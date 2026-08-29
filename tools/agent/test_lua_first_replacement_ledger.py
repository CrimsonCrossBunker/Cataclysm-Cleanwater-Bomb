import unittest

from tools.agent.generate_lua_first_replacement_ledger import (
    IMPLEMENTED_VERIFIED,
    INVENTORIES,
    BOUNDED_IMPLEMENTED_VERIFIED,
    build_ledger,
    legacy_evidence,
    normalize_evidence,
)


class LuaFirstReplacementLedgerTest(unittest.TestCase):
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
