#pragma once
#ifndef CATA_SRC_KEG_H
#define CATA_SRC_KEG_H

#include <cstdint>
#include <optional>
#include <vector>

#include "item_unload.h"
#include "tool_activity_target.h"
#include "units.h"

class Character;
class JsonObject;
class JsonOut;
class item;
class map;

namespace keg
{
enum class operation { fill, dispense, drink, recover };

struct command {
    operation action = operation::fill;
    tripoint_abs_ms origin;
    tool_activity_target target;
    int64_t batch = 0;
    std::vector<item_source> supplies;
    std::optional<unload_liquid_choice> destination;
    bool allow_consequences = false;

    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

units::volume capacity( const map &here, const tripoint_bub_ms &tile );
bool pour( map &here, const tripoint_bub_ms &tile, item &liquid );
bool available_supply( Character &who, const item_location &supply );
bool execute( Character &who, map &here, const command &choice, bool remote,
              std::vector<tripoint_abs_ms> *changed_tiles = nullptr );
} // namespace keg

#endif // CATA_SRC_KEG_H
