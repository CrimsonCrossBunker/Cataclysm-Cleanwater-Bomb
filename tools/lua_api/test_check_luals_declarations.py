"""Regression tests for the Lua-first Platform declaration check."""

from __future__ import annotations

import tempfile
import unittest
from pathlib import Path

try:
    from .check_luals_declarations import check
except ImportError:
    from check_luals_declarations import check  # type: ignore


ROOT = Path(__file__).resolve().parents[2]
DECLARATIONS = ROOT / "data/lua/types/ccb_platform_v1.d.lua"


class LuaLsPlatformTest(unittest.TestCase):
    def test_platform_declarations_are_current(self) -> None:
        result = check(DECLARATIONS)
        self.assertGreater(result["classes"], 100)
        self.assertGreater(result["methods"], 300)
        self.assertGreater(result["fields"], 300)

    def test_legacy_surface_is_rejected(self) -> None:
        contents = DECLARATIONS.read_text(encoding="utf-8")
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / DECLARATIONS.name
            path.write_text(contents.replace("Platform v1", "API v5", 1), encoding="utf-8")
            with self.assertRaisesRegex(RuntimeError, "Platform v1"):
                check(path)

    def test_duplicate_class_is_rejected(self) -> None:
        contents = DECLARATIONS.read_text(encoding="utf-8")
        marker = "---@class CcbPlatformContent\n"
        self.assertIn(marker, contents)
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / DECLARATIONS.name
            path.write_text(contents + marker, encoding="utf-8")
            with self.assertRaisesRegex(RuntimeError, "repeats a LuaLS class"):
                check(path)


if __name__ == "__main__":
    unittest.main()
