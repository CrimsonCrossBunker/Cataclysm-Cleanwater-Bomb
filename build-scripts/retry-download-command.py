#!/usr/bin/env python3
"""Retry a download command only after a reported transient network failure."""

import argparse
import re
import subprocess
import sys
import time


TRANSIENT = re.compile(
    r"HTTP(?:/[\d.]+)?\s+(?:408|429|5\d\d)\b"
    r"|requested URL returned error:\s*(?:408|429|5\d\d)\b"
    r"|status_code:\s*(?:6|7|28|35|52|56)\b"
    r"|connection (?:timed out|reset by peer|refused)",
    re.IGNORECASE,
)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--attempts", type=int, default=3)
    parser.add_argument("--delay", type=float, default=5)
    parser.add_argument("command", nargs=argparse.REMAINDER)
    args = parser.parse_args()
    command = args.command
    if command[:1] == ["--"]:
        command = command[1:]
    if not command or args.attempts < 1 or args.delay < 0:
        parser.error(
            "provide a command, positive attempts and nonnegative delay")
    for attempt in range(1, args.attempts + 1):
        result = subprocess.run(
            command, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
            text=True,
        )
        print(result.stdout, end="", flush=True)
        if result.returncode == 0:
            return 0
        if attempt == args.attempts or not TRANSIENT.search(result.stdout):
            return result.returncode
        print(
            f"Transient download failure; retry {attempt + 1}/{args.attempts}",
            flush=True,
        )
        time.sleep(args.delay)
    return 1


if __name__ == "__main__":
    sys.exit(main())
