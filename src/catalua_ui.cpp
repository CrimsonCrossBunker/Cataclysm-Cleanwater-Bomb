#include "catalua_ui.h"

#include <algorithm>
#include <cctype>
#include <chrono>
#include <cstdlib>
#include <filesystem>
#include <memory>
#include <optional>
#include <stdexcept>
#include <string>
#include <utility>
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
#include "catalua_ui_i18n.h"
#include "catalua_ui_imgui.h"
#include "catalua_ui_manifest.h"
#include "catalua_ui_navigation.h"
#include "catalua_ui_navigation_internal.h"
#include "catalua_ui_renderer.h"
#include "catalua_ui_state.h"
#include "debug.h"
#include "enum_conversions.h"
#include "event.h"
#include "event_bus.h"
#include "event_subscriber.h"
#include "filesystem.h"
#include "imgui/imgui.h"
#include "input_context.h"
#include "input_context_actions.h"
#include "json_loader.h"
#include "messages.h"
#include "mod_manager.h"
#include "output.h"
#include "path_info.h"
#include "point.h"
#include "translations.h"
#include "ui_profile.h"
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
constexpr std::size_t maximum_page_stack_depth = 32;

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
    std::string category = "general";
    std::vector<std::string> slots = { "main.extensions", "ingame.extensions" };
    int order = 100;
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
    bool interactive = false;
    bool background = true;
    bool title_bar = false;
    std::vector<std::string> contexts;
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
        script_persistent_state world_state;
        script_persistent_state page_state;
        sol::state lua;
        std::vector<fs::path> module_roots;
        std::vector<script_source> sources;
        std::vector<page_definition> pages;
        std::vector<hud_definition> huds;
        std::vector<event_handler_definition> event_handlers;
        std::size_t generation = 0;
        bool accept_actions = false;
        std::optional<std::size_t> current_source;
        std::optional<std::string> current_page;
        std::uint64_t callback_count = 0;
        std::uint64_t callback_time_total_us = 0;
        std::uint64_t callback_time_max_us = 0;
        std::uint64_t slow_callback_count = 0;
        std::string last_slow_callback;
};

std::unique_ptr<runtime_state> active_state;
std::unique_ptr<ui_adaptor> hud_adaptor;
bool world_ready_for_huds = false;
std::string last_runtime_error;
std::size_t generation_counter = 0;

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

class page_scope
{
    public:
        page_scope( runtime_state &state, std::string page_id ) :
            state_( state ), previous_( state.current_page ) {
            state_.current_page = std::move( page_id );
        }

        page_scope( const page_scope & ) = delete;
        page_scope &operator=( const page_scope & ) = delete;

        ~page_scope() {
            state_.current_page = previous_;
        }

    private:
        runtime_state &state_;
        std::optional<std::string> previous_;
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

bool valid_page_slot( const std::string &slot )
{
    static const std::array<std::string_view, 4> slots = {
        "main.extensions", "ingame.extensions", "settings.mods", "debug.tools"
    };
    return std::find( slots.begin(), slots.end(), slot ) != slots.end();
}

void register_page( runtime_state &state, const std::string &id, const sol::object &descriptor,
                    sol::protected_function draw )
{
    require_capability( state, "ui.pages" );
    if( id.empty() || id.size() > 128 ) {
        throw std::runtime_error( "ui.page id must contain 1 to 128 bytes" );
    }
    if( !draw.valid() ) {
        throw std::runtime_error( "ui.page requires a draw function" );
    }

    page_definition replacement;
    replacement.id = id;
    replacement.title = id;
    replacement.draw = std::move( draw );
    replacement.source_index = *state.current_source;
    if( descriptor.get_type() == sol::type::string ) {
        replacement.title = descriptor.as<std::string>();
    } else if( descriptor.get_type() == sol::type::table ) {
        const sol::table options = descriptor.as<sol::table>();
        replacement.title = options.get_or( "title", id );
        replacement.category = options.get_or( "category", std::string( "general" ) );
        replacement.order = options.get_or( "order", 100 );
        replacement.order = std::clamp( replacement.order, -10000, 10000 );
        const sol::object raw_slots = options["slots"];
        if( raw_slots.valid() && raw_slots.get_type() != sol::type::nil ) {
            if( raw_slots.get_type() != sol::type::table ) {
                throw std::runtime_error( "ui.page slots must be an array of strings" );
            }
            replacement.slots.clear();
            const sol::table slots = raw_slots.as<sol::table>();
            for( std::size_t index = 1; index <= slots.size(); ++index ) {
                const sol::object raw_slot = slots[index];
                if( !raw_slot.valid() || raw_slot.get_type() != sol::type::string ) {
                    throw std::runtime_error( "ui.page slots must be an array of strings" );
                }
                const std::string slot = raw_slot.as<std::string>();
                if( !valid_page_slot( slot ) ) {
                    throw std::runtime_error( "ui.page has an unknown navigation slot: " + slot );
                }
                if( std::find( replacement.slots.begin(), replacement.slots.end(), slot ) ==
                    replacement.slots.end() ) {
                    replacement.slots.push_back( slot );
                }
            }
            if( replacement.slots.empty() ) {
                throw std::runtime_error( "ui.page requires at least one navigation slot" );
            }
        }
    } else {
        throw std::runtime_error( "ui.page second argument must be a title or descriptor table" );
    }
    if( replacement.title.empty() ) {
        replacement.title = id;
    }
    if( replacement.category.empty() || replacement.category.size() > 128 ) {
        throw std::runtime_error( "ui.page category must contain 1 to 128 bytes" );
    }
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
    replacement.anchor = options.get_or( "anchor", std::string( "top_left" ) );
    replacement.offset_x = static_cast<float>( options.get_or( "x", 12.0 ) );
    replacement.offset_y = static_cast<float>( options.get_or( "y", 12.0 ) );
    replacement.alpha = static_cast<float>( std::clamp( options.get_or( "alpha", 0.8 ), 0.0, 1.0 ) );
    replacement.interactive = options.get_or( "interactive", false );
    replacement.background = options.get_or( "background", true );
    replacement.title_bar = options.get_or( "title_bar", false );
    const sol::object raw_contexts = options["contexts"];
    if( raw_contexts.valid() && raw_contexts.get_type() != sol::type::nil ) {
        if( raw_contexts.get_type() != sol::type::table ) {
            throw std::runtime_error( "ui.hud contexts must be an array of strings" );
        }
        const sol::table contexts = raw_contexts.as<sol::table>();
        if( contexts.size() > 32 ) {
            throw std::runtime_error( "ui.hud accepts at most 32 input contexts" );
        }
        for( std::size_t index = 1; index <= contexts.size(); ++index ) {
            const sol::object raw_context = contexts[index];
            if( !raw_context.valid() || raw_context.get_type() != sol::type::string ) {
                throw std::runtime_error( "ui.hud contexts must be an array of strings" );
            }
            const std::string context = raw_context.as<std::string>();
            if( context.empty() || context.size() > 128 ) {
                throw std::runtime_error( "ui.hud context ids must contain 1 to 128 bytes" );
            }
            if( std::find( replacement.contexts.begin(), replacement.contexts.end(), context ) ==
                replacement.contexts.end() ) {
                replacement.contexts.push_back( context );
            }
        }
    }
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

sol::object typed_state_get( const script_persistent_state &store,
                             sol::this_state lua, const std::string &key,
                             const sol::object &default_value )
{
    const auto found = store.find( key );
    if( found == store.end() ) {
        return default_value;
    }
    return std::visit( [lua]( const auto & value ) {
        return sol::make_object( lua, value );
    }, found->second );
}

void typed_state_set( script_persistent_state &store, const std::string &key,
                      const sol::object &value, const std::string &api_name )
{
    if( key.empty() ) {
        throw std::runtime_error( api_name + " requires a non-empty key" );
    }
    switch( value.get_type() ) {
        case sol::type::boolean:
            assign_persistent_value( store, key, value.as<bool>() );
            break;
        case sol::type::number:
            if( value.is<lua_Integer>() ) {
                assign_persistent_value( store, key,
                                         static_cast<std::int64_t>( value.as<lua_Integer>() ) );
            } else {
                assign_persistent_value( store, key, value.as<double>() );
            }
            break;
        case sol::type::string:
            assign_persistent_value( store, key, value.as<std::string>() );
            break;
        case sol::type::nil:
            store.erase( key );
            break;
        default:
            throw std::runtime_error(
                api_name + " only accepts boolean, number, string, or nil" );
    }
}

sol::object persistent_get( const runtime_state &runtime, sol::this_state lua,
                            const std::string &key,
                            const sol::object &default_value )
{
    require_capability( runtime, "state.character" );
    return typed_state_get( runtime.persistent_state, lua, key, default_value );
}

void persistent_set( runtime_state &runtime, const std::string &key,
                     const sol::object &value )
{
    require_capability( runtime, "state.character" );
    typed_state_set( runtime.persistent_state, key, value, "game.state_set" );
}

std::string scoped_state_key( const runtime_state &runtime,
                              const std::string &scope,
                              const std::string &key )
{
    if( key.empty() || key.size() > 128 ) {
        throw std::invalid_argument(
            "state keys must contain 1 to 128 bytes" );
    }
    const script_manifest &manifest = current_manifest( runtime );
    std::string result = "v3:" + scope + ":" +
                         std::to_string( manifest.id.size() ) + ":" +
                         manifest.id + ":";
    if( scope == "page" ) {
        if( !runtime.current_page ) {
            throw std::runtime_error(
                "state.page is only available while drawing a page" );
        }
        result += std::to_string( runtime.current_page->size() ) + ":" +
                  *runtime.current_page + ":";
    }
    result += key;
    if( result.size() > persistent_state_max_key_bytes ) {
        throw std::invalid_argument(
            "namespaced state key exceeds the 256 byte storage limit" );
    }
    return result;
}

sol::object scoped_state_get( const runtime_state &runtime,
                              const script_persistent_state &store,
                              sol::this_state lua, const std::string &scope,
                              const std::string &key,
                              const sol::object &default_value )
{
    return typed_state_get( store, lua,
                            scoped_state_key( runtime, scope, key ),
                            default_value );
}

void scoped_state_set( runtime_state &runtime, script_persistent_state &store,
                       const std::string &scope, const std::string &key,
                       const sol::object &value )
{
    typed_state_set( store, scoped_state_key( runtime, scope, key ), value,
                     "state." + scope + ".set" );
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

std::string lua_radial_select( script_ui_context &context, const std::string &id,
                               const std::string &center_label, const sol::table &lua_options )
{
    const std::size_t count = lua_options.size();
    if( count == 0 || count > 8 ) {
        throw std::invalid_argument( "ctx:radial_select_id requires 1..8 options" );
    }
    std::vector<script_ui_radial_option> options;
    options.reserve( count );
    for( std::size_t index = 1; index <= count; ++index ) {
        const sol::object raw_option = lua_options[index];
        if( !raw_option.valid() || raw_option.get_type() != sol::type::table ) {
            throw std::invalid_argument( "ctx:radial_select_id options must be an array of tables" );
        }
        const sol::table option = raw_option.as<sol::table>();
        const sol::object raw_id = option["id"];
        const sol::object raw_label = option["label"];
        if( !raw_id.valid() || raw_id.get_type() != sol::type::string ||
            !raw_label.valid() || raw_label.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "ctx:radial_select_id options require string id and label fields" );
        }
        options.push_back( script_ui_radial_option{
            raw_id.as<std::string>(), raw_label.as<std::string>(),
            option.get_or( "enabled", true ), option.get_or( "selected", false )
        } );
    }
    return context.radial_select_id( id, center_label, options );
}

std::string lua_action_slot( runtime_state &state, script_ui_context &context,
                             const std::string &id, const std::string &selected_action,
                             const int context_revision, const sol::table &lua_options )
{
    require_capability( state, "game.actions" );
    const std::size_t count = lua_options.size();
    if( count > 16 ) {
        throw std::invalid_argument( "ctx:action_slot_id accepts at most 16 options" );
    }

    std::vector<script_ui_action_option> options;
    options.reserve( count );
    std::vector<std::string> action_ids;
    action_ids.reserve( count );
    for( std::size_t index = 1; index <= count; ++index ) {
        const sol::object raw_option = lua_options[index];
        if( !raw_option.valid() || raw_option.get_type() != sol::type::table ) {
            throw std::invalid_argument(
                "ctx:action_slot_id options must be an array of tables" );
        }
        const sol::table option = raw_option.as<sol::table>();
        const sol::object raw_id = option["id"];
        const sol::object raw_label = option["label"];
        if( !raw_id.valid() || raw_id.get_type() != sol::type::string ||
            !raw_label.valid() || raw_label.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "ctx:action_slot_id options require string id and label fields" );
        }
        const std::string action_id = raw_id.as<std::string>();
        options.push_back( {
            action_id,
            raw_label.as<std::string>(),
            option.get_or( "enabled", true )
        } );
        action_ids.push_back( action_id );
    }
    const std::vector<bool> allowed =
        cata::input_context_actions::validate_candidates( context_revision, action_ids );
    for( std::size_t index = 0; index < options.size(); ++index ) {
        options[index].enabled = options[index].enabled && allowed[index];
    }
    return context.action_slot_id( id, selected_action, context_revision, options );
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

    state.lua.new_usertype<script_ui_environment>(
        "ScriptUiEnvironment", sol::no_constructor,
        "profile", &script_ui_environment::profile,
        "input", &script_ui_environment::input,
        "density", &script_ui_environment::density,
        "breakpoint", &script_ui_environment::breakpoint,
        "minimum_target", &script_ui_environment::minimum_target,
        "touch", &script_ui_environment::touch,
        "hover", &script_ui_environment::hover,
        "swipe_scroll", &script_ui_environment::swipe_scroll,
        "native_text_input", &script_ui_environment::native_text_input,
        "keyboard_navigation", &script_ui_environment::keyboard_navigation,
        "pointer_activation", &script_ui_environment::pointer_activation,
        "tap_activation", &script_ui_environment::tap_activation,
        "long_press_dangerous", &script_ui_environment::long_press_dangerous );

    state.lua.new_usertype<script_ui_context>(
        "ScriptUiContext", sol::no_constructor,
        "backend", &script_ui_context::backend,
        "platform", &script_ui_context::platform,
        "supports", &script_ui_context::supports,
        "is_immediate_mode", &script_ui_context::is_immediate_mode,
        "uses_native_widgets", &script_ui_context::uses_native_widgets,
        "environment", &script_ui_context::environment,
        "text", &script_ui_context::text,
        "heading", &script_ui_context::heading,
        "bullet_text", &script_ui_context::bullet_text,
        "disabled_text", &script_ui_context::disabled_text,
        "text_colored", &script_ui_context::text_colored,
        "text_tone", &script_ui_context::text_tone,
        "separator", &script_ui_context::separator,
        "same_line", &script_ui_context::same_line,
        "new_line", &script_ui_context::new_line,
        "spacing", &script_ui_context::spacing,
        "set_next_item_width", &script_ui_context::set_next_item_width,
        "item_width", &script_ui_context::item_width,
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
        "radial_select_id", &lua_radial_select,
        "action_slot_id", [&state]( script_ui_context & context, const std::string & id,
                                    const std::string & selected_action,
    int context_revision, const sol::table & options ) {
        return lua_action_slot(
                   state, context, id, selected_action, context_revision, options );
    },
    "child", &script_ui_context::child,
    "scroll", &script_ui_context::scroll,
    "table", &script_ui_context::table,
    "grid", &script_ui_context::grid,
    "table_next_row", &script_ui_context::table_next_row,
    "table_next_column", &script_ui_context::table_next_column,
    "tabs", &script_ui_context::tabs,
    "tab", &script_ui_context::tab,
    "tree", &script_ui_context::tree,
    "modal", &script_ui_context::modal,
    "tooltip", &script_ui_context::tooltip,
    "virtual_list", &script_ui_context::virtual_list,
    "virtual_list_rows", &script_ui_context::virtual_list_rows );

    sol::table ui = state.lua.create_named_table( "ui" );
    ui.set_function( "page", [&state]( const std::string & id, const sol::object & descriptor,
    sol::protected_function draw ) {
        register_page( state, id, descriptor, std::move( draw ) );
    } );
    ui.set_function( "hud", [&state]( const std::string & id, const sol::table & options,
    sol::protected_function draw ) {
        register_hud( state, id, options, std::move( draw ) );
    } );
    install_navigation_api(
        ui,
    [&state]() {
        require_capability( state, "ui.pages" );
    },
    [&state]() {
        return state.accept_actions && state.current_source.has_value();
    },
    [&state]( const std::string & page_id ) {
        return find_definition( state.pages, page_id ) != state.pages.end();
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
    install_i18n_api( state.lua );

    sol::table state_api = state.lua.create_named_table( "state" );
    sol::table character_state = state.lua.create_table();
    character_state.set_function(
        "get",
        [&state]( sol::this_state lua, const std::string & key,
    const sol::object & default_value ) {
        require_capability( state, "state.character" );
        return scoped_state_get( state, state.persistent_state, lua,
                                 "character", key, default_value );
    } );
    character_state.set_function(
        "set",
    [&state]( const std::string & key, const sol::object & value ) {
        require_capability( state, "state.character" );
        scoped_state_set( state, state.persistent_state,
                          "character", key, value );
    } );
    state_api["character"] = std::move( character_state );

    sol::table world_state = state.lua.create_table();
    world_state.set_function(
        "get",
        [&state]( sol::this_state lua, const std::string & key,
    const sol::object & default_value ) {
        require_capability( state, "state.world" );
        return scoped_state_get( state, state.world_state, lua,
                                 "world", key, default_value );
    } );
    world_state.set_function(
        "set",
    [&state]( const std::string & key, const sol::object & value ) {
        require_capability( state, "state.world" );
        scoped_state_set( state, state.world_state,
                          "world", key, value );
    } );
    state_api["world"] = std::move( world_state );

    sol::table page_state = state.lua.create_table();
    page_state.set_function(
        "get",
        [&state]( sol::this_state lua, const std::string & key,
    const sol::object & default_value ) {
        require_capability( state, "state.page" );
        return scoped_state_get( state, state.page_state, lua,
                                 "page", key, default_value );
    } );
    page_state.set_function(
        "set",
    [&state]( const std::string & key, const sol::object & value ) {
        require_capability( state, "state.page" );
        scoped_state_set( state, state.page_state,
                          "page", key, value );
    } );
    state_api["page"] = std::move( page_state );

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

std::optional<cata_path> world_state_path()
{
    if( !world_generator || world_generator->active_world == nullptr ) {
        return std::nullopt;
    }
    return world_generator->active_world->folder_path() / "lua_ui_world.json";
}

bool load_state_file( const cata_path &path, script_persistent_state &state,
                      std::string &error )
{
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

bool write_state_file( const cata_path &path,
                       const script_persistent_state &state,
                       std::string &error )
{
    try {
        write_to_file( path, [&]( std::ostream & output ) {
            write_persistent_state( output, state );
        } );
        error.clear();
        return true;
    } catch( const std::exception &exception ) {
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

class ui_profile_style_guard
{
    public:
        explicit ui_profile_style_guard( const cata::ui::profile &profile ) :
            scaled_font_( profile.text_scale != 1.0F ) {
            if( scaled_font_ ) {
                cataimgui::PushGuiFontScaled( profile.text_scale );
            }
            const float frame_padding_y = profile.is_touch() ?
                                          std::max(
                                              profile.frame_padding_y,
                                              ( profile.minimum_target -
                                                ImGui::GetTextLineHeight() ) * 0.5F ) :
                                          profile.frame_padding_y;
            ImGui::PushStyleVar( ImGuiStyleVar_FrameRounding, profile.corner_radius );
            ImGui::PushStyleVar(
                ImGuiStyleVar_FramePadding,
                ImVec2( profile.frame_padding_x, frame_padding_y ) );
            ImGui::PushStyleVar(
                ImGuiStyleVar_ItemSpacing,
                ImVec2( profile.item_spacing_x, profile.item_spacing_y ) );
        }

        ui_profile_style_guard( const ui_profile_style_guard & ) = delete;
        ui_profile_style_guard &operator=( const ui_profile_style_guard & ) = delete;

        ~ui_profile_style_guard() {
            ImGui::PopStyleVar( 3 );
            if( scaled_font_ ) {
                cataimgui::PopGuiFontScaled();
            }
        }

    private:
        bool scaled_font_;
};

void draw_huds()
{
    if( !active_state ) {
        return;
    }
    std::unique_ptr<script_ui_renderer> renderer = make_imgui_script_ui_renderer();
    script_ui_context context( *renderer );
    const ImGuiViewport *viewport = ImGui::GetMainViewport();
    const std::string active_context =
        cata::input_context_actions::snapshot().category;
    for( hud_definition &hud : active_state->huds ) {
        if( !hud.enabled ||
            ( !hud.contexts.empty() &&
              std::find( hud.contexts.begin(), hud.contexts.end(), active_context ) ==
              hud.contexts.end() ) ) {
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

bool has_enabled_hud()
{
    return active_state && std::any_of(
               active_state->huds.begin(), active_state->huds.end(),
    []( const hud_definition & hud ) {
        return hud.enabled;
    } );
}

void sync_hud_adaptor()
{
#if defined(__ANDROID__)
    // Android HUD schema 6 is the only in-game HUD on this platform.  Lua
    // ui.hud registrations remain portable mod data but are not consumed here.
    hud_adaptor.reset();
    return;
#endif
    const bool should_render = world_ready_for_huds && has_enabled_hud();
    if( !should_render ) {
        hud_adaptor.reset();
        return;
    }
    if( !hud_adaptor ) {
        hud_adaptor = std::make_unique<ui_adaptor>();
        hud_adaptor->position_absolute( point::zero, point::zero );
        hud_adaptor->on_redraw( []( ui_adaptor & adaptor ) {
            draw_huds();
            // A callback failure disables that HUD.  If it was the final
            // enabled HUD, stop driving idle ImGui frames immediately without
            // destroying the adaptor from inside its own redraw callback.
            adaptor.is_imgui = has_enabled_hud();
        } );
    }
    hud_adaptor->is_imgui = true;
    hud_adaptor->invalidate_ui();
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

struct page_stack_entry {
    std::string page_id;
    navigation_parameters parameters;
};

sol::table parameters_to_lua( runtime_state &state,
                              const navigation_parameters &parameters )
{
    sol::table result = state.lua.create_table();
    for( const auto &parameter : parameters ) {
        const std::string &key = parameter.first;
        const script_persistent_value &value = parameter.second;
        std::visit( [&result, &key]( const auto & entry ) {
            result[key] = entry;
        }, value );
    }
    return result;
}

bool consume_navigation_requests( std::vector<page_stack_entry> &stack,
                                  const std::size_t minimum_depth )
{
    bool close_requested = false;
    while( const std::optional<navigation_request> request =
               take_navigation_request() ) {
        switch( request->type ) {
            case navigation_request_type::open_page:
                if( find_page( request->page_id ) == nullptr ) {
                    ::add_msg( m_bad, _( "Lua page is no longer registered: %s" ),
                               request->page_id );
                } else if( stack.size() >= maximum_page_stack_depth ) {
                    ::add_msg( m_warning,
                               _( "Lua page navigation reached its maximum depth." ) );
                } else {
                    stack.push_back( { request->page_id, request->parameters } );
                }
                break;
            case navigation_request_type::back:
                if( stack.size() > minimum_depth ) {
                    stack.pop_back();
                } else {
                    close_requested = true;
                }
                break;
            case navigation_request_type::close:
                close_requested = true;
                break;
        }
    }
    return close_requested;
}

int page_host_poll_timeout()
{
    // Mouse/touch events wake the input wait immediately.  This timeout only
    // provides an animation/redraw heartbeat and is intentionally slower than
    // the old 5 ms busy loop.
    return cata::ui::current_profile().is_touch() ? 16 : 33;
}

template<typename Draw>
void draw_scrollable_child( const char *id, const ImVec2 size,
                            const ImGuiChildFlags child_flags,
                            const bool always_show_scrollbar, Draw &&draw )
{
    if( ImGui::BeginChild( id, size, child_flags,
                           always_show_scrollbar ?
                           ImGuiWindowFlags_AlwaysVerticalScrollbar :
                           ImGuiWindowFlags_None ) ) {
        const cata::ui::profile profile = cata::ui::current_profile();
        const bool suppress_interaction = cataimgui::handle_vertical_swipe(
                                              profile.allow_swipe,
                                              profile.frame_padding_x );
        const cataimgui::scoped_interaction_suppression suppression(
            suppress_interaction );
        draw();
    }
    ImGui::EndChild();
}

void draw_registered_page( const std::string &page_id,
                           const navigation_parameters &parameters = {} )
{
    page_definition *page = find_page( page_id );
    if( page == nullptr ) {
        ImGui::TextWrapped( "%s", _( "This page is no longer registered." ) );
        return;
    }
    if( !page->enabled ) {
        ImGui::TextColored( ImVec4( 1.0F, 0.35F, 0.35F, 1.0F ), "%s", page->error.c_str() );
        return;
    }

    std::unique_ptr<script_ui_renderer> renderer = make_imgui_script_ui_renderer();
    script_ui_context context( *renderer );
    source_scope source( *active_state, page->source_index );
    page_scope current_page( *active_state, page->id );
    instruction_guard guard( active_state->lua.lua_state(), callback_instruction_limit );
    const auto started = std::chrono::steady_clock::now();
    const sol::protected_function_result result =
        page->draw( &context, parameters_to_lua( *active_state, parameters ) );
    record_callback_timing( *active_state, "page '" + page->id + "'", started );
    if( !result.valid() ) {
        disable_callback( page->enabled, page->error, "Lua page '" + page->id + "'", result );
        ImGui::TextColored( ImVec4( 1.0F, 0.35F, 0.35F, 1.0F ), "%s", page->error.c_str() );
    }
}

class lua_page_window : public cataimgui::window
{
    public:
        lua_page_window( std::string page_id, const std::string &title,
                         navigation_parameters parameters = {} ) :
            cataimgui::window( title ) {
            stack_.push_back( { std::move( page_id ), std::move( parameters ) } );
        }

        void run() {
            input_context context( "HELP_KEYBINDINGS" );
            context.register_action( "QUIT" );
            context.register_action( "ANY_INPUT" );
            context.register_action( "HELP_KEYBINDINGS" );

            ui_manager::redraw();
            while( get_is_open() ) {
                ui_manager::redraw();
                if( consume_navigation_requests( stack_, 1 ) ) {
                    break;
                }
                if( context.handle_input( page_host_poll_timeout() ) == "QUIT" ) {
                    if( stack_.size() > 1 ) {
                        stack_.pop_back();
                    } else {
                        break;
                    }
                }
            }
        }

    protected:
        cataimgui::bounds get_bounds() override {
            const cata::ui::profile profile = cata::ui::current_profile();
            return { -1.0F, -1.0F, profile.page_width, profile.page_height };
        }

        void draw_controls() override {
            const cata::ui::profile profile = cata::ui::current_profile();
            const ui_profile_style_guard style( profile );
            const bool has_back = stack_.size() > 1;
            if( has_back &&
                ImGui::Button( _( "Back" ),
                               ImVec2( 0.0F, profile.minimum_target ) ) ) {
                stack_.pop_back();
            }
            if( has_back ) {
                ImGui::SameLine();
            }
            if( ImGui::Button( _( "Reload Lua" ),
                               ImVec2( 0.0F, profile.minimum_target ) ) ) {
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

            if( !stack_.empty() ) {
                draw_scrollable_child(
                    "##lua_page_content", ImVec2( 0.0F, 0.0F ),
                ImGuiChildFlags_None, true, [this]() {
                    draw_registered_page( stack_.back().page_id,
                                          stack_.back().parameters );
                } );
            }
        }

    private:
        std::vector<page_stack_entry> stack_;
};

class lua_page_hub_window : public cataimgui::window
{
    public:
        lua_page_hub_window( std::string slot, std::vector<page_info> pages ) :
            cataimgui::window( "Lua extension pages",
                               ImGuiWindowFlags_NoCollapse | ImGuiWindowFlags_NoSavedSettings ),
            slot_( std::move( slot ) ), pages_( std::move( pages ) ) {}

        void run() {
            input_context context( "HELP_KEYBINDINGS" );
            context.register_action( "QUIT" );
            context.register_action( "UP" );
            context.register_action( "DOWN" );
            context.register_action( "LEFT" );
            context.register_action( "RIGHT" );
            context.register_action( "PAGE_UP" );
            context.register_action( "PAGE_DOWN" );
            context.register_action( "ANY_INPUT" );
            context.register_action( "HELP_KEYBINDINGS" );
            ui_manager::redraw();
            while( get_is_open() ) {
                ui_manager::redraw();
                if( consume_navigation_requests( page_stack_, 0 ) ) {
                    break;
                }
                const std::string action =
                    context.handle_input( page_host_poll_timeout() );
                if( action == "QUIT" ) {
                    if( !page_stack_.empty() ) {
                        page_stack_.pop_back();
                    } else {
                        break;
                    }
                } else if( page_stack_.empty() ) {
                    if( action == "UP" || action == "LEFT" ) {
                        move_selection( -1 );
                    } else if( action == "DOWN" || action == "RIGHT" ) {
                        move_selection( 1 );
                    } else if( action == "PAGE_UP" ) {
                        move_selection( -5 );
                    } else if( action == "PAGE_DOWN" ) {
                        move_selection( 5 );
                    }
                }
            }
        }

    protected:
        cataimgui::bounds get_bounds() override {
            const cata::ui::profile profile = cata::ui::current_profile();
            return { -1.0F, -1.0F, profile.page_width, profile.page_height };
        }

        void draw_controls() override {
            const cata::ui::profile profile = cata::ui::current_profile();
            const ui_profile_style_guard style( profile );

            if( !page_stack_.empty() ) {
                if( ImGui::Button( _( "Back" ),
                                   ImVec2( 0.0F, profile.minimum_target ) ) ) {
                    page_stack_.pop_back();
                    return;
                }
                ImGui::SameLine();
                const page_definition *page =
                    find_page( page_stack_.back().page_id );
                ImGui::TextUnformatted(
                    page == nullptr ? page_stack_.back().page_id.c_str() :
                    page->title.c_str() );
                ImGui::Separator();
                draw_scrollable_child(
                    "##lua_stacked_page_content", ImVec2( 0.0F, 0.0F ),
                ImGuiChildFlags_None, true, [this]() {
                    draw_registered_page( page_stack_.back().page_id,
                                          page_stack_.back().parameters );
                } );
                return;
            }

            ImGui::TextUnformatted( _( "Extensions" ) );
            ImGui::SameLine();
            if( ImGui::Button( _( "Reload Lua" ), ImVec2( 0.0F, profile.minimum_target ) ) ) {
                const std::string previous_id = selected_id();
                std::string error;
                if( reload_scripts( error ) ) {
                    pages_ = registered_pages( slot_ );
                    select_id( previous_id );
                    ::add_msg( _( "Lua UI scripts reloaded." ) );
                } else {
                    ::add_msg( m_bad, _( "Lua reload failed: %s" ), error );
                }
            }
            ImGui::Separator();

            if( pages_.empty() ) {
                ImGui::TextWrapped( "%s", _( "No extension pages are registered here." ) );
                return;
            }
            selected_ = std::clamp( selected_, 0, static_cast<int>( pages_.size() ) - 1 );
            const ImVec2 available = ImGui::GetContentRegionAvail();
            const bool single_column =
                profile.breakpoint_for_width( available.x ) ==
                cata::ui::layout_breakpoint::narrow;
            if( single_column ) {
                draw_horizontal_navigation( profile );
                ImGui::Separator();
                draw_scrollable_child(
                    "##lua_extension_content", ImVec2( 0.0F, 0.0F ),
                ImGuiChildFlags_None, true, [this]() {
                    draw_registered_page( pages_[selected_].id );
                } );
            } else {
                const float navigation_width = std::clamp(
                                                   available.x * 0.27F,
                                                   profile.width_normal,
                                                   profile.width_wide );
                draw_scrollable_child(
                    "##lua_extension_navigation",
                    ImVec2( navigation_width, 0.0F ),
                ImGuiChildFlags_Borders, false, [this, &profile]() {
                    draw_vertical_navigation( profile.minimum_target );
                } );
                ImGui::SameLine();
                draw_scrollable_child(
                    "##lua_extension_content", ImVec2( 0.0F, 0.0F ),
                ImGuiChildFlags_Borders, true, [this]() {
                    ImGui::TextUnformatted( pages_[selected_].title.c_str() );
                    ImGui::Separator();
                    draw_registered_page( pages_[selected_].id );
                } );
            }
        }

    private:
        std::string slot_;
        std::vector<page_info> pages_;
        std::vector<page_stack_entry> page_stack_;
        int selected_ = 0;
        bool scroll_to_selection_ = true;

        void move_selection( const int delta ) {
            if( pages_.empty() || delta == 0 ) {
                return;
            }
            const int count = static_cast<int>( pages_.size() );
            selected_ = ( selected_ + delta % count + count ) % count;
            scroll_to_selection_ = true;
        }

        std::string selected_id() const {
            if( selected_ < 0 || static_cast<std::size_t>( selected_ ) >= pages_.size() ) {
                return {};
            }
            return pages_[selected_].id;
        }

        void select_id( const std::string &id ) {
            const auto found = std::find_if( pages_.begin(), pages_.end(), [&id]( const page_info & page ) {
                return page.id == id;
            } );
            selected_ = found == pages_.end() ? 0 :
                        static_cast<int>( std::distance( pages_.begin(), found ) );
        }

        void draw_vertical_navigation( const float target_height ) {
            std::string category;
            for( std::size_t index = 0; index < pages_.size(); ++index ) {
                const page_info &page = pages_[index];
                if( page.category != category ) {
                    category = page.category;
                    ImGui::SeparatorText( category.c_str() );
                }
                if( ImGui::Selectable( ( page.title + "###lua_page_" + page.id ).c_str(),
                                       selected_ == static_cast<int>( index ), 0,
                                       ImVec2( 0.0F, target_height ) ) &&
                    !cataimgui::interaction_suppressed() ) {
                    selected_ = static_cast<int>( index );
                }
                if( selected_ == static_cast<int>( index ) &&
                    scroll_to_selection_ ) {
                    ImGui::SetScrollHereY( 0.5F );
                    scroll_to_selection_ = false;
                }
            }
        }

        void draw_horizontal_navigation( const cata::ui::profile &profile ) {
            if( ImGui::BeginChild(
                    "##lua_extension_tabs",
                    ImVec2( 0.0F, profile.minimum_target +
                            profile.item_spacing_y ),
                    ImGuiChildFlags_None,
                    ImGuiWindowFlags_HorizontalScrollbar ) ) {
                for( std::size_t index = 0; index < pages_.size(); ++index ) {
                    if( index > 0 ) {
                        ImGui::SameLine();
                    }
                    const bool selected =
                        selected_ == static_cast<int>( index );
                    if( selected ) {
                        ImGui::PushStyleColor(
                            ImGuiCol_Button,
                            ImVec4( 0.08F, 0.30F, 0.34F, 1.0F ) );
                        ImGui::PushStyleColor(
                            ImGuiCol_Border,
                            ImVec4( 0.32F, 0.72F, 0.75F, 1.0F ) );
                    }
                    if( ImGui::Button( ( pages_[index].title + "###lua_page_" +
                                         pages_[index].id ).c_str(),
                                       ImVec2( 0.0F, profile.minimum_target ) ) ) {
                        selected_ = static_cast<int>( index );
                    }
                    if( selected ) {
                        ImGui::PopStyleColor( 2 );
                    }
                    if( selected && scroll_to_selection_ ) {
                        ImGui::SetScrollHereX( 0.5F );
                        scroll_to_selection_ = false;
                    }
                }
            }
            ImGui::EndChild();
        }
};

bool reload_scripts_with_state(
    const script_persistent_state *initial_character_state,
    const script_persistent_state *initial_world_state,
    std::string &error )
{
    try {
        auto next = std::make_unique<runtime_state>();
        if( active_state ) {
            next->persistent_state = active_state->persistent_state;
            next->world_state = active_state->world_state;
            next->page_state = active_state->page_state;
        } else {
            if( initial_character_state != nullptr ) {
                next->persistent_state = *initial_character_state;
            }
            if( initial_world_state != nullptr ) {
                next->world_state = *initial_world_state;
            }
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
        sync_hud_adaptor();
        clear_navigation_requests();
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
    // The profile loader is an independent, early Lua sandbox.  A bad profile
    // falls back to compiled defaults and must not invalidate working Mod UI
    // scripts, so only surface its error after a successful script reload.
    std::string profile_error;
    cata::ui::reload_profile( profile_error );
    const bool reloaded = reload_scripts_with_state( nullptr, nullptr, error );
    if( reloaded && !profile_error.empty() ) {
        record_runtime_error( "UI profile reload failed", profile_error );
    }
    return reloaded;
}

void on_world_ready()
{
    // A save/new-game transition is a runtime boundary, unlike an in-page hot
    // reload.  Never retain callbacks or state belonging to the previous world.
    world_ready_for_huds = false;
    hud_adaptor.reset();
    active_state.reset();
    clear_navigation_requests();
    script_persistent_state saved_character_state;
    std::string character_state_error;
    load_state_file( persistent_state_path(), saved_character_state,
                     character_state_error );

    script_persistent_state saved_world_state;
    std::string world_state_error;
    if( const std::optional<cata_path> path = world_state_path() ) {
        load_state_file( *path, saved_world_state, world_state_error );
    }

    std::string script_error;
    if( !reload_scripts_with_state( &saved_character_state,
                                    &saved_world_state, script_error ) ) {
        ::add_msg( m_bad, _( "Lua initialization failed: %s" ), script_error );
    }
    if( !character_state_error.empty() ) {
        record_runtime_error( "Lua character state load failed",
                              character_state_error );
        ::add_msg( m_warning,
                   _( "Lua character state could not be loaded; using defaults: %s" ),
                   character_state_error );
    }
    if( !world_state_error.empty() ) {
        record_runtime_error( "Lua world state load failed", world_state_error );
        ::add_msg( m_warning,
                   _( "Lua world state could not be loaded; using defaults: %s" ),
                   world_state_error );
    }
    world_ready_for_huds = true;
    sync_hud_adaptor();
}

bool save_persistent_state( std::string &error )
{
    if( !active_state ) {
        error.clear();
        return true;
    }

    std::vector<std::string> errors;
    std::string character_error;
    if( !write_state_file( persistent_state_path(), active_state->persistent_state,
                           character_error ) ) {
        record_runtime_error( "Lua character state save failed", character_error );
        errors.push_back( character_error );
    }

    if( const std::optional<cata_path> path = world_state_path() ) {
        std::string world_error;
        if( !write_state_file( *path, active_state->world_state,
                               world_error ) ) {
            record_runtime_error( "Lua world state save failed", world_error );
            errors.push_back( world_error );
        }
    }

    error.clear();
    for( const std::string &entry : errors ) {
        if( !error.empty() ) {
            error += "; ";
        }
        error += entry;
    }
    return errors.empty();
}

runtime_status status()
{
    runtime_status result;
    result.loaded = active_state != nullptr;
    result.hud_renderer_active = hud_adaptor && hud_adaptor->is_imgui;
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

void shutdown()
{
    world_ready_for_huds = false;
    hud_adaptor.reset();
    active_state.reset();
    clear_actions();
    clear_navigation_requests();
    last_runtime_error.clear();
}

std::vector<page_info> registered_pages( const std::string_view slot )
{
    std::vector<page_info> result;
    if( !active_state ) {
        return result;
    }
    for( const page_definition &page : active_state->pages ) {
        if( !slot.empty() && std::find( page.slots.begin(), page.slots.end(), slot ) ==
            page.slots.end() ) {
            continue;
        }
        result.push_back( { page.id, page.title, page.category, page.slots, page.order } );
    }
    std::stable_sort( result.begin(), result.end(), []( const page_info & left,
    const page_info & right ) {
        if( left.category != right.category ) {
            return left.category < right.category;
        }
        if( left.order != right.order ) {
            return left.order < right.order;
        }
        if( left.title != right.title ) {
            return left.title < right.title;
        }
        return left.id < right.id;
    } );
    return result;
}

bool has_registered_pages( const std::string_view slot )
{
    if( !active_state ) {
        return false;
    }
    return std::any_of( active_state->pages.begin(), active_state->pages.end(),
    [slot]( const page_definition & page ) {
        return slot.empty() || std::find( page.slots.begin(), page.slots.end(), slot ) !=
               page.slots.end();
    } );
}

bool show_page( const std::string &page_id )
{
    std::string error;
    if( !active_state && !reload_scripts( error ) ) {
        popup( _( "Unable to load Lua UI scripts:\n%s" ), error );
        return false;
    }
    page_definition *page = find_page( page_id );
    if( page == nullptr ) {
        return false;
    }
    lua_page_window window( page->id, page->title );
    window.run();
    return true;
}

bool process_pending_navigation()
{
    while( const std::optional<navigation_request> request =
               take_navigation_request() ) {
        if( request->type != navigation_request_type::open_page ) {
            continue;
        }
        if( !active_state ) {
            clear_navigation_requests();
            return false;
        }
        page_definition *page = find_page( request->page_id );
        if( page == nullptr ) {
            ::add_msg( m_bad, _( "Lua page is no longer registered: %s" ),
                       request->page_id );
            continue;
        }
        lua_page_window window( page->id, page->title, request->parameters );
        window.run();
        return true;
    }
    return false;
}

void show_slot( const std::string_view slot )
{
    std::string error;
    if( !reload_scripts( error ) ) {
        popup( _( "Unable to load Lua UI scripts:\n%s" ), error );
        return;
    }
    std::vector<page_info> pages = registered_pages( slot );
    if( pages.empty() ) {
        popup( _( "Lua loaded successfully, but no UI pages were registered here." ) );
        return;
    }
    lua_page_hub_window window( std::string( slot ), std::move( pages ) );
    window.run();
}

void show()
{
    show_slot( {} );
}

} // namespace cata::lua_ui
