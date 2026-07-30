"""Regression tests for LuaLS public-surface completeness checks."""

from __future__ import annotations

import tempfile
import unittest
from pathlib import Path

from .check_luals_declarations import check


REPOSITORY_ROOT = Path(__file__).resolve().parents[2]
DECLARATIONS = REPOSITORY_ROOT / "data/lua/types/ccb_api_v5.d.lua"


class LuaLsDeclarationTest(unittest.TestCase):
    def check_modified(
        self,
        old: str,
        new: str,
        message: str,
    ) -> None:
        contents = DECLARATIONS.read_text(encoding="utf-8")
        self.assertIn(old, contents)
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / DECLARATIONS.name
            path.write_text(
                contents.replace(old, new, 1), encoding="utf-8"
            )
            with self.assertRaisesRegex(RuntimeError, message):
                check(path)

    def test_committed_declarations_cover_the_native_surface(self) -> None:
        result = check(DECLARATIONS)
        self.assertEqual(result["methods"], 285)
        self.assertEqual(result["usertypes"], 14)
        self.assertEqual(result["coordinate_factories"], 36)

    def test_missing_registered_method_is_rejected(self) -> None:
        self.check_modified(
            "function CcbHordesApi.advance() end",
            "",
            "omit registered methods",
        )

    def test_missing_usertype_is_rejected(self) -> None:
        self.check_modified(
            "---@class GameHandle",
            "---@type GameHandle",
            "omit usertypes",
        )

    def test_missing_dynamic_coordinate_factory_is_rejected(self) -> None:
        self.check_modified(
            "---@field point_abs_ms fun",
            "---@field removed_abs_ms fun",
            "omit coordinate factories",
        )

    def test_stale_v4_file_is_rejected(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            path = root / DECLARATIONS.name
            path.write_text(
                DECLARATIONS.read_text(encoding="utf-8"),
                encoding="utf-8",
            )
            (root / "ccb_api_v4.d.lua").write_text(
                "stale", encoding="utf-8"
            )
            with self.assertRaisesRegex(RuntimeError, "stale"):
                check(path)


if __name__ == "__main__":
    unittest.main()
