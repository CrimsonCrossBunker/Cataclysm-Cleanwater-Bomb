#!/usr/bin/env python3
"""Validate Lua-enabled build and ``--check-mods`` runtime contracts."""

from __future__ import annotations

from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
ENGINE_CMAKE_PATH = ROOT / "src" / "CMakeLists.txt"
LUA_CMAKE_PATH = ROOT / "src" / "lua" / "CMakeLists.txt"
SOL_CONFIG_PATH = ROOT / "src" / "sol" / "config.hpp"
MAIN_PATH = ROOT / "src" / "main.cpp"


def validate_cmake_contract(
    engine_source: str,
    lua_source: str,
    sol_config_source: str,
    main_source: str,
) -> list[str]:
    """Return actionable errors for broken bundled-Lua
    build/runtime contracts."""
    errors: list[str] = []
    signature = "function(configure_lua_platform TARGET)"
    start = engine_source.find(signature)
    if start == -1:
        errors.append(
            "src/CMakeLists.txt: missing configure_lua_platform "
            "helper"
        )
    else:
        end = engine_source.find("endfunction()", start)
        if end == -1:
            errors.append(
                "src/CMakeLists.txt: configure_lua_platform is "
                "unterminated"
            )
        else:
            helper = engine_source[start:end]
            if "if (CATA_ENABLE_LUA_PLATFORM)" not in helper:
                errors.append(
                    "src/CMakeLists.txt: Lua linking must remain optional"
                )
            if "target_link_libraries(${TARGET} PUBLIC libsol)" not in helper:
                errors.append(
                    "src/CMakeLists.txt: configure_lua_platform must "
                    "propagate libsol"
                )

    normalized_lua = " ".join(lua_source.split())
    if (
        "set_source_files_properties(${LUA_SOURCES} "
        "PROPERTIES LANGUAGE C)"
        not in normalized_lua
    ):
        errors.append(
            "src/lua/CMakeLists.txt: bundled Lua sources must use LANGUAGE C"
        )
    if "#define SOL_USE_CXX_LUA" in sol_config_source:
        errors.append(
            "src/sol/config.hpp: sol must use the bundled Lua C ABI"
        )

    normalized_main = " ".join(main_source.split())
    headless_init = (
        "#if !defined(TILES) if( !cli.check_mods ) { "
        "get_options().init(); get_options().load(); } #endif"
    )
    check_mods_init = (
        "else if( cli.check_mods ) { get_options().init(); "
        "get_options().load(); }"
    )
    if headless_init not in normalized_main:
        errors.append(
            "src/main.cpp: headless option initialization must skip "
            "--check-mods"
        )
    if check_mods_init not in normalized_main:
        errors.append(
            "src/main.cpp: --check-mods must initialize options exactly once"
        )
    return errors


def main() -> int:
    errors = validate_cmake_contract(
        ENGINE_CMAKE_PATH.read_text(encoding="utf-8"),
        LUA_CMAKE_PATH.read_text(encoding="utf-8"),
        SOL_CONFIG_PATH.read_text(encoding="utf-8"),
        MAIN_PATH.read_text(encoding="utf-8"),
    )
    if errors:
        for error in errors:
            print(error)
        return 1
    print("Lua-enabled build and --check-mods runtime contracts passed")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
