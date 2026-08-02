#!/usr/bin/env python3
"""Validate the Lua-enabled CMake executable-link contract."""

from __future__ import annotations

import re
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
CMAKE_PATH = ROOT / "src" / "CMakeLists.txt"


def validate_cmake_contract(source: str) -> list[str]:
    """Return actionable errors for a broken Lua executable link contract."""
    errors: list[str] = []
    match = re.search(
        r"function\(link_lua_ui_runtime TARGET\)(.*?)endfunction\(\)",
        source,
        flags=re.DOTALL,
    )
    if match is None:
        return ["src/CMakeLists.txt: missing link_lua_ui_runtime helper"]

    helper = match.group(1)
    if "if (CATA_ENABLE_LUA_UI)" not in helper:
        errors.append("src/CMakeLists.txt: Lua executable linking must remain optional")
    if "target_link_libraries(${TARGET} PRIVATE liblua)" not in helper:
        errors.append("src/CMakeLists.txt: final executables must link liblua explicitly")

    tiles_calls = source.count("link_lua_ui_runtime(cataclysm-tiles)")
    curses_and_headless_calls = source.count("link_lua_ui_runtime(cataclysm)")
    if tiles_calls != 1:
        errors.append("src/CMakeLists.txt: tiles needs exactly one Lua runtime link")
    if curses_and_headless_calls != 2:
        errors.append(
            "src/CMakeLists.txt: curses and headless both need a Lua runtime link"
        )
    return errors


def main() -> int:
    errors = validate_cmake_contract(CMAKE_PATH.read_text(encoding="utf-8"))
    if errors:
        for error in errors:
            print(error)
        return 1
    print("Lua-enabled CMake executable link contract passed")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
