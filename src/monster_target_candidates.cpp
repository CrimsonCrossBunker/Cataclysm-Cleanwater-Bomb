#include "monster_target_candidates.h"

#include <compute_budget.h>
#include <algorithm>
#include <cstdlib>
#include <exception>
#include <future>
#include <vector>

#include "point.h"
#include "thread_pool.h"

namespace
{
constexpr int width = 16;
int cell_axis( int value )
{
    return value / width - ( value % width < 0 ? 1 : 0 );
}
} // namespace

monster_target_candidates::cell monster_target_candidates::cell_at( const point &pos )
{
    return { cell_axis( pos.x ), cell_axis( pos.y ) };
}

monster_target_candidates::monster_target_candidates( int range ) :
    cell_range_( ( range + width - 1 ) / width )
{
}

bool monster_target_candidates::overlaps( cell observer, cell target ) const
{
    return std::abs( observer.first - target.first ) <= cell_range_ &&
           std::abs( observer.second - target.second ) <= cell_range_;
}

void monster_target_candidates::add( const point &pos )
{
    cells_.push_back( cell_at( pos ) );
    windows_.clear();
}

void monster_target_candidates::move( std::size_t index, const point &pos )
{
    const cell next = cell_at( pos );
    const cell previous = cells_.at( index );
    if( previous == next ) {
        return;
    }
    // Defer invalidation to queried windows instead of visiting all cached
    // windows for every moving monster. The history has a fixed memory bound.
    movements_[movement_clock_ % movement_history_size] = { previous, next };
    ++movement_clock_;
    cells_[index] = next;
}

void monster_target_candidates::validate( cell key, window &entry )
{
    if( !entry.ready || entry.checked_movement == movement_clock_ ) {
        return;
    }
    const std::uint64_t changes = movement_clock_ - entry.checked_movement;
    if( changes > movement_history_size ) {
        entry.ready = false;
        return;
    }
    for( std::uint64_t i = 0; i < changes; ++i ) {
        const movement &change = movements_[( entry.checked_movement + i ) % movement_history_size];
        if( overlaps( key, change.previous ) != overlaps( key, change.next ) ) {
            entry.ready = false;
            return;
        }
    }
    entry.checked_movement = movement_clock_;
}

void monster_target_candidates::warm( const point &pos )
{
    if( windows_.size() < max_windows ) {
        auto entry = windows_.try_emplace( cell_at( pos ) );
        if( entry.second ) {
            entry.first->second.prefetch = true;
            entry.first->second.checked_movement = movement_clock_;
        }
    }
}

void monster_target_candidates::prepare( cata_thread_pool &pool, window &requested )
{
    std::vector<std::pair<cell, window *>> pending;
    for( auto &entry : windows_ ) {
        // Movement can make the original warmup locations irrelevant. Do not
        // build those speculative windows after their position snapshot changed.
        const bool prefetch = entry.second.prefetch &&
                              entry.second.checked_movement == movement_clock_;
        if( !entry.second.ready && ( &entry.second == &requested || prefetch ) ) {
            pending.emplace_back( entry.first, &entry.second );
        }
    }
    const auto build = [&]( std::size_t begin, std::size_t end ) {
        for( std::size_t row = begin; row < end; ++row ) {
            indices &out = pending[row].second->candidates;
            out.clear();
            for( std::size_t i = 0; i < cells_.size(); ++i ) {
                if( overlaps( pending[row].first, cells_[i] ) ) {
                    out.push_back( i );
                }
            }
        }
    };
    // Tiny or single-window work is cheaper inline. No nested pool waits.
    const std::size_t work = cells_.size() * pending.size();
    const std::size_t chunks = std::min( { pending.size(),
                                           static_cast<std::size_t>( pool.num_workers() ), work / 4096 } );
    if( chunks < 2 || is_pool_worker_thread() ) {
        build( 0, pending.size() );
    } else {
        std::vector<std::future<void>> tasks;
        tasks.reserve( chunks );
        std::exception_ptr failure;
        try {
            for( std::size_t i = 0; i < chunks; ++i ) {
                tasks.push_back( pool.submit_returning( build, pending.size() * i / chunks,
                                                        pending.size() * ( i + 1 ) / chunks ) );
            }
        } catch( ... ) {
            failure = std::current_exception();
        }
        // Workers borrow this batch. Drain all accepted tasks even on failure.
        for( auto &task : tasks ) {
            try {
                task.get();
            } catch( ... ) {
                if( !failure ) {
                    failure = std::current_exception();
                }
            }
        }
        if( failure ) {
            std::rethrow_exception( failure );
        }
    }
    for( auto &entry : pending ) {
        entry.second->ready = true;
        entry.second->prefetch = false;
        entry.second->checked_movement = movement_clock_;
    }
}

const monster_target_candidates::indices &monster_target_candidates::query(
    const point &pos, cata_thread_pool &pool )
{
    const cell key = cell_at( pos );
    if( windows_.find( key ) == windows_.end() && windows_.size() == max_windows ) {
        const auto oldest = std::min_element( windows_.begin(), windows_.end(),
        []( const auto &lhs, const auto &rhs ) {
            return lhs.second.last_used < rhs.second.last_used;
        } );
        windows_.erase( oldest );
    }
    window &entry = windows_[key];
    entry.last_used = ++query_clock_;
    validate( key, entry );
    if( !entry.ready ) {
        prepare( pool, entry );
    }
    return entry.candidates;
}
