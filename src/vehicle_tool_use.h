#pragma once
#ifndef CATA_SRC_VEHICLE_TOOL_USE_H
#define CATA_SRC_VEHICLE_TOOL_USE_H

#include <cstdint>
#include <optional>
#include <string>
#include <vector>

#include "coordinates.h"
#include "item.h"
#include "type_id.h"

class Character;
class JsonObject;
class JsonOut;
class map;
class vehicle;
class veh_menu;
struct vehicle_control_selection;

// A tool's hardware and installed identity, never a client-supplied tool or cost.
struct vehicle_tool_use_selection {
    int64_t part = 0;
    int64_t installed_tool = 0;
    std::string tool;
    std::string method;
    std::optional<tripoint_abs_ms> target;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

// Persistent source for a tool activity. Coordinates alone must not bind to a
// replacement vehicle, part or installed tool after loading or resuming.
struct mounted_tool_source {
    int64_t vehicle_id = 0;
    tripoint_abs_ms position;
    vehicle_tool_use_selection tool;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

std::optional<mounted_tool_source> capture_mounted_tool( const vehicle &target,
        const tripoint_abs_ms &position, const itype_id &type, const std::string &method );
std::optional<item> mounted_tool_item( Character &who, map &here,
                                       const mounted_tool_source &source );
bool consume_mounted_tool_turn( Character &who, map &here, const mounted_tool_source &source );
bool query_mounted_saw( Character &who, const item &tool, const tripoint_bub_ms &position );

bool immediate_vehicle_tool_method( const std::string &method );
std::vector<vehicle_tool_use_selection> vehicle_tool_use_options( const vehicle &target,
        const tripoint_abs_ms &position );
bool valid_vehicle_tool_use( Character &who, map &here, vehicle &target,
                             const tripoint_abs_ms &position, const vehicle_tool_use_selection &choice );
bool execute_vehicle_tool_use( Character &who, map &here, vehicle &target,
                               const tripoint_abs_ms &position, const vehicle_tool_use_selection &choice );
std::optional<vehicle_control_selection> query_vehicle_tool_use( Character &who, map &here,
        vehicle &target, const tripoint_abs_ms &position );
void add_vehicle_tool_use_menu( veh_menu &menu, map &here, vehicle &target,
                                const tripoint_abs_ms &position );

// Native pseudo-tool preparation and resource billing, with an explicit operator.
// Empty method retains the legacy local selection; no_invoke is the old heater handoff.
bool invoke_vehicle_tool( Character &who, vehicle &target, map &here,
                          const tripoint_bub_ms &position, const itype_id &tool,
                          const std::string &method = {}, bool no_invoke = false );
#endif // CATA_SRC_VEHICLE_TOOL_USE_H
