#include "item_rot.h"

#include "cpu_scheduler.h"

namespace
{
thread_local item_rot_batch *current_rot_batch = nullptr;
}

item_rot_batch::~item_rot_batch()
{
    if( published_ ) {
        current_rot_batch = previous_;
    }
}

bool item_rot_batch::full() const
{
    return published_ || entries_.size() >= 8192;
}

void item_rot_batch::add( const item *owner, const item_rot_input &input )
{
    if( full() ) {
        return;
    }
    const auto inserted = indices_.emplace( owner, entries_.size() );
    if( inserted.second ) {
        entries_.push_back( { input, {} } );
    }
}

void item_rot_batch::prepare()
{
    if( published_ || entries_.size() < 32 ) {
        return;
    }
    cpu_parallel_for( cpu_task_kind::item_daily_rot, entries_.size(), 16,
    [this]( std::size_t begin, std::size_t end ) {
        for( std::size_t i = begin; i < end; ++i ) {
            entries_[i].increments = calculate_item_rot_increments( entries_[i].input );
        }
    } );
    previous_ = current_rot_batch;
    current_rot_batch = this;
    published_ = true;
}

std::optional<time_duration> item_rot_batch::find( const item *owner,
        const item_rot_input &input, bool cold, bool mushy )
{
    if( !current_rot_batch ) {
        return std::nullopt;
    }
    const auto found = current_rot_batch->indices_.find( owner );
    if( found == current_rot_batch->indices_.end() ) {
        return std::nullopt;
    }
    const entry &prepared = current_rot_batch->entries_[found->second];
    if( !( prepared.input == input ) ) {
        return std::nullopt;
    }
    return prepared.increments[static_cast<std::size_t>( mushy ) * 2 + cold];
}
