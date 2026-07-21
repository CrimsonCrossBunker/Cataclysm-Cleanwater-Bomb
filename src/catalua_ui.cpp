#include "catalua_ui.h"

#include <algorithm>
#include <cctype>
#include <chrono>
#include <cstdlib>
#include <filesystem>
#include <memory>
#include <mutex>
#include <optional>
#include <stdexcept>
#include <string>
#include <utility>
#include <unordered_map>
#include <vector>

#include "avatar.h"
#include "calendar.h"
#include "cata_imgui.h"
#include "cata_utility.h"
#include "cata_variant.h"
#include "catalua_sol.h"
#include "catalua_ui_actions.h"
#include "catalua_ui_actions_internal.h"
#include "catalua_ui_game.h"
#include "catalua_ui_imgui.h"
#include "catalua_ui_manifest.h"
#include "catalua_ui_renderer.h"
#include "catalua_ui_retained.h"
#include "catalua_ui_state.h"
#include "debug.h"
#include "enum_conversions.h"
#include "event.h"
#include "event_bus.h"
#include "event_subscriber.h"
#include "filesystem.h"
#include "imgui/imgui.h"
#include "input_context.h"
#include "json_loader.h"
#include "messages.h"
#include "mod_manager.h"
#include "output.h"
#include "path_info.h"
#include "point.h"
#include "translations.h"
#include "ui_manager.h"
#include "uilist.h"
#include "worldfactory.h"

namespace cata::lua_ui
{

namespace
{

namespace fs = std::filesystem;

constexpr std::size_t default_memory_limit = 32U * 1024U * 1024U;
constexpr int script_instruction_limit = 1000000;
constexpr int callback_instruction_limit = 250000;
constexpr std::uint64_t slow_callback_threshold_us = 8000;

struct memory_tracker {
    std::size_t used = 0;
    std::size_t limit = default_memory_limit;
};

void *limited_allocator( void *userdata, void *pointer, std::size_t old_size,
                         std::size_t new_size )
{
    memory_tracker &tracker = *static_cast<memory_tracker *>( userdata );
    if( new_size == 0 ) {
        tracker.used = old_size > tracker.used ? 0 : tracker.used - old_size;
        std::free( pointer );
        return nullptr;
    }

    const std::size_t current = pointer == nullptr ? 0 : old_size;
    const std::size_t used_without_current = tracker.used - std::min( tracker.used, current );
    if( new_size > tracker.limit - used_without_current ) {
        return nullptr;
    }
    void *result = std::realloc( pointer, new_size );
    if( result != nullptr ) {
        tracker.used = used_without_current + new_size;
    }
    return result;
}

void instruction_limit_hook( lua_State *lua, lua_Debug * )
{
    luaL_error( lua, "Lua instruction budget exceeded" );
}

class instruction_guard
{
    public:
        instruction_guard( lua_State *lua, int limit ) : lua_( lua ), old_hook_( lua_gethook( lua ) ),
            old_mask_( lua_gethookmask( lua ) ), old_count_( lua_gethookcount( lua ) ) {
            lua_sethook( lua_, instruction_limit_hook, LUA_MASKCOUNT, std::max( 1, limit ) );
        }

        instruction_guard( const instruction_guard & ) = delete;
        instruction_guard &operator=( const instruction_guard & ) = delete;

        ~instruction_guard() {
            lua_sethook( lua_, old_hook_, old_mask_, old_count_ );
        }

    private:
        lua_State *lua_;
        lua_Hook old_hook_;
        int old_mask_;
        int old_count_;
};

struct page_definition {
    std::string id;
    std::string title;
    sol::protected_function draw;
    bool enabled = true;
    std::string error;
    std::size_t source_index = 0;
};

struct hud_definition {
    std::string id;
    std::string title;
    std::string anchor = "top_left";
    float offset_x = 12.0F;
    float offset_y = 12.0F;
    float alpha = 0.8F;
    float default_width = 0.28F;
    float default_height = 0.18F;
    bool interactive = false;
    bool background = true;
    bool title_bar = false;
    bool movable = true;
    bool scalable = true;
    bool user_toggleable = true;
    sol::protected_function draw;
    bool enabled = true;
    std::string error;
    std::size_t source_index = 0;
};

struct event_handler_definition {
    event_type type = event_type::num_event_types;
    std::string name;
    sol::protected_function callback;
    bool enabled = true;
    std::string error;
    std::size_t source_index = 0;
};

struct script_source {
    script_manifest manifest;
    fs::path root;
    fs::path entry;
};

class runtime_state : public event_subscriber
{
    public:
        runtime_state() : lua( sol::default_at_panic, limited_allocator, &memory ) {}

        using event_subscriber::notify;
        void notify( const cata::event &event ) override;

        memory_tracker memory;
        script_persistent_state persistent_state;
        sol::state lua;
        std::vector<fs::path> module_roots;
        std::vector<script_source> sources;
        std::vector<page_definition> pages;
        std::vector<hud_definition> huds;
        std::vector<event_handler_definition> event_handlers;
        std::size_t generation = 0;
        bool accept_actions = false;
        std::optional<std::size_t> current_source;
        std::uint64_t callback_count = 0;
        std::uint64_t callback_time_total_us = 0;
        std::uint64_t callback_time_max_us = 0;
        std::uint64_t slow_callback_count = 0;
        std::string last_slow_callback;
};

std::unique_ptr<runtime_state> active_state;
std::unique_ptr<ui_adaptor> hud_adaptor;
std::string last_runtime_error;
std::size_t generation_counter = 0;
std::mutex android_state_mutex;
std::unordered_map<std::string, std::string> android_interactions;
std::string android_selected_page;
std::string android_last_published_page;
std::chrono::steady_clock::time_point android_last_publish;
std::string android_published_snapshot =
    R"({"schema":1,"generation":0,"selectedPage":"","surfaces":[]})";

class source_scope
{
    public:
        source_scope( runtime_state &state, std::size_t source_index ) : state_( state ),
            previous_( state.current_source ) {
            if( source_index >= state.sources.size() ) {
                throw std::runtime_error( "Lua callback has an invalid source index" );
            }
            state_.current_source = source_index;
        }

        source_scope( const source_scope & ) = delete;
        source_scope &operator=( const source_scope & ) = delete;

        ~source_scope() {
            state_.current_source = previous_;
        }

    private:
        runtime_state &state_;
        std::optional<std::size_t> previous_;
};

const script_manifest &current_manifest( const runtime_state &state )
{
    if( !state.current_source || *state.current_source >= state.sources.size() ) {
        throw std::runtime_error( "Lua API call is outside a script source context" );
    }
    return state.sources[*state.current_source].manifest;
}

void require_capability( const runtime_state &state, const std::string &capability )
{
    const script_manifest &manifest = current_manifest( state );
    if( !manifest.has_capability( capability ) ) {
        throw std::runtime_error( "Lua source '" + manifest.id + "' lacks capability '" +
                                  capability + "'" );
    }
}

void record_callback_timing( runtime_state &state, const std::string &name,
                             std::chrono::steady_clock::time_point started )
{
    const auto elapsed = std::chrono::duration_cast<std::chrono::microseconds>(
                             std::chrono::steady_clock::now() - started );
    const std::uint64_t microseconds = static_cast<std::uint64_t>( std::max<std::int64_t>(
                                           0, elapsed.count() ) );
    ++state.callback_count;
    state.callback_time_total_us += microseconds;
    state.callback_time_max_us = std::max( state.callback_time_max_us, microseconds );
    if( microseconds >= slow_callback_threshold_us ) {
        ++state.slow_callback_count;
        state.last_slow_callback = name + " (" + std::to_string( microseconds ) + " us)";
    }
}

void record_runtime_error( const std::string &context, const std::string &error )
{
    last_runtime_error = context + ": " + error;
    // Script failures are isolated and recoverable.  Logging them as D_ERROR
    // emits an expensive native backtrace, which can stall hot reload for many
    // seconds without adding useful context beyond the Lua stack trace.
    DebugLog( D_WARNING, D_MAIN ) << last_runtime_error;
}

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
    lua_pushnil( lua );
    lua_setfield( lua, -2, "loadlib" );
    lua_pop( lua, 1 );
}

template<typename Definition>
auto find_definition( std::vector<Definition> &definitions, const std::string &id )
{
    return std::find_if( definitions.begin(), definitions.end(), [&id]( const Definition & entry ) {
        return entry.id == id;
    } );
}

void register_page( runtime_state &state, const std::string &id, const std::string &title,
                    sol::protected_function draw )
{
    require_capability( state, "ui.pages" );
    if( id.empty() ) {
        throw std::runtime_error( "ui.page requires a non-empty id" );
    }
    if( !draw.valid() ) {
        throw std::runtime_error( "ui.page requires a draw function" );
    }

    page_definition replacement{ id, title.empty() ? id : title, std::move( draw ), true, {},
                                 *state.current_source };
    const auto existing = find_definition( state.pages, id );
    if( existing == state.pages.end() ) {
        state.pages.emplace_back( std::move( replacement ) );
    } else {
        *existing = std::move( replacement );
    }
}

bool valid_anchor( const std::string &anchor )
{
    return anchor == "top_left" || anchor == "top_right" || anchor == "bottom_left" ||
           anchor == "bottom_right";
}

void register_hud( runtime_state &state, const std::string &id, const sol::table &options,
                   sol::protected_function draw )
{
    require_capability( state, "ui.hud" );
    if( id.empty() ) {
        throw std::runtime_error( "ui.hud requires a non-empty id" );
    }
    if( !draw.valid() ) {
        throw std::runtime_error( "ui.hud requires a draw function" );
    }

    hud_definition replacement;
    replacement.id = id;
    replacement.title = options.get_or( "title", id );
    replacement.anchor = options.get_or( "default_anchor",
                                         options.get_or( "anchor", std::string( "top_left" ) ) );
    replacement.offset_x = static_cast<float>( options.get_or( "default_x",
                           options.get_or( "x", 12.0 ) ) );
    replacement.offset_y = static_cast<float>( options.get_or( "default_y",
                           options.get_or( "y", 12.0 ) ) );
    replacement.alpha = static_cast<float>( std::clamp( options.get_or( "alpha", 0.8 ), 0.0, 1.0 ) );
    replacement.default_width = static_cast<float>( std::clamp(
                                    options.get_or( "default_width", 0.28 ), 0.10, 0.90 ) );
    replacement.default_height = static_cast<float>( std::clamp(
                                     options.get_or( "default_height", 0.18 ), 0.08, 0.90 ) );
    replacement.interactive = options.get_or( "interactive", false );
    replacement.background = options.get_or( "background", true );
    replacement.title_bar = options.get_or( "title_bar", false );
    replacement.movable = options.get_or( "movable", true );
    replacement.scalable = options.get_or( "scalable", true );
    replacement.user_toggleable = options.get_or( "user_toggleable", true );
    replacement.draw = std::move( draw );
    replacement.source_index = *state.current_source;
    if( !valid_anchor( replacement.anchor ) ) {
        throw std::runtime_error( "ui.hud anchor must be top_left, top_right, bottom_left, or bottom_right" );
    }

    const auto existing = find_definition( state.huds, id );
    if( existing == state.huds.end() ) {
        state.huds.emplace_back( std::move( replacement ) );
    } else {
        *existing = std::move( replacement );
    }
}

void register_event_handler( runtime_state &state, const std::string &name,
                             sol::protected_function callback )
{
    require_capability( state, "events" );
    if( !io::enum_is_valid<event_type>( name ) ) {
        throw std::runtime_error( "events.on received unknown event type '" + name + "'" );
    }
    if( !callback.valid() ) {
        throw std::runtime_error( "events.on requires a callback function" );
    }
    state.event_handlers.push_back( event_handler_definition{
        io::string_to_enum<event_type>( name ), name, std::move( callback ), true, {},
        *state.current_source
    } );
}

sol::object persistent_get( const runtime_state &runtime, sol::this_state lua,
                            const std::string &key,
                            const sol::object &default_value )
{
    require_capability( runtime, "state.character" );
    const auto found = runtime.persistent_state.find( key );
    if( found == runtime.persistent_state.end() ) {
        return default_value;
    }
    return std::visit( [lua]( const auto & value ) {
        return sol::make_object( lua, value );
    }, found->second );
}

void persistent_set( runtime_state &runtime, const std::string &key, const sol::object &value )
{
    require_capability( runtime, "state.character" );
    if( key.empty() ) {
        throw std::runtime_error( "game.state_set requires a non-empty key" );
    }
    switch( value.get_type() ) {
        case sol::type::boolean:
            assign_persistent_value( runtime.persistent_state, key, value.as<bool>() );
            break;
        case sol::type::number:
            if( value.is<lua_Integer>() ) {
                assign_persistent_value( runtime.persistent_state, key,
                                         static_cast<std::int64_t>( value.as<lua_Integer>() ) );
            } else {
                assign_persistent_value( runtime.persistent_state, key, value.as<double>() );
            }
            break;
        case sol::type::string:
            assign_persistent_value( runtime.persistent_state, key, value.as<std::string>() );
            break;
        case sol::type::nil:
            runtime.persistent_state.erase( key );
            break;
        default:
            throw std::runtime_error( "game.state_set only accepts boolean, number, string, or nil" );
    }
}

sol::table lua_runtime_status( sol::this_state lua )
{
    const runtime_status snapshot = status();
    sol::state_view state( lua );
    sol::table result = state.create_table();
    result["loaded"] = snapshot.loaded;
    result["generation"] = snapshot.generation;
    result["pages"] = snapshot.page_count;
    result["huds"] = snapshot.hud_count;
    result["event_handlers"] = snapshot.event_handler_count;
    result["sources"] = snapshot.source_count;
    result["memory_used"] = snapshot.memory_used;
    result["memory_limit"] = snapshot.memory_limit;
    result["callback_count"] = snapshot.callback_count;
    result["callback_time_total_us"] = snapshot.callback_time_total_us;
    result["callback_time_max_us"] = snapshot.callback_time_max_us;
    result["slow_callback_count"] = snapshot.slow_callback_count;
    result["last_slow_callback"] = snapshot.last_slow_callback;
    result["last_error"] = snapshot.last_error;
    return result;
}

void initialize_state( runtime_state &state, const std::vector<fs::path> &module_roots )
{
    state.module_roots = module_roots;
    state.lua.open_libraries( sol::lib::base, sol::lib::package, sol::lib::math,
                              sol::lib::string, sol::lib::table );
    state.lua["dofile"] = sol::nil;
    state.lua["load"] = sol::nil;
    state.lua["loadfile"] = sol::nil;
    state.lua["loadstring"] = sol::nil;
    state.lua["collectgarbage"] = sol::nil;
    install_module_searcher( state );

    state.lua.new_usertype<script_ui_context>(
        "ScriptUiContext", sol::no_constructor,
        "backend", &script_ui_context::backend,
        "platform", &script_ui_context::platform,
        "supports", &script_ui_context::supports,
        "is_immediate_mode", &script_ui_context::is_immediate_mode,
        "uses_native_widgets", &script_ui_context::uses_native_widgets,
        "text", &script_ui_context::text,
        "heading", &script_ui_context::heading,
        "bullet_text", &script_ui_context::bullet_text,
        "disabled_text", &script_ui_context::disabled_text,
        "text_colored", &script_ui_context::text_colored,
        "separator", &script_ui_context::separator,
        "same_line", &script_ui_context::same_line,
        "new_line", &script_ui_context::new_line,
        "spacing", &script_ui_context::spacing,
        "set_next_item_width", &script_ui_context::set_next_item_width,
        "progress_bar", &script_ui_context::progress_bar,
        "button", &script_ui_context::button,
        "button_id", &script_ui_context::button_id,
        "small_button", &script_ui_context::small_button,
        "small_button_id", &script_ui_context::small_button_id,
        "checkbox", &script_ui_context::checkbox,
        "checkbox_id", &script_ui_context::checkbox_id,
        "radio_button", &script_ui_context::radio_button,
        "radio_button_id", &script_ui_context::radio_button_id,
        "selectable", &script_ui_context::selectable,
        "selectable_id", &script_ui_context::selectable_id,
        "slider_int", &script_ui_context::slider_int,
        "slider_int_id", &script_ui_context::slider_int_id,
        "slider_float", &script_ui_context::slider_float,
        "slider_float_id", &script_ui_context::slider_float_id,
        "input_int", &script_ui_context::input_int,
        "input_int_id", &script_ui_context::input_int_id,
        "input_float", &script_ui_context::input_float,
        "input_float_id", &script_ui_context::input_float_id,
        "input_text", &script_ui_context::input_text,
        "input_text_id", &script_ui_context::input_text_id,
        "child", &script_ui_context::child,
        "table", &script_ui_context::table,
        "table_next_row", &script_ui_context::table_next_row,
        "table_next_column", &script_ui_context::table_next_column,
        "tabs", &script_ui_context::tabs,
        "tab", &script_ui_context::tab,
        "tree", &script_ui_context::tree,
        "modal", &script_ui_context::modal,
        "tooltip", &script_ui_context::tooltip,
        "virtual_list", &script_ui_context::virtual_list );

    sol::table ui = state.lua.create_named_table( "ui" );
    ui.set_function( "page", [&state]( const std::string & id, const std::string & title,
    sol::protected_function draw ) {
        register_page( state, id, title, std::move( draw ) );
    } );
    ui.set_function( "hud", [&state]( const std::string & id, const sol::table & options,
    sol::protected_function draw ) {
        register_hud( state, id, options, std::move( draw ) );
    } );

    sol::table events = state.lua.create_named_table( "events" );
    events.set_function( "on", [&state]( const std::string & name,
    sol::protected_function callback ) {
        register_event_handler( state, name, std::move( callback ) );
    } );

    sol::table game = state.lua.create_named_table( "game" );
    game["api_version"] = api_version;
    game.set_function( "add_msg", [&state]( const std::string & message ) {
        require_capability( state, "game.actions" );
        ::add_msg( message );
    } );
    game.set_function( "player_name", [&state]() {
        require_capability( state, "game.read" );
        return get_avatar().get_name();
    } );
    install_game_snapshot_api( game, [&state]() {
        require_capability( state, "game.read" );
    } );
    install_action_api( game, [&state]() {
        require_capability( state, "game.actions" );
    }, [&state]() {
        return state.accept_actions;
    } );
    game.set_function( "state_get", [&state]( sol::this_state lua, const std::string & key,
    const sol::object & default_value ) {
        return persistent_get( state, lua, key, default_value );
    } );
    game.set_function( "state_set", [&state]( const std::string & key, const sol::object & value ) {
        persistent_set( state, key, value );
    } );
    game.set_function( "runtime_status", lua_runtime_status );

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
        ::add_msg( "[Lua] " + message );
    } );
}

void run_script( runtime_state &state, const fs::path &path, std::size_t source_index )
{
    source_scope source( state, source_index );
    sol::load_result loaded = state.lua.load_file( path.string() );
    if( !loaded.valid() ) {
        const sol::error error = loaded;
        throw std::runtime_error( path.string() + ": " + error.what() );
    }
    sol::protected_function script = loaded;
    instruction_guard guard( state.lua.lua_state(), script_instruction_limit );
    sol::protected_function_result result = script();
    if( !result.valid() ) {
        const sol::error error = result;
        throw std::runtime_error( path.string() + ": " + error.what() );
    }
}

script_manifest load_source_manifest( const fs::path &root, const std::string &expected_id,
                                      bool allow_actions, bool required )
{
    const fs::path path = root / "manifest.json";
    if( !file_exist( path.string() ) ) {
        if( required ) {
            throw std::runtime_error( "Lua source '" + expected_id +
                                      "' is missing manifest.json" );
        }
        return default_script_manifest( expected_id, allow_actions );
    }
    script_manifest result = read_script_manifest( json_loader::from_path(
                                 cata_path( cata_path::root_path::unknown, path ) ) );
    if( result.id != expected_id ) {
        throw std::runtime_error( "Lua manifest at '" + path.string() + "' has id '" +
                                  result.id + "', expected '" + expected_id + "'" );
    }
    return result;
}

std::vector<script_source> active_script_sources()
{
    std::vector<script_source> sources;
    const fs::path built_in_root = fs::u8path( PATH_INFO::datadir() ) / "lua";
    sources.push_back( script_source{
        load_source_manifest( built_in_root, "builtin", true, true ), built_in_root,
        built_in_root / "main.lua"
    } );

    if( world_generator && world_generator->active_world != nullptr ) {
        for( const mod_id &mod : world_generator->active_world->active_mod_order ) {
            if( !mod.is_valid() ) {
                continue;
            }
            const fs::path root = mod->path.get_unrelative_path() / "lua";
            const fs::path entry = root / "main.lua";
            if( !file_exist( entry.string() ) ) {
                continue;
            }
            sources.push_back( script_source{
                load_source_manifest( root, mod.str(), false, false ), root, entry
            } );
        }
    }

    const fs::path user_root = fs::u8path( PATH_INFO::config_dir() ) / "lua";
    const fs::path user_entry = user_root / "main.lua";
    if( file_exist( user_entry.string() ) ) {
        sources.push_back( script_source{
            load_source_manifest( user_root, "user", true, false ), user_root, user_entry
        } );
    }

    std::vector<script_manifest> manifests;
    manifests.reserve( sources.size() );
    for( const script_source &source : sources ) {
        if( !file_exist( source.entry.string() ) ) {
            throw std::runtime_error( "Lua source '" + source.manifest.id +
                                      "' is missing main.lua" );
        }
        manifests.push_back( source.manifest );
    }
    validate_script_manifests( manifests );
    return sources;
}

std::vector<fs::path> module_roots( const std::vector<script_source> &sources )
{
    std::vector<fs::path> roots;
    roots.reserve( sources.size() );
    for( auto source = sources.rbegin(); source != sources.rend(); ++source ) {
        roots.push_back( source->root );
    }
    return roots;
}

cata_path persistent_state_path()
{
    return PATH_INFO::player_base_save_path() + ".lua_ui.json";
}

bool load_persistent_state_file( script_persistent_state &state, std::string &error )
{
    const cata_path path = persistent_state_path();
    if( !file_exist( path ) ) {
        state.clear();
        error.clear();
        return true;
    }

    try {
        std::error_code size_error;
        const std::uintmax_t size = fs::file_size( path.get_unrelative_path(), size_error );
        if( size_error ) {
            throw std::runtime_error( "unable to inspect file: " + size_error.message() );
        }
        if( size > persistent_state_max_file_bytes ) {
            throw std::runtime_error( "file exceeds 1 MiB" );
        }
        state = read_persistent_state( json_loader::from_path( path ) );
        error.clear();
        return true;
    } catch( const std::exception &exception ) {
        state.clear();
        error = path.get_unrelative_path().string() + ": " + exception.what();
        return false;
    }
}

page_definition *find_page( const std::string &id )
{
    if( !active_state ) {
        return nullptr;
    }
    const auto found = find_definition( active_state->pages, id );
    return found == active_state->pages.end() ? nullptr : &*found;
}

void disable_callback( bool &enabled, std::string &stored_error, const std::string &context,
                       const sol::protected_function_result &result )
{
    const sol::error error = result;
    enabled = false;
    stored_error = error.what();
    record_runtime_error( context, stored_error );
}

void draw_huds()
{
    if( !active_state ) {
        return;
    }
    std::unique_ptr<script_ui_renderer> renderer = make_imgui_script_ui_renderer();
    script_ui_context context( *renderer );
    const ImGuiViewport *viewport = ImGui::GetMainViewport();
    for( hud_definition &hud : active_state->huds ) {
        if( !hud.enabled ) {
            continue;
        }

        const bool right = hud.anchor == "top_right" || hud.anchor == "bottom_right";
        const bool bottom = hud.anchor == "bottom_left" || hud.anchor == "bottom_right";
        ImVec2 position( right ? viewport->WorkPos.x + viewport->WorkSize.x : viewport->WorkPos.x,
                         bottom ? viewport->WorkPos.y + viewport->WorkSize.y : viewport->WorkPos.y );
        position.x += right ? -hud.offset_x : hud.offset_x;
        position.y += bottom ? -hud.offset_y : hud.offset_y;
        ImGui::SetNextWindowPos( position, ImGuiCond_Always,
                                 ImVec2( right ? 1.0F : 0.0F, bottom ? 1.0F : 0.0F ) );
        ImGui::SetNextWindowBgAlpha( hud.alpha );

        ImGuiWindowFlags flags = ImGuiWindowFlags_NoSavedSettings | ImGuiWindowFlags_NoMove |
                                 ImGuiWindowFlags_AlwaysAutoResize | ImGuiWindowFlags_NoNav |
                                 ImGuiWindowFlags_NoFocusOnAppearing | ImGuiWindowFlags_NoCollapse |
                                 ImGuiWindowFlags_NoBringToFrontOnFocus;
        if( !hud.interactive ) {
            flags |= ImGuiWindowFlags_NoInputs;
        }
        if( !hud.background ) {
            flags |= ImGuiWindowFlags_NoBackground;
        }
        if( !hud.title_bar ) {
            flags |= ImGuiWindowFlags_NoTitleBar;
        }

        const std::string window_id = hud.title + "###lua_hud_" + hud.id;
        if( ImGui::Begin( window_id.c_str(), nullptr, flags ) ) {
            source_scope source( *active_state, hud.source_index );
            instruction_guard guard( active_state->lua.lua_state(), callback_instruction_limit );
            const auto started = std::chrono::steady_clock::now();
            const sol::protected_function_result result = hud.draw( &context );
            record_callback_timing( *active_state, "HUD '" + hud.id + "'", started );
            if( !result.valid() ) {
                disable_callback( hud.enabled, hud.error, "Lua HUD '" + hud.id + "'", result );
            }
        }
        ImGui::End();
    }
}

void ensure_hud_adaptor()
{
#if defined(__ANDROID__)
    // Android publishes retained widget trees from the game thread and renders
    // them as native Views.  Do not also draw the same HUD through ImGui.
    return;
#endif
    if( hud_adaptor ) {
        return;
    }
    hud_adaptor = std::make_unique<ui_adaptor>();
    hud_adaptor->is_imgui = true;
    hud_adaptor->position_absolute( point::zero, point::zero );
    hud_adaptor->on_redraw( []( ui_adaptor & ) {
        draw_huds();
    } );
}

sol::table event_to_lua( runtime_state &state, const cata::event &event )
{
    sol::table result = state.lua.create_table();
    sol::table data = state.lua.create_table();
    sol::table data_types = state.lua.create_table();
    result["type"] = io::enum_to_string( event.type() );
    result["turn"] = to_turn<int>( event.time() );
    for( const auto &[name, value] : event.data() ) {
        switch( value.type() ) {
            case cata_variant_type::bool_:
                data[name] = value.get<cata_variant_type::bool_>();
                break;
            case cata_variant_type::int_:
                data[name] = value.get<cata_variant_type::int_>();
                break;
            default:
                data[name] = value.get_string();
                break;
        }
        data_types[name] = io::enum_to_string( value.type() );
    }
    result["data"] = data;
    result["data_types"] = data_types;
    return result;
}

void runtime_state::notify( const cata::event &event )
{
    for( event_handler_definition &handler : event_handlers ) {
        if( !handler.enabled || handler.type != event.type() ) {
            continue;
        }
        sol::table payload = event_to_lua( *this, event );
        source_scope source( *this, handler.source_index );
        instruction_guard guard( lua.lua_state(), callback_instruction_limit );
        const auto started = std::chrono::steady_clock::now();
        const sol::protected_function_result result = handler.callback( payload );
        record_callback_timing( *this, "event '" + handler.name + "'", started );
        if( !result.valid() ) {
            disable_callback( handler.enabled, handler.error,
                              "Lua event handler '" + handler.name + "'", result );
        }
    }
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
                if( reload_scripts( error ) ) {
                    ::add_msg( _( "Lua UI scripts reloaded." ) );
                } else {
                    ::add_msg( m_bad, _( "Lua reload failed: %s" ), error );
                }
            }
            const runtime_status snapshot = status();
            ImGui::SameLine();
            ImGui::TextDisabled( "API %d | gen %zu | %.1f / %.1f MiB", api_version,
                                 snapshot.generation,
                                 static_cast<double>( snapshot.memory_used ) / ( 1024.0 * 1024.0 ),
                                 static_cast<double>( snapshot.memory_limit ) / ( 1024.0 * 1024.0 ) );
            ImGui::Separator();

            page_definition *page = find_page( page_id_ );
            if( page == nullptr ) {
                ImGui::TextWrapped( "%s", _( "This page is no longer registered." ) );
                return;
            }
            if( !page->enabled ) {
                ImGui::TextColored( ImVec4( 1.0F, 0.35F, 0.35F, 1.0F ), "%s",
                                    page->error.c_str() );
                return;
            }

            std::unique_ptr<script_ui_renderer> renderer = make_imgui_script_ui_renderer();
            script_ui_context context( *renderer );
            source_scope source( *active_state, page->source_index );
            instruction_guard guard( active_state->lua.lua_state(), callback_instruction_limit );
            const auto started = std::chrono::steady_clock::now();
            const sol::protected_function_result result = page->draw( &context );
            record_callback_timing( *active_state, "page '" + page->id + "'", started );
            if( !result.valid() ) {
                disable_callback( page->enabled, page->error, "Lua page '" + page->id + "'", result );
                ImGui::TextColored( ImVec4( 1.0F, 0.35F, 0.35F, 1.0F ), "%s",
                                    page->error.c_str() );
            }
        }

    private:
        std::string page_id_;
};

bool reload_scripts_with_state( const script_persistent_state *initial_state, std::string &error )
{
    try {
        auto next = std::make_unique<runtime_state>();
        if( active_state ) {
            next->persistent_state = active_state->persistent_state;
        } else if( initial_state != nullptr ) {
            next->persistent_state = *initial_state;
        }
        next->sources = active_script_sources();
        initialize_state( *next, module_roots( next->sources ) );

        for( std::size_t index = 0; index < next->sources.size(); ++index ) {
            run_script( *next, next->sources[index].entry, index );
        }

        next->generation = ++generation_counter;
        if( !next->event_handlers.empty() ) {
            get_event_bus().subscribe( next.get() );
        }
        active_state = std::move( next );
        active_state->accept_actions = true;
        {
            std::lock_guard<std::mutex> lock( android_state_mutex );
            android_interactions.clear();
            android_last_published_page.clear();
            android_last_publish = {};
        }
        last_runtime_error.clear();
        error.clear();
        return true;
    } catch( const std::exception &exception ) {
        error = exception.what();
        record_runtime_error( "Lua reload failed", error );
        return false;
    }
}

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
    return reload_scripts_with_state( nullptr, error );
}

void on_world_ready()
{
    // A save/new-game transition is a runtime boundary, unlike an in-page hot
    // reload.  Never retain callbacks or state belonging to the previous world.
    active_state.reset();
    script_persistent_state saved_state;
    std::string state_error;
    load_persistent_state_file( saved_state, state_error );

    std::string script_error;
    if( !reload_scripts_with_state( &saved_state, script_error ) ) {
        ::add_msg( m_bad, _( "Lua initialization failed: %s" ), script_error );
    } else if( !state_error.empty() ) {
        record_runtime_error( "Lua state load failed", state_error );
        ::add_msg( m_warning, _( "Lua state could not be loaded; using defaults: %s" ), state_error );
    }
    ensure_hud_adaptor();
}

bool save_persistent_state( std::string &error )
{
    if( !active_state ) {
        error.clear();
        return true;
    }
    const cata_path path = persistent_state_path();
    try {
        if( !write_to_file( path, [&]( std::ostream & output ) {
        write_persistent_state( output, active_state->persistent_state );
        }, _( "Lua UI state" ) ) ) {
            throw std::runtime_error( "unable to write file" );
        }
        error.clear();
        return true;
    } catch( const std::exception &exception ) {
        error = path.get_unrelative_path().string() + ": " + exception.what();
        record_runtime_error( "Lua state save failed", error );
        return false;
    }
}

runtime_status status()
{
    runtime_status result;
    result.loaded = active_state != nullptr;
    result.last_error = last_runtime_error;
    if( active_state ) {
        result.generation = active_state->generation;
        result.page_count = active_state->pages.size();
        result.hud_count = active_state->huds.size();
        result.event_handler_count = active_state->event_handlers.size();
        result.source_count = active_state->sources.size();
        result.memory_used = active_state->memory.used;
        result.memory_limit = active_state->memory.limit;
        result.callback_count = active_state->callback_count;
        result.callback_time_total_us = active_state->callback_time_total_us;
        result.callback_time_max_us = active_state->callback_time_max_us;
        result.slow_callback_count = active_state->slow_callback_count;
        result.last_slow_callback = active_state->last_slow_callback;
    }
    return result;
}

bool validate_snippet( std::string_view source, int instruction_limit, std::string &error )
{
    try {
        memory_tracker memory;
        sol::state lua( sol::default_at_panic, limited_allocator, &memory );
        lua.open_libraries( sol::lib::base, sol::lib::math, sol::lib::string, sol::lib::table );
        lua["dofile"] = sol::nil;
        lua["load"] = sol::nil;
        lua["loadfile"] = sol::nil;
        lua["loadstring"] = sol::nil;
        lua["collectgarbage"] = sol::nil;
        const sol::load_result loaded = lua.load( std::string( source ), "validation snippet" );
        if( !loaded.valid() ) {
            const sol::error load_error = loaded;
            throw std::runtime_error( load_error.what() );
        }
        sol::protected_function function = loaded;
        instruction_guard guard( lua.lua_state(), instruction_limit );
        const sol::protected_function_result result = function();
        if( !result.valid() ) {
            const sol::error runtime_error = result;
            throw std::runtime_error( runtime_error.what() );
        }
        error.clear();
        return true;
    } catch( const std::exception &exception ) {
        error = exception.what();
        return false;
    }
}

bool submit_android_interaction( const std::string &widget_id,
                                 const std::string &encoded_value )
{
    if( widget_id.empty() || widget_id.size() > 512 || encoded_value.size() > 65536 ) {
        return false;
    }
    const bool valid_value = encoded_value == "click" || encoded_value.rfind( "bool:", 0 ) == 0 ||
                             encoded_value.rfind( "int:", 0 ) == 0 ||
                             encoded_value.rfind( "number:", 0 ) == 0 ||
                             encoded_value.rfind( "text:", 0 ) == 0;
    if( !valid_value ) {
        return false;
    }
    std::lock_guard<std::mutex> lock( android_state_mutex );
    if( android_interactions.size() >= 256 && android_interactions.count( widget_id ) == 0 ) {
        return false;
    }
    android_interactions[widget_id] = encoded_value;
    return true;
}

bool select_android_page( const std::string &page_id )
{
    if( page_id.size() > 256 ) {
        return false;
    }
    std::lock_guard<std::mutex> lock( android_state_mutex );
    android_selected_page = page_id;
    return true;
}

std::string android_snapshot_json()
{
    std::lock_guard<std::mutex> lock( android_state_mutex );
    return android_published_snapshot;
}

void publish_android_snapshot()
{
    std::string selected_page;
    bool has_interactions = false;
    {
        std::lock_guard<std::mutex> lock( android_state_mutex );
        selected_page = android_selected_page;
        has_interactions = !android_interactions.empty();
    }
    const auto now = std::chrono::steady_clock::now();
    if( !has_interactions && selected_page == android_last_published_page &&
        android_last_publish.time_since_epoch().count() != 0 &&
        std::chrono::duration_cast<std::chrono::milliseconds>( now - android_last_publish ).count() <
        50 ) {
        return;
    }
    if( !active_state ) {
        std::lock_guard<std::mutex> lock( android_state_mutex );
        android_published_snapshot =
            R"({"schema":1,"generation":0,"selectedPage":"","surfaces":[]})";
        return;
    }

    const retained_interaction_reader interactions = []( const std::string & id )
    -> std::optional<std::string> {
        std::lock_guard<std::mutex> lock( android_state_mutex );
        const auto found = android_interactions.find( id );
        if( found == android_interactions.end() )
        {
            return std::nullopt;
        }
        std::string value = std::move( found->second );
        android_interactions.erase( found );
        return value;
    };

    std::vector<retained_ui_surface> surfaces;
    surfaces.reserve( active_state->huds.size() + active_state->pages.size() );
    for( hud_definition &hud : active_state->huds ) {
        retained_ui_surface surface;
        surface.id = "hud:" + hud.id;
        surface.title = hud.title;
        surface.kind = "hud";
        surface.anchor = hud.anchor;
        surface.offset_x = hud.offset_x;
        surface.offset_y = hud.offset_y;
        surface.alpha = hud.alpha;
        surface.default_width = hud.default_width;
        surface.default_height = hud.default_height;
        surface.interactive = hud.interactive;
        surface.movable = hud.movable;
        surface.scalable = hud.scalable;
        surface.user_toggleable = hud.user_toggleable;
        if( hud.enabled ) {
            std::unique_ptr<script_ui_renderer> renderer = make_retained_script_ui_renderer(
                        surface.document, surface.id + "/", interactions );
            script_ui_context context( *renderer );
            source_scope source( *active_state, hud.source_index );
            instruction_guard guard( active_state->lua.lua_state(), callback_instruction_limit );
            const auto started = std::chrono::steady_clock::now();
            const sol::protected_function_result result = hud.draw( &context );
            record_callback_timing( *active_state, "Android HUD '" + hud.id + "'", started );
            if( !result.valid() ) {
                disable_callback( hud.enabled, hud.error, "Lua HUD '" + hud.id + "'", result );
            }
        }
        surfaces.push_back( std::move( surface ) );
    }

    bool selected_found = selected_page.empty();
    for( page_definition &page : active_state->pages ) {
        retained_ui_surface surface;
        surface.id = "page:" + page.id;
        surface.title = page.title;
        surface.kind = "page";
        surface.anchor = "center";
        surface.interactive = true;
        if( page.id == selected_page ) {
            selected_found = true;
            if( page.enabled ) {
                std::unique_ptr<script_ui_renderer> renderer = make_retained_script_ui_renderer(
                            surface.document, surface.id + "/", interactions );
                script_ui_context context( *renderer );
                source_scope source( *active_state, page.source_index );
                instruction_guard guard( active_state->lua.lua_state(), callback_instruction_limit );
                const auto started = std::chrono::steady_clock::now();
                const sol::protected_function_result result = page.draw( &context );
                record_callback_timing( *active_state, "Android page '" + page.id + "'", started );
                if( !result.valid() ) {
                    disable_callback( page.enabled, page.error, "Lua page '" + page.id + "'", result );
                }
            }
        }
        surfaces.push_back( std::move( surface ) );
    }
    if( !selected_found ) {
        selected_page.clear();
        std::lock_guard<std::mutex> lock( android_state_mutex );
        android_selected_page.clear();
    }

    const std::string snapshot = retained_surfaces_json( surfaces, active_state->generation,
                                 selected_page );
    std::lock_guard<std::mutex> lock( android_state_mutex );
    android_published_snapshot = snapshot;
    android_last_published_page = selected_page;
    android_last_publish = now;
}

void shutdown()
{
    hud_adaptor.reset();
    active_state.reset();
    clear_actions();
    {
        std::lock_guard<std::mutex> lock( android_state_mutex );
        android_interactions.clear();
        android_selected_page.clear();
        android_last_published_page.clear();
        android_last_publish = {};
        android_published_snapshot =
            R"({"schema":1,"generation":0,"selectedPage":"","surfaces":[]})";
    }
    last_runtime_error.clear();
}

void show()
{
    std::string error;
    if( !reload_scripts( error ) ) {
        popup( _( "Unable to load Lua UI scripts:\n%s" ), error );
        return;
    }
    ensure_hud_adaptor();
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
