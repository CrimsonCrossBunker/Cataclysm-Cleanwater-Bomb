import ctypes as c
from pathlib import Path
import platform
import socket
import sys
import time


class TransportStatus(c.Structure):
    _fields_ = [
        ("mode", c.c_uint8),
        ("running", c.c_uint8),
        ("connected", c.c_uint8),
        ("reserved", c.c_uint8),
        ("peer_count", c.c_uint32),
    ]


def main(library_path, expected_arch):
    assert platform.machine() == expected_arch, platform.machine()
    library = c.CDLL(str(Path(library_path).resolve(strict=True)))

    def bind(symbol, result_type, *argument_types):
        fn = getattr(library, f"ccb_coop_{symbol}")
        fn.restype = result_type
        fn.argtypes = argument_types
        return fn

    abi_version = bind("abi_version", c.c_uint32)
    assert abi_version() == 2, "Unexpected CCB co-op library ABI"
    create = bind("transport_create", c.c_void_p)
    destroy = bind("transport_destroy", None, c.c_void_p)
    start_host = bind("transport_start_host", c.c_uint8, c.c_void_p, c.c_char_p)
    start_client = bind("transport_start_client", c.c_uint8, c.c_void_p, c.c_char_p, c.c_uint64)
    status = bind("transport_status", TransportStatus, c.c_void_p)
    with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as reservation:
        reservation.bind(("127.0.0.1", 0))
        endpoint = f"127.0.0.1:{reservation.getsockname()[1]}".encode()

    host, guest = create(), create()
    try:
        assert host and guest
        assert start_host(host, endpoint), "Host start failed"
        assert start_client(guest, endpoint, 42), "Guest start failed"
        deadline = time.monotonic() + 10
        while time.monotonic() < deadline:
            if status(host).peer_count == 1 and status(guest).connected:
                print(f"ABI 2 and native UDP loopback passed on {expected_arch}")
                return
            time.sleep(0.02)
        raise RuntimeError("Host and guest did not establish a Renet connection")
    finally:
        destroy(guest)
        destroy(host)


if __name__ == "__main__":
    main(*sys.argv[1:])
