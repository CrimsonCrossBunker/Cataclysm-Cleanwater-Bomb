#include "hacksaw_activity.h"

#include <algorithm>
#include <optional>

#include "activity_actor_definitions.h"
#include "calendar.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "character_action_guard.h"
#include "color.h"
#include "game.h"
#include "item.h"
#include "item_location.h"
#include "item_source.h"
#include "itype.h"
#include "map.h"
#include "messages.h"
#include "output.h"
#include "player_activity.h"
#include "rng.h"
#include "string_formatter.h"
#include "tool_activity_target.h"
#include "translations.h"
#include "vehicle_tool_use.h"

namespace
{
std::optional<player_activity> proposed_work( Character &who, const item_location &portable,
        const tripoint_abs_ms &target, const mounted_tool_source *mounted, const item &tool )
{
    map &here = get_map();
    if( who.is_dead_state() || who.has_effect( efftype_id( "incorporeal" ) ) ||
        !valid_adjacent_tool_target( adjacent_tool_action::saw, who, here, tool, target ) ||
        !tool.ammo_sufficient( mounted ? nullptr : &who, "HACKSAW" ) ||
        ( !mounted && ( !portable || portable->is_broken() ||
                        resolve_item_source( who, here, capture_item_source( who, portable ) ) != portable ) ) ) {
        return std::nullopt;
    }
    hacksaw_activity_actor actor( here.get_bub( target ), portable );
    actor.bind_owned_work( who, target, mounted );
    player_activity activity( actor );
    activity.set_execution( activity_execution::authoritative );
    return activity;
}
} // namespace

bool query_hacksaw_work( Character &who, const item &tool, const tripoint_abs_ms &target,
                         const mounted_tool_source *mounted )
{
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    const item_location source = mounted ? item_location::nowhere :
                                 item_location( who, const_cast<item *>( &tool ) );
    auto proposed = proposed_work( who, source, target, mounted, tool );
    if( !proposed ) {
        return false;
    }
    // Call only the duration calculation, never start_or_resume's gameplay events.
    proposed->actor->start( *proposed, who );
    if( !*proposed ) {
        return false;
    }
    const bool resume = !who.backlog.empty() && who.backlog.front().can_resume_with( *proposed, who );
    player_activity preview = resume ? who.backlog.front() : *proposed;
    if( resume ) {
        preview.set_resume_values( *proposed, who );
    }
    const int remaining = static_cast<const hacksaw_activity_actor &>( *preview.actor ).moves_left;
    std::string query = string_format( resume ? _( "Resume cutting up metal using your %1$s?" ) :
                                       _( "Cut up metal using your %1$s?" ), tool.tname() );
    const float weariness = who.exertion_adjusted_move_multiplier( preview.exertion_level() );
    const time_duration duration = time_duration::from_turns( remaining * weariness / who.get_speed() );
    query += "\n" + std::string( _( "Time to complete: " ) ) +
             colorize( to_string( duration, true ), c_light_gray );
    if( tool.uses_firing_requirements() ) {
        const int per_turn = std::max( 1, static_cast<int>( who.get_speed() * weariness ) );
        const int first = std::min( remaining, std::max( 1,
                                    static_cast<int>( who.get_moves() * weariness ) ) );
        const int rest = std::max( 0, remaining - first );
        const int turns = 1 + ( rest + per_turn - 1 ) / per_turn;
        query += "\n" + string_format( _( "This will require: %s." ),
                                       tool.format_consumption_requirements( "HACKSAW", gun_mode_id( "DEFAULT" ), turns ) );
    } else if( tool.ammo_required() ) {
        const int charges = tool.ammo_required() * remaining / 100;
        query += "\n" + ( tool.ammo_current()->ammo->type == ammotype( "battery" ) ?
                          string_format( _( "This will require %d kJ." ), charges ) :
                          string_format( _( "This will require %d %s." ), charges, tool.ammo_current()->nname( charges ) ) );
    }
    if( !who.query_yn( query ) ) {
        who.add_msg_if_player( m_info, _( "You decide not to cut up this metal." ) );
        return false;
    }
    return true;
}

bool start_hacksaw_work( Character &who, const item_location &tool,
                         const tripoint_abs_ms &target, const mounted_tool_source *mounted )
{
    map &here = get_map();
    const auto proxy = mounted ? mounted_tool_item( who, here, *mounted ) : std::nullopt;
    const item *used = mounted ? ( proxy ? &*proxy : nullptr ) : ( tool ? tool.get_item() : nullptr );
    if( !used || who.activity ) {
        return false;
    }
    auto proposed = proposed_work( who, tool, target, mounted, *used );
    if( !proposed ) {
        return false;
    }
    if( !used->activation_success() ) {
        who.add_msg_if_player( m_bad,
                               _( "The blade of your %s disconnects at one end, so you put it back into place." ), used->tname() );
        return false;
    }
    const character_action_guard lifetime( who );
    who.assign_activity( *proposed );
    if( !lifetime ) {
        return false;
    }
    return who.activity.id() == activity_id( "ACT_HACKSAW" );
}
