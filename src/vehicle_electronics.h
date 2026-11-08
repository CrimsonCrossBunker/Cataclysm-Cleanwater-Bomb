#pragma once
#ifndef CATA_SRC_VEHICLE_ELECTRONICS_H
#define CATA_SRC_VEHICLE_ELECTRONICS_H

#include <cstdint>
#include <optional>
#include <string>
#include <vector>

#include "coordinates.h"

class Character;
class JsonObject;
class JsonOut;
class item_location;
class map;
class vehicle;
struct vehicle_part;

// Desired state, not a toggle or a part-vector index. Individual hardware is
// identified by its base item's UID; groups name a supported native system.
struct vehicle_electronics_selection {
    std::string system;
    int64_t part_id = 0;
    bool enabled = false;

    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

struct vehicle_electronics_option {
    vehicle_electronics_selection choice;
    std::string label;
    std::string hotkey;
    std::string submenu;
    bool enabled = true;
    std::optional<tripoint_abs_ms> position;
};

bool can_enable_vehicle_part( const Character &who, map &here, const vehicle &target,
                              const vehicle_part &part, bool alert = false );
std::optional<tripoint_abs_ms> vehicle_electronics_position( const Character &who, map &here,
        const vehicle &target, const item_location *remote_source = nullptr );
std::vector<vehicle_electronics_option> vehicle_electronics_options( const Character &who,
        map &here, const vehicle &target, const std::string &submenu = {} );
bool valid_vehicle_electronics_selection( const Character &who, map &here, const vehicle &target,
        const vehicle_electronics_selection &choice );
// Called by execute_vehicle_control after operator access/theft validation.
bool execute_vehicle_electronics( Character &who, map &here, vehicle &target,
                                  const vehicle_electronics_selection &choice );

#endif // CATA_SRC_VEHICLE_ELECTRONICS_H
