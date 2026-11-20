import copy
import json
import unittest
from unittest import mock
from pathlib import Path

from jsonschema import Draft202012Validator

from tools.agent import check_lua_first_replacement_ledger as validator

from tools.agent.generate_lua_first_replacement_ledger import (
    INVENTORIES,
    TODO_CLASSIFICATIONS,
    build_ledger,
    classify_migration_todo,
    legacy_evidence,
    normalize_evidence,
)


class LuaFirstReplacementLedgerTest(unittest.TestCase):
    def test_primitive_evidence_does_not_claim_a_selector_migration(self):
        ledger = build_ledger()
        entry = next(
            value for value in ledger["entries"]
            if value["inventory"] == "eoc-conditions" and
            value["selector"] == "map_is_passable"
        )
        self.assertEqual(entry["status"], "primitive_available_unverified")
        entry["evidence"] = [
            path for path in entry["evidence"]
            if path != "tools/migrate_lua_first.py"
        ]
        with mock.patch.object(
            validator.yaml, "safe_load", return_value=ledger
        ):
            validator.check()
            # Advertising the complete selector still requires its migration.
            entry["status"] = "implemented_unverified"
            ledger["summary"]["primitive_available_unverified"] -= 1
            ledger["summary"]["implemented_unverified"] += 1
            with self.assertRaisesRegex(
                RuntimeError, "lacks migration evidence"
            ):
                validator.check()

    def test_primitive_evidence_still_requires_a_native_test(self):
        ledger = build_ledger()
        entry = next(
            value for value in ledger["entries"]
            if value["inventory"] == "eoc-conditions" and
            value["selector"] == "map_is_passable"
        )
        entry["evidence"] = [
            path for path in entry["evidence"] if not path.startswith("tests/")
        ]
        with mock.patch.object(
            validator.yaml, "safe_load", return_value=ledger
        ):
            with self.assertRaisesRegex(RuntimeError, "lacks Platform source"):
                validator.check()

    def test_schema_requires_each_todo_category_and_core_input_contract(self):
        schema_root = Path(__file__).resolve().parents[2] / "ai"
        schema_path = schema_root / "lua-first-replacement-ledger.schema.json"
        schema = json.loads(schema_path.read_text(encoding="utf-8"))
        generated = build_ledger()
        validator = Draft202012Validator(schema)

        self.assertEqual(list(validator.iter_errors(generated)), [])

        for category in TODO_CLASSIFICATIONS:
            duplicate = copy.deepcopy(generated)
            classifications = duplicate["migration_todo_policy"][
                "classifications"
            ]
            duplicate_index = next(
                index
                for index, entry in enumerate(classifications)
                if entry["id"] != category
            )
            classifications[duplicate_index]["id"] = category
            self.assertTrue(
                list(validator.iter_errors(duplicate)),
                category,
            )

        for category, expected in (
            ("platform_gap", False),
            ("auto_fix", True),
        ):
            mismatch = copy.deepcopy(generated)
            entry = next(
                item
                for item in mismatch["migration_todo_policy"][
                    "classifications"
                ]
                if item["id"] == category
            )
            entry["platform_core_input"] = expected
            self.assertTrue(
                list(validator.iter_errors(mismatch)),
                category,
            )

    def test_migration_todo_policy_is_orthogonal_and_conservative(self):
        policy = build_ledger()["migration_todo_policy"]
        self.assertEqual(policy["scope"], "individual_migration_todo")
        self.assertEqual(
            policy["orthogonal_to"],
            "selector_disposition_and_verification_status",
        )
        self.assertEqual(policy["unclassified"], "error")
        self.assertEqual(policy["platform_core_input"], "platform_gap")
        self.assertEqual(
            [entry["id"] for entry in policy["classifications"]],
            list(TODO_CLASSIFICATIONS),
        )
        self.assertEqual(
            [
                entry["id"]
                for entry in policy["classifications"]
                if entry["platform_core_input"]
            ],
            ["platform_gap"],
        )

    def test_migration_todo_classification_validates_all_categories(self):
        for category in TODO_CLASSIFICATIONS:
            self.assertEqual(classify_migration_todo(category), category)
        with self.assertRaisesRegex(
            ValueError, "unknown migration TODO classification"
        ):
            classify_migration_todo(None)
        with self.assertRaisesRegex(
            ValueError, "unknown migration TODO classification"
        ):
            classify_migration_todo("selector_todo")

    def test_verified_entries_require_final_gate_and_native_test_evidence(
        self,
    ):
        verified = [
            entry
            for entry in build_ledger()["entries"]
            if entry["status"]
            in ("implemented_verified", "bounded_implemented_verified")
        ]
        for entry in verified:
            self.assertEqual(entry["verification"], "final_semantic_gate")
            self.assertTrue(
                any(
                    Path(evidence).parts[0] == "tests" and
                    Path(evidence).suffix == ".cpp"
                    for evidence in entry["evidence"]
                ),
                entry,
            )

    def test_generator_uses_the_three_real_inventories(self):
        generated = build_ledger()
        self.assertEqual(
            {source["id"] for source in generated["sources"]},
            set(INVENTORIES),
        )
        self.assertTrue(
            all(source["entry_count"] > 0 for source in generated["sources"])
        )
        self.assertTrue(
            all("\\" not in source["path"] for source in generated["sources"])
        )
        self.assertTrue(
            all(
                "\\" not in path
                for entry in generated["entries"]
                for path in entry["evidence"]
            )
        )

    def test_entries_have_honest_source_only_evidence(self):
        generated = build_ledger()
        for entry in generated["entries"]:
            self.assertIn("verification", entry)
            self.assertNotIn(
                "cata" + "lua", " ".join(entry["evidence"]).lower()
            )
            self.assertNotIn(
                "ccb_" + "native_inventory", " ".join(entry["evidence"])
            )
            if entry["status"] in {
                "implemented_verified",
                "bounded_implemented_verified",
            }:
                self.assertEqual(entry["verification"], "final_semantic_gate")
            elif entry["status"] in {
                "implemented_unverified",
                "bounded_implemented_unverified",
                "primitive_available_unverified",
            }:
                self.assertEqual(entry["verification"], "source_only")

    def test_evidence_normalization_rejects_legacy_paths(self):
        evidence = normalize_evidence(
            "json-object-types",
            [
                "src/" + "cata" + "lua_runtime.cpp",
                "data/lua/types/ccb_platform_v1.d.lua",
                "tests/lua_platform_test.cpp",
                "tools/migrate_lua_first.py",
            ],
        )
        self.assertNotIn("src/" + "cata" + "lua_runtime.cpp", evidence)
        self.assertIn(
            "src/lua_platform_runtime.cpp",
            normalize_evidence(
                "json-object-types", ["src/lua_platform_runtime.cpp"]
            ),
        )
        self.assertIn(
            "data/reference/json/ccb_json_object_types.json",
            evidence,
        )

    def test_legacy_evidence_points_to_the_real_inventory(self):
        self.assertEqual(
            legacy_evidence("eoc-effects", {}),
            ["data/reference/json/ccb_eoc_effects.json"],
        )


if __name__ == "__main__":
    unittest.main()
