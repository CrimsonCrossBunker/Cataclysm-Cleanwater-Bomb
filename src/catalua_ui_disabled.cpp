#include "catalua_ui.h"

#include "catalua_hook.h"

#include <optional>
#include <string>
#include <string_view>
#include <vector>

#include "dialogue.h"

namespace cata::lua
{

native_hook_result dispatch_native_hook_result(
    std::string_view, const native_callback_arguments & )
{
    return {};
}

bool dispatch_native_hook(
    std::string_view, const native_callback_arguments & )
{
    return true;
}

bool dispatch_avatar_fatal( Character &, const Creature * )
{
    return true;
}

bool dispatch_npc_fatal( Character &, const Creature * )
{
    return true;
}

bool has_native_hook( std::string_view )
{
    return false;
}

bool native_hook_supports_result_field( std::string_view, std::string_view )
{
    return false;
}

bool native_hook_contract_exists( std::string_view )
{
    return false;
}

std::vector<std::string> collect_native_mapgen_factory_usages(
    const std::vector<std::string> & )
{
    return {};
}

void dispatch_native_monster_spawn(
    const Creature &, std::string_view )
{
}

void dispatch_native_npc_spawn(
    const Character &, std::string_view )
{
}

std::string dispatch_character_display_skill_info(
    const Character &, std::string_view )
{
    return {};
}

bool dispatch_character_display_skill_action(
    const Character &, std::string_view, std::string_view )
{
    return false;
}

native_hook_result dispatch_native_dialogue_hook(
    std::string_view, const const_talker &, const const_talker &,
    std::string_view, std::optional<std::string_view>,
    bool, std::optional<std::string_view> )
{
    return {};
}

void clear_dialogue_response_callbacks()
{
}

std::optional<std::string> dialogue_dynamic_line(
    dialogue &, const talk_topic & )
{
    return std::nullopt;
}

void apply_lua_dialogue_speaker_effects(
    dialogue &, const talk_topic & )
{
}

bool gen_lua_dialogue_responses(
    dialogue &, const talk_topic & )
{
    return false;
}

void extend_lua_dialogue_responses(
    dialogue &, const talk_topic & )
{
}

talk_topic apply_lua_dialogue_response(
    dialogue &, std::uint64_t, const talk_topic &fallback, const bool )
{
    return fallback;
}

bool begin_native_npc_interaction(
    const Character &, const Character & )
{
    return true;
}

bool allow_native_monster_interaction(
    const Character &, const Creature & )
{
    return true;
}

bool allow_native_elevator_use(
    const Character &, const native_callback_point &,
    const native_callback_point & )
{
    return true;
}

std::vector<native_menu_entry> collect_native_hook_menu_entries(
    std::string_view, const native_callback_arguments & )
{
    return {};
}

void dispatch_mapgen_postprocess( mapgendata & )
{
}

bool dispatch_mapgen_generate( mapgendata & )
{
    return false;
}

} // namespace cata::lua
