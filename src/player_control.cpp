#include "player_control.h"

#include <map>
#include <stdexcept>
#include <utility>

#include "character.h"
#include "character_turn.h"
#include "character_id.h"
#include "creature.h"
#include "safe_reference.h"

struct player_control_scope {};

struct player_control_state {
    std::weak_ptr<const player_control_scope> owner;
    player_id player;
    character_id actor_id;
    safe_reference<Creature> actor;
    player_control_kind kind = player_control_kind::native;
    bool active = true;
    character_turn_driver turns;

    Character *get() const {
        Creature *value = actor.get();
        Character *character = value ? value->as_character() : nullptr;
        return active && !owner.expired() && character && character->getID() == actor_id &&
               player_control_registry::observes_assignment( *character, this ) ?
               character : nullptr;
    }
};

struct player_control_registry::impl {
    std::shared_ptr<const player_control_scope> owner = std::make_shared<player_control_scope>();
    std::map<player_id, std::weak_ptr<player_control_state>> players;

    std::shared_ptr<player_control_state> find_actor( const Character &actor ) const {
        if( actor.is_dead_state() ) {
            return nullptr;
        }
        for( const auto &entry : players ) {
            const auto state = entry.second.lock();
            if( state && state->kind == player_control_kind::native && state->get() == &actor ) {
                return state;
            }
        }
        return nullptr;
    }

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

bool player_control_registry::observes_assignment( const Character &actor,
        const player_control_state *state )
{
    // A native move leaves the source object alive. Its safe reference alone
    // cannot prove it still holds this role after its fields have moved away.
    return actor.player_control_.lock().get() == state;
}

bool Character::is_player_controlled() const
{
    const auto state = player_control_.lock();
    return state && state->get() == this;
}

bool Character::has_native_player_control() const
{
    const auto state = player_control_.lock();
    return state && state->kind == player_control_kind::native && state->get() == this;
}

player_control::player_control( player_control && ) noexcept = default;

player_control &player_control::operator=( player_control &&other ) noexcept
{
    if( this != &other ) {
        reset();
        state_ = std::move( other.state_ );
    }
    return *this;
}

player_control::~player_control()
{
    reset();
}

Character *player_control::get() const
{
    return state_ ? state_->get() : nullptr;
}

player_id player_control::player() const
{
    return state_ ? state_->player : player_id();
}

void player_control::update_body()
{
    if( !get() || state_->kind != player_control_kind::native ) {
        throw std::runtime_error( "Cannot advance an inactive or externally driven player control" );
    }
    state_->turns.update_body();
}

void player_control::process_turn()
{
    if( !get() || state_->kind != player_control_kind::native ) {
        throw std::runtime_error( "Cannot advance an inactive or externally driven player control" );
    }
    state_->turns.process_turn();
}

void player_control::reset()
{
    // An in-flight native phase may retain state until its callback returns.
    // Releasing authority is immediate even while that state stays allocated.
    if( state_ ) {
        state_->active = false;
    }
    state_.reset();
}

Character *player_control_reference::resolve( const player_control_registry &world ) const
{
    const auto state = state_.lock();
    Character *actor = state && state->owner.lock() == world.impl_->owner ? state->get() : nullptr;
    return actor && !actor->is_dead_state() ? actor : nullptr;
}

player_control player_control_registry::claim( const player_id &player, Character &actor,
        player_control_kind kind )
{
    if( !player.valid() || !actor.getID().is_valid() || actor.is_dead_state() ) {
        throw std::runtime_error( "Invalid player control assignment" );
    }
    impl_->prune();
    if( impl_->players.count( player ) || is_claimed( actor ) || actor.is_player_controlled() ) {
        throw std::runtime_error( "Player or character already has a controller" );
    }
    auto state = std::make_shared<player_control_state>();
    state->owner = impl_->owner;
    state->player = player;
    state->actor_id = actor.getID();
    state->actor = actor.get_safe_reference();
    state->kind = kind;
    state->turns.bind( actor, character_turn_policy::native_step );
    impl_->players.emplace( player, state );
    actor.player_control_ = state;
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

bool player_control_registry::update_body( Character &actor )
{
    const auto state = impl_->find_actor( actor );
    if( !state ) {
        return false;
    }
    state->turns.update_body();
    return true;
}

bool player_control_registry::process_turn( Character &actor )
{
    const auto state = impl_->find_actor( actor );
    if( !state ) {
        return false;
    }
    state->turns.process_turn();
    return true;
}
