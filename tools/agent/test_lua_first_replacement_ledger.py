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
                "implemented_verified": 53,
                "implemented_unverified": 14,
                "bounded_implemented_verified": 14,
                "bounded_implemented_unverified": 244,
                "primitive_available_unverified": 299,
                "planned": 133,
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
            "field_type", "item_group", "body_part",
            "wound", "wound_fix",
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
            "implemented_verified",
            "implemented_unverified",
            "bounded_implemented_verified",
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

    def test_full_coverage_selectors_are_implemented_unverified(self):
        generated = build_ledger()
        entries = {
            (entry["inventory"], entry["selector"]): entry
            for entry in generated["entries"]
        }
        for selector, target in {
            "sound_effect": "content.sound-effects",
            "sound_effect_preload": "content.sound-effects",
            "TRAIT_BLACKLIST": "content.blacklists",
            "MONSTER_WHITELIST": "content.blacklists",
            "magic_type": "content.magic-types",
            "playlist": "content.playlists",
            "activity_type": "content.activity-types",
            "help": "content.help-topics",
            "bionic_migration": "content.migrations",
            "field_type_migration": "content.migrations",
            "ITEM_BLACKLIST": "content.blacklists",
            "profession_blacklist": "content.blacklists",
            "trait_group": "content.trait-groups",
            "monster_adjustment": "content.monsters",
        }.items():
            entry = entries[("json-object-types", selector)]
            self.assertEqual(
                entry["status"], "implemented_unverified"
            )
            self.assertEqual(entry["target"], target)
            self.assertEqual(entry["legacy_dependency"], "none")
            self.assertIn("tools/migrate_lua_first.py", entry["evidence"])

    def test_parity_verified_selectors_promote_to_verified(self):
        generated = build_ledger()
        entries = {
            (entry["inventory"], entry["selector"]): entry
            for entry in generated["entries"]
        }
        for selector, target in {
            "ammunition_type": "content.ammunition-types",
            "anatomy": "content.anatomies",
            "attack_vector": "content.attack-vectors",
            "bash_damage_profile": "content.bash-damage-profiles",
            "butchery_requirement": "content.butchery-requirements",
            "charge_removal_blacklist": "content.blacklists",
            "connect_group": "content.connect-groups",
            "construction_category": "content.construction-categories",
            "construction_group": "content.construction-groups",
            "damage_info_order": "content.damage-info-presentation",
            "disease_type": "content.disease-types",
            "dream": "content.gameplay",
            "effect_migration": "content.migrations",
            "emit": "content.emissions",
            "fault_group": "content.fault-groups",
            "gate": "content.map",
            "harvest_drop_type": "content.harvest-drop-types",
            "hit_range": "content.hit-range",
            "item_action": "content.item-actions",
            "limb_score": "content.limb-scores",
            "MONSTER_BLACKLIST": "content.blacklists",
            "monster_flag": "content.monster-flags",
            "mutation_category": "content.mutation-categories",
            "named_color": "content.named-colors",
            "oter_id_migration": "content.migrations",
            "oter_vision": "content.overmap-vision",
            "overlay_order": "content.overlay-order",
            "overmap_connection": "content.overmap-connections",
            "overmap_land_use_code": "content.overmap-land-use-codes",
            "overmap_special_migration": "content.migrations",
            "profession_group": "content.profession-groups",
            "proficiency_category": "content.proficiency-categories",
            "proficiency_migration": "content.migrations",
            "recipe_category": "content.recipe-categories",
            "rotatable_symbol": "content.rotatable-symbols",
            "SCENARIO_BLACKLIST": "content.blacklists",
            "scent_type": "content.scent-types",
            "skill": "content.skills",
            "skill_display_type": "content.skill-display-categories",
            "SPECIES": "content.species",
            "speech": "content.speech-pools",
            "speed_description": "content.speed-descriptions",
            "sub_body_part": "content.sub-body-parts",
            "temperature_removal_blacklist": "content.blacklists",
            "ter_furn_migration": "content.migrations",
            "trap_migration": "content.migrations",
            "var_migration": "content.migrations",
            "vehicle_color_palette": "content.vehicle-color-palettes",
            "vehicle_group": "content.vehicle-groups",
            "vehicle_part_category": "content.vehicle-part-categories",
            "vehicle_part_location": "content.vehicle-part-locations",
            "vehicle_part_migration": "content.migrations",
            "weapon_category": "content.weapon-categories",
        }.items():
            entry = entries[("json-object-types", selector)]
            self.assertEqual(entry["status"], "implemented_verified")
            self.assertEqual(entry["target"], target)
            self.assertEqual(entry["legacy_dependency"], "none")
            self.assertIn("tests/catalua_ui_test.cpp", entry["evidence"])

        for selector, target in {
            "clothing_mod": "content.clothing-modifications",
            "damage_type": "content.damage-types",
            "explosion_light": "content.explosion-lights",
            "fault": "content.faults",
            "ITEM_CATEGORY": "content.item-categories",
            "json_flag": "content.flags",
            "LOOT_ZONE": "content.zone-types",
            "mood_face": "content.mood-faces",
            "morale_type": "content.morale-types",
            "movement_mode": "content.movement-modes",
            "recipe_group": "content.recipe-groups",
            "scenario": "content.scenarios",
            "start_location": "content.start-locations",
            "tool_quality": "content.tool-qualities",
        }.items():
            entry = entries[("json-object-types", selector)]
            self.assertEqual(entry["status"], "bounded_implemented_verified")
            self.assertEqual(entry["target"], target)
            self.assertEqual(entry["legacy_dependency"], "none")
            self.assertIn("tests/catalua_ui_test.cpp", entry["evidence"])

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
            "is_season",
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
                "primitive_available_unverified",
            )
            self.assertEqual(wound_effect["target"], "services.wounds")
            self.assertEqual(
                wound_effect["legacy_dependency"], "none"
            )
            self.assertIn("src/npctalk.cpp", wound_effect["evidence"])
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
            "npc_deal_damage": "services.combat",
            "npc_pick_bodypart": "services.body-parts-and-wounds",
            "u_deal_damage": "services.combat",
            "u_pick_bodypart": "services.body-parts-and-wounds",
        }.items():
            wound_effect = entries[("eoc-effects", selector)]
            self.assertEqual(wound_effect["status"], "planned")
            self.assertEqual(wound_effect["target"], target)

        for selector, target in {
            "npc_add_wound": "services.wounds",
            "npc_remove_wound": "services.wounds",
        }.items():
            wound_effect = entries[("eoc-effects", selector)]
            self.assertEqual(
                wound_effect["status"], "primitive_available_unverified"
            )
            self.assertEqual(wound_effect["target"], target)

        for selector, status, target in {
            (
                "npc_add_wet",
                "bounded_implemented_unverified",
                "services.wetness",
            ),
            (
                "u_add_wet",
                "bounded_implemented_unverified",
                "services.wetness",
            ),
        }:
            wet_effect = entries[("eoc-effects", selector)]
            self.assertEqual(wet_effect["status"], status)
            self.assertEqual(wet_effect["target"], target)

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
            ("eoc-effects", "goto_location", "workflows.npc-navigation"),
            ("eoc-effects", "morale_chat_activity", "workflows.socialize"),
            ("eoc-effects", "npc_set_goal", "services.npc-navigation"),
            ("eoc-effects", "npc_set_guard_pos", "services.npc-navigation"),
            ("eoc-effects", "npc_teleport", "services.relocation"),
            ("eoc-effects", "revert_activity", "services.npc-work"),
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

        for inventory, selector, status, target in {
            (
                "eoc-conditions",
                "npc_is_travelling",
                "bounded_implemented_unverified",
                "services.character-navigation",
            ),
            (
                "eoc-conditions",
                "u_is_travelling",
                "bounded_implemented_unverified",
                "services.character-navigation",
            ),
            (
                "eoc-conditions",
                "player_see_u",
                "bounded_implemented_unverified",
                "services.creatures.perception",
            ),
            (
                "eoc-conditions",
                "player_see_npc",
                "bounded_implemented_unverified",
                "services.creatures.perception",
            ),
            (
                "eoc-conditions",
                "u_at_safe_space",
                "bounded_implemented_unverified",
                "services.overmap-safety-and-characters",
            ),
            (
                "eoc-conditions",
                "at_safe_space",
                "bounded_implemented_unverified",
                "services.overmap-safety-and-characters",
            ),
            (
                "eoc-conditions",
                "u_has_pickup_list",
                "bounded_implemented_unverified",
                "services.npcs.ai-rules",
            ),
            (
                "eoc-conditions",
                "has_pickup_list",
                "bounded_implemented_unverified",
                "services.npcs.ai-rules",
            ),
            (
                "eoc-conditions",
                "is_rotten",
                "primitive_available_unverified",
                "services.items",
            ),
            (
                "eoc-conditions",
                "is_by_radio",
                "primitive_available_unverified",
                "services.dialogue-projection",
            ),
            (
                "eoc-conditions",
                "has_reason",
                "primitive_available_unverified",
                "services.dialogue-projection",
            ),
            (
                "eoc-conditions",
                "has_alpha",
                "primitive_available_unverified",
                "services.dialogue-projection",
            ),
            (
                "eoc-conditions",
                "has_beta",
                "primitive_available_unverified",
                "services.dialogue-projection",
            ),
        }:
            predicate_entry = entries[(inventory, selector)]
            self.assertEqual(predicate_entry["status"], status)
            self.assertEqual(predicate_entry["target"], target)

        for selector, status, target in {
            (
                "u_add_wound",
                "primitive_available_unverified",
                "services.wounds",
            ),
            (
                "npc_add_wound",
                "primitive_available_unverified",
                "services.wounds",
            ),
            (
                "u_remove_wound",
                "primitive_available_unverified",
                "services.wounds",
            ),
            (
                "npc_remove_wound",
                "primitive_available_unverified",
                "services.wounds",
            ),
            (
                "u_assign_activity",
                "primitive_available_unverified",
                "services.activities",
            ),
            (
                "npc_assign_activity",
                "primitive_available_unverified",
                "services.activities",
            ),
        }:
            effect_entry = entries[("eoc-effects", selector)]
            self.assertEqual(effect_entry["status"], status)
            self.assertEqual(effect_entry["target"], target)

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
