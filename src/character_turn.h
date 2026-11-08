#pragma once
#ifndef CATA_SRC_CHARACTER_TURN_H
#define CATA_SRC_CHARACTER_TURN_H

#include <memory>

class Character;

enum class character_turn_policy {
    // The simulation calls each phase once, at its existing native boundary.
    native_step,
    // Compatibility with the current client clock: catch up elapsed time but
    // preserve externally granted moves. This is not server authority.
    observed_clock
};

// Owner-thread body/effect driver for one exact Character instance. It owns
// timing, not the actor, input, activities, AI, world advancement or transport.
// Its enclosing control/session owns the lifecycle and must reset on detach.
class character_turn_driver
{
    public:
        character_turn_driver();
        ~character_turn_driver();
        character_turn_driver( const character_turn_driver & ) = delete;
        character_turn_driver &operator=( const character_turn_driver & ) = delete;
        character_turn_driver( character_turn_driver && ) noexcept;
        character_turn_driver &operator=( character_turn_driver && ) noexcept;

        // Idempotent for the same live instance, ID and policy. Explicitly
        // rebinding another incarnation starts a fresh clock, even at the
        // same address or calendar time.
        void bind( Character &actor, character_turn_policy policy );
        void reset();
        void update_body();
        void process_turn();
    private:
        struct impl;
        std::unique_ptr<impl> impl_;
};

#endif // CATA_SRC_CHARACTER_TURN_H
