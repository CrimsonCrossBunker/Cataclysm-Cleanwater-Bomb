#pragma once
#ifndef CATA_SRC_BASECAMP_H
#define CATA_SRC_BASECAMP_H

#include <cstddef>
#include <cstdint>
#include <functional>
#include <list>
#include <map>
#include <memory>
#include <optional>
#include <set>
#include <string>
#include <string_view>
#include <unordered_set>
#include <utility>
#include <vector>

#include "calendar.h"
#include "character_id.h"
#include "coordinates.h"
#include "craft_command.h"
#include "game_constants.h"
#include "inventory.h"
#include "item_components.h"
#include "item_location.h"
#include "map.h"
#include "mapgendata.h"
#include "memory_fast.h"
#include "mission_companion.h"
#include "point.h"
#include "requirements.h"
#include "safe_reference.h"
#include "stomach.h"
#include "translation.h"
#include "type_id.h"
#include "units_fwd.h"

class Character;
class JsonObject;
class JsonOut;
class basecamp;
class character_id;
class faction;
class inventory_filter_preset;
class item;
class npc;
class recipe;
enum class farm_ops;
struct MonsterGroupResult;

const int work_day_hours = 10;
const int work_day_rest_hours = 8;
const int work_day_idle_hours = 6;

struct expansion_data {
    std::string type;
    std::vector<itype_id> available_pseudo_items;
    std::map<std::string, int> provides;
    std::map<std::string, int> in_progress;
    tripoint_abs_omt pos;
    // legacy camp level, replaced by provides map and set to -1
    int cur_level = 0;

};

using npc_ptr = shared_ptr_fast<npc>;
using comp_list = std::vector<npc_ptr>;

namespace base_camps
{

enum tab_mode : int {
    TAB_MAIN,
    TAB_N,
    TAB_NE,
    TAB_E,
    TAB_SE,
    TAB_S,
    TAB_SW,
    TAB_W,
    TAB_NW
};

struct direction_data {
    // used for composing mission ids
    std::string id;
    // tab order
    tab_mode tab_order;
    // such as [B], [NW], etc
    translation bracket_abbr;
    // MAIN, [NW], etc
    translation tab_title;
};

// base_dir and the eight directional points
extern const std::map<point_rel_omt, direction_data> all_directions;

point_rel_omt direction_from_id( const std::string &id );

constexpr point_rel_omt base_dir;
const std::string prefix = "faction_base_";
const std::string id = "FACTION_CAMP";
const int prefix_len = 13;
std::string faction_encode_short( const std::string &type );
std::string faction_encode_abs( const expansion_data &e, int number );
std::string faction_decode( std::string_view full_type );
time_duration to_workdays( const time_duration &work_time );
int max_upgrade_by_type( const std::string &type );
} // namespace base_camps

// camp resource structures
struct basecamp_resource {
    itype_id fake_id;
    itype_id ammo_id;
    int available = 0;
    int consumed = 0;
};

struct basecamp_fuel {
    itype_id ammo_id;
    int available = 0;
};

/** A typed, all-or-nothing change to one Platform-visible camp resource. */
struct basecamp_platform_resource_change {
    itype_id resource_id;
    std::int64_t delta = 0;
};

enum class basecamp_platform_actor_lookup_status : std::uint8_t {
    found,
    authoritative_not_found,
    unknown,
    ambiguous
};

struct basecamp_platform_actor_lookup_result {
    basecamp_platform_actor_lookup_status status =
        basecamp_platform_actor_lookup_status::unknown;
    npc_ptr actor;
};

using basecamp_platform_actor_lookup = std::function <
                                       basecamp_platform_actor_lookup_result( character_id id ) >;

inline constexpr std::uint32_t basecamp_platform_task_schema_version = 3;
inline constexpr std::uint32_t basecamp_platform_task_schema_version_legacy_v1 = 1;
inline constexpr std::uint32_t basecamp_platform_task_schema_version_legacy = 2;
inline constexpr std::string_view basecamp_platform_worker_reservation_kind =
    "worker_reservation";
inline constexpr std::string_view basecamp_platform_resource_work_kind =
    "resource_work";
inline constexpr std::string_view basecamp_platform_resource_work_parameter_schema =
    "resource_work_v1";
inline constexpr std::string_view basecamp_platform_recipe_work_kind =
    "recipe_work";
inline constexpr std::string_view basecamp_platform_recipe_work_parameter_schema =
    "recipe_work_v1";
inline constexpr std::string_view basecamp_platform_upgrade_work_kind =
    "upgrade_work";
inline constexpr std::string_view basecamp_platform_upgrade_work_parameter_schema =
    "upgrade_work_v1";
inline constexpr std::uint32_t basecamp_platform_expansion_schema_version = 1;

/** A typed resource or food delta used by the Platform resource-work kind. */
struct basecamp_platform_resource_work {
    std::vector<basecamp_platform_resource_change> resource_inputs;
    std::vector<basecamp_platform_resource_change> resource_outputs;
    std::optional<std::int64_t> food_input_kcal;
    std::optional<std::int64_t> food_output_kcal;
    std::int64_t duration_turns = 0;
};

/** A persisted, explicit holder identity used by the recipe_work vertical slice.
 *
 * The first slice deliberately accepts only Character-owned slots.  The native
 * item holder API remains the source of truth for other holder kinds, but they
 * are rejected here until their escrow/refund lifecycle can be persisted safely.
 */
enum class basecamp_platform_recipe_holder_kind : std::uint8_t {
    character,
};

struct basecamp_platform_recipe_holder {
    basecamp_platform_recipe_holder_kind kind =
        basecamp_platform_recipe_holder_kind::character;
    character_id character;
    std::uint64_t identity_generation = 0;
    std::string slot;
};

/** One exact item moved into a persistent recipe task escrow. */
struct basecamp_platform_recipe_escrow_item {
    std::int64_t stable_uid = 0;
    std::uint64_t identity_generation = 0;
    std::int64_t charges = 0;
    bool tool = false;
    // Native item serialization is task-owned persistence, not a Lua-facing
    // JSON/object API and never contains a GameHandle.
    std::string serialized_item;
    basecamp_platform_recipe_holder source_holder;
};

/** Typed recipe task descriptor.  Source holders and destination are stable
 * values; live Lua handles are supplied again at start/cancel/complete. */
struct basecamp_platform_recipe_work {
    std::string recipe_id;
    int batch = 1;
    std::int64_t duration_turns = 0;
    std::vector<basecamp_platform_recipe_holder> source_holders;
    basecamp_platform_recipe_holder destination_holder;
};

enum class basecamp_platform_upgrade_target_kind : std::uint8_t {
    camp_core,
    expansion,
};

enum class basecamp_platform_upgrade_commit_state : std::uint8_t {
    committed,
    not_committed,
    unknown,
};

/** Typed, persisted descriptor for one Platform camp blueprint upgrade. */
struct basecamp_platform_upgrade_work {
    std::string upgrade_id;
    std::string blueprint_id;
    basecamp_platform_upgrade_target_kind target_kind =
        basecamp_platform_upgrade_target_kind::camp_core;
    std::uint64_t target_core_generation = 0;
    std::uint64_t target_expansion_id = 0;
    std::uint64_t target_expansion_generation = 0;
    tripoint_abs_omt target_position;
    std::string target_terrain;
    mapgen_arguments mapgen_args;
    std::int64_t duration_turns = 0;
    std::vector<basecamp_platform_recipe_holder> source_holders;
    // Remaining non-consumed tools and failed-refund values are returned only
    // to this explicit Character holder after terminal settlement.
    basecamp_platform_recipe_holder destination_holder;
};

/** A detached, generation-safe identity for one Platform camp expansion. */
struct basecamp_platform_expansion {
    std::uint64_t expansion_id = 0;
    std::uint64_t identity_generation = 1;
    std::uint64_t camp_id = 0;
    point_rel_omt direction;
    tripoint_abs_omt position;
    std::string type;
    std::string name;
    bool work_in_progress = false;
};

/** Operations a Platform camp-task executor may expose. */
enum class basecamp_platform_task_operation : std::uint8_t {
    preflight,
    resolve,
    start,
    cancel,
    complete
};

enum class basecamp_platform_task_state : std::uint8_t {
    pending,
    running,
    refund_pending,
    completed_unclaimed,
    completed,
    cancelled
};

struct basecamp_platform_task {
    std::uint64_t task_id = 0;
    std::uint64_t identity_generation = 1;
    std::uint64_t camp_id = 0;
    faction_id owner_faction;
    character_id manager;
    character_id worker;
    std::uint64_t manager_identity_generation = 0;
    std::uint64_t worker_identity_generation = 0;
    std::string kind;
    std::string parameters;
    basecamp_platform_task_state state = basecamp_platform_task_state::pending;
    time_point started_at = calendar::before_time_starts;
    time_point due_at = calendar::before_time_starts;
    std::optional<time_point> finished_at;
    // Typed resource_work parameters and its persisted task-owned input ledger.
    std::optional<basecamp_platform_resource_work> resource_work;
    std::vector<basecamp_platform_resource_change> reserved_resources;
    std::int64_t reserved_food_kcal = 0;
    bool reservation_discarded = false;
    // Typed recipe_work parameters and task-owned serialized item escrow.
    std::optional<basecamp_platform_recipe_work> recipe_work;
    // Typed upgrade_work parameters reuse the same task-owned Item escrow;
    // upgrade completion never publishes an Item directly to an external
    // holder.
    std::optional<basecamp_platform_upgrade_work> upgrade_work;
    std::vector<basecamp_platform_recipe_escrow_item> recipe_escrow;
    // Non-zero only after the detached authoritative recipe settlement has
    // been committed into this task's escrow.  It is persisted so a reload
    // cannot mistake a completed-unclaimed escrow for an uncommitted recipe.
    std::uint64_t recipe_commit_marker = 0;
    // Non-zero only after a transactional upgrade has published its mapgen
    // and metadata change.  It makes completion idempotent across reloads.
    std::uint64_t upgrade_commit_marker = 0;
    // Non-zero only while an upgrade mapgen transaction is being applied.  A
    // save observed at this boundary must reconcile against authoritative
    // terrain and metadata before it can be retried or finalized.
    std::uint64_t upgrade_applying_marker = 0;
    // Invalid persisted escrow is isolated in-place so recovery tooling can
    // inspect it without silently dropping an owned Item value.
    bool recipe_recovery_required = false;
    // This is runtime-only state.  Active records set it after deserialization
    // or an actor unload and keep the durable record alive until the exact
    // actor lifetime is seen again.
    bool awaiting_reconciliation = false; // NOLINT(cata-serialize)
};

/**
 * Native context handed to one registered Platform task executor.
 *
 * The basecamp layer owns lookup, staging, and final swaps.  A kind executor
 * owns only its typed lifecycle semantics through this context; it never
 * receives a UI mission or a raw JSON object.
 */
struct basecamp_platform_task_execution_context {
    basecamp *camp = nullptr;
    basecamp_platform_task *task = nullptr;
    npc_ptr worker;
    std::vector<basecamp_platform_task> *staged_tasks = nullptr;
    std::vector<npc_ptr> *staged_assigned = nullptr;
    std::vector<basecamp_resource> *staged_resources = nullptr;
    std::int64_t staged_food_delta_kcal = 0;
    std::int64_t staged_food_liability_kcal = 0;
    bool commit_worker_assignment = false;
    bool commit_worker_release = false;
    const std::vector<basecamp_platform_recipe_escrow_item> *recipe_escrow = nullptr;
    const std::vector<basecamp_platform_recipe_escrow_item> *recipe_original_escrow = nullptr;
    bool recipe_completion = false;
    bool recipe_claim = false;
    bool upgrade_completion = false;
    // These two flags are used only by the upgrade executor's staged
    // transaction.  The prepare pass may set an applying marker; the commit
    // pass is deliberately no-fail and only publishes already-prepared
    // detached values after mapgen succeeds.
    bool upgrade_prepare_only = false;
    bool upgrade_commit_ready = false;
    time_point now = calendar::before_time_starts;
    time_duration duration = time_duration::from_turns( 0 );
    bool complete = false;
};

using basecamp_platform_task_executor_dispatch = bool ( * )(
            basecamp_platform_task_operation operation,
            basecamp_platform_task_execution_context &context, std::string &error );

/**
 * The single native registry entry for a Platform camp-task kind.
 *
 * The executor owns the parameter schema and explicitly declares every
 * lifecycle operation it can perform.  UI mission kinds are not registry
 * entries and cannot reach the Platform task API through this boundary.
 */
struct basecamp_platform_task_kind_executor {
    std::string_view kind;
    std::string_view parameter_schema;
    bool supports_preflight = false;
    bool supports_resolve = false;
    bool supports_start = false;
    bool supports_cancel = false;
    bool supports_complete = false;
    bool ( *validate_parameters )( std::string_view parameters,
                                   std::string &error ) = nullptr;
    basecamp_platform_task_executor_dispatch dispatch = nullptr;
};

const basecamp_platform_task_kind_executor *find_basecamp_platform_task_executor(
    std::string_view kind ) noexcept;
bool validate_basecamp_platform_task_kind(
    std::string_view kind, std::string_view parameters,
    basecamp_platform_task_operation operation, std::string &error );
bool dispatch_basecamp_platform_task(
    std::string_view kind, basecamp_platform_task_operation operation,
    basecamp_platform_task_execution_context &context, std::string &error );

bool validate_basecamp_platform_resource_work(
    const basecamp_platform_resource_work &work, std::string &error );
bool validate_basecamp_platform_recipe_work(
    const basecamp_platform_recipe_work &work, std::string &error );
bool validate_basecamp_platform_upgrade_work(
    const basecamp_platform_upgrade_work &work, std::string &error );
/** Resolve blueprint mirror/rotation flags for an exact camp direction. */
bool basecamp_upgrade_orientation_flags(
    const recipe_id &recipe, const point_rel_omt &direction,
    bool &mirror_horizontal, bool &mirror_vertical, int &rotation,
    std::string_view base_error_message, const std::string &actor );

/** Keep newly created task ids above ids restored from a save. */
void reserve_platform_task_id( std::uint64_t id );
/** Keep newly created expansion ids above ids restored from a save. */
void reserve_platform_expansion_id( std::uint64_t id );

std::string basecamp_platform_task_state_name( basecamp_platform_task_state state );
std::optional<basecamp_platform_task_state>
basecamp_platform_task_state_from_name( std::string_view name );

struct basecamp_upgrade {
    std::string bldg;
    mapgen_arguments args;
    translation name;
    bool avail = false;
    bool in_progress = false;
};

struct expansion_salt_water_pipe_segment {
    tripoint_abs_omt point;
    bool started;
    bool finished;
};

struct expansion_salt_water_pipe {
    point_rel_omt expansion;
    point_rel_omt connection_direction;
    std::vector<expansion_salt_water_pipe_segment> segments;
};

class basecamp_map
{
        friend basecamp;
    private:
        std::unique_ptr<map> map_;
    public:
        basecamp_map() = default;
        basecamp_map( const basecamp_map & );
        basecamp_map &operator=( const basecamp_map & );
};

class basecamp
{
    public:
        basecamp();
        basecamp( const std::string &name_, const tripoint_abs_omt &omt_pos );
        basecamp( const std::string &name_, const tripoint_abs_ms &bb_pos_,
                  const std::vector<point_rel_omt> &directions_,
                  const std::map<point_rel_omt, expansion_data> &expansions_ );
        /** Stable identity used by the Lua Platform, persisted with a camp. */
        std::uint64_t platform_id() const noexcept;
        /** Stable generation for the exact camp-core upgrade target. */
        std::uint64_t platform_core_upgrade_generation() const noexcept;
        /** Set an identity restored from a save or supplied by the engine. */
        void set_platform_id( std::uint64_t id );
        /** Lifetime-safe reference for one exact basecamp object. */
        safe_reference<basecamp> get_safe_reference();
        inline bool is_valid() const {
            return !name.empty() && omt_pos != tripoint_abs_omt();
        }
        inline int board_x() const {
            return bb_pos.x();
        }
        inline int board_y() const {
            return bb_pos.y();
        }
        inline tripoint_abs_omt camp_omt_pos() const {
            return omt_pos;
        }
        inline const std::string &camp_name() const {
            return name;
        }
        tripoint_abs_ms get_bb_pos() const {
            return bb_pos;
        }
        tripoint_abs_ms get_bb_pos_abs() const {
            return bb_pos;
        }
        void validate_bb_pos( const tripoint_abs_ms &new_abs_pos ) {
            if( bb_pos.raw() == tripoint::zero ) {
                bb_pos = new_abs_pos;
            }
        }
        void set_bb_pos( const tripoint_abs_ms &new_abs_pos ) {
            bb_pos = new_abs_pos;
        }
        void set_by_radio( bool access_by_radio );

        std::string board_name() const;
        std::vector<point_rel_omt> directions; // NOLINT(cata-serialize)
        std::vector<std::vector<ui_mission_id>> hidden_missions;
        std::vector<tripoint_abs_omt> fortifications;
        std::vector<expansion_salt_water_pipe *> salt_water_pipes;

        //change name of camp
        void set_name( const std::string &new_name );
        void query_new_name( bool force = false );
        // remove the camp without safety checks; use abandon_camp() for in-game
        // normally always removes from overmap, but when mass-removing via overmap::clear_camps() we don't so we can iterate it properly
        void remove_camp( bool remove_from_overmap = true );
        // remove the camp from an in-game context
        void abandon_camp();
        void scan_pseudo_items();
        void add_expansion( const std::string &terrain, const tripoint_abs_omt &new_pos );
        void add_expansion( const std::string &bldg, const tripoint_abs_omt &new_pos,
                            const point_rel_omt &dir );
        void define_camp( const tripoint_abs_omt &p, std::string_view camp_type,
                          bool player_founded = true );

        std::string expansion_tab( const point_rel_omt &dir ) const;
        // check whether the point is the part of camp
        bool point_within_camp( const tripoint_abs_omt &p ) const;
        // upgrade levels
        bool has_provides( const std::string &req, const expansion_data &e_data, int level = 0 ) const;
        bool has_provides( const std::string &req, const std::optional<point_rel_omt> &dir = std::nullopt,
                           int level = 0 ) const;
        void update_resources( const std::string &bldg );
        void update_provides( const std::string &bldg, expansion_data &e_data );
        void update_in_progress( const std::string &bldg, const point_rel_omt &dir );

        /// Returns the name of the building the current building @ref dir upgrades into,
        /// "null" if there isn't one
        std::string next_upgrade( const point_rel_omt &dir, int offset = 1 ) const;
        std::vector<basecamp_upgrade> available_upgrades( const point_rel_omt &dir );

        // camp utility functions
        int recruit_evaluation() const;
        int recruit_evaluation( int &sbase, int &sexpansions, int &sfaction, int &sbonus ) const;
        // confirm there is at least 1 loot destination and 1 unsorted loot zone in the camp
        bool validate_sort_points();
        // Validates the expansion data
        expansion_data parse_expansion( std::string_view terrain,
                                        const tripoint_abs_omt &new_pos );
        /**
         * Invokes the zone manager and validates that the necessary sort zones exist.
         */
        bool set_sort_points();

        // food utility
        /// Changes the faction food supply by @ref change, returns the amount of kcal+vitamins consumed, a negative
        /// total food supply hurts morale
        /// Handles vitamin consumption when only a kcal value is supplied
        nutrients camp_food_supply( nutrients change );
        /// Constructs a new nutrients struct in place and forwards it. Passed argument should be in kilocalories.
        nutrients camp_food_supply( int change );
        /// Calculates raw kcal cost from duration (including non-work hours) and work exercise, then forwards it to above
        nutrients camp_food_supply( const time_duration &total_time, float exertion_level = NO_EXERCISE,
                                    const time_duration &travel_time = 0_hours );
        /// Evenly distributes the actual consumed food from a work project to the workers assigned to it
        void feed_workers( const std::vector<std::reference_wrapper <Character>> &workers, nutrients food,
                           bool is_player_meal = false );
        /// Helper, forwards to above
        void feed_workers( Character &worker, nutrients food, bool is_player_meal = false );
        void player_eats_meal();
        item make_fake_food( const nutrients &to_use ) const;
        /// Takes all the food from the camp_food zone and increases the faction
        /// food_supply
        bool distribute_food( bool player_command = true );
        std::string name_display_of( const mission_id &miss_id );
        void handle_hide_mission( const point_rel_omt &dir );
        void handle_reveal_mission( const point_rel_omt &dir );
        bool has_water() const;
        /// The number of days the current camp supplies lasts at the given exertion level.
        int camp_food_supply_days( float exertion_level ) const;
        /// Returns the total charges of food time_duration @ref work costs
        int time_to_food( time_duration total_time, float work_exertion_level = NO_EXERCISE,
                          time_duration travel_time = 0_hours ) const;
        /// Changes the faction respect for you by @ref change, returns respect
        int camp_discipline( int change = 0 ) const;
        /// Changes the faction opinion for you by @ref change, returns opinion
        int camp_morale( int change = 0 ) const;

        bool allowed_access_by( Character &guy, bool water_request = false ) const;
        /* Transfers ownership of a camp and send an event signalling it. If violent_takeover, also applies relation
        * maluses and transfers a proportional amount of the previous owner's food/resources to the new owner.
        */
        void handle_takeover_by( faction_id new_owner, bool violent_takeover );
        // recipes, gathering, and craft support functions
        // from a direction
        std::map<recipe_id, translation> recipe_deck( const point_rel_omt &dir ) const;
        // from a building
        std::map<recipe_id, translation> recipe_deck( const std::string &bldg ) const;
        // All recipes known by NPCs stationed here + all recipes provided by all expansions
        std::unordered_set<recipe_id> recipe_deck_all() const;
        int recipe_batch_max( const recipe &making ) const;
        void form_crafting_inventory();
        void form_crafting_inventory( map &target_map );
        std::list<item> use_charges( const itype_id &fake_id, int &quantity );
        /** Return semantically unique native resource entries as value data. */
        bool platform_resource_snapshot( std::vector<basecamp_resource> &result,
                                         std::string &error ) const;
        /** Normalize resource keys without exposing native vector positions. */
        static bool platform_normalize_resources(
            const std::vector<basecamp_resource> &input,
            std::vector<basecamp_resource> &result, std::string &error );
        /** Apply a validated batch of resource changes atomically. */
        bool platform_adjust_resources(
            const std::vector<basecamp_platform_resource_change> &changes,
            std::string &error );
        /** Return resource/food quantities held by active resource-work ledgers. */
        bool platform_reservation_liability(
            std::vector<basecamp_platform_resource_change> &resources,
            std::int64_t &food_kcal, std::string &error,
            std::uint64_t excluded_task_id = 0 ) const;
        /** Detached copy of the Platform-owned task records, ordered by id. */
        std::vector<basecamp_platform_task> platform_task_snapshot() const;
        /** Detached copy of Platform-owned expansion identities, ordered by id. */
        std::vector<basecamp_platform_expansion> platform_expansion_snapshot() const;
        /**
         * Validate one exact expansion placement against the currently loaded
         * OMT and the native expansion recipe group.  This is a read-only
         * domain predicate shared by Platform and the legacy survey flow.
         */
        bool platform_validate_expansion_placement( const std::string &type,
                const tripoint_abs_omt &position, std::string &error ) const;
        /** Validate an exact upgrade target and the current authoritative
         * blueprint/terrain/ordering boundary without mutating the world. */
        bool platform_validate_upgrade_target(
            const basecamp_platform_upgrade_work &work, std::string &error ) const;
        /** Determine whether an in-flight upgrade is committed without replaying it. */
        basecamp_platform_upgrade_commit_state platform_upgrade_commit_state(
            const basecamp_platform_upgrade_work &work,
            std::uint64_t task_identity_generation,
            std::uint64_t applying_marker,
            std::uint64_t commit_marker,
            std::string &error ) const;
        /** Resolve one exact expansion generation without a positional lookup. */
        bool platform_get_expansion( std::uint64_t expansion_id,
                                     std::uint64_t identity_generation,
                                     basecamp_platform_expansion &result,
                                     std::string &error ) const;
        /** Create one explicit expansion after all caller-side authorization checks. */
        bool platform_create_expansion( const std::string &type,
                                        const std::string &name,
                                        const tripoint_abs_omt &position,
                                        basecamp_platform_expansion &result,
                                        std::string &error );
        /** Remove one exact expansion generation. */
        bool platform_remove_expansion( std::uint64_t expansion_id,
                                        std::uint64_t identity_generation,
                                        std::string &error );
        /** Verify that every active liability and expansion boundary is clear. */
        bool platform_can_remove( std::string &error ) const;
        /** Create a pending Platform task; task_id 0 receives a stable id. */
        bool platform_create_task( basecamp_platform_task &task, std::string &error );
        /** Start a pending worker-reservation task atomically with assignment. */
        bool platform_start_task( std::uint64_t task_id, std::uint64_t task_generation,
                                  const npc_ptr &worker, time_point now,
                                  time_duration duration, std::string &error );
        /** Start a recipe_work task after exact item handles have been moved
         * into its task-owned escrow. */
        bool platform_start_task( std::uint64_t task_id, std::uint64_t task_generation,
                                  const npc_ptr &worker, time_point now,
                                  time_duration duration,
                                  const std::vector<basecamp_platform_recipe_escrow_item> &escrow,
                                  std::string &error );
        /** Complete or cancel a task and release its reservation atomically. */
        bool platform_finish_task( std::uint64_t task_id, std::uint64_t task_generation,
                                   const npc_ptr &worker, time_point now, bool complete,
                                   std::string &error );
        /** Finish a recipe task only after the Lua item transaction has
         * successfully placed/refunded the exact expected escrow values. */
        bool platform_finish_task( std::uint64_t task_id, std::uint64_t task_generation,
                                   const npc_ptr &worker, time_point now, bool complete,
                                   const std::vector<basecamp_platform_recipe_escrow_item> &escrow,
                                   std::string &error );
        /** Replace running escrow with detached tools and outputs, without
         * touching an external holder. */
        bool platform_complete_recipe_task(
            std::uint64_t task_id, std::uint64_t task_generation,
            const npc_ptr &worker, time_point now,
            const std::vector<basecamp_platform_recipe_escrow_item> &original_escrow,
            const std::vector<basecamp_platform_recipe_escrow_item> &remaining_escrow,
            std::string &error );
        /** Retire a refund_pending/completed_unclaimed task after an external
         * explicit-holder transfer has succeeded. */
        bool platform_claim_recipe_escrow(
            std::uint64_t task_id, std::uint64_t task_generation,
            time_point now, bool completed,
            const std::vector<basecamp_platform_recipe_escrow_item> &escrow,
            std::string &error );
        /** Record a recoverable refund failure without retiring the task. */
        bool platform_mark_recipe_refund_pending( std::uint64_t task_id,
                std::uint64_t task_generation, std::string &error );
        /** Prepare the authoritative recipe settlement on detached escrow
         * values without mutating the task.  The returned escrow contains
         * remaining tools and newly created outputs. */
        bool platform_prepare_recipe_completion(
            std::uint64_t task_id, std::uint64_t task_generation,
            const npc_ptr &worker, time_point now,
            std::vector<basecamp_platform_recipe_escrow_item> &remaining_escrow,
            std::string &error ) const;
        /** Return a detached copy of recipe escrow for an explicit refund. */
        bool platform_prepare_recipe_refund(
            std::uint64_t task_id, std::uint64_t task_generation,
            const npc_ptr &worker,
            std::vector<basecamp_platform_recipe_escrow_item> &escrow,
            std::string &error ) const;
        /** Prepare a detached upgrade settlement using the authoritative
         * blueprint requirements; no map or task state is mutated here. */
        bool platform_prepare_upgrade_completion(
            std::uint64_t task_id, std::uint64_t task_generation,
            const npc_ptr &worker, time_point now,
            std::vector<basecamp_platform_recipe_escrow_item> &remaining_escrow,
            std::string &error ) const;
        /** Apply the prepared upgrade through the transactional mapgen path,
         * then publish metadata and terminal escrow in one native commit. */
        bool platform_complete_upgrade_task(
            std::uint64_t task_id, std::uint64_t task_generation,
            const npc_ptr &worker, time_point now,
            const std::vector<basecamp_platform_recipe_escrow_item> &original_escrow,
            const std::vector<basecamp_platform_recipe_escrow_item> &remaining_escrow,
            std::string &error );
        /** Release only the ephemeral reservation for one unloaded NPC. */
        void platform_release_worker_reservation( npc &worker );
        /** Retire active Platform tasks for one dead or replaced NPC lifetime. */
        void platform_retire_tasks_for_worker( npc &worker );
        /** Retire camp tasks; false refuses a camp removal with live recipe escrow. */
        bool platform_retire_tasks_for_camp( bool owner_change = false );
        /** Rebuild valid running-task reservations after native load. */
        bool platform_reconcile_task_reservations(
            const basecamp_platform_actor_lookup &lookup, std::string &error );
        /**
         * spawn items or corpses based on search attempts
         * @param skill skill level of the search
         * @param group_id name of the item_group that provides the items
         * @param attempts number of skill checks to make
         * @param difficulty a random number from 0 to difficulty is created for each attempt, and
         * if skill is higher, an item or corpse is spawned
         */
        void search_results( int skill, const item_group_id &, int attempts, int difficulty );
        /**
         * spawn items or corpses based on search attempts
         * @param skill skill level of the search
         * @param task string to identify what types of corpses to provide ( _faction_camp_hunting
         * or _faction_camp_trapping )
         * @param attempts number of skill checks to make
         * @param difficulty a random number from 0 to difficulty is created for each attempt, and
         * if skill is higher, an item or corpse is spawned
         */
        void hunting_results( int skill, const mission_id &miss_id, int attempts, int difficulty );
        void make_corpse_from_group( const std::vector<MonsterGroupResult> &group );
        inline const tripoint_abs_ms &get_dumping_spot() const {
            return dumping_spot;
        }
        inline const std::vector<tripoint_abs_ms> &get_liquid_dumping_spot() const {
            return liquid_dumping_spots;
        }
        // dumping spot in absolute co-ords
        inline void set_dumping_spot( const tripoint_abs_ms &spot ) {
            dumping_spot = spot;
        }
        inline void set_liquid_dumping_spot( const std::vector<tripoint_abs_ms> &liquid_dumps ) {
            // Nowhere qualified to dump liquid? Dump it wherever everything else goes.
            if( liquid_dumps.empty() ) {
                liquid_dumping_spots.clear();
                liquid_dumping_spots.emplace_back( dumping_spot );
                return;
            } //else
            liquid_dumping_spots.clear();
            liquid_dumping_spots = liquid_dumps;
        }
        void place_results( const item &result );

        // mission description functions
        void add_available_recipes( mission_data &mission_key, mission_kind kind,
                                    const point_rel_omt &dir );

        std::string recruit_description( int npc_count ) const;
        /// Provides a "guess" for some of the things your gatherers will return with
        /// to upgrade the camp
        std::vector<std::string> gathering_description() const;
        /// Returns a string for the number of plants that are harvestable, plots ready to plant,
        /// and ground that needs tilling
        std::vector<std::string> farm_description( const point_rel_omt &dir, size_t &plots_count,
                farm_ops operation );
        /// Returns the description of a camp crafting options. converts fire charges to charcoal,
        /// allows dark crafting
        std::string craft_description( const recipe_id &itm );

        // main mission description collection
        void get_available_missions( mission_data &mission_key, map &here );
        void get_available_missions_by_dir( mission_data &mission_key, const point_rel_omt &dir );
        void choose_new_leader();
        // available companion list manipulation
        void reset_camp_workers();
        comp_list get_mission_workers( const mission_id &miss_id, bool contains = false );
        // main mission start/return dispatch function
        bool handle_mission( const ui_mission_id &miss_id );

        // mission start functions
        /// generic mission start function that wraps individual mission
        npc_ptr start_mission( const mission_id &miss_id, time_duration total_time,
                               bool must_feed, const std::string &desc, bool group,
                               const std::vector<item *> &equipment,
                               const skill_id &skill_tested, int skill_level,
                               float exertion_level, const time_duration &travel_time = 0_hours );
        npc_ptr start_mission( const mission_id &miss_id, time_duration total_time,
                               bool must_feed, const std::string &desc, bool group,
                               const std::vector<item *> &equipment,
                               const std::map<skill_id, int> &required_skills = {},
                               float exertion_level = 1.0f, const time_duration &travel_time = 0_hours,
                               const npc_ptr &preselected_choice = nullptr );
        comp_list start_multi_mission( const mission_id &miss_id,
                                       bool must_feed, const std::string &desc,
                                       // const std::vector<item*>& equipment, //  No support for extracting equipment from recipes currently..
                                       const skill_id &skill_tested, int skill_level );
        comp_list start_multi_mission( const mission_id &miss_id,
                                       bool must_feed, const std::string &desc,
                                       //  const std::vector<item*>& equipment, //  No support for extracting equipment from recipes currently..
                                       const std::map<skill_id, int> &required_skills = {} );
        void start_upgrade( const mission_id &miss_id );
        std::string om_upgrade_description( const std::string &bldg, const mapgen_arguments &,
                                            bool trunc = false ) const;
        void start_menial_labor();
        void worker_assignment_ui();
        void job_assignment_ui();
        // Assembles a dummy NPC with all available recipes and uses player input on the regular crafting GUI to
        // determine what to make, batch size, who to assign to making it, etc.
        void start_crafting( const mission_id &miss_id );

        /// Called when a companion is sent to cut logs
        void start_cut_logs( const mission_id &miss_id, float exertion_level );
        void start_clearcut( const mission_id &miss_id, float exertion_level );
        void start_setup_hide_site( const mission_id &miss_id, float exertion_level );
        void start_relay_hide_site( const mission_id &miss_id, float exertion_level );
        /// Called when a companion is sent to start fortifications
        void start_fortifications( const mission_id &miss_id, float exertion_level );
        /// Called when a companion is sent to start digging down salt water pipes
        bool common_salt_water_pipe_construction( const mission_id &miss_id,
                expansion_salt_water_pipe *pipe,
                int segment_number ); //  Code factored out from the two following operation, not intended to be used elsewhere.
        void start_salt_water_pipe( const mission_id &miss_id );
        void continue_salt_water_pipe( const mission_id &miss_id );
        void start_combat_mission( const mission_id &miss_id, float exertion_level );
        void start_farm_op( const point_rel_omt &dir, const mission_id &miss_id,
                            float exertion_level );
        ///Display items listed in @ref equipment to let the player pick what to give the departing
        ///NPC, loops until quit or empty.
        drop_locations give_basecamp_equipment( inventory_filter_preset &preset, const std::string &title,
                                                const std::string &column_title, const std::string &msg_empty ) const;
        drop_locations give_equipment( Character *pc, const inventory_filter_preset &preset,
                                       const std::string &msg, const std::string &title, units::volume &total_volume,
                                       units::mass &total_mass );
        drop_locations get_equipment( tinymap *target_bay, const tripoint_omt_ms &target, Character *pc,
                                      const inventory_filter_preset &preset,
                                      const std::string &msg, const std::string &title, units::volume &total_volume,
                                      units::mass &total_mass );

        // mission return functions
        /// called to select a companion to return to the base
        npc_ptr companion_choose_return( const mission_id &miss_id, time_duration min_duration );
        npc_ptr companion_crafting_choose_return( const mission_id &miss_id );
        /// called with a companion @ref comp who is not the camp manager, finishes updating their
        /// skills, consuming food, and returning them to the base.
        void finish_return( npc &comp, bool fixed_time, const std::string &return_msg,
                            const std::string &skill, int difficulty, bool cancel = false );
        /// a wrapper function for @ref companion_choose_return and @ref finish_return
        npc_ptr mission_return( const mission_id &miss_id, time_duration min_duration,
                                bool fixed_time, const std::string &return_msg,
                                const std::string &skill, int difficulty );
        npc_ptr crafting_mission_return( const mission_id &miss_id, const std::string &return_msg,
                                         const std::string &skill, int difficulty );
        /// select a companion for any mission to return to base
        npc_ptr emergency_recall( const mission_id &miss_id );

        /// Called to close upgrade missions, @ref miss is the name of the mission id
        /// and @ref dir is the direction of the location to be upgraded
        bool upgrade_return( const mission_id &miss_id );

        /// Choose which expansion slot to check for field conversion
        bool survey_field_return( const mission_id &miss_id );

        /// Choose which expansion you should start, called when a survey mission is completed
        bool survey_return( const mission_id &miss_id );
        bool menial_return( const mission_id &miss_id );
        /// Called when a companion completes a gathering @ref task mission
        bool gathering_return( const mission_id &miss_id, time_duration min_time );
        void recruit_return( const mission_id &miss_id, int score );
        /**
        * Perform any mix of the three farm tasks.
        * @param task
        * @param omt_tgt the overmap pos3 of the farm_ops
        * @param op whether to plow, plant, or harvest
        */
        bool farm_return( const mission_id &miss_id, const point_rel_omt &dir );
        std::pair<size_t, std::string> farm_action( const point_rel_omt &dir, farm_ops op,
                const npc_ptr &comp = nullptr );
        void fortifications_return( const mission_id &miss_id );
        bool salt_water_pipe_swamp_return( const mission_id &miss_id,
                                           const comp_list &npc_list );
        bool salt_water_pipe_return( const mission_id &miss_id,
                                     const comp_list &npc_list );

        void combat_mission_return( const mission_id &miss_id );
        void validate_assignees();
        void add_assignee( character_id id );
        void remove_assignee( character_id id );
        /** Exact Platform worker mutation; never searches by a guessed id. */
        bool assign_exact_worker( const npc_ptr &worker );
        bool recall_exact_worker( const npc_ptr &worker );
        bool has_exact_worker( const npc &worker ) const noexcept;
        std::size_t exact_worker_count() const noexcept;
        std::vector<npc_ptr> get_npcs_assigned();
        void hide_mission( ui_mission_id id );
        void reveal_mission( ui_mission_id id );
        bool is_hidden( ui_mission_id id );
        // Save/load
        void serialize( JsonOut &json ) const;
        void deserialize( const JsonObject &data );
        void load_data( const std::string &data );
        inline const std::unordered_set<tripoint_abs_ms> &get_storage_tiles() const {
            return src_set;
        }
        inline void set_storage_tiles( const std::unordered_set<tripoint_abs_ms> &tiles ) {
            src_set = tiles;
        }
        void form_storage_zones( map &here, const tripoint_abs_ms &abspos );
        map &get_camp_map();
        void unload_camp_map();
        void set_owner( faction_id new_owner );
        faction_id get_owner();
    private:
        friend class basecamp_action_components;

        void platform_register_expansion_identity( const point_rel_omt &direction,
                const expansion_data &expansion, std::string name = {} );
        void platform_retire_expansion_identity( std::uint64_t expansion_id );
        void platform_retire_expansion_identities();
        bool platform_transition_owner( faction_id new_owner,
                                        const std::function<void()> &before_publish );

        // Which faction owns this camp?
        mutable faction_id owner = faction_id::NULL_ID();
        // Returns the actual faction object which owns this camp
        faction *fac() const;
        // lazy re-evaluation of available camp resources
        void reset_camp_resources( map &here );
        void add_resource( const itype_id &camp_resource );
        // Translated name w/ parse_tags evaluated
        std::string name;
        // omt pos
        tripoint_abs_omt omt_pos;
        // Platform identity is separate from the mutable overmap position.
        std::uint64_t platform_id_ = 0; // NOLINT(cata-serialize)
        std::uint64_t platform_core_upgrade_generation_ = 1; // NOLINT(cata-serialize)
        safe_reference_anchor platform_anchor; // NOLINT(cata-serialize)
        std::vector<npc_ptr> assigned_npcs; // NOLINT(cata-serialize)
        // location of associated bulletin board
        tripoint_abs_ms bb_pos;
        std::map<point_rel_omt, expansion_data> expansions;
        std::map<std::uint64_t, basecamp_platform_expansion> platform_expansions_; // NOLINT(cata-serialize)
        // Tombstones keep an already-issued expansion token fail-closed until
        // its owning camp object is destroyed or a world is reloaded.  IDs
        // are monotonic and are never reused, so this map is not save data.
        std::map<std::uint64_t, std::uint64_t>
        platform_retired_expansion_generations_; // NOLINT(cata-serialize)
        comp_list camp_workers; // NOLINT(cata-serialize)
        basecamp_map camp_map; // NOLINT(cata-serialize)
        // dumping spot in absolute co-ords
        tripoint_abs_ms dumping_spot;
        // Tiles inside STORAGE-type zones that have LIQUIDCONT terrain
        std::vector<tripoint_abs_ms> liquid_dumping_spots;
        std::unordered_set<tripoint_abs_ms> src_set; // NOLINT(cata-serialize)
        std::set<itype_id> fuel_types; // NOLINT(cata-serialize)
        std::vector<basecamp_fuel> fuels; // NOLINT(cata-serialize)
        std::vector<basecamp_resource> resources; // NOLINT(cata-serialize)
        std::vector<basecamp_platform_task> platform_tasks; // NOLINT(cata-serialize)
        std::vector<std::vector<ui_mission_id>> temp_ui_mission_keys;   // NOLINT(cata-serialize)
        inventory _inv; // NOLINT(cata-serialize)
        bool by_radio = false; // NOLINT(cata-serialize)
};

class basecamp_action_components
{
    public:
        basecamp_action_components( const recipe &making, const mapgen_arguments &, int batch_size,
                                    basecamp & );

        // Returns true iff all necessary components were successfully chosen
        bool choose_components();
        void consume_components();
        item_components &consumed_components() {
            return consumed_components_;
        }
    private:
        const recipe &making_;
        const mapgen_arguments &args_;
        int batch_size_;
        basecamp &base_;
        std::vector<comp_selection<item_comp>> item_selections_;
        std::vector<comp_selection<tool_comp>> tool_selections_;
        item_components consumed_components_;
};

#endif // CATA_SRC_BASECAMP_H
