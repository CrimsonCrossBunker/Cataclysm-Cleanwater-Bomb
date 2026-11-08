#pragma once
#ifndef CATA_SRC_VEHICLE_TOOLSTATION_H
#define CATA_SRC_VEHICLE_TOOLSTATION_H

#include <cstdint>
#include <optional>

#include "item_source.h"

class Character;
class JsonObject;
class JsonOut;
class map;
class vehicle;
class veh_menu;
struct vehicle_control_selection;

// Exactly one source: an accessible item to attach, or an installed tool to detach.
struct vehicle_tool_selection {
    int64_t part_id = 0;
    std::optional<item_source> source;
    int64_t tool_id = 0;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

bool has_vehicle_toolstation( const vehicle &target, const tripoint_abs_ms &position );
bool valid_vehicle_tool_selection( Character &who, map &here, const vehicle &target,
                                   const tripoint_abs_ms &position, const vehicle_tool_selection &choice );
// The vehicle command checks physical access and theft before transferring anything.
bool execute_vehicle_tool_selection( Character &who, map &here, vehicle &target,
                                     const tripoint_abs_ms &position, const vehicle_tool_selection &choice );
std::optional<vehicle_control_selection> query_vehicle_toolstation( Character &who, map &here,
        vehicle &target, const tripoint_abs_ms &position, int64_t part_id = 0,
        std::optional<bool> attaching = std::nullopt );
void add_vehicle_toolstation_menu( veh_menu &menu, map &here, vehicle &target,
                                   const tripoint_abs_ms &position );

#endif // CATA_SRC_VEHICLE_TOOLSTATION_H
