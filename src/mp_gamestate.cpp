#include "vehicle_control.h"
#include "mp_gamestate.h"
#include "mp_log.h"
#include "mp_combat_result.h"
#include "mp_throw.h"
#include "mp_peek.h"
#include "view_action.h"
#include "mp_equipment.h"
#include "sling.h"

#include <list>
#include <stdexcept>
#include <limits>

#include "activity_actor.h"
#include "activity_actor_definitions.h"
#include "activity_type.h"
#include "avatar.h"
#include "bodypart.h"
#include "calendar.h"
#include "cata_path.h"
#include "cata_scope_helpers.h"
#include "cata_utility.h"
#include "catacharset.h"
#include "character.h"
#include "character_action_guard.h"
#include "character_attire.h"
#include "character_id.h"
#include "city.h"
#include "clone_ptr.h"
#include "color.h"
#include "construction.h"
#include "coordinates.h"
#include "creature.h"
#include "creature_tracker.h"
#include "current_map.h"
#include "cursesdef.h"
#include "dialogue_chatbin.h"
#include "display.h"
#include "do_turn.h"
#include "effect.h"
#include "enums.h"
#include "field.h"
#include "filesystem.h"
#include "flexbuffer_json.h"
#include "game.h"
#include "gates.h"
#include "game_inventory.h"
#include "get_version.h"
#include "input.h"
#include "inventory.h"
#include "item.h"
#include "item_location.h"
#include "itype.h"
#include "json.h"
#include "json_loader.h"
#include "line.h"
#include "map.h"
#include "map_scale_constants.h"
#include "map_simulation_regions.h"
#include "mapdata.h"
#include "memory_fast.h"
#include "messages.h"
#include "message_routing.h"
#include "mp_player_feedback.h"
#include "mod_manager.h"
#include "monster.h"
#include "mp_actor_binding.h"
#include "mp_client_conn.h"
#include "mp_mod_compat.h"
#include "mp_pickup.h"
#include "mp_protocol.h"
#include "mp_queue.h"
#include "mp_server.h"
#include "mp_world_session.h"
#include "pickup.h"
#include "mtype.h"
#include "mutation.h"
#include "npc.h"
#include "npc_opinion.h"
#include "output.h"
#include "overmap.h"
#include "overmapbuffer.h"
#include "panels.h"
#include "path_info.h"
#include "pimpl.h"
#include "player_activity.h"
#include "point.h"
#include "rng.h"
#include "sleep.h"
#include "sounds.h"
#include "scent_map.h"
#include "string_formatter.h"
#include "string_input_popup.h"
#include "tileray.h"
#include "translation.h"
#include "translations.h"
#include "trap.h"
#include "type_id.h"
#include "ui_manager.h"
#include "uilist.h"
#include "units.h"
#include "veh_type.h"
#include "vehicle.h"
#include "vpart_position.h"
#include "vpart_range.h"
#include "worldfactory.h"
#include "item_disposition.h"
#include "item_load_context.h"
#include "item_source.h"
#include "item_uid.h"
#include "kill_statistics.h"
#include "map_viewpoint.h"
#include "mp_admission.h"
#include "mp_apply_watchdog.h"
#include "mp_entity_registry.h"
#include "mp_firearm.h"
#include "mp_inventory_activity.h"
#include "mp_item_source.h"
#include "mp_melee.h"
#include "mp_player_identity.h"
#include "mp_player_store.h"
#include "mp_player_view.h"
#include "mp_world_state.h"
#include "player_control.h"
#include "player_identity.h"
#include "world_identity.h"
#ifdef TILES
    #include "sdl_wrappers.h"
#endif
#include <algorithm>
#include <array>
#include <cctype>
#include <chrono>
#include <cmath>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <ctime>
#include <exception>
#include <filesystem>
#include <fstream>
#include <functional>
#include <iostream>
#include <iterator>
#include <map>
#include <memory>
#include <mutex>
#include <optional>
#include <set>
#include <sstream>
#include <string>
#include <string_view>
#include <system_error>
#include <thread>
#include <tuple>
#include <unordered_map>
#include <unordered_set>
#include <utility>
#include <vector>

// This experimental multiplayer implementation intentionally keeps wire-only
// IDs and helper types local to this translation unit while it is being split
// into smaller components.
// NOLINTBEGIN(cata-no-long,cata-static-string_id-constants,cata-xy,misc-use-internal-linkage,performance-inefficient-string-concatenation)

namespace cata_mp
{

static const morale_type morale_high_five( "morale_high_five" );

static const vproto_id vehicle_prototype_none( "none" );

static world_session &mp_session();

enum class log_role { none, host, client };

static void mp_log_impl( const std::string &msg, log_role role )
{
    // Both the transport worker and simulation thread write this stream.
    static std::mutex log_mutex;
    const std::scoped_lock lock( log_mutex );
    // Wall-clock ms since the previous mp_log line — lets us read the log as a
    // timeline ("this step took 47ms") without having to add timing helpers
    // around every call site.  Reset each line: prefix shows the gap since the
    // last log call, so a long gap = something blocked the main thread.
    static std::chrono::steady_clock::time_point last =
        std::chrono::steady_clock::now();
    const std::chrono::steady_clock::time_point now = std::chrono::steady_clock::now();
    const long long delta_ms =
        std::chrono::duration_cast<std::chrono::milliseconds>( now - last ).count();
    last = now;
    // Absolute wall-clock stamp [HH:MM:SS.mmm] in front of the per-log [+Nms]
    // delta.  The delta is each log's private clock; the wall-clock lets the host
    // and client logs be aligned against each other (assuming the two machines'
    // clocks are roughly NTP-synced, which LAN/Tailscale gives).  Thread-safe:
    // system_clock::now and localtime_r/_s into a local tm, no shared buffer.
    const std::chrono::system_clock::time_point wall = std::chrono::system_clock::now();
    const std::time_t wt = std::chrono::system_clock::to_time_t( wall );
    const int wms = static_cast<int>( std::chrono::duration_cast<std::chrono::milliseconds>(
                                          wall.time_since_epoch() ).count() % 1000 );
    std::tm tmv{};
#if defined(_WIN32)
    localtime_s( &tmv, &wt );
#else
    localtime_r( &wt, &tmv );
#endif
    char tbuf[20];
    // NOLINTNEXTLINE(cata-use-point-apis)
    ( void )std::snprintf( tbuf, sizeof( tbuf ), "[%02d:%02d:%02d.%03d]",
                           tmv.tm_hour, tmv.tm_min, tmv.tm_sec, wms );
    const std::string line = std::string( tbuf ) + "[+" +
                             std::to_string( delta_ms ) + "ms] " + msg;

    // Also append to /tmp/cdda-mp-{server,client}.log so log capture doesn't
    // require launching via start-mp.sh's stdout-tee.  Opens lazily on the
    // first call once the mode is known; truncates on first open so each
    // session's log starts fresh.  Re-opens with truncation if the mode
    // changes (e.g. SP→host via the in-game menu).
    static std::ofstream log_file;
    static std::string current_path;
    // Log directory: /tmp on unix (the stable path our tooling reads). Windows
    // has no /tmp — an ofstream open on a nonexistent C:\tmp\ silently fails, so
    // the client never wrote a log there. Use %USERPROFILE% (always present and
    // writable): C:\Users\<name>\cdda-mp-client.log.
    std::string log_dir = "/tmp/";
#if defined(_WIN32)
    if( const char *home = std::getenv( "USERPROFILE" ) ) {
        log_dir = std::string( home ) + "\\";
    } else if( const char *tmp = std::getenv( "TEMP" ) ) {
        log_dir = std::string( tmp ) + "\\";
    } else {
        log_dir.clear();
    }
#endif
    std::string desired_path;
    if( role == log_role::client ) {
        desired_path = log_dir + "cdda-mp-client.log";
    } else if( role == log_role::host ) {
        desired_path = log_dir + "cdda-mp-server.log";
    }
    if( !desired_path.empty() && desired_path != current_path ) {
        if( log_file.is_open() ) {
            log_file.close();
        }
        // Append (don't rotate per session — that split a play session across
        // .log/.log.1 and hid debug data, 2026-06-03).  ONE exception: if the
        // file has grown past a hard cap, truncate on open so it can't grow
        // unbounded across dozens of launches.  Only fires at the start of a new
        // launch, never mid-session, so it never pulls live data out from under
        // a debugging run.
        constexpr std::uintmax_t LOG_CAP_BYTES = 10ULL * 1024 *
                1024;  // 10 MB — keeps logs attachable to Discord (10MB free) / GitHub (25MB)
        std::error_code ec;
        const std::filesystem::path desired_fs_path = std::filesystem::u8path( desired_path );
        const std::uintmax_t sz =
            std::filesystem::exists( desired_fs_path, ec )
            ? std::filesystem::file_size( desired_fs_path, ec ) : 0;
        const std::ios::openmode mode = ( !ec && sz > LOG_CAP_BYTES )
                                        ? ( std::ios::out | std::ios::trunc )
                                        : ( std::ios::out | std::ios::app );
        log_file.open( desired_path, mode );
        current_path = desired_path;
        log_file << "\n[cdda-mp] ===================== LOG OPENED ====================="
                 << std::endl;
    }
    if( log_file.is_open() ) {
        log_file << line << '\n';
        log_file.flush();
    }
}

// Owner-only routing; background producers use the explicit-role entry points.
void mp_log( const std::string &msg )
{
    mp_log_impl( msg, is_client_mode() ? log_role::client :
                 ( is_host_mode() || is_server_mode() ? log_role::host : log_role::none ) );
}

void mp_log_host( const std::string &msg )
{
    mp_log_impl( msg, log_role::host );
}

void mp_log_client( const std::string &msg )
{
    mp_log_impl( msg, log_role::client );
}

// ----------------------------------------------------------------------------
// Client main-thread apply watchdog + breadcrumbs.
// Record apply phases through the world's owned diagnostic worker. It receives
// only labels/timestamps and is joined before world/session teardown.
struct mp_apply_step {
    std::string label_;
    std::chrono::steady_clock::time_point t0_;
    apply_watchdog &watchdog_;
    apply_watchdog::token token_;
    explicit mp_apply_step( std::string label )
        : label_( std::move( label ) ), t0_( std::chrono::steady_clock::now() ),
          watchdog_( g->multiplayer_session().client_apply_watchdog ),
          token_( watchdog_.begin( label_, t0_ ) ) {
        mp_log( "[cdda-mp] STATE-APPLY: " + label_ + " start" );
    }
    mp_apply_step( const mp_apply_step & ) = delete;
    mp_apply_step &operator=( const mp_apply_step & ) = delete;
    ~mp_apply_step() {
        const std::chrono::milliseconds::rep ms = std::chrono::duration_cast<std::chrono::milliseconds>(
                    std::chrono::steady_clock::now() - t0_ ).count();
        watchdog_.end( token_ );
        mp_log( "[cdda-mp] STATE-APPLY: " + label_ + " done dur=" + std::to_string( ms ) + "ms" );
    }
};

bool is_server_mode()
{
    return g && mp_session().server_mode;
}

void set_server_mode( bool enabled )
{
    mp_session().server_mode = enabled;
}

bool is_host_mode()
{
    return g && mp_session().host_mode;
}

void set_host_mode( bool enabled )
{
    mp_session().host_mode = enabled;
}

bool is_mp_mode()
{
    return is_server_mode() || is_host_mode();
}

bool is_session_active()
{
    return is_client_mode() || is_mp_mode();
}

bool is_hosting()
{
    return get_active_server() != nullptr;
}

// Host: sfx events generated during this turn, forwarded to the client in the next grant.
// Capped at 32 entries per turn to bound grant message size.

void host_queue_sfx( const std::string &id, const std::string &variant, int vol )
{
    if( !is_hosting() || vol < 5 ) {
        return;
    }
    for( const auto &entry : mp_session().remote_players ) {
        cata_mp::remote_player_session &recipient = *entry.second;
        if( recipient.connected && !recipient.detach_pending &&
            recipient.turn.host_sfx_queue.size() < 32 ) {
            recipient.turn.host_sfx_queue.push_back( { id, variant, vol } );
        }
    }
}
// This is menu/CLI intent, not an active world. It survives initial setup()
// and is consumed only once the first world turn can create its owned host.
struct host_request {
    uint16_t port;
    std::string password;
    std::string version;
};
static std::optional<host_request> g_pending_host_start;

// Legacy gameplay helpers access the current world's owned proxy bindings.
// The transport thread communicates through mp_event values instead.
static world_session &mp_session()
{
    return g->multiplayer_session();
}

static npc *mp_loaded_actor( actor_binding &binding )
{
    npc *actor = binding.retained( g->npc_lifetimes() );
    // critter_by_id also finds unloaded overmap NPCs. Control and presentation
    // require the exact object to still be in this world's active tracker.
    return actor && g->shared_from( *actor ) ?
           binding.resolve_loaded( actor, g->npc_lifetimes() ) : nullptr;
}

static npc *mp_remote_actor( remote_player_session &recipient )
{
    return mp_loaded_actor( recipient.actor );
}

static map &remote_actor_map( const remote_player_session &recipient, const npc &actor )
{
    map &primary = reality_bubble();
    if( const resident_region *region = mp_session().find_region( recipient.credentials.id ) ) {
        if( region->terrain->has_loaded_submap( actor.pos_abs_sm() ) ) {
            return *region->terrain;
        }
    }
    return mp_session().map_for( primary, actor.pos_abs_sm() );
}

static map &recipient_map( remote_player_session &recipient )
{
    const npc *const actor = mp_remote_actor( recipient );
    return actor ? remote_actor_map( recipient, *actor ) : reality_bubble();
}

static void activate_resident_region( map &terrain )
{
    const map_simulation_regions loaded = mp_session().simulation_regions( reality_bubble() );
    const swap_map context( terrain );
    g->load_npcs( &terrain );
    terrain.spawn_monsters( true, true, &loaded );
}

void refresh_resident_regions( bool before_primary_relocation )
{
    map &primary = reality_bubble();
    if( !is_hosting() || &get_map() != &primary ) {
        return;
    }
    world_session &session = mp_session();
    if( session.refreshing_regions || ( session.remote_players.empty() && !session.has_regions() ) ) {
        return;
    }
    const restore_on_out_of_scope restore_refresh( session.refreshing_regions );
    session.refreshing_regions = true;
    const point_abs_sm primary_center =
        primary.get_abs_sub().xy() + point_rel_sm( HALF_MAPSIZE, HALF_MAPSIZE );
    std::set<player_id> keep;
    bool coverage_changed = false;
    for( const auto &entry : session.remote_players ) {
        remote_player_session &peer = *entry.second;
        const npc *const actor = mp_remote_actor( peer );
        if( !actor ) {
            continue;
        }
        const tripoint_abs_sm center = actor->pos_abs_sm();
        const int distance = square_dist( center.xy(), primary_center );
        resident_region *region = session.find_region( peer.credentials.id );
        if( !before_primary_relocation && distance < HALF_MAPSIZE - ( region ? 3 : 2 ) &&
            primary.has_loaded_submap( center ) ) {
            continue;
        }
        keep.insert( peer.credentials.id );
        if( !region ) {
            try {
                region = &session.load_region( *g, primary, peer.credentials.id, center );
            } catch( const std::exception &error ) {
                mp_log_host( std::string( "[ccb-mp] could not open guest region: " ) + error.what() );
                continue;
            }
            activate_resident_region( *region->terrain );
            coverage_changed = true;
            continue;
        }
        const tripoint_abs_sm current = region->terrain->get_abs_sub() +
                                        point_rel_sm( HALF_MAPSIZE, HALF_MAPSIZE );
        if( current != center ) {
            session.recenter_region( primary, *region, center );
            activate_resident_region( *region->terrain );
            coverage_changed = true;
        }
    }
    for( const auto &entry : session.active_regions() ) {
        const player_id player = entry.get().player;
        if( keep.count( player ) == 0 ) {
            session.retire_region( primary, player );
            coverage_changed = true;
        }
    }
    if( coverage_changed ) {
        g->unload_creatures_outside_resident_maps();
    }
}

static const peer_observation &mp_partner_observation( character_id target = character_id() )
{
    if( !target.is_valid() ) {
        if( const npc *partner = get_partner_npc() ) {
            target = partner->getID();
        }
    }
    if( is_client_mode() ) {
        for( const auto &entry : mp_session().client_player_views ) {
            if( entry.second->actor.id() == target ) {
                return entry.second->observation;
            }
        }
        if( target == mp_session().client_host_actor.id() ) {
            return mp_session().host_observation;
        }
    }
    if( const auto *recipient = mp_session().find_remote( target ) ) {
        return recipient->observation;
    }
    static const peer_observation empty;
    return empty;
}

static npc *mp_host_view_actor()
{
    return mp_loaded_actor( mp_session().client_host_actor );
}

client_connection *current_client_connection()
{
    return g ? &mp_session().client : nullptr;
}

std::shared_ptr<server> get_active_server()
{
    return g ? mp_session().hosting.active_server() : nullptr;
}

event_queue &get_mp_queue()
{
    return mp_session().hosting.events();
}

// Monotonic millisecond clock shared by the ping stamp/echo. Process-relative;
// only differences on the SAME machine are used, so no cross-host clock sync.
static int64_t mp_mono_ms()
{
    static const std::chrono::steady_clock::time_point start =
        std::chrono::steady_clock::now();
    return std::chrono::duration_cast<std::chrono::milliseconds>(
               std::chrono::steady_clock::now() - start ).count();
}
// Worst-hurt body part's real (current, max) HP for a character — the limb the
// Co-op panel bar represents. Worst by fraction so one shredded limb still shows.
// Computed on each side from its OWN avatar (real max), then synced.
static std::pair<int, int> mp_worst_limb_hp( const Character &c )
{
    int worst_cur = 0;
    int worst_max = 0;
    float worst = 2.0f;
    for( const bodypart_id &bp : c.get_all_body_parts() ) {
        const int hpm = c.get_hp_max( bp );
        if( hpm <= 0 ) {
            continue;
        }
        const int hp = c.get_hp( bp );
        const float f = static_cast<float>( hp ) / hpm;
        if( f < worst ) {
            worst = f;
            worst_cur = hp;
            worst_max = hpm;
        }
    }
    return { worst_cur, worst_max };
}

static const int g_map_sync_cap = 64;
static std::string build_map_sync_z( remote_player_session &recipient, int az,
                                     bool complete = false );
static std::string build_map_sync( remote_player_session &recipient, bool complete = false );

static const peek_authorization *active_peek( remote_player_session &recipient )
{
    auto &peek = recipient.inventory_activity.peek;
    npc *who = mp_remote_actor( recipient );
    if( peek && ( !who || !peek->valid_for( *who, get_map() ) ) ) {
        peek.reset();
    }
    return peek ? &*peek : nullptr;
}

// Strip "ACT_" prefix and lowercase the rest so the HUD shows "drop" not
// "ACT_DROP".  Returns "—" for empty.
static std::string mp_format_activity( const std::string &act_id )
{
    if( act_id.empty() ) {
        return "\xe2\x80\x94";
    }
    std::string s = act_id;
    if( s.rfind( "ACT_", 0 ) == 0 ) {
        s = s.substr( 4 );
    }
    for( char &c : s ) {
        c = static_cast<char>( std::tolower( static_cast<unsigned char>( c ) ) );
    }
    return s;
}

// Look up the partner's display name.  On host: the proxy NPC representing
// the connected client.  On client: the proxy NPC representing the host.
// Falls back to "Partner" when the proxy isn't yet known.  This is the single
// source of truth for any MP message that needs to address the other player.
static std::string mp_partner_display_name()
{
    if( const npc *partner = is_hosting() ? get_partner_npc() : mp_host_view_actor() ) {
        if( !partner->name.empty() ) {
            return partner->name;
        }
    }
    return _( "Partner" );
}

// Translate an activity id (e.g. ACT_VEHICLE) to a human verb phrase suitable
// for "<name> begins <X>." sentences.  Prefers the activity_type::verb()
// translation maintained in JSON ("constructing a vehicle", "reading", etc.).
// Falls back to a stripped/lowercased id when no verb is registered.
static std::string mp_activity_verb_phrase( const std::string &act_id )
{
    if( act_id.empty() ) {
        return std::string();
    }
    const activity_id aid( act_id );
    if( aid.is_valid() ) {
        const std::string v = aid->verb().translated();
        if( !v.empty() ) {
            return v;
        }
    }
    return mp_format_activity( act_id );
}

// Forward decl — defined further down with the other co-op helper functions.
static void mp_cancel_help_if_partner_done();

// Templates wire-sync helpers (definitions below alongside notify_session_ending).
// Forward-declared so the host- and client-side message dispatchers can call
// them; both dispatchers live above the definitions.
static void mp_handle_templates_list( const std::string &msg, const peer_admission &recipient = {} );
static void mp_handle_template_request( const std::string &msg, const peer_admission &recipient = {} );
static void mp_handle_template_data( const std::string &msg );
static void mp_send_payload( const std::string &payload, const peer_admission &recipient );
static void mp_templates_sync_on_join( const peer_admission &recipient );

// Fire "<partner> begins <verb>." / "<partner> has finished." on the
// transition edges.  Caller is responsible for setting g_partner_activity to
// the latest value before calling this.
static void mp_partner_activity_transition_check()
{
    mp_cancel_help_if_partner_done();
    if( mp_partner_observation().partner_activity == mp_session().presentation.partner_activity_prev ) {
        return;
    }
    const std::string partner_name = mp_partner_display_name();
    if( mp_session().presentation.partner_activity_prev.empty() &&
        !mp_partner_observation().partner_activity.empty() ) {
        add_msg( m_info, _( "%1$s begins %2$s." ), partner_name,
                 mp_activity_verb_phrase( mp_partner_observation().partner_activity ) );
    } else if( !mp_session().presentation.partner_activity_prev.empty() &&
               mp_partner_observation().partner_activity.empty() ) {
        // Use the just-ended activity's verb so the message reads "<name> has
        // finished reading." instead of the generic "<name> has finished."
        add_msg( m_info, _( "%1$s has finished %2$s." ), partner_name,
                 mp_activity_verb_phrase( mp_session().presentation.partner_activity_prev ) );
    }
    mp_session().presentation.partner_activity_prev = mp_partner_observation().partner_activity;
    // Partner's activity changed — if we were helping with the OLD one and
    // they've moved on (or stopped entirely), drop our local commitment so
    // the SP helper bonus stops being applied.
    mp_cancel_help_if_partner_done();
}

// Host: reset overmap-stream state so the next client gets a fresh bulk send.
// Defined far below with the rest of the overmap-streaming code.

static const efftype_id effect_sleep( "sleep" );

// ---------------------------------------------------------------------------
// Info panel (bottom-left corner)
// ---------------------------------------------------------------------------

// Forward-declared so mp_hud_t::draw() can use it for its border color;
// definition lives further down with the mp_edge_t frame that shares it.
static bool mp_turn_show_green();

// ---------------------------------------------------------------------------
// Co-op text chat (basic).  Each line is shown in two places: up to the last
// MP_CHAT_OVERLAY_MAX lines directly above the info panel (magenta), and in the
// main message log.  Wire: {"type":"chat","from":<name>,"text":<line>}, sent
// client<->host; each side just displays what it receives (2-player).
static constexpr size_t MP_CHAT_OVERLAY_MAX = 3;
// Each line carries the sender's color so host vs client messages are visually
// distinct (host = light cyan, client = light blue) in both the overlay and log.

static int mp_chat_overlay_count()
{
    return static_cast<int>( std::min( mp_session().presentation.mp_chat_overlay.size(),
                                       MP_CHAT_OVERLAY_MAX ) );
}

struct mp_hud_t {
    catacurses::window win;
    ui_adaptor ui;

    // Width is recomputed on resize to span the whole map viewport (left edge up
    // to just before the right sidebar). Full TERMX would overdraw the sidebar's
    // bottom rows, so we stop at panel_manager's right boundary.
    int W = 56;
    static constexpr int H = 3;   // top border + status row + bottom border

    mp_hud_t() {
        ui.on_screen_resize( [this]( ui_adaptor & ua ) {
            // Single window: any chat lines render INSIDE the top of the co-op
            // box, above the status row.  One stable window/area — the earlier
            // two-window overlay churned the ui_adaptor stack and made the panel
            // flicker / vanish on unrelated redraws (focus changes, turn-waits).
            panel_manager &pm = panel_manager::get_manager();
            W = std::max( 40, TERMX - pm.get_width_right() );
            const int ch = mp_chat_overlay_count();
            // border + chat lines + separator + status row + border
            const int height = ch > 0 ? ch + 4 : H;
            win = catacurses::newwin( height, W, point( 0, TERMY - height ) );
            ua.position_from_window( win );
        } );
        ui.on_redraw( [this]( const ui_adaptor & ) {
            draw();
        } );
        ui.mark_resize();
    }

    void draw() const {
        werase( win );
        // Border color tracks the same turn-state signal as the edge frame so
        // panel + frame pulse together.
        draw_border( win, mp_turn_show_green() ? c_light_green : c_red );

        // Chat lines inside the top of the box, each in its sender's color
        // (host = light cyan, client = light blue).  The status row sits below.
        const int ch = mp_chat_overlay_count();
        if( ch > 0 ) {
            const int start = static_cast<int>( mp_session().presentation.mp_chat_overlay.size() ) - ch;
            for( int i = 0; i < ch; ++i ) {
                const mp_chat_line &cl = mp_session().presentation.mp_chat_overlay[start + i];
                mvwprintz( win, point( 1, 1 + i ), cl.color, "%s",
                           cl.text.substr( 0, W - 2 ).c_str() );
            }
            // Separator between chat and the status row.
            mvwprintz( win, point( 1, ch + 1 ), c_dark_gray, "%s",
                       std::string( W - 2, '-' ).c_str() );
        }
        // Status row sits below the chat + separator when chat is present.
        const int crow = ch > 0 ? ch + 2 : 1;

        // Partner-centric single content row.  Host sees the connected client;
        // client sees the host.  Both read from the local NPC proxy that the
        // wire-state apply path keeps fresh (HP, move_mode, position), plus
        // the latest g_partner_activity / g_partner_activity_pct received
        // from the wire.
        npc *partner = is_hosting() ? get_partner_npc() : mp_host_view_actor();

        if( mp_session().remote_players.empty() && is_hosting() ) {
            mvwprintz( win, point( 2, crow ), c_dark_gray, "%s",
                       _( "Partner not connected" ) );
            wnoutrefresh( win );
            return;
        }

        // Column 0: partner name.  Prefer the live proxy NPC's name; fall back
        // to the cached name from the wire when the proxy isn't resolvable
        // (first-frame race after connect, between npc despawn/respawn).
        // Truncated to 10 chars with a ".." continuation marker.
        std::string pname = partner ? partner->name : mp_partner_observation().partner_name_cached;
        if( pname.empty() ) {
            pname = "Partner";
        }
        // First name only.
        const size_t pname_sp = pname.find( ' ' );
        if( pname_sp != std::string::npos ) {
            pname = pname.substr( 0, pname_sp );
        }
        if( pname.size() > 8 ) {
            pname = pname.substr( 0, 8 );
        }
        int x = 1;
        mvwprintz( win, point( x, crow ), c_white, "%-8s", pname.c_str() );
        x += 9;

        // Move mode in square brackets — first char only (w/r/c/p) for compactness.
        // Requires the proxy NPC; show a placeholder when it isn't available.
        char mm = '?';
        if( partner ) {
            const std::string mode_str = partner->move_mode.str();
            if( !mode_str.empty() ) {
                mm = mode_str[0];
            }
        }
        mvwprintz( win, point( x, crow ), partner ? c_white : c_dark_gray, "[%c]", mm );
        x += 4;

        // Mood: CDDA's own morale face + color (display::morale_emotion), so it
        // matches the player's sidebar mood widget exactly. The partner proxy is
        // an npc (no character_mood_face(), which is avatar-only), so we feed the
        // synced morale level through the DEFAULT mood face's value table.
        {
            static const mood_face_id mood_face_DEFAULT( "DEFAULT" );
            const std::pair<std::string, nc_color> mf =
                display::morale_emotion( mp_partner_observation().partner_morale, mood_face_DEFAULT.obj() );
            const nc_color col = partner ? mf.second : c_dark_gray;
            mvwprintz( win, point( x, crow ), col, "%s", mf.first.c_str() );
            // Advance by the actual face width + 1 so the HP bar sits right up
            // against the mood emoji instead of after a fixed reserved slot.
            x += static_cast<int>( utf8_width( mf.first ) ) + 1;
        }

        // HP bar — the partner's WORST body part rendered with the game's native
        // get_hp_bar (same glyphs + coloring as the sidebar limb bars). cur/max
        // come synced from the partner's real character (g_partner_hp_*), NOT the
        // local proxy, whose proxy-derived max HP gave the wrong length/color.
        std::string hpbar = "-----";
        nc_color hp_color = c_dark_gray;
        if( partner && mp_partner_observation().partner_hp_max > 0 ) {
            const std::pair<std::string, nc_color> bar =
                get_hp_bar( mp_partner_observation().partner_hp_cur, mp_partner_observation().partner_hp_max );
            hpbar = bar.first;
            hp_color = bar.second;
        }
        // Fixed 5-wide slot inside the brackets so the columns after it stay put;
        // get_hp_bar returns a variable-length string (empty..5 chars).
        mvwprintz( win, point( x, crow ), c_white, "[" );
        mvwprintz( win, point( x + 1, crow ), hp_color, "%s", hpbar.c_str() );
        mvwprintz( win, point( x + 6, crow ), c_white, "]" );
        x += 9;

        // Activity + progress %.  Use the verb phrase (e.g. "reading",
        // "constructing a vehicle") so the panel matches the begin/finish
        // sentences.  Empty when partner is idle.
        if( !mp_partner_observation().partner_activity.empty() ) {
            const std::string verb = mp_activity_verb_phrase( mp_partner_observation().partner_activity );
            // Compose "<verb> NN%" — clamp verb length so the % stays on row.
            const int avail = W - x - 8; // reserve room for " NN%" + drift
            std::string vshown = verb;
            if( static_cast<int>( vshown.size() ) > avail ) {
                vshown = vshown.substr( 0, std::max( 0, avail - 2 ) ) + "..";
            }
            mvwprintz( win, point( x, crow ), c_yellow, "%s", vshown.c_str() );
            x += static_cast<int>( vshown.size() ) + 1;
            mvwprintz( win, point( x, crow ), c_light_blue, "%d%%",
                       mp_partner_observation().partner_activity_pct );
            x += 5;
        }

        // Latency to the partner on the right edge — the player-facing replacement
        // for the old dev calendar-drift indicator. Round-trip ms, colored
        // green/yellow/red by how laggy the link feels. "--" until first measured.
        {
            std::string ps;
            nc_color pc;
            if( mp_partner_observation().partner_ping_ms < 0 ) {
                ps = "--";
                pc = c_dark_gray;
            } else {
                pc = mp_partner_observation().partner_ping_ms < 120 ? c_green
                     : mp_partner_observation().partner_ping_ms < 300 ? c_yellow : c_red;
                ps = std::to_string( mp_partner_observation().partner_ping_ms ) + "ms";
            }
            mvwprintz( win, point( W - static_cast<int>( ps.size() ) - 1, crow ),
                       pc, "%s", ps.c_str() );
        }

        wnoutrefresh( win );
    }
};

// ---------------------------------------------------------------------------
// Turn-state signal: shared helper + thin-frame border around the game view
// ---------------------------------------------------------------------------

// True when the player can act this instant — used for both the edge frame
// color and the mp_hud panel border color. Tracks raw moves, in-flight wait
// activities (catch-breath etc. that own the move budget), and host wait-for-
// client lockstep. Updates the shared smoother on green so the 400ms hold
// covers the ack-gap blip.
static bool mp_turn_show_green()
{
    const player_activity &pact = get_avatar().activity;
    const bool in_wait_act = is_wait_activity( pact.id().str() );
    // On the CLIENT, local moves>0 is NOT sufficient to act: the client must
    // also not be waiting on the host's grant/ack for the turn it already sent.
    // Without this, the bar paints green (we have stale local moves) while the
    // client is actually blocked until the host moves/waits — the "green but
    // can't proceed" lie. Mirrors the client's act-readiness gate
    // (moves>0 && !waiting_for_ack). On the host this term is false (host uses
    // g_host_waiting_for_client), so host behavior is unchanged.
    const bool client_blocked_on_ack = is_client_mode() &&
                                       mp_session().client_turn.client_waiting_for_ack;
    const bool go = get_avatar().get_moves() > 0 && !in_wait_act
                    && !mp_session().host_waiting_for_clients && !client_blocked_on_ack;
    const std::chrono::steady_clock::time_point now = std::chrono::steady_clock::now();
    if( go ) {
        mp_session().presentation.mp_last_go_time = now;
    }
    const std::chrono::milliseconds::rep since_go_ms =
        std::chrono::duration_cast<std::chrono::milliseconds>(
            now - mp_session().presentation.mp_last_go_time ).count();
    return !in_wait_act && ( go || since_go_ms < 400 );
}

struct mp_edge_t {
    // Two full-height 1-cell windows on the left and right edges of the game
    // view (excluding the right sidebar). Half-block glyphs render as crisp
    // vertical lines at the very edge of their cell. Top/bottom bars removed
    // to claim back vertical screen real estate; the partner-info panel keeps
    // its own colored border so the turn-state signal is still visible there.
    catacurses::window lft_win, rgt_win;
    ui_adaptor ui;
    // Last sidebar geometry the windows were built for. on_screen_resize only
    // fires on terminal/font changes, NOT when the player flips sidebar side or
    // switches layout from the options menu — so we watch these and force a
    // re-resize when they change (see maybe_resize()).
    int last_left = -1, last_right = -1, last_termx = -1;

    mp_edge_t() {
        ui.on_screen_resize( [this]( ui_adaptor & ua ) {
            // Mirror the SP terrain-window math (game.cpp): the map view spans
            // columns [get_width_left(), TERMX - get_width_right() - 1]. Both
            // accessors already account for SIDEBAR_POSITION (left vs right) and
            // the active layout's width, so the stripes land flush on the
            // sidebar's inner edge no matter which side it's on or how wide it
            // is. The ▌/▐ half-blocks then hug that boundary: when a sidebar is
            // present the colored half faces it; when an edge is the bare screen
            // edge the stripe frames the map there instead.
            panel_manager &pm = panel_manager::get_manager();
            const int left_col = pm.get_width_left();
            const int right_col = std::max( left_col, TERMX - pm.get_width_right() - 1 );
            lft_win = catacurses::newwin( TERMY, 1, point( left_col, 0 ) );
            rgt_win = catacurses::newwin( TERMY, 1, point( right_col, 0 ) );
            last_left = pm.get_width_left();
            last_right = pm.get_width_right();
            last_termx = TERMX;
            ua.position_from_window( lft_win );
        } );
        ui.on_redraw( [this]( const ui_adaptor & ) {
            draw();
        } );
        ui.mark_resize();
    }

    // Re-run the resize callback when the sidebar geometry changed out from
    // under us (side flip / layout switch / width change). ui_adaptor only
    // re-runs on_screen_resize on its own for terminal/font changes, so without
    // this the stripes stay pinned to their startup columns.
    void maybe_resize() const {
        panel_manager &pm = panel_manager::get_manager();
        if( pm.get_width_left() != last_left || pm.get_width_right() != last_right
            || TERMX != last_termx ) {
            ui.mark_resize();
        }
    }

    void draw() const {
        const nc_color c = mp_turn_show_green() ? c_light_green : c_red;

        // ▌ left half block on the left column, ▐ right half block on right.
        werase( lft_win );
        werase( rgt_win );
        for( int y = 0; y < TERMY; y++ ) {
            mvwprintz( lft_win, point( 0, y ), c, "\xe2\x96\x8c" );
            mvwprintz( rgt_win, point( 0, y ), c, "\xe2\x96\x90" );
        }
        wnoutrefresh( lft_win );
        wnoutrefresh( rgt_win );
    }
};

session_presentation::session_presentation() = default;
session_presentation::~session_presentation() = default;
session_presentation::session_presentation( session_presentation && ) noexcept = default;
session_presentation &session_presentation::operator=( session_presentation && ) noexcept = default;

void ensure_mp_hud()
{
    // Only create the MP HUD when actually in an active MP session (hosting
    // with a running server, or connected as client).  Creating ui_adaptors in
    // SP mode (when host_mode_ is armed but the server hasn't started yet)
    // interferes with the ImGui render stack and causes assertion failures.
    if( !is_hosting() && !is_client_mode() ) {
        return;
    }
    // Edge frame rendered first so the panel draws on top in the overlap zone.
    if( !mp_session().presentation.mp_edge ) {
        mp_session().presentation.mp_edge = std::make_unique<mp_edge_t>();
        mp_log( "[cdda-mp] HUD: created mp_edge (fresh)" );
    }
    mp_session().presentation.mp_edge->maybe_resize();
    mp_session().presentation.mp_edge->ui.invalidate_ui();
    if( !mp_session().presentation.mp_hud ) {
        mp_session().presentation.mp_hud = std::make_unique<mp_hud_t>();
        mp_log( "[cdda-mp] HUD: created mp_hud (fresh)" );
    }
    mp_session().presentation.mp_hud->ui.invalidate_ui();
}

static std::string json_escape_str( std::string_view s );   // defined below

// Display a chat line locally: push to the overlay above the panel and into the
// main message log (magenta).  Used for both received lines and the local echo.
static void mp_chat_display( const std::string &from, const std::string &text, bool from_host )
{
    // Host messages = light cyan, client messages = light blue, on both ends.
    const nc_color col = from_host ? c_light_cyan : c_light_blue;
    const char *tag = from_host ? "light_cyan" : "light_blue";
    // First name only (matches the status-row name).  "You" has no space so
    // it's left as-is.
    std::string name = from;
    const size_t name_sp = name.find( ' ' );
    if( name_sp != std::string::npos ) {
        name = name.substr( 0, name_sp );
    }
    std::string line = "[" + name + "] " + text;
    // Strip angle brackets so a chat line can't inject color tags into the
    // overlay or the message log (both parse them).
    for( char &c : line ) {
        if( c == '<' || c == '>' ) {
            c = '\'';
        }
    }
    const int prev_count = mp_chat_overlay_count();
    mp_session().presentation.mp_chat_overlay.push_back( { line, col } );
    while( mp_session().presentation.mp_chat_overlay.size() > MP_CHAT_OVERLAY_MAX ) {
        mp_session().presentation.mp_chat_overlay.erase(
            mp_session().presentation.mp_chat_overlay.begin() );
    }
    if( mp_session().presentation.mp_hud ) {
        // Only resize when the visible line count actually changes (0->1->2->3),
        // never per-message once full — repeated resizes churned the panel.
        if( mp_chat_overlay_count() != prev_count ) {
            mp_session().presentation.mp_hud->ui.mark_resize();
        }
        mp_session().presentation.mp_hud->ui.invalidate_ui();
    }
    add_msg( m_info, "%s", "<color_" + std::string( tag ) + ">" + line + "</color>" );
}

// Parse + display an incoming {"type":"chat",...} packet.  Shared by the host
// and client receive paths (2-player: each side just shows what it receives).
static void mp_handle_chat_msg( const std::string &msg )
{
    try {
        JsonValue jv = json_loader::from_string( msg );
        JsonObject jo = jv.get_object();
        jo.allow_omitted_members();
        const std::string from = jo.get_string( "from", "Partner" );
        const std::string text = jo.get_string( "text", std::string() );
        const bool from_host = jo.get_bool( "host", true );
        // Dedup: the partner always has the opposite role.  A received message
        // whose sender-role matches ours is our own echo bouncing back — we
        // already displayed it locally, so drop it.  (2-player assumption.)
        if( from_host == is_hosting() ) {
            return;
        }
        if( !text.empty() ) {
            mp_chat_display( from, text, from_host );
        }
    } catch( const JsonError &e ) {
        mp_log( "[cdda-mp] chat parse error: " + std::string( e.what() ) );
    }
}

// Keybound entry point (ACTION_COOP_CHAT): prompt for a line and send it to the
// partner, then echo it locally.
void mp_open_chat()
{
    mp_log( "[cdda-mp] mp_open_chat: ENTER hosting=" + std::string( is_hosting() ? "1" : "0" ) +
            " remote_connected=" + std::string( !mp_session().remote_players.empty() ? "1" : "0" ) +
            " client_mode=" + std::string( is_client_mode() ? "1" : "0" ) );
    // remote_player_connected is host-side only; on the client, being in client
    // mode means we're joined to a host.  Gate on the correct side.
    const bool partner = is_hosting() ? !mp_session().remote_players.empty() : is_client_mode();
    if( !partner ) {
        add_msg( m_warning, _( "No co-op partner connected." ) );
        return;
    }
    std::string text = string_input_popup()
                       .title( _( "Co-op chat: " ) )
                       .width( 60 )
                       .query_string();
    // Trim surrounding whitespace; ignore empty/cancelled input.
    const size_t a = text.find_first_not_of( " \t" ); // NOLINT(cata-text-style)
    if( a == std::string::npos ) {
        return;
    }
    text = text.substr( a, text.find_last_not_of( " \t" ) - a + 1 ); // NOLINT(cata-text-style)
    if( text.size() > 256 ) {
        text = text.substr( 0, 256 );
    }
    const bool host = is_hosting();
    const std::string from = get_avatar().get_name();
    const std::string js = R"({"type":"chat","from":")" + json_escape_str( from ) +
                           R"(","text":")" + json_escape_str( text ) +
                           R"(","host":)" + ( host ? "true" : "false" ) + "}";
    if( host ) {
        if( auto srv = get_active_server() ) {
            srv->post_broadcast( js + "\n" );
        }
    } else {
        client_send( js );
    }
    mp_chat_display( _( "You" ), text, host );   // local echo — own messages show as "You"
}

void mp_capture_host_omt( const tripoint_abs_omt &p )
{
    mp_session().host_info.host_omt = std::array<int, 3> { p.x(), p.y(), p.z() };
}

bool mp_host_omt_valid()
{
    return mp_session().host_info.host_omt.has_value();
}

tripoint_abs_omt mp_host_omt()
{
    const auto position = mp_session().host_info.host_omt.value_or( std::array<int, 3> {} );
    return tripoint_abs_omt( position[0], position[1], position[2] );
}

tripoint_abs_omt mp_client_spawn_omt()
{
    return mp_session().admission.client_host_spawn_omt;
}

unsigned int mp_host_world_seed()
{
    return mp_session().host_info.seed;
}

void mp_set_host_world_name( const std::string &name )
{
    mp_session().host_info.world_name = name;
}

std::string mp_get_host_world_name()
{
    return mp_session().host_info.world_name;
}

std::string mp_client_host_world_name()
{
    return mp_session().admission.client_host_world_name;
}

void mp_set_client_host_world_name( const std::string &name )
{
    mp_session().admission.client_host_world_name = name;
}

void mp_set_host_player_name( const std::string &name )
{
    mp_session().host_info.player_name = name;
}

std::string mp_get_host_player_name()
{
    return mp_session().host_info.player_name;
}

std::string mp_client_host_player_name()
{
    return mp_session().admission.client_host_player_name;
}

void mp_set_client_host_player_name( const std::string &name )
{
    mp_session().admission.client_host_player_name = name;
}

// Client: adopt the host's seed (received in 'welcome') into local worldgen,
// once, before the host-area overmap is generated. No-op if no seed has been
// received yet or it's already applied. Idempotent + safe to call repeatedly.
static void mp_client_apply_host_seed()
{
    if( mp_session().admission.client_host_seed_applied ||
        mp_session().admission.client_host_seed == 0 ) {
        return;
    }
    const unsigned int before = g->get_seed();
    g->set_seed( mp_session().admission.client_host_seed );
    mp_session().admission.client_host_seed_applied = true;
    mp_log( "[cdda-mp] SEED: client adopted host seed " +
            std::to_string( mp_session().admission.client_host_seed ) + " (was " + std::to_string(
                before ) + ")" );
}

// Client: parse the fields a joining client needs out of a 'welcome' message —
// host world name, host player name, host spawn OMT, and worldgen seed. When
// apply_seed_now is true the seed is adopted immediately (engine seed already
// finalized, e.g. the game-loop replay path); when false the seed value is only
// stored — used at connect time, before start_game()'s rng_bits() runs, with the
// actual adoption deferred to mp_client_prepare_spawn().
static void parse_welcome_fields( const std::string &msg, bool apply_seed_now )
{
    try {
        JsonValue jv = json_loader::from_string( msg );
        JsonObject jo = jv.get_object();
        jo.allow_omitted_members();
        const std::string wn = jo.get_string( "world", "" );
        if( !wn.empty() && wn != "default" ) {
            mp_session().admission.client_host_world_name = wn;
            mp_log( "[cdda-mp] welcome: host world='" + wn + "'" );
        }
        const std::string hn = jo.get_string( "host_name", "" );
        if( !hn.empty() ) {
            mp_set_client_host_player_name( hn );
            mp_log( "[cdda-mp] welcome: host player='" + hn + "'" );
        }
        // The host's OMT — start_game spawns the client here (host's area)
        // instead of its character's scenario start_location.
        if( jo.has_array( "host_omt" ) ) {
            JsonArray ho = jo.get_array( "host_omt" );
            if( ho.size() >= 3 ) {
                mp_session().admission.client_host_spawn_omt = tripoint_abs_omt(
                            ho.get_int( 0 ), ho.get_int( 1 ), ho.get_int( 2 ) );
                mp_log( "[cdda-mp] welcome: host_omt=" + mp_session().admission.client_host_spawn_omt.to_string() );
            }
        }
    } catch( const JsonError & ) {}
    const std::string::size_type spos = msg.find( "\"seed\":" );
    if( spos != std::string::npos ) {
        // Seed is an unsigned int serialized as a bare JSON number.
        const unsigned long parsed = std::strtoul( msg.c_str() + spos + 7, nullptr, 10 );
        mp_session().admission.client_host_seed = static_cast<unsigned int>( parsed );
        mp_log( "[cdda-mp] SEED: welcome " + std::string( apply_seed_now ? "received" : "stored" ) +
                " host seed " + std::to_string( mp_session().admission.client_host_seed ) + " (local was " +
                std::to_string( g->get_seed() ) + ")" );
        if( apply_seed_now ) {
            mp_client_apply_host_seed();
        }
    } else {
        mp_log( "[cdda-mp] SEED: welcome had no seed field" );
    }
}

// Client: stash the join 'welcome' at connect time and pre-parse its fields
// (seed value, spawn OMT, names) WITHOUT applying the seed yet — start_game()
// resets the engine seed via rng_bits(), so adoption is deferred to
// mp_client_prepare_spawn(), called from start_game right after that reset.
void mp_store_pending_welcome( const std::string &msg )
{
    // Validate before replacing a previous admission or replication state.
    JsonValue value = json_loader::from_string( msg );
    JsonObject welcome = value.get_object();
    welcome.allow_omitted_members();
    const world_id host_world( welcome.get_string( "world_id" ) );
    // Called once after a successful connection probe, not for each queued
    // welcome. Never import a previous host's wire IDs or delta baselines.
    mp_session().replication.client = {};
    mp_session().client_feedback_sequence = 0;
    mp_session().admission = {};
    mp_session().admission.host_world = host_world;
    mp_session().admission.pending_welcome = msg;
    parse_welcome_fields( msg, /*apply_seed_now=*/false );
}

// Client: called from game::start_game() right after seed = rng_bits() and
// before the host-area overmap is generated. Adopts the host's stashed seed so
// the client's base terrain matches the host's. The spawn OMT was already set by
// mp_store_pending_welcome() (read via mp_client_spawn_omt()). No-op on the host
// or when no welcome has been stashed.
void mp_client_prepare_spawn()
{
    if( !is_client_mode() || mp_session().admission.pending_welcome.empty() ) {
        return;
    }
    mp_client_apply_host_seed();
}

static std::string json_escape_str( const std::string_view s )
{
    std::string out;
    out.reserve( s.size() );
    for( char c : s ) {
        if( c == '"' )       {
            out += "\\\"";
        } else if( c == '\\' ) {
            out += "\\\\";
        } else if( c == '\n' ) {
            out += "\\n";
        } else if( c == '\r' ) {
            out += "\\r";
        } else if( c == '\t' ) {
            out += "\\t";
        } else                 {
            out += c;
        }
    }
    return out;
}

// ---------------------------------------------------------------------------
// Stale MP NPC cleanup — cross-session
// ---------------------------------------------------------------------------

// Path of the list of MP NPC IDs that were alive when the last session ended.
// Any NPC whose ID is in this file should be removed at startup.
static cata_path mp_npc_cleanup_path()
{
    return PATH_INFO::world_base_save_path() / "mp_npc_cleanup.json";
}

// Write the IDs of all currently-live MP NPCs so the next session can purge them.
// Called whenever we spawn or despawn MP NPCs.
static void mp_save_npc_ids()
{
    if( is_client_mode() ) {
        return;
    }
    std::vector<int> ids;
    std::vector<std::string> names;
    for( const auto &entry : mp_session().remote_players ) {
        cata_mp::remote_player_session &recipient = *entry.second;
        if( recipient.actor.id().is_valid() ) {
            ids.push_back( recipient.actor.id().get_value() );
            npc *rn = mp_remote_actor( recipient );
            if( rn && !rn->name.empty() ) {
                names.push_back( rn->name );
            }
        }
    }
    if( ids.empty() && names.empty() ) {
        remove_file( mp_npc_cleanup_path() );
        return;
    }
    write_to_file( mp_npc_cleanup_path(), [&]( std::ostream & fout ) {
        JsonOut jo( fout );
        jo.start_object();
        jo.member( "ids" );
        jo.start_array();
        for( int id : ids ) {
            jo.write( id );
        }
        jo.end_array();
        jo.member( "names" );
        jo.start_array();
        for( const std::string &nm : names ) {
            jo.write( nm );
        }
        jo.end_array();
        jo.end_object();
    }, "mp npc cleanup list" );
}

static player_store &world_players();

static void release_guest_seat( npc &guest )
{
    if( !guest.in_vehicle ) {
        return;
    }
    map &here = get_map();
    const auto seat = here.veh_at( guest.pos_bub( here ) ).part_with_feature( VPFLAG_BOARDABLE,
                      false );
    if( seat && seat->part().passenger_id == guest.getID() ) {
        here.unboard_vehicle( *seat, &guest );
    }
}

static void mp_cleanup_stale_npcs()
{
    if( mp_session().stale_proxy_cleanup_done ) {
        return;
    }
    mp_session().stale_proxy_cleanup_done = true;
    // Only explicit ownership tags authorize removal, never names or IDs
    // copied from a cleanup file.
    std::vector<character_id> active;
    for( npc &candidate : g->all_npcs() ) {
        if( is_player_proxy( candidate ) ) {
            release_guest_seat( candidate );
            g->remove_npc_follower( candidate.getID() );
            active.push_back( candidate.getID() );
        }
    }
    for( character_id id : active ) {
        g->remove_npc( id );
    }
    std::vector<character_id> stored;
    for( const auto &candidate : overmap_buffer.get_npcs_near_player( 500 ) ) {
        if( candidate && is_player_proxy( *candidate ) ) {
            release_guest_seat( *candidate );
            g->remove_npc_follower( candidate->getID() );
            stored.push_back( candidate->getID() );
        }
    }
    for( character_id id : stored ) {
        overmap_buffer.remove_npc( id );
    }
    if( !active.empty() || !stored.empty() ) {
        g->cleanup_dead();
    }
    remove_file( mp_npc_cleanup_path() );
}

void mp_cleanup_stale_npcs_after_load()
{
    if( is_client_mode() || mp_session().stale_proxy_cleanup_done || !world_generator ||
        !world_generator->active_world ) {
        return;
    }

    const std::string &worldname = world_generator->active_world->world_name;
    if( worldname.empty() || !mp_world_has_history( worldname ) ) {
        // A world with no co-op marker or legacy MP state cannot contain one of
        // our saved proxy NPCs.  Latch the migration for this load without
        // scanning the active NPC list or nearby overmaps.
        mp_session().stale_proxy_cleanup_done = true;
        return;
    }

    // Reserve disconnected players as well, before solo play can allocate a
    // new NPC ID. Corrupt ownership data must be repaired, never overwritten.
    world_players();
    mp_cleanup_stale_npcs();
}

// Client: remove NPCs spawned by the client's own divergent local world — the
// scratch world's random-NPC spawner and local map features (e.g. a refugee
// center's "panicked persons") put NPCs the host's world doesn't have.  In co-op
// the only legitimate NPC on the client is the host's proxy (client_host_npc_id);
// host-world NPCs aren't synced, so every other active NPC is a local phantom.
// Mirrors the monster/vehicle local-cull.  Runs each client drain; the active
// NPC list is tiny so it's cheap.
static void mp_cull_local_npcs()
{
    if( !is_client_mode() ) {
        return;
    }
    const auto is_synced_view = []( const npc & candidate ) {
        if( mp_session().client_host_actor.owns_instance( &candidate, g->npc_lifetimes() ) ) {
            return true;
        }
        for( const auto &entry : mp_session().client_player_views ) {
            if( entry.second && entry.second->actor.owns_instance( &candidate, g->npc_lifetimes() ) ) {
                return true;
            }
        }
        for( const auto &entry : mp_session().client_npc_views ) {
            if( entry.second && entry.second->actor.owns_instance( &candidate, g->npc_lifetimes() ) ) {
                return true;
            }
        }
        return false;
    };
    std::vector<character_id> to_remove;
    for( npc &n : g->all_npcs() ) {
        if( is_synced_view( n ) ) {
            continue;
        }
        to_remove.push_back( n.getID() );
    }
    for( const character_id &id : to_remove ) {
        if( const npc *n = g->critter_by_id<npc>( id ) ) {
            mp_log( "[cdda-mp] CLI-NPC-CULL-LOCAL: id=" +
                    std::to_string( id.get_value() ) + " name=\"" + n->name + "\"" );
        }
        g->remove_npc( id );             // active (loaded) copy
        overmap_buffer.remove_npc( id ); // overmap copy, so it can't re-load
    }
    if( !to_remove.empty() ) {
        g->cleanup_dead();
    }
}

// End the live transport before releasing a world, including menu return,
// rollback and application shutdown. Calls after normal save/quit are harmless.
void mp_on_world_exit()
{
    g_pending_host_start.reset();
    if( get_avatar().has_guest_map_memory() ) {
        if( !get_avatar().save_map_memory() ) {
            mp_log_client( "Could not save this player's map memory before disconnect" );
        }
    }
    get_avatar().use_local_map_memory();
    // One owner stops/joins producers before discarding simulation and UI state.
    mp_session().reset();
}

player_id partner_identity( character_id actor )
{
    if( actor == get_avatar().getID() ) {
        return get_avatar().get_player_id();
    }
    if( is_client_mode() ) {
        if( actor == mp_session().client_host_actor.id() ) {
            return mp_session().client_host_player_id;
        }
        for( const auto &entry : mp_session().client_player_views ) {
            if( entry.second->actor.id() == actor ) {
                return entry.first;
            }
        }
    } else if( const auto *recipient = mp_session().find_remote( actor ) ) {
        return recipient->credentials.id;
    }
    return {};
}

// A helper keeps its chosen identity even when another player moves closer.
static std::string activity_help_target( const player_activity &activity )
{
    return activity.id().str() == "ACT_HELP_PARTNER" && !activity.str_values.empty() ?
           activity.str_values.front() : std::string();
}

static npc *helped_partner( const player_activity &activity )
{
    const std::string target = activity_help_target( activity );
    if( target.empty() ) {
        return nullptr;
    }
    if( is_client_mode() ) {
        if( mp_session().client_host_player_id.str() == target ) {
            return mp_host_view_actor();
        }
        for( const auto &entry : mp_session().client_player_views ) {
            if( entry.first.str() == target ) {
                return mp_loaded_actor( entry.second->actor );
            }
        }
    } else {
        for( const auto &entry : mp_session().remote_players ) {
            cata_mp::remote_player_session const &peer = *entry.second;
            if( peer.connected && !peer.detach_pending && peer.credentials.id.str() == target ) {
                return mp_remote_actor( *entry.second );
            }
        }
    }
    return nullptr;
}

std::string client_partner_action( const std::string &action, character_id target )
{
    std::ostringstream encoded;
    JsonOut out( encoded );
    out.start_object();
    out.member( "type", "action" );
    out.member( "action", action );
    out.member( "target_player", partner_identity( target ).str() );
    out.end_object();
    return client_enrich_action( encoded.str() );
}

static void release_remote_player( remote_player_session &recipient );

static player_store &world_players()
{
    if( !mp_session().players ) {
        auto players = std::make_unique<player_store>( PATH_INFO::world_base_save_path() );
        for( character_id id : players->actor_ids() ) {
            g->observe_npc_id( id );
        }
        mp_session().players = std::move( players );
    }
    return *mp_session().players;
}

static std::string serialize_player( const npc &remote )
{
    std::ostringstream output;
    JsonOut json( output );
    remote.serialize( json );
    return output.str();
}

static bool save_remote_player( remote_player_session &recipient )
{
    if( !recipient.connected || recipient.awaiting_character ) {
        return true;
    }
    const npc *remote = recipient.actor.retained( g->npc_lifetimes() );
    if( !remote ) {
        return false;
    }
    try {
        world_players().save( recipient.credentials, serialize_player( *remote ) );
        return true;
    } catch( const std::exception & ) {
        // A malformed record may contain private credentials in its parser
        // excerpt. Keep the on-screen failure actionable without exposing it.
        add_msg( m_bad,
                 _( "Could not save the multiplayer character.  Keep the world open and check the save directory." ) );
        return false;
    }
}


bool mp_save_remote_player()
{
    bool saved = true;
    for( auto it = mp_session().remote_players.begin(); it != mp_session().remote_players.end(); ) {
        cata_mp::remote_player_session &recipient = *it++->second;
        // Successful retry may release a disconnected actor and erase its entry.
        if( !save_remote_player( recipient ) ) {
            saved = false;
        } else if( recipient.detach_pending ) {
            release_remote_player( recipient );
        }
    }
    return saved;
}
static std::optional<std::string> restore_player( const player_credentials &player )
{
    player_store &store = world_players();
    auto saved = store.load( player );
    const auto legacy = saved ? std::vector<cata_path>() : store.legacy_records();
    if( !legacy.empty() ) {
        uilist choice;
        choice.title = _( "Associate an old multiplayer character" );
        choice.text =
            _( "This profile has no character in this world.  Only choose an old save if it belongs to this player.  Original files will be kept." );
        choice.entries.emplace_back( 0, true, 'n', _( "Create a new character" ) );
        for( size_t i = 0; i < legacy.size(); ++i ) {
            choice.entries.emplace_back( i + 1, true, -1,
                                         legacy[i].get_relative_path().filename().u8string() );
        }
        choice.query();
        if( choice.ret < 0 ) {
            throw std::runtime_error( "Host cancelled legacy association" );
        }
        if( choice.ret > 0 && static_cast<size_t>( choice.ret ) <= legacy.size() ) {
            const auto &source = legacy[choice.ret - 1];
            const JsonObject legacy_json = json_loader::from_path( source ).get_object();
            legacy_json.allow_omitted_members();
            const character_id id( legacy_json.get_int( "id" ) );
            if( id == get_avatar().getID() || g->critter_by_id<npc>( id ) ||
                overmap_buffer.find_npc( id ) ) {
                throw std::runtime_error( "Legacy actor ID is still occupied; association refused" );
            }
            store.import_legacy( player, source );
            saved = store.load( player );
        }
    }
    return saved;
}

static bool guest_spawn_tile_is_free( const map &here, const tripoint_abs_ms &pos )
{
    const tripoint_bub_ms local = here.get_bub( pos );
    return here.has_loaded_submap( local ) && !here.impassable( local ) &&
           here.has_floor_or_water( local ) && !get_creature_tracker().creature_at<Creature>( pos );
}

static std::optional<tripoint_abs_ms> find_guest_spawn( const map &here,
        const tripoint_abs_ms &host_pos, const std::optional<tripoint_abs_ms> &saved_pos )
{
    if( saved_pos && guest_spawn_tile_is_free( here, *saved_pos ) ) {
        return saved_pos;
    }

    for( int radius = 1; radius <= 20; ++radius ) {
        for( int dy = -radius; dy <= radius; ++dy ) {
            for( int dx = -radius; dx <= radius; ++dx ) {
                if( std::abs( dx ) != radius && std::abs( dy ) != radius ) {
                    continue;
                }
                const tripoint_abs_ms candidate = host_pos + tripoint( dx, dy, 0 );
                if( guest_spawn_tile_is_free( here, candidate ) ) {
                    return candidate;
                }
            }
        }
    }
    return std::nullopt;
}

static void spawn_remote_player( const std::string &name, const peer_admission &admission,
                                 const player_credentials &player, const JsonObject *initial = nullptr )
{
    if( mp_session().remote_players.count( admission.peer_id() ) != 0 ) {
        throw std::runtime_error( "A live or unsaved multiplayer actor already owns this slot" );
    }
    // Legacy association can write a record while restoring. Refuse a player
    // already owned by this world before any such side effect or prompt.
    if( g->player_controls().is_reserved( player.id ) ) {
        throw std::runtime_error( "Player already has a controller in this world" );
    }
    for( const auto &entry : mp_session().remote_players ) {
        if( entry.second->credentials.id == player.id ) {
            throw std::runtime_error( "Player already has a pending admission" );
        }
    }
    const auto saved = restore_player( player );
    auto pending = std::make_unique<remote_player_session>();
    cata_mp::remote_player_session &recipient = *pending;
    recipient.admission = admission;
    recipient.credentials = player;
    if( !saved && !initial ) {
        // No actor is published, advanced or saved until its complete initial
        // state arrives. A disconnect here leaves no blank character record.
        recipient.connected = true;
        recipient.awaiting_character = true;
        recipient.turn.client_acted_this_turn = true;
        recipient.observation.partner_name_cached = name;
        mp_session().remote_players.emplace( admission.peer_id(), std::move( pending ) );
        if( const auto server = get_active_server() ) {
            server->post_send( admission, "{\"type\":\"player_create_request\"}\n" );
        }
        return;
    }

    avatar &u = get_avatar();
    map &primary = reality_bubble();

    shared_ptr_fast<npc> remote = make_shared_fast<npc>();
    bool saved_in_current_dimension = false;

    if( saved ) {
        const JsonObject record = json_loader::from_string( *saved ).get_object();
        remote->deserialize( record );
        const std::string dimension = remote->get_value( "mp_saved_dimension" ).str();
        saved_in_current_dimension = dimension.empty() || dimension == g->get_dimension_prefix().str();
        if( remote->is_dead_state() || !remote->getID().is_valid() || remote->getID() == u.getID() ||
            overmap_buffer.find_npc( remote->getID() ) || g->critter_by_id<npc>( remote->getID() ) ) {
            throw std::runtime_error( "Saved multiplayer actor ID is already in use" );
        }
        g->observe_npc_id( remote->getID() );
        mp_log( "[ccb-mp] restored persistent actor=" + std::to_string( remote->getID().get_value() ) );
    } else {
        remote->normalize();
        remote->load_player_state( *initial );
        if( remote->is_dead_state() || remote->name.empty() ) {
            throw std::runtime_error( "Initial player character is dead or unnamed" );
        }
    }
    recipient.player_state_initialized = true;
    // Cache the partner's name so the Co-op panel has a stable fallback even
    // if the NPC pointer briefly becomes unresolvable (load/unload races).
    recipient.observation.partner_name_cached = remote->name;

    map *spawn_map = &primary;
    bool created_region = false;
    bool published = false;
    const on_out_of_scope retire_failed_region( [&]() {
        if( created_region && !published ) {
            try {
                mp_session().retire_region( primary, player.id );
                g->unload_creatures_outside_resident_maps();
            } catch( const std::exception &error ) {
                mp_log_host( std::string( "[ccb-mp] could not retire failed guest region: " ) + error.what() );
            }
        }
    } );
    std::optional<tripoint_abs_ms> spawn_pos;
    if( saved_in_current_dimension && primary.inbounds_z( remote->posz() ) ) {
        const tripoint_abs_ms saved_pos = remote->pos_abs();
        if( is_hosting() && !primary.has_loaded_submap( remote->pos_abs_sm() ) ) {
            created_region = !mp_session().find_region( player.id );
            spawn_map = mp_session().load_region( *g, primary, player.id, remote->pos_abs_sm() ).terrain.get();
            const swap_map context( *spawn_map );
            g->load_npcs( spawn_map );
        }
        spawn_pos = find_guest_spawn( *spawn_map, saved_pos, saved_pos );
    }
    if( !spawn_pos ) {
        if( created_region ) {
            mp_session().retire_region( primary, player.id );
            g->unload_creatures_outside_resident_maps();
            created_region = false;
        }
        spawn_map = &primary;
        spawn_pos = find_guest_spawn( primary, u.pos_abs(), std::nullopt );
    }
    if( !spawn_pos ) {
        throw std::runtime_error( "No free spawn tile near the host" );
    }

    // Ensure the NPC has a valid character_id before inserting into the world.
    // make_shared_fast<npc>() + normalize() never calls setID(), so we must
    // assign one explicitly here. Loaded NPCs may already have a valid id from
    // their save file; assign_npc_id() is safe to call regardless.
    if( !remote->getID().is_valid() ) {
        remote->setID( g->assign_npc_id() );
    }
    remote->in_vehicle = false;
    remote->controlling_vehicle = false;
    remote->spawn_at_precise( *spawn_pos );

    // Commit the identity/actor binding before inserting the live proxy. An I/O
    // failure rejects the join instead of creating an unpersisted character.
    // Reserve control before publishing or saving the actor. A duplicate local
    // or remote player cannot acquire a second character through admission.
    // The world advances the admitted player's native body/effect/AP phases;
    // commands supply actions, while the NPC representation never runs AI.
    player_control control = g->player_controls().claim( player.id, *remote );
    remote->set_value( "mp_player_id", player.id.str() );
    remote->set_value( "mp_proxy", std::string( "1" ) );
    remote->set_value( "mp_saved_dimension", g->get_dimension_prefix().str() );
    recipient.credentials = player;

    const on_out_of_scope rollback( [&]() {
        if( !published ) {
            if( g->shared_from( *remote ) ) {
                g->remove_npc( remote->getID() );
            }
            if( overmap_buffer.find_npc( remote->getID() ).get() == remote.get() ) {
                overmap_buffer.remove_npc( remote->getID() );
            }
        }
    } );
    overmap_buffer.insert_npc( remote );
    g->load_npcs( spawn_map );
    if( !g->shared_from( *remote ) ) {
        throw std::runtime_error( "Could not activate the multiplayer actor at its selected tile" );
    }

    recipient.actor.bind_player( *remote, player.id, g->npc_lifetimes(),
                                 std::move( control ) );
    world_players().save( player, serialize_player( *remote ) );
    mp_log( "[cdda-mp] spawn: remote_player_npc_id=" +
            std::to_string( recipient.actor.id().get_value() ) +
            " valid=" + std::to_string( recipient.actor.id().is_valid() ) +
            " tagged mp_proxy=1" );

    // Co-op partner: apply ally status AFTER load_npcs so the NPC pointer is
    // fully wired into the game state (faction manager, critter tracker, etc.).
    npc *rn = mp_remote_actor( recipient );
    if( rn ) {
        rn->set_attitude( NPCATT_FOLLOW );
        rn->set_fac( faction_id( "your_followers" ) );
        rn->chatbin.first_topic = "TALK_FRIEND";
        rn->op_of_u.trust = 10;
        rn->op_of_u.value = 10;
        g->add_npc_follower( rn->getID() );
    }
    recipient.admission = admission;
    recipient.connected = true;
    recipient.turn.grant_seq = ++mp_session().grant_sequence;
    mp_session().remote_players.emplace( admission.peer_id(), std::move( pending ) );
    published = true;
    if( spawn_map != &primary ) {
        const map_simulation_regions regions = mp_session().simulation_regions( primary );
        const swap_map context( *spawn_map );
        spawn_map->spawn_monsters( true, true, &regions );
    }
    recipient.turn.remote_moves = rn ? rn->get_speed() : 100;  // grant first turn immediately
    recipient.turn.client_acted_this_turn = false;
    recipient.turn.last_forwarded_msg_count =
        Messages::size();  // don't forward pre-connect history
    mp_save_npc_ids();  // persist ID so next session can clean it up

    add_msg( m_good, _( "%s has connected and joined the game." ), remote->name );
    // Establish the authoritative body and inventory before queued legacy
    // uploads can run. Existing records retain their saved state, including
    // records made before full character bootstrap was implemented.
    const std::string resumed = rn ? make_player_resume_result( *rn, recipient.pickup ) : "";
    auto srv = get_active_server();
    if( srv ) {
        const std::string terrain = build_map_sync( recipient, true );
        if( !terrain.empty() ) {
            srv->post_send( recipient.admission, terrain + "\n" );
        }
        if( !resumed.empty() ) {
            srv->post_send( recipient.admission, resumed + "\n" );
        }
        srv->post_send( recipient.admission, serialize_remote_player_state( recipient ) + "\n" );
    }

    // Templates wire-sync: send host's local template list so the client can
    // request any it doesn't already have.  Cheap one-shot exchange — the
    // client sends its own list independently on its side.
    mp_templates_sync_on_join( admission );
}

static void release_remote_player( remote_player_session &recipient )
{
    if( !recipient.connected ) {
        return;
    }
    npc *remote = mp_remote_actor( recipient );
    if( remote ) {
        const swap_map context( remote_actor_map( recipient, *remote ) );
        release_guest_seat( *remote );
        g->remove_npc_follower( remote->getID() );
        // Clean despawn — the partner quit/disconnected, they are NOT dead.
        // die() drops a corpse carrying all their gear (a pickup-able loot dupe).
        g->remove_npc( recipient.actor.id() );
    }
    // Remove from overmap buffer so the NPC doesn't get written back into the
    // world save, which would cause a stale NPC to appear on next load.
    // Guard with find_npc(): the proxy is normally an in-bubble ACTIVE npc
    // (already despawned by g->remove_npc above) and was never registered as an
    // overmap NPC, so an unconditional remove_npc() hits its internal "NPC not
    // found" debugmsg — a BLOCKING modal popup on the host EVERY time the client
    // disconnects ("client quit drags the host down", 2026-06-21). find_npc()
    // returns null without complaint, so we only remove when it's actually there.
    const auto retained = overmap_buffer.find_npc( recipient.actor.id() );
    if( recipient.actor.owns_instance( retained.get(), g->npc_lifetimes() ) ) {
        overmap_buffer.remove_npc( recipient.actor.id() );
    }

    recipient.connected = false;
    recipient.admission = {};
    recipient.credentials = {};
    recipient.detach_pending = false;
    recipient.actor.reset();
    recipient.turn.proxy_was_alive = false;
    // Do NOT reset g_grant_seq here.  It must stay monotonically increasing so
    // that a reconnecting client (which resets g_client_last_grant_seq=0 via the
    // join path) always sees seq > 0 and accepts the first new grant.  Resetting
    // to 0 here caused a deadlock: client last_seq=N, server restarts at seq=1..N
    // which were all skipped as "old seq".
    for( auto it = mp_session().remote_players.begin(); it != mp_session().remote_players.end();
         ++it ) {
        if( it->second.get() == &recipient ) {
            mp_session().remote_players.erase( it );
            break;
        }
    }
    mp_save_npc_ids();
    mp_cancel_help_if_partner_done();
    add_msg( m_bad, _( "The other player has disconnected." ) );
    std::cout << "[cdda-mp] Remote player removed from world." << std::endl;
}

static void remove_remote_player( remote_player_session &recipient )
{
    if( !recipient.connected ) {
        return;
    }
    if( !save_remote_player( recipient ) ) {
        // Retain ownership and freeze NPC AI until an explicit world-save retry
        // succeeds. The departed peer must no longer receive turns or actions.
        recipient.admission = {};
        recipient.detach_pending = true;
        return;
    }
    release_remote_player( recipient );
}

// After substituting an NPC name → "You", the verb is still third-person singular.
// Strip the suffix so "You guts" → "You gut", "You misses" → "You miss", etc.
// Also fixes "You's " → "your " for possessive constructions.
// Rewrite a first-person message ("You drop your hand mirror on the grass.")
// into a third-person version with the subject's name and proper conjugation
// ("Wilford Rubin drops Wilford Rubin's hand mirror on the grass.").
//
// Handles three substitutions and one conjugation pass:
//   1. Leading "You " → "<name> " + s/-verb conjugation
//   2. Mid-string " you " → " <name> "  (any case)
//   3. Possessives "your "/"Your "/"yours" → "<name>'s " / "<name>'s"
//   4. Reflexive "yourself" → "themself"
//
// Use this any time the host's own avatar messages need to be presented to
// the OTHER player from a third-person view — typically when forwarding the
// host's "You X" messages to the client.  Without the possessive pass, the
// client sees "FrozenFoxy drops your X" which reads as "the host dropped
// MY (client's) X" — semantically wrong.
static void mp_rewrite_first_to_third( std::string &s, const std::string &subject )
{
    if( subject.empty() ) {
        return;
    }
    const std::string possessive = subject + "'s";

    auto replace_all = []( std::string & dst, const std::string & from, const std::string & to ) {
        if( from.empty() ) {
            return;
        }
        size_t p = 0;
        while( ( p = dst.find( from, p ) ) != std::string::npos ) {
            dst.replace( p, from.size(), to );
            p += to.size();
        }
    };

    // Possessives first — "your" before "you" so a later " you " sub doesn't
    // chew the start of "your".
    replace_all( s, " your ", " " + possessive + " " );
    replace_all( s, " Your ", " " + possessive + " " );
    replace_all( s, " yours ", " " + possessive + " " );
    replace_all( s, " yourself ", " themself " );
    if( s.size() >= 5 && s.compare( 0, 5, "Your " ) == 0 ) {
        s.replace( 0, 4, possessive );
    }

    // Mid-string "you" (lowercase, e.g., "the can hit you in the head") becomes
    // the subject name.
    replace_all( s, " you ", " " + subject + " " );

    // Leading "You " — handled last so the verb conjugation pass below can
    // assume the subject already sits at position 0.
    if( s.size() >= 4 && s.compare( 0, 4, "You " ) == 0 ) {
        s.replace( 0, 3, subject );
        // Now conjugate the verb that follows (e.g., "drop" → "drops").
        const size_t vs = subject.size() + 1; // skip "<name> "
        size_t ve = s.find( ' ', vs );
        if( ve == std::string::npos ) {
            ve = s.size();
        }
        if( ve > vs + 1 ) {
            const std::string v = s.substr( vs, ve - vs );
            std::string fixed;
            // Irregular verbs (second-person plural → third-person singular).
            // Must run before the generic "add s" rule below, otherwise
            // "have" → "haves", "do" → "dos", "are" → "ares".
            static const std::vector<std::pair<std::string, std::string>> irregulars = {
                { "have", "has" }, { "do", "does" }, { "are", "is" }, { "were", "was" },
                { "go", "goes" }, { "say", "says" }, { "Have", "has" }, { "Do", "does" },
                { "Are", "is" }, { "Were", "was" },
            };
            bool matched = false;
            for( const auto &p : irregulars ) {
                if( v == p.first ) {
                    fixed = p.second;
                    matched = true;
                    break;
                }
            }
            auto ends_with = [&]( const char *suf, size_t n ) {
                return v.size() >= n && v.compare( v.size() - n, n, suf ) == 0;
            };
            if( !matched ) {
                if( ends_with( "y", 1 ) && v.size() > 1 ) {
                    // try → tries (but not "stay" → "stays" — vowel before 'y' keeps it)
                    const char before_y = v[v.size() - 2];
                    const bool vowel_before_y = before_y == 'a' || before_y == 'e' ||
                                                before_y == 'i' || before_y == 'o' || before_y == 'u';
                    fixed = vowel_before_y ? v + "s" : v.substr( 0, v.size() - 1 ) + "ies";
                } else if( ends_with( "s", 1 ) || ends_with( "x", 1 ) || ends_with( "z", 1 ) ||
                           ends_with( "ch", 2 ) || ends_with( "sh", 2 ) ) {
                    fixed = v + "es";
                } else {
                    fixed = v + "s";
                }
            }
            s.replace( vs, ve - vs, fixed );
        }
    }
}

static void fix_you_verb( std::string &s )
{
    for( size_t p = 0; ( p = s.find( "You's ", p ) ) != std::string::npos; ) {
        s.replace( p, 6, "your " );
    }

    if( s.rfind( "You ", 0 ) != 0 ) {
        return;
    }

    const size_t vs = 4;
    size_t ve = s.find( ' ', vs );
    if( ve == std::string::npos ) {
        ve = s.size();
    }
    if( ve <= vs + 1 ) {
        return;
    }

    const std::string v = s.substr( vs, ve - vs );
    std::string fixed;

    // Irregular verbs (third-person singular → second-person plural).  These
    // must be handled before the generic "trim trailing s" rule, otherwise
    // "has" → "ha", "does" → "doe", "is" → "i".
    static const std::vector<std::pair<std::string, std::string>> irregulars = {
        { "has", "have" }, { "does", "do" }, { "is", "are" }, { "was", "were" },
        { "goes", "go" }, { "says", "say" }, { "Has", "have" }, { "Does", "do" },
        { "Is", "are" }, { "Was", "were" },
    };
    bool matched = false;
    for( const auto &p : irregulars ) {
        if( v == p.first ) {
            fixed = p.second;
            matched = true;
            break;
        }
    }
    auto ends_with = [&]( const char *suffix, size_t n ) {
        return v.size() >= n && v.compare( v.size() - n, n, suffix ) == 0;
    };
    if( !matched ) {
        if( ends_with( "ies", 3 ) ) {
            fixed = v.substr( 0, v.size() - 3 ) + "y";
        } else if( ends_with( "sses", 4 ) || ends_with( "xes", 3 ) || ends_with( "zes", 3 ) ||
                   ends_with( "ches", 4 ) || ends_with( "shes", 4 ) ) {
            fixed = v.substr( 0, v.size() - 2 );
        } else if( v.size() > 1 && v.back() == 's' ) {
            fixed = v.substr( 0, v.size() - 1 );
        } else {
            return;
        }
    }

    s.replace( vs, ve - vs, fixed );
}

// Collect messages generated from pre_msg onward, apply NPC→"You" substitution,
// and append them to g_action_msgs_pending for inclusion in the next broadcast.
// Messages starting with "You " that don't contain the NPC name are host-avatar
// messages that have no meaning on the client — they are skipped.
static void flush_action_msgs( remote_player_session &recipient,  unsigned long long pre_msg,
                               const std::string &npc_name )
{
    const unsigned long long cur = Messages::size();
    if( cur <= pre_msg ) {
        return;
    }
    const size_t count = static_cast<size_t>( cur - pre_msg );
    recipient.turn.last_forwarded_msg_count = cur;  // advance watermark to avoid double-forward
    const auto new_msgs = Messages::recent_messages_for_player( count, recipient.credentials.id );
    for( const auto &[time_str, text] : new_msgs ) {
        ( void )time_str;
        // Partner swap/push/tap/join messages are host-POV (either the host's
        // own actor line "You swap places with <proxy>", or the handler's
        // observer line "<proxy> pushes you out of the way", or the join
        // announcement).  Forwarding them through the proxy-name→"You"
        // substitution below produces garbage ("You swap places with You",
        // "You pushes you out of the way").  The client renders all of these
        // locally — its own actor line for client-initiated actions, or a
        // semantic flag (partner_swapped / partner_pushed) for host-initiated
        // ones — so none of them may be forwarded here.
        if( text.find( "places with" ) != std::string::npos ||   // "swap/swaps places with"
            text.find( "pushes you out of the way" ) != std::string::npos ||
            text.rfind( "You push ", 0 ) == 0 ||
            text.find( "tries to push you" ) != std::string::npos ||
            text.find( "moves out of the way" ) != std::string::npos ||
            text.find( "has nowhere to go" ) != std::string::npos ||
            text.find( "taps you on the shoulder" ) != std::string::npos ||
            text.rfind( "You tap ", 0 ) == 0 ||
            text.find( "has connected and joined" ) != std::string::npos ) {
            continue;
        }
        // Substitute NPC name → "You" so client sees first-person messages.
        // Do NOT filter "You ..." messages here — bash/smash/interact success
        // messages are generated by map code without NPC name and must reach
        // the client.  Between-action messages (in serialize_remote_player_state)
        // are NPC-name-filtered separately.
        std::string out = text;
        if( !npc_name.empty() ) {
            // Resolve <npcname> placeholder used by melee/combat message generators
            // (e.g. player_hit_message stores "<npcname> hits X" not the real name).
            // Expand it to the real name first so the name→"You" pass below catches it.
            size_t q = 0;
            while( ( q = out.find( "<npcname>", q ) ) != std::string::npos ) {
                out.replace( q, 9, npc_name );
                q += npc_name.size();
            }
            bool did_sub = false;
            size_t p = 0;
            while( ( p = out.find( npc_name, p ) ) != std::string::npos ) {
                out.replace( p, npc_name.size(), "You" );
                p += 3;
                did_sub = true;
            }
            if( did_sub ) {
                fix_you_verb( out );
            }
        }
        mp_log( "[cdda-mp] flush_action_msgs queued: " + out );
        recipient.turn.action_msgs_pending.push_back( out );
    }
}

// Capture messages the avatar generated since pre_msg and queue them for the client,
// replacing "You" with the host character's name so the client sees attributed hits.
// Called from do_turn after each avatar handle_action() when a remote player is connected.
// Capture ALL messages generated during vehmove() and queue them for the remote
// client as their own messages (no attribution — the driver sees these directly).
void host_capture_vehmove_msgs( unsigned long long pre_msg )
{
    if( !is_hosting() || mp_session().remote_players.empty() ) {
        return;
    }
    const unsigned long long cur = Messages::size();
    mp_log( "[veh-move] host_capture_vehmove_msgs: pre=" + std::to_string( pre_msg ) +
            " cur=" + std::to_string( cur ) +
            " delta=" + std::to_string( cur > pre_msg ? cur - pre_msg : 0 ) );
    if( cur <= pre_msg ) {
        return;
    }
    for( const auto &entry : mp_session().remote_players ) {
        cata_mp::remote_player_session &recipient = *entry.second;
        const npc *actor = mp_remote_actor( recipient );
        if( actor && actor->controlling_vehicle ) {
            for( const auto &message : Messages::recent_messages_for_player(
                     static_cast<size_t>( cur - pre_msg ), recipient.credentials.id ) ) {
                recipient.turn.action_msgs_pending.push_back( message.second );
            }
        }
    }
}

void host_broadcast_vehicle_step()
{
    if( !is_hosting() || mp_session().remote_players.empty() ) {
        return;
    }
    auto srv = get_active_server();
    if( !srv ) {
        return;
    }
    map &vmap = get_map();
    std::string vehicles_json = "[";
    bool vfirst = true;
    for( const wrapped_vehicle &wv : vmap.get_vehicles() ) {
        vehicle *v = wv.v;
        if( !v ) {
            continue;
        }
        v->ensure_uid();
        const uint32_t nid = mp_session().replication.entity_ids.assign( *v );
        const tripoint_abs_ms vabs = v->pos_abs();
        const int face_deg     = static_cast<int>( std::lround( to_degrees( v->face.dir() ) ) );
        const int turn_dir_deg = static_cast<int>( std::lround( to_degrees( v->turn_dir ) ) );
        if( !vfirst ) {
            vehicles_json += ',';
        }
        vfirst = false;
        vehicles_json += "{\"nid\":" + std::to_string( nid )
                             + ",\"uid\":" + std::to_string( v->uid().get_value() )
                         + ",\"x\":" + std::to_string( vabs.x() )
                         + ",\"y\":" + std::to_string( vabs.y() )
                         + ",\"z\":" + std::to_string( vabs.z() )
                         + ",\"face\":" + std::to_string( face_deg )
                         + ",\"turn_dir\":" + std::to_string( turn_dir_deg )
                         + ",\"vel\":" + std::to_string( v->velocity )
                         + ",\"cruise\":" + std::to_string( v->cruise_velocity ) + "}";
    }
    vehicles_json += "]";
    // Suppress identical back-to-back broadcasts.  vehproceed() fires this hook
    // once per call even for stationary vehicles whose of_turn is being touched
    // by act_on_map(), which floods the client with dozens of duplicate packets
    // per host turn and stretches the grant→ack cycle to ~500ms.  Same
    // baseline-diff pattern as the cargo broadcast.
    for( const auto &entry : mp_session().remote_players ) {
        cata_mp::remote_player_session &recipient = *entry.second;
        if( !recipient.connected || recipient.detach_pending ||
            ( mp_session().has_regions() && &recipient_map( recipient ) != &vmap ) ||
            vehicles_json == recipient.replication.last_vehicle_step_payload ) {
            continue;
        }
        recipient.replication.last_vehicle_step_payload = vehicles_json;
        srv->post_send( recipient.admission,
                        R"({"type":"vehicle_step","vehicles":)" + vehicles_json + "}\n" );
    }
}
// A relayed line is shown to the PARTNER, so a mention of the partner by name
// should read as "you" to them (host's "Niesha swaps places with player2" →
// client sees "Niesha swaps places with you").  Guarded against the same-name
// case: if the partner's cached name equals the local player's own name (e.g.
// both picked the same preset), we can't disambiguate, so leave names rather
// than collapse to "you swaps places with you".  own_name is the local avatar.
static void mp_addressee_to_you( std::string &s, const std::string &own_name,
                                 const std::string &name )
{
    if( name.empty() || name == own_name ) {
        return;
    }
    size_t p = 0;
    while( ( p = s.find( name, p ) ) != std::string::npos ) {
        const std::string repl = ( p == 0 ) ? "You" : "you";
        s.replace( p, name.size(), repl );
        p += repl.size();
    }
}

void host_capture_avatar_msgs( unsigned long long pre_msg )
{
    if( !is_hosting() || mp_session().remote_players.empty() ) {
        return;
    }
    const unsigned long long cur = Messages::size();
    if( cur <= pre_msg ) {
        return;
    }
    const std::string host_name = get_avatar().name;
    for( const auto &entry : mp_session().remote_players ) {
        cata_mp::remote_player_session &recipient = *entry.second;
        const auto new_msgs = Messages::recent_messages_for_player(
                                  static_cast<size_t>( cur - pre_msg ), recipient.credentials.id );
        for( const auto &[time_str, text] : new_msgs ) {
            ( void )time_str;
            // Only forward messages that look like avatar combat ("You " prefix).
            // Inventory, UI, and ambient messages are excluded.
            if( text.rfind( "You ", 0 ) != 0 ) {
                continue;
            }
            // Swap/push are delivered to the client as semantic flags
            // (partner_swapped / partner_pushed) and rendered there locally; never
            // relay their rendered text (that path produced "you pushes you").
            if( text.find( "swap places" ) != std::string::npos ||
                text.rfind( "You push ", 0 ) == 0 ) {
                continue;
            }
            std::string out = text;
            // Convert first-person to third-person properly: subject substitution,
            // verb conjugation ("drop" → "drops"), AND possessive substitution
            // ("your X" → "<name>'s X").  Without the possessive pass the client
            // sees "<host> drops your X" and reads "your" as referring to itself
            // — wrong subject.
            mp_rewrite_first_to_third( out, host_name );
            std::string addressed = out;
            mp_addressee_to_you( addressed, host_name, recipient.observation.partner_name_cached );
            recipient.turn.host_action_msgs_pending.push_back( std::move( addressed ) );
        }
    }
}

void host_broadcast_post_action()
{
    if( const auto srv = get_active_server() ) {
        for( const auto &entry : mp_session().remote_players ) {
            cata_mp::remote_player_session &recipient = *entry.second;
            if( recipient.connected && !recipient.detach_pending ) {
                if( mp_session().has_regions() ) {
                    const std::string terrain = build_map_sync( recipient );
                    if( !terrain.empty() ) {
                        srv->post_send( recipient.admission, terrain + "\n" );
                    }
                }
                srv->post_send( recipient.admission, serialize_remote_player_state( recipient ) + "\n" );
            }
        }
    }
}

static void send_inventory_activity_observers( const remote_player_session &initiator )
{
    if( const auto server = get_active_server() ) {
        const auto *patient = mp_session().find_remote( initiator.inventory_activity.healing_patient );
        for( const auto &entry : mp_session().remote_players ) {
            cata_mp::remote_player_session &observer = *entry.second;
            if( &observer != &initiator && observer.connected && !observer.detach_pending &&
                ( initiator.inventory_activity.refresh_observers || &observer == patient ) ) {
                server->post_send( observer.admission, serialize_remote_player_state( observer,
                                   initiator.inventory_activity.changed_tiles ) + "\n" );
            }
        }
    }
}

// Standard turn-ending broadcast for handlers in handle_remote_action.
//
// All actions that consume the client's full turn budget MUST end with this
// (or the explicit equivalent): zero g_remote_moves, set the acted flag, log
// SRV-ACK with the current grant_seq, and broadcast the new state so the
// client receives a moves=0 ack and clears its ack-guard.
//
// The earlier "g_remote_moves -= remote->get_speed()" pattern relied on speed
// equalling the grant amount; that's true today but fragile (encumbrance,
// effects, mutations can change speed mid-turn).  Setting moves to exactly 0
// removes the coupling entirely.  push_partner's "-= 20" was the canary that
// exposed the latent bug: subtracting less than the grant left moves > 0 and
// the client interpreted the broadcast as a new grant instead of an ack-clear,
// wedging lockstep.
static void srv_emit_ack( remote_player_session &recipient,  const char *action_name )
{
    recipient.turn.client_acted_this_turn = true;
    recipient.turn.remote_moves = 0;
    mp_log( std::string( "[cdda-mp] SRV-ACK: moves=0 (" ) + action_name
            + ") grant_seq=" + std::to_string( recipient.turn.grant_seq ) );
    host_broadcast_post_action();
    // The handler just mutated authoritative world state (positions, items,
    // doors, vehicle flags, etc.) but the host may be sitting in a blocking
    // wait_for_client_action poll where no normal turn boundary triggers a
    // redraw. Force the main UI adaptor to redraw so swap/push/pickup/drop/
    // open-close/etc. show up immediately on the host instead of lagging
    // until the next turn cycle.
    g->invalidate_main_ui_adaptor();
}

static void mp_handle_note_sync( const std::string &msg );
static void mp_handle_high_five_recv( const std::string &msg );
static bool mp_apply_high_five( Character &who );
static void mp_handle_shout_recv( remote_player_session &recipient, const std::string &msg );

static void publish_inventory_update( remote_player_session &recipient )
{
    if( npc *actor = mp_remote_actor( recipient ) ) {
        const std::string message = make_inventory_update( *actor, recipient.pickup );
        if( const auto server = get_active_server() ) {
            server->post_send( recipient.admission, message + "\n" );
        }
    }
}

static Character *resolve_partner_target( remote_player_session &sender, const JsonObject &message )
{
    const player_id requested( message.get_string( "target_player", "" ) );
    npc *actor = mp_remote_actor( sender );
    if( !actor || !requested.valid() || requested == sender.credentials.id ) {
        return nullptr;
    }
    Character *target = nullptr;
    if( requested == get_avatar().get_player_id() ) {
        target = &get_avatar();
    } else {
        for( const auto &entry : mp_session().remote_players ) {
            cata_mp::remote_player_session &other = *entry.second;
            if( other.connected && !other.detach_pending && requested == other.credentials.id ) {
                target = mp_remote_actor( other );
                break;
            }
        }
    }
    if( !target || target->is_dead_state() || target->posz() != actor->posz() ||
        rl_dist( actor->pos_abs(), target->pos_abs() ) > 1 ) {
        return nullptr;
    }
    return target;
}

// NOLINTNEXTLINE(readability-function-size)
static void handle_remote_action( remote_player_session &recipient,  const std::string_view/*name*/,
                                  const std::string &msg )
{
    if( !recipient.connected ) {
        return;
    }

    JsonValue jv_top = json_loader::from_string( msg );
    JsonObject jo = jv_top.get_object();
    jo.allow_omitted_members();
    const std::string action = jo.get_string( "action", "" );
    const std::string type = jo.get_string( "type", "" );
    if( !action.empty() && !type.empty() && type != "action" ) {
        return;
    }
    if( recipient.awaiting_character ) {
        if( action != "player_create" ) {
            return;
        }
        const peer_admission admission = recipient.admission;
        const player_credentials credentials = recipient.credentials;
        const std::string name = recipient.observation.partner_name_cached;
        // Complete admission creates and persists a fresh actor atomically.
        // Nothing from this upload can replace an already saved character.
        mp_session().remote_players.erase( admission.peer_id() );
        try {
            const JsonObject initial = jo.get_object( "player_state" );
            spawn_remote_player( name, admission, credentials, &initial );
        } catch( const std::exception & ) {
            if( const auto server = get_active_server() ) {
                server->post_reject( admission, "Could not initialize player character; reconnect to retry" );
            }
        }
        return;
    }
    if( action == "player_create" || action == "worn_sync" ) {
        return; // An admitted character is owned by the host.
    }
    npc *remote = mp_remote_actor( recipient );
    if( !remote ) {
        return;
    }
    const swap_map context( remote_actor_map( recipient, *remote ) );
    const bool inventory_request = action == "inventory_activity" ||
                                   action == "inventory_activity_cancel";
    if( remote->has_effect( effect_sleep ) && !inventory_request && !is_state_sync_message( msg ) ) {
        return;
    }

    if( action == "monster_name" ) {
        try {
            const int nid = jo.get_int( "subject" );
            monster *subject = nid > 0 ? mp_session().replication.entity_ids.find_monster(
                                   nid, get_creature_tracker() ) : nullptr;
            if( !subject ) {
                return;
            }
            view_action selected = select_view_action( view_action::kind::rename, *remote, get_map(),
                                   subject->pos_bub(), subject );
            jo.read( "origin", selected.origin, true );
            jo.read( "target", selected.target, true );
            jo.read( "name", selected.name, true );
            const int64_t request = jo.has_member( "peek_request" ) ? jo.get_int64( "peek_request" ) : 0;
            if( selected.name.size() > 1024 || request < 0 ) {
                return;
            }
            if( request > 0 ) {
                const auto *peek = active_peek( recipient );
                if( !peek || peek->request != request ) {
                    return;
                }
                selected.observation = map_viewpoint{ remote->getID(), peek->origin, peek->viewpoint,
                                                      peek->standing, peek->z_range };
            }
            if( selected.visible_to( *remote, get_map() ) ) {
                subject->nickname = selected.name;
                if( const auto server = get_active_server() ) {
                    server->post_send( recipient.admission, serialize_remote_player_state( recipient ) + "\n" );
                }
            }
        } catch( const JsonError & ) {
            mp_log( "[ccb-mp] rejected malformed monster nickname" );
        }
        return; // Cosmetic command: no action grant or inventory mutation.
    }

    if( action == "peek_close" ) {
        auto &peek = recipient.inventory_activity.peek;
        if( peek && ( jo.has_member( "request" ) ? jo.get_int64( "request" ) : 0 ) == peek->request ) {
            peek.reset();
        }
        return; // Presentation release neither consumes a grant nor cancels an activity.
    }

    if( inventory_request ) {
        const bool granted = !remote->has_effect( effect_sleep ) && jo.has_int( "grant_seq" ) &&
                             jo.get_int64( "grant_seq" ) == recipient.turn.grant_seq &&
                             recipient.turn.granted_this_turn && !recipient.turn.client_acted_this_turn &&
                             recipient.turn.remote_moves > 0;
        remote->set_moves( recipient.turn.remote_moves );
        const int original_z = remote->pos_abs().z();
        const size_t messages = Messages::size();
        std::string result;
        try {
            const bool cancel = action == "inventory_activity_cancel" &&
                                jo.get_string( "operation" ) == "cancel";
            const bool step = action == "inventory_activity" && jo.get_string( "operation" ) != "cancel" &&
                              granted;
            result = execute_inventory_activity_request( *remote, get_map(), jo, recipient.inventory_activity,
                     recipient.pickup, cancel || ( step && recipient.firearm.weapon == 0 ) );
        } catch( const JsonError &error ) {
            if( const auto server = get_active_server() ) {
                server->post_reject( recipient.admission,
                                     "Invalid inventory activity request; reconnect to synchronize." );
            }
            mp_log( std::string( "[ccb-mp] rejected inventory activity intent: " ) + error.what() );
            return;
        }
        for( const int64_t uid : recipient.inventory_activity.refresh_vehicle_snapshots ) {
            if( vehicle *target = vehicle::find_vehicle_by_uid( get_map(), uid ) ) {
                const uint32_t wire_id = mp_session().replication.entity_ids.assign( *target );
                for( auto &entry : mp_session().remote_players ) {
                    if( entry.second ) {
                        entry.second->replication.client_known_veh_nids.erase( wire_id );
                    }
                }
            }
        }
        remote = mp_remote_actor( recipient );
        if( !remote ) {
            send_inventory_activity_observers( recipient );
            return;
        }
        if( remote->has_effect( effect_sleep ) ) {
            remote->set_moves( std::min( 0, remote->get_moves() ) );
        }
        recipient.turn.remote_moves = remote->get_moves();
        recipient.turn.client_acted_this_turn = recipient.turn.remote_moves <= 0;
        recipient.observation.partner_activity = owns_inventory_activity( *remote ) ?
                remote->activity.id().str() : "";
        flush_action_msgs( recipient, messages, remote->name );
        if( const auto server = get_active_server() ) {
            const int current_z = remote->pos_abs().z();
            if( current_z != original_z ) {
                for( auto it = recipient.replication.map_sync_sent.begin();
                     it != recipient.replication.map_sync_sent.end(); ) {
                    it = it->z() == current_z ? recipient.replication.map_sync_sent.erase( it ) :
                         std::next( it );
                }
                const std::string zmap = build_map_sync_z( recipient, current_z );
                if( !zmap.empty() ) {
                    server->post_send( recipient.admission, zmap + "\n" );
                }
            }
            if( const auto *peek = active_peek( recipient ); peek &&
                peek->request == jo.get_int64( "request" ) ) {
                const int bottom = std::max( -OVERMAP_DEPTH, peek->viewpoint.z() - peek->z_range );
                const int top = std::min( OVERMAP_HEIGHT, peek->viewpoint.z() + peek->z_range );
                for( auto it = recipient.replication.map_sync_sent.begin();
                     it != recipient.replication.map_sync_sent.end(); ) {
                    it = it->z() >= bottom && it->z() <= top ?
                         recipient.replication.map_sync_sent.erase( it ) : std::next( it );
                }
                // Map, result and state share reliable_ordered. Complete this view
                // before the result can open its UI; the ordinary join cap is insufficient.
                for( int z = bottom; z <= top; ++z ) {
                    const std::string tiles = build_map_sync_z( recipient, z, true );
                    if( !tiles.empty() ) {
                        server->post_send( recipient.admission, tiles + "\n" );
                    }
                }
            }
            if( !result.empty() ) {
                server->post_send( recipient.admission, result + "\n" );
            }
            std::string state = serialize_remote_player_state( recipient,
                                recipient.inventory_activity.changed_tiles );
            if( recipient.turn.granted_this_turn && !recipient.turn.client_acted_this_turn &&
                !state.empty() && state.back() == '}' ) {
                state.insert( state.size() - 1, ",\"free\":true" );
            }
            server->post_send( recipient.admission, state + "\n" );
        }
        send_inventory_activity_observers( recipient );
        g->invalidate_main_ui_adaptor();
        return;
    }
    if( action == "move" || action == "grab" || action == "toggle_haul" ||
        action == "drop" || action == "position_sync" || action == "smash" || action == "eat" ||
        action == "vehicle_construct" ) {
        // Reject before legacy stats/inventory uploads below can mutate this actor.
        if( const auto server = get_active_server() ) {
            std::string state = serialize_remote_player_state( recipient );
            if( recipient.turn.granted_this_turn && !recipient.turn.client_acted_this_turn &&
                !state.empty() && state.back() == '}' ) {
                state.insert( state.size() - 1, ",\"free\":true" );
            }
            server->post_send( recipient.admission, state + "\n" );
        }
        return;
    }
    if( owns_inventory_activity( *remote ) ||
        recipient.inventory_activity.dialogue_session != nullptr ) {
        // The owned activity and its inventory cannot be overwritten by a
        // legacy action/state upload while the player is reloading or choosing
        // placement. Cancellation has its own identity-checked operation above.
        if( const auto server = get_active_server() ) {
            server->post_send( recipient.admission, serialize_remote_player_state( recipient ) );
        }
        return;
    }
    if( !action.empty() && action != "firearm_cancel" && !is_state_sync_message( msg ) &&
        ( !jo.has_int( "grant_seq" ) || jo.get_int64( "grant_seq" ) != recipient.turn.grant_seq ||
          !recipient.turn.granted_this_turn || recipient.turn.client_acted_this_turn ||
          recipient.turn.remote_moves <= 0 ) ) {
        // A retry must not become a second action or an action in the next
        // world turn. Never apply its attached inventory/terrain mutations.
        if( const auto server = get_active_server() ) {
            server->post_send( recipient.admission, serialize_remote_player_state( recipient ) );
        }
        return;
    }
    if( !action.empty() && action != "throw" && !is_state_sync_message( msg ) ) {
        recipient.inventory_activity.peek.reset();
    }
    if( action == "control_vehicle" || action == "stop_engine" || action == "toggle_engine" ) {
        // Current clients use identity-checked vehicle_control requests. Legacy
        // toggles must not apply attached character, inventory or vehicle data.
        srv_emit_ack( recipient, action.c_str() );
        return;
    }
    if( action == "pldrive" || action == "cruise" || action == "handbrake" ) {
        // Driving is an intent, not a character/vehicle upload. The grant above
        // and native control lookup select the operator and vehicle on the host.
        const size_t messages = Messages::size();
        remote->set_moves( recipient.turn.remote_moves );
        try {
            if( recipient.firearm.weapon == 0 ) {
                if( action == "pldrive" ) {
                    const tripoint_rel_ms input( jo.get_int( "dx", 0 ), jo.get_int( "dy", 0 ),
                                                 jo.get_int( "dz", 0 ) );
                    const int excess = std::max( 0, recipient.turn.remote_moves - remote->get_speed() );
                    if( drive_vehicle( *remote, get_map(), input ) ) {
                        remote = mp_remote_actor( recipient );
                        if( !remote ) {
                            return;
                        }
                        // Steering caps moves to one speed unit; acceleration alone
                        // does not. Never count the excess budget twice.
                        if( input.x() != 0 && input.z() == 0 &&
                            remote->get_moves() != recipient.turn.remote_moves ) {
                            remote->mod_moves( excess );
                        }
                    }
                } else if( action == "cruise" ) {
                    adjust_vehicle_cruise( *remote, get_map(), jo.get_int( "dy", 0 ) );
                } else {
                    brake_vehicle( *remote, get_map() );
                }
            }
        } catch( const JsonError &error ) {
            mp_log( std::string( "[ccb-mp] rejected driving intent: " ) + error.what() );
        }
        remote = mp_remote_actor( recipient );
        if( !remote ) {
            return;
        }
        recipient.turn.remote_moves = remote->get_moves();
        recipient.turn.client_acted_this_turn = recipient.turn.remote_moves <= 0;
        flush_action_msgs( recipient, messages, remote->name );
        if( const auto server = get_active_server() ) {
            std::string state = serialize_remote_player_state( recipient );
            if( !recipient.turn.client_acted_this_turn && !state.empty() && state.back() == '}' ) {
                state.insert( state.size() - 1, ",\"free\":true" );
            }
            server->post_send( recipient.admission, state + "\n" );
        }
        g->invalidate_main_ui_adaptor();
        return;
    }
    if( action == "firearm_cancel" ) {
        // Cancellation can arrive while AP is exhausted; the owned preparation
        // identity makes retries harmless, without accepting client mutations.
        const firearm_state &aim = recipient.firearm;
        const int64_t source = aim.weapon ? aim.weapon :
                               aim.bionic_weapon_source;
        if( source > 0 && source == ( jo.has_member( "weapon" ) ? jo.get_int64( "weapon" ) : 0 ) &&
            aim.bionic == ( jo.has_member( "bionic" ) ? jo.get_int64( "bionic" ) : 0 ) &&
            ( jo.has_member( "request" ) ? jo.get_int64( "request" ) : 0 ) > aim.last_request ) {
            recipient.firearm.last_request = jo.get_int64( "request" );
            remote->set_moves( recipient.turn.remote_moves );
            const size_t messages = Messages::size();
            finish_firearm_activity( *remote, recipient.firearm, true,
                                     jo.get_bool( "unload_ras", false ) );
            remote = mp_remote_actor( recipient );
            if( !remote ) {
                return;
            }
            recipient.turn.remote_moves = remote->get_moves();
            recipient.turn.client_acted_this_turn = recipient.turn.remote_moves <= 0;
            recipient.observation.partner_activity.clear();
            flush_action_msgs( recipient, messages, remote->name );
        }
        const std::string result = make_combat_result( *remote, recipient.pickup );
        if( const auto server = get_active_server() ) {
            server->post_send( recipient.admission, result + "\n" );
            std::string state = serialize_remote_player_state( recipient );
            if( !recipient.turn.client_acted_this_turn && recipient.turn.granted_this_turn &&
                !state.empty() && state.back() == '}' ) {
                state.insert( state.size() - 1, ",\"free\":true" );
            }
            server->post_send( recipient.admission, state + "\n" );
        }
        return;
    }
    if( action == "pickup" ) {
        // An intent must not first apply client tile/inventory mutations.
        // Resolve exact source identities against the authoritative map.
        try {
            remote->set_moves( recipient.turn.remote_moves );
            const int64_t previous = recipient.pickup.last_request;
            const std::string result = execute_pickup_request( *remote, get_map(), jo,
                                       recipient.pickup );
            if( const auto srv = get_active_server() ) {
                srv->post_send( recipient.admission, result );
            }
            if( previous != recipient.pickup.last_request ) {
                mp_session().presentation.last_client_action_label = "pickup";
                srv_emit_ack( recipient, "pickup" );
            }
        } catch( const JsonError & ) {
            if( const auto srv = get_active_server() ) {
                srv->post_reject( recipient.admission,
                                  "Invalid pickup request; reconnect to resynchronize." );
            }
        }
        return;
    }
    if( action == "give_item" ) {
        try {
            Character *target = resolve_partner_target( recipient, jo );
            remote_player_session *other = target ? mp_session().find_remote( target->getID() ) : nullptr;
            if( other && other->pickup.revision >= std::numeric_limits<int64_t>::max() - 1 ) {
                target = nullptr;
            }
            const int64_t previous = recipient.pickup.last_request;
            remote->set_moves( recipient.turn.remote_moves );
            const give_result result = execute_give_request( *remote, target, jo, recipient.pickup );
            if( result.transferred && other ) {
                publish_inventory_update( *other );
            }
            if( const auto server = get_active_server() ) {
                server->post_send( recipient.admission, result.response + "\n" );
            }
            if( previous != recipient.pickup.last_request ) {
                srv_emit_ack( recipient, "give_item" );
            }
        } catch( const std::exception & ) {
            if( const auto server = get_active_server() ) {
                server->post_reject( recipient.admission, "Invalid inventory request; reconnect to synchronize." );
            }
        }
        return;
    }
    if( action == "equipment" ) {
        remote->set_moves( recipient.turn.remote_moves );
        const size_t messages = Messages::size();
        try {
            equipment_intent intent;
            jo.read( "equipment", intent, true );
            if( recipient.firearm.weapon == 0 &&
                pickup_inventory_revision_matches( jo, recipient.pickup ) ) {
                execute_equipment_intent( *remote, get_map(), intent );
            }
        } catch( const JsonError &error ) {
            mp_log( std::string( "[ccb-mp] rejected equipment intent: " ) + error.what() );
        }
        remote = mp_remote_actor( recipient );
        if( !remote ) {
            return;
        }
        recipient.turn.remote_moves = remote->get_moves();
        recipient.turn.client_acted_this_turn = recipient.turn.remote_moves <= 0;
        flush_action_msgs( recipient, messages, remote->name );
        const std::string result = make_combat_result( *remote, recipient.pickup );
        if( const auto server = get_active_server() ) {
            server->post_send( recipient.admission, result + "\n" );
            std::string state = serialize_remote_player_state( recipient );
            if( !recipient.turn.client_acted_this_turn && !state.empty() && state.back() == '}' ) {
                state.insert( state.size() - 1, ",\"free\":true" );
            }
            server->post_send( recipient.admission, state + "\n" );
        }
        g->invalidate_main_ui_adaptor();
        return;
    }
    if( action == "throw" ) {
        remote->set_moves( recipient.turn.remote_moves );
        const size_t messages = Messages::size();
        const auto paid_peek = std::exchange( recipient.inventory_activity.peek, std::nullopt );
        try {
            throw_intent intent;
            const std::string method = jo.get_string( "method", "hand" );
            if( method != "hand" && method != "sling" ) {
                jo.throw_error_at( "method", "Unknown throwing method" );
            }
            intent.method = method == "sling" ? throw_method::sling : throw_method::hand;
            jo.read( "origin", intent.origin, true );
            jo.read( "target", intent.target, true );
            jo.read( "blind_from", intent.blind_from, true );
            intent.item.kind = jo.get_string( "source" );
            jo.read( "source_position", intent.item.position, true );
            jo.read( "path", intent.item.path, true );
            intent.wielded = jo.get_int64( "wielded" );
            intent.peek_request = ( jo.has_member( "peek_request" ) ? jo.get_int64( "peek_request" ) : 0 );
            intent.allow_theft = jo.get_bool( "allow_theft", false );
            if( jo.has_object( "disposition" ) ) {
                const JsonObject choice = jo.get_object( "disposition" );
                intent.disposition = item_disposition{ choice.get_string( "action" ),
                                                       choice.get_int64( "container" ), choice.get_int64( "pocket" ) };
            }
            if( pickup_inventory_revision_matches( jo, recipient.pickup ) ) {
                const bool prepared = intent.method != throw_method::sling ||
                                      ( recipient.firearm.weapon == intent.wielded &&
                                        !recipient.firearm.activity_started );
                if( prepared ) {
                    if( execute_throw_intent( *remote, get_map(), intent, paid_peek ? &*paid_peek : nullptr ) &&
                        intent.method == throw_method::sling ) {
                        const int64_t cursor = recipient.firearm.last_request;
                        recipient.firearm = {};
                        recipient.firearm.last_request = cursor;
                    }
                }
            }
        } catch( const JsonError &error ) {
            mp_log( std::string( "[ccb-mp] rejected throw intent: " ) + error.what() );
        }
        remote = mp_remote_actor( recipient );
        if( !remote ) {
            return;
        }
        recipient.turn.remote_moves = remote->get_moves();
        recipient.turn.client_acted_this_turn = recipient.turn.remote_moves <= 0;
        flush_action_msgs( recipient, messages, remote->name );
        const std::string result = make_combat_result( *remote, recipient.pickup );
        g->cleanup_dead();
        if( const auto server = get_active_server() ) {
            server->post_send( recipient.admission, result + "\n" );
            std::string state = serialize_remote_player_state( recipient );
            if( !recipient.turn.client_acted_this_turn && !state.empty() && state.back() == '}' ) {
                state.insert( state.size() - 1, ",\"free\":true" );
            }
            server->post_send( recipient.admission, state + "\n" );
        }
        g->invalidate_main_ui_adaptor();
        return;
    }
    if( action == "firearm" ) {
        const int budget = recipient.turn.remote_moves;
        remote->set_moves( budget );
        const size_t messages = Messages::size();
        firearm_intent intent;
        firearm_outcome outcome = firearm_outcome::rejected;
        try {
            intent.action = jo.get_string( "operation" );
            intent.weapon = jo.get_int64( "weapon" );
            jo.read( "bionic", intent.bionic );
            intent.request = jo.get_int64( "request" );
            intent.mode = gun_mode_id( jo.get_string( "mode" ) );
            intent.burst_rounds = jo.get_int( "burst_rounds", 0 );
            jo.read( "ammo", intent.ammo, false );
            jo.read( "origin", intent.origin, true );
            jo.read( "target", intent.target, true );
            if( intent.request > 0 && pickup_inventory_revision_matches( jo, recipient.pickup ) ) {
                outcome = execute_firearm_intent( *remote, get_map(), recipient.firearm, intent );
            }
        } catch( const JsonError &error ) {
            mp_log( std::string( "[ccb-mp] rejected firearm intent: " ) + error.what() );
        }
        remote = mp_remote_actor( recipient );
        if( !remote ) {
            return;
        }
        recipient.turn.remote_moves = remote->get_moves();
        recipient.turn.client_acted_this_turn = recipient.turn.remote_moves <= 0;
        recipient.observation.partner_activity = outcome == firearm_outcome::aiming ? "ACT_AIM" : "";
        flush_action_msgs( recipient, messages, remote->name );
        std::ostringstream encoded;
        JsonOut out( encoded );
        out.start_object();
        out.member( "type", "firearm_result" );
        out.member( "weapon", intent.weapon );
        out.member( "bionic", intent.bionic );
        out.member( "request", intent.request );
        if( intent.bionic && recipient.firearm.bionic == intent.bionic && recipient.firearm.bionic_weapon &&
            ( intent.action == "prepare" || intent.ammo || outcome != firearm_outcome::aiming ) ) {
            out.member( "bionic_preview", *recipient.firearm.bionic_weapon );
        }
        out.member( "outcome", static_cast<int>( outcome ) );
        // Aiming a firearm changes recoil/AP only. Avoid serializing every
        // carried item on each ten-move aim adjustment.
        if( outcome != firearm_outcome::aiming || intent.action == "prepare" || intent.ammo ) {
            const std::string combat = make_combat_result( *remote, recipient.pickup );
            out.member( "combat" );
            *out.get_stream() << combat;
            out.set_need_separator();
        } else {
            ++recipient.pickup.revision;
        }
        out.member( "inventory_revision", recipient.pickup.revision );
        out.member( "recoil", remote->recoil );
        out.end_object();
        g->cleanup_dead();
        if( const auto server = get_active_server() ) {
            server->post_send( recipient.admission, encoded.str() + "\n" );
            std::string state = serialize_remote_player_state( recipient );
            if( !recipient.turn.client_acted_this_turn && !state.empty() && state.back() == '}' ) {
                state.insert( state.size() - 1, ",\"free\":true" );
            }
            server->post_send( recipient.admission, state + "\n" );
        }
        g->invalidate_main_ui_adaptor();
        return;
    }
    if( action == "melee" ) {
        const int budget = recipient.turn.remote_moves;
        remote->set_moves( budget );
        const size_t messages = Messages::size();
        try {
            melee_intent intent;
            jo.read( "origin", intent.origin, true );
            jo.read( "target", intent.target, true );
            const std::string mode = jo.get_string( "mode" );
            if( mode != "strike" && mode != "reach" && mode != "technique" ) {
                jo.throw_error_at( "mode", "Unknown melee action" );
            }
            intent.action = mode == "reach" ? melee_action::reach :
                            mode == "technique" ? melee_action::technique : melee_action::strike;
            intent.technique = matec_id( jo.get_string( "technique", "" ) );
            intent.allow_collateral = jo.get_bool( "allow_collateral", false );
            map &here = get_map();
            Creature *target = here.inbounds( intent.target ) ?
                               get_creature_tracker().creature_at( here.get_bub( intent.target ), true ) : nullptr;
            const std::string player = jo.get_string( "target_player", "" );
            const int64_t monster_id = jo.has_int( "target_monster" ) ?
                                       jo.get_int64( "target_monster" ) : 0;
            const int npc_id = jo.get_int( "target_npc", -1 );
            bool identity_matches = false;
            if( jo.has_member( "target_monster" ) ) {
                identity_matches = monster_id > 0 && monster_id <= std::numeric_limits<uint32_t>::max() &&
                                   target && target == mp_session().replication.entity_ids.find_monster(
                                       static_cast<uint32_t>( monster_id ), get_creature_tracker() );
            } else if( !player.empty() ) {
                identity_matches = target && target->as_character() &&
                                   partner_identity( target->as_character()->getID() ).str() == player;
            } else if( npc_id >= 0 ) {
                identity_matches = target && target->as_npc() &&
                                   target->as_npc()->getID().get_value() == npc_id;
            } else {
                identity_matches = intent.action == melee_action::reach;
            }
            if( identity_matches && pickup_inventory_revision_matches( jo, recipient.pickup ) ) {
                execute_melee_intent( *remote, here, intent );
            }
        } catch( const JsonError &error ) {
            mp_log( std::string( "[ccb-mp] rejected melee intent: " ) + error.what() );
        }
        recipient.observation.partner_activity.clear();
        const bool spent = remote->get_moves() < budget;
        recipient.turn.remote_moves = spent ? remote->get_moves() : budget;
        const bool turn_ended = recipient.turn.remote_moves <= 0;
        recipient.turn.client_acted_this_turn = turn_ended;
        flush_action_msgs( recipient, messages, remote->name );
        const std::string result = make_combat_result( *remote, recipient.pickup );
        // Cleanup may delete an attacker killed by retaliation; do not use it afterward.
        g->cleanup_dead();
        if( const auto server = get_active_server() ) {
            server->post_send( recipient.admission, result + "\n" );
            std::string state = serialize_remote_player_state( recipient );
            if( !turn_ended && !state.empty() && state.back() == '}' ) {
                state.insert( state.size() - 1, ",\"free\":true" );
            }
            server->post_send( recipient.admission, state + "\n" );
        }
        g->invalidate_main_ui_adaptor();
        return;
    }
    if( action == "open" || action == "close" ) {
        // Door messages are intents. Do not first trust attached client terrain,
        // inventory, position or character changes, even for a rejected target.
        try {
            const tripoint_abs_ms target{ jo.get_int( "x" ), jo.get_int( "y" ), jo.get_int( "z" ) };
            map &here = get_map();
            const tripoint_abs_ms position = remote->pos_abs();
            remote->set_moves( recipient.turn.remote_moves );
            if( here.inbounds( position ) && here.inbounds( target ) &&
                target.z() == position.z() && square_dist( target.xy(), position.xy() ) <= 1 ) {
                if( action == "open" ) {
                    doors::open_immediately( here, *remote, here.get_bub( target ) );
                } else {
                    close_tile_activity_actor::close_immediately( *remote, here.get_bub( target ) );
                }
            }
        } catch( const JsonError &e ) {
            mp_log( std::string( "[cdda-mp] door parse error: " ) + e.what() );
        }
        srv_emit_ack( recipient, action.c_str() );
        return;
    }
    if( action == "swap_with_partner" || action == "push_partner" || action == "tap_partner" ) {
        try {
            if( Character *target = resolve_partner_target( recipient, jo ) ) {
                map &here = get_map();
                auto *other = mp_session().find_remote( target->getID() );
                if( action == "swap_with_partner" && !remote->is_mounted() && !target->is_mounted() ) {
                    g->swap_critters( *target, *remote );
                    if( other ) {
                        other->turn.pending_partner_swap = true;
                        other->turn.swap_from = remote->name;
                    } else {
                        add_msg( _( "%s swaps places with you." ), remote->name );
                    }
                } else if( action == "push_partner" && !target->is_mounted() ) {
                    const tripoint_bub_ms from = remote->pos_bub();
                    const tripoint_bub_ms to = target->pos_bub();
                    const auto sign = []( int value ) {
                        return ( value > 0 ) - ( value < 0 );
                    };
                    const tripoint_bub_ms destination = to + tripoint_rel_ms(
                                                            sign( to.x() - from.x() ), sign( to.y() - from.y() ), 0 );
                    if( here.inbounds( destination ) && !here.impassable( destination ) &&
                        !get_creature_tracker().creature_at<Creature>( destination ) ) {
                        target->setpos( here, destination );
                        if( other ) {
                            other->turn.pending_partner_push = true;
                            other->turn.push_from = remote->name;
                        } else {
                            add_msg( _( "%s pushes you out of the way." ), remote->name );
                        }
                    }
                } else if( action == "tap_partner" ) {
                    tap_waiting_partner( *remote, *target );
                }
            }
        } catch( const std::exception & ) {
            mp_log( "[ccb-mp] rejected invalid partner target" );
        }
        srv_emit_ack( recipient, action.c_str() );
        return;
    }
    if( type == "note_sync" ) {
        mp_handle_note_sync( msg );
        return;
    }

    if( type == "chat" ) {
        mp_handle_chat_msg( msg );
        return;
    }

    if( type == "high_five" ) {
        try {
            if( Character *target = resolve_partner_target( recipient, jo ) ) {
                mp_apply_high_five( *remote );
                mp_apply_high_five( *target );
                if( const auto *other = mp_session().find_remote( target->getID() ) ) {
                    if( const auto server = get_active_server() ) {
                        std::ostringstream encoded;
                        JsonOut out( encoded );
                        out.start_object();
                        out.member( "type", "high_five" );
                        out.member( "name", remote->name );
                        out.end_object();
                        server->post_send( other->admission, encoded.str() + "\n" );
                    }
                } else {
                    add_msg( m_good, _( "%s high-fives you!" ), remote->name );
                }
            }
        } catch( const std::exception & ) {
            mp_log( "[ccb-mp] rejected invalid high-five target" );
        }
        return;
    }

    if( type == "shout" ) {
        mp_handle_shout_recv( recipient, msg );
        return;
    }

    // Give the NPC its current move budget before executing any action.
    // (monmove skips remote player NPCs, so we manage AP ourselves.)
    remote->set_moves( recipient.turn.remote_moves );

    // Track the client's current activity for HUD + partner-notice display
    // AND for the lockstep bypass in wait_for_client_action.  Field is empty
    // when the client is idle.  The heartbeat is belt-and-suspenders: the
    // primary signal is the explicit activity_start / activity_end actions
    // handled below, but every action carries this snapshot too so a missed
    // start/end can still be reconciled on the next packet.
    if( jo.has_string( "client_activity" ) ) {
        recipient.observation.partner_activity = jo.get_string( "client_activity" );
        const std::string target = jo.get_string( "client_help_target", "" );
        recipient.observation.partner_help_target = target.empty() ? "" : player_id( target ).str();
        mp_partner_activity_transition_check();
    }
    if( jo.has_int( "client_activity_pct" ) ) {
        recipient.observation.partner_activity_pct = jo.get_int( "client_activity_pct" );
    }
    if( jo.has_int( "client_activity_moves_total" ) ) {
        recipient.observation.partner_activity_moves_total = jo.get_int( "client_activity_moves_total" );
    }
    if( jo.has_int( "client_morale" ) ) {
        recipient.observation.partner_morale = jo.get_int( "client_morale" );
    }
    if( jo.has_int( "client_hp_cur" ) ) {
        recipient.observation.partner_hp_cur = jo.get_int( "client_hp_cur" );
    }
    if( jo.has_int( "client_hp_max" ) ) {
        recipient.observation.partner_hp_max = jo.get_int( "client_hp_max" );
    }
    // Ping: remember the client's stamp to echo back; adopt the client-measured
    // RTT so the host panel shows the same latency the client computed.
    if( jo.has_int( "client_ping" ) ) {
        recipient.turn.last_client_ping_stamp = jo.get_int( "client_ping" );
    }
    if( is_hosting() && jo.has_int( "client_rtt" ) ) {
        recipient.observation.partner_ping_ms = jo.get_int( "client_rtt" );
    }
    if( jo.has_int( "client_calendar_turn" ) ) {
        recipient.observation.partner_calendar_turn = jo.get_int( "client_calendar_turn" );
    }

    // Explicit lifecycle markers for the client's passive activities.  These
    // are signal-only — they don't consume host moves and don't drive any
    // simulation on the host side.  Their sole job is to open and close the
    // lockstep bypass cleanly, so variable-duration activities like ACT_DROP
    // don't race the heartbeat.
    if( action == "activity_start" ) {
        const std::string id = jo.get_string( "activity_id", "" );
        const std::string prev = recipient.observation.partner_activity;
        if( !id.empty() ) {
            recipient.observation.partner_activity = id;
            mp_partner_activity_transition_check();
        }
        mp_log( "[cdda-mp] ACT-START RECV: id=" + id
                + " g_partner_activity prev=" + prev + " now=" + recipient.observation.partner_activity );
        return;
    }
    if( action == "activity_end" ) {
        const std::string id = jo.get_string( "activity_id", "" );
        if( ( id.empty() || id == "ACT_AIM" ) && recipient.firearm.weapon != 0 ) {
            finish_firearm_activity( *remote, recipient.firearm, true );
            if( npc *actor = mp_remote_actor( recipient ) ) {
                const std::string result = make_combat_result( *actor, recipient.pickup );
                if( const auto server = get_active_server() ) {
                    server->post_send( recipient.admission, result + "\n" );
                }
            }
        }
        const std::string prev = recipient.observation.partner_activity;
        recipient.observation.partner_activity.clear();
        recipient.observation.partner_help_target.clear();
        mp_partner_activity_transition_check();
        mp_log( "[cdda-mp] ACT-END RECV: id=" + id
                + " g_partner_activity prev=" + prev + " now=" + recipient.observation.partner_activity );
        return;
    }

    // A remote player can change the authoritative world without the host
    // taking an action. Bypass quicksave's local-avatar dirty counter and
    // report success only after the world and remote characters are written.
    if( action == "session_ending" ) {
        mp_log( "[cdda-mp] SESSION-END RECV: client is leaving — auto-saving host" );
        if( g->save() ) {
            add_msg( m_info, _( "Your partner is leaving.  The shared world has been saved." ) );
        } else {
            add_msg( m_bad,
                     _( "Your partner is leaving, but saving the shared world failed.  Keep the world open and retry saving." ) );
        }
        return;
    }

    // Co-op save handshake: the client saved on their side and asked us to save
    // the shared world too, so the host's authoritative save and the client's
    // local save stay at the same game-time. Reply with the actual outcome.
    if( action == "save_request" ) {
        mp_log( "[cdda-mp] SAVE-REQ RECV: partner asked host to save the shared world" );
        const bool saved = g->save();
        if( saved ) {
            add_msg( m_info, _( "Your partner saved — the shared world was saved too." ) );
        } else {
            add_msg( m_bad,
                     _( "Your partner requested a save, but saving the shared world failed.  Keep the world open and retry saving." ) );
        }
        if( auto srv = get_active_server() ) {
            srv->post_send( recipient.admission, saved ?
                            "{\"type\":\"save_done\",\"saved\":true}\n" :
                            "{\"type\":\"save_done\",\"saved\":false}\n" );
        }
        return;
    }

    // Templates wire-sync handlers (symmetric — same shape on host and client).
    if( type == "templates_list" ) {
        mp_handle_templates_list( msg, recipient.admission );
        return;
    }
    if( type == "template_request" ) {
        mp_handle_template_request( msg, recipient.admission );
        return;
    }
    if( type == "template_data" ) {
        mp_handle_template_data( msg );
        return;
    }

    if( !action.empty() ) {
        mp_session().presentation.last_client_action_label = action;
    }

    // Sync client facing direction so the remote NPC proxy flips correctly.
    if( jo.has_int( "client_facing" ) ) {
        remote->facing = jo.get_int( "client_facing" ) == 0
                         ? FacingDirection::LEFT : FacingDirection::RIGHT;
    }

    // Client-side avatar messages forwarded for display on the host's log.
    // The client has already substituted "You" with their character name, so
    // we just need to add_msg each verbatim.  Lets the host see notifications
    // like "Roy is now reading [Adventure Novel], 5 to stop early."
    if( jo.has_array( "client_msgs" ) ) {
        for( const JsonValue &mv : jo.get_array( "client_msgs" ) ) {
            const std::string text = mv.get_string();
            add_msg( m_info, text );
        }
        // Loop-break: messages forwarded FROM the client must not be picked
        // up by the host's between-action forwarder (NPC-name substitution
        // path in serialize_remote_player_state) and sent back as msgs.
        // Otherwise we get an infinite ping-pong of the same notification.
        recipient.turn.last_forwarded_msg_count = Messages::size();
    }

    if( action == "wait" ) {
        mp_log( "[cdda-mp] wait recv: ctrl_veh=" + std::to_string( remote->controlling_vehicle ) +
                " g_remote_moves=" + std::to_string( recipient.turn.remote_moves ) );
        srv_emit_ack( recipient, "wait" );
        return;
    }

    // Unrecognized legacy actions have no implicit movement fallback.
    mp_log( "[ccb-mp] rejected obsolete or unknown action: " + action );
    if( const auto server = get_active_server() ) {
        std::string state = serialize_remote_player_state( recipient );
        if( recipient.turn.granted_this_turn && !recipient.turn.client_acted_this_turn &&
            !state.empty() && state.back() == '}' ) {
            state.insert( state.size() - 1, ",\"free\":true" );
        }
        server->post_send( recipient.admission, state + "\n" );
    }
}

// Chunked overmap-sync apply. Applying the full ~32k-cell region with one
// overmap_buffer.ter_set() per cell froze the client's main thread for ~5.6s on
// receipt. Decode the packet into this buffer and drain a budget of cells per
// do_turn (mp_drain_pending_omsync) so the far-map fills in over a few seconds
// without ever blocking a frame. The overmap is far-map only (minimap / m-screen),
// so a brief fill-in delay is invisible to normal play.

static void mp_drain_pending_omsync()
{
    if( mp_session().replication.client.pending_omsync.empty() ) {
        return;
    }
    // Only apply while actually a client. If the session ended (e.g. dropped to
    // solo mid-apply), discard — don't write host overmap cells into a solo world.
    if( !is_client_mode() ) {
        mp_session().replication.client.pending_omsync.clear();
        return;
    }
    const std::chrono::steady_clock::time_point t0 = std::chrono::steady_clock::now();
    constexpr size_t BUDGET = 1200;   // cells per do_turn
    pending_omsync_t &p = mp_session().replication.client.pending_omsync.front();
    const size_t end = std::min( p.cursor + BUDGET, p.cells.size() );
    int applied = 0;
    for( ; p.cursor < end; ++p.cursor ) {
        if( p.ok[p.cursor] ) {
            overmap_buffer.ter_set(
                tripoint_abs_omt( p.ox + static_cast<int>( p.cursor % p.w ),
                                  p.oy + static_cast<int>( p.cursor / p.w ), p.z ),
                p.cells[p.cursor] );
            ++applied;
        }
    }
    const bool done = p.cursor >= p.cells.size();
    const size_t remaining = p.cells.size() - p.cursor;
    const int done_z = p.z;
    const long dur = static_cast<long>(
                         std::chrono::duration_cast<std::chrono::milliseconds>(
                             std::chrono::steady_clock::now() - t0 ).count() );
    if( dur > 25 ) {
        mp_log( "[cdda-mp] OMSYNC chunk: applied=" + std::to_string( applied ) +
                " dur=" + std::to_string( dur ) + "ms remaining=" +
                std::to_string( remaining ) );
    }
    if( done ) {
        mp_session().replication.client.pending_omsync.erase(
            mp_session().replication.client.pending_omsync.begin() );
        g->invalidate_main_ui_adaptor();   // one repaint once the region is complete
        mp_log( "[cdda-mp] OMSYNC apply DONE (chunked) z=" + std::to_string( done_z ) );
    }
}

// ---- Map (submap terrain+furniture) streaming -----------------------------
// One zoom level below overmap streaming.  The client regenerates submap detail
// locally with divergent mapgen RNG, so its main view and pixel minimap
// disagree with the host beyond the ~20-tile tile_changes patch.  Stream the
// host's authoritative ter+furn for the reality bubble, per-submap and
// incrementally (only newly-entered submaps each turn, capped), and overwrite
// the client's local terrain.  Items/fields/traps stay on the per-turn
// tile_changes delta; monsters/vehicles already synced.  Tracks which submaps
// (abs sm coord, at the avatar's z) the client already has; submaps that scroll
// out of the bubble are dropped so a return visit re-syncs.

// Build the overmap-region message for a single z-level.  The region is centered
// on the host's x/y (`center`); `z` selects the floor.  Throttling and the choice
// of which floors to sync live in the build_overmap_sync() wrapper below.
static std::string build_overmap_sync_z( remote_player_session &recipient,  int z,
        const tripoint_abs_omt &center )
{
    const int R = recipient.replication.om_sync_radius;
    const point o( center.x() - R, center.y() - R );
    const int w = 2 * R + 1;
    const int h = 2 * R + 1;

    std::vector<std::string> palette;
    std::unordered_map<std::string, int> pal_idx;
    auto idx_of = [&]( const std::string & s ) -> int {
        auto it = pal_idx.find( s );
        if( it != pal_idx.end() )
        {
            return it->second;
        }
        const int i = static_cast<int>( palette.size() );
        palette.push_back( s );
        pal_idx.emplace( s, i );
        return i;
    };

    // Row-major run-length encode the palette indices.
    std::string runs;
    runs.reserve( 8192 );
    int run_count = 0;
    int run_idx = -1;
    auto flush_run = [&]() {
        if( run_count > 0 ) {
            if( !runs.empty() ) {
                runs += ',';
            }
            runs += '[' + std::to_string( run_count ) + ',' + std::to_string( run_idx ) + ']';
        }
    };
    int real_omts = 0;
    for( int yy = 0; yy < h; ++yy ) {
        for( int xx = 0; xx < w; ++xx ) {
            const tripoint_abs_omt p( o.x + xx, o.y + yy, z );
            // No-generate read: only stream what the host already has. Empty
            // string = "ungenerated here", which the client skips.
            const overmap_with_local_coords omc = overmap_buffer.get_existing_om_global( p );
            int i;
            if( omc.om ) {
                i = idx_of( omc.om->ter( omc.local ).id().str() );
                ++real_omts;
            } else {
                i = idx_of( std::string() );
            }
            if( i == run_idx ) {
                ++run_count;
            } else {
                flush_run();
                run_idx = i;
                run_count = 1;
            }
        }
    }
    flush_run();
    // Nothing generated at this z near the host (e.g. an unvisited floor, or the
    // first turn before the bubble settles) — the wrapper decides whether to retry.
    if( real_omts == 0 ) {
        return std::string();
    }

    std::string pal_json = "[";
    for( size_t i = 0; i < palette.size(); ++i ) {
        if( i ) {
            pal_json += ',';
        }
        pal_json += '"' + json_escape_str( palette[i] ) + '"';
    }
    pal_json += ']';

    // City names: overmap terrain (synced above) is seed-deterministic, but city
    // NAMES are RNG-state-dependent and diverge on the client (same buildings,
    // wrong town name). Stream the host's names for this region; the client matches
    // its same-position cities and renames them. (Rivers are the same class —
    // overmap data the oter sync doesn't carry — and would use this same hook.)
    std::string cities_json = "[";
    if( z == 0 ) {   // cities live on the surface layer; only the z=0 sync carries names
        bool cfirst = true;
        const tripoint_abs_sm center_sm = project_to<coords::sm>( center );
        const int radius_sm = ( std::max( w, h ) / 2 + 1 ) * 2;
        for( const city_reference &cr : overmap_buffer.get_cities_near( center_sm, radius_sm ) ) {
            if( !cr.city || cr.city->name.empty() ) {
                continue;
            }
            const tripoint_abs_omt cp = project_to<coords::omt>( cr.abs_sm_pos );
            if( cp.x() < o.x || cp.x() >= o.x + w || cp.y() < o.y || cp.y() >= o.y + h ) {
                continue;
            }
            if( !cfirst ) {
                cities_json += ',';
            }
            cfirst = false;
            cities_json += "{\"x\":" + std::to_string( cp.x() ) + ",\"y\":" +
                           std::to_string( cp.y() ) + R"(,"n":")" +
                           json_escape_str( cr.city->name ) + "\"}";
        }
    }
    cities_json += "]";

    std::string msg = R"({"type":"overmap_sync","z":)" + std::to_string( z ) +
                      ",\"ox\":" + std::to_string( o.x ) + ",\"oy\":" + std::to_string( o.y ) +
                      ",\"w\":" + std::to_string( w ) + ",\"h\":" + std::to_string( h ) +
                      ",\"pal\":" + pal_json + ",\"cities\":" + cities_json +
                      ",\"rle\":[" + runs + "]}";
    mp_log( "[cdda-mp] OMSYNC send: center=" + std::to_string( center.x() ) + "," +
            std::to_string( center.y() ) + " z=" + std::to_string( z ) +
            " w=" + std::to_string( w ) +
            " real=" + std::to_string( real_omts ) + "/" + std::to_string( w * h ) +
            " pal=" + std::to_string( palette.size() ) + " bytes=" + std::to_string( msg.size() ) );
    return msg;
}

// Cross-z overmap (far-map) sync.  The v1 sync only streamed the surface (z=0),
// so the m-screen / minimap was wrong whenever a player was underground or up a
// floor.  Mirror the terrain fix: sync the union of {host z, client proxy z}.
// Throttled — resends only on the first sync, after the host moves a meaningful
// x/y distance, or when either player's floor changed (took stairs).
static std::string build_overmap_sync( remote_player_session &recipient )
{
    if( !is_hosting() || !recipient.connected ) {
        return std::string();
    }
    const npc *const remote = mp_remote_actor( recipient );
    const bool regional = remote && &remote_actor_map( recipient, *remote ) != &reality_bubble();
    const tripoint_abs_omt center = regional ? remote->pos_abs_omt() : get_avatar().pos_abs_omt();
    const int host_z = center.z();
    int client_z = host_z;
    if( remote ) {
        client_z = remote->pos_abs_omt().z();
    }

    const int step = 20;
    const bool moved = std::abs( center.x() - recipient.replication.om_sync_last_center.x() ) >=
                       step ||
                       std::abs( center.y() - recipient.replication.om_sync_last_center.y() ) >= step;
    const bool z_changed = host_z != recipient.replication.om_sync_last_center.z() ||
                           client_z != recipient.replication.om_sync_last_client_z;
    if( recipient.replication.om_sync_done && !moved && !z_changed ) {
        return std::string();
    }

    // Build the host's floor first; if nothing's generated there yet, don't latch
    // — retry next turn (mirrors the v1 real_omts==0 retry).
    std::string host_msg = build_overmap_sync_z( recipient, host_z, center );
    if( host_msg.empty() ) {
        recipient.replication.om_sync_done = false;
        return std::string();
    }
    recipient.replication.om_sync_last_center = center;
    recipient.replication.om_sync_last_client_z = client_z;
    recipient.replication.om_sync_done = true;

    std::string out = std::move( host_msg );
    if( client_z != host_z ) {
        const std::string cmsg = build_overmap_sync_z( recipient, client_z, center );
        if( !cmsg.empty() ) {
            out += '\n';
            out += cmsg;
        }
    }
    return out;
}

// Stream the host's authoritative submap terrain+furniture for the reality
// bubble so the client's main view and minimap match instead of its divergent
// local mapgen.  Returns "" when there are no new submaps to send this turn
// (steady state), so it's cheap on the hot path.  Sends at most g_map_sync_cap
// submaps per call; the bubble fills over a few turns on join and incremental
// rows stream in as a player moves.  Palette + per-submap RLE, like the overmap
// sync.  Builds the message for a single z-level `az`; which z-levels get synced
// (and the sent-set pruning) live in the build_map_sync() wrapper below.
static std::string build_map_sync_z( remote_player_session &recipient, int az, bool complete )
{
    const std::chrono::steady_clock::time_point t0 = std::chrono::steady_clock::now();
    map &m = recipient_map( recipient );
    const tripoint_abs_sm origin = m.get_abs_sub();

    std::vector<std::string> palette;
    std::unordered_map<std::string, int> pal_idx;
    auto idx_of = [&]( const std::string & s ) -> int {
        auto f = pal_idx.find( s );
        if( f != pal_idx.end() )
        {
            return f->second;
        }
        const int i = static_cast<int>( palette.size() );
        palette.push_back( s );
        pal_idx[s] = i;
        return i;
    };
    auto rle = [&]( const std::vector<int> &cells ) -> std::string {
        std::string out = "[";
        bool first = true;
        const int n = static_cast<int>( cells.size() );
        int i = 0;
        while( i < n )
        {
            int j = i + 1;
            while( j < n && cells[j] == cells[i] ) {
                ++j;
            }
            if( !first ) {
                out += ',';
            }
            first = false;
            out += "[" + std::to_string( j - i ) + "," + std::to_string( cells[i] ) + "]";
            i = j;
        }
        out += "]";
        return out;
    };

    std::string subs = "[";
    bool first_sub = true;
    int sent = 0;
    const int cap = complete ? MAPSIZE * MAPSIZE : g_map_sync_cap;
    for( int gy = 0; gy < MAPSIZE && sent < cap; ++gy ) {
        for( int gx = 0; gx < MAPSIZE && sent < cap; ++gx ) {
            const tripoint_abs_sm sm_abs{ origin.x() + gx, origin.y() + gy, az };
            if( recipient.replication.map_sync_sent.count( sm_abs ) || !m.has_loaded_submap( sm_abs ) ) {
                continue;
            }
            const tripoint_abs_ms sm_ms0{ sm_abs.x() *SEEX, sm_abs.y() *SEEY, az };
            const tripoint_bub_ms bub0 = m.get_bub( sm_ms0 );
            if( !m.inbounds( bub0 ) ) {
                continue;
            }
            std::vector<int> ter_cells;
            std::vector<int> furn_cells;
            ter_cells.reserve( SEEX * SEEY );
            furn_cells.reserve( SEEX * SEEY );
            for( int ly = 0; ly < SEEY; ++ly ) {
                for( int lx = 0; lx < SEEX; ++lx ) {
                    const tripoint_bub_ms bub{ bub0.x() + lx, bub0.y() + ly, bub0.z() };
                    ter_cells.push_back( idx_of( m.ter( bub ).id().str() ) );
                    furn_cells.push_back( idx_of( m.furn( bub ).id().str() ) );
                }
            }
            if( !first_sub ) {
                subs += ',';
            }
            first_sub = false;
            subs += "{\"sx\":" + std::to_string( sm_abs.x() ) +
                    ",\"sy\":" + std::to_string( sm_abs.y() ) +
                    ",\"t\":" + rle( ter_cells ) +
                    ",\"f\":" + rle( furn_cells ) + "}";
            recipient.replication.map_sync_sent.insert( sm_abs );
            ++sent;
        }
    }
    subs += "]";
    if( sent == 0 ) {
        return std::string();   // nothing new — steady state
    }
    std::string pal = "[";
    for( size_t i = 0; i < palette.size(); ++i ) {
        if( i ) {
            pal += ',';
        }
        pal += "\"" + palette[i] + "\"";
    }
    pal += "]";
    std::string msg = R"({"type":"map_sync","z":)" + std::to_string( az ) +
                      ",\"pal\":" + pal + ",\"subs\":" + subs + "}";
    const long build_ms = std::chrono::duration_cast<std::chrono::milliseconds>(
                              std::chrono::steady_clock::now() - t0 ).count();
    mp_log( "[cdda-mp] MAPSYNC send: subs=" + std::to_string( sent ) +
            " pal=" + std::to_string( palette.size() ) +
            " bytes=" + std::to_string( msg.size() ) +
            " ms=" + std::to_string( build_ms ) +
            " z=" + std::to_string( az ) );
    return msg;
}

// Cross-z terrain sync.  The client can stand on a different floor than the host
// — it may spawn a level off, or either player walks up/down stairs.  The v1
// behavior synced only the host's z-level, so the floor the *client* was on kept
// showing its divergent local mapgen: it looked like the whole tile was erased
// except for the one synced floor (reported 2026-06-14, client a floor below the
// host).  Fix: sync the union of the host's z and the remote player's z.  Same z
// => one message (no extra cost); different floors => one message per floor.
static std::string build_map_sync( remote_player_session &recipient, bool complete )
{
    if( !is_hosting() || !recipient.connected ) {
        return std::string();
    }
    map &terrain = recipient_map( recipient );
    const tripoint_abs_sm origin = terrain.get_abs_sub();

    // Which floors to sync this turn: the host's, plus the client's if its proxy
    // is on a different one.
    const int host_z = &terrain == &reality_bubble() ? get_avatar().posz() : origin.z();
    int client_z = host_z;
    const npc *remote = mp_remote_actor( recipient );
    if( remote ) {
        client_z = remote->posz();
    }
    const bool two_floors = client_z != host_z;
    const auto *peek = active_peek( recipient );

    // Forget submaps that have scrolled out of the synced region — a different
    // x/y bubble, or a z-level we're no longer syncing — so a return visit
    // re-syncs them (the client may have regenerated them locally after unload).
    for( auto it = recipient.replication.map_sync_sent.begin();
         it != recipient.replication.map_sync_sent.end(); ) {
        const bool z_synced = it->z() == host_z || ( two_floors && it->z() == client_z ) ||
                              ( peek && std::abs( it->z() - peek->viewpoint.z() ) <= peek->z_range );
        const bool in_bubble = z_synced &&
                               it->x() >= origin.x() && it->x() < origin.x() + MAPSIZE &&
                               it->y() >= origin.y() && it->y() < origin.y() + MAPSIZE;
        it = in_bubble ? std::next( it ) : recipient.replication.map_sync_sent.erase( it );
    }

    const bool regional = &terrain != &reality_bubble();
    std::string out = build_map_sync_z( recipient, host_z, complete || regional );
    if( two_floors ) {
        const std::string client_msg = build_map_sync_z( recipient, client_z, complete || regional );
        if( !client_msg.empty() ) {
            if( !out.empty() ) {
                out += '\n';
            }
            out += client_msg;
        }
    }
    return out;
}

// ---------------------------------------------------------------------------
// Public API
// ---------------------------------------------------------------------------

bool prepare_remote_character_turn( npc &actor )
{
    if( is_client_mode() ) {
        return false;
    }
    auto *peer = mp_session().find_remote( actor.getID() );
    if( !peer || mp_remote_actor( *peer ) != &actor ) {
        return false;
    }
    actor.set_moves( peer->turn.remote_moves );
    if( peer->player_state_initialized ) {
        peer->inventory_before_turn = capture_inventory_turn( actor );
    }
    return true;
}

void finish_remote_character_turn( npc &actor )
{
    if( auto *peer = mp_session().find_remote( actor.getID() ) ) {
        if( peer->actor.owns_instance( &actor, g->npc_lifetimes() ) ) {
            peer->turn.remote_moves = actor.get_moves();
            if( peer->inventory_before_turn ) {
                const auto update = make_inventory_turn_update( actor, *peer->inventory_before_turn,
                                    peer->pickup );
                peer->inventory_before_turn.reset();
                if( update ) {
                    if( const auto server = get_active_server() ) {
                        server->post_send( peer->admission, *update + "\n" );
                    }
                }
            }
        }
    }
}

static void grant_remote_turn( remote_player_session &recipient )
{
    if( !recipient.connected || recipient.detach_pending ) {
        return;
    }
    npc *remote = mp_remote_actor( recipient );
    if( !remote ) {
        recipient.turn.granted_this_turn = false;
        const npc *retained = recipient.actor.retained( g->npc_lifetimes() );
        if( retained && !retained->is_dead_state() ) {
            // Temporary unload or removal from the tracker is not death. Do
            // not grant actions until native loading restores this same actor.
            return;
        }

        // If we previously had a live proxy and it's now gone, treat it as a
        // death (monsters on the host's side killed the NPC representing the
        // client).  Notify the client cleanly so they get a "You died." flow
        // instead of a silent "Lost connection to server" 20 seconds later
        // when something else times out.  Then tear down the host-side state.
        if( recipient.turn.proxy_was_alive ) {
            mp_log( "[cdda-mp] PROXY-DIED: notifying client and disconnecting" );
            if( auto srv = get_active_server() ) {
                srv->post_send( recipient.admission, "{\"type\":\"you_died\"}\n" );
                // Brief flush window so the packet leaves before the socket
                // is torn down — same pattern as notify_client_host_died.
                std::this_thread::sleep_for( std::chrono::milliseconds( 200 ) );
            }
            recipient.turn.proxy_was_alive = false;
            remove_remote_player( recipient );
        }
        return;
    }
    recipient.turn.proxy_was_alive = true;
    const bool sleeping = remote->has_effect( effect_sleep );
    if( !sleeping && recipient.turn.granted_this_turn && !recipient.turn.client_acted_this_turn ) {
        return; // An outstanding grant must be consumed before another is issued.
    }
    if( sleeping ) {
        recipient.turn.remote_moves = std::min( 0, recipient.turn.remote_moves );
        remote->set_moves( recipient.turn.remote_moves );
    }
    recipient.turn.client_acted_this_turn = false;
    // The native character phase already replenished AP and applied effect
    // penalties. Grant that resulting budget, including carried action debt.
    recipient.turn.granted_this_turn = ( recipient.turn.remote_moves > 0 );
    if( recipient.turn.granted_this_turn ) {
        recipient.turn.grant_seq = ++mp_session().grant_sequence;
    }
    const player_activity &ha = get_avatar().activity;
    // turn= is the shared game clock (the client logs calendar_turn in its state
    // packets) — use it to align the host and client logs by game turn, immune to
    // wall-clock skew.  Safe to read here: grant_client_turn runs on the game
    // thread.
    mp_log( "[cdda-mp] grant_client_turn: remote_moves=" + std::to_string(
                recipient.turn.remote_moves ) +
            " seq=" + std::to_string( recipient.turn.grant_seq ) +
            " turn=" + std::to_string( to_turn<int>( calendar::turn ) ) +
            " host_act=" + ( ha ? ha.id().str() : "none" ) );
    // The owned-character world phase regenerates stamina once, independently
    // of grant delivery or AP debt; do not regenerate it again here.
    auto srv = get_active_server();
    if( srv ) {
        // NOTE: do NOT throttle this broadcast during fast-forward. The grant
        // itself (g_remote_moves / g_grant_seq) is delivered to the client INSIDE
        // serialize_remote_player_state — skipping the broadcast skips the grant,
        // which starved the client of grants and deadlocked both sides (client
        // waits for a grant that never comes; host waits for its ack). The FF
        // wire-flood/drift needs a fix that throttles only the heavy map/state
        // delta while still delivering every grant — reverted 2026-06-21.
        // Send map terrain BEFORE the position update so the client's
        // MAPBUFFER already has correct tiles (e.g. bridge deck at z=1)
        // by the time client_teleport_avatar fires update_map.  If map_sync
        // arrives after remote_player_state the client loads stale disk tiles
        // (t_open_air) first, gravity_check fires, and the client falls.
        const std::string mapm = build_map_sync( recipient );
        if( !mapm.empty() ) {
            srv->post_send( recipient.admission, mapm + "\n" );
        }
        srv->post_send( recipient.admission, serialize_remote_player_state( recipient ) + "\n" );
        // Stream the host's overmap region so the client's far-map (cities/
        // roads/biomes) matches instead of its own non-deterministic regen.
        // Returns "" unless this is the first sync or the host moved a step,
        // so it's cheap on the steady-state path.
        const std::string om = build_overmap_sync( recipient );
        if( !om.empty() ) {
            srv->post_send( recipient.admission, om + "\n" );
        }
    }
}


void grant_client_turn()
{
    // Capture the world seed each host turn (game-thread read of g->get_seed())
    // so the network thread can put it in the join 'welcome' without touching
    // game state. Runs before the connected-check so it's current the moment a
    // client joins. Seed is constant for a session; the store is idempotent.
    mp_session().host_info.seed = g->get_seed();
    // Capture the host avatar's OMT for the join 'welcome' so a client spawns into
    // the host's area, not its own scenario start_location.
    mp_capture_host_omt( get_avatar().pos_abs_omt() );
    if( world_generator && world_generator->active_world ) {
        mp_set_host_world_name( world_generator->active_world->world_name );
        mp_session().host_info.world = world_generator->active_world->identity();
    }
    // Cache the host's character name for the join 'welcome' so the client's
    // join dialog can show whose game it is. Runs before the connected-check so
    // it's current the moment a client probes.
    mp_set_host_player_name( get_avatar().name );
    mp_session().hosting.update_welcome( mp_session().host_info );
    for( auto it = mp_session().remote_players.begin(); it != mp_session().remote_players.end(); ) {
        cata_mp::remote_player_session &recipient = *it++->second;
        grant_remote_turn( recipient );
    }
}
static bool remote_turns_pending()
{
    for( const auto &entry : mp_session().remote_players ) {
        remote_player_session &recipient = *entry.second;
        if( recipient.connected && !recipient.detach_pending &&
            recipient.turn.granted_this_turn && !recipient.turn.client_acted_this_turn ) {
            const npc *actor = mp_remote_actor( recipient );
            if( actor && !actor->has_effect( effect_sleep ) ) {
                return true;
            }
        }
    }
    return false;
}

void wait_for_client_action()
{
    // Every admitted player with a positive action budget must finish this
    // turn. A reply, disconnect or AP debt affects only its own participant.
    process_mp_events();
    if( !remote_turns_pending() ) {
        return;
    }
    mp_session().host_waiting_for_clients = true;
    const std::chrono::steady_clock::time_point start = std::chrono::steady_clock::now();
    std::string previous_activity = get_avatar().activity ? get_avatar().activity.id().str() : "";
    while( g->uquit == QUIT_NO && remote_turns_pending() ) {
        get_mp_queue().wait_for_event( std::chrono::milliseconds( 16 ) );
        process_mp_events();
        if( !remote_turns_pending() ) {
            break;
        }
        const std::string activity = get_avatar().activity ? get_avatar().activity.id().str() : "";
        if( activity != previous_activity ) {
            host_broadcast_post_action();
            previous_activity = activity;
        }
        // Keep zoom, activity cancellation and window events responsive without
        // introducing a blocking gameplay input poll into the network wait.
        inp_mngr.pump_events();
        handle_key_blocking_activity( 16 );
        ensure_mp_hud();
        inp_mngr.pump_events();
        const std::chrono::steady_clock::time_point now = std::chrono::steady_clock::now();
        if( std::chrono::duration_cast<std::chrono::milliseconds>(
                now - mp_session().presentation.last_redraw ).count() > 100 ) {
            ui_manager::redraw();
            mp_session().presentation.last_redraw = now;
        }
    }
    mp_session().host_waiting_for_clients = false;
    mp_session().host_wait_elapsed_ms = static_cast<int>(
                                            std::chrono::duration_cast<std::chrono::milliseconds>(
                                                    std::chrono::steady_clock::now() - start ).count() );
    g->invalidate_main_ui_adaptor();
    ui_manager::redraw();
}
bool host_is_in_wait_activity()
{
    if( !is_hosting() ) {
        return false;
    }
    return is_wait_activity( get_avatar().activity.id().str() );
}

bool should_advance_calendar()
{
    return !is_client_mode();
}

bool client_begin_simulation_turn()
{
    client_turn_state &turn = mp_session().client_turn;
    if( !is_client_mode() || turn.observed_host_turn <= turn.processed_host_turn ) {
        return false;
    }
    turn.processed_host_turn = turn.observed_host_turn;
    return true;
}

bool is_passive_activity( const std::string &activity_id_str )
{
    // Activities where the avatar is committed turn-after-turn without
    // per-turn user input.  Once entered, SP's activity_actor::do_turn ticks
    // the activity on every game turn at machine speed.  Excludes:
    //  - ACT_AIM, ACT_AUTOATTACK, ACT_AUTODRIVE — interactive
    //  - ACT_NULL / empty — not in an activity
    static const std::set<std::string> passive = {
        "ACT_CRAFT", "ACT_LONG_CRAFT", "ACT_DISASSEMBLE", "ACT_DISMEMBER",
        "ACT_READ",
        "ACT_EAT", "ACT_DRINK", "ACT_CONSUME", "ACT_CONSUME_DRINK_MENU",
        "ACT_CONSUME_FOOD_MENU", "ACT_CONSUME_MEDS_MENU",
        "ACT_BUTCHER", "ACT_BUTCHER_FULL", "ACT_FIELD_DRESS",
        "ACT_SKIN", "ACT_DISSECT", "ACT_QUARTER",
        "ACT_CONSTRUCTION", "ACT_BUILD",
        "ACT_VEHICLE", "ACT_VEHICLE_REPAIR",
        "ACT_WORKOUT_LIGHT", "ACT_WORKOUT_MODERATE", "ACT_WORKOUT_ACTIVE",
        "ACT_WORKOUT_HARD", "ACT_WORKOUT",
        "ACT_FORAGE", "ACT_FISH",
        "ACT_FILL_LIQUID", "ACT_PICKUP", "ACT_MOVE_ITEMS",
        "ACT_WAIT", "ACT_WAIT_STAMINA", "ACT_WAIT_WEATHER", "ACT_WAIT_FOLLOWERS", "ACT_WAIT_NPC",
        "ACT_SLEEP", "ACT_TRY_SLEEP", "ACT_FIRSTAID",
        "ACT_HELP_PARTNER",
    };
    return passive.count( activity_id_str ) > 0;
}

bool should_fast_forward()
{
    if( !is_hosting() && !is_client_mode() ) {
        return false;
    }
    const player_activity &activity = get_avatar().activity;
    if( !get_avatar().has_effect( effect_sleep ) &&
        ( !activity || !is_passive_activity( activity.id().str() ) ) ) {
        return false;
    }
    if( is_client_mode() ) {
        // The client cannot infer group readiness from the host alone.
        return mp_session().client_turn.group_fast_forward;
    }
    bool participants = false;
    for( const auto &entry : mp_session().remote_players ) {
        remote_player_session &recipient = *entry.second;
        if( !recipient.connected || recipient.detach_pending ) {
            continue;
        }
        participants = true;
        const npc *actor = mp_remote_actor( recipient );
        if( !actor ) {
            return false;
        }
        if( actor->has_effect( effect_sleep ) ) {
            continue;
        }
        const bool passive = actor->activity ? is_passive_activity( actor->activity.id().str() ) :
                             recipient.observation.partner_activity == "ACT_HELP_PARTNER";
        if( !passive ) {
            return false;
        }
    }
    return participants;
}
void mp_log_safemode_check( int newseen, int mostseen, int safe_mode )
{
    if( !is_client_mode() && !is_hosting() ) {
        return;
    }
    avatar &u = get_avatar();
    const tripoint_abs_ms apos = u.pos_abs();
    int nearest = 9999;
    bool nearest_synced = false;
    std::string nearest_id;
    for( const auto &ptr : get_creature_tracker().get_monsters_list() ) {
        monster *mon = ptr.get();
        if( !mon || mon->is_dead() ) {
            continue;
        }
        if( u.attitude_to( *mon ) != Creature::Attitude::HOSTILE ) {
            continue;
        }
        const tripoint_abs_ms mp = mon->pos_abs();
        const int d = std::max( std::abs( mp.x() - apos.x() ), std::abs( mp.y() - apos.y() ) );
        if( d < nearest ) {
            nearest = d;
            nearest_synced = ( is_client_mode() ?
                               mp_session().replication.client.monsters.known_id( *mon ) :
                               mp_session().replication.entity_ids.known_id( *mon ) ) != 0;
            nearest_id = mon->type->id.str();
        }
    }
    // Throttle: only emit when something meaningful changed, else FF (200 turns/sec)
    // floods the 10MB log.
    if( newseen == mp_session().presentation.last_newseen &&
        nearest == mp_session().presentation.last_nearest &&
        safe_mode == mp_session().presentation.last_safe ) {
        return;
    }
    mp_session().presentation.last_newseen = newseen;
    mp_session().presentation.last_nearest = nearest;
    mp_session().presentation.last_safe = safe_mode;
    mp_log( "[cdda-mp] SAFEMODE-CHK side=" + std::string( is_client_mode() ? "client" : "host" ) +
            " act=" + ( u.activity ? u.activity.id().str() : std::string( "none" ) ) +
            " newseen=" + std::to_string( newseen ) +
            " mostseen=" + std::to_string( mostseen ) +
            " safe_mode=" + std::to_string( safe_mode ) +
            " nearest_hostile=" + ( nearest == 9999 ? std::string( "none" ) :
                                    ( nearest_id + "@d" + std::to_string( nearest ) +
                                      ( nearest_synced ? "(synced)" : "(PHANTOM)" ) ) ) );
}

void set_last_monmove_ms( int ms )
{
    mp_session().last_monmove_ms = ms;
}

void set_last_host_action_label( const std::string &label )
{
    // Normalize directional action_ident() output ("RIGHT", "LEFTUP", etc.)
    // into the client's "move:DIR" format so the HUD's "Queued" row reads
    // identically on both ends.  Non-movement labels pass through unchanged.
    static const std::unordered_map<std::string, std::string> dir_map = {
        { "UP", "move:n" },  { "DOWN", "move:s" },
        { "LEFT", "move:w" }, { "RIGHT", "move:e" },
        { "LEFTUP", "move:nw" }, { "RIGHTUP", "move:ne" },
        { "LEFTDOWN", "move:sw" }, { "RIGHTDOWN", "move:se" },
        { "LEVEL_UP", "move:up" }, { "LEVEL_DOWN", "move:down" },
    };
    const auto it = dir_map.find( label );
    mp_session().presentation.last_host_action_label = ( it != dir_map.end() ) ? it->second : label;
}

bool is_remote_player( character_id id )
{
    if( is_client_mode() ) {
        if( id == mp_session().client_host_actor.id() &&
            mp_session().client_host_actor.owns_instance( g->critter_by_id<npc>( id ), g->npc_lifetimes() ) ) {
            return true;
        }
        for( const auto &entry : mp_session().client_player_views ) {
            const actor_binding &binding = entry.second->actor;
            if( binding.id() == id &&
                binding.owns_instance( g->critter_by_id<npc>( id ), g->npc_lifetimes() ) ) {
                return true;
            }
        }
        return false;
    }
    const auto *recipient = mp_session().find_remote( id );
    return recipient &&
           recipient->actor.owns_instance( g->critter_by_id<npc>( id ), g->npc_lifetimes() );
}
bool is_host_waiting_for_client()
{
    return mp_session().host_waiting_for_clients;
}

bool client_acted_this_turn()
{
    return !remote_turns_pending();
}

bool partner_in_interactive_activity()
{
    return !mp_partner_observation().partner_activity.empty() &&
           !is_passive_activity( mp_partner_observation().partner_activity );
}

bool is_partner_in_wait_activity( character_id target )
{
    if( is_client_mode() ) {
        return is_wait_activity( mp_partner_observation( target ).partner_activity );
    }
    if( !target.is_valid() ) {
        if( const npc *partner = get_partner_npc() ) {
            target = partner->getID();
        }
    }
    auto *peer = mp_session().find_remote( target );
    const npc *actor = peer ? mp_remote_actor( *peer ) : nullptr;
    return actor && is_wait_activity( actor->activity.id().str() );
}

bool is_partner_helping( character_id helper, character_id worker )
{
    const player_id target = partner_identity( worker );
    if( !target.valid() || helper == worker ) {
        return false;
    }
    if( helper == get_avatar().getID() ) {
        return activity_help_target( get_avatar().activity ) == target.str();
    }
    const peer_observation &observation = mp_partner_observation( helper );
    return observation.partner_activity == "ACT_HELP_PARTNER" &&
           observation.partner_help_target == target.str();
}

bool start_helping_partner( character_id target )
{
    const npc *partner = get_partner_npc( target );
    const player_id identity = partner_identity( target );
    avatar &helper = get_avatar();
    if( !partner || !identity.valid() || !partner_activity_accepts_help( target ) ||
        partner->posz() != helper.posz() || rl_dist( partner->pos_abs(), helper.pos_abs() ) > 1 ) {
        return false;
    }
    const int total = partner_activity_moves_total( target );
    player_activity help( activity_id( "ACT_HELP_PARTNER" ), total > 0 ? total : 1'000'000 );
    help.str_values.push_back( identity.str() );
    helper.assign_activity( help );
    return true;
}

bool partner_activity_accepts_help( character_id target )
{
    // SP's helper system (get_crafting_helpers + skill/proficiency math)
    // engages for these activities.  ACT_READ is intentionally excluded:
    // its "learn alongside" semantics need a separate design pass.
    static const std::set<std::string> eligible = {
        "ACT_CRAFT",
        "ACT_LONG_CRAFT",
        "ACT_BUILD",
        "ACT_VEHICLE",
        "ACT_VEHICLE_REPAIR",
        "ACT_BUTCHER",
        "ACT_BUTCHER_FULL",
        "ACT_FIELD_DRESS",
        "ACT_QUARTER",
        "ACT_DISMEMBER",
        "ACT_SKIN",
        "ACT_DISASSEMBLE",
        "ACT_DISASSEMBLE_RECURSIVELY",
    };
    return eligible.count( mp_partner_observation( target ).partner_activity ) > 0;
}

int partner_activity_moves_total( character_id target )
{
    return mp_partner_observation( target ).partner_activity_moves_total;
}

int partner_activity_pct()
{
    if( get_avatar().activity.id().str() == "ACT_HELP_PARTNER" ) {
        const npc *target = helped_partner( get_avatar().activity );
        return target ? mp_partner_observation( target->getID() ).partner_activity_pct : 0;
    }
    return mp_partner_observation().partner_activity_pct;
}

bool mp_in_burst_mode()
{
    // Both sides committed to non-interactive activities (neither needs
    // user input this turn).  Skip the lockstep throttle so the calendar
    // doesn't crawl at 1 turn/sec when nobody is actually playing.
    if( !is_hosting() && !is_client_mode() ) {
        return false;
    }
    if( !get_avatar().activity ) {
        return false;
    }
    if( mp_partner_observation().partner_activity.empty() ) {
        return false;
    }
    return true;
}

// Compute a 0–100 progress percent for an arbitrary player_activity.  Most
// actors populate moves_total + moves_left, but a few (craft, vehicle) leave
// moves_total at 0 and track progress elsewhere.  This helper hides those
// special cases so the wire field `*_activity_pct` reflects what the player
// sees in their wait popup, not 0%.
static int mp_compute_activity_pct( const player_activity &act )
{
    if( !act ) {
        return 0;
    }
    // Helper activity: mirror the partner's reported progress so both sides
    // display the same percent.  ACT_HELP_PARTNER uses a long fallback
    // duration on assign (since craft/vehicle leave moves_total=0), which
    // would otherwise read 1% throughout the entire help.  Check this BEFORE
    // the moves_total branch.
    static const activity_id ACT_HELP_PARTNER_ID( "ACT_HELP_PARTNER" );
    if( act.id() == ACT_HELP_PARTNER_ID ) {
        const npc *target = helped_partner( act );
        return target ? mp_partner_observation( target->getID() ).partner_activity_pct : 0;
    }
    // Standard path — works for ACT_WAIT and any other actor that sets
    // moves_total properly.
    if( act.moves_total > 0 ) {
        const int done = act.moves_total - act.moves_left;
        return std::clamp( done * 100 / act.moves_total, 0, 100 );
    }
    // Crafting: progress lives in the craft item's item_counter (scale of
    // 100,000 per percent, max 10,000,000).  Same calculation as SP's
    // tname display (`"%s (%d%%)"`).
    static const activity_id ACT_CRAFT_ID( "ACT_CRAFT" );
    static const activity_id ACT_LONG_CRAFT_ID( "ACT_LONG_CRAFT" );
    if( act.id() == ACT_CRAFT_ID || act.id() == ACT_LONG_CRAFT_ID ) {
        if( !act.targets.empty() && act.targets[0] ) {
            const item *it = act.targets[0].get_item();
            if( it && it->is_craft() ) {
                return std::clamp( it->item_counter / 100000, 0, 100 );
            }
        }
    }
    // Construction: progress lives in the partial_con counter at the build tile
    // (same 10,000,000 = 100% scale as crafting), held in the build actor, not in
    // moves_total — which the actor pins to 1, so the moves_total branch reads 0%.
    static const activity_id ACT_BUILD_ID( "ACT_BUILD" );
    if( act.id() == ACT_BUILD_ID && act.actor ) {
        if( const auto *builder = dynamic_cast<const build_construction_activity_actor *>
                                  ( act.actor.get() ) ) {
            map &here = get_map();
            if( const partial_con *site = here.partial_con_at( here.get_bub( builder->location() ) ) ) {
                return std::clamp( site->counter / 100000, 0, 100 );
            }
        }
    }
    return 0;
}

// If our avatar is locally running ACT_HELP_PARTNER but the partner just
// finished / cancelled / switched to a non-helper-eligible activity, cancel
// our help commitment so we get our moves back and the SP helper bonus stops
// applying on their side.  Called from each wire-parse site that mutates
// g_partner_activity.  Safe to call when the avatar isn't helping (no-op).
static void mp_cancel_help_if_partner_done()
{
    avatar &av = get_avatar();
    if( !av.activity || av.activity.id().str() != "ACT_HELP_PARTNER" ) {
        return;
    }
    const npc *target = helped_partner( av.activity );
    if( target && partner_activity_accepts_help( target->getID() ) ) {
        return;
    }
    mp_log( "[cdda-mp] HELP-CANCEL: partner activity ended, dropping ACT_HELP_PARTNER" );
    add_msg( m_info, _( "Your partner finished — you stop helping." ) );
    av.cancel_activity();
}

bool tap_waiting_partner( const Character &who, Character &target )
{
    const character_action_guard lifetime( target );
    if( !lifetime || &who == &target || who.posz() != target.posz() ||
        rl_dist( who.pos_abs(), target.pos_abs() ) > 1 ||
        !is_wait_activity( target.activity.id().str() ) ) {
        return false;
    }
    const std::string name = who.get_name();
    const character_id id = target.getID();
    target.cancel_activity();
    if( lifetime ) {
        target.add_msg_if_player( _( "%s taps you on the shoulder, snapping you out of your wait." ), name );
        if( auto *peer = mp_session().find_remote( id ) ) {
            peer->observation.partner_activity = target.activity ? target.activity.id().str() : "";
            if( const auto server = get_active_server() ) {
                server->post_send( peer->admission, serialize_remote_player_state( *peer ) + "\n" );
            }
        }
    }
    return true;
}

void mark_partner_swap_pending( character_id target )
{
    if( auto *recipient = mp_session().find_remote( target ) ) {
        recipient->turn.pending_partner_swap = true;
        recipient->turn.swap_from = get_avatar().name;
    }
}
void mark_partner_push_pending( character_id target )
{
    if( auto *recipient = mp_session().find_remote( target ) ) {
        recipient->turn.pending_partner_push = true;
        recipient->turn.push_from = get_avatar().name;
    }
}
npc *get_partner_npc( character_id target )
{
    if( is_client_mode() ) {
        npc *nearest = mp_host_view_actor();
        if( target.is_valid() && nearest && nearest->getID() == target ) {
            return nearest;
        }
        for( const auto &entry : mp_session().client_player_views ) {
            npc *actor = mp_loaded_actor( entry.second->actor );
            if( target.is_valid() && actor && actor->getID() == target ) {
                return actor;
            }
            if( actor && ( !nearest || rl_dist( actor->pos_abs(), get_avatar().pos_abs() ) <
                           rl_dist( nearest->pos_abs(), get_avatar().pos_abs() ) ) ) {
                nearest = actor;
            }
        }
        return target.is_valid() ? nullptr : nearest;
    }
    if( target.is_valid() ) {
        auto *recipient = mp_session().find_remote( target );
        return recipient ? mp_remote_actor( *recipient ) : nullptr;
    }
    npc *nearest = nullptr;
    for( const auto &entry : mp_session().remote_players ) {
        cata_mp::remote_player_session &recipient = *entry.second;
        if( !recipient.connected || recipient.detach_pending ) {
            continue;
        }
        npc *actor = mp_remote_actor( recipient );
        if( actor && ( !nearest || rl_dist( actor->pos_abs(), get_avatar().pos_abs() ) <
                       rl_dist( nearest->pos_abs(), get_avatar().pos_abs() ) ) ) {
            nearest = actor;
        }
    }
    return nearest;
}
bool is_partner_npc( character_id id )
{
    // Host side: the client's proxy is remote_player_npc_id.
    if( is_remote_player( id ) ) {
        return true;
    }
    return is_client_mode() && id == mp_session().client_host_actor.id() &&
           mp_session().client_host_actor.owns_instance( g->critter_by_id<npc>( id ),
                   g->npc_lifetimes() );
}

bool is_client_host_at( const tripoint_abs_ms &abs )
{
    if( !mp_session().client_host_spawned || !mp_session().client_host_actor.id().is_valid() ) {
        return false;
    }
    npc *hnpc = mp_host_view_actor();
    return hnpc && get_map().get_abs( hnpc->pos_bub() ) == abs;
}

bool client_suppress_self_gravity( const Character &who )
{
    if( !is_client_mode() || !who.is_avatar() ) {
        return false;
    }
    // The host already validated this z-transition on the proxy NPC (e.g. proxy
    // landed on a passable t_ramp_down_low) and dictated our new position via
    // teleport.  Our local map at the destination z is a lagging shadow that may
    // still read t_open_air, so trusting our own gravity check here means falling
    // through a bridge deck the host knows is solid.  Defer entirely to the host.
    mp_log( "[cdda-mp] gravity: suppressed client avatar self-fall at z=" +
            std::to_string( who.pos_abs().z() ) );
    return true;
}

void notify_client_host_died()
{
    auto srv = get_active_server();
    if( !srv ) {
        return;
    }
    srv->post_broadcast( "{\"type\":\"host_died\"}\n" );
    // Brief pause so the packet flushes before the death screen takes focus.
    std::this_thread::sleep_for( std::chrono::milliseconds( 200 ) );
}

// A guest's quicksave only stores their local exploration memory. The host
// handles the separate request to persist authoritative character and world state.
void mp_after_quicksave()
{
    if( is_host_mode() && is_hosting() ) {
        add_msg( m_good,
                 _( "The shared world and guest characters have been saved." ) );
    } else if( is_client_mode() ) {
        add_msg( m_info,
                 _( "Asking the host to save the shared world and your character…" ) );
        client_send( R"({"type":"action","action":"save_request"})" );
    }
}

void mp_notify_session_ending()
{
    if( is_host_mode() ) {
        auto srv = get_active_server();
        if( srv ) {
            srv->post_broadcast( "{\"type\":\"session_ending\",\"from\":\"host\"}\n" );
            mp_log( "[cdda-mp] SESSION-END: host notified client" );
        }
    } else if( is_client_mode() ) {
        // Wrapped as an action so handle_remote_action()'s dispatcher sees it.
        client_send( R"({"type":"action","action":"session_ending","from":"client"})" );
        mp_log( "[cdda-mp] SESSION-END: client notified host" );
    } else {
        return;
    }
    // Retain the existing grace interval for the session-ending notification.
    std::this_thread::sleep_for( std::chrono::milliseconds( 300 ) );

    // The owner does not return until the server worker and its transport
    // have stopped. No detached thread or timed polling may outlive the world.
    mp_session().hosting.stop();

    // Drop the co-op HUD so the next session re-creates it fresh.  g_mp_hud /
    // edge adaptors register against the current
    // screen; carrying them across a return-to-main-menu leaves stale adaptors
    // that never draw — no co-op panel / turn-stripes on a second session.
    mp_session().presentation.mp_edge.reset();
    mp_session().presentation.mp_hud.reset();
    mp_log( "[cdda-mp] SESSION-END: co-op HUD reset" );
}

// Enumerate `*.template` basenames in the user templates dir.
static std::vector<std::string> mp_local_template_names()
{
    std::vector<std::string> out;
    for( std::string p : get_files_from_path( ".template", PATH_INFO::templatedir(),
            false, true ) ) {
        p.erase( p.find( ".template" ), std::string::npos );
        p.erase( 0, p.find_last_of( "\\/" ) + 1 );
        out.push_back( p );
    }
    return out;
}

// Pick the right transport for outgoing MP messages from this side.  Both
// templates messages and the join-time list go through here so we don't keep
// branching on host/client at every send site.
static void mp_send_payload( const std::string &payload, const peer_admission &recipient )
{
    if( is_host_mode() ) {
        auto srv = get_active_server();
        if( srv ) {
            srv->post_send( recipient, payload + "\n" );
        }
    } else if( is_client_mode() ) {
        client_send( payload );
    }
}

static void mp_templates_sync_on_join( const peer_admission &recipient )
{
    const std::vector<std::string> names = mp_local_template_names();
    std::ostringstream oss;
    {
        JsonOut jo( oss );
        jo.start_object();
        jo.member( "type", "templates_list" );
        jo.member( "names", names );
        jo.end_object();
    }
    mp_send_payload( oss.str(), recipient );
    mp_log( "[cdda-mp] TEMPLATES: sent list, n=" + std::to_string( names.size() ) );
}


void mp_templates_sync_on_join()
{
    if( is_client_mode() ) {
        mp_templates_sync_on_join( {} );
    }
}
static void mp_handle_templates_list( const std::string &msg, const peer_admission &recipient )
{
    try {
        JsonValue jv = json_loader::from_string( msg );
        JsonObject jo = jv.get_object();
        jo.allow_omitted_members();
        if( !jo.has_array( "names" ) ) {
            return;
        }
        std::set<std::string> local;
        for( const std::string &n : mp_local_template_names() ) {
            local.insert( n );
        }
        std::vector<std::string> missing;
        for( const JsonValue &v : jo.get_array( "names" ) ) {
            const std::string n = v.get_string();
            if( local.find( n ) == local.end() ) {
                missing.push_back( n );
            }
        }
        if( missing.empty() ) {
            mp_log( "[cdda-mp] TEMPLATES: nothing to request from partner" );
            return;
        }
        std::ostringstream oss;
        {
            JsonOut out( oss );
            out.start_object();
            out.member( "type", "template_request" );
            out.member( "names", missing );
            out.end_object();
        }
        mp_send_payload( oss.str(), recipient );
        mp_log( "[cdda-mp] TEMPLATES: requested " + std::to_string( missing.size() ) );
    } catch( const JsonError &e ) {
        mp_log( "[cdda-mp] TEMPLATES list parse error: " + std::string( e.what() ) );
    }
}

static void mp_handle_template_request( const std::string &msg, const peer_admission &recipient )
{
    try {
        JsonValue jv = json_loader::from_string( msg );
        JsonObject jo = jv.get_object();
        jo.allow_omitted_members();
        if( !jo.has_array( "names" ) ) {
            return;
        }
        int sent = 0;
        for( const JsonValue &v : jo.get_array( "names" ) ) {
            const std::string name = v.get_string();
            const std::string path = PATH_INFO::templatedir() + name + ".template";
            std::optional<std::string> content = read_whole_file( path );
            if( !content ) {
                mp_log( "[cdda-mp] TEMPLATES: requested template missing locally: " + name );
                continue;
            }
            std::ostringstream oss;
            {
                JsonOut out( oss );
                out.start_object();
                out.member( "type", "template_data" );
                out.member( "name", name );
                out.member( "content", *content );
                out.end_object();
            }
            mp_send_payload( oss.str(), recipient );
            ++sent;
        }
        mp_log( "[cdda-mp] TEMPLATES: sent " + std::to_string( sent ) + " requested" );
    } catch( const JsonError &e ) {
        mp_log( "[cdda-mp] TEMPLATES request parse error: " + std::string( e.what() ) );
    }
}

static void mp_handle_template_data( const std::string &msg )
{
    try {
        JsonValue jv = json_loader::from_string( msg );
        JsonObject jo = jv.get_object();
        jo.allow_omitted_members();
        const std::string name = jo.get_string( "name", "" );
        const std::string content = jo.get_string( "content", "" );
        if( name.empty() || content.empty() ) {
            return;
        }
        const std::string path = PATH_INFO::templatedir() + name + ".template";
        // Local-wins on name collision so a player can't have their custom
        // template silently replaced by a partner's same-named one.
        if( file_exist( path ) ) {
            mp_log( "[cdda-mp] TEMPLATES: skip overwrite of existing: " + name );
            return;
        }
        const bool ok = write_to_file( path, [&]( std::ostream & out ) {
            out << content;
        }, _( "received template" ) );
        if( ok ) {
            mp_log( "[cdda-mp] TEMPLATES: wrote received '" + name + "'" );
        }
    } catch( const JsonError &e ) {
        mp_log( "[cdda-mp] TEMPLATES data parse error: " + std::string( e.what() ) );
    }
}

static void mp_start_pending_host()
{
    if( !g_pending_host_start ) {
        return;
    }
    const host_request request = std::move( *g_pending_host_start );
    g_pending_host_start.reset();
    try {
        if( !world_generator || !world_generator->active_world ) {
            throw std::runtime_error( "No active world" );
        }
        WORLD &world = *world_generator->active_world;
        const tripoint_abs_omt location = get_avatar().pos_abs_omt();
        mp_session().host_info = {
            world.world_name, get_avatar().name, g->get_seed(),
            std::array<int, 3>{ location.x(), location.y(), location.z() }, world.identity()
        };
    } catch( const std::exception &error ) {
        add_msg( m_bad, _( "Unable to start multiplayer host: %s" ), error.what() );
        set_host_mode( false );
        return;
    }
    if( !mp_session().hosting.start( request.port, request.password, request.version,
                                     mp_session().host_info ) ) {
        mp_log( "[ccb-mp] HOST-START failed: " + mp_session().hosting.error() );
        add_msg( m_bad, _( "Unable to start multiplayer host: %s" ), mp_session().hosting.error() );
        set_host_mode( false );
    }
}

bool mp_request_host_session( uint16_t port, const std::string &password,
                              const std::string &version )
{
    if( is_client_mode() ) {
        return false;
    }
    if( mp_session().hosting.running() ) {
        return true;
    }
    set_host_mode( true );
    g_pending_host_start = host_request{ port, password, version };
    return true;
}

bool mp_menu_start_host_session()
{
    return mp_request_host_session( 8080, "", getVersionString() );
}

void mp_menu_cancel_host()
{
    g_pending_host_start.reset();
    mp_session().hosting.stop();
    set_host_mode( false );
}

bool mp_close_host_session()
{
    if( !is_host_mode() || is_client_mode() || is_server_mode() || g->uquit != QUIT_NO ||
        !world_generator || !world_generator->active_world || !g->save() ) {
        return false;
    }

    // Save with the actors still bound. If any save step fails, they retain
    // control and the owner can retry without discarding unsaved progress.
    mp_notify_session_ending();
    for( auto it = mp_session().remote_players.begin(); it != mp_session().remote_players.end(); ) {
        remote_player_session &guest = *it++->second;
        release_remote_player( guest );
    }
    mp_on_world_exit();
    g->unload_creatures_outside_resident_maps();
    g->invalidate_main_ui_adaptor();
    return true;
}

void mp_open_session_menu()
{
    if( is_client_mode() || is_server_mode() || g->uquit != QUIT_NO ||
        !world_generator || !world_generator->active_world ) {
        return;
    }
    uilist menu;
    menu.title = _( "Co-op session" );
    constexpr int change_mode = 1;
    const bool hosting = is_host_mode();
    menu.addentry( change_mode, true, hosting ? 's' : 'h',
                   hosting ? _( "Close room and continue solo" ) : _( "Open this world to co-op" ) );
    menu.query();
    if( menu.ret != change_mode ) {
        return;
    }
    if( hosting ) {
        if( query_yn( _( "Save the world, disconnect the guests and continue solo?" ) ) &&
            mp_close_host_session() ) {
            add_msg( m_good, _( "Co-op room closed.  Continuing solo." ) );
        }
    } else if( mp_menu_start_host_session() ) {
        mp_start_pending_host();
        if( is_hosting() ) {
            mp_world_marker_update();
            ensure_mp_hud();
            add_msg( m_good, _( "Co-op room open on port 8080." ) );
        }
    }
}

void mp_tick_proxy_activity( npc &guy )
{
    // No activity → nothing to do.  Most turns this is the no-op path.
    if( !guy.activity || owns_inventory_activity( guy ) ) {
        return;
    }
    // Give the activity a single step's worth of move budget so per-item
    // costs in move_items_activity_actor::do_turn (and similar) can charge
    // and exit at moves<=0.  Save+restore around the call so subsequent
    // move-handler logic isn't surprised by an unexpected proxy moves value.
    const int saved = guy.get_moves();
    guy.set_moves( 100 );
    const std::string before = guy.activity ? guy.activity.id().str() : std::string( "none" );
    guy.activity.do_turn( guy );
    const std::string after = guy.activity ? guy.activity.id().str() : std::string( "none" );
    guy.set_moves( saved );
    mp_log( "[cdda-mp] PROXY-ACT-TICK: proxy '" + guy.name +
            "' before=" + before + " after=" + after +
            " hauling=" + std::to_string( guy.is_hauling() ) +
            " haul_list_size=" + std::to_string( guy.haul_list.size() ) );
}

// Co-op section appended to the debug "Generate game report" output (debug.cpp).
// Surfaces the fork identity + co-op session state + log locations so a pasted
// report tells us everything we need to triage a multiplayer bug.
std::string mp_game_report_section()
{
    std::string s;
    s += "- Co-op Fork: Cataclysm-DDA Multiplayer (busterbogheart/Cataclysm-DDA-multi)\n";
    const char *role = is_client_mode() ? "Client (joined a host)"
                       : ( is_host_mode() ? "Host (running a session)"
                           : "Single-player (not in a co-op session)" );
    s += std::string( "- Co-op Role: " ) + role + "\n";
    if( is_client_mode() ) {
        const std::string hp = mp_client_host_player_name();
        const std::string hw = mp_client_host_world_name();
        s += "- Co-op Partner (host): " + ( hp.empty() ? std::string( "<unknown>" ) : hp )
             + ( hw.empty() ? std::string() : "  (world: " + hw + ")" ) + "\n";
    } else if( is_host_mode() ) {
        s += "- Co-op Partner (client): "
             + ( mp_partner_observation().partner_name_cached.empty() ? std::string( "<none connected>" )
                 : mp_partner_observation().partner_name_cached ) + "\n";
    }
#if defined(_WIN32)
    s += "- Co-op Logs (attach to bug reports): %USERPROFILE%\\cdda-mp-server.log (host) / "
         "%USERPROFILE%\\cdda-mp-client.log (client)\n";
#else
    s += "- Co-op Logs (attach to bug reports): /tmp/cdda-mp-server.log (host) / "
         "/tmp/cdda-mp-client.log (client)\n";
#endif
    s += "- Co-op Note: both players must run the SAME Game Version listed above; "
         "mismatched builds are rejected at join.\n";
    return s;
}

WORLD *mp_ensure_client_scratch_world()
{
    // Leading underscore is rejected by worldfactory's lexical validity
    // check, so use a friendly name we'd also be happy showing to the user.
    // Auto-created throwaway world the client spawns into before teleporting to
    // the host.  Named to make it obvious in the world menu that it's internal
    // and must not be hand-selected.  (ASCII only — this becomes a directory.)
    static const std::string SCRATCH_NAME = "Co-op (auto) - DO NOT SELECT";
    if( world_generator->has_world( SCRATCH_NAME ) ) {
        return world_generator->get_world( SCRATCH_NAME );
    }
    const std::vector<mod_id> default_mods = { mod_id( "ccb" ) };
    WORLD *neww = world_generator->make_new_world( SCRATCH_NAME, default_mods );
    if( neww ) {
        mp_log( "[cdda-mp] MENU: created client scratch world '" + SCRATCH_NAME + "'" );
    } else {
        mp_log( "[cdda-mp] MENU: failed to create client scratch world" );
    }
    return neww;
}

bool mp_world_coop_block( const std::string &worldname,
                          std::vector<std::string> &block_reasons,
                          std::vector<std::string> &warn_reasons )
{
    WORLD *w = world_generator->get_world( worldname );
    if( !w ) {
        return false;
    }
    // Mods: incompatible -> block, warn -> warn.  Mirrors the create-screen mod
    // list (worldfactory.cpp), which colors/blocks the same set — this catches
    // worlds built outside that screen via World > Create World.
    for( const mod_id &m : w->active_mod_order ) {
        const std::string disp = m.is_valid() ? m->name() : m.str();
        switch( mod_coop_status( m.str() ) ) {
            case mod_coop::incompatible:
                block_reasons.push_back(
                    string_format( _( "Mod \"%s\" is not co-op compatible." ), disp ) );
                break;
            case mod_coop::warn:
                warn_reasons.push_back(
                    string_format( _( "Mod \"%s\" may break in co-op." ), disp ) );
                break;
            default:
                break;
        }
    }
    // Random NPCs: the co-op create-screen locks the "Random NPCs" slider to its
    // lowest level, which sets NPC_SPAWNTIME = 10 ("Where is everyone?").  A
    // standalone world keeps the default (4) or a higher spawn rate.  Note the
    // sense of the value: LARGER NPC_SPAWNTIME = rarer NPCs, and 0 means random
    // NPCs are fully off (game::perhaps_add_random_npc early-returns).  So a
    // world spawns more random NPCs than co-op allows iff 0 < spawn_time < 10.
    // Random NPCs aren't synced to the other player yet, so warn (per design).
    const auto it = w->WORLD_OPTIONS.find( "NPC_SPAWNTIME" );
    if( it != w->WORLD_OPTIONS.end() ) {
        float spawn_time = 0.0f;
        try {
            spawn_time = std::stof( it->second.getValue() );
        } catch( ... ) {
            spawn_time = 0.0f;
        }
        if( spawn_time > 0.0f && spawn_time < 10.0f ) {
            warn_reasons.emplace_back(
                _( "Random NPCs are enabled — co-op can't sync them to the other player yet." ) );
        }
    }
    return !block_reasons.empty();
}

// Returns the path to a world's mp_world.json sidecar.  Empty when the
// named world doesn't exist (e.g. picker is looking at a stale name).
static cata_path mp_world_marker_path( const std::string &worldname )
{
    WORLD *w = world_generator->get_world( worldname );
    if( !w ) {
        return cata_path();
    }
    return w->folder_path() / "mp_world.json";
}

mp_world_marker mp_world_marker_load( const std::string &worldname )
{
    mp_world_marker m;
    const cata_path path = mp_world_marker_path( worldname );
    if( path.get_unrelative_path().empty() ) {
        return m;
    }
    read_from_file_optional_json( path, [&]( const JsonValue & jv ) {
        JsonObject jo = jv.get_object();
        m.first_seen_iso = jo.get_string( "first_seen_iso", std::string() );
        m.last_seen_iso  = jo.get_string( "last_seen_iso",  std::string() );
        m.last_role      = jo.get_string( "last_role",      std::string() );
    } );
    return m;
}

static void mp_world_marker_save( const std::string &worldname,
                                  const mp_world_marker &m )
{
    const cata_path path = mp_world_marker_path( worldname );
    if( path.get_unrelative_path().empty() ) {
        return;
    }
    write_to_file( path, [&]( std::ostream & fout ) {
        JsonOut jo( fout );
        jo.start_object();
        jo.member( "first_seen_iso", m.first_seen_iso );
        jo.member( "last_seen_iso",  m.last_seen_iso );
        jo.member( "last_role",      m.last_role );
        jo.end_object();
    }, "mp world marker" );
}

bool mp_world_has_history( const std::string &worldname )
{
    WORLD *w = world_generator->get_world( worldname );
    if( !w ) {
        return false;
    }
    const cata_path folder = w->folder_path();
    // Primary marker.
    if( file_exist( folder / "mp_world.json" ) ) {
        return true;
    }
    // Fallback for worlds that pre-date the marker: any mp_player_*.json
    // or mp_npc_cleanup.json sitting in the world folder is a tell.
    if( file_exist( folder / "mp_npc_cleanup.json" ) ) {
        return true;
    }
    const std::vector<cata_path> players = get_files_from_path(
            "mp_player_", folder, false, false );
    return !players.empty() || !get_files_from_path( "mp_actor_", folder, false, false ).empty();
}

std::string mp_world_marker_badge( const std::string &worldname )
{
    if( !mp_world_has_history( worldname ) ) {
        return std::string();
    }
    const mp_world_marker m = mp_world_marker_load( worldname );
    std::string body = "co-op";
    if( !m.last_role.empty() ) {
        body += ", " + m.last_role;
    }
    return "  (" + body + ")";
}

bool mp_load_promote_prompt( const std::string &worldname )
{
    if( !mp_world_has_history( worldname ) ) {
        return true;
    }
    // If already armed/connected from a previous menu interaction, no point
    // re-prompting — just continue.
    if( is_host_mode() || is_client_mode() ) {
        return true;
    }
    uilist menu;
    menu.title = _( "This world has co-op history" );
    menu.text = _( "Load as solo, or arm Host so your partner can Join?" );
    // Distinct positive retvals + an explicit cancel sentinel.  Avoids any
    // ambiguity with uilist's own UILIST_CANCEL (-1027) on ESC.
    constexpr int RET_SOLO = 1;
    constexpr int RET_HOST = 2;
    constexpr int RET_CANCEL = 3;
    menu.entries.emplace_back( RET_SOLO,   true, 's', _( "Load solo" ) );
    menu.entries.emplace_back( RET_HOST,   true, 'h', _( "Arm Host (co-op)" ) );
    menu.entries.emplace_back( RET_CANCEL, true, 'q', _( "Cancel" ) );
    menu.query();
    if( menu.ret == RET_SOLO ) {
        mp_log( "[cdda-mp] promote-prompt: solo for " + worldname );
        return true;
    }
    if( menu.ret == RET_HOST ) {
        mp_log( "[cdda-mp] promote-prompt: arm host for " + worldname );
        mp_menu_start_host_session();
        return true;
    }
    mp_log( "[cdda-mp] promote-prompt: cancel for " + worldname + " (ret=" + std::to_string(
                menu.ret ) + ")" );
    return false;
}

void mp_world_marker_update()
{
    if( !is_host_mode() && !is_client_mode() ) {
        return;
    }
    if( !world_generator || !world_generator->active_world ) {
        return;
    }
    const std::string &worldname = world_generator->active_world->world_name;
    if( worldname.empty() ) {
        return;
    }
    // One write per loaded-world lifetime, including reloading the same world.
    if( mp_session().last_marked_world == worldname ) {
        return;
    }
    mp_session().last_marked_world = worldname;

    // Local-time string is fine; mp_world.json is human-readable, not parsed
    // for arithmetic.
    const std::time_t now = std::time( nullptr );
    char buf[32] = {0};
    ( void )std::strftime( buf, sizeof( buf ), "%Y-%m-%d %H:%M:%S",
                           std::localtime( &now ) );
    const std::string now_iso( buf );

    mp_world_marker m = mp_world_marker_load( worldname );
    if( m.first_seen_iso.empty() ) {
        m.first_seen_iso = now_iso;
    }
    m.last_seen_iso = now_iso;
    m.last_role = is_host_mode() ? "host" : "client";
    mp_world_marker_save( worldname, m );
    mp_log( "[cdda-mp] world-marker: wrote " + worldname + " as " + m.last_role );
}

static cata_path mp_recent_hosts_path()
{
    return PATH_INFO::config_dir_path() / "mp_recent_hosts.json";
}

std::vector<mp_recent_host> mp_recent_hosts_load()
{
    std::vector<mp_recent_host> out;
    read_from_file_optional_json( mp_recent_hosts_path(), [&]( const JsonValue & jv ) {
        JsonObject jo = jv.get_object();
        if( !jo.has_array( "hosts" ) ) {
            return;
        }
        for( JsonObject e : jo.get_array( "hosts" ) ) {
            mp_recent_host rh;
            rh.host = e.get_string( "host", std::string() );
            rh.port = static_cast<uint16_t>( e.get_int( "port", 8080 ) );
            rh.label = e.get_string( "label", std::string() );
            if( !rh.host.empty() ) {
                out.push_back( std::move( rh ) );
            }
        }
    } );
    return out;
}

void mp_recent_hosts_save( const std::vector<mp_recent_host> &hosts )
{
    write_to_file( mp_recent_hosts_path(), [&]( std::ostream & fout ) {
        JsonOut jo( fout );
        jo.start_object();
        jo.member( "hosts" );
        jo.start_array();
        for( const mp_recent_host &h : hosts ) {
            jo.start_object();
            jo.member( "host", h.host );
            jo.member( "port", static_cast<int>( h.port ) );
            jo.member( "label", h.label );
            jo.end_object();
        }
        jo.end_array();
        jo.end_object();
    }, "mp recent hosts" );
}

void mp_recent_hosts_remember( const std::string &host, uint16_t port,
                               const std::string &label )
{
    constexpr size_t MP_RECENT_HOSTS_CAP = 8;
    std::vector<mp_recent_host> list = mp_recent_hosts_load();
    std::string preserved_label = label;
    auto same = [&]( const mp_recent_host & h ) {
        return h.host == host && h.port == port;
    };
    auto it = std::find_if( list.begin(), list.end(), same );
    if( it != list.end() ) {
        if( preserved_label.empty() ) {
            preserved_label = it->label;
        }
        list.erase( it );
    }
    list.insert( list.begin(), mp_recent_host{ host, port, preserved_label } );
    if( list.size() > MP_RECENT_HOSTS_CAP ) {
        list.resize( MP_RECENT_HOSTS_CAP );
    }
    mp_recent_hosts_save( list );
}

// Parse "host[:port]" into separate host + port.  Returns false (and pops an
// error) on a malformed port; default port is 8080.
static bool mp_parse_address( const std::string &entered, std::string &host,
                              uint16_t &port )
{
    host = entered;
    port = 8080;
    const size_t colon = entered.rfind( ':' );
    if( colon != std::string::npos ) {
        host = entered.substr( 0, colon );
        try {
            port = static_cast<uint16_t>( std::stoi( entered.substr( colon + 1 ) ) );
        } catch( const std::exception & ) {
            popup( _( "Invalid port in '%s'." ), entered.c_str() );
            return false;
        }
    }
    return true;
}

bool mp_menu_join_session()
{
    if( is_client_mode() ) {
        // Already connected — treat as success so caller can drive the
        // next UI step (char-creation flow).
        return true;
    }

    std::vector<mp_recent_host> recent = mp_recent_hosts_load();
    std::string entered;
    std::string label_in;       // existing label if user picked from history
    if( !recent.empty() ) {
        uilist menu;
        menu.title = _( "Co-op: join a session" );
        int idx = 0;
        for( const mp_recent_host &rh : recent ) {
            std::string display = rh.host + ":" + std::to_string( rh.port );
            if( !rh.label.empty() ) {
                display = rh.label + "  —  " + display;
            }
            menu.entries.emplace_back( idx++, true, MENU_AUTOASSIGN, display );
        }
        const int new_addr_idx = idx;
        menu.entries.emplace_back( new_addr_idx, true, 'n', _( "Enter new address…" ) );
        menu.entries.emplace_back( -1, true, 'q', _( "Cancel" ) );
        menu.query();
        if( menu.ret < 0 ) {
            return false;
        }
        if( menu.ret < static_cast<int>( recent.size() ) ) {
            const mp_recent_host &rh = recent[menu.ret];
            entered = rh.host + ":" + std::to_string( rh.port );
            label_in = rh.label;
        }
        // else: "Enter new address" — fall through to the input popup
    }
    if( entered.empty() ) {
        entered = string_input_popup()
                  .title( _( "Host address  (e.g. 192.168.1.5  or  100.64.0.5:8080)" ) )
                  .width( 40 )
                  .query_string();
        if( entered.empty() ) {
            return false;
        }
    }

    std::string host;
    uint16_t port = 8080;
    if( !mp_parse_address( entered, host, port ) ) {
        return false;
    }
    // The Renet handshake below includes the bounded UDP connection attempt.
    set_client_mode( true );
    if( !client_connect( host, port, "player2", std::string(), getVersionString() ) ) {
        const std::string err = client_connect_error();
        popup( "%s", err.empty()
               ? string_format( _( "Could not connect to %s:%d." ), host, static_cast<int>( port ) ).c_str()
               : err.c_str() );
        set_client_mode( false );
        return false;
    }
    mp_log( "[cdda-mp] MENU: client connected to " + host + ":" + std::to_string( port ) );
    // Log the running binary's exact version (the string the join handshake
    // sends) so the client log shows what's actually executing — catches the
    // host/client commit-mismatch that strands a client in its own world.
    mp_log( std::string( "[cdda-mp] VERSION=" ) + getVersionString() + " (role=CLIENT)" );
    // Only ask for a label the first time we see this address.  Skipping is
    // fine — the address alone is also a useful identifier.
    std::string label_out = label_in;
    if( label_in.empty() ) {
        label_out = string_input_popup()
                    .title( _( "Save as (optional label, e.g. 'Intel Mac' — blank to skip)" ) )
                    .width( 30 )
                    .query_string();
    }
    mp_recent_hosts_remember( host, port, label_out );
    return true;
}

std::string mp_menu_coop_status_text()
{
    if( is_host_mode() ) {
        if( g_pending_host_start ) {
            return std::string( _( "Co-op: armed — re-enter Host to pick world / character" ) );
        }
        return std::string( _( "Co-op: hosting on port 8080 — waiting for partner" ) );
    }
    if( is_client_mode() ) {
        return std::string( _( "Co-op: connected to host — re-enter Join to pick character" ) );
    }
    return std::string();
}

void process_mp_events()
{
    if( mp_session().refreshing_regions || ( is_hosting() && &get_map() != &reality_bubble() ) ) {
        return;
    }
    // Menu and CLI hosting both start on the first world turn, after the
    // avatar exists and an incoming client can be spawned into the world.
    mp_start_pending_host();

    // Client: drain a budget of queued overmap-sync cells this turn (no-op when
    // nothing is pending). Keeps the ~32k-cell apply off the single-frame hot path.
    mp_drain_pending_omsync();

    // Stamp this world as MP-touched so the world pickers can badge it.
    mp_world_marker_update();
    refresh_resident_regions();

    // Queue depth is intentionally capped at 1 game-turn action per call.
    // Draining the whole queue in a loop caused unexpected back-to-back move
    // execution when network timing let two packets arrive before
    // process_mp_events() ran.
    // Bookkeeping can drain after an action, but cannot overtake the next
    // queued action. Attached tile deltas never exempt a gameplay action from
    // this budget. Keep a deferred action queued instead of dropping it.
    // TODO(roadmap): real multi-depth queue for lockstep relaxation / input
    // buffering — see ROADMAP.md "Action queue depth"
    mp_event event;
    std::set<uint64_t> acted_peers;
    bool state_sync = false;
    size_t drained_events = 0;
    size_t drained_bytes = 0;
    constexpr size_t max_drain_events = 64;
    constexpr size_t max_drain_bytes = 1024 * 1024;
    const auto can_drain = [&]( const mp_event & queued ) {
        // Let one large packet make progress, then yield. Count stale and
        // bookkeeping events too; neither may monopolize the owner thread.
        if( drained_events >= max_drain_events ||
            ( drained_events > 0 &&
              queued.data.size() > max_drain_bytes - std::min( drained_bytes, max_drain_bytes ) ) ) {
            return false;
        }
        state_sync = false;
        if( queued.evt_type != mp_event::type::action ||
            !mp_session().accepts_remote_event( queued.admission ) ) {
            return true;
        }
        state_sync = is_state_sync_message( queued.data );
        return acted_peers.count( queued.admission.peer_id() ) == 0 || state_sync;
    };
    while( get_mp_queue().pop_if( event, can_drain ) ) {
        ++drained_events;
        drained_bytes += event.data.size();
        // A late disconnect/action from a former transport peer must not act on
        // the currently bound character. Display names are not connection IDs.
        remote_player_session *recipient = mp_session().find_remote( event.admission );
        if( event.evt_type != mp_event::type::connect && !recipient ) {
            continue;
        }
        if( event.evt_type == mp_event::type::action ) {
            // Already admitted actions precede the disconnect in this queue.
            // Preserve that order even after transport retirement; exact
            // admission matching rejects them after detach or replacement.
            mp_log( "[cdda-mp] process_mp_events: " + event.data.substr( 0, 60 ) );
        }
        switch( event.evt_type ) {
            case mp_event::type::connect:
                if( event.admission.active() ) {
                    try {
                        spawn_remote_player( event.display_name, event.admission, event.player );
                    } catch( const std::exception & ) {
                        if( const auto server = get_active_server() ) {
                            server->post_reject( event.admission,
                                                 "Could not restore player identity; host must check the saved character" );
                        }
                        add_msg( m_bad,
                                 _( "Multiplayer join rejected: identity, saved character, or legacy association failed.  No saved character was replaced." ) );
                    }
                }
                break;
            case mp_event::type::disconnect:
                remove_remote_player( *recipient );
                break;
            case mp_event::type::action:
                handle_remote_action( *recipient, event.display_name, event.data );
                if( !state_sync ) {
                    acted_peers.insert( event.admission.peer_id() );
                }
                break;
        }
        refresh_resident_regions();
    }
}

void process_session_turn()
{
    process_mp_events();

    if( is_client_mode() ) {
        client_process_incoming();
    }

    if( is_hosting() ) {
        grant_client_turn();
    }

    if( is_client_mode() || is_host_mode() ) {
        ensure_mp_hud();
    }
}

static void apply_monster_sync( JsonObject &jo );
static void apply_tile_changes( JsonObject &jo );
static void apply_vehicle_sync( JsonObject &jo );

static void apply_pending_terrain()
{
    map &terrain = get_map();
    auto &pending = mp_session().replication.client.pending_terrain;
    for( auto it = pending.begin(); it != pending.end(); ) {
        const tripoint_abs_sm &position = it->first;
        if( !terrain.has_loaded_submap( position ) ) {
            ++it;
            continue;
        }
        const auto &chunk = it->second;
        const tripoint_bub_ms origin = terrain.get_bub( project_to<coords::ms>( position ) );
        for( int y = 0; y < SEEY; ++y ) {
            for( int x = 0; x < SEEX; ++x ) {
                const tripoint_bub_ms local = origin + point( x, y );
                const int index = y * SEEX + x;
                terrain.ter_set( local, chunk.terrain[index] );
                terrain.furn_set( local, chunk.furniture[index], false, false, true );
            }
        }
        it = pending.erase( it );
        g->invalidate_main_ui_adaptor();
    }
}

// Replica position comes from the authenticated server. Load the window,
// install its terrain, and only then put the avatar on the destination tile.
static void client_teleport_avatar( const tripoint_abs_ms &abs_pos )
{
    avatar &u = get_avatar();
    map &terrain = get_map();
    if( !terrain.inbounds_z( abs_pos.z() ) ) {
        return;
    }
    const tripoint_abs_sm center = project_to<coords::sm>( abs_pos );
    const tripoint_abs_sm origin = center - point_rel_sm( HALF_MAPSIZE, HALF_MAPSIZE );
    if( !terrain.has_loaded_submap( center ) ) {
        mp_client_apply_host_seed();
        g->place_player_overmap( project_to<coords::omt>( abs_pos ), false );
    }
    if( !terrain.has_loaded_submap( center ) ) {
        return;
    }
    if( terrain.get_abs_sub().z() != abs_pos.z() ) {
        terrain.vertical_shift( abs_pos.z() );
    }
    const point_rel_sm displacement = origin.xy() - terrain.get_abs_sub().xy();
    for( point_rel_sm remaining = displacement; remaining != point_rel_sm::zero; ) {
        const point_rel_sm step( std::clamp( remaining.x(), -1, 1 ),
                                 std::clamp( remaining.y(), -1, 1 ) );
        terrain.shift( step );
        remaining -= step;
    }
    apply_pending_terrain();
    if( u.pos_abs() != abs_pos ) {
        u.setpos( terrain, terrain.get_bub( abs_pos ), false );
    }
    auto &pending = mp_session().replication.client.pending_terrain;
    for( auto it = pending.begin(); it != pending.end(); ) {
        const point_abs_sm p = it->first.xy();
        const bool nearby = square_dist( p, center.xy() ) <= MAPSIZE;
        it = nearby ? std::next( it ) : pending.erase( it );
    }
    mp_session().replication.client.position_received = true;
}

static void update_client_host_npc( const tripoint_abs_ms &abs_pos, const std::string &name,
                                    bool host_in_vehicle, bool host_ctrl_veh )
{
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    map &m = get_map();

    if( !mp_session().client_host_spawned ) {
        shared_ptr_fast<npc> host_npc = make_shared_fast<npc>();
        host_npc->normalize();
        host_npc->setID( g->assign_npc_id() );
        host_npc->set_value( "mp_proxy", std::string( "1" ) );
        host_npc->name = name.empty() ? "host" : name;
        host_npc->spawn_at_precise( abs_pos );
        overmap_buffer.insert_npc( host_npc );
        g->load_npcs();
        mp_session().client_host_actor.bind_view( *host_npc, g->npc_lifetimes() );
        mp_session().client_host_spawned = true;

        // Apply ally status AFTER load_npcs so the NPC is fully wired into the
        // game state (faction manager, critter tracker, etc.).
        npc *hn = mp_host_view_actor();
        if( hn ) {
            hn->set_attitude( NPCATT_FOLLOW );
            hn->set_fac( faction_id( "your_followers" ) );
            hn->chatbin.first_topic = "TALK_FRIEND";
            hn->op_of_u.trust = 10;
            hn->op_of_u.value = 10;
            g->add_npc_follower( hn->getID() );
        }
        mp_log( "[cdda-mp] HOST-OVERLAY: spawned host NPC '" + host_npc->name +
                "' at abs " + abs_pos.to_string() );
        return;
    }

    npc *host_npc = mp_host_view_actor();
    if( !host_npc ) {
        // NPC left the reality bubble — still in overmap buffer, just not loaded.
        // Don't reset spawned state or we'll create a duplicate on the next tick.
        // If they're far enough to load, request a map reload in their direction.
        if( m.inbounds( abs_pos ) ) {
            if( npc *retained = mp_session().client_host_actor.retained( g->npc_lifetimes() ) ) {
                retained->spawn_at_precise( abs_pos );
                g->load_npcs();
            }
        }
        return;
    }
    if( !name.empty() && host_npc->name != name ) {
        host_npc->name = name;
    }
    // Re-apply ally status every position update — cheap and idempotent, ensures
    // settings survive save/load cycles where the NPC may reload with neutral defaults.
    if( !host_npc->is_player_ally() ) {
        host_npc->set_attitude( NPCATT_FOLLOW );
        host_npc->set_fac( faction_id( "your_followers" ) );
        host_npc->chatbin.first_topic = "TALK_FRIEND";
        host_npc->op_of_u.trust = 10;
        host_npc->op_of_u.value = 10;
        g->add_npc_follower( host_npc->getID() );
    }
    const bool host_inb = m.inbounds( abs_pos );
    {
        // Diagnose "host overlay stuck on client": logs whenever the received host
        // abs position, its in-bounds status, or the overlay's current bubble tile
        // changes.  If recv_abs keeps changing but cur_bub doesn't, the apply is
        // broken; if recv_abs stops changing, the host isn't broadcasting movement;
        // if inbounds=0, the host left the client's bubble and the overlay freezes.
        const std::string s = "recv_abs=" + abs_pos.to_string() +
                              " inbounds=" + std::to_string( host_inb ) +
                              " cur_bub=" + host_npc->pos_bub().to_string();
        if( s != mp_session().presentation.last_overlay ) {
            mp_session().presentation.last_overlay = s;
            mp_log( "[cdda-mp] HOST-OVERLAY: " + s );
        }
    }
    if( host_inb ) {
        const tripoint_bub_ms bub = m.get_bub( abs_pos );
        if( bub != host_npc->pos_bub() ) {
            // Mirror SP avatar_action::move boarding semantics for the host proxy:
            // unboard from current tile before setpos, board at the new tile if
            // boardable AND the host says they're in a vehicle.  Without this the
            // proxy renders walking next to the car while the host is driving.
            // Guard against stale in_vehicle (set by previous broadcast where the
            // host was in a vehicle that has since moved or unloaded).
            if( host_npc->in_vehicle ) {
                if( m.veh_at( host_npc->pos_bub() ).part_with_feature( "BOARDABLE", true ) ) {
                    m.unboard_vehicle( host_npc->pos_bub() );
                } else {
                    host_npc->in_vehicle = false;
                    host_npc->controlling_vehicle = false;
                }
            }
            host_npc->setpos( m, bub );
            if( host_in_vehicle &&
                m.veh_at( host_npc->pos_bub() ).part_with_feature( "BOARDABLE", true ) ) {
                m.board_vehicle( host_npc->pos_bub(), host_npc );
            }
        }
    }
    // Apply driving state every tick so the proxy's flags track the host even when
    // position didn't change (idling at the wheel, cruise mode).
    host_npc->in_vehicle = host_in_vehicle;
    host_npc->controlling_vehicle = host_ctrl_veh;
}

static void apply_player_roster( const JsonObject &message )
{
    const player_id host( message.get_string( "host_player" ) );
    const player_id self( message.get_string( "self_player" ) );
    std::map<player_id, JsonObject> roster;
    for( const JsonObject member : message.get_array( "players" ) ) {
        member.allow_omitted_members();
        const player_id id( member.get_string( "player" ) );
        if( !id.valid() || id == host || id == self || !roster.emplace( id, member ).second ) {
            throw std::runtime_error( "Invalid multiplayer roster identity" );
        }
        if( mp_session().client_player_views.count( id ) == 0 && !member.has_object( "appearance" ) ) {
            throw std::runtime_error( "New player view requires a complete appearance" );
        }
    }
    mp_session().client_host_player_id = host;
    for( const auto &entry : roster ) {
        auto &view = mp_session().client_player_views[entry.first];
        if( !view ) {
            view = std::make_unique<player_view>();
        }
        apply_player_view( entry.second, *view );
    }
    for( auto it = mp_session().client_player_views.begin();
         it != mp_session().client_player_views.end(); ) {
        if( roster.count( it->first ) == 0 ) {
            remove_player_view( *it->second );
            it = mp_session().client_player_views.erase( it );
        } else {
            ++it;
        }
    }
}

static void apply_npc_roster( const JsonObject &message )
{
    std::map<character_id, JsonObject> roster;
    for( const JsonObject member : message.get_array( "npcs" ) ) {
        member.allow_omitted_members();
        const int raw_id = member.get_int( "npc_id", -1 );
        const character_id id( raw_id );
        if( raw_id <= 0 || !id.is_valid() || !roster.emplace( id, member ).second ) {
            throw std::runtime_error( "Invalid multiplayer NPC roster identity" );
        }
        if( mp_session().client_npc_views.count( id ) == 0 && !member.has_object( "appearance" ) ) {
            throw std::runtime_error( "New NPC view requires a complete appearance" );
        }
    }
    for( const auto &entry : roster ) {
        auto &view = mp_session().client_npc_views[entry.first];
        if( !view ) {
            view = std::make_unique<npc_view>();
        }
        apply_npc_view( entry.second, *view );
    }
    for( auto it = mp_session().client_npc_views.begin();
         it != mp_session().client_npc_views.end(); ) {
        if( roster.count( it->first ) == 0 ) {
            remove_npc_view( *it->second );
            it = mp_session().client_npc_views.erase( it );
        } else {
            ++it;
        }
    }
}

static void leave_client_replica( const std::string &reason )
{
    // Retain the client role until world cleanup. The loaded world contains
    // replica state and must never fall through to the solo simulation.
    get_avatar().set_moves( 0 );
    g->uquit = QUIT_NOSAVED;
    mp_log_client( reason );
    mp_session().client_turn.exit_reason = reason;
}

// NOLINTNEXTLINE(readability-function-size)
bool client_apply_message( const std::string &msg )
{
    if( !is_client_mode() || g->uquit != QUIT_NO ) {
        return false;
    }
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    if( msg.find( "player_resume" ) != std::string::npos ) {
        try {
            const JsonValue value = json_loader::from_string( msg );
            const JsonObject message = value.get_object();
            message.allow_omitted_members();
            if( message.get_string( "type", "" ) == "player_resume" ) {
                apply_player_resume_result( get_avatar(), message, mp_session().client_pickup );
                return true;
            }
        } catch( const JsonError & ) {
            leave_client_replica(
                _( "Could not restore your saved character from the host.  Reconnect to retry." ) );
            return true;
        }
    }
    if( msg.find( "inventory_activity_result" ) != std::string::npos ) {
        try {
            JsonValue value = json_loader::from_string( msg );
            JsonObject response = value.get_object();
            response.allow_omitted_members();
            if( apply_inventory_activity_result( response ) ) {
                return true;
            }
        } catch( const JsonError & ) {
            leave_client_replica(
                _( "Invalid inventory activity response.  Reconnect to synchronize your character." ) );
            return true;
        }
    }
    if( msg.find( "firearm_result" ) != std::string::npos ) {
        try {
            JsonValue value = json_loader::from_string( msg );
            JsonObject message = value.get_object();
            message.allow_omitted_members();
            if( message.get_string( "type", "" ) == "firearm_result" ) {
                const int64_t revision = message.get_int64( "inventory_revision" );
                if( revision <= mp_session().client_pickup.revision ) {
                    return true;
                }
                const int outcome = message.get_int( "outcome" );
                if( outcome < 0 || outcome > static_cast<int>( firearm_outcome::finished ) ) {
                    message.throw_error_at( "outcome", "Invalid firearm outcome" );
                }
                if( message.has_object( "combat" ) ) {
                    JsonObject combat = message.get_object( "combat" );
                    combat.allow_omitted_members();
                    if( !apply_combat_result( get_avatar(), combat, mp_session().client_pickup ) ) {
                        return true;
                    }
                } else {
                    mp_session().client_pickup.revision = revision;
                }
                get_avatar().recoil = message.get_float( "recoil" );
                get_avatar().mark_aim_cache_dirty();
                firearm_view_state &view = mp_session().client_firearm;
                if( view.phase == firearm_view_phase::pending && view.weapon ==
                    message.get_int64( "weapon" ) &&
                    view.bionic == ( message.has_member( "bionic" ) ? message.get_int64( "bionic" ) : 0 ) &&
                    view.pending_request == ( message.has_member( "request" ) ? message.get_int64( "request" ) : 0 ) ) {
                    if( view.bionic && message.has_object( "bionic_preview" ) ) {
                        const restore_on_out_of_scope restore_rng( rng_get_engine() );
                        view.bionic_preview = std::make_shared<item>();
                        message.read( "bionic_preview", *view.bionic_preview, true );
                    }
                    view.phase = outcome == static_cast<int>( firearm_outcome::finished ) ?
                                 firearm_view_phase::finished :
                                 outcome == static_cast<int>( firearm_outcome::aiming ) ?
                                 firearm_view_phase::aiming : firearm_view_phase::rejected;
                }
                return true;
            }
        } catch( const JsonError & ) {
            leave_client_replica( _( "Invalid firearm response.  Reconnect to synchronize your character." ) );
            return true;
        }
    }
    if( msg.find( "combat_result" ) != std::string::npos ) {
        try {
            JsonValue value = json_loader::from_string( msg );
            JsonObject message = value.get_object();
            message.allow_omitted_members();
            if( message.get_string( "type", "" ) == "combat_result" ) {
                apply_combat_result( get_avatar(), message, mp_session().client_pickup );
                return true;
            }
        } catch( const JsonError & ) {
            leave_client_replica( _( "Invalid combat response.  Reconnect to synchronize your character." ) );
            return true;
        }
    }
    if( msg.find( "pickup_result" ) != std::string::npos ||
        msg.find( "inventory_update" ) != std::string::npos ||
        msg.find( "inventory_delta" ) != std::string::npos ) {
        try {
            JsonValue value = json_loader::from_string( msg );
            JsonObject result = value.get_object();
            result.allow_omitted_members();
            if( result.get_string( "type", "" ) == "inventory_delta" ) {
                apply_inventory_turn_update( get_avatar(), result, mp_session().client_pickup );
                return true;
            }
            if( result.get_string( "type", "" ) == "inventory_update" ) {
                apply_inventory_update( get_avatar(), result, mp_session().client_pickup );
                return true;
            }
            if( result.get_string( "type", "" ) == "pickup_result" ) {
                const bool complete = result.get_bool( "complete" );
                if( apply_pickup_result( get_avatar(), result, mp_session().client_pickup ) && !complete ) {
                    add_msg( m_info, _( "Some selected items could not be moved." ) );
                }
                return true;
            }
        } catch( const JsonError & ) {
            leave_client_replica( _( "Invalid pickup response.  Reconnect to synchronize your inventory." ) );
            return true;
        }
    }
    // Log a preview of every received packet so we can confirm moves=90 packets arrive.
    {
        const size_t preview_len = std::min( msg.size(), static_cast<size_t>( 120 ) );
        mp_log( "[cdda-mp] recv-packet: " + msg.substr( 0, preview_len ) );
    }
    if( msg.find( R"("type":"error")" ) != std::string::npos ) {
        std::string reason = _( "The co-op host rejected the connection." );
        try {
            const JsonValue value = json_loader::from_string( msg );
            const JsonObject error = value.get_object();
            error.allow_omitted_members();
            reason = error.get_string( "message", reason );
        } catch( const JsonError & ) {
            // Keep the generic reason if the host's error packet is malformed.
        }
        leave_client_replica( reason );
        return true;
    }

    // Join accepted. Carries the host's worldgen seed — adopt it before we
    // generate the host-area overmap so our base terrain (forests/lakes/rivers/
    // coast) matches the host's. Without this the client rolls its own random
    // seed in start_game() and renders a different map outside the tile-synced
    // bubble (the "different map until I got close" report, 2026-06-02).
    if( msg.find( R"("type":"welcome")" ) != std::string::npos ) {
        try {
            JsonValue value = json_loader::from_string( msg );
            JsonObject welcome = value.get_object();
            welcome.allow_omitted_members();
            const world_id received( welcome.get_string( "world_id" ) );
            if( received != mp_session().admission.host_world ) {
                return false;
            }
        } catch( const std::exception & ) {
            return false;
        }
        // Game-loop replay path (first do_turn): the engine seed is already
        // finalized, so adopt the host seed now. The connect-time path stashes
        // the same welcome earlier via mp_store_pending_welcome() so start_game
        // can act on it before worldgen.
        parse_welcome_fields( msg, /*apply_seed_now=*/true );
        return true;
    }

    if( msg.find( R"("type":"player_create_request")" ) != std::string::npos ) {
        // Only the host's first-admission request permits this upload. Future
        // actions carry intents; reconnects receive the host's saved snapshot.
        std::ostringstream text;
        JsonOut out( text );
        out.start_object();
        out.member( "action", "player_create" );
        out.member( "player_state" );
        get_avatar().store_player_state( out );
        out.end_object();
        client_send( text.str() );
        return true;
    }

    // Per-tile vehicle motion packet (sent during host's vehmove between
    // game turns).  Slim payload — just position/face/turn_dir/vel.  Apply
    // through the same vehicle sync path the full state packet uses, then
    // force a render so the new tile shows immediately instead of waiting
    // for the next user keypress.
    if( msg.find( R"("type":"vehicle_step")" ) != std::string::npos ) {
        try {
            JsonValue jv = json_loader::from_string( msg );
            JsonObject jo = jv.get_object();
            jo.allow_omitted_members();
            apply_vehicle_sync( jo );
            g->invalidate_main_ui_adaptor();
            ui_manager::redraw();
            refresh_display();
        } catch( const JsonError &e ) {
            mp_log( "[cdda-mp] vehicle_step parse error: " + std::string( e.what() ) );
        }
        return true;
    }

    // Overmap region streamed from the host — apply the host's actual omt grid
    // (cities/roads/biomes) over our own non-deterministic regen so the far-map
    // matches. Palette + row-major RLE; see build_overmap_sync().
    if( msg.find( R"("type":"overmap_sync")" ) != std::string::npos ) {
        try {
            JsonValue jv = json_loader::from_string( msg );
            JsonObject jo = jv.get_object();
            jo.allow_omitted_members();
            const int z = jo.get_int( "z" );
            const point o( jo.get_int( "ox" ), jo.get_int( "oy" ) );
            const int w = jo.get_int( "w" );
            const int h = jo.get_int( "h" );
            // Resolve the palette to oter_ids once; invalid ids (shouldn't
            // happen — same commit + same mods) fall back to skip.
            std::vector<oter_id> palette;
            std::vector<bool> pal_ok;
            for( const JsonValue &pv : jo.get_array( "pal" ) ) {
                const oter_str_id sid( pv.get_string() );
                const bool ok = sid.is_valid();
                palette.push_back( ok ? sid.id() : oter_id() );
                pal_ok.push_back( ok );
            }
            const int total = w * h;
            // Apply the host's city NAMES to our same-position cities. Overmap
            // terrain matches by seed, but names are RNG-state-divergent. Match by
            // exact OMT position (the seed-synced overmap places cities identically).
            if( jo.has_array( "cities" ) ) {
                int renamed = 0;
                for( const JsonValue &cv : jo.get_array( "cities" ) ) {
                    JsonObject co = cv.get_object();
                    co.allow_omitted_members();
                    const tripoint_abs_omt cp( co.get_int( "x" ), co.get_int( "y" ), z );
                    const std::string nm = co.get_string( "n", "" );
                    if( nm.empty() ) {
                        continue;
                    }
                    overmap_with_local_coords omc = overmap_buffer.get_existing_om_global( cp );
                    if( !omc.om ) {
                        continue;
                    }
                    for( city &c : omc.om->cities ) {
                        if( project_combine( c.pos_om, c.pos ) == cp.xy() && c.name != nm ) {
                            c.name = nm;
                            ++renamed;
                            break;
                        }
                    }
                }
                if( renamed > 0 ) {
                    mp_log( "[cdda-mp] OMSYNC: renamed " + std::to_string( renamed ) +
                            " cities to match host" );
                }
            }
            // Decode the RLE into the pending buffer instead of applying inline —
            // mp_drain_pending_omsync() applies a budget of cells per do_turn so the
            // ~32k ter_set calls don't freeze the main thread for seconds on receipt.
            pending_omsync_t p;
            p.z = z;
            p.ox = o.x;
            p.oy = o.y;
            p.w = w;
            p.cells.assign( total, oter_id() );
            p.ok.assign( total, 0 );
            p.cursor = 0;
            int cursor = 0;
            int queued = 0;
            for( JsonValue rv : jo.get_array( "rle" ) ) {
                JsonArray run = rv.get_array();
                const int count = run.get_int( 0 );
                const int pidx = run.get_int( 1 );
                const bool valid = pidx >= 0 && pidx < static_cast<int>( palette.size() ) && pal_ok[pidx];
                for( int k = 0; k < count && cursor < total; ++k, ++cursor ) {
                    if( valid ) {
                        p.cells[cursor] = palette[pidx];
                        p.ok[cursor] = 1;
                        ++queued;
                    }
                }
            }
            p.active = queued > 0;
            // Priority window: apply the omts immediately around the avatar's
            // current x/y NOW, synchronously, before queuing the rest for the
            // lazy chunk drain.  The drain is row-major from the region's NW
            // corner and restarts at cursor 0 on every re-sync (a fresh host
            // move supersedes the in-progress region below), so the player's own
            // omt — near the middle of the 181x181 region — was never reached and
            // kept reading the client's local-worldgen open_air (e.g. a bridge
            // deck at z=1).  This window is a few hundred cells (<<25ms), so it
            // never hitches a frame, and it guarantees the look-around header and
            // near far-map are correct the instant the floor's terrain arrives.
            int prio_applied = 0;
            if( queued > 0 ) {
                constexpr int PRIO_R = 16;   // omts around the avatar to apply now
                const tripoint_abs_omt ao = get_avatar().pos_abs_omt();
                const int x0 = std::max( o.x, ao.x() - PRIO_R );
                const int x1 = std::min( o.x + w - 1, ao.x() + PRIO_R );
                const int y0 = std::max( o.y, ao.y() - PRIO_R );
                const int y1 = std::min( o.y + h - 1, ao.y() + PRIO_R );
                for( int yy = y0; yy <= y1; ++yy ) {
                    for( int xx = x0; xx <= x1; ++xx ) {
                        const int cur = ( yy - o.y ) * w + ( xx - o.x );
                        if( cur >= 0 && cur < total && p.ok[cur] ) {
                            overmap_buffer.ter_set( tripoint_abs_omt( xx, yy, z ), p.cells[cur] );
                            p.ok[cur] = 0;   // applied — let the drain skip it
                            ++prio_applied;
                        }
                    }
                }
                if( prio_applied > 0 ) {
                    g->invalidate_main_ui_adaptor();
                }
            }
            if( queued > 0 ) {
                // A fresh sync of a floor supersedes any still-pending region for
                // the same z; drop it, then enqueue this one.
                for( auto it = mp_session().replication.client.pending_omsync.begin();
                     it != mp_session().replication.client.pending_omsync.end(); ) {
                    it = ( it->z == z ) ? mp_session().replication.client.pending_omsync.erase( it ) : std::next( it );
                }
                mp_session().replication.client.pending_omsync.push_back( std::move( p ) );
            }
            mp_log( "[cdda-mp] OMSYNC recv: queued=" + std::to_string( queued ) + "/" +
                    std::to_string( total ) + " prio=" + std::to_string( prio_applied ) +
                    " pal=" + std::to_string( palette.size() ) + " (chunked apply)" );
            // Repaint happens once the chunked apply completes (in the drain).
        } catch( const JsonError &e ) {
            mp_log( "[cdda-mp] OMSYNC parse error: " + std::string( e.what() ) );
        }
        return true;
    }

    // Submap terrain+furniture stream (see build_map_sync).  Overwrites the
    // client's divergent local mapgen via map::ter_set / furn_set (public API;
    // they early-out on unchanged tiles, set the per-tile cache flags, and mark
    // the submap player-adjusted so the synced terrain persists).  The host caps
    // submaps per turn so the bulk join fill is spread over a few turns rather
    // than one freeze; we time the apply below to confirm it stays cheap.
    if( msg.find( R"("type":"map_sync")" ) != std::string::npos ) {
        const std::chrono::steady_clock::time_point t0 = std::chrono::steady_clock::now();
        try {
            JsonValue jv = json_loader::from_string( msg );
            JsonObject jo = jv.get_object();
            jo.allow_omitted_members();
            const int z = jo.get_int( "z" );
            if( !get_map().inbounds_z( z ) ) {
                return true;
            }
            std::vector<ter_str_id> terrain_palette;
            std::vector<furn_str_id> furniture_palette;
            for( const JsonValue &value : jo.get_array( "pal" ) ) {
                terrain_palette.emplace_back( value.get_string() );
                furniture_palette.emplace_back( value.get_string() );
            }
            const auto decode = []( const JsonArray &runs, const auto &palette, auto &out ) {
                size_t cursor = 0;
                for( JsonValue value : runs ) {
                    const JsonArray run = value.get_array();
                    const int count = run.get_int( 0 );
                    const int id = run.get_int( 1 );
                    if( count <= 0 || id < 0 || static_cast<size_t>( id ) >= palette.size() ||
                        static_cast<size_t>( count ) > out.size() - cursor || !palette[id].is_valid() ) {
                        return false;
                    }
                    std::fill_n( out.begin() + cursor, count, palette[id].id() );
                    cursor += count;
                }
                return cursor == out.size();
            };
            auto &pending = mp_session().replication.client.pending_terrain;
            constexpr size_t pending_limit = MAPSIZE * MAPSIZE * OVERMAP_LAYERS;
            for( JsonValue value : jo.get_array( "subs" ) ) {
                if( pending.size() >= pending_limit ) {
                    break;
                }
                JsonObject cell = value.get_object();
                cell.allow_omitted_members();
                const tripoint_abs_sm position( cell.get_int( "sx" ), cell.get_int( "sy" ), z );
                client_replication_state::terrain_chunk chunk;
                if( decode( cell.get_array( "t" ), terrain_palette, chunk.terrain ) &&
                    decode( cell.get_array( "f" ), furniture_palette, chunk.furniture ) ) {
                    pending.insert_or_assign( position, std::move( chunk ) );
                }
            }
            apply_pending_terrain();
            const auto elapsed = std::chrono::duration_cast<std::chrono::milliseconds>(
                                     std::chrono::steady_clock::now() - t0 ).count();
            mp_log( "[ccb-mp] MAPSYNC recv: pending=" + std::to_string( pending.size() ) +
                    " ms=" + std::to_string( elapsed ) );
        } catch( const JsonError &e ) {
            mp_log( "[cdda-mp] MAPSYNC parse error: " + std::string( e.what() ) );
        }
        return true;
    }

    if( msg.find( R"("type":"host_died")" ) != std::string::npos ) {
        leave_client_replica( _( "The co-op host has died.  Rejoin when their world is available." ) );
        return true;
    }

    // The host saved the authoritative world and guest characters. Leave the
    // replica through the normal menu cleanup, which saves its private memory.
    if( msg.find( R"("type":"session_ending")" ) != std::string::npos ) {
        mp_log( "[cdda-mp] SESSION-END RECV: host is leaving" );
        leave_client_replica( _( "The host saved and closed the co-op session." ) );
        return true;
    }

    // Co-op save handshake: receipt alone is not proof of a successful save.
    if( msg.find( R"("type":"save_done")" ) != std::string::npos ) {
        const JsonValue value = json_loader::from_string( msg );
        const JsonObject result = value.get_object();
        result.allow_omitted_members();
        const bool saved = result.get_bool( "saved", false );
        mp_log( saved ? "[cdda-mp] SAVE-DONE RECV: host saved the shared world" :
                "[cdda-mp] SAVE-DONE RECV: host did not confirm a successful save" );
        if( saved ) {
            add_msg( m_good, _( "The host saved the shared world and your character." ) );
        } else {
            add_msg( m_bad,
                     _( "The host did not confirm a successful save.  Keep the session open and ask the host to retry saving." ) );
        }
        return true;
    }

    // Templates wire-sync handlers (symmetric — same shape on host and client).
    if( msg.find( R"("type":"templates_list")" ) != std::string::npos ) {
        mp_handle_templates_list( msg );
        return true;
    }
    if( msg.find( R"("type":"template_request")" ) != std::string::npos ) {
        mp_handle_template_request( msg );
        return true;
    }
    if( msg.find( R"("type":"template_data")" ) != std::string::npos ) {
        mp_handle_template_data( msg );
        return true;
    }

    // Our character died on the host (proxy NPC was killed by monsters there).
    // Mirror the SP death path locally: zero our HP and let the next do_turn
    // trigger the standard death-screen / game-over flow.  Without this the
    // client would just see a "Lost connection to server" 20 seconds later
    // when the silent host stops granting turns — confusing UX for what is
    // really "your character died".
    if( msg.find( R"("type":"you_died")" ) != std::string::npos ) {
        add_msg( m_bad, "%s", _( "You died." ) );
        get_avatar().die( &get_map(), nullptr );
        return true;
    }

    if( msg.find( R"("type":"note_sync")" ) != std::string::npos ) {
        mp_handle_note_sync( msg );
        return true;
    }

    if( msg.find( R"("type":"chat")" ) != std::string::npos ) {
        mp_handle_chat_msg( msg );
        return true;
    }

    if( msg.find( R"("type":"high_five")" ) != std::string::npos ) {
        mp_handle_high_five_recv( msg );
        return true;
    }

    const bool is_state = msg.find( R"("type":"state")" ) != std::string::npos ||
                          msg.find( R"("type": "state")" ) != std::string::npos;
    if( !is_state ) {
        std::cout << "[cdda-mp] " << msg << std::endl;
        return false;
    }
    if( msg.find( "\"connected\":false" ) != std::string::npos ) {
        leave_client_replica( _( "Lost connection to the co-op host.  Rejoin to resume your character." ) );
        return true;
    }

    try {
        mp_log( "[cdda-mp] STATE-APPLY: parse (" + std::to_string( msg.size() ) + " bytes) start" );
        JsonValue jv = json_loader::from_string( msg );
        JsonObject jo = jv.get_object();
        jo.allow_omitted_members();
        mp_log( "[cdda-mp] STATE-APPLY: parse done" );
        if( jo.has_int( "grant_seq" ) &&
            jo.get_int64( "grant_seq" ) < mp_session().client_turn.client_last_grant_seq ) {
            return true;
        }

        if( jo.has_object( "character_turn" ) &&
            jo.get_int64( "character_revision" ) <= mp_session().client_turn.last_character_revision ) {
            return true;
        }

        // Sync host's calendar turn so the client sees the correct time, lighting, and weather.
        if( jo.has_int( "calendar_turn" ) ) {
            const time_point host_turn( jo.get_int( "calendar_turn" ) );
            if( host_turn < mp_session().client_turn.observed_host_turn ) {
                return true;
            }
            mp_session().client_turn.observed_host_turn = host_turn;
            calendar::turn = host_turn;
        }
        mp_session().client_turn.group_fast_forward = jo.get_bool( "group_fast_forward", false );

        if( jo.has_object( "pos" ) ) {
            mp_apply_step _s( "teleport" );
            JsonObject pos = jo.get_object( "pos" );
            pos.allow_omitted_members();
            mp_session().host_observation.mp_remote_pos = tripoint_abs_ms{
                pos.get_int( "x" ), pos.get_int( "y" ), pos.get_int( "z" )
            };
            client_teleport_avatar( mp_session().host_observation.mp_remote_pos );
        }

        std::string host_name;
        jo.read( "host_name", host_name );
        if( !host_name.empty() ) {
            mp_session().host_observation.partner_name_cached = host_name;
        }

        if( jo.has_object( "host_pos" ) ) {
            JsonObject hpos = jo.get_object( "host_pos" );
            hpos.allow_omitted_members();
            const tripoint_abs_ms host_pos{
                hpos.get_int( "x" ), hpos.get_int( "y" ), hpos.get_int( "z" )
            };
            const bool host_in_veh  = jo.has_bool( "host_in_vehicle" )
                                      ? jo.get_bool( "host_in_vehicle" ) : false;
            const bool host_ctrl_v  = jo.has_bool( "host_ctrl_veh" )
                                      ? jo.get_bool( "host_ctrl_veh" ) : false;
            update_client_host_npc( host_pos, host_name, host_in_veh, host_ctrl_v );
        }

        if( jo.has_array( "players" ) ) {
            apply_player_roster( jo );
            mp_cancel_help_if_partner_done();
        }
        if( jo.has_object( "missions" ) ) {
            apply_mission_view( jo.get_object( "missions" ), get_avatar() );
        }
        if( jo.has_array( "radio_contacts" ) ) {
            apply_radio_contacts( jo.get_array( "radio_contacts" ), mp_session().client_radio_contacts );
        }
        if( jo.has_array( "npcs" ) ) {
            apply_npc_roster( jo );
        }

        // Track the host's current activity for HUD + partner-notice display.
        if( jo.has_string( "host_activity" ) ) {
            mp_session().host_observation.partner_activity = jo.get_string( "host_activity" );
            mp_session().host_observation.partner_help_target = jo.get_string( "host_help_target", "" );
            mp_partner_activity_transition_check();
        }
        if( jo.has_int( "host_activity_pct" ) ) {
            const int new_pct = jo.get_int( "host_activity_pct" );
            // ASSIST-DISPLAY diag: when does the client actually receive a fresh
            // host pct vs. when its screen redraws?  Change-gated.
            if( new_pct != mp_session().host_observation.partner_activity_pct ) {
                mp_log( "[cdda-mp] ASSIST-PCT: client recv host_activity_pct=" +
                        std::to_string( new_pct ) );
            }
            mp_session().host_observation.partner_activity_pct = new_pct;
        }
        if( jo.has_int( "host_activity_moves_total" ) ) {
            mp_session().host_observation.partner_activity_moves_total =
                jo.get_int( "host_activity_moves_total" );
        }
        if( jo.has_int( "host_morale" ) ) {
            mp_session().host_observation.partner_morale = jo.get_int( "host_morale" );
        }
        if( jo.has_int( "host_hp_cur" ) ) {
            mp_session().host_observation.partner_hp_cur = jo.get_int( "host_hp_cur" );
        }
        if( jo.has_int( "host_hp_max" ) ) {
            mp_session().host_observation.partner_hp_max = jo.get_int( "host_hp_max" );
        }
        // Ping (CLIENT ONLY — the host adopts the mirrored client_rtt instead,
        // since subtracting our stamp against the host's clock would be garbage).
        // Measure RTT only when the echo matches the stamp we're currently
        // awaiting, then clear it: a host re-echoing the same stamp during idle
        // must not keep growing the number against an ever-advancing clock.
        if( is_client_mode() && jo.has_int( "host_ping_echo" ) ) {
            const int64_t stamp = jo.get_int( "host_ping_echo" );
            if( stamp >= 0 && stamp == mp_session().client_turn.pending_ping_stamp ) {
                mp_session().host_observation.partner_ping_ms = static_cast<int>( mp_mono_ms() - stamp );
                mp_session().client_turn.pending_ping_stamp = -1; // consumed; hold this value until next send
            }
        }
        // Snapshot host's calendar BEFORE the local sync above overwrites it,
        // so the panel can show drift = local - last_received_partner.  Since
        // the client sets local = host on every state packet, drift here is
        // the gap between packets — useful sanity indicator.
        if( jo.has_int( "calendar_turn" ) ) {
            mp_session().host_observation.partner_calendar_turn = jo.get_int( "calendar_turn" );
        }

        // Host→client swap/push: the host did the action locally and flagged it
        // here.  Render the observer message locally from the host proxy's real
        // name so it always reads "<host> swaps places with you." — no relayed
        // text, no POV rewriting, robust even when both players share a name.
        if( ( jo.has_bool( "partner_swapped" ) && jo.get_bool( "partner_swapped" ) ) ||
            ( jo.has_bool( "partner_pushed" ) && jo.get_bool( "partner_pushed" ) ) ) {
            std::string host_name = _( "Your partner" );
            if( mp_session().client_host_actor.id().is_valid() ) {
                if( npc *hnpc = mp_host_view_actor() ) {
                    host_name = hnpc->get_name();
                }
            }
            mp_log( "[cdda-mp] DIAG cli-render: proxy='" + host_name + "' own_av='" +
                    get_avatar().name + "'" );
            if( jo.has_bool( "partner_swapped" ) && jo.get_bool( "partner_swapped" ) ) {
                add_msg( _( "%s swaps places with you." ), jo.get_string( "swap_from", host_name ) );
            }
            if( jo.has_bool( "partner_pushed" ) && jo.get_bool( "partner_pushed" ) ) {
                add_msg( _( "%s pushes you out of the way." ), jo.get_string( "push_from", host_name ) );
            }
        }

        if( jo.has_float( "host_light" ) || jo.has_int( "host_light" ) ) {
            mp_session().host_observation.mp_host_luminance = static_cast<float>
                    ( jo.get_float( "host_light" ) );
        }

        // Dress the host NPC with the items the host player is wearing and apply
        // all appearance mutations. Signature-gated to avoid redoing every tick.
        if( jo.has_array( "host_worn" ) ) {
            // Fingerprint: worn list + appearance array raw string + wielded.
            std::string sig;
            for( const JsonValue &wv : jo.get_array( "host_worn" ) ) {
                JsonObject wo = wv.get_object();
                wo.allow_omitted_members();
                sig += wo.get_string( "typeid", wo.get_string( "t", "" ) ) + ',';
            }
            std::string incoming_wielded;
            jo.read( "host_wielded", incoming_wielded );
            // Include the full appearance JSON in sig so any sub-field change triggers redress.
            if( jo.has_array( "host_appearance" ) ) {
                for( const JsonValue &av : jo.get_array( "host_appearance" ) ) {
                    JsonObject ao = av.get_object();
                    ao.allow_omitted_members();
                    sig += ao.get_string( "type", "" ) + ':' + ao.get_string( "id", "" )
                           + '/' + ao.get_string( "var", "" ) + '|';
                }
            }
            sig += '|' + incoming_wielded;
            if( jo.has_int( "host_weight" ) ) {
                sig += "|w" + std::to_string( jo.get_int( "host_weight" ) );
            }

            if( sig != mp_session().replication.client.client_host_worn_sig &&
                mp_session().client_host_spawned ) {
                mp_apply_step _dress( "dress-host-npc" );
                mp_session().replication.client.client_host_worn_sig = sig;
                npc *host_npc = mp_host_view_actor();
                if( host_npc ) {
                    if( jo.has_bool( "host_male" ) ) {
                        host_npc->male = jo.get_bool( "host_male" );
                    }
                    host_npc->clear_worn();
                    std::string applied_log;
                    for( const JsonValue &wv : jo.get_array( "host_worn" ) ) {
                        JsonObject wo = wv.get_object();
                        wo.allow_omitted_members();
                        item worn_item;
                        try {
                            worn_item.deserialize( wo );
                        } catch( const JsonError &e ) {
                            const itype_id tid( wo.get_string( "t", "" ) );
                            if( tid.is_valid() ) {
                                worn_item = item( tid );
                                const std::string var = wo.get_string( "v", "" );
                                if( !var.empty() ) {
                                    worn_item.set_itype_variant( var );
                                }
                            }
                            mp_log( std::string( "[cdda-mp] host_worn: parse fallback: " )
                                    + e.what() );
                        }
                        if( !worn_item.typeId().is_empty() && worn_item.typeId().is_valid() ) {
                            applied_log += worn_item.typeId().str() + ' ';
                            host_npc->worn.wear_item( *host_npc, worn_item,
                                                      false, false, true, true );
                        }
                    }
                    mp_log( "[cdda-mp] host_worn applied: [" + applied_log + "]" );
                    // Apply all mutations from the host_appearance array.  Full
                    // state sync: clear every mutation on the proxy first, then
                    // apply the host's list.  Earlier per-type clearing missed
                    // physical mutations (Fangs, Sleek Fur, Spines, etc.) since
                    // they have different type tags than the chargen cosmetics.
                    if( jo.has_array( "host_appearance" ) ) {
                        // Snapshot then clear — modifying the set while iterating crashes.
                        std::vector<trait_id> to_unset;
                        for( const trait_id &existing : host_npc->get_mutations() ) {
                            to_unset.push_back( existing );
                        }
                        for( const trait_id &old : to_unset ) {
                            host_npc->unset_mutation( old );
                        }
                        int applied = 0;
                        for( const JsonValue &av : jo.get_array( "host_appearance" ) ) {
                            JsonObject ao = av.get_object();
                            ao.allow_omitted_members();
                            const std::string mid = ao.get_string( "id", "" );
                            if( mid.empty() ) {
                                continue;
                            }
                            const trait_id tid( mid );
                            if( !tid.is_valid() ) {
                                continue;
                            }
                            const std::string var_str = ao.get_string( "var", "" );
                            const mutation_variant *var = var_str.empty()
                                                          ? nullptr
                                                          : tid.obj().variant( var_str );
                            host_npc->set_mutation( tid, var );
                            ++applied;
                        }
                        mp_log( "[cdda-mp] host_appearance: cleared "
                                + std::to_string( to_unset.size() )
                                + " applied " + std::to_string( applied ) );
                        std::string ov_log;
                        for( const auto &ov : host_npc->get_overlay_ids() ) {
                            ov_log += ov.first + ' ';
                        }
                        mp_log( "[cdda-mp] host_npc overlays after appearance: [" + ov_log + "]" );
                    }
                    // Apply or clear the host's wielded weapon (full object preferred).
                    bool applied_wielded_full = false;
                    if( jo.has_object( "host_wielded_obj" ) ) {
                        try {
                            JsonObject wo = jo.get_object( "host_wielded_obj" );
                            wo.allow_omitted_members();
                            item tmp;
                            tmp.deserialize( wo );
                            host_npc->set_wielded_item( tmp );
                            applied_wielded_full = true;
                            mp_log( "[cdda-mp] host_wielded applied(full): " + tmp.typeId().str()
                                    + " charges=" + std::to_string( tmp.charges )
                                    + " ammo=" + std::to_string( tmp.ammo_remaining() ) );
                        } catch( const JsonError &e ) {
                            mp_log( std::string( "[cdda-mp] host_wielded_obj parse error: " )
                                    + e.what() );
                        }
                    }
                    if( !applied_wielded_full ) {
                        if( incoming_wielded.empty() ) {
                            host_npc->remove_weapon();
                        } else {
                            const itype_id wid( incoming_wielded );
                            if( wid.is_valid() ) {
                                host_npc->set_wielded_item( item( wid ) );
                                mp_log( "[cdda-mp] host_wielded applied: " + incoming_wielded );
                            }
                        }
                    }
                    // Rebuild the host NPC's main inventory from the serialized blob.
                    if( jo.has_array( "host_inv" ) ) {
                        try {
                            host_npc->inv->clear();
                            JsonArray inv_ja = jo.get_array( "host_inv" );
                            host_npc->inv->json_load_items( inv_ja );
                            mp_log( "[cdda-mp] host_inv applied: items=" +
                                    std::to_string( host_npc->inv->size() ) );
                        } catch( const JsonError &e ) {
                            mp_log( std::string( "[cdda-mp] host_inv rebuild error: " )
                                    + e.what() );
                        }
                    }
                }
            }
        }

        // Apply host's move_mode to the host NPC proxy every tick (changes per-action).
        if( jo.has_string( "host_move_mode" ) && mp_session().client_host_spawned ) {
            npc *host_npc = mp_host_view_actor();
            if( host_npc ) {
                const move_mode_id mode_id( jo.get_string( "host_move_mode" ) );
                if( mode_id.is_valid() ) {
                    host_npc->move_mode = mode_id;
                }
            }
        }

        // Sync host facing direction for correct sprite flip.
        if( jo.has_int( "host_facing" ) && mp_session().client_host_spawned ) {
            npc *host_npc = mp_host_view_actor();
            if( host_npc ) {
                host_npc->facing = jo.get_int( "host_facing" ) == 0
                                   ? FacingDirection::LEFT : FacingDirection::RIGHT;
            }
        }

        // Apply the host's active effects to the proxy so its status + overhead
        // markers (bleeding, etc.) match the host. NOT signature-gated — effects
        // change every turn. Full-state: clear then re-add the host's current set
        // (empty array correctly clears, e.g. host stopped bleeding).
        if( jo.has_array( "host_effects" ) && mp_session().client_host_spawned ) {
            npc *host_npc = mp_host_view_actor();
            if( host_npc ) {
                host_npc->clear_effects();
                for( const JsonValue &ev : jo.get_array( "host_effects" ) ) {
                    JsonObject eo = ev.get_object();
                    eo.allow_omitted_members();
                    const std::string eid = eo.get_string( "id", "" );
                    if( eid.empty() ) {
                        continue;
                    }
                    const efftype_id et( eid );
                    if( !et.is_valid() ) {
                        continue;
                    }
                    const int intensity = eo.get_int( "intensity", 1 );
                    const time_duration dur =
                        time_duration::from_turns( std::max( 1, eo.get_int( "dur", 1 ) ) );
                    const std::string bp_str = eo.get_string( "bp", "" );
                    const bodypart_str_id bpsid( bp_str );
                    if( bp_str.empty() || !bpsid.is_valid() ) {
                        host_npc->add_effect( et, dur, false, intensity );
                    } else {
                        host_npc->add_effect( et, dur, bpsid.id(), intensity );
                    }
                }
            }
        }

        // Apply the host's per-bodypart HP so the co-op partner-HP HUD reflects
        // the host's real health (the bar reads partner->get_hp() off the proxy).
        if( jo.has_array( "host_hp" ) && mp_session().client_host_spawned ) {
            npc *host_npc = mp_host_view_actor();
            if( host_npc ) {
                for( const JsonValue &hv : jo.get_array( "host_hp" ) ) {
                    JsonObject ho = hv.get_object();
                    ho.allow_omitted_members();
                    const std::string bp_str = ho.get_string( "id", "" );
                    const int hp = ho.get_int( "hp", -1 );
                    if( bp_str.empty() || hp < 0 ) {
                        continue;
                    }
                    const bodypart_str_id bpsid( bp_str );
                    // has_part guard: the host proxy can lag the host's real body
                    // when a mutation that grants a bodypart hasn't been applied to
                    // the proxy yet (or the two bodies differ). set_part_hp_cur on a
                    // part this body lacks debugmsgs in get_part and can SIGSEGV.
                    if( bpsid.is_valid() && host_npc->has_part( bpsid.id() ) ) {
                        host_npc->set_part_hp_cur( bpsid.id(), hp );
                    }
                }
            }
        }

        {
            mp_apply_step _s( "monster" );
            if( jo.has_member( "peek" ) ) {
                auto &pending_peek = mp_session().client_inventory_activity.peek;
                if( pending_peek && ( !jo.has_object( "peek" ) ||
                                      jo.get_object( "peek" ).get_int64( "request" ) != pending_peek->request ) ) {
                    pending_peek.reset();
                }
            }
            apply_monster_sync( jo );
        }
        {
            mp_apply_step _s( "tile" );
            apply_tile_changes( jo );
        }
        {
            mp_apply_step _s( "vehicle" );
            apply_vehicle_sync( jo );
        }

        if( jo.has_object( "character_turn" ) ) {
            std::optional<kill_statistics> updated_kills;
            if( jo.has_object( "kill_tracker" ) ) {
                updated_kills.emplace();
                updated_kills->deserialize( jo.get_object( "kill_tracker" ) );
            }
            get_avatar().load_turn_state( jo.get_object( "character_turn" ) );
            client_sync_rest_activity( jo );
            if( updated_kills ) {
                get_avatar().get_kill_statistics().reset( updated_kills->monster_kills(),
                        updated_kills->character_kills() );
            }
            mp_session().client_turn.last_character_revision = jo.get_int64( "character_revision" );
        }

        // Apply per-bodypart HP to the client avatar so the sidebar stays accurate.
        // Also synthesise "you were hit" messages from HP deltas.
        if( jo.has_array( "bodyparts" ) ) {
            avatar &av = get_avatar();
            int total_damage = 0;
            int n_parts = 0;          // parts in this sync
            int n_dropped = 0;        // parts whose HP fell vs. baseline
            int first_delta = 0;      // delta of the first dropped part
            bool uniform_drop = true; // every dropped part fell by first_delta
            for( const JsonValue &bpv : jo.get_array( "bodyparts" ) ) {
                JsonObject bpo = bpv.get_object();
                bpo.allow_omitted_members();
                const std::string bp_str = bpo.get_string( "id" );
                const bodypart_id bp = bodypart_str_id( bp_str ).id();
                const int new_hp = bpo.get_int( "hp" );
                // Skip bodyparts this avatar doesn't have. The host serializes its
                // proxy's parts; if a mutation that grants a part (e.g. tail_fluffy)
                // is on one body but not yet the other, get_part_hp_max/set_part_hp_cur
                // below would debugmsg and can SIGSEGV. A later sync after mutations
                // sync carries the part. (host-chargen crash, 2026-06-21.)
                if( !bp.is_valid() || !av.has_part( bp ) ) {
                    continue;
                }
                const auto prev_it = mp_session().replication.client.last_bodypart_hp.find( bp_str );
                ++n_parts;
                // Synthesise a "you were hit" message from HP deltas — but only
                // when the previous baseline was a *valid* HP (<= this part's
                // current max).  A baseline above max predates a max-HP
                // recompute: the proxy NPC spawns at NPC-default HP, then
                // recomputes to this character's real max and clamps current
                // down.  That clamp is not combat damage; counting it made the
                // client cry "You are hit for 204 damage!" on join with no
                // attacker (confirmed 2026-06-02: all parts 105->88/max95).
                if( prev_it != mp_session().replication.client.last_bodypart_hp.end() && new_hp < prev_it->second
                    && prev_it->second <= av.get_part_hp_max( bp ) ) {
                    const int delta = prev_it->second - new_hp;
                    mp_log( "[cdda-mp] BP-DELTA: " + bp_str
                            + " prev=" + std::to_string( prev_it->second )
                            + " new=" + std::to_string( new_hp )
                            + " max=" + std::to_string( av.get_part_hp_max( bp ) )
                            + " delta=" + std::to_string( delta ) );
                    total_damage += delta;
                    if( n_dropped == 0 ) {
                        first_delta = delta;
                    } else if( delta != first_delta ) {
                        uniform_drop = false;
                    }
                    ++n_dropped;
                }
                mp_session().replication.client.last_bodypart_hp[bp_str] = new_hp;
                av.set_part_hp_cur( bp, new_hp );
            }
            // Suppress the message for the recompute signature: EVERY part in the
            // sync fell by the IDENTICAL amount.  Real combat damages specific
            // parts by varied amounts (armor, hit location) — it never knocks all
            // ~12 parts down by the same value at once.  That uniform pattern is a
            // host-side HP recompute (e.g. a stat re-apply on the proxy) that
            // oscillates 84<->75/96 and self-corrects, not an attack.  Was firing
            // a phantom "hit for 108 damage!" after innocuous gestures like a
            // high-five (confirmed 2026-06-15: all 12 parts 84->75 delta=9 twice).
            const bool recompute_sig = n_dropped == n_parts && n_dropped >= 6 && uniform_drop;
            if( total_damage > 0 && !recompute_sig ) {
                mp_log( "[cdda-mp] BP-DAMAGE-SYNTH: total=" + std::to_string( total_damage ) );
                add_msg( m_bad, _( "You are hit for %d damage!" ), total_damage );
            } else if( recompute_sig ) {
                mp_log( "[cdda-mp] BP-DAMAGE-SYNTH: suppressed uniform recompute (all "
                        + std::to_string( n_parts ) + " parts -" + std::to_string( first_delta )
                        + ")" );
            }
        }

        // Packet reception only updates state. The main loop owns activity
        // execution; repeated/older grants cannot restore a spent move budget.
        if( jo.has_int( "moves" ) && jo.has_int( "grant_seq" ) ) {
            const int64_t sequence = jo.get_int64( "grant_seq" );
            if( sequence <= 0 || sequence > std::numeric_limits<uint32_t>::max() ) {
                jo.throw_error_at( "grant_seq", "Invalid turn grant" );
            }
            client_turn_state &turn = mp_session().client_turn;
            const uint32_t grant_seq = static_cast<uint32_t>( sequence );
            const int moves = jo.get_int( "moves" );
            turn.last_grant_time = std::chrono::steady_clock::now();
            const bool fresh = grant_seq > turn.client_last_grant_seq;
            const bool response = grant_seq == turn.client_last_grant_seq &&
                                  ( moves <= 0 || jo.get_bool( "free", false ) );
            if( fresh || response ) {
                turn.client_last_grant_seq = grant_seq;
                turn.client_waiting_for_ack = false;
                get_avatar().set_moves( moves );
            }
        }

        // Sync authoritative client stats from the server's NPC proxy.
        // The server is the source of truth for stamina, move_mode, and vehicle control —
        // it drains proxy stamina during movement and manages controlling_vehicle.
        mp_session().client_turn.client_ctrl_veh = jo.get_bool( "client_ctrl_veh", false );
        if( jo.has_object( "client_veh_pos" ) ) {
            JsonObject cvp = jo.get_object( "client_veh_pos" );
            cvp.allow_omitted_members();
            mp_session().client_turn.client_ctrl_veh_abs = tripoint_abs_ms{
                cvp.get_int( "x" ), cvp.get_int( "y" ), cvp.get_int( "z" )
            };
        } else {
            mp_session().client_turn.client_ctrl_veh_abs = tripoint_abs_ms{ 0, 0, 0 };
        }
        if( jo.has_string( "client_move_mode" ) ) {
            const move_mode_id mode_id( jo.get_string( "client_move_mode" ) );
            get_avatar().move_mode = mode_id;
            // Do NOT cancel desired_move_mode here — that would nuke a pending run/crouch
            // toggle the player just pressed before this state packet arrived.
            // The commit in handle_action already calls cancel_desired when set_movement_mode
            // fails (e.g. on stamina exhaustion), so no-op cancellation is redundant.
        }

        // Display forwarded combat messages from the host (hits, misses, kills).
        apply_craft_notifications( jo );
        apply_player_feedback( jo );
        if( jo.has_array( "msgs" ) ) {
            for( const JsonValue &mv : jo.get_array( "msgs" ) ) {
                const std::string txt = mv.get_string();
                mp_log( "[cdda-mp] client recv msg: " + txt );
                add_msg( m_neutral, txt );
            }
            // Loop-break: messages forwarded FROM the host must not be picked up
            // by client_capture_avatar_msgs and forwarded back via client_msgs.
            // Otherwise the host's "You X" → client adds → client captures and
            // sends "Name X" back → host adds → host re-substitutes to "You X"
            // → forwards back forever.  Advancing the watermark past these
            // messages keeps them local-display-only.
            mp_session().client_turn.client_msg_watermark = Messages::size();
        }

        // Play sfx events forwarded from the host's turn.
        if( jo.has_array( "sfx" ) ) {
            for( const JsonValue &sv : jo.get_array( "sfx" ) ) {
                JsonObject so = sv.get_object();
                so.allow_omitted_members();
                if( so.has_string( "id" ) && so.has_string( "v" ) && so.has_int( "vol" ) ) {
                    sfx::play_variant_sound( so.get_string( "id" ), so.get_string( "v" ),
                                             so.get_int( "vol" ) );
                }
            }
        }

        // Client manages its own inventory via the normal pickup dialog.
        // No server-driven inventory sync needed.

        std::cout << "[cdda-mp] state applied ok" << std::endl;

    } catch( const std::exception &e ) {
        std::cout << "[cdda-mp] exception in state processing: " << e.what() << std::endl;
    } catch( ... ) {
        std::cout << "[cdda-mp] unknown exception in state processing" << std::endl;
    }
    return true;
}

void client_process_incoming()
{
    if( g->uquit != QUIT_NO ) {
        return;
    }

    // Send the join message on the first tick — the save is loaded by now.
    const bool was_joined = client_join_is_sent();
    if( !was_joined ) {
        try {
            if( !mp_session().local_player ) {
                mp_session().local_player = load_server_player_credentials(
                                                PATH_INFO::config_dir_path(), client_identity_scope() );
            }
            const world_id &host = mp_session().admission.host_world;
            if( host.valid() ) {
                get_avatar().use_guest_map_memory( PATH_INFO::config_dir_path() /
                                                  "mp_map_memory" / host.str() /
                                                   mp_session().local_player->id.str() );
            }
            client_send_join( *mp_session().local_player );
        } catch( const std::exception & ) {
            leave_client_replica(
                _( "Could not load or save your multiplayer identity.  Restore its configuration backup before reconnecting." ) );
            return;
        }
    }
    if( !was_joined && client_join_is_sent() ) {
        // A loaded character can still have local AP. Wait for the first
        // authoritative grant before allowing an action in the new session.
        get_avatar().set_moves( 0 );
        mp_session().client_turn.client_waiting_for_ack = false;
        mp_session().client_turn.client_last_grant_seq = 0;
        mp_session().client_turn.last_character_revision = 0;
        mp_session().client_turn.observed_host_turn = calendar::before_time_starts;
        mp_session().client_turn.processed_host_turn = calendar::before_time_starts;
        mp_session().client_pickup = {};
        // Templates wire-sync: send local template list so the host can request
        // anything it's missing.  Host sends its own list independently.
        mp_templates_sync_on_join();
    }
    // A successful host snapshot creates its proxy. Before that admission,
    // retain local NPCs: a missing profile or rejected join must not erase them.
    if( mp_session().client_host_spawned ) {
        mp_cull_local_npcs();
    }
    std::string msg;
    int recv_count = 0;
    while( client_recv_pop( msg ) ) {
        ++recv_count;
        const std::string::size_type m_pos = msg.find( "\"moves\":" );
        const std::string moves_str = ( m_pos != std::string::npos )
                                      ? msg.substr( m_pos, 16 ) : "no-moves";
        const int pre_apply_moves = get_avatar().get_moves();
        mp_log( "[cdda-mp] CLI-RECV#" + std::to_string( recv_count ) + ": " + moves_str +
                " pre_apply_moves=" + std::to_string( pre_apply_moves ) );
        client_apply_message( msg );
        if( g->uquit != QUIT_NO ) {
            return;
        }
        const int post_apply_moves = get_avatar().get_moves();
        if( post_apply_moves != pre_apply_moves ) {
            mp_log( "[cdda-mp] CLI-RECV#" + std::to_string( recv_count ) +
                    ": moves changed " + std::to_string( pre_apply_moves ) + "->" +
                    std::to_string( post_apply_moves ) );
        }
    }
    // (Repaint consolidated into the single throttled redraw at the END of this
    // function. There used to be a second full refresh_display() here too — two
    // per drain — which on the slower client doubled the per-grant render and,
    // because divergent two-machine worlds make recv_count>0 every grant, paced
    // the host's per-turn lockstep wait to ~2x render-speed. 2026-06-03.)
    // Snapshot drain-end state. Deduped so idle/locked do_turn (~60Hz) doesn't flood log.
    {
        const std::string msg = "[cdda-mp] CLI-DRAIN-END: moves=" +
                                std::to_string( get_avatar().get_moves() ) +
                                " ack=" + std::to_string( mp_session().client_turn.client_waiting_for_ack ) +
                                " last_seq=" + std::to_string( mp_session().client_turn.client_last_grant_seq );
        if( msg != mp_session().presentation.client_drain_last ) {
            mp_log( msg );
            mp_session().presentation.client_drain_last = msg;
        }
    }
    // Repaint when we processed incoming messages so calendar/time/messages/
    // tiles reach the screen during long activities (the client stays in tight
    // do_turn iterations otherwise). THROTTLED to ~12fps: a full refresh_display
    // is ~100ms on the slower client, and with divergent worlds recv_count>0
    // every grant, so rendering per grant paced the client's do_turn (and thus
    // the host's lockstep wait) to render-speed. The grant ack is already sent
    // in process_mp_events, so throttling only affects visual freshness, not the
    // round-trip. DIAG: log slow renders so we can see the actual cost.
    if( recv_count > 0 ) {
        // One repaint per drained batch (the throttle experiment is reverted —
        // it froze the client without helping the host, since a single render
        // is ~236ms on the slow client and exceeds any useful throttle). The
        // real fix is the client's render speed, not the render frequency.
        // CLI-RENDER timing kept so we can measure that.
        const std::chrono::steady_clock::time_point r0 = std::chrono::steady_clock::now();
        g->invalidate_main_ui_adaptor();
        const std::chrono::steady_clock::time_point r1 = std::chrono::steady_clock::now();
        ui_manager::redraw();
        const std::chrono::steady_clock::time_point r2 = std::chrono::steady_clock::now();
        refresh_display();
        const std::chrono::steady_clock::time_point r3 = std::chrono::steady_clock::now();
        auto ms = []( auto a, auto b ) {
            return static_cast<long>(
                       std::chrono::duration_cast<std::chrono::milliseconds>( b - a ).count() );
        };
        const long rdur = ms( r0, r3 );
        if( rdur > 25 ) {
            // Sub-timed so we know which call to cut: invalidate (cold cache rebuild)
            // vs redraw (tile draw) vs present (framebuffer blit, slow w/o accel).
            mp_log( "[cdda-mp] CLI-RENDER: " + std::to_string( rdur ) + "ms (inval=" +
                    std::to_string( ms( r0, r1 ) ) + " redraw=" + std::to_string( ms( r1, r2 ) ) +
                    " present=" + std::to_string( ms( r2, r3 ) ) + ")" );
        }
    }
}

// Conjugate the first-word verb of `s` to third-person singular in place.
// "finish waiting" → "finishes waiting", "watch X" → "watches X".
// Inverse of fix_you_verb (which strips for host→client direction).
static void add_third_person_s( std::string &s )
{
    size_t end = s.find( ' ' );
    if( end == std::string::npos ) {
        end = s.size();
    }
    if( end == 0 || end > 40 ) {
        return;
    }
    const char last = s[end - 1];
    if( last == 's' ) {
        return;  // already conjugated
    }
    if( last == 'x' || last == 'z' ) {
        s.insert( end, "es" );
        return;
    }
    if( end >= 2 ) {
        const std::string two = s.substr( end - 2, 2 );
        if( two == "ch" || two == "sh" ) {
            s.insert( end, "es" );
            return;
        }
    }
    s.insert( end, "s" );
}

// Snapshot any new "You ..." messages the client's avatar produced since the
// last send.  Substitute "You" with the client's character name so the host
// reads them in third person ("Roy finishes waiting", "Roy is now reading X").
// Drains into the enriched action payload below.
static void client_capture_avatar_msgs()
{
    const unsigned long long cur = Messages::size();
    if( cur <= mp_session().client_turn.client_msg_watermark ) {
        mp_session().client_turn.client_msg_watermark = cur;
        return;
    }
    const auto new_msgs = Messages::recent_messages( static_cast<size_t>( cur -
                          mp_session().client_turn.client_msg_watermark ) );
    mp_session().client_turn.client_msg_watermark = cur;
    const std::string client_name = get_avatar().name;
    for( const auto &[time_str, text] : new_msgs ) {
        ( void )time_str;
        if( text.rfind( "You ", 0 ) != 0 && text.rfind( "Now ", 0 ) != 0 ) {
            continue;  // skip ambient/UI/inventory chatter
        }
        // Swap and push are already shown on the host by their dedicated
        // handlers ("<client> swaps places with you" / "pushes you out of the
        // way"); relaying the client's own "You swap/push <host>" too would
        // duplicate them on the host.
        if( text.find( "swap places" ) != std::string::npos ||
            text.find( "You push " ) != std::string::npos ) {
            continue;
        }
        std::string out = text;
        if( out.rfind( "You ", 0 ) == 0 ) {
            // "You finish waiting" → "finish waiting" → "finishes waiting" → "Roy finishes waiting"
            std::string rest = out.substr( 4 );
            add_third_person_s( rest );
            out = client_name;
            out += ' ';
            out += rest;
        } else {
            // "Now reading X" → "Roy is now reading X"
            out.insert( 0, client_name + " is " );
        }
        mp_addressee_to_you( out, client_name,
                             mp_session().host_observation.partner_name_cached );
        mp_session().client_turn.client_msgs_pending.push_back( out );
    }
}

std::string client_enrich_action( const std::string &json )
{
    const avatar &av = get_avatar();
    client_capture_avatar_msgs();

    std::string enriched = json;
    if( !enriched.empty() && enriched.back() == '}' ) {
        enriched.pop_back();
        enriched += ",\"client_facing\":" + std::to_string(
                        av.facing == FacingDirection::LEFT ? 0 : 1 );
        // Sync current activity id for HUD/messaging and group pacing.  Primary signals are the explicit
        // activity_start / activity_end actions emitted in assign_activity /
        // do_turn — this field is belt-and-suspenders so a missed lifecycle
        // packet still gets reconciled on the next normal action.  Refresh
        // from live av.activity when present so an activity assigned mid-turn
        // is reflected here too.
        mp_session().client_turn.client_turn_activity = av.activity ? av.activity.id().str() : "";
        enriched += ",\"grant_seq\":" + std::to_string( mp_session().client_turn.client_last_grant_seq );
        const std::string client_act_id = mp_session().client_turn.client_turn_activity;
        enriched += R"(,"client_activity":")" + client_act_id + "\"";
        enriched += ",\"client_help_target\":" + wire_quote( activity_help_target( av.activity ) );
        // Progress percentage of the live activity, for the host's Co-op panel.
        // mp_compute_activity_pct handles crafting (item_counter-based) as
        // well as standard moves_total-based activities.
        enriched += ",\"client_activity_pct\":" + std::to_string(
                        mp_compute_activity_pct( av.activity ) );
        // Total moves of the live activity, so the host's bump menu can gate
        // the "Help with task" option on "long enough to warrant it".
        enriched += ",\"client_activity_moves_total\":" + std::to_string(
                        av.activity ? av.activity.moves_total : 0 );
        // Local calendar turn so the host can show a sync-drift indicator.
        enriched += ",\"client_calendar_turn\":" + std::to_string(
                        to_turn<int>( calendar::turn ) );
        // Morale level for the host's Co-op panel mood indicator.
        enriched += ",\"client_morale\":" + std::to_string( av.get_morale_level() );
        // Worst-limb real cur/max HP so the host's panel bar matches our sidebar.
        {
            const std::pair<int, int> wl = mp_worst_limb_hp( av );
            enriched += ",\"client_hp_cur\":" + std::to_string( wl.first );
            enriched += ",\"client_hp_max\":" + std::to_string( wl.second );
        }
        // Ping: stamp now (client clock) for the host to echo, and remember it
        // as the outstanding round-trip we're timing. Mirror the last RTT we
        // measured so the host's panel shows the same latency number.
        {
            const int64_t stamp = mp_mono_ms();
            mp_session().client_turn.pending_ping_stamp = stamp;
            enriched += ",\"client_ping\":" + std::to_string( stamp );
            enriched += ",\"client_rtt\":" + std::to_string( mp_session().host_observation.partner_ping_ms );
        }
        if( !mp_session().client_turn.client_msgs_pending.empty() ) {
            std::string msgs = "[";
            bool first_m = true;
            for( const std::string &m : mp_session().client_turn.client_msgs_pending ) {
                if( !first_m ) {
                    msgs += ',';
                }
                first_m = false;
                msgs += "\"" + json_escape_str( m ) + "\"";
            }
            msgs += "]";
            enriched += ",\"client_msgs\":" + msgs;
            mp_session().client_turn.client_msgs_pending.clear();
        }
        enriched += '}';
    }
    return enriched;
}

void set_client_turn_activity( const std::string &activity_id_str )
{
    mp_session().client_turn.client_turn_activity = activity_id_str;
}

const std::string &get_client_turn_activity()
{
    return mp_session().client_turn.client_turn_activity;
}

character_id get_host_npc_character_id()
{
    return mp_session().client_host_actor.id();
}

std::vector<player_light> player_lights()
{
    std::vector<player_light> result;
    if( is_client_mode() ) {
        const npc *host = mp_host_view_actor();
        if( host && mp_session().host_observation.mp_host_luminance > 0 ) {
            result.push_back( { host->pos_bub(), mp_session().host_observation.mp_host_luminance } );
        }
        for( const auto &entry : mp_session().client_player_views ) {
            const npc *actor = mp_loaded_actor( entry.second->actor );
            const float luminance = entry.second->observation.mp_remote_player_luminance;
            if( actor && luminance > 0 ) {
                result.push_back( { actor->pos_bub(), luminance } );
            }
        }
    }
    return result;
}
namespace
{
item_location client_firearm_weapon()
{
    avatar &who = get_avatar();
    if( auto *aim = dynamic_cast<aim_activity_actor *>( who.activity.actor.get() ) ) {
        return aim->get_weapon( who );
    }
    return who.get_wielded_item();
}
} // namespace

bool client_uses_firearm_intents( const item &weapon )
{
    const item_location current = client_firearm_weapon();
    return is_client_mode() && current && &*current == &weapon && supports_firearm_intents( weapon );
}

void client_start_firearm_activity( unsigned int bionic_uid )
{
    const item_location weapon = client_firearm_weapon();
    if( weapon ) {
        const int64_t next_request = mp_session().client_firearm.next_request;
        mp_session().client_firearm = {};
        firearm_view_state &view = mp_session().client_firearm;
        const item *installed = bionic_uid ? bionic_firearm_source( get_avatar(), bionic_uid ) : nullptr;
        view.weapon = installed ? installed->uid().get_value() : weapon->uid().get_value();
        view.phase = firearm_view_phase::preparing;
        view.bionic = bionic_uid;
        view.next_request = next_request;
    }
}

void client_finish_firearm_activity()
{
    const int64_t next_request = mp_session().client_firearm.next_request;
    mp_session().client_firearm = {};
    mp_session().client_firearm.next_request = next_request;
}

void client_apply_firearm_preview( aim_activity_actor &aim )
{
    firearm_view_state &view = mp_session().client_firearm;
    if( is_client_mode() && view.bionic_preview && view.bionic == aim.bionic_source() ) {
        aim.update_bionic_weapon( view.bionic, *view.bionic_preview );
        view.bionic_preview.reset();
    }
}

firearm_view_phase client_firearm_phase()
{
    return mp_session().client_firearm.phase;
}

void client_finish_ready_firearm_activity()
{
    avatar &u = get_avatar();
    if( !is_client_mode() ) {
        return;
    }
    const firearm_view_phase firearm_phase = client_firearm_phase();
    if( auto *aim = dynamic_cast<aim_activity_actor *>( u.activity.actor.get() ) ) {
        client_apply_firearm_preview( *aim );
    }
    const item_location weapon = client_firearm_weapon();
    if( weapon && is_sling_launcher( *weapon ) &&
        mp_session().client_firearm.weapon == weapon->uid().get_value() ) {
        if( firearm_phase == firearm_view_phase::finished ||
            firearm_phase == firearm_view_phase::rejected ) {
            client_finish_firearm_activity();
        } else if( !is_client_waiting_for_ack() && u.get_moves() > 0 ) {
            if( firearm_phase == firearm_view_phase::preparing ) {
                client_request_firearm( u.pos_bub(), "prepare" );
            } else if( firearm_phase == firearm_view_phase::aiming ) {
                aim_sling( u );
            }
        }
        return;
    }
    if( u.activity.id() == activity_id( "ACT_AIM" ) && u.activity.actor &&
        ( firearm_phase == firearm_view_phase::finished ||
          firearm_phase == firearm_view_phase::rejected ) ) {
        // Finalize only the local aiming view, outside packet parsing and
        // even with no AP. The server has already paid for the shot; this
        // must not turn into another compatibility wait on the next grant.
        u.activity.actor->finish( u.activity, u );
        set_client_turn_activity( u.activity ? u.activity.id().str() : "" );
    }
}

void client_request_firearm( const tripoint_bub_ms &target, const std::string &action )
{
    client_request_firearm( target, action, item_location() );
}

void client_cancel_firearm_activity( bool unload_ras )
{
    const int64_t weapon = mp_session().client_firearm.weapon;
    if( !is_client_mode() || weapon == 0 || mp_session().client_firearm.next_request <= 0 ||
        mp_session().client_firearm.next_request == std::numeric_limits<int64_t>::max() ) {
        return;
    }
    std::ostringstream encoded;
    JsonOut out( encoded );
    out.start_object();
    out.member( "type", "action" );
    out.member( "action", "firearm_cancel" );
    out.member( "weapon", weapon );
    out.member( "bionic", mp_session().client_firearm.bionic );
    out.member( "request", mp_session().client_firearm.next_request++ );
    out.member( "unload_ras", unload_ras );
    out.end_object();
    client_send( encoded.str() );
    get_avatar().set_moves( 0 );
    client_mark_action_sent();
}

void client_request_firearm( const tripoint_bub_ms &target, const std::string &action,
                             const item_location &ammo, int burst_rounds )
{
    avatar &who = get_avatar();
    const item_location weapon = client_firearm_weapon();
    if( !is_client_mode() || who.get_moves() <= 0 || is_client_waiting_for_ack() ||
        !weapon || !client_uses_firearm_intents( *weapon ) ) {
        return;
    }
    firearm_view_state &view = mp_session().client_firearm;
    const item *installed = view.bionic ? bionic_firearm_source( who, view.bionic ) : nullptr;
    const int64_t source = installed ? installed->uid().get_value() : weapon->uid().get_value();
    if( view.weapon != source || view.phase == firearm_view_phase::inactive ||
        view.next_request <= 0 || view.next_request == std::numeric_limits<int64_t>::max() ) {
        return;
    }
    std::ostringstream encoded;
    JsonOut out( encoded );
    out.start_object();
    out.member( "type", "action" );
    out.member( "action", "firearm" );
    out.member( "operation", action );
    out.member( "weapon", view.weapon );
    out.member( "bionic", view.bionic );
    view.pending_request = view.next_request++;
    out.member( "request", view.pending_request );
    out.member( "mode", weapon->gun_get_mode_id() );
    if( burst_rounds != 0 ) {
        out.member( "burst_rounds", burst_rounds );
    }
    if( ammo ) {
        out.member( "ammo", capture_item_source( who, ammo ) );
    }
    out.member( "origin", who.pos_abs() );
    out.member( "target", get_map().get_abs( target ) );
    out.member( "inventory_revision", mp_session().client_pickup.revision );
    out.member( "grant_seq", mp_session().client_turn.client_last_grant_seq );
    out.end_object();
    view.phase = firearm_view_phase::pending;
    client_send( encoded.str() );
    who.set_moves( 0 );
    client_mark_action_sent();
}

void client_close_peek( int64_t request )
{
    if( !is_client_mode() || request <= 0 ) {
        return;
    }
    client_send( R"({"type":"action","action":"peek_close","request":)" +
                 std::to_string( request ) + "}" );
}

bool client_name_monster( const monster &subject, const tripoint_abs_ms &origin,
                          const std::string &name, const std::optional<map_viewpoint> &observation )
{
    if( !is_client_mode() || origin != get_avatar().pos_abs() || name.size() > 1024 ) {
        return false;
    }
    const uint32_t nid = mp_session().replication.client.monsters.known_id( subject );
    if( nid == 0 ) {
        return false;
    }
    int64_t request = 0;
    if( observation ) {
        const auto peek = client_peek_authorization();
        if( !peek || peek->origin != origin || peek->viewpoint != observation->position ) {
            return false;
        }
        request = peek->request;
    }
    std::ostringstream text;
    JsonOut out( text );
    out.start_object();
    out.member( "type", "action" );
    out.member( "action", "monster_name" );
    out.member( "subject", nid );
    out.member( "origin", origin );
    out.member( "target", subject.pos_abs() );
    out.member( "peek_request", request );
    out.member( "name", name );
    out.end_object();
    client_send( text.str() );
    return true;
}

void client_request_throw( const throw_intent &intent )
{
    avatar &who = get_avatar();
    const auto peek = client_peek_authorization();
    if( !is_client_mode() || who.get_moves() <= 0 ||
        is_client_waiting_for_ack() ||
        ( intent.peek_request > 0 && ( !peek || peek->request != intent.peek_request ||
                                       peek->origin != intent.origin || !intent.blind_from ||
                                       peek->viewpoint != *intent.blind_from ) ) ) {
        return;
    }
    std::ostringstream encoded;
    JsonOut out( encoded );
    out.start_object();
    out.member( "type", "action" );
    out.member( "action", "throw" );
    out.member( "method", intent.method == throw_method::sling ? "sling" : "hand" );
    out.member( "origin", intent.origin );
    out.member( "target", intent.target );
    out.member( "blind_from", intent.blind_from );
    out.member( "peek_request", intent.peek_request );
    out.member( "source", intent.item.kind );
    out.member( "source_position", intent.item.position );
    out.member( "path", intent.item.path );
    out.member( "wielded", intent.wielded );
    out.member( "allow_theft", intent.allow_theft );
    if( intent.disposition ) {
        out.member( "disposition" );
        out.start_object();
        out.member( "action", intent.disposition->action );
        out.member( "container", intent.disposition->container );
        out.member( "pocket", intent.disposition->pocket );
        out.end_object();
    }
    out.member( "inventory_revision", mp_session().client_pickup.revision );
    out.member( "grant_seq", mp_session().client_turn.client_last_grant_seq );
    out.end_object();
    client_send( encoded.str() );
    who.set_moves( 0 );
    client_mark_action_sent();
}

void client_request_melee( const tripoint_bub_ms &target, melee_action action,
                           const matec_id &technique )
{
    avatar &who = get_avatar();
    if( !is_client_mode() || who.get_moves() <= 0 || is_client_waiting_for_ack() ) {
        return;
    }
    bool collateral = false;
    if( action == melee_action::reach ) {
        auto path = line_to( who.pos_bub(), target );
        if( !path.empty() ) {
            path.pop_back();
        }
        for( const tripoint_bub_ms &point : path ) {
            const Creature *other = get_creature_tracker().creature_at( point, true );
            if( other && ( other->has_effect( efftype_id( "pet" ) ) ||
                           ( other->as_npc() && other->as_npc()->is_friendly( who ) ) ) ) {
                collateral = query_yn( _( "Your attack may cause accidental injury, continue?" ) );
                if( !collateral ) {
                    return;
                }
                break;
            }
        }
    }
    std::ostringstream text;
    JsonOut out( text );
    out.start_object();
    out.member( "type", "action" );
    out.member( "action", "melee" );
    out.member( "mode", action == melee_action::reach ? "reach" :
                action == melee_action::technique ? "technique" : "strike" );
    out.member( "origin", who.pos_abs() );
    out.member( "target", get_map().get_abs( target ) );
    out.member( "technique", technique.str() );
    out.member( "allow_collateral", collateral );
    out.member( "grant_seq", mp_session().client_turn.client_last_grant_seq );
    out.member( "inventory_revision", mp_session().client_pickup.revision );
    if( Creature *victim = get_creature_tracker().creature_at( target, true ) ) {
        if( monster *mon = victim->as_monster() ) {
            const uint32_t id = mp_session().replication.client.monsters.known_id( *mon );
            if( id == 0 ) {
                return; // Wait for an identified host snapshot before targeting it.
            }
            out.member( "target_monster", id );
        } else if( Character *person = victim->as_character() ) {
            const player_id id = partner_identity( person->getID() );
            if( id.valid() ) {
                out.member( "target_player", id.str() );
            } else {
                out.member( "target_npc", person->getID().get_value() );
            }
        }
    }
    out.end_object();
    client_send( text.str() );
    who.set_moves( 0 );
    client_mark_action_sent();
}

void client_request_pickup( const Pickup::selection &selection )
{
    avatar &who = get_avatar();
    if( !is_client_mode() || who.get_moves() <= 0 || is_client_waiting_for_ack() ) {
        return;
    }
    const auto request = make_pickup_request( selection, get_map(), mp_session().client_pickup );
    if( !request ) {
        if( !selection.targets.empty() ) {
            add_msg( m_info, _( "The selected items could not be picked up." ) );
        }
        return;
    }
    mp_log( "[cdda-mp] mp_dispatch act=pickup path=SEND" );
    client_send( client_enrich_action( *request ) );
    who.set_moves( 0 );
    client_mark_action_sent();
}

void client_mark_action_sent()
{
    mp_log( "[cdda-mp] CLI-ACK-SET: ack guard SET, was=" + std::to_string(
                mp_session().client_turn.client_waiting_for_ack ) +
            " last_seq=" + std::to_string( mp_session().client_turn.client_last_grant_seq ) );
    mp_session().client_turn.client_waiting_for_ack = true;
    mp_session().client_turn.ack_set_time = std::chrono::steady_clock::now();
}

bool is_client_waiting_for_ack()
{
    return mp_session().client_turn.client_waiting_for_ack;
}

void mp_client_post_action( int pre_moves )
{
    if( !is_client_mode() || is_client_waiting_for_ack() ||
        mp_session().client_inventory_activity.active ) {
        // Intent-based actions already sent their request. In particular the
        // fire UI also handles reach attacks, which send their own request.
        return;
    }
    if( get_avatar().get_moves() >= pre_moves ) {
        return;
    }
    client_send( client_enrich_action( R"({"type":"action","action":"wait"})" ) );
    get_avatar().set_moves( 0 );
    client_mark_action_sent();
}

int ms_since_last_grant()
{
    using namespace std::chrono;
    return static_cast<int>(
               duration_cast<milliseconds>( steady_clock::now() -
                                            mp_session().client_turn.last_grant_time ).count() );
}

bool client_render_can_throttle()
{
    return is_client_mode() && static_cast<bool>( get_avatar().activity );
}

bool client_ctrl_veh()
{
    return mp_session().client_turn.client_ctrl_veh;
}

void set_client_ctrl_veh( bool b )
{
    mp_session().client_turn.client_ctrl_veh = b;
    if( !b ) {
        mp_session().client_turn.client_ctrl_veh_abs = tripoint_abs_ms{ 0, 0, 0 };
    }
}

tripoint_abs_ms client_ctrl_veh_abs()
{
    return mp_session().client_turn.client_ctrl_veh_abs;
}

void client_dispatch_wait_for_activity( const activity_id &pre_id, bool force_idle )
{
    if( mp_session().client_inventory_activity.active ) {
        // An owned activity sends step/cancel intents, including the frame
        // where its local view has just been canceled. Never append a wait.
        return;
    }

    if( !is_client_mode() || mp_session().client_turn.client_last_grant_seq == 0 ||
        mp_session().client_turn.client_waiting_for_ack ) {
        mp_log( "[cdda-mp] dispatch_wait: ack pending, skip" );
        return;
    }
    const player_activity &pact = get_avatar().activity;
    const activity_id &id = pact ? pact.id() : pre_id;
    if( !id && !force_idle ) {
        mp_log( "[cdda-mp] dispatch_wait: no activity, skip" );
        return;
    }
    mp_log( "[cdda-mp] dispatch_wait: SEND wait for act=" + ( id ? id.str() : "idle" ) );
    client_send( client_enrich_action( R"({"type":"action","action":"wait"})" ) );
    client_mark_action_sent();
}

// Signal-only lifecycle markers.  Bypass enrich (no stat blob needed) and do
// NOT set the ack guard — these are out-of-band notifications that don't
// participate in the grant/wait/ack cycle.  The host treats them as pure
// state-machine inputs that flip g_partner_activity.
void client_send_activity_start( const std::string &activity_id_str )
{
    if( ( activity_id_str == "ACT_RELOAD" || activity_id_str == "ACT_UNLOAD" ||
          activity_id_str == "ACT_INSERT_ITEM" || activity_id_str == "ACT_CONSUME" ||
          activity_id_str == "ACT_FIRSTAID" || activity_id_str == "ACT_CRAFT" ||
          activity_id_str == "ACT_CRAFT_WAIT" || activity_id_str == "ACT_BUILD" ||
          is_rest_activity( activity_id_str ) ) &&
        mp_session().client_inventory_activity.active ) {
        return;
    }

    if( !is_client_mode() || activity_id_str.empty() ) {
        return;
    }
    const std::string json = "{\"type\":\"action\",\"action\":\"activity_start\","
                             "\"activity_id\":\"" + activity_id_str + "\"}";
    const player_activity &cur = get_avatar().activity;
    mp_log( "[cdda-mp] ACT-START SEND: id=" + activity_id_str
            + " g_client_turn_activity=" + mp_session().client_turn.client_turn_activity
            + " av.activity=" + ( cur ? cur.id().str() : "none" )
            + " moves=" + std::to_string( get_avatar().get_moves() ) );
    client_send( json );
}

void client_send_activity_end( const std::string &activity_id_str )
{
    if( ( activity_id_str == "ACT_RELOAD" || activity_id_str == "ACT_UNLOAD" ||
          activity_id_str == "ACT_INSERT_ITEM" || activity_id_str == "ACT_CONSUME" ||
          activity_id_str == "ACT_FIRSTAID" || activity_id_str == "ACT_CRAFT" ||
          activity_id_str == "ACT_CRAFT_WAIT" || activity_id_str == "ACT_BUILD" ||
          is_rest_activity( activity_id_str ) ) &&
        mp_session().client_inventory_activity.active ) {
        return;
    }

    if( !is_client_mode() ) {
        return;
    }
    const std::string json = "{\"type\":\"action\",\"action\":\"activity_end\","
                             "\"activity_id\":\"" + activity_id_str + "\"}";
    const player_activity &cur = get_avatar().activity;
    mp_log( "[cdda-mp] ACT-END SEND: id=" + activity_id_str
            + " g_client_turn_activity=" + mp_session().client_turn.client_turn_activity
            + " av.activity=" + ( cur ? cur.id().str() : "none" )
            + " ack=" + std::to_string( mp_session().client_turn.client_waiting_for_ack )
            + " moves=" + std::to_string( get_avatar().get_moves() ) );
    client_send( json );
}

// MP construction sync.  A partial construction (in-progress build site: frame +
// consumed components + a progress counter) lives in the submap's
// partial_constructions map, NOT in the per-tile snapshot — so before this it was
// invisible to the other player even though the % rode the activity packet.  These
// helpers replicate server-owned sites to client views. Clients submit start,
// resume and remove intents instead of uploading site snapshots.

// Stable fingerprint: site identity + construction id + counter +
// component count (covers start/finish).  Empty when no build site here.
static std::string mp_partial_con_sig( const tripoint_bub_ms &bub )
{
    const partial_con *pc = get_map().partial_con_at( bub );
    if( !pc ) {
        return std::string();
    }
    return pc->id.obj().id.str() + ':' + std::to_string( pc->uid ) + ':' +
           std::to_string( pc->counter ) + ':' +
           std::to_string( pc->components.size() );
}

// Serialize the tile's partial_con to a JSON object.  Caller must confirm one
// exists (partial_con_at != nullptr) before calling.
static std::string mp_partial_con_obj_json( const tripoint_bub_ms &bub )
{
    const partial_con *pc = get_map().partial_con_at( bub );
    std::string comp_json = "[";
    bool cfirst = true;
    for( const item &it : pc->components ) {
        if( !cfirst ) {
            comp_json += ',';
        }
        cfirst = false;
        comp_json += serialize( it );
    }
    comp_json += "]";
    return R"({"con":")" + pc->id.obj().id.str() + R"(","counter":)" +
           std::to_string( pc->counter ) + ",\"uid\":" + std::to_string( pc->uid ) +
           ",\"components\":" + comp_json + "}";
}

// Apply a received "partial_con" object to a tile.  Updates the counter/id in
// place when a build site already exists here (the common per-turn case — avoids
// re-deserializing components and the partial_con_set "already has a partial con"
// debugmsg); otherwise creates a fresh one with its component pile.
static void mp_apply_partial_con_obj( const tripoint_bub_ms &bub, const JsonObject &po )
{
    po.allow_omitted_members();
    const construction_str_id con_sid( po.get_string( "con", "" ) );
    if( !con_sid.is_valid() ) {
        return;
    }
    const int counter = std::clamp( po.get_int( "counter", 0 ), 0, 10000000 );
    int64_t uid = 0;
    po.read( "uid", uid );
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    map &m = get_map();
    if( partial_con *existing = m.partial_con_at( bub ) ) {
        if( existing->uid == uid && existing->id == con_sid.id() ) {
            existing->counter = counter;
            return;
        }
        m.partial_con_remove( bub );
    }
    partial_con pc;
    pc.id = con_sid.id();
    pc.uid = uid;
    pc.counter = counter;
    if( po.has_array( "components" ) ) {
        for( const JsonValue &iv : po.get_array( "components" ) ) {
            try {
                item comp;
                JsonObject io = iv.get_object();
                io.allow_omitted_members();
                comp.deserialize( io, item_load_context::current_state );
                if( !comp.typeId().is_empty() && comp.typeId().is_valid() ) {
                    pc.components.push_back( std::move( comp ) );
                }
            } catch( const JsonError & ) {}
        }
    }
    m.partial_con_set( bub, pc );
}

// Server: scan the sync area and emit tile entries whose ter/furn/items changed since last broadcast.
static std::string build_tile_changes( remote_player_session &recipient,
                                       const tripoint_abs_ms &center, int radius )
{
    std::string out = "[";
    bool first = true;
    map &m = get_map();

    for( int dy = -radius; dy <= radius; ++dy ) {
        for( int dx = -radius; dx <= radius; ++dx ) {
            const tripoint_abs_ms abs{ center.x() + dx, center.y() + dy, center.z() };
            if( !m.inbounds( abs ) ) {
                continue;
            }
            const tripoint_bub_ms bub = m.get_bub( abs );
            const std::string ter_str  = m.ter( bub ).id().str();
            const std::string furn_str = m.furn( bub ).id().str();

            // Build item fingerprint and JSON simultaneously.
            // Full item serialize() is used so nested pocket contents are included.
            std::string items_sig;
            std::string items_json = "[]";
            map_stack items = m.i_at( bub );
            if( !items.empty() ) {
                items_json = "[";
                bool ifirst = true;
                for( const item &it : items ) {
                    const std::string item_json = serialize( it );
                    items_sig += item_json + ',';
                    if( !ifirst ) {
                        items_json += ',';
                    }
                    ifirst = false;
                    items_json += item_json;
                }
                items_json += "]";
            }

            // Build field fingerprint and JSON.
            std::string fields_sig;
            std::string fields_json = "[]";
            const field &fld = m.field_at( bub );
            if( fld.field_count() > 0 ) {
                fields_json = "[";
                bool ffield = true;
                for( const auto &[ftype, fentry] : fld ) {
                    if( !fentry.is_field_alive() ) {
                        continue;
                    }
                    const int fi = fentry.get_field_intensity();
                    fields_sig += ftype.id().str() + ':' + std::to_string( fi ) + ',';
                    if( !ffield ) {
                        fields_json += ',';
                    }
                    ffield = false;
                    fields_json += R"({"t":")" + ftype.id().str()
                                   + R"(","i":)" + std::to_string( fi ) + "}";
                }
                fields_json += "]";
            }

            // Trap — id string, empty when no placed trap (tr_null) or when the
            // trap is just the terrain's built-in (peer derives those from the
            // terrain itself; re-applying via trap_set triggers a debugmsg).
            const trap &tr      = m.tr_at( bub );
            const trap_id &builtin = m.ter( bub )->trap;
            const bool is_builtin = !tr.is_null() && tr.loadid == builtin;
            const std::string trap_sig = ( tr.is_null() || is_builtin ) ? "" : tr.id.str();

            // Graffiti.
            const std::string graffiti_sig = m.has_graffiti_at( bub ) ? m.graffiti_at( bub ) : "";

            // Partial construction (in-progress build site).  Its counter changes
            // every turn during a build, so it must enter the diff or the build
            // tile would be skipped once ter/furn/items settle.
            const std::string partial_con_sig = mp_partial_con_sig( bub );
            const bool has_pc = m.partial_con_at( bub ) != nullptr;

            auto &baseline = recipient.replication.tile_baseline[abs];
            if( baseline.ter == ter_str && baseline.furn == furn_str &&
                baseline.items_sig == items_sig && baseline.fields_sig == fields_sig &&
                baseline.trap_sig == trap_sig && baseline.graffiti_sig == graffiti_sig &&
                baseline.partial_con_sig == partial_con_sig ) {
                continue; // Nothing changed — skip this tile.
            }
            const bool had_pc = !baseline.partial_con_sig.empty();
            baseline.ter          = ter_str;
            baseline.furn         = furn_str;
            baseline.items_sig    = items_sig;
            baseline.fields_sig   = fields_sig;
            baseline.trap_sig     = trap_sig;
            baseline.graffiti_sig = graffiti_sig;
            baseline.partial_con_sig = partial_con_sig;

            if( !items_sig.empty() ) {
                mp_log( "tile_delta items @ " +
                        std::to_string( abs.x() ) + "," +
                        std::to_string( abs.y() ) + "," +
                        std::to_string( abs.z() ) );
            }
            if( !fields_sig.empty() ) {
                mp_log( "tile_delta fields @ " +
                        std::to_string( abs.x() ) + "," +
                        std::to_string( abs.y() ) + "," +
                        std::to_string( abs.z() ) + " : " + fields_sig );
            }

            if( !first ) {
                out += ',';
            }
            first = false;
            out += "{\"x\":" + std::to_string( abs.x() )
                   + ",\"y\":" + std::to_string( abs.y() )
                   + ",\"z\":" + std::to_string( abs.z() );
            out += R"(,"ter":")";
            out += ter_str;
            out += R"(","furn":")";
            out += furn_str;
            out += R"(","items":)";
            out += items_json;
            out += ",\"fields\":";
            out += fields_json;
            out += R"(,"trap":")";
            out += trap_sig.empty() ? "tr_null" : trap_sig;
            out += R"(","graffiti":")";
            out += json_escape_str( graffiti_sig );
            out += '"';
            if( has_pc ) {
                out += ",\"partial_con\":" + mp_partial_con_obj_json( bub );
            } else if( had_pc ) {
                out += ",\"partial_con_remove\":true";
            }
            out += "}";
        }
    }
    out += ']';
    return out;
}

static std::string build_monster_list( remote_player_session &recipient,
                                       const tripoint_abs_ms &center, int radius )
{
    // Periodic keyframe: every KEYFRAME_INTERVAL broadcasts, drop the delta cache
    // so the full snapshot goes out. Self-heals any drift (a fresh joiner that
    // missed the on-connect clear, a dropped packet) without per-turn cost the
    // rest of the time. Cheap: monsters that haven't changed simply re-serialize.
    constexpr int KEYFRAME_INTERVAL = 120;
    // MP diagnostic toggle: CDDA_MP_NO_DELTA=1 forces a full monster snapshot
    // every broadcast (disables delta-encoding). Lets us isolate the client
    // load-in hard-hang (2026-06-26) to the delta path without rebuilding
    // between test runs — set the env on the host and restart.
    static const bool s_force_keyframe = [] {
        const char *e = std::getenv( "CDDA_MP_NO_DELTA" );
        return e && *e && *e != '0';
    }();
    const bool keyframe = s_force_keyframe ||
                          ( recipient.replication.keyframe_ctr++ % KEYFRAME_INTERVAL ) == 0;
    if( keyframe ) {
        recipient.replication.server_mon_last_sent.clear();
    }

    const auto *peek = active_peek( recipient );
    std::string out = "[";
    bool first = true;
    int n_sent = 0;        // monsters actually written to the wire this call
    int n_skipped = 0;     // in-radius but unchanged → omitted (the delta win)
    std::unordered_set<uint32_t> seen_nids;  // in-radius nids this call (for pruning)
    std::string excluded_near;  // in reality bubble but outside broadcast radius
    for( const auto &mon_ptr : get_creature_tracker().get_monsters_list() ) {
        if( !mon_ptr ) {
            continue;
        }
        const tripoint_abs_ms mp = mon_ptr->pos_abs();
        const point delta{ std::abs( mp.x() - center.x() ), std::abs( mp.y() - center.y() ) };
        if( ( delta.x > radius || delta.y > radius || mp.z() != center.z() ) &&
            ( !peek || !peek->contains( mp, radius ) ) ) {
            // Diagnostic: a monster inside the reality bubble (≤84) but outside
            // this broadcast radius is NOT sent, so the client culls it
            // (MON-SYNC cull) even though it's alive on the host — the "monster
            // died for no reason near the players" bug. The broadcast is centered
            // on the client PROXY, which lags the real client, so the window can
            // sit off the monsters the client sees.
            if( mp.z() == center.z() && delta.x <= 84 && delta.y <= 84 ) {
                excluded_near += mon_ptr->type->id.str() + "@d" +
                                 std::to_string( std::max( delta.x, delta.y ) ) + " ";
            }
            continue;
        }
        // Assign a stable network ID the first time this monster enters sync range.
        // Done for EVERY in-radius monster (even ones we delta-omit below) so the
        // removed_monsters diff (g_server_mon_known_nids) stays accurate.
        const uint32_t nid = mp_session().replication.entity_ids.assign( *mon_ptr );
        seen_nids.insert( nid );
        const int mon_facing = ( mon_ptr->facing == FacingDirection::LEFT ) ? 0 : 1;
        std::ostringstream nickname;
        JsonOut name_out( nickname );
        name_out.write( mon_ptr->nickname );
        std::string rec = "{\"nid\":" + std::to_string( nid )
                          + R"(,"id":")" + mon_ptr->type->id.str() + "\""
                          + ",\"x\":" + std::to_string( mp.x() )
                          + ",\"y\":" + std::to_string( mp.y() )
                          + ",\"z\":" + std::to_string( mp.z() )
                          + ",\"hp\":" + std::to_string( mon_ptr->get_hp() )
                          + ",\"facing\":" + std::to_string( mon_facing )
                          + ",\"nickname\":" + nickname.str() + "}";
        // Delta gate: emit only if new or changed since last broadcast. nid + id
        // are stable, so an identical record string means x/y/z/hp/facing are all
        // unchanged → the client already holds this exact state, omit it.
        auto cached = recipient.replication.server_mon_last_sent.find( nid );
        if( cached != recipient.replication.server_mon_last_sent.end() && cached->second == rec ) {
            ++n_skipped;
            continue;
        }
        recipient.replication.server_mon_last_sent[nid] = rec;
        if( !first ) {
            out += ',';
        }
        first = false;
        out += rec;
        ++n_sent;
    }
    out += ']';
    // Prune cache entries for nids no longer in radius so a monster that leaves
    // and later re-enters is re-sent in full (its state may have changed while
    // out of range, and the client removed it via removed_monsters on exit).
    if( recipient.replication.server_mon_last_sent.size() > seen_nids.size() ) {
        for( auto it = recipient.replication.server_mon_last_sent.begin();
             it != recipient.replication.server_mon_last_sent.end(); ) {
            it = seen_nids.count( it->first ) ? std::next( it )
                 : recipient.replication.server_mon_last_sent.erase( it );
        }
    }
    // Log only when the excluded-near set changes — this fires every broadcast
    // while a distant monster lingers in the 40–84 band and would otherwise spam.
    if( excluded_near != mp_session().presentation.last_excluded_near ) {
        mp_session().presentation.last_excluded_near = excluded_near;
        if( !excluded_near.empty() ) {
            mp_log( "[cdda-mp] MON-BROADCAST: sent=" + std::to_string( n_sent ) +
                    " radius=" + std::to_string( radius ) +
                    " EXCLUDED-NEAR (in bubble, not synced to client): " + excluded_near );
        }
    }
    // Diagnostic: monsters actually broadcast this tick vs the host's full live
    // tracker count. A persistent gap (host holds many, sends few) means monsters
    // sit outside the 84-radius window centered on the client proxy — the band the
    // client can fill with its own divergent local-mapgen monsters that the host
    // has no copy of ("client sees enemies the host can't kill" report). Pair this
    // with the client's MON-PHANTOM line. Logged on change to avoid per-tick spam.
    if( n_sent != mp_session().presentation.last_n_sent ) {
        mp_session().presentation.last_n_sent = n_sent;
        int n_tracker = 0;
        for( const auto &t_ptr : get_creature_tracker().get_monsters_list() ) {
            if( t_ptr && !t_ptr->is_dead() ) {
                ++n_tracker;
            }
        }
        mp_log( "[cdda-mp] MON-BROADCAST-COUNT: sent=" + std::to_string( n_sent ) +
                " skipped(delta)=" + std::to_string( n_skipped ) +
                " radius=" + std::to_string( radius ) +
                " host_tracker_alive=" + std::to_string( n_tracker ) );
    }
    return out;
}

// Client: apply terrain, furniture, and item changes received from the server.
static void apply_tile_changes( JsonObject &jo )
{
    if( !jo.has_array( "tile_changes" ) ) {
        return;
    }
    map &m = get_map();
    bool any_new_trap = false;

    // Diagnostic: is the host's terrain reaching us, and does it differ from
    // our own world-gen terrain?  ter_seen = tiles carrying a "ter"; ter_diff =
    // tiles where the host's terrain differs from what we already had locally
    // (i.e. our scratch-world map disagreeing with the host's).
    int ter_seen = 0;
    int ter_diff = 0;
    int ter_logged = 0;

    for( const JsonValue &entry : jo.get_array( "tile_changes" ) ) {
        JsonObject to = entry.get_object();
        to.allow_omitted_members();

        const tripoint_abs_ms abs{
            to.get_int( "x" ), to.get_int( "y" ), to.get_int( "z" )
        };
        if( !m.inbounds( abs ) ) {
            continue;
        }
        const tripoint_bub_ms bub = m.get_bub( abs );

        std::string ter_str;
        std::string furn_str;
        to.read( "ter", ter_str );
        to.read( "furn", furn_str );

        if( !ter_str.empty() ) {
            ter_seen++;
            const std::string local_ter = m.ter( bub ).id().str();
            if( local_ter != ter_str ) {
                ter_diff++;
                if( ter_logged < 8 ) {
                    ter_logged++;
                    mp_log( "[cdda-mp] apply_tile_changes: TER @ " +
                            std::to_string( abs.x() ) + "," + std::to_string( abs.y() ) +
                            " local=" + local_ter + " -> host=" + ter_str );
                }
            }
            m.ter_set( bub, ter_id( ter_str ) );
        }
        if( !furn_str.empty() ) {
            // furn_reset=true — see comment on the other MP furn_set call.
            m.furn_set( bub, furn_id( furn_str ), /* furn_reset */ true );
        }

        if( to.has_array( "items" ) ) {
            // Log any items that currently exist locally but are about to be
            // cleared — these are client-only drops that the server doesn't know
            // about and will erase.
            map_stack existing = m.i_at( bub );
            if( !existing.empty() ) {
                std::string had;
                for( const item &it : existing ) {
                    had += it.typeId().str() + ' ';
                }
                mp_log( "[cdda-mp] apply_tile_changes: clearing local items @ " +
                        std::to_string( abs.x() ) + "," +
                        std::to_string( abs.y() ) + "," +
                        std::to_string( abs.z() ) + " had=[" + had + "]" );
            }
            m.i_clear( bub );
            std::string applied;
            for( const JsonValue &iv : to.get_array( "items" ) ) {
                try {
                    item new_item;
                    JsonObject io = iv.get_object();
                    io.allow_omitted_members();
                    new_item.deserialize( io );
                    if( !new_item.typeId().is_empty() && new_item.typeId().is_valid() ) {
                        applied += new_item.typeId().str() + ' ';
                        // Restore the server's item state without running placement effects on the replica.
                        m.add_item_unprocessed( bub, std::move( new_item ), true );
                    }
                } catch( const JsonError & ) {}
            }
            if( !applied.empty() ) {
                mp_log( "[cdda-mp] apply_tile_changes: set items @ " +
                        std::to_string( abs.x() ) + "," +
                        std::to_string( abs.y() ) + "," +
                        std::to_string( abs.z() ) + " items=[" + applied + "]" );
            }
        }

        if( to.has_array( "fields" ) ) {
            // Clear all existing fields on this tile, then apply the server's set.
            field &fld = m.field_at( bub );
            std::vector<field_type_id> to_remove;
            for( const auto &[ftype, fentry] : fld ) {
                to_remove.push_back( ftype );
            }
            for( const field_type_id &ftype : to_remove ) {
                m.delete_field( bub, ftype );
            }
            for( const JsonValue &fv : to.get_array( "fields" ) ) {
                JsonObject fo = fv.get_object();
                fo.allow_omitted_members();
                const std::string type_str = fo.get_string( "t", "" );
                if( type_str.empty() ) {
                    continue;
                }
                const field_type_id ftid( type_str );
                if( ftid.is_valid() ) {
                    m.add_field( bub, ftid, fo.get_int( "i", 1 ) );
                }
            }
        }

        if( to.has_string( "trap" ) ) {
            const std::string trap_str = to.get_string( "trap" );
            // Skip if the terrain has a built-in trap (e.g. downspout funnel on
            // t_gutter_downspout); trap_set refuses any trap on such tiles and
            // debugmsgs.  Peer derives the trap from the terrain.
            const trap_id &builtin = m.ter( bub )->trap;
            if( builtin != tr_null ) {
                // no-op
            } else if( trap_str.empty() || trap_str == "tr_null" ) {
                m.trap_set( bub, tr_null );
            } else {
                const trap_str_id tsid( trap_str );
                if( tsid.is_valid() ) {
                    m.trap_set( bub, tsid.id() );
                    any_new_trap = true;
                }
            }
        }

        if( to.has_string( "graffiti" ) ) {
            const std::string gtext = to.get_string( "graffiti" );
            if( gtext.empty() ) {
                m.delete_graffiti( bub );
            } else {
                m.set_graffiti( bub, gtext );
            }
        }

        // Partial construction (the host's in-progress build site).  An object
        // creates/updates it; partial_con_remove clears it (build finished or
        // cancelled). Clients never upload these replicated sites.
        if( to.has_object( "partial_con" ) ) {
            mp_apply_partial_con_obj( bub, to.get_object( "partial_con" ) );
        } else if( to.get_bool( "partial_con_remove", false ) ) {
            if( m.partial_con_at( bub ) ) {
                m.partial_con_remove( bub );
            }
        }
    }

    if( ter_seen > 0 ) {
        mp_log( "[cdda-mp] apply_tile_changes: batch ter_seen=" + std::to_string( ter_seen ) +
                " ter_diff=" + std::to_string( ter_diff ) +
                "  (ter_diff>0 => host terrain differs from our local world-gen)" );
    }

    // Run detection so newly synced traps show the warning tile immediately,
    // mirroring the search_surroundings() call that SP makes after every move.
    if( any_new_trap ) {
        get_avatar().search_surroundings();
    }
}

// Client: apply vehicle position, facing, and velocity from the server state packet.
// Scope: stationary and moving vehicles visible to the host.  Driving, boarding,
// and reality-bubble edge transitions are excluded until those features are designed.
static void apply_vehicle_sync( JsonObject &jo )
{
    if( !jo.has_array( "vehicles" ) ) {
        return;
    }
    map &m = get_map();

    auto &known = mp_session().replication.client.vehicle_uids;
    std::unordered_map<int64_t, vehicle *> vehicles;
    for( const wrapped_vehicle &local : m.get_vehicles() ) {
        if( local.v ) {
            vehicles.emplace( local.v->uid().get_value(), local.v );
        }
    }
    const auto lookup = [&]( int64_t uid ) -> vehicle * {
        const auto found = vehicles.find( uid );
        return found == vehicles.end() ? nullptr : found->second;
    };
    if( jo.has_array( "removed_vehicles" ) ) {
        for( const JsonValue &removed : jo.get_array( "removed_vehicles" ) ) {
            const auto entry = known.find( static_cast<uint32_t>( removed.get_int() ) );
            if( entry != known.end() ) {
                if( vehicle *old = lookup( entry->second ) ) {
                    vehicles.erase( entry->second );
                    m.destroy_vehicle( old );
                }
                known.erase( entry );
            }
        }
    }
    const JsonArray incoming = jo.get_array( "vehicles" );
    std::unordered_set<int64_t> host_uids;
    for( const JsonValue &entry : incoming ) {
        const JsonObject description = entry.get_object();
        description.allow_omitted_members();
        const int64_t uid = description.has_member( "uid" ) ? description.get_int64( "uid" ) : 0;
        if( uid > 0 ) {
            host_uids.insert( uid );
        }
    }

    for( const JsonValue &entry : incoming ) {
        JsonObject vo = entry.get_object();
        vo.allow_omitted_members();
        const uint32_t nid = static_cast<uint32_t>( vo.get_int( "nid", 0 ) );
        const tripoint_abs_ms new_abs{ vo.get_int( "x" ), vo.get_int( "y" ), vo.get_int( "z" ) };
        const int face_deg = vo.get_int( "face", 0 );
        const int turn_dir_deg = vo.get_int( "turn_dir", face_deg );
        const int vel = vo.get_int( "vel", 0 );
        const int cruise = vo.get_int( "cruise", vel );
        const std::string vname = vo.get_string( "name", "" );
        const auto prior = known.find( nid );
        const bool first_encounter = prior == known.end();
        const int64_t uid = vo.has_member( "uid" ) ? vo.get_int64( "uid" ) :
                            ( first_encounter ? 0 : prior->second );

        if( vo.has_object( "snapshot" ) && m.inbounds( new_abs ) ) {
            JsonObject snapshot = vo.get_object( "snapshot" );
            snapshot.allow_omitted_members();
            auto replica = std::make_unique<vehicle>( vehicle_prototype_none );
            replica->deserialize( snapshot );
            const int64_t identity = replica->uid().get_value();
            if( identity <= 0 || ( uid > 0 && uid != identity ) ) {
                continue;
            }
            vehicle *previous = lookup( identity );
            if( !previous ) {
                const auto at_origin = m.veh_at( m.get_bub( new_abs ) );
                if( at_origin && at_origin->vehicle().pos_abs() == new_abs &&
                    !host_uids.count( at_origin->vehicle().uid().get_value() ) ) {
                    previous = &at_origin->vehicle();
                }
            }
            const int64_t previous_uid = previous ? previous->uid().get_value() : 0;
            if( vehicle *restored = m.restore_vehicle_snapshot( std::move( replica ), new_abs, previous ) ) {
                vehicles.erase( previous_uid );
                vehicles[identity] = restored;
                known[nid] = identity;
                host_uids.insert( identity );
            }
            continue;
        }

        vehicle *found = lookup( uid );
        if( !found ) {
            continue;
        }
        known[nid] = uid;

        // Compute target facing.
        const units::angle face_angle = units::from_degrees( face_deg );
        const bool face_changed = ( found->face.dir() != face_angle );

        // Always prime precalc[1] before any displacement.
        // displace_vehicle → advance_precalc_mounts copies precalc[1] → precalc[0]
        // then calls add_vehicle_to_cache.  Without this, a pure translation (no face
        // change) would copy stale precalc[1] into the cache — wrong part positions.
        found->pivot_rotation[1] = face_angle;
        found->precalc_mounts( 1, face_angle, found->pivot_point( m ) );

        // Move vehicle to server-authoritative position if it has changed AND the
        // target is inside the client's loaded map.  Driving out of the bubble is
        // handled naturally when the submaps unload; we don't force the vehicle to
        // follow into territory the client hasn't loaded.
        bool did_displace = false;
        if( found->pos_abs() != new_abs && m.inbounds( new_abs ) ) {
            const tripoint_bub_ms cur_bub = found->pos_bub( m );
            const tripoint_bub_ms new_bub = m.get_bub( new_abs );
            const tripoint_rel_ms dp      = new_bub - cur_bub;
            if( dp != tripoint_rel_ms::zero ) {
                m.displace_vehicle( *found, dp );
                did_displace = true;
                // advance_precalc_mounts inside displace_vehicle already:
                //   - cleared the rendering cache at old positions
                //   - copied precalc[1] (new facing) → precalc[0]
                //   - set pivot_rotation[0] = pivot_rotation[1] = face_angle
                // add_vehicle_to_cache was called inside displace_vehicle with the
                // correct new-facing part positions.
            }
        }


        // Finalise facing state.  face.init() and move.init() must still be updated
        // even when displace_vehicle already set pivot_rotation[0].
        // turn_dir synced unconditionally: it updates immediately after pldrive on the
        // server (before vehmove), so the client sees the new intended heading right away.
        found->turn_dir = units::from_degrees( turn_dir_deg );

        if( face_changed ) {
            found->face.init( face_angle );
            found->move.init( face_angle );
            found->pivot_rotation[0] = face_angle;

            if( !did_displace ) {
                // No displacement occurred: advance_precalc_mounts was NOT called,
                // so precalc[0] and the rendering cache still reflect the old facing.
                // Clear the stale cache entries, recompute precalc[0], then re-add.
                for( const vpart_reference &vpr : found->get_all_parts_with_fakes() ) {
                    if( !vpr.part().removed ) {
                        m.clear_vehicle_point_from_cache( found,
                                                          found->bub_part_pos( m, vpr.part() ) );
                    }
                }
                found->precalc_mounts( 0, face_angle, found->pivot_point( m ) );
                m.add_vehicle_to_cache( found );
            }
            // did_displace case: cache and precalc[0] are already correct (set by
            // advance_precalc_mounts from the pre-set precalc[1]).
        }

        // First encounter: vehicle may have uninitialized precalc (debug spawn, save
        // load without a physics tick, etc.).  Force a full rebuild so the render
        // cache reflects correct part positions from the start.
        if( first_encounter && !did_displace && !face_changed ) {
            for( const vpart_reference &vpr : found->get_all_parts_with_fakes() ) {
                if( !vpr.part().removed ) {
                    m.clear_vehicle_point_from_cache( found,
                                                      found->bub_part_pos( m, vpr.part() ) );
                }
            }
            found->precalc_mounts( 0, found->face.dir(), found->pivot_anchor[0] );
            m.add_vehicle_to_cache( found );
        }

        // Update velocity and cruise target (server is authoritative for physics).
        found->velocity = vel;
        found->cruise_velocity = cruise;

        // Sync vehicle name — server is authoritative; overrides any local rename.
        if( !vname.empty() && found->name != vname ) {
            found->name = vname;
        }

        // Apply per-part state (open/enabled).  Parts are indexed by sequential
        // position over get_all_parts() — same iteration order on both sides.
        if( vo.has_array( "parts" ) ) {
            std::vector<vpart_reference> parts;
            for( const vpart_reference &vpr : found->get_all_parts() ) {
                parts.push_back( vpr );
            }

            bool parts_changed = false;
            for( const JsonValue &pv : vo.get_array( "parts" ) ) {
                JsonObject po = const_cast<JsonValue &>( pv ).get_object();
                po.allow_omitted_members();
                const int idx = po.get_int( "i", -1 );
                if( idx < 0 || idx >= static_cast<int>( parts.size() ) ) {
                    continue;
                }
                const vpart_reference &part = parts[idx];
                vehicle_part &vp = part.part();
                const bool new_open    = po.get_bool( "open",    vp.open );
                const bool new_enabled = po.get_bool( "enabled", vp.enabled );
                if( vp.open != new_open || vp.enabled != new_enabled ) {
                    vp.open    = new_open;
                    vp.enabled = new_enabled;
                    parts_changed = true;
                }
                // HP: server is authoritative; apply if it differs from local value.
                const int new_hp = po.get_int( "hp", -1 );
                if( new_hp >= 0 && new_hp != vp.hp() ) {
                    found->set_hp( vp, new_hp, true );
                    parts_changed = true;
                }
                // Fuel: sync amount for tanks and fuel stores.
                std::string fuel_type_str;
                if( po.read( "fuel_type", fuel_type_str ) && !fuel_type_str.empty() ) {
                    const itype_id ftype( fuel_type_str );
                    const int fuel_amt = po.get_int( "fuel_amt", 0 );
                    if( vp.is_tank() && po.has_member( "liquid_uid" ) ) {
                        const int64_t liquid_uid = po.get_int64( "liquid_uid" );
                        const item &base = vp.get_base();
                        if( fuel_amt > 0 && !base.empty() && base.legacy_front().typeId() == ftype &&
                            base.legacy_front().uid().get_value() == liquid_uid &&
                            vp.ammo_remaining() != fuel_amt ) {
                            item_location tank = found->part_base( part.part_index() );
                            tank->legacy_front().charges = fuel_amt;
                            tank.on_contents_changed();
                            found->invalidate_mass();
                        }
                    } else if( ftype.is_valid() && vp.ammo_remaining() != fuel_amt ) {
                        vp.ammo_set( ftype, fuel_amt );
                    }
                }
            }
            // Rebuild the render cache so part sprite changes are visible immediately.
            if( parts_changed ) {
                for( const vpart_reference &vpr : found->get_all_parts_with_fakes() ) {
                    if( !vpr.part().removed ) {
                        m.clear_vehicle_point_from_cache( found,
                                                          found->bub_part_pos( m, vpr.part() ) );
                    }
                }
                found->precalc_mounts( 0, found->face.dir(), found->pivot_anchor[0] );
                m.add_vehicle_to_cache( found );
            }
        }

        if( vo.has_array( "cargo" ) ) {
            for( const JsonValue &entry : vo.get_array( "cargo" ) ) {
                const JsonObject cargo = entry.get_object();
                cargo.allow_omitted_members();
                const tripoint_abs_ms position{ cargo.get_int( "x" ), cargo.get_int( "y" ), cargo.get_int( "z" ) };
                if( !m.inbounds( position ) ) {
                    continue;
                }
                const auto at = m.veh_at( m.get_bub( position ) ).cargo();
                const int64_t part_uid = cargo.has_member( "part" ) ? cargo.get_int64( "part" ) : 0;
                if( !at || &at->vehicle() != found ||
                    ( part_uid > 0 && at->part().get_base().uid().get_value() != part_uid ) ) {
                    continue;
                }
                std::vector<item> contents;
                for( const JsonValue &value : cargo.get_array( "items" ) ) {
                    item restored;
                    const JsonObject data = value.get_object();
                    data.allow_omitted_members();
                    restored.deserialize( data );
                    if( !restored.is_null() && restored.typeId().is_valid() ) {
                        contents.emplace_back( std::move( restored ) );
                    }
                }
                found->restore_cargo( m, at->part(), std::move( contents ) );
            }
        }
    }

    // Full lists contain every authoritative vehicle in the same loaded region.
    // Preserve the avatar's current vehicle until boarding state is reconciled.
    if( host_uids.size() == incoming.size() ) {
        const auto avatar_part = m.veh_at( get_avatar().pos_bub() );
        const vehicle *avatar_vehicle = avatar_part ? &avatar_part->vehicle() : nullptr;
        for( const wrapped_vehicle &local : m.get_vehicles() ) {
            if( local.v && local.v != avatar_vehicle && !host_uids.count( local.v->uid().get_value() ) ) {
                m.destroy_vehicle( local.v );
            }
        }
    }
}

static void apply_monster_sync( JsonObject &jo )
{
    if( !jo.has_array( "monsters" ) ) {
        return;
    }

    creature_tracker &ct = get_creature_tracker();
    const std::vector<shared_ptr_fast<monster>> &mons = ct.get_monsters_list();
    map &m = get_map();

    // DIAGNOSTIC (resurrection #2): track every net_id we've ever held a live copy
    // of, erased only when the host EXPLICITLY removes it (removed_monsters below).
    // If we then spawn an nid still in this set, the client lost it WITHOUT a host
    // removal — a silent drop (suspected client update_map/teleport unload), the
    // resurrection flicker. Distinct from legit re-entry (host removed it first, so
    // the nid was erased and a re-spawn is expected, not flagged).

    monster_mirrors &mirrors = mp_session().replication.client.monsters;
    mirrors.begin_sync( ct );

    std::optional<peek_authorization> peek;
    if( jo.has_object( "peek" ) ) {
        peek.emplace();
        jo.read( "peek", *peek, true );
    }
    constexpr int SYNC_RADIUS = 84;   // match build_monster_list's broadcast radius
    const tripoint_abs_ms region_center = mp_session().host_observation.mp_remote_pos;

    // Collect all client monsters inside the sync region for cleanup pass.
    std::unordered_set<monster *> in_region;
    for( const auto &ptr : mons ) {
        monster *mon = ptr.get();
        if( !mon ) {
            continue;
        }
        const tripoint_abs_ms mp = mon->pos_abs();
        if( ( std::abs( mp.x() - region_center.x() ) <= SYNC_RADIUS &&
              std::abs( mp.y() - region_center.y() ) <= SYNC_RADIUS &&
              mp.z() == region_center.z() ) || ( peek && peek->contains( mp, SYNC_RADIUS ) ) ) {
            in_region.insert( mon );
        }
    }

    std::unordered_set<monster *> matched;
    std::unordered_set<uint32_t> received_ids;
    int n_recv = 0;
    int n_spawned = 0;
    int n_culled = 0;
    std::string culled_log;
    const auto remove_mirror = [&]( uint32_t id ) {
        mp_session().replication.client.ever_seen_nids.erase( id );
        if( monster *removed = mirrors.unbind( id ) ) {
            culled_log += removed->type->id.str() + "(nid=" + std::to_string( id ) + ") ";
            ++n_culled;
            in_region.erase( removed );
            g->remove_zombie( *removed );
        }
    };

    for( const JsonValue &entry : jo.get_array( "monsters" ) ) {
        JsonObject mo = entry.get_object();
        mo.allow_omitted_members();
        ++n_recv;

        const int wire_id = mo.get_int( "nid", 0 );
        if( wire_id <= 0 || !received_ids.insert( static_cast<uint32_t>( wire_id ) ).second ) {
            continue;
        }
        const uint32_t nid = static_cast<uint32_t>( wire_id );
        const int server_hp = mo.get_int( "hp", -1 );
        if( server_hp == 0 ) {
            remove_mirror( nid );
            continue;
        }
        const tripoint_abs_ms target{
            mo.get_int( "x" ), mo.get_int( "y" ), mo.get_int( "z" )
        };

        // --- Primary lookup: stable network ID ---
        monster *best = mirrors.find( nid );

        // --- Fallback: proximity + type for monsters not yet assigned an ID ---
        // Covers a new admission: native monsters do not carry another host's IDs.
        if( best == nullptr ) {
            std::string id_str;
            mo.read( "id", id_str );
            if( !id_str.empty() ) {
                const mtype_id mid( id_str );
                int best_dist = 15;
                for( const auto &ptr : mons ) {
                    monster *mon = ptr.get();
                    if( !mon || mon->type->id != mid || matched.count( mon ) ) {
                        continue;
                    }
                    const uint32_t existing = mirrors.known_id( *mon );
                    if( existing != 0 && existing != nid ) {
                        continue;  // Already tracked under a different server ID
                    }
                    const tripoint_abs_ms mp = mon->pos_abs();
                    const int dist = std::abs( mp.x() - target.x() ) +
                                     std::abs( mp.y() - target.y() );
                    if( dist < best_dist ) {
                        best_dist = dist;
                        best = mon;
                    }
                }
                // Assign the server's ID so future lookups are O(1).
                if( best != nullptr && !mirrors.bind( nid, *best ) ) {
                    continue;
                }
            }
        }

        // --- Spawn: server has a monster the client doesn't know about ---
        if( best == nullptr && m.inbounds( target ) && server_hp > 0 ) {
            std::string id_str;
            mo.read( "id", id_str );
            if( !id_str.empty() ) {
                const mtype_id mid( id_str );
                const tripoint_bub_ms bub = m.get_bub( target );
                auto new_mon = make_shared_fast<monster>( mid, bub );
                new_mon->set_hp( server_hp );
                best = g->place_critter_at( new_mon, bub );
                if( best != nullptr && !mirrors.bind( nid, *best ) ) {
                    g->remove_zombie( *best );
                    best = nullptr;
                }
                if( best != nullptr ) {
                    ++n_spawned;
                    const bool silently_dropped = nid != 0 &&
                                                  mp_session().replication.client.ever_seen_nids.count( nid );
                    mp_log( "[cdda-mp] MON-SPAWN: " + id_str + " nid=" +
                            std::to_string( nid ) + " @ " + std::to_string( target.x() ) +
                            "," + std::to_string( target.y() ) + " hp=" +
                            std::to_string( server_hp ) );
                    if( silently_dropped ) {
                        mp_log( "[cdda-mp] MON-RESPAWN-DROPPED: nid=" + std::to_string( nid ) +
                                " (" + id_str + ") re-spawned but host never removed it — "
                                "client silently lost & re-added it (resurrection flicker)" );
                    }
                }
            }
        }

        if( best == nullptr ) {
            continue;
        }

        matched.insert( best );
        mp_session().replication.client.ever_seen_nids.insert( nid );

        // Correct position if the server disagrees.
        if( best->pos_abs() != target && m.inbounds( target ) ) {
            const shared_ptr_fast<monster> occupant = ct.find( target );
            if( !occupant || occupant.get() == best ) {
                best->setpos( target, false );
            }
        }

        if( server_hp > 0 ) {
            best->set_hp( server_hp );
        }

        // Sync facing direction for correct sprite flip.
        mo.read( "nickname", best->nickname );
        if( mo.has_int( "facing" ) ) {
            best->facing = mo.get_int( "facing" ) == 0
                           ? FacingDirection::LEFT : FacingDirection::RIGHT;
        }
    }

    // Cull purely client-local monsters: any monster inside the host's broadcast
    // region with NO network id that the host didn't report this turn comes from
    // the client's own divergent local mapgen (a client-local map feature the
    // host's world doesn't have — e.g. a refugee center with turkeys/NPCs).  Host
    // monsters always receive a net id on match/spawn, so no current binding reliably
    // means "never corresponded to a host monster," and the host's authoritative
    // list covers this whole region — so the absence is real.  This is NOT the
    // old cull-by-absence (which killed *synced* monsters, net_id!=0, on a missed
    // broadcast — the woodpecker bug); those are untouched here.  remove_zombie
    // despawns cleanly (no corpse, which would itself be a desync).
    {
        std::vector<monster *> local_cull;
        std::vector<monster *> ordered_in_region( in_region.begin(), in_region.end() );
        std::sort( ordered_in_region.begin(), ordered_in_region.end(),
        []( const monster * lhs, const monster * rhs ) {
            return lhs->pos_abs() < rhs->pos_abs();
        } );
        for( monster *mon : ordered_in_region ) {
            if( mon && mirrors.known_id( *mon ) == 0 && !matched.count( mon ) && !mon->is_dead() ) {
                local_cull.push_back( mon );
            }
        }
        for( monster *mon : local_cull ) {
            culled_log += mon->type->id.str() + "(local) ";
            ++n_culled;
            g->remove_zombie( *mon );
        }
    }

    // Client-local monsters (unbound, unmatched, alive) OUTSIDE the host's
    // broadcast/cull region (>84 of region_center). These were never broadcast by
    // the host — a host monster gets a net_id the first time it enters sync range
    // (build_monster_list), so net_id==0 here means the host has NO synced copy.
    // They're local-mapgen phantoms: the "killed a zed, it rose again" report is
    // the host-synced twin dying authoritatively while this local copy lingers,
    // since the in-region cull above can't reach them (region_center = the lagging
    // proxy g_mp_remote_pos, which drifts off this client's avatar).
    // CULL them — but only after they persist unclaimed for PHANTOM_CULL_SYNCS
    // consecutive syncs. A *real* host monster at the leading edge of client
    // movement is briefly net_id==0 (client mapgen spawned it before the host's
    // broadcast reached it), but the proximity-adoption pass assigns it a net_id
    // within a sync or two — which removes it from this set and resets its strike
    // count. A phantom is never adopted, so only phantoms reach the threshold.
    // Phantoms are inert on the client (no local monmove) → stable position key.
    {
        constexpr int PHANTOM_CULL_SYNCS = 3;
        std::unordered_map<std::string, int> seen_now;
        std::vector<monster *> phantom_cull;
        int n_phantom = 0;
        std::string phantom_log;
        const tripoint_abs_ms av = get_avatar().pos_abs();
        for( const auto &ptr : mons ) {
            monster *mon = ptr.get();
            if( !mon || mirrors.known_id( *mon ) != 0 || matched.count( mon ) || mon->is_dead() ) {
                continue;
            }
            if( in_region.count( mon ) ) {
                continue;  // inside cull region — already handled above
            }
            ++n_phantom;
            const tripoint_abs_ms mp = mon->pos_abs();
            const std::string key = mon->type->id.str() + "@" +
                                    std::to_string( mp.x() ) + "," +
                                    std::to_string( mp.y() ) + "," +
                                    std::to_string( mp.z() );
            const auto prev = mp_session().replication.client.phantom_strikes.find( key );
            const int strikes = ( prev != mp_session().replication.client.phantom_strikes.end() ? prev->second :
                                  0 ) + 1;
            seen_now[key] = strikes;
            phantom_log += mon->type->id.str() + "@dAvatar" +
                           std::to_string( std::max( std::abs( mp.x() - av.x() ),
                                           std::abs( mp.y() - av.y() ) ) ) +
                           "(s" + std::to_string( strikes ) + ") ";
            if( strikes >= PHANTOM_CULL_SYNCS ) {
                phantom_cull.push_back( mon );
            }
        }
        mp_session().replication.client.phantom_strikes.swap( seen_now );   // drop keys not seen this sync
        for( monster *mon : phantom_cull ) {
            culled_log += mon->type->id.str() + "(phantom) ";
            ++n_culled;
            g->remove_zombie( *mon );          // clean despawn, no corpse
        }
        if( n_phantom != mp_session().presentation.last_phantom || !phantom_cull.empty() ) {
            mp_session().presentation.last_phantom = n_phantom;
            if( n_phantom > 0 ) {
                mp_log( "[cdda-mp] MON-PHANTOM: " + std::to_string( n_phantom ) +
                        " client-local monster(s) outside cull region (host has no copy)"
                        " culled=" + std::to_string( phantom_cull.size() ) +
                        " region_center=" + std::to_string( region_center.x() ) + "," +
                        std::to_string( region_center.y() ) +
                        " avatar=" + std::to_string( av.x() ) + "," +
                        std::to_string( av.y() ) + " [" + phantom_log + "]" );
            }
        }
    }

    // A monster omitted from a delta keeps its existing mirror.
    if( jo.has_array( "removed_monsters" ) ) {
        for( const JsonValue &rv : jo.get_array( "removed_monsters" ) ) {
            const int id = rv.get_int();
            if( id > 0 ) {
                remove_mirror( static_cast<uint32_t>( id ) );
            }
        }
    }

    // Summary only when something changed (spawn/remove) — avoids per-turn spam.
    if( n_spawned > 0 || n_culled > 0 ) {
        mp_log( "[cdda-mp] MON-SYNC: host_sent=" + std::to_string( n_recv ) +
                " in_region=" + std::to_string( in_region.size() ) +
                " matched=" + std::to_string( matched.size() ) +
                " spawned=" + std::to_string( n_spawned ) +
                " removed=" + std::to_string( n_culled ) +
                ( culled_log.empty() ? "" : " [removed: " + culled_log + "]" ) );
    }

    // Corpses and death effects are simulated by the host.
    ct.remove_dead();
}

static std::string build_viewport( remote_player_session &recipient, const tripoint_bub_ms &center )
{
    constexpr int W = 41;
    constexpr int H = 21;

    map &m = get_map();
    avatar &u = get_avatar();
    npc *remote = mp_remote_actor( recipient );

    tripoint_bub_ms avatar_pos = u.pos_bub();

    // Map bounds in bubble coords
    const point_bub_ms map_min{ 0, 0 };
    const point_bub_ms map_max{ MAPSIZE_X - 1, MAPSIZE_Y - 1 };

    const point origin{ center.x() - W / 2, center.y() - H / 2 };

    std::string tiles;
    tiles.reserve( W * H );

    for( int row = 0; row < H; ++row ) {
        for( int col = 0; col < W; ++col ) {
            const point b = origin + point( col, row );
            tripoint_bub_ms p{ b.x, b.y, center.z() };

            if( b.x < map_min.x() || b.x > map_max.x() || b.y < map_min.y() || b.y > map_max.y() ) {
                tiles += ' ';
                continue;
            }

            // Player markers take priority
            if( remote && p == remote->pos_bub() ) {
                tiles += '2';
            } else if( p == avatar_pos ) {
                tiles += '@';
            } else {
                int sym = m.ter( p ).obj().symbol();
                char ch = ( sym >= 32 && sym < 127 ) ? static_cast<char>( sym ) : '?';
                if( ch == '\\' || ch == '"' ) {
                    tiles += '\\';
                }
                tiles += ch;
            }
        }
    }

    return "{\"w\":" + std::to_string( W ) +
           ",\"h\":" + std::to_string( H ) +
           ",\"ox\":" + std::to_string( origin.x ) +
           ",\"oy\":" + std::to_string( origin.y ) +
           R"(,"tiles":")" + tiles + "\"}";
}


void mp_handle_pass_item( character_id target )
{
    if( !is_hosting() && !is_client_mode() ) {
        return;
    }
    npc *partner = get_partner_npc( target );
    avatar &giver = get_avatar();
    if( !partner || rl_dist( giver.pos_abs(), partner->pos_abs() ) > 1 ) {
        add_msg( m_warning, _( "You need to be adjacent to your partner." ) );
        return;
    }
    item_location source = game_menus::inv::titled_menu( giver,
                           _( "Pass what?" ), _( "You have no items to pass." ) );
    if( !source ) {
        return;
    }
    if( is_client_mode() ) {
        const auto request = make_give_request( source, partner_identity( partner->getID() ),
                                                mp_session().client_pickup );
        if( request ) {
            client_send( client_enrich_action( *request ) );
            giver.set_moves( 0 );
            client_mark_action_sent();
        }
        return;
    }
    auto *recipient = mp_session().find_remote( partner->getID() );
    if( !recipient || recipient->detach_pending ||
        recipient->pickup.revision >= std::numeric_limits<int64_t>::max() - 1 ) {
        return;
    }
    const std::string name = source->tname();
    if( Pickup::give_item( giver, *partner, source ) ) {
        publish_inventory_update( *recipient );
        host_broadcast_post_action();
        add_msg( _( "You pass the %s to %s." ), name, partner->get_name() );
    } else {
        add_msg( m_info, _( "Your partner cannot carry that item." ) );
    }
}
// --- High-five partner action -------------------------------------------

// A quick social beat, calibrated just under morale_chat. Anti-farm: only
// grants while no high-five morale is still active. Repeated high-fives are
// still the gesture (and still cost the initiator a turn) but don't re-up the
// buff, so you can't refresh +5 forever by spamming it. Returns whether morale
// was actually granted (false == on cooldown, decaying from a recent one).
static bool mp_apply_high_five( Character &who )
{
    if( who.has_morale( morale_high_five ) > 0 ) {
        return false;
    }
    who.add_morale( morale_high_five, 5, 5, 30_minutes, 10_minutes );
    return true;
}

// The gesture takes a beat regardless of whether it lands morale — a standard
// one-second action. This is what stops the host high-fiving free and forever
// (it charged nothing before) and caps both sides to ~one high-five per turn.
static constexpr int high_five_moves_cost = 100;

static bool mp_partner_is_busy( character_id target )
{
    const std::string &activity = mp_partner_observation( target ).partner_activity;
    return !activity.empty() && !is_wait_activity( activity );
}

void mp_high_five( character_id target )
{
    if( !is_hosting() && !is_client_mode() ) {
        return;
    }
    npc *partner = get_partner_npc( target );
    if( !partner ) {
        add_msg( m_warning, _( "Your partner is not connected." ) );
        return;
    }
    avatar &av = get_avatar();
    if( rl_dist( av.pos_bub().raw(), partner->pos_bub().raw() ) > 1 ) {
        add_msg( m_warning, _( "You need to be adjacent to your partner to high-five." ) );
        return;
    }
    // Availability gate — a busy partner is never interrupted; the gesture
    // just whiffs with flavor (same restraint as tap-on-shoulder).
    if( mp_partner_is_busy( target ) ) {
        const std::string verb = mp_activity_verb_phrase( mp_partner_observation(
                                     target ).partner_activity );
        if( verb.empty() ) {
            add_msg( m_info, _( "%s is busy and leaves you hanging." ), partner->get_name() );
        } else {
            add_msg( m_info, _( "%s is busy %s and leaves you hanging." ),
                     partner->get_name(), verb );
        }
        return;
    }

    // Charge the action up front so the cost lands whether or not morale is
    // still on cooldown — same beat every time, on both host and client.
    const int pre_moves = av.get_moves();
    av.mod_moves( -high_five_moves_cost );

    // Local effect on the initiator; the peer applies its own on receipt.
    mp_apply_high_five( av );
    add_msg( m_good, _( "You high-five %s!" ), partner->get_name() );

    // The name rides in the packet so the receiver renders the correct
    // attribution itself (avoids the "You"->name substitution path that the
    // yell feature mis-uses).
    std::ostringstream encoded;
    JsonOut out( encoded );
    out.start_object();
    out.member( "type", "high_five" );
    out.member( "name", av.get_name() );
    out.member( "target_player", partner_identity( partner->getID() ).str() );
    out.end_object();
    const std::string payload = encoded.str();
    if( is_hosting() || is_server_mode() ) {
        mp_apply_high_five( *partner );
        if( auto s = get_active_server() ) {
            if( const auto *recipient = mp_session().find_remote( partner->getID() ) ) {
                s->post_send( recipient->admission, payload + "\n" );
            }
        }
    } else if( is_client_mode() ) {
        client_send( payload );
    }

    if( is_client_mode() ) {
        mp_client_post_action( pre_moves );
    }
}

void mp_relay_shout( int vol, bool order )
{
    // The host's own yell already created authoritative noise locally when it
    // called sounds::sound() inside Character::shout(); nothing to relay.  Only
    // the client needs to forward, because its local shout lands in its own
    // (non-authoritative) bubble — the host must reproduce the noise at the
    // proxy.  Noise only: the spoken line is shown on each side via the normal
    // message path, so the packet carries volume + loudness, not text.
    if( vol <= 0 || !is_client_mode() ) {
        return;
    }
    const std::string payload = R"({"type":"shout","vol":)" + std::to_string( vol ) +
                                ",\"order\":" + ( order ? "true" : "false" ) + "}";
    client_send( payload );
    mp_log( "[cdda-mp] shout relay sent: vol=" + std::to_string( vol ) +
            " order=" + ( order ? "1" : "0" ) );
}

static void mp_handle_shout_recv( remote_player_session &recipient, const std::string &msg )
{
    npc *remote = mp_remote_actor( recipient );
    if( !remote ) {
        return;
    }
    try {
        JsonValue jv = json_loader::from_string( msg );
        JsonObject jo = jv.get_object();
        jo.allow_omitted_members();
        const int vol = jo.get_int( "vol", 0 );
        const bool order = jo.get_bool( "order", false );
        if( vol <= 0 ) {
            return;
        }
        // Authoritative sound at the remote player's real position: a FULL sound
        // (not monster-only) so the host (a) hears it as a real "you hear <name>
        // yells" message — the only tiles-visible signal, since CDDA's sound
        // overlay is curses-only — (b) gets the normal '?' sound marker when the
        // partner is out of view, and (c) draws monsters toward the proxy tile.
        // The "<name> yells" line this produces on the host is suppressed from
        // the host->client relay (mp_forward_*), so the client doesn't double it
        // against its own local "You yell ...".
        sounds::sound( remote->pos_bub(), vol,
                       order ? sounds::sound_t::order : sounds::sound_t::alert,
                       string_format( _( "%s yells" ), remote->disp_name() ),
                       false, "shout", "default" );
        mp_log( "[cdda-mp] shout recv: vol=" + std::to_string( vol ) +
                " order=" + ( order ? "1" : "0" ) + " at proxy" );
    } catch( const JsonError &e ) {
        mp_log( std::string( "[cdda-mp] shout recv parse error: " ) + e.what() );
    }
}

static void mp_handle_high_five_recv( const std::string &msg )
{
    std::string from = mp_partner_display_name();
    try {
        JsonValue jv = json_loader::from_string( msg );
        JsonObject jo = jv.get_object();
        jo.allow_omitted_members();
        if( jo.has_string( "name" ) ) {
            const std::string n = jo.get_string( "name" );
            if( !n.empty() ) {
                from = n;
            }
        }
    } catch( const std::exception & ) {
        // malformed packet — fall back to the looked-up partner name
    }
    mp_apply_high_five( get_avatar() );
    add_msg( m_good, _( "%s high-fives you!" ), from );
}

static void mp_send_note_msg( const std::string &payload )
{
    if( is_server_mode() || is_hosting() ) {
        auto s = get_active_server();
        if( s ) {
            s->post_broadcast( payload + "\n" );
        }
    } else if( is_client_mode() ) {
        client_send( payload );
    }
}

void mp_sync_note_add( const tripoint_abs_omt &pos, std::string_view text )
{
    if( mp_session().replication.applying_remote_note ) {
        return;
    }
    if( !is_hosting() && !is_client_mode() ) {
        return;
    }
    std::string escaped;
    escaped.reserve( text.size() );
    for( char c : text ) {
        if( c == '\\' ) {
            escaped += "\\\\";
        } else if( c == '"' ) {
            escaped += "\\\"";
        } else {
            escaped += c;
        }
    }
    std::string payload = R"({"type":"note_sync","op":"add","x":)" + std::to_string( pos.x() ) + ","
                          "\"y\":" + std::to_string( pos.y() ) + ","
                          "\"z\":" + std::to_string( pos.z() ) + ","
                          "\"text\":\"" + escaped + "\"}";
    mp_send_note_msg( payload );
    mp_log( "[cdda-mp] note_sync send: add at " + std::to_string( pos.x() ) + ","
            + std::to_string( pos.y() ) );
}

void mp_sync_note_delete( const tripoint_abs_omt &pos )
{
    if( mp_session().replication.applying_remote_note ) {
        return;
    }
    if( !is_hosting() && !is_client_mode() ) {
        return;
    }
    std::string payload = R"({"type":"note_sync","op":"delete","x":)" + std::to_string( pos.x() ) + ","
                          "\"y\":" + std::to_string( pos.y() ) + ","
                          "\"z\":" + std::to_string( pos.z() ) + "}";
    mp_send_note_msg( payload );
    mp_log( "[cdda-mp] note_sync send: delete at " + std::to_string( pos.x() ) + ","
            + std::to_string( pos.y() ) );
}

void mp_sync_note_danger( const tripoint_abs_omt &pos, int radius, bool dangerous )
{
    if( mp_session().replication.applying_remote_note ) {
        return;
    }
    if( !is_hosting() && !is_client_mode() ) {
        return;
    }
    std::string payload = R"({"type":"note_sync","op":"danger","x":)" + std::to_string( pos.x() ) + ","
                          "\"y\":" + std::to_string( pos.y() ) + ","
                          "\"z\":" + std::to_string( pos.z() ) + ","
                          "\"radius\":" + std::to_string( radius ) + ","
                          "\"dangerous\":" + ( dangerous ? "true" : "false" ) + "}";
    mp_send_note_msg( payload );
    mp_log( "[cdda-mp] note_sync send: danger at " + std::to_string( pos.x() ) + ","
            + std::to_string( pos.y() ) + " r=" + std::to_string( radius ) );
}

static void mp_handle_note_sync( const std::string &msg )
{
    try {
        JsonValue jv = json_loader::from_string( msg );
        JsonObject jo = jv.get_object();
        jo.allow_omitted_members();
        const std::string op = jo.get_string( "op" );
        const tripoint_abs_omt pos( tripoint( jo.get_int( "x" ), jo.get_int( "y" ),
                                              jo.get_int( "z", 0 ) ) );
        mp_session().replication.applying_remote_note = true;
        if( op == "add" ) {
            const std::string text = jo.get_string( "text" );
            overmap_buffer.add_note( pos, text );
            mp_log( "[cdda-mp] note_sync recv: add at " + std::to_string( pos.x() ) + ","
                    + std::to_string( pos.y() ) + " text=" + text );
            add_msg( m_info, _( "Your partner marked a spot on the map." ) );
        } else if( op == "delete" ) {
            overmap_buffer.delete_note( pos );
            mp_log( "[cdda-mp] note_sync recv: delete at " + std::to_string( pos.x() ) + ","
                    + std::to_string( pos.y() ) );
        } else if( op == "danger" ) {
            const int radius = jo.get_int( "radius", 0 );
            const bool dangerous = jo.get_bool( "dangerous", true );
            overmap_buffer.mark_note_dangerous( pos, radius, dangerous );
            mp_log( "[cdda-mp] note_sync recv: danger at " + std::to_string( pos.x() ) + ","
                    + std::to_string( pos.y() ) + " r=" + std::to_string( radius ) );
            if( dangerous ) {
                add_msg( m_warning, _( "Your partner marked an area as dangerous." ) );
            }
        }
        mp_session().replication.applying_remote_note = false;
    } catch( const JsonError &e ) {
        mp_session().replication.applying_remote_note = false;
        mp_log( std::string( "[cdda-mp] note_sync parse error: " ) + e.what() );
    }
}

static std::string build_player_roster( remote_player_session &recipient )
{
    std::ostringstream encoded;
    JsonOut out( encoded );
    out.start_array();
    std::set<std::string> present;
    for( const auto &entry : mp_session().remote_players ) {
        cata_mp::remote_player_session &other = *entry.second;
        if( &other == &recipient || !other.connected ) {
            continue;
        }
        if( const npc *actor = mp_remote_actor( other ) ) {
            const std::string &id = other.credentials.id.str();
            present.insert( id );
            write_player_view( out, other.credentials.id, *actor, other.observation,
                               recipient.replication.player_appearance[id] );
        }
    }
    out.end_array();
    for( auto it = recipient.replication.player_appearance.begin();
         it != recipient.replication.player_appearance.end(); ) {
        it = present.count( it->first ) == 0 ? recipient.replication.player_appearance.erase(
                 it ) : std::next( it );
    }
    return encoded.str();
}

static std::string build_npc_roster( remote_player_session &recipient, const Character &viewer )
{
    std::ostringstream encoded;
    JsonOut out( encoded );
    out.start_array();
    std::set<int> present;
    for( const npc &actor : g->all_npcs() ) {
        if( actor.is_dead() || actor.is_hallucination() || is_player_proxy( actor ) ||
            ( mp_session().has_regions() && !get_map().has_loaded_submap( actor.pos_abs_sm() ) ) ||
            !actor.getID().is_valid() ) {
            continue;
        }
        const int id = actor.getID().get_value();
        present.insert( id );
        write_npc_view( out, actor, viewer, recipient.replication.npc_appearance[id] );
    }
    out.end_array();
    for( auto it = recipient.replication.npc_appearance.begin();
         it != recipient.replication.npc_appearance.end(); ) {
        it = present.count( it->first ) == 0 ? recipient.replication.npc_appearance.erase(
                 it ) : std::next( it );
    }
    return encoded.str();
}

std::string serialize_remote_player_state( remote_player_session &recipient,
        const std::vector<tripoint_abs_ms> &changed_tiles )
{
    if( !recipient.connected ) {
        return R"({"type":"state","connected":false})";
    }

    npc *remote = mp_remote_actor( recipient );
    if( !remote ) {
        return R"({"type":"state","connected":false})";
    }

    const swap_map context( remote_actor_map( recipient, *remote ) );
    tripoint_bub_ms pos_bub = remote->pos_bub();
    tripoint_abs_ms pos = remote->pos_abs();
    mp_log( "[cdda-mp] SRP: npc_abs=" + std::to_string( pos.x() ) + "," + std::to_string( pos.y() ) +
            " bub=" + std::to_string( pos_bub.x() ) + "," + std::to_string( pos_bub.y() ) );
    const avatar &host = get_avatar();
    tripoint_abs_ms host_pos = host.pos_abs();

    std::string viewport = build_viewport( recipient, pos_bub );
    // Broadcast every monster in the reality bubble the client can see (~84-tile
    // view radius), not just 40 — at 40, host monsters in the 40–84 band weren't
    // sent (the EXCLUDED-NEAR diag) and the client filled the gap with its own
    // divergent local-mapgen monsters.  Must match the client's cull radius in
    // apply_monster_sync.
    std::string monsters     = build_monster_list( recipient, pos, 84 );

    // Death-based monster removal (mirrors removed_vehicles, but glitch-proof).
    // A monster is "removed" only if it had a net id last broadcast and is no
    // longer alive ANYWHERE in the creature tracker (genuinely died / left the
    // bubble) — NOT merely because it fell outside this broadcast's radius. So
    // a transient short broadcast, or a monster wandering past 40 tiles while
    // still alive, never removes it on the client. Replaces the client's old
    // cull-by-absence, which killed live monsters (the woodpecker bug).
    std::unordered_set<uint32_t> mon_alive_now;
    for( const auto &mon_ptr : get_creature_tracker().get_monsters_list() ) {
        if( mon_ptr && !mon_ptr->is_dead() ) {
            if( const uint32_t nid = mp_session().replication.entity_ids.known_id( *mon_ptr ) ) {
                mon_alive_now.insert( nid );
            }
        }
    }
    std::string removed_monsters_json = "[";
    {
        bool rmfirst = true;
        for( const uint32_t old_nid : recipient.replication.server_mon_known_nids ) {
            if( mon_alive_now.count( old_nid ) ) {
                continue;
            }
            if( !rmfirst ) {
                removed_monsters_json += ',';
            }
            rmfirst = false;
            removed_monsters_json += std::to_string( old_nid );
            mp_log( "[cdda-mp] MON-REMOVED: nid=" + std::to_string( old_nid ) +
                    " (died/left bubble)" );
        }
    }
    removed_monsters_json += ']';
    recipient.replication.server_mon_known_nids = std::move( mon_alive_now );

    // Scan for tile changes around both the remote player AND the host so that
    // doors/terrain the host interacts with also reach the client.
    std::string tile_changes = build_tile_changes( recipient, pos, 20 );
    if( host_pos != pos ) {
        std::string host_tc = build_tile_changes( recipient, host_pos, 20 );
        if( host_tc.size() > 2 ) { // not just "[]"
            if( tile_changes == "[]" ) {
                tile_changes = host_tc;
            } else {
                tile_changes = tile_changes.substr( 0, tile_changes.size() - 1 )
                               + "," + host_tc.substr( 1 );
            }
        }
    }

    // Some owned actions touch a different floor without moving the player.
    // Send only those cells, using the normal per-recipient delta cache.
    for( const auto &changed : changed_tiles ) {
        const std::string delta = build_tile_changes( recipient, changed, 0 );
        if( delta.size() > 2 ) {
            tile_changes = tile_changes == "[]" ? delta :
                           tile_changes.substr( 0, tile_changes.size() - 1 ) + "," + delta.substr( 1 );
        }
    }

    const auto *peek = active_peek( recipient );
    const std::string peek_state = peek ? serialize( *peek ) : "null";
    if( peek ) {
        const int bottom = std::max( -OVERMAP_DEPTH, peek->viewpoint.z() - peek->z_range );
        const int top = std::min( OVERMAP_HEIGHT, peek->viewpoint.z() + peek->z_range );
        for( int z = bottom; z <= top; ++z ) {
            const tripoint_abs_ms center( peek->viewpoint.xy(), z );
            const std::string delta = build_tile_changes( recipient, center, MAX_VIEW_DISTANCE );
            if( delta.size() > 2 ) {
                tile_changes = tile_changes == "[]" ? delta :
                               tile_changes.substr( 0, tile_changes.size() - 1 ) + "," + delta.substr( 1 );
            }
        }
    }

    // Per-bodypart HP for accurate client sidebar display.
    std::string bparts_json = "[";
    bool bfirst = true;
    std::string bp_log;
    for( const bodypart_id &bp : remote->get_all_body_parts() ) {
        if( !bfirst ) {
            bparts_json += ',';
            bp_log += ' ';
        }
        bfirst = false;
        const int hp_cur = remote->get_hp( bp );
        const int hp_max = remote->get_hp_max( bp );
        bparts_json += R"({"id":")" + bp.id().str() +
                       R"(","hp":)" + std::to_string( hp_cur ) +
                       ",\"hp_max\":" + std::to_string( hp_max ) + "}";
        bp_log += bp.id().str() + "=" + std::to_string( hp_cur ) + "/" + std::to_string( hp_max );
    }
    bparts_json += "]";
    // Per-turn body-part HP dump — rarely changes, so log only on change.
    {
        if( bp_log != mp_session().presentation.last_bp ) {
            mp_session().presentation.last_bp = bp_log;
            mp_log( "[cdda-mp] SRP-BP: " + bp_log );
        }
    }

    const std::string host_male_str = host.male ? "true" : "false";

    // Build host mutation array — ALL active mutations (cosmetics like skin/hair
    // plus physical mutations like Fangs / Sleek Fur / Spines / Feathered Arms).
    // The earlier appearance-only list omitted physical mutations, so the proxy
    // NPC rendered as a bare base sprite even when the host was a deeply mutated
    // character.  Receiver clears the proxy's full mutation set and applies this
    // list.  The "type" field is the mutation's first type tag (used only for
    // logging now — receiver no longer clears by-type, it clears everything).
    std::string host_appearance_json = "[";
    bool happ_first = true;
    for( const trait_and_var &tv : host.get_mutations_variants() ) {
        const mutation_branch &mb = tv.trait.obj();
        std::string first_type;
        if( !mb.types.empty() ) {
            first_type = *mb.types.begin();
        }
        if( !happ_first ) {
            host_appearance_json += ',';
        }
        happ_first = false;
        host_appearance_json += R"({"type":")" + first_type
                                + R"(","id":")" + tv.trait.str() + "\"";
        if( !tv.variant.empty() ) {
            host_appearance_json += R"(,"var":")" + tv.variant + "\"";
        }
        host_appearance_json += '}';
    }
    host_appearance_json += ']';

    // Host wielded weapon — typeId for legacy, full object for trade/skill checks.
    std::string host_wielded_type;
    std::string host_wielded_obj_json = "null";
    item_location host_wielded_loc = host.get_wielded_item();
    if( host_wielded_loc ) {
        host_wielded_type = host_wielded_loc->typeId().str();
        std::ostringstream hw_oss;
        {
            JsonOut hw_out( hw_oss );
            host_wielded_loc->serialize( hw_out );
        }
        host_wielded_obj_json = hw_oss.str();
    }

    // Host main inventory — tools, books, currency, etc. for trade menu.
    std::string host_inv_json;
    {
        std::ostringstream inv_oss;
        {
            JsonOut inv_out( inv_oss );
            host.inv->json_save_items( inv_out );
        }
        host_inv_json = inv_oss.str();
    }

    // Host worn items — cached; JSON only rebuilt when worn list or appearance changes.

    std::vector<const item *> host_worn_items;
    host.worn.inv_dump( host_worn_items );

    std::string host_worn_sig;
    for( const item *it : host_worn_items ) {
        host_worn_sig += it->typeId().str();
        if( it->has_itype_variant() ) {
            host_worn_sig += '[';
            host_worn_sig += it->itype_variant().id;
            host_worn_sig += ']';
        }
        host_worn_sig += ',';
    }
    host_worn_sig += '|' + host_appearance_json + '|' + host_wielded_type;
    if( host_wielded_loc ) {
        host_worn_sig += ':';
        host_worn_sig += std::to_string( host_wielded_loc->ammo_remaining() );
    }
    host_worn_sig += '|';
    host_worn_sig += std::to_string( host.weight_carried().value() );

    std::string host_worn_json;
    if( host_worn_sig == recipient.replication.host_worn_sig_cache ) {
        host_worn_json = recipient.replication.host_worn_json_cache;
    } else {
        recipient.replication.host_worn_sig_cache = host_worn_sig;
        host_worn_json = "[";
        bool hwfirst = true;
        for( const item *it : host_worn_items ) {
            if( !hwfirst ) {
                host_worn_json += ',';
            }
            hwfirst = false;
            std::ostringstream woss;
            {
                JsonOut wout( woss );
                it->serialize( wout );
            }
            host_worn_json += woss.str();
        }
        host_worn_json += "]";
        recipient.replication.host_worn_json_cache = host_worn_json;
        mp_log( "[cdda-mp] host_worn changed: [" + host_worn_sig + "]" );
    }

    // Build the messages JSON.  Two sources:
    //   1. g_action_msgs_pending — all messages from the last remote player action,
    //      already NPC→"You" substituted and filtered by flush_action_msgs( recipient ).
    //   2. Name-filtered messages generated between actions (monster attacks on the
    //      NPC, etc.) that arrived since the last broadcast.
    const std::string &npc_name = remote->name;
    std::string msgs_json = "[";
    bool mfirst = true;

    // Helper: JSON-escape and append one message string.
    const auto append_msg = [&]( std::string_view text ) {
        std::string escaped;
        escaped.reserve( text.size() );
        for( char c : text ) {
            if( c == '\\' ) {
                escaped += "\\\\";
            } else if( c == '"' ) {
                escaped += "\\\"";
            } else {
                escaped += c;
            }
        }
        if( !mfirst ) {
            msgs_json += ',';
        }
        mfirst = false;
        msgs_json += '"' + escaped + '"';
    };

    // 1. Action-window messages (unfiltered except for host-avatar "You..." skips).
    for( const std::string &text : recipient.turn.action_msgs_pending ) {
        append_msg( text );
    }
    recipient.turn.action_msgs_pending.clear();

    // 1b. Host avatar combat messages forwarded with "You" → host name attribution.
    for( const std::string &text : recipient.turn.host_action_msgs_pending ) {
        append_msg( text );
    }
    recipient.turn.host_action_msgs_pending.clear();

    // 2. Between-action messages mentioning the remote player's NPC or their vehicle.
    // When the client is driving, physics messages (engine dies, collision, etc.)
    // name the vehicle not the player — include those so the driver sees them.
    std::string driving_veh_name;
    if( remote->controlling_vehicle && remote->in_vehicle ) {
        if( const optional_vpart_position vp_pos = get_map().veh_at( remote->pos_bub() ) ) {
            driving_veh_name = vp_pos->vehicle().name;
        }
    }
    const unsigned long long current_msg_count = Messages::size();
    if( current_msg_count > recipient.turn.last_forwarded_msg_count ) {
        const size_t new_count = static_cast<size_t>( current_msg_count -
                                 recipient.turn.last_forwarded_msg_count );
        recipient.turn.last_forwarded_msg_count = current_msg_count;
        const std::vector<std::pair<std::string, std::string>> new_msgs =
                    Messages::recent_messages_for_player( new_count, recipient.credentials.id );
        for( const auto &[time_str, text] : new_msgs ) {
            ( void )time_str;
            // Swap/push messages are rendered on the client via semantic flags
            // (partner_swapped/partner_pushed) or the client's own SP handler —
            // forwarding them here produces "You swaps/swap places with you."
            if( text.find( "places with" ) != std::string::npos ||
                text.find( "pushes you out of the way" ) != std::string::npos ||
                text.rfind( "You push ", 0 ) == 0 ) {
                mp_log( "[cdda-mp] between-action: suppressed swap/push relay: " + text );
                continue;
            }
            // The host's "you hear <partner> yells" line comes from the proxy's
            // relayed shout (mp_handle_shout_recv); the client already printed its
            // own "You yell ..." locally, so forwarding this would double it (and
            // the You-substitution would garble it to "you hear You yells").
            if( text.find( " yells" ) != std::string::npos ) {
                mp_log( "[cdda-mp] between-action: suppressed relayed-yell echo: " + text );
                continue;
            }
            const bool has_npc    = !npc_name.empty() && text.find( npc_name ) != std::string::npos;
            const bool has_vehnam = !driving_veh_name.empty() &&
                                    text.find( driving_veh_name ) != std::string::npos;
            if( !has_npc && !has_vehnam ) {
                continue;  // skip messages unrelated to the remote player
            }
            std::string out = text;
            if( !npc_name.empty() ) {
                size_t p = 0;
                while( ( p = out.find( npc_name, p ) ) != std::string::npos ) {
                    out.replace( p, npc_name.size(), "You" );
                    p += 3;
                }
            }
            append_msg( out );
        }
    }

    msgs_json += ']';

    // Build vehicle sync payload: position, facing, and velocity for all vehicles
    // in the active reality bubble.  Clients use this to keep vehicle sprites in sync.
    std::string vehicles_json = "[";
    std::unordered_set<uint32_t> alive_now;
    {
        bool vfirst = true;
        map &vmap = get_map();
        for( const wrapped_vehicle &wv : vmap.get_vehicles() ) {
            vehicle *v = wv.v;
            if( !v ) {
                continue;
            }
            // Assign a stable net ID on first encounter.
            v->ensure_uid();
            const uint32_t nid = mp_session().replication.entity_ids.assign( *v );
            alive_now.insert( nid );

            const tripoint_abs_ms vabs = v->pos_abs();
            const int face_deg     = static_cast<int>( std::lround( to_degrees( v->face.dir() ) ) );
            const int turn_dir_deg = static_cast<int>( std::lround( to_degrees( v->turn_dir ) ) );
            // JSON-escape the vehicle name so special characters don't break the packet.
            std::string vname_escaped;
            vname_escaped.reserve( v->name.size() );
            for( char c : v->name ) {
                if( c == '\\' ) {
                    vname_escaped += "\\\\";
                } else if( c == '"' ) {
                    vname_escaped += "\\\"";
                } else {
                    vname_escaped += c;
                }
            }
            // Per-part state: open/enabled, HP, and fuel (for tanks/fuel stores).
            // Sequential index over get_all_parts() — host and client share the same
            // save so the iteration order is identical on both sides.
            std::string parts_json = "[";
            bool psfirst = true;
            int pidx = 0;
            std::vector<replicated_vehicle_part_identity> part_identities;
            for( const vpart_reference &vpr : v->get_all_parts() ) {
                const vehicle_part &vp = vpr.part();
                const item &base = vp.get_base();
                const item *contents = vp.is_tank() && !base.empty() ? &base.legacy_front() : nullptr;
                const int64_t liquid_uid = contents ? contents->uid().get_value() : 0;
                part_identities.push_back( { base.uid().get_value(), liquid_uid,
                                             contents && contents->made_of( phase_id::LIQUID ) } );
                if( !psfirst ) {
                    parts_json += ',';
                }
                psfirst = false;
                parts_json += "{\"i\":" + std::to_string( pidx )
                              + ",\"open\":" + ( vp.open ? "true" : "false" )
                              + ",\"enabled\":" + ( vp.enabled ? "true" : "false" )
                              + ",\"hp\":" + std::to_string( vp.hp() );
                // Fuel stores: sync current fuel type and amount.
                if( vp.is_fuel_store( false ) && !vp.ammo_current().is_null() ) {
                    parts_json += R"(,"fuel_type":")" + vp.ammo_current().str()
                                  + R"(","fuel_amt":)" + std::to_string( vp.ammo_remaining() );
                    if( contents ) {
                        parts_json += R"(,"liquid_uid":)" + std::to_string( liquid_uid );
                    }
                }
                parts_json += "}";
                ++pidx;
            }
            parts_json += ']';

            auto &previous_parts = recipient.replication.server_veh_parts[nid];
            if( previous_parts != part_identities ) {
                recipient.replication.client_known_veh_nids.erase( nid );
                previous_parts = std::move( part_identities );
            }
            // Per-cargo-part contents.  Baseline-diff gated so a 100-item trunk
            // with stable contents costs nothing on the wire — we only emit
            // parts whose items actually changed since the last broadcast.
            std::string cargo_json = "[";
            bool cfirst = true;
            for( const vpart_reference &vpr : v->get_any_parts( VPFLAG_CARGO ) ) {
                const tripoint_abs_ms vp_abs = vmap.get_abs( vpr.pos_bub( vmap ) );
                const int64_t part_uid = vpr.part().get_base().uid().get_value();
                std::string items_sig = std::to_string( part_uid ) + ':';
                std::string items_json = "[";
                bool ifirst = true;
                for( const item &it : v->get_items( vpr.part() ) ) {
                    const std::string item_json = serialize( it );
                    items_sig += item_json + ',';
                    if( !ifirst ) {
                        items_json += ',';
                    }
                    ifirst = false;
                    items_json += item_json;
                }
                items_json += "]";
                auto &baseline = recipient.replication.host_veh_cargo_baseline[vp_abs];
                if( baseline == items_sig ) {
                    continue; // no change since last broadcast
                }
                baseline = items_sig;
                mp_log( "[cdda-mp] host veh cargo @ " +
                        std::to_string( vp_abs.x() ) + "," +
                        std::to_string( vp_abs.y() ) + "," +
                        std::to_string( vp_abs.z() ) +
                        " items_sig_len=" + std::to_string( items_sig.size() ) );
                if( !cfirst ) {
                    cargo_json += ',';
                }
                cfirst = false;
                cargo_json += "{\"x\":" + std::to_string( vp_abs.x() )
                              + ",\"y\":" + std::to_string( vp_abs.y() )
                              + ",\"z\":" + std::to_string( vp_abs.z() )
                              + ",\"part\":" + std::to_string( part_uid )
                              + ",\"items\":" + items_json + "}";
            }
            cargo_json += ']';

            if( !vfirst ) {
                vehicles_json += ',';
            }
            vfirst = false;
            // First sight or a changed part/tank identity needs a save-format
            // snapshot. Other updates use the existing part and cargo deltas.
            std::string snapshot_field;
            if( !recipient.replication.client_known_veh_nids.count( nid ) ) {
                snapshot_field = ",\"snapshot\":" + ::serialize( *v );
                recipient.replication.client_known_veh_nids.insert( nid );
                mp_log( "[cdda-mp] HOST-VEH-SNAPSHOT: nid=" + std::to_string( nid )
                        + " name=\"" + v->name + "\" bytes="
                        + std::to_string( snapshot_field.size() ) );
            }
            vehicles_json += "{\"nid\":" + std::to_string( nid )
                             + ",\"uid\":" + std::to_string( v->uid().get_value() )
                             + ",\"x\":" + std::to_string( vabs.x() )
                             + ",\"y\":" + std::to_string( vabs.y() )
                             + ",\"z\":" + std::to_string( vabs.z() )
                             + ",\"face\":" + std::to_string( face_deg )
                             + ",\"turn_dir\":" + std::to_string( turn_dir_deg )
                             + ",\"vel\":" + std::to_string( v->velocity )
                             + ",\"cruise\":" + std::to_string( v->cruise_velocity );
            vehicles_json += R"(,"name":")";
            vehicles_json += vname_escaped;
            vehicles_json += R"(","parts":)";
            vehicles_json += parts_json;
            vehicles_json += ",\"cargo\":";
            vehicles_json += cargo_json;
            vehicles_json += snapshot_field;
            vehicles_json += '}';
        }
    }
    vehicles_json += ']';

    // Diff against the previous broadcast: any nid that was live last time but
    // isn't in alive_now has disappeared (folded, fully destroyed, driven out
    // of bubble, etc.).  Emit a removed_vehicles array so the client can
    // mirror SP's map::destroy_vehicle path.  Also drop those nids from the
    // snapshot/part identity tracking so a future re-encounter triggers a fresh
    // snapshot.
    std::string removed_vehicles_json = "[";
    {
        bool rfirst = true;
        for( const uint32_t old_nid : recipient.replication.server_veh_live_nids ) {
            if( alive_now.count( old_nid ) ) {
                continue;
            }
            if( !rfirst ) {
                removed_vehicles_json += ',';
            }
            rfirst = false;
            removed_vehicles_json += std::to_string( old_nid );
            recipient.replication.client_known_veh_nids.erase( old_nid );
            recipient.replication.server_veh_parts.erase( old_nid );
            mp_log( "[cdda-mp] HOST-VEH-REMOVED: nid=" + std::to_string( old_nid ) );
        }
    }
    removed_vehicles_json += ']';
    recipient.replication.server_veh_live_nids = std::move( alive_now );

    // Host effects for the observing client's partner markers. The local
    // player receives its complete body/effect projection separately.
    std::string host_effects_json = "[";
    {
        bool ef_first = true;
        for( const effect &eff : host.get_effects() ) {
            if( !ef_first ) {
                host_effects_json += ',';
            }
            ef_first = false;
            host_effects_json += R"({"id":")" + eff.get_id().str() +
                                 R"(","bp":")" + eff.get_bp().id().str() +
                                 R"(","intensity":)" + std::to_string( eff.get_intensity() ) +
                                 ",\"dur\":" + std::to_string( to_turns<int>( eff.get_duration() ) ) + "}";
        }
    }
    host_effects_json += "]";

    // Host per-bodypart HP so the client's co-op partner-HP HUD reflects the
    // host's real health (the bar reads partner->get_hp() off the proxy, which
    // was never updated → stale).
    std::string host_hp_json = "[";
    {
        bool hp_first = true;
        for( const bodypart_id &bp : host.get_all_body_parts() ) {
            if( !hp_first ) {
                host_hp_json += ',';
            }
            hp_first = false;
            host_hp_json += R"({"id":")" + bp.id().str() +
                            R"(","hp":)" + std::to_string( host.get_hp( bp ) ) +
                            ",\"hp_max\":" + std::to_string( host.get_hp_max( bp ) ) + "}";
        }
    }
    host_hp_json += "]";

    std::ostringstream character_turn;
    JsonOut character_out( character_turn );
    remote->store_turn_state( character_out );
    std::ostringstream missions_state;
    JsonOut missions_out( missions_state );
    write_mission_view( missions_out, *remote );
    std::ostringstream radio_state;
    JsonOut radio_out( radio_state );
    write_radio_contacts( radio_out, *remote );
    std::string kill_statistics_update;
    const kill_statistics &kills = remote->get_kill_statistics();
    if( recipient.turn.last_kill_statistics_revision != kills.revision() ) {
        std::ostringstream serialized_kills;
        JsonOut kill_out( serialized_kills );
        kills.serialize( kill_out );
        kill_statistics_update = ",\"kill_tracker\":" + serialized_kills.str();
        recipient.turn.last_kill_statistics_revision = kills.revision();
    }

    return "{\"type\":\"state\","
           "\"host_player\":\"" + host.get_player_id().str() + "\","
           "\"self_player\":\"" + recipient.credentials.id.str() + "\","
           "\"players\":" + build_player_roster( recipient ) + ","
           "\"missions\":" + missions_state.str() + ","
           "\"radio_contacts\":" + radio_state.str() + ","
           "\"npcs\":" + build_npc_roster( recipient, *remote ) + ","
           "\"calendar_turn\":" + std::to_string( to_turn<int>( calendar::turn ) ) + ","
           "\"host_name\":\"" + host.name + "\","
           "\"pos\":{\"x\":" + std::to_string( pos.x() ) +
           ",\"y\":" + std::to_string( pos.y() ) +
           ",\"z\":" + std::to_string( pos.z() ) + "},"
           "\"host_pos\":{\"x\":" + std::to_string( host_pos.x() ) +
           ",\"y\":" + std::to_string( host_pos.y() ) +
           ",\"z\":" + std::to_string( host_pos.z() ) + "},"
           "\"host_worn\":" + host_worn_json + ","
           "\"host_wielded\":\"" + host_wielded_type + "\","
           "\"host_wielded_obj\":" + host_wielded_obj_json + ","
           "\"host_inv\":" + host_inv_json + ","
           "\"host_weight\":" + std::to_string( host.weight_carried().value() ) + ","
           "\"host_male\":" + host_male_str + ","
           "\"host_appearance\":" + host_appearance_json + ","
           "\"host_move_mode\":\"" + host.move_mode.str() + "\","
           "\"host_facing\":" + std::to_string( host.facing == FacingDirection::LEFT ? 0 : 1 ) + ","
           "\"host_light\":" + std::to_string( host.active_light() ) + ","
           "\"host_in_vehicle\":" + std::string( host.in_vehicle ? "true" : "false" ) + ","
           "\"host_ctrl_veh\":" + std::string( host.controlling_vehicle ? "true" : "false" ) + ","
           "\"host_activity\":\"" + ( host.activity ? host.activity.id().str() : "" ) + "\","
           "\"host_help_target\":" + wire_quote( activity_help_target( host.activity ) ) + ","
           "\"host_activity_pct\":" + std::to_string(
               mp_compute_activity_pct( host.activity ) ) + ","
           "\"host_activity_moves_total\":" + std::to_string(
               host.activity ? host.activity.moves_total : 0 ) + ","
           "\"host_morale\":" + std::to_string( host.get_morale_level() ) + ","
           "\"host_hp_cur\":" + std::to_string( mp_worst_limb_hp( host ).first ) + ","
           "\"host_hp_max\":" + std::to_string( mp_worst_limb_hp( host ).second ) + ","
           "\"host_ping_echo\":" + std::to_string( recipient.turn.last_client_ping_stamp ) + ","
           "\"host_effects\":" + host_effects_json + ","
           "\"host_hp\":" + host_hp_json + "," +
    ( [&recipient]() -> std::string {
        // One-shot host→client swap/push signals — client renders the
        // observer message locally from the proxy name (no text relay).
        std::string s;
        if( recipient.turn.pending_partner_swap )
        {
            recipient.turn.pending_partner_swap = false;
            s += R"("partner_swapped":true,"swap_from":")" + json_escape_str( recipient.turn.swap_from ) +
            "\",";
        }
        if( recipient.turn.pending_partner_push )
        {
            recipient.turn.pending_partner_push = false;
            s += R"("partner_pushed":true,"push_from":")" + json_escape_str( recipient.turn.push_from ) +
            "\",";
        }
        return s;
    }() ) +
    "\"character_revision\":" + std::to_string( ++recipient.turn.character_revision ) +
    ",\"character_turn\":" + character_turn.str() + kill_statistics_update +
    ( owns_inventory_activity( *remote ) && is_rest_activity( remote->activity.id().str() ) ?
      R"(,"rest_activity":{"kind":)" + wire_quote( remote->activity.id().str() ) +
      R"(,"activity":")" + std::to_string( remote->activity.identity_generation() ) +
      R"(","moves_total":)" + std::to_string( remote->activity.moves_total ) +
      R"(,"moves_left":)" + std::to_string( remote->activity.moves_left ) + "}" : "" ) +
    ",\"bodyparts\":" + bparts_json +
    ",\"moves\":" + std::to_string( recipient.turn.remote_moves ) +
    ",\"speed\":" + std::to_string( remote->get_speed() ) +
    R"(,"client_move_mode":")" + remote->move_mode.str() + "\""
    ",\"client_stamina\":" + std::to_string( remote->get_stamina() ) +
    ",\"client_stamina_max\":" + std::to_string( remote->get_stamina_max() ) +
    ",\"client_ctrl_veh\":" + ( controlled_vehicle( *remote, get_map() ) ? "true" : "false" ) +
    [&]() -> std::string {
        vehicle *target = controlled_vehicle( *remote, get_map() );
        if( !target )
        {
            return "";
        }
        const tripoint_abs_ms vabs = target->pos_abs();
        return R"(,"client_veh_pos":{"x":)" + std::to_string( vabs.x() )
        + ",\"y\":" + std::to_string( vabs.y() )
        + ",\"z\":" + std::to_string( vabs.z() ) + "}";
    }() +
    ",\"peek\":" + peek_state +
    ",\"monsters\":" + monsters +
    ",\"removed_monsters\":" + removed_monsters_json +
    ",\"tile_changes\":" + tile_changes +
    ",\"vehicles\":" + vehicles_json +
    ",\"removed_vehicles\":" + removed_vehicles_json +
    ",\"msgs\":" + msgs_json +
    ",\"player_feedback\":" + take_player_feedback( recipient ) +
    ",\"craft_notices\":" + take_craft_notifications( recipient.inventory_activity ) +
    ",\"group_fast_forward\":" + ( should_fast_forward() ? std::string( "true" ) :
                                   std::string( "false" ) ) +
    ",\"grant_seq\":" + std::to_string( recipient.turn.grant_seq ) +
    ",\"sfx\":" + [&]() -> std::string {
        std::string j = "[";
        bool first = true;
        for( const MPSfxEvent &e : recipient.turn.host_sfx_queue )
        {
            if( !first ) {
                j += ',';
            }
            first = false;
            j += R"({"id":")";
            j += json_escape_str( e.id );
            j += R"(","v":")";
            j += json_escape_str( e.variant );
            j += R"(","vol":)";
            j += std::to_string( e.vol );
            j += '}';
        }
        recipient.turn.host_sfx_queue.clear();
        j += "]";
        return j;
    }() +
    ",\"map\":" + viewport + "}";
}

void client_wait_for_initial_position()
{
    using namespace std::chrono_literals;
    const auto deadline = std::chrono::steady_clock::now() + 5s;
    while( !mp_session().replication.client.position_received ) {
        if( std::chrono::steady_clock::now() >= deadline ) {
            std::cout << "[cdda-mp] Timed out waiting for initial position from server." << std::endl;
            break;
        }
        client_process_incoming();
        std::this_thread::sleep_for( 50ms );
    }
}

} // namespace cata_mp

// NOLINTEND(cata-no-long,cata-static-string_id-constants,cata-xy,misc-use-internal-linkage,performance-inefficient-string-concatenation)
