

class UnsupportedVersionError(Exception):
    pass


class ZStringParseException(Exception):
    pass


class ZMachineStackUnderflow(Exception):
    pass


class ZMachineExitException(Exception):
    """ Raised then the z-machine `quit` instruction is executed. """
    pass


class ZMachineUndefinedInstruction(Exception):
    """ Raised when an undefined instruction is attempted to be executed """
    pass
