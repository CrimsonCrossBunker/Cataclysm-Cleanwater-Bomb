#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_RUNTIME_INTERNAL_H
#define CATA_SRC_LUA_PLATFORM_RUNTIME_INTERNAL_H

#include "lua_platform_runtime.h"

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <cstddef>
#include <cstdint>
#include <filesystem>
#include <limits>
#include <map>
#include <memory>
#include <optional>
#include <random>
#include <set>
#include <string>
#include <string_view>
#include <unordered_map>
#include <utility>
#include <vector>

#include "character_id.h"
#include "lua_platform_handle.h"
#include "lua_platform_state.h"
#include "item_location.h"
#include "mod_tileset.h"

class avatar;
class const_talker;
class mission;
class spell;
struct const_dialogue;

namespace cata::lua_platform
{

struct handler_definition {
    int payload_version = 1;
    sol::protected_function callback;
};

struct task_payload_migration {
    int target_version = 1;
    sol::protected_function callback;
};

enum class persistent_task_participant_kind : int {
    character,
    item,
    monster,
    vehicle
};

struct persistent_task_participant {
    std::string role;
    persistent_task_participant_kind kind = persistent_task_participant_kind::character;
    std::int64_t stable_id = 0;
    game_handle_locator hint;
    bool pending = false;
};

struct persistent_task {
    std::uint64_t id = 0;
    std::string handler_id;
    std::int64_t due_turn = 0;
    std::int64_t interval_turns = 0;
    std::string owner = "world";
    std::string owner_mod_id;
    std::optional<character_id> actor_character_id;
    std::optional<std::int64_t> actor_item_uid;
    std::optional<game_handle_locator> actor_item_hint;
    bool actor_item_pending = false;
    std::optional<std::int64_t> actor_monster_uid;
    std::optional<game_handle_locator> actor_monster_hint;
    bool actor_monster_pending = false;
    std::optional<std::int64_t> actor_vehicle_uid;
    std::optional<game_handle_locator> actor_vehicle_hint;
    bool actor_vehicle_pending = false;
    std::vector<persistent_task_participant> participants;
    int payload_version = 1;
    script_persistent_state payload;
};

inline constexpr std::size_t maximum_tasks_per_mod = 1024;
inline constexpr std::int64_t persistent_item_task_retry_turns = 60LL * 60LL;
inline constexpr std::int64_t persistent_monster_task_retry_turns = 60LL * 60LL;
inline constexpr std::int64_t persistent_vehicle_task_retry_turns = 60LL * 60LL;
inline constexpr std::int64_t persistent_participant_task_retry_turns = 60LL * 60LL;
inline constexpr std::size_t maximum_task_participants = 4;
inline constexpr std::size_t maximum_character_recurring_handlers_per_mod = 1024;
inline constexpr std::int64_t maximum_character_recurrence_turns =
    365LL * 24LL * 60LL * 60LL;
inline constexpr std::size_t maximum_platform_dialogue_topics = 8192;
inline constexpr std::size_t maximum_presentation_text_bytes = 32768;
inline constexpr std::size_t maximum_presentation_choices = 128;

class runtime : public std::enable_shared_from_this<runtime>
{
    public:
        struct character_recurring_registration {
            std::string effect_handler;
            std::string interval_handler;
            std::string due_variable;
        };

        struct declarative_dialogue_topic {
            std::uint64_t registration_id = 0;
            sol::object dynamic_line;
            sol::object responses;
            sol::object speaker_effects;
            sol::object repeat_responses;
            bool replace_built_in_responses = true;
            bool insert_before_standard_exits = false;
        };

        struct declarative_dialogue_extension {
            std::uint64_t registration_id = 0;
            std::string id;
            std::string key;
            bool insert_before_standard_exits = false;
            sol::object responses;
            sol::object speaker_effects;
            sol::object repeat_responses;
        };

        struct mapgen_registration {
            std::string handler_id;
            std::vector<std::string> terrain_ids;
            int z_min = std::numeric_limits<int>::min();
            int z_max = std::numeric_limits<int>::max();
            bool primary = false;
        };

        struct declarative_mapgen_palette {
            std::uint64_t registration_id = 0;
            std::vector<std::string> parents;
            std::map<std::string, sol::object> symbols;
        };

        struct declarative_mapgen_definition {
            std::uint64_t registration_id = 0;
            std::string id;
            std::vector<std::string> terrain_ids;
            int z_min = std::numeric_limits<int>::min();
            int z_max = std::numeric_limits<int>::max();
            bool primary = true;
            int offset_x = 0;
            int offset_y = 0;
            std::string fill_terrain;
            std::vector<std::vector<std::string>> rows;
            std::vector<std::string> palettes;
            std::map<std::string, sol::object> symbols;
            sol::object before_generate;
            sol::object after_generate;
        };

        runtime( std::string id, std::size_t candidate_generation,
                 sol::state &state, std::filesystem::path root );

        game_handle_runtime handle_runtime() const;

        std::string mod_id;
        std::size_t generation = 0;
        game_handle_runtime_owner_ptr game_handle_owner =
            make_game_handle_runtime_owner();
        sol::state *lua = nullptr;
        content_transaction content;
        std::filesystem::path mod_root;
        std::vector<mod_tileset_definition> native_tilesets;
        std::optional<std::size_t> tileset_registry_generation;
        std::unordered_map<std::string, handler_definition> handlers;
        std::unordered_map<std::string, std::map<int, task_payload_migration>>
                task_migrations;
        std::unordered_map<std::string, std::vector<std::string>> subscriptions;
        std::unordered_map<std::string, std::vector<std::string>> hooks;
        std::vector<character_recurring_registration> character_recurring_handlers;
        std::set<std::string> reported_character_recurring_failures;
        std::map<std::string, std::string> dialogue_topics;
        std::map<std::string, declarative_dialogue_topic> declarative_dialogue_topics;
        std::vector<declarative_dialogue_extension> declarative_dialogue_extensions;
        std::uint64_t next_dialogue_registration_id = 1;
        std::vector<mapgen_registration> mapgen_handlers;
        std::map<std::string, declarative_mapgen_palette> mapgen_palettes;
        std::vector<declarative_mapgen_definition> declarative_mapgens;
        std::uint64_t next_mapgen_registration_id = 1;
        script_persistent_state character_state;
        script_persistent_state world_state;
        std::vector<persistent_task> tasks;
        std::set<std::uint64_t> reported_task_migration_failures;
        std::uint64_t next_task_id = 1;
        bool task_migration_active = false;
        std::mt19937_64 random_engine;
        int callback_depth = 0;
        bool world_is_ready = false;
};

namespace detail
{

struct widget_custom_handler_result {
    int value = 0;
    int minimum = std::numeric_limits<int>::min();
    int normal_minimum = std::numeric_limits<int>::min();
    int normal_maximum = std::numeric_limits<int>::max();
    int maximum = std::numeric_limits<int>::max();
};

class platform_event_dispatch_scope
{
    public:
        platform_event_dispatch_scope();

        platform_event_dispatch_scope( const platform_event_dispatch_scope & ) = delete;
        platform_event_dispatch_scope &operator=( const platform_event_dispatch_scope & ) = delete;

        ~platform_event_dispatch_scope();
};

const std::vector<std::shared_ptr<runtime>> &active_runtime_values();
extern std::vector<std::shared_ptr<runtime>> active_runtimes;
extern std::size_t active_world_generation;
std::shared_ptr<runtime> find_active_runtime( std::string_view id );
std::size_t &runtime_world_generation_storage();
int current_platform_event_dispatch_depth() noexcept;

std::uint64_t runtime_hash( std::string_view value );
std::size_t checked_dense_array( const sol::table &values,
                                 std::string_view description,
                                 std::size_t minimum,
                                 std::size_t maximum );

class callback_scope
{
    public:
        explicit callback_scope( runtime &owner ) : owner_( owner ) {
            ++owner_.callback_depth;
        }

        callback_scope( const callback_scope & ) = delete;
        callback_scope &operator=( const callback_scope & ) = delete;

        ~callback_scope() {
            --owner_.callback_depth;
        }

    private:
        runtime &owner_;
};

void require_live_runtime( const std::weak_ptr<runtime> &weak,
                           std::string_view operation );
bool runtime_callback_is_active( const std::weak_ptr<runtime> &weak );
void report_callback_error( const runtime &owner, std::string_view handler,
                            const sol::protected_function_result &result );
void dispatch_lifecycle( runtime &owner, const std::string &name,
                         const sol::optional<sol::table> &payload = sol::nullopt );
bool migrate_task_payload( runtime &owner, persistent_task &task,
                           std::string &error );

inline bool fits_native_int( const std::int64_t value )
{
    return value >= std::numeric_limits<int>::min() &&
           value <= std::numeric_limits<int>::max();
}

sol::table platform_callback_payload(
    runtime &owner, const native_callback_arguments &arguments );
sol::object platform_talker_to_lua( runtime &owner,
                                    const const_talker &talker );
sol::object platform_callback_talker_to_lua(
    runtime &owner, const native_callback_talker &talker );
Character *platform_event_character( const character_id &id );
game_handle platform_creature_handle( const runtime &owner,
                                      const Creature &creature );
game_handle platform_item_handle( const runtime &owner,
                                  item_location &value,
                                  const game_handle_locator &stored_hint );
game_handle platform_vehicle_handle( const runtime &owner,
                                     vehicle &value );
item_locator_hint persistent_item_hint( const game_handle_locator &stored );
item_locator_hint persistent_task_item_hint( const persistent_task &task );

std::optional<bool> invoke_widget_condition_handler(
    std::string_view mod_id, std::string_view widget_id_value,
    std::string_view clause_id, std::string_view handler_id,
    std::string_view bodypart );
std::optional<widget_custom_handler_result> invoke_widget_custom_handler(
    std::string_view mod_id, std::string_view widget_id_value,
    std::string_view handler_id, const avatar &subject );
std::optional<bool> invoke_enchantment_condition_handler(
    std::string_view mod_id, std::string_view enchantment,
    std::string_view scope, std::string_view target,
    std::string_view handler_id, const const_dialogue &dialogue );
std::optional<double> invoke_enchantment_number_handler(
    std::string_view mod_id, std::string_view enchantment,
    std::string_view scope, std::string_view target,
    std::string_view part, std::string_view handler_id,
    const const_dialogue &dialogue );
std::optional<bool> invoke_spell_condition_handler(
    std::string_view mod_id, std::string_view spell_id_value,
    std::string_view phase, std::string_view handler_id,
    const const_dialogue &dialogue );
std::optional<double> invoke_spell_stat_handler(
    std::string_view mod_id, std::string_view spell_id_value,
    std::string_view stat, std::string_view handler_id,
    const const_dialogue &dialogue );
void invoke_spell_effect_handler(
    std::string_view mod_id, std::string_view spell_id_value,
    std::string_view handler_id, const spell &cast_spell,
    Creature &caster, const tripoint_bub_ms &target );
std::optional<bool> invoke_mission_condition_handler(
    std::string_view mod_id, std::string_view mission_type,
    std::string_view phase, std::string_view handler_id,
    const const_dialogue &dialogue );
std::optional<std::int64_t> invoke_mission_deadline_handler(
    std::string_view mod_id, std::string_view mission_type,
    std::string_view handler_id, const const_dialogue &dialogue );
std::optional<bool> invoke_mission_place_handler(
    std::string_view mod_id, std::string_view mission_type,
    std::string_view handler_id, const tripoint_abs_omt &position );
void invoke_mission_phase_handler(
    std::string_view mod_id, std::string_view mission_type,
    std::string_view phase, std::string_view handler_id,
    mission *active_mission );
std::optional<bool> invoke_mutation_condition_handler(
    std::string_view mod_id, std::string_view mutation_id,
    std::string_view handler_id, const const_dialogue &dialogue );

void start_runtime_event_bridge();
void stop_runtime_event_bridge();
void clear_orphan_runtime_records();

void install_runtime_callback_api( const std::shared_ptr<runtime> &value,
                                   sol::state &lua, sol::table &ccb );
void install_runtime_state_task_api( const std::shared_ptr<runtime> &value,
                                     sol::state &lua, sol::table &ccb );
void install_runtime_dialogue_presentation_api(
    const std::shared_ptr<runtime> &value, sol::state &lua, sol::table &ccb );

} // namespace detail

} // namespace cata::lua_platform

#endif // CATA_ENABLE_LUA_PLATFORM

#endif // CATA_SRC_LUA_PLATFORM_RUNTIME_INTERNAL_H
