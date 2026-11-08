#pragma once
#ifndef CATA_SRC_VEHICLE_HARNESS_H
#define CATA_SRC_VEHICLE_HARNESS_H

#include <cstdint>
#include <optional>

#include "coordinates.h"

class Character;
class JsonObject;
class JsonOut;
class map;
class vehicle;
struct vehicle_control_selection;

struct vehicle_harness_selection {
    int64_t part = 0;
    int64_t animal = 0;
    tripoint_abs_ms animal_position;

    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

bool valid_vehicle_harness( Character &who, map &here, vehicle &target,
                            const tripoint_abs_ms &position, const vehicle_harness_selection &choice );
bool execute_vehicle_harness( Character &who, map &here, vehicle &target,
                              const tripoint_abs_ms &position, const vehicle_harness_selection &choice );
std::optional<vehicle_control_selection> query_vehicle_harness( Character &who, map &here,
        vehicle &target, const tripoint_abs_ms &position, int64_t part = 0 );

#endif // CATA_SRC_VEHICLE_HARNESS_H
