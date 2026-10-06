#include "melee_sound_queue.h"

#include <algorithm>
#include <utility>

bool sfx::melee_sound_queue::later::operator()( const pending_sound &lhs,
        const pending_sound &rhs ) const
{
    return lhs.due > rhs.due || ( lhs.due == rhs.due && lhs.order > rhs.order );
}

bool sfx::melee_sound_queue::enqueue( melee_sound_sequence sequence, clock::time_point now )
{
    const size_t count = sequence.hit ? 2 : 1;
    // Reject the whole cosmetic sequence on overload, never a lone hit.
    if( pending.size() + count > capacity ) {
        return false;
    }
    const clock::time_point swing_due = now + std::chrono::milliseconds(
                                            std::uniform_int_distribution<int>( 1, 2 )( random_engine ) );
    sequence.swing.random_seed = random_engine();
    pending.push( { swing_due, next_order++, std::move( sequence.swing ) } );
    if( sequence.hit ) {
        const int delay = std::max( sequence.weapon_volume, 0 ) *
                          std::uniform_int_distribution<int>( sequence.target_monster ? 12 : 9,
                                  sequence.target_monster ? 16 : 12 )( random_engine );
        sequence.hit->random_seed = random_engine();
        pending.push( { swing_due + std::chrono::milliseconds( delay ), next_order++,
                        std::move( *sequence.hit ) } );
    }
    return true;
}

std::optional<sfx::queued_sound> sfx::melee_sound_queue::pop_due( clock::time_point now )
{
    if( pending.empty() || pending.top().due > now ) {
        return std::nullopt;
    }
    queued_sound result = pending.top().sound;
    pending.pop();
    return result;
}

void sfx::melee_sound_queue::clear()
{
    pending = {};
    next_order = 0;
    random_engine.seed( std::minstd_rand0::default_seed );
}

bool sfx::melee_sound_queue::empty() const
{
    return pending.empty();
}

size_t sfx::melee_sound_queue::size() const
{
    return pending.size();
}
