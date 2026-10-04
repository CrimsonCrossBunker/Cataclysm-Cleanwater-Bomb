from __future__ import annotations

import shutil
import subprocess
import tempfile
import unittest
from pathlib import Path

try:
    from .check_cmake_contract import (
        ENGINE_CMAKE_PATH,
        LUA_CMAKE_PATH,
        MAIN_PATH,
        SOL_CONFIG_PATH,
        validate_cmake_contract,
    )
except ImportError:
    from check_cmake_contract import (
        ENGINE_CMAKE_PATH,
        LUA_CMAKE_PATH,
        MAIN_PATH,
        SOL_CONFIG_PATH,
        validate_cmake_contract,
    )


class CMakeContractTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.engine_source = ENGINE_CMAKE_PATH.read_text(encoding="utf-8")
        cls.lua_source = LUA_CMAKE_PATH.read_text(encoding="utf-8")
        cls.sol_config_source = SOL_CONFIG_PATH.read_text(encoding="utf-8")
        cls.main_source = MAIN_PATH.read_text(encoding="utf-8")

    def test_checked_in_contract_is_complete(self) -> None:
        self.assertEqual(
            validate_cmake_contract(
                self.engine_source,
                self.lua_source,
                self.sol_config_source,
                self.main_source,
            ),
            [],
        )

    @unittest.skipUnless(shutil.which("cmake") and shutil.which("make"),
                         "native build tools unavailable")
    def test_native_test_scopes_match_make_and_cmake(self) -> None:
        root = ENGINE_CMAKE_PATH.parents[1]
        support = (root / "tests/test_support_sources.txt").read_text()
        sources = set(support.splitlines()) | {
            "lua_platform_future_test.cpp", "unrelated_test.cpp"}
        # Exercise the actual build files using tiny sources, without building
        # the engine or running native game tests in this contract gate.
        with tempfile.TemporaryDirectory() as directory:
            fixture = Path(directory)
            tests = fixture / "tests"
            tests.mkdir()
            for name in (
                    "CMakeLists.txt", "Makefile", "test_support_sources.txt"):
                shutil.copyfile(root / "tests" / name, tests / name)
            for name in sources:
                (tests / name).touch()
            (fixture / "CMakeLists.txt").write_text('''
cmake_minimum_required(VERSION 3.20)
project(TestSelection LANGUAGES CXX)
set(BUILD_TESTING ON)
set(CURSES ON)
add_library(cataclysm-common INTERFACE)
add_subdirectory(tests)
get_target_property(selected cata_test SOURCES)
list(JOIN selected "\\n" selected)
file(WRITE "${CMAKE_BINARY_DIR}/selected.txt" "${selected}")
''', encoding="utf-8")
            for scope, enabled, valid in (
                    ("all", "ON", True), ("lua", "ON", True),
                    ("lua", "OFF", False), ("unknown", "ON", False)):
                with self.subTest(scope=scope, lua=enabled):
                    cmake = subprocess.run([
                        "cmake", "-S", str(fixture),
                        "-B", str(fixture / "build"),
                        "-DCATA_TEST_SUITE=" + scope,
                        "-DCATA_ENABLE_LUA_PLATFORM=" + enabled,
                    ], capture_output=True, text=True)
                    make = subprocess.run([
                        "make", "-s", "PCH=0", "CLANG=0", "ODIR=objects",
                        "CATA_TEST_SUITE=" + scope,
                        "CATA_ENABLE_LUA_PLATFORM=" +
                        ("1" if enabled == "ON" else "0"),
                        "--eval", r'print-sources:;@printf "%s\n" $(SOURCES)',
                        "print-sources",
                    ], cwd=tests, capture_output=True, text=True)
                    if not valid:
                        self.assertNotEqual(cmake.returncode, 0)
                        self.assertNotEqual(make.returncode, 0)
                        continue
                    self.assertEqual(cmake.returncode, 0, cmake.stderr)
                    self.assertEqual(make.returncode, 0, make.stderr)
                    expected = (sources if scope == "all" else
                                sources - {"unrelated_test.cpp"})
                    self.assertEqual(set(make.stdout.splitlines()), expected)
                    selected = (fixture / "build/selected.txt").read_text()
                    self.assertEqual(
                        {Path(name).name for name in selected.splitlines()},
                        expected)

    def test_cpp_abi_for_bundled_lua_is_rejected(self) -> None:
        lua_source = self.lua_source.replace(
            "PROPERTIES LANGUAGE C", "PROPERTIES LANGUAGE CXX"
        )
        self.assertNotEqual(lua_source, self.lua_source)
        errors = validate_cmake_contract(
            self.engine_source,
            lua_source,
            self.sol_config_source,
            self.main_source,
        )
        self.assertTrue(
            any("LANGUAGE C" in error for error in errors), errors)

    def test_native_loading_prerequisites_cannot_be_removed(self) -> None:
        requirements = (
            "target_compile_definitions(liblua PRIVATE LUA_BUILD_AS_DLL)",
            "target_compile_definitions(liblua PRIVATE LUA_USE_DLOPEN)",
            "C_VISIBILITY_PRESET default",
            "target_link_libraries(liblua PUBLIC ${CMAKE_DL_LIBS})",
            '"LINKER:--export-dynamic"',
            '"LINKER:-export_dynamic"',
        )
        for requirement in requirements:
            with self.subTest(requirement=requirement):
                changed = self.lua_source.replace(requirement, "")
                self.assertNotEqual(changed, self.lua_source)
                errors = validate_cmake_contract(
                    self.engine_source, changed,
                    self.sol_config_source, self.main_source,
                )
                self.assertTrue(
                    any("native Lua loading requires" in e for e in errors),
                    errors,
                )

    def test_sol_cpp_lua_abi_is_rejected(self) -> None:
        sol_config_source = (
            self.sol_config_source + "\n#define SOL_USE_CXX_LUA 1\n"
        )
        errors = validate_cmake_contract(
            self.engine_source,
            self.lua_source,
            sol_config_source,
            self.main_source,
        )
        self.assertTrue(any("Lua C ABI" in error for error in errors), errors)

    def test_missing_libsol_propagation_is_rejected(self) -> None:
        engine_source = self.engine_source.replace(
            "target_link_libraries(${TARGET} PUBLIC libsol)",
            "target_link_libraries(${TARGET} PUBLIC third-party)",
        )
        self.assertNotEqual(engine_source, self.engine_source)
        errors = validate_cmake_contract(
            engine_source,
            self.lua_source,
            self.sol_config_source,
            self.main_source,
        )
        self.assertTrue(
            any("propagate libsol" in error for error in errors), errors)

    def test_duplicate_headless_check_mods_initialization_is_rejected(
            self) -> None:
        main_source = self.main_source.replace(
            """    if( !cli.check_mods ) {
        get_options().init();
        get_options().load();
    }
""",
            """    get_options().init();
    get_options().load();
""",
            1,
        )
        self.assertNotEqual(main_source, self.main_source)
        errors = validate_cmake_contract(
            self.engine_source,
            self.lua_source,
            self.sol_config_source,
            main_source,
        )
        self.assertTrue(
            any("skip --check-mods" in error for error in errors), errors)


if __name__ == "__main__":
    unittest.main()
