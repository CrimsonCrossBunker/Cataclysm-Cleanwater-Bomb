#pragma once
#ifndef CATA_SRC_VEHICLE_CONTROL_H
#define CATA_SRC_VEHICLE_CONTROL_H

#include <cstdint>
#include <optional>
#include <string>

#include "coordinates.h"
#include "item_disposition.h"

class JsonObject;
class JsonOut;
class Character;
class map;
class vehicle;

// Controller state belongs to its character. Queries never reuse another
// character's connection or a cached vehicle pointer from an earlier map state.
vehicle *resolve_remote_vehicle( const Character &who, map &here );
vehicle *get_remote_vehicle( Character &who, map &here );
bool set_remote_vehicle( Character &who, map &here, vehicle *target );

// A physically present driver supplies muscle power; a remote operator can steer and train,
// but cannot supply another character's body. Neither query invents an operator
// for unattended or debug-controlled vehicles.
Character *vehicle_operator( const vehicle &target, map &here );
vehicle *controlled_vehicle( const Character &who, map &here );
bool drive_vehicle( Character &who, map &here, const tripoint_rel_ms &input );
bool adjust_vehicle_cruise( Character &who, map &here, int direction );
bool brake_vehicle( Character &who, map &here );

// Explicit choices only; the server revalidates access, identity and costs.
struct vehicle_control_selection {
    int64_t vehicle_id = 0;
    tripoint_abs_ms position;
    std::string action;
    bool allow_theft = false;
    int64_t weapon_id = 0;
    std::optional<item_disposition> unwield;

    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

bool vehicle_control_accessible( const Character &who, map &here, const vehicle &target,
                                 const tripoint_abs_ms &position, const std::string &action );
std::optional<vehicle_control_selection> query_vehicle_control( Character &who, map &here,
        vehicle &target, const tripoint_abs_ms &position, const std::string &action );
bool execute_vehicle_control( Character &who, map &here,
                              const vehicle_control_selection &selection );
#endif // CATA_SRC_VEHICLE_CONTROL_H
