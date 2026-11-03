#pragma once
#ifndef CATA_SRC_MP_ITEM_SOURCE_H
#define CATA_SRC_MP_ITEM_SOURCE_H

#include <cstdint>
#include <string>
#include <vector>

#include "coordinates.h"

class Character;
class item_location;
class map;
class JsonOut;
class JsonObject;

namespace cata_mp
{
// Identity and ancestry only; never a client-provided item payload.
struct item_source {
    std::string kind;
    tripoint_abs_ms position;
    std::vector<int64_t> path;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &object );
};

item_source capture_item_source( const Character &who, item_location source );
item_location resolve_item_source( Character &who, map &here, const item_source &source );
} // namespace cata_mp
#endif // CATA_SRC_MP_ITEM_SOURCE_H
