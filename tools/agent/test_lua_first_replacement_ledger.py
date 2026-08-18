import unittest

from check_lua_first_replacement_ledger import check
from generate_lua_first_replacement_ledger import (
    OUTPUT,
    PLANNED_JSON,
    build_ledger,
    render,
)


class LuaFirstReplacementLedgerTest(unittest.TestCase):
    def test_committed_ledger_covers_every_selector_once(self):
        result = check()
        self.assertEqual(
            result,
            {
                "total": 775,
                "implemented_verified": 67,
                "implemented_unverified": 0,
                "bounded_implemented_verified": 14,
                "bounded_implemented_unverified": 639,
                "primitive_available_unverified": 4,
                "planned": 33,
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

    def test_full_coverage_selectors_are_implemented_verified(self):
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
                entry["status"], "implemented_verified"
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
                "bounded_implemented_unverified",
            )
            self.assertEqual(faction_effect["target"], "services.factions")
            self.assertIn(
                "src/catalua_ui_factions.cpp",
                faction_effect["evidence"],
            )

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
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-conditions",
                "is_by_radio",
                "bounded_implemented_unverified",
                "services.dialogue-projection",
            ),
            (
                "eoc-conditions",
                "has_reason",
                "bounded_implemented_unverified",
                "services.dialogue-projection",
            ),
            (
                "eoc-conditions",
                "has_alpha",
                "bounded_implemented_unverified",
                "services.dialogue-projection",
            ),
            (
                "eoc-conditions",
                "has_beta",
                "bounded_implemented_unverified",
                "services.dialogue-projection",
            ),
            (
                "eoc-conditions",
                "follower_present",
                "bounded_implemented_unverified",
                "services.followers",
            ),
            (
                "eoc-effects",
                "sound_effect",
                "bounded_implemented_unverified",
                "services.sound",
            ),
            (
                "eoc-effects",
                "u_wants_to_talk",
                "bounded_implemented_unverified",
                "services.characters",
            ),
            (
                "eoc-effects",
                "npc_wants_to_talk",
                "bounded_implemented_unverified",
                "services.npcs",
            ),
            (
                "eoc-effects",
                "hostile",
                "bounded_implemented_unverified",
                "services.npcs",
            ),
            (
                "eoc-effects",
                "flee",
                "bounded_implemented_unverified",
                "services.npcs",
            ),
            (
                "eoc-effects",
                "u_spawn_item",
                "bounded_implemented_unverified",
                "services.inventory",
            ),
            (
                "eoc-effects",
                "map_spawn_item",
                "bounded_implemented_unverified",
                "services.world",
            ),
            (
                "eoc-effects",
                "player_weapon_away",
                "bounded_implemented_unverified",
                "services.inventory",
            ),
            (
                "eoc-effects",
                "set_trap",
                "bounded_implemented_unverified",
                "services.world-and-coords",
            ),
            (
                "eoc-effects",
                "signal_hordes",
                "bounded_implemented_unverified",
                "services.hordes",
            ),
            (
                "eoc-effects",
                "reveal_route",
                "bounded_implemented_unverified",
                "services.overmap",
            ),
            (
                "eoc-effects",
                "follow",
                "bounded_implemented_unverified",
                "services.followers-and-npcs",
            ),
            (
                "eoc-effects",
                "stop_following",
                "bounded_implemented_unverified",
                "services.followers-and-npcs",
            ),
            (
                "eoc-effects",
                "stranger_neutral",
                "bounded_implemented_unverified",
                "services.npcs",
            ),
            (
                "eoc-effects",
                "end_conversation",
                "bounded_implemented_unverified",
                "services.dialogue",
            ),
            (
                "eoc-conditions",
                "u_can_see",
                "bounded_implemented_unverified",
                "services.creatures.perception",
            ),
            (
                "eoc-conditions",
                "npc_can_see",
                "bounded_implemented_unverified",
                "services.creatures.perception",
            ),
            (
                "eoc-conditions",
                "u_has_species",
                "bounded_implemented_unverified",
                "services.characters",
            ),
            (
                "eoc-conditions",
                "npc_has_species",
                "bounded_implemented_unverified",
                "services.characters",
            ),
            (
                "eoc-conditions",
                "u_has_activity",
                "bounded_implemented_unverified",
                "services.activities",
            ),
            (
                "eoc-conditions",
                "u_has_stolen_item",
                "bounded_implemented_unverified",
                "services.inventory",
            ),
            (
                "eoc-conditions",
                "u_can_stow_weapon",
                "bounded_implemented_unverified",
                "services.inventory",
            ),
            (
                "eoc-conditions",
                "u_are_owed",
                "bounded_implemented_unverified",
                "services.characters",
            ),
            (
                "eoc-conditions",
                "u_train_skills",
                "bounded_implemented_unverified",
                "services.skills",
            ),
            (
                "eoc-conditions",
                "u_train_spells",
                "bounded_implemented_unverified",
                "services.magic",
            ),
            (
                "eoc-conditions",
                "u_train_styles",
                "bounded_implemented_unverified",
                "services.martial_arts",
            ),
            (
                "eoc-effects",
                "turn_cost",
                "bounded_implemented_unverified",
                "services.characters-and-time",
            ),
            (
                "eoc-effects",
                "wake_up",
                "bounded_implemented_unverified",
                "services.npcs",
            ),
            (
                "eoc-effects",
                "reveal_stats",
                "bounded_implemented_unverified",
                "services.npcs",
            ),
            (
                "eoc-conditions",
                "npc_train_skills",
                "bounded_implemented_unverified",
                "services.skills",
            ),
            (
                "eoc-conditions",
                "npc_train_spells",
                "bounded_implemented_unverified",
                "services.magic",
            ),
            (
                "eoc-conditions",
                "npc_train_styles",
                "bounded_implemented_unverified",
                "services.martial_arts",
            ),
            (
                "eoc-conditions",
                "npc_has_stolen_item",
                "bounded_implemented_unverified",
                "services.inventory",
            ),
            (
                "eoc-conditions",
                "npc_can_stow_weapon",
                "bounded_implemented_unverified",
                "services.inventory",
            ),
            (
                "eoc-effects",
                "insult_combat",
                "bounded_implemented_unverified",
                "services.npcs",
            ),
            (
                "eoc-effects",
                "lead_to_safety",
                "bounded_implemented_unverified",
                "services.npcs",
            ),
            (
                "eoc-effects",
                "leave",
                "bounded_implemented_unverified",
                "services.npcs",
            ),
            (
                "eoc-effects",
                "follow_only",
                "bounded_implemented_unverified",
                "services.followers-and-npcs",
            ),
            (
                "eoc-effects",
                "deny_follow",
                "bounded_implemented_unverified",
                "services.effects",
            ),
            (
                "eoc-effects",
                "deny_lead",
                "bounded_implemented_unverified",
                "services.effects",
            ),
            (
                "eoc-effects",
                "deny_equipment",
                "bounded_implemented_unverified",
                "services.effects",
            ),
            (
                "eoc-effects",
                "deny_train",
                "bounded_implemented_unverified",
                "services.effects",
            ),
            (
                "eoc-effects",
                "deny_personal_info",
                "bounded_implemented_unverified",
                "services.effects",
            ),
            (
                "eoc-effects",
                "player_leaving",
                "bounded_implemented_unverified",
                "services.npcs",
            ),
            (
                "eoc-effects",
                "start_mugging",
                "bounded_implemented_unverified",
                "services.npcs",
            ),
            (
                "eoc-effects",
                "remove_stolen_status",
                "bounded_implemented_unverified",
                "services.npcs",
            ),
            (
                "eoc-effects",
                "assign_guard",
                "bounded_implemented_unverified",
                "services.npcs",
            ),
            (
                "eoc-effects",
                "stop_guard",
                "bounded_implemented_unverified",
                "services.npcs",
            ),
            (
                "eoc-effects",
                "buy_chicken",
                "bounded_implemented_unverified",
                "services.spawns",
            ),
            (
                "eoc-effects",
                "buy_horse",
                "bounded_implemented_unverified",
                "services.spawns",
            ),
            (
                "eoc-effects",
                "buy_cow",
                "bounded_implemented_unverified",
                "services.spawns",
            ),
            (
                "eoc-effects",
                "start_trade",
                "bounded_implemented_unverified",
                "services.dialogue",
            ),
            (
                "eoc-effects",
                "barber_hair",
                "bounded_implemented_unverified",
                "services.dialogue",
            ),
            (
                "eoc-effects",
                "barber_beard",
                "bounded_implemented_unverified",
                "services.dialogue",
            ),
            (
                "eoc-effects",
                "buy_haircut",
                "bounded_implemented_unverified",
                "services.dialogue",
            ),
            (
                "eoc-effects",
                "buy_shave",
                "bounded_implemented_unverified",
                "services.dialogue",
            ),
            (
                "eoc-effects",
                "revert_activity",
                "bounded_implemented_unverified",
                "services.activities",
            ),
            (
                "eoc-effects",
                "morale_chat_activity",
                "bounded_implemented_unverified",
                "services.activities",
            ),
            (
                "eoc-effects",
                "do_butcher",
                "bounded_implemented_unverified",
                "services.activities",
            ),
            (
                "eoc-effects",
                "do_chop_plank",
                "bounded_implemented_unverified",
                "services.activities",
            ),
            (
                "eoc-effects",
                "do_chop_trees",
                "bounded_implemented_unverified",
                "services.activities",
            ),
            (
                "eoc-effects",
                "do_construction",
                "bounded_implemented_unverified",
                "services.activities",
            ),
            (
                "eoc-effects",
                "do_farming",
                "bounded_implemented_unverified",
                "services.activities",
            ),
            (
                "eoc-effects",
                "do_fishing",
                "bounded_implemented_unverified",
                "services.activities",
            ),
            (
                "eoc-effects",
                "do_mining",
                "bounded_implemented_unverified",
                "services.activities",
            ),
            (
                "eoc-effects",
                "do_mopping",
                "bounded_implemented_unverified",
                "services.activities",
            ),
            (
                "eoc-effects",
                "do_read",
                "bounded_implemented_unverified",
                "services.activities",
            ),
            (
                "eoc-effects",
                "do_eread",
                "bounded_implemented_unverified",
                "services.activities",
            ),
            (
                "eoc-effects",
                "do_read_repeatedly",
                "bounded_implemented_unverified",
                "services.activities",
            ),
            (
                "eoc-effects",
                "do_study",
                "bounded_implemented_unverified",
                "services.activities",
            ),
            (
                "eoc-effects",
                "sort_loot",
                "bounded_implemented_unverified",
                "services.activities",
            ),
            (
                "eoc-effects",
                "do_craft",
                "bounded_implemented_unverified",
                "services.activities",
            ),
            (
                "eoc-effects",
                "do_disassembly",
                "bounded_implemented_unverified",
                "services.activities",
            ),
            (
                "eoc-effects",
                "do_vehicle_deconstruct",
                "bounded_implemented_unverified",
                "services.activities",
            ),
            (
                "eoc-effects",
                "do_vehicle_repair",
                "bounded_implemented_unverified",
                "services.activities",
            ),
            (
                "eoc-effects",
                "drop_items_in_place",
                "bounded_implemented_unverified",
                "services.activities",
            ),
            (
                "eoc-effects",
                "find_mount",
                "bounded_implemented_unverified",
                "services.activities",
            ),
            (
                "eoc-effects",
                "start_training",
                "bounded_implemented_unverified",
                "services.activities",
            ),
            (
                "eoc-effects",
                "start_training_seminar",
                "bounded_implemented_unverified",
                "services.activities",
            ),
            (
                "eoc-effects",
                "distribute_food_auto",
                "bounded_implemented_unverified",
                "services.activities",
            ),
            (
                "eoc-effects",
                "dismount",
                "bounded_implemented_unverified",
                "services.dialogue",
            ),
            (
                "eoc-effects",
                "lesser_give_aid",
                "bounded_implemented_unverified",
                "services.dialogue",
            ),
            (
                "eoc-effects",
                "give_all_aid",
                "bounded_implemented_unverified",
                "services.dialogue",
            ),
            (
                "eoc-effects",
                "lesser_give_all_aid",
                "bounded_implemented_unverified",
                "services.dialogue",
            ),
            (
                "eoc-effects",
                "open_dialogue",
                "bounded_implemented_unverified",
                "services.dialogue",
            ),
            (
                "eoc-effects",
                "pick_style",
                "bounded_implemented_unverified",
                "services.dialogue",
            ),
            (
                "eoc-effects",
                "take_control",
                "bounded_implemented_unverified",
                "services.dialogue",
            ),
            (
                "eoc-effects",
                "u_teleport",
                "bounded_implemented_unverified",
                "services.relocation",
            ),
            (
                "eoc-effects",
                "npc_teleport",
                "bounded_implemented_unverified",
                "services.relocation",
            ),
            (
                "eoc-effects",
                "u_set_goal",
                "bounded_implemented_unverified",
                "services.npcs",
            ),
            (
                "eoc-effects",
                "npc_set_goal",
                "bounded_implemented_unverified",
                "services.npcs",
            ),
            (
                "eoc-effects",
                "u_set_guard_pos",
                "bounded_implemented_unverified",
                "services.npcs",
            ),
            (
                "eoc-effects",
                "npc_set_guard_pos",
                "bounded_implemented_unverified",
                "services.npcs",
            ),
            (
                "eoc-effects",
                "goto_location",
                "bounded_implemented_unverified",
                "services.npcs",
            ),
            (
                "eoc-effects",
                "u_deal_damage",
                "bounded_implemented_unverified",
                "services.characters",
            ),
            (
                "eoc-effects",
                "npc_deal_damage",
                "bounded_implemented_unverified",
                "services.characters",
            ),
            (
                "eoc-effects",
                "u_pick_bodypart",
                "bounded_implemented_unverified",
                "services.characters",
            ),
            (
                "eoc-effects",
                "npc_pick_bodypart",
                "bounded_implemented_unverified",
                "services.characters",
            ),
            (
                "eoc-effects",
                "trigger_event",
                "bounded_implemented_unverified",
                "services.gameplay",
            ),
            (
                "eoc-effects",
                "set_browsed",
                "bounded_implemented_unverified",
                "services.dialogue",
            ),
            (
                "eoc-effects",
                "clear_dimension",
                "bounded_implemented_unverified",
                "services.dialogue",
            ),
            (
                "eoc-effects",
                "clear_overrides",
                "bounded_implemented_unverified",
                "services.dialogue",
            ),
            (
                "eoc-effects",
                "place_override",
                "bounded_implemented_unverified",
                "services.dialogue",
            ),
            (
                "eoc-effects",
                "custom_light_level",
                "bounded_implemented_unverified",
                "services.gameplay",
            ),
            (
                "eoc-effects",
                "u_activate",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-effects",
                "npc_activate",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-effects",
                "u_set_fault",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-effects",
                "npc_set_fault",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-effects",
                "u_set_random_fault_of_type",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-effects",
                "npc_set_random_fault_of_type",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-effects",
                "transform_item",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-effects",
                "transform_line",
                "bounded_implemented_unverified",
                "services.world",
            ),
            (
                "eoc-effects",
                "u_travel_to_dimension",
                "bounded_implemented_unverified",
                "services.relocation",
            ),
            (
                "json-object-types",
                "effect_on_condition",
                "bounded_implemented_unverified",
                "platform.runtime-events-and-functions",
            ),
            (
                "json-object-types",
                "MIGRATION",
                "bounded_implemented_unverified",
                "content.gameplay",
            ),
            (
                "json-object-types",
                "TRAIT_MIGRATION",
                "bounded_implemented_unverified",
                "content.mutations",
            ),
            (
                "json-object-types",
                "spell_migration",
                "bounded_implemented_unverified",
                "content.magic",
            ),
            (
                "json-object-types",
                "camp_migration",
                "bounded_implemented_unverified",
                "content.camps",
            ),
            (
                "json-object-types",
                "mod_migration",
                "bounded_implemented_unverified",
                "content.gameplay",
            ),
            (
                "json-object-types",
                "jmath_function",
                "bounded_implemented_unverified",
                "content.state-and-values",
            ),
            (
                "json-object-types",
                "event_statistic",
                "bounded_implemented_unverified",
                "content.gameplay",
            ),
            (
                "json-object-types",
                "event_transformation",
                "bounded_implemented_unverified",
                "content.gameplay",
            ),
            (
                "json-object-types",
                "widget",
                "bounded_implemented_unverified",
                "content.gameplay",
            ),
            (
                "json-object-types",
                "option_slider",
                "bounded_implemented_unverified",
                "content.gameplay",
            ),
            (
                "json-object-types",
                "palette",
                "bounded_implemented_unverified",
                "content.gameplay",
            ),
            (
                "json-object-types",
                "ter_furn_transform",
                "bounded_implemented_unverified",
                "content.gameplay",
            ),
            (
                "json-object-types",
                "profession_item_substitutions",
                "bounded_implemented_unverified",
                "content.items",
            ),
            (
                "json-object-types",
                "relic_procgen_data",
                "bounded_implemented_unverified",
                "content.gameplay",
            ),
            (
                "json-object-types",
                "dimension",
                "bounded_implemented_unverified",
                "content.gameplay",
            ),
            (
                "json-object-types",
                "dimension_region_layout",
                "bounded_implemented_unverified",
                "content.gameplay",
            ),
            (
                "json-object-types",
                "city",
                "bounded_implemented_unverified",
                "content.gameplay",
            ),
            (
                "json-object-types",
                "city_building",
                "bounded_implemented_unverified",
                "content.gameplay",
            ),
            (
                "json-object-types",
                "omt_placeholder",
                "bounded_implemented_unverified",
                "content.gameplay",
            ),
            (
                "json-object-types",
                "pp_generator",
                "bounded_implemented_unverified",
                "content.gameplay",
            ),
            (
                "json-object-types",
                "mod_tileset",
                "bounded_implemented_unverified",
                "content.gameplay",
            ),
            (
                "json-object-types",
                "region_settings",
                "bounded_implemented_unverified",
                "content.gameplay",
            ),
            (
                "json-object-types",
                "region_settings_city",
                "bounded_implemented_unverified",
                "content.gameplay",
            ),
            (
                "json-object-types",
                "region_settings_forest",
                "bounded_implemented_unverified",
                "content.gameplay",
            ),
            (
                "json-object-types",
                "region_settings_forest_mapgen",
                "bounded_implemented_unverified",
                "content.map",
            ),
            (
                "json-object-types",
                "region_settings_forest_trail",
                "bounded_implemented_unverified",
                "content.gameplay",
            ),
            (
                "json-object-types",
                "region_settings_highway",
                "bounded_implemented_unverified",
                "content.gameplay",
            ),
            (
                "json-object-types",
                "region_settings_lake",
                "bounded_implemented_unverified",
                "content.gameplay",
            ),
            (
                "json-object-types",
                "region_settings_map_extras",
                "bounded_implemented_unverified",
                "content.map",
            ),
            (
                "json-object-types",
                "region_settings_ocean",
                "bounded_implemented_unverified",
                "content.gameplay",
            ),
            (
                "json-object-types",
                "region_settings_ravine",
                "bounded_implemented_unverified",
                "content.gameplay",
            ),
            (
                "json-object-types",
                "region_settings_river",
                "bounded_implemented_unverified",
                "content.gameplay",
            ),
            (
                "json-object-types",
                "region_settings_terrain_furniture",
                "bounded_implemented_unverified",
                "content.map",
            ),
            (
                "json-object-types",
                "region_terrain_furniture",
                "bounded_implemented_unverified",
                "content.map",
            ),
            (
                "json-object-types",
                "forest_biome_component",
                "bounded_implemented_unverified",
                "content.gameplay",
            ),
            (
                "json-object-types",
                "forest_biome_mapgen",
                "bounded_implemented_unverified",
                "content.map",
            ),
            (
                "json-object-types",
                "enchantment",
                "bounded_implemented_unverified",
                "content.gameplay",
            ),
            (
                "json-object-types",
                "SPELL",
                "bounded_implemented_unverified",
                "content.magic",
            ),
            (
                "json-object-types",
                "bionic",
                "bounded_implemented_unverified",
                "content.bionics",
            ),
            (
                "json-object-types",
                "faction",
                "bounded_implemented_unverified",
                "content.factions",
            ),
            (
                "json-object-types",
                "faction_mission",
                "bounded_implemented_unverified",
                "content.missions",
            ),
            (
                "json-object-types",
                "mapgen",
                "bounded_implemented_unverified",
                "content.map",
            ),
            (
                "json-object-types",
                "mission_definition",
                "bounded_implemented_unverified",
                "content.missions",
            ),
            (
                "json-object-types",
                "mutation",
                "bounded_implemented_unverified",
                "content.mutations",
            ),
            (
                "json-object-types",
                "npc",
                "bounded_implemented_unverified",
                "content.characters",
            ),
            (
                "json-object-types",
                "npc_class",
                "bounded_implemented_unverified",
                "content.characters",
            ),
            (
                "json-object-types",
                "overmap_special",
                "bounded_implemented_unverified",
                "content.map",
            ),
            (
                "json-object-types",
                "overmap_terrain",
                "bounded_implemented_unverified",
                "content.map",
            ),
            (
                "json-object-types",
                "profession",
                "bounded_implemented_unverified",
                "content.gameplay",
            ),
            (
                "json-object-types",
                "talk_topic",
                "bounded_implemented_unverified",
                "content.gameplay",
            ),
            (
                "json-object-types",
                "vehicle",
                "bounded_implemented_unverified",
                "content.vehicles",
            ),
            (
                "json-object-types",
                "vehicle_part",
                "bounded_implemented_unverified",
                "content.vehicles",
            ),
            (
                "json-object-types",
                "vehicle_placement",
                "bounded_implemented_unverified",
                "content.vehicles",
            ),
            (
                "json-object-types",
                "vehicle_spawn",
                "bounded_implemented_unverified",
                "content.vehicles",
            ),
            (
                "eoc-effects",
                "u_assign_activity",
                "bounded_implemented_unverified",
                "services.activities",
            ),
            (
                "eoc-effects",
                "npc_assign_activity",
                "bounded_implemented_unverified",
                "services.activities",
            ),
            (
                "eoc-conditions",
                "npc_has_activity",
                "bounded_implemented_unverified",
                "services.activities",
            ),
            (
                "eoc-effects",
                "math",
                "bounded_implemented_unverified",
                "services.state-and-values",
            ),
            (
                "eoc-effects",
                "copy_var",
                "bounded_implemented_unverified",
                "services.state-and-values",
            ),
            (
                "eoc-effects",
                "add_debt",
                "bounded_implemented_unverified",
                "services.state-and-values",
            ),
            (
                "eoc-effects",
                "set_string_var",
                "bounded_implemented_unverified",
                "services.state-and-values",
            ),
            (
                "eoc-conditions",
                "expects_vars",
                "bounded_implemented_unverified",
                "services.state-and-values",
            ),
            (
                "eoc-conditions",
                "math",
                "bounded_implemented_unverified",
                "services.state-and-values",
            ),
            (
                "eoc-effects",
                "alter_timed_events",
                "bounded_implemented_unverified",
                "services.time-weather",
            ),
            (
                "eoc-effects",
                "lightning",
                "bounded_implemented_unverified",
                "services.time-weather",
            ),
            (
                "eoc-effects",
                "next_weather",
                "bounded_implemented_unverified",
                "services.time-weather",
            ),
            (
                "eoc-effects",
                "mirror_coordinates",
                "bounded_implemented_unverified",
                "services.coords",
            ),
            (
                "eoc-effects",
                "sample_range",
                "bounded_implemented_unverified",
                "services.random",
            ),
            (
                "eoc-effects",
                "dimension_name",
                "bounded_implemented_unverified",
                "services.gameplay.environment",
            ),
            (
                "eoc-effects",
                "u_add_faction_trust",
                "bounded_implemented_unverified",
                "services.factions",
            ),
            (
                "eoc-effects",
                "u_set_fac_relation",
                "bounded_implemented_unverified",
                "services.factions",
            ),
            (
                "eoc-effects",
                "npc_set_fac_relation",
                "bounded_implemented_unverified",
                "services.factions",
            ),
            (
                "eoc-conditions",
                "line_of_sight",
                "bounded_implemented_unverified",
                "services.gameplay.environment",
            ),
            (
                "eoc-effects",
                "closest_city",
                "bounded_implemented_unverified",
                "services.overmap",
            ),
            (
                "eoc-effects",
                "take_control_menu",
                "bounded_implemented_unverified",
                "services.presentation",
            ),
            (
                "eoc-effects",
                "add_mission",
                "bounded_implemented_unverified",
                "services.missions",
            ),
            (
                "eoc-effects",
                "basecamp_mission",
                "bounded_implemented_unverified",
                "services.missions",
            ),
            (
                "eoc-effects",
                "clear_mission",
                "bounded_implemented_unverified",
                "services.missions",
            ),
            (
                "eoc-effects",
                "companion_mission",
                "bounded_implemented_unverified",
                "services.missions",
            ),
            (
                "eoc-effects",
                "finish_mission",
                "bounded_implemented_unverified",
                "services.missions",
            ),
            (
                "eoc-effects",
                "mission_failure",
                "bounded_implemented_unverified",
                "services.missions",
            ),
            (
                "eoc-effects",
                "assign_mission",
                "bounded_implemented_unverified",
                "services.missions-and-dialogue",
            ),
            (
                "eoc-conditions",
                "mission_goal",
                "bounded_implemented_unverified",
                "services.missions",
            ),
            (
                "eoc-conditions",
                "mission_has_generic_rewards",
                "bounded_implemented_unverified",
                "services.missions",
            ),
            (
                "eoc-conditions",
                "npc_mission_goal",
                "bounded_implemented_unverified",
                "services.missions",
            ),
            (
                "eoc-effects",
                "abandon_camp",
                "bounded_implemented_unverified",
                "services.camps",
            ),
            (
                "eoc-effects",
                "assign_camp",
                "bounded_implemented_unverified",
                "services.camps",
            ),
            (
                "eoc-effects",
                "return_to_camp_duties",
                "bounded_implemented_unverified",
                "services.camps",
            ),
            (
                "eoc-effects",
                "start_camp",
                "bounded_implemented_unverified",
                "services.camps",
            ),
            (
                "eoc-effects",
                "bionic_install",
                "bounded_implemented_unverified",
                "services.bionics",
            ),
            (
                "eoc-effects",
                "bionic_install_allies",
                "bounded_implemented_unverified",
                "services.bionics",
            ),
            (
                "eoc-effects",
                "bionic_remove",
                "bounded_implemented_unverified",
                "services.bionics",
            ),
            (
                "eoc-effects",
                "bionic_remove_allies",
                "bounded_implemented_unverified",
                "services.bionics",
            ),
            (
                "eoc-effects",
                "repair_bionic_limbs",
                "bounded_implemented_unverified",
                "services.bionics",
            ),
            (
                "eoc-effects",
                "quote_vehicle_full_repair",
                "bounded_implemented_unverified",
                "services.vehicles",
            ),
            (
                "eoc-effects",
                "select_vehicle_part_service",
                "bounded_implemented_unverified",
                "services.vehicles",
            ),
            (
                "eoc-effects",
                "start_vehicle_full_repair",
                "bounded_implemented_unverified",
                "services.vehicles",
            ),
            (
                "eoc-effects",
                "npc_run_vehicle_eocs",
                "bounded_implemented_unverified",
                "services.vehicles",
            ),
            (
                "eoc-effects",
                "u_run_vehicle_eocs",
                "bounded_implemented_unverified",
                "services.vehicles",
            ),
            (
                "eoc-effects",
                "copy_location",
                "bounded_implemented_unverified",
                "services.map",
            ),
            (
                "eoc-effects",
                "location_variable_adjust",
                "bounded_implemented_unverified",
                "services.map",
            ),
            (
                "eoc-effects",
                "mapgen_update",
                "bounded_implemented_unverified",
                "services.map",
            ),
            (
                "eoc-effects",
                "npc_location_variable",
                "bounded_implemented_unverified",
                "services.map",
            ),
            (
                "eoc-effects",
                "npc_map_run_eocs",
                "bounded_implemented_unverified",
                "services.map",
            ),
            (
                "eoc-effects",
                "npc_set_field",
                "bounded_implemented_unverified",
                "services.map",
            ),
            (
                "eoc-conditions",
                "npc_at_om_location",
                "bounded_implemented_unverified",
                "services.map",
            ),
            (
                "eoc-conditions",
                "npc_can_see_location",
                "bounded_implemented_unverified",
                "services.map",
            ),
            (
                "eoc-conditions",
                "npc_near_om_location",
                "bounded_implemented_unverified",
                "services.map",
            ),
            (
                "eoc-conditions",
                "overmap_at_point",
                "bounded_implemented_unverified",
                "services.map",
            ),
            (
                "eoc-conditions",
                "u_at_om_location",
                "bounded_implemented_unverified",
                "services.map",
            ),
            (
                "eoc-conditions",
                "u_can_see_location",
                "bounded_implemented_unverified",
                "services.map",
            ),
            (
                "eoc-conditions",
                "has_ammo",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-conditions",
                "is_rotten",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-conditions",
                "npc_can_drop_weapon",
                "bounded_implemented_unverified",
                "services.inventory-and-martial-arts",
            ),
            (
                "eoc-conditions",
                "npc_has_item",
                "bounded_implemented_unverified",
                "services.inventory",
            ),
            (
                "eoc-conditions",
                "npc_has_item_category",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-conditions",
                "npc_has_item_with_flag",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-conditions",
                "npc_has_items",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-conditions",
                "npc_has_items_sum",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-conditions",
                "npc_has_weapon",
                "bounded_implemented_unverified",
                "services.inventory-and-martial-arts",
            ),
            (
                "eoc-conditions",
                "npc_has_wielded_with_ammotype",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-conditions",
                "npc_has_wielded_with_flag",
                "bounded_implemented_unverified",
                "services.inventory-and-items",
            ),
            (
                "eoc-conditions",
                "npc_has_wielded_with_skill",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-conditions",
                "npc_has_wielded_with_weapon_category",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-conditions",
                "u_has_item_category",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-conditions",
                "u_has_item_with_flag",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-conditions",
                "u_has_items",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-conditions",
                "u_has_items_sum",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-conditions",
                "u_has_wielded_with_ammotype",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-conditions",
                "u_has_wielded_with_skill",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-conditions",
                "u_has_wielded_with_weapon_category",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-conditions",
                "u_near_om_location",
                "bounded_implemented_unverified",
                "services.map",
            ),
            (
                "eoc-effects",
                "drop_stolen_item",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-effects",
                "drop_weapon",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-effects",
                "give_equipment",
                "bounded_implemented_unverified",
                "services.inventory-and-presentation",
            ),
            (
                "eoc-effects",
                "mission_reward",
                "bounded_implemented_unverified",
                "services.missions",
            ),
            (
                "eoc-effects",
                "mission_success",
                "bounded_implemented_unverified",
                "services.missions",
            ),
            (
                "eoc-effects",
                "npc_consume_item",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-effects",
                "npc_consume_item_sum",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-effects",
                "npc_gets_item",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-effects",
                "npc_gets_item_to_use",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-effects",
                "npc_map_run_item_eocs",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-effects",
                "npc_pickup_items",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-effects",
                "npc_remove_item_with",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-effects",
                "offer_mission",
                "bounded_implemented_unverified",
                "services.missions",
            ),
            (
                "eoc-effects",
                "player_weapon_drop",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-effects",
                "quote_npc_trade_item",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-effects",
                "remove_active_mission",
                "bounded_implemented_unverified",
                "services.missions",
            ),
            (
                "eoc-effects",
                "reveal_map",
                "bounded_implemented_unverified",
                "services.map",
            ),
            (
                "eoc-effects",
                "revert_location",
                "bounded_implemented_unverified",
                "services.map",
            ),
            (
                "eoc-effects",
                "set_furniture",
                "bounded_implemented_unverified",
                "services.map",
            ),
            (
                "eoc-effects",
                "set_item_category_spawn_rates",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-effects",
                "set_terrain",
                "bounded_implemented_unverified",
                "services.map",
            ),
            (
                "eoc-effects",
                "u_buy_item",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-effects",
                "u_consume_item",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-effects",
                "u_consume_item_sum",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-effects",
                "u_location_variable",
                "bounded_implemented_unverified",
                "services.map",
            ),
            (
                "eoc-effects",
                "u_map_run_eocs",
                "bounded_implemented_unverified",
                "services.map",
            ),
            (
                "eoc-effects",
                "u_map_run_item_eocs",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-effects",
                "u_pickup_items",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-effects",
                "u_remove_item_with",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-effects",
                "u_sell_item",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-effects",
                "u_set_field",
                "bounded_implemented_unverified",
                "services.map",
            ),
            (
                "eoc-effects",
                "u_set_flag",
                "bounded_implemented_unverified",
                "services.items",
            ),
            (
                "eoc-effects",
                "u_unset_flag",
                "bounded_implemented_unverified",
                "services.items",
            ),
        }:
            if (
                inventory == "json-object-types" and
                selector in PLANNED_JSON
            ) or (
                inventory == "eoc-effects" and
                selector == "transform_item"
            ):
                continue
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

    def test_missing_native_registrars_and_item_transform_are_planned(self):
        expected_content = {
            "jmath_function", "event_statistic", "event_transformation",
            "widget", "option_slider", "palette", "ter_furn_transform",
            "profession_item_substitutions", "relic_procgen_data",
            "dimension", "dimension_region_layout",
            "city_building", "omt_placeholder", "pp_generator",
            "mod_tileset",
            "enchantment", "SPELL", "bionic",
            "faction", "mapgen", "mission_definition",
            "mutation", "npc", "npc_class", "overmap_special",
            "overmap_terrain", "profession", "talk_topic", "vehicle",
            "vehicle_part", "vehicle_placement", "vehicle_spawn",
        }
        self.assertEqual(set(PLANNED_JSON), expected_content)

        generated = build_ledger()
        entries = {
            (entry["inventory"], entry["selector"]): entry
            for entry in generated["entries"]
        }
        for selector in expected_content:
            entry = entries[("json-object-types", selector)]
            self.assertEqual(entry["status"], "planned")
            self.assertEqual(entry["legacy_dependency"], "public_legacy")

        transform = entries[("eoc-effects", "transform_item")]
        self.assertEqual(transform["status"], "planned")
        self.assertEqual(transform["legacy_dependency"], "public_legacy")



if __name__ == "__main__":
    unittest.main()
