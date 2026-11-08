#pragma once
#ifndef CATA_SRC_VEHICLE_HEATING_H
#define CATA_SRC_VEHICLE_HEATING_H

#include <cstdint>
#include <memory>
#include <optional>
#include <string>
#include <utility>
#include <vector>

#include "item_source.h"

class Character;
class JsonObject;
class JsonOut;
class JsonValue;
class activity_actor;
class item;
class map;
class player_activity;
class vehicle;
struct unload_liquid_choice;
struct vehicle_control_selection;

// Selection only: the server derives energy and duration from the live items.
struct vehicle_heating_selection {
    int64_t part = 0;
    int64_t installed_tool = 0; // Zero identifies a part-defined pseudo tool.
    std::string tool;
    std::string method;
    std::vector<std::pair<item_source, int>> items;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

bool has_vehicle_heater( const vehicle &target, const tripoint_abs_ms &position );
bool valid_vehicle_heating( Character &who, map &here, vehicle &target,
                            const tripoint_abs_ms &position, const vehicle_heating_selection &selection );
bool execute_vehicle_heating( Character &who, map &here, vehicle &target,
                              const tripoint_abs_ms &position, const vehicle_heating_selection &selection );
std::optional<vehicle_control_selection> query_vehicle_heating( Character &who, map &here,
        vehicle &target, const tripoint_abs_ms &position );
bool query_mounted_heating( Character &who, const item &tool,
                            const tripoint_bub_ms &position, const std::string &method );
bool is_vehicle_heating( const player_activity &activity );
const item *vehicle_heating_liquid( const player_activity &activity );
bool apply_vehicle_heating_liquid( Character &who, const unload_liquid_choice &choice,
                                   bool allow_consequences );
std::unique_ptr<activity_actor> deserialize_vehicle_heating( JsonValue &data );

#endif // CATA_SRC_VEHICLE_HEATING_H
