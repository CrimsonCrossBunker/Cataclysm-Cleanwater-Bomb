#pragma once
#ifndef CATA_SRC_ITEM_SOURCE_H
#define CATA_SRC_ITEM_SOURCE_H

#include <cstdint>
#include <string>
#include <vector>

#include "coordinates.h"

class Character;
class item_location;
class map;
class JsonOut;
class JsonObject;

// Identity and ancestry only; never a client-provided item payload.
struct item_source {
    std::string kind;
    tripoint_abs_ms position;
    std::vector<int64_t> path;
    int64_t vehicle = 0;
    int64_t cargo = 0;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &object );
};

// Restore the pocket chain when a visitor returned a flat location for a nested item.
item_location locate_item_with_parents( item_location location );
item_source capture_item_source( const Character &who, item_location source );
// Search radius is selected by the native operation, never read from a client request.
item_location resolve_item_source( Character &who, map &here, const item_source &source,
                                   int range = 1 );
// For callers that have already authorized access to a specific furniture tile.
item_location resolve_furniture_item( map &here, const tripoint_abs_ms &position, int64_t uid );
bool can_remove_from_item_pockets( const Character &who, item_location source );
#endif // CATA_SRC_ITEM_SOURCE_H
