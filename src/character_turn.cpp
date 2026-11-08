#include "character_turn.h"

#include <algorithm>
#include <stdexcept>
#include <utility>

#include "calendar.h"
#include "character.h"
#include "character_id.h"
#include "creature.h"
#include "safe_reference.h"

struct character_turn_driver::impl {
    safe_reference<Creature> actor;
    character_id id;
    character_turn_policy policy;
    time_point last_body = calendar::before_time_starts;
    time_point last_effects = calendar::before_time_starts;

    Character &get() const {
        Creature *value = actor.get();
        Character *character = value ? value->as_character() : nullptr;
        if( !character || character->getID() != id ) {
            throw std::runtime_error( "Character turn driver lost its actor" );
        }
        return *character;
    }
};

character_turn_driver::character_turn_driver() = default;
character_turn_driver::~character_turn_driver() = default;
character_turn_driver::character_turn_driver( character_turn_driver && ) noexcept = default;
character_turn_driver &character_turn_driver::operator=( character_turn_driver && ) noexcept =
    default;

void character_turn_driver::bind( Character &actor, character_turn_policy policy )
{
    if( impl_ && impl_->actor.get() == &actor && impl_->id == actor.getID() &&
        impl_->policy == policy ) {
        return;
    }
    auto state = std::make_unique<impl>();
    state->actor = actor.get_safe_reference();
    state->id = actor.getID();
    state->policy = policy;
    impl_ = std::move( state );
}

void character_turn_driver::reset()
{
    impl_.reset();
}

void character_turn_driver::update_body()
{
    if( !impl_ ) {
        throw std::runtime_error( "Character turn driver is not bound" );
    }
    Character &actor = impl_->get();
    if( impl_->policy == character_turn_policy::native_step ) {
        actor.update_body();
        return;
    }
    if( calendar::turn == impl_->last_body ) {
        return;
    }
    if( impl_->last_body != calendar::before_time_starts && calendar::turn > impl_->last_body ) {
        actor.update_body( impl_->last_body, calendar::turn );
    } else {
        actor.update_body();
    }
    impl_->last_body = calendar::turn;
}

void character_turn_driver::process_turn()
{
    if( !impl_ ) {
        throw std::runtime_error( "Character turn driver is not bound" );
    }
    Character &actor = impl_->get();
    if( impl_->policy == character_turn_policy::native_step ) {
        actor.process_turn();
        return;
    }
    const int moves = actor.get_moves();
    int elapsed = 0;
    if( impl_->last_effects == calendar::before_time_starts ) {
        elapsed = 1;
    } else if( calendar::turn > impl_->last_effects ) {
        elapsed = to_turns<int>( calendar::turn - impl_->last_effects );
    }
    impl_->last_effects = calendar::turn;
    // Preserve the existing bounded client catch-up policy. Changing the cap
    // or replaying each intermediate calendar requires separate rule migration.
    constexpr int max_catchup = 100;
    for( int i = 0; i < std::min( elapsed, max_catchup ); ++i ) {
        actor.process_turn();
    }
    actor.set_moves( moves );
}
