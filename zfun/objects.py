from abc import ABC, abstractmethod
from typing import NamedTuple, Union, Tuple, Dict, Set, List

from .header import ZCodeHeader
from .z_string import z_string_to_str
from .util import read_word, is_bit_set, set_bit, write_word

# Z-Machine Object
# -----------------
# - attributes (flags in a bitfield)
# - properties (numbers of variable length)
# - parent
# - sibling
# - child


class PropertiesTable(ABC):

    class PropertyData(NamedTuple):
        size: int
        number: int
        value: Union[bytes, memoryview]
        next_prop_address: int

    def __init__(self, memory: memoryview, header: ZCodeHeader, table_addr: int):
        self._memory = memory
        self._addr = table_addr
        self._header = header
        self._default_properties_address = header.object_table_address

        # Properties start after the name, the length of which is the value of the first byte * 2 (number of words)
        self._properties_address = table_addr + 1 + (memory[table_addr] * 2)

    @property
    def name(self) -> Union[str, None]:
        """
        :return: The name of the object, or None if no name is set.
        """
        # The first byte contains the length of the name string
        str_len = self._memory[self._addr]

        if str_len > 0:
            return z_string_to_str(self._memory, self._addr + 1, self._header.abbreviations_table_address)
        else:
            return None

    def property_val(self, prop_num: int) -> Union[bytes, memoryview]:
        """ Get the value of the property number.

        If the property isn't defined on the object then the default value is returned.

        :param prop_num:
        :return:
        """
        own_val = self.own_property_val(prop_num)

        if own_val is None:
            return self.default_val(prop_num)
        else:
            return own_val

    def own_property_address(self, prop_num: int) -> Union[None, int]:
        """ Get the address of the property on this object.

        :param prop_num:
        :return: Address of prop_num or None if not found.
        """
        next_prop_offset = self._properties_address
        while True:
            prop = self.property_at(self._memory, next_prop_offset)

            if prop is None:
                return None
            elif prop.number == prop_num:
                return next_prop_offset
            else:
                next_prop_offset = prop.next_prop_address

    def first_own_property(self) -> Union[None, PropertyData]:
        """ Get the first property (in memory) set on this object.

        :return:
        """
        return self.property_at(self._memory, self._properties_address)

    def own_property(self, prop_num: int) -> Union[None, PropertyData]:
        """ Get property info for a property explicitly set on this object.

        :param prop_num:
        :return:
        """
        property_addr = self.own_property_address(prop_num)

        if property_addr is not None:
            return self.property_at(self._memory, property_addr)
        else:
            return None

    def own_property_val(self, prop_num: int) -> Union[None, bytes, memoryview]:
        """ Get the value of the property explicitly set on this object.

        If the property is not set, None is returned.

        :param prop_num:
        :return:
        """
        prop_info = self.own_property(prop_num)

        if prop_info is not None:
            return prop_info.value
        else:
            return None

    @property
    def own_properties(self) -> Dict[int, Union[bytes, memoryview]]:
        """ Get a dict of the properties explicitly set on the object.

        :return: A dict of property numbers -> values
        """
        props = dict()

        next_prop_offset = self._properties_address
        while True:
            prop = self.property_at(self._memory, next_prop_offset)

            if prop is None:
                return props
            else:
                props[prop.number] = prop.value
                next_prop_offset = prop.next_prop_address

    @abstractmethod
    def default_val(self, prop_num: int) -> Union[bytes, memoryview]:
        """ Get the default value of the provided property number.

        :param prop_num:
        :return: Default value of prop_num
        """
        # each default is a word so the offset is 2 * prop_num
        offset = self._default_properties_address + (prop_num * 2)
        return self._memory[offset:offset+2]

    @staticmethod
    @abstractmethod
    def property_at(memory: memoryview, address: int) -> Union[None, PropertyData]:
        """ Get property at the given address from the provided memory.

        If the address points to the end of the property list then None is returned.

        :param memory: Memory to get property from
        :param address: Address of the object property
        :return:
        """
        pass


class PropertiesTableV1(PropertiesTable):

    @staticmethod
    def property_at(memory: memoryview, address: int) -> Union[None, PropertiesTable.PropertyData]:
        # A size/num byte equal to 0 indicates the end of the property list
        if memory[address] == 0:
            return None
        else:
            size = (memory[address] >> 5) + 1
            number = (memory[address] & 0x1f)
            next_prop_offset = address + 1 + size
            val = memory[address + 1:next_prop_offset]

            return PropertiesTable.PropertyData(size, number, val, next_prop_offset)

    def default_val(self, prop_num: int) -> Union[bytes, memoryview]:
        assert 0 <= prop_num <= 31, f'prop_num out of range for version {self._header.version}'
        return super().default_val(prop_num)


class PropertiesTableV4(PropertiesTable):

    @staticmethod
    def property_at(memory: memoryview, address: int) -> Union[None, PropertiesTable.PropertyData]:
        if memory[address] == 0:
            return None
        else:
            # If the top bit is clear then there is one size byte
            if (memory[address] & 0x80) == 0:
                size_bytes = 1

                # XXX: Make be able to just use the V1 algorithm for this
                # If bit 6 of the size byte is clear then the size is 1
                if memory[address] & 0x20 == 0:
                    size = 1
                # If it's set then the size is 2
                else:
                    size = 2
            # If the top bit is set then there is two size bytes
            else:
                size_bytes = 2
                size = memory[address + 1] & 0x3f

                if size == 0:
                    size = 64

            next_prop_offset = address + size_bytes + size
            number = memory[address] & 0x3f
            val = memory[address + size_bytes:next_prop_offset]

            return PropertiesTable.PropertyData(size, number, val, next_prop_offset)

    def default_val(self, prop_num: int) -> Union[bytes, memoryview]:
        assert 0 <= prop_num <= 63, f'prop_num out of range for version {self._header.version}'
        return super().default_val(prop_num)


class ZMachineObject(ABC):

    def __init__(self, memory: memoryview, header: ZCodeHeader, obj_addr: int):
        self._memory = memory
        self._header = header
        self._addr = obj_addr

    @staticmethod
    def _attr_byte_and_bit(attr_num: int) -> Tuple[int, int]:
        byte_num = int(attr_num/8)
        bit_num = attr_num % 8
        return byte_num, bit_num

    @abstractmethod
    def is_attribute_set(self, attr_num: int) -> bool:
        """ Is the attribute number on this object set?

        :param attr_num:
        :return: True if set, False if not
        """
        byte_num, bit_num = ZMachineObject._attr_byte_and_bit(attr_num)
        return is_bit_set(self._memory, self._addr + byte_num, bit_num)

    @abstractmethod
    def update_attribute(self, attr_num: int, is_set: bool):
        """ Set or clear the attribute number

        :param attr_num:
        :param is_set:
        """
        byte_num, bit_num = ZMachineObject._attr_byte_and_bit(attr_num)
        set_bit(self._memory, self._addr + byte_num, bit_num, is_set)

    @property
    @abstractmethod
    def parent(self) -> int:
        """ Parent object number """
        pass

    @parent.setter
    @abstractmethod
    def parent(self, obj_num: int) -> int:
        """ Set parent object number """
        pass

    @property
    @abstractmethod
    def sibling(self) -> int:
        """ Next sibling object number """
        pass

    @sibling.setter
    @abstractmethod
    def sibling(self, obj_num: int) -> int:
        """ Set sibling object number """
        pass

    @property
    @abstractmethod
    def child(self) -> int:
        """ Child object number """
        pass

    @child.setter
    @abstractmethod
    def child(self, obj_num: int) -> int:
        """ Set child object number """
        pass

    @property
    @abstractmethod
    def attributes(self) -> Set[int]:
        """ The set of all set attributes """
        pass

    @property
    @abstractmethod
    def properties(self) -> PropertiesTable:
        """
        :return: Object properties table
        """
        pass


class ZMachineObjectV1(ZMachineObject):

    def __init__(self, memory: memoryview, header: ZCodeHeader, obj_addr: int):
        super().__init__(memory, header, obj_addr)

        # The properties table lies after the 4 bytes of flags and 3 bytes of parent, sibling and child objects
        props_addr = read_word(memory, obj_addr + 7)
        self._properties = PropertiesTableV1(memory, header, props_addr)

    def is_attribute_set(self, attr_num: int) -> bool:
        assert attr_num <= 31
        return super().is_attribute_set(attr_num)

    def update_attribute(self, attr_num: int, is_set: bool):
        assert attr_num <= 31
        return super().update_attribute(attr_num, is_set)

    @property
    def attributes(self) -> Set[int]:
        """ The set of all set attributes """
        set_attrs = set()

        for i in range(32):
            if self.is_attribute_set(i):
                set_attrs.add(i)

        return set_attrs

    @property
    def parent(self) -> int:
        return self._memory[self._addr + 4]

    @parent.setter
    def parent(self, obj_num: int):
        self._memory[self._addr + 4] = obj_num

    @property
    def sibling(self) -> int:
        return self._memory[self._addr + 5]

    @sibling.setter
    def sibling(self, obj_num: int):
        self._memory[self._addr + 5] = obj_num

    @property
    def child(self) -> int:
        return self._memory[self._addr + 6]

    @child.setter
    def child(self, obj_num: int):
        self._memory[self._addr + 6] = obj_num

    @property
    def properties(self) -> PropertiesTable:
        return self._properties


class ZMachineObjectV4(ZMachineObject):

    def __init__(self, memory: memoryview, header: ZCodeHeader, obj_addr: int):
        super().__init__(memory, header, obj_addr)

        # The properties table lies after the 6 bytes of flags and 3 words of parent, sibling and child objects
        props_addr = read_word(memory, obj_addr + 12)
        self._properties = PropertiesTableV4(memory, header, props_addr)

    def is_attribute_set(self, attr_num: int) -> bool:
        assert attr_num <= 47
        return super().is_attribute_set(attr_num)

    def update_attribute(self, attr_num: int, is_set: bool):
        assert attr_num <= 47
        return super().update_attribute(attr_num, is_set)

    @property
    def parent(self) -> int:
        return read_word(self._memory, self._addr + 6)

    @parent.setter
    def parent(self, obj_num: int):
        write_word(self._memory, self._addr + 6, obj_num)

    @property
    def sibling(self) -> int:
        return read_word(self._memory, self._addr + 8)

    @sibling.setter
    def sibling(self, obj_num: int):
        write_word(self._memory, self._addr + 8, obj_num)

    @property
    def child(self) -> int:
        return read_word(self._memory, self._addr + 10)

    @child.setter
    def child(self, obj_num: int):
        write_word(self._memory, self._addr + 10, obj_num)

    @property
    def properties(self) -> PropertiesTable:
        return self._properties

    @property
    def attributes(self) -> Set[int]:
        set_attrs = set()

        for i in range(48):
            if self.is_attribute_set(i):
                set_attrs.add(i)

        return set_attrs


class ZMachineObjectTable(ABC):

    def __init__(self, memory: memoryview, header: ZCodeHeader):
        self._memory = memory
        self._addr = header.object_table_address
        self._version = header.version
        self._header = header

    def object(self, obj_num: int) -> ZMachineObject:
        assert obj_num > 0, 'object number must be greater than 0'
        if self._version <= 3:
            assert obj_num <= 255, f'obj #{obj_num} is out of range for this version'
            # There are 31 words of defaults in version 1-3
            obj_tree_base = self._addr + (31 * 2)
            obj_desc_size = 9
            obj_class = ZMachineObjectV1
        else:
            assert obj_num <= 65535, f'obj #{obj_num} is out of range for this version'
            # There are 63 words of defaults in version 4-6
            obj_tree_base = self._addr + (63 * 2)
            obj_desc_size = 14
            obj_class = ZMachineObjectV4

        return obj_class(self._memory, self._header, obj_tree_base + (obj_desc_size * (obj_num - 1)))

    def remove_obj_from_parent(self, obj_num: int):
        """ Remove the object from its parent while retaining the object's children.

        :param obj_num:
        """
        # See remove_obj opcode
        obj = self.object(obj_num)

        if obj.parent == 0:
            return

        parent = self.object(obj.parent)

        if parent.child == obj_num:
            parent.child = obj.sibling
        else:
            prev_sibling = self.object(parent.child)
            child = self.object(prev_sibling.sibling)
            while prev_sibling.sibling != obj_num:
                prev_sibling = child
                child = self.object(child.sibling)

            prev_sibling.sibling = obj.sibling

        obj.parent = 0
        obj.sibling = 0

    def insert_child(self, obj_num: int, parent_obj_num: int):
        # See insert_obj opcode
        self.remove_obj_from_parent(obj_num)

        parent = self.object(parent_obj_num)
        obj = self.object(obj_num)

        obj.sibling = parent.child
        parent.child = obj_num

    def obj_tree(self, obj_num: int) -> Dict[str, Union[ZMachineObject, List[ZMachineObject]]]:
        """ Get the object and all of its descendants as a dict.

        The form will be a next dict in the following form:

        ```python
        {
            'number': Object number
            'object': The object itself
            'children': List of children
        }
        ```

        :param obj_num:
        :return: Object tree
        """
        children = []
        obj = self.object(obj_num)
        if obj.child != 0:
            children.append(self.obj_tree(obj.child))

            sibling_obj_num = self.object(obj.child).sibling
            while sibling_obj_num != 0:
                sibling = self.object(sibling_obj_num)
                children.append(self.obj_tree(sibling_obj_num))
                sibling_obj_num = sibling.sibling
                
        return dict(number=obj_num, object=obj, children=children)

    def property_at(self, address: int) -> PropertiesTable.PropertyData:
        """ Get an object property at the provided address.

        :param address: Address of object property
        :return: Property data
        """
        if self._header.version <= 3:
            return PropertiesTableV1.property_at(self._memory, address)
        else:
            return PropertiesTableV4.property_at(self._memory, address)
