#include "catalua_ui.h"

#include <algorithm>
#include <cctype>
#include <optional>

#include "catalua_ui_actions.h"

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

void on_world_ready()
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

bool show_page( const std::string & )
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
