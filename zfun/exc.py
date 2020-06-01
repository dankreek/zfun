class ZMachineException(Exception):
    pass


class UnsupportedVersionError(ZMachineException):
    pass


class ZMachineIllegalOperation(ZMachineException):
    """ Raised when an illegal operation of some kind occurs """
    pass
