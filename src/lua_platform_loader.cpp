#include "lua_platform_loader.h"

#include <algorithm>
#include <array>
#include <cmath>
#include <cstddef>
#include <cstdint>
#include <exception>
#include <fstream>
#include <iomanip>
#include <initializer_list>
#include <iterator>
#include <limits>
#include <map>
#include <memory>
#include <optional>
#include <set>
#include <sstream>
#include <stdexcept>
#include <string_view>
#include <system_error>
#include <type_traits>
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

#include "lua_platform_content.h"
#include "lua_platform_content_text.h"
#include "lua_platform_runtime.h"
#include "lua_platform_runtime_internal.h"
#include "lua_platform_sol.h"
#include "achievement.h"
#include "ammo.h"
#include "ascii_art.h"
#include "cata_scope_helpers.h"
#include "catacharset.h"
#include "character_modifier.h"
#include "condition.h"
#include "construction.h"
#include "dialogue.h"
#include "enum_conversions.h"
#include "enums.h"
#include "native_file_path.h"
#include "fault.h"
#include "field_type.h"
#include "generic_factory.h"
#include "harvest.h"
#include "item_action.h"
#include "item_factory.h"
#include "itype.h"
#include "json.h"
#include "json_loader.h"
#include "magic.h"
#include "math_parser_type.h"
#include "martialarts.h"
#include "map_extras.h"
#include "mapdata.h"
#include "mapgen.h"
#include "mod_manager.h"
#include "mod_tracker.h"
#include "mission.h"
#include "monfaction.h"
#include "monstergenerator.h"
#include "mutation.h"
#include "npc.h"
#include "npc_class.h"
#include "omdata.h"
#include "overmap.h"
#include "output.h"
#include "profession.h"
#include "proficiency.h"
#include "recipe_dictionary.h"
#include "regional_climate.h"
#include "regional_settings.h"
#include "scenario.h"
#include "start_location.h"
#include "trap.h"
#include "veh_type.h"
#include "vehicle_group.h"
#include "vehicle_part_location.h"
#include "weakpoint.h"
#include "widget.h"
#include "worldfactory.h"
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
    if( const auto path = values.get<sol::optional<std::string>>( "data_path" ) ) {
        result.data_path = *path;
    }
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
    "data_path", &mod_definition::data_path,
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

struct static_dialogue_predicate {
    talk_predicate test;
};

struct static_dialogue_action {
    talk_effect_fun_t effect;
};

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
    ccb.new_usertype<static_dialogue_predicate>( "StaticDialoguePredicate", sol::no_constructor );
    ccb.new_usertype<static_dialogue_action>( "StaticDialogueAction", sol::no_constructor );
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
    write_placement_member<bool>( json, options, "dialogue_on_access", "//ccb_lua_computer_dialogue" );
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

void write_static_mapgen_layout_fields( JsonOut &json, const sol::table &layout,
                                        std::size_t max_rows )
{
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
}

void write_static_mapgen_layout( JsonOut &json, const sol::table &layout, std::size_t max_rows )
{
    json.member( "object" );
    json.start_object();
    write_static_mapgen_layout_fields( json, layout, max_rows );
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

using item_field = std::pair<const char *, const char *>;

template<typename T>
void write_item_fields( JsonOut &json, const sol::table &values,
                        std::initializer_list<item_field> fields )
{
    for( const auto &[field, native] : fields ) {
        write_placement_member<T>( json, values, field, native );
    }
}

void write_item_ids( JsonOut &json, const sol::table &values,
                     std::initializer_list<item_field> fields )
{
    for( const auto &[field, native] : fields ) {
        if( const auto ids = values.get<sol::optional<sol::table>>( field ) ) {
            json.member( native, bounded_string_array( *ids, field,
                         std::numeric_limits<std::size_t>::max(), "static definition" ) );
        }
    }
}

void write_item_text_value( JsonOut &json, const char *field, const sol::object &value,
                            bool allow_plural, bool infer_regular_plural = false )
{
    if( value.get_type() == sol::type::string ) {
        json.write( value.as<std::string>() );
        return;
    }
    const detail::localized_text &text = value.as<const detail::localized_text &>();
    if( text.plural && !allow_plural ) {
        throw std::invalid_argument( std::string( field ) + " does not accept plural text" );
    }
    json.start_object();
    if( text.plural && *text.plural == text.singular ) {
        json.member( "str_sp", text.singular );
    } else {
        json.member( "str", text.singular );
        if( text.plural && ( !infer_regular_plural || *text.plural != text.singular + "s" ) ) {
            json.member( "str_pl", *text.plural );
        }
    }
    if( text.context ) {
        json.member( "ctxt", *text.context );
    }
    json.end_object();
}

void write_item_text( JsonOut &json, const char *field, const sol::object &value,
                      bool allow_plural, bool infer_regular_plural = false )
{
    if( value.get_type() != sol::type::nil ) {
        json.member( field );
        write_item_text_value( json, field, value, allow_plural, infer_regular_plural );
    }
}

void write_static_native_text( JsonOut &json, const sol::table &options, const char *field,
                               const char *native )
{
    const sol::object value = options.raw_get<sol::object>( field );
    if( value.is<detail::localized_text>() ) {
        // These native readers translate their strings at the point of use.
        const detail::localized_text &text = value.as<const detail::localized_text &>();
        if( text.context || text.plural ) {
            throw std::invalid_argument( std::string( field ) + " only accepts unqualified singular text" );
        }
        json.member( native, text.singular );
    } else {
        write_placement_member<std::string>( json, options, field, native );
    }
}

template<typename T>
void write_item_keyed_values( JsonOut &json, const char *field, const sol::table &values )
{
    json.member( field );
    json.start_object();
    for( const auto &[id, value] : values ) {
        json.member( id.as<std::string>(), value.as<T>() );
    }
    json.end_object();
}

void write_item_materials( JsonOut &json, const sol::table &values, bool armor )
{
    json.member( "material" );
    json.start_array();
    const std::size_t count = values.size();
    for( std::size_t i = 1; i <= count; ++i ) {
        const sol::object entry = values.raw_get<sol::object>( i );
        if( entry.get_type() == sol::type::string ) {
            json.write( entry.as<std::string>() );
            continue;
        }
        const sol::table material = entry.as<sol::table>();
        json.start_object();
        json.member( "type", material.get<std::string>( "id" ) );
        if( armor ) {
            write_item_fields<double>( json, material, { { "thickness", "thickness" } } );
            write_item_fields<int>( json, material, { { "coverage", "covered_by_mat" } } );
            write_item_fields<bool>( json, material, { { "ignore_sheet_thickness", "ignore_sheet_thickness" } } );
        } else {
            write_item_fields<double>( json, material, { { "portions", "portion" } } );
        }
        json.end_object();
    }
    json.end_array();
}

void write_item_armor( JsonOut &json, const sol::table &armor )
{
    write_item_fields<double>( json, armor, { { "thickness", "material_thickness" } } );
    write_item_fields<int>( json, armor, {
        { "warmth", "warmth" }, { "environmental_protection", "environmental_protection" },
        { "filtered_protection", "environmental_protection_with_filter" },
    } );
    write_item_fields<bool>( json, armor, { { "sided", "sided" }, { "power_armor", "power_armor" } } );
    write_item_fields<std::string>( json, armor, { { "broken_item", "non_functional" } } );
    write_item_ids( json, armor, { { "covers", "covers" }, { "valid_mods", "valid_mods" } } );
    write_item_text( json, "damage_verb", armor.raw_get<sol::object>( "damage_verb" ), false );
    if( const auto portions = armor.get<sol::optional<sol::table>>( "portions" ) ) {
        json.member( "armor" );
        json.start_array();
        const std::size_t count = portions->size();
        for( std::size_t i = 1; i <= count; ++i ) {
            const sol::table portion = portions->raw_get<sol::table>( i );
            json.start_object();
            write_item_ids( json, portion, {
                { "covers", "covers" }, { "covers_except", "covers_except" },
                { "subparts", "specifically_covers" }, { "subparts_except", "specifically_covers_except" },
                { "layers", "layers" }, { "encumbrance_modifiers", "encumbrance_modifiers" },
            } );
            write_item_fields<int>( json, portion, {
                { "coverage", "coverage" }, { "melee_coverage", "cover_melee" },
                { "ranged_coverage", "cover_ranged" }, { "vitals_coverage", "cover_vitals" },
                { "environmental_protection", "environmental_protection" },
                { "filtered_protection", "environmental_protection_with_filter" },
            } );
            write_item_fields<bool>( json, portion, { { "covers_all", "covers_all" },
                { "rigid_only", "rigid_layer_only" } } );
            write_item_fields<double>( json, portion, { { "thickness", "material_thickness" },
                { "volume_encumbrance", "volume_encumber_modifier" } } );
            write_item_fields<std::string>( json, portion, { { "breathability", "breathability" } } );
            write_mapgen_range( json, "encumbrance", portion.raw_get<sol::object>( "encumbrance" ) );
            if( const auto materials = portion.get<sol::optional<sol::table>>( "materials" ) ) {
                write_item_materials( json, *materials, true );
            }
            json.end_object();
        }
        json.end_array();
    }
}

void write_item_vitamins( JsonOut &json, const sol::table &values, const char *field )
{
    if( const auto nutrients = values.get<sol::optional<sol::table>>( field ) ) {
        json.member( "vitamins" );
        json.start_array();
        const std::size_t count = nutrients->size();
        for( std::size_t i = 1; i <= count; ++i ) {
            const sol::table nutrient = nutrients->raw_get<sol::table>( i );
            json.start_array();
            json.write( nutrient.get<std::string>( "id" ) );
            const sol::object amount = nutrient.raw_get<sol::object>( "amount" );
            if( amount.get_type() == sol::type::string ) {
                json.write( amount.as<std::string>() );
            } else {
                json.write( amount.as<int>() );
            }
            json.end_array();
        }
        json.end_array();
    }
}

void write_item_rot_spawn( JsonOut &json, const sol::table &values )
{
    if( const auto spawn = values.get<sol::optional<sol::table>>( "rot_spawn" ) ) {
        json.member( "rot_spawn" );
        json.start_object();
        write_item_fields<std::string>( json, *spawn,
        { { "monster", "monster" }, { "group", "group" } } );
        write_placement_member<int>( json, *spawn, "chance", "chance" );
        write_mapgen_range( json, "amount", spawn->raw_get<sol::object>( "amount" ) );
        json.end_object();
    }
}

void write_item_comestible( JsonOut &json, const sol::table &food )
{
    if( const auto addictions = food.get<sol::optional<sol::table>>( "addictions" ) ) {
        if( food.raw_get<sol::object>( "addiction" ).get_type() != sol::type::nil ) {
            throw std::invalid_argument( "comestible requires either addiction or addictions" );
        }
        json.member( "addiction_type" );
        json.start_array();
        for( std::size_t i = 1, count = addictions->size(); i <= count; ++i ) {
            const sol::object entry = addictions->raw_get<sol::object>( i );
            if( entry.get_type() == sol::type::string ) {
                json.write( entry.as<std::string>() );
            } else {
                const sol::table addiction = entry.as<sol::table>();
                json.start_object();
                json.member( "addiction", addiction.get<std::string>( "id" ) );
                json.member( "potential", addiction.get<int>( "potential" ) );
                json.end_object();
            }
        }
        json.end_array();
    }
    write_item_fields<std::string>( json, food, {
        { "kind", "comestible_type" }, { "tool", "tool" }, { "cooks_like", "cooks_like" },
        { "eats_like", "eats_like" }, { "smoking_result", "smoking_result" },
        { "cooked_item", "cook_result" }, { "cooking_energy", "cook_cost_energy" },
        { "addiction", "addiction_type" },
    } );
    write_item_fields<int>( json, food, {
        { "servings", "charges" }, { "calories", "calories" }, { "fun", "fun" },
        { "quench", "quench" }, { "healthy", "healthy" }, { "stimulation", "stim" },
        { "sensitivity", "sensitive" }, { "sleepiness", "sleepiness_mod" },
        { "parasites", "parasites" }, { "addiction_potential", "addiction_potential" },
        { "monotony_penalty", "monotony_penalty" },
    } );
    write_placement_member<double>( json, food, "freezing_point", "freezing_point" );
    const sol::object shelf_life = food.raw_get<sol::object>( "shelf_life" );
    if( shelf_life.get_type() == sol::type::string ) {
        json.member( "spoils_in", shelf_life.as<std::string>() );
    } else if( shelf_life.get_type() == sol::type::number ) {
        json.member( "spoils_in", shelf_life.as<int>() );
    }
    write_item_ids( json, food, { { "pet_food", "petfood" } } );
    write_item_vitamins( json, food, "vitamins" );
    write_item_rot_spawn( json, food );
    if( const auto handler = food.get<sol::optional<std::string>>( "on_consume" ) ) {
        if( handler->empty() ) {
            throw std::invalid_argument( "item consumption handler id cannot be empty" );
        }
        json.member( "//ccb_lua_consume_handler", *handler );
    }
}

void write_item_damage_unit( JsonOut &json, const sol::table &unit )
{
    json.start_object();
    json.member( "damage_type", unit.get<std::string>( "type" ) );
    write_item_fields<double>( json, unit, {
        { "amount", "amount" }, { "penetration", "armor_penetration" },
        { "damage_multiplier", "damage_multiplier" }, { "armor_multiplier", "armor_multiplier" },
        { "constant_damage_multiplier", "constant_damage_multiplier" },
        { "constant_armor_multiplier", "constant_armor_multiplier" },
    } );
    if( const auto barrels = unit.get<sol::optional<sol::table>>( "barrels" ) ) {
        json.member( "barrels" );
        json.start_array();
        for( std::size_t i = 1, count = barrels->size(); i <= count; ++i ) {
            const sol::table barrel = barrels->raw_get<sol::table>( i );
            json.start_object();
            json.member( "barrel_length", barrel.get<std::string>( "length" ) );
            json.member( "amount", barrel.get<double>( "amount" ) );
            json.end_object();
        }
        json.end_array();
    }
    json.end_object();
}

void write_item_damage( JsonOut &json, const sol::table &options,
                        const char *field, const char *native )
{
    if( const auto damage = options.get<sol::optional<sol::table>>( field ) ) {
        json.member( native );
        if( damage->raw_get<sol::object>( "type" ).get_type() != sol::type::nil ) {
            write_item_damage_unit( json, *damage );
            return;
        }
        json.start_array();
        for( std::size_t i = 1, count = damage->size(); i <= count; ++i ) {
            write_item_damage_unit( json, damage->raw_get<sol::table>( i ) );
        }
        json.end_array();
    }
}

void write_item_ammunition( JsonOut &json, const sol::table &ammo )
{
    write_item_fields<std::string>( json, ammo, {
        { "type", "ammo_type" }, { "casing", "casing" }, { "drop", "drop" },
    } );
    write_item_fields<int>( json, ammo, {
        { "range", "range" }, { "dispersion", "dispersion" }, { "recoil", "recoil" },
        { "recovery_chance", "recovery_chance" }, { "count", "count" }, { "loudness", "loudness" },
        { "projectile_count", "projectile_count" }, { "shot_spread", "shot_spread" },
    } );
    write_item_fields<double>( json, ammo, {
        { "drop_chance", "drop_chance" }, { "range_multiplier", "range_multiplier" },
        { "critical_multiplier", "critical_multiplier" },
    } );
    write_item_fields<bool>( json, ammo, {
        { "drop_active", "drop_active" }, { "show_stats", "show_stats" },
    } );
    write_item_ids( json, ammo, { { "effects", "effects" } } );
    write_item_damage( json, ammo, "damage", "damage" );
    write_item_damage( json, ammo, "shot_damage", "shot_damage" );
    if( const auto spread = ammo.get<sol::optional<sol::table>>( "barrel_dispersion" ) ) {
        json.member( "dispersion_modifier" );
        json.start_array();
        for( std::size_t i = 1, count = spread->size(); i <= count; ++i ) {
            const sol::table barrel = spread->raw_get<sol::table>( i );
            json.start_object();
            json.member( "barrel_length", barrel.get<std::string>( "length" ) );
            json.member( "dispersion", barrel.get<int>( "dispersion" ) );
            json.end_object();
        }
        json.end_array();
    }
}

void write_item_magazine( JsonOut &json, const sol::table &magazine )
{
    write_item_ids( json, magazine, { { "ammunition", "ammo_type" } } );
    write_item_fields<std::string>( json, magazine, {
        { "default_ammo", "default_ammo" }, { "linkage", "linkage" },
    } );
    write_item_fields<int>( json, magazine, {
        { "capacity", "capacity" }, { "count", "count" }, { "reload_time", "reload_time" },
    } );
    write_placement_member<double>( json, magazine, "jam_multiplier", "mag_jam_mult" );
}

void write_item_gun_modes( JsonOut &json, const sol::table &modes, const char *field = "modes" )
{
    json.member( field );
    json.start_array();
    for( std::size_t i = 1, count = modes.size(); i <= count; ++i ) {
        const sol::table mode = modes.raw_get<sol::table>( i );
        const auto id = mode.get<sol::optional<std::string>>( "id" );
        const auto rpm = mode.get<sol::optional<int>>( "rpm" );
        const auto quantity = mode.get<sol::optional<int>>( "quantity" );
        if( id ? rpm.has_value() == quantity.has_value() : !rpm || !quantity ) {
            throw std::invalid_argument( "firing modes require one of rpm or quantity, or both for a fixed burst" );
        }
        json.start_array();
        if( !id ) {
            json.write( "brust-rpm" );
            json.write( std::to_string( *rpm ) );
            json.write( *quantity );
        } else {
            json.write( *id );
            write_item_text_value( json, "firing mode label", mode.raw_get<sol::object>( "label" ), false );
            if( rpm ) {
                json.write( std::to_string( *rpm ) );
            } else {
                json.write( *quantity );
            }
        }
        if( const auto flags = mode.get<sol::optional<sol::table>>( "flags" ) ) {
            json.write( bounded_string_array( *flags, "flags",
                        std::numeric_limits<std::size_t>::max(), "firing mode" ) );
        }
        json.end_array();
    }
    json.end_array();
}

std::string read_item_display_id( const sol::object &value, std::string_view context = {} )
{
    if( value.get_type() == sol::type::string ) {
        return value.as<std::string>();
    }
    const detail::localized_text &text = value.as<const detail::localized_text &>();
    if( text.plural || ( text.context && *text.context != context ) ) {
        throw std::invalid_argument( "invalid translation context for item identifier" );
    }
    return text.singular;
}

void write_item_counted_ids( JsonOut &json, const sol::table &options, const char *field,
                             const char *native )
{
    if( const auto entries = options.get<sol::optional<sol::table>>( field ) ) {
        json.member( native );
        json.start_array();
        const std::size_t count = checked_dense_array_size( *entries, field,
                                  std::numeric_limits<std::size_t>::max() );
        for( std::size_t i = 1; i <= count; ++i ) {
            const sol::table entry = entries->raw_get<sol::table>( i );
            json.start_array();
            json.write( read_item_display_id( entry.raw_get<sol::object>( "id" ) ) );
            json.write( entry.get<int>( "count" ) );
            json.end_array();
        }
        json.end_array();
    }
}

void write_item_gun( JsonOut &json, const sol::table &gun )
{
    const sol::object skill = gun.raw_get<sol::object>( "skill" );
    if( skill.get_type() != sol::type::nil ) {
        json.member( "skill", read_item_display_id( skill, "gun_type_type" ) );
    }
    write_item_fields<std::string>( json, gun, {
        { "barrel_volume", "barrel_volume" },
        { "barrel_length", "barrel_length" }, { "energy_drain", "energy_drain" },
    } );
    write_item_fields<int>( json, gun, {
        { "range", "range" }, { "dispersion", "dispersion" }, { "sight_dispersion", "sight_dispersion" },
        { "recoil", "recoil" }, { "handling", "handling" }, { "durability", "durability" },
        { "loudness", "loudness" }, { "clip_size", "clip_size" }, { "reload_time", "reload" },
        { "reload_noise_volume", "reload_noise_volume" }, { "blackpowder_tolerance", "blackpowder_tolerance" },
        { "min_cycle_recoil", "min_cycle_recoil" }, { "ammo_per_shot", "ammo_to_fire" },
    } );
    write_item_fields<double>( json, gun, {
        { "heat_per_shot", "heat_per_shot" }, { "cooling", "cooling_value" },
        { "overheat_threshold", "overheat_threshold" }, { "jam_multiplier", "gun_jam_mult" },
    } );
    write_item_ids( json, gun, {
        { "ammunition", "ammo" }, { "built_in_mods", "built_in_mods" },
        { "default_mods", "default_mods" }, { "effects", "ammo_effects" },
    } );
    write_item_text( json, "reload_noise", gun.raw_get<sol::object>( "reload_noise" ), false );
    write_item_damage( json, gun, "damage", "ranged_damage" );
    if( const auto modes = gun.get<sol::optional<sol::table>>( "modes" ) ) {
        write_item_gun_modes( json, *modes );
    }
    write_item_counted_ids( json, gun, "mod_locations", "valid_mod_locations" );
    if( const auto injury = gun.get<sol::optional<sol::table>>( "injuries" ) ) {
        write_item_keyed_values<int>( json, "hurt_part_when_fired", *injury );
    }
    if( const auto modes = gun.get<sol::optional<sol::table>>( "firing_requirements" ) ) {
        json.member( "firing_requirements" );
        json.start_object();
        for( const auto &[id, value] : *modes ) {
            const sol::table requirements = value.as<sol::table>();
            json.member( id.as<std::string>() );
            json.start_array();
            for( std::size_t i = 1, count = requirements.size(); i <= count; ++i ) {
                const sol::table req = requirements.raw_get<sol::table>( i );
                json.start_object();
                json.member( "pocket", req.get<std::string>( "pocket" ) );
                json.member( "qty", req.get<int>( "count" ) );
                json.end_object();
            }
            json.end_array();
        }
        json.end_object();
    }
}

void write_item_pockets( JsonOut &json, const sol::table &pockets, const char *field = "pocket_data" )
{
    json.member( field );
    json.start_array();
    const std::size_t count = pockets.size();
    for( std::size_t i = 1; i <= count; ++i ) {
        const sol::table pocket = pockets.raw_get<sol::table>( i );
        json.start_object();
        write_item_fields<std::string>( json, pocket, {
            { "kind", "pocket_type" }, { "id", "id" }, { "capacity", "max_contains_volume" },
            { "mass_limit", "max_contains_weight" }, { "max_item_length", "max_item_length" },
            { "min_item_length", "min_item_length" }, { "min_item_volume", "min_item_volume" },
            { "max_item_volume", "max_item_volume" }, { "magazine_well", "magazine_well" },
            { "default_magazine", "default_magazine" },
            { "memory_capacity", "ememory_max" },
        } );
        write_item_text( json, "name", pocket.raw_get<sol::object>( "name" ), false );
        write_item_text( json, "description", pocket.raw_get<sol::object>( "description" ), false );
        write_item_fields<int>( json, pocket, {
            { "moves", "moves" }, { "ripoff", "ripoff" }, { "extra_encumbrance", "extra_encumbrance" },
        } );
        write_item_fields<double>( json, pocket, {
            { "volume_encumbrance", "volume_encumber_modifier" }, { "weight_multiplier", "weight_multiplier" },
            { "volume_multiplier", "volume_multiplier" }, { "spoil_multiplier", "spoil_multiplier" },
        } );
        write_item_fields<bool>( json, pocket, {
            { "holster", "holster" }, { "ablative", "ablative" }, { "transparent", "transparent" },
            { "rigid", "rigid" }, { "watertight", "watertight" }, { "airtight", "airtight" },
            { "inherits_flags", "inherits_flags" }, { "fire_protection", "fire_protection" },
            { "open_container", "open_container" },
        } );
        write_item_ids( json, pocket, {
            { "allowed_flags", "flag_restriction" }, { "allowed_items", "item_restriction" },
            { "allowed_materials", "material_restriction" }, { "allowed_speedloaders", "allowed_speedloaders" },
        } );
        if( const auto ammo = pocket.get<sol::optional<sol::table>>( "ammunition" ) ) {
            write_item_keyed_values<int>( json, "ammo_restriction", *ammo );
        }
        json.end_object();
    }
    json.end_array();
}

void write_item_mod( JsonOut &json, const sol::table &mod )
{
    write_item_ids( json, mod, {
        { "ammo_types", "ammo_modifier" }, { "compatible_ammo", "acceptable_ammo" }
    } );
    write_placement_member<double>( json, mod, "capacity_multiplier", "capacity_multiplier" );
    if( const auto pockets = mod.get<sol::optional<sol::table>>( "added_pockets" ) ) {
        write_item_pockets( json, *pockets, "pocket_mods" );
    }
    if( const auto adapters = mod.get<sol::optional<sol::table>>( "magazine_adapters" ) ) {
        json.member( "magazine_adaptor" );
        json.start_array();
        const std::size_t count = checked_dense_array_size( *adapters, "magazine_adapters",
                                  std::numeric_limits<std::size_t>::max() );
        for( std::size_t i = 1; i <= count; ++i ) {
            const sol::table adapter = adapters->raw_get<sol::table>( i );
            json.start_array();
            json.write( adapter.get<std::string>( "ammo_type" ) );
            json.write( bounded_string_array( adapter.get<sol::table>( "magazines" ), "magazines",
                        std::numeric_limits<std::size_t>::max(), "magazine adapter" ) );
            json.end_array();
        }
        json.end_array();
    }
}

void write_item_gunmod( JsonOut &json, const sol::table &mod )
{
    write_item_mod( json, mod );
    write_item_fields<std::string>( json, mod, {
        { "install_time", "install_time" }, { "barrel_length", "barrel_length" },
        { "energy_drain_modifier", "energy_drain_modifier" }
    } );
    write_static_native_text( json, mod, "location", "location" );
    write_item_fields<int>( json, mod, {
        { "loudness_modifier", "loudness_modifier" }, { "to_hit_modifier", "to_hit_mod" },
        { "dispersion_modifier", "dispersion_modifier" }, { "field_of_view", "field_of_view" },
        { "sight_dispersion", "sight_dispersion" }, { "aim_speed", "aim_speed" },
        { "handling_modifier", "handling_modifier" }, { "range_modifier", "range_modifier" },
        { "consume_chance", "consume_chance" }, { "consume_divisor", "consume_divisor" },
        { "ammo_per_shot_modifier", "ammo_to_fire_modifier" },
        { "min_cycle_recoil", "overwrite_min_cycle_recoil" }, { "reload_modifier", "reload_modifier" },
        { "strength_modifier", "min_str_required_mod" }, { "prone_strength_modifier", "min_str_required_mod_if_prone" }
    } );
    write_item_fields<double>( json, mod, {
        { "loudness_multiplier", "loudness_multiplier" }, { "aim_speed_modifier", "aim_speed_modifier" },
        { "range_multiplier", "range_multiplier" }, { "shot_spread_modifier", "shot_spread_multiplier_modifier" },
        { "energy_drain_multiplier", "energy_drain_multiplier" }, { "ammo_per_shot_multiplier", "ammo_to_fire_multiplier" },
        { "weight_multiplier", "weight_multiplier" }, { "overheat_threshold_modifier", "overheat_threshold_modifier" },
        { "overheat_threshold_multiplier", "overheat_threshold_multiplier" },
        { "cooling_modifier", "cooling_value_modifier" }, { "cooling_multiplier", "cooling_value_multiplier" },
        { "heat_per_shot_modifier", "heat_per_shot_modifier" }, { "heat_per_shot_multiplier", "heat_per_shot_multiplier" }
    } );
    write_item_fields<bool>( json, mod, {
        { "bayonet", "is_bayonet" }, { "visible_when_installed", "is_visible_when_installed" }
    } );
    write_item_ids( json, mod, {
        { "effects", "ammo_effects" }, { "hidden_modes", "hide_modes" },
        { "incompatible_mods", "blacklist_mod" }, { "incompatible_slots", "blacklist_slot" }
    } );
    if( const auto targets = mod.get<sol::optional<sol::table>>( "targets" ) ) {
        json.member( "mod_targets" );
        json.start_array();
        const std::size_t count = checked_dense_array_size( *targets, "targets",
                                  std::numeric_limits<std::size_t>::max() );
        for( std::size_t i = 1; i <= count; ++i ) {
            json.write( read_item_display_id( targets->raw_get<sol::object>( i ), "gun_type_type" ) );
        }
        json.end_array();
    }
    write_item_counted_ids( json, mod, "added_slots", "add_mod" );
    write_item_damage( json, mod, "damage_modifier", "damage_modifier" );
    if( const auto modes = mod.get<sol::optional<sol::table>>( "modes" ) ) {
        write_item_gun_modes( json, *modes, "mode_modifier" );
    }
}

void write_item_artifact( JsonOut &json, const sol::table &artifact )
{
    if( const auto passives = artifact.get<sol::optional<sol::table>>( "enchantments" ) ) {
        json.member( "passive_effects" );
        json.start_array();
        const auto ids = bounded_string_array( *passives, "enchantments",
                        std::numeric_limits<std::size_t>::max(), "artifact" );
        for( const std::string &id : ids ) {
            json.start_object();
            json.member( "id", id );
            json.end_object();
        }
        json.end_array();
    }
    if( const auto charge = artifact.get<sol::optional<sol::table>>( "charge" ) ) {
        json.member( "charge_info" );
        json.start_object();
        write_item_fields<std::string>( json, *charge, {
            { "recharge_type", "recharge_type" }, { "recharge_condition", "recharge_condition" },
            { "interval", "time" }
        } );
        write_item_fields<int>( json, *charge, {
            { "charges", "charges" }, { "charges_per_use", "charges_per_use" },
            { "max_charges", "max_charges" }
        } );
        write_placement_member<bool>( json, *charge, "regenerate_ammo", "regenerate_ammo" );
        json.end_object();
    }
}

void write_item_variants( JsonOut &json, const sol::table &options )
{
    if( const auto variants = options.get<sol::optional<sol::table>>( "variants" ) ) {
        json.member( "variants" );
        json.start_array();
        const std::size_t count = variants->size();
        for( std::size_t i = 1; i <= count; ++i ) {
            const sol::table variant = variants->raw_get<sol::table>( i );
            json.start_object();
            json.member( "id", variant.get<std::string>( "id" ) );
            write_item_text( json, "name", variant.raw_get<sol::object>( "name" ), true, true );
            write_item_text( json, "description", variant.raw_get<sol::object>( "description" ), false );
            write_item_fields<std::string>( json, variant, {
                { "symbol", "symbol" }, { "color", "color" }, { "ascii_picture", "ascii_picture" },
            } );
            write_item_fields<bool>( json, variant, { { "append", "append" },
                { "expand_snippets", "expand_snippets" } } );
            write_placement_member<int>( json, variant, "weight", "weight" );
            json.end_object();
        }
        json.end_array();
    }
}

void write_item_conditional_names( JsonOut &json, const sol::table &names )
{
    json.member( "conditional_names" );
    json.start_array();
    const std::size_t count = names.size();
    for( std::size_t i = 1; i <= count; ++i ) {
        const sol::table name = names.raw_get<sol::table>( i );
        json.start_object();
        write_item_fields<std::string>( json, name,
        { { "kind", "type" }, { "key", "condition" }, { "value", "value" } } );
        write_item_text( json, "name", name.raw_get<sol::object>( "name" ), true, true );
        json.end_object();
    }
    json.end_array();
}

void write_item_faults( JsonOut &json, const sol::table &faults )
{
    json.member( "faults" );
    json.start_array();
    const std::size_t count = faults.size();
    for( std::size_t i = 1; i <= count; ++i ) {
        const sol::table fault = faults.raw_get<sol::table>( i );
        json.start_object();
        write_item_fields<std::string>( json, fault, { { "fault", "fault" }, { "group", "fault_group" } } );
        write_item_fields<double>( json, fault, { { "weight", "weight" },
            { "weight_multiplier", "weight_mult" } } );
        write_item_fields<int>( json, fault, { { "weight_override", "weight_override" },
            { "weight_add", "weight_add" } } );
        json.end_object();
    }
    json.end_array();
}

void write_item_qualities( JsonOut &json, const sol::table &qualities, const char *field = "qualities" )
{
    json.member( field );
    json.start_array();
    const std::size_t count = qualities.size();
    for( std::size_t i = 1; i <= count; ++i ) {
        const sol::table quality = qualities.raw_get<sol::table>( i );
        json.start_array();
        json.write( quality.get<std::string>( "id" ) );
        json.write( quality.get<int>( "level" ) );
        json.end_array();
    }
    json.end_array();
}

void write_item_inheritance( JsonOut &json, const sol::table &options )
{
    if( const auto additions = options.get<sol::optional<sol::table>>( "add" ) ) {
        json.member( "extend" );
        json.start_object();
        write_item_ids( json, *additions, { { "flags", "flags" }, { "pet_food", "petfood" },
            { "projectile_effects", "effects" }, { "firing_effects", "ammo_effects" } } );
        write_item_vitamins( json, *additions, "vitamins" );
        write_item_rot_spawn( json, *additions );
        write_item_variants( json, *additions );
        json.end_object();
    }
    if( const auto removals = options.get<sol::optional<sol::table>>( "remove" ) ) {
        json.member( "delete" );
        json.start_object();
        write_item_ids( json, *removals, { { "flags", "flags" },
            { "projectile_effects", "effects" }, { "firing_effects", "ammo_effects" } } );
        json.end_object();
    }
    if( const auto scale = options.get<sol::optional<sol::table>>( "scale" ) ) {
        json.member( "proportional" );
        json.start_object();
        write_item_fields<double>( json, *scale, {
            { "mass", "weight" }, { "volume", "volume" }, { "price", "price" },
            { "survival_price", "price_postapoc" }, { "warmth", "warmth" },
            { "calories", "calories" }, { "encumbrance", "encumbrance" },
            { "fun", "fun" }, { "quench", "quench" }, { "parasites", "parasites" },
            { "dispersion", "dispersion" }, { "sight_dispersion", "sight_dispersion" },
            { "recoil", "recoil" }, { "range", "range" },
            { "shot_spread", "shot_spread" }, { "loudness", "loudness" },
            { "count", "count" }, { "reload_time", "reload" },
        } );
        write_item_damage( json, *scale, "damage", "damage" );
        write_item_damage( json, *scale, "shot_damage", "shot_damage" );
        write_item_damage( json, *scale, "ranged_damage", "ranged_damage" );
        if( const auto damage = scale->get<sol::optional<sol::table>>( "melee_damage" ) ) {
            write_item_keyed_values<double>( json, "melee_damage", *damage );
        }
        json.end_object();
    }
    if( const auto offset = options.get<sol::optional<sol::table>>( "offset" ) ) {
        json.member( "relative" );
        json.start_object();
        write_item_fields<std::string>( json, *offset, { { "mass", "weight" }, { "volume", "volume" },
            { "price", "price" }, { "barrel_volume", "barrel_volume" } } );
        write_item_fields<int>( json, *offset, { { "warmth", "warmth" }, { "fun", "fun" },
            { "quench", "quench" }, { "range", "range" }, { "dispersion", "dispersion" },
            { "recoil", "recoil" }, { "accuracy", "to_hit" } } );
        write_item_damage( json, *offset, "damage", "damage" );
        write_item_damage( json, *offset, "ranged_damage", "ranged_damage" );
        if( const auto damage = offset->get<sol::optional<sol::table>>( "melee_damage" ) ) {
            write_item_keyed_values<double>( json, "melee_damage", *damage );
        }
        json.end_object();
    }
}

void write_item_tool( JsonOut &json, const sol::table &tool )
{
    write_item_fields<int>( json, tool, {
        { "max_charges", "max_charges" }, { "initial_charges", "initial_charges" },
        { "charges_per_use", "charges_per_use" }, { "charge_factor", "charge_factor" },
        { "turns_per_charge", "turns_per_charge" }
    } );
    write_placement_member<double>( json, tool, "fuel_efficiency", "fuel_efficiency" );
    write_item_fields<std::string>( json, tool, {
        { "power_draw", "power_draw" }, { "crafting_subtype", "sub" }, { "transfer_rate", "etransfer_rate" }
    } );
    const sol::object ammo = tool.raw_get<sol::object>( "ammo_types" );
    if( ammo.get_type() == sol::type::string ) {
        json.member( "tool_ammo", ammo.as<std::string>() );
    } else {
        write_item_ids( json, tool, { { "ammo_types", "tool_ammo" } } );
    }
    write_item_text( json, "revert_msg", tool.raw_get<sol::object>( "revert_message" ), false );
}

void write_item_bionic( JsonOut &json, const sol::table &bionic )
{
    write_placement_member<int>( json, bionic, "difficulty", "difficulty" );
    write_placement_member<bool>( json, bionic, "upgrade", "is_upgrade" );
    write_placement_member<std::string>( json, bionic, "installation", "installation_data" );
}

void write_item_pet_armor( JsonOut &json, const sol::table &armor )
{
    write_placement_member<double>( json, armor, "thickness", "material_thickness" );
    write_item_fields<int>( json, armor, {
        { "environmental_protection", "environmental_protection" },
        { "protection_with_filter", "environmental_protection_with_filter" }
    } );
    write_item_fields<std::string>( json, armor, {
        { "max_pet_volume", "max_pet_vol" }, { "min_pet_volume", "min_pet_vol" },
        { "body_type", "pet_bodytype" }
    } );
    write_placement_member<bool>( json, armor, "power_armor", "power_armor" );
}

void write_item_pet_equipment( JsonOut &json, const sol::table &gear )
{
    write_item_ids( json, gear, {
        { "slots", "pet_slots" }, { "passive_effects", "pet_passive_effects" }
    } );
    if( const auto qualities = gear.get<sol::optional<sol::table>>( "install_qualities" ) ) {
        write_item_qualities( json, *qualities, "pet_install_qualities" );
    }
    write_placement_member<int>( json, gear, "mount_threshold_delta", "pet_mount_threshold_delta" );
    write_item_fields<double>( json, gear, {
        { "melee_hit_multiplier", "pet_melee_hit_multiplier" },
        { "melee_damage_multiplier", "pet_melee_damage_multiplier" },
        { "fear_multiplier", "pet_fear_multiplier" }, { "spook_multiplier", "pet_spook_multiplier" },
        { "mounted_move_cost_multiplier", "pet_mounted_move_cost_multiplier" }
    } );
}

void write_item_fermentation( JsonOut &json, const sol::table &recipe, const char *time_field,
                              const char *result_field )
{
    const sol::object duration = recipe.raw_get<sol::object>( "duration" );
    if( duration.get_type() == sol::type::number ) {
        json.member( time_field, duration.as<int>() );
    } else {
        write_placement_member<std::string>( json, recipe, "duration", time_field );
    }
    if( const auto products = recipe.get<sol::optional<sol::table>>( "products" ) ) {
        const std::size_t count = checked_dense_array_size( *products, "fermentation products",
                                  std::numeric_limits<std::size_t>::max() );
        json.member( result_field );
        json.start_array();
        for( std::size_t i = 1; i <= count; ++i ) {
            const sol::object product = products->raw_get<sol::object>( i );
            if( product.get_type() == sol::type::string ) {
                json.write( product.as<std::string>() );
            } else {
                const sol::table entry = product.as<sol::table>();
                json.start_object();
                json.member( "item", entry.get<std::string>( "item" ) );
                write_placement_member<std::string>( json, entry, "variant", "variant" );
                write_placement_member<int>( json, entry, "count", "count" );
                json.end_object();
            }
        }
        json.end_array();
    }
}

void write_item_milling( JsonOut &json, const sol::table &milling )
{
    write_item_fields<std::string>( json, milling, { { "result", "into" }, { "recipe", "recipe" } } );
}

void write_item_wheel( JsonOut &json, const sol::table &wheel )
{
    write_item_fields<int>( json, wheel, { { "diameter", "diameter" }, { "width", "width" } } );
}

void write_item_seed( JsonOut &json, const sol::table &seed )
{
    write_item_text( json, "plant_name", seed.raw_get<sol::object>( "plant_name" ), false );
    write_item_fields<std::string>( json, seed, {
        { "fruit", "fruit" }, { "growth_temperature", "growth_temp" },
        { "required_terrain_flag", "required_terrain_flag" }
    } );
    write_placement_member<bool>( json, seed, "drop_seeds", "seeds" );
    write_placement_member<int>( json, seed, "water_consumption", "water_consumption" );
    write_item_ids( json, seed, { { "byproducts", "byproducts" } } );
    if( const auto stages = seed.get<sol::optional<sol::table>>( "growth_stages" ) ) {
        json.member( "growth_stages" );
        json.start_array();
        const std::size_t count = checked_dense_array_size( *stages, "growth_stages",
                                  std::numeric_limits<std::size_t>::max() );
        for( std::size_t index = 1; index <= count; ++index ) {
            const sol::table stage = stages->raw_get<sol::table>( index );
            json.start_object();
            json.member( stage.get<std::string>( "stage" ), stage.get<std::string>( "duration" ) );
            json.end_object();
        }
        json.end_array();
    }
    if( const auto climate = seed.get<sol::optional<sol::table>>( "climate" ) ) {
        json.member( "crop_climate" );
        json.start_object();
        write_item_fields<double>( json, *climate, {
            { "base_c", "base_c" }, { "optimum_c", "optimum_c" }, { "min_c", "min_c" },
            { "max_c", "max_c" }, { "degree_days", "degree_days" },
            { "water_mm", "water_mm" }, { "water_peak", "water_peak" }
        } );
        write_placement_member<int>( json, *climate, "growing_days", "growing_days" );
        json.end_object();
    }
}

void write_item_transformation( JsonOut &json, const sol::table &options )
{
    write_item_fields<std::string>( json, options, {
        { "target", "target" }, { "target_group", "target_group" }, { "variant_kind", "variant_type" },
        { "container", "container" }, { "target_ammo", "target_ammo" }
    } );
    write_placement_member<int>( json, options, "target_charges", "target_charges" );
    write_placement_member<bool>( json, options, "sealed", "sealed" );
    const sol::object timer = options.raw_get<sol::object>( "target_timer" );
    if( timer.get_type() == sol::type::number ) {
        json.member( "target_timer", timer.as<int>() );
    } else {
        write_placement_member<std::string>( json, options, "target_timer", "target_timer" );
    }
    if( const auto charges = options.get<sol::optional<sol::table>>( "random_charges" ) ) {
        const std::size_t count = checked_dense_array_size( *charges, "random_charges",
                                  std::numeric_limits<std::size_t>::max() );
        json.member( "rand_target_charges" );
        json.start_array();
        for( std::size_t i = 1; i <= count; ++i ) {
            json.write( charges->raw_get<int>( i ) );
        }
        json.end_array();
    }
}

void write_item_transform_action( JsonOut &json, const sol::table &options )
{
    write_item_transformation( json, options );
    write_item_fields<int>( json, options, {
        { "sound_volume", "sound_volume" },
        { "moves", "moves" }, { "chance", "chance" }, { "need_fire", "need_fire" },
        { "need_charges", "need_charges" }
    } );
    write_item_fields<bool>( json, options, {
        { "set_timer", "set_timer" }, { "need_worn", "need_worn" },
        { "need_wielding", "need_wielding" }, { "need_empty", "need_empty" }
    } );
    if( const auto qualities = options.get<sol::optional<sol::table>>( "qualities" ) ) {
        write_item_keyed_values<int>( json, "qualities_needed", *qualities );
    }
    write_item_text( json, "msg", options.raw_get<sol::object>( "message" ), false );
    write_item_text( json, "menu_text", options.raw_get<sol::object>( "menu_text" ), false );
    write_item_text( json, "damage_failure_msg", options.raw_get<sol::object>( "damage_failure" ), false );
    write_item_text( json, "need_charges_msg", options.raw_get<sol::object>( "need_charges_message" ), false );
    write_item_text( json, "need_fire_msg", options.raw_get<sol::object>( "need_fire_message" ), false );
}

void write_item_action_effects( JsonOut &json, const sol::table &options )
{
    if( const auto effects = options.get<sol::optional<sol::table>>( "effects" ) ) {
        json.member( "effects" );
        json.start_array();
        const std::size_t count = checked_dense_array_size( *effects, "effects",
                                  std::numeric_limits<std::size_t>::max() );
        for( std::size_t index = 1; index <= count; ++index ) {
            const sol::table effect = effects->raw_get<sol::table>( index );
            json.start_object();
            json.member( "id", effect.get<std::string>( "id" ) );
            const sol::object duration = effect.raw_get<sol::object>( "duration" );
            if( duration.get_type() == sol::type::string ) {
                json.member( "duration", duration.as<std::string>() );
            } else {
                write_placement_member<int>( json, effect, "duration", "duration" );
            }
            write_placement_member<std::string>( json, effect, "bodypart", "bp" );
            write_placement_member<bool>( json, effect, "permanent", "permanent" );
            write_placement_member<int>( json, effect, "intensity", "intensity" );
            json.end_object();
        }
        json.end_array();
    }
}

void write_item_drug_action( JsonOut &json, const sol::table &options )
{
    write_item_text( json, "activation_message", options.raw_get<sol::object>( "message" ), false );
    write_placement_member<int>( json, options, "moves", "moves" );
    write_placement_member<std::string>( json, options, "used_up_item", "used_up_item" );
    for( const char *field : { "charges_needed", "tools_needed", "fields_produced" } ) {
        if( const auto values = options.get<sol::optional<sol::table>>( field ) ) {
            write_item_keyed_values<int>( json, field, *values );
        }
    }
    if( const auto values = options.get<sol::optional<sol::table>>( "stat_adjustments" ) ) {
        write_item_keyed_values<int>( json, "stat_adjustments", *values );
    }
    if( const auto vitamins = options.get<sol::optional<sol::table>>( "vitamins" ) ) {
        json.member( "vitamins" );
        json.start_array();
        const std::size_t count = checked_dense_array_size( *vitamins, "vitamins",
                                  std::numeric_limits<std::size_t>::max() );
        for( std::size_t index = 1; index <= count; ++index ) {
            const sol::table vitamin = vitamins->raw_get<sol::table>( index );
            json.start_array();
            json.write( vitamin.get<std::string>( "id" ) );
            json.write( vitamin.get<int>( "minimum" ) );
            if( const auto maximum = vitamin.get<sol::optional<int>>( "maximum" ) ) {
                json.write( *maximum );
            }
            json.end_array();
        }
        json.end_array();
    }
    write_item_action_effects( json, options );
}

void write_item_blast( JsonOut &json, const sol::table &options )
{
    if( const auto blast = options.get<sol::optional<sol::table>>( "blast" ) ) {
        json.member( "explosion" );
        json.start_object();
        json.member( "power", blast->get<double>( "power" ) );
        write_placement_member<double>( json, *blast, "distance_factor", "distance_factor" );
        write_placement_member<int>( json, *blast, "max_noise", "max_noise" );
        write_placement_member<bool>( json, *blast, "fire", "fire" );
        write_placement_member<std::string>( json, *blast, "light_effect", "light_effect" );
        const sol::object shrapnel = blast->raw_get<sol::object>( "shrapnel" );
        if( shrapnel.get_type() == sol::type::number ) {
            json.member( "shrapnel", shrapnel.as<int>() );
        } else if( shrapnel.get_type() != sol::type::nil ) {
            const sol::table fragments = shrapnel.as<sol::table>();
            json.member( "shrapnel" );
            json.start_object();
            json.member( "casing_mass", fragments.get<int>( "casing_mass" ) );
            write_placement_member<double>( json, fragments, "fragment_mass", "fragment_mass" );
            write_placement_member<int>( json, fragments, "recovery", "recovery" );
            write_placement_member<std::string>( json, fragments, "drop", "drop" );
            json.end_object();
        }
        json.end_object();
    }
}

void write_item_explosion_action( JsonOut &json, const sol::table &options )
{
    write_item_blast( json, options );
    write_item_ids( json, options, { { "ammo_effects", "effects" } } );
    write_item_fields<int>( json, options, {
        { "draw_radius", "draw_explosion_radius" }, { "field_radius", "fields_radius" },
        { "field_minimum", "fields_min_intensity" }, { "field_maximum", "fields_max_intensity" },
        { "emp_radius", "emp_blast_radius" }, { "scrambler_radius", "scrambler_blast_radius" }
    } );
    write_item_fields<std::string>( json, options, {
        { "draw_color", "draw_explosion_color" }, { "field", "fields_type" }
    } );
    write_item_fields<bool>( json, options, {
        { "flash", "do_flashbang" }, { "flash_immune", "flashbang_player_immune" }
    } );
}

void write_item_heal_action( JsonOut &json, const sol::table &options )
{
    json.member( "move_cost", options.get<int>( "moves" ) );
    write_placement_member<int>( json, options, "bleed", "bleed" );
    for( const char *field : {
             "limb_power", "head_power", "torso_power", "limb_scaling", "head_scaling",
             "torso_scaling", "bandages_power", "bandages_scaling", "disinfectant_power",
             "disinfectant_scaling", "bite", "infect"
         } ) {
        write_placement_member<double>( json, options, field, field );
    }
    write_item_action_effects( json, options );
    const sol::object byproduct = options.raw_get<sol::object>( "byproduct" );
    if( byproduct.get_type() == sol::type::string ) {
        json.member( "used_up_item", byproduct.as<std::string>() );
    } else if( byproduct.get_type() != sol::type::nil ) {
        const sol::table replacement = byproduct.as<sol::table>();
        json.member( "used_up_item" );
        json.start_object();
        json.member( "id", replacement.get<std::string>( "id" ) );
        write_item_fields<int>( json, replacement, {
            { "quantity", "quantity" }, { "charges", "charges" }
        } );
        write_item_ids( json, replacement, { { "flags", "flags" } } );
        json.end_object();
    }
}

void write_item_instrument_action( JsonOut &json, const sol::table &options )
{
    json.member( "volume", options.get<int>( "volume" ) );
    json.member( "fun", options.get<int>( "fun" ) );
    write_item_fields<int>( json, options, {
        { "fun_bonus", "fun_bonus" }, { "speed_penalty", "speed_penalty" }
    } );
    const sol::object interval = options.raw_get<sol::object>( "description_interval" );
    if( interval.get_type() == sol::type::number ) {
        json.member( "description_frequency", interval.as<int>() );
    } else {
        json.member( "description_frequency", interval.as<std::string>() );
    }
    for( const auto &[field, native] : {
             item_field{ "player_messages", "player_descriptions" },
             item_field{ "npc_messages", "npc_descriptions" }
         } ) {
        if( const auto messages = options.get<sol::optional<sol::table>>( field ) ) {
            json.member( native );
            json.start_array();
            const std::size_t count = checked_dense_array_size( *messages, field,
                std::numeric_limits<std::size_t>::max() );
            for( std::size_t index = 1; index <= count; ++index ) {
                write_item_text_value( json, field, messages->raw_get<sol::object>( index ), false );
            }
            json.end_array();
        }
    }
}


void write_item_native_action( JsonOut &json, const sol::object &action )
{
    if( action.get_type() == sol::type::string ) {
        const std::string name = action.as<std::string>();
        if( name == "effect_on_conditions" ) {
            throw std::invalid_argument( "ordered item definitions require a native item action" );
        }
        json.write( name );
        return;
    }
    const sol::table options = action.as<sol::table>();
    const std::string kind = options.get<std::string>( "kind" );
    if( kind == "native" ) {
        const std::string id = options.get<std::string>( "id" );
        if( id == "effect_on_conditions" ) {
            throw std::invalid_argument( "ordered item definitions require a native item action" );
        }
        json.start_array();
        json.write( id );
        json.write( options.get<int>( "ammo_scale" ) );
        json.end_array();
        return;
    }
    json.start_object();
    json.member( "type", kind );
    write_placement_member<int>( json, options, "ammo_scale", "ammo_scale" );
    if( kind == "transform" || kind == "delayed_transform" ) {
        write_item_transform_action( json, options );
        if( kind == "delayed_transform" ) {
            json.member( "transform_age", options.get<int>( "age" ) );
            write_item_text( json, "not_ready_msg", options.raw_get<sol::object>( "not_ready_message" ), false );
        }
    } else if( kind == "consume_drug" ) {
        write_item_drug_action( json, options );
    } else if( kind == "heal" ) {
        write_item_heal_action( json, options );
    } else if( kind == "explosion" ) {
        write_item_explosion_action( json, options );
    } else if( kind == "musical_instrument" ) {
        write_item_instrument_action( json, options );
    } else if( kind == "manualnoise" ) {
        write_item_fields<int>( json, options, { { "volume", "noise" }, { "moves", "moves" } } );
        write_item_fields<std::string>( json, options, {
            { "sound_id", "noise_id" }, { "sound_variant", "noise_variant" }
        } );
        write_item_text( json, "use_message", options.raw_get<sol::object>( "message" ), false );
        write_item_text( json, "noise_message", options.raw_get<sol::object>( "sound_message" ), false );
    } else if( kind == "repair_item" ) {
        write_item_fields<std::string>( json, options, {
            { "id", "item_action_type" }, { "skill", "skill" }
        } );
        write_item_fields<int>( json, options, {
            { "tool_quality", "tool_quality" }, { "move_cost", "move_cost" },
            { "trains_skill_to", "trains_skill_to" }
        } );
        write_placement_member<double>( json, options, "cost_scaling", "cost_scaling" );
        write_item_ids( json, options, { { "materials", "materials" } } );
    } else if( kind == "place_monster" ) {
        write_placement_member<std::string>( json, options, "monster", "monster_id" );
        write_item_fields<int>( json, options, {
            { "difficulty", "difficulty" }, { "moves", "moves" },
            { "need_charges", "need_charges" }
        } );
        write_item_fields<bool>( json, options, {
            { "place_randomly", "place_randomly" }, { "is_pet", "is_pet" }
        } );
        write_item_ids( json, options, { { "skills", "skills" } } );
        write_item_text( json, "friendly_msg", options.raw_get<sol::object>( "friendly_message" ), false );
        write_item_text( json, "hostile_msg", options.raw_get<sol::object>( "hostile_message" ), false );
    } else if( kind == "firestarter" ) {
        write_item_fields<int>( json, options, {
            { "moves", "moves" }, { "slow_moves", "moves_slow" }
        } );
        write_placement_member<bool>( json, options, "need_sunlight", "need_sunlight" );
        if( const auto values = options.get<sol::optional<sol::table>>( "qualities" ) ) {
            write_item_keyed_values<int>( json, "qualities_needed", *values );
        }
    } else if( kind == "mp3" ) {
        write_placement_member<std::string>( json, options, "target", "transform" );
        write_placement_member<bool>( json, options, "activate", "activate" );
        write_item_text( json, "message", options.raw_get<sol::object>( "message" ), false );
    } else if( kind == "sound" ) {
        write_item_fields<std::string>( json, options, {
            { "sound_id", "sound_id" }, { "sound_variant", "sound_variant" },
            { "sound_type", "sound_type" }
        } );
        write_placement_member<int>( json, options, "volume", "sound_volume" );
        write_item_text( json, "name", options.raw_get<sol::object>( "menu_text" ), false );
        write_item_text( json, "sound_message", options.raw_get<sol::object>( "message" ), false );
    } else if( kind == "inscribe" ) {
        write_placement_member<int>( json, options, "cost", "cost" );
        write_item_fields<bool>( json, options, {
            { "on_items", "on_items" }, { "on_terrain", "on_terrain" },
            { "material_restricted", "material_restricted" }
        } );
        write_item_ids( json, options, { { "materials", "material_whitelist" } } );
        write_item_text( json, "verb", options.raw_get<sol::object>( "verb" ), false );
        write_item_text( json, "gerund", options.raw_get<sol::object>( "gerund" ), false );
    } else if( kind == "link_up" ) {
        write_placement_member<std::string>( json, options, "charge_rate", "charge_rate" );
        write_item_fields<int>( json, options, {
            { "cable_length", "cable_length" }, { "move_cost", "move_cost" }
        } );
        write_placement_member<double>( json, options, "efficiency", "efficiency" );
        write_item_ids( json, options, {
            { "targets", "targets" }, { "can_extend", "can_extend" }
        } );
        write_item_text( json, "menu_text", options.raw_get<sol::object>( "menu_text" ), false );
    } else if( kind == "emit_actor" ) {
        write_placement_member<bool>( json, options, "scale_quantity", "scale_qty" );
        write_item_ids( json, options, { { "emissions", "emits" } } );
    } else if( kind == "holster" ) {
        write_item_text( json, "holster_prompt", options.raw_get<sol::object>( "prompt" ), false );
        write_item_text( json, "holster_msg", options.raw_get<sol::object>( "message" ), false );
    } else if( kind == "message" ) {
        write_item_text( json, "name", options.raw_get<sol::object>( "menu_text" ), false );
        write_item_text( json, "message", options.raw_get<sol::object>( "message" ), false );
    } else if( kind == "attach_molle" || kind == "detach_molle" ) {
        if( kind == "attach_molle" ) {
            json.member( "size", options.get<int>( "size" ) );
        }
        write_placement_member<int>( json, options, "moves", "moves" );
    } else if( kind == "cast_spell" ) {
        json.member( "spell_id", options.get<std::string>( "spell" ) );
        json.member( "level", options.get<int>( "level" ) );
        json.member( "no_fail", options.get<bool>( "no_fail" ) );
        write_item_fields<bool>( json, options, {
            { "need_worn", "need_worn" }, { "need_wielding", "need_wielding" }, { "mundane", "mundane" }
        } );
    } else if( kind != "play_instrument" ) {
        throw std::invalid_argument( "unsupported ordered item action: " + kind );
    }
    json.end_object();
}

void write_item_action_list( JsonOut &json, const sol::table &options, const char *field,
                             const char *native )
{
    if( const auto actions = options.get<sol::optional<sol::table>>( field ) ) {
        json.member( native );
        json.start_array();
        const std::size_t count = checked_dense_array_size( *actions, field,
                                  std::numeric_limits<std::size_t>::max() );
        for( std::size_t index = 1; index <= count; ++index ) {
            write_item_native_action( json, actions->raw_get<sol::object>( index ) );
        }
        json.end_array();
    }
}

void load_static_item( const sol::table &options, const std::string &source )
{
    struct slot_type {
        const char *field;
        const char *native_id;
        void ( *write )( JsonOut &, const sol::table & );
    };
    static constexpr slot_type slot_types[] = {
        { "tool", "TOOL", write_item_tool },
        { "armor", "ARMOR", write_item_armor },
        { "pet_armor", "PET_ARMOR", write_item_pet_armor },
        { "pet_equipment", "PET_EQUIPMENT", write_item_pet_equipment },
        { "engine", "ENGINE", []( JsonOut & out, const sol::table & engine ) {
                write_placement_member<int>( out, engine, "displacement", "displacement" );
            }
        },
        { "brewing", "BREWABLE", []( JsonOut & out, const sol::table & recipe ) {
                write_item_fermentation( out, recipe, "brew_time", "brew_results" );
            }
        },
        { "composting", "COMPOSTABLE", []( JsonOut & out, const sol::table & recipe ) {
                write_item_fermentation( out, recipe, "compost_time", "compost_results" );
            }
        },
        { "seed", "SEED", write_item_seed },
        { "milling", "MILLING", write_item_milling },
        { "comestible", "COMESTIBLE", write_item_comestible },
        { "bionic", "BIONIC_ITEM", write_item_bionic },
        { "wheel", "WHEEL", write_item_wheel },
        { "ammunition", "AMMO", write_item_ammunition },
        { "magazine", "MAGAZINE", write_item_magazine },
        { "gun", "GUN", write_item_gun },
        { "gunmod", "GUNMOD", write_item_gunmod },
        { "toolmod", "TOOLMOD", write_item_mod },
        { "artifact", "ARTIFACT", write_item_artifact },
    };
    std::vector<const slot_type *> slots;
    for( const slot_type &candidate : slot_types ) {
        if( options.raw_get<sol::object>( candidate.field ).get_type() != sol::type::nil ) {
            slots.push_back( &candidate );
        }
    }
    if( const auto order = options.get<sol::optional<sol::table>>( "subtype_order" ) ) {
        const auto names = bounded_string_array( *order, "subtype_order", std::size( slot_types ),
                           "static item" );
        if( names.size() != slots.size() ) {
            throw std::invalid_argument( "subtype_order must list every configured subtype once" );
        }
        auto next = slots.begin();
        for( const std::string &field : names ) {
            const auto match = std::find_if( next, slots.end(), [&field]( const slot_type * slot ) {
                return slot->field == field;
            } );
            if( match == slots.end() ) {
                throw std::invalid_argument( "unknown or repeated item subtype: " + field );
            }
            std::iter_swap( next, match );
            ++next;
        }
    } else if( slots.size() > 1 ) {
        throw std::invalid_argument( "ordered items with multiple subtypes require subtype_order" );
    }
    if( const auto gun = options.get<sol::optional<sol::table>>( "gun" ) ) {
        if( const auto mod = options.get<sol::optional<sol::table>>( "gunmod" ) ) {
            for( const char *field : { "barrel_length", "effects" } ) {
                if( gun->raw_get<sol::object>( field ).get_type() != sol::type::nil &&
                    mod->raw_get<sol::object>( field ).get_type() != sol::type::nil ) {
                    throw std::invalid_argument( std::string( "gun and gunmod share the item field " ) + field );
                }
            }
        }
    }
    std::ostringstream serialized;
    JsonOut json( serialized );
    serialized << std::defaultfloat << std::setprecision( std::numeric_limits<double>::max_digits10 );
    json.start_object();
    // The native factory can queue a definition whose parent is loaded later.
    json.member( "type", "ITEM" );
    json.member( options.get_or( "abstract", false ) ? "abstract" : "id",
                 options.get<std::string>( "id" ) );
    if( !slots.empty() ) {
        json.member( "subtypes" );
        json.start_array();
        for( const slot_type *slot : slots ) {
            json.write( slot->native_id );
        }
        json.end_array();
    }
    write_item_text( json, "name", options.raw_get<sol::object>( "name" ), true, true );
    write_item_text( json, "description", options.raw_get<sol::object>( "description" ), false );
    write_item_fields<std::string>( json, options, {
        { "copy_from", "copy-from" }, { "symbol", "symbol" }, { "color", "color" },
        { "category", "category" }, { "looks_like", "looks_like" }, { "ascii_picture", "ascii_picture" },
        { "variant_kind", "variant_type" }, { "phase", "phase" }, { "display_type", "display_type" },
        { "default_container", "container" }, { "repair_like", "repairs_like" },
        { "mass", "weight" }, { "volume", "volume" }, { "length", "longest_side" },
        { "integral_mass", "integral_weight" }, { "integral_volume", "integral_volume" },
        { "integral_length", "integral_longest_side" },
        { "price", "price" }, { "survival_price", "price_postapoc" },
        { "snippet_category", "snippet_category" }, { "revert_to", "revert_to" },
    } );
    write_item_fields<bool>( json, options, {
        { "stackable", "stackable" }, { "expand_snippets", "expand_snippets" },
        { "sealed_container", "sealed" }, { "explode_in_fire", "explode_in_fire" },
    } );
    write_item_fields<int>( json, options, {
        { "stack_size", "stack_size" }, { "light", "light" }, { "max_worn", "max_worn" },
        { "min_strength", "min_strength" }, { "throwing_recovery_chance", "thrown_recovery_chance" },
    } );
    write_placement_member<double>( json, options, "fertilizer_quality", "fertilizer_quality" );
    write_item_ids( json, options, {
        { "flags", "flags" }, { "techniques", "techniques" }, { "repair_materials", "repairs_with" },
        { "emissions", "emits" }, { "weapon_categories", "weapon_category" },
    } );
    if( const auto materials = options.get<sol::optional<sol::table>>( "materials" ) ) {
        write_item_materials( json, *materials, false );
    }
    if( const auto replace = options.get<sol::optional<sol::table>>( "replace_materials" ) ) {
        write_item_keyed_values<std::string>( json, "replace_materials", *replace );
    }
    if( const auto damage = options.get<sol::optional<sol::table>>( "melee_damage" ) ) {
        write_item_keyed_values<double>( json, "melee_damage", *damage );
    }
    write_item_damage( json, options, "thrown_damage", "thrown_damage" );
    const sol::object mounted = options.raw_get<sol::object>( "mounted_charge" );
    if( mounted.get_type() == sol::type::table ) {
        const sol::table charge = mounted.as<sol::table>();
        json.member( "mounted_charge" );
        json.start_object();
        json.member( "max_steps", charge.get<int>( "max_steps" ) );
        json.member( "damage_type", charge.get<std::string>( "damage_type" ) );
        json.member( "multiplier_per_step", charge.get<double>( "multiplier_per_step" ) );
        json.member( "max_multiplier", charge.get<double>( "max_multiplier" ) );
        json.end_object();
    } else if( mounted.get_type() == sol::type::boolean && !mounted.as<bool>() ) {
        json.member( "mounted_charge" );
        json.write_null();
    } else if( mounted.get_type() != sol::type::nil ) {
        throw std::invalid_argument( "mounted_charge requires a profile or false" );
    }
    if( const auto pockets = options.get<sol::optional<sol::table>>( "pockets" ) ) {
        write_item_pockets( json, *pockets );
    }
    write_item_variants( json, options );
    if( const auto names = options.get<sol::optional<sol::table>>( "conditional_names" ) ) {
        write_item_conditional_names( json, *names );
    }
    if( const auto faults = options.get<sol::optional<sol::table>>( "faults" ) ) {
        write_item_faults( json, *faults );
    }
    if( const auto qualities = options.get<sol::optional<sol::table>>( "qualities" ) ) {
        write_item_qualities( json, *qualities );
    }
    write_item_counted_ids( json, options, "minimum_skills", "min_skills" );
    const sol::object to_hit = options.raw_get<sol::object>( "accuracy" );
    if( to_hit.get_type() == sol::type::number ) {
        json.member( "to_hit", to_hit.as<int>() );
    } else if( to_hit.get_type() == sol::type::table ) {
        json.member( "to_hit" );
        json.start_object();
        write_item_fields<std::string>( json, to_hit.as<sol::table>(), {
            { "grip", "grip" }, { "length", "length" }, { "surface", "surface" }, { "balance", "balance" },
        } );
        json.end_object();
    }
    for( const slot_type *slot : slots ) {
        slot->write( json, options.get<sol::table>( slot->field ) );
    }
    if( const auto transformation = options.get<sol::optional<sol::table>>( "transform_into" ) ) {
        json.member( "transform_into" );
        json.start_object();
        write_item_transformation( json, *transformation );
        json.end_object();
    }
    write_item_blast( json, options );
    write_item_action_list( json, options, "use_actions", "use_action" );
    write_item_action_list( json, options, "tick_actions", "tick_action" );
    for( const char *field : { "countdown_action", "drop_action" } ) {
        const sol::object action = options.raw_get<sol::object>( field );
        if( action.get_type() != sol::type::nil ) {
            json.member( field );
            write_item_native_action( json, action );
        }
    }
    write_placement_member<std::string>( json, options, "countdown_interval", "countdown_interval" );
    if( const auto inheritance = options.get<sol::optional<sol::table>>( "inheritance" ) ) {
        write_item_inheritance( json, *inheritance );
    }
    json.end_object();
    const JsonObject definition = json_loader::from_string( serialized.str() ).get_object();
    static_cast<void>( definition.get_string( "type" ) );
    items::load( definition, source );
}

sol::table static_gendered_dialogue_line( sol::this_state state, const std::string &text,
        const sol::table &participants )
{
    sol::state_view lua( state );
    sol::table line = lua.create_table();
    line["gendered"] = text;
    line["participants"] = participants;
    return line;
}

bool dialogue_participant_is_interlocutor( std::string_view role )
{
    if( role == "interlocutor" ) {
        return true;
    }
    if( role == "speaker" ) {
        return false;
    }
    throw std::invalid_argument( "dialogue participant must be speaker or interlocutor" );
}

var_info read_dialogue_variable( const sol::table &variable )
{
    static const std::map<std::string_view, var_type> scopes = {
        { "speaker", var_type::u }, { "interlocutor", var_type::npc },
        { "global", var_type::global }, { "conversation", var_type::context },
        { "indirect", var_type::var },
    };
    const std::string scope = variable.get<std::string>( "scope" );
    const auto type = scopes.find( scope );
    if( type == scopes.end() ) {
        throw std::invalid_argument( "unsupported dialogue variable scope: " + scope );
    }
    return var_info( type->second, variable.get<std::string>( "key" ) );
}

str_or_var read_dialogue_string_value( const sol::object &value )
{
    if( value.get_type() == sol::type::string ) {
        return str_or_var( value.as<std::string>() );
    }
    const sol::table variable = value.as<sol::table>();
    str_or_var result;
    result.val = read_dialogue_variable( variable );
    if( const auto fallback = variable.get<sol::optional<std::string>>( "fallback" ) ) {
        result.default_val = *fallback;
    }
    return result;
}

translation_or_var read_dialogue_translation_value( const sol::object &value )
{
    if( value.get_type() != sol::type::table ) {
        const detail::authored_text text = detail::read_singular_text( value, {}, "dialogue action" );
        return translation_or_var( text.translated ? text.native() : to_translation( text.raw ) );
    }
    const sol::table variable = value.as<sol::table>();
    translation_or_var result;
    result.val = read_dialogue_variable( variable );
    if( const auto fallback = variable.get<sol::optional<sol::object>>( "fallback" ) ) {
        const detail::authored_text text = detail::read_singular_text( *fallback, {}, "dialogue fallback" );
        result.default_val = text.translated ? text.native() : to_translation( text.raw );
    }
    return result;
}

std::vector<str_or_var> read_dialogue_string_values( const sol::table &values )
{
    std::vector<str_or_var> result;
    const std::size_t count = values.size();
    result.reserve( count );
    for( std::size_t i = 1; i <= count; ++i ) {
        result.push_back( read_dialogue_string_value( values.raw_get<sol::object>( i ) ) );
    }
    return result;
}

static_dialogue_predicate combine_dialogue_predicates( const sol::table &values, bool all )
{
    std::vector<talk_predicate> rules;
    const std::size_t count = values.size();
    rules.reserve( count );
    for( std::size_t i = 1; i <= count; ++i ) {
        rules.push_back( values.raw_get<const static_dialogue_predicate &>( i ).test );
    }
    return { [rules = std::move( rules ), all]( const const_dialogue & d )
    {
        const auto matches = [&]( const talk_predicate & rule ) {
            return rule( d );
        };
        return all ? std::all_of( rules.begin(), rules.end(), matches ) :
               std::any_of( rules.begin(), rules.end(), matches );
    } };
}

void install_static_dialogue_predicates( sol::state &lua, sol::table &content )
{
    sol::table predicates = lua.create_table();
    predicates.set_function( "all", []( const sol::table & values ) {
        return combine_dialogue_predicates( values, true );
    } );
    predicates.set_function( "any", []( const sol::table & values ) {
        return combine_dialogue_predicates( values, false );
    } );
    predicates.set_function( "negate", []( const static_dialogue_predicate & value ) {
        return static_dialogue_predicate{ [test = value.test]( const const_dialogue & d )
        {
            return !test( d );
        } };
    } );
    predicates.set_function( "any_equal", []( const sol::table & values ) {
        return static_dialogue_predicate{ dialogue_data::any_equal(
                                              read_dialogue_string_values( values ) ) };
    } );
    predicates.set_function( "has_trait", []( const std::string & role, const sol::object & id ) {
        return static_dialogue_predicate{ dialogue_data::has_trait( read_dialogue_string_value( id ),
                dialogue_participant_is_interlocutor( role ) ) };
    } );
    predicates.set_function( "has_any_trait", []( const std::string & role, const sol::table & ids ) {
        return static_dialogue_predicate{ dialogue_data::has_any_trait( read_dialogue_string_values( ids ),
                dialogue_participant_is_interlocutor( role ) ) };
    } );
    predicates.set_function( "has_flag", []( const std::string & role, const sol::object & id ) {
        return static_dialogue_predicate{ dialogue_data::has_flag( read_dialogue_string_value( id ),
                dialogue_participant_is_interlocutor( role ) ) };
    } );
    predicates.set_function( "wears", []( const std::string & role, const sol::object & id ) {
        return static_dialogue_predicate{ dialogue_data::wears( read_dialogue_string_value( id ),
                dialogue_participant_is_interlocutor( role ) ) };
    } );
    predicates.set_function( "has_item", []( const std::string & role, const sol::object & id ) {
        return static_dialogue_predicate{ dialogue_data::has_item( read_dialogue_string_value( id ),
                dialogue_participant_is_interlocutor( role ) ) };
    } );
    predicates.set_function( "has_inventory", []( const std::string & role, const sol::object & id,
    sol::optional<double> count, sol::optional<double> charges ) {
        if( !count && !charges ) {
            throw std::invalid_argument( "dialogue inventory check requires a count or charges" );
        }
        return static_dialogue_predicate{ dialogue_data::has_items( read_dialogue_string_value( id ),
                dbl_or_var( count.value_or( 0.0 ) ), dbl_or_var( charges.value_or( 0.0 ) ),
                dialogue_participant_is_interlocutor( role ) ) };
    } );
    predicates.set_function( "has_effect", []( const std::string & role, const sol::object & id,
    sol::optional<double> intensity, const sol::optional<sol::object> &body_part ) {
        return static_dialogue_predicate{ dialogue_data::has_effect( read_dialogue_string_value( id ),
                dbl_or_var( intensity.value_or( -1.0 ) ),
                body_part ? read_dialogue_string_value( *body_part ) : str_or_var{},
                dialogue_participant_is_interlocutor( role ) ) };
    } );
    predicates.set_function( "has_mission", []( const sol::object & id ) {
        return static_dialogue_predicate{ dialogue_data::has_mission( read_dialogue_string_value( id ) ) };
    } );
    predicates.set_function( "actor_state", []( const std::string & role, const std::string & state ) {
        return static_dialogue_predicate{ dialogue_data::actor_state( state,
                dialogue_participant_is_interlocutor( role ) ) };
    } );
    predicates.set_function( "conversation_state", []( const std::string & state ) {
        return static_dialogue_predicate{ dialogue_data::conversation_state( state ) };
    } );
    predicates.set_function( "minimum_attribute", []( const std::string & role,
    const std::string & attribute, double minimum ) {
        return static_dialogue_predicate{ dialogue_data::minimum_attribute( attribute, minimum,
                dialogue_participant_is_interlocutor( role ) ) };
    } );
    predicates.set_function( "assigned_missions", []( unsigned int minimum,
    sol::optional<unsigned int> maximum ) {
        return static_dialogue_predicate{ dialogue_data::assigned_missions( minimum,
                maximum ? std::optional<std::size_t>( *maximum ) : std::nullopt ) };
    } );
    predicates.set_function( "available_missions", []( const std::string & role, unsigned int minimum,
    sol::optional<unsigned int> maximum ) {
        return static_dialogue_predicate{ dialogue_data::available_missions(
                                              dialogue_participant_is_interlocutor( role ), minimum,
                                              maximum ? std::optional<std::size_t>( *maximum ) : std::nullopt ) };
    } );
    content["dialogue_predicates"] = predicates;
}

dynamic_line_t read_static_dialogue_line( const sol::object &line )
{
    if( line.get_type() == sol::type::nil ) {
        return {};
    }
    if( line.get_type() == sol::type::string ) {
        return dynamic_line_t( to_translation( line.as<std::string>() ) );
    }
    if( line.get_type() != sol::type::table ) {
        return dynamic_line_t( detail::read_singular_text( line, {}, "dialogue line" ).native() );
    }
    const sol::table options = line.as<sol::table>();
    const auto choices = options.get<sol::optional<sol::table>>( "choices" );
    const auto joined = options.get<sol::optional<sol::table>>( "joined" );
    const auto gendered = options.get<sol::optional<std::string>>( "gendered" );
    const auto condition = options.get<sol::optional<static_dialogue_predicate>>( "when" );
    const auto special = options.get<sol::optional<std::string>>( "special" );
    if( choices.has_value() + joined.has_value() + gendered.has_value() + condition.has_value() +
        special.has_value() != 1 ) {
        throw std::invalid_argument( "dialogue line requires choices, joined lines, gendered text, a predicate, or a native line" );
    }
    if( choices || joined ) {
        const sol::table &lines = choices ? *choices : *joined;
        if( choices && lines.size() == 0 ) {
            throw std::invalid_argument( "random dialogue line requires at least one choice" );
        }
        std::vector<dynamic_line_t> entries;
        const std::size_t count = lines.size();
        entries.reserve( count );
        for( std::size_t i = 1; i <= count; ++i ) {
            entries.push_back( read_static_dialogue_line( lines.raw_get<sol::object>( i ) ) );
        }
        return choices ? dynamic_line_t::choose( std::move( entries ) ) :
               dynamic_line_t::join( std::move( entries ) );
    }
    if( condition ) {
        return dynamic_line_t::branch( condition->test,
                                       read_static_dialogue_line( options.raw_get<sol::object>( "yes" ) ),
                                       read_static_dialogue_line( options.raw_get<sol::object>( "no" ) ) );
    }
    if( special ) {
        if( *special == "hint" ) {
            return dynamic_line_t::hint();
        }
        if( *special == "consume_reason" ) {
            return dynamic_line_t::use_reason();
        }
        throw std::invalid_argument( "unsupported native dialogue line: " + *special );
    }
    const sol::table roles = options.get<sol::table>( "participants" );
    std::vector<std::string> participants = bounded_string_array( roles, "participants", 2,
                                            "gendered dialogue" );
    for( std::string &role : participants ) {
        role = dialogue_participant_is_interlocutor( role ) ? "npc" : "u";
    }
    return dynamic_line_t::gendered( *gendered, std::move( participants ) );
}

void validate_builtin_dialogue_action( const std::string &name )
{
    static const std::set<std::string_view> available = {
        "assign_mission", "mission_success", "mission_failure", "clear_mission", "mission_reward",
        "start_trade", "assign_guard", "stop_guard", "npc_die", "wake_up", "reveal_stats", "end_conversation",
        "insult_combat", "give_equipment", "give_aid", "give_all_aid", "bionic_install",
        "bionic_remove", "follow", "follow_only", "deny_follow", "deny_lead", "deny_equipment",
        "deny_train", "deny_personal_info", "hostile", "flee", "leave", "stop_following",
        "goto_location", "stranger_neutral", "start_mugging", "player_leaving", "drop_weapon",
        "drop_stolen_item", "remove_stolen_status", "player_weapon_away", "player_weapon_drop",
        "lead_to_safety", "start_training", "start_training_npc", "start_training_seminar",
        "npc_rules_menu", "clear_overrides", "npc_thankful", "nothing",
        "dismount", "find_mount", "morale_chat_activity", "drop_items_in_place",
        "start_camp", "basecamp_mission", "return_to_camp_duties", "repair_bionic_limbs",
        "bionic_install_allies", "bionic_remove_allies",
    };
    if( available.count( name ) == 0 ) {
        throw std::invalid_argument( "unsupported native dialogue action: " + name );
    }
}

void install_static_dialogue_actions( sol::state &lua, sol::table &content )
{
    sol::table actions = lua.create_table();
    actions.set_function( "update_map", []( const sol::object & id, const sol::optional<sol::object> & terrain ) {
        return static_dialogue_action{ talk_effect_fun_t( dialogue_action::update_map(
                    read_dialogue_string_value( id ), terrain ? read_dialogue_string_value( *terrain ) : str_or_var{} ) ) };
    } );
    actions.set_function( "notify_player", []( const sol::object & message, sol::optional<std::string> severity ) {
        const auto type = io::string_to_enum_optional<game_message_type>( severity.value_or( "neutral" ) );
        if( !type ) {
            throw std::invalid_argument( "unknown dialogue message severity" );
        }
        return static_dialogue_action{ talk_effect_fun_t( dialogue_action::notify_player(
                    read_dialogue_translation_value( message ), *type ) ) };
    } );
    actions.set_function( "open_conversation", []( const sol::object & topic ) {
        return static_dialogue_action{ talk_effect_fun_t( dialogue_action::open_conversation(
                    read_dialogue_string_value( topic ) ) ) };
    } );
    actions.set_function( "record_time", []( const sol::table & target ) {
        return static_dialogue_action{ talk_effect_fun_t( dialogue_action::record_time(
                    read_dialogue_variable( target ) ) ) };
    } );
    actions.set_function( "set_actor_value", []( const std::string & role, const std::string & key,
    const sol::object & value ) {
        std::vector<std::string> choices = value.get_type() == sol::type::string ?
                                           std::vector<std::string> { value.as<std::string>() } :
                                           bounded_string_array( value.as<sol::table>(), "values",
                                                   std::numeric_limits<std::size_t>::max(), "dialogue action" );
        if( choices.empty() ) {
            throw std::invalid_argument( "dialogue variable assignment needs at least one value" );
        }
        return static_dialogue_action{ talk_effect_fun_t( dialogue_action::set_actor_value(
                    dialogue_participant_is_interlocutor( role ), key, std::move( choices ) ) ) };
    } );
    actions.set_function( "record_turn", []( const std::string & role, const std::string & key ) {
        return static_dialogue_action{ talk_effect_fun_t( dialogue_action::record_turn(
                    dialogue_participant_is_interlocutor( role ), key ) ) };
    } );
    actions.set_function( "clear_actor_value", []( const std::string & role, const std::string & key ) {
        return static_dialogue_action{ talk_effect_fun_t( dialogue_action::clear_actor_value(
                    dialogue_participant_is_interlocutor( role ), key ) ) };
    } );
    actions.set_function( "set_string", []( const sol::table & target, const sol::table & values,
    sol::optional<bool> expand_tags ) {
        const std::size_t count = checked_dense_array_size( values, "dialogue string values",
            std::numeric_limits<std::size_t>::max() );
        if( count == 0 ) {
            throw std::invalid_argument( "dialogue variable assignment needs at least one value" );
        }
        return static_dialogue_action{ talk_effect_fun_t( dialogue_action::set_string(
                    read_dialogue_variable( target ), read_dialogue_string_values( values ),
                    expand_tags.value_or( false ) ) ) };
    } );
    actions.set_function( "set_translated_string", []( const sol::table & target,
            const sol::table & values,
    sol::optional<bool> expand_tags ) {
        const std::size_t count = checked_dense_array_size( values, "dialogue translation values",
            std::numeric_limits<std::size_t>::max() );
        if( count == 0 ) {
            throw std::invalid_argument( "dialogue variable assignment needs at least one translation" );
        }
        std::vector<translation_or_var> choices;
        choices.reserve( count );
        for( std::size_t i = 1; i <= count; ++i ) {
            choices.push_back( read_dialogue_translation_value( values.raw_get<sol::object>( i ) ) );
        }
        return static_dialogue_action{ talk_effect_fun_t( dialogue_action::set_translated_string(
                    read_dialogue_variable( target ), std::move( choices ), expand_tags.value_or( false ) ) ) };
    } );
    actions.set_function( "assign_mission", []( const sol::object & id,
    sol::optional<double> deadline ) {
        return static_dialogue_action{ talk_effect_fun_t( dialogue_action::assign_mission(
                    read_dialogue_string_value( id ), dbl_or_var( deadline.value_or( 0.0 ) ) ) ) };
    } );
    actions.set_function( "offer_mission", []( const sol::object & id ) {
        return static_dialogue_action{ talk_effect_fun_t( dialogue_action::offer_mission(
                    read_dialogue_string_value( id ) ) ) };
    } );
    actions.set_function( "finish_mission", []( const sol::object & id, const sol::table & result ) {
        const auto success = result.get<sol::optional<bool>>( "success" );
        const auto step = result.get<sol::optional<int>>( "step" );
        if( success.has_value() == step.has_value() ) {
            throw std::invalid_argument( "dialogue mission completion requires one of success or step" );
        }
        return static_dialogue_action{ talk_effect_fun_t( dialogue_action::finish_mission(
                    read_dialogue_string_value( id ), success.value_or( false ),
                    step ? std::optional<int>( *step ) : std::nullopt ) ) };
    } );
    actions.set_function( "set_first_topic", []( const sol::object & topic ) {
        return static_dialogue_action{ talk_effect_fun_t( dialogue_action::set_first_topic(
                    read_dialogue_string_value( topic ) ) ) };
    } );
    actions.set_function( "adjust_faction_trust", []( double amount ) {
        return static_dialogue_action{ talk_effect_fun_t( dialogue_action::adjust_faction_trust(
                    dbl_or_var( amount ) ) ) };
    } );
    actions.set_function( "add_effect", []( const std::string & role, const sol::object & id,
    const sol::table & options ) {
        const bool permanent = options.get_or( "permanent", false );
        const auto turns = options.get<sol::optional<int>>( "turns" );
        if( permanent == turns.has_value() ) {
            throw std::invalid_argument( "dialogue effect needs a turn duration or permanent flag" );
        }
        const auto body_part = options.get<sol::optional<sol::object>>( "body_part" );
        return static_dialogue_action{ talk_effect_fun_t( dialogue_action::add_effect(
                    dialogue_participant_is_interlocutor( role ), read_dialogue_string_value( id ),
                    duration_or_var( time_duration::from_turns( turns.value_or( 1 ) ) ),
                    body_part ? read_dialogue_string_value( *body_part ) : str_or_var( "bp_null" ),
                    permanent, options.get_or( "force", false ),
                    dbl_or_var( options.get_or( "intensity", 0.0 ) ) ) ) };
    } );
    actions.set_function( "remove_effects", []( const std::string & role, const sol::table & ids,
    const sol::optional<sol::object> & body_part ) {
        return static_dialogue_action{ talk_effect_fun_t( dialogue_action::remove_effects(
                    dialogue_participant_is_interlocutor( role ), read_dialogue_string_values( ids ),
                    body_part ? read_dialogue_string_value( *body_part ) : str_or_var( "bp_null" ) ) ) };
    } );
    actions.set_function( "replace_mutation", []( const std::string & role, const sol::object & id,
    const sol::optional<sol::object> & variant ) {
        return static_dialogue_action{ talk_effect_fun_t( dialogue_action::replace_mutation(
                    dialogue_participant_is_interlocutor( role ), read_dialogue_string_value( id ),
                    variant ? read_dialogue_string_value( *variant ) : str_or_var{} ) ) };
    } );
    actions.set_function( "remove_items", []( const std::string & role, const sol::object & id ) {
        return static_dialogue_action{ talk_effect_fun_t( dialogue_action::remove_items(
                    dialogue_participant_is_interlocutor( role ), read_dialogue_string_value( id ) ) ) };
    } );
    actions.set_function( "set_ally_rule", []( const sol::object & rule, bool enabled ) {
        return static_dialogue_action{ talk_effect_fun_t( dialogue_action::set_ally_rule(
                    read_dialogue_string_value( rule ), enabled ) ) };
    } );
    actions.set_function( "purchase_pet", []( const sol::object & id, const sol::table & options ) {
        const auto name = options.get<sol::optional<sol::object>>( "name" );
        return static_dialogue_action{ talk_effect_fun_t( dialogue_action::purchase_pet(
                    read_dialogue_string_value( id ), dbl_or_var( options.get_or( "cost", 0 ) ),
                    dbl_or_var( options.get_or( "count", 1 ) ), options.get_or( "pacified", false ),
                    name ? read_dialogue_translation_value( *name ) : translation_or_var{} ) ) };
    } );
    actions.set_function( "transfer_items", []( const sol::object & id, sol::optional<int> count,
    sol::optional<int> debt ) {
        return static_dialogue_action{ talk_effect_fun_t( dialogue_action::transfer_items(
                    read_dialogue_string_value( id ), dbl_or_var( count.value_or( 1 ) ),
                    dbl_or_var( debt.value_or( 0 ) ) ) ) };
    } );
    content["dialogue_actions"] = actions;
}

talk_effect_fun_t read_static_mission_reward( const sol::table &reward )
{
    const auto item = reward.get<sol::optional<std::string>>( "item" );
    const auto group = reward.get<sol::optional<std::string>>( "group" );
    const auto container = reward.get<sol::optional<std::string>>( "container" );
    if( item.has_value() == group.has_value() || ( group && container ) ) {
        throw std::invalid_argument( "mission reward requires an item with optional container, or a group" );
    }
    return dialogue_action::mission_item_reward( item ? *item : *group, reward.get_or( "count", 1 ),
            container.value_or( "" ), group.has_value(), reward.get_or( "preview", true ) );
}

std::optional<talk_effect_t> read_static_dialogue_actions( const sol::table &outcome,
        const std::string &source, detail::mission_phase_handlers *handlers = nullptr )
{
    const auto actions = outcome.get<sol::optional<sol::table>>( "actions" );
    if( !actions ) {
        return std::nullopt;
    }
    if( outcome.get<sol::optional<sol::table>>( "native_actions" ) ) {
        throw std::invalid_argument( "dialogue outcome cannot specify both actions and native_actions" );
    }
    const std::size_t count = checked_dense_array_size( *actions, "dialogue actions",
        std::numeric_limits<std::size_t>::max() );
    const JsonObject empty = json_loader::from_string( "{}" ).get_object();
    talk_effect_t result;
    for( std::size_t i = 1; i <= count; ++i ) {
        const sol::object action = actions->raw_get<sol::object>( i );
        if( action.get_type() == sol::type::string ) {
            const std::string name = action.as<std::string>();
            validate_builtin_dialogue_action( name );
            result.parse_string_effect( name, empty, source );
        } else if( handlers && action.get_type() == sol::type::table ) {
            const sol::table step = action.as<sol::table>();
            if( const auto handler = step.get<sol::optional<std::string>>( "handler" ) ) {
                if( handler->empty() || std::distance( step.begin(), step.end() ) != 1 ) {
                    throw std::invalid_argument( "mission callback step requires a single nonempty handler" );
                }
                handlers->emplace_back( result.effects.size(), *handler );
            } else {
                result.set_effect( read_static_mission_reward( step ) );
            }
        } else {
            result.set_effect( action.as<const static_dialogue_action &>().effect );
        }
    }
    return result;
}

talk_entry_rules read_static_dialogue_entry( const sol::table &entry, const std::string &source )
{
    talk_entry_rules rules;
    if( const auto predicate = entry.get<sol::optional<static_dialogue_predicate>>( "when" ) ) {
        rules.condition = predicate->test;
    }
    if( const auto once = entry.get<sol::optional<std::string>>( "once" ) ) {
        rules.once = *once;
    }
    auto actions = read_static_dialogue_actions( entry, source );
    if( !actions ) {
        throw std::invalid_argument( "dialogue entry rule requires actions" );
    }
    rules.actions = std::move( *actions );
    return rules;
}

talk_response_rules read_static_dialogue_rules( const sol::table &reply, const std::string &source )
{
    talk_response_rules rules;
    if( const auto predicate = reply.get<sol::optional<static_dialogue_predicate>>( "when" ) ) {
        rules.condition = predicate->test;
    }
    if( const auto predicate = reply.get<sol::optional<static_dialogue_predicate>>( "show_when" ) ) {
        if( reply.get_or( "show_always", false ) ) {
            throw std::invalid_argument( "dialogue reply cannot set both show_always and show_when" );
        }
        rules.show_condition = predicate->test;
    }
    rules.success_actions = read_static_dialogue_actions( reply, source );
    if( const auto success = reply.get<sol::optional<sol::table>>( "success" ) ) {
        if( rules.success_actions ) {
            throw std::invalid_argument( "dialogue reply actions belong inside its success outcome" );
        }
        rules.success_actions = read_static_dialogue_actions( *success, source );
    } else if( rules.success_actions && !reply.get<sol::optional<std::string>>( "next_topic" ) ) {
        throw std::invalid_argument( "dialogue reply actions require a next topic" );
    }
    if( const auto failure = reply.get<sol::optional<sol::table>>( "failure" ) ) {
        rules.failure_actions = read_static_dialogue_actions( *failure, source );
    }
    return rules;
}

void write_static_dialogue_native_actions( JsonOut &json, const sol::table &options,
        const char *context )
{
    if( const auto actions = options.get<sol::optional<sol::table>>( "native_actions" ) ) {
        const auto names = bounded_string_array( *actions, "native_actions",
                           std::numeric_limits<std::size_t>::max(), context );
        for( const std::string &name : names ) {
            validate_builtin_dialogue_action( name );
        }
        json.member( "effect", names );
    }
}

void write_static_dialogue_outcome( JsonOut &json, const sol::table &outcome )
{
    write_placement_member<std::string>( json, outcome, "next_topic", "topic" );
    write_static_dialogue_native_actions( json, outcome, "dialogue reply" );
    for( const char *field : { "opinion", "mission_opinion" } ) {
        if( const auto opinion = outcome.get<sol::optional<sol::table>>( field ) ) {
            json.member( field );
            json.start_object();
            write_item_fields<int>( json, *opinion, {
                { "trust", "trust" }, { "fear", "fear" }, { "value", "value" },
                { "anger", "anger" }, { "owed", "owed" }, { "sold", "sold" },
            } );
            json.end_object();
        }
    }
}

void write_static_dialogue_trial( JsonOut &json, const sol::table &trial )
{
    static const std::map<std::string_view, std::string_view> trial_kinds = {
        { "none", "NONE" }, { "lie", "LIE" }, { "persuade", "PERSUADE" },
        { "intimidate", "INTIMIDATE" }, { "skill_check", "SKILL_CHECK" },
    };
    json.member( "trial" );
    json.start_object();
    if( const auto kind = trial.get<sol::optional<std::string>>( "kind" ) ) {
        const auto native = trial_kinds.find( *kind );
        if( native == trial_kinds.end() ) {
            throw std::invalid_argument( "unsupported dialogue trial: " + *kind );
        }
        json.member( "type", native->second );
    }
    write_placement_member<int>( json, trial, "difficulty", "difficulty" );
    write_placement_member<std::string>( json, trial, "skill", "skill_required" );
    if( const auto modifiers = trial.get<sol::optional<sol::table>>( "modifiers" ) ) {
        json.member( "mod" );
        json.start_array();
        for( std::size_t i = 1, count = modifiers->size(); i <= count; ++i ) {
            const sol::table modifier = modifiers->raw_get<sol::table>( i );
            json.start_array();
            json.write( modifier.get<std::string>( "score" ) );
            json.write( modifier.get<int>( "scale" ) );
            json.end_array();
        }
        json.end_array();
    }
    json.end_object();
}

void write_static_dialogue_reply( JsonOut &json, const sol::table &reply )
{
    json.start_object();
    write_item_text( json, "text", reply.raw_get<sol::object>( "text" ), false );
    write_static_dialogue_outcome( json, reply );
    write_item_fields<bool>( json, reply, {
        { "switch", "switch" }, { "default", "default" }, { "show_always", "show_always" },
    } );
    write_item_fields<std::string>( json, reply, {
        { "show_reason", "show_reason" }, { "failure_topic", "failure_topic" },
    } );
    write_item_text( json, "failure_explanation", reply.raw_get<sol::object>( "failure_explanation" ), false );
    if( const auto trial = reply.get<sol::optional<sol::table>>( "trial" ) ) {
        write_static_dialogue_trial( json, *trial );
    }
    for( const char *field : { "success", "failure" } ) {
        if( const auto outcome = reply.get<sol::optional<sol::table>>( field ) ) {
            json.member( field );
            json.start_object();
            write_static_dialogue_outcome( json, *outcome );
            json.end_object();
        }
    }
    json.end_object();
}

void load_static_dialogue_topic( const sol::table &options, const std::string &source )
{
    std::ostringstream serialized;
    JsonOut json( serialized );
    json.start_object();
    json.member( "type", "talk_topic" );
    const sol::object id = options.raw_get<sol::object>( "id" );
    if( id.get_type() == sol::type::table ) {
        const auto ids = bounded_string_array( id.as<sol::table>(), "id",
                         std::numeric_limits<std::size_t>::max(), "dialogue topic" );
        if( ids.empty() ) {
            throw std::invalid_argument( "dialogue topic requires at least one id" );
        }
        json.member( "id", ids );
    } else {
        json.member( "id", id.as<std::string>() );
    }
    talk_topic_rules rules;
    const sol::object line = options.raw_get<sol::object>( "line" );
    if( line.get_type() != sol::type::nil ) {
        rules.line = read_static_dialogue_line( line );
    }
    write_item_fields<bool>( json, options, {
        { "insert_before_standard_exits", "insert_before_standard_exits" },
        { "replace_native_replies", "replace_built_in_responses" },
    } );
    if( const auto replies = options.get<sol::optional<sol::table>>( "replies" ) ) {
        json.member( "responses" );
        json.start_array();
        for( std::size_t i = 1, count = replies->size(); i <= count; ++i ) {
            const sol::table reply = replies->raw_get<sol::table>( i );
            rules.responses.push_back( read_static_dialogue_rules( reply, source ) );
            write_static_dialogue_reply( json, reply );
        }
        json.end_array();
    }
    if( const auto repeats = options.get<sol::optional<sol::table>>( "repeat_replies" ) ) {
        json.member( "repeat_responses" );
        json.start_array();
        for( std::size_t i = 1, count = repeats->size(); i <= count; ++i ) {
            const sol::table repeat = repeats->raw_get<sol::table>( i );
            json.start_object();
            write_item_ids( json, repeat, { { "items", "for_item" }, { "categories", "for_category" } } );
            if( repeat.get_or( "interlocutor_inventory", false ) ) {
                json.member( "is_npc", true );
            }
            if( repeat.get_or( "include_containers", false ) ) {
                json.member( "include_containers", true );
            }
            json.member( "response" );
            const sol::table reply = repeat.get<sol::table>( "reply" );
            rules.repeats.push_back( read_static_dialogue_rules( reply, source ) );
            write_static_dialogue_reply( json, reply );
            json.end_object();
        }
        json.end_array();
    }
    if( const auto entries = options.get<sol::optional<sol::table>>( "on_enter" ) ) {
        for( std::size_t i = 1, count = entries->size(); i <= count; ++i ) {
            rules.on_enter.push_back( read_static_dialogue_entry( entries->raw_get<sol::table>( i ), source ) );
        }
    }
    json.end_object();

    // Use the native accumulator so same-id contributions and aliases retain
    // their JSON/Lua interleaving, including replies inserted above exits.
    const JsonObject definition = json_loader::from_string( serialized.str() ).get_object();
    static_cast<void>( definition.get_string( "type" ) );
    load_ordered_talk_topic( definition, source, &rules );
}

void write_static_mutation_links( JsonOut &json, const sol::table &options )
{
    write_item_ids( json, options, {
        { "categories", "category" }, { "prerequisites", "prereqs" },
        { "secondary_prerequisites", "prereqs2" }, { "threshold_requirements", "threshreq" },
        { "cancels", "cancels" }, { "replacements", "changes_to" }, { "additions", "leads_to" },
        { "flags", "flags" }, { "active_flags", "active_flags" }, { "inactive_flags", "inactive_flags" },
        { "types", "types" },
    } );
}

template<typename T>
void write_static_mutation_pairs( JsonOut &json, const sol::table &options, const char *field,
                                  const char *native )
{
    if( const auto entries = options.get<sol::optional<sol::table>>( field ) ) {
        json.member( native );
        json.start_array();
        for( const auto &[key, value] : *entries ) {
            json.start_array();
            json.write( key.as<std::string>() );
            json.write( value.as<T>() );
            json.end_array();
        }
        json.end_array();
    }
}

void write_static_mutation_nutrition( JsonOut &json, const sol::table &options )
{
    write_static_mutation_pairs<int>( json, options, "vitamin_intervals", "vitamin_rates" );
    if( const auto absorption = options.get<sol::optional<sol::table>>( "vitamin_absorption" ) ) {
        json.member( "vitamins_absorb_multi" );
        json.start_array();
        for( const auto &[material, entries] : *absorption ) {
            json.start_array();
            json.write( material.as<std::string>() );
            json.start_array();
            for( const auto &[vitamin, multiplier] : entries.as<sol::table>() ) {
                json.start_array();
                json.write( vitamin.as<std::string>() );
                json.write( multiplier.as<double>() );
                json.end_array();
            }
            json.end_array();
            json.end_array();
        }
        json.end_array();
    }
}

void write_static_mutation_protection( JsonOut &json, const sol::table &options )
{
    if( const auto armor = options.get<sol::optional<sol::table>>( "armor" ) ) {
        json.member( "armor" );
        json.start_array();
        for( std::size_t i = 1, count = armor->size(); i <= count; ++i ) {
            const sol::table entry = armor->raw_get<sol::table>( i );
            json.start_object();
            write_item_ids( json, entry, { { "parts", "parts" }, { "part_types", "part_types" } } );
            for( const auto &[damage_type, value] : entry.get<sol::table>( "resistances" ) ) {
                json.member( damage_type.as<std::string>(), value.as<double>() );
            }
            json.end_object();
        }
        json.end_array();
    }
    if( const auto protection = options.get<sol::optional<sol::table>>( "wet_protection" ) ) {
        json.member( "wet_protection" );
        json.start_array();
        for( std::size_t i = 1, count = protection->size(); i <= count; ++i ) {
            const sol::table entry = protection->raw_get<sol::table>( i );
            json.start_object();
            json.member( "part", entry.get<std::string>( "part" ) );
            write_item_fields<int>( json, entry, {
                { "ignored", "ignored" }, { "neutral", "neutral" }, { "good", "good" },
            } );
            json.end_object();
        }
        json.end_array();
    }
    write_static_mutation_pairs<int>( json, options, "encumbrance", "encumbrance_always" );
    write_static_mutation_pairs<int>( json, options, "covered_encumbrance", "encumbrance_covered" );
    if( const auto multiplier = options.get<sol::optional<sol::table>>( "encumbrance_multipliers" ) ) {
        write_item_keyed_values<double>( json, "encumbrance_multiplier_always", *multiplier );
    }
    if( const auto bionic = options.get<sol::optional<sol::table>>( "bionic_slots" ) ) {
        write_item_keyed_values<int>( json, "bionic_slot_bonuses", *bionic );
    }
}

void write_static_mutation_variants( JsonOut &json, const sol::table &options )
{
    if( const auto variants = options.get<sol::optional<sol::table>>( "variants" ) ) {
        json.member( "variants" );
        json.start_array();
        for( std::size_t i = 1, count = variants->size(); i <= count; ++i ) {
            const sol::table variant = variants->raw_get<sol::table>( i );
            json.start_object();
            json.member( "id", variant.get<std::string>( "id" ) );
            write_item_text( json, "name", variant.raw_get<sol::object>( "name" ), false );
            write_item_text( json, "description", variant.raw_get<sol::object>( "description" ), false );
            write_placement_member<int>( json, variant, "weight", "weight" );
            write_placement_member<bool>( json, variant, "append_description", "append_desc" );
            json.end_object();
        }
        json.end_array();
    }
    if( const auto appearance = options.get<sol::optional<sol::table>>( "appearance" ) ) {
        json.member( "override_look" );
        json.start_object();
        json.member( "id", appearance->get<std::string>( "id" ) );
        json.member( "tile_category", appearance->get<std::string>( "tile_category" ) );
        json.end_object();
    }
}

void write_static_mutation_uses( JsonOut &json, const sol::table &options )
{
    write_item_text( json, "activation_msg", options.raw_get<sol::object>( "activation_message" ), false );
    const sol::object cooldown = options.raw_get<sol::object>( "cooldown" );
    if( cooldown.get_type() == sol::type::string ) {
        json.member( "time", cooldown.as<std::string>() );
    } else if( cooldown.get_type() == sol::type::number ) {
        json.member( "time", cooldown.as<int>() );
    }
    for( const char *field : { "spawn_item", "ranged_mutation" } ) {
        if( const auto action = options.get<sol::optional<sol::table>>( field ) ) {
            json.member( field );
            json.start_object();
            write_placement_member<std::string>( json, *action, "item", "type" );
            write_item_text( json, "message", action->raw_get<sol::object>( "message" ), false );
            json.end_object();
        }
    }
    if( const auto transform = options.get<sol::optional<sol::table>>( "transform" ) ) {
        json.member( "transform" );
        json.start_object();
        write_placement_member<std::string>( json, *transform, "target", "target" );
        write_item_text( json, "msg_transform", transform->raw_get<sol::object>( "message" ), false );
        write_item_fields<bool>( json, *transform, { { "active", "active" }, { "safe", "safe" } } );
        write_placement_member<int>( json, *transform, "moves", "moves" );
        json.end_object();
    }
}

void write_static_mutation_attacks( JsonOut &json, const sol::table &options )
{
    if( const auto attacks = options.get<sol::optional<sol::table>>( "attacks" ) ) {
        json.member( "attacks" );
        json.start_array();
        for( std::size_t i = 1, count = attacks->size(); i <= count; ++i ) {
            const sol::table attack = attacks->raw_get<sol::table>( i );
            json.start_object();
            write_item_text( json, "attack_text_u", attack.raw_get<sol::object>( "player_message" ), false );
            write_item_text( json, "attack_text_npc", attack.raw_get<sol::object>( "npc_message" ), false );
            write_item_ids( json, attack, { { "required_mutations", "required_mutations" },
                { "blocker_mutations", "blocker_mutations" } } );
            write_placement_member<std::string>( json, attack, "body_part", "body_part" );
            write_placement_member<int>( json, attack, "chance", "chance" );
            write_placement_member<bool>( json, attack, "native_effect", "hardcoded_effect" );
            write_item_damage( json, attack, "base_damage", "base_damage" );
            write_item_damage( json, attack, "strength_damage", "strength_damage" );
            json.end_object();
        }
        json.end_array();
    }
}

void write_static_mutation_comfort( JsonOut &json, const sol::table &options )
{
    if( const auto profiles = options.get<sol::optional<sol::table>>( "comfort" ) ) {
        json.member( "comfort" );
        json.start_array();
        for( std::size_t i = 1, count = profiles->size(); i <= count; ++i ) {
            const sol::table profile = profiles->raw_get<sol::table>( i );
            json.start_object();
            write_placement_member<std::string>( json, profile, "comfort", "comfort" );
            write_item_fields<bool>( json, profile, {
                { "any_condition", "conditions_any" }, { "add_human_comfort", "add_human_comfort" },
                { "use_better_comfort", "use_better_comfort" }, { "add_sleep_aids", "add_sleep_aids" },
            } );
            if( const auto conditions = profile.get<sol::optional<sol::table>>( "conditions" ) ) {
                json.member( "conditions" );
                json.start_array();
                for( std::size_t j = 1, n = conditions->size(); j <= n; ++j ) {
                    const sol::table condition = conditions->raw_get<sol::table>( j );
                    json.start_object();
                    json.member( "type", condition.get<std::string>( "kind" ) );
                    write_item_fields<std::string>( json, condition, { { "id", "id" }, { "flag", "flag" } } );
                    write_placement_member<int>( json, condition, "intensity", "intensity" );
                    write_item_fields<bool>( json, condition, { { "invert", "invert" }, { "active", "active" } } );
                    json.end_object();
                }
                json.end_array();
            }
            for( const auto &[field, native] : {
                     item_field{ "try_message", "msg_try" }, { "hint_message", "msg_hint" },
                     { "sleep_message", "msg_sleep" },
                 } ) {
                if( const auto message = profile.get<sol::optional<sol::table>>( field ) ) {
                    json.member( native );
                    json.start_object();
                    write_item_text( json, "text", message->raw_get<sol::object>( "text" ), false );
                    write_placement_member<std::string>( json, *message, "rating", "rating" );
                    json.end_object();
                }
            }
            json.end_object();
        }
        json.end_array();
    }
}

void load_static_mutation( const sol::table &options, const std::string &source )
{
    std::ostringstream serialized;
    JsonOut json( serialized );
    json.start_object();
    json.member( "type", "mutation" );
    json.member( options.get_or( "abstract", false ) ? "abstract" : "id",
                 options.get<std::string>( "id" ) );
    write_item_text( json, "name", options.raw_get<sol::object>( "name" ), false );
    write_item_text( json, "description", options.raw_get<sol::object>( "description" ), false );
    write_item_fields<std::string>( json, options, {
        { "copy_from", "copy-from" }, { "scent_type", "scent_type" },
    } );
    write_item_fields<int>( json, options, {
        { "points", "points" }, { "vitamin_cost", "vitamin_cost" }, { "visibility", "visibility" },
        { "ugliness", "ugliness" }, { "cost", "cost" }, { "scent_intensity", "scent_intensity" },
    } );
    write_item_fields<bool>( json, options, {
        { "starting_trait", "starting_trait" }, { "chargen_allow_npc", "chargen_allow_npc" },
        { "random_start_allowed", "random_start_allowed" }, { "mixed_effect", "mixed_effect" },
        { "active", "active" }, { "starts_active", "starts_active" }, { "destroys_gear", "destroys_gear" },
        { "allow_soft_gear", "allow_soft_gear" }, { "consumes_calories", "kcal" },
        { "consumes_water", "thirst" }, { "consumes_rest", "sleepiness" },
        { "consumes_mana", "mana" }, { "consumes_stamina", "stamina" },
        { "valid", "valid" }, { "purifiable", "purifiable" }, { "threshold", "threshold" },
        { "strict_threshold_requirements", "strict_threshreq" }, { "profession", "profession" },
        { "debug", "debug" }, { "player_display", "player_display" }, { "vanity", "vanity" },
        { "dummy", "dummy" }, { "activation_setup_only", "activated_is_setup" },
    } );
    write_item_ids( json, options, {
        { "initial_martial_arts", "initial_ma_styles" }, { "threshold_substitutes", "threshold_substitutes" },
        { "ignored_by", "ignored_by" }, { "empathize_with", "empathize_with" },
        { "no_empathize_with", "no_empathize_with" }, { "can_only_eat", "can_only_eat" },
        { "can_only_heal_with", "can_only_heal_with" }, { "can_heal_with", "can_heal_with" },
        { "allowed_categories", "allowed_category" }, { "enchantments", "enchantments" },
        { "bionic_exclusions", "no_cbm_on_bp" }, { "restricts_gear", "restricts_gear" },
        { "remove_rigid", "remove_rigid" }, { "allowed_item_flags", "allowed_items" },
        { "integrated_armor", "integrated_armor" },
    } );
    write_mapgen_range( json, "bodytemp_modifiers", options.raw_get<sol::object>( "body_temperature" ) );
    write_static_mutation_links( json, options );
    for( const auto &[field, native] : { item_field{ "add", "extend" }, { "remove", "delete" } } ) {
        if( const auto changes = options.get<sol::optional<sol::table>>( field ) ) {
            json.member( native );
            json.start_object();
            write_static_mutation_links( json, *changes );
            json.end_object();
        }
    }
    write_static_mutation_pairs<int>( json, options, "monster_cameras", "moncams" );
    write_static_mutation_pairs<int>( json, options, "spells_learned", "spells_learned" );
    write_static_mutation_pairs<int>( json, options, "craft_skill_bonuses", "craft_skill_bonus" );
    write_static_mutation_pairs<double>( json, options, "body_light", "lumination" );
    write_static_mutation_pairs<int>( json, options, "species_anger", "anger_relations" );
    if( const auto social = options.get<sol::optional<sol::table>>( "social_modifiers" ) ) {
        json.member( "social_modifiers" );
        json.start_object();
        write_item_fields<int>( json, *social, {
            { "lie", "lie" }, { "persuade", "persuade" }, { "intimidate", "intimidate" },
        } );
        json.end_object();
    }
    if( const auto personality = options.get<sol::optional<sol::table>>( "personality" ) ) {
        json.member( "personality_score" );
        json.start_object();
        write_item_fields<int>( json, *personality, {
            { "min_aggression", "min_aggression" }, { "max_aggression", "max_aggression" },
            { "min_bravery", "min_bravery" }, { "max_bravery", "max_bravery" },
            { "min_collector", "min_collector" }, { "max_collector", "max_collector" },
            { "min_altruism", "min_altruism" }, { "max_altruism", "max_altruism" },
        } );
        json.end_object();
    }
    if( const auto qualities = options.get<sol::optional<sol::table>>( "provided_qualities" ) ) {
        write_item_keyed_values<int>( json, "provided_qualities", *qualities );
    }
    write_static_mutation_variants( json, options );
    write_static_mutation_nutrition( json, options );
    write_static_mutation_protection( json, options );
    write_static_mutation_uses( json, options );
    write_static_mutation_attacks( json, options );
    write_static_mutation_comfort( json, options );
    const auto activate = options.get<sol::optional<std::string>>( "on_activate" );
    const auto deactivate = options.get<sol::optional<std::string>>( "on_deactivate" );
    const auto process = options.get<sol::optional<std::string>>( "on_process" );
    if( activate || deactivate || process ) {
        // Keep the names on the native input for deferred inheritance after
        // the temporary Lua state has been discarded.
        json.member( "//ccb_lua_mutation_lifecycle" );
        json.start_object();
        if( activate ) {
            json.member( "activate", *activate );
        }
        if( deactivate ) {
            json.member( "deactivate", *deactivate );
        }
        if( process ) {
            json.member( "process", *process );
        }
        json.end_object();
    }
    json.end_object();
    const JsonObject definition = json_loader::from_string( serialized.str() ).get_object();
    static_cast<void>( definition.get_string( "type" ) );
    mutation_branch::load_trait( definition, source );
}

void write_static_monster_spell( JsonOut &json, const sol::table &options, const char *field,
                                 const char *native )
{
    if( const auto spell = options.get<sol::optional<sol::table>>( field ) ) {
        json.member( native );
        json.start_object();
        json.member( "id", spell->get<std::string>( "id" ) );
        write_item_fields<int>( json, *spell, {
            { "once_in", "once_in" }, { "min_level", "min_level" }, { "max_level", "max_level" },
        } );
        write_placement_member<bool>( json, *spell, "hit_self", "hit_self" );
        write_item_text( json, "message", spell->raw_get<sol::object>( "message" ), false );
        write_item_text( json, "npc_message", spell->raw_get<sol::object>( "npc_message" ), false );
        json.end_object();
    }
}

void write_static_monster_effect_list( JsonOut &json, const sol::table &options, const char *field,
                                       const char *native )
{
    if( const auto effects = options.get<sol::optional<sol::table>>( field ) ) {
        json.member( native );
        json.start_array();
        for( std::size_t i = 1, count = effects->size(); i <= count; ++i ) {
            const sol::table effect = effects->raw_get<sol::table>( i );
            json.start_object();
            json.member( "id", effect.get<std::string>( "id" ) );
            write_item_fields<bool>( json, effect, {
                { "permanent", "permanent" }, { "affect_hit_body_part", "affect_hit_bp" },
            } );
            write_placement_member<double>( json, effect, "chance", "chance" );
            write_placement_member<std::string>( json, effect, "body_part", "bp" );
            write_item_text( json, "message", effect.raw_get<sol::object>( "message" ), false );
            write_mapgen_range( json, "duration", effect.raw_get<sol::object>( "duration" ) );
            write_mapgen_range( json, "intensity", effect.raw_get<sol::object>( "intensity" ) );
            json.end_object();
        }
        json.end_array();
    }
}

void write_monster_gun_attack( JsonOut &json, const sol::table &gun )
{
    write_item_fields<std::string>( json, gun, { { "weapon", "gun_type" }, { "ammo", "ammo_type" } } );
    write_item_fields<int>( json, gun, {
        { "strength", "fake_str" }, { "dexterity", "fake_dex" }, { "intelligence", "fake_int" },
        { "perception", "fake_per" }, { "max_ammo", "max_ammo" }, { "targeting_cost", "targeting_cost" },
        { "targeting_timeout", "targeting_timeout" }, { "targeting_extension", "targeting_timeout_extend" },
        { "targeting_volume", "targeting_volume" }
    } );
    write_item_fields<bool>( json, gun, {
        { "lock_player", "require_targeting_player" }, { "lock_npc", "require_targeting_npc" },
        { "lock_monster", "require_targeting_monster" }, { "laser_lock", "laser_lock" },
        { "target_moving_vehicles", "target_moving_vehicles" }, { "require_sunlight", "require_sunlight" }
    } );
    for( const auto &[field, native] : { item_field{ "description", "description" },
             { "failure_message", "failure_msg" }, { "empty_sound", "no_ammo_sound" },
             { "targeting_sound", "targeting_sound" }
         } ) {
        write_item_text( json, native, gun.raw_get<sol::object>( field ), false );
    }
    if( const auto skills = gun.get<sol::optional<sol::table>>( "skills" ) ) {
        json.member( "fake_skills" );
        json.start_array();
        const std::size_t count = checked_dense_array_size( *skills, "monster gun skills",
                                  std::numeric_limits<std::size_t>::max() );
        for( std::size_t index = 1; index <= count; ++index ) {
            const sol::table skill = skills->raw_get<sol::table>( index );
            json.start_array();
            json.write( skill.get<std::string>( "id" ) );
            json.write( skill.get<int>( "level" ) );
            json.end_array();
        }
        json.end_array();
    }
    if( const auto ranges = gun.get<sol::optional<sol::table>>( "ranges" ) ) {
        json.member( "ranges" );
        json.start_array();
        const std::size_t count = checked_dense_array_size( *ranges, "monster gun ranges",
                                  std::numeric_limits<std::size_t>::max() );
        for( std::size_t index = 1; index <= count; ++index ) {
            const sol::table range = ranges->raw_get<sol::table>( index );
            json.start_array();
            json.write( range.get<int>( "minimum" ) );
            json.write( range.get<int>( "maximum" ) );
            if( const auto mode = range.get<sol::optional<std::string>>( "mode" ) ) {
                json.write( *mode );
            }
            json.end_array();
        }
        json.end_array();
    }
}

void write_monster_attack_cooldown( JsonOut &json, const sol::object &cooldown )
{
    if( cooldown.get_type() != sol::type::table ) {
        json.write( cooldown.as<double>() );
        return;
    }
    const sol::table bounds = cooldown.as<sol::table>();
    if( checked_dense_array_size( bounds, "monster attack cooldown", 2 ) != 2 ) {
        throw std::invalid_argument( "monster attack cooldown requires a minimum and a maximum" );
    }
    json.start_array();
    json.write( bounds.raw_get<int>( 1 ) );
    json.write( bounds.raw_get<int>( 2 ) );
    json.end_array();
}

void write_static_monster_attack_fields( JsonOut &json, const sol::table &attack, const char *kind_field )
{
    const auto kind = attack.get<sol::optional<std::string>>( "kind" );
    if( kind ) {
        if( *kind == "scripted" ) {
            json.member( "//ccb_lua_attack_action", attack.get<std::string>( "action" ) );
        } else if( *kind != "leap" && *kind != "spell" && *kind != "melee" && *kind != "bite" &&
                   *kind != "gun" && *kind != "polymorph_special" ) {
            throw std::invalid_argument( "unknown monster attack kind: " + *kind );
        }
        json.member( kind_field, *kind );
        write_placement_member<std::string>( json, attack, "id", "id" );
    } else {
        json.member( "id", attack.get<std::string>( "id" ) );
    }
    if( const auto gun = attack.get<sol::optional<sol::table>>( "gun" ) ) {
        write_monster_gun_attack( json, *gun );
    }
    write_placement_member<std::string>( json, attack, "form", "mon_id" );
    write_item_fields<bool>( json, attack, {
        { "keep_speed", "poly_keep_speed" }, { "keep_hp", "poly_keep_hp" }, { "keep_anger", "poly_keep_anger" }
    } );
    write_item_fields<int>( json, attack, {
        { "move_cost", "move_cost" }, { "accuracy", "accuracy" }, { "range", "range" },
        { "minimum_hit_size", "hitsize_min" }, { "maximum_hit_size", "hitsize_max" },
        { "throw_strength", "throw_strength" }, { "infection_chance", "infection_chance" },
    } );
    const sol::object cooldown = attack.raw_get<sol::object>( "cooldown" );
    if( cooldown.valid() && cooldown.get_type() != sol::type::nil ) {
        json.member( "cooldown" );
        write_monster_attack_cooldown( json, cooldown );
    }
    write_item_fields<double>( json, attack, {
        { "minimum_damage_multiplier", "min_mul" },
        { "maximum_damage_multiplier", "max_mul" }, { "minimum_range", "min_range" },
        { "maximum_range", "max_range" }, { "minimum_target_distance", "min_consider_range" },
        { "maximum_target_distance", "max_consider_range" },
    } );
    write_item_fields<bool>( json, attack, {
        { "allow_no_target", "allow_no_target" }, { "prefer_leap", "prefer_leap" },
        { "random_leap", "random_leap" }, { "ignore_destination_terrain", "ignore_dest_terrain" },
        { "ignore_destination_danger", "ignore_dest_danger" }, { "no_adjacent", "no_adjacent" },
        { "dodgeable", "dodgeable" }, { "uncanny_dodgeable", "uncanny_dodgeable" },
        { "blockable", "blockable" }, { "effects_require_damage", "effects_require_dmg" },
        { "effects_require_organic", "effects_require_organic" }, { "spread_damage", "spread_damage" },
        { "attack_upper", "attack_upper" }, { "grab", "grab" },
    } );
    write_placement_member<std::string>( json, attack, "when", "//ccb_lua_attack_when" );
    write_placement_member<std::string>( json, attack, "on_hit", "//ccb_lua_attack_hit" );
    if( const auto parts = attack.get<sol::optional<sol::table>>( "body_part_types" ) ) {
        write_mapgen_weighted_choices<int, false>( json, "body_part_types", *parts );
    }
    write_mapgen_range( json, "attack_amount", attack.raw_get<sol::object>( "attack_count" ) );
    write_item_damage( json, attack, "damage", "damage_max_instance" );
    write_static_monster_spell( json, attack, "spell", "spell_data" );
    for( const auto &[field, native] : {
             item_field{ "message", "message" }, { "casting_message", "monster_message" },
             { "avatar_hit", "hit_dmg_u" }, { "avatar_miss", "miss_msg_u" },
             { "avatar_no_damage", "no_dmg_msg_u" }, { "npc_hit", "hit_dmg_npc" },
             { "npc_miss", "miss_msg_npc" }, { "npc_no_damage", "no_dmg_msg_npc" },
             { "avatar_thrown", "throw_msg_u" }, { "npc_thrown", "throw_msg_npc" },
         } ) {
        write_item_text( json, native, attack.raw_get<sol::object>( field ), false );
    }
    for( const auto &[field, native] : {
             item_field{ "effects", "effects" }, { "self_effects", "self_effects" },
             { "self_effects_always", "self_effects_always" }, { "self_effects_on_hit", "self_effects_onhit" },
             { "self_effects_on_damage", "self_effects_ondmg" },
         } ) {
        write_static_monster_effect_list( json, attack, field, native );
    }
    if( const auto grab = attack.get<sol::optional<sol::table>>( "grab_settings" ) ) {
        json.member( "grab_data" );
        json.start_object();
        write_item_fields<int>( json, *grab, {
            { "strength", "grab_strength" }, { "pull_chance", "pull_chance" },
            { "drag_distance", "drag_distance" }, { "drag_deviation", "drag_deviation" },
            { "break_distance", "drag_grab_break_distance" },
        } );
        write_item_fields<double>( json, *grab, {
            { "move_cost_multiplier", "drag_movecost_mod" }, { "pull_weight_ratio", "pull_weight_ratio" },
        } );
        write_item_fields<bool>( json, *grab, {
            { "exclusive", "exclusive_grab" }, { "respect_seatbelts", "respect_seatbelts" },
        } );
        write_placement_member<std::string>( json, *grab, "effect", "grab_effect" );
        json.end_object();
    }
}

void write_static_monster_attacks( JsonOut &json, const sol::table &options )
{
    if( const auto attacks = options.get<sol::optional<sol::table>>( "attacks" ) ) {
        json.member( "special_attacks" );
        json.start_array();
        for( std::size_t i = 1, count = attacks->size(); i <= count; ++i ) {
            const sol::table attack = attacks->raw_get<sol::table>( i );
            if( const auto base = attack.get<sol::optional<std::string>>( "reference" ) ) {
                json.start_array();
                json.write( *base );
                write_monster_attack_cooldown( json, attack.raw_get<sol::object>( "cooldown" ) );
                json.end_array();
            } else {
                json.start_object();
                write_static_monster_attack_fields( json, attack, "type" );
                json.end_object();
            }
        }
        json.end_array();
    }
}

void write_static_monster_drop_entries( JsonOut &json, const sol::table &entries )
{
    json.start_array();
    for( std::size_t i = 1, count = entries.size(); i <= count; ++i ) {
        const sol::table entry = entries.raw_get<sol::table>( i );
        json.start_object();
        write_item_fields<std::string>( json, entry, { { "item", "item" }, { "group", "group" } } );
        write_placement_member<int>( json, entry, "probability", "prob" );
        for( const char *field : { "count", "charges", "damage" } ) {
            write_mapgen_range( json, field, entry.raw_get<sol::object>( field ) );
        }
        json.end_object();
    }
    json.end_array();
}

void write_static_monster_death( JsonOut &json, const sol::table &death )
{
    const sol::object drops = death.raw_get<sol::object>( "drops" );
    if( drops.get_type() == sol::type::string ) {
        json.member( "death_drops", drops.as<std::string>() );
    } else if( drops.get_type() == sol::type::table ) {
        const sol::table drop_group = drops.as<sol::table>();
        if( const auto entries = drop_group.get<sol::optional<sol::table>>( "entries" ) ) {
            json.member( "death_drops" );
            write_static_monster_drop_entries( json, *entries );
        } else {
            json.member( "death_drops" );
            json.start_object();
            write_placement_member<std::string>( json, drop_group, "kind", "subtype" );
            if( const auto items = drop_group.get<sol::optional<sol::table>>( "items" ) ) {
                json.member( "items" );
                write_static_monster_drop_entries( json, *items );
            }
            if( const auto groups = drop_group.get<sol::optional<sol::table>>( "groups" ) ) {
                write_mapgen_weighted_choices<int, false>( json, "groups", *groups );
            }
            json.end_object();
        }
    }
    const auto outcome = death.get<sol::optional<sol::table>>( "outcome" );
    if( !outcome ) {
        return;
    }
    json.member( "death_function" );
    json.start_object();
    write_placement_member<std::string>( json, *outcome, "corpse", "corpse_type" );
    write_item_text( json, "message", outcome->raw_get<sol::object>( "message" ), false );
    write_static_monster_spell( json, *outcome, "spell", "effect" );
    json.end_object();
    if( const auto handler = outcome->get<sol::optional<std::string>>( "on_death" ) ) {
        if( handler->empty() ) {
            throw std::invalid_argument( "monster on_death requires a named runtime handler" );
        }
        json.member( "//ccb_lua_monster_death_handler", *handler );
    }
}

void write_static_monster_lifecycle( JsonOut &json, const sol::table &options )
{
    const sol::object upgrades = options.raw_get<sol::object>( "upgrade" );
    if( upgrades.get_type() == sol::type::boolean && !upgrades.as<bool>() ) {
        json.member( "upgrades", false );
    } else if( upgrades.get_type() == sol::type::table ) {
        const sol::table upgrade = upgrades.as<sol::table>();
        json.member( "upgrades" );
        json.start_object();
        write_item_fields<int>( json, upgrade, {
            { "half_life", "half_life" }, { "grow_at_age", "age_grow" }, { "spawn_range", "spawn_range" },
        } );
        write_item_fields<std::string>( json, upgrade, {
            { "monster", "into" }, { "monster_group", "into_group" },
        } );
        write_item_fields<bool>( json, upgrade, {
            { "multiple_spawns", "multiple_spawns" }, { "despawn_when_null", "despawn_when_null" },
        } );
        json.end_object();
    }
    if( const auto reproduction = options.get<sol::optional<sol::table>>( "reproduction" ) ) {
        json.member( "reproduction" );
        json.start_object();
        write_placement_member<int>( json, *reproduction, "count", "baby_count" );
        const sol::object interval = reproduction->raw_get<sol::object>( "interval" );
        if( interval.get_type() == sol::type::string ) {
            json.member( "baby_timer", interval.as<std::string>() );
        } else if( interval.get_type() == sol::type::number ) {
            json.member( "baby_timer", interval.as<int>() );
        }
        if( const auto offspring = reproduction->get<sol::optional<sol::table>>( "offspring" ) ) {
            json.member( "baby_type" );
            json.start_object();
            write_item_fields<std::string>( json, *offspring, {
                { "monster", "baby_monster" }, { "monster_group", "baby_monster_group" },
                { "egg", "baby_egg" }, { "egg_group", "baby_egg_group" },
            } );
            json.end_object();
        }
        json.end_object();
    }
    if( const auto biosignature = options.get<sol::optional<sol::table>>( "biosignature" ) ) {
        json.member( "biosignature" );
        json.start_object();
        write_placement_member<std::string>( json, *biosignature, "item", "biosig_item" );
        const sol::object interval = biosignature->raw_get<sol::object>( "interval" );
        if( interval.get_type() == sol::type::string ) {
            json.member( "biosig_timer", interval.as<std::string>() );
        } else if( interval.get_type() == sol::type::number ) {
            json.member( "biosig_timer", interval.as<int>() );
        }
        json.end_object();
    }
}

void write_static_monster_traits( JsonOut &json, const sol::table &options )
{
    write_item_ids( json, options, {
        { "flags", "flags" }, { "species", "species" }, { "categories", "categories" },
        { "weakpoint_sets", "weakpoint_sets" },
        { "anger_triggers", "anger_triggers" }, { "fear_triggers", "fear_triggers" },
        { "placate_triggers", "placate_triggers" },
    } );
    if( const auto families = options.get<sol::optional<sol::table>>( "families" ) ) {
        json.member( "families" );
        json.start_array();
        const std::size_t count = checked_dense_array_size( *families, "weakpoint families",
                                  std::numeric_limits<std::size_t>::max() );
        for( std::size_t i = 1; i <= count; ++i ) {
            const sol::object value = families->raw_get<sol::object>( i );
            if( value.get_type() == sol::type::string ) {
                json.write( value.as<std::string>() );
            } else {
                const sol::table family = value.as<sol::table>();
                json.start_object();
                json.member( "proficiency", family.get<std::string>( "proficiency" ) );
                write_placement_member<std::string>( json, family, "id", "id" );
                write_item_fields<double>( json, family, { { "bonus", "bonus" }, { "penalty", "penalty" } } );
                json.end_object();
            }
        }
        json.end_array();
    }
    if( const auto skills = options.get<sol::optional<sol::table>>( "move_skills" ) ) {
        json.member( "move_skills" );
        json.start_object();
        write_item_fields<int>( json, *skills, {
            { "climb", "climb" }, { "swim", "swim" }, { "dig", "dig" },
        } );
        json.end_object();
    }
}

void write_static_monster_effects( JsonOut &json, const sol::table &options )
{
    write_static_monster_effect_list( json, options, "attack_effects", "attack_effs" );
    if( const auto emissions = options.get<sol::optional<sol::table>>( "emissions" ) ) {
        json.member( "emit_fields" );
        json.start_array();
        for( std::size_t i = 1, count = emissions->size(); i <= count; ++i ) {
            const sol::table emission = emissions->raw_get<sol::table>( i );
            json.start_object();
            json.member( "emit_id", emission.get<std::string>( "id" ) );
            json.member( "delay", emission.get<std::string>( "delay" ) );
            json.end_object();
        }
        json.end_array();
    }
    if( const auto regen = options.get<sol::optional<sol::table>>( "regeneration_modifiers" ) ) {
        write_item_keyed_values<int>( json, "regeneration_modifiers", *regen );
    }
}

template<typename T>
void write_static_monster_stat_changes( JsonOut &json, const sol::table &change )
{
    write_item_fields<T>( json, change, {
        { "speed", "speed" }, { "hp", "hp" }, { "morale", "morale" },
        { "melee_dice", "melee_dice" }, { "melee_sides", "melee_dice_sides" },
        { "melee_skill", "melee_skill" }, { "dodge", "dodge" }, { "attack_cost", "attack_cost" },
        { "vision_day", "vision_day" }, { "vision_night", "vision_night" },
        { "aggression", "aggression" }, { "regenerates", "regenerates" },
    } );
    if( const auto armor = change.get<sol::optional<sol::table>>( "armor" ) ) {
        write_item_keyed_values<double>( json, "armor", *armor );
    }
    write_item_damage( json, change, "melee_damage", "melee_damage" );
}

void write_inline_monster_weakpoints( JsonOut &json, const sol::table &options );

void write_static_monster_inheritance( JsonOut &json, const sol::table &inheritance )
{
    if( const auto add = inheritance.get<sol::optional<sol::table>>( "add" ) ) {
        json.member( "extend" );
        json.start_object();
        write_static_monster_traits( json, *add );
        write_inline_monster_weakpoints( json, *add );
        write_static_monster_attacks( json, *add );
        if( const auto armor = add->get<sol::optional<sol::table>>( "armor" ) ) {
            write_item_keyed_values<double>( json, "armor", *armor );
        }
        json.end_object();
    }
    if( const auto remove = inheritance.get<sol::optional<sol::table>>( "remove" ) ) {
        json.member( "delete" );
        json.start_object();
        write_static_monster_traits( json, *remove );
        write_item_ids( json, *remove, { { "attacks", "special_attacks" } } );
        if( const auto ids = remove->get<sol::optional<sol::table>>( "weakpoints" ) ) {
            json.member( "weakpoints" );
            json.start_array();
            for( const std::string &id : bounded_string_array( *ids, "weakpoints",
                    std::numeric_limits<std::size_t>::max(), "monster inheritance" ) ) {
                json.start_object();
                json.member( "id", id );
                json.end_object();
            }
            json.end_array();
        }
        json.end_object();
    }
    if( const auto scale = inheritance.get<sol::optional<sol::table>>( "scale" ) ) {
        json.member( "proportional" );
        json.start_object();
        write_static_monster_stat_changes<double>( json, *scale );
        write_item_fields<double>( json, *scale, { { "mass", "weight" }, { "volume", "volume" } } );
        json.end_object();
    }
    if( const auto offset = inheritance.get<sol::optional<sol::table>>( "offset" ) ) {
        json.member( "relative" );
        json.start_object();
        write_static_monster_stat_changes<int>( json, *offset );
        json.end_object();
    }
}

void load_static_monster( const sol::table &options, const std::string &source )
{
    std::ostringstream serialized;
    JsonOut json( serialized );
    json.start_object();
    json.member( "type", "MONSTER" );
    json.member( options.get_or( "abstract", false ) ? "abstract" : "id",
                 options.get<std::string>( "id" ) );
    const sol::object name = options.raw_get<sol::object>( "name" );
    if( name.get_type() != sol::type::nil ) {
        json.member( "name" );
        write_item_text_value( json, "name", name, true, true );
    }
    write_item_text( json, "description", options.raw_get<sol::object>( "description" ), false );
    write_item_fields<std::string>( json, options, {
        { "copy_from", "copy-from" }, { "ascii_picture", "ascii_picture" },
        { "default_faction", "default_faction" }, { "symbol", "symbol" },
        { "looks_like", "looks_like" }, { "body_type", "bodytype" }, { "color", "color" },
        { "volume", "volume" }, { "mass", "weight" }, { "phase", "phase" },
        { "harvest", "harvest" }, { "dissect", "dissect" }, { "decay", "decay" },
        { "speed_description", "speed_description" }, { "revert_item", "revert_to_itype" },
        { "broken_item", "broken_itype" }, { "mech_weapon", "mech_weapon" },
        { "mech_battery", "mech_battery" }, { "zombify_into", "zombify_into" },
        { "fungalize_into", "fungalize_into" }, { "burn_into", "burn_into" },
    } );
    write_item_fields<int>( json, options, {
        { "difficulty_adjustment", "diff" }, { "hp", "hp" }, { "speed", "speed" },
        { "aggression", "aggression" }, { "morale", "morale" },
        { "tracking_distance", "tracking_distance" }, { "attack_cost", "attack_cost" },
        { "melee_skill", "melee_skill" }, { "melee_dice", "melee_dice" }, { "melee_sides", "melee_dice_sides" },
        { "melee_armor_penetration", "melee_dice_ap" }, { "grab_strength", "grab_strength" },
        { "dodge", "dodge" }, { "bleed_rate", "bleed_rate" },
        { "vision_day", "vision_day" }, { "vision_night", "vision_night" },
        { "regenerates", "regenerates" }, { "mech_strength_bonus", "mech_str_bonus" },
        { "melee_training_cap", "melee_training_cap" }, { "absorb_ml_per_hp", "absorb_ml_per_hp" },
        { "split_move_cost", "split_move_cost" }, { "absorb_move_cost_min", "absorb_move_cost_min" },
        { "absorb_move_cost_max", "absorb_move_cost_max" },
    } );
    write_item_fields<double>( json, options, {
        { "mountable_weight_ratio", "mountable_weight_ratio" },
        { "status_chance_multiplier", "status_chance_multiplier" }, { "luminance", "luminance" },
        { "absorb_move_cost_per_ml", "absorb_move_cost_per_ml" },
    } );
    write_item_fields<bool>( json, options, {
        { "regenerates_in_dark", "regenerates_in_dark" }, { "regenerates_morale", "regen_morale" },
        { "aggressive_to_characters", "aggro_character" },
    } );
    write_static_monster_traits( json, options );
    write_inline_monster_weakpoints( json, options );
    write_item_ids( json, options, {
        { "trap_avoids", "trap_avoids" }, { "absorb_materials", "absorb_material" },
        { "ignored_absorb_materials", "no_absorb_material" },
        { "scents_tracked", "scents_tracked" }, { "scents_ignored", "scents_ignored" },
        { "chat_topics", "chat_topics" }, { "mating_seasons", "baby_flags" },
    } );
    if( const auto materials = options.get<sol::optional<sol::table>>( "materials" ) ) {
        write_item_materials( json, *materials, false );
    }
    if( const auto armor = options.get<sol::optional<sol::table>>( "armor" ) ) {
        write_item_keyed_values<double>( json, "armor", *armor );
    }
    if( const auto ammo = options.get<sol::optional<sol::table>>( "starting_ammo" ) ) {
        write_item_keyed_values<int>( json, "starting_ammo", *ammo );
    }
    write_item_damage( json, options, "melee_damage", "melee_damage" );
    if( const auto defense = options.get<sol::optional<sol::table>>( "defense" ) ) {
        json.member( "special_when_hit" );
        json.start_array();
        json.write( defense->get<std::string>( "id" ) );
        json.write( defense->get<int>( "chance" ) );
        json.end_array();
    }
    if( const auto block = options.get<sol::optional<sol::table>>( "block" ) ) {
        json.member( "block" );
        json.start_object();
        write_item_fields<int>( json, *block, {
            { "chance", "chance" }, { "effectiveness", "effectiveness" }, { "count", "count" },
        } );
        write_placement_member<bool>( json, *block, "ranged", "ranged" );
        json.end_object();
    }
    if( const auto pathing = options.get<sol::optional<sol::table>>( "pathing" ) ) {
        json.member( "path_settings" );
        json.start_object();
        write_item_fields<int>( json, *pathing, {
            { "max_distance", "max_dist" }, { "max_length", "max_length" }, { "bash_strength", "bash_strength" },
        } );
        write_item_fields<bool>( json, *pathing, {
            { "open_doors", "allow_open_doors" }, { "climb_stairs", "allow_climb_stairs" },
            { "avoid_traps", "avoid_traps" }, { "avoid_sharp", "avoid_sharp" },
            { "avoid_dangerous_fields", "avoid_dangerous_fields" },
        } );
        json.end_object();
    }
    if( const auto pet = options.get<sol::optional<sol::table>>( "pet" ) ) {
        json.member( "petfood" );
        json.start_object();
        write_item_ids( json, *pet, { { "food", "food" } } );
        write_item_text( json, "feed", pet->raw_get<sol::object>( "feed_message" ), false );
        write_item_text( json, "pet", pet->raw_get<sol::object>( "pet_message" ), false );
        json.end_object();
    }
    if( const auto mount = options.get<sol::optional<sol::table>>( "mount_items" ) ) {
        json.member( "mount_items" );
        json.start_object();
        write_item_fields<std::string>( json, *mount, {
            { "tied", "tied" }, { "tack", "tack" }, { "armor", "armor" },
        } );
        json.end_object();
    }
    if( const auto shearing = options.get<sol::optional<sol::table>>( "shearing" ) ) {
        json.member( "shearing" );
        json.start_array();
        for( std::size_t i = 1, count = shearing->size(); i <= count; ++i ) {
            const sol::table yield = shearing->raw_get<sol::table>( i );
            json.start_object();
            json.member( "result", yield.get<std::string>( "item" ) );
            write_placement_member<int>( json, yield, "amount", "amount" );
            write_placement_member<double>( json, yield, "volume_ratio", "ratio_volume" );
            json.end_object();
        }
        json.end_array();
    }
    write_static_monster_effects( json, options );
    write_static_monster_lifecycle( json, options );
    write_static_monster_attacks( json, options );
    if( const auto death = options.get<sol::optional<sol::table>>( "death" ) ) {
        write_static_monster_death( json, *death );
    }
    if( const auto inheritance = options.get<sol::optional<sol::table>>( "inheritance" ) ) {
        write_static_monster_inheritance( json, *inheritance );
    }
    json.end_object();
    const JsonObject definition = json_loader::from_string( serialized.str() ).get_object();
    static_cast<void>( definition.get_string( "type" ) );
    MonsterGenerator::generator().load_monster( definition, source );
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

template<typename Value, typename Writer>
void write_static_values( JsonOut &json, const sol::table &values, const char *field,
                          Writer write_value )
{
    const std::size_t count = checked_dense_array_size( values, field,
        std::numeric_limits<std::size_t>::max() );
    json.start_array();
    for( std::size_t i = 1; i <= count; ++i ) {
        write_value( json, values.raw_get<Value>( i ) );
    }
    json.end_array();
}

template<typename Writer>
void write_static_catalog_array( JsonOut &json, const sol::table &options, const char *field,
                                 const char *native, Writer write_entry )
{
    const auto entries = options.get<sol::optional<sol::table>>( field );
    if( !entries ) {
        return;
    }
    json.member( native );
    write_static_values<sol::table>( json, *entries, field, write_entry );
}

void write_static_trait_group_entry( JsonOut &json, const sol::table &entry )
{
    json.start_object();
    write_item_fields<std::string>( json, entry, {
        { "trait", "trait" }, { "group", "group" }, { "variant", "variant" }
    } );
    write_placement_member<int>( json, entry, "weight", "prob" );
    for( const char *kind : {
             "collection", "distribution"
         } ) {
        write_static_catalog_array( json, entry, kind, kind, write_static_trait_group_entry );
    }
    json.end_object();
}

void write_static_trait_group( JsonOut &json, const sol::table &options )
{
    json.member( "id", options.get<std::string>( "id" ) );
    const std::string kind = options.get<std::string>( "kind" );
    if( kind != "collection" && kind != "distribution" ) {
        throw std::invalid_argument( "trait group kind must be collection or distribution" );
    }
    json.member( "subtype", kind );
    write_static_catalog_array( json, options, "entries", "traits", write_static_trait_group_entry );
}

template<typename Number>
void write_static_weakpoint_range( JsonOut &json, const sol::table &options, const char *field,
                                   const char *native, bool duration = false )
{
    const sol::object range = options.raw_get<sol::object>( field );
    if( range.get_type() == sol::type::nil ) {
        return;
    }
    const auto write_endpoint = [&]( const sol::object &value ) {
        if( duration && value.get_type() == sol::type::string ) {
            json.write( value.as<std::string>() );
        } else {
            json.write( value.as<Number>() );
        }
    };
    json.member( native );
    if( range.get_type() == sol::type::table ) {
        const sol::table endpoints = range.as<sol::table>();
        if( checked_dense_array_size( endpoints, field, 2 ) != 2 ) {
            throw std::invalid_argument( std::string( field ) + " requires two endpoints" );
        }
        json.start_array();
        write_endpoint( endpoints.raw_get<sol::object>( 1 ) );
        write_endpoint( endpoints.raw_get<sol::object>( 2 ) );
        json.end_array();
    } else {
        write_endpoint( range );
    }
}

void write_static_weakpoint_effect( JsonOut &json, const sol::table &entry )
{
    json.start_object();
    write_placement_member<std::string>( json, entry, "effect", "effect" );
    write_placement_member<double>( json, entry, "chance", "chance" );
    write_placement_member<bool>( json, entry, "permanent", "permanent" );
    write_item_text( json, "message", entry.raw_get<sol::object>( "message" ), false );
    write_static_weakpoint_range<int>( json, entry, "duration", "duration", true );
    write_static_weakpoint_range<int>( json, entry, "intensity", "intensity" );
    write_static_weakpoint_range<double>( json, entry, "damage_percent", "damage_required" );
    write_static_weakpoint_range<int>( json, entry, "death_chance", "instant_death_chance" );
    json.end_object();
}

void write_weakpoint_members( JsonOut &json, const sol::table &entry )
{
    json.member( "id", entry.get<std::string>( "id" ) );
    write_item_text( json, "name", entry.raw_get<sol::object>( "name" ), false );
    write_placement_member<double>( json, entry, "coverage", "coverage" );
    write_item_fields<bool>( json, entry, { { "good", "is_good" }, { "head", "is_head" } } );
    for( const auto &[field, native] : {
             item_field{ "armor_multiplier", "armor_mult" }, { "armor_penalty", "armor_penalty" },
             { "damage_multiplier", "damage_mult" }, { "critical_multiplier", "crit_mult" },
             { "attack_coverage", "coverage_mult" }, { "difficulty", "difficulty" }
         } ) {
        if( const auto values = entry.get<sol::optional<sol::table>>( field ) ) {
            write_item_keyed_values<double>( json, native, *values );
        }
    }
    write_static_catalog_array( json, entry, "effects", "effects", write_static_weakpoint_effect );
}

void write_inline_monster_weakpoints( JsonOut &json, const sol::table &options )
{
    write_static_catalog_array( json, options, "weakpoints", "weakpoints",
    []( JsonOut & out, const sol::table & entry ) {
        out.start_object();
        write_weakpoint_members( out, entry );
        write_placement_member<std::string>( out, entry, "target_effect", "//ccb_lua_weakpoint_target_effect" );
        out.end_object();
    } );
}

weakpoint read_static_weakpoint( const sol::table &entry, const std::string &source,
                                 const std::string &set_id )
{
    std::ostringstream serialized;
    JsonOut json( serialized );
    serialized << std::defaultfloat << std::setprecision( std::numeric_limits<double>::max_digits10 );
    json.start_object();
    write_weakpoint_members( json, entry );
    json.end_object();
    weakpoint point;
    point.load( json_loader::from_string( serialized.str() ).get_object() );
    if( const auto predicate = entry.get<sol::optional<static_dialogue_predicate>>( "when" ) ) {
        point.condition = predicate->test;
        point.has_condition = true;
    }
    if( const auto effects = entry.get<sol::optional<sol::table>>( "effects" ) ) {
        for( std::size_t i = 0; i < point.effects.size(); ++i ) {
            const sol::table options = effects->raw_get<sol::table>( i + 1 );
            if( const auto handler = options.get<sol::optional<std::string>>( "on_hit" ) ) {
                if( handler->empty() ) {
                    throw std::invalid_argument( "weakpoint on_hit requires a named runtime handler" );
                }
                weakpoint_effect &effect = point.effects[i];
                effect.lua_platform_set_id = set_id;
                effect.lua_platform_weakpoint_id = point.id;
                effect.lua_platform_mod = source;
                effect.lua_platform_handler = *handler;
            }
        }
    }
    return point;
}

void load_static_weakpoint_set( const sol::table &options, const std::string &source )
{
    weakpoints definition;
    definition.id = weakpoints_id( options.get<std::string>( "id" ) );
    mod_tracker::assign_src( definition, source );
    const sol::table entries = options.get<sol::table>( "points" );
    const std::size_t count = checked_dense_array_size( entries, "weakpoints",
                              std::numeric_limits<std::size_t>::max() );
    for( std::size_t index = 1; index <= count; ++index ) {
        definition.add_point( read_static_weakpoint( entries.raw_get<sol::table>( index ), source,
                              definition.id.str() ) );
    }
    definition.sort_by_coverage();
    detail::weakpoint_set_registry().insert( definition );
}

void write_static_monster_faction_relations( JsonOut &json, const sol::table &options )
{
    for( const char *kind : {
             "by_mood", "neutral", "friendly", "hate"
         } ) {
        const sol::object relation = options.raw_get<sol::object>( kind );
        if( relation.get_type() == sol::type::string ) {
            json.member( kind, relation.as<std::string>() );
        } else {
            write_item_ids( json, options, { { kind, kind } } );
        }
    }
}

void write_static_monster_faction( JsonOut &json, const sol::table &options )
{
    json.member( "name", options.get<std::string>( "id" ) );
    write_placement_member<std::string>( json, options, "base", "base_faction" );
    write_placement_member<std::string>( json, options, "copy_from", "copy-from" );
    write_static_monster_faction_relations( json, options );
    for( const char *operation : {
             "extend", "delete"
         } ) {
        if( const auto relations = options.get<sol::optional<sol::table>>( operation ) ) {
            json.member( operation );
            json.start_object();
            write_static_monster_faction_relations( json, *relations );
            json.end_object();
        }
    }
}

void write_static_int_triplet( JsonOut &json, const sol::table &entry, const char *field )
{
    if( const auto point = entry.get<sol::optional<sol::table>>( field ) ) {
        if( checked_dense_array_size( *point, field, 3 ) != 3 ) {
            throw std::invalid_argument( std::string( field ) + " requires three integers" );
        }
        json.member( field );
        json.start_array();
        for( int i = 1; i <= 3; ++i ) {
            json.write( point->raw_get<int>( i ) );
        }
        json.end_array();
    }
}

void write_static_overmap_tile( JsonOut &json, const sol::table &tile )
{
    json.start_object();
    write_static_int_triplet( json, tile, "point" );
    write_item_fields<std::string>( json, tile, {
        { "terrain", "overmap" }, { "camp", "camp" }, { "camp_name", "camp_name" }
    } );
    write_item_ids( json, tile, { { "locations", "locations" }, { "flags", "flags" } } );
    json.end_object();
}

void write_static_overmap_connection( JsonOut &json, const sol::table &connection )
{
    json.start_object();
    write_static_int_triplet( json, connection, "point" );
    write_static_int_triplet( json, connection, "from" );
    write_item_fields<std::string>( json, connection, {
        { "terrain", "terrain" }, { "connection", "connection" }
    } );
    write_placement_member<bool>( json, connection, "existing", "existing" );
    json.end_object();
}

void write_static_fixed_overmap_layout( JsonOut &json, const sol::table &options )
{
    json.member( "id", options.get<std::string>( "id" ) );
    write_item_ids( json, options, { { "locations", "locations" }, { "flags", "flags" } } );
    write_placement_member<bool>( json, options, "rotate", "rotate" );
    write_mapgen_range( json, "city_sizes", options.raw_get<sol::object>( "city_sizes" ) );
    write_static_catalog_array( json, options, "tiles", "overmaps", write_static_overmap_tile );
    write_static_catalog_array( json, options, "connections", "connections",
                                write_static_overmap_connection );
    if( const auto spawns = options.get<sol::optional<sol::table>>( "spawns" ) ) {
        json.member( "spawns" );
        json.start_object();
        json.member( "group", spawns->get<std::string>( "group" ) );
        write_mapgen_range( json, "population", spawns->raw_get<sol::object>( "population" ) );
        write_mapgen_range( json, "radius", spawns->raw_get<sol::object>( "radius" ) );
        json.end_object();
    }
}

void write_static_fixed_overmap_special( JsonOut &json, const sol::table &options )
{
    write_static_fixed_overmap_layout( json, options );
    write_mapgen_range( json, "occurrences", options.raw_get<sol::object>( "occurrences" ) );
    write_mapgen_range( json, "city_distance", options.raw_get<sol::object>( "city_distance" ) );
    write_placement_member<int>( json, options, "priority", "priority" );
}

void write_static_external_option( JsonOut &json, const sol::table &options )
{
    json.member( "name", options.get<std::string>( "id" ) );
    const std::string kind = options.get<std::string>( "kind" );
    json.member( "stype", kind );
    if( kind == "int" ) {
        json.member( "value", options.get<int>( "value" ) );
    } else if( kind == "float" ) {
        json.member( "value", options.get<double>( "value" ) );
    } else if( kind == "bool" ) {
        json.member( "value", options.get<bool>( "value" ) );
    } else if( kind == "string" || kind == "string_input" ) {
        json.member( "value", options.get<std::string>( "value" ) );
    } else {
        throw std::runtime_error( "Unknown external option kind: " + kind );
    }
}

template<typename Weight>
void write_static_weighted_ids( JsonOut &json, const char *field, const sol::table &entries )
{
    checked_dense_array_size( entries, field, std::numeric_limits<std::size_t>::max() );
    write_mapgen_weighted_choices<Weight, false>( json, field, entries );
}

void write_modifier_operation( JsonOut &json, const char *field, const std::string &operation )
{
    if( operation == "multiply" ) {
        json.member( field, "MULT" );
    } else if( operation == "add" ) {
        json.member( field, "ADD" );
    } else if( operation == "none" ) {
        json.member( field, "" );
    } else {
        throw std::invalid_argument( "modifier operation must be add, multiply or none" );
    }
}

void write_static_character_modifier( JsonOut &json, const sol::table &options )
{
    json.member( "id", options.get<std::string>( "id" ) );
    write_item_text( json, "description", options.raw_get<sol::object>( "description" ), false );
    write_modifier_operation( json, "mod_type", options.get<std::string>( "operation" ) );
    json.member( "value" );
    json.start_object();
    if( const auto builtin = options.get<sol::optional<std::string>>( "builtin" ) ) {
        json.member( "builtin", *builtin );
    } else {
        const sol::object scores = options.raw_get<sol::object>( "scores" );
        if( scores.get_type() == sol::type::string ) {
            json.member( "limb_score", scores.as<std::string>() );
        } else {
            write_static_weighted_ids<double>( json, "limb_score", scores.as<sol::table>() );
        }
        if( const auto combine = options.get<sol::optional<std::string>>( "combine" ) ) {
            write_modifier_operation( json, "limb_score_op", *combine );
        }
        write_placement_member<std::string>( json, options, "limb_type", "limb_type" );
        write_item_fields<bool>( json, options, {
            { "override_encumbrance", "override_encumb" }, { "override_wounds", "override_wounds" }
        } );
        write_item_fields<double>( json, options, {
            { "numerator", "nominator" }, { "denominator", "denominator" }, { "subtract", "subtract" }
        } );
        for( const char *bound : { "min", "max" } ) {
            const sol::object value = options.raw_get<sol::object>( bound );
            if( value.get_type() == sol::type::string ) {
                json.member( bound, value.as<std::string>() );
            } else if( value.get_type() != sol::type::nil ) {
                json.member( bound, value.as<double>() );
            }
        }
    }
    json.end_object();
}

void write_static_ammunition_type( JsonOut &json, const sol::table &options )
{
    json.member( "id", options.get<std::string>( "id" ) );
    write_item_text( json, "name", options.raw_get<sol::object>( "name" ), false );
    json.member( "default", options.get<std::string>( "default_item" ) );
}

void write_static_vehicle_part_location( JsonOut &json, const sol::table &options )
{
    json.member( "id", options.get<std::string>( "id" ) );
    write_item_text( json, "name", options.raw_get<sol::object>( "name" ), false );
    write_item_text( json, "desc", options.raw_get<sol::object>( "description" ), false );
    write_item_fields<int>( json, options, { { "z_order", "z_order" }, { "list_order", "list_order" } } );
}

void write_forest_weights( JsonOut &json, const sol::table &options, const char *field )
{
    if( const auto entries = options.get<sol::optional<sol::table>>( field ) ) {
        write_static_weighted_ids<int>( json, field, *entries );
    }
}

void write_region_identity( JsonOut &json, const sol::table &options )
{
    json.member( "id", options.get<std::string>( "id" ) );
    write_placement_member<std::string>( json, options, "copy_from", "copy-from" );
}

template<typename Value>
void write_region_fields( JsonOut &json, const sol::table &options,
                          std::initializer_list<const char *> fields )
{
    for( const char *field : fields ) {
        write_placement_member<Value>( json, options, field, field );
    }
}

void write_region_set_change( JsonOut &json, const sol::table &options, const char *field,
                              const char *native, const char *operation )
{
    if( options.get<sol::optional<sol::table>>( field ) ) {
        json.member( operation );
        json.start_object();
        write_mapgen_string_array( json, options, field, native );
        json.end_object();
    }
}

void write_static_region_settings_river( JsonOut &json, const sol::table &options )
{
    write_region_identity( json, options );
    write_placement_member<int>( json, options, "river_scale", "river_scale" );
    write_region_fields<double>( json, options, {
        "river_frequency", "river_branch_chance", "river_branch_remerge_chance",
        "river_branch_scale_decrease"
    } );
}

void write_static_region_settings_lake( JsonOut &json, const sol::table &options )
{
    write_region_identity( json, options );
    write_placement_member<double>( json, options, "noise_threshold_lake", "noise_threshold_lake" );
    write_region_fields<int>( json, options, {
        "lake_size_min", "lake_depth"
    } );
    write_mapgen_string_array( json, options, "shore_terrains", "shore_extendable_overmap_terrain" );
    write_static_catalog_array( json, options, "shore_aliases", "shore_extendable_overmap_terrain_aliases",
    []( JsonOut &out, const sol::table &alias ) {
        out.start_object();
        write_item_fields<std::string>( out, alias, {
            { "terrain", "om_terrain" }, { "match", "om_terrain_match_type" }, { "alias", "alias" }
        } );
        out.end_object();
    } );
}

void write_static_region_settings_ocean( JsonOut &json, const sol::table &options )
{
    write_region_identity( json, options );
    write_placement_member<double>( json, options, "noise_threshold_ocean", "noise_threshold_ocean" );
    write_region_fields<int>( json, options, {
        "ocean_size_min", "ocean_depth", "sandy_beach_width"
    } );
    for( const char *field : { "ocean_start_north", "ocean_start_east", "ocean_start_west", "ocean_start_south" } ) {
        const sol::object value = options.raw_get<sol::object>( field );
        if( value.get_type() == sol::type::boolean && !value.as<bool>() ) {
            json.member( field );
            json.write_null();
        } else if( value.get_type() != sol::type::nil ) {
            json.member( field, value.as<int>() );
        }
    }
}

void write_static_region_settings_ravine( JsonOut &json, const sol::table &options )
{
    write_region_identity( json, options );
    write_region_fields<int>( json, options, {
        "num_ravines", "ravine_width", "ravine_range", "ravine_depth"
    } );
    write_placement_member<std::string>( json, options, "bottom_terrain", "ravine_bottom_terrain_id" );
}

void write_static_region_settings_forest( JsonOut &json, const sol::table &options )
{
    write_region_identity( json, options );
    write_region_fields<double>( json, options, {
        "noise_threshold_forest", "noise_threshold_forest_thick",
        "noise_threshold_swamp_adjacent_water", "noise_threshold_swamp_isolated",
        "forest_threshold_limit"
    } );
    write_region_fields<int>( json, options, {
        "river_floodplain_buffer_distance_min", "river_floodplain_buffer_distance_max"
    } );
    if( const auto values = options.get<sol::optional<sol::table>>( "forest_threshold_increase" ) ) {
        if( checked_dense_array_size( *values, "forest_threshold_increase", 4 ) != 4 ) {
            throw std::invalid_argument( "forest_threshold_increase requires four cardinal values" );
        }
        json.member( "forest_threshold_increase", std::array<float, 4>{
            values->get<float>( 1 ), values->get<float>( 2 ), values->get<float>( 3 ), values->get<float>( 4 )
        } );
    }
}

void write_static_region_settings_forest_trail( JsonOut &json, const sol::table &options )
{
    write_region_identity( json, options );
    write_region_fields<int>( json, options, {
        "chance", "border_point_chance", "minimum_forest_size", "random_point_min",
        "random_point_max", "random_point_size_scalar", "trailhead_chance",
        "trailhead_road_distance"
    } );
    if( const auto choices = options.get<sol::optional<sol::table>>( "trailheads" ) ) {
        write_static_weighted_ids<int>( json, "trailheads", *choices );
    }
}

void write_static_region_settings_forest_mapgen( JsonOut &json, const sol::table &options )
{
    write_region_identity( json, options );
    write_mapgen_string_array( json, options, "biomes", "biomes" );
    write_region_set_change( json, options, "add_biomes", "biomes", "extend" );
}

void write_static_region_settings_terrain_furniture( JsonOut &json, const sol::table &options )
{
    write_region_identity( json, options );
    write_mapgen_string_array( json, options, "replacements", "ter_furn" );
}

void write_static_region_terrain_furniture( JsonOut &json, const sol::table &options )
{
    write_region_identity( json, options );
    write_placement_member<std::string>( json, options, "terrain", "ter_id" );
    write_placement_member<std::string>( json, options, "furniture", "furn_id" );
    if( const auto choices = options.get<sol::optional<sol::table>>( "terrain_choices" ) ) {
        write_static_weighted_ids<int>( json, "replace_with_terrain", *choices );
    }
    if( const auto choices = options.get<sol::optional<sol::table>>( "furniture_choices" ) ) {
        write_static_weighted_ids<int>( json, "replace_with_furniture", *choices );
    }
    const auto terrain = options.get<sol::optional<sol::table>>( "add_terrain_choices" );
    const auto furniture = options.get<sol::optional<sol::table>>( "add_furniture_choices" );
    if( terrain || furniture ) {
        json.member( "extend" );
        json.start_object();
        if( terrain ) {
            write_static_weighted_ids<int>( json, "replace_with_terrain", *terrain );
        }
        if( furniture ) {
            write_static_weighted_ids<int>( json, "replace_with_furniture", *furniture );
        }
        json.end_object();
    }
}

void write_static_region_settings_map_extras( JsonOut &json, const sol::table &options )
{
    write_region_identity( json, options );
    write_mapgen_string_array( json, options, "extras", "extras" );
    write_region_set_change( json, options, "add_extras", "extras", "extend" );
    write_region_set_change( json, options, "remove_extras", "extras", "delete" );
}

void write_static_forest_biome_component( JsonOut &json, const sol::table &options )
{
    json.member( "id", options.get<std::string>( "id" ) );
    write_placement_member<std::string>( json, options, "copy_from", "copy-from" );
    write_item_fields<int>( json, options, { { "chance", "chance" }, { "sequence", "sequence" } } );
    write_forest_weights( json, options, "types" );
}

void write_static_forest_biome_mapgen( JsonOut &json, const sol::table &options )
{
    json.member( "id", options.get<std::string>( "id" ) );
    write_item_fields<std::string>( json, options, {
        { "copy_from", "copy-from" }, { "item_group", "item_group" }
    } );
    write_item_fields<int>( json, options, {
        { "sparseness_adjacency_factor", "sparseness_adjacency_factor" },
        { "item_group_chance", "item_group_chance" }, { "item_spawn_iterations", "item_spawn_iterations" }
    } );
    write_mapgen_string_array( json, options, "terrains", "terrains" );
    write_mapgen_string_array( json, options, "components", "components" );
    write_forest_weights( json, options, "groundcover" );
    if( const auto placements = options.get<sol::optional<sol::table>>( "terrain_furniture" ) ) {
        json.member( "terrain_furniture" );
        json.start_object();
        for( const auto &entry : *placements ) {
            json.member( entry.first.as<std::string>() );
            json.start_object();
            const auto placement = entry.second.as<sol::table>();
            write_placement_member<int>( json, placement, "chance", "chance" );
            write_forest_weights( json, placement, "furniture" );
            json.end_object();
        }
        json.end_object();
    }
    if( options.get<sol::optional<sol::table>>( "extend_terrains" ) ) {
        json.member( "extend" );
        json.start_object();
        write_mapgen_string_array( json, options, "extend_terrains", "terrains" );
        json.end_object();
    }
}

void write_static_map_extra( JsonOut &json, const sol::table &options )
{
    json.member( "id", options.get<std::string>( "id" ) );
    write_item_fields<std::string>( json, options, {
        { "copy_from", "copy-from" }, { "color", "color" }, { "symbol", "sym" }, { "visibility", "autonote_visibility" }
    } );
    write_item_text( json, "name", options.raw_get<sol::object>( "name" ), false );
    write_item_text( json, "description", options.raw_get<sol::object>( "description" ), false );
    if( const auto generator = options.get<sol::optional<sol::table>>( "generator" ) ) {
        json.member( "generator" );
        json.start_object();
        json.member( "generator_method", generator->get<std::string>( "method" ) );
        json.member( "generator_id", generator->get<std::string>( "id" ) );
        json.end_object();
    }
    write_mapgen_range( json, "min_max_zlevel", options.raw_get<sol::object>( "z_levels" ) );
    write_item_ids( json, options, { { "flags", "flags" } } );
    if( options.raw_get<sol::object>( "add_flags" ).get_type() != sol::type::nil ) {
        json.member( "extend" );
        json.start_object();
        write_item_ids( json, options, { { "add_flags", "flags" } } );
        json.end_object();
    }
}

void write_static_map_extra_collection( JsonOut &json, const sol::table &options )
{
    json.member( "id", options.get<std::string>( "id" ) );
    write_placement_member<std::string>( json, options, "copy_from", "copy-from" );
    write_placement_member<int>( json, options, "chance", "chance" );
    const auto write_entry = []( JsonOut & out, const sol::table & entry ) {
        out.start_array();
        out.write( entry.get<std::string>( "extra" ) );
        out.write( entry.get<int>( "weight" ) );
        out.end_array();
    };
    write_static_catalog_array( json, options, "extras", "extras", write_entry );
    if( options.raw_get<sol::object>( "add_extras" ).get_type() != sol::type::nil ) {
        json.member( "extend" );
        json.start_object();
        write_static_catalog_array( json, options, "add_extras", "extras", write_entry );
        json.end_object();
    }
}

void write_static_trait_migration( JsonOut &json, const sol::table &options )
{
    json.member( "id", options.get<std::string>( "id" ) );
    write_item_fields<std::string>( json, options, {
        { "trait", "trait" }, { "variant", "variant" }, { "proficiency", "proficiency" }
    } );
    write_placement_member<bool>( json, options, "remove", "remove" );
}

void write_static_camp_migration( JsonOut &json, const sol::table &options )
{
    json.member( "camp_migrations" );
    json.start_object();
    write_static_native_text( json, options, "name", "name" );
    json.member( "overmap_terrain", options.get<std::string>( "terrain" ) );
    json.member( "faction", options.get<std::string>( "faction" ) );
    json.end_object();
}

void write_static_mod_migration( JsonOut &json, const sol::table &options )
{
    json.member( "id", options.get<std::string>( "id" ) );
    write_placement_member<std::string>( json, options, "replace_with", "new_id" );
    write_item_text( json, "removal_reason", options.raw_get<sol::object>( "removal_reason" ), false );
}

void write_static_climate_station( JsonOut &json, const sol::table &options )
{
    json.member( "id", options.get<std::string>( "id" ) );
    json.member( "name", options.get<std::string>( "name" ) );
    json.member( "source_station", options.get<std::string>( "source_station" ) );
    json.member( "latitude", options.get<double>( "latitude" ) );
    json.member( "longitude", options.get<double>( "longitude" ) );
    write_static_catalog_array( json, options, "months", "months",
    []( JsonOut & out, const sol::table & month ) {
        if( checked_dense_array_size( month, "climate monthly normal", 5 ) != 5 ) {
            throw std::runtime_error( "A climate monthly normal requires five entries" );
        }
        out.start_array();
        for( int i = 1; i <= 4; ++i ) {
            out.write( month.get<double>( i ) );
        }
        out.write( month.get<std::string>( 5 ) );
        out.end_array();
    } );
}

void write_static_ascii_art( JsonOut &json, const sol::table &options )
{
    json.member( "id", options.get<std::string>( "id" ) );
    write_item_ids( json, options, { { "lines", "picture" } } );
}

void write_static_vehicle_group( JsonOut &json, const sol::table &options )
{
    json.member( "id", options.get<std::string>( "id" ) );
    write_static_catalog_array( json, options, "vehicles", "vehicles",
    []( JsonOut & out, const sol::table & entry ) {
        out.start_array();
        out.write( entry.get<std::string>( "id" ) );
        out.write( entry.get<int>( "weight" ) );
        out.end_array();
    } );
}

void write_static_mutation_type( JsonOut &json, const sol::table &options )
{
    json.member( "id", options.get<std::string>( "id" ) );
}

void write_static_string_or_ids( JsonOut &json, const sol::table &options, const char *field,
                                 const char *native )
{
    if( const sol::object value = options.raw_get<sol::object>( field );
        value.get_type() == sol::type::string ) {
        json.member( native, value.as<std::string>() );
    } else {
        write_item_ids( json, options, { { field, native } } );
    }
}

void install_static_widget_conditions( sol::state &lua, sol::table &content )
{
    sol::table predicates = lua.create_table();
    const auto compare = []( const std::string & name, const std::string & op, double threshold,
    const sol::optional<std::string> &arg ) {
        using comparison = bool ( * )( double, double );
        static const std::map<std::string, comparison> comparisons = {
            { "==", []( double a, double b )
                {
                    return a == b;
                }
            },
            { "!=", []( double a, double b )
                {
                    return a != b;
                }
            },
            { ">", []( double a, double b )
                {
                    return a > b;
                }
            },
            { ">=", []( double a, double b )
                {
                    return a >= b;
                }
            },
            { "<", []( double a, double b )
                {
                    return a < b;
                }
            },
            { "<=", []( double a, double b )
                {
                    return a <= b;
                }
            },
        };
        const auto it = comparisons.find( op );
        if( it == comparisons.end() ) {
            throw std::invalid_argument( "unknown widget comparison '" + op + "'" );
        }
        const auto read = widget::make_reading( name,
                                                arg ? std::optional<std::string>( *arg ) : std::nullopt );
        return static_dialogue_predicate{ [read, test = it->second, threshold]( const const_dialogue & d )
        {
            try {
                return test( read( d ), threshold );
            } catch( const math::exception &error ) {
                debugmsg( "Cannot read sidebar widget value: %s", error.what() );
                return false;
            }
        } };
    };
    predicates.set_function( "compare", compare );
    predicates.set_function( "test", [compare]( const std::string & name,
    sol::optional<std::string> arg ) {
        return compare( name, "!=", 0, arg );
    } );
    content["widget_conditions"] = std::move( predicates );
}

void write_static_widget_clause( JsonOut &json, const sol::table &options )
{
    json.start_object();
    write_item_fields<std::string>( json, options, {
        { "id", "id" }, { "symbol", "sym" }, { "color", "color" }
    } );
    write_item_text( json, "text", options.raw_get<sol::object>( "text" ), false );
    write_placement_member<int>( json, options, "value", "value" );
    write_placement_member<bool>( json, options, "parse_tags", "parse_tags" );
    const sol::object when = options.raw_get<sol::object>( "when" );
    if( when.is<static_dialogue_predicate>() ) {
        json.member( "//ccb_lua_widget_when", widget_clause::stage_condition(
                         when.as<const static_dialogue_predicate &>().test ) );
    } else if( when.get_type() == sol::type::string ) {
        const std::string handler = when.as<std::string>();
        if( handler.empty() ) {
            throw std::invalid_argument( "widget condition handler must have a name" );
        }
        json.member( "//ccb_lua_widget_when", handler );
    } else if( when.get_type() != sol::type::nil ) {
        throw std::invalid_argument( "widget clause requires a predicate or named callback" );
    }
    write_static_string_or_ids( json, options, "widgets", "widgets" );
    json.end_object();
}

void write_static_widget( JsonOut &json, const sol::table &options )
{
    json.member( "id", options.get<std::string>( "id" ) );
    write_item_fields<std::string>( json, options, {
        { "copy_from", "copy-from" }, { "style", "style" }, { "arrange", "arrange" },
        { "symbols", "symbols" }, { "fill", "fill" }, { "body_graph", "body_graph" },
        { "direction", "direction" }, { "text_align", "text_align" },
        { "label_align", "label_align" }, { "separator", "separator" },
        { "variable", "var" }, { "bodypart", "bodypart" }
    } );
    write_item_fields<int>( json, options, {
        { "width", "width" }, { "height", "height" }, { "padding", "padding" }
    } );
    write_placement_member<bool>( json, options, "pad_labels", "pad_labels" );
    write_item_ids( json, options, {
        { "flags", "flags" }, { "colors", "colors" }, { "bodyparts", "bodyparts" }
    } );
    write_static_string_or_ids( json, options, "widgets", "widgets" );
    if( const auto breaks = options.get<sol::optional<sol::table>>( "breaks" ) ) {
        json.member( "breaks" );
        write_static_values<int>( json, *breaks, "breaks", []( JsonOut & out, int value ) {
            out.write( value );
        } );
    }
    write_item_text( json, "label", options.raw_get<sol::object>( "label" ), false );
    write_item_text( json, "string", options.raw_get<sol::object>( "text" ), false );
    const sol::object description = options.raw_get<sol::object>( "description" );
    if( description.is<detail::localized_text>() ) {
        // Native widget descriptions are untranslated source strings.
        json.member( "description", description.as<const detail::localized_text &>().singular );
    } else {
        write_placement_member<std::string>( json, options, "description", "description" );
    }
    if( const auto handler = options.get<sol::optional<std::string>>( "custom_handler" ) ) {
        if( handler->empty() ) {
            throw std::invalid_argument( "widget custom handler must have a name" );
        }
        const auto variable = options.get<sol::optional<std::string>>( "variable" );
        if( variable && *variable != "custom" ) {
            throw std::invalid_argument( "widget custom_handler requires a custom variable" );
        }
        if( !variable ) {
            json.member( "var", "custom" );
        }
        json.member( "//ccb_lua_widget_custom", *handler );
    }
    write_static_catalog_array( json, options, "clauses", "clauses", write_static_widget_clause );
    if( const auto fallback = options.get<sol::optional<sol::table>>( "default_clause" ) ) {
        json.member( "default_clause" );
        write_static_widget_clause( json, *fallback );
    }
    for( const char *operation : {
             "extend", "delete"
         } ) {
        if( const auto edit = options.get<sol::optional<sol::table>>( operation ) ) {
            json.member( operation );
            json.start_object();
            write_static_string_or_ids( json, *edit, "widgets", "widgets" );
            json.end_object();
        }
    }
}

void write_static_harvest_range( JsonOut &json, const sol::table &entry, const char *field,
                                 const char *native )
{
    if( const auto range = entry.get<sol::optional<sol::table>>( field ) ) {
        if( checked_dense_array_size( *range, field, 2 ) != 2 ) {
            throw std::invalid_argument( std::string( field ) + " requires two quantities" );
        }
        json.member( native );
        json.start_array();
        json.write( range->raw_get<double>( 1 ) );
        json.write( range->raw_get<double>( 2 ) );
        json.end_array();
    }
}

void write_static_harvest_drop( JsonOut &json, const sol::table &entry )
{
    json.start_object();
    json.member( "drop", entry.get<std::string>( "output" ) );
    write_placement_member<std::string>( json, entry, "category", "type" );
    write_placement_member<double>( json, entry, "mass_ratio", "mass_ratio" );
    write_placement_member<int>( json, entry, "maximum", "max" );
    write_static_harvest_range( json, entry, "base_quantity", "base_num" );
    write_static_harvest_range( json, entry, "skill_quantity", "scale_num" );
    write_item_ids( json, entry, { { "flags", "flags" }, { "faults", "faults" } } );
    json.end_object();
}

void write_static_harvest( JsonOut &json, const sol::table &options )
{
    json.member( "id", options.get<std::string>( "id" ) );
    write_item_fields<std::string>( json, options, {
        { "copy_from", "copy-from" }, { "leftovers", "leftovers" },
        { "butchery_requirements", "butchery_requirements" }
    } );
    write_item_text( json, "message", options.raw_get<sol::object>( "message" ), false );
    write_static_catalog_array( json, options, "drops", "entries", write_static_harvest_drop );
    for( const char *operation : {
             "extend", "delete"
         } ) {
        if( const auto edit = options.get<sol::optional<sol::table>>( operation ) ) {
            json.member( operation );
            json.start_object();
            write_static_catalog_array( json, *edit, "drops", "entries", write_static_harvest_drop );
            json.end_object();
        }
    }
}

void write_static_construction_requirement( JsonOut &json, const sol::table &entry )
{
    const std::size_t size = checked_dense_array_size( entry, "construction requirement",
        std::numeric_limits<std::size_t>::max() );
    if( size < 2 ) {
        throw std::invalid_argument( "construction requirement needs an id and quantity" );
    }
    json.start_array();
    json.write( entry.raw_get<std::string>( 1 ) );
    json.write( entry.raw_get<int>( 2 ) );
    for( std::size_t i = 3; i <= size; ++i ) {
        json.write( entry.raw_get<std::string>( i ) );
    }
    json.end_array();
}

void write_static_construction_quality( JsonOut &json, const sol::table &options )
{
    json.start_object();
    json.member( "id", options.get<std::string>( "id" ) );
    write_item_fields<int>( json, options, { { "level", "level" }, { "amount", "amount" } } );
    json.end_object();
}

void write_static_construction_byproduct( JsonOut &json, const sol::table &options )
{
    json.start_object();
    write_item_fields<std::string>( json, options, { { "item", "item" }, { "group", "group" } } );
    for( const char *field : {
             "count", "charges"
         } ) {
        write_mapgen_range( json, field, options.raw_get<sol::object>( field ) );
    }
    json.end_object();
}

void write_static_requirement_groups( JsonOut &json, const sol::table &options )
{
    for( const char *field : {
             "components", "tools", "qualities"
         } ) {
        const auto groups = options.get<sol::optional<sol::table>>( field );
        if( !groups ) {
            continue;
        }
        const bool quality = std::string_view( field ) == "qualities";
        json.member( field );
        write_static_values<sol::table>( json, *groups, field,
        [quality, field]( JsonOut & out, const sol::table & group ) {
            if( quality && group.raw_get<sol::object>( "id" ).get_type() == sol::type::string ) {
                write_static_construction_quality( out, group );
                return;
            }
            write_static_values<sol::object>( out, group, field,
            [quality]( JsonOut & dest, const sol::object & choice ) {
                if( quality ) {
                    write_static_construction_quality( dest, choice.as<sol::table>() );
                } else if( choice.get_type() == sol::type::string ) {
                    dest.write( choice.as<std::string>() );
                } else {
                    write_static_construction_requirement( dest, choice.as<sol::table>() );
                }
            } );
        } );
    }
}

void write_static_fault_modifier( JsonOut &json, const sol::table &entry )
{
    json.start_object();
    json.member( "damage_id", entry.get<std::string>( "damage_type" ) );
    write_placement_member<int>( json, entry, "add", "add" );
    write_placement_member<double>( json, entry, "multiply", "multiply" );
    json.end_object();
}

void write_static_fault( JsonOut &json, const sol::table &options )
{
    json.member( "id", options.get<std::string>( "id" ) );
    write_item_fields<std::string>( json, options, {
        { "copy_from", "copy-from" }, { "fault_type", "fault_type" }, { "severity", "severity" },
        { "color", "color" }
    } );
    for( const char *field : { "name", "description", "message", "item_prefix", "item_suffix" } ) {
        write_item_text( json, field, options.raw_get<sol::object>( field ), false );
    }
    write_item_ids( json, options, { { "flags", "flags" }, { "blocks", "block_faults" } } );
    write_item_fields<int>( json, options, {
        { "degradation_mod", "degradation_mod" }, { "instant_damage", "instant_damage" },
        { "encumbrance_add", "encumbrance_add" }, { "vehicle_move_penalty_mod", "vehicle_move_penalty_mod" }
    } );
    write_item_fields<double>( json, options, {
        { "price_modifier", "price_modifier" }, { "encumbrance_mult", "encumbrance_mult" },
        { "contact_area_mod", "contact_area_mod" }, { "rolling_resistance_mod", "rolling_resistance_mod" }
    } );
    write_placement_member<bool>( json, options, "affected_by_degradation", "affected_by_degradation" );
    write_static_catalog_array( json, options, "melee_damage", "melee_damage_mod",
                                write_static_fault_modifier );
    write_static_catalog_array( json, options, "armor", "armor_mod", write_static_fault_modifier );
}

void write_static_fault_fix_requirement( JsonOut &json, const sol::table &entry )
{
    if( const auto ref = entry.get<sol::optional<std::string>>( "id" ) ) {
        json.start_array();
        json.write( *ref );
        json.write( entry.get<int>( "count" ) );
        json.end_array();
    } else {
        json.start_object();
        write_static_requirement_groups( json, entry );
        json.end_object();
    }
}

void write_static_fault_fix( JsonOut &json, const sol::table &options )
{
    json.member( "id", options.get<std::string>( "id" ) );
    write_item_fields<std::string>( json, options, {
        { "copy_from", "copy-from" }, { "duration", "time" }
    } );
    write_item_text( json, "name", options.raw_get<sol::object>( "name" ), false );
    write_item_text( json, "success_msg", options.raw_get<sol::object>( "success_message" ), false );
    write_item_ids( json, options, { { "removes", "faults_removed" }, { "adds", "faults_added" } } );
    write_item_fields<int>( json, options, {
        { "mod_damage", "mod_damage" }, { "mod_degradation", "mod_degradation" }
    } );
    if( const auto skills = options.get<sol::optional<sol::table>>( "skills" ) ) {
        write_item_keyed_values<int>( json, "skills", *skills );
    }
    for( const auto &[field, native] : { item_field{ "proficiency_time_factors", "time_save_profs" },
                                        { "flag_time_factors", "time_save_flags" },
                                        { "multiply_variables", "adjust_variables_multiply" } } ) {
        if( const auto values = options.get<sol::optional<sol::table>>( field ) ) {
            write_item_keyed_values<double>( json, native, *values );
        }
    }
    if( const auto variables = options.get<sol::optional<sol::table>>( "set_variables" ) ) {
        json.member( "set_variables" );
        json.start_object();
        for( const auto &[key, value] : *variables ) {
            const std::string name = key.as<std::string>();
            switch( value.get_type() ) {
                case sol::type::boolean:
                    json.member( name, value.as<bool>() );
                    break;
                case sol::type::number:
                    json.member( name, value.as<double>() );
                    break;
                case sol::type::string:
                    json.member( name, value.as<std::string>() );
                    break;
                default:
                    throw std::invalid_argument( "fault fix variable must be a string, number or boolean" );
            }
        }
        json.end_object();
    }
    write_static_catalog_array( json, options, "requirements", "requirements",
                                write_static_fault_fix_requirement );
}

void write_static_construction( JsonOut &json, const sol::table &options )
{
    json.member( "id", options.get<std::string>( "id" ) );
    json.member( "group", options.get<std::string>( "group" ) );
    write_item_fields<std::string>( json, options, {
        { "duration", "time" }, { "category", "category" }, { "skill", "skill" },
        { "post_terrain", "post_terrain" }, { "activity_level", "activity_level" },
        { "turn_action", "do_turn_special" }, { "explain_failure", "explain_failure" }
    } );
    write_placement_member<int>( json, options, "difficulty", "difficulty" );
    write_item_fields<bool>( json, options, {
        { "on_display", "on_display" }, { "dark_craftable", "dark_craftable" },
        { "vehicle_start", "vehicle_start" }, { "strict", "strict" }
    } );
    write_item_ids( json, options, { { "post_flags", "post_flags" } } );
    write_static_string_or_ids( json, options, "pre_terrain", "pre_terrain" );
    write_static_string_or_ids( json, options, "pre_checks", "pre_special" );
    write_static_string_or_ids( json, options, "completion_actions", "post_special" );
    write_item_text( json, "pre_note", options.raw_get<sol::object>( "pre_note" ), false );

    if( const sol::object flags = options.raw_get<sol::object>( "pre_flags" );
        flags.get_type() == sol::type::table && flags.as<sol::table>().raw_get<sol::object>(
            "flag" ).get_type() == sol::type::string ) {
        const sol::table flag = flags.as<sol::table>();
        json.member( "pre_flags" );
        json.start_object();
        json.member( "flag", flag.get<std::string>( "flag" ) );
        write_placement_member<bool>( json, flag, "force_terrain", "force_terrain" );
        json.end_object();
    } else {
        write_static_string_or_ids( json, options, "pre_flags", "pre_flags" );
    }

    const sol::object using_requirements = options.raw_get<sol::object>( "using_requirements" );
    if( using_requirements.get_type() == sol::type::string ) {
        json.member( "using", using_requirements.as<std::string>() );
    } else {
        write_static_catalog_array( json, options, "using_requirements", "using",
                                    write_static_construction_requirement );
    }
    write_static_catalog_array( json, options, "required_skills", "required_skills",
                                write_static_construction_requirement );

    if( const sol::object byproducts = options.raw_get<sol::object>( "byproducts" );
        byproducts.get_type() == sol::type::string ) {
        json.member( "byproducts", byproducts.as<std::string>() );
    } else {
        write_static_catalog_array( json, options, "byproducts", "byproducts",
                                    write_static_construction_byproduct );
    }

    write_static_requirement_groups( json, options );
}

template<typename Writer>
void write_static_tile_object( JsonOut &json, const sol::table &options, const char *field,
                               const char *native, Writer write_fields )
{
    if( const auto value = options.get<sol::optional<sol::table>>( field ) ) {
        json.member( native );
        write_fields( json, *value );
    }
}

void write_static_tile_unit( JsonOut &json, const sol::table &options, const char *field,
                             const char *native )
{
    if( const sol::object value = options.raw_get<sol::object>( field );
        value.get_type() == sol::type::number ) {
        json.member( native, value.as<int>() );
    } else {
        write_placement_member<std::string>( json, options, field, native );
    }
}

void write_static_tile_field( JsonOut &json, const sol::table &options, const char *field,
                              const char *native )
{
    if( const auto value = options.get<sol::optional<sol::table>>( field ) ) {
        if( checked_dense_array_size( *value, field, 2 ) != 2 ) {
            throw std::invalid_argument( std::string( field ) + " requires a field ID and intensity" );
        }
        json.member( native );
        json.start_array();
        json.write( value->raw_get<std::string>( 1 ) );
        json.write( value->raw_get<int>( 2 ) );
        json.end_array();
    }
}

void write_static_tile_temperatures( JsonOut &json, const sol::table &options, const char *field,
                                     const char *native )
{
    if( const auto values = options.get<sol::optional<sol::table>>( field ) ) {
        json.member( native );
        write_static_values<sol::object>( json, *values, field,
        []( JsonOut & out, const sol::object & value ) {
            if( value.get_type() == sol::type::string ) {
                out.write( value.as<std::string>() );
            } else {
                out.write( value.as<double>() );
            }
        } );
    }
}

void write_static_tile_drop( JsonOut &json, const sol::table &options )
{
    json.start_object();
    write_item_fields<std::string>( json, options, {
        { "item", "item" }, { "group", "group" }, { "contents_group", "contents-group" },
        { "variant", "variant" }
    } );
    write_placement_member<int>( json, options, "chance", "prob" );
    write_mapgen_range( json, "count", options.raw_get<sol::object>( "count" ) );
    write_mapgen_range( json, "charges", options.raw_get<sol::object>( "charges" ) );
    write_mapgen_range( json, "damage", options.raw_get<sol::object>( "damage" ) );
    write_static_catalog_array( json, options, "distribution", "distribution", write_static_tile_drop );
    write_static_catalog_array( json, options, "collection", "collection", write_static_tile_drop );
    json.end_object();
}

void write_static_tile_drops( JsonOut &json, const sol::table &options, const char *field,
                              const char *native )
{
    if( const sol::object value = options.raw_get<sol::object>( field );
        value.get_type() == sol::type::string ) {
        json.member( native, value.as<std::string>() );
    } else {
        write_static_catalog_array( json, options, field, native, write_static_tile_drop );
    }
}

void write_static_bash_fields( JsonOut &json, const sol::table &options )
{
    write_item_fields<std::string>( json, options, {
        { "profile", "profile" }, { "terrain", "ter_set" },
        { "terrain_from_above", "ter_set_bashed_from_above" }, { "furniture", "furn_set" }
    } );
    write_item_fields<int>( json, options, {
        { "minimum_strength", "str_min" }, { "maximum_strength", "str_max" },
        { "minimum_strength_blocked", "str_min_blocked" },
        { "maximum_strength_blocked", "str_max_blocked" },
        { "minimum_strength_supported", "str_min_supported" },
        { "maximum_strength_supported", "str_max_supported" }, { "explosive", "explosive" },
        { "volume", "sound_vol" }, { "failure_volume", "sound_fail_vol" },
        { "collapse_radius", "collapse_radius" }
    } );
    write_item_fields<bool>( json, options, {
        { "destroy_only", "destroy_only" }, { "bash_below", "bash_below" }
    } );
    write_item_ids( json, options, {
        { "tent_centers", "tent_centers" }
    } );
    write_item_text( json, "sound", options.raw_get<sol::object>( "sound" ), false );
    write_item_text( json, "sound_fail", options.raw_get<sol::object>( "failure_sound" ), false );
    write_static_tile_field( json, options, "hit_field", "hit_field" );
    write_static_tile_field( json, options, "destroyed_field", "destroyed_field" );
    write_static_tile_drops( json, options, "drops", "items" );
}

void write_static_tile_bash( JsonOut &json, const sol::table &options )
{
    json.start_object();
    write_static_bash_fields( json, options );
    json.end_object();
}

void write_static_field_immunity( JsonOut &json, const sol::table &options )
{
    json.start_object();
    write_item_ids( json, options, { { "flags", "flags" } } );
    write_static_catalog_array( json, options, "resistances", "body_part_env_resistance",
    []( JsonOut & out, const sol::table & entry ) {
        out.start_array();
        out.write( entry.get<std::string>( "part" ) );
        out.write( entry.get<int>( "minimum" ) );
        out.end_array();
    } );
    for( const auto &[field, native] : { item_field{ "worn_flags", "immunity_flags_worn" },
                                        { "any_worn_flags", "immunity_flags_worn_any" } } ) {
        write_static_catalog_array( json, options, field, native,
        []( JsonOut & out, const sol::table & entry ) {
            out.start_array();
            out.write( entry.get<std::string>( "part" ) );
            out.write( entry.get<std::string>( "flag" ) );
            out.end_array();
        } );
    }
    json.end_object();
}

void write_static_field_effect( JsonOut &json, const sol::table &options )
{
    json.start_object();
    write_item_fields<std::string>( json, options, {
        { "effect", "effect_id" }, { "body_part", "body_part" }, { "message_type", "message_type" }
    } );
    write_item_fields<int>( json, options, {
        { "intensity", "intensity" }, { "chance_in_vehicle", "chance_in_vehicle" },
        { "chance_inside_vehicle", "chance_inside_vehicle" },
        { "chance_outside_vehicle", "chance_outside_vehicle" }
    } );
    write_item_fields<bool>( json, options, {
        { "environmental", "is_environmental" }, { "immune_in_vehicle", "immune_in_vehicle" },
        { "immune_inside_vehicle", "immune_inside_vehicle" },
        { "immune_outside_vehicle", "immune_outside_vehicle" }
    } );
    write_static_tile_unit( json, options, "min_duration", "min_duration" );
    write_static_tile_unit( json, options, "max_duration", "max_duration" );
    write_item_text( json, "message", options.raw_get<sol::object>( "message" ), false );
    write_item_text( json, "message_npc", options.raw_get<sol::object>( "npc_message" ), false );
    write_static_tile_object( json, options, "immunity", "immunity_data", write_static_field_immunity );
    json.end_object();
}

void write_static_field_level( JsonOut &json, const sol::table &options )
{
    json.start_object();
    write_item_fields<std::string>( json, options, {
        { "symbol", "sym" }, { "color", "color" }, { "monster_spawn_group", "monster_spawn_group" }
    } );
    write_item_fields<int>( json, options, {
        { "move_cost", "move_cost" }, { "extra_radiation_min", "extra_radiation_min" },
        { "extra_radiation_max", "extra_radiation_max" },
        { "radiation_hurt_damage_min", "radiation_hurt_damage_min" },
        { "radiation_hurt_damage_max", "radiation_hurt_damage_max" },
        { "intensity_upgrade_chance", "intensity_upgrade_chance" },
        { "monster_spawn_chance", "monster_spawn_chance" },
        { "monster_spawn_count", "monster_spawn_count" },
        { "monster_spawn_radius", "monster_spawn_radius" }, { "concentration", "concentration" },
        { "convection_temperature_mod", "convection_temperature_mod" },
        { "scent_neutralization", "scent_neutralization" }
    } );
    write_item_fields<double>( json, options, {
        { "light_emitted", "light_emitted" }, { "light_override", "light_override" },
        { "translucency", "translucency" }
    } );
    write_item_fields<bool>( json, options, {
        { "transparent", "transparent" }, { "dangerous", "dangerous" }
    } );
    write_static_tile_unit( json, options, "intensity_upgrade_duration", "intensity_upgrade_duration" );
    write_item_text( json, "name", options.raw_get<sol::object>( "name" ), false );
    write_item_text( json, "radiation_hurt_message", options.raw_get<sol::object>( "radiation_hurt_message" ), false );
    write_static_int_triplet( json, options, "light_color" );
    write_static_catalog_array( json, options, "effects", "effects", write_static_field_effect );
    json.end_object();
}

void write_static_field_complaint( JsonOut &json, const sol::table &options )
{
    json.start_object();
    write_item_fields<std::string>( json, options, {
        { "issue", "issue" }
    } );
    write_item_fields<int>( json, options, {
        { "chance", "chance" }
    } );
    write_static_tile_unit( json, options, "duration", "duration" );
    write_item_text( json, "speech", options.raw_get<sol::object>( "speech" ), false );
    json.end_object();
}

void write_static_field_fire_reaction( JsonOut &json, const sol::table &options )
{
    json.start_object();
    write_item_fields<int>( json, options, {
        { "degrade_at", "degrade_at" }, { "clear_at", "clear_at" }
    } );
    write_static_tile_unit( json, options, "interval", "interval" );
    json.end_object();
}

void write_static_field_bash( JsonOut &json, const sol::table &options )
{
    json.start_object();
    write_static_bash_fields( json, options );
    write_item_text( json, "msg_success", options.raw_get<sol::object>( "success_message" ), false );
    json.end_object();
}

void write_static_field_type( JsonOut &json, const sol::table &options )
{
    json.member( "id", options.get<std::string>( "id" ) );
    write_item_fields<std::string>( json, options, {
        { "copy_from", "copy-from" }, { "looks_like", "looks_like" }, { "phase", "phase" },
        { "description_affix", "description_affix" }, { "wandering_field", "wandering_field" }
    } );
    write_item_fields<int>( json, options, {
        { "legacy_enum_id", "legacy_enum_id" }, { "decay_amount_factor", "decay_amount_factor" },
        { "percent_spread", "percent_spread" }, { "apply_slime_factor", "apply_slime_factor" },
        { "priority", "priority" }
    } );
    write_item_fields<bool>( json, options, {
        { "splattering", "is_splattering" }, { "dirty_transparency_cache", "dirty_transparency_cache" },
        { "has_fire", "has_fire" }, { "has_acid", "has_acid" }, { "has_elec", "has_elec" },
        { "has_fume", "has_fume" }, { "moppable", "moppable" },
        { "linear_half_life", "linear_half_life" }, { "indestructible", "indestructible" },
        { "accelerated_decay", "accelerated_decay" }, { "display_items", "display_items" },
        { "display_field", "display_field" }, { "legacy_make_rubble", "legacy_make_rubble" },
        { "mopsafe", "mopsafe" }, { "decrease_intensity_on_contact", "decrease_intensity_on_contact" }
    } );
    write_static_tile_unit( json, options, "half_life", "half_life" );
    write_static_tile_unit( json, options, "underwater_age_speedup", "underwater_age_speedup" );
    write_static_tile_unit( json, options, "outdoor_age_speedup", "outdoor_age_speedup" );
    write_static_tile_unit( json, options, "gas_absorption_factor", "gas_absorption_factor" );
    write_item_ids( json, options, {
        { "immune_monsters", "immune_mtypes" }, { "blocked_monsters", "block_mtypes" }
    } );
    write_static_catalog_array( json, options, "levels", "intensity_levels", write_static_field_level );
    write_static_tile_object( json, options, "immunity", "immunity_data", write_static_field_immunity );
    write_static_tile_object( json, options, "complaint", "npc_complain", write_static_field_complaint );
    write_static_tile_object( json, options, "fire_reaction", "fire_reaction", write_static_field_fire_reaction );
    write_static_tile_object( json, options, "bash", "bash", write_static_field_bash );
}

void write_static_tile_practice( JsonOut &json, const sol::table &options )
{
    json.start_object();
    write_placement_member<std::string>( json, options, "id", "skill" );
    write_item_fields<int>( json, options, {
        { "minimum", "min" }, { "maximum", "max" }
    } );
    write_placement_member<double>( json, options, "multiplier", "multiplier" );
    json.end_object();
}

void write_static_tile_deconstruct( JsonOut &json, const sol::table &options )
{
    json.start_object();
    write_item_fields<std::string>( json, options, {
        { "terrain", "ter_set" }, { "furniture", "furn_set" }
    } );
    write_placement_member<bool>( json, options, "deconstruct_above", "deconstruct_above" );
    write_static_tile_drops( json, options, "drops", "items" );
    write_static_tile_object( json, options, "practice", "skill", write_static_tile_practice );
    json.end_object();
}

void write_static_tile_shoot( JsonOut &json, const sol::table &options )
{
    json.start_object();
    write_placement_member<int>( json, options, "chance_to_hit", "chance_to_hit" );
    write_placement_member<bool>( json, options, "no_laser_destroy", "no_laser_destroy" );
    write_mapgen_range( json, "reduce_damage", options.raw_get<sol::object>( "reduce_damage" ) );
    write_mapgen_range( json, "reduce_damage_laser",
                        options.raw_get<sol::object>( "reduce_damage_laser" ) );
    write_mapgen_range( json, "destroy_damage", options.raw_get<sol::object>( "destroy_damage" ) );
    json.end_object();
}

void write_static_tile_liquid( JsonOut &json, const sol::table &options )
{
    json.start_object();
    write_item_fields<std::string>( json, options, {
        { "item", "id" }, { "dries_to", "dries_to" }
    } );
    write_placement_member<double>( json, options, "minimum_temperature", "min_temp" );
    write_mapgen_range( json, "count", options.raw_get<sol::object>( "count" ) );
    json.end_object();
}

void write_static_tile_seasonal_harvest( JsonOut &json, const sol::table &options )
{
    json.start_object();
    write_placement_member<std::string>( json, options, "harvest", "id" );
    write_static_string_or_ids( json, options, "seasons", "seasons" );
    json.end_object();
}

void write_static_tile_pry( JsonOut &json, const sol::table &options )
{
    json.start_object();
    write_item_fields<int>( json, options, {
        { "difficulty", "difficulty" }, { "prying_level", "prying_level" }
    } );
    write_item_fields<bool>( json, options, {
        { "prying_nails", "prying_nails" }, { "noisy", "noisy" }, { "alarm", "alarm" },
        { "breakable", "breakable" }
    } );
    write_item_text( json, "failure", options.raw_get<sol::object>( "failure" ), false );
    json.end_object();
}

void write_static_tile_tool_drop( JsonOut &json, const sol::table &options )
{
    json.start_object();
    write_placement_member<std::string>( json, options, "item", "item" );
    write_mapgen_range( json, "count", options.raw_get<sol::object>( "count" ) );
    json.end_object();
}

void write_static_tile_tool_action( JsonOut &json, const sol::table &options )
{
    json.start_object();
    write_item_fields<std::string>( json, options, {
        { "duration", "duration" }, { "result", "result" }
    } );
    write_item_text( json, "message", options.raw_get<sol::object>( "message" ), false );
    write_item_text( json, "sound", options.raw_get<sol::object>( "sound" ), false );
    write_static_catalog_array( json, options, "byproducts", "byproducts",
                                write_static_tile_tool_drop );
    write_static_tile_object( json, options, "prying", "prying_data", write_static_tile_pry );
    json.end_object();
}

void write_static_tile_plant( JsonOut &json, const sol::table &options )
{
    json.start_object();
    write_item_fields<std::string>( json, options, {
        { "transform", "transform" }, { "base", "base" }
    } );
    write_placement_member<int>( json, options, "max_water_storage", "max_water_storage" );
    write_item_fields<double>( json, options, {
        { "growth_multiplier", "growth_multiplier" },
        { "harvest_multiplier", "harvest_multiplier" },
        { "water_consumption_multiplier", "water_consumption_multiplier" }
    } );
    json.end_object();
}

void write_static_tile_workbench( JsonOut &json, const sol::table &options )
{
    json.start_object();
    write_placement_member<double>( json, options, "multiplier", "multiplier" );
    write_static_tile_unit( json, options, "mass", "mass" );
    write_static_tile_unit( json, options, "volume", "volume" );
    json.end_object();
}

void write_static_tile_growth( JsonOut &json, const sol::table &options )
{
    json.start_object();
    write_item_fields<std::string>( json, options, {
        { "transform", "transform" }, { "growth_time", "growth_time" }
    } );
    write_placement_member<double>( json, options, "growth_multiplier", "growth_multiplier" );
    write_static_string_or_ids( json, options, "fertilize_seasons", "fertilize_seasons" );
    json.end_object();
}

void write_static_tile_crop_climate( JsonOut &json, const sol::table &options )
{
    json.start_object();
    write_placement_member<int>( json, options, "growing_days", "growing_days" );
    write_item_fields<double>( json, options, {
        { "base_c", "base_c" }, { "optimum_c", "optimum_c" }, { "min_c", "min_c" },
        { "max_c", "max_c" }, { "degree_days", "degree_days" }, { "water_mm", "water_mm" },
        { "water_peak", "water_peak" }
    } );
    json.end_object();
}

void write_static_tile_fruit_climate( JsonOut &json, const sol::table &options )
{
    json.start_object();
    write_placement_member<std::string>( json, options, "harvest", "harvest" );
    write_placement_member<int>( json, options, "bearing_days", "bearing_days" );
    write_static_tile_object( json, options, "growth", "growth", write_static_tile_crop_climate );
    json.end_object();
}

void write_static_tile_extends( JsonOut &json, const sol::table &options )
{
    json.start_object();
    write_item_ids( json, options, {
        { "flags", "flags" }
    } );
    write_static_string_or_ids( json, options, "connect_groups", "connect_groups" );
    write_static_string_or_ids( json, options, "connects_to", "connects_to" );
    write_static_string_or_ids( json, options, "rotates_to", "rotates_to" );
    json.end_object();
}

void write_static_tile_appliance( JsonOut &json, const sol::table &options )
{
    json.start_object();
    json.member( "type", "appliance_convert" );
    write_item_fields<std::string>( json, options, {
        { "item", "item" }, { "furniture", "furn_set" }, { "terrain", "ter_set" }
    } );
    json.end_object();
}

void write_static_tile_card_reader( JsonOut &json, const sol::table &options )
{
    json.start_object();
    json.member( "type", "cardreader" );
    write_placement_member<std::string>( json, options, "mapgen_id", "mapgen_id" );
    write_item_fields<int>( json, options, {
        { "radius", "radius" }, { "omt_allowed_radius", "omt_allowed_radius" }
    } );
    write_item_fields<bool>( json, options, {
        { "consume_card", "consume_card" }, { "allow_hacking", "allow_hacking" },
        { "despawn_monsters", "despawn_monsters" }, { "query", "query" }
    } );
    write_item_ids( json, options, {
        { "flags", "flags" }
    } );
    write_static_native_text( json, options, "query_message", "query_msg" );
    write_static_native_text( json, options, "success_message", "success_msg" );
    write_static_native_text( json, options, "redundant_message", "redundant_msg" );
    if( const auto value = options.get<sol::optional<sol::table>>( "terrain_changes" ) ) {
        write_item_keyed_values<std::string>( json, "terrain_changes", *value );
    }
    if( const auto value = options.get<sol::optional<sol::table>>( "furniture_changes" ) ) {
        write_item_keyed_values<std::string>( json, "furn_changes", *value );
    }
    json.end_object();
}

void write_static_tile_examine( JsonOut &json, const sol::table &options )
{
    const sol::object builtin = options.raw_get<sol::object>( "builtin_examine" );
    const auto appliance = options.get<sol::optional<sol::table>>( "appliance_conversion" );
    const auto card_reader = options.get<sol::optional<sol::table>>( "card_reader" );
    const auto handler = options.get<sol::optional<std::string>>( "examine_handler" );
    const int kinds = ( builtin.get_type() != sol::type::nil ) + appliance.has_value() +
                      card_reader.has_value() + handler.has_value();
    if( kinds > 1 ) {
        throw std::invalid_argument( "tile examine requires one interaction kind" );
    }
    if( handler ) {
        if( handler->empty() || handler->find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument( "tile examine requires a registered handler name" );
        }
        json.member( "//ccb_lua_examine_handler", *handler );
    } else if( appliance ) {
        json.member( "examine_action" );
        write_static_tile_appliance( json, *appliance );
    } else if( card_reader ) {
        json.member( "examine_action" );
        write_static_tile_card_reader( json, *card_reader );
    } else {
        write_static_string_or_ids( json, options, "builtin_examine", "examine_action" );
    }
}

void write_static_tile_shared( JsonOut &json, const sol::table &options )
{
    write_item_fields<std::string>( json, options, {
        { "id", "id" }, { "abstract", "abstract" }, { "copy_from", "copy-from" },
        { "looks_like", "looks_like" }, { "curtain_transform", "curtain_transform" },
        { "base_item", "item" }, { "lockpick_result", "lockpick_result" }, { "open", "open" },
        { "close", "close" }
    } );
    write_item_fields<int>( json, options, {
        { "coverage", "coverage" }, { "comfort", "comfort" },
        { "floor_bedding_warmth", "floor_bedding_warmth" }, { "light_emitted", "light_emitted" }
    } );
    write_item_ids( json, options, {
        { "flags", "flags" }, { "emissions", "emissions" }
    } );
    write_static_tile_unit( json, options, "max_volume", "max_volume" );
    write_static_string_or_ids( json, options, "symbol", "symbol" );
    write_static_string_or_ids( json, options, "color", "color" );
    write_static_string_or_ids( json, options, "background_color", "bgcolor" );
    write_static_string_or_ids( json, options, "connect_groups", "connect_groups" );
    write_static_string_or_ids( json, options, "connects_to", "connects_to" );
    write_static_string_or_ids( json, options, "rotates_to", "rotates_to" );
    write_item_text( json, "name", options.raw_get<sol::object>( "name" ), false );
    write_item_text( json, "description", options.raw_get<sol::object>( "description" ), false );
    write_item_text( json, "lockpick_message", options.raw_get<sol::object>( "lockpick_message" ),
                     false );
    write_static_int_triplet( json, options, "light_color" );
    write_static_tile_object( json, options, "bash", "bash", write_static_tile_bash );
    write_static_tile_object( json, options, "deconstruct", "deconstruct",
                              write_static_tile_deconstruct );
    write_static_tile_object( json, options, "shoot", "shoot", write_static_tile_shoot );
    write_static_tile_object( json, options, "liquid_source", "liquid_source",
                              write_static_tile_liquid );
    write_static_catalog_array( json, options, "harvest_by_season", "harvest_by_season",
                                write_static_tile_seasonal_harvest );
    write_static_tile_object( json, options, "plant", "plant_data", write_static_tile_plant );
    write_static_tile_object( json, options, "boltcut", "boltcut", write_static_tile_tool_action );
    write_static_tile_object( json, options, "hacksaw", "hacksaw", write_static_tile_tool_action );
    write_static_tile_object( json, options, "oxytorch", "oxytorch", write_static_tile_tool_action );
    write_static_tile_object( json, options, "prying", "prying", write_static_tile_tool_action );
    write_static_tile_object( json, options, "extend", "extend", write_static_tile_extends );
    write_static_tile_object( json, options, "delete", "delete", write_static_tile_extends );
    write_static_tile_examine( json, options );
}

void write_static_tile_terrain( JsonOut &json, const sol::table &options )
{
    write_static_tile_shared( json, options );
    write_item_fields<std::string>( json, options, {
        { "transforms_into", "transforms_into" }, { "roof", "roof" }, { "trap", "trap" },
        { "phase_method", "phase_method" }
    } );
    write_item_fields<int>( json, options, {
        { "move_cost", "move_cost" }, { "heat_radiation", "heat_radiation" }
    } );
    write_item_ids( json, options, {
        { "phase_targets", "phase_targets" }, { "allowed_template_ids", "allowed_template_ids" }
    } );
    write_static_tile_temperatures( json, options, "phase_temperatures", "phase_temps" );
    write_static_tile_object( json, options, "growth", "terrain_growth", write_static_tile_growth );
    write_static_tile_object( json, options, "fruit_climate", "fruit_climate",
                              write_static_tile_fruit_climate );
}

void write_static_tile_furniture( JsonOut &json, const sol::table &options )
{
    write_static_tile_shared( json, options );
    write_item_fields<std::string>( json, options, {
        { "crafting_pseudo_item", "crafting_pseudo_item" }, { "deployed_item", "deployed_item" }
    } );
    write_item_fields<int>( json, options, {
        { "move_cost_mod", "move_cost_mod" }, { "required_strength", "required_str" },
        { "fall_damage_reduction", "fall_damage_reduction" },
        { "bonus_fire_warmth_feet", "bonus_fire_warmth_feet" }
    } );
    write_placement_member<double>( json, options, "surgery_skill_multiplier",
                                    "surgery_skill_multiplier" );
    write_static_tile_unit( json, options, "mass", "mass" );
    write_static_tile_unit( json, options, "keg_capacity", "keg_capacity" );
    write_static_tile_object( json, options, "workbench", "workbench", write_static_tile_workbench );
}

void write_static_trap_vehicle( JsonOut &json, const sol::table &options )
{
    json.start_object();
    write_item_fields<bool>( json, options, {
        { "explosion", "do_explosion" }, { "falling", "is_falling" }, { "remove_trap", "remove_trap" }
    } );
    write_item_fields<int>( json, options, {
        { "chance", "chance" }, { "damage", "damage" }, { "shrapnel", "shrapnel" },
        { "sound_volume", "sound_volume" }
    } );
    write_item_fields<std::string>( json, options, {
        { "sound_type", "sound_type" }, { "sound_variant", "sound_variant" }, { "set_trap", "set_trap" }
    } );
    write_item_text( json, "sound", options.raw_get<sol::object>( "sound" ), false );
    if( const auto items = options.get<sol::optional<sol::table>>( "spawn_items" ) ) {
        json.member( "spawn_items" );
        write_static_values<sol::object>( json, *items, "spawn_items",
        []( JsonOut & out, const sol::object & value ) {
            if( value.get_type() == sol::type::string ) {
                out.write( value.as<std::string>() );
                return;
            }
            const sol::table item = value.as<sol::table>();
            out.start_object();
            out.member( "id", item.get<std::string>( "id" ) );
            write_placement_member<double>( out, item, "chance", "chance" );
            out.end_object();
        } );
    }
    json.end_object();
}

void write_static_trap( JsonOut &json, const sol::table &options )
{
    write_item_fields<std::string>( json, options, {
        { "id", "id" }, { "copy_from", "copy-from" }, { "color", "color" },
        { "symbol", "symbol" }, { "action", "action" }, { "map_regen", "map_regen" }
    } );
    write_item_fields<int>( json, options, {
        { "visibility", "visibility" }, { "avoidance", "avoidance" },
        { "difficulty", "difficulty" }, { "trap_radius", "trap_radius" }
    } );
    write_item_fields<int>( json, options, {
        { "comfort", "comfort" }, { "floor_bedding_warmth", "floor_bedding_warmth" },
        { "funnel_radius_mm", "funnel_radius" }
    } );
    write_static_tile_unit( json, options, "trigger_weight", "trigger_weight" );
    for( const auto &[field, native] : {
             item_field{ "memorial_male", "memorial_male" }, { "memorial_female", "memorial_female" },
             { "avatar_message", "trigger_message_u" }, { "npc_message", "trigger_message_npc" }
         } ) {
        write_item_text( json, native, options.raw_get<sol::object>( field ), false );
    }
    if( const auto drops = options.get<sol::optional<sol::table>>( "drops" ) ) {
        json.member( "drops" );
        write_static_values<sol::object>( json, *drops, "trap drops",
        []( JsonOut & out, const sol::object & value ) {
            if( value.get_type() == sol::type::string ) {
                out.write( value.as<std::string>() );
                return;
            }
            const sol::table drop = value.as<sol::table>();
            out.start_object();
            out.member( "item", drop.get<std::string>( "item" ) );
            write_item_fields<int>( out, drop, { { "quantity", "quantity" }, { "charges", "charges" } } );
            out.end_object();
        } );
    }
    write_static_tile_object( json, options, "vehicle", "vehicle_data", write_static_trap_vehicle );
    write_item_fields<bool>( json, options, {
        { "always_invisible", "always_invisible" }, { "benign", "benign" }
    } );
    write_item_ids( json, options, { { "flags", "flags" } } );
    if( const auto flags = options.get<sol::optional<sol::table>>( "extend_flags" ) ) {
        json.member( "extend" );
        json.start_object();
        json.member( "flags", bounded_string_array( *flags, "extend_flags",
                std::numeric_limits<std::size_t>::max(), "trap" ) );
        json.end_object();
    }
    write_item_text( json, "name", options.raw_get<sol::object>( "name" ), false );
    if( const auto handler = options.get<sol::optional<std::string>>( "trigger_handler" ) ) {
        if( handler->empty() || handler->find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument( "trap requires a registered trigger handler name" );
        }
        json.member( "//ccb_lua_trap_handler", *handler );
    }
}

void write_static_named_definition( JsonOut &json, const sol::table &options )
{
    json.member( "id", options.get<std::string>( "id" ) );
    write_item_text( json, "name", options.raw_get<sol::object>( "name" ), false );
}

void write_static_proficiency_category( JsonOut &json, const sol::table &options )
{
    write_static_named_definition( json, options );
    write_item_text( json, "description", options.raw_get<sol::object>( "description" ), false );
}

void write_static_proficiency_bonus( JsonOut &json, const sol::table &bonus )
{
    json.start_object();
    json.member( "type", bonus.get<std::string>( "attribute" ) );
    json.member( "value", bonus.get<double>( "value" ) );
    json.end_object();
}

void write_static_proficiency( JsonOut &json, const sol::table &options )
{
    write_static_proficiency_category( json, options );
    write_item_fields<std::string>( json, options, {
        { "category", "category" }, { "time_to_learn", "time_to_learn" }
    } );
    write_item_fields<bool>( json, options, {
        { "can_learn", "can_learn" }, { "ignore_focus", "ignore_focus" }, { "teachable", "teachable" }
    } );
    write_item_fields<double>( json, options, {
        { "time_multiplier", "default_time_multiplier" }, { "skill_penalty", "default_skill_penalty" },
        { "weakpoint_bonus", "default_weakpoint_bonus" },
        { "weakpoint_penalty", "default_weakpoint_penalty" }
    } );
    write_item_ids( json, options, { { "requires", "required_proficiencies" } } );
    if( const auto bonuses = options.get<sol::optional<sol::table>>( "bonuses" ) ) {
        json.member( "bonuses" );
        json.start_object();
        for( const auto &[category, values] : *bonuses ) {
            const std::string name = category.as<std::string>();
            json.member( name );
            write_static_values<sol::table>( json, values.as<sol::table>(), name.c_str(),
                                             write_static_proficiency_bonus );
        }
        json.end_object();
    }
}

void write_static_start_location_target( JsonOut &json, const sol::object &target )
{
    if( target.get_type() == sol::type::string ) {
        json.write( target.as<std::string>() );
        return;
    }
    const sol::table options = target.as<sol::table>();
    json.start_object();
    json.member( "om_terrain", options.get<std::string>( "overmap_terrain" ) );
    if( const auto match = options.get<sol::optional<std::string>>( "match" ) ) {
        json.member( "om_terrain_match_type", to_upper_case( *match ) );
    }
    if( const auto parameters = options.get<sol::optional<sol::table>>( "parameters" ) ) {
        json.member( "parameters" );
        json.start_object();
        for( const auto &[name, value] : *parameters ) {
            json.member( name.as<std::string>(), value.as<std::string>() );
        }
        json.end_object();
    }
    json.end_object();
}

void write_static_start_location( JsonOut &json, const sol::table &options )
{
    write_static_named_definition( json, options );
    write_placement_member<std::string>( json, options, "copy_from", "copy-from" );
    if( const auto targets = options.get<sol::optional<sol::table>>( "targets" ) ) {
        json.member( "terrain" );
        write_static_values<sol::object>( json, *targets, "targets", write_static_start_location_target );
    }
    for( const auto &[field, native] : {
             std::pair{ "city_size", "city_sizes" }, std::pair{ "city_distance", "city_distance" },
             std::pair{ "z_levels", "allowed_z_levels" }
         } ) {
        write_mapgen_range( json, native, options.raw_get<sol::object>( field ) );
    }
    write_item_ids( json, options, { { "flags", "flags" } } );
    if( const auto flags = options.get<sol::optional<sol::table>>( "extend_flags" ) ) {
        json.member( "extend" );
        json.start_object();
        json.member( "flags", bounded_string_array( *flags, "extend_flags",
                     std::numeric_limits<std::size_t>::max(), "start location" ) );
        json.end_object();
    }
}

void write_static_profession_text( JsonOut &json, const sol::table &options, const char *field )
{
    const sol::object text = options.raw_get<sol::object>( field );
    if( text.get_type() == sol::type::nil ) {
        return;
    }
    if( text.get_type() == sol::type::string ) {
        json.member( field, text.as<std::string>() );
        return;
    }
    const sol::table gendered = text.as<sol::table>();
    json.member( field );
    json.start_object();
    for( const char *gender : { "male", "female" } ) {
        json.member( gender, gendered.get<std::string>( gender ) );
    }
    json.end_object();
}

void write_static_spawn_entry( JsonOut &json, const sol::object &value )
{
    if( value.get_type() == sol::type::string ) {
        json.write( value.as<std::string>() );
        return;
    }
    const sol::table entry = value.as<sol::table>();
    json.start_object();
    write_item_fields<std::string>( json, entry, {
        { "item", "item" }, { "group", "group" }, { "variant", "variant" },
        { "ammo_item", "ammo-item" }, { "container_item", "container-item" },
        { "entry_wrapper", "entry-wrapper" }
    } );
    write_placement_member<int>( json, entry, "probability", "prob" );
    write_item_ids( json, entry, { { "custom_flags", "custom-flags" } } );
    write_static_string_or_ids( json, entry, "contents_items", "contents-item" );
    write_static_string_or_ids( json, entry, "contents_groups", "contents-group" );
    for( const char *field : { "count", "charges", "damage" } ) {
        write_mapgen_range( json, field, entry.raw_get<sol::object>( field ) );
    }
    json.end_object();
}

void write_static_profession_legacy_item( JsonOut &json, const sol::object &value )
{
    if( value.get_type() == sol::type::string ) {
        json.write( value.as<std::string>() );
        return;
    }
    const sol::table entry = value.as<sol::table>();
    json.start_array();
    json.write( entry.get<std::string>( "item" ) );
    json.write( entry.get<std::string>( "snippet" ) );
    json.end_array();
}

void write_static_profession_loadout( JsonOut &json, const sol::table &loadout )
{
    if( const auto legacy = loadout.get<sol::optional<sol::table>>( "legacy" ) ) {
        write_static_values<sol::object>( json, *legacy, "legacy", write_static_profession_legacy_item );
        return;
    }
    json.start_object();
    write_item_fields<int>( json, loadout, { { "ammo_chance", "ammo" }, { "magazine_chance", "magazine" } } );
    for( const char *field : { "entries", "items" } ) {
        if( const auto entries = loadout.get<sol::optional<sol::table>>( field ) ) {
            json.member( field );
            write_static_values<sol::object>( json, *entries, field, write_static_spawn_entry );
        }
    }
    json.end_object();
}

void write_static_profession_skill( JsonOut &json, const sol::table &skill )
{
    json.start_object();
    json.member( "name", skill.get<std::string>( "id" ) );
    json.member( "level", skill.get<int>( "level" ) );
    json.end_object();
}

void write_static_mission_phase( JsonOut &json, const sol::table &options, const char *field,
                                 const char *native, const std::string &source )
{
    const sol::object phase = options.raw_get<sol::object>( field );
    if( phase.get_type() == sol::type::nil ) {
        return;
    }
    if( phase.get_type() == sol::type::string ) {
        json.member( native, phase.as<std::string>() );
        return;
    }
    const sol::table rules = phase.as<sol::table>();
    json.member( native );
    json.start_object();
    detail::mission_phase_handlers handlers;
    auto actions = read_static_dialogue_actions( rules, source, &handlers );
    if( !actions ) {
        write_static_dialogue_native_actions( json, rules, "mission phase" );
    }
    if( const auto rewards = rules.get<sol::optional<sol::table>>( "item_rewards" ) ) {
        if( !actions ) {
            actions.emplace();
        }
        const std::size_t count = checked_dense_array_size( *rewards, "mission item rewards",
                                  std::numeric_limits<std::size_t>::max() );
        for( std::size_t i = 1; i <= count; ++i ) {
            actions->set_effect( read_static_mission_reward( rewards->raw_get<sol::table>( i ) ) );
        }
    }
    if( actions ) {
        json.member( "//ccb_lua_mission_actions", detail::stage_mission_actions( std::move( *actions ),
                     std::move( handlers ) ) );
    }
    write_static_string_or_ids( json, rules, "before_rewards", "//ccb_lua_mission_before_rewards" );
    write_static_string_or_ids( json, rules, "handler", "//ccb_lua_mission_handler" );
    write_static_string_or_ids( json, rules, "reveal_terrain", "reveal_om_ter" );
    if( const auto target = rules.get<sol::optional<sol::table>>( "target" ) ) {
        if( rules.raw_get<sol::object>( "reveal_terrain" ).get_type() != sol::type::nil ) {
            throw std::invalid_argument( "mission phase cannot both reveal terrain and assign a target" );
        }
        json.member( "assign_mission_target" );
        json.start_object();
        write_item_fields<std::string>( json, *target, {
            { "terrain", "om_terrain" }, { "match", "om_terrain_match_type" },
            { "special", "om_special" }, { "replace_terrain", "om_terrain_replace" }
        } );
        write_item_fields<int>( json, *target, {
            { "reveal_radius", "reveal_radius" }, { "min_distance", "min_distance" },
            { "search_range", "search_range" }, { "z", "z" }
        } );
        write_item_fields<bool>( json, *target, {
            { "random", "random" }, { "must_see", "must_see" }, { "cant_see", "cant_see" }
        } );
        if( const auto position = target->get<sol::optional<std::string>>( "global_position" ) ) {
            json.member( "var" );
            json.start_object();
            json.member( "global_val", *position );
            json.end_object();
        }
        json.end_object();
    }
    write_static_catalog_array( json, rules, "map_updates", "update_mapgen",
    []( JsonOut & out, const sol::table & update ) {
        const auto layout = update.get<sol::optional<sol::table>>( "layout" );
        const auto id = update.get<sol::optional<std::string>>( "id" );
        if( layout.has_value() == id.has_value() ) {
            throw std::invalid_argument( "mission map update requires exactly one of layout or id" );
        }
        out.start_object();
        write_placement_member<std::string>( out, update, "terrain", "om_terrain" );
        if( layout ) {
            write_static_mapgen_layout_fields( out, *layout, std::numeric_limits<std::size_t>::max() );
        } else {
            out.member( "mapgen_update_id", *id );
        }
        out.end_object();
    } );
    json.end_object();
}

void write_static_mission( JsonOut &json, const sol::table &options, const std::string &source )
{
    write_item_fields<std::string>( json, options, {
        { "id", "id" }, { "abstract", "abstract" }, { "copy_from", "copy-from" }, { "goal", "goal" },
        { "item", "item" }, { "item_group", "item_group" }, { "required_container", "required_container" },
        { "empty_container", "empty_container" }, { "monster_type", "monster_type" },
        { "monster_species", "monster_species" }, { "destination", "destination" },
        { "followup", "followup" }, { "place", "place" }, { "complete_when", "//ccb_lua_mission_goal" }
    } );
    write_item_text( json, "name", options.raw_get<sol::object>( "name" ), false );
    write_item_text( json, "description", options.raw_get<sol::object>( "description" ), false );
    write_item_fields<int>( json, options, {
        { "difficulty", "difficulty" }, { "value", "value" }, { "item_count", "count" },
        { "monster_kill_goal", "monster_kill_goal" }
    } );
    write_item_fields<bool>( json, options, {
        { "urgent", "urgent" }, { "generic_rewards", "has_generic_rewards" },
        { "invisible_on_complete", "invisible_on_complete" }, { "remove_container", "remove_container" }
    } );
    write_item_ids( json, options, { { "origins", "origins" } } );
    if( const auto lines = options.get<sol::optional<sol::table>>( "dialogue" ) ) {
        json.member( "dialogue" );
        json.start_object();
        for( const char *line : { "describe", "offer", "accepted", "rejected", "advice", "inquire",
                                  "success", "success_lie", "failure" } ) {
            write_item_text( json, line, lines->raw_get<sol::object>( line ), false );
        }
        json.end_object();
    }
    write_static_string_or_ids( json, options, "deadline", "deadline" );
    write_static_mission_phase( json, options, "start", "start", source );
    write_static_mission_phase( json, options, "finish", "end", source );
    write_static_mission_phase( json, options, "failure", "fail", source );
}

void write_static_scenario_lists( JsonOut &json, const sol::table &options )
{
    write_item_ids( json, options, {
        { "professions", "professions" }, { "hobbies", "hobbies" }, { "traits", "traits" },
        { "forced_traits", "forced_traits" }, { "forbidden_traits", "forbidden_traits" },
        { "locations", "allowed_locs" }, { "flags", "flags" }, { "missions", "missions" }
    } );
}

void write_static_scenario( JsonOut &json, const sol::table &options )
{
    write_item_fields<std::string>( json, options, {
        { "id", "id" }, { "abstract", "abstract" }, { "copy_from", "copy-from" },
        { "name", "name" }, { "description", "description" }, { "start_name", "start_name" },
        { "map_extra", "map_extra" }, { "vehicle", "vehicle" }, { "requirement", "requirement" }
    } );
    write_item_fields<bool>( json, options, {
        { "blacklist_professions", "blacklist_professions" }, { "add_professions", "add_professions" },
        { "whitelist_hobbies", "whitelist_hobbies" }, { "hard_requirement", "hard_requirement" },
        { "reveal_locale", "reveal_locale" }
    } );
    write_item_fields<int>( json, options, {
        { "points", "points" }, { "initial_visibility", "distance_initial_visibility" }
    } );
    write_static_scenario_lists( json, options );
    for( const char *operation : { "extend", "delete" } ) {
        if( const auto lists = options.get<sol::optional<sol::table>>( operation ) ) {
            json.member( operation );
            json.start_object();
            write_static_scenario_lists( json, *lists );
            json.end_object();
        }
    }
    for( const char *field : { "start_of_cataclysm", "start_of_game" } ) {
        if( const auto date = options.get<sol::optional<sol::table>>( field ) ) {
            json.member( field );
            json.start_object();
            write_item_fields<int>( json, *date, { { "hour", "hour" }, { "day", "day" }, { "year", "year" } } );
            write_placement_member<std::string>( json, *date, "season", "season" );
            json.end_object();
        }
    }
    if( const auto offset = options.get<sol::optional<sol::table>>( "origin_offset" ) ) {
        json.member( "origin_offset" );
        json.start_array();
        json.write( offset->get<int>( "x" ) );
        json.write( offset->get<int>( "y" ) );
        json.end_array();
    }
    write_static_catalog_array( json, options, "surround_groups", "surround_groups",
    []( JsonOut & out, const sol::table & group ) {
        out.start_array();
        out.write( group.get<std::string>( "group" ) );
        out.write( group.get<double>( "expected_points" ) );
        out.end_array();
    } );
}

void write_static_profession( JsonOut &json, const sol::table &options )
{
    json.member( "id", options.get<std::string>( "id" ) );
    write_static_profession_text( json, options, "name" );
    write_static_profession_text( json, options, "description" );
    write_item_fields<std::string>( json, options, {
        { "copy_from", "copy-from" }, { "subtype", "subtype" },
        { "npc_background", "npc_background" }, { "vehicle", "vehicle" }, { "no_bonus", "no_bonus" }
    } );
    write_item_fields<int>( json, options, {
        { "points", "points" }, { "age_lower", "age_lower" }, { "age_upper", "age_upper" },
        { "starting_cash", "starting_cash" }, { "martial_art_choice_count", "starting_styles_choices_amount" }
    } );
    write_item_fields<bool>( json, options, {
        { "allow_npc", "chargen_allow_npc" }, { "hobbies_whitelist", "whitelist_hobbies" },
        { "hard_requirement", "hard_requirement" }
    } );
    write_item_ids( json, options, {
        { "flags", "flags" }, { "bionics", "CBMs" }, { "proficiencies", "proficiencies" },
        { "recipes", "recipes" }, { "traits", "traits" }, { "forbidden_traits", "forbidden_traits" },
        { "hobbies", "hobbies" }, { "martial_arts", "starting_styles" },
        { "martial_art_choices", "starting_styles_choices" }, { "missions", "missions" }
    } );
    write_static_string_or_ids( json, options, "requirements", "requirement" );
    write_static_catalog_array( json, options, "skills", "skills", write_static_profession_skill );
    write_static_catalog_array( json, options, "addictions", "addictions",
    []( JsonOut & out, const sol::table & addiction ) {
        out.start_object();
        out.member( "type", addiction.get<std::string>( "id" ) );
        out.member( "intensity", addiction.get<int>( "intensity" ) );
        out.end_object();
    } );
    write_static_catalog_array( json, options, "pets", "pets",
    []( JsonOut & out, const sol::table & pet ) {
        out.start_object();
        out.member( "name", pet.get<std::string>( "monster" ) );
        out.member( "amount", pet.get<int>( "count" ) );
        out.end_object();
    } );
    write_static_catalog_array( json, options, "spells", "spells",
    []( JsonOut & out, const sol::table & spell ) {
        out.start_object();
        out.member( "id", spell.get<std::string>( "id" ) );
        out.member( "level", spell.get<int>( "level" ) );
        out.end_object();
    } );
    if( const auto items = options.get<sol::optional<sol::table>>( "items" ) ) {
        json.member( "items" );
        json.start_object();
        for( const char *gender : { "both", "male", "female" } ) {
            if( const auto loadout = items->get<sol::optional<sol::table>>( gender ) ) {
                json.member( gender );
                write_static_profession_loadout( json, *loadout );
            }
        }
        json.end_object();
    }
    if( const auto skills = options.get<sol::optional<sol::table>>( "extend_skills" ) ) {
        json.member( "extend" );
        json.start_object();
        json.member( "skills" );
        write_static_values<sol::table>( json, *skills, "extend_skills", write_static_profession_skill );
        json.end_object();
    }
}

void write_static_vehicle_part_variant( JsonOut &json, const sol::table &variant )
{
    json.start_object();
    write_item_fields<std::string>( json, variant, {
        { "id", "id" }, { "label", "label" },
        { "symbols", "symbols" }, { "broken_symbols", "symbols_broken" }
    } );
    json.end_object();
}

void write_static_vehicle_part_requirement( JsonOut &json, const sol::table &options )
{
    json.start_object();
    write_placement_member<std::string>( json, options, "duration", "time" );
    const sol::object using_requirements = options.raw_get<sol::object>( "using_requirements" );
    if( using_requirements.get_type() == sol::type::string ) {
        json.member( "using", using_requirements.as<std::string>() );
    } else {
        write_static_catalog_array( json, options, "using_requirements", "using",
                                    write_static_construction_requirement );
    }
    write_static_catalog_array( json, options, "skills", "skills", write_static_construction_requirement );
    write_static_catalog_array( json, options, "qualities", "qualities", write_static_construction_quality );
    write_static_catalog_array( json, options, "components", "components",
    []( JsonOut & out, const sol::table & alternatives ) {
        write_static_values<sol::table>( out, alternatives, "component choices",
                                         write_static_construction_requirement );
    } );
    json.end_object();
}

void write_static_vehicle_part_requirements( JsonOut &json, const sol::table &options )
{
    json.start_object();
    for( const char *operation : { "install", "removal", "repair" } ) {
        write_static_tile_object( json, options, operation, operation, write_static_vehicle_part_requirement );
    }
    json.end_object();
}

void write_static_vehicle_part_controls( JsonOut &json, const sol::table &options )
{
    json.start_object();
    for( const char *kind : { "air", "land" } ) {
        write_static_tile_object( json, options, kind, kind, []( JsonOut & out, const sol::table & controls ) {
            out.start_object();
            write_item_ids( out, controls, { { "proficiencies", "proficiencies" } } );
            write_static_catalog_array( out, controls, "skills", "skills",
                                         write_static_construction_requirement );
            out.end_object();
        } );
    }
    json.end_object();
}

void write_static_vehicle_part( JsonOut &json, const sol::table &options )
{
    write_item_fields<std::string>( json, options, {
        { "id", "id" }, { "abstract", "abstract" }, { "copy_from", "copy-from" },
        { "item", "item" }, { "location", "location" }, { "remove_as", "remove_as" },
        { "color", "color" }, { "broken_color", "broken_color" },
        { "looks_like", "looks_like" }, { "fuel_type", "fuel_type" }, { "default_ammo", "default_ammo" },
        { "default_tint_color", "default_tint_color" }, { "size", "size" },
        { "folded_volume", "folded_volume" }, { "cargo_passable_size", "cargo_passable_size" },
        { "folding_time", "folding_time" }, { "unfolding_time", "unfolding_time" },
        { "energy_consumption", "energy_consumption" }, { "power", "power" }, { "epower", "epower" }
    } );
    write_item_text( json, "name", options.raw_get<sol::object>( "name" ), false );
    write_item_text( json, "description", options.raw_get<sol::object>( "description" ), false );
    write_item_fields<int>( json, options, {
        { "durability", "durability" }, { "damage_modifier", "damage_modifier" },
        { "bonus", "bonus" }, { "comfort", "comfort" }, { "backfire_frequency", "backfire_freq" },
        { "noise_factor", "noise_factor" }, { "m2c", "m2c" }, { "muscle_power_factor", "muscle_power_factor" },
        { "contact_area", "contact_area" }, { "propeller_diameter", "propeller_diameter" },
        { "rotor_diameter", "rotor_diameter" }, { "ladder_length", "length" }
    } );
    write_item_fields<double>( json, options, {
        { "balloon_height", "height" }, { "backfire_threshold", "backfire_threshold" },
        { "damaged_power_factor", "damaged_power_factor" }, { "rolling_resistance", "rolling_resistance" },
        { "wheel_offroad_rating", "wheel_offroad_rating" }
    } );
    write_static_tile_unit( json, options, "floor_bedding_warmth", "floor_bedding_warmth" );
    write_static_int_triplet( json, options, "light_color" );
    write_item_ids( json, options, {
        { "categories", "categories" }, { "flags", "flags" }, { "emissions", "emissions" },
        { "exhaust", "exhaust" }, { "engine_exclusions", "exclusions" }, { "fuel_options", "fuel_options" },
        { "folding_tools", "folding_tools" }, { "unfolding_tools", "unfolding_tools" },
        { "allowed_tools", "allowed_tools" }
    } );
    for( const char *field : { "extend", "delete" } ) {
        write_static_tile_object( json, options, field, field, []( JsonOut & out, const sol::table & edit ) {
            out.start_object();
            write_item_ids( out, edit, {
                { "flags", "flags" }, { "categories", "categories" }, { "allowed_tools", "allowed_tools" }
            } );
            out.end_object();
        } );
    }
    write_static_tile_object( json, options, "proportional", "proportional",
    []( JsonOut & out, const sol::table & scale ) {
        out.start_object();
        write_item_fields<double>( out, scale, {
            { "durability", "durability" }, { "damage_modifier", "damage_modifier" },
            { "size", "size" }, { "epower", "epower" }
        } );
        out.end_object();
    } );
    write_static_catalog_array( json, options, "variants", "variants", write_static_vehicle_part_variant );
    write_static_catalog_array( json, options, "variant_bases", "variants_bases",
                                write_static_vehicle_part_variant );
    write_static_catalog_array( json, options, "qualities", "qualities", write_static_construction_requirement );
    write_static_catalog_array( json, options, "pseudo_tools", "pseudo_tools",
    []( JsonOut & out, const sol::table & tool ) {
        out.start_object();
        out.member( "id", tool.get<std::string>( "id" ) );
        write_placement_member<std::string>( out, tool, "hotkey", "hotkey" );
        out.end_object();
    } );
    write_static_tile_object( json, options, "requirements", "requirements",
                              write_static_vehicle_part_requirements );
    write_static_tile_object( json, options, "control", "control_requirements",
                              write_static_vehicle_part_controls );
    write_static_tile_object( json, options, "workbench", "workbench", write_static_tile_workbench );
    write_static_tile_object( json, options, "transform_terrain", "transform_terrain",
    []( JsonOut & out, const sol::table & transform ) {
        out.start_object();
        write_item_ids( out, transform, { { "pre_flags", "pre_flags" } } );
        write_item_fields<std::string>( out, transform, {
            { "post_terrain", "post_terrain" }, { "post_furniture", "post_furniture" }
        } );
        out.end_object();
    } );
    write_static_tile_object( json, options, "damage_reduction", "damage_reduction",
    []( JsonOut & out, const sol::table & damage ) {
        out.start_object();
        for( const auto &[type, amount] : damage ) {
            out.member( type.as<std::string>(), amount.as<double>() );
        }
        out.end_object();
    } );
    write_static_tile_object( json, options, "wheel_terrain_modifiers", "wheel_terrain_modifiers",
    []( JsonOut & out, const sol::table & modifiers ) {
        const std::size_t size = checked_dense_array_size( modifiers, "wheel_terrain_modifiers",
                                 std::numeric_limits<std::size_t>::max() );
        out.start_object();
        for( std::size_t i = 1; i <= size; ++i ) {
            const sol::table modifier = modifiers.raw_get<sol::table>( i );
            out.member( modifier.get<std::string>( "flag" ),
                        std::array<int, 2>{ modifier.get<int>( "move_override" ), modifier.get<int>( "move_penalty" ) } );
        }
        out.end_object();
    } );
    const sol::object drops = options.raw_get<sol::object>( "breaks_into" );
    if( drops.get_type() == sol::type::string ) {
        json.member( "breaks_into", drops.as<std::string>() );
    } else if( drops.get_type() == sol::type::table ) {
        json.member( "breaks_into" );
        write_static_values<sol::object>( json, drops.as<sol::table>(), "breaks_into", write_static_spawn_entry );
    }
}

void write_static_vehicle_part_placement( JsonOut &json, const sol::object &placement )
{
    if( placement.get_type() == sol::type::string ) {
        json.write( placement.as<std::string>() );
        return;
    }
    const sol::table part = placement.as<sol::table>();
    json.start_object();
    json.member( "part", part.get<std::string>( "part" ) );
    write_placement_member<int>( json, part, "ammo_chance", "ammo" );
    write_placement_member<std::string>( json, part, "fuel", "fuel" );
    write_static_string_or_ids( json, part, "ammo_types", "ammo_types" );
    write_static_string_or_ids( json, part, "tools", "tools" );
    write_mapgen_range( json, "ammo_qty", part.raw_get<sol::object>( "ammo_quantity" ) );
    json.end_object();
}

void write_static_vehicle_mount( JsonOut &json, const sol::table &mount )
{
    json.start_object();
    write_item_fields<int>( json, mount, { { "x", "x" }, { "y", "y" }, { "z", "z" } } );
    json.member( "parts" );
    write_static_values<sol::object>( json, mount.get<sol::table>( "parts" ), "mounted parts",
                                     write_static_vehicle_part_placement );
    json.end_object();
}

void write_static_vehicle_item_spawn( JsonOut &json, const sol::table &spawn )
{
    json.start_object();
    write_item_fields<int>( json, spawn, {
        { "x", "x" }, { "y", "y" }, { "z", "z" }, { "chance", "chance" },
        { "magazine_chance", "magazine" }, { "ammo_chance", "ammo" }
    } );
    write_static_string_or_ids( json, spawn, "item_groups", "item_groups" );
    const sol::object items = spawn.raw_get<sol::object>( "items" );
    if( items.get_type() == sol::type::string ) {
        json.member( "items", items.as<std::string>() );
    } else if( items.get_type() == sol::type::table ) {
        json.member( "items" );
        write_static_values<sol::object>( json, items.as<sol::table>(), "vehicle spawn items",
        []( JsonOut & out, const sol::object & value ) {
            if( value.get_type() == sol::type::string ) {
                out.write( value.as<std::string>() );
                return;
            }
            const sol::table item = value.as<sol::table>();
            out.start_object();
            out.member( "id", item.get<std::string>( "id" ) );
            write_placement_member<std::string>( out, item, "variant", "variant" );
            out.end_object();
        } );
    }
    json.end_object();
}

void write_static_vehicle_zone( JsonOut &json, const sol::table &zone )
{
    json.start_object();
    json.member( "type", zone.get<std::string>( "type" ) );
    write_item_fields<int>( json, zone, { { "x", "x" }, { "y", "y" }, { "z", "z" } } );
    write_item_fields<std::string>( json, zone, { { "name", "name" }, { "filter", "filter" } } );
    json.end_object();
}

void write_static_vehicle( JsonOut &json, const sol::table &options )
{
    write_item_fields<std::string>( json, options, {
        { "id", "id" }, { "abstract", "abstract" }, { "copy_from", "copy-from" },
        { "color_palette", "color_palette" }
    } );
    write_item_text( json, "name", options.raw_get<sol::object>( "name" ), false );
    if( const auto blueprint = options.get<sol::optional<sol::table>>( "blueprint" ) ) {
        json.member( "blueprint" );
        write_static_values<sol::object>( json, *blueprint, "blueprint",
        []( JsonOut & out, const sol::object & row ) {
            if( row.get_type() == sol::type::string ) {
                out.write( row.as<std::string>() );
            } else {
                out.write( bounded_string_array( row.as<sol::table>(), "row",
                           std::numeric_limits<std::size_t>::max(), "vehicle blueprint" ) );
            }
        } );
    }
    write_static_catalog_array( json, options, "mounts", "parts", write_static_vehicle_mount );
    write_static_catalog_array( json, options, "item_spawns", "items", write_static_vehicle_item_spawn );
    write_static_catalog_array( json, options, "zones", "zones", write_static_vehicle_zone );
}

void write_static_npc( JsonOut &json, const sol::table &options )
{
    json.member( "id", options.get<std::string>( "id" ) );
    write_item_text( json, "name_unique", options.raw_get<sol::object>( "unique_name" ), false );
    write_item_text( json, "name_suffix", options.raw_get<sol::object>( "suffix" ), false );
    write_item_text( json, "snip_bye", options.raw_get<sol::object>( "farewell" ), false );
    write_item_fields<std::string>( json, options, {
        { "gender", "gender" }, { "faction", "faction" }, { "class", "class" },
        { "mission", "mission" }, { "chat", "chat" }, { "temporary_suffix", "temp_suffix" },
        { "friend_chat", "talk_friend" }, { "friend_guard_chat", "talk_friend_guard" }
    } );
    write_item_fields<int>( json, options, {
        { "attitude", "attitude" }, { "age", "age" }, { "height", "height" },
        { "strength", "str" }, { "dexterity", "dex" }, { "intelligence", "int" }, { "perception", "per" }
    } );
    write_static_string_or_ids( json, options, "missions_offered", "mission_offered" );
    if( const auto handler = options.get<sol::optional<std::string>>( "on_death" ) ) {
        if( handler->empty() || handler->find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument( "NPC death requires a registered Lua handler name" );
        }
        json.member( "//ccb_lua_npc_death_handler", *handler );
    }
    write_static_tile_object( json, options, "personality", "personality",
    []( JsonOut & out, const sol::table & value ) {
        out.start_object();
        for( const char *field : { "aggression", "bravery", "collector", "altruism" } ) {
            out.member( field, value.get<int>( field ) );
        }
        out.end_object();
    } );
}

void write_static_npc_distribution( JsonOut &json, const sol::object &value )
{
    if( value.get_type() == sol::type::number ) {
        json.write( value.as<double>() );
        return;
    }
    const sol::table expression = value.as<sol::table>();
    json.start_object();
    write_item_fields<double>( json, expression, { { "constant", "constant" }, { "one_in", "one_in" } } );
    write_mapgen_range( json, "dice", expression.raw_get<sol::object>( "dice" ) );
    write_mapgen_range( json, "rng", expression.raw_get<sol::object>( "rng" ) );
    for( const char *field : { "sum", "mul" } ) {
        if( const auto terms = expression.get<sol::optional<sol::table>>( field ) ) {
            json.member( field );
            write_static_values<sol::object>( json, *terms, field, write_static_npc_distribution );
        }
    }
    json.end_object();
}

void write_static_npc_distribution_field( JsonOut &json, const sol::table &options, const char *field,
        const char *native )
{
    const sol::object value = options.raw_get<sol::object>( field );
    if( value.get_type() != sol::type::nil ) {
        json.member( native );
        write_static_npc_distribution( json, value );
    }
}

void write_static_shop_condition( JsonOut &json, const sol::table &options,
                                  const std::string &mod, const std::string &class_id )
{
    if( const auto handler = options.get<sol::optional<std::string>>( "condition_handler" ) ) {
        if( handler->empty() || handler->find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument( "shop condition requires a registered Lua handler name" );
        }
        json.member( "//ccb_lua_shop_condition" );
        json.start_object();
        json.member( "mod", mod );
        json.member( "owner", class_id );
        json.member( "handler", *handler );
        json.end_object();
    }
}

void write_static_npc_shop_group( JsonOut &json, const sol::table &group,
                                 const std::string &mod, const std::string &class_id )
{
    json.start_object();
    json.member( "group", group.get<std::string>( "id" ) );
    write_placement_member<int>( json, group, "trust", "trust" );
    write_item_fields<bool>( json, group, { { "strict", "strict" }, { "rigid", "rigid" } } );
    write_item_text( json, "refusal", group.raw_get<sol::object>( "refusal" ), false );
    write_static_shop_condition( json, group, mod, class_id );
    json.end_object();
}

void write_static_npc_price_rule( JsonOut &json, const sol::table &rule,
                                 const std::string &mod, const std::string &class_id )
{
    json.start_object();
    write_item_fields<std::string>( json, rule, {
        { "item", "item" }, { "group", "group" }, { "category", "category" }
    } );
    write_item_fields<double>( json, rule, {
        { "markup", "markup" }, { "premium", "premium" }, { "fixed_adjustment", "fixed_adj" }
    } );
    write_placement_member<int>( json, rule, "price", "price" );
    write_static_shop_condition( json, rule, mod, class_id );
    json.end_object();
}

void write_static_npc_class( JsonOut &json, const sol::table &options, const std::string &mod )
{
    write_static_named_definition( json, options );
    write_item_text( json, "job_description", options.raw_get<sol::object>( "job_description" ), false );
    write_placement_member<std::string>( json, options, "copy_from", "copy-from" );
    write_item_fields<bool>( json, options, { { "common", "common" }, { "sells_belongings", "sells_belongings" } } );
    write_placement_member<double>( json, options, "spawn_weight", "common_spawn_weight" );
    for( const auto &[field, native] : {
             std::pair{ "strength", "bonus_str" }, std::pair{ "dexterity", "bonus_dex" },
             std::pair{ "intelligence", "bonus_int" }, std::pair{ "perception", "bonus_per" },
             std::pair{ "aggression", "bonus_aggression" }, std::pair{ "bravery", "bonus_bravery" },
             std::pair{ "collector", "bonus_collector" }, std::pair{ "altruism", "bonus_altruism" }
         } ) {
        write_static_npc_distribution_field( json, options, field, native );
    }
    write_item_fields<std::string>( json, options, {
        { "worn", "worn_override" }, { "carry", "carry_override" }, { "weapon", "weapon_override" },
        { "bye_message", "bye_message_override" }, { "restock_interval", "restock_interval" },
        { "consumption_rates", "shopkeeper_consumption_rates" },
        { "blacklist", "shopkeeper_blacklist" }, { "whitelist", "shopkeeper_whitelist" }
    } );
    write_mapgen_range( json, "work_hours", options.raw_get<sol::object>( "work_hours" ) );
    write_item_ids( json, options, { { "proficiencies", "proficiencies" } } );
    const std::string class_id = options.get<std::string>( "id" );
    const sol::object shop_groups = options.raw_get<sol::object>( "shop_groups" );
    if( shop_groups.get_type() == sol::type::string ) {
        json.member( "shopkeeper_item_group", shop_groups.as<std::string>() );
    } else {
        write_static_catalog_array( json, options, "shop_groups", "shopkeeper_item_group",
        [&mod, &class_id]( JsonOut & out, const sol::table & group ) {
            write_static_npc_shop_group( out, group, mod, class_id );
        } );
    }
    write_static_catalog_array( json, options, "price_rules", "shopkeeper_price_rules",
    [&mod, &class_id]( JsonOut & out, const sol::table & rule ) {
        write_static_npc_price_rule( out, rule, mod, class_id );
    } );
    const sol::object traits = options.raw_get<sol::object>( "traits" );
    if( traits.get_type() == sol::type::string ) {
        json.member( "traits", traits.as<std::string>() );
    } else {
        write_static_catalog_array( json, options, "traits", "traits",
        []( JsonOut & out, const sol::table & entry ) {
            if( entry.raw_get<sol::object>( 1 ).get_type() == sol::type::string ) {
                write_static_construction_requirement( out, entry );
            } else {
                write_static_trait_group_entry( out, entry );
            }
        } );
    }
    write_static_catalog_array( json, options, "skills", "skills",
    []( JsonOut & out, const sol::table & row ) {
        out.start_object();
        write_static_string_or_ids( out, row, "skill", "skill" );
        write_static_npc_distribution_field( out, row, "level", "level" );
        write_static_npc_distribution_field( out, row, "bonus", "bonus" );
        out.end_object();
    } );
    write_static_catalog_array( json, options, "spells", "spells",
    []( JsonOut & out, const sol::table & spell ) {
        out.start_object();
        out.member( "id", spell.get<std::string>( "id" ) );
        out.member( "level", spell.get<int>( "level" ) );
        out.end_object();
    } );
    write_static_catalog_array( json, options, "bionics", "bionics",
    []( JsonOut & out, const sol::table & bionic ) {
        out.start_object();
        write_static_string_or_ids( out, bionic, "id", "id" );
        out.member( "chance", bionic.get<int>( "chance" ) );
        out.end_object();
    } );
}

void write_static_achievement( JsonOut &json, const sol::table &options )
{
    write_item_fields<std::string>( json, options, {
        { "id", "id" }, { "abstract", "abstract" }, { "copy_from", "copy-from" }
    } );
    write_item_text( json, "name", options.raw_get<sol::object>( "name" ), false );
    write_item_text( json, "description", options.raw_get<sol::object>( "description" ), false );
    write_item_ids( json, options, { { "hidden_by", "hidden_by" } } );
    write_placement_member<bool>( json, options, "manual", "manually_given" );
    if( const auto limit = options.get<sol::optional<sol::table>>( "time_limit" ) ) {
        json.member( "time_constraint" );
        json.start_object();
        json.member( "since", limit->get<std::string>( "since" ) );
        json.member( "is", limit->get<std::string>( "comparison" ) );
        json.member( "target", limit->get<std::string>( "duration" ) );
        json.end_object();
    }
    write_static_catalog_array( json, options, "requirements", "requirements",
    []( JsonOut & out, const sol::table & requirement ) {
        out.start_object();
        out.member( "event_statistic", requirement.get<std::string>( "statistic" ) );
        out.member( "is", requirement.get<std::string>( "comparison" ) );
        write_placement_member<std::string>( out, requirement, "visibility", "visible" );
        write_item_text( out, "description", requirement.raw_get<sol::object>( "description" ), false );

        const sol::object target = requirement.raw_get<sol::object>( "target" );
        if( target.get_type() == sol::type::table ) {
            const sol::table value = target.as<sol::table>();
            out.member( "target" );
            out.start_array();
            out.write( value.get<std::string>( "type" ) );
            out.write( value.get<std::string>( "value" ) );
            out.end_array();
        } else if( target.get_type() == sol::type::boolean ) {
            out.member( "target", target.as<bool>() );
        } else if( target.get_type() != sol::type::nil ) {
            if( !target.is<int>() ) {
                throw std::invalid_argument( "achievement target requires an integer, boolean, or typed value" );
            }
            out.member( "target", target.as<int>() );
        }
        out.end_object();
    } );
}

void write_static_technique( JsonOut &json, const sol::table &options )
{
    write_item_fields<std::string>( json, options, {
        { "id", "id" }, { "abstract", "abstract" }, { "copy_from", "copy-from" },
        { "cooldown", "cooldown" }, { "aoe", "aoe" },
        { "grapple_action", "grapple_action" }, { "grapple_cooldown", "grapple_cooldown" }
    } );
    write_item_text( json, "name", options.raw_get<sol::object>( "name" ), false );
    write_item_text( json, "description", options.raw_get<sol::object>( "description" ), false );
    write_placement_member<std::string>( json, options, "when", "//ccb_lua_combat_predicate" );
    write_static_native_text( json, options, "condition_description", "condition_desc" );
    write_placement_member<std::string>( json, options, "on_apply", "//ccb_lua_technique_on_apply" );
    if( const auto messages = options.get<sol::optional<sol::table>>( "messages" ) ) {
        json.member( "messages" );
        write_static_values<sol::object>( json, *messages, "technique messages",
        []( JsonOut & out, const sol::object & message ) {
            write_item_text_value( out, "technique message", message, false );
        } );
    }
    write_item_fields<bool>( json, options, {
        { "crit_tec", "crit_tec" }, { "crit_ok", "crit_ok" }, { "wall_adjacent", "wall_adjacent" },
        { "reach_tec", "reach_tec" }, { "reach_ok", "reach_ok" },
        { "manual_activation", "manual_activation" }, { "needs_ammo", "needs_ammo" },
        { "defensive", "defensive" }, { "disarms", "disarms" }, { "take_weapon", "take_weapon" },
        { "side_switch", "side_switch" }, { "dummy", "dummy" },
        { "dodge_counter", "dodge_counter" }, { "block_counter", "block_counter" },
        { "miss_recovery", "miss_recovery" }, { "grab_break", "grab_break" },
        { "knockback_follow", "knockback_follow" }, { "unarmed_allowed", "unarmed_allowed" },
        { "melee_allowed", "melee_allowed" }, { "strictly_unarmed", "strictly_unarmed" }
    } );
    write_item_fields<int>( json, options, {
        { "weighting", "weighting" }, { "repeat_min", "repeat_min" }, { "repeat_max", "repeat_max" },
        { "down_dur", "down_dur" }, { "stun_dur", "stun_dur" }, { "knockback_dist", "knockback_dist" },
        { "grapple_power", "grapple_power" }, { "grapple_stamina", "grapple_stamina" }
    } );
    write_placement_member<double>( json, options, "knockback_spread", "knockback_spread" );
    write_item_ids( json, options, {
        { "attack_vectors", "attack_vectors" }, { "flags", "flags" },
        { "weapon_categories", "weapon_categories_allowed" },
        { "required_buffs_all", "required_buffs_all" }, { "required_buffs_any", "required_buffs_any" },
        { "forbidden_buffs_all", "forbidden_buffs_all" }, { "forbidden_buffs_any", "forbidden_buffs_any" },
        { "required_weapon_flags", "req_flags" }, { "required_char_flags", "required_char_flags" },
        { "required_char_flags_all", "required_char_flags_all" },
        { "forbidden_char_flags", "forbidden_char_flags" }
    } );
    write_static_catalog_array( json, options, "skills", "skill_requirements",
    []( JsonOut & out, const sol::table & requirement ) {
        out.start_object();
        out.member( "name", requirement.get<std::string>( "id" ) );
        out.member( "level", requirement.get<int>( "level" ) );
        out.end_object();
    } );
    write_static_catalog_array( json, options, "weapon_damage", "weapon_damage_requirements",
    []( JsonOut & out, const sol::table & requirement ) {
        out.start_object();
        out.member( "type", requirement.get<std::string>( "type" ) );
        out.member( "min", requirement.get<int>( "minimum" ) );
        out.end_object();
    } );
    const auto bonus = []( JsonOut & out, const sol::table & entry ) {
        out.start_object();
        out.member( "stat", entry.get<std::string>( "stat" ) );
        out.member( "scale", entry.get<double>( "scale" ) );
        write_item_fields<std::string>( out, entry, {
            { "damage_type", "type" }, { "scaling_stat", "scaling-stat" }
        } );
        out.end_object();
    };
    write_static_catalog_array( json, options, "flat_bonuses", "flat_bonuses", bonus );
    write_static_catalog_array( json, options, "mult_bonuses", "mult_bonuses", bonus );
    write_static_catalog_array( json, options, "effects", "tech_effects",
    []( JsonOut & out, const sol::table & effect ) {
        out.start_object();
        out.member( "id", effect.get<std::string>( "id" ) );
        write_item_fields<int>( out, effect, { { "duration_turns", "duration" }, { "chance", "chance" } } );
        write_item_fields<bool>( out, effect, { { "permanent", "permanent" }, { "on_damage", "on_damage" } } );
        write_placement_member<std::string>( out, effect, "required_flag", "req_flag" );
        write_placement_member<std::string>( out, effect, "when", "//ccb_lua_combat_predicate" );
        write_static_native_text( out, effect, "message", "message" );
        out.end_object();
    } );
}

void write_static_spell_energy( JsonOut &json, const sol::table &options )
{
    const sol::object energy = options.raw_get<sol::object>( "energy_source" );
    if( energy.is<std::string>() ) {
        json.member( "energy_source", energy.as<std::string>() );
    } else if( energy.get_type() != sol::type::nil ) {
        json.member( "energy_source" );
        json.start_object();
        const sol::table source = energy.as<sol::table>();
        json.member( "type", source.get<std::string>( "source" ) );
        write_item_fields<std::string>( json, source, { { "vitamin", "vitamin" }, { "color", "color" } } );
        json.end_object();
    }
}

void write_static_magic_type( JsonOut &json, const sol::table &options )
{
    write_item_fields<std::string>( json, options, {
        { "id", "id" }, { "abstract", "abstract" }, { "copy_from", "copy-from" },
        { "get_level_formula", "get_level_formula_id" }, { "exp_for_level_formula", "exp_for_level_formula_id" },
        { "casting_xp_formula", "casting_xp_formula_id" }, { "failure_chance_formula", "failure_chance_formula_id" },
        { "on_failure", "//ccb_lua_magic_type_failure" }
    } );
    write_static_spell_energy( json, options );
    write_static_string_or_ids( json, options, "cannot_cast_flags", "cannot_cast_flags" );
    write_static_native_text( json, options, "cannot_cast_message", "cannot_cast_message" );
    write_placement_member<int>( json, options, "max_book_level", "max_book_level" );
    write_item_fields<double>( json, options, {
        { "failure_cost_fraction", "failure_cost_percent" }, { "failure_experience_fraction", "failure_exp_percent" }
    } );
}

void write_static_spell( JsonOut &json, const sol::table &options )
{
    write_item_fields<std::string>( json, options, {
        { "id", "id" }, { "abstract", "abstract" }, { "copy_from", "copy-from" },
        { "skill", "skill" }, { "components", "components" }, { "sound_type", "sound_type" },
        { "sound_id", "sound_id" }, { "sound_variant", "sound_variant" }, { "shape", "shape" },
        { "effect_data", "effect_str" }, { "explosion_light", "explosion_light" },
        { "field", "field_id" }, { "spell_class", "spell_class" }, { "damage_type", "damage_type" },
        { "magic_type", "magic_type" }, { "get_level_formula", "get_level_formula_id" },
        { "exp_for_level_formula", "exp_for_level_formula_id" }
    } );
    const auto impact = options.get<sol::optional<std::string>>( "impact_handler" );
    if( const auto effect = options.get<sol::optional<std::string>>( "effect" ) ) {
        if( impact ) {
            throw std::invalid_argument( "an ordered spell may specify either effect or impact_handler" );
        }
        if( *effect == "effect_on_condition" ) {
            throw std::invalid_argument( "ordered spell definitions require a native spell effect" );
        }
        json.member( "effect", *effect );
    }
    for( const char *field : { "name", "description", "message", "sound_description",
                              "caster_condition_fail_message", "target_condition_fail_message" } ) {
        write_item_text( json, field, options.raw_get<sol::object>( field ), false );
    }
    write_item_fields<bool>( json, options, {
        { "teachable", "teachable" }, { "sound_ambient", "sound_ambient" }
    } );
    write_placement_member<int>( json, options, "max_book_level", "max_book_level" );
    std::map<std::string, std::string> stat_handlers;
    for( const char *stat : {
             "field_chance", "min_field_intensity", "field_intensity_increment", "max_field_intensity",
             "field_intensity_variance", "min_accuracy", "accuracy_increment", "max_accuracy",
             "min_damage", "damage_increment", "max_damage", "min_range", "range_increment", "max_range",
             "min_aoe", "aoe_increment", "max_aoe", "min_dot", "dot_increment", "max_dot", "min_duration",
             "duration_increment", "max_duration", "min_pierce", "pierce_increment", "max_pierce",
             "min_bash_scaling", "bash_scaling_increment", "max_bash_scaling", "base_energy_cost",
             "final_energy_cost", "energy_increment", "difficulty", "multiple_projectiles", "max_level",
             "base_casting_time", "final_casting_time", "casting_time_increment"
         } ) {
        const sol::object value = options.raw_get<sol::object>( stat );
        if( value.get_type() == sol::type::nil ) {
            continue;
        }
        double fallback;
        if( value.get_type() == sol::type::table ) {
            const sol::table provider = value.as<sol::table>();
            stat_handlers.emplace( stat, provider.get<std::string>( "handler" ) );
            fallback = provider.get<double>( "fallback" );
        } else if( value.get_type() == sol::type::number ) {
            fallback = value.as<double>();
        } else {
            throw std::invalid_argument( std::string( "expected a spell stat number or handler: " ) + stat );
        }
        if( !std::isfinite( fallback ) ) {
            throw std::invalid_argument( std::string( "ordered spell stat must be a finite number: " ) + stat );
        }
        json.member( stat, fallback );
    }
    const auto caster = options.get<sol::optional<std::string>>( "caster_when" );
    const auto target = options.get<sol::optional<std::string>>( "target_when" );
    if( impact || caster || target || !stat_handlers.empty() ) {
        json.member( "//ccb_lua_spell" );
        json.start_object();
        if( impact ) {
            json.member( "impact", *impact );
        }
        if( caster ) {
            json.member( "caster", *caster );
        }
        if( target ) {
            json.member( "target", *target );
        }
        if( !stat_handlers.empty() ) {
            json.member( "stats", stat_handlers );
        }
        json.end_object();
    }
    write_item_ids( json, options, {
        { "valid_targets", "valid_targets" }, { "targeted_monsters", "targeted_monster_ids" },
        { "targeted_species", "targeted_monster_species" }, { "ignored_species", "ignored_monster_species" },
        { "affected_bodyparts", "affected_body_parts" }
    } );
    write_static_string_or_ids( json, options, "flags", "flags" );
    if( const auto flags = options.get<sol::optional<sol::table>>( "extend_flags" ) ) {
        json.member( "extend" );
        json.start_object();
        json.member( "flags", bounded_string_array( *flags, "extend_flags",
                     std::numeric_limits<std::size_t>::max(), "static spell" ) );
        json.end_object();
    }
    write_static_spell_energy( json, options );
    if( const auto channel = options.get<sol::optional<sol::table>>( "channel" ) ) {
        json.member( "channel_data" );
        json.start_object();
        write_placement_member<int>( json, *channel, "turns", "max_channel_turns" );
        write_item_fields<std::string>( json, *channel, {
            { "spell", "channel_spell" }, { "end_spell", "channel_end_spell" },
            { "interrupt_spell", "channel_interrupt_spell" }
        } );
        write_placement_member<bool>( json, *channel, "uses_energy", "channel_uses_energy" );
        json.end_object();
    }
    write_static_catalog_array( json, options, "extra_spells", "extra_effects",
    []( JsonOut & out, const sol::table & spell ) {
        out.start_object();
        out.member( "id", spell.get<std::string>( "spell" ) );
        write_placement_member<bool>( out, spell, "self", "hit_self" );
        write_item_fields<int>( out, spell, {
            { "min_level", "min_level" }, { "max_level", "max_level" }, { "once_in", "once_in" }
        } );
        write_item_text( out, "message", spell.raw_get<sol::object>( "message" ), false );
        write_item_text( out, "npc_message", spell.raw_get<sol::object>( "npc_message" ), false );
        out.end_object();
    } );
    if( const auto learned = options.get<sol::optional<sol::table>>( "learned_spells" ) ) {
        json.member( "learn_spells" );
        json.start_object();
        const std::size_t count = checked_dense_array_size( *learned, "learned_spells",
                                  std::numeric_limits<std::size_t>::max() );
        for( std::size_t index = 1; index <= count; ++index ) {
            const sol::table spell = learned->raw_get<sol::table>( index );
            json.member( spell.get<std::string>( "spell" ), spell.get<int>( "level" ) );
        }
        json.end_object();
    }
}

template<typename Writer, typename Loader>
auto static_catalog_definition( const std::string &source, const char *type,
                                Writer write_fields, Loader load )
{
    return [&source, type, write_fields, load]( const sol::table & options ) {
        std::ostringstream serialized;
        JsonOut json( serialized );
        serialized << std::defaultfloat << std::setprecision( std::numeric_limits<double>::max_digits10 );
        json.start_object();
        json.member( "type", type );
        write_fields( json, options );
        json.end_object();
        const JsonObject definition = json_loader::from_string( serialized.str() ).get_object();
        static_cast<void>( definition.get_string( "type" ) );
        if constexpr( std::is_invocable_v<Loader, const JsonObject &, const std::string &> ) {
            load( definition, source );
        } else {
            load( definition );
        }
    };
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

void bind_ordered_mutation_lifecycle( mutation_branch &definition, const JsonObject &object,
                                      std::string_view source )
{
    const auto lifecycle = object.get_member_opt( "//ccb_lua_mutation_lifecycle" );
    if( !lifecycle ) {
        return;
    }
    if( lifecycle->has_source_file() ) {
        lifecycle->throw_error( "mutation lifecycle metadata is reserved for ordered Lua definitions" );
    }
    const JsonObject handlers = lifecycle->get_object();
    const auto bind = [&]( const char *field, const char *phase,
                           mutation_branch::lifecycle_callback &callback ) {
        if( handlers.has_member( field ) ) {
            const std::string name = handlers.get_string( field );
            if( name.empty() || name.find( '\0' ) != std::string::npos ) {
                handlers.throw_error_at( field, "mutation lifecycle requires a registered handler name" );
            }
            callback = [owner = std::string( source ), name, phase]( Character & actor,
            const trait_id & id ) {
                detail::invoke_mutation_lifecycle_handler( owner, id.str(), phase, name, actor );
            };
        }
    };
    bind( "activate", "activation", definition.platform_on_activate );
    bind( "deactivate", "deactivation", definition.platform_on_deactivate );
    bind( "process", "processing", definition.platform_on_process );
}

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
    sol::table ccb = loaded["ccb"];
    sol::table content = ccb["content"];
    content.set_function( "is_mod_active", [&selected_mod_ids]( const std::string &id ) {
        return selected_mod_ids.count( id ) != 0;
    } );
    content.set_function( "define_mapgen", load_static_mapgen );
    content.set_function( "define_external_option", static_catalog_definition(
                              resolved.id, "EXTERNAL_OPTION", write_static_external_option, load_external_option ) );
    content.set_function( "define_character_modifier", static_catalog_definition(
                              resolved.id, "character_mod", write_static_character_modifier,
                              character_modifier::load_character_modifiers ) );
    content.set_function( "define_ammunition_type", static_catalog_definition(
                              resolved.id, "ammunition_type", write_static_ammunition_type,
                              ammunition_type::load_ammunition_type ) );
    content.set_function( "define_vehicle_part_location", static_catalog_definition(
                              resolved.id, "vehicle_part_location", write_static_vehicle_part_location,
                              vpart_location::load_vehicle_part_locations ) );
    content.set_function( "define_region_settings_river", static_catalog_definition(
                              resolved.id, "region_settings_river", write_static_region_settings_river,
                              region_settings_river::load_region_settings_river ) );
    content.set_function( "define_region_settings_lake", static_catalog_definition(
                              resolved.id, "region_settings_lake", write_static_region_settings_lake,
                              region_settings_lake::load_region_settings_lake ) );
    content.set_function( "define_region_settings_ocean", static_catalog_definition(
                              resolved.id, "region_settings_ocean", write_static_region_settings_ocean,
                              region_settings_ocean::load_region_settings_ocean ) );
    content.set_function( "define_region_settings_ravine", static_catalog_definition(
                              resolved.id, "region_settings_ravine", write_static_region_settings_ravine,
                              region_settings_ravine::load_region_settings_ravine ) );
    content.set_function( "define_region_settings_forest", static_catalog_definition(
                              resolved.id, "region_settings_forest", write_static_region_settings_forest,
                              region_settings_forest::load_region_settings_forest ) );
    content.set_function( "define_region_settings_forest_trail", static_catalog_definition(
                              resolved.id, "region_settings_forest_trail", write_static_region_settings_forest_trail,
                              region_settings_forest_trail::load_region_settings_forest_trail ) );
    content.set_function( "define_region_settings_forest_mapgen", static_catalog_definition(
                              resolved.id, "region_settings_forest_mapgen", write_static_region_settings_forest_mapgen,
                              region_settings_forest_mapgen::load_region_settings_forest_mapgen ) );
    content.set_function( "define_region_settings_terrain_furniture", static_catalog_definition(
                              resolved.id, "region_settings_terrain_furniture", write_static_region_settings_terrain_furniture,
                              region_settings_terrain_furniture::load_region_settings_terrain_furniture ) );
    content.set_function( "define_region_terrain_furniture", static_catalog_definition(
                              resolved.id, "region_terrain_furniture", write_static_region_terrain_furniture,
                              region_terrain_furniture::load_region_terrain_furniture ) );
    content.set_function( "define_region_settings_map_extras", static_catalog_definition(
                              resolved.id, "region_settings_map_extras", write_static_region_settings_map_extras,
                              region_settings_map_extras::load_region_settings_map_extras ) );
    content.set_function( "define_monster_attack", static_catalog_definition(
    resolved.id, "monster_attack", []( JsonOut & json, const sol::table & attack ) {
        write_static_monster_attack_fields( json, attack, "attack_type" );
    }, []( const JsonObject & definition, const std::string & source_id ) {
        MonsterGenerator::generator().load_monster_attack( definition, source_id );
    } ) );
    content.set_function( "define_magic_type", static_catalog_definition(
                              resolved.id, "magic_type", write_static_magic_type, magic_type::load_magic_type ) );
    content.set_function( "define_forest_biome_component", static_catalog_definition(
                              resolved.id, "forest_biome_component", write_static_forest_biome_component,
                              forest_biome_component::load_forest_biome_feature ) );
    content.set_function( "define_forest_biome_mapgen", static_catalog_definition(
                              resolved.id, "forest_biome_mapgen", write_static_forest_biome_mapgen,
                              forest_biome_mapgen::load_forest_biome_mapgen ) );
    content.set_function( "define_map_extra", static_catalog_definition(
                              resolved.id, "map_extra", write_static_map_extra, MapExtras::load ) );
    content.set_function( "define_map_extra_collection", static_catalog_definition(
                              resolved.id, "map_extra_collection", write_static_map_extra_collection,
                              map_extra_collection::load_map_extra_collection ) );
    content.set_function( "define_trait_migration", static_catalog_definition(
                              resolved.id, "TRAIT_MIGRATION", write_static_trait_migration, mutation_branch::load_trait_migration ) );
    content.set_function( "define_camp_migration", static_catalog_definition(
                              resolved.id, "camp_migration", write_static_camp_migration, overmap::load_oter_id_camp_migration ) );
    content.set_function( "define_mod_migration", static_catalog_definition(
                              resolved.id, "mod_migration", write_static_mod_migration, mod_migrations::load ) );
    content.set_function( "define_climate_station", static_catalog_definition(
                              resolved.id, "regional_climate_station", write_static_climate_station,
                              regional_climate::load_station ) );
    content.set_function( "define_ascii_art", static_catalog_definition(
                              resolved.id, "ascii_art", write_static_ascii_art,
                              ascii_art::load_ascii_art ) );
    content.set_function( "define_city_building", static_catalog_definition(
                              resolved.id, "city_building", write_static_fixed_overmap_layout,
                              city_buildings::load ) );
    content.set_function( "define_fixed_overmap_special", static_catalog_definition(
                              resolved.id, "overmap_special", write_static_fixed_overmap_special,
                              overmap_specials::load ) );
    content.set_function( "define_weakpoint_set", [&resolved]( const sol::table & options ) {
        load_static_weakpoint_set( options, resolved.id );
    } );
    content.set_function( "define_monster_faction", static_catalog_definition(
                              resolved.id, "MONSTER_FACTION", write_static_monster_faction,
                              monfactions::load_monster_faction ) );
    content.set_function( "define_mutation_type", static_catalog_definition(
                              resolved.id, "mutation_type", write_static_mutation_type,
                              load_mutation_type ) );
    content.set_function( "define_trait_group", static_catalog_definition(
                              resolved.id, "trait_group", write_static_trait_group,
                              static_cast<void ( * )( const JsonObject & )>( mutation_branch::load_trait_group ) ) );
    content.set_function( "define_fault", static_catalog_definition(
                              resolved.id, "fault", write_static_fault, faults::load_fault ) );
    content.set_function( "define_fault_fix", static_catalog_definition(
                              resolved.id, "fault_fix", write_static_fault_fix, faults::load_fix ) );
    content.set_function( "define_vehicle_group", static_catalog_definition(
                              resolved.id, "vehicle_group", write_static_vehicle_group,
                              VehicleGroup::load ) );
    content.set_function( "define_construction", static_catalog_definition(
                              resolved.id, "construction", write_static_construction, load_construction ) );
    content.set_function( "define_harvest", static_catalog_definition(
                              resolved.id, "harvest", write_static_harvest, harvest_list::load_harvest_list ) );
    content.set_function( "define_widget", static_catalog_definition(
                              resolved.id, "widget", write_static_widget, widget::load_widget ) );
    content.set_function( "define_field_type", static_catalog_definition(
                              resolved.id, "field_type", write_static_field_type, field_types::load ) );
    content.set_function( "define_terrain", static_catalog_definition(
                              resolved.id, "terrain", write_static_tile_terrain, load_terrain ) );
    content.set_function( "define_furniture", static_catalog_definition(
                              resolved.id, "furniture", write_static_tile_furniture, load_furniture ) );
    content.set_function( "define_trap", static_catalog_definition(
                              resolved.id, "trap", write_static_trap, trap::load_trap ) );
    content.set_function( "define_proficiency_category", static_catalog_definition(
                              resolved.id, "proficiency_category", write_static_proficiency_category,
                              proficiency_category::load_proficiency_categories ) );
    content.set_function( "define_proficiency", static_catalog_definition(
                              resolved.id, "proficiency", write_static_proficiency,
                              proficiency::load_proficiencies ) );
    content.set_function( "define_item_action", static_catalog_definition(
                              resolved.id, "item_action", write_static_named_definition, []( const JsonObject & jo ) {
        item_action_generator::generator().load_item_action( jo );
    } ) );
    content.set_function( "define_start_location", static_catalog_definition(
                              resolved.id, "start_location", write_static_start_location, start_locations::load ) );
    content.set_function( "define_mission", static_catalog_definition(
    resolved.id, "mission_definition", [&resolved]( JsonOut & json, const sol::table & options ) {
        write_static_mission( json, options, resolved.id );
    }, mission_type::load_mission_type ) );
    content.set_function( "define_scenario", static_catalog_definition(
                              resolved.id, "scenario", write_static_scenario, scenario::load_scenario ) );
    content.set_function( "define_profession", static_catalog_definition(
                              resolved.id, "profession", write_static_profession, profession::load_profession ) );
    content.set_function( "define_vehicle_part", static_catalog_definition(
                              resolved.id, "vehicle_part", write_static_vehicle_part, vehicles::parts::load ) );
    content.set_function( "define_vehicle", static_catalog_definition(
                              resolved.id, "vehicle", write_static_vehicle, vehicles::load_prototype ) );
    content.set_function( "define_spell", static_catalog_definition(
                              resolved.id, "SPELL", write_static_spell, spell_type::load_spell ) );
    content.set_function( "define_technique", static_catalog_definition(
                              resolved.id, "technique", write_static_technique, load_technique ) );
    content.set_function( "define_achievement", static_catalog_definition(
                              resolved.id, "achievement", write_static_achievement, achievement::load_achievement ) );
    content.set_function( "define_conduct", static_catalog_definition(
                              resolved.id, "conduct", write_static_achievement, achievement::load_achievement ) );
    content.set_function( "set_martial_art_handler",
    [&resolved]( const std::string & id, const std::string & phase, const std::string & handler ) {
        set_ordered_martial_art_handler( matype_id( id ), phase, resolved.id, handler );
    } );
    content.set_function( "define_npc", static_catalog_definition(
                              resolved.id, "npc", write_static_npc, npc_template::load ) );
    content.set_function( "define_npc_class", static_catalog_definition(
    resolved.id, "npc_class", [&resolved]( JsonOut & json, const sol::table & options ) {
        write_static_npc_class( json, options, resolved.id );
    }, npc_class::load_npc_class ) );
    install_static_dialogue_predicates( lua, content );
    install_static_widget_conditions( lua, content );
    install_static_dialogue_actions( lua, content );
    content.set_function( "gendered_line", static_gendered_dialogue_line );
    content.set_function( "define_dialogue_topic", [&resolved]( const sol::table &options ) {
        load_static_dialogue_topic( options, resolved.id );
    } );
    content.set_function( "define_item", [&resolved]( const sol::table &options ) {
        load_static_item( options, resolved.id );
    } );
    content.set_function( "define_mutation", [&resolved]( const sol::table &options ) {
        load_static_mutation( options, resolved.id );
    } );
    content.set_function( "define_monster", [&resolved]( const sol::table &options ) {
        load_static_monster( options, resolved.id );
    } );
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

void bind_ordered_mutation_lifecycle( mutation_branch &, const JsonObject &, std::string_view )
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
