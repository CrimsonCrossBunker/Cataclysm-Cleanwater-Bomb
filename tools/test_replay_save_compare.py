from contextlib import redirect_stdout
import copy
import io
import json
from pathlib import Path
import tempfile
import unittest

import replay_save_compare as compare


def player():
    return {"player": {"traits": ["STRONG", "QUICK"], "hp": 100,
                       "local_player_id": "abc",
                       "inventory": ["rope", "knife"]},
            "achievements_tracker": {"initial_achievements": ["one", "two"]},
            "player_messages": {"messages": ["first", "second"]}}


def memory():
    return {"version": 1, "data": [[[144, 46, "t_floor", 0, 0]]] + [None] * 63}


class PersistedStateTest(unittest.TestCase):
    def test_only_proven_player_sets_ignore_order(self):
        a, b = player(), player()
        b["player"]["traits"].reverse()
        b["achievements_tracker"]["initial_achievements"].reverse()
        before = copy.deepcopy(b)
        self.assertTrue(compare.compare_documents("player", a, b)["match"])
        self.assertEqual(b, before)
        self.assertFalse(compare.compare_documents("json", a, b)["match"])

    def test_player_values_identity_messages_and_arrays_remain_significant(
            self):
        changes = [("hp", 99), ("local_player_id", "different"),
                   ("traits", ["QUICK"]), ("inventory", ["knife", "rope"])]
        for key, value in changes:
            with self.subTest(key=key):
                a, b = player(), player()
                b["player"][key] = value
                self.assertFalse(compare.compare_documents(
                    "player", a, b)["match"])
        a, b = player(), player()
        b["player_messages"]["messages"].reverse()
        self.assertFalse(compare.compare_documents("player", a, b)["match"])
        b = player()
        b["new_unknown_field"] = None
        self.assertEqual(
            compare.compare_documents("player", a, b)["differences"],
            [{"path": "/new_unknown_field", "reason": "missing"}])

    def test_set_corruption_fails_instead_of_being_deduplicated(self):
        for bad in (["QUICK", "QUICK"], ["QUICK", 1], {}, [None], "QUICK"):
            with self.subTest(bad=bad):
                a = player()
                a["player"]["traits"] = bad
                with self.assertRaises(ValueError):
                    compare.compare_documents("player", a, a)

    def test_npc_order_and_state_remain_significant(self):
        a = {"npcs": [{"id": 1, "traits": ["a", "b"]}, {"id": 2}]}
        b = copy.deepcopy(a)
        b["npcs"][0]["traits"].reverse()
        self.assertTrue(compare.compare_documents("overmap", a, b)["match"])
        b["npcs"].reverse()
        self.assertFalse(compare.compare_documents("overmap", a, b)["match"])
        b = copy.deepcopy(a)
        b["npcs"][1]["id"] = 3
        self.assertFalse(compare.compare_documents("overmap", a, b)["match"])

    def test_autonotes_preserve_membership_and_unknown_state(self):
        a = {"enabled": ["a", "b"], "discovered": ["c"], "custom": [1, 2]}
        b = copy.deepcopy(a)
        b["enabled"].reverse()
        self.assertTrue(compare.compare_documents("autonotes", a, b)["match"])
        b["custom"].reverse()
        self.assertFalse(compare.compare_documents("autonotes", a, b)["match"])
        b = copy.deepcopy(a)
        b["discovered"] = []
        self.assertFalse(compare.compare_documents("autonotes", a, b)["match"])

    def test_json_types_keys_and_versions_are_not_erased(self):
        for a, b in [(1, True), (1, 1.0), ({"version": 1}, {"version": 2}),
                     ({"a": None}, {}), ([1, 2], [2, 1])]:
            with self.subTest(a=a, b=b):
                self.assertFalse(
                    compare.compare_documents("json", a, b)["match"])
        self.assertTrue(compare.compare_documents("json", {"a": 1, "b": 2},
                                                  {"b": 2, "a": 1})["match"])
        result = compare.compare_documents("json", {"a~/b": 1}, {"a~/b": 2})
        self.assertEqual(result["differences"][0]["path"], "/a~0~1b")

    def test_diagnostic_output_is_bounded_without_accepting_a_mismatch(self):
        result = compare.compare_documents(
            "json", list(range(1000)), [-1] * 1000)
        self.assertFalse(result["match"])
        self.assertTrue(result["truncated"])
        self.assertEqual(len(result["differences"]), compare.MAX_DIFFERENCES)


class MemoryStateTest(unittest.TestCase):
    def test_rle_partition_and_omitted_empty_decoration_are_storage_only(self):
        a, b = memory(), memory()
        b["data"][0] = [[72, 46, "t_floor", 0, 0, "", 0, 0]] * 2
        self.assertTrue(compare.compare_documents("map-memory", a, b)["match"])

    def test_each_tile_field_and_position_are_preserved(self):
        for index, value in ((1, 35), (2, "t_wall"), (3, 1), (4, 1),
                             (5, "f_chair"), (6, 1), (7, 1)):
            with self.subTest(index=index):
                a, b = memory(), memory()
                b["data"][0] = [[1, 46, "t_floor", 0, 0, "", 0, 0],
                                [143, 46, "t_floor", 0, 0]]
                b["data"][0][0][index] = value
                result = compare.compare_documents("map-memory", a, b)
                self.assertFalse(result["match"])
                self.assertEqual(len(result["differences"]), 1)
        b = memory()
        b["data"].reverse()
        self.assertFalse(compare.compare_documents(
            "map-memory", memory(), b)["match"])

    def test_unknown_fields_and_allocated_submaps_are_not_dropped(self):
        b = memory()
        b["extension"] = 7
        self.assertFalse(compare.compare_documents(
            "map-memory", memory(), b)["match"])
        b = memory()
        b["data"][1] = [[144, 0, "", 0, 0]]
        self.assertFalse(compare.compare_documents(
            "map-memory", memory(), b)["match"])

    def test_malformed_or_unsupported_memory_fails_closed(self):
        bad = [{"version": True, "data": memory()["data"]},
               {"version": 0, "data": memory()["data"]},
               {"version": 1, "data": []}]
        for run in ([], [0, 46, "floor", 0, 0], [145, 46, "floor", 0, 0],
                    [143, 46, "floor", 0, 0], [True, 46, "floor", 0, 0],
                    [144, True, "floor", 0, 0], [144, 46, 42, 0, 0],
                    [144, 46, "floor", 128, 0], [144, 46, "floor", 0, 0, "x"]):
            value = memory()
            value["data"][0] = [run]
            bad.append(value)
        for value in bad:
            with self.subTest(value=value), self.assertRaises(ValueError):
                compare.compare_documents("map-memory", value, value)


class InputAndCliTest(unittest.TestCase):
    def test_cli_equal_different_invalid_and_nonmutating(self):
        with tempfile.TemporaryDirectory() as directory:
            a, b = Path(directory) / "a.json", Path(directory) / "b.json"
            a.write_text('# version 34\n{"hp":100}\n')
            for content, code in (("{\"hp\":100}", 0), ("{\"hp\":99}", 1),
                                  ("{\"hp\":1,\"hp\":2}",
                                   2), ("{\"hp\":NaN}", 2),
                                  ("{\"hp\":1e999}", 2), ("not JSON", 2)):
                b.write_text('# version 34\n' + content)
                before = (a.read_bytes(), b.read_bytes())
                output = io.StringIO()
                with self.subTest(content=content), redirect_stdout(output):
                    self.assertEqual(compare.main(
                        ["--kind", "json", str(a), str(b)]), code)
                self.assertEqual((a.read_bytes(), b.read_bytes()), before)
                self.assertEqual(json.loads(output.getvalue())
                                 ["schema_version"], 1)

    def test_cli_preserves_save_version_header(self):
        with tempfile.TemporaryDirectory() as directory:
            a, b = Path(directory) / "a", Path(directory) / "b"
            a.write_text('# version 34\n{"hp":100}')
            for prefix in ("", "# version 35\n"):
                b.write_text(prefix + '{"hp":100}')
                output = io.StringIO()
                with redirect_stdout(output):
                    self.assertEqual(compare.main(
                        ["--kind", "json", str(a), str(b)]), 1)
                report = json.loads(output.getvalue())
                self.assertFalse(report["match"])
                self.assertFalse(report["preamble_match"])

    def test_protected_cache_symlinks_large_and_deep_inputs_are_rejected(self):
        with self.assertRaises(ValueError):
            compare.read_document(Path("obj-lua") / "not-opened")
        with tempfile.TemporaryDirectory() as directory:
            target = Path(directory) / "target"
            target.write_text("{}")
            link = Path(directory) / "link"
            link.symlink_to(target)
            with self.assertRaises(ValueError):
                compare.read_document(link)
            with target.open("wb") as stream:
                stream.truncate(compare.MAX_BYTES + 1)
            with self.assertRaises(ValueError):
                compare.read_document(target)
        value = None
        for _ in range(130):
            value = [value]
        with self.assertRaises(ValueError):
            compare.compare_documents("json", value, value)


if __name__ == "__main__":
    unittest.main()
