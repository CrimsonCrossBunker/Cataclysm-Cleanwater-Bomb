#pragma once
#ifndef CATA_SRC_TILE_CATEGORY_H
#define CATA_SRC_TILE_CATEGORY_H

// Make sure to change TILE_CATEGORY_IDS if this changes!
enum class TILE_CATEGORY {
    NONE,
    VEHICLE_PART,
    TERRAIN,
    ITEM,
    FURNITURE,
    TRAP,
    FIELD,
    LIGHTING,
    MONSTER,
    BULLET,
    HIT_ENTITY,
    WEATHER,
    OVERMAP_TERRAIN,
    OVERMAP_VISION_LEVEL,
    OVERMAP_WEATHER,
    MAP_EXTRA,
    OVERMAP_NOTE,
    last
};

#endif // CATA_SRC_TILE_CATEGORY_H
