#pragma once
#ifndef CATA_SRC_VEHICLE_CONTROL_H
#define CATA_SRC_VEHICLE_CONTROL_H

#include <cstdint>
#include <optional>
#include <string>
#include <vector>

#include "coordinates.h"
#include "item_disposition.h"
#include "vehicle_electronics.h"
#include "vehicle_appliance.h"

class JsonObject;
class JsonOut;
class Character;
class map;
class vehicle;
class item_location;

// Controller state belongs to its character. Queries never reuse another
// character's connection or a cached vehicle pointer from an earlier map state.
vehicle *resolve_remote_vehicle( const Character &who, map &here );
vehicle *get_remote_vehicle( Character &who, map &here );
bool set_remote_vehicle( Character &who, map &here, vehicle *target );
void write_remote_vehicle_binding( const Character &who, map &here, JsonOut &out );
void apply_remote_vehicle_binding( Character &who, const JsonObject &view );
bool remote_vehicle_accessible( const Character &who, map &here, const vehicle &target,
                                const item_location &controller );

// A physically present driver supplies muscle power; a remote operator can steer and train,
// but cannot supply another character's body. Neither query invents an operator
// for unattended or debug-controlled vehicles.
Character *vehicle_operator( const vehicle &target, map &here );
vehicle *controlled_vehicle( const Character &who, map &here );
bool drive_vehicle( Character &who, map &here, const tripoint_rel_ms &input );
bool adjust_vehicle_cruise( Character &who, map &here, int direction );
bool brake_vehicle( Character &who, map &here );

// Explicit choices only; the server revalidates access, identity and costs.
struct vehicle_engine_selection {
    int64_t part_id = 0;
    std::string fuel;
    bool enabled = false;

    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

struct vehicle_control_selection {
    int64_t vehicle_id = 0;
    tripoint_abs_ms position;
    std::string action;
    bool allow_theft = false;
    int64_t weapon_id = 0;
    std::optional<item_disposition> unwield;
    std::vector<vehicle_engine_selection> engines;
    std::optional<vehicle_electronics_selection> electronics;
    std::optional<vehicle_appliance_selection> appliance;

    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

bool vehicle_control_accessible( const Character &who, map &here, const vehicle &target,
                                 const tripoint_abs_ms &position, const std::string &action,
                                 const item_location *remote_source = nullptr );
std::optional<vehicle_control_selection> query_vehicle_control( Character &who, map &here,
        vehicle &target, const tripoint_abs_ms &position, const std::string &action,
        const item_location *remote_source = nullptr );
std::optional<vehicle_control_selection> query_vehicle_engines( Character &who, map &here,
        vehicle &target, const tripoint_abs_ms &position, const item_location *remote_source = nullptr );
std::optional<vehicle_control_selection> query_vehicle_autopilot( Character &who, map &here,
        vehicle &target, const tripoint_abs_ms &position, const item_location *remote_source = nullptr );
std::optional<vehicle_control_selection> query_vehicle_electronics( Character &who, map &here,
        vehicle &target, const tripoint_abs_ms &position, const item_location *remote_source = nullptr,
        const std::string &submenu = {} );
std::optional<vehicle_control_selection> query_owned_vehicle_menu( Character &who, map &here,
        vehicle &target, const tripoint_abs_ms &position, const item_location *remote_source = nullptr );
std::optional<vehicle_control_selection> query_vehicle_appliance( Character &who, map &here,
        vehicle &target, const tripoint_abs_ms &position, int64_t part_id = 0 );
// remote_source is supplied only by a completed native security scan; it is
// never accepted from a serialized vehicle_control_selection.
bool execute_vehicle_control( Character &who, map &here,
                              const vehicle_control_selection &selection, const item_location *remote_source = nullptr );
#endif // CATA_SRC_VEHICLE_CONTROL_H
