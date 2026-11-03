#include "item_temperature.h"

#include "cpu_scheduler.h"

namespace
{
thread_local item_temperature_batch *current_batch = nullptr;
constexpr std::size_t maximum_batch_size = 8192;
}

item_temperature_batch::~item_temperature_batch()
{
    if( published_ ) {
        current_batch = previous_;
    }
}

bool item_temperature_batch::full() const
{
    return entries_.size() >= maximum_batch_size || published_;
}

void item_temperature_batch::add( const item *owner, const item_temperature_input &input )
{
    if( full() ) {
        return;
    }
    const auto inserted = indices_.emplace( owner, entries_.size() );
    if( inserted.second ) {
        entries_.push_back( { input, {} } );
    }
}

void item_temperature_batch::prepare()
{
    if( published_ || entries_.size() < 32 ) {
        return;
    }
    cpu_parallel_for( cpu_task_kind::item_temperature, entries_.size(), 16,
    [this]( std::size_t begin, std::size_t end ) {
        for( std::size_t i = begin; i < end; ++i ) {
            entries_[i].result = calculate_item_temperature( entries_[i].input );
        }
    } );
    // Publish only after all workers finish; nested processing restores its outer batch.
    previous_ = current_batch;
    current_batch = this;
    published_ = true;
}

std::optional<item_temperature_result> item_temperature_batch::find(
    const item *owner, const item_temperature_input &input )
{
    if( !current_batch ) {
        return std::nullopt;
    }
    const auto found = current_batch->indices_.find( owner );
    if( found == current_batch->indices_.end() ) {
        return std::nullopt;
    }
    const entry &prepared = current_batch->entries_[found->second];
    // Earlier items can change the environment, contents or even replace an item.
    // Reuse a number only when every input to the formula is still identical.
    return prepared.input == input ? std::optional<item_temperature_result>( prepared.result ) :
           std::nullopt;
}
