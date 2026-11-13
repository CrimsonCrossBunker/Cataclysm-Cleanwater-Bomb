#pragma once
#ifndef CATA_SRC_VEHICLE_WATER_H
#define CATA_SRC_VEHICLE_WATER_H

#include <optional>
#include <string>

#include "item_unload.h"
#include "type_id.h"

class player_activity;
class veh_menu;
struct vehicle_control_selection;

struct vehicle_water_selection {
    std::string operation;
    int64_t tool = 0;
    int64_t tank = 0;
    int64_t liquid = 0;
    bool allow_consequences = false;
    std::optional<unload_liquid_choice> destination;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

bool has_vehicle_water_tool( const vehicle &target, const tripoint_abs_ms &position );
bool valid_vehicle_water_selection( Character &who, map &here, vehicle &target,
                                    const tripoint_abs_ms &position, const vehicle_water_selection &choice );
bool execute_vehicle_water( Character &who, map &here, vehicle &target,
                            const tripoint_abs_ms &position, const vehicle_water_selection &choice,
                            bool allow_theft );
std::optional<vehicle_control_selection> query_vehicle_water( Character &who, map &here,
        vehicle &target, const tripoint_abs_ms &position, const std::string &operation = {} );
void add_vehicle_water_menu( veh_menu &menu, map &here, vehicle &target,
                             const tripoint_abs_ms &position );

// The saved source is used only by vehicle liquid activities. It is not an
// inventory source for pickup, reload or arbitrary item use.
bool is_vehicle_liquid_source( const item_source &source );
item_location resolve_vehicle_water_source( Character &who, map &here, const item_source &source,
        const std::optional<faction_id> &owner = std::nullopt );
void drink_vehicle_liquid( Character &who, map &here, item_location liquid );
void vehicle_liquid_transfer_turn( player_activity &act, Character &who, const item_source &source,
                                  const unload_liquid_choice &destination );

#endif // CATA_SRC_VEHICLE_WATER_H
