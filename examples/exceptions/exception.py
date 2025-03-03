import ctypes

lib = ctypes.CDLL("./libexception.so")

lib.add_with_cb.argtypes = [
    ctypes.c_int,
    ctypes.c_int,
    ctypes.CFUNCTYPE(ctypes.c_int, ctypes.c_int, ctypes.c_int),
]
lib.add_with_cb.restype = ctypes.c_int


def add_ctypes_cb(a: int, b: int) -> int:
    if a == 0:
        raise ValueError("a is 0")
    return a + b


if __name__ == "__main__":
    CALLBACK = ctypes.CFUNCTYPE(ctypes.c_int, ctypes.c_int, ctypes.c_int)
    cb_func = CALLBACK(add_ctypes_cb)
    lib.add_with_cb(1, 2, cb_func)
    lib.add_with_cb(0, 2, cb_func)
