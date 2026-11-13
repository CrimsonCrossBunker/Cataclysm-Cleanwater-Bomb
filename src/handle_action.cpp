#include "game.h" // IWYU pragma: associated

#include <coordinates.h>
#include <creature.h>
#include <enums.h>
#include <item_location.h>
#include <item_source.h>
#include <map_scale_constants.h>
#include <memory_fast.h>
#include <pimpl.h>
#include <safe_reference.h>
#include <type_id.h>
#include <algorithm>
#include <chrono>
#include <cmath>
#include <initializer_list>
#include <list>
#include <map>
#include <sstream>
#include <string>
#include <string_view>
#include <utility>

#include "action.h"
#include "activity_actor_definitions.h"
#include "advanced_inv.h"
#include "android_ui_mode.h" // IWYU pragma: keep
#include "auto_note.h"
#include "auto_pickup.h"
#include "avatar.h"
#include "avatar_action.h"
#include "bionics.h"
#include "bodygraph.h"
#include "bodypart.h"
#include "cached_options.h"
#include "calendar.h"
#include "catacharset.h"
#include "character.h"
#include "character_action_guard.h"
#include "character_attire.h"
#include "character_martial_arts.h"
#include "clzones.h"
#include "color.h"
#include "construction.h"
#include "creature_tracker.h"
#include "cursesdef.h"
#include "debug.h"
#include "debug_menu.h"
#include "diary.h"
#include "distraction_manager.h"
#include "do_turn.h"
#include "event.h"
#include "event_bus.h"
#include "faction.h"
#include "flag.h"
#include "game_constants.h"
#include "game_inventory.h"
#include "gamemode.h"
#include "grab.h"
#include "gun_mode.h"
#include "hauling.h"
#include "help.h"
#include "input_context.h"
#include "input_enums.h"
#include "input_popup.h"
#include "inventory_ui.h"
#include "item.h"
#include "itype.h"
#include "iuse.h"
#include "level_cache.h"
#include "live_view.h"
#include "magic.h"
#include "magic_enchantment.h"
#include "magic_type.h"
#include "map.h"
#include "map_iterator.h"
#include "mapdata.h"
#include "melee.h"
#include "mapsharing.h"
#include "math_parser_diag_value.h"
#include "mdarray.h"
#include "messages.h"
#include "monster.h"
#include "move_mode.h"
#include "mp_inventory_activity.h"
#include "mp_world_session.h"
#include "mtype.h"
#include "mutation.h"
#include "options.h"
#include "output.h"
#include "overmap_ui.h"
#include "panels.h"
#include "pathfinding.h"
#include "player_activity.h"
#include "ret_val.h"
#include "point.h"
#include "popup.h"
#include "profiling.h"
#include "radio_car_control.h"
#include "ranged.h"
#include "rng.h"
#include "safemode_ui.h"
#include "vehicle_control.h"
#include "vertical_movement.h"
#include "walking.h"
#if defined(TILES)
    #include "sdl_gamepad.h"
#endif
#include "sleep.h"
#include "sling.h"
#include "sounds.h"
#include "string_formatter.h"
#include "timed_event.h"
#include "translation.h"
#include "translations.h"
#include "ui_manager.h"
#include "uilist.h"
#include "uistate.h"
#include "units.h"
#include "value_ptr.h"
#include "veh_type.h"
#include "vehicle.h"
#include "vpart_position.h"
#include "weather.h"
#include "weather_type.h"
#include "worldfactory.h"

#define MP_ENABLED
#include "mp_client_conn.h"
#include "mp_equipment.h"
#include "mp_gamestate.h"
#include "mp_melee.h"
#include "npc.h"

enum class direction : unsigned int;

#if defined(TILES)
    #include "cata_tiles.h" // all animation functions will be pushed out to a cata_tiles function in some manner
    #include "screen_shake.h"
    #include "sdltiles.h"
#endif
#if defined(__ANDROID__)
    #include <jni.h>

    #include "android_native_ui.h"
    #include "sdl_wrappers.h"
#endif


static const character_modifier_id
character_modifier_move_mode_move_cost_mod( "move_mode_move_cost_mod" );


static const efftype_id effect_alarm_clock( "alarm_clock" );
static const efftype_id effect_incorporeal( "incorporeal" );
static const efftype_id effect_laserlocked( "laserlocked" );
static const efftype_id effect_pet( "pet" );
static const efftype_id effect_stunned( "stunned" );

static const flag_id json_flag_ALLOWS_REMOTE_USE( "ALLOWS_REMOTE_USE" );
static const flag_id json_flag_MOP( "MOP" );
static const flag_id json_flag_NO_UNLOAD( "NO_UNLOAD" );

static const gun_mode_id gun_mode_AUTO( "AUTO" );
static const gun_mode_id gun_mode_BURST( "BURST" );

static const json_character_flag json_flag_ALARMCLOCK( "ALARMCLOCK" );
static const json_character_flag json_flag_BIONIC_SLEEP_FRIENDLY( "BIONIC_SLEEP_FRIENDLY" );
static const json_character_flag json_flag_CANNOT_ATTACK( "CANNOT_ATTACK" );
static const json_character_flag json_flag_HANDS_CANNOT_USE_FIREARMS( "HANDS_CANNOT_USE_FIREARMS" );
static const json_character_flag json_flag_SUBTLE_SPELL( "SUBTLE_SPELL" );
static const json_character_flag
json_flag_TEMPORARY_SHAPESHIFT_NO_HANDS( "TEMPORARY_SHAPESHIFT_NO_HANDS" );


static const quality_id qual_CUT( "CUT" );


static const trait_id trait_BRAWLER( "BRAWLER" );
static const trait_id trait_GUNSHY( "GUNSHY" );
static const trait_id trait_HIBERNATE( "HIBERNATE" );
static const trait_id trait_PROF_CHURL( "PROF_CHURL" );
static const trait_id trait_SHELL2( "SHELL2" );
static const trait_id trait_SHELL3( "SHELL3" );
static const trait_id trait_WAYFARER( "WAYFARER" );

#define dbg(x) DebugLog((x),D_GAME) << __FILE__ << ":" << __LINE__ << ": "

#if defined(__ANDROID__)
extern std::map<std::string, std::list<input_event>> quick_shortcuts_map;
extern bool add_best_key_for_action_to_quick_shortcuts( action_id action,
        const std::string &category, bool back );
extern bool add_key_to_quick_shortcuts( int key, const std::string &category, bool back );
#endif

static bool has_vehicle_control( avatar &player_character );

namespace
{
class user_turn
{

    private:
        std::chrono::time_point<std::chrono::steady_clock> user_turn_start;
    public:
        user_turn() {
            user_turn_start = std::chrono::steady_clock::now();
        }

        bool has_timeout_elapsed() {
            return moves_elapsed() > 100;
        }

        int moves_elapsed() {
            const float turn_duration = get_option<float>( "TURN_DURATION" );
            // Magic number 0.005 chosen due to option menu's 2 digit precision and
            // the option menu UI rounding <= 0.005 down to "0.00" in the display.
            // This conditional will catch values (e.g. 0.003) that the options menu
            // would round down to "0.00" in the options menu display. This prevents
            // the user from being surprised by floating point rounding near zero.
            if( turn_duration <= 0.005 ) {
                return 0;
            }
            std::chrono::steady_clock::time_point now = std::chrono::steady_clock::now();
            std::chrono::milliseconds elapsed_ms =
                std::chrono::duration_cast<std::chrono::milliseconds>( now - user_turn_start );
            return elapsed_ms.count() / ( 10.0 * turn_duration );
        }

        bool async_anim_timeout() {
            std::chrono::steady_clock::time_point now = std::chrono::steady_clock::now();
            std::chrono::milliseconds elapsed_ms =
                std::chrono::duration_cast<std::chrono::milliseconds>( now - user_turn_start );
            return elapsed_ms.count() > get_option<int>( "ANIMATION_DELAY" );
        }

        std::chrono::steady_clock::time_point last_blink_transition = std::chrono::steady_clock::now();
        bool blink_timeout() {
            std::chrono::steady_clock::time_point now = std::chrono::steady_clock::now();
            std::chrono::milliseconds elapsed_ms =
                std::chrono::duration_cast<std::chrono::milliseconds>( now - last_blink_transition );
            if( elapsed_ms.count() > get_option<int>( "BLINK_SPEED" ) ) {
                last_blink_transition = now;
                return true;
            }
            return false;
        }

};
} // namespace

input_context game::get_player_input( std::string &action )
{
    // Includes input waiting, animations, redraws and multiplayer polling.
    CATA_PROFILE_SCOPE_NAMED( "input.acquire" );
    map &here = get_map();

    const tripoint_bub_ms pos = u.pos_bub( here );

    input_context ctxt;
    if( uquit == QUIT_WATCH ) {
        ctxt = input_context( "DEFAULTMODE", keyboard_mode::keycode );
        ctxt.set_iso( true );
        // The list of allowed actions in death-cam mode in game::handle_action
        // *INDENT-OFF*
        for( const action_id id : {
            ACTION_CENTER,
            ACTION_SHIFT_N,
            ACTION_SHIFT_NE,
            ACTION_SHIFT_E,
            ACTION_SHIFT_SE,
            ACTION_SHIFT_S,
            ACTION_SHIFT_SW,
            ACTION_SHIFT_W,
            ACTION_SHIFT_NW,
            ACTION_LOOK,
            ACTION_KEYBINDINGS,
        } ) {
            ctxt.register_action( action_ident( id ) );
        }
        // *INDENT-ON*
        ctxt.register_action( "QUIT", to_translation( "Accept your fate" ) );
    } else {
        ctxt = get_default_mode_input_context();
    }

    here.update_visibility_cache( pos.z() );
    const visibility_variables &cache = here.get_visibility_variables_cache();
    const level_cache &map_cache = here.get_cache_ref( pos.z() );
    const auto &visibility_cache = map_cache.visibility_cache;
#if defined(TILES)
    // Mark cata_tiles draw caches as dirty
    tilecontext->set_draw_cache_dirty();
#endif

    user_turn current_turn;

    if( get_option<bool>( "ANIMATIONS" ) ) {
        const int TOTAL_VIEW = MAX_VIEW_DISTANCE * 2 + 1;
        point iStart( ( TERRAIN_WINDOW_WIDTH > TOTAL_VIEW ) ? ( TERRAIN_WINDOW_WIDTH - TOTAL_VIEW ) / 2 : 0,
                      ( TERRAIN_WINDOW_HEIGHT > TOTAL_VIEW ) ? ( TERRAIN_WINDOW_HEIGHT - TOTAL_VIEW ) / 2 :
                      0 );
        point iEnd( ( TERRAIN_WINDOW_WIDTH > TOTAL_VIEW ) ? TERRAIN_WINDOW_WIDTH -
                    ( TERRAIN_WINDOW_WIDTH - TOTAL_VIEW ) /
                    2 :
                    TERRAIN_WINDOW_WIDTH, ( TERRAIN_WINDOW_HEIGHT > TOTAL_VIEW ) ? TERRAIN_WINDOW_HEIGHT -
                    ( TERRAIN_WINDOW_HEIGHT - TOTAL_VIEW ) /
                    2 : TERRAIN_WINDOW_HEIGHT );

        if( fullscreen ) {
            iStart.x = 0;
            iStart.y = 0;
            iEnd.x = TERMX;
            iEnd.y = TERMY;
        }

        //x% of the Viewport, only shown on visible areas
        const weather_animation_t weather_info = weather.weather_id->weather_animation;
        point offset( u.view_offset.xy().raw() + point( -getmaxx( w_terrain ) / 2 + pos.x(),
                      -getmaxy( w_terrain ) / 2 + pos.y() ) );

#if defined(TILES)
        if( g->is_tileset_isometric() ) {
            iStart.x = 0;
            iStart.y = 0;
            iEnd.x = MAPSIZE_X;
            iEnd.y = MAPSIZE_Y;
            offset.x = 0;
            offset.y = 0;
        }
#endif //TILES

        // TODO: Move the weather calculations out of here.
        const bool bWeatherEffect = weather_info.symbol != NULL_UNICODE;
        const int dropCount = static_cast<int>( iEnd.x * iEnd.y * weather_info.factor );

        weather_printable wPrint;
        wPrint.colGlyph = weather_info.color;
        wPrint.cGlyph = weather_info.symbol;
        wPrint.wtype = weather.weather_id;
        wPrint.vdrops.clear();

        // MP: BOTH sides poll on input TIMEOUT — the client to process the
        // host's grant and ack, the host (via wait_for_client_action's
        // mp_poll_input) to DETECT that ack. At 125ms each lockstep turn waited
        // up to ~125ms on BOTH legs (~195ms median measured) -> red turn-signal
        // flicker past the 400ms hysteresis and host activities paced to the
        // round-trip. 30ms for either MP role keeps the per-turn wait well under
        // 400ms. SP stays 125ms; animations are time-based (ANIMATION_DELAY) so
        // faster polling doesn't speed them up.
        // MP-HOOK: verify - CCB has gliding/FPS animation code, MP doesn't;
        // placed before the gliding dynamic timeout adjustment.
#ifdef MP_ENABLED
        ctxt.set_timeout( ( cata_mp::is_client_mode() || cata_mp::is_host_mode() ) ? 30 : 125 );
#else
        ctxt.set_timeout( 125 );
#endif

        shared_ptr_fast<game::draw_callback_t> animation_cb =
        make_shared_fast<game::draw_callback_t>( [&]() {
            draw_weather( wPrint );

            if( uquit != QUIT_WATCH ) {
                draw_sct();
            }
        } );
        add_draw_callback( animation_cb );

        creature_tracker &creatures = get_creature_tracker();
        // Discrete step-based animations (weather drops, SCT) advance once per
        // ~125ms regardless of how fast we redraw, so raising the redraw rate for
        // a smooth creature glide does not speed them up. Tracks the last step time.
        std::chrono::steady_clock::time_point last_discrete_step =
            std::chrono::steady_clock::now();
        do {
#if defined(TILES)
            const bool gliding = tilecontext &&
                                 ( tilecontext->has_creature_anim() ||
                                   tilecontext->has_explosion_light_anim() ||
                                   screen_shake_active() );
#else
            const bool gliding = false;
#endif
            // While a creature is gliding, an explosion light is playing, or the
            // screen is shaking, redraw at the configured framerate so the motion
            // looks smooth instead of stepping at 8 FPS.
            if( gliding ) {
                const int fps = std::clamp( get_option<int>( "CREATURE_MOVE_ANIM_FPS" ), 15, 144 );
                ctxt.set_timeout( std::max( 1, 1000 / fps ) );
            } else {
#ifdef MP_ENABLED
                ctxt.set_timeout( ( cata_mp::is_client_mode() || cata_mp::is_host_mode() ) ? 30 : 125 );
#else
                ctxt.set_timeout( 125 );
#endif
            }
            // Gate the discrete step-based animations to their original cadence.
            bool do_discrete_step = true;
            if( gliding ) {
                const std::chrono::steady_clock::time_point now =
                    std::chrono::steady_clock::now();
                if( std::chrono::duration_cast<std::chrono::milliseconds>(
                        now - last_discrete_step ).count() >= 125 ) {
                    last_discrete_step = now;
                } else {
                    do_discrete_step = false;
                }
            }
            if( do_discrete_step && bWeatherEffect && get_option<bool>( "ANIMATION_RAIN" ) ) {
                /*
                Location to add rain drop animation bits! Since it refreshes w_terrain it can be added to the animation section easily
                Get tile information from above's weather information:
                WEATHER_DRIZZLE | WEATHER_LIGHT_DRIZZLE | WEATHER_RAINY | WEATHER_RAINSTORM | WEATHER_THUNDER | WEATHER_LIGHTNING = "weather_rain_drop"
                WEATHER_FLURRIES | WEATHER_SNOW | WEATHER_SNOWSTORM = "weather_snowflake"
                */
                const bool had_weather_animation = !wPrint.vdrops.empty();
                wPrint.vdrops.clear();

                for( int i = 0; i < dropCount; i++ ) {
                    const point iRand( rng( iStart.x, iEnd.x - 1 ), rng( iStart.y, iEnd.y - 1 ) );
                    const point map( iRand + offset );

                    const tripoint_bub_ms mapp( map.x, map.y, pos.z() );
                    const bool no_roof_above = here.has_flag( ter_furn_flag::TFLAG_NO_FLOOR, mapp + tripoint::above );
                    if( here.inbounds( mapp ) && here.is_outside( mapp ) &&
                        no_roof_above &&
                        here.get_visibility( visibility_cache[mapp.x()][mapp.y()], cache ) ==
                        visibility_type::CLEAR &&
                        !creatures.creature_at( mapp, true ) ) {
                        // Suppress if a critter is there
                        wPrint.vdrops.emplace_back( iRand.x, iRand.y );
                    }
                }
                if( had_weather_animation || !wPrint.vdrops.empty() ) {
                    invalidate_main_ui_adaptor();
                }
            }
            // don't bother calculating SCT if we won't show it
            if( do_discrete_step && uquit != QUIT_WATCH && get_option<bool>( "ANIMATION_SCT" ) &&
                !SCT.vSCT.empty() ) {
                invalidate_main_ui_adaptor();

                SCT.advanceAllSteps();

                //Check for creatures on all drawing positions and offset if necessary
                for( auto iter = SCT.vSCT.rbegin(); iter != SCT.vSCT.rend(); ++iter ) {
                    const direction oCurDir = iter->getDirection();
                    const int width = utf8_width( iter->getText() );
                    for( int i = 0; i < width; ++i ) {
                        tripoint_bub_ms tmp( iter->getPosX() + i, iter->getPosY(), here.get_abs_sub().z() );
                        const Creature *critter = creatures.creature_at( tmp, true );

                        if( critter != nullptr && u.sees( here, *critter ) ) {
                            i = -1;
                            int iPos = iter->getStep() + iter->getStepOffset();
                            for( auto iter2 = iter; iter2 != SCT.vSCT.rend(); ++iter2 ) {
                                if( iter2->getDirection() == oCurDir &&
                                    iter2->getStep() + iter2->getStepOffset() <= iPos ) {
                                    if( iter2->getType() == "hp" ) {
                                        iter2->advanceStepOffset();
                                    }

                                    iter2->advanceStepOffset();
                                    iPos = iter2->getStep() + iter2->getStepOffset();
                                }
                            }
                        }
                    }
                }
            }

            if( pixel_minimap_option && g->w_pixel_minimap ) {
                if( liveview.is_enabled() ) {
                    // Mouse View overlaps the minimap; a direct wnoutrefresh
                    // ignores ui_adaptor z-order and paints over it.
                    invalidate_main_ui_adaptor();
                } else {
#if defined(TILES)
                    // Mark minimap dirty so beacon colors keep cycling
                    if( tilecontext->has_blinking_minimap() ) {
                        werase( g->w_pixel_minimap );
                    }
#endif
                    wnoutrefresh( g->w_pixel_minimap );
                }
            }

            std::unique_ptr<static_popup> deathcam_msg_popup;
            if( uquit == QUIT_WATCH ) {
                deathcam_msg_popup = std::make_unique<static_popup>();
                deathcam_msg_popup
                ->wait_message( c_red, _( "Press %s to accept your fate…" ), ctxt.get_desc( "QUIT" ) )
                .on_top( true );
            }

            // Remove asynchronous animations after animation delay if no input
            if( current_turn.async_anim_timeout() ) {
                bool cleared = g->void_async_anim_curses();
#if defined(TILES)
                cleared |= tilecontext->void_async_anim();
#endif
                if( cleared ) {
                    invalidate_main_ui_adaptor();
                }
            }

#if defined(TILES)
            // Expire stale hit-animation overlays between draws
            if( tilecontext->expire_hit_animations() ) {
                invalidate_main_ui_adaptor();
            }

            // Animated tiles need periodic redraws to cycle frames
            if( tilecontext->has_animated_tiles() ) {
                invalidate_main_ui_adaptor();
            }
            // A gliding creature must keep redrawing even when its sprite is
            // currently off-screen (it may scroll back into view mid-glide).
            if( gliding ) {
                invalidate_main_ui_adaptor();
            }
#endif

            if( g->has_blink_curses() && current_turn.blink_timeout() ) {
                // Toggle blink phase and redraw
                g->blink_active_phase = !g->blink_active_phase;
                g->invalidate_main_ui_adaptor();
            }

            // MP-HOOK: verify - MP process_mp_events/client_process_incoming hooks
            // placed before redraw_invalidated; MP version had simpler animation loop.
#ifdef MP_ENABLED
            // Host: process queued client actions on every animation frame so
            // the client gets combat feedback within ~125 ms instead of waiting
            // for the host's next keypress.
            if( cata_mp::is_hosting() ) {
                cata_mp::process_mp_events();
            }
            // Client: pull server monster/position updates on every frame so
            // monsters move visually without advancing local game time.
            if( cata_mp::is_client_mode() && action == "TIMEOUT" ) {
                cata_mp::client_process_incoming();
                if( uquit != QUIT_NO ) {
                    break;
                }
                g->invalidate_main_ui_adaptor();
            }
#endif

            {
                CATA_PROFILE_SCOPE_NAMED( "game.input_redraw" );
                ui_manager::redraw_invalidated();
            }
#ifdef MP_ENABLED
            // Client: when the avatar has an active multi-turn activity,
            // exit the input poll on TIMEOUT regardless of TURN_DURATION so
            // the do_turn loop ticks the activity and dispatches a wait.
            if( cata_mp::is_client_mode() && action == "TIMEOUT" &&
                get_avatar().activity ) {
                break;
            }
            // Host symmetric escape: when wait_for_client_action() called us
            // via mp_poll_input() and the partner has already acked this turn,
            // unblock immediately instead of sitting on a host keypress.
            if( cata_mp::is_hosting() && action == "TIMEOUT" &&
                cata_mp::is_host_waiting_for_client() &&
                ( cata_mp::client_acted_this_turn() ||
                  cata_mp::partner_in_interactive_activity() ) ) {
                break;
            }
#endif
        } while( handle_mouseview( ctxt, action ) && uquit != QUIT_WATCH
                 && ( action != "TIMEOUT" || !current_turn.has_timeout_elapsed() ) );
        ctxt.reset_timeout();
    } else {
#ifdef MP_ENABLED
        ctxt.set_timeout( ( cata_mp::is_client_mode() || cata_mp::is_host_mode() ) ? 30 : 125 );
#else
        ctxt.set_timeout( 125 );
#endif
        while( handle_mouseview( ctxt, action ) ) {
            if( action == "TIMEOUT" ) {
                if( current_turn.has_timeout_elapsed() ) {
                    break;
                }
#ifdef MP_ENABLED
                if( cata_mp::is_hosting() ) {
                    cata_mp::process_mp_events();
                    if( cata_mp::is_host_waiting_for_client() &&
                        cata_mp::client_acted_this_turn() ) {
                        break;
                    }
                }
                if( cata_mp::is_client_mode() ) {
                    cata_mp::client_process_incoming();
                    if( uquit != QUIT_NO ) {
                        break;
                    }
                    g->invalidate_main_ui_adaptor();
                    if( get_avatar().activity ) {
                        break;
                    }
                }
#endif
            }
        }
        ctxt.reset_timeout();
    }

    return ctxt;
}

static void pldrive( const tripoint_rel_ms &p )
{
    if( g->check_safe_mode_allowed() ) {
        drive_vehicle( get_avatar(), get_map(), p );
    }
}

static void pldrive( point_rel_ms d )
{
    pldrive( tripoint_rel_ms( d, 0 ) );
}

static void close( const std::optional<tripoint_bub_ms> &p = std::nullopt )
{
    map &here = get_map();

    std::optional<tripoint_bub_ms> pnt = p;
    if( !pnt ) {
        pnt = choose_adjacent_highlight(
                  here, _( "Close where?" ),
                  pgettext( "no door, gate, etc.", "There is nothing that can be closed nearby." ),
                  ACTION_CLOSE, false );
    }

    if( pnt ) {
        get_player_character().assign_activity( close_tile_activity_actor( *pnt ) );
    }
}

static void set_next_option( const std::string &option )
{
    get_options().get_option( option ).setNext();
    get_options().save();
    add_msg( _( "Set %s to %s." ),
             get_options().get_option( option ).getMenuText(),
             get_options().get_option( option ).getValueName() );
}

static void auto_features_warn()
{
    if( !get_option<bool>( "AUTO_FEATURES" ) ) {
        const options_manager::cOpt &auto_features = get_options().get_option( "AUTO_FEATURES" );
        add_msg( _( "Warning: Options > %s > %s > %s set to %s." ),
                 auto_features.getPage(),
                 auto_features.getGroupName(),
                 auto_features.getMenuText(),
                 auto_features.getValueName()  // false in locale
               );
    }
}

// Collect UI choices without changing the world. Local and remote players use
// the same native operation; remote clients wait for its authoritative result.
static void grab( const std::optional<tripoint_bub_ms> &p = std::nullopt )
{
    avatar &who = get_avatar();
    std::optional<tripoint_bub_ms> target = p;
    if( who.get_grab_type() != object_type::NONE ) {
        target = who.pos_bub();
    } else if( !target ) {
        target = choose_adjacent( _( "Grab where?" ) );
    }
    if( !target ) {
        return;
    }
    const auto choice = query_grab( who, get_map(), *target );
    if( !choice ) {
        return;
    }
#ifdef MP_ENABLED
    if( cata_mp::client_grab( *choice ) ) {
        return;
    }
#endif
    execute_grab( who, get_map(), *choice );
}

static void haul()
{
    Character &player_character = get_player_character();

    uilist menu;

    bool hauling = player_character.is_hauling();
    bool autohaul = player_character.is_autohauling();
    std::vector<item_location> &haul_list = player_character.haul_list;
    std::vector<item_location> haulable_items = get_map().get_haulable_items(
                player_character.pos_bub() );
    int haul_qty = haul_list.size();
    std::string &haul_filter = player_character.hauling_filter;


    std::string help_header =
        _( "Select items on current tile to haul with you as you move.\nIf autohaul is enabled, you will automatically add encountered items to the haul.\nYou can set a filter to limit which items are automatically added." );

    std::string status_header;
    if( hauling && autohaul ) {
        if( haul_qty == 0 ) {
            status_header =
                _( "You are currently not hauling any items, but autohaul is enabled, so any new items encountered on the ground will be hauled." );
        } else {
            status_header = string_format(
                                _( "You are currently hauling %d items.\nAutohaul is enabled, so any new items encountered on the ground will be hauled." ),
                                haul_qty );
        }
    }

    if( hauling && !autohaul ) {
        if( haul_qty == 0 ) {
            status_header = _( "You are currently hauling nothing.\nAutohaul is disabled." );
        } else {
            status_header = string_format( _( "You are currently hauling %d items.\nAutohaul is disabled." ),
                                           haul_qty );
        }
    }

    if( !hauling ) {
        status_header =
            _( "You are currently not hauling.  Select items to haul or enable autohaul to start." );
    }

    if( status_header.empty() ) {
        debugmsg( "Failed to construct status header for haul interface" );
    }

    status_header += haul_filter.empty() ? _( "\nAutohaul filter not set." ) : string_format(
                         _( "\nAutohaul filter: %s" ), haul_filter );

    menu.text = help_header + "\n\n" + status_header;

    input_context ctxt = get_default_mode_input_context();
    std::vector<input_event> haul_keys = ctxt.keys_bound_to( "haul" );
    int haul_key = haul_keys.empty() ? '\\' : haul_keys.front().sequence.front();

    menu.entries.emplace_back( 0, hauling, hauling ? haul_key : 'h', _( "Stop hauling" ) );
    menu.entries.emplace_back( 1, !haulable_items.empty(), !hauling ? haul_key : 'h',
                               _( "Haul everything here" ) );
    menu.entries.emplace_back( 2, !haulable_items.empty(), 'p', _( "Choose items to haul" ) );
    menu.entries.emplace_back( 3, true, 'a',
                               autohaul ? _( "Disable autohaul" ) : _( "Enable autohaul" ) );
    menu.entries.emplace_back( 4, true, 'f', _( "Edit autohaul filter" ) );
    menu.entries.emplace_back( 9, true, 'c', _( "Cancel" ) );

    menu.query();

    hauling_selection choice;
    choice.position = player_character.pos_abs();
    switch( menu.ret ) {
        case 0:
            choice.action = "stop";
            break;
        case 1:
            choice.action = "all";
            break;
        case 2: {
            inventory_haul_selector selector( player_character );
            selector.add_map_items( player_character.pos_bub() );
            selector.apply_selection( player_character.haul_list );
            selector.set_title( _( "Select items to haul" ) );
            selector.set_hint( _( "To select items, type a number before selecting." ) );
            const drop_locations result = selector.execute( true );
            choice.action = "select";
            for( const drop_location &entry : result ) {
                choice.items.push_back( { capture_item_source( player_character, entry.first ), entry.second } );
            }
            break;
        }
        case 3:
            choice.action = "autohaul";
            choice.enable_autohaul = !autohaul;
            break;
        case 4: {
            string_input_popup_imgui filter_popup( 50, player_character.hauling_filter );
            filter_popup.set_label( _( "Filter:" ) );
            filter_popup.set_description( item_filter_rule_string( item_filter_type::FILTER ), c_white, true );
            filter_popup.set_identifier( "item_filter" );
            choice.action = "filter";
            choice.filter = filter_popup.query();
            break;
        }
        default:
            return;
    }
#ifdef MP_ENABLED
    if( cata_mp::client_hauling( choice ) ) {
        return;
    }
#endif
    execute_hauling( player_character, get_map(), choice );
}

static void haul_toggle()
{
    Character &who = get_player_character();
    hauling_selection choice;
    choice.position = who.pos_abs();
    choice.action = who.is_hauling() ? "stop" : "all";
    choice.enable_autohaul = !who.is_hauling();
#ifdef MP_ENABLED
    if( cata_mp::client_hauling( choice ) ) {
        return;
    }
#endif
    execute_hauling( who, get_map(), choice );
}

static void smash( const std::optional<tripoint_bub_ms> &p = std::nullopt )
{
    const bool allow_floor_bash = debug_mode && !cata_mp::is_client_mode();
    std::optional<tripoint_bub_ms> smashp_ = p;
    if( !smashp_ ) {
        smashp_ = choose_adjacent( _( "Smash where?" ),
                                   allow_floor_bash );
    }
    if( !smashp_ ) {
        return;
    }
    tripoint_bub_ms smashp = *smashp_;
    if( cata_mp::is_client_mode() ) {
        cata_mp::client_start_smash( smashp );
        return;
    }

    map &here = get_map();
    if( !melee::has_revivable_corpse( here, smashp ) &&
        !g->warn_player_maybe_anger_local_faction( true ) ) {
        return;
    }

    avatar &player_character = get_avatar();
    Character::smash_result res = player_character.smash( here, smashp );
    if( res.did_smash && !res.success && res.can_smash &&
        query_yn( _( "Keep smashing until destroyed?" ) ) ) {
        player_character.assign_activity( bash_activity_actor( smashp ) );
    }
}

void game::execute_contextual_action( const action_id action, const tripoint_bub_ms &target )
{
    map &here = get_map();
    avatar &player_character = get_avatar();

    if( !can_interact_at( action, here, target ) ) {
        add_msg( m_info, _( "That action is no longer available at the selected tile." ) );
        return;
    }

    const bool vertical_action = action == ACTION_MOVE_UP || action == ACTION_MOVE_DOWN;
    const tripoint_bub_ms origin = player_character.pos_bub( here );
    if( ( vertical_action && target != origin ) ||
        ( !vertical_action && ( target.z() != origin.z() ||
                                square_dist( target.xy(), origin.xy() ) > 1 ) ) ) {
        add_msg( m_info, _( "You are no longer close enough to perform that action." ) );
        return;
    }

    switch( action ) {
        case ACTION_OPEN:
            player_character.assign_activity( open_tile_activity_actor( target ) );
            break;
        case ACTION_CLOSE:
            if( player_character.is_mounted() &&
                !player_character.mounted_creature->has_flag( mon_flag_RIDEABLE_MECH ) ) {
                add_msg( m_info, _( "You can't close things while you're riding." ) );
            } else {
                close( target );
            }
            break;
        case ACTION_EXAMINE:
            examine( target );
            break;
        case ACTION_PICKUP:
            pickup( target );
            break;
        case ACTION_BUTCHER:
            butcher( target );
            break;
        case ACTION_CHAT:
            chat( target );
            break;
        case ACTION_MOVE_UP:
        case ACTION_MOVE_DOWN: {
            const int direction = action == ACTION_MOVE_UP ? 1 : -1;
            if( !cata_mp::client_query_vertical_move( direction ) ) {
                if( const auto choice = query_vertical_move( player_character, here, direction ) ) {
                    execute_vertical_move( player_character, here, *choice );
                }
            }
            break;
        }
        default:
            add_msg( m_info, _( "That action cannot be queued." ) );
            break;
    }
}

static int try_set_alarm()
{
    uilist as_m;
    const bool already_set = get_player_character().has_effect( effect_alarm_clock );

    as_m.text = already_set ?
                _( "You already have an alarm set.  What do you want to do?" ) :
                _( "You have an alarm clock.  What do you want to do?" );

    as_m.entries.emplace_back( 0, true, 'w', already_set ?
                               _( "Keep the alarm and wait a while" ) :
                               _( "Wait a while" ) );
    as_m.entries.emplace_back( 1, true, 'a', already_set ?
                               _( "Change your alarm" ) :
                               _( "Set an alarm for later" ) );
    as_m.query();

    return as_m.ret;
}

static void wait()
{
    std::map<int, wait_selection> choices;
    uilist as_m;
    Character &player_character = get_player_character();
    const character_action_guard lifetime( player_character );
    bool setting_alarm = false;
    map &here = get_map();
    const auto context = here.get_context_reference();
    const tripoint_abs_ms origin = player_character.pos_abs();

    if( !can_wait_here( player_character, here ) ) {
        popup( _( "You can't pass time while controlling a moving vehicle." ) );
        return;
    }

    if( player_character.has_alarm_clock() ) {
        int alarm_query = try_set_alarm();
        if( !lifetime || !context || alarm_query == UILIST_CANCEL ) {
            return;
        }
        setting_alarm = alarm_query == 1;
    }

    const bool has_watch = player_character.has_watch() || setting_alarm;

    const auto add_menu_item = [&]( int retval, int hotkey, const std::string &caption = "",
                                    time_duration duration = 0_turns,
                                    const std::string &target = "duration" ) {
        std::string text( caption );
        if( has_watch && ( duration > 0_turns || target == "cancel" ) ) {
            const std::string dur_str( to_string( duration ) );
            text += ( text.empty() ? dur_str : string_format( " (%s)", dur_str ) );
        }
        as_m.addentry( retval, true, hotkey, text );
        choices.emplace( retval, wait_selection{ origin, target,
                         target == "duration" ? duration : 0_turns, setting_alarm } );
    };

    if( setting_alarm ) {

        add_menu_item( 0, '0', "", 30_minutes );

        for( int i = 1; i <= 9; ++i ) {
            add_menu_item( i, '0' + i, "", i * 1_hours );
        }

    } else {
        if( player_character.get_stamina() < player_character.get_stamina_max() ) {
            add_menu_item( 14, 'w', _( "Wait until you catch your breath" ), 0_turns, "stamina" );
        }
        if( !wait_followers_activity_actor::get_absent_followers( player_character ).empty() ) {
            add_menu_item( 15, 'f', _( "Wait for followers to catch up" ), 0_turns, "followers" );
        }
        add_menu_item( 1, '1', !has_watch ? _( "Wait 20 heartbeats" ) : "", 20_seconds );
        add_menu_item( 2, '2', !has_watch ? _( "Wait 60 heartbeats" ) : "", 1_minutes );
        add_menu_item( 3, '3', !has_watch ? _( "Wait 300 heartbeats" ) : "", 5_minutes );
        add_menu_item( 4, '4', !has_watch ? _( "Wait 1800 heartbeats" ) : "", 30_minutes );

        if( has_watch ) {
            add_menu_item( 5, '5', "", 1_hours );
            add_menu_item( 6, '6', "", 2_hours );
            add_menu_item( 7, '7', "", 3_hours );
            add_menu_item( 8, '8', "", 6_hours );
        }
    }

    if( player_character.posz() >= 0 || has_watch ) {
        const auto add_time_of_day = [&]( int id, int key, const std::string &caption,
                                          const std::string &target ) {
            add_menu_item( id, key, caption, wait_time_until( target, calendar::turn ), target );
        };
        add_time_of_day( 9, 'd', setting_alarm ? _( "Set alarm for dawn" ) :
                         _( "Wait till daylight" ), "daylight" );
        add_time_of_day( 10, 'n', setting_alarm ? _( "Set alarm for noon" ) :
                         _( "Wait till noon" ), "noon" );
        add_time_of_day( 11, 'k', setting_alarm ? _( "Set alarm for dusk" ) :
                         _( "Wait till night" ), "night" );
        add_time_of_day( 12, 'm', setting_alarm ? _( "Set alarm for midnight" ) :
                         _( "Wait till midnight" ), "midnight" );
        if( setting_alarm ) {
            if( player_character.has_effect( effect_alarm_clock ) ) {
                add_menu_item( 13, 'x', _( "Cancel the currently set alarm." ), 0_turns, "cancel" );
            }
        } else {
            add_menu_item( 13, 'W', _( "Wait till weather changes" ), 0_turns, "weather" );
        }
    }

    // NOLINTNEXTLINE(cata-text-style): spaces required for concatenation
    as_m.text = has_watch ? string_format( _( "It's %s now.  " ),
                                           to_string_time_of_day( calendar::turn ) ) : "";
    as_m.text += setting_alarm ? _( "Set alarm for when?" ) : _( "Wait for how long?" );
    as_m.query(); /* calculate key and window variables, generate window, and loop until we get a valid answer */

    const auto selected = choices.find( as_m.ret );
    if( !lifetime || !context || selected == choices.end() ) {
        return;
    }
    if( cata_mp::is_client_mode() ) {
        cata_mp::client_start_wait( selected->second );
    } else {
        start_wait( player_character, here, selected->second, activity_execution::local );
    }
}

static void sleep()
{
    avatar &player_character = get_avatar();
    map &here = get_map();
    const character_action_guard lifetime( player_character );
    const auto context = here.get_context_reference();
    const auto allowed = can_start_sleep( player_character, here );
    if( !allowed.success() ) {
        if( !allowed.str().empty() ) {
            add_msg( m_info, allowed.str() );
        }
        return;
    }
    const bool client = cata_mp::is_client_mode();
    sleep_selection choice;
    choice.origin = player_character.pos_abs();

    uilist as_m;
    as_m.title = _( "Are you sure you want to sleep?" );
    // (Y)es/(S)ave before sleeping/(N)o
    as_m.entries.emplace_back( 0, true,
                               get_option<bool>( "FORCE_CAPITAL_YN" ) ? 'Y' : 'y',
                               _( "Yes." ) );
    as_m.entries.emplace_back( 1, client || g->get_moves_since_last_save(),
                               get_option<bool>( "FORCE_CAPITAL_YN" ) ? 'S' : 's',
                               _( "Yes, and save game before sleeping." ) );
    as_m.entries.emplace_back( 2, true,
                               get_option<bool>( "FORCE_CAPITAL_YN" ) ? 'N' : 'n',
                               _( "No." ) );

    // List all active items, bionics or mutations so player can deactivate them
    std::vector<std::string> active;
    for( item_location &it : player_character.all_items_loc() ) {
        if( it->has_flag( flag_LITCIG ) || ( it->active && it->ammo_sufficient( &player_character ) &&
                                             it->is_tool() && !it->has_flag( flag_SLEEP_IGNORE ) ) ) {
            active.push_back( it->tname() );
        }
    }
    for( int i = 0; i < player_character.num_bionics(); i++ ) {
        const bionic &bio = player_character.bionic_at_index( i );
        if( !bio.powered ) {
            continue;
        }

        // some bionics
        // bio_alarm is useful for waking up during sleeping
        if( bio.info().has_flag( json_flag_BIONIC_SLEEP_FRIENDLY ) ) {
            continue;
        }

        const bionic_data &info = bio.info();
        if( info.power_over_time > 0_kJ ) {
            active.push_back( info.name.translated() );
        }
    }
    for( auto &mut : player_character.get_functioning_mutations() ) {
        const mutation_branch &mdata = mut.obj();
        if( mdata.cost > 0 && player_character.has_active_mutation( mut ) ) {
            active.push_back( player_character.mutation_name( mut ) );
        }
    }

    // ask for deactivation
    std::stringstream data;
    if( !active.empty() ) {
        as_m.selected = 2;
        data << _( "You may want to extinguish or turn off:" ) << std::endl;
        for( auto &a : active ) {
            data << "<color_red>" << a << "</color>" << std::endl;
        }
        as_m.text = data.str();
    }

    /* Calculate key and window variables, generate window,
       and loop until we get a valid answer. */
    as_m.query();

    if( !lifetime || !context || as_m.ret == 2 || as_m.ret < 0 ) {
        return;
    }
    choice.save_before_sleep = as_m.ret == 1;
    if( sleep_uses_private_property( player_character, here ) ) {
        const std::string warning = g->local_faction_action_warning( player_character, true );
        if( !warning.empty() ) {
            if( !player_character.query_yn( warning ) || !lifetime || !context ) {
                return;
            }
            choice.allow_faction_offense = true;
        }
    }

    std::string deaf_text;
    if( player_character.is_deaf() && !player_character.has_flag( json_flag_ALARMCLOCK ) ) {
        deaf_text = _( "<color_c_red> (DEAF!)</color>" );
    }
    if( player_character.has_alarm_clock() ) {
        /* Reuse menu to ask player whether they want to set an alarm. */
        bool can_hibernate = player_character.get_hunger() < -60 &&
                             player_character.has_active_mutation( trait_HIBERNATE );

        as_m.reset();
        as_m.text = can_hibernate ?
                    _( "You're engorged to hibernate.  The alarm would only attract attention.  "
                       "Set an alarm anyway?" ) :
                    _( "You have an alarm clock.  Set an alarm?" );
        as_m.text += deaf_text;

        as_m.entries.emplace_back( 0, true,
                                   get_option<bool>( "FORCE_CAPITAL_YN" ) ? 'N' : 'n',
                                   _( "No, don't set an alarm." ) );

        for( int i = 3; i <= 9; ++i ) {
            as_m.entries.emplace_back( i, true, '0' + i,
                                       string_format( _( "Set alarm to wake up in %i hours." ), i ) + deaf_text );
        }

        as_m.query();
        if( !lifetime || !context || as_m.ret < 0 ) {
            return;
        }
        choice.alarm_hours = as_m.ret;
    }

    if( client ) {
        cata_mp::client_start_sleep( choice );
    } else {
        start_sleep( player_character, here, choice, activity_execution::local );
    }
}

static void wear()
{
    avatar &player_character = get_avatar();
    item_location loc = game_menus::inv::wear( player_character );

    if( loc ) {
#ifdef MP_ENABLED
        if( cata_mp::is_client_mode() ) {
            cata_mp::client_select_equipment( "wear", loc );
            return;
        }
#endif
        player_character.wear( loc );
    } else {
        add_msg( _( "Never mind." ) );
    }
}

static void takeoff()
{
    avatar &player_character = get_avatar();
    item_location loc = game_menus::inv::take_off();

    if( loc ) {
#ifdef MP_ENABLED
        if( cata_mp::is_client_mode() ) {
            cata_mp::client_select_equipment( "takeoff", loc );
            return;
        }
#endif
        player_character.takeoff( loc.obtain( player_character ) );
    } else {
        add_msg( _( "Never mind." ) );
    }
}

static void read()
{
    avatar &player_character = get_avatar();
    // Can read items from inventory or within one tile (including in vehicles)
    item_location loc = game_menus::inv::read( player_character );

    if( loc ) {
        item the_book = *loc.get_item();
        if( avatar_action::check_stealing( get_player_character(), the_book ) ) {
            item_location parent_loc = loc.parent_item();
            if( loc->type->can_use( "learn_spell" ) ) {
                the_book.get_use( "learn_spell" )->call( &player_character, the_book, player_character.pos_bub() );
            } else if( loc.is_efile() ) {
                // obtain e-storage device if not allowed to use remotely
                if( !parent_loc->has_flag( json_flag_ALLOWS_REMOTE_USE ) ) {
                    parent_loc = parent_loc.obtain( player_character );
                    item *newit = parent_loc->get_item_with( [&]( const item & it ) {
                        return it.typeId() == the_book.typeId();
                    } );
                    loc = item_location( parent_loc, &*newit );
                }
                player_character.read( loc, parent_loc );
            } else {
                if( ( parent_loc && parent_loc->has_flag( json_flag_NO_UNLOAD ) ) || loc.is_efile() ) {
                    debugmsg( "tried to get an item you shouldn't obtain." );
                }
                loc = loc.obtain( player_character );
                player_character.read( loc );
            }
        }
    } else {
        add_msg( _( "Never mind." ) );
    }
}

// Perform a reach attack
static void reach_attack( avatar &you )
{
    g->temp_exit_fullscreen();

    target_handler::trajectory traj;
    if( you.get_wielded_item() ) {
        traj = target_handler::mode_reach( you, you.get_wielded_item() );
    } else {
        traj = target_handler::mode_unarmed_reach( you );
    }

    if( !traj.empty() ) {
        if( cata_mp::is_client_mode() ) {
            cata_mp::client_request_melee( traj.back(), cata_mp::melee_action::reach );
        } else {
            you.reach_attack( traj.back() );
        }
    }
    g->reenter_fullscreen();
}

static void fire( const std::optional<tripoint_bub_ms> &selected )
{
    avatar &you = get_avatar();
    map &here = get_map();

    if( you.has_flag( json_flag_CANNOT_ATTACK ) ) {
        add_msg( m_info, _( "You are incapable of attacking!" ) );
        return;
    }

    const item_location weapon = you.get_wielded_item();
    const bool reach = weapon ? !weapon->is_gun() && weapon->current_reach_range( you ).first > 1 :
                       static_cast<int>( you.calculate_by_enchantment( 1,
                                         enchant_vals::mod::MELEE_RANGE_MODIFIER ) ) > 1;
    const bool remote_attack = ( cata_mp::is_client_mode() &&
                                 ( reach || ( weapon && is_sling_launcher( *weapon ) ) ) ) ||
                               ( weapon && cata_mp::client_uses_firearm_intents( *weapon ) );
    if( !remote_attack &&
        !you.try_break_relax_gas( _( "Your willpower asserts itself, and so do you!" ),
                                  _( "You're too pacified to strike anything…" ) ) ) {
        return;
    }

    // try reach weapon
    // used_weapon() returns null location if force unarmed is selected
    if( weapon && !you.used_weapon() && !weapon->is_gun() ) {
        add_msg( m_info, _( "You can't use reach attacks while forcing yourself to fight unarmed." ) );
        return;
    }
    if( reach ) {
        reach_attack( you );
        return;
    }
    if( you.has_trait( trait_BRAWLER ) ) {
        add_msg( m_bad, _( "You refuse to use ranged weapons." ) );
        return;
    }
    if( you.has_trait( trait_GUNSHY ) && weapon && weapon->is_firearm() ) {
        add_msg( m_bad, _( "You refuse to use firearms." ) );
        return;
    }
    if( you.has_flag( json_flag_TEMPORARY_SHAPESHIFT_NO_HANDS ) ) {
        add_msg( m_bad, _( "You have no hands and cannot use ranged weapons!" ) );
        return;
    }
    if( you.has_flag( json_flag_HANDS_CANNOT_USE_FIREARMS ) && weapon && weapon->is_firearm() ) {
        add_msg( m_bad, _( "Your hands aren't suited for using firearms!" ) );
        return;
    }
    if( weapon && is_sling_launcher( *weapon ) ) {
        avatar_action::fire_wielded_weapon( you );
        return;
    }
    // try firing gun
    if( weapon && weapon->is_gun() && !weapon->gun_current_mode().melee() ) {
        const auto target = selected ? std::optional<tripoint_abs_ms>( here.get_abs( *selected ) ) :
                            std::nullopt;
        avatar_action::fire_wielded_weapon( you, target );
        return;
    }
    // try firing turrets
    if( const optional_vpart_position ovp = here.veh_at( you.pos_abs() ) ) {
        if( turret_data turret_here = ovp->vehicle().turret_query( you.pos_abs() ) ) {
            if( avatar_action::fire_turret_manual( you, here, turret_here ) ) {
                return;
            }
        } else if( ovp.part_with_feature( VPFLAG_CONTROLS, true ) ) {
            if( ovp->vehicle().turrets_aim_and_fire_all_manual() ) {
                return;
            }
        }
    }
    // offer to draw a gun from worn holster
    std::vector<std::string> options;
    std::vector<std::function<void()>> actions;
    you.worn.fire_options( you, options, actions );
    if( !options.empty() ) {
        int sel = uilist( _( "Draw what?" ), options );
        if( sel >= 0 ) {
            actions[sel]();
#ifdef MP_ENABLED
            cata_mp::mp_client_post_action();
#endif
            return;
        }
    }
}

static void open_movement_mode_menu()
{
    avatar &player_character = get_avatar();
    const std::vector<move_mode_id> &modes = move_modes_by_speed();
    const int cycle = 1027;
    uilist as_m;

    as_m.text = _( "Change to which movement mode?" );

    for( size_t i = 0; i < modes.size(); ++i ) {
        const move_mode_id &curr = modes[i];
        std::string label = curr->name();
        const float required_moves = player_character.move_mode_switch_cost(
                                         player_character.current_movement_mode(), curr );
        const float required_seconds = required_moves / player_character.get_speed();

        if( required_seconds > 0 ) {
            label += string_format( _( " (%.2f s)" ), required_seconds );
        }

        as_m.entries.emplace_back( static_cast<int>( i ), player_character.can_switch_to( curr ),
                                   curr->letter(),
                                   label );
    }
    as_m.entries.emplace_back( cycle,
                               true, // cycling movement is controlled in relevant functions, always allow
                               hotkey_for_action( ACTION_OPEN_MOVEMENT, /*maximum_modifier_count=*/1 ),
                               _( "Cycle move mode" ) );
    // This should select the middle move mode
    as_m.selected = std::floor( modes.size() / 2 );
    as_m.query();

    if( as_m.ret != UILIST_CANCEL ) {
        if( as_m.ret == cycle ) {
            player_character.cycle_desired_move_mode();
        } else {
            player_character.set_desired_movement_mode( modes[as_m.ret] );
        }
    }
}

static void cast_spell( bool recast_spell = false )
{
    if( cata_mp::client_query_spellbook( recast_spell ) ) {
        return;
    }
    Character &player_character = get_player_character();
    player_character.magic->clear_opens_spellbook_data();
    get_event_bus().send<event_type::opens_spellbook>( player_character.getID() ); // trigger EoC
    player_character.magic->evaluate_opens_spellbook_data( player_character );
    std::vector<spell_id> spells = player_character.magic->spells();

    if( player_character.has_flag( json_flag_CANNOT_ATTACK ) ) {
        add_msg( game_message_params{ m_bad, gmf_bypass_cooldown },
                 _( "You cannot cast spells at this moment." ) );
        return;
    }
    if( spells.empty() ) {
        add_msg( game_message_params{ m_bad, gmf_bypass_cooldown },
                 _( "You don't know any spells to cast." ) );
        return;
    }

    std::map<magic_type_id, bool> success_tracker = {};
    if( !player_character.magic->can_cast_any_spell( player_character, success_tracker ) ) {
        for( auto const& [m_type, any_success] : success_tracker ) {
            if( !any_success && m_type->cannot_cast_message.has_value() ) {
                add_msg( game_message_params{ m_bad, gmf_bypass_cooldown },
                         m_type->cannot_cast_message.value() );
            }
        }
    }

    if( recast_spell && player_character.magic->last_spell.is_null() ) {
        popup( _( "Cast a spell first" ) );
        return;
    }

    spell &sp = recast_spell
                ? player_character.magic->get_spell( player_character.magic->last_spell )
                : player_character.magic->select_spell( player_character );
    // if no spell was selected
    if( sp.id().is_null() ) {
        return;
    }
    player_character.magic->last_spell = sp.id();
    player_character.cast_spell( sp, false, std::nullopt );
}

// returns true if the spell was assigned
bool Character::cast_spell( spell &sp, bool fake_spell,
                            const std::optional<tripoint_bub_ms> &target = std::nullopt )
{
    if( is_avatar() && !fake_spell ) {
        const auto handled = cata_mp::client_cast_spell( sp.id(),
                             target ? std::make_optional( get_map().get_abs( *target ) ) : std::nullopt );
        if( handled ) {
            return *handled;
        }
    }

    if( is_armed() && !sp.no_hands() && !has_flag( json_flag_SUBTLE_SPELL ) &&
        !get_wielded_item()->has_flag( flag_MAGIC_FOCUS ) && !sp.check_if_component_in_hand( *this ) ) {
        add_msg( game_message_params{ m_bad, gmf_bypass_cooldown },
                 _( "You need your hands free to cast this spell!" ) );
        return false;
    }

    if( !sp.valid_caster_condition( *this ) ) {
        add_msg( game_message_params{ m_bad, gmf_bypass_cooldown }, sp.failed_caster_condition_message() );
        return false;
    }

    if( !magic->has_enough_energy( *this, sp ) ) {
        add_msg( game_message_params{ m_bad, gmf_bypass_cooldown },
                 _( "You don't have enough %s to cast the spell." ),
                 sp.energy_string() );
        return false;
    }

    if( !sp.no_hands() && !has_flag( json_flag_SUBTLE_SPELL ) &&
        has_effect( effect_stunned ) ) {
        add_msg( game_message_params{ m_bad, gmf_bypass_cooldown },
                 _( "You can't focus enough to cast spell." ) );
        return false;
    }

    if( sp.energy_source() == magic_energy_type::hp && !has_quality( qual_CUT ) ) {
        add_msg( game_message_params{ m_bad, gmf_bypass_cooldown },
                 _( "You cannot cast Blood Magic without a cutting implement." ) );
        return false;
    }

    // The spell menu disables powers that cannot currently be cast, but other
    // entry points (notably recasting the last spell) bypass that menu.
    if( sp.has_components() ) {
        invalidate_crafting_inventory();
    }
    if( !sp.can_cast( *this ) ) {
        if( !sp.has_required_components( *this ) ) {
            add_msg( game_message_params{ m_bad, gmf_bypass_cooldown },
                     _( "You don't have the components to cast %s." ), sp.name() );
        } else {
            add_msg( game_message_params{ m_bad, gmf_bypass_cooldown },
                     _( "You cannot cast %s right now." ), sp.name() );
        }
        return false;
    }

    std::optional<int> fake_spell_level;
    if( fake_spell ) {
        fake_spell_level = sp.get_level();
    }
    std::optional<tripoint_abs_ms> abs_target;
    if( target ) {
        abs_target = get_map().get_abs( *target );
    }

    assign_activity( spellcasting_activity_actor(
                         time_duration::from_moves<int>( sp.casting_time( *this ) ),
                         sp.id(), abs_target, fake_spell_level ) );
    return true;
}

// this is here because it shares some things in common with cast_spell
bool bionic::activate_spell( Character &caster ) const
{
    if( ( !caster.is_avatar() && caster.activity.execution() != activity_execution::authoritative ) ||
        !id->spell_on_activate ) {
        // the return value tells us if the spell fails. if it has no spell it can't fail
        return true;
    }
    spell sp = id->spell_on_activate->get_spell( caster );
    return caster.cast_spell( sp, true );
}

void game::open_consume_item_menu()
{
    uilist as_m;

    as_m.text = _( "What do you want to consume?" );

    as_m.entries.emplace_back( 0, true, 'f', _( "Food" ) );
    as_m.entries.emplace_back( 1, true, 'd', _( "Drink" ) );
    as_m.entries.emplace_back( 2, true, 'm', _( "Medication" ) );
    as_m.query();

    const int query_returned_index = as_m.ret;
    if( query_returned_index >= 0 && query_returned_index < 3 ) {
        const std::array<std::string, 3> comestype_strings = { "FOOD", "DRINK", "MED" };
        const std::string &selected_comestype = comestype_strings[query_returned_index];
        uistate.open_menu = [selected_comestype = selected_comestype]() {
            avatar_action::eat_or_use( get_avatar(), game_menus::inv::consume( selected_comestype ) );
        };
    }
}

static void handle_debug_mode()
{
    auto debug_mode_setup = []( uilist_entry & entry ) -> void {
        entry.txt = string_format( _( "Debug Mode (%1$s)" ), debug_mode ? _( "ON" ) : _( "OFF" ) );
        entry.text_color = debug_mode ? c_green : c_light_gray;
    };

    // returns if entry became active
    auto debugmode_entry_setup = []( uilist_entry & entry, bool active ) -> void {
        if( active )
        {
            entry.extratxt.txt = entry.hotkey->short_description() + " " + _( "A" );
            entry.extratxt.color = c_white_green;
            entry.text_color = c_green;
        } else
        {
            entry.extratxt.txt = entry.hotkey->short_description() + " ";
            entry.extratxt.color = c_unset;
            entry.text_color = c_light_gray;
        }
    };

    input_context ctxt( "DEFAULTMODE" );
    ctxt.register_action( "debug_mode" );

    uilist dbmenu;
    dbmenu.allow_anykey = true;
    dbmenu.title = _( "Debug Mode Filters" );
    dbmenu.text = string_format( _( "Press [%1$s] to quickly toggle debug mode." ),
                                 ctxt.get_desc( "debug_mode" ) );

    dbmenu.entries.reserve( 1 + debugmode::DF_LAST );

    dbmenu.addentry( 0, true, 'd', " " );
    debug_mode_setup( dbmenu.entries[0] );

    dbmenu.addentry( 1, true, 't', _( "Toggle all filters" ) );
    bool toggle_value = true;
    const hotkey_queue &hotkeys = hotkey_queue::alpha_digits();
    input_event assigned_hotkey = ctxt.first_unassigned_hotkey( hotkeys );
    int reserved_character_d = 'd';
    int reserved_character_t = 't';

    for( int i = 0; i < debugmode::DF_LAST; ++i ) {
        uilist_entry entry( i + 2, true, assigned_hotkey,
                            "  " + debugmode::filter_name( static_cast<debugmode::debug_filter>( i ) ) );
        assigned_hotkey = ctxt.next_unassigned_hotkey( hotkeys, assigned_hotkey );
        // Skip d and t, special cased
        if( assigned_hotkey.sequence.front() == reserved_character_d ||
            assigned_hotkey.sequence.front() == reserved_character_t ) {
            assigned_hotkey = hotkeys.next( assigned_hotkey );
        }

        entry.extratxt.left = 1;

        const bool active = debugmode::enabled_filters.count( static_cast<debugmode::debug_filter>
                            ( i ) ) == 1;

        if( toggle_value && active ) {
            toggle_value = false;
        }

        debugmode_entry_setup( entry, active );
        dbmenu.entries.push_back( entry );
    }

    do {
        dbmenu.query();
        if( ctxt.input_to_action( dbmenu.ret_evt ) == "debug_mode" ) {
            debug_mode = !debug_mode;
            if( debug_mode ) {
                add_msg( m_info, _( "Debug mode ON!" ) );
            } else {
                add_msg( m_info, _( "Debug mode OFF!" ) );
            }
            break;
        }

        if( dbmenu.ret == 0 ) {
            debug_mode = !debug_mode;
            debug_mode_setup( dbmenu.entries[0] );

        } else if( dbmenu.ret == 1 ) {
            debugmode::enabled_filters.clear();

            for( int i = 0; i < debugmode::DF_LAST; ++i ) {
                debugmode_entry_setup( dbmenu.entries[i + 2], toggle_value );

                if( toggle_value ) {
                    debugmode::enabled_filters.emplace( static_cast<debugmode::debug_filter>( i ) );
                }
            }

            toggle_value = !toggle_value;

        } else if( dbmenu.ret > 1 ) {
            uilist_entry &entry = dbmenu.entries[dbmenu.ret];

            const auto filter_iter = debugmode::enabled_filters.find( static_cast<debugmode::debug_filter>
                                     ( dbmenu.ret - 2 ) );

            const bool active = filter_iter != debugmode::enabled_filters.end();

            debugmode_entry_setup( entry, !active );

            if( active ) {
                debugmode::enabled_filters.erase( filter_iter );
            } else {
                debugmode::enabled_filters.emplace(
                    static_cast<debugmode::debug_filter>( dbmenu.ret - 2 ) );
            }
        }
    } while( dbmenu.ret != UILIST_CANCEL );
}

static bool has_vehicle_control( avatar &player_character )
{
    map &here = get_map();

    if( player_character.is_dead_state() ) {
        return false;
    }
    const optional_vpart_position vp = here.veh_at( player_character.pos_bub() );
    if( vp && vp->vehicle().player_in_control( here, player_character ) ) {
        return true;
    }
    return g->remoteveh() != nullptr;
}

static void do_deathcam_action( const action_id &act, avatar &player_character )
{
    switch( act ) {
        case ACTION_CENTER:
            player_character.view_offset.x() = g->driving_view_offset.x();
            player_character.view_offset.y() = g->driving_view_offset.y();
            player_character.view_offset.z() = 0;
            break;

        case ACTION_SHIFT_N:
        case ACTION_SHIFT_NE:
        case ACTION_SHIFT_E:
        case ACTION_SHIFT_SE:
        case ACTION_SHIFT_S:
        case ACTION_SHIFT_SW:
        case ACTION_SHIFT_W:
        case ACTION_SHIFT_NW: {
            static const std::map<action_id, std::pair<point, point>> shift_delta = {
                { ACTION_SHIFT_N, { point::north, point::north_east } },
                { ACTION_SHIFT_NE, { point::north_east, point::east } },
                { ACTION_SHIFT_E, { point::east, point::south_east } },
                { ACTION_SHIFT_SE, { point::south_east, point::south } },
                { ACTION_SHIFT_S, { point::south, point::south_west } },
                { ACTION_SHIFT_SW, { point::south_west, point::west } },
                { ACTION_SHIFT_W, { point::west, point::north_west } },
                { ACTION_SHIFT_NW, { point::north_west, point::north } },
            };
            int soffset = get_option<int>( "MOVE_VIEW_OFFSET" );
            player_character.view_offset += g->is_tileset_isometric()
                                            ? shift_delta.at( act ).second * soffset
                                            : shift_delta.at( act ).first * soffset;
        }
        break;

        case ACTION_LOOK:
            g->look_around();
            break;

        case ACTION_KEYBINDINGS: // already handled by input context
        default:
            break;
    }
}

static std::map<action_id, std::string> get_actions_disabled_in_shell()
{
    return std::map<action_id, std::string> {
        { ACTION_OPEN,               _( "You can't open things while you're in your shell." ) },
        { ACTION_CLOSE,              _( "You can't close things while you're in your shell." ) },
        { ACTION_SMASH,              _( "You can't smash things while you're in your shell." ) },
        { ACTION_EXAMINE,            _( "You can't examine your surroundings while you're in your shell." ) },
        { ACTION_EXAMINE_AND_PICKUP, _( "You can't examine your surroundings while you're in your shell." ) },
        { ACTION_ADVANCEDINV,        _( "You can't move mass quantities while you're in your shell." ) },
        { ACTION_PICKUP,             _( "You can't pick anything up while you're in your shell." ) },
        { ACTION_PICKUP_ALL,         _( "You can't pick anything up while you're in your shell." ) },
        { ACTION_GRAB,               _( "You can't grab things while you're in your shell." ) },
        { ACTION_HAUL,               _( "You can't haul things while you're in your shell." ) },
        { ACTION_HAUL_TOGGLE,        _( "You can't haul things while you're in your shell." ) },
        { ACTION_BUTCHER,            _( "You can't butcher while you're in your shell." ) },
        { ACTION_PEEK,               _( "You can't peek around corners while you're in your shell." ) },
        { ACTION_DROP,               _( "You can't drop things while you're in your shell." ) },
        { ACTION_CRAFT,              _( "You can't craft while you're in your shell." ) },
        { ACTION_RECRAFT,            _( "You can't craft while you're in your shell." ) },
        { ACTION_LONGCRAFT,          _( "You can't craft while you're in your shell." ) },
        { ACTION_DISASSEMBLE,        _( "You can't disassemble while you're in your shell." ) },
        { ACTION_CONSTRUCT,          _( "You can't construct while you're in your shell." ) },
        { ACTION_CONTROL_VEHICLE,    _( "You can't operate a vehicle while you're in your shell." ) },
        { ACTION_VEHICLE_TURNING_ASSIST, _( "You can't operate a vehicle while you're in your shell." ) },
    };
}

static const std::set<action_id> actions_disabled_in_incorporeal {
    ACTION_OPEN,
    ACTION_CLOSE,
    ACTION_SMASH,
    ACTION_ADVANCEDINV,
    ACTION_PICKUP,
    ACTION_PICKUP_ALL,
    ACTION_DROP,
    ACTION_DIR_DROP,
    ACTION_GRAB,
    ACTION_HAUL,
    ACTION_HAUL_TOGGLE,
    ACTION_BUTCHER,
    ACTION_CRAFT,
    ACTION_RECRAFT,
    ACTION_LONGCRAFT,
    ACTION_DISASSEMBLE,
    ACTION_CONSTRUCT,
    ACTION_CONTROL_VEHICLE,
    ACTION_VEHICLE_TURNING_ASSIST,
};

static std::map<action_id, std::string> get_actions_disabled_in_handless_temporary_shapeshift()
{
    return std::map<action_id, std::string> {
        { ACTION_OPEN,               _( "You can't open things while shapeshifted." ) },
        { ACTION_CLOSE,              _( "You can't close things while shapeshifted." ) },
        { ACTION_ADVANCEDINV,        _( "You can't move mass quantities while shapeshifted." ) },
        { ACTION_PICKUP,             _( "You can't pick anything up while shapeshifted." ) },
        { ACTION_PICKUP_ALL,         _( "You can't pick anything up while shapeshifted." ) },
        { ACTION_GRAB,               _( "You can't grab things while shapeshifted." ) },
        { ACTION_HAUL,               _( "You can't haul things while shapeshifted." ) },
        { ACTION_HAUL_TOGGLE,        _( "You can't haul things while shapeshifted." ) },
        { ACTION_BUTCHER,            _( "You can't butcher while shapeshifted." ) },
        { ACTION_DROP,               _( "You can't drop things while shapeshifted." ) },
        { ACTION_DIR_DROP,           _( "You can't drop things while shapeshifted." ) },
        { ACTION_CRAFT,              _( "You can't craft while shapeshifted." ) },
        { ACTION_RECRAFT,            _( "You can't craft while shapeshifted." ) },
        { ACTION_LONGCRAFT,          _( "You can't craft while shapeshifted." ) },
        { ACTION_DISASSEMBLE,        _( "You can't disassemble while shapeshifted." ) },
        { ACTION_CONSTRUCT,          _( "You can't construct while shapeshifted." ) },
        { ACTION_CONTROL_VEHICLE,    _( "You can't operate a vehicle while shapeshifted." ) },
        { ACTION_VEHICLE_TURNING_ASSIST, _( "You can't operate a vehicle while shapeshifted." ) },
    };
}

static std::map<action_id, std::string> get_actions_disabled_mounted()
{
    return std::map<action_id, std::string> {
        { ACTION_DISASSEMBLE,        _( "You can't disassemble items while you're riding." ) },
        { ACTION_CONSTRUCT,          _( "You can't construct while you're riding." ) },
        { ACTION_OPEN,               _( "You can't open things while you're riding." ) },
        { ACTION_ADVANCEDINV,        _( "You can't move mass quantities while you're riding." ) },
        { ACTION_PICKUP,             _( "You can't pick anything up while you're riding." ) },
        { ACTION_PICKUP_ALL,         _( "You can't pick anything up while you're riding." ) },
        { ACTION_GRAB,               _( "You can't grab things while you're riding." ) },
        { ACTION_HAUL,               _( "You can't haul things while you're riding." ) },
        { ACTION_HAUL_TOGGLE,        _( "You can't haul things while you're riding." ) },
        { ACTION_BUTCHER,            _( "You can't butcher while you're riding." ) },
        { ACTION_PEEK,               _( "You can't peek around corners while you're riding." ) },
        { ACTION_CRAFT,              _( "You can't craft while you're riding." ) },
        { ACTION_RECRAFT,            _( "You can't craft while you're riding." ) },
        { ACTION_LONGCRAFT,          _( "You can't craft while you're riding." ) },
    };
}

static std::vector<action_id> get_actions_move_mode()
{
    return std::vector<action_id> {
        ACTION_CYCLE_MOVE,
        ACTION_CYCLE_MOVE_REVERSE,
        ACTION_RESET_MOVE,
        ACTION_TOGGLE_RUN,
        ACTION_TOGGLE_CROUCH,
        ACTION_TOGGLE_PRONE,
        ACTION_OPEN_MOVEMENT,
    };
}

#ifdef MP_ENABLED
// Actions the host may take while locked (moves <= 0, waiting for client).
static const std::set<action_id> host_ui_actions = {
    ACTION_ZOOM_IN, ACTION_ZOOM_OUT,
    ACTION_MAP, ACTION_LIST_ITEMS,
    ACTION_INVENTORY, ACTION_COMPARE, ACTION_ORGANIZE,
    ACTION_LOOK,
    ACTION_HELP, ACTION_MESSAGES,
    ACTION_PL_INFO, ACTION_MORALE,
    ACTION_FACTIONS, ACTION_MISSIONS, ACTION_MEDICAL,
    ACTION_MUTATIONS, ACTION_BIONICS,
    ACTION_DIARY,
    ACTION_PICKUP, ACTION_PICKUP_ALL, ACTION_LOOT,
    ACTION_CRAFT, ACTION_RECRAFT, ACTION_LONGCRAFT,
    ACTION_DISASSEMBLE,
    ACTION_BUTCHER,
    ACTION_TOGGLE_RUN, ACTION_TOGGLE_CROUCH, ACTION_TOGGLE_PRONE,
    ACTION_CYCLE_MOVE, ACTION_CYCLE_MOVE_REVERSE,
    ACTION_OPTIONS, ACTION_TOGGLE_PANEL_ADM,
    ACTION_AUTOPICKUP, ACTION_AUTONOTES,
    ACTION_SAFEMODE, ACTION_DISTRACTION_MANAGER,
    ACTION_TOGGLE_SAFEMODE, ACTION_TOGGLE_AUTOSAFE,
    ACTION_IGNORE_ENEMY, ACTION_WHITELIST_ENEMY,
    ACTION_COLOR, ACTION_WORLD_MODS,
    ACTION_QUICKSAVE, ACTION_SAVE,
    ACTION_KEYBINDINGS,
    ACTION_MAIN_MENU,
    ACTION_EXPORT_BUG_REPORT_ARCHIVE,
    ACTION_MANAGE_ANDROID_EXTRA_BUTTONS,
    ACTION_COOP_CHAT,
    ACTION_COOP_SESSION,
};
#endif

#if defined(__ANDROID__)
static void manage_android_buttons()
{
    JNIEnv *env = ( JNIEnv * )GetAndroidJNIEnv();
    jobject activity = ( jobject )GetAndroidActivity();
    if( env == nullptr || activity == nullptr ) {
        return;
    }
    jclass clazz( env->GetObjectClass( activity ) );
    if( clazz == nullptr ) {
        env->DeleteLocalRef( activity );
        return;
    }
    jmethodID method_id = env->GetMethodID( clazz, "showButtonManage", "()V" );
    if( env->ExceptionCheck() ) {
        env->ExceptionClear();
    }
    if( method_id != nullptr ) {
        env->CallVoidMethod( activity, method_id );
    }
    env->DeleteLocalRef( activity );
    env->DeleteLocalRef( clazz );
}
#endif

static std::optional<point> fractional_walk_input( const avatar &who, const map &here,
        action_id action, bool auto_travel, const camera_input *camera )
{
    if( !camera || who.is_auto_moving() || auto_travel ||
        !avatar_action::can_move_fractional( who, here ) ) {
        return std::nullopt;
    }
    const point delta = fractional_walk::camera_delta( get_delta_from_movement_action( action,
        iso_rotate::no ).raw(), camera->forward );
    if( who.get_grab_type() != object_type::NONE ) {
        const auto step = fractional_walk::resolve( who.pos_world(), delta );
        if( !step || !step->supports_grab( who, here ) ) {
            return std::nullopt;
        }
    }
    return delta;
}

// NOLINTNEXTLINE(readability-function-size)
bool game::do_regular_action( action_id &act, avatar &player_character,
                              const std::optional<tripoint_bub_ms> &mouse_target,
                              const camera_input *camera )
{
#if defined(__ANDROID__)
    // Android button management is a Java-side screen.  Handle it before
    // touching map/terrain or movement-mode state; the main-menu path can be
    // entered while those world objects are not ready for a regular action.
    if( act == ACTION_MANAGE_ANDROID_EXTRA_BUTTONS ) {
        if( android_ui_mode::is_new_ui_build() ) {
            android_native_ui::show_android_hud_manager();
        } else {
            manage_android_buttons();
        }
        return false;
    }
#endif

#ifdef MP_ENABLED
    // MP-HOOK: verify - client action dispatch block. The MP version places
    // this at the start of do_regular_action before local variable declarations.
    // CCB's surrounding context (mount/shell/incorporeal/shapeshift checks) is
    // moved after the MP block; verify these still gate correctly for MP actions.
    // Movement collects choices here; the server executes the common native
    // movement path. Never predict stamina, traps, theft or gameplay RNG here.
    if( cata_mp::is_client_mode() ) {
        const bool mp_locked = player_character.get_moves() <= 0;

        // Pure display/UI actions — always free, work even while locked.
        if( act == ACTION_ZOOM_IN ) {
            zoom_in();
            return false;
        }
        if( act == ACTION_ZOOM_OUT ) {
            zoom_out();
            return false;
        }
        if( act == ACTION_LIST_ITEMS ) {
            list_surroundings();
            return false;
        }
        if( act == ACTION_MORALE ) {
            player_character.disp_morale();
            return false;
        }

        if( act == ACTION_SUICIDE ) {
            add_msg( m_info, _( "Abandoning a character is unavailable to co-op guests." ) );
            return false;
        }

        if( mp_locked ) {
            static const std::set<action_id> menu_allowed_while_locked = {
                ACTION_PICKUP, ACTION_PICKUP_ALL,
                ACTION_BUTCHER, ACTION_LOOT,
                ACTION_CRAFT, ACTION_RECRAFT, ACTION_LONGCRAFT,
                ACTION_DISASSEMBLE,
            };
            static const std::set<action_id> blocked_while_locked = {
                ACTION_WEAR, ACTION_TAKE_OFF, ACTION_WIELD,
                ACTION_EAT, ACTION_OPEN_CONSUME,
                ACTION_DROP, ACTION_DIR_DROP,
                ACTION_UNLOAD, ACTION_UNLOAD_CONTAINER, ACTION_INSERT_ITEM,
                ACTION_MEND, ACTION_SORT_ARMOR,
                ACTION_RELOAD_ITEM, ACTION_RELOAD_WEAPON, ACTION_RELOAD_WIELDED,
                ACTION_USE, ACTION_USE_WIELDED, ACTION_READ,
                ACTION_PASS_ITEM, ACTION_HIGH_FIVE,
                ACTION_CHAT,
                ACTION_FIRE, ACTION_FIRE_BURST, ACTION_AUTOATTACK, ACTION_ACTIVE_TECHNIQUE,
                ACTION_THROW, ACTION_THROW_WIELDED,
                ACTION_CAST_SPELL, ACTION_RECAST_SPELL,
                ACTION_SMASH,
                ACTION_CONSTRUCT,
                ACTION_GRAB, ACTION_HAUL, ACTION_HAUL_TOGGLE,
                ACTION_OPEN, ACTION_CLOSE, ACTION_PEEK,
                ACTION_EXAMINE, ACTION_EXAMINE_AND_PICKUP,
                ACTION_CONTROL_VEHICLE,
                ACTION_SLEEP, ACTION_WORKOUT, ACTION_WAIT,
            };
            if( menu_allowed_while_locked.count( act ) ) {
                cata_mp::mp_log( "[cdda-mp] CLI-LOCKED-ALLOW: act=" +
                                 std::to_string( act ) );
            } else if( blocked_while_locked.count( act ) ) {
                cata_mp::mp_log( "[cdda-mp] CLI-LOCKED-BLOCK: act=" +
                                 std::to_string( act ) );
                return false;
            }
        }

        const auto mp_dispatch = [&]( const std::string &json ) {
            const bool had_grant = player_character.get_moves() > 0;
            cata_mp::mp_log( std::string( "[cdda-mp] mp_dispatch act=" ) +
                             action_ident( act ) + " path=" +
                             ( had_grant && !cata_mp::is_client_waiting_for_ack() ? "SEND" : "DROP" ) +
                             " moves=" + std::to_string( player_character.get_moves() ) +
                             " ack=" + std::to_string( cata_mp::is_client_waiting_for_ack() ) +
                             " json=" + json.substr( 0, 60 ) );
            if( had_grant && !cata_mp::is_client_waiting_for_ack() ) {
                cata_mp::client_send( cata_mp::client_enrich_action( json ) );
                player_character.set_moves( 0 );
                cata_mp::client_mark_action_sent();
            }
        };

        if( act == ACTION_MOVE_UP || act == ACTION_MOVE_DOWN ) {
            if( mp_locked || cata_mp::is_client_waiting_for_ack() || player_character.activity ) {
                return false;
            }
            map &here = get_map();
            const int direction = act == ACTION_MOVE_UP ? 1 : -1;
            if( vehicle *craft = controlled_vehicle( player_character, here ); craft &&
                craft->is_aircraft( here ) ) {
                mp_dispatch( R"({"type":"action","action":"pldrive","dz":)" +
                             std::to_string( direction ) + "}" );
            } else {
                cata_mp::client_query_vertical_move( direction );
            }
            return true;
        }

        if( const point_rel_ms delta = get_delta_from_movement_action( act, iso_rotate::no );
            delta != point_rel_ms::zero ) {
            map &here = get_map();
            if( has_radio_car_binding( player_character ) ) {
                cata_mp::client_drive_radio_car( get_delta_from_movement_action( act, iso_rotate::yes, camera ) );
                return true;
            }
            // Vehicle control mode: route movement to pldrive instead of walk.
            if( cata_mp::client_ctrl_veh() ) {
                cata_mp::mp_log( "[cdda-mp] MOVE-EXIT: ctrl_veh path" );
                if( delta.x() != 0 ) {
                    const std::string json = "{\"type\":\"action\",\"action\":\"pldrive\""
                                             ",\"dx\":" + std::to_string( delta.x() ) +
                                             ",\"dy\":" + std::to_string( delta.y() ) + "}";
                    mp_dispatch( json );
                } else if( delta.y() != 0 ) {
                    mp_dispatch( R"({"type":"action","action":"cruise","dy":)" +
                                 std::to_string( delta.y() ) + "}" );
                }
                return true;
            }

            if( mp_locked || cata_mp::is_client_waiting_for_ack() || player_character.activity ) {
                return false;
            }
            const auto fractional = fractional_walk_input( player_character, here, act, auto_travel_mode,
                camera );
            const auto step = fractional ? fractional_walk::resolve( player_character.pos_world(),
                *fractional ) : std::nullopt;
            if( fractional && !step ) {
                return false;
            }
            const tripoint_rel_ms direction = step ? step->target.tile() - player_character.pos_abs() :
                                              tripoint_rel_ms( get_delta_from_movement_action( act, iso_rotate::yes, camera ), 0 );
            tripoint_bub_ms target_pos = player_character.pos_bub( here ) + direction;
            if( direction != tripoint_rel_ms::zero ) {
                target_pos.z() += here.ramp_z_offset( target_pos );
            }
            if( !here.has_loaded_submap( target_pos ) ||
                ( step && !step->clears_obstacles( here, player_character, target_pos ) ) ) {
                if( player_character.is_auto_moving() ) {
                    player_character.abort_automove();
                }
                return false;
            }
            if( direction != tripoint_rel_ms::zero &&
                cata_mp::client_auto_mine( here.get_abs( target_pos ) ) ) {
                return true;
            }
            if( Creature *target = direction == tripoint_rel_ms::zero ? nullptr :
                                   get_creature_tracker().creature_at( target_pos, true ) ) {
                if( target->as_npc() && player_character.is_auto_moving() ) {
                    player_character.add_msg_if_player( _( "NPC in the way, Auto move canceled." ) );
                    player_character.abort_automove();
                    return true;
                }
                if( npc *person = target->as_npc(); person && !person->is_enemy() ) {
                    npc_menu( *person );
                    return true;
                }
                const monster *mon = target->as_monster();
                const bool submerged = mon && mon->is_underwater() &&
                                       here.has_flag( ter_furn_flag::TFLAG_SWIM_UNDER, target_pos );
                if( !submerged && ( !mon || ( mon->friendly == 0 && !mon->has_effect( effect_pet ) ) ) ) {
                    if( player_character.is_auto_moving() ) {
                        player_character.add_msg_if_player( m_warning, _( "Monster in the way.  Auto move canceled." ) );
                        player_character.abort_automove();
                        return true;
                    }
                    if( !mon || avatar_action::confirm_non_hostile_melee_attack( player_character, *mon ) ) {
                        cata_mp::client_request_melee( target_pos, cata_mp::melee_action::strike );
                    }
                    return true;
                }
            }
            const auto hazards = direction == tripoint_rel_ms::zero ? std::vector<std::string>() :
                                 get_dangerous_tile( player_character, target_pos );
            if( hazards.size() == 1 && hazards.front() == "ledge" ) {
                cata_mp::client_query_ledge_move( here.get_abs( target_pos ) );
                return true;
            }
            const auto choices = avatar_action::query_walk( player_character, here, direction,
                step ? &*step : nullptr );
            if( choices ) {
                cata_mp::client_walk( direction, *choices, fractional );
            } else if( player_character.is_auto_moving() ) {
                player_character.abort_automove();
            }
            return true;
        }
        if( act == ACTION_PAUSE ) {
            if( player_character.activity && player_character.activity.is_interruptible_with_kb() ) {
                g->cancel_activity_query( _( "Confirm:" ) );
                return true;
            }
            mp_dispatch( R"({"type":"action","action":"wait"})" );
            return true;
        }
        if( act == ACTION_WAIT ) {
            wait();
            return true;
        }
        if( act == ACTION_SMASH && cata_mp::client_ctrl_veh() ) {
            mp_dispatch( R"({"type":"action","action":"handbrake"})" );
            return true;
        }
        if( act == ACTION_SMASH ) {
            smash();
            return true;
        }
        if( act == ACTION_OPEN ) {
            const std::optional<tripoint_bub_ms> doorpos =
                choose_adjacent( _( "Open where?" ), false );
            if( !doorpos ) {
                return true;
            }
            // Submit the target; only the server mutates the door and charges
            // the action. Prediction must not duplicate sounds or gameplay RNG.
            const tripoint_abs_ms abs_target = get_map().get_abs( *doorpos );
            const std::string json =
                R"({"type":"action","action":"open","x":)" + std::to_string( abs_target.x() ) +
                ",\"y\":" + std::to_string( abs_target.y() ) +
                ",\"z\":" + std::to_string( abs_target.z() ) + "}";
            mp_dispatch( json );
            return true;
        }
        if( act == ACTION_CLOSE ) {
            const std::optional<tripoint_bub_ms> doorpos =
                choose_adjacent( _( "Close where?" ), false );
            if( !doorpos ) {
                return true;
            }
            // Closing, like opening, is settled by the server only.
            const tripoint_abs_ms abs_target = get_map().get_abs( *doorpos );
            const std::string json =
                R"({"type":"action","action":"close","x":)" + std::to_string( abs_target.x() ) +
                ",\"y\":" + std::to_string( abs_target.y() ) +
                ",\"z\":" + std::to_string( abs_target.z() ) + "}";
            mp_dispatch( json );
            return true;
        }

        if( act == ACTION_SLEEP ) {
            sleep();
            return true;
        }

        if( act == ACTION_LOOK ) {
            const int moves_before = player_character.get_moves();
            g->look_around();
            if( player_character.get_moves() < moves_before ) {
                mp_dispatch( R"({"type":"action","action":"wait"})" );
                return true;
            }
            return false;
        }

        if( act == ACTION_PICKUP || act == ACTION_PICKUP_ALL ) {
            if( act == ACTION_PICKUP_ALL ) {
                pickup_all();
            } else {
                pickup();
            }
            return true;
        }

        if( act == ACTION_DROP || act == ACTION_DIR_DROP ) {
            tripoint_bub_ms drop_pos = player_character.pos_bub();
            if( act == ACTION_DIR_DROP ) {
                const std::optional<tripoint_bub_ms> pnt = choose_adjacent( _( "Drop where?" ) );
                if( !pnt ) {
                    return true;
                }
                drop_pos = *pnt;
            }
            drop_in_direction( drop_pos );
            if( player_character.activity ) {
                add_msg( m_info, _( "Now dropping items, %s to interrupt." ),
                         press_x( ACTION_PAUSE ) );
            }
            return true;
        }

        if( act == ACTION_WEAR ) {
            wear();
            return true;
        }

        if( act == ACTION_TAKE_OFF ) {
            takeoff();
            return true;
        }

        if( act == ACTION_CONTROL_VEHICLE ) {
            cata_mp::client_query_vehicle_control();
            return true;
        }

    }

    // Host waiting for client action: allow pure UI actions, block everything else.
    if( cata_mp::is_hosting() && player_character.get_moves() <= 0 ) {
        if( !host_ui_actions.count( act ) ) {
            cata_mp::mp_log( "[cdda-mp] HOST-LOCKED-BLOCK: act=" + std::to_string( act ) );
            return false;
        }
        cata_mp::mp_log( "[cdda-mp] HOST-LOCKED-ALLOW: act=" + std::to_string( act ) );
    }
#endif

    map &here = get_map();

    item_location weapon = player_character.get_wielded_item();
    const bool in_shell = player_character.has_active_mutation( trait_SHELL2 )
                          || player_character.has_active_mutation( trait_SHELL3 );

    const std::map<action_id, std::string> actions_disabled_mounted = get_actions_disabled_mounted();
    const std::map<action_id, std::string> actions_disabled_in_shell = get_actions_disabled_in_shell();
    const std::map<action_id, std::string> actions_disabled_while_handless_shapeshifted =
        get_actions_disabled_in_handless_temporary_shapeshift();

    if( in_shell && actions_disabled_in_shell.count( act ) > 0 ) {
        add_msg( m_info, actions_disabled_in_shell.at( act ) );
        return true;
    }

    if( u.has_effect( effect_incorporeal ) && actions_disabled_in_incorporeal.count( act ) > 0 ) {
        add_msg( m_info, _( "You lack the substance to affect anything." ) );
        return true;
    }

    if( u.has_flag( json_flag_TEMPORARY_SHAPESHIFT_NO_HANDS ) &&
        actions_disabled_while_handless_shapeshifted.count( act ) > 0 ) {
        add_msg( m_info, _( "You can't do that while shapeshifted." ) );
        return true;
    }

    if( player_character.is_mounted() && actions_disabled_mounted.count( act ) > 0 ) {
        add_msg( m_info, actions_disabled_mounted.at( act ) );
        return true;
    }

    const std::vector<action_id> actions_move_mode = get_actions_move_mode();
    const bool is_actions_move_mode = std::find( actions_move_mode.begin(),
                                      actions_move_mode.end(), act ) != actions_move_mode.end();
    // Are we performing an action that is not a move mode action?
    int desired_move_mode_cost = 0;
    if( player_character.is_waiting_to_change_mode_mode() && !is_actions_move_mode ) {
        move_mode_id desired_move = player_character.get_desired_move_mode();
        if( player_character.can_switch_to( desired_move ) ) {
            desired_move_mode_cost = player_character.move_mode_switch_cost( player_character.move_mode,
                                     desired_move );
            player_character.set_movement_mode( desired_move );
            if( player_character.move_mode == desired_move ) {
                player_character.mod_moves( -desired_move_mode_cost );
            } else {
                debugmsg( "Player unable to change from move_mode(%s) to desired_move_mode(%s)",
                          player_character.move_mode.c_str(), desired_move.c_str() );
            }
        }
    }

    switch( act ) {
        case ACTION_NULL: // dummy entry
        case NUM_ACTIONS: // dummy entry
        case ACTION_ACTIONMENU: // handled above
        case ACTION_MAIN_MENU:
        case ACTION_KEYBINDINGS:
            break;

        case ACTION_TIMEOUT:
#ifdef MP_ENABLED
            if( cata_mp::is_client_mode() && player_character.activity ) {
                break;
            }
#endif
            if( check_safe_mode_allowed( false ) ) {
                player_character.pause();
            }
            break;

        case ACTION_PAUSE:
            if( check_safe_mode_allowed() ) {
                player_character.pause();
            }
            break;

        case ACTION_CYCLE_MOVE:
            player_character.cycle_desired_move_mode();
            break;

        case ACTION_CYCLE_MOVE_REVERSE:
            player_character.cycle_desired_move_mode_reverse();
            break;

        case ACTION_RESET_MOVE:
            player_character.set_walk_mode_desired();
            break;

        case ACTION_TOGGLE_RUN:
            player_character.toggle_run_mode_desired();
            break;

        case ACTION_TOGGLE_CROUCH:
            player_character.toggle_crouch_mode_desired();
            break;

        case ACTION_TOGGLE_PRONE:
            player_character.toggle_prone_mode_desired();
            break;

        case ACTION_OPEN_MOVEMENT:
            open_movement_mode_menu();
            break;

        case ACTION_MOVE_FORTH:
        case ACTION_MOVE_FORTH_RIGHT:
        case ACTION_MOVE_RIGHT:
        case ACTION_MOVE_BACK_RIGHT:
        case ACTION_MOVE_BACK:
        case ACTION_MOVE_BACK_LEFT:
        case ACTION_MOVE_LEFT:
        case ACTION_MOVE_FORTH_LEFT:
            if( has_radio_car_binding( player_character ) ) {
                if( const auto binding = read_radio_car_binding( player_character, here ) ) {
                    drive_radio_car( player_character, here,
                                     get_delta_from_movement_action( act, iso_rotate::yes, camera ), *binding );
                } else {
                    disconnect_radio_car( player_character );
                }
            } else if( has_vehicle_control( player_character ) ) {
                // vehicle control uses x for steering and y for ac/deceleration,
                // so no rotation needed
                pldrive( get_delta_from_movement_action( act, iso_rotate::no ) );
            } else {
                const int pre_walk_moves = player_character.get_moves();
                point_rel_ms dest_delta = get_delta_from_movement_action( act, iso_rotate::yes, camera );
                if( auto_travel_mode && !player_character.is_auto_moving() ) {
                    const bool use_grab_routing =
                        has_grabbed_single_tile_vehicle( player_character, here );
                    for( int i = 0; i < SEEX; i++ ) {
                        tripoint_bub_ms auto_travel_destination =
                            player_character.pos_bub() + dest_delta * ( SEEX - i );
                        if( use_grab_routing ) {
                            destination_preview = route_with_grab( here, player_character,
                                                                   pathfinding_target::point( auto_travel_destination ),
                                                                   player_character.get_path_avoid() );
                        } else {
                            destination_preview =
                                here.route( player_character, pathfinding_target::point( auto_travel_destination ) );
                        }
                        if( !destination_preview.empty() ) {
                            destination_preview.erase(
                                destination_preview.begin() + 1, destination_preview.end() );
                            player_character.set_destination( destination_preview );
                            break;
                        }
                    }
                    act = player_character.get_next_auto_move_direction();
                    const point_rel_ms dest_next = get_delta_from_movement_action( act, iso_rotate::yes );
                    if( dest_next == point_rel_ms::zero ) {
                        add_msg_debug( debugmode::DF_ACTIVITY,
                                       "auto_move: get_next returned zero, aborting.  pos=(%d,%d)",
                                       player_character.pos_bub().x(), player_character.pos_bub().y() );
                        player_character.abort_automove();
                    }
                    dest_delta = dest_next;
                }
                tripoint_bub_ms landing = player_character.pos_bub( here ) + dest_delta;
                if( player_character.is_auto_moving() && dest_delta != point_rel_ms::zero &&
                    here.has_loaded_submap( landing ) ) {
                    landing.z() += here.ramp_z_offset( landing );
                }
                const auto pending_move = capture_automove_step( player_character, here,
                    here.get_abs( landing ) );
                const character_action_guard mover( player_character );
                const auto move_context = here.get_context_reference();
                const auto fractional = fractional_walk_input( player_character, here, act,
                    auto_travel_mode || pending_move.has_value(), camera );
                const bool moved = fractional ?
                                   avatar_action::move_fractional( player_character, here, *fractional ) :
                                   avatar_action::move( player_character, here, tripoint_rel_ms( dest_delta, 0 ) );
                if( !mover ) {
                    return true;
                }
                if( pending_move ) {
                    pending_move->finish( player_character, here, !moved );
                }
                if( !move_context ) {
                    return true;
                }

                // QQ#183: while auto-moving (auto travel mode or destination
                // travel), pace to the slowest following NPC so the party stays
                // together.  If a follower slower than the avatar has fallen
                // behind, spend the rest of the turn waiting for it to catch up
                // instead of stepping away again.
                if( player_character.is_auto_moving() && !player_character.in_vehicle ) {
                    npc *slowest_follower = nullptr;
                    int worst_lag = 0;
                    const int player_speed = player_character.get_speed();
                    for( npc *guy : g->get_npcs_if( []( const npc & n ) {
                    return n.is_walking_with() && n.can_follow_player_now();
                    } ) ) {
                        if( guy->get_speed() >= player_speed ) {
                            continue;
                        }
                        const int lag = rl_dist( guy->pos_bub(), player_character.pos_bub() );
                        if( lag > worst_lag ) {
                            worst_lag = lag;
                            slowest_follower = guy;
                        }
                    }
                    if( slowest_follower != nullptr ) {
                        const int threshold =
                            std::max( slowest_follower->desired_follow_radius() + 1, 4 );
                        // Only pace while the follower is still on the way; a far-away
                        // or stuck follower must not stop travel forever.
                        if( worst_lag > threshold && worst_lag < 20 ) {
                            player_character.set_moves( 0 );
                            add_msg( m_info, _( "You slow down to let %s catch up." ),
                                     slowest_follower->get_name() );
                        }
                    }
                }

                // if we changed move modes this action, refund half the cost of changing move mode
                // if their move action was an easy movement to represent combining the two actions
                if( desired_move_mode_cost > 0 ) {
                    const int moves_delta = pre_walk_moves - player_character.get_moves();
                    // add 10% to the easy movement threshold to allow for some minor encumbrance
                    // add 20% if going prone because it has an extra 20% crawling mod
                    const int easy_moves = 110 /
                                           player_character.get_modifier( character_modifier_move_mode_move_cost_mod ) *
                                           ( player_character.is_prone() ? 1.2 : 1 );

                    if( moves_delta > 0 && moves_delta <= easy_moves ) {
                        player_character.mod_moves( desired_move_mode_cost / 2 );
                    }
                }

                if( get_option<bool>( "AUTO_FEATURES" ) && get_option<bool>( "AUTO_MOPPING" ) &&
                    weapon && weapon->has_flag( json_flag_MOP ) ) {
                    const bool is_blind = player_character.is_blind();
                    for( const tripoint_bub_ms &point : here.points_in_radius( player_character.pos_bub(), 1 ) ) {
                        bool did_mop = false;
                        if( is_blind ) {
                            // blind character have a 1/3 chance of actually mopping
                            if( one_in( 3 ) ) {
                                did_mop = here.mop_spills( point );
                            } else {
                                did_mop = here.terrain_moppable( point );
                            }
                        } else {
                            did_mop = here.mop_spills( point );
                        }
                        // iuse::mop costs 15 moves per use
                        if( did_mop ) {
                            player_character.mod_moves( -15 );
                        }
                    }
                }
            }
            break;
        case ACTION_MOVE_DOWN:
        case ACTION_MOVE_UP: {
                const int direction = act == ACTION_MOVE_UP ? 1 : -1;
                // Aircraft controls take priority over ladders under the pilot.
                if( vehicle *craft = controlled_vehicle( player_character, here ); craft &&
                    craft->is_aircraft( here ) ) {
                    pldrive( tripoint_rel_ms( 0, 0, direction ) );
                } else {
                    const auto pending_move = capture_automove_step( player_character, here,
                                              player_character.pos_abs() + tripoint_rel_ms( 0, 0, direction ) );
                    const character_action_guard mover( player_character );
                    const auto move_context = here.get_context_reference();
                    const auto choice = query_vertical_move( player_character, here, direction );
                    if( choice && mover && move_context ) {
                        execute_vertical_move( player_character, here, *choice );
                    }
                    if( !mover ) {
                        return true;
                    }
                    if( pending_move ) {
                        pending_move->finish( player_character, here, !choice );
                    }
                    if( !move_context ) {
                        return true;
                    }
                }
                break;
            }

        case ACTION_OPEN:
            player_character.assign_activity( open_tile_activity_actor( std::nullopt ) );
            break;

        case ACTION_CLOSE:
            if( player_character.is_mounted() ) {
                auto *mon = player_character.mounted_creature.get();
                if( !mon->has_flag( mon_flag_RIDEABLE_MECH ) ) {
                    add_msg( m_info, _( "You can't close things while you're riding." ) );
                }
            } else {
                close( mouse_target );
            }
            break;

        case ACTION_SMASH:
            if( has_vehicle_control( player_character ) ) {
                handbrake( here );
            } else {
                smash( mouse_target );
            }
            break;

        case ACTION_EXAMINE:
        case ACTION_EXAMINE_AND_PICKUP:
            if( mouse_target ) {
                // Examine including item pickup if ACTION_EXAMINE_AND_PICKUP is used
                examine( *mouse_target, act == ACTION_EXAMINE_AND_PICKUP );
            } else {
                examine( act == ACTION_EXAMINE_AND_PICKUP );
            }
            break;

        case ACTION_ADVANCEDINV:
            create_advanced_inv();
            break;

        case ACTION_PICKUP:
        case ACTION_PICKUP_ALL:
            if( mouse_target ) {
                pickup( *mouse_target );
            } else {
                if( act == ACTION_PICKUP_ALL ) {
                    pickup_all();
                } else {
                    pickup();
                }
            }
            break;

        case ACTION_GRAB:
            grab( mouse_target );
            break;
        case ACTION_HAUL:
            haul();
            break;
        case ACTION_HAUL_TOGGLE:
            haul_toggle();
            break;

        case ACTION_BUTCHER:
            butcher( mouse_target );
            break;

        case ACTION_CHAT: {
#ifdef MP_ENABLED
                const int pre_chat_moves = player_character.get_moves();
#endif
                chat( mouse_target );
#ifdef MP_ENABLED
                cata_mp::mp_client_post_action( pre_chat_moves );
#endif
                break;
            }

        case ACTION_PEEK:
            if( mouse_target ) {
                peek( *mouse_target );
            } else {
                peek();
            }
            break;

        case ACTION_LIST_ITEMS:
            list_surroundings();
            break;

        case ACTION_ZONES:
            if( !cata_mp::client_query_zones() ) {
                zone_manager_ui::display_zone_manager();
            }
            break;

        case ACTION_LOOT:
            zone_manager_ui::display_zone_actions();
            break;

        case ACTION_INVENTORY:
            game_menus::inv::common();
            break;

        case ACTION_COMPARE:
            game_menus::inv::compare( std::nullopt );
            break;

        case ACTION_ORGANIZE:
            game_menus::inv::swap_letters();
            break;

        case ACTION_USE: {
                // Shell-users are presumed to be able to mess with their inventories, etc
                // while in the shell.  Eating, gear-changing, and item use are OK.
#ifdef MP_ENABLED
                const int pre_use_moves = player_character.get_moves();
#endif
                avatar_action::use_item( player_character );
#ifdef MP_ENABLED
                cata_mp::mp_client_post_action( pre_use_moves );
#endif
                break;
            }

        case ACTION_USE_WIELDED: {
#ifdef MP_ENABLED
                const int pre_use_moves = player_character.get_moves();
#endif
                player_character.use_wielded();
#ifdef MP_ENABLED
                cata_mp::mp_client_post_action( pre_use_moves );
#endif
                break;
            }

        case ACTION_WEAR:
            wear();
            break;

        case ACTION_TAKE_OFF:
            takeoff();
            break;

        case ACTION_EAT:
            if( !avatar_action::eat_here( player_character ) ) {
                avatar_action::eat_or_use( player_character, game_menus::inv::consume() );
            }
            break;

        case ACTION_OPEN_CONSUME:
            if( !avatar_action::eat_here( player_character ) ) {
                open_consume_item_menu();
            }
            break;

        case ACTION_READ:
            // Shell-users are presumed to have the book just at an opening and read it that way
            read();
            break;

        case ACTION_WIELD: {
                item_location loc = game_menus::inv::wield();
                if( loc ) {
#ifdef MP_ENABLED
                    if( cata_mp::is_client_mode() ) {
                        cata_mp::client_select_equipment( "wield", loc );
                        break;
                    }
#endif
                    player_character.wield( loc );
#ifdef MP_ENABLED
                    cata_mp::mp_client_post_action();
#endif
                }
                break;
            }

#ifdef MP_ENABLED
        case ACTION_PASS_ITEM:
            cata_mp::mp_handle_pass_item();
            break;

        case ACTION_HIGH_FIVE:
            cata_mp::mp_high_five();
            break;

        case ACTION_COOP_CHAT:
            cata_mp::mp_open_chat();
            break;

        case ACTION_COOP_SESSION:
            cata_mp::mp_open_session_menu();
            return false;
#endif

        case ACTION_PICK_STYLE:
            player_character.martial_arts_data->pick_style( player_character );
            break;

        case ACTION_ACTIVE_TECHNIQUE:
            avatar_action::active_technique( player_character, here );
            break;

        case ACTION_RELOAD_ITEM: {
#ifdef MP_ENABLED
                const int pre_reload_moves = player_character.get_moves();
#endif
                reload_item();
#ifdef MP_ENABLED
                cata_mp::mp_client_post_action( pre_reload_moves );
#endif
                break;
            }

        case ACTION_RELOAD_WEAPON: {
#ifdef MP_ENABLED
                const int pre_reload_moves = player_character.get_moves();
#endif
                reload_weapon();
#ifdef MP_ENABLED
                cata_mp::mp_client_post_action( pre_reload_moves );
#endif
                break;
            }

        case ACTION_RELOAD_WIELDED: {
#ifdef MP_ENABLED
                const int pre_reload_moves = player_character.get_moves();
#endif
                reload_wielded();
#ifdef MP_ENABLED
                cata_mp::mp_client_post_action( pre_reload_moves );
#endif
                break;
            }

        case ACTION_UNLOAD: {
#ifdef MP_ENABLED
                const int pre_unload_moves = player_character.get_moves();
#endif
                avatar_action::unload( player_character );
#ifdef MP_ENABLED
                cata_mp::mp_client_post_action( pre_unload_moves );
#endif
                break;
            }

        case ACTION_MEND: {
#ifdef MP_ENABLED
                const int pre_mend_moves = player_character.get_moves();
#endif
                avatar_action::mend( player_character, item_location() );
#ifdef MP_ENABLED
                cata_mp::mp_client_post_action( pre_mend_moves );
#endif
                break;
            }

        case ACTION_THROW: {
#ifdef MP_ENABLED
                const int pre_throw_moves = player_character.get_moves();
#endif
                item_location loc;
                avatar_action::plthrow( player_character, loc );
#ifdef MP_ENABLED
                cata_mp::mp_client_post_action( pre_throw_moves );
#endif
                break;
            }

        case ACTION_THROW_WIELDED: {
#ifdef MP_ENABLED
                const int pre_throw_moves = player_character.get_moves();
#endif
                avatar_action::plthrow_wielded( player_character );
#ifdef MP_ENABLED
                cata_mp::mp_client_post_action( pre_throw_moves );
#endif
                break;
            }

        case ACTION_FIRE: {
#ifdef MP_ENABLED
                const int pre_fire_moves = player_character.get_moves();
#endif
            fire( mouse_target );
#ifdef MP_ENABLED
                cata_mp::mp_client_post_action( pre_fire_moves );
#endif
                break;
            }

        case ACTION_CAST_SPELL: {
#ifdef MP_ENABLED
                const int pre_cast_moves = player_character.get_moves();
#endif
                cast_spell();
#ifdef MP_ENABLED
                cata_mp::mp_client_post_action( pre_cast_moves );
#endif
                break;
            }

        case ACTION_RECAST_SPELL: {
#ifdef MP_ENABLED
                const int pre_cast_moves = player_character.get_moves();
#endif
                cast_spell( true );
#ifdef MP_ENABLED
                cata_mp::mp_client_post_action( pre_cast_moves );
#endif
                break;
            }

        case ACTION_FIRE_BURST: {
#ifdef MP_ENABLED
                const int pre_burst_moves = player_character.get_moves();
#endif
                if( weapon ) {
                    if( weapon->gun_set_mode( gun_mode_BURST ) || weapon->gun_set_mode( gun_mode_AUTO ) ) {
                        avatar_action::fire_wielded_weapon( player_character );
                    }
                }
#ifdef MP_ENABLED
                cata_mp::mp_client_post_action( pre_burst_moves );
#endif
                break;
            }

        case ACTION_SELECT_FIRE_MODE:
            if( weapon && weapon->is_gun() && !weapon->is_gunmod() ) {
                if( weapon->gun_all_modes().size() > 1 ) {
                    weapon->gun_cycle_mode();
                } else {
                    add_msg( m_info, _( "Your %s has only one firing mode." ), weapon->tname() );
                }
            }
            break;

        case ACTION_SELECT_DEFAULT_AMMO:
            if( weapon && weapon->is_gun() && !weapon->is_gunmod() ) {
                if( weapon->has_flag( flag_RELOAD_ONE ) ||
                    weapon->has_flag( flag_RELOAD_AND_SHOOT ) ) {
                    item::reload_option opt = player_character.select_ammo( weapon, false );
                    if( !opt ) {
                        break;
                    } else if( player_character.ammo_location && opt.ammo == player_character.ammo_location ) {
                        player_character.add_msg_if_player( _( "Cleared ammo preferences for %s." ), weapon->tname() );
                        player_character.ammo_location = item_location();
                    } else if( player_character.has_item( *opt.ammo ) ) {
                        player_character.add_msg_if_player( _( "Selected %s as default ammo for %s." ), opt.ammo->tname(),
                                                            weapon->tname() );
                        player_character.ammo_location = opt.ammo;
                    } else {
                        player_character.add_msg_if_player(
                            _( "You need to keep that ammo on you to select it as default ammo." ) );
                    }
                }
            }
            break;

        case ACTION_INSERT_ITEM: {
#ifdef MP_ENABLED
                const int pre_insert_moves = player_character.get_moves();
#endif
                insert_item();
#ifdef MP_ENABLED
                cata_mp::mp_client_post_action( pre_insert_moves );
#endif
                break;
            }

        case ACTION_UNLOAD_CONTAINER: {
                // You CAN drop things to your own tile while in the shell.
#ifdef MP_ENABLED
                const int pre_unload_moves = player_character.get_moves();
#endif
                unload_container( mouse_target );
#ifdef MP_ENABLED
                cata_mp::mp_client_post_action( pre_unload_moves );
#endif
                break;
            }

        case ACTION_DROP: {
#ifdef MP_ENABLED
                const int pre_drop_moves = player_character.get_moves();
#endif
                drop_in_direction( player_character.pos_bub() );
#ifdef MP_ENABLED
                cata_mp::mp_client_post_action( pre_drop_moves );
#endif
                break;
            }
        case ACTION_DIR_DROP: {
                std::optional<tripoint_bub_ms> pnt = mouse_target;
                if( !pnt ) {
                    pnt = choose_adjacent( _( "Drop where?" ) );
                }
                if( pnt ) {
                    if( *pnt != player_character.pos_bub() && in_shell ) {
                        add_msg( m_info, _( "You can't drop things to another tile while you're in your shell." ) );
                    } else {
                        // MP-HOOK: verify - non-animation branch timeout and MP poll hooks
#ifdef MP_ENABLED
                        const int pre_drop_moves = player_character.get_moves();
#endif
                        drop_in_direction( *pnt );
#ifdef MP_ENABLED
                        cata_mp::mp_client_post_action( pre_drop_moves );
#endif
                    }
                }
                break;
            }
        case ACTION_BIONICS:
            player_character.power_bionics();
            break;
        case ACTION_MUTATIONS:
            player_character.power_mutations();
            break;

        case ACTION_SORT_ARMOR:
            player_character.worn.sort_armor( player_character );
            break;

        case ACTION_WAIT:
            wait();
            break;

        case ACTION_CRAFT:
            player_character.craft();
            break;

        case ACTION_RECRAFT:
            player_character.recraft();
            break;

        case ACTION_LONGCRAFT:
            player_character.long_craft();
            break;

        case ACTION_DISASSEMBLE:
            if( player_character.controlling_vehicle ) {
                add_msg( m_info, _( "You can't disassemble items while driving." ) );
            } else {
                player_character.disassemble();
            }
            break;

        case ACTION_CONSTRUCT:
            if( player_character.in_vehicle ) {
                add_msg( m_info, _( "You can't construct while in a vehicle." ) );
            } else {
                construction_menu( false );
            }
            break;

        case ACTION_SLEEP:
            sleep();
            break;

        case ACTION_VEHICLE_TURNING_ASSIST:
            vehicle_turning_assist();
            break;

        case ACTION_VEHICLE_GUIDANCE:
            vehicle_guidance = !vehicle_guidance;
            add_msg( m_info, vehicle_guidance ? _( "Driving guidance ON." ) :
                     _( "Driving guidance OFF." ) );
            break;

        case ACTION_CONTROL_VEHICLE:
            if( player_character.is_mounted() ) {
                player_character.dismount();
            } else if( player_character.has_trait( trait_WAYFARER ) ) {
                add_msg( m_info, _( "You refuse to take control of this vehicle." ) );
            } else {
                control_vehicle( mouse_target );
            }
            break;

        case ACTION_TOGGLE_AUTO_TRAVEL_MODE:
            auto_travel_mode = !auto_travel_mode;
            add_msg( m_info, auto_travel_mode ? _( "Auto travel mode ON!" ) : _( "Auto travel mode OFF!" ) );
            break;

        case ACTION_TOGGLE_SAFEMODE:
            if( safe_mode == SAFE_MODE_OFF ) {
                set_safe_mode( SAFE_MODE_ON );
                mostseen = 0;
                add_msg( m_info, _( "Safe mode ON!" ) );
            } else {
                turnssincelastmon = 0_turns;
                set_safe_mode( SAFE_MODE_OFF );
                add_msg( m_info, get_option<bool>( "AUTOSAFEMODE" )
                         ? _( "Safe mode OFF!  (Auto safe mode still enabled!)" ) : _( "Safe mode OFF!" ) );
            }
            if( player_character.has_effect( effect_laserlocked ) ) {
                player_character.remove_effect( effect_laserlocked );
                safe_mode_warning_logged = false;
            }
            break;

        case ACTION_TOGGLE_AUTOSAFE: {
                // Set Auto reactivate safe mode to x
                set_next_option( "AUTOSAFEMODE" );
                break;
            }

        case ACTION_IGNORE_ENEMY:
            if( safe_mode == SAFE_MODE_STOP ) {
                add_msg( m_info, _( "Ignoring enemy!" ) );
                for( auto &elem : player_character.get_mon_visible().new_seen_mon ) {
                    monster &critter = *elem;
                    critter.ignoring = rl_dist( player_character.pos_bub(), critter.pos_bub() );
                }
                set_safe_mode( SAFE_MODE_ON );
            } else if( player_character.has_effect( effect_laserlocked ) ) {
                if( player_character.has_trait( trait_PROF_CHURL ) ) {
                    add_msg( m_warning, _( "You make the sign of the cross." ) );
                } else {
                    add_msg( m_info, _( "Ignoring laser targeting!" ) );
                }
                player_character.remove_effect( effect_laserlocked );
                safe_mode_warning_logged = false;
            }
            break;

        case ACTION_WHITELIST_ENEMY:
            if( safe_mode == SAFE_MODE_STOP && !get_safemode().empty() ) {
                get_safemode().add_rule( get_safemode().lastmon_whitelist, Creature::Attitude::ANY, 0,
                                         rule_state::WHITELISTED );
                add_msg( m_info, _( "Creature whitelisted: %s" ), get_safemode().lastmon_whitelist );
                set_safe_mode( SAFE_MODE_ON );
                mostseen = 0;
            } else {
                get_safemode().show();
            }
            break;

        case ACTION_WORKOUT:
            player_character.assign_activity( workout_activity_actor( player_character.pos_bub() ) );
            break;

        case ACTION_SUICIDE:
            if( query_yn( _( "Abandon this character?" ) ) ) {
                if( query_yn( _( "This will kill your character.  Continue?" ) ) ) {
                    player_character.set_moves( 0 );
                    player_character.place_corpse( &here );
                    uquit = QUIT_SUICIDE;
                }
            }
            break;

        case ACTION_SAVE:
#ifdef MP_ENABLED
            if( cata_mp::is_client_mode() ) {
                if( query_yn( _( "Disconnect from the co-op host?" ) ) ) {
                    if( save() ) {
                        player_character.use_local_map_memory();
                        player_character.set_moves( 0 );
                        uquit = QUIT_NOSAVED;
                        cata_mp::mp_notify_session_ending();
                    } else {
                        add_msg( m_bad, _( "Could not save your exploration memory.  Retry before disconnecting." ) );
                    }
                }
            } else if( query_yn( _( "Save and quit?" ) ) ) {
                if( save() ) {
                    discard_dimension_rollback_snapshot();
                    cata_mp::mp_notify_session_ending();
                    player_character.set_moves( 0 );
                    uquit = QUIT_SAVED;
                    cata_mp::mp_log( "[mp-quit] HOST save&quit: saved + notified, uquit=QUIT_SAVED set" );
                }
            }
#else
            if( query_yn( _( "Save and quit?" ) ) ) {
                if( save() ) {
                    discard_dimension_rollback_snapshot();
                    player_character.set_moves( 0 );
                    uquit = QUIT_SAVED;
                }
            }
#endif
            break;

        case ACTION_QUICKSAVE:
            quicksave();
#ifdef MP_ENABLED
            cata_mp::mp_after_quicksave();
#endif
            return false;

        case ACTION_QUICKLOAD:
            quickload();
            return false;

        case ACTION_SNAPSHOT_MENU:
            snapshot_menu();
            return false;

        case ACTION_QUIT_TO_SNAPSHOT:
            quit_to_last_snapshot();
            return false;

        case ACTION_PL_INFO:
            player_character.disp_info( true );
            break;

        case ACTION_MAP:
            if( !here.is_outside( player_character.pos_bub() ) ) {
                uistate.overmap_visible_weather = false;
            }
            if( you_know_where_you_are() ) {
                ui::omap::display();
            } else {
                add_msg( m_info, _( "You have no idea where you are." ) );
            }
            break;

        case ACTION_SKY:
            if( here.is_outside( player_character.pos_bub() ) ) {
                ui::omap::display_visible_weather();
            } else {
                add_msg( m_info, _( "You can't see the sky from here." ) );
            }
            break;

        case ACTION_MISSIONS:
            list_missions();
            break;

        case ACTION_DIARY:
            diary::show_diary_ui( u.get_avatar_diary() );
            break;

        case ACTION_FACTIONS:
            faction_manager_ptr->display();
            break;

        case ACTION_MORALE:
            player_character.disp_morale();
            break;

        case ACTION_MEDICAL:
            if( player_character.disp_medical() ) {
                return false;
            }
            break;

        case ACTION_BODYSTATUS:
            display_bodygraph( get_player_character() );
            break;

        case ACTION_MESSAGES:
            Messages::display_messages();
            break;

        case ACTION_HELP:
            get_help().display_help();
            break;

        case ACTION_OPTIONS:
            get_options().show( true );
            break;

        case ACTION_AUTOPICKUP:
            get_auto_pickup().show();
            break;

        case ACTION_AUTONOTES:
            get_auto_notes_settings().show_gui();
            break;

        case ACTION_SAFEMODE:
            get_safemode().show();
            break;

        case ACTION_DISTRACTION_MANAGER:
            get_distraction_manager().show();
            break;

        case ACTION_COLOR:
            all_colors.show_gui();
            break;

        case ACTION_WORLD_MODS:
            world_generator->show_active_world_mods( world_generator->active_world->active_mod_order );
            break;

        case ACTION_EXPORT_BUG_REPORT_ARCHIVE:
            debug_menu::export_save_archive_and_game_report();
            break;

        case ACTION_DEBUG:
            if( MAP_SHARING::isCompetitive() && !MAP_SHARING::isDebugger() ) {
                break;    //don't do anything when sharing and not debugger
            }
            debug_menu::debug();
            break;

        case ACTION_TOGGLE_FULLSCREEN:
            toggle_fullscreen();
            break;

        case ACTION_TOGGLE_PIXEL_MINIMAP:
            toggle_pixel_minimap();
            break;

        case ACTION_TOGGLE_PANEL_ADM:
            panel_manager::get_manager().show_adm();
            break;

        case ACTION_RELOAD_TILESET:
            reload_tileset();
            break;

        case ACTION_TOGGLE_AUTO_FEATURES:
            // Set Auto Features to x
            set_next_option( "AUTO_FEATURES" );
            break;

        case ACTION_TOGGLE_AUTO_PULP_BUTCHER:
            // Set Auto pulp or butcher to x
            set_next_option( "AUTO_PULP_BUTCHER" );
            auto_features_warn();
            break;

        case ACTION_TOGGLE_AUTO_MINING:
            // Set Auto Mining to x
            set_next_option( "AUTO_MINING" );
            auto_features_warn();
            break;

        case ACTION_TOGGLE_THIEF_MODE:
            if( player_character.get_value( "THIEF_MODE" ).str() == "THIEF_ASK" ) {
                player_character.set_value( "THIEF_MODE", "THIEF_HONEST" );
                //~ Thief mode cycled between THIEF_ASK/THIEF_HONEST/THIEF_STEAL
                add_msg( _( "Thief mode: Always Honest - you will not pick up others' belongings." ) );
            } else if( player_character.get_value( "THIEF_MODE" ).str() == "THIEF_HONEST" ) {
                player_character.set_value( "THIEF_MODE", "THIEF_STEAL" );
                //~ Thief mode cycled between THIEF_ASK/THIEF_HONEST/THIEF_STEAL
                add_msg( _( "Thief mode: Always Steal - you will pick up others' belongings without prompting." ) );
            } else if( player_character.get_value( "THIEF_MODE" ).str() == "THIEF_STEAL" ) {
                player_character.set_value( "THIEF_MODE", "THIEF_ASK" );
                //~ Thief mode cycled between THIEF_ASK/THIEF_HONEST/THIEF_STEAL
                add_msg( _( "Thief mode: Default - you will be prompted when picking up owned items." ) );
            } else {
                // ERROR
                add_msg( _( "THIEF_MODE CONTAINED BAD VALUE [ %s ]!" ),
                         player_character.get_value( "THIEF_MODE" ).to_string() );
            }
            break;

        case ACTION_TOGGLE_AUTO_FORAGING:
            // Set Auto Foraging to x
            set_next_option( "AUTO_FORAGING" );
            auto_features_warn();
            break;

        case ACTION_TOGGLE_AUTO_PICKUP:
            // Set Auto pickup enabled to x
            set_next_option( "AUTO_PICKUP" );
            break;

        case ACTION_TOGGLE_HOUR_TIMER:
            toggle_debug_hour_timer();
            break;

        case ACTION_TOGGLE_DEBUG_MODE:
            if( MAP_SHARING::isCompetitive() && !MAP_SHARING::isDebugger() ) {
                break;    //don't do anything when sharing and not debugger
            }
            handle_debug_mode();
            break;

        case ACTION_TOGGLE_PREVENT_OCCLUSION:
            set_next_option( "PREVENT_OCCLUSION" );
            break;

        case ACTION_ZOOM_IN:
            zoom_in();
            mark_main_ui_adaptor_resize();
            break;

        case ACTION_ZOOM_OUT:
            zoom_out();
            mark_main_ui_adaptor_resize();
            break;

        case ACTION_ITEMACTION:
            item_action_menu();
            break;

        case ACTION_AUTOATTACK:
            avatar_action::autoattack( player_character, here );
            break;

        default:
            break;
    }

    return true;
}

bool game::handle_action()
{
    map &here = get_map();

    std::string action;
    input_context ctxt;
    action_id act = ACTION_NULL;
    user_turn current_turn;
    avatar &player_character = get_avatar();
    if( cata_mp::is_client_mode() &&
        player_character.is_auto_moving() &&
        ( cata_mp::is_client_waiting_for_ack() || player_character.get_moves() <= 0 ||
          multiplayer_session().client_inventory_activity.active ) ) {
        handle_key_blocking_activity();
        return false;
    }
    // Check if we have an auto-move destination
    if( player_character.has_destination() ) {
        // Poll before consuming a route step: cancellation can clear the route,
        // and consuming its last step first would skip interruption polling.
        handle_key_blocking_activity();
        if( !player_character.has_destination() ) {
            return false;
        }
        act = player_character.get_next_auto_move_direction();
#ifdef MP_ENABLED
        if( cata_mp::is_client_mode() ) {
            cata_mp::mp_log( std::string( "[cdda-mp] HA-AUTOMOVE: dest=on next=" ) +
                             action_ident( act ) );
        }
#endif
        if( act == ACTION_NULL ) {
            add_msg( m_info, _( "Auto-move canceled" ) );
            player_character.abort_automove();
            return false;
        }
    } else if( player_character.has_destination_activity() ) {
        // starts destination activity after the player successfully reached his destination
        player_character.start_destination_activity();
        return false;
    } else if( uistate.open_menu ) {
        // make a copy so that uistate.open_menu can be assigned a new function
        // during the execution of the copied old function
        std::optional<std::function<void()>> open_menu_tmp = std::nullopt;
        std::swap( uistate.open_menu, open_menu_tmp );
        open_menu_tmp.value()();
        return false;
    } else {
        // A consumed final step is not proof of arrival. With no pending
        // authoritative reply, retire an exhausted route before manual input.
        if( player_character.is_auto_moving() ) {
            player_character.abort_automove();
        }
        ctxt = get_player_input( action );
    }

    if( cata_mp::is_client_mode() && uquit != QUIT_NO ) {
        return false;
    }

#ifdef MP_ENABLED
    if( cata_mp::is_client_mode() && action != "TIMEOUT" ) {
        cata_mp::mp_log( "[cdda-mp] HA-ACTION: action=\"" + action +
                         "\" moves=" + std::to_string( player_character.get_moves() ) );
    }
#endif

    // Remove asynchronous animations if any action taken before the input timeout
    // Otherwise repeated input can cause animations to accumulate as the timeout is never reached
    g->void_async_anim_curses();
#if defined(TILES)
    tilecontext->void_async_anim();
#else
    // Curses does not redraw itself so do it here
    g->invalidate_main_ui_adaptor();
#endif

    bool veh_ctrl = has_vehicle_control( player_character );

    // If performing an action with right mouse button, co-ordinates
    // of location clicked.
    std::optional<tripoint_bub_ms> mouse_target;

    if( uquit == QUIT_WATCH && action == "QUIT" ) {
        uquit = QUIT_DIED;
        return false;
    }

    if( act == ACTION_NULL ) {
        act = look_up_action( action );

        if( act == ACTION_KEYBINDINGS ) {
            // already handled by input context
            return false;
        }

        if( act == ACTION_MAIN_MENU ) {
            if( uquit == QUIT_WATCH ) {
                return false;
            }
            // No auto-move actions have or can be set at this point.
            player_character.clear_destination();
            destination_preview.clear();
#ifdef MP_ENABLED
            cata_mp::mp_log( "[cdda-mp] MAIN-MENU: enter" );
#endif
            act = handle_main_menu();
#ifdef MP_ENABLED
            cata_mp::mp_log( "[cdda-mp] MAIN-MENU: exit, act=" + std::to_string( static_cast<int>( act ) ) );
#endif
            if( act == ACTION_NULL ) {
#ifdef MP_ENABLED
                cata_mp::mp_log( "[cdda-mp] MAIN-MENU: dismissed (ACTION_NULL), returning false" );
#endif
                return false;
            }
#ifdef MP_ENABLED
            // Re-gate: handle_main_menu may return an AP-costing action.
            // If the host is locked, block it.
            if( cata_mp::is_hosting() && player_character.get_moves() <= 0 &&
                !host_ui_actions.count( act ) ) {
                add_msg( m_info, _( "Waiting for partner — can't do that yet." ) );
                return false;
            }
#endif
        }

#if defined(TILES)
        if( gamepad::is_active() ) {
            gamepad::direction dir = gamepad::get_left_stick_direction();
            if( dir != gamepad::direction::NONE ) {
                // List of actions that can use the directional cursor
                if( act == ACTION_INTERACT || act == ACTION_SMASH || act == ACTION_GRAB ||
                    act == ACTION_PEEK || act == ACTION_UNLOAD_CONTAINER || act == ACTION_DIR_DROP ||
                    act == ACTION_EXAMINE || act == ACTION_EXAMINE_AND_PICKUP ||
                    act == ACTION_PICKUP || act == ACTION_PICKUP_ALL || act == ACTION_CONTROL_VEHICLE ) {
                    tripoint offset = gamepad::direction_to_offset( dir );
                    mouse_target = player_character.pos_bub() + tripoint_rel_ms( offset.x, offset.y, 0 );
                }
            }
        }
#endif

        if( act == ACTION_ACTIONMENU ) {
            if( uquit == QUIT_WATCH ) {
                return false;
            }
            // No auto-move actions have or can be set at this point.
            player_character.clear_destination();
            destination_preview.clear();
            act = handle_action_menu( here );
            if( act == ACTION_NULL ) {
                return false;
            }
#if defined(__ANDROID__)
            if( get_option<bool>( "ANDROID_ACTIONMENU_AUTOADD" ) && ctxt.get_category() == "DEFAULTMODE" ) {
                add_best_key_for_action_to_quick_shortcuts( act, ctxt.get_category(), false );
            }
#endif
        }

        if( act == ACTION_INTERACT ) {
            if( !mouse_target ) {
                mouse_target = player_character.pos_bub();
            }
            act = handle_interact( here, *mouse_target );
            if( act == ACTION_NULL ) {
                return false;
            }
        }

        if( act == ACTION_KEYBINDINGS ) {
            player_character.clear_destination();
            destination_preview.clear();
            act = ctxt.display_menu( true );
            if( act == ACTION_NULL ) {
                return false;
            }
        }

        if( can_action_change_worldstate( act ) ) {
            user_action_counter += 1;
        }

        if( act == ACTION_CLICK_AND_DRAG ) {
            // Need to return false to avoid disrupting actions like character mouse movement that require two clicks
            return false;
        }

        if( act == ACTION_SELECT || act == ACTION_SEC_SELECT ) {
            // Mouse button click
            if( veh_ctrl ) {
                // No mouse use in vehicle
                return false;
            }

            if( player_character.is_dead_state() ) {
                // do not allow mouse actions while dead
                return false;
            }

            const std::optional<tripoint_bub_ms> mouse_pos = ctxt.get_coordinates( w_terrain,
                    ter_view_p.raw().xy(),
                    true );
            if( !mouse_pos ) {
                return false;
            }
            if( !player_character.sees( here, *mouse_pos ) ) {
                // Not clicked in visible terrain
                return false;
            }
            mouse_target = mouse_pos;

            if( act == ACTION_SELECT ) {
                // Note: The following has the potential side effect of
                // setting auto-move destination state in addition to setting
                // act.
                if( !try_get_left_click_action( act, *mouse_target ) ) {
                    return false;
                }
            } else if( act == ACTION_SEC_SELECT ) {
                if( !try_get_right_click_action( act, *mouse_target ) ) {
                    return false;
                }
            }
        } else if( act != ACTION_TIMEOUT ) {
            // act has not been set for an auto-move, so clearing possible
            // auto-move destinations. Since initializing an auto-move with
            // the mouse may span across multiple actions, we do not clear the
            // auto-move destination if the action is only a timeout, as this
            // would require the user to double click quicker than the
            // timeout delay.
            player_character.clear_destination();
            destination_preview.clear();
        }
    }

    if( act == ACTION_NULL ) {
        const input_event &&evt = ctxt.get_raw_input();
        if( !evt.sequence.empty() ) {
            const int ch = evt.get_first_input();
            if( !get_option<bool>( "NO_UNKNOWN_COMMAND_MSG" ) ) {
                std::string msg = string_format( _( "Unknown command: \"%s\" (%ld)" ), evt.long_description(), ch );
                if( const std::optional<std::string> hint =
                        press_x_if_bound( ACTION_KEYBINDINGS ) ) {
                    msg = string_format( "%s\n%s", msg,
                                         string_format( _( "%s at any time to see and edit keybindings relevant to "
                                                           "the current context." ),
                                                        *hint ) );
                }
                add_msg( m_info, msg );
            }
        }
        return false;
    }

    // Start after input and action resolution so idle waiting is not action work.
    // Some commands can still open interactive menus during execution.
    CATA_PROFILE_SCOPE_NAMED( "game.action_execute" );
    CATA_PROFILE_TEXT( action.data(), action.size() );
    CATA_PROFILE_PLOT( "game.action_id", static_cast<int64_t>( act ) );

    // This has no action unless we're in a special game mode.
    gamemode->pre_action( act );

    int before_action_moves = player_character.get_moves();

    // These actions are allowed while deathcam is active. Registered in game::get_player_input
    if( uquit == QUIT_WATCH || !player_character.is_dead_state() ) {
        do_deathcam_action( act, player_character );
    }

    // actions allowed only while alive
    if( !player_character.is_dead_state() ) {
        // A confirmed mouse route already supplied a movement action.
        const camera_input *camera = mouse_target ? nullptr : ctxt.get_camera_input();
        if( !do_regular_action( act, player_character, mouse_target, camera ) ) {
            return false;
        }
    }
    if( act != ACTION_TIMEOUT ) {
        player_character.mod_moves( -current_turn.moves_elapsed() );
    }
    if( act != ACTION_PAUSE ) {
        player_character.magic->break_channeling( player_character );
    }

    gamemode->post_action( act );

    player_character.movecounter = ( !player_character.is_dead_state() ? ( before_action_moves -
                                     player_character.get_moves() ) : 0 );
    dbg( D_INFO ) << string_format( "%s: [%d] %d - %d = %d", action_ident( act ),
                                    to_turn<int>( calendar::turn ), before_action_moves, player_character.movecounter,
                                    player_character.get_moves() );
    return !player_character.is_dead_state();
}
