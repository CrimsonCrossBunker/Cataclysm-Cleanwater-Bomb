#pragma once
#ifndef CATA_SRC_MP_ACTOR_BINDING_H
#define CATA_SRC_MP_ACTOR_BINDING_H

#include "character_id.h"
#include "mp_player_identity.h"
#include "npc_lifetime.h"
#include "safe_reference.h"

class Creature;
class npc;

namespace cata_mp
{
// A world-local control/view role retains the exact native object identity
// across temporary unload. The active incarnation is refreshed only after
// native on_load has registered that same object again. Reused IDs, copied
// player tags and another world's registry cannot grant this role.
class actor_binding
{
    public:
        actor_binding() = default;
        actor_binding( const actor_binding & ) = delete;
        actor_binding &operator=( const actor_binding & ) = delete;
        void bind_player( npc &actor, const player_id &player, npc_lifetime_registry &world );
        void bind_view( npc &actor, npc_lifetime_registry &world );
        void reset();
        character_id id() const {
            return id_;
        }
        bool owns_instance( const npc *actor, const npc_lifetime_registry &world ) const;
        // Only the native tracker's currently loaded candidate may be used.
        npc *resolve_loaded( npc *candidate, const npc_lifetime_registry &world );
        // Exact retained object for save/despawn, including temporary unload.
        npc *retained( const npc_lifetime_registry &world ) const;

    private:
        character_id id_;
        player_id player_;
        safe_reference<Creature> instance_;
        npc_lifetime active_;
        void bind( npc &actor, const player_id &player, npc_lifetime_registry &world );
};
} // namespace cata_mp

#endif // CATA_SRC_MP_ACTOR_BINDING_H
