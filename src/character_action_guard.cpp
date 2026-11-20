#include "character_action_guard.h"

#include "character.h"
#include "creature.h"
#include "game.h"
#include "npc.h"

namespace
{
bool is_dead( const Character &who )
{
    const npc *npc_value = who.as_npc();
    return npc_value ? npc_value->is_dead() : who.is_dead_state();
}
} // namespace

character_action_guard::character_action_guard( Character &who, bool allow_dead ) :
    memory( who.get_safe_reference() ), identity( who.getID() ), allow_dead( allow_dead )
{
    if( g ) {
        retained = g->shared_from( who );
        if( npc *value = who.as_npc(); value && retained && ( allow_dead || !value->is_dead() ) ) {
            npc_lifetime_registry &registry = g->npc_lifetimes();
            npc_owner = &registry;
            npc_reference = registry.track_active( *value, allow_dead );
        }
    }
}

Character *character_action_guard::get() const
{
    return get( allow_dead );
}

Character *character_action_guard::get( bool allow_dead ) const
{
    Creature *value = memory.get();
    Character *who = value ? value->as_character() : nullptr;
    if( !who || who->getID() != identity ) {
        return nullptr;
    }
    if( npc_owner ) {
        return current_npc_lifetimes() == npc_owner &&
               npc_reference.resolve( *npc_owner, allow_dead ) == who ? who : nullptr;
    }
    return allow_dead || !is_dead( *who ) ? who : nullptr;
}

damage_event_participants::damage_event_participants( Character &target, Creature *source ) :
    target_guard( target, true ), self_inflicted( source == &target ),
    allow_dead_target( is_dead( target ) )
{
    if( !source || self_inflicted ) {
        return;
    }
    if( Character *who = source->as_character() ) {
        source_guard.emplace( *who, is_dead( *who ) );
    } else {
        other_source = source->get_safe_reference();
        if( g ) {
            retained_source = g->shared_from( *source );
        }
    }
}

void damage_event_participants::begin_notification()
{
    const Character *who = target_guard.get();
    allow_dead_target = who && is_dead( *who );
}

bool damage_event_participants::same_target() const
{
    return target_guard.get( true ) != nullptr;
}

Character *damage_event_participants::target() const
{
    return target_guard.get( allow_dead_target );
}

Creature *damage_event_participants::source() const
{
    if( self_inflicted ) {
        return target();
    }
    if( source_guard ) {
        return source_guard->get();
    }
    Creature *source = other_source.get();
    return source && ( !retained_source || ( g && g->shared_from( *source ) == retained_source ) ) ?
           source : nullptr;
}
