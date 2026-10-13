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
    if( view.force_goal || ( view.hostile && !view.fleeing ) ) {
        return view.target;
    }
    if( view.fleeing ) {
        tripoint_abs_ms away = view.source - view.target + view.source;
        away.z() = view.flee_z;
        return away;
    }
    return std::nullopt;
}

monster_destination_plan::monster_destination_plan( monster &source, map &here ) :
    source_( source.get_safe_reference() ), map_( here.get_context_reference() ),
    view_{ source.pos_abs(), source.pos_abs(), false, false, source.posz() },
    origin_( here.get_abs_sub() ), previous_goal_( current_goal( source ) ),
    source_type_( source.type ), moves_( source.get_moves() ), anger_( source.anger ),
    morale_( source.morale ), friendly_( source.friendly ), hp_( source.get_hp() ),
    flies_( source.flies() ), turn_( calendar::turn )
{}

monster_destination_plan::monster_destination_plan( monster &source, Creature &target,
        map &here, bool hostile, bool fleeing ) : monster_destination_plan( source, here )
{
    target_ = target.get_safe_reference();
    has_target_ = true;
    view_.target = target.pos_abs();
    view_.hostile = hostile;
    view_.fleeing = fleeing;
    view_.flee_z = fleeing ? flee_level( source, here ) : source.posz();
}

monster_destination_plan::monster_destination_plan( monster &source, Creature &target,
        map &here ) : monster_destination_plan( source, target, here, false, false )
{
    view_.force_goal = true;
}

monster_destination_plan::monster_destination_plan( monster &source, map &here,
        const tripoint_abs_ms &destination, monster_point_goal kind ) :
    monster_destination_plan( source, here )
{
    view_.target = destination;
    view_.force_goal = true;
    point_kind_ = kind;
    if( kind == monster_point_goal::furniture ) {
        const tripoint_bub_ms point = here.get_bub( destination );
        tile_ = std::make_pair( here.ter( point ), here.furn( point ) );
    } else if( kind == monster_point_goal::patrol ) {
        const monster_patrol_view patrol = source.patrol_view();
        patrol_index_ = patrol.current;
        patrol_count_ = patrol.count;
    }
}

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
    if( !source_creature || ( has_target_ && !target ) ) {
        return false;
    }
    monster *source = source_creature->as_monster();
    creature_tracker &tracker = get_creature_tracker();
    if( !source || source->is_dead() || !tracker.is_present( source ) ||
        source->pos_abs() != view_.source ||
        current_goal( *source ) != previous_goal_ || source->type != source_type_ ||
        source->get_moves() != moves_ || source->anger != anger_ || source->morale != morale_ ||
        source->friendly != friendly_ || source->get_hp() != hp_ ||
        source->flies() != flies_ ) {
        return false;
    }
    if( has_target_ && ( target->is_dead_state() || !tracker.is_present( target ) ||
                         target->pos_abs() != view_.target ) ) {
        return false;
    }
    if( tile_ ) {
        const tripoint_bub_ms point = here.get_bub( view_.target );
        if( !here.inbounds( point ) || here.ter( point ) != tile_->first ||
            here.furn( point ) != tile_->second ) {
            return false;
        }
    }
    if( point_kind_ == monster_point_goal::patrol ) {
        const monster_patrol_view patrol = source->patrol_view();
        if( patrol.current != patrol_index_ || patrol.count != patrol_count_ ||
            !patrol.goal || *patrol.goal != view_.target ) {
            return false;
        }
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
