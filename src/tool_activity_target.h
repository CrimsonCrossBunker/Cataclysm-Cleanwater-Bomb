#pragma once
#ifndef CATA_SRC_TOOL_ACTIVITY_TARGET_H
#define CATA_SRC_TOOL_ACTIVITY_TARGET_H

#include <cstdint>
#include <optional>
#include <string>

#include "coordinates.h"
#include "item_location.h"
#include "item_source.h"
#include "type_id.h"

class Character;
class JsonObject;
class JsonOut;
class item;
class item_location;
class map;
class player_activity;

enum class adjacent_tool_action { none, pry, mine, drill, lockpick };
adjacent_tool_action adjacent_tool_method( const std::string &method );
// Select the wielded mining action using gameplay conditions shared by local
// movement and the authority. Auto-feature preferences belong to the frontend.
std::string automatic_mining_method( const Character &who, map &here,
                                     const tripoint_abs_ms &target );
bool valid_adjacent_tool_target( adjacent_tool_action action, const Character &who,
                                 map &here, const item &tool, const tripoint_abs_ms &target );
std::optional<tripoint_abs_ms> query_adjacent_tool_target( adjacent_tool_action action,
        Character &who, map &here, const item &tool );

bool execute_owned_prying( Character &who, item_location tool, const tripoint_abs_ms &target,
                           bool allow_theft, bool allow_wet );

// A long-running operation must still refer to the surface/vehicle it started
// on. Absolute coordinates survive a bubble shift; a changed target cancels
// before tool costs, skill gains or byproducts can be applied a second time.
struct tool_activity_target {
    tripoint_abs_ms position;
    ter_str_id terrain;
    furn_str_id furniture;
    int64_t vehicle = 0;
    int64_t locked_part = 0;
    std::optional<item_source> tool_source;

    static tool_activity_target capture( map &here, const tripoint_abs_ms &position );
    bool matches( map &here ) const;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

bool continue_owned_tool_activity( player_activity &activity, Character &who,
                                   const std::optional<item_location> &tool,
                                   const std::optional<tool_activity_target> &target );
void start_owned_tool_activity( player_activity &activity, Character &who,
                                const std::optional<item_location> &tool,
                                const tripoint_abs_ms &position,
                                std::optional<tool_activity_target> &target );

#endif // CATA_SRC_TOOL_ACTIVITY_TARGET_H
