#include "catalua_ui.h"

#include <algorithm>
#include <array>
#include <chrono>
#include <cstdlib>
#include <deque>
#include <filesystem>
#include <fstream>
#include <functional>
#include <limits>
#include <memory>
#include <optional>
#include <set>
#include <stdexcept>
#include <string>
#include <unordered_map>
#include <utility>
#include <vector>

#include "avatar.h"
#include "cached_options.h"
#include "calendar.h"
#include "cata_imgui.h"
#include "cata_scope_helpers.h"
#include "cata_utility.h"
#include "cata_variant.h"
#include "catalua_sol.h"
#include "catalua_bindings.h"
#include "catalua_bindings_values.h"
#include "catalua_game_handle.h"
#include "catalua_ui_actions.h"
#include "catalua_ui_actions_internal.h"
#include "catalua_ui_bionics.h"
#include "catalua_ui_callbacks.h"
#include "catalua_ui_crafting.h"
#include "catalua_ui_creatures.h"
#include "catalua_ui_effects.h"
#include "catalua_ui_events.h"
#include "catalua_ui_game.h"
#include "catalua_ui_hordes.h"
#include "catalua_ui_i18n.h"
#include "catalua_ui_imgui.h"
#include "catalua_ui_items.h"
#include "catalua_ui_magic.h"
#include "catalua_ui_manifest.h"
#include "catalua_ui_mapgen.h"
#include "catalua_ui_missions.h"
#include "catalua_ui_modules.h"
#include "catalua_ui_mutations.h"
#include "catalua_ui_navigation.h"
#include "catalua_ui_navigation_internal.h"
#include "catalua_ui_overmap.h"
#include "catalua_ui_renderer.h"
#include "catalua_ui_registry.h"
#include "catalua_ui_scheduler.h"
#include "catalua_ui_services.h"
#include "catalua_ui_state.h"
#include "catalua_ui_values.h"
#include "catalua_ui_world.h"
#include "debug.h"
#include "enum_conversions.h"
#include "event.h"
#include "event_bus.h"
#include "event_subscriber.h"
#include "filesystem.h"
#include "game.h"
#include "game_constants.h"
#include "imgui/imgui.h"
#include "input_context.h"
#include "input_context_actions.h"
#include "json_loader.h"
#include "messages.h"
#include "mapgendata.h"
#include "mod_manager.h"
#include "output.h"
#include "path_info.h"
#include "translations.h"
#include "thread_pool.h"
#include "type_id.h"
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
constexpr int instruction_hook_quantum = 1000;
constexpr std::uint64_t slow_callback_threshold_us = 8000;
constexpr std::size_t maximum_page_stack_depth = 32;
constexpr std::size_t maximum_diagnostic_records = 64;
constexpr std::size_t maximum_diagnostic_context_bytes = 512;
constexpr std::size_t maximum_diagnostic_message_bytes = 8192;

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

class instruction_guard
{
    public:
        instruction_guard( lua_State *lua, int limit ) : lua_( lua ), old_hook_( lua_gethook( lua ) ),
            old_mask_( lua_gethookmask( lua ) ), old_count_( lua_gethookcount( lua ) ),
            previous_( active() ), remaining_( std::max( 1, limit ) ) {
            bool parent_exceeded = false;
            for( instruction_guard *ancestor = previous_; ancestor != nullptr;
                 ancestor = ancestor->previous_ ) {
                if( ancestor->lua_ == lua_ ) {
                    parent_exceeded = ancestor->consume( instruction_hook_quantum ) ||
                                      parent_exceeded;
                }
            }
            if( parent_exceeded ) {
                mark_exceeded( lua_ );
                throw std::runtime_error( "Lua instruction budget exceeded" );
            }
            active() = this;
            lua_sethook( lua_, instruction_limit_hook, LUA_MASKCOUNT,
                         instruction_hook_quantum );
        }

        instruction_guard( const instruction_guard & ) = delete;
        instruction_guard &operator=( const instruction_guard & ) = delete;

        ~instruction_guard() {
            lua_sethook( lua_, old_hook_, old_mask_, old_count_ );
            active() = previous_;
        }

        static bool budget_exceeded( lua_State *lua ) noexcept {
            for( instruction_guard *guard = active(); guard != nullptr;
                 guard = guard->previous_ ) {
                if( guard->lua_ == lua && guard->exceeded_ ) {
                    return true;
                }
            }
            return false;
        }

    private:
        static instruction_guard *&active() noexcept {
            static thread_local instruction_guard *guard = nullptr;
            return guard;
        }

        static void mark_exceeded( lua_State *lua ) noexcept {
            for( instruction_guard *guard = active(); guard != nullptr;
                 guard = guard->previous_ ) {
                if( guard->lua_ == lua ) {
                    guard->exceeded_ = true;
                    guard->remaining_ = 0;
                }
            }
        }

        static void instruction_limit_hook( lua_State *lua, lua_Debug * ) {
            bool exceeded = false;
            for( instruction_guard *guard = active(); guard != nullptr;
                 guard = guard->previous_ ) {
                if( guard->lua_ == lua ) {
                    exceeded = guard->consume( instruction_hook_quantum ) || exceeded;
                }
            }
            if( exceeded ) {
                mark_exceeded( lua );
                luaL_error( lua, "Lua instruction budget exceeded" );
            }
        }

        bool consume( int amount ) noexcept {
            if( exceeded_ || remaining_ <= amount ) {
                exceeded_ = true;
                remaining_ = 0;
                return true;
            }
            remaining_ -= amount;
            return false;
        }

        lua_State *lua_;
        lua_Hook old_hook_;
        int old_mask_;
        int old_count_;
        instruction_guard *previous_;
        int remaining_;
        bool exceeded_ = false;
};

int guarded_protected_call( lua_State *lua )
{
    if( instruction_guard::budget_exceeded( lua ) ) {
        return luaL_error( lua, "Lua instruction budget exceeded" );
    }

    const int argument_count = lua_gettop( lua );
    lua_pushvalue( lua, lua_upvalueindex( 1 ) );
    lua_insert( lua, 1 );
    lua_call( lua, argument_count, LUA_MULTRET );

    if( instruction_guard::budget_exceeded( lua ) ) {
        return luaL_error( lua, "Lua instruction budget exceeded" );
    }
    return lua_gettop( lua );
}

void install_guarded_protected_calls( lua_State *lua )
{
    static constexpr std::array<const char *, 2> function_names = { "pcall", "xpcall" };
    for( const char *name : function_names ) {
        lua_getglobal( lua, name );
        if( !lua_isfunction( lua, -1 ) ) {
            lua_pop( lua, 1 );
            throw std::runtime_error( std::string( "Lua base library is missing " ) + name );
        }
        lua_pushcclosure( lua, guarded_protected_call, 1 );
        lua_setglobal( lua, name );
    }
}

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

struct script_source {
    script_manifest manifest;
    fs::path root;
    fs::path entry;
};

struct mapgen_handler_filter {
    std::vector<std::string> terrain_ids;
    int z_min = -OVERMAP_DEPTH;
    int z_max = OVERMAP_HEIGHT;
};

struct mapgen_handler_options {
    mapgen_handler_filter filter;
    int priority = 0;
    bool once = false;
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
        std::vector<script_source> sources;
        std::unique_ptr<script_module_resolver> module_resolver;
        std::unordered_map<std::string, sol::object> module_cache;
        std::set<std::string> loading_modules;
        std::vector<std::size_t> loaded_module_counts;
        std::size_t module_load_depth = 0;
        std::vector<sol::environment> source_environments;
        deterministic_turn_scheduler scheduler;
        std::unordered_map<std::uint64_t, sol::protected_function> scheduled_callbacks;
        script_service_registry service_registry;
        std::unordered_map<std::string, sol::protected_function> service_methods;
        int service_call_depth = 0;
        std::vector<page_definition> pages;
        script_event_registry event_registry;
        std::unordered_map<std::uint64_t, sol::protected_function> event_callbacks;
        script_event_registry hook_registry;
        std::unordered_map<std::uint64_t, sol::protected_function> hook_callbacks;
        script_event_registry mapgen_registry;
        std::unordered_map<std::uint64_t, sol::protected_function> mapgen_callbacks;
        std::unordered_map<std::uint64_t, mapgen_handler_filter> mapgen_filters;
        int event_dispatch_depth = 0;
        int hook_dispatch_depth = 0;
        int mapgen_dispatch_depth = 0;
        std::size_t generation = 0;
        std::size_t world_generation = 0;
        bool accept_actions = false;
        std::optional<std::size_t> current_source;
        std::optional<std::string> current_page;
        std::uint64_t callback_count = 0;
        std::uint64_t callback_time_total_us = 0;
        std::uint64_t callback_time_max_us = 0;
        std::uint64_t slow_callback_count = 0;
        std::string last_slow_callback;
};

struct runtime_diagnostic_record {
    std::uint64_t sequence = 0;
    std::size_t generation = 0;
    std::size_t world_generation = 0;
    std::string source;
    std::string context;
    std::string message;
};

std::unique_ptr<runtime_state> active_state;
std::string last_runtime_error;
std::size_t generation_counter = 0;
std::size_t world_generation_counter = 0;
std::deque<runtime_diagnostic_record> diagnostic_history;
std::uint64_t diagnostic_sequence = 0;
bool mapgen_bootstrap_attempted = false;

bool dispatch_custom_event( runtime_state &state, const std::string &internal_name,
                            const std::string &display_name,
                            const script_value_map &data );

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

void require_api_version( const runtime_state &state, const int minimum_version,
                          const std::string_view api_name )
{
    const script_manifest &manifest = current_manifest( state );
    if( manifest.api_version < minimum_version ) {
        throw std::runtime_error(
            std::string( api_name ) + " requires Lua API " +
            std::to_string( minimum_version ) + " (source '" + manifest.id +
            "' requests API " + std::to_string( manifest.api_version ) + ")" );
    }
}

std::int64_t script_current_turn()
{
    return to_turn<std::int64_t>( calendar::turn );
}

std::uint64_t schedule_callback( runtime_state &state, const std::int64_t delay,
                                 sol::protected_function callback, const bool repeating )
{
    require_capability( state, "scheduler" );
    if( !state.current_source || !callback.valid() ) {
        throw std::runtime_error( "scheduler requires an active source and callback function" );
    }
    const std::size_t source_index = *state.current_source;
    const std::uint64_t id = repeating ?
                             state.scheduler.schedule_every(
                                 script_current_turn(), delay, source_index ) :
                             state.scheduler.schedule_after(
                                 script_current_turn(), delay, source_index );
    try {
        state.scheduled_callbacks.emplace( id, std::move( callback ) );
    } catch( ... ) {
        state.scheduler.cancel_unchecked( id );
        throw;
    }
    return id;
}

bool cancel_scheduled_callback( runtime_state &state, const std::uint64_t id )
{
    require_capability( state, "scheduler" );
    if( !state.current_source ) {
        throw std::runtime_error( "scheduler.cancel is outside a Lua source context" );
    }
    if( !state.scheduler.cancel( id, *state.current_source ) ) {
        return false;
    }
    state.scheduled_callbacks.erase( id );
    return true;
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
    const std::string stored_context =
        context.substr( 0, maximum_diagnostic_context_bytes );
    const std::string stored_error =
        error.substr( 0, maximum_diagnostic_message_bytes );
    last_runtime_error = stored_context + ": " + stored_error;

    if( diagnostic_sequence == std::numeric_limits<std::uint64_t>::max() ) {
        diagnostic_history.clear();
        diagnostic_sequence = 0;
    }
    runtime_diagnostic_record record;
    record.sequence = ++diagnostic_sequence;
    record.generation = active_state ?
                        active_state->generation : generation_counter;
    record.world_generation = active_state ?
                              active_state->world_generation :
                              world_generation_counter;
    if( active_state && active_state->current_source &&
        *active_state->current_source < active_state->sources.size() ) {
        record.source =
            active_state->sources[*active_state->current_source].manifest.id;
    }
    record.context = stored_context;
    record.message = stored_error;
    diagnostic_history.push_back( std::move( record ) );
    while( diagnostic_history.size() > maximum_diagnostic_records ) {
        diagnostic_history.pop_front();
    }

    // Script failures are isolated and recoverable.  Logging them as D_ERROR
    // emits an expensive native backtrace, which can stall hot reload for many
    // seconds without adding useful context beyond the Lua stack trace.
    DebugLog( D_WARNING, D_MAIN ) << last_runtime_error;
}

void disable_native_module_searchers( runtime_state &state )
{
    lua_State *lua = state.lua.lua_state();
    lua_getglobal( lua, "package" );
    lua_newtable( lua );
    lua_setfield( lua, -2, "searchers" );
    lua_pushliteral( lua, "" );
    lua_setfield( lua, -2, "path" );
    lua_pushliteral( lua, "" );
    lua_setfield( lua, -2, "cpath" );
    lua_pushnil( lua );
    lua_setfield( lua, -2, "loadlib" );
    lua_pop( lua, 1 );
}

std::string module_display_name(
    const std::optional<std::string_view> provider_id,
    const std::string_view module_name )
{
    return provider_id ?
           std::string( *provider_id ) + ":" + std::string( module_name ) :
           std::string( module_name );
}

std::string read_bounded_module_source(
    const fs::path &path, const std::string_view display_name )
{
    std::error_code error;
    const std::uintmax_t size = fs::file_size( path, error );
    if( error ) {
        throw std::runtime_error(
            "Lua module '" + std::string( display_name ) +
            "' could not be inspected" );
    }
    if( size > maximum_module_source_bytes ) {
        throw std::runtime_error(
            "Lua module '" + std::string( display_name ) +
            "' exceeds the 1 MiB source size limit" );
    }

    std::ifstream input( path, std::ios::binary );
    if( !input ) {
        throw std::runtime_error(
            "Lua module '" + std::string( display_name ) +
            "' could not be opened" );
    }
    std::string source( static_cast<std::size_t>( size ), '\0' );
    if( size > 0 ) {
        input.read( source.data(), static_cast<std::streamsize>( size ) );
    }
    if( input.gcount() != static_cast<std::streamsize>( size ) ||
        input.peek() != std::char_traits<char>::eof() ) {
        throw std::runtime_error(
            "Lua module '" + std::string( display_name ) +
            "' changed while it was being read" );
    }
    return source;
}

sol::object load_module( runtime_state &state, const std::size_t caller_index,
                         const std::optional<std::string_view> provider_id,
                         const std::string_view module_name )
{
    if( state.module_resolver == nullptr ) {
        throw std::runtime_error( "Lua module resolver is not initialized" );
    }
    const std::optional<script_module_resolution> resolution =
        provider_id ?
        state.module_resolver->resolve_import( caller_index, *provider_id, module_name ) :
        state.module_resolver->resolve_local( caller_index, module_name );
    if( !resolution ) {
        const std::string prefix = provider_id ?
                                   "Lua dependency module '" + std::string( *provider_id ) + ":" :
                                   "Lua module '";
        throw std::runtime_error( prefix + std::string( module_name ) +
                                  "' was not found or is not allowed" );
    }

    if( caller_index >= state.sources.size() ||
        caller_index >= state.source_environments.size() ||
        caller_index >= state.loaded_module_counts.size() ) {
        throw std::runtime_error( "Lua module caller has an invalid source environment" );
    }
    // Modules are source code dependencies, not capability-bearing services.
    // Execute and cache one copy per consumer so an imported helper uses the
    // consumer's capabilities and mutable exports never leak between Mods.
    const std::string cache_key =
        state.sources[caller_index].manifest.id + "->" + resolution->cache_key;
    const auto cached = state.module_cache.find( cache_key );
    if( cached != state.module_cache.end() ) {
        return cached->second;
    }

    const std::string display_name =
        module_display_name( provider_id, module_name );
    if( state.module_load_depth >= maximum_module_load_depth ) {
        throw std::runtime_error(
            "Lua module '" + display_name +
            "' exceeds the module nesting limit" );
    }
    if( state.loaded_module_counts[caller_index] >=
        maximum_modules_per_source ) {
        throw std::runtime_error(
            "Lua source '" + state.sources[caller_index].manifest.id +
            "' exceeds the loaded module limit" );
    }
    if( state.module_cache.size() >= maximum_modules_per_runtime ) {
        throw std::runtime_error(
            "Lua runtime exceeds the loaded module limit" );
    }

    // Match Lua require's cycle behavior: a recursive request observes true
    // until the first evaluation supplies its final exported value.
    sol::object provisional = sol::make_object( state.lua, true );
    ++state.module_load_depth;
    on_out_of_scope restore_depth( [&state]() {
        --state.module_load_depth;
    } );
    ++state.loaded_module_counts[caller_index];
    try {
        state.module_cache.emplace( cache_key, provisional );
        state.loading_modules.insert( cache_key );
        const std::string module_source =
            read_bounded_module_source( resolution->path, display_name );
        sol::load_result loaded =
            state.lua.load( module_source, "@" + display_name );
        if( !loaded.valid() ) {
            const sol::error error = loaded;
            throw std::runtime_error(
                "Lua module '" + display_name + "': " + error.what() );
        }
        sol::protected_function module = loaded;
        sol::set_environment( state.source_environments[caller_index], module );
        source_scope source( state, caller_index );
        instruction_guard guard( state.lua.lua_state(), script_instruction_limit );
        sol::protected_function_result result = module();
        if( !result.valid() ) {
            const sol::error error = result;
            throw std::runtime_error(
                "Lua module '" + display_name + "': " + error.what() );
        }

        sol::object exported = provisional;
        if( result.return_count() > 0 && result.get_type() != sol::type::nil ) {
            exported = result.get<sol::object>();
        }
        state.module_cache[cache_key] = exported;
        state.loading_modules.erase( cache_key );
        return exported;
    } catch( ... ) {
        state.loading_modules.erase( cache_key );
        state.module_cache.erase( cache_key );
        --state.loaded_module_counts[caller_index];
        throw;
    }
}

sol::table clone_api_table( sol::state_view lua, const sol::table &source, const int depth )
{
    sol::table result = lua.create_table();
    for( const auto &entry : source ) {
        const sol::object key = entry.first;
        const sol::object value = entry.second;
        if( depth > 0 && value.get_type() == sol::type::table ) {
            result[key] = clone_api_table( lua, value.as<sol::table>(), depth - 1 );
        } else {
            result[key] = value;
        }
    }
    return result;
}

void create_source_environments( runtime_state &state )
{
    static const std::array<std::string_view, 12> isolated_tables = {
        "ui", "events", "game", "state", "i18n", "modules", "registry", "scheduler",
        "services", "math", "string", "table"
    };
    static const std::array<std::string_view, 21> safe_globals = {
        "_VERSION", "assert", "error", "getmetatable", "ipairs", "next", "pairs",
        "pcall", "print", "rawequal", "rawget", "rawlen", "rawset", "require",
        "select", "setmetatable", "tonumber", "tostring", "type", "warn", "xpcall"
    };
    state.source_environments.clear();
    state.source_environments.reserve( state.sources.size() );
    for( std::size_t index = 0; index < state.sources.size(); ++index ) {
        // Do not use the state globals as an __index fallback.  A fallback
        // would let a source delete one of its cloned API tables and regain
        // the shared table, or mutate math/string/table for every other Mod.
        sol::environment environment( state.lua, sol::create );
        for( const std::string_view name : safe_globals ) {
            const sol::object global = state.lua.globals()[std::string( name )];
            if( global.valid() && global.get_type() != sol::type::nil ) {
                environment[std::string( name )] = global;
            }
        }
        for( const std::string_view name : isolated_tables ) {
            const sol::object global = state.lua.globals()[std::string( name )];
            if( global.valid() && global.get_type() == sol::type::table ) {
                environment[std::string( name )] =
                    clone_api_table( state.lua, global.as<sol::table>(), 3 );
            }
        }

        // The custom require implementation does not consult package.loaded.
        // Expose a small compatibility table without cloning package.loaded's
        // cyclic reference back to the shared global environment.
        sol::table package = state.lua.create_table();
        package["path"] = "";
        package["cpath"] = "";
        package["loaded"] = state.lua.create_table();
        package["preload"] = state.lua.create_table();
        package["searchers"] = state.lua.create_table();
        environment["package"] = std::move( package );
        environment["ccb_source_id"] = state.sources[index].manifest.id;
        environment["_G"] = environment;
        state.source_environments.emplace_back( std::move( environment ) );
    }
}

template<typename Definition>
auto find_definition( std::vector<Definition> &definitions, const std::string_view id )
{
    return std::find_if( definitions.begin(), definitions.end(), [id]( const Definition & entry ) {
        return entry.id.compare( id ) == 0;
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

std::string local_custom_event_name( const runtime_state &state,
                                     const std::string_view name )
{
    if( !is_safe_custom_event_segment( name ) ) {
        throw std::runtime_error(
            "custom Lua event names must contain only letters, digits, '_', '-', or '.'" );
    }
    return "custom:" + current_manifest( state ).id + ":" + std::string( name );
}

std::string subscription_event_name( const runtime_state &state,
                                     const std::string &name )
{
    if( io::enum_is_valid<event_type>( name ) ) {
        return "game:" + name;
    }
    if( is_lifecycle_event_name( name ) ) {
        return name;
    }
    return local_custom_event_name( state, name );
}

std::string dependency_custom_event_name( const runtime_state &state,
        const std::string &provider_id, const std::string &name )
{
    if( !is_safe_custom_event_segment( name ) ) {
        throw std::runtime_error( "events.on_from received an invalid custom event name" );
    }
    const script_manifest &manifest = current_manifest( state );
    if( provider_id != manifest.id && provider_id != "builtin" &&
        !manifest.depends_on( provider_id ) ) {
        throw std::runtime_error(
            "events.on_from requires a declared dependency on '" + provider_id + "'" );
    }
    const auto provider = std::find_if(
                              state.sources.begin(), state.sources.end(),
    [&provider_id]( const script_source & source ) {
        return source.manifest.id == provider_id;
    } );
    if( provider == state.sources.end() ) {
        throw std::runtime_error( "events.on_from provider is not loaded: " + provider_id );
    }
    return "custom:" + provider_id + ":" + name;
}

std::pair<int, bool> event_options( const sol::optional<sol::table> &options )
{
    if( !options ) {
        return { 0, false };
    }
    return {
        options->get_or( "priority", 0 ),
        options->get_or( "once", false )
    };
}

std::uint64_t register_event_handler(
    runtime_state &state, std::string normalized_name,
    const sol::optional<sol::table> &options, sol::protected_function callback )
{
    require_capability( state, "events" );
    if( !state.current_source || !callback.valid() ) {
        throw std::runtime_error( "events.on requires an active source and callback function" );
    }
    const auto [priority, once] = event_options( options );
    const std::uint64_t id = state.event_registry.subscribe(
                                 std::move( normalized_name ), priority,
                                 *state.current_source, once );
    try {
        state.event_callbacks.emplace( id, std::move( callback ) );
    } catch( ... ) {
        state.event_registry.unsubscribe_unchecked( id );
        throw;
    }
    return id;
}

bool unregister_event_handler( runtime_state &state, const std::uint64_t id )
{
    require_capability( state, "events" );
    if( !state.current_source ) {
        throw std::runtime_error( "events.off is outside a Lua source context" );
    }
    if( !state.event_registry.unsubscribe( id, *state.current_source ) ) {
        return false;
    }
    state.event_callbacks.erase( id );
    return true;
}

void require_hook_capabilities(
    const runtime_state &state, const script_hook_spec *spec = nullptr )
{
    require_api_version( state, 5, "game.hooks" );
    require_capability( state, "events" );
    require_capability( state, "game.hooks" );
    if( spec != nullptr && spec->mode == script_hook_mode::intercept ) {
        require_capability( state, "game.write" );
    }
}

std::uint64_t register_hook_handler(
    runtime_state &state, const std::string &name,
    const sol::optional<sol::table> &options,
    sol::protected_function callback )
{
    const script_hook_spec *spec = find_script_hook_spec( name );
    if( spec == nullptr ) {
        throw std::invalid_argument(
            "game.hooks.on received an unknown hook name: " + name );
    }
    require_hook_capabilities( state, spec );
    if( !state.current_source || !callback.valid() ) {
        throw std::runtime_error(
            "game.hooks.on requires an active source and callback function" );
    }
    const auto [priority, once] = event_options( options );
    const std::uint64_t id = state.hook_registry.subscribe(
                                 "hook:" + name, priority,
                                 *state.current_source, once );
    try {
        state.hook_callbacks.emplace( id, std::move( callback ) );
    } catch( ... ) {
        state.hook_registry.unsubscribe_unchecked( id );
        throw;
    }
    return id;
}

bool unregister_hook_handler( runtime_state &state, const std::uint64_t id )
{
    require_hook_capabilities( state );
    if( !state.current_source ) {
        throw std::runtime_error(
            "game.hooks.off is outside a Lua source context" );
    }
    if( !state.hook_registry.unsubscribe( id, *state.current_source ) ) {
        return false;
    }
    state.hook_callbacks.erase( id );
    return true;
}

sol::table hook_spec_to_lua(
    sol::state_view lua, const script_hook_spec &spec )
{
    sol::table result = lua.create_table();
    result["name"] = std::string( spec.name );
    result["mode"] = std::string( script_hook_mode_name( spec.mode ) );
    result["cancellable"] = spec.mode == script_hook_mode::intercept;
    result["requires_write"] = spec.mode == script_hook_mode::intercept;
    sol::table fields = lua.create_table();
    for( std::size_t index = 0; index < spec.payload_fields.size(); ++index ) {
        fields[index + 1] = std::string( spec.payload_fields[index] );
    }
    result["payload_fields"] = std::move( fields );
    return result;
}

sol::table describe_hook(
    runtime_state &state, sol::this_state lua, const std::string &name )
{
    const script_hook_spec *spec = find_script_hook_spec( name );
    if( spec == nullptr ) {
        throw std::invalid_argument(
            "game.hooks.describe received an unknown hook name: " + name );
    }
    require_hook_capabilities( state );
    return hook_spec_to_lua( sol::state_view( lua ), *spec );
}

sol::table list_hooks( runtime_state &state, sol::this_state lua )
{
    require_hook_capabilities( state );
    sol::state_view view( lua );
    sol::table result = view.create_table();
    const std::vector<script_hook_spec> &specs = script_hook_specs();
    for( std::size_t index = 0; index < specs.size(); ++index ) {
        result[index + 1] = hook_spec_to_lua( view, specs[index] );
    }
    return result;
}

sol::table hook_limits( runtime_state &state, sol::this_state lua )
{
    require_hook_capabilities( state );
    sol::state_view view( lua );
    sol::table result = view.create_table();
    result["hooks"] = script_hook_specs().size();
    result["handlers"] = script_event_registry::maximum_subscriptions;
    result["registered"] = state.hook_registry.size();
    result["priority_min"] = script_event_registry::minimum_priority;
    result["priority_max"] = script_event_registry::maximum_priority;
    result["dispatch_depth"] = 16;
    result["instruction_budget"] = callback_instruction_limit;
    return result;
}

void require_mapgen_hook_capabilities( const runtime_state &state )
{
    require_api_version( state, 5, "game.mapgen" );
    require_capability( state, "events" );
    require_capability( state, "game.hooks" );
    require_capability( state, "game.read" );
}

mapgen_handler_options read_mapgen_handler_options(
    const sol::optional<sol::table> &options )
{
    mapgen_handler_options result;
    if( !options ) {
        return result;
    }

    result.priority = options->get_or( "priority", 0 );
    result.once = options->get_or( "once", false );
    result.filter.z_min = options->get_or( "z_min", -OVERMAP_DEPTH );
    result.filter.z_max = options->get_or( "z_max", OVERMAP_HEIGHT );
    if( result.filter.z_min < -OVERMAP_DEPTH ||
        result.filter.z_max > OVERMAP_HEIGHT ||
        result.filter.z_min > result.filter.z_max ) {
        throw std::invalid_argument(
            "game.mapgen.on_postprocess requires ordered z_min/z_max "
            "within the overmap bounds" );
    }

    const sol::object raw_terrain_ids = ( *options )["terrain_ids"];
    if( !raw_terrain_ids.valid() ||
        raw_terrain_ids.get_type() == sol::type::nil ) {
        return result;
    }
    if( raw_terrain_ids.get_type() != sol::type::table ) {
        throw std::invalid_argument(
            "game.mapgen.on_postprocess terrain_ids must be an array" );
    }

    const sol::table terrain_ids = raw_terrain_ids.as<sol::table>();
    if( terrain_ids.size() > 64 ) {
        throw std::invalid_argument(
            "game.mapgen.on_postprocess accepts at most 64 terrain_ids" );
    }
    result.filter.terrain_ids.reserve( terrain_ids.size() );
    for( std::size_t index = 1; index <= terrain_ids.size(); ++index ) {
        const sol::object raw_id = terrain_ids[index];
        if( !raw_id.valid() || raw_id.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "game.mapgen.on_postprocess terrain_ids must be an array "
                "of strings" );
        }
        const std::string id = raw_id.as<std::string>();
        if( id.empty() || id.size() > 256 ||
            !oter_str_id( id ).is_valid() ) {
            throw std::invalid_argument(
                "game.mapgen.on_postprocess received an unknown "
                "overmap terrain id" );
        }
        result.filter.terrain_ids.push_back( id );
    }
    std::sort( result.filter.terrain_ids.begin(),
               result.filter.terrain_ids.end() );
    result.filter.terrain_ids.erase(
        std::unique( result.filter.terrain_ids.begin(),
                     result.filter.terrain_ids.end() ),
        result.filter.terrain_ids.end() );
    return result;
}

std::uint64_t register_mapgen_handler(
    runtime_state &state, const sol::optional<sol::table> &options,
    sol::protected_function callback )
{
    require_mapgen_hook_capabilities( state );
    if( !state.current_source || !callback.valid() ) {
        throw std::runtime_error(
            "game.mapgen.on_postprocess requires an active source and "
            "callback function" );
    }
    const mapgen_handler_options parsed =
        read_mapgen_handler_options( options );
    const std::uint64_t id = state.mapgen_registry.subscribe(
                                 "mapgen.postprocess", parsed.priority,
                                 *state.current_source, parsed.once );
    try {
        state.mapgen_callbacks.emplace( id, std::move( callback ) );
        state.mapgen_filters.emplace( id, parsed.filter );
    } catch( ... ) {
        state.mapgen_registry.unsubscribe_unchecked( id );
        state.mapgen_callbacks.erase( id );
        state.mapgen_filters.erase( id );
        throw;
    }
    return id;
}

bool unregister_mapgen_handler(
    runtime_state &state, const std::uint64_t id )
{
    require_mapgen_hook_capabilities( state );
    if( !state.current_source ) {
        throw std::runtime_error(
            "game.mapgen.off is outside a Lua source context" );
    }
    if( !state.mapgen_registry.unsubscribe(
            id, *state.current_source ) ) {
        return false;
    }
    state.mapgen_callbacks.erase( id );
    state.mapgen_filters.erase( id );
    return true;
}

sol::table mapgen_limits( runtime_state &state, sol::this_state lua )
{
    require_mapgen_hook_capabilities( state );
    sol::state_view view( lua );
    sol::table result = view.create_table();
    result["map_width"] = script_mapgen_context::map_width;
    result["map_height"] = script_mapgen_context::map_height;
    result["operations"] = script_mapgen_context::maximum_operations;
    result["nested_generators"] =
        script_mapgen_context::maximum_nested_generators;
    result["full_generators"] =
        script_mapgen_context::maximum_full_generators;
    result["handlers"] =
        script_event_registry::maximum_subscriptions;
    result["registered"] = state.mapgen_registry.size();
    result["priority_min"] =
        script_event_registry::minimum_priority;
    result["priority_max"] =
        script_event_registry::maximum_priority;
    result["z_min"] = -OVERMAP_DEPTH;
    result["z_max"] = OVERMAP_HEIGHT;
    result["terrain_ids"] = 64;
    return result;
}

std::size_t loaded_source_index( const runtime_state &state,
                                 const std::string_view source_id )
{
    const auto found = std::find_if(
                           state.sources.begin(), state.sources.end(),
    [source_id]( const script_source & source ) {
        return source.manifest.id == source_id;
    } );
    if( found == state.sources.end() ) {
        throw std::runtime_error( "Lua source is not loaded: " + std::string( source_id ) );
    }
    return static_cast<std::size_t>( std::distance( state.sources.begin(), found ) );
}

void require_service_dependency( const runtime_state &state,
                                 const std::string_view provider_id )
{
    const script_manifest &consumer = current_manifest( state );
    if( provider_id != consumer.id && provider_id != "builtin" &&
        !consumer.depends_on( provider_id ) ) {
        throw std::runtime_error(
            "Lua service call requires a declared dependency on '" +
            std::string( provider_id ) + "'" );
    }
    static_cast<void>( loaded_source_index( state, provider_id ) );
}

void provide_service( runtime_state &state, const std::string &name,
                      const sol::table &descriptor )
{
    require_capability( state, "services.provide" );
    if( !state.current_source ) {
        throw std::runtime_error( "services.provide is outside a Lua source context" );
    }
    const sol::object methods_object = descriptor["methods"];
    if( !methods_object.valid() || methods_object.get_type() != sol::type::table ) {
        throw std::invalid_argument( "services.provide requires a methods table" );
    }

    const sol::table methods = methods_object.as<sol::table>();
    std::vector<std::string> method_names;
    std::unordered_map<std::string, sol::protected_function> callbacks;
    for( const auto &entry : methods ) {
        const sol::object key = entry.first;
        const sol::object value = entry.second;
        if( key.get_type() != sol::type::string ||
            value.get_type() != sol::type::function ) {
            throw std::invalid_argument(
                "services.provide methods must map string names to functions" );
        }
        const std::string method_name = key.as<std::string>();
        method_names.push_back( method_name );
        callbacks.emplace(
            script_service_registry::method_key(
                current_manifest( state ).id, name, method_name ),
            value.as<sol::protected_function>() );
    }

    const std::string provider_id = current_manifest( state ).id;
    const script_service_definition *previous =
        state.service_registry.find( provider_id, name );
    std::vector<std::string> previous_methods =
        previous == nullptr ? std::vector<std::string>() : previous->methods;
    auto replacement_methods = state.service_methods;
    for( const std::string &method : previous_methods ) {
        replacement_methods.erase(
            script_service_registry::method_key( provider_id, name, method ) );
    }
    for( const auto &[key, callback] : callbacks ) {
        replacement_methods.insert_or_assign( key, callback );
    }
    state.service_registry.provide( {
        provider_id,
        name,
        descriptor.get_or( "version", 1 ),
        *state.current_source,
        method_names
    } );
    state.service_methods.swap( replacement_methods );
}

class service_call_scope
{
    public:
        explicit service_call_scope( runtime_state &state ) : state_( state ) {
            if( state_.service_call_depth >= 16 ) {
                throw std::runtime_error( "Lua service recursion limit reached" );
            }
            ++state_.service_call_depth;
        }

        service_call_scope( const service_call_scope & ) = delete;
        service_call_scope &operator=( const service_call_scope & ) = delete;

        ~service_call_scope() {
            --state_.service_call_depth;
        }

    private:
        runtime_state &state_;
};

sol::table call_service( runtime_state &state, sol::this_state lua,
                         const std::string &provider_id,
                         const std::string &service_name,
                         const std::string &method_name,
                         const sol::optional<sol::table> &arguments )
{
    require_capability( state, "services.consume" );
    require_service_dependency( state, provider_id );
    if( !is_safe_service_identifier( service_name ) ||
        !is_safe_service_identifier( method_name ) ) {
        throw std::invalid_argument( "services.call received an invalid service or method name" );
    }
    const script_service_definition *service =
        state.service_registry.find( provider_id, service_name );
    if( service == nullptr ||
        std::find( service->methods.begin(), service->methods.end(), method_name ) ==
        service->methods.end() ) {
        throw std::runtime_error(
            "Lua service method is unavailable: " + provider_id + "/" +
            service_name + "/" + method_name );
    }
    const std::string key = script_service_registry::method_key(
                                provider_id, service_name, method_name );
    const auto callback_entry = state.service_methods.find( key );
    if( callback_entry == state.service_methods.end() ) {
        throw std::runtime_error( "Lua service method callback is missing" );
    }

    static const script_value_map_limits service_limits{
        64, 128, 8192, 64U * 1024U
    };
    const script_value_map copied_arguments =
        read_script_value_map( arguments, service_limits, "services.call arguments" );
    sol::protected_function callback = callback_entry->second;
    script_value_map copied_result;
    {
        service_call_scope call_scope( state );
        source_scope provider( state, service->source_index );
        instruction_guard guard( state.lua.lua_state(), callback_instruction_limit );
        const auto started = std::chrono::steady_clock::now();
        const sol::protected_function_result result =
            callback( script_value_map_to_lua( state.lua, copied_arguments ) );
        record_callback_timing(
            state, "service '" + provider_id + "/" + service_name + "/" +
            method_name + "'", started );
        if( !result.valid() ) {
            const sol::error error = result;
            record_runtime_error(
                "Lua service '" + provider_id + "/" + service_name + "/" +
                method_name + "'", error.what() );
            throw std::runtime_error( error.what() );
        }
        if( result.return_count() > 0 && result.get_type() != sol::type::nil ) {
            if( result.get_type() != sol::type::table ) {
                throw std::runtime_error( "Lua service methods must return a table or nil" );
            }
            copied_result = read_script_value_map(
                                result.get<sol::table>(), service_limits,
                                "services.call result" );
        }
    }
    return script_value_map_to_lua( sol::state_view( lua ), copied_result );
}

bool service_available( runtime_state &state, const std::string &provider_id,
                        const std::string &service_name, const int minimum_version )
{
    require_capability( state, "services.consume" );
    require_service_dependency( state, provider_id );
    if( !is_safe_service_identifier( service_name ) ) {
        throw std::invalid_argument( "services.available received an invalid service name" );
    }
    if( minimum_version < 1 ||
        minimum_version > script_service_registry::maximum_version ) {
        throw std::invalid_argument(
            "services.available minimum version must be within 1..1000000" );
    }
    const script_service_definition *service =
        state.service_registry.find( provider_id, service_name );
    return service != nullptr && service->version >= minimum_version;
}

sol::table visible_services( runtime_state &state, sol::this_state lua )
{
    require_capability( state, "services.consume" );
    const script_manifest &consumer = current_manifest( state );
    sol::state_view lua_state( lua );
    sol::table result = lua_state.create_table();
    std::size_t output_index = 1;
    for( const script_service_definition &service : state.service_registry.all() ) {
        if( service.provider_id != consumer.id && service.provider_id != "builtin" &&
            !consumer.depends_on( service.provider_id ) ) {
            continue;
        }
        sol::table entry = lua_state.create_table();
        entry["provider"] = service.provider_id;
        entry["name"] = service.name;
        entry["version"] = service.version;
        sol::table methods = lua_state.create_table();
        for( std::size_t index = 0; index < service.methods.size(); ++index ) {
            methods[index + 1] = service.methods[index];
        }
        entry["methods"] = std::move( methods );
        result[output_index++] = std::move( entry );
    }
    return result;
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

sol::table lua_runtime_status( sol::this_state lua, const runtime_state &runtime )
{
    sol::state_view state( lua );
    sol::table result = state.create_table();
    result["loaded"] = true;
    result["generation"] = runtime.generation;
    result["world_generation"] = runtime.world_generation;
    result["pages"] = runtime.pages.size();
    result["event_handlers"] = runtime.event_registry.size();
    result["mapgen_handlers"] = runtime.mapgen_registry.size();
    result["sources"] = runtime.sources.size();
    result["memory_used"] = runtime.memory.used;
    result["memory_limit"] = runtime.memory.limit;
    result["callback_count"] = runtime.callback_count;
    result["callback_time_total_us"] = runtime.callback_time_total_us;
    result["callback_time_max_us"] = runtime.callback_time_max_us;
    result["slow_callback_count"] = runtime.slow_callback_count;
    result["last_slow_callback"] = runtime.last_slow_callback;
    result["last_error"] = last_runtime_error;
    return result;
}

sol::table diagnostic_string_array(
    sol::state_view lua, const std::set<std::string> &values )
{
    sol::table result = lua.create_table(
                            static_cast<int>( values.size() ), 0 );
    std::size_t index = 1;
    for( const std::string &value : values ) {
        result[index++] = value;
    }
    return result;
}

sol::table diagnostic_string_array(
    sol::state_view lua, const std::vector<std::string> &values )
{
    sol::table result = lua.create_table(
                            static_cast<int>( values.size() ), 0 );
    for( std::size_t index = 0; index < values.size(); ++index ) {
        result[index + 1] = values[index];
    }
    return result;
}

struct source_resource_counts {
    std::size_t pages = 0;
    std::size_t event_handlers = 0;
    std::size_t mapgen_handlers = 0;
    std::size_t scheduled_tasks = 0;
    std::size_t services = 0;
    std::size_t modules = 0;
};

std::vector<source_resource_counts> count_source_resources(
    const runtime_state &runtime )
{
    std::vector<source_resource_counts> result( runtime.sources.size() );
    for( const page_definition &page : runtime.pages ) {
        if( page.source_index < result.size() ) {
            ++result[page.source_index].pages;
        }
    }
    for( const script_event_subscription &event :
         runtime.event_registry.all() ) {
        if( event.source_index < result.size() ) {
            ++result[event.source_index].event_handlers;
        }
    }
    for( const script_event_subscription &handler :
         runtime.mapgen_registry.all() ) {
        if( handler.source_index < result.size() ) {
            ++result[handler.source_index].mapgen_handlers;
        }
    }
    for( const scheduled_script_task &task : runtime.scheduler.all() ) {
        if( task.source_index < result.size() ) {
            ++result[task.source_index].scheduled_tasks;
        }
    }
    for( const script_service_definition &service :
         runtime.service_registry.all() ) {
        if( service.source_index < result.size() ) {
            ++result[service.source_index].services;
        }
    }
    for( std::size_t source_index = 0;
         source_index < runtime.sources.size(); ++source_index ) {
        const std::string prefix =
            runtime.sources[source_index].manifest.id + "->";
        for( const auto &entry : runtime.module_cache ) {
            if( entry.first.compare( 0, prefix.size(), prefix ) == 0 ) {
                ++result[source_index].modules;
            }
        }
    }
    return result;
}

sol::table lua_runtime_diagnostics(
    sol::this_state lua, const runtime_state &runtime )
{
    sol::state_view state( lua );
    sol::table snapshot = state.create_table();
    snapshot["schema_version"] = 1;

    sol::table health = state.create_table();
    health["ok"] = last_runtime_error.empty();
    health["last_error"] = last_runtime_error;
    health["memory_pressure"] = runtime.memory.limit == 0 ? 0.0 :
                                static_cast<double>( runtime.memory.used ) /
                                static_cast<double>( runtime.memory.limit );
    health["diagnostic_records"] = diagnostic_history.size();
    health["latest_diagnostic_sequence"] = diagnostic_sequence;
    snapshot["health"] = std::move( health );

    sol::table identity = state.create_table();
    identity["generation"] = runtime.generation;
    identity["world_generation"] = runtime.world_generation;
    identity["source_count"] = runtime.sources.size();
    const bool has_current_source =
        runtime.current_source &&
        *runtime.current_source < runtime.sources.size();
    identity["current_source"] = has_current_source ?
                                 runtime.sources[*runtime.current_source].manifest.id :
                                 std::string();
    identity["accepting_actions"] = runtime.accept_actions;
    snapshot["runtime"] = std::move( identity );

    sol::table memory = state.create_table();
    memory["used"] = runtime.memory.used;
    memory["limit"] = runtime.memory.limit;
    memory["remaining"] =
        runtime.memory.used >= runtime.memory.limit ?
        0 : runtime.memory.limit - runtime.memory.used;
    snapshot["memory"] = std::move( memory );

    sol::table callbacks = state.create_table();
    callbacks["count"] = runtime.callback_count;
    callbacks["total_us"] = runtime.callback_time_total_us;
    callbacks["max_us"] = runtime.callback_time_max_us;
    callbacks["average_us"] = runtime.callback_count == 0 ? 0.0 :
                              static_cast<double>( runtime.callback_time_total_us ) /
                              static_cast<double>( runtime.callback_count );
    callbacks["slow_count"] = runtime.slow_callback_count;
    callbacks["slow_threshold_us"] = slow_callback_threshold_us;
    callbacks["last_slow"] = runtime.last_slow_callback;
    callbacks["event_dispatch_depth"] = runtime.event_dispatch_depth;
    callbacks["mapgen_dispatch_depth"] = runtime.mapgen_dispatch_depth;
    callbacks["service_call_depth"] = runtime.service_call_depth;
    snapshot["callbacks"] = std::move( callbacks );

    sol::table resources = state.create_table();
    resources["pages"] = runtime.pages.size();
    resources["event_handlers"] = runtime.event_registry.size();
    resources["mapgen_handlers"] = runtime.mapgen_registry.size();
    resources["scheduled_tasks"] = runtime.scheduler.size();
    resources["scheduled_callbacks"] = runtime.scheduled_callbacks.size();
    resources["services"] = runtime.service_registry.size();
    resources["service_methods"] = runtime.service_methods.size();
    resources["module_cache"] = runtime.module_cache.size();
    resources["modules_loading"] = runtime.loading_modules.size();
    resources["module_load_depth"] = runtime.module_load_depth;
    resources["character_state_entries"] = runtime.persistent_state.size();
    resources["world_state_entries"] = runtime.world_state.size();
    resources["page_state_entries"] = runtime.page_state.size();
    snapshot["resources"] = std::move( resources );

    sol::table limits = state.create_table();
    limits["memory_bytes"] = runtime.memory.limit;
    limits["script_instructions"] = script_instruction_limit;
    limits["callback_instructions"] = callback_instruction_limit;
    limits["instruction_hook_quantum"] = instruction_hook_quantum;
    limits["scheduler_tasks"] =
        deterministic_turn_scheduler::maximum_tasks;
    limits["scheduler_callbacks_per_turn"] =
        deterministic_turn_scheduler::maximum_callbacks_per_turn;
    limits["event_handlers"] =
        script_event_registry::maximum_subscriptions;
    limits["mapgen_handlers"] =
        script_event_registry::maximum_subscriptions;
    limits["services"] = script_service_registry::maximum_services;
    limits["service_methods"] =
        script_service_registry::maximum_methods_per_service;
    limits["page_stack_depth"] = maximum_page_stack_depth;
    limits["diagnostic_records"] = maximum_diagnostic_records;
    limits["module_name_bytes"] = maximum_module_name_bytes;
    limits["module_source_bytes"] = maximum_module_source_bytes;
    limits["module_load_depth"] = maximum_module_load_depth;
    limits["modules_per_source"] = maximum_modules_per_source;
    limits["modules_per_runtime"] = maximum_modules_per_runtime;
    snapshot["limits"] = std::move( limits );

    const std::vector<source_resource_counts> source_counts =
        count_source_resources( runtime );
    sol::table sources = state.create_table(
                             static_cast<int>( runtime.sources.size() ), 0 );
    for( std::size_t index = 0; index < runtime.sources.size(); ++index ) {
        const script_manifest &manifest = runtime.sources[index].manifest;
        const source_resource_counts &counts = source_counts[index];
        sol::table source = state.create_table();
        source["id"] = manifest.id;
        source["version"] = manifest.version;
        source["api_version"] = manifest.api_version;
        source["capabilities"] =
            diagnostic_string_array( state, manifest.capabilities );
        source["dependencies"] =
            diagnostic_string_array( state, manifest.dependencies );
        source["pages"] = counts.pages;
        source["event_handlers"] = counts.event_handlers;
        source["mapgen_handlers"] = counts.mapgen_handlers;
        source["scheduled_tasks"] = counts.scheduled_tasks;
        source["services"] = counts.services;
        source["modules"] = counts.modules;
        source["current"] =
            has_current_source && *runtime.current_source == index;
        sources[index + 1] = std::move( source );
    }
    snapshot["sources"] = std::move( sources );
    return snapshot;
}

sol::table lua_recent_diagnostics(
    sol::this_state lua, const std::int64_t raw_limit )
{
    if( raw_limit < 0 ||
        raw_limit > static_cast<std::int64_t>( maximum_diagnostic_records ) ) {
        throw std::invalid_argument(
            "game.diagnostics.recent limit must be within 0..64" );
    }
    sol::state_view state( lua );
    const std::size_t limit = static_cast<std::size_t>( raw_limit );
    const std::size_t count = std::min( limit, diagnostic_history.size() );
    sol::table result = state.create_table(
                            static_cast<int>( count ), 0 );
    auto record = diagnostic_history.rbegin();
    for( std::size_t index = 0; index < count; ++index, ++record ) {
        sol::table entry = state.create_table();
        entry["sequence"] = record->sequence;
        entry["severity"] = "error";
        entry["generation"] = record->generation;
        entry["world_generation"] = record->world_generation;
        entry["source"] = record->source;
        entry["context"] = record->context;
        entry["message"] = record->message;
        result[index + 1] = std::move( entry );
    }
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
    const cata::input_context_actions::context_snapshot input_context =
        cata::input_context_actions::snapshot();
    const bool matching_revision = input_context.revision == context_revision;
    const script_manifest &manifest = current_manifest( state );
    const std::string source_id = manifest.id;
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
        const auto descriptor = std::find_if(
                                    input_context.actions.begin(), input_context.actions.end(),
        [&action_id]( const cata::input_context_actions::action_descriptor & entry ) {
            return entry.id == action_id;
        } );
        const bool available =
            matching_revision && descriptor != input_context.actions.end();
        const bool dangerous = available && descriptor->dangerous;
        const bool capability_allows =
            !dangerous || manifest.has_capability( "game.actions.dangerous" );
        const std::string action_label =
            available && !descriptor->label.empty() ?
            descriptor->label : raw_label.as<std::string>();
        options.push_back( {
            action_id,
            raw_label.as<std::string>(),
            option.get_or( "enabled", true ) &&available &&capability_allows,
            dangerous,
            [&state, action_id, action_label, context_revision, source_id, dangerous]()
            {
                if( dangerous ) {
                    require_capability( state, "game.actions.dangerous" );
                    enqueue_context_action(
                        action_id, context_revision, source_id );
                } else {
                    cata::input_context_actions::enqueue(
                        action_id, context_revision );
                }
            }
        } );
    }
    return context.action_slot_id( id, selected_action, context_revision, options );
}

void initialize_state( runtime_state &state )
{
    std::vector<script_module_source> module_sources;
    module_sources.reserve( state.sources.size() );
    for( const script_source &source : state.sources ) {
        module_sources.push_back( { source.manifest, source.root } );
    }
    state.module_resolver =
        std::make_unique<script_module_resolver>( std::move( module_sources ) );
    state.loaded_module_counts.assign( state.sources.size(), 0 );

    state.lua.open_libraries( sol::lib::base, sol::lib::package, sol::lib::math,
                              sol::lib::string, sol::lib::table );
    install_guarded_protected_calls( state.lua.lua_state() );
    state.lua["dofile"] = sol::nil;
    state.lua["load"] = sol::nil;
    state.lua["loadfile"] = sol::nil;
    state.lua["loadstring"] = sol::nil;
    state.lua["collectgarbage"] = sol::nil;
    disable_native_module_searchers( state );

    state.lua.set_function(
        "require",
    [&state]( const std::string & module_name ) {
        if( !state.current_source ) {
            throw std::runtime_error( "require is outside a Lua source context" );
        }
        return load_module( state, *state.current_source, std::nullopt, module_name );
    } );

    sol::table modules = state.lua.create_named_table( "modules" );
    modules.set_function(
        "import",
    [&state]( const std::string & provider_id, const std::string & module_name ) {
        require_capability( state, "modules.import" );
        if( !state.current_source ) {
            throw std::runtime_error( "modules.import is outside a Lua source context" );
        }
        return load_module( state, *state.current_source, provider_id, module_name );
    } );
    modules.set_function( "source_id", [&state]() {
        return current_manifest( state ).id;
    } );

    sol::table scheduler = state.lua.create_named_table( "scheduler" );
    scheduler.set_function(
        "after",
    [&state]( const std::int64_t delay, sol::protected_function callback ) {
        return schedule_callback( state, delay, std::move( callback ), false );
    } );
    scheduler.set_function(
        "every",
    [&state]( const std::int64_t interval, sol::protected_function callback ) {
        return schedule_callback( state, interval, std::move( callback ), true );
    } );
    scheduler.set_function( "cancel", [&state]( const std::uint64_t id ) {
        return cancel_scheduled_callback( state, id );
    } );
    scheduler.set_function( "now", [&state]() {
        require_capability( state, "scheduler" );
        return script_current_turn();
    } );

    sol::table services = state.lua.create_named_table( "services" );
    services.set_function(
        "provide",
    [&state]( const std::string & name, const sol::table & descriptor ) {
        provide_service( state, name, descriptor );
    } );
    services.set_function(
        "call",
        [&state]( sol::this_state lua, const std::string & provider_id,
                  const std::string & service_name, const std::string & method_name,
    const sol::optional<sol::table> &arguments ) {
        return call_service(
                   state, lua, provider_id, service_name, method_name, arguments );
    } );
    services.set_function(
        "available",
        sol::overload(
            [&state]( const std::string & provider_id,
    const std::string & service_name ) {
        return service_available( state, provider_id, service_name, 1 );
    },
    [&state]( const std::string & provider_id,
              const std::string & service_name, const int minimum_version ) {
        return service_available(
                   state, provider_id, service_name, minimum_version );
    } ) );
    services.set_function( "list", [&state]( sol::this_state lua ) {
        return visible_services( state, lua );
    } );

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
    events.set_function(
        "on",
        sol::overload(
            [&state]( const std::string & name,
    sol::protected_function callback ) {
        return register_event_handler(
                   state, subscription_event_name( state, name ),
                   std::nullopt, std::move( callback ) );
    },
    [&state]( const std::string & name, const sol::table & options,
              sol::protected_function callback ) {
        return register_event_handler(
                   state, subscription_event_name( state, name ),
                   options, std::move( callback ) );
    } ) );
    events.set_function(
        "on_from",
        sol::overload(
            [&state]( const std::string & provider_id, const std::string & name,
    sol::protected_function callback ) {
        return register_event_handler(
                   state, dependency_custom_event_name( state, provider_id, name ),
                   std::nullopt, std::move( callback ) );
    },
    [&state]( const std::string & provider_id, const std::string & name,
              const sol::table & options, sol::protected_function callback ) {
        return register_event_handler(
                   state, dependency_custom_event_name( state, provider_id, name ),
                   options, std::move( callback ) );
    } ) );
    events.set_function( "off", [&state]( const std::uint64_t id ) {
        return unregister_event_handler( state, id );
    } );
    events.set_function(
        "emit",
        [&state]( const std::string & name,
    const sol::optional<sol::table> &data ) {
        require_capability( state, "events" );
        const std::string source_id = current_manifest( state ).id;
        const script_value_map copied = read_script_value_map(
                                            data, script_value_map_limits{}, "events.emit data" );
        return dispatch_custom_event(
                   state, local_custom_event_name( state, name ),
                   source_id + ":" + name, copied );
    } );

    state.lua.new_usertype<script_mapgen_context>(
        "ScriptMapgenContext", sol::no_constructor,
        "valid", &script_mapgen_context::valid,
        "operations_used", &script_mapgen_context::operations_used,
        "operations_remaining",
        &script_mapgen_context::operations_remaining,
        "id", &script_mapgen_context::id,
        "north", &script_mapgen_context::north,
        "east", &script_mapgen_context::east,
        "south", &script_mapgen_context::south,
        "west", &script_mapgen_context::west,
        "neast", &script_mapgen_context::neast,
        "seast", &script_mapgen_context::seast,
        "swest", &script_mapgen_context::swest,
        "nwest", &script_mapgen_context::nwest,
        "above", &script_mapgen_context::above,
        "below", &script_mapgen_context::below,
        "get_nesw", &script_mapgen_context::get_nesw,
        "zlevel", &script_mapgen_context::zlevel,
        "get_direction", &script_mapgen_context::get_direction,
        "set_dir", &script_mapgen_context::set_dir,
        "get_rotation", &script_mapgen_context::get_rotation,
        "get_rot_suffix", &script_mapgen_context::get_rot_suffix,
        "random_int", &script_mapgen_context::random_int,
        "random_chance", &script_mapgen_context::random_chance,
        "terrain_at", &script_mapgen_context::terrain_at,
        "furniture_at", &script_mapgen_context::furniture_at,
        "trap_at", &script_mapgen_context::trap_at,
        "set_terrain", &script_mapgen_context::set_terrain,
        "set_furniture", &script_mapgen_context::set_furniture,
        "set_trap", &script_mapgen_context::set_trap,
        "fill_groundcover", &script_mapgen_context::fill_groundcover,
        "nest", &script_mapgen_context::nest,
        "generate", &script_mapgen_context::generate );

    sol::table game = state.lua.create_named_table( "game" );
    game["api_version"] = api_version;
    install_value_type_api( state.lua, game, [&state]() {
        require_api_version( state, 5, "game.types" );
        require_capability( state, "game.read" );
    } );
    sol::table hooks = state.lua.create_table();
    hooks.set_function(
        "on",
        sol::overload(
            [&state]( const std::string & name,
    sol::protected_function callback ) {
        return register_hook_handler(
                   state, name, std::nullopt, std::move( callback ) );
    },
    [&state]( const std::string & name,
              const sol::table & options,
              sol::protected_function callback ) {
        return register_hook_handler(
                   state, name, options, std::move( callback ) );
    } ) );
    hooks.set_function( "off", [&state]( const std::uint64_t id ) {
        return unregister_hook_handler( state, id );
    } );
    hooks.set_function(
        "describe",
    [&state]( sol::this_state lua, const std::string & name ) {
        return describe_hook( state, lua, name );
    } );
    hooks.set_function( "list", [&state]( sol::this_state lua ) {
        return list_hooks( state, lua );
    } );
    hooks.set_function( "limits", [&state]( sol::this_state lua ) {
        return hook_limits( state, lua );
    } );
    game["hooks"] = std::move( hooks );
    sol::table mapgen = state.lua.create_table();
    mapgen.set_function(
        "on_postprocess",
        sol::overload(
    [&state]( sol::protected_function callback ) {
        return register_mapgen_handler(
                   state, std::nullopt, std::move( callback ) );
    },
    [&state]( const sol::table & options,
              sol::protected_function callback ) {
        return register_mapgen_handler(
                   state, options, std::move( callback ) );
    } ) );
    mapgen.set_function( "off", [&state]( const std::uint64_t id ) {
        return unregister_mapgen_handler( state, id );
    } );
    mapgen.set_function( "limits", [&state]( sol::this_state lua ) {
        return mapgen_limits( state, lua );
    } );
    game["mapgen"] = std::move( mapgen );
    install_game_handle_api(
        state.lua, game,
    [&state]() {
        return state.generation;
    },
    [&state]() {
        return state.world_generation;
    },
    [&state]() {
        require_api_version( state, 5, "game.handles" );
        require_capability( state, "game.read" );
    } );
    install_creature_api(
        game,
    [&state]() {
        return state.generation;
    },
    [&state]() {
        return state.world_generation;
    },
    [&state]() {
        require_api_version( state, 5, "game.creatures" );
        require_capability( state, "game.read" );
    },
    [&state]() {
        require_api_version( state, 5, "game.creatures" );
        require_capability( state, "game.write" );
    } );
    install_effect_api(
        game,
    [&state]() {
        return state.generation;
    },
    [&state]() {
        return state.world_generation;
    },
    [&state]() {
        require_api_version( state, 5, "game.effects" );
        require_capability( state, "game.read" );
    },
    [&state]() {
        require_api_version( state, 5, "game.effects" );
        require_capability( state, "game.write" );
    } );
    install_bionic_api(
        game,
    [&state]() {
        return state.generation;
    },
    [&state]() {
        return state.world_generation;
    },
    [&state]() {
        require_api_version( state, 5, "game.bionics" );
        require_capability( state, "game.read" );
    },
    [&state]() {
        require_api_version( state, 5, "game.bionics" );
        require_capability( state, "game.write" );
    } );
    install_mutation_api(
        game,
    [&state]() {
        return state.generation;
    },
    [&state]() {
        return state.world_generation;
    },
    [&state]() {
        require_api_version( state, 5, "game.mutations" );
        require_capability( state, "game.read" );
    },
    [&state]() {
        require_api_version( state, 5, "game.mutations" );
        require_capability( state, "game.write" );
    } );
    install_magic_api(
        game,
    [&state]() {
        return state.generation;
    },
    [&state]() {
        return state.world_generation;
    },
    [&state]() {
        require_api_version( state, 5, "game.spells" );
        require_capability( state, "game.read" );
    },
    [&state]() {
        require_api_version( state, 5, "game.spells" );
        require_capability( state, "game.write" );
    } );
    install_mission_api(
        game,
    [&state]() {
        return state.generation;
    },
    [&state]() {
        return state.world_generation;
    },
    [&state]() {
        require_api_version( state, 5, "game.missions" );
        require_capability( state, "game.read" );
    },
    [&state]() {
        require_api_version( state, 5, "game.missions" );
        require_capability( state, "game.write" );
    } );
    install_crafting_api(
        game,
    [&state]() {
        require_api_version( state, 5, "game.recipes" );
        require_capability( state, "game.read" );
    },
    [&state]() {
        require_api_version( state, 5, "game.crafting" );
        require_capability( state, "game.write" );
    },
    [&state]() {
        return state.accept_actions;
    },
    [&state]() {
        return current_manifest( state ).id;
    } );
    install_world_api(
        game,
    [&state]() {
        return state.generation;
    },
    [&state]() {
        return state.world_generation;
    },
    [&state]() {
        require_api_version( state, 5, "game.world" );
        require_capability( state, "game.read" );
    },
    [&state]() {
        require_api_version( state, 5, "game.world" );
        require_capability( state, "game.write" );
    } );
    install_overmap_api(
        game,
    [&state]() {
        require_api_version( state, 5, "game.overmap" );
        require_capability( state, "game.read" );
    },
    [&state]() {
        require_api_version( state, 5, "game.overmap" );
        require_capability( state, "game.write" );
    } );
    install_horde_api(
        game,
    [&state]() {
        return state.generation;
    },
    [&state]() {
        return state.world_generation;
    },
    [&state]() {
        require_api_version( state, 5, "game.hordes" );
        require_capability( state, "game.read" );
    },
    [&state]() {
        require_api_version( state, 5, "game.hordes" );
        require_capability( state, "game.write" );
    } );
    install_item_api(
        game,
    [&state]() {
        return state.generation;
    },
    [&state]() {
        return state.world_generation;
    },
    [&state]() {
        require_api_version( state, 5, "game.items" );
        require_capability( state, "game.read" );
    },
    [&state]() {
        require_api_version( state, 5, "game.items" );
        require_capability( state, "game.write" );
    } );
    install_binding_catalog_api( game, [&state]() {
        require_api_version( state, 5, "game.api_catalog" );
        require_capability( state, "game.read" );
    } );
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
        require_capability( state, "game.actions.dangerous" );
    }, [&state]() {
        return current_manifest( state ).has_capability(
                   "game.actions.dangerous" );
    }, [&state]() {
        return current_manifest( state ).id;
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
    game.set_function( "runtime_status", [&state]( sol::this_state lua ) {
        return lua_runtime_status( lua, state );
    } );
    sol::table diagnostics = state.lua.create_table();
    diagnostics.set_function(
        "snapshot",
    [&state]( sol::this_state lua ) {
        require_api_version( state, 5, "game.diagnostics" );
        require_capability( state, "game.read" );
        return lua_runtime_diagnostics( lua, state );
    } );
    diagnostics.set_function(
        "recent",
        [&state](
            sol::this_state lua,
    const sol::optional<std::int64_t> &limit ) {
        require_api_version( state, 5, "game.diagnostics" );
        require_capability( state, "game.read" );
        return lua_recent_diagnostics( lua, limit.value_or( 16 ) );
    } );
    game["diagnostics"] = std::move( diagnostics );
    install_i18n_api( state.lua );
    install_registry_api( state.lua, game, [&state]() {
        require_capability( state, "registry.read" );
    }, [&state]() {
        require_api_version( state, 5, "game.definitions" );
        require_capability( state, "registry.read" );
    } );

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

    create_source_environments( state );
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
    if( source_index >= state.source_environments.size() ) {
        throw std::runtime_error( path.string() + ": invalid Lua source environment" );
    }
    sol::set_environment( state.source_environments[source_index], script );
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

page_definition *find_page( const std::string_view id )
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

std::string script_value_type_name( const script_persistent_value &value )
{
    if( std::holds_alternative<bool>( value ) ) {
        return "boolean";
    }
    if( std::holds_alternative<std::int64_t>( value ) ) {
        return "integer";
    }
    if( std::holds_alternative<double>( value ) ) {
        return "float";
    }
    return "string";
}

sol::table custom_event_to_lua( runtime_state &state, const std::string &display_name,
                                const script_value_map &data_values )
{
    sol::table result = state.lua.create_table();
    sol::table data = script_value_map_to_lua( state.lua, data_values );
    sol::table data_types = state.lua.create_table();
    for( const auto &[name, value] : data_values ) {
        data_types[name] = script_value_type_name( value );
    }
    result["type"] = display_name;
    result["turn"] = script_current_turn();
    result["data"] = std::move( data );
    result["data_types"] = std::move( data_types );
    return result;
}

class event_dispatch_scope
{
    public:
        explicit event_dispatch_scope( runtime_state &state ) : state_( state ) {
            if( state_.event_dispatch_depth >= 16 ) {
                throw std::runtime_error( "Lua custom event recursion limit reached" );
            }
            ++state_.event_dispatch_depth;
        }

        event_dispatch_scope( const event_dispatch_scope & ) = delete;
        event_dispatch_scope &operator=( const event_dispatch_scope & ) = delete;

        ~event_dispatch_scope() {
            --state_.event_dispatch_depth;
        }

    private:
        runtime_state &state_;
};

bool dispatch_script_event( runtime_state &state, const std::string_view internal_name,
                            const std::function<sol::table()> &make_payload )
{
    event_dispatch_scope dispatch_scope( state );
    const std::vector<script_event_subscription> handlers =
        state.event_registry.matching( internal_name );
    for( const script_event_subscription &handler : handlers ) {
        if( !state.event_registry.contains( handler.id ) ) {
            continue;
        }
        const auto callback_entry = state.event_callbacks.find( handler.id );
        if( callback_entry == state.event_callbacks.end() ) {
            state.event_registry.unsubscribe_unchecked( handler.id );
            continue;
        }
        sol::protected_function callback = callback_entry->second;
        source_scope source( state, handler.source_index );
        instruction_guard guard( state.lua.lua_state(), callback_instruction_limit );
        const auto started = std::chrono::steady_clock::now();
        const sol::protected_function_result result = callback( make_payload() );
        record_callback_timing(
            state, "event '" + std::string( internal_name ) + "'", started );
        bool continue_dispatch = true;
        if( !result.valid() ) {
            const sol::error error = result;
            record_runtime_error(
                "Lua event handler '" + std::string( internal_name ) + "'", error.what() );
            state.event_registry.unsubscribe_unchecked( handler.id );
            state.event_callbacks.erase( handler.id );
        } else {
            if( result.return_count() > 0 &&
                result.get_type() == sol::type::boolean &&
                !result.get<bool>() ) {
                continue_dispatch = false;
            }
            if( handler.once ) {
                state.event_registry.unsubscribe_unchecked( handler.id );
                state.event_callbacks.erase( handler.id );
            }
        }
        if( !continue_dispatch ) {
            return false;
        }
    }
    return true;
}

bool dispatch_custom_event( runtime_state &state, const std::string &internal_name,
                            const std::string &display_name,
                            const script_value_map &data )
{
    return dispatch_script_event( state, internal_name, [&state, &display_name, &data]() {
        return custom_event_to_lua( state, display_name, data );
    } );
}

bool dispatch_lifecycle_event( runtime_state &state, const std::string &name,
                               const script_value_map &data = {} )
{
    return dispatch_custom_event( state, name, name, data );
}

class hook_dispatch_scope
{
    public:
        explicit hook_dispatch_scope( runtime_state &state ) : state_( state ) {
            if( state_.hook_dispatch_depth >= 16 ) {
                throw std::runtime_error(
                    "Lua hook callback recursion limit reached" );
            }
            ++state_.hook_dispatch_depth;
        }

        hook_dispatch_scope( const hook_dispatch_scope & ) = delete;
        hook_dispatch_scope &operator=( const hook_dispatch_scope & ) = delete;

        ~hook_dispatch_scope() {
            --state_.hook_dispatch_depth;
        }

    private:
        runtime_state &state_;
};

bool dispatch_script_hook(
    runtime_state &state, const std::string_view name,
    const std::function<sol::table()> &make_payload )
{
    const script_hook_spec *spec = find_script_hook_spec( name );
    if( spec == nullptr ) {
        record_runtime_error(
            "Lua hook dispatch",
            "native code requested unknown Lua hook '" +
            std::string( name ) + "'" );
        return true;
    }

    hook_dispatch_scope dispatch_scope( state );
    const std::string registry_name = "hook:" + std::string( name );
    const std::vector<script_event_subscription> handlers =
        state.hook_registry.matching( registry_name );
    bool allowed = true;
    for( const script_event_subscription &handler : handlers ) {
        if( !state.hook_registry.contains( handler.id ) ) {
            continue;
        }
        const auto callback_entry = state.hook_callbacks.find( handler.id );
        if( callback_entry == state.hook_callbacks.end() ||
            handler.source_index >= state.sources.size() ) {
            state.hook_registry.unsubscribe_unchecked( handler.id );
            state.hook_callbacks.erase( handler.id );
            continue;
        }

        bool stop = false;
        const auto started = std::chrono::steady_clock::now();
        try {
            sol::protected_function callback = callback_entry->second;
            source_scope source( state, handler.source_index );
            instruction_guard guard(
                state.lua.lua_state(), callback_instruction_limit );
            sol::table payload = make_payload();
            payload["hook"] = std::string( name );
            payload["mode"] =
                std::string( script_hook_mode_name( spec->mode ) );
            payload["cancellable"] =
                spec->mode == script_hook_mode::intercept;
            const sol::protected_function_result result =
                callback( std::move( payload ) );
            record_callback_timing(
                state, "hook '" + std::string( name ) + "'", started );
            if( !result.valid() ) {
                const sol::error error = result;
                record_runtime_error(
                    "Lua hook handler '" + std::string( name ) + "'",
                    error.what() );
                state.hook_registry.unsubscribe_unchecked( handler.id );
                state.hook_callbacks.erase( handler.id );
                continue;
            }

            if( result.return_count() > 0 ) {
                const sol::type type = result.get_type();
                if( type == sol::type::boolean ) {
                    const bool decision = result.get<bool>();
                    if( spec->mode == script_hook_mode::intercept ) {
                        allowed = decision;
                    }
                    stop = !decision;
                } else if( type == sol::type::table ) {
                    const sol::table decision = result.get<sol::table>();
                    const sol::optional<bool> requested_allow =
                        decision["allow"];
                    if( requested_allow &&
                        spec->mode == script_hook_mode::intercept ) {
                        allowed = *requested_allow;
                    }
                    stop = decision.get_or( "stop", false ) || !allowed;
                } else if( type != sol::type::nil ) {
                    record_runtime_error(
                        "Lua hook handler '" + std::string( name ) + "'",
                        "hook callbacks must return nil, boolean, or a "
                        "decision table" );
                    state.hook_registry.unsubscribe_unchecked( handler.id );
                    state.hook_callbacks.erase( handler.id );
                    continue;
                }
            }
            if( handler.once ) {
                state.hook_registry.unsubscribe_unchecked( handler.id );
                state.hook_callbacks.erase( handler.id );
            }
        } catch( const std::exception &exception ) {
            record_callback_timing(
                state, "hook '" + std::string( name ) + "'", started );
            record_runtime_error(
                "Lua hook handler '" + std::string( name ) + "'",
                exception.what() );
            state.hook_registry.unsubscribe_unchecked( handler.id );
            state.hook_callbacks.erase( handler.id );
        }
        if( stop ) {
            break;
        }
    }
    return allowed;
}

std::vector<std::string_view> hooks_for_event( const event_type type )
{
    switch( type ) {
        case event_type::avatar_dies:
        case event_type::character_dies:
        case event_type::game_avatar_death:
            return { "on_character_death" };
        case event_type::character_gains_effect:
            return { "on_character_effect_added" };
        case event_type::character_loses_effect:
            return { "on_character_effect_removed" };
        case event_type::character_melee_attacks_character:
        case event_type::character_melee_attacks_monster:
            return { "on_creature_melee_attacked" };
        case event_type::character_ranged_attacks_character:
        case event_type::character_ranged_attacks_monster:
            return { "on_shoot" };
        case event_type::game_load:
            return { "on_game_load" };
        case event_type::game_save:
            return { "on_game_save" };
        case event_type::game_begin:
        case event_type::game_start:
            return { "on_game_started" };
        default:
            return {};
    }
}

void runtime_state::notify( const cata::event &event )
{
    const std::string name = io::enum_to_string( event.type() );
    dispatch_script_event( *this, "game:" + name, [this, &event]() {
        return event_to_lua( *this, event );
    } );
    for( const std::string_view hook : hooks_for_event( event.type() ) ) {
        dispatch_script_hook( *this, hook, [this, &event]() {
            return event_to_lua( *this, event );
        } );
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
    const std::shared_ptr<script_ui_context> context =
        std::make_shared<script_ui_context>( *renderer );
    on_out_of_scope invalidate_context( [context]() {
        context->invalidate();
    } );
    source_scope source( *active_state, page->source_index );
    page_scope current_page( *active_state, page->id );
    instruction_guard guard( active_state->lua.lua_state(), callback_instruction_limit );
    const auto started = std::chrono::steady_clock::now();
    const sol::protected_function_result result =
        page->draw( context, parameters_to_lua( *active_state, parameters ) );
    context->invalidate();
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
        if( generation_counter == std::numeric_limits<std::size_t>::max() ) {
            throw std::runtime_error( "Lua runtime generation counter exhausted" );
        }
        const std::size_t candidate_generation = generation_counter + 1;
        auto next = std::make_unique<runtime_state>();
        // Handles created by top-level scripts must carry the generation that
        // this candidate will have after the transactional reload commits.
        next->generation = candidate_generation;
        next->world_generation = world_generation_counter;
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
        initialize_state( *next );

        for( std::size_t index = 0; index < next->sources.size(); ++index ) {
            run_script( *next, next->sources[index].entry, index );
        }

        // Subscribe even when no entry script registered a game event yet.
        // A page, service, scheduler, or lifecycle callback may add its first
        // game-event handler later in the lifetime of this runtime.
        get_event_bus().subscribe( next.get() );
        active_state = std::move( next );
        generation_counter = candidate_generation;
        active_state->accept_actions = true;
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

void run_scheduled_callbacks( runtime_state &state, const std::int64_t now )
{
    const std::vector<scheduled_script_task> due = state.scheduler.take_due( now );
    for( const scheduled_script_task &task : due ) {
        const auto found = state.scheduled_callbacks.find( task.id );
        if( found == state.scheduled_callbacks.end() ) {
            state.scheduler.cancel_unchecked( task.id );
            continue;
        }

        sol::protected_function callback = found->second;
        source_scope source( state, task.source_index );
        instruction_guard guard( state.lua.lua_state(), callback_instruction_limit );
        const auto started = std::chrono::steady_clock::now();
        const sol::protected_function_result result =
            callback( task.id, now, task.due_turn );
        record_callback_timing(
            state, "scheduled callback " + std::to_string( task.id ), started );

        bool keep_repeating = task.interval > 0 && state.scheduler.contains( task.id );
        if( !result.valid() ) {
            const sol::error error = result;
            record_runtime_error(
                "Lua scheduled callback " + std::to_string( task.id ), error.what() );
            keep_repeating = false;
        } else if( result.return_count() > 0 &&
                   result.get_type() == sol::type::boolean &&
                   !result.get<bool>() ) {
            keep_repeating = false;
        }

        if( !keep_repeating ) {
            state.scheduler.cancel_unchecked( task.id );
            state.scheduled_callbacks.erase( task.id );
        }
    }
}

bool mapgen_filter_matches( const mapgen_handler_filter &filter,
                            const mapgendata &data )
{
    if( data.zlevel() < filter.z_min || data.zlevel() > filter.z_max ) {
        return false;
    }
    if( filter.terrain_ids.empty() ) {
        return true;
    }
    const std::string terrain_id = data.terrain_type().id().str();
    return std::binary_search(
               filter.terrain_ids.begin(), filter.terrain_ids.end(),
               terrain_id );
}

void hash_mapgen_byte( std::uint64_t &hash, const std::uint8_t value )
{
    hash ^= value;
    hash *= UINT64_C( 1099511628211 );
}

void hash_mapgen_integer( std::uint64_t &hash, const std::uint64_t value )
{
    for( unsigned int shift = 0; shift < 64; shift += 8 ) {
        hash_mapgen_byte(
            hash, static_cast<std::uint8_t>( value >> shift ) );
    }
}

void hash_mapgen_string(
    std::uint64_t &hash, const std::string_view value )
{
    hash_mapgen_integer( hash, value.size() );
    for( const unsigned char ch : value ) {
        hash_mapgen_byte( hash, ch );
    }
}

std::uint64_t deterministic_mapgen_seed(
    const mapgendata &data, const std::string_view source_id )
{
    std::uint64_t hash = UINT64_C( 1469598103934665603 );
    hash_mapgen_integer( hash, g ? g->get_seed() : 0 );
    hash_mapgen_integer(
        hash, static_cast<std::uint64_t>(
            static_cast<std::int64_t>( data.pos().x() ) ) );
    hash_mapgen_integer(
        hash, static_cast<std::uint64_t>(
            static_cast<std::int64_t>( data.pos().y() ) ) );
    hash_mapgen_integer(
        hash, static_cast<std::uint64_t>(
            static_cast<std::int64_t>( data.pos().z() ) ) );
    hash_mapgen_string( hash, data.terrain_type().id().str() );
    hash_mapgen_string( hash, source_id );
    hash ^= hash >> 30;
    hash *= UINT64_C( 0xbf58476d1ce4e5b9 );
    hash ^= hash >> 27;
    hash *= UINT64_C( 0x94d049bb133111eb );
    return hash ^ ( hash >> 31 );
}

void remove_mapgen_handler(
    runtime_state &state, const std::uint64_t id )
{
    state.mapgen_registry.unsubscribe_unchecked( id );
    state.mapgen_callbacks.erase( id );
    state.mapgen_filters.erase( id );
}

void bootstrap_mapgen_runtime_if_needed()
{
    if( active_state || test_mode || mapgen_bootstrap_attempted ) {
        return;
    }
    mapgen_bootstrap_attempted = true;
    std::string error;
    if( !reload_scripts_with_state( nullptr, nullptr, error ) ) {
        DebugLog( D_WARNING, D_MAP_GEN )
                << "Early Lua mapgen initialization failed: " << error;
    }
}

} // namespace

bool reload_scripts( std::string &error )
{
    // The profile loader is an independent, early Lua sandbox.  A bad profile
    // falls back to compiled defaults and must not invalidate working Mod UI
    // scripts, so only surface its error after a successful script reload.
    std::string profile_error;
    cata::ui::reload_profile( profile_error );
    const bool reloaded = reload_scripts_with_state( nullptr, nullptr, error );
    if( reloaded && active_state ) {
        dispatch_lifecycle_event( *active_state, "ccb.lifecycle.reload" );
    }
    if( reloaded && !profile_error.empty() ) {
        record_runtime_error( "UI profile reload failed", profile_error );
    }
    return reloaded;
}

void on_turn()
{
    if( active_state ) {
        run_scheduled_callbacks( *active_state, script_current_turn() );
    }
}

void dispatch_mapgen_postprocess( mapgendata &data )
{
    if( is_pool_worker_thread() ) {
        return;
    }
    bootstrap_mapgen_runtime_if_needed();
    if( !active_state ) {
        return;
    }

    runtime_state &state = *active_state;
    if( state.mapgen_dispatch_depth >= 4 ) {
        record_runtime_error(
            "Lua mapgen postprocess",
            "Lua mapgen callback recursion limit reached" );
        return;
    }
    ++state.mapgen_dispatch_depth;
    on_out_of_scope restore_depth( [&state]() {
        --state.mapgen_dispatch_depth;
    } );

    const std::vector<script_event_subscription> handlers =
        state.mapgen_registry.matching( "mapgen.postprocess" );
    for( const script_event_subscription &handler : handlers ) {
        if( !state.mapgen_registry.contains( handler.id ) ) {
            continue;
        }
        const auto callback_entry =
            state.mapgen_callbacks.find( handler.id );
        const auto filter_entry =
            state.mapgen_filters.find( handler.id );
        if( callback_entry == state.mapgen_callbacks.end() ||
            filter_entry == state.mapgen_filters.end() ) {
            remove_mapgen_handler( state, handler.id );
            continue;
        }
        if( !mapgen_filter_matches( filter_entry->second, data ) ) {
            continue;
        }
        if( handler.source_index >= state.sources.size() ) {
            record_runtime_error(
                "Lua mapgen postprocess",
                "Lua mapgen handler has an invalid source index" );
            remove_mapgen_handler( state, handler.id );
            continue;
        }

        const script_manifest &manifest =
            state.sources[handler.source_index].manifest;
        const std::shared_ptr<script_mapgen_context> context =
            std::make_shared<script_mapgen_context>(
                data, manifest.has_capability( "game.write" ),
                deterministic_mapgen_seed( data, manifest.id ) );
        on_out_of_scope invalidate_context( [context]() {
            context->invalidate();
        } );
        const auto started = std::chrono::steady_clock::now();
        try {
            sol::protected_function callback = callback_entry->second;
            source_scope source( state, handler.source_index );
            instruction_guard guard(
                state.lua.lua_state(), callback_instruction_limit );
            const sol::protected_function_result result =
                callback( context );
            context->invalidate();
            record_callback_timing(
                state,
                "mapgen postprocess " + std::to_string( handler.id ),
                started );
            if( !result.valid() ) {
                const sol::error error = result;
                record_runtime_error(
                    "Lua mapgen postprocess handler " +
                    std::to_string( handler.id ), error.what() );
                remove_mapgen_handler( state, handler.id );
            } else if( handler.once ) {
                remove_mapgen_handler( state, handler.id );
            }
        } catch( const std::exception &exception ) {
            context->invalidate();
            record_callback_timing(
                state,
                "mapgen postprocess " + std::to_string( handler.id ),
                started );
            record_runtime_error(
                "Lua mapgen postprocess handler " +
                std::to_string( handler.id ), exception.what() );
            remove_mapgen_handler( state, handler.id );
        }
    }
}

void on_world_ready()
{
    mapgen_bootstrap_attempted = true;
    // A save/new-game transition is a runtime boundary, unlike an in-page hot
    // reload.  Never retain callbacks or state belonging to the previous world.
    if( active_state ) {
        active_state->accept_actions = false;
        dispatch_lifecycle_event( *active_state, "ccb.lifecycle.shutdown" );
        active_state.reset();
    }
    if( world_generation_counter == std::numeric_limits<std::size_t>::max() ) {
        world_generation_counter = 1;
    } else {
        ++world_generation_counter;
    }
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
    } else if( active_state ) {
        dispatch_lifecycle_event( *active_state, "ccb.lifecycle.world_ready" );
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
}

bool save_persistent_state( std::string &error )
{
    if( !active_state ) {
        error.clear();
        return true;
    }

    dispatch_lifecycle_event( *active_state, "ccb.lifecycle.before_save" );

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
    dispatch_lifecycle_event(
    *active_state, "ccb.lifecycle.after_save", {
        { "success", errors.empty() },
        { "error", error }
    } );
    return errors.empty();
}

runtime_status status()
{
    runtime_status result;
    result.loaded = active_state != nullptr;
    result.last_error = last_runtime_error;
    if( active_state ) {
        result.generation = active_state->generation;
        result.world_generation = active_state->world_generation;
        result.page_count = active_state->pages.size();
        result.event_handler_count = active_state->event_registry.size();
        result.mapgen_handler_count =
            active_state->mapgen_registry.size();
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
        install_guarded_protected_calls( lua.lua_state() );
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
    if( active_state ) {
        active_state->accept_actions = false;
        dispatch_lifecycle_event( *active_state, "ccb.lifecycle.shutdown" );
        active_state.reset();
    }
    clear_actions();
    clear_navigation_requests();
    last_runtime_error.clear();
    diagnostic_history.clear();
    mapgen_bootstrap_attempted = false;
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

bool show_page( const std::string_view page_id )
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
