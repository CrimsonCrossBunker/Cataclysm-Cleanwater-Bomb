#include "catalua_ui_scheduler.h"

#include <algorithm>
#include <limits>
#include <stdexcept>

namespace cata::lua_ui
{

std::uint64_t deterministic_turn_scheduler::schedule(
    const std::int64_t now, const std::int64_t delay, const std::int64_t interval,
    const std::size_t source_index )
{
    if( delay <= 0 || delay > maximum_delay_turns ||
        interval < 0 || interval > maximum_delay_turns ) {
        throw std::invalid_argument( "Lua scheduler delay must be within 1..1000000000 turns" );
    }
    if( tasks_.size() >= maximum_tasks ) {
        throw std::runtime_error( "Lua scheduler task limit reached" );
    }
    if( now > std::numeric_limits<std::int64_t>::max() - delay ) {
        throw std::overflow_error( "Lua scheduler due turn overflow" );
    }
    const std::uint64_t id = next_id_++;
    tasks_.push_back( { id, now + delay, interval, source_index, next_sequence_++ } );
    return id;
}

std::uint64_t deterministic_turn_scheduler::schedule_after(
    const std::int64_t now, const std::int64_t delay, const std::size_t source_index )
{
    return schedule( now, delay, 0, source_index );
}

std::uint64_t deterministic_turn_scheduler::schedule_every(
    const std::int64_t now, const std::int64_t interval, const std::size_t source_index )
{
    return schedule( now, interval, interval, source_index );
}

bool deterministic_turn_scheduler::cancel(
    const std::uint64_t id, const std::size_t source_index )
{
    const auto found = std::find_if(
    tasks_.begin(), tasks_.end(), [id, source_index]( const scheduled_script_task & task ) {
        return task.id == id && task.source_index == source_index;
    } );
    if( found == tasks_.end() ) {
        return false;
    }
    tasks_.erase( found );
    return true;
}

bool deterministic_turn_scheduler::cancel_unchecked( const std::uint64_t id )
{
    const auto found = std::find_if(
    tasks_.begin(), tasks_.end(), [id]( const scheduled_script_task & task ) {
        return task.id == id;
    } );
    if( found == tasks_.end() ) {
        return false;
    }
    tasks_.erase( found );
    return true;
}

std::vector<scheduled_script_task> deterministic_turn_scheduler::take_due(
    const std::int64_t now )
{
    std::stable_sort(
        tasks_.begin(), tasks_.end(), []( const scheduled_script_task & left,
    const scheduled_script_task & right ) {
        if( left.due_turn != right.due_turn ) {
            return left.due_turn < right.due_turn;
        }
        return left.sequence < right.sequence;
    } );

    std::vector<scheduled_script_task> due;
    due.reserve( std::min( tasks_.size(), maximum_callbacks_per_turn ) );
    for( scheduled_script_task &task : tasks_ ) {
        if( task.due_turn > now || due.size() >= maximum_callbacks_per_turn ) {
            break;
        }
        due.push_back( task );
        if( task.interval > 0 ) {
            const std::int64_t elapsed = now - task.due_turn;
            const std::int64_t periods = elapsed / task.interval + 1;
            if( periods > ( std::numeric_limits<std::int64_t>::max() -
                            task.due_turn ) / task.interval ) {
                task.due_turn = std::numeric_limits<std::int64_t>::max();
            } else {
                task.due_turn += periods * task.interval;
            }
            task.sequence = next_sequence_++;
        }
    }
    tasks_.erase(
        std::remove_if(
    tasks_.begin(), tasks_.end(), [&due]( const scheduled_script_task & task ) {
        return task.interval == 0 &&
        std::any_of( due.begin(), due.end(), [&task]( const scheduled_script_task & entry ) {
            return entry.id == task.id;
        } );
    } ),
    tasks_.end() );
    return due;
}

bool deterministic_turn_scheduler::contains( const std::uint64_t id ) const
{
    return std::any_of( tasks_.begin(), tasks_.end(), [id]( const scheduled_script_task & task ) {
        return task.id == id;
    } );
}

std::size_t deterministic_turn_scheduler::size() const
{
    return tasks_.size();
}

const std::vector<scheduled_script_task> &
deterministic_turn_scheduler::all() const
{
    return tasks_;
}

void deterministic_turn_scheduler::clear()
{
    tasks_.clear();
    next_id_ = 1;
    next_sequence_ = 1;
}

} // namespace cata::lua_ui
