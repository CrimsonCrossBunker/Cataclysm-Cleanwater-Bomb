"""Focused safety and end-to-end smoke checks for the offline EOC converter."""

from __future__ import annotations

import json
import subprocess
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

import migrate_lua_first


class LuaFirstMigrationTest(unittest.TestCase):
    def test_game_start_avatar_proof_tracks_the_canonical_sender_set(self) -> None:
        self.assertEqual(
            migrate_lua_first.game_start_sender_sites(),
            migrate_lua_first.EXPECTED_GAME_START_SENDER_SITES,
        )
        self.assertTrue(
            migrate_lua_first.game_start_avatar_actor_is_proven(False)
        )
        self.assertFalse(
            migrate_lua_first.game_start_avatar_actor_is_proven(True)
        )

        with tempfile.TemporaryDirectory() as temporary:
            with patch.object(
                migrate_lua_first, "REPOSITORY_ROOT", Path(temporary)
            ):
                migrate_lua_first.game_start_sender_sites.cache_clear()
                self.assertFalse(
                    migrate_lua_first.game_start_avatar_actor_is_proven(False)
                )
        migrate_lua_first.game_start_sender_sites.cache_clear()

    def test_game_start_avatar_proof_rejects_additional_senders(self) -> None:
        self.addCleanup(migrate_lua_first.game_start_sender_sites.cache_clear)
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            (root / "src").mkdir()
            (root / "src/game.cpp").write_text(
                "events.send<event_type::game_start>();\n", encoding="utf-8"
            )
            for constructor in ("send", "make"):
                with self.subTest(constructor=constructor):
                    (root / "src/other.cpp").write_text(
                        f"events.{constructor}<event_type::game_start>();\n",
                        encoding="utf-8",
                    )
                    with patch.object(migrate_lua_first, "REPOSITORY_ROOT", root):
                        migrate_lua_first.game_start_sender_sites.cache_clear()
                        self.assertEqual(
                            migrate_lua_first.game_start_sender_sites(),
                            (("src/game.cpp", "send"),
                             ("src/other.cpp", constructor)),
                        )
                        self.assertFalse(
                            migrate_lua_first.game_start_avatar_actor_is_proven(False)
                        )

    def test_directory_discovery_prunes_build_caches(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            (root / "content").mkdir()
            (root / "content" / "item.json").write_text(
                '{"type":"GENERIC","id":"kept"}', encoding="utf-8"
            )
            (root / "obj-lua").mkdir()
            (root / "obj-lua" / "cached.json").write_text(
                "not valid JSON and must never be read", encoding="utf-8"
            )

            objects = migrate_lua_first.load_objects([root])
            self.assertEqual([entry.value["id"] for entry in objects], ["kept"])

    def test_loader_accepts_game_json_comments_and_trailing_commas(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                """[
  // Real game data permits comments.
  { "type": "GENERIC", "id": "kept", },
]
""",
                encoding="utf-8",
            )
            objects = migrate_lua_first.load_objects([source])
            self.assertEqual([entry.value["id"] for entry in objects], ["kept"])

    def test_mod_info_and_literal_item_shapes_are_audited_as_bounded(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "MOD_INFO",
                            "id": "bounded_mod",
                            "name": "Bounded Mod",
                            "version": "1.2.3",
                            "dependencies": ["dda"],
                            "core": False,
                        },
                        {
                            "type": "ITEM",
                            "id": "bounded_item",
                            "name": "bounded item",
                        },
                    ]
                ),
                encoding="utf-8",
            )

            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "bounded_mod"
            )
            metadata = result.files[Path("mod.lua")]
            main = result.files[Path("main.lua")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(len(result.partial), 0)
            self.assertIn('id = "bounded_mod"', metadata)
            self.assertIn('name = "Bounded Mod"', metadata)
            self.assertIn('version = "1.2.3"', metadata)
            self.assertIn('dependencies = { "dda" }', metadata)
            self.assertIn("core = false", metadata)
            self.assertIn("content.Item", main)
            self.assertIn('id = "bounded_item"', main)

    def test_check_mode_is_non_mutating_and_detects_stale_output(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            result = migrate_lua_first.MigrationResult(
                files={Path("main.lua"): "return true\n"}
            )
            self.assertFalse(
                migrate_lua_first.write_result(result, root, force=False, check=True)
            )
            self.assertFalse((root / "main.lua").exists())
            self.assertTrue(
                migrate_lua_first.write_result(result, root, force=False, check=False)
            )
            self.assertTrue(
                migrate_lua_first.write_result(result, root, force=False, check=True)
            )

    def test_refusal_to_overwrite_is_preflighted_before_any_write(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            (root / "z-existing.lua").write_text("author data\n", encoding="utf-8")
            result = migrate_lua_first.MigrationResult(
                files={
                    Path("a-new.lua"): "new\n",
                    Path("z-existing.lua"): "replacement\n",
                }
            )
            with self.assertRaisesRegex(ValueError, "refusing to overwrite"):
                migrate_lua_first.write_result(
                    result, root, force=False, check=False
                )
            self.assertFalse((root / "a-new.lua").exists())
            self.assertEqual(
                (root / "z-existing.lua").read_text(encoding="utf-8"),
                "author data\n",
            )

    def test_output_file_is_rejected_before_writing(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            output = Path(temporary) / "owned"
            output.write_text("author data\n", encoding="utf-8")
            result = migrate_lua_first.MigrationResult(
                files={Path("main.lua"): "return true\n"}
            )
            with self.assertRaisesRegex(ValueError, "not a directory"):
                migrate_lua_first.write_result(
                    result, output, force=True, check=False
                )
            self.assertEqual(
                output.read_text(encoding="utf-8"), "author data\n"
            )

    def test_force_install_rolls_back_every_file_after_failure(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            output = Path(temporary) / "migration"
            output.mkdir()
            (output / "a.lua").write_text("old a\n", encoding="utf-8")
            (output / "b.lua").write_text("old b\n", encoding="utf-8")
            result = migrate_lua_first.MigrationResult(
                files={
                    Path("a.lua"): "new a\n",
                    Path("b.lua"): "new b\n",
                }
            )
            real_install = migrate_lua_first._install_staged_file
            calls = 0

            def fail_second(source: Path, destination: Path) -> None:
                nonlocal calls
                calls += 1
                if calls == 2:
                    raise OSError("install failed")
                real_install(source, destination)

            with patch(
                "migrate_lua_first._install_staged_file",
                side_effect=fail_second,
            ):
                with self.assertRaisesRegex(OSError, "install failed"):
                    migrate_lua_first.write_result(
                        result, output, force=True, check=False
                    )
            self.assertEqual(
                (output / "a.lua").read_text(encoding="utf-8"), "old a\n"
            )
            self.assertEqual(
                (output / "b.lua").read_text(encoding="utf-8"), "old b\n"
            )

    def test_unconverted_eoc_guards_stop_effects_before_execution(self) -> None:
        for gate, raw_gate in (
            ("condition", "unsupported_native_condition"),
            ("deactivate_condition", "unsupported_native_condition"),
        ):
            with self.subTest(gate=gate):
                source = migrate_lua_first.SourceObject(
                    Path("source.json"), 0, {
                        "type": "effect_on_condition", "id": "unknown_guard",
                        "eoc_type": "EVENT",
                        "required_event": "character_melee_attacks_character",
                        gate: raw_gate,
                        "effect": {"message": "must not execute"},
                    },
                )
                result = migrate_lua_first.MigrationResult()
                rendered = migrate_lua_first.render_eoc(source, result)
                self.assertIn("    do return false end", rendered)
                self.assertLess(
                    rendered.index("    do return false end"),
                    rendered.index("services.message("),
                )
                self.assertTrue(result.todos)
                script = """
local calls = 0
local services = { message = function() calls = calls + 1 end }
local runtime = { handler = function() end, on = function() end }
local migrated_eoc_functions = {}
RENDERED
assert(migrated_eoc_unknown_guard({ actors = { attacker = {} } }) == false)
assert(calls == 0)
""".replace("RENDERED", rendered)
                run = subprocess.run(
                    ["lua", "-"], input=script, text=True,
                    capture_output=True, timeout=10,
                )
                self.assertEqual(run.returncode, 0, run.stderr)


if __name__ == "__main__":
    unittest.main()
