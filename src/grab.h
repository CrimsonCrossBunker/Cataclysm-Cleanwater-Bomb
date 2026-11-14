#pragma once
#ifndef CATA_SRC_GRAB_H
#define CATA_SRC_GRAB_H

#include <cstdint>
#include <optional>

#include "coordinates.h"
#include "type_id.h"

class Character;
class JsonObject;
class JsonOut;
class map;

// Persistent identity of a held object. Furniture is tied to its absolute cell
// and invalidated when that cell changes; vehicles retain their exact part UID.
struct grabbed_object {
    tripoint_abs_ms position;
    int64_t vehicle_id = 0;
    int64_t part_id = 0;
    furn_str_id furniture;

    bool matches( const Character &who, const map &here ) const;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

// A selection describes the object seen by the operator, never a replacement
// grab state. Execution resolves it again after UI/network delay.
struct grab_selection {
    bool release = false;
    tripoint_abs_ms position;
    int64_t vehicle_id = 0;
    int64_t part_id = 0;
    furn_str_id furniture;
    bool separate_grid = false;
    bool loaded_furniture = false;
    bool allow_theft = false;

    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

std::optional<grab_selection> query_grab( Character &who, map &here,
        const tripoint_bub_ms &target );
bool execute_grab( Character &who, map &here, const grab_selection &choice );

#endif // CATA_SRC_GRAB_H
