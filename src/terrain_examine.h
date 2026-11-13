#pragma once
#ifndef CATA_SRC_TERRAIN_EXAMINE_H
#define CATA_SRC_TERRAIN_EXAMINE_H

#include <optional>
#include <vector>

#include "coordinates.h"
#include "item_source.h"
#include "type_id.h"

class Character;
class JsonObject;
class JsonOut;
class item_location;
class map;

enum class terrain_examine_action { cover_pit, uncover_pit, remove_curtains };

struct terrain_examine_selection {
    terrain_examine_action action = terrain_examine_action::cover_pit;
    tripoint_abs_ms origin;
    tripoint_abs_ms target;
    ter_str_id terrain;
    std::optional<item_source> plank;

    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

bool can_use_pit_plank( Character &who, map &here, const item_location &plank );
bool can_access_curtains( const Character &who, map &here, const tripoint_bub_ms &tile );
bool execute_terrain_examine( Character &who, map &here, const terrain_examine_selection &choice,
                              std::vector<tripoint_abs_ms> *changed_tiles = nullptr );

#endif // CATA_SRC_TERRAIN_EXAMINE_H
