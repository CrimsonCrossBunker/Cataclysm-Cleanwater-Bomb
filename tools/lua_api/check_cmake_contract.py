#!/usr/bin/env python3
"""Validate the Lua-enabled CMake ABI and propagated-link contract."""

from __future__ import annotations

from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
ENGINE_CMAKE_PATH = ROOT / "src" / "CMakeLists.txt"
LUA_CMAKE_PATH = ROOT / "src" / "lua" / "CMakeLists.txt"


def validate_cmake_contract(engine_source: str, lua_source: str) -> list[str]:
    """Return actionable errors for a broken bundled-Lua CMake contract."""
    errors: list[str] = []
    signature = "function(configure_lua_ui TARGET)"
    start = engine_source.find(signature)
    if start == -1:
        errors.append("src/CMakeLists.txt: missing configure_lua_ui helper")
    else:
        end = engine_source.find("endfunction()", start)
        if end == -1:
            errors.append("src/CMakeLists.txt: configure_lua_ui is unterminated")
        else:
            helper = engine_source[start:end]
            if "if (CATA_ENABLE_LUA_UI)" not in helper:
                errors.append("src/CMakeLists.txt: Lua linking must remain optional")
            if "target_link_libraries(${TARGET} PUBLIC libsol)" not in helper:
                errors.append(
                    "src/CMakeLists.txt: configure_lua_ui must propagate libsol"
                )

    normalized_lua = " ".join(lua_source.split())
    if (
        "set_source_files_properties(${LUA_SOURCES} "
        "PROPERTIES LANGUAGE CXX)"
        not in normalized_lua
    ):
        errors.append(
            "src/lua/CMakeLists.txt: bundled Lua sources must use LANGUAGE CXX"
        )
    return errors


def main() -> int:
    errors = validate_cmake_contract(
        ENGINE_CMAKE_PATH.read_text(encoding="utf-8"),
        LUA_CMAKE_PATH.read_text(encoding="utf-8"),
    )
    if errors:
        for error in errors:
            print(error)
        return 1
    print("Lua-enabled CMake ABI and propagated-link contract passed")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
