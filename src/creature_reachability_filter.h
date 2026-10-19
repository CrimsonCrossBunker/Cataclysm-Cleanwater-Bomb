#pragma once
#ifndef CATA_SRC_CREATURE_REACHABILITY_FILTER_H
#define CATA_SRC_CREATURE_REACHABILITY_FILTER_H

#include <bitset>
#include <cstddef>
#include <cstdint>

#include "coordinates.h"

// Call-local filter of registered absolute locations, without creature pointers.
// Eight-cell XY blocks and periodic aliases can only cause extra exact lookups;
// a marked block never replaces the authoritative lookup at a queried cell.
class creature_reachability_filter
{
    public:
        void mark( const tripoint_abs_ms &position ) {
            occupied_.set( block( position ) );
        }

        bool may_contain( const tripoint_abs_ms &position ) const {
            return occupied_[block( position )];
        }

        void reset() {
            occupied_.reset();
        }

    private:
        // 16 x 16 XY blocks, 32 Z buckets: a 1 KiB traversal-local value.
        std::bitset<8192> occupied_;

        static size_t block( const tripoint_abs_ms &position ) {
            // Unsigned conversion keeps negative and extreme coordinates defined.
            const uint32_t x = ( static_cast<uint32_t>( position.x() ) >> 3 ) & 15;
            const uint32_t y = ( static_cast<uint32_t>( position.y() ) >> 3 ) & 15;
            const uint32_t z = static_cast<uint32_t>( position.z() ) & 31;
            return ( z << 8 ) | ( y << 4 ) | x;
        }
};

static_assert( sizeof( creature_reachability_filter ) == sizeof( std::bitset<8192> ) );
static_assert( alignof( creature_reachability_filter ) == alignof( std::bitset<8192> ) );

#endif // CATA_SRC_CREATURE_REACHABILITY_FILTER_H
