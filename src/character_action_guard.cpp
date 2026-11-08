#include "character_action_guard.h"

#include "character.h"
#include "creature.h"
#include "game.h"
#include "npc.h"

character_action_guard::character_action_guard( Character &who, bool allow_dead ) :
    memory( who.get_safe_reference() ), identity( who.getID() ), allow_dead( allow_dead )
{
    if( g ) {
        retained = g->shared_from( who );
        if( npc *value = who.as_npc(); value && retained && !value->is_dead() ) {
            npc_owner = &g->npc_lifetimes();
            npc_reference = g->npc_lifetimes().track_active( *value );
        }
    }
}

Character *character_action_guard::get() const
{
    Creature *value = memory.get();
    Character *who = value ? value->as_character() : nullptr;
    if( !who || who->getID() != identity ) {
        return nullptr;
    }
    const npc *npc_value = who->as_npc();
    if( !allow_dead && ( npc_value ? npc_value->is_dead() : who->is_dead_state() ) ) {
        return nullptr;
    }
    if( npc_owner && ( current_npc_lifetimes() != npc_owner ||
                       npc_reference.resolve( *npc_owner ) != who ) ) {
        return nullptr;
    }
    return who;
}
