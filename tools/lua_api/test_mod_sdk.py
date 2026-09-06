"""SDK snapshots and author diagnostics with an optional real LuaLS gate."""

from __future__ import annotations

import json
import os
import shutil
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

try:
    from . import mod_sdk
except ImportError:
    import mod_sdk

ROOT = Path(__file__).resolve().parents[2]
DECLARATIONS = '''---@meta
---@class CcbPlatformV1
---@field runtime Runtime
---@class Runtime
local Runtime = {}
---@param name string
function Runtime.hello(name) end
---@type CcbPlatformV1
local ccb = {}
return ccb
'''


class ModSdkTest(unittest.TestCase):
    def make_sdk(
        self, root: Path, name: str, text: str = DECLARATIONS,
    ) -> Path:
        source = root / (name + ".d.lua")
        source.write_text(text, encoding="utf-8")
        mod = root / name
        mod.mkdir()
        mod_sdk.write_editor_files(mod, source)
        return mod

    def test_snapshot_survives_source_changes_and_project_move(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            mod = self.make_sdk(root, "before")
            (root / "before.d.lua").write_text("changed", encoding="utf-8")
            moved = root / "moved"
            shutil.move(mod, moved)
            metadata, text = mod_sdk.read_sdk(moved)
            self.assertEqual(text, DECLARATIONS)
            self.assertEqual(metadata["platform_version"], 1)
            settings = json.loads((moved / ".luarc.json").read_text())
            library = moved / settings["workspace.library"][0]
            self.assertTrue(library.is_dir())

    def test_tampered_declarations_are_rejected(self):
        with tempfile.TemporaryDirectory() as directory:
            mod = self.make_sdk(Path(directory), "example")
            (mod / ".ccb-sdk/ccb.lua").write_text(
                "tampered", encoding="utf-8"
            )
            with self.assertRaisesRegex(ValueError, "checksum"):
                mod_sdk.read_sdk(mod)

    def test_compare_reports_types_removals_and_additions_without_writes(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            before = self.make_sdk(root, "before")
            after = self.make_sdk(root, "after", DECLARATIONS.replace(
                "---@param name string", "---@param name integer"
            ).replace(
                "---@field runtime Runtime", "---@field service Runtime"
            ))
            saved = (before / ".ccb-sdk/ccb.lua").read_bytes()
            report = mod_sdk.compare_sdks(before, after)
            self.assertIn("Runtime.hello", report["changed"])
            self.assertEqual(
                report["removed"], ["CcbPlatformV1.runtime"]
            )
            self.assertEqual(report["added"], ["CcbPlatformV1.service"])
            self.assertEqual((before / ".ccb-sdk/ccb.lua").read_bytes(), saved)

    def test_source_line_movement_does_not_change_signatures(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            before = self.make_sdk(root, "before")
            after = self.make_sdk(root, "after", "-- comment\n" + DECLARATIONS)
            report = mod_sdk.compare_sdks(before, after)
            self.assertEqual(report["changed"], {})
            self.assertNotEqual(report["old"]["declarations_sha256"],
                                report["new"]["declarations_sha256"])

    def test_checker_crash_is_not_a_clean_report(self):
        with tempfile.TemporaryDirectory() as directory:
            mod = self.make_sdk(Path(directory), "example")

            def crash(command, **kwargs):
                log = next(x.split("=", 1)[1] for x in command
                           if x.startswith("--logpath="))
                (Path(log) / "check.json").write_text("[]", encoding="utf-8")
                return subprocess.CompletedProcess(command, -11, "", "crash")

            with patch.object(mod_sdk.subprocess, "run", side_effect=crash):
                with self.assertRaisesRegex(RuntimeError, "exited -11"):
                    mod_sdk.check_mod(mod, "luals")


@unittest.skipUnless(
    os.environ.get("CCB_LUALS"), "set CCB_LUALS for editor gate"
)
class LuaLanguageServerIntegrationTest(unittest.TestCase):
    def scaffold(self, root: Path, template: str) -> Path:
        mod = root / template
        subprocess.run(
            [sys.executable, str(ROOT / "tools/create_lua_mod.py"),
             str(mod), "--template", template], check=True,
            capture_output=True, text=True,
        )
        return mod

    def test_both_templates_are_clean_in_real_language_server(self):
        with tempfile.TemporaryDirectory() as directory:
            for template in ("minimal", "complete"):
                with self.subTest(template=template):
                    mod = self.scaffold(Path(directory), template)
                    self.assertEqual(
                        mod_sdk.check_mod(mod, os.environ["CCB_LUALS"]), []
                    )

    def test_real_errors_have_file_line_expected_type_and_api_name(self):
        with tempfile.TemporaryDirectory() as directory:
            mod = self.scaffold(Path(directory), "minimal")
            invalid = mod / "invalid.lua"
            invalid.write_text('''local ccb = require("ccb")
ccb.runtime.handler("bad", "not a function")
ccb.runtime.nonexistent_api()
ccb.presentation.confirm(123)
ccb.runtime.handler()
''', encoding="utf-8")
            report = "\n".join(
                mod_sdk.check_mod(mod, os.environ["CCB_LUALS"])
            )
            self.assertIn(str(invalid) + ":2:", report)
            self.assertIn("param-type-mismatch", report)
            self.assertIn("fun(payload: any):any", report)
            self.assertIn(str(invalid) + ":3:", report)
            self.assertIn("nonexistent_api", report)
            self.assertIn(str(invalid) + ":5:", report)
            self.assertIn("missing-parameter", report)
            result = subprocess.run(
                [sys.executable, str(ROOT / "tools/lua_api/mod_sdk.py"),
                 "check", str(mod), "--language-server",
                 os.environ["CCB_LUALS"]],
                capture_output=True, text=True,
            )
            self.assertEqual(result.returncode, 1, result.stderr)


if __name__ == "__main__":
    unittest.main()
