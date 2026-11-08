#pragma once
#ifndef CATA_SRC_ITEM_INSERT_H
#define CATA_SRC_ITEM_INSERT_H

#include <vector>
#include <utility>
#include "item_source.h"
#include "item_location.h"

class Character;
class JsonObject;
class JsonOut;

// Selection data only. No item payloads or client-calculated movement costs.
struct insert_selection {
    item_source destination;
    std::vector<std::pair<item_source, int>> items;
    bool allow_nested = true;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &object );
};

insert_selection capture_insert_selection( const Character &who, const item_location &destination,
        const drop_locations &items, bool allow_nested );
bool valid_insert_item( Character &who, item_location destination, item_location source );
// All UI entrypoints share this dispatch; the server uses the same native actor.
void start_item_insert( Character &who, const item_location &destination,
                        const drop_locations &items, bool reopen_menu = false,
                        bool allow_nested = true, bool server_owned = false );

#endif // CATA_SRC_ITEM_INSERT_H
