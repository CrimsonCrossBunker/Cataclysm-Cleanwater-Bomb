from __future__ import annotations

import unittest

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
