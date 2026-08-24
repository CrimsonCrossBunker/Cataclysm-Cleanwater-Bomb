#pragma once
#ifndef CATA_SRC_CATALUA_PLATFORM_RUNTIME_H
#define CATA_SRC_CATALUA_PLATFORM_RUNTIME_H

#include <cstddef>
#include <cstdint>
#include <filesystem>
#include <map>
#include <memory>
#include <optional>
#include <string>
#include <string_view>
#include <vector>

#include "coords_fwd.h"

class Character;
class computer;
class Creature;
class item;
class map;
class mapgendata;
class npc;
class player_activity;
class recipe;
class vehicle;
struct dialogue;
struct itype;
struct talk_topic;
struct vehicle_part;
struct w_point;
struct weakpoint_attack;

#if defined(CATA_ENABLE_LUA_UI) && CATA_ENABLE_LUA_UI
    #include "catalua_sol.h"
    #include "catalua_ui.h"
#endif

namespace cata::lua_platform
{

class runtime;

/**
 * Owns native content definitions created by one candidate Platform Mod.
 *
 * The class name is intentionally part of the native friendship boundary: it
 * may populate Item_factory and recipe_dictionary without exposing either
 * legacy loader to Lua.  Lua only receives generation-checked definition
 * handles installed by runtime.
 */
class content_transaction
{
    public:
        content_transaction( std::string owner, std::size_t generation );
        ~content_transaction();

        content_transaction( const content_transaction & ) = delete;
        content_transaction &operator=( const content_transaction & ) = delete;

        bool validate( const runtime &owner_runtime, bool check_engine_state,
                       std::string &error ) const;
        bool apply( std::string &error );
        bool validate_finalized( std::string &error ) const;
        void rollback();
        void commit();
        /** Retire Lua definition handles without reapplying unchanged content. */
        void seal();
        void discard();

        std::string fingerprint() const;
        bool was_applied() const;

        /** Find the named callback owned by this transaction's damage type. */
        bool find_damage_handler( std::string_view damage_id,
                                  std::string_view phase,
                                  std::string &handler_id ) const;

        /** Find the named Lua impact policy owned by this ammunition effect. */
        bool find_ammo_effect_handler( std::string_view ammo_effect_id,
                                       std::string &handler_id ) const;

        /** Find the named Lua tick policy owned by this addiction type. */
        bool find_addiction_type_handler( std::string_view addiction_type_id,
                                          std::string &handler_id ) const;

        /** Find the named Lua evaluator owned by this character modifier. */
        bool find_character_modifier_handler( std::string_view modifier_id,
                                              std::string &handler_id ) const;

        /** Find the named Lua eligibility policy owned by this weather type. */
        bool find_weather_type_handler( std::string_view weather_type_id,
                                        std::string &handler_id ) const;

        /** Find the named Lua selection policy owned by this end screen. */
        bool find_end_screen_handler( std::string_view end_screen_id,
                                      std::string &handler_id ) const;

        /** Find a named turn or completion policy owned by an activity type. */
        bool find_activity_type_handler( std::string_view activity_type_id,
                                         std::string_view phase,
                                         std::string &handler_id ) const;

        /** Find the named examine policy owned by a Lua-first snippet. */
        bool find_snippet_handler( std::string_view snippet_id,
                                   std::string &category_id,
                                   std::string &handler_id ) const;

        /** Find a named evaluator or failure callback owned by this magic type. */
        bool find_magic_type_handler( std::string_view magic_type_id,
                                      std::string_view phase,
                                      std::string &handler_id ) const;

        /** Find the named Lua profile policy owned by this emission. */
        bool find_emission_handler( std::string_view emission_id,
                                    std::string &handler_id ) const;

        /** Find a named entry/exit policy owned by an overmap terrain type. */
        bool find_overmap_terrain_handler( std::string_view terrain_id,
                                           std::string_view phase,
                                           std::string &handler_id ) const;

        /** Find a named eligibility/placement policy owned by an overmap special. */
        bool find_overmap_special_handler( std::string_view special_id,
                                           std::string_view phase,
                                           std::string &handler_id ) const;

        /** Find a named interaction policy owned by a vehicle-part type. */
        bool find_vehicle_part_handler( std::string_view part_id,
                                        std::string_view phase,
                                        std::string &handler_id ) const;

        /** Find a handler attached to one seed or plant-furniture lifecycle. */
        bool find_plant_lifecycle_handler( std::string_view target,
                                           std::string_view target_id,
                                           std::string_view phase,
                                           std::string &handler_id ) const;

        /** Find one lifecycle handler owned by a Lua-first martial art. */
        bool find_martial_art_handler( std::string_view martial_art_id,
                                       std::string_view phase,
                                       std::string &handler_id ) const;

#if defined(CATA_ENABLE_LUA_UI) && CATA_ENABLE_LUA_UI
        void install_lua_api( sol::state &lua, sol::table &ccb,
                              const std::shared_ptr<runtime> &owner_runtime );
#endif

    private:
        struct impl;
        std::unique_ptr<impl> pimpl_;
};

#if defined(CATA_ENABLE_LUA_UI) && CATA_ENABLE_LUA_UI

std::shared_ptr<runtime> make_runtime( const std::string &mod_id,
                                       std::size_t generation,
                                       sol::state &lua,
                                       const std::filesystem::path &mod_root = {} );
void install_runtime_api( const std::shared_ptr<runtime> &value,
                          sol::state &lua, sol::table &ccb );

bool validate_runtime( const std::shared_ptr<runtime> &value,
                       bool check_engine_state,
                       std::string &error );
bool apply_runtime_content( const std::shared_ptr<runtime> &value,
                            std::string &error );
bool validate_finalized_runtime_content( const std::shared_ptr<runtime> &value,
        std::string &error );
void rollback_runtime_content( const std::shared_ptr<runtime> &value );
void commit_runtime( const std::shared_ptr<runtime> &value );
void seal_runtime_content( const std::shared_ptr<runtime> &value );
void discard_runtime( const std::shared_ptr<runtime> &value );
std::string runtime_fingerprint( const std::shared_ptr<runtime> &value );

/** Query the candidate runtime's handler registry during content validation. */
bool runtime_has_handler( const runtime &value, std::string_view handler_id );

void set_active_runtimes( const std::vector<std::shared_ptr<runtime>> &values );
void hot_swap_active_runtimes(
    const std::vector<std::shared_ptr<runtime>> &values );
void clear_active_runtimes();

bool runtime_has_primary_mapgen_for( const std::shared_ptr<runtime> &value,
                                     std::string_view terrain_id );
std::optional<std::string> platform_dialogue_dynamic_line( dialogue &d,
        const talk_topic &topic );
void apply_platform_dialogue_speaker_effects( dialogue &d,
        const talk_topic &topic );
bool gen_platform_dialogue_responses( dialogue &d, const talk_topic &topic );
void extend_platform_dialogue_responses( dialogue &d, const talk_topic &topic );

std::optional<int> invoke_use_handler( std::string_view mod_id,
                                       std::string_view handler_id,
                                       Character *character, item &used_item,
                                       map *here,
                                       const tripoint_bub_ms &position );

void runtime_world_ready( bool new_game );
void runtime_before_save();
bool runtime_save( std::string &error );
void runtime_after_save( bool success, std::string_view error );
void runtime_process_tasks();
void runtime_process_character_recurring( Character &character );
bool dispatch_platform_mapgen_generate( mapgendata &data );
void dispatch_platform_mapgen_postprocess( mapgendata &data );

bool has_runtime_hook( std::string_view name );
cata::lua_ui::native_hook_result dispatch_runtime_hook(
    std::string_view name,
    const cata::lua_ui::native_callback_arguments &arguments = {},
    const cata::lua_ui::native_hook_result &initial = {} );

#endif

} // namespace cata::lua_platform

namespace cata::lua_platform
{

/** One complete, bounded field-emission decision. */
struct emission_profile {
    std::string field;
    int intensity = 1;
    int quantity = 1;
    int chance = 100;
};

/** Dispatch a native damage-type callback; a non-Lua build provides a no-op. */
void invoke_damage_type_handler( std::string_view damage_id,
                                 std::string_view phase,
                                 Creature *source, Creature *target,
                                 std::string_view body_part = {},
                                 double total_damage = 0.0,
                                 double damage_taken = 0.0 );

/** Dispatch a native Lua ammunition-impact policy; a non-Lua build is a no-op. */
void invoke_ammo_effect_handler( std::string_view ammo_effect_id,
                                 Creature *source, Creature *target,
                                 const tripoint_bub_ms &position,
                                 int dealt_damage );

/** Run a Lua addiction tick policy; no Lua-authored definition yields nullopt. */
std::optional<bool> invoke_addiction_type_handler(
    std::string_view addiction_type_id, Character &character,
    int intensity, std::int64_t sated_turns );

/** Evaluate a Lua-authored character modifier; no Lua definition yields nullopt. */
std::optional<double> invoke_character_modifier_handler(
    std::string_view modifier_id, const Character &character,
    std::string_view skill_id );

/** Evaluate a Lua-authored shop group or price-rule policy. */
std::optional<bool> invoke_shop_condition_handler(
    std::string_view mod_id, std::string_view owner_id,
    std::string_view policy_kind, std::string_view selector_kind,
    std::string_view selector_id, std::string_view handler_id,
    const item *candidate, const npc &shopkeeper );

/** Dispatch a Lua-authored overmap terrain entry or exit policy. */
void invoke_overmap_terrain_handler(
    std::string_view terrain_id, std::string_view phase,
    const tripoint_abs_omt &old_position, const tripoint_abs_omt &new_position,
    const Character &character );

/** Evaluate a Lua-authored overmap-special placement condition. */
std::optional<bool> invoke_overmap_special_condition_handler(
    std::string_view special_id, const tripoint_abs_omt &position,
    int rotation, std::string_view city_name, int city_size,
    int city_population );

/** Dispatch a Lua-authored overmap-special placement effect. */
void invoke_overmap_special_placement_handler(
    std::string_view special_id, const tripoint_abs_omt &position,
    int rotation, std::string_view city_name, int city_size,
    int city_population );

/** Dispatch a Lua-authored vehicle-part activation policy. */
void invoke_vehicle_part_activation_handler(
    std::string_view part_id, vehicle &subject, vehicle_part &part,
    Character &character );

/** Run a Lua-first terminal access policy; true continues the native terminal flow. */
std::optional<bool> invoke_computer_access_handler(
    computer &terminal, Character &character );

/** Dispatch a Lua-first profession or scenario start lifecycle handler. */
void invoke_character_start_handler(
    std::string_view kind, std::string_view definition_id,
    std::string_view mod_id, std::string_view handler_id,
    Character &character );

/** Dispatch a Lua-first recipe completion handler after legacy result EOCs. */
void invoke_recipe_completion_handler(
    std::string_view recipe_id, std::string_view mod_id,
    std::string_view handler_id, Character &character, int batch );

/** Run a Lua-first trap policy; true continues the configured native action. */
std::optional<bool> invoke_trap_trigger_handler(
    std::string_view trap_id, std::string_view mod_id,
    std::string_view handler_id, const tripoint_abs_ms &position,
    Creature *creature, const item *triggering_item );

/** Dispatch Lua-first seed/furniture handlers for one plant lifecycle event. */
void invoke_plant_lifecycle_handlers(
    std::string_view phase, Character &character, map &here,
    const tripoint_bub_ms &position, std::string_view seed_id,
    std::string_view old_stage, std::string_view new_stage,
    int effective_growth_turns, int water,
    const std::map<std::string, std::string> &string_context,
    const std::map<std::string, double> &number_context );

/** Dispatch one Lua-first martial-art lifecycle phase. */
void invoke_martial_art_handler( std::string_view martial_art_id,
                                 std::string_view phase,
                                 Character &character );

/** Dispatch a Lua-first technique callback after one application repeat. */
void invoke_technique_application_handler(
    std::string_view technique_id, std::string_view mod_id,
    std::string_view handler_id, Character &attacker, Creature &target,
    int repeat_index, int repeat_count, double total_damage,
    std::string_view weapon_id );

/** Dispatch a Lua-first post-consumption item handler. */
void invoke_item_consumption_handler( std::string_view item_id,
                                      std::string_view mod_id,
                                      std::string_view handler_id,
                                      Character &character, item &consumed_item );

/** Dispatch a Lua-first weakpoint effect handler after its legacy EOCs. */
void invoke_weakpoint_effect_handler(
    std::string_view set_id, std::string_view weakpoint_id,
    std::string_view mod_id, std::string_view handler_id,
    Creature &target, int total_damage, const weakpoint_attack &attack );

/** Evaluate a Lua-authored behavior condition for one native AI subject. */
std::optional<bool> invoke_behavior_condition_handler(
    std::string_view mod_id, std::string_view behavior_id,
    std::string_view handler_id, const Creature *subject,
    std::string_view argument );

/** Evaluate a Lua-authored behavior utility score for one native AI subject. */
std::optional<double> invoke_behavior_score_handler(
    std::string_view mod_id, std::string_view behavior_id,
    std::string_view handler_id, const Creature *subject,
    std::string_view argument );

/** Run one Lua-authored native monster special attack policy. */
std::optional<bool> invoke_monster_attack_handler(
    std::string_view mod_id, std::string_view attack_id,
    std::string_view handler_id, Creature &attacker );

/** Dispatch a post-hit handler for one native monster melee attack. */
void invoke_monster_attack_result_handler(
    std::string_view monster_type_id, std::string_view attack_id,
    std::string_view mod_id, std::string_view handler_id,
    Creature &attacker, Creature *target, int total_damage );

/** Dispatch a Lua-first monster death handler after native death effects. */
void invoke_monster_death_handler(
    std::string_view monster_type_id, std::string_view mod_id,
    std::string_view handler_id, Creature &monster, Creature *killer,
    const tripoint_abs_ms &position );

/** Run a Lua-first NPC template death policy; false prevents the death flow. */
std::optional<bool> invoke_npc_death_handler(
    std::string_view npc_template_id, std::string_view mod_id,
    std::string_view handler_id, npc &subject, Creature *killer,
    const tripoint_abs_ms &position );

/** Dispatch a Lua-first terrain or furniture examine actor. */
void invoke_examine_handler(
    std::string_view target_kind, std::string_view target_id,
    std::string_view mod_id, std::string_view handler_id,
    Character &character, const tripoint_bub_ms &position );

/** Evaluate a Lua-authored weather condition against one generated sample. */
std::optional<bool> invoke_weather_type_handler(
    std::string_view weather_type_id, const w_point &sample );

/** Evaluate a Lua-authored end-screen selection policy. */
std::optional<bool> invoke_end_screen_handler(
    std::string_view end_screen_id, const Character &character );

/**
 * Run one Lua-authored activity policy and apply its bounded result table.
 * Returns true when a Lua-first definition owns the activity type, including
 * when that definition deliberately omits the requested policy.
 */
bool invoke_activity_type_handler( std::string_view activity_type_id,
                                   std::string_view phase,
                                   player_activity &activity,
                                   Character &character );

/** Dispatch one Lua-authored snippet examine policy; true means Lua owns it. */
bool invoke_snippet_examine_handler( std::string_view snippet_id,
                                     std::string_view item_type_id,
                                     Character &character );

/** Evaluate a native Lua magic-type policy; no handler yields std::nullopt. */
std::optional<double> invoke_magic_type_number_handler(
    std::string_view magic_type_id, std::string_view phase,
    std::string_view spell_id, const Creature *caster = nullptr,
    double input = 0.0 );

/** Dispatch a native Lua magic-type cast-failure callback. */
void invoke_magic_type_failure_handler( std::string_view magic_type_id,
                                        std::string_view spell_id,
                                        Character &caster );

/** Evaluate one Lua-authored emission profile; no override yields nullopt. */
std::optional<emission_profile> invoke_emission_profile_handler(
    std::string_view emission_id, const tripoint_bub_ms &position,
    const emission_profile &fallback );

} // namespace cata::lua_platform

#endif // CATA_SRC_CATALUA_PLATFORM_RUNTIME_H
