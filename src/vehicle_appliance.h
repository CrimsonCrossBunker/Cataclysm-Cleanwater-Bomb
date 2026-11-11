#pragma once
#ifndef CATA_SRC_VEHICLE_APPLIANCE_H
#define CATA_SRC_VEHICLE_APPLIANCE_H

#include <cstdint>
#include <optional>

#include "craft_command.h"

class Character;
class JsonObject;
class JsonOut;
class map;
class vehicle;
class veh_menu;

// Stable hardware identity and player choices, never client-computed costs.
struct vehicle_appliance_selection {
    int64_t part_id = 0;
    bool enabled = true;
    std::optional<comp_selection<item_comp>> detergent;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

bool has_vehicle_appliance( const vehicle &target, const tripoint_abs_ms &position );
bool valid_vehicle_appliance_selection( Character &who, map &here, const vehicle &target,
                                        const tripoint_abs_ms &position, const vehicle_appliance_selection &choice );
// Called only after the shared vehicle command validates access and theft.
bool execute_vehicle_appliance( Character &who, map &here, vehicle &target,
                                const tripoint_abs_ms &position, const vehicle_appliance_selection &choice );
// Native frontend; multiplayer clients submit the same owned vehicle command.
void use_vehicle_appliance( Character &who, map &here, vehicle &target, int part );
void add_vehicle_appliance_menu( veh_menu &menu, map &here, vehicle &target,
                                 const tripoint_abs_ms &position );

#endif // CATA_SRC_VEHICLE_APPLIANCE_H
