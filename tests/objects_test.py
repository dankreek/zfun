import pytest

from zfun import get_header, ZMachineObjectTable


@pytest.fixture
def zork_v3_obj_table(zork1_v3_data: memoryview) -> ZMachineObjectTable:
    header = get_header(zork1_v3_data)
    yield ZMachineObjectTable(zork1_v3_data, header)


@pytest.fixture
def zork_v5_obj_table(zork1_v5_data: memoryview) -> ZMachineObjectTable:
    header = get_header(zork1_v5_data)
    yield ZMachineObjectTable(zork1_v5_data, header)


def test_attributes_v3(zork_v3_obj_table: ZMachineObjectTable):
    cretin = zork_v3_obj_table.object(4)
    assert cretin.attributes == {0, 9, 14, 25}

    cretin.update_attribute(0, False)
    cretin.update_attribute(9, False)
    cretin.update_attribute(14, False)
    cretin.update_attribute(25, False)
    assert cretin.attributes == set()

    # Flip each attribute individually
    for i in range(32):
        cretin.update_attribute(i, True)
        assert cretin.attributes == {i}, f'attribute {i} should be set in the attributes set'
        assert cretin.is_attribute_set(i) == True, f'attribute {i} should be set'

        cretin.update_attribute(i, False)
        assert cretin.attributes == set(), f'attribute {i} should be set in the attributes set'
        assert cretin.is_attribute_set(i) == False, f'attribute {i} should be set'

    # Gotta' set 'em all
    for i in range(32):
        cretin.update_attribute(i, True)

    assert cretin.attributes == set(range(32))


def test_attributes_v5(zork_v5_obj_table: ZMachineObjectTable):
    cretin = zork_v5_obj_table.object(46)
    assert cretin.attributes == {16, 24, 30, 41}

    cretin.update_attribute(16, False)
    cretin.update_attribute(24, False)
    cretin.update_attribute(30, False)
    cretin.update_attribute(41, False)
    assert cretin.attributes == set()

    # Flip each attribute individually
    for i in range(48):
        cretin.update_attribute(i, True)
        assert cretin.attributes == {i}, f'attribute {i} should be set in the attributes set'
        assert cretin.is_attribute_set(i) == True, f'attribute {i} should be set'

        cretin.update_attribute(i, False)
        assert cretin.attributes == set(), f'attribute {i} should be set in the attributes set'
        assert cretin.is_attribute_set(i) == False, f'attribute {i} should be set'

    # Gotta' set 'em all
    for i in range(48):
        cretin.update_attribute(i, True)

    assert cretin.attributes == set(range(48))


def test_tree_v3(zork_v3_obj_table: ZMachineObjectTable):
    west_of_house = zork_v3_obj_table.object(180)
    # XXX: finish object tree tests
    assert west_of_house.parent == 82
    assert west_of_house.child == 181
    assert west_of_house.sibling == 15


def test_tree_v5(zork_v5_obj_table: ZMachineObjectTable):
    pass


prop_name_v3_cases = [(4, 'cretin'), (82, None), (180, 'West of House')]

@pytest.mark.parametrize('obj_num,expected_name', prop_name_v3_cases)
def test_object_name_prop_v3(obj_num: int, expected_name: str, zork_v3_obj_table: ZMachineObjectTable):
    assert zork_v3_obj_table.object(obj_num).properties.name == expected_name


prop_name_v5_cases = [(46, 'cretin'), (41, None), (68, 'West of House')]

@pytest.mark.parametrize('obj_num,expected_name', prop_name_v5_cases)
def test_object_name_prop_v5(obj_num: int, expected_name: str, zork_v5_obj_table: ZMachineObjectTable):
    assert zork_v5_obj_table.object(obj_num).properties.name == expected_name


def test_first_own_property_v3(zork_v3_obj_table: ZMachineObjectTable):
    door = zork_v3_obj_table.object(18)
    first_prop = door.properties.first_own_property()
    assert first_prop.number == 31


def test_own_properties_v3(zork_v3_obj_table: ZMachineObjectTable):
    door = zork_v3_obj_table.object(181)

    # Get own properties
    own_properties = door.properties.own_properties
    assert 18 in own_properties
    assert own_properties[18].hex() == '3f9d'

    assert 17 in own_properties
    assert own_properties[17].hex() == '6d57'

    assert 16 in own_properties
    assert own_properties[16].hex() == 'c9ca'

    assert own_properties[18] == door.properties.own_property_val(18)
    assert own_properties[17] == door.properties.own_property_val(17)
    assert own_properties[16] == door.properties.own_property_val(16)

    assert own_properties[18] == door.properties.property_val(18)
    assert own_properties[17] == door.properties.property_val(17)
    assert own_properties[16] == door.properties.property_val(16)


def test_default_properties_v3(zork_v3_obj_table: ZMachineObjectTable):
    door = zork_v3_obj_table.object(181)

    # Get default properties and spot check
    default_1 = door.properties.default_val(1)
    default_31 = door.properties.default_val(31)

    # ensure default falls through if own property isn't defined
    assert default_1 == door.properties.property_val(1), 'default property 1 should have been returned'
    assert default_31 == door.properties.property_val(31), 'default property 31 should have been returned'


def test_own_properties_v5(zork_v5_obj_table: ZMachineObjectTable):
    door = zork_v5_obj_table.object(127)

    # Get own properties
    own_properties = door.properties.own_properties
    assert 46 in own_properties
    assert own_properties[46].hex() == '4dff'

    assert 45 in own_properties
    assert own_properties[45].hex() == '3e24'

    assert 44 in own_properties
    assert own_properties[44].hex() == '50364a60'

    assert own_properties[46] == door.properties.own_property_val(46)
    assert own_properties[45] == door.properties.own_property_val(45)
    assert own_properties[44] == door.properties.own_property_val(44)

    assert own_properties[46] == door.properties.property_val(46)
    assert own_properties[45] == door.properties.property_val(45)
    assert own_properties[44] == door.properties.property_val(44)


def test_default_properties_v5(zork_v5_obj_table: ZMachineObjectTable):
    door = zork_v5_obj_table.object(127)

    # Get default properties and spot check
    default_1 = door.properties.default_val(1)
    default_63 = door.properties.default_val(63)

    # ensure default falls through if own property isn't defined
    assert default_1 == door.properties.property_val(1), 'default property 1 should have been returned'
    assert default_63 == door.properties.property_val(63), 'default property 63 should have been returned'


def test_remove_obj_from_parent_first_child_v3(zork_v3_obj_table: ZMachineObjectTable):
    zork_v3_obj_table.remove_obj_from_parent(181)
    west_of_house_tree = zork_v3_obj_table.obj_tree(180)

    assert len(west_of_house_tree['children']) == 1
    assert west_of_house_tree['children'][0]['number'] == 160

    door_obj = zork_v3_obj_table.object(181)
    assert door_obj.parent == 0, 'object should no longer have a parent'
    assert door_obj.sibling == 0, 'object should no longer have a sibling'


def test_remove_obj_from_parent_first_child_v5(zork_v5_obj_table: ZMachineObjectTable):
    zork_v5_obj_table.remove_obj_from_parent(239)
    west_of_house_tree = zork_v5_obj_table.obj_tree(68)

    assert len(west_of_house_tree['children']) == 1
    assert west_of_house_tree['children'][0]['number'] == 127

    small_mailbox_obj = zork_v5_obj_table.object(239)
    assert small_mailbox_obj.parent == 0, 'object should no longer have a parent'
    assert small_mailbox_obj.sibling == 0, 'object should no longer have a sibling'


def test_remove_obj_from_parent_middle_child_v3(zork_v3_obj_table: ZMachineObjectTable):
    zork_v3_obj_table.remove_obj_from_parent(91)
    maintenance_room_tree = zork_v3_obj_table.obj_tree(199)

    assert len(maintenance_room_tree['children']) == 8
    assert maintenance_room_tree['children'][0]['number'] == 200
    assert maintenance_room_tree['children'][1]['number'] == 99

    wrench_obj = zork_v3_obj_table.object(91)
    assert wrench_obj.parent == 0
    assert wrench_obj.sibling == 0


def test_remove_obj_from_parent_middle_child_v5(zork_v5_obj_table: ZMachineObjectTable):
    zork_v5_obj_table.remove_obj_from_parent(203)
    maintenance_room_tree = zork_v5_obj_table.obj_tree(233)

    assert len(maintenance_room_tree['children']) == 8
    assert maintenance_room_tree['children'][0]['number'] == 245
    assert maintenance_room_tree['children'][1]['number'] == 120

    tube_obj = zork_v5_obj_table.object(203)
    assert tube_obj.parent == 0
    assert tube_obj.sibling == 0


def test_remove_obj_from_parent_last_child_v3(zork_v3_obj_table: ZMachineObjectTable):
    zork_v3_obj_table.remove_obj_from_parent(160)
    west_of_house_tree = zork_v3_obj_table.obj_tree(180)

    assert len(west_of_house_tree['children']) == 1
    assert west_of_house_tree['children'][0]['number'] == 181

    small_mailbox_obj = zork_v3_obj_table.object(160)
    assert small_mailbox_obj.parent == 0
    assert small_mailbox_obj.sibling == 0


def test_remove_obj_from_parent_last_child_v5(zork_v5_obj_table: ZMachineObjectTable):
    zork_v5_obj_table.remove_obj_from_parent(127)
    west_of_house_tree = zork_v5_obj_table.obj_tree(68)

    assert len(west_of_house_tree['children']) == 1
    assert west_of_house_tree['children'][0]['number'] == 239

    door_obj = zork_v5_obj_table.object(127)
    assert door_obj.parent == 0
    assert door_obj.sibling == 0


def test_insert_child_without_parent_v3(zork_v3_obj_table: ZMachineObjectTable):
    zork_v3_obj_table.insert_child(4, 180)

    west_of_house_tree = zork_v3_obj_table.obj_tree(180)
    assert len(west_of_house_tree['children']) == 3
    assert west_of_house_tree['children'][0]['number'] == 4


def test_insert_child_without_parent_v5(zork_v5_obj_table: ZMachineObjectTable):
    zork_v5_obj_table.insert_child(46, 68)

    west_of_house_tree = zork_v5_obj_table.obj_tree(68)
    assert len(west_of_house_tree['children']) == 3
    assert west_of_house_tree['children'][0]['number'] == 46


def test_insert_child_with_parent_v3(zork_v3_obj_table: ZMachineObjectTable):
    # Take machine out of Machine room and put in West of House
    zork_v3_obj_table.insert_child(158, 180)

    west_of_house_tree = zork_v3_obj_table.obj_tree(180)
    assert len(west_of_house_tree['children']) == 3
    assert west_of_house_tree['children'][0]['number'] == 158

    machine_room_tree = zork_v3_obj_table.obj_tree(157)
    assert len(machine_room_tree['children']) == 1
    assert machine_room_tree['children'][0]['number'] == 112


def test_insert_child_with_parent_v5(zork_v5_obj_table: ZMachineObjectTable):
    # Take machine out of Machine room and put in West of House
    zork_v5_obj_table.insert_child(215, 68)

    west_of_house_tree = zork_v5_obj_table.obj_tree(68)
    assert len(west_of_house_tree['children']) == 3
    assert west_of_house_tree['children'][0]['number'] == 215

    machine_room_tree = zork_v5_obj_table.obj_tree(93)
    assert len(machine_room_tree['children']) == 1
    assert machine_room_tree['children'][0]['number'] == 105


