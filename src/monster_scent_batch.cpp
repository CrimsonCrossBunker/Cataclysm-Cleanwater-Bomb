#include "monster_scent_batch.h"

#include "cpu_scheduler.h"
#include "map.h"
#include "map_iterator.h"
#include "scent_map.h"

namespace
{
thread_local monster_scent_batch *current_scent_batch = nullptr;
constexpr std::size_t max_sources = 16384;
} // namespace

monster_scent_batch::~monster_scent_batch()
{
    if( published_ ) {
        current_scent_batch = previous_;
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
{
    static_assert( SCENT_MAP_Z_REACH == 1 );
    if( published_ || indices_.size() < 32 || !cpu_parallel_enabled() ) {
        return;
    }
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
    cpu_parallel_for( cpu_task_kind::monster_scent, entries_.size(), 16,
    [&]( std::size_t begin, std::size_t end ) {
        for( std::size_t i = begin; i < end; ++i ) {
            auto &entry = entries_[i];
            entry.ranking = rank_monster_scent( snapshot, entry.min, entry.max );
        }
    } );
    previous_ = current_scent_batch;
    current_scent_batch = this;
    published_ = true;
}

std::optional<std::vector<tripoint_bub_ms>> monster_scent_batch::directions(
    const map &here, const scent_map &scents, const tripoint_bub_ms &position, int minimum )
{
    const auto *batch = current_scent_batch;
    if( !batch || batch->map_ != &here || batch->scents_ != &scents || minimum <= 0 ||
        batch->origin_ != here.get_abs_sub() || batch->revision_ != scents.revision() ||
        !cpu_parallel_enabled() ) {
        return std::nullopt;
    }
    const auto found = batch->indices_.find( position );
    if( found == batch->indices_.end() ) {
        return std::nullopt;
    }
    return select_monster_scent( batch->entries_[found->second].ranking, minimum,
    [&]( const tripoint_bub_ms &candidate ) {
        return scents.inbounds( candidate );
    } );
}
