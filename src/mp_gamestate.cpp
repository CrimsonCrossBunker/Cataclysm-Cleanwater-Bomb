#include "mp_gamestate.h"

#include "activity_actor.h"
#include "activity_actor_definitions.h"
#include "activity_type.h"
#include "avatar.h"
#include "bodypart.h"
#include "calendar.h"
#include "cata_path.h"
#include "cata_utility.h"
#include "catacharset.h"
#include "character.h"
#include "character_attire.h"
#include "character_id.h"
#include "character_martial_arts.h"
#include "city.h"
#include "clone_ptr.h"
#include "color.h"
#include "construction.h"
#include "coordinates.h"
#include "creature.h"
#include "creature_tracker.h"
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
#include "game_inventory.h"
#include "gates.h"
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
#include "mapdata.h"
#include "memory_fast.h"
#include "messages.h"
#include "mod_manager.h"
#include "monster.h"
#include "mp_client_conn.h"
#include "mp_mod_compat.h"
#include "mp_queue.h"
#include "mp_server.h"
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
#include "skill.h"
#include "sounds.h"
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
#ifdef TILES
    #include "sdl_wrappers.h"
    #include "sounds.h"
#endif
#include <algorithm>
#include <array>
#include <atomic>
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
#include <system_error>
#include <thread>
#include <tuple>
#include <unordered_map>
#include <unordered_set>
#include <utility>
#include <vector>

namespace cata_mp
{

void mp_log( const std::string &msg )
{
    // Wall-clock ms since the previous mp_log line — lets us read the log as a
    // timeline ("this step took 47ms") without having to add timing helpers
    // around every call site.  Reset each line: prefix shows the gap since the
    // last log call, so a long gap = something blocked the main thread.
    static std::chrono::steady_clock::time_point last =
        std::chrono::steady_clock::now();
    const auto now = std::chrono::steady_clock::now();
    const long long delta_ms =
        std::chrono::duration_cast<std::chrono::milliseconds>( now - last ).count();
    last = now;
    // Absolute wall-clock stamp [HH:MM:SS.mmm] in front of the per-log [+Nms]
    // delta.  The delta is each log's private clock; the wall-clock lets the host
    // and client logs be aligned against each other (assuming the two machines'
    // clocks are roughly NTP-synced, which LAN/Tailscale gives).  Thread-safe:
    // system_clock::now and localtime_r/_s into a local tm, no shared buffer.
    const auto wall = std::chrono::system_clock::now();
    const std::time_t wt = std::chrono::system_clock::to_time_t( wall );
    const long wms = static_cast<long>(
                         std::chrono::duration_cast<std::chrono::milliseconds>(
                             wall.time_since_epoch() ).count() % 1000 );
    std::tm tmv{};
#if defined(_WIN32)
    localtime_s( &tmv, &wt );
#else
    localtime_r( &wt, &tmv );
#endif
    char tbuf[20];
    std::snprintf( tbuf, sizeof( tbuf ), "[%02d:%02d:%02d.%03ld]",
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
    if( is_client_mode() ) {
        desired_path = log_dir + "cdda-mp-client.log";
    } else if( is_host_mode() || is_server_mode() ) {
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
        const std::uintmax_t sz =
            std::filesystem::exists( desired_path, ec )
            ? std::filesystem::file_size( desired_path, ec ) : 0;
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

// ----------------------------------------------------------------------------
// Client main-thread apply watchdog + breadcrumbs.
//
// A host "state" broadcast is applied on the client's MAIN thread (parse →
// teleport → host-NPC → monster → tile → vehicle → bodyparts).  A bug that
// spins or blocks in any of those steps hard-hangs the whole client — Windows
// shows "not responding" — and until now left NO trace: the old breadcrumbs
// went to std::cout, which never reaches the log file, so the log simply
// stopped mid-apply with nothing naming the step (the 2026-06-26 Parallels
// hang).  mp_apply_step records the active step + a heartbeat and logs a
// START/DONE pair through mp_log (which flushes every line, so the START
// survives a hang).  A background watchdog — started lazily on the first apply
// step — reads the heartbeat and, if any step stays active past a threshold,
// logs a line NAMING the stalled step.  That converts a silent beachball into a
// labeled, attributable event, for this bug and any future one.  Critical
// sections are tiny (label assignment only); the apply work runs with no lock
// held, so the watchdog can always read and log even while the main thread
// spins on a separate core.
static std::mutex g_apply_step_mtx;
static std::string g_apply_step_label;       // active step, "" when idle
static std::chrono::steady_clock::time_point g_apply_step_started;

static void mp_start_apply_watchdog()
{
    static std::once_flag once;
    std::call_once( once, [] {
        std::thread( [] {
            std::chrono::steady_clock::time_point warned_for{};
            int last_warned_s = 0;
            for( ;; )
            {
                std::this_thread::sleep_for( std::chrono::seconds( 1 ) );
                std::string label;
                std::chrono::steady_clock::time_point started;
                {
                    std::scoped_lock lk( g_apply_step_mtx );
                    label = g_apply_step_label;
                    started = g_apply_step_started;
                }
                if( label.empty() ) {
                    warned_for = {};
                    last_warned_s = 0;
                    continue;
                }
                if( started != warned_for ) {
                    // A new step began since the last warning — reset.
                    warned_for = {};
                    last_warned_s = 0;
                }
                const int active_s = static_cast<int>(
                                         std::chrono::duration_cast<std::chrono::seconds>(
                                             std::chrono::steady_clock::now() - started ).count() );
                // Warn first at >=3s, then re-warn every 5s so the log shows the
                // stall never recovered.
                if( active_s >= 3 && active_s - last_warned_s >= ( last_warned_s ? 5 : 1 ) ) {
                    mp_log( "[cdda-mp] WATCHDOG: main thread stalled " +
                            std::to_string( active_s ) + "s in apply-step=" + label +
                            " (client likely hung — Windows 'not responding')" );
                    last_warned_s = active_s;
                    warned_for = started;
                }
            }
        } ).detach();
    } );
}

// RAII breadcrumb: marks one client apply step active for its lifetime.
struct mp_apply_step {
    std::string label_;
    std::chrono::steady_clock::time_point t0_;
    explicit mp_apply_step( std::string label )
        : label_( std::move( label ) ), t0_( std::chrono::steady_clock::now() ) {
        mp_start_apply_watchdog();
        {
            std::scoped_lock lk( g_apply_step_mtx );
            g_apply_step_label = label_;
            g_apply_step_started = t0_;
        }
        mp_log( "[cdda-mp] STATE-APPLY: " + label_ + " start" );
    }
    ~mp_apply_step() {
        const long ms = std::chrono::duration_cast<std::chrono::milliseconds>(
                            std::chrono::steady_clock::now() - t0_ ).count();
        {
            std::scoped_lock lk( g_apply_step_mtx );
            g_apply_step_label.clear();
        }
        mp_log( "[cdda-mp] STATE-APPLY: " + label_ + " done dur=" + std::to_string( ms ) + "ms" );
    }
};

// Per-turn body update, called from do_turn.cpp. SP/host: one plain update.
// Client: the host-driven calendar advances in JUMPS and do_turn spins while
// locked, so the no-arg update_body() (always exactly one turn) starved stamina
// regen + every per-turn effect on a multi-turn jump. Catch up the full elapsed
// span (mirrors SP's fast-forward), gated on a calendar change so the locked
// spin doesn't re-run it.
void mp_do_turn_update_body( Character &u )
{
    if( !is_client_mode() ) {
        u.update_body();
        return;
    }
    static time_point s_last_update_body = calendar::before_time_starts;
    if( calendar::turn == s_last_update_body ) {
        return;
    }
    if( s_last_update_body != calendar::before_time_starts &&
        calendar::turn > s_last_update_body ) {
        u.update_body( s_last_update_body, calendar::turn );
    } else {
        u.update_body();  // first run / clock rewind — single turn
    }
    s_last_update_body = calendar::turn;
}

// Client per-turn processing (effects, needs, move regen), called from do_turn.cpp.
// SP/host run their normal process_turn() in simulate_turn_suffix(). Client:
// process_turn() ticks effects/needs exactly one turn per call with no catch-up,
// so calling it on every locked-spin iteration over-applied them (confirmed:
// bleed/pain climbing while locked) and a multi-turn jump under-applied them.
// Tick once per ELAPSED game-turn (skip on locked spin, capped catch-up on
// jumps); discard the move regen — the client's moves come from server grants.
void mp_do_turn_process_turn( Character &u )
{
    const int pre_moves = u.get_moves();
    if( !is_client_mode() ) {
        return;
    }
    static time_point s_last_proc = calendar::before_time_starts;
    int dturns;
    if( s_last_proc == calendar::before_time_starts ) {
        dturns = 1;                                   // first call
    } else if( calendar::turn > s_last_proc ) {
        dturns = to_turns<int>( calendar::turn - s_last_proc );
    } else {
        dturns = 0;                                   // locked spin / clock rewind
    }
    s_last_proc = calendar::turn;
    constexpr int MAX_CATCHUP = 100;
    const int ticks = dturns < MAX_CATCHUP ? dturns : MAX_CATCHUP;
    for( int i = 0; i < ticks; ++i ) {
        u.process_turn();
    }
    u.set_moves( pre_moves );
}

static bool server_mode_ = false;

bool is_server_mode()
{
    return server_mode_;
}

void set_server_mode( bool enabled )
{
    server_mode_ = enabled;
}

static bool host_mode_ = false;

bool is_host_mode()
{
    return host_mode_;
}

void set_host_mode( bool enabled )
{
    host_mode_ = enabled;
}

bool is_mp_mode()
{
    return server_mode_ || host_mode_;
}

bool is_hosting()
{
    return get_active_server() != nullptr;
}

// Host: sfx events generated during this turn, forwarded to the client in the next grant.
// Capped at 32 entries per turn to bound grant message size.
struct MPSfxEvent {
    std::string id;
    std::string variant;
    int vol = 0;
};
static std::vector<MPSfxEvent> g_host_sfx_queue;

void host_queue_sfx( const std::string &id, const std::string &variant, int vol )
{
    if( !is_hosting() || vol < 5 ) {
        return;
    }
    if( g_host_sfx_queue.size() >= 32 ) {
        return;
    }
    g_host_sfx_queue.push_back( {id, variant, vol} );
}

// The character_id of the remote player's NPC. Invalid when no remote player is connected.
static character_id remote_player_npc_id;
static bool remote_player_connected = false;
static std::string remote_player_name_;

// Client-side: NPC representing the host player in the client's local world.
static character_id client_host_npc_id;
static bool client_host_npc_spawned = false;

// Server: monotonically increasing counter for assigning monster/vehicle network IDs.
static uint32_t g_next_net_id = 0;

// Server: maps vehicle pointers to stable network IDs for vehicle position sync.
static std::unordered_map<vehicle *, uint32_t> g_server_veh_ids;

// Server: nids for which the full vehicle save-format snapshot has already been
// broadcast to the current client.  First broadcast of a previously-unknown
// vehicle includes the "snapshot" payload so the client can mirror the SP
// map::add_vehicle path; subsequent broadcasts stay slim.  Cleared on client
// connect so a fresh client receives snapshots for every visible vehicle.
// Also dropped per-nid when the vehicle's parts vector changes size (install,
// remove, fold/unfold, damage-purge) so a structural mutation triggers a full
// re-snapshot — the slim parts/cargo deltas cover state-on-existing-parts only.
static std::unordered_set<uint32_t> g_client_known_veh_nids;

// Server: per-nid baseline of the parts vector size from the last broadcast.
// Any change (install/remove/purge) invalidates that nid's snapshot tracking
// so the client receives a fresh full snapshot rather than indices that drift
// from the host's vector.
static std::unordered_map<uint32_t, size_t> g_server_veh_parts_count;

// Server: nids broadcast in the most recent state packet.  Diffed against the
// current iteration to detect vehicles that have disappeared (folded, fully
// destroyed, driven out of bubble) so we can emit a "removed_vehicles" entry
// in the state packet for the client to clean up.
static std::unordered_set<uint32_t> g_server_veh_live_nids;

// Host: nids of monsters that were alive (and net-id'd) at the last broadcast.
// Diff against the currently-alive set to emit "removed_monsters" — monsters
// that genuinely DIED/left the bubble, not merely ones outside the broadcast
// radius. The client removes only these and never culls by absence, so a
// transient short broadcast can't kill a live monster (the woodpecker bug).
static std::unordered_set<uint32_t> g_server_mon_known_nids;

// Host: per-nid last-broadcast monster record (the emitted JSON object). The
// monster snapshot resent every monster, every turn — large and ~95% redundant
// (most monsters don't move/change between turns). build_monster_list now emits
// only monsters whose record CHANGED since last send (new nid, or moved / HP /
// facing differs); unchanged ones are omitted. This is safe because the client
// NEVER culls a synced monster by absence — it merges present records and
// removes only via removed_monsters (apply_monster_sync). Cleared on client
// (re)connect and on a periodic keyframe so a fresh/recovering client gets the
// full set. Pruned of nids that leave the broadcast radius (forces a re-send on
// re-entry, since their state may have changed while away).
static std::unordered_map<uint32_t, std::string> g_server_mon_last_sent;

// Client: maps server vehicle network IDs to the last-known absolute tile position.
// Used to look up the vehicle object before moving it to the server-authoritative position.
static std::unordered_map<uint32_t, tripoint_abs_ms> g_client_veh_pos;

// Server: cumulative AP for the remote player (replaces the NPC's own moves which
// are skipped by monmove since is_remote_player() returns true).
static int g_remote_moves = 0;
// Server: true if grant_client_turn() issued a real grant this turn (the client's
// carried move budget was positive).  False on a "deficit turn" — the client is
// still paying off an expensive move's AP debt — and wait_for_client_action()
// skips its blocking wait so the host advances monmove() solo while the client
// stays locked, mirroring SP where an expensive move costs several turns.
static bool g_granted_this_turn = true;

// Server: true while wait_for_client_action() is blocking.  Used by the HUD
// strip so it shows red (can't act) even when host moves > 0.
static bool g_host_waiting_for_client = false;
// Host-only one-shot: when set, the next serialize_remote_player_state()
// broadcast carries "wake_client":true and the flag is cleared.  Drives the
// host→client direction of the tap-on-shoulder action.
static bool g_pending_wake_client = false;
// Host-only one-shot signals for host→client partner interactions.  The host
// performs the swap/push locally (SP path); these flags piggy-back on the next
// state broadcast so the client can render the observer message ("<host> swaps
// places with you.") locally from the proxy's real name — no rendered text is
// shipped, so there is no grammar/POV rewriting to break.
static bool g_pending_partner_swap = false;
static bool g_pending_partner_push = false;

// Server: monotonic message-append watermark at last forward — used to forward
// only NEW messages.  Uses Messages::size() (never decremented) rather
// than size(), which is capped at MESSAGE_LIMIT and stalls once the log fills.
static unsigned long long g_last_forwarded_msg_count = 0;

// Server: messages captured during a remote player action that are forwarded
// verbatim (after NPC→"You" substitution) regardless of NPC name filter.
// Cleared by serialize_remote_player_state() when it consumes them.
static std::vector<std::string> g_action_msgs_pending;

// Server: messages from the avatar's own actions, forwarded to the client with
// "You" → host character name so the client sees attributed host hits.
// Populated by host_capture_avatar_msgs(); cleared by serialize_remote_player_state().
static std::vector<std::string> g_host_action_msgs_pending;

// Client: maps server-assigned network IDs to local monster pointers.
// Rebuilt each sync tick from creature_tracker before applying updates.
static std::unordered_map<uint32_t, monster *> g_net_id_map;

// Client: "keep smashing" continuation state.
// When set, auto-re-fire the smash action after each partial bash until the
// target is destroyed or the bash fails to make progress.
static bool g_client_autosmash = false;
static std::string g_client_autosmash_json; // the smash JSON to re-fire
static bool g_autosmash_pending = false;    // fire the smash on the next available grant
// Set when a partial-bash result arrives and we need to ask "Keep smashing?".
// The query MUST run from the main do_turn loop (client_resolve_pending_ui),
// never inline in apply_one_state_message — a blocking popup from inside network
// processing is the same re-entrant-UI crash class as the aim bug.
static bool g_client_smash_query_pending = false;

// Client: set when the host sends host_died or the socket drops.
// Suppresses further processing and the lost-connection spam.
static bool g_server_died = false;

// Client: set after sending an action, cleared when the server sends moves=0.
// While true, incoming state packets with moves>0 are stale pre-ack broadcasts
// and must be ignored — otherwise TCP-buffered grants re-unlock the client
// before the server has processed the action.
static bool g_client_waiting_for_ack = false;
// Client: true when the server's proxy NPC is at vehicle controls.
// Set by apply_state_packet() from the "client_ctrl_veh" field.
// handle_action uses this to route movement keys to pldrive.
static bool g_client_ctrl_veh = false;
// Client: absolute position of the controlled vehicle (root tile).
// Set alongside g_client_ctrl_veh from "client_veh_pos" in the state packet.
static tripoint_abs_ms g_client_ctrl_veh_abs{ 0, 0, 0 };
// Timestamp of when the ack guard was set. Used to break deadlocks where the
// server never sends moves<=0 (e.g. after reconnect with a stale ack flag).
static std::chrono::steady_clock::time_point g_ack_set_time;
// Timestamp of when the server last granted moves (moves > 0 packet received).
// Used by ms_since_last_grant() to auto-send "wait" when the player is idle.
static std::chrono::steady_clock::time_point g_last_grant_time;

// Server: monotonically increasing sequence number, incremented each grant_client_turn().
// Included in every state packet so the client can distinguish a fresh grant from a
// TCP-buffered duplicate of a previous grant.
static uint32_t g_grant_seq = 0;

// Client: last grant_seq that was successfully applied (moves > 0 path).
// Guards the "new grant" branch: a packet with grant_seq <= g_client_last_grant_seq
// is a stale buffered duplicate and its moves value is ignored.
static uint32_t g_client_last_grant_seq = 0;

// Server: set when the remote player has submitted at least one real action
// this turn.  Cleared by grant_client_turn(); checked by wait_for_client_action().
static bool g_client_acted_this_turn = false;

// Server: elapsed wait time (ms) in the last wait_for_client_action() call.
static int g_wait_elapsed_ms = 0;
// Server: duration (ms) of the last monmove() (AI turn) call; set by do_turn.cpp.
static int g_last_monmove_ms = 0;

// Server: short label for the last action type received from the client this turn.
// Reset to em-dash by grant_client_turn() at the start of each host turn.
// Displayed on the server HUD "Queued" row as the partner-side equivalent.
static std::string g_last_client_action_label = "\xe2\x80\x94";

// Host: the host's own last input action.  Captured at the end of handle_action
// so the local "Queued" HUD field actually reflects the host's most recent key,
// not the client's (which was the previous, misleading behavior).
static std::string g_last_host_action_label = "\xe2\x80\x94";

// Partner activity id (e.g. "ACT_DROP", or "" for none).  On the host this is
// the client's activity (set from action packets); on the client this is the
// host's activity (set from state packets).  Display-only — the actual
// activity ticks on the side that owns the player.  Used by the Co-op HUD and
// transition-edge messages.
static std::string g_partner_activity;
// Progress % (0-100) of the partner's current activity.  Forwarded each
// action/state packet alongside g_partner_activity.  Read by the Co-op panel.
static int g_partner_activity_pct = 0;
// Total moves required by the partner's current activity (act.moves_total).
// Read by the bump-menu predicate to decide whether the "Help with task"
// option should appear (gate: >= HELPER_MIN_MOVES_TOTAL).  Zero when idle.
static int g_partner_activity_moves_total = 0;
// Partner's morale level (Character::get_morale_level()).  Forwarded on the
// same state packet as the activity fields; read by the Co-op panel to show a
// mood indicator.  Piggybacks the existing packet so it costs no extra traffic
// and updates whenever that packet fires (no per-frame work).
static int g_partner_morale = 0;

// Partner's worst-hurt body part, real current/max HP, synced from the partner's
// OWN character (not read off the local proxy, whose max HP is derived from proxy
// stats and so disagrees with the partner's real max — which threw off the bar's
// length and color). Fed straight into get_hp_bar() so the Co-op panel bar is
// pixel-identical to the partner's sidebar limb bar. max<=0 = not yet received.
static int g_partner_hp_cur = 0;
static int g_partner_hp_max = 0;

// Round-trip latency to the partner, in milliseconds; -1 until first measured.
// Measured on the CLIENT via a stamp/echo on the existing packets (no clock
// sync needed), then mirrored back to the host so both panels show the same
// number.  Replaces the old dev-only calendar-drift indicator in the Co-op
// panel.
static int g_partner_ping_ms = -1;
// Host-side: last client_ping stamp we received, to echo back next broadcast.
static int64_t g_last_client_ping_stamp = -1;
// Client-side: the stamp we're currently awaiting an echo for. RTT is measured
// exactly once per round trip (when its echo returns), then this is cleared so
// a host re-echoing the same stale stamp during idle can't keep inflating the
// number. -1 = nothing outstanding (hold the last measured value).
static int64_t g_pending_ping_stamp = -1;
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
// Last calendar turn the partner reported.  Used to display sync drift in the
// Co-op panel: drift = local calendar - partner calendar.  Under lockstep
// both sides should always advance together; nonzero drift is a useful sanity
// indicator for the player.
static int g_partner_calendar_turn = 0;
// Last name the partner reported.  Used by the Co-op panel as a fallback when
// the local proxy NPC isn't (yet) resolvable — proxy spawn races the panel on
// first connect; this lets the panel still show *something* instead of
// "Partner unknown".
static std::string g_partner_name_cached;

// Host-only: tracks whether the proxy NPC was previously resolvable.  Used to
// detect the alive→gone transition so we can distinguish "proxy died in
// combat on host" (notify client, disconnect) from "proxy was never spawned
// yet" or "still null after a recent disconnect".  Cleared on disconnect; set
// to true on the first grant where the proxy resolves.
static bool g_proxy_was_alive = false;
static std::string g_partner_activity_prev;

// Client's avatar activity id snapshot at the start of each do_turn iteration.
// Sent over the wire instead of av.activity at enrich-time because the activity
// can finish (set_to_null) mid-turn, leaving av.activity null when the wait
// dispatch runs — which would mask the activity from the host's HUD.
static std::string g_client_turn_activity;

// Map-sync sent-set and forward declaration — defined later in the map-streaming
// section but referenced in the move handler (process_remote_action).
static std::set<tripoint_abs_sm> g_map_sync_sent;
static const int g_map_sync_cap = 64;
static std::string build_map_sync_z( int az );

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
    const character_id &id = is_hosting() ? remote_player_npc_id : client_host_npc_id;
    if( id.is_valid() ) {
        if( npc *n = g->critter_by_id<npc>( id ) ) {
            if( !n->name.empty() ) {
                return n->name;
            }
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
static void mp_handle_templates_list( const std::string &msg );
static void mp_handle_template_request( const std::string &msg );
static void mp_handle_template_data( const std::string &msg );
static void mp_send_payload( const std::string &payload );

// Fire "<partner> begins <verb>." / "<partner> has finished." on the
// transition edges.  Caller is responsible for setting g_partner_activity to
// the latest value before calling this.
static void mp_partner_activity_transition_check()
{
    if( g_partner_activity == g_partner_activity_prev ) {
        return;
    }
    const std::string partner_name = mp_partner_display_name();
    if( g_partner_activity_prev.empty() && !g_partner_activity.empty() ) {
        add_msg( m_info, _( "%1$s begins %2$s." ), partner_name,
                 mp_activity_verb_phrase( g_partner_activity ) );
    } else if( !g_partner_activity_prev.empty() && g_partner_activity.empty() ) {
        // Use the just-ended activity's verb so the message reads "<name> has
        // finished reading." instead of the generic "<name> has finished."
        add_msg( m_info, _( "%1$s has finished %2$s." ), partner_name,
                 mp_activity_verb_phrase( g_partner_activity_prev ) );
    }
    g_partner_activity_prev = g_partner_activity;
    // Partner's activity changed — if we were helping with the OLD one and
    // they've moved on (or stopped entirely), drop our local commitment so
    // the SP helper bonus stops being applied.
    mp_cancel_help_if_partner_done();
}

// Client → host message forwarding.  When the client's avatar generates a
// notable "You ..." message (e.g. "Now reading X", "You start crafting Y"),
// we capture it here and tack it onto the next outgoing action so the host
// sees a name-substituted version ("Roy now reads X") in their own log.
// Monotonic append watermark (Messages::size()), not size() — see
// g_last_forwarded_msg_count note.
static unsigned long long g_client_msg_watermark = 0;
static std::vector<std::string> g_client_msgs_pending;

// Host: reset overmap-stream state so the next client gets a fresh bulk send.
// Defined far below with the rest of the overmap-streaming code.
static void mp_reset_overmap_sync();
static void mp_reset_map_sync();

// Separation warning tier: 0=ok, 1=warn (≥50 tiles), 2=danger (≥57 tiles).
// Shared by both host and client; resets on connect/disconnect.
// Hysteresis: step up at 50/57, step down at 44/50.
static int g_separation_tier = 0;
// False until the host+client have been confirmed close (<40 tiles) at least once
// this session. Suppresses the join transient: the client proxy spawns at its
// scenario start (far) and is teleported next to the host a beat later, so the
// first separation checks would otherwise fire "close the gap now" before the
// players are actually together. Reset on session end / world exit.
static bool g_separation_settled = false;
static void check_separation_warning( const tripoint_abs_ms &a, const tripoint_abs_ms &b );

// Client: luminance emitted by the host player (flashlight, mutations, etc.).
// Received from state packet each turn and injected into the lighting pass.
static float g_mp_host_luminance = 0.0f;

// Host: luminance emitted by the remote player (client). Received from each
// action packet and injected into the host's lighting pass at the proxy NPC position.
static float g_mp_remote_player_luminance = 0.0f;

static const efftype_id effect_bleed( "bleed" );

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
struct mp_chat_line {
    std::string text;
    nc_color color;
};
static std::vector<mp_chat_line> g_mp_chat_overlay;   // newest last

static int mp_chat_overlay_count()
{
    return static_cast<int>( std::min( g_mp_chat_overlay.size(), MP_CHAT_OVERLAY_MAX ) );
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
            const int start = static_cast<int>( g_mp_chat_overlay.size() ) - ch;
            for( int i = 0; i < ch; ++i ) {
                const mp_chat_line &cl = g_mp_chat_overlay[start + i];
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
        const character_id &partner_id = is_hosting()
                                         ? remote_player_npc_id
                                         : client_host_npc_id;
        npc *partner = partner_id.is_valid()
                       ? g->critter_by_id<npc>( partner_id )
                       : nullptr;
        // Fallback: id may be stale or invalid after a reconnect/respawn but
        // a matching NPC still exists in the active world.  Scan by cached
        // name so we can still pull HP / move_mode for the panel.
        if( !partner && !g_partner_name_cached.empty() ) {
            for( npc &candidate : g->all_npcs() ) {
                if( candidate.name == g_partner_name_cached ) {
                    partner = &candidate;
                    break;
                }
            }
        }

        if( !remote_player_connected && is_hosting() ) {
            mvwprintz( win, point( 2, crow ), c_dark_gray, "%s",
                       _( "Partner not connected" ) );
            wnoutrefresh( win );
            return;
        }

        // Column 0: partner name.  Prefer the live proxy NPC's name; fall back
        // to the cached name from the wire when the proxy isn't resolvable
        // (first-frame race after connect, between npc despawn/respawn).
        // Truncated to 10 chars with a ".." continuation marker.
        std::string pname = partner ? partner->name : g_partner_name_cached;
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
                display::morale_emotion( g_partner_morale, mood_face_DEFAULT.obj() );
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
        if( partner && g_partner_hp_max > 0 ) {
            const std::pair<std::string, nc_color> bar =
                get_hp_bar( g_partner_hp_cur, g_partner_hp_max );
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
        if( !g_partner_activity.empty() ) {
            const std::string verb = mp_activity_verb_phrase( g_partner_activity );
            // Compose "<verb> NN%" — clamp verb length so the % stays on row.
            const int avail = W - x - 8; // reserve room for " NN%" + drift
            std::string vshown = verb;
            if( static_cast<int>( vshown.size() ) > avail ) {
                vshown = vshown.substr( 0, std::max( 0, avail - 2 ) ) + "..";
            }
            mvwprintz( win, point( x, crow ), c_yellow, "%s", vshown.c_str() );
            x += static_cast<int>( vshown.size() ) + 1;
            mvwprintz( win, point( x, crow ), c_light_blue, "%d%%",
                       g_partner_activity_pct );
            x += 5;
        }

        // Latency to the partner on the right edge — the player-facing replacement
        // for the old dev calendar-drift indicator. Round-trip ms, colored
        // green/yellow/red by how laggy the link feels. "--" until first measured.
        {
            std::string ps;
            nc_color pc;
            if( g_partner_ping_ms < 0 ) {
                ps = "--";
                pc = c_dark_gray;
            } else {
                pc = g_partner_ping_ms < 120 ? c_green
                     : g_partner_ping_ms < 300 ? c_yellow : c_red;
                ps = std::to_string( g_partner_ping_ms ) + "ms";
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

// Smoother for the brief moves=0 gap between a sent action and the next grant.
// Module-scope so the edge frame and the panel border pulse together.
static std::chrono::steady_clock::time_point g_mp_last_go_time =
    std::chrono::steady_clock::now() - std::chrono::seconds( 10 );

// True when the player can act this instant — used for both the edge frame
// color and the mp_hud panel border color. Tracks raw moves, in-flight wait
// activities (catch-breath etc. that own the move budget), and host wait-for-
// client lockstep. Updates the shared smoother on green so the 400ms hold
// covers the ack-gap blip.
static bool mp_turn_show_green()
{
    const player_activity &pact = get_avatar().activity;
    static const activity_id s_act_wait( "ACT_WAIT" );
    static const activity_id s_act_wait_stamina( "ACT_WAIT_STAMINA" );
    static const activity_id s_act_wait_weather( "ACT_WAIT_WEATHER" );
    static const activity_id s_act_wait_npc( "ACT_WAIT_NPC" );
    const bool in_wait_act = pact && (
                                 pact.id() == s_act_wait || pact.id() == s_act_wait_stamina ||
                                 pact.id() == s_act_wait_weather || pact.id() == s_act_wait_npc );
    // On the CLIENT, local moves>0 is NOT sufficient to act: the client must
    // also not be waiting on the host's grant/ack for the turn it already sent.
    // Without this, the bar paints green (we have stale local moves) while the
    // client is actually blocked until the host moves/waits — the "green but
    // can't proceed" lie. Mirrors the client's act-readiness gate
    // (moves>0 && !waiting_for_ack). On the host this term is false (host uses
    // g_host_waiting_for_client), so host behavior is unchanged.
    const bool client_blocked_on_ack = is_client_mode() && g_client_waiting_for_ack;
    const bool go = get_avatar().get_moves() > 0 && !in_wait_act
                    && !g_host_waiting_for_client && !client_blocked_on_ack;
    const auto now = std::chrono::steady_clock::now();
    if( go ) {
        g_mp_last_go_time = now;
    }
    const auto since_go_ms = std::chrono::duration_cast<std::chrono::milliseconds>(
                                 now - g_mp_last_go_time ).count();
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

static std::unique_ptr<mp_edge_t> g_mp_edge;
static std::unique_ptr<mp_hud_t> g_mp_hud;

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
    if( !g_mp_edge ) {
        g_mp_edge = std::make_unique<mp_edge_t>();
        mp_log( "[cdda-mp] HUD: created mp_edge (fresh)" );
    }
    g_mp_edge->maybe_resize();
    g_mp_edge->ui.invalidate_ui();
    if( !g_mp_hud ) {
        g_mp_hud = std::make_unique<mp_hud_t>();
        mp_log( "[cdda-mp] HUD: created mp_hud (fresh)" );
    }
    g_mp_hud->ui.invalidate_ui();
}

static std::string json_escape_str( const std::string &s );   // defined below

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
    g_mp_chat_overlay.push_back( { line, col } );
    while( g_mp_chat_overlay.size() > MP_CHAT_OVERLAY_MAX ) {
        g_mp_chat_overlay.erase( g_mp_chat_overlay.begin() );
    }
    if( g_mp_hud ) {
        // Only resize when the visible line count actually changes (0->1->2->3),
        // never per-message once full — repeated resizes churned the panel.
        if( mp_chat_overlay_count() != prev_count ) {
            g_mp_hud->ui.mark_resize();
        }
        g_mp_hud->ui.invalidate_ui();
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
            " remote_connected=" + std::string( remote_player_connected ? "1" : "0" ) +
            " client_mode=" + std::string( is_client_mode() ? "1" : "0" ) );
    // remote_player_connected is host-side only; on the client, being in client
    // mode means we're joined to a host.  Gate on the correct side.
    const bool partner = is_hosting() ? remote_player_connected : is_client_mode();
    if( !partner ) {
        add_msg( m_warning, _( "No co-op partner connected." ) );
        return;
    }
    std::string text = string_input_popup()
                       .title( _( "Co-op chat: " ) )
                       .width( 60 )
                       .query_string();
    // Trim surrounding whitespace; ignore empty/cancelled input.
    const size_t a = text.find_first_not_of( " \t" );
    if( a == std::string::npos ) {
        return;
    }
    text = text.substr( a, text.find_last_not_of( " \t" ) - a + 1 );
    if( text.size() > 256 ) {
        text = text.substr( 0, 256 );
    }
    const bool host = is_hosting();
    const std::string from = get_avatar().get_name();
    const std::string js = R"({"type":"chat","from":")" + json_escape_str( from ) +
                           R"(","text":")" + json_escape_str( text ) +
                           R"(","host":)" + ( host ? "true" : "false" ) + "}";
    if( host ) {
        if( server *srv = get_active_server() ) {
            srv->post_broadcast( js + "\n" );
        }
    } else {
        client_send( js );
    }
    mp_chat_display( _( "You" ), text, host );   // local echo — own messages show as "You"
}

// Client: last confirmed position of the remote player (our avatar as seen by the server).
// Used as the center of the monster sync region.
static tripoint_abs_ms g_mp_remote_pos{ 0, 0, 0 };

// Client: true after the first successful long-range teleport to the host area.
// The heavy place_player_overmap() is only needed once per session.
static bool g_initial_teleport_done = false;

// Host: the world's overmap seed (g->get_seed()), captured on the game thread
// each host turn so the network thread can include it in the join 'welcome'
// without touching game state. Read via mp_host_world_seed().
static std::atomic<unsigned int> g_host_world_seed{ 0 };

// Host: world name captured on the game thread for the network thread's welcome.
// Protected by a simple mutex (set once at world load, read in server thread).
static std::string g_host_world_name;
static std::mutex g_host_world_name_mtx;

// Client: world name received from host in 'welcome'.  Empty until the first
// welcome is processed.  Exposed via mp_client_host_world_name().
static std::string g_client_host_world_name;

// Client: the host's seed as received in 'welcome', and whether we've applied
// it to g->set_seed() yet. Applied before the initial host-area overmap is
// generated so the client's terrain matches the host's. 0 = not yet received.
static unsigned int g_client_host_seed = 0;
static bool g_client_host_seed_applied = false;

// Client: the raw join 'welcome' stashed at connect time so start_game() can
// adopt the host seed + spawn-omt BEFORE worldgen. The welcome's own arrival on
// the first do_turn is too late — start_game has already built the host-area
// overmap with the client's own rng_bits() seed by then. See
// mp_store_pending_welcome() / mp_client_prepare_spawn().
static std::string g_pending_welcome;

// Host: the host avatar's overmap-terrain position, captured each turn on the
// game thread for the join 'welcome'. A joining client spawns directly into the
// host's area instead of generating its character's scenario start_location — a
// divergent environment the host lacks that caused wrong-place vehicles and a
// cull crash in dense areas (hospitals). Read via mp_host_omt()/mp_host_omt_valid().
static std::atomic<int> g_host_omt_x{ 0 };
static std::atomic<int> g_host_omt_y{ 0 };
static std::atomic<int> g_host_omt_z{ 0 };
static std::atomic<bool> g_host_omt_valid{ false };

// Client: the host's OMT received in 'welcome' — the spawn target start_game uses
// in client mode. invalid until a welcome carrying host_omt is processed.
static tripoint_abs_omt g_client_host_spawn_omt = tripoint_abs_omt::invalid;

void mp_capture_host_omt( const tripoint_abs_omt &p )
{
    g_host_omt_x.store( p.x() );
    g_host_omt_y.store( p.y() );
    g_host_omt_z.store( p.z() );
    g_host_omt_valid.store( true );
}

bool mp_host_omt_valid()
{
    return g_host_omt_valid.load();
}

tripoint_abs_omt mp_host_omt()
{
    return tripoint_abs_omt( g_host_omt_x.load(), g_host_omt_y.load(), g_host_omt_z.load() );
}

tripoint_abs_omt mp_client_spawn_omt()
{
    return g_client_host_spawn_omt;
}

// Network-thread safe: returns ",\"host_omt\":[x,y,z]" for the welcome, or "" if
// the host position isn't captured yet. Kept here so mp_server.cpp needn't know
// coordinate types.
std::string mp_host_omt_welcome_field()
{
    if( !g_host_omt_valid.load() ) {
        return std::string();
    }
    return ",\"host_omt\":[" + std::to_string( g_host_omt_x.load() ) + "," +
           std::to_string( g_host_omt_y.load() ) + "," +
           std::to_string( g_host_omt_z.load() ) + "]";
}

// Host: current world seed, for the network thread's 'welcome' message.
unsigned int mp_host_world_seed()
{
    return g_host_world_seed.load();
}

void mp_set_host_world_name( const std::string &name )
{
    std::scoped_lock lk( g_host_world_name_mtx );
    g_host_world_name = name;
}

std::string mp_get_host_world_name()
{
    std::scoped_lock lk( g_host_world_name_mtx );
    return g_host_world_name;
}

std::string mp_client_host_world_name()
{
    return g_client_host_world_name;
}

void mp_set_client_host_world_name( const std::string &name )
{
    g_client_host_world_name = name;
}

// Host: the host avatar's character name, captured on the game thread for the
// network thread's 'welcome' (so the join dialog can show "Joining X's game").
static std::string g_host_player_name;
static std::mutex g_host_player_name_mtx;

void mp_set_host_player_name( const std::string &name )
{
    std::scoped_lock lk( g_host_player_name_mtx );
    g_host_player_name = name;
}

std::string mp_get_host_player_name()
{
    std::scoped_lock lk( g_host_player_name_mtx );
    return g_host_player_name;
}

// Client: the host's character name received in 'welcome'. Empty until processed.
static std::string g_client_host_player_name;

std::string mp_client_host_player_name()
{
    return g_client_host_player_name;
}

void mp_set_client_host_player_name( const std::string &name )
{
    g_client_host_player_name = name;
}

// Client: adopt the host's seed (received in 'welcome') into local worldgen,
// once, before the host-area overmap is generated. No-op if no seed has been
// received yet or it's already applied. Idempotent + safe to call repeatedly.
static void mp_client_apply_host_seed()
{
    if( g_client_host_seed_applied || g_client_host_seed == 0 ) {
        return;
    }
    const unsigned int before = g->get_seed();
    g->set_seed( g_client_host_seed );
    g_client_host_seed_applied = true;
    mp_log( "[cdda-mp] SEED: client adopted host seed " +
            std::to_string( g_client_host_seed ) + " (was " + std::to_string( before ) + ")" );
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
            g_client_host_world_name = wn;
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
                g_client_host_spawn_omt = tripoint_abs_omt(
                                              ho.get_int( 0 ), ho.get_int( 1 ), ho.get_int( 2 ) );
                mp_log( "[cdda-mp] welcome: host_omt=" + g_client_host_spawn_omt.to_string() );
            }
        }
    } catch( const JsonError & ) {}
    const auto spos = msg.find( "\"seed\":" );
    if( spos != std::string::npos ) {
        // Seed is an unsigned int serialized as a bare JSON number.
        const unsigned long parsed = std::strtoul( msg.c_str() + spos + 7, nullptr, 10 );
        g_client_host_seed = static_cast<unsigned int>( parsed );
        mp_log( "[cdda-mp] SEED: welcome " + std::string( apply_seed_now ? "received" : "stored" ) +
                " host seed " + std::to_string( g_client_host_seed ) + " (local was " +
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
    g_pending_welcome = msg;
    parse_welcome_fields( msg, /*apply_seed_now=*/false );
}

// Client: called from game::start_game() right after seed = rng_bits() and
// before the host-area overmap is generated. Adopts the host's stashed seed so
// the client's base terrain matches the host's. The spawn OMT was already set by
// mp_store_pending_welcome() (read via mp_client_spawn_omt()). No-op on the host
// or when no welcome has been stashed.
void mp_client_prepare_spawn()
{
    if( !is_client_mode() || g_pending_welcome.empty() ) {
        return;
    }
    mp_client_apply_host_seed();
}

// Server: per-tile baseline (ter + furn + item fingerprint) for dirty-tile tracking.
struct mp_tile_state {
    std::string ter;
    std::string furn;
    std::string items_sig;    // "type:charges,..." — empty when no items
    std::string fields_sig;   // "type:intensity,..." — empty when no fields
    std::string trap_sig;     // trap id string, empty = tr_null (no placed trap)
    std::string graffiti_sig; // empty = no graffiti
    std::string partial_con_sig; // "construction:counter:ncomponents", empty = no build site
};
static std::unordered_map<tripoint_abs_ms, mp_tile_state> g_tile_baseline;
static mp_tile_state compute_tile_state( const tripoint_abs_ms &abs );
// Partial-construction (in-progress build site) sync helpers — defined near
// compute_tile_state, forward-declared here for the client_tile_changes applier.
static std::string mp_partial_con_sig( const tripoint_bub_ms &bub );
static std::string mp_partial_con_obj_json( const tripoint_bub_ms &bub );
static void mp_apply_partial_con_obj( const tripoint_bub_ms &bub, const JsonObject &po );

// Client→server tile baselines: track what was last sent so we only send diffs.
// Fields are host-authoritative — the host generates the dust/blood/etc. that
// the client sees via tile_changes, and the client must not echo them back or
// the host's own state ping-pongs back as ~80 KB per turn.  apply_tile_changes
// refreshes these baselines from server-pushed state so the next outgoing
// build_client_tile_changes recognizes the tile as unchanged and skips it.
static std::unordered_map<tripoint_abs_ms, std::string> g_client_item_baseline;
static std::unordered_map<tripoint_abs_ms, std::string> g_client_terfurn_baseline;
static std::unordered_map<tripoint_abs_ms, std::string> g_client_trap_baseline;
static std::unordered_map<tripoint_abs_ms, std::string> g_client_graffiti_baseline;
static std::unordered_map<tripoint_abs_ms, std::string> g_client_field_baseline;
static std::unordered_map<tripoint_abs_ms, std::string> g_client_partial_con_baseline;
// Client→server vehicle cargo baseline.  Keyed by the absolute tile position
// of the cargo vpart so the host can find the vehicle + part by tile lookup.
// Mirrors the item baseline but for items stored inside vehicle cargo parts
// (trunks, freezers, lockers, etc.).
static std::unordered_map<tripoint_abs_ms, std::string> g_client_veh_cargo_baseline;
// Server→client vehicle cargo baseline.  Same keying as the client direction —
// without this the client can't see items the host drops into trunks/seats/etc.,
// and its stale snapshot would then overwrite the host on the next client drop.
static std::unordered_map<tripoint_abs_ms, std::string> g_host_veh_cargo_baseline;
// Client→server worn-list baseline.  When the worn signature changes (e.g.
// drop_activity_actor peeled a worn garment off as part of a drop), we trigger
// a client_resync_worn() so the host's proxy mirrors the new worn list.
// Plain signature string keyed on typeId + variant + wielded id.
static std::string g_client_worn_baseline;

static std::string json_escape_str( const std::string &s )
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

// Client: last known HP per net ID — used to synthesise combat hit/death messages.
static std::unordered_map<uint32_t, int> g_last_monster_hp;

// Client: last known HP per bodypart string ID — used to synthesise "you were hit" messages.
static std::unordered_map<std::string, int> g_last_bodypart_hp;

// Client: net_ids of synced monsters the client just killed locally, awaiting the
// host's authoritative confirmation. Value = remaining syncs to suppress a
// host-rebroadcast respawn. The host hasn't processed the forwarded kill yet, so
// it keeps broadcasting the monster alive; without this, apply_monster_sync
// respawns it ("killed the zed, it rose again, dropped 2-3 corpses" — GH#1). The
// loop repeats, each iteration leaving a host-side corpse that syncs back.
// Bounded: a kill the host REJECTS (HP desync) reappears after the window
// instead of vanishing forever.
static std::unordered_map<uint32_t, int> g_client_pending_kill;
static constexpr int CLIENT_PENDING_KILL_SYNCS = 3;

// Client: fingerprint of the last host_worn list applied — avoids re-dressing every tick.
static std::string g_client_host_worn_sig;

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
    std::vector<int> ids;
    std::vector<std::string> names;
    if( remote_player_npc_id.is_valid() ) {
        ids.push_back( remote_player_npc_id.get_value() );
        npc *rn = g->critter_by_id<npc>( remote_player_npc_id );
        if( rn && !rn->name.empty() ) {
            names.push_back( rn->name );
        }
    }
    if( client_host_npc_id.is_valid() ) {
        ids.push_back( client_host_npc_id.get_value() );
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

static void purge_npcs_by_name( const std::string &name );

// Remove stale MP NPCs saved from a previous session.
// Called once per process lifetime, early in the game loop.
static bool mp_cleanup_done = false;
static void mp_cleanup_stale_npcs()
{
    if( mp_cleanup_done ) {
        return;
    }
    mp_cleanup_done = true;

    const cata_path path = mp_npc_cleanup_path();
    bool found_any = false;
    read_from_file_optional_json( path, [&]( const JsonValue & jv ) {
        // Support both the old array format (ids only) and the new object format
        // (ids + names).  The old format was written by earlier versions of the
        // code and may still be present in existing saves.
        if( jv.test_array() ) {
            // Legacy: plain array of integer IDs
            for( const JsonValue &v : jv.get_array() ) {
                const character_id id( v.get_int() );
                found_any = true;
                npc *n = g->critter_by_id<npc>( id );
                if( n ) {
                    // Clean despawn — a stale proxy, not a death; no corpse/loot.
                    g->remove_npc( id );
                }
                if( id.is_valid() ) {
                    overmap_buffer.remove_npc( id );
                }
            }
        } else {
            JsonObject jo = jv.get_object();
            for( const JsonValue &v : jo.get_array( "ids" ) ) {
                const character_id id( v.get_int() );
                found_any = true;
                npc *n = g->critter_by_id<npc>( id );
                if( n ) {
                    // Clean despawn — a stale proxy, not a death; no corpse/loot.
                    g->remove_npc( id );
                }
                if( id.is_valid() ) {
                    overmap_buffer.remove_npc( id );
                }
            }
            for( const JsonValue &v : jo.get_array( "names" ) ) {
                const std::string nm = v.get_string();
                found_any = true;
                purge_npcs_by_name( nm );
            }
        }
    } );
    if( found_any ) {
        g->cleanup_dead();
        std::cout << "[cdda-mp] Cleaned up stale MP NPCs from previous session." << std::endl;
    }
    remove_file( path );

    // Orphan sweep — catches proxies that survived because the cleanup file
    // wasn't written (host saved while connected, then quit).  Any NPC tagged
    // with mp_proxy=1 at spawn time is, by definition, a stale proxy now —
    // the current session hasn't spawned any yet.  Active proxies will be
    // re-created fresh when the partner reconnects.
    //
    // Also legacy-purge by the default proxy name "player2" — pre-tag saves
    // have untagged ghosts that the value-based sweep can't see.  Safe to
    // hardcode because "player2" is the client_connect default and no SP NPC
    // ships with that name.
    // In client mode the host creates a proxy NPC named after the client's own
    // character.  If that NPC leaked into the shared save directory it appears
    // as a walkable ghost of the client's own character on the next session.
    // Purge any NPC whose name matches the local avatar — safe because no SP
    // NPC is ever named after the currently-loaded player character.
    const std::string own_name = get_avatar().name;

    int orphans = 0;
    std::vector<character_id> orphan_ids;
    for( npc &candidate : g->all_npcs() ) {
        if( candidate.maybe_get_value( "mp_proxy" )
            || candidate.name == "player2"
            || ( !own_name.empty() && candidate.name == own_name ) ) {
            orphan_ids.push_back( candidate.getID() );
        }
    }
    for( const character_id &id : orphan_ids ) {
        if( g->critter_by_id<npc>( id ) ) {
            // Silent removal — die() emits a "X dies!" message which is
            // misleading when the NPC is a leftover proxy, not a combat death.
            // NB: game::remove_npc() only erases the active (loaded) copy; the
            // overmap copy is swept separately below.
            g->remove_npc( id );
            ++orphans;
        }
    }
    // Overmap orphan sweep — the loaded sweep above only touches NPCs currently
    // in the reality bubble; the overmap keeps its OWN copy, which
    // g->load_npcs() re-hydrates every tick (the phantom partner that reappears
    // next to the host with no client connected).  The old code tried to erase
    // it inline but guarded on id.is_valid() (value > 0); proxies that lost
    // their assigned id on save/reload land at id=-1, so the overmap copy was
    // never removed.  Drive removal from the overmap list itself: every id is
    // guaranteed present (no debugmsg) and the id sign is irrelevant.
    int overmap_orphans = 0;
    std::vector<character_id> om_orphan_ids;
    for( const auto &ptr : overmap_buffer.get_npcs_near_player( 500 ) ) {
        if( ptr && ( ptr->maybe_get_value( "mp_proxy" ) || ptr->name == "player2"
                     || ( !own_name.empty() && ptr->name == own_name ) ) ) {
            om_orphan_ids.push_back( ptr->getID() );
        }
    }
    for( const character_id &id : om_orphan_ids ) {
        overmap_buffer.remove_npc( id );
        ++overmap_orphans;
    }
    if( orphans > 0 || overmap_orphans > 0 ) {
        g->cleanup_dead();
        mp_log( "[cdda-mp] ORPHAN-SWEEP removed " + std::to_string( orphans )
                + " loaded + " + std::to_string( overmap_orphans ) + " overmap proxy NPCs" );
    }
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
    std::vector<character_id> to_remove;
    for( npc &n : g->all_npcs() ) {
        if( n.getID() == client_host_npc_id ) {
            continue;   // the host's proxy — the one NPC we keep
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

// Remove every NPC with the given name from both the active critter list and the
// overmap buffer. Eliminates artifacts left by previous sessions before the
// ID-tracking cleanup mechanism existed.
// Reset per-world MP state when a world is unloaded (quit-to-menu). The
// stale-NPC sweep is one-shot per world load via mp_cleanup_done; without this
// reset, re-entering a world in the same process skips the sweep and leaves
// phantom proxy NPCs from a prior load-in (a session that quit while connected,
// so its proxy was saved into the world and never cleanly removed). Reproduced
// 2026-06-03 ("Alicia Donald" phantom). NOT a same-machine artifact — any host
// that enters a world twice per launch hits it.
void mp_on_world_exit()
{
    mp_cleanup_done = false;
    // A world exit ends any co-op session.  Clear the host/client session mode so
    // the NEXT game started from the menu is treated as plain single-player.
    // set_client_mode(false) was previously only called on a *connect failure*, so
    // after a successful co-op session the process stayed in client mode until it
    // quit.  A solo "play now" afterward then saw is_client_mode()==true, got
    // routed into the disposable "Co-op (auto) - DO NOT SELECT" scratch world, and
    // its save was suppressed — silent single-player save loss.  The join/host
    // menu paths re-arm the mode before the next session, so clearing here is safe.
    if( is_client_mode() || is_host_mode() ) {
        mp_log( "[cdda-mp] WORLD-EXIT: clearing session mode (client=" +
                std::to_string( is_client_mode() ) + " host=" +
                std::to_string( is_host_mode() ) + ")" );
        set_client_mode( false );
        set_host_mode( false );
    }
}

static void purge_npcs_by_name( const std::string &name )
{
    if( name.empty() ) {
        return;
    }
    int active_killed = 0;
    int overmap_removed = 0;
    // Active critters first
    for( npc *n : g->get_npcs_if( [&]( const npc & np ) {
    return np.name == name;
} ) ) {
        mp_log( "[cdda-mp] PURGE active: id=" + std::to_string( n->getID().get_value() )
                + " name='" + n->name + "' pos=" + n->pos_abs().to_string() );
        // Clean despawn — a stale proxy, not a death; no corpse/loot dropped.
        g->remove_npc( n->getID() );
        ++active_killed;
    }
    g->cleanup_dead();
    // Overmap buffer — radius 500 sm covers the entire typical play area
    for( const auto &ptr : overmap_buffer.get_npcs_near_player( 500 ) ) {
        if( ptr && ptr->name == name && ptr->getID().is_valid() ) {
            mp_log( "[cdda-mp] PURGE overmap: id=" + std::to_string( ptr->getID().get_value() )
                    + " name='" + ptr->name + "'" );
            ++overmap_removed;
            overmap_buffer.remove_npc( ptr->getID() );
        }
    }
    mp_log( "[cdda-mp] PURGE summary name='" + name + "' active=" + std::to_string( active_killed )
            + " overmap=" + std::to_string( overmap_removed ) );
}

static cata_path remote_player_save_path( const std::string &name )
{
    std::string safe;
    for( char c : name ) {
        safe += std::isalnum( static_cast<unsigned char>( c ) ) ? c : '_';
    }
    return PATH_INFO::world_base_save_path() / ( "mp_player_" + safe + ".json" );
}

static void save_remote_player()
{
    if( !remote_player_connected ) {
        return;
    }
    npc *remote = g->critter_by_id<npc>( remote_player_npc_id );
    if( !remote ) {
        return;
    }
    const cata_path path = remote_player_save_path( remote->name );
    write_to_file( path, [&]( std::ostream & fout ) {
        JsonOut json( fout );
        remote->serialize( json );
    }, "multiplayer character" );
    std::cout << "[cdda-mp] Saved remote player '" << remote->name << "'" << std::endl;
}

static void spawn_remote_player( const std::string &name )
{
    if( remote_player_connected ) {
        std::cout << "[cdda-mp] Remote player already exists, ignoring spawn." << std::endl;
        return;
    }
    // Purge any stale NPCs from previous sessions that share this name —
    // covers artifacts that predate the ID-tracking cleanup file.
    purge_npcs_by_name( name );

    avatar &u = get_avatar();
    map &m = get_map();

    // Find nearest passable tile that is NOT the host's own tile.
    // Search outward from radius 1; expand up to 20 tiles if needed.
    tripoint_bub_ms spawn_pos = u.pos_bub();
    bool found = false;
    for( int radius = 1; radius <= 20 && !found; ++radius ) {
        for( int dy = -radius; dy <= radius && !found; ++dy ) {
            for( int dx = -radius; dx <= radius && !found; ++dx ) {
                if( std::abs( dx ) != radius && std::abs( dy ) != radius ) {
                    continue; // only check the ring edge
                }
                tripoint_bub_ms candidate = u.pos_bub() + tripoint( dx, dy, 0 );
                if( candidate == u.pos_bub() ) {
                    continue; // never land on the host's exact tile
                }
                if( m.inbounds( candidate ) && !m.impassable( candidate ) ) {
                    spawn_pos = candidate;
                    found = true;
                }
            }
        }
    }
    if( !found ) {
        std::cout << "[cdda-mp] WARNING: no passable spawn tile found near host, using host tile" <<
                  std::endl;
    }

    shared_ptr_fast<npc> remote = make_shared_fast<npc>();

    const cata_path save_path = remote_player_save_path( name );
    bool loaded = read_from_file_optional_json( save_path, [&]( const JsonValue & jv ) {
        remote->deserialize( jv.get_object() );
    } );

    if( loaded ) {
        remote->name = name;
        std::cout << "[cdda-mp] Loaded saved character for '" << name << "'" << std::endl;
    } else {
        remote->normalize();
        remote->name = name;
    }
    // Cache the partner's name so the Co-op panel has a stable fallback even
    // if the NPC pointer briefly becomes unresolvable (load/unload races).
    g_partner_name_cached = name;

    // Ensure the NPC has a valid character_id before inserting into the world.
    // make_shared_fast<npc>() + normalize() never calls setID(), so we must
    // assign one explicitly here. Loaded NPCs may already have a valid id from
    // their save file; assign_npc_id() is safe to call regardless.
    if( !remote->getID().is_valid() ) {
        remote->setID( g->assign_npc_id() );
    }

    // Always respawn near the host player regardless of saved position
    remote->spawn_at_precise( m.get_abs( spawn_pos ) );
    overmap_buffer.insert_npc( remote );
    g->load_npcs();

    remote_player_npc_id = remote->getID();
    // Tag the proxy so a load-time sweep can find and remove orphans from
    // sessions where the cleanup file went missing (e.g. host saved while
    // connected, then quit — the proxy ends up in the world save).
    remote->set_value( "mp_proxy", std::string( "1" ) );
    mp_log( "[cdda-mp] spawn: remote_player_npc_id=" +
            std::to_string( remote_player_npc_id.get_value() ) +
            " valid=" + std::to_string( remote_player_npc_id.is_valid() ) +
            " tagged mp_proxy=1" );

    // Co-op partner: apply ally status AFTER load_npcs so the NPC pointer is
    // fully wired into the game state (faction manager, critter tracker, etc.).
    npc *rn = g->critter_by_id<npc>( remote_player_npc_id );
    if( rn ) {
        rn->set_attitude( NPCATT_FOLLOW );
        rn->set_fac( faction_id( "your_followers" ) );
        rn->chatbin.first_topic = "TALK_FRIEND";
        rn->op_of_u.trust = 10;
        rn->op_of_u.value = 10;
        g->add_npc_follower( rn->getID() );
    }
    remote_player_connected = true;
    g_remote_moves = rn ? rn->get_speed() : 100;  // grant first turn immediately
    g_client_acted_this_turn = false;
    g_tile_baseline.clear();  // force full resync — client reloads from disk on connect
    mp_reset_overmap_sync();  // bulk-send the overmap region to the fresh client
    mp_reset_map_sync();      // re-stream submap terrain+furniture to the fresh client
    g_client_known_veh_nids.clear();  // re-snapshot every visible vehicle for the fresh client
    g_server_veh_parts_count.clear();
    g_server_veh_live_nids.clear();
    g_server_mon_last_sent.clear();   // force full monster snapshot to the fresh client (delta cache)
    g_separation_tier = 0;
    g_separation_settled = false;
    g_last_forwarded_msg_count = Messages::size();  // don't forward pre-connect history
    mp_save_npc_ids();  // persist ID so next session can clean it up

    // Don't announce the join here — at spawn the only name we have is the
    // "player2" placeholder (the client's real name arrives a beat later in
    // its first char_stats). The named announcement fires from the char_stats
    // handler the moment the proxy is renamed from the placeholder.
    std::cout << "[cdda-mp] Spawned remote player '" << name << "' at "
              << spawn_pos.x() << "," << spawn_pos.y() << std::endl;

    // Send initial state to player 2, then ask it to resend worn/hair so the
    // fresh NPC gets the correct appearance even after a respawn.
    server *srv = get_active_server();
    if( srv ) {
        srv->post_broadcast( serialize_remote_player_state() + "\n" );
        srv->post_broadcast( "{\"type\":\"resync_request\"}\n" );
    }

    // Templates wire-sync: send host's local template list so the client can
    // request any it doesn't already have.  Cheap one-shot exchange — the
    // client sends its own list independently on its side.
    mp_templates_sync_on_join();
}

static void remove_remote_player()
{
    if( !remote_player_connected ) {
        return;
    }

    save_remote_player();

    npc *remote = g->critter_by_id<npc>( remote_player_npc_id );
    if( remote ) {
        // Clean despawn — the partner quit/disconnected, they are NOT dead.
        // die() drops a corpse carrying all their gear (a pickup-able loot dupe).
        g->remove_npc( remote_player_npc_id );
    }
    // Remove from overmap buffer so the NPC doesn't get written back into the
    // world save, which would cause a stale NPC to appear on next load.
    // Guard with find_npc(): the proxy is normally an in-bubble ACTIVE npc
    // (already despawned by g->remove_npc above) and was never registered as an
    // overmap NPC, so an unconditional remove_npc() hits its internal "NPC not
    // found" debugmsg — a BLOCKING modal popup on the host EVERY time the client
    // disconnects ("client quit drags the host down", 2026-06-21). find_npc()
    // returns null without complaint, so we only remove when it's actually there.
    if( remote_player_npc_id.is_valid() && overmap_buffer.find_npc( remote_player_npc_id ) ) {
        overmap_buffer.remove_npc( remote_player_npc_id );
    }

    remote_player_connected = false;
    remote_player_npc_id = character_id();
    g_proxy_was_alive = false;
    g_separation_tier = 0;
    g_separation_settled = false;
    // Do NOT reset g_grant_seq here.  It must stay monotonically increasing so
    // that a reconnecting client (which resets g_client_last_grant_seq=0 via the
    // join path) always sees seq > 0 and accepts the first new grant.  Resetting
    // to 0 here caused a deadlock: client last_seq=N, server restarts at seq=1..N
    // which were all skipped as "old seq".
    mp_save_npc_ids();  // ID is now invalid — clears the cleanup file entry
    add_msg( m_bad, "The other player has disconnected." );
    std::cout << "[cdda-mp] Remote player removed from world." << std::endl;
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
static void flush_action_msgs( unsigned long long pre_msg, const std::string &npc_name )
{
    const unsigned long long cur = Messages::size();
    if( cur <= pre_msg ) {
        return;
    }
    const size_t count = static_cast<size_t>( cur - pre_msg );
    g_last_forwarded_msg_count = cur;  // advance watermark to avoid double-forward
    const auto new_msgs = Messages::recent_messages( count );
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
        g_action_msgs_pending.push_back( out );
    }
}

// Capture messages the avatar generated since pre_msg and queue them for the client,
// replacing "You" with the host character's name so the client sees attributed hits.
// Called from do_turn after each avatar handle_action() when a remote player is connected.
// Capture ALL messages generated during vehmove() and queue them for the remote
// client as their own messages (no attribution — the driver sees these directly).
void host_capture_vehmove_msgs( unsigned long long pre_msg )
{
    if( !is_hosting() || !remote_player_connected ) {
        return;
    }
    const unsigned long long cur = Messages::size();
    mp_log( "[veh-move] host_capture_vehmove_msgs: pre=" + std::to_string( pre_msg ) +
            " cur=" + std::to_string( cur ) +
            " delta=" + std::to_string( cur > pre_msg ? cur - pre_msg : 0 ) );
    if( cur <= pre_msg ) {
        return;
    }
    const auto new_msgs = Messages::recent_messages( static_cast<size_t>( cur - pre_msg ) );
    for( const auto &[time_str, text] : new_msgs ) {
        ( void )time_str;
        mp_log( "[veh-move] capture queuing: " + text );
        g_action_msgs_pending.push_back( text );
    }
}

void host_broadcast_vehicle_step()
{
    if( !is_hosting() || !remote_player_connected ) {
        return;
    }
    server *srv = get_active_server();
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
        auto vid_it = g_server_veh_ids.find( v );
        if( vid_it == g_server_veh_ids.end() ) {
            g_server_veh_ids[v] = ++g_next_net_id;
            vid_it = g_server_veh_ids.find( v );
        }
        const uint32_t nid = vid_it->second;
        const tripoint_abs_ms vabs = v->pos_abs();
        const int face_deg     = static_cast<int>( std::lround( to_degrees( v->face.dir() ) ) );
        const int turn_dir_deg = static_cast<int>( std::lround( to_degrees( v->turn_dir ) ) );
        if( !vfirst ) {
            vehicles_json += ',';
        }
        vfirst = false;
        vehicles_json += "{\"nid\":" + std::to_string( nid )
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
    static std::string g_last_vehicle_step_payload;
    if( vehicles_json == g_last_vehicle_step_payload ) {
        return;
    }
    g_last_vehicle_step_payload = vehicles_json;
    srv->post_broadcast( R"({"type":"vehicle_step","vehicles":)" + vehicles_json + "}\n" );
}

// A relayed line is shown to the PARTNER, so a mention of the partner by name
// should read as "you" to them (host's "Niesha swaps places with player2" →
// client sees "Niesha swaps places with you").  Guarded against the same-name
// case: if the partner's cached name equals the local player's own name (e.g.
// both picked the same preset), we can't disambiguate, so leave names rather
// than collapse to "you swaps places with you".  own_name is the local avatar.
static void mp_addressee_to_you( std::string &s, const std::string &own_name )
{
    const std::string &name = g_partner_name_cached;
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
    if( !is_hosting() || !remote_player_connected ) {
        return;
    }
    const unsigned long long cur = Messages::size();
    if( cur <= pre_msg ) {
        return;
    }
    const std::string host_name = get_avatar().name;
    const auto new_msgs = Messages::recent_messages( static_cast<size_t>( cur - pre_msg ) );
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
        mp_addressee_to_you( out, host_name );   // partner's name → "you" (guarded)
        g_host_action_msgs_pending.push_back( out );
    }
}

void host_broadcast_post_action()
{
    if( !is_hosting() || !remote_player_connected ) {
        return;
    }
    server *srv = get_active_server();
    if( !srv ) {
        return;
    }
    mp_log( "[cdda-mp] HOST-ACK: post-action broadcast grant_seq="
            + std::to_string( g_grant_seq ) );
    srv->post_broadcast( serialize_remote_player_state() + "\n" );
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
static void srv_emit_ack( const char *action_name )
{
    g_client_acted_this_turn = true;
    g_remote_moves = 0;
    mp_log( std::string( "[cdda-mp] SRV-ACK: moves=0 (" ) + action_name
            + ") grant_seq=" + std::to_string( g_grant_seq ) );
    server *srv = get_active_server();
    if( srv ) {
        srv->post_broadcast( serialize_remote_player_state() + "\n" );
    }
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
static void mp_handle_shout_recv( const std::string &msg );

static void handle_remote_action( const std::string &/*name*/, const std::string &msg )
{
    if( !remote_player_connected ) {
        return;
    }

    npc *remote = g->critter_by_id<npc>( remote_player_npc_id );
    if( !remote ) {
        return;
    }

    // Trade delta from client — client traded with the host's NPC proxy on its
    // side.  Apply item changes to the host's real avatar before anything else.
    if( msg.find( R"("type":"trade_delta")" ) != std::string::npos ) {
        try {
            JsonValue jv = json_loader::from_string( msg );
            JsonObject jo2 = jv.get_object();
            jo2.allow_omitted_members();
            avatar &av = get_avatar();
            if( jo2.has_array( "give" ) ) {
                for( const JsonValue &iv : jo2.get_array( "give" ) ) {
                    JsonObject io = iv.get_object();
                    io.allow_omitted_members();
                    item tmp;
                    tmp.deserialize( io );
                    av.i_add( tmp );
                    mp_log( "[cdda-mp] trade_delta(host): gained " + tmp.typeId().str() );
                }
            }
            if( jo2.has_array( "take" ) ) {
                for( const JsonValue &iv : jo2.get_array( "take" ) ) {
                    JsonObject io = iv.get_object();
                    io.allow_omitted_members();
                    item tmp;
                    tmp.deserialize( io );
                    const itype_id tid = tmp.typeId();
                    bool found = false;
                    av.remove_items_with( [&tid, &found]( const item & i ) {
                        if( !found && i.typeId() == tid ) {
                            found = true;
                            return true;
                        }
                        return false;
                    }, 1 );
                    mp_log( "[cdda-mp] trade_delta(host): lost " + tid.str()
                            + ( found ? " (ok)" : " (NOT FOUND)" ) );
                }
            }
        } catch( const JsonError &e ) {
            mp_log( std::string( "[cdda-mp] trade_delta(host) parse error: " ) + e.what() );
        }
        return;
    }

    if( msg.find( R"("type":"note_sync")" ) != std::string::npos ) {
        mp_handle_note_sync( msg );
        return;
    }

    if( msg.find( R"("type":"chat")" ) != std::string::npos ) {
        mp_handle_chat_msg( msg );
        return;
    }

    if( msg.find( R"("type":"high_five")" ) != std::string::npos ) {
        mp_handle_high_five_recv( msg );
        return;
    }

    if( msg.find( R"("type":"shout")" ) != std::string::npos ) {
        mp_handle_shout_recv( msg );
        return;
    }

    map &m = get_map();

    // Snapshot message count before processing so we can forward ALL messages
    // generated during this action (hits, damage, kills, sounds) to the client.
    const unsigned long long pre_action_msg = Messages::size();

    // Give the NPC its current move budget before executing any action.
    // (monmove skips remote player NPCs, so we manage AP ourselves.)
    remote->set_moves( g_remote_moves );

    // Parse the full action JSON once here so char_stats and other top-level
    // fields are accessible without re-parsing inside each action block.
    JsonValue jv_top = json_loader::from_string( msg );
    JsonObject jo = jv_top.get_object();
    jo.allow_omitted_members();

    // Track the client's current activity for HUD + partner-notice display
    // AND for the lockstep bypass in wait_for_client_action.  Field is empty
    // when the client is idle.  The heartbeat is belt-and-suspenders: the
    // primary signal is the explicit activity_start / activity_end actions
    // handled below, but every action carries this snapshot too so a missed
    // start/end can still be reconciled on the next packet.
    if( jo.has_string( "client_activity" ) ) {
        g_partner_activity = jo.get_string( "client_activity" );
        mp_partner_activity_transition_check();
    }
    if( jo.has_int( "client_activity_pct" ) ) {
        g_partner_activity_pct = jo.get_int( "client_activity_pct" );
    }
    if( jo.has_int( "client_activity_moves_total" ) ) {
        g_partner_activity_moves_total = jo.get_int( "client_activity_moves_total" );
    }
    if( jo.has_int( "client_morale" ) ) {
        g_partner_morale = jo.get_int( "client_morale" );
    }
    if( jo.has_int( "client_hp_cur" ) ) {
        g_partner_hp_cur = jo.get_int( "client_hp_cur" );
    }
    if( jo.has_int( "client_hp_max" ) ) {
        g_partner_hp_max = jo.get_int( "client_hp_max" );
    }
    // Ping: remember the client's stamp to echo back; adopt the client-measured
    // RTT so the host panel shows the same latency the client computed.
    if( jo.has_int( "client_ping" ) ) {
        g_last_client_ping_stamp = jo.get_int( "client_ping" );
    }
    if( is_hosting() && jo.has_int( "client_rtt" ) ) {
        g_partner_ping_ms = jo.get_int( "client_rtt" );
    }
    if( jo.has_int( "client_calendar_turn" ) ) {
        g_partner_calendar_turn = jo.get_int( "client_calendar_turn" );
    }

    // Explicit lifecycle markers for the client's passive activities.  These
    // are signal-only — they don't consume host moves and don't drive any
    // simulation on the host side.  Their sole job is to open and close the
    // lockstep bypass cleanly, so variable-duration activities like ACT_DROP
    // don't race the heartbeat.
    if( msg.find( R"("action":"activity_start")" ) != std::string::npos ) {
        const std::string id = jo.get_string( "activity_id", "" );
        const std::string prev = g_partner_activity;
        if( !id.empty() ) {
            g_partner_activity = id;
            mp_partner_activity_transition_check();
        }
        mp_log( "[cdda-mp] ACT-START RECV: id=" + id
                + " g_partner_activity prev=" + prev + " now=" + g_partner_activity );
        return;
    }
    if( msg.find( R"("action":"activity_end")" ) != std::string::npos ) {
        const std::string id = jo.get_string( "activity_id", "" );
        const std::string prev = g_partner_activity;
        g_partner_activity.clear();
        mp_partner_activity_transition_check();
        mp_log( "[cdda-mp] ACT-END RECV: id=" + id
                + " g_partner_activity prev=" + prev + " now=" + g_partner_activity );
        return;
    }

    // Graceful session-end notification from the client (v1 save handshake).
    // Snapshot the host's world before the TCP socket goes down so any
    // shared state the client touched is captured.  Client owns its own
    // .sav, so nothing to do for their character on this side.
    if( msg.find( R"("action":"session_ending")" ) != std::string::npos ) {
        mp_log( "[cdda-mp] SESSION-END RECV: client is leaving — auto-saving host" );
        add_msg( m_warning, _( "Your partner is leaving.  The game has been saved." ) );
        g->quicksave();
        return;
    }

    // Co-op save handshake: the client saved on their side and asked us to save
    // the shared world too, so the host's authoritative save and the client's
    // local save stay at the same game-time.  Reply save_done for confirmation.
    if( msg.find( R"("action":"save_request")" ) != std::string::npos ) {
        mp_log( "[cdda-mp] SAVE-REQ RECV: partner asked host to save the shared world" );
        g->quicksave();
        add_msg( m_info, _( "Your partner saved — the shared world was saved too." ) );
        if( server *srv = get_active_server() ) {
            srv->post_broadcast( "{\"type\":\"save_done\"}\n" );
        }
        return;
    }

    // Templates wire-sync handlers (symmetric — same shape on host and client).
    if( msg.find( R"("type":"templates_list")" ) != std::string::npos ) {
        mp_handle_templates_list( msg );
        return;
    }
    if( msg.find( R"("type":"template_request")" ) != std::string::npos ) {
        mp_handle_template_request( msg );
        return;
    }
    if( msg.find( R"("type":"template_data")" ) != std::string::npos ) {
        mp_handle_template_data( msg );
        return;
    }

    // Apply the client's real character stats to the proxy so all action
    // handlers (pldrive steering, melee, etc.) use the player's actual values.
    if( jo.has_object( "char_stats" ) ) {
        JsonObject cs = jo.get_object( "char_stats" );
        cs.allow_omitted_members();
        // Rename the proxy from the "player2" placeholder to the client's real
        // character name once it arrives. Drives the on-map @ label and the
        // sidebar nearby-creature list.
        if( cs.has_string( "name" ) ) {
            const std::string cname = cs.get_string( "name" );
            if( !cname.empty() && remote->name != cname ) {
                // First rename away from the "player2" placeholder is the real
                // "joined" moment — announce it here with the actual name
                // instead of the placeholder the spawn path would have used.
                const bool was_placeholder = ( remote->name == "player2" );
                remote->name = cname;
                // Keep the partner-name cache in lockstep with the proxy name —
                // mp_addressee_to_you() and the Co-op panel both read it, and a
                // stale value (the session-id placeholder set at spawn) means a
                // relayed "Niesha swaps places with Jeff" never converts Jeff→you.
                g_partner_name_cached = cname;
                if( was_placeholder ) {
                    add_msg( m_good, _( "%s has connected and joined the game." ), cname );
                }
            }
        }
        if( cs.has_int( "str" ) ) {
            remote->set_str_base( cs.get_int( "str" ) );
        }
        if( cs.has_int( "dex" ) ) {
            remote->set_dex_base( cs.get_int( "dex" ) );
        }
        if( cs.has_int( "int" ) ) {
            remote->set_int_base( cs.get_int( "int" ) );
        }
        if( cs.has_int( "per" ) ) {
            remote->set_per_base( cs.get_int( "per" ) );
        }
        if( cs.has_array( "skills" ) ) {
            for( const JsonValue &entry : cs.get_array( "skills" ) ) {
                JsonArray ja = entry.get_array();
                const skill_id sid( ja.next_string() );
                const int lvl = ja.next_int();
                remote->set_skill_level( sid, lvl );
            }
        }
        if( cs.has_array( "profs" ) ) {
            for( const JsonValue &pv : cs.get_array( "profs" ) ) {
                const proficiency_id pid( pv.get_string() );
                if( !remote->has_proficiency( pid ) ) {
                    remote->add_proficiency( pid, true );
                }
            }
        }
    }

    // Extract action label for HUD "Queued" row on the server panel.
    {
        const size_t pos = msg.find( R"("action":")" );
        if( pos != std::string::npos ) {
            const size_t start = pos + 10;
            const size_t end = msg.find( '"', start );
            if( end != std::string::npos ) {
                std::string act = msg.substr( start, end - start );
                // Append direction for move actions so it reads e.g. "move:n".
                if( act == "move" ) {
                    const size_t dpos = msg.find( R"("dir":")" );
                    if( dpos != std::string::npos ) {
                        const size_t dstart = dpos + 7;
                        const size_t dend = msg.find( '"', dstart );
                        if( dend != std::string::npos ) {
                            act += ':' + msg.substr( dstart, dend - dstart );
                        }
                    }
                }
                if( act != "worn_sync" ) {
                    g_last_client_action_label = act;
                }
            }
        }
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
        g_last_forwarded_msg_count = Messages::size();
    }

    // Worn-item sync — client sends this once after joining (and after any
    // wear/take-off) so the remote NPC reflects the client's actual equipment.
    if( msg.find( R"("action":"worn_sync")" ) != std::string::npos ) {
        mp_log( "[cdda-mp] worn_sync recv: " + msg.substr( 0, 120 ) );
        try {
            JsonValue jv = json_loader::from_string( msg );
            JsonObject jo = jv.get_object();
            jo.allow_omitted_members();
            // Sync gender so tileset uses the correct overlay prefix.
            if( jo.has_bool( "male" ) ) {
                remote->male = jo.get_bool( "male" );
            }
            if( jo.has_array( "worn" ) ) {
                remote->clear_worn();
                for( const JsonValue &wv : jo.get_array( "worn" ) ) {
                    JsonObject wo = wv.get_object();
                    wo.allow_omitted_members();
                    // Full item deserialization — preserves pocket contents (items
                    // inside jacket, fanny pack, etc.) so trade menu and skill
                    // checks see the client's actual carried items.
                    item worn_item;
                    try {
                        worn_item.deserialize( wo );
                    } catch( const JsonError &e ) {
                        // Fallback for legacy {t,v} format or parse errors.
                        const itype_id tid( wo.get_string( "t", "" ) );
                        if( tid.is_valid() ) {
                            worn_item = item( tid );
                            const std::string var = wo.get_string( "v", "" );
                            if( !var.empty() ) {
                                worn_item.set_itype_variant( var );
                            }
                        }
                        mp_log( std::string( "[cdda-mp] worn_sync: worn item parse error (fallback): " )
                                + e.what() );
                    }
                    if( !worn_item.typeId().is_empty() && worn_item.typeId().is_valid() ) {
                        // wear_item(who, item, interactive, do_calc_encumbrance, do_sort, quiet)
                        auto result = remote->worn.wear_item( *remote, worn_item,
                                                              false, false, true, true );
                        if( !result ) {
                            mp_log( "[cdda-mp] worn_sync: wear_item FAILED for "
                                    + worn_item.typeId().str() );
                        }
                    }
                }
                std::vector<item *> applied_worn;
                remote->worn.inv_dump( applied_worn );
                std::string worn_list;
                for( const item *wi : applied_worn ) {
                    worn_list += wi->typeId().str() + ' ';
                }
                mp_log( "[cdda-mp] worn_sync applied: [" + worn_list + "]" );
                // Log overlay IDs the NPC would generate (confirm tileset coverage).
                std::string ov_log;
                for( const auto &ov : remote->get_overlay_ids() ) {
                    ov_log += ov.first + ' ';
                }
                mp_log( "[cdda-mp] worn_sync overlays: [" + ov_log + "]" );
            }
            // Apply the client's wielded weapon to the remote NPC.
            // Prefer the full item serialization (carries ammo, mods, charges,
            // contents) when present; fall back to typeId-only for legacy.
            std::string wielded_str;
            jo.read( "wielded", wielded_str );
            bool applied_full = false;
            if( jo.has_object( "wielded_obj" ) ) {
                try {
                    JsonObject wo = jo.get_object( "wielded_obj" );
                    wo.allow_omitted_members();
                    item tmp;
                    tmp.deserialize( wo );
                    remote->set_wielded_item( tmp );
                    applied_full = true;
                    mp_log( "[cdda-mp] worn_sync: set wielded(full)=" + tmp.typeId().str()
                            + " charges=" + std::to_string( tmp.charges )
                            + " ammo=" + std::to_string( tmp.ammo_remaining() ) );
                } catch( const JsonError &e ) {
                    mp_log( std::string( "[cdda-mp] worn_sync: wielded_obj parse error: " )
                            + e.what() );
                }
            }
            if( !applied_full ) {
                if( !wielded_str.empty() ) {
                    const itype_id wid( wielded_str );
                    if( wid.is_valid() ) {
                        remote->set_wielded_item( item( wid ) );
                        mp_log( "[cdda-mp] worn_sync: set wielded=" + wielded_str );
                    }
                } else {
                    // Client is empty-handed — clear the proxy's weapon slot.
                    // remove_weapon() zeroes weapon=item() and returns the old
                    // item without touching the map, so no duplication.
                    // Do NOT call unwield() here — that moves the item to a pocket
                    // or drops to the floor, duplicating what the drop/throw/unload
                    // handler already placed there via tile_changes.
                    remote->remove_weapon();
                    mp_log( "[cdda-mp] worn_sync: remove_weapon (client empty-handed)" );
                }
            }
            // Apply all mutations from the client's "appearance" array to the
            // remote NPC proxy.  Full state sync: clear every mutation on the
            // proxy first, then apply the client's list.  This covers chargen
            // cosmetics AND physical mutations (Fangs, Sleek Fur, Spines, etc.)
            // which the old per-type clearing missed.
            if( jo.has_array( "appearance" ) ) {
                std::vector<trait_id> to_unset;
                for( const trait_id &existing : remote->get_mutations() ) {
                    to_unset.push_back( existing );
                }
                for( const trait_id &old : to_unset ) {
                    remote->unset_mutation( old );
                }
                int applied = 0;
                for( const JsonValue &av : jo.get_array( "appearance" ) ) {
                    JsonObject ao = av.get_object();
                    ao.allow_omitted_members();
                    const std::string mid = ao.get_string( "id", "" );
                    if( mid.empty() ) {
                        continue;
                    }
                    const trait_id tid( mid );
                    if( !tid.is_valid() ) {
                        mp_log( "[cdda-mp] worn_sync: appearance id INVALID: " + mid );
                        continue;
                    }
                    const std::string var_str = ao.get_string( "var", "" );
                    const mutation_variant *var = var_str.empty()
                                                  ? nullptr
                                                  : tid.obj().variant( var_str );
                    remote->set_mutation( tid, var );
                    ++applied;
                }
                mp_log( "[cdda-mp] worn_sync: appearance cleared "
                        + std::to_string( to_unset.size() )
                        + " applied " + std::to_string( applied ) );
            }
            std::string ma_style_str;
            jo.read( "ma_style", ma_style_str );
            if( !ma_style_str.empty() ) {
                const matype_id mid( ma_style_str );
                if( mid.is_valid() ) {
                    remote->martial_arts_data->set_style( mid, true );
                    mp_log( "[cdda-mp] worn_sync: set ma_style=" + ma_style_str );
                }
            }
            // Rebuild the proxy's main (non-worn, non-wielded) inventory from the
            // client's serialized blob.  This makes tools, books, guns-in-bag,
            // currency, and any other carried items visible in the trade menu and
            // available to host-side skill / activity checks.
            if( jo.has_array( "client_inv" ) ) {
                try {
                    remote->inv->clear();
                    JsonArray inv_ja = jo.get_array( "client_inv" );
                    remote->inv->json_load_items( inv_ja );
                    mp_log( "[cdda-mp] worn_sync: inv rebuilt items=" +
                            std::to_string( remote->inv->size() ) );
                } catch( const JsonError &e ) {
                    mp_log( std::string( "[cdda-mp] worn_sync: inv rebuild error: " ) + e.what() );
                }
            }
        } catch( const JsonError &e ) {
            mp_log( std::string( "[cdda-mp] worn_sync parse error: " ) + e.what() );
        }
        return;
    }

    // Apply client's move_mode to the remote NPC proxy (run/crouch/prone overlay).
    if( msg.find( "\"move_mode\":" ) != std::string::npos ) {
        try {
            JsonValue jv = json_loader::from_string( msg );
            JsonObject jo = jv.get_object();
            jo.allow_omitted_members();
            std::string mm_str;
            jo.read( "move_mode", mm_str );
            if( !mm_str.empty() ) {
                const move_mode_id mode_id( mm_str );
                if( mode_id.is_valid() ) {
                    remote->move_mode = mode_id;
                }
            }
        } catch( const JsonError & ) {}
    }

    // Mirror client's locally-computed stamina onto the proxy so the host sees accurate state.
    if( msg.find( "\"client_stamina\":" ) != std::string::npos ) {
        try {
            JsonValue jv = json_loader::from_string( msg );
            JsonObject jo = jv.get_object();
            jo.allow_omitted_members();
            if( jo.has_int( "client_stamina" ) ) {
                remote->set_stamina( jo.get_int( "client_stamina" ) );
            }
        } catch( const JsonError & ) {}
    }

    // Sync client light level so the host lighting pass can inject it at the proxy NPC.
    if( msg.find( "\"client_light\":" ) != std::string::npos ) {
        try {
            JsonValue jv = json_loader::from_string( msg );
            JsonObject jo = jv.get_object();
            jo.allow_omitted_members();
            if( jo.has_float( "client_light" ) || jo.has_int( "client_light" ) ) {
                g_mp_remote_player_luminance = static_cast<float>( jo.get_float( "client_light" ) );
            }
        } catch( const JsonError & ) {}
    }

    // Sync client bleeding effects to the remote NPC proxy so blood appears on
    // the host's map when the proxy moves.
    if( msg.find( "\"client_bleed\":" ) != std::string::npos ) {
        try {
            JsonValue jv = json_loader::from_string( msg );
            JsonObject jo = jv.get_object();
            jo.allow_omitted_members();
            if( jo.has_array( "client_bleed" ) ) {
                remote->remove_effect( effect_bleed );
                for( const JsonValue &bv : jo.get_array( "client_bleed" ) ) {
                    JsonObject bo = bv.get_object();
                    bo.allow_omitted_members();
                    const std::string bp_str = bo.get_string( "bp", "" );
                    const int intensity = bo.get_int( "intensity", 0 );
                    if( !bp_str.empty() && intensity > 0 ) {
                        const bodypart_id bp = bodypart_str_id( bp_str ).id();
                        remote->add_effect( effect_bleed, 2_turns, bp, intensity );
                    }
                }
            }
        } catch( const JsonError & ) {}
    }

    // Apply field changes (blood, etc.) placed on the client's map tiles.
    if( msg.find( "\"client_tile_changes\":" ) != std::string::npos ) {
        try {
            JsonValue jv = json_loader::from_string( msg );
            JsonObject jo = jv.get_object();
            jo.allow_omitted_members();
            if( jo.has_array( "client_tile_changes" ) ) {
                map &m = get_map();
                for( const JsonValue &entry : jo.get_array( "client_tile_changes" ) ) {
                    JsonObject to = entry.get_object();
                    to.allow_omitted_members();
                    const tripoint_abs_ms abs{
                        to.get_int( "x" ), to.get_int( "y" ), to.get_int( "z" )
                    };
                    if( !m.inbounds( abs ) ) {
                        continue;
                    }
                    const tripoint_bub_ms bub = m.get_bub( abs );
                    bool touched = false;
                    if( to.has_string( "ter" ) ) {
                        const ter_id tid( to.get_string( "ter" ) );
                        if( tid.id().is_valid() ) {
                            m.ter_set( bub, tid );
                            touched = true;
                        }
                    }
                    if( to.has_string( "furn" ) ) {
                        const furn_id fid( to.get_string( "furn" ) );
                        if( fid.id().is_valid() ) {
                            // furn_reset=true suppresses the avatar-grab
                            // "destroyed!" check inside map::furn_set
                            // (map.cpp:2085).  Without this, the host's
                            // legitimate furniture-move (clears old tile,
                            // sets new tile) arrives as two tile_changes;
                            // the OLD-tile clear is interpreted by the
                            // client as a destruction of the avatar's
                            // grabbed furniture and the grab releases with
                            // a spurious "The X you were grabbing is
                            // destroyed!" message.  Real destructions by
                            // monsters etc. now skip the message too, but
                            // that's an acceptable trade vs every grab-
                            // move firing a false alarm.
                            m.furn_set( bub, fid, /* furn_reset */ true );
                            touched = true;
                        }
                    }
                    if( to.has_array( "items" ) ) {
                        mp_log( "[cdda-mp] server apply client items @ " +
                                std::to_string( abs.x() ) + "," +
                                std::to_string( abs.y() ) + "," +
                                std::to_string( abs.z() ) );
                        m.i_clear( bub );
                        for( const JsonValue &iv : to.get_array( "items" ) ) {
                            try {
                                item new_item;
                                JsonObject io = iv.get_object();
                                io.allow_omitted_members();
                                new_item.deserialize( io );
                                if( !new_item.typeId().is_empty() && new_item.typeId().is_valid() ) {
                                    m.add_item( bub, std::move( new_item ) );
                                }
                            } catch( const JsonError & ) {}
                        }
                        touched = true;
                    }
                    if( to.has_array( "fields" ) ) {
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
                                touched = true;
                            }
                        }
                    }
                    if( to.has_string( "trap" ) ) {
                        const std::string trap_str = to.get_string( "trap" );
                        // Skip if the terrain has a built-in trap (e.g. downspout
                        // funnel on t_gutter_downspout); trap_set refuses any trap
                        // on such tiles and debugmsgs.  The peer derives the trap
                        // from the terrain, so no work needed.
                        const trap_id &builtin = m.ter( bub )->trap;
                        if( builtin != tr_null ) {
                            // no-op
                        } else if( trap_str.empty() || trap_str == "tr_null" ) {
                            m.trap_set( bub, tr_null );
                        } else {
                            const trap_str_id tsid( trap_str );
                            if( tsid.is_valid() ) {
                                m.trap_set( bub, tsid.id() );
                            }
                        }
                        touched = true;
                    }
                    if( to.has_string( "graffiti" ) ) {
                        const std::string gtext = to.get_string( "graffiti" );
                        if( gtext.empty() ) {
                            m.delete_graffiti( bub );
                        } else {
                            m.set_graffiti( bub, gtext );
                        }
                        touched = true;
                    }
                    // Partial construction (the client's in-progress build site).
                    if( to.has_object( "partial_con" ) ) {
                        mp_apply_partial_con_obj( bub, to.get_object( "partial_con" ) );
                        touched = true;
                    } else if( to.get_bool( "partial_con_remove", false ) ) {
                        if( m.partial_con_at( bub ) ) {
                            m.partial_con_remove( bub );
                        }
                        touched = true;
                    }
                    // Refresh baseline to the just-applied state so the next
                    // build_tile_changes broadcast doesn't echo this same tile
                    // back to the client.  Erase-and-resend was causing the
                    // partner's ACT_WAIT heartbeat (which re-includes every
                    // visible tile) to ping-pong ~80 KB of items+fields per
                    // turn, blocking the host's input pump.
                    if( touched ) {
                        g_tile_baseline[abs] = compute_tile_state( abs );
                    }
                }
            }
        } catch( const JsonError & ) {}
    }

    // Apply vehicle cargo changes the client made (items placed in trunks,
    // freezers, lockers via SP drop_activity_actor → put_into_vehicle_or_drop).
    // Mirrors client_tile_changes for items stored inside vehicle parts.
    if( msg.find( "\"client_veh_cargo_changes\":" ) != std::string::npos ) {
        try {
            JsonValue jv = json_loader::from_string( msg );
            JsonObject jo = jv.get_object();
            jo.allow_omitted_members();
            if( jo.has_array( "client_veh_cargo_changes" ) ) {
                map &m = get_map();
                for( const JsonValue &entry : jo.get_array( "client_veh_cargo_changes" ) ) {
                    JsonObject co = entry.get_object();
                    co.allow_omitted_members();
                    const tripoint_abs_ms vp_abs{
                        co.get_int( "x" ), co.get_int( "y" ), co.get_int( "z" )
                    };
                    if( !m.inbounds( vp_abs ) ) {
                        continue;
                    }
                    const tripoint_bub_ms vp_bub = m.get_bub( vp_abs );
                    const std::optional<vpart_reference> cargo_vp = m.veh_at( vp_bub ).cargo();
                    if( !cargo_vp ) {
                        mp_log( "[cdda-mp] server veh cargo miss: no cargo part at " +
                                std::to_string( vp_abs.x() ) + "," +
                                std::to_string( vp_abs.y() ) + "," +
                                std::to_string( vp_abs.z() ) );
                        continue;
                    }
                    vehicle &veh = cargo_vp->vehicle();
                    vehicle_part &part = cargo_vp->part();
                    mp_log( "[cdda-mp] server apply veh cargo @ " +
                            std::to_string( vp_abs.x() ) + "," +
                            std::to_string( vp_abs.y() ) + "," +
                            std::to_string( vp_abs.z() ) );
                    {
                        vehicle_stack stack = veh.get_items( part );
                        while( !stack.empty() ) {
                            stack.erase( stack.begin() );
                        }
                    }
                    if( co.has_array( "items" ) ) {
                        for( const JsonValue &iv : co.get_array( "items" ) ) {
                            try {
                                item new_item;
                                JsonObject io = iv.get_object();
                                io.allow_omitted_members();
                                new_item.deserialize( io );
                                if( !new_item.typeId().is_empty() &&
                                    new_item.typeId().is_valid() ) {
                                    veh.add_item( m, part, new_item );
                                }
                            } catch( const JsonError & ) {}
                        }
                    }
                }
            }
        } catch( const JsonError & ) {}
    }

    // Apply client-reported combat damage (gun fire, throw, spell) to server monsters.
    if( msg.find( "\"client_monster_hits\":" ) != std::string::npos ) {
        try {
            JsonValue jv = json_loader::from_string( msg );
            JsonObject jo = jv.get_object();
            jo.allow_omitted_members();
            if( jo.has_array( "client_monster_hits" ) ) {
                map &m = get_map();
                bool any_killed = false;
                for( const JsonValue &hv : jo.get_array( "client_monster_hits" ) ) {
                    JsonObject ho = hv.get_object();
                    ho.allow_omitted_members();
                    const uint32_t nid = static_cast<uint32_t>( ho.get_int( "nid", 0 ) );
                    const int new_hp   = ho.get_int( "hp", -1 );
                    if( nid == 0 || new_hp < 0 ) {
                        continue;
                    }
                    monster *mon = nullptr;
                    for( const auto &ptr : get_creature_tracker().get_monsters_list() ) {
                        if( ptr && ptr->mp_net_id == nid ) {
                            mon = ptr.get();
                            break;
                        }
                    }
                    if( !mon || mon->is_dead() ) {
                        // Diagnostic for the resurrection report: the client
                        // reported a hit/kill for a net id the host can't match,
                        // so the host never applies it and keeps broadcasting the
                        // monster as alive.
                        mp_log( "[cdda-mp] HOST-HIT-MISS: nid=" + std::to_string( nid ) +
                                " hp=" + std::to_string( new_hp ) +
                                ( mon ? " (host monster already dead)"
                                  : " (no host monster with this nid)" ) );
                        continue;
                    }
                    if( new_hp <= 0 ) {
                        mon->die( &m, nullptr );
                        any_killed = true;
                    } else {
                        mon->set_hp( new_hp );
                    }
                    mp_log( "[cdda-mp] client hit: nid=" + std::to_string( nid )
                            + " hp=" + std::to_string( new_hp ) );
                }
                if( any_killed ) {
                    g->cleanup_dead();
                }
            }
        } catch( const JsonError &e ) {
            mp_log( "[cdda-mp] monster_hits parse error: " + std::string( e.what() ) );
        }
    }

    // Partner-menu swap: swap host's avatar with the client's proxy NPC.
    // Triggered when the client picked "Swap positions" from the bump menu.
    if( msg.find( R"("action":"swap_with_partner")" ) != std::string::npos ) {
        avatar &host_av = get_avatar();
        const tripoint_bub_ms host_pre  = host_av.pos_bub();
        const tripoint_bub_ms proxy_pre = remote->pos_bub();
        mp_log( "[cdda-mp] SRV-SWAP-PRE: host=" + host_pre.to_string() +
                " proxy=" + proxy_pre.to_string() );
        mp_log( "[cdda-mp] DIAG swap-handler: remote.get_name()='" + remote->get_name() +
                "' av='" + get_avatar().name + "'" );
        add_msg( _( "%s swaps places with you." ), remote->get_name() );
        g->swap_critters( host_av, *remote );
        mp_log( "[cdda-mp] SRV-SWAP-POST: host=" + host_av.pos_bub().to_string() +
                " proxy=" + remote->pos_bub().to_string() );
        srv_emit_ack( "swap_with_partner" );
        return;
    }

    // Partner-menu push: host's avatar moves one tile away from the client's
    // proxy.  Triggered when the client picked "Push away" from the bump menu.
    // avatar has no move_away_from() (that's npc-only), so compute the step
    // direction manually: sign of (host - proxy) on each axis.
    if( msg.find( R"("action":"push_partner")" ) != std::string::npos ) {
        avatar &host_av = get_avatar();
        const tripoint_bub_ms host_pos  = host_av.pos_bub();
        const tripoint_bub_ms proxy_pos = remote->pos_bub();
        mp_log( "[cdda-mp] SRV-PUSH-PRE: host=" + host_pos.to_string() +
                " proxy=" + proxy_pos.to_string() );
        const int dx = ( host_pos.x() > proxy_pos.x() ) ? 1
                       : ( host_pos.x() < proxy_pos.x() ) ? -1 : 0;
        const int dy = ( host_pos.y() > proxy_pos.y() ) ? 1
                       : ( host_pos.y() < proxy_pos.y() ) ? -1 : 0;
        const tripoint_bub_ms target = host_pos + tripoint_rel_ms( dx, dy, 0 );
        mp_log( "[cdda-mp] DIAG push-handler: remote.get_name()='" + remote->get_name() +
                "' av='" + get_avatar().name + "'" );
        if( ( dx != 0 || dy != 0 ) && !m.impassable( target ) ) {
            host_av.setpos( m, target );
            add_msg( _( "%s pushes you out of the way." ), remote->get_name() );
        } else {
            add_msg( m_warning, _( "%s tries to push you but you have nowhere to go." ),
                     remote->get_name() );
        }
        mp_log( "[cdda-mp] SRV-PUSH-POST: host=" + host_av.pos_bub().to_string() +
                " proxy=" + remote->pos_bub().to_string() );
        srv_emit_ack( "push_partner" );
        return;
    }

    // Partner-menu tap-on-shoulder: client interrupts host's "wait for
    // several minutes" activity. Only cancels ACT_WAIT — other activities
    // (sleep, crafting, reading) are intentionally not interruptible by tap
    // at this stage. If host isn't waiting, the tap is acknowledged but the
    // activity state is left alone.
    if( msg.find( R"("action":"tap_partner")" ) != std::string::npos ) {
        avatar &host_av = get_avatar();
        static const activity_id s_act_wait( "ACT_WAIT" );
        const bool was_waiting = host_av.activity.id() == s_act_wait;
        mp_log( "[cdda-mp] SRV-TAP-PRE: was_waiting=" + std::to_string( was_waiting ) +
                " activity=" + host_av.activity.id().str() );
        if( was_waiting ) {
            host_av.cancel_activity();
            add_msg( _( "%s taps you on the shoulder, snapping you out of your wait." ),
                     remote->get_name() );
        } else {
            add_msg( _( "%s taps you on the shoulder." ), remote->get_name() );
        }
        srv_emit_ack( "tap_partner" );
        return;
    }

    // Wait — drain one turn's worth of AP.
    const bool is_wait = msg.find( R"("action":"wait")" ) != std::string::npos ||
                         msg.find( R"("action": "wait")" ) != std::string::npos;
    if( is_wait ) {
        mp_log( "[cdda-mp] wait recv: ctrl_veh=" + std::to_string( remote->controlling_vehicle ) +
                " g_remote_moves=" + std::to_string( g_remote_moves ) );
        srv_emit_ack( "wait" );
        return;
    }

    // Pickup — drain AP and remove the taken items from the server's authoritative tile.
    if( msg.find( R"("action":"pickup")" ) != std::string::npos ) {
        try {
            JsonValue jv = json_loader::from_string( msg );
            JsonObject jo = jv.get_object();
            jo.allow_omitted_members();
            // Use NPC's server-side position — client coordinates may be out of sync.
            map &here = get_map();
            const tripoint_bub_ms bub_pos = remote->pos_bub();
            if( jo.has_array( "items" ) ) {
                for( const JsonValue &iv : jo.get_array( "items" ) ) {
                    JsonObject io = iv.get_object();
                    io.allow_omitted_members();
                    const itype_id tid( io.get_string( "t", "" ) );
                    if( !tid.is_valid() ) {
                        continue;
                    }
                    map_stack stack = here.i_at( bub_pos );
                    for( auto &it : stack ) {
                        if( it.typeId() == tid ) {
                            here.i_rem( bub_pos, &it );
                            mp_log( "[cdda-mp] pickup: removed " + tid.str()
                                    + " from " + std::to_string( bub_pos.x() ) + ","
                                    + std::to_string( bub_pos.y() ) );
                            break;
                        }
                    }
                }
            }
        } catch( const JsonError &e ) {
            mp_log( "[cdda-mp] pickup parse error: " + std::string( e.what() ) );
        }
        srv_emit_ack( "pickup" );
        return;
    }

    // Drop — client dropped items locally; add them to the server's authoritative tile.
    // Always drop at the remote NPC's current server-side position to avoid coordinate
    // desync between the client's local bubble and the server's bubble.
    if( msg.find( R"("action":"drop")" ) != std::string::npos ) {
        try {
            JsonValue jv = json_loader::from_string( msg );
            JsonObject jo = jv.get_object();
            jo.allow_omitted_members();
            map &here = get_map();
            // Use the absolute coordinates sent by the client; fall back to NPC
            // proxy position only if the client didn't supply them.
            const tripoint_abs_ms remote_abs = remote->pos_abs();
            const tripoint_abs_ms abs_pos{
                jo.get_int( "x", remote_abs.x() ),
                jo.get_int( "y", remote_abs.y() ),
                jo.get_int( "z", remote_abs.z() )
            };
            const tripoint_bub_ms bub_pos = here.inbounds( abs_pos )
                                            ? here.get_bub( abs_pos )
                                            : remote->pos_bub();
            mp_log( "[cdda-mp] drop recv: abs=(" + std::to_string( abs_pos.x() ) + ","
                    + std::to_string( abs_pos.y() ) + "," + std::to_string( abs_pos.z() ) + ")"
                    + " bub=(" + std::to_string( bub_pos.x() ) + "," + std::to_string( bub_pos.y() ) + ")"
                    + " has_items=" + std::string( jo.has_array( "items" ) ? "yes" : "NO" ) );
            if( jo.has_array( "items" ) ) {
                for( const JsonValue &iv : jo.get_array( "items" ) ) {
                    try {
                        item dropped;
                        JsonObject io = iv.get_object();
                        io.allow_omitted_members();
                        dropped.deserialize( io );
                        if( !dropped.typeId().is_empty() && dropped.typeId().is_valid() ) {
                            mp_log( "[cdda-mp] drop: added " + dropped.typeId().str()
                                    + " at " + std::to_string( bub_pos.x() ) + ","
                                    + std::to_string( bub_pos.y() ) );
                            here.add_item( bub_pos, std::move( dropped ) );
                            g_tile_baseline.erase( abs_pos );
                        }
                    } catch( const JsonError &e ) {
                        mp_log( "[cdda-mp] drop: item deserialize error: " + std::string( e.what() ) );
                    }
                }
            }
        } catch( const JsonError &e ) {
            mp_log( "[cdda-mp] drop parse error: " + std::string( e.what() ) );
        }
        srv_emit_ack( "drop" );
        return;
    }

    // Door open/close.
    const bool is_open  = msg.find( R"("action":"open")" ) != std::string::npos;
    const bool is_close = msg.find( R"("action":"close")" ) != std::string::npos;
    if( is_open || is_close ) {
        try {
            JsonValue jv = json_loader::from_string( msg );
            JsonObject jo = jv.get_object();
            jo.allow_omitted_members();
            const tripoint_abs_ms abs_target{
                jo.get_int( "x" ), jo.get_int( "y" ), jo.get_int( "z" )
            };
            if( m.inbounds( abs_target ) ) {
                const tripoint_bub_ms bub = m.get_bub( abs_target );
                if( is_open ) {
                    m.open_door( *remote, bub, true, false );
                } else {
                    // doors::close_door handles vehicle parts (next_part_to_close →
                    // veh->close()) as well as regular terrain/furniture doors.
                    // map::close_door alone skips vehicle doors entirely.
                    doors::close_door( m, *remote, bub );
                }
            }
        } catch( const JsonError &e ) {
            std::cout << "[cdda-mp] door parse error: " << e.what() << std::endl;
        }
        srv_emit_ack( is_open ? "open" : "close" );
        return;
    }

    // Smash — parse absolute target and bash it using the client's smash ability.
    if( msg.find( R"("action":"smash")" ) != std::string::npos ) {
        std::string smash_result_str = "failed";
        tripoint_abs_ms smash_target_abs{ 0, 0, 0 };
        try {
            JsonValue jv = json_loader::from_string( msg );
            JsonObject jo = jv.get_object();
            jo.allow_omitted_members();
            const tripoint_abs_ms abs_target{
                jo.get_int( "x" ), jo.get_int( "y" ), jo.get_int( "z" )
            };
            smash_target_abs = abs_target;
            if( m.inbounds( abs_target ) ) {
                const tripoint_bub_ms bub = m.get_bub( abs_target );
                // Capture target name BEFORE bash (it may be destroyed/replaced).
                std::string target_name;
                if( m.has_furn( bub ) ) {
                    target_name = m.furnname( bub );
                } else {
                    target_name = m.tername( bub );
                }
                auto bash_map = remote->smash_ability();
                if( jo.has_int( "bash" ) ) {
                    const int client_bash = jo.get_int( "bash" );
                    const damage_type_id bash_type( "bash" );
                    bash_map[bash_type] = client_bash;
                }
                // destroy=false so normal bash strength checks apply.
                const bash_params result = m.bash( bub, bash_map, false, false );
                if( result.success ) {
                    smash_result_str = "destroyed";
                } else if( result.did_bash ) {
                    smash_result_str = result.can_bash ? "hit" : "impossible";
                }
                mp_log( "[cdda-mp] smash @ " +
                        std::to_string( abs_target.x() ) + "," +
                        std::to_string( abs_target.y() ) +
                        " result=" + smash_result_str );
                // Generate a message so flush_action_msgs forwards it to the client.
                if( !target_name.empty() ) {
                    if( smash_result_str == "destroyed" ) {
                        add_msg( m_good, _( "%s smashes the %s to pieces!" ),
                                 remote->get_name(), target_name );
                    } else if( smash_result_str == "hit" ) {
                        add_msg( _( "%s strikes the %s." ),
                                 remote->get_name(), target_name );
                    } else if( smash_result_str == "impossible" ) {
                        add_msg( m_info, _( "%s can't damage the %s." ),
                                 remote->get_name(), target_name );
                    }
                }
            }
        } catch( const JsonError &e ) {
            std::cout << "[cdda-mp] smash parse error: " << e.what() << std::endl;
        }
        // Inlined srv_emit_ack: smash needs custom state injection for the
        // bash animation, so the broadcast is custom rather than the helper.
        g_client_acted_this_turn = true;
        g_remote_moves = 0;
        mp_log( "[cdda-mp] SRV-ACK: moves=0 (smash) grant_seq=" +
                std::to_string( g_grant_seq ) );
        flush_action_msgs( pre_action_msg, remote->name );
        server *srv = get_active_server();
        if( srv ) {
            std::string state = serialize_remote_player_state();
            state = state.substr( 0, state.size() - 1 )
                    + R"(,"smash_result":")" + smash_result_str + "\""
                    + ",\"smash_x\":" + std::to_string( smash_target_abs.x() )
                    + ",\"smash_y\":" + std::to_string( smash_target_abs.y() )
                    + ",\"smash_z\":" + std::to_string( smash_target_abs.z() ) + "}";
            srv->post_broadcast( state + "\n" );
        }
        // See NPC-MOVE invalidate for rationale.
        g->invalidate_main_ui_adaptor();
        return;
    }

    // Position sync — client went up/down stairs; teleport proxy NPC to match.
    if( msg.find( R"("action":"position_sync")" ) != std::string::npos ) {
        try {
            JsonValue jv = json_loader::from_string( msg );
            JsonObject jo = jv.get_object();
            jo.allow_omitted_members();
            const tripoint_abs_ms abs_pos{
                jo.get_int( "x" ), jo.get_int( "y" ), jo.get_int( "z" )
            };
            if( m.inbounds( abs_pos ) ) {
                remote->setpos( m, m.get_bub( abs_pos ) );
                std::cout << "[cdda-mp] position_sync: proxy NPC moved to ("
                          << abs_pos.x() << "," << abs_pos.y() << "," << abs_pos.z()
                          << ")" << std::endl;
            }
        } catch( const JsonError &e ) {
            std::cout << "[cdda-mp] position_sync parse error: " << e.what() << std::endl;
        }
        srv_emit_ack( "position_sync" );
        return;
    }

    // Eat / use item — client is authoritative over its own nutrition; server just
    // drains one turn of AP and re-broadcasts state so the client's HUD stays current.
    if( msg.find( R"("action":"eat")" ) != std::string::npos ) {
        srv_emit_ack( "eat" );
        return;
    }

    // Control vehicle — toggle the proxy NPC's vehicle control state.
    // Mirrors game::control_vehicle() for the client's proxy.
    if( msg.find( R"("action":"control_vehicle")" ) != std::string::npos ) {
        mp_log( "[cdda-mp] control_vehicle: HANDLER ENTERED controlling=" +
                std::to_string( remote->controlling_vehicle ) );
        map &here = get_map();
        const tripoint_bub_ms bub = remote->pos_bub();
        mp_log( "[cdda-mp] control_vehicle: proxy bub=(" + std::to_string( bub.x() ) + "," +
                std::to_string( bub.y() ) + "," + std::to_string( bub.z() ) + ")" );
        const optional_vpart_position vp_check = here.veh_at( bub );
        mp_log( "[cdda-mp] control_vehicle: veh_at=" + std::to_string( static_cast<bool>( vp_check ) ) );
        if( remote->controlling_vehicle ) {
            // Already controlling — give up control and unboard.  Use the
            // two-arg unboard form with the proxy passed explicitly; the
            // single-arg form does vp->get_passenger() which returns null
            // when the proxy was set in_vehicle by per-turn position sync
            // rather than a real board_vehicle call (passenger_flag never
            // got set), and that fires "passenger not found" debugmsg.
            remote->controlling_vehicle = false;
            if( const optional_vpart_position vp_at = here.veh_at( bub ) ) {
                const std::optional<vpart_reference> board_vp =
                    vp_at->part_with_feature( VPFLAG_BOARDABLE, false );
                if( board_vp ) {
                    here.unboard_vehicle( *board_vp, remote, false );
                }
            }
            remote->in_vehicle = false;
            mp_log( "[cdda-mp] control_vehicle: proxy released controls" );
            // Host log: NPC-form. Client: direct push (correct grammar, first-person).
            add_msg( _( "%s lets go of the controls." ), remote->name );
            g_action_msgs_pending.emplace_back( _( "You let go of the controls." ) );
        } else if( const optional_vpart_position vp = here.veh_at( bub ) ) {
            vehicle &veh = vp->vehicle();
            const int ctrl_idx = veh.avail_part_with_feature( vp->mount_pos(), "CONTROLS" );
            mp_log( "[cdda-mp] control_vehicle: ctrl_idx=" + std::to_string( ctrl_idx ) +
                    " engine_on=" + std::to_string( veh.engine_on ) );
            if( ctrl_idx >= 0 ) {
                // board_vehicle early-returns if proxy is already seated at this part,
                // so this is safe to call unconditionally.  Without it, a proxy whose
                // in_vehicle was set by the per-turn position sync (rather than by a
                // prior board_vehicle) would never get passenger_flag on the seat.
                here.board_vehicle( bub, remote );
                remote->in_vehicle = true;
                const bool engine_was_off = !veh.engine_on;
                int started = 0;
                if( engine_was_off ) {
                    // start_engines() with an NPC driver assigns a cranking activity whose
                    // finish() uses get_player_character() to re-find the vehicle — it
                    // never finds it for an NPC proxy and the engine stays off.
                    // Bypass the activity: directly enable and start each engine, mirroring
                    // what start_engines_activity_actor::finish() does internally.
                    for( const int p : veh.engines ) {
                        vehicle_part &vpart = veh.part( p );
                        if( !vpart.is_broken() ) {
                            vpart.enabled = true;
                        }
                    }
                    for( const int p : veh.engines ) {
                        vehicle_part &vpart = veh.part( p );
                        if( veh.is_engine_on( vpart ) && veh.start_engine( here, vpart ) ) {
                            started++;
                        }
                    }
                    veh.engine_on = started > 0;
                    mp_log( "[cdda-mp] control_vehicle: direct engine start, started=" +
                            std::to_string( started ) + " engine_on=" + std::to_string( veh.engine_on ) );
                }
                if( veh.engine_on ) {
                    remote->controlling_vehicle = true;
                    mp_log( "[cdda-mp] control_vehicle: proxy took/started+took control of " + veh.name );
                    // Host log: NPC-form. Client: direct push (correct grammar, first-person).
                    add_msg( _( "%s takes control of the %s." ), remote->name, veh.name );
                    g_action_msgs_pending.push_back(
                        string_format( _( "You take control of the %s." ), veh.name ) );
                    if( engine_was_off ) {
                        add_msg( n_gettext( "The %s's engine starts up.",
                                            "The %s's engines start up.", started ), veh.name );
                        g_action_msgs_pending.push_back(
                            string_format( n_gettext( "The %s's engine starts up.",
                                                      "The %s's engines start up.", started ), veh.name ) );
                    }
                } else {
                    mp_log( "[cdda-mp] control_vehicle: engine failed to start" );
                    add_msg( m_bad, _( "%s can't start the %s's engine." ), remote->name, veh.name );
                    g_action_msgs_pending.push_back(
                        string_format( _( "You can't start the %s's engine." ), veh.name ) );
                }
            } else {
                mp_log( "[cdda-mp] control_vehicle: no controls at proxy position" );
                add_msg( m_info, _( "%s can't drive from here — no controls." ), remote->name );
                g_action_msgs_pending.emplace_back( _( "You can't drive from here — no controls." ) );
            }
        } else {
            mp_log( "[cdda-mp] control_vehicle: no vehicle at proxy position" );
            add_msg( m_info, _( "No vehicle here for %s to control." ), remote->name );
            g_action_msgs_pending.emplace_back( _( "No vehicle here to control." ) );
        }
        // Don't use flush_action_msgs here — messages are pushed directly above
        // to avoid grammar issues from NPC-name→"You" substitution ("takes"→"take").
        g_last_forwarded_msg_count = Messages::size();
        srv_emit_ack( "control_vehicle" );
        return;
    }

    // Pldrive — client is at vehicle controls, translate directional input to
    // vehicle::pldrive() exactly as handle_action.cpp does in single-player.
    if( msg.find( R"("action":"pldrive")" ) != std::string::npos ) {
        int dx = 0;
        int dy = 0;
        try {
            JsonValue jv = json_loader::from_string( msg );
            JsonObject jo = jv.get_object();
            jo.allow_omitted_members();
            dx = jo.get_int( "dx", 0 );
            dy = jo.get_int( "dy", 0 );
        } catch( const JsonError &e ) {
            mp_log( "[cdda-mp] pldrive parse error: " + std::string( e.what() ) );
        }
        map &here = get_map();
        const tripoint_bub_ms bub = remote->pos_bub();
        if( const optional_vpart_position vp = here.veh_at( bub ) ) {
            vehicle &veh = vp->vehicle();
            const int face_before = static_cast<int>( units::to_degrees( veh.face.dir() ) );
            const int str = remote->get_str();
            const int dex = remote->get_dex();
            const int drv = remote->get_skill_level( skill_id( "driving" ) );
            mp_log( "[cdda-mp] pldrive: dx=" + std::to_string( dx ) +
                    " dy=" + std::to_string( dy ) +
                    " face=" + std::to_string( face_before ) +
                    " str=" + std::to_string( str ) +
                    " dex=" + std::to_string( dex ) +
                    " drv=" + std::to_string( drv ) +
                    " moves=" + std::to_string( g_remote_moves ) );
            // pldrive() internally caps moves to get_speed() then deducts the turn cost.
            // Preserve any budget above one speed unit, then use pldrive's remainder.
            const int excess = std::max( 0, g_remote_moves - remote->get_speed() );
            veh.pldrive( here, *remote, dx, dy, 0 );
            mp_log( "[cdda-mp] pldrive result: face=" +
                    std::to_string( static_cast<int>( units::to_degrees( veh.face.dir() ) ) ) +
                    " moves_after=" + std::to_string( remote->get_moves() ) );
            g_remote_moves = excess + remote->get_moves();
        } else {
            // No longer at a vehicle — clear control flag so the client gets corrected.
            remote->controlling_vehicle = false;
            g_remote_moves = 0;
        }
        // Mirror SP's pldrive: turning costs AP but doesn't end the turn unless
        // AP runs out.  If the proxy still has moves, send a partial-turn update
        // (free=true) so the client can do more driving inputs (more turns, cruise
        // changes, pause to commit) in the same turn — matching SP behavior where
        // the driver can chain inputs until moves reach 0.
        const bool turn_ended = g_remote_moves <= 0;
        if( turn_ended ) {
            g_client_acted_this_turn = true;
            g_remote_moves = 0;
            mp_log( "[cdda-mp] SRV-ACK: moves=0 (pldrive) grant_seq=" +
                    std::to_string( g_grant_seq ) );
        }
        flush_action_msgs( pre_action_msg, remote->name );
        server *srv = get_active_server();
        if( srv ) {
            std::string state = serialize_remote_player_state();
            if( !turn_ended ) {
                state = state.substr( 0, state.size() - 1 ) + ",\"free\":true}";
            }
            srv->post_broadcast( state + "\n" );
        }
        // See NPC-MOVE invalidate for rationale.
        g->invalidate_main_ui_adaptor();
        return;
    }

    // Cruise speed adjustment — free action (mirrors SP: cruise_thrust costs no AP).
    if( msg.find( R"("action":"cruise")" ) != std::string::npos ) {
        int dy = 0;
        try {
            JsonValue jv = json_loader::from_string( msg );
            JsonObject jo = jv.get_object();
            jo.allow_omitted_members();
            dy = jo.get_int( "dy", 0 );
        } catch( const JsonError &e ) {
            mp_log( "[cdda-mp] cruise parse error: " + std::string( e.what() ) );
        }
        map &here = get_map();
        if( const optional_vpart_position vp = here.veh_at( remote->pos_bub() ) ) {
            vehicle &veh = vp->vehicle();
            veh.cruise_thrust( here, -dy * 400 );
            mp_log( "[cdda-mp] cruise: dy=" + std::to_string( dy )
                    + " cruise_vel=" + std::to_string( veh.cruise_velocity ) );
        }
        // Free action: do NOT deduct g_remote_moves.  Broadcast updated state.
        server *srv = get_active_server();
        if( srv ) {
            srv->post_broadcast( serialize_remote_player_state() + "\n" );
        }
        // See NPC-MOVE invalidate for rationale.
        g->invalidate_main_ui_adaptor();
        return;
    }

    // Handbrake — client pressed smash key while in vehicle control mode.
    if( msg.find( R"("action":"handbrake")" ) != std::string::npos ) {
        map &here = get_map();
        const tripoint_bub_ms bub = remote->pos_bub();
        if( const optional_vpart_position vp = here.veh_at( bub ) ) {
            vehicle &veh = vp->vehicle();
            mp_log( "[cdda-mp] handbrake: veh=" + veh.name
                    + " vel=" + std::to_string( veh.velocity ) );
            add_msg( _( "%s pulls a handbrake." ), remote->name );
            g_action_msgs_pending.emplace_back( _( "You pull a handbrake." ) );
            veh.cruise_velocity = 0;
            if( veh.last_turn != 0_degrees &&
                rng( 15, 60 ) * 100 < std::abs( veh.velocity ) ) {
                veh.skidding = true;
                add_msg( m_warning, _( "%s loses control of %s." ), remote->name, veh.name );
                g_action_msgs_pending.push_back( string_format( _( "You lose control of %s." ),
                                                 veh.name ) );
                veh.turn( veh.last_turn > 0_degrees ? 60_degrees : -60_degrees );
            } else {
                int braking_power = std::abs( veh.velocity ) / 2 + 10 * 100;
                if( std::abs( veh.velocity ) < braking_power ) {
                    veh.stop( here );
                } else {
                    int sgn = veh.velocity > 0 ? 1 : -1;
                    veh.velocity = sgn * ( std::abs( veh.velocity ) - braking_power );
                }
            }
        }
        g_last_forwarded_msg_count = Messages::size();
        srv_emit_ack( "cruise" );
        return;
    }

    // Stop engine — client selected "Stop engine" from driving menu.
    if( msg.find( R"("action":"stop_engine")" ) != std::string::npos ) {
        map &here = get_map();
        const tripoint_bub_ms bub = remote->pos_bub();
        if( const optional_vpart_position vp = here.veh_at( bub ) ) {
            vehicle &veh = vp->vehicle();
            veh.engine_on = false;
            for( const int p : veh.engines ) {
                veh.part( p ).enabled = false;
            }
            veh.cruise_velocity = 0;
            mp_log( "[cdda-mp] stop_engine: engines stopped for " + veh.name );
            // Host log: NPC-form. Client: direct push (correct grammar, first-person).
            add_msg( _( "%s turns off the engine and lets go of the controls." ), remote->name );
            g_action_msgs_pending.push_back(
                string_format( _( "You turn the engine off and let go of the controls." ) ) );
        }
        remote->controlling_vehicle = false;
        here.unboard_vehicle( bub );
        remote->in_vehicle = false;
        g_last_forwarded_msg_count = Messages::size();
        srv_emit_ack( "stop_engine" );
        return;
    }

    // Toggle engine while not driving (at controls but not in control mode).
    if( msg.find( R"("action":"toggle_engine")" ) != std::string::npos ) {
        map &here = get_map();
        const tripoint_bub_ms bub = remote->pos_bub();
        if( const optional_vpart_position vp = here.veh_at( bub ) ) {
            vehicle &veh = vp->vehicle();
            if( veh.engine_on ) {
                veh.stop_engines( here );
                add_msg( _( "%s turns off the engine." ), remote->name );
                g_action_msgs_pending.emplace_back( _( "You turn the engine off." ) );
            } else {
                veh.start_engines( here, remote );
                add_msg( _( "%s starts the engine." ), remote->name );
                g_action_msgs_pending.emplace_back( _( "You start the engine." ) );
            }
        }
        g_last_forwarded_msg_count = Messages::size();
        srv_emit_ack( "toggle_engine" );
        return;
    }

    // Honk horn.
    // Client → host vehicle construction sync.  Client runs the activity
    // locally (timer, moves, items, messages, local vehicle mutation) and on
    // finish dispatches this action with the actor's serialized state.  Host
    // reconstructs the actor and runs complete_vehicle against the proxy NPC's
    // crafting inventory and the host's authoritative vehicle.  Piece A's
    // parts-count-change detection then triggers a snapshot rebroadcast so
    // the client's local vehicle is replaced with the post-construction
    // snapshot — covers install, remove (including appliance), repair,
    // refill, change-shape paths in vehicle_activity_actor.
    if( msg.find( R"("action":"vehicle_construct")" ) != std::string::npos ) {
        try {
            JsonValue actor_jv = jo.get_member( "actor" );
            std::unique_ptr<activity_actor> actor =
                vehicle_activity_actor::deserialize( actor_jv );
            if( !actor ) {
                mp_log( "[cdda-mp] vehicle_construct: actor deserialize returned null" );
            } else {
                player_activity tmp_act( *actor );
                // complete_vehicle mutates the actor's internal state (vp_index
                // adjustments etc.) so call it on the deserialized instance
                // rather than the temp player_activity's clone.
                static_cast<vehicle_activity_actor *>( actor.get() )
                ->complete_vehicle( tmp_act, *remote );
                mp_log( "[cdda-mp] HOST-VEH-CONSTRUCT applied for proxy NPC" );
            }
        } catch( const JsonError &e ) {
            mp_log( "[cdda-mp] vehicle_construct parse error: " + std::string( e.what() ) );
        }
        flush_action_msgs( pre_action_msg, remote->name );
        srv_emit_ack( "vehicle_construct" );
        return;
    }

    if( msg.find( R"("action":"honk")" ) != std::string::npos ) {
        map &here = get_map();
        const tripoint_bub_ms bub = remote->pos_bub();
        if( const optional_vpart_position vp = here.veh_at( bub ) ) {
            vehicle &veh = vp->vehicle();
            veh.honk_horn( here );
        }
        flush_action_msgs( pre_action_msg, remote->name );
        srv_emit_ack( "honk" );
        return;
    }

    // Client → host grab state sync.  Client runs its own SP grab() locally to
    // do the UI prompts, target validation, and add_msg calls; the resulting
    // grab_type + grab_point delta is forwarded here so the host's proxy NPC
    // mirrors it.  The host's move handler (below) consults this state and
    // invokes the parameterized grabbed_move() to actually drag furniture or
    // vehicles when the proxy moves.
    //
    //   { "type":"action", "action":"grab", "grab_type":<int>,
    //     "dx":<int>, "dy":<int>, "dz":<int> }
    if( msg.find( R"("action":"grab")" ) != std::string::npos ) {
        try {
            const int gt = jo.get_int( "grab_type", 0 );
            const int dx = jo.get_int( "dx", 0 );
            const int dy = jo.get_int( "dy", 0 );
            const int dz = jo.get_int( "dz", 0 );
            // MP-FIXME: npc::grab not available in CCB, grab sync stubbed
            // remote->grab( static_cast<object_type>( gt ), tripoint_rel_ms( dx, dy, dz ) );
            mp_log( "[cdda-mp] HOST-GRAB: proxy '" + remote->name + "' grab_type=" +
                    std::to_string( gt ) + " offset=(" + std::to_string( dx ) + "," +
                    std::to_string( dy ) + "," + std::to_string( dz ) + ")" );
        } catch( const JsonError &e ) {
            mp_log( "[cdda-mp] grab parse error: " + std::string( e.what() ) );
        }
        srv_emit_ack( "grab" );
        return;
    }

    // Client → host hauling toggle.  Character::toggle_hauling is already a
    // base-class method, so it works directly on the NPC proxy.  Items are
    // tracked on the host side via the NPC's haul_list; the client's local
    // is_hauling state is what affects the client's move dispatch UI.  Sync
    // both sides via remote_player_state.
    if( msg.find( R"("action":"toggle_haul")" ) != std::string::npos ) {
        remote->toggle_hauling();
        // Diagnostic: confirm whether toggle on the proxy populated haul_list
        // from the proxy's current tile (Character::toggle_hauling does this
        // for the "starting" half of the toggle).  If haul_list is empty
        // post-toggle even when is_hauling()=true, the on-move start_hauling
        // hook will bail at target_items.empty() and stop the activity.
        mp_log( "[cdda-mp] HOST-HAUL: proxy '" + remote->name + "' hauling=" +
                std::to_string( remote->is_hauling() ) +
                " haul_list_size=" + std::to_string( remote->haul_list.size() ) +
                " autohaul=" + std::to_string( remote->is_autohauling() ) +
                " pos=(" + std::to_string( remote->pos_bub().x() ) + "," +
                std::to_string( remote->pos_bub().y() ) + ")" );
        flush_action_msgs( pre_action_msg, remote->name );
        srv_emit_ack( "toggle_haul" );
        return;
    }

    tripoint_bub_ms cur = remote->pos_bub();
    tripoint_bub_ms next = cur;

    // Sync NPC proxy move_mode to what the client committed before dispatching.
    // If stamina later runs out during the move, the auto-walk transition below
    // will override this and the state packet will correct the client.
    {
        const size_t mm = msg.find( R"("move_mode":")" );
        if( mm != std::string::npos ) {
            const size_t start = mm + 13;
            const size_t end = msg.find( '"', start );
            if( end != std::string::npos ) {
                try {
                    remote->move_mode = move_mode_id( msg.substr( start, end - start ) );
                } catch( ... ) {}
            }
        }
    }

    // Parse direction — handle both "dir":"n" and "dir": "n" spacing
    const auto dir_match = [&msg]( const std::string & d ) {
        return msg.find( R"("dir":")" + d + "\"" ) != std::string::npos ||
               msg.find( R"("dir": ")" + d + "\"" ) != std::string::npos;
    };
    tripoint offset;
    if( dir_match( "n" ) ) {
        offset = tripoint( 0, -1, 0 );
    } else if( dir_match( "s" ) ) {
        offset = tripoint( 0, 1, 0 );
    } else if( dir_match( "e" ) ) {
        offset = tripoint( 1, 0, 0 );
    } else if( dir_match( "w" ) ) {
        offset = tripoint( -1, 0, 0 );
    } else if( dir_match( "ne" ) ) {
        offset = tripoint( 1, -1, 0 );
    } else if( dir_match( "nw" ) ) {
        offset = tripoint( -1, -1, 0 );
    } else if( dir_match( "se" ) ) {
        offset = tripoint( 1, 1, 0 );
    } else if( dir_match( "sw" ) ) {
        offset = tripoint( -1, 1, 0 );
    }
    next += offset;

    // Apply ramp z-adjustment, mirroring avatar_action::move (avatar_action.cpp:237-241).
    // Client sends explicit dz when it detects a ramp at the destination; also
    // apply from terrain flags directly so the server is always authoritative.
    {
        const int client_dz = jo.get_int( "dz", 0 );
        const bool had_ramp_up   = m.has_flag( ter_furn_flag::TFLAG_RAMP_UP,   next );
        const bool had_ramp_down = m.has_flag( ter_furn_flag::TFLAG_RAMP_DOWN, next );
        if( client_dz != 0 ) {
            next = tripoint_bub_ms{ next.x(), next.y(), next.z() + client_dz };
        } else if( had_ramp_up ) {
            next = tripoint_bub_ms{ next.x(), next.y(), next.z() + 1 };
        } else if( had_ramp_down ) {
            next = tripoint_bub_ms{ next.x(), next.y(), next.z() - 1 };
        }
        if( client_dz != 0 || had_ramp_up || had_ramp_down ) {
            mp_log( "[cdda-mp] RAMP-ADJ: dz=" + std::to_string( client_dz ) +
                    " ramp_up=" + std::to_string( had_ramp_up ) +
                    " ramp_dn=" + std::to_string( had_ramp_down ) +
                    " next=(" + std::to_string( next.x() ) + "," +
                    std::to_string( next.y() ) + "," + std::to_string( next.z() ) + ")" +
                    " ter=" + m.ter( next ).id().str() +
                    " passable=" + std::to_string( !m.impassable( next ) ) );
        }
    }

    // Track whether this action consumed a turn.  Wall bumps and other no-ops
    // must not lock the client — they get a "free":true response instead.
    bool acted = false;

    // Move or attack, matching single-player bump-to-attack behaviour.
    // Check for a creature first — melee_attack applies regardless of tile passability.
    if( next != cur ) {
        const tripoint_abs_ms next_abs = m.get_abs( next );
        // Block movement onto the host avatar's tile.
        const tripoint_abs_ms host_abs = m.get_abs( get_avatar().pos_bub() );
        if( next_abs == host_abs ) {
            // The client's local bump check (handle_action.cpp) is the intended
            // UX path — it opens the partner menu locally before the move ever
            // dispatches.  If that check missed (position-sync drift, etc.) we
            // land here.  Treat the bump as a consumed turn so the host's
            // wait_for_client_action releases cleanly.
            srv_emit_ack( "bump_host_fallthrough" );
            return;
        }
        const shared_ptr_fast<monster> target = get_creature_tracker().find( next_abs );
        // Run the host-side drag FIRST (before the creature / impassable
        // checks below). Mirrors SP walk_move(): grabbed_move() runs before
        // the actual step so a successful push shifts the furniture forward
        // out of the way, then the player follows onto the now-passable tile.
        // Without this ordering, pushing straight into the grabbed tile
        // would hit the impassable check (furniture is still there) and fall
        // into bump-to-open without ever invoking the drag.
        //
        // For a pull or shift, the drag moves the furniture to a different
        // tile than `next`; the subsequent impassable check sees a normal
        // empty tile and the step proceeds.
        //
        // grabbed_*_move returns TRUE when the drag itself consumed the turn
        // and the player should NOT step (collision / shift / too heavy);
        // FALSE on a successful pull/push where the player should step.
        // MP-FIXME: grab sync stubbed for CCB compatibility
        // (npc::get_grab_type, game::grabbed_veh_move_helper, game::grabbed_furn_move not available)
        bool drag_handled_turn = false;
#if 0
        if( false /* remote->get_grab_type() != object_type::NONE && !target */ ) {
            const tripoint_rel_ms drag_dp( offset.x, offset.y, offset.z );
            const tripoint_bub_ms proxy_pos = remote->pos_bub();
            const tripoint_bub_ms fpos = proxy_pos + remote->grab_point;
            const bool has_furn = m.has_furn( fpos );
            mp_log( "[cdda-mp] HOST-DRAG-PRE: proxy '" + remote->name +
                    "' pos=(" + std::to_string( proxy_pos.x() ) + "," +
                    std::to_string( proxy_pos.y() ) + "," +
                    std::to_string( proxy_pos.z() ) + ")" +
                    " grab_type=" + std::to_string(
                        static_cast<int>( remote->get_grab_type() ) ) +
                    " grab_point=(" + std::to_string( remote->grab_point.x() ) + "," +
                    std::to_string( remote->grab_point.y() ) + ")" +
                    " fpos=(" + std::to_string( fpos.x() ) + "," +
                    std::to_string( fpos.y() ) + ")" +
                    " has_furn=" + std::to_string( has_furn ) +
                    " arm_str=" + std::to_string( remote->get_arm_str() ) +
                    " dp=(" + std::to_string( drag_dp.x() ) + "," +
                    std::to_string( drag_dp.y() ) + ")" +
                    " next_impassable_pre=" +
                    std::to_string( m.impassable( next ) ) );
            if( remote->get_grab_type() == object_type::VEHICLE ) {
                drag_handled_turn =
                    g->grabbed_veh_move_helper( *remote, drag_dp, false );
            } else if( remote->get_grab_type() == object_type::FURNITURE ) {
                drag_handled_turn = g->grabbed_furn_move( *remote, drag_dp );
            } else if( remote->get_grab_type() == object_type::FURNITURE_ON_VEHICLE ) {
                drag_handled_turn = g->grabbed_furn_move( *remote, drag_dp );
            }
            mp_log( "[cdda-mp] HOST-DRAG-POST: proxy '" + remote->name +
                    "' grab_type=" + std::to_string(
                        static_cast<int>( remote->get_grab_type() ) ) +
                    " grab_point=(" + std::to_string( remote->grab_point.x() ) + "," +
                    std::to_string( remote->grab_point.y() ) + ")" +
                    " handled_turn=" + std::to_string( drag_handled_turn ) +
                    " next_impassable_post=" +
                    std::to_string( m.impassable( next ) ) );
        }
#endif
        if( target ) {
            // melee_attack() charges moves on the NPC internally; capture the result.
            remote->melee_attack( *target, true );
            g_remote_moves = remote->get_moves();
            acted = true;
        } else if( drag_handled_turn ) {
            // Drag fully consumed the turn (collision / stuff in way /
            // shift / too heavy).  Don't step the proxy; pay roughly the
            // step's AP cost so the lockstep ack still advances cleanly.
            // Skips the setpos / board / trap / hauling hook entirely —
            // those only fire on an actual step.
            const int mcost = m.combined_movecost( cur, next );
            const bool diag = ( std::abs( offset.x ) + std::abs( offset.y ) ) == 2;
            const int prev_moves = g_remote_moves;
            g_remote_moves -= remote->run_cost( mcost, diag );
            remote->burn_move_stamina( prev_moves - g_remote_moves );
            acted = true;
            mp_log( "[cdda-mp] HOST-DRAG-NO-STEP: proxy held in place, "
                    "AP charged " + std::to_string( prev_moves - g_remote_moves ) );
        } else if( !m.impassable( next ) ) {
            // Mirror avatar_action::move boarding semantics: unboard from current
            // vehicle tile before setpos, then board at the new tile if boardable.
            // Without this, board_vehicle is never called on the way in and the
            // controls seat's passenger_flag stays clear, which makes the host
            // flag the vehicle as unmanned and trigger spontaneous skids.
            // Guard the unboard call: in_vehicle can be stale (set true by the
            // per-turn sync or carried across a save/load) while the proxy
            // isn't actually standing on a vehicle.  Calling unboard_vehicle
            // at a non-vehicle tile fires a debugmsg.
            if( remote->in_vehicle ) {
                if( m.veh_at( remote->pos_bub() ).part_with_feature( "BOARDABLE", true ) ) {
                    m.unboard_vehicle( remote->pos_bub() );
                } else {
                    remote->in_vehicle = false;
                    remote->controlling_vehicle = false;
                }
            }
            remote->setpos( m, next );
            if( m.veh_at( remote->pos_bub() ).part_with_feature( "BOARDABLE", true ) ) {
                m.board_vehicle( remote->pos_bub(), remote );
            }
            mp_log( "[cdda-mp] NPC-MOVE: setpos done, pos_abs=" + std::to_string( remote->pos_abs().x() ) +
                    "," + std::to_string( remote->pos_abs().y() ) +
                    "," + std::to_string( remote->pos_abs().z() ) +
                    " bub=" + std::to_string( remote->pos_bub().x() ) + "," + std::to_string( remote->pos_bub().y() ) +
                    "," + std::to_string( remote->pos_bub().z() ) +
                    " in_vehicle=" + std::to_string( remote->in_vehicle ) );
            // Hauling hook — mirrors SP walk_move()'s post-step check that
            // assigns a move_items_activity_actor when the player is hauling.
            // Without this the haul flag syncs but no items are ever picked
            // up.  start_hauling reads the OLD tile (cur) for items.
            //
            // Skip when an ACT_MOVE_ITEMS is already in progress — calling
            // start_hauling re-scans the proxy's CURRENT tile (which is the
            // tile they just stepped FROM, often empty/different from where
            // they originally toggled), populates an empty target_items,
            // overwrites the running activity and the remaining items at
            // the original tile never get picked up.  Letting the existing
            // activity drain naturally via PROXY-ACT-TICK is how SP would
            // do it (the SP avatar's activity persists across moves;
            // item_locations stay valid as the player walks away).
            static const activity_id s_act_move_items( "ACT_MOVE_ITEMS" );
            const bool haul_act_running = remote->activity &&
                                          remote->activity.id() == s_act_move_items;
            if( remote->is_hauling() && !haul_act_running ) {
                /* MP-FIXME: g->start_hauling stubbed for CCB */
                // g->start_hauling( *remote, cur );
                mp_log( "[cdda-mp] HOST-HAUL-START: proxy '" + remote->name +
                        "' from pos=(" + std::to_string( cur.x() ) + "," +
                        std::to_string( cur.y() ) + ")" );
            } else if( remote->is_hauling() && haul_act_running ) {
                mp_log( "[cdda-mp] HOST-HAUL-CONTINUE: proxy '" + remote->name +
                        "' activity already running, not re-assigning" );
            }
            // Trigger traps on the destination tile, mirroring game.cpp:8351.
            m.creature_on_trap( *remote );
            // Use combined_movecost (same as game.cpp:7733) so the AP cost includes
            // all terrain/encumbrance factors, not just the raw tile cost.
            const bool diag = ( std::abs( offset.x ) + std::abs( offset.y ) ) == 2;
            const int mcost = m.combined_movecost( cur, next );
            const int prev_moves = g_remote_moves;
            const int ap_cost = remote->run_cost( mcost, diag );
            g_remote_moves -= ap_cost;
            // burn_move_stamina with the actual AP consumed, mirroring game.cpp:7776.
            remote->burn_move_stamina( prev_moves - g_remote_moves );
            // Auto-transition to walk when stamina runs out (mirrors game.cpp:8970).
            static const move_mode_id walk_id( "walk" );
            if( !remote->can_run() ) {
                remote->move_mode = walk_id;
            }
            acted = true;
        } else {
            // Bump-to-open: try to open a door on the target tile (follows CDDA rules —
            // respects locks, handles etc).  If it's not openable, it's a wall bump.
            // No explicit AP charge here — the canonical SRV-ACK below zeros the
            // move budget when acted=true.
            if( m.open_door( *remote, next, true, false ) ) {
                acted = true;
            }
            // else: solid wall — acted stays false, no AP charged
        }
    }

    // Capture all messages generated during this action (hits, misses, damage,
    // kills) for forwarding to the client regardless of NPC name filter.
    flush_action_msgs( pre_action_msg, remote->name );

    if( acted ) {
        g_client_acted_this_turn = true;
        // FIX #2/#3: carry an expensive move's AP debt instead of wiping it.
        // g_remote_moves here is (granted budget - real ap_cost).  If the move
        // overspent (cost > budget) it's negative — KEEP that debt so
        // grant_client_turn()'s "+= speed" makes the client skip turns until it's
        // paid off (the SP move economy).  Cap surplus at 0 so a cheap move can't
        // bank budget across turns (preserves one-action-per-grant).
        g_remote_moves = std::min( 0, g_remote_moves );
        mp_log( "[cdda-mp] SRV-ACK: moves=" + std::to_string( g_remote_moves ) +
                " (debt-carry) ack to client, grant_seq=" + std::to_string( g_grant_seq ) );
    } else {
        mp_log( "[cdda-mp] SRV-FREE: no-op move (wall/bump), sending free=true, moves=" + std::to_string(
                    g_remote_moves ) );
    }

    // Broadcast updated state.  Wall bumps and other no-ops include "free":true
    // so the client knows to restore its moves without waiting for the next turn grant.
    server *srv = get_active_server();
    if( srv ) {
        // Ramp crossing: proxy moved to a new z-level.  Flush the target z's
        // submap data to the client BEFORE the position update so the client's
        // MAPBUFFER has correct bridge/ramp tiles by the time
        // client_teleport_avatar fires update_map and gravity_check runs.
        // Evict first so we always re-send even if these submaps were already
        // in g_map_sync_sent from a previous crossing.
        if( next.z() != cur.z() ) {
            for( auto it = g_map_sync_sent.begin(); it != g_map_sync_sent.end(); ) {
                it = ( it->z() == next.z() ) ? g_map_sync_sent.erase( it ) : std::next( it );
            }
            const std::string zmap = build_map_sync_z( next.z() );
            if( !zmap.empty() ) {
                srv->post_broadcast( zmap + "\n" );
                mp_log( "[cdda-mp] RAMP-ZMAP: pre-teleport z=" + std::to_string( next.z() ) +
                        " bytes=" + std::to_string( zmap.size() ) );
            }
        }
        std::string state = serialize_remote_player_state();
        if( !acted ) {
            state = state.substr( 0, state.size() - 1 ) + ",\"free\":true}";
        }
        srv->post_broadcast( state + "\n" );
    }

    // Mirror srv_emit_ack's UI invalidation — the move handler inlines its own
    // broadcast (above) so it doesn't go through srv_emit_ack, but the
    // authoritative position just changed and the host may be sitting in a
    // blocking wait_for_client_action poll with no normal turn boundary to
    // trigger a redraw.  Without this, the proxy NPC's new tile only appears
    // after an unrelated event (alt-tab, host keypress, monmove) forces the
    // window to repaint.
    g->invalidate_main_ui_adaptor();
}

// ---------------------------------------------------------------------------
// Overmap streaming (host -> client)
// ---------------------------------------------------------------------------
//
// Worldgen is NOT deterministic from g->seed alone across machines: biome
// noise uses g->seed (synced), but cities/roads/specials are placed from the
// clock-seeded global RNG, so a client that regenerates its overmap gets
// different towns (verified 2026-06-03). Fix per Arch Rule 1: the host streams
// its actual omt grid (every oter_id IS the terrain *and* the city/road/
// building) and the client applies it, overriding its own regen.
//
// Perf design: a radius around the host, z=0 for now, palette + row-major RLE
// (oter_ids are ~95% repetitive so this compresses hard), only (re)sent on the
// first sync or when the host's omt center moves a step — never per-turn full
// resend. Crucially we read with get_existing_om_global (NO generation): we
// stream only what the host has already generated, so a wide radius is free
// (no host freeze, no growing the host's world) and naturally covers the
// host's known region. Ungenerated OMTs are sent as an empty-string sentinel
// the client skips (keeping its own terrain there).
static int g_om_sync_radius = 90;   // OMTs around the host (covers the m-screen)
static tripoint_abs_omt g_om_sync_last_center{ INT_MIN, INT_MIN, 0 };
static int g_om_sync_last_client_z = INT_MIN;   // proxy z at last sync (stair retrigger)
static bool g_om_sync_done = false;

// Chunked overmap-sync apply. Applying the full ~32k-cell region with one
// overmap_buffer.ter_set() per cell froze the client's main thread for ~5.6s on
// receipt. Decode the packet into this buffer and drain a budget of cells per
// do_turn (mp_drain_pending_omsync) so the far-map fills in over a few seconds
// without ever blocking a frame. The overmap is far-map only (minimap / m-screen),
// so a brief fill-in delay is invisible to normal play.
struct pending_omsync_t {
    int z = 0, ox = 0, oy = 0, w = 0;
    std::vector<oter_id> cells;   // row-major resolved terrain
    std::vector<char> ok;         // 1 = apply this cell, 0 = skip (ungenerated)
    size_t cursor = 0;
    bool active = false;
};
// FIFO of per-z regions.  The host may stream more than one floor's overmap in a
// turn (host and client on different z), so each region drains independently
// instead of overwriting the previous (the v1 single buffer).
static std::vector<pending_omsync_t> g_pending_omsync;

static void mp_drain_pending_omsync()
{
    if( g_pending_omsync.empty() ) {
        return;
    }
    // Only apply while actually a client. If the session ended (e.g. dropped to
    // solo mid-apply), discard — don't write host overmap cells into a solo world.
    if( !is_client_mode() ) {
        g_pending_omsync.clear();
        return;
    }
    const auto t0 = std::chrono::steady_clock::now();
    constexpr size_t BUDGET = 1200;   // cells per do_turn
    pending_omsync_t &p = g_pending_omsync.front();
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
        g_pending_omsync.erase( g_pending_omsync.begin() );
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
static void mp_reset_map_sync()
{
    g_map_sync_sent.clear();
}

static void mp_reset_overmap_sync()
{
    g_om_sync_done = false;
    g_om_sync_last_center = tripoint_abs_omt{ INT_MIN, INT_MIN, 0 };
    g_om_sync_last_client_z = INT_MIN;
}

// Build the overmap-region message for a single z-level.  The region is centered
// on the host's x/y (`center`); `z` selects the floor.  Throttling and the choice
// of which floors to sync live in the build_overmap_sync() wrapper below.
static std::string build_overmap_sync_z( int z, const tripoint_abs_omt &center )
{
    const int R = g_om_sync_radius;
    const int ox = center.x() - R;
    const int oy = center.y() - R;
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
            const tripoint_abs_omt p( ox + xx, oy + yy, z );
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
            if( cp.x() < ox || cp.x() >= ox + w || cp.y() < oy || cp.y() >= oy + h ) {
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
                      ",\"ox\":" + std::to_string( ox ) + ",\"oy\":" + std::to_string( oy ) +
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
static std::string build_overmap_sync()
{
    if( !is_hosting() || !remote_player_connected ) {
        return std::string();
    }
    const tripoint_abs_omt center = get_avatar().pos_abs_omt();
    const int host_z = center.z();
    int client_z = host_z;
    const npc *remote = g->critter_by_id<npc>( remote_player_npc_id );
    if( remote ) {
        client_z = remote->pos_abs_omt().z();
    }

    const int step = 20;
    const bool moved = std::abs( center.x() - g_om_sync_last_center.x() ) >= step ||
                       std::abs( center.y() - g_om_sync_last_center.y() ) >= step;
    const bool z_changed = host_z != g_om_sync_last_center.z() ||
                           client_z != g_om_sync_last_client_z;
    if( g_om_sync_done && !moved && !z_changed ) {
        return std::string();
    }

    // Build the host's floor first; if nothing's generated there yet, don't latch
    // — retry next turn (mirrors the v1 real_omts==0 retry).
    std::string host_msg = build_overmap_sync_z( host_z, center );
    if( host_msg.empty() ) {
        g_om_sync_done = false;
        return std::string();
    }
    g_om_sync_last_center = center;
    g_om_sync_last_client_z = client_z;
    g_om_sync_done = true;

    std::string out = std::move( host_msg );
    if( client_z != host_z ) {
        const std::string cmsg = build_overmap_sync_z( client_z, center );
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
static std::string build_map_sync_z( int az )
{
    const auto t0 = std::chrono::steady_clock::now();
    map &m = get_map();
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
    for( int gy = 0; gy < MAPSIZE && sent < g_map_sync_cap; ++gy ) {
        for( int gx = 0; gx < MAPSIZE && sent < g_map_sync_cap; ++gx ) {
            const tripoint_abs_sm sm_abs{ origin.x() + gx, origin.y() + gy, az };
            if( g_map_sync_sent.count( sm_abs ) ) {
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
            g_map_sync_sent.insert( sm_abs );
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
static std::string build_map_sync()
{
    if( !is_hosting() || !remote_player_connected ) {
        return std::string();
    }
    const tripoint_abs_sm origin = get_map().get_abs_sub();

    // Which floors to sync this turn: the host's, plus the client's if its proxy
    // is on a different one.
    const int host_z = get_avatar().posz();
    int client_z = host_z;
    const npc *remote = g->critter_by_id<npc>( remote_player_npc_id );
    if( remote ) {
        client_z = remote->posz();
    }
    const bool two_floors = client_z != host_z;

    // Forget submaps that have scrolled out of the synced region — a different
    // x/y bubble, or a z-level we're no longer syncing — so a return visit
    // re-syncs them (the client may have regenerated them locally after unload).
    for( auto it = g_map_sync_sent.begin(); it != g_map_sync_sent.end(); ) {
        const bool z_synced = it->z() == host_z || ( two_floors && it->z() == client_z );
        const bool in_bubble = z_synced &&
                               it->x() >= origin.x() && it->x() < origin.x() + MAPSIZE &&
                               it->y() >= origin.y() && it->y() < origin.y() + MAPSIZE;
        it = in_bubble ? std::next( it ) : g_map_sync_sent.erase( it );
    }

    std::string out = build_map_sync_z( host_z );
    if( two_floors ) {
        const std::string client_msg = build_map_sync_z( client_z );
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

void grant_client_turn()
{
    // Capture the world seed each host turn (game-thread read of g->get_seed())
    // so the network thread can put it in the join 'welcome' without touching
    // game state. Runs before the connected-check so it's current the moment a
    // client joins. Seed is constant for a session; the store is idempotent.
    g_host_world_seed.store( g->get_seed() );
    // Capture the host avatar's OMT for the join 'welcome' so a client spawns into
    // the host's area, not its own scenario start_location.
    mp_capture_host_omt( get_avatar().pos_abs_omt() );
    if( world_generator && world_generator->active_world ) {
        mp_set_host_world_name( world_generator->active_world->world_name );
    }
    // Cache the host's character name for the join 'welcome' so the client's
    // join dialog can show whose game it is. Runs before the connected-check so
    // it's current the moment a client probes.
    mp_set_host_player_name( get_avatar().name );
    if( !remote_player_connected ) {
        return;
    }
    npc *remote = g->critter_by_id<npc>( remote_player_npc_id );
    if( !remote ) {
        // If we previously had a live proxy and it's now gone, treat it as a
        // death (monsters on the host's side killed the NPC representing the
        // client).  Notify the client cleanly so they get a "You died." flow
        // instead of a silent "Lost connection to server" 20 seconds later
        // when something else times out.  Then tear down the host-side state.
        if( g_proxy_was_alive ) {
            mp_log( "[cdda-mp] PROXY-DIED: notifying client and disconnecting" );
            if( server *srv = get_active_server() ) {
                srv->post_broadcast( "{\"type\":\"you_died\"}\n" );
                // Brief flush window so the packet leaves before the socket
                // is torn down — same pattern as notify_client_host_died.
                std::this_thread::sleep_for( std::chrono::milliseconds( 200 ) );
            }
            g_proxy_was_alive = false;
            remove_remote_player();
        }
        return;
    }
    g_proxy_was_alive = true;
    g_client_acted_this_turn = false;
    // FIX #2/#3: accumulate this turn's speed onto any carried AP debt instead of
    // resetting to full speed.  Only issue a real grant (advance grant_seq, unlock
    // the client) when the budget comes out positive; while still negative this is
    // a "deficit turn" — no grant — and wait_for_client_action() advances the
    // host's monmove() solo so the world keeps moving while the client pays off the
    // expensive move (SP-faithful: a costly step burns several turns).
    g_remote_moves += remote->get_speed();
    g_granted_this_turn = ( g_remote_moves > 0 );
    if( g_granted_this_turn ) {
        ++g_grant_seq;
    }
    const player_activity &ha = get_avatar().activity;
    // turn= is the shared game clock (the client logs calendar_turn in its state
    // packets) — use it to align the host and client logs by game turn, immune to
    // wall-clock skew.  Safe to read here: grant_client_turn runs on the game
    // thread.
    mp_log( "[cdda-mp] grant_client_turn: remote_moves=" + std::to_string( g_remote_moves ) +
            " seq=" + std::to_string( g_grant_seq ) +
            " turn=" + std::to_string( to_turn<int>( calendar::turn ) ) +
            " host_act=" + ( ha ? ha.id().str() : "none" ) );
    // Proxy skips npcmove so never auto-regenerates stamina. Replicate the
    // update_body() path that the real avatar gets each game turn.
    remote->update_stamina( 1 );
    check_separation_warning( get_avatar().pos_abs(), remote->pos_abs() );
    server *srv = get_active_server();
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
        const std::string mapm = build_map_sync();
        if( !mapm.empty() ) {
            srv->post_broadcast( mapm + "\n" );
        }
        srv->post_broadcast( serialize_remote_player_state() + "\n" );
        // Stream the host's overmap region so the client's far-map (cities/
        // roads/biomes) matches instead of its own non-deterministic regen.
        // Returns "" unless this is the first sync or the host moved a step,
        // so it's cheap on the steady-state path.
        const std::string om = build_overmap_sync();
        if( !om.empty() ) {
            srv->post_broadcast( om + "\n" );
        }
    }
}

void wait_for_client_action()
{
    if( !remote_player_connected ) {
        return;
    }

    // Sleep is the one true fast-forward case: 28800 ticks of strict lockstep
    // would mean ~48 minutes wall-clock for 8 hours of game-sleep.  Host-side
    // sleep effect bypasses the lockstep wait so the host can race through
    // those turns at native do_turn speed.  Client-side sleep needs its own
    // bypass once implemented — for now sleep is treated as host-only.
    {
        static const efftype_id eff_sleep( "sleep" );
        if( get_avatar().has_effect( eff_sleep ) ) {
            process_mp_events();
            mp_log( "[cdda-mp] lockstep-skip: host_act=sleep" );
            return;
        }
    }

    // Both-passive fast-forward: when both sides are in passive activities
    // (both crafting, both eating, host crafting + client helping, etc.),
    // drop strict lockstep so wall-clock progress matches SP's machine-speed
    // activity ticks.  20-min in-game craft → ~5-10s real-time instead of
    // ~6.5min under 1:1 lockstep.  SP's per-turn activity cancellation
    // (hostile-in-sight, low HP, sound, etc.) fires on the host as turns
    // advance and naturally exits FF: cancel ends av_act, next call returns
    // false, the following turn re-enters strict lockstep.
    static bool ff_was_active = false;
    const bool ff_now = should_fast_forward();
    if( ff_now != ff_was_active ) {
        if( ff_now ) {
            mp_log( std::string( "[cdda-mp] lockstep-skip: FAST-FORWARD enter host_act=" )
                    + ( get_avatar().activity ? get_avatar().activity.id().str() : "?" )
                    + " partner_act=" + g_partner_activity );
        } else {
            mp_log( "[cdda-mp] lockstep-resume: FAST-FORWARD exit" );
        }
        ff_was_active = ff_now;
    }
    if( ff_now ) {
        process_mp_events();
        return;
    }

    // FIX #2/#3: deficit turn — the client is still paying off an expensive move's
    // AP debt, so grant_client_turn() issued no grant this turn.  Don't block on a
    // client ack that won't come; pump events and let the host advance monmove()
    // solo, exactly as SP advances turns while a slow character's moves are
    // negative.  The next grant_client_turn() adds another speed's worth; once the
    // budget goes positive the client is granted again and strict lockstep resumes.
    if( !g_granted_this_turn ) {
        process_mp_events();
        static int s_debt_skips = 0;
        mp_log( "[cdda-mp] lockstep-skip: client in move-debt, g_remote_moves=" +
                std::to_string( g_remote_moves ) + " skip#" + std::to_string( ++s_debt_skips ) );
        return;
    }

    // No partner-activity bypass: every activity (drop, wear, take_off, read,
    // craft, eat, wait, …) now dispatches a "wait" ack per tick via the
    // do_turn post-loop dispatch path, so strict lockstep works for them all.
    // The earlier g_partner_activity bypass was leftover scaffolding from the
    // DISCONNECT-TIMEOUT era and would let the host fast-forward freely while
    // the partner was inside an activity that took even a few packets to
    // complete (drop on a seat → host's |-wait fast-forwarded ~30 minutes).

    g_host_waiting_for_client = true;
    const auto t_start = std::chrono::steady_clock::now();
    // Pure lockstep: every game-turn requires a client ack — including turns
    // the host spends inside a long activity (|-wait, sleep, craft).  The
    // activity progresses one game-turn at a time, paced by the client's
    // round-trip.  This keeps the shared calendar consistent: time only
    // advances when both ends agree on an action for this turn.
    //
    // No wall-clock timeout: in turn-based, "wait indefinitely" is correct.
    // TCP connection drop (remote_player_connected = false) is the only
    // legitimate exit besides the client acting.  Each iter caps at 16ms
    // so SDL stays pumped during long waits.
    const bool host_in_wait = host_is_in_wait_activity();  // logged only
    {
        const player_activity &ha_enter = get_avatar().activity;
        mp_log( "[cdda-mp] SRV-WAIT: entering, grant_seq=" + std::to_string( g_grant_seq ) +
                " host_in_wait=" + std::to_string( host_in_wait ) +
                " host_act=" + ( ha_enter ? ha_enter.id().str() : "none" ) );
    }

    int iter_count = 0;
    // Per-phase max times across this SRV-WAIT, logged once on exit so we
    // don't spam per-iter.  Anything that spikes above ~16ms is blocking the
    // SDL input pump and explains "I pressed zoom and it didn't react."
    int max_waitev_ms = 0;
    int max_drain_ms  = 0;
    int max_pump_ms   = 0;
    int max_redraw_ms = 0;
    int max_input_ms  = 0;
    // Track host activity across iters so we can detect a transition (cancel
    // mid-handle_action, or a new activity started somehow) and force-broadcast
    // it.  Without this, the client's view of g_partner_activity goes stale —
    // it FF-decides based on what we LAST told it, not what we're doing now.
    // If host's activity ended after the iteration's grant_client_turn
    // broadcast but before reaching the wait, the client still thinks FF
    // applies, suppresses its wait dispatch, and we deadlock waiting for an
    // ack that won't come.  Cheap to do — only broadcasts on actual edge.
    std::string prev_wait_host_act = get_avatar().activity
                                     ? get_avatar().activity.id().str() : "";
    // Log the partner-interactive skip (below) once per wait, not per-iter.
    bool logged_partner_interactive_skip = false;
    while( remote_player_connected ) {
        // Host requested quit (save&quit / suicide / die) while waiting for the
        // client: stop waiting immediately so do_turn can return and the game
        // exits. The client was already told via mp_notify_session_ending().
        // Without this the wait spins forever once the client has left — no ack
        // ever arrives — and save&quit appears to do nothing (regression
        // 2026-06-21: host stuck in SRV-WAIT, uquit=QUIT_SAVED set but ignored).
        if( g->uquit != QUIT_NO ) {
            mp_log( "[cdda-mp] SRV-WAIT: uquit=" + std::to_string( g->uquit ) +
                    " set, breaking out of client wait" );
            break;
        }
        if( g_client_acted_this_turn ) {
            break;  // client acted, advance shared clock by this turn
        }
        // Mid-wait FF check: client's activity_start may arrive *after* we
        // entered the wait (host entered first), so the entry-time
        // should_fast_forward() returned false.  Re-check each iter — the
        // moment partner activity flips to passive while ours already is,
        // bail out and let do_turn race through both crafts at SP speed.
        // Without this, the client (also in FF) won't dispatch waits, so
        // g_client_acted_this_turn never flips and we deadlock both ends.
        if( should_fast_forward() ) {
            mp_log( "[cdda-mp] SRV-WAIT: FAST-FORWARD engaged mid-wait, bailing" );
            break;
        }
        // Host-activity transition broadcast: if our activity changed since
        // entering the wait (typically: just cancelled mid-handle_action),
        // push fresh state to the client right away.  Otherwise the client
        // keeps thinking we're still crafting and stays in FF — meaning it
        // never dispatches a wait — meaning this wait never unblocks.
        const std::string cur_host_act = get_avatar().activity
                                         ? get_avatar().activity.id().str() : "";
        if( cur_host_act != prev_wait_host_act ) {
            mp_log( std::string( "[cdda-mp] SRV-WAIT: host activity transition " ) +
                    prev_wait_host_act + " -> " + cur_host_act +
                    ", broadcasting state" );
            if( server *srv = get_active_server() ) {
                srv->post_broadcast( serialize_remote_player_state() + "\n" );
            }
            prev_wait_host_act = cur_host_act;
        }
        // Cap each iteration at ~16ms so SDL gets pumped at 60Hz.  Without this
        // the main thread blocks in TCP recv indefinitely, which trips the macOS
        // spinning-beachball watchdog.  mp_poll_input() (handle_action) is
        // intentionally NOT called: it blocks waiting for a keypress, eating the
        // async-tick budget by up to seconds.  Re-adding host-side menu access
        // during waits will need a non-blocking input peek, not a full action
        // dispatcher.
        // Burst mode: both players in non-interactive activities (e.g. crafting +
        // helping).  Drop the 16ms throttle so the shared clock advances as fast
        // as the host's CPU can serialize ticks — turns an 8-hour craft from
        // minutes of staring at the wait popup into seconds.
        const auto step = mp_in_burst_mode()
                          ? std::chrono::milliseconds( 0 )
                          : std::chrono::milliseconds( 16 );
        const auto t_iter0 = std::chrono::steady_clock::now();
        get_mp_queue().wait_for_event( step );
        const auto t_after_wait = std::chrono::steady_clock::now();
        process_mp_events();
        const auto t_after_drain = std::chrono::steady_clock::now();
        // The drain above may have just set g_client_acted_this_turn (the
        // client's "wait" ack arrived). Break NOW, before the blocking
        // mp_poll_input() below — otherwise the host sits in handle_action for
        // 135-327ms even though the client already acked at ~+16ms, pacing
        // every host move to that input poll and flickering the turn signal
        // red. Root cause of the host sluggishness/flicker (2026-06-03 logs:
        // input=150-327ms dominated SRV-WAIT while drain/pump/redraw were
        // <20ms and the client acked in 16ms). The top-of-loop check only
        // catches it a full input-poll too late.
        // Poll input EVERY iteration BEFORE the drain-break. handle_key_blocking_
        // activity handles BOTH a wait/long activity AND the no-activity host-locked
        // case (is_host_waiting_for_client() is true throughout SRV-WAIT) — zoom,
        // m-map, 5-to-cancel, messages. Non-blocking handle_input(0), so it can't
        // re-pace moves or flicker. The break fires the instant the client acks
        // (~16ms), before the 100ms-gated poll below; gating this on
        // get_avatar().activity (prev attempt) missed the COMMON case — the host
        // sits here with host_act=none most of the time, so input was starved
        // ("5/zoom/map only occasionally caught").
        inp_mngr.pump_events();
        // Block up to 16ms for an event (not a non-blocking poll). DIAG proved the
        // non-blocking poll ran 57x/sec but caught ZERO keys — the SRV-WAIT sub-loop
        // doesn't deliver SDL events to handle_input(0) the way the main loop does.
        // Blocking (like the monster-interrupt popup, which IS responsive) catches
        // them reliably. 16ms ≈ the loop's step, so it adds no real latency.
        handle_key_blocking_activity( 16 );
        if( g_client_acted_this_turn ) {
            break;
        }
        ensure_mp_hud();
        inp_mngr.pump_events();
        const auto t_after_pump = std::chrono::steady_clock::now();
        // Redraw the side strip + Co-op panel ~10x/sec while we're blocked so
        // the host's HUD actually flips to red while locked, instead of staying
        // green until the wait exits.  Rate-limited because ui_manager::redraw
        // isn't free and 60Hz redraws are wasteful when nothing visually changes.
        static auto last_redraw = std::chrono::steady_clock::now();
        const auto now = std::chrono::steady_clock::now();
        if( std::chrono::duration_cast<std::chrono::milliseconds>( now - last_redraw ).count() > 100 ) {
            ui_manager::redraw();
            last_redraw = now;
        }
        const auto t_after_redraw = std::chrono::steady_clock::now();
        // Mirror the client's locked-input branch: call full handle_action so
        // every free UI action (zoom, morale, map, inventory, messages, look)
        // works while the host is waiting for the client.  handle_action gates
        // moves-consuming actions out via the host-locked check at
        // handle_action.cpp:3038, so this is safe — only pure UI passes.
        //
        // handle_action blocks on a keypress, but its internal TIMEOUT poll
        // calls process_mp_events for the host every ~125ms, and the
        // client_just_acted TIMEOUT escape in get_player_input breaks out of
        // the input poll the moment the client acts.  Net result: host gets
        // full SP-style input access AND the wait still exits on client ack.
        // Only run the (blocking) host input poll once we've genuinely been
        // waiting a while. For a normal move the client acks in tens of ms and
        // the drain-break above exits the loop long before this threshold — so
        // mp_poll_input never runs and can't pace the host or flicker the turn
        // signal red (root cause of the residual movement flicker, 2026-06-03:
        // max_input=76-442ms on host_act=none waits even after the drain-break,
        // because handle_action's internal client-acted escape is unreliable
        // and blocks up to ~440ms). Past the threshold it's a real long wait
        // (client crafting/sleeping) where the host wants menu access, so
        // engage the full poll then. SDL still gets pumped every iter via
        // inp_mngr.pump_events() above, so no beachball during the tight phase.
        const long wait_elapsed_ms = std::chrono::duration_cast<std::chrono::milliseconds>(
                                         std::chrono::steady_clock::now() - t_start ).count();
        // No-activity host wait: the blocking input poll stays gated behind 100ms
        // so it can't pace normal moves / flicker the turn signal. The in-activity
        // case is now polled non-blocking every iteration above (before the
        // drain-break), so it's not repeated here.
        // Partner in an interactive activity (ACT_AIM/FIRSTAID/AUTOATTACK/
        // AUTODRIVE) runs its UI locally and won't send a wait until it resolves.
        // mp_poll_input() blocks until a host keypress OR client_acted_this_turn()
        // — neither happens while the partner aims, so it would sit here for the
        // ENTIRE aim (the 10s+ "input=" SRV-WAIT phases / host beachball). Skip the
        // blocking poll then: the non-blocking handle_key_blocking_activity(16)
        // above still gives the host zoom/menu access, and the loop keeps spinning
        // every ~16ms (SDL pumped), so the host stays responsive — the mirror of
        // the client staying responsive while the host aims (ranged.cpp:2988).
        const bool partner_interactive = partner_in_interactive_activity();
        if( wait_elapsed_ms > 100 && !get_avatar().activity && !partner_interactive ) {
            /* MP-FIXME: g->mp_poll_input stubbed for CCB */
        } else if( partner_interactive && !logged_partner_interactive_skip ) {
            mp_log( "[cdda-mp] SRV-WAIT: partner interactive (" + g_partner_activity +
                    ") — skipping blocking host poll to stay responsive" );
            logged_partner_interactive_skip = true;
        }
        const auto t_after_input = std::chrono::steady_clock::now();
        const int waitev_ms = static_cast<int>(
                                  std::chrono::duration_cast<std::chrono::milliseconds>( t_after_wait - t_iter0 ).count() );
        const int drain_ms = static_cast<int>(
                                 std::chrono::duration_cast<std::chrono::milliseconds>( t_after_drain - t_after_wait ).count() );
        const int pump_ms = static_cast<int>(
                                std::chrono::duration_cast<std::chrono::milliseconds>( t_after_pump - t_after_drain ).count() );
        const int redraw_ms = static_cast<int>(
                                  std::chrono::duration_cast<std::chrono::milliseconds>( t_after_redraw - t_after_pump ).count() );
        const int input_ms = static_cast<int>(
                                 std::chrono::duration_cast<std::chrono::milliseconds>( t_after_input - t_after_redraw ).count() );
        max_waitev_ms = std::max( max_waitev_ms, waitev_ms );
        max_drain_ms  = std::max( max_drain_ms,  drain_ms );
        max_pump_ms   = std::max( max_pump_ms,   pump_ms );
        max_redraw_ms = std::max( max_redraw_ms, redraw_ms );
        max_input_ms  = std::max( max_input_ms,  input_ms );
        // Flag any single iter where a phase spent > 30ms — that's a smoking
        // gun for input lag, since the SDL queue can only drain via pump_events
        // and any phase that hogs the main thread blocks the next keypress.
        if( waitev_ms > 30 || drain_ms > 30 || pump_ms > 30 ||
            redraw_ms > 30 || input_ms > 30 ) {
            mp_log( "[cdda-mp] SRV-WAIT-ITER#" + std::to_string( iter_count ) +
                    " SLOW: wait=" + std::to_string( waitev_ms ) +
                    "ms drain=" + std::to_string( drain_ms ) +
                    "ms pump=" + std::to_string( pump_ms ) +
                    "ms redraw=" + std::to_string( redraw_ms ) +
                    "ms input=" + std::to_string( input_ms ) + "ms" );
        }
        iter_count++;
    }
    g_host_waiting_for_client = false;
    // DIAG: per-turn wait duration. The turn-signal shows RED while
    // g_host_waiting_for_client is true and stays red once that exceeds the
    // 400ms green-hysteresis — so any value >400ms here is a red flicker the
    // host sees this turn. Correlate with whether the client was idle.
    {
        const long wait_ms = std::chrono::duration_cast<std::chrono::milliseconds>(
                                 std::chrono::steady_clock::now() - t_start ).count();
        mp_log( "[cdda-mp] SRV-WAIT-DONE: turn_wait=" + std::to_string( wait_ms ) +
                "ms" + ( wait_ms > 400 ? "  >400 (RED)" : "" ) );
    }
    // Force a main-UI repaint each turn cycle.  During a long activity (|-wait,
    // crafting, sleep) the host's main game loop stays in a tight do_turn() loop
    // because the avatar always has moves; without this, the time/wait-% HUD
    // and recent messages don't visibly tick between turns.  ui_manager::redraw()
    // is a no-op unless something has been invalidated.
    g->invalidate_main_ui_adaptor();
    ui_manager::redraw();
    g_wait_elapsed_ms = static_cast<int>(
                            std::chrono::duration_cast<std::chrono::milliseconds>(
                                std::chrono::steady_clock::now() - t_start ).count() );
    {
        const player_activity &ha = get_avatar().activity;
        mp_log( "[cdda-mp] SRV-WAIT: done, elapsed=" + std::to_string( g_wait_elapsed_ms ) +
                "ms host_act=" + ( ha ? ha.id().str() : "none" ) +
                " host_in_wait=" + std::to_string( host_in_wait ) +
                " iters=" + std::to_string( iter_count ) +
                " acted_flag=" + std::to_string( g_client_acted_this_turn ) +
                " max_wait=" + std::to_string( max_waitev_ms ) +
                "ms max_drain=" + std::to_string( max_drain_ms ) +
                "ms max_pump=" + std::to_string( max_pump_ms ) +
                "ms max_redraw=" + std::to_string( max_redraw_ms ) +
                "ms max_input=" + std::to_string( max_input_ms ) + "ms" );
    }

    // Keep the remote NPC proxy's in_vehicle flag in sync with its map position
    // before monmove() / process_vehicles() runs.  vehicle_move.cpp line ~892 skips
    // collision for any character with in_vehicle==true, so without this the vehicle
    // rams into its own passenger each time it moves.
    if( remote_player_connected ) {
        npc *remote = g->critter_by_id<npc>( remote_player_npc_id );
        if( remote ) {
            const optional_vpart_position ovp = get_map().veh_at( remote->pos_bub() );
            remote->in_vehicle = static_cast<bool>( ovp );
            if( !ovp ) {
                remote->controlling_vehicle = false;
            }
        }
    }
}

bool host_is_in_wait_activity()
{
    if( !is_hosting() ) {
        return false;
    }
    static const activity_id act_wait( "ACT_WAIT" );
    static const activity_id act_wait_stamina( "ACT_WAIT_STAMINA" );
    static const activity_id act_wait_weather( "ACT_WAIT_WEATHER" );
    static const activity_id act_wait_npc( "ACT_WAIT_NPC" );
    const player_activity &act = get_avatar().activity;
    return act && ( act.id() == act_wait || act.id() == act_wait_stamina ||
                    act.id() == act_wait_weather || act.id() == act_wait_npc );
}

bool should_advance_calendar()
{
    // SP / host: always advance.  Client: only advance when moves > 0 — that
    // means a grant just landed and the current do_turn iteration represents
    // an actual game turn.  Without this guard, calendar::turn would tick at
    // every main-loop iteration (~10/sec) regardless of whether the client
    // had been granted a turn, racing past the host's authoritative time.
    return !is_client_mode() || get_avatar().get_moves() > 0;
}

bool is_passive_activity( const std::string &activity_id_str )
{
    // Activities where the avatar is committed turn-after-turn without
    // per-turn user input.  Once entered, SP's activity_actor::do_turn ticks
    // the activity on every game turn at machine speed.  Excludes:
    //  - ACT_FIRSTAID, ACT_AIM, ACT_AUTOATTACK, ACT_AUTODRIVE — interactive
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
        "ACT_WAIT", "ACT_WAIT_STAMINA", "ACT_WAIT_WEATHER", "ACT_WAIT_NPC",
        "ACT_SLEEP",
        "ACT_HELP_PARTNER",
    };
    return passive.count( activity_id_str ) > 0;
}

bool should_fast_forward()
{
    // Need to be in an MP session.  SP never fast-forwards — SP runs activities
    // at machine speed already.
    if( !is_hosting() && !is_client_mode() ) {
        return false;
    }
    // Local avatar must be in a passive activity.
    const player_activity &av_act = get_avatar().activity;
    if( !av_act || !is_passive_activity( av_act.id().str() ) ) {
        return false;
    }
    // Partner's reported activity must also be passive.  g_partner_activity is
    // set by the heartbeat / per-action enrich on the other side — empty when
    // partner is idle (input loop) which means strict lockstep applies.
    if( g_partner_activity.empty() || !is_passive_activity( g_partner_activity ) ) {
        return false;
    }
    // No explicit combat-mode gate here: SP's activity_actor::do_turn already
    // cancels the activity on hostile-in-sight (and on low HP, hunger, sound,
    // etc.).  When that fires, av_act becomes null, this returns false on the
    // next call, and the next do_turn returns to strict lockstep naturally.
    return true;
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
            nearest_synced = mon->mp_net_id != 0;
            nearest_id = mon->type->id.str();
        }
    }
    // Throttle: only emit when something meaningful changed, else FF (200 turns/sec)
    // floods the 10MB log.
    static int s_last_newseen = -2;
    static int s_last_nearest = -2;
    static int s_last_safe = -2;
    if( newseen == s_last_newseen && nearest == s_last_nearest && safe_mode == s_last_safe ) {
        return;
    }
    s_last_newseen = newseen;
    s_last_nearest = nearest;
    s_last_safe = safe_mode;
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
    g_last_monmove_ms = ms;
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
    g_last_host_action_label = ( it != dir_map.end() ) ? it->second : label;
}

bool is_remote_player( character_id id )
{
    return remote_player_connected && id == remote_player_npc_id;
}

bool is_host_waiting_for_client()
{
    return g_host_waiting_for_client;
}

bool client_acted_this_turn()
{
    return g_client_acted_this_turn;
}

bool partner_in_interactive_activity()
{
    return !g_partner_activity.empty() && !is_passive_activity( g_partner_activity );
}

bool is_partner_in_wait_activity()
{
    // g_partner_activity is the activity id string last broadcast from the
    // other side (host_activity field for the client; client_activity field
    // for the host).  Only the four wait variants count as interruptible.
    return g_partner_activity == "ACT_WAIT" ||
           g_partner_activity == "ACT_WAIT_STAMINA" ||
           g_partner_activity == "ACT_WAIT_WEATHER" ||
           g_partner_activity == "ACT_WAIT_NPC";
}

bool is_partner_helping_us()
{
    return g_partner_activity == "ACT_HELP_PARTNER";
}

bool partner_activity_accepts_help()
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
    return eligible.count( g_partner_activity ) > 0;
}

int partner_activity_moves_total()
{
    return g_partner_activity_moves_total;
}

int partner_activity_pct()
{
    return g_partner_activity_pct;
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
    if( g_partner_activity.empty() ) {
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
        // ASSIST-DISPLAY diag (case 2: I help, partner builds): I mirror the
        // partner's reported pct.  Change-gated.
        static int s_last_help_pct = -1;
        if( g_partner_activity_pct != s_last_help_pct ) {
            s_last_help_pct = g_partner_activity_pct;
            mp_log( "[cdda-mp] ASSIST-PCT help(mirror): partner pct=" +
                    std::to_string( g_partner_activity_pct ) );
        }
        return g_partner_activity_pct;
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
        if( const build_construction_activity_actor *bca =
                dynamic_cast<const build_construction_activity_actor *>( act.actor.get() ) ) {
            map &m = get_map();
#if 0 // MP-FIXME: get_construction_location private in CCB
            if( partial_con *pc = m.partial_con_at( m.get_bub( bca->get_construction_location() ) ) ) {
                const int pct = std::clamp( pc->counter / 100000, 0, 100 );
                static int s_last_build_pct = -1;
                if( pct != s_last_build_pct ) {
                    s_last_build_pct = pct;
                    mp_log( "[cdda-mp] ASSIST-PCT build(local): pct=" + std::to_string( pct ) +
                            " counter=" + std::to_string( pc->counter ) );
                }
                return pct;
            }
#endif
            ( void )m;
            ( void )bca;
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
    if( partner_activity_accepts_help() ) {
        return;
    }
    mp_log( "[cdda-mp] HELP-CANCEL: partner activity ended, dropping ACT_HELP_PARTNER" );
    add_msg( m_info, _( "Your partner finished — you stop helping." ) );
    av.cancel_activity();
}

void mark_wake_client_pending()
{
    g_pending_wake_client = true;
}

void mark_partner_swap_pending()
{
    g_pending_partner_swap = true;
}

void mark_partner_push_pending()
{
    g_pending_partner_push = true;
}

int get_separation_tier()
{
    return g_separation_tier;
}

npc *get_partner_npc()
{
    // Host POV: client's proxy. Client POV: host's proxy.
    // Gate each branch on the live-session flag, mirroring is_remote_player().
    // The id alone is not safe: the cleared/default sentinel is
    // character_id() == -1, which collides with the id of an orphaned proxy
    // left in a world save (proxies that lose their assigned id on reload also
    // land at -1). Without the connection gate, a host with no client resolves
    // that ghost and draws the off-screen partner arrow at its tile.
    npc *result = nullptr;
    if( ( is_hosting() || is_server_mode() ) && remote_player_connected &&
        remote_player_npc_id.get_value() != 0 ) {
        if( npc *n = g->critter_by_id<npc>( remote_player_npc_id ) ) {
            result = n;
        }
    }
    if( !result && is_client_mode() && client_host_npc_id.get_value() != 0 ) {
        if( npc *n = g->critter_by_id<npc>( client_host_npc_id ) ) {
            result = n;
        }
    }
    return result;
}

bool is_partner_npc( character_id id )
{
    // Host side: the client's proxy is remote_player_npc_id.
    if( is_remote_player( id ) ) {
        return true;
    }
    // Client side: the host's proxy is client_host_npc_id.  Don't use
    // character_id::is_valid() — it checks value > 0, but the MP-spawned
    // proxy NPCs end up with negative IDs (e.g. -1) which is_valid() rejects
    // even though the NPC is real and findable.  Just guard against the
    // default-uninitialized id (value 0) and compare directly.
    return is_client_mode() &&
           client_host_npc_id.get_value() != 0 &&
           id == client_host_npc_id;
}

bool is_client_host_at( const tripoint_abs_ms &abs )
{
    if( !client_host_npc_spawned || !client_host_npc_id.is_valid() ) {
        return false;
    }
    npc *hnpc = g->critter_by_id<npc>( client_host_npc_id );
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
    server *srv = get_active_server();
    if( !srv ) {
        return;
    }
    srv->post_broadcast( "{\"type\":\"host_died\"}\n" );
    // Brief pause so the packet flushes before the death screen takes focus.
    std::this_thread::sleep_for( std::chrono::milliseconds( 200 ) );
}

// Co-op save handshake — called right after the SP quicksave() runs.  See the
// "Co-op save model" section of ROADMAP.md.  Host: confirm the authoritative
// save.  Client: the local save is already written; also ask the host to save
// the shared world so the two stores stay at the same game-time, and surface
// where each player's data lives.
void mp_after_quicksave()
{
    if( is_host_mode() && is_hosting() ) {
        add_msg( m_good,
                 _( "Co-op world saved — the authoritative save of the shared world and your partner's character.  (Your partner also keeps a local copy of their own character.)" ) );
    } else if( is_client_mode() ) {
        add_msg( m_info,
                 _( "Saved your character locally.  Asking the host to save the shared world so you stay in sync…" ) );
        client_send( R"({"type":"action","action":"save_request"})" );
    }
}

void mp_notify_session_ending()
{
    if( is_host_mode() ) {
        server *srv = get_active_server();
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
    // Brief pause so the TCP write completes before the socket goes down.
    std::this_thread::sleep_for( std::chrono::milliseconds( 300 ) );

    // Host: tear down the listen server. run_server()'s srv.run() blocks until
    // stop() is called; if we never stop it, the thread lingers, active_server_
    // stays set, is_hosting() keeps returning true, and the NEXT host session in
    // this launch short-circuits the re-arm -> no new thread, no co-op UI
    // (reproduced 2026-06-02). stop() makes srv.run() return -> run_server sets
    // active_server_ = nullptr. The post-stop pause lets that unwind before any
    // re-host checks is_hosting().
    if( is_host_mode() ) {
        if( server *srv = get_active_server() ) {
            srv->stop();
            mp_log( "[cdda-mp] SESSION-END: host server stop() called" );
        }
        // Wait for the (detached) listen thread to FULLY exit run_server() —
        // not just a fixed sleep. Only then has the server object destructed
        // and freed the port-8080 socket. A fixed 200ms sleep raced this: a
        // re-host could bind before the old socket released, the server ctor
        // threw EADDRINUSE, active_server_ stayed null, is_hosting() read false
        // on the 2nd host -> no co-op HUD, no live listener (2026-06-02).
        // Bounded so a wedged thread can't hang the quit/return-to-menu.
        for( int i = 0; i < 300 && is_server_thread_running(); ++i ) {
            std::this_thread::sleep_for( std::chrono::milliseconds( 10 ) );
        }
        mp_log( "[cdda-mp] SESSION-END: listen thread exited, running=" +
                std::to_string( is_server_thread_running() ) );
    }

    // Drop the co-op HUD so the next session re-creates it fresh.  g_mp_hud /
    // g_mp_edge are static and their ui_adaptors register against the current
    // screen; carrying them across a return-to-main-menu leaves stale adaptors
    // that never draw — no co-op panel / turn-stripes on a second session.
    g_mp_edge.reset();
    g_mp_hud.reset();
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
static void mp_send_payload( const std::string &payload )
{
    if( is_host_mode() ) {
        server *srv = get_active_server();
        if( srv ) {
            srv->post_broadcast( payload + "\n" );
        }
    } else if( is_client_mode() ) {
        client_send( payload );
    }
}

void mp_templates_sync_on_join()
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
    mp_send_payload( oss.str() );
    mp_log( "[cdda-mp] TEMPLATES: sent list, n=" + std::to_string( names.size() ) );
}

static void mp_handle_templates_list( const std::string &msg )
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
        mp_send_payload( oss.str() );
        mp_log( "[cdda-mp] TEMPLATES: requested " + std::to_string( missing.size() ) );
    } catch( const JsonError &e ) {
        mp_log( "[cdda-mp] TEMPLATES list parse error: " + std::string( e.what() ) );
    }
}

static void mp_handle_template_request( const std::string &msg )
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
            mp_send_payload( oss.str() );
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

// Set when the user picks "Host a session" from the main-menu chooser.
// The server thread isn't actually spawned yet — that's deferred to the
// first process_mp_events() call (which only runs once a world is loaded),
// so a client connecting before there's an avatar to spawn into can't crash
// us.  Lets us also offer a "Cancel co-op" path while still in the menu.
static bool g_pending_host_start = false;
static bool g_host_thread_actually_started = false;

// Called from process_mp_events() on the host's first turn after the world
// has loaded.  Spawns the listen-server thread iff the menu armed it and we
// haven't already started it.  No-op when the server was started via the
// --host CLI flag (main.cpp spawns its own thread in that path).
static void mp_start_pending_host_thread()
{
    // Nothing armed / already running: return immediately, BEFORE any logging.
    // process_mp_events() calls this every do_turn even in pure single-player
    // (the callout in do_turn.cpp is unconditional), so an early return here keeps
    // a non-hosting player from touching the MP log at all on this path.
    if( !g_pending_host_start || g_host_thread_actually_started ) {
        return;
    }
    // Lifecycle trace: only reached on the turn the server thread actually starts.
    // A second host session in one launch can arrive here with stale statics.
    mp_log( "[cdda-mp] HOST-THREAD-CHECK: pending=" + std::to_string( g_pending_host_start ) +
            " already_started=" + std::to_string( g_host_thread_actually_started ) +
            " host_mode=" + std::to_string( is_host_mode() ) );
    std::thread( []() {
        run_server( 8080, std::string(), getVersionString() );
    } ).detach();
    g_host_thread_actually_started = true;
    mp_log( "[cdda-mp] MENU: host thread started (post-world-load)" );
}

bool mp_menu_start_host_session()
{
    // Log the running binary's exact version so the log shows what's ACTUALLY
    // executing — the on-disk binary can differ from a still-running process
    // after a rebuild, and the handshake compares this string's commit token.
    mp_log( std::string( "[cdda-mp] VERSION=" ) + getVersionString() + " (role=HOST)" );
    // Short-circuit ONLY when we're genuinely still hosting (a live server) — the
    // case where the user re-enters the world/char picker mid-arming.  If
    // host_mode is set but the server is gone (a prior session ended without
    // clearing it), fall through and RE-ARM.  Otherwise a second host session in
    // the same launch never restarts the listen thread:
    // g_host_thread_actually_started stays true -> mp_start_pending_host_thread
    // returns early -> no listener, no co-op UI (reproduced 2026-06-02).
    if( is_host_mode() && is_hosting() ) {
        mp_log( "[cdda-mp] HOST-ARM: already hosting (live server), short-circuit" );
        return true;
    }
    mp_log( "[cdda-mp] HOST-ARM: arming (host_mode was " +
            std::to_string( is_host_mode() ) + ", live_server=" +
            std::to_string( is_hosting() ) + ") — re-arm restarts the thread" );
    set_host_mode( true );
    // Server thread starts on the host's first do_turn (see
    // mp_start_pending_host_thread) so we don't end up listening before
    // there's a world for incoming clients to spawn into.
    g_pending_host_start = true;
    g_host_thread_actually_started = false;
    mp_log( "[cdda-mp] MENU: host armed on port 8080 (thread deferred to do_turn)" );
    mp_update_window_title();
    return true;
}

void mp_menu_cancel_host()
{
    if( !g_pending_host_start && !is_host_mode() ) {
        return;
    }
    g_pending_host_start = false;
    set_host_mode( false );
    mp_log( "[cdda-mp] MENU: host-mode cancelled from co-op chooser" );
    mp_update_window_title();
}

// Defined here; declared extern in mp_gamestate.h.  main.cpp populates this
// at startup from the binary's mtime.
std::string g_mp_build_stamp = "?";

void mp_tick_proxy_activity( npc &guy )
{
    // No activity → nothing to do.  Most turns this is the no-op path.
    if( !guy.activity ) {
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

void mp_update_window_title()
{
    const char *role = is_client_mode() ? "CLIENT"
                       : ( is_host_mode() ? "HOST" : "SP" );
    // Include the commit hash (getVersionString) in the title bar too, matching
    // the main-menu version line, so a screenshot of any window shows the exact
    // build both players are running — the #1 thing co-op bug reports need.
    set_title( string_format( "CDDA co-op — %s — %s — build %s",
                              role, getVersionString(), g_mp_build_stamp ) );
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
             + ( g_partner_name_cached.empty() ? std::string( "<none connected>" )
                 : g_partner_name_cached ) + "\n";
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
    const std::vector<mod_id> default_mods = { mod_id( "dda" ) };
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
    return !players.empty();
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
    // One write per (process, world).  Resets when the loaded world changes.
    static std::string last_marked_world;
    if( last_marked_world == worldname ) {
        return;
    }
    last_marked_world = worldname;

    // Local-time string is fine; mp_world.json is human-readable, not parsed
    // for arithmetic.
    const std::time_t now = std::time( nullptr );
    char buf[32] = {0};
    std::strftime( buf, sizeof( buf ), "%Y-%m-%d %H:%M:%S",
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
    // Pre-flight TCP probe so a typo'd IP returns in ~3 s instead of hanging
    // on macOS's 75 s default SYN retry.  Only on success do we commit to
    // setting client_mode and running the real connect handshake.
    if( !tcp_probe( host, port, 3000 ) ) {
        popup( _( "Could not reach %s:%d.\n\nCheck the address, the host is running, and the port (default 8080) isn't blocked." ),
               host.c_str(), static_cast<int>( port ) );
        return false;
    }
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
    mp_update_window_title();

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
        if( g_pending_host_start && !g_host_thread_actually_started ) {
            return std::string( _( "Co-op: armed — re-enter Host to pick world / character" ) );
        }
        return std::string( _( "Co-op: hosting on port 8080 — waiting for partner" ) );
    }
    if( is_client_mode() ) {
        return std::string( _( "Co-op: connected to host — re-enter Join to pick character" ) );
    }
    return std::string();
}

// Check separation between two absolute positions and update g_separation_tier.
// Uses Chebyshev distance (same as rl_dist in 2D).  Tier thresholds, sized
// for the MAPSIZE=15 bubble (~84-tile radius).  Tier 3 is the auto-pause
// threshold; tier 2 is an 8-tile leeway zone above the warning so a driver
// at highway speed gets braking room before time freezes.
//   0 → 1 at ≥40 tiles  (mild warning)
//   1 → 2 at ≥60 tiles  (urgent — brake/turn around, 8 tiles of leeway)
//   2 → 3 at ≥68 tiles  (pause world clock until separation drops back)
//   3 → 2 at <63 tiles, 2 → 1 at <55, 1 → 0 at <34   (hysteresis)
static void check_separation_warning( const tripoint_abs_ms &a, const tripoint_abs_ms &b )
{
    const int dist = std::max( std::abs( a.x() - b.x() ), std::abs( a.y() - b.y() ) );
    // Don't warn until the pair has first been confirmed together this session,
    // so the spawn-far → teleport-close join sequence doesn't emit a spurious
    // "close the gap now" / "close enough again" pair before play even starts.
    if( !g_separation_settled ) {
        if( dist < 40 ) {
            g_separation_settled = true;
        }
        g_separation_tier = 0;
        return;
    }
    const int prev = g_separation_tier;
    if( dist >= 68 ) {
        g_separation_tier = 3;
    } else if( dist >= 60 ) {
        g_separation_tier = std::max( g_separation_tier, 2 );
    } else if( dist >= 40 ) {
        g_separation_tier = std::max( std::min( g_separation_tier, 2 ), 1 );
    } else if( dist < 34 ) {
        g_separation_tier = 0;
    } else if( dist < 55 ) {
        g_separation_tier = std::min( g_separation_tier, 1 );
    } else if( dist < 63 ) {
        g_separation_tier = std::min( g_separation_tier, 2 );
    }
    if( g_separation_tier != prev ) {
        if( g_separation_tier == 0 ) {
            add_msg( m_good, "You and your partner are close enough again." );
        } else if( g_separation_tier == 1 ) {
            add_msg( m_warning, "Your partner is getting far away (%d tiles). Max safe range is ~80.", dist );
        } else if( g_separation_tier == 2 ) {
            add_msg( m_bad,
                     "Your partner is near the edge of the simulated zone (%d tiles)! Brake or turn around.", dist );
        } else {
            add_msg( m_bad,
                     "Your partner is past the edge (%d tiles)! Vehicle physics will break — close the gap now.",
                     dist );
        }
    }
}

void process_mp_events()
{
    // If the menu armed host mode but the world wasn't loaded yet, the
    // listen-server thread was deferred until now.  Starts on the first
    // do_turn() after the avatar exists so a client connecting can actually
    // be spawned into a world.  No-op for --host CLI launches.
    mp_start_pending_host_thread();

    // Client: drain a budget of queued overmap-sync cells this turn (no-op when
    // nothing is pending). Keeps the ~32k-cell apply off the single-frame hot path.
    mp_drain_pending_omsync();

    // On the very first tick, purge any MP NPCs that leaked into the world save
    // from a previous session (server and client share the same world directory).
    mp_cleanup_stale_npcs();

    // Stamp this world as MP-touched so the world pickers can badge it.
    mp_world_marker_update();

    // Queue depth is intentionally capped at 1 game-turn action per call.
    // Draining the whole queue in a loop caused unexpected back-to-back move
    // execution when network timing let two packets arrive before
    // process_mp_events() ran.
    // State-sync messages (worn_sync, note_sync, trade_delta, templates_list,
    // resync_request, tile_changes) are protocol bookkeeping, not game turns —
    // they always drain regardless of depth. Only actions that advance the
    // lockstep turn count toward the depth-1 limit.
    // TODO(roadmap): real multi-depth queue for lockstep relaxation / input
    // buffering — see ROADMAP.md "Action queue depth"
    auto is_state_sync = []( const std::string & data ) {
        return data.find( R"("action":"worn_sync")" ) != std::string::npos
               || data.find( R"("type":"trade_delta")" ) != std::string::npos
               || data.find( R"("type":"note_sync")" ) != std::string::npos
               || data.find( R"("type":"chat")" ) != std::string::npos
               || data.find( R"("type":"templates_list")" ) != std::string::npos
               || data.find( R"("type":"resync_request")" ) != std::string::npos
               || data.find( "\"client_tile_changes\":" ) != std::string::npos;
    };
    mp_event event;
    bool turn_action_processed = false;
    while( get_mp_queue().pop( event ) ) {
        if( event.evt_type == mp_event::type::action ) {
            const bool sync = is_state_sync( event.data );
            if( !sync && turn_action_processed ) {
                mp_log( "[cdda-mp] process_mp_events: unexpected queued turn-action dropped: " +
                        event.data.substr( 0, 60 ) );
                continue;
            }
            mp_log( "[cdda-mp] process_mp_events: " + event.data.substr( 0, 60 ) );
        }
        switch( event.evt_type ) {
            case mp_event::type::connect:
                spawn_remote_player( event.session_id );
                break;
            case mp_event::type::disconnect:
                remove_remote_player();
                break;
            case mp_event::type::action:
                handle_remote_action( event.session_id, event.data );
                if( !is_state_sync( event.data ) ) {
                    turn_action_processed = true;
                }
                break;
        }
    }
}

static void apply_monster_sync( JsonObject &jo );
static void apply_tile_changes( JsonObject &jo );
static void apply_vehicle_sync( JsonObject &jo );

// Move the client avatar to an absolute position, loading the map chunk if needed.
static void client_teleport_avatar( const tripoint_abs_ms &abs_pos )
{
    avatar &u = get_avatar();
    map &m = get_map();

    const bool in = m.inbounds( abs_pos );
    mp_log( "[cdda-mp] teleport: target_abs=" + std::to_string( abs_pos.x() ) + "," +
            std::to_string( abs_pos.y() ) + " inbounds=" + std::to_string( in ) +
            " initial_done=" + std::to_string( g_initial_teleport_done ) +
            " avatar_abs=" + std::to_string( u.pos_abs().x() ) + "," +
            std::to_string( u.pos_abs().y() ) );

    if( !in ) {
        if( !g_initial_teleport_done ) {
            // Last chance to adopt the host's seed before the host-area overmap
            // is generated — in case 'welcome' was drained in this same batch.
            mp_client_apply_host_seed();
            mp_log( "[cdda-mp] teleport: -> place_player_overmap (initial) seed=" +
                    std::to_string( g->get_seed() ) );
            g->place_player_overmap( project_to<coords::omt>( abs_pos ), true );
            g_initial_teleport_done = true;
        } else {
            // The host moved out of the client's bubble and we already did the
            // one-time overmap placement, so we refuse to chase it.  If the
            // *initial* placement put us at the wrong spot (e.g. our own
            // scenario start instead of the host), this is where we get stranded
            // far from the partner — that's the "4560 tiles away" symptom.
            mp_log( "[cdda-mp] teleport: -> OUT OF BUBBLE, skip (avatar stays put)" );
            return;
        }
    } else {
        g_initial_teleport_done = true;
    }

    const tripoint_bub_ms new_pos = m.get_bub( abs_pos );
    if( new_pos != u.pos_bub() ) {
        // DIAGNOSTIC (resurrection #2): count live synced monsters before/after the
        // map reload to prove whether update_map silently unloads them (the suspected
        // source of MON-RESPAWN-DROPPED). Logs only when the count drops.
        int mons_before = 0;
        for( const auto &p : get_creature_tracker().get_monsters_list() ) {
            if( p && p->mp_net_id != 0 && !p->is_dead() ) {
                ++mons_before;
            }
        }
        if( new_pos.z() != u.pos_bub().z() ) {
            // Z-level change (ramp / bridge crossing).
            // 1. Place avatar on the destination tile FIRST (no gravity check
            //    yet — map z-submaps aren't loaded until after vertical_shift).
            // 2. Shift the map view so abs_sub.z() matches new_pos.z().
            // 3. update_map loads z=1 submaps; its own setpos fires gravity_check
            //    in the correct context (avatar on ramp deck, submaps loaded).
            mp_log( "[cdda-mp] teleport: -> setpos-then-vertical_shift z=" + std::to_string( new_pos.z() ) );
            u.setpos( m, new_pos, /*check_gravity=*/false );
            g->vertical_shift( new_pos.z() );
        } else {
            mp_log( "[cdda-mp] teleport: -> setpos+update_map z=" + std::to_string( new_pos.z() ) );
            u.setpos( m, new_pos );
        }
        g->update_map( u );
        int mons_after = 0;
        for( const auto &p : get_creature_tracker().get_monsters_list() ) {
            if( p && p->mp_net_id != 0 && !p->is_dead() ) {
                ++mons_after;
            }
        }
        if( mons_after < mons_before ) {
            mp_log( "[cdda-mp] TELE-MON-DROP: synced monsters " + std::to_string( mons_before ) +
                    " -> " + std::to_string( mons_after ) + " across update_map (delta=" +
                    std::to_string( mons_before - mons_after ) + ")" );
        }
    } else {
        mp_log( "[cdda-mp] teleport: -> already at target" );
    }
}

static void remove_client_host_npc()
{
    if( !client_host_npc_spawned ) {
        return;
    }
    // Clean despawn — the host left, they are NOT dead. die() would drop a
    // corpse carrying all their gear (a pickup-able loot dupe). Remove the
    // active copy and the overmap copy without a death.
    npc *host_npc = g->critter_by_id<npc>( client_host_npc_id );
    if( host_npc ) {
        g->remove_npc( client_host_npc_id );
    }
    if( client_host_npc_id.is_valid() ) {
        overmap_buffer.remove_npc( client_host_npc_id );
    }
    client_host_npc_spawned = false;
    client_host_npc_id = character_id();
    g_client_host_worn_sig.clear();
    mp_save_npc_ids();
}

static void update_client_host_npc( const tripoint_abs_ms &abs_pos, const std::string &name,
                                    bool host_in_vehicle, bool host_ctrl_veh )
{
    map &m = get_map();

    if( !client_host_npc_spawned ) {
        // Purge any stale host-proxy NPCs with the same name from old sessions.
        purge_npcs_by_name( name.empty() ? "host" : name );

        shared_ptr_fast<npc> host_npc = make_shared_fast<npc>();
        host_npc->normalize();
        host_npc->name = name.empty() ? "host" : name;
        host_npc->spawn_at_precise( abs_pos );
        overmap_buffer.insert_npc( host_npc );
        g->load_npcs();
        client_host_npc_id = host_npc->getID();
        client_host_npc_spawned = true;
        // Same orphan-resistance tag as the host's remote_player proxy.
        host_npc->set_value( "mp_proxy", std::string( "1" ) );
        mp_save_npc_ids();  // persist ID so next session can clean it up

        // Apply ally status AFTER load_npcs so the NPC is fully wired into the
        // game state (faction manager, critter tracker, etc.).
        npc *hn = g->critter_by_id<npc>( client_host_npc_id );
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

    npc *host_npc = g->critter_by_id<npc>( client_host_npc_id );
    if( !host_npc ) {
        // NPC left the reality bubble — still in overmap buffer, just not loaded.
        // Don't reset spawned state or we'll create a duplicate on the next tick.
        // If they're far enough to load, request a map reload in their direction.
        if( m.inbounds( abs_pos ) ) {
            // Back in bounds — the game will load_npcs() on the next do_turn pass.
            g->load_npcs();
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
        static std::string last_overlay;
        const std::string s = "recv_abs=" + abs_pos.to_string() +
                              " inbounds=" + std::to_string( host_inb ) +
                              " cur_bub=" + host_npc->pos_bub().to_string();
        if( s != last_overlay ) {
            last_overlay = s;
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

static bool apply_one_state_message( const std::string &msg )
{
    // Log a preview of every received packet so we can confirm moves=90 packets arrive.
    {
        const size_t preview_len = std::min( msg.size(), static_cast<size_t>( 120 ) );
        mp_log( "[cdda-mp] recv-packet: " + msg.substr( 0, preview_len ) );
    }
    // Server rejected our join — show the error and flag disconnect.
    if( msg.find( R"("type":"error")" ) != std::string::npos ) {
        const auto mpos = msg.find( R"("message":")" );
        std::string errtxt = "Server rejected connection.";
        if( mpos != std::string::npos ) {
            const size_t start = mpos + 11;
            const size_t end = msg.find( '"', start );
            if( end != std::string::npos ) {
                errtxt = msg.substr( start, end - start );
            }
        }
        mp_log( "[cdda-mp] SERVER ERROR: " + errtxt );
        popup( errtxt );
        return true;
    }

    // Join accepted. Carries the host's worldgen seed — adopt it before we
    // generate the host-area overmap so our base terrain (forests/lakes/rivers/
    // coast) matches the host's. Without this the client rolls its own random
    // seed in start_game() and renders a different map outside the tile-synced
    // bubble (the "different map until I got close" report, 2026-06-02).
    if( msg.find( R"("type":"welcome")" ) != std::string::npos ) {
        // Game-loop replay path (first do_turn): the engine seed is already
        // finalized, so adopt the host seed now. The connect-time path stashes
        // the same welcome earlier via mp_store_pending_welcome() so start_game
        // can act on it before worldgen.
        parse_welcome_fields( msg, /*apply_seed_now=*/true );
        return true;
    }

    // Server asks the client to re-send worn/hair after a respawn.
    if( msg.find( R"("type":"resync_request")" ) != std::string::npos ) {
        client_resync_worn();
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
            const int ox = jo.get_int( "ox" );
            const int oy = jo.get_int( "oy" );
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
            p.ox = ox;
            p.oy = oy;
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
                const int x0 = std::max( ox, ao.x() - PRIO_R );
                const int x1 = std::min( ox + w - 1, ao.x() + PRIO_R );
                const int y0 = std::max( oy, ao.y() - PRIO_R );
                const int y1 = std::min( oy + h - 1, ao.y() + PRIO_R );
                for( int yy = y0; yy <= y1; ++yy ) {
                    for( int xx = x0; xx <= x1; ++xx ) {
                        const int cur = ( yy - oy ) * w + ( xx - ox );
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
                for( auto it = g_pending_omsync.begin(); it != g_pending_omsync.end(); ) {
                    it = ( it->z == z ) ? g_pending_omsync.erase( it ) : std::next( it );
                }
                g_pending_omsync.push_back( std::move( p ) );
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
        const auto t0 = std::chrono::steady_clock::now();
        try {
            JsonValue jv = json_loader::from_string( msg );
            JsonObject jo = jv.get_object();
            jo.allow_omitted_members();
            const int z = jo.get_int( "z" );
            std::vector<std::string> pal;
            for( const JsonValue &pv : jo.get_array( "pal" ) ) {
                pal.push_back( pv.get_string() );
            }
            // A palette entry is only ever used as ter OR furn within a given
            // submap's t/f arrays; resolve both interpretations up front.
            std::vector<ter_id> ter_pal( pal.size() );
            std::vector<furn_id> furn_pal( pal.size() );
            std::vector<bool> ter_ok( pal.size(), false );
            std::vector<bool> furn_ok( pal.size(), false );
            for( size_t i = 0; i < pal.size(); ++i ) {
                const ter_str_id ts( pal[i] );
                if( ts.is_valid() ) {
                    ter_pal[i] = ts.id();
                    ter_ok[i] = true;
                }
                const furn_str_id fs( pal[i] );
                if( fs.is_valid() ) {
                    furn_pal[i] = fs.id();
                    furn_ok[i] = true;
                }
            }
            map &m = get_map();
            int applied = 0;
            int skipped = 0;
            auto decode = [&]( const JsonArray & arr, std::vector<int> &out ) {
                for( JsonValue rv : arr ) {
                    JsonArray run = rv.get_array();
                    const int cnt = run.get_int( 0 );
                    const int idx = run.get_int( 1 );
                    for( int k = 0; k < cnt; ++k ) {
                        out.push_back( idx );
                    }
                }
            };
            for( JsonValue sv : jo.get_array( "subs" ) ) {
                JsonObject so = sv.get_object();
                so.allow_omitted_members();
                const int sx = so.get_int( "sx" );
                const int sy = so.get_int( "sy" );
                const tripoint_abs_ms sm_ms0{ sx * SEEX, sy * SEEY, z };
                const tripoint_bub_ms bub0 = m.get_bub( sm_ms0 );
                if( !m.inbounds( bub0 ) ) {
                    ++skipped;   // outside this client's loaded bubble (far from host)
                    continue;
                }
                std::vector<int> tcells;
                std::vector<int> fcells;
                decode( so.get_array( "t" ), tcells );
                decode( so.get_array( "f" ), fcells );
                for( int ly = 0; ly < SEEY; ++ly ) {
                    for( int lx = 0; lx < SEEX; ++lx ) {
                        const int ci = ly * SEEX + lx;
                        const tripoint_bub_ms bub{ bub0.x() + lx, bub0.y() + ly, bub0.z() };
                        if( ci < static_cast<int>( tcells.size() ) ) {
                            const int pi = tcells[ci];
                            if( pi >= 0 && pi < static_cast<int>( ter_ok.size() ) && ter_ok[pi] ) {
                                m.ter_set( bub, ter_pal[pi] );
                            }
                        }
                        if( ci < static_cast<int>( fcells.size() ) ) {
                            const int pi = fcells[ci];
                            if( pi >= 0 && pi < static_cast<int>( furn_ok.size() ) && furn_ok[pi] ) {
                                m.furn_set( bub, furn_pal[pi] );
                            }
                        }
                    }
                }
                ++applied;
            }
            if( applied > 0 ) {
                m.invalidate_map_cache( z );
                g->invalidate_main_ui_adaptor();
            }
            const long apply_ms = std::chrono::duration_cast<std::chrono::milliseconds>(
                                      std::chrono::steady_clock::now() - t0 ).count();
            mp_log( "[cdda-mp] MAPSYNC recv: applied=" + std::to_string( applied ) +
                    " skipped=" + std::to_string( skipped ) +
                    " pal=" + std::to_string( pal.size() ) +
                    " ms=" + std::to_string( apply_ms ) );
        } catch( const JsonError &e ) {
            mp_log( "[cdda-mp] MAPSYNC parse error: " + std::string( e.what() ) );
        }
        return true;
    }

    // Host died gracefully — show once and stop processing further packets.
    if( msg.find( R"("type":"host_died")" ) != std::string::npos ) {
        if( !g_server_died ) {
            g_server_died = true;
            remove_client_host_npc();
            add_msg( m_bad, "Your partner has died.  Waiting for them to respawn..." );
        }
        return true;
    }

    // Graceful session-end notification from the host (v1 save handshake).
    // Host has saved their world; the client's local .sav isn't written by
    // the current architecture, so this is messaging-only on this side.
    // After this the server socket will close shortly — the existing
    // disconnect handler takes over from there.
    if( msg.find( R"("type":"session_ending")" ) != std::string::npos ) {
        mp_log( "[cdda-mp] SESSION-END RECV: host is leaving" );
        add_msg( m_warning, _( "Your partner is leaving.  The session will end shortly." ) );
        return true;
    }

    // Co-op save handshake: the host saved the shared world at our request.
    if( msg.find( R"("type":"save_done")" ) != std::string::npos ) {
        mp_log( "[cdda-mp] SAVE-DONE RECV: host saved the shared world" );
        add_msg( m_good,
                 _( "The host saved the shared world — your progress is in sync.  (Your inventory isn't fully mirrored to the host yet — known limitation.)" ) );
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

    // Trade delta: the host traded with our proxy — apply item changes to our
    // real avatar so items don't vanish when the next worn_sync overwrites the proxy.
    if( msg.find( R"("type":"trade_delta")" ) != std::string::npos ) {
        try {
            JsonValue jv = json_loader::from_string( msg );
            JsonObject jo = jv.get_object();
            jo.allow_omitted_members();
            avatar &av = get_avatar();
            // DIAG (pass-item deadlock, temp): capture the client's grant/move/ack
            // state when a pass/trade is applied. The host hangs in SRV-WAIT after a
            // pass-in-vehicle because the client ends at moves<=0 + queued move + no
            // ack. This handler doesn't touch moves itself, so we want to see whether
            // moves are already 0 here (grant lost / spent elsewhere) and whether an
            // ack is pending. Pair with CLI-GRANT / CLI-DRAIN-END.
            mp_log( "[cdda-mp] TRADE-APPLY: moves=" + std::to_string( av.get_moves() ) +
                    " ack=" + std::to_string( is_client_waiting_for_ack() ) +
                    " ms_since_grant=" + std::to_string( ms_since_last_grant() ) + "ms" );
            // "give" = items the host gave to our proxy → add to our avatar
            if( jo.has_array( "give" ) ) {
                for( const JsonValue &iv : jo.get_array( "give" ) ) {
                    JsonObject io = iv.get_object();
                    io.allow_omitted_members();
                    item tmp;
                    tmp.deserialize( io );
                    av.i_add( tmp );
                    mp_log( "[cdda-mp] trade_delta: gained " + tmp.typeId().str() );
                }
            }
            // "take" = items taken from our proxy → remove from our avatar
            if( jo.has_array( "take" ) ) {
                for( const JsonValue &iv : jo.get_array( "take" ) ) {
                    JsonObject io = iv.get_object();
                    io.allow_omitted_members();
                    item tmp;
                    tmp.deserialize( io );
                    const itype_id tid = tmp.typeId();
                    bool found = false;
                    av.remove_items_with( [&tid, &found]( const item & i ) {
                        if( !found && i.typeId() == tid ) {
                            found = true;
                            return true;
                        }
                        return false;
                    }, 1 );
                    mp_log( "[cdda-mp] trade_delta: lost " + tid.str()
                            + ( found ? " (ok)" : " (NOT FOUND)" ) );
                }
            }
        } catch( const JsonError &e ) {
            mp_log( std::string( "[cdda-mp] trade_delta parse error: " ) + e.what() );
        }
        return true;
    }

    const bool is_state = msg.find( R"("type":"state")" ) != std::string::npos ||
                          msg.find( R"("type": "state")" ) != std::string::npos;
    if( !is_state ) {
        std::cout << "[cdda-mp] " << msg << std::endl;
        return false;
    }
    if( msg.find( "\"connected\":false" ) != std::string::npos ) {
        if( !g_server_died ) {
            g_server_died = true;
            remove_client_host_npc();
            add_msg( m_bad, "Lost connection to server." );
        }
        return true;
    }

    try {
        mp_log( "[cdda-mp] STATE-APPLY: parse (" + std::to_string( msg.size() ) + " bytes) start" );
        JsonValue jv = json_loader::from_string( msg );
        JsonObject jo = jv.get_object();
        jo.allow_omitted_members();
        mp_log( "[cdda-mp] STATE-APPLY: parse done" );

        // Sync host's calendar turn so the client sees the correct time, lighting, and weather.
        if( jo.has_int( "calendar_turn" ) ) {
            calendar::turn = time_point( jo.get_int( "calendar_turn" ) );
        }

        if( jo.has_object( "pos" ) ) {
            mp_apply_step _s( "teleport" );
            JsonObject pos = jo.get_object( "pos" );
            pos.allow_omitted_members();
            g_mp_remote_pos = tripoint_abs_ms{
                pos.get_int( "x" ), pos.get_int( "y" ), pos.get_int( "z" )
            };
            client_teleport_avatar( g_mp_remote_pos );
        }

        std::string host_name;
        jo.read( "host_name", host_name );
        if( !host_name.empty() ) {
            g_partner_name_cached = host_name;
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

        // Track the host's current activity for HUD + partner-notice display.
        if( jo.has_string( "host_activity" ) ) {
            g_partner_activity = jo.get_string( "host_activity" );
            mp_partner_activity_transition_check();
        }
        if( jo.has_int( "host_activity_pct" ) ) {
            const int new_pct = jo.get_int( "host_activity_pct" );
            // ASSIST-DISPLAY diag: when does the client actually receive a fresh
            // host pct vs. when its screen redraws?  Change-gated.
            if( new_pct != g_partner_activity_pct ) {
                mp_log( "[cdda-mp] ASSIST-PCT: client recv host_activity_pct=" +
                        std::to_string( new_pct ) );
            }
            g_partner_activity_pct = new_pct;
        }
        if( jo.has_int( "host_activity_moves_total" ) ) {
            g_partner_activity_moves_total = jo.get_int( "host_activity_moves_total" );
        }
        if( jo.has_int( "host_morale" ) ) {
            g_partner_morale = jo.get_int( "host_morale" );
        }
        if( jo.has_int( "host_hp_cur" ) ) {
            g_partner_hp_cur = jo.get_int( "host_hp_cur" );
        }
        if( jo.has_int( "host_hp_max" ) ) {
            g_partner_hp_max = jo.get_int( "host_hp_max" );
        }
        // Ping (CLIENT ONLY — the host adopts the mirrored client_rtt instead,
        // since subtracting our stamp against the host's clock would be garbage).
        // Measure RTT only when the echo matches the stamp we're currently
        // awaiting, then clear it: a host re-echoing the same stamp during idle
        // must not keep growing the number against an ever-advancing clock.
        if( is_client_mode() && jo.has_int( "host_ping_echo" ) ) {
            const int64_t stamp = jo.get_int( "host_ping_echo" );
            if( stamp >= 0 && stamp == g_pending_ping_stamp ) {
                g_partner_ping_ms = static_cast<int>( mp_mono_ms() - stamp );
                g_pending_ping_stamp = -1; // consumed; hold this value until next send
            }
        }
        // Snapshot host's calendar BEFORE the local sync above overwrites it,
        // so the panel can show drift = local - last_received_partner.  Since
        // the client sets local = host on every state packet, drift here is
        // the gap between packets — useful sanity indicator.
        if( jo.has_int( "calendar_turn" ) ) {
            g_partner_calendar_turn = jo.get_int( "calendar_turn" );
        }

        // Host→client tap-on-shoulder: cancel local wait activity if the
        // host's bump menu invoked Tap. Only ACT_WAIT variants are
        // interruptible at this stage (sleep / crafting / reading are left
        // alone). The host already side-emitted the appropriate add_msg on
        // its side; we add the symmetric message here so the client sees
        // who tapped them.
        if( jo.has_bool( "wake_client" ) && jo.get_bool( "wake_client" ) ) {
            avatar &u = get_avatar();
            static const activity_id s_act_wait( "ACT_WAIT" );
            static const activity_id s_act_wait_stamina( "ACT_WAIT_STAMINA" );
            static const activity_id s_act_wait_weather( "ACT_WAIT_WEATHER" );
            static const activity_id s_act_wait_npc( "ACT_WAIT_NPC" );
            const activity_id cur = u.activity.id();
            const bool was_waiting = cur == s_act_wait || cur == s_act_wait_stamina ||
                                     cur == s_act_wait_weather || cur == s_act_wait_npc;
            mp_log( "[cdda-mp] CLI-WAKE: was_waiting=" + std::to_string( was_waiting ) +
                    " activity=" + cur.str() );
            if( was_waiting ) {
                u.cancel_activity();
                std::string host_name = _( "Your partner" );
                if( client_host_npc_id.is_valid() ) {
                    if( npc *hnpc = g->critter_by_id<npc>( client_host_npc_id ) ) {
                        host_name = hnpc->get_name();
                    }
                }
                add_msg( _( "%s taps you on the shoulder, snapping you out of your wait." ),
                         host_name );
            }
        }

        // Host→client swap/push: the host did the action locally and flagged it
        // here.  Render the observer message locally from the host proxy's real
        // name so it always reads "<host> swaps places with you." — no relayed
        // text, no POV rewriting, robust even when both players share a name.
        if( ( jo.has_bool( "partner_swapped" ) && jo.get_bool( "partner_swapped" ) ) ||
            ( jo.has_bool( "partner_pushed" ) && jo.get_bool( "partner_pushed" ) ) ) {
            std::string host_name = _( "Your partner" );
            if( client_host_npc_id.is_valid() ) {
                if( npc *hnpc = g->critter_by_id<npc>( client_host_npc_id ) ) {
                    host_name = hnpc->get_name();
                }
            }
            mp_log( "[cdda-mp] DIAG cli-render: proxy='" + host_name + "' own_av='" +
                    get_avatar().name + "'" );
            if( jo.has_bool( "partner_swapped" ) && jo.get_bool( "partner_swapped" ) ) {
                add_msg( _( "%s swaps places with you." ), host_name );
            }
            if( jo.has_bool( "partner_pushed" ) && jo.get_bool( "partner_pushed" ) ) {
                add_msg( _( "%s pushes you out of the way." ), host_name );
            }
        }

        if( jo.has_float( "host_light" ) || jo.has_int( "host_light" ) ) {
            g_mp_host_luminance = static_cast<float>( jo.get_float( "host_light" ) );
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

            if( sig != g_client_host_worn_sig && client_host_npc_spawned ) {
                mp_apply_step _dress( "dress-host-npc" );
                g_client_host_worn_sig = sig;
                npc *host_npc = g->critter_by_id<npc>( client_host_npc_id );
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
        if( jo.has_string( "host_move_mode" ) && client_host_npc_spawned ) {
            npc *host_npc = g->critter_by_id<npc>( client_host_npc_id );
            if( host_npc ) {
                const move_mode_id mode_id( jo.get_string( "host_move_mode" ) );
                if( mode_id.is_valid() ) {
                    host_npc->move_mode = mode_id;
                }
            }
        }

        // Sync host facing direction for correct sprite flip.
        if( jo.has_int( "host_facing" ) && client_host_npc_spawned ) {
            npc *host_npc = g->critter_by_id<npc>( client_host_npc_id );
            if( host_npc ) {
                host_npc->facing = jo.get_int( "host_facing" ) == 0
                                   ? FacingDirection::LEFT : FacingDirection::RIGHT;
            }
        }

        // Apply the host's active effects to the proxy so its status + overhead
        // markers (bleeding, etc.) match the host. NOT signature-gated — effects
        // change every turn. Full-state: clear then re-add the host's current set
        // (empty array correctly clears, e.g. host stopped bleeding).
        if( jo.has_array( "host_effects" ) && client_host_npc_spawned ) {
            npc *host_npc = g->critter_by_id<npc>( client_host_npc_id );
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
        if( jo.has_array( "host_hp" ) && client_host_npc_spawned ) {
            npc *host_npc = g->critter_by_id<npc>( client_host_npc_id );
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
                const auto prev_it = g_last_bodypart_hp.find( bp_str );
                ++n_parts;
                // Synthesise a "you were hit" message from HP deltas — but only
                // when the previous baseline was a *valid* HP (<= this part's
                // current max).  A baseline above max predates a max-HP
                // recompute: the proxy NPC spawns at NPC-default HP, then
                // recomputes to this character's real max and clamps current
                // down.  That clamp is not combat damage; counting it made the
                // client cry "You are hit for 204 damage!" on join with no
                // attacker (confirmed 2026-06-02: all parts 105->88/max95).
                if( prev_it != g_last_bodypart_hp.end() && new_hp < prev_it->second
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
                g_last_bodypart_hp[bp_str] = new_hp;
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
                add_msg( m_bad, "You are hit for %d damage!", total_damage );
            } else if( recompute_sig ) {
                mp_log( "[cdda-mp] BP-DAMAGE-SYNTH: suppressed uniform recompute (all "
                        + std::to_string( n_parts ) + " parts -" + std::to_string( first_delta )
                        + ")" );
            }
        }

        // "free":true means this isn't a turn-ending action.  Two cases:
        //  - Wall bump or refused action (moves<=0 broadcast, free=true)
        //  - Partial-turn update like pldrive that consumed only some AP and
        //    left budget for more driving inputs (moves>0, free=true).
        // Clear the ack guard so the restored/partial moves value is accepted
        // by the seq-bypassed path further down.
        const bool is_partial_turn = jo.has_bool( "free" ) && jo.get_bool( "free" );
        if( is_partial_turn ) {
            g_client_waiting_for_ack = false;
        }

        const uint32_t grant_seq = jo.has_int( "grant_seq" )
                                   ? static_cast<uint32_t>( jo.get_int( "grant_seq" ) ) : 0;

        // Apply server-authoritative move budget.
        // Two guards prevent double-application:
        //  1. ack guard: we sent an action and are waiting for the server's moves=0 ack
        //  2. seq guard: grant_seq <= last seen means this is a TCP-buffered duplicate
        // Safety: force-clear ack guard after 5 s to recover from any stuck state.
        if( g_client_waiting_for_ack ) {
            using namespace std::chrono_literals;
            if( std::chrono::steady_clock::now() - g_ack_set_time > 5s ) {
                mp_log( "[cdda-mp] ack guard timed out — force-clearing" );
                g_client_waiting_for_ack = false;
            }
        }
        if( jo.has_member( "moves" ) ) {
            const int srv_moves = jo.get_int( "moves" );
            // Refresh the "last heard from host" timestamp on any moves-bearing
            // state message (grants AND ack-clears).
            g_last_grant_time = std::chrono::steady_clock::now();
            if( is_partial_turn && srv_moves > 0 ) {
                // Partial-turn update from host (e.g., pldrive consumed some AP
                // but left budget).  Bypass the seq guard — this isn't a fresh
                // grant, the host hasn't advanced the calendar.  Just sync the
                // remaining AP so the client can issue more driving inputs.
                mp_log( "[cdda-mp] CLI-PARTIAL: moves=" + std::to_string( srv_moves ) );
                get_avatar().set_moves( srv_moves );
            } else if( srv_moves <= 0 ) {
                // ACK: server confirmed our action was received.  Always apply.
                mp_log( "[cdda-mp] CLI-ACK-CLEAR: moves=" + std::to_string( srv_moves ) +
                        " seq=" + std::to_string( grant_seq ) +
                        " ack_was=" + std::to_string( g_client_waiting_for_ack ) +
                        " last_seq=" + std::to_string( g_client_last_grant_seq ) );
                g_client_waiting_for_ack = false;
                get_avatar().set_moves( srv_moves );
            } else if( ( !g_client_waiting_for_ack || get_avatar().activity ) &&
                       ( grant_seq == 0 || grant_seq > g_client_last_grant_seq ) ) {
                // New grant: seq is fresh AND (no pending ack OR avatar is in an
                // activity).  The activity-override bypasses the ack guard so
                // long activities (drop, read, craft) don't stall when grants
                // arrive faster than the client can ack — the activity is the
                // pacing authority during a passive activity, not the
                // handshake.  Seq guard still prevents stale replays.
                if( grant_seq > 0 ) {
                    g_client_last_grant_seq = grant_seq;
                }
                const player_activity &ca = get_avatar().activity;
                mp_log( "[cdda-mp] CLI-GRANT: moves=" + std::to_string( srv_moves ) +
                        " seq=" + std::to_string( grant_seq ) +
                        " act=" + ( ca ? ca.id().str() : "none" ) +
                        " override_ack=" + std::to_string( ca && g_client_waiting_for_ack ) );
                // If we overrode the ack guard for an activity, clear it now so
                // the next dispatch isn't suppressed by stale state.
                if( ca && g_client_waiting_for_ack ) {
                    g_client_waiting_for_ack = false;
                }
                get_avatar().set_moves( srv_moves );
                g_last_grant_time = std::chrono::steady_clock::now();
                // If the client is in any long activity, ack the grant
                // immediately with a "wait" action.  Without this, multiple
                // host grants pile up in the same process_mp_events drain and
                // only one gets acked per do_turn, so the host races ahead via
                // SAFETY-TIMEOUT and calendars desync.  Setting the ack guard
                // here also causes subsequent grants in the same drain to take
                // the CLI-SKIP branch, providing proper backpressure so the
                // host advances at the client's pace.
                if( ca && !is_passive_activity( ca.id().str() ) ) {
                    // Interactive activity (ACT_AIM, ACT_FIRSTAID, ACT_AUTOATTACK,
                    // ACT_AUTODRIVE): its do_turn opens a BLOCKING UI (e.g. aiming's
                    // target_ui via mode_fire).  Ticking it here — inside
                    // client_process_incoming, during network-message processing —
                    // ran that UI re-entrantly and crashed (target_ui::run /
                    // ~display_buffer_draw_scope) and froze before.  Do NOT tick it;
                    // the main do_turn act loop drives it in a valid UI context and
                    // dispatches its own wait when moves are consumed.  Moves were
                    // already set above from the grant.
                    mp_log( "[cdda-mp] CLI-GRANT: interactive act=" + ca.id().str() +
                            " deferred to main loop (no incoming-path tick)" );
                } else if( ca ) {
                    // Any passive player_activity in MP is a long action: it needs
                    // one tick per host grant, and we must ack the grant before
                    // the next message in this drain (the host's ack-clear) zeroes
                    // our moves.  Covers `|` wait, crafting, reading, butchering,
                    // mining, construction, repair, etc. — every activity_actor.
                    const std::string pre_tick_id = ca.id().str();
                    const int pre_tick_moves = get_avatar().get_moves();
                    const int pre_tick_moves_left = ca.moves_left;
                    get_avatar().activity.do_turn( get_avatar() );
                    const int post_tick_moves = get_avatar().get_moves();
                    const player_activity &post_ca = get_avatar().activity;
                    const int post_tick_moves_left = post_ca ? post_ca.moves_left : 0;
                    // If the activity completed during this tick, emit the
                    // explicit end signal BEFORE the wait so the host clears
                    // its lockstep-bypass state and the wait closes the turn.
                    // do_turn's outer activity_just_ended detector misses this
                    // case because pre_activity_id is captured AFTER
                    // client_process_incoming runs.
                    if( !get_avatar().activity ) {
                        g_client_turn_activity.clear();
                        client_send_activity_end( pre_tick_id );
                    }
                    mp_log( "[cdda-mp] CLI-GRANT-ACT-ACK: id=" + pre_tick_id
                            + " moves " + std::to_string( pre_tick_moves ) + "->" + std::to_string( post_tick_moves )
                            + " moves_left " + std::to_string( pre_tick_moves_left ) + "->" + std::to_string(
                                post_tick_moves_left )
                            + " ended=" + std::to_string( !get_avatar().activity )
                            + " grant_seq=" + std::to_string( grant_seq ) );
                    client_send( client_enrich_action(
                                     R"({"type":"action","action":"wait"})" ) );
                    g_client_waiting_for_ack = true;
                    g_ack_set_time = std::chrono::steady_clock::now();
                    // Mirror the host's per-turn redraw so the client's HUD
                    // (time, activity %, environmental messages) ticks live
                    // while the activity runs.  Without this, do_turn never
                    // exits to the main game loop's redraw path during a long
                    // activity.
                    g->invalidate_main_ui_adaptor();
                }
            } else {
                // Stale: ack pending or seq already seen.
                mp_log( "[cdda-mp] CLI-SKIP: moves=" + std::to_string( srv_moves ) +
                        " seq=" + std::to_string( grant_seq ) + "/" +
                        std::to_string( g_client_last_grant_seq ) +
                        " ack=" + std::to_string( g_client_waiting_for_ack ) +
                        " reason=" + ( g_client_waiting_for_ack ? "ack-pending" : "old-seq" ) );
            }
        }

        // Handle "keep smashing" continuation based on server bash result.
        if( jo.has_string( "smash_result" ) ) {
            const std::string sr = jo.get_string( "smash_result" );
            // Play the bash animation on the client if the server sent target coords.
            if( jo.has_int( "smash_x" ) && jo.has_int( "smash_y" ) && jo.has_int( "smash_z" ) ) {
                const tripoint_abs_ms abs_smash{
                    jo.get_int( "smash_x" ), jo.get_int( "smash_y" ), jo.get_int( "smash_z" )
                };
                map &here = get_map();
                if( here.inbounds( abs_smash ) ) {
                    const tripoint_bub_ms bub = here.get_bub( abs_smash );
                    if( sr == "destroyed" ) {
                        g->draw_async_anim( bub, "bash_complete", "X", c_light_gray );
                    } else if( sr == "hit" ) {
                        g->draw_async_anim( bub, "bash_effective", "/", c_light_gray );
                    } else if( sr == "impossible" ) {
                        g->draw_async_anim( bub, "bash_ineffective" );
                    }
                }
            }
            if( sr == "hit" ) {
                // Partial bash. If already auto-smashing, re-queue immediately.
                // Otherwise DEFER the "Keep smashing?" prompt — query_yn opens a
                // blocking popup, and running it here (inside apply_one_state_message,
                // i.e. network-message processing) is the same re-entrant-UI crash
                // class as the aim bug.  client_resolve_pending_ui() (main do_turn
                // loop) asks it in a valid context.
                if( g_client_autosmash ) {
                    if( !g_client_autosmash_json.empty() ) {
                        g_autosmash_pending = true;
                    }
                } else {
                    g_client_smash_query_pending = true;
                }
            } else {
                // Destroyed, impossible, or failed — stop auto-smashing.
                g_client_autosmash = false;
                g_client_autosmash_json.clear();
            }
        }

        // Sync authoritative client stats from the server's NPC proxy.
        // The server is the source of truth for stamina, move_mode, and vehicle control —
        // it drains proxy stamina during movement and manages controlling_vehicle.
        g_client_ctrl_veh = jo.get_bool( "client_ctrl_veh", false );
        if( jo.has_object( "client_veh_pos" ) ) {
            JsonObject cvp = jo.get_object( "client_veh_pos" );
            cvp.allow_omitted_members();
            g_client_ctrl_veh_abs = tripoint_abs_ms{
                cvp.get_int( "x" ), cvp.get_int( "y" ), cvp.get_int( "z" )
            };
        } else {
            g_client_ctrl_veh_abs = tripoint_abs_ms{ 0, 0, 0 };
        }
        if( jo.has_string( "client_move_mode" ) ) {
            const move_mode_id mode_id( jo.get_string( "client_move_mode" ) );
            get_avatar().move_mode = mode_id;
            // Do NOT cancel desired_move_mode here — that would nuke a pending run/crouch
            // toggle the player just pressed before this state packet arrived.
            // The commit in handle_action already calls cancel_desired when set_movement_mode
            // fails (e.g. on stamina exhaustion), so no-op cancellation is redundant.
        }

        // Mirror authoritative grab + hauling state onto the local avatar so
        // SP code paths (rendering, move-cost gating, status indicators) read
        // the same values the host enforces. Only re-apply when the value
        // actually differs to avoid spamming avatar::grab's map-memory refresh.
        if( jo.has_int( "client_grab_type" ) ) {
            const int gt = jo.get_int( "client_grab_type" );
            const int dx = jo.get_int( "client_grab_dx", 0 );
            const int dy = jo.get_int( "client_grab_dy", 0 );
            const int dz = jo.get_int( "client_grab_dz", 0 );
            avatar &av = get_avatar();
            const object_type new_type = static_cast<object_type>( gt );
            const tripoint_rel_ms new_pt( dx, dy, dz );
            if( av.get_grab_type() != new_type || av.grab_point != new_pt ) {
                av.grab( new_type, new_pt );
                mp_log( "[cdda-mp] CLI-GRAB-APPLY: type=" + std::to_string( gt ) +
                        " offset=(" + std::to_string( dx ) + "," + std::to_string( dy ) +
                        "," + std::to_string( dz ) + ")" );
            }
        }
        if( jo.has_bool( "client_hauling" ) ) {
            const bool host_hauling = jo.get_bool( "client_hauling" );
            avatar &av = get_avatar();
            if( av.is_hauling() != host_hauling ) {
                av.toggle_hauling();
                mp_log( "[cdda-mp] CLI-HAUL-APPLY: hauling=" +
                        std::to_string( host_hauling ) );
            }
        }
        // Display forwarded combat messages from the host (hits, misses, kills).
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
            g_client_msg_watermark = Messages::size();
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

void client_resolve_pending_ui()
{
    // Drains blocking UI deferred out of the network-recv path (apply_one_state_
    // message).  MUST be called from the main do_turn loop, where a top-level UI
    // context is valid — never from inside packet processing.
    if( g_client_smash_query_pending ) {
        g_client_smash_query_pending = false;
        g_client_autosmash = query_yn( _( "Keep smashing until destroyed?" ) );
        if( g_client_autosmash && !g_client_autosmash_json.empty() ) {
            g_autosmash_pending = true;
        }
    }
}

void client_process_incoming()
{
    // After the host has died (or the socket dropped), drain the queue silently
    // and do nothing else — prevents the lost-connection spam.
    if( g_server_died ) {
        std::string msg;
        while( client_recv_pop( msg ) ) {}
        return;
    }

    mp_cleanup_stale_npcs();
    mp_cull_local_npcs();   // drop client-local phantom NPCs (keep only host proxy)

    // Send the join message on the first tick — the save is loaded by now.
    const bool was_joined = client_join_is_sent();
    client_send_join();
    if( !was_joined && client_join_is_sent() ) {
        // Just sent the join — clear any stale ack/seq state from a previous session
        // so the server's first move grant isn't silently ignored after reconnect.
        g_client_waiting_for_ack = false;
        g_client_last_grant_seq = 0;
        // Immediately follow with our worn-item list and skin tone.
        client_resync_worn();
        // Templates wire-sync: send local template list so the host can request
        // anything it's missing.  Host sends its own list independently.
        mp_templates_sync_on_join();
    }
    std::string msg;
    int recv_count = 0;
    while( client_recv_pop( msg ) ) {
        ++recv_count;
        const auto m_pos = msg.find( "\"moves\":" );
        const std::string moves_str = ( m_pos != std::string::npos )
                                      ? msg.substr( m_pos, 16 ) : "no-moves";
        const int pre_apply_moves = get_avatar().get_moves();
        mp_log( "[cdda-mp] CLI-RECV#" + std::to_string( recv_count ) + ": " + moves_str +
                " pre_apply_moves=" + std::to_string( pre_apply_moves ) );
        apply_one_state_message( msg );
        const int post_apply_moves = get_avatar().get_moves();
        if( post_apply_moves != pre_apply_moves ) {
            mp_log( "[cdda-mp] CLI-RECV#" + std::to_string( recv_count ) +
                    ": moves changed " + std::to_string( pre_apply_moves ) + "->" +
                    std::to_string( post_apply_moves ) +
                    " autosmash=" + std::to_string( g_autosmash_pending ) );
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
                                " ack=" + std::to_string( g_client_waiting_for_ack ) +
                                " last_seq=" + std::to_string( g_client_last_grant_seq );
        static std::string last;
        if( msg != last ) {
            mp_log( msg );
            last = msg;
        }
    }
    // Auto-fire pending autosmash when a grant arrives and no ack is outstanding.
    if( g_autosmash_pending && !g_client_autosmash_json.empty() &&
        get_avatar().get_moves() > 0 && !g_client_waiting_for_ack ) {
        g_autosmash_pending = false;
        client_send( g_client_autosmash_json );
        // FIX #4 (smash stamina): mirror SP avatar::smash on each continued swing.
        // Autosmash only re-fires while the target is still bashable, so every re-fire
        // is a successful swing — burn unconditionally here (manual smash burns in
        // handle_action.cpp's ACTION_SMASH block, gated on is_bashable).
        get_avatar().burn_energy_arms( 2 * get_avatar().get_standard_stamina_cost() );
        mp_log( "[cdda-mp] CLI-AUTOSMASH: sending smash, moves=" +
                std::to_string( get_avatar().get_moves() ) +
                " stam=" + std::to_string( get_avatar().get_stamina() ) );
        get_avatar().set_moves( 0 );
        g_client_waiting_for_ack = true;
        g_ack_set_time = std::chrono::steady_clock::now();
    }
    // Warn if the client is drifting too far from the host's reality bubble center.
    // is_valid() rejects negative IDs but MP proxy NPCs have negative IDs — check
    // the raw value instead so the client-side warning actually fires.
    if( client_host_npc_id.get_value() != 0 ) {
        npc *hnpc = g->critter_by_id<npc>( client_host_npc_id );
        if( hnpc ) {
            check_separation_warning( get_avatar().pos_abs(), hnpc->pos_abs() );
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
        const auto r0 = std::chrono::steady_clock::now();
        g->invalidate_main_ui_adaptor();
        const auto r1 = std::chrono::steady_clock::now();
        ui_manager::redraw();
        const auto r2 = std::chrono::steady_clock::now();
        refresh_display();
        const auto r3 = std::chrono::steady_clock::now();
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

// Scan tiles around the client avatar for field changes (blood, etc.) since the
// last action was sent.  Returns a JSON array of changed tile entries suitable
// for inclusion as "client_tile_changes" in an action packet.
static std::string build_client_tile_changes( int radius = 10 )
{
    const avatar &av = get_avatar();
    const tripoint_abs_ms center = av.pos_abs();
    map &m = get_map();
    std::string out = "[";
    bool first = true;

    for( int dy = -radius; dy <= radius; ++dy ) {
        for( int dx = -radius; dx <= radius; ++dx ) {
            const tripoint_abs_ms abs{ center.x() + dx, center.y() + dy, center.z() };
            if( !m.inbounds( abs ) ) {
                continue;
            }
            const tripoint_bub_ms bub = m.get_bub( abs );

            // Terrain + furniture — baseline-gated.
            const std::string ter_str  = m.ter( bub ).id().str();
            const std::string furn_str = m.furn( bub ).id().str();
            const std::string terfurn_sig = ter_str + '|' + furn_str;
            auto &terfurn_baseline = g_client_terfurn_baseline[abs];
            const bool terfurn_changed = ( terfurn_baseline != terfurn_sig );
            if( terfurn_changed ) {
                terfurn_baseline = terfurn_sig;
            }

            // Items — baseline-gated so we only send when the tile changes.
            // Full item serialize() is used so nested pocket contents are included.
            std::string items_sig;
            std::string items_json = "[]";
            auto items = m.i_at( bub );
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
            auto &item_baseline = g_client_item_baseline[abs];
            const bool items_changed = ( item_baseline != items_sig );
            if( items_changed ) {
                item_baseline = items_sig;
                if( !items_sig.empty() ) {
                    mp_log( "[cdda-mp] client tile items @ " +
                            std::to_string( abs.x() ) + "," +
                            std::to_string( abs.y() ) + "," +
                            std::to_string( abs.z() ) );
                }
            }

            // Fields — baseline-gated.  Host owns field simulation (dust,
            // smoke, blood spread/decay); the only fields the host doesn't
            // already know about are ones the client *created* this turn via
            // an action.  Forwarding host-observed fields back to the host
            // was producing ~100 entries per turn while the partner sat in
            // ACT_WAIT and blocking the host's input pump.
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
            auto &field_baseline = g_client_field_baseline[abs];
            const bool fields_changed = ( field_baseline != fields_sig );
            if( fields_changed ) {
                field_baseline = fields_sig;
            }

            // Trap — baseline-gated. Skip terrain-builtin traps (e.g. downspout funnel
            // on t_gutter_downspout); the peer derives those from the terrain itself,
            // and re-applying via trap_set triggers a debugmsg.
            const trap &tr_here = m.tr_at( bub );
            const trap_id &builtin_here = m.ter( bub )->trap;
            const bool is_builtin_c = !tr_here.is_null() && tr_here.loadid == builtin_here;
            const std::string trap_sig_c = ( tr_here.is_null() || is_builtin_c ) ? "" : tr_here.id.str();
            auto &trap_baseline = g_client_trap_baseline[abs];
            const bool trap_changed = ( trap_baseline != trap_sig_c );
            if( trap_changed ) {
                trap_baseline = trap_sig_c;
            }

            // Graffiti — baseline-gated.
            const std::string graffiti_sig_c = m.has_graffiti_at( bub ) ? m.graffiti_at( bub ) : "";
            auto &graffiti_baseline = g_client_graffiti_baseline[abs];
            const bool graffiti_changed = ( graffiti_baseline != graffiti_sig_c );
            if( graffiti_changed ) {
                graffiti_baseline = graffiti_sig_c;
            }

            // Partial construction — baseline-gated.  The counter changes each
            // turn during a build, so this re-sends the build tile every turn
            // (one tile, cheap) until the construction completes.
            const std::string partial_con_sig_c = mp_partial_con_sig( bub );
            const bool has_pc_c = m.partial_con_at( bub ) != nullptr;
            auto &pc_baseline = g_client_partial_con_baseline[abs];
            const bool pc_changed = ( pc_baseline != partial_con_sig_c );
            const bool had_pc_c = !pc_baseline.empty();
            if( pc_changed ) {
                pc_baseline = partial_con_sig_c;
            }

            if( !terfurn_changed && !items_changed && !fields_changed &&
                !trap_changed && !graffiti_changed && !pc_changed ) {
                continue;
            }

            if( !first ) {
                out += ',';
            }
            first = false;
            out += "{\"x\":" + std::to_string( abs.x() )
                   + ",\"y\":" + std::to_string( abs.y() )
                   + ",\"z\":" + std::to_string( abs.z() );
            if( terfurn_changed ) {
                out += R"(,"ter":")" + ter_str + R"(","furn":")" + furn_str + "\"";
            }
            if( items_changed ) {
                out += ",\"items\":" + items_json;
            }
            if( fields_changed ) {
                out += ",\"fields\":" + fields_json;
            }
            if( trap_changed ) {
                out += R"(,"trap":")" + ( trap_sig_c.empty() ? std::string( "tr_null" ) : trap_sig_c ) + "\"";
            }
            if( graffiti_changed ) {
                out += R"(,"graffiti":")" + json_escape_str( graffiti_sig_c ) + "\"";
            }
            if( pc_changed ) {
                if( has_pc_c ) {
                    out += ",\"partial_con\":" + mp_partial_con_obj_json( bub );
                } else if( had_pc_c ) {
                    out += ",\"partial_con_remove\":true";
                }
            }
            out += "}";
        }
    }
    out += ']';
    return out;
}

// Scan vehicle cargo parts near the client avatar for item changes since the
// last action was sent.  Each entry identifies the cargo by its tile abs
// position; the host looks up the vehicle at that tile and updates its cargo.
// Mirrors build_client_tile_changes() for vehicle cargo storage so drops into
// trunks/freezers/lockers (and the SP fall-through to ground if the cargo is
// full) sync over the wire the same way ground drops do.
static std::string build_client_veh_cargo_changes( int radius = 12 )
{
    const avatar &av = get_avatar();
    const tripoint_abs_ms center = av.pos_abs();
    map &m = get_map();
    std::string out = "[";
    bool first = true;

    for( const wrapped_vehicle &wv : m.get_vehicles() ) {
        vehicle *v = wv.v;
        if( !v ) {
            continue;
        }
        // Cheap reject: skip vehicles whose root is far from the avatar.
        if( std::abs( v->pos_abs().x() - center.x() ) > radius + 20 ||
            std::abs( v->pos_abs().y() - center.y() ) > radius + 20 ||
            v->pos_abs().z() != center.z() ) {
            continue;
        }
        for( const vpart_reference &vp : v->get_any_parts( VPFLAG_CARGO ) ) {
            const tripoint_bub_ms vp_bub = vp.pos_bub( m );
            const tripoint_abs_ms vp_abs = m.get_abs( vp_bub );
            if( std::abs( vp_abs.x() - center.x() ) > radius ||
                std::abs( vp_abs.y() - center.y() ) > radius ) {
                continue;
            }
            std::string items_sig;
            std::string items_json = "[";
            bool ifirst = true;
            for( const item &it : v->get_items( vp.part() ) ) {
                const std::string item_json = serialize( it );
                items_sig += item_json + ',';
                if( !ifirst ) {
                    items_json += ',';
                }
                ifirst = false;
                items_json += item_json;
            }
            items_json += "]";
            auto &baseline = g_client_veh_cargo_baseline[vp_abs];
            if( baseline == items_sig ) {
                continue; // no change since last send
            }
            baseline = items_sig;
            mp_log( "[cdda-mp] client veh cargo @ " +
                    std::to_string( vp_abs.x() ) + "," +
                    std::to_string( vp_abs.y() ) + "," +
                    std::to_string( vp_abs.z() ) +
                    " items_sig_len=" + std::to_string( items_sig.size() ) );
            if( !first ) {
                out += ',';
            }
            first = false;
            out += "{\"x\":" + std::to_string( vp_abs.x() )
                   + ",\"y\":" + std::to_string( vp_abs.y() )
                   + ",\"z\":" + std::to_string( vp_abs.z() )
                   + ",\"items\":" + items_json + "}";
        }
    }
    out += ']';
    return out;
}

// Build JSON array of monsters the client damaged since the last server sync.
// Uses g_last_monster_hp (last server-reported HP) as the baseline.
static std::string build_client_monster_hits()
{
    std::string hits;
    bool first = true;
    for( const auto &ptr : get_creature_tracker().get_monsters_list() ) {
        monster *mon = ptr.get();
        if( !mon || mon->mp_net_id == 0 ) {
            // Diagnostic for the "killed a zed, it rose again" report: a monster
            // the client killed in its own local world that the host never
            // assigned a net id to is never reported — the host keeps it alive
            // and re-broadcasts it, resurrecting the client's corpse.
            if( mon && mon->is_dead() && mon->mp_net_id == 0 ) {
                mp_log( "[cdda-mp] CLIENT-KILL-UNSYNCED: '" + mon->name() +
                        "' died locally with mp_net_id==0 — not reported to host" );
            }
            continue;
        }
        const auto it = g_last_monster_hp.find( mon->mp_net_id );
        if( it == g_last_monster_hp.end() ) {
            continue;
        }
        const int client_hp = mon->is_dead() ? 0 : mon->get_hp();
        if( client_hp >= it->second ) {
            continue;
        }
        if( client_hp <= 0 ) {
            // Client killed this synced monster locally. Mark it so the next few
            // host broadcasts (still showing it alive, kill not yet processed)
            // don't respawn it — see apply_monster_sync's spawn guard (GH#1).
            g_client_pending_kill[mon->mp_net_id] = CLIENT_PENDING_KILL_SYNCS;
        }
        if( !first ) {
            hits += ',';
        }
        first = false;
        hits += "{\"nid\":" + std::to_string( mon->mp_net_id )
                + ",\"hp\":" + std::to_string( client_hp ) + "}";
    }
    return first ? std::string() : ( "[" + hits + "]" );
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
    if( cur <= g_client_msg_watermark ) {
        g_client_msg_watermark = cur;
        return;
    }
    const auto new_msgs = Messages::recent_messages( static_cast<size_t>( cur -
                          g_client_msg_watermark ) );
    g_client_msg_watermark = cur;
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
            out = client_name + " " + rest;
        } else {
            // "Now reading X" → "Roy is now reading X"
            out = client_name + " is " + out;
        }
        mp_addressee_to_you( out, client_name );   // partner's name → "you" (guarded)
        g_client_msgs_pending.push_back( out );
    }
}

std::string client_enrich_action( const std::string &json )
{
    const avatar &av = get_avatar();
    client_capture_avatar_msgs();

    std::string bleed_json = "[";
    bool bleed_first = true;
    for( const bodypart_id &bp : av.get_all_body_parts() ) {
        const int intensity = av.get_effect_int( effect_bleed, bp );
        if( intensity > 0 ) {
            if( !bleed_first ) {
                bleed_json += ',';
            }
            bleed_first = false;
            bleed_json += R"({"bp":")" + bp.id().str() +
                          R"(","intensity":)" + std::to_string( intensity ) + "}";
        }
    }
    bleed_json += "]";

    const float cl = av.active_light();
    const std::string tile_changes = build_client_tile_changes();
    const std::string veh_cargo_changes = build_client_veh_cargo_changes();

    // Worn-list baseline check: if the avatar's worn list (or wielded item)
    // changed since the last send, fire a worn_sync packet so the host's NPC
    // proxy reflects the new worn state.  Captures drops that peel garments
    // off, take_off, wear, and any other worn-mutating activity.  Baseline
    // includes type + variant + wielded id so a swap (drop X, wear Y) flips
    // the signature.
    {
        std::vector<const item *> worn_items;
        av.worn.inv_dump( worn_items );
        std::string worn_sig;
        for( const item *it : worn_items ) {
            worn_sig += it->typeId().str();
            if( it->has_itype_variant() ) {
                worn_sig += '|';
                worn_sig += it->itype_variant().id;
            }
            worn_sig += ',';
        }
        item_location wielded = av.get_wielded_item();
        worn_sig += ';';
        if( wielded ) {
            worn_sig += wielded->typeId().str();
            // Include ammo count so firing (which doesn't change typeId) still
            // triggers a worn_sync carrying the updated full-item serialization.
            worn_sig += ':';
            worn_sig += std::to_string( wielded->ammo_remaining() );
        }
        // Include carried weight and item count so that pocket-content changes
        // trigger a worn_sync even when worn list and wielded item are unchanged.
        // Weight alone misses weight-neutral swaps (drop X kg, pick up X kg →
        // same weight, proxy goes stale until next weight change).
        worn_sig += '|';
        worn_sig += std::to_string( av.weight_carried().value() );
        worn_sig += '/';
        worn_sig += std::to_string( av.inv->size() );
        if( worn_sig != g_client_worn_baseline ) {
            g_client_worn_baseline = worn_sig;
            client_resync_worn();
        }
    }

    // Build char_stats block: base stats, all skills, and known proficiencies.
    // Applied server-side to the NPC proxy so pldrive(), melee, etc. use real values.
    std::string char_stats = "{";
    // Carry the client's real character name so the host can rename the proxy
    // (spawned with the "player2" placeholder, since the client connects from
    // the main menu before its character exists). Renames the on-map @ and the
    // sidebar nearby-list; messages already use the real name from packets.
    char_stats += R"("name":")" + av.get_name() + "\",";
    char_stats += "\"str\":" + std::to_string( av.get_str_base() );
    char_stats += ",\"dex\":" + std::to_string( av.get_dex_base() );
    char_stats += ",\"int\":" + std::to_string( av.get_int_base() );
    char_stats += ",\"per\":" + std::to_string( av.get_per_base() );
    char_stats += ",\"skills\":[";
    bool first_s = true;
    for( const auto &[sid, slevel] : av.get_all_skills() ) {
        const int lvl = slevel.level();
        if( lvl <= 0 ) {
            continue;
        }
        if( !first_s ) {
            char_stats += ',';
        }
        first_s = false;
        char_stats += "[\"" + sid.str() + "\"," + std::to_string( lvl ) + "]";
    }
    char_stats += "],\"profs\":[";
    bool first_p = true;
    for( const proficiency_id &pid : av.known_proficiencies() ) {
        if( !first_p ) {
            char_stats += ',';
        }
        first_p = false;
        char_stats += "\"" + pid.str() + "\"";
    }
    char_stats += "]}";

    std::string enriched = json;
    if( !enriched.empty() && enriched.back() == '}' ) {
        enriched.pop_back();
        enriched += ",\"client_light\":" + std::to_string( cl );
        enriched += ",\"client_bleed\":" + bleed_json;
        enriched += ",\"client_tile_changes\":" + tile_changes;
        if( veh_cargo_changes != "[]" ) {
            enriched += ",\"client_veh_cargo_changes\":" + veh_cargo_changes;
        }
        enriched += ",\"client_stamina\":" + std::to_string( av.get_stamina() );
        const std::string monster_hits = build_client_monster_hits();
        if( !monster_hits.empty() ) {
            enriched += ",\"client_monster_hits\":" + monster_hits;
        }
        enriched += ",\"char_stats\":" + char_stats;
        enriched += ",\"client_facing\":" + std::to_string(
                        av.facing == FacingDirection::LEFT ? 0 : 1 );
        // Sync current activity id for HUD/messaging and as a heartbeat for
        // the host's lockstep bypass.  Primary signals are the explicit
        // activity_start / activity_end actions emitted in assign_activity /
        // do_turn — this field is belt-and-suspenders so a missed lifecycle
        // packet still gets reconciled on the next normal action.  Refresh
        // from live av.activity when present so an activity assigned mid-turn
        // is reflected here too.
        if( av.activity ) {
            g_client_turn_activity = av.activity.id().str();
        }
        const std::string client_act_id = g_client_turn_activity;
        enriched += R"(,"client_activity":")" + client_act_id + "\"";
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
            g_pending_ping_stamp = stamp;
            enriched += ",\"client_ping\":" + std::to_string( stamp );
            enriched += ",\"client_rtt\":" + std::to_string( g_partner_ping_ms );
        }
        if( !g_client_msgs_pending.empty() ) {
            std::string msgs = "[";
            bool first_m = true;
            for( const std::string &m : g_client_msgs_pending ) {
                if( !first_m ) {
                    msgs += ',';
                }
                first_m = false;
                msgs += "\"" + json_escape_str( m ) + "\"";
            }
            msgs += "]";
            enriched += ",\"client_msgs\":" + msgs;
            g_client_msgs_pending.clear();
        }
        enriched += '}';
    }
    return enriched;
}

// Client-side post-grab dispatcher.  Called by the handle_action.cpp wrapper
// around the SP grab() handler.  The SP function already ran on the client,
// mutating the local avatar's grab state — we just need to forward the delta
// to the host so its proxy NPC mirrors it.  No-op when state didn't change
// (user cancelled the direction prompt) or when not in client mode.
void mp_client_dispatch_grab_if_changed( object_type pre_type,
        const tripoint_rel_ms &pre_point )
{
    if( !is_client_mode() ) {
        return;
    }
    avatar &av = get_avatar();
    if( av.get_grab_type() == pre_type && av.grab_point == pre_point ) {
        return;
    }
    const std::string json =
        std::string( R"({"type":"action","action":"grab",)" ) +
        "\"grab_type\":" + std::to_string( static_cast<int>( av.get_grab_type() ) ) +
        ",\"dx\":" + std::to_string( av.grab_point.x() ) +
        ",\"dy\":" + std::to_string( av.grab_point.y() ) +
        ",\"dz\":" + std::to_string( av.grab_point.z() ) + "}";
    const bool had_grant = av.get_moves() > 0;
    mp_log( std::string( "[cdda-mp] CLI-GRAB-SEND type=" ) +
            std::to_string( static_cast<int>( av.get_grab_type() ) ) +
            " offset=(" + std::to_string( av.grab_point.x() ) + "," +
            std::to_string( av.grab_point.y() ) + ") path=" +
            ( had_grant && !is_client_waiting_for_ack() ? "SEND" : "DROP" ) );
    if( had_grant && !is_client_waiting_for_ack() ) {
        client_send( client_enrich_action( json ) );
        av.set_moves( 0 );
        client_mark_action_sent();
    }
}

// Client-side post-haul dispatcher.  Parallel to the grab one — the SP
// haul()/haul_toggle() handlers already toggled is_hauling on the local
// avatar; we forward the toggle to the host.
void mp_client_dispatch_hauling_if_changed( bool pre_hauling )
{
    if( !is_client_mode() ) {
        return;
    }
    avatar &av = get_avatar();
    if( av.is_hauling() == pre_hauling ) {
        return;
    }
    const std::string json = R"({"type":"action","action":"toggle_haul"})";
    const bool had_grant = av.get_moves() > 0;
    mp_log( std::string( "[cdda-mp] CLI-HAUL-SEND hauling=" ) +
            std::to_string( av.is_hauling() ) + " path=" +
            ( had_grant && !is_client_waiting_for_ack() ? "SEND" : "DROP" ) );
    if( had_grant && !is_client_waiting_for_ack() ) {
        client_send( client_enrich_action( json ) );
        av.set_moves( 0 );
        client_mark_action_sent();
    }
}

void set_client_turn_activity( const std::string &activity_id_str )
{
    g_client_turn_activity = activity_id_str;
}

const std::string &get_client_turn_activity()
{
    return g_client_turn_activity;
}

float get_host_luminance()
{
    return g_mp_host_luminance;
}

float get_remote_player_luminance()
{
    return g_mp_remote_player_luminance;
}

character_id get_host_npc_character_id()
{
    return client_host_npc_id;
}

character_id get_remote_player_npc_character_id()
{
    return remote_player_npc_id;
}

void client_resync_worn()
{
    avatar &av = get_avatar();
    std::vector<item *> worn_items;
    av.worn.inv_dump( worn_items );

    // Send ALL active mutations — chargen cosmetics (skin/hair/eye) plus
    // physical mutations (Fangs, Sleek Fur, Spines, Feathered Arms, etc.) —
    // so the host's NPC proxy renders with the full set of visual overlays.
    // Receiver does a full state sync: clears its own mutations then applies
    // this list.
    std::string appearance_json = "[";
    bool afirst = true;
    for( const trait_and_var &tv : av.get_mutations_variants() ) {
        const mutation_branch &mb = tv.trait.obj();
        std::string first_type;
        if( !mb.types.empty() ) {
            first_type = *mb.types.begin();
        }
        if( !afirst ) {
            appearance_json += ',';
        }
        afirst = false;
        appearance_json += R"({"type":")" + first_type
                           + R"(","id":")" + tv.trait.str() + "\"";
        if( !tv.variant.empty() ) {
            appearance_json += R"(,"var":")" + tv.variant + "\"";
        }
        appearance_json += '}';
    }
    appearance_json += ']';

    std::string worn_json = R"({"action":"worn_sync","worn":[)";
    bool wfirst = true;
    for( const item *it : worn_items ) {
        if( !wfirst ) {
            worn_json += ',';
        }
        wfirst = false;
        // Full item serialization — carries pocket contents (bandages in jacket,
        // camera in fanny pack, etc.) through to the host's proxy NPC so the
        // trade menu and skill checks see the real carried items.
        std::ostringstream woss;
        {
            JsonOut wout( woss );
            it->serialize( wout );
        }
        worn_json += woss.str();
    }
    std::string wielded_type;
    std::string wielded_obj_json = "null";
    item_location wielded = av.get_wielded_item();
    if( wielded ) {
        wielded_type = wielded->typeId().str();
        // Full item serialization carries ammo, mods, charges, contents — so the
        // host's proxy mirrors the actual wielded weapon, not a pristine spawn.
        std::ostringstream oss;
        {
            JsonOut out( oss );
            wielded->serialize( out );
        }
        wielded_obj_json = oss.str();
    }
    // Serialize the client's main (non-worn, non-wielded) inventory so the host's
    // proxy NPC mirrors tools, books, guns-in-bag, etc. for trade / skill checks.
    std::string inv_json;
    {
        std::ostringstream inv_oss;
        {
            JsonOut inv_out( inv_oss );
            av.inv->json_save_items( inv_out );
        }
        inv_json = inv_oss.str();
    }
    const std::string male_str = av.male ? "true" : "false";
    const std::string ma_style_str = av.martial_arts_data->selected_style().str();
    worn_json += "],\"male\":" + male_str
                 + ",\"appearance\":" + appearance_json
                 + R"(,"wielded":")" + wielded_type + "\""
                 + ",\"wielded_obj\":" + wielded_obj_json
                 + ",\"client_inv\":" + inv_json
                 + R"(,"ma_style":")" + ma_style_str + "\"}";
    mp_log( "[cdda-mp] worn_sync send: inv_items=" + std::to_string( av.inv->size() )
            + " inv_bytes=" + std::to_string( inv_json.size() ) );
    client_send( worn_json );
}

void client_mark_action_sent()
{
    mp_log( "[cdda-mp] CLI-ACK-SET: ack guard SET, was=" + std::to_string( g_client_waiting_for_ack ) +
            " last_seq=" + std::to_string( g_client_last_grant_seq ) );
    g_client_waiting_for_ack = true;
    g_ack_set_time = std::chrono::steady_clock::now();
}

bool is_client_waiting_for_ack()
{
    return g_client_waiting_for_ack;
}

void mp_client_post_action( int pre_moves )
{
    if( !is_client_mode() ) {
        return;
    }
    if( get_avatar().get_moves() >= pre_moves ) {
        return;
    }
    client_resync_worn();
    client_send( client_enrich_action( R"({"type":"action","action":"wait"})" ) );
    get_avatar().set_moves( 0 );
    client_mark_action_sent();
}

int ms_since_last_grant()
{
    using namespace std::chrono;
    return static_cast<int>(
               duration_cast<milliseconds>( steady_clock::now() - g_last_grant_time ).count() );
}

bool client_render_can_throttle()
{
    return is_client_mode() && static_cast<bool>( get_avatar().activity );
}

bool client_ctrl_veh()
{
    return g_client_ctrl_veh;
}

void set_client_ctrl_veh( bool b )
{
    g_client_ctrl_veh = b;
    if( !b ) {
        g_client_ctrl_veh_abs = tripoint_abs_ms{ 0, 0, 0 };
    }
}

tripoint_abs_ms client_ctrl_veh_abs()
{
    return g_client_ctrl_veh_abs;
}

void client_set_autosmash_json( const std::string &json )
{
    // Clear any existing auto-smash state so a new manual smash starts fresh.
    g_client_autosmash = false;
    g_client_autosmash_json = json;
}

void client_dispatch_wait_for_activity( const activity_id &pre_id, bool force_idle )
{
    if( g_client_waiting_for_ack ) {
        mp_log( "[cdda-mp] dispatch_wait: ack pending, skip" );
        return;
    }
    const player_activity &pact = get_avatar().activity;
    const activity_id &id = pact ? pact.id() : pre_id;
    if( !id && !force_idle ) {
        mp_log( "[cdda-mp] dispatch_wait: no activity, skip" );
        return;
    }
    // Fast-forward mode: when both sides are in passive activities, host has
    // dropped its strict-lockstep wait (see wait_for_client_action).  We
    // skip the wait dispatch too — sending one would just queue against the
    // host's already-bypassed wait and waste a TCP round-trip.  The host's
    // next grant arrives at near-SP-tick speed and ticks our activity locally.
    if( should_fast_forward() ) {
        mp_log( "[cdda-mp] dispatch_wait: FAST-FORWARD, skip wait for act=" +
                ( id ? id.str() : "idle" ) );
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
    if( !is_client_mode() || activity_id_str.empty() ) {
        return;
    }
    const std::string json = "{\"type\":\"action\",\"action\":\"activity_start\","
                             "\"activity_id\":\"" + activity_id_str + "\"}";
    const player_activity &cur = get_avatar().activity;
    mp_log( "[cdda-mp] ACT-START SEND: id=" + activity_id_str
            + " g_client_turn_activity=" + g_client_turn_activity
            + " av.activity=" + ( cur ? cur.id().str() : "none" )
            + " moves=" + std::to_string( get_avatar().get_moves() ) );
    client_send( json );
}

void client_send_activity_end( const std::string &activity_id_str )
{
    if( !is_client_mode() ) {
        return;
    }
    const std::string json = "{\"type\":\"action\",\"action\":\"activity_end\","
                             "\"activity_id\":\"" + activity_id_str + "\"}";
    const player_activity &cur = get_avatar().activity;
    mp_log( "[cdda-mp] ACT-END SEND: id=" + activity_id_str
            + " g_client_turn_activity=" + g_client_turn_activity
            + " av.activity=" + ( cur ? cur.id().str() : "none" )
            + " ack=" + std::to_string( g_client_waiting_for_ack )
            + " moves=" + std::to_string( get_avatar().get_moves() ) );
    client_send( json );
}

// Compute the tile baseline signature from current authoritative map state.
// Used by build_tile_changes to detect change vs last broadcast, and by the
// client_tile_changes apply handler to refresh the baseline after applying
// client-supplied state — without that refresh, the next build_tile_changes
// would re-broadcast the same state back, causing an item/field round-trip
// loop with the client (uids drift through deserialize → broadcast → apply,
// fueling a per-turn 80 KB ping-pong while the partner sits in ACT_WAIT).
// MP construction sync.  A partial construction (in-progress build site: frame +
// consumed components + a progress counter) lives in the submap's
// partial_constructions map, NOT in the per-tile snapshot — so before this it was
// invisible to the other player even though the % rode the activity packet.  These
// helpers serialize/apply it alongside the tile snapshot in BOTH directions
// (host map_sync + client_tile_changes), since construction runs on both sides.

// Stable fingerprint: construction id + counter (drives per-turn % updates) +
// component count (covers start/finish).  Empty when no build site here.
static std::string mp_partial_con_sig( const tripoint_bub_ms &bub )
{
    const partial_con *pc = get_map().partial_con_at( bub );
    if( !pc ) {
        return std::string();
    }
    return pc->id.obj().id.str() + ':' + std::to_string( pc->counter ) + ':' +
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
           std::to_string( pc->counter ) + ",\"components\":" + comp_json + "}";
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
    const int counter = po.get_int( "counter", 0 );
    map &m = get_map();
    if( partial_con *existing = m.partial_con_at( bub ) ) {
        existing->counter = counter;
        existing->id = con_sid.id();
        return;
    }
    partial_con pc;
    pc.id = con_sid.id();
    pc.counter = counter;
    if( po.has_array( "components" ) ) {
        for( const JsonValue &iv : po.get_array( "components" ) ) {
            try {
                item comp;
                JsonObject io = iv.get_object();
                io.allow_omitted_members();
                comp.deserialize( io );
                if( !comp.typeId().is_empty() && comp.typeId().is_valid() ) {
                    pc.components.push_back( std::move( comp ) );
                }
            } catch( const JsonError & ) {}
        }
    }
    m.partial_con_set( bub, pc );
}

static mp_tile_state compute_tile_state( const tripoint_abs_ms &abs )
{
    mp_tile_state st;
    map &m = get_map();
    if( !m.inbounds( abs ) ) {
        return st;
    }
    const tripoint_bub_ms bub = m.get_bub( abs );

    st.ter  = m.ter( bub ).id().str();
    st.furn = m.furn( bub ).id().str();

    for( const item &it : m.i_at( bub ) ) {
        st.items_sig += serialize( it ) + ',';
    }

    const field &fld = m.field_at( bub );
    if( fld.field_count() > 0 ) {
        for( const auto &[ftype, fentry] : fld ) {
            if( !fentry.is_field_alive() ) {
                continue;
            }
            st.fields_sig += ftype.id().str() + ':' +
                             std::to_string( fentry.get_field_intensity() ) + ',';
        }
    }

    const trap &tr = m.tr_at( bub );
    const trap_id &builtin = m.ter( bub )->trap;
    const bool is_builtin = !tr.is_null() && tr.loadid == builtin;
    st.trap_sig = ( tr.is_null() || is_builtin ) ? "" : tr.id.str();

    st.graffiti_sig = m.has_graffiti_at( bub ) ? m.graffiti_at( bub ) : "";

    st.partial_con_sig = mp_partial_con_sig( bub );

    return st;
}

// Server: scan the sync area and emit tile entries whose ter/furn/items changed since last broadcast.
static std::string build_tile_changes( const tripoint_abs_ms &center, int radius )
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
            auto items = m.i_at( bub );
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

            auto &baseline = g_tile_baseline[abs];
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
                   + ",\"z\":" + std::to_string( abs.z() )
                   + R"(,"ter":")" + ter_str + "\""
                   + R"(,"furn":")" + furn_str + "\""
                   + ",\"items\":" + items_json
                   + ",\"fields\":" + fields_json
                   + R"(,"trap":")" + ( trap_sig.empty() ? "tr_null" : trap_sig ) + "\""
                   + R"(,"graffiti":")" + json_escape_str( graffiti_sig ) + "\"";
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

static std::string build_monster_list( const tripoint_abs_ms &center, int radius )
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
    static int s_keyframe_ctr = 0;
    const bool keyframe = s_force_keyframe || ( s_keyframe_ctr++ % KEYFRAME_INTERVAL ) == 0;
    if( keyframe ) {
        g_server_mon_last_sent.clear();
    }

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
        const int dx = std::abs( mp.x() - center.x() );
        const int dy = std::abs( mp.y() - center.y() );
        if( dx > radius || dy > radius || mp.z() != center.z() ) {
            // Diagnostic: a monster inside the reality bubble (≤84) but outside
            // this broadcast radius is NOT sent, so the client culls it
            // (MON-SYNC cull) even though it's alive on the host — the "monster
            // died for no reason near the players" bug. The broadcast is centered
            // on the client PROXY, which lags the real client, so the window can
            // sit off the monsters the client sees.
            if( mp.z() == center.z() && dx <= 84 && dy <= 84 ) {
                excluded_near += mon_ptr->type->id.str() + "@d" +
                                 std::to_string( std::max( dx, dy ) ) + " ";
            }
            continue;
        }
        // Assign a stable network ID the first time this monster enters sync range.
        // Done for EVERY in-radius monster (even ones we delta-omit below) so the
        // removed_monsters diff (g_server_mon_known_nids) stays accurate.
        if( mon_ptr->mp_net_id == 0 ) {
            mon_ptr->mp_net_id = ++g_next_net_id;
        }
        const uint32_t nid = mon_ptr->mp_net_id;
        seen_nids.insert( nid );
        const int mon_facing = ( mon_ptr->facing == FacingDirection::LEFT ) ? 0 : 1;
        std::string rec = "{\"nid\":" + std::to_string( nid )
                          + R"(,"id":")" + mon_ptr->type->id.str() + "\""
                          + ",\"x\":" + std::to_string( mp.x() )
                          + ",\"y\":" + std::to_string( mp.y() )
                          + ",\"z\":" + std::to_string( mp.z() )
                          + ",\"hp\":" + std::to_string( mon_ptr->get_hp() )
                          + ",\"facing\":" + std::to_string( mon_facing ) + "}";
        // Delta gate: emit only if new or changed since last broadcast. nid + id
        // are stable, so an identical record string means x/y/z/hp/facing are all
        // unchanged → the client already holds this exact state, omit it.
        auto cached = g_server_mon_last_sent.find( nid );
        if( cached != g_server_mon_last_sent.end() && cached->second == rec ) {
            ++n_skipped;
            continue;
        }
        g_server_mon_last_sent[nid] = rec;
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
    if( g_server_mon_last_sent.size() > seen_nids.size() ) {
        for( auto it = g_server_mon_last_sent.begin(); it != g_server_mon_last_sent.end(); ) {
            it = seen_nids.count( it->first ) ? std::next( it )
                 : g_server_mon_last_sent.erase( it );
        }
    }
    // Log only when the excluded-near set changes — this fires every broadcast
    // while a distant monster lingers in the 40–84 band and would otherwise spam.
    static std::string s_last_excluded_near;
    if( excluded_near != s_last_excluded_near ) {
        s_last_excluded_near = excluded_near;
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
    static int s_last_n_sent = -1;
    if( n_sent != s_last_n_sent ) {
        s_last_n_sent = n_sent;
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
            auto existing = m.i_at( bub );
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
                        m.add_item( bub, std::move( new_item ) );
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
        // cancelled).  Keeps the client's g_client_partial_con_baseline in step so
        // it doesn't echo the host's construction straight back.
        if( to.has_object( "partial_con" ) ) {
            mp_apply_partial_con_obj( bub, to.get_object( "partial_con" ) );
            g_client_partial_con_baseline[abs] = mp_partial_con_sig( bub );
        } else if( to.get_bool( "partial_con_remove", false ) ) {
            if( m.partial_con_at( bub ) ) {
                m.partial_con_remove( bub );
            }
            g_client_partial_con_baseline[abs] = std::string();
        }

        // Refresh client→server baselines to match the state we just installed
        // from the host.  Without this, the next build_client_tile_changes
        // re-serializes the items/ter/etc., compares to a stale baseline,
        // marks "changed", and ships them back to the host — fueling an 80 KB
        // per-turn round-trip while the avatar sits in ACT_WAIT.  Computed
        // from current map state (not the JSON we received) so the sig
        // matches what build_client_tile_changes will produce.
        {
            const ter_id &cur_ter = m.ter( bub );
            const furn_id &cur_furn = m.furn( bub );
            g_client_terfurn_baseline[abs] = cur_ter.id().str() + '|' + cur_furn.id().str();

            std::string cur_items_sig;
            for( const item &it : m.i_at( bub ) ) {
                cur_items_sig += serialize( it ) + ',';
            }
            g_client_item_baseline[abs] = cur_items_sig;

            std::string cur_fields_sig;
            const field &cur_fld = m.field_at( bub );
            if( cur_fld.field_count() > 0 ) {
                for( const auto &[ftype, fentry] : cur_fld ) {
                    if( !fentry.is_field_alive() ) {
                        continue;
                    }
                    cur_fields_sig += ftype.id().str() + ':' +
                                      std::to_string( fentry.get_field_intensity() ) + ',';
                }
            }
            g_client_field_baseline[abs] = cur_fields_sig;

            const trap &cur_tr = m.tr_at( bub );
            const trap_id &cur_builtin = m.ter( bub )->trap;
            const bool cur_is_builtin = !cur_tr.is_null() && cur_tr.loadid == cur_builtin;
            g_client_trap_baseline[abs] =
                ( cur_tr.is_null() || cur_is_builtin ) ? "" : cur_tr.id.str();

            g_client_graffiti_baseline[abs] =
                m.has_graffiti_at( bub ) ? m.graffiti_at( bub ) : "";
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

    // Process host-reported removals first: any nid the host no longer tracks
    // (folded, fully destroyed, driven out of bubble) should be torn down on
    // the client to mirror SP's map::destroy_vehicle.  Done before the apply
    // loop so a vehicle removed-and-replaced in the same broadcast doesn't
    // collide with its successor at the same tile.
    if( jo.has_array( "removed_vehicles" ) ) {
        for( const JsonValue &rv : jo.get_array( "removed_vehicles" ) ) {
            const auto rnid = static_cast<uint32_t>( rv.get_int() );
            auto pos_it = g_client_veh_pos.find( rnid );
            if( pos_it == g_client_veh_pos.end() ) {
                continue;
            }
            const tripoint_abs_ms rabs = pos_it->second;
            g_client_veh_pos.erase( pos_it );
            if( !m.inbounds( rabs ) ) {
                continue;
            }
            const optional_vpart_position vp = m.veh_at( m.get_bub( rabs ) );
            if( !vp ) {
                continue;
            }
            vehicle &dveh = vp->vehicle();
            mp_log( "[cdda-mp] CLI-VEH-REMOVE: nid=" + std::to_string( rnid )
                    + " abs=" + std::to_string( rabs.x() )
                    + "," + std::to_string( rabs.y() )
                    + "," + std::to_string( rabs.z() )
                    + " name=\"" + dveh.name + "\"" );
            m.destroy_vehicle( &dveh );
        }
    }

    const VehicleList vehs = m.get_vehicles();

    // Authoritative positions of every host vehicle in this broadcast.
    // vehicle_step lists ALL host vehicles, so this is the complete set; used
    // after the apply loop to cull client-local phantom vehicles.
    std::vector<tripoint_abs_ms> host_veh_positions;

    for( const JsonValue &entry : jo.get_array( "vehicles" ) ) {
        JsonObject vo = entry.get_object();
        vo.allow_omitted_members();

        const auto nid       = static_cast<uint32_t>( vo.get_int( "nid", 0 ) );
        const tripoint_abs_ms new_abs{
            vo.get_int( "x" ), vo.get_int( "y" ), vo.get_int( "z" )
        };
        host_veh_positions.push_back( new_abs );
        const int  face_deg     = vo.get_int( "face", 0 );
        const int  turn_dir_deg = vo.get_int( "turn_dir", face_deg );
        const int  vel          = vo.get_int( "vel",  0 );
        const int  cruise       = vo.get_int( "cruise", vel );
        // Read name early — used as fallback identifier when position lookups fail
        // (e.g. the client's local physics have drifted the vehicle away from both
        // the tracked position and the server's authoritative position).
        std::string vname;
        vo.read( "name", vname );

        vehicle *found = nullptr;

        // Snapshot path: the host emits a full save-format snapshot for this
        // nid on first encounter AND any time the parts vector mutates
        // (install, remove, fold, damage-purge).  Treat it as an authoritative
        // replacement: destroy any prior local instance for this nid, then
        // deserialize-and-place.  The snapshot is complete state, so we skip
        // the slim per-part / cargo apply that follows and move on.
        if( vo.has_object( "snapshot" ) && m.inbounds( new_abs ) ) {
            // Tear down the previous local instance (if any) so a structural
            // change doesn't end up with two overlapping vehicles at the same
            // tile.  Look up by tracked position; fall back to scanning by name.
            auto prev_it = g_client_veh_pos.find( nid );
            tripoint_abs_ms prev_abs = ( prev_it != g_client_veh_pos.end() )
                                       ? prev_it->second
                                       : new_abs;
            vehicle *prev = nullptr;
            if( m.inbounds( prev_abs ) ) {
                if( const optional_vpart_position vp = m.veh_at( m.get_bub( prev_abs ) ) ) {
                    prev = &vp->vehicle();
                }
            }
            if( !prev && !vname.empty() ) {
                for( const wrapped_vehicle &wv : vehs ) {
                    if( wv.v && wv.v->name == vname ) {
                        prev = wv.v;
                        break;
                    }
                }
            }
            if( prev ) {
                mp_log( "[cdda-mp] CLI-VEH-REPLACE: nid=" + std::to_string( nid )
                        + " name=\"" + prev->name + "\"" );
                m.destroy_vehicle( prev );
            }
            if( prev_it != g_client_veh_pos.end() ) {
                g_client_veh_pos.erase( prev_it );
            }

            JsonObject snap = vo.get_object( "snapshot" );
            snap.allow_omitted_members();
            static const vproto_id vehicle_prototype_none( "none" );
            auto veh_up = std::make_unique<vehicle>( vehicle_prototype_none );
            veh_up->deserialize( snap );
            // Re-anchor sm_pos+pos to the broadcast abs position — the
            // serialized "posx"/"posy" are submap-relative and need to match
            // the client's bubble origin.  Mirrors map::add_vehicle().
            const tripoint_bub_ms new_bub = m.get_bub( new_abs );
            tripoint_bub_sm quotient;
            point_sm_ms remainder;
            std::tie( quotient, remainder ) =
                coords::project_remain<coords::sm>( new_bub );
            veh_up->sm_pos = m.get_abs_sub().xy() + rebase_rel( quotient );
            veh_up->pos = remainder;
            // Preserve the deserialized pivot_anchor / pivot_rotation — those
            // were set by vehicle::deserialize from the snapshot's "pivot" and
            // "faceDir" fields, and reflect the host's authoritative state.
            // Passing point_rel_ms::zero here (as map::add_vehicle does for a
            // freshly-spawned vehicle from a prototype) would clobber any
            // non-zero pivot the host has accumulated through rotations or
            // part changes, shifting every part by a fixed offset relative
            // to pos_abs.  pos_abs matches the host's, but the rendered
            // tiles end up several squares off — visible as the bus
            // appearing at the wrong location on the client after load.
            veh_up->precalc_mounts( 0, veh_up->pivot_rotation[0],
                                    veh_up->pivot_anchor[0] );
            // MP-FIXME: add_vehicle_from_snapshot stubbed for CCB
            ( void )std::move( veh_up );
            /* vehicle *placed = m.add_vehicle_from_snapshot(std::move(veh_up)); */
            mp_log( "[cdda-mp] CLI-VEH-CREATE-SKIPPED: nid=" + std::to_string( nid )
                    + " abs=" + std::to_string( new_abs.x() )
                    + "," + std::to_string( new_abs.y() )
                    + "," + std::to_string( new_abs.z() ) );
            continue;
        }

        // Slim path: no snapshot.  Find the existing local vehicle by tracked
        // position, server's new_abs, or name.  Same fallback chain as before.
        auto pos_it = g_client_veh_pos.find( nid );
        const bool first_encounter = ( pos_it == g_client_veh_pos.end() );
        const tripoint_abs_ms search_abs = ( pos_it != g_client_veh_pos.end() )
                                           ? pos_it->second
                                           : new_abs;

        if( m.inbounds( search_abs ) ) {
            for( const wrapped_vehicle &wv : vehs ) {
                if( wv.v && wv.v->pos_abs() == search_abs ) {
                    found = wv.v;
                    break;
                }
            }
        }
        if( !found && m.inbounds( new_abs ) ) {
            for( const wrapped_vehicle &wv : vehs ) {
                if( wv.v && wv.v->pos_abs() == new_abs ) {
                    found = wv.v;
                    break;
                }
            }
        }
        if( !found && !vname.empty() ) {
            for( const wrapped_vehicle &wv : vehs ) {
                if( wv.v && wv.v->name == vname ) {
                    found = wv.v;
                    break;
                }
            }
        }

        if( !found ) {
            // No local vehicle and no snapshot in this packet (slim
            // vehicle_step before first state, or out-of-bounds).  Skip and
            // wait for the next full state broadcast which will carry one.
            // Log once per nid — this fires every frame for an unplaceable
            // vehicle and used to flood ~23% of the client log.
            static std::unordered_set<uint32_t> s_logged_skip_nids;
            if( s_logged_skip_nids.insert( nid ).second ) {
                mp_log( "[cdda-mp] CLI-VEH-SKIP-UNKNOWN: nid=" + std::to_string( nid )
                        + " new_abs=" + std::to_string( new_abs.x() )
                        + "," + std::to_string( new_abs.y() )
                        + "," + std::to_string( new_abs.z() )
                        + " name=\"" + vname + "\""
                        + " first_encounter=" + std::to_string( first_encounter )
                        + " (further skips for this nid suppressed)" );
            }
            continue;
        }

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

        // Update tracked position only after we've confirmed the vehicle exists
        // at a location the client can see.  This keeps the lookup anchor valid.
        g_client_veh_pos[nid] = found->pos_abs();

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
            // Build index → part pointer map using the same iteration as serialize.
            std::vector<vehicle_part *> part_ptrs;
            for( const vpart_reference &vpr : found->get_all_parts() ) {
                part_ptrs.push_back( &vpr.part() );
            }

            bool parts_changed = false;
            for( const JsonValue &pv : vo.get_array( "parts" ) ) {
                JsonObject po = const_cast<JsonValue &>( pv ).get_object();
                po.allow_omitted_members();
                const int idx = po.get_int( "i", -1 );
                if( idx < 0 || idx >= static_cast<int>( part_ptrs.size() ) ) {
                    continue;
                }
                vehicle_part &vp = *part_ptrs[idx];
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
                    if( ftype.is_valid() && vp.ammo_remaining() != fuel_amt ) {
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

        // Apply per-cargo-part item lists the host sent.  Position is already
        // synced above so m.veh_at(vp_bub).cargo() resolves to the correct part.
        // Mirrors the server-side client_veh_cargo_changes applier so client and
        // host converge on the same items_sig the next time either side scans.
        if( vo.has_array( "cargo" ) ) {
            for( const JsonValue &cv : vo.get_array( "cargo" ) ) {
                JsonObject co = const_cast<JsonValue &>( cv ).get_object();
                co.allow_omitted_members();
                const tripoint_abs_ms vp_abs{
                    co.get_int( "x" ), co.get_int( "y" ), co.get_int( "z" )
                };
                if( !m.inbounds( vp_abs ) ) {
                    continue;
                }
                const tripoint_bub_ms vp_bub = m.get_bub( vp_abs );
                const std::optional<vpart_reference> cargo_vp = m.veh_at( vp_bub ).cargo();
                if( !cargo_vp ) {
                    mp_log( "[cdda-mp] client veh cargo miss: no cargo part at " +
                            std::to_string( vp_abs.x() ) + "," +
                            std::to_string( vp_abs.y() ) + "," +
                            std::to_string( vp_abs.z() ) );
                    continue;
                }
                vehicle &veh = cargo_vp->vehicle();
                vehicle_part &part = cargo_vp->part();
                mp_log( "[cdda-mp] client apply veh cargo @ " +
                        std::to_string( vp_abs.x() ) + "," +
                        std::to_string( vp_abs.y() ) + "," +
                        std::to_string( vp_abs.z() ) );
                {
                    vehicle_stack stack = veh.get_items( part );
                    while( !stack.empty() ) {
                        stack.erase( stack.begin() );
                    }
                }
                std::string items_sig;
                if( co.has_array( "items" ) ) {
                    for( const JsonValue &iv : co.get_array( "items" ) ) {
                        try {
                            item new_item;
                            JsonObject io = const_cast<JsonValue &>( iv ).get_object();
                            io.allow_omitted_members();
                            new_item.deserialize( io );
                            if( !new_item.typeId().is_empty() &&
                                new_item.typeId().is_valid() ) {
                                veh.add_item( m, part, new_item );
                                items_sig += serialize( new_item ) + ',';
                            }
                        } catch( const JsonError & ) {}
                    }
                }
                // Resync the client→host baseline to the post-apply state so the
                // next build_client_veh_cargo_changes() doesn't immediately
                // re-send the host's authoritative contents back as a "client
                // delta" (which would be a no-op but pollutes the wire).
                g_client_veh_cargo_baseline[vp_abs] = items_sig;
            }
        }
    }

    // Cull purely client-local vehicles: the host's vehicle_step lists ALL its
    // vehicles every broadcast, so any client vehicle far from every host
    // vehicle is from the client's own divergent local mapgen (a wreck/parked
    // car the host's world lacks).  Conservative on purpose — vehicles have no
    // network id and the client matches them by fragile position/name, so we
    // only cull vehicles well clear of every host position (never a real host
    // vehicle whose client pivot has drifted) and never the player-controlled
    // one.  Empty host list (host has no vehicles) culls all non-controlled
    // local vehicles, which is correct.
    {
        const avatar &av = get_avatar();
        const optional_vpart_position av_vp = m.veh_at( av.pos_bub() );
        const vehicle *av_veh = av_vp ? &av_vp->vehicle() : nullptr;
        constexpr int CULL_MIN_DIST = 8;
        std::vector<vehicle *> local_cull;
        for( const wrapped_vehicle &wv : m.get_vehicles() ) {
            vehicle *v = wv.v;
            if( !v || v == av_veh ) {
                continue;
            }
            const tripoint_abs_ms vp = v->pos_abs();
            int best = INT_MAX;
            for( const tripoint_abs_ms &hp : host_veh_positions ) {
                if( hp.z() != vp.z() ) {
                    continue;
                }
                best = std::min( best,
                                 std::max( std::abs( hp.x() - vp.x() ),
                                           std::abs( hp.y() - vp.y() ) ) );
            }
            if( best > CULL_MIN_DIST ) {
                local_cull.push_back( v );
            }
        }
        for( vehicle *v : local_cull ) {
            mp_log( "[cdda-mp] CLI-VEH-CULL-LOCAL: name=\"" + v->name + "\" abs=" +
                    std::to_string( v->pos_abs().x() ) + "," +
                    std::to_string( v->pos_abs().y() ) );
            m.destroy_vehicle( v );
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
    static std::unordered_set<uint32_t> s_ever_seen_nids;

    // Rebuild net_id → monster* map from current creature_tracker state.
    g_net_id_map.clear();
    for( const auto &ptr : mons ) {
        if( ptr && ptr->mp_net_id != 0 ) {
            g_net_id_map[ptr->mp_net_id] = ptr.get();
        }
    }

    constexpr int SYNC_RADIUS = 84;   // match build_monster_list's broadcast radius
    const tripoint_abs_ms region_center = g_mp_remote_pos;

    // Collect all client monsters inside the sync region for cleanup pass.
    std::unordered_set<monster *> in_region;
    for( const auto &ptr : mons ) {
        monster *mon = ptr.get();
        if( !mon ) {
            continue;
        }
        const tripoint_abs_ms mp = mon->pos_abs();
        if( std::abs( mp.x() - region_center.x() ) <= SYNC_RADIUS &&
            std::abs( mp.y() - region_center.y() ) <= SYNC_RADIUS &&
            mp.z() == region_center.z() ) {
            in_region.insert( mon );
        }
    }

    std::unordered_set<monster *> matched;
    int n_recv = 0;
    int n_spawned = 0;
    int n_culled = 0;
    std::string culled_log;

    for( const JsonValue &entry : jo.get_array( "monsters" ) ) {
        JsonObject mo = entry.get_object();
        mo.allow_omitted_members();
        ++n_recv;

        const auto nid       = static_cast<uint32_t>( mo.get_int( "nid", 0 ) );
        const int  server_hp = mo.get_int( "hp", -1 );
        const tripoint_abs_ms target{
            mo.get_int( "x" ), mo.get_int( "y" ), mo.get_int( "z" )
        };

        // Host confirmed this monster dead — drop the pending-kill suppress. The
        // corpse arrives via the host's authoritative kill (item/tile sync), so
        // the client never spawns a local one (GH#1: no duplicate corpse).
        if( nid != 0 && server_hp <= 0 ) {
            g_client_pending_kill.erase( nid );
        }

        monster *best = nullptr;

        // --- Primary lookup: stable network ID ---
        if( nid != 0 ) {
            auto it = g_net_id_map.find( nid );
            if( it != g_net_id_map.end() && !matched.count( it->second ) ) {
                best = it->second;
            }
        }

        // --- Fallback: proximity + type for monsters not yet assigned an ID ---
        // Covers the initial connect where the client's local monsters have mp_net_id == 0.
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
                    if( mon->mp_net_id != 0 && mon->mp_net_id != nid ) {
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
                if( best != nullptr && nid != 0 && best->mp_net_id == 0 ) {
                    best->mp_net_id = nid;
                    g_net_id_map[nid] = best;
                }
            }
        }

        // --- Suppress respawn of a monster the client just killed locally ---
        // The host hasn't processed the forwarded kill yet, so it's still
        // broadcasting this monster alive. Respawning it now is the GH#1
        // "killed zed rose again + extra corpses" loop. Skip for a bounded
        // window; if the host keeps reporting it alive past that, the kill was
        // rejected (HP desync) — fall through and respawn rather than leave an
        // invisible-but-alive monster.
        if( best == nullptr && nid != 0 ) {
            auto pk = g_client_pending_kill.find( nid );
            if( pk != g_client_pending_kill.end() ) {
                if( pk->second > 0 ) {
                    --pk->second;
                    mp_log( "[cdda-mp] MON-KILL-SUPPRESS: nid=" + std::to_string( nid ) +
                            " server_hp=" + std::to_string( server_hp ) +
                            " syncs_left=" + std::to_string( pk->second ) );
                    continue;
                }
                g_client_pending_kill.erase( pk );
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
                new_mon->mp_net_id = nid;
                new_mon->set_hp( server_hp );
                best = g->place_critter_at( new_mon, bub );
                if( best != nullptr && nid != 0 ) {
                    g_net_id_map[nid] = best;
                }
                if( best != nullptr ) {
                    ++n_spawned;
                    const bool silently_dropped = nid != 0 && s_ever_seen_nids.count( nid );
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

        // Silent-drop diagnostic: remember live nids; forget ones the host reports
        // dead (server_hp<=0) so a later revival re-spawn isn't mis-flagged.
        if( nid != 0 ) {
            if( server_hp > 0 ) {
                s_ever_seen_nids.insert( nid );
            } else {
                s_ever_seen_nids.erase( nid );
            }
        }

        // Correct position if the server disagrees.
        if( best->pos_abs() != target && m.inbounds( target ) ) {
            const shared_ptr_fast<monster> occupant = ct.find( target );
            if( !occupant || occupant.get() == best ) {
                best->setpos( target, false );
            }
        }

        // Synthesise death messages from HP deltas before applying the new value.
        // "takes N damage" is intentionally omitted — attributed hit messages
        // from flush_action_msgs / host_capture_avatar_msgs cover those, and
        // the dumb HP-delta version creates confusing duplicates.
        if( nid != 0 && server_hp >= 0 ) {
            g_last_monster_hp[nid] = server_hp;
        }

        // Apply server HP. Kill locally if the server says it's dead.
        if( server_hp >= 0 ) {
            if( server_hp <= 0 ) {
                best->die( &m, nullptr );
            } else {
                best->set_hp( server_hp );
            }
        }

        // Sync facing direction for correct sprite flip.
        if( mo.has_int( "facing" ) ) {
            best->facing = mo.get_int( "facing" ) == 0
                           ? FacingDirection::LEFT : FacingDirection::RIGHT;
        }
    }

    // Cull purely client-local monsters: any monster inside the host's broadcast
    // region with NO network id that the host didn't report this turn comes from
    // the client's own divergent local mapgen (a client-local map feature the
    // host's world doesn't have — e.g. a refugee center with turkeys/NPCs).  Host
    // monsters always receive a net id on match/spawn, so mp_net_id==0 reliably
    // means "never corresponded to a host monster," and the host's authoritative
    // list covers this whole region — so the absence is real.  This is NOT the
    // old cull-by-absence (which killed *synced* monsters, net_id!=0, on a missed
    // broadcast — the woodpecker bug); those are untouched here.  remove_zombie
    // despawns cleanly (no corpse, which would itself be a desync).
    {
        std::vector<monster *> local_cull;
        for( monster *mon : in_region ) {
            if( mon && mon->mp_net_id == 0 && !matched.count( mon ) && !mon->is_dead() ) {
                local_cull.push_back( mon );
            }
        }
        for( monster *mon : local_cull ) {
            culled_log += mon->type->id.str() + "(local) ";
            ++n_culled;
            g->remove_zombie( *mon );
        }
    }

    // Client-local monsters (mp_net_id==0, unmatched, alive) OUTSIDE the host's
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
        static std::unordered_map<std::string, int> s_phantom_strikes;
        std::unordered_map<std::string, int> seen_now;
        std::vector<monster *> phantom_cull;
        int n_phantom = 0;
        std::string phantom_log;
        const tripoint_abs_ms av = get_avatar().pos_abs();
        for( const auto &ptr : mons ) {
            monster *mon = ptr.get();
            if( !mon || mon->mp_net_id != 0 || matched.count( mon ) || mon->is_dead() ) {
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
            const auto prev = s_phantom_strikes.find( key );
            const int strikes = ( prev != s_phantom_strikes.end() ? prev->second : 0 ) + 1;
            seen_now[key] = strikes;
            phantom_log += mon->type->id.str() + "@dAvatar" +
                           std::to_string( std::max( std::abs( mp.x() - av.x() ),
                                           std::abs( mp.y() - av.y() ) ) ) +
                           "(s" + std::to_string( strikes ) + ") ";
            if( strikes >= PHANTOM_CULL_SYNCS ) {
                phantom_cull.push_back( mon );
            }
        }
        s_phantom_strikes.swap( seen_now );   // drop keys not seen this sync
        for( monster *mon : phantom_cull ) {
            culled_log += mon->type->id.str() + "(phantom) ";
            ++n_culled;
            g->remove_zombie( *mon );          // clean despawn, no corpse
        }
        static int s_last_phantom = -1;
        if( n_phantom != s_last_phantom || !phantom_cull.empty() ) {
            s_last_phantom = n_phantom;
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

    // Remove ONLY monsters the host explicitly reports gone (died / left the
    // bubble) via removed_monsters. NO cull-by-absence: a monster merely missing
    // from this broadcast (out of radius, or a transient short broadcast) is
    // left alone — it stays frozen until the host updates or removes it. This
    // replaces the old "in_region but unmatched → die" loop that killed live
    // monsters on a single missed broadcast (the woodpecker bug).
    if( jo.has_array( "removed_monsters" ) ) {
        for( const JsonValue &rv : jo.get_array( "removed_monsters" ) ) {
            const uint32_t rnid = static_cast<uint32_t>( rv.get_int() );
            if( rnid == 0 ) {
                continue;
            }
            g_client_pending_kill.erase( rnid );  // host confirmed gone (GH#1)
            s_ever_seen_nids.erase( rnid );        // host-confirmed removal → not a silent drop
            auto it = g_net_id_map.find( rnid );
            if( it != g_net_id_map.end() && it->second && !it->second->is_dead() ) {
                culled_log += it->second->type->id.str() + "(nid=" +
                              std::to_string( rnid ) + ") ";
                ++n_culled;
                it->second->die( &m, nullptr );
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

    g->cleanup_dead();
}

static std::string build_viewport( const tripoint_bub_ms &center )
{
    constexpr int W = 41;
    constexpr int H = 21;

    map &m = get_map();
    avatar &u = get_avatar();
    npc *remote = g->critter_by_id<npc>( remote_player_npc_id );

    tripoint_bub_ms avatar_pos = u.pos_bub();

    // Map bounds in bubble coords
    const point_bub_ms map_min{ 0, 0 };
    const point_bub_ms map_max{ MAPSIZE_X - 1, MAPSIZE_Y - 1 };

    int ox = center.x() - W / 2;
    int oy = center.y() - H / 2;

    std::string tiles;
    tiles.reserve( W * H );

    for( int row = 0; row < H; ++row ) {
        for( int col = 0; col < W; ++col ) {
            int bx = ox + col;
            int by = oy + row;
            tripoint_bub_ms p{ bx, by, center.z() };

            if( bx < map_min.x() || bx > map_max.x() || by < map_min.y() || by > map_max.y() ) {
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
           ",\"ox\":" + std::to_string( ox ) +
           ",\"oy\":" + std::to_string( oy ) +
           R"(,"tiles":")" + tiles + "\"}";
}

void mp_post_trade( npc &np, const std::list<item> &items_given,
                    const std::list<item> &items_taken )
{
    const bool host_side = is_server_mode() || is_hosting();
    const bool client_side = is_client_mode();

    if( !host_side && !client_side ) {
        return;
    }

    if( !is_partner_npc( np.getID() ) ) {
        return;
    }

    std::string give_json = "[";
    bool gfirst = true;
    for( const item &it : items_given ) {
        if( !gfirst ) {
            give_json += ',';
        }
        gfirst = false;
        std::ostringstream oss;
        {
            JsonOut out( oss );
            it.serialize( out );
        }
        give_json += oss.str();
    }
    give_json += "]";

    std::string take_json = "[";
    bool tfirst = true;
    for( const item &it : items_taken ) {
        if( !tfirst ) {
            take_json += ',';
        }
        tfirst = false;
        std::ostringstream oss;
        {
            JsonOut out( oss );
            it.serialize( out );
        }
        take_json += oss.str();
    }
    take_json += "]";

    std::string payload = "{\"type\":\"trade_delta\","
                          "\"give\":" + give_json + ","
                          "\"take\":" + take_json + "}";

    mp_log( "[cdda-mp] trade_delta send: give=" + std::to_string( items_given.size() )
            + " take=" + std::to_string( items_taken.size() ) );

    if( host_side ) {
        server *s = get_active_server();
        if( s ) {
            s->post_broadcast( payload + "\n" );
        }
    } else {
        client_send( payload );
    }
}

void mp_handle_pass_item()
{
    if( !is_hosting() && !is_client_mode() ) {
        return;
    }

    npc *partner = get_partner_npc();
    if( !partner ) {
        add_msg( m_warning, _( "Your partner is not connected." ) );
        return;
    }

    avatar &av = get_avatar();
    if( rl_dist( av.pos_bub().raw(), partner->pos_bub().raw() ) > 1 ) {
        add_msg( m_warning, _( "You need to be adjacent to your partner." ) );
        return;
    }

    item_location loc = game_menus::inv::titled_menu( av,
                        _( "Pass what?" ), _( "You have no items to pass." ) );
    if( !loc ) {
        return;
    }

    item given = *loc;

    av.i_rem( loc.get_item() );
    partner->i_add( given );

    std::list<item> give_list = { given };
    std::list<item> take_list;
    mp_post_trade( *partner, give_list, take_list );

    av.mod_moves( -100 );
    add_msg( _( "You pass the %s to %s." ), given.tname(), partner->get_name() );

    if( is_client_mode() ) {
        mp_client_post_action();
    }
}

// --- High-five partner action -------------------------------------------

static const morale_type morale_high_five( "morale_high_five" );

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

// Mirror tap-on-shoulder's interruptible set exactly (is_partner_in_wait_activity,
// which covers all four ACT_WAIT* variants): idle or any wait == available; any
// real activity (craft / read / sleep / butcher / build / ...) == busy, left alone.
static bool mp_partner_is_busy()
{
    const std::string &a = g_partner_activity;
    if( a.empty() ) {
        return false;
    }
    return a != "ACT_WAIT" && a != "ACT_WAIT_STAMINA" &&
           a != "ACT_WAIT_WEATHER" && a != "ACT_WAIT_NPC";
}

void mp_high_five()
{
    if( !is_hosting() && !is_client_mode() ) {
        return;
    }
    npc *partner = get_partner_npc();
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
    if( mp_partner_is_busy() ) {
        const std::string verb = mp_activity_verb_phrase( g_partner_activity );
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
    const std::string payload = R"({"type":"high_five","name":")" +
                                av.get_name() + "\"}";
    if( is_hosting() || is_server_mode() ) {
        if( server *s = get_active_server() ) {
            s->post_broadcast( payload + "\n" );
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

static void mp_handle_shout_recv( const std::string &msg )
{
    npc *remote = g->critter_by_id<npc>( remote_player_npc_id );
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

static bool g_applying_remote_note = false;

static void mp_send_note_msg( const std::string &payload )
{
    if( is_server_mode() || is_hosting() ) {
        server *s = get_active_server();
        if( s ) {
            s->post_broadcast( payload + "\n" );
        }
    } else if( is_client_mode() ) {
        client_send( payload );
    }
}

void mp_sync_note_add( const tripoint_abs_omt &pos, const std::string &text )
{
    if( g_applying_remote_note ) {
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
    if( g_applying_remote_note ) {
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
    if( g_applying_remote_note ) {
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
        g_applying_remote_note = true;
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
        g_applying_remote_note = false;
    } catch( const JsonError &e ) {
        g_applying_remote_note = false;
        mp_log( std::string( "[cdda-mp] note_sync parse error: " ) + e.what() );
    }
}

std::string serialize_remote_player_state()
{
    if( !remote_player_connected ) {
        return R"({"type":"state","connected":false})";
    }

    npc *remote = g->critter_by_id<npc>( remote_player_npc_id );
    if( !remote ) {
        return R"({"type":"state","connected":false})";
    }

    tripoint_bub_ms pos_bub = remote->pos_bub();
    tripoint_abs_ms pos = remote->pos_abs();
    mp_log( "[cdda-mp] SRP: npc_abs=" + std::to_string( pos.x() ) + "," + std::to_string( pos.y() ) +
            " bub=" + std::to_string( pos_bub.x() ) + "," + std::to_string( pos_bub.y() ) );
    const avatar &host = get_avatar();
    tripoint_abs_ms host_pos = host.pos_abs();

    std::string viewport = build_viewport( pos_bub );
    // Broadcast every monster in the reality bubble the client can see (~84-tile
    // view radius), not just 40 — at 40, host monsters in the 40–84 band weren't
    // sent (the EXCLUDED-NEAR diag) and the client filled the gap with its own
    // divergent local-mapgen monsters.  Must match the client's cull radius in
    // apply_monster_sync.
    std::string monsters     = build_monster_list( pos, 84 );

    // Death-based monster removal (mirrors removed_vehicles, but glitch-proof).
    // A monster is "removed" only if it had a net id last broadcast and is no
    // longer alive ANYWHERE in the creature tracker (genuinely died / left the
    // bubble) — NOT merely because it fell outside this broadcast's radius. So
    // a transient short broadcast, or a monster wandering past 40 tiles while
    // still alive, never removes it on the client. Replaces the client's old
    // cull-by-absence, which killed live monsters (the woodpecker bug).
    std::unordered_set<uint32_t> mon_alive_now;
    for( const auto &mon_ptr : get_creature_tracker().get_monsters_list() ) {
        if( mon_ptr && mon_ptr->mp_net_id != 0 && !mon_ptr->is_dead() ) {
            mon_alive_now.insert( mon_ptr->mp_net_id );
        }
    }
    std::string removed_monsters_json = "[";
    {
        bool rmfirst = true;
        for( const uint32_t old_nid : g_server_mon_known_nids ) {
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
    g_server_mon_known_nids = std::move( mon_alive_now );

    // Scan for tile changes around both the remote player AND the host so that
    // doors/terrain the host interacts with also reach the client.
    std::string tile_changes = build_tile_changes( pos, 20 );
    if( host_pos != pos ) {
        std::string host_tc = build_tile_changes( host_pos, 20 );
        if( host_tc.size() > 2 ) { // not just "[]"
            if( tile_changes == "[]" ) {
                tile_changes = host_tc;
            } else {
                tile_changes = tile_changes.substr( 0, tile_changes.size() - 1 )
                               + "," + host_tc.substr( 1 );
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
        static std::string last_bp;
        if( bp_log != last_bp ) {
            last_bp = bp_log;
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
    static std::string g_host_worn_json_cache;
    static std::string g_host_worn_sig_cache;

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
    if( host_worn_sig == g_host_worn_sig_cache ) {
        host_worn_json = g_host_worn_json_cache;
    } else {
        g_host_worn_sig_cache = host_worn_sig;
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
        g_host_worn_json_cache = host_worn_json;
        mp_log( "[cdda-mp] host_worn changed: [" + host_worn_sig + "]" );
    }

    // Build the messages JSON.  Two sources:
    //   1. g_action_msgs_pending — all messages from the last remote player action,
    //      already NPC→"You" substituted and filtered by flush_action_msgs().
    //   2. Name-filtered messages generated between actions (monster attacks on the
    //      NPC, etc.) that arrived since the last broadcast.
    const std::string &npc_name = remote->name;
    std::string msgs_json = "[";
    bool mfirst = true;

    // Helper: JSON-escape and append one message string.
    const auto append_msg = [&]( const std::string & text ) {
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
    for( const std::string &text : g_action_msgs_pending ) {
        append_msg( text );
    }
    g_action_msgs_pending.clear();

    // 1b. Host avatar combat messages forwarded with "You" → host name attribution.
    for( const std::string &text : g_host_action_msgs_pending ) {
        append_msg( text );
    }
    g_host_action_msgs_pending.clear();

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
    if( current_msg_count > g_last_forwarded_msg_count ) {
        const size_t new_count = static_cast<size_t>( current_msg_count - g_last_forwarded_msg_count );
        g_last_forwarded_msg_count = current_msg_count;
        const auto new_msgs = Messages::recent_messages( new_count );
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
            auto vid_it = g_server_veh_ids.find( v );
            if( vid_it == g_server_veh_ids.end() ) {
                g_server_veh_ids[v] = ++g_next_net_id;
                vid_it = g_server_veh_ids.find( v );
            }
            const uint32_t nid = vid_it->second;
            alive_now.insert( nid );

            // Detect structural change: if the parts vector grew or shrank since
            // the last broadcast (install, remove, damage-purge, fold-merge), the
            // sequential part indices the slim sync relies on no longer line up
            // with the client's local vector.  Drop the nid from the snapshot
            // tracking so the very next broadcast re-emits the full snapshot
            // and the client mirrors the new structural state via the existing
            // CLI-VEH-CREATE path.  Use part_count_real() — part_count()
            // includes fake parts that are added/removed transiently by
            // refresh()/remove_fake_parts() between broadcasts (e.g. for
            // turn-rendering), which would oscillate the baseline and trigger
            // a snapshot resend on every turn, looping client+host indefinitely.
            const size_t parts_now = v->part_count_real();
            auto pc_it = g_server_veh_parts_count.find( nid );
            if( pc_it != g_server_veh_parts_count.end() && pc_it->second != parts_now ) {
                mp_log( "[cdda-mp] HOST-VEH-PARTS-CHANGED: nid=" + std::to_string( nid )
                        + " was=" + std::to_string( pc_it->second )
                        + " now=" + std::to_string( parts_now )
                        + " name=\"" + v->name + "\"" );
                g_client_known_veh_nids.erase( nid );
            }
            g_server_veh_parts_count[nid] = parts_now;
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
            for( const vpart_reference &vpr : v->get_all_parts() ) {
                const vehicle_part &vp = vpr.part();
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
                }
                parts_json += "}";
                ++pidx;
            }
            parts_json += ']';

            // Per-cargo-part contents.  Baseline-diff gated so a 100-item trunk
            // with stable contents costs nothing on the wire — we only emit
            // parts whose items actually changed since the last broadcast.
            // Mirrors build_client_veh_cargo_changes() in the opposite direction.
            std::string cargo_json = "[";
            bool cfirst = true;
            for( const vpart_reference &vpr : v->get_any_parts( VPFLAG_CARGO ) ) {
                const tripoint_abs_ms vp_abs = vmap.get_abs( vpr.pos_bub( vmap ) );
                std::string items_sig;
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
                auto &baseline = g_host_veh_cargo_baseline[vp_abs];
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
                              + ",\"items\":" + items_json + "}";
            }
            cargo_json += ']';

            if( !vfirst ) {
                vehicles_json += ',';
            }
            vfirst = false;
            // First-encounter snapshot: include the full save-format vehicle
            // JSON so the client can mirror SP's add_vehicle / save-load path
            // for vehicles it has no local instance of (debug spawn, deployed
            // foldable, mid-game-constructed frame, mapgen-into-bubble).  The
            // snapshot is only emitted once per nid per client connection;
            // subsequent broadcasts stay slim.  Field name "snapshot" is a
            // nested JSON object so no escaping is needed.
            std::string snapshot_field;
            if( !g_client_known_veh_nids.count( nid ) ) {
                snapshot_field = ",\"snapshot\":" + ::serialize( *v );
                g_client_known_veh_nids.insert( nid );
                mp_log( "[cdda-mp] HOST-VEH-SNAPSHOT: nid=" + std::to_string( nid )
                        + " name=\"" + v->name + "\" bytes="
                        + std::to_string( snapshot_field.size() ) );
            }
            vehicles_json += "{\"nid\":" + std::to_string( nid )
                             + ",\"x\":" + std::to_string( vabs.x() )
                             + ",\"y\":" + std::to_string( vabs.y() )
                             + ",\"z\":" + std::to_string( vabs.z() )
                             + ",\"face\":" + std::to_string( face_deg )
                             + ",\"turn_dir\":" + std::to_string( turn_dir_deg )
                             + ",\"vel\":" + std::to_string( v->velocity )
                             + ",\"cruise\":" + std::to_string( v->cruise_velocity )
                             + R"(,"name":")" + vname_escaped + "\""
                             + ",\"parts\":" + parts_json
                             + ",\"cargo\":" + cargo_json
                             + snapshot_field + "}";
        }
    }
    vehicles_json += ']';

    // Diff against the previous broadcast: any nid that was live last time but
    // isn't in alive_now has disappeared (folded, fully destroyed, driven out
    // of bubble, etc.).  Emit a removed_vehicles array so the client can
    // mirror SP's map::destroy_vehicle path.  Also drop those nids from the
    // snapshot/parts-count tracking so a future re-encounter triggers a fresh
    // snapshot.
    std::string removed_vehicles_json = "[";
    {
        bool rfirst = true;
        for( const uint32_t old_nid : g_server_veh_live_nids ) {
            if( alive_now.count( old_nid ) ) {
                continue;
            }
            if( !rfirst ) {
                removed_vehicles_json += ',';
            }
            rfirst = false;
            removed_vehicles_json += std::to_string( old_nid );
            g_client_known_veh_nids.erase( old_nid );
            g_server_veh_parts_count.erase( old_nid );
            mp_log( "[cdda-mp] HOST-VEH-REMOVED: nid=" + std::to_string( old_nid ) );
        }
    }
    removed_vehicles_json += ']';
    g_server_veh_live_nids = std::move( alive_now );

    // Host's active effects (bleeding, poison, splints, buffs…) so the client's
    // host-proxy shows the same status + overhead markers. The client->host
    // direction already syncs bleed (client_bleed); this is the missing mirror,
    // and covers ALL effects, not just bleed.
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

    return "{\"type\":\"state\","
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
           "\"host_activity_pct\":" + std::to_string(
               mp_compute_activity_pct( host.activity ) ) + ","
           "\"host_activity_moves_total\":" + std::to_string(
               host.activity ? host.activity.moves_total : 0 ) + ","
           "\"host_morale\":" + std::to_string( host.get_morale_level() ) + ","
           "\"host_hp_cur\":" + std::to_string( mp_worst_limb_hp( host ).first ) + ","
           "\"host_hp_max\":" + std::to_string( mp_worst_limb_hp( host ).second ) + ","
           "\"host_ping_echo\":" + std::to_string( g_last_client_ping_stamp ) + ","
           "\"host_effects\":" + host_effects_json + ","
           "\"host_hp\":" + host_hp_json + ","
    + ( []() -> std::string {
        // One-shot wake_client signal — emit on this broadcast then clear.
        if( g_pending_wake_client )
        {
            g_pending_wake_client = false;
            return "\"wake_client\":true,";
        }
        return "";
    }() ) +
    ( []() -> std::string {
        // One-shot host→client swap/push signals — client renders the
        // observer message locally from the proxy name (no text relay).
        std::string s;
        if( g_pending_partner_swap )
        {
            g_pending_partner_swap = false;
            s += "\"partner_swapped\":true,";
        }
        if( g_pending_partner_push )
        {
            g_pending_partner_push = false;
            s += "\"partner_pushed\":true,";
        }
        return s;
    }() ) +
    "\"bodyparts\":" + bparts_json +
    ",\"moves\":" + std::to_string( g_remote_moves ) +
    ",\"speed\":" + std::to_string( remote->get_speed() ) +
    R"(,"client_move_mode":")" + remote->move_mode.str() + "\""
    ",\"client_stamina\":" + std::to_string( remote->get_stamina() ) +
    ",\"client_stamina_max\":" + std::to_string( remote->get_stamina_max() ) +
    ",\"client_ctrl_veh\":" + ( remote->controlling_vehicle ? "true" : "false" ) +
    // Authoritative grab + hauling state for the client's character.
    // Client mirrors these onto its local avatar each tick so the
    // local SP grab/haul code (and its move-cost gating) reads the
    // same values the host is enforcing.
    // MP-FIXME: npc::get_grab_type stubbed for CCB
    ",\"client_grab_type\":0 /* static_cast<int>(remote->get_grab_type()) */" +
    ",\"client_grab_dx\":" + std::to_string( remote->grab_point.x() ) +
    ",\"client_grab_dy\":" + std::to_string( remote->grab_point.y() ) +
    ",\"client_grab_dz\":" + std::to_string( remote->grab_point.z() ) +
    ",\"client_hauling\":" + ( remote->is_hauling() ? "true" : "false" ) +
    [&]() -> std::string {
        if( !remote->controlling_vehicle )
        {
            return "";
        }
        map &vmap = get_map();
        const optional_vpart_position ovp = vmap.veh_at( remote->pos_bub() );
        if( !ovp )
        {
            return "";
        }
        const tripoint_abs_ms vabs = ovp->vehicle().pos_abs();
        return R"(,"client_veh_pos":{"x":)" + std::to_string( vabs.x() )
        + ",\"y\":" + std::to_string( vabs.y() )
        + ",\"z\":" + std::to_string( vabs.z() ) + "}";
    }() +
    ",\"monsters\":" + monsters +
    ",\"removed_monsters\":" + removed_monsters_json +
    ",\"tile_changes\":" + tile_changes +
    ",\"vehicles\":" + vehicles_json +
    ",\"removed_vehicles\":" + removed_vehicles_json +
    ",\"msgs\":" + msgs_json +
    ",\"grant_seq\":" + std::to_string( g_grant_seq ) +
    ",\"sfx\":" + [&]() -> std::string {
        std::string j = "[";
        bool first = true;
        for( const auto &e : g_host_sfx_queue )
        {
            if( !first ) {
                j += ',';
            }
            first = false;
            j += R"({"id":")" + json_escape_str( e.id )
                 + R"(","v":")" + json_escape_str( e.variant )
                 + R"(","vol":)" + std::to_string( e.vol ) + "}";
        }
        g_host_sfx_queue.clear();
        j += "]";
        return j;
    }() +
    ",\"map\":" + viewport + "}";
}

void client_wait_for_initial_position()
{
    using namespace std::chrono_literals;
    const auto deadline = std::chrono::steady_clock::now() + 5s;
    while( !g_initial_teleport_done ) {
        if( std::chrono::steady_clock::now() >= deadline ) {
            std::cout << "[cdda-mp] Timed out waiting for initial position from server." << std::endl;
            break;
        }
        client_process_incoming();
        std::this_thread::sleep_for( 50ms );
    }
}

} // namespace cata_mp
