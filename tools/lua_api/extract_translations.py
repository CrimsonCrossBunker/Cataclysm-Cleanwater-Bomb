#!/usr/bin/env python3
"""Extract literal Platform text with GNU xgettext; never execute Lua."""
from __future__ import annotations

import argparse
from pathlib import Path
import subprocess
import sys

KEYWORDS = (
    "ccb.services.translate:1,1t",
    "ccb.services.translate:1,2c,2t",
    "ccb.services.translate_plural:1,2,3t",
    "ccb.services.translate_plural:1,2,4c,4t",
)
HEADER = (
    'msgid ""\nmsgstr ""\n'
    '"Content-Type: text/plain; charset=UTF-8\\n"\n'
    '"Content-Transfer-Encoding: 8bit\\n"\n\n'
)


def extract(files: list[Path], executable: str = "xgettext") -> str:
    """Keep the caller's relative source references; stable input order is sorted."""
    for path in files:
        if path.suffix != ".lua" or not path.is_file():
            raise ValueError(f"expected an existing Lua source file: {path}")
    if not files:
        raise ValueError("at least one Lua source file is required")
    command = [executable, "--language=Lua", "--from-code=UTF-8", "--keyword=",
               "--force-po", "--no-wrap", "--output=-"]
    command.extend(f"--keyword={keyword}" for keyword in KEYWORDS)
    command.append("--")
    command.extend(sorted({str(path) for path in files}))
    try:
        result = subprocess.run(command, capture_output=True, text=True,
                                encoding="utf-8", check=False)
    except (OSError, UnicodeError) as error:
        raise ValueError(f"cannot run GNU xgettext: {error}") from error
    if result.returncode:
        raise ValueError(f"xgettext failed ({result.returncode}): {result.stderr.strip()}")
    if result.stderr:
        print(result.stderr.rstrip(), file=sys.stderr)
    # Keep xgettext's UTF-8 header during extraction: --omit-header can lose
    # non-ASCII strings in some gettext versions. Replace only after extraction.
    _, separator, messages = result.stdout.partition("\n\n")
    if not separator:
        raise ValueError("xgettext returned an invalid translation template")
    return HEADER + messages


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("files", nargs="+", type=Path, help="explicit Lua source files")
    parser.add_argument("--output", type=Path, help="POT destination; default is stdout")
    parser.add_argument("--check", action="store_true", help="compare --output without writing")
    parser.add_argument("--xgettext", default="xgettext", help="GNU xgettext executable")
    args = parser.parse_args(argv)
    if args.check and args.output is None:
        parser.error("--check requires --output")
    try:
        if args.output and args.output.resolve() in {path.resolve() for path in args.files}:
            raise ValueError("output must not overwrite an input source")
        content = extract(args.files, args.xgettext)
        if args.check:
            if not args.output.is_file() or args.output.read_bytes() != content.encode("utf-8"):
                print(f"translation template is out of date: {args.output}", file=sys.stderr)
                return 1
        elif args.output:
            args.output.write_bytes(content.encode("utf-8"))
        else:
            sys.stdout.write(content)
        return 0
    except (OSError, UnicodeError, ValueError) as error:
        print(f"error: {error}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    raise SystemExit(main())
