#!/usr/bin/env python3
"""
Attempts to generate a reasonable set of overlay IDs
that should be defined in a tileset.
Meant to be used along with tools/gfx_tools/list_tileset_ids.py

Google Docs Spreadsheet formulas:

Prune IDs from tileset for verification:
=REGEXREPLACE(A2,"_season_(spring|summer|autumn|winter)|_male|_female","")

Search for the pruned ID in overlays
=arrayformula(iferror(VLOOKUP($C2:$C,'overlays'!$A$1:$A,1,FALSE)))

Search in game IDs
=arrayformula(iferror(VLOOKUP($C2:$C,'all game IDs'!$B$2:$B,1,FALSE)))
"""

from itertools import product

from util import import_data


CPP_IDS = (
    'cursor', 'highlight', 'highlight_item', 'footstep', 'graffiti',
    'zombie_revival_indicator',
    'weather_rain_drop', 'weather_acid_drop', 'weather_snowflake',
    'animation_bullet_normal', 'animation_bullet_shrapnel',
    'animation_bullet_flame',
    'explosion', 'explosion_weak', 'explosion_medium',
    'animation_hit', 'player_male', 'player_female', 'npc_male', 'npc_female',
    'animation_line', 'line_target', 'line_trail',
    'infrared_creature',
    'run_nw', 'run_n', 'run_ne', 'run_w', 'run_e', 'run_sw', 'run_s', 'run_se',
    'bash_complete', 'bash_effective', 'bash_ineffective',
    'shadow',
)
ATTITUDES = ('hostile', 'neutral', 'friendly', 'other')

ITEM_WORN_SUBTYPES = {'ARMOR', 'TOOL_ARMOR'}

TILESET_OVERLAY_TYPES = {
    'effect_type': {
        'prefix': 'overlay_effect_'
    },
    'mutation': {
        'prefix': 'overlay_mutation_'
    },
    'bionic': {
        'prefix': 'overlay_mutation_'
    },
    'ARMOR': {
        'prefix': 'overlay_worn_'
    },
    'TOOL_ARMOR': {
        'prefix': 'overlay_worn_'
    },
    'GENERIC': {
        'prefix': 'overlay_wielded_'
    },
    'GUN': {
        'prefix': 'overlay_wielded_'
    },
    'AMMO': {
        'prefix': 'overlay_wielded_'
    },
    'TOOL': {
        'prefix': 'overlay_wielded_'
    },
    'ENGINE': {
        'prefix': 'overlay_wielded_'
    },
    'WHEEL': {
        'prefix': 'overlay_wielded_'
    },
    'COMESTIBLE': {
        'prefix': 'overlay_wielded_'
    },
    'MONSTER': {
        'prefix': ''
    },
    'movement_mode': {
        'prefix': 'overlay_'
    },
    'vehicle_part': {
        'prefix': 'vp_'
    },
}


def _as_list(value):
    if value is None:
        return []
    return value if isinstance(value, list) else [value]


def _refs(datum):
    result = []
    if isinstance(datum.get('abstract'), str):
        result.append(datum['abstract'])
    result.extend(x for x in _as_list(datum.get('id')) if isinstance(x, str))
    return result


def _resolve_set(datum, field, by_ref, trail=()):
    parent_ref = datum.get('copy-from')
    parent = by_ref.get(parent_ref) if isinstance(parent_ref, str) else None
    if field in datum:
        result = set(_as_list(datum.get(field)))
    elif parent is not None and parent_ref not in trail:
        result = _resolve_set(parent, field, by_ref, trail + (parent_ref,))
    else:
        result = set()
    extend = datum.get('extend')
    if isinstance(extend, dict):
        result.update(_as_list(extend.get(field)))
    delete = datum.get('delete')
    if isinstance(delete, dict):
        result.difference_update(_as_list(delete.get(field)))
    return {x for x in result if isinstance(x, str)}


def _overlay_prefixes(datum, by_ref):
    datum_type = datum.get('type')
    if datum_type != 'ITEM':
        overlay_data = TILESET_OVERLAY_TYPES.get(datum_type)
        return [overlay_data['prefix']] if overlay_data else []

    subtypes = _resolve_set(datum, 'subtypes', by_ref)
    # Character::get_overlay_ids() can request a wielded overlay for every
    # real item, regardless of subtype.  Wearable items additionally request
    # worn overlays.  PET_ARMOR uses monster/bodytype-specific IDs instead.
    prefixes = ['overlay_wielded_']
    if subtypes & ITEM_WORN_SUBTYPES:
        prefixes.append('overlay_worn_')
    return prefixes


if __name__ == '__main__':
    data = import_data()[0]

    by_ref = {}
    for datum in data:
        for ref in _refs(datum):
            by_ref.setdefault(ref, datum)

    for datum in data:
        datum_type = datum.get('type')
        overlay_prefixes = _overlay_prefixes(datum, by_ref)
        if not overlay_prefixes:
            continue

        game_ids = [x for x in _as_list(datum.get('id')) if isinstance(x, str)]
        flags = _resolve_set(datum, 'flags', by_ref)

        if not game_ids:
            continue
        if datum.get('abstract'):
            continue
        if 'PSEUDO' in flags or 'NO_DROP' in flags:
            continue
        if datum.get('copy-from') in ('fake_item', 'software'):
            continue

        for game_id in game_ids:
            variable_prefix = ('',)
            variable_suffix = ('',)
            if 'BIONIC_TOGGLED' in flags:
                variable_prefix = ('', 'active_')
            if datum_type == 'MONSTER':
                variable_prefix = ('corpse_', 'overlay_wielded_corpse_')
            if datum_type == 'vehicle_part':
                symbols = datum.get('symbols', {})
                variable_suffix = list(symbols.keys()) if isinstance(symbols, dict) else []
                variable_suffix = ['', ] + [f'_{s}' for s in variable_suffix]

            for overlay_prefix in overlay_prefixes:
                for parts in product(variable_prefix, (game_id,), variable_suffix):
                    print(overlay_prefix + ''.join(parts))

    for hardcoded_id in CPP_IDS:
        print(hardcoded_id)
    for attitude in ATTITUDES:
        print(f'overlay_{attitude}_sees_player')
