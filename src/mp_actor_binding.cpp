#include "mp_actor_binding.h"

#include <stdexcept>

#include "creature.h"
#include "npc.h"

namespace cata_mp
{
void actor_binding::bind( npc &actor, const player_id &player, npc_lifetime_registry &world )
{
    if( !actor.getID().is_valid() || actor.is_dead_state() ||
        actor.get_value( "mp_proxy" ).str() != "1" ||
        ( player.valid() && actor.get_value( "mp_player_id" ).str() != player.str() ) ) {
        throw std::runtime_error( "Invalid multiplayer actor ownership" );
    }
    id_ = actor.getID();
    player_ = player;
    instance_ = actor.get_safe_reference();
    active_ = world.acquire( actor );
}

void actor_binding::bind_player( npc &actor, const player_id &player, npc_lifetime_registry &world )
{
    if( !player.valid() ) {
        throw std::runtime_error( "Missing multiplayer player identity" );
    }
    bind( actor, player, world );
}

void actor_binding::bind_view( npc &actor, npc_lifetime_registry &world )
{
    bind( actor, player_id(), world );
}

void actor_binding::reset()
{
    id_ = character_id();
    player_ = player_id();
    instance_ = {};
    active_ = {};
}

bool actor_binding::owns_instance( const npc *actor, const npc_lifetime_registry &world ) const
{
    return actor && active_.belongs_to( world ) && instance_.get() == actor &&
           id_.is_valid() && actor->getID() == id_ && actor->get_value( "mp_proxy" ).str() == "1" &&
           ( !player_.valid() || actor->get_value( "mp_player_id" ).str() == player_.str() );
}

npc *actor_binding::resolve_loaded( npc *candidate, const npc_lifetime_registry &world )
{
    if( !owns_instance( candidate, world ) || candidate->is_dead_state() ) {
        return nullptr;
    }
    if( active_.resolve( world ) != candidate ) {
        // Observation only: an unload or replacement must not be undone by
        // a getter. A legitimate on_load supplies the new active incarnation.
        const auto loaded = world.active_reference( *candidate );
        if( loaded.resolve( world ) != candidate ) {
            return nullptr;
        }
        active_ = loaded;
    }
    return candidate;
}

npc *actor_binding::retained( const npc_lifetime_registry &world ) const
{
    Creature *creature = instance_.get();
    npc *actor = creature ? creature->as_npc() : nullptr;
    return owns_instance( actor, world ) ? actor : nullptr;
}
} // namespace cata_mp
