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
    for( auto &entry : windows_ ) {
        if( overlaps( entry.first, previous ) != overlaps( entry.first, next ) ) {
            entry.second.ready = false;
        }
    }
    cells_[index] = next;
}

void monster_target_candidates::warm( const point &pos )
{
    if( windows_.size() < max_windows ) {
        windows_.try_emplace( cell_at( pos ) );
    }
}

void monster_target_candidates::prepare( cata_thread_pool &pool )
{
    std::vector<std::pair<cell, window *>> pending;
    for( auto &entry : windows_ ) {
        if( !entry.second.ready ) {
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
    }
}

const monster_target_candidates::indices &monster_target_candidates::query(
    const point &pos, cata_thread_pool &pool )
{
    const cell key = cell_at( pos );
    if( windows_.find( key ) == windows_.end() && windows_.size() == max_windows ) {
        windows_.clear();
    }
    window &entry = windows_[key];
    if( !entry.ready ) {
        prepare( pool );
    }
    return entry.candidates;
}
