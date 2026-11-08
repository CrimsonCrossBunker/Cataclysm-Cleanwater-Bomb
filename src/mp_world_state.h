#pragma once
#ifndef CATA_SRC_MP_WORLD_STATE_H
#define CATA_SRC_MP_WORLD_STATE_H

#include <chrono>
#include <climits>
#include <cstdint>
#include <memory>
#include <set>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <vector>

#include "calendar.h"
#include "character_turn.h"
#include "color.h"
#include "coordinates.h"
#include "mp_entity_registry.h"
#include "type_id.h"
#include "world_identity.h"

class monster;
class vehicle;

namespace cata_mp
{
struct mp_edge_t;
struct mp_hud_t;

// Mutable multiplayer state belongs to one simulation owner. Transport workers
// publish value messages; none may read these structures. Pointer lookup tables
// are transient world-local indexes, never serialized or exposed to Lua.
struct MPSfxEvent {
    std::string id;
    std::string variant;
    int vol = 0;
};

struct mp_chat_line {
    std::string text;
    nc_color color;
};

struct mp_tile_state {
    std::string ter;
    std::string furn;
    std::string items_sig;    // "type:charges,..." — empty when no items
    std::string fields_sig;   // "type:intensity,..." — empty when no fields
    std::string trap_sig;     // trap id string, empty = tr_null (no placed trap)
    std::string graffiti_sig; // empty = no graffiti
    std::string partial_con_sig; // "construction:counter:ncomponents", empty = no build site
};

struct pending_omsync_t {
    int z = 0, ox = 0, oy = 0, w = 0;
    std::vector<oter_id> cells;   // row-major resolved terrain
    std::vector<char> ok;         // 1 = apply this cell, 0 = skip (ungenerated)
    size_t cursor = 0;
    bool active = false;
};

struct host_replication_baselines {
    std::unordered_map<std::string, std::string> player_appearance;
    // Server: nids for which the full vehicle save-format snapshot has already been
    // broadcast to the current client.  First broadcast of a previously-unknown
    // vehicle includes the "snapshot" payload so the client can mirror the SP
    // map::add_vehicle path; subsequent broadcasts stay slim.  Cleared on client
    // connect so a fresh client receives snapshots for every visible vehicle.
    // Also dropped per-nid when the vehicle's parts vector changes size (install,
    // remove, fold/unfold, damage-purge) so a structural mutation triggers a full
    // re-snapshot — the slim parts/cargo deltas cover state-on-existing-parts only.
    std::unordered_set<uint32_t> client_known_veh_nids{};
    // Server: per-nid baseline of the parts vector size from the last broadcast.
    // Any change (install/remove/purge) invalidates that nid's snapshot tracking
    // so the client receives a fresh full snapshot rather than indices that drift
    // from the host's vector.
    std::unordered_map<uint32_t, size_t> server_veh_parts_count{};
    // Server: nids broadcast in the most recent state packet.  Diffed against the
    // current iteration to detect vehicles that have disappeared (folded, fully
    // destroyed, driven out of bubble) so we can emit a "removed_vehicles" entry
    // in the state packet for the client to clean up.
    std::unordered_set<uint32_t> server_veh_live_nids{};
    // Host: nids of monsters that were alive (and net-id'd) at the last broadcast.
    // Diff against the currently-alive set to emit "removed_monsters" — monsters
    // that genuinely DIED/left the bubble, not merely ones outside the broadcast
    // radius. The client removes only these and never culls by absence, so a
    // transient short broadcast can't kill a live monster (the woodpecker bug).
    std::unordered_set<uint32_t> server_mon_known_nids{};
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
    std::unordered_map<uint32_t, std::string> server_mon_last_sent{};
    // Map-sync sent-set and forward declaration — defined later in the map-streaming
    // section but referenced in the move handler (process_remote_action).
    std::set<tripoint_abs_sm> map_sync_sent{};
    std::unordered_map<tripoint_abs_ms, mp_tile_state> tile_baseline{};
    // Server→client vehicle cargo baseline.  Same keying as the client direction —
    // without this the client can't see items the host drops into trunks/seats/etc.,
    // and its stale snapshot would then overwrite the host on the next client drop.
    std::unordered_map<tripoint_abs_ms, std::string> host_veh_cargo_baseline{};
    std::string last_vehicle_step_payload{};
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
    int om_sync_radius = 90;   // OMTs around the host (covers the m-screen)
    tripoint_abs_omt om_sync_last_center{ INT_MIN, INT_MIN, 0 };
    int om_sync_last_client_z = INT_MIN;   // proxy z at last sync (stair retrigger)
    bool om_sync_done = false;
    int keyframe_ctr = 0;
    std::string host_worn_json_cache{};
    std::string host_worn_sig_cache{};
};

struct client_replication_state {
    // Client: maps server vehicle network IDs to the last-known absolute tile position.
    // Used to look up the vehicle object before moving it to the server-authoritative position.
    std::unordered_map<uint32_t, tripoint_abs_ms> client_veh_pos{};
    monster_mirrors monsters{};
    // Client: true after the first successful long-range teleport to the host area.
    // The heavy place_player_overmap() is only needed once per session.
    bool initial_teleport_done = false;
    // Client→server tile baselines: track what was last sent so we only send diffs.
    // Fields are host-authoritative — the host generates the dust/blood/etc. that
    // the client sees via tile_changes, and the client must not echo them back or
    // the host's own state ping-pongs back as ~80 KB per turn.  apply_tile_changes
    // refreshes these baselines from server-pushed state so the next outgoing
    // build_client_tile_changes recognizes the tile as unchanged and skips it.
    std::unordered_map<tripoint_abs_ms, std::string> client_item_baseline{};
    std::unordered_map<tripoint_abs_ms, std::string> client_terfurn_baseline{};
    std::unordered_map<tripoint_abs_ms, std::string> client_trap_baseline{};
    std::unordered_map<tripoint_abs_ms, std::string> client_graffiti_baseline{};
    std::unordered_map<tripoint_abs_ms, std::string> client_field_baseline{};
    std::unordered_map<tripoint_abs_ms, std::string> client_partial_con_baseline{};
    // Client→server vehicle cargo baseline.  Keyed by the absolute tile position
    // of the cargo vpart so the host can find the vehicle + part by tile lookup.
    // Mirrors the item baseline but for items stored inside vehicle cargo parts
    // (trunks, freezers, lockers, etc.).
    std::unordered_map<tripoint_abs_ms, std::string> client_veh_cargo_baseline{};
    // Client→server worn-list baseline.  When the worn signature changes (e.g.
    // drop_activity_actor peeled a worn garment off as part of a drop), we trigger
    // a client_resync_worn() so the host's proxy mirrors the new worn list.
    // Plain signature string keyed on typeId + variant + wielded id.
    std::string client_worn_baseline{};
    // Client: last known HP per net ID — used to synthesise combat hit/death messages.
    std::unordered_map<uint32_t, int> last_monster_hp{};
    // Client: last known HP per bodypart string ID — used to synthesise "you were hit" messages.
    std::unordered_map<std::string, int> last_bodypart_hp{};
    // Client: net_ids of synced monsters the client just killed locally, awaiting the
    // host's authoritative confirmation. Value = remaining syncs to suppress a
    // host-rebroadcast respawn. The host hasn't processed the forwarded kill yet, so
    // it keeps broadcasting the monster alive; without this, apply_monster_sync
    // respawns it ("killed the zed, it rose again, dropped 2-3 corpses" — GH#1). The
    // loop repeats, each iteration leaving a host-side corpse that syncs back.
    // Bounded: a kill the host REJECTS (HP desync) reappears after the window
    // instead of vanishing forever.
    std::unordered_map<uint32_t, int> client_pending_kill{};
    // Client: fingerprint of the last host_worn list applied — avoids re-dressing every tick.
    std::string client_host_worn_sig{};
    // FIFO of per-z regions.  The host may stream more than one floor's overmap in a
    // turn (host and client on different z), so each region drains independently
    // instead of overwriting the previous (the v1 single buffer).
    std::vector<pending_omsync_t> pending_omsync{};
    std::unordered_set<uint32_t> ever_seen_nids{};
    std::unordered_map<std::string, int> phantom_strikes{};
};

struct world_replication_state {
    entity_registry entity_ids{};
    bool applying_remote_note = false;
    client_replication_state client;
};

struct host_turn_state {
    std::vector<MPSfxEvent> host_sfx_queue{};
    // Server: cumulative AP for the remote player (replaces the NPC's own moves which
    // are skipped by monmove since is_remote_player() returns true).
    int remote_moves = 0;
    // Server: true if grant_client_turn() issued a real grant this turn (the client's
    // carried move budget was positive).  False on a "deficit turn" — the client is
    // still paying off an expensive move's AP debt — and wait_for_client_action()
    // skips its blocking wait so the host advances monmove() solo while the client
    // stays locked, mirroring SP where an expensive move costs several turns.
    bool granted_this_turn = true;
    // Host-only one-shot: when set, the next serialize_remote_player_state()
    // broadcast carries "wake_client":true and the flag is cleared.  Drives the
    // host→client direction of the tap-on-shoulder action.
    bool pending_wake_client = false;
    std::string wake_from;
    // Host-only one-shot signals for host→client partner interactions.  The host
    // performs the swap/push locally (SP path); these flags piggy-back on the next
    // state broadcast so the client can render the observer message ("<host> swaps
    // places with you.") locally from the proxy's real name — no rendered text is
    // shipped, so there is no grammar/POV rewriting to break.
    bool pending_partner_swap = false;
    std::string swap_from;
    bool pending_partner_push = false;
    std::string push_from;
    // Server: monotonic message-append watermark at last forward — used to forward
    // only NEW messages.  Uses Messages::size() (never decremented) rather
    // than size(), which is capped at MESSAGE_LIMIT and stalls once the log fills.
    unsigned long long last_forwarded_msg_count = 0;
    // Server: messages captured during a remote player action that are forwarded
    // verbatim (after NPC→"You" substitution) regardless of NPC name filter.
    // Cleared by serialize_remote_player_state() when it consumes them.
    std::vector<std::string> action_msgs_pending{};
    // Server: messages from the avatar's own actions, forwarded to the client with
    // "You" → host character name so the client sees attributed host hits.
    // Populated by host_capture_avatar_msgs(); cleared by serialize_remote_player_state().
    std::vector<std::string> host_action_msgs_pending{};
    // Server: monotonically increasing sequence number, incremented each grant_client_turn().
    // Included in every state packet so the client can distinguish a fresh grant from a
    // TCP-buffered duplicate of a previous grant.
    uint32_t grant_seq = 0;
    // Server: set when the remote player has submitted at least one real action
    // this turn.  Cleared by grant_client_turn(); checked by wait_for_client_action().
    bool client_acted_this_turn = false;
    // Host-side: last client_ping stamp we received, to echo back next broadcast.
    int64_t last_client_ping_stamp = -1;
    // Host-only: tracks whether the proxy NPC was previously resolvable.  Used to
    // detect the alive→gone transition so we can distinguish "proxy died in
    // combat on host" (notify client, disconnect) from "proxy was never spawned
    // yet" or "still null after a recent disconnect".  Cleared on disconnect; set
    // to true on the first grant where the proxy resolves.
    bool proxy_was_alive = false;
};

struct client_turn_state {
    // Socket reads may refresh a view many times in one host turn. Only the
    // main loop consumes a new clock value and advances the local character.
    time_point observed_host_turn = calendar::before_time_starts;
    time_point processed_host_turn = calendar::before_time_starts;
    bool group_fast_forward = false;
    character_turn_driver character_turns;
    // Client: "keep smashing" continuation state.
    // When set, auto-re-fire the smash action after each partial bash until the
    // target is destroyed or the bash fails to make progress.
    bool client_autosmash = false;
    std::string client_autosmash_json{}; // the smash JSON to re-fire
    bool autosmash_pending = false;    // fire the smash on the next available grant
    // Set when a partial-bash result arrives and we need to ask "Keep smashing?".
    // The query MUST run from the main do_turn loop (client_resolve_pending_ui),
    // never inline in apply_one_state_message — a blocking popup from inside network
    // processing is the same re-entrant-UI crash class as the aim bug.
    bool client_smash_query_pending = false;
    // Client: set when the host sends host_died or the socket drops.
    // Suppresses further processing and the lost-connection spam.
    bool server_died = false;
    // Client: an action is pending until a matching response or a newer grant.
    // Repeated positive-budget snapshots never restore spent moves.
    bool client_waiting_for_ack = false;
    // Client: true when the server's proxy NPC is at vehicle controls.
    // Set by apply_state_packet() from the "client_ctrl_veh" field.
    // handle_action uses this to route movement keys to pldrive.
    bool client_ctrl_veh = false;
    // Client: absolute position of the controlled vehicle (root tile).
    // Set alongside g_client_ctrl_veh from "client_veh_pos" in the state packet.
    tripoint_abs_ms client_ctrl_veh_abs{ 0, 0, 0 };
    // Diagnostic timestamp; elapsed wall time never unlocks an action grant.
    std::chrono::steady_clock::time_point ack_set_time{};
    // Timestamp of when the server last granted moves (moves > 0 packet received).
    // Used by ms_since_last_grant() to auto-send "wait" when the player is idle.
    std::chrono::steady_clock::time_point last_grant_time{};
    // Client: last grant_seq that was successfully applied (moves > 0 path).
    // Guards the "new grant" branch: a packet with grant_seq <= g_client_last_grant_seq
    // is a stale buffered duplicate and its moves value is ignored.
    uint32_t client_last_grant_seq = 0;
    // Client-side: the stamp we're currently awaiting an echo for. RTT is measured
    // exactly once per round trip (when its echo returns), then this is cleared so
    // a host re-echoing the same stale stamp during idle can't keep inflating the
    // number. -1 = nothing outstanding (hold the last measured value).
    int64_t pending_ping_stamp = -1;
    // Client's avatar activity id snapshot at the start of each do_turn iteration.
    // Sent over the wire instead of av.activity at enrich-time because the activity
    // can finish (set_to_null) mid-turn, leaving av.activity null when the wait
    // dispatch runs — which would mask the activity from the host's HUD.
    std::string client_turn_activity{};
    // Client → host message forwarding.  When the client's avatar generates a
    // notable "You ..." message (e.g. "Now reading X", "You start crafting Y"),
    // we capture it here and tack it onto the next outgoing action so the host
    // sees a name-substituted version ("Roy now reads X") in their own log.
    // Monotonic append watermark (Messages::size()), not size() — see
    // g_last_forwarded_msg_count note.
    unsigned long long client_msg_watermark = 0;
    std::vector<std::string> client_msgs_pending{};
};

struct peer_observation {
    // Partner activity id (e.g. "ACT_DROP", or "" for none).  On the host this is
    // the client's activity (set from action packets); on the client this is the
    // host's activity (set from state packets).  Display-only — the actual
    // activity ticks on the side that owns the player.  Used by the Co-op HUD and
    // transition-edge messages.
    std::string partner_activity{};
    // Stable identity of the player this helper committed to.
    std::string partner_help_target{};
    bool partner_sleeping = false;
    // Progress % (0-100) of the partner's current activity.  Forwarded each
    // action/state packet alongside g_partner_activity.  Read by the Co-op panel.
    int partner_activity_pct = 0;
    // Total moves required by the partner's current activity (act.moves_total).
    // Read by the bump-menu predicate to decide whether the "Help with task"
    // option should appear (gate: >= HELPER_MIN_MOVES_TOTAL).  Zero when idle.
    int partner_activity_moves_total = 0;
    // Partner's morale level (Character::get_morale_level()).  Forwarded on the
    // same state packet as the activity fields; read by the Co-op panel to show a
    // mood indicator.  Piggybacks the existing packet so it costs no extra traffic
    // and updates whenever that packet fires (no per-frame work).
    int partner_morale = 0;
    // Partner's worst-hurt body part, real current/max HP, synced from the partner's
    // OWN character (not read off the local proxy, whose max HP is derived from proxy
    // stats and so disagrees with the partner's real max — which threw off the bar's
    // length and color). Fed straight into get_hp_bar() so the Co-op panel bar is
    // pixel-identical to the partner's sidebar limb bar. max<=0 = not yet received.
    int partner_hp_cur = 0;
    int partner_hp_max = 0;
    // Round-trip latency to the partner, in milliseconds; -1 until first measured.
    // Measured on the CLIENT via a stamp/echo on the existing packets (no clock
    // sync needed), then mirrored back to the host so both panels show the same
    // number.  Replaces the old dev-only calendar-drift indicator in the Co-op
    // panel.
    int partner_ping_ms = -1;
    // Last calendar turn the partner reported.  Used to display sync drift in the
    // Co-op panel: drift = local calendar - partner calendar.  Under lockstep
    // both sides should always advance together; nonzero drift is a useful sanity
    // indicator for the player.
    int partner_calendar_turn = 0;
    // Last name the partner reported.  Used by the Co-op panel as a fallback when
    // the local proxy NPC isn't (yet) resolvable — proxy spawn races the panel on
    // first connect; this lets the panel still show *something* instead of
    // "Partner unknown".
    std::string partner_name_cached{};
    // Client: luminance emitted by the host player (flashlight, mutations, etc.).
    // Received from state packet each turn and injected into the lighting pass.
    float mp_host_luminance = 0.0f;
    // Host: luminance emitted by the remote player (client). Received from each
    // action packet and injected into the host's lighting pass at the proxy NPC position.
    float mp_remote_player_luminance = 0.0f;
    // Client: last confirmed position of the remote player (our avatar as seen by the server).
    // Used as the center of the monster sync region.
    tripoint_abs_ms mp_remote_pos{ 0, 0, 0 };
};

struct client_admission_state {
    // Host authority namespace; never the client's local scratch-world ID.
    world_id host_world;
    // Client: world name received from host in 'welcome'.  Empty until the first
    // welcome is processed.  Exposed via mp_client_host_world_name().
    std::string client_host_world_name{};
    // Client: the host's seed as received in 'welcome', and whether we've applied
    // it to g->set_seed() yet. Applied before the initial host-area overmap is
    // generated so the client's terrain matches the host's. 0 = not yet received.
    unsigned int client_host_seed = 0;
    bool client_host_seed_applied = false;
    // Client: the raw join 'welcome' stashed at connect time so start_game() can
    // adopt the host seed + spawn-omt BEFORE worldgen. The welcome's own arrival on
    // the first do_turn is too late — start_game has already built the host-area
    // overmap with the client's own rng_bits() seed by then. See
    // mp_store_pending_welcome() / mp_client_prepare_spawn().
    std::string pending_welcome{};
    // Client: the host's OMT received in 'welcome' — the spawn target start_game uses
    // in client mode. invalid until a welcome carrying host_omt is processed.
    tripoint_abs_omt client_host_spawn_omt = tripoint_abs_omt::invalid;
    // Client: the host's character name received in 'welcome'. Empty until processed.
    std::string client_host_player_name{};
};

struct session_presentation {
    session_presentation();
    ~session_presentation();
    session_presentation( session_presentation && ) noexcept;
    session_presentation &operator=( session_presentation && ) noexcept;
    session_presentation( const session_presentation & ) = delete;
    session_presentation &operator=( const session_presentation & ) = delete;

    // Server: short label for the last action type received from the client this turn.
    // Reset to em-dash by grant_client_turn() at the start of each host turn.
    // Displayed on the server HUD "Queued" row as the partner-side equivalent.
    std::string last_client_action_label = "\xe2\x80\x94";
    // Host: the host's own last input action.  Captured at the end of handle_action
    // so the local "Queued" HUD field actually reflects the host's most recent key,
    // not the client's (which was the previous, misleading behavior).
    std::string last_host_action_label = "\xe2\x80\x94";
    std::string partner_activity_prev{};
    // Separation warning tier: 0=ok, 1=warn (≥50 tiles), 2=danger (≥57 tiles).
    // Shared by both host and client; resets on connect/disconnect.
    // Hysteresis: step up at 50/57, step down at 44/50.
    int separation_tier = 0;
    // False until the host+client have been confirmed close (<40 tiles) at least once
    // this session. Suppresses the join transient: the client proxy spawns at its
    // scenario start (far) and is teleported next to the host a beat later, so the
    // first separation checks would otherwise fire "close the gap now" before the
    // players are actually together. Reset on session end / world exit.
    bool separation_settled = false;
    std::vector<mp_chat_line> mp_chat_overlay{};   // newest last
    // Smoother for the brief moves=0 gap between a sent action and the next grant.
    // Module-scope so the edge frame and the panel border pulse together.
    std::chrono::steady_clock::time_point mp_last_go_time =
        std::chrono::steady_clock::now() - std::chrono::seconds( 10 );
    std::unique_ptr<mp_edge_t> mp_edge{};
    std::unique_ptr<mp_hud_t> mp_hud{};
    int debt_skips = 0;
    std::chrono::steady_clock::time_point last_redraw =
        std::chrono::steady_clock::now();
    int last_newseen = -2;
    int last_nearest = -2;
    int last_safe = -2;
    int last_help_pct = -1;
    int last_build_pct = -1;
    std::string last_overlay{};
    std::string client_drain_last{};
    std::string last_excluded_near{};
    int last_n_sent = -1;
    std::unordered_set<uint32_t> logged_skip_nids{};
    int last_phantom = -1;
    std::string last_bp{};
};

} // namespace cata_mp

#endif // CATA_SRC_MP_WORLD_STATE_H
