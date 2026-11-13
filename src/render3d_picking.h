#pragma once
#ifndef CATA_SRC_RENDER3D_PICKING_H
#define CATA_SRC_RENDER3D_PICKING_H

#include <array>
#include <cstddef>
#include <cstdint>
#include <memory>
#include <optional>
#include <unordered_map>
#include <utility>
#include <vector>

#include "map_scale_constants.h"
#include "point.h"

struct sprite_alpha_profile;

namespace render3d
{

inline constexpr int REGION_RADIUS = 24;
inline constexpr int REGION_SIZE = REGION_RADIUS * 2 + 1;
inline constexpr int VIEW_RADIUS = MAX_VIEW_DISTANCE;
inline constexpr int VIEW_SIZE = VIEW_RADIUS * 2 + 1;
inline constexpr float LEVEL_HEIGHT = 2.6f;
inline constexpr float FLOOR_THICK = 0.1f;
inline constexpr float WALL_HEIGHT = LEVEL_HEIGHT - FLOOR_THICK * 0.5f;

struct scene_point {
    float x;
    float y;
    float z;
};

// Height at the northwest corner and the rise across one tile on each axis.
struct ramp_surface {
    float corner;
    float rise_x;
    float rise_y;

    float height_at( float x, float y ) const {
        return corner + rise_x * x + rise_y * y;
    }
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
        void set_ramp( const tripoint &cell, ramp_surface surface );
        void set_vehicle_body( const tripoint &cell, float bottom, float top );
        void add_box( const tripoint &cell, const scene_point &minimum,
                      const scene_point &maximum, bool selectable = true );
        void add_actor( const tripoint &cell, const scene_point &bottom, const point &pixel_size,
                        float width, float height, std::shared_ptr<const sprite_alpha_profile> alpha );
        std::optional<tripoint> trace( const scene_point &origin, const scene_point &ray,
                                       const scene_point &view_right = {} ) const;

    private:
        struct height_range {
            float bottom;
            float top;
        };

        struct box_surface {
            tripoint cell;
            scene_point minimum;
            scene_point maximum;
            bool selectable;
        };

        struct actor_surface {
            tripoint cell;
            scene_point bottom;
            point pixel_size;
            float width;
            float height;
            std::shared_ptr<const sprite_alpha_profile> alpha;
        };

        bool contains( const tripoint &cell ) const;
        pick_surface at( const tripoint &cell ) const;
        std::size_t index( const tripoint &cell ) const;

        int view_level_ = 0;
        std::vector<pick_surface> cells_;
        std::unordered_map<std::size_t, height_range> vehicle_bodies_;
        std::vector<std::pair<tripoint, ramp_surface>> ramps_;
        std::array<float, OVERMAP_LAYERS> vehicle_top_{};
        std::vector<box_surface> boxes_;
        std::vector<actor_surface> actors_;
};

} // namespace render3d
#endif // CATA_SRC_RENDER3D_PICKING_H
