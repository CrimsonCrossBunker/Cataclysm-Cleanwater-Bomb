#pragma once
#ifndef CATA_SRC_RADIO_CAR_CONTROL_H
#define CATA_SRC_RADIO_CAR_CONTROL_H

#include <cstdint>
#include <optional>

#include "coordinates.h"

class Character;
class item;
class map;
class JsonOut;
class JsonObject;

struct radio_car_binding {
    int64_t car = 0;
    tripoint_abs_ms position;
    int64_t controller = 0;
    unsigned int bionic = 0;
};

// Read-only, including the old bubble-coordinate save representation.
std::optional<radio_car_binding> read_radio_car_binding( const Character &who, map &here );
bool has_radio_car_binding( const Character &who );
bool has_radio_car_control( const Character &who, map &here );
bool connect_radio_car( Character &who, map &here, const item &controller );
void disconnect_radio_car( Character &who );
bool radio_car_uses_controller( const Character &who, map &here, const item &controller );
bool radio_car_uses_bionic( const Character &who, map &here, unsigned int uid );
bool drive_radio_car( Character &who, map &here, const point_rel_ms &direction,
                      const radio_car_binding &expected );
void write_radio_car_binding( const Character &who, map &here, JsonOut &out );
void apply_radio_car_binding( Character &who, const JsonObject &data );

#endif // CATA_SRC_RADIO_CAR_CONTROL_H
