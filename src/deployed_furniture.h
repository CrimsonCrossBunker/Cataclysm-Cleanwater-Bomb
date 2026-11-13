#pragma once
#ifndef CATA_SRC_DEPLOYED_FURNITURE_H
#define CATA_SRC_DEPLOYED_FURNITURE_H

#include <vector>

#include "coordinates.h"
#include "type_id.h"

class Character;
class JsonObject;
class JsonOut;
class map;

// A choice identifies the furniture that was shown, never an item to spawn.
struct deployed_furniture_selection {
    tripoint_abs_ms origin;
    tripoint_abs_ms target;
    furn_str_id furniture;
    bool allow_burning = false;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

bool can_take_down_deployed_furniture( const Character &who, const map &here,
                                       const deployed_furniture_selection &choice );
bool take_down_deployed_furniture( Character &who, map &here,
                                   const deployed_furniture_selection &choice,
                                   std::vector<tripoint_abs_ms> *changed_tiles = nullptr );

#endif // CATA_SRC_DEPLOYED_FURNITURE_H
