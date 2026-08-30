import copy
import json
import unittest
from pathlib import Path

from jsonschema import Draft202012Validator

from tools.agent.generate_lua_first_replacement_ledger import (
    IMPLEMENTED_VERIFIED,
    INVENTORIES,
    BOUNDED_IMPLEMENTED_VERIFIED,
    TODO_CLASSIFICATIONS,
    build_ledger,
    classify_migration_todo,
    legacy_evidence,
    normalize_evidence,
)


class LuaFirstReplacementLedgerTest(unittest.TestCase):
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

    def test_verified_promotions_are_disabled_until_the_final_gate(self):
        self.assertEqual(IMPLEMENTED_VERIFIED, frozenset())
        self.assertEqual(BOUNDED_IMPLEMENTED_VERIFIED, frozenset())

    def test_generator_uses_the_three_real_inventories(self):
        generated = build_ledger()
        self.assertEqual(
            {source["id"] for source in generated["sources"]},
            set(INVENTORIES),
        )
        self.assertTrue(
            all(source["entry_count"] > 0 for source in generated["sources"])
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

    def test_bounded_shapes_are_not_promoted_to_verified(self):
        generated = {
            (entry["inventory"], entry["selector"]): entry
            for entry in build_ledger()["entries"]
        }
        for identity in {
            ("json-object-types", "wound"),
            ("eoc-conditions", "u_has_item"),
            ("eoc-effects", "u_add_effect"),
        }:
            self.assertEqual(
                generated[identity]["status"],
                "bounded_implemented_unverified",
            )
            self.assertEqual(
                generated[identity]["verification"], "source_only"
            )

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
        self.assertIn("src/lua_platform_runtime.cpp", normalize_evidence(
            "json-object-types", ["src/lua_platform_runtime.cpp"]
        ))
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
