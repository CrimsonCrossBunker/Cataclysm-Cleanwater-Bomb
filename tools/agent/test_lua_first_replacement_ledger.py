import unittest

from check_lua_first_replacement_ledger import check
from generate_lua_first_replacement_ledger import OUTPUT, build_ledger, render


class LuaFirstReplacementLedgerTest(unittest.TestCase):
    def test_committed_ledger_covers_every_selector_once(self):
        result = check()
        self.assertEqual(
            result,
            {
                "total": 775,
                "implemented_unverified": 0,
                "bounded_implemented_unverified": 119,
                "primitive_available_unverified": 440,
                "planned": 198,
                "private_adapter": 0,
                "reviewed_not_applicable": 18,
            },
        )

    def test_generator_preserves_the_three_inventory_denominators(self):
        generated = build_ledger()
        counts = {
            source["id"]: source["entry_count"]
            for source in generated["sources"]
        }
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
            "monster_attack", "effect_type", "weakpoint_set",
            "field_type", "item_group", "sub_body_part", "body_part",
            "wound", "wound_fix", "anatomy",
            "body_graph", "MONSTER",
        }:
            self.assertEqual(
                entries[selector]["status"],
                "bounded_implemented_unverified",
            )
            self.assertIn(
                "tools/migrate_lua_first.py",
                entries[selector]["evidence"],
            )

    def test_committed_ledger_matches_the_generator(self):
        self.assertEqual(
            OUTPUT.read_text(encoding="utf-8"),
            render(build_ledger()),
        )

    def test_coverage_statuses_have_status_specific_evidence(self):
        generated = build_ledger()
        implemented_statuses = {
            "implemented_unverified",
            "bounded_implemented_unverified",
        }
        evidenced_statuses = implemented_statuses | {
            "primitive_available_unverified",
        }
        required_prefixes = (
            "src/",
            "data/lua/types/",
            "tests/",
            "data/lua/LUA_FIRST_PLATFORM.md",
        )
        for entry in generated["entries"]:
            if entry["status"] not in evidenced_statuses:
                continue
            for prefix in required_prefixes:
                self.assertTrue(
                    any(
                        value.startswith(prefix)
                        for value in entry["evidence"]
                    ),
                    f"{entry['inventory']}:{entry['selector']} lacks "
                    f"{prefix} evidence",
                )
            if entry["status"] in implemented_statuses:
                self.assertIn(
                    "tools/migrate_lua_first.py",
                    entry["evidence"],
                    f"{entry['inventory']}:{entry['selector']} lacks "
                    "migration evidence",
                )

    def test_lua_native_eoc_shapes_remain_bounded_until_full_parity(self):
        generated = build_ledger()
        entries = {
            (entry["inventory"], entry["selector"]): entry
            for entry in generated["entries"]
        }
        for selector in {
            "compare_string",
            "compare_string_match_all",
            "current_dimension",
            "mod_is_loaded",
            "one_in_chance",
            "roll_contested",
            "u_can_drop_weapon",
            "u_has_activity",
            "u_has_bionics",
            "u_has_item",
            "u_has_move_mode",
            "u_has_weapon",
            "u_has_wielded_with_flag",
            "u_has_any_trait",
            "u_has_martial_art",
            "u_has_proficiency",
            "u_has_trait",
            "u_know_recipe",
            "u_using_martial_art",
            "x_in_y_chance",
        }:
            entry = entries[("eoc-conditions", selector)]
            self.assertEqual(entry["status"], "bounded_implemented_unverified")
            self.assertEqual(entry["legacy_dependency"], "none")
            self.assertIn("tools/migrate_lua_first.py", entry["evidence"])

        achievement = entries[("eoc-effects", "give_achievement")]
        self.assertEqual(
            achievement["status"], "bounded_implemented_unverified"
        )
        self.assertEqual(achievement["target"], "services.achievements")

        message = entries[("eoc-effects", "message")]
        self.assertEqual(message["status"], "bounded_implemented_unverified")
        self.assertEqual(message["target"], "services.message")

        for selector in {"npc_set_flag", "npc_unset_flag"}:
            item_flag = entries[("eoc-effects", selector)]
            self.assertEqual(
                item_flag["status"], "bounded_implemented_unverified"
            )
            self.assertEqual(item_flag["target"], "services.items")
            self.assertIn("src/event_bus.cpp", item_flag["evidence"])

        bionic = entries[("eoc-effects", "u_add_bionic")]
        self.assertEqual(bionic["status"], "bounded_implemented_unverified")
        self.assertEqual(bionic["target"], "services.bionics")
        self.assertIn("src/catalua_ui_bionics.cpp", bionic["evidence"])

        bionic_removal = entries[("eoc-effects", "u_lose_bionic")]
        self.assertEqual(
            bionic_removal["status"], "bounded_implemented_unverified"
        )
        self.assertEqual(bionic_removal["target"], "services.bionics")

        learned_recipe = entries[("eoc-effects", "u_learn_recipe")]
        self.assertEqual(
            learned_recipe["status"], "bounded_implemented_unverified"
        )
        self.assertEqual(learned_recipe["target"], "services.recipes")
        self.assertIn("src/character_crafting.cpp", learned_recipe["evidence"])

        forgotten_recipe = entries[("eoc-effects", "u_forget_recipe")]
        self.assertEqual(
            forgotten_recipe["status"], "bounded_implemented_unverified"
        )
        self.assertEqual(forgotten_recipe["target"], "services.recipes")

        known_recipe = entries[("eoc-conditions", "u_know_recipe")]
        self.assertEqual(
            known_recipe["status"], "bounded_implemented_unverified"
        )
        self.assertEqual(known_recipe["target"], "services.recipes")
        self.assertIn("src/condition.cpp", known_recipe["evidence"])
        self.assertIn(
            "src/character_crafting.cpp", known_recipe["evidence"]
        )

        learned_style = entries[("eoc-effects", "u_learn_martial_art")]
        self.assertEqual(
            learned_style["status"], "bounded_implemented_unverified"
        )
        self.assertEqual(learned_style["target"], "services.martial_arts")
        self.assertIn(
            "src/character_martial_arts.cpp", learned_style["evidence"]
        )

        forgotten_style = entries[("eoc-effects", "u_forget_martial_art")]
        self.assertEqual(
            forgotten_style["status"], "bounded_implemented_unverified"
        )
        self.assertEqual(forgotten_style["target"], "services.martial_arts")

        added_morale = entries[("eoc-effects", "u_add_morale")]
        self.assertEqual(
            added_morale["status"], "bounded_implemented_unverified"
        )
        self.assertEqual(added_morale["target"], "services.morale")
        self.assertIn("src/morale.cpp", added_morale["evidence"])
        self.assertIn("src/npctalk.cpp", added_morale["evidence"])
        self.assertIn("src/talker_character.cpp", added_morale["evidence"])

        removed_morale = entries[("eoc-effects", "u_lose_morale")]
        self.assertEqual(
            removed_morale["status"], "bounded_implemented_unverified"
        )
        self.assertEqual(removed_morale["target"], "services.morale")
        self.assertIn("src/npctalk.cpp", removed_morale["evidence"])
        self.assertIn("src/talker_character.cpp", removed_morale["evidence"])

        added_effect = entries[("eoc-effects", "u_add_effect")]
        self.assertEqual(
            added_effect["status"], "bounded_implemented_unverified"
        )
        self.assertEqual(added_effect["target"], "services.effects")
        self.assertIn("src/catalua_ui_effects.cpp", added_effect["evidence"])

        removed_effect = entries[("eoc-effects", "u_lose_effect")]
        self.assertEqual(
            removed_effect["status"], "bounded_implemented_unverified"
        )
        self.assertEqual(removed_effect["target"], "services.effects")

        cancelled_activity = entries[("eoc-effects", "u_cancel_activity")]
        self.assertEqual(
            cancelled_activity["status"],
            "bounded_implemented_unverified",
        )
        self.assertEqual(cancelled_activity["target"], "services.activities")

        for selector in {"u_add_wound", "u_remove_wound"}:
            wound_effect = entries[("eoc-effects", selector)]
            self.assertEqual(
                wound_effect["status"],
                "planned",
            )
            self.assertEqual(wound_effect["target"], "services.wounds")
            self.assertEqual(
                wound_effect["legacy_dependency"], "public_legacy"
            )
            self.assertIn("src/npctalk.cpp", wound_effect["evidence"])
            self.assertIn("src/bodypart.cpp", wound_effect["evidence"])
            self.assertIn("src/wound.cpp", wound_effect["evidence"])
            self.assertIn(
                "src/catalua_platform_runtime.cpp", wound_effect["evidence"]
            )

        for selector in {
            "npc_set_fac_relation",
            "u_add_faction_trust",
            "u_set_fac_relation",
        }:
            faction_effect = entries[("eoc-effects", selector)]
            self.assertEqual(
                faction_effect["status"],
                "primitive_available_unverified",
            )
            self.assertEqual(faction_effect["target"], "services.factions")
            self.assertIn(
                "src/catalua_ui_factions.cpp",
                faction_effect["evidence"],
            )

        for selector, target in {
            "npc_add_wet": "services.wetness",
            "npc_add_wound": "services.wounds",
            "npc_deal_damage": "services.combat",
            "npc_pick_bodypart": "services.body-parts-and-wounds",
            "npc_remove_wound": "services.wounds",
            "u_add_wet": "services.wetness",
            "u_deal_damage": "services.combat",
            "u_pick_bodypart": "services.body-parts-and-wounds",
        }.items():
            wound_effect = entries[("eoc-effects", selector)]
            self.assertEqual(wound_effect["status"], "planned")
            self.assertEqual(wound_effect["target"], target)

        wound = entries[("json-object-types", "wound")]
        self.assertEqual(
            wound["status"], "bounded_implemented_unverified"
        )
        self.assertEqual(wound["target"], "content.wounds")
        self.assertEqual(wound["legacy_dependency"], "none")
        self.assertIn("tools/migrate_lua_first.py", wound["evidence"])
        wound_fix = entries[("json-object-types", "wound_fix")]
        self.assertEqual(
            wound_fix["status"], "bounded_implemented_unverified"
        )
        self.assertEqual(wound_fix["target"], "content.wound-fixes")
        self.assertEqual(wound_fix["legacy_dependency"], "none")
        self.assertIn("tools/migrate_lua_first.py", wound_fix["evidence"])

        for inventory, selector, target in {
            (
                "eoc-conditions",
                "npc_can_drop_weapon",
                "services.inventory-and-martial-arts",
            ),
            ("eoc-conditions", "npc_has_activity", "services.activities"),
            ("eoc-conditions", "npc_has_item", "services.inventory"),
            (
                "eoc-conditions",
                "npc_has_move_mode",
                "services.characters.movement",
            ),
            (
                "eoc-conditions",
                "npc_has_weapon",
                "services.inventory-and-martial-arts",
            ),
            (
                "eoc-conditions",
                "npc_has_wielded_with_flag",
                "services.inventory-and-items",
            ),
            ("eoc-effects", "map_spawn_item", "services.world"),
            ("eoc-effects", "npc_cancel_activity", "services.activities"),
            (
                "eoc-effects",
                "assign_mission",
                "services.missions-and-dialogue",
            ),
            ("eoc-effects", "u_set_flag", "services.items"),
            ("eoc-effects", "u_spawn_item", "services.inventory"),
            ("eoc-effects", "u_unset_flag", "services.items"),
        }:
            item_entry = entries[(inventory, selector)]
            self.assertEqual(
                item_entry["status"],
                "primitive_available_unverified",
            )
            self.assertEqual(item_entry["target"], target)

        for selector, target in {
            "npc_activate": "services.items-and-characters",
            "npc_set_fault": "services.items",
            "npc_set_random_fault_of_type": "services.items",
            "set_browsed": "services.items",
            "transform_item": "services.items",
            "u_activate": "services.items-and-characters",
            "u_set_fault": "services.items",
            "u_set_random_fault_of_type": "services.items",
        }.items():
            item_entry = entries[("eoc-effects", selector)]
            self.assertEqual(item_entry["status"], "planned")
            self.assertEqual(item_entry["target"], target)

        for inventory, selector, target in {
            (
                "eoc-conditions",
                "npc_is_travelling",
                "services.character-navigation",
            ),
            (
                "eoc-conditions",
                "u_is_travelling",
                "services.character-navigation",
            ),
            ("eoc-effects", "goto_location", "workflows.npc-navigation"),
            ("eoc-effects", "morale_chat_activity", "workflows.socialize"),
            ("eoc-effects", "npc_assign_activity", "services.activities"),
            ("eoc-effects", "npc_set_goal", "services.npc-navigation"),
            ("eoc-effects", "npc_set_guard_pos", "services.npc-navigation"),
            ("eoc-effects", "npc_teleport", "services.relocation"),
            ("eoc-effects", "revert_activity", "services.npc-work"),
            ("eoc-effects", "u_assign_activity", "services.activities"),
            ("eoc-effects", "u_set_goal", "services.npc-navigation"),
            ("eoc-effects", "u_set_guard_pos", "services.npc-navigation"),
            ("eoc-effects", "u_teleport", "services.relocation"),
            (
                "eoc-effects",
                "u_travel_to_dimension",
                "workflows.dimension-travel",
            ),
        }:
            activity_entry = entries[(inventory, selector)]
            self.assertEqual(activity_entry["status"], "planned")
            self.assertEqual(activity_entry["target"], target)

        for selector in {
            "get_condition",
            "nothing",
            "run_eoc_selector",
            "run_eocs",
            "run_lua",
            "set_condition",
            "test_eoc",
        }:
            matches = [
                entry for entry in generated["entries"]
                if entry["selector"] == selector
            ]
            self.assertTrue(matches)
            self.assertTrue(
                all(
                    entry["status"] == "reviewed_not_applicable"
                    for entry in matches
                )
            )

        for inventory, selector in {
            ("eoc-conditions", "is_outside"),
            ("eoc-conditions", "line_of_sight"),
            ("eoc-effects", "dimension_name"),
            ("eoc-effects", "mirror_coordinates"),
            ("eoc-effects", "sample_range"),
        }:
            self.assertEqual(
                entries[(inventory, selector)]["status"],
                "primitive_available_unverified",
            )

        primitive_targets = {
            ("eoc-conditions", "follower_present"): "services.followers",
            ("eoc-effects", "closest_city"): "services.overmap",
            ("eoc-effects", "follow"): "services.followers-and-npcs",
            ("eoc-effects", "give_aid"): "services.characters-and-effects",
            ("eoc-effects", "give_equipment"): (
                "services.inventory-and-presentation"
            ),
            ("eoc-effects", "hostile"): "services.npcs",
            ("eoc-effects", "reveal_route"): "services.overmap",
            ("eoc-effects", "set_trap"): "services.world-and-coords",
            ("eoc-effects", "signal_hordes"): "services.hordes",
            ("eoc-effects", "stop_following"): "services.followers-and-npcs",
            ("eoc-effects", "stranger_neutral"): "services.npcs",
            ("eoc-effects", "turn_cost"): "services.characters-and-time",
        }
        for key, target in primitive_targets.items():
            self.assertEqual(
                entries[key]["status"], "primitive_available_unverified"
            )
            self.assertEqual(entries[key]["target"], target)


if __name__ == "__main__":
    unittest.main()
