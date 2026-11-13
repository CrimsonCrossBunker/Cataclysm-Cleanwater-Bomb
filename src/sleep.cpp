#include "sleep.h"

#include <list>
#include <optional>
#include <string>

#include "activity_actor_definitions.h"
#include "character.h"
#include "character_action_guard.h"
#include "debug.h"
#include "flag.h"
#include "flexbuffer_json.h"
#include "game.h"
#include "generic_factory.h"
#include "item.h"
#include "item_stack.h"
#include "json.h"
#include "map.h"
#include "mapdata.h"
#include "player_activity.h"
#include "ret_val.h"
#include "translations.h"
#include "trap.h"
#include "type_id.h"
#include "veh_type.h"
#include "vehicle.h"
#include "vehicle_control.h"
#include "vpart_position.h"

namespace
{
const bionic_id bio_soporific( "bio_soporific" );
const efftype_id effect_alarm_clock( "alarm_clock" );
const efftype_id effect_sleep( "sleep" );

bool valid_fixed_wait( time_duration duration, bool alarm, bool watch )
{
    if( alarm ) {
        return duration == 30_minutes ||
               ( duration >= 1_hours && duration <= 9_hours &&
                 duration == 1_hours * to_hours<int>( duration ) );
    }
    return duration == 20_seconds || duration == 1_minutes || duration == 5_minutes ||
           duration == 30_minutes ||
           ( watch && ( duration == 1_hours || duration == 2_hours || duration == 3_hours ||
                        duration == 6_hours ) );
}
} // namespace

void wait_selection::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "origin", origin );
    out.member( "target", target );
    out.member( "duration", duration );
    out.member( "alarm", alarm );
    out.end_object();
}

void wait_selection::deserialize( const JsonObject &data )
{
    data.read( "origin", origin, true );
    data.read( "target", target, true );
    data.read( "duration", duration, true );
    data.read( "alarm", alarm, true );
}

bool is_wait_activity( std::string_view id )
{
    return id == "ACT_WAIT" || id == "ACT_WAIT_STAMINA" || id == "ACT_WAIT_WEATHER" ||
           id == "ACT_WAIT_FOLLOWERS" || id == "ACT_WAIT_NPC";
}

bool is_rest_activity( std::string_view id )
{
    return id == "ACT_TRY_SLEEP" || is_wait_activity( id );
}

bool can_wait_here( const Character &who, map &here )
{
    const vehicle *veh = controlled_vehicle( who, here );
    return !veh || veh->can_use_rails( here ) ||
           ( !veh->is_flying_in_air() && !veh->is_falling && !veh->velocity &&
             !( veh->cruise_velocity &&
                ( ( veh->is_watercraft() && veh->can_float( here ) ) ||
                  veh->sufficient_wheel_config() ) ) &&
             !( veh->is_in_water( true ) && !veh->can_float( here ) ) );
}

time_duration wait_time_until( std::string_view target, time_point now )
{
    const time_point midnight = now - time_past_midnight( now );
    time_point when = midnight;
    if( target == "daylight" ) {
        when = daylight_time( now );
    } else if( target == "noon" ) {
        when += 12_hours;
    } else if( target == "night" ) {
        when = night_time( now );
    } else if( target != "midnight" ) {
        return 0_turns;
    }
    return ( when > now ? when : when + 1_days ) - now;
}

bool start_wait( Character &who, map &here, const wait_selection &choice,
                 activity_execution execution )
{
    const character_action_guard lifetime( who );
    if( !lifetime || who.is_dead_state() || who.in_sleep_state() || who.activity ||
        who.get_moves() <= 0 || who.pos_abs() != choice.origin || !here.inbounds( choice.origin ) ||
        !can_wait_here( who, here ) || ( choice.alarm && !who.has_alarm_clock() ) ) {
        return false;
    }
    const bool watch = who.has_watch() || choice.alarm;
    const bool time_of_day_available = who.posz() >= 0 || watch;
    player_activity activity;
    if( !choice.alarm && choice.target == "stamina" && who.get_stamina() < who.get_stamina_max() ) {
        activity = player_activity( wait_stamina_activity_actor() );
    } else if( !choice.alarm && choice.target == "weather" && time_of_day_available ) {
        activity = player_activity( wait_weather_activity_actor() );
    } else if( !choice.alarm && choice.target == "followers" &&
               !wait_followers_activity_actor::get_absent_followers( who ).empty() ) {
        activity = player_activity( wait_followers_activity_actor() );
    } else {
        const bool cancel_alarm = choice.alarm && choice.target == "cancel" &&
                                  who.has_effect( effect_alarm_clock );
        const time_duration duration = choice.target == "duration" &&
                                       valid_fixed_wait( choice.duration, choice.alarm, watch ) ?
                                       choice.duration : time_of_day_available ?
                                       wait_time_until( choice.target, calendar::turn ) : 0_turns;
        if( !cancel_alarm && duration <= 0_turns ) {
            return false;
        }
        if( choice.alarm ) {
            who.remove_effect( effect_alarm_clock );
            if( !lifetime ) {
                return false;
            }
            if( cancel_alarm ) {
                who.add_msg_if_player( _( "You cancel your alarm." ) );
            } else {
                who.add_effect( effect_alarm_clock, duration );
                if( lifetime ) {
                    who.add_msg_if_player( _( "You set your alarm." ) );
                }
            }
            return static_cast<bool>( lifetime );
        }
        activity = player_activity( wait_activity_actor( duration ) );
    }
    activity.set_execution( execution );
    who.assign_activity( activity );
    return lifetime && who.activity.id() == activity.id();
}

void sleep_selection::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "origin", origin );
    out.member( "alarm_hours", alarm_hours );
    out.member( "save_before_sleep", save_before_sleep );
    out.member( "allow_faction_offense", allow_faction_offense );
    out.end_object();
}

void sleep_selection::deserialize( const JsonObject &data )
{
    data.read( "origin", origin, true );
    data.read( "alarm_hours", alarm_hours, true );
    data.read( "save_before_sleep", save_before_sleep, true );
    data.read( "allow_faction_offense", allow_faction_offense, true );
}

ret_val<void> can_start_sleep( Character &who, map &here )
{
    if( who.is_dead_state() || who.has_effect( effect_sleep ) || who.activity || who.get_moves() <= 0 ) {
        return ret_val<void>::make_failure();
    }
    if( controlled_vehicle( who, here ) ) {
        return ret_val<void>::make_failure( _( "You can't sleep while controlling a vehicle." ) );
    }
    if( who.is_mounted() ) {
        return ret_val<void>::make_failure( _( "You cannot sleep while mounted." ) );
    }
    const tripoint_bub_ms p = who.pos_bub( here );
    if( !here.inbounds( p ) ) {
        return ret_val<void>::make_failure();
    }
    if( !here.veh_at( p ) && who.get_comfort_data_for( p ).human_or_impossible() ) {
        if( here.has_flag( ter_furn_flag::TFLAG_DEEP_WATER, p ) ) {
            return ret_val<void>::make_failure( _( "You cannot sleep while swimming." ) );
        }
        if( here.has_flag( ter_furn_flag::TFLAG_NO_FLOOR, p ) ) {
            return ret_val<void>::make_failure( _( "You cannot sleep while airborne." ) );
        }
    }
    return ret_val<void>::make_success();
}

bool sleep_uses_private_property( const Character &who, const map &here )
{
    const tripoint_bub_ms p = who.pos_bub( here );
    const auto vehicle = here.veh_at( p );
    return ( vehicle && !vehicle->vehicle().is_owned_by( who ) ) ||
           ( here.has_furn( p ) && !here.has_flag( "FREE_TO_EXAMINE", p ) );
}

bool start_sleep( Character &who, map &here, const sleep_selection &choice,
                  activity_execution execution )
{
    const character_action_guard lifetime( who );
    const auto context = here.get_context_reference();
    const auto valid = [&]() {
        if( !lifetime || !context || who.pos_abs() != choice.origin ) {
            return false;
        }
        const auto allowed = can_start_sleep( who, here );
        if( !allowed.success() ) {
            if( !allowed.str().empty() ) {
                who.add_msg_if_player( m_info, allowed.str() );
            }
            return false;
        }
        if( choice.alarm_hours != 0 &&
            ( choice.alarm_hours < 3 || choice.alarm_hours > 9 || !who.has_alarm_clock() ) ) {
            who.add_msg_if_player( m_info, _( "You can't set that alarm." ) );
            return false;
        }
        if( sleep_uses_private_property( who, here ) && !choice.allow_faction_offense ) {
            const std::string warning = g->local_faction_action_warning( who, true );
            if( !warning.empty() ) {
                who.add_msg_if_player( m_info, warning );
                return false;
            }
        }
        return true;
    };
    if( !valid() ) {
        return false;
    }
    if( choice.save_before_sleep ) {
        if( who.is_avatar() ) {
            g->quicksave( true );
        } else if( !g->save() ) {
            if( lifetime ) {
                who.add_msg_if_player( m_bad, _( "Saving failed.  You haven't started trying to sleep." ) );
            }
            return false;
        }
        if( !valid() ) {
            return false;
        }
    }
    if( sleep_uses_private_property( who, here ) &&
        !g->warn_character_maybe_anger_local_faction( who, false, true, choice.allow_faction_offense ) ) {
        return false;
    }
    time_duration duration = 24_hours;
    if( choice.alarm_hours > 0 ) {
        const time_duration alarm = 1_hours * choice.alarm_hours;
        who.add_effect( effect_alarm_clock, alarm );
        if( !lifetime || !context || who.activity || who.pos_abs() != choice.origin ) {
            return false;
        }
        duration = alarm + 1_turns;
    }
    for( item *entry : who.inv_dump() ) {
        if( entry->active && entry->get_use( "musical_instrument" ) != nullptr ) {
            who.add_msg_if_player( _( "You stop playing your %s before trying to sleep." ),
                                   entry->tname() );
            entry->active = false;
        }
    }
    who.get_comfort_at( who.pos_bub( here ) ).add_try_msgs( who );
    who.add_msg_if_player( _( "You start trying to fall asleep." ) );
    if( who.has_active_bionic( bio_soporific ) ) {
        who.bio_soporific_powered_at_last_sleep_check = who.has_power();
        if( who.bio_soporific_powered_at_last_sleep_check ) {
            who.add_msg_if_player( m_good, _( "Your soporific inducer starts working its magic." ) );
        } else {
            who.add_msg_if_player( m_bad, _( "Your soporific inducer doesn't have enough power to operate." ) );
        }
    }
    who.set_moves( 0 );
    player_activity activity{ try_sleep_activity_actor( duration ) };
    activity.set_execution( execution );
    who.assign_activity( activity );
    return lifetime && who.activity.id() == activity.id();
}

namespace io
{
template<> std::string enum_to_string<comfort_data::category>( comfort_data::category data )
{
    switch( data ) {
        case comfort_data::category::terrain:
            return "terrain";
        case comfort_data::category::furniture:
            return "furniture";
        case comfort_data::category::trap:
            return "trap";
        case comfort_data::category::field:
            return "field";
        case comfort_data::category::vehicle:
            return "vehicle";
        case comfort_data::category::character:
            return "character";
        case comfort_data::category::trait:
            return "trait";
        case comfort_data::category::last:
            break;
    }
    cata_fatal( "Invalid comfort_data::category" );
}
} // namespace io

static comfort_data human_comfort;

const comfort_data &comfort_data::human()
{
    if( !human_comfort.was_loaded ) {
        human_comfort.base_comfort = 0;
        human_comfort.add_human_comfort = true;
        human_comfort.add_sleep_aids = true;
        human_comfort.was_loaded = true;
    }
    return human_comfort;
}

int comfort_data::human_comfort_at( const tripoint_bub_ms &p )
{
    const map &here = get_map();
    const optional_vpart_position vp = here.veh_at( p );
    const furn_id &furn = here.furn( p );
    const trap &trap = here.tr_at( p );

    if( vp ) {
        const std::optional<vpart_reference> board = vp.part_with_feature( "BOARDABLE", true );
        return board ? board->info().comfort : -here.move_cost( p );
    } else if( furn != furn_str_id::NULL_ID() ) {
        return furn->comfort;
    } else if( !trap.is_null() ) {
        return trap.comfort;
    } else {
        return here.ter( p )->comfort - here.move_cost( p );
    }
}

bool comfort_data::try_get_sleep_aid_at( const tripoint_bub_ms &p, item &result )
{
    map &here = get_map();
    const optional_vpart_position vp = here.veh_at( p );
    const map_stack items = here.i_at( p );
    item_stack::const_iterator begin = items.begin();
    item_stack::const_iterator end = items.end();

    if( vp ) {
        if( const std::optional<vpart_reference> cargo = vp.cargo() ) {
            const vehicle_stack vs = cargo->items();
            begin = vs.begin();
            end = vs.end();
        }
    }

    for( item_stack::const_iterator item_it = begin; item_it != end; item_it++ ) {
        if( item_it->has_flag( flag_SLEEP_AID ) ) {
            result = *item_it;
            return true;
        } else if( item_it->has_flag( flag_SLEEP_AID_CONTAINER ) ) {
            if( item_it->num_item_stacks() > 1 ) {
                continue;
            }
            for( const item *it : item_it->all_items_top() ) {
                if( it->has_flag( flag_SLEEP_AID ) ) {
                    result = *item_it;
                    return true;
                }
            }
        }
    }
    return false;
}

void comfort_data::deserialize_comfort( const JsonObject &jo, bool was_loaded,
                                        const std::string &name, int &member )
{
    if( !was_loaded ) {
        if( jo.has_int( name ) ) {
            member = jo.get_int( name );
        } else if( jo.has_string( name ) ) {
            const std::string str = jo.get_string( name );
            if( str == "impossible" ) {
                member = COMFORT_IMPOSSIBLE;
            } else if( str == "uncomfortable" ) {
                member = COMFORT_UNCOMFORTABLE;
            } else if( str == "neutral" ) {
                member = COMFORT_NEUTRAL;
            } else if( str == "slightly_comfortable" ) {
                member = COMFORT_SLIGHTLY_COMFORTABLE;
            } else if( str == "sleep_aid" ) {
                member = COMFORT_SLEEP_AID;
            } else if( str == "comfortable" ) {
                member = COMFORT_COMFORTABLE;
            } else if( str == "very_comfortable" ) {
                member = COMFORT_VERY_COMFORTABLE;
            } else {
                jo.throw_error( "invalid comfort level" );
            }
        }
    }
}

bool comfort_data::condition::is_condition_true( const Character &guy,
        const tripoint_bub_ms &p ) const
{
    bool result = false;
    const map &here = get_map();
    const optional_vpart_position vp = here.veh_at( p );
    const trap &trap = here.tr_at( p );
    switch( ccategory ) {
        case category::terrain:
            if( !id.empty() ) {
                result = ter_id( id ) == here.ter( p );
            } else if( !flag.empty() ) {
                result = here.has_flag_ter( flag, p );
            }
            break;
        case category::furniture:
            if( !id.empty() ) {
                result = furn_id( id ) == here.furn( p );
            } else if( !flag.empty() ) {
                result = here.has_flag_furn( flag, p );
            }
            break;
        case category::trap:
            result = trap_id( id ) == trap.id;
            break;
        case category::field:
            result = here.get_field_intensity( p, field_type_id( id ) ) >= intensity;
            break;
        case category::vehicle:
            if( vp && !flag.empty() ) {
                result = !!vp.part_with_feature( flag, true );
            } else {
                result = !!vp;
            }
            break;
        case category::character:
            result = guy.has_flag( json_character_flag( flag ) );
            break;
        case category::trait:
            if( active ) {
                result = guy.has_active_mutation( trait_id( id ) );
            } else {
                result = guy.has_trait( trait_id( id ) );
            }
            break;
        case category::last:
            break;
    }
    return result != invert;
}

void comfort_data::condition::deserialize( const JsonObject &jo )
{
    mandatory( jo, false, "type", ccategory );
    switch( ccategory ) {
        case category::terrain:
        case category::furniture:
            optional( jo, false, "id", id );
            optional( jo, false, "flag", flag );
            break;
        case category::trap:
            mandatory( jo, false, "id", id );
            break;
        case category::field:
            mandatory( jo, false, "id", id );
            optional( jo, false, "intensity", intensity, 1 );
            break;
        case category::vehicle:
            optional( jo, false, "flag", flag );
            break;
        case category::character:
            mandatory( jo, false, "flag", flag );
            break;
        case category::trait:
            mandatory( jo, false, "id", id );
            optional( jo, false, "active", active );
            break;
        case category::last:
            break;
    }
    optional( jo, false, "invert", invert );
}

void comfort_data::message::deserialize( const JsonObject &jo )
{
    mandatory( jo, false, "text", text );
    optional( jo, false, "rating", type );
}

void comfort_data::response::add_try_msgs( const Character &guy ) const
{
    const message &msg_try = data->msg_try;
    if( !msg_try.text.empty() ) {
        guy.add_msg_if_player( msg_try.type, msg_try.text );
    }

    const message &msg_hint = data->msg_hint;
    if( !msg_hint.text.empty() ) {
        guy.add_msg_if_player( msg_hint.type, msg_hint.text );
    }

    if( !sleep_aid.empty() ) {
        //~ %s: item name
        guy.add_msg_if_player( m_info, _( "You use your %s for comfort." ), sleep_aid );
    }

    if( comfort > COMFORT_NEUTRAL ) {
        guy.add_msg_if_player( m_good, _( "This is a comfortable place to sleep." ) );
    } else {
        const map &here = get_map();
        if( const optional_vpart_position &vp = here.veh_at( last_position ) ) {
            if( const std::optional<vpart_reference> aisle = vp.part_with_feature( "AISLE", true ) ) {
                //~ %1$s: vehicle name, %2$s: vehicle part name
                guy.add_msg_if_player( m_bad, _( "It's a little hard to get to sleep on this %2$s in %1$s." ),
                                       vp->vehicle().disp_name(), aisle->part().name( false ) );
            } else {
                //~ %1$s: vehicle name
                guy.add_msg_if_player( m_bad, _( "It's hard to get to sleep in %1$s." ),
                                       vp->vehicle().disp_name() );
            }
        } else {
            std::string name;
            const furn_id &furn = here.furn( last_position );
            const trap &trap = here.tr_at( last_position );
            const ter_id &ter = here.ter( last_position );
            if( furn != furn_str_id::NULL_ID() ) {
                name = furn->name();
            } else if( !trap.is_null() ) {
                name = trap.name();
            } else {
                name = ter->name();
            }
            if( comfort >= -2 ) {
                //~ %s: terrain/furniture/trap name
                guy.add_msg_if_player( m_bad, _( "It's a little hard to get to sleep on this %s." ), name );
            } else {
                //~ %s: terrain/furniture/trap name
                guy.add_msg_if_player( m_bad, _( "It's hard to get to sleep on this %s." ), name );
            }
        }
    }
}

void comfort_data::response::add_sleep_msgs( const Character &guy ) const
{
    const message &msg_sleep = data->msg_sleep;
    if( !msg_sleep.text.empty() ) {
        guy.add_msg_if_player( msg_sleep.type, msg_sleep.text );
    }
}

bool comfort_data::human_or_impossible() const
{
    return this == &human_comfort || base_comfort == COMFORT_IMPOSSIBLE;
}

// The logic isn't intuitive at all, but it works. Conditions are ORed together if `conditions_or`
// is true and ANDed together if it's false. Somehow.
bool comfort_data::are_conditions_true( const Character &guy, const tripoint_bub_ms &p ) const
{
    for( const condition &cond : conditions ) {
        const bool passed = cond.is_condition_true( guy, p );
        if( conditions_or == passed ) {
            return conditions_or;
        }
    }
    return !conditions_or;
}

comfort_data::response comfort_data::get_comfort_at( const tripoint_bub_ms &p ) const
{
    response result;
    result.data = this;
    result.comfort = base_comfort;
    const int hc = human_comfort_at( p );
    if( use_better_comfort && hc > base_comfort ) {
        result.comfort = hc;
    } else if( add_human_comfort ) {
        result.comfort += hc;
    }
    item sleep_aid;
    if( add_sleep_aids && try_get_sleep_aid_at( p, sleep_aid ) ) {
        result.comfort += COMFORT_SLEEP_AID;
        result.sleep_aid = sleep_aid.tname();
    }
    result.last_position = p;
    result.last_time = calendar::turn;
    return result;
}

void comfort_data::deserialize( const JsonObject &jo )
{
    mandatory( jo, was_loaded, "conditions", conditions );
    optional( jo, was_loaded, "conditions_any", conditions_or );
    deserialize_comfort( jo, was_loaded, "comfort", base_comfort );
    optional( jo, was_loaded, "add_human_comfort", add_human_comfort );
    optional( jo, was_loaded, "use_better_comfort", use_better_comfort );
    optional( jo, was_loaded, "add_sleep_aids", add_sleep_aids );
    optional( jo, was_loaded, "msg_try", msg_try );
    optional( jo, was_loaded, "msg_hint", msg_hint );
    optional( jo, was_loaded, "msg_sleep", msg_sleep );
    was_loaded = true;
}
