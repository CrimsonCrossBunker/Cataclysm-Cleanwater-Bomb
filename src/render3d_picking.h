#pragma once
#ifndef CATA_SRC_RENDER3D_PICKING_H
#define CATA_SRC_RENDER3D_PICKING_H

#include <cstddef>
#include <cstdint>
#include <optional>
#include <vector>

#include "map_scale_constants.h"
#include "point.h"

namespace render3d
{

inline constexpr int REGION_RADIUS = 24;
inline constexpr int REGION_SIZE = REGION_RADIUS * 2 + 1;
inline constexpr int VIEW_RADIUS = 60;
inline constexpr int VIEW_SIZE = VIEW_RADIUS * 2 + 1;
inline constexpr float LEVEL_HEIGHT = 2.6f;
inline constexpr float FLOOR_THICK = 0.1f;
inline constexpr float WALL_HEIGHT = LEVEL_HEIGHT - FLOOR_THICK * 0.5f;

struct scene_point {
    float x;
    float y;
    float z;
};

enum class pick_surface : std::uint8_t {
    open,
    floor,
    wall,
    memory_floor,
    memory_wall
};

// A frame-local record of drawn terrain surfaces. XY is relative to the
// camera anchor, while Z is the map level. Open air and cutaway roofs are empty.
class pick_surfaces
{
    public:
        void reset( int view_level );
        void set( const tripoint &cell, pick_surface surface );
        std::optional<tripoint> trace( const scene_point &origin, const scene_point &ray ) const;

    private:
        pick_surface at( const tripoint &cell ) const;
        std::size_t index( const tripoint &cell ) const;

        int view_level_ = 0;
        std::vector<pick_surface> cells_;
};

} // namespace render3d
#endif // CATA_SRC_RENDER3D_PICKING_H
