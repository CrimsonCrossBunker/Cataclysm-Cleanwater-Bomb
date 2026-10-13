#include "monster_destination_plan.h"

#include "creature.h"
#include "creature_tracker.h"
#include "map.h"
#include "monster.h"
#include "point.h"

namespace
{
int flee_level( const monster &source, const map &here )
{
    const int z = source.posz();
    if( !source.flies() ) {
        return z;
    }
    const tripoint_bub_ms local = source.pos_bub( here );
    const bool grounded = here.has_floor_or_water( local );
    if( !grounded && here.valid_move( local, local + tripoint::below, false, true ) ) {
        return z - 1;
    } else if( grounded && here.valid_move( local, local + tripoint::above, false, true ) ) {
        return z + 1;
    }
    return z;
}

std::optional<tripoint_abs_ms> current_goal( const monster &source )
{
    return source.has_dest() ? std::optional<tripoint_abs_ms>( source.get_dest() ) : std::nullopt;
}
} // namespace

std::optional<tripoint_abs_ms> propose_monster_destination( const monster_destination_view &view )
{
    if( view.hostile && !view.fleeing ) {
        return view.target;
    }
    if( view.fleeing ) {
        tripoint_abs_ms away = view.source - view.target + view.source;
        away.z() = view.flee_z;
        return away;
    }
    return std::nullopt;
}

monster_destination_plan::monster_destination_plan( monster &source, Creature &target,
        map &here, bool hostile, bool fleeing ) :
    source_( source.get_safe_reference() ), target_( target.get_safe_reference() ),
    map_( here.get_context_reference() ),
    view_{ source.pos_abs(), target.pos_abs(), hostile, fleeing,
           fleeing ? flee_level( source, here ) : source.posz() },
    origin_( here.get_abs_sub() ), previous_goal_( current_goal( source ) ),
    source_type_( source.type ), moves_( source.get_moves() ), anger_( source.anger ),
    morale_( source.morale ), friendly_( source.friendly ), hp_( source.get_hp() ),
    flies_( source.flies() ), turn_( calendar::turn )
{}

bool monster_destination_plan::commit( const std::optional<tripoint_abs_ms> &proposal, map &here )
{
    if( consumed_ ) {
        return false;
    }
    consumed_ = true;
    // All dereferences and tracker checks occur on the owner, after validating
    // lifetimes. Removed-this-turn objects may still be alive but not present.
    if( map_.get() != &here || origin_ != here.get_abs_sub() || turn_ != calendar::turn ) {
        return false;
    }
    Creature *source_creature = source_.get();
    Creature *target = target_.get();
    if( !source_creature || !target ) {
        return false;
    }
    monster *source = source_creature->as_monster();
    creature_tracker &tracker = get_creature_tracker();
    if( !source || source->is_dead() || target->is_dead_state() ||
        !tracker.is_present( source ) || !tracker.is_present( target ) ||
        source->pos_abs() != view_.source || target->pos_abs() != view_.target ||
        current_goal( *source ) != previous_goal_ || source->type != source_type_ ||
        source->get_moves() != moves_ || source->anger != anger_ || source->morale != morale_ ||
        source->friendly != friendly_ || source->get_hp() != hp_ ||
        source->flies() != flies_ ) {
        return false;
    }
    if( view_.fleeing && flee_level( *source, here ) != view_.flee_z ) {
        return false;
    }
    if( proposal != propose_monster_destination( view_ ) ) {
        return false;
    }
    if( proposal ) {
        source->set_dest( *proposal );
    }
    return true;
}
