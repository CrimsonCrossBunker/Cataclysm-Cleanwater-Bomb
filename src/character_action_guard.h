#pragma once
#ifndef CATA_SRC_CHARACTER_ACTION_GUARD_H
#define CATA_SRC_CHARACTER_ACTION_GUARD_H

#include "character_id.h"
#include "memory_fast.h"
#include "npc_lifetime.h"
#include "safe_reference.h"

class Character;
class Creature;

// Owner-thread scope for a native character operation that invokes callbacks.
// Keep an active NPC's storage alive until native code returns, but stop the
// operation after death, unload, removal, or an in-place identity replacement.
// This is a lifetime check, not permission to control the character.
class character_action_guard
{
    public:
        explicit character_action_guard( Character &who, bool allow_dead = false );
        Character *get() const;
        explicit operator bool() const {
            return get() != nullptr;
        }

    private:
        safe_reference<Creature> memory;
        shared_ptr_fast<Character> retained;
        character_id identity;
        bool allow_dead;
        npc_lifetime npc_reference;
        const npc_lifetime_registry *npc_owner = nullptr;
};

#endif // CATA_SRC_CHARACTER_ACTION_GUARD_H
