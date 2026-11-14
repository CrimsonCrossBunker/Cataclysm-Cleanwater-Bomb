#pragma once
#ifndef CATA_SRC_HAULING_H
#define CATA_SRC_HAULING_H

#include <string>
#include <vector>

#include "item_source.h"

class Character;
class JsonObject;
class JsonOut;
class map;

struct haul_item_selection {
    item_source source;
    int quantity = 0;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

struct hauling_selection {
    std::string action;
    tripoint_abs_ms position;
    std::vector<haul_item_selection> items;
    bool enable_autohaul = false;
    std::string filter;

    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

bool execute_hauling( Character &who, map &here, const hauling_selection &choice );

#endif // CATA_SRC_HAULING_H
