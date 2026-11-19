#include "lua_platform_loader.h"

#include <algorithm>
#include <array>
#include <cmath>
#include <cstddef>
#include <cstdint>
#include <exception>
#include <fstream>
#include <iomanip>
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

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#ifdef __clang__
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wold-style-cast"
#endif
#if defined(__GNUC__) && !defined(__clang__)
    #pragma GCC diagnostic push
    #pragma GCC diagnostic ignored "-Wold-style-cast"
#endif
extern "C" {
#include <lua.h>
}
#ifdef __clang__
    #pragma clang diagnostic pop
#endif
#if defined(__GNUC__) && !defined(__clang__)
    #pragma GCC diagnostic pop
#endif

#include "lua_platform_content_text.h"
#include "lua_platform_runtime.h"
#include "lua_platform_runtime_internal.h"
#include "lua_platform_sol.h"
#include "cata_scope_helpers.h"
#include "catacharset.h"
#include "native_file_path.h"
#include "generic_factory.h"
#include "item_factory.h"
#include "itype.h"
#include "json.h"
#include "json_loader.h"
#include "mapgen.h"
#include "omdata.h"
#include "output.h"
#include "recipe_dictionary.h"
#include <functional>

namespace cata::lua_platform
{

namespace
{

namespace fs = std::filesystem;

struct runtime_state {
    std::string id;
    fs::path root;
    fs::path entry;
    mod_source_type type = mod_source_type::mod;
    std::unique_ptr<sol::state> lua;
    std::shared_ptr<runtime> platform;
    std::shared_ptr<const std::set<std::string>> selected_mod_ids;
};

std::vector<runtime_state> active_states;
std::vector<runtime_state> prepared_states;
bool candidate_is_prepared = false;
bool candidate_content_is_applied = false;
bool candidate_content_is_finalized = false;
bool script_reload_in_progress = false;
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

std::optional<fs::path> resolve_local_module( const fs::path &root,
        const std::string &module_name )
{
    // This is a preferred search path, not a module-name permission filter.
    // Keep ordinary Lua names, including UTF-8 and repeated dot separators.
    if( module_name.empty() || module_name.find( '\0' ) != std::string::npos ) {
        return std::nullopt;
    }
    std::string relative = module_name;
    std::replace( relative.begin(), relative.end(), '.',
                  static_cast<char>( fs::path::preferred_separator ) );
    const fs::path relative_path = fs::u8path( relative );
    if( relative_path.is_absolute() || relative_path.has_root_name() ) {
        // Absolute names belong to the caller's ordinary package searchers.
        return std::nullopt;
    }
    const std::array<fs::path, 2> candidates = {
        root / fs::u8path( relative + ".lua" ),
        root / relative_path / fs::u8path( "init.lua" )
    };
    for( const fs::path &candidate : candidates ) {
        std::error_code filesystem_error;
        const fs::path canonical_candidate = fs::canonical( candidate, filesystem_error );
        if( !filesystem_error &&
            fs::is_regular_file( canonical_candidate, filesystem_error ) && !filesystem_error ) {
            return canonical_candidate;
        }
    }
    return std::nullopt;
}

mod_source resolve_source( const mod_source &source )
{
    const auto valid_mod_id = []( const std::string_view id ) {
        return !id.empty() && id.size() <= 256 &&
               id.find( '#' ) == std::string_view::npos &&
               id.find( '\0' ) == std::string_view::npos;
    };
    const std::string_view id = source.id;
    const std::size_t separator = id.find( '#' );
    const bool valid_id = source.type == mod_source_type::interaction_content ?
                          separator != std::string_view::npos && valid_mod_id( id.substr( 0, separator ) ) &&
                          valid_mod_id( id.substr( separator + 1 ) ) :
                          valid_mod_id( id );
    if( !valid_id ) {
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
    return { source.id, root, entry, source.type };
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

std::size_t checked_dense_array_size( const sol::table &values, const std::string &label,
                                     std::size_t maximum_entries )
{
    const std::size_t count = values.size();
    if( count > maximum_entries ) {
        throw std::runtime_error( label + " exceed " + std::to_string( maximum_entries ) + " entries" );
    }
    std::size_t observed = 0;
    for( const auto &entry : values ) {
        const sol::object key = entry.first;
        if( !key.is<lua_Integer>() ) {
            throw std::runtime_error( label + " must be a dense array" );
        }
        const lua_Integer index = key.as<lua_Integer>();
        if( index < 1 || static_cast<std::uint64_t>( index ) > count ) {
            throw std::runtime_error( label + " must be a dense array" );
        }
        ++observed;
    }
    if( observed != count ) {
        throw std::runtime_error( label + " must be a dense array" );
    }
    return count;
}

std::vector<std::string> bounded_string_array( const sol::table &values,
        const std::string_view field, const std::size_t maximum_entries = 256,
        const std::string_view context = "ModDefinition" )
{
    const std::string label = std::string( context ) + " " + std::string( field );
    const std::size_t count = checked_dense_array_size( values, label, maximum_entries );
    std::vector<std::string> result;
    result.reserve( count );
    for( std::size_t index = 1; index <= count; ++index ) {
        const sol::object entry = values.raw_get<sol::object>( index );
        if( entry.get_type() != sol::type::string ) {
            throw std::runtime_error( label + " may only contain strings" );
        }
        result.push_back( entry.as<std::string>() );
    }
    return result;
}

mod_world_options read_world_options( const sol::table &values )
{
    mod_world_options result;
    for( const auto &[key, value] : values ) {
        if( key.get_type() != sol::type::string ) {
            throw std::runtime_error( "ModDefinition world_options keys must be strings" );
        }
        const std::string name = key.as<std::string>();
        if( name.empty() || name.find( '\0' ) != std::string::npos ) {
            throw std::runtime_error( "ModDefinition world_options requires valid option names" );
        }
        if( value.get_type() == sol::type::boolean ) {
            result.emplace( name, value.as<bool>() );
        } else if( value.get_type() == sol::type::string ) {
            result.emplace( name, value.as<std::string>() );
        } else if( value.get_type() == sol::type::number ) {
            lua_State *state = value.lua_state();
            value.push();
            const bool integer = lua_isinteger( state, -1 );
            lua_pop( state, 1 );
            const double number = value.as<double>();
            if( integer && number >= std::numeric_limits<int>::min() &&
                number <= std::numeric_limits<int>::max() ) {
                result.emplace( name, static_cast<int>( number ) );
            } else if( !integer && std::isfinite( number ) &&
                       std::abs( number ) <= std::numeric_limits<float>::max() ) {
                result.emplace( name, static_cast<float>( number ) );
            } else {
                throw std::runtime_error( "ModDefinition world option '" + name +
                                          "' is outside the native numeric range" );
            }
        } else {
            throw std::runtime_error( "ModDefinition world option '" + name +
                                      "' must be a boolean, number or string" );
        }
    }
    return result;
}

mod_interaction_world_options read_interaction_world_options( const sol::table &values )
{
    mod_interaction_world_options result;
    for( const auto &[key, value] : values ) {
        if( key.get_type() != sol::type::string || value.get_type() != sol::type::table ) {
            throw std::runtime_error( "ModDefinition interaction_world_options expects Mod ids and option tables" );
        }
        const std::string companion = key.as<std::string>();
        if( companion.empty() || companion.size() > 256 ||
            companion.find( '\0' ) != std::string::npos || companion.find( '#' ) != std::string::npos ) {
            throw std::runtime_error( "ModDefinition interaction_world_options requires valid Mod ids" );
        }
        result.emplace( companion, read_world_options( value.as<sol::table>() ) );
    }
    return result;
}

sol::table write_world_options( sol::state_view lua, const mod_world_options &options )
{
    sol::table result = lua.create_table();
    for( const auto &option : options ) {
        std::visit( [&]( const auto & value ) {
            result[option.first] = value;
        }, option.second );
    }
    return result;
}

void set_mod_text( const sol::object &value, const char *key, std::string &raw,
                   std::optional<translation> &localized, bool &was_set )
{
    if( !value.valid() || value.get_type() == sol::type::nil ) {
        return;
    }
    const detail::authored_text text = detail::read_singular_text( value, {}, key );
    raw = text.raw;
    localized = text.translated ? std::optional<translation>( text.native() ) : std::nullopt;
    was_set = true;
}

std::optional<std::vector<std::string>> read_metadata_array( const sol::table &values,
        const char *key )
{
    const sol::object value = values.raw_get<sol::object>( key );
    if( !value.valid() || value.get_type() == sol::type::nil ) {
        return std::nullopt;
    }
    if( value.get_type() != sol::type::table ) {
        throw std::runtime_error( std::string( "ModDefinition " ) + key + " must be a dense array" );
    }
    return bounded_string_array( value.as<sol::table>(), key );
}

mod_definition make_mod_definition( const sol::table &values )
{
    mod_definition result;
    set_optional_field( values, "id", result.id, result.id_set );
    set_mod_text( values.raw_get<sol::object>( "name" ), "ModDefinition name",
                  result.name, result.localized_name, result.name_set );
    set_optional_field( values, "version", result.version, result.version_set );
    set_optional_field( values, "entry", result.entry, result.entry_set );
    set_mod_text( values.raw_get<sol::object>( "description" ), "ModDefinition description",
                  result.description, result.localized_description, result.description_set );
    set_optional_field( values, "category", result.category, result.category_set );
    set_optional_field( values, "core", result.core, result.core_set );
    result.load_with_data = values.get_or( "load_with_data", false );
    result.ordered_data_files = values.get_or( "ordered_data_files", false );
    const sol::object world_options = values.raw_get<sol::object>( "world_options" );
    if( world_options.valid() && world_options.get_type() != sol::type::nil ) {
        if( world_options.get_type() != sol::type::table ) {
            throw std::runtime_error( "ModDefinition world_options must be a table" );
        }
        result.world_options = read_world_options( world_options.as<sol::table>() );
    }
    const sol::object interactions = values.raw_get<sol::object>( "interaction_world_options" );
    if( interactions.valid() && interactions.get_type() != sol::type::nil ) {
        if( interactions.get_type() != sol::type::table ) {
            throw std::runtime_error( "ModDefinition interaction_world_options must be a table" );
        }
        result.interaction_world_options =
            read_interaction_world_options( interactions.as<sol::table>() );
    }
    if( auto dependencies = read_metadata_array( values, "dependencies" ) ) {
        result.dependencies = std::move( *dependencies );
        result.dependencies_set = true;
    }
    if( auto authors = read_metadata_array( values, "authors" ) ) {
        result.authors = std::move( *authors );
        result.authors_set = true;
    }
    result.conflicts = read_metadata_array( values, "conflicts" );
    result.maintainers = read_metadata_array( values, "maintainers" );
    result.loading_images = read_metadata_array( values, "loading_images" );
    if( const auto disabled = values.get<sol::optional<bool>>( "disable_other_loading_screens" ) ) {
        result.disable_other_loading_screens = *disabled;
    }
    if( const auto obsolete = values.get<sol::optional<bool>>( "obsolete" ) ) {
        result.obsolete = *obsolete;
    }
    return result;
}

void install_mod_definition( sol::table &ccb )
{
    ccb.new_usertype<detail::localized_text>( "LocalizedText", sol::no_constructor );
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
    []( mod_definition & definition, const sol::object & value ) {
        set_mod_text( value, "ModDefinition name", definition.name, definition.localized_name,
                      definition.name_set );
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
    []( mod_definition & definition, const sol::object & value ) {
        set_mod_text( value, "ModDefinition description", definition.description,
                      definition.localized_description, definition.description_set );
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
    } ),
    "conflicts", sol::property(
    []( const mod_definition & definition ) {
        return definition.conflicts.value_or( std::vector<std::string>() );
    },
    []( mod_definition & definition, const sol::table & value ) {
        definition.conflicts = bounded_string_array( value, "conflicts" );
    } ),
    "maintainers", sol::property(
    []( const mod_definition & definition ) {
        return definition.maintainers.value_or( std::vector<std::string>() );
    },
    []( mod_definition & definition, const sol::table & value ) {
        definition.maintainers = bounded_string_array( value, "maintainers" );
    } ),
    "loading_images", sol::property(
    []( const mod_definition & definition ) {
        return definition.loading_images.value_or( std::vector<std::string>() );
    },
    []( mod_definition & definition, const sol::table & value ) {
        definition.loading_images = bounded_string_array( value, "loading_images" );
    } ),
    "disable_other_loading_screens", sol::property(
    []( const mod_definition & definition ) {
        return definition.disable_other_loading_screens.value_or( false );
    },
    []( mod_definition & definition, bool value ) {
        definition.disable_other_loading_screens = value;
    } ),
    "obsolete", sol::property(
    []( const mod_definition & definition ) {
        return definition.obsolete.value_or( false );
    },
    []( mod_definition & definition, bool value ) {
        definition.obsolete = value;
    } ),
    "load_with_data", &mod_definition::load_with_data,
    "ordered_data_files", &mod_definition::ordered_data_files,
    "world_options", sol::property(
    []( const mod_definition & definition, sol::this_state state ) {
        return write_world_options( sol::state_view( state ), definition.world_options );
    },
    []( mod_definition & definition, const sol::table & value ) {
        definition.world_options = read_world_options( value );
    } ),
    "interaction_world_options", sol::property(
    []( const mod_definition & definition, sol::this_state state ) {
        sol::state_view lua( state );
        sol::table result = lua.create_table();
        for( const auto &[companion, options] : definition.interaction_world_options ) {
            result[companion] = write_world_options( lua, options );
        }
        return result;
    },
    []( mod_definition & definition, const sol::table &value ) {
        definition.interaction_world_options = read_interaction_world_options( value );
    } ) );
    ccb["_ModDefinitionNative"] = sol::lua_nil;
    ccb.set_function( "ModDefinition", []( const sol::table & values ) {
        return make_mod_definition( values );
    } );
}

sol::load_result load_platform_file( sol::state &lua, const fs::path &path )
{
    std::ifstream input( native_file_path( path ), std::ios::binary );
    if( !input ) {
        throw std::runtime_error( "Cannot open Lua file: " + path.generic_u8string() );
    }
    std::string source( std::istreambuf_iterator<char> { input }, std::istreambuf_iterator<char> {} );
    if( input.bad() ) {
        throw std::runtime_error( "Cannot read Lua file: " + path.generic_u8string() );
    }
    if( source.compare( 0, 3, "\xef\xbb\xbf" ) == 0 ) {
        source.erase( 0, 3 );
    }
    if( !source.empty() && source.front() == '#' ) {
        const size_t newline = source.find( '\n' );
        source.erase( 0, newline == std::string::npos ? source.size() : newline + 1 );
        if( source.empty() || source.front() != '\x1b' ) {
            source.insert( source.begin(), '\n' );
        }
    }
    return lua.load( source, "@" + path.generic_u8string() );
}

struct file_execution_result {
    int return_count = 0;
    std::optional<sol::object> first;
};

file_execution_result execute_file( sol::state &lua, const fs::path &path,
                                    const std::string &context )
{
    sol::load_result loaded = load_platform_file( lua, path );
    if( !loaded.valid() ) {
        const sol::error error = loaded;
        throw std::runtime_error( context + " [" + path.generic_u8string() + "]: " + error.what() );
    }
    sol::protected_function script = loaded;
    sol::protected_function_result result = script();
    if( !result.valid() ) {
        const sol::error error = result;
        throw std::runtime_error( context + " [" + path.generic_u8string() + "]: " + error.what() );
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

void initialize_state( sol::state &lua, const fs::path &requested_root,
                       const std::shared_ptr<runtime> &platform = nullptr,
                       const std::shared_ptr<const std::set<std::string>> &selected_mod_ids = nullptr,
                       const mod_source_type type = mod_source_type::mod )
{
    // Mods are trusted executable code. State ownership is not a sandbox.
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
        if( type != mod_source_type::mod ) {
            platform->content.install_lua_api( lua, ccb, platform );
        } else {
            install_runtime_api( platform, lua, ccb );
        }
        sol::table content = ccb["content"];
        content.set_function( "is_mod_active", [selected_mod_ids]( const std::string &id ) {
            return selected_mod_ids->count( id ) != 0;
        } );
    } else {
        sol::table content = lua.create_table();
        detail::install_content_text( content );
        ccb["content"] = content;
    }

    sol::table package = lua["package"];
    // Let Lua's native searchers resolve a library shipped beside main.lua,
    // preserving their entry-symbol rules and all original external paths.
    // cpath has no escaping for its separators/placeholders. Such roots can
    // still load native libraries through an explicit package.loadlib path.
    if( root.generic_u8string().find_first_of( ";?" ) == std::string::npos ) {
#if defined(_WIN32)
        const fs::path native_pattern = root / fs::u8path( "?.dll" );
#else
        const fs::path native_pattern = root / fs::u8path( "?.so" );
#endif
        package["cpath"] = native_pattern.generic_u8string() + ";" +
                           package.get<std::string>( "cpath" );
    }
    sol::table loaded = package["loaded"];
    loaded["ccb"] = ccb;

    // Keep Lua's normal loaders, cache and loader-data return semantics. Insert
    // the Mod-local searcher first, without restricting the remaining searchers.
    sol::table searchers = package["searchers"];
    for( std::size_t index = searchers.size(); index > 0; --index ) {
        searchers[index + 1] = searchers.get<sol::object>( index );
    }
    searchers.set_function( 1, [&lua, root]( const std::string & module_name ) {
        sol::variadic_results result;
        const std::optional<fs::path> path = resolve_local_module( root, module_name );
        if( !path ) {
            // Match the standard Lua searcher diagnostic prefix.
            // NOLINTNEXTLINE(cata-text-style)
            result.push_back( sol::make_object( lua, "\n\tno Mod-local module '" + module_name + "'" ) );
            return result;
        }
        sol::load_result loaded_file = load_platform_file( lua, *path );
        if( !loaded_file.valid() ) {
            const sol::error error = loaded_file;
            throw std::runtime_error( path->generic_u8string() + ": " + error.what() );
        }
        result.push_back( loaded_file.get<sol::function>() );
        result.push_back( sol::make_object( lua, path->generic_u8string() ) );
        return result;
    } );

    // Lua-owned upvalues keep the original require and Platform table alive
    // without retaining a C++ sol::reference inside a state-owned closure.
    sol::load_result wrapper = lua.load( R"lua(
return function(original_require, platform)
    return function(name)
        if name == "ccb" then
            return platform
        end
        return original_require(name)
    end
end
)lua" );
    if( !wrapper.valid() ) {
        const sol::error error = wrapper;
        throw std::runtime_error( error.what() );
    }
    sol::protected_function factory = wrapper;
    sol::protected_function_result factory_result = factory();
    if( !factory_result.valid() ) {
        const sol::error error = factory_result;
        throw std::runtime_error( error.what() );
    }
    sol::protected_function bind = factory_result.get<sol::protected_function>();
    sol::protected_function_result bound = bind( lua["require"], ccb );
    if( !bound.valid() ) {
        const sol::error error = bound;
        throw std::runtime_error( error.what() );
    }
    lua["require"] = bound.get<sol::function>();
}

void write_mapgen_range( JsonOut &json, const char *field, const sol::object &value )
{
    if( !value.valid() || value.get_type() == sol::type::nil ) {
        return;
    }
    if( value.get_type() != sol::type::table ) {
        json.member( field, value.as<int>() );
        return;
    }
    const sol::table range = value.as<sol::table>();
    const std::size_t count = range.size();
    if( count < 1 || count > 2 ) {
        throw std::invalid_argument( std::string( field ) + " requires one or two integers" );
    }
    json.member( field );
    json.start_array();
    for( std::size_t i = 1; i <= count; ++i ) {
        json.write( range.raw_get<int>( i ) );
    }
    json.end_array();
}

template<typename T>
void write_placement_member( JsonOut &json, const sol::table &options, const char *field,
                             const char *native_field )
{
    if( const auto value = options.get<sol::optional<T>>( field ) ) {
        json.member( native_field, *value );
    }
}

void write_mapgen_value( JsonOut &json, const sol::object &value );

template<typename Weight, bool AllowExpression = true>
void write_mapgen_weighted_choices( JsonOut &json, const char *field, const sol::table &choices )
{
    const auto write_choice = [&]( const sol::object &id ) {
        if constexpr( AllowExpression ) {
            write_mapgen_value( json, id );
        } else {
            json.write( id.as<std::string>() );
        }
    };
    json.member( field );
    json.start_array();
    const std::size_t count = choices.size();
    for( std::size_t i = 1; i <= count; ++i ) {
        const sol::object value = choices.raw_get<sol::object>( i );
        if( value.get_type() == sol::type::table ) {
            const sol::table choice = value.as<sol::table>();
            const sol::object id = choice.raw_get<sol::object>( "id" );
            if( id.get_type() != sol::type::nil ) {
                json.start_array();
                write_choice( id );
                json.write( choice.get<Weight>( "weight" ) );
                json.end_array();
                continue;
            }
        }
        write_choice( value );
    }
    json.end_array();
}

void write_mapgen_value( JsonOut &json, const sol::object &value )
{
    if( value.get_type() == sol::type::string ) {
        json.write( value.as<std::string>() );
        return;
    }
    const sol::table definition = value.as<sol::table>();
    const auto parameter = definition.get<sol::optional<std::string>>( "parameter" );
    const auto weighted = definition.get<sol::optional<sol::table>>( "weighted" );
    const sol::object select = definition.raw_get<sol::object>( "select" );
    const bool has_select = select.get_type() == sol::type::table;
    if( parameter.has_value() + weighted.has_value() + has_select != 1 ) {
        throw std::invalid_argument( "mapgen value requires one of parameter, weighted or select" );
    }
    json.start_object();
    if( parameter ) {
        json.member( "param", *parameter );
        write_placement_member<std::string>( json, definition, "fallback", "fallback" );
    } else if( weighted ) {
        if( weighted->size() == 0 ) {
            throw std::invalid_argument( "mapgen value requires at least one weighted choice" );
        }
        write_mapgen_weighted_choices<int, false>( json, "distribution", *weighted );
    } else {
        json.member( "switch" );
        write_mapgen_value( json, select );
        json.member( "cases" );
        json.start_object();
        const sol::table cases = definition.get<sol::table>( "cases" );
        for( const auto &[key, result] : cases ) {
            json.member( key.as<std::string>(), result.as<std::string>() );
        }
        json.end_object();
    }
    json.end_object();
}

void write_mapgen_value_member( JsonOut &json, std::string_view field, const sol::object &value )
{
    json.member( field );
    write_mapgen_value( json, value );
}

void write_mapgen_integer_choices( JsonOut &json, const sol::table &options, const char *field )
{
    const sol::object value = options.raw_get<sol::object>( field );
    if( value.get_type() != sol::type::table ) {
        write_placement_member<int>( json, options, field, field );
        return;
    }
    const sol::table choices = value.as<sol::table>();
    const std::size_t count = choices.size();
    if( count == 0 ) {
        throw std::invalid_argument( std::string( field ) + " requires at least one choice" );
    }
    json.member( field );
    json.start_array();
    for( std::size_t i = 1; i <= count; ++i ) {
        json.write( choices.raw_get<int>( i ) );
    }
    json.end_array();
}

void write_placement_item( JsonOut &json, const sol::table &options )
{
    write_mapgen_value_member( json, "item", options.raw_get<sol::object>( "id" ) );
    write_mapgen_range( json, "chance", options.raw_get<sol::object>( "chance" ) );
    write_mapgen_range( json, "amount", options.raw_get<sol::object>( "amount" ) );
    write_placement_member<std::string>( json, options, "variant", "variant" );
    write_placement_member<std::string>( json, options, "faction", "faction" );
    if( const auto flags = options.get<sol::optional<sol::table>>( "flags" ) ) {
        json.member( "custom-flags", bounded_string_array( *flags, "flags",
                     std::numeric_limits<std::size_t>::max(), "mapgen item placement" ) );
    }
}

void write_placement_item_group( JsonOut &json, const sol::table &options )
{
    const sol::object group = options.raw_get<sol::object>( "group" );
    if( group.get_type() == sol::type::table ) {
        const sol::table definition = group.as<sol::table>();
        json.member( "item" );
        json.start_object();
        write_placement_member<std::string>( json, definition, "kind", "subtype" );
        const sol::table entries = definition.get<sol::table>( "entries" );
        json.member( "entries" );
        json.start_array();
        for( std::size_t i = 1, count = entries.size(); i <= count; ++i ) {
            const sol::table entry = entries.raw_get<sol::table>( i );
            const auto item_id = entry.get<sol::optional<std::string>>( "item" );
            const auto group_id = entry.get<sol::optional<std::string>>( "group" );
            if( item_id.has_value() == group_id.has_value() ) {
                throw std::invalid_argument( "mapgen item group entry requires one of item or group" );
            }
            json.start_object();
            if( item_id ) {
                json.member( "item", *item_id );
            } else {
                json.member( "group", *group_id );
            }
            write_placement_member<int>( json, entry, "probability", "prob" );
            for( const char *field : { "count", "charges", "damage" } ) {
                write_mapgen_range( json, field, entry.raw_get<sol::object>( field ) );
            }
            json.end_object();
        }
        json.end_array();
        json.end_object();
    } else {
        json.member( "item", group.as<std::string>() );
    }
    write_mapgen_range( json, "chance", options.raw_get<sol::object>( "chance" ) );
    write_placement_member<std::string>( json, options, "faction", "faction" );
}

void write_placement_loot( JsonOut &json, const sol::table &options )
{
    write_placement_member<std::string>( json, options, "id", "item" );
    write_placement_member<std::string>( json, options, "group", "group" );
    write_placement_member<std::string>( json, options, "variant", "variant" );
    for( const char *field : { "chance", "ammo", "magazine" } ) {
        write_placement_member<int>( json, options, field, field );
    }
}

void write_placement_monster_group( JsonOut &json, const sol::table &options )
{
    write_mapgen_value_member( json, "monster", options.raw_get<sol::object>( "group" ) );
    write_mapgen_range( json, "chance", options.raw_get<sol::object>( "chance" ) );
    write_placement_member<double>( json, options, "density", "density" );
}

void write_static_singular_text( JsonOut &json, const char *field, const sol::object &value,
                                const char *label )
{
    if( !value.valid() || value.get_type() == sol::type::nil ) {
        return;
    }
    const detail::authored_text text = detail::read_singular_text( value, {}, label );
    if( text.translated && text.translated->context ) {
        json.member( field );
        json.start_object();
        json.member( "str", text.raw );
        json.member( "ctxt", *text.translated->context );
        json.end_object();
    } else {
        json.member( field, text.raw );
    }
}

void write_placement_monster( JsonOut &json, const sol::table &options )
{
    const sol::object id = options.raw_get<sol::object>( "id" );
    const sol::object group = options.raw_get<sol::object>( "group" );
    const bool has_id = id.get_type() != sol::type::nil;
    const bool has_group = group.get_type() != sol::type::nil;
    const auto choices = options.get<sol::optional<sol::table>>( "choices" );
    const int sources = has_id + has_group + choices.has_value();
    if( sources != 1 ) {
        throw std::invalid_argument( "mapgen monster placement requires one of id, group or choices" );
    }
    if( has_id ) {
        write_mapgen_value_member( json, "monster", id );
    } else if( has_group ) {
        write_mapgen_value_member( json, "group", group );
    } else {
        write_mapgen_weighted_choices<int>( json, "monster", *choices );
    }
    write_mapgen_range( json, "chance", options.raw_get<sol::object>( "chance" ) );
    write_mapgen_range( json, "pack_size", options.raw_get<sol::object>( "pack_size" ) );
    for( const char *field : { "one_or_none", "friendly", "target", "use_pack_size" } ) {
        write_placement_member<bool>( json, options, field, field );
    }
    write_placement_member<std::string>( json, options, "random_name", "random_name" );
    write_static_singular_text( json, "name", options.raw_get<sol::object>( "name" ),
                                "monster name" );
    const auto ammunition = options.get<sol::optional<sol::table>>( "ammunition" );
    const auto patrol = options.get<sol::optional<sol::table>>( "patrol" );
    if( ammunition || patrol ) {
        json.member( "spawn_data" );
        json.start_object();
        if( ammunition ) {
            json.member( "ammo" );
            json.start_array();
            const std::size_t count = ammunition->size();
            for( std::size_t index = 1; index <= count; ++index ) {
                const sol::table entry = ammunition->raw_get<sol::table>( index );
                json.start_object();
                json.member( "ammo_id", entry.get<std::string>( "id" ) );
                write_mapgen_range( json, "qty", entry.raw_get<sol::object>( "quantity" ) );
                json.end_object();
            }
            json.end_array();
        }
        if( patrol ) {
            json.member( "patrol" );
            json.start_array();
            const std::size_t count = patrol->size();
            for( std::size_t index = 1; index <= count; ++index ) {
                const sol::table point = patrol->raw_get<sol::table>( index );
                json.start_object();
                write_mapgen_range( json, "x", point.raw_get<sol::object>( "x" ) );
                write_mapgen_range( json, "y", point.raw_get<sol::object>( "y" ) );
                json.end_object();
            }
            json.end_array();
        }
        json.end_object();
    }
}

void write_placement_vehicle( JsonOut &json, const sol::table &options )
{
    json.member( "vehicle", options.get<std::string>( "id" ) );
    for( const char *field : { "chance", "fuel", "status" } ) {
        write_placement_member<int>( json, options, field, field );
    }
    write_placement_member<std::string>( json, options, "faction", "faction" );
    write_mapgen_integer_choices( json, options, "rotation" );
}

void write_placement_field( JsonOut &json, const sol::table &options )
{
    json.member( "field", options.get<std::string>( "id" ) );
    write_mapgen_integer_choices( json, options, "intensity" );
    write_placement_member<int>( json, options, "age_turns", "age" );
    write_placement_member<int>( json, options, "chance", "chance" );
    write_placement_member<bool>( json, options, "remove", "remove" );
}

void write_placement_npc( JsonOut &json, const sol::table &options )
{
    json.member( "class", options.get<std::string>( "id" ) );
    write_placement_member<bool>( json, options, "target", "target" );
    write_placement_member<std::string>( json, options, "unique_id", "unique_id" );
    const sol::object traits = options.raw_get<sol::object>( "traits" );
    if( traits.get_type() == sol::type::table ) {
        json.member( "add_trait", bounded_string_array( traits.as<sol::table>(), "traits",
                     std::numeric_limits<std::size_t>::max(), "mapgen NPC placement" ) );
    } else {
        write_placement_member<std::string>( json, options, "traits", "add_trait" );
    }
}

void write_placement_sign( JsonOut &json, const sol::table &options )
{
    write_static_singular_text( json, "signage", options.raw_get<sol::object>( "text" ),
                                "mapgen sign text" );
    write_placement_member<std::string>( json, options, "snippet", "snippet" );
    write_placement_member<std::string>( json, options, "furniture", "furniture" );
}

void write_placement_graffiti( JsonOut &json, const sol::table &options )
{
    write_static_singular_text( json, "text", options.raw_get<sol::object>( "text" ),
                                "mapgen graffiti text" );
    write_placement_member<std::string>( json, options, "snippet", "snippet" );
}

void write_placement_zone( JsonOut &json, const sol::table &options )
{
    json.member( "type", options.get<std::string>( "id" ) );
    json.member( "faction", options.get<std::string>( "faction" ) );
    write_placement_member<std::string>( json, options, "name", "name" );
    write_placement_member<std::string>( json, options, "filter", "filter" );
}

void write_placement_toilet( JsonOut &json, const sol::table &options )
{
    write_mapgen_range( json, "amount", options.raw_get<sol::object>( "water_charges" ) );
}

void write_mapgen_string_array( JsonOut &json, const sol::table &options, const char *field,
                                const char *native_field )
{
    if( const auto values = options.get<sol::optional<sol::table>>( field ) ) {
        json.member( native_field, bounded_string_array( *values, field,
                     std::numeric_limits<std::size_t>::max(), "mapgen placement" ) );
    }
}

void write_placement_computer( JsonOut &json, const sol::table &options )
{
    write_static_singular_text( json, "name", options.raw_get<sol::object>( "name" ),
                                "mapgen computer name" );
    write_static_singular_text( json, "access_denied", options.raw_get<sol::object>( "access_denied" ),
                                "mapgen computer denial text" );
    write_placement_member<int>( json, options, "security", "security" );
    write_placement_member<bool>( json, options, "mission_target", "target" );
    write_mapgen_string_array( json, options, "chat_topics", "chat_topics" );
    if( const auto menu = options.get<sol::optional<sol::table>>( "menu" ) ) {
        json.member( "options" );
        json.start_array();
        const std::size_t count = menu->size();
        for( std::size_t i = 1; i <= count; ++i ) {
            const sol::table choice = menu->raw_get<sol::table>( i );
            json.start_object();
            write_static_singular_text( json, "name", choice.raw_get<sol::object>( "label" ),
                                        "mapgen computer option label" );
            json.member( "action", choice.get<std::string>( "action" ) );
            write_placement_member<int>( json, choice, "security", "security" );
            json.end_object();
        }
        json.end_array();
    }
    if( const auto failures = options.get<sol::optional<sol::table>>( "failures" ) ) {
        json.member( "failures" );
        json.start_array();
        for( const std::string &action : bounded_string_array( *failures, "failures",
                std::numeric_limits<std::size_t>::max(), "mapgen computer placement" ) ) {
            json.start_object();
            json.member( "action", action );
            json.end_object();
        }
        json.end_array();
    }
}

void write_placement_vending_machine( JsonOut &json, const sol::table &options )
{
    write_placement_member<std::string>( json, options, "group", "item_group" );
    for( const char *field : { "reinforced", "lootable", "powered", "networked" } ) {
        write_placement_member<bool>( json, options, field, field );
    }
}

void write_placement_liquid( JsonOut &json, const sol::table &options )
{
    json.member( "liquid", options.get<std::string>( "id" ) );
    write_mapgen_range( json, "amount", options.raw_get<sol::object>( "amount" ) );
    write_mapgen_range( json, "chance", options.raw_get<sol::object>( "one_in" ) );
}

void write_placement_fuel_pump( JsonOut &json, const sol::table &options )
{
    write_mapgen_range( json, "amount", options.raw_get<sol::object>( "amount" ) );
    write_placement_member<std::string>( json, options, "fuel", "fuel" );
}

void write_placement_corpse( JsonOut &json, const sol::table &options )
{
    json.member( "group", options.get<std::string>( "group" ) );
    write_placement_member<int>( json, options, "age_days", "age" );
}

void write_placement_rubble( JsonOut &json, const sol::table &options )
{
    write_placement_member<std::string>( json, options, "furniture", "rubble_type" );
    write_placement_member<std::string>( json, options, "floor", "floor_type" );
    write_placement_member<bool>( json, options, "with_debris", "items" );
    write_placement_member<bool>( json, options, "overwrite", "overwrite" );
}

using placement_writer = void ( * )( JsonOut &, const sol::table & );

void write_static_mapgen_placement( JsonOut &json, const sol::table &options,
                                    placement_writer writer, bool positioned )
{
    json.start_object();
    if( positioned ) {
        for( const char *axis : { "x", "y", "z" } ) {
            write_mapgen_range( json, axis, options.raw_get<sol::object>( axis ) );
        }
    }
    write_mapgen_range( json, "repeat", options.raw_get<sol::object>( "repetitions" ) );
    writer( json, options );
    json.end_object();
}

void write_placement_sealed_item( JsonOut &json, const sol::table &options )
{
    json.member( "furniture", options.get<std::string>( "furniture" ) );
    write_mapgen_range( json, "chance", options.raw_get<sol::object>( "chance" ) );
    if( const auto item = options.get<sol::optional<sol::table>>( "item" ) ) {
        json.member( "item" );
        write_static_mapgen_placement( json, *item, write_placement_item, false );
    }
    if( const auto group = options.get<sol::optional<sol::table>>( "item_group" ) ) {
        json.member( "items" );
        write_static_mapgen_placement( json, *group, write_placement_item_group, false );
    }
}

void write_mapgen_glyph_placement( JsonOut &json, const sol::table &placements,
                                   placement_writer writer )
{
    const std::size_t count = placements.size();
    if( count == 0 ) {
        write_static_mapgen_placement( json, placements, writer, false );
        return;
    }
    json.start_array();
    for( std::size_t i = 1; i <= count; ++i ) {
        write_static_mapgen_placement( json, placements.raw_get<sol::table>( i ), writer, false );
    }
    json.end_array();
}

std::vector<std::string> sorted_mapgen_glyphs( const sol::table &glyphs )
{
    // Some native placements consume RNG or allocate an anonymous item group during loading.
    std::vector<std::string> keys;
    for( const auto &entry : glyphs ) {
        keys.push_back( entry.first.as<std::string>() );
    }
    std::sort( keys.begin(), keys.end() );
    return keys;
}

void write_mapgen_glyph_placements( JsonOut &json, const char *field, const sol::table &glyphs,
                                    placement_writer writer )
{
    json.member( field );
    json.start_object();
    for( const std::string &glyph : sorted_mapgen_glyphs( glyphs ) ) {
        json.member( glyph );
        write_mapgen_glyph_placement( json, glyphs.raw_get<sol::table>( glyph ), writer );
    }
    json.end_object();
}

void write_static_mapgen_placements( JsonOut &json, const sol::table &layout,
                                     bool include_positions )
{
    struct placement_fields {
        const char *positions;
        const char *native_positions;
        const char *glyphs;
        const char *native_glyphs;
        placement_writer writer;
    };
    static constexpr placement_fields fields[] = {
        { "item_placements", "place_item", "item_spawns", "item", write_placement_item },
        { "item_group_placements", "place_items", "item_groups", "items", write_placement_item_group },
        { "loot_placements", "place_loot", nullptr, nullptr, write_placement_loot },
        { "monster_placements", "place_monster", "monster_glyphs", "monster", write_placement_monster },
        { "monster_group_placements", "place_monsters", "monster_group_glyphs", "monsters",
            write_placement_monster_group },
        { "vehicle_placements", "place_vehicles", "vehicle_glyphs", "vehicles", write_placement_vehicle },
        { "field_placements", "place_fields", "field_glyphs", "fields", write_placement_field },
        { "npc_placements", "place_npcs", "npc_glyphs", "npcs", write_placement_npc },
        { "sign_placements", "place_signs", "sign_glyphs", "signs", write_placement_sign },
        { "graffiti_placements", "place_graffiti", "graffiti_glyphs", "graffiti", write_placement_graffiti },
        { "zone_placements", "place_zones", "zone_glyphs", "zones", write_placement_zone },
        { "toilet_placements", "place_toilets", nullptr, nullptr, write_placement_toilet },
        { "computer_placements", "place_computers", "computer_glyphs", "computers", write_placement_computer },
        { "vending_placements", "place_vendingmachines", "vending_glyphs", "vendingmachines",
            write_placement_vending_machine },
        { "liquid_placements", "place_liquids", "liquid_glyphs", "liquids", write_placement_liquid },
        { "fuel_pump_placements", "place_gaspumps", "fuel_pump_glyphs", "gaspumps", write_placement_fuel_pump },
        { nullptr, nullptr, "sealed_item_glyphs", "sealed_item", write_placement_sealed_item },
        { "corpse_placements", "place_corpses", "corpse_glyphs", "corpses", write_placement_corpse },
        { "rubble_placements", "place_rubble", "rubble_glyphs", "rubble", write_placement_rubble },
        { "transform_placements", "place_ter_furn_transforms", "transform_glyphs", "ter_furn_transforms",
            []( JsonOut & out, const sol::table & options ) {
                write_mapgen_value_member( out, "transform", options.raw_get<sol::object>( "id" ) );
            }
        },
        { "vehicle_removals", "remove_vehicles", nullptr, nullptr,
            []( JsonOut & out, const sol::table & options ) {
                write_mapgen_string_array( out, options, "prototypes", "vehicles" );
            }
        },
        { "npc_removals", "remove_npcs", nullptr, nullptr,
            []( JsonOut & out, const sol::table & options ) {
                write_placement_member<std::string>( out, options, "id", "class" );
                write_placement_member<std::string>( out, options, "unique_id", "unique_id" );
            }
        },
        { "clear_areas", "place_remove_all", "clear_glyphs", "remove_all",
            []( JsonOut &, const sol::table & ) {}
        },
        { "position_markers", "place_variables", nullptr, nullptr,
            []( JsonOut & out, const sol::table & options ) {
                out.member( "name", options.get<std::string>( "name" ) );
            }
        },
        { "faction_areas", "faction_owner", nullptr, nullptr,
            []( JsonOut & out, const sol::table & options ) {
                out.member( "id", options.get<std::string>( "id" ) );
            }
        },
        { "terrain_placements", "place_terrain", nullptr, nullptr,
            []( JsonOut & out, const sol::table & options ) {
                out.member( "ter", options.get<std::string>( "id" ) );
            }
        },
        { "furniture_placements", "place_furniture", nullptr, nullptr,
            []( JsonOut & out, const sol::table & options ) {
                out.member( "furn", options.get<std::string>( "id" ) );
            }
        },
        { "trap_placements", "place_traps", nullptr, nullptr,
            []( JsonOut & out, const sol::table & options ) {
                out.member( "trap", options.get<std::string>( "id" ) );
            }
        },
    };
    for( const placement_fields &field : fields ) {
        if( include_positions && field.positions ) {
            if( const auto positions = layout.get<sol::optional<sol::table>>( field.positions ) ) {
                json.member( field.native_positions );
                json.start_array();
                const std::size_t count = positions->size();
                for( std::size_t index = 1; index <= count; ++index ) {
                    write_static_mapgen_placement( json, positions->raw_get<sol::table>( index ),
                                                   field.writer, true );
                }
                json.end_array();
            }
        }
        if( !field.glyphs ) {
            continue;
        }
        if( const auto glyphs = layout.get<sol::optional<sol::table>>( field.glyphs ) ) {
            write_mapgen_glyph_placements( json, field.native_glyphs, *glyphs, field.writer );
        }
    }
}

void write_mapgen_glyph_alternatives( JsonOut &json, std::string_view member,
                                      const sol::object &value )
{
    if( value.get_type() == sol::type::string ) {
        write_mapgen_value_member( json, member, value );
        return;
    }
    const sol::table choices = value.as<sol::table>();
    const std::size_t count = choices.size();
    if( count == 0 && choices.begin() != choices.end() ) {
        write_mapgen_value_member( json, member, value );
        return;
    }
    json.member( member );
    json.start_array();
    for( std::size_t i = 1; i <= count; ++i ) {
        const sol::table choice = choices.raw_get<sol::table>( i );
        const sol::object id = choice.raw_get<sol::object>( "id" );
        const auto copies = choice.get<sol::optional<int>>( "copies" );
        if( copies || id.get_type() != sol::type::string ) {
            json.start_array();
            write_mapgen_value( json, id );
            json.write( copies.value_or( 1 ) );
            json.end_array();
        } else {
            write_mapgen_value( json, id );
        }
    }
    json.end_array();
}

void write_mapgen_glyph_mappings( JsonOut &json, const sol::table &mappings )
{
    struct mapping_field {
        const char *field;
        const char *native_field;
        placement_writer writer;
    };
    static constexpr mapping_field placements[] = {
        { "item_spawns", "item", write_placement_item },
        { "item_groups", "items", write_placement_item_group },
        { "liquids", "liquids", write_placement_liquid },
        { "fields", "fields", write_placement_field },
        { "npcs", "npcs", write_placement_npc },
        { "toilets", "toilets", write_placement_toilet },
    };
    json.member( "mapping" );
    json.start_object();
    for( const std::string &glyph : sorted_mapgen_glyphs( mappings ) ) {
        const sol::table mapping = mappings.raw_get<sol::table>( glyph );
        json.member( glyph );
        json.start_object();
        for( const char *field : { "terrain", "furniture", "traps" } ) {
            const sol::object mapped = mapping.raw_get<sol::object>( field );
            if( mapped.get_type() != sol::type::nil ) {
                write_mapgen_glyph_alternatives( json, field, mapped );
            }
        }
        for( const mapping_field &placement : placements ) {
            if( const auto entry = mapping.get<sol::optional<sol::table>>( placement.field ) ) {
                json.member( placement.native_field );
                write_mapgen_glyph_placement( json, *entry, placement.writer );
            }
        }
        json.end_object();
    }
    json.end_object();
}

void write_mapgen_tile_edits( JsonOut &json, const sol::table &edits )
{
    static constexpr std::pair<std::string_view, std::string_view> actions[] = {
        { "terrain", "terrain" }, { "furniture", "furniture" }, { "trap", "trap" },
        { "remove_trap", "trap_remove" }, { "remove_creatures", "creature_remove" },
        { "kill_creatures", "creature_kill" }, { "remove_items", "item_remove" },
        { "remove_fields", "field_remove" }, { "radiation", "radiation" },
        { "bash", "bash" }, { "burn", "burn" }, { "remember_position", "variable" },
    };
    json.member( "set" );
    json.start_array();
    for( std::size_t i = 1, count = edits.size(); i <= count; ++i ) {
        const sol::table edit = edits.raw_get<sol::table>( i );
        const std::string shape = edit.get<std::string>( "shape" );
        if( shape != "point" && shape != "line" && shape != "rectangle" ) {
            throw std::invalid_argument( "mapgen tile edit shape must be point, line or rectangle" );
        }
        const std::string operation = edit.get<std::string>( "operation" );
        const auto action = std::find_if( std::begin( actions ), std::end( actions ),
        [&]( const auto &entry ) {
            return entry.first == operation;
        } );
        if( action == std::end( actions ) ) {
            throw std::invalid_argument( "unknown mapgen tile operation: " + operation );
        }
        if( shape != "point" && ( operation == "bash" || operation == "burn" ||
                                 operation == "remember_position" ) ) {
            throw std::invalid_argument( operation + " requires a point tile edit" );
        }
        json.start_object();
        json.member( shape == "rectangle" ? "square" : shape, action->second );
        for( const char *axis : { "x", "y", "z" } ) {
            write_mapgen_range( json, axis, edit.raw_get<sol::object>( axis ) );
        }
        if( shape != "point" ) {
            write_mapgen_range( json, "x2", edit.raw_get<sol::object>( "end_x" ) );
            write_mapgen_range( json, "y2", edit.raw_get<sol::object>( "end_y" ) );
        }
        write_placement_member<std::string>( json, edit, "id", "id" );
        write_mapgen_range( json, "amount", edit.raw_get<sol::object>( "amount" ) );
        write_mapgen_range( json, "repeat", edit.raw_get<sol::object>( "repetitions" ) );
        write_placement_member<int>( json, edit, "one_in", "chance" );
        json.end_object();
    }
    json.end_array();
}

void write_mapgen_terrain_matchers( JsonOut &json, const sol::table &matches )
{
    json.start_array();
    const std::size_t count = matches.size();
    for( std::size_t i = 1; i <= count; ++i ) {
        const sol::object value = matches.raw_get<sol::object>( i );
        if( value.get_type() == sol::type::string ) {
            json.write( value.as<std::string>() );
        } else {
            const sol::table matcher = value.as<sol::table>();
            json.start_object();
            json.member( "om_terrain", matcher.get<std::string>( "terrain" ) );
            if( const auto mode = matcher.get<sol::optional<std::string>>( "match" ) ) {
                json.member( "om_terrain_match_type", to_upper_case( *mode ) );
            }
            json.end_object();
        }
    }
    json.end_array();
}

void write_mapgen_nested_placement( JsonOut &json, const sol::table &placement )
{
    json.start_object();
    const sol::object id = placement.raw_get<sol::object>( "id" );
    const bool has_id = id.get_type() != sol::type::nil;
    const auto choices = placement.get<sol::optional<sol::table>>( "choices" );
    if( has_id && choices ) {
        throw std::invalid_argument( "nested placement can take an id or a choice list" );
    }
    if( has_id ) {
        json.member( "chunks" );
        json.start_array();
        write_mapgen_value( json, id );
        json.end_array();
    } else if( choices ) {
        write_mapgen_weighted_choices<double>( json, "chunks", *choices );
    }
    if( const auto fallback = placement.get<sol::optional<sol::table>>( "otherwise" ) ) {
        write_mapgen_weighted_choices<double>( json, "else_chunks", *fallback );
    }
    for( const auto &[field, native] : {
             std::pair{ "x", "x" }, std::pair{ "y", "y" }, std::pair{ "z", "z" },
             std::pair{ "repetitions", "repeat" }
         } ) {
        write_mapgen_range( json, native, placement.raw_get<sol::object>( field ) );
    }
    if( const auto neighbors = placement.get<sol::optional<sol::table>>( "neighbors" ) ) {
        json.member( "neighbors" );
        json.start_object();
        for( const auto &[direction, matches] : *neighbors ) {
            const std::string key = direction.as<std::string>();
            if( matches.get_type() == sol::type::string ) {
                json.member( key, matches.as<std::string>() );
            } else {
                json.member( key );
                write_mapgen_terrain_matchers( json, matches.as<sol::table>() );
            }
        }
        json.end_object();
    }
    for( const auto &[field, native] : {
             std::pair{ "joins", "joins" }, std::pair{ "required_flags", "flags" },
             std::pair{ "any_flags", "flags_any" }
         } ) {
        if( const auto directions = placement.get<sol::optional<sol::table>>( field ) ) {
            json.member( native );
            json.start_object();
            for( const auto &[direction, values] : *directions ) {
                const std::string key = direction.as<std::string>();
                if( values.get_type() == sol::type::string ) {
                    json.member( key, values.as<std::string>() );
                } else {
                    json.member( key, bounded_string_array( values.as<sol::table>(), field,
                                 std::numeric_limits<std::size_t>::max(), "nested mapgen" ) );
                }
            }
            json.end_object();
        }
    }
    if( const auto predecessors = placement.get<sol::optional<sol::table>>( "predecessors" ) ) {
        json.member( "predecessors" );
        write_mapgen_terrain_matchers( json, *predecessors );
    }
    if( const auto levels = placement.get<sol::optional<sol::table>>( "levels" ) ) {
        json.member( "check_z" );
        json.start_array();
        const std::size_t count = levels->size();
        for( std::size_t i = 1; i <= count; ++i ) {
            json.write( levels->raw_get<int>( i ) );
        }
        json.end_array();
    }
    json.end_object();
}

void write_mapgen_parameters( JsonOut &json, const sol::table &parameters )
{
    static constexpr std::pair<std::string_view, std::string_view> value_types[] = {
        { "palette", "palette_id" }, { "terrain", "ter_str_id" }, { "furniture", "furn_str_id" },
        { "string", "string" },
        { "nested_mapgen", "nested_mapgen_id" }, { "monster_group", "mongroup_id" }, { "boolean", "bool" },
    };
    static constexpr std::pair<std::string_view, std::string_view> scopes[] = {
        { "overmap_special", "overmap_special" }, { "map_stack", "omt_stack" },
        { "map_tile", "omt" }, { "nested", "nest" },
    };
    const auto native_name = []( const auto & entries, const std::string & name ) {
        const auto entry = std::find_if( std::begin( entries ), std::end( entries ),
        [&]( const auto &candidate ) {
            return candidate.first == name;
        } );
        if( entry == std::end( entries ) ) {
            throw std::invalid_argument( "unknown mapgen parameter type or scope: " + name );
        }
        return entry->second;
    };
    json.member( "parameters" );
    json.start_object();
    for( const auto &[name, value] : parameters ) {
        const sol::table parameter = value.as<sol::table>();
        json.member( name.as<std::string>() );
        json.start_object();
        json.member( "type", native_name( value_types, parameter.get<std::string>( "value_type" ) ) );
        if( const auto scope = parameter.get<sol::optional<std::string>>( "scope" ) ) {
            json.member( "scope", native_name( scopes, *scope ) );
        }
        write_mapgen_value_member( json, "default", parameter.raw_get<sol::object>( "default" ) );
        json.end_object();
    }
    json.end_object();
}

void write_mapgen_palette_fields( JsonOut &json, const sol::table &layout,
                                  bool include_positions )
{
    if( const auto parameters = layout.get<sol::optional<sol::table>>( "parameters" ) ) {
        write_mapgen_parameters( json, *parameters );
    }
    if( const auto palettes = layout.get<sol::optional<sol::table>>( "palettes" ) ) {
        const std::size_t count = checked_dense_array_size( *palettes, "mapgen layout palettes",
                                  std::numeric_limits<std::size_t>::max() );
        json.member( "palettes" );
        json.start_array();
        for( std::size_t i = 1; i <= count; ++i ) {
            write_mapgen_value( json, palettes->raw_get<sol::object>( i ) );
        }
        json.end_array();
    }
    for( const char *field : { "terrain", "furniture", "traps" } ) {
        if( const auto glyphs = layout.get<sol::optional<sol::table>>( field ) ) {
            json.member( field );
            json.start_object();
            for( const auto &[glyph, value] : *glyphs ) {
                write_mapgen_glyph_alternatives( json, glyph.as<std::string>(), value );
            }
            json.end_object();
        }
    }
    if( const auto mappings = layout.get<sol::optional<sol::table>>( "glyph_mappings" ) ) {
        write_mapgen_glyph_mappings( json, *mappings );
    }
    write_static_mapgen_placements( json, layout, include_positions );
    if( const auto glyphs = layout.get<sol::optional<sol::table>>( "nested_glyphs" ) ) {
        json.member( "nested" );
        json.start_object();
        for( const auto &[glyph, value] : *glyphs ) {
            json.member( glyph.as<std::string>() );
            const sol::table placements = value.as<sol::table>();
            const std::size_t count = placements.size();
            if( count == 0 ) {
                write_mapgen_nested_placement( json, placements );
            } else {
                json.start_array();
                for( std::size_t i = 1; i <= count; ++i ) {
                    write_mapgen_nested_placement( json, placements.raw_get<sol::table>( i ) );
                }
                json.end_array();
            }
        }
        json.end_object();
    }
    if( const auto toilets = layout.get<sol::optional<sol::table>>( "toilets" ) ) {
        if( toilets->size() == 0 ) {
            write_mapgen_glyph_placements( json, "toilets", *toilets, write_placement_toilet );
        } else {
            json.member( "toilets" );
            json.start_object();
            for( const std::string &glyph : bounded_string_array( *toilets, "toilets", 256,
                    "overmap mapgen layout" ) ) {
                json.member( glyph );
                json.start_object();
                json.end_object();
            }
            json.end_object();
        }
    }
}

void write_static_mapgen_layout( JsonOut &json, const sol::table &layout,
                                 std::size_t max_rows )
{
    json.member( "object" );
    json.start_object();
    const sol::object fill = layout.raw_get<sol::object>( "fill_terrain" );
    if( fill.get_type() != sol::type::nil ) {
        write_mapgen_value_member( json, "fill_ter", fill );
    }
    if( const auto rows = layout.get<sol::optional<sol::table>>( "rows" ) ) {
        json.member( "rows", bounded_string_array( *rows, "rows", max_rows, "mapgen layout" ) );
    }
    if( const auto size = layout.get<sol::optional<sol::table>>( "size" ) ) {
        json.member( "mapgensize", std::array<int, 2>{ size->get<int>( "width" ),
                     size->get<int>( "height" ) } );
    }
    const auto layout_flags = layout.get<sol::optional<sol::table>>( "flags" );
    const bool erase = layout.get_or( "erase_before_terrain", false );
    if( layout_flags || erase ) {
        std::vector<std::string> flags = layout_flags ?
            bounded_string_array( *layout_flags, "flags", std::numeric_limits<std::size_t>::max(),
                                  "mapgen layout" ) : std::vector<std::string>{};
        if( erase && std::find( flags.begin(), flags.end(), "ERASE_ALL_BEFORE_PLACING_TERRAIN" ) == flags.end() ) {
            flags.emplace_back( "ERASE_ALL_BEFORE_PLACING_TERRAIN" );
        }
        json.member( "flags", flags );
    }
    write_mapgen_range( json, "rotation", layout.raw_get<sol::object>( "rotation" ) );
    for( const char *field : { "predecessor_mapgen", "fallback_predecessor_mapgen" } ) {
        if( const auto predecessor = layout.get<sol::optional<std::string>>( field ) ) {
            json.member( field, *predecessor );
        }
    }
    write_mapgen_palette_fields( json, layout, true );
    if( const auto edits = layout.get<sol::optional<sol::table>>( "tile_edits" ) ) {
        write_mapgen_tile_edits( json, *edits );
    }
    if( const auto placements = layout.get<sol::optional<sol::table>>( "nested" ) ) {
        const std::size_t count = placements->size();
        json.member( "place_nested" );
        json.start_array();
        for( std::size_t i = 1; i <= count; ++i ) {
            write_mapgen_nested_placement( json, placements->raw_get<sol::table>( i ) );
        }
        json.end_array();
    }
    json.end_object();
}

void write_overmap_mapgens( JsonOut &json, const char *key, const sol::table &variants )
{
    json.member( key );
    json.start_array();
    for( std::size_t i = 1; i <= variants.size(); ++i ) {
        const sol::table mapgen = variants.get<sol::table>( i );
        const auto builtin = mapgen.get<sol::optional<std::string>>( "builtin" );
        const auto layout = mapgen.get<sol::optional<sol::table>>( "layout" );
        if( static_cast<bool>( builtin ) == static_cast<bool>( layout ) ) {
            throw std::runtime_error( "overmap mapgen requires either a builtin or a layout" );
        }
        json.start_object();
        if( const auto weight = mapgen.get<sol::optional<int>>( "weight" ) ) {
            json.member( "weight", *weight );
        }
        if( builtin ) {
            json.member( "builtin", *builtin );
        } else {
            write_static_mapgen_layout( json, *layout, 24 );
        }
        json.end_object();
    }
    json.end_array();
}

void write_static_mapgen_targets( JsonOut &json, const sol::object &id )
{
    if( id.get_type() != sol::type::table ) {
        json.member( "om_terrain", id.as<std::string>() );
        return;
    }
    const sol::table targets = id.as<sol::table>();
    const std::size_t limit = std::numeric_limits<std::size_t>::max();
    if( targets.raw_get<sol::object>( 1 ).get_type() != sol::type::table ) {
        json.member( "om_terrain", bounded_string_array( targets, "id", limit, "overmap mapgen" ) );
        return;
    }
    std::vector<std::vector<std::string>> grid;
    const std::size_t rows = targets.size();
    grid.reserve( rows );
    for( std::size_t i = 1; i <= rows; ++i ) {
        grid.push_back( bounded_string_array( targets.raw_get<sol::table>( i ), "id row", limit,
                                             "overmap mapgen" ) );
    }
    json.member( "om_terrain", grid );
}

void load_static_mapgen( const sol::table &options )
{
    const std::string kind = options.get<std::string>( "kind" );
    const sol::object id = options.raw_get<sol::object>( "id" );
    std::ostringstream serialized;
    JsonOut json( serialized );
    json.start_object();
    if( kind == "overmap" ) {
        write_static_mapgen_targets( json, id );
    } else if( kind == "nested" ) {
        json.member( "nested_mapgen_id", id.as<std::string>() );
    } else if( kind == "update" ) {
        json.member( "update_mapgen_id", id.as<std::string>() );
    } else {
        throw std::runtime_error( "mapgen kind must be overmap, nested or update" );
    }
    if( const auto weight = options.get<sol::optional<int>>( "weight" ) ) {
        json.member( "weight", *weight );
    }
    write_static_mapgen_layout( json, options.get<sol::table>( "layout" ),
                                std::numeric_limits<std::size_t>::max() );
    json.end_object();
    load_mapgen( json_loader::from_string( serialized.str() ).get_object() );
}

void load_static_mapgen_palette( const sol::table &options, const std::string &source )
{
    std::ostringstream serialized;
    JsonOut json( serialized );
    json.start_object();
    json.member( "id", options.get<std::string>( "id" ) );
    write_placement_member<bool>( json, options, "extend", "extending" );
    write_mapgen_palette_fields( json, options.get<sol::table>( "layout" ), false );
    json.end_object();
    mapgen_palette::load( json_loader::from_string( serialized.str() ).get_object(), source );
}

void load_static_overmap_terrain( const sol::table &options, const std::string &source,
                                  bool patch )
{
    const std::string_view context = "overmap terrain";
    const sol::object id = options.raw_get<sol::object>( patch ? "ids" : "id" );
    const auto abstract = options.get<sol::optional<std::string>>( "abstract" );
    const auto parent = options.get<sol::optional<std::string>>( "copy_from" );
    const bool has_id = id.valid() && id.get_type() != sol::type::nil;
    if( has_id == static_cast<bool>( abstract ) ||
        ( patch && ( abstract || !parent || parent->empty() ) ) ) {
        throw std::runtime_error( patch ? "overmap terrain patch requires ids and a parent" :
                                  "overmap terrain requires exactly one of id or abstract" );
    }

    std::ostringstream serialized;
    JsonOut json( serialized );
    json.start_object();
    json.member( "type", "overmap_terrain" );
    if( abstract ) {
        json.member( "abstract", *abstract );
    } else if( !patch && id.get_type() == sol::type::string ) {
        json.member( "id", id.as<std::string>() );
    } else {
        const auto ids = bounded_string_array( id.as<sol::table>(), "ids", 4096, context );
        if( ids.empty() ) {
            throw std::runtime_error( "overmap terrain ids cannot be empty" );
        }
        json.member( "id", ids );
    }
    if( parent ) {
        json.member( "copy-from", *parent );
    }
    if( const auto on_entry = options.get<sol::optional<std::string>>( "on_entry" ) ) {
        json.member( "__ccb_on_entry", *on_entry );
    }
    write_static_singular_text( json, "name", options.raw_get<sol::object>( "name" ),
                                "overmap terrain name" );
    for( const auto &[key, native_key] : {
             std::pair{ "symbol", "sym" }, std::pair{ "color", "color" },
             std::pair{ "see_cost", "see_cost" }, std::pair{ "vision_levels", "vision_levels" },
             std::pair{ "uniform_terrain", "uniform_terrain" }, std::pair{ "extras", "extras" },
             std::pair{ "travel_cost", "travel_cost_type" }, std::pair{ "land_use_code", "land_use_code" },
             std::pair{ "connect_group", "connect_group" }
         } ) {
        if( const auto value = options.get<sol::optional<std::string>>( key ) ) {
            json.member( native_key, *value );
        }
    }
    const sol::object looks_like = options.raw_get<sol::object>( "looks_like" );
    if( looks_like.get_type() == sol::type::table ) {
        json.member( "looks_like", bounded_string_array( looks_like.as<sol::table>(),
                     "looks_like", 256, context ) );
    } else if( looks_like.valid() && looks_like.get_type() != sol::type::nil ) {
        json.member( "looks_like", looks_like.as<std::string>() );
    }
    if( const auto density = options.get<sol::optional<int>>( "monster_density" ) ) {
        json.member( "mondensity", *density );
    }
    for( const char *key : { "flags", "post_process_generators" } ) {
        if( const auto values = options.get<sol::optional<sol::table>>( key ) ) {
            json.member( key, bounded_string_array( *values, key, 256, context ) );
        }
    }
    for( const char *operation : { "extend", "delete" } ) {
        if( const auto changes = options.get<sol::optional<sol::table>>( operation ) ) {
            json.member( operation );
            json.start_object();
            for( const char *key : { "flags", "post_process_generators" } ) {
                if( const auto values = changes->get<sol::optional<sol::table>>( key ) ) {
                    json.member( key, bounded_string_array( *values, key, 256, context ) );
                }
            }
            json.end_object();
        }
    }
    if( const auto spawns = options.get<sol::optional<sol::table>>( "spawns" ) ) {
        json.member( "spawns" );
        json.start_object();
        if( const auto group = spawns->get<sol::optional<std::string>>( "group" ) ) {
            json.member( "group", *group );
        }
        if( const auto population = spawns->get<sol::optional<sol::table>>( "population" ) ) {
            if( population->size() != 2 ) {
                throw std::runtime_error( "overmap terrain spawn population requires {minimum, maximum}" );
            }
            json.member( "population", std::array<int, 2>{ population->get<int>( 1 ),
                         population->get<int>( 2 ) } );
        }
        if( const auto chance = spawns->get<sol::optional<int>>( "chance" ) ) {
            json.member( "chance", *chance );
        }
        json.end_object();
    }
    if( const auto mapgen = options.get<sol::optional<sol::table>>( "mapgen" ) ) {
        write_overmap_mapgens( json, "mapgen", *mapgen );
    }
    if( const auto directional = options.get<sol::optional<sol::table>>( "directional_mapgen" ) ) {
        for( const auto &[shape, native_key] : {
                 std::pair{ "straight", "mapgen_straight" }, std::pair{ "curved", "mapgen_curved" },
                 std::pair{ "end_cap", "mapgen_end" }, std::pair{ "tee", "mapgen_tee" },
                 std::pair{ "four_way", "mapgen_four_way" }
             } ) {
            if( const auto mapgen = directional->get<sol::optional<sol::table>>( shape ) ) {
                write_overmap_mapgens( json, native_key, *mapgen );
            }
        }
    }
    json.end_object();

    // The native loader preserves inheritance, deferred parents and mapgen registration order.
    const JsonObject definition = json_loader::from_string( serialized.str() ).get_object();
    static_cast<void>( definition.get_string( "type" ) );
    overmap_terrains::load( definition, source );
}

runtime_state load_source( const mod_source &source,
                           const std::shared_ptr<const std::set<std::string>> &selected_mod_ids )
{
    const mod_source resolved = resolve_source( source );
    DebugLog( D_WARNING, D_MAIN )
            << "Executing Lua-first Platform Mod entry as trusted executable code "
            << "(with access to the player system): "
            << resolved.entry.generic_u8string();
    runtime_state result;
    result.id = resolved.id;
    result.root = resolved.root;
    result.entry = resolved.entry;
    result.type = resolved.type;
    result.selected_mod_ids = selected_mod_ids;
    result.lua = std::make_unique<sol::state>();
    result.platform = make_runtime( resolved.id, generation_counter + 1,
                                    *result.lua, resolved.root );
    initialize_state( *result.lua, resolved.root, result.platform, result.selected_mod_ids,
                      result.type );
    execute_file( *result.lua, resolved.entry, "Lua-first Mod '" + resolved.id + "' entry" );
    return result;
}

} // namespace

void load_core_content( const fs::path &root )
{
    const fs::path entry = root / "main.lua";
    if( !fs::exists( entry ) ) {
        return;
    }

    const auto no_world_mods = std::make_shared<const std::set<std::string>>();
    const runtime_state core = load_source( { "core", root, entry, mod_source_type::core_content },
                                            no_world_mods );
    std::string error;
    if( !validate_runtime( core.platform, true, error ) ||
        !apply_runtime_content( core.platform, error ) ) {
        throw std::runtime_error( error );
    }
    // Core definitions are available while the main menu and loading UI run.
    // The static entry has no runtime callbacks and never becomes a world Mod.
    commit_runtime( core.platform );
}

void load_mod_content_with_data( const mod_source &source,
                                const std::set<std::string> &selected_mod_ids )
{
    const mod_source resolved = resolve_source( source );
    sol::state lua;
    initialize_state( lua, resolved.root );
    const sol::table package = lua["package"];
    const sol::table loaded = package["loaded"];
    const sol::table ccb = loaded["ccb"];
    sol::table content = ccb["content"];
    content.set_function( "is_mod_active", [&selected_mod_ids]( const std::string &id ) {
        return selected_mod_ids.count( id ) != 0;
    } );
    content.set_function( "define_mapgen", load_static_mapgen );
    content.set_function( "define_mapgen_palette", [&resolved]( const sol::table &options ) {
        load_static_mapgen_palette( options, resolved.id );
    } );
    content.set_function( "define_overmap_terrain", [&resolved]( const sol::table &options ) {
        load_static_overmap_terrain( options, resolved.id, false );
    } );
    content.set_function( "patch_overmap_terrain", [&resolved]( const sol::table &options ) {
        load_static_overmap_terrain( options, resolved.id, true );
    } );
    execute_file( lua, resolved.entry, "Lua-first data entry for '" + resolved.id + "'" );
}

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
        const fs::path path = fs::canonical( canonical_root / fs::u8path( "mod.lua" ), filesystem_error );
        if( filesystem_error || !path_is_within( path, canonical_root ) ||
            !fs::is_regular_file( path, filesystem_error ) || filesystem_error ) {
            throw std::runtime_error( "Lua-first mod.lua escapes its Mod root or is not a regular file" );
        }
        DebugLog( D_WARNING, D_MAIN )
                << "Executing Lua-first Platform Mod metadata as trusted executable code "
                << "(with access to the player system): "
                << path.generic_u8string();
        sol::state lua;
        initialize_state( lua, canonical_root );
        const file_execution_result execution = execute_file( lua, path, "Lua-first Mod metadata" );
        if( execution.return_count != 1 ) {
            error = "Lua-first Mod metadata [" + path.generic_u8string() +
                    "]: expected exactly one ccb.ModDefinition return value; "
                    // Lua source syntax uses three literal dots.
                    // NOLINTNEXTLINE(cata-text-style)
                    "use return (require(...)) when forwarding a metadata module";
            return false;
        }
        const sol::object &value = *execution.first;
        if( !value.is<mod_definition>() ) {
            error = "Lua-first Mod metadata [" + path.generic_u8string() +
                    "]: expected a native ccb.ModDefinition return value";
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

bool prepare_mods( const std::vector<mod_source> &sources, std::string &error,
                   const std::set<std::string> &selected_mod_ids )
{
    discard_prepared_mods();
    std::vector<runtime_state> candidate;
    candidate.reserve( sources.size() );
    try {
        if( generation_counter == std::numeric_limits<std::size_t>::max() ) {
            throw std::runtime_error( "Lua-first Platform generation space is exhausted" );
        }
        std::set<std::string> seen_ids;
        std::set<std::string> all_ids = selected_mod_ids;
        for( const mod_source &source : sources ) {
            if( !seen_ids.insert( source.id ).second ) {
                throw std::runtime_error( "Duplicate Lua-first Mod id '" + source.id + "'" );
            }
            if( source.type == mod_source_type::mod ) {
                all_ids.insert( source.id );
            }
        }
        const auto selected = std::make_shared<const std::set<std::string>>( std::move( all_ids ) );
        for( const mod_source &source : sources ) {
            candidate.push_back( load_source( source, selected ) );
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
    // JSON items and recipes may still be waiting for parents declared later.
    // Resolve native inheritance before any Lua transaction takes its snapshots;
    // leave abstract parents and unresolved dependencies for finalization.
    item_controller->get_generic_factory().resolve_deferred();
    recipe_dictionary::resolve_deferred();
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
        if( state.type == mod_source_type::mod ) {
            active.push_back( state.platform );
        }
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
    for( const runtime_state &state : active_states ) {
        if( state.type == mod_source_type::mod ) {
            result.push_back( state.id );
        }
    }
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
    if( script_reload_in_progress ) {
        error = "Lua script reload is already in progress; retry after it returns";
        return false;
    }
    if( active_states.empty() ) {
        error.clear();
        return true;
    }

    std::ostringstream active_fingerprint;
    std::vector<mod_source> sources;
    sources.reserve( active_states.size() );
    for( const runtime_state &state : active_states ) {
        lua_Debug frame;
        if( lua_getstack( state.lua->lua_state(), 0, &frame ) != 0 ) {
            error = "Lua code is still executing for Mod '" + state.id +
                    "'; retry script reload after it returns";
            return false;
        }
        active_fingerprint << state.id.size() << ':' << state.id << ':'
                           << runtime_fingerprint( state.platform ) << ';';
        sources.push_back( { state.id, state.root, state.entry, state.type } );
    }

    // Candidate entry scripts and replacement lifecycle callbacks can enter
    // native code. In particular, new world_ready callbacks execute before
    // prepared_states becomes active_states, so the old stack check is not
    // sufficient to protect the transaction from a nested reload.
    const restore_on_out_of_scope<bool> restore_reload_flag( script_reload_in_progress );
    script_reload_in_progress = true;
    if( !prepare_mods( sources, error, *active_states.front().selected_mod_ids ) ) {
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
        if( state.type == mod_source_type::mod ) {
            replacement.push_back( state.platform );
        }
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

namespace
{
std::string console_string( const char *text, const std::size_t size )
{
    // Bound presentation only, without restricting script execution or values.
    int remaining = static_cast<int>( std::min<std::size_t>( size, 1024 ) );
    std::string result = "\"";
    while( remaining > 0 ) {
        const std::uint32_t ch = UTF8_getch( &text, &remaining );
        if( ch == '\\' || ch == '"' ) {
            result += '\\';
            result += static_cast<char>( ch );
        } else if( ch < 32 || ch == 127 ) {
            constexpr char hex[] = "0123456789abcdef";
            result += "\\x";
            result += hex[ch >> 4];
            result += hex[ch & 15];
        } else {
            result += utf32_to_utf8( ch );
        }
    }
    result += '"';
    if( size > 1024 ) {
        result += " [truncated]";
    }
    return result;
}

std::string console_value( lua_State *lua, const int index, const bool expand_table )
{
    const int type = lua_type( lua, index );
    if( type == LUA_TSTRING ) {
        std::size_t size = 0;
        const char *text = lua_tolstring( lua, index, &size );
        return console_string( text, size );
    }
    if( type == LUA_TNUMBER ) {
        // Do not convert a live lua_next numeric key into a string on the stack.
        if( lua_isinteger( lua, index ) ) {
            return std::to_string( lua_tointeger( lua, index ) );
        }
        std::ostringstream number;
        number << std::setprecision( std::numeric_limits<lua_Number>::max_digits10 ) <<
               lua_tonumber( lua, index );
        return number.str();
    }
    if( type == LUA_TBOOLEAN ) {
        return lua_toboolean( lua, index ) ? "true" : "false";
    }
    if( type == LUA_TNIL ) {
        return "nil";
    }
    if( type == LUA_TTABLE && expand_table ) {
        if( !lua_checkstack( lua, 2 ) ) {
            return "<table: insufficient stack space>";
        }
        const int top = lua_gettop( lua );
        const on_out_of_scope restore_stack( [lua, top]() {
            lua_settop( lua, top );
        } );
        const int table = lua_absindex( lua, index );
        int count = 0;
        std::string result = "{";
        lua_pushnil( lua );
        while( lua_next( lua, table ) != 0 ) {
            if( count == 20 ) {
                result += "\n  [remaining fields omitted]";
                break;
            }
            result += "\n  [" + console_value( lua, -2, false ) + "] = " +
                      console_value( lua, -1, false );
            ++count;
            lua_pop( lua, 1 );
        }
        return result + ( count == 0 ? "}" : "\n}" );
    }
    return std::string( "<" ) + lua_typename( lua, type ) + ">";
}
} // namespace

bool execute_console( const std::string &mod_id, const std::string &source,
                      std::string &output, std::string &error )
{
    output.clear();
    error.clear();
    if( script_reload_in_progress ) {
        error = "Lua script reload is in progress; retry after it returns";
        return false;
    }
    const auto found = std::find_if( active_states.begin(), active_states.end(),
    [&mod_id]( const runtime_state & state ) {
        return state.type == mod_source_type::mod && state.id == mod_id;
    } );
    if( found == active_states.end() ) {
        error = "No active Lua Mod named '" + mod_id + "'";
        return false;
    }
    lua_State *const lua = found->lua->lua_state();
    lua_Debug frame;
    if( lua_getstack( lua, 0, &frame ) != 0 ) {
        error = "Lua code is still executing for Mod '" + mod_id + "'";
        return false;
    }
    try {
        // The explicit console invocation is a runtime callback. Keep the
        // existing world-ready, owner, handle and domain mutation checks.
        const detail::callback_scope callback( *found->platform );
        const sol::protected_function_result result = found->lua->safe_script(
                source, sol::script_pass_on_error, "=CCB console: " + mod_id, sol::load_mode::text );
        if( !result.valid() ) {
            const sol::error script_error = result;
            error = "Lua console [" + mod_id + "]: " + script_error.what();
            return false;
        }
        const int shown = std::min( result.return_count(), 16 );
        for( int i = 0; i < shown; ++i ) {
            const int index = result.stack_index() + i;
            if( i != 0 ) {
                output += '\n';
            }
            output += console_value( lua, index, true );
        }
        if( result.return_count() == 0 ) {
            output = "Completed (no return values)";
        } else if( result.return_count() > shown ) {
            output += "\n[remaining return values omitted]";
        }
        return true;
    } catch( const std::exception &exception ) {
        error = "Lua console [" + mod_id + "]: " + exception.what();
        return false;
    }
}

void on_world_load_started()
{
    runtime_world_load_started();
}

void on_world_ready( bool new_game, const std::function<void()> &finish_native_load )
{
    runtime_world_ready( new_game, finish_native_load );
}

void before_save()
{
    runtime_before_save();
}

bool save_persistent_state( std::string &error )
{
    return runtime_save( error );
}

void after_save( bool success, std::string_view error )
{
    runtime_after_save( success, error );
}

void on_turn()
{
    runtime_process_tasks();
}

} // namespace cata::lua_platform

#else // CATA_ENABLE_LUA_PLATFORM

namespace cata::lua_platform
{

namespace
{

constexpr const char *disabled_error = "Lua-first Platform is not enabled in this build";

} // namespace

void load_core_content( const std::filesystem::path & )
{
}

void load_mod_content_with_data( const mod_source &, const std::set<std::string> & )
{
    throw std::runtime_error( "Lua-first Platform support is disabled" );
}

bool read_mod_definition( const std::filesystem::path &, mod_definition &, std::string &error )
{
    error = disabled_error;
    return false;
}

bool prepare_mods( const std::vector<mod_source> &sources, std::string &error,
                   const std::set<std::string> & )
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

bool execute_console( const std::string &, const std::string &,
                      std::string &output, std::string &error )
{
    output.clear();
    error = disabled_error;
    return false;
}

void on_world_load_started()
{
}

void on_world_ready( bool, const std::function<void()> &finish_native_load )
{
    if( finish_native_load ) {
        finish_native_load();
    }
}

void on_restored_avatar_event( const cata::event & )
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

void after_save( bool, std::string_view )
{
}

void on_turn()
{
}

} // namespace cata::lua_platform

#endif // CATA_ENABLE_LUA_PLATFORM
