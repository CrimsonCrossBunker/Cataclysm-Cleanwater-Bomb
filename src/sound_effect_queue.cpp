#include "sound_effect_queue.h"

#include <algorithm>
#include <limits>
#include <utility>

bool sfx::sound_effect_queue::later::operator()( const pending_sound &lhs,
        const pending_sound &rhs ) const
{
    return lhs.due > rhs.due || ( lhs.due == rhs.due && lhs.order > rhs.order );
}

void sfx::sound_effect_queue::push( queued_sound sound, clock::time_point due )
{
    sound.random_seed = random_engine();
    pending.push( { due, next_order++, std::move( sound ) } );
}

bool sfx::sound_effect_queue::enqueue( melee_sound_sequence sequence, clock::time_point now )
{
    const size_t count = sequence.hit ? 2 : 1;
    // Reject the whole cosmetic sequence on overload, never a lone hit.
    if( pending.size() + count > capacity ) {
        return false;
    }
    const clock::time_point swing_due = now + std::chrono::milliseconds(
                                            std::uniform_int_distribution<int>( 1, 2 )( random_engine ) );
    push( std::move( sequence.swing ), swing_due );
    if( sequence.hit ) {
        const int delay = std::max( sequence.weapon_volume, 0 ) *
                          std::uniform_int_distribution<int>( sequence.target_monster ? 12 : 9,
                                  sequence.target_monster ? 16 : 12 )( random_engine );
        push( std::move( *sequence.hit ), swing_due + std::chrono::milliseconds( delay ) );
    }
    return true;
}

bool sfx::sound_effect_queue::enqueue_gunshot( queued_sound sound, clock::time_point burst_start,
        int rpm, int shot_index )
{
    if( pending.size() >= capacity ) {
        return false;
    }
    // Compute every deadline from the first shot so fractional intervals never accumulate error.
    const auto offset = std::chrono::microseconds( std::chrono::minutes( 1 ) ) * shot_index / rpm;
    push( std::move( sound ), burst_start + offset );
    return true;
}

std::optional<sfx::queued_sound> sfx::sound_effect_queue::pop_due( clock::time_point now )
{
    if( pending.empty() || pending.top().due > now ) {
        return std::nullopt;
    }
    queued_sound result = pending.top().sound;
    pending.pop();
    return result;
}

std::optional<uint32_t> sfx::sound_effect_queue::wait_ms( clock::time_point now ) const
{
    if( pending.empty() ) {
        return std::nullopt;
    }
    const auto delay = std::max( pending.top().due - now, clock::duration::zero() );
    const auto ms = std::chrono::ceil<std::chrono::milliseconds>( delay ).count();
    return static_cast<uint32_t>( std::min<int64_t>( ms, std::numeric_limits<uint32_t>::max() ) );
}

void sfx::sound_effect_queue::clear()
{
    pending = {};
    next_order = 0;
    random_engine.seed( std::minstd_rand0::default_seed );
}

bool sfx::sound_effect_queue::empty() const
{
    return pending.empty();
}

size_t sfx::sound_effect_queue::size() const
{
    return pending.size();
}
