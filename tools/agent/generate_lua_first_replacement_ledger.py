#!/usr/bin/env python3
"""Generate the exact Lua-first disposition ledger from checked inventories."""

from __future__ import annotations

import argparse
import json
from pathlib import Path

import yaml


ROOT = Path(__file__).resolve().parents[2]
OUTPUT = ROOT / "ai" / "lua-first-replacement-ledger.yml"
INVENTORIES = {
    "json-object-types": (
        ROOT / "data/reference/json/ccb_json_object_types.json",
        "type",
    ),
    "eoc-conditions": (
        ROOT / "data/reference/json/ccb_eoc_conditions.json",
        "key",
    ),
    "eoc-effects": (
        ROOT / "data/reference/json/ccb_eoc_effects.json",
        "key",
    ),
}

CONTROL_FLOW = {
    "and",
    "or",
    "not",
    "if",
    "foreach",
    "switch",
    "weighted_list_eocs",
}

IMPLEMENTED_JSON = {
    "MOD_INFO": {
        "target": "platform.mod-metadata",
        "evidence": [
            "src/catalua_platform.cpp",
            "src/mod_manager.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "ITEM": {
        "target": "content.items",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "recipe": {
        "target": "content.recipes",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "tool_quality": {
        "target": "content.tool-qualities",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/requirements.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "skill_display_type": {
        "target": "content.skill-display-categories",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/skill.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "skill": {
        "target": "content.skills",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/skill.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "vitamin": {
        "target": "content.vitamins",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/vitamin.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "json_flag": {
        "target": "content.flags",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/flag.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "damage_type": {
        "target": "content.damage-types",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/damage.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "material": {
        "target": "content.materials",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/material.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "ammunition_type": {
        "target": "content.ammunition-types",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/ammo.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "ITEM_CATEGORY": {
        "target": "content.item-categories",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/item_category.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "recipe_category": {
        "target": "content.recipe-categories",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/crafting_gui.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "proficiency_category": {
        "target": "content.proficiency-categories",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/proficiency.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "proficiency": {
        "target": "content.proficiencies",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/proficiency.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "weapon_category": {
        "target": "content.weapon-categories",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/martialarts.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "requirement": {
        "target": "content.requirements",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/requirements.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "recipe_group": {
        "target": "content.recipe-groups",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/recipe_groups.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "scent_type": {
        "target": "content.scent-types",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/scent_map.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "speed_description": {
        "target": "content.speed-descriptions",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/speed_description.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "harvest_drop_type": {
        "target": "content.harvest-drop-types",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/harvest.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "harvest": {
        "target": "content.harvest-lists",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/harvest.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "behavior": {
        "target": "content.behavior-trees",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/behavior.cpp",
            "src/behavior_oracle.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "monster_attack": {
        "target": "content.monster-attacks",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/monstergenerator.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "effect_type": {
        "target": "content.effect-types",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/effect.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "weakpoint_set": {
        "target": "content.weakpoint-sets",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/weakpoint.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "field_type": {
        "target": "content.field-types",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/field_type.cpp",
            "src/map_field.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "item_group": {
        "target": "content.item-groups",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/item_factory.cpp",
            "src/item_group.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "sub_body_part": {
        "target": "content.sub-body-parts",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/subbodypart.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "body_part": {
        "target": "content.body-parts",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/bodypart.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "anatomy": {
        "target": "content.anatomies",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/anatomy.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "body_graph": {
        "target": "content.body-graphs",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/bodygraph.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "MONSTER": {
        "target": "content.monsters",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/monstergenerator.cpp",
            "src/mtype.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "morale_type": {
        "target": "content.morale-types",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/morale_types.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "disease_type": {
        "target": "content.disease-types",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/disease.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "monster_flag": {
        "target": "content.monster-flags",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/monstergenerator.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "SPECIES": {
        "target": "content.species",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/monstergenerator.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "emit": {
        "target": "content.emissions",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/emit.cpp",
            "src/map_field.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "MONSTER_FACTION": {
        "target": "content.monster-factions",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/monfaction.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "mutation_type": {
        "target": "content.mutation-types",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/mutation_type.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "connect_group": {
        "target": "content.connect-groups",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/mapdata.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "mutation_category": {
        "target": "content.mutation-categories",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/mutation_data.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "construction_category": {
        "target": "content.construction-categories",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/construction_category.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "construction_group": {
        "target": "content.construction-groups",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/construction_group.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "vehicle_part_location": {
        "target": "content.vehicle-part-locations",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/vehicle_part_location.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "mood_face": {
        "target": "content.mood-faces",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/mood_face.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "damage_info_order": {
        "target": "content.damage-info-presentation",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/damage.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "vehicle_part_category": {
        "target": "content.vehicle-part-categories",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/veh_type.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "named_color": {
        "target": "content.named-colors",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/hsv_color.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "rotatable_symbol": {
        "target": "content.rotatable-symbols",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/rotatable_symbols.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "ascii_art": {
        "target": "content.ascii-art",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/ascii_art.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "limb_score": {
        "target": "content.limb-scores",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/bodypart.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "hit_range": {
        "target": "content.hit-range",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/creature.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "bash_damage_profile": {
        "target": "content.bash-damage-profiles",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/map_accessories.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "clothing_mod": {
        "target": "content.clothing-modifications",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/clothing_mod.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "overmap_land_use_code": {
        "target": "content.overmap-land-use-codes",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/overmap_terrain.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "oter_vision": {
        "target": "content.overmap-vision",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/overmap_terrain.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "overmap_location": {
        "target": "content.overmap-locations",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/overmap_location.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "profession_group": {
        "target": "content.profession-groups",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/profession_group.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "map_extra_collection": {
        "target": "content.map-extra-collections",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/regional_settings.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "vehicle_group": {
        "target": "content.vehicle-groups",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/vehicle_group.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "fault_group": {
        "target": "content.fault-groups",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/fault.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "explosion_light": {
        "target": "content.explosion-lights",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/explosion_light.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "ammo_effect": {
        "target": "content.ammunition-effects",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/ammo_effect.cpp",
            "src/projectile.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "addiction_type": {
        "target": "content.addiction-types",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/addiction.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "character_mod": {
        "target": "content.character-modifiers",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/character_modifier.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "start_location": {
        "target": "content.start-locations",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/start_location.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "climbing_aid": {
        "target": "content.climbing-aids",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/climbing.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "weather_type": {
        "target": "content.weather-types",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/weather_type.cpp",
            "src/weather_gen.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "score": {
        "target": "content.scores",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/event_statistics.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "overlay_order": {
        "target": "content.overlay-order",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/overlay_ordering.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "LOOT_ZONE": {
        "target": "content.zone-types",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/clzones.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "speech": {
        "target": "content.speech-pools",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/speech.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "end_screen": {
        "target": "content.end-screens",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/end_screen.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "activity_type": {
        "target": "content.activity-types",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/activity_type.cpp",
            "src/player_activity.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "help": {
        "target": "content.help-topics",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/help.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "snippet": {
        "target": "content.snippet-categories",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/text_snippets.cpp",
            "src/item_info.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "playlist": {
        "target": "content.playlists",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/sdlsound.cpp",
            "src/sounds.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "nested_category": {
        "target": "content.nested-recipe-categories",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/recipe.cpp",
            "src/recipe_dictionary.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "attack_vector": {
        "target": "content.attack-vectors",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/martialarts.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "magic_type": {
        "target": "content.magic-types",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/magic_type.cpp",
            "src/magic.cpp",
            "src/activity_actor.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
    "movement_mode": {
        "target": "content.movement-modes",
        "evidence": [
            "src/catalua_platform_runtime.cpp",
            "src/move_mode.cpp",
            "data/lua/types/ccb_platform_v1.d.lua",
            "tests/catalua_ui_test.cpp",
            "tools/migrate_lua_first.py",
            "data/lua/LUA_FIRST_PLATFORM.md",
        ],
    },
}

NATIVE_PRIMITIVE_DOMAINS = {
    "items",
    "crafting",
    "map",
    "vehicles",
    "missions",
    "characters",
    "creatures",
    "camps",
    "time-weather",
    "magic",
    "bionics",
    "mutations",
    "skills",
    "audio",
    "factions",
    "state-and-values",
    "presentation",
}

NATIVE_PRIMITIVE_EVIDENCE = [
    "src/catalua_platform_runtime.cpp",
    "src/catalua_game_handle.cpp",
    "data/lua/types/ccb_platform_v1.d.lua",
    "tests/catalua_ui_test.cpp",
    "data/lua/LUA_FIRST_PLATFORM.md",
]


def service_for(selector: str) -> str:
    value = selector.lower()
    groups = (
        (("item", "inventory", "wield", "weapon", "armor", "ammo"), "items"),
        (("recipe", "craft", "disassembly"), "crafting"),
        (("map", "terrain", "furniture", "field", "location"), "map"),
        (("vehicle", "veh_"), "vehicles"),
        (("mission",), "missions"),
        (("npc", "u_", "character", "talker"), "characters"),
        (("monster", "mon_", "mtype"), "creatures"),
        (("camp", "companion"), "camps"),
        (("weather", "season", "day", "time", "lightning"), "time-weather"),
        (("spell", "magic"), "magic"),
        (("bionic", "cbm"), "bionics"),
        (("mutation", "trait"), "mutations"),
        (("skill", "proficiency", "martial"), "skills"),
        (("sound", "music"), "audio"),
        (("faction",), "factions"),
        (("var", "state", "math", "debt"), "state-and-values"),
        (("message", "popup", "query", "menu"), "presentation"),
    )
    for needles, domain in groups:
        if any(needle in value for needle in needles):
            return domain
    return "gameplay"


def legacy_evidence(entry: dict) -> list[str]:
    evidence: list[str] = []
    for registration in entry.get("registrations", []):
        source = registration.get("source", {})
        if source.get("path"):
            evidence.append(source["path"])
    for symbol in entry.get("handlers", []):
        if symbol:
            evidence.append(str(symbol))
    return sorted(set(evidence))[:8]


def disposition(inventory: str, selector: str, entry: dict) -> dict:
    if inventory == "json-object-types":
        if selector in IMPLEMENTED_JSON:
            implemented = IMPLEMENTED_JSON[selector]
            return {
                "inventory": inventory,
                "selector": selector,
                "target_kind": "platform_domain",
                "target": implemented["target"],
                "status": "implemented_unverified",
                "legacy_dependency": "none",
                "evidence": implemented["evidence"],
            }
        if selector in {"EXTERNAL_OPTION", "WORLD_OPTION", "colordef", "test_data"}:
            return {
                "inventory": inventory,
                "selector": selector,
                "target_kind": "not_applicable",
                "target": "engine-owned-configuration",
                "status": "reviewed_not_applicable",
                "legacy_dependency": "none",
                "evidence": legacy_evidence(entry),
            }
        return {
            "inventory": inventory,
            "selector": selector,
            "target_kind": "platform_domain",
            "target": f"content.{service_for(selector)}",
            "status": "planned",
            "legacy_dependency": "public_legacy",
            "evidence": legacy_evidence(entry),
        }

    if selector in CONTROL_FLOW:
        return {
            "inventory": inventory,
            "selector": selector,
            "target_kind": "not_applicable",
            "target": "native-lua-control-flow",
            "status": "reviewed_not_applicable",
            "legacy_dependency": "none",
            "evidence": legacy_evidence(entry),
        }
    domain = service_for(selector)
    if domain in NATIVE_PRIMITIVE_DOMAINS:
        return {
            "inventory": inventory,
            "selector": selector,
            "target_kind": "shared_service",
            "target": f"services.{domain}",
            "status": "primitive_available_unverified",
            "legacy_dependency": "none",
            "evidence": NATIVE_PRIMITIVE_EVIDENCE,
        }
    return {
        "inventory": inventory,
        "selector": selector,
        "target_kind": "shared_service",
        "target": f"services.{domain}",
        "status": "planned",
        "legacy_dependency": "public_legacy",
        "evidence": legacy_evidence(entry),
    }


def build_ledger() -> dict:
    entries: list[dict] = []
    sources: list[dict] = []
    for inventory, (path, selector_field) in INVENTORIES.items():
        document = json.loads(path.read_text(encoding="utf-8"))
        source_entries = document["entries"]
        sources.append(
            {
                "id": inventory,
                "path": str(path.relative_to(ROOT)),
                "selector": selector_field,
                "source_fingerprint": document["source"]["source_fingerprint"],
                "entry_count": len(source_entries),
            }
        )
        for entry in source_entries:
            selector = entry[selector_field]
            entries.append(disposition(inventory, selector, entry))
    entries.sort(key=lambda value: (value["inventory"], value["selector"]))
    return {
        "$schema": "lua-first-replacement-ledger.schema.json",
        "schema_version": 1,
        "kind": "lua_first_replacement_ledger",
        "contract": (
            "Every checked legacy selector appears exactly once. Planned entries are "
            "migration work, not shipped Platform APIs. Primitive-available entries "
            "have native composition building blocks but are not claims of selector-level parity."
        ),
        "sources": sources,
        "summary": {
            "total": len(entries),
            "implemented_unverified": sum(
                entry["status"] == "implemented_unverified" for entry in entries
            ),
            "primitive_available_unverified": sum(
                entry["status"] == "primitive_available_unverified"
                for entry in entries
            ),
            "planned": sum(entry["status"] == "planned" for entry in entries),
            "private_adapter": sum(
                entry["status"] == "private_adapter" for entry in entries
            ),
            "reviewed_not_applicable": sum(
                entry["status"] == "reviewed_not_applicable" for entry in entries
            ),
        },
        "entries": entries,
    }


def render(ledger: dict) -> str:
    return yaml.safe_dump(ledger, sort_keys=False, allow_unicode=True, width=100)


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    expected = render(build_ledger())
    if args.check:
        if not OUTPUT.exists() or OUTPUT.read_text(encoding="utf-8") != expected:
            print(f"stale generated ledger: {OUTPUT.relative_to(ROOT)}")
            return 1
        return 0
    OUTPUT.write_text(expected, encoding="utf-8")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
