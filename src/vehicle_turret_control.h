#pragma once
#ifndef CATA_SRC_VEHICLE_TURRET_CONTROL_H
#define CATA_SRC_VEHICLE_TURRET_CONTROL_H

#include <cstdint>
#include <optional>
#include <string>
#include <vector>

#include "coordinates.h"
#include "type_id.h"

class Character;
class JsonObject;
class JsonOut;
class item_location;
class map;
class vehicle;
struct vehicle_part;
struct vehicle_control_selection;

struct vehicle_turret_choice {
    int64_t part = 0;
    tripoint_abs_ms position;
    gun_mode_id mode;
    itype_id ammo;
    bool automatic = false;

    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

// Desired settings and an explicit target, never a toggle or a vector index.
struct vehicle_turret_selection {
    std::string operation;
    tripoint_abs_ms operator_position;
    std::vector<vehicle_turret_choice> turrets;
    std::optional<tripoint_abs_ms> target;
    std::optional<tripoint_abs_ms> sweep_end;
    int sweep_speed = 0;

    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

vehicle_turret_choice capture_vehicle_turret( vehicle &target, vehicle_part &part );
bool valid_vehicle_turret_control( Character &who, map &here, vehicle &target,
                                   const vehicle_turret_selection &choice );
// Called after vehicle_control has checked physical/radio access and ownership.
bool execute_vehicle_turret_control( Character &who, map &here, vehicle &target,
                                     const vehicle_turret_selection &choice );
std::optional<vehicle_control_selection> query_vehicle_turrets( Character &who, map &here,
        vehicle &target, const tripoint_abs_ms &position, const std::string &operation = {},
        const item_location *remote_source = nullptr, bool sweeping = false, bool reaiming = false );
// Returns whether this action was handled, including canceling its target UI.
bool use_vehicle_turrets( Character &who, map &here, vehicle &target,
                          const tripoint_abs_ms &position, const std::string &operation, bool show_message = true,
                          bool sweeping = false, bool reaiming = false );

#endif // CATA_SRC_VEHICLE_TURRET_CONTROL_H
