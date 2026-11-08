#include "player_control.h"

#include <map>
#include <stdexcept>
#include <utility>

#include "character.h"
#include "character_id.h"
#include "creature.h"
#include "safe_reference.h"

struct player_control_scope {};

struct player_control_state {
    std::weak_ptr<const player_control_scope> owner;
    player_id player;
    character_id actor_id;
    safe_reference<Creature> actor;
    bool active = true;

    Character *get() const {
        Creature *value = actor.get();
        Character *character = value ? value->as_character() : nullptr;
        return active && !owner.expired() && character && character->getID() == actor_id ?
               character : nullptr;
    }
};

struct player_control_registry::impl {
    std::shared_ptr<const player_control_scope> owner = std::make_shared<player_control_scope>();
    std::map<player_id, std::weak_ptr<player_control_state>> players;

    void prune() {
        for( auto it = players.begin(); it != players.end(); ) {
            auto state = it->second.lock();
            if( !state || !state->get() ) {
                if( state ) {
                    state->active = false;
                }
                it = players.erase( it );
            } else {
                ++it;
            }
        }
    }
};

player_control_registry::player_control_registry() : impl_( std::make_unique<impl>() ) {}
player_control_registry::~player_control_registry() = default;

Character *player_control::get() const
{
    return state_ ? state_->get() : nullptr;
}

player_id player_control::player() const
{
    return state_ ? state_->player : player_id();
}

void player_control::reset()
{
    state_.reset();
}

Character *player_control_reference::resolve( const player_control_registry &world ) const
{
    const auto state = state_.lock();
    Character *actor = state && state->owner.lock() == world.impl_->owner ? state->get() : nullptr;
    return actor && !actor->is_dead_state() ? actor : nullptr;
}

player_control player_control_registry::claim( const player_id &player, Character &actor )
{
    if( !player.valid() || !actor.getID().is_valid() || actor.is_dead_state() ) {
        throw std::runtime_error( "Invalid player control assignment" );
    }
    impl_->prune();
    if( impl_->players.count( player ) || is_claimed( actor ) ) {
        throw std::runtime_error( "Player or character already has a controller" );
    }
    auto state = std::make_shared<player_control_state>();
    state->owner = impl_->owner;
    state->player = player;
    state->actor_id = actor.getID();
    state->actor = actor.get_safe_reference();
    impl_->players.emplace( player, state );
    player_control result;
    result.state_ = std::move( state );
    return result;
}

player_control_reference player_control_registry::find( const player_id &player ) const
{
    player_control_reference result;
    const auto found = impl_->players.find( player );
    if( found != impl_->players.end() ) {
        result.state_ = found->second;
    }
    return result;
}

bool player_control_registry::is_claimed( const Character &actor ) const
{
    for( const auto &entry : impl_->players ) {
        const auto state = entry.second.lock();
        const Character *claimed = state ? state->get() : nullptr;
        if( claimed && ( claimed == &actor || state->actor_id == actor.getID() ) ) {
            return true;
        }
    }
    return false;
}

bool player_control_registry::is_reserved( const player_id &player ) const
{
    const auto found = impl_->players.find( player );
    const auto state = found == impl_->players.end() ? nullptr : found->second.lock();
    return state && state->get();
}

void player_control_registry::reset()
{
    // Changing scope also invalidates controllers retained outside this table.
    impl_->owner = std::make_shared<player_control_scope>();
    impl_->players.clear();
}
