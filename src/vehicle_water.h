#pragma once
#ifndef CATA_SRC_VEHICLE_WATER_H
#define CATA_SRC_VEHICLE_WATER_H

#include <memory>
#include <optional>
#include <string>

#include "item_unload.h"

class activity_actor;
class JsonValue;
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

// Identity-only access to a water tank through a nearby working faucet. Shared
// with consumption so every turn rechecks the faucet, tank and liquid instance.
std::optional<item_source> capture_vehicle_water_source( const Character &who,
        const item_location &source );
item_location resolve_vehicle_water_source( Character &who, map &here, const item_source &source );
std::unique_ptr<activity_actor> deserialize_vehicle_water_activity( JsonValue &data );

#endif // CATA_SRC_VEHICLE_WATER_H
