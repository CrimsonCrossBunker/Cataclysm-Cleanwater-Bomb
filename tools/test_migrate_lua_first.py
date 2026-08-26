from __future__ import annotations

import json
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

import migrate_lua_first


class LuaFirstMigrationTest(unittest.TestCase):
    def test_game_start_avatar_proof_tracks_the_canonical_sender_set(self) -> None:
        self.assertEqual(
            migrate_lua_first.game_start_sender_sites(),
            migrate_lua_first.EXPECTED_GAME_START_SENDER_SITES,
        )
        self.assertTrue(migrate_lua_first.game_start_avatar_actor_is_proven())

        with tempfile.TemporaryDirectory() as temporary:
            with patch.object(
                migrate_lua_first, "REPOSITORY_ROOT", Path(temporary)
            ):
                migrate_lua_first.game_start_sender_sites.cache_clear()
                self.assertFalse(
                    migrate_lua_first.game_start_avatar_actor_is_proven()
                )
        migrate_lua_first.game_start_sender_sites.cache_clear()

    def test_directory_discovery_prunes_build_caches(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            (root / "content").mkdir()
            (root / "content" / "item.json").write_text(
                '{"type":"GENERIC","id":"kept"}', encoding="utf-8"
            )
            (root / "obj-lua").mkdir()
            (root / "obj-lua" / "cached.json").write_text(
                "not valid JSON and must never be read", encoding="utf-8"
            )

            objects = migrate_lua_first.load_objects([root])
            self.assertEqual([entry.value["id"] for entry in objects], ["kept"])

    def test_loader_accepts_game_json_comments_and_trailing_commas(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                """[
  // Real game data permits comments.
  { "type": "GENERIC", "id": "kept", },
]
""",
                encoding="utf-8",
            )
            objects = migrate_lua_first.load_objects([source])
            self.assertEqual([entry.value["id"] for entry in objects], ["kept"])

    def test_mod_info_and_literal_item_shapes_are_audited_as_bounded(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "MOD_INFO",
                            "id": "bounded_mod",
                            "name": "Bounded Mod",
                            "version": "1.2.3",
                            "dependencies": ["dda"],
                            "core": False,
                        },
                        {
                            "type": "ITEM",
                            "id": "bounded_item",
                            "name": "bounded item",
                        },
                    ]
                ),
                encoding="utf-8",
            )

            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "bounded_mod"
            )
            metadata = result.files[Path("mod.lua")]
            main = result.files[Path("main.lua")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(len(result.partial), 0)
            self.assertIn('id = "bounded_mod"', metadata)
            self.assertIn('name = "Bounded Mod"', metadata)
            self.assertIn('version = "1.2.3"', metadata)
            self.assertIn('dependencies = { "dda" }', metadata)
            self.assertIn("core = false", metadata)
            self.assertIn("content.Item", main)
            self.assertIn('id = "bounded_item"', main)

    def test_mod_info_reports_every_field_outside_the_bounded_shape(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "MOD_INFO",
                        "id": "bounded_mod",
                        "name": "Bounded Mod",
                        "authors": ["Legacy Author"],
                        "description": "Not silently discarded",
                    }
                ),
                encoding="utf-8",
            )

            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "bounded_mod"
            )
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(result.converted, [])
            self.assertEqual(len(result.partial), 1)
            self.assertIn("MOD_INFO unresolved fields: authors, description", report)

    def test_emits_native_lua_and_explicit_todos_without_legacy_calls(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            source = root / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "GENERIC",
                            "id": "sample_item",
                            "name": "sample",
                            "weight": "250 g",
                            "volume": "1 L",
                            "material": [["steel", 2]],
                            "flags": ["DURABLE_MELEE"],
                            "pocket_data": [],
                        },
                        {
                            "type": "recipe",
                            "id": "sample_recipe",
                            "result": "sample_item",
                            "time": "2 s",
                            "components": [[["scrap", 2], ["steel_chunk", 1]]],
                            "tools": [[["hammer", 1], ["rock", 1]]],
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "sample_event",
                            "required_event": "game_start",
                            "effect": {"message": "hello"},
                        },
                        {"type": "vehicle", "id": "needs_native_registrar"},
                    ]
                ),
                encoding="utf-8",
            )
            objects = migrate_lua_first.load_objects([source])
            result = migrate_lua_first.migrate(objects, "sample_mod")
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertIn("content.Item", main)
            self.assertIn("definition:mass_grams(250)", main)
            self.assertIn("definition:volume_ml(1000)", main)
            self.assertIn("definition:component_any", main)
            self.assertIn("definition:tool_any", main)
            self.assertIn('runtime.on("game:game_start"', main)
            self.assertNotIn("run_eoc", main)
            self.assertNotIn("load_json", main)
            self.assertNotIn('"type":', main)
            self.assertIn("pocket_data", report)
            self.assertIn("content.Vehicle", main)
            self.assertNotIn("has no native Platform registrar", report)

    def test_item_subtypes_and_inheritance_are_never_reported_as_complete(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {"type": "ARMOR", "id": "sample_armor", "name": "armor"},
                        {
                            "type": "GENERIC",
                            "id": "derived_item",
                            "copy-from": "base_item",
                            "name": "derived",
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "sample_mod"
            )
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(result.converted, [])
            self.assertEqual(len(result.partial), 2)
            self.assertIn("ARMOR subtype", report)
            self.assertIn("inheritance must become", report)

    def test_translates_bounded_eoc_predicates_into_lua_composition(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            predicates = [
                {"compare_string": ["a", "b", "a"]},
                {"compare_string_match_all": ["same", "same"]},
                {"one_in_chance": 3},
                {"x_in_y_chance": {"x": 1.5, "y": 4.0}},
                {"roll_contested": 2, "difficulty": 5, "die_size": 8},
                {"mod_is_loaded": "dda"},
                {"current_dimension": "default"},
                {"is_season": "spring"},
                {"is_weather": "rain"},
                "is_day",
                "is_night",
                {"u_has_trait": "SAMPLE_TRAIT"},
                {"u_has_any_trait": ["SAMPLE_TRAIT", "TOUGH"]},
                {"u_has_martial_art": "style_karate"},
                {"u_using_martial_art": "style_karate"},
                {"u_has_proficiency": "prof_knapping"},
                {"u_has_bionics": "bio_earplugs"},
                {"u_has_item": "water_clean"},
                {"u_has_move_mode": "walk"},
                "u_has_activity",
                {"u_has_activity": "ignored"},
                {
                    "compare_string": [
                        "expected",
                        {"context_val": "event_value"},
                        {"u_val": "remembered_value"},
                    ]
                },
                {
                    "and": [
                        {"one_in_chance": 2},
                        {"not": {"mod_is_loaded": "missing_mod"}},
                    ]
                },
            ]
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": f"predicate_{index}",
                            "required_event": "game_start",
                            "condition": predicate,
                            "effect": {"message": f"predicate {index}"},
                        }
                        for index, predicate in enumerate(predicates)
                    ]
                ),
                encoding="utf-8",
            )

            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "predicate_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), len(predicates))
            self.assertEqual(result.partial, [])
            self.assertIn("services.gameplay.strings.any_equal", main)
            self.assertIn("services.gameplay.strings.all_equal", main)
            self.assertIn("services.random.one_in(3)", main)
            self.assertIn("services.random.probability(1.5, 4)", main)
            self.assertIn("services.random.contested(2, 5, 8)", main)
            self.assertIn('services.gameplay.mods.is_loaded("dda")', main)
            self.assertIn(
                'services.gameplay.environment.dimension() == "default"',
                main,
            )
            self.assertIn(
                'services.time_snapshot().season_id == "spring"',
                main,
            )
            self.assertIn(
                'services.weather.current().weather.value == "rain"',
                main,
            )
            self.assertIn(
                "not services.gameplay.environment.is_night()", main
            )
            self.assertIn("services.gameplay.environment.is_night()", main)
            self.assertEqual(main.count("local function service_value"), 1)
            self.assertIn(
                'services.types.id("mutation", "SAMPLE_TRAIT")',
                main,
            )
            self.assertIn('services.types.id("mutation", "TOUGH")', main)
            self.assertIn(
                'services.types.id("martial_art", "style_karate")',
                main,
            )
            self.assertIn(
                'services.types.id("proficiency", "prof_knapping")',
                main,
            )
            self.assertIn(
                'services.types.id("bionic", "bio_earplugs")',
                main,
            )
            self.assertIn("services.mutations.has", main)
            self.assertIn("services.martial_arts.get", main)
            self.assertIn("services.proficiencies.get", main)
            self.assertIn("services.bionics.has", main)
            self.assertIn("services.inventory.resources", main)
            self.assertIn(
                'services.inventory.resources(actor, services.types.id("item", "water_clean"), 1)',
                main,
            )
            self.assertIn("services.characters.snapshot(actor)", main)
            self.assertIn('.movement.id == "walk"', main)
            self.assertIn("services.activities.snapshot(actor)", main)
            self.assertIn('tostring((context.data["event_value"]) or "")', main)
            self.assertIn(
                'services.variables.resolve(context.data, actor, "u", "remembered_value")',
                main,
            )
            self.assertIn("not (services.gameplay.mods.is_loaded", main)
            self.assertNotIn("condition needs a native Lua predicate", report)

    def test_translates_proven_actor_effect_predicates(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "avatar_effect",
                            "required_event": "game_start",
                            "condition": {"u_has_effect": "downed"},
                            "effect": {"message": "avatar"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "avatar_any_effect",
                            "required_event": "game_start",
                            "condition": {
                                "u_has_any_effect": ["downed", "blind"]
                            },
                            "effect": {"message": "avatar any"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "avatar_effect_qualified",
                            "required_event": "game_start",
                            "condition": {
                                "u_has_effect": "downed",
                                "bodypart": "torso",
                                "intensity": 1,
                            },
                            "effect": {"message": "avatar qualified"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_effect",
                            "required_event": "npc_becomes_hostile",
                            "condition": {"npc_has_effect": "downed"},
                            "effect": {"message": "npc"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "dynamic_effect",
                            "required_event": "game_start",
                            "condition": {
                                "u_has_effect": {"context_val": "effect_id"}
                            },
                            "effect": {"message": "dynamic"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "unproven_npc_effect",
                            "required_event": "game_start",
                            "condition": {"npc_has_effect": "downed"},
                            "effect": {"message": "unproven"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "effect_predicate_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 5)
            self.assertEqual(len(result.partial), 1)
            self.assertIn(
                'services.effects.has(actor, services.types.id("effect", "downed"))',
                main,
            )
            self.assertIn(
                'services.types.id("effect", "blind")',
                main,
            )
            self.assertIn(
                'services.effects.has(actor, services.types.id("effect", "downed"), services.types.id("body_part", "torso"), 1)',
                main,
            )
            self.assertNotIn(
                "EOC dynamic_effect condition needs a native Lua predicate",
                report,
            )
            self.assertIn(
                "EOC unproven_npc_effect condition needs a native Lua predicate",
                report,
            )
            self.assertNotIn("run_eoc", main)

    def test_translates_literal_avatar_faction_trust_condition(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "trust_gate",
                        "required_event": "game_start",
                        "condition": {"u_has_faction_trust": 12},
                        "effect": {"message": "trusted"},
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "faction_condition_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertIn(
                "service_value(services.factions.player()).reputation.trusts >= 12",
                main,
            )
            self.assertNotIn("condition needs a native Lua predicate", report)
            self.assertNotIn("run_eoc", main)

    def test_translates_dialogue_predicate_services_for_proven_avatars(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            predicates = [
                "u_is_travelling",
                "u_at_safe_space",
                "u_has_pickup_list",
                "player_see_u",
            ]
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": f"predicate_{index}",
                            "required_event": "game_start",
                            "condition": predicate,
                            "effect": {"message": f"predicate {index}"},
                        }
                        for index, predicate in enumerate(predicates)
                    ]
                ),
                encoding="utf-8",
            )

            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "predicate_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), len(predicates))
            self.assertEqual(result.partial, [])
            self.assertIn("local function character_travel_has_path", main)
            self.assertIn("character_travel_has_path(actor)", main)
            self.assertIn(".travel.has_path", main)
            self.assertIn("local function character_at_safe_space", main)
            self.assertIn("character_at_safe_space(actor)", main)
            self.assertIn("services.overmap.is_safe(position)", main)
            self.assertIn("services.characters.is_safe(character)", main)
            self.assertIn(
                "local function character_has_pickup_whitelist", main
            )
            self.assertIn("character_has_pickup_whitelist(actor)", main)
            self.assertIn("services.npcs.ai_rules(character)", main)
            self.assertIn("services.creatures.can_see", main)
            self.assertIn("services.creatures.avatar()", main)
            self.assertNotIn("condition needs a native Lua predicate", report)

    def test_dialogue_predicates_without_actor_proof_stay_partial(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            predicates = [
                "npc_is_travelling",
                "at_safe_space",
                "has_pickup_list",
                "player_see_npc",
                "is_rotten",
                "is_by_radio",
                "has_reason",
            ]
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": f"predicate_{index}",
                            "required_event": "unproven_dialogue_event",
                            "condition": predicate,
                            "effect": {"message": f"predicate {index}"},
                        }
                        for index, predicate in enumerate(predicates)
                    ]
                ),
                encoding="utf-8",
            )

            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "predicate_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(result.converted, [])
            self.assertEqual(len(result.partial), len(predicates))
            self.assertIn(
                "condition needs a native Lua predicate", report
            )

    def test_translates_bounded_weapon_predicates_for_proven_u_actors(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            cases = [
                ("game_start", "u_has_weapon"),
                ("game_start", "u_can_drop_weapon"),
                (
                    "game_start",
                    {"u_has_wielded_with_flag": "SPEAR"},
                ),
                ("character_wields_item", "u_has_weapon"),
                ("character_wears_item", "u_can_drop_weapon"),
                (
                    "character_takeoff_item",
                    {"u_has_wielded_with_flag": "DURABLE_MELEE"},
                ),
                (
                    "character_armor_destroyed",
                    {"not": "u_has_weapon"},
                ),
            ]
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": f"weapon_{index}",
                            "required_event": event,
                            "condition": condition,
                            "effect": {"message": "bounded weapon predicate"},
                        }
                        for index, (event, condition) in enumerate(cases)
                    ]
                ),
                encoding="utf-8",
            )

            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "weapon_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(len(result.converted), len(cases))
            self.assertEqual(result.partial, [])
            self.assertEqual(main.count("local function character_has_weapon"), 1)
            self.assertEqual(
                main.count("local function character_can_drop_weapon"), 1
            )
            self.assertEqual(
                main.count("local function character_wields_with_flag"), 0
            )
            self.assertIn("services.inventory.wielded_matches(actor", main)
            self.assertIn("services.inventory.wielded(character)", main)
            self.assertIn("services.martial_arts.current(character)", main)
            self.assertIn("return not style.force_unarmed", main)
            self.assertIn('services.types.id("json_flag", "NO_UNWIELD")', main)
            self.assertIn("services.items.has_flag(", main)
            self.assertIn('services.types.id("json_flag", "SPEAR")', main)
            self.assertIn(
                'services.types.id("json_flag", "DURABLE_MELEE")', main
            )
            self.assertEqual(
                main.count("context.actors.character"), 4
            )
            self.assertIn(
                "local actor = actor_override or services.characters.avatar()",
                main,
            )
            self.assertNotIn("context.alpha", main)
            self.assertNotIn("context.beta", main)

    def test_weapon_predicates_without_exact_shape_or_actor_proof_stay_partial(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            cases = [
                ("character_kills_monster", "u_has_weapon"),
                ("game_start", "npc_has_weapon"),
                ("character_wields_item", "npc_can_drop_weapon"),
                ([], "u_has_weapon"),
                ("game_start", {"u_has_weapon": True}),
                (
                    "game_start",
                    {
                        "u_has_wielded_with_flag": {
                            "context_val": "dynamic_flag"
                        }
                    },
                ),
                (
                    "game_start",
                    {"npc_has_wielded_with_flag": "SPEAR"},
                ),
                (
                    "game_start",
                    {"u_has_wielded_with_flag": "X" * 257},
                ),
            ]
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": f"unsafe_weapon_{index}",
                            "required_event": event,
                            "condition": condition,
                            "effect": {"message": "must remain partial"},
                        }
                        for index, (event, condition) in enumerate(cases)
                    ]
                ),
                encoding="utf-8",
            )

            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "weapon_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(len(result.partial), 6)
            self.assertIn("local function character_has_weapon", main)
            self.assertNotIn("local function character_can_drop_weapon", main)
            self.assertNotIn("local function character_wields_with_flag", main)
            self.assertIn("services.inventory.wielded_matches", main)
            self.assertEqual(
                report.count("condition needs a native Lua predicate"),
                5,
            )

    def test_item_event_npc_flag_effects_use_optional_item_actor_guard(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            cases = [
                ("character_wields_item", {"npc_set_flag": "FILTHY"}),
                ("character_wears_item", {"npc_unset_flag": "WET"}),
                ("character_takeoff_item", {"npc_set_flag": "FIT"}),
                (
                    "character_armor_destroyed",
                    {"npc_unset_flag": "NO_UNWIELD"},
                ),
            ]
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": f"item_flag_{index}",
                            "required_event": event,
                            "effect": effect,
                        }
                        for index, (event, effect) in enumerate(cases)
                    ]
                ),
                encoding="utf-8",
            )

            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "item_flag_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(len(result.converted), len(cases))
            self.assertEqual(result.partial, [])
            self.assertEqual(
                main.count("if context.actors.item ~= nil then"), len(cases)
            )
            self.assertEqual(
                main.count("services.items.set_flag("), len(cases)
            )
            self.assertIn('services.types.id("json_flag", "FILTHY"), true)', main)
            self.assertIn('services.types.id("json_flag", "WET"), false)', main)
            self.assertNotIn("context.alpha", main)
            self.assertNotIn("context.beta", main)

    def test_item_event_npc_variables_use_optional_item_actor_guard(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps([
                    {
                        "type": "effect_on_condition",
                        "id": "item_variable_wield",
                        "required_event": "character_wields_item",
                        "effect": {
                            "npc_add_var": "last_event",
                            "value": "character_wields_item",
                        },
                    },
                    {
                        "type": "effect_on_condition",
                        "id": "item_variable_wear",
                        "required_event": "character_wears_item",
                        "effect": {
                            "npc_add_var": "last_event",
                            "value": "character_wears_item",
                        },
                    },
                ]),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "item_variable_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(result.partial, [])
            self.assertEqual(
                main.count("if context.actors.item ~= nil then"), 2
            )
            self.assertEqual(
                main.count("services.variables.set("), 2
            )
            self.assertIn("context.actors.item", main)

    def test_unsafe_or_wrong_talker_flag_effects_never_emit_item_mutation(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            cases = [
                ("game_start", {"npc_set_flag": "FILTHY"}),
                ("character_kills_monster", {"npc_unset_flag": "WET"}),
                ("character_wields_item", {"u_set_flag": "FILTHY"}),
                ("character_wears_item", {"u_unset_flag": "WET"}),
                (
                    "character_takeoff_item",
                    {"npc_set_flag": {"context_val": "dynamic_flag"}},
                ),
                (
                    "character_armor_destroyed",
                    {"npc_unset_flag": "X" * 257},
                ),
            ]
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": f"unsafe_item_flag_{index}",
                            "required_event": event,
                            "effect": effect,
                        }
                        for index, (event, effect) in enumerate(cases)
                    ]
                ),
                encoding="utf-8",
            )

            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "item_flag_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(result.converted, [])
            self.assertEqual(len(result.partial), len(cases))
            self.assertNotIn("services.items.set_flag", main)
            self.assertEqual(
                report.count("effect #0 needs domain-service conversion"),
                len(cases),
            )

    def test_item_traversal_branches_inherit_item_actor_for_npc_flags(self) -> None:
        """Nested item EOCs keep the selected item handle through ``if``."""
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "item_traversal_parent",
                            "effect": {
                                "u_run_inv_eocs": "all",
                                "search_data": [{"worn_only": True}],
                                "true_eocs": [
                                    {
                                        "id": "item_traversal_child",
                                        "effect": [
                                            {
                                                "if": {
                                                    "and": [
                                                        {
                                                            "not": {
                                                                "npc_has_flag": "SEMITANGIBLE"
                                                            }
                                                        },
                                                        {
                                                            "not": {
                                                                "npc_has_flag": "UNRESTRICTED"
                                                            }
                                                        },
                                                        {
                                                            "not": {
                                                                "npc_has_flag": "INTEGRATED"
                                                            }
                                                        },
                                                    ]
                                                },
                                                "then": [
                                                    {"npc_set_flag": "SHAPESHIFTED_ARMOR"},
                                                    {"npc_set_flag": "SEMITANGIBLE"},
                                                    {"npc_set_flag": "UNRESTRICTED"},
                                                    {"npc_set_flag": "INTANGIBLE_ARMOR"},
                                                    {"npc_set_flag": "UNBREAKABLE"},
                                                ],
                                            }
                                        ],
                                    }
                                ],
                            },
                        }
                    ]
                ),
                encoding="utf-8",
            )

            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "nested_item_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertIn("migrated_eoc_item_traversal_child__if_then__0", main)
            self.assertEqual(main.count("services.items.set_flag("), 5)
            self.assertEqual(main.count("context.actors.item ~= nil"), 5)
            self.assertNotIn("item_traversal_child__if_then__0 effect #0", report)
            self.assertNotIn("needs domain-service conversion", report)

    def test_literal_character_wound_changes_use_typed_service(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "add_avatar_wound",
                            "required_event": "game_start",
                            "effect": {
                                "u_add_wound": "arm_l",
                                "wound_id": "scratch",
                            },
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "remove_avatar_wounds",
                            "required_event": "game_start",
                            "effect": {
                                "u_remove_wound": "arm_l",
                                "wound_id": ["scratch", "deep_scratch"],
                            },
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "add_named_character_wound",
                            "required_event": "character_wields_item",
                            "effect": {
                                "u_add_wound": "hand_r",
                                "wound_id": "cut",
                            },
                        },
                    ]
                ),
                encoding="utf-8",
            )

            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "wound_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 3)
            self.assertEqual(result.partial, [])
            self.assertIn("services.wounds.add", main)
            self.assertIn("services.wounds.remove", main)
            self.assertIn("services.characters.avatar()", main)
            self.assertIn("context.actors.character", main)
            self.assertIn(
                'services.types.id("body_part", "arm_l")',
                main,
            )
            self.assertIn(
                'services.types.id("wound", "deep_scratch")',
                main,
            )
            self.assertNotIn("needs domain-service conversion", report)
            self.assertNotIn("context.alpha", main)
            self.assertNotIn("context.beta", main)
            self.assertNotIn("run_eoc", main)

    def test_unproven_or_nonliteral_wound_shapes_remain_partial(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            cases = [
                (
                    "game_start",
                    {"npc_add_wound": "arm_l", "wound_id": "scratch"},
                ),
                (
                    "game_start",
                    {
                        "npc_remove_wound": "arm_l",
                        "wound_id": ["scratch"],
                    },
                ),
                (
                    "character_kills_monster",
                    {"u_add_wound": "arm_l", "wound_id": "scratch"},
                ),
                (
                    "game_start",
                    {
                        "u_add_wound": {"context_val": "body_part"},
                        "wound_id": "scratch",
                    },
                ),
                (
                    "game_start",
                    {
                        "u_add_wound": "arm_l",
                        "wound_id": {"context_val": "wound"},
                    },
                ),
                (
                    "game_start",
                    {"u_remove_wound": "arm_l", "wound_id": "scratch"},
                ),
                (
                    "game_start",
                    {"u_remove_wound": "arm_l", "wound_id": []},
                ),
                (
                    "game_start",
                    {
                        "u_remove_wound": "arm_l",
                        "wound_id": ["scratch", {"context_val": "wound"}],
                    },
                ),
                (
                    "game_start",
                    {
                        "u_add_wound": "arm_l",
                        "wound_id": "scratch",
                        "unexpected": True,
                    },
                ),
                (
                    [],
                    {"u_add_wound": "arm_l", "wound_id": "scratch"},
                ),
            ]
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": f"unsafe_wound_{index}",
                            "required_event": event,
                            "effect": effect,
                        }
                        for index, (event, effect) in enumerate(cases)
                    ]
                ),
                encoding="utf-8",
            )

            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "wound_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 5)
            self.assertEqual(len(result.partial), 5)
            self.assertIn("services.wounds.add", main)
            self.assertIn("services.wounds.remove", main)
            self.assertEqual(
                report.count("effect #0 needs domain-service conversion"),
                4,
            )

    def test_bounded_character_variable_and_math_effects_use_native_services(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "bounded_character_variables",
                            "required_event": "game_start",
                            "condition": {
                                "and": [
                                    {"expects_vars": ["required"]},
                                    {"math": ["1 == 1"]},
                                ]
                            },
                            "effect": [
                                {"u_add_var": "literal", "value": "ready"},
                                {
                                    "u_add_var": "choice",
                                    "possible_values": ["left", "right"],
                                },
                                {"u_add_var": "turn", "time": True},
                            ],
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "bounded_character_math",
                            "required_event": "game_start",
                            "effect": {"math": ["u_score += 2"]},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "bounded_character_copy",
                            "required_event": "game_start",
                            "effect": {
                                "copy_var": {"u_val": "source"},
                                "target_var": {"u_val": "target"},
                            },
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "bounded_character_string",
                            "required_event": "game_start",
                            "effect": {
                                "set_string_var": ["one", "two"],
                                "target_var": {"u_val": "label"},
                            },
                        },
                    ]
                ),
                encoding="utf-8",
            )

            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "character_values_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 4)
            self.assertEqual(result.partial, [])
            self.assertIn(
                'services.variables.set(\n        actor, "literal", "ready")',
                main,
            )
            self.assertIn('values[services.random.int(1, #values)]', main)
            self.assertIn('tostring(services.turn())', main)
            self.assertIn('context.data["required"] ~= nil', main)
            self.assertIn("1 == 1", main)
            self.assertIn('services.variables.get(actor, "source")', main)
            self.assertIn('services.variables.remove(actor, "target")', main)
            self.assertIn(
                'services.variables.set(\n        actor, "label"',
                main,
            )
            self.assertIn('current + 2', main)
            self.assertEqual(main.count("local function service_value"), 1)
            self.assertNotIn("needs domain-service conversion", report)
            self.assertNotIn("services.state.", main)

    def test_dynamic_character_variable_shapes_remain_partial(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "dynamic_character_variable",
                            "required_event": "game_start",
                            "effect": {
                                "u_add_var": {"context_val": "name"},
                                "value": "ready",
                            },
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "numeric_character_variable",
                            "required_event": "game_start",
                            "effect": {"u_add_var": "count", "value": 1},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "ambiguous_character_variable",
                            "required_event": "game_start",
                            "effect": {
                                "u_add_var": "choice",
                                "value": "one",
                                "possible_values": ["two"],
                            },
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "dynamic_character_math",
                            "required_event": "game_start",
                            "effect": {"math": ["u_score = rng(1, 3)"]},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "mixed_character_copy",
                            "required_event": "game_start",
                            "effect": {
                                "copy_var": {"u_val": "source"},
                                "target_var": {"npc_val": "target"},
                            },
                        },
                    ]
                ),
                encoding="utf-8",
            )

            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "unsafe_character_values_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 4)
            self.assertEqual(len(result.todos), 4)
            self.assertNotIn("services.variables.set(actor", main)
            self.assertNotIn("services.variables.get(actor", main)
            self.assertNotIn("services.state.", main)
            self.assertIn("variable name/value into bounded Lua values", main)
            self.assertIn("services.gameplay.math.apply", main)
            self.assertIn("copy_var into typed variable services", main)
            self.assertNotIn("run_eoc", main)
            self.assertIn("needs domain-service conversion", report)

    def test_dynamic_context_and_math_conditions_remain_partial(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "dynamic_context_presence",
                            "required_event": "game_start",
                            "condition": {
                                "expects_vars": [{"context_val": "name"}]
                            },
                            "effect": {"message": "not proven"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "dynamic_condition_math",
                            "required_event": "game_start",
                            "condition": {"math": ["u_score == 1"]},
                            "effect": {"message": "not proven"},
                        },
                    ]
                ),
                encoding="utf-8",
            )

            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "unsafe_conditions_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 1)
            self.assertEqual(len(result.todos), 1)
            self.assertNotIn("context.data[", main)
            self.assertIn("u_score", main)
            self.assertIn("condition needs a native Lua predicate", report)

    def test_bounded_plain_activity_assignment_uses_typed_service(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "avatar_activity",
                            "required_event": "game_start",
                            "effect": {
                                "u_assign_activity": "ACT_WAIT",
                                "duration": "10 minutes",
                            },
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_activity",
                            "required_event": "npc_becomes_hostile",
                            "effect": {
                                "npc_assign_activity": "ACT_WAIT",
                                "duration": "20 minutes",
                            },
                        },
                    ]
                ),
                encoding="utf-8",
            )

            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "activity_assignment_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(result.partial, [])
            self.assertIn(
                'services.activities.assign_timed(\n'
                '        actor, services.types.id("activity", "ACT_WAIT"),\n'
                '        services.time.duration(600, "turn"))',
                main,
            )
            self.assertIn('services.time.duration(1200, "turn")', main)
            self.assertNotIn("services.activities.assign(actor)", main)
            self.assertNotIn("needs domain-service conversion", report)

    def test_dynamic_random_conditions_are_bounded_and_invalid_shapes_stay_partial(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            predicates = [
                {"one_in_chance": {"context_val": "denominator"}},
                {
                    "x_in_y_chance": {
                        "x": {"context_val": "chance"},
                        "y": 10,
                    }
                },
                {"x_in_y_chance": {"x": 2, "y": 1}},
                {
                    "roll_contested": 2,
                    "difficulty": 5,
                    "die_size": {"context_val": "die_size"},
                },
                {"roll_contested": 2, "difficulty": 5, "die_size": 0},
            ]
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": f"unsafe_random_{index}",
                            "required_event": "game_start",
                            "condition": predicate,
                            "effect": {"message": "bounded only"},
                        }
                        for index, predicate in enumerate(predicates)
                    ]
                ),
                encoding="utf-8",
            )

            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "predicate_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 3)
            self.assertEqual(len(result.partial), 2)
            self.assertIn("services.random.one_in", main)
            self.assertIn("services.random.probability", main)
            self.assertIn("services.random.contested", main)
            self.assertEqual(
                report.count("condition needs a native Lua predicate"),
                2,
            )

    def test_translates_bionic_any_and_literal_recipe_knowledge(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "has_any_bionic_or_power",
                            "required_event": "game_start",
                            "condition": {"u_has_bionics": "ANY"},
                            "effect": {"message": "powered"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "knows_recipe",
                            "required_event": "game_start",
                            "condition": {
                                "u_know_recipe": "cudgel_test_no_tools"
                            },
                            "effect": {"message": "known"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "predicate_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(result.partial, [])
            self.assertEqual(
                main.count("local function character_has_any_bionic_or_capacity"),
                1,
            )
            self.assertIn("services.bionics.summary(character)", main)
            self.assertIn(
                "summary.installed_count > 0 or summary.has_capacity",
                main,
            )
            self.assertIn("services.recipes.knows", main)
            self.assertIn(
                'services.types.id("recipe", "cudgel_test_no_tools")',
                main,
            )
            self.assertNotIn("run_eoc", main)

    def test_dynamic_or_unproven_bionic_and_recipe_conditions_stay_partial(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "unproven_any_bionic",
                            "required_event": "character_kills_monster",
                            "condition": {"u_has_bionics": "ANY"},
                            "effect": {"message": "bounded only"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "dynamic_bionic",
                            "required_event": "game_start",
                            "condition": {
                                "u_has_bionics": {"context_val": "bionic_id"}
                            },
                            "effect": {"message": "bounded only"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "dynamic_recipe",
                            "required_event": "game_start",
                            "condition": {
                                "u_know_recipe": {"context_val": "recipe_id"}
                            },
                            "effect": {"message": "bounded only"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "predicate_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 3)
            self.assertEqual(result.partial, [])
            self.assertIn("services.bionics.summary", main)
            self.assertIn("services.bionics.has", main)
            self.assertIn("services.recipes.knows", main)
            self.assertNotIn("condition needs a native Lua predicate", report)

    def test_dynamic_or_unproven_is_day_shapes_stay_partial(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "unproven_is_day",
                            "required_event": "game_start",
                            "condition": {"is_day": True},
                            "effect": {"message": "bounded only"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "predicate_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(result.converted, [])
            self.assertEqual(len(result.partial), 1)
            self.assertNotIn("services.gameplay.environment.is_night", main)
            self.assertEqual(
                report.count("condition needs a native Lua predicate"),
                1,
            )

    def test_dynamic_or_unproven_is_season_shapes_stay_partial(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "unproven_is_season",
                            "required_event": "game_start",
                            "condition": {
                                "is_season": {"u_val": "remembered_season"}
                            },
                            "effect": {"message": "bounded only"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "nonstring_is_season",
                            "required_event": "game_start",
                            "condition": {"is_season": 5},
                            "effect": {"message": "bounded only"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "predicate_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(result.converted, [])
            self.assertEqual(len(result.partial), 2)
            self.assertNotIn("services.time_snapshot", main)
            self.assertEqual(
                report.count("condition needs a native Lua predicate"),
                2,
            )

    def test_dynamic_or_unproven_is_weather_shapes_stay_partial(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "unproven_is_weather",
                            "required_event": "game_start",
                            "condition": {
                                "is_weather": {"u_val": "remembered_weather"}
                            },
                            "effect": {"message": "bounded only"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "nonstring_is_weather",
                            "required_event": "game_start",
                            "condition": {"is_weather": 5},
                            "effect": {"message": "bounded only"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "empty_is_weather",
                            "required_event": "game_start",
                            "condition": {"is_weather": ""},
                            "effect": {"message": "bounded only"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "predicate_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(result.converted, [])
            self.assertEqual(len(result.partial), 3)
            self.assertNotIn("services.weather.current", main)
            self.assertEqual(
                report.count("condition needs a native Lua predicate"),
                3,
            )

    def test_translates_proven_avatar_activity_cancellation(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "cancel_activity",
                        "required_event": "game_start",
                        "effect": "u_cancel_activity",
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "activity_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertGreaterEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertIn("services.characters.avatar()", main)
            self.assertIn("services.activities.cancel(actor)", main)
            self.assertNotIn("run_eoc", main)

    def test_item_presence_emits_its_result_helper_when_used_alone(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "has_water",
                        "required_event": "game_start",
                        "condition": {"u_has_item": "water_clean"},
                        "effect": {"message": "water found"},
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "inventory_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertEqual(main.count("local function service_value"), 1)
            self.assertIn("services.inventory.resources(actor", main)
            self.assertIn('services.types.id("item", "water_clean")', main)

    def test_translates_achievement_awards_without_an_eoc_runner(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "award",
                        "required_event": "game_start",
                        "effect": {
                            "give_achievement": "achievement_reach_string_dimension"
                        },
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "achievement_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertIn("services.achievements.complete", main)
            self.assertIn(
                'services.types.id("achievement", '
                '"achievement_reach_string_dimension")',
                main,
            )
            self.assertNotIn("run_eoc", main)

    def test_translates_avatar_bionic_install_without_a_dialogue_actor(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "install_bionic",
                        "required_event": "game_start",
                        "effect": {"u_add_bionic": "bio_earplugs"},
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "bionic_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertIn("services.bionics.grant", main)
            self.assertIn("services.characters.avatar()", main)
            self.assertNotIn("context.alpha", main)
            self.assertIn(
                'services.types.id("bionic", "bio_earplugs")',
                main,
            )
            self.assertNotIn("run_eoc", main)

    def test_translates_avatar_bionic_removal_by_type(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "remove_bionic",
                        "required_event": "game_start",
                        "effect": {"u_lose_bionic": "bio_earplugs"},
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "bionic_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertIn("services.bionics.remove_type", main)
            self.assertIn("services.characters.avatar()", main)
            self.assertNotIn("context.alpha", main)
            self.assertIn(
                'services.types.id("bionic", "bio_earplugs")',
                main,
            )
            self.assertNotIn("run_eoc", main)

    def test_translates_avatar_recipe_learning_without_a_dialogue_actor(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "learn_recipe",
                        "required_event": "game_start",
                        "effect": {"u_learn_recipe": "cudgel_test_no_tools"},
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "recipe_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertIn("services.recipes.learn", main)
            self.assertIn("services.characters.avatar()", main)
            self.assertNotIn("context.alpha", main)
            self.assertIn(
                'services.types.id("recipe", "cudgel_test_no_tools")',
                main,
            )
            self.assertNotIn("run_eoc", main)

    def test_translates_avatar_recipe_and_literal_category_forgetting(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "forget_recipe",
                            "required_event": "game_start",
                            "effect": {"u_forget_recipe": "cudgel_test_no_tools"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "forget_category",
                            "required_event": "game_start",
                            "effect": {
                                "u_forget_recipe": "CC_FOOD",
                                "category": True,
                            },
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "forget_subcategory",
                            "required_event": "game_start",
                            "effect": {
                                "u_forget_recipe": "CC_FOOD",
                                "subcategory": "CSC_FOOD_DRINKS",
                            },
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "recipe_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(len(result.converted), 3)
            self.assertEqual(result.partial, [])
            self.assertIn("services.recipes.forget", main)
            self.assertIn(
                'services.types.id("recipe", "cudgel_test_no_tools")',
                main,
            )
            self.assertEqual(main.count("services.recipes.forget_category"), 2)
            self.assertEqual(
                main.count(
                    'services.types.id("crafting_category", "CC_FOOD")'
                ),
                2,
            )
            self.assertIn(
                '"CSC_FOOD_DRINKS")',
                main,
            )
            self.assertNotIn("run_eoc", main)

    def test_dynamic_recipe_category_forgetting_stays_partial(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "dynamic_category",
                            "required_event": "game_start",
                            "effect": {
                                "u_forget_recipe": {
                                    "context_val": "category_id"
                                },
                                "category": True,
                            },
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "dynamic_subcategory",
                            "required_event": "game_start",
                            "effect": {
                                "u_forget_recipe": "CC_FOOD",
                                "subcategory": {
                                    "context_val": "subcategory_id"
                                },
                            },
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "recipe_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(result.converted, [])
            self.assertEqual(len(result.partial), 2)
            self.assertNotIn("services.recipes.forget_category", main)
            self.assertEqual(
                report.count("effect #0 needs domain-service conversion"),
                2,
            )

    def test_translates_avatar_martial_art_learning_and_forgetting(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "learn_style",
                            "required_event": "game_start",
                            "effect": {"u_learn_martial_art": "style_karate"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "forget_style",
                            "required_event": "game_start",
                            "effect": {"u_forget_martial_art": "style_karate"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "martial_art_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(result.partial, [])
            self.assertIn("services.martial_arts.learn", main)
            self.assertIn("services.martial_arts.forget", main)
            self.assertIn("services.characters.avatar()", main)
            self.assertNotIn("context.alpha", main)
            self.assertIn(
                'services.types.id("martial_art", "style_karate")',
                main,
            )
            self.assertNotIn("run_eoc", main)

    def test_translates_bounded_avatar_morale_changes(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "add_morale",
                            "required_event": "game_start",
                            "effect": {
                                "u_add_morale": "morale_feeling_good",
                                "bonus": 10,
                                "max_bonus": 50,
                            },
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "remove_morale",
                            "required_event": "game_start",
                            "effect": {"u_lose_morale": "morale_feeling_good"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "timed_morale",
                            "required_event": "game_start",
                            "effect": {
                                "u_add_morale": "morale_feeling_good",
                                "bonus": 10,
                                "max_bonus": 50,
                                "duration": "2 hours",
                            },
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "morale_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 3)
            self.assertEqual(len(result.partial), 0)
            self.assertIn("services.morale.add", main)
            self.assertIn("services.morale.remove", main)
            self.assertIn(
                'services.types.id("morale", "morale_feeling_good")',
                main,
            )
            self.assertIn("10, 50)", main)
            self.assertIn(
                'duration = services.time.duration(7200, "turn")',
                main,
            )
            self.assertNotIn("needs domain-service conversion", report)
            self.assertNotIn("run_eoc", main)

    def test_translates_npc_predicates_for_proven_npc_events(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "npc_hostile",
                        "required_event": "npc_becomes_hostile",
                        "condition": {
                            "and": [
                                "npc_is_travelling",
                                "at_safe_space",
                                "player_see_npc",
                            ]
                        },
                        "effect": [
                            {"npc_add_wet": 30},
                            "npc_cancel_activity",
                        ],
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "npc_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertIn("context.actors.npc", main)
            self.assertIn("character_travel_has_path(actor)", main)
            self.assertIn("character_at_safe_space(actor)", main)
            self.assertIn("services.creatures.can_see", main)
            self.assertIn("services.characters.add_wet(actor, 30)", main)
            self.assertIn("services.activities.cancel(actor)", main)
            self.assertNotIn("needs a native Lua predicate", report)
            self.assertNotIn("run_eoc", main)

    def test_translates_bounded_avatar_wetness_changes(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "add_wet",
                            "required_event": "game_start",
                            "effect": {"u_add_wet": 42},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "add_wet_npc",
                            "required_event": "game_start",
                            "effect": {"npc_add_wet": 42},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "add_wet_huge",
                            "required_event": "game_start",
                            "effect": {"u_add_wet": 99999999},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "wet_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 2)
            self.assertIn("services.characters.add_wet(actor, 42)", main)
            self.assertEqual(main.count("services.characters.add_wet(actor, 42)"), 1)
            self.assertIn(
                "EOC add_wet_huge effect #0 needs domain-service conversion",
                report,
            )
            self.assertNotIn("run_eoc", main)

    def test_static_timed_morale_emits_native_duration_service_call(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "timed_morale_only",
                        "required_event": "game_start",
                        "effect": {
                            "u_add_morale": "morale_feeling_good",
                            "bonus": 10,
                            "max_bonus": 50,
                            "duration": "2 hours",
                        },
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "morale_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertIn("services.morale.add", main)
            self.assertIn(
                'duration = services.time.duration(7200, "turn")',
                main,
            )
            self.assertNotIn("services.morale.remove", main)
            self.assertNotIn("run_eoc", main)

    def test_translates_only_bounded_literal_avatar_effect_changes(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "add_timed_effect",
                            "required_event": "game_start",
                            "effect": {
                                "u_add_effect": "downed",
                                "duration": 60,
                            },
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "add_permanent_effect",
                            "required_event": "game_start",
                            "effect": {
                                "u_add_effect": "incorporeal",
                                "duration": "PERMANENT",
                            },
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "remove_effect",
                            "required_event": "game_start",
                            "effect": {"u_lose_effect": "downed"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "zero_duration",
                            "required_event": "game_start",
                            "effect": {"u_add_effect": "blind", "duration": 0},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "effect_options",
                            "required_event": "game_start",
                            "effect": {
                                "u_add_effect": "bleed",
                                "duration": 60,
                                "intensity": 2,
                            },
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "effect_target_part_and_force",
                            "required_event": "game_start",
                            "effect": {
                                "u_add_effect": "bleed",
                                "duration": "10 minutes",
                                "target_part": "eyes",
                                "force": True,
                            },
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "variable_remove_bug_compatibility",
                            "required_event": "game_start",
                            "effect": {
                                "u_lose_effect": {"context_val": "effect_id"}
                            },
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "effect_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 7)
            self.assertEqual(len(result.partial), 0)
            self.assertIn("services.effects.add", main)
            self.assertIn("services.effects.remove", main)
            self.assertIn(
                'services.types.id("effect", "downed")',
                main,
            )
            self.assertIn('services.time.duration(60, "turn")', main)
            self.assertIn(
                'services.time.duration(1, "turn"), { permanent = true }',
                main,
            )
            self.assertIn(
                'services.time.duration(60, "turn"), { intensity = 2 })',
                main,
            )
            self.assertIn(
                'services.time.duration(600, "turn"), { '
                'body_part = services.types.id("body_part", "eyes"), '
                'force = true })',
                main,
            )
            self.assertNotIn(
                "EOC zero_duration effect #0 needs domain-service conversion",
                report,
            )
            self.assertNotIn(
                "EOC variable_remove_bug_compatibility effect #0 needs "
                "domain-service conversion",
                report,
            )
            self.assertNotIn("run_eoc", main)

    def test_unsupported_effect_shapes_never_emit_effect_service_calls(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "zero_duration",
                            "required_event": "game_start",
                            "effect": {"u_add_effect": "blind", "duration": 0},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "effect_options",
                            "required_event": "game_start",
                            "effect": {
                                "u_add_effect": "bleed",
                                "duration": 60,
                                "intensity": 1000001,
                            },
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "variable_remove",
                            "required_event": "game_start",
                            "effect": {
                                "u_lose_effect": {"unknown_val": "effect_id"}
                            },
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "effect_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 2)
            self.assertIn("services.effects.add", main)
            self.assertNotIn("services.effects.remove", main)
            self.assertNotIn("run_eoc", main)

    def test_translates_npc_effect_and_trait_changes_with_provenance(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "npc_effect",
                            "required_event": "npc_becomes_hostile",
                            "effect": {
                                "npc_add_effect": "downed",
                                "duration": 40,
                                "intensity": 3,
                            },
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_effect_permanent",
                            "required_event": "npc_becomes_hostile",
                            "effect": {
                                "npc_add_effect": "bleed",
                                "duration": "PERMANENT",
                            },
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "avatar_trait",
                            "required_event": "game_start",
                            "effect": {"u_add_trait": "TOUGH"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "avatar_trait_variant",
                            "required_event": "game_start",
                            "effect": {
                                "u_add_trait": "SKIN_DARK",
                                "variant": "black",
                            },
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "avatar_lose_trait",
                            "required_event": "game_start",
                            "effect": {"u_lose_trait": "TOUGH"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_trait",
                            "required_event": "npc_becomes_hostile",
                            "effect": {"npc_add_trait": "TOUGH"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_lose_trait",
                            "required_event": "npc_becomes_hostile",
                            "effect": {"npc_lose_trait": "TOUGH"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "unproven_npc_effect",
                            "required_event": "game_start",
                            "effect": {
                                "npc_add_effect": "downed",
                                "duration": 40,
                            },
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "bad_intensity",
                            "required_event": "game_start",
                            "effect": {
                                "u_add_effect": "bleed",
                                "target_part": "arm_l",
                                "duration": 0,
                                "intensity": -1,
                            },
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "effect_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 8)
            self.assertEqual(len(result.partial), 1)
            self.assertIn(
                'services.types.id("effect", "downed")',
                main,
            )
            self.assertIn(
                'services.time.duration(40, "turn"), { intensity = 3 })',
                main,
            )
            self.assertIn(
                'services.time.duration(1, "turn"), { permanent = true })',
                main,
            )
            self.assertIn(
                'services.mutations.grant(\n        actor,\n'
                '        services.types.id("mutation", "TOUGH"))',
                main,
            )
            self.assertIn(
                'services.mutations.grant(\n        actor,\n'
                '        services.types.id("mutation", "SKIN_DARK"),\n'
                '        "black")',
                main,
            )
            self.assertIn(
                'services.mutations.remove(\n        actor,\n'
                '        services.types.id("mutation", "TOUGH"))',
                main,
            )
            self.assertIn(
                "EOC unproven_npc_effect effect #0 needs domain-service "
                "conversion",
                report,
            )
            self.assertIn(
                'services.effects.adjust_intensity(\n'
                '        actor,\n'
                '        services.types.id("effect", "bleed"),\n'
                '        -1, services.types.id("body_part", "arm_l"))',
                main,
            )
            self.assertNotIn(
                "EOC bad_intensity effect #0 needs domain-service conversion",
                report,
            )
            self.assertNotIn("run_eoc", main)

    def test_translates_bounded_mutation_effects_for_avatar_and_npc(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "avatar_mutate",
                            "required_event": "game_start",
                            "effect": [
                                {"u_mutate": 0, "use_vitamins": False},
                                {
                                    "u_mutate_category": "HUMAN",
                                    "use_vitamins": False,
                                    "true_random": True,
                                },
                                {
                                    "u_mutate_towards": {
                                        "context_val": "trait_id"
                                    },
                                    "category": "ANY",
                                    "use_vitamins": False,
                                },
                            ],
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_mutate",
                            "required_event": "npc_becomes_hostile",
                            "effect": [
                                {"npc_mutate": 1},
                                {"npc_mutate_category": "HUMAN"},
                                {"npc_mutate_towards": "TOUGH"},
                            ],
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "unsupported_mutation_shapes",
                            "required_event": "game_start",
                            "effect": [
                                {"u_mutate": 1.5},
                                {
                                    "u_mutate_category": {
                                        "global_val": "next_category"
                                    }
                                },
                                {"u_mutate_towards": "TOUGH", "unknown": True},
                            ],
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "unproven_npc_mutation",
                            "required_event": "game_start",
                            "effect": {"npc_mutate": 1},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "mutation_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(len(result.partial), 2)
            self.assertIn("services.mutations.mutate(", main)
            self.assertIn(
                "services.mutations.mutate_category(\n"
                "        actor, services.types.id(\"mutation_category\", \"HUMAN\"), "
                "false, true)",
                main,
            )
            self.assertIn(
                "services.mutations.mutate_towards(\n"
                "        actor, services.types.id(\"mutation\", "
                "tostring((context.data[\"trait_id\"])",
                main,
            )
            self.assertIn("services.mutations.mutate_towards(\n        actor,", main)
            self.assertIn("services.types.id(\"mutation\", \"TOUGH\")", main)
            self.assertIn(
                "services.mutations.mutate_towards(\n"
                "        actor, services.types.id(\"mutation\", \"TOUGH\"), nil",
                main,
            )
            self.assertNotIn("services.mutations.mutate(\n        actor, 1.5", main)
            self.assertIn(
                "EOC unsupported_mutation_shapes effect #0 needs domain-service conversion",
                report,
            )
            self.assertIn(
                "EOC unproven_npc_mutation effect #0 needs domain-service conversion",
                report,
            )
            self.assertNotIn("run_eoc", main)

    def test_translates_literal_stat_threshold_conditions_with_provenance(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "strong",
                            "required_event": "game_start",
                            "condition": {"u_has_strength": 8},
                            "effect": {"message": "strong enough"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "dexterous",
                            "required_event": "game_start",
                            "condition": {"u_has_dexterity": 6},
                            "effect": {"message": "dexterous"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "smart",
                            "required_event": "game_start",
                            "condition": {"u_has_intelligence": 7},
                            "effect": {"message": "smart"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "perceptive",
                            "required_event": "game_start",
                            "condition": {"u_has_perception": 9},
                            "effect": {"message": "perceptive"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_strong",
                            "required_event": "npc_becomes_hostile",
                            "condition": {"npc_has_strength": 8},
                            "effect": {"message": "npc strong"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_dext",
                            "required_event": "npc_becomes_hostile",
                            "condition": {"npc_has_dexterity": 6},
                            "effect": {"message": "npc dexterous"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_int",
                            "required_event": "npc_becomes_hostile",
                            "condition": {"npc_has_intelligence": 7},
                            "effect": {"message": "npc smart"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_per",
                            "required_event": "npc_becomes_hostile",
                            "condition": {"npc_has_perception": 9},
                            "effect": {"message": "npc perceptive"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "unproven_npc_stat",
                            "required_event": "game_start",
                            "condition": {"npc_has_strength": 8},
                            "effect": {"message": "unproven"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "variable_stat",
                            "required_event": "game_start",
                            "condition": {"u_has_strength": "str_var"},
                            "effect": {"message": "variable"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "stat_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 8)
            self.assertEqual(len(result.partial), 2)
            self.assertIn(
                "service_value(services.characters.snapshot(actor))"
                ".stats.strength >= 8",
                main,
            )
            self.assertIn(
                "service_value(services.characters.snapshot(actor))"
                ".stats.dexterity >= 6",
                main,
            )
            self.assertIn(
                "service_value(services.characters.snapshot(actor))"
                ".stats.intelligence >= 7",
                main,
            )
            self.assertIn(
                "service_value(services.characters.snapshot(actor))"
                ".stats.perception >= 9",
                main,
            )
            self.assertIn(
                "EOC unproven_npc_stat condition needs a native Lua predicate",
                report,
            )
            self.assertIn(
                "EOC variable_stat condition needs a native Lua predicate",
                report,
            )
            self.assertNotIn("run_eoc", main)

    def test_translates_warm_and_deaf_senses_with_provenance(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "warm",
                            "required_event": "game_start",
                            "condition": "u_is_warm",
                            "effect": {"message": "warm"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "deaf",
                            "required_event": "game_start",
                            "condition": "u_is_deaf",
                            "effect": {"message": "deaf"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_warm",
                            "required_event": "npc_becomes_hostile",
                            "condition": "npc_is_warm",
                            "effect": {"message": "npc warm"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_deaf",
                            "required_event": "npc_becomes_hostile",
                            "condition": "npc_is_deaf",
                            "effect": {"message": "npc deaf"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "unproven_warm",
                            "required_event": "game_start",
                            "condition": "npc_is_warm",
                            "effect": {"message": "unproven"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "underwater",
                            "required_event": "game_start",
                            "condition": "u_is_underwater",
                            "effect": {"message": "underwater"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "senses_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 5)
            self.assertEqual(len(result.partial), 1)
            self.assertIn(
                "service_value(services.characters.snapshot(actor))"
                ".creature.warm",
                main,
            )
            self.assertIn(
                "service_value(services.characters.snapshot(actor))"
                ".senses.deaf",
                main,
            )
            self.assertIn(
                "EOC unproven_warm condition needs a native Lua predicate",
                report,
            )
            self.assertIn(
                "service_value(services.characters.is_underwater(actor))",
                main,
            )
            self.assertNotIn("run_eoc", main)

    def test_translates_game_start_is_alive_to_true_with_provenance(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "alive",
                            "required_event": "game_start",
                            "condition": "u_is_alive",
                            "effect": {"message": "alive"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_alive",
                            "required_event": "game_start",
                            "condition": "npc_is_alive",
                            "effect": {"message": "npc alive"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_alive_proven",
                            "required_event": "npc_becomes_hostile",
                            "condition": "npc_is_alive",
                            "effect": {"message": "npc alive proven"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "hostile_alive",
                            "required_event": "npc_becomes_hostile",
                            "condition": "u_is_alive",
                            "effect": {"message": "hostile alive"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "item_alive",
                            "required_event": "character_wields_item",
                            "condition": "u_is_alive",
                            "effect": {"message": "item alive"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "is_alive_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 4)
            self.assertEqual(len(result.partial), 1)
            self.assertIn('runtime.on("game:game_start"', main)
            self.assertIn(
                "EOC npc_alive condition needs a native Lua predicate",
                report,
            )
            self.assertIn(
                "service_value(services.characters.is_alive(actor))",
                main,
            )
            self.assertNotIn("EOC hostile_alive condition needs a native Lua predicate", report)
            self.assertNotIn("EOC item_alive condition needs a native Lua predicate", report)
            self.assertNotIn("run_eoc", main)

    def test_translates_proven_character_status_and_temperature_predicates(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "avatar_temp",
                            "required_event": "game_start",
                            "condition": {
                                "u_has_part_temp": 5000,
                                "bodypart": "torso",
                            },
                            "effect": {"message": "avatar temp"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_temp",
                            "required_event": "npc_becomes_hostile",
                            "condition": {
                                "npc_has_part_temp": 0,
                                "bodypart": "arm_l",
                            },
                            "effect": {"message": "npc temp"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "avatar_underwater",
                            "required_event": "game_start",
                            "condition": "u_is_underwater",
                            "effect": {"message": "avatar underwater"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_underwater",
                            "required_event": "npc_becomes_hostile",
                            "condition": "npc_is_underwater",
                            "effect": {"message": "npc underwater"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "missing_bodypart",
                            "required_event": "game_start",
                            "condition": {"u_has_part_temp": 5000},
                            "effect": {"message": "missing bodypart"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "character_status_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 4)
            self.assertEqual(len(result.partial), 1)
            self.assertIn(
                "services.characters.has_part_temp("
                "actor, services.types.id(\"body_part\", \"torso\"), 5000)",
                main,
            )
            self.assertIn(
                "services.characters.is_underwater(actor)",
                main,
            )
            self.assertIn(
                "EOC missing_bodypart condition needs a native Lua predicate",
                report,
            )
            self.assertNotIn("run_eoc", main)

    def test_translates_game_start_identity_gender_and_cash_predicates(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "identity",
                            "required_event": "game_start",
                            "condition": "u_is_avatar",
                            "effect": {"message": "avatar"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "gender",
                            "required_event": "game_start",
                            "condition": "u_female",
                            "effect": {"message": "female"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "cash",
                            "required_event": "game_start",
                            "condition": {"u_has_cash": 500},
                            "effect": {"message": "cash"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_gender",
                            "required_event": "game_start",
                            "condition": "npc_female",
                            "effect": {"message": "npc female"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "dynamic_cash",
                            "required_event": "game_start",
                            "condition": {
                                "u_has_cash": {"math": ["cash_var"]}
                            },
                            "effect": {"message": "dynamic"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "identity_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 4)
            self.assertEqual(len(result.partial), 1)
            self.assertIn(
                "services.characters.avatar()", main
            )
            self.assertIn(
                "not service_value(services.characters.snapshot(actor)).male",
                main,
            )
            self.assertIn(
                "service_value(services.characters.snapshot(actor)).cash >= 500",
                main,
            )
            self.assertIn(
                "EOC npc_gender condition needs a native Lua predicate",
                report,
            )
            self.assertIn(
                'services.gameplay.math.evaluate("cash_var", actor',
                main,
            )
            self.assertNotIn("run_eoc", main)

    def test_translates_context_val_map_lookups_to_environment_queries(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "terrain",
                            "required_event": "game_start",
                            "condition": {
                                "map_terrain_id": "t_grass",
                                "loc": {"context_val": "spot"},
                            },
                            "effect": {"message": "terrain"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "furniture",
                            "required_event": "game_start",
                            "condition": {
                                "map_furniture_id": "f_null",
                                "loc": {"context_val": "spot"},
                            },
                            "effect": {"message": "furniture"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "field",
                            "required_event": "game_start",
                            "condition": {
                                "map_field_id": "fd_smoke",
                                "loc": {"context_val": "spot"},
                            },
                            "effect": {"message": "field"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "dynamic_loc",
                            "required_event": "game_start",
                            "condition": {
                                "map_terrain_id": "t_grass",
                                "loc": {"u_val": "spot"},
                            },
                            "effect": {"message": "dynamic"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "map_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 4)
            self.assertEqual(len(result.partial), 0)
            self.assertIn(
                'services.gameplay.environment.terrain_id(', main
            )
            self.assertIn(
                'services.gameplay.environment.furniture_id(', main
            )
            self.assertIn(
                'services.gameplay.environment.field_exists(', main
            )
            self.assertNotIn("condition needs a native Lua predicate", report)
            self.assertNotIn("run_eoc", main)

    def test_translates_context_val_map_flag_and_city_queries(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "terrain_flag",
                            "required_event": "game_start",
                            "condition": {
                                "map_terrain_with_flag": "INDOORS",
                                "loc": {"context_val": "spot"},
                            },
                            "effect": {"message": "flag"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "city",
                            "required_event": "game_start",
                            "condition": {
                                "map_in_city": {"context_val": "spot"},
                            },
                            "effect": {"message": "city"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "indoor",
                            "required_event": "game_start",
                            "condition": {
                                "map_is_outside": {"context_val": "spot"},
                            },
                            "effect": {"message": "indoor"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "outside",
                            "required_event": "game_start",
                            "condition": {
                                "is_outside": {"context_val": "spot"},
                            },
                            "effect": {"message": "outside"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "dynamic_city",
                            "required_event": "game_start",
                            "condition": {
                                "map_in_city": {"u_val": "spot"},
                            },
                            "effect": {"message": "dynamic"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "dynamic_outside",
                            "required_event": "game_start",
                            "condition": {
                                "is_outside": {"u_val": "spot"},
                            },
                            "effect": {"message": "dynamic"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "map_flag_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 6)
            self.assertEqual(len(result.partial), 0)
            self.assertIn(
                'services.gameplay.environment.terrain_has_flag(', main
            )
            self.assertIn(
                "services.overmap.is_in_city(", main
            )
            self.assertIn(
                "services.gameplay.environment.is_indoor_tile(", main
            )
            self.assertIn(
                "services.gameplay.environment.is_outside(", main
            )
            self.assertNotIn("condition needs a native Lua predicate", report)
            self.assertNotIn("run_eoc", main)

    def test_translates_map_location_predicates_at_actor_position(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            eocs = []
            for index, (event, condition) in enumerate(
                [
                    ("game_start", {"u_is_on_terrain": "t_grass"}),
                    ("game_start", {"u_is_on_furniture": "f_null"}),
                    ("game_start", {"u_is_in_field": "fd_smoke"}),
                    ("game_start", {"u_is_on_terrain_with_flag": "INDOORS"}),
                    (
                        "game_start",
                        {"u_is_on_furniture_with_flag": "TRANSPARENT"},
                    ),
                    ("npc_becomes_hostile", {"npc_is_on_terrain": "t_grass"}),
                    (
                        "npc_becomes_hostile",
                        {"npc_is_on_furniture": "f_null"},
                    ),
                    ("npc_becomes_hostile", {"npc_is_in_field": "fd_smoke"}),
                    (
                        "npc_becomes_hostile",
                        {"npc_is_on_terrain_with_flag": "INDOORS"},
                    ),
                    (
                        "npc_becomes_hostile",
                        {"npc_is_on_furniture_with_flag": "TRANSPARENT"},
                    ),
                    (
                        "game_start",
                        {"u_is_on_terrain": {"context_val": "terrain_id"}},
                    ),
                    ("character_kills_monster", {"u_is_on_terrain": "t_grass"}),
                ]
            ):
                eocs.append(
                    {
                        "type": "effect_on_condition",
                        "id": f"loc_{index}",
                        "required_event": event,
                        "condition": condition,
                        "effect": {"message": "loc"},
                    }
                )
            source.write_text(json.dumps(eocs), encoding="utf-8")
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "loc_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 11)
            self.assertEqual(len(result.partial), 1)
            self.assertIn(
                "services.gameplay.environment.terrain_id(", main
            )
            self.assertIn(
                "services.gameplay.environment.furniture_id(", main
            )
            self.assertIn(
                "services.gameplay.environment.field_exists(", main
            )
            self.assertIn(
                "services.gameplay.environment.terrain_has_flag(", main
            )
            self.assertIn(
                "services.gameplay.environment.furniture_has_flag(", main
            )
            self.assertIn(
                ".creature.position", main
            )
            self.assertIn(
                "EOC loc_10 condition needs a native Lua predicate", report
            )
            self.assertNotIn("run_eoc", main)

    def test_translates_falling_mission_and_need_constants(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            eocs = []
            for index, (event, condition) in enumerate(
                [
                    ("game_start", "u_is_falling"),
                    ("game_start", "u_is_floating"),
                    ("game_start", "u_is_flying"),
                    ("game_start", "u_is_sinking"),
                    ("game_start", "u_is_skidding"),
                    ("npc_becomes_hostile", "npc_is_falling"),
                    ("npc_becomes_hostile", "npc_is_floating"),
                    ("npc_becomes_hostile", "npc_is_flying"),
                    ("npc_becomes_hostile", "npc_is_sinking"),
                    ("npc_becomes_hostile", "npc_is_skidding"),
                    ("game_start", "u_mission_complete"),
                    ("game_start", "u_mission_failed"),
                    ("game_start", "u_mission_incomplete"),
                    ("game_start", "u_has_available_mission"),
                    ("game_start", "u_has_many_available_missions"),
                    ("game_start", "u_has_no_available_mission"),
                    ("game_start", {"u_mission_goal": "MGOAL_FIND_ITEM"}),
                    ("game_start", {"u_need": "hunger", "amount": 100}),
                    ("game_start", {"u_need": "sleepiness", "level": "TIRED"}),
                    ("game_start", {"u_need": "thirst"}),
                    ("npc_becomes_hostile", {"npc_need": "hunger", "amount": 5}),
                    ("game_start", {"u_aim_rule": "WHEN_CONVENIENT"}),
                    ("game_start", {"u_engagement_rule": "ENGAGE_ALL"}),
                    ("game_start", {"u_cbm_recharge_rule": "ALWAYS"}),
                    ("game_start", {"u_cbm_reserve_rule": "NEVER"}),
                    ("game_start", {"u_bodytype": "human"}),
                    ("npc_becomes_hostile", {"npc_bodytype": "limb"}),
                    ("game_start", "u_can_float"),
                    ("game_start", "u_can_fly"),
                    ("npc_becomes_hostile", "npc_can_float"),
                    ("npc_becomes_hostile", "npc_can_fly"),
                    ("game_start", "u_following"),
                    ("game_start", {"u_is_trait_purifiable": "ELFAEYES"}),
                    (
                        "npc_becomes_hostile",
                        {"npc_is_trait_purifiable": "ELFAEYES"},
                    ),
                    ("game_start", {"u_need": "hunger", "amount": {"math": ["x"]}}),
                    ("character_kills_monster", "u_is_falling"),
                    ("game_start", {"u_aim_rule": {"u_val": "rule_var"}}),
                    ("game_start", {"u_bodytype": {"u_val": "bt_var"}}),
                    (
                        "game_start",
                        {"u_is_trait_purifiable": {"u_val": "trait_var"}},
                    ),
                    ("game_start", "u_available"),
                    ("game_start", {"u_rule": "ALLY_ONLY"}),
                    ("game_start", {"u_safe_mode_trigger": "NE"}),
                    (
                        "game_start",
                        {"u_safe_mode_trigger": {"u_val": "dir_var"}},
                    ),
                    ("game_start", {"u_has_part_flag": "SPLINT", "enabled": True}),
                    (
                        "npc_becomes_hostile",
                        {"npc_has_part_flag": "SPLINT"},
                    ),
                    (
                        "game_start",
                        {"u_has_part_flag": {"u_val": "flag_var"}},
                    ),
                    ("game_start", {"u_has_class": "NC_BOUNTY_HUNTER"}),
                    (
                        "game_start",
                        {"u_has_class": {"u_val": "class_var"}},
                    ),
                ]
            ):
                eocs.append(
                    {
                        "type": "effect_on_condition",
                        "id": f"cnst_{index}",
                        "required_event": event,
                        "condition": condition,
                        "effect": {"message": "cnst"},
                    }
                )
            source.write_text(json.dumps(eocs), encoding="utf-8")
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "cnst_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 41)
            self.assertEqual(len(result.partial), 7)
            self.assertIn(
                ".needs.hunger > 100", main
            )
            self.assertIn(
                ".needs.sleepiness > 191", main
            )
            self.assertIn(
                ".needs.thirst > 0", main
            )
            self.assertIn(
                "services.mutations.definition(", main
            )
            self.assertIn(
                ".availability.purifiable", main
            )
            self.assertIn(
                "services.gameplay.environment.safe_mode_dangerous(", main
            )
            for partial_index in ("34", "36", "37", "38", "42", "45", "47"):
                self.assertIn(
                    f"EOC cnst_{partial_index} condition needs a native "
                    "Lua predicate",
                    report,
                )
            self.assertNotIn("run_eoc", main)

    def test_translates_npc_becomes_hostile_character_queries(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "trait",
                            "required_event": "npc_becomes_hostile",
                            "condition": {"npc_has_trait": "ELFAEYES"},
                            "effect": {"message": "trait"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "any_trait",
                            "required_event": "npc_becomes_hostile",
                            "condition": {
                                "npc_has_any_trait": ["ELFAEYES", "URSINE_EYE"]
                            },
                            "effect": {"message": "any"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "martial",
                            "required_event": "npc_becomes_hostile",
                            "condition": {"npc_has_martial_art": "style_karate"},
                            "effect": {"message": "martial"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "using_martial",
                            "required_event": "npc_becomes_hostile",
                            "condition": {
                                "npc_using_martial_art": "style_karate"
                            },
                            "effect": {"message": "using"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "proficiency",
                            "required_event": "npc_becomes_hostile",
                            "condition": {"npc_has_proficiency": "prof_knapping"},
                            "effect": {"message": "prof"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "bionics",
                            "required_event": "npc_becomes_hostile",
                            "condition": {"npc_has_bionics": "bio_armor_arms"},
                            "effect": {"message": "bionics"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "item",
                            "required_event": "npc_becomes_hostile",
                            "condition": {"npc_has_item": "bandages"},
                            "effect": {"message": "item"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "move",
                            "required_event": "npc_becomes_hostile",
                            "condition": {"npc_has_move_mode": "crouch"},
                            "effect": {"message": "move"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "dynamic_trait",
                            "required_event": "npc_becomes_hostile",
                            "condition": {
                                "npc_has_trait": {"u_val": "trait_var"}
                            },
                            "effect": {"message": "dynamic"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "safe_space",
                            "required_event": "npc_becomes_hostile",
                            "condition": "npc_at_safe_space",
                            "effect": {"message": "safe"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_profession",
                            "required_event": "npc_becomes_hostile",
                            "condition": {"npc_has_profession": "unemployed"},
                            "effect": {"message": "prof"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_flag",
                            "required_event": "npc_becomes_hostile",
                            "condition": {"npc_has_flag": "MUTE"},
                            "effect": {"message": "flag"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_wearing",
                            "required_event": "npc_becomes_hostile",
                            "condition": {"npc_is_wearing": "backpack"},
                            "effect": {"message": "wearing"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_pickup",
                            "required_event": "npc_becomes_hostile",
                            "condition": "npc_has_pickup_list",
                            "effect": {"message": "pickup"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_class",
                            "required_event": "npc_becomes_hostile",
                            "condition": {"npc_has_class": "NC_BOUNTY_HUNTER"},
                            "effect": {"message": "class"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "npc_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 15)
            self.assertEqual(len(result.partial), 0)
            self.assertIn(
                "context.actors.npc", main
            )
            self.assertIn(
                "character_at_safe_space(actor)", main
            )
            self.assertIn(
                "character_has_profession(actor,", main
            )
            self.assertIn(
                "services.creatures.has_flag(", main
            )
            self.assertIn(
                "character_is_wearing(actor,", main
            )
            self.assertIn(
                "character_has_pickup_whitelist(actor)", main
            )
            self.assertIn(
                "services.npcs.get(actor)", main
            )
            self.assertIn(
                'services.mutations.has(', main
            )
            self.assertIn(
                'services.martial_arts.get(', main
            )
            self.assertIn(
                'services.proficiencies.get(', main
            )
            self.assertIn(
                'services.bionics.has(', main
            )
            self.assertIn(
                'services.inventory.resources(actor, services.types.id("item", "bandages"), 1)',
                main,
            )
            self.assertIn(
                "character_has_any_bionic_or_capacity", main
            ) if False else None
            self.assertIn(
                '.movement.id == "crouch"', main
            )
            self.assertNotIn(
                "EOC dynamic_trait condition needs a native Lua predicate",
                report,
            )
            self.assertNotIn("run_eoc", main)

    def test_translates_literal_lose_var_effects(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "u_var",
                            "required_event": "game_start",
                            "effect": {"u_lose_var": "quest_var"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_var",
                            "required_event": "npc_becomes_hostile",
                            "effect": {"npc_lose_var": "npc_var"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "dynamic_var",
                            "required_event": "game_start",
                            "effect": {"u_lose_var": {"u_val": "v"}},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "add_var",
                            "required_event": "game_start",
                            "effect": {"u_add_var": "var", "value": 1},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "u_msg",
                            "required_event": "game_start",
                            "effect": {"u_message": "hello"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_msg",
                            "required_event": "npc_becomes_hostile",
                            "effect": {"npc_message": "hello"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "sound_msg",
                            "required_event": "game_start",
                            "effect": {"u_message": "hello", "sound": True},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "activate",
                            "required_event": "game_start",
                            "effect": {"u_activate_trait": "ELFAEYES"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "deactivate",
                            "required_event": "game_start",
                            "effect": {"u_deactivate_trait": "ELFAEYES"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_activate",
                            "required_event": "npc_becomes_hostile",
                            "effect": {"npc_activate_trait": "ELFAEYES"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_deactivate",
                            "required_event": "npc_becomes_hostile",
                            "effect": {"npc_deactivate_trait": "ELFAEYES"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "dynamic_trait_effect",
                            "required_event": "game_start",
                            "effect": {
                                "u_activate_trait": {"u_val": "trait_var"}
                            },
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "lose_var_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 10)
            self.assertEqual(len(result.partial), 2)
            self.assertIn(
                'services.variables.remove(actor, "quest_var")', main
            )
            self.assertIn(
                'services.variables.remove(actor, "npc_var")', main
            )
            self.assertIn(
                'services.message("hello")', main
            )
            self.assertIn(
                "services.mutations.set_active(", main
            )
            self.assertIn(
                "EOC dynamic_var effect #0 needs domain-service conversion",
                report,
            )
            self.assertIn(
                "EOC add_var effect #0 needs domain-service conversion",
                report,
            )
            self.assertNotIn(
                "EOC sound_msg effect #0 needs domain-service conversion",
                report,
            )
            self.assertNotIn(
                "EOC dynamic_trait_effect effect #0 needs domain-service conversion",
                report,
            )
            self.assertNotIn("run_eoc", main)

    def test_translates_literal_u_has_profession_with_proven_avatar(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "profession_game_start",
                            "required_event": "game_start",
                            "condition": {"u_has_profession": "unemployed"},
                            "effect": {"message": "unemployed"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "profession_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertIn(
                'character_has_profession(actor, "unemployed")',
                main,
            )
            self.assertIn(
                "local function character_has_profession(character, profession_id)",
                main,
            )
            self.assertIn(
                "services.characters.has_profession(",
                main,
            )
            self.assertNotIn("needs a native Lua predicate", report)
            self.assertNotIn("run_eoc", main)

    def test_translates_character_identity_and_npc_ai_rule_conditions(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "u_male_eoc",
                            "required_event": "game_start",
                            "condition": "u_male",
                            "effect": {"message": "u_male"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "u_char_eoc",
                            "required_event": "game_start",
                            "condition": "u_is_character",
                            "effect": {"message": "u_char"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_male_eoc",
                            "required_event": "npc_becomes_hostile",
                            "condition": "npc_male",
                            "effect": {"message": "npc_male"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_female_eoc",
                            "required_event": "npc_becomes_hostile",
                            "condition": "npc_female",
                            "effect": {"message": "npc_female"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_char_eoc",
                            "required_event": "npc_becomes_hostile",
                            "condition": "npc_is_character",
                            "effect": {"message": "npc_char"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_npc_eoc",
                            "required_event": "npc_becomes_hostile",
                            "condition": "npc_is_npc",
                            "effect": {"message": "npc_npc"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_outside_eoc",
                            "required_event": "npc_becomes_hostile",
                            "condition": "npc_is_outside",
                            "effect": {"message": "npc_outside"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_aim_eoc",
                            "required_event": "npc_becomes_hostile",
                            "condition": {"npc_aim_rule": "AIM_WHEN_CONVENIENT"},
                            "effect": {"message": "npc_aim"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_engage_eoc",
                            "required_event": "npc_becomes_hostile",
                            "condition": {"npc_engagement_rule": "ENGAGE_ALL"},
                            "effect": {"message": "npc_engage"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_reserve_eoc",
                            "required_event": "npc_becomes_hostile",
                            "condition": {"npc_cbm_reserve_rule": "CBM_RESERVE_ALL"},
                            "effect": {"message": "npc_reserve"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_recharge_eoc",
                            "required_event": "npc_becomes_hostile",
                            "condition": {"npc_cbm_recharge_rule": "CBM_RECHARGE_ALL"},
                            "effect": {"message": "npc_recharge"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "invalid_aim_eoc",
                            "required_event": "npc_becomes_hostile",
                            "condition": {"npc_aim_rule": "UNKNOWN_RULE"},
                            "effect": {"message": "invalid_aim"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "identity_rules_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 11)
            self.assertEqual(len(result.partial), 1)
            self.assertIn(
                "service_value(services.characters.snapshot(actor)).male",
                main,
            )
            self.assertIn(
                "not service_value(services.characters.snapshot(actor)).male",
                main,
            )
            self.assertIn(
                "services.gameplay.environment.is_outside(",
                main,
            )
            self.assertIn(
                'service_value(services.npcs.ai_rules(actor)).aim == "AIM_WHEN_CONVENIENT"',
                main,
            )
            self.assertIn(
                'service_value(services.npcs.ai_rules(actor)).engagement == "ENGAGE_ALL"',
                main,
            )
            self.assertIn(
                'service_value(services.npcs.ai_rules(actor)).cbm_reserve == "CBM_RESERVE_ALL"',
                main,
            )
            self.assertIn(
                'service_value(services.npcs.ai_rules(actor)).cbm_recharge == "CBM_RECHARGE_ALL"',
                main,
            )
            self.assertIn(
                "EOC invalid_aim_eoc condition needs a native Lua predicate",
                report,
            )
            self.assertNotIn("run_eoc", main)

    def test_translates_character_entity_vehicle_and_npc_effects(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "avatar_entity_predicates",
                            "required_event": "game_start",
                            "condition": {
                                "and": [
                                    "u_exists",
                                    "has_alpha",
                                    "u_friend",
                                    {"not": "u_is_npc"},
                                    {"not": "u_is_monster"},
                                    {"not": "u_is_item"},
                                    {"not": "u_is_furniture"},
                                    {"not": "u_is_vehicle"},
                                    {"not": "u_hostile"},
                                    {"not": "u_is_in_vehicle"},
                                    {"not": "u_controlling_vehicle"},
                                    {"not": "u_driving"},
                                    {"not": "u_is_riding"},
                                    {"not": "u_is_avatar_passenger"},
                                    {"not": "u_is_driven"},
                                    {"not": "u_is_remote_controlled"},
                                    {"not": "u_is_on_rails"},
                                ]
                            },
                            "effect": {"message": "avatar predicates ok"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_entity_and_effects",
                            "required_event": "npc_becomes_hostile",
                            "condition": {
                                "and": [
                                    "npc_exists",
                                    "npc_hostile",
                                    {"not": "npc_is_avatar"},
                                    {"not": "npc_is_monster"},
                                    {"not": "npc_is_item"},
                                    {"not": "npc_is_furniture"},
                                    {"not": "npc_is_vehicle"},
                                    {"not": "npc_friend"},
                                ]
                            },
                            "effect": [
                                {"npc_add_bionic": "bio_power_storage"},
                                {"npc_lose_bionic": "bio_power_storage"},
                                {"npc_learn_recipe": "bandages"},
                                {"npc_forget_recipe": "bandages"},
                                {"npc_learn_martial_art": "style_karate"},
                                {"npc_forget_martial_art": "style_karate"},
                                {
                                    "npc_add_morale": "morale_chat",
                                    "bonus": 10,
                                    "max_bonus": 50,
                                },
                                {"npc_lose_morale": "morale_chat"},
                            ],
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "unproven_presence",
                            "required_event": "npc_becomes_hostile",
                            "condition": "u_has_items",
                            "effect": {"message": "unproven"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "entity_npc_effects_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(len(result.partial), 1)
            self.assertIn("services.bionics.grant(", main)
            self.assertIn("services.bionics.remove_type(", main)
            self.assertIn("services.recipes.learn(", main)
            self.assertIn("services.recipes.forget(", main)
            self.assertIn("services.martial_arts.learn(", main)
            self.assertIn("services.martial_arts.forget(", main)
            self.assertIn("services.morale.add(", main)
            self.assertIn("services.morale.remove(", main)
            self.assertIn(
                "EOC unproven_presence condition needs a native Lua predicate",
                report,
            )
            self.assertNotIn("needs a native Lua effect", report)
            self.assertNotIn("run_eoc", main)

    def test_translates_dialogue_mission_and_npc_vehicle_predicates(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "avatar_dialogue_and_missions",
                            "required_event": "game_start",
                            "condition": {
                                "and": [
                                    "has_alpha",
                                    {"not": "has_beta"},
                                    {"not": "is_by_radio"},
                                    {"not": "has_reason"},
                                    {"not": "u_vehicle_owned_by_avatar"},
                                    {"not": "has_assigned_mission"},
                                    {"not": "has_many_assigned_missions"},
                                    "has_no_assigned_mission",
                                    {"not": "has_available_mission"},
                                    {"not": "has_many_available_missions"},
                                    "has_no_available_mission",
                                    {"not": "mission_complete"},
                                    {"not": "mission_incomplete"},
                                    {"not": "mission_failed"},
                                    {"not": {"mission_goal": "MGOAL_ASSASSINATE"}},
                                    {"not": {"follower_present": "FOLLOWER"}},
                                    {"not": {"u_override": "OVERRIDE"}},
                                    {"is_outside": {"context_val": "loc"}},
                                ]
                            },
                            "effect": {"message": "avatar dialogue ok"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_movement_vehicle_and_missions",
                            "required_event": "npc_becomes_hostile",
                            "condition": {
                                "and": [
                                    "npc_available",
                                    "npc_has_no_available_mission",
                                    {"not": "npc_is_in_vehicle"},
                                    {"not": "npc_controlling_vehicle"},
                                    {"not": "npc_driving"},
                                    {"not": "npc_is_riding"},
                                    {"not": "npc_is_avatar_passenger"},
                                    {"not": "npc_is_driven"},
                                    {"not": "npc_is_remote_controlled"},
                                    {"not": "npc_is_on_rails"},
                                    {"not": "npc_vehicle_owned_by_avatar"},
                                    {"not": "npc_following"},
                                    {"not": "npc_has_assigned_camp"},
                                    {"not": "npc_has_available_mission"},
                                    {"not": "npc_has_many_available_missions"},
                                    {"not": "npc_mission_complete"},
                                    {"not": "npc_mission_incomplete"},
                                    {"not": "npc_mission_failed"},
                                    {"not": {"npc_mission_goal": "MGOAL_ASSASSINATE"}},
                                    {"not": {"npc_rule": "RULE"}},
                                    {"not": {"npc_override": "OVERRIDE"}},
                                ]
                            },
                            "effect": {"message": "npc states ok"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "dialogue_mission_predicates_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(len(result.partial), 0)
            self.assertIn('services.gameplay.environment.is_outside(context.data["loc"])', main)
            self.assertNotIn("run_eoc", main)



    def test_dynamic_or_unproven_u_has_profession_shapes_stay_partial(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            cases = [
                ("npc_becomes_hostile", {"u_has_profession": "unemployed"}),
                ("game_start", {"u_has_profession": {"context_val": "profession_id"}}),
                ("game_start", {"npc_has_profession": "unemployed"}),
                ("character_kills_monster", {"u_has_profession": "unemployed"}),
            ]
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": f"profession_{index}",
                            "required_event": event,
                            "condition": condition,
                            "effect": {"message": "must stay partial"},
                        }
                        for index, (event, condition) in enumerate(cases)
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "profession_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 3)
            self.assertEqual(len(result.partial), 1)
            self.assertIn("character_has_profession", main)
            self.assertEqual(
                report.count("condition needs a native Lua predicate"),
                1,
            )
            self.assertNotIn("run_eoc", main)

    def test_translates_literal_u_has_flag_with_proven_alpha(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "flag_game_start",
                            "required_event": "game_start",
                            "condition": {
                                "u_has_flag": "MUTATION_THRESHOLD"
                            },
                            "effect": {"message": "threshold"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "flag_item",
                            "required_event": "character_wields_item",
                            "condition": {"u_has_flag": "SAMPLE_FLAG"},
                            "effect": {"message": "wielded"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "flag_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(result.partial, [])
            self.assertIn(
                'service_value(services.characters.has_flag(actor, '
                'services.types.id("json_flag", "MUTATION_THRESHOLD")))',
                main,
            )
            self.assertIn(
                'services.types.id("json_flag", "SAMPLE_FLAG")',
                main,
            )
            self.assertEqual(
                main.count("services.characters.avatar()"), 1
            )
            self.assertEqual(
                main.count("context.actors.character"), 1
            )
            self.assertNotIn("needs a native Lua predicate", report)
            self.assertNotIn("run_eoc", main)

    def test_dynamic_or_unproven_u_has_flag_shapes_stay_partial(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            cases = [
                ("npc_becomes_hostile", {"u_has_flag": "SAMPLE_FLAG"}),
                ("game_start", {"u_has_flag": {"context_val": "flag_id"}}),
                ("game_start", {"npc_has_flag": "SAMPLE_FLAG"}),
                ("character_kills_monster", {"u_has_flag": "SAMPLE_FLAG"}),
            ]
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": f"flag_{index}",
                            "required_event": event,
                            "condition": condition,
                            "effect": {"message": "must stay partial"},
                        }
                        for index, (event, condition) in enumerate(cases)
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "flag_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 3)
            self.assertEqual(len(result.partial), 1)
            self.assertIn("services.characters.has_flag", main)
            self.assertEqual(
                report.count("condition needs a native Lua predicate"),
                1,
            )
            self.assertNotIn("run_eoc", main)

    def test_translates_literal_u_is_wearing_with_proven_alpha(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "wearing_game_start",
                            "required_event": "game_start",
                            "condition": {"u_is_wearing": "army_top"},
                            "effect": {"message": "wearing"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "wearing_item",
                            "required_event": "character_wields_item",
                            "condition": {"u_is_wearing": "socks"},
                            "effect": {"message": "item wearing"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "wearing_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(result.partial, [])
            self.assertIn('character_is_wearing(actor, "army_top")', main)
            self.assertIn('character_is_wearing(actor, "socks")', main)
            self.assertEqual(
                main.count("services.characters.avatar()"), 1
            )
            self.assertEqual(
                main.count("context.actors.character"), 1
            )
            self.assertEqual(
                main.count("local function character_is_wearing"), 1
            )
            self.assertNotIn("needs a native Lua predicate", report)
            self.assertNotIn("run_eoc", main)

    def test_dynamic_or_unproven_u_is_wearing_shapes_stay_partial(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            cases = [
                ("npc_becomes_hostile", {"u_is_wearing": "army_top"}),
                ("game_start", {"u_is_wearing": {"u_val": "worn_id"}}),
                ("game_start", {"npc_is_wearing": "army_top"}),
                ("character_kills_monster", {"u_is_wearing": "army_top"}),
            ]
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": f"wearing_{index}",
                            "required_event": event,
                            "condition": condition,
                            "effect": {"message": "must stay partial"},
                        }
                        for index, (event, condition) in enumerate(cases)
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "wearing_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 3)
            self.assertEqual(len(result.partial), 1)
            self.assertIn("character_is_wearing", main)
            self.assertEqual(
                report.count("condition needs a native Lua predicate"),
                1,
            )
            self.assertNotIn("run_eoc", main)

    def test_translates_game_start_is_outside_predicate(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "outside",
                            "required_event": "game_start",
                            "condition": "u_is_outside",
                            "effect": {"message": "outside"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_outside",
                            "required_event": "game_start",
                            "condition": "npc_is_outside",
                            "effect": {"message": "npc outside"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "item_outside",
                            "required_event": "character_wields_item",
                            "condition": "u_is_outside",
                            "effect": {"message": "item outside"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "is_outside_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(len(result.partial), 1)
            self.assertIn('runtime.on("game:game_start"', main)
            self.assertIn(
                "services.gameplay.environment.is_outside("
                "service_value(services.characters.snapshot(actor))"
                ".creature.position)",
                main,
            )
            self.assertIn(
                "EOC npc_outside condition needs a native Lua predicate",
                report,
            )
            self.assertNotIn(
                "EOC item_outside condition needs a native Lua predicate",
                report,
            )
            self.assertNotIn("run_eoc", main)

    def test_translates_literal_flag_map_furniture_with_flag_predicate(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "furniture_flag",
                            "required_event": "game_start",
                            "condition": {
                                "map_furniture_with_flag": "TRANSPARENT",
                                "loc": {"context_val": "target_location"},
                            },
                            "effect": {"message": "transparent furniture"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "dynamic_flag",
                            "required_event": "game_start",
                            "condition": {
                                "map_furniture_with_flag": {
                                    "u_val": "remembered_flag"
                                },
                                "loc": {"context_val": "target_location"},
                            },
                            "effect": {"message": "dynamic flag"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "non_context_loc",
                            "required_event": "game_start",
                            "condition": {
                                "map_furniture_with_flag": "TRANSPARENT",
                                "loc": {"u_val": "remembered_location"},
                            },
                            "effect": {"message": "non-context loc"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "furniture_flag_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(len(result.partial), 1)
            self.assertIn(
                'services.gameplay.environment.furniture_has_flag('
                'context.data["target_location"], "TRANSPARENT")',
                main,
            )
            self.assertIn(
                "EOC dynamic_flag condition needs a native Lua predicate",
                report,
            )
            self.assertNotIn(
                "EOC non_context_loc condition needs a native Lua predicate",
                report,
            )
            self.assertNotIn("run_eoc", main)

    def test_translates_literal_u_has_mission_in_any_event(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            cases = [
                ("game_start", {"u_has_mission": "MISSION_MAIN_QUEST"}),
                ("character_wields_item", {"u_has_mission": "MISSION_MAIN_QUEST"}),
            ]
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": f"mission_{index}",
                            "required_event": event,
                            "condition": condition,
                            "effect": {"message": "mission active"},
                        }
                        for index, (event, condition) in enumerate(cases)
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "mission_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), len(cases))
            self.assertEqual(result.partial, [])
            self.assertIn(
                'service_value(services.missions.avatar_has_active('
                'services.types.id("mission", "MISSION_MAIN_QUEST")))',
                main,
            )
            self.assertNotIn("needs a native Lua predicate", report)
            self.assertNotIn("run_eoc", main)

    def test_dynamic_or_unproven_u_has_mission_shapes_stay_partial(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            cases = [
                ("game_start", {"u_has_mission": {"context_val": "mission_id"}}),
                ("game_start", {"u_has_mission": 5}),
                ("game_start", {"u_has_mission": ""}),
            ]
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": f"mission_{index}",
                            "required_event": event,
                            "condition": condition,
                            "effect": {"message": "must stay partial"},
                        }
                        for index, (event, condition) in enumerate(cases)
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "mission_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(result.converted, [])
            self.assertEqual(len(result.partial), len(cases))
            self.assertNotIn("services.missions.avatar_has_active", main)
            self.assertEqual(
                report.count("condition needs a native Lua predicate"),
                len(cases),
            )
            self.assertNotIn("run_eoc", main)

    def test_translates_u_has_camp_in_any_event(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            cases = [
                ("game_start", "u_has_camp"),
                ("character_wields_item", "u_has_camp"),
            ]
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": f"camp_{index}",
                            "required_event": event,
                            "condition": condition,
                            "effect": {"message": "has camp"},
                        }
                        for index, (event, condition) in enumerate(cases)
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "camp_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), len(cases))
            self.assertEqual(result.partial, [])
            self.assertIn(
                "service_value(services.camps.player_has_camp())",
                main,
            )
            self.assertNotIn("needs a native Lua predicate", report)
            self.assertNotIn("run_eoc", main)

    def test_dynamic_or_unproven_u_has_camp_shapes_stay_partial(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "camp_dict",
                            "required_event": "game_start",
                            "condition": {"u_has_camp": "ignored"},
                            "effect": {"message": "must stay partial"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "camp_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(result.converted, [])
            self.assertEqual(len(result.partial), 1)
            self.assertNotIn("services.camps.player_has_camp", main)
            self.assertEqual(
                report.count("condition needs a native Lua predicate"),
                1,
            )
            self.assertNotIn("run_eoc", main)

    def test_renders_butchery_requirement_catalog(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            size_entry = {
                "BLEED": "bleed_small",
                "QUICK": "butchery_small",
                "FULL": "butchery_small",
                "FIELD_DRESS": "field_dress",
                "SKIN": "field_dress",
                "QUARTER": "field_dress",
                "DISMEMBER": "field_dress",
                "DISSECT": "dissect_small",
            }
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "butchery_requirement",
                            "id": "default",
                            "requirements": {
                                "1.0": [size_entry] * 5,
                                "1.2": [size_entry] * 5,
                            },
                        },
                        {
                            "type": "butchery_requirement",
                            "id": "short_rows",
                            "requirements": {
                                "2.0": [size_entry] * 3,
                            },
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "butcher_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 1)
            self.assertIn("content.ButcheryRequirement", main)
            self.assertIn(
                'definition:requirement(1, "TINY", "BLEED", "bleed_small")',
                main,
            )
            self.assertIn(
                'definition:requirement(1.2, "HUGE", "DISSECT", "dissect_small")',
                main,
            )
            self.assertEqual(
                main.count("definition:requirement("), 80
            )
            self.assertIn(
                "butchery requirement short_rows speed row '2.0' needs review",
                report,
            )

    def test_renders_item_action_catalog_with_name_fallback(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "item_action",
                            "id": "repair_fabric",
                            "name": {"str": "Repair fabric"},
                        },
                        {
                            "type": "item_action",
                            "id": "mp3",
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "ia_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(len(result.partial), 0)
            self.assertIn("content.ItemAction", main)
            self.assertIn(
                '    id = "repair_fabric",\n    name = "Repair fabric",',
                main,
            )
            self.assertIn(
                '    id = "mp3",\n    name = "mp3",',
                main,
            )

    def test_renders_scenario_catalog_bounded_with_explicit_todos(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "scenario",
                            "id": "evacuee",
                            "name": "Evacuee",
                            "points": 0,
                            "description": "You survived the initial wave.",
                            "allowed_locs": ["sloc_shelter_safe"],
                            "start_name": "Evac Shelter",
                            "flags": ["CITY_START"],
                        },
                        {
                            "type": "scenario",
                            "id": "lab_challenge",
                            "name": "Lab Challenge",
                            "points": 3,
                            "description": "The lab.",
                            "allowed_locs": ["sloc_lab"],
                            "start_name": "Lab",
                            "flags": ["CHALLENGE"],
                            "professions": ["labtech"],
                            "traits": ["PROF_SKILLED_LIAR"],
                            "forced_traits": ["TOUGH"],
                            "forbidden_traits": ["PACIFIST"],
                            "requirement": "achievement_kill_100",
                            "eoc": ["eoc_lab_wakeup"],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "sc_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 1)
            self.assertIn("content.Scenario", main)
            self.assertIn('definition:location("sloc_shelter_safe")', main)
            self.assertIn('definition:flag("CITY_START")', main)
            self.assertIn('definition:profession("labtech")', main)
            self.assertIn('definition:allowed_trait("PROF_SKILLED_LIAR")', main)
            self.assertIn('definition:forced_trait("TOUGH")', main)
            self.assertIn('definition:forbidden_trait("PACIFIST")', main)
            self.assertIn(
                'definition:requirement("achievement_kill_100")',
                main,
            )
            self.assertIn(
                "scenario lab_challenge unresolved fields: eoc",
                report,
            )

    def test_renders_vehicle_color_palette_catalog(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "vehicle_color_palette",
                            "id": "sample_palette",
                            "palette": [
                                {
                                    "fuzzy_ids": ["door", "roof"],
                                    "colors": [
                                        {"color": "Jet black", "weight": 10},
                                        {"color": "Cataclysm Red", "weight": 5},
                                    ],
                                },
                            ],
                        },
                        {
                            "type": "vehicle_color_palette",
                            "id": "bad_palette",
                            "palette": [
                                {
                                    "fuzzy_ids": ["door"],
                                    "colors": [
                                        {"color": "Jet black", "weight": 0},
                                    ],
                                },
                            ],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "vp_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 1)
            self.assertIn("content.VehicleColorPalette", main)
            self.assertIn(
                'definition:group({ "door", "roof" }, {',
                main,
            )
            self.assertIn(
                '{ "Jet black", 10 },',
                main,
            )
            self.assertIn(
                "vehicle color palette bad_palette group needs review",
                report,
            )

    def test_renders_monster_group_catalog_bounded_with_explicit_todos(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "monstergroup",
                            "id": "GROUP_SAMPLE",
                            "default": "mon_zombie",
                            "is_animal": False,
                            "monsters": [
                                {
                                    "monster": "mon_zombie",
                                    "weight": 100,
                                    "cost_multiplier": 0,
                                    "pack_size": [1, 2],
                                },
                                {
                                    "group": "GROUP_OTHER",
                                    "weight": 50,
                                    "cost_multiplier": 1,
                                },
                            ],
                        },
                        {
                            "type": "monstergroup",
                            "id": "GROUP_GATED",
                            "monsters": [
                                {
                                    "monster": "mon_zombie",
                                    "weight": 100,
                                    "starts": "30 days",
                                },
                            ],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "mg_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 1)
            self.assertIn("content.MonsterGroup", main)
            self.assertIn('    default_monster = "mon_zombie",', main)
            self.assertIn(
                'definition:monster("mon_zombie", 100, 0, 1, 2)',
                main,
            )
            self.assertIn(
                'definition:group("GROUP_OTHER", 50, 1, 1, 1)',
                main,
            )
            self.assertIn(
                "monster group GROUP_GATED entry mon_zombie needs review",
                report,
            )

    def test_renders_overmap_connection_catalog(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "overmap_connection",
                            "id": "sample_connection",
                            "subtypes": [
                                {
                                    "terrain": "road",
                                    "locations": ["road"],
                                    "basic_cost": 0,
                                    "flags": ["ORTHOGONAL"],
                                },
                                {
                                    "terrain": "road",
                                    "locations": ["stream"],
                                    "basic_cost": 30,
                                    "flags": ["PERPENDICULAR_CROSSING"],
                                },
                                {
                                    "terrain": "road_nesw_manhole",
                                    "locations": [],
                                },
                            ],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "oc_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 0)
            self.assertIn("content.OvermapConnection", main)
            self.assertIn(
                'definition:subtype("road", 0, { "road" }, true, false)',
                main,
            )
            self.assertIn(
                'definition:subtype("road", 30, { "stream" }, false, true)',
                main,
            )
            self.assertIn(
                'definition:subtype("road_nesw_manhole", 0, {  }, false, false)',
                main,
            )

    def test_uses_event_actor_proof_for_character_kill_shapes(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "ambiguous_alpha",
                        "required_event": "character_kills_monster",
                        "condition": {"u_has_trait": "TOUGH"},
                        "effect": {
                            "u_add_effect": "downed",
                            "duration": 1,
                        },
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "actor_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertIn("services.mutations.has", main)
            self.assertIn("services.effects.add", main)
            self.assertNotIn("EOC ambiguous_alpha condition needs a native Lua predicate", report)
            self.assertNotIn("EOC ambiguous_alpha effect #0 needs domain-service conversion", report)
            self.assertNotIn("run_eoc", main)

    def test_recipe_abstracts_uncraft_and_missing_results_are_partial(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "recipe",
                            "abstract": "abstract_recipe",
                            "copy-from": "base_recipe",
                        },
                        {
                            "type": "uncraft",
                            "id": "disassembly_recipe",
                            "result": "scrap",
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "sample_mod"
            )
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(result.converted, [])
            self.assertEqual(len(result.partial), 2)
            self.assertIn("recipe abstract_recipe inheritance", report)
            self.assertIn(
                "uncraft disassembly_recipe native disassembly registration is bounded",
                report,
            )
            self.assertIn("uncraft = true", result.files[Path("main.lua")])

    def test_practice_recipes_emit_bounded_native_skeletons(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "practice",
                            "id": "prac_driving",
                            "result": "prac_driving_result",
                            "name": "driving drills",
                            "category": "CC_PRACTICE",
                            "subcategory": "CSC_PRACTICE_MECHANICS",
                            "skill_used": "driving",
                            "time": "1 h",
                            "practice_data": {
                                "min_difficulty": 0,
                                "max_difficulty": 1,
                                "skill_limit": 3,
                            },
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "sample_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(result.converted, [])
            self.assertEqual(len(result.partial), 1)
            self.assertIn('id = "prac_driving"', main)
            self.assertIn("practice = true", main)
            self.assertIn('skill = "driving"', main)
            self.assertIn("practice prac_driving practice_data needs review", report)
            self.assertNotIn("run_eoc", main)

    def test_missing_ids_and_mixed_eoc_effects_are_never_complete(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {"type": "GENERIC", "name": "missing id"},
                        {
                            "type": "effect_on_condition",
                            "id": "mixed_effects",
                            "effect": [
                                {"message": "translated"},
                                {"message": "not complete", "u_add_effect": "cold"},
                            ],
                        },
                        {
                            "type": "effect_on_condition",
                            "effect": {"message": "anonymous"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "sample_mod"
            )
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(result.converted, [])
            self.assertEqual(len(result.partial), 3)
            self.assertIn("has no concrete stable id", report)
            self.assertIn("needs a stable handler id", report)

    def test_malformed_or_out_of_range_native_fields_are_partial(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "GENERIC",
                            "id": "bad#item",
                            "name": "unsafe id",
                        },
                        {
                            "type": "GENERIC",
                            "id": "bad_ranges",
                            "name": "bad ranges",
                            "weight": "-1 g",
                            "volume": f"{1 << 31} ml",
                            "price": True,
                            "qualities": [["CUT", True]],
                            "flags": [""],
                        },
                        {
                            "type": "recipe",
                            "id": "bad_recipe_ranges",
                            "result": "bad_ranges",
                            "difficulty": 11,
                            "components": [["scrap", True]],
                            "skills_required": [["fabrication", -1]],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "sample_mod"
            )
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(result.converted, [])
            self.assertEqual(len(result.partial), 3)
            self.assertIn("safe native Platform id", report)
            self.assertIn("weight needs unit review", report)
            self.assertIn("volume needs unit review", report)
            self.assertIn("difficulty needs review", report)
            self.assertIn("required skill needs review", report)

    def test_foundational_catalogs_emit_native_builders_in_dependency_order(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "catalogs.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "ascii_art",
                            "id": "sample_art",
                            "picture": ["native Lua", "content art"],
                        },
                        {
                            "type": "limb_score",
                            "id": "sample_limb_score",
                            "name": "Sample balance",
                            "affected_by_wounds": False,
                            "affected_by_encumb": True,
                        },
                        {
                            "type": "hit_range",
                            "even_good": [1000, 500, 250],
                        },
                        {
                            "type": "bash_damage_profile",
                            "id": "sample_bash_profile",
                            "profile": {"sample_damage": 0.5},
                        },
                        {
                            "type": "clothing_mod",
                            "id": "sample_clothing_mod",
                            "flag": "SAMPLE_FLAG",
                            "item": "sample_material_item",
                            "implement_prompt": "Apply sample layer",
                            "destroy_prompt": "Remove sample layer",
                            "mod_value": [
                                {
                                    "type": "bash",
                                    "value": 2.5,
                                    "round_up": True,
                                    "proportion": ["thickness", "coverage"],
                                }
                            ],
                        },
                        {
                            "type": "overmap_land_use_code",
                            "id": "sample_land_use",
                            "land_use_code": 321,
                            "name": "Sample land use",
                            "detailed_definition": "Defined by native Lua",
                            "sym": "L",
                            "color": "light_blue",
                        },
                        {
                            "type": "oter_vision",
                            "id": "sample_vision",
                            "levels": [
                                {
                                    "name": "sample structure",
                                    "sym": "?",
                                    "color": "light_blue",
                                    "looks_like": "cabin",
                                },
                                {"blends_adjacent": True},
                            ],
                        },
                        {
                            "type": "overmap_location",
                            "id": "sample_overmap_location",
                            "terrains": ["field"],
                            "flags": ["ROAD"],
                        },
                        {
                            "type": "profession_group",
                            "id": "sample_profession_group",
                            "professions": ["unemployed"],
                        },
                        {
                            "type": "map_extra_collection",
                            "id": "sample_map_extras",
                            "chance": 17,
                            "extras": [["mx_crater", 25]],
                        },
                        {
                            "type": "vehicle_group",
                            "id": "sample_vehicles",
                            "vehicles": [["car", 80]],
                        },
                        {
                            "type": "fault_group",
                            "id": "sample_faults",
                            "group": [
                                {"fault": "fault_armor_lc_dented", "weight": 100}
                            ],
                        },
                        {
                            "type": "explosion_light",
                            "id": "sample_explosion_light",
                            "stops": [
                                {"color": [255, 180, 40], "alpha": 150},
                                {"color": [180, 20, 0], "alpha": 60},
                            ],
                            "easing": "smoothstep",
                            "wave_travel": 0.4,
                            "duration_min_ms": 120,
                            "duration_max_ms": 500,
                            "screen_shake_magnitude": 2.0,
                            "screen_shake_duration_ms": 80,
                            "shockwave": True,
                            "shockwave_strength": 0.25,
                            "shockwave_speed": 1.5,
                            "shockwave_thickness": 1.0,
                        },
                        {
                            "type": "ammo_effect",
                            "id": "sample_ammo_effect",
                            "trigger_chance": 75,
                            "aoe": [
                                {
                                    "field_type": "fd_smoke",
                                    "intensity_min": 1,
                                    "intensity_max": 2,
                                    "radius": 2,
                                    "chance": 50,
                                }
                            ],
                            "trail": [
                                {
                                    "field_type": "fd_smoke",
                                    "intensity_min": 1,
                                    "intensity_max": 1,
                                }
                            ],
                            "on_hit_effects": [
                                {
                                    "effect": "onfire",
                                    "duration": 5,
                                    "intensity": 1,
                                }
                            ],
                            "explosion": {
                                "power": 10,
                                "distance_factor": 0.5,
                                "light_effect": "sample_explosion_light",
                                "shrapnel": {
                                    "casing_mass": 10,
                                    "fragment_mass": 0.1,
                                },
                            },
                        },
                        {
                            "type": "addiction_type",
                            "id": "sample_addiction",
                            "name": "Sample withdrawal",
                            "type_name": "samples",
                            "description": "Needs a native Lua tick policy.",
                            "craving_morale": "sample_craving",
                            "builtin": "sample_builtin",
                        },
                        {
                            "type": "character_mod",
                            "id": "sample_character_modifier",
                            "description": "Sample modifier",
                            "mod_type": "x",
                            "value": {"builtin": "sample_builtin"},
                        },
                        {
                            "type": "start_location",
                            "id": "sample_start_location",
                            "name": "Sample start",
                            "terrain": [
                                {
                                    "om_terrain": "field",
                                    "om_terrain_match_type": "TYPE",
                                    "parameters": {"sample_palette": "test"},
                                }
                            ],
                            "flags": ["ALLOW_OUTSIDE"],
                            "city_sizes": [0, 20],
                            "allowed_z_levels": [0, 0],
                        },
                        {
                            "type": "climbing_aid",
                            "id": "sample_climbing_aid",
                            "slip_chance_mod": -10,
                            "condition": {"type": "special", "flag": "SAMPLE"},
                            "down": {
                                "menu_text": "Use sample aid.",
                                "confirm_text": "Climb?",
                                "msg_after": "You climb.",
                                "max_height": 2,
                                "cost": {"pain": 1, "kcal": 2},
                            },
                        },
                        {
                            "type": "weather_type",
                            "id": "sample_weather",
                            "name": "Sample rain",
                            "color": "light_blue",
                            "map_color": "h_light_blue",
                            "sym": ".",
                            "sun_sym": "☂",
                            "ranged_penalty": 2,
                            "sight_penalty": 1.1,
                            "light_modifier": -10,
                            "temperature_modifier": "-10 C",
                            "light_multiplier": 0.8,
                            "sun_multiplier": 0.4,
                            "sound_attn": 3,
                            "dangerous": True,
                            "precip": "light",
                            "rains": True,
                            "tiles_animation": "weather_rain_drop",
                            "sound_category": "rainy",
                            "priority": 45,
                            "duration_min": "2 m",
                            "duration_max": "5 m",
                            "weather_animation": {
                                "factor": 0.02,
                                "color": "light_blue",
                                "sym": ",",
                            },
                            "required_weathers": ["cloudy"],
                            "passive_effects": [{
                                "effect_id": "cold",
                                "min_duration": "1 m",
                                "max_duration": "2 m",
                                "intensity": 2,
                                "body_part": "torso",
                                "chance_outside_vehicle": 25,
                                "message": "The rain chills you.",
                            }],
                            "condition": {
                                "math": ["weather('humidity') >= 80"]
                            },
                            "debug_cause_eoc": "EOC_SAMPLE_WEATHER",
                        },
                        {
                            "type": "score",
                            "id": "sample_score",
                            "statistic": "num_moves",
                            "description": "%s sample moves",
                        },
                        {
                            "type": "overlay_order",
                            "overlay_ordering": [
                                {
                                    "id": ["THRESH_SAMPLE", "WINGS_SAMPLE"],
                                    "order": 500,
                                }
                            ],
                        },
                        {
                            "type": "LOOT_ZONE",
                            "id": "SAMPLE_ZONE",
                            "name": "Sample zone",
                            "description": "A native Lua zone.",
                            "display_field": "fd_no_auto_pickup_zone",
                            "can_be_personal": True,
                        },
                        {
                            "type": "speech",
                            "speaker": ["sample_speaker", "sample_listener"],
                            "sound": "Sample speech one.",
                            "volume": 20,
                        },
                        {
                            "type": "speech",
                            "speaker": "sample_speaker",
                            "sound": "Sample speech two.",
                            "volume": 30,
                        },
                        {
                            "type": "end_screen",
                            "id": "sample_end_screen",
                            "picture_id": "sample_art",
                            "priority": 100,
                            "condition": {"u_has_trait": "SAMPLE_TRAIT"},
                            "added_info": [
                                [[2, 3], "Sample ending for <u_name>"]
                            ],
                            "last_words_label": "Last sample words:",
                        },
                        {
                            "type": "activity_type",
                            "id": "ACT_SAMPLE_LUA",
                            "verb": "working in Lua",
                            "rooted": True,
                            "based_on": "neither",
                            "activity_level": "LIGHT_EXERCISE",
                            "ignored_distractions": ["noise", "weather_change"],
                            "do_turn_eoc": "EOC_SAMPLE_ACTIVITY_TURN",
                            "completion_eoc": "EOC_SAMPLE_ACTIVITY_FINISH",
                        },
                        {
                            "type": "help",
                            "order": 7,
                            "name": "Lua help",
                            "messages": [
                                "Native Lua help paragraph.",
                                "<HELP_DRAW_DIRECTIONS>",
                            ],
                        },
                        {
                            "type": "snippet",
                            "category": "<sample_lore>",
                            "text": [
                                "Anonymous sample lore.",
                                {
                                    "id": "sample_lore_entry",
                                    "text": "Named sample lore.",
                                    "name": "Sample lore",
                                    "weight": 3,
                                    "effect_on_examine": [
                                        {"u_add_var": "sample_seen", "value": "yes"}
                                    ],
                                },
                            ],
                        },
                        {
                            "type": "playlist",
                            "playlists": [
                                {
                                    "id": "sample_playlist",
                                    "shuffle": True,
                                    "files": [
                                        {"file": "music/sample.ogg", "volume": 96}
                                    ],
                                }
                            ],
                        },
                        {
                            "type": "attack_vector",
                            "id": "sample_attack_vector",
                            "limbs": ["hand_l"],
                            "contact_area": ["hand_palm_l"],
                            "limb_req": [["hand", 1]],
                            "bp_hp_limit": 25,
                            "encumbrance_limit": 50,
                        },
                        {
                            "type": "magic_type",
                            "id": "sample_magic",
                            "energy_source": {
                                "type": "VITAMIN",
                                "vitamin": "sample_vitamin",
                                "color": "light_blue",
                            },
                            "cannot_cast_flags": ["NO_SAMPLE_MAGIC"],
                            "cannot_cast_message": "Sample magic is unavailable.",
                            "max_book_level": 5,
                            "failure_cost_percent": 0.25,
                            "failure_exp_percent": 0.5,
                        },
                        {
                            "type": "movement_mode",
                            "id": "sample_stride",
                            "character": "s",
                            "panel_char": "S",
                            "name": "stride",
                            "panel_color": "light_green",
                            "symbol_color": "green",
                            "exertion_level": "MODERATE_EXERCISE",
                            "exertion_level_animal_riding": "LIGHT_EXERCISE",
                            "prepare_none": "Prepare to stride.",
                            "prepare_animal": "Steed prepares to stride.",
                            "prepare_mech": "Mech prepares to stride.",
                            "change_good_none": "Start striding.",
                            "change_good_animal": "Steed starts striding.",
                            "change_good_mech": "Mech starts striding.",
                            "move_type": "walking",
                            "move_speed_multiplier": 1.25,
                        },
                        {
                            "type": "material",
                            "id": "sample_material",
                            "name": "Sample material",
                            "resist": {"sample_damage": 2},
                        },
                        {
                            "type": "damage_type",
                            "id": "sample_damage",
                            "name": "sample damage",
                            "skill": "sample_skill",
                        },
                        {
                            "type": "damage_info_order",
                            "id": "sample_damage",
                            "info_display": "detailed",
                            "verb": "sample striking",
                            "bionic_info": {"order": 12, "show_type": True},
                        },
                        {
                            "type": "vitamin",
                            "id": "sample_vitamin",
                            "vit_type": "vitamin",
                            "name": "Sample vitamin",
                            "min": -100,
                            "max": 10,
                            "rate": "15 m",
                            "weight_per_unit": "10 mg 420 μg",
                        },
                        {
                            "type": "skill",
                            "id": "sample_skill",
                            "name": "Sample skill",
                            "description": "Native Lua skill",
                            "display_category": "sample_display",
                        },
                        {
                            "type": "skill_display_type",
                            "id": "sample_display",
                            "display_string": "Sample skills",
                        },
                        {
                            "type": "tool_quality",
                            "id": "SAMPLE_QUALITY",
                            "name": "sample quality",
                            "usages": [[1, ["sample usage"]]],
                        },
                        {
                            "type": "json_flag",
                            "id": "SAMPLE_FLAG",
                            "info": "Sample flag",
                        },
                        {
                            "type": "proficiency_category",
                            "id": "sample_proficiency_category",
                            "name": "Sample proficiencies",
                            "description": "Native Lua proficiency category",
                        },
                        {
                            "type": "proficiency",
                            "id": "sample_proficiency",
                            "name": "Sample proficiency",
                            "description": "Native Lua proficiency",
                            "category": "sample_proficiency_category",
                            "can_learn": True,
                            "time_to_learn": "2 h",
                            "bonuses": {
                                "sample": [{"type": "strength", "value": 1}]
                            },
                        },
                        {
                            "type": "weapon_category",
                            "id": "SAMPLE_WEAPONS",
                            "name": "SAMPLE WEAPONS",
                            "proficiencies": ["sample_proficiency"],
                        },
                        {
                            "type": "ITEM_CATEGORY",
                            "id": "sample_items",
                            "name_header": "Sample items",
                            "name_noun": "sample item",
                            "sort_rank": 12,
                            "priority_zones": [
                                {"id": "LOOT_OTHER", "flags": ["SAMPLE_FLAG"]}
                            ],
                        },
                        {
                            "type": "recipe_category",
                            "id": "CC_SAMPLE",
                            "recipe_subcategories": ["CSC_ALL", "CSC_SAMPLE_MISC"],
                        },
                        {
                            "type": "ammunition_type",
                            "id": "sample_ammunition",
                            "name": "sample ammunition",
                        },
                        {
                            "type": "scent_type",
                            "id": "sample_scent",
                            "receptive_species": ["MAMMAL", "BIRD"],
                        },
                        {
                            "type": "speed_description",
                            "id": "sample_speed",
                            "values": [
                                {"value": 1.1, "descriptions": "It is faster."},
                                {
                                    "value": 0.8,
                                    "descriptions": ["It is slower.", "It lags behind."],
                                },
                            ],
                        },
                        {
                            "type": "harvest_drop_type",
                            "id": "sample_drop",
                            "harvest_skills": ["sample_skill"],
                            "dissect_only": True,
                            "msg_dissect_fail": "sample_dissect_failure",
                        },
                        {
                            "type": "harvest",
                            "id": "sample_harvest",
                            "message": "Native Lua harvest",
                            "leftovers": "sample_item",
                            "butchery_requirements": "default",
                            "entries": [
                                {
                                    "drop": "sample_item",
                                    "type": "sample_drop",
                                    "base_num": [1, 4],
                                    "scale_num": [0, 0.5],
                                    "max": 20,
                                    "mass_ratio": 0.25,
                                    "flags": ["SAMPLE_FLAG"],
                                    "faults": ["fault_sample"],
                                }
                            ],
                        },
                        {
                            "type": "behavior",
                            "id": "sample_behavior",
                            "goal": "sample_goal",
                            "conditions": [
                                {
                                    "predicate": "npc_has_food",
                                    "argument": "sample argument",
                                    "invert_result": True,
                                }
                            ],
                            "score": "npc_hunger_urgency",
                            "score_argument": "sample score argument",
                        },
                        {
                            "type": "effect_type",
                            "id": "sample_effect",
                            "name": ["sample effect"],
                            "desc": ["Applied by migrated native Lua."],
                            "reduced_desc": ["A reduced sample effect."],
                            "max_intensity": 1,
                            "show_in_info": True,
                        },
                        {
                            "type": "item_group",
                            "id": "sample_item_group",
                            "subtype": "distribution",
                            "items": [["sample_item", 100]],
                        },
                        {
                            "type": "sub_body_part",
                            "id": "sample_surface",
                            "name": "sample surface",
                            "parent": "sample_body",
                            "locations_under": ["sample_surface"],
                            "unarmed_damage": [{"damage_type": "bash", "amount": 1}],
                        },
                        {
                            "type": "body_part",
                            "id": "sample_body",
                            "name": "sample body",
                            "main_part": "sample_body",
                            "connected_to": "sample_body",
                            "opposite_part": "sample_body",
                            "limb_types": "torso",
                            "is_limb": True,
                            "is_vital": True,
                            "hit_size": 10,
                            "hit_difficulty": 1,
                            "side": "both",
                            "base_hp": 20,
                            "drench_capacity": 10,
                            "sub_parts": ["sample_surface"],
                            "armor": {"bash": 1},
                        },
                        {
                            "type": "anatomy",
                            "id": "sample_anatomy",
                            "parts": ["sample_body"],
                        },
                        {
                            "type": "body_graph",
                            "id": "sample_body_graph",
                            "parent_bodypart": "sample_body",
                            "rows": ["B"],
                            "parts": {
                                "B": {
                                    "body_parts": ["sample_body"],
                                    "sub_body_parts": ["sample_surface"],
                                    "select_color": "light_blue",
                                    "sym": "B",
                                }
                            },
                        },
                        {
                            "type": "field_type",
                            "id": "fd_sample_lua",
                            "phase": "gas",
                            "intensity_levels": [
                                {
                                    "name": "sample mist",
                                    "sym": "%",
                                    "color": "light_blue",
                                    "effects": [
                                        {
                                            "effect_id": "sample_effect",
                                            "min_duration": "1 s",
                                            "max_duration": "2 s",
                                            "intensity": 1,
                                            "body_part": "sample_body",
                                        }
                                    ],
                                }
                            ],
                            "immune_mtypes": ["mon_sample_lua"],
                        },
                        {
                            "type": "monster_attack",
                            "id": "sample_lua_attack",
                            "cooldown": 5,
                        },
                        {
                            "type": "weakpoint_set",
                            "id": "sample_weakpoints",
                            "weakpoints": [
                                {
                                    "id": "core",
                                    "name": "sample core",
                                    "coverage": 100,
                                    "armor_mult": {"bash": 0.5},
                                    "effects": [
                                        {
                                            "effect": "sample_effect",
                                            "duration": [1, 2],
                                            "intensity": [1, 1],
                                        }
                                    ],
                                }
                            ],
                        },
                        {
                            "type": "MONSTER",
                            "id": "mon_sample_lua",
                            "name": {"str": "sample creature", "str_pl": "sample creatures"},
                            "description": "Migrated to native Lua content.",
                            "symbol": "S",
                            "color": "light_blue",
                            "default_faction": "sample_monster_faction",
                            "material": [["flesh", 1]],
                            "species": ["SAMPLE_SPECIES"],
                            "death_drops": "sample_item_group",
                            "hp": 20,
                            "speed": 80,
                            "armor": {"bash": 2},
                            "melee_damage": [
                                {"damage_type": "bash", "amount": 3, "armor_penetration": 1}
                            ],
                            "special_attacks": [["sample_lua_attack", 7]],
                            "weakpoint_sets": ["sample_weakpoints"],
                            "goals": ["sample_behavior"],
                        },
                        {
                            "type": "morale_type",
                            "id": "sample_morale",
                            "text": "Enjoyed native Lua",
                            "permanent": True,
                        },
                        {
                            "type": "disease_type",
                            "id": "sample_disease",
                            "min_duration": "2 m",
                            "max_duration": "5 m",
                            "min_intensity": 1,
                            "max_intensity": 2,
                            "symptoms": "sample_symptoms",
                            "affected_bodyparts": ["torso"],
                        },
                        {
                            "type": "mood_face",
                            "id": "SAMPLE_MOOD",
                            "values": [
                                {"value": 10, "face": ":)"},
                                {"value": -10, "face": ":("},
                            ],
                        },
                        {
                            "type": "monster_flag",
                            "id": "SAMPLE_MONSTER_FLAG",
                        },
                        {
                            "type": "SPECIES",
                            "id": "SAMPLE_SPECIES",
                            "description": "a sample species",
                            "footsteps": "sample steps.",
                            "bleeds": "fd_blood",
                            "flags": ["SAMPLE_MONSTER_FLAG"],
                            "anger_triggers": ["HURT"],
                            "fear_triggers": ["FIRE"],
                            "placate_triggers": ["SOUND"],
                        },
                        {
                            "type": "emit",
                            "id": "emit_sample",
                            "field": "fd_smoke",
                            "intensity": 2,
                            "qty": 7,
                            "chance": 50,
                        },
                        {
                            "type": "MONSTER_FACTION",
                            "name": "sample_monster_faction",
                            "base_faction": "",
                            "friendly": ["player"],
                            "hate": ["zombie"],
                        },
                        {
                            "type": "mutation_type",
                            "id": "sample_mutation_type",
                        },
                        {
                            "type": "connect_group",
                            "id": "SAMPLE_CONNECT_GROUP",
                        },
                        {
                            "type": "mutation_category",
                            "id": "SAMPLE_MUTATION_CATEGORY",
                            "name": "Sample mutation category",
                            "threshold_mut": "",
                            "mutagen_message": "You feel sample changes.",
                            "memorial_message": "Sampled a threshold.",
                            "threshold_min": 1500,
                            "base_removal_chance": 50,
                            "base_removal_cost_mul": 2.0,
                        },
                        {
                            "type": "construction_category",
                            "id": "SAMPLE_CONSTRUCTION_CATEGORY",
                            "name": "Sample construction category",
                        },
                        {
                            "type": "construction_group",
                            "id": "sample_construction_group",
                            "name": "Sample construction group",
                        },
                        {
                            "type": "vehicle_part_category",
                            "id": "sample_vehicle_category",
                            "name": "Sample vehicle parts",
                            "short_name": "S",
                            "priority": 15,
                        },
                        {
                            "type": "vehicle_part_location",
                            "id": "sample_vehicle_location",
                            "name": "Sample vehicle location",
                            "desc": "Defined by native Lua",
                            "z_order": 7,
                            "list_order": 3,
                        },
                        {
                            "type": "named_color",
                            "name": "Sample blue",
                            "value": "#0A14C8",
                        },
                        {
                            "type": "rotatable_symbol",
                            "tuple": ["①", "②", "③", "④"],
                        },
                        {
                            "type": "requirement",
                            "id": "sample_requirement",
                            "name": "Sample requirement",
                            "tools": [[
                                ["welder", 10],
                                ["hammer", -1],
                            ]],
                            "qualities": [[
                                ["SAMPLE_QUALITY", 1, 1],
                            ]],
                        },
                        {
                            "type": "recipe_group",
                            "id": "sample_recipe_group",
                            "building_type": "BASE",
                            "recipes": [{
                                "id": "sample_recipe",
                                "description": "Craft sample",
                                "om_terrains": ["ANY"],
                            }],
                        },
                        {
                            "type": "nested_category",
                            "id": "sample_nested_recipe",
                            "name": "Sample nested recipes",
                            "description": "Nested directly in Lua.",
                            "category": "CC_SAMPLE",
                            "subcategory": "CSC_SAMPLE_MISC",
                            "activity_level": "LIGHT_EXERCISE",
                            "nested_category_data": ["sample_recipe"],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "sample_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertIn("content.AsciiArt", main)
            self.assertIn('definition:line("native Lua")', main)
            self.assertIn("content.LimbScore", main)
            self.assertIn("affected_by_wounds = false", main)
            self.assertIn("content.HitRange", main)
            self.assertIn("content.replace(definition)", main)
            self.assertIn("content.BashDamageProfile", main)
            self.assertIn('definition:factor("sample_damage", 0.5)', main)
            self.assertIn("content.ClothingMod", main)
            self.assertIn('stat = "bash"', main)
            self.assertIn('scale = { "thickness", "coverage" }', main)
            self.assertIn("content.OvermapLandUseCode", main)
            self.assertIn("code = 321", main)
            self.assertIn("content.OvermapVision", main)
            self.assertIn("definition:appearance", main)
            self.assertIn("definition:blend_adjacent()", main)
            self.assertIn("content.OvermapLocation", main)
            self.assertIn('definition:terrain("field")', main)
            self.assertIn('definition:terrain_flag("ROAD")', main)
            self.assertIn("content.ProfessionGroup", main)
            self.assertIn('definition:profession("unemployed")', main)
            self.assertIn("content.MapExtraCollection", main)
            self.assertIn('definition:extra("mx_crater", 25)', main)
            self.assertIn("content.VehicleGroup", main)
            self.assertIn('definition:vehicle("car", 80)', main)
            self.assertIn("content.FaultGroup", main)
            self.assertIn(
                'definition:fault("fault_armor_lc_dented", 100)', main
            )
            self.assertIn("content.ExplosionLight", main)
            self.assertIn("definition:stop(255, 180, 40, 150)", main)
            self.assertIn('easing = "smoothstep"', main)
            self.assertIn("definition:screen_shake(2, 80)", main)
            self.assertIn("definition:shockwave", main)
            self.assertIn("content.AmmoEffect", main)
            self.assertIn("definition:field_burst", main)
            self.assertIn("definition:trail", main)
            self.assertIn("definition:on_hit", main)
            self.assertIn("definition:explosion", main)
            self.assertIn("definition:shrapnel", main)
            self.assertIn("content.AddictionType", main)
            self.assertIn('definition:tick_policy("TODO_sample_addiction_tick")', main)
            self.assertIn("content.CharacterModifier", main)
            self.assertIn('definition:evaluate_with("TODO_sample_character_modifier_evaluate")', main)
            self.assertIn("content.StartLocation", main)
            self.assertIn('definition:terrain("field", {', main)
            self.assertIn('definition:flag("ALLOW_OUTSIDE")', main)
            self.assertIn("content.ClimbingAid", main)
            self.assertIn("definition:available_when", main)
            self.assertIn("definition:descent", main)
            self.assertIn("definition:cost", main)
            self.assertIn("content.WeatherType", main)
            self.assertIn("temperature_delta_kelvin = -10", main)
            self.assertIn("definition:duration(120, 300)", main)
            self.assertIn("definition:animation", main)
            self.assertIn('definition:requires("cloudy")', main)
            self.assertIn("definition:passive_effect", main)
            self.assertIn(
                'definition:condition("TODO_sample_weather_condition")', main
            )
            self.assertIn("content.Score", main)
            self.assertIn('statistic = "num_moves"', main)
            self.assertIn("content.OverlayOrder()", main)
            self.assertIn(
                'definition:mutation("THRESH_SAMPLE", 500)', main
            )
            self.assertIn(
                'definition:mutation("WINGS_SAMPLE", 500)', main
            )
            self.assertIn("content.ZoneType", main)
            self.assertIn('display_field = "fd_no_auto_pickup_zone"', main)
            self.assertIn("can_be_personal = true", main)
            self.assertIn("content.SpeechPool", main)
            self.assertIn('id = "sample_speaker"', main)
            self.assertIn(
                'definition:line("Sample speech one.", 20)', main
            )
            self.assertIn(
                'definition:line("Sample speech two.", 30)', main
            )
            self.assertIn("content.EndScreen", main)
            self.assertIn(
                'definition:info(2, 3, "Sample ending for <u_name>")', main
            )
            self.assertIn(
                'definition:condition("TODO_sample_end_screen_condition")', main
            )
            self.assertIn("content.ActivityType", main)
            self.assertIn('based_on = "neither"', main)
            self.assertIn('definition:ignore("noise")', main)
            self.assertIn(
                'definition:on_turn("TODO_ACT_SAMPLE_LUA_turn")', main
            )
            self.assertIn(
                'definition:on_finish("TODO_ACT_SAMPLE_LUA_finish")', main
            )
            self.assertIn("content.HelpTopic", main)
            self.assertIn('id = "help_sample_mod_7_Lua_help"', main)
            self.assertIn(
                'definition:paragraph("Native Lua help paragraph.")', main
            )
            self.assertIn("content.SnippetCategory", main)
            self.assertIn('definition:text("Anonymous sample lore.", 1)', main)
            self.assertIn('id = "sample_lore_entry"', main)
            self.assertIn(
                'on_examine = "TODO_sample_lore_entry_examine"', main
            )
            self.assertIn("content.Playlist", main)
            self.assertIn(
                'definition:track("music/sample.ogg", 96)', main
            )
            self.assertIn("content.AttackVector", main)
            self.assertIn('definition:limb("hand_l")', main)
            self.assertIn('definition:contact("hand_palm_l")', main)
            self.assertIn('definition:requires_limb("hand", 1)', main)
            self.assertIn("content.MagicType", main)
            self.assertIn('energy = "vitamin"', main)
            self.assertIn('vitamin = "sample_vitamin"', main)
            self.assertIn('definition:cannot_cast_when("NO_SAMPLE_MAGIC")', main)
            self.assertIn("content.MovementMode", main)
            self.assertIn("exertion = 4", main)
            self.assertIn('definition:messages("none"', main)
            self.assertIn("content.ToolQuality", main)
            self.assertIn("content.SkillDisplay", main)
            self.assertIn("content.Skill", main)
            self.assertIn("content.Vitamin", main)
            self.assertIn("definition:weight_micrograms(10420)", main)
            self.assertIn("content.JsonFlag", main)
            self.assertIn("content.DamageType", main)
            self.assertIn("content.DamageInfoOrder", main)
            self.assertIn('definition:section("bionic", 12, true)', main)
            self.assertIn("content.Material", main)
            self.assertIn("content.ProficiencyCategory", main)
            self.assertIn("content.Proficiency", main)
            self.assertIn('definition:bonus("sample", "strength", 1)', main)
            self.assertIn("content.WeaponCategory", main)
            self.assertIn("content.ItemCategory", main)
            self.assertIn("content.RecipeCategory", main)
            self.assertIn("content.AmmunitionType", main)
            self.assertIn("content.ScentType", main)
            self.assertIn('definition:receptive_species("MAMMAL")', main)
            self.assertIn("content.SpeedDescription", main)
            self.assertIn('definition:value(1.1, { "It is faster." })', main)
            self.assertIn("content.HarvestDropType", main)
            self.assertIn('definition:skill("sample_skill")', main)
            self.assertIn("content.Harvest", main)
            self.assertIn('leftovers = "sample_item"', main)
            self.assertIn('output = "sample_item"', main)
            self.assertIn('category = "sample_drop"', main)
            self.assertIn("base_maximum = 4", main)
            self.assertIn("skill_maximum = 0.5", main)
            self.assertIn('definition:item_flag("sample_item", "SAMPLE_FLAG")', main)
            self.assertIn('definition:item_fault("sample_item", "fault_sample")', main)
            self.assertIn("content.Behavior", main)
            self.assertIn('goal = "sample_goal"', main)
            self.assertIn(
                'definition:when_native("npc_has_food", "sample argument", true)',
                main,
            )
            self.assertIn(
                'definition:score_native("npc_hunger_urgency", "sample score argument")',
                main,
            )
            self.assertIn("content.EffectType", main)
            self.assertIn('definition:reduced_description("A reduced sample effect.")', main)
            self.assertIn("content.ItemGroup", main)
            self.assertIn('definition:item("sample_item", 100, "")', main)
            self.assertIn("content.SubBodyPart", main)
            self.assertIn('definition:location_under("sample_surface")', main)
            self.assertIn("content.BodyPart", main)
            self.assertIn('definition:limb_type("torso", 1)', main)
            self.assertIn("content.Anatomy", main)
            self.assertIn('definition:part("sample_body")', main)
            self.assertIn("content.BodyGraph", main)
            self.assertIn('definition:row("B")', main)
            self.assertIn("content.FieldType", main)
            self.assertIn('definition:effect(1, {', main)
            self.assertIn("content.MonsterAttack", main)
            self.assertIn(
                'definition:policy("migrated.monster_attack.sample_lua_attack")', main
            )
            self.assertIn("content.WeakpointSet", main)
            self.assertIn('definition:armor_multiplier("core", "bash", 0.5)', main)
            self.assertIn("content.Monster", main)
            self.assertIn('definition:attack("sample_lua_attack", 7)', main)
            self.assertIn('definition:weakpoint_set("sample_weakpoints")', main)
            self.assertIn("content.MoraleType", main)
            self.assertIn("content.DiseaseType", main)
            self.assertIn("minimum_duration_turns = 120", main)
            self.assertIn('definition:affected_body_part("torso")', main)
            self.assertIn("content.MoodFace", main)
            self.assertIn('definition:value(10, ":)")', main)
            self.assertIn("content.MonsterFlag", main)
            self.assertIn("content.Species", main)
            self.assertIn('definition:flag("SAMPLE_MONSTER_FLAG")', main)
            self.assertIn('definition:anger("HURT")', main)
            self.assertIn("content.Emission", main)
            self.assertIn('field = "fd_smoke"', main)
            self.assertIn("quantity = 7", main)
            self.assertIn("content.MonsterFaction", main)
            self.assertIn(
                'definition:attitude("friendly", "player")', main
            )
            self.assertIn("content.MutationType", main)
            self.assertIn("content.ConnectGroup", main)
            self.assertIn("content.MutationCategory", main)
            self.assertIn("threshold_minimum = 1500", main)
            self.assertIn("content.ConstructionCategory", main)
            self.assertIn("content.ConstructionGroup", main)
            self.assertIn("content.VehiclePartCategory", main)
            self.assertIn("content.VehiclePartLocation", main)
            self.assertIn("z_order = 7", main)
            self.assertIn("content.NamedColor", main)
            self.assertIn("blue = 200", main)
            self.assertIn("content.RotatableSymbol", main)
            self.assertIn("content.Requirement", main)
            self.assertIn("definition:tool_any", main)
            self.assertIn('definition:quality("SAMPLE_QUALITY", 1, 1)', main)
            self.assertIn("content.RecipeGroup", main)
            self.assertIn(
                'definition:terrain("sample_recipe", "ANY", "TYPE")', main
            )
            self.assertIn("content.NestedRecipeCategory", main)
            self.assertIn('definition:recipe("sample_recipe")', main)
            self.assertIn("activity_level = 2", main)
            self.assertLess(main.index("content.SkillDisplay"), main.index("content.Skill {"))
            self.assertLess(main.index("content.DamageType"), main.index("content.Material"))
            self.assertLess(
                main.index("content.ProficiencyCategory"),
                main.index("content.Proficiency {"),
            )
            self.assertLess(
                main.index("content.Proficiency {"), main.index("content.WeaponCategory")
            )
            self.assertLess(main.index("content.EffectType"), main.index("content.FieldType"))
            self.assertLess(main.index("content.SubBodyPart"), main.index("content.BodyPart"))
            self.assertLess(main.index("content.MonsterAttack"), main.index("content.Monster {"))
            self.assertNotIn("load_json", main)
            self.assertNotIn("run_eoc", main)
            self.assertEqual(len(result.converted), 73)
            self.assertTrue(
                any("weather type sample_weather" in item for item in result.partial)
            )
            self.assertTrue(
                any("legacy condition tree/jmath" in item for item in result.todos)
            )
            self.assertTrue(
                any("debug_cause_eoc" in item for item in result.todos)
            )
            self.assertTrue(
                any(
                    "end screen sample_end_screen" in item
                    for item in result.partial
                )
            )
            self.assertTrue(
                any(
                    "snippet category <sample_lore>" in item
                    for item in result.partial
                )
            )
            self.assertTrue(
                any("effect_on_examine" in item for item in result.todos)
            )
            self.assertTrue(
                any("sample_addiction" in todo and "named Lua handler" in todo for todo in result.todos)
            )
            self.assertTrue(
                any("sample_character_modifier" in todo and "named Lua evaluator" in todo for todo in result.todos)
            )
            self.assertTrue(
                any(
                    "monster attack sample_lua_attack" in todo and
                    "named Lua handler" in todo
                    for todo in result.todos
                )
            )

    def test_creature_catalog_fallbacks_remain_native_and_applicable(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "creature_edges.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "body_part",
                            "id": "safe_body",
                            "name": "safe body",
                            "main_part": {"invalid": True},
                            "limb_types": "torso",
                        },
                        {
                            "type": "body_graph",
                            "id": "mirrored_graph",
                            "mirror": "base_graph",
                            "rows": ["X"],
                            "parts": {"X": {"select_color": "red"}},
                        },
                        {
                            "type": "field_type",
                            "id": "fd_compacted",
                            "intensity_levels": [
                                "invalid",
                                {
                                    "name": "usable",
                                    "effects": [{"effect_id": "usable_effect"}],
                                },
                            ],
                        },
                        {
                            "type": "field_type",
                            "id": "fd_placeholder",
                            "intensity_levels": ["invalid"],
                        },
                        {
                            "type": "weakpoint_set",
                            "id": "placeholder_weakpoints",
                            "weakpoints": ["invalid"],
                        },
                    ]
                ),
                encoding="utf-8",
            )

            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "sample_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertIn('main_part = "safe_body"', main)
            self.assertIn('connected_to = "safe_body"', main)
            self.assertIn('mirror = "base_graph"', main)
            self.assertNotIn('definition:row("X")', main)
            self.assertNotIn('definition:part("X", {', main)
            self.assertIn('definition:effect(1, {', main)
            self.assertNotIn('definition:effect(2, {', main)
            self.assertIn('name = "TODO fd_placeholder"', main)
            self.assertIn('id = "TODO_weakpoint"', main)
            self.assertIn("rows were omitted", report)
            self.assertIn("has no usable body", report)
            self.assertIn("safe placeholder", report)

    def test_magic_type_formulas_and_failure_eocs_become_lua_policy_todos(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "magic.json"
            source.write_text(
                json.dumps(
                    [{
                        "type": "magic_type",
                        "id": "policy_magic",
                        "energy_source": "MANA",
                        "get_level_formula_id": "legacy_level",
                        "exp_for_level_formula_id": "legacy_experience",
                        "failure_chance_formula_id": "legacy_failure",
                        "failure_eocs": ["LEGACY_FAILURE_EOC"],
                    }]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "sample_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertIn("content.MagicType", main)
            self.assertIn("definition:progression handler", main)
            self.assertIn("definition:on_failure(handler_id)", main)
            self.assertIn("must be rewritten", report)
            self.assertEqual(result.converted, [])
            self.assertEqual(len(result.partial), 1)
            self.assertNotIn("run_eoc", main)
            self.assertNotIn("load_json", main)

    def test_converts_bounded_wound_and_wound_fix_definitions(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "wound",
                            "id": "lua_laceration",
                            "name": {
                                "str": "laceration",
                                "str_pl": "lacerations",
                            },
                            "description": "A deep open cut.",
                            "pain": [1, 3],
                            "healing_time": ["1 hour", "2 hours"],
                            "damage_types": ["cut", "stab"],
                            "damage_required": [5, 30],
                            "weight": 2,
                            "limb_scores": [
                                {"score": "manip", "value": 0.25}
                            ],
                            "limit": 2,
                            "wound_progression": [
                                {"id": "lua_deep_laceration", "chance": 20}
                            ],
                            "whitelist_bp_with_flag": "LIMB",
                            "whitelist_body_part_types": ["arm", "hand"],
                            "blacklist_bp_with_flag": "BIONIC_LIMB",
                            "blacklist_body_part_types": ["head"],
                        },
                        {
                            "type": "wound_fix",
                            "id": "lua_suture",
                            "name": "suture wound",
                            "description": "Close a laceration.",
                            "success_msg": "You close the wound.",
                            "mod_hp": 3,
                            "time": "5 minutes",
                            "skills": {"firstaid": 2},
                            "wounds_removed": ["lua_laceration"],
                            "wounds_added": ["lua_sutured"],
                            "proficiencies": [
                                {
                                    "proficiency": "prof_wound_care",
                                    "time_save": 0.75,
                                    "is_mandatory": True,
                                }
                            ],
                            "requirements": [["wound_care", 2]],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "wound_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn("content.Wound {", main)
            self.assertIn('plural_name = "lacerations"', main)
            self.assertIn("healing_min_turns = 3600", main)
            self.assertIn('definition:damage_type("cut")', main)
            self.assertIn('definition:limb_score("manip", 0.25)', main)
            self.assertIn(
                'definition:progression("lua_deep_laceration", 20)', main
            )
            self.assertIn('definition:require_body_part_type("arm")', main)
            self.assertIn("content.WoundFix {", main)
            self.assertIn("duration_turns = 300", main)
            self.assertIn('definition:skill("firstaid", 2)', main)
            self.assertIn(
                'definition:proficiency("prof_wound_care", 0.75, true)',
                main,
            )
            self.assertIn('definition:removes("lua_laceration")', main)
            self.assertIn('definition:requires("wound_care", 2)', main)
            self.assertNotIn("load_json", main)
            self.assertNotIn("run_eoc", main)

    def test_wound_and_fix_accept_exact_platform_utf8_byte_caps(self) -> None:
        bounded_id = "界" * 85 + "a"
        bounded_name = "界" * 341 + "a"
        bounded_description = "界" * 10922 + "ab"
        self.assertEqual(len(bounded_id.encode("utf-8")), 256)
        self.assertEqual(len(bounded_name.encode("utf-8")), 1024)
        self.assertEqual(len(bounded_description.encode("utf-8")), 32768)

        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "wound",
                            "id": bounded_id,
                            "name": bounded_name,
                            "description": bounded_description,
                            "healing_time": [1, 1],
                            "damage_types": ["d" * 256],
                            "damage_required": [0, 1],
                            "limb_scores": [
                                {"score": "l" * 256, "value": 0.5}
                            ],
                            "wound_progression": [
                                {"id": "p" * 256, "chance": 1}
                            ],
                            "whitelist_bp_with_flag": "r" * 256,
                            "blacklist_bp_with_flag": "f" * 256,
                        },
                        {
                            "type": "wound_fix",
                            "id": "x" * 256,
                            "name": bounded_name,
                            "description": bounded_description,
                            "success_msg": bounded_description,
                            "skills": {"s" * 256: 1},
                            "wounds_removed": [bounded_id],
                            "wounds_added": ["a" * 256],
                            "proficiencies": [
                                {
                                    "proficiency": "q" * 256,
                                    "time_save": 2 ** -149,
                                }
                            ],
                            "requirements": [["e" * 256, 1]],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "wound_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn(
                f'definition:damage_type("{"d" * 256}")', main
            )
            self.assertIn(
                f'definition:proficiency("{"q" * 256}", '
                f'{migrate_lua_first.lua_number(2 ** -149)}, false)',
                main,
            )

    def test_wound_and_fix_reject_overlong_required_fields(self) -> None:
        valid_wound = {
            "type": "wound",
            "id": "valid_wound",
            "name": "wound",
            "description": "description",
            "damage_types": ["bash"],
            "damage_required": [0, 1],
        }
        wound_cases = {
            "id": {"id": "i" * 257},
            "multibyte id": {"id": "界" * 86},
            "name": {"name": "n" * 1025},
            "description": {"description": "d" * 32769},
            "damage type": {"damage_types": ["t" * 257]},
            "unencodable id": {"id": "\ud800"},
        }
        for label, replacement in wound_cases.items():
            with self.subTest(kind="wound", field=label):
                result = migrate_lua_first.MigrationResult()
                rendered = migrate_lua_first.render_wound(
                    migrate_lua_first.SourceObject(
                        Path("source.json"), 0, valid_wound | replacement
                    ),
                    result,
                )
                self.assertIsNone(rendered)
                self.assertEqual(len(result.partial), 1)
                self.assertEqual(len(result.todos), 1)

        valid_fix = {
            "type": "wound_fix",
            "id": "valid_fix",
            "name": "fix",
            "description": "description",
            "wounds_removed": ["valid_wound"],
        }
        fix_cases = {
            "id": {"id": "i" * 257},
            "name": {"name": "n" * 1025},
            "description": {"description": "d" * 32769},
            "removed wound": {"wounds_removed": ["w" * 257]},
            "unencodable text": {"name": "\ud800"},
        }
        for label, replacement in fix_cases.items():
            with self.subTest(kind="wound fix", field=label):
                result = migrate_lua_first.MigrationResult()
                rendered = migrate_lua_first.render_wound_fix(
                    migrate_lua_first.SourceObject(
                        Path("source.json"), 0, valid_fix | replacement
                    ),
                    result,
                )
                self.assertIsNone(rendered)
                self.assertEqual(len(result.partial), 1)
                self.assertEqual(len(result.todos), 1)

    def test_wound_optional_values_fail_closed_to_valid_lua(self) -> None:
        overlong_id = "z" * 257
        wound_result = migrate_lua_first.MigrationResult()
        wound = migrate_lua_first.render_wound(
            migrate_lua_first.SourceObject(
                Path("source.json"),
                0,
                {
                    "type": "wound",
                    "id": "bounded_wound",
                    "name": {"str": "wound", "str_pl": "n" * 1025},
                    "description": "description",
                    "damage_types": ["bash"],
                    "damage_required": [0, 1],
                    "limb_scores": [
                        {"score": overlong_id, "value": 0.5},
                        {"score": "huge_penalty", "value": 10 ** 10000},
                    ],
                    "wound_progression": [
                        {"id": overlong_id, "chance": 1}
                    ],
                    "whitelist_bp_with_flag": "SAME_FLAG",
                    "blacklist_bp_with_flag": "SAME_FLAG",
                },
            ),
            wound_result,
        )
        self.assertIsNotNone(wound)
        assert wound is not None
        self.assertIn('plural_name = "wound"', wound)
        self.assertNotIn("required_body_part_flag", wound)
        self.assertNotIn("forbidden_body_part_flag", wound)
        self.assertNotIn(overlong_id, wound)
        self.assertEqual(wound_result.converted, [])
        self.assertEqual(len(wound_result.partial), 1)
        self.assertTrue(
            any("cannot require and forbid" in todo for todo in wound_result.todos)
        )

        fix_result = migrate_lua_first.MigrationResult()
        wound_fix = migrate_lua_first.render_wound_fix(
            migrate_lua_first.SourceObject(
                Path("source.json"),
                1,
                {
                    "type": "wound_fix",
                    "id": "bounded_fix",
                    "name": "fix",
                    "description": "description",
                    "success_msg": "m" * 32769,
                    "skills": {overlong_id: 1},
                    "wounds_removed": ["bounded_wound"],
                    "wounds_added": [overlong_id],
                    "proficiencies": [
                        {"proficiency": overlong_id, "time_save": 1},
                        {"proficiency": "underflow", "time_save": 2 ** -150},
                        {
                            "proficiency": "overflow",
                            "time_save": migrate_lua_first.NATIVE_FLOAT_MAX * 2,
                        },
                        {"proficiency": "huge", "time_save": 10 ** 10000},
                        {"proficiency": "small_ok", "time_save": 2 ** -149},
                    ],
                    "requirements": [[overlong_id, 1]],
                },
            ),
            fix_result,
        )
        self.assertIsNotNone(wound_fix)
        assert wound_fix is not None
        self.assertIn('success_message = ""', wound_fix)
        self.assertNotIn(overlong_id, wound_fix)
        self.assertNotIn('definition:proficiency("underflow"', wound_fix)
        self.assertNotIn('definition:proficiency("overflow"', wound_fix)
        self.assertNotIn('definition:proficiency("huge"', wound_fix)
        self.assertIn('definition:proficiency("small_ok"', wound_fix)
        self.assertEqual(fix_result.converted, [])
        self.assertEqual(len(fix_result.partial), 1)

        self.assertEqual(
            migrate_lua_first.lua_quote("a\x01\b\f\v\x7f"),
            '"a\\001\\b\\f\\v\\127"',
        )

    def test_wound_inheritance_and_inline_requirements_stay_explicit(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "wound",
                            "id": "inherited_wound",
                            "copy-from": "base_wound",
                        },
                        {
                            "type": "wound_fix",
                            "id": "inline_fix",
                            "name": "patch wound",
                            "description": "Patch a wound.",
                            "wounds_removed": ["lua_laceration"],
                            "requirements": [
                                {"components": [["rag", 1]]}
                            ],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "wound_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(result.converted, [])
            self.assertEqual(len(result.partial), 2)
            self.assertIn("wound needs a stable id, text", report)
            self.assertIn("needs a standalone Requirement", report)
            self.assertIn("content.WoundFix {", main)
            self.assertNotIn("content.Wound {", main)
            self.assertNotIn("load_json", main)
            self.assertNotIn("run_eoc", main)

    def test_check_mode_is_non_mutating_and_detects_stale_output(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            result = migrate_lua_first.MigrationResult(
                files={Path("main.lua"): "return true\n"}
            )
            self.assertFalse(
                migrate_lua_first.write_result(result, root, force=False, check=True)
            )
            self.assertFalse((root / "main.lua").exists())
            self.assertTrue(
                migrate_lua_first.write_result(result, root, force=False, check=False)
            )
            self.assertTrue(
                migrate_lua_first.write_result(result, root, force=False, check=True)
            )

    def test_refusal_to_overwrite_is_preflighted_before_any_write(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            (root / "z-existing.lua").write_text("author data\n", encoding="utf-8")
            result = migrate_lua_first.MigrationResult(
                files={
                    Path("a-new.lua"): "new\n",
                    Path("z-existing.lua"): "replacement\n",
                }
            )
            with self.assertRaisesRegex(ValueError, "refusing to overwrite"):
                migrate_lua_first.write_result(
                    result, root, force=False, check=False
                )
            self.assertFalse((root / "a-new.lua").exists())
            self.assertEqual(
                (root / "z-existing.lua").read_text(encoding="utf-8"),
                "author data\n",
            )

    def test_output_file_is_rejected_before_writing(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            output = Path(temporary) / "owned"
            output.write_text("author data\n", encoding="utf-8")
            result = migrate_lua_first.MigrationResult(
                files={Path("main.lua"): "return true\n"}
            )
            with self.assertRaisesRegex(ValueError, "not a directory"):
                migrate_lua_first.write_result(
                    result, output, force=True, check=False
                )
            self.assertEqual(
                output.read_text(encoding="utf-8"), "author data\n"
            )

    def test_force_install_rolls_back_every_file_after_failure(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            output = Path(temporary) / "migration"
            output.mkdir()
            (output / "a.lua").write_text("old a\n", encoding="utf-8")
            (output / "b.lua").write_text("old b\n", encoding="utf-8")
            result = migrate_lua_first.MigrationResult(
                files={
                    Path("a.lua"): "new a\n",
                    Path("b.lua"): "new b\n",
                }
            )
            real_install = migrate_lua_first._install_staged_file
            calls = 0

            def fail_second(source: Path, destination: Path) -> None:
                nonlocal calls
                calls += 1
                if calls == 2:
                    raise OSError("install failed")
                real_install(source, destination)

            with patch(
                "migrate_lua_first._install_staged_file",
                side_effect=fail_second,
            ):
                with self.assertRaisesRegex(OSError, "install failed"):
                    migrate_lua_first.write_result(
                        result, output, force=True, check=False
                    )
            self.assertEqual(
                (output / "a.lua").read_text(encoding="utf-8"), "old a\n"
            )
            self.assertEqual(
                (output / "b.lua").read_text(encoding="utf-8"), "old b\n"
            )

    def test_translates_techniques_with_bounded_todos(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "technique",
                            "id": "tec_sample_disarm",
                            "name": "Sample Disarm",
                            "messages": ["You disarm %s", "<npcname> disarms %s"],
                            "skill_requirements": [
                                {"name": "unarmed", "level": 1}
                            ],
                            "unarmed_allowed": True,
                            "weighting": 2,
                            "disarms": True,
                            "stun_dur": 1,
                            "attack_vectors": ["vector_grasp"],
                        },
                        {
                            "type": "technique",
                            "id": "tec_sample_complex",
                            "name": "Complex",
                            "tech_effects": [{"id": "disarmed"}],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "tech_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 1)
            self.assertIn('id = "tec_sample_disarm"', main)
            self.assertIn('name = "Sample Disarm"', main)
            self.assertIn('disarms = true', main)
            self.assertIn("stun_dur = 1", main)
            self.assertIn("definition:attack_vector(\"vector_grasp\")", main)
            self.assertIn('definition:requires_skill("unarmed", 1)', main)
            self.assertIn("unarmed_allowed = true", main)
            self.assertIn(
                "technique tec_sample_complex tech_effects needs review",
                report,
            )
            self.assertNotIn("run_eoc", main)

    def test_translates_martial_arts_with_bounded_todos(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "martial_art",
                            "id": "style_sample_kicks",
                            "name": {"str": "Sample Kicks"},
                            "description": "A sample kicking style.",
                            "initiate": ["You kick.", "%s kicks."],
                            "primary_skill": "unarmed",
                            "teachable": True,
                            "arm_block": 1,
                            "leg_block": 99,
                            "force_unarmed": True,
                            "prevent_weapon_blocking": True,
                            "autolearn": [["unarmed", 2]],
                            "techniques": ["tec_none"],
                            "weapons": ["knife_combat"],
                        },
                        {
                            "type": "martial_art",
                            "id": "style_sample_complex",
                            "name": "Complex Style",
                            "static_buffs": [{"id": "buff_sample"}],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "style_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 1)
            self.assertIn('id = "style_sample_kicks"', main)
            self.assertIn('name = "Sample Kicks"', main)
            self.assertIn("force_unarmed = true", main)
            self.assertIn("leg_block = 99", main)
            self.assertIn('definition:autolearn("unarmed", 2)', main)
            self.assertIn('definition:technique("tec_none")', main)
            self.assertIn('definition:weapon("knife_combat")', main)
            self.assertIn(
                "martial art style_sample_complex static_buffs needs review",
                report,
            )
            self.assertNotIn("run_eoc", main)

    def test_translates_traps_with_bounded_todos(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "trap",
                            "id": "tr_sample_spikes",
                            "name": "Sample Spikes",
                            "color": "red",
                            "symbol": "^",
                            "visibility": 10,
                            "avoidance": 8,
                            "difficulty": 3,
                            "action": "spike",
                            "flags": ["TRAP"],
                            "drops": [
                                {"item": "spike", "quantity": 2, "charges": 1}
                            ],
                        },
                        {
                            "type": "trap",
                            "id": "tr_sample_complex",
                            "name": "Complex Trap",
                            "action": "spell",
                            "spell_data": {"id": "fake_spell"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "trap_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 1)
            self.assertIn('id = "tr_sample_spikes"', main)
            self.assertIn('action = "spike"', main)
            self.assertIn("visibility = 10", main)
            self.assertIn('definition:flag("TRAP")', main)
            self.assertIn('definition:drop("spike", 2, 1)', main)
            self.assertIn("trap tr_sample_complex spell_data needs review", report)
            self.assertNotIn("run_eoc", main)

    def test_translates_constructions_with_bounded_todos(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "construction",
                            "id": "con_sample_dig",
                            "group": "dig_channel",
                            "category": "DIG",
                            "required_skills": {"fabrication": 1},
                            "time": "30 m",
                            "pre_terrain": "t_pit",
                            "post_terrain": "t_pit_shallow",
                        },
                        {
                            "type": "construction",
                            "id": "con_sample_complex",
                            "group": "build_wall",
                            "category": "CONSTRUCT",
                            "byproducts": [{"item": "scrap", "count": [1, 2]}],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "con_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 1)
            self.assertIn('id = "con_sample_dig"', main)
            self.assertIn('group = "dig_channel"', main)
            self.assertIn('definition:requires_skill("fabrication", 1)', main)
            self.assertIn('definition:pre_terrain("t_pit")', main)
            self.assertIn('post_terrain = "t_pit_shallow"', main)
            self.assertIn(
                "construction con_sample_complex byproducts needs review",
                report,
            )
            self.assertNotIn("run_eoc", main)

    def test_translates_furniture_with_bounded_todos(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "furniture",
                            "id": "f_sample_bed",
                            "name": "Sample Bed",
                            "description": "A sample bed.",
                            "color": "blue",
                            "symbol": "#",
                            "move_cost_mod": 2,
                            "required_str": 5,
                            "comfort": 4,
                            "flags": ["FLAMMABLE_ASH"],
                        },
                        {
                            "type": "furniture",
                            "id": "f_sample_complex",
                            "name": "Complex",
                            "bash": {"str_min": 2},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "furn_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 1)
            self.assertIn('id = "f_sample_bed"', main)
            self.assertIn('name = "Sample Bed"', main)
            self.assertIn("move_cost_mod = 2", main)
            self.assertIn("comfort = 4", main)
            self.assertIn('definition:flag("FLAMMABLE_ASH")', main)
            self.assertIn("furniture f_sample_complex bash needs review", report)
            self.assertNotIn("run_eoc", main)

    def test_translates_terrain_with_bounded_todos(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "terrain",
                            "id": "t_sample_path",
                            "name": "Sample Path",
                            "description": "A sample path.",
                            "color": "brown",
                            "symbol": ".",
                            "move_cost": 2,
                            "flags": ["TRANSPARENT", "FLAT"],
                        },
                        {
                            "type": "terrain",
                            "id": "t_sample_complex",
                            "name": "Complex",
                            "bash": {"str_min": 2},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "terr_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 1)
            self.assertIn('id = "t_sample_path"', main)
            self.assertIn('name = "Sample Path"', main)
            self.assertIn("move_cost = 2", main)
            self.assertIn('definition:flag("FLAT")', main)
            self.assertIn("terrain t_sample_complex bash needs review", report)
            self.assertNotIn("run_eoc", main)

    def test_translates_gates_with_bounded_todos(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "gate",
                            "id": "t_gate_sample",
                            "door": "t_door_o",
                            "floor": "t_floor",
                            "walls": ["t_wall"],
                            "messages": {
                                "pull": "You pull the gate.",
                                "open": "The gate opens.",
                                "close": "The gate closes.",
                                "fail": "The gate jams.",
                            },
                            "moves": 200,
                            "bashing_damage": 10,
                        },
                        {
                            "type": "gate",
                            "id": "t_gate_broken",
                            "door": "t_door_o",
                            "floor": "t_floor",
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "gate_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 1)
            self.assertIn('id = "t_gate_sample"', main)
            self.assertIn('door = "t_door_o"', main)
            self.assertIn("moves = 200", main)
            self.assertIn("bashing_damage = 10", main)
            self.assertIn('pull_message = "You pull the gate."', main)
            self.assertIn('definition:wall("t_wall")', main)
            self.assertIn("gate t_gate_broken walls need review", report)
            self.assertNotIn("run_eoc", main)

    def test_translates_faults_and_fixes_with_bounded_todos(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "fault",
                            "id": "fault_sample",
                            "fault_type": "generic",
                            "name": "Sample Fault",
                            "description": "A sample fault.",
                            "price_modifier": 0.5,
                            "instant_damage": 2,
                            "flags": ["SILENT"],
                            "fixes": ["mend_sample"],
                        },
                        {
                            "type": "fault_fix",
                            "id": "mend_sample",
                            "name": "Mend Sample",
                            "success_msg": "You mend it.",
                            "time": "10 s",
                            "skills": {"mechanics": 1},
                            "faults_removed": ["fault_sample"],
                        },
                        {
                            "type": "fault_fix",
                            "id": "mend_complex",
                            "name": "Complex Fix",
                            "requirements": {
                                "qualities": [["WRENCH", 1]],
                            },
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "fault_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(len(result.partial), 1)
            self.assertIn('id = "fault_sample"', main)
            self.assertIn('fault_type = "generic"', main)
            self.assertIn("instant_damage = 2", main)
            self.assertIn('definition:fix("mend_sample")', main)
            self.assertIn('id = "mend_sample"', main)
            self.assertIn("time_seconds = 10", main)
            self.assertIn('definition:requires_skill("mechanics", 1)', main)
            self.assertIn(
                "fault fix mend_complex requirements needs review", report
            )
            self.assertNotIn("run_eoc", main)

    def test_translates_dreams_without_json(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "dream",
                        "category": "PLANT",
                        "strength": 2,
                        "messages": ["You dream of sample.", "It fades."],
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "dream_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertIn('category = "PLANT"', main)
            self.assertIn("strength = 2", main)
            self.assertIn('definition:message("You dream of sample.")', main)
            self.assertNotIn("run_eoc", main)

    def test_translates_achievements_and_conducts_with_bounded_todos(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "achievement",
                            "id": "achievement_sample",
                            "name": "Sample Achievement",
                            "description": "A sample achievement.",
                            "hidden_by": ["achievement_other"],
                        },
                        {
                            "type": "conduct",
                            "id": "conduct_sample",
                            "name": "Sample Conduct",
                            "description": "A sample conduct.",
                        },
                        {
                            "type": "achievement",
                            "id": "achievement_complex",
                            "name": "Complex",
                            "requirements": [{"event_statistic": "stat"}],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "achievement_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(len(result.partial), 1)
            self.assertIn("content.Achievement {", main)
            self.assertIn("content.Conduct {", main)
            self.assertIn('id = "conduct_sample"', main)
            self.assertIn('definition:hidden_by("achievement_other")', main)
            self.assertIn(
                "achievement achievement_complex requirements needs review",
                report,
            )
            self.assertNotIn("run_eoc", main)

    def test_translates_trait_and_monster_blacklists(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "TRAIT_BLACKLIST",
                            "traits": ["TOUGH", "NIGHTVISION"],
                        },
                        {
                            "type": "MONSTER_WHITELIST",
                            "monsters": ["mon_zombie"],
                        },
                        {
                            "type": "ITEM_BLACKLIST",
                            "items": ["screwdriver"],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "blacklist_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 3)
            self.assertEqual(result.partial, [])
            self.assertIn('kind = "trait"', main)
            self.assertIn('definition:entry("TOUGH")', main)
            self.assertIn('kind = "monster"', main)
            self.assertIn("whitelist = true", main)
            self.assertIn('kind = "item"', main)
            self.assertIn('definition:entry("screwdriver")', main)
            self.assertNotIn("run_eoc", main)

    def test_translates_map_extras_with_bounded_todos(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "map_extra",
                            "id": "mx_sample",
                            "name": "Sample Map Extra",
                            "description": "A sample map extra.",
                            "generator": {"generator_id": "mx_house"},
                            "sym": "M",
                            "color": "green",
                            "flags": ["FIRE"],
                        },
                        {
                            "type": "map_extra",
                            "id": "mx_complex",
                            "name": "Complex",
                            "min_max_zlevel": [0, 2],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "mx_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 1)
            self.assertIn('id = "mx_sample"', main)
            self.assertIn('generator_id = "mx_house"', main)
            self.assertIn('definition:flag("FIRE")', main)
            self.assertIn("map extra mx_complex min_max_zlevel needs review", report)
            self.assertNotIn("run_eoc", main)

    def test_translates_weather_generators_with_bounded_todos(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "weather_generator",
                            "id": "wg_sample",
                            "base_temperature": 10.5,
                            "base_humidity": 50,
                            "base_pressure": 101325,
                            "base_wind": 4,
                            "weather_black_list": ["acid_rain"],
                        },
                        {
                            "type": "weather_generator",
                            "id": "wg_complex",
                            "weather_types": [{"id": "clear"}],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "wg_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 1)
            self.assertIn('id = "wg_sample"', main)
            self.assertIn("base_temperature = 10.5", main)
            self.assertIn('definition:blacklisted_weather("acid_rain")', main)
            self.assertIn(
                "weather generator wg_complex weather_types needs review", report
            )
            self.assertNotIn("run_eoc", main)

    def test_translates_migration_types_without_json(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "trap_migration",
                            "from_trap": "tr_ledge",
                            "to_trap": "tr_null",
                        },
                        {
                            "type": "oter_id_migration",
                            "oter_ids": {"old_house": "house", "old_road": "road"},
                        },
                        {
                            "type": "bionic_migration",
                            "from": "bn_bio_solar",
                            "to": "bio_microgen",
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "migration_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 3)
            self.assertEqual(result.partial, [])
            self.assertIn('kind = "trap"', main)
            self.assertIn('from = "tr_ledge"', main)
            self.assertIn('to = "tr_null"', main)
            self.assertIn('kind = "oter"', main)
            self.assertIn('from = "old_house"', main)
            self.assertIn('to = "house"', main)
            self.assertIn('kind = "bionic"', main)
            self.assertNotIn("run_eoc", main)

    def test_translates_sound_effects_and_preloads_without_json(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "sound_effect",
                            "id": "ambient_wind",
                            "variant": ["breeze", "gust"],
                            "season": "autumn",
                            "is_indoors": False,
                            "volume": 64,
                            "files": ["env/wind_a.ogg", "env/wind_b.ogg"],
                        },
                        {
                            "type": "sound_effect_preload",
                            "preload": [
                                {
                                    "id": "ambient_wind",
                                    "variant": "breeze",
                                    "season": "autumn",
                                },
                                {
                                    "id": "ambient_rain",
                                    "variant": "default",
                                    "is_night": True,
                                },
                            ],
                        },
                    ]
                ),
                encoding="utf-8",
            )

            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "sound_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(result.partial, [])
            self.assertEqual(main.count("content.SoundEffect {"), 2)
            self.assertIn('variant = "breeze"', main)
            self.assertIn('variant = "gust"', main)
            self.assertIn('season = "autumn"', main)
            self.assertIn("is_indoors = false", main)
            self.assertIn("volume = 64", main)
            self.assertIn('definition:file("env/wind_a.ogg")', main)
            self.assertEqual(main.count("content.SoundEffectPreload {"), 2)
            self.assertIn('id = "ambient_rain"', main)
            self.assertIn("is_night = true", main)
            self.assertTrue(
                any("sound effect ambient_wind" in entry
                    for entry in result.converted)
            )
            self.assertNotIn("needs review", report)

    def test_invalid_sound_effect_shapes_stay_partial(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "sound_effect",
                            "id": "broken_volume",
                            "volume": "loud",
                            "files": ["env/a.ogg"],
                        },
                        {
                            "type": "sound_effect_preload",
                            "preload": "not_a_list",
                        },
                    ]
                ),
                encoding="utf-8",
            )

            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "sound_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.partial), 2)
            self.assertIn("volume needs review", report)
            self.assertIn("preload list needs review", report)

    def test_renders_mutation_category_with_explicit_empty_mutagen_message(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "mutation_category",
                            "id": "MYCUS",
                            "name": "Mycus",
                            "threshold_mut": "THRESH_MYCUS",
                            "mutagen_message": "",
                            "memorial_message": "Dissolved into the collective.",
                            "vitamin": "null",
                            "skip_test": True,
                        },
                        {
                            "type": "mutation_category",
                            "id": "NO_MESSAGE",
                            "name": "Silent category",
                            "threshold_mut": "THRESH_SILENT",
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "category_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(len(result.partial), 0)
            self.assertIn('id = "MYCUS"', main)
            self.assertIn("mutagen_message = \"\"", main)
            self.assertIn("skip_consistency_test = true", main)
            self.assertNotIn("presentation needs review", report)

    def test_renders_legacy_null_land_use_code_verbatim(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "overmap_land_use_code",
                            "id": "",
                            "sym": "#",
                            "color": "white",
                            "detailed_definition": "",
                        },
                        {
                            "type": "overmap_land_use_code",
                            "id": "forest",
                            "land_use_code": 3,
                            "name": "Forest",
                            "detailed_definition": "Tree cover.",
                            "sym": "F",
                            "color": "green_yellow",
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "land_use_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(len(result.partial), 0)
            self.assertIn('id = ""', main)
            self.assertIn("code = 0", main)
            self.assertIn('id = "forest"', main)
            self.assertNotIn("needs a stable non-null id", report)

    def test_oter_migration_pairs_wrap_each_definition_in_do_end(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            pairs = {
                f"old_oter_{index}": f"new_oter_{index}"
                for index in range(250)
            }
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "oter_id_migration",
                            "oter_ids": pairs,
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "oter_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 0)
            self.assertEqual(main.count("content.Migration {"), 250)
            self.assertEqual(main.count("do\nlocal definition = content.Migration {"), 250)
            self.assertNotIn("needs review", report)

            # Migrations always submit through content.add: the native
            # registrar forbids edit/replace even in --replace mode.
            previous = migrate_lua_first.EMIT_REPLACE_CONTENT
            migrate_lua_first.EMIT_REPLACE_CONTENT = True
            try:
                replaced = migrate_lua_first.migrate(
                    migrate_lua_first.load_objects([source]), "oter_mod"
                )
            finally:
                migrate_lua_first.EMIT_REPLACE_CONTENT = previous
            replaced_main = replaced.files[Path("main.lua")]
            self.assertIn("content.add(definition)", replaced_main)
            self.assertNotIn("content.replace(definition)", replaced_main)

    def test_renders_empty_and_scenario_blacklists(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "MONSTER_BLACKLIST",
                            "monsters": [],
                        },
                        {
                            "type": "SCENARIO_BLACKLIST",
                            "subtype": "blacklist",
                            "scenarios": ["defense_mode_fortified"],
                        },
                        {
                            "type": "charge_removal_blacklist",
                            "list": ["hinge"],
                        },
                        {
                            "type": "temperature_removal_blacklist",
                            "list": ["napkin", "cardboard"],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "blacklist_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 4)
            self.assertEqual(len(result.partial), 0)
            self.assertIn('kind = "monster"', main)
            self.assertIn('kind = "scenario"', main)
            self.assertIn('definition:entry("defense_mode_fortified")', main)
            self.assertIn('kind = "charge_removal"', main)
            self.assertIn('definition:entry("hinge")', main)
            self.assertIn('kind = "temperature_removal"', main)
            self.assertIn('definition:entry("napkin")', main)
            self.assertNotIn("needs review", report)

            # Blacklists always submit through content.add: the native
            # registrar forbids edit/replace even in --replace mode.
            previous = migrate_lua_first.EMIT_REPLACE_CONTENT
            migrate_lua_first.EMIT_REPLACE_CONTENT = True
            try:
                replaced = migrate_lua_first.migrate(
                    migrate_lua_first.load_objects([source]), "blacklist_mod"
                )
            finally:
                migrate_lua_first.EMIT_REPLACE_CONTENT = previous
            replaced_main = replaced.files[Path("main.lua")]
            self.assertEqual(replaced_main.count("content.Blacklist {"), 4)
            self.assertNotIn("content.replace(definition)", replaced_main)

    def test_skill_level_descriptions_keep_theory_and_practice_independent(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "skill",
                            "id": "sample_skill",
                            "name": "Sample skill",
                            "description": "Practices level splitting.",
                            "display_category": "display_melee",
                            "companion_skill_practice": [
                                {"skill": "", "weight": 10},
                                {"skill": "traps", "weight": 5},
                                {"skill": "traps", "weight": 90},
                            ],
                            "level_descriptions_theory": [
                                {"level": 0, "description": "theory only"},
                                {"level": 2, "description": "both theory"},
                            ],
                            "level_descriptions_practice": [
                                {"level": 1, "description": "practice only"},
                                {"level": 2, "description": "both practice"},
                            ],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "skill_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 0)
            self.assertIn('definition:companion_practice("", 10)', main)
            self.assertIn('definition:companion_practice("traps", 5)', main)
            self.assertEqual(main.count('definition:companion_practice("traps"'), 1)
            self.assertIn(
                'definition:level_description(0, "theory only")', main
            )
            self.assertIn(
                'definition:level_description_practice(1, "practice only")', main
            )
            self.assertIn(
                'definition:level_description(2, "both theory", "both practice")', main
            )
            self.assertNotIn("needs review", report)

    def test_sub_body_part_copy_from_resolves_inheritance(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "sub_body_part",
                            "id": "beak_nares",
                            "name": "beak nares",
                            "name_multiple": "beak nares",
                            "parent": "beak",
                            "side": "both",
                            "max_coverage": 2,
                        },
                        {
                            "type": "sub_body_part",
                            "id": "beak_bird_nares",
                            "copy-from": "beak_nares",
                            "parent": "beak_bird",
                            "similar_bodypart": "beak_nares",
                        },
                        {
                            "type": "sub_body_part",
                            "id": "beak_bird_top",
                            "copy-from": "beak_top",
                        },
                        {
                            "type": "sub_body_part",
                            "id": "bionic_treads_body",
                            "name": "bionic treads shell",
                            "name_multiple": "bionic treads",
                            "parent": "bionic_treads_leg",
                            "side": 0,
                            "opposite": "bionic_treads_treads",
                            "max_coverage": 80,
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "sbp_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 3)
            self.assertEqual(len(result.partial), 1)
            # Resolved child inherits the parent presentation.
            self.assertIn('id = "beak_bird_nares"', main)
            self.assertIn('name = "beak nares"', main)
            self.assertIn('parent = "beak_bird"', main)
            self.assertIn('similar_body_part = "beak_nares"', main)
            self.assertIn("maximum_coverage = 2", main)
            # opposite is never inherited: the child defaults to its own id.
            self.assertIn('opposite = "beak_bird_nares"', main)
            # locations_under inherits the parent's effective [parent id]
            # default.
            self.assertIn('definition:location_under("beak_nares")', main)
            # Integer side 0 maps to the legacy enum value "both".
            self.assertIn('side = "both"', main)
            self.assertNotIn("copy-from", main)
            # The missing-parent child fails closed.
            self.assertIn(
                "copy-from parent 'beak_top' is not in the migration corpus",
                report,
            )

    def test_gate_copy_from_resolves_inheritance(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "gate",
                            "id": "t_gates_mech_control",
                            "door": "t_door_metal_locked",
                            "floor": "t_floor",
                            "walls": ["t_wall"],
                            "messages": {
                                "pull": "You turn the handle…",
                                "open": "The gate is opened!",
                                "close": "The gate is closed!",
                                "fail": "The gate can't be closed!",
                            },
                            "moves": 1800,
                            "bashing_damage": 40,
                        },
                        {
                            "type": "gate",
                            "id": "t_gates_control_concrete",
                            "copy-from": "t_gates_mech_control",
                            "messages": {"pull": "Concrete handle…"},
                        },
                        {
                            "type": "gate",
                            "id": "t_gates_missing_parent",
                            "copy-from": "t_gates_absent",
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "gate_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(len(result.partial), 1)
            self.assertIn('id = "t_gates_control_concrete"', main)
            self.assertIn('door = "t_door_metal_locked"', main)
            self.assertIn('pull_message = "Concrete handle…"', main)
            # Per-key message inheritance: un-overridden keys come from the
            # parent.
            self.assertIn('open_message = "The gate is opened!"', main)
            self.assertIn('definition:wall("t_wall")', main)
            self.assertIn(
                "copy-from parent 't_gates_absent' is not in the migration corpus",
                report,
            )

    def test_mood_face_copy_from_and_start_location_empty_targets(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "mood_face",
                            "id": "THRESH_FELINE_HORIZONTAL",
                            "values": [
                                {"value": 100, "face": "horizontal"},
                                {"value": -100, "face": "splat"},
                            ],
                        },
                        {
                            "type": "mood_face",
                            "id": "THRESH_URSINE_HORIZONTAL",
                            "copy-from": "THRESH_FELINE_HORIZONTAL",
                        },
                        {
                            "type": "start_location",
                            "id": "sloc_house_boarded",
                            "name": "Boarded House",
                        },
                        {
                            "type": "start_location",
                            "id": "sloc_road",
                            "name": "Road",
                            "terrain": [
                                {"om_terrain": "road", "om_terrain_match_type": "TYPE"}
                            ],
                            "city_distance": [10, -1],
                        },
                        {
                            "type": "start_location",
                            "id": "sloc_house",
                            "name": "House",
                            "terrain": ["house"],
                            "flags": ["ALLOW_OUTSIDE"],
                        },
                        {
                            "type": "start_location",
                            "id": "sloc_house_boarded",
                            "copy-from": "sloc_house",
                            "name": "House (boarded up)",
                            "extend": {"flags": ["BOARDED"]},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "batch_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 6)
            self.assertEqual(len(result.partial), 0)
            # Mood face inheritance resolves the copied values.
            self.assertIn('id = "THRESH_URSINE_HORIZONTAL"', main)
            self.assertIn('definition:value(100, "horizontal")', main)
            self.assertNotIn("copy-from", main)
            # An absent terrain member is a deliberate empty target set and
            # the sloc_road [10, -1] interval is normalized the way legacy
            # numeric_interval::deserialize clamps it (max -> INT_MAX).
            self.assertIn('definition:city_distance(10, 2147483647)', main)
            # copy-from plus extend: the child inherits the parent terrain
            # and extends the flag list.
            self.assertIn('id = "sloc_house_boarded"', main)
            self.assertIn('name = "House (boarded up)"', main)
            self.assertIn('definition:terrain("house")', main)
            self.assertIn('definition:flag("ALLOW_OUTSIDE")', main)
            self.assertIn('definition:flag("BOARDED")', main)
            self.assertNotIn("needs review", report)

    def test_exclude_types_skips_entries_silently(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "sub_body_part",
                            "id": "sample_limb",
                            "name": "sample limb",
                            "parent": "torso",
                        },
                        {
                            "type": "body_part",
                            "id": "torso",
                            "name": "torso",
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]),
                "filter_mod",
                exclude_types=frozenset({"body_part"}),
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 0)
            self.assertIn("content.SubBodyPart", main)
            self.assertNotIn("content.BodyPart", main)
            self.assertNotIn("body part torso", report)

    def test_vehicle_groups_keep_duplicate_weighted_entries(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "vehicle_group",
                            "id": "duplicate_group",
                            "vehicles": [
                                ["car", 100],
                                ["car", 50],
                                ["suv", 200],
                            ],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "group_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 0)
            self.assertEqual(
                main.count('definition:vehicle("car"'), 2
            )
            self.assertNotIn("needs review", report)

    def test_translates_sound_effects(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "sound_effects_eoc",
                            "required_event": "character_wields_item",
                            "effect": [
                                {
                                    "id": "bionics",
                                    "sound_effect": "elec_crackle_low",
                                    "volume": 100,
                                },
                                {
                                    "id": "chainsaw_cord",
                                    "sound_effect": "chainsaw_on",
                                },
                                "nothing",
                            ],
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "invalid_sound_volume",
                            "required_event": "character_wields_item",
                            "effect": [
                                {
                                    "id": "bionics",
                                    "sound_effect": "elec_crackle_low",
                                    "volume": 500,
                                }
                            ],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "sound_effects_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 1)
            self.assertIn('services.sound.play_if_audible("bionics", "elec_crackle_low", 100)', main)
            self.assertIn('services.sound.play_if_audible("chainsaw_cord", "chainsaw_on", 80)', main)
            self.assertIn(
                "EOC invalid_sound_volume effect #0 needs domain-service conversion",
                report,
            )

    def test_translates_npc_attitude_and_control_effects(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "npc_attitude_effects",
                            "required_event": "npc_becomes_hostile",
                            "effect": [
                                "npc_wants_to_talk",
                                "u_wants_to_talk",
                                "hostile",
                                "flee",
                                "nothing",
                            ],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "npc_attitude_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 0)
            self.assertIn('services.npcs.set_attitude(actor, "talk")', main)
            self.assertIn('services.npcs.set_attitude(actor, "kill")', main)
            self.assertIn('services.npcs.set_attitude(actor, "flee")', main)
            self.assertNotIn("needs review", report)

    def test_translates_spawn_and_world_interaction_effects(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "avatar_spawns_and_world",
                            "required_event": "game_start",
                            "effect": [
                                {"u_spawn_item": "aspirin", "count": 2},
                                {"u_spawn_item": "water_clean"},
                                {
                                    "map_spawn_item": "flashlight",
                                    "count": 1,
                                    "loc": {"context_val": "loc"},
                                },
                                {"map_spawn_item": "radio"},
                                "player_weapon_away",
                                {"set_trap": "tr_beartrap", "loc": {"context_val": "loc"}},
                                {"set_trap": "tr_rollmat"},
                                {"signal_hordes": 50, "loc": {"context_val": "loc"}},
                                {"signal_hordes": 20},
                                {
                                    "reveal_route": {"context_val": "loc"},
                                    "target_var": {"context_val": "destination"},
                                    "radius": 3,
                                },
                                "end_conversation",
                            ],
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_attitudes_extended",
                            "required_event": "npc_becomes_hostile",
                            "effect": [
                                "follow",
                                "stop_following",
                                "stranger_neutral",
                            ],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "spawn_and_world_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(len(result.partial), 0)
            self.assertIn('services.inventory.give(\n        actor, services.types.id("item", "aspirin"), 2, { allow_wield = false })', main)
            self.assertIn('services.inventory.give(\n        actor, services.types.id("item", "water_clean"), 1, { allow_wield = false })', main)
            self.assertIn('services.world.spawn_item(context.data["loc"], services.types.id("item", "flashlight"), 1)', main)
            self.assertIn(
                'services.world.spawn_item(service_value(services.characters.snapshot(actor)).creature.position, '
                'services.types.id("item", "radio"), 1)',
                main,
            )
            self.assertIn('services.inventory.stash_wielded(actor)', main)
            self.assertIn('services.world.set_trap(context.data["loc"], services.types.id("trap", "tr_beartrap"))', main)
            self.assertIn(
                'services.world.set_trap(service_value(services.characters.snapshot(actor)).creature.position, '
                'services.types.id("trap", "tr_rollmat"))',
                main,
            )
            self.assertIn('services.hordes.signal(context.data["loc"], 50)', main)
            self.assertIn(
                'services.hordes.signal(service_value(services.characters.snapshot(actor)).creature.position, 20)',
                main,
            )
            self.assertIn(
                'services.overmap.reveal_route(\n'
                '        context.data["loc"], context.data["destination"], 3, false)',
                main,
            )
            self.assertIn('services.npcs.set_attitude(actor, "follow")', main)
            self.assertIn('services.npcs.set_attitude(actor, "null")', main)
            self.assertNotIn("needs review", report)

    def test_translates_foreach_with_native_definition_pages(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "foreach_native_pages",
                        "required_event": "game_start",
                        "effect": [
                            {
                                "foreach": "array",
                                "var": {"context_val": "id"},
                                "target": ["a", "b"],
                                "effect": {"u_message": "<context_val:id>"},
                            },
                            {
                                "foreach": "ids",
                                "var": {"context_val": "id"},
                                "target": "bodypart",
                                "effect": {"u_message": "<context_val:id>"},
                            },
                            {
                                "foreach": "ids",
                                "var": {"context_val": "id"},
                                "target": "trait",
                                "effect": {"u_message": "<context_val:id>"},
                            },
                            {
                                "foreach": "ids",
                                "var": {"context_val": "id"},
                                "target": "vitamin",
                                "effect": {"u_message": "<context_val:id>"},
                            },
                            {
                                "foreach": "item_group",
                                "var": {"context_val": "id"},
                                "target": "forest",
                                "effect": {"u_message": "<context_val:id>"},
                            },
                            {
                                "foreach": "monstergroup",
                                "var": {"context_val": "id"},
                                "target": "GROUP_ANIMALPOUND_DOGS",
                                "effect": {"u_message": "<context_val:id>"},
                            },
                        ],
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "foreach_pages_mod"
            )
            main = result.files[Path("main.lua")]
            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn('for _, entry in ipairs({ "a", "b" }) do', main)
            self.assertIn(
                'services.registry.list("body_part", '
                '{ offset = foreach_offset, limit = 256 })',
                main,
            )
            self.assertIn(
                "services.mutations.definitions({ offset = foreach_offset, limit = 256 })",
                main,
            )
            self.assertIn(
                "services.vitamins.definitions({ offset = foreach_offset, limit = 256 })",
                main,
            )
            self.assertIn(
                'services.items.possible_from_group(services.types.id("item_group", "forest"))',
                main,
            )
            self.assertIn(
                'services.hordes.monsters(services.types.id("monster_group", '
                '"GROUP_ANIMALPOUND_DOGS"), true, '
                '{ offset = foreach_offset, limit = 256 })',
                main,
            )

    def test_translates_senses_species_and_turn_cost(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "avatar_senses_turn_cost",
                            "required_event": "game_start",
                            "condition": {
                                "and": [
                                    "u_can_see",
                                    {"u_has_species": "human"},
                                    {"not": "u_has_activity"},
                                    {"not": "u_has_stolen_item"},
                                    {"not": "u_can_stow_weapon"},
                                    {"not": "u_are_owed"},
                                    {"not": "u_train_skills"},
                                    {"not": "u_train_spells"},
                                    {"not": "u_train_styles"},
                                ]
                            },
                            "effect": [
                                {"turn_cost": 50},
                            ],
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_senses_and_wake",
                            "required_event": "npc_becomes_hostile",
                            "condition": {
                                "and": [
                                    "npc_can_see",
                                    {"npc_has_species": "human"},
                                ]
                            },
                            "effect": [
                                "wake_up",
                                "reveal_stats",
                            ],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "senses_turn_cost_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(len(result.partial), 0)
            self.assertIn("services.characters.adjust(actor, { moves = -50 })", main)
            self.assertNotIn("needs review", report)

    def test_translates_npc_dialogue_attitude_and_denial_effects(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "npc_denials_and_attitudes",
                            "required_event": "npc_becomes_hostile",
                            "condition": {
                                "and": [
                                    {"not": "npc_train_skills"},
                                    {"not": "npc_train_spells"},
                                    {"not": "npc_train_styles"},
                                    {"not": "npc_has_stolen_item"},
                                    {"not": "npc_can_stow_weapon"},
                                ]
                            },
                            "effect": [
                                "insult_combat",
                                "lead_to_safety",
                                "leave",
                                "follow_only",
                                "deny_follow",
                                "deny_lead",
                                "deny_equipment",
                                "deny_train",
                                "deny_personal_info",
                            ],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "npc_dialogue_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 0)
            self.assertIn('services.npcs.set_attitude(actor, "kill")', main)
            self.assertIn('services.npcs.set_attitude(actor, "lead")', main)
            self.assertIn('services.npcs.set_attitude(actor, "null")', main)
            self.assertIn('services.npcs.set_attitude(actor, "follow")', main)
            self.assertIn(
                'services.effects.add(actor, services.types.id("effect", "asked_to_follow"), '
                'services.time.duration(21600, "turn"))',
                main,
            )
            self.assertIn(
                'services.effects.add(actor, services.types.id("effect", "asked_to_lead"), '
                'services.time.duration(21600, "turn"))',
                main,
            )
            self.assertIn(
                'services.effects.add(actor, services.types.id("effect", "asked_for_item"), '
                'services.time.duration(3600, "turn"))',
                main,
            )
            self.assertIn(
                'services.effects.add(actor, services.types.id("effect", "asked_to_train"), '
                'services.time.duration(21600, "turn"))',
                main,
            )
            self.assertIn(
                'services.effects.add(actor, services.types.id("effect", "asked_personal_info"), '
                'services.time.duration(10800, "turn"))',
                main,
            )
            self.assertNotIn("needs review", report)

    def test_translates_npc_guard_trade_and_animal_purchase_effects(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "npc_guard_and_trade",
                            "required_event": "npc_becomes_hostile",
                            "effect": [
                                "player_leaving",
                                "start_mugging",
                                "remove_stolen_status",
                                "assign_guard",
                                "stop_guard",
                                "buy_chicken",
                                "buy_horse",
                                "buy_cow",
                                "start_trade",
                                "barber_hair",
                                "barber_beard",
                                "buy_haircut",
                                "buy_shave",
                            ],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "npc_trade_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 0)
            self.assertIn('services.npcs.set_attitude(actor, "wait_for_leave")', main)
            self.assertIn('services.npcs.set_attitude(actor, "mug")', main)
            self.assertIn('services.npcs.set_attitude(actor, "null")', main)
            self.assertIn('services.npcs.set_attitude(actor, "follow")', main)
            self.assertIn(
                'services.spawns.monster(services.types.id("monster", "mon_chicken"), '
                'service_value(services.characters.snapshot(actor)).creature.position, 1)',
                main,
            )
            self.assertIn(
                'services.spawns.monster(services.types.id("monster", "mon_horse"), '
                'service_value(services.characters.snapshot(actor)).creature.position, 1)',
                main,
            )
            self.assertIn(
                'services.spawns.monster(services.types.id("monster", "mon_cow"), '
                'service_value(services.characters.snapshot(actor)).creature.position, 1)',
                main,
            )
            self.assertNotIn("needs review", report)

    def test_translates_npc_activity_effects(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "npc_activity_assigns",
                            "required_event": "npc_becomes_hostile",
                            "effect": [
                                "revert_activity",
                                "morale_chat_activity",
                                "do_butcher",
                                "do_chop_plank",
                                "do_chop_trees",
                                "do_construction",
                                "do_farming",
                                "do_fishing",
                                "do_mining",
                                "do_mopping",
                                "do_read",
                                "do_eread",
                                "do_read_repeatedly",
                                "do_study",
                                "sort_loot",
                                "do_craft",
                                "do_disassembly",
                                "do_vehicle_deconstruct",
                                "do_vehicle_repair",
                                "drop_items_in_place",
                            ],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "npc_activities_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 0)
            self.assertIn('services.activities.cancel(actor)', main)
            self.assertIn('services.activities.assign_timed(services.characters.avatar(), services.types.id("activity", "ACT_SOCIALIZE"), services.time.duration(600, "turn"))', main)
            self.assertIn('services.activities.assign_timed(actor, services.types.id("activity", "ACT_BUTCHER"), services.time.duration(1800, "turn"))', main)
            self.assertIn('services.activities.assign_timed(actor, services.types.id("activity", "ACT_CHOP_PLANKS"), services.time.duration(1800, "turn"))', main)
            self.assertIn('services.activities.assign_timed(actor, services.types.id("activity", "ACT_CHOP_TREE"), services.time.duration(3600, "turn"))', main)
            self.assertIn('services.activities.assign_timed(actor, services.types.id("activity", "ACT_BUILD"), services.time.duration(3600, "turn"))', main)
            self.assertIn('services.activities.assign_timed(actor, services.types.id("activity", "ACT_PLANT_SEED"), services.time.duration(1800, "turn"))', main)
            self.assertIn('services.activities.assign_timed(actor, services.types.id("activity", "ACT_FISH"), services.time.duration(3600, "turn"))', main)
            self.assertIn('services.activities.assign_timed(actor, services.types.id("activity", "ACT_MINING"), services.time.duration(3600, "turn"))', main)
            self.assertIn('services.activities.assign_timed(actor, services.types.id("activity", "ACT_MOPPING"), services.time.duration(900, "turn"))', main)
            self.assertIn('services.activities.assign_timed(actor, services.types.id("activity", "ACT_READ"), services.time.duration(1800, "turn"))', main)
            self.assertIn('services.activities.assign_timed(actor, services.types.id("activity", "ACT_READ"), services.time.duration(7200, "turn"))', main)
            self.assertIn('services.activities.assign_timed(actor, services.types.id("activity", "ACT_STUDY_SPELL"), services.time.duration(3600, "turn"))', main)
            self.assertIn('services.activities.assign_timed(actor, services.types.id("activity", "ACT_SORT_LOOT"), services.time.duration(1800, "turn"))', main)
            self.assertIn('services.activities.assign_timed(actor, services.types.id("activity", "ACT_CRAFT"), services.time.duration(3600, "turn"))', main)
            self.assertIn('services.activities.assign_timed(actor, services.types.id("activity", "ACT_DISASSEMBLE"), services.time.duration(3600, "turn"))', main)
            self.assertIn('services.activities.assign_timed(actor, services.types.id("activity", "ACT_VEHICLE_DECONSTRUCT"), services.time.duration(3600, "turn"))', main)
            self.assertIn('services.activities.assign_timed(actor, services.types.id("activity", "ACT_VEHICLE_REPAIR"), services.time.duration(3600, "turn"))', main)
            self.assertIn('services.activities.assign_timed(actor, services.types.id("activity", "ACT_DROP"), services.time.duration(60, "turn"))', main)
            self.assertNotIn("needs review", report)

    def test_translates_npc_mount_training_and_interaction_effects(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "npc_mount_and_train",
                            "required_event": "npc_becomes_hostile",
                            "effect": [
                                "dismount",
                                "find_mount",
                                "start_training",
                                "start_training_seminar",
                                "distribute_food_auto",
                                "lesser_give_aid",
                                "give_all_aid",
                                "lesser_give_all_aid",
                                "open_dialogue",
                                "pick_style",
                                "take_control",
                            ],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "npc_mount_train_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 0)
            self.assertIn('services.activities.assign_timed(actor, services.types.id("activity", "ACT_FIND_MOUNT"), services.time.duration(600, "turn"))', main)
            self.assertIn('services.activities.assign_timed(actor, services.types.id("activity", "ACT_TRAIN"), services.time.duration(3600, "turn"))', main)
            self.assertIn('services.activities.assign_timed(actor, services.types.id("activity", "ACT_DISTRIBUTE_FOOD"), services.time.duration(1800, "turn"))', main)
            self.assertNotIn("needs review", report)

    def test_translates_teleport_navigation_damage_and_events(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "npc_teleport_and_damage",
                            "required_event": "npc_becomes_hostile",
                            "effect": [
                                {"u_teleport": {}},
                                {"npc_teleport": {}},
                                {"u_set_goal": {}},
                                {"npc_set_goal": {}},
                                {"u_set_guard_pos": {}},
                                {"npc_set_guard_pos": {}},
                                "goto_location",
                                {"u_deal_damage": "pure", "amount": 10, "bodypart": "torso"},
                                {"npc_deal_damage": "pure", "amount": 15, "bodypart": "torso"},
                                {"trigger_event": "custom_event"},
                                "u_pick_bodypart",
                                "npc_pick_bodypart",
                                "clear_dimension",
                                "clear_overrides",
                                "place_override",
                                "return_to_camp_duties",
                            ],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "npc_teleport_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 0)
            self.assertEqual(len(result.partial), 1)
            self.assertIn(
                "TODO: translate teleport through a typed creature-relocation service.",
                main,
            )
            self.assertIn("TODO: translate the NPC goal", main)
            self.assertIn("TODO: translate the NPC guard position", main)
            self.assertIn("services.npcs.destinations(actor)", main)
            self.assertIn(
                'ccb.presentation.choose("Select a destination", choices)',
                main,
            )
            self.assertIn("services.npcs.plan_travel(", main)
            self.assertIn("services.npcs.set_goal(", main)
            self.assertNotIn("TODO: translate goto_location", main)
            self.assertIn("services.npcs.set_goal", main)
            self.assertNotIn("services.npcs.set_guard_pos", main)
            self.assertNotIn("services.npcs.set_omt_destination", main)
            self.assertNotIn("services.relocation.local_at", main)
            self.assertIn(
                'services.characters.damage(\n        actor, '
                'services.types.id("damage_type", "pure"), 10,\n'
                '        { '
                'body_part = services.types.id("body_part", "torso") })',
                main,
            )
            self.assertIn(
                'services.characters.damage(\n        actor, '
                'services.types.id("damage_type", "pure"), 15,\n'
                '        { '
                'body_part = services.types.id("body_part", "torso") })',
                main,
            )
            self.assertIn('runtime.trigger("game:custom_event")', main)
            self.assertIn('services.camps.return_to_duties(actor)', main)
            self.assertNotIn("needs review", report)

    def test_translates_bounded_npc_goal_and_guard_variable_shapes(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "bounded_navigation",
                        "required_event": "game_start",
                        "effect": [
                            {
                                "u_set_goal": {
                                    "om_terrain": "road",
                                    "om_special": "special_road",
                                    "search_range": 12,
                                    "min_distance": 1,
                                    "offset_x": 1,
                                }
                            },
                            {"u_set_guard_pos": {"u_val": "guard_position"}},
                        ],
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "bounded_navigation_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertIn("services.overmap.search(origin", main)
            self.assertIn('terrain = "road"', main)
            self.assertIn('special = "special_road"', main)
            self.assertIn("minimum_radius = 1", main)
            self.assertIn("services.npcs.set_goal(", main)
            self.assertIn('services.variables.get(\n        services.characters.avatar(), "guard_position")', main)
            self.assertIn("services.npcs.set_guard_position(", main)
            self.assertNotIn("TODO: translate the NPC goal", main)
            self.assertNotIn("TODO: translate the NPC guard position", main)
            self.assertNotIn("domain-service conversion", report)

    def test_translates_bounded_perception_conditions(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "avatar_perception",
                            "required_event": "game_start",
                            "condition": {
                                "u_monsters_in_direction": "NE",
                            },
                            "effect": "u_cancel_activity",
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_perception",
                            "required_event": "npc_becomes_hostile",
                            "condition": {
                                "and": [
                                    "u_see_npc_loc",
                                    "npc_see_u_loc",
                                    {"npc_query": "ignored", "default": False},
                                ]
                            },
                            "effect": "npc_cancel_activity",
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "perception_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(result.partial, [])
            self.assertIn(
                'services.creatures.visible_monsters("NE").present', main
            )
            self.assertIn(
                "services.creatures.has_line_of_sight(services.characters.avatar(), actor)",
                main,
            )
            self.assertIn(
                "services.creatures.has_line_of_sight(actor, services.characters.avatar())",
                main,
            )
            self.assertIn("and (false)", main)
            self.assertNotIn("needs domain-service conversion", report)

    def test_translates_literal_avatar_query_condition(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "avatar_query",
                        "required_event": "game_start",
                        "condition": {
                            "u_query": "Continue the operation?",
                            "default": False,
                        },
                        "effect": "u_cancel_activity",
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "query_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertIn(
                'ccb.presentation.confirm("Continue the operation?")', main
            )
            self.assertNotIn("needs a native Lua predicate", report)

    def test_translates_bounded_avatar_mission_lifecycle_shapes(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "assign_literal_mission",
                            "required_event": "game_start",
                            "effect": {
                                "assign_mission": "MISSION_TEST",
                                "deadline": 500,
                            },
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "finish_literal_mission",
                            "required_event": "game_start",
                            "effect": {
                                "finish_mission": "MISSION_TEST",
                                "success": True,
                            },
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "remove_literal_mission",
                            "required_event": "game_start",
                            "effect": {"remove_active_mission": "MISSION_TEST"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "mission_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 3)
            self.assertEqual(result.partial, [])
            self.assertIn('services.missions.reserve(\n        services.types.id("mission", "MISSION_TEST"))', main)
            self.assertIn("services.missions.set_deadline(", main)
            self.assertIn("services.time.point(500)", main)
            self.assertIn("services.missions.assign(token)", main)
            self.assertIn("services.missions.complete(", main)
            self.assertIn("services.missions.abandon(entry.token)", main)
            self.assertNotIn("mission lifecycle shape", main)
            self.assertNotIn("domain-service conversion", report)

    def test_translates_variable_backed_avatar_mission_lifecycle_shapes(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "assign_variable_mission",
                            "required_event": "game_start",
                            "effect": {
                                "assign_mission": {"context_val": "mission_id"},
                                "deadline": {"global_val": "mission_deadline"},
                            },
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "finish_variable_mission",
                            "required_event": "game_start",
                            "effect": {
                                "finish_mission": {"u_val": "mission_id"},
                                "step": {"context_val": "mission_step"},
                            },
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "remove_variable_mission",
                            "required_event": "game_start",
                            "effect": {
                                "remove_active_mission": {"global_val": "mission_id"},
                            },
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "dynamic_mission_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 3)
            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn('services.types.id("mission", tostring((context.data["mission_id"])', main)
            self.assertIn('services.variables.get_global("mission_deadline")', main)
            self.assertIn('services.variables.resolve(context.data, actor, "u", "mission_id")', main)
            self.assertIn('services.missions.step_complete(', main)
            self.assertNotIn("mission lifecycle shape", report)

    def test_translates_bounded_npc_mission_provider_shapes(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "npc_mission_provider",
                        "required_event": "npc_becomes_hostile",
                        "effect": [
                            {"offer_mission": ["MISSION_ONE", "MISSION_TWO"]},
                            "assign_mission",
                            "mission_success",
                            "mission_failure",
                            "clear_mission",
                            "remove_active_mission",
                            "mission_reward",
                        ],
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "npc_mission_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertEqual(main.count("services.npcs.missions.offer("), 2)
            self.assertIn("services.npcs.missions.assign_selected(actor)", main)
            self.assertIn("services.npcs.missions.succeed_selected(actor, false)", main)
            self.assertIn("services.npcs.missions.fail_selected(actor)", main)
            self.assertIn("services.npcs.missions.clear_selected(actor)", main)
            self.assertEqual(
                main.count("services.npcs.missions.clear_selected(actor)"), 2
            )
            self.assertIn("services.npcs.missions.claim_selected_reward(actor)", main)

    def test_translates_bounded_camp_worker_actions(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "camp_worker_actions",
                        "required_event": "npc_becomes_hostile",
                        "effect": [
                            "start_camp",
                            "assign_camp",
                            "return_to_camp_duties",
                            "abandon_camp",
                        ],
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "camp_worker_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertIn("services.camps.start_with(actor)", main)
            self.assertIn("services.camps.assign_resident(actor)", main)
            self.assertIn("services.camps.return_to_duties(actor)", main)
            self.assertIn("services.camps.abandon_at_worker(actor)", main)

    def test_translates_bounded_npc_service_menu_actions(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "npc_service_menus",
                        "required_event": "npc_becomes_hostile",
                        "effect": [
                            "npc_rules_menu",
                            "set_npc_pickup",
                            "start_training_npc",
                        ],
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "npc_service_menu_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertIn("services.npcs.open_rules(actor)", main)
            self.assertIn(
                "services.npcs.orders.open_pickup_rules(actor)", main
            )
            self.assertIn(
                'services.npcs.training.start_selected(actor, "npc")', main
            )
            self.assertNotIn("needs domain-service conversion", report)

    def test_translates_bounded_context_pickup_actions(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "avatar_pickup",
                            "required_event": "game_start",
                            "effect": {
                                "u_pickup_items": {"context_val": "loot_pos"},
                                "extra_moves_per_item": 5,
                                "max_volume": 1000,
                            },
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_pickup",
                            "required_event": "npc_becomes_hostile",
                            "effect": {
                                "npc_pickup_items": {"context_val": "npc_pos"},
                                "max_mass": 2500,
                            },
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "pickup_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(result.partial, [])
            self.assertIn(
                'services.activities.pickup_from(\n        actor, '
                'context.data["loot_pos"], 5, 1000, nil)',
                main,
            )
            self.assertIn(
                'services.activities.pickup_from(\n        actor, context.data["npc_pos"], '
                '0, nil, 2500)',
                main,
            )
            self.assertNotIn("pickup location and limits", main)
            self.assertNotIn("needs domain-service conversion", report)

    def test_translates_bounded_follower_and_item_selection_actions(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "npc_selection_services",
                        "required_event": "npc_becomes_hostile",
                        "effect": [
                            "bionic_install_allies",
                            "bionic_remove_allies",
                            "copy_npc_rules",
                            "npc_gets_item",
                            "npc_gets_item_to_use",
                        ],
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "selection_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertEqual(main.count("services.followers.list()"), 3)
            self.assertIn(
                'services.npcs.medical.open_bionic_service(\n'
                '                    actor, "install", selected_handle)',
                main,
            )
            self.assertIn(
                'services.npcs.medical.open_bionic_service(\n'
                '                    actor, "remove", selected_handle)',
                main,
            )
            self.assertIn(
                "services.npcs.copy_ai_rules(\n"
                "                    actor, selected_handle)",
                main,
            )
            self.assertEqual(main.count("services.inventory.choose("), 2)
            self.assertIn(
                "services.npcs.offer_item(\n"
                "                actor, selected.item, false)",
                main,
            )
            self.assertIn(
                "services.npcs.offer_item(\n"
                "                actor, selected.item, true)",
                main,
            )
            self.assertNotIn("needs domain-service conversion", report)

    def test_translates_bounded_npc_equipment_trade_shapes(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "npc_equipment_trade",
                        "required_event": "npc_becomes_hostile",
                        "effect": [
                            "drop_stolen_item",
                            {"give_equipment": {"allowance": 500}},
                            {
                                "u_buy_monster": "mon_dog",
                                "cost": 500,
                                "count": 2,
                                "pacified": True,
                                "name": "Buddy",
                            },
                            {"u_spend_cash": 250},
                            {"u_remove_item_with": "rock"},
                            {"npc_remove_item_with": "bandage"},
                            {"u_buy_item": "apple", "cost": 50, "count": 2},
                            {"u_sell_item": "rock", "cost": 25, "count": 1},
                            {"u_level_spell_class": "all", "levels": 2},
                            {"npc_level_spell_class": "MUTATION_CLASS", "levels": 1},
                            {"u_roll_remainder": ["MUT_A", "MUT_B"], "type": "mutation"},
                            {"npc_roll_remainder": ["SPELL_A"], "type": "spell"},
                            {"u_roll_remainder": ["RECIPE_A"], "type": "recipe"},
                            {"add_mission": "MISSION_A"},
                            "give_aid",
                            {"u_faction_rep": 2},
                            {"add_debt": [["ANGER", 1], ["TOTAL", 1]]},
                            "basecamp_mission",
                            {"companion_mission": "SCAVENGER"},
                            "bionic_install",
                            "bionic_remove",
                            "repair_bionic_limbs",
                        ],
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "npc_equipment_trade_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertIn(
                "services.npcs.equipment.return_stolen_items(actor)", main
            )
            self.assertIn(
                "services.npcs.equipment.request_gift(\n        actor, 500)",
                main,
            )
            self.assertIn(
                'services.trade.buy_monsters(\n        actor, services.types.id("monster", "mon_dog"), 500',
                main,
            )
            self.assertIn("name = \"Buddy\"", main)
            self.assertIn("services.trade.settle(\n        actor, spend_amount)", main)
            self.assertEqual(main.count("services.inventory.remove(actor, matching_items[index])"), 2)
            self.assertIn(
                "services.inventory.remove(actor, matching_items[index])",
                main,
            )
            self.assertIn(
                'services.inventory.give(\n        services.characters.avatar(), services.types.id("item", "apple"), 2',
                main,
            )
            self.assertIn(
                'services.trade.transfer_matching(\n        services.characters.avatar(), actor, services.types.id("item", "rock"), { limit = 1 })',
                main,
            )
            self.assertIn("services.spells.gain_levels(", main)
            self.assertIn("actor, spell.id, 2", main)
            self.assertIn("actor, spell.id, 1", main)
            self.assertIn("services.mutations.grant(actor, remainder)", main)
            self.assertIn("services.spells.learn(actor, remainder, { force = true })", main)
            self.assertIn("services.recipes.learn(actor, remainder, true)", main)
            self.assertIn(
                'services.npcs.missions.add_assigned(\n        actor, services.types.id("mission", "MISSION_A"))',
                main,
            )
            self.assertIn(
                'services.npcs.medical.provide_aid(actor, "advanced", false)',
                main,
            )
            self.assertIn(
                "services.npcs.add_faction_rep(\n        actor, 2)",
                main,
            )
            self.assertIn("local npc_state = service_value(services.npcs.get(actor))", main)
            self.assertIn("debt = debt + (npc_state.opinion.anger) * 1", main)
            self.assertIn("services.camps.open_missions(actor)", main)
            self.assertIn(
                'services.npcs.open_companion_missions(actor, "SCAVENGER")',
                main,
            )
            self.assertIn(
                'services.npcs.medical.open_bionic_service(actor, "install")',
                main,
            )
            self.assertIn(
                'services.npcs.medical.open_bionic_service(actor, "remove")',
                main,
            )
            self.assertIn(
                "services.npcs.medical.repair_bionic_limbs(actor)", main
            )
            self.assertNotIn("domain-service conversion", report)

    def test_roll_remainder_runs_true_and_false_callbacks(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "roll_remainder_success",
                            "required_event": "game_start",
                            "effect": {"message": "success"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "roll_remainder_failure",
                            "required_event": "game_start",
                            "effect": {"message": "failure"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "roll_remainder_callbacks",
                            "required_event": "game_start",
                            "effect": {
                                "u_roll_remainder": ["MUT_A", "MUT_B"],
                                "type": "mutation",
                                "message": "You learned %s.",
                                "true_eocs": "roll_remainder_success",
                                "false_eocs": "roll_remainder_failure",
                            },
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "roll_remainder_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 3)
            self.assertEqual(result.partial, [])
            self.assertIn(
                "migrated_eoc_roll_remainder_success(context, actor)", main
            )
            self.assertIn(
                "migrated_eoc_roll_remainder_failure(context, actor)", main
            )
            self.assertIn(
                'services.message(string.format("You learned %s.", remainder_name))',
                main,
            )
            self.assertNotIn("remainder-roll conversion", report)

    def test_translates_proven_character_teleport_targets(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "bounded_character_teleport",
                            "required_event": "game_start",
                            "effect": [
                                {"u_teleport": {"u_val": "return_pos"}},
                                {
                                    "u_teleport": {"context_val": "safe_pos"},
                                    "force": True,
                                },
                            ],
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "bounded_npc_teleport",
                            "required_event": "npc_becomes_hostile",
                            "effect": [
                                {"npc_teleport": {"npc_val": "npc_pos"}},
                            ],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "teleport_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(result.partial, [])
            self.assertEqual(main.count("services.relocation.creature_at("), 3)
            self.assertIn(
                'services.variables.get(\n        actor, "return_pos")',
                main,
            )
            self.assertIn('context.data["safe_pos"]', main)
            self.assertIn("{ force = true }", main)
            self.assertNotIn("services.relocation.local_at", main)
            self.assertNotIn("needs domain-service conversion", report)

    def test_translates_literal_and_variable_avatar_dimension_travel(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "bounded_dimension_travel",
                            "required_event": "game_start",
                            "effect": [
                                {"u_travel_to_dimension": "nether"},
                                {
                                    "u_travel_to_dimension": "scarlet",
                                    "npc_travel_radius": 10,
                                    "npc_travel_filter": "follower",
                                    "item_travel_radius": 4,
                                    "take_vehicle": True,
                                },
                            ],
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "dynamic_dimension_travel",
                            "required_event": "game_start",
                            "effect": {"u_travel_to_dimension": {"u_val": "target"}},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "dimension_travel_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(result.partial, [])
            self.assertEqual(main.count("services.relocation.travel_to_dimension("), 3)
            self.assertIn('"nether"', main)
            self.assertIn('npc_travel_filter = "follower"', main)
            self.assertIn("item_travel_radius = 4", main)
            self.assertIn("take_vehicle = true", main)
            self.assertIn('services.variables.resolve(context.data, actor, "u", "target")', main)
            self.assertNotIn("TODO: translate u_travel_to_dimension", main)
            self.assertNotIn("needs domain-service conversion", report)

    def test_reports_missing_item_transform_service_without_crashing(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "npc_fault_and_item",
                            "required_event": "npc_becomes_hostile",
                            "effect": [
                                {"custom_light_level": 50},
                                {"u_activate": "item_id"},
                                {"npc_activate": "item_id"},
                                {"u_set_fault": "fault_id"},
                                {"npc_set_fault": "fault_id"},
                                {"u_set_random_fault_of_type": "engine"},
                                {"npc_set_random_fault_of_type": "engine"},
                                {"transform_item": "new_item_id"},
                                {
                                    "transform_item": {
                                        "context_val": "transform_target"
                                    }
                                },
                                {"transform_line": {}},
                                {"u_travel_to_dimension": "nether"},
                            ],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "npc_fault_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 0)
            self.assertEqual(len(result.partial), 1)
            self.assertIn("TODO: translate custom_light_level", main)
            self.assertNotIn("TODO: translate item activation", main)
            self.assertIn("TODO: translate item fault mutation", main)
            self.assertIn("TODO: translate random item-fault mutation", main)
            self.assertNotIn("services.items.transform", main)
            self.assertIn("TODO: translate transform_line", main)
            self.assertNotIn("TODO: translate u_travel_to_dimension", main)
            self.assertNotIn("services.world.transform_line", main)
            self.assertNotIn("services.gameplay.environment.set_light_level", main)
            self.assertIn("services.items.activate", main)
            self.assertNotIn("services.items.set_fault", main)
            self.assertNotIn("services.items.set_random_fault", main)
            self.assertNotIn("services.relocation.overmap_at", main)
            self.assertIn(
                "transform_item needs a native item-talker transform service",
                report,
            )

    def test_renders_bounded_custom_light_override_and_fails_closed(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "custom_light_shapes",
                            "required_event": "character_wakes_up",
                            "effect": [
                                {
                                    "custom_light_level": 50,
                                    "length": "2 turns",
                                    "key": "ccb_light",
                                },
                                {
                                    "custom_light_level": 0,
                                    "length": "1 seconds",
                                },
                                {
                                    "custom_light_level": {
                                        "context_val": "level"
                                    },
                                    "length": "1 turn",
                                },
                                {
                                    "custom_light_level": 80,
                                    "length": {"context_val": "duration"},
                                },
                                {"custom_light_level": 126, "length": "1 turn"},
                                {"custom_light_level": 20},
                            ],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "custom_light_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 0)
            self.assertEqual(len(result.partial), 1)
            self.assertIn(
                'services.gameplay.environment.set_light_override(\n'
                '        50, services.time.duration(2, "turn"), "ccb_light")',
                main,
            )
            self.assertIn(
                'services.gameplay.environment.set_light_override(\n'
                '        0, services.time.duration(1, "turn"))',
                main,
            )
            self.assertEqual(main.count("TODO: translate custom_light_level"), 1)
            self.assertIn("needs domain-service conversion", report)

    def test_lowers_dynamic_damage_and_keeps_unproven_npc_target_fail_closed(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "damage_requires_lua_rewrite",
                            "required_event": "character_wakes_up",
                            "effect": [
                                {
                                    "u_deal_damage": "pure",
                                    "amount": {"math": ["rng(1, 3)"]},
                                },
                                {
                                    "npc_deal_damage": "pure",
                                    "amount": {"context_val": "damage"},
                                },
                            ],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "damage_rewrite_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 0)
            self.assertEqual(len(result.partial), 1)
            self.assertNotIn("services.characters.adjust(actor, { hp", main)
            self.assertEqual(main.count("services.characters.damage("), 1)
            self.assertIn("damage amount/options need a finite static Lua-native conversion", report)

    def test_translates_item_state_and_transform_for_proven_item_event(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "bounded_item_transform",
                            "required_event": "character_wields_item",
                            "effect": [
                                {"set_browsed": True},
                                {
                                    "transform_item": {
                                        "context_val": "target"
                                    },
                                    "active": True,
                                },
                            ],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "item_transform_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertIn("services.items.update(", main)
            self.assertIn("browsed = true", main)
            self.assertIn("services.items.transform(", main)
            self.assertIn("context.actors.item", main)
            self.assertIn("carrier = actor", main)
            self.assertIn("active = true", main)
            self.assertIn('context.data["target"]', main)
            self.assertNotIn("transform_item needs", report)
            self.assertNotIn("run_eoc", main)

    def test_translates_literal_item_fault_mutations_for_proven_item_events(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "bounded_item_fault",
                            "required_event": "character_wields_item",
                            "effect": [
                                {"npc_set_fault": "fault_sample"},
                                {"u_set_fault": "fault_avatar"},
                                {
                                    "npc_set_fault": "fault_forced",
                                    "force": True,
                                    "message": False,
                                },
                                {
                                    "npc_set_random_fault_of_type": "engine",
                                    "force": True,
                                },
                                {"u_set_random_fault_of_type": "engine"},
                            ],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "item_fault_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertEqual(
                main.count("if context.actors.item ~= nil then"), 5
            )
            self.assertEqual(main.count("services.items.set_fault("), 3)
            self.assertEqual(main.count("services.items.set_random_fault("), 2)
            self.assertIn('services.types.id("fault", "fault_sample")', main)
            self.assertIn('services.types.id("fault", "fault_avatar")', main)
            self.assertIn('services.types.id("fault", "fault_forced")', main)
            self.assertIn('"engine",', main)
            self.assertIn("holder = actor", main)
            self.assertIn("force = true", main)
            self.assertIn("message = false", main)
            self.assertNotIn("item fault id and options", report)
            self.assertNotIn("run_eoc", main)

    def test_item_fault_mutations_fail_closed_without_static_item_proof(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            cases = [
                ("game_start", {"npc_set_fault": "fault_sample"}),
                (
                    "character_wields_item",
                    {"u_set_fault": {"context_val": "fault_id"}},
                ),
                (
                    "character_wears_item",
                    {"npc_set_fault": {"context_val": "fault_id"}},
                ),
                (
                    "character_takeoff_item",
                    {
                        "npc_set_random_fault_of_type": "engine",
                        "message": "yes",
                    },
                ),
                (
                    "character_armor_destroyed",
                    {"npc_set_fault": "X" * 257},
                ),
            ]
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": f"unsafe_item_fault_{index}",
                            "required_event": event,
                            "effect": effect,
                        }
                        for index, (event, effect) in enumerate(cases)
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "item_fault_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(len(result.partial), 3)
            self.assertIn("services.items.set_fault", main)
            self.assertNotIn("services.items.set_random_fault", main)
            self.assertEqual(
                report.count("needs domain-service conversion"), 3
            )
            self.assertNotIn("run_eoc", main)

    def test_translates_noninteractive_body_part_picks_for_proven_actors(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "bounded_body_part_pick_avatar",
                            "required_event": "game_start",
                            "effect": {
                                "u_pick_bodypart": {"u_val": "picked"},
                                "pick_random": True,
                                "wounded": True,
                            },
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "bounded_body_part_pick_npc",
                            "required_event": "npc_becomes_hostile",
                            "effect": {
                                "npc_pick_bodypart": {"npc_val": "picked"},
                                "wounded": False,
                            },
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "body_part_pick_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(result.partial, [])
            self.assertEqual(main.count("services.characters.pick_body_part"), 2)
            self.assertIn("wounded = true", main)
            self.assertIn("wounded = false", main)
            self.assertIn('services.variables.set(actor, "picked", picked.body_part.value)', main)
            self.assertNotIn("body-part picking", report)

    def test_body_part_pick_stays_fail_closed_for_interactive_or_dynamic_shapes(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "unsafe_body_part_pick_avatar",
                            "required_event": "game_start",
                            "effect": {
                                "u_pick_bodypart": {"u_val": "picked"},
                            },
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "unsafe_body_part_pick_filter",
                            "required_event": "npc_becomes_hostile",
                            "effect": {
                                "npc_pick_bodypart": {"npc_val": "picked"},
                                "whitelist_flag": "WET",
                            },
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "body_part_pick_mod"
            )
            main = result.files[Path("main.lua")]
            self.assertEqual(result.converted, [])
            self.assertEqual(len(result.partial), 2)
            self.assertNotIn("services.characters.pick_body_part", main)
            self.assertEqual(main.count("TODO: translate body-part picking"), 2)

    def test_translates_literal_item_activation_for_proven_item_events(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "bounded_item_activation",
                            "required_event": "character_wields_item",
                            "effect": [
                                {"u_activate": "reveal_map"},
                                {"npc_activate": "transform"},
                            ],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "item_activation_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertEqual(main.count("services.items.activate("), 2)
            self.assertEqual(main.count("context.actors.item ~= nil and actor ~= nil"), 2)
            self.assertIn('context.actors.item, actor, "reveal_map")', main)
            self.assertIn('context.actors.item, actor, "transform")', main)
            self.assertNotIn("item activation through", report)

    def test_item_activation_fails_closed_for_dynamic_or_interactive_shapes(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "unsafe_item_activation",
                            "required_event": "character_wields_item",
                            "effect": [
                                {"u_activate": {"context_val": "method"}},
                                {"npc_activate": ""},
                                {
                                    "u_activate": "deploy_furn",
                                    "target_var": {"u_val": "activate_pos"},
                                },
                            ],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "unsafe_item_activation_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 0)
            self.assertEqual(len(result.partial), 1)
            self.assertEqual(main.count("services.items.activate("), 2)
            self.assertEqual(report.count("needs domain-service conversion"), 1)

    def test_translates_prevent_death_boundary_to_cancellable_hook(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "bounded_prevent_death",
                            "eoc_type": "PREVENT_DEATH",
                            "effect": "u_prevent_death",
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "bounded_npc_death",
                            "eoc_type": "NPC_DEATH",
                            "effect": "u_prevent_death",
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "fatal_hook_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(result.partial, [])
            self.assertIn(
                'runtime.hook("on_avatar_fatal", '
                '"migrated.bounded_prevent_death")',
                main,
            )
            self.assertIn("context.actors.avatar = context.character", main)
            self.assertIn(
                'runtime.hook("on_npc_fatal", "migrated.bounded_npc_death")',
                main,
            )
            self.assertIn(
                "local actor = actor_override or context.character or context.actors.npc",
                main,
            )
            self.assertIn("context.data = context.data or {}", main)
            self.assertIn("return false", main)
            self.assertNotIn("needs an explicit Platform trigger", report)
            self.assertNotIn("services.characters.u_prevent_death", main)
            self.assertNotIn("run_eoc", main)

    def test_translates_migration_json_object_types(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {"type": "MIGRATION", "id": "old_item", "replace": "new_item"},
                        {"type": "TRAIT_MIGRATION", "id": "old_trait", "replace": "new_trait"},
                        {"type": "spell_migration", "id": "old_spell", "replace": "new_spell"},
                        {"type": "camp_migration", "id": "old_camp", "replace": "new_camp"},
                        {"type": "mod_migration", "id": "old_mod", "replace": "new_mod"},
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "migrations_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 5)
            self.assertEqual(len(result.partial), 0)
            self.assertIn('kind = "item"', main)
            self.assertIn('from = "old_item"', main)
            self.assertIn('to = "new_item"', main)
            self.assertIn('kind = "mutation"', main)
            self.assertIn('from = "old_trait"', main)
            self.assertIn('kind = "spell"', main)
            self.assertIn('from = "old_spell"', main)
            self.assertIn('kind = "camp"', main)
            self.assertIn('from = "old_camp"', main)
            self.assertIn('kind = "mod"', main)
            self.assertIn('from = "old_mod"', main)
            self.assertNotIn("needs review", report)

    def test_translates_dimension_slider_and_omt_placeholder_types(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "option_slider",
                            "id": "test_slider",
                            "name": "Test slider",
                            "context": "WORLDGEN",
                            "default": 1,
                            "levels": [
                                {
                                    "level": 0,
                                    "name": "Low",
                                    "description": "Low values",
                                    "options": [
                                        {"option": "MONSTER_SPEED", "type": "int", "val": 90},
                                        {"option": "SPAWN_DENSITY", "type": "float", "val": 0.5},
                                    ],
                                },
                                {
                                    "level": 1,
                                    "name": "Normal",
                                    "options": [
                                        {"option": "ETERNAL_SEASON", "type": "bool", "val": False},
                                        {"option": "ETERNAL_TIME_OF_DAY", "type": "string", "val": "normal"},
                                    ],
                                },
                            ],
                        },
                        {
                            "type": "dimension_region_layout",
                            "id": "test_layout",
                            "generation_mode": "UNIFORM",
                            "uniform_region": "default",
                        },
                        {
                            "type": "dimension",
                            "id": "test_dimension",
                            "region_layout": "test_layout",
                        },
                        {
                            "type": "omt_placeholder",
                            "id": "test_placeholder",
                            "grid": ["01" * 12 for _ in range(24)],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "generic_content_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 4)
            self.assertEqual(len(result.partial), 0)
            self.assertEqual(len(result.todos), 0)
            self.assertIn("content.OptionSlider", main)
            self.assertIn("default_level = 1", main)
            self.assertIn('type = "float", value = 0.5', main)
            self.assertIn("content.DimensionRegionLayout", main)
            self.assertIn('uniform_region = "default"', main)
            self.assertIn("content.Dimension", main)
            self.assertIn('region_layout = "test_layout"', main)
            self.assertIn("content.OmtPlaceholder", main)
            self.assertIn('"010101010101010101010101"', main)
            self.assertNotIn("needs review", report)

    def test_rejects_invalid_dimension_slider_and_placeholder_values(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "option_slider",
                            "id": "bad_slider",
                            "name": "Bad slider",
                            "levels": [
                                {
                                    "level": 0,
                                    "name": "Broken",
                                    "options": [
                                        {"option": "MONSTER_SPEED", "type": "int", "val": 1.5},
                                    ],
                                },
                            ],
                        },
                        {
                            "type": "dimension_region_layout",
                            "id": "bad_layout",
                            "generation_mode": "RANDOM",
                            "uniform_region": "default",
                        },
                        {
                            "type": "dimension",
                            "id": "bad_dimension",
                            "region_layout": "",
                        },
                        {
                            "type": "omt_placeholder",
                            "id": "bad_placeholder",
                            "grid": ["2" * 24 for _ in range(24)],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "generic_content_mod"
            )
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 0)
            self.assertEqual(len(result.partial), 4)
            self.assertGreaterEqual(len(result.todos), 4)
            self.assertIn("option #0 needs review", report)
            self.assertIn("generation_mode needs review", report)
            self.assertIn("region_layout needs review", report)
            self.assertIn("grid needs review", report)

    def test_translates_event_statistics_and_transformations(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "event_transformation",
                            "id": "moves_expand",
                            "event_type": "avatar_moves",
                            "new_fields": {
                                "swimming": {
                                    "is_swimming_terrain": "terrain"
                                }
                            },
                            "value_constraints": {
                                "underwater": {"equals": ["bool", True]},
                                "movement_mode": {
                                    "equals": ["character_movemode", "walk"]
                                },
                                "terrain": {
                                    "equals_any": ["ter_id", ["t_grass", "t_dirt"]]
                                },
                                "character": {"equals_statistic": "avatar_id"},
                            },
                            "drop_fields": ["character"],
                        },
                        {
                            "type": "event_statistic",
                            "id": "moves_count",
                            "stat_type": "count",
                            "event_transformation": "moves_expand",
                            "description": {
                                "str": "move",
                                "str_pl": "moves",
                            },
                        },
                        {
                            "type": "event_statistic",
                            "id": "moves_total_z",
                            "stat_type": "total",
                            "event_type": "avatar_moves",
                            "field": "z",
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "event_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 3)
            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn("content.EventTransformation {", main)
            self.assertIn("definition:derive(\"swimming\", \"is_swimming_terrain\", \"terrain\")", main)
            self.assertIn("definition:where_equals(\"underwater\", \"bool\", true)", main)
            self.assertIn("definition:where_any(\"terrain\", \"ter_id\", { \"t_grass\", \"t_dirt\" })", main)
            self.assertIn("definition:where_statistic(\"character\", \"avatar_id\")", main)
            self.assertIn("description_plural = \"moves\"", main)
            self.assertNotIn("has no native Platform registrar", report)
            self.assertNotIn("run_eoc", main)

    def test_reports_unregistered_generic_json_content_types(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {"type": "jmath_function", "id": "test_math"},
                        {"type": "widget", "id": "test_widget"},
                        {"type": "palette", "id": "test_palette"},
                        {"type": "ter_furn_transform", "id": "test_transform"},
                        {"type": "profession_item_substitutions", "id": "test_subst"},
                        {"type": "relic_procgen_data", "id": "test_relic"},
                        {"type": "city_building", "id": "test_building"},
                        {"type": "pp_generator", "id": "test_pp"},
                        {"type": "mod_tileset", "id": "test_tileset"},
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "generic_content_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 7)
            self.assertEqual(len(result.partial), 2)
            self.assertEqual(len(result.todos), 2)
            self.assertIn("local definition = content.MathFunction", main)
            self.assertIn("local definition = content.CityBuilding", main)
            self.assertNotIn("has no native Platform registrar", report)

    def test_reports_unregistered_region_json_content_types(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {"type": "region_settings", "id": "test_region"},
                        {"type": "enchantment", "id": "test_enchantment"},
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "ecosystem_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 1)
            self.assertEqual(len(result.todos), 1)
            self.assertIn("local definition = content.Enchantment", main)
            self.assertNotIn("has no native Platform registrar", report)

    def test_reports_unregistered_final_json_content_types(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {"type": "SPELL", "id": "test_spell"},
                        {"type": "bionic", "id": "test_bionic"},
                        {"type": "faction", "id": "test_faction"},
                        {"type": "mapgen", "id": "test_mapgen"},
                        {"type": "mission_definition", "id": "test_mission_def"},
                        {"type": "mutation", "id": "test_mutation"},
                        {"type": "npc", "id": "test_npc"},
                        {"type": "npc_class", "id": "test_npc_class"},
                        {"type": "overmap_special", "id": "test_om_special"},
                        {"type": "overmap_terrain", "id": "test_om_terrain"},
                        {"type": "profession", "id": "test_profession"},
                        {"type": "talk_topic", "id": "test_talk_topic"},
                        {"type": "vehicle", "id": "test_vehicle"},
                        {"type": "vehicle_part", "id": "test_vehicle_part"},
                        {"type": "vehicle_placement", "id": "test_v_placement"},
                        {"type": "vehicle_spawn", "id": "test_v_spawn"},
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "final_content_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 14)
            self.assertEqual(len(result.partial), 2)
            self.assertEqual(len(result.todos), 2)
            self.assertIn("local definition = content.Spell", main)
            self.assertIn("local definition = content.Vehicle", main)
            self.assertNotIn("has no native Platform registrar", report)

    def test_renders_bounded_mapgen_palette_tileset_and_dialogue_services(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "mapgen",
                            "om_terrain": ["sample_omt"],
                            "object": {
                                "fill_ter": "t_floor",
                                "rows": ["##", ".."],
                                "terrain": {"#": "t_wall", ".": "t_floor"},
                                "furniture": {"#": "f_table"},
                            },
                        },
                        {
                            "type": "palette",
                            "id": "sample_palette",
                            "terrain": {"#": "t_wall"},
                            "furniture": {"#": "f_table"},
                        },
                        {
                            "type": "mod_tileset",
                            "id": "sample_tileset",
                            "compatibility": ["sample_base"],
                            "tiles-new": [
                                {
                                    "file": "sample.png",
                                    "tiles": [{"id": "t_floor", "fg": 1}],
                                }
                            ],
                        },
                        {
                            "type": "talk_topic",
                            "id": "TALK_SAMPLE_LUA",
                            "dynamic_line": {"concatenate": ["Hello", " world"]},
                            "speaker_effect": [
                                {"effect": {"u_bulk_donate": 1}},
                                "quote_vehicle_full_repair",
                            ],
                            "responses": [{
                                "text": "Goodbye",
                                "topic": "TALK_DONE",
                                "effect": "u_bulk_trade_accept",
                            }],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "service_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertIn("services.mapgen.define", main)
            self.assertIn('terrain_ids = { "sample_omt" }', main)
            self.assertIn("services.mapgen.register_palette", main)
            self.assertIn("services.tileset.register", main)
            self.assertIn('file = "sample.png"', main)
            self.assertIn("ccb.dialogue.register_topic", main)
            self.assertIn('dynamic_line = "Hello world"', main)
            self.assertIn('topic = "TALK_DONE"', main)
            self.assertIn("speaker_effects = { function(context)", main)
            self.assertIn("on_select = function(context)", main)
            self.assertIn("services.trade.transfer_matching", main)
            self.assertIn("context:topic_item()", main)
            self.assertIn("services.vehicles.marked_service_vehicle", main)
            self.assertNotIn("has no native Platform registrar", result.files[Path("MIGRATION_REPORT.md")])
            self.assertEqual(result.todos, [])

    def test_translates_bounded_inventory_conditions_to_typed_services(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            conditions = [
                {"u_has_item": "water_clean"},
                {"u_has_items": {"item": "water_clean", "count": 2}},
                {"u_has_item_with_flag": "EATEN_COLD"},
                {"u_has_item_category": "food", "count": 2},
                {"u_has_items_sum": [{"item": "scrap", "amount": 2}]},
                {"u_has_software": {"item": "software_calculator", "charges": 1}},
                {"u_has_worn_with_flag": "WATERPROOF"},
                {"u_has_wielded_with_flag": "DURABLE_MELEE"},
                {"u_has_wielded_with_weapon_category": "WEAPON"},
                {"u_has_wielded_with_skill": "survival"},
                {"u_has_wielded_with_ammotype": "9mm"},
                "has_ammo",
                "is_rotten",
            ]
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": f"inventory_condition_{index}",
                            "required_event": "game_start",
                            "condition": condition,
                            "effect": {"message": "inventory condition"},
                        }
                        for index, condition in enumerate(conditions)
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "inventory_condition_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), len(conditions))
            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn("services.inventory.resources(actor", main)
            self.assertIn("services.inventory.category_count(actor", main)
            self.assertIn("services.inventory.has_items_sum(actor", main)
            self.assertIn("services.inventory.wielded_matches(actor", main)
            self.assertIn("services.items.ammo_sufficient(context.actors.item, actor)", main)
            self.assertIn("relative_rot > 1", main)
            self.assertNotIn("condition needs a native Lua predicate", report)

    def test_inventory_and_world_effects_lower_only_bounded_shapes(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "bounded_world_avatar",
                            "required_event": "game_start",
                            "effect": [
                                {"u_consume_item": "apple"},
                                {"u_consume_item": "battery", "charges": 3},
                                {
                                    "u_consume_item_sum": [
                                        {"item": "scrap", "amount": 2},
                                        {"item": "steel", "amount": 1.5},
                                    ]
                                },
                                {
                                    "u_set_field": "fd_fire",
                                    "radius": 0,
                                    "hit_player": False,
                                },
                                {
                                    "set_terrain": "t_floor",
                                    "location": {"context_val": "loc"},
                                    "radius": 0,
                                },
                                {
                                    "set_furniture": "f_null",
                                    "location": {"context_val": "loc"},
                                    "radius": 0,
                                },
                                {
                                    "mapgen_update": "update_demo",
                                    "target_var": {"context_val": "loc"},
                                },
                                {
                                    "reveal_map": {"context_val": "loc"},
                                    "radius": 3,
                                },
                                {
                                    "revert_location": {"context_val": "loc"},
                                    "time_in_future": "1 turn",
                                },
                                {
                                    "copy_location": {"context_val": "loc"},
                                    "new_loc": {"context_val": "destination"},
                                    "time_in_future": "2 turns",
                                },
                                {
                                    "u_transform_radius": 0,
                                    "ter_furn_transform": "transform_demo",
                                },
                                "player_weapon_drop",
                                {
                                    "set_item_category_spawn_rates": [
                                        {"id": "food", "spawn_rate": 0.5},
                                        {"id": "tools", "spawn_rate": 0.25},
                                    ]
                                },
                            ],
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "bounded_world_npc",
                            "required_event": "npc_becomes_hostile",
                            "effect": [
                                {"npc_consume_item": "water_clean", "count": 1},
                                {
                                    "npc_consume_item_sum": [
                                        {"item": "bandage", "amount": 1}
                                    ]
                                },
                                {
                                    "npc_set_field": "fd_smoke",
                                    "radius": 0,
                                    "hit_player": False,
                                },
                                {
                                    "npc_transform_radius": 1,
                                    "ter_furn_transform": "transform_demo",
                                },
                                "drop_weapon",
                            ],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "world_effect_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn("services.inventory.consume(", main)
            self.assertIn("services.inventory.consume_sum(", main)
            self.assertIn("services.world.put_field(", main)
            self.assertIn("services.world.apply_mapgen_update(", main)
            self.assertIn("services.overmap.reveal(", main)
            self.assertIn("services.world.schedule_location_revert(", main)
            self.assertIn("services.world.schedule_location_copy(", main)
            self.assertIn("services.world.transform_radius(", main)
            self.assertIn("services.inventory.drop_wielded(", main)
            self.assertIn("services.item_categories.set_spawn_rates(", main)

    def test_set_field_preserves_native_hit_player_default(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps([
                    {
                        "type": "effect_on_condition",
                        "id": "set_field_native_default",
                        "required_event": "game_start",
                        "effect": {
                            "u_set_field": "fd_fire",
                            "radius": 0,
                        },
                    }
                ]),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "set_field_default_mod"
            )
            main = result.files[Path("main.lua")]
            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn("services.world.put_field(", main)
            self.assertIn(", true)", main)

    def test_mapgen_update_preserves_multiple_ids_and_native_options(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "mapgen_update_options",
                        "required_event": "game_start",
                        "effect": {
                            "mapgen_update": [
                                "update_one",
                                {"context_val": "update_two"},
                            ],
                            "target_var": {"context_val": "location"},
                            "time_in_future": {"global_val": "delay"},
                            "key": {"context_val": "event_key"},
                            "cancel_on_collision": False,
                            "mirror_horizontal": True,
                            "rotation": 2,
                        },
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "mapgen_options_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertEqual(main.count("services.world.apply_mapgen_update("), 2)
            self.assertIn('services.types.id("update_mapgen", "update_one")', main)
            self.assertIn('tostring((context.data["update_two"])', main)
            self.assertIn('services.variables.get_global("delay")', main)
            self.assertIn('tostring((context.data["event_key"])', main)
            self.assertIn("cancel_on_collision = false", main)
            self.assertIn("mirror_horizontal = true", main)
            self.assertIn("rotation = 2", main)
            self.assertNotIn("mapgen update target", report)

    def test_mapgen_update_searches_terrain_and_applies_omt_offsets(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps({
                    "type": "effect_on_condition",
                    "id": "mapgen_update_search",
                    "required_event": "game_start",
                    "effect": {
                        "mapgen_update": "update_pond",
                        "om_terrain": "island_core",
                        "offset_x": -1,
                        "offset_y": 1,
                    },
                }),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "mapgen_search_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertIn("services.overmap.closest(", main)
            self.assertIn("radius = 540", main)
            self.assertIn(
                "services.coords.tripoint_rel_omt(-1, 1, 0)", main
            )
            self.assertIn("services.world.apply_mapgen_update(", main)

    def test_inventory_lowering_rejects_dynamic_or_out_of_contract_shapes(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "unsafe_inventory",
                            "required_event": "game_start",
                            "condition": {
                                "and": [
                                    {
                                        "u_has_software": {
                                            "item": "software_calculator",
                                            "device": {"context_val": "device"},
                                        }
                                    },
                                    {
                                        "u_has_worn_with_flag": {
                                            "item": "WATERPROOF",
                                        }
                                    },
                                    {
                                        "u_has_items": {
                                            "item": "apple",
                                            "count": 1.5,
                                        }
                                    },
                                ]
                            },
                            "effect": {"message": "must stay partial"},
                        }
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "unsafe_inventory_mod"
            )

            self.assertEqual(result.converted, [])
            self.assertEqual(len(result.partial), 1)
            self.assertIn("condition needs a native Lua predicate", result.files[Path("MIGRATION_REPORT.md")])

    def test_lowers_variable_backed_inventory_consumption(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "dynamic_inventory_consumption",
                        "required_event": "game_start",
                        "effect": [
                            {
                                "u_consume_item": {"context_val": "item_id"},
                                "count": {"global_val": "count"},
                                "charges": {"u_val": "charges"},
                            },
                            {
                                "u_consume_item_sum": [
                                    {
                                        "item": {"context_val": "sum_item"},
                                        "amount": {"global_val": "sum_amount"},
                                    },
                                ],
                            },
                        ],
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "dynamic_inventory_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn('services.types.id("item", tostring((context.data["item_id"])', main)
            self.assertIn('services.variables.get_global("count")', main)
            self.assertIn('services.variables.resolve(context.data, actor, "u", "charges")', main)
            self.assertIn("services.inventory.consume_sum(actor", main)
            self.assertIn('tostring((context.data["sum_item"])', main)
            self.assertNotIn("inventory consumption through", report)

    def test_lowers_variable_backed_pickup_limits_and_positions(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "dynamic_pickup",
                        "required_event": "game_start",
                        "effect": {
                            "u_pickup_items": {"u_val": "pickup_position"},
                            "extra_moves_per_item": {"global_val": "extra_moves"},
                            "max_volume": {"context_val": "volume"},
                            "max_mass": {"u_val": "mass"},
                        },
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "dynamic_pickup_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn("services.activities.pickup_from(", main)
            self.assertIn('services.variables.get(actor, "pickup_position")', main)
            self.assertIn('services.variables.get_global("extra_moves")', main)
            self.assertIn('context.data["volume"]', main)
            self.assertIn('services.variables.resolve(context.data, actor, "u", "mass")', main)
            self.assertNotIn("pickup location and limits", report)

    def test_character_action_effects_lower_for_proven_avatar_and_npc_actors(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "character_actions_avatar",
                            "required_event": "game_start",
                            "effect": [
                                {"u_cast_spell": {"id": "spell_demo", "min_level": 1}},
                                {"u_die": {"remove_corpse": True, "supress_message": True}},
                                {"u_emit": "emit_demo", "chance_mult": 2},
                                {"u_explosion": {"power": 10}},
                                {"u_knockback": 2, "stun": 1},
                                {"u_lose_category": "MUTATION_CATEGORY"},
                                {"u_lose_effect": "effect_demo"},
                                {"u_make_sound": "alarm", "volume": 15, "type": "alarm"},
                                {"u_set_talker": {"u_val": "talker_id"}},
                                {"u_set_trait_purifiability": "TRAIT", "purifiable": False},
                                {"u_spawn_monster": "mon_demo", "real_count": 1, "min_radius": 0, "max_radius": 0, "//": "spawn comment"},
                                {"u_spawn_npc": "npc_template_demo", "real_count": 1, "min_radius": 0, "max_radius": 0},
                                "u_prevent_death",
                            ],
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "character_actions_npc",
                            "required_event": "npc_becomes_hostile",
                            "effect": [
                                {"npc_attack": "technique"},
                                {"u_attack": "technique"},
                                {"npc_cast_spell": {"id": "spell_demo"}},
                                {"u_cast_spell": {"id": "spell_demo"}},
                                {"npc_die": {"remove_corpse": True}},
                                "u_die",
                                {"npc_emit": "emit_demo"},
                                {"u_emit": "emit_demo"},
                                {"npc_explosion": {"power": 5}},
                                {"u_explosion": {"power": 5}},
                                {"npc_knockback": 2},
                                {"u_knockback": 2},
                                {"npc_change_class": "NC_BOUNTY_HUNTER"},
                                {"npc_change_faction": "faction_demo"},
                                {"npc_lose_category": "MUTATION_CATEGORY"},
                                {"npc_lose_effect": "effect_demo"},
                                "npc_make_radio_representative",
                                "npc_thankful",
                                {"npc_make_sound": "warning", "volume": 10, "type": "alert"},
                                {"npc_set_talker": {"npc_val": "talker_id"}},
                                {"npc_set_trait_purifiability": "TRAIT"},
                                {"npc_spawn_monster": "mon_demo", "real_count": 1, "min_radius": 0, "max_radius": 0},
                                {"npc_spawn_npc": "npc_template_demo", "real_count": 1, "min_radius": 0, "max_radius": 0},
                                "npc_prevent_death",
                                "u_ranged_attack",
                                "npc_ranged_attack",
                            ],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "character_action_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn("services.characters.attack(", main)
            self.assertIn("services.characters.cast_spell(", main)
            self.assertIn("services.characters.die(actor, { remove_corpse = true", main)
            self.assertIn("services.characters.explosion(", main)
            self.assertIn("services.characters.knockback(", main)
            self.assertIn("services.characters.ranged_attack(", main)
            self.assertIn("services.mutations.remove_category(", main)
            self.assertIn("services.effects.remove(", main)
            self.assertIn("services.npcs.set_class(", main)
            self.assertIn("services.npcs.set_faction(", main)
            self.assertIn("services.npcs.set_radio_representative(", main)
            self.assertIn("services.npcs.make_thankful(", main)
            self.assertIn("services.sound.emit(", main)
            self.assertIn("services.variables.set(", main)
            self.assertIn("services.mutations.set_purifiable(", main)
            self.assertIn("services.spawns.monster_configured(", main)
            self.assertIn("services.spawns.npc(", main)

    def test_lowers_variable_backed_combat_attack_and_knockback_options(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "dynamic_combat_options",
                        "required_event": "npc_becomes_hostile",
                        "effect": [
                            {
                                "npc_attack": {"context_val": "technique"},
                                "forced_movecost": {"global_val": "move_cost"},
                                "allow_special": False,
                            },
                            {
                                "npc_knockback": {"context_val": "force"},
                                "stun": {"npc_val": "stun"},
                                "dam_mult": {"global_val": "damage"},
                            },
                        ],
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "dynamic_combat_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn('tostring((context.data["technique"])', main)
            self.assertIn('services.variables.get_global("move_cost")', main)
            self.assertIn('context.data["force"]', main)
            self.assertIn('services.variables.resolve(context.data, actor, "npc", "stun")', main)
            self.assertIn('services.variables.get_global("damage")', main)
            self.assertIn("allow_special = false", main)
            self.assertNotIn("combat effect", report)

    def test_lowers_dynamic_combat_damage_options(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "dynamic_combat_damage",
                        "required_event": "game_start",
                        "effect": {
                            "u_deal_damage": {"context_val": "damage_type"},
                            "amount": {"math": ["u_damage_amount"]},
                            "bodypart": {"context_val": "body_part"},
                            "arpen": {"global_val": "armor_penetration"},
                            "min_hit": {"context_val": "min_hit"},
                            "max_hit": {"context_val": "max_hit"},
                        },
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "dynamic_damage_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn("services.characters.damage(", main)
            self.assertIn('services.types.id("damage_type"', main)
            self.assertIn("math.max(-1e+06, math.min(1e+06", main)
            self.assertIn("math.max(-1, math.min(1e+06", main)
            self.assertNotIn("damage amount/options", report)

    def test_lowers_dynamic_cast_spell_levels_with_bounded_expressions(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "dynamic_cast_spell_levels",
                        "required_event": "game_start",
                        "effect": {
                            "u_cast_spell": {
                                "id": "spell_demo",
                                "min_level": {"math": ["u_spell_level"]},
                                "max_level": {"context_val": "spell_max"},
                            }
                        },
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "dynamic_cast_spell_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn("min_level = math.max(0, math.min(1000", main)
            self.assertIn("max_level = math.max(-1, math.min(1000", main)
            self.assertNotIn("cast spell", report)

    def test_rejects_literal_cast_spell_level_ordering(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "invalid_cast_spell_levels",
                        "required_event": "game_start",
                        "effect": {
                            "u_cast_spell": {
                                "id": "spell_demo",
                                "min_level": 5,
                                "max_level": 2,
                            }
                        },
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "invalid_cast_spell_mod"
            )
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(result.converted, [])
            self.assertEqual(len(result.partial), 1)
            self.assertIn("needs domain-service conversion", report)

    def test_reuses_typed_renderers_inside_conditional_branches(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "conditional_typed_branches",
                        "required_event": "game_start",
                        "effect": [
                            {
                                "if": {"compare_string": ["yes", "yes"]},
                                "then": {
                                    "open_dialogue": {"topic": "TALK_TEST"}
                                },
                            },
                            {
                                "if": "u_is_outside",
                                "then": {
                                    "give_achievement": "achievement_demo"
                                },
                            },
                            {
                                "if": "u_is_outside",
                                "then": {
                                    "set_string_var": "yes",
                                    "target_var": {"context_val": "branch_value"},
                                },
                            },
                            {
                                "if": "u_is_outside",
                                "then": {
                                    "u_deal_damage": "pure",
                                    "amount": 10,
                                    "bodypart": "torso",
                                },
                            },
                            {
                                "if": "u_is_outside",
                                "then": "nothing",
                                "else": {
                                    "u_teleport": {"context_val": "return_to"}
                                },
                            },
                        ],
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "conditional_typed_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertGreaterEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn("services.dialogue.open_topic(\"TALK_TEST\")", main)
            self.assertIn("services.achievements.complete(", main)
            self.assertIn('context.data["branch_value"]', main)
            self.assertIn('services.characters.damage(\n        actor', main)
            self.assertNotIn("conditional-control-flow conversion", report)

    def test_lowers_variable_backed_explosion_parameters(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "dynamic_explosion",
                        "required_event": "game_start",
                        "effect": {
                            "u_explosion": {
                                "power": {"context_val": "power"},
                                "distance_factor": {"global_val": "distance"},
                                "max_noise": {"u_val": "noise"},
                                "shrapnel": {
                                    "casing_mass": {"context_val": "casing"},
                                    "fragment_mass": {"global_val": "fragment"},
                                    "recovery": {"u_val": "recovery"},
                                },
                            },
                            "flashbang_radius": {"context_val": "radius"},
                        },
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "dynamic_explosion_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn('context.data["power"]', main)
            self.assertIn('services.variables.get_global("distance")', main)
            self.assertIn('services.variables.resolve(context.data, actor, "u", "noise")', main)
            self.assertIn('context.data["casing"]', main)
            self.assertIn('services.variables.get_global("fragment")', main)
            self.assertIn('services.variables.resolve(context.data, actor, "u", "recovery")', main)
            self.assertIn('context.data["radius"]', main)
            self.assertNotIn("combat effect", report)

    def test_lowers_variable_backed_non_popup_messages(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "dynamic_messages",
                        "required_event": "game_start",
                        "effect": [
                            {"message": {"context_val": "message_text"}},
                            {"u_message": {"global_val": "avatar_message"}, "type": "neutral"},
                        ],
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "dynamic_message_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn('services.message(tostring((context.data["message_text"])', main)
            self.assertIn('services.variables.get_global("avatar_message")', main)
            self.assertNotIn("message presentation options", report)

    def test_u_message_without_event_reacquires_avatar(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "unbound_u_message",
                            "effect": {"u_message": "avatar message", "type": "info"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "unbound_u_message_owner",
                            "required_event": "game_start",
                            "effect": {"run_eocs": "unbound_u_message"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "unbound_message_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(result.partial, [])
            self.assertIn('services.messages.add("avatar message", "info")', main)
            self.assertNotIn("message presentation options", main)

    def test_native_popup_flag_aliases_use_typed_presentation(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "popup_alias",
                        "required_event": "game_start",
                        "effect": {
                            "u_message": "on top",
                            "popup": True,
                            "popup_flag": "PF_ON_TOP",
                        },
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "popup_alias_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn('ccb.presentation.notice_top("on top")', main)

    def test_opposite_actor_visibility_conditions_require_npc_event_proof(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "visibility_npc",
                            "required_event": "npc_becomes_hostile",
                            "condition": {"and": ["npc_see_u", "u_see_npc"]},
                            "effect": {"message": "visible"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "visibility_unproven",
                            "required_event": "game_start",
                            "condition": "npc_see_u",
                            "effect": {"message": "must stay partial"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "visibility_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 1)
            self.assertIn("services.creatures.can_see(actor", main)
            self.assertIn("services.characters.avatar(), actor", main)
            self.assertIn("EOC visibility_unproven condition needs a native Lua predicate", report)

    def test_overmap_location_conditions_use_typed_overmap_matching(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "avatar_omt",
                            "required_event": "game_start",
                            "condition": {"u_at_om_location": "field"},
                            "effect": {"message": "avatar"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_omt",
                            "required_event": "npc_becomes_hostile",
                            "condition": {"npc_at_om_location": "forest"},
                            "effect": {"message": "npc"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "point_omt",
                            "required_event": "game_start",
                            "condition": {
                                "overmap_at_point": "field",
                                "point": {"context_val": "point"},
                            },
                            "effect": {"message": "point"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "overmap_condition_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(len(result.converted), 3)
            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertEqual(main.count("services.overmap.matches("), 3)
            self.assertIn('services.coords.project_to(context.data["point"], "omt")', main)

    def test_visibility_and_location_conditions_use_typed_character_services(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "avatar_location_visibility",
                            "required_event": "game_start",
                            "condition": {
                                "u_can_see_location": {"context_val": "point"}
                            },
                            "effect": {"message": "avatar"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_location_visibility",
                            "required_event": "npc_becomes_hostile",
                            "condition": {
                                "and": [
                                    {"npc_can_see_location": {"context_val": "point"}},
                                    {"npc_has_visible_trait": "TRAIT"},
                                    {"u_has_visible_trait": "TRAIT"},
                                ]
                            },
                            "effect": {"message": "npc"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "visibility_service_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn("services.characters.can_see_location(", main)
            self.assertIn("services.mutations.is_visible_to(", main)

    def test_npc_population_and_overmap_proximity_conditions_use_typed_services(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "population_avatar",
                            "required_event": "game_start",
                            "condition": {
                                "and": [
                                    {"npc_allies": 1},
                                    {"npc_allies_global": 1},
                                    {"u_service": 0},
                                    {"u_near_om_location": "field", "range": 2},
                                ]
                            },
                            "effect": {"message": "avatar"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "population_npc",
                            "required_event": "npc_becomes_hostile",
                            "condition": {
                                "and": [
                                    {"npc_role_nearby": "scout", "range": 5},
                                    {"npc_service": 0},
                                    {"npc_has_items_sum": [{"item": "scrap", "amount": 1}]},
                                    {"npc_near_om_location": "forest", "range": 2},
                                ]
                            },
                            "effect": {"message": "npc"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "population_condition_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn("services.npcs.count_allies(false)", main)
            self.assertIn("services.npcs.count_allies(true)", main)
            self.assertIn("services.npcs.has_role_nearby(actor", main)
            self.assertIn("services.overmap.search(", main)
            self.assertIn(".activity.active", main)

    def test_translates_batch_28_primitive_to_bounded_selectors(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "eoc_batch_28",
                            "required_event": "game_start",
                            "condition": {
                                "and": [
                                    "npc_has_activity",
                                    "line_of_sight",
                                    {"expects_vars": ["test_var"]},
                                    {"math": ["1 == 1"]},
                                ]
                            },
                            "effect": [
                                {"u_assign_activity": "ACT_WAIT"},
                                {"npc_assign_activity": "ACT_WAIT"},
                                {"math": ["x = 1"]},
                                {"copy_var": "var_a"},
                                {"add_debt": 10},
                                {"set_string_var": "str_var"},
                                {"alter_timed_events": "event"},
                                "lightning",
                                "next_weather",
                                {"mirror_coordinates": [0, 0]},
                                {"sample_range": [1, 10]},
                                {"dimension_name": "nether"},
                                {"u_add_faction_trust": 5},
                                {"u_set_fac_relation": "ally"},
                                {"npc_set_fac_relation": "ally"},
                                {"closest_city": "center"},
                                "take_control_menu",
                            ],
                        }
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "batch_28_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 0)
            self.assertEqual(len(result.partial), 1)
            self.assertEqual(len(result.todos), 13)
            self.assertNotIn("services.activities.assign(actor)", main)
            self.assertIn("plain typed activity service", main)
            self.assertNotIn("services.state.", main)
            self.assertNotIn('services.characters.adjust(actor, "debt")', main)
            self.assertIn(
                'services.time.reschedule(\n'
                '        "event", services.time.duration(0, "turn"))',
                main,
            )
            self.assertIn("services.gameplay.math.apply", main)
            self.assertIn("copy_var into typed variable services", main)
            self.assertIn("add_debt through a bounded NPC opinion/debt service", main)
            self.assertIn("set_string_var into typed variable services", main)
            self.assertNotIn("alter_timed_events into a persistent-task operation", main)
            self.assertIn("typed city query and writable location variable", main)
            self.assertIn("services.weather.activate_lightning()", main)
            self.assertIn("services.weather.refresh()", main)
            self.assertNotIn("services.coords.mirror", main)
            self.assertNotIn("services.random.sample()", main)
            self.assertNotIn("services.gameplay.environment.dimension_name", main)
            self.assertNotIn("services.factions.adjust_trust", main)
            self.assertNotIn("services.factions.set_relation", main)
            self.assertNotIn("services.overmap.closest_city", main)
            self.assertNotIn('context.data["test_var"] ~= nil', main)
            self.assertNotIn("1 == 1", main)
            self.assertIn("condition needs a native Lua predicate", report)
            self.assertNotIn("needs review", report)

    def test_renders_bounded_closest_city_for_actor_location_var(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "closest_city_shapes",
                            "required_event": "game_start",
                            "effect": [
                                {
                                    "closest_city": {"u_val": "center"},
                                    "known": False,
                                },
                                {"closest_city": {"context_val": "dynamic"}},
                                {"closest_city": {"npc_val": "npc_center"}},
                            ],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "closest_city_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(result.converted, [])
            self.assertEqual(len(result.partial), 1)
            self.assertEqual(len(result.todos), 2)
            self.assertIn("services.overmap.closest_city", main)
            self.assertIn('city.value.position', main)
            self.assertIn('context.data["city_name"]', main)
            self.assertIn("typed city query and writable location variable", main)
            self.assertIn("needs domain-service conversion", report)

    def test_renders_bounded_transform_line_for_actor_coordinates(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "transform_line_shapes",
                            "required_event": "game_start",
                            "effect": [
                                {
                                    "transform_line": "transform_test",
                                    "first": {"u_val": "line_a"},
                                    "second": {"u_val": "line_b"},
                                },
                                {
                                    "transform_line": "transform_test",
                                    "first": {"context_val": "line_a"},
                                    "second": {"context_val": "line_b"},
                                },
                            ],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "transform_line_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn("services.world.transform_line", main)
            self.assertIn('services.types.id("ter_furn_transform", "transform_test")', main)
            self.assertIn('local first = context.data["line_a"]', main)
            self.assertNotIn("needs domain-service conversion", report)

    def test_renders_literal_dimension_name_for_proven_character(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "dimension_name_shapes",
                            "required_event": "game_start",
                            "effect": [
                                {"dimension_name": {"u_val": "current_dimension"}},
                                {"dimension_name": {"context_val": "dynamic_target"}},
                                {"dimension_name": {"npc_val": "npc_dimension"}},
                            ],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "dimension_name_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 0)
            self.assertEqual(len(result.partial), 1)
            self.assertIn(
                'services.variables.set(\n'
                '        actor, "current_dimension", '
                'services.gameplay.environment.dimension())',
                main,
            )
            self.assertIn(
                'context.data["dynamic_target"] = '
                'services.gameplay.environment.dimension()',
                main,
            )
            self.assertEqual(main.count("TODO: translate dimension_name"), 1)
            self.assertIn("needs domain-service conversion", report)

    def test_renders_literal_mirror_coordinates_for_same_scope_variables(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "mirror_coordinate_shapes",
                            "required_event": "game_start",
                            "effect": [
                                {
                                    "mirror_coordinates": {"u_val": "output"},
                                    "center_var": {"u_val": "center"},
                                    "relative_var": {"u_val": "relative"},
                                },
                                {
                                    "mirror_coordinates": {"u_val": "mixed"},
                                    "center_var": {"npc_val": "center"},
                                    "relative_var": {"u_val": "relative"},
                                },
                                {
                                    "mirror_coordinates": {"u_val": "dynamic"},
                                    "center_var": {"context_val": "center"},
                                    "relative_var": {"u_val": "relative"},
                                },
                            ],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "mirror_coordinates_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 0)
            self.assertEqual(len(result.partial), 1)
            self.assertIn(
                'local center_result = services.variables.get(\n'
                '        actor, "center")',
                main,
            )
            self.assertIn(
                'actor, "output", center:scale_by(2):subtract(relative))',
                main,
            )
            self.assertEqual(main.count("TODO: translate mirror_coordinates"), 2)
            self.assertIn("needs domain-service conversion", report)

    def test_translates_literal_line_of_sight_condition(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "literal_line_of_sight",
                            "required_event": "game_start",
                            "condition": {
                                "line_of_sight": 12,
                                "loc_1": {"context_val": "origin"},
                                "loc_2": {"context_val": "target"},
                                "with_fields": False,
                            },
                            "effect": {"message": "visible"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "dynamic_line_of_sight",
                            "required_event": "game_start",
                            "condition": {
                                "line_of_sight": {"context_val": "range"},
                                "loc_1": {"context_val": "origin"},
                                "loc_2": {"context_val": "target"},
                            },
                            "effect": {"message": "must stay partial"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "line_of_sight_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 1)
            self.assertIn(
                "services.gameplay.environment.line_of_sight("
                "context.data[\"origin\"], context.data[\"target\"], 12, false)",
                main,
            )
            self.assertIn("EOC dynamic_line_of_sight condition needs a native Lua predicate", report)
            self.assertNotIn("run_eoc", main)

    def test_translates_batch_29_primitive_to_bounded_selectors(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "eoc_batch_29",
                            "required_event": "game_start",
                            "condition": {
                                "and": [
                                    "npc_at_om_location",
                                    "npc_can_see_location",
                                    "npc_near_om_location",
                                    "overmap_at_point",
                                    "u_at_om_location",
                                    "u_can_see_location",
                                    "mission_goal",
                                    "mission_has_generic_rewards",
                                    "npc_mission_goal",
                                ]
                            },
                            "effect": [
                                {"add_mission": "mission_1"},
                                {"basecamp_mission": "mission_2"},
                                {"clear_mission": "mission_3"},
                                {"companion_mission": "mission_4"},
                                {"finish_mission": "mission_5"},
                                {"mission_failure": "mission_6"},
                                {"assign_mission": "mission_7"},
                                "abandon_camp",
                                {"assign_camp": "camp_1"},
                                "return_to_camp_duties",
                                "start_camp",
                                "bionic_install",
                                "bionic_install_allies",
                                "bionic_remove",
                                "bionic_remove_allies",
                                "repair_bionic_limbs",
                                "quote_vehicle_full_repair",
                                "select_vehicle_part_service",
                                "start_vehicle_full_repair",
                                {"npc_run_vehicle_eocs": "eoc_1"},
                                {"u_run_vehicle_eocs": "eoc_2"},
                                {"copy_location": "loc_1"},
                                {"location_variable_adjust": "loc_2"},
                                "mapgen_update",
                                {"npc_location_variable": "var_1"},
                                "npc_map_run_eocs",
                                {"npc_set_field": "field_1"},
                            ],
                        }
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "batch_29_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 0)
            self.assertEqual(len(result.partial), 1)
            self.assertIn("services.missions.reserve", main)
            self.assertIn("services.missions.assign", main)
            self.assertNotIn("services.camps.", main)
            self.assertNotIn("services.bionics.adjust", main)
            self.assertNotIn("services.vehicles.", main)
            self.assertNotIn("services.map.", main)
            self.assertIn("no placeholder call is emitted", main)
            self.assertIn("needs domain-service conversion", report)

    def test_bounded_npc_faction_effects_use_typed_character_services(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "npc_faction_trust",
                            "required_event": "npc_becomes_hostile",
                            "effect": {"u_add_faction_trust": 5},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_faction_relation",
                            "required_event": "npc_becomes_hostile",
                            "effect": {
                                "npc_set_fac_relation": "knows your voice",
                                "set_value_to": False,
                            },
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "npc_faction_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(result.partial, [])
            self.assertIn(
                "services.characters.add_faction_trust(\n        actor, 5)",
                main,
            )
            self.assertIn(
                "services.characters.set_faction_relationship(\n"
                "        actor, services.characters.avatar(),\n"
                '        "knows your voice", false)',
                main,
            )
            self.assertNotIn("needs domain-service conversion", report)

    def test_dynamic_npc_faction_trust_is_bounded_and_relation_stays_partial(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "dynamic_npc_faction_trust",
                            "required_event": "npc_becomes_hostile",
                            "effect": {
                                "u_add_faction_trust": {"context_val": "delta"}
                            },
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "invalid_npc_faction_relation",
                            "required_event": "npc_becomes_hostile",
                            "effect": {"npc_set_fac_relation": "ally"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "unsafe_npc_faction_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 1)
            self.assertEqual(len(result.todos), 1)
            self.assertIn("services.characters.add_faction_trust(", main)
            self.assertNotIn("set_faction_relationship(\n        actor", main)
            self.assertIn("typed character-faction service", main)
            self.assertIn("needs domain-service conversion", report)

    def test_bounded_u_faction_relation_uses_avatar_and_npc_handles(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "u_faction_relation",
                            "required_event": "npc_becomes_hostile",
                            "effect": {
                                "u_set_fac_relation": "knows your voice",
                                "set_value_to": True,
                            },
                        }
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "u_faction_mod"
            )
            main = result.files[Path("main.lua")]
            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertIn(
                "services.characters.set_faction_relationship(\n"
                "        services.characters.avatar(), actor,\n"
                '        "knows your voice", true)',
                main,
            )

    def test_static_sample_range_uses_bounded_random_and_variable_services(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "static_sample_range",
                            "required_event": "game_start",
                            "effect": {
                                "sample_range": {
                                    "count": 2,
                                    "min": 3,
                                    "max": 9,
                                    "target_vars": [
                                        {"u_val": "roll_a"},
                                        {"u_val": "roll_b"},
                                    ],
                                }
                            },
                        }
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "sample_range_mod"
            )
            main = result.files[Path("main.lua")]
            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertIn(
                "services.random.sample_integers(3, 9, 2, false)", main
            )
            self.assertIn(
                'services.variables.set(\n        actor, "roll_a", samples[1])',
                main,
            )
            self.assertIn(
                'services.variables.set(\n        actor, "roll_b", samples[2])',
                main,
            )

    def test_dynamic_sample_range_clamps_runtime_bounds(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "dynamic_sample_range",
                        "required_event": "game_start",
                        "effect": {
                            "sample_range": {
                                "count": {"context_val": "count"},
                                "min": {"context_val": "minimum"},
                                "max": {"context_val": "maximum"},
                                "target_vars": [{"u_val": "roll"}],
                            }
                        },
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "dynamic_sample_mod"
            )
            main = result.files[Path("main.lua")]
            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertIn("local sample_count =", main)
            self.assertIn("local sample_minimum =", main)
            self.assertIn("local sample_maximum =", main)
            self.assertIn("math.min(1000000000", main)
            self.assertIn("services.random.sample_integers(", main)

    def test_translates_batch_30_primitive_to_bounded_selectors(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "eoc_batch_30_u",
                            "required_event": "game_start",
                            "condition": {
                                "and": [
                                    {"u_has_item": "id2"},
                                    {"u_has_item_category": "tools"},
                                    {"u_has_item_with_flag": "FIRE"},
                                    {"u_has_items": ["bandage"]},
                                    {"u_has_items_sum": ["bandage", "splint"]},
                                    {"u_has_wielded_with_ammotype": "45"},
                                    {"u_has_wielded_with_skill": "rifle"},
                                    {"u_has_wielded_with_weapon_category": "swords"},
                                    "u_near_om_location",
                                ]
                            },
                            "effect": [
                                "drop_stolen_item",
                                "drop_weapon",
                                "give_equipment",
                                "mission_reward",
                                "mission_success",
                                "offer_mission",
                                "player_weapon_drop",
                                "remove_active_mission",
                                "reveal_map",
                                "revert_location",
                                "set_furniture",
                                {"set_item_category_spawn_rates": "rate"},
                                "set_terrain",
                                {"u_buy_item": "item_x"},
                                {"u_consume_item": "apple"},
                                {"u_consume_item_sum": "juice"},
                                {"u_location_variable": "var_y"},
                                "u_map_run_eocs",
                                {"u_map_run_item_eocs": "eoc_b"},
                                {"u_pickup_items": "loot"},
                                {"u_remove_item_with": "flag"},
                                {"u_sell_item": "gold"},
                                {"u_set_field": "fire"},
                            ],
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "eoc_batch_30_npc",
                            "required_event": "npc_becomes_hostile",
                            "condition": {
                                "and": [
                                    {"npc_has_item": "id1"},
                                    {"npc_has_item_category": "food"},
                                    {"npc_has_item_with_flag": "HOT"},
                                    {"npc_has_items": ["item1"]},
                                    {"npc_has_items_sum": ["item1", "item2"]},
                                    {"npc_has_wielded_with_ammotype": "9mm"},
                                    {"npc_has_wielded_with_skill": "pistol"},
                                    {"npc_has_wielded_with_weapon_category": "knives"},
                                ]
                            },
                            "effect": [
                                {"npc_consume_item": "food"},
                                {"npc_consume_item_sum": "water"},
                                {"npc_gets_item": "gun"},
                                {"npc_gets_item_to_use": "knife"},
                                {"npc_map_run_item_eocs": "eoc_a"},
                                {"npc_pickup_items": "items"},
                                {"npc_remove_item_with": "flag"},
                                {"quote_npc_trade_item": "coin"},
                            ],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "batch_30_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 0)
            self.assertEqual(len(result.partial), 2)
            self.assertNotIn("services.items.adjust", main)
            self.assertNotIn("services.items.drop", main)
            self.assertNotIn("services.missions.adjust", main)
            self.assertNotIn("services.map.", main)
            self.assertIn("no placeholder call is emitted", main)
            self.assertIn("needs domain-service conversion", report)

    def test_translates_batch_31_primitive_to_bounded_selectors(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "eoc_batch_31_u",
                            "required_event": "game_start",
                            "condition": {
                                "and": [
                                    {"u_has_any_effect": ["eff1"]},
                                    {"u_has_effect": "eff2"},
                                    {"u_has_faction_trust": 5},
                                    {"u_has_part_temp": "arm_l"},
                                    {"u_has_software": "soft1"},
                                    {"u_has_visible_trait": "trait1"},
                                    {"u_has_worn_with_flag": "FLAG1"},
                                    {"u_monsters_in_direction": "north"},
                                    {"u_query": "query1"},
                                    "u_see_npc",
                                    "u_see_npc_loc",
                                    {"u_service": "srv1"},
                                ]
                            },
                            "effect": [
                                {"u_attack": "tec_none"},
                                "u_bulk_donate",
                                "u_bulk_trade_accept",
                                {"u_buy_monster": "m1"},
                                {"u_cast_spell": {"id": "spell_id", "min_level": 1}},
                                {"u_choose_adjacent_highlight": "hi1"},
                                {"u_die": {"remove_corpse": True, "supress_message": True}},
                                {"u_emit": "emit_id", "chance_mult": 2},
                                {"u_explosion": {"power": 10, "distance_factor": 0.75}},
                                {"u_faction_rep": 2},
                                {"u_knockback": 3, "stun": 2},
                                {"u_level_spell_class": "cl1"},
                                {"u_lose_category": "cat1"},
                                "u_make_radio_representative",
                                {"u_make_sound": "snd1"},
                                {"u_mutate": "mut1"},
                                {"u_mutate_category": "mutcat1"},
                                {"u_mutate_towards": "muttow1"},
                                "u_prevent_death",
                                {"u_query_omt": "omt1"},
                                {"u_query_tile": "tile1"},
                                "u_ranged_attack",
                                {"u_recalculate_enchantment_cache": True},
                                {"u_roll_remainder": "rem1"},
                                {"u_run_fixed_zone_eocs": "z1"},
                                {"u_run_inv_eocs": "inv1"},
                                {"u_run_monster_eocs": "mon1"},
                                {"u_run_npc_eocs": "npc1"},
                                "u_set_talker",
                                {"u_set_trait_purifiability": "trait1"},
                                {"u_spawn_monster": "mon2"},
                                {"u_spawn_npc": "npc2"},
                                {"u_spend_cash": 100},
                                {"u_transform_radius": 5},
                            ],
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "eoc_batch_31_npc",
                            "required_event": "npc_becomes_hostile",
                            "condition": {
                                "and": [
                                    "npc_allies",
                                    "npc_allies_global",
                                    {"npc_has_any_effect": ["eff1"]},
                                    {"npc_has_effect": "eff2"},
                                    {"npc_has_move_mode": "crouch"},
                                    {"npc_has_part_temp": "arm_r"},
                                    {"npc_has_software": "soft2"},
                                    {"npc_has_visible_trait": "trait2"},
                                    {"npc_has_worn_with_flag": "FLAG2"},
                                    {"npc_query": "q2"},
                                    "npc_role_nearby",
                                    "npc_see_u",
                                    "npc_see_u_loc",
                                    {"npc_service": "srv2"},
                                ]
                            },
                            "effect": [
                                "clear_npc_rule",
                                "copy_npc_rules",
                                "give_aid",
                                {"npc_attack": "tec_none"},
                                "npc_bulk_donate",
                                "npc_bulk_trade_accept",
                                {"npc_cast_spell": {"id": "spell_id", "min_level": 1}},
                                {"npc_change_class": "nc1"},
                                {"npc_change_faction": "nf1"},
                                {"npc_choose_adjacent_highlight": "nhi1"},
                                {"npc_die": {"remove_corpse": True, "supress_message": True}},
                                {"npc_emit": "emit_id", "chance_mult": 2},
                                {"npc_explosion": {"power": 5, "distance_factor": 0.75}},
                                "npc_first_topic",
                                {"npc_knockback": 2, "stun": 2},
                                {"npc_level_spell_class": "ncl1"},
                                {"npc_lose_category": "ncat1"},
                                {"npc_lose_effect": "neff1"},
                                "npc_make_radio_representative",
                                {"npc_make_sound": "nsnd1"},
                                {"npc_mutate": "nmut1"},
                                {"npc_mutate_category": "nmutcat1"},
                                {"npc_mutate_towards": "nmuttow1"},
                                "npc_prevent_death",
                                {"npc_query_omt": "nomt1"},
                                {"npc_query_tile": "ntile1"},
                                "npc_ranged_attack",
                                {"npc_recalculate_enchantment_cache": True},
                                {"npc_roll_remainder": "nrem1"},
                                "npc_rules_menu",
                                {"npc_run_fixed_zone_eocs": "nz1"},
                                {"npc_run_inv_eocs": "ninv1"},
                                {"npc_run_monster_eocs": "nmon1"},
                                {"npc_run_npc_eocs": "nnpc1"},
                                "npc_set_talker",
                                {"npc_set_trait_purifiability": "ntrait1"},
                                {"npc_spawn_monster": "nmon2"},
                                {"npc_spawn_npc": "nnpc2"},
                                "npc_thankful",
                                {"npc_transform_radius": 3},
                                {"set_npc_aim_rule": "aim1"},
                                {"set_npc_cbm_recharge_rule": "cbm1"},
                                {"set_npc_cbm_reserve_rule": "cbm2"},
                                {"set_npc_engagement_rule": "eng1"},
                                {"set_npc_pickup": "pick1"},
                                {"set_npc_rule": "rule1"},
                                "start_training_npc",
                                "toggle_npc_rule",
                            ],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "batch_31_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 0)
            self.assertEqual(len(result.partial), 2)
            self.assertNotIn("services.characters.adjust(actor)", main)
            self.assertIn("no placeholder call is emitted", main)
            self.assertIn("needs domain-service conversion", report)

    def test_translates_static_coordinate_and_targeting_effects(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "static_coordinate_adjust",
                            "required_event": "game_start",
                            "effect": {
                                "location_variable_adjust": {"u_val": "origin"},
                                "x_adjust": 2,
                                "y_adjust": -1,
                                "z_adjust": 1,
                                "output_var": {"u_val": "target"},
                            },
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "static_location_variable",
                            "required_event": "game_start",
                            "effect": {
                                "u_location_variable": {"u_val": "picked"},
                                "x_adjust": 1,
                                "z_adjust": -2,
                            },
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "static_npc_location_variable",
                            "required_event": "npc_becomes_hostile",
                            "effect": {
                                "npc_location_variable": {"npc_val": "npc_loc"},
                                "x_adjust": -1,
                            },
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "static_npc_query_tile_noop",
                            "required_event": "npc_becomes_hostile",
                            "effect": {
                                "npc_query_tile": "anywhere",
                                "target_var": {"npc_val": "unused_tile"},
                            },
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "static_npc_query_omt_noop",
                            "required_event": "npc_becomes_hostile",
                            "effect": {
                                "npc_query_omt": {"npc_val": "unused_omt"},
                                "message": "unused",
                            },
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "static_query_tile",
                            "required_event": "game_start",
                            "effect": {
                                "u_query_tile": "anywhere",
                                "target_var": {"u_val": "tile"},
                                "message": "Pick a tile",
                                "center_var": {"context_val": "center"},
                            },
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "static_query_omt",
                            "required_event": "game_start",
                            "effect": {
                                "u_query_omt": {"u_val": "omt"},
                                "message": "Pick an overmap tile",
                                "distance_limit": 12,
                            },
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "static_query_line_of_sight",
                            "required_event": "game_start",
                            "effect": {
                                "u_query_tile": "line_of_sight",
                                "target_var": {"u_val": "los"},
                                "message": "Pick a visible tile",
                                "range": 20,
                            },
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "static_adjacent",
                            "required_event": "game_start",
                            "effect": {
                                "u_choose_adjacent_highlight": {"u_val": "adjacent"},
                                "message": "Pick an adjacent tile",
                                "condition": True,
                                "allow_vertical": True,
                            },
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "static_npc_adjacent",
                            "required_event": "npc_becomes_hostile",
                            "effect": {
                                "npc_choose_adjacent_highlight": {"npc_val": "adjacent"},
                                "message": "Pick near NPC",
                                "failure_message": "No adjacent tile",
                                "condition": True,
                            },
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "static_coordinate_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 10)
            self.assertEqual(result.partial, [])
            self.assertIn(
                'services.variables.get(actor, "origin"))',
                main,
            )
            self.assertIn(
                'services.coords.tripoint_rel_ms(math.max(-1000000',
                main,
            )
            self.assertIn(
                'services.targeting.choose_map_square("Pick a tile", '
                'context.data["center"], false)',
                main,
            )
            self.assertIn(
                'services.targeting.choose_overmap_point('
                '"Pick an overmap tile", nil, 12)',
                main,
            )
            self.assertIn("services.random.real(11, 13)", main)
            self.assertIn(
                'services.targeting.choose_visible_map_square("Pick a visible tile", 20)',
                main,
            )
            self.assertIn(
                'services.targeting.choose_adjacent("Pick an adjacent tile", true)',
                main,
            )
            self.assertIn(
                "services.targeting.choose_adjacent_where_at(",
                main,
            )
            self.assertIn(
                'center, "Pick near NPC", "No adjacent tile"',
                main,
            )
            self.assertNotIn("needs domain-service conversion", report)

    def test_dynamic_coordinate_and_targeting_effects_remain_fail_closed(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "dynamic_coordinate_adjust",
                            "required_event": "game_start",
                            "effect": {
                                "location_variable_adjust": {"context_val": "origin"},
                                "x_adjust": {"context_val": "delta"},
                            },
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "dynamic_query_omt",
                            "required_event": "game_start",
                            "effect": {
                                "u_query_omt": {"context_val": "output"},
                                "spread": 1,
                            },
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "conditional_adjacent",
                            "required_event": "game_start",
                            "effect": {
                                "u_choose_adjacent_highlight": {"u_val": "adjacent"},
                                "condition": {"u_has_activity": "ACT"},
                            },
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "dynamic_coordinate_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(len(result.partial), 1)
            self.assertEqual(len(result.todos), 1)
            self.assertIn("dynamic_coordinate_adjust", result.converted[0])
            self.assertNotIn("services.targeting.choose_overmap_point", main)
            self.assertIn("services.targeting.choose_adjacent_where_at", main)
            self.assertIn("services.activities.snapshot(actor)", main)
            self.assertNotIn("typed coordinate variables", main)
            self.assertIn("typed targeting service", main)
            self.assertIn("needs domain-service conversion", report)

    def test_lowers_dynamic_line_of_sight_query_range(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "dynamic_query_tile_range",
                        "required_event": "game_start",
                        "effect": {
                            "u_query_tile": "line_of_sight",
                            "target_var": {"context_val": "picked"},
                            "message": "Pick a visible tile",
                            "range": {"math": ["u_spell_level('demo') + 3"]},
                        },
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "dynamic_query_tile_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn(
                'services.targeting.choose_visible_map_square("Pick a visible tile", '
                "math.max(0, math.min(1000",
                main,
            )
            self.assertNotIn("typed targeting service", report)

    def test_lowers_context_backed_location_variable_adjustments_for_proven_actors(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "dynamic_location_from_context",
                            "required_event": "game_start",
                            "effect": {
                                "u_location_variable": {"context_val": "picked"},
                                "x_adjust": {"context_val": "dx"},
                                "y_adjust": {"global_val": "dy"},
                                "z_adjust": {"u_val": "dz"},
                                "z_override": True,
                            },
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "dynamic_location_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn('tonumber((context.data["dx"]) or 0)', main)
            self.assertIn('services.variables.get_global("dy")', main)
            self.assertIn('services.variables.resolve(context.data, actor, "u", "dz")', main)
            self.assertIn("tripoint_abs_ms(location.x, location.y", main)
            self.assertNotIn("needs domain-service conversion", report)

    def test_lowers_var_indirected_coordinate_writes_with_resolved_variable_service(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "indirected_coordinate",
                        "required_event": "game_start",
                        "effect": {
                            "location_variable_adjust": {"var_val": "input_name"},
                            "output_var": {"var_val": "output_name"},
                            "x_adjust": 1,
                        },
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "indirected_coordinate_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn(
                'services.variables.resolve(\n'
                '        context.data, actor, "var", "input_name")',
                main,
            )
            self.assertIn('services.variables.set_resolved(', main)
            self.assertIn('"var", "output_name", location', main)
            self.assertNotIn("typed coordinate variables", report)

    def test_migrates_region_settings_ravine(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "region_settings_ravine",
                            "id": "ravine_default",
                            "num_ravines": 2,
                            "ravine_range": 50,
                            "ravine_width": 3,
                            "ravine_depth": -4,
                        }
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "regional_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 0)
            self.assertIn("content.RegionSettingsRavine", main)
            self.assertIn('id = "ravine_default"', main)
            self.assertIn("num_ravines = 2", main)
            self.assertIn("ravine_range = 50", main)
            self.assertIn("ravine_width = 3", main)
            self.assertIn("ravine_depth = -4", main)
            self.assertIn("content.add(definition)", main)
            self.assertNotIn("needs review", report)

    def test_migrates_region_settings_lake(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "region_settings_lake",
                            "id": "lake_default",
                            "noise_threshold_lake": 0.5,
                            "lake_size_min": 25,
                            "lake_depth": -6,
                            "invert_lakes": True,
                            "surface_ter": "lake_surface",
                            "shore_ter": "lake_shore",
                            "interior_ter": "lake_water_cube",
                            "bed_ter": "lake_bed",
                            "shore_extendable_overmap_terrain": ["forest", "field"],
                            "shore_extendable_overmap_terrain_aliases": [
                                {
                                    "om_terrain": "swamp",
                                    "alias": "lake_shore",
                                    "om_terrain_match_type": "TYPE"
                                }
                            ]
                        }
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "regional_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 0)
            self.assertIn("content.RegionSettingsLake", main)
            self.assertIn('id = "lake_default"', main)
            self.assertIn("noise_threshold_lake = 0.5", main)
            self.assertIn("lake_size_min = 25", main)
            self.assertIn("lake_depth = -6", main)
            self.assertIn("invert_lakes = true", main)
            self.assertIn('surface_ter = "lake_surface"', main)
            self.assertIn('shore_extendable_overmap_terrain = {', main)
            self.assertIn('"forest"', main)
            self.assertIn('om_terrain = "swamp"', main)
            self.assertIn('om_terrain_match_type = "TYPE"', main)
            self.assertNotIn("needs review", report)

    def test_migrates_region_settings_ocean(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "region_settings_ocean",
                            "id": "ocean_default",
                            "noise_threshold_ocean": 0.25,
                            "ocean_size_min": 120,
                            "ocean_depth": -12,
                            "ocean_start_north": 10,
                            "ocean_start_east": 20,
                            "sandy_beach_width": 3,
                        }
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "regional_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 0)
            self.assertIn("content.RegionSettingsOcean", main)
            self.assertIn('id = "ocean_default"', main)
            self.assertIn("noise_threshold_ocean = 0.25", main)
            self.assertIn("ocean_size_min = 120", main)
            self.assertIn("ocean_depth = -12", main)
            self.assertIn("ocean_start_north = 10", main)
            self.assertIn("ocean_start_east = 20", main)
            self.assertIn("sandy_beach_width = 3", main)
            self.assertNotIn("needs review", report)

    def test_migrates_region_settings_forest(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "region_settings_forest",
                            "id": "forest_default",
                            "noise_threshold_forest": 0.25,
                            "noise_threshold_forest_thick": 0.5,
                            "noise_threshold_swamp_adjacent_water": 0.75,
                            "noise_threshold_swamp_isolated": 0.625,
                            "river_floodplain_buffer_distance_min": 4,
                            "river_floodplain_buffer_distance_max": 18,
                            "forest_threshold_limit": 0.375,
                            "forest_threshold_increase": [0.125, 0.25, 0.375, 0.5],
                        }
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "regional_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 0)
            self.assertIn("content.RegionSettingsForest", main)
            self.assertIn('id = "forest_default"', main)
            self.assertIn("noise_threshold_forest = 0.25", main)
            self.assertIn("noise_threshold_forest_thick = 0.5", main)
            self.assertIn("noise_threshold_swamp_adjacent_water = 0.75", main)
            self.assertIn("noise_threshold_swamp_isolated = 0.625", main)
            self.assertIn("river_floodplain_buffer_distance_min = 4", main)
            self.assertIn("river_floodplain_buffer_distance_max = 18", main)
            self.assertIn("forest_threshold_limit = 0.375", main)
            self.assertIn("forest_threshold_increase = {0.125, 0.25, 0.375, 0.5}", main)
            self.assertNotIn("needs review", report)

    def test_migrates_region_settings_river(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "region_settings_river",
                            "id": "test_river_custom",
                            "river_scale": 2,
                            "river_frequency": 1.25,
                            "river_branch_chance": 32.0,
                            "river_branch_remerge_chance": 8.0,
                            "river_branch_scale_decrease": 1.5,
                        }
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "river_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 0)
            self.assertIn("local definition = content.RegionSettingsRiver {", main)
            self.assertIn('id = "test_river_custom"', main)
            self.assertIn("river_scale = 2", main)
            self.assertIn("river_frequency = 1.25", main)
            self.assertIn("river_branch_chance = 32", main)
            self.assertIn("river_branch_remerge_chance = 8", main)
            self.assertIn("river_branch_scale_decrease = 1.5", main)
            self.assertNotIn("needs review", report)

    def test_migrates_region_settings_forest_mapgen(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "region_settings_forest_mapgen",
                            "id": "test_forest_mapgen_custom",
                            "biomes": ["forest_biome_test_a", "forest_biome_test_b"],
                        }
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "forest_mapgen_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 0)
            self.assertIn("local definition = content.RegionSettingsForestMapgen {", main)
            self.assertIn('id = "test_forest_mapgen_custom"', main)
            self.assertIn('biomes = { "forest_biome_test_a", "forest_biome_test_b" }', main)
            self.assertNotIn("needs review", report)

    def test_migrates_region_settings_map_extras(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "region_settings_map_extras",
                            "id": "test_map_extras_custom",
                            "extras": ["map_extra_test_a", "map_extra_test_b"],
                        }
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "map_extras_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 0)
            self.assertIn("local definition = content.RegionSettingsMapExtras {", main)
            self.assertIn('id = "test_map_extras_custom"', main)
            self.assertIn('extras = { "map_extra_test_a", "map_extra_test_b" }', main)
            self.assertNotIn("needs review", report)

    def test_migrates_region_settings_terrain_furniture(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "region_settings_terrain_furniture",
                            "id": "test_terrain_furniture_custom",
                            "ter_furn": ["region_ter_furn_test_a", "region_ter_furn_test_b"],
                        }
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "terrain_furniture_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 0)
            self.assertIn("local definition = content.RegionSettingsTerrainFurniture {", main)
            self.assertIn('id = "test_terrain_furniture_custom"', main)
            self.assertIn('ter_furn = { "region_ter_furn_test_a", "region_ter_furn_test_b" }', main)
            self.assertNotIn("needs review", report)

    def test_g2_regional_reference_ids_and_duplicates_are_partial(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "region_settings_river",
                            "id": "r" * 257,
                        },
                        {
                            "type": "region_settings_forest_mapgen",
                            "id": "duplicate_biomes",
                            "biomes": ["biome_a", "biome_a"],
                        },
                        {
                            "type": "region_settings_map_extras",
                            "id": "overlong_extra",
                            "extras": ["x" * 257],
                        },
                        {
                            "type": "region_settings_terrain_furniture",
                            "id": "duplicate_ter_furn",
                            "ter_furn": ["mapping_a", "mapping_a"],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "regional_invalid_ids"
            )
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 0)
            self.assertEqual(len(result.partial), 4)
            self.assertIn("region settings river needs a stable native id", report)
            self.assertIn("biomes entry needs review", report)
            self.assertIn("extras entry needs review", report)
            self.assertIn("ter_furn entry needs review", report)

    def test_g2_regional_inheritance_without_parents_fails_closed(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "region_settings_river",
                            "id": "river_child",
                            "copy-from": "default",
                        },
                        {
                            "type": "region_settings_forest_mapgen",
                            "id": "forest_child",
                            "copy-from": "default",
                            "extend": {"biomes": ["biome_extra"]},
                        },
                        {
                            "type": "region_settings_map_extras",
                            "id": "extras_child",
                            "copy-from": "default",
                            "delete": {"extras": ["forest"]},
                        },
                        {
                            "type": "region_settings_terrain_furniture",
                            "id": "terrain_child",
                            "copy-from": "default",
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "regional_inheritance"
            )
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 0)
            self.assertEqual(len(result.partial), 4)
            self.assertIn(
                "copy-from parent 'default' is not available in the migration corpus "
                "after deferred resolution",
                report,
            )

    def test_regional_inheritance_resolves_forward_and_multihop_parents(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "region_settings_ravine",
                            "id": "ravine_child",
                            "copy-from": "ravine_middle",
                            "ravine_depth": -8,
                        },
                        {
                            "type": "region_settings_ravine",
                            "id": "ravine_middle",
                            "copy-from": "ravine_base",
                            "ravine_width": 4,
                        },
                        {
                            "type": "region_settings_terrain_furniture",
                            "id": "terrain_child",
                            "copy-from": "terrain_base",
                            "ter_furn": ["mapping_child"],
                        },
                        {
                            "type": "region_settings_ravine",
                            "id": "ravine_base",
                            "num_ravines": 2,
                            "ravine_range": 50,
                            "ravine_width": 3,
                            "ravine_depth": -4,
                        },
                        {
                            "type": "region_settings_terrain_furniture",
                            "id": "terrain_base",
                            "ter_furn": ["mapping_base"],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "forward_regional_inheritance"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(len(result.converted), 5)
            self.assertEqual(len(result.partial), 0)
            self.assertEqual(len(result.todos), 0)
            self.assertIn('id = "ravine_child"', main)
            self.assertIn("ravine_range = 50", main)
            self.assertIn("ravine_width = 4", main)
            self.assertIn("ravine_depth = -8", main)
            self.assertIn('id = "terrain_child"', main)
            self.assertIn('ter_furn = { "mapping_child" }', main)

    def test_regional_inheritance_flattens_copy_extend_and_delete(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "region_settings_ravine",
                            "id": "ravine_base",
                            "num_ravines": 2,
                            "ravine_range": 50,
                            "ravine_width": 3,
                            "ravine_depth": -4,
                        },
                        {
                            "type": "region_settings_ravine",
                            "id": "ravine_child",
                            "copy-from": "ravine_base",
                            "ravine_depth": -8,
                        },
                        {
                            "type": "region_settings_lake",
                            "id": "lake_base",
                            "noise_threshold_lake": 0.5,
                            "lake_size_min": 25,
                            "shore_extendable_overmap_terrain": ["forest", "field"],
                        },
                        {
                            "type": "region_settings_lake",
                            "id": "lake_child",
                            "copy-from": "lake_base",
                            "extend": {
                                "shore_extendable_overmap_terrain": ["swamp"]
                            },
                            "delete": {
                                "shore_extendable_overmap_terrain": ["forest"]
                            },
                        },
                        {
                            "type": "region_settings_ocean",
                            "id": "ocean_base",
                            "noise_threshold_ocean": 0.25,
                            "ocean_depth": -12,
                        },
                        {
                            "type": "region_settings_ocean",
                            "id": "ocean_child",
                            "copy-from": "ocean_base",
                            "ocean_size_min": 120,
                        },
                        {
                            "type": "region_settings_forest",
                            "id": "forest_base",
                            "noise_threshold_forest": 0.25,
                            "forest_threshold_limit": 0.375,
                        },
                        {
                            "type": "region_settings_forest",
                            "id": "forest_child",
                            "copy-from": "forest_base",
                            "noise_threshold_forest_thick": 0.5,
                        },
                        {
                            "type": "region_settings_river",
                            "id": "river_base",
                            "river_scale": 2,
                            "river_frequency": 1.25,
                        },
                        {
                            "type": "region_settings_river",
                            "id": "river_child",
                            "copy-from": "river_base",
                            "river_scale": 4,
                        },
                        {
                            "type": "region_settings_forest_mapgen",
                            "id": "forest_mapgen_base",
                            "biomes": ["biome_a", "biome_b"],
                        },
                        {
                            "type": "region_settings_forest_mapgen",
                            "id": "forest_mapgen_child",
                            "copy-from": "forest_mapgen_base",
                            "extend": {"biomes": ["biome_c"]},
                            "delete": {"biomes": ["biome_a"]},
                        },
                        {
                            "type": "region_settings_map_extras",
                            "id": "map_extras_base",
                            "extras": ["forest", "field"],
                        },
                        {
                            "type": "region_settings_map_extras",
                            "id": "map_extras_child",
                            "copy-from": "map_extras_base",
                            "extend": {"extras": ["road"]},
                            "delete": {"extras": ["forest"]},
                        },
                        {
                            "type": "region_settings_terrain_furniture",
                            "id": "terrain_furniture_base",
                            "ter_furn": ["mapping_a", "mapping_b"],
                        },
                        {
                            "type": "region_settings_terrain_furniture",
                            "id": "terrain_furniture_child",
                            "copy-from": "terrain_furniture_base",
                            "extend": {"ter_furn": ["mapping_c"]},
                            "delete": {"ter_furn": ["mapping_a"]},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "regional_inheritance"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 16)
            self.assertEqual(len(result.partial), 0)
            self.assertEqual(len(result.todos), 0)
            self.assertIn('id = "ravine_child"', main)
            self.assertIn("ravine_range = 50", main)
            self.assertIn("ravine_depth = -8", main)
            self.assertIn('id = "lake_child"', main)
            self.assertIn('"field"', main)
            self.assertIn('"swamp"', main)
            self.assertIn('id = "ocean_child"', main)
            self.assertIn("noise_threshold_ocean = 0.25", main)
            self.assertIn('id = "forest_child"', main)
            self.assertIn("forest_threshold_limit = 0.375", main)
            self.assertIn('id = "river_child"', main)
            self.assertIn("river_frequency = 1.25", main)
            self.assertIn(
                'biomes = { "biome_b", "biome_c" }', main
            )
            self.assertIn(
                'extras = { "field", "road" }', main
            )
            self.assertIn(
                'ter_furn = { "mapping_b", "mapping_c" }', main
            )
            self.assertNotIn("copy-from", main)
            self.assertNotIn("needs review", report)

    def test_regional_inheritance_rejects_impossible_delete(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "region_settings_map_extras",
                            "id": "base",
                            "extras": ["forest"],
                        },
                        {
                            "type": "region_settings_map_extras",
                            "id": "child",
                            "copy-from": "base",
                            "delete": {"extras": ["road"]},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "bad_regional_delete"
            )
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 1)
            self.assertIn(
                "delete.extras references values absent from the inherited container",
                report,
            )

    def test_regional_inheritance_same_id_uses_previous_effective_object(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "region_settings_map_extras",
                            "id": "default",
                            "extras": ["forest"],
                        },
                        {
                            "type": "region_settings_map_extras",
                            "id": "default",
                            "copy-from": "default",
                            "extend": {"extras": ["field"]},
                        },
                        {
                            "type": "region_settings_map_extras",
                            "id": "child",
                            "copy-from": "default",
                            "delete": {"extras": ["forest"]},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "same_id_inheritance"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(len(result.converted), 3)
            self.assertEqual(len(result.partial), 0)
            self.assertEqual(len(result.todos), 0)
            self.assertIn('extras = { "forest", "field" }', main)
            self.assertIn('extras = { "field" }', main)

    def test_g3_regional_inheritance_flattens_weighted_lists(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "region_settings_forest_trail",
                            "id": "trail_base",
                            "chance": 3,
                            "trailheads": [["trail_a", 1]],
                        },
                        {
                            "type": "region_settings_forest_trail",
                            "id": "trail_child",
                            "copy-from": "trail_base",
                            "extend": {"trailheads": [["trail_a", 7], "trail_b"]},
                        },
                        {
                            "type": "region_settings_highway",
                            "id": "highway_base",
                            "clockwise_slant_special": "slant_clockwise",
                            "counterclockwise_slant_special": "slant_counterclockwise",
                            "bends": [["bend_a", 1]],
                        },
                        {
                            "type": "region_settings_highway",
                            "id": "highway_child",
                            "copy-from": "highway_base",
                            "extend": {"bends": [["bend_a", 4], ["bend_b", 2]]},
                        },
                        {
                            "type": "region_terrain_furniture",
                            "id": "rtf_base",
                            "ter_id": "t_base",
                            "replace_with_terrain": [["t_a", 1], ["t_b", 2]],
                        },
                        {
                            "type": "region_terrain_furniture",
                            "id": "rtf_child",
                            "copy-from": "rtf_base",
                            "extend": {"replace_with_terrain": [["t_a", 9], ["t_c", 3]]},
                            "delete": {"replace_with_terrain": ["t_b"]},
                        },
                        {
                            "type": "forest_biome_component",
                            "id": "component_base",
                            "chance": 5,
                            "types": {"t_a": 1, "t_b": 2},
                        },
                        {
                            "type": "forest_biome_component",
                            "id": "component_child",
                            "copy-from": "component_base",
                            "extend": {"types": [["t_a", 8], "t_c"]},
                            "delete": {"types": ["t_b"]},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "g3_inheritance"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(len(result.converted), 8)
            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn('id = "trail_child"', main)
            self.assertIn('definition:trailhead("trail_a", 7)', main)
            self.assertIn('definition:trailhead("trail_b", 1)', main)
            self.assertIn('id = "highway_child"', main)
            self.assertIn('definition:bend("bend_a", 4)', main)
            self.assertIn('definition:bend("bend_b", 2)', main)
            self.assertIn('id = "rtf_child"', main)
            self.assertIn('definition:replace_terrain("t_a", 9)', main)
            self.assertNotIn('definition:replace_terrain("t_b", 2)', main.split('id = "rtf_child"', 1)[1])
            self.assertIn('definition:replace_terrain("t_c", 3)', main)
            self.assertIn('id = "component_child"', main)
            self.assertIn('definition:type("t_a", 8)', main)
            self.assertIn('definition:type("t_c", 1)', main)

    def test_g3_weighted_lists_replace_duplicate_weights_in_place(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "forest_biome_component",
                        "id": "duplicate_component",
                        "types": [["t_first", 1], ["t_second", 2], ["t_first", 9]],
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "g3_duplicates"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertEqual(main.count('definition:type("t_first",'), 1)
            self.assertLess(
                main.index('definition:type("t_first", 9)'),
                main.index('definition:type("t_second", 2)'),
            )

    def test_regional_leaf_invalid_native_values_are_partial(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "region_settings_ravine",
                            "id": "ravine_invalid",
                            "num_ravines": 1 << 40,
                        },
                        {
                            "type": "region_settings_lake",
                            "id": "lake_invalid",
                            "invert_lakes": "false",
                            "surface_ter": 7,
                            "shore_extendable_overmap_terrain_aliases": [
                                {
                                    "om_terrain": "forest",
                                    "alias": "lake_shore",
                                    "om_terrain_match_type": "sideways",
                                }
                            ],
                        },
                        {
                            "type": "region_settings_ocean",
                            "id": "ocean_invalid",
                            "ocean_start_north": 1 << 40,
                        },
                        {
                            "type": "region_settings_forest",
                            "id": "forest_invalid",
                            "forest_threshold_limit": 1e300,
                            "forest_threshold_increase": [1e300, 0, 0, 0],
                        },
                        {
                            "type": "region_settings_river",
                            "id": "river_invalid",
                            "river_scale": 1 << 40,
                        },
                        {
                            "type": "region_settings_forest_mapgen",
                            "id": "forest_mapgen_invalid",
                            "biomes": "not_a_list",
                        },
                        {
                            "type": "region_settings_map_extras",
                            "id": "map_extras_invalid",
                            "extras": [""],
                        },
                        {
                            "type": "region_settings_terrain_furniture",
                            "id": "terrain_furniture_invalid",
                            "ter_furn": [123],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "regional_invalid_mod"
            )
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 0)
            self.assertEqual(len(result.partial), 8)
            self.assertIn("num_ravines needs review", report)
            self.assertIn("invert_lakes needs review", report)
            self.assertIn("surface_ter needs review", report)
            self.assertIn(
                "shore_extendable_overmap_terrain_aliases element needs review",
                report,
            )
            self.assertIn("ocean_start_north needs review", report)
            self.assertIn("forest_threshold_limit needs review", report)
            self.assertIn("forest_threshold_increase element needs review", report)
            self.assertIn("river_scale needs review", report)
            self.assertIn("biomes must be a list", report)
            self.assertIn("extras entry needs review", report)
            self.assertIn("ter_furn entry needs review", report)

    def test_migrates_region_settings_forest_trail(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "region_settings_forest_trail",
                            "id": "test_trail",
                            "chance": 3,
                            "border_point_chance": 4,
                            "minimum_forest_size": 80,
                            "random_point_min": 5,
                            "random_point_max": 45,
                            "random_point_size_scalar": 90,
                            "trailhead_chance": 2,
                            "trailhead_road_distance": 8,
                            "trailheads": [
                                ["trailhead_basic", 2],
                                ["trailhead_outhouse", 1],
                            ],
                        }
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "forest_trail_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertIn("content.RegionSettingsForestTrail {", main)
            self.assertIn('id = "test_trail"', main)
            self.assertIn("chance = 3", main)
            self.assertIn("border_point_chance = 4", main)
            self.assertIn("minimum_forest_size = 80", main)
            self.assertIn("random_point_min = 5", main)
            self.assertIn("random_point_max = 45", main)
            self.assertIn("random_point_size_scalar = 90", main)
            self.assertIn("trailhead_chance = 2", main)
            self.assertIn("trailhead_road_distance = 8", main)
            self.assertIn('definition:trailhead("trailhead_basic", 2)', main)
            self.assertIn('definition:trailhead("trailhead_outhouse", 1)', main)

    def test_migrates_region_settings_highway(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "region_settings_highway",
                            "id": "test_highway",
                            "width_of_segments": 3,
                            "straightness_chance": 0.75,
                            "reserved_terrain_id": "hw_reserved",
                            "reserved_terrain_water_id": "hw_reserved_water",
                            "segment_flat_special": "highway_segment_flat",
                            "clockwise_slant_special": "Highway Slant Minor Clockwise",
                            "counterclockwise_slant_special": "Highway Slant Minor Counterclockwise",
                            "four_way_intersections": [["Highway Clover Leaf", 2]],
                            "three_way_intersections": [["Highway Trumpet Interchange", 1]],
                            "bends": [["Highway Bend", 3]],
                            "road_connections": [["Highway Diamond Interchange", 1]],
                            "interchanges": [["Highway Diamond Interchange", 2]],
                        }
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "highway_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertIn("content.RegionSettingsHighway {", main)
            self.assertIn('id = "test_highway"', main)
            self.assertIn("width_of_segments = 3", main)
            self.assertIn("straightness_chance = 0.75", main)
            self.assertIn('reserved_terrain_id = "hw_reserved"', main)
            self.assertIn('reserved_terrain_water_id = "hw_reserved_water"', main)
            self.assertIn('segment_flat_special = "highway_segment_flat"', main)
            self.assertIn('definition:four_way_intersection("Highway Clover Leaf", 2)', main)
            self.assertIn('definition:three_way_intersection("Highway Trumpet Interchange", 1)', main)
            self.assertIn('definition:bend("Highway Bend", 3)', main)
            self.assertIn('definition:road_connection("Highway Diamond Interchange", 1)', main)
            self.assertIn('definition:interchange("Highway Diamond Interchange", 2)', main)

    def test_migrates_top_level_region_settings(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "region_settings",
                        "id": "test_region",
                        "cities": "test_cities",
                        "default_oter": [f"oter_{index}" for index in range(21)],
                        "default_groundcover": [
                            ["t_grass", 2], ["t_dirt", 1], ["t_grass", 7]
                        ],
                        "forest_composition": "test_composition",
                        "forest_trails": "test_trails",
                        "weather": "test_weather",
                        "forests": "test_forests",
                        "rivers": None,
                        "lakes": "test_lakes",
                        "ocean": "test_ocean",
                        "highways": "test_highways",
                        "ravines": "test_ravines",
                        "map_extras": "test_extras",
                        "terrain_furniture": "test_terrain_furniture",
                        "feature_flag_settings": {
                            "blacklist": ["BLACK", "BLACK"],
                            "whitelist": ["WHITE", "BLACK"],
                        },
                        "connections": {
                            "trail_connection": "trail_connection",
                            "sewer_connection": "sewer_connection",
                            "subway_connection": "subway_connection",
                            "rail_connection": "rail_connection",
                            "intra_city_road_connection": "intra_road",
                            "inter_city_road_connection": "inter_road",
                        },
                        "place_swamps": False,
                        "place_roads": False,
                        "place_railroads": True,
                        "place_railroads_before_roads": True,
                        "place_specials": False,
                        "neighbor_connections": False,
                        "max_urbanity": 12.5,
                        "urbanity_increase": [-1, 2.5, 3, 4],
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "region_settings_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn("content.RegionSettings {", main)
            self.assertIn('id = "test_region"', main)
            self.assertIn('cities = "test_cities"', main)
            self.assertIn('definition:default_oter({ "oter_0",', main)
            self.assertEqual(main.count('definition:groundcover("t_grass",'), 1)
            self.assertIn('definition:groundcover("t_grass", 7)', main)
            self.assertIn('definition:forest_composition("test_composition")', main)
            self.assertNotIn("definition:rivers", main)
            self.assertEqual(main.count('definition:feature_blacklisted("BLACK")'), 1)
            self.assertIn('definition:feature_whitelisted("BLACK")', main)
            self.assertIn('definition:inter_city_road_connection("inter_road")', main)
            self.assertIn("definition:place_railroads(true)", main)
            self.assertIn("definition:max_urbanity(12.5)", main)
            self.assertIn("definition:urbanity_increase({ -1, 2.5, 3, 4 })", main)

    def test_region_settings_inheritance_flattens_nested_and_weighted_fields(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "region_settings",
                            "id": "base_region",
                            "cities": "base_cities",
                            "default_groundcover": [
                                ["t_grass", 2], ["t_dirt", 1]
                            ],
                            "feature_flag_settings": {
                                "blacklist": ["BASE_BLACK"],
                                "whitelist": ["BASE_WHITE"],
                            },
                            "connections": {
                                "trail_connection": "base_trail",
                                "sewer_connection": "base_sewer",
                            },
                        },
                        {
                            "type": "region_settings",
                            "id": "child_region",
                            "copy-from": "base_region",
                            "extend": {
                                "default_groundcover": [
                                    ["t_grass", 9], ["t_sand", 3]
                                ]
                            },
                            "delete": {"default_groundcover": ["t_dirt"]},
                            "feature_flag_settings": {
                                "whitelist": ["CHILD_WHITE"],
                                "extend": {"blacklist": ["CHILD_BLACK"]},
                            },
                            "connections": {"trail_connection": "child_trail"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "region_inheritance_mod"
            )
            main = result.files[Path("main.lua")]
            child = main.split('id = "child_region"', 1)[1]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn('cities = "base_cities"', child)
            self.assertIn('definition:groundcover("t_grass", 9)', child)
            self.assertIn('definition:groundcover("t_sand", 3)', child)
            self.assertNotIn('definition:groundcover("t_dirt", 1)', child)
            self.assertIn('definition:feature_blacklisted("BASE_BLACK")', child)
            self.assertIn('definition:feature_blacklisted("CHILD_BLACK")', child)
            self.assertIn('definition:feature_whitelisted("CHILD_WHITE")', child)
            self.assertIn('definition:trail_connection("child_trail")', child)
            self.assertIn('definition:sewer_connection("base_sewer")', child)

    def test_region_settings_preserves_explicit_empty_groundcover(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "region_settings",
                        "id": "empty_groundcover",
                        "cities": "default",
                        "default_groundcover": [],
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "empty_groundcover_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertIn("definition:default_groundcover({})", main)

    def test_invalid_region_settings_native_values_are_partial(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "region_settings",
                            "id": "invalid_region",
                            "cities": "valid_cities",
                            "default_oter": ["oter"] * 20,
                            "default_groundcover": [["t_grass", 0]],
                            "feature_flag_settings": {"blacklist": 7},
                            "connections": {"trail_connection": 7},
                            "max_urbanity": float("inf"),
                            "urbanity_increase": [0, 1, 2],
                        },
                        {
                            "type": "region_settings",
                            "id": "missing_cities",
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "invalid_region_mod"
            )
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(result.converted, [])
            self.assertEqual(len(result.partial), 2)
            self.assertIn("default_oter needs exactly 21", report)
            self.assertIn("default_groundcover needs review", report)
            self.assertIn("feature_flag_settings.blacklist needs review", report)
            self.assertIn("connections.trail_connection needs", report)
            self.assertIn("max_urbanity needs a native float", report)
            self.assertIn("urbanity_increase needs exactly four", report)
            self.assertIn("cities needs a bounded native id", report)

    def test_migrates_region_terrain_furniture(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "region_terrain_furniture",
                            "id": "test_rtf",
                            "ter_id": "t_region_groundcover",
                            "furn_id": "f_region_flower",
                            "replace_with_terrain": [
                                ["t_grass", 100],
                                ["t_dirt", 10],
                            ],
                            "replace_with_furniture": [
                                ["f_flower_tulip", 5],
                            ],
                        }
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "rtf_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertIn("content.RegionTerrainFurniture {", main)
            self.assertIn('id = "test_rtf"', main)
            self.assertIn('ter_id = "t_region_groundcover"', main)
            self.assertIn('furn_id = "f_region_flower"', main)
            self.assertIn('definition:replace_terrain("t_grass", 100)', main)
            self.assertIn('definition:replace_terrain("t_dirt", 10)', main)
            self.assertIn('definition:replace_furniture("f_flower_tulip", 5)', main)

    def test_migrates_forest_biome_component(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "forest_biome_component",
                            "id": "test_fbc",
                            "sequence": 1,
                            "chance": 25,
                            "types": [
                                ["t_tree_young", 10],
                                ["t_region_tree_forest", 50],
                            ],
                        }
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "fbc_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertIn("content.ForestBiomeComponent {", main)
            self.assertIn('id = "test_fbc"', main)
            self.assertIn("sequence = 1", main)
            self.assertIn("chance = 25", main)
            self.assertIn('definition:type("t_tree_young", 10)', main)
            self.assertIn('definition:type("t_region_tree_forest", 50)', main)

    def test_migrates_batch_g3_invalid_fields_report_todos(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "region_settings_forest_trail",
                            "id": "trail_inv",
                            "chance": 1 << 40,
                            "trailheads": 7,
                        },
                        {
                            "type": "region_settings_highway",
                            "id": "highway_inv",
                            "width_of_segments": 1 << 40,
                            "four_way_intersections": 7,
                        },
                        {
                            "type": "region_terrain_furniture",
                            "id": "rtf_inv",
                            "replace_with_terrain": 7,
                        },
                        {
                            "type": "forest_biome_component",
                            "id": "fbc_inv",
                            "chance": 1 << 40,
                            "types": 7,
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "g3_inv_mod"
            )
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 0)
            self.assertEqual(len(result.partial), 4)
            self.assertIn("chance needs review", report)
            self.assertIn("trailheads need review", report)
            self.assertIn("width_of_segments needs review", report)
            self.assertIn("four_way_intersections needs review", report)
            self.assertIn("replace_with_terrain needs review", report)
            self.assertIn("types need review", report)

    def test_translates_batch_g4_selectors(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "city",
                            "id": "city_boston",
                            "database_id": 42,
                            "name": "Boston",
                            "population": 650000,
                            "size": 12,
                            "pos_om": [ 10, 20 ],
                            "pos": [ 30, 40 ],
                        },
                        {
                            "type": "faction_mission",
                            "id": "mission_scout",
                            "name": "Scouting Mission",
                            "desc": "Scout nearby sector.",
                            "skill": "survival",
                            "difficulty": "LOW",
                            "risk": "VERY_LOW",
                            "activity": "LIGHT_EXERCISE",
                            "time": "2 Hours",
                            "positions": 2,
                            "items_label": "Rewards",
                            "items_possibilities": [ "canteen", "matchbook" ],
                            "effects": [ "Uncovers map tiles." ],
                            "footer": "Report back to base.",
                        },
                        {
                            "type": "region_settings_city",
                            "id": "default_city",
                            "is_megacity": False,
                            "city_size": 8,
                            "city_spacing": 4,
                            "shop_radius": 30,
                            "shop_sigma": 50,
                            "park_radius": 20,
                            "park_sigma": 80,
                            "name_snippet": "city_names",
                            "houses": [ [ "house_suburban", 50 ] ],
                            "shops": [ [ "shop_grocery", 25 ] ],
                            "parks": [ [ "park_central", 10 ] ],
                        },
                        {
                            "type": "region_settings_city",
                            "id": "child_city",
                            "copy-from": "default_city",
                            "city_size": 10,
                            "extend": {
                                "houses": [ [ "house_modern", 40 ] ],
                            },
                            "delete": {
                                "shops": [ [ "shop_grocery", 25 ] ],
                            },
                        },
                        {
                            "type": "forest_biome_mapgen",
                            "id": "default_biome",
                            "sparseness_adjacency_factor": 3,
                            "item_group": "forest",
                            "item_group_chance": 60,
                            "item_spawn_iterations": 1,
                            "terrains": [ "forest", "special_forest" ],
                            "components": [ "trees_forest" ],
                            "groundcover": [ [ "t_region_groundcover_forest", 1 ] ],
                            "terrain_furniture": {
                                "t_water_murky": {
                                    "chance": 2,
                                    "furniture": [ [ "f_region_water_plant", 1 ] ],
                                },
                            },
                        },
                        {
                            "type": "forest_biome_mapgen",
                            "id": "child_biome",
                            "copy-from": "default_biome",
                            "sparseness_adjacency_factor": 4,
                            "extend": {
                                "terrains": [ "forest_thick" ],
                                "components": [ "shrubs_forest" ],
                                "groundcover": [ [ "t_region_groundcover_swamp", 2 ] ],
                            },
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "g4_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 6)
            self.assertEqual(len(result.partial), 0)
            self.assertEqual(len(result.todos), 0)
            self.assertIn("content.City", main)
            self.assertIn("content.FactionMission", main)
            self.assertIn("content.RegionSettingsCity", main)
            self.assertIn("content.ForestBiomeMapgen", main)
            self.assertIn('id = "city_boston"', main)
            self.assertIn('id = "mission_scout"', main)
            self.assertIn('id = "default_city"', main)
            self.assertIn('id = "child_city"', main)
            self.assertIn('id = "default_biome"', main)
            self.assertIn('id = "child_biome"', main)
            self.assertIn('definition:add_house("house_modern", 40)', main)
            self.assertIn('definition:add_terrain("forest_thick")', main)
            self.assertIn('definition:add_component("shrubs_forest")', main)
            self.assertIn('definition:add_groundcover("t_region_groundcover_swamp", 2)', main)

    def test_batch_g4_defaults_and_invalid_shapes_fail_closed(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "city",
                            "id": "city_missing_native_members",
                        },
                        {
                            "type": "faction_mission",
                            "id": "mission_missing_text",
                            "activity": "NOT_AN_ACTIVITY_LEVEL",
                        },
                        {
                            "type": "region_settings_city",
                            "id": "city_settings_missing_size",
                            "is_megacity": "false",
                        },
                        {
                            "type": "region_settings_city",
                            "id": "city_settings_defaults",
                            "city_size": 8,
                        },
                        {
                            "type": "forest_biome_mapgen",
                            "id": "forest_defaults",
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "g4_invalid_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(len(result.partial), 3)
            self.assertIn("database_id needs review", report)
            self.assertIn("name needs review", report)
            self.assertIn("activity needs review", report)
            self.assertIn("is_megacity needs review", report)
            self.assertIn("city_size needs review", report)
            self.assertIn("shop_sigma = 20", main)
            self.assertIn("park_radius = 30", main)
            self.assertIn("park_sigma = 70", main)
            self.assertIn('name_snippet = "<city_name>"', main)
            self.assertIn("sparseness_adjacency_factor = 0", main)
            self.assertIn("item_group_chance = 0", main)
            self.assertIn("item_spawn_iterations = 0", main)

    def test_lowers_all_traversals_and_inline_callbacks_without_eoc_runner(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "traversal_owner",
                            "required_event": "game_start",
                            "effect": [
                                {
                                    "u_run_npc_eocs": [
                                        {"effect": {"message": "npc"}}
                                    ],
                                    "npc_range": 3,
                                    "local": True,
                                },
                                {
                                    "u_run_monster_eocs": [
                                        {"effect": {"message": "monster"}}
                                    ],
                                    "monster_range": 4,
                                },
                                {
                                    "u_run_vehicle_eocs": [
                                        {"effect": {"message": "vehicle"}}
                                    ],
                                    "vehicle_range": 5,
                                },
                                {
                                    "u_run_fixed_zone_eocs": [
                                        {"effect": {"message": "zone"}}
                                    ],
                                    "zone_range": 6,
                                },
                                {
                                    "u_run_inv_eocs": "all",
                                    "true_eocs": [
                                        {"effect": {"message": "inventory"}}
                                    ],
                                },
                                {
                                    "u_map_run_eocs": {
                                        "effect": {"math": ["u_point_count += 1"]}
                                    },
                                    "range": 1,
                                    "store_coordinates_in": {
                                        "context_val": "point_location"
                                    },
                                },
                                {
                                    "u_map_run_item_eocs": "all",
                                    "true_eocs": [
                                        {"effect": {"message": "map item"}}
                                    ],
                                },
                            ],
                        }
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "traversal_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn("services.creatures.nearby", main)
            self.assertIn("local npc_offset = 0", main)
            self.assertIn("npc_page.has_more", main)
            self.assertIn("local monster_offset = 0", main)
            self.assertIn("monster_page.has_more", main)
            self.assertIn("services.world.vehicles", main)
            self.assertIn("local vehicle_offset = 0", main)
            self.assertIn("vehicle_page.has_more", main)
            self.assertIn("services.zones.list", main)
            self.assertIn("local zone_offset = 0", main)
            self.assertIn("zone_page.has_more", main)
            self.assertIn("services.inventory.filter", main)
            self.assertIn("local inventory_offset = 0", main)
            self.assertIn("inventory_page.has_more", main)
            self.assertIn("services.world.points_nearby", main)
            self.assertIn("local point_offset = 0", main)
            self.assertIn("point_page.has_more", main)
            self.assertIn('services.variables.set(\n        actor, "point_count"', main)
            self.assertIn(
                'context.data["point_location"] = point_entry.position', main
            )
            self.assertIn("migrated_eoc_", main)
            self.assertIn("services.world.items_nearby", main)
            self.assertIn("local item_offset = 0", main)
            self.assertIn("item_page.has_more", main)
            self.assertIn("local migrated_eoc_", main)
            self.assertNotIn("run_eoc(", main)

    def test_local_npc_traversal_without_range_pages_all_loaded_npcs(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "mutation",
                            "id": "CALLBACK_MUTATION",
                            "deactivated_eocs": ["deactivated_owner"],
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "deactivated_owner",
                            "effect": {
                                "u_run_npc_eocs": ["npc_target"],
                                "local": True,
                                "npc_must_see": True,
                            },
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "npc_target",
                            "effect": {"message": "seen"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]),
                "local_npc_traversal_mod",
                exclude_types=frozenset({"mutation"}),
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertNotIn("complete named-NPC traversal conversion", report)
            self.assertIn("services.npcs.list", main)
            self.assertIn("npc_page.has_more", main)
            self.assertIn("services.creatures.can_see(target, actor)", main)
            self.assertIn("migrated_eoc_npc_target(context, target)", main)
            self.assertNotIn(
                'runtime.handler("migrated.deactivated_owner"', main
            )

    def test_unbounded_monster_and_false_only_inventory_traversals_are_paged(
        self,
    ) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "traversal_edge_owner",
                            "required_event": "game_start",
                            "effect": [
                                {
                                    "u_run_monster_eocs": ["monster_target"]
                                },
                                {
                                    "u_run_inv_eocs": "all",
                                    "//": "false-only search",
                                    "search_data": [{"id": ["staff"]}],
                                    "false_eocs": ["inventory_missing"],
                                },
                            ],
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "monster_target",
                            "effect": {"message": "monster"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "inventory_missing",
                            "effect": {"u_message": "missing"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]),
                "traversal_edges_mod",
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertNotIn("complete named-NPC traversal conversion", report)
            self.assertIn("radius = 1000", main)
            self.assertIn("monster_page.has_more", main)
            self.assertIn("if not inventory_seen then", main)
            self.assertIn(
                "migrated_eoc_inventory_missing(context, nil)", main
            )

    def test_lowers_inventory_item_conditions_with_shared_context_options(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "inventory_conditions",
                            "effect": [
                                {
                                    "u_run_inv_eocs": "all",
                                    "search_data": [
                                        {"condition": "has_ammo"},
                                        {
                                            "id": "rock",
                                            "condition": {
                                                "math": ["n_volume() > 0"]
                                            },
                                        },
                                        {
                                            "condition": {
                                                "and": [
                                                    {"math": ["n_volume() > 0"]},
                                                    {"math": ["_cost < u_val('power')"]},
                                                ]
                                            }
                                        },
                                    ],
                                    "true_eocs": [
                                        {"effect": {"message": "matched"}}
                                    ],
                                }
                            ],
                        }
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "inventory_condition_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn('condition = "has_ammo"', main)
            self.assertIn('condition = { math = "n_volume() > 0" }', main)
            self.assertIn(
                'condition = { all = { { math = "n_volume() > 0" }, { math = "_cost < u_val(\'power\')" } } }',
                main,
            )
            self.assertIn("local inventory_options =", main)
            self.assertIn("context = (context and context.data) or {}", main)
            self.assertIn("inventory_options.offset = inventory_offset", main)

    def test_uses_event_contract_actor_and_typed_relocation_services(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "event_character_mutation",
                            "required_event": "character_gains_effect",
                            "effect": [
                                {"u_add_effect": "stunned", "duration": "1 turn"},
                                {
                                    "u_lose_effect": ["stunned", "downed"]
                                },
                                {
                                    "u_teleport": {"context_val": "destination"},
                                    "force": True,
                                    "success_message": "moved",
                                },
                            ],
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "avatar_map_update",
                            "required_event": "avatar_enters_omt",
                            "effect": {
                                "mapgen_update": "update_lab",
                                "target_var": {"context_val": "location"},
                                "om_terrain": "lab",
                            },
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "monster_damage_effect_cleanup",
                            "required_event": "monster_takes_damage",
                            "condition": {
                                "and": [
                                    {"u_has_effect": "psi_stunned"},
                                    {"npc_has_effect": "mesmerize_source"},
                                ]
                            },
                            "effect": {
                                "u_lose_effect": [
                                    "psi_stunned",
                                    "effect_telepath_mesmerize_tracker",
                                ]
                            },
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "character_damage_effect_cleanup",
                            "required_event": "character_takes_damage",
                            "condition": "has_beta",
                            "effect": {
                                "if": {
                                    "and": [
                                        {"u_has_effect": "telepathic_ignorance"},
                                        {"npc_has_effect": "telepathic_ignorance_self"},
                                    ]
                                },
                                "then": {
                                    "u_lose_effect": "telepathic_ignorance"
                                },
                            },
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "event_actor_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn('context.actors["character"]', main)
            self.assertIn("services.effects.add", main)
            self.assertIn("services.effects.remove", main)
            self.assertIn("services.relocation.creature_at", main)
            self.assertNotIn("services.overmap.matches", main)
            self.assertIn("services.world.apply_mapgen_update", main)
            self.assertIn("context.actors.beta", main)
            self.assertIn("context.actors.character or context.actors.alpha", main)
            self.assertIn(
                'service_value(services.effects.remove(actor, services.types.id("effect", "psi_stunned")))',
                main,
            )

    def test_global_npc_queries_do_not_hide_u_actor_effects(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "network_spell",
                            "condition": {"npc_allies": 1},
                            "effect": {
                                "u_cast_spell": {
                                    "id": "telepathic_network_real",
                                    "hit_self": True,
                                    "message": "networked",
                                }
                            },
                        }
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "network_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.partial), 1)
            self.assertIn("if not (services.npcs.count_allies(false) >= 1) then", main)
            self.assertNotIn("invalid empty math condition", report)
            self.assertNotIn("needs a native Lua predicate", report)
            self.assertEqual(len(result.todos), 1)
            self.assertIn(
                'services.characters.cast_spell(actor, services.types.id("spell", "telepathic_network_real")',
                main,
            )
            self.assertNotIn("combat effect through a proven actor", main)
            self.assertIn("needs an explicit Platform trigger", report)

    def test_run_eocs_talker_overrides_preserve_alpha_beta_context(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "talker_parent",
                            "condition": {"u_has_effect": "source"},
                            "effect": [
                                {
                                    "run_eocs": ["talker_child"],
                                    "alpha_talker": "u",
                                    "beta_talker": "avatar",
                                }
                            ],
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "talker_child",
                            "condition": {
                                "and": ["u_is_alive", "npc_is_avatar"]
                            },
                            "effect": {"u_lose_effect": "marked"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "talker_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.partial), 1)
            self.assertEqual(len(result.todos), 1)
            self.assertIn("talker_parent needs an explicit Platform trigger", result.todos[0])
            self.assertIn(
                "local selected_alpha = ((context.actors and "
                "context.actors.alpha) or actor)",
                main,
            )
            self.assertIn(
                "local selected_beta = services.characters.avatar()", main
            )
            self.assertIn("context.actors.alpha = selected_alpha", main)
            self.assertIn("context.actors.beta = selected_beta", main)
            self.assertIn(
                "services.creatures.snapshot((context.actors and context.actors.beta) or actor)",
                main,
            )
            self.assertNotIn("needs a typed callback/task conversion", report)

    def test_lowers_world_content_types_through_registered_platform_builders(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {"type": "faction", "id": "fac_test", "name": "Test faction"},
                        {"type": "npc_class", "id": "class_test", "name": "Test class"},
                        {"type": "overmap_terrain", "id": "oter_test", "name": "Test OMT"},
                        {"type": "vehicle", "id": "vehicle_test", "parts": []},
                        {"type": "widget", "id": "widget_test", "bodypart": "torso"},
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "world_content_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(len(result.partial), 0)
            self.assertEqual(len(result.converted), 5)
            self.assertEqual(result.todos, [])
            self.assertIn("content.Faction", main)
            self.assertIn("content.NpcClass", main)
            self.assertIn("content.OvermapTerrain", main)
            self.assertIn("content.Vehicle", main)
            self.assertIn("content.Widget", main)
            self.assertNotIn("has no native Platform registrar", main)

    def test_flattens_generic_copy_from_extend_and_delete(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "vehicle_part",
                            "id": "base_part",
                            "flags": ["BASE", "REMOVE_ME"],
                            "allowed_tools": ["welder"],
                        },
                        {
                            "type": "vehicle_part",
                            "id": "child_part",
                            "copy-from": "base_part",
                            "extend": {
                                "flags": ["CHILD"],
                                "allowed_tools": ["soldering_iron"],
                            },
                            "delete": {"flags": ["REMOVE_ME"]},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "generic_inheritance_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn('id = "child_part"', main)
            self.assertIn('"BASE", "CHILD"', main)
            self.assertIn('"welder", "soldering_iron"', main)
            self.assertNotIn("copy-from", main)
            self.assertNotIn("extend", main)
            self.assertNotIn("delete", main)
            self.assertNotIn("needs review", report)

    def test_normalizes_legacy_generic_aliases_before_typed_registration(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "overmap_terrain",
                            "id": "alias_oter",
                            "sym": "S",
                            "mondensity": 7,
                        },
                        {
                            "type": "faction",
                            "id": "alias_faction",
                            "name": {"str": "Alias faction"},
                            "likes_u": 2,
                            "respects_u": 3,
                            "known_by_u": False,
                            "fac_food_supply": 4,
                            "mon_faction": "alias_monsters",
                        },
                        {
                            "type": "npc_class",
                            "id": "alias_class",
                            "name": {"str": "Alias class"},
                            "worn_override": "worn_group",
                            "weapon_override": "weapon_group",
                            "bonus_str": 1,
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "generic_alias_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 3)
            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn('symbol = "S"', main)
            self.assertIn("monster_density = 7", main)
            self.assertIn('name = "Alias faction"', main)
            self.assertIn("likes = 2", main)
            self.assertIn("respects = 3", main)
            self.assertIn("known = false", main)
            self.assertIn("food_calories = 4", main)
            self.assertIn('monster_faction = "alias_monsters"', main)
            self.assertIn('name = "Alias class"', main)
            self.assertIn('worn = "worn_group"', main)
            self.assertIn('weapon = "weapon_group"', main)
            self.assertIn("strength = 1", main)
            self.assertNotIn("needs review", report)

    def test_lowers_weighted_inline_eocs_to_bounded_lua_random_selection(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "weighted_owner",
                            "required_event": "game_start",
                            "effect": {
                                "weighted_list_eocs": [
                                    [{"effect": {"message": "first"}}, 2],
                                    [{"effect": {"message": "second"}}, 1],
                                ]
                            },
                        }
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "weighted_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn("services.random.int(1, 3)", main)
            self.assertIn("weighted_cursor", main)
            self.assertNotIn("run_eoc(", main)

    def test_weighted_eoc_dynamic_weights_are_bounded(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "weighted_dynamic_first",
                            "required_event": "game_start",
                            "effect": {"message": "first"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "weighted_dynamic_second",
                            "required_event": "game_start",
                            "effect": {"message": "second"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "weighted_dynamic_owner",
                            "required_event": "game_start",
                            "effect": {
                                "weighted_list_eocs": [
                                    ["weighted_dynamic_first", {"context_val": "weight"}],
                                    ["weighted_dynamic_second", 1],
                                ]
                            },
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "weighted_dynamic_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn("math.min(1000000000", main)
            self.assertIn("weighted_cursor", main)

    def test_false_effect_supports_weighted_eoc_callbacks(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps([
                    {
                        "type": "effect_on_condition",
                        "id": "false_weighted_first",
                        "effect": {"message": "first"},
                    },
                    {
                        "type": "effect_on_condition",
                        "id": "false_weighted_second",
                        "effect": {"message": "second"},
                    },
                    {
                        "type": "effect_on_condition",
                        "id": "false_weighted_owner",
                        "required_event": "game_start",
                        "condition": {"u_has_cash": 1000000},
                        "false_effect": {
                            "weighted_list_eocs": [
                                ["false_weighted_first", 2],
                                ["false_weighted_second", 1],
                            ]
                        },
                        "effect": "nothing",
                    },
                ]),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "false_weighted_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn("services.random.int(1, 3)", main)
            self.assertIn("weighted_cursor", main)
            self.assertNotIn("weighted-callback conversion", report)

    def test_global_u_sound_false_effect_uses_avatar_talker(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps({
                    "type": "effect_on_condition",
                    "id": "global_u_sound_false",
                    "required_event": "game_start",
                    "condition": False,
                    "false_effect": {
                        "u_make_sound": "a loud tearing sound.",
                        "target_var": {"context_val": "sound_location"},
                        "volume": 80,
                        "type": "alert",
                    },
                    "effect": "nothing",
                }),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "global_u_sound_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn("services.sound.emit(", main)
            self.assertIn("sound_location", main)
            self.assertNotIn("typed Lua services", report)

    def test_global_u_set_field_false_effect_uses_avatar_talker(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps({
                    "type": "effect_on_condition",
                    "id": "global_u_field_false",
                    "required_event": "game_start",
                    "condition": False,
                    "false_effect": {
                        "u_set_field": "fd_hot_air3",
                        "outdoor_only": True,
                        "radius": 2,
                    },
                    "effect": "nothing",
                }),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "global_u_field_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn("services.world.put_field(", main)
            self.assertIn('services.types.id("field", "fd_hot_air3")', main)
            self.assertNotIn("typed Lua services", report)

    def test_lowers_dynamic_character_predicates_and_effects(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "dynamic_character_shapes",
                        "required_event": "game_start",
                        "condition": {
                            "and": [
                                {"u_has_item": {"context_val": "item_id"}},
                                {
                                    "u_has_effect": {"u_val": "effect_id"},
                                    "bodypart": {"context_val": "body_part"},
                                    "intensity": {"context_val": "effect_intensity"},
                                },
                                {
                                    "compare_string": [
                                        "zombie",
                                        {
                                            "mutator": "mon_faction",
                                            "mtype_id": {"context_val": "victim_type"},
                                        },
                                    ]
                                },
                                {
                                    "u_has_items": {
                                        "item": "scrap_dreamdross",
                                        "count": {"context_val": "item_count"},
                                    }
                                },
                                {
                                    "u_near_om_location": {"context_val": "omt"},
                                    "range": {"context_val": "radius"},
                                },
                                {
                                    "u_has_any_effect": ["hot", "cold"],
                                    "bodypart": "torso",
                                },
                                {"u_has_wielded_with_flag": {"global_val": "flag_id"}},
                                {"u_has_cash": {"context_val": "minimum_cash"}},
                            ]
                        },
                        "effect": [
                            {
                                "u_add_effect": {"context_val": "effect_id"},
                                "duration": {"context_val": "effect_duration"},
                                "intensity": {"context_val": "effect_intensity"},
                            },
                            {
                                "u_add_morale": {"context_val": "morale_id"},
                                "bonus": {"context_val": "morale_bonus"},
                                "max_bonus": {"context_val": "morale_max"},
                            },
                            {
                                "u_add_wound": {"context_val": "body_part"},
                                "wound_id": {"context_val": "wound_id"},
                            },
                            {
                                "custom_light_level": {"context_val": "light"},
                                "length": {"context_val": "light_duration"},
                            },
                        ],
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "dynamic_character_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn('services.types.id("item", tostring((context.data["item_id"])', main)
            self.assertIn('services.types.id("effect", tostring(', main)
            self.assertIn('services.registry.get("monster",', main)
            self.assertIn("services.overmap.search", main)
            self.assertIn("services.inventory.resources", main)
            self.assertIn('services.types.id("body_part", "torso")', main)
            self.assertIn("services.effects.add", main)
            self.assertIn("services.morale.add", main)
            self.assertIn("services.wounds.add", main)
            self.assertIn("set_light_override", main)

    def test_dynamic_item_callbacks_remain_item_scoped(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "dynamic_item_shapes",
                        "required_event": "character_wields_item",
                        "effect": [
                            {"u_activate": {"context_val": "method"}},
                            {"u_set_fault": {"context_val": "fault"}, "force": True},
                            {"u_set_random_fault_of_type": {"context_val": "fault_type"}},
                            {"transform_item": {"context_val": "target"}, "active": True},
                        ],
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "dynamic_item_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn("services.items.activate", main)
            self.assertIn("services.items.set_fault", main)
            self.assertIn("services.items.set_random_fault", main)
            self.assertIn("services.items.transform", main)

    def test_delayed_run_eocs_use_persistent_platform_tasks(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "delayed_target",
                            "required_event": "game_start",
                            "effect": {"message": "later"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "delayed_owner",
                            "required_event": "game_start",
                            "effect": {
                                "run_eocs": ["delayed_target"],
                                "time_in_future": "2 turns",
                            },
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "delayed_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn(
                'ccb.tasks.after(2, "migrated.delayed_target", '
                '{ __ccb_task = true, data = context.data }, 1, "world")',
                main,
            )
            self.assertIn(
                "if task_payload ~= nil and task_payload.__ccb_task == true",
                main,
            )

    def test_delayed_run_eocs_reacquire_characters_by_stable_id(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "npc_delayed_target",
                            "required_event": "npc_becomes_hostile",
                            "effect": {"npc_add_wet": 10},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "delayed_npc_owner",
                            "required_event": "game_start",
                            "effect": {
                                "run_eocs": ["npc_delayed_target"],
                                "time_in_future": "2 turns",
                            },
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "delayed_actor_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn("services.characters.snapshot(delayed_task_actor)", main)
            self.assertIn(
                "actor_character_id = delayed_task_actor_result.value.id",
                main,
            )
            self.assertIn(', 1, "character")', main)
            self.assertIn(
                "services.characters.by_id(task_payload.actor_character_id)",
                main,
            )
            self.assertNotIn("typed callback/task conversion", report)

    def test_delayed_run_eocs_reacquire_alpha_beta_character_talkers(
        self,
    ) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "delayed_talker_target",
                            "effect": {"npc_add_wet": 5},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "delayed_talker_owner",
                            "required_event": "character_takes_damage",
                            "effect": {
                                "run_eocs": "delayed_talker_target",
                                "alpha_talker": "npc",
                                "time_in_future": 10,
                            },
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]),
                "delayed_talker_mod",
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn(
                "services.characters.snapshot(selected_alpha)", main
            )
            self.assertIn(
                "services.characters.snapshot(selected_beta)", main
            )
            self.assertIn(
                "alpha_character_id = delayed_task_alpha_id", main
            )
            self.assertIn(
                "beta_character_id = delayed_task_beta_id", main
            )
            self.assertIn(
                "services.characters.by_id(task_payload.alpha_character_id)",
                main,
            )
            self.assertIn(
                "services.characters.by_id(task_payload.beta_character_id)",
                main,
            )
            self.assertIn(', 1, "character")', main)
            self.assertNotIn("typed callback/task conversion", report)

    def test_delayed_run_eocs_preserve_native_nonpersistent_actor_noop(self) -> None:
        cases = {
            "item": {
                "u_run_inv_eocs": "all",
                "true_eocs": ["delayed_target"],
            },
            "creature": {
                "u_run_monster_eocs": ["delayed_target"],
                "monster_range": 1,
            },
            "vehicle": {
                "u_run_vehicle_eocs": ["delayed_target"],
                "vehicle_range": 1,
            },
        }
        for actor_kind, traversal in cases.items():
            with self.subTest(actor_kind=actor_kind), tempfile.TemporaryDirectory() as temporary:
                source = Path(temporary) / "source.json"
                source.write_text(
                    json.dumps(
                        [
                            {
                                "type": "effect_on_condition",
                                "id": "delayed_target",
                                "effect": {"message": actor_kind},
                            },
                            {
                                "type": "effect_on_condition",
                                "id": "delayed_owner",
                                "required_event": "game_start",
                                "effect": [
                                    traversal,
                                    {
                                        "run_eocs": ["delayed_target"],
                                        "time_in_future": "2 turns",
                                    },
                                ],
                            },
                        ]
                    ),
                    encoding="utf-8",
                )
                result = migrate_lua_first.migrate(
                    migrate_lua_first.load_objects([source]),
                    f"delayed_{actor_kind}_mod",
                )
                main = result.files[Path("main.lua")]
                report = result.files[Path("MIGRATION_REPORT.md")]

                self.assertNotIn(
                    'ccb.tasks.after(2, "migrated.delayed_target"', main
                )
                self.assertNotIn("delayed or context-bound run_eocs", main)
                self.assertNotIn("typed callback/task conversion", report)

    def test_delayed_global_eoc_from_item_context_reacquires_avatar(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "global_delayed_target",
                            "global": True,
                            "effect": {"u_message": "target"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "global_delayed_owner",
                            "required_event": "game_start",
                            "effect": [
                                {
                                    "u_run_inv_eocs": "all",
                                    "true_eocs": ["global_delayed_target"],
                                },
                                {
                                    "run_eocs": "global_delayed_target",
                                    "time_in_future": "2 turns",
                                },
                            ],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]),
                "global_delayed_mod",
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn(
                "local delayed_task_actor = services.characters.avatar()",
                main,
            )
            self.assertIn("services.characters.snapshot(delayed_task_actor)", main)
            self.assertIn(', 1, "character")', main)
            self.assertNotIn("typed callback/task conversion", report)

    def test_recipe_result_eocs_join_the_private_callback_registry(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "recipe",
                            "id": "recipe_with_result_eoc",
                            "result": "test_item",
                            "category": "CC_OTHER",
                            "subcategory": "CSC_OTHER_OTHER",
                            "skill_used": "fabrication",
                            "difficulty": 0,
                            "time": "1 turns",
                            "result_eocs": [
                                {
                                    "id": "recipe_result_callback",
                                    "effect": {"message": "crafted"},
                                }
                            ],
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "recipe_callback_owner",
                            "required_event": "game_start",
                            "effect": {
                                "run_eocs": "recipe_result_callback"
                            },
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]),
                "recipe_callback_mod",
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertIn(
                'migrated_eoc_functions["recipe_result_callback"]', main
            )
            self.assertIn("migrated_eoc_recipe_result_callback(context, actor)", main)
            self.assertNotIn("typed callback/task conversion", report)

    def test_delayed_run_eocs_accept_dynamic_bounded_time_ranges(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "dynamic_delay_target",
                            "required_event": "game_start",
                            "effect": {"message": "later"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "dynamic_delay_owner",
                            "required_event": "game_start",
                            "effect": {
                                "run_eocs": "dynamic_delay_target",
                                "time_in_future": [
                                    {"global_val": "minimum_delay"},
                                    {"math": ["u_spell_level('delay_spell') * 2"]},
                                ],
                            },
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "dynamic_delay_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn("services.random.int(math.min(", main)
            self.assertIn("services.variables.get_global(\"minimum_delay\")", main)
            self.assertIn("services.gameplay.math.evaluate(\"u_spell_level", main)
            self.assertIn('ccb.tasks.after(', main)
            self.assertNotIn("typed callback/task conversion", report)

    def test_run_eocs_accept_bounded_dynamic_iterations_and_random_delays(
        self,
    ) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "loop_target_a",
                            "effect": {"message": "a"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "loop_target_b",
                            "effect": {"message": "b"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "loop_owner",
                            "required_event": "game_start",
                            "effect": [
                                {
                                    "run_eocs": ["loop_target_a", "loop_target_b"],
                                    "iterations": {"global_val": "loop_count"},
                                },
                                {
                                    "run_eocs": ["loop_target_a", "loop_target_b"],
                                    "time_in_future": ["1 turns", "3 turns"],
                                },
                                {
                                    "run_eocs": ["loop_target_a", "loop_target_b"],
                                    "time_in_future": ["1 turns", "3 turns"],
                                    "randomize_time_in_future": True,
                                },
                            ],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "loop_task_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn("local run_eocs_iterations = math.max(0, math.min(10000", main)
            self.assertIn('services.variables.get_global("loop_count")', main)
            self.assertEqual(main.count("ccb.tasks.after(delayed_task_turns"), 2)
            self.assertEqual(main.count("ccb.tasks.after(services.random.int("), 2)
            self.assertNotIn("typed callback/task conversion", report)

    def test_run_eocs_resolve_talker_and_location_overrides_fail_closed(
        self,
    ) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "talker_target",
                            "effect": {"message": "target"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "talker_failure",
                            "effect": {"message": "failure"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "talker_owner",
                            "required_event": "game_start",
                            "effect": [
                                {
                                    "run_eocs": "talker_target",
                                    "alpha_talker": "avatar",
                                    "beta_talker": {"global_val": "target_id"},
                                    "false_eocs": ["talker_failure"],
                                },
                                {
                                    "run_eocs": "talker_target",
                                    "alpha_talker": "",
                                    "beta_talker": "",
                                    "false_eocs": "talker_failure",
                                },
                                {
                                    "run_eocs": "talker_target",
                                    "beta_loc": {"context_val": "target_location"},
                                    "false_eocs": "talker_failure",
                                },
                                {
                                    "run_eocs": "talker_target",
                                    "alpha_loc": {"global_val": "source_location"},
                                    "false_eocs": "talker_failure",
                                },
                                {
                                    "run_eocs": "talker_target",
                                    "alpha_talker": "npc",
                                    "false_eocs": "talker_failure",
                                },
                            ],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "talker_task_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn("services.characters.by_id(run_eocs_beta_id)", main)
            self.assertIn("services.creatures.at(run_eocs_beta_location)", main)
            self.assertIn("services.creatures.at(run_eocs_alpha_location)", main)
            self.assertIn("if selected_alpha == nil and selected_beta == nil", main)
            self.assertIn("context.actors.alpha = selected_alpha", main)
            self.assertIn("context.actors.beta = selected_beta", main)
            self.assertIn("migrated_eoc_talker_failure(context, actor)", main)
            self.assertNotIn("typed callback/task conversion", report)

    def test_run_eocs_dispatch_dynamic_ids_only_within_migrated_callbacks(
        self,
    ) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "dynamic_target",
                            "required_event": "game_start",
                            "effect": {"message": "target"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "dynamic_owner",
                            "required_event": "game_start",
                            "effect": [
                                {
                                    "run_eocs": [
                                        {"context_val": "callback_id"}
                                    ]
                                },
                                {
                                    "run_eocs": [
                                        {"u_val": "callback_id"}
                                    ]
                                },
                            ],
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "dynamic_callback_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn("local migrated_eoc_functions = {}", main)
            self.assertIn(
                'migrated_eoc_functions["dynamic_target"] = '
                "migrated_eoc_dynamic_target",
                main,
            )
            self.assertIn(
                "local dynamic_eoc = migrated_eoc_functions[dynamic_eoc_id]",
                main,
            )
            self.assertIn("if dynamic_eoc ~= nil then", main)
            self.assertNotIn("game.eocs.activate", main)
            self.assertNotIn("typed callback/task conversion", report)

    def test_named_conditions_remain_callback_local_across_run_eocs(
        self,
    ) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "stored_condition_owner",
                            "required_event": "game_start",
                            "effect": [
                                {
                                    "set_condition": "stored_test",
                                    "condition": {"math": ["_context > 0"]},
                                },
                                {"run_eocs": "stored_condition_literal"},
                                {
                                    "run_eocs": "stored_condition_dynamic",
                                    "variables": {
                                        "condition_name": "stored_test"
                                    },
                                },
                            ],
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "stored_condition_literal",
                            "condition": {
                                "get_condition": "stored_test"
                            },
                            "effect": {"message": "literal"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "stored_condition_dynamic",
                            "condition": {
                                "get_condition": {
                                    "context_val": "condition_name"
                                }
                            },
                            "effect": {"message": "dynamic"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]),
                "stored_condition_mod",
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn("context.conditions = context.conditions or {}", main)
            self.assertIn(
                "context.conditions[stored_condition_name] = "
                "function(context, actor)",
                main,
            )
            self.assertIn(
                "conditions = context.conditions", main
            )
            self.assertIn(
                "context.conditions[stored_condition_name]", main
            )
            self.assertNotIn("native Lua predicate", report)

    def test_attack_events_use_proven_beta_creature_predicates(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "monster_attack_predicates",
                            "required_event": "character_melee_attacks_monster",
                            "condition": {
                                "and": [
                                    {"npc_has_effect": "stunned"},
                                    {"npc_has_species": "MAMMAL"},
                                    {"npc_has_flag": "SEES"},
                                    {"npc_is_on_terrain_with_flag": "DIGGABLE"},
                                    "npc_is_outside",
                                    "player_see_npc",
                                ]
                            },
                            "effect": {"message": "monster"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "character_attack_predicates",
                            "required_event": "character_melee_attacks_character",
                            "condition": {
                                "and": [
                                    {"npc_has_trait": "TOUGH"},
                                    "npc_is_alive",
                                ]
                            },
                            "effect": {"message": "character"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "monster_damage_species_predicate",
                            "required_event": "monster_takes_damage",
                            "condition": {"u_has_species": "PLANT"},
                            "effect": {"message": "species"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]),
                "attack_predicate_mod",
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn("context.actors.beta", main)
            self.assertIn("services.effects.has(context.actors.beta", main)
            self.assertIn("services.creatures.has_species(context.actors.beta", main)
            self.assertIn("services.creatures.has_species(actor", main)
            self.assertIn("services.creatures.has_flag(context.actors.beta", main)
            self.assertIn("services.world.tile_has_flag(", main)
            self.assertIn("services.creatures.can_see(", main)
            self.assertIn("services.mutations.has(", main)
            self.assertNotIn("native Lua predicate", report)

    def test_content_callback_fields_prove_alpha_beta_eoc_provenance(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "damage_type",
                            "id": "callback_damage",
                            "name": "callback damage",
                            "ondamage_eocs": ["damage_callback"],
                        },
                        {
                            "type": "technique",
                            "id": "callback_technique",
                            "name": "callback technique",
                            "eocs": ["technique_callback"],
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "damage_callback",
                            "condition": {
                                "and": [
                                    {"npc_has_flag": "SEES"},
                                    {"npc_has_trait": "TOUGH"},
                                ]
                            },
                            "effect": {"message": "damage"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "technique_callback",
                            "condition": {
                                "and": [
                                    "npc_is_outside",
                                    {
                                        "npc_is_on_terrain_with_flag":
                                        "DIGGABLE"
                                    },
                                ]
                            },
                            "effect": {"message": "technique"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]),
                "content_callback_predicate_mod",
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertIn("local actor = actor_override", main)
            self.assertIn("services.creatures.has_flag(", main)
            self.assertIn("services.mutations.has(", main)
            self.assertIn("services.world.tile_has_flag(", main)
            self.assertNotIn(
                "damage_callback condition needs a native Lua predicate",
                report,
            )
            self.assertNotIn(
                "technique_callback condition needs a native Lua predicate",
                report,
            )

    def test_run_eocs_variables_accept_bounded_translation_scalars(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "translation_target",
                            "required_event": "game_start",
                            "effect": {"u_message": {"context_val": "message"}},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "translation_owner",
                            "required_event": "game_start",
                            "effect": {
                                "run_eocs": "translation_target",
                                "variables": {
                                    "message": {"str": "translated", "i18n": True}
                                },
                            },
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "translation_scalar_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn('child_data["message"] = "translated"', main)

    def test_run_eocs_variables_accept_coordinate_and_math_scalars(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "typed_variable_target",
                            "required_event": "game_start",
                            "effect": {"message": "target"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "typed_variable_owner",
                            "required_event": "game_start",
                            "effect": {
                                "run_eocs": "typed_variable_target",
                                "variables": {
                                    "location": {"tripoint": [0, 10, 0]},
                                    "amount": {"math": ["2 + 2 - 1"]},
                                },
                            },
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]),
                "typed_variable_mod",
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn(
                'child_data["location"] = '
                "services.coords.tripoint_abs_ms(0, 10, 0)",
                main,
            )
            self.assertIn('child_data["amount"] = service_value(', main)
            self.assertIn('services.gameplay.math.evaluate("2 + 2 - 1"', main)

    def test_run_eocs_nonfinite_variables_report_the_safety_boundary(
        self,
    ) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "nonfinite_target",
                            "required_event": "game_start",
                            "effect": {"message": "target"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "nonfinite_owner",
                            "required_event": "game_start",
                            "effect": {
                                "run_eocs": "nonfinite_target",
                                "variables": {
                                    "positive_infinity": {"dbl": "+inf"},
                                    "not_a_number": {"dbl": "-nan"},
                                },
                            },
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]),
                "nonfinite_variable_mod",
            )
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.partial), 1)
            self.assertEqual(len(result.todos), 0)
            self.assertIn("non-finite values rejected", report)
            self.assertNotIn("typed callback/task conversion", report)

    def test_global_dynamic_recurrence_uses_persistent_self_scheduling(
        self,
    ) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "global_dynamic_recurrence",
                            "global": True,
                            "recurrence": [
                                {
                                    "global_val": "minimum_recurrence",
                                    "default": "5 days",
                                },
                                {"math": ["time_until('sunrise')"]},
                            ],
                            "effect": {"message": "tick"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "character_dynamic_recurrence",
                            "recurrence": {"math": ["time('20 d')"]},
                            "effect": {"message": "character tick"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]),
                "dynamic_recurrence_mod",
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertIn(
                'runtime.handler("migrated.global_dynamic_recurrence.recurring"',
                main,
            )
            self.assertIn("services.random.int(math.min(", main)
            self.assertIn(
                'services.variables.get_global("minimum_recurrence")', main
            )
            self.assertIn("services.gameplay.math.evaluate", main)
            self.assertIn(
                'ccb.state.character.get("recurrence.global_dynamic_recurrence.scheduled"',
                main,
            )
            self.assertIn(
                'ccb.tasks.after(next_recurrence, '
                '"migrated.global_dynamic_recurrence.recurring"',
                main,
            )
            self.assertNotIn(
                'ccb.tasks.every(',
                main.split(
                    "-- Extracted from", 2
                )[1],
            )
            self.assertNotIn(
                "global_dynamic_recurrence recurrence needs", report
            )
            self.assertIn(
                'runtime.handler("migrated.character_dynamic_recurrence.'
                'character_recurring"',
                main,
            )
            self.assertIn(
                'runtime.character_recurring('
                '"migrated.character_dynamic_recurrence.character_recurring"',
                main,
            )
            self.assertNotIn(
                "character_dynamic_recurrence recurrence needs", report
            )

    def test_recurrence_proves_actor_for_referenced_predicates(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "recurrence_predicate",
                            "condition": "u_is_outside",
                            "effect": [],
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "recurrence_predicate_wrapper",
                            "condition": {"test_eoc": "recurrence_predicate"},
                            "effect": [],
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "global_recurrence_owner",
                            "global": True,
                            "recurrence": "1 hour",
                            "condition": {
                                "test_eoc": "recurrence_predicate_wrapper"
                            },
                            "effect": {"u_message": "global tick"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "character_recurrence_owner",
                            "recurrence": "2 hours",
                            "condition": {"test_eoc": "recurrence_predicate"},
                            "effect": {"u_message": "character tick"},
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]),
                "recurrence_predicate_mod",
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertNotIn(
                "global_recurrence_owner condition needs a native Lua predicate",
                report,
            )
            self.assertNotIn(
                "character_recurrence_owner condition needs a native Lua predicate",
                report,
            )
            self.assertNotIn(
                "recurrence_predicate_wrapper condition needs a native Lua predicate",
                report,
            )
            self.assertGreaterEqual(
                main.count("services.gameplay.environment.is_outside("), 4
            )
            self.assertIn(
                "local actor = actor_override or services.characters.avatar()",
                main,
            )

    def test_content_callbacks_propagate_creature_talker_provenance(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "SPELL",
                            "id": "talker_spell",
                            "effect": "effect_on_condition",
                            "effect_str": "spell_talker_root",
                            "valid_targets": ["hostile"],
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "spell_talker_root",
                            "condition": {"npc_has_flag": "SEES"},
                            "effect": {
                                "run_eocs": [
                                    {
                                        "id": "spell_visibility_leaf",
                                        "condition": {
                                            "and": [
                                                "player_see_u",
                                                "player_see_npc",
                                            ]
                                        },
                                        "effect": {"message": "visible"},
                                    }
                                ]
                            },
                        },
                        {
                            "type": "monster_attack",
                            "id": "talker_attack",
                            "attack_type": "eoc",
                            "eoc": ["attack_talker_root"],
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "attack_talker_root",
                            "condition": "player_see_u",
                            "effect": {"message": "attack visible"},
                        },
                        {
                            "type": "talk_topic",
                            "id": "TALK_CALLBACK",
                            "responses": [
                                {
                                    "text": "continue",
                                    "topic": "TALK_DONE",
                                    "effect": {
                                        "run_eocs": "dialogue_talker_root"
                                    },
                                }
                            ],
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "dialogue_talker_root",
                            "effect": {
                                "if": "has_beta",
                                "then": {
                                    "if": {"npc_has_trait": "FAE"},
                                    "then": {"math": ["u_dialogue_flag = 1"]},
                                },
                            },
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]),
                "content_talker_mod",
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertNotIn(
                "spell_talker_root condition needs a native Lua predicate",
                report,
            )
            self.assertNotIn(
                "spell_visibility_leaf condition needs a native Lua predicate",
                report,
            )
            self.assertNotIn(
                "attack_talker_root condition needs a native Lua predicate",
                report,
            )
            self.assertNotIn(
                "dialogue_talker_root effect #0 needs conditional-control-flow conversion",
                report,
            )
            self.assertIn("context.actors.beta", main)
            self.assertIn("services.creatures.has_flag(", main)
            self.assertGreaterEqual(
                main.count(
                    "services.creatures.can_see(services.characters.avatar(), actor)"
                ),
                2,
            )

    def test_faction_camp_proximity_uses_the_typed_camp_query(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "camp_proximity",
                        "required_event": "game_start",
                        "condition": {
                            "u_near_om_location": "FACTION_CAMP_ANY",
                            "range": 2,
                        },
                        "effect": {"message": "near camp"},
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "camp_proximity_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn("services.camps.near(", main)
            self.assertIn("{ radius_omt = 2, limit = 1 }", main)

    def test_empty_math_condition_is_rejected_as_invalid_source_data(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "empty_math_condition",
                        "required_event": "game_start",
                        "condition": {"math": []},
                        "effect": {"message": "unreachable"},
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "empty_math_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.partial), 1)

    def test_if_effect_accepts_else_only_and_nested_else_only_branches(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "else_only",
                        "required_event": "game_start",
                        "effect": {
                            "if": {"compare_string": ["yes", "no"]},
                            "else": {
                                "if": {"compare_string_match_all": ["x", "y"]},
                                "else": {"math": ["global_value++"]},
                            },
                        },
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "else_only_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn("services.gameplay.strings.any_equal", main)
            self.assertIn("services.gameplay.strings.all_equal", main)
            self.assertIn("services.gameplay.math.apply", main)

    def test_phase_move_and_global_overmap_point_keep_avatar_context(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "phase_destination",
                        "required_event": "phase_move",
                        "effect": {
                            "if": {
                                "and": [
                                    {"u_has_effect": "attention"},
                                    {
                                        "overmap_at_point": "field",
                                        "point": {"global_val": "destination"},
                                    },
                                ]
                            },
                            "then": {"u_message": "valid"},
                        },
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "phase_point_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn("services.characters.avatar()", main)
            self.assertIn(
                'service_value(services.variables.get_global("destination")).value',
                main,
            )
            self.assertIn("services.overmap.matches(", main)

    def test_missing_test_eoc_is_reported_as_missing_content_not_control_flow(
        self,
    ) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "missing_predicate_owner",
                        "required_event": "game_start",
                        "effect": {
                            "if": {"test_eoc": "MISSING_PREDICATE"},
                            "then": {"u_message": "unreachable"},
                        },
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]),
                "missing_predicate_mod",
            )
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.partial), 1)
            self.assertIn(
                "references missing test_eoc definitions: MISSING_PREDICATE",
                report,
            )
            self.assertNotIn("conditional-control-flow conversion", report)

    def test_generic_talker_type_conditions_use_handle_kind_and_furniture_metadata(
        self,
    ) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "generic_talker_types",
                        "effect": [
                            {
                                "if": condition,
                                "then": {
                                    "set_string_var": "yes",
                                    "target_var": {
                                        "global_val": condition.removeprefix("u_is_")
                                    },
                                },
                            }
                            for condition in (
                                "u_is_avatar",
                                "u_is_npc",
                                "u_is_character",
                                "u_is_monster",
                                "u_is_item",
                                "u_is_furniture",
                                "u_is_vehicle",
                            )
                        ],
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]),
                "generic_talker_mod",
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertNotIn("conditional-control-flow conversion", report)
            self.assertIn('actor.kind == "creature"', main)
            self.assertIn('actor.kind == "item"', main)
            self.assertIn('actor.kind == "vehicle"', main)
            self.assertIn(
                'context.data["__ccb_talker_kind"] == "furniture"', main
            )
            self.assertIn(
                "requires callback context __ccb_talker_kind=furniture",
                report,
            )
            self.assertIn("needs an explicit Platform trigger", report)

    def test_unbound_mixed_eoc_keeps_a_fail_closed_condition_actor_contract(
        self,
    ) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "unbound_mixed_talkers",
                        "condition": {
                            "and": [
                                {"u_has_trait": "GOBLIN"},
                                {"u_has_item": "food"},
                            ]
                        },
                        "effect": [
                            {"u_remove_item_with": "food"},
                            {"npc_remove_item_with": "food"},
                        ],
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]),
                "unbound_condition_actor_mod",
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertIn("local actor = actor_override", main)
            self.assertIn("if actor == nil then", main)
            self.assertNotIn("needs a native Lua predicate", report)
            self.assertIn("needs an explicit Platform trigger", report)
            self.assertEqual(len(result.partial), 1)

    def test_false_effect_branches_use_the_same_typed_character_services(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "false_branch_services",
                        "required_event": "game_start",
                        "condition": {"u_has_cash": 1000000},
                        "false_effect": [
                            {"u_add_effect": {"context_val": "effect_id"}, "duration": "1 turn"},
                            {"u_add_wound": {"context_val": "body_part"}, "wound_id": {"context_val": "wound_id"}},
                            {"u_add_morale": {"context_val": "morale_id"}, "bonus": 1, "max_bonus": 2},
                            {"u_lose_var": "fallback"},
                        ],
                        "effect": "nothing",
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "false_branch_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn("services.effects.add", main)
            self.assertIn("services.wounds.add", main)
            self.assertIn("services.morale.add", main)
            self.assertIn('services.variables.remove(actor, "fallback")', main)

    def test_false_effect_reuses_inventory_spawn_recipe_and_world_renderers(
        self,
    ) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "false_domain_services",
                        "required_event": "game_start",
                        "condition": False,
                        "false_effect": [
                            {
                                "u_spawn_item": "reward",
                                "count": 2,
                                "suppress_message": True,
                            },
                            {"u_remove_item_with": "old_item"},
                            "u_cancel_activity",
                            {"u_add_trait": "NEW_TRAIT"},
                            {
                                "u_spawn_monster": "mon_test",
                                "real_count": 1,
                                "min_radius": 1,
                                "max_radius": 2,
                            },
                            {"u_consume_item": "food", "count": 1},
                            {"u_forget_recipe": "recipe_test"},
                            {
                                "alter_timed_events": "test_event",
                                "time_in_future": "1 minute",
                            },
                            {
                                "u_roll_remainder": ["TRAIT_A"],
                                "type": "mutation",
                            },
                            {
                                "u_transform_radius": 1,
                                "ter_furn_transform": "test_transform",
                            },
                            {
                                "u_lose_effect": ["effect_a", "effect_b"],
                            },
                            {
                                "u_message": "popup alias",
                                "type": "popup",
                            },
                            {
                                "sound_effect": "chainsaw_on",
                                "id": "chainsaw_cord",
                            },
                        ],
                        "effect": "nothing",
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]),
                "false_domains_mod",
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertNotIn("domain-service conversion", report)
            self.assertIn("services.inventory.give", main)
            self.assertIn("services.inventory.remove", main)
            self.assertIn("services.activities.cancel", main)
            self.assertIn("services.mutations.grant", main)
            self.assertIn("services.spawns.monster_configured", main)
            self.assertIn("services.inventory.consume", main)
            self.assertIn("services.recipes.forget", main)
            self.assertIn("services.time.reschedule", main)
            self.assertIn("remainder_candidates", main)
            self.assertIn("services.world.transform_radius", main)
            self.assertEqual(main.count("services.effects.remove"), 2)
            self.assertIn("ccb.presentation.notice", main)
            self.assertIn("services.sound.play_if_audible", main)

    def test_spawn_renderer_preserves_configured_dynamic_and_copy_workflows(
        self,
    ) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps([
                    {
                        "type": "effect_on_condition",
                        "id": "spawn_success",
                        "effect": "nothing",
                    },
                    {
                        "type": "effect_on_condition",
                        "id": "spawn_failure",
                        "effect": "nothing",
                    },
                    {
                        "type": "effect_on_condition",
                        "id": "spawn_workflows",
                        "required_event": "game_start",
                        "effect": [
                            {
                                "u_spawn_monster": "mon_test",
                                "real_count": [
                                    {"math": ["1"]},
                                    {"math": ["2"]},
                                ],
                                "summoner_is_alpha": True,
                                "lifespan": {"math": ["15"]},
                                "min_radius": 1,
                                "max_radius": 8,
                                "mon_variables": {
                                    "owner": {"context_val": "owner"},
                                },
                                "spawn_message": "one spawn",
                                "spawn_message_plural": "many spawns",
                                "true_eocs": ["spawn_success"],
                                "false_eocs": ["spawn_failure"],
                            },
                            {
                                "u_spawn_monster": "",
                                "hallucination_count": 1,
                                "target_range": 50,
                                "lifespan": 60,
                            },
                            {
                                "u_spawn_monster": "GROUP_ZOMBIE",
                                "group": True,
                                "single_target": True,
                                "real_count": 1,
                            },
                            {
                                "u_spawn_npc": "npc_test",
                                "real_count": 1,
                                "traits": ["HALLUCINATION"],
                                "true_eocs": ["spawn_success"],
                            },
                        ],
                    },
                ]),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]),
                "spawn_workflows_mod",
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn("summoner = actor", main)
            self.assertIn("services.variables.set(", main)
            self.assertIn('attitude = "hostile"', main)
            self.assertIn("services.spawns.choose_monster_from_group", main)
            self.assertIn("local spawn_min_radius = 1", main)
            self.assertIn("local spawn_max_radius = 10", main)
            self.assertIn("if total_spawns > 0 then", main)
            self.assertIn(
                "migrated_eoc_spawn_success(context, actor)", main
            )
            self.assertIn(
                "migrated_eoc_spawn_failure(context, actor)", main
            )
            self.assertIn("if visible_spawns > 1 then", main)
            self.assertNotIn(
                "services.spawns.monster_configured(services.spawns.monster_from_group",
                main,
            )

    def test_talker_scoped_teleport_and_directional_knockback_use_typed_values(
        self,
    ) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "coordinate_combat",
                        "required_event": "game_start",
                        "effect": [
                            {"u_teleport": {"u_val": "destination"}},
                            {
                                "u_knockback": {"math": ["force"]},
                                "stun": 1,
                                "dam_mult": 2,
                                "target_var": {"context_val": "target"},
                                "direction_var": {
                                    "context_val": "direction"
                                },
                            },
                        ],
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]),
                "coordinate_combat_mod",
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn(
                'services.variables.get(\n        actor, "destination")', main
            )
            self.assertIn('target = context.data["target"]', main)
            self.assertIn('direction = context.data["direction"]', main)

    def test_attack_event_beta_supports_effects_variables_and_dynamic_removal(
        self,
    ) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "attack_beta_mutations",
                        "required_event": "character_melee_attacks_monster",
                        "effect": [
                            {
                                "npc_add_effect": "marked",
                                "duration": "2 seconds",
                            },
                            {"npc_add_var": "hits", "value": "1"},
                            {
                                "npc_lose_effect": ["old_a", "old_b"],
                                "target_part": {"context_val": "part"},
                            },
                        ],
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]),
                "attack_beta_mod",
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertNotIn("domain-service conversion", report)
            self.assertIn("context.actors.beta", main)
            self.assertIn("services.effects.add", main)
            self.assertIn("services.variables.set", main)
            self.assertEqual(main.count("services.effects.remove"), 2)
            self.assertIn(
                'services.types.id("body_part", tostring((context.data["part"]',
                main,
            )

    def test_switch_branches_are_normalized_to_actor_aware_lua_callbacks(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps([
                    {
                        "type": "effect_on_condition",
                        "id": "switch_owner",
                        "required_event": "game_start",
                        "effect": {
                            "switch": {"math": ["u_health()"]},
                            "cases": [
                                {"case": 0, "effect": {"u_message": "zero"}},
                                {"case": 1, "effect": {"if": "u_is_outside", "then": {"u_message": "one"}}},
                            ],
                        },
                    }
                ]),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "switch_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertNotIn("switch-control-flow conversion", main)
            self.assertIn("services.gameplay.math.evaluate(\"u_health()\", actor", main)
            self.assertIn("local switch_case = 0", main)
            self.assertIn("switch_value >= (0)", main)
            self.assertIn("switch_value >= (1)", main)
            self.assertIn("switch_owner__switch__0", main)
            self.assertIn("switch_owner__switch__1", main)

    def test_switch_accepts_comments_and_keeps_selector_defaults_numeric(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "switch_metadata",
                        "required_event": "game_start",
                        "effect": [
                            {
                                "switch": {"math": ["rng(1,1)"]},
                                "//": "vestigial selector comment",
                                "cases": [
                                    {
                                        "case": 1,
                                        "effect": {"u_message": "random"},
                                    }
                                ],
                            },
                            {
                                "switch": {
                                    "global_val": "choice",
                                    "default": 0,
                                },
                                "cases": [
                                    {
                                        "case": 0,
                                        "effect": {"u_message": "fallback"},
                                    }
                                ],
                            },
                        ],
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]),
                "switch_metadata_mod",
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertNotIn("switch-control-flow conversion", report)
            self.assertIn('services.gameplay.math.evaluate("rng(1,1)"', main)
            self.assertIn('services.variables.get_global("choice")', main)
            self.assertNotIn("switch_default", main)

    def test_false_effect_switch_reuses_switch_renderer(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "false_switch",
                        "required_event": "game_start",
                        "condition": False,
                        "false_effect": {
                            "switch": {"math": ["u_health()"]},
                            "cases": [
                                {"case": 0, "effect": {"u_message": "zero"}},
                                {"case": 1, "effect": {"u_message": "one"}},
                            ],
                        },
                        "effect": "nothing",
                    }
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "false_switch_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn("local switch_case = 0", main)
            self.assertIn('services.message("zero")', main)
            self.assertNotIn("switch-control-flow conversion", report)

    def test_test_eoc_conditions_inline_the_referenced_native_predicate(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps([
                    {
                        "type": "effect_on_condition",
                        "id": "predicate_target",
                        "condition": {"u_has_trait": "TOUGH"},
                        "effect": [],
                    },
                    {
                        "type": "effect_on_condition",
                        "id": "predicate_owner",
                        "required_event": "game_start",
                        "condition": {"test_eoc": "predicate_target"},
                        "effect": {"u_message": "matched"},
                    },
                ]),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "predicate_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertNotIn("predicate_owner condition needs a native Lua predicate", main)
            self.assertIn('services.mutations.has(actor, services.types.id("mutation", "TOUGH"))', main)

    def test_referenced_character_eoc_inherits_callback_actor_without_standalone_handler(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps([
                    {
                        "type": "effect_on_condition",
                        "id": "nested_character_target",
                        "condition": {"and": ["u_is_alive", "npc_is_alive"]},
                        "effect": {"u_message": "callback actor"},
                    },
                    {
                        "type": "effect_on_condition",
                        "id": "nested_character_owner",
                        "required_event": "game_start",
                        "effect": {"run_eocs": ["nested_character_target"]},
                    },
                ]),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "nested_actor_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertNotIn(
                'runtime.handler("migrated.nested_character_target"', main
            )
            self.assertIn(
                "local actor = actor_override\n    if not ((service_value(services.characters.is_alive(actor)))",
                main,
            )
            self.assertIn(
                "migrated_eoc_nested_character_target(context, actor)", main
            )
            self.assertNotIn("needs an explicit Platform trigger", report)

    def test_lowers_bounded_run_eoc_iterations_to_one_lua_loop(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps([
                    {
                        "type": "effect_on_condition",
                        "id": "iteration_target",
                        "effect": {"u_message": "iteration"},
                    },
                    {
                        "type": "effect_on_condition",
                        "id": "iteration_owner",
                        "required_event": "game_start",
                        "effect": {
                            "run_eocs": ["iteration_target"],
                            "iterations": 3,
                            "condition": {"math": ["counter < 2"]},
                        },
                    },
                ]),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "iteration_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn("for _ = 1, 3 do", main)
            self.assertIn("then break end", main)
            self.assertEqual(main.count("migrated_eoc_iteration_target(context, actor)"), 1)

    def test_dynamic_location_search_and_global_teleport_targets_are_lowered(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps({
                    "type": "effect_on_condition",
                    "id": "dynamic_world_targets",
                    "required_event": "game_start",
                    "effect": [
                        {
                            "u_location_variable": {"global_val": "target"},
                            "target_params": {
                                "om_terrain": "forest",
                                "min_distance": 1,
                                "search_range": 1200,
                                "reveal_radius": {
                                    "global_val": "reveal_radius",
                                    "default": 0,
                                },
                            },
                        },
                        {"u_teleport": {"global_val": "target"}, "force": True},
                    ],
                }),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "world_target_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertNotIn("location-variable search through", main)
            self.assertIn("services.overmap.closest", main)
            self.assertIn("radius = 1200", main)
            self.assertIn("services.overmap.reveal(", main)
            self.assertIn("services.variables.get_global(\"target\")", main)
            self.assertIn("services.relocation.creature_at", main)

    def test_location_search_offsets_and_callbacks_use_typed_world_services(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps(
                    [
                        {
                            "type": "effect_on_condition",
                            "id": "location_success",
                            "required_event": "game_start",
                            "effect": {"message": "found"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "location_failure",
                            "required_event": "game_start",
                            "effect": {"message": "missing"},
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "location_owner",
                            "required_event": "game_start",
                            "effect": {
                                "u_location_variable": {"global_val": "target"},
                                "target_params": {
                                    "om_terrain": "forest",
                                    "om_terrain_match_type": "CONTAINS",
                                    "min_distance": 1,
                                    "search_range": 10,
                                    "offset_x": -1,
                                    "offset_y": 1,
                                },
                                "true_eocs": "location_success",
                                "false_eocs": "location_failure",
                            },
                        },
                    ]
                ),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "location_callback_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertEqual(len(result.converted), 3)
            self.assertEqual(result.partial, [])
            self.assertIn(
                "services.coords.tripoint_rel_omt(-1, 1, 0)", main
            )
            self.assertIn(
                "migrated_eoc_location_success(context, actor)", main
            )
            self.assertIn(
                "migrated_eoc_location_failure(context, actor)", main
            )
            self.assertNotIn("location-variable search through", report)

    def test_dynamic_spawn_item_shape_uses_typed_ids_and_numeric_expressions(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps({
                    "type": "effect_on_condition",
                    "id": "dynamic_spawn",
                    "required_event": "game_start",
                    "effect": {
                        "u_spawn_item": {"context_val": "item_id"},
                        "count": {"math": ["rand(3) + 1"]},
                    },
                }),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "dynamic_spawn_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertIn('services.types.id("item", tostring((context.data["item_id"])', main)
            self.assertIn('services.gameplay.math.evaluate("rand(3) + 1", actor', main)
            self.assertIn("services.inventory.give", main)

    def test_domain_renderers_accept_comments_dynamic_ids_and_native_activities(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps({
                    "type": "effect_on_condition",
                    "id": "domain_edges",
                    "required_event": "game_start",
                    "effect": [
                        {
                            "//en_us_u_message": "Comment-only translation aid",
                            "u_message": "A translated message",
                            "type": "good",
                        },
                        {
                            "//": "Recipe group marker",
                            "u_forget_recipe": "recipe_to_forget",
                        },
                        {
                            "u_lose_effect": [
                                {"context_val": "effect_to_remove"}
                            ],
                        },
                        {"u_add_trait": {"global_val": "trait_to_gain"}},
                        {
                            "u_add_effect": "large_intensity_effect",
                            "duration": 60,
                            "intensity": 50000,
                        },
                        {"//": "Native duration spelling", "turn_cost": "6 seconds"},
                        {"u_assign_activity": "ACT_TARGET_PRACTICE"},
                        {
                            "npc_emit": "emit_fog_plume",
                            "target_var": {"context_val": "death_loc"},
                        },
                        {
                            "transform_line": "test_transform",
                            "first": {"global_val": "first_point"},
                            "second": {"global_val": "second_point"},
                        },
                        {
                            "mirror_coordinates": {"context_val": "mirrored"},
                            "center_var": {"context_val": "center"},
                            "relative_var": {"context_val": "relative"},
                        },
                        {
                            "u_location_variable": {
                                "context_val": "raised_position"
                            },
                            "z_adjust": 2,
                            "outdoor_only": True,
                        },
                        {
                            "set_string_var": {
                                "mutator": "game_option",
                                "option": "USE_LANG",
                            },
                            "target_var": {"global_val": "option_value"},
                        },
                        {
                            "set_string_var": {
                                "mutator": "ma_technique_name",
                                "matec_id": {"global_val": "technique_id"},
                            },
                            "target_var": {"global_val": "technique_name"},
                        },
                        {
                            "set_string_var": {"mutator": "valid_technique"},
                            "target_var": {"context_val": "random_technique"},
                        },
                        {
                            "set_string_var": "<u_name>",
                            "parse_tags": True,
                            "target_var": {"global_val": "expanded_name"},
                        },
                    ],
                }),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "domain_edges_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertEqual(result.todos, [])
            self.assertIn(
                'services.messages.add("A translated message", "good")',
                main,
            )
            self.assertIn("services.recipes.forget", main)
            self.assertIn('context.data["effect_to_remove"]', main)
            self.assertIn('services.variables.get_global("trait_to_gain")', main)
            self.assertIn("intensity = 50000", main)
            self.assertIn("moves = -math.max", main)
            self.assertIn("math.floor((6)", main)
            self.assertIn("services.activities.target_practice(actor)", main)
            self.assertIn(
                'local emission_position = context.data["death_loc"]',
                main,
            )
            self.assertIn("services.world.emit(", main)
            self.assertIn(
                'services.variables.get_global(\n        "first_point")',
                main,
            )
            self.assertIn(
                'services.variables.get_global(\n        "second_point")',
                main,
            )
            self.assertIn("services.world.transform_line(", main)
            self.assertIn('local center = context.data["center"]', main)
            self.assertIn(
                'context.data["mirrored"] = center:scale_by(2):subtract(relative)',
                main,
            )
            self.assertIn(
                'context.data["raised_position"] = location', main
            )
            self.assertIn('services.options.get("USE_LANG")', main)
            self.assertIn(
                "services.martial_arts.technique_definition(", main
            )
            self.assertIn("services.characters.choose_technique(", main)
            self.assertIn("services.text.expand_for(", main)

    def test_dialogue_item_popup_uses_native_hand_in_notice(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps([
                    {
                        "type": "talk_topic",
                        "id": "TALK_HAND_IN",
                        "responses": [{
                            "text": "hand over",
                            "topic": "TALK_DONE",
                            "effect": {"run_eocs": "hand_in_item"},
                        }],
                    },
                    {
                        "type": "effect_on_condition",
                        "id": "hand_in_item",
                        "effect": {
                            "u_consume_item": "anvil",
                            "popup": True,
                        },
                    },
                ]),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "hand_in_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertFalse(
                any("EOC hand_in_item" in entry for entry in result.partial)
            )
            self.assertFalse(
                any(
                    "EOC hand_in_item" in entry and
                    "domain-service conversion" in entry
                    for entry in result.todos
                )
            )
            self.assertIn("services.inventory.hand_in(", main)
            self.assertIn(
                "actor, hand_in_recipient", main
            )
            self.assertIn(
                "local hand_in_recipient = context.actors.beta", main
            )
            self.assertIn("ccb.presentation.notice(hand_in.notice)", main)

    def test_talker_pair_attack_targets_beta_and_monster_attack_is_native_noop(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps([
                    {
                        "type": "talk_topic",
                        "id": "TALK_ATTACK",
                        "responses": [{
                            "text": "attack",
                            "topic": "TALK_DONE",
                            "effect": {"run_eocs": "pair_attack"},
                        }],
                    },
                    {
                        "type": "effect_on_condition",
                        "id": "pair_attack",
                        "effect": {"u_attack": {"context_val": "technique"}},
                    },
                    {
                        "type": "monster_attack",
                        "id": "monster_attack_owner",
                        "attack_type": "eoc",
                        "eoc": ["monster_attack_noop"],
                    },
                    {
                        "type": "effect_on_condition",
                        "id": "monster_attack_noop",
                        "effect": [
                            {
                                "npc_location_variable": {
                                    "context_val": "target_position"
                                }
                            },
                            {"u_attack": "monster_technique"},
                        ],
                    },
                ]),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "attack_talker_mod"
            )
            main = result.files[Path("main.lua")]
            report = result.files[Path("MIGRATION_REPORT.md")]

            self.assertNotIn(
                "EOC pair_attack effect #0 needs domain-service conversion",
                report,
            )
            self.assertNotIn(
                "EOC monster_attack_noop effect #1 needs domain-service conversion",
                report,
            )
            self.assertEqual(main.count("services.characters.attack("), 2)
            self.assertIn("actor, context.actors.beta", main)
            self.assertIn('context.data["technique"]', main)
            self.assertIn(
                'if attack_snapshot.kind ~= "monster" then', main
            )
            self.assertIn(
                "(context.actors and context.actors.beta) or actor", main
            )
            self.assertIn('context.data["target_position"]', main)

    def test_adjacent_selectors_filter_candidates_and_honor_explicit_centers(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(
                json.dumps([
                    {
                        "type": "effect_on_condition",
                        "id": "conditional_adjacent",
                        "required_event": "game_start",
                        "effect": {
                            "u_choose_adjacent_highlight": {
                                "context_val": "selected_tree"
                            },
                            "condition": {
                                "map_terrain_with_flag": "TREE",
                                "loc": {"context_val": "loc"},
                            },
                            "message": "Select tree",
                            "failure_message": "No tree",
                        },
                    },
                    {
                        "type": "effect_on_condition",
                        "id": "centered_adjacent",
                        "required_event": "npc_becomes_hostile",
                        "effect": {
                            "npc_choose_adjacent_highlight": {
                                "context_val": "direction"
                            },
                            "target_var": {"context_val": "center"},
                            "message": "Select direction",
                        },
                    },
                ]),
                encoding="utf-8",
            )
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "adjacent_mod"
            )
            main = result.files[Path("main.lua")]

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(result.partial, [])
            self.assertIn('context.data["loc"] = candidate', main)
            self.assertIn(
                "services.gameplay.environment.terrain_has_flag", main
            )
            self.assertIn("services.targeting.choose_adjacent_where_at", main)
            self.assertIn('local center = context.data["center"]', main)
            self.assertIn('context.data["direction"] = selected', main)


if __name__ == "__main__":
    unittest.main()
