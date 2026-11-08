#pragma once
#ifndef CATA_SRC_PLAYER_CONTROL_H
#define CATA_SRC_PLAYER_CONTROL_H

#include <memory>

#include "player_identity.h"

class Character;
class player_control_registry;
struct player_control_state;

// Observes one assignment without retaining the actor or controller. A
// reference cannot be resolved against another world or a later assignment.
class player_control_reference
{
    public:
        Character *resolve( const player_control_registry &world ) const;
    private:
        friend class player_control_registry;
        std::weak_ptr<player_control_state> state_;
};

// Simulation-thread owner of one player/actor assignment. Moving transfers
// ownership; destruction/reset releases it. Never a network credential.
class player_control
{
    public:
        player_control() = default;
        player_control( const player_control & ) = delete;
        player_control &operator=( const player_control & ) = delete;
        player_control( player_control && ) noexcept = default;
        player_control &operator=( player_control && ) noexcept = default;
        // Exact retained actor, including death while a final save is pending.
        Character *get() const;
        player_id player() const;
        // Native body/effect phases, driven by this assignment. Does not run
        // input or NPC AI, and rejects revoked world/actor assignments.
        void update_body();
        void process_turn();
        void reset();
    private:
        friend class player_control_registry;
        std::shared_ptr<player_control_state> state_;
};

// One table per world, shared by local and remote controllers. Claiming is an
// explicit owner-thread operation after admission, not authorization by ID.
// At most one live assignment may own a player or a native character ID.
// NPC load/unload validity remains the native lifetime registry's concern.
class player_control_registry
{
    public:
        player_control_registry();
        ~player_control_registry();
        player_control_registry( const player_control_registry & ) = delete;
        player_control_registry &operator=( const player_control_registry & ) = delete;
        player_control claim( const player_id &player, Character &actor );
        player_control_reference find( const player_id &player ) const;
        bool is_claimed( const Character &actor ) const;
        bool is_reserved( const player_id &player ) const;
        void reset();
    private:
        friend class player_control_reference;
        struct impl;
        std::unique_ptr<impl> impl_;
};

#endif // CATA_SRC_PLAYER_CONTROL_H
