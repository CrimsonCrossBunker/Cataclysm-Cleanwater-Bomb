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
                                  "stable_id": 12, "pending": True, "hint_scope": "npc",
                                  "hint_x": 0, "hint_y": 0, "hint_z": 0}],
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

    def test_saved_task_counter_and_legacy_pending_id_fallback(self):
        snapshot = saved_state()
        legacy = inspect_state.summarize(snapshot)["mods"][0]
        self.assertEqual(legacy["last_task_id"], 3)
        self.assertFalse(legacy["task_counter_persisted"])
        record = snapshot["mods"]["tonic"]
        record["last_task_id"] = 77
        saved = inspect_state.summarize(snapshot)["mods"][0]
        self.assertEqual(saved["last_task_id"], 77)
        self.assertTrue(saved["task_counter_persisted"])
        for invalid in (-1, True, 2**63, 3.5, 2):
            record["last_task_id"] = invalid
            with self.subTest(counter=invalid), self.assertRaisesRegex(
                    ValueError, "last_task_id"):
                inspect_state.summarize(snapshot)
        record["tasks"] = []
        record["last_task_id"] = 2**63 - 1
        self.assertEqual(inspect_state.summarize(snapshot)["mods"][0]["last_task_id"],
                         2**63 - 1)

    def test_actor_reports_known_identity_and_hints_only(self):
        snapshot = saved_state()
        task = snapshot["mods"]["tonic"]["tasks"][0]
        del task["actor_character_id"]
        actor = {"actor_item_uid": 99, "actor_item_pending": True,
                 "actor_item_hint_scope": "map", "actor_item_hint_x": -4,
                 "actor_item_hint_y": 5, "actor_item_hint_z": 0}
        task.update(actor, actor_unrecognized={"large": ["not native actor data"]})
        report = inspect_state.summarize(snapshot)
        self.assertEqual(report["mods"][0]["tasks"][0]["actor"], actor)

    def test_malformed_actor_records_report_the_task_location(self):
        cases = [
            {"actor_character_id": True},
            {"actor_character_id": 2**31},
            {"actor_character_id": 1, "actor_item_uid": 2},
            {"actor_item_uid": 0},
            {"actor_item_pending": True},
            {"actor_item_uid": 1, "actor_item_hint_x": 0},
            {"actor_monster_uid": 2, "actor_monster_pending": "yes"},
        ]
        for actor in cases:
            with self.subTest(actor=actor):
                snapshot = saved_state()
                task = snapshot["mods"]["tonic"]["tasks"][0]
                del task["actor_character_id"]
                task.update(actor)
                with self.assertRaisesRegex(ValueError, r"tonic\.tasks\[0\]"):
                    inspect_state.summarize(snapshot)

    def test_mod_filter_does_not_drop_unknown_saved_owners(self):
        snapshot = saved_state()
        snapshot["mods"]["uninstalled-mod"] = {"values": {}, "tasks": []}
        report = inspect_state.summarize(snapshot, mod="uninstalled-mod")
        self.assertEqual([row["mod"] for row in report["mods"]],
                         ["uninstalled-mod"])
        with self.assertRaisesRegex(ValueError, "absent"):
            inspect_state.summarize(snapshot, mod="missing")

    def test_mod_list_is_bounded_with_total_and_filtered_counts(self):
        snapshot = saved_state()
        snapshot["mods"]["another"] = {"values": {}, "tasks": []}
        report = inspect_state.summarize(snapshot, limit=1)
        self.assertEqual(report["mod_count"], 2)
        self.assertEqual(report["matched_mod_count"], 2)
        self.assertEqual(len(report["mods"]), 1)
        self.assertEqual(report["mods"][0]["mod"], "another")
        report = inspect_state.summarize(snapshot, mod="tonic", limit=1)
        self.assertEqual(report["mod_count"], 2)
        self.assertEqual(report["matched_mod_count"], 1)
        self.assertEqual(report["mods"][0]["mod"], "tonic")

    def test_task_filter_reaches_entries_beyond_the_display_limit(self):
        snapshot = saved_state()
        record = snapshot["mods"]["tonic"]
        template = record["tasks"][0]
        record["tasks"] = [dict(template, id=number) for number in range(1, 251)]
        row = inspect_state.summarize(snapshot, mod="tonic", limit=1, task_id=225)["mods"][0]
        self.assertEqual(row["task_count"], 250)
        self.assertEqual(row["matched_task_count"], 1)
        self.assertEqual([task["id"] for task in row["tasks"]], [225])
        with self.assertRaisesRegex(ValueError, "requires --mod"):
            inspect_state.summarize(snapshot, task_id=225)
        with self.assertRaisesRegex(ValueError, "task 999 is absent"):
            inspect_state.summarize(snapshot, mod="tonic", task_id=999)
        for invalid in (0, -1, True, 2**63):
            with self.subTest(task_id=invalid), self.assertRaisesRegex(ValueError, "positive"):
                inspect_state.summarize(snapshot, mod="tonic", task_id=invalid)

    def test_invalid_task_identity_and_owner_are_reported(self):
        for field, value in (("id", True), ("id", 0),
                             ("owner_mod_id", "another-mod"),
                             ("interval_turns", -1),
                             ("payload_version", 0), ("payload_version", 2**31)):
            with self.subTest(field=field, value=value):
                snapshot = saved_state()
                snapshot["mods"]["tonic"]["tasks"][0][field] = value
                with self.assertRaises(ValueError):
                    inspect_state.summarize(snapshot)

    def test_participant_diagnostics_identify_the_bad_record(self):
        for field, value in (("hint_x", True), ("hint_scope", "a\0b"),
                             ("stable_id", 2**31), ("pending", "yes"),
                             ("kind", "unknown")):
            with self.subTest(field=field):
                snapshot = saved_state()
                participant = snapshot["mods"]["tonic"]["tasks"][0]["participants"][0]
                participant[field] = value
                with self.assertRaisesRegex(ValueError, r"tonic.tasks\[0\].participants\[0\]"):
                    inspect_state.summarize(snapshot)
        snapshot = saved_state()
        participants = snapshot["mods"]["tonic"]["tasks"][0]["participants"]
        participants.append(copy.deepcopy(participants[0]))
        with self.assertRaisesRegex(ValueError, "repeated participant role"):
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
