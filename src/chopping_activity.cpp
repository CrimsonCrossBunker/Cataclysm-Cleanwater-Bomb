#include "chopping_activity.h"
#include "mp_client_conn.h"

#include <algorithm>
#include <array>
#include <cmath>
#include <optional>
#include <utility>
#include <vector>

#include "activity_actor_definitions.h"
#include "activity_item_handling.h"
#include "avatar.h"
#include "cata_scope_helpers.h"
#include "calendar.h"
#include "character.h"
#include "character_action_guard.h"
#include "creature_tracker.h"
#include "craft_reservation.h"
#include "event.h"
#include "event_bus.h"
#include "flag.h"
#include "game.h"
#include "game_inventory.h"
#include "item.h"
#include "item_activation.h"
#include "item_consumption.h"
#include "item_location.h"
#include "item_source.h"
#include "itype.h"
#include "json.h"
#include "line.h"
#include "map.h"
#include "map_selector.h"
#include "mapdata.h"
#include "messages.h"
#include "mp_gamestate.h"
#include "output.h"
#include "player_activity.h"
#include "rng.h"
#include "sounds.h"
#include "translations.h"

int chopping_work_moves( Character &who, const item &tool )
{
    const int quality = tool.get_quality( quality_id( "AXE" ) );
    const int attr = tool.has_flag( flag_POWERED ) ? who.get_dex() : who.get_arm_str();
    int moves = to_moves<int>( time_duration::from_minutes( 60 - attr ) / std::pow( 2, quality - 1 ) );
    moves *= 1.0f - who.get_num_crafting_helpers( 3 ) / 10.0f;
    return moves;
}

void chopping_work_sound( const player_activity &activity )
{
    const tripoint_bub_ms position = get_map().get_bub( activity.placement );
    sfx::play_activity_sound( "tool", "axe", sfx::get_heard_volume( position ) );
    if( calendar::once_every( 1_minutes ) ) {
        //~ Sound of a wood chopping tool at work!
        sounds::sound( position, 15, sounds::sound_t::activity, _( "CHK!" ) );
    }
}

bool start_chopping_work( Character &who, const item_location &tool,
                          const tripoint_abs_ms &position, bool automatic )
{
    map &here = get_map();
    if( !tool || tool->is_broken() || ( who.activity && !automatic ) ||
        !here.inbounds( position ) ||
        resolve_item_source( who, here, capture_item_source( who, tool ) ) != tool ) {
        return false;
    }
    const bool tree = here.has_flag( ter_furn_flag::TFLAG_TREE, here.get_bub( position ) );
    const auto source = owned_tool_activity_source::capture( who, tool, position );
    if( !source.valid( who, tool, tree ? adjacent_tool_action::tree : adjacent_tool_action::logs ) ||
        !tool->ammo_sufficient( &who, tree ? "CHOP_TREE" : "CHOP_LOGS" ) ) {
        return false;
    }
    const int moves = chopping_work_moves( who, *tool );
    if( !automatic ) {
        const auto helpers = who.get_crafting_helpers();
        for( size_t i = 0; i < helpers.size() && i < 3; ++i ) {
            who.add_msg_if_player( m_info, _( "%s helps with this task…" ), helpers[i]->get_name() );
        }
    }
    player_activity proposed = tree ? player_activity( chop_tree_activity_actor( moves, tool,
                               automatic ) ) :
                               player_activity( chop_logs_activity_actor( moves, tool ) );
    proposed.placement = position;
    proposed.set_execution( activity_execution::authoritative );
    const character_action_guard lifetime( who );
    const auto context = here.get_context_reference();
    const activity_id type = proposed.id();
    who.assign_activity( proposed );
    return lifetime && context && who.activity.id() == type && who.activity.placement == position;
}

namespace
{
bool continue_chopping( player_activity &act, Character &who, const item_location &tool,
                        std::optional<owned_tool_activity_source> &source, bool tree )
{
    if( !source ) {
        // Old saved activities retain placement/tool. Bind to their actual owner
        // once, rather than adopting a different character on every turn.
        if( !tool || !get_map().inbounds( act.placement ) ) {
            act.set_to_null();
            return false;
        }
        source = owned_tool_activity_source::capture( who, tool, act.placement );
    }
    if( !source->valid( who, tool, tree ? adjacent_tool_action::tree : adjacent_tool_action::logs ) ||
        act.placement != source->target.position ) {
        act.set_to_null();
        return false;
    }
    act.set_execution( activity_execution::authoritative );
    return true;
}

tripoint_rel_ms automatic_fall_direction( const Character &who, const tripoint_bub_ms &position )
{
    // Preserve the native preference order and its occupied-line checks.
    const point_rel_ms main = position.xy() - who.pos_bub().xy();
    static constexpr std::array<point, 8> circle = {
        point::east, point::south_east, point::south, point::south_west, point::west,
        point::north_west, point::north, point::north_east
    };
    int center = 0;
    for( int i = 0; i < 8; ++i ) {
        if( main.raw() == circle[i] ) {
            center = i;
            break;
        }
    }
    const std::array<point, 7> candidates = {
        main.raw(), circle[( center + 7 ) % 8], circle[( center + 1 ) % 8],
        circle[( center + 6 ) % 8], circle[( center + 2 ) % 8],
        circle[( center + 5 ) % 8], circle[( center + 3 ) % 8]
    };
    for( const point &candidate : candidates ) {
        bool occupied = false;
        for( const auto &tile : line_to( position, position + 3 * candidate ) ) {
            if( get_creature_tracker().creature_at( tile ) ) {
                occupied = true;
                break;
            }
        }
        if( !occupied ) {
            return tripoint_rel_ms( candidate.x, candidate.y, 0 );
        }
    }
    return tripoint_rel_ms::zero;
}
} // namespace

bool chop_logs_activity_actor::continue_work( player_activity &act, Character &who )
{
    return continue_chopping( act, who, tool, source, false );
}

void chop_logs_activity_actor::start( player_activity &act, Character &who )
{
    act.moves_total = moves;
    act.moves_left = moves;
    continue_work( act, who );
}

void chop_logs_activity_actor::do_turn( player_activity &act, Character &who )
{
    if( continue_work( act, who ) ) {
        chopping_work_sound( act );
    }
}

void chop_logs_activity_actor::finish( player_activity &act, Character &who )
{
    if( !continue_work( act, who ) ) {
        return;
    }
    map &here = get_map();
    const auto context = here.get_context_reference();
    const character_action_guard lifetime( who );
    const tripoint_bub_ms position = here.get_bub( source->target.position );
    const bool trunk = here.ter( position ) == ter_str_id( "t_trunk" );
    const int logs = trunk ? rng( 2, 3 ) : rng( 0, 2 );
    const int sticks = trunk ? rng( 0, 3 ) : 0;
    const int splinters = trunk ? 0 : rng( 5, 15 );
    std::vector<item_location> results;
    for( const auto &entry : {
    std::pair<itype_id, int> { itype_id( "log" ), logs },
    { itype_id( "stick_long" ), sticks }, { itype_id( "splinter" ), splinters }
         } ) {
        for( int i = 0; i < entry.second; ++i ) {
            item &stored = here.add_item_unprocessed( position, item( entry.first, calendar::turn ) );
            if( !stored.is_null() ) {
                results.emplace_back( map_cursor( position ), &stored );
            }
        }
    }
    // Publish the entire native yield and consume the terrain before any drop
    // callback. A replacement activity must not be cleared at the end of this one.
    act.set_to_null();
    const auto generation = act.identity_generation();
    here.ter_set( position, ter_str_id( "t_dirt" ) );
    for( const item_location &result : results ) {
        if( !lifetime || !context || who.activity.identity_generation() != generation ) {
            return;
        }
        if( result ) {
            here.transfer_item_or_charges( position, result, item( *result ), who, 1, true );
        }
    }
    if( lifetime && context ) {
        who.add_msg_if_player( m_good, _( "You finish chopping wood." ) );
    }
}

void chop_logs_activity_actor::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "moves", moves );
    out.member( "tool", tool );
    out.member( "source", source );
    out.end_object();
}

std::unique_ptr<activity_actor> chop_logs_activity_actor::deserialize( JsonValue &value )
{
    chop_logs_activity_actor result;
    const JsonObject data = value.get_object();
    data.read( "moves", result.moves );
    data.read( "tool", result.tool );
    data.read( "source", result.source );
    return result.clone();
}

bool chop_tree_activity_actor::continue_work( player_activity &act, Character &who )
{
    return continue_chopping( act, who, tool, source, true );
}

void chop_tree_activity_actor::start( player_activity &act, Character &who )
{
    act.moves_total = moves;
    act.moves_left = moves;
    continue_work( act, who );
}

bool chop_tree_activity_actor::apply_direction( Character &who, const tripoint_rel_ms &choice )
{
    if( !waiting_for_direction || direction || choice.z() != 0 ||
        choice.x() < -1 || choice.x() > 1 || choice.y() < -1 || choice.y() > 1 ||
        choice == tripoint_rel_ms::zero || who.activity.actor.get() != this ||
        !continue_work( who.activity, who ) ) {
        return false;
    }
    direction = choice;
    waiting_for_direction = false;
    return true;
}

void chop_tree_activity_actor::do_turn( player_activity &act, Character &who )
{
    if( !continue_work( act, who ) ) {
        return;
    }
    if( act.moves_left > 0 ) {
        chopping_work_sound( act );
        return;
    }
    if( direction ) {
        return;
    }
    if( automatic || !who.is_player_controlled() ||
        ( !who.backlog.empty() && who.backlog.front().id() == activity_id( "ACT_MULTIPLE_CHOP_TREES" ) ) ) {
        direction = automatic_fall_direction( who, get_map().get_bub( source->target.position ) );
        return;
    }
    waiting_for_direction = true;
    if( who.is_avatar() && !cata_mp::is_client_mode() ) {
        const character_action_guard lifetime( who );
        const auto context = get_map().get_context_reference();
        const auto generation = act.identity_generation();
        const auto selected = choose_direction( _( "Select a direction for the tree to fall in." ) );
        if( !lifetime || !context || who.activity.identity_generation() != generation ) {
            return;
        }
        if( selected ) {
            apply_direction( who, *selected );
        } else {
            who.cancel_activity();
        }
    }
}

void chop_tree_activity_actor::finish( player_activity &act, Character &who )
{
    if( !direction || !continue_work( act, who ) ) {
        return;
    }
    map &here = get_map();
    const tripoint_bub_ms position = here.get_bub( source->target.position );
    const point_rel_ms falling = direction->xy();
    const character_id operator_id = who.getID();
    const character_action_guard lifetime( who );
    const auto context = here.get_context_reference();
    act.set_to_null();
    here.cut_down_tree( position, falling );
    if( !context ) {
        return;
    }
    here.collapse_at( position, false, true, false );
    if( !context ) {
        return;
    }
    sfx::play_variant_sound( "misc", "timber", sfx::get_heard_volume( position ) );
    if( lifetime ) {
        who.add_msg_if_player( m_good, _( "You finish chopping down a tree." ) );
    }
    get_event_bus().send<event_type::cuts_tree>( operator_id );
}

void chop_tree_activity_actor::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "moves", moves );
    out.member( "tool", tool );
    out.member( "source", source );
    out.member( "automatic", automatic );
    out.member( "waiting_for_direction", waiting_for_direction );
    out.member( "direction", direction );
    out.end_object();
}

std::unique_ptr<activity_actor> chop_tree_activity_actor::deserialize( JsonValue &value )
{
    chop_tree_activity_actor result;
    const JsonObject data = value.get_object();
    data.read( "moves", result.moves );
    data.read( "tool", result.tool );
    data.read( "source", result.source );
    data.read( "automatic", result.automatic );
    data.read( "waiting_for_direction", result.waiting_for_direction );
    data.read( "direction", result.direction );
    return result.clone();
}

namespace
{
bool available_log( Character &who, const item_location &log )
{
    map &here = get_map();
    return log && log->typeId() == itype_id( "log" ) && log->count() > 0 &&
           !activity_handlers::activity_item_reserved_for_other( *log, who ) &&
           craft_reservation::usable_by_automation( *log ) &&
           resolve_item_source( who, here, capture_item_source( who, log ) ) == log &&
           ( log.held_by( who ) || here.clear_path( who.pos_bub(), log.pos_bub( here ), 1, 1, 100 ) );
}

bool available_plank_tool( Character &who, const item_location &tool, bool automatic )
{
    return tool && !tool->is_broken() &&
           resolve_item_source( who, get_map(), capture_item_source( who, tool ) ) == tool &&
           ( automatic ? tool->get_quality( quality_id( "AXE" ) ) >= 1 : tool->type->can_use( "LUMBER" ) );
}
} // namespace

bool query_lumber_choices( Character &who, item_activation_choices &choices )
{
    choices = {};
    avatar *player = who.as_avatar();
    if( !player || who.is_mounted() ) {
        return false;
    }
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    const character_action_guard lifetime( who );
    map &here = get_map();
    const auto context = here.get_context_reference();
    item_location selected;
    // Preserve native preference for a log directly under the operator.
    for( item &value : here.i_at( who.pos_bub() ) ) {
        item_location location( map_cursor( who.pos_abs() ), &value );
        if( available_log( who, location ) ) {
            selected = location;
            break;
        }
    }
    if( !selected ) {
        selected = game_menus::inv::titled_filter_menu( []( const item & value ) {
            return value.typeId() == itype_id( "log" );
        }, *player, _( "Cut up what?" ) );
    }
    if( !lifetime || !context || !available_log( who, selected ) ||
        !query_consumption_ownership( *selected, who ) || !lifetime || !context ||
        !available_log( who, selected ) ) {
        return false;
    }
    choices.lumber = lumber_selection{ capture_item_source( who, selected ),
                                       !selected->is_owned_by( who, true ) };
    return true;
}

bool start_plank_work( Character &who, const item_location &tool, const lumber_selection &selection,
                       std::optional<tripoint_abs_ms> output, bool automatic )
{
    map &here = get_map();
    if( who.is_dead_state() || who.is_mounted() || who.has_effect( efftype_id( "incorporeal" ) ) ||
        ( who.activity && !automatic ) || !available_plank_tool( who, tool, automatic ) ||
        !tool->ammo_sufficient( &who, "LUMBER" ) ) {
        return false;
    }
    item_location log = resolve_item_source( who, here, selection.log );
    const tripoint_abs_ms destination = output.value_or( who.pos_abs() );
    if( !available_log( who, log ) || log == tool || log->has_item( *tool ) ||
        ( !log->is_owned_by( who, true ) && !selection.allow_theft ) ||
        !here.inbounds( destination ) || destination.z() != who.pos_abs().z() ||
        rl_dist( who.pos_abs(), destination ) > 1 ) {
        return false;
    }
    const character_action_guard lifetime( who );
    const auto context = here.get_context_reference();
    const auto generation = who.activity.identity_generation();
    const auto origin = who.pos_abs();
    const auto continuing = [&]() {
        return lifetime && context && who.activity.identity_generation() == generation &&
               who.pos_abs() == origin;
    };
    const int count = log->count();
    log->handle_pickup_ownership( who );
    if( !continuing() || !available_plank_tool( who, tool, automatic ) ||
        resolve_item_source( who, here, selection.log ) != log || !available_log( who, log ) ||
        log->count() != count ) {
        return false;
    }
    player_activity proposed( chop_planks_activity_actor( who, tool, automatic ) );
    proposed.placement = destination;
    proposed.set_execution( activity_execution::authoritative );
    // Native plank processing pays the log at the beginning. Cancellation does
    // not refund it. Remove before unwield/start callbacks can request it again.
    if( log->count_by_charges() && log->charges > 1 ) {
        --log->charges;
        log.on_contents_changed();
    } else {
        log.remove_item();
    }
    if( continuing() && available_plank_tool( who, tool, automatic ) ) {
        who.add_msg_if_player( _( "You cut the log into planks." ) );
        who.assign_activity( proposed );
    }
    // The input was spent even when its unwield callback replaced the activity.
    return true;
}

chop_planks_activity_actor::chop_planks_activity_actor( Character &who,
        const item_location &used, bool automatic ) :
    moves( to_moves<int>( 20_minutes ) ), operator_id( who.getID() ), origin( who.pos_abs() ),
    tool( capture_item_source( who, used ) ), automatic( automatic )
{
}

bool chop_planks_activity_actor::continue_work( player_activity &act, Character &who )
{
    if( !operator_id.is_valid() ) {
        // Old saves already paid for their log and did not retain a tool.
        // They may finish, but acquire a fixed owner and origin when resumed.
        operator_id = who.getID();
        origin = who.pos_abs();
    }
    map &here = get_map();
    if( operator_id != who.getID() || !origin || *origin != who.pos_abs() ||
        who.is_dead_state() || who.is_mounted() || who.has_effect( efftype_id( "incorporeal" ) ) ||
        !here.inbounds( act.placement ) || act.placement.z() != origin->z() ||
        rl_dist( *origin, act.placement ) > 1 ||
        ( tool && !available_plank_tool( who, resolve_item_source( who, here, *tool ), automatic ) ) ) {
        act.set_to_null();
        return false;
    }
    act.set_execution( activity_execution::authoritative );
    return true;
}

void chop_planks_activity_actor::start( player_activity &act, Character &who )
{
    act.moves_total = moves;
    act.moves_left = moves;
    continue_work( act, who );
}

void chop_planks_activity_actor::do_turn( player_activity &act, Character &who )
{
    if( continue_work( act, who ) ) {
        chopping_work_sound( act );
    }
}

void chop_planks_activity_actor::finish( player_activity &act, Character &who )
{
    if( !continue_work( act, who ) ) {
        return;
    }
    const int max_planks = 10;
    /** @EFFECT_FABRICATION increases number of planks cut from a log */
    int planks = normal_roll( 2 + who.get_skill_level( skill_id( "fabrication" ) ), 1 );
    const int wasted_planks = max_planks - planks;
    const int scraps = rng( wasted_planks, wasted_planks * 3 );
    planks = std::min( planks, max_planks );
    map &here = get_map();
    const tripoint_bub_ms position = here.get_bub( act.placement );
    const auto context = here.get_context_reference();
    const character_action_guard lifetime( who );
    const auto work_origin = who.pos_abs();
    std::vector<item_location> results;
    for( const auto &entry : {
             std::pair<itype_id, int> { itype_id( "2x4" ), planks }, { itype_id( "splinter" ), scraps }
         } ) {
        for( int i = 0; i < entry.second; ++i ) {
            // Retain spawn_item's native migrations, container, variation and
            // degradation randomization, but defer its placement/drop effects.
            if( auto prepared = here.prepare_spawn_item( position, entry.first, 0, calendar::turn ) ) {
                item &stored = here.add_item_unprocessed( position, std::move( *prepared ) );
                if( !stored.is_null() ) {
                    results.emplace_back( map_cursor( position ), &stored );
                }
            }
        }
    }
    act.set_to_null();
    const auto generation = act.identity_generation();
    for( const item_location &result : results ) {
        if( !lifetime || !context || who.pos_abs() != work_origin ||
            who.activity.identity_generation() != generation ) {
            return;
        }
        if( result ) {
            here.transfer_item_or_charges( position, result, item( *result ), who, 1, true );
        }
    }
    if( !lifetime || !context ) {
        return;
    }
    if( planks > 0 ) {
        who.add_msg_if_player( m_good, n_gettext( "You produce %d plank.", "You produce %d planks.",
                               planks ), planks );
    }
    if( scraps > 0 ) {
        who.add_msg_if_player( m_good, n_gettext( "You produce %d splinter.", "You produce %d splinters.",
                               scraps ), scraps );
    }
    if( planks < max_planks / 2 ) {
        who.add_msg_if_player( m_bad, _( "You waste a lot of the wood." ) );
    }
}

void chop_planks_activity_actor::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "moves", moves );
    out.member( "operator", operator_id );
    out.member( "origin", origin );
    out.member( "tool", tool );
    out.member( "automatic", automatic );
    out.end_object();
}

std::unique_ptr<activity_actor> chop_planks_activity_actor::deserialize( JsonValue &value )
{
    chop_planks_activity_actor result;
    const JsonObject data = value.get_object();
    data.read( "moves", result.moves );
    data.read( "operator", result.operator_id );
    data.read( "origin", result.origin );
    data.read( "tool", result.tool );
    data.read( "automatic", result.automatic );
    return result.clone();
}
