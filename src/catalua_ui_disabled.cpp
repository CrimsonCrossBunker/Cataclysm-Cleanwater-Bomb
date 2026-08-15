#include "catalua_ui.h"

#include <algorithm>
#include <cctype>
#include <optional>
#include <string>
#include <string_view>
#include <vector>

#include "catalua_ui_actions.h"
#include "dialogue.h"

namespace cata::lua_ui
{

namespace
{

constexpr std::string_view disabled_error = "Lua UI is not enabled in this build";

} // namespace

bool is_safe_module_name( std::string_view name )
{
    if( name.empty() || name.front() == '.' || name.back() == '.' || name.find( ".." ) !=
        std::string_view::npos ) {
        return false;
    }
    return std::all_of( name.begin(), name.end(), []( const unsigned char ch ) {
        return std::isalnum( ch ) != 0 || ch == '_' || ch == '-' || ch == '.';
    } );
}

bool reload_scripts( std::string &error )
{
    error = disabled_error;
    return false;
}

bool validate_mod_scripts( const std::vector<std::string> &, std::string &error )
{
    // A build without Lua has no script runtime to validate.
    error.clear();
    return true;
}

void on_turn()
{
}

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
    dialogue &, std::uint64_t, const talk_topic &fallback )
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

bool dispatch_native_callback(
    std::string_view, std::string_view, std::string_view,
    const native_callback_arguments & )
{
    return true;
}

bool dispatch_native_consuming_callback(
    std::string_view, std::string_view, std::string_view,
    const native_callback_arguments & )
{
    return false;
}

bool has_native_callback(
    std::string_view, std::string_view, std::string_view )
{
    return false;
}

std::vector<native_menu_entry> collect_native_callback_menu_entries(
    std::string_view, std::string_view, std::string_view,
    const native_callback_arguments & )
{
    return {};
}

std::vector<native_menu_entry> collect_native_hook_menu_entries(
    std::string_view, const native_callback_arguments & )
{
    return {};
}

bool invoke_lua_handler(
    std::string_view, const script_value_map &,
    const native_callback_arguments & )
{
    return true;
}

void dispatch_mapgen_postprocess( mapgendata & )
{
}

void on_world_ready( world_ready_kind )
{
}

void on_game_save()
{
}

bool save_persistent_state( std::string &error )
{
    error.clear();
    return true;
}

void shutdown()
{
}

runtime_status status()
{
    runtime_status result;
    result.last_error = disabled_error;
    return result;
}

bool validate_snippet( std::string_view, int, std::string &error )
{
    error = disabled_error;
    return false;
}

std::vector<page_info> registered_pages( std::string_view )
{
    return {};
}

bool has_registered_pages( std::string_view )
{
    return false;
}

std::vector<action_menu_entry_info>
registered_action_menu_entries()
{
    return {};
}

bool invoke_action_menu_entry( std::uint64_t )
{
    return false;
}

std::vector<sidebar_widget_info> registered_sidebar_widgets()
{
    return {};
}

bool sidebar_widget_visible( std::string_view )
{
    return false;
}

std::vector<sidebar_widget_line> render_sidebar_widget(
    std::string_view, int, int )
{
    return {};
}

bool show_page( std::string_view )
{
    return false;
}

void show_slot( std::string_view )
{
}

bool process_pending_navigation()
{
    return false;
}

void show()
{
}

std::optional<bool> process_next_action()
{
    return std::nullopt;
}

void clear_actions()
{
}

} // namespace cata::lua_ui
