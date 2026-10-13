#pragma once
#ifndef CATA_SRC_TILE_LAYER_VIEW_H
#define CATA_SRC_TILE_LAYER_VIEW_H

#include <cstdint>
#include <string>
#include <utility>

#include "coordinates.h"
#include "tile_category.h"

enum class lit_level : uint8_t;

// Owned semantic request emitted by the world owner after visibility,
// connections, map-memory and preview overrides are resolved. Asset lookup
// and projection consume values, never a map/observer/memorized-tile reference.
struct tile_layer_view {
    std::string id;
    TILE_CATEGORY category;
    std::string subcategory;
    tripoint_bub_ms position;
    tripoint_abs_ms absolute_position;
    int subtile;
    int rotation;
    lit_level light;
    bool night_vision;

    tile_layer_view( std::string id, TILE_CATEGORY category, std::string subcategory,
                     const tripoint_bub_ms &position, int subtile, int rotation,
                     lit_level light, bool night_vision, const tripoint_abs_ms &absolute_position ) :
        id( std::move( id ) ), category( category ), subcategory( std::move( subcategory ) ),
        position( position ), absolute_position( absolute_position ), subtile( subtile ),
        rotation( rotation ), light( light ),
        night_vision( night_vision ) {}
};

#endif // CATA_SRC_TILE_LAYER_VIEW_H
