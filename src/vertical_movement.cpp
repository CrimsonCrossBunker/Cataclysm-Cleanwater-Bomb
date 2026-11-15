#include "vertical_movement.h"
#include "deployed_furniture.h"

#include <algorithm>
#include <array>
#include <cmath>

#include "action.h"
#include "activity_actor_definitions.h"
#include "avatar.h"
#include "creature_tracker.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "character_action_guard.h"
#include "climbing.h"
#include "flag.h"
#include "game.h"
#include "item.h"
#include "item_location.h"
#include "item_uid.h"
#include "json.h"
#include "map.h"
#include "map_iterator.h"
#include "mapdata.h"
#include "monster.h"
#include "mtype.h"
#include "npc.h"
#include "output.h"
#include "line.h"
#include "string_formatter.h"
#include "rng.h"
#include "translations.h"
#include "uilist.h"
#include "weather.h"
#include "vehicle.h"
#include "vehicle_uid.h"
#include "vpart_position.h"

void vertical_move_choices::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "landing", landing );
    out.member( "drag_direction", drag_direction );
    out.member( "wielded_uid", wielded_uid );
    if( unwield ) {
        out.member( "unwield" );
        out.start_object();
        out.member( "action", unwield->action );
        out.member( "container", unwield->container );
        out.member( "pocket", unwield->pocket );
        out.end_object();
    }
    out.member( "allow_danger", allow_danger );
    out.member( "allow_blocker", allow_blocker );
    out.member( "allow_one_way", allow_one_way );
    out.member( "drop_aid", drop_aid );
    out.member( "detach_vine", detach_vine );
    out.end_object();
}

void vertical_move_choices::deserialize( const JsonObject &data )
{
    data.read( "landing", landing );
    data.read( "drag_direction", drag_direction );
    data.read( "wielded_uid", wielded_uid );
    if( data.has_object( "unwield" ) ) {
        const auto selection = data.get_object( "unwield" );
        unwield = item_disposition{ selection.get_string( "action" ),
                                    selection.has_member( "container" ) ? selection.get_int64( "container" ) : 0, selection.has_member( "pocket" ) ? selection.get_int64( "pocket" ) : 0 };
    }
    data.read( "allow_danger", allow_danger );
    data.read( "allow_blocker", allow_blocker );
    data.read( "allow_one_way", allow_one_way );
    data.read( "drop_aid", drop_aid );
    data.read( "detach_vine", detach_vine );
}

void vertical_move_selection::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "origin", origin );
    out.member( "target", target );
    out.member( "action", action );
    out.member( "direction", direction );
    out.member( "vehicle", vehicle );
    out.member( "part", part );
    out.member( "aid", aid );
    out.member( "furniture", furniture );
    out.member( "choices", choices );
    out.end_object();
}

void vertical_move_selection::deserialize( const JsonObject &data )
{
    data.read( "origin", origin, true );
    data.read( "target", target, true );
    data.read( "action", action, true );
    data.read( "direction", direction, true );
    data.read( "vehicle", vehicle );
    data.read( "part", part );
    data.read( "aid", aid );
    data.read( "furniture", furniture );
    data.read( "choices", choices, true );
}

std::vector<tripoint_bub_ms> climb_up_destinations( const Character &who, const map &here,
        const tripoint_bub_ms &above )
{
    std::vector<tripoint_bub_ms> points;
    if( !here.inbounds( above ) ) {
        return points;
    }
    if( who.has_flag( json_character_flag( "CLIMB_FLYING" ) ) ) {
        points.push_back( above );
    } else {
        for( const auto &p : here.points_in_radius( above, 1 ) ) {
            if( here.passable_through( p ) ) {
                points.push_back( p );
            }
        }
        if( who.has_flag( json_character_flag( "WALL_CLING" ) ) && here.is_wall_adjacent( above ) &&
            std::find( points.begin(), points.end(), above ) == points.end() ) {
            points.push_back( above );
        }
    }
    return points;
}

void vertical_move_option::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "selection", selection );
    out.member( "label", label );
    out.member( "confirmation", confirmation );
    out.member( "enabled", enabled );
    out.member( "unwield", unwield );
    out.member( "blocker", blocker );
    out.member( "danger", danger );
    out.member( "one_way", one_way );
    out.member( "detach_vine", detach_vine );
    out.member( "drag", drag );
    out.end_object();
}

void vertical_move_option::deserialize( const JsonObject &data )
{
    data.read( "selection", selection, true );
    data.read( "label", label, true );
    data.read( "confirmation", confirmation );
    data.read( "enabled", enabled );
    data.read( "unwield", unwield );
    data.read( "blocker", blocker );
    data.read( "danger", danger );
    data.read( "one_way", one_way );
    data.read( "detach_vine", detach_vine );
    data.read( "drag", drag );
}

void vertical_move_prompt::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "origin", origin );
    out.member( "title", title );
    out.member( "options", options );
    out.end_object();
}

void vertical_move_prompt::deserialize( const JsonObject &data )
{
    data.read( "origin", origin, true );
    data.read( "title", title, true );
    data.read( "options", options, true );
}

std::optional<vertical_move_selection> vertical_move_prompt::query( Character &who ) const
{
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    const character_action_guard lifetime( who );
    const auto unchanged = [&]() {
        return lifetime && who.pos_abs() == origin;
    };
    if( !unchanged() || !who.is_avatar() ) {
        return std::nullopt;
    }
    if( options.empty() ) {
        who.add_msg_if_player( title );
        return std::nullopt;
    }
    size_t selected = 0;
    if( options.size() != 1 || !options.front().enabled ) {
        uilist menu;
        menu.text = title;
        for( size_t i = 0; i < options.size(); ++i ) {
            menu.addentry( i, options[i].enabled, MENU_AUTOASSIGN, options[i].label );
        }
        menu.query();
        if( !unchanged() || menu.ret < 0 || static_cast<size_t>( menu.ret ) >= options.size() ) {
            return std::nullopt;
        }
        selected = menu.ret;
    }
    const auto &option = options[selected];
    if( !option.enabled ) {
        return std::nullopt;
    }
    auto choice = option.selection;
    const auto confirm = [&]( const std::string & message ) {
        return who.query_yn( message ) && unchanged();
    };
    if( !option.confirmation.empty() && !confirm( option.confirmation ) ) {
        return std::nullopt;
    }
    if( option.one_way ) {
        choice.choices.allow_one_way = true;
    }
    if( option.unwield ) {
        const auto weapon = who.get_wielded_item();
        if( !weapon || weapon->uid().get_value() != choice.choices.wielded_uid ) {
            return std::nullopt;
        }
        choice.choices.unwield = query_item_disposition( who, weapon,
                                 _( "Put your two-handed weapon away before climbing?" ) );
        if( !choice.choices.unwield || !unchanged() ) {
            return std::nullopt;
        }
    }
    if( option.blocker ) {
        if( !confirm( _( "There is someone on the stairs.  Attempt to push past?" ) ) ) {
            return std::nullopt;
        }
        choice.choices.allow_blocker = true;
    }
    if( option.danger ) {
        if( !confirm( _( "There appears to be a dangerous field at your destination.  Continue?" ) ) ) {
            return std::nullopt;
        }
        choice.choices.allow_danger = true;
    }
    if( option.detach_vine ) {
        choice.choices.detach_vine = who.query_yn(
                                         _( "Detach a vine?  It'll hurt, but you'll be able to climb back up…" ) );
        if( !unchanged() ) {
            return std::nullopt;
        }
    }
    if( option.drag ) {
        choice.choices.drag_direction = choose_direction(
                                            _( "Select a direction to push grabbed object towards." ) );
    }
    return unchanged() ? std::make_optional( choice ) : std::nullopt;
}

vertical_move_prompt make_climb_down_prompt( Character &who, map &here,
        const tripoint_bub_ms &ledge )
{
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    vertical_move_prompt prompt;
    prompt.origin = who.pos_abs();
    prompt.title = _( "How would you prefer to climb down?" );
    if( !here.inbounds( ledge ) || who.posz() != ledge.z() ||
        square_dist( who.pos_bub( here ).xy(), ledge.xy() ) > 1 ) {
        return prompt;
    }
    // This fills menu data only: no host input or simulation is performed.
    uilist menu;
    g->climb_down_menu_gen( who, ledge, menu );
    for( const auto &entry : menu.entries ) {
        const int_id<climbing_aid> aid( entry.retval - 0x1000 );
        if( !aid.is_valid() ) {
            continue;
        }
        vertical_move_option option;
        auto &choice = option.selection;
        choice.origin = prompt.origin;
        choice.target = here.get_abs( ledge );
        choice.direction = -1;
        choice.action = "climb";
        choice.aid = aid.id();
        option.label = entry.txt;
        const auto risk = g->climb_down_prompt( who, ledge, choice.aid );
        option.enabled = entry.enabled && risk.has_value();
        if( risk ) {
            option.confirmation = *risk;
        }
        prompt.options.push_back( std::move( option ) );
    }
    return prompt;
}

static bool can_glide_from_ledge( const Character &who )
{
    return who.has_flag( json_character_flag( "GLIDE" ) ) ||
           who.has_flag( json_character_flag( "WING_GLIDE" ) ) ||
           who.has_bodypart_with_flag( json_character_flag( "WING_ARMS" ) );
}

std::optional<tripoint_abs_ms> ledge_peek_position( const Character &who, const map &here,
        const tripoint_abs_ms &ledge_position )
{
    if( !here.inbounds( ledge_position ) || !here.inbounds( who.pos_abs() ) ) {
        return std::nullopt;
    }
    const auto ledge = here.get_bub( ledge_position );
    const auto origin = who.pos_bub( here );
    if( ledge.z() != origin.z() || square_dist( ledge.xy(), origin.xy() ) != 1 ||
        !here.is_open_air( ledge ) || !here.valid_move( origin, ledge, false, true ) ) {
        return std::nullopt;
    }
    auto where = ledge;
    auto below = where + tripoint::below;
    while( here.inbounds( below ) && here.valid_move( where, below, false, true ) ) {
        where = below;
        below += tripoint::below;
    }
    return where == ledge ? std::nullopt : std::make_optional( here.get_abs( where ) );
}

std::vector<tripoint_abs_ms> peek_destinations( const Character &who, const map &here,
        int direction )
{
    std::vector<tripoint_abs_ms> result;
    const auto origin = who.pos_bub( here );
    if( !here.inbounds( origin ) || direction < -1 || direction > 1 ) {
        return result;
    }
    const auto append = [&]( const tripoint_bub_ms & p ) {
        if( here.inbounds( p ) && here.passable( p ) ) {
            result.push_back( here.get_abs( p ) );
        }
    };
    if( direction == 0 ) {
        for( const auto &p : here.points_in_radius( origin, 1 ) ) {
            append( p );
        }
        return result;
    }
    const tripoint_bub_ms vertical( origin.xy(), origin.z() + direction );
    if( !here.inbounds( vertical ) || who.has_flag( json_character_flag( "CANNOT_MOVE" ) ) ||
        who.is_mounted() ) {
        return result;
    }
    if( const auto ladder = here.vehicle_ladder_destination( origin, direction ) ) {
        append( *ladder );
        return result;
    }
    if( who.in_vehicle || here.has_vehicle_ladder_at( origin ) ) {
        return result;
    }
    const auto stairs_flag = direction > 0 ? ter_furn_flag::TFLAG_GOES_UP :
                             ter_furn_flag::TFLAG_GOES_DOWN;
    if( here.has_flag( stairs_flag, origin ) ) {
        if( const auto stairs = g->find_stairs( here, vertical.z(), origin ) ) {
            const Creature *blocker = get_creature_tracker().creature_at( *stairs );
            const npc *person = blocker ? blocker->as_npc() : nullptr;
            const monster *mon = blocker ? blocker->as_monster() : nullptr;
            if( !blocker || blocker == &who ||
                ( person && !person->is_player_controlled() && !person->is_enemy() ) ||
                ( mon && mon->friendly == -1 ) ) {
                append( *stairs );
            }
        }
        return result;
    }
    if( here.has_flag( ter_furn_flag::TFLAG_SWIMMABLE, origin ) &&
        here.has_flag( ter_furn_flag::TFLAG_SWIMMABLE, vertical ) &&
        here.valid_move( origin, vertical, false, true ) ) {
        append( vertical );
        return result;
    }
    if( direction < 0 || here.has_floor_or_support( vertical ) ) {
        return result;
    }
    const bool flying = who.has_flag( json_character_flag( "CLIMB_FLYING" ) );
    const bool ladder = here.has_flag( ter_furn_flag::TFLAG_LADDER, origin );
    const auto weapon = who.get_wielded_item();
    if( !flying && !ladder && ( who.get_working_arm_count() < 1 ||
                                ( weapon && weapon->is_two_handed( who ) ) ) ) {
        return result;
    }
    bool adjacent_climb = false;
    for( const auto &p : here.points_in_radius( origin, 2 ) ) {
        adjacent_climb |= here.has_flag( ter_furn_flag::TFLAG_CLIMB_ADJACENT, p );
    }
    if( flying || adjacent_climb || who.climbing_cost( origin, vertical ) > 0 ||
        who.has_flag( json_character_flag( "CLIMB_NO_LADDER" ) ) ||
        who.has_flag( json_character_flag( "WALL_CLING" ) ) ) {
        for( const auto &p : climb_up_destinations( who, here, vertical ) ) {
            append( p );
        }
    }
    return result;
}

vertical_move_prompt make_peek_prompt( const Character &who, const map &here, int direction )
{
    vertical_move_prompt prompt;
    prompt.origin = who.pos_abs();
    prompt.title = _( "Peek where?" );
    for( const auto &p : peek_destinations( who, here, direction ) ) {
        vertical_move_option option;
        option.selection.origin = prompt.origin;
        option.selection.target = p;
        option.selection.direction = direction;
        option.selection.action = "peek";
        option.label = direction_name( direction_from( who.pos_bub( here ).xy(), here.get_bub( p ).xy() ) );
        prompt.options.push_back( std::move( option ) );
    }
    return prompt;
}

vertical_move_prompt make_ledge_move_prompt( Character &who, map &here,
        const tripoint_bub_ms &ledge )
{
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    auto prompt = make_climb_down_prompt( who, here, ledge );
    prompt.title = _( "There is a ledge here.  What do you want to do?" );
    const auto pos = who.pos_bub( here );
    if( !here.inbounds( ledge ) || ledge.z() != pos.z() ||
        square_dist( ledge.xy(), pos.xy() ) != 1 || !here.is_open_air( ledge ) ||
        !here.valid_move( pos, ledge, false, true ) || who.in_vehicle || who.is_mounted() ) {
        prompt.options.clear();
        prompt.title = _( "You can't reach that ledge." );
        return prompt;
    }
    if( ledge_peek_position( who, here, here.get_abs( ledge ) ) ) {
        vertical_move_option peek;
        peek.selection.origin = prompt.origin;
        peek.selection.target = here.get_abs( ledge );
        peek.selection.action = "ledge_peek";
        peek.selection.direction = -1;
        peek.label = _( "Peek down." );
        prompt.options.push_back( std::move( peek ) );
    }
    const auto below = ledge + tripoint::below;
    if( here.inbounds( below ) ) {
        const deployed_furniture_selection furniture{ who.pos_abs(), here.get_abs( below ), here.furn( below ).id() };
        if( can_take_down_deployed_furniture( who, here, furniture ) ) {
            vertical_move_option reach;
            reach.selection.origin = prompt.origin;
            reach.selection.target = furniture.target;
            reach.selection.furniture = furniture.furniture;
            reach.selection.action = "ledge_reach";
            reach.selection.direction = -1;
            reach.label = string_format( _( "Reach for the %s below." ), furniture.furniture.obj().name() );
            reach.confirmation = string_format( _( "Pull up the %s?" ), furniture.furniture.obj().name() );
            prompt.options.push_back( std::move( reach ) );
        }
    }
    const auto heading = tripoint_rel_ms( sgn( ledge.x() - pos.x() ), sgn( ledge.y() - pos.y() ), 0 );
    const auto landing = pos + heading * 2;
    vertical_move_option entry;
    entry.selection.origin = who.pos_abs();
    entry.selection.target = here.get_abs( ledge );
    entry.selection.direction = -1;
    entry.selection.action = "ledge_jump";
    entry.selection.choices.landing = here.get_abs( landing );
    entry.enabled = here.inbounds( landing ) && !here.is_open_air( landing );
    entry.label = entry.enabled ? _( "Jump across." ) : _( "Can't jump across (need a small gap)." );
    prompt.options.push_back( entry );
    entry.selection.action = "ledge_fall";
    entry.selection.choices.landing.reset();
    entry.label = _( "Fall down." );
    entry.enabled = true;
    entry.one_way = true;
    entry.confirmation = _( "Climbing might be safer.  Really fall from the ledge?" );
    prompt.options.push_back( entry );
    if( can_glide_from_ledge( who ) ) {
        entry.selection.action = "ledge_glide";
        entry.enabled = who.can_glide();
        entry.label = entry.enabled ? _( "Glide away." ) : _( "You can't glide in your current state" );
        entry.one_way = false;
        entry.confirmation.clear();
        prompt.options.push_back( std::move( entry ) );
    }
    return prompt;
}

static bool execute_ledge_move( Character &who, map &here, const vertical_move_selection &choice )
{
    const character_action_guard lifetime( who );
    const auto origin = who.pos_abs();
    const auto map_origin = here.get_abs_sub();
    const auto at_origin = [&]() {
        return lifetime && who.pos_abs() == origin && here.get_abs_sub() == map_origin;
    };
    const auto pos = who.pos_bub( here );
    const auto ledge = here.get_bub( choice.target );
    if( choice.direction != -1 || !here.inbounds( choice.target ) || ledge.z() != pos.z() ||
        square_dist( ledge.xy(), pos.xy() ) != 1 || !here.is_open_air( ledge ) ||
        !here.valid_move( pos, ledge, false, true ) || who.in_vehicle || who.is_mounted() ) {
        return false;
    }
    if( choice.action == "ledge_jump" ) {
        if( !who.move_effects( false ) ) {
            if( lifetime ) {
                who.mod_moves( -to_moves<int>( 1_seconds ) );
            }
            return false;
        }
        if( !at_origin() ) {
            return false;
        }
        const auto heading = tripoint_rel_ms( sgn( ledge.x() - pos.x() ), sgn( ledge.y() - pos.y() ), 0 );
        const auto landing = pos + heading * 2;
        if( who.get_str() < 4 ) {
            who.add_msg_if_player( m_warning, _( "You are too weak to jump over an obstacle." ) );
        } else if( who.weight_carried() * 100 > who.weight_capacity() * 25 ) {
            who.add_msg_if_player( m_warning, _( "You are too burdened to jump over an obstacle." ) );
        } else if( !here.inbounds( landing ) || !choice.choices.landing ||
                   *choice.choices.landing != here.get_abs( landing ) || !here.is_open_air( ledge ) ||
                   !here.valid_move( pos, ledge, false, true ) ||
                   !here.valid_move( ledge, landing, false, true ) ) {
            who.add_msg_if_player( m_warning,
                                   _( "You cannot jump over an obstacle - something is blocking the way." ) );
        } else if( const Creature *blocker = get_creature_tracker().creature_at( landing ) ) {
            who.add_msg_if_player( m_warning,
                                   _( "You cannot jump over an obstacle - there is %s blocking the way." ), blocker->disp_name() );
        } else if( here.is_open_air( landing ) ) {
            who.add_msg_if_player( m_warning,
                                   _( "You are not going to jump over an obstacle only to fall down." ) );
        } else {
            who.add_msg_if_player( m_info, _( "You jump over an obstacle." ) );
            who.set_activity_level( BRISK_EXERCISE );
            g->place_character( who, landing );
            return true;
        }
        return false;
    }
    if( choice.action == "ledge_fall" ) {
        if( !choice.choices.allow_one_way || get_creature_tracker().creature_at( ledge ) ) {
            return false;
        }
        who.mod_moves( -to_moves<int>( 1_seconds ) );
        if( !who.move_effects( false ) || !at_origin() ) {
            return false;
        }
        if( !here.is_open_air( ledge ) || !here.valid_move( pos, ledge, false, true ) ||
            get_creature_tracker().creature_at( ledge ) ) {
            return false;
        }
        if( who.has_effect_with_flag( json_character_flag( "LEVITATION" ) ) ) {
            who.add_effect( efftype_id( "slow_descent" ), 1_seconds, false );
        }
        if( !at_origin() ) {
            return false;
        }
        who.setpos( here, here.get_bub( choice.target ) );
        if( lifetime && who.pos_abs() == choice.target ) {
            who.gravity_check();
        }
        return true;
    }
    if( choice.action != "ledge_glide" || !can_glide_from_ledge( who ) ||
        get_creature_tracker().creature_at( ledge ) ) {
        return false;
    }
    if( !who.can_fly() ) {
        if( lifetime ) {
            who.mod_moves( -to_moves<int>( 1_seconds ) );
        }
        return false;
    }
    if( !at_origin() ) {
        return false;
    }
    static const std::array<tripoint_rel_ms, 8> headings = {{
            tripoint_rel_ms::south, tripoint_rel_ms::south_west, tripoint_rel_ms::west,
            tripoint_rel_ms::north_west, tripoint_rel_ms::north, tripoint_rel_ms::north_east,
            tripoint_rel_ms::east, tripoint_rel_ms::south_east
        }
    };
    const auto heading = tripoint_rel_ms( sgn( ledge.x() - pos.x() ), sgn( ledge.y() - pos.y() ), 0 );
    const auto found = std::find( headings.begin(), headings.end(), heading );
    if( found == headings.end() ) {
        return false;
    }
    const int direction = std::distance( headings.begin(), found );
    const weather_manager &weather = get_weather();
    int distance = 5;
    int difference = std::abs( weather.winddirection - direction * 45 );
    difference = std::min( difference, 360 - difference );
    if( difference <= 45 && weather.windspeed >= 12 ) {
        who.add_msg_if_player( m_warning, _( "Your glide is aided by a tailwind." ) );
        ++distance;
    } else if( difference >= 135 && weather.windspeed >= 12 ) {
        who.add_msg_if_player( m_warning, _( "Your glide is hindered by a headwind." ) );
        --distance;
    }
    if( direction % 2 != 0 ) {
        distance = std::round( 0.7 * distance );
    }
    who.assign_activity( glide_activity_actor( who, choice.target, direction, distance ) );
    if( lifetime && who.activity.id() != activity_id( "ACT_GLIDE" ) &&
        who.has_effect( efftype_id( "gliding" ) ) ) {
        // The activity-start callback may replace the newly started flight.
        // Remove only its effect; never clear the callback's successor activity.
        who.remove_effect( efftype_id( "gliding" ) );
        if( lifetime && !who.has_effect( efftype_id( "gliding" ) ) ) {
            who.gravity_check();
        }
    }
    if( lifetime && who.activity.id() == activity_id( "ACT_GLIDE" ) ) {
        who.add_msg_if_player( m_info, _( "You soar away from the ledge." ) );
        return true;
    }
    return false;
}

vertical_move_prompt make_vertical_move_prompt( Character &who, map &here, int direction )
{
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    vertical_move_prompt prompt;
    prompt.origin = who.pos_abs();
    prompt.title = _( "Move where?" );
    if( direction != -1 && direction != 1 ) {
        return prompt;
    }
    const auto pos = who.pos_bub( here );
    if( who.is_mounted() && !who.mounted_creature->has_flag( mon_flag_RIDEABLE_MECH ) ) {
        prompt.title = _( "You can't go up or down stairs while you're riding." );
        return prompt;
    }
    vertical_move_option option;
    auto &selection = option.selection;
    selection.origin = prompt.origin;
    selection.target = prompt.origin;
    selection.direction = direction;
    option.label = direction > 0 ? _( "Go up." ) : _( "Go down." );
    option.drag = who.grab_point != tripoint_rel_ms::zero;
    auto &choices = selection.choices;
    const auto append = [&]( vertical_move_option entry ) {
        if( entry.selection.choices.landing ) {
            entry.danger = here.dangerous_field_at( here.get_bub( *entry.selection.choices.landing ) );
        }
        prompt.options.push_back( std::move( entry ) );
    };
    const auto append_landings = [&]( const std::vector<tripoint_bub_ms> &points ) {
        for( const auto &p : points ) {
            auto entry = option;
            entry.selection.choices.landing = here.get_abs( p );
            entry.label = string_format( _( "Climb up %s" ), direction_name( direction_from( pos.xy(),
                                         p.xy() ) ) );
            append( std::move( entry ) );
        }
    };
    if( const auto source = here.veh_at( pos ) ) {
        if( const auto destination = source->vehicle().deck_transition( here, pos, direction ) ) {
            if( who.is_mounted() || get_creature_tracker().creature_at( *destination ) ) {
                prompt.title = _( "The vehicle stairs are blocked." );
                return prompt;
            }
            selection.action = "vehicle_deck";
            selection.target = here.get_abs( *destination );
            selection.vehicle = source->vehicle().uid().get_value();
            choices.landing = selection.target;
            append( std::move( option ) );
            return prompt;
        }
    }
    if( const auto destination = here.vehicle_ladder_destination( pos, direction ) ) {
        const auto ladder = here.vehicle_ladder_at( pos );
        if( !ladder ) {
            return prompt;
        }
        selection.action = "ladder";
        selection.target = here.get_abs( *destination );
        selection.vehicle = ladder->vehicle().uid().get_value();
        selection.part = ladder->part().get_base().uid().get_value();
        choices.landing = selection.target;
        if( here.is_open_air( *destination ) && !here.veh_at( *destination ) ) {
            option.one_way = true;
            option.confirmation =
                _( "The vehicle ladder does not reach a safe landing.  If you climb down, you will fall from the end of it.  Continue?" );
        }
    } else {
        if( here.has_vehicle_ladder_at( pos ) ) {
            prompt.title = _( "You can't climb any farther from here." );
            return prompt;
        }
        if( who.in_vehicle ) {
            prompt.title = _( "You can't climb from here." );
            return prompt;
        }
        const bool swimming = here.has_flag( ter_furn_flag::TFLAG_SWIMMABLE, pos );
        const bool phase = who.has_flag( json_character_flag( "PHASE_MOVEMENT" ) );
        if( direction < 0 && !swimming && !phase &&
            !here.has_flag( ter_furn_flag::TFLAG_GOES_DOWN, pos ) ) {
            std::vector<tripoint_bub_ms> ledges;
            if( who.has_flag( json_character_flag( "LEVITATION" ) ) && here.is_open_air( pos ) ) {
                ledges.push_back( pos );
            } else {
                for( const auto &p : here.points_in_radius( pos, 1 ) ) {
                    if( here.is_open_air( p ) ) {
                        ledges.push_back( p );
                    }
                }
            }
            if( !ledges.empty() ) {
                prompt.title = _( "Climb where?" );
                for( const auto &ledge : ledges ) {
                    auto climb = make_climb_down_prompt( who, here, ledge );
                    for( auto &entry : climb.options ) {
                        entry.label = string_format( "%s: %s", direction_name( direction_from( pos.xy(), ledge.xy() ) ),
                                                     entry.label );
                        prompt.options.push_back( std::move( entry ) );
                    }
                }
                return prompt;
            }
        }
        const tripoint_bub_ms vertical( pos.xy(), pos.z() + direction );
        if( !here.inbounds( vertical ) ) {
            prompt.title = _( "The way is blocked off." );
            return prompt;
        }
        if( swimming || phase ) {
            choices.landing = here.get_abs( vertical );
        } else if( direction > 0 && !here.has_flag( ter_furn_flag::TFLAG_GOES_UP, pos ) ) {
            if( !here.has_floor_or_support( vertical ) ) {
                const auto weapon = who.get_wielded_item();
                if( !who.has_flag( json_character_flag( "CLIMB_FLYING" ) ) &&
                    !here.has_flag( ter_furn_flag::TFLAG_LADDER, pos ) && weapon && weapon->is_two_handed( who ) ) {
                    choices.wielded_uid = weapon->uid().get_value();
                    option.unwield = true;
                }
                append_landings( climb_up_destinations( who, here, vertical ) );
                if( prompt.options.empty() ) {
                    prompt.title =
                        _( "You can't climb here - there is no terrain above you that would support your weight." );
                }
                return prompt;
            }
        } else if( const auto stairs = g->find_stairs( here, vertical.z(), pos ) ) {
            choices.landing = here.get_abs( *stairs );
            if( const Creature *blocker = get_creature_tracker().creature_at( *stairs ) ) {
                const Character *person = blocker->as_character();
                const npc *guy = blocker->as_npc();
                const monster *mon = blocker->as_monster();
                if( person && person != &who && person->is_player_controlled() ) {
                    prompt.title = _( "Another player is blocking the stairs." );
                    return prompt;
                }
                option.blocker = blocker != &who && !( ( guy && !guy->is_enemy() ) || ( mon &&
                                                       mon->friendly == -1 ) );
            }
        } else {
            choices.landing = here.get_abs( vertical );
            if( direction > 0 && !here.has_floor_or_support( vertical ) ) {
                std::vector<tripoint_bub_ms> points;
                for( const auto &p : here.points_in_radius( vertical, 1 ) ) {
                    if( here.passable_through( p ) ) {
                        points.push_back( p );
                    }
                }
                append_landings( points );
                return prompt;
            }
            if( direction > 0 || here.ter( vertical ) == ter_id( "t_lava" ) ) {
                option.one_way = true;
                option.confirmation = _( "The stairs do not connect safely.  Continue even if you cannot return?" );
            } else {
                if( who.has_flag( json_character_flag( "WEB_RAPPEL" ) ) ) {
                    choices.drop_aid = "web";
                } else if( who.has_trait( trait_id( "VINES2" ) ) || who.has_trait( trait_id( "VINES3" ) ) ) {
                    choices.drop_aid = "vines";
                    option.detach_vine = who.has_trait( trait_id( "VINES2" ) );
                } else if( who.has_amount( itype_id( "grapnel" ), 1 ) ) {
                    choices.drop_aid = "grapnel";
                } else if( who.has_amount( itype_id( "rope_30" ), 1 ) ) {
                    choices.drop_aid = "rope";
                } else {
                    choices.drop_aid = "jump";
                }
                option.confirmation = choices.drop_aid == "jump" ?
                                      _( "There is a sheer drop halfway down.  Jump?" ) :
                                      _( "There is a sheer drop halfway down.  Use your climbing aid to descend?" );
            }
        }
    }
    append( std::move( option ) );
    return prompt;
}

std::optional<vertical_move_selection> query_vertical_move( Character &who, map &here,
        int direction )
{
    if( !who.is_avatar() || !g->check_safe_mode_allowed() ) {
        return std::nullopt;
    }
    return make_vertical_move_prompt( who, here, direction ).query( who );
}

std::optional<vertical_move_selection> query_climb_down( Character &who, map &here,
        const tripoint_bub_ms &ledge )
{
    return make_climb_down_prompt( who, here, ledge ).query( who );
}

bool execute_vertical_move( Character &who, map &here, const vertical_move_selection &selection )
{
    const character_action_guard lifetime( who );
    if( !lifetime || who.pos_abs() != selection.origin ||
        ( selection.direction != -1 && selection.direction != 1 ) ||
        who.has_flag( json_character_flag( "CANNOT_MOVE" ) ) ||
        ( who.is_mounted() && !who.mounted_creature->has_flag( mon_flag_RIDEABLE_MECH ) ) ) {
        return false;
    }
    if( selection.action == "ledge_jump" || selection.action == "ledge_fall" ||
        selection.action == "ledge_glide" ) {
        return execute_ledge_move( who, here, selection );
    }
    if( selection.action == "climb" ) {
        if( selection.direction != -1 || !here.inbounds( selection.target ) ||
            !g->can_climb_down_using( who, here.get_bub( selection.target ), selection.aid ) ) {
            return false;
        }
        g->climb_down_using( who, here.get_bub( selection.target ), selection.aid, true, true );
        return true;
    }
    if( selection.action == "vehicle_deck" ) {
        const auto pos = who.pos_bub( here );
        const auto source = here.veh_at( pos );
        if( !source || source->vehicle().uid().get_value() != selection.vehicle || who.is_mounted() ) {
            return false;
        }
        const auto destination = source->vehicle().deck_transition( here, pos, selection.direction );
        if( !destination || here.get_abs( *destination ) != selection.target ||
            get_creature_tracker().creature_at( *destination ) ||
            ( here.dangerous_field_at( *destination ) && !selection.choices.allow_danger ) ) {
            return false;
        }
        g->vertical_move( who, selection.direction, false, false, &selection.choices );
        return lifetime && who.pos_abs() == selection.target;
    }
    if( selection.action == "ladder" ) {
        const auto pos = who.pos_bub( here );
        const auto ladder = here.vehicle_ladder_at( pos );
        const auto destination = here.vehicle_ladder_destination( pos, selection.direction );
        if( !ladder || !destination || ladder->vehicle().uid().get_value() != selection.vehicle ||
            ladder->part().get_base().uid().get_value() != selection.part ||
            here.get_abs( *destination ) != selection.target ||
            ( here.is_open_air( *destination ) && !here.veh_at( *destination ) &&
              !selection.choices.allow_one_way ) ||
            ( here.dangerous_field_at( *destination ) && !selection.choices.allow_danger ) ) {
            return false;
        }
        if( who.in_vehicle ) {
            here.unboard_vehicle( pos );
        }
        if( !lifetime || who.pos_abs() != selection.origin ) {
            return false;
        }
        g->vertical_move( who, destination->z() - pos.z(), true, false, &selection.choices );
        if( lifetime && !who.in_vehicle &&
            here.veh_at( who.pos_bub() ).part_with_feature( "BOARDABLE", true ) ) {
            here.board_vehicle( who.pos_bub(), &who );
        }
        return true;
    }
    if( selection.action != "stairs" || who.in_vehicle ) {
        return false;
    }
    g->vertical_move( who, selection.direction, who.has_flag( json_character_flag( "PHASE_MOVEMENT" ) ),
                      false, &selection.choices );
    return true;
}
