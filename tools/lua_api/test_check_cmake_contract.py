from __future__ import annotations

import unittest

try:
    from .check_cmake_contract import CMAKE_PATH, validate_cmake_contract
except ImportError:
    from check_cmake_contract import CMAKE_PATH, validate_cmake_contract


class CMakeContractTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.source = CMAKE_PATH.read_text(encoding="utf-8")

    def test_checked_in_contract_is_complete(self) -> None:
        self.assertEqual(validate_cmake_contract(self.source), [])

    def test_missing_final_lua_archive_is_rejected(self) -> None:
        source = self.source.replace(
            "target_link_libraries(${TARGET} PRIVATE liblua)",
            "target_link_libraries(${TARGET} PRIVATE libsol)",
        )
        errors = validate_cmake_contract(source)
        self.assertTrue(any("link liblua explicitly" in error for error in errors), errors)

    def test_missing_headless_executable_link_is_rejected(self) -> None:
        prefix, separator, suffix = self.source.rpartition(
            "    link_lua_ui_runtime(cataclysm)\n"
        )
        self.assertTrue(separator)
        errors = validate_cmake_contract(prefix + suffix)
        self.assertTrue(any("curses and headless" in error for error in errors), errors)


if __name__ == "__main__":
    unittest.main()
