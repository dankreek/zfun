import json
import pytest
from os import path

from typing import Tuple

from mocks import MockInput, MockScreen
from zfun import ZCodeHeader, ZMachineInterpreter, ZMachineInterpreterV3, get_header, ZMachineVariables, ZMachineObjectTable, ZMachineStack, ZMachineExitException


def compare_machine_state(interpreter: ZMachineInterpreter, state_data_dir: str, num_objects: int = 250) -> dict:
    """ Compare the state of the interpreter with state saved on disk.

    The files on disk should have the filenames of:
    * "mem-{step_num}" : binary file containing all of a Z-Machine's memory
    * "state-{step_num}.json" : JSON file containing machine state external to the memory in the following format,
                                note that all values are hexadecimal strings, not ints, and only the current routine
                                stack frame is accounted.
    ```json
    {
      "pc": "0x5479",                      # Program counter
      "local_vars": ["0x8010", "0xffff"],  # Local variables, in oder from 0-n
      "stack": [],                         # Routine stack
      "ret_var": "0x0",                    # Variable number to return value to
      "ret_pc": "0x4f0e"                   : PC to return to after routine exits
    }
    ```

    :param interpreter: Interpreter to compare the state to
    :param state_data_dir: Directory where state data can be found
    :param num_objects: Number of objects to scan
    :return: Differences in state on disk and interpreter
    """
    with open(path.join(state_data_dir, f'mem-{interpreter.step_count}'), 'br') as f:
        memory = f.read()

    with open(path.join(state_data_dir, f'state-{interpreter.step_count}.json'), 'r') as f:
        state = json.load(f)

    comp_header = get_header(memory)
    assert comp_header.version == interpreter.header.version

    diffs = dict()

    # Compare objects
    obj_table = ZMachineObjectTable(memory, comp_header)
    for obj_num in range(1, num_objects + 1):
        obj_diffs = dict()
        comp_obj = obj_table.object(obj_num)
        obj = interpreter.object_table.object(obj_num)

        if comp_obj.parent != obj.parent:
            obj_diffs['parent'] = dict(expected=comp_obj.parent,
                                       found=obj.parent)

        if comp_obj.sibling != obj.sibling:
            obj_diffs['sibling'] = dict(expected=comp_obj.sibling,
                                        found=obj.sibling)

        if comp_obj.child != obj.child:
            obj_diffs['child'] = dict(expected=comp_obj.child,
                                      found=obj.child)

        if comp_obj.attributes != obj.attributes:
            obj_diffs['attributes'] = dict(expected=comp_obj.attributes,
                                           found=obj.attributes)

        if comp_obj.properties.all() != obj.properties.all():
            obj_diffs['properties'] = dict(expected=comp_obj.properties.all(),
                                           found=obj.properties.all())

        if obj_diffs:
            diffs.setdefault('objects', dict())
            diffs['objects'][obj_num] = obj_diffs

    # Compare global variables
    variables = ZMachineVariables(memory, comp_header, ZMachineStack())
    for global_num in range(0xef):
        if variables.global_val(global_num) != interpreter.variables.global_val(global_num):
            diffs.setdefault('globals', dict())
            diffs['globals'][global_num] = dict(expected=variables.global_val(global_num),
                                                found=interpreter.variables.global_val(global_num))

    # Compare external state
    if state['pc'] != hex(int(interpreter.pc)):
        diffs['pc'] = dict(expected=state['pc'],
                           found=hex(int(interpreter.pc)))

    # Local vars
    if len(state['local_vars']) != len(interpreter.stack.frame.local_vars):
        diffs['num_local_vars'] = dict(expected=len(state['local_vars']))
    else:
        for i in range(len(state['local_vars'])):
            expected = state['local_vars'][i]
            found = '0x' + interpreter.stack.frame.local_vars[i].hex()
            if expected != found:
                diffs.setdefault('local_vars', {})
                diffs['local_vars'][i] = dict(expected=expected, found=found)

    # Routine stack
    if len(state['stack']) != len(interpreter.stack.frame.stack_data):
        diffs['routine_stack_size'] = dict(expected=len(state['stack']),
                                           found=len(interpreter.stack.frame.stack_data))
    else:
        for i in range(len(state['stack'])):
            expected = state['stack'][i]
            found = '0x' + interpreter.stack.frame.stack_data[i].hex()

            if expected != found:
                diffs.setdefault('routine_stack', {})
                diffs['routine_stack'][i] = dict(expected=expected, found=found)

    # ret var
    found_res_var = '0x' + interpreter.stack.frame.result_var.hex() if interpreter.stack.frame.result_var is not None else None
    if state['ret_var'] != found_res_var:
        diffs['result_var'] = dict(expected=state['ret_var'], found=found_res_var)

    found_ret_pc = hex(int(interpreter.stack.frame.return_pc)) if interpreter.stack.frame.return_pc is not None else '0x0000'
    if state['ret_pc'] != found_ret_pc:
        diffs['return_pc'] = dict(expected=state['ret_pc'], found=found_ret_pc)

    return diffs


@pytest.fixture
def v3_header_and_data(zork1_v3_data: memoryview) -> Tuple[ZCodeHeader, memoryview]:
    header = get_header(zork1_v3_data)
    return header, zork1_v3_data


def test_repro_none_property_value(v3_header_and_data: Tuple[ZCodeHeader, memoryview]):
    header, memory = v3_header_and_data
    screen = MockScreen()
    input = MockInput(['s', 'e', 'open window', 'q', 'y'])

    interpreter = ZMachineInterpreterV3(header, memory, screen, input)
    interpreter.initialize()

    try:
        interpreter.run()
        raise AssertionError('End of input should have occurred.')
    except ZMachineExitException as e:
        # check message
        assert interpreter.pc == 0x6e08


def test_playing_some_zork_v3(v3_header_and_data: Tuple[ZCodeHeader, memoryview]):
    header, memory = v3_header_and_data
    screen = MockScreen()
    input = MockInput(['open mailbox', 'get leaflet', 'read leaflet', 'w', 'q', 'y'])

    interpreter = ZMachineInterpreterV3(header, memory, screen, input)
    interpreter.initialize()

    try:
        interpreter.run()
        raise AssertionError('End of input should have occurred.')
    except ZMachineExitException:
        # check message
        assert interpreter.pc == 0x6e08
        text = ''.join(screen.printed_text)
        assert text == """ZORK I: The Great Underground Empire
Copyright (c) 1981, 1982, 1983 Infocom, Inc. All rights reserved.
ZORK is a registered trademark of Infocom, Inc.
Revision 88 / Serial number 840726

West of House
You are standing in an open field west of a white house, with a boarded front door.
There is a small mailbox here.

>Opening the small mailbox reveals a leaflet.

>Taken.

>"WELCOME TO ZORK!

ZORK is a game of adventure, danger, and low cunning. In it you will explore some of the most amazing territory ever seen by mortals. No computer should be without one!"


>Forest
This is a forest, with trees in all directions. To the east, there appears to be sunlight.

>Your score is 0 (total of 350 points), in 4 moves.
This gives you the rank of Adventurer.
Do you wish to leave the game? (Y is affirmative): >"""


@pytest.mark.skip('only useful with data from other z-machine')
def test_compare_with_other_zmachine(v3_header_and_data: Tuple[ZCodeHeader, memoryview]):
    header, memory = v3_header_and_data
    screen = MockScreen()
    input = MockInput(['open mailbox', 'get leaflet', 'read leaflet', 'w'])

    interpreter = ZMachineInterpreterV3(header, memory, screen, input)
    interpreter.initialize()

    while True:
        interpreter.step()

        if interpreter.step_count > 2947:
            diffs = compare_machine_state(interpreter, '../../theinternetftw/xyppy/steps')
            if diffs != {}:
                # Looks weird, but useful for setting a breakpoint here
                assert diffs == {}


