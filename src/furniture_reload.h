#pragma once
#ifndef CATA_SRC_FURNITURE_RELOAD_H
#define CATA_SRC_FURNITURE_RELOAD_H

#include <optional>
#include <vector>

#include "item_unload.h"
#include "tool_activity_target.h"

class Character;
class JsonObject;
class JsonOut;
class item;
class item_location;
class map;

namespace furniture_reload
{
enum class operation { load, unload };

struct command {
    operation action = operation::load;
    tripoint_abs_ms origin;
    tool_activity_target target;
    item_source source;
    itype_id type;
    int quantity = 0;
    std::optional<unload_liquid_choice> destination;

    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

item reload_tool( const map &here, const tripoint_bub_ms &tile );
std::vector<item_location> loaded_ammo( map &here, const tripoint_bub_ms &tile );
int remaining_capacity( map &here, const tripoint_bub_ms &tile, const item &ammo );
bool execute( Character &who, map &here, const command &choice,
              std::vector<tripoint_abs_ms> *changed_tiles = nullptr );
} // namespace furniture_reload

#endif // CATA_SRC_FURNITURE_RELOAD_H
