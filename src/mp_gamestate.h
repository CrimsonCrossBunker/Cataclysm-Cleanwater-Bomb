#pragma once
#ifndef CATA_SRC_MP_GAMESTATE_H
#define CATA_SRC_MP_GAMESTATE_H

#include <stdint.h>
#include <climits>
#include <list>
#include <string>
#include <string_view>
#include <vector>

#include "character_id.h"
#include "coordinates.h"
#include "type_id.h"

class Character;
class item;
class npc;
enum class object_type : int;
struct WORLD;

namespace cata_mp
{

// Called once per game turn from do_turn() — drains the event queue and
// processes connect/disconnect/action events from remote players.
void process_mp_events();

// Cheap outer gate for the game loop.  Single-player code should test this
// before calling any per-turn multiplayer work so queues, cleanup, logging and
// UI synchronization are not entered at all in a solo session.
bool is_session_active();

// Run all multiplayer work associated with the start of a game turn.  The
// caller must first check is_session_active(); keeping the gate at the call
// site makes the single-player hot path one predictable mode check.
void process_session_turn();

// Returns a JSON string describing the remote player's current position,
// HP, and nearby visible tiles. Sent to the client after each action.
std::string serialize_remote_player_state();

// Returns true if the given character_id belongs to a remote player NPC.
// Used by monmove() to skip AI processing for human-controlled NPCs.
bool is_remote_player( character_id id );

// True if `id` belongs to the MP partner's proxy NPC — works on either side.
// (host: matches the client's proxy; client: matches the host's proxy.)
bool is_partner_npc( character_id id );

// True when the partner (on the other end of the connection) is currently
// in an interruptible "wait several minutes" activity.  Reads the activity
// id last broadcast over the wire — works in either direction (client sees
// host's wait; host sees client's wait).
bool is_partner_in_wait_activity();

// Minimum moves_total for the partner's activity to surface the "Help with
// task" bump-menu entry.  Below this threshold the activity is short enough
// that the menu interaction friction outweighs the helper bonus.  ~10000
// moves ≈ 100 turns ≈ ~100 seconds real-time under MP lockstep cadence.
constexpr int HELPER_MIN_MOVES_TOTAL = 10000;

// True when the partner is currently in the helper activity (ACT_HELP_PARTNER),
// committed to helping with our long task.  Read by Character::get_crafting_helpers()
// to decide whether to include the partner proxy NPC in the SP helper list
// (which feeds skill / proficiency / time-bonus math).
bool is_partner_helping_us();

// True when the partner's current activity is one that SP's helper system
// supports (crafting, construction, vehicle, butchery, disassembly).  Reading
// is intentionally excluded — its "learn alongside" semantics need separate
// design.  Used by the bump-menu gate.
bool partner_activity_accepts_help();

// Total moves required by the partner's current activity (act.moves_total),
// snapshotted by the partner's actor::start() and propagated each tick.  Read
// by the bump-menu predicate.  Zero when partner is idle.
int partner_activity_moves_total();

// Last progress percent (0-100) the partner reported for their current
// activity.  Used by the helper's local wait popup to mirror the lead's
// actual progress (otherwise the helper's popup tracks ACT_HELP_PARTNER's
// long fallback duration and reads as 1% throughout the entire help).
int partner_activity_pct();

// True when both avatars are committed to non-interactive activities (host
// has an activity AND partner has an activity per the heartbeat).  When true,
// wait_for_client_action() drops its 16ms per-iter throttle so turns advance
// as fast as the network round-trip allows — long crafts/sleeps don't
// require watching a 1Hz progress bar for 8 game-hours.  Activity completion,
// distraction prompts, or manual interrupts all break burst mode naturally.
bool mp_in_burst_mode();

// Host-only: queue a one-shot "wake_client" signal that piggy-backs on the
// next serialize_remote_player_state broadcast.  Client consumes it and
// cancels its own wait activity.  Used by the host's tap-on-shoulder
// dispatch when the host is interrupting the client's wait.
void mark_wake_client_pending();

// Host-only: queue a one-shot signal that the host swapped with / pushed the
// client this turn (host-initiated, performed locally on the host).  The next
// state broadcast carries the flag; the client renders the observer message
// ("<host> swaps places with you.") locally from the proxy's real name, so no
// rendered text crosses the wire.
void mark_partner_swap_pending();
void mark_partner_push_pending();

// Current partner-separation tier (0 = close, 1 = mild warn, 2 = urgent
// warn / leeway, 3 = pause).  Read by do_turn to auto-pause the calendar
// at tier 3.
int get_separation_tier();

// Returns the partner NPC (proxy of the OTHER player) from this side's POV,
// or nullptr if not connected. On the host that's the client's proxy; on
// the client that's the host's proxy. Used by the tile renderer to draw a
// direction indicator when the partner is off-screen.
::npc *get_partner_npc();

// Host: true while wait_for_client_action() is blocking — i.e. the host has
// no moves and is waiting for the client to ack the current turn.  Used to
// gate which keys are handled during the wait (zoom etc.).
bool is_host_waiting_for_client();

// Host: true once the client has acked the current host turn.  Cleared by
// grant_client_turn().  Used by get_player_input()'s TIMEOUT escape so the
// host's blocking handle_action call unwinds the moment the partner acks,
// instead of sitting idle until the next host keypress.
bool client_acted_this_turn();

// True when the partner is in an interactive activity (ACT_AIM/FIRSTAID/
// AUTOATTACK/AUTODRIVE) — i.e. running a local UI that won't send a wait until
// it resolves.  Used by the host wait so it neither enters nor stays in the
// blocking input poll while the partner aims (mirror of the client staying
// responsive while the host aims).
bool partner_in_interactive_activity();

// Drain the server recv queue and apply each state message to the local avatar.
// Called once per game turn from do_turn() when in client mode.
void client_process_incoming();

// Run blocking UI that was deferred out of the network-recv path (e.g. the smash
// "Keep smashing?" prompt).  Call from do_turn() right after
// client_process_incoming(), where a top-level UI context is valid.
void client_resolve_pending_ui();

// Block until the server has sent the initial position and the avatar has been
// teleported to the host area.  Call once after the game world is loaded but
// before the first do_turn(), so the player never sees their scenario start tile.
// Times out after ~5 seconds if no position arrives.
void client_wait_for_initial_position();

// Cached at main() startup from the binary's on-disk mtime, e.g.
// "May 25 19:26:00". Used to keep the build identifier in the window
// title across mp_update_window_title() calls (mode changes) without
// re-stat'ing argv[0] every time.
extern std::string g_mp_build_stamp;

// Host-only: tick any player_activity the proxy NPC holds (e.g. a
// move_items_activity_actor assigned by the post-step hauling hook).
// do_turn.cpp's main NPC loop continues past remote-player NPCs so they
// don't run AI; this gives their assigned activities the do_turn()
// they'd get on the avatar's path.
// (class npc is already forward-declared at global scope above.)
void mp_tick_proxy_activity( ::npc &guy );

// Client-only: invoke from the wrapper around the SP grab() handler in
// handle_action.cpp's ACTION_GRAB case.  Snapshot the avatar's grab state
// before running SP grab(), then call this with the pre-snapshot; we forward
// the delta to the host so its proxy NPC mirrors the grab.  No-op for the SP
// case (cancelled prompt → state unchanged) and outside client mode.
void mp_client_dispatch_grab_if_changed( object_type pre_type,
        const tripoint_rel_ms &pre_point );

// Client-only: parallel to the grab dispatcher.  Invoke from the wrappers
// around ACTION_HAUL and ACTION_HAUL_TOGGLE after running the SP handler;
// forwards a toggle_haul action to the host when is_hauling() actually flipped.
void mp_client_dispatch_hauling_if_changed( bool pre_hauling );

// Enrich a client action JSON with the current client_light and client_bleed fields.
// Call before any direct client_send() to ensure the server always receives light/bleed state.
std::string client_enrich_action( const std::string &json );

// Client only: call immediately after client_send() to suppress stale moves>0
// state packets until the server sends moves=0 (its action acknowledgement).
// Prevents TCP-buffered pre-ack grants from re-unlocking the client.
void client_mark_action_sent();

// Client only: returns true if we have sent an action and are waiting for the
// server's acknowledgement (moves<=0 packet).  Used by do_turn() to block the
// game loop and by mp_dispatch to avoid double-sending while ack is pending.
bool is_client_waiting_for_ack();

// Save the last smash action JSON so it can be re-queued for "keep smashing".
void client_set_autosmash_json( const std::string &json );

// Client only: after any action that consumed avatar moves, send a "wait" to
// the server so the grant/ack cycle advances.  If pre_moves is provided, only
// fires when the avatar has fewer moves now than it did before the action
// (i.e. moves were actually spent).  Pass INT_MAX to fire unconditionally.
// Also resyncs worn items and clears local moves to 0.
void mp_client_post_action( int pre_moves = INT_MAX );

// Ensure the MP debug HUD overlay is active. Safe to call every turn.
void ensure_mp_hud();

// True when running as a dedicated headless server (--server flag).
// Suppresses avatar input and display-related paths in the game loop.
bool is_server_mode();
void set_server_mode( bool enabled );

// True in any multiplayer role: host (--host) or dedicated server (--server).
bool is_mp_mode();

// True when running as an in-process host (--host flag, listen server in background thread).
bool is_host_mode();
void set_host_mode( bool enabled );

// True when this instance is hosting (listen server running), regardless of
// whether it is also a headless dedicated server.
bool is_hosting();

// Called when a world is unloaded (quit-to-menu). Resets per-world MP state —
// currently the stale-NPC sweep guard — so re-entering any
// world in the same process re-runs the orphan-proxy cleanup instead of
// skipping it (the one-shot guard otherwise leaves phantom proxies from a prior
// load-in; reproduced 2026-06-03).
void mp_on_world_exit();

// Load-time migration for worlds with co-op history.  Removes proxy NPCs left
// by an interrupted multiplayer session while the loading screen is active,
// rather than discovering and scanning for them from the per-turn hot path.
void mp_cleanup_stale_npcs_after_load();

// Host: the world's overmap seed (g->get_seed()), captured on the game thread.
// Sent to the client in the join 'welcome' so it can match the host's terrain.
unsigned int mp_host_world_seed();
void mp_set_host_world_name( const std::string &name );
std::string mp_get_host_world_name();
// Host: capture the host avatar OMT each turn for the join 'welcome'.
void mp_capture_host_omt( const tripoint_abs_omt &p );
bool mp_host_omt_valid();
tripoint_abs_omt mp_host_omt();
// Welcome JSON field ",\"host_omt\":[x,y,z]" (or "" if not captured). Net-thread safe.
std::string mp_host_omt_welcome_field();
// Client: the host's OMT from the welcome — start_game spawns here in client mode
// instead of the character's scenario start_location (invalid if not a client join).
tripoint_abs_omt mp_client_spawn_omt();
// Client: stash + pre-parse the join 'welcome' at connect time (seed/omt/names),
// then adopt the seed at start_game time (after its rng_bits() reset) so worldgen
// matches the host. Without this the welcome is only processed on the first
// do_turn — after start_game already built the overmap with a random seed and
// spawned at the character's own scenario start (ocean-spawn / "different
// overmap" co-op join regression, 2026-06-21).
void mp_store_pending_welcome( const std::string &msg );
void mp_client_prepare_spawn();
// Client: world name received from the host's 'welcome' message.  Empty until
// after mp_menu_join_session() returns successfully.
std::string mp_client_host_world_name();
void mp_set_client_host_world_name( const std::string &name );
// Host's character name, plumbed to the client's join dialog ("whose game").
void mp_set_host_player_name( const std::string &name );
std::string mp_get_host_player_name();
std::string mp_client_host_player_name();
void mp_set_client_host_player_name( const std::string &name );

// True when hosting and the host avatar has an active wait activity (ACT_WAIT,
// ACT_WAIT_STAMINA, etc.).  Used by do_turn to skip monmove() so monsters
// freeze while the host fast-forwards, giving the client time to act freely.
bool host_is_in_wait_activity();

// True when do_turn() should run `calendar::turn += 1_turns;` this iteration.
// In SP and host mode, always true.  In client mode, true only when moves > 0
// (i.e. the host just granted a turn) — otherwise the calendar races forward
// at ~10 turns/sec while the client sits in its locked input poll.  Named
// callout so the SP file in do_turn.cpp holds a single boolean check instead
// of an inline MP block — keeps merge-conflict surface minimal.
bool should_advance_calendar();

// True when the given activity id (e.g. "ACT_CRAFT", "ACT_READ") is one where
// the avatar is committed to ticking turns without per-turn user input — i.e.
// safe to fast-forward through.  Excludes interactive activities (firstaid
// where the player picks a target each tick, aim, etc.).
bool is_passive_activity( const std::string &activity_id_str );

// True when both the local avatar and the partner are in passive activities
// (per is_passive_activity).  Used to drop strict lockstep when both sides are
// idle in a long task (both crafting, both reading, host crafting + client
// helping, etc.) so wall-clock progress matches SP fast-forward speed.
// Re-evaluated every turn — naturally exits when SP's activity cancellation
// fires on either side (hostile in sight, low HP, player input, etc.).
bool should_fast_forward();

// Client only: returns true when the client host-NPC proxy occupies the given
// absolute map position.  Used by handle_action to block walk-through-host.
bool is_client_host_at( const tripoint_abs_ms &abs );

// Client only: the host is authoritative for the client avatar's z-position.
// All vertical movement (ramps, ledge falls) arrives via host teleport, so the
// client avatar must never run its own gravity_check / try_fall against the
// local shadow map — which lags map_sync and frequently still shows t_open_air
// on the destination z when the teleport lands, producing a spurious "You fall
// down 1 story!" and impact damage on a perfectly valid ramp crossing.  SP's
// walk_move(via_ramp) never falls; this restores that behavior for the client.
// Returns true when the caller should skip the fall.
bool client_suppress_self_gravity( const Character &who );

// Server only: broadcast a host_died packet to connected clients so they can
// show a "waiting for respawn" message instead of a raw disconnect spam.
// Call this before the death screen takes over.
void notify_client_host_died();

// v1 graceful session-end handshake.  Call from the SP save+quit path when an
// MP session is active — broadcasts a session_ending packet to the partner so
// they see a graceful "your partner is leaving — game saved" message and
// (host only) trigger an auto-save, instead of a raw TCP disconnect.  No-op
// outside MP modes.  Includes a brief sleep so the TCP write completes
// before the caller's socket teardown.
void mp_notify_session_ending();

// Co-op save handshake.  Call immediately after the SP quicksave() runs: the
// host confirms the authoritative save; the client also asks the host to save
// the shared world (save_request -> save_done) so the two stores stay in step.
// No-op outside MP modes.
void mp_after_quicksave();

// Templates wire-sync on join: enumerate the local ~/Library/.../templates/
// dir, send the list to the partner, then exchange any templates the other
// side is missing.  Symmetric — both host and client send their list on
// connect; both receive, diff, request, respond.  Result: both players see
// the union of their template libraries the next time they open Custom
// Character → Load Template.  Local templates with the same name as a
// received one always win (no overwrite).
void mp_templates_sync_on_join();

// Main-menu integration: arms host mode (server thread is spawned later, on
// the first do_turn after world load — see mp_start_pending_host_thread).
// Silent on success (caller drives the next UI step); pops only on error.
// Returns true if host mode is armed (including the no-op "already armed").
bool mp_menu_start_host_session();

// Main-menu integration: prompts for a host address (with optional :port),
// probes, connects, sets client mode.  Silent on success; pops an error
// and returns false on cancel or connection failure.
bool mp_menu_join_session();

// Main-menu integration: disarm a previously armed (but not-yet-started)
// host session.  No-op if host mode isn't armed.
void mp_menu_cancel_host();

// Refresh the SDL window title to reflect the current MP role (SP/HOST/CLIENT).
// main.cpp sets it once at startup from CLI flags; menu-armed mode changes
// need to call this so the title updates after Host/Join is picked from the UI.
void mp_update_window_title();

// Co-op block appended to the debug "Generate game report" output (debug.cpp).
std::string mp_game_report_section();

// Client-only: ensure a minimal scratch world exists so the client's
// character-creation flow doesn't force the user into worldgen when they
// have no local worlds.  The client will be teleported to the host's world
// after spawn — the local world is just scaffolding for the avatar object.
// Returns the scratch WORLD* (creates it on first call), or nullptr on
// failure.  Idempotent: subsequent calls reuse the existing scratch world.
::WORLD *mp_ensure_client_scratch_world();

// Per-world MP marker (save/<world>/mp_world.json).  Written once per session
// when the world is loaded under host or client mode.  Solo sessions never
// touch it — so its presence (or absence) tells the picker which worlds have
// co-op history.  The implicit fallback (mp_world_has_history) also accepts
// older worlds that pre-date the marker by checking for mp_player_*.json or
// mp_npc_cleanup.json files.
struct mp_world_marker {
    std::string first_seen_iso;
    std::string last_seen_iso;
    std::string last_role;          // "host" or "client"
};
mp_world_marker mp_world_marker_load( const std::string &worldname );
bool mp_world_has_history( const std::string &worldname );
// One-line plain-text badge for picker display, e.g. "  (co-op, host)".
// Empty when the world has no co-op history.  Caller chooses the color.
std::string mp_world_marker_badge( const std::string &worldname );
// Host-time co-op validation for a world the host is about to host.  A world
// made via the standalone World > Create World path never went through the
// co-op create-screen's mod/NPC restrictions, so re-check it here.  Fills
// block_reasons (incompatible mods — must not host) and warn_reasons (warn
// mods + random NPCs enabled — may break).  Returns true if there is at least
// one BLOCK reason.  Client/join callers should NOT call this — the host owns
// the shared world and has already validated it.
bool mp_world_coop_block( const std::string &worldname,
                          std::vector<std::string> &block_reasons,
                          std::vector<std::string> &warn_reasons );
// SP Load -> picked a co-op world.  If the world has MP history, pops a
// chooser (Solo / Arm Host / Cancel) and arms host mode when chosen.
// Returns true if the caller should continue loading the world, false to
// cancel.  No-op (returns true) when the world has no history.
bool mp_load_promote_prompt( const std::string &worldname );
// Called from process_mp_events on first turn of each session per world.
void mp_world_marker_update();

// Recent-hosts history persisted under config/mp_recent_hosts.json so the
// Join screen can offer one-tap reconnect to known partners.
struct mp_recent_host {
    std::string host;
    uint16_t port;
    std::string label;          // optional user-typed identifier
};
std::vector<mp_recent_host> mp_recent_hosts_load();
void mp_recent_hosts_save( const std::vector<mp_recent_host> &hosts );
// Insert/promote an entry to the front; dedup on host+port; cap at 8.
// If label is empty, preserves any existing label for the same address.
void mp_recent_hosts_remember( const std::string &host, uint16_t port,
                               const std::string &label );

// Banner text shown above the main menu when an MP session has been started
// from the menu (or via --host / --client flags).  Empty when neither host
// nor client mode is active — caller falls back to its default footer copy.
std::string mp_menu_coop_status_text();

// Server only: grant the remote player one turn's worth of moves and broadcast
// the updated state so the client knows it can act.  Call once per game turn,
// at the top of do_turn(), before the host enters its input loop.
void grant_client_turn();

// Server only: block until the remote player has submitted at least one action
// this turn, then return.  Times out after 30 s so a slow/disconnected client
// never freezes the host permanently.  Call just before monmove().
void wait_for_client_action();

// Server only: record the duration of the last monster/NPC AI turn (in ms) for
// display on the debug HUD.  Call from do_turn() immediately after monmove().
void set_last_monmove_ms( int ms );

// Host only: record the host's most recent input action (e.g. "move_n", "wait")
// so the Co-op HUD's "Queued" row reflects the host's last key, not the client's.
void set_last_host_action_label( const std::string &label );

// Server only: capture avatar-generated messages since pre_msg and queue them
// for the client with "You" → host character name substitution.
// Call from do_turn() after each handle_action() when a remote player is connected.
// pre_msg is a Messages::appended_total() snapshot (monotonic), not size().
void host_capture_avatar_msgs( unsigned long long pre_msg );
// Capture ALL messages from vehmove() and queue them for the remote client as
// their own messages (vehicle collision/status messages the driver should see).
void host_capture_vehmove_msgs( unsigned long long pre_msg );

// Per-tile vehicle position broadcast, called from map::vehmove after each
// successful vehproceed step.  Sends a slim "vehicle_step" packet with just
// pos/face/turn_dir/vel for in-bubble vehicles so the client renders each
// intermediate tile instead of teleporting to the final position.  No-op
// when not hosting.
void host_broadcast_vehicle_step();

// Server only: broadcast the full remote_player_state after a successful host
// action (handle_action returned acted=true).  Mirrors srv_emit_ack's
// post-mutation broadcast for client actions: each host action that mutates
// world state must push the new state to the client immediately, otherwise
// the client only sees host position/world updates at grant boundaries and
// can miss intermediate states when the host takes multiple actions per
// grant cycle.  No-op when not hosting or no remote player connected.
void host_broadcast_post_action();

// Set by do_turn at turn start (before the activity loop runs) to the avatar's
// current activity id, or empty if idle.  client_enrich_action reads this so
// the value sent to the host is the activity that was active at the start of
// the turn, not whatever av.activity holds after the activity may have
// completed mid-turn.
void set_client_turn_activity( const std::string &activity_id_str );

// Read the cached activity id we last told the host about (via activity_start
// dispatch from assign_activity, or the per-turn pre_activity_id snapshot).
// Used to detect activities that started AND ended within a single input-loop
// iteration (typical case: vehicle interact menu assigns ACT_VEHICLE then the
// user cancels) — the natural iter_pre_act/pre_activity_id detectors miss this
// because both were NULL at their respective capture points.  Empty string
// means "we last told the host: no activity".
const std::string &get_client_turn_activity();

// Write a [cdda-mp] log line to /tmp/cdda-mp-server.log or
// /tmp/cdda-mp-client.log (depending on mode).  Use this for any event that
// should be readable after a session without stopping the process.  Do not echo
// to stdout: in curses builds that writes through the active terminal UI.
void mp_log( const std::string &msg );

// DIAGNOSTIC (temporary, 2026-06-23, for #5 assist-distraction / client safe-mode):
// log the safe-mode / hostile decision so we can see whether the client actually
// reacts to an approaching hostile during fast-forward. Named callout (rule 4) so
// the SP site in game.cpp::mon_info_update carries only a one-line MP-guarded call.
// No-op outside MP. Throttled internally (emits only when newseen / nearest-hostile
// distance / safe_mode change) so it never floods the log during 200-turn/sec FF.
void mp_log_safemode_check( int newseen, int mostseen, int safe_mode );

// Per-turn callouts invoked from do_turn.cpp (an SP file) so the MP per-turn
// catch-up/gating logic lives here, not inline in the SP loop (rule 4, minimize
// upstream merge conflicts). Non-client (SP/host) process_turn() still happens
// in the normal SP suffix path.
// mp_do_turn_update_body: catches up the host-driven calendar's jumps (stamina
//   regen, suffers, cravings). mp_do_turn_process_turn: ticks effects/needs once
//   per elapsed game-turn (skip on locked spin, capped catch-up on jumps) and
//   discards process_turn's move regen (client moves come from server grants).
void mp_do_turn_update_body( Character &u );
void mp_do_turn_process_turn( Character &u );

// Client only: re-send the client's current worn-item list, skin tone, hair,
// and wielded weapon to the server so the remote NPC proxy stays in sync.
// Call after any wear/take-off/wield action.
void client_resync_worn();

// Client only: if the avatar has an active wait-type activity (ACT_WAIT,
// ACT_WAIT_STAMINA, etc.), dispatch a "wait" action to the server so its
// timeline advances in sync with the client's local activity.  Call once per
// game turn after the avatar activity loop has run and consumed moves.
// Pass the activity ID that was running BEFORE the loop so the dispatch still
// fires when the activity consumed moves and then called finish() this same turn.
void client_dispatch_wait_for_activity( const activity_id &pre_id = activity_id(),
                                        bool force_idle = false );

// Client only: emit an explicit activity-lifecycle marker to the host.  These
// are signal-only — they don't consume client moves and the host doesn't
// dispatch a handler for them.  The host uses them to open / close the
// lockstep bypass so it can run free while the client ticks a passive
// activity (drop, read, craft, wait, etc.) and re-engages lockstep the
// instant the activity ends, without relying on a stale-timer heuristic.
void client_send_activity_start( const std::string &activity_id_str );
void client_send_activity_end( const std::string &activity_id_str );

// Client only: returns the luminance emitted by the host player (flashlight,
// mutations, etc.) as received in the last state packet.  Used by lightmap.cpp
// to inject a point light at the host NPC position during build_map_cache().
float get_host_luminance();

// Host only: returns the luminance emitted by the remote player (client), as
// received in each action packet.  Used by lightmap.cpp to inject a point light
// at the remote NPC proxy position during build_map_cache().
float get_remote_player_luminance();

// Client only: returns the character_id of the host NPC proxy so lightmap.cpp
// can find the right NPC without knowing internal MP state.
character_id get_host_npc_character_id();

// Host only: returns the character_id of the remote player NPC proxy so
// lightmap.cpp can inject the client's light at the correct position.
character_id get_remote_player_npc_character_id();

// Client only: milliseconds since the server last granted moves to the client.
// Returns a large value if no grant has been received yet.
// Used by do_turn() to auto-send "wait" when the player is idle and the host
// is fast-forwarding through a long activity (wait, sleep, crafting).
int ms_since_last_grant();

// True when the client is in a long activity, so the expensive per-turn tiles
// redraw can be rate-capped (it doesn't need 1:1 repaints while waiting/crafting/
// reading, and skipping frees the client loop to process host grants promptly —
// otherwise a ~317ms draw runs every turn, paces the host to it, and flickers the
// turn border RED). Client-only; false on host/SP so they render normally.
bool client_render_can_throttle();

// Client only: true when the server's last state packet indicated the host is

// Client only: true when the server has told us the proxy NPC is at vehicle controls.
// handle_action uses this to route movement keys through pldrive instead of walk.
bool client_ctrl_veh();

// Client only: immediately set the local ctrl-veh flag (without waiting for the next
// state packet).  Use when the client releases controls via the drive menu so that
// movement keys stop routing to pldrive right away.
void set_client_ctrl_veh( bool b );

// Client only: absolute map position of the vehicle the client is currently
// controlling, as broadcast by the server in the most recent state packet.
// Returns a zero tripoint when not driving.
tripoint_abs_ms client_ctrl_veh_abs();

// Host only: called by sdlsound to enqueue an sfx event for forwarding to the
// client in the next grant.  Silently ignored when not hosting.
void host_queue_sfx( const std::string &id, const std::string &variant, int vol );

// Called after npc_trading::trade() completes with a remote player proxy.
// Sends a trade_delta message so the other side's real avatar gains/loses items.
void mp_post_trade( npc &np, const std::list<item> &items_given,
                    const std::list<item> &items_taken );

// Pass a single item to the adjacent partner.  Opens the inventory picker,
// removes the item from the giver, adds it to the partner proxy, and sends
// a trade_delta so the other side's real avatar gains the item.
void mp_handle_pass_item();

// MP: high-five the adjacent partner. Small mutual morale boost (both players),
// gated on adjacency + the partner being available (idle, not mid-activity).
// A busy partner is never interrupted — the gesture just whiffs with flavor.
void mp_high_five();

// MP: relay a local yell as authoritative world-noise.  Called from game::chat()
// right after the avatar shouts.  No-op on the host (its shout already made real
// noise); on the client it sends a noise-only packet so the host reproduces the
// sound at the remote player's proxy position (monsters hear it).  vol is the
// avatar's shout volume; order=true for command yells (loudest).
void mp_relay_shout( int vol, bool order );

// MP: open the co-op text-chat prompt (ACTION_COOP_CHAT).  Sends the typed line
// to the partner and echoes it locally; shown above the info panel + message log.
void mp_open_chat();

// Overmap note sync — call after add_note / delete_note / mark_note_dangerous
// so the partner's overmap mirrors the change.
void mp_sync_note_add( const tripoint_abs_omt &pos, std::string_view text );
void mp_sync_note_delete( const tripoint_abs_omt &pos );
void mp_sync_note_danger( const tripoint_abs_omt &pos, int radius, bool dangerous );

} // namespace cata_mp

#endif // CATA_SRC_MP_GAMESTATE_H
