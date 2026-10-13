#include "monster_movement_plan.h"

#include <algorithm>

#include "cached_options.h"
#include "creature.h"
#include "creature_tracker.h"
#include "effect.h"
#include "game.h"
#include "line.h"
#include "map.h"
#include "monster.h"
#include "vehicle.h"
#include "vpart_position.h"

static const efftype_id effect_pacified( "pacified" );

namespace
{
std::optional<tripoint_abs_ms> current_goal( const monster &source )
{
    return source.has_dest() ? std::optional<tripoint_abs_ms>( source.get_dest() ) : std::nullopt;
}
} // namespace

float monster_stagger_adjustment( const tripoint_bub_ms &source, const tripoint_bub_ms &goal,
                                  const tripoint_bub_ms &step, bool use_trig_distance )
{
    const float initial = use_trig_distance ? trig_dist( source, goal ) : square_dist( source.raw(),
                          goal.raw() );
    const float next = use_trig_distance ? trig_dist( step, goal ) : square_dist( step.raw(),
                       goal.raw() );
    return std::max( 0.01f, initial - next );
}

monster_movement_plan::monster_movement_plan( monster &source, map &here,
        monster_movement_proposal proposal ) :
    source_( source.get_safe_reference() ), map_( here.get_context_reference() ),
    proposal_( proposal ), source_position_( source.pos_abs() ), origin_( here.get_abs_sub() ),
    previous_goal_( current_goal( source ) ), terrain_( here.ter( here.get_bub( proposal.step ) ) ),
    furniture_( here.furn( here.get_bub( proposal.step ) ) ), source_type_( source.type ),
    turn_( calendar::turn ), moves_( source.get_moves() ), anger_( source.anger ),
    morale_( source.morale ), friendly_( source.friendly ), hp_( source.get_hp() ),
    hallucination_( source.is_hallucination() ),
    effect_pacified_( source.has_effect( effect_pacified ) )
{
    Creature *occupant = get_creature_tracker().creature_at( proposal.step, hallucination_ );
    if( occupant ) {
        had_occupant_ = true;
        occupant_ = occupant->get_safe_reference();
    }
    if( const optional_vpart_position vp = here.veh_at( here.get_bub( proposal.step ) ) ) {
        had_vehicle_ = true;
        vehicle_ = vp->vehicle().get_safe_reference();
        vehicle_position_ = vp->vehicle().pos_abs();
        vehicle_part_ = vp->part_index();
    }
}

monster_movement_result monster_movement_plan::commit( const monster_movement_proposal &proposal,
        map &here )
{
    if( consumed_ ) {
        return monster_movement_result::stale;
    }
    consumed_ = true;
    if( map_.get() != &here || &here != &get_map() || origin_ != here.get_abs_sub() ||
        turn_ != calendar::turn || proposal.step != proposal_.step || proposal.goal != proposal_.goal ||
        proposal.pacified != proposal_.pacified || proposal.can_open_doors != proposal_.can_open_doors ) {
        return monster_movement_result::stale;
    }
    Creature *observed = source_.get();
    monster *source = observed ? observed->as_monster() : nullptr;
    creature_tracker &tracker = get_creature_tracker();
    // Pin only on the owner. A Lua hook may remove an actor during an action;
    // removed actors cannot continue the fall-through sequence.
    const auto pin = tracker.find( source_position_ );
    if( !source || pin.get() != source || source->is_dead() || !tracker.is_present( source ) ||
        source->pos_abs() != source_position_ || current_goal( *source ) != previous_goal_ ||
        source->type != source_type_ || source->get_moves() != moves_ || source->anger != anger_ ||
        source->morale != morale_ || source->friendly != friendly_ || source->get_hp() != hp_ ||
        source->is_hallucination() != hallucination_ ||
        source->has_effect( effect_pacified ) != effect_pacified_ ) {
        return monster_movement_result::stale;
    }
    const tripoint_bub_ms step = here.get_bub( proposal.step );
    Creature *occupant = tracker.creature_at( proposal.step, hallucination_ );
    if( ( had_occupant_ && ( !occupant_.get() || occupant_.get() != occupant ) ) ||
        ( !had_occupant_ && occupant ) || here.ter( step ) != terrain_ ||
        here.furn( step ) != furniture_ ) {
        return monster_movement_result::stale;
    }
    const optional_vpart_position vp = here.veh_at( step );
    if( had_vehicle_ ) {
        vehicle *observed_vehicle = vehicle_.get();
        if( !observed_vehicle || !vp || &vp->vehicle() != observed_vehicle ||
            vp->part_index() != vehicle_part_ || observed_vehicle->pos_abs() != vehicle_position_ ) {
            return monster_movement_result::stale;
        }
    } else if( vp ) {
        return monster_movement_result::stale;
    }
    const auto still_active = [&]() {
        return map_.get() == &here && origin_ == here.get_abs_sub() &&
               !source->is_dead() && tracker.is_present( source );
    };
    // Keep the old lazy order, including inside/outside and stagger queries.
    // Successful actions stop immediately; failed actions may have effects.
    if( !proposal.pacified ) {
        if( source->attack_at( step ) ) {
            return monster_movement_result::acted;
        }
        if( !still_active() ) {
            return monster_movement_result::cancelled;
        }
        if( proposal.can_open_doors &&
            here.open_door( *source, step, !here.is_outside( source->pos_bub() ) ) ) {
            return monster_movement_result::acted;
        }
        if( !still_active() ) {
            return monster_movement_result::cancelled;
        }
        if( source->bash_at( step ) ) {
            return monster_movement_result::acted;
        }
        if( !still_active() ) {
            return monster_movement_result::cancelled;
        }
        if( source->push_to( step, 0, 0 ) ) {
            return monster_movement_result::acted;
        }
        if( !still_active() ) {
            return monster_movement_result::cancelled;
        }
    }
    const float adjustment = monster_stagger_adjustment( source->pos_bub(), proposal.goal, step,
                             trigdist );
    if( source->move_to( step, false, false, adjustment ) ) {
        return monster_movement_result::acted;
    }
    return still_active() ? monster_movement_result::blocked : monster_movement_result::cancelled;
}
