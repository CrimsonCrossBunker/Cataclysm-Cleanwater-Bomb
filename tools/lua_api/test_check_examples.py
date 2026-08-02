#!/usr/bin/env python3
"""Regression tests for Lua manifests and the loadable v5 example Mod."""

from __future__ import annotations

import json
import tempfile
import unittest
from pathlib import Path

try:
    from .check_examples import validate_example_mod, validate_manifest
except ImportError:
    from check_examples import validate_example_mod, validate_manifest


class LuaExampleCheckTest(unittest.TestCase):
    def test_example_is_a_complete_mod(self) -> None:
        result = validate_example_mod()
        self.assertEqual(result["modinfo_entries"], 1)
        self.assertEqual(result["lua_files"], 2)
        self.assertEqual(result["contract_symbols"], 23)
        self.assertGreater(result["capabilities"], 0)

    def test_manifest_schema_rejects_missing_id(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "manifest.json"
            path.write_text(
                json.dumps(
                    {
                        "version": "1",
                        "api_version": 5,
                        "capabilities": [],
                        "dependencies": [],
                    }
                ),
                encoding="utf-8",
            )
            with self.assertRaises(Exception):
                validate_manifest(path)


if __name__ == "__main__":
    unittest.main()
