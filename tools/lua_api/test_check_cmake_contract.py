from __future__ import annotations

import unittest

try:
    from .check_cmake_contract import (
        ENGINE_CMAKE_PATH,
        LUA_CMAKE_PATH,
        MAIN_PATH,
        validate_cmake_contract,
    )
except ImportError:
    from check_cmake_contract import (
        ENGINE_CMAKE_PATH,
        LUA_CMAKE_PATH,
        MAIN_PATH,
        validate_cmake_contract,
    )


class CMakeContractTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.engine_source = ENGINE_CMAKE_PATH.read_text(encoding="utf-8")
        cls.lua_source = LUA_CMAKE_PATH.read_text(encoding="utf-8")
        cls.main_source = MAIN_PATH.read_text(encoding="utf-8")

    def test_checked_in_contract_is_complete(self) -> None:
        self.assertEqual(
            validate_cmake_contract(
                self.engine_source, self.lua_source, self.main_source
            ),
            [],
        )

    def test_c_abi_for_bundled_lua_is_rejected(self) -> None:
        lua_source = self.lua_source.replace(
            "PROPERTIES LANGUAGE CXX", "PROPERTIES LANGUAGE C"
        )
        self.assertNotEqual(lua_source, self.lua_source)
        errors = validate_cmake_contract(
            self.engine_source, lua_source, self.main_source
        )
        self.assertTrue(
            any("LANGUAGE CXX" in error for error in errors), errors)

    def test_missing_libsol_propagation_is_rejected(self) -> None:
        engine_source = self.engine_source.replace(
            "target_link_libraries(${TARGET} PUBLIC libsol)",
            "target_link_libraries(${TARGET} PUBLIC third-party)",
        )
        self.assertNotEqual(engine_source, self.engine_source)
        errors = validate_cmake_contract(
            engine_source, self.lua_source, self.main_source
        )
        self.assertTrue(
            any("propagate libsol" in error for error in errors), errors)

    def test_duplicate_headless_check_mods_initialization_is_rejected(
            self ) -> None:
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
            self.engine_source, self.lua_source, main_source
        )
        self.assertTrue(
            any("skip --check-mods" in error for error in errors), errors)


if __name__ == "__main__":
    unittest.main()
