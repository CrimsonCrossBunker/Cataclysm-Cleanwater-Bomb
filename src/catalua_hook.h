#pragma once
#ifndef CATA_SRC_CATALUA_HOOK_H
#define CATA_SRC_CATALUA_HOOK_H

#include <cstdint>
#include <cstddef>
#include <optional>
#include <string>
#include <string_view>
#include <utility>
#include <variant>
#include <vector>

#include "coordinates.h"
#include "catalua_ui_state.h"

class Character;
class Creature;
class const_talker;
class item;
class mapgendata;
struct dialogue;
struct talk_topic;

namespace cata::lua
{

struct native_callback_point {
    std::string coordinate_space;
    tripoint_rel_ms pos;
};

struct native_callback_id {
    std::string kind;
    std::string value;
};

struct native_callback_mission {
    int uid = 0;
};

using native_callback_value = std::variant <
                              bool, std::int64_t, double, std::string,
                              const Character *, const Creature *, const item *,
                              native_callback_point, native_callback_id,
                              std::vector<std::string>, const const_talker *,
                              native_callback_mission >;

struct native_callback_argument {
    std::string name;
    native_callback_value value;
};

using native_callback_arguments = std::vector<native_callback_argument>;

struct native_menu_entry {
    std::string id;
    std::string label;
    bool enabled = true;
};

struct native_hook_result {
    bool allowed = true;
    bool handled = false;
    std::string text;
    std::optional<std::string> result;
    std::vector<std::string> results;
    std::vector<native_menu_entry> menu_entries;
};

/** Return whether a named Platform hook is part of the native result contract. */
bool native_hook_contract_exists( std::string_view name );

/** Return whether a named Platform hook accepts a specific aggregate field. */
bool native_hook_supports_result_field( std::string_view name,
                                        std::string_view field );

native_hook_result dispatch_native_hook_result(
    std::string_view name,
    const native_callback_arguments &arguments = {} );
bool dispatch_native_hook(
    std::string_view name,
    const native_callback_arguments &arguments = {} );
bool dispatch_avatar_fatal( Character &character, const Creature *killer );
bool dispatch_npc_fatal( Character &character, const Creature *killer );
bool has_native_hook( std::string_view name );
std::vector<std::string> collect_native_mapgen_factory_usages(
    const std::vector<std::string> &candidates );
void dispatch_native_monster_spawn(
    const Creature &monster, std::string_view source );
void dispatch_native_npc_spawn(
    const Character &npc, std::string_view source );
std::string dispatch_character_display_skill_info(
    const Character &character, std::string_view skill );
bool dispatch_character_display_skill_action(
    const Character &character, std::string_view skill,
    std::string_view action );
native_hook_result dispatch_native_dialogue_hook(
    std::string_view name, const const_talker &alpha,
    const const_talker &beta, std::string_view topic,
    std::optional<std::string_view> option = std::nullopt,
    bool by_radio = false,
    std::optional<std::string_view> reason = std::nullopt );
void clear_dialogue_response_callbacks();
std::optional<std::string> dialogue_dynamic_line(
    dialogue &d, const talk_topic &topic );
void apply_lua_dialogue_speaker_effects(
    dialogue &d, const talk_topic &topic );
bool gen_lua_dialogue_responses(
    dialogue &d, const talk_topic &topic );
void extend_lua_dialogue_responses(
    dialogue &d, const talk_topic &topic );
talk_topic apply_lua_dialogue_response(
    dialogue &d, std::uint64_t response_id, const talk_topic &fallback,
    bool trial_success );
bool begin_native_npc_interaction(
    const Character &avatar, const Character &npc );
bool allow_native_monster_interaction(
    const Character &avatar, const Creature &monster );
bool allow_native_elevator_use(
    const Character &character,
    const native_callback_point &position,
    const native_callback_point &destination );
std::vector<native_menu_entry> collect_native_hook_menu_entries(
    std::string_view name,
    const native_callback_arguments &arguments = {} );

enum class script_hook_mode : int {
    observe,
    intercept
};

struct script_hook_spec {
    script_hook_spec( std::string_view name_in, script_hook_mode mode_in,
                      std::vector<std::string_view> payload_fields_in,
                      std::vector<std::string_view> result_fields_in = {} ) :
        name( name_in ),
        mode( mode_in ),
        payload_fields( std::move( payload_fields_in ) ),
        result_fields( std::move( result_fields_in ) ) {}

    std::string_view name;
    script_hook_mode mode = script_hook_mode::observe;
    std::vector<std::string_view> payload_fields;
    std::vector<std::string_view> result_fields;
};

const std::vector<script_hook_spec> &script_hook_specs();
const script_hook_spec *find_script_hook_spec( std::string_view name );
bool script_hook_supports_result( const script_hook_spec &spec,
                                  std::string_view field );
std::string_view script_hook_mode_name( script_hook_mode mode );

} // namespace cata::lua

#endif // CATA_SRC_CATALUA_HOOK_H
