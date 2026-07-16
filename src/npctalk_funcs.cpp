#include "npctalk.h" // IWYU pragma: associated

#include <algorithm>
#include <cmath>
#include <cstddef>
#include <cstdint>
#include <limits>
#include <list>
#include <map>
#include <memory>
#include <optional>
#include <ostream>
#include <set>
#include <string>
#include <utility>
#include <vector>

#include "activity_actor_definitions.h"
#include "activity_handlers.h"
#include "auto_pickup.h"
#include "avatar.h"
#include "basecamp.h"
#include "bionics.h"
#include "bodypart.h"
#include "calendar.h"
#include "cata_utility.h"
#include "character.h"
#include "character_id.h"
#include "character_martial_arts.h"
#include "clzones.h"
#include "coordinates.h"
#include "creature.h"
#include "debug.h"
#include "dialogue_chatbin.h"
#include "enums.h"
#include "event.h"
#include "event_bus.h"
#include "faction.h"
#include "fault.h"
#include "flexbuffer_json.h"
#include "game.h"
#include "game_constants.h"
#include "game_inventory.h"
#include "item.h"
#include "item_location.h"
#include "itype.h"
#include "json.h"
#include "magic.h"
#include "map.h"
#include "martialarts.h"
#include "math_parser_diag_value.h"
#include "messages.h"
#include "mission.h"
#include "monster.h"
#include "mutation.h"
#include "npc.h"
#include "npc_opinion.h"
#include "npctrade.h"
#include "output.h"
#include "overmap.h"
#include "overmap_ui.h"
#include "overmapbuffer.h"
#include "pimpl.h"
#include "point.h"
#include "proficiency.h"
#include "rng.h"
#include "simple_pathfinding.h"
#include "skill.h"
#include "translation.h"
#include "translations.h"
#include "uilist.h"
#include "units.h"
#include "value_ptr.h"
#include "veh_interact.h"
#include "veh_type.h"
#include "vehicle.h"
#include "viewer.h"
#include "vpart_position.h"
#include "vpart_range.h"

static const efftype_id effect_allow_sleep( "allow_sleep" );
static const efftype_id effect_asked_for_item( "asked_for_item" );
static const efftype_id effect_asked_personal_info( "asked_personal_info" );
static const efftype_id effect_asked_to_follow( "asked_to_follow" );
static const efftype_id effect_asked_to_lead( "asked_to_lead" );
static const efftype_id effect_asked_to_train( "asked_to_train" );
static const efftype_id effect_bite( "bite" );
static const efftype_id effect_bleed( "bleed" );
static const efftype_id effect_currently_busy( "currently_busy" );
static const efftype_id effect_infected( "infected" );
static const efftype_id effect_lying_down( "lying_down" );
static const efftype_id effect_npc_suspend( "npc_suspend" );
static const efftype_id effect_pet( "pet" );
static const efftype_id effect_sleep( "sleep" );

static const faction_id faction_no_faction( "no_faction" );
static const faction_id faction_your_followers( "your_followers" );

static const json_character_flag json_flag_BIONIC_LIMB( "BIONIC_LIMB" );
static const json_character_flag json_flag_PARTIAL_BIONIC_LIMB( "PARTIAL_BIONIC_LIMB" );

static const mission_type_id mission_MISSION_REACH_SAFETY( "MISSION_REACH_SAFETY" );

static const morale_type morale_haircut( "morale_haircut" );
static const morale_type morale_shave( "morale_shave" );

static const mtype_id mon_chicken( "mon_chicken" );
static const mtype_id mon_cow( "mon_cow" );
static const mtype_id mon_horse( "mon_horse" );

static const zone_type_id zone_type_CAMP_FOOD( "CAMP_FOOD" );
static const zone_type_id zone_type_CAMP_STORAGE( "CAMP_STORAGE" );

static const std::string vehicle_part_repair_target = "vehicle_part_repair_target";
static const std::string vehicle_part_repair_valid = "vehicle_part_repair_selection_valid";
static const std::string vehicle_part_repair_part_name = "vehicle_part_repair_part_name";
static const std::string vehicle_part_repair_vehicle_name = "vehicle_part_repair_vehicle_name";
static const std::string vehicle_part_repair_damage_percent = "vehicle_part_repair_damage_percent";
static const std::string vehicle_part_repair_cost = "vehicle_part_repair_cost";
static const std::string vehicle_part_repair_cost_text = "vehicle_part_repair_cost_text";
static const std::string vehicle_part_repair_time = "vehicle_part_repair_time";
static const std::string vehicle_part_repair_time_text = "vehicle_part_repair_time_text";
static const std::string vehicle_part_repair_price_multiplier =
    "vehicle_part_repair_price_multiplier";
static const std::string vehicle_part_repair_status = "vehicle_part_repair_status";
static const std::string vehicle_part_repair_part_index = "vehicle_part_repair_part_index";
static const std::string vehicle_part_repair_part_id = "vehicle_part_repair_part_id";
static const std::string vehicle_part_repair_mount_x = "vehicle_part_repair_mount_x";
static const std::string vehicle_part_repair_mount_y = "vehicle_part_repair_mount_y";
static const std::string vehicle_part_repair_damage = "vehicle_part_repair_damage";
static const std::string vehicle_part_repair_degradation = "vehicle_part_repair_degradation";
static const std::string vehicle_part_repair_faults = "vehicle_part_repair_faults";

static void spawn_animal( npc &p, const mtype_id &mon );

static vehicle *marked_vehicle_part_repair_target( map &here )
{
    avatar &player_character = get_avatar();
    for( wrapped_vehicle &wrapped : here.get_vehicles() ) {
        vehicle &veh = *wrapped.v;
        const diag_value *marker = veh.maybe_get_value( vehicle_part_repair_target );
        if( marker && marker->is_str() && marker->str() == "yes" &&
            veh.is_owned_by( player_character ) &&
            !veh.player_in_control( here, player_character ) ) {
            return &veh;
        }
    }
    return nullptr;
}

static void clear_vehicle_part_repair_quote( npc &p )
{
    p.set_value( vehicle_part_repair_valid, 0 );
    p.set_value( vehicle_part_repair_part_name, "" );
    p.set_value( vehicle_part_repair_vehicle_name, "" );
    p.set_value( vehicle_part_repair_damage_percent, 0 );
    p.set_value( vehicle_part_repair_cost, 0 );
    p.set_value( vehicle_part_repair_cost_text, format_money( 0 ) );
    p.set_value( vehicle_part_repair_time, 0 );
    p.set_value( vehicle_part_repair_time_text, "" );
    p.set_value( vehicle_part_repair_status, "cancelled" );
}

static void clear_vehicle_part_repair_snapshot( vehicle &veh )
{
    veh.remove_value( vehicle_part_repair_part_index );
    veh.remove_value( vehicle_part_repair_part_id );
    veh.remove_value( vehicle_part_repair_mount_x );
    veh.remove_value( vehicle_part_repair_mount_y );
    veh.remove_value( vehicle_part_repair_damage );
    veh.remove_value( vehicle_part_repair_degradation );
    veh.remove_value( vehicle_part_repair_faults );
}

static bool vehicle_part_repair_is_selectable( const vehicle_part &part )
{
    return !part.removed && !part.is_fake && part.max_damage() > 0 && part.damage() > 0;
}

static std::string vehicle_part_repair_fault_snapshot( const vehicle_part &part )
{
    std::string result;
    for( const fault_id &fault : part.faults() ) {
        if( !result.empty() ) {
            result += '\n';
        }
        result += fault.str();
    }
    return result;
}

void talk_function::nothing( npc & )
{
}

void talk_function::assign_mission( npc &p )
{
    mission *miss = p.chatbin.mission_selected;
    if( miss == nullptr ) {
        debugmsg( "assign_mission: mission_selected == nullptr" );
        return;
    } else if( miss->is_assigned() ) {
        DebugLog( D_WARNING, D_MAIN ) << "assign_mission: mission_id: " << miss->mission_id().str() <<
                                      " is already assigned!";
        return;
    }
    miss->assign( get_avatar() );
    p.chatbin.missions_assigned.push_back( miss );
    const auto it = std::find( p.chatbin.missions.begin(), p.chatbin.missions.end(), miss );
    p.chatbin.missions.erase( it );
}

void talk_function::mission_success( npc &p )
{
    mission *miss = p.chatbin.mission_selected;
    if( miss == nullptr ) {
        debugmsg( "mission_success: mission_selected == nullptr" );
        return;
    }

    int miss_val = npc_trading::cash_to_favor( p, miss->get_value() );
    npc_opinion op;
    op.value = 1 + miss_val / 5;
    op.anger = -1;
    p.op_of_u += op;
    faction *p_fac = p.get_faction();
    if( p_fac != nullptr ) {
        int fac_val = std::min( 1 + miss_val / 10, 10 );
        p_fac->likes_u += fac_val;
        p_fac->respects_u += fac_val;
        p_fac->trusts_u += fac_val;
        p_fac->power += fac_val;
    }
    miss->wrap_up();
}

void talk_function::mission_failure( npc &p )
{
    mission *miss = p.chatbin.mission_selected;
    if( miss == nullptr ) {
        debugmsg( "mission_failure: mission_selected == nullptr" );
        return;
    }
    npc_opinion op;
    op.trust = -1;
    op.value = -1;
    op.anger = 1;
    p.op_of_u += op;
    miss->fail();
}

void talk_function::clear_mission( npc &p )
{
    mission *miss = p.chatbin.mission_selected;
    if( miss == nullptr ) {
        debugmsg( "clear_mission: mission_selected == nullptr" );
        return;
    }
    const auto it = std::find( p.chatbin.missions_assigned.begin(), p.chatbin.missions_assigned.end(),
                               miss );
    if( it == p.chatbin.missions_assigned.end() ) {
        debugmsg( "clear_mission: mission_selected not in assigned" );
        return;
    }
    p.chatbin.missions_assigned.erase( it );
    if( p.chatbin.missions_assigned.empty() ) {
        p.chatbin.mission_selected = nullptr;
    } else {
        p.chatbin.mission_selected = p.chatbin.missions_assigned.front();
    }
    if( miss->has_follow_up() ) {
        p.add_new_mission( mission::reserve_new( miss->get_follow_up(), p.getID() ) );
        if( !p.chatbin.mission_selected ) {
            p.chatbin.mission_selected = p.chatbin.missions.front();
        }
    }
}

void talk_function::mission_reward( npc &p )
{
    const mission *miss = p.chatbin.mission_selected;
    if( miss == nullptr ) {
        debugmsg( "Called mission_reward with null mission" );
        return;
    }

    int mission_value = miss->get_value();
    p.op_of_u.owed += mission_value;
    npc_trading::trade( p, 0, _( "Reward" ) );
}

void talk_function::buy_chicken( npc &p )
{
    spawn_animal( p, mon_chicken );
}
void talk_function::buy_horse( npc &p )
{
    spawn_animal( p, mon_horse );
}

void talk_function::buy_cow( npc &p )
{
    spawn_animal( p, mon_cow );
}

void spawn_animal( npc &p, const mtype_id &mon )
{
    if( monster *const mon_ptr = g->place_critter_around( mon, p.pos_bub(), 1 ) ) {
        mon_ptr->friendly = -1;
        mon_ptr->add_effect( effect_pet, 1_turns, true );
    } else {
        // TODO: handle this gracefully (return the money, proper in-character message from npc)
        add_msg_debug( debugmode::DF_NPC, "No space to spawn purchased pet" );
    }
}

void talk_function::start_trade( npc &p )
{
    npc_trading::trade( p.get_trade_delegate(), 0, _( "Trade" ) );
}

void talk_function::sort_loot( npc &p )
{
    p.assign_activity( zone_sort_activity_actor() );
}

void talk_function::do_construction( npc &p )
{
    p.assign_activity( multi_build_construction_activity_actor() );
}

void talk_function::do_mining( npc &p )
{
    p.assign_activity( multi_mine_activity_actor( false ) );
}

void talk_function::do_mopping( npc &p )
{
    p.assign_activity( multi_mop_activity_actor() );
}

void talk_function::do_read( npc &p )
{
    p.do_npc_read();
}

void talk_function::do_eread( npc &p )
{
    p.do_npc_read( true );
}

void talk_function::do_read_repeatedly( npc &p )
{
    p.assign_activity( multi_read_activity_actor() );
}

void talk_function::do_study( npc &p )
{
    p.assign_activity( multi_study_activity_actor() );
}

void talk_function::dismount( npc &p )
{
    p.npc_dismount();
}

void talk_function::find_mount( npc &p )
{
    // first find one nearby
    for( monster &critter : g->all_monsters() ) {
        if( p.can_mount( critter ) ) {
            // keep the horse still for some time, so that NPC can catch up to it and mount it.
            p.assign_activity( find_mount_activity_actor() );
            p.chosen_mount = g->shared_from( critter );
            // we found one, that's all we need.
            return;
        }
    }
    // if we got here and this was prompted by a renewal of the activity, and there are no valid monsters nearby, then cancel whole thing.
    if( p.has_player_activity() ) {
        p.revert_after_activity();
    }
}

void talk_function::do_butcher( npc &p )
{
    p.assign_activity( multi_butchery_activity_actor() );
}

void talk_function::do_chop_plank( npc &p )
{
    p.assign_activity( multi_chop_planks_activity_actor() );
}

void talk_function::do_vehicle_deconstruct( npc &p )
{
    p.assign_activity( multi_vehicle_deconstruct_activity_actor() );
}

void talk_function::do_vehicle_repair( npc &p )
{
    p.assign_activity( multi_vehicle_repair_activity_actor() );
}

static int vehicle_part_repair_service_cost( const vehicle_part &part,
        const double price_multiplier )
{
    if( !vehicle_part_repair_is_selectable( part ) || price_multiplier <= 0.0 ) {
        return 0;
    }
    const int pristine_value = units::to_cent( part.info().base_item->price_post );
    if( pristine_value <= 0 ) {
        return 0;
    }
    const double damage_ratio = clamp( part.damage_percent(), 0.0, 1.0 );
    const double calculated_cost = std::ceil( pristine_value * damage_ratio * price_multiplier );
    return std::max( 1, static_cast<int>( std::min<double>( calculated_cost,
                                          std::numeric_limits<int>::max() ) ) );
}

static double vehicle_part_repair_multiplier( const npc &mechanic )
{
    const diag_value *value = mechanic.maybe_get_value( vehicle_part_repair_price_multiplier );
    return value && value->is_dbl() && value->dbl() > 0.0 ? value->dbl() : 1.0;
}

static time_duration adjusted_fault_fix_time( const fault_fix &fix, const vehicle_part &part,
        const Character &mechanic )
{
    time_duration result = fix.time;
    for( const std::pair<const flag_id, float> &entry : fix.time_save_flags ) {
        if( part.get_base().has_flag( entry.first ) ) {
            result *= entry.second;
        }
    }
    for( const std::pair<const proficiency_id, float> &entry : fix.time_save_profs ) {
        if( mechanic.has_proficiency( entry.first ) ) {
            result *= entry.second;
        }
    }
    return result;
}

static time_duration vehicle_part_repair_service_time( const vehicle_part &part,
        const Character &mechanic )
{
    const vpart_info &info = part.info();
    if( part.is_broken() ) {
        return std::max( 1_seconds, info.install_time( mechanic ) );
    }

    std::map<fault_fix_id, time_duration> selected_fixes;
    for( const fault_id &fault : part.faults() ) {
        const std::set<fault_fix_id> &fixes = fault->get_fixes();
        if( fixes.empty() ) {
            return std::max( 1_seconds, info.install_time( mechanic ) );
        }

        fault_fix_id fastest_fix = fault_fix_id::NULL_ID();
        time_duration fastest_time = 0_seconds;
        for( const fault_fix_id &fix_id : fixes ) {
            const fault_fix &fix = *fix_id;
            const time_duration candidate = adjusted_fault_fix_time( fix, part, mechanic );
            if( fastest_fix.is_null() || candidate < fastest_time ) {
                fastest_fix = fix_id;
                fastest_time = candidate;
            }
        }
        selected_fixes[fastest_fix] = fastest_time;
    }

    const int damage_levels = part.get_base().damage_level();
    time_duration result = info.repair_time( mechanic ) * damage_levels;
    for( const std::pair<const fault_fix_id, time_duration> &entry : selected_fixes ) {
        result += entry.second;
    }
    return std::max( 1_seconds, result );
}

static void restore_vehicle_part_to_pristine( vehicle &veh, vehicle_part &part )
{
    item restored_base( part.get_base() );
    restored_base.faults.clear();
    restored_base.set_degradation( 0 );
    restored_base.force_set_damage( 0 );
    part.set_base( std::move( restored_base ) );
    veh.refresh();
}

struct vehicle_part_repair_order { // NOLINT(misc-use-internal-linkage)
    vehicle *veh = nullptr;
    int part_index = -1;
};

static std::optional<vehicle_part_repair_order> valid_vehicle_part_repair_order( npc &mechanic )
{
    map &here = get_map();
    vehicle *veh = marked_vehicle_part_repair_target( here );
    const diag_value *cost_value = mechanic.maybe_get_value( vehicle_part_repair_cost );
    const int cost = cost_value && cost_value->is_dbl() ? static_cast<int>( cost_value->dbl() ) : 0;
    if( veh == nullptr || cost <= 0 ) {
        return std::nullopt;
    }

    const diag_value *index_value = veh->maybe_get_value( vehicle_part_repair_part_index );
    if( index_value == nullptr || !index_value->is_dbl() ) {
        return std::nullopt;
    }
    const int part_index = static_cast<int>( index_value->dbl() );
    if( part_index < 0 || part_index >= veh->part_count() ) {
        return std::nullopt;
    }

    const vehicle_part &part = veh->part( part_index );
    const diag_value *part_id = veh->maybe_get_value( vehicle_part_repair_part_id );
    const diag_value *mount_x = veh->maybe_get_value( vehicle_part_repair_mount_x );
    const diag_value *mount_y = veh->maybe_get_value( vehicle_part_repair_mount_y );
    const diag_value *damage = veh->maybe_get_value( vehicle_part_repair_damage );
    const diag_value *degradation = veh->maybe_get_value( vehicle_part_repair_degradation );
    const diag_value *faults = veh->maybe_get_value( vehicle_part_repair_faults );
    const bool valid = part_id && part_id->is_str() && part_id->str() == part.info().id.str() &&
                       mount_x && mount_x->is_dbl() &&
                       static_cast<int>( mount_x->dbl() ) == part.mount.x() &&
                       mount_y && mount_y->is_dbl() &&
                       static_cast<int>( mount_y->dbl() ) == part.mount.y() &&
                       damage && damage->is_dbl() &&
                       static_cast<int>( damage->dbl() ) == part.damage() &&
                       degradation && degradation->is_dbl() &&
                       static_cast<int>( degradation->dbl() ) == part.degradation() &&
                       faults && faults->is_str() &&
                       faults->str() == vehicle_part_repair_fault_snapshot( part ) &&
                       vehicle_part_repair_service_cost( part,
                               vehicle_part_repair_multiplier( mechanic ) ) == cost;
    if( !valid ) {
        return std::nullopt;
    }
    return vehicle_part_repair_order{ veh, part_index };
}

static void refund_vehicle_part_repair( npc &mechanic, const std::string &status )
{
    const diag_value *cost_value = mechanic.maybe_get_value( vehicle_part_repair_cost );
    const int cost = cost_value && cost_value->is_dbl() ? static_cast<int>( cost_value->dbl() ) : 0;
    if( cost > 0 ) {
        mechanic.op_of_u.owed += cost;
    }
    if( vehicle *veh = marked_vehicle_part_repair_target( get_map() ) ) {
        clear_vehicle_part_repair_snapshot( *veh );
    }
    clear_vehicle_part_repair_quote( mechanic );
    mechanic.set_value( vehicle_part_repair_status, status );
    mechanic.remove_effect( effect_currently_busy );
}

void talk_function::select_vehicle_part_repair( npc &p )
{
    map &here = get_map();
    clear_vehicle_part_repair_quote( p );
    vehicle *veh = marked_vehicle_part_repair_target( here );
    if( veh == nullptr ) {
        p.set_value( vehicle_part_repair_status, "no_vehicle" );
        return;
    }
    clear_vehicle_part_repair_snapshot( *veh );

    const std::optional<vpart_reference> selected = veh_interact::select_part_at_grid( here, *veh,
    []( const map &, const vehicle_part & part ) {
        return vehicle_part_repair_is_selectable( part );
    } );
    if( !selected ) {
        const vehicle_part_range all_parts = veh->get_all_parts();
        const bool has_damaged_part = std::any_of( all_parts.begin(), all_parts.end(),
        []( const vpart_reference & vpr ) {
            return vehicle_part_repair_is_selectable( vpr.part() );
        } );
        p.set_value( vehicle_part_repair_status, has_damaged_part ? "cancelled" : "no_damage" );
        return;
    }

    const vehicle_part &part = selected->part();
    const int cost = vehicle_part_repair_service_cost( part, vehicle_part_repair_multiplier( p ) );
    if( cost <= 0 ) {
        p.set_value( vehicle_part_repair_status, "no_value" );
        return;
    }
    const time_duration repair_time = vehicle_part_repair_service_time( part, p );

    veh->set_value( vehicle_part_repair_part_index, selected->part_index() );
    veh->set_value( vehicle_part_repair_part_id, part.info().id.str() );
    veh->set_value( vehicle_part_repair_mount_x, part.mount.x() );
    veh->set_value( vehicle_part_repair_mount_y, part.mount.y() );
    veh->set_value( vehicle_part_repair_damage, part.damage() );
    veh->set_value( vehicle_part_repair_degradation, part.degradation() );
    veh->set_value( vehicle_part_repair_faults, vehicle_part_repair_fault_snapshot( part ) );

    p.set_value( vehicle_part_repair_valid, 1 );
    p.set_value( vehicle_part_repair_part_name, part.name() );
    p.set_value( vehicle_part_repair_vehicle_name, veh->name );
    p.set_value( vehicle_part_repair_damage_percent,
                 static_cast<int>( std::ceil( part.damage_percent() * 100.0 ) ) );
    p.set_value( vehicle_part_repair_cost, cost );
    p.set_value( vehicle_part_repair_cost_text, format_money( cost ) );
    p.set_value( vehicle_part_repair_time, to_turns<int>( repair_time ) );
    p.set_value( vehicle_part_repair_time_text, to_string_approx( repair_time ) );
    p.set_value( vehicle_part_repair_status, "quoted" );
}

void talk_function::start_vehicle_part_repair( npc &p )
{
    const std::optional<vehicle_part_repair_order> order = valid_vehicle_part_repair_order( p );
    const diag_value *time_value = p.maybe_get_value( vehicle_part_repair_time );
    if( !order || time_value == nullptr || !time_value->is_dbl() || time_value->dbl() <= 0 ) {
        refund_vehicle_part_repair( p, "invalidated" );
        add_msg( m_bad,
                 _( "The selected vehicle part changed before repairs could begin.  %s credits you for the payment." ),
                 p.get_name() );
        return;
    }
    const time_duration repair_time = time_duration::from_turns( static_cast<int>
                                      ( time_value->dbl() ) );
    get_player_character().assign_activity( vehicle_part_repair_service_activity_actor(
            repair_time, p.getID() ) );
    p.add_effect( effect_currently_busy, repair_time );
    p.set_value( vehicle_part_repair_status, "repairing" );
    add_msg( m_info, _( "%s begins repairing the selected vehicle part." ), p.get_name() );
}

void talk_function::finish_vehicle_part_repair( npc &p )
{
    const std::optional<vehicle_part_repair_order> order = valid_vehicle_part_repair_order( p );
    if( !order ) {
        refund_vehicle_part_repair( p, "invalidated" );
        add_msg( m_bad,
                 _( "The selected vehicle part changed while repairs were underway.  %s credits you for the payment." ),
                 p.get_name() );
        return;
    }

    vehicle_part &part = order->veh->part( order->part_index );
    const std::string part_name = part.name();
    const std::string vehicle_name = order->veh->name;
    clear_vehicle_part_repair_snapshot( *order->veh );
    restore_vehicle_part_to_pristine( *order->veh, part );
    clear_vehicle_part_repair_quote( p );
    p.set_value( vehicle_part_repair_status, "complete" );
    p.remove_effect( effect_currently_busy );
    add_msg( m_good, _( "%1$s completely repairs the %2$s's %3$s." ), p.get_name(),
             vehicle_name, part_name );
}

void talk_function::cancel_vehicle_part_repair( npc &p )
{
    refund_vehicle_part_repair( p, "cancelled" );
    add_msg( m_info,
             _( "%s stops repairing the selected vehicle part and credits you for the payment." ),
             p.get_name() );
}

void talk_function::do_chop_trees( npc &p )
{
    p.assign_activity( multi_chop_trees_activity_actor() );
}

void talk_function::do_farming( npc &p )
{
    p.assign_activity( multi_farm_activity_actor() );
}

void talk_function::do_fishing( npc &p )
{
    p.assign_activity( multi_fish_activity_actor() );
}

void talk_function::revert_activity( npc &p )
{
    p.revert_after_activity();
}

void talk_function::do_craft( npc &p )
{
    p.do_npc_craft();
}

void talk_function::do_disassembly( npc &p )
{
    p.assign_activity( multi_disassemble_activity_actor() );
}

void talk_function::goto_location( npc &p )
{
    int i = 0;
    uilist selection_menu;
    selection_menu.text = _( "Select a destination" );
    std::vector<basecamp *> camps;
    tripoint_abs_omt destination;
    Character &player_character = get_player_character();
    for( auto elem : player_character.camps ) {
        if( elem == p.pos_abs_omt() ) {
            continue;
        }
        if( overmap_buffer.seen( elem ) == om_vision_level::unseen ) {
            continue;
        }
        std::optional<basecamp *> camp = overmap_buffer.find_camp( elem.xy() );
        if( !camp ) {
            continue;
        }
        basecamp *temp_camp = *camp;
        camps.push_back( temp_camp );
    }
    for( const basecamp *iter : camps ) {
        //~ %1$s: camp name, %2$s: coordinates of the camp
        selection_menu.addentry( i++, true, MENU_AUTOASSIGN, pgettext( "camp", "%1$s at %2$s" ),
                                 iter->camp_name(), iter->camp_omt_pos().to_string() );
    }
    selection_menu.addentry( i++, p.pos_abs_omt() != player_character.pos_abs_omt(),
                             MENU_AUTOASSIGN, _( "My current location" ) );
    selection_menu.addentry( i++, !player_character.omt_path.empty(), MENU_AUTOASSIGN,
                             _( "My destination" ) );
    selection_menu.addentry( i, true, MENU_AUTOASSIGN, _( "Cancel" ) );
    selection_menu.selected = 0;
    selection_menu.query();
    int index = selection_menu.ret;
    if( index < 0 || index >= i ) {
        return;
    }
    if( index == static_cast<int>( camps.size() ) ) {
        destination = player_character.pos_abs_omt();
    } else if( index == static_cast<int>( camps.size() ) + 1 ) {
        // This looks nuts, but omt_path is emplaced in reverse order. So the front of the vector is our destination
        destination = player_character.omt_path.front();
    } else {
        const basecamp *selected_camp = camps[index];
        destination = selected_camp->camp_omt_pos();
    }
    p.goal = destination;
    p.omt_path = overmap_buffer.get_travel_path( p.pos_abs_omt(), p.goal,
                 overmap_path_params::for_npc() ).points;
    if( destination == tripoint_abs_omt::zero || destination.is_invalid() ||
        p.omt_path.empty() ) {
        p.goal = npc::no_goal_point;
        p.omt_path.clear();
        add_msg( m_info, _( "That is not a valid destination for %s." ), p.disp_name() );
        return;
    }
    g->follower_path_to_show = &p; // Necessary for overmap display in tiles version...
    ui::omap::display_npc_path( p.pos_abs_omt(), p.omt_path );
    g->follower_path_to_show = nullptr;
    int tiles_to_travel = p.omt_path.size();
    time_duration ETA = time_between_npc_OM_moves * tiles_to_travel;
    ETA = ETA * rng_float( 0.8, 1.2 ); // Add +-20% variance in our estimate
    if( !query_yn(
            _( "Estimated time to arrival: %1$s  \nTiles to travel: %2$d  \nIs this path and destination acceptable?" ),
            to_string_approx( ETA ), tiles_to_travel ) ) {
        p.goal = npc::no_goal_point;
        p.omt_path.clear();
        return;
    }
    p.set_mission( NPC_MISSION_TRAVELLING );
    p.chatbin.first_topic = p.chatbin.talk_friend_guard;
    p.guard_pos = std::nullopt;
    p.set_attitude( NPCATT_NULL );
}

void talk_function::assign_guard( npc &p )
{
    if( !p.is_player_ally() ) {
        p.set_mission( NPC_MISSION_GUARD );
        p.set_omt_destination();
        return;
    }

    if( p.has_player_activity() ) {
        p.revert_after_activity();
    }
    p.set_attitude( NPCATT_NULL );
    p.set_mission( NPC_MISSION_GUARD_ALLY );
    p.chatbin.first_topic = p.assigned_camp
                            ? "TALK_FRIEND_GUARD_CAMP"
                            : p.chatbin.talk_friend_guard;
    p.clear_committed_goal();
    p.set_omt_destination();
}

void talk_function::abandon_camp( npc &p )
{
    std::optional<basecamp *> bcp = overmap_buffer.find_camp( p.pos_abs_omt().xy() );
    if( bcp ) {
        basecamp *temp_camp = *bcp;
        temp_camp->abandon_camp();
    }
}

void talk_function::assign_camp( npc &p )
{
    std::optional<basecamp *> bcp = overmap_buffer.find_camp( p.pos_abs_omt().xy() );
    if( bcp ) {
        basecamp *temp_camp = *bcp;
        if( p.has_player_activity() ) {
            p.revert_after_activity();
        }
        p.set_attitude( NPCATT_NULL );
        p.set_mission( NPC_MISSION_CAMP_RESIDENT );
        p.guard_pos = std::nullopt;
        p.clear_ai_guard_pos();
        temp_camp->add_assignee( p.getID() );
        temp_camp->job_assignment_ui();
        temp_camp->validate_assignees();
        add_msg( _( "%1$s is assigned to %2$s" ), p.disp_name(), temp_camp->camp_name() );
        p.chatbin.first_topic = "TALK_FRIEND_CAMP_RESIDENT";
        p.goal = npc::no_goal_point;
        p.omt_path.clear();
        p.path.clear();
        p.chair_pos = std::nullopt;
        p.wander_pos = std::nullopt;
        p.clear_destination();
        p.clear_committed_goal();
    }
}

void talk_function::return_to_camp_duties( npc &p )
{
    p.set_attitude( NPCATT_NULL );
    p.set_mission( NPC_MISSION_CAMP_RESIDENT );
    p.guard_pos = std::nullopt;
    p.clear_ai_guard_pos();
    p.clear_committed_goal();
    p.chatbin.first_topic = "TALK_FRIEND_CAMP_RESIDENT";
    // Check whether the NPC is already within the camp footprint
    // (including expansion tiles), not just the base OMT.
    bool at_camp = false;
    if( p.assigned_camp ) {
        std::optional<basecamp *> bcp = overmap_buffer.find_camp( p.assigned_camp->xy() );
        at_camp = ( bcp && *bcp )
                  ? ( *bcp )->point_within_camp( p.pos_abs_omt() )
                  : p.pos_abs_omt() == *p.assigned_camp;
    }
    if( p.assigned_camp && !at_camp ) {
        p.goal = *p.assigned_camp;
        tripoint_abs_omt surface = p.pos_abs_omt();
        surface.z() = 0;
        p.omt_path = overmap_buffer.get_travel_path( surface, *p.assigned_camp,
                     overmap_path_params::for_npc() ).points;
    } else {
        p.goal = npc::no_goal_point;
        p.omt_path.clear();
    }
    p.path.clear();
    p.chair_pos = std::nullopt;
    p.wander_pos = std::nullopt;
    p.clear_destination();
    add_msg( _( "%s returns to camp duties." ), p.get_name() );
}

void talk_function::stop_guard( npc &p )
{
    if( !p.is_player_ally() ) {
        p.set_attitude( NPCATT_NULL );
        p.set_mission( NPC_MISSION_NULL );
        return;
    }
    p.set_attitude( NPCATT_FOLLOW );
    add_msg( _( "%s begins to follow you." ), p.get_name() );
    p.set_mission( NPC_MISSION_NULL );
    if( p.has_companion_mission() ) {
        p.reset_companion_mission();
    }
    p.chatbin.first_topic = p.chatbin.talk_friend;
    p.goal = npc::no_goal_point;
    p.guard_pos = std::nullopt;
    p.clear_ai_guard_pos();
    p.clear_committed_goal();
    // assigned_camp is preserved: the NPC remembers their camp while following.
    // Player can send them back via "Go back to your camp" in follower dialogue.
}

void talk_function::wake_up( npc &p )
{
    p.rules.clear_override( ally_rule::allow_sleep );
    p.rules.enable_override( ally_rule::allow_sleep );
    p.remove_effect( effect_allow_sleep );
    p.remove_effect( effect_lying_down );
    p.remove_effect( effect_npc_suspend );
    p.remove_effect( effect_sleep );
    // TODO: Get mad at player for waking us up unless we're in danger
}

void talk_function::reveal_stats( npc &p )
{
    p.disp_info( true );
}

void talk_function::end_conversation( npc &p )
{
    add_msg( _( "%s starts ignoring you." ), p.get_name() );
    p.chatbin.first_topic = "TALK_DONE";
}

void talk_function::insult_combat( npc &p )
{
    add_msg( _( "You start a fight with %s!" ), p.get_name() );
    p.chatbin.first_topic = "TALK_DONE";
    p.set_attitude( NPCATT_KILL );
}

static void bionic_install_common( npc &p, Character &patron, Character &patient )
{
    item_location bionic = game_menus::inv::install_bionic( p, patron, patient, true );

    if( !bionic ) {
        return;
    }

    item *tmp = bionic.get_item();
    tmp->set_var( VAR_TRADE_IGNORE, 1 );
    const itype &it = *tmp->type;

    signed int price = npc_trading::bionic_install_price( p, patient, bionic );
    bool const ret = npc_trading::pay_npc( p, price );
    tmp->erase_var( VAR_TRADE_IGNORE );
    if( !ret ) {
        return;
    }

    //Makes the doctor awesome at installing but not perfect
    if( patient.can_install_bionics( it, p, false, 20 ) ) {
        bionic.remove_item();
        patient.install_bionics( it, p, false, 20 );
    }
}

void talk_function::bionic_install( npc &p )
{
    Character &pc = get_player_character();
    bionic_install_common( p, pc, pc );
}

void talk_function::bionic_install_allies( npc &p )
{
    npc *patient = pick_follower();
    if( !patient ) {
        return;
    }
    bionic_install_common( p, get_player_character(), *patient );
}

static void bionic_remove_common( npc &p, Character &patient )
{
    const bionic_collection all_bio = *patient.my_bionics;
    if( all_bio.empty() ) {
        popup( _( "%s doesn't have any bionics installed…" ), patient.get_name() );
        return;
    }

    std::vector<itype_id> bionic_types;
    std::vector<std::string> bionic_names;
    std::vector<const bionic *> bionics;
    for( const bionic &bio : all_bio ) {
        const itype_id &bio_itype = bio.info().itype();
        if( std::find( bionic_types.begin(), bionic_types.end(), bio_itype ) == bionic_types.end() ) {
            bionic_types.push_back( bio_itype );
            if( item::type_is_defined( bio_itype ) ) {
                item tmp = item( bio_itype, calendar::turn_zero );
                bionic_names.push_back( tmp.tname() + " - " + format_money( 5000 + ( tmp.price( true ) / 4 ) ) );
            } else {
                bionic_names.push_back( bio.id.str() + " - " + format_money( 5000 ) );
            }
            bionics.push_back( &bio );
        }
    }
    // Choose bionic if applicable
    int bionic_index = uilist( _( "Which bionic do you wish to uninstall?" ),
                               bionic_names );
    // Did we cancel?
    if( bionic_index < 0 ) {
        popup( _( "You decide to hold off…" ) );
        return;
    }

    signed int price;
    if( item::type_is_defined( bionic_types[bionic_index] ) ) {
        price = 5000 + ( item( bionic_types[bionic_index], calendar::turn_zero ).price( true ) / 4 );
    } else {
        price = 5000;
    }
    if( !npc_trading::pay_npc( p, price ) ) {
        return;
    }

    //Makes the doctor awesome at uninstalling but not perfect
    if( patient.can_uninstall_bionic( *bionics[bionic_index], p, false, 20 ) ) {
        patient.uninstall_bionic( *bionics[bionic_index], p, false, 20 );
    }
}

void talk_function::bionic_remove( npc &p )
{
    bionic_remove_common( p, get_player_character() );
}

void talk_function::bionic_remove_allies( npc &p )
{
    npc *patient = pick_follower();
    if( !patient ) {
        return;
    }
    bionic_remove_common( p, *patient );
}

void talk_function::give_equipment( npc &p )
{
    give_equipment_allowance( p, 0 );
}

void talk_function::give_equipment_allowance( npc &p, int allowance )
{
    std::vector<item_pricing> giving = npc_trading::init_selling( p );
    int chosen = -1;
    while( chosen == -1 && !giving.empty() ) {
        int index = rng( 0, giving.size() - 1 );
        if( giving[index].price < p.op_of_u.owed + allowance ) {
            chosen = index;
        } else {
            giving.erase( giving.begin() + index );
        }
    }
    if( giving.empty() ) {
        popup( _( "%s has nothing to give!" ), p.get_name() );
        return;
    }
    if( chosen < 0 || static_cast<size_t>( chosen ) >= giving.size() ) {
        debugmsg( "Chosen index is outside of available item range!" );
        chosen = 0;
    }
    item it = *giving[chosen].loc.get_item();
    giving[chosen].loc.remove_item();
    popup( _( "%1$s gives you a %2$s." ), p.get_name(), it.tname() );
    Character &player_character = get_player_character();
    it.set_owner( player_character );
    player_character.i_add( it );
    allowance -= giving[chosen].price;
    if( allowance < 0 ) {
        p.op_of_u.owed += allowance;
    }
    p.add_effect( effect_asked_for_item, 3_hours );
}

void talk_function::lesser_give_aid( npc &p )
{
    Character &player_character = get_player_character();
    for( const bodypart_id &bp :
         player_character.get_all_body_parts( get_body_part_flags::only_main ) ) {
        player_character.heal( bp, rng( 5, 15 ) );
        if( player_character.has_effect( effect_bleed, bp.id() ) ) {
            player_character.remove_effect( effect_bleed, bp );
        }
    }
    player_character.assign_activity( wait_npc_activity_actor( 15_minutes, p.get_name() ) );

    p.add_effect( effect_currently_busy, 60_minutes );
}

void talk_function::lesser_give_all_aid( npc &p )
{
    lesser_give_aid( p ); // Provide lesser aid to the player first

    Character &player_character = get_player_character();
    for( npc &guy : g->all_npcs() ) {
        if( guy.is_walking_with() && rl_dist( guy.pos_bub(), player_character.pos_bub() ) < PICKUP_RANGE ) {
            for( const bodypart_id &bp :
                 guy.get_all_body_parts( get_body_part_flags::only_main ) ) {
                guy.heal( bp, rng( 5, 15 ) );
                if( guy.has_effect( effect_bleed, bp.id() ) ) {
                    guy.remove_effect( effect_bleed, bp );
                }
            }
        }
    }
    player_character.assign_activity( wait_npc_activity_actor( 30_minutes, p.get_name() ) );
    p.add_effect( effect_currently_busy, 120_minutes );
}

void talk_function::give_aid( npc &p )
{
    Character &player_character = get_player_character();
    for( const bodypart_id &bp :
         player_character.get_all_body_parts( get_body_part_flags::only_main ) ) {
        player_character.heal( bp, 5 * rng( 2, 5 ) );
        if( player_character.has_effect( effect_bite, bp.id() ) ) {
            player_character.remove_effect( effect_bite, bp );
        }
        if( player_character.has_effect( effect_bleed, bp.id() ) ) {
            player_character.remove_effect( effect_bleed, bp );
        }
        if( player_character.has_effect( effect_infected, bp.id() ) ) {
            player_character.remove_effect( effect_infected, bp );
        }
    }
    player_character.assign_activity( wait_npc_activity_actor( 30_minutes, p.get_name() ) );
    p.add_effect( effect_currently_busy, 120_minutes );
}

void talk_function::give_all_aid( npc &p )
{
    give_aid( p ); // Provide aid to the player first

    Character &player_character = get_player_character();
    for( npc &guy : g->all_npcs() ) {
        if( guy.is_walking_with() && rl_dist( guy.pos_bub(), player_character.pos_bub() ) < PICKUP_RANGE ) {
            for( const bodypart_id &bp :
                 guy.get_all_body_parts( get_body_part_flags::only_main ) ) {
                guy.heal( bp, 5 * rng( 2, 5 ) );
                if( guy.has_effect( effect_bite, bp.id() ) ) {
                    guy.remove_effect( effect_bite, bp );
                }
                if( guy.has_effect( effect_bleed, bp.id() ) ) {
                    guy.remove_effect( effect_bleed, bp );
                }
                if( guy.has_effect( effect_infected, bp.id() ) ) {
                    guy.remove_effect( effect_infected, bp );
                }
            }
        }
    }
    player_character.assign_activity( wait_npc_activity_actor( 60_minutes, p.get_name() ) );
    p.add_effect( effect_currently_busy, 240_minutes );
}

void talk_function::repair_bionic_limbs( npc &p )
{
    Character &player_character = get_player_character();

    signed int price = 0;

    for( const bodypart_id &bp : player_character.get_all_body_parts(
             get_body_part_flags::only_main ) ) {
        if( bp->has_flag( json_flag_BIONIC_LIMB ) || bp->has_flag( json_flag_PARTIAL_BIONIC_LIMB ) ) {
            price += ( player_character.get_part_hp_max( bp ) - player_character.get_part_hp_cur( bp ) ) * 20;
        }
    }
    if( price == 0 ) {
        add_msg( m_good, _( "You don't need any repairs…" ) );
        return;
    }
    bool const ret = npc_trading::pay_npc( p, price );
    if( !ret ) {
        return;
    }

    for( const bodypart_id &bp :
         player_character.get_all_body_parts( get_body_part_flags::only_main ) ) {
        if( bp->has_flag( json_flag_BIONIC_LIMB ) ||  bp->has_flag( json_flag_PARTIAL_BIONIC_LIMB ) ) {
            player_character.heal( bp, player_character.get_part_hp_max( bp ) -
                                   player_character.get_part_hp_cur( bp ) );
            if( player_character.has_effect( effect_bite, bp.id() ) ) {
                player_character.remove_effect( effect_bite, bp );
            }
            if( player_character.has_effect( effect_bleed, bp.id() ) ) {
                player_character.remove_effect( effect_bleed, bp );
            }
        }
    }
    player_character.assign_activity( wait_npc_activity_actor( 30_minutes, p.get_name() ) );
    p.add_effect( effect_currently_busy, 120_minutes );
}

static void generic_barber( const std::string &mut_type )
{
    uilist hair_menu;
    std::string menu_text;
    if( mut_type == "hair_style" ) {
        menu_text = _( "Choose a new hairstyle" );
    } else if( mut_type == "facial_hair" ) {
        menu_text = _( "Choose a new facial hair style" );
    }
    hair_menu.text = menu_text;
    int index = 0;
    hair_menu.addentry( index, true, 'q', _( "Actually…  I've changed my mind." ) );
    std::vector<trait_and_var> hair_muts = mutations_var_in_type( mut_type );
    Character &player_character = get_player_character();
    trait_and_var cur_hair;
    for( const trait_and_var &elem : hair_muts ) {
        if( player_character.has_trait_variant( elem ) ) {
            cur_hair = elem;
        }
        index += 1;
        hair_menu.addentry( index, true, MENU_AUTOASSIGN, elem.name() );
    }
    hair_menu.query();
    int choice = hair_menu.ret;
    if( choice != 0 ) {
        if( player_character.has_trait( cur_hair.trait ) ) {
            player_character.remove_mutation( cur_hair.trait, true );
        }
        const trait_and_var &chosen = hair_muts[choice - 1];
        player_character.set_mutation( chosen.trait, chosen.trait->variant( chosen.variant ) );
        add_msg( m_info, _( "You get a trendy new cut!" ) );
    }
}

void talk_function::barber_beard( npc &/*p*/ )
{
    generic_barber( "facial_hair" );
}

void talk_function::barber_hair( npc &/*p*/ )
{
    generic_barber( "hair_style" );
}

void talk_function::buy_haircut( npc &p )
{
    Character &player_character = get_player_character();
    player_character.add_morale( morale_haircut, 5, 5, 720_minutes, 3_minutes );
    player_character.assign_activity( wait_npc_activity_actor( 20_minutes, p.get_name() ) );
    add_msg( m_good, _( "%s gives you a decent haircut…" ), p.get_name() );
}

void talk_function::buy_shave( npc &p )
{
    Character &player_character = get_player_character();
    player_character.add_morale( morale_shave, 10, 10, 360_minutes, 3_minutes );
    player_character.assign_activity( wait_npc_activity_actor( 5_minutes, p.get_name() ) );
    add_msg( m_good, _( "%s gives you a decent shave…" ), p.get_name() );
}

void talk_function::morale_chat_activity( npc &p )
{
    Character &player_character = get_player_character();
    player_character.assign_activity( socialize_activity_actor( 10_minutes, p.getID() ) );
}

/*
 * Function to make the npc drop non favorite, worn or wielded items at their current position.
 */
void talk_function::drop_items_in_place( npc &p )
{
    std::vector<drop_or_stash_item_info> to_drop;

    // add all non favorite carried items to the drop off list
    for( const item_location &npcs_item : p.all_items_loc() ) {
        if( !npcs_item->is_favorite && npcs_item.where() == item_location::type::container &&
            npcs_item.parent_item().where() == item_location::type::character ) {
            to_drop.emplace_back( npcs_item, npcs_item->count() );
        }
    }
    if( !to_drop.empty() ) {
        // spawn a activity for the npc to drop the specified items
        p.assign_activity( drop_activity_actor( to_drop, tripoint_rel_ms::zero, false ) );
        p.say( "<acknowledged>" );
    } else {
        p.say( _( "I don't have anything to drop off." ) );
    }
}

void talk_function::follow( npc &p )
{
    g->add_npc_follower( p.getID() );
    p.set_attitude( NPCATT_FOLLOW );
    p.set_fac( faction_your_followers );
    get_player_character().cash += p.cash;
    p.cash = 0;
    if( !p.custom_profession.empty() ) {
        p.custom_profession.clear();
    }
}

void talk_function::follow_only( npc &p )
{
    p.set_attitude( NPCATT_FOLLOW );
}

void talk_function::deny_follow( npc &p )
{
    p.add_effect( effect_asked_to_follow, 6_hours );
}

void talk_function::deny_lead( npc &p )
{
    p.add_effect( effect_asked_to_lead, 6_hours );
}

void talk_function::deny_equipment( npc &p )
{
    p.add_effect( effect_asked_for_item, 1_hours );
}

void talk_function::deny_train( npc &p )
{
    p.add_effect( effect_asked_to_train, 6_hours );
}

void talk_function::deny_personal_info( npc &p )
{
    p.add_effect( effect_asked_personal_info, 3_hours );
}

void talk_function::hostile( npc &p )
{
    const map &here = get_map();

    if( p.get_attitude() == NPCATT_KILL ) {
        return;
    }

    if( p.sees( here, get_player_character() ) ) {
        add_msg( _( "%s turns hostile!" ), p.get_name() );
    }

    get_event_bus().send<event_type::npc_becomes_hostile>( p.getID(), p.name );
    p.set_attitude( NPCATT_KILL );
}

void talk_function::flee( npc &p )
{
    add_msg( _( "%s turns to flee!" ), p.get_name() );
    p.set_attitude( NPCATT_FLEE );
}

void talk_function::leave( npc &p )
{
    add_msg( _( "%s leaves." ), p.get_name() );
    g->remove_npc_follower( p.getID() );
    std::string new_fac_id = "solo_";
    new_fac_id += p.name;
    new_fac_id += std::to_string( p.getID().get_value() );
    p.job.clear_all_priorities();
    // create a new "lone wolf" faction for this one NPC
    faction *new_solo_fac = g->faction_manager_ptr->add_new_faction( p.name,
                            faction_id( new_fac_id ), faction_no_faction );
    p.set_fac( new_solo_fac ? new_solo_fac->id : faction_no_faction );
    if( new_solo_fac ) {
        new_solo_fac->known_by_u = true;
    }
    p.chatbin.first_topic = p.chatbin.talk_stranger_neutral;
    p.set_attitude( NPCATT_NULL );
    p.mission = NPC_MISSION_NULL;
    p.long_term_goal_action();
}

void talk_function::stop_following( npc &p )
{
    // this is to tell non-allied NPCs to stop following.
    // ( usually after a mission where they were temporarily tagging along )
    // so don't tell already allied NPCs to stop following.
    // they use the guard command for that.
    if( p.is_player_ally() ) {
        return;
    }
    add_msg( _( "%s stops following." ), p.get_name() );
    p.set_attitude( NPCATT_NULL );
}

void talk_function::stranger_neutral( npc &p )
{
    add_msg( _( "%s feels less threatened by you." ), p.get_name() );
    p.set_attitude( NPCATT_NULL );
    p.chatbin.first_topic = p.chatbin.talk_stranger_neutral;
}

bool talk_function::drop_stolen_item( item &cur_item, npc &p )
{
    Character &player_character = get_player_character();
    map &here = get_map();
    bool dropped = false;
    if( cur_item.is_old_owner( p ) ) {
        item to_drop = player_character.i_rem( &cur_item );
        to_drop.remove_old_owner();
        to_drop.set_owner( p );
        here.add_item_or_charges( player_character.pos_bub(), to_drop );
        dropped = true;
    } else if( cur_item.is_container() ) {
        bool changed = false;
        for( item *contained : cur_item.all_items_top() ) {
            changed |= drop_stolen_item( *contained, p );
        }
        if( changed ) {
            dropped = true;
            cur_item.on_contents_changed();
        }
    }
    return dropped;
}

void talk_function::drop_stolen_item( npc &p )
{
    bool dropped = false;
    Character &player_character = get_player_character();
    for( item *&elem : player_character.inv_dump() ) {
        dropped |= drop_stolen_item( *elem, p );
    }
    if( dropped ) {
        player_character.invalidate_weight_carried_cache();
    } else {
        debugmsg( "Failed to drop any stolen items." );
    }
    if( p.known_stolen_item ) {
        p.known_stolen_item = nullptr;
    }
    if( player_character.is_hauling() ) {
        player_character.stop_hauling();
    }
    p.set_attitude( NPCATT_NULL );
}

void talk_function::remove_stolen_status( npc &p )
{
    if( p.known_stolen_item ) {
        p.known_stolen_item = nullptr;
    }
    p.set_attitude( NPCATT_NULL );
}

void talk_function::start_mugging( npc &p )
{
    p.set_attitude( NPCATT_MUG );
    add_msg( _( "Pause to stay still.  Any movement may cause %s to attack." ), p.get_name() );
}

void talk_function::player_leaving( npc &p )
{
    p.set_attitude( NPCATT_WAIT_FOR_LEAVE );
    p.patience = 15 - p.personality.aggression;
}

void talk_function::drop_weapon( npc &p )
{
    if( p.is_hallucination() ) {
        return;
    }
    item weap = p.remove_weapon();
    get_map().add_item_or_charges( p.pos_bub(), weap );
}

void talk_function::player_weapon_away( npc &/*p*/ )
{
    Character &player_character = get_player_character();

    std::optional<bionic *> bionic_weapon = player_character.find_bionic_by_uid(
            player_character.get_weapon_bionic_uid() );
    if( bionic_weapon ) {
        player_character.deactivate_bionic( **bionic_weapon );
        return;
    }

    player_character.i_add( player_character.remove_weapon() );
}

void talk_function::player_weapon_drop( npc &/*p*/ )
{
    map &here = get_map();

    Character &player_character = get_player_character();
    item weap = player_character.remove_weapon();
    drop_on_map( player_character, item_drop_reason::deliberate, {weap}, &here,
                 player_character.pos_bub( here ) );
}

void talk_function::lead_to_safety( npc &p )
{
    mission *reach_safety_mission = mission::reserve_new( mission_MISSION_REACH_SAFETY,
                                    character_id() );
    reach_safety_mission->assign( get_avatar() );
    p.goal = reach_safety_mission->get_target();
    p.set_attitude( NPCATT_LEAD );
}

bool npc_trading::pay_npc( npc &np, int cost )
{
    if( np.op_of_u.owed >= cost ) {
        np.op_of_u.owed -= cost;
        return true;
    }

    return npc_trading::trade( np, cost, _( "Pay:" ) );
}

namespace talk_function
{
std::string teach_domain::to_string() const
{
    std::string subject_name;
    if( skill.is_valid() ) {
        subject_name = skill->name();
    } else if( prof.is_valid() ) {
        subject_name = prof->name();
    } else if( style.is_valid() ) {
        subject_name = style->name.translated();
    } else if( spell.is_valid() ) {
        subject_name = spell->name.translated();
    }
    return subject_name;
}

void teach_domain::serialize( JsonOut &jsout ) const
{
    jsout.start_object();
    jsout.member( "skill", skill );
    jsout.member( "prof", prof );
    jsout.member( "style", style );
    jsout.member( "spell", spell );
    jsout.end_object();
}

void teach_domain::deserialize( const JsonValue &jsin )
{
    JsonObject data = jsin.get_object();
    data.read( "skill", skill );
    data.read( "prof", prof );
    data.read( "style", style );
    data.read( "spell", spell );
}
} //namespace talk_function

void talk_function::start_training_npc( npc &p )
{
    teach_domain d;
    d.skill = p.chatbin.skill;
    d.style = p.chatbin.style;
    d.spell = p.chatbin.dialogue_spell;
    d.prof = p.chatbin.proficiency;
    std::vector<Character *> students;
    students.push_back( &p );
    start_training_gen( get_player_character(), students, d );
}

void talk_function::start_training( npc &p )
{
    teach_domain d;
    d.skill = p.chatbin.skill;
    d.style = p.chatbin.style;
    d.spell = p.chatbin.dialogue_spell;
    d.prof = p.chatbin.proficiency;
    std::vector<Character *> students;
    students.push_back( &get_player_character() );
    start_training_gen( p, students, d );
}

void talk_function::start_training_seminar( npc &p )
{
    teach_domain d;
    d.skill = p.chatbin.skill;
    d.style = p.chatbin.style;
    d.spell = p.chatbin.dialogue_spell;
    d.prof = p.chatbin.proficiency;
    std::vector<npc *> followers = g->get_npcs_if( [&p]( const npc & n ) {
        return n.is_player_ally() && n.is_following() && n.can_hear( p.pos_bub(), p.get_shout_volume() );
    } );
    std::vector<Character *> students;
    for( npc *n : followers ) {
        if( n && p.getID() != n->getID() ) {
            students.push_back( n );
        }
    }
    students.push_back( &get_player_character() );

    std::vector<Character *> picked;
    std::function<bool( const Character * )> include_func = [&]( const Character * c ) {
        if( d.skill != skill_id() ) {
            return c->get_knowledge_level( d.skill ) < p.get_knowledge_level( d.skill );
        } else if( d.style != matype_id() ) {
            return !c->martial_arts_data->has_martialart( d.style );
        } else if( d.prof != proficiency_id() ) {
            return !c->has_proficiency( d.prof );
        } else if( d.spell != spell_id() ) {
            const bool knows = c->magic->knows_spell( d.spell );
            return !knows || c->magic->get_spell( d.spell ).get_level() <
                   p.magic->get_spell( d.spell ).get_level();
        }
        return false;
    };
    std::vector<int> selected = npcs_select_menu( students, _( "Who should participate?" ),
    [&include_func]( const Character * ch ) {
        return !include_func( ch );
    } );

    if( selected.empty() ) {
        return;
    }
    picked.reserve( selected.size() );
    for( int sel : selected ) {
        picked.emplace_back( students[sel] );
    }
    start_training_gen( p, picked, d );
}

void talk_function::start_training_gen( Character &teacher, std::vector<Character *> &students,
                                        teach_domain &d )
{
    int cost = 0;
    time_duration time = 0_turns;
    std::string name;
    const skill_id &skill = d.skill;
    const matype_id &style = d.style;
    const spell_id &sp_id = d.spell;
    const proficiency_id &proficiency = d.prof;
    bool player_is_student = false;

    for( Character *student : students ) {
        if( student->is_avatar() ) {
            player_is_student = true;
        }
        int tmp_cost = 0;
        time_duration tmp_time = 0_turns;
        if( skill != skill_id() &&
            student->get_knowledge_level( skill ) < teacher.get_knowledge_level( skill ) ) {
            tmp_cost = calc_skill_training_cost_char( teacher, *student, skill );
            tmp_time = calc_skill_training_time_char( teacher, *student, skill );
        } else if( style != matype_id() &&
                   !student->martial_arts_data->has_martialart( style ) ) {
            tmp_cost = calc_ma_style_training_cost( teacher, *student, style );
            tmp_time = calc_ma_style_training_time( teacher, *student, style );
        } else if( sp_id != spell_id() ) {
            // already checked if can learn this spell in npctalk.cpp
            tmp_cost = calc_spell_training_cost( teacher, *student, sp_id );
            tmp_time = calc_spell_training_time( teacher, *student, sp_id );
        } else if( proficiency != proficiency_id() ) {
            tmp_cost = calc_proficiency_training_cost( teacher, *student, proficiency );
            tmp_time = calc_proficiency_training_time( teacher, *student, proficiency );
        } else {
            debugmsg( "start_training with no valid skill or style set" );
            return;
        }
        // use the slowest common denominator and combine cost
        cost += tmp_cost;
        time = std::max( time, tmp_time );
    }

    if( !teacher.is_avatar() ) {
        npc &p = static_cast<npc &>( teacher );
        mission *miss = p.chatbin.mission_selected;
        const character_id &pid = get_player_character().getID();
        if( player_is_student && miss != nullptr &&
            miss->get_assigned_player_id() == pid && miss->is_complete( pid ) ) {
            clear_mission( p );
        } else if( !npc_trading::pay_npc( p, cost ) ) {
            return;
        }
    }
    std::vector<character_id> student_ids;
    student_ids.reserve( students.size() );
    for( Character *student : students ) {
        student_ids.emplace_back( student->getID() );
    }

    const character_id teacher_id = teacher.getID();
    teacher.assign_activity( training_activity_actor( time, d, student_ids ) );
    teacher.add_effect( effect_asked_to_train, 6_hours );
    for( Character *student : students ) {
        student->assign_activity( training_activity_actor( time, d, teacher_id ) );
    }
}

npc *pick_follower()
{
    const map &here = get_map();

    std::vector<npc *> followers;
    std::vector<tripoint_bub_ms> locations;

    for( npc &guy : g->all_npcs() ) {
        if( guy.is_player_ally() && get_player_view().sees( here, guy ) ) {
            followers.push_back( &guy );
            locations.push_back( guy.pos_bub() );
        }
    }

    pointmenu_cb callback( locations );

    uilist menu;
    menu.text = _( "Select a follower" );
    menu.callback = &callback;

    for( const npc *p : followers ) {
        menu.addentry( -1, true, MENU_AUTOASSIGN, p->get_name() );
    }

    menu.query();
    if( menu.ret < 0 || static_cast<size_t>( menu.ret ) >= followers.size() ) {
        return nullptr;
    }

    return followers[ menu.ret ];
}

void talk_function::distribute_food_auto( npc &p )
{
    std::optional<basecamp *> bcp = overmap_buffer.find_camp( p.pos_abs_omt().xy() );
    if( !bcp ) {
        debugmsg( "distribute_food_auto called without a basecamp, aborting." );
        return;
    }
    basecamp *npc_camp = *bcp;
    if( !npc_camp->allowed_access_by( p ) ) {
        debugmsg( "distribute_food_auto called on npc that isn't allowed to access local basecamp storage, aborting." );
        return;
    }

    zone_manager &mgr = zone_manager::get_manager();
    const tripoint_abs_ms &npc_abs_loc = p.pos_abs();
    // 3x3 square with NPC in the center, includes NPC's tile and all adjacent ones, for overflow
    const tripoint_abs_ms top_left = npc_abs_loc + point::north_west;
    const tripoint_abs_ms bottom_right = npc_abs_loc + point::south_east;
    std::string zone_name = "ERROR IF YOU SEE THIS (dummy zone talk_function::distribute_food_auto)";
    const faction_id &fac_id = p.get_fac_id();
    mgr.add( zone_name, zone_type_CAMP_FOOD, fac_id, false, true, top_left, bottom_right );
    mgr.add( zone_name, zone_type_CAMP_STORAGE, fac_id, false, true, top_left,
             bottom_right );
    npc_camp->distribute_food( false );
    // Now we clean up all camp zones, though there SHOULD only be the two we just made
    auto lambda_remove_zones = [&mgr, &fac_id]( zone_type_id type_to_remove ) {
        std::vector<zone_manager::ref_zone_data> p_zones = mgr.get_zones( fac_id );
        for( zone_data &a_zone : p_zones ) {
            if( a_zone.get_type() == type_to_remove ) {
                mgr.remove( a_zone );
            }
        }
    };
    lambda_remove_zones( zone_type_CAMP_FOOD );
    lambda_remove_zones( zone_type_CAMP_STORAGE );
}

void talk_function::copy_npc_rules( npc &p )
{
    const npc *other = pick_follower();
    if( other != nullptr && other != &p ) {
        p.rules = other->rules;
    }
}

void talk_function::set_npc_pickup( npc &p )
{
    p.rules.pickup_whitelist->show( p.name );
}

void talk_function::npc_thankful( npc &p )
{
    if( p.get_attitude() == NPCATT_MUG || p.get_attitude() == NPCATT_WAIT_FOR_LEAVE ||
        p.get_attitude() == NPCATT_FLEE || p.get_attitude() == NPCATT_KILL ||
        p.get_attitude() == NPCATT_FLEE_TEMP ) {
        p.set_attitude( NPCATT_NULL );
    }
    if( p.chatbin.first_topic != p.chatbin.talk_friend ) {
        p.chatbin.first_topic = p.chatbin.talk_stranger_friendly;
    }
    int8_t &aggro = p.personality.aggression;
    aggro = std::clamp<int8_t>( aggro - 1, NPC_PERSONALITY_MIN, NPC_PERSONALITY_MAX );

}

void talk_function::clear_overrides( npc &p )
{
    p.rules.clear_overrides();
}

void talk_function::pick_style( npc &p )
{
    p.martial_arts_data->pick_style( p );
}
