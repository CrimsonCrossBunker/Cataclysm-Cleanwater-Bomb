#!/usr/bin/env python3

import json
from pathlib import Path
import sys
import tempfile
import unittest
from unittest.mock import patch

from generate_builtin_mods import (
    find_mod_ids,
    find_mod_roots,
    main,
    strip_jsonc_comments,
    strip_trailing_commas,
)


class BuiltinModManifestTest(unittest.TestCase):
    def test_jsonc_root_entries_are_extracted(self) -> None:
        text = """[
          // A line comment.
          { "type": "MOD_INFO", "id": "beta", },
          /* A block comment. */
          { "type": "MOD_INFO", "id": "alpha" },
          { "type": "MOD_INFO", "id": "alpha" }
        ]"""
        value = json.loads(strip_trailing_commas(strip_jsonc_comments(text)))
        self.assertEqual(
            find_mod_ids(value, Path("modinfo.json")), {"alpha", "beta"}
        )

    def test_nested_mod_info_is_not_loaded(self) -> None:
        value = {
            "type": "NOT_MOD_INFO",
            "nested": {"type": "MOD_INFO", "id": "not_loaded"},
        }
        self.assertEqual(find_mod_ids(value, Path("modinfo.json")), set())

    def test_main_accepts_bom_and_writes_sorted_ids(self) -> None:
        with tempfile.TemporaryDirectory() as temp_dir:
            root = Path(temp_dir)
            source = root / "mods"
            source.mkdir()
            (source / "modinfo.json").write_text(
                '\ufeff[{"type":"MOD_INFO","id":"beta"},'
                '{"type":"MOD_INFO","id":"alpha"}]',
                encoding="utf-8",
            )
            output = root / "builtin_mods_generated.h"
            arguments = [
                "generate_builtin_mods.py",
                "--source",
                str(source),
                "--output",
                str(output),
            ]
            with patch.object(sys, "argv", arguments):
                self.assertEqual(main(), 0)
            header = output.read_text(encoding="utf-8")
            self.assertIn("builtin_mod_manifest_available = true", header)
            self.assertLess(header.index('"alpha"'), header.index('"beta"'))

    def test_platform_roots_are_listed_without_executing_lua(self) -> None:
        with tempfile.TemporaryDirectory() as temp_dir:
            source = Path(temp_dir) / "mods"
            (source / "minimal").mkdir(parents=True)
            (source / "minimal" / "main.lua").write_text(
                'error("must not execute")', encoding="utf-8"
            )
            (source / "custom_id").mkdir()
            (source / "custom_id" / "mod.lua").write_text(
                'return ccb.ModDefinition { id = "different" }',
                encoding="utf-8",
            )
            (source / "not_a_mod").mkdir()

            self.assertEqual(
                find_mod_roots(source), {"minimal", "custom_id"}
            )

    def test_missing_source_writes_unavailable_manifest(self) -> None:
        with tempfile.TemporaryDirectory() as temp_dir:
            root = Path(temp_dir)
            output = root / "builtin_mods_generated.h"
            arguments = [
                "generate_builtin_mods.py",
                "--source",
                str(root / "missing"),
                "--output",
                str(output),
            ]
            with patch.object(sys, "argv", arguments):
                self.assertEqual(main(), 0)
            header = output.read_text(encoding="utf-8")
            self.assertIn("builtin_mod_manifest_available = false", header)

    def test_check_mode_is_non_mutating_and_detects_stale_output(self) -> None:
        with tempfile.TemporaryDirectory() as temp_dir:
            root = Path(temp_dir)
            source = root / "mods"
            (source / "minimal").mkdir(parents=True)
            (source / "minimal" / "main.lua").write_text(
                "return true", encoding="utf-8"
            )
            output = root / "builtin_mods_generated.h"
            output.write_text("stale", encoding="utf-8")
            arguments = [
                "generate_builtin_mods.py",
                "--source",
                str(source),
                "--output",
                str(output),
                "--check",
            ]
            with patch.object(sys, "argv", arguments):
                self.assertEqual(main(), 1)
            self.assertEqual(output.read_text(encoding="utf-8"), "stale")

            arguments.remove("--check")
            with patch.object(sys, "argv", arguments):
                self.assertEqual(main(), 0)
            arguments.append("--check")
            with patch.object(sys, "argv", arguments):
                self.assertEqual(main(), 0)


if __name__ == "__main__":
    unittest.main()
