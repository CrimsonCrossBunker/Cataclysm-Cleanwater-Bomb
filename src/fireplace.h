#pragma once
#ifndef CATA_SRC_FIREPLACE_H
#define CATA_SRC_FIREPLACE_H

#include <optional>
#include <vector>

#include "item_source.h"
#include "tool_activity_target.h"

class Character;
class JsonObject;
class JsonOut;
class item_location;
class map;
enum class activity_execution;

enum class fireplace_action { light_with_tool, light_with_bionic, extinguish };

struct fireplace_selection {
    fireplace_action action = fireplace_action::light_with_tool;
    tripoint_abs_ms origin;
    tool_activity_target target;
    std::optional<item_source> tool;
    std::optional<item_source> tinder;

    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

item_location find_fireplace_firestarter( Character &who, map &here, const tripoint_bub_ms &tile );
bool can_light_fireplace_with_bionic( const Character &who );
bool has_fireplace_quencher( Character &who, map &here, const tripoint_bub_ms &tile );
bool query_fireplace_ignition( Character &who, map &here, const item_location &tool,
                               fireplace_selection &choice );
bool execute_fireplace_selection( Character &who, map &here, const fireplace_selection &choice,
                                  activity_execution execution,
                                  std::vector<tripoint_abs_ms> *changed_tiles = nullptr );

#endif // CATA_SRC_FIREPLACE_H
