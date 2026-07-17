#include "do_turn.h"

#include "mp_client_conn.h"
#include "mp_gamestate.h"
#include "translation.h"

#if defined(EMSCRIPTEN)
    #include <emscripten.h>
#endif

#include <algorithm>
#include <chrono>
#include <map>
#include <memory>
#include <optional>
#include <ostream>
#include <ratio>
#include <string>
#include <thread>
#include <unordered_map>
#include <utility>
#include <vector>

#include "action.h"
#include "activity_type.h"
#include "avatar.h"
#include "bionics.h"
#include "cached_options.h"
#include "calendar.h"
#ifdef TILES
    #include "cata_imgui.h"
#endif
#include "cata_variant.h"
#include "clzones.h"
#include "coordinates.h"
#include "creature_tracker.h"
#include "debug.h"
#include "debug_capture.h"
#include "enums.h"
#include "event.h"
#include "event_bus.h"
#include "explosion.h"
#include "field.h"
#include "game.h"
#include "game_constants.h"
#include "gamemode.h"
#include "help.h"
#include "input.h"
#include "input_context.h"
#include "input_replay.h"
#include "item_wakeup.h"
#include "magic_enchantment.h"
#include "map.h"
#include "map_iterator.h"
#include "map_scale_constants.h"
#include "mapbuffer.h"
#include "mapdata.h"
#include "memorial_logger.h"
#include "messages.h"
#include "mission.h"
#include "monster.h"
#include "mtype.h"
#include "music.h"
#include "npc.h"
#include "options.h"
#include "output.h"
#include "overmap_ui.h"
#include "overmapbuffer.h"
#include "pimpl.h"
#include "player_activity.h"
#include "point.h"
#include "popup.h"
#include "profiling.h"
#include "rng.h"
#include "scent_map.h"
#include "sdlsound.h"
#include "simple_pathfinding.h"
#include "sounds.h"
#include "stats_tracker.h"
#include "string_formatter.h"
#include "timed_event.h"
#include "translations.h"
#include "type_id.h"
#include "ui_manager.h"
#include "uilist.h"
#include "units.h"
#include "vehicle.h"
#include "vpart_position.h"
#include "weather.h"
#include "worldfactory.h"

static const activity_id ACT_AUTODRIVE( "ACT_AUTODRIVE" );
static const activity_id ACT_FIRSTAID( "ACT_FIRSTAID" );
static const activity_id ACT_MIGRATION_CANCEL( "ACT_MIGRATION_CANCEL" );
static const activity_id ACT_OPERATION( "ACT_OPERATION" );

static const bionic_id bio_alarm( "bio_alarm" );

static const efftype_id effect_controlled( "controlled" );
static const efftype_id effect_npc_suspend( "npc_suspend" );
static const efftype_id effect_ridden( "ridden" );
static const efftype_id effect_sleep( "sleep" );

static const event_statistic_id event_statistic_last_words( "last_words" );

static const json_character_flag json_flag_NO_SCENT( "NO_SCENT" );

static const trait_id trait_HAS_NEMESIS( "HAS_NEMESIS" );

#if defined(__ANDROID__)
extern std::map<std::string, std::list<input_event>> quick_shortcuts_map;
extern bool add_best_key_for_action_to_quick_shortcuts( action_id action,
        const std::string &category, bool back );
#endif

#define dbg(x) DebugLog((x),D_GAME) << __FILE__ << ":" << __LINE__ << ": "

namespace turn_handler
{
bool cleanup_at_end()
{
    avatar &u = get_avatar();
    if( g->uquit == QUIT_DIED || g->uquit == QUIT_SUICIDE ) {
        // Put (non-hallucinations) into the overmap so they are not lost.
        for( monster &critter : g->all_monsters() ) {
            g->despawn_monster( critter );
        }
        // if player has "hunted" trait, remove their nemesis monster on death
        if( u.has_trait( trait_HAS_NEMESIS ) ) {
            overmap_buffer.remove_nemesis();
        }
        // Reset NPC factions and disposition
        g->reset_npc_dispositions();
        // Save the factions', missions and set the NPC's overmap coordinates
        // Npcs are saved in the overmap.
        g->save_factions_missions_npcs(); //missions need to be saved as they are global for all saves.

        // and the overmap, and the local map.
        g->save_maps(); //Omap also contains the npcs who need to be saved.

        //save achievements entry
        g->save_achievements();

        // Notify connected clients before the death screen takes focus so they
        // see "partner died" instead of a raw socket-drop spam.
        if( cata_mp::is_hosting() ) {
            cata_mp::notify_client_host_died();
        }
        g->death_screen();
        // See game::save(): freeze the wall-clock delta under replay so playtime
        // (and anything derived from the game_over event) is reproducible.
        std::chrono::seconds time_since_load =
            replay_mode == replay_mode_t::replay
            ? std::chrono::seconds( 0 )
            : std::chrono::duration_cast<std::chrono::seconds>(
                std::chrono::steady_clock::now() - g->time_of_last_load );
        std::chrono::seconds total_time_played = g->time_played_at_last_load + time_since_load;
        get_event_bus().send<event_type::game_over>( total_time_played );
        // Struck the save_player_data here to forestall Weirdness
        g->move_save_to_graveyard();
        g->write_memorial_file( g->stats().value_of( event_statistic_last_words )
                                .get<cata_variant_type::string>() );
        get_memorial().clear();
        std::vector<std::string> characters = g->list_active_saves();
        // remove current player from the active characters list, as they are dead
        std::vector<std::string>::iterator curchar = std::find( characters.begin(),
                characters.end(), u.get_save_id() );
        if( curchar != characters.end() ) {
            characters.erase( curchar );
        }

        if( characters.empty() ) {
            bool queryDelete = false;
            bool queryReset = false;

            if( get_option<std::string>( "WORLD_END" ) == "query" ) {
                bool decided = false;
                std::string buffer = _( "Warning: NPC interactions and some other global flags "
                                        "will not all reset when starting a new character in an "
                                        "already-played world.  This can lead to some strange "
                                        "behavior.\n\n"
                                        "Are you sure you wish to keep this world?"
                                      );

                while( !decided ) {
                    uilist smenu;
                    smenu.allow_cancel = false;
                    smenu.addentry( 0, true, 'r', "%s", _( "Reset world" ) );
                    smenu.addentry( 1, true, 'd', "%s", _( "Delete world" ) );
                    smenu.addentry( 2, true, 'k', "%s", _( "Keep world" ) );
                    smenu.query();

                    switch( smenu.ret ) {
                        case 0:
                            queryReset = true;
                            decided = true;
                            break;
                        case 1:
                            queryDelete = true;
                            decided = true;
                            break;
                        case 2:
                            decided = query_yn( buffer );
                            break;
                    }
                }
            }

            if( queryDelete || get_option<std::string>( "WORLD_END" ) == "delete" ) {
                world_generator->delete_world( world_generator->active_world->world_name, true );

            } else if( queryReset || get_option<std::string>( "WORLD_END" ) == "reset" ) {
                world_generator->delete_world( world_generator->active_world->world_name, false );
            }
        } else if( get_option<std::string>( "WORLD_END" ) != "keep" ) {
            std::string tmpmessage;
            for( auto &character : characters ) {
                tmpmessage += "\n  ";
                tmpmessage += character;
            }
            popup( _( "World retained.  Characters remaining:%s" ), tmpmessage );
        }
        if( g->gamemode ) {
            g->gamemode = std::make_unique<special_game>(); // null gamemode or something..
        }
    }

    //Reset any offset due to driving
    g->set_driving_view_offset( point_rel_ms::zero );

    //clear all sound channels
    sfx::fade_audio_channel( sfx::channel::any, 300 );
    sfx::fade_audio_group( sfx::group::weather, 300 );
    sfx::fade_audio_group( sfx::group::time_of_day, 300 );
    sfx::fade_audio_group( sfx::group::context_themes, 300 );
    sfx::fade_audio_group( sfx::group::low_stamina, 300 );

    zone_manager::get_manager().clear();

    MAPBUFFER.clear();
    overmap_buffer.clear();

#if defined(__ANDROID__)
    quick_shortcuts_map.clear();
#endif
    return true;
}

} // namespace turn_handler

void handle_key_blocking_activity( int timeout )
{
    if( test_mode ) {
        return;
    }
    avatar &u = get_avatar();
    const bool has_unfinished_activity = u.activity && (
            u.activity.id()->based_on() == based_on_type::NEITHER
            || u.activity.moves_left > 0 );
    // MP-locked host has no activity but should still be able to zoom, check
    // inventory, see messages, etc. while waiting for the client to act.
    if( has_unfinished_activity || u.has_destination()
        || cata_mp::is_host_waiting_for_client() ) {
        input_context ctxt = get_default_mode_input_context();
        const std::string action = ctxt.handle_input( timeout );
        if( cata_mp::is_hosting() && cata_mp::is_host_waiting_for_client() &&
            !action.empty() && action != "ANY_INPUT" && action != "TIMEOUT" ) {
            cata_mp::mp_log( "[cdda-mp] HOST-LOCKED-INPUT: action=\"" + action + "\"" );
        }
        if( cata_mp::is_client_mode() &&
            !action.empty() && action != "ANY_INPUT" && action != "TIMEOUT" ) {
            cata_mp::mp_log( "[cdda-mp] CLI-LOCKED-INPUT: action=\"" + action + "\"" );
        }
        bool refresh = true;
        if( action == "pause" ) {
            if( u.activity.is_interruptible_with_kb() ) {
                if( cata_mp::is_client_mode() ) {
                    u.cancel_activity();
                    u.abort_automove();
                    u.resume_backlog_activity();
                } else {
                    g->cancel_activity_query( _( "Confirm:" ) );
                }
            }
        } else if( action == "zoom_in" ) {
            g->zoom_in();
            g->mark_main_ui_adaptor_resize();
        } else if( action == "zoom_out" ) {
            g->zoom_out();
            g->mark_main_ui_adaptor_resize();
        } else if( action == "map" ) {
            ui::omap::display();
        } else if( action == "player_data" ) {
            u.disp_info( true );
        } else if( action == "morale" ) {
            u.disp_morale();
        } else if( action == "messages" ) {
            Messages::display_messages();
        } else if( action == "help" ) {
            get_help().display_help();
        } else if( action == "coop_chat" ) {
            cata_mp::mp_open_chat();
        } else if( action != "HELP_KEYBINDINGS" ) {
            refresh = false;
        }
        if( refresh ) {
            ui_manager::redraw();
            refresh_display();
        }
    } else {
        refresh_display();
        inp_mngr.pump_events();
    }
}

namespace
{
void monmove()
{
    ZoneScoped;
    g->cleanup_dead();
    map &m = get_map();
    avatar &u = get_avatar();

    int mon_count = 0;
    std::string mon_slow_log;
    for( monster &critter : g->all_monsters() ) {
        if( !m.inbounds( critter.pos_abs() ) ) {
            continue;
        }
        ++mon_count;
        const std::chrono::steady_clock::time_point mon_t0 = std::chrono::steady_clock::now();
        const tripoint_bub_ms critter_pos = critter.pos_bub( m );

        // Critters in impassable tiles get pushed away, unless it's not impassable for them
        if( !critter.is_dead() && ( m.impassable( critter_pos ) &&
                                    !m.get_impassable_field_at( critter_pos ).has_value() ) &&
            !critter.can_move_to( critter_pos ) ) {
            dbg( D_ERROR ) << "game:monmove: " << critter.name()
                           << " can't move to its location!  (" << critter_pos.x()
                           << ":" << critter_pos.y() << ":" << critter_pos.z() << "), "
                           << m.tername( critter_pos );
            add_msg_debug( debugmode::DF_MONSTER, "%s can't move to its location!  (%d,%d,%d), %s",
                           critter.name(),
                           critter_pos.x(), critter_pos.y(), critter_pos.z(), m.tername( critter_pos ) );
            bool okay = false;
            for( const tripoint_bub_ms &dest : m.points_in_radius( critter_pos, 3 ) ) {
                if( critter.can_move_to( dest ) && g->is_empty( dest ) ) {
                    critter.setpos( m, dest );
                    okay = true;
                    break;
                }
            }
            if( !okay ) {
                // die of "natural" cause (overpopulation is natural)
                critter.die( &m, nullptr );
            }
        }

        if( !critter.is_dead() ) {
            critter.process_turn();
        }

        m.creature_in_field( critter );
        if( calendar::once_every( 1_days ) ) {
            if( critter.has_flag( mon_flag_MILKABLE ) ) {
                critter.refill_udders();
            }
            critter.try_biosignature();
            critter.try_reproduce();
        }
        while( critter.get_moves() > 0 && !critter.is_dead() && !critter.has_effect( effect_ridden ) ) {
            critter.made_footstep = false;
            // Controlled critters don't make their own plans
            if( !critter.has_effect( effect_controlled ) ) {
                // Formulate a path to follow
                critter.plan();
            } else {
                critter.set_moves( 0 );
                break;
            }
            critter.move(); // Move one square, possibly hit u
            critter.process_triggers();
            m.creature_in_field( critter );
        }

        if( !critter.is_dead() && !critter.is_hallucination() &&
            rl_dist( u.pos_abs(), critter.pos_abs() ) < u.enchantment_cache->modify_value(
                enchant_vals::mod::MOTION_ALARM, 0 ) ) {
            if( u.has_active_bionic( bio_alarm ) ) {
                u.mod_power_level( -bio_alarm->power_trigger );
                add_msg( m_warning, _( "Your motion alarm goes off!" ) );
                g->cancel_activity_or_ignore_query( distraction_type::motion_alarm,
                                                    _( "Your motion alarm goes off!" ) );
            } else {
                add_msg( m_warning, _( "You suddenly feel alerted!" ) );
                g->cancel_activity_or_ignore_query( distraction_type::motion_alarm,
                                                    _( "Your instincts warn you for danger!" ) );
            }
            if( u.has_effect( effect_sleep ) ) {
                u.wake_up();
            }
        }

        if( cata_mp::is_hosting() ) {
            const int mon_ms = static_cast<int>(
                                   std::chrono::duration_cast<std::chrono::milliseconds>(
                                       std::chrono::steady_clock::now() - mon_t0 ).count() );
            if( mon_ms >= 10 ) {
                mon_slow_log += " " + critter.type->id.str() + "=" + std::to_string( mon_ms ) + "ms";
            }
        }
    }

    if( cata_mp::is_hosting() && !mon_slow_log.empty() ) {
        cata_mp::mp_log( "[cdda-mp] monmove slow monsters (count=" +
                         std::to_string( mon_count ) + "):" + mon_slow_log );
    }

    g->cleanup_dead();

    // The remaining monsters are all alive, but may be outside of the reality bubble.
    // If so, despawn them. This is not the same as dying, they will be stored for later and the
    // monster::die function is not called.
    g->despawn_nonlocal_monsters();

    // Now, do active NPCs.
    for( npc &guy : g->all_npcs() ) {
        // Remote player NPCs are driven by network input, not AI.
        if( cata_mp::is_remote_player( guy.getID() ) ) {
            cata_mp::mp_tick_proxy_activity( guy );
            continue;
        }
        const std::chrono::steady_clock::time_point npc_t0 = std::chrono::steady_clock::now();
        int turns = 0;
        int real_count = 0;
        const int count_limit = std::max( 10, guy.get_moves() / 64 );
        if( guy.is_mounted() ) {
            guy.check_mount_is_spooked();
        }
        m.creature_in_field( guy );
        if( !guy.has_effect( effect_npc_suspend ) ) {
            guy.process_turn();
        }
        while( !guy.is_dead() && ( !guy.in_sleep_state() ||
                                   guy.activity.id() == ACT_OPERATION || guy.activity.id() == ACT_MIGRATION_CANCEL ) &&
               guy.get_moves() > 0 && turns < 10 ) {
            const int moves = guy.get_moves();
            const bool has_destination = guy.has_destination_activity();
            guy.move();
            if( moves == guy.get_moves() ) {
                // Count every time we exit npc::move() without spending any moves.
                real_count++;
                if( has_destination == guy.has_destination_activity() || real_count > count_limit ) {
                    turns++;
                }
            }
            // Turn on debug mode when in infinite loop
            // It has to be done before the last turn, otherwise
            // there will be no meaningful debug output.
            if( turns == 9 ) {
                debugmsg( "NPC '%s' entered infinite loop, npc activity id: '%s'",
                          guy.get_name(), guy.activity.id().str() );
            }
        }

        // If we spun too long trying to decide what to do (without spending moves),
        // Invoke cognitive suspension to prevent an infinite loop.
        if( turns == 10 ) {
            add_msg( _( "%s faints!" ), guy.get_name() );
            guy.reboot();
        }

        if( !guy.is_dead() ) {
            guy.npc_update_body();
        }

        if( cata_mp::is_hosting() ) {
            const int npc_ms = static_cast<int>(
                                   std::chrono::duration_cast<std::chrono::milliseconds>(
                                       std::chrono::steady_clock::now() - npc_t0 ).count() );
            if( npc_ms >= 10 ) {
                cata_mp::mp_log( "[cdda-mp] monmove slow NPC: " + guy.get_name() +
                                 " activity=" + guy.activity.id().str() +
                                 " " + std::to_string( npc_ms ) + "ms" );
            }
        }
    }
    g->cleanup_dead();
}

void overmap_npc_move()
{
    avatar &u = get_avatar();
    std::vector<npc *> travelling_npcs;
    static constexpr int move_search_radius = 600;
    for( auto &elem : overmap_buffer.get_npcs_near_player( move_search_radius ) ) {
        if( !elem ) {
            continue;
        }
        npc *npc_to_add = elem.get();
        if( ( !npc_to_add->is_active() || rl_dist( u.pos_bub(), npc_to_add->pos_bub() ) > SEEX * 2 ) &&
            npc_to_add->mission == NPC_MISSION_TRAVELLING ) {
            travelling_npcs.push_back( npc_to_add );
        }
    }
    bool npcs_need_reload = false;
    for( npc *&elem : travelling_npcs ) {
        if( elem->has_omt_destination() ) {
            if( !elem->omt_path.empty() ) {
                if( rl_dist( elem->omt_path.back(), elem->pos_abs_omt() ) > 2 ) {
                    // recalculate path, we got distracted doing something else probably
                    elem->omt_path.clear();
                } else if( elem->omt_path.back() == elem->pos_abs_omt() ) {
                    elem->omt_path.pop_back();
                }
            }
            if( elem->omt_path.empty() ) {
                elem->omt_path = overmap_buffer.get_travel_path( elem->pos_abs_omt(), elem->goal,
                                 overmap_path_params::for_npc() ).points;
                if( elem->omt_path.empty() ) { // goal is unreachable, or already reached goal, reset it
                    elem->goal = npc::no_goal_point;
                }
            } else {
                elem->travel_overmap( elem->omt_path.back() );
                npcs_need_reload = true;
            }
        }
        if( !elem->has_omt_destination() && calendar::once_every( 1_hours ) && one_in( 3 ) ) {
            // travelling destination is reached/not set, try different one
            elem->set_omt_destination();
        }
    }
    if( npcs_need_reload ) {
        g->reload_npcs();
    }
}

} // namespace

void game::handle_progress_ui()
{
    avatar &u = get_avatar();

    // handle activity/progress/waiting UI
    const bool player_is_sleeping = u.has_effect( effect_sleep );
    bool wait_redraw = false;
    std::string wait_message;
    time_duration wait_refresh_rate;
    if( player_is_sleeping ) {
        wait_redraw = true;
        wait_message = _( "Wait till you wake up…" );
        wait_refresh_rate = 30_minutes;
    } else if( const std::optional<std::string> progress = u.activity.get_progress_message( u ) ) {
        wait_redraw = true;
        wait_message = *progress;
        // MP: when our local activity is ACT_HELP_PARTNER, mirror the partner's
        // reported progress.  Our own moves_total uses a long fallback that
        // doesn't track the actual craft/build/etc the partner is doing.
        if( ( cata_mp::is_client_mode() || cata_mp::is_hosting() ) &&
            u.activity.id().str() == "ACT_HELP_PARTNER" ) {
            wait_message = string_format( _( "%s: %d%%" ),
                                          u.activity.get_verb().translated(),
                                          cata_mp::partner_activity_pct() );
        }
        if( u.activity.is_interruptible() && u.activity.interruptable_with_kb ) {
            wait_message += string_format( _( "\n%s to interrupt" ), press_x( ACTION_PAUSE ) );
        }
        if( u.activity.id() == ACT_AUTODRIVE ) {
            wait_refresh_rate = 1_turns;
        } else if( u.activity.id() == ACT_FIRSTAID ) {
            wait_refresh_rate = 5_turns;
        } else {
            wait_refresh_rate = 5_minutes;
        }
        // In lockstep MP, cap to 1_turns so the progress bar updates every grant
        // cycle.  In FF mode turns race at CPU speed — don't cap here, handled below.
        if( cata_mp::is_client_mode() || cata_mp::is_hosting() ) {
            if( !cata_mp::should_fast_forward() ) {
                wait_refresh_rate = 1_turns;
            }
        }
    }
    if( wait_redraw ) {
        // FF mode: bypass the calendar gate entirely and use a wall-clock cap
        // (~100ms = ~10 Hz).  This lets thousands of game turns race through
        // per second while the progress popup still updates smoothly.
        static std::chrono::steady_clock::time_point s_last_ff_redraw =
            std::chrono::steady_clock::time_point {};
        const bool ff_active = cata_mp::should_fast_forward();
        const bool ff_redraw_due = [&] {
            if( !ff_active )
            {
                return false;
            }
            const std::chrono::steady_clock::time_point now = std::chrono::steady_clock::now();
            if( first_redraw_since_waiting_started ||
                std::chrono::duration_cast<std::chrono::milliseconds>( now - s_last_ff_redraw ).count() >= 100 )
            {
                s_last_ff_redraw = now;
                return true;
            }
            return false;
        }();
        if( ff_redraw_due ||
            ( !ff_active && ( first_redraw_since_waiting_started ||
                              calendar::once_every( std::min( 1_minutes, wait_refresh_rate ) ) ) ) ) {
            if( ff_redraw_due || first_redraw_since_waiting_started ||
                calendar::once_every( wait_refresh_rate ) ) {
                ui_manager::redraw();
            }

            // Avoid redrawing the main UI every time due to invalidation
#ifdef TILES
            // If an ImGui window just closed and cleared the buffer, do a full
            // redraw now before blocking UIs below.
            if( cataimgui::clear_pending() ) {
                ui_manager::redraw();
            }
#endif
            ui_adaptor dummy( ui_adaptor::disable_uis_below {} );
            if( !wait_popup ) {
                wait_popup = std::make_unique<static_popup>();
            }
            wait_popup->on_top( true ).wait_message( "%s", wait_message );
            ui_manager::redraw();
            refresh_display();
            first_redraw_since_waiting_started = false;
        }
    } else {
        // Nothing to wait for now
        wait_popup_reset();
        first_redraw_since_waiting_started = true;
    }
}

bool game::do_turn()
{
    ZoneScoped;
    // If a replay's input log has drained, save and request quit before doing
    // any more simulation. Checked at the top of every turn so it fires no matter
    // which input path drained the log (avatar action loop, a modal menu, a
    // query); a single in-loop check missed cases where the avatar loop was not
    // re-entered. One-shot, so it only triggers the save once.
    if( input_replay::replay_just_finished() ) {
        save();
        uquit = QUIT_SAVED;
    }

    if( is_game_over() ) {
        return turn_handler::cleanup_at_end();
    }

    drain_renderer_recovery();

    simulate_turn_prefix();

    // Keep multiplayer entirely outside the single-player turn path.  The
    // false branch is stable for the lifetime of a solo session, so it is
    // cheap for the CPU to predict and no MP queue, cleanup, logging or UI
    // synchronization function is entered.
    if( cata_mp::is_session_active() ) {
        cata_mp::process_session_turn();
    }

    if( do_avatar_action_loop() ) {
        return turn_handler::cleanup_at_end();
    }
    simulate_turn_suffix();
    present_turn();

    return false;
}

void game::simulate_turn_prefix()
{
    ZoneScoped;
    weather_manager &weather = get_weather();

    // Increment game turn
    if( new_game ) {
        new_game = false;
        weather.on_game_start();
    } else {
        gamemode->per_turn();
        // MP callout: client-mode locks the calendar until a grant brings
        // moves > 0; otherwise the clock races forward ~10 turns/sec while
        // waiting and diverges from the host.
        if( cata_mp::should_advance_calendar() ) {
            calendar::turn += 1_turns;
        }
    }
    //used for dimension swapping
    if( swapping_dimensions ) {
        swapping_dimensions = false;
    }
    play_music( music::get_music_id_string() );

    // starting a new turn, clear out temperature cache
    weather.temperature_cache.clear();

    if( npcs_dirty ) {
        load_npcs();
    }

    timed_event_manager &timed_events = get_timed_events();
    timed_events.process();
    get_item_wakeups().process( calendar::turn );
    mission::process_all();
    avatar &u = get_avatar();
    map &m = get_map();
    // If controlling a vehicle that is owned by someone else
    if( calendar::once_every( 1_minutes ) ) {
        if( u.in_vehicle && u.controlling_vehicle ) {
            vehicle *veh = veh_pointer_or_null( m.veh_at( u.pos_bub() ) );
            if( veh && !veh->handle_potential_theft( u, true ) ) {
                veh->handle_potential_theft( u, false, false );
            }
        }
    }

    // If you're inside a wall or something and haven't been telefragged, let's get you out.
    // In client MP mode the server is authoritative for position.
    if( !cata_mp::is_client_mode() &&
        ( m.impassable( u.pos_bub() ) && !m.impassable_field_at( u.pos_bub() ) ) &&
        !m.has_flag( ter_furn_flag::TFLAG_CLIMBABLE, u.pos_bub() ) ) {
        u.stagger();
    }

    // If riding a horse - chance to spook
    if( u.is_mounted() ) {
        u.check_mount_is_spooked();
    }
    if( calendar::once_every( 1_days ) ) {
        overmap_buffer.process_mongroups();
    }

    // Move hordes every turn, move_hordes has its own rate limiting
    overmap_buffer.move_hordes();
    if( calendar::once_every( time_duration::from_minutes( 2.5 ) ) ) {
        if( u.has_trait( trait_HAS_NEMESIS ) ) {
            overmap_buffer.move_nemesis();
        }
    }

    debug_hour_timer.print_time();

    // Per-turn body update. In SP this is one turn; in MP-client it must catch
    // up the host-driven calendar's jumps.
    cata_mp::mp_do_turn_update_body( u );

    // Auto-save if autosave is enabled (suppressed in client mode — server owns saves)
    if( !cata_mp::is_client_mode() &&
        get_option<bool>( "AUTOSAVE" ) &&
        calendar::once_every( 1_turns * get_option<int>( "AUTOSAVE_TURNS" ) ) &&
        !u.is_dead_state() ) {
        autosave();
    }

    weather.update_weather();

    reset_light_level();
    for( int z = -OVERMAP_DEPTH; z <= OVERMAP_HEIGHT; z++ ) {
        m.set_lightmap_cache_dirty( z );
    }

    perhaps_add_random_npc( /* ignore_spawn_timers_and_rates = */ false );

    // In server mode the avatar is a simulation host, not a controllable player.
    if( cata_mp::is_server_mode() ) {
        u.set_moves( 0 );
        u.set_hunger( 0 );
        u.set_thirst( 0 );
        u.set_sleep_deprivation( 0 );
        u.set_stamina( u.get_stamina_max() );
        u.healall( 100 );
    }

    // process avatar activities (ignoring user input)
    // Snapshot moves and activity ID before the loop for client dispatch.
    const int pre_activity_moves = u.get_moves();
    const activity_id pre_activity_id = u.activity ? u.activity.id() : activity_id::NULL_ID();
    if( cata_mp::is_client_mode() ) {
        // Snapshot this turn's activity id for the wire.
        cata_mp::set_client_turn_activity( pre_activity_id ? pre_activity_id.str()
                                           : std::string() );
        // Client busy-loop fix: yield to network thread when we have an activity
        // but no moves to tick it.
        if( pre_activity_id && pre_activity_moves <= 0 ) {
            std::this_thread::sleep_for( std::chrono::milliseconds( 10 ) );
        }
    }
    while( u.get_moves() > 0 && u.activity ) {
        u.activity.do_turn( u );
    }
    // Client-only: tick effects/needs once per elapsed host turn, without granting
    // local moves. SP/host process_turn() still runs in simulate_turn_suffix().
    if( cata_mp::is_client_mode() ) {
        cata_mp::mp_do_turn_process_turn( u );
    }
    // Client: if a wait activity consumed the server-granted moves this turn,
    // dispatch "wait" so the server advances its timeline in sync.
    if( cata_mp::is_client_mode() && pre_activity_moves > 0 && u.get_moves() <= 0 ) {
        cata_mp::client_dispatch_wait_for_activity( pre_activity_id );
    }

    // Process NPC sound events before they move or they hear themselves talking
    for( npc &guy : all_npcs() ) {
        if( rl_dist( guy.pos_bub(), u.pos_bub() ) < MAX_VIEW_DISTANCE ) {
            sounds::process_sound_markers( &guy );
        }
    }

    music::deactivate_music_id( music::music_id::sound );

    // Process sound events into sound markers for display to the player.
    sounds::process_sound_markers( &u );

    if( u.is_deaf() ) {
        sfx::do_hearing_loss();
    }
}

bool game::do_avatar_action_loop()
{
    ZoneScoped;
    avatar &u = get_avatar();
    map &m = get_map();

    // Capture pre-loop state for MP client dispatch.
    const int pre_act_moves = u.get_moves();
    const bool pre_act_had_activity = static_cast<bool>( u.activity );

    // avatar processes human input through handle_action()
    if( !u.has_effect( effect_sleep ) || uquit == QUIT_WATCH ) {
        if( u.get_moves() > 0 || uquit == QUIT_WATCH ) {
            // Tracks the position last memorized inside the step loop below.
            // Seeded with the turn-start position, which the previous turn's
            // end-of-turn update_map_memory already recorded, so a turn that is
            // a single step (the common case) triggers no extra memorise here.
            tripoint_bub_ms last_memorized_pos = u.pos_bub( m );
            while( u.get_moves() > 0 || uquit == QUIT_WATCH ) {

                // handle_action() may cause map updates, creatures to die
                m.process_falling();
                cleanup_dead();

                mon_info_update();
                // Process any new sounds the player caused during their turn.
                for( npc &guy : all_npcs() ) {
                    if( rl_dist( guy.pos_bub(), u.pos_bub() ) < MAX_VIEW_DISTANCE ) {
                        sounds::process_sound_markers( &guy );
                    }
                }
                explosion_handler::process_explosions();
                sounds::process_sound_markers( &u );
                if( !u.activity && uquit != QUIT_WATCH
                    && ( !u.has_distant_destination() || calendar::once_every( 10_seconds ) ) ) {
                    render_mid_step( u, m, last_memorized_pos );
                }

                if( queue_screenshot ) {
                    take_screenshot();
                    queue_screenshot = false;
                }

                {
                    const unsigned long long pre_msg = cata_mp::is_hosting() ? Messages::size() :
                                                       0;
                    if( handle_action() ) {
                        ++moves_since_last_save;
                        u.action_taken();
                        if( cata_mp::is_hosting() ) {
                            cata_mp::host_capture_avatar_msgs( pre_msg );
                            cata_mp::host_broadcast_post_action();
                        }
                    }
                }

                // Pump MP events after each host action so the remote player's
                // queued actions are processed immediately.
                if( cata_mp::is_hosting() ) {
                    cata_mp::process_mp_events();
                    cata_mp::ensure_mp_hud();
                }

                if( is_game_over() ) {
                    return true;
                }

                if( uquit == QUIT_WATCH ) {
                    break;
                }

                // avatar processes moves for activities started by handle_action()
                const activity_id iter_pre_act = u.activity ? u.activity.id()
                                                 : activity_id::NULL_ID();
                while( u.get_moves() > 0 && u.activity ) {
                    u.activity.do_turn( u );
                }
                // Client: if a multi-turn activity just ended mid-input-loop,
                // emit the end signal immediately and burn remaining moves to ack.
                const std::string &mid_iter_act = cata_mp::get_client_turn_activity();
                const bool mid_iter_orphan =
                    !mid_iter_act.empty() && !u.activity;
                if( cata_mp::is_client_mode() && ( iter_pre_act || mid_iter_orphan ) && !u.activity ) {
                    const std::string ended_id = iter_pre_act ? iter_pre_act.str() : mid_iter_act;
                    cata_mp::set_client_turn_activity( std::string() );
                    cata_mp::client_send_activity_end( ended_id );
                    if( !cata_mp::is_client_waiting_for_ack() ) {
                        u.set_moves( 0 );
                        cata_mp::client_dispatch_wait_for_activity(
                            activity_id(), /*force_idle=*/true );
                    }
                }
            }
            // Client: detect activity end post-loop.
            const std::string &post_loop_act = cata_mp::get_client_turn_activity();
            const bool post_orphan = !post_loop_act.empty() && !u.activity;
            const bool activity_just_ended = ( pre_act_had_activity || post_orphan ) && !u.activity;
            const bool moves_consumed = pre_act_moves > 0 && u.get_moves() <= 0;
            if( cata_mp::is_client_mode() && activity_just_ended ) {
                const std::string ended_id = pre_act_had_activity ? u.activity ?
                                             activity_id::NULL_ID().str() : "" : post_loop_act;
                cata_mp::set_client_turn_activity( std::string() );
                if( !ended_id.empty() ) {
                    cata_mp::client_send_activity_end( ended_id );
                }
            }
            if( cata_mp::is_client_mode() &&
                ( moves_consumed || activity_just_ended ) &&
                !cata_mp::is_client_waiting_for_ack() ) {
                cata_mp::client_dispatch_wait_for_activity(
                    u.activity ? u.activity.id() : activity_id::NULL_ID(), /*force_idle=*/true );
            }
            // Reset displayed sound markers now that the turn is over.
            sounds::reset_markers();
        } else {
            // Rate limit key polling to 10 times a second.
            // Client mode: enabled — handle_input(0) is non-blocking unless the
            // user actually presses an interrupt key, in which case the
            // cancel-confirmation popup blocking briefly is the correct UX.
            static auto start = std::chrono::time_point_cast<std::chrono::milliseconds>(
                                    std::chrono::steady_clock::now() );
            const auto now = std::chrono::time_point_cast<std::chrono::milliseconds>(
                                 std::chrono::steady_clock::now() );
            if( ( now - start ).count() > 100 ) {
                // Client: detect activity cancellation during passive wait.
                const bool had_act_pre = cata_mp::is_client_mode() && u.activity;
                handle_key_blocking_activity( 0 );
                if( cata_mp::is_client_mode() && had_act_pre && !u.activity ) {
                    cata_mp::set_client_turn_activity( std::string() );
                    cata_mp::client_send_activity_end( "" );
                    if( !cata_mp::is_client_waiting_for_ack() ) {
                        cata_mp::client_dispatch_wait_for_activity(
                            activity_id(), /*force_idle=*/true );
                    }
                }
                start = now;
            }

            mon_info_update();

            // If player is performing a task, a monster is dangerously close,
            // and monster can reach to the player or it has some sort of a ranged attack,
            // warn them regardless of previous safemode warnings
            if( u.activity ) {
                for( std::pair<const distraction_type, std::string> &dist : u.activity.get_distractions() ) {
                    if( cancel_activity_or_ignore_query( dist.first, dist.second ) ) {
                        break;
                    }
                }
            }
        }
    }
    return false;
}

void game::simulate_turn_suffix()
{
    ZoneScoped;
    avatar &u = get_avatar();
    map &m = get_map();

    if( driving_view_offset.x() != 0 || driving_view_offset.y() != 0 ) {
        // Still have a view offset, but might not be driving anymore,
        // or the option has been deactivated,
        // might also happen when someone dives from a moving car.
        // or when using the handbrake.
        vehicle *veh = veh_pointer_or_null( m.veh_at( u.pos_bub() ) );
        calc_driving_offset( veh );
    }

    scent_map &scent = get_scent();
    // No-scent debug mutation has to be processed here or else it takes time to start working
    if( !u.has_flag( json_flag_NO_SCENT ) ) {
        scent.set( u.pos_bub(), u.scent, u.get_type_of_scent() );
        overmap_buffer.set_scent( u.pos_abs_omt(),  u.scent );
    }
    scent.update( u.pos_bub(), m );

    // We need floor cache before checking falling 'n stuff
    m.build_floor_caches();

    m.process_falling();
    m.vehmove();
    m.process_fields();
    m.process_items();
    explosion_handler::process_explosions();
    m.creature_in_field( u );

    // Apply sounds from previous turn to monster and NPC AI.
    sounds::process_sounds();
    const int levz = m.get_abs_sub().z();
    // Update vision caches for monsters. If this turns out to be expensive,
    // consider a stripped down cache just for monsters.
    m.build_map_cache( levz, true );

    // Eagerly compute reachability zones for all creatures in parallel so
    // that individual monster::plan() / find_reachable() calls hit the cache.
    get_creature_tracker().precompute_all_zones();

    // process monster and npc turn
    // Lockstep: wait for the client to ack this turn before running monster AI.
    if( cata_mp::is_hosting() ) {
        cata_mp::wait_for_client_action();
        // Skip monmove when fast-forwarding through a wait activity.
        if( !cata_mp::host_is_in_wait_activity() ) {
            monmove();
        }
    } else {
        monmove();
    }

    if( calendar::once_every( time_between_npc_OM_moves ) ) {
        overmap_npc_move();
    }
    m.furniture_terrain_emit_fields();
    // required after monsters move and fields emit
    mon_info_update();

    // replenish avatar moves
    u.process_turn();

    // Update player map memory from the current field of view.  This used to
    // happen lazily inside the tiles draw path; running it here in the sim loop
    // (after the map cache is built, before the visibility cache is
    // invalidated) lets rendering become pure-read and keeps memory on the sim
    // side (required by autodrive / NPC pathing that consume it).
    // Skip only during view-blocking activities (sleeping / reading / long-wait
    // / crafting) — the same condition that triggers handle_progress_ui's
    // wait popup.  During those the player cannot see the world, so per-turn
    // memorisation is pure waste and the source of the stutter.
    // Autodrive uses the progress UI too, but unlike reading/crafting it moves
    // the avatar through a visible world and must keep recording map memory.
    const bool in_long_wait = u.has_effect( effect_sleep ) ||
                              ( u.activity.id() != ACT_AUTODRIVE &&
                                static_cast<bool>( u.activity.get_progress_message( u ) ) );
    if( !in_long_wait ) {
        m.update_map_memory( u );
    }

    // Per-turn world-state updates previously ran inside present_turn().
    // Moving them here keeps simulation advancing every tick regardless of
    // whether the renderer is gated.
    if( levz >= 0 && !u.is_underwater() ) {
        handle_weather_effects( get_weather().weather_id );
    }

    m.invalidate_visibility_cache();

    u.update_bodytemp();
    {
        weather_manager &weather = get_weather();
        u.update_body_wetness( *weather.weather_precise );
        u.apply_wetness_morale( weather.temperature );
    }

    if( calendar::once_every( 1_minutes ) ) {
        u.update_morale();
        for( npc &guy : all_npcs() ) {
            guy.update_morale();
            guy.check_and_recover_morale();
        }
    }

    if( calendar::once_every( 9_turns ) ) {
        u.check_and_recover_morale();
    }

    // reset player noise
    u.volume = 0;

    // Calculate bionic power balance
    u.power_balance = u.get_power_level() - u.power_prev_turn;
    u.power_prev_turn = u.get_power_level();
}

void game::present_turn()
{
    ZoneScoped;
    avatar &u = get_avatar();

    if( u.get_moves() < 0 && get_option<bool>( "FORCE_REDRAW" ) ) {
        ui_manager::redraw();
        refresh_display();
    }

    handle_progress_ui();

    if( !u.is_deaf() ) {
        sfx::remove_hearing_loss();
    }
    sfx::do_danger_music();
    sfx::do_vehicle_engine_sfx();
    sfx::do_vehicle_exterior_engine_sfx();
    sfx::do_low_stamina_sfx();

#if defined(EMSCRIPTEN)
    // This will cause a prompt to be shown if the window is closed, until the
    // game is saved.
    EM_ASM( window.game_unsaved = true; );
#endif

    debug_menu::debug_capture::tick_if_active();
    FrameMark;
}

void game::render_mid_step( avatar &u, map &m, tripoint_bub_ms &last_memorized_pos )
{
    // Visibility cache must stay fresh even when the render is skipped:
    // it is consumed by update_map_memory to decide which tiles were seen.
    m.update_visibility_cache( u.posz() );

    if( !skip_mid_step_render ) {
        wait_popup_reset();
        ui_manager::redraw();
    }

    // A single turn can span several steps (roads, speed effects,
    // partial-move loops).  The end-of-turn update_map_memory call
    // only sees the avatar's final position, so terrain visible only
    // mid-step would never be memorized.  That is invisible for
    // self-connecting terrain (re-memorized every pass) but loses
    // non-connecting terrain such as grass, which is memorized
    // exactly once.  Memorize the current field of view whenever the
    // avatar has actually moved since the last memorize, using the
    // visibility cache updated above.  The position guard keeps
    // single-step turns (the common case) free: their start position
    // was already memorized at the previous turn's end.
    const tripoint_bub_ms mem_pos = u.pos_bub( m );
    if( mem_pos != last_memorized_pos ) {
        m.update_map_memory( u );
        last_memorized_pos = mem_pos;
    }
}
