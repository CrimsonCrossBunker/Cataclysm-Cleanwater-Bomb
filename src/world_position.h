#pragma once
#ifndef CATA_SRC_WORLD_POSITION_H
#define CATA_SRC_WORLD_POSITION_H

#include <array>
#include <cstdint>
#include <limits>
#include <optional>

#include "coordinates.h"

// Fixed-point world location. The tile is the containing cell, including at
// negative coordinates. Grid systems continue to use that cell as their key.
class world_position
{
    public:
        static constexpr int units_per_tile = 256;
        static constexpr int tile_center = units_per_tile / 2;

        world_position() = default;
        explicit world_position( const tripoint_abs_ms &tile ) : tile_( tile ) {}

        static std::optional<world_position> from_tile( const tripoint_abs_ms &tile,
                const tripoint &offset ) {
            if( offset.x < 0 || offset.x >= units_per_tile ||
                offset.y < 0 || offset.y >= units_per_tile ||
                offset.z < 0 || offset.z >= units_per_tile ) {
                return std::nullopt;
            }
            world_position result( tile );
            result.offset_ = { static_cast<uint8_t>( offset.x ), static_cast<uint8_t>( offset.y ),
                               static_cast<uint8_t>( offset.z )
                             };
            return result;
        }

        const tripoint_abs_ms &tile() const {
            return tile_;
        }

        tripoint offset() const {
            return { offset_[0], offset_[1], offset_[2] };
        }

        std::optional<world_position> translated( const tripoint &delta ) const {
            tripoint tile = tile_.raw();
            tripoint offset = this->offset();
            if( !translate_axis( tile.x, offset.x, delta.x ) ||
                !translate_axis( tile.y, offset.y, delta.y ) ||
                !translate_axis( tile.z, offset.z, delta.z ) ) {
                return std::nullopt;
            }
            return from_tile( tripoint_abs_ms( tile ), offset );
        }

        bool operator==( const world_position &other ) const {
            return tile_ == other.tile_ && offset_ == other.offset_;
        }
        bool operator!=( const world_position &other ) const {
            return !( *this == other );
        }

    private:
        static bool translate_axis( int &tile, int &offset, const int delta ) {
            const int64_t next = static_cast<int64_t>( offset ) + delta;
            int64_t cell = static_cast<int64_t>( tile ) + next / units_per_tile;
            int remainder = next % units_per_tile;
            if( remainder < 0 ) {
                --cell;
                remainder += units_per_tile;
            }
            if( cell < std::numeric_limits<int>::min() || cell > std::numeric_limits<int>::max() ) {
                return false;
            }
            tile = static_cast<int>( cell );
            offset = remainder;
            return true;
        }

        tripoint_abs_ms tile_;
        std::array<uint8_t, 3> offset_ = { tile_center, tile_center, 0 };
};

#endif // CATA_SRC_WORLD_POSITION_H
