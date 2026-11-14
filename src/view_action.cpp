#include "view_action.h"

#include "character.h"
#include "creature.h"
#include "creature_tracker.h"
#include "map.h"

view_action select_view_action( view_action::kind action, Character &who, map &here,
                                const tripoint_bub_ms &target, Creature *subject )
{
    view_action selected;
    selected.action = action;
    selected.origin = who.pos_abs();
    selected.target = here.get_abs( target );
    selected.context = here.get_context_reference();
    selected.observation = here.observer_viewpoint( who );
    if( subject ) {
        selected.subject = subject->get_safe_reference();
    }
    return selected;
}

bool view_action::visible_to( Character &who, map &here ) const
{
    if( !context || context.get() != &here || who.is_dead_state() ||
        who.pos_abs() != origin || !here.inbounds( target ) ) {
        return false;
    }
    const bool targets_creature = action == kind::fire || action == kind::rename;
    if( targets_creature && ( !subject || subject->is_dead_state() ||
                              subject->pos_abs() != target ||
                              get_creature_tracker().creature_at( here.get_bub( target ), true ) != subject.get() ) ) {
        return false;
    }
    const auto visible = [&]() {
        return targets_creature ? who.sees( here, *subject ) :
               who.sees( here, here.get_bub( target ) );
    };
    if( observation ) {
        if( observation->observer != who.getID() || observation->origin != origin ||
            !here.inbounds( observation->position ) ) {
            return false;
        }
        const scoped_map_viewpoint view( here, who, observation->position,
                                         observation->standing, observation->z_range );
        here.build_map_cache( observation->position.z() );
        if( who.is_avatar() ) {
            here.update_visibility_cache( observation->position.z() );
        }
        return visible();
    }
    return visible();
}
