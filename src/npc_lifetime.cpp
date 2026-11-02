#include "npc_lifetime.h"

#include <algorithm>
#include <cstdint>
#include <limits>
#include <unordered_map>

#include "creature.h"
#include "game.h"
#include "npc.h"
#include "safe_reference.h"

struct npc_lifetime_scope {};

struct npc_lifetime_state {
    std::weak_ptr<const npc_lifetime_scope> owner;
    safe_reference<Creature> reference;
    character_id id;
    std::size_t generation = 0;
    bool active = true;
};

struct npc_lifetime_registry::impl {
    std::shared_ptr<const npc_lifetime_scope> owner = std::make_shared<npc_lifetime_scope>();
    std::unordered_map<int64_t, std::weak_ptr<npc_lifetime_state>> states;
    std::size_t lookups_until_prune = 64;

    void prune() {
        if( --lookups_until_prune != 0 ) {
            return;
        }
        for( auto it = states.begin(); it != states.end(); ) {
            if( it->second.expired() ) {
                it = states.erase( it );
            } else {
                ++it;
            }
        }
        lookups_until_prune = std::max<std::size_t>( 64, states.size() );
    }
};

npc_lifetime_registry::npc_lifetime_registry() : impl_( std::make_unique<impl>() ) {}
npc_lifetime_registry::~npc_lifetime_registry() = default;

bool npc_lifetime::belongs_to( const npc_lifetime_registry &owner ) const
{
    return state_ && state_->owner.lock() == owner.impl_->owner;
}

npc *npc_lifetime::resolve( const npc_lifetime_registry &owner ) const
{
    if( !belongs_to( owner ) ||
        !state_->active || state_->generation != generation_ || state_->id != id_ ) {
        return nullptr;
    }
    Creature *creature = state_->reference.get();
    npc *value = creature ? creature->as_npc() : nullptr;
    return value && value->getID() == id_ && !value->is_dead() ? value : nullptr;
}

npc_lifetime npc_lifetime_registry::acquire( npc &value )
{
    npc_lifetime result;
    if( !value.getID().is_valid() || value.is_dead() ) {
        return result;
    }
    impl_->prune();
    auto &stored = impl_->states[value.getID().get_value()];
    auto state = stored.lock();
    if( state && ( state->reference.get() != &value || !state->active ) ) {
        // Replacement and reload must never revive an earlier incarnation.
        state->active = false;
        if( state->generation == std::numeric_limits<std::size_t>::max() ) {
            state.reset();
        } else {
            ++state->generation;
        }
    }
    if( !state ) {
        state = std::make_shared<npc_lifetime_state>();
        state->owner = impl_->owner;
        stored = state;
    }
    state->reference = value.get_safe_reference();
    state->id = value.getID();
    state->active = true;
    result.state_ = state;
    result.id_ = state->id;
    result.generation_ = state->generation;
    return result;
}

npc_lifetime npc_lifetime_registry::active_reference( npc &value ) const
{
    npc_lifetime result;
    const auto found = impl_->states.find( value.getID().get_value() );
    if( found == impl_->states.end() ) {
        return result;
    }
    const auto state = found->second.lock();
    if( !state || !state->active || state->reference.get() != &value || value.is_dead() ) {
        return result;
    }
    result.state_ = state;
    result.id_ = state->id;
    result.generation_ = state->generation;
    return result;
}

void npc_lifetime_registry::activate( npc &value )
{
    acquire( value );
}

void npc_lifetime_registry::retire( npc &value )
{
    impl_->prune();
    const auto found = impl_->states.find( value.getID().get_value() );
    if( found == impl_->states.end() ) {
        return;
    }
    const auto state = found->second.lock();
    // A late unload for a replaced object must not retire its successor.
    if( state && state->reference.get() == &value && state->active ) {
        state->active = false;
        if( state->generation != std::numeric_limits<std::size_t>::max() ) {
            ++state->generation;
        }
    }
}

void npc_lifetime_registry::reset()
{
    // Rotate identity rather than reuse a numeric epoch after wraparound.
    impl_->owner = std::make_shared<npc_lifetime_scope>();
    impl_->states.clear();
    impl_->lookups_until_prune = 64;
}

npc_lifetime_registry *current_npc_lifetimes()
{
    return g ? &g->npc_lifetimes() : nullptr;
}

void activate_npc_lifetime( npc &value )
{
    if( auto *owner = current_npc_lifetimes() ) {
        owner->activate( value );
    }
}

void retire_npc_lifetime( npc &value )
{
    if( auto *owner = current_npc_lifetimes() ) {
        owner->retire( value );
    }
}
