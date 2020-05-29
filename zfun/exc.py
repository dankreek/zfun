class ZMachineException(Exception):
    pass


class UnsupportedVersionError(ZMachineException):
    pass


class ZStringParseException(ZMachineException):
    pass


class ZMachineStackUnderflow(ZMachineException):
    pass


class ZMachineExitException(ZMachineException):
    """ Raised then the z-machine `quit` instruction is executed. """
    pass


class ZMachineUndefinedInstruction(ZMachineException):
    """ Raised when an undefined instruction is attempted to be executed """
    pass


class ZMachineResetException(ZMachineException):
    """ Raised when the z-machine would like to restart itself """
    pass


class ZMachineIllegalOperation(ZMachineException):
    """ Raised when an illegal operation of some kind occurs """
    pass
