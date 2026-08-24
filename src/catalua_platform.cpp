#include "catalua_platform.h"

#include <algorithm>
#include <array>
#include <cctype>
#include <cstdint>
#include <iterator>
#include <limits>
#include <memory>
#include <optional>
#include <set>
#include <sstream>
#include <stdexcept>
#include <string_view>
#include <system_error>
#include <utility>

#include "debug.h"

#if defined(CATA_ENABLE_LUA_UI) && CATA_ENABLE_LUA_UI

#include "catalua_platform_runtime.h"
#include "catalua_sol.h"

namespace cata::lua_platform
{

namespace
{

namespace fs = std::filesystem;

struct runtime_state {
    std::string id;
    fs::path root;
    fs::path entry;
    std::unique_ptr<sol::state> lua;
    std::shared_ptr<runtime> platform;
};

std::vector<runtime_state> active_states;
std::vector<runtime_state> prepared_states;
bool candidate_is_prepared = false;
bool candidate_content_is_applied = false;
bool candidate_content_is_finalized = false;
std::size_t generation_counter = 0;

bool path_is_within( const fs::path &path, const fs::path &directory )
{
    auto path_it = path.begin();
    auto directory_it = directory.begin();
    while( directory_it != directory.end() ) {
        if( path_it == path.end() || *path_it != *directory_it ) {
            return false;
        }
        ++path_it;
        ++directory_it;
    }
    return true;
}

bool is_safe_module_name( const std::string_view name )
{
    if( name.empty() || name.size() > 256 || name.front() == '.' ||
        name.back() == '.' || name.find( ".." ) != std::string_view::npos ) {
        return false;
    }
    return std::all_of( name.begin(), name.end(), []( const unsigned char value ) {
        return std::isalnum( value ) != 0 || value == '_' || value == '-' || value == '.';
    } );
}

std::optional<fs::path> resolve_local_module( const fs::path &root,
        const std::string &module_name )
{
    if( !is_safe_module_name( module_name ) ) {
        return std::nullopt;
    }
    std::string relative = module_name;
    std::replace( relative.begin(), relative.end(), '.',
                  static_cast<char>( fs::path::preferred_separator ) );
    const std::array<fs::path, 2> candidates = {
        root / ( relative + ".lua" ),
        root / relative / "init.lua"
    };
    for( const fs::path &candidate : candidates ) {
        std::error_code filesystem_error;
        const fs::path canonical_candidate = fs::canonical( candidate, filesystem_error );
        if( !filesystem_error && path_is_within( canonical_candidate, root ) &&
            fs::is_regular_file( canonical_candidate, filesystem_error ) && !filesystem_error ) {
            return canonical_candidate;
        }
    }
    return std::nullopt;
}

mod_source resolve_source( const mod_source &source )
{
    if( source.id.empty() || source.id.size() > 256 ||
        source.id.find( '#' ) != std::string::npos ||
        source.id.find( '\0' ) != std::string::npos ) {
        throw std::runtime_error( "Invalid Lua-first Mod id '" + source.id + "'" );
    }

    std::error_code filesystem_error;
    const fs::path root = fs::canonical( source.root, filesystem_error );
    if( filesystem_error || !fs::is_directory( root, filesystem_error ) || filesystem_error ) {
        throw std::runtime_error( "Cannot resolve Lua-first Mod root for '" + source.id + "'" );
    }
    fs::path entry = fs::canonical( source.entry, filesystem_error );
    if( !source.entry.is_absolute() &&
        ( filesystem_error || !path_is_within( entry, root ) ) ) {
        filesystem_error.clear();
        entry = fs::canonical( root / source.entry, filesystem_error );
    }
    if( filesystem_error || !path_is_within( entry, root ) ) {
        throw std::runtime_error( "Lua-first Mod entry for '" + source.id +
                                  "' escapes its root or cannot be resolved" );
    }
    if( !fs::is_regular_file( entry, filesystem_error ) || filesystem_error ) {
        throw std::runtime_error( "Lua-first Mod entry for '" + source.id +
                                  "' is not a regular file" );
    }
    return { source.id, root, entry };
}

template<typename T>
void set_optional_field( const sol::table &values, const char *key, T &field, bool &was_set )
{
    const sol::object value = values.raw_get<sol::object>( key );
    if( !value.valid() || value.get_type() == sol::type::nil ) {
        return;
    }
    field = value.as<T>();
    was_set = true;
}

std::vector<std::string> bounded_string_array( const sol::table &values,
        const std::string_view field )
{
    constexpr std::size_t maximum_entries = 256;
    const std::size_t count = values.size();
    if( count > maximum_entries ) {
        throw std::runtime_error( "ModDefinition " + std::string( field ) +
                                  " exceed 256 entries" );
    }
    std::size_t observed = 0;
    for( const auto &entry : values ) {
        const sol::object key = entry.first;
        if( !key.is<lua_Integer>() ) {
            throw std::runtime_error(
                "ModDefinition " + std::string( field ) + " must be a dense array" );
        }
        const lua_Integer index = key.as<lua_Integer>();
        if( index < 1 || static_cast<std::uint64_t>( index ) > count ) {
            throw std::runtime_error(
                "ModDefinition " + std::string( field ) + " must be a dense array" );
        }
        ++observed;
    }
    if( observed != count ) {
        throw std::runtime_error(
            "ModDefinition " + std::string( field ) + " must be a dense array" );
    }
    std::vector<std::string> result;
    result.reserve( count );
    for( std::size_t index = 1; index <= count; ++index ) {
        const sol::object entry = values.raw_get<sol::object>( index );
        if( entry.get_type() != sol::type::string ) {
            throw std::runtime_error(
                "ModDefinition " + std::string( field ) + " may only contain strings" );
        }
        result.push_back( entry.as<std::string>() );
    }
    return result;
}

mod_definition make_mod_definition( const sol::table &values )
{
    mod_definition result;
    set_optional_field( values, "id", result.id, result.id_set );
    set_optional_field( values, "name", result.name, result.name_set );
    set_optional_field( values, "version", result.version, result.version_set );
    set_optional_field( values, "entry", result.entry, result.entry_set );
    set_optional_field( values, "description", result.description,
                        result.description_set );
    set_optional_field( values, "category", result.category, result.category_set );
    set_optional_field( values, "core", result.core, result.core_set );
    const sol::object dependencies = values.raw_get<sol::object>( "dependencies" );
    if( dependencies.valid() && dependencies.get_type() != sol::type::nil ) {
        if( dependencies.get_type() != sol::type::table ) {
            throw std::runtime_error(
                "ModDefinition dependencies must be a dense array" );
        }
        result.dependencies = bounded_string_array(
                                  dependencies.as<sol::table>(), "dependencies" );
        result.dependencies_set = true;
    }
    const sol::object authors = values.raw_get<sol::object>( "authors" );
    if( authors.valid() && authors.get_type() != sol::type::nil ) {
        if( authors.get_type() != sol::type::table ) {
            throw std::runtime_error(
                "ModDefinition authors must be a dense array" );
        }
        result.authors = bounded_string_array(
                             authors.as<sol::table>(), "authors" );
        result.authors_set = true;
    }
    return result;
}

void install_mod_definition( sol::table &ccb )
{
    ccb.new_usertype<mod_definition>(
        "_ModDefinitionNative", sol::no_constructor,
        "id", sol::property(
    []( const mod_definition & definition ) {
        return definition.id;
    },
    []( mod_definition & definition, std::string value ) {
        definition.id = std::move( value );
        definition.id_set = true;
    } ),
    "name", sol::property(
    []( const mod_definition & definition ) {
        return definition.name;
    },
    []( mod_definition & definition, std::string value ) {
        definition.name = std::move( value );
        definition.name_set = true;
    } ),
    "version", sol::property(
    []( const mod_definition & definition ) {
        return definition.version;
    },
    []( mod_definition & definition, std::string value ) {
        definition.version = std::move( value );
        definition.version_set = true;
    } ),
    "entry", sol::property(
    []( const mod_definition & definition ) {
        return definition.entry;
    },
    []( mod_definition & definition, std::string value ) {
        definition.entry = std::move( value );
        definition.entry_set = true;
    } ),
    "dependencies", sol::property(
    []( const mod_definition & definition ) {
        return definition.dependencies;
    },
    []( mod_definition & definition, const sol::table & value ) {
        definition.dependencies = bounded_string_array( value, "dependencies" );
        definition.dependencies_set = true;
    } ),
    "authors", sol::property(
    []( const mod_definition & definition ) {
        return definition.authors;
    },
    []( mod_definition & definition, const sol::table & value ) {
        definition.authors = bounded_string_array( value, "authors" );
        definition.authors_set = true;
    } ),
    "description", sol::property(
    []( const mod_definition & definition ) {
        return definition.description;
    },
    []( mod_definition & definition, std::string value ) {
        definition.description = std::move( value );
        definition.description_set = true;
    } ),
    "category", sol::property(
    []( const mod_definition & definition ) {
        return definition.category;
    },
    []( mod_definition & definition, std::string value ) {
        definition.category = std::move( value );
        definition.category_set = true;
    } ),
    "core", sol::property(
    []( const mod_definition & definition ) {
        return definition.core;
    },
    []( mod_definition & definition, bool value ) {
        definition.core = value;
        definition.core_set = true;
    } ) );
    ccb["_ModDefinitionNative"] = sol::lua_nil;
    ccb.set_function( "ModDefinition", []( const sol::table & values ) {
        return make_mod_definition( values );
    } );
}

struct file_execution_result {
    int return_count = 0;
    std::optional<sol::object> first;
};

file_execution_result execute_file( sol::state &lua, const fs::path &path )
{
    sol::load_result loaded = lua.load_file( path.string() );
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
    file_execution_result snapshot;
    snapshot.return_count = result.return_count();
    if( snapshot.return_count > 0 ) {
        // protected_function_result owns stack slots that cannot safely cross
        // this helper boundary.  Preserve the first return in the registry.
        snapshot.first = result.get<sol::object>();
    }
    return snapshot;
}

sol::object require_local_module( sol::state &lua, const fs::path &root,
                                  const std::string &module_name )
{
    sol::table package = lua["package"];
    sol::table loaded_modules = package["loaded"];
    const sol::object cached = loaded_modules.raw_get<sol::object>( module_name );
    if( cached.valid() && cached.get_type() != sol::type::nil &&
        ( !cached.is<bool>() || cached.as<bool>() ) ) {
        return cached;
    }
    if( !is_safe_module_name( module_name ) ) {
        throw std::runtime_error( "invalid local module name '" + module_name + "'" );
    }
    const std::optional<fs::path> path = resolve_local_module( root, module_name );
    if( !path ) {
        throw std::runtime_error( "module '" + module_name +
                                  "' was not found inside the Mod root" );
    }

    // Match Lua require's recursive-load behavior while keeping resolution
    // independent from author-mutated package.path/searchers.
    loaded_modules[module_name] = true;
    try {
        const file_execution_result execution = execute_file( lua, *path );
        sol::object exported = loaded_modules.raw_get<sol::object>( module_name );
        if( execution.first && execution.first->get_type() != sol::type::nil ) {
            exported = *execution.first;
        } else if( !exported.valid() || exported.get_type() == sol::type::nil ) {
            exported = sol::make_object( lua, true );
        }
        loaded_modules[module_name] = exported;
        return exported;
    } catch( ... ) {
        loaded_modules[module_name] = sol::make_object( lua, sol::lua_nil );
        throw;
    }
}

void initialize_state( sol::state &lua, const fs::path &requested_root,
                       const std::shared_ptr<runtime> &platform = nullptr )
{
    // Platform Mods are trusted extensions, not v5 capability-sandboxed scripts.
    lua.open_libraries();

    std::error_code filesystem_error;
    const fs::path root = fs::canonical( requested_root, filesystem_error );
    if( filesystem_error || !fs::is_directory( root, filesystem_error ) || filesystem_error ) {
        throw std::runtime_error( "Cannot resolve Lua-first Mod root '" +
                                  requested_root.generic_u8string() + "'" );
    }

    sol::table ccb = lua.create_table();
    ccb["platform_version"] = platform_version;
    install_mod_definition( ccb );
    if( platform ) {
        install_runtime_api( platform, lua, ccb );
    }

    sol::table package = lua["package"];
    sol::table loaded = package["loaded"];
    loaded["ccb"] = ccb;

    package["path"] = ( root / "?.lua" ).generic_u8string() + ";" +
                      ( root / "?" / "init.lua" ).generic_u8string();
    package["cpath"] = std::string();
    lua.set_function( "require", [&lua, root]( const std::string & module_name ) {
        return require_local_module( lua, root, module_name );
    } );
}

runtime_state load_source( const mod_source &source )
{
    const mod_source resolved = resolve_source( source );
    DebugLog( D_WARNING, D_MAIN )
            << "Executing trusted Lua-first Mod entry with full process privileges: "
            << resolved.entry.generic_u8string();
    runtime_state result;
    result.id = resolved.id;
    result.root = resolved.root;
    result.entry = resolved.entry;
    result.lua = std::make_unique<sol::state>();
    result.platform = make_runtime( resolved.id, generation_counter + 1,
                                    *result.lua, resolved.root );
    initialize_state( *result.lua, resolved.root, result.platform );
    execute_file( *result.lua, resolved.entry );
    return result;
}

} // namespace

bool read_mod_definition( const fs::path &root, mod_definition &result, std::string &error )
{
    try {
        std::error_code filesystem_error;
        const fs::path canonical_root = fs::canonical( root, filesystem_error );
        if( filesystem_error || !fs::is_directory( canonical_root, filesystem_error ) ||
            filesystem_error ) {
            throw std::runtime_error( "Cannot resolve Lua-first Mod root '" +
                                      root.generic_u8string() + "'" );
        }
        const fs::path path = fs::canonical( canonical_root / "mod.lua", filesystem_error );
        if( filesystem_error || !path_is_within( path, canonical_root ) ||
            !fs::is_regular_file( path, filesystem_error ) || filesystem_error ) {
            throw std::runtime_error( "Lua-first mod.lua escapes its Mod root or is not a regular file" );
        }
        DebugLog( D_WARNING, D_MAIN )
                << "Executing trusted Lua-first Mod metadata with full process privileges: "
                << path.generic_u8string();
        sol::state lua;
        initialize_state( lua, canonical_root );
        const file_execution_result execution = execute_file( lua, path );
        if( execution.return_count != 1 ) {
            error = path.generic_u8string() +
                    ": expected exactly one ccb.ModDefinition return value";
            return false;
        }
        const sol::object &value = *execution.first;
        if( !value.is<mod_definition>() ) {
            error = path.generic_u8string() +
                    ": expected a native ccb.ModDefinition return value";
            return false;
        }
        result = value.as<mod_definition>();
        error.clear();
        return true;
    } catch( const std::exception &exception ) {
        error = exception.what();
        return false;
    }
}

bool prepare_mods( const std::vector<mod_source> &sources, std::string &error )
{
    discard_prepared_mods();
    std::vector<runtime_state> candidate;
    candidate.reserve( sources.size() );
    try {
        if( generation_counter == std::numeric_limits<std::size_t>::max() ) {
            throw std::runtime_error( "Lua-first Platform generation space is exhausted" );
        }
        std::set<std::string> seen_ids;
        for( const mod_source &source : sources ) {
            if( !seen_ids.insert( source.id ).second ) {
                throw std::runtime_error( "Duplicate Lua-first Mod id '" + source.id + "'" );
            }
            candidate.push_back( load_source( source ) );
            if( !validate_runtime( candidate.back().platform, false, error ) ) {
                throw std::runtime_error( error );
            }
        }
    } catch( const std::exception &exception ) {
        error = exception.what();
        return false;
    }
    prepared_states = std::move( candidate );
    candidate_is_prepared = true;
    candidate_content_is_applied = false;
    candidate_content_is_finalized = false;
    error.clear();
    return true;
}

bool apply_prepared_content( std::string &error )
{
    if( !candidate_is_prepared ) {
        error = "No Lua-first Platform candidate is prepared";
        return false;
    }
    if( candidate_content_is_applied ) {
        error.clear();
        return true;
    }
    std::vector<std::shared_ptr<runtime>> applied;
    for( runtime_state &state : prepared_states ) {
        if( !validate_runtime( state.platform, true, error ) ) {
            if( error.empty() ) {
                error = "Lua-first Platform candidate failed engine-state validation "
                        "without a diagnostic";
            }
            for( auto it = applied.rbegin(); it != applied.rend(); ++it ) {
                rollback_runtime_content( *it );
            }
            return false;
        }
        if( !apply_runtime_content( state.platform, error ) ) {
            if( error.empty() ) {
                error = "Lua-first Platform candidate failed content application "
                        "without a diagnostic";
            }
            for( auto it = applied.rbegin(); it != applied.rend(); ++it ) {
                rollback_runtime_content( *it );
            }
            return false;
        }
        applied.push_back( state.platform );
    }
    candidate_content_is_applied = true;
    candidate_content_is_finalized = false;
    error.clear();
    return true;
}

bool validate_finalized_prepared_content( std::string &error )
{
    if( !candidate_is_prepared || !candidate_content_is_applied ) {
        error = "No applied Lua-first Platform candidate is prepared";
        return false;
    }
    for( const runtime_state &state : prepared_states ) {
        if( !validate_finalized_runtime_content( state.platform, error ) ) {
            return false;
        }
    }
    candidate_content_is_finalized = true;
    error.clear();
    return true;
}

void commit_prepared_mods()
{
    if( !candidate_is_prepared ) {
        return;
    }
    if( !candidate_content_is_applied ) {
        std::string error;
        if( !apply_prepared_content( error ) ) {
            DebugLog( D_ERROR, D_MAIN ) << "Cannot commit Lua-first Platform candidate: " << error;
            discard_prepared_mods();
            return;
        }
    }
    if( !candidate_content_is_finalized ) {
        DebugLog( D_ERROR, D_MAIN )
                << "Cannot commit Lua-first Platform candidate before global finalization validation";
        discard_prepared_mods();
        return;
    }
    clear_active_runtimes();
    for( const runtime_state &state : prepared_states ) {
        commit_runtime( state.platform );
    }
    active_states = std::move( prepared_states );
    std::vector<std::shared_ptr<runtime>> active;
    active.reserve( active_states.size() );
    for( const runtime_state &state : active_states ) {
        active.push_back( state.platform );
    }
    set_active_runtimes( active );
    ++generation_counter;
    prepared_states.clear();
    candidate_is_prepared = false;
    candidate_content_is_applied = false;
    candidate_content_is_finalized = false;
}

void discard_prepared_mods()
{
    for( auto it = prepared_states.rbegin(); it != prepared_states.rend(); ++it ) {
        discard_runtime( it->platform );
    }
    prepared_states.clear();
    candidate_is_prepared = false;
    candidate_content_is_applied = false;
    candidate_content_is_finalized = false;
}

bool validate_mods( const std::vector<mod_source> &sources, std::string &error )
{
    const bool valid = prepare_mods( sources, error );
    discard_prepared_mods();
    return valid;
}

void shutdown()
{
    discard_prepared_mods();
    clear_active_runtimes();
    active_states.clear();
}

std::vector<std::string> loaded_mod_ids()
{
    std::vector<std::string> result;
    result.reserve( active_states.size() );
    std::transform( active_states.begin(), active_states.end(), std::back_inserter( result ),
    []( const runtime_state & state ) {
        return state.id;
    } );
    return result;
}

bool has_primary_mapgen_for( const std::string_view terrain_id )
{
    const std::vector<runtime_state> &states = candidate_is_prepared ?
            prepared_states : active_states;
    return std::any_of( states.begin(), states.end(),
    [terrain_id]( const runtime_state & state ) {
        return runtime_has_primary_mapgen_for( state.platform, terrain_id );
    } );
}

std::string prepared_content_fingerprint()
{
    std::ostringstream joined;
    for( const runtime_state &state : prepared_states ) {
        joined << state.id.size() << ':' << state.id << ':'
               << runtime_fingerprint( state.platform ) << ';';
    }
    return joined.str();
}

bool reload_active_mods( std::string &error )
{
    if( active_states.empty() ) {
        error.clear();
        return true;
    }

    std::ostringstream active_fingerprint;
    std::vector<mod_source> sources;
    sources.reserve( active_states.size() );
    for( const runtime_state &state : active_states ) {
        active_fingerprint << state.id.size() << ':' << state.id << ':'
                           << runtime_fingerprint( state.platform ) << ';';
        sources.push_back( { state.id, state.root, state.entry } );
    }

    if( !prepare_mods( sources, error ) ) {
        return false;
    }
    if( prepared_content_fingerprint() != active_fingerprint.str() ) {
        discard_prepared_mods();
        error = "requires_full_data_reload: Lua-first static content changed";
        return false;
    }

    std::vector<std::shared_ptr<runtime>> replacement;
    replacement.reserve( prepared_states.size() );
    for( const runtime_state &state : prepared_states ) {
        seal_runtime_content( state.platform );
        replacement.push_back( state.platform );
    }
    hot_swap_active_runtimes( replacement );
    active_states = std::move( prepared_states );
    ++generation_counter;
    prepared_states.clear();
    candidate_is_prepared = false;
    candidate_content_is_applied = false;
    candidate_content_is_finalized = false;
    error.clear();
    return true;
}

void on_world_ready( bool new_game )
{
    runtime_world_ready( new_game );
}

void before_save()
{
    runtime_before_save();
}

bool save_persistent_state( std::string &error )
{
    return runtime_save( error );
}

void after_save( bool success, const std::string &error )
{
    runtime_after_save( success, error );
}

void on_turn()
{
    runtime_process_tasks();
}

} // namespace cata::lua_platform

#else // CATA_ENABLE_LUA_UI

namespace cata::lua_platform
{

namespace
{

constexpr const char *disabled_error = "Lua-first Platform is not enabled in this build";

} // namespace

bool read_mod_definition( const std::filesystem::path &, mod_definition &, std::string &error )
{
    error = disabled_error;
    return false;
}

bool prepare_mods( const std::vector<mod_source> &sources, std::string &error )
{
    if( sources.empty() ) {
        error.clear();
        return true;
    }
    error = disabled_error;
    return false;
}

bool apply_prepared_content( std::string &error )
{
    error.clear();
    return true;
}

bool validate_finalized_prepared_content( std::string &error )
{
    error.clear();
    return true;
}

void commit_prepared_mods()
{
}

void discard_prepared_mods()
{
}

bool validate_mods( const std::vector<mod_source> &sources, std::string &error )
{
    return prepare_mods( sources, error );
}

void shutdown()
{
}

std::vector<std::string> loaded_mod_ids()
{
    return {};
}

bool has_primary_mapgen_for( std::string_view )
{
    return false;
}

std::string prepared_content_fingerprint()
{
    return {};
}

bool reload_active_mods( std::string &error )
{
    error.clear();
    return true;
}

void on_world_ready( bool )
{
}

void before_save()
{
}

bool save_persistent_state( std::string &error )
{
    error.clear();
    return true;
}

void after_save( bool, const std::string & )
{
}

void on_turn()
{
}

} // namespace cata::lua_platform

#endif // CATA_ENABLE_LUA_UI
