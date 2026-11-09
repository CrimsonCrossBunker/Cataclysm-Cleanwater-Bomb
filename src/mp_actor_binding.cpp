#include "mp_actor_binding.h"

#include <stdexcept>
#include <string>
#include <utility>

#include "character_id.h"
#include "creature.h"
#include "math_parser_diag_value.h"
#include "mp_player_identity.h"
#include "npc.h"
#include "npc_lifetime.h"
#include "player_control.h"
#include "safe_reference.h"

namespace cata_mp
{
bool is_player_proxy( const npc &actor )
{
    const auto *tag = actor.maybe_get_value( "mp_proxy" );
    return tag && tag->is_str() && tag->str() == "1";
}

static bool has_binding_role( const npc &actor, const player_id &player )
{
    const auto *replica = actor.maybe_get_value( "mp_npc_replica" );
    return is_player_proxy( actor ) ||
           ( !player.valid() && replica && replica->is_str() && replica->str() == "1" );
}

void actor_binding::bind( npc &actor, const player_id &player, npc_lifetime_registry &world )
{
    if( !actor.getID().is_valid() || actor.is_dead_state() ||
        !has_binding_role( actor, player ) ||
        ( player.valid() && actor.get_value( "mp_player_id" ).str() != player.str() ) ) {
        throw std::runtime_error( "Invalid multiplayer actor ownership" );
    }
    id_ = actor.getID();
    player_ = player;
    instance_ = actor.get_safe_reference();
    active_ = world.acquire( actor );
}

void actor_binding::bind_player( npc &actor, const player_id &player, npc_lifetime_registry &world,
                                 player_control control )
{
    if( !player.valid() || !( control.player() == player ) || control.get() != &actor ) {
        throw std::runtime_error( "Missing multiplayer player control assignment" );
    }
    bind( actor, player, world );
    control_ = std::move( control );
}

void actor_binding::bind_view( npc &actor, npc_lifetime_registry &world )
{
    bind( actor, player_id(), world );
    control_.reset();
}

void actor_binding::reset()
{
    control_.reset();
    id_ = character_id();
    player_ = player_id();
    instance_ = {};
    active_ = {};
}

bool actor_binding::owns_instance( const npc *actor, const npc_lifetime_registry &world ) const
{
    return actor && active_.belongs_to( world ) && instance_.get() == actor &&
           id_.is_valid() && actor->getID() == id_ && has_binding_role( *actor, player_ ) &&
           ( !player_.valid() || ( actor->get_value( "mp_player_id" ).str() == player_.str() &&
                                   control_.get() == actor ) );
}

npc *actor_binding::resolve_loaded( npc *candidate, const npc_lifetime_registry &world )
{
    if( !owns_instance( candidate, world ) || candidate->is_dead_state() ) {
        return nullptr;
    }
    if( active_.resolve( world ) != candidate ) {
        // Observation only: an unload or replacement must not be undone by
        // a getter. A legitimate on_load supplies the new active incarnation.
        const npc_lifetime loaded = world.active_reference( *candidate );
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
