import unittest

from check_lua_first_replacement_ledger import check
from generate_lua_first_replacement_ledger import OUTPUT, build_ledger, render


class LuaFirstReplacementLedgerTest(unittest.TestCase):
    def test_committed_ledger_covers_every_selector_once(self):
        result = check()
        self.assertEqual(result["total"], 775)
        self.assertEqual(result["implemented_unverified"], 82)
        self.assertGreater(
            build_ledger()["summary"]["primitive_available_unverified"], 0
        )

    def test_generator_preserves_the_three_inventory_denominators(self):
        generated = build_ledger()
        counts = {source["id"]: source["entry_count"] for source in generated["sources"]}
        self.assertEqual(
            counts,
            {
                "json-object-types": 190,
                "eoc-conditions": 275,
                "eoc-effects": 310,
            },
        )

    def test_creature_content_selectors_have_native_unverified_evidence(self):
        generated = build_ledger()
        entries = {
            entry["selector"]: entry
            for entry in generated["entries"]
            if entry["inventory"] == "json-object-types"
        }
        for selector in {
            "monster_attack", "effect_type", "weakpoint_set", "field_type",
            "item_group", "sub_body_part", "body_part", "anatomy",
            "body_graph", "MONSTER",
        }:
            self.assertEqual(entries[selector]["status"], "implemented_unverified")
            self.assertIn("tools/migrate_lua_first.py", entries[selector]["evidence"])

    def test_committed_ledger_matches_the_generator(self):
        self.assertEqual(
            OUTPUT.read_text(encoding="utf-8"),
            render(build_ledger()),
        )


if __name__ == "__main__":
    unittest.main()
