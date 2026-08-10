from __future__ import annotations

import json
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

import migrate_lua_first


class LuaFirstMigrationTest(unittest.TestCase):
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
            self.assertIn("native disassembly registrar", report)

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
                    "monster attack sample_lua_attack" in todo
                    and "named Lua handler" in todo
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


if __name__ == "__main__":
    unittest.main()
