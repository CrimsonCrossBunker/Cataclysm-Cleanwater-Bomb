#pragma once
#ifndef CATA_SRC_NPC_LIFETIME_H
#define CATA_SRC_NPC_LIFETIME_H

#include <cstddef>
#include <memory>

#include "character_id.h"

class npc;
class npc_lifetime_registry;
struct npc_lifetime_state;

// A simulation-thread reference to one active NPC incarnation. Persistent
// character IDs survive unload/reload; these references deliberately do not.
// Neither a reference nor a registry keeps the native NPC alive.
class npc_lifetime
{
    public:
        npc_lifetime() = default;
        npc *resolve( const npc_lifetime_registry &owner ) const;
        bool belongs_to( const npc_lifetime_registry &owner ) const;
        std::size_t generation() const {
            return generation_;
        }

    private:
        friend class npc_lifetime_registry;
        std::shared_ptr<npc_lifetime_state> state_;
        character_id id_;
        std::size_t generation_ = 0;
};

// One registry per native world, independent of Lua or networking. The owner
// thread registers load/replacement and retires unload/death. reset() also
// invalidates references whose native objects are still retained elsewhere.
class npc_lifetime_registry
{
    public:
        npc_lifetime_registry();
        ~npc_lifetime_registry();
        npc_lifetime_registry( const npc_lifetime_registry & ) = delete;
        npc_lifetime_registry &operator=( const npc_lifetime_registry & ) = delete;

        npc_lifetime acquire( npc &value );
        // Observe an already registered active incarnation without activating
        // an unloaded object or replacing the owner of a reused numeric ID.
        npc_lifetime active_reference( npc &value ) const;
        void activate( npc &value );
        void retire( npc &value );
        void reset();

    private:
        friend class npc_lifetime;
        struct impl;
        std::unique_ptr<impl> impl_;
};

// Owner-thread adapters for existing native lifecycle and Platform callers.
// No fallback registry is manufactured without an owning game.
npc_lifetime_registry *current_npc_lifetimes();
void activate_npc_lifetime( npc &value );
void retire_npc_lifetime( npc &value );

#endif // CATA_SRC_NPC_LIFETIME_H
