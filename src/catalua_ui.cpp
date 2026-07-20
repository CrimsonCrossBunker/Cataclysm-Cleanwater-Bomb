#include "catalua_ui.h"

#include <algorithm>
#include <cctype>
#include <filesystem>
#include <memory>
#include <stdexcept>
#include <string>
#include <utility>
#include <vector>

#include "avatar.h"
#include "cata_imgui.h"
#include "catalua_sol.h"
#include "filesystem.h"
#include "imgui/imgui.h"
#include "imgui/imgui_stdlib.h"
#include "input_context.h"
#include "messages.h"
#include "output.h"
#include "path_info.h"
#include "translations.h"
#include "ui_manager.h"
#include "uilist.h"

namespace cata::lua_ui
{

namespace
{

namespace fs = std::filesystem;

class script_ui_context
{
    public:
        void text( const std::string &value ) const {
            ImGui::TextWrapped( "%s", value.c_str() );
        }

        void separator() const {
            ImGui::Separator();
        }

        void same_line() const {
            ImGui::SameLine();
        }

        bool button( const std::string &label ) const {
            return ImGui::Button( label.c_str() );
        }

        bool checkbox( const std::string &label, bool value ) const {
            ImGui::Checkbox( label.c_str(), &value );
            return value;
        }

        int slider_int( const std::string &label, int value, int minimum, int maximum ) const {
            ImGui::SliderInt( label.c_str(), &value, minimum, maximum );
            return value;
        }

        double slider_float( const std::string &label, double value, double minimum,
                             double maximum ) const {
            float result = static_cast<float>( value );
            ImGui::SliderFloat( label.c_str(), &result, static_cast<float>( minimum ),
                                static_cast<float>( maximum ) );
            return result;
        }

        std::string input_text( const std::string &label, std::string value ) const {
            ImGui::InputText( label.c_str(), &value );
            return value;
        }
};

struct page_definition {
    std::string id;
    std::string title;
    sol::protected_function draw;
};

struct runtime_state {
    sol::state lua;
    std::vector<fs::path> module_roots;
    std::vector<page_definition> pages;
};

std::unique_ptr<runtime_state> active_state;

runtime_state *state_from_upvalue( lua_State *lua )
{
    return static_cast<runtime_state *>( lua_touserdata( lua, lua_upvalueindex( 1 ) ) );
}

std::string module_relative_path( std::string name )
{
    std::replace( name.begin(), name.end(), '.', fs::path::preferred_separator );
    return name + ".lua";
}

int module_searcher( lua_State *lua )
{
    runtime_state *state = state_from_upvalue( lua );
    const char *raw_name = luaL_checkstring( lua, 1 );
    const std::string name = raw_name == nullptr ? std::string() : std::string( raw_name );
    if( state == nullptr || !is_safe_module_name( name ) ) {
        lua_pushfstring( lua, "\n\tunsafe Lua module name '%s'", name.c_str() );
        return 1;
    }

    const std::string relative = module_relative_path( name );
    for( const fs::path &root : state->module_roots ) {
        const fs::path candidate = ( root / relative ).lexically_normal();
        if( !file_exist( candidate.string() ) ) {
            continue;
        }
        if( luaL_loadfile( lua, candidate.string().c_str() ) != LUA_OK ) {
            return lua_error( lua );
        }
        lua_pushstring( lua, candidate.string().c_str() );
        return 2;
    }

    lua_pushfstring( lua, "\n\tno Lua module named '%s'", name.c_str() );
    return 1;
}

void install_module_searcher( runtime_state &state )
{
    lua_State *lua = state.lua.lua_state();
    lua_getglobal( lua, "package" );
    lua_newtable( lua );
    lua_pushlightuserdata( lua, &state );
    lua_pushcclosure( lua, module_searcher, 1 );
    lua_rawseti( lua, -2, 1 );
    lua_setfield( lua, -2, "searchers" );
    lua_pushliteral( lua, "" );
    lua_setfield( lua, -2, "path" );
    lua_pushliteral( lua, "" );
    lua_setfield( lua, -2, "cpath" );
    lua_pop( lua, 1 );
}

void register_page( runtime_state &state, const std::string &id, const std::string &title,
                    sol::protected_function draw )
{
    if( id.empty() ) {
        throw std::runtime_error( "ui.page requires a non-empty id" );
    }
    if( !draw.valid() ) {
        throw std::runtime_error( "ui.page requires a draw function" );
    }

    const auto existing = std::find_if( state.pages.begin(), state.pages.end(),
    [&id]( const page_definition & page ) {
        return page.id == id;
    } );
    page_definition replacement{ id, title.empty() ? id : title, std::move( draw ) };
    if( existing == state.pages.end() ) {
        state.pages.emplace_back( std::move( replacement ) );
    } else {
        *existing = std::move( replacement );
    }
}

void initialize_state( runtime_state &state )
{
    state.module_roots = {
        fs::u8path( PATH_INFO::config_dir() ) / "lua",
        fs::u8path( PATH_INFO::datadir() ) / "lua"
    };

    state.lua.open_libraries( sol::lib::base, sol::lib::package, sol::lib::math,
                              sol::lib::string, sol::lib::table );
    state.lua["dofile"] = sol::nil;
    state.lua["load"] = sol::nil;
    state.lua["loadfile"] = sol::nil;
    state.lua["loadstring"] = sol::nil;
    install_module_searcher( state );

    state.lua.new_usertype<script_ui_context>(
        "ScriptUiContext", sol::no_constructor,
        "text", &script_ui_context::text,
        "separator", &script_ui_context::separator,
        "same_line", &script_ui_context::same_line,
        "button", &script_ui_context::button,
        "checkbox", &script_ui_context::checkbox,
        "slider_int", &script_ui_context::slider_int,
        "slider_float", &script_ui_context::slider_float,
        "input_text", &script_ui_context::input_text );

    sol::table ui = state.lua.create_named_table( "ui" );
    ui.set_function( "page", [&state]( const std::string & id, const std::string & title,
    sol::protected_function draw ) {
        register_page( state, id, title, std::move( draw ) );
    } );

    sol::table game = state.lua.create_named_table( "game" );
    game["api_version"] = api_version;
    game.set_function( "add_msg", []( const std::string & message ) {
        ::add_msg( message );
    } );
    game.set_function( "player_name", []() {
        return get_avatar().get_name();
    } );
    state.lua.set_function( "print", []( const sol::variadic_args & values ) {
        std::string message;
        for( const sol::object &value : values ) {
            if( !message.empty() ) {
                message += '\t';
            }
            sol::state_view lua( value.lua_state() );
            sol::protected_function tostring = lua["tostring"];
            sol::protected_function_result result = tostring( value );
            if( result.valid() ) {
                message += result.get<std::string>();
            }
        }
        ::add_msg( message );
    } );
}

void run_script( runtime_state &state, const fs::path &path )
{
    sol::load_result loaded = state.lua.load_file( path.string() );
    if( !loaded.valid() ) {
        const sol::error error = loaded;
        throw std::runtime_error( path.string() + ": " + error.what() );
    }
    sol::protected_function script = loaded;
    sol::protected_function_result result = script();
    if( !result.valid() ) {
        const sol::error error = result;
        throw std::runtime_error( path.string() + ": " + error.what() );
    }
}

bool reload( std::string &error )
{
    try {
        auto next = std::make_unique<runtime_state>();
        initialize_state( *next );

        bool found_script = false;
        const fs::path bundled = fs::u8path( PATH_INFO::datadir() ) / "lua" / "main.lua";
        const fs::path user = fs::u8path( PATH_INFO::config_dir() ) / "lua" / "main.lua";
        for( const fs::path &script : {
                 bundled, user
             } ) {
            if( file_exist( script.string() ) ) {
                run_script( *next, script );
                found_script = true;
            }
        }
        if( !found_script ) {
            throw std::runtime_error( "No Lua entry script found in data/lua or config/lua" );
        }
        active_state = std::move( next );
        error.clear();
        return true;
    } catch( const std::exception &exception ) {
        error = exception.what();
        return false;
    }
}

page_definition *find_page( const std::string &id )
{
    if( !active_state ) {
        return nullptr;
    }
    const auto found = std::find_if( active_state->pages.begin(), active_state->pages.end(),
    [&id]( const page_definition & page ) {
        return page.id == id;
    } );
    return found == active_state->pages.end() ? nullptr : &*found;
}

class lua_page_window : public cataimgui::window
{
    public:
        lua_page_window( std::string page_id, const std::string &title ) :
            cataimgui::window( title ), page_id_( std::move( page_id ) ) {}

        void run() {
            input_context context( "HELP_KEYBINDINGS" );
            context.register_action( "QUIT" );
            context.register_action( "ANY_INPUT" );
            context.register_action( "HELP_KEYBINDINGS" );

            ui_manager::redraw();
            while( get_is_open() ) {
                ui_manager::redraw();
                if( context.handle_input( 5 ) == "QUIT" ) {
                    break;
                }
            }
        }

    protected:
        cataimgui::bounds get_bounds() override {
            return { -1.0F, -1.0F, 0.85F, 0.85F };
        }

        void draw_controls() override {
            if( ImGui::Button( _( "Reload Lua" ) ) ) {
                std::string error;
                if( reload( error ) ) {
                    ::add_msg( _( "Lua UI scripts reloaded." ) );
                } else {
                    ::add_msg( m_bad, _( "Lua reload failed: %s" ), error );
                }
            }
            ImGui::Separator();

            page_definition *page = find_page( page_id_ );
            if( page == nullptr ) {
                ImGui::TextWrapped( "%s", _( "This page is no longer registered." ) );
                return;
            }

            script_ui_context context;
            sol::protected_function_result result = page->draw( &context );
            if( !result.valid() ) {
                const sol::error error = result;
                ImGui::TextWrapped( "%s", error.what() );
            }
        }

    private:
        std::string page_id_;
};

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

void show()
{
    std::string error;
    if( !reload( error ) ) {
        popup( _( "Unable to load Lua UI scripts:\n%s" ), error );
        return;
    }
    if( active_state->pages.empty() ) {
        popup( _( "Lua loaded successfully, but no UI pages were registered." ) );
        return;
    }

    uilist menu;
    menu.text = _( "Lua UI pages" );
    for( std::size_t index = 0; index < active_state->pages.size(); ++index ) {
        menu.addentry( static_cast<int>( index ), true, MENU_AUTOASSIGN,
                       active_state->pages[index].title );
    }
    menu.query();
    if( menu.ret < 0 || static_cast<std::size_t>( menu.ret ) >= active_state->pages.size() ) {
        return;
    }

    const page_definition &page = active_state->pages[menu.ret];
    lua_page_window window( page.id, page.title );
    window.run();
}

} // namespace cata::lua_ui
