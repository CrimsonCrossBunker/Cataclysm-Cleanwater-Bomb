#!/usr/bin/env python3
"""Generate the entry-level CCB coverage audit for the pinned CBN API."""

from __future__ import annotations

import argparse
import fnmatch
import json
from pathlib import Path


SECTIONS = (
    "types",
    "functions",
    "members",
    "ids",
    "hooks",
    "callback_actors",
    "callbacks",
)

DEFAULT_INVENTORY = Path("data/lua/reference/cbn_api_inventory.json")
DEFAULT_OUTPUT = Path("data/lua/reference/cbn_coverage.json")

DISTRIBUTION_GRID_SELECTOR = {
    "section": "functions",
    "file": "src/catalua_bindings_game.cpp",
    "kind": "function",
    "name": "get_distribution_grid_tracker",
}


def policy(
    domain_id: str,
    sections: tuple[str, ...],
    file_globs: tuple[str, ...],
    equivalents: tuple[str, ...],
    implementation_evidence: tuple[str, ...],
    test_evidence: tuple[str, ...],
) -> dict[str, object]:
    return {
        "id": domain_id,
        "sections": sections,
        "file_globs": file_globs,
        "equivalents": equivalents,
        "implementation_evidence": implementation_evidence,
        "test_evidence": test_evidence,
    }


POLICIES = (
    policy(
        "value_types_and_ids",
        ("types", "ids"),
        ("*",),
        (
            "game.types",
            "game.values",
            "game.time",
            "game.enums",
            "game.serde",
            "game.definitions",
        ),
        (
            "src/catalua_bindings_values.cpp#void install_value_type_api",
            "src/catalua_bindings_enums.cpp#void install_enum_value_api",
            "src/catalua_bindings_serde.cpp#void install_serde_api",
        ),
        (
            "tests/catalua_ui_test.cpp#lua_v5_game_ids_are_immutable_typed",
            "tests/catalua_ui_test.cpp#lua_v5_unit_values_are_exact_bounded",
            "tests/catalua_ui_test.cpp#lua_v5_serde_is_deterministic_typed",
        ),
    ),
    policy(
        "coordinates",
        ("functions", "members"),
        ("src/catalua_bindings_coords*",),
        ("game.coords", "game.world.to_absolute", "game.world.to_bubble"),
        (
            "src/catalua_bindings_coords.cpp#void install_coordinate_value_api",
        ),
        (
            "tests/catalua_ui_test.cpp#lua_v5_coordinates_are_immutable_typed",
            "tests/catalua_ui_test.cpp#lua_v5_coordinate_projections_and_ranges",
        ),
    ),
    policy(
        "bionics",
        ("functions", "members"),
        ("src/catalua_bindings_bionics.cpp",),
        ("game.bionics",),
        ("src/catalua_ui_bionics.cpp#void install_bionic_api",),
        (
            "tests/catalua_ui_test.cpp#lua_v5_bionics_use_detached_definitions",
        ),
    ),
    policy(
        "creatures_and_effects",
        ("functions", "members"),
        (
            "src/catalua_bindings_creature.cpp",
            "src/catalua_bindings_effect.cpp",
            "src/catalua_bindings_game_creatures.cpp",
        ),
        (
            "game.creatures",
            "game.characters",
            "game.effects",
            "game.handles",
        ),
        (
            "src/catalua_ui_creatures.cpp#void install_creature_api",
            "src/catalua_ui_effects.cpp#void install_effect_api",
        ),
        (
            "tests/catalua_ui_test.cpp#lua_v5_creature_queries_return_bounded",
            "tests/catalua_ui_test.cpp#lua_v5_effects_are_detached_bounded",
        ),
    ),
    policy(
        "items_and_inventory",
        ("functions", "members"),
        (
            "src/catalua_bindings_inventory.cpp",
            "src/catalua_bindings_item.cpp",
        ),
        ("game.items", "game.inventory", "game.handles"),
        ("src/catalua_ui_items.cpp#void install_item_api",),
        (
            "tests/catalua_ui_test.cpp#lua_v5_item_snapshots_are_detailed",
            "tests/catalua_ui_test.cpp#lua_v5_inventory_operations_are_bounded",
        ),
    ),
    policy(
        "character_powers",
        ("functions", "members"),
        (
            "src/catalua_bindings_magic.cpp",
            "src/catalua_bindings_mutation.cpp",
        ),
        ("game.mutations", "game.spells"),
        (
            "src/catalua_ui_magic.cpp#void install_magic_api",
            "src/catalua_ui_mutations.cpp#void install_mutation_api",
        ),
        (
            "tests/catalua_ui_test.cpp#lua_v5_spellbook_mana_and_casting",
            "tests/catalua_ui_test.cpp#lua_v5_character_mutations_are_generation",
        ),
    ),
    policy(
        "map_and_world",
        ("functions", "members"),
        (
            "src/catalua_bindings_game_world.cpp",
            "src/catalua_bindings_map.cpp",
            "src/catalua_bindings_mongroup.cpp",
            "src/catalua_bindings_overmap.cpp",
        ),
        ("game.world", "game.overmap", "game.hordes"),
        (
            "src/catalua_ui_world.cpp#void install_world_api",
            "src/catalua_ui_overmap.cpp#void install_overmap_api",
            "src/catalua_ui_hordes.cpp#void install_horde_api",
        ),
        (
            "tests/catalua_ui_test.cpp#lua_v5_world_reads_bounded_active_map",
            "tests/catalua_ui_test.cpp#lua_v5_overmap_reads_existing_tiles",
            "tests/catalua_ui_test.cpp#lua_v5_hordes_expose_bounded_definitions",
        ),
    ),
    policy(
        "mapgen",
        ("functions", "members"),
        ("src/catalua_bindings_mapgen.cpp",),
        ("game.mapgen",),
        ("src/catalua_ui.cpp#game[\"mapgen\"]",),
        (
            "tests/catalua_ui_test.cpp#lua_v5_mapgen_context_is_bounded",
            "tests/catalua_ui_test.cpp#lua_v5_mapgen_hooks_mutate",
        ),
    ),
    policy(
        "missions",
        ("functions", "members"),
        ("src/catalua_bindings_mission.cpp",),
        ("game.missions",),
        ("src/catalua_ui_missions.cpp#void install_mission_api",),
        (
            "tests/catalua_ui_test.cpp#lua_v5_missions_use_detached_definitions",
        ),
    ),
    policy(
        "crafting",
        ("functions", "members"),
        (
            "src/catalua_bindings_recipe.cpp",
            "src/catalua_bindings_requirement.cpp",
        ),
        ("game.recipes", "game.crafting"),
        ("src/catalua_ui_crafting.cpp#void install_crafting_api",),
        (
            "tests/catalua_ui_test.cpp#lua_v5_recipe_catalog_is_detached",
            "tests/catalua_ui_test.cpp#lua_v5_crafting_starts_only",
        ),
    ),
    policy(
        "game_services",
        ("functions", "members"),
        (
            "src/catalua_bindings_game.cpp",
            "src/catalua_bindings_ui.cpp",
        ),
        (
            "game.messages",
            "game.constants",
            "game.random",
            "game.targeting",
            "game.sound",
            "game.spawns",
            "game.followers",
            "game.relocation",
            "game.action_menu",
            "sidebar",
            "game.world",
            "ui",
        ),
        (
            "src/catalua_ui_game_info.cpp#void install_game_info_api",
            "src/catalua_ui_interaction.cpp#void install_game_interaction_api",
            "src/catalua_ui_world_services.cpp#void install_game_world_service_api",
            "src/catalua_ui.cpp#game[\"action_menu\"]",
            "src/catalua_ui.cpp#create_named_table( \"sidebar\" )",
        ),
        (
            "tests/catalua_ui_test.cpp#lua_v5_game_info_services_are_bounded",
            "tests/catalua_ui_test.cpp#lua_v5_sound_and_targeting_services",
            "tests/catalua_ui_test.cpp#lua_v5_world_services_use_handles",
            "tests/catalua_ui_test.cpp#lua_action_menu_entries_are_owned",
            "tests/catalua_ui_test.cpp#lua_sidebar_widgets_are_owned",
        ),
    ),
    policy(
        "runtime_and_definitions",
        ("functions", "members"),
        (
            "src/catalua.cpp",
            "src/catalua.h",
            "src/catalua_bindings.cpp",
            "src/catalua_bindings_ids*",
            "src/catalua_bindings_type_defs.cpp",
            "src/catalua_bindings_utils.h",
            "src/catalua_console.cpp",
            "src/catalua_impl.cpp",
            "src/catalua_input.cpp",
            "src/catalua_luna*",
            "src/catalua_readonly.cpp",
            "src/catalua_serde.cpp",
        ),
        (
            "game.definitions",
            "game.modules",
            "game.registry",
            "game.diagnostics",
            "game.services",
        ),
        (
            "src/catalua_ui_registry.cpp#void install_registry_api",
            "src/catalua_ui_modules.cpp#script_module_resolver::resolve_local",
        ),
        (
            "tests/catalua_ui_test.cpp#lua_v5_definition_registry_uses_typed",
            "tests/catalua_ui_test.cpp#lua_v5_module_loading_enforces",
            "tests/catalua_ui_test.cpp#lua_v5_runtime_diagnostics_are_bounded",
        ),
    ),
    policy(
        "hooks",
        ("hooks",),
        ("*",),
        ("game.hooks",),
        (
            "src/catalua_ui_callbacks.cpp#script_hook_specs()",
            "src/catalua_ui.cpp#game[\"hooks\"]",
        ),
        (
            "tests/catalua_ui_test.cpp#lua_v5_hook_and_callback_catalogs",
            "tests/catalua_ui_test.cpp#lua_v5_hooks_are_described_ordered",
            "tests/catalua_ui_test.cpp#lua_v5_remaining_combat_and_control_hooks",
        ),
    ),
    policy(
        "callback_actors",
        ("callback_actors", "callbacks"),
        ("*",),
        ("game.callbacks",),
        (
            "src/catalua_ui_callbacks.cpp#script_callback_kind_specs()",
            "src/catalua_ui.cpp#game[\"callbacks\"]",
        ),
        (
            "tests/catalua_ui_test.cpp#lua_v5_hook_and_callback_catalogs",
            "tests/catalua_ui_test.cpp#lua_v5_callback_actors_dispatch_typed",
            "tests/catalua_ui_test.cpp#lua_v5_equipment_and_reload_callbacks",
        ),
    ),
)


SERVICE_EQUIVALENTS = {
    "abs_to_bub": ("game.world.to_bubble(position)",),
    "bub_to_abs": ("game.world.to_absolute(position)",),
    "add_msg": ("game.messages.add(text, type)",),
    "get_messages": ("game.messages.recent(limit)",),
    "rng": ("game.random.int(minimum, maximum)",),
    "choose_adjacent": ("game.targeting.choose_adjacent(message, vertical)",),
    "choose_adjacent_highlight": (
        "game.targeting.choose_adjacent_where(message, failure, candidates)",
    ),
    "choose_adjacent_uilist": (
        "game.targeting.choose_adjacent_for_action(message, failure, action)",
    ),
    "choose_area": ("game.targeting.choose_area(message, start, vertical)",),
    "choose_direction": (
        "game.targeting.choose_direction(message, vertical)",
    ),
    "look_around": ("game.targeting.look_around()",),
    "play_variant_sound": ("game.sound.play(id, variant, volume, options)",),
    "play_ambient_variant_sound": (
        "game.sound.play_ambient(id, variant, volume, options)",
    ),
    "place_monster_at": ("game.spawns.monster(id, position)",),
    "place_monster_around": ("game.spawns.monster(id, position, radius)",),
    "spawn_hallucination": ("game.spawns.hallucination(position, options)",),
    "add_npc_follower": ("game.followers.add(handle)",),
    "remove_npc_follower": ("game.followers.remove(handle)",),
    "place_player_local_at": ("game.relocation.local_at(position)",),
    "place_player_overmap_at": ("game.relocation.overmap_at(position)",),
    "register_action_menu_entry": (
        "game.action_menu.register(id, name, callback, options)",
    ),
    "register_widget": ("sidebar.register_widget(definition)",),
    "clear_widgets": ("sidebar.clear_widgets()",),
    "get_layout_id": ("sidebar.get_layout_id()",),
    "get_lua_log": ("game.diagnostics.recent(limit)",),
}


ACTOR_KINDS = {
    "lua_bionic_callback_actor": "bionic",
    "lua_iequippable_actor": "iequippable",
    "lua_imelee_actor": "imelee",
    "lua_iranged_actor": "iranged",
    "lua_istate_actor": "istate",
    "lua_itrap_actor": "trap",
    "lua_iuse_actor": "iuse",
    "lua_iwearable_actor": "iwearable",
    "lua_iwieldable_actor": "iwieldable",
    "lua_monster_callback_actor": "monster",
    "lua_mutation_callback_actor": "mutation",
}


def load(path: Path) -> dict[str, object]:
    value = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(value, dict):
        raise RuntimeError(f"{path} must contain a JSON object")
    return value


def identity(entry: dict[str, object]) -> str:
    if "name" in entry:
        return str(entry["name"])
    cpp_type = str(entry.get("cpp_type", "?"))
    if "lua_name" in entry:
        return f"{cpp_type}->{entry['lua_name']}"
    return cpp_type


def stable_key(section: str, entry: dict[str, object]) -> str:
    return "|".join(
        (
            section,
            str(entry.get("file", "?")),
            str(entry.get("line", "?")),
            identity(entry),
        )
    )


def selector_for(
    section: str, entry: dict[str, object]
) -> dict[str, object]:
    return {"section": section, **entry}


def matches_policy(
    section: str,
    entry: dict[str, object],
    candidate: dict[str, object],
) -> bool:
    if section not in candidate["sections"]:
        return False
    file_name = str(entry.get("file", ""))
    return any(
        fnmatch.fnmatch(file_name, pattern)
        for pattern in candidate["file_globs"]
    )


def classify(
    section: str, entry: dict[str, object]
) -> dict[str, object]:
    matches = [
        candidate
        for candidate in POLICIES
        if matches_policy(section, entry, candidate)
    ]
    if len(matches) != 1:
        raise RuntimeError(
            f"{stable_key(section, entry)} matched {len(matches)} policies"
        )
    return matches[0]


def is_distribution_grid(
    section: str, entry: dict[str, object]
) -> bool:
    selector = selector_for(section, entry)
    return all(
        selector.get(field) == value
        for field, value in DISTRIBUTION_GRID_SELECTOR.items()
    )


def equivalents_for(
    section: str,
    entry: dict[str, object],
    domain: dict[str, object],
) -> list[str]:
    if section == "hooks":
        return [f'game.hooks.on("{entry["name"]}", handler)']
    if section == "callback_actors":
        kind = ACTOR_KINDS.get(str(entry["name"]))
        if kind is None:
            raise RuntimeError(
                f"no callback kind mapping for {entry['name']!r}"
            )
        return [
            f'game.callbacks.register("{kind}", target, descriptor)'
        ]
    if section == "callbacks":
        method = str(entry["name"]).removeprefix("call_")
        return [
            "game.callbacks.register("
            f'"<kind>", target, {{ {method} = handler }})'
        ]
    if domain["id"] == "game_services":
        mapped = SERVICE_EQUIVALENTS.get(str(entry.get("name", "")))
        if mapped is not None:
            return list(mapped)
    return list(domain["equivalents"])


def generate(
    inventory: dict[str, object],
    inventory_name: str = DEFAULT_INVENTORY.name,
) -> dict[str, object]:
    if inventory.get("schema_version") != 1:
        raise RuntimeError("unsupported CBN Lua inventory schema")
    source = inventory.get("source")
    if not isinstance(source, dict):
        raise RuntimeError("CBN inventory source is missing")

    entries: list[dict[str, object]] = []
    keys: set[str] = set()
    status_counts = {"covered": 0, "not_applicable": 0, "planned": 0}
    domain_counts: dict[str, int] = {}
    for section in SECTIONS:
        inventory_entries = inventory.get(section)
        if not isinstance(inventory_entries, list):
            raise RuntimeError(f"inventory section {section!r} is invalid")
        for raw_entry in inventory_entries:
            if not isinstance(raw_entry, dict):
                raise RuntimeError(
                    f"inventory section {section!r} has a non-object"
                )
            entry = dict(raw_entry)
            key = stable_key(section, entry)
            if key in keys:
                raise RuntimeError(f"duplicate generated key {key!r}")
            keys.add(key)
            domain = classify(section, entry)
            domain_id = str(domain["id"])
            domain_counts[domain_id] = domain_counts.get(domain_id, 0) + 1

            record: dict[str, object] = {
                "key": key,
                "selector": selector_for(section, entry),
                "domain": domain_id,
                "status": "covered",
                "ccb_equivalent": equivalents_for(
                    section, entry, domain
                ),
                "implementation_evidence": list(
                    domain["implementation_evidence"]
                ),
                "test_evidence": list(domain["test_evidence"]),
            }
            if is_distribution_grid(section, entry):
                record["status"] = "not_applicable"
                record["ccb_equivalent"] = []
                record["implementation_evidence"] = [
                    "tools/lua_api/generate_cbn_coverage.py"
                    "#DISTRIBUTION_GRID_SELECTOR"
                ]
                record["test_evidence"] = [
                    "tools/lua_api/check_coverage.py"
                    "#not_applicable entries must include a reason"
                ]
                record["reason"] = (
                    "CBN's distribution-grid tracker belongs to a CBN-only "
                    "power-distribution engine subsystem that is absent from "
                    "CCB; there is no native object or behavior to expose."
                )
            status_counts[str(record["status"])] += 1
            entries.append(record)

    total = len(entries)
    completed = status_counts["covered"] + status_counts["not_applicable"]
    return {
        "schema_version": 2,
        "source_inventory": {
            "path": inventory_name,
            "schema_version": inventory["schema_version"],
            **source,
        },
        "completion_policy": {
            "covered": (
                "The CCB API provides equivalent or stronger behavior and "
                "both implementation and test evidence resolve."
            ),
            "not_applicable": (
                "Only valid for a CBN-only engine feature absent from CCB; "
                "the entry must include a specific reason and audit evidence."
            ),
            "planned": (
                "The capability remains required and blocks 100% completion."
            ),
        },
        "summary": {
            "total": total,
            "completed": completed,
            "percent": round(completed * 100.0 / total, 2),
            "by_status": status_counts,
            "by_domain": dict(sorted(domain_counts.items())),
        },
        "entries": entries,
    }


def write_or_check(
    payload: dict[str, object],
    output: Path,
    check_snapshot: bool,
) -> None:
    serialized = (
        json.dumps(payload, ensure_ascii=False, indent=2) + "\n"
    )
    if check_snapshot:
        if not output.is_file():
            raise RuntimeError(f"coverage snapshot {output} is missing")
        if output.read_text(encoding="utf-8") != serialized:
            raise RuntimeError(
                f"coverage snapshot {output} is stale; regenerate it"
            )
        return
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(serialized, encoding="utf-8")


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--inventory", type=Path, default=DEFAULT_INVENTORY)
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    parser.add_argument("--check-snapshot", action="store_true")
    args = parser.parse_args()

    payload = generate(load(args.inventory), args.inventory.name)
    write_or_check(payload, args.output, args.check_snapshot)


if __name__ == "__main__":
    main()
