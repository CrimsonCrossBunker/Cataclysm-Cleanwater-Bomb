from __future__ import annotations

import contextlib
import copy
import io
import json
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

try:
    from . import inspect_state
except ImportError:
    import inspect_state


def saved_state() -> dict:
    return {
        "version": 1, "scope": "character",
        "mods": {"tonic": {
            "values": {"cooldown": {"type": "integer", "value": 42}},
            "tasks": [{
                "id": 3, "handler": "restore", "due_turn": 80,
                "payload_version": 1, "payload": {},
                "actor_character_id": 12,
                "participants": [{"role": "target", "kind": "character",
                                  "stable_id": 12, "pending": True}],
            }],
        }},
    }


class StateInspectorTests(unittest.TestCase):
    def test_snapshot_preserves_identity_and_legacy_interval_default(self):
        snapshot = saved_state()
        original = copy.deepcopy(snapshot)
        report = inspect_state.summarize(snapshot)
        row = report["mods"][0]
        self.assertEqual(row["mod"], "tonic")
        self.assertEqual(row["state"], [
            {"key": "cooldown", "type": "integer"}])
        task = row["tasks"][0]
        self.assertEqual(task["id"], 3)
        self.assertEqual(task["interval_turns"], 0)
        self.assertEqual(task["actor"], {"actor_character_id": 12})
        self.assertTrue(task["participants"][0]["pending"])
        self.assertEqual(snapshot, original)

    def test_values_are_opt_in_and_counts_survive_truncation(self):
        snapshot = saved_state()
        snapshot["mods"]["tonic"]["values"]["active"] = {
            "type": "boolean", "value": True,
        }
        report = inspect_state.summarize(snapshot, limit=1, show_values=True)
        row = report["mods"][0]
        self.assertEqual(row["state_count"], 2)
        self.assertEqual(row["state"], [
            {"key": "active", "type": "boolean", "value": True}])

    def test_mod_filter_does_not_drop_unknown_saved_owners(self):
        snapshot = saved_state()
        snapshot["mods"]["uninstalled-mod"] = {"values": {}, "tasks": []}
        report = inspect_state.summarize(snapshot, mod="uninstalled-mod")
        self.assertEqual([row["mod"] for row in report["mods"]],
                         ["uninstalled-mod"])
        with self.assertRaisesRegex(ValueError, "absent"):
            inspect_state.summarize(snapshot, mod="missing")

    def test_invalid_task_identity_and_owner_are_reported(self):
        for field, value in (("id", True), ("id", 0),
                             ("owner_mod_id", "another-mod"),
                             ("interval_turns", -1),
                             ("payload_version", 0)):
            with self.subTest(field=field, value=value):
                snapshot = saved_state()
                snapshot["mods"]["tonic"]["tasks"][0][field] = value
                with self.assertRaises(ValueError):
                    inspect_state.summarize(snapshot)

    def test_duplicate_tasks_and_typed_value_mismatch_are_rejected(self):
        snapshot = saved_state()
        tasks = snapshot["mods"]["tonic"]["tasks"]
        tasks.append(copy.deepcopy(tasks[0]))
        with self.assertRaisesRegex(ValueError, "duplicate task"):
            inspect_state.summarize(snapshot)
        snapshot = saved_state()
        snapshot["mods"]["tonic"]["values"]["cooldown"]["value"] = False
        with self.assertRaisesRegex(ValueError, "invalid 'integer'"):
            inspect_state.summarize(snapshot)

    def test_cli_is_read_only_and_rejects_ambiguous_json(self):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "save.lua_platform.json"
            original = json.dumps(saved_state()).encode()
            path.write_bytes(original)
            with contextlib.redirect_stdout(io.StringIO()) as stdout:
                self.assertEqual(inspect_state.main([str(path)]), 0)
            self.assertEqual(
                json.loads(stdout.getvalue())["scope"], "character")
            self.assertEqual(path.read_bytes(), original)
            path.write_text('{"version":1,"version":2}', encoding="utf-8")
            with self.assertRaisesRegex(ValueError, "duplicate JSON"):
                inspect_state.read_snapshot(path)
            path.write_bytes(original)
            with patch.object(inspect_state, "MAX_FILE_BYTES", 8):
                with self.assertRaisesRegex(ValueError, "exceeds"):
                    inspect_state.read_snapshot(path)


if __name__ == "__main__":
    unittest.main()
