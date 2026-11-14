#include "vehicle_harness.h"

#include <string>
#include <utility>

#include "action.h"
#include "calendar.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "character_action_guard.h"
#include "creature_tracker.h"
#include "game.h"
#include "item.h"
#include "json.h"
#include "line.h"
#include "map.h"
#include "messages.h"
#include "monster.h"
#include "mtype.h"
#include "rng.h"
#include "translations.h"
#include "vehicle.h"
#include "vehicle_control.h"
#include "vpart_range.h"

namespace
{
vehicle_part *find_harness( vehicle &target, const tripoint_abs_ms &position, int64_t identity )
{
    for( const vpart_reference &part : target.get_avail_parts( "ANIMAL_CTRL" ) ) {
        if( target.abs_part_pos( part.part() ) == position &&
            ( identity == 0 || part.part().get_base().uid().get_value() == identity ) ) {
            return &part.part();
        }
    }
    return nullptr;
}
} // namespace

void vehicle_harness_selection::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "part", part );
    out.member( "animal", animal );
    out.member( "animal_position", animal_position );
    out.end_object();
}

void vehicle_harness_selection::deserialize( const JsonObject &data )
{
    data.read( "part", part, true );
    data.read( "animal", animal, true );
    data.read( "animal_position", animal_position, true );
}

bool valid_vehicle_harness( Character &who, map &here, vehicle &target,
                            const tripoint_abs_ms &position, const vehicle_harness_selection &choice )
{
    if( who.is_dead_state() || who.has_effect( efftype_id( "incorporeal" ) ) ||
        choice.part <= 0 || choice.animal <= 0 ||
        !here.inbounds( position ) || !here.inbounds( choice.animal_position ) ||
        who.pos_abs().z() != position.z() || who.pos_abs().z() != choice.animal_position.z() ||
        rl_dist( who.pos_abs(), position ) > 1 ||
        rl_dist( who.pos_abs(), choice.animal_position ) > 1 ||
        !g->is_empty( &here, position ) ) {
        return false;
    }
    const vehicle_part *part = find_harness( target, position, choice.part );
    const auto animal = get_creature_tracker().find_by_uid( choice.animal );
    return part && animal && !animal->is_dead_state() &&
           animal->pos_abs() == choice.animal_position && animal->friendly != 0 &&
           !animal->has_effect( efftype_id( "harnessed" ) ) &&
           ( animal->has_flag( mon_flag_PET_MOUNTABLE ) || animal->has_flag( mon_flag_PET_HARNESSABLE ) ) &&
           ( part->info().has_flag( "HARNESS_any" ) ||
             part->info().has_flag( "HARNESS_" + animal->type->bodytype ) );
}

bool execute_vehicle_harness( Character &who, map &here, vehicle &target,
                              const tripoint_abs_ms &position, const vehicle_harness_selection &choice )
{
    if( !valid_vehicle_harness( who, here, target, position, choice ) ) {
        return false;
    }
    const character_action_guard lifetime( who );
    const auto animal = get_creature_tracker().find_by_uid( choice.animal );
    const int64_t vehicle_id = target.uid().get_value();
    const std::string vehicle_name = target.disp_name();
    const std::string animal_name = animal->get_name();
    animal->add_effect( efftype_id( "harnessed" ), 1_turns, true );
    vehicle *live = vehicle::find_vehicle_by_uid( here, vehicle_id );
    if( !lifetime || animal->is_dead_state() ||
        get_creature_tracker().find_by_uid( choice.animal ) != animal ||
        !live || !find_harness( *live, position, choice.part ) ||
        animal->pos_abs() != choice.animal_position || !g->is_empty( &here, position ) ) {
        animal->remove_effect( efftype_id( "harnessed" ) );
        return false;
    }
    animal->setpos( position );
    if( lifetime ) {
        who.add_msg_if_player( m_info, _( "You harness your %1$s to %2$s." ),
                               animal_name, vehicle_name );
    }
    if( animal->has_effect( efftype_id( "tied" ) ) ) {
        auto rope = std::move( animal->tied_item );
        animal->remove_effect( efftype_id( "tied" ) );
        if( lifetime ) {
            who.add_msg_if_player( m_info, _( "You untie your %s." ), animal_name );
            if( rope ) {
                who.i_add( *rope );
            }
        } else if( rope ) {
            here.add_item_or_charges( here.get_bub( position ), std::move( *rope ) );
        }
    }
    return true;
}

std::optional<vehicle_control_selection> query_vehicle_harness( Character &who, map &here,
        vehicle &target, const tripoint_abs_ms &position, int64_t part )
{
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    const character_action_guard lifetime( who );
    const int64_t vehicle_id = target.uid().get_value();
    auto command = query_vehicle_control( who, here, target, position, "harness" );
    vehicle *live = vehicle::find_vehicle_by_uid( here, vehicle_id );
    if( !lifetime || !live ) {
        return std::nullopt;
    }
    vehicle_part *harness = find_harness( *live, position, part );
    if( !command || !harness ) {
        return std::nullopt;
    }
    if( !g->is_empty( &here, position ) ) {
        who.add_msg_if_player( m_info, _( "The harness is blocked." ) );
        return std::nullopt;
    }
    const int64_t identity = harness->get_base().uid().get_value();
    const auto selected = choose_adjacent( who.pos_bub(), _( "Where is the creature to harness?" ) );
    live = vehicle::find_vehicle_by_uid( here, vehicle_id );
    if( !selected || !lifetime || !live ) {
        return std::nullopt;
    }
    const auto animal = get_creature_tracker().find( here.get_abs( *selected ) );
    if( !animal ) {
        who.add_msg_if_player( m_info, _( "No creature there." ) );
        return std::nullopt;
    }
    vehicle_harness_selection choice{ identity, animal->uid().get_value(), animal->pos_abs() };
    if( !valid_vehicle_harness( who, here, *live, position, choice ) ) {
        who.add_msg_if_player( m_info, _( "This creature cannot be harnessed here." ) );
        return std::nullopt;
    }
    command->harness = choice;
    return command;
}
