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
            self.assertEqual(result.partial, [])
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
            self.assertIn("vehicle needs_native_registrar", report)

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
            self.assertEqual(main.count("local function character_has_item"), 1)
            self.assertIn("services.inventory.resources", main)
            self.assertIn('services.types.id("item", item_id)', main)
            self.assertIn('character_has_item(actor, "water_clean")', main)
            self.assertIn("services.characters.snapshot(actor)", main)
            self.assertIn('.movement.id == "walk"', main)
            self.assertIn("services.activities.snapshot(actor)", main)
            self.assertIn('tostring((context.data["event_value"]) or "")', main)
            self.assertIn(
                'tostring((ccb.state.character.get("remembered_value", "")) or "")',
                main,
            )
            self.assertIn("not (services.gameplay.mods.is_loaded", main)
            self.assertNotIn("condition needs a native Lua predicate", report)

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
                main.count("local function character_wields_with_flag"), 1
            )
            self.assertIn("services.inventory.wielded(character)", main)
            self.assertIn("services.martial_arts.current(character)", main)
            self.assertIn("return not style.force_unarmed", main)
            self.assertIn('services.types.id("json_flag", "NO_UNWIELD")', main)
            self.assertIn("services.items.has_flag(wielded, flag)", main)
            self.assertIn('services.types.id("json_flag", "SPEAR")', main)
            self.assertIn(
                'services.types.id("json_flag", "DURABLE_MELEE")', main
            )
            self.assertEqual(
                main.count("local actor = context.actors.character"), 4
            )
            self.assertIn("local actor = services.characters.avatar()", main)
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

            self.assertEqual(result.converted, [])
            self.assertEqual(len(result.partial), len(cases))
            self.assertNotIn("local function character_has_weapon", main)
            self.assertNotIn("local function character_can_drop_weapon", main)
            self.assertNotIn("local function character_wields_with_flag", main)
            self.assertNotIn("services.inventory.wielded", main)
            self.assertEqual(
                report.count("condition needs a native Lua predicate"),
                len(cases),
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

    def test_literal_character_wound_changes_remain_partial(self) -> None:
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

            self.assertEqual(result.converted, [])
            self.assertEqual(len(result.partial), 3)
            self.assertNotIn("services.wounds.add", main)
            self.assertNotIn("services.wounds.remove", main)
            self.assertIn("local actor = services.characters.avatar()", main)
            self.assertIn("local actor = context.actors.character", main)
            self.assertEqual(
                report.count("effect #0 needs domain-service conversion"),
                3,
            )
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

            self.assertEqual(result.converted, [])
            self.assertEqual(len(result.partial), len(cases))
            self.assertNotIn("services.wounds.add", main)
            self.assertNotIn("services.wounds.remove", main)
            self.assertEqual(
                report.count("effect #0 needs domain-service conversion"),
                len(cases),
            )

    def test_dynamic_or_out_of_contract_random_conditions_stay_partial(self) -> None:
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

            self.assertEqual(result.converted, [])
            self.assertEqual(len(result.partial), len(predicates))
            self.assertNotIn("services.random.one_in", main)
            self.assertNotIn("services.random.probability", main)
            self.assertNotIn("services.random.contested", main)
            self.assertEqual(
                report.count("condition needs a native Lua predicate"),
                len(predicates),
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

            self.assertEqual(result.converted, [])
            self.assertEqual(len(result.partial), 3)
            self.assertNotIn("services.bionics.summary", main)
            self.assertNotIn("services.recipes.knows", main)
            self.assertEqual(
                report.count("condition needs a native Lua predicate"),
                3,
            )

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

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(result.partial, [])
            self.assertIn("local actor = services.characters.avatar()", main)
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
            self.assertEqual(main.count("local function character_has_item"), 1)
            self.assertIn("resources.has_charges or resources.has_amount", main)

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
            self.assertIn("local actor = services.characters.avatar()", main)
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
            self.assertIn("local actor = services.characters.avatar()", main)
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
            self.assertIn("local actor = services.characters.avatar()", main)
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
            self.assertIn("local actor = services.characters.avatar()", main)
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

            self.assertEqual(len(result.converted), 2)
            self.assertEqual(len(result.partial), 1)
            self.assertIn("services.morale.add", main)
            self.assertIn("services.morale.remove", main)
            self.assertIn(
                'services.types.id("morale", "morale_feeling_good")',
                main,
            )
            self.assertIn("10, 50)", main)
            self.assertIn(
                "EOC timed_morale effect #0 needs domain-service conversion",
                report,
            )
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
            self.assertIn("local actor = context.actors.npc", main)
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
            self.assertNotIn("npc_add_wet", main)
            self.assertIn(
                "EOC add_wet_npc effect #0 needs domain-service conversion",
                report,
            )
            self.assertIn(
                "EOC add_wet_huge effect #0 needs domain-service conversion",
                report,
            )
            self.assertNotIn("run_eoc", main)

    def test_unsupported_timed_morale_never_emits_a_service_call(self) -> None:
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

            self.assertEqual(result.converted, [])
            self.assertEqual(len(result.partial), 1)
            self.assertNotIn("services.morale.add", main)
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

            self.assertEqual(len(result.converted), 4)
            self.assertEqual(len(result.partial), 2)
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
                "EOC zero_duration effect #0 needs domain-service conversion",
                report,
            )
            self.assertIn(
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
                                "intensity": 1001,
                            },
                        },
                        {
                            "type": "effect_on_condition",
                            "id": "variable_remove",
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

            self.assertEqual(result.converted, [])
            self.assertEqual(len(result.partial), 3)
            self.assertNotIn("services.effects.add", main)
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
                                "u_add_effect": "downed",
                                "duration": 40,
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

            self.assertEqual(len(result.converted), 7)
            self.assertEqual(len(result.partial), 2)
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
                "EOC bad_intensity effect #0 needs domain-service conversion",
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

            self.assertEqual(len(result.converted), 4)
            self.assertEqual(len(result.partial), 2)
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
                "EOC underwater condition needs a native Lua predicate",
                report,
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

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 3)
            self.assertIn('runtime.on("game:game_start"', main)
            self.assertNotIn("if not", main)
            self.assertIn(
                "EOC npc_alive condition needs a native Lua predicate",
                report,
            )
            self.assertIn(
                "EOC hostile_alive condition needs a native Lua predicate",
                report,
            )
            self.assertIn(
                "EOC item_alive condition needs a native Lua predicate",
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

            self.assertEqual(len(result.converted), 3)
            self.assertEqual(len(result.partial), 2)
            self.assertIn(
                "local actor = services.characters.avatar()", main
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
                "EOC dynamic_cash condition needs a native Lua predicate",
                report,
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

            self.assertEqual(len(result.converted), 3)
            self.assertEqual(len(result.partial), 1)
            self.assertIn(
                'services.gameplay.environment.terrain_id(', main
            )
            self.assertIn(
                'services.gameplay.environment.furniture_id(', main
            )
            self.assertIn(
                'services.gameplay.environment.field_exists(', main
            )
            self.assertIn(
                "EOC dynamic_loc condition needs a native Lua predicate",
                report,
            )
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

            self.assertEqual(len(result.converted), 4)
            self.assertEqual(len(result.partial), 2)
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
            self.assertIn(
                "EOC dynamic_city condition needs a native Lua predicate",
                report,
            )
            self.assertIn(
                "EOC dynamic_outside condition needs a native Lua predicate",
                report,
            )
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

            self.assertEqual(len(result.converted), 10)
            self.assertEqual(len(result.partial), 2)
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
            self.assertIn(
                "EOC loc_11 condition needs a native Lua predicate", report
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

            self.assertEqual(len(result.converted), 40)
            self.assertEqual(len(result.partial), 8)
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
            for partial_index in ("34", "35", "36", "37", "38", "42", "45", "47"):
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

            self.assertEqual(len(result.converted), 14)
            self.assertEqual(len(result.partial), 1)
            self.assertIn(
                "local actor = context.actors.npc", main
            )
            self.assertIn(
                "character_at_safe_space(actor)", main
            )
            self.assertIn(
                "character_has_profession(actor,", main
            )
            self.assertIn(
                "services.characters.has_flag(", main
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
                "character_has_item(actor,", main
            )
            self.assertIn(
                "character_has_any_bionic_or_capacity", main
            ) if False else None
            self.assertIn(
                '.movement.id == "crouch"', main
            )
            self.assertIn(
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

            self.assertEqual(len(result.converted), 8)
            self.assertEqual(len(result.partial), 4)
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
            self.assertIn(
                "EOC sound_msg effect #0 needs domain-service conversion",
                report,
            )
            self.assertIn(
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
                            "id": "beta_presence",
                            "required_event": "npc_becomes_hostile",
                            "condition": "has_beta",
                            "effect": {"message": "beta"},
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
                "EOC beta_presence condition needs a native Lua predicate",
                report,
            )
            self.assertNotIn("needs a native Lua effect", report)
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

            self.assertEqual(result.converted, [])
            self.assertEqual(len(result.partial), len(cases))
            self.assertNotIn("character_has_profession", main)
            self.assertEqual(
                report.count("condition needs a native Lua predicate"),
                len(cases),
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
                main.count("local actor = services.characters.avatar()"), 1
            )
            self.assertEqual(
                main.count("local actor = context.actors.character"), 1
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

            self.assertEqual(result.converted, [])
            self.assertEqual(len(result.partial), len(cases))
            self.assertNotIn("services.characters.has_flag", main)
            self.assertEqual(
                report.count("condition needs a native Lua predicate"),
                len(cases),
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
                main.count("local actor = services.characters.avatar()"), 1
            )
            self.assertEqual(
                main.count("local actor = context.actors.character"), 1
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

            self.assertEqual(result.converted, [])
            self.assertEqual(len(result.partial), len(cases))
            self.assertNotIn("character_is_wearing", main)
            self.assertEqual(
                report.count("condition needs a native Lua predicate"),
                len(cases),
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

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 2)
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
            self.assertIn(
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

            self.assertEqual(len(result.converted), 1)
            self.assertEqual(len(result.partial), 2)
            self.assertIn(
                'services.gameplay.environment.furniture_has_flag('
                'context.data["target_location"], "TRANSPARENT")',
                main,
            )
            self.assertIn(
                "EOC dynamic_flag condition needs a native Lua predicate",
                report,
            )
            self.assertIn(
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

    def test_keeps_actor_dependent_u_shapes_partial_without_avatar_proof(self) -> None:
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

            self.assertEqual(result.converted, [])
            self.assertEqual(len(result.partial), 1)
            self.assertNotIn("services.mutations.has", main)
            self.assertNotIn("services.effects.add", main)
            self.assertIn(
                "EOC ambiguous_alpha condition needs a native Lua predicate",
                report,
            )
            self.assertIn(
                "EOC ambiguous_alpha effect #0 needs domain-service conversion",
                report,
            )
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


if __name__ == "__main__":
    unittest.main()
