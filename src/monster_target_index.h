#pragma once
#ifndef CATA_SRC_MONSTER_TARGET_INDEX_H
#define CATA_SRC_MONSTER_TARGET_INDEX_H

#include <algorithm>
#include <cstddef>
#include <unordered_map>
#include <vector>

#include "game_constants.h"
#include "map_scale_constants.h"
#include "point.h"

// Pure value index. The owner updates it; workers may only call candidates().
// Results include conservative false positives and preserve monster-list order.
class monster_target_index
{
    public:
        static constexpr int width = 16;
        static tripoint cell( const tripoint &p ) {
            const auto floor_div = []( int n ) { return n / width - ( n % width < 0 ); };
            return { floor_div( p.x ), floor_div( p.y ), p.z };
        }
        static bool overlaps( const tripoint &observer, const tripoint &target ) {
            const int dx = std::max( 0, std::abs( observer.x - target.x ) * width - ( width - 1 ) );
            const int dy = std::max( 0, std::abs( observer.y - target.y ) * width - ( width - 1 ) );
            return dx <= MAX_VIEW_DISTANCE && dy <= MAX_VIEW_DISTANCE &&
                   std::abs( observer.z - target.z ) <= fov_3d_z_range;
        }
        void insert( std::size_t id, const tripoint &p ) {
            buckets_[cell( p )].push_back( id );
        }
        void erase( std::size_t id, const tripoint &p ) {
            auto found = buckets_.find( cell( p ) );
            if( found == buckets_.end() ) {
                return;
            }
            auto &ids = found->second;
            ids.erase( std::remove( ids.begin(), ids.end(), id ), ids.end() );
            if( ids.empty() ) {
                buckets_.erase( found );
            }
        }
        std::vector<std::size_t> candidates( const tripoint &observer_cell ) const {
            std::vector<std::size_t> result;
            for( const auto &bucket : buckets_ ) {
                if( overlaps( observer_cell, bucket.first ) ) {
                    result.insert( result.end(), bucket.second.begin(), bucket.second.end() );
                }
            }
            std::sort( result.begin(), result.end() );
            return result;
        }
    private:
        std::unordered_map<tripoint, std::vector<std::size_t>> buckets_;
};

#endif // CATA_SRC_MONSTER_TARGET_INDEX_H
