#pragma once
#ifndef CATA_SRC_CHARACTER_ACTION_GUARD_H
#define CATA_SRC_CHARACTER_ACTION_GUARD_H

#include <optional>

#include "character_id.h"
#include "memory_fast.h"
#include "npc_lifetime.h"
#include "safe_reference.h"

class Character;
class Creature;

// Owner-thread scope for a native character operation that invokes callbacks.
// Keep an active NPC's storage alive until native code returns, but stop the
// operation after unload, removal, or an in-place identity replacement. Death
// also stops the operation unless the caller explicitly allows it.
// This is a lifetime check, not permission to control the character.
class character_action_guard
{
    public:
        explicit character_action_guard( Character &who, bool allow_dead = false );
        Character *get() const;
        Character *get_alive() const {
            return get( false );
        }
        explicit operator bool() const {
            return get() != nullptr;
        }

    private:
        friend class damage_event_participants;
        Character *get( bool allow_dead ) const;

        safe_reference<Creature> memory;
        shared_ptr_fast<Character> retained;
        character_id identity;
        bool allow_dead;
        npc_lifetime npc_reference;
        const npc_lifetime_registry *npc_owner = nullptr;
};

// Keep the participants of a hit stable through HP changes and notification.
// Damage may itself be lethal, but a listener cannot supply a new lifetime.
class damage_event_participants
{
    public:
        damage_event_participants( Character &target, Creature *source );
        void begin_notification();
        // HP updates may leave the same incarnation lethally injured.
        bool same_target() const;
        Character *target() const;
        Creature *source() const;

    private:
        character_action_guard target_guard;
        std::optional<character_action_guard> source_guard;
        safe_reference<Creature> other_source;
        shared_ptr_fast<Creature> retained_source;
        bool self_inflicted;
        bool allow_dead_target;
};

#endif // CATA_SRC_CHARACTER_ACTION_GUARD_H
