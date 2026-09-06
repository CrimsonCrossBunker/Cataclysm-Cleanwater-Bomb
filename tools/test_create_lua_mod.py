import tempfile
import json
import unittest
from pathlib import Path
from unittest.mock import patch

import create_lua_mod
from create_lua_mod import create_mod


class CreateLuaModTest(unittest.TestCase):
    def test_minimal_template_has_only_root_lua_entry(self):
        with tempfile.TemporaryDirectory() as directory:
            target = Path(directory) / "example"
            create_mod(target, "minimal")
            self.assertTrue((target / "main.lua").is_file())
            self.assertFalse((target / "manifest.json").exists())
            self.assertFalse((target / "modinfo.json").exists())
            self.assertFalse((target / "lua").exists())

    def test_complete_template_is_zero_json_and_has_vertical_slice(self):
        with tempfile.TemporaryDirectory() as directory:
            target = Path(directory) / "complete"
            create_mod(target, "complete", editor=False)
            files = [path for path in target.rglob("*") if path.is_file()]
            self.assertTrue((target / "runtime" / "behaviour.lua").is_file())
            self.assertTrue((target / "content" / "token.lua").is_file())
            self.assertFalse(any(path.suffix == ".json" for path in files))
            source = "\n".join(
                path.read_text(encoding="utf-8")
                for path in files
                if path.suffix == ".lua"
            )
            self.assertIn("ccb.content.Item", source)
            self.assertIn("ccb.content.Recipe", source)
            self.assertNotIn("run_eoc", source)
            self.assertIn(
                'local MOD_ID = "complete"',
                (target / "content" / "token.lua").read_text(encoding="utf-8"),
            )

    def test_nonempty_target_is_never_overwritten(self):
        with tempfile.TemporaryDirectory() as directory:
            target = Path(directory) / "owned"
            target.mkdir()
            sentinel = target / "main.lua"
            sentinel.write_text("author owned\n", encoding="utf-8")
            with self.assertRaises(FileExistsError):
                create_mod(target, "complete")
            self.assertEqual(
                sentinel.read_text(encoding="utf-8"), "author owned\n"
            )

    def test_default_editor_library_is_portable_and_not_runtime_content(self):
        with tempfile.TemporaryDirectory() as directory:
            target = Path(directory) / "editor_mod"
            create_mod(target, "minimal")
            settings = json.loads((target / ".luarc.json").read_text())
            self.assertEqual(settings["runtime.version"], "Lua 5.4")
            self.assertEqual(settings["workspace.library"], [".ccb-sdk"])
            self.assertEqual(
                (target / ".ccb-sdk/ccb.lua").read_bytes(),
                create_lua_mod.DEFAULT_DECLARATIONS.read_bytes(),
            )
            self.assertNotIn(".ccb-sdk", (target / "main.lua").read_text())

    def test_missing_sdk_input_preserves_empty_target(self):
        with tempfile.TemporaryDirectory() as directory:
            target = Path(directory) / "editor_mod"
            target.mkdir()
            with self.assertRaises(FileNotFoundError):
                create_mod(target, "minimal", declarations=target / "missing")
            self.assertEqual(list(target.iterdir()), [])
            self.assertEqual(list(target.parent.iterdir()), [target])

    def test_file_target_is_never_replaced(self):
        with tempfile.TemporaryDirectory() as directory:
            target = Path(directory) / "owned"
            target.write_text("author owned\n", encoding="utf-8")
            with self.assertRaises(FileExistsError):
                create_mod(target, "minimal")
            self.assertEqual(
                target.read_text(encoding="utf-8"), "author owned\n"
            )

    def test_symlink_target_is_never_replaced(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            owned = root / "owned"
            owned.mkdir()
            target = root / "linked_mod"
            target.symlink_to(owned, target_is_directory=True)
            with self.assertRaises(FileExistsError):
                create_mod(target, "minimal")
            self.assertTrue(target.is_symlink())
            self.assertEqual(list(owned.iterdir()), [])

    def test_invalid_directory_id_is_rejected_before_creating_target(self):
        with tempfile.TemporaryDirectory() as directory:
            target = Path(directory) / "invalid mod"
            with self.assertRaisesRegex(ValueError, "Mod id"):
                create_mod(target, "minimal")
            self.assertFalse(target.exists())

    def test_copy_failure_leaves_an_existing_empty_target_untouched(self):
        with tempfile.TemporaryDirectory() as directory:
            target = Path(directory) / "atomic_mod"
            target.mkdir()
            with patch(
                "create_lua_mod.render_template_file",
                side_effect=OSError("copy failed"),
            ):
                with self.assertRaisesRegex(OSError, "copy failed"):
                    create_mod(target, "complete")
            self.assertTrue(target.is_dir())
            self.assertEqual(list(target.iterdir()), [])

    def test_install_failure_restores_an_existing_empty_target(self):
        with tempfile.TemporaryDirectory() as directory:
            target = Path(directory) / "atomic_mod"
            target.mkdir()
            with patch(
                "create_lua_mod._install_staged_directory",
                side_effect=OSError("install failed"),
            ):
                with self.assertRaisesRegex(OSError, "install failed"):
                    create_mod(target, "complete")
            self.assertTrue(target.is_dir())
            self.assertFalse(target.is_symlink())
            self.assertEqual(list(target.iterdir()), [])

    def test_target_created_during_staging_is_preserved(self):
        with tempfile.TemporaryDirectory() as directory:
            target = Path(directory) / "raced_mod"
            real_render = create_lua_mod.render_template_file
            created = False

            def create_concurrent_target(
                source: Path, destination: Path, mod_id: str
            ) -> None:
                nonlocal created
                if not created:
                    target.mkdir()
                    created = True
                real_render(source, destination, mod_id)

            with patch(
                "create_lua_mod.render_template_file",
                side_effect=create_concurrent_target,
            ):
                with self.assertRaisesRegex(FileExistsError, "appeared"):
                    create_mod(target, "minimal")
            self.assertTrue(target.is_dir())
            self.assertEqual(list(target.iterdir()), [])


if __name__ == "__main__":
    unittest.main()
