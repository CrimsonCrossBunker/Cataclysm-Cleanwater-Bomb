#include "monster_scent_batch.h"

#include <algorithm>
#include <new>
#include <system_error>

#include "map.h"
#include "map_iterator.h"
#include "monster_batch_policy.h"
#include "scent_map.h"
#include "thread_pool.h"

namespace
{
thread_local monster_scent_batch *current_scent_batch = nullptr;
thread_local monster_batch_policy scent_policy;
constexpr std::size_t max_sources = 16384;
} // namespace

void monster_scent_batch::observe_serial( double microseconds )
{
    scent_policy.observe( 0, microseconds );
}

bool monster_scent_batch::worth_collecting()
{
    return scent_policy.estimate( 0 ) >= 20.0;
}

monster_scent_batch::~monster_scent_batch()
{
    if( attempted_ ) {
        scent_policy.finish( 0, task_count_, overhead_, used_count_ * serial_cost_ );
    }
    for( auto **link = &current_scent_batch; *link; link = &( *link )->previous_ ) {
        if( *link == this ) {
            *link = previous_;
            break;
        }
    }
}

void monster_scent_batch::add( const tripoint_bub_ms &position )
{
    if( published_ || indices_.size() >= max_sources ) {
        return;
    }
    indices_.emplace( position, indices_.size() );
}

void monster_scent_batch::prepare( const map &here, const scent_map &scents )
try {
    static_assert( SCENT_MAP_Z_REACH == 1 );
    if( published_ || attempted_ || indices_.size() < 512 || is_pool_worker_thread() ||
        get_thread_pool().num_workers() < 2 ) {
        return;
    }
    if( !scent_policy.begin( 0, indices_.size(), 512, 20.0 ) ) {
        return;
    }
    serial_cost_ = scent_policy.estimate( 0 );
    const std::size_t chunks = monster_batch_policy::chunks( indices_.size(),
                               get_thread_pool().num_workers(), 256, serial_cost_ );
    if( chunks < 2 ) {
        return;
    }
    attempted_ = true;
    task_count_ = indices_.size();
    monster_batch_timer preparation( overhead_ );
    monster_scent_snapshot snapshot;
    snapshot.width = MAPSIZE_X;
    snapshot.height = MAPSIZE_Y;
    snapshot.z = here.get_abs_sub().z();
    snapshot.values = scents.snapshot_values();
    entries_.resize( indices_.size() );
    for( const auto &source : indices_ ) {
        const auto range = here.points_in_radius( source.first, 1, SCENT_MAP_Z_REACH );
        auto &entry = entries_[source.second];
        entry.min = range.min();
        entry.max = range.max();
    }
    map_ = &here;
    scents_ = &scents;
    origin_ = here.get_abs_sub();
    revision_ = scents.revision();
    parallel_for( 0, static_cast<int>( chunks ),
    [&]( int chunk ) {
        const std::size_t end = entries_.size() * ( chunk + 1 ) / chunks;
        for( std::size_t i = entries_.size() * chunk / chunks; i < end; ++i ) {
            auto &entry = entries_[i];
            entry.ranking = rank_monster_scent( snapshot, entry.min, entry.max );
        }
    } );
    previous_ = current_scent_batch;
    current_scent_batch = this;
    published_ = true;
}
catch( const std::bad_alloc & ) {
    entries_.clear();
    indices_.clear();
}
catch( const std::system_error & ) {
    entries_.clear();
    indices_.clear();
}

std::optional<std::vector<tripoint_bub_ms>> monster_scent_batch::directions(
    const map &here, const scent_map &scents, const tripoint_bub_ms &position, int minimum )
{
    auto *batch = current_scent_batch;
    while( batch && batch->map_ != &here ) {
        batch = batch->previous_;
    }
    if( !batch || batch->map_ != &here || batch->scents_ != &scents || minimum <= 0 ||
        batch->origin_ != here.get_abs_sub() || batch->revision_ != scents.revision() ) {
        return std::nullopt;
    }
    const auto found = batch->indices_.find( position );
    if( found == batch->indices_.end() ) {
        return std::nullopt;
    }
    monster_batch_timer validation( batch->overhead_ );
    ++batch->used_count_;
    return select_monster_scent( batch->entries_[found->second].ranking, minimum,
    [&]( const tripoint_bub_ms &candidate ) {
        return scents.inbounds( candidate );
    } );
}
