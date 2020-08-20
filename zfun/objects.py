from abc import ABC, abstractmethod
from typing import NamedTuple, Union, Tuple, Dict, Set, List, Type

from .header import ZCodeHeader, get_header
from .z_string import z_string_to_str, z_string_to_str_with_next
from .util import is_bit_set, set_bit
from .exc import ZMachineIllegalOperation, ZMachineException
from .data_structures import ZData, ZWord, ZByte


class EndOfProperties(ZMachineException):
    pass


class ObjectProperty(ABC):

    def __init__(self, memory: memoryview, address: int):
        """
        :param memory:
        :param address: Address of the property's length header (not value)
        """
        if memory[address] == 0:
            raise EndOfProperties()

        self._memory = memory
        self._address = address

    def set(self, value: ZData):
        """ Set the value of this property.

        :param value:
        """
        if self.size == 2 and type(value) == ZByte:
            value = value.pad(is_signed=True)
        elif self.size == 1 and type(value) == ZWord:
            value = ZByte.from_int(value.integer)
        elif self.size != len(value):
            raise ZMachineIllegalOperation(f'Can not set a property value of size {self.size} with a value of size {len(value)}')

        value.write(self._memory, self.value_address)

    @property
    @abstractmethod
    def number(self) -> int:
        """ This property's number """
        pass

    @property
    @abstractmethod
    def num_size_bytes(self) -> int:
        """ The number of bytes which indicate the size of the property """
        pass

    @property
    def value_address(self) -> int:
        """ Address of the property's value. """
        return self._address + self.num_size_bytes

    @property
    @abstractmethod
    def size(self) -> int:
        """ Size of this property, in bytes. """
        pass

    @property
    def next_property_address(self) -> int:
        """ Address of the next property. """
        return self._address + self.num_size_bytes + self.size

    @property
    def value(self) -> Union[ZData, bytes]:
        """ Value of this property.

        :return: A ZWord or ZByte if the size if 1 or 2, or a bytes string if longer
        """
        if self.size == 1:
            return ZByte(self._memory, self.value_address)
        elif self.size == 2:
            return ZWord(self._memory, self.value_address)
        else:
            return bytes(self._memory[self.value_address:self.value_address + self.size])


class ObjectPropertyV1(ObjectProperty):

    def __init__(self, memory: memoryview, address: int):
        super().__init__(memory, address)
        self._size = (memory[address] >> 5) + 1
        self._number = (memory[address] & 0x1f)

    @property
    def number(self) -> int:
        return self._number

    @property
    def num_size_bytes(self) -> int:
        return 1

    @property
    def size(self) -> int:
        return self._size


class ObjectPropertyV4(ObjectProperty):

    def __init__(self, memory: memoryview, address: int):
        super().__init__(memory, address)

        if is_bit_set(memory, address, 7):
            # If the top bit is set then there is two size bytes
            self._num_size_bytes = 2
        else:
            # If the top bit is clear then there is one size byte (like V1 object properties)
            self._num_size_bytes = 1

        if self._num_size_bytes == 2:
            self._size = memory[address + 1] & 0x3f

            if self._size == 0:
                self._size = 64
        else:
            # If bit 6 of the size byte is clear then the size is 2
            if is_bit_set(memory, address, 6):
                self._size = 2
            # If it's set then the size is 1
            else:
                self._size = 1

        self._number = memory[address] & 0x3f

    @property
    def number(self) -> int:
        return self._number

    @property
    def num_size_bytes(self) -> int:
        return self._num_size_bytes

    @property
    def size(self) -> int:
        return self._size


class ObjectPropertiesIterator:

    def __init__(self, memory: memoryview, first_prop_address: int, property_type: Type[ObjectProperty]):
        self._memory = memory
        self._first_prop_addr = first_prop_address
        self._type = property_type
        self._cur_prop_addr = first_prop_address

    def __next__(self) -> ObjectProperty:
        try:
            prop = self._type(self._memory, self._cur_prop_addr)
            self._cur_prop_addr = prop.next_property_address
            return prop
        except EndOfProperties:
            self._cur_prop_addr = None
            raise StopIteration()


class ObjectProperties(ABC):

    def __init__(self, memory: memoryview, first_prop_address: int):
        header = get_header(memory)
        self._version = header.version
        self._default_vals_addr = header.object_table_address
        self._memory = memory
        self._first_prop_addr = first_prop_address

        if header.version <= 3:
            self._property_type = ObjectPropertyV1
        else:
            self._property_type = ObjectPropertyV4

    def __iter__(self) -> ObjectPropertiesIterator:
        return ObjectPropertiesIterator(self._memory, self._first_prop_addr, self._property_type)

    def all(self) -> Dict[int, Union[ZData, bytes]]:
        all_props = dict()
        for prop in self:
            all_props[prop.number] = prop.value

        return all_props

    def first_property(self) -> ObjectProperty:
        if self._version <= 3:
            return ObjectPropertyV1(self._memory, self._first_prop_addr)
        else:
            return ObjectPropertyV4(self._memory, self._first_prop_addr)

    def get(self, prop_num: int) -> Union[None, ObjectProperty]:
        """ Get the object property with the given number.

        If the property does not exist on this object, return None.

        :param prop_num:
        :return:
        """
        for prop in self:
            if prop.number == prop_num:
                return prop

        return None

    def set(self, prop_num: int, value: ZData):
        """ Set the value of the property number on this object.

        :param prop_num:
        :param value:
        :return:
        """
        prop = self.get(prop_num)

        if prop is None:
            raise ZMachineIllegalOperation('attempting to set value of non-existent property')

        prop.set(value)

    def value(self, prop_num: int) -> Union[None, ZData, bytes]:
        """ Get the value of the given property number

        :param prop_num:
        :return: Value of property, or None if the value doesn't exist
        """
        prop = self.get(prop_num)
        return prop.value if prop is not None else None

    def value_or_default(self, prop_num: int) -> Union[ZData, bytes]:
        """ Get the value of the given property number, or the default value.

        If this object doesn't have the property on it, return the value of the default.

        :param prop_num:
        :return:
        """
        prop = self.get(prop_num)

        if prop is not None:
            return prop.value
        else:
            return self.default_value(prop_num)

    def default_value(self, prop_num: int) -> ZData:
        if self._version <= 3:
            assert 0 <= prop_num <= 31, 'version 1-3 property numbers range from 0-31'
        else:
            assert 0 <= prop_num <= 63, 'version 4+ property numbers range from 0-63'

        return ZWord(self._memory, self._default_vals_addr + (2 * (prop_num - 1)))


class PropertiesTable(ABC):

    class PropertyData(NamedTuple):
        address: int
        size: int
        number: int
        value: Union[ZData, bytes]
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

    def property_val(self, prop_num: int) -> Union[ZData, bytes]:
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

    def _own_property_address(self, prop_num: int) -> Union[None, int]:
        """ Get the address of the property on this object.

        :param prop_num:
        :return: Address of prop_num or None if not found.
        """
        next_prop_offset = self._properties_address
        while True:
            prop = self._property_data_at(self._memory, next_prop_offset)

            if prop is None:
                return None
            elif prop.number == prop_num:
                return next_prop_offset
            else:
                next_prop_offset = prop.next_prop_address

    def _first_property_data(self) -> Union[None, PropertyData]:
        """ Get the first property (in memory) set on this object.

        :return:
        """
        return self._property_data_at(self._memory, self._properties_address)

    def own_property_data(self, prop_num: int) -> Union[None, PropertyData]:
        """ Get property info for a property explicitly set on this object.

        :param prop_num:
        :return:
        """
        property_addr = self._own_property_address(prop_num)

        if property_addr is not None:
            return self._property_data_at(self._memory, property_addr)
        else:
            return None

    def own_property_val(self, prop_num: int) -> Union[None, ZData, bytes]:
        """ Get the value of the property explicitly set on this object.

        If the property is not set, None is returned.

        :param prop_num:
        :return:
        """
        prop_info = self.own_property_data(prop_num)

        if prop_info is not None:
            return prop_info.value
        else:
            return None

    @abstractmethod
    def property_value_address(self, property_address: int) -> int:
        """ Get the address of a property's value

        :param property_address: Address of the property
        :return: Address of the property's value
        """
        pass

    def set_own_property(self, prop_num: int, value: ZData):
        """ Set the value of a property on this object.

        :param prop_num: Property number to set
        :param value: Value to set
        """
        prop_info = self.own_property_data(prop_num)

        if prop_info is None:
            raise ZMachineIllegalOperation(f'Property number {prop_num} not found on this object')

        value_address = self.property_value_address(prop_info.address)

        if (prop_info.size == 1) and (len(value) == 2):
            byte_val = ZByte.from_int(value.integer)
            byte_val.write(self._memory, value_address)
        elif (prop_info.size == 2) and (type(value) == ZByte):
            word_val = value.pad(is_signed=True)
            word_val.write(self._memory, value_address)
        elif prop_info.size == len(value):
            value.write(self._memory, value_address)
        else:
            raise ZMachineIllegalOperation(f'Can not set a property value of size {prop_info.size} with a value of size {len(value)}')

    @property
    def own_properties(self) -> Dict[int, Union[ZData, bytes]]:
        """ Get a dict of the properties explicitly set on the object.

        :return: A dict of property numbers -> values
        """
        props = dict()

        next_prop_offset = self._properties_address
        while True:
            prop = self._property_data_at(self._memory, next_prop_offset)

            if prop is None:
                return props
            else:
                props[prop.number] = prop.value
                next_prop_offset = prop.next_prop_address

    @abstractmethod
    def default_val(self, prop_num: int) -> ZWord:
        """ Get the default value of the provided property number.

        :param prop_num:
        :return: Default value of prop_num
        """
        # each default is a word so the offset is 2 * prop_num
        address = self._default_properties_address + ((prop_num-1) * 2)
        return ZWord(self._memory, address)

    @staticmethod
    @abstractmethod
    def _property_data_at(memory: memoryview, address: int) -> Union[None, PropertyData]:
        """ Get property at the given address from the provided memory.

        If the address points to the end of the property list then None is returned.

        :param memory: Memory to get property from
        :param address: Address of the object property
        :return:
        """
        pass


class ZMachineObject(ABC):

    def __init__(self, memory: memoryview, header: ZCodeHeader, obj_addr: int):
        self._memory = memory
        self._header = header
        self._addr = obj_addr
        name_size = memory[self.properties_table_address] * 2
        first_prop_addr = self.properties_table_address + 1 + name_size
        self._properties = ObjectProperties(memory, first_prop_addr)

    @staticmethod
    def _attr_byte_and_bit(attr_num: int) -> Tuple[int, int]:
        byte_num = attr_num // 8
        bit_num = 7 - attr_num % 8
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
    def properties(self) -> ObjectProperties:
        """
        :return: Object properties
        """
        return self._properties

    @property
    @abstractmethod
    def properties_table_address(self) -> int:
        """
        :return: Address of this object's properties table
        """
        pass

    @property
    def name(self) -> Union[str, None]:
        """
        :return: The name of the object, or None if no name is set.
        """
        # The first byte contains the length of the name string
        str_len = self._memory[self.properties_table_address] * 2

        if str_len > 0:
            name, next_addr = z_string_to_str_with_next(self._memory, self.properties_table_address + 1, self._header.abbreviations_table_address)
            return name
        else:
            return None


class ZMachineObjectV1(ZMachineObject):

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
        ZByte.from_unsigned_int(obj_num).write(self._memory, self._addr + 4)

    @property
    def sibling(self) -> int:
        return self._memory[self._addr + 5]

    @sibling.setter
    def sibling(self, obj_num: int):
        ZByte.from_unsigned_int(obj_num).write(self._memory, self._addr + 5)

    @property
    def child(self) -> int:
        return self._memory[self._addr + 6]

    @child.setter
    def child(self, obj_num: int):
        ZByte.from_unsigned_int(obj_num).write(self._memory, self._addr + 6)

    @property
    def properties_table_address(self) -> int:
        return ZWord(self._memory, self._addr + 7).unsigned_int


class ZMachineObjectV4(ZMachineObject):

    def is_attribute_set(self, attr_num: int) -> bool:
        assert attr_num <= 47
        return super().is_attribute_set(attr_num)

    def update_attribute(self, attr_num: int, is_set: bool):
        assert attr_num <= 47
        return super().update_attribute(attr_num, is_set)

    @property
    def parent(self) -> int:
        return ZWord(self._memory, self._addr + 6).unsigned_int

    @parent.setter
    def parent(self, obj_num: int):
        ZWord.from_unsigned_int(obj_num).write(self._memory, self._addr + 6)

    @property
    def sibling(self) -> int:
        return ZWord(self._memory, self._addr + 8).unsigned_int

    @sibling.setter
    def sibling(self, obj_num: int):
        ZWord.from_unsigned_int(obj_num).write(self._memory, self._addr + 8)

    @property
    def child(self) -> int:
        return ZWord(self._memory, self._addr + 10).unsigned_int

    @child.setter
    def child(self, obj_num: int):
        ZWord.from_unsigned_int(obj_num).write(self._memory, self._addr + 10)

    @property
    def attributes(self) -> Set[int]:
        set_attrs = set()

        for i in range(48):
            if self.is_attribute_set(i):
                set_attrs.add(i)

        return set_attrs

    @property
    def properties_table_address(self) -> int:
        return ZWord(self._memory, self._addr + 12).unsigned_int


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
        obj.parent = parent_obj_num
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

    def property_at(self, address: int) -> ObjectProperty:
        """ Get an object property at the provided address.

        :param address: Address of object property
        :return: Property data
        """
        if self._header.version <= 3:
            return ObjectPropertyV1(self._memory, address)
        else:
            return ObjectPropertyV4(self._memory, address)

