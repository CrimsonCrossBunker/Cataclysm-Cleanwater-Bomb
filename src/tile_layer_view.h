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
    // Explicit previews keep their light when the scene lightmap is applied.
    bool fixed_light;

    template<typename Id, typename Subcategory>
    tile_layer_view( Id &&id, TILE_CATEGORY category, Subcategory &&subcategory,
                     const tripoint_bub_ms &position, int subtile, int rotation,
                     lit_level light, bool night_vision, const tripoint_abs_ms &absolute_position,
                     bool fixed_light = false ) :
        id( std::forward<Id>( id ) ), category( category ),
        subcategory( std::forward<Subcategory>( subcategory ) ),
        position( position ), absolute_position( absolute_position ), subtile( subtile ),
        rotation( rotation ), light( light ),
        night_vision( night_vision ), fixed_light( fixed_light ) {}

    // Reuse owned string capacity for immediate owner capture. Values remain
    // independent of the world; callers retain a copy if they need an older view.
    template<typename Id, typename Subcategory>
    void assign( Id &&new_id, TILE_CATEGORY new_category, Subcategory &&new_subcategory,
                 const tripoint_bub_ms &new_position, int new_subtile, int new_rotation,
                 lit_level new_light, bool new_night_vision,
                 const tripoint_abs_ms &new_absolute_position, bool new_fixed_light = false ) {
        id = std::forward<Id>( new_id );
        category = new_category;
        subcategory = std::forward<Subcategory>( new_subcategory );
        position = new_position;
        absolute_position = new_absolute_position;
        subtile = new_subtile;
        rotation = new_rotation;
        light = new_light;
        night_vision = new_night_vision;
        fixed_light = new_fixed_light;
    }
};

#endif // CATA_SRC_TILE_LAYER_VIEW_H
