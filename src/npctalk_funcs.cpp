#include "npctalk.h" // IWYU pragma: associated

#include <line.h>
#include <map_scale_constants.h>
#include <memory_fast.h>
#include <monster_uid.h>
#include <string_formatter.h>
#include <tileray.h>
#include <type_id.h>
#include <algorithm>
#include <cmath>
#include <cstddef>
#include <cstdint>
#include <initializer_list>
#include <limits>
#include <list>
#include <map>
#include <memory>
#include <optional>
#include <set>
#include <sstream>
#include <string>
#include <unordered_set>
#include <utility>
#include <vector>

#include "activity_actor_definitions.h"
#include "activity_handlers.h"
#include "auto_pickup.h"
#include "avatar.h"
#include "basecamp.h"
#include "bionics.h"
#include "bodypart.h"
#include "cached_options.h"
#include "calendar.h"
#include "cata_utility.h"
#include "character.h"
#include "character_action_guard.h"
#include "character_id.h"
#include "character_martial_arts.h"
#include "clzones.h"
#include "coordinates.h"
#include "creature.h"
#include "debug.h"
#include "dialogue.h"
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
#include "mission_dialogue.h"
#include "monster.h"
#include "mp_actor_binding.h"
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
#include "trade_ui.h"
#include "translation.h"
#include "translations.h"
#include "uilist.h"
#include "units.h"
#include "units_utility.h"
#include "value_ptr.h"
#include "veh_interact.h"
#include "veh_type.h"
#include "vehicle.h"
#include "viewer.h"

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
static const furn_str_id furn_f_counter( "f_counter" );
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
static const zone_type_id zone_type_VEHICLE_SERVICE_OUTPUT( "VEHICLE_SERVICE_OUTPUT" );

static const std::string vehicle_part_repair_target = "vehicle_part_repair_target";
static const std::string vehicle_part_repair_price_multiplier =
    "vehicle_part_repair_price_multiplier";
static const std::string vehicle_full_repair_valid = "vehicle_full_repair_selection_valid";
static const std::string vehicle_full_repair_vehicle_name = "vehicle_full_repair_vehicle_name";
static const std::string vehicle_full_repair_part_count = "vehicle_full_repair_part_count";
static const std::string vehicle_full_repair_cost = "vehicle_full_repair_cost";
static const std::string vehicle_full_repair_cost_text = "vehicle_full_repair_cost_text";
static const std::string vehicle_full_repair_time = "vehicle_full_repair_time";
static const std::string vehicle_full_repair_time_text = "vehicle_full_repair_time_text";
static const std::string vehicle_full_repair_status = "vehicle_full_repair_status";
static const std::string vehicle_full_repair_snapshot = "vehicle_full_repair_snapshot";
static const std::string vehicle_part_install_price_multiplier =
    "vehicle_part_install_price_multiplier";
static const std::string vehicle_part_service_status = "vehicle_part_service_status";

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

static void clear_vehicle_full_repair_quote( npc &p )
{
    p.set_value( vehicle_full_repair_valid, 0 );
    p.set_value( vehicle_full_repair_vehicle_name, "" );
    p.set_value( vehicle_full_repair_part_count, 0 );
    p.set_value( vehicle_full_repair_cost, 0 );
    p.set_value( vehicle_full_repair_cost_text, format_money( 0 ) );
    p.set_value( vehicle_full_repair_time, 0 );
    p.set_value( vehicle_full_repair_time_text, "" );
    p.set_value( vehicle_full_repair_status, "cancelled" );
}

static bool vehicle_part_repair_is_selectable( const vehicle_part &part )
{
    return !part.removed && !part.is_fake && part.max_damage() > 0 &&
           ( part.damage() > 0 || part.degradation() > 0 || !part.faults().empty() );
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

std::string talk_function::vehicle_service_state_snapshot( const vehicle &veh )
{
    std::ostringstream result;
    for( int index = 0; index < veh.part_count(); ++index ) {
        const vehicle_part &part = veh.part( index );
        if( part.removed || part.is_fake ) {
            continue;
        }
        const std::string part_id = part.info().id.str();
        const std::string faults = vehicle_part_repair_fault_snapshot( part );
        result << index << ':' << part_id.size() << ':' << part_id << ':'
               << part.mount.x() << ':' << part.mount.y() << ':' << part.damage() << ':'
               << part.degradation() << ':' << faults.size() << ':' << faults << ';';
    }
    return result.str();
}

namespace
{
bool start_training_request( Character &teacher, const std::vector<Character *> &students,
                             const talk_function::teach_domain &domain, mission *reward_mission,
                             dialogue *conversation = nullptr, Character *explicit_patron = nullptr );
void request_remote_seminar( dialogue &conversation, npc &teacher, Character &payer,
                             const talk_function::teach_domain &domain );
}

namespace mission_dialogue
{

namespace
{

std::vector<mission_selection_identity> active_mission_operations;

class scoped_mission_operation_guard
{
    public:
        explicit scoped_mission_operation_guard( const mission_selection_identity &identity )
            : identity_( identity ) {
            if( !identity_.is_set() ) {
                return;
            }
            if( std::find( active_mission_operations.begin(), active_mission_operations.end(),
                           identity_ ) != active_mission_operations.end() ) {
                return;
            }
            active_mission_operations.push_back( identity_ );
            acquired_ = true;
        }

        scoped_mission_operation_guard( const scoped_mission_operation_guard & ) = delete;
        scoped_mission_operation_guard &operator=( const scoped_mission_operation_guard & ) = delete;

        ~scoped_mission_operation_guard() {
            if( !acquired_ ) {
                return;
            }
            const auto it = std::find( active_mission_operations.begin(),
                                       active_mission_operations.end(), identity_ );
            if( it != active_mission_operations.end() ) {
                active_mission_operations.erase( it );
            }
        }

        explicit operator bool() const {
            return acquired_;
        }

    private:
        mission_selection_identity identity_;
        bool acquired_ = false;
};

} // namespace

mission_selection_identity identify_mission( const mission *miss )
{
    const mission *live = mission::find_by_address( miss );
    return live ? mission_selection_identity{ live->get_id(), live->identity_generation() } :
           mission_selection_identity{};
}

mission *resolve_live_mission( const mission_selection_identity &identity )
{
    if( !identity.is_set() ) {
        return nullptr;
    }
    mission *live = mission::find( identity.uid, true );
    if( live == nullptr || live->identity_generation() != identity.generation ) {
        return nullptr;
    }
    return live;
}

bool is_live_mission( const mission *miss )
{
    return identify_mission( miss ).is_set();
}

bool is_available_chatbin_mission( const npc &p, const mission *miss )
{
    if( !is_live_mission( miss ) || miss->get_npc_id() != p.getID() ) {
        return false;
    }
    if( miss->is_assigned() || miss->in_progress() ||
        miss->has_succeeded() || miss->has_failed() ) {
        return false;
    }
    if( std::find( p.chatbin.missions.begin(), p.chatbin.missions.end(), miss ) ==
        p.chatbin.missions.end() ) {
        return false;
    }
    if( std::find( p.chatbin.missions_assigned.begin(), p.chatbin.missions_assigned.end(), miss ) !=
        p.chatbin.missions_assigned.end() ) {
        return false;
    }
    return true;
}

bool is_assigned_chatbin_mission_for( const npc &p, const character_id &owner_id,
                                      const mission *miss )
{
    if( !owner_id.is_valid() || !is_live_mission( miss ) || miss->get_npc_id() != p.getID() ) {
        return false;
    }
    if( !miss->is_assigned() || miss->get_assigned_player_id() != owner_id ) {
        return false;
    }
    return std::find( p.chatbin.missions_assigned.begin(), p.chatbin.missions_assigned.end(),
                      miss ) != p.chatbin.missions_assigned.end();
}

bool is_authorized_dialogue_mission( const npc &p, const character_id &owner_id,
                                     const mission *miss )
{
    return is_available_chatbin_mission( p, miss ) ||
           is_assigned_chatbin_mission_for( p, owner_id, miss );
}

mission *resolve_selected_mission( const npc &p, const character_id &owner_id,
                                   mission_selection_identity &selection )
{
    mission *live = resolve_live_mission( selection );
    if( live == nullptr || !is_authorized_dialogue_mission( p, owner_id, live ) ) {
        selection.reset();
        return nullptr;
    }
    return live;
}

std::vector<mission *> filter_available_missions( const npc &p )
{
    std::vector<mission *> result;
    for( mission *miss : p.chatbin.missions ) {
        if( is_available_chatbin_mission( p, miss ) ) {
            result.push_back( miss );
        }
    }
    return result;
}

std::vector<mission *> filter_assigned_missions_for( const npc &p,
        const character_id &owner_id )
{
    std::vector<mission *> result;
    if( !owner_id.is_valid() ) {
        return result;
    }
    for( mission *miss : p.chatbin.missions_assigned ) {
        if( is_assigned_chatbin_mission_for( p, owner_id, miss ) ) {
            result.push_back( miss );
        }
    }
    return result;
}

bool participants_live( const const_dialogue &d )
{
    for( const bool beta : {
             false, true
         } ) {
        if( d.has_actor( beta ) && !d.const_actor( beta )->is_valid() ) {
            return false;
        }
    }
    return true;
}

Character *resolve_dialogue_character( const const_dialogue &d, const bool is_beta )
{
    if( !participants_live( d ) || !d.has_actor( is_beta ) ) {
        return nullptr;
    }
    Character *who = const_cast<Character *>( d.const_actor( is_beta )->get_const_character() );
    if( !who ) {
        return nullptr;
    }
    const character_action_guard guard( *who );
    return guard ? who : nullptr;
}

npc *resolve_dialogue_npc( const dialogue &d, const bool is_beta )
{
    Character *ch = resolve_dialogue_character( d, is_beta );
    return ch != nullptr ? ch->as_npc() : nullptr;
}

} // namespace mission_dialogue

namespace mission_dialogue
{

namespace
{

bool assign_mission_for_character( npc &p, Character &u, mission *miss, dialogue *d )
{
    const character_action_guard u_guard( u );
    const character_action_guard p_guard( p );
    if( !u_guard || !p_guard || !is_available_chatbin_mission( p, miss ) ) {
        return false;
    }
    const mission_selection_identity identity = identify_mission( miss );
    const scoped_mission_operation_guard op_guard( identity );
    if( !op_guard ) {
        return false;
    }
    miss->assign( u );
    if( !u_guard || !p_guard ) {
        return false;
    }
    mission *live = resolve_live_mission( identity );
    if( !live || !live->is_assigned() || live->get_assigned_player_id() != u.getID() ||
        live->get_npc_id() != p.getID() ) {
        return false;
    }
    p.chatbin.missions.erase(
        std::remove( p.chatbin.missions.begin(), p.chatbin.missions.end(), live ),
        p.chatbin.missions.end() );
    if( live != nullptr && live->get_npc_id() == p.getID() &&
        live->is_assigned() && live->get_assigned_player_id() == u.getID() ) {
        if( std::find( p.chatbin.missions_assigned.begin(), p.chatbin.missions_assigned.end(),
                       live ) == p.chatbin.missions_assigned.end() ) {
            p.chatbin.missions_assigned.push_back( live );
        }
    }
    if( d != nullptr ) {
        if( live != nullptr && is_assigned_chatbin_mission_for( p, u.getID(), live ) ) {
            d->actor( true )->select_mission( live );
        } else {
            d->actor( true )->select_mission( nullptr );
        }
        talk_effect_t::update_missions( *d );
    }
    return live != nullptr;
}

bool succeed_mission_for_character( npc &p, Character &u, mission *miss, dialogue *d )
{
    const character_action_guard u_guard( u );
    const character_action_guard p_guard( p );
    if( !u_guard || !p_guard ||
        !is_assigned_chatbin_mission_for( p, u.getID(), miss ) ||
        miss->has_succeeded() || miss->has_failed() ) {
        return false;
    }
    const mission_selection_identity identity = identify_mission( miss );
    const scoped_mission_operation_guard op_guard( identity );
    if( !op_guard ) {
        return false;
    }
    const int miss_val = npc_trading::cash_to_favor( p, miss->get_value() );
    npc_opinion op;
    op.value = 1 + miss_val / 5;
    op.anger = -1;
    p.opinion_of( u.getID() ) += op;
    faction *p_fac = p.get_faction();
    if( p_fac != nullptr ) {
        const int fac_val = std::min( 1 + miss_val / 10, 10 );
        p_fac->likes_u += fac_val;
        p_fac->respects_u += fac_val;
        p_fac->trusts_u += fac_val;
        p_fac->power += fac_val;
    }
    miss->wrap_up( u );
    if( d != nullptr && u_guard && p_guard ) {
        talk_effect_t::update_missions( *d );
    }
    return true;
}

bool fail_mission_for_character( npc &p, Character &u, mission *miss, dialogue *d )
{
    const character_action_guard u_guard( u );
    const character_action_guard p_guard( p );
    if( !u_guard || !p_guard ||
        !is_assigned_chatbin_mission_for( p, u.getID(), miss ) ||
        miss->has_succeeded() || miss->has_failed() ) {
        return false;
    }
    const mission_selection_identity identity = identify_mission( miss );
    const scoped_mission_operation_guard op_guard( identity );
    if( !op_guard ) {
        return false;
    }
    npc_opinion op;
    op.trust = -1;
    op.value = -1;
    op.anger = 1;
    p.opinion_of( u.getID() ) += op;
    miss->fail( u );
    if( d != nullptr && u_guard && p_guard ) {
        talk_effect_t::update_missions( *d );
    }
    return true;
}

bool clear_mission_for_character( npc &p, Character &u, mission *miss, dialogue *d,
                                  bool update_legacy_selection = true )
{
    const character_action_guard u_guard( u );
    const character_action_guard p_guard( p );
    if( !u_guard || !p_guard ||
        !is_assigned_chatbin_mission_for( p, u.getID(), miss ) ) {
        return false;
    }
    if( miss->in_progress() && !miss->is_complete( p.getID(), u ) ) {
        return false;
    }
    const mission_selection_identity identity = identify_mission( miss );
    const scoped_mission_operation_guard op_guard( identity );
    if( !op_guard ) {
        return false;
    }
    const auto it = std::find( p.chatbin.missions_assigned.begin(),
                               p.chatbin.missions_assigned.end(), miss );
    if( it == p.chatbin.missions_assigned.end() ) {
        return false;
    }
    p.chatbin.missions_assigned.erase( it );
    if( !miss->has_failed() && miss->has_follow_up() ) {
        const mission_type_id follow_up_type = miss->get_follow_up();
        if( follow_up_type.is_valid() ) {
            mission *follow_up = mission::reserve_new( follow_up_type, p.getID() );
            if( !u_guard || !p_guard ) {
                return false;
            }
            if( follow_up != nullptr ) {
                p.add_new_mission( follow_up );
            }
        }
    }
    mission *next_selected = nullptr;
    for( mission *candidate : p.chatbin.missions_assigned ) {
        if( is_assigned_chatbin_mission_for( p, u.getID(), candidate ) ) {
            next_selected = candidate;
            break;
        }
    }
    if( next_selected == nullptr ) {
        for( mission *candidate : p.chatbin.missions ) {
            if( is_available_chatbin_mission( p, candidate ) ) {
                next_selected = candidate;
                break;
            }
        }
    }
    if( d != nullptr ) {
        if( p.chatbin.mission_selected == miss ) {
            p.chatbin.mission_selected = nullptr;
        }
        d->actor( true )->select_mission( next_selected );
        talk_effect_t::update_missions( *d );
    } else if( update_legacy_selection ) {
        p.chatbin.mission_selected = next_selected;
    }
    return true;
}

bool reward_mission_for_character( npc &p, Character &u, mission *miss,
                                   dialogue *conversation = nullptr, bool require_trade = false )
{
    const character_action_guard u_guard( u );
    const character_action_guard p_guard( p );
    if( !u_guard || !p_guard ||
        !is_assigned_chatbin_mission_for( p, u.getID(), miss ) ||
        miss->has_failed() || ( miss->generic_reward_claimed() && !require_trade ) ) {
        return false;
    }
    const mission_selection_identity identity = identify_mission( miss );
    const scoped_mission_operation_guard op_guard( identity );
    if( !op_guard ) {
        return false;
    }
    const bool claimed = miss->generic_reward_claimed();
    const int64_t balance = static_cast<int64_t>( std::as_const( p ).opinion_of( u.getID() ).owed ) +
                            ( claimed ? 0 : miss->get_value() );
    if( balance < std::numeric_limits<int>::min() || balance > std::numeric_limits<int>::max() ) {
        return false;
    }
    if( &u != &get_avatar() ) {
        const bool opening = conversation && u.has_native_player_control() &&
                             conversation->request_remote_trade( { _( "Reward" ), false } );
        if( require_trade && !opening ) {
            return false;
        }
    }
    if( !claimed ) {
        miss->commit_generic_reward_claim();
        p.opinion_of( u.getID() ).owed = static_cast<int>( balance );
    }
    if( &u == &get_avatar() ) {
        npc_trading::trade( p, 0, _( "Reward" ) );
    }
    return true;
}

talk_function::teach_domain selected_training_domain( const dialogue &conversation, const npc &p )
{
    talk_function::teach_domain domain;
    if( conversation.has_beta && conversation.const_actor( true )->has_chosen_training() ) {
        const const_talker *actor = conversation.const_actor( true );
        domain.skill = actor->chosen_training_skill();
        domain.style = actor->chosen_training_style();
        domain.spell = actor->chosen_training_spell();
        domain.prof = actor->chosen_training_proficiency();
    } else {
        domain.skill = p.chatbin.skill;
        domain.style = p.chatbin.style;
        domain.spell = p.chatbin.dialogue_spell;
        domain.prof = p.chatbin.proficiency;
    }
    return domain;
}

} // namespace

void assign_selected_mission( dialogue &d )
{
    Character *u = resolve_dialogue_character( d, false );
    npc *p = resolve_dialogue_npc( d, true );
    if( u == nullptr || p == nullptr || !d.has_beta ) {
        return;
    }
    assign_mission_for_character( *p, *u, d.actor( true )->selected_mission(), &d );
}

void succeed_selected_mission( dialogue &d )
{
    Character *u = resolve_dialogue_character( d, false );
    npc *p = resolve_dialogue_npc( d, true );
    if( u == nullptr || p == nullptr || !d.has_beta ) {
        return;
    }
    succeed_mission_for_character( *p, *u, d.actor( true )->selected_mission(), &d );
}

void fail_selected_mission( dialogue &d )
{
    Character *u = resolve_dialogue_character( d, false );
    npc *p = resolve_dialogue_npc( d, true );
    if( u == nullptr || p == nullptr || !d.has_beta ) {
        return;
    }
    fail_mission_for_character( *p, *u, d.actor( true )->selected_mission(), &d );
}

void clear_selected_mission( dialogue &d )
{
    Character *u = resolve_dialogue_character( d, false );
    npc *p = resolve_dialogue_npc( d, true );
    if( u == nullptr || p == nullptr || !d.has_beta ) {
        return;
    }
    clear_mission_for_character( *p, *u, d.actor( true )->selected_mission(), &d );
}

bool reward_selected_mission( dialogue &d, bool require_trade )
{
    Character *u = resolve_dialogue_character( d, false );
    npc *p = resolve_dialogue_npc( d, true );
    if( u == nullptr || p == nullptr || !d.has_beta ) {
        return false;
    }
    return reward_mission_for_character( *p, *u, d.actor( true )->selected_mission(), &d,
                                         require_trade );
}

void add_mission_for_dialogue( dialogue &d, const mission_type_id &mission_id )
{
    if( !participants_live( d ) || !d.has_beta || !mission_id.is_valid() ) {
        return;
    }
    d.actor( true )->add_mission( mission_id );
    if( participants_live( d ) ) {
        talk_effect_t::update_missions( d );
    }
}

void finish_mission_by_type_for_dialogue( dialogue &d, const mission_type_id &mission_id,
        const bool success, const int step )
{
    Character *u = resolve_dialogue_character( d, false );
    if( u == nullptr || !mission_id.is_valid() ) {
        return;
    }
    const character_action_guard u_guard( *u );
    if( !u_guard ) {
        return;
    }
    const std::vector<mission *> missions = u->get_active_missions();
    for( mission *miss : missions ) {
        if( !is_live_mission( miss ) ||
            miss->get_assigned_player_id() != u->getID() ||
            miss->has_succeeded() || miss->has_failed() ||
            miss->mission_id() != mission_id ) {
            continue;
        }
        const mission_selection_identity identity = identify_mission( miss );
        const scoped_mission_operation_guard op_guard( identity );
        if( !op_guard ) {
            return;
        }
        if( step >= 0 ) {
            miss->step_complete( step );
        } else if( success ) {
            miss->wrap_up( *u );
        } else {
            miss->fail( *u );
        }
        break;
    }
    if( u_guard && participants_live( d ) ) {
        talk_effect_t::update_missions( d );
    }
}

void remove_active_mission_by_type_for_dialogue( dialogue &d, const mission_type_id &mission_id )
{
    Character *u = resolve_dialogue_character( d, false );
    if( u == nullptr || !mission_id.is_valid() ) {
        return;
    }
    const character_action_guard u_guard( *u );
    if( !u_guard ) {
        return;
    }
    const std::vector<mission *> missions = u->get_active_missions();
    for( mission *miss : missions ) {
        if( !is_live_mission( miss ) ||
            miss->get_assigned_player_id() != u->getID() ||
            miss->mission_id() != mission_id ) {
            continue;
        }
        u->remove_active_mission( *miss );
        break;
    }
    if( u_guard && participants_live( d ) ) {
        talk_effect_t::update_missions( d );
    }
}

void start_selected_training( dialogue &conversation )
{
    Character *student = resolve_dialogue_character( conversation, false );
    npc *teacher = resolve_dialogue_npc( conversation );
    if( !student || !teacher || student == teacher ||
        ( student != &get_avatar() && !conversation.const_actor( true )->has_chosen_training() ) ) {
        return;
    }
    talk_function::teach_domain domain = selected_training_domain( conversation, *teacher );
    std::vector<Character *> students{ student };
    start_training_request( *teacher, students, domain,
                            conversation.actor( true )->selected_mission(), &conversation );
    if( participants_live( conversation ) ) {
        talk_effect_t::update_missions( conversation );
    }
}

void start_selected_training_npc( dialogue &conversation )
{
    Character *teacher = resolve_dialogue_character( conversation, false );
    npc *student = resolve_dialogue_npc( conversation );
    if( !teacher || !student || teacher == student ||
        ( teacher != &get_avatar() && !conversation.const_actor( true )->has_chosen_training() ) ) {
        return;
    }
    talk_function::teach_domain domain = selected_training_domain( conversation, *student );
    std::vector<Character *> students{ student };
    start_training_request( *teacher, students, domain, nullptr, &conversation, teacher );
}

void start_selected_training_seminar( dialogue &conversation )
{
    Character *student = resolve_dialogue_character( conversation, false );
    npc *teacher = resolve_dialogue_npc( conversation );
    if( !student || !teacher || student == teacher ) {
        return;
    }
    talk_function::teach_domain domain = selected_training_domain( conversation, *teacher );
    if( student != &get_avatar() ) {
        if( student->has_native_player_control() &&
            conversation.const_actor( true )->has_chosen_training() ) {
            request_remote_seminar( conversation, *teacher, *student, domain );
        }
        return;
    }
    teacher->chatbin.store_chosen_training( domain.skill, domain.style, domain.spell,
                                            domain.prof );
    talk_function::start_training_seminar( *teacher );
}

} // namespace mission_dialogue

void talk_function::nothing( npc & )
{
}

void talk_function::assign_mission( npc &p )
{
    mission_dialogue::assign_mission_for_character(
        p, get_player_character(), p.chatbin.mission_selected, nullptr );
}

void talk_function::mission_success( npc &p )
{
    mission_dialogue::succeed_mission_for_character(
        p, get_player_character(), p.chatbin.mission_selected, nullptr );
}

void talk_function::mission_failure( npc &p )
{
    mission_dialogue::fail_mission_for_character(
        p, get_player_character(), p.chatbin.mission_selected, nullptr );
}

void talk_function::clear_mission( npc &p )
{
    mission_dialogue::clear_mission_for_character(
        p, get_player_character(), p.chatbin.mission_selected, nullptr );
}

void talk_function::mission_reward( npc &p )
{
    mission *miss = p.chatbin.mission_selected;
    if( miss == nullptr ) {
        debugmsg( "Called mission_reward with null mission" );
        return;
    }
    mission_dialogue::reward_mission_for_character(
        p, get_player_character(), miss );
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
    const shared_ptr_fast<npc> npc_lifetime = g->shared_from( p );
    // first find one nearby
    for( monster &critter : g->all_monsters() ) {
        if( p.can_mount( critter ) ) {
            // keep the horse still for some time, so that NPC can catch up to it and mount it.
            const shared_ptr_fast<monster> mount_lifetime =
                g->shared_from( critter );
            if( !npc_lifetime || !mount_lifetime ) {
                return;
            }
            p.chosen_mount = mount_lifetime;
            p.assign_activity(
                find_mount_activity_actor( mount_lifetime->uid().get_value() ) );
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
    double fault_value_multiplier = 1.0;
    for( const fault_id &fault : part.faults() ) {
        fault_value_multiplier *= clamp( fault->price_mod(), 0.0, 1.0 );
    }
    const double repair_ratio = damage_ratio +
                                ( 1.0 - damage_ratio ) * ( 1.0 - fault_value_multiplier );
    const double calculated_cost = std::ceil( pristine_value * repair_ratio * price_multiplier );
    return std::max( 1, static_cast<int>( std::min<double>( calculated_cost,
                                          std::numeric_limits<int>::max() ) ) );
}

static int add_vehicle_repair_service_cost( const int total, const int cost )
{
    if( cost >= std::numeric_limits<int>::max() - total ) {
        return std::numeric_limits<int>::max();
    }
    return total + cost;
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

static void restore_vehicle_part_to_pristine( vehicle_part &part )
{
    item restored_base( part.get_base() );
    restored_base.faults.clear();
    restored_base.set_degradation( 0 );
    restored_base.force_set_damage( 0 );
    part.set_base( std::move( restored_base ) );
}

struct vehicle_full_repair_order { // NOLINT(misc-use-internal-linkage)
    vehicle *veh = nullptr;
    std::vector<int> part_indices;
};

static std::vector<int> vehicle_full_repair_part_indices( const vehicle &veh )
{
    std::vector<int> result;
    for( int index = 0; index < veh.part_count(); ++index ) {
        if( vehicle_part_repair_is_selectable( veh.part( index ) ) ) {
            result.push_back( index );
        }
    }
    return result;
}

static int vehicle_full_repair_service_cost( const vehicle &veh,
        const std::vector<int> &part_indices, const double price_multiplier )
{
    int result = 0;
    for( const int index : part_indices ) {
        result = add_vehicle_repair_service_cost( result,
                 vehicle_part_repair_service_cost( veh.part( index ), price_multiplier ) );
    }
    return result;
}

static std::optional<vehicle_full_repair_order> valid_vehicle_full_repair_order( npc &mechanic )
{
    vehicle *veh = marked_vehicle_part_repair_target( get_map() );
    const diag_value *cost_value = mechanic.maybe_get_value( vehicle_full_repair_cost );
    const int cost = cost_value && cost_value->is_dbl() ? static_cast<int>( cost_value->dbl() ) : 0;
    const diag_value *count_value = mechanic.maybe_get_value( vehicle_full_repair_part_count );
    const diag_value *snapshot = veh ? veh->maybe_get_value( vehicle_full_repair_snapshot ) : nullptr;
    if( veh == nullptr || cost <= 0 || count_value == nullptr || !count_value->is_dbl() ||
        snapshot == nullptr || !snapshot->is_str() ||
        snapshot->str() != talk_function::vehicle_service_state_snapshot( *veh ) ) {
        return std::nullopt;
    }

    std::vector<int> part_indices = vehicle_full_repair_part_indices( *veh );
    if( static_cast<int>( part_indices.size() ) != static_cast<int>( count_value->dbl() ) ||
        vehicle_full_repair_service_cost( *veh, part_indices,
                                          vehicle_part_repair_multiplier( mechanic ) ) != cost ) {
        return std::nullopt;
    }
    return vehicle_full_repair_order{ veh, std::move( part_indices ) };
}

static void refund_vehicle_full_repair( npc &mechanic, const std::string &status )
{
    const diag_value *cost_value = mechanic.maybe_get_value( vehicle_full_repair_cost );
    const int cost = cost_value && cost_value->is_dbl() ? static_cast<int>( cost_value->dbl() ) : 0;
    if( cost > 0 ) {
        mechanic.op_of_u.owed += cost;
    }
    if( vehicle *veh = marked_vehicle_part_repair_target( get_map() ) ) {
        veh->remove_value( vehicle_full_repair_snapshot );
    }
    clear_vehicle_full_repair_quote( mechanic );
    mechanic.set_value( vehicle_full_repair_status, status );
    mechanic.remove_effect( effect_currently_busy );
}

void talk_function::quote_vehicle_full_repair( npc &p )
{
    clear_vehicle_full_repair_quote( p );
    vehicle *veh = marked_vehicle_part_repair_target( get_map() );
    if( veh == nullptr ) {
        p.set_value( vehicle_full_repair_status, "no_vehicle" );
        return;
    }

    veh->remove_value( vehicle_full_repair_snapshot );
    const std::vector<int> part_indices = vehicle_full_repair_part_indices( *veh );
    p.set_value( vehicle_full_repair_vehicle_name, veh->name );
    p.set_value( vehicle_full_repair_part_count, static_cast<int>( part_indices.size() ) );
    if( part_indices.empty() ) {
        p.set_value( vehicle_full_repair_status, "no_repairs" );
        return;
    }

    const int cost = vehicle_full_repair_service_cost( *veh, part_indices,
                     vehicle_part_repair_multiplier( p ) );
    if( cost <= 0 ) {
        p.set_value( vehicle_full_repair_status, "no_value" );
        return;
    }

    constexpr time_duration maximum_repair_time = 3_hours;
    time_duration repair_time = 0_seconds;
    for( const int index : part_indices ) {
        repair_time = std::min( maximum_repair_time,
                                repair_time + std::min( maximum_repair_time,
                                        vehicle_part_repair_service_time( veh->part( index ), p ) ) );
    }
    veh->set_value( vehicle_full_repair_snapshot,
                    talk_function::vehicle_service_state_snapshot( *veh ) );
    p.set_value( vehicle_full_repair_valid, 1 );
    p.set_value( vehicle_full_repair_cost, cost );
    p.set_value( vehicle_full_repair_cost_text, format_money( cost ) );
    p.set_value( vehicle_full_repair_time, to_turns<int>( repair_time ) );
    p.set_value( vehicle_full_repair_time_text, to_string_approx( repair_time ) );
    p.set_value( vehicle_full_repair_status, "quoted" );
}

void talk_function::start_vehicle_full_repair( npc &p )
{
    const std::optional<vehicle_full_repair_order> order = valid_vehicle_full_repair_order( p );
    const diag_value *time_value = p.maybe_get_value( vehicle_full_repair_time );
    if( !order || time_value == nullptr || !time_value->is_dbl() || time_value->dbl() <= 0 ) {
        refund_vehicle_full_repair( p, "invalidated" );
        add_msg( m_bad,
                 _( "The vehicle changed before refurbishment could begin.  %s credits you for the payment." ),
                 p.get_name() );
        return;
    }
    const time_duration repair_time = time_duration::from_turns( static_cast<int>
                                      ( time_value->dbl() ) );
    get_player_character().assign_activity( vehicle_part_repair_service_activity_actor(
            repair_time, p.getID(), true ) );
    p.add_effect( effect_currently_busy, repair_time );
    p.set_value( vehicle_full_repair_status, "repairing" );
    add_msg( m_info, _( "%s begins refurbishing the entire vehicle." ), p.get_name() );
}

void talk_function::finish_vehicle_full_repair( npc &p )
{
    const std::optional<vehicle_full_repair_order> order = valid_vehicle_full_repair_order( p );
    if( !order ) {
        refund_vehicle_full_repair( p, "invalidated" );
        add_msg( m_bad,
                 _( "The vehicle changed while refurbishment was underway.  %s credits you for the payment." ),
                 p.get_name() );
        return;
    }

    const std::string vehicle_name = order->veh->name;
    const int part_count = static_cast<int>( order->part_indices.size() );
    order->veh->remove_value( vehicle_full_repair_snapshot );
    for( const int index : order->part_indices ) {
        restore_vehicle_part_to_pristine( order->veh->part( index ) );
    }
    order->veh->refresh();
    clear_vehicle_full_repair_quote( p );
    p.set_value( vehicle_full_repair_status, "complete" );
    p.remove_effect( effect_currently_busy );
    add_msg( m_good, _( "%1$s completely refurbishes the %2$s, restoring %3$d parts." ),
             p.get_name(), vehicle_name, part_count );
}

void talk_function::cancel_vehicle_full_repair( npc &p )
{
    refund_vehicle_full_repair( p, "cancelled" );
    add_msg( m_info,
             _( "%s stops refurbishing the vehicle and credits you for the payment." ),
             p.get_name() );
}

static double vehicle_part_install_multiplier( const npc &mechanic )
{
    const diag_value *value = mechanic.maybe_get_value( vehicle_part_install_price_multiplier );
    return value && value->is_dbl() && value->dbl() > 0.0 ? value->dbl() : 1.0;
}

static double vehicle_part_service_skill_factor( const std::map<skill_id, int> &skills )
{
    int highest_skill = 0;
    for( const std::pair<const skill_id, int> &skill_requirement : skills ) {
        highest_skill = std::max( highest_skill, skill_requirement.second );
    }
    const int extra_skill_count = std::max( 0, static_cast<int>( skills.size() ) - 1 );
    return 1.0 + 0.10 * highest_skill + 0.05 * extra_skill_count;
}

static int ceil_cents_to_dollar( const double cents )
{
    if( cents <= 0.0 ) {
        return 0;
    }
    const double capped = std::min<double>( cents, std::numeric_limits<int>::max() - 99 );
    const int rounded_cents = static_cast<int>( std::ceil( capped ) );
    return ( ( rounded_cents + 99 ) / 100 ) * 100;
}

static int vehicle_part_service_labor_cost( const std::map<skill_id, int> &skills,
        const time_duration &service_time, const double multiplier )
{
    if( multiplier <= 0.0 ) {
        return 0;
    }
    const double base_labor = std::max( 200.0, to_hours<double>( service_time ) * 1200.0 );
    const double calculated = base_labor * vehicle_part_service_skill_factor( skills ) * multiplier;
    return ceil_cents_to_dollar( calculated );
}

namespace
{

struct vehicle_part_install_candidate {
    item_location location;
    bool supplied_by_mechanic = false;
    int item_cost = 0;
    int labor_cost = 0;
    int total_cost = 0;
};

} // namespace

static std::optional<std::string> choose_vehicle_part_variant( const vpart_info &part )
{
    if( part.variants.size() <= 1 ) {
        return part.variant_default;
    }
    uilist menu;
    menu.text = _( "Choose cosmetic variant:" );
    std::vector<std::string> variants;
    for( const std::pair<const std::string, vpart_variant> &entry : part.variants ) {
        variants.push_back( entry.first );
        menu.addentry( static_cast<int>( variants.size() - 1 ), true, MENU_AUTOASSIGN,
                       entry.second.get_label() );
    }
    menu.query();
    if( menu.ret < 0 || menu.ret >= static_cast<int>( variants.size() ) ) {
        return std::nullopt;
    }
    return variants[menu.ret];
}

static std::optional<int> choose_vehicle_part_direction( map &here, vehicle &veh,
        const point_rel_ms &mount, const vpart_info &part )
{
    if( !( part.has_flag( VPFLAG_CONE_LIGHT ) || part.has_flag( VPFLAG_WIDE_CONE_LIGHT ) ||
           part.has_flag( VPFLAG_HALF_CIRCLE_LIGHT ) ) ) {
        return 0;
    }

    avatar &player_character = get_avatar();
    const tripoint_rel_ms old_view_offset = player_character.view_offset;
    const point_rel_ms translated_mount = veh.coord_translate( mount );
    const tripoint_bub_ms origin = veh.pos_bub( here ) + translated_mount;
    player_character.view_offset = origin - player_character.pos_bub( here );
    popup( _( "Choose a facing direction for the new %s and confirm, or cancel the installation." ),
           part.name() );
    const std::optional<tripoint_bub_ms> chosen = g->look_around();
    player_character.view_offset = old_view_offset;
    if( !chosen || ( *chosen - origin ).xy() == point_rel_ms::zero ) {
        return std::nullopt;
    }
    const point_rel_ms delta = ( *chosen - origin ).xy();
    const units::angle direction = normalize( atan2( delta.raw() ) - veh.face.dir() );
    return static_cast<int>( std::lround( units::to_degrees( direction ) ) );
}

static std::vector<vehicle_part_install_candidate> vehicle_part_sources(
    avatar &player_character, npc &mechanic, const vpart_info &part,
    const time_duration &install_time, const trade_ui::item_locations_t &trade_items )
{
    std::vector<vehicle_part_install_candidate> candidates;
    const int labor_cost = vehicle_part_service_labor_cost(
                               part.install_skills, install_time,
                               vehicle_part_install_multiplier( mechanic ) );
    const auto append_candidates = [&]( const std::vector<item_location> &locations,
    const bool supplied_by_mechanic ) {
        for( const item_location &location : locations ) {
            if( !location || location->typeId() != part.base_item ) {
                continue;
            }
            const int item_cost = supplied_by_mechanic ? std::max( 0,
                                  npc_trading::trading_price( player_character, mechanic,
            { location, 1 } ) ) : 0;
            candidates.push_back( { location, supplied_by_mechanic, item_cost, labor_cost,
                                    add_vehicle_repair_service_cost( item_cost, labor_cost ) } );
        }
    };
    append_candidates( trade_items.you, false );
    append_candidates( trade_items.trader, true );
    return candidates;
}

static std::optional<vehicle_part_install_candidate> choose_vehicle_part_source(
    const std::vector<vehicle_part_install_candidate> &candidates,
    const time_duration &install_time )
{
    if( candidates.empty() ) {
        return std::nullopt;
    }
    if( candidates.size() == 1 ) {
        return candidates.front();
    }

    uilist menu;
    menu.text = _( "Choose the exact part and supplier:" );
    for( size_t index = 0; index < candidates.size(); ++index ) {
        const vehicle_part_install_candidate &candidate = candidates[index];
        const std::string source = candidate.supplied_by_mechanic ? _( "mechanic" ) : _( "yours" );
        const std::string price = candidate.supplied_by_mechanic ?
                                  string_format( _( "part %1$s + labor %2$s = %3$s" ),
                                          format_money( candidate.item_cost ),
                                          format_money( candidate.labor_cost ),
                                          format_money( candidate.total_cost ) ) :
                                  string_format( _( "labor %s" ), format_money( candidate.labor_cost ) );
        menu.addentry( static_cast<int>( index ), true, MENU_AUTOASSIGN,
                       string_format( _( "%1$s: %2$s — %3$s; %4$s" ), source,
                                      candidate.location->tname(), price,
                                      to_string_approx( install_time ) ) );
    }
    menu.query();
    if( menu.ret < 0 || menu.ret >= static_cast<int>( candidates.size() ) ) {
        return std::nullopt;
    }
    return candidates[menu.ret];
}

static std::vector<vehicle_part_install_candidate> choose_vehicle_part_batch_sources(
    const std::vector<vehicle_part_install_candidate> &candidates, const size_t count )
{
    // A vehicle part can contain another matching item.  Reserve only disjoint item trees.
    std::vector<vehicle_part_install_candidate> sources;
    std::unordered_set<const item *> seen;
    for( const vehicle_part_install_candidate &candidate : candidates ) {
        item_location parent = candidate.location;
        bool nested = false;
        while( parent.where() == item_location::type::container ) {
            parent = parent.parent_item();
            if( parent && std::any_of( candidates.begin(), candidates.end(),
            [&parent]( const vehicle_part_install_candidate & other ) {
            return other.location == parent;
        } ) ) {
                nested = true;
                break;
            }
        }
        if( !nested && seen.insert( &*candidate.location ).second ) {
            sources.push_back( candidate );
        }
    }
    if( sources.empty() ) {
        popup( _( "Neither side has a tradable vehicle part available for installation." ) );
        return {};
    }
    const size_t install_count = std::min( count, sources.size() );
    if( install_count < count ) {
        uilist shortage_menu;
        shortage_menu.text = string_format(
                                 _( "This area needs %1$d parts, but only %2$d are available between you and "
                                    "the mechanic.  Installing these would leave %3$d compatible tiles unchanged." ),
                                 count, install_count, count - install_count );
        shortage_menu.addentry( 0, true, MENU_AUTOASSIGN, _( "Cancel installation" ) );
        shortage_menu.addentry( 1, true, MENU_AUTOASSIGN,
                                string_format( _( "Install as many as possible (%d parts)" ), install_count ) );
        shortage_menu.query();
        if( shortage_menu.ret != 1 ) {
            return {};
        }
    }

    uilist menu;
    menu.text = _( "Choose supplies for the batch installation (one part per position):" );
    std::vector<std::vector<vehicle_part_install_candidate>> orders;
    for( const bool shop_first : {
             false, true
         } ) {
        std::vector<vehicle_part_install_candidate> order = sources;
        std::stable_sort( order.begin(), order.end(),
                          [shop_first]( const vehicle_part_install_candidate & lhs,
        const vehicle_part_install_candidate & rhs ) {
            if( lhs.supplied_by_mechanic != rhs.supplied_by_mechanic ) {
                return lhs.supplied_by_mechanic == shop_first;
            }
            return lhs.total_cost < rhs.total_cost;
        } );
        order.resize( install_count );
        int64_t total_cost = 0;
        int shop_count = 0;
        for( const vehicle_part_install_candidate &source : order ) {
            total_cost += source.total_cost;
            shop_count += source.supplied_by_mechanic ? 1 : 0;
        }
        const bool valid_cost = total_cost <= std::numeric_limits<int>::max();
        menu.addentry( static_cast<int>( orders.size() ), valid_cost, MENU_AUTOASSIGN,
                       valid_cost ? string_format( _( "%1$s: %2$d yours, %3$d from mechanic; total %4$s" ),
                               shop_first ? _( "Buy from mechanic first" ) : _( "Use your parts first" ),
                               install_count - shop_count, shop_count, format_money( static_cast<int>( total_cost ) ) ) :
                       _( "The total price is too high.  Choose a smaller area." ) );
        orders.push_back( std::move( order ) );
    }
    menu.query();
    if( menu.ret < 0 || menu.ret >= static_cast<int>( orders.size() ) ) {
        return {};
    }
    return orders[menu.ret];
}

static std::optional<tripoint_abs_ms> vehicle_service_output_position( map &here,
        const npc &mechanic )
{
    const std::unordered_set<tripoint_abs_ms> candidates = zone_manager::get_manager().get_near(
                zone_type_VEHICLE_SERVICE_OUTPUT, mechanic.pos_abs(), MAX_VIEW_DISTANCE, nullptr,
                mechanic.get_fac_id() );
    std::optional<tripoint_abs_ms> result;
    size_t result_item_count = std::numeric_limits<size_t>::max();
    for( const tripoint_abs_ms &candidate : candidates ) {
        const tripoint_bub_ms local = here.get_bub( candidate );
        if( !here.inbounds( local ) || here.furn( local ) != furn_f_counter ) {
            continue;
        }
        const size_t item_count = here.i_at( local ).size();
        if( !result || item_count < result_item_count ) {
            result = candidate;
            result_item_count = item_count;
        }
    }
    return result;
}

static bool vehicle_service_output_is_valid( map &here, const npc &mechanic,
        const tripoint_abs_ms &output )
{
    const tripoint_bub_ms local = here.get_bub( output );
    return here.inbounds( local ) && here.furn( local ) == furn_f_counter &&
           zone_manager::get_manager().has( zone_type_VEHICLE_SERVICE_OUTPUT, output,
                                            mechanic.get_fac_id() );
}

void talk_function::select_vehicle_part_service( npc &p )
{
    map &here = get_map();
    avatar &player_character = get_avatar();
    p.set_value( vehicle_part_service_status, "cancelled" );
    vehicle *veh = marked_vehicle_part_repair_target( here );
    if( veh == nullptr ) {
        p.set_value( vehicle_part_service_status, "no_vehicle" );
        popup( _( "No eligible player vehicle is marked for service." ) );
        return;
    }

    // Checkout performs these steps too.  Finish them before retaining item locations
    // so a restock cannot remove reserved stock while its trade-ignore flags are set.
    p.shop_restock();
    p.drop_invalid_inventory();
    const trade_ui::item_locations_t trade_items = trade_ui::get_item_locations( player_character, p );
    std::set<itype_id> available_base_items;
    for( const item_location &location : trade_items.you ) {
        if( location ) {
            available_base_items.insert( location->typeId() );
        }
    }
    for( const item_location &location : trade_items.trader ) {
        if( location ) {
            available_base_items.insert( location->typeId() );
        }
    }
    const std::optional<veh_interact::service_selection> selection =
        veh_interact::select_service_action_at_grid( here, *veh, available_base_items,
    []( const map &, const vehicle_part & part ) {
        return vehicle_part_repair_is_selectable( part );
    } );
    if( !selection ) {
        return;
    }

    const std::string vehicle_snapshot = vehicle_service_state_snapshot( *veh );
    if( selection->action == veh_interact::service_action::repair ) {
        if( selection->part_index < 0 || selection->part_index >= veh->part_count() ) {
            p.set_value( vehicle_part_service_status, "invalidated" );
            return;
        }
        const vehicle_part &part = veh->part( selection->part_index );
        const int cost = vehicle_part_repair_service_cost( part,
                         vehicle_part_repair_multiplier( p ) );
        if( cost <= 0 ) {
            p.set_value( vehicle_part_service_status, "no_value" );
            popup( _( "The selected repair has no payable post-Cataclysm value." ) );
            return;
        }
        const time_duration repair_time = vehicle_part_repair_service_time( part, p );
        if( !query_yn( _( "Repair the %1$s's %2$s to pristine condition for %3$s?  "
                          "Estimated time: %4$s." ), veh->name, part.name(), format_money( cost ),
                       to_string_approx( repair_time ) ) ) {
            return;
        }
        if( !npc_trading::pay_npc( p, cost ) ) {
            p.set_value( vehicle_part_service_status, "payment_cancelled" );
            return;
        }
        const bool order_valid = marked_vehicle_part_repair_target( here ) == veh &&
                                 vehicle_service_state_snapshot( *veh ) == vehicle_snapshot &&
                                 selection->part_index < veh->part_count() &&
                                 vehicle_part_repair_is_selectable( veh->part( selection->part_index ) ) &&
                                 vehicle_part_repair_service_cost( veh->part( selection->part_index ),
                                         vehicle_part_repair_multiplier( p ) ) == cost;
        if( !order_valid ) {
            p.op_of_u.owed += cost;
            p.set_value( vehicle_part_service_status, "invalidated" );
            add_msg( m_bad, _( "The repair order changed during checkout.  %s credits the full payment." ),
                     p.get_name() );
            return;
        }
        player_character.assign_activity( vehicle_part_repair_service_activity_actor(
                                              repair_time, p.getID(), veh->pos_abs(), vehicle_snapshot,
                                              selection->part_index, cost ) );
        p.add_effect( effect_currently_busy, repair_time );
        p.set_value( vehicle_part_service_status, "repairing" );
        add_msg( m_info, _( "%1$s begins repairing the %2$s's %3$s." ),
                 p.get_name(), veh->name, part.name() );
        return;
    }

    if( selection->action == veh_interact::service_action::remove ) {
        if( selection->part_index < 0 || selection->part_index >= veh->part_count() ||
            veh_interact::service_removal_denial( *veh, selection->part_index ) ) {
            p.set_value( vehicle_part_service_status, "invalidated" );
            popup( _( "The selected vehicle part cannot be removed by the mechanic." ) );
            return;
        }
        const std::optional<tripoint_abs_ms> output = vehicle_service_output_position( here, p );
        if( !output ) {
            p.set_value( vehicle_part_service_status, "no_output" );
            popup( _( "No valid vehicle service output zone is available for the removed items." ) );
            return;
        }
        const vehicle_part &part = veh->part( selection->part_index );
        const vpart_info &part_info = part.info();
        const time_duration removal_time = std::max( 1_seconds, part_info.removal_time( p ) );
        const int cost = vehicle_part_service_labor_cost(
                             part_info.removal_skills, removal_time,
                             vehicle_part_install_multiplier( p ) );
        const bool disable_flyable = veh->would_removal_prevent_flyable( part, player_character );
        if( disable_flyable &&
            !query_yn( _( "Removing this part will make the vehicle no longer flightworthy.  Continue?" ) ) ) {
            return;
        }
        if( veh->part_count_real() <= 1 &&
            !query_yn( _( "Removing this final part will completely dismantle the vehicle.  Continue?" ) ) ) {
            return;
        }
        if( !query_yn( _( "Remove the %1$s from the %2$s for %3$s?  All recovered items will be "
                          "placed on the front counter.  Estimated time: %4$s." ),
                       part.name(), veh->name, format_money( cost ),
                       to_string_approx( removal_time ) ) ) {
            return;
        }
        if( cost > 0 && !npc_trading::pay_npc( p, cost ) ) {
            p.set_value( vehicle_part_service_status, "payment_cancelled" );
            return;
        }
        const bool order_valid = marked_vehicle_part_repair_target( here ) == veh &&
                                 vehicle_service_state_snapshot( *veh ) == vehicle_snapshot &&
                                 selection->part_index < veh->part_count() &&
                                 !veh_interact::service_removal_denial( *veh, selection->part_index ) &&
                                 vehicle_service_output_is_valid( here, p, *output );
        if( !order_valid ) {
            p.op_of_u.owed += cost;
            p.set_value( vehicle_part_service_status, "invalidated" );
            add_msg( m_bad, _( "The removal order changed during checkout.  %s credits the full payment." ),
                     p.get_name() );
            return;
        }
        player_character.assign_activity( vehicle_part_remove_service_activity_actor(
                                              removal_time, p.getID(), veh->pos_abs(), vehicle_snapshot,
                                              selection->part_index, cost, *output, disable_flyable ) );
        p.add_effect( effect_currently_busy, removal_time );
        p.set_value( vehicle_part_service_status, "removing" );
        add_msg( m_info, _( "%1$s begins removing the %2$s from the %3$s." ),
                 p.get_name(), part.name(), veh->name );
        return;
    }

    const vpart_info &part = selection->part_id.obj();
    const time_duration install_time = std::max( 1_seconds, part.install_time( p ) );
    const bool batch = selection->action == veh_interact::service_action::install_batch;
    std::vector<point_rel_ms> mounts = batch ? selection->mounts :
                                       std::vector<point_rel_ms> { selection->mount };
    if( mounts.empty() ) {
        return;
    }
    const std::vector<vehicle_part_install_candidate> sources = vehicle_part_sources(
                player_character, p, part, install_time, trade_items );
    std::vector<vehicle_part_install_candidate> candidates;
    if( batch ) {
        candidates = choose_vehicle_part_batch_sources( sources, mounts.size() );
    } else if( const std::optional<vehicle_part_install_candidate> candidate =
                   choose_vehicle_part_source( sources, install_time ) ) {
        candidates.push_back( *candidate );
    }
    if( candidates.empty() ) {
        return;
    }
    mounts.resize( candidates.size() );
    if( to_turns<int64_t>( install_time ) >
        std::numeric_limits<int>::max() / 100 / static_cast<int64_t>( candidates.size() ) ) {
        popup( _( "The installation would take too long.  Choose a smaller area." ) );
        return;
    }
    const time_duration total_time = install_time * static_cast<int>( candidates.size() );
    int64_t sum_cost = 0;
    std::vector<vehicle_part_install_service_entry> entries;
    for( size_t index = 0; index < candidates.size(); ++index ) {
        const vehicle_part_install_candidate &candidate = candidates[index];
        sum_cost += candidate.total_cost;
        entries.push_back( { mounts[index], *candidate.location, candidate.supplied_by_mechanic,
                             candidate.total_cost } );
    }
    if( sum_cost > std::numeric_limits<int>::max() ||
        static_cast<int64_t>( p.op_of_u.owed ) - sum_cost < std::numeric_limits<int>::min() ) {
        popup( _( "The total price is too high.  Choose a smaller area." ) );
        return;
    }
    if( !vehicle_part_install_service_activity_actor::can_install_order(
            here, *veh, selection->part_id, entries ) ) {
        popup( _( "These parts cannot all be installed together as one order.  "
                  "Choose a smaller area or a different part." ) );
        return;
    }
    const int total_cost = static_cast<int>( sum_cost );
    const std::optional<std::string> variant = choose_vehicle_part_variant( part );
    if( !variant ) {
        return;
    }
    const std::optional<int> direction = choose_vehicle_part_direction(
            here, *veh, selection->mount, part );
    if( !direction ) {
        return;
    }
    if( veh->is_foldable() && !part.folded_volume &&
        !query_yn( _( "Installing this part will make the vehicle unfoldable.  Continue?" ) ) ) {
        return;
    }
    const bool disable_flyable = veh->would_install_prevent_flyable( part, player_character );
    if( disable_flyable &&
        !query_yn(
            _( "Installing this part will make the vehicle no longer flightworthy.  Continue?" ) ) ) {
        return;
    }
    const std::string confirmation = batch ?
                                     string_format( _( "Install %1$d copies of %2$s in the selected area of the %3$s "
                                             "for %4$s?  Estimated total time: %5$s." ),
                                             entries.size(), part.name(), veh->name, format_money( total_cost ),
                                             to_string_approx( total_time ) ) :
                                     string_format( _( "Install %1$s into the %2$s for %3$s?  Estimated time: %4$s." ),
                                             candidates.front().location->tname(), veh->name, format_money( total_cost ),
                                             to_string_approx( total_time ) );
    if( !query_yn( confirmation ) ) {
        return;
    }

    std::vector<item *> protected_trade_items;
    std::unordered_set<item *> protected_trade_item_set;
    const auto protect_item = [&]( item * protected_item ) {
        if( protected_trade_item_set.insert( protected_item ).second &&
            !protected_item->has_var( VAR_TRADE_IGNORE ) ) {
            protected_item->set_var( VAR_TRADE_IGNORE, 1 );
            protected_trade_items.push_back( protected_item );
        }
    };
    const auto protect_location_tree = [&]( item_location protected_location ) {
        while( protected_location ) {
            protect_item( &*protected_location );
            for( item *contained : protected_location->all_items_ptr() ) {
                protect_item( contained );
            }
            if( protected_location.where() != item_location::type::container ) {
                break;
            }
            protected_location = protected_location.parent_item();
        }
    };
    for( const vehicle_part_install_candidate &candidate : candidates ) {
        protect_location_tree( candidate.location );
    }
    const bool paid = total_cost <= 0 || npc_trading::pay_npc( p, total_cost );
    for( item *protected_item : protected_trade_items ) {
        protected_item->erase_var( VAR_TRADE_IGNORE );
    }
    if( !paid ) {
        p.set_value( vehicle_part_service_status, "payment_cancelled" );
        return;
    }

    const bool valid_sources = std::all_of( candidates.begin(), candidates.end(),
    [&part]( const vehicle_part_install_candidate & candidate ) {
        return candidate.location && candidate.location->typeId() == part.base_item;
    } );
    const bool order_valid = valid_sources &&
                             marked_vehicle_part_repair_target( here ) == veh &&
                             vehicle_service_state_snapshot( *veh ) == vehicle_snapshot &&
                             vehicle_part_install_service_activity_actor::can_install_order(
                                 here, *veh, selection->part_id, entries );
    if( !order_valid ) {
        if( total_cost > 0 ) {
            p.op_of_u.owed += total_cost;
        }
        p.set_value( vehicle_part_service_status, "invalidated" );
        add_msg( m_bad,
                 _( "The installation order changed during checkout.  %s credits the full payment." ),
                 p.get_name() );
        return;
    }

    for( size_t index = 0; index < candidates.size(); ++index ) {
        item &reserved_part = entries[index].reserved_part;
        reserved_part = *candidates[index].location;
        candidates[index].location.remove_item();
        reserved_part.erase_var( VAR_TRADE_IGNORE );
        reserved_part.set_owner( player_character );
    }
    player_character.assign_activity( vehicle_part_install_service_activity_actor(
                                          total_time, p.getID(), veh->pos_abs(), vehicle_snapshot,
                                          selection->part_id, std::move( entries ),
                                          *variant, *direction, disable_flyable ) );
    p.add_effect( effect_currently_busy, total_time );
    p.set_value( vehicle_part_service_status, "installing" );
    add_msg( m_info, _( "%1$s begins installing %2$d × %3$s into the %4$s." ),
             p.get_name(), candidates.size(), part.name(), veh->name );
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
    p.rules.enable_override( ally_rule::allow_sleep );
    p.rules.set_override( ally_rule::allow_sleep );
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
        std::optional<item> source_item = *bionic.get_item();
        // The patient paid the purchase price for this CBM (see bionic_install_price):
        // transfer ownership to the payer, otherwise the salvaged module dropped on
        // uninstall would still belong to the doctor's faction and picking it up would
        // be treated as theft.
        if( !source_item->is_owned_by( patient ) ) {
            source_item->set_owner( patron );
        }
        bionic.remove_item();
        patient.install_bionics( it, p, false, 20, source_item );
    }
}

void talk_function::bionic_install( npc &p )
{
    Character &pc = get_player_character();
    bionic_install( p, pc );
}

void talk_function::bionic_install( npc &p, Character &patient )
{
    bionic_install_common( p, get_player_character(), patient );
}

void talk_function::bionic_install_allies( npc &p )
{
    npc *patient = pick_follower();
    if( !patient ) {
        return;
    }
    bionic_install( p, *patient );
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
    bionic_remove( p, get_player_character() );
}

void talk_function::bionic_remove( npc &p, Character &patient )
{
    bionic_remove_common( p, patient );
}

void talk_function::bionic_remove_allies( npc &p )
{
    npc *patient = pick_follower();
    if( !patient ) {
        return;
    }
    bionic_remove( p, *patient );
}

void talk_function::give_equipment( npc &p )
{
    give_equipment( p, get_player_character() );
}

void talk_function::give_equipment( npc &p, Character &u )
{
    give_equipment_allowance( p, u, 0 );
}

void talk_function::give_equipment_allowance( npc &p, int allowance )
{
    give_equipment_allowance( p, get_player_character(), allowance );
}

void talk_function::give_equipment_allowance( npc &p, Character &player_character, int allowance )
{
    npc_opinion &op = ( &player_character == &get_avatar() &&
                        &p.opinion_of( player_character.getID() ) != &p.op_of_u &&
                        p.opinion_of( player_character.getID() ).owed == 0 &&
                        p.op_of_u.owed != 0 )
                      ? p.op_of_u
                      : p.opinion_of( player_character.getID() );
    std::vector<item_pricing> giving = npc_trading::init_selling( p );
    int chosen = -1;
    while( chosen == -1 && !giving.empty() ) {
        int index = rng( 0, giving.size() - 1 );
        if( giving[index].price < op.owed + allowance ) {
            chosen = index;
        } else {
            giving.erase( giving.begin() + index );
        }
    }
    if( giving.empty() ) {
        if( &player_character == &get_avatar() ) {
            popup( _( "%s has nothing to give!" ), p.get_name() );
        }
        return;
    }
    if( chosen < 0 || static_cast<size_t>( chosen ) >= giving.size() ) {
        debugmsg( "Chosen index is outside of available item range!" );
        chosen = 0;
    }
    item it = *giving[chosen].loc.get_item();
    giving[chosen].loc.remove_item();
    if( &player_character == &get_avatar() ) {
        popup( _( "%1$s gives you a %2$s." ), p.get_name(), it.tname() );
    }
    it.set_owner( player_character );
    player_character.i_add( it );
    allowance -= giving[chosen].price;
    if( allowance < 0 ) {
        op.owed += allowance;
    }
    p.add_effect( effect_asked_for_item, 3_hours );
}

void talk_function::lesser_give_aid( npc &p )
{
    lesser_give_aid( p, get_player_character() );
}

void talk_function::lesser_give_aid( npc &p, Character &player_character )
{
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
    lesser_give_all_aid( p, get_player_character() );
}

void talk_function::lesser_give_all_aid( npc &p, Character &player_character )
{
    lesser_give_aid( p, player_character ); // Provide lesser aid to the player first

    for( npc &guy : g->all_npcs() ) {
        if( guy.is_walking_with() &&
            rl_dist( guy.pos_bub(), player_character.pos_bub() ) < pickup_range ) {
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
    give_aid( p, get_player_character() );
}

void talk_function::give_aid( npc &p, Character &player_character )
{
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
    give_all_aid( p, get_player_character() );
}

void talk_function::give_all_aid( npc &p, Character &player_character )
{
    give_aid( p, player_character ); // Provide aid to the player first

    for( npc &guy : g->all_npcs() ) {
        if( guy.is_walking_with() &&
            rl_dist( guy.pos_bub(), player_character.pos_bub() ) < pickup_range ) {
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
    repair_bionic_limbs( p, get_player_character() );
}

void talk_function::repair_bionic_limbs( npc &p, Character &player_character )
{
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
    bool const ret = npc_trading::pay_npc( p, player_character, price );
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
    const int choice = hair_menu.ret;
    if( choice <= 0 || static_cast<std::size_t>( choice ) > hair_muts.size() ) {
        return;
    }
    if( player_character.has_trait( cur_hair.trait ) ) {
        player_character.remove_mutation( cur_hair.trait, true );
    }
    const trait_and_var &chosen = hair_muts[choice - 1];
    player_character.set_mutation( chosen.trait, chosen.trait->variant( chosen.variant ) );
    add_msg( m_info, _( "You get a trendy new cut!" ) );
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
    buy_haircut( p, get_player_character() );
}

void talk_function::buy_haircut( npc &p, Character &player_character )
{
    player_character.add_morale( morale_haircut, 5, 5, 720_minutes, 3_minutes );
    player_character.assign_activity( wait_npc_activity_actor( 20_minutes, p.get_name() ) );
    add_msg( m_good, _( "%s gives you a decent haircut…" ), p.get_name() );
}

void talk_function::buy_shave( npc &p )
{
    buy_shave( p, get_player_character() );
}

void talk_function::buy_shave( npc &p, Character &player_character )
{
    player_character.add_morale( morale_shave, 10, 10, 360_minutes, 3_minutes );
    player_character.assign_activity( wait_npc_activity_actor( 5_minutes, p.get_name() ) );
    add_msg( m_good, _( "%s gives you a decent shave…" ), p.get_name() );
}

void talk_function::morale_chat_activity( npc &p )
{
    morale_chat_activity( p, get_player_character() );
}

void talk_function::morale_chat_activity( npc &p, Character &player_character )
{
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
    follow( p, get_player_character() );
}

void talk_function::follow( npc &p, Character &u )
{
    g->add_npc_follower( p.getID() );
    if( avatar *av = u.as_avatar() ) {
        av->follower_ids.insert( p.getID() );
    }
    p.set_attitude( NPCATT_FOLLOW );
    p.set_fac( faction_your_followers );
    p.set_mission( NPC_MISSION_NULL );
    p.goal = npc::no_goal_point;
    p.guard_pos = std::nullopt;
    p.clear_ai_guard_pos();
    p.clear_committed_goal();
    u.cash += p.cash;
    p.cash = 0;
    if( !p.custom_profession.empty() ) {
        p.custom_profession.clear();
    }
}

void talk_function::follow_only( npc &p )
{
    p.set_attitude( NPCATT_FOLLOW );
    p.set_mission( NPC_MISSION_NULL );
    p.goal = npc::no_goal_point;
    p.guard_pos = std::nullopt;
    p.clear_ai_guard_pos();
    p.clear_committed_goal();
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
    return drop_stolen_item( cur_item, p, get_player_character() );
}

bool talk_function::drop_stolen_item( item &cur_item, npc &p, Character &player_character )
{
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
            changed |= drop_stolen_item( *contained, p, player_character );
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
    drop_stolen_item( p, get_player_character() );
}

void talk_function::drop_stolen_item( npc &p, Character &player_character )
{
    bool dropped = false;
    for( item *&elem : player_character.inv_dump() ) {
        dropped |= drop_stolen_item( *elem, p, player_character );
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

void talk_function::player_weapon_away( npc &p )
{
    player_weapon_away( p, get_player_character() );
}

void talk_function::player_weapon_away( npc &/*p*/, Character &player_character )
{
    std::optional<bionic *> bionic_weapon = player_character.find_bionic_by_uid(
            player_character.get_weapon_bionic_uid() );
    if( bionic_weapon ) {
        player_character.deactivate_bionic( **bionic_weapon );
        return;
    }

    player_character.i_add( player_character.remove_weapon() );
}

void talk_function::drop_player_weapon( Character &player_character )
{
    map &here = get_map();
    item weap = player_character.remove_weapon();
    drop_on_map( player_character, item_drop_reason::deliberate, {weap}, &here,
                 player_character.pos_bub( here ) );
}

void talk_function::player_weapon_drop( npc &p )
{
    player_weapon_drop( p, get_player_character() );
}

void talk_function::player_weapon_drop( npc &/*p*/, Character &player_character )
{
    drop_player_weapon( player_character );
}

void talk_function::lead_to_safety( npc &p )
{
    lead_to_safety( p, get_player_character() );
}

void talk_function::lead_to_safety( npc &p, Character &u )
{
    mission *reach_safety_mission = mission::reserve_new( mission_MISSION_REACH_SAFETY,
                                    character_id() );
    reach_safety_mission->assign( u );
    p.goal = reach_safety_mission->get_target();
    p.set_attitude( NPCATT_LEAD );
}

bool npc_trading::pay_npc( npc &np, Character &payer, int cost )
{
    npc_opinion &op = np.opinion_of( payer.getID() );
    if( op.owed >= cost ) {
        op.owed -= cost;
        return true;
    }
    if( &payer == &get_avatar() && &op != &np.op_of_u && np.op_of_u.owed >= cost ) {
        np.op_of_u.owed -= cost;
        return true;
    }
    if( cost <= 0 && np.will_exchange_items_freely() ) {
        return true;
    }
    if( &payer != &get_avatar() ) {
        return false;
    }
    return npc_trading::trade( np, cost, _( "Pay:" ) );
}

bool npc_trading::pay_npc( npc &np, int cost )
{
    return pay_npc( np, get_player_character(), cost );
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
    npc *provider = teacher.as_npc();
    start_training_gen( teacher, students, d, provider ? provider->chatbin.mission_selected : nullptr );
}

namespace
{
struct training_terms {
    int cost = 0;
    time_duration duration = 0_turns;
};

std::optional<training_terms> price_training( const Character &teacher,
        const std::vector<Character *> &students, const talk_function::teach_domain &domain )
{
    training_terms result;
    int64_t cost = 0;
    for( const Character *student : students ) {
        time_duration duration;
        if( domain.skill != skill_id() &&
            student->get_knowledge_level( domain.skill ) < teacher.get_knowledge_level( domain.skill ) ) {
            cost += calc_skill_training_cost_char( teacher, *student, domain.skill );
            duration = calc_skill_training_time_char( teacher, *student, domain.skill );
        } else if( domain.style != matype_id() &&
                   !student->martial_arts_data->has_martialart( domain.style ) ) {
            cost += calc_ma_style_training_cost( teacher, *student, domain.style );
            duration = calc_ma_style_training_time( teacher, *student, domain.style );
        } else if( domain.spell != spell_id() ) {
            cost += calc_spell_training_cost( teacher, *student, domain.spell );
            duration = calc_spell_training_time( teacher, *student, domain.spell );
        } else if( domain.prof != proficiency_id() ) {
            cost += calc_proficiency_training_cost( teacher, *student, domain.prof );
            duration = calc_proficiency_training_time( teacher, *student, domain.prof );
        } else {
            return std::nullopt;
        }
        result.duration = std::max( result.duration, duration );
    }
    if( cost < 0 || cost > std::numeric_limits<int>::max() ) {
        return std::nullopt;
    }
    result.cost = static_cast<int>( cost );
    return result;
}

bool course_is_offered( const Character &teacher, const Character &student,
                        const talk_function::teach_domain &domain )
{
    const auto contains = []( const auto & list, const auto & id ) {
        return std::find( list.begin(), list.end(), id ) != list.end();
    };
    if( domain.skill != skill_id() ) {
        return contains( teacher.skills_offered_to( &student ), domain.skill );
    }
    if( domain.style != matype_id() ) {
        return contains( teacher.styles_offered_to( &student ), domain.style );
    }
    if( domain.spell != spell_id() ) {
        return contains( teacher.spells_offered_to( &student ), domain.spell );
    }
    return domain.prof != proficiency_id() &&
           contains( teacher.proficiencies_offered_to( &student ), domain.prof );
}

bool within_training_range( const Character &teacher, const Character &student, const map &here )
{
    return here.inbounds( student.pos_abs() ) && student.posz() == teacher.posz() &&
           rl_dist( student.pos_abs(), teacher.pos_abs() ) <= SEEX * 2;
}

bool is_seminar_follower( const Character &teacher, const Character &student, const map &here,
                          const std::set<character_id> &roster )
{
    const npc *follower = student.as_npc();
    return follower && &student != &teacher && roster.count( follower->getID() ) != 0 &&
           !cata_mp::is_player_proxy( *follower ) && !follower->has_native_player_control() &&
           follower->is_player_ally() && follower->is_following() &&
           follower->can_hear( teacher.pos_bub( here ), teacher.get_shout_volume() );
}

class training_group
{
    public:
        training_group( Character &teacher, const std::vector<Character *> &students,
                        const talk_function::teach_domain &domain )
            : teacher_( teacher ), domain_( domain ) {
            students_.reserve( students.size() );
            for( Character *student : students ) {
                students_.emplace_back( *student );
            }
        }

        std::vector<Character *> live_students() const {
            if( !teacher_ ) {
                return {};
            }
            std::vector<Character *> result;
            result.reserve( students_.size() );
            for( const character_action_guard &student : students_ ) {
                Character *live = student.get();
                if( !live ) {
                    return {};
                }
                result.push_back( live );
            }
            return result;
        }

        bool matches_offer( const character_action_guard &patron,
                            const training_terms &confirmed ) const {
            const Character *teacher = teacher_.get();
            const Character *payer = patron.get();
            if( !teacher || !payer || !payer->has_native_player_control() ||
                teacher->activity || payer->activity ||
                ( npc_trading::merchant( *teacher ) && teacher->has_effect( effect_asked_to_train ) ) ) {
                return false;
            }
            const map &here = get_map();
            const bool npc_teacher = npc_trading::merchant( *teacher ) != nullptr;
            const auto students = live_students();
            std::set<character_id> roster;
            if( npc_teacher && std::any_of( students.begin(), students.end(),
            [payer]( const Character * student ) {
            return student != payer;
        } ) ) {
                roster = g->get_follower_list();
            }
            if( students.empty() || !here.inbounds( teacher->pos_abs() ) ||
                !within_training_range( *teacher, *payer, here ) ||
            std::any_of( students.begin(), students.end(), [&]( const Character * student ) {
            return student->activity || !within_training_range( *teacher, *student, here ) ||
                       ( npc_teacher && student != payer &&
                         !is_seminar_follower( *teacher, *student, here, roster ) ) ||
                       !course_is_offered( *teacher, *student, domain_ );
            } ) ) {
                return false;
            }
            const auto current = price_training( *teacher, students, domain_ );
            return current && current->cost == confirmed.cost && current->duration == confirmed.duration;
        }

        bool begin( time_duration duration ) const {
            Character *teacher = teacher_.get();
            const auto students = live_students();
            if( !teacher || students.empty() ) {
                return false;
            }
            std::vector<character_id> ids;
            ids.reserve( students.size() );
            for( const Character *student : students ) {
                ids.push_back( student->getID() );
            }
            const auto assign = []( Character & participant, const training_activity_actor & actor ) {
                player_activity activity( actor );
                if( !participant.is_avatar() && participant.has_native_player_control() ) {
                    activity.set_execution( activity_execution::authoritative );
                }
                participant.assign_activity( activity );
            };
            const character_id teacher_id = teacher->getID();
            assign( *teacher, training_activity_actor( duration, domain_, ids ) );
            if( teacher_ ) {
                teacher->add_effect( effect_asked_to_train, 6_hours );
            }
            for( const character_action_guard &student : students_ ) {
                Character *live = student.get();
                if( !teacher_ || !live ) {
                    return false;
                }
                assign( *live, training_activity_actor( duration, domain_, teacher_id ) );
            }
            return true;
        }

    private:
        character_action_guard teacher_;
        talk_function::teach_domain domain_;
        std::vector<character_action_guard> students_;
};

bool start_training_request( Character &teacher, const std::vector<Character *> &students,
                             const talk_function::teach_domain &domain, mission *reward_mission,
                             dialogue *conversation, Character *explicit_patron )
{
    if( students.empty() ||
    std::any_of( students.begin(), students.end(), [&]( const Character * student ) {
    return !student || student == &teacher;
} ) ) {
        return false;
    }
    const auto group = std::make_shared<training_group>( teacher, students, domain );
    if( group->live_students().empty() ) {
        return false;
    }
    const auto terms = price_training( teacher, students, domain );
    if( !terms ) {
        return false;
    }
    const auto avatar_student = std::find_if( students.begin(),
    students.end(), []( const Character * student ) {
        return student->is_avatar();
    } );
    Character &payer = explicit_patron ? *explicit_patron :
                       avatar_student != students.end() ? **avatar_student : *students.front();
    const character_action_guard patron( payer );
    const bool remote = conversation && payer.has_native_player_control() && !payer.is_avatar();
    if( remote && !group->matches_offer( patron, *terms ) ) {
        return false;
    }
    if( npc *provider = teacher.has_native_player_control() ? nullptr : teacher.as_npc() ) {
        const bool reward = mission_dialogue::is_assigned_chatbin_mission_for(
                                *provider, payer.getID(), reward_mission ) &&
                            !reward_mission->generic_reward_claimed() &&
                            !reward_mission->has_failed() &&
                            reward_mission->is_complete( provider->getID(), payer );
        if( reward ) {
            if( !mission_dialogue::clear_mission_for_character(
                    *provider, payer, reward_mission, nullptr, false ) ) {
                return false;
            }
        } else if( !npc_trading::pay_npc( *provider, payer, terms->cost ) ) {
            if( remote && terms->cost > 0 ) {
                dialogue_trade_request payment;
                payment.title = _( "Pay for training" );
                payment.service_cost = terms->cost;
                payment.can_fulfill = [group, patron, confirmed = *terms]() {
                    return group->matches_offer( patron, confirmed );
                };
                payment.fulfill = [group, duration = terms->duration]() {
                    group->begin( duration );
                };
                return conversation->request_remote_trade( std::move( payment ) );
            }
            return false;
        }
        // The reward or debit is committed. Even if an activity callback
        // invalidates a participant, do not present the same enrollment again.
        group->begin( terms->duration );
        return true;
    }
    return group->begin( terms->duration );
}

void request_remote_seminar( dialogue &conversation, npc &teacher, Character &payer,
                             const talk_function::teach_domain &domain )
{
    const character_action_guard instructor( teacher );
    const character_action_guard patron( payer );
    const map &map_at_request = get_map();
    const auto follower_ids = g->get_follower_list();
    auto offered = std::make_shared<std::vector<character_action_guard>>();
    offered->emplace_back( payer );
    for( const character_id id : follower_ids ) {
        if( npc *follower = g->critter_by_id<npc>( id );
            follower && follower != &payer &&
            is_seminar_follower( teacher, *follower, map_at_request, follower_ids ) ) {
            offered->emplace_back( *follower );
        }
    }

    const auto available = [offered, instructor, patron, domain]() {
        std::vector<Character *> students;
        const Character *current_teacher = instructor.get();
        const Character *current_payer = patron.get();
        const map &here = get_map();
        if( !current_teacher || !current_payer || !current_payer->has_native_player_control() ||
            !npc_trading::merchant( *current_teacher ) || current_teacher->activity ||
            current_payer->activity || current_teacher->has_effect( effect_asked_to_train ) ||
            !here.inbounds( current_teacher->pos_abs() ) ||
            !within_training_range( *current_teacher, *current_payer, here ) ) {
            return students;
        }
        const auto roster = g->get_follower_list();
        for( const character_action_guard &entry : *offered ) {
            Character *student = entry.get();
            if( student && !student->activity &&
                within_training_range( *current_teacher, *student, here ) &&
                ( student == current_payer || is_seminar_follower( *current_teacher, *student, here, roster ) ) &&
                course_is_offered( *current_teacher, *student, domain ) ) {
                students.push_back( student );
            }
        }
        return students;
    };
    dialogue_seminar_request request;
    request.candidates = [available]() {
        std::vector<std::pair<character_id, std::string>> result;
        for( const Character *student : available() ) {
            result.emplace_back( student->getID(), student->get_name() );
        }
        return result;
    };
    request.enroll = [available, instructor, patron, domain]( dialogue & d,
    const std::vector<character_id> &chosen ) {
        Character *current_teacher = instructor.get();
        Character *current_payer = patron.get();
        if( !current_teacher || !current_payer || chosen.empty() ) {
            return false;
        }
        const std::set<character_id> chosen_ids( chosen.begin(), chosen.end() );
        std::vector<Character *> students;
        for( Character *candidate : available() ) {
            if( chosen_ids.count( candidate->getID() ) != 0 ) {
                students.push_back( candidate );
            }
        }
        if( students.size() != chosen.size() ) {
            return false;
        }
        return start_training_request( *current_teacher, students, domain,
                                       d.actor( true )->selected_mission(), &d, current_payer );
    };
    conversation.request_remote_seminar( std::move( request ) );
}
} // namespace

void talk_function::start_training_gen( Character &teacher, std::vector<Character *> &students,
                                        teach_domain &d, mission *reward_mission )
{
    start_training_request( teacher, students, d, reward_mission );
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
    basecamp *npc_camp = nullptr;
    int nearest_distance = 4;
    overmap_buffer.foreach_loaded_camp( [&p, &npc_camp, &nearest_distance]( basecamp & candidate ) {
        const int distance = rl_dist( candidate.camp_omt_pos().xy(), p.pos_abs_omt().xy() );
        if( distance < nearest_distance && candidate.allowed_access_by( p ) ) {
            npc_camp = &candidate;
            nearest_distance = distance;
        }
    } );
    if( !npc_camp ) {
        return;
    }

    zone_manager &mgr = zone_manager::get_manager();
    const tripoint_abs_ms &npc_abs_loc = p.pos_abs();
    // 3x3 square with NPC in the center, includes NPC's tile and all adjacent ones, for overflow
    const tripoint_abs_ms top_left = npc_abs_loc + point::north_west;
    const tripoint_abs_ms bottom_right = npc_abs_loc + point::south_east;
    std::string zone_name = "ERROR IF YOU SEE THIS (dummy zone talk_function::distribute_food_auto)";
    const faction_id fac_id = npc_camp->get_owner();
    mgr.add( zone_name, zone_type_CAMP_FOOD, fac_id, false, true, top_left, bottom_right );
    mgr.add( zone_name, zone_type_CAMP_STORAGE, fac_id, false, true, top_left,
             bottom_right );
    npc_camp->distribute_food( false );
    auto lambda_remove_zones = [&mgr, &fac_id, &zone_name]( zone_type_id type_to_remove ) {
        std::vector<zone_manager::ref_zone_data> p_zones = mgr.get_zones( fac_id );
        for( zone_data &a_zone : p_zones ) {
            if( a_zone.get_type() == type_to_remove && a_zone.get_name() == zone_name ) {
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
