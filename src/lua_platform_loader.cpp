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
