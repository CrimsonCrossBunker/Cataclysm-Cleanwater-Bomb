#pragma once
#ifndef CATA_SRC_ITEM_CONSUMPTION_H
#define CATA_SRC_ITEM_CONSUMPTION_H

#include "coordinates.h"
#include "item_location.h"
#include "type_id.h"

class Character;
class item;
class JsonObject;
class JsonOut;
class map;

struct ground_food_target {
    tripoint_abs_ms position;
    ter_str_id terrain;
    furn_str_id furniture;

    static ground_food_target capture( map &here, const tripoint_bub_ms &position );
    bool matches( const Character &who, map &here ) const;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

bool start_ground_food( Character &who, map &here, const ground_food_target *selection = nullptr,
                        bool allow_consequences = false );
bool select_client_ground_food( Character &who, map &here );

// Confirmation only; witnessing theft and consumption remain native mutations.
bool query_consumption_ownership( const item &target, Character &who );
bool owned_consumption_allowed( Character &who, item_location source,
                                bool allow_consequences, bool allow_theft );
void start_item_consumption( Character &who, const item_location &source,
                             bool reprompt = false );

#endif // CATA_SRC_ITEM_CONSUMPTION_H
