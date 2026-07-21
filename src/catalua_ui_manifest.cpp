#include "catalua_ui_manifest.h"

#include <algorithm>
#include <cctype>
#include <stdexcept>
#include <unordered_map>
#include <utility>

#include "catalua_ui.h"
#include "flexbuffer_json.h"

namespace cata::lua_ui
{

namespace
{

constexpr std::size_t maximum_manifest_id_bytes = 128;
constexpr std::size_t maximum_manifest_version_bytes = 64;
constexpr std::size_t maximum_manifest_entries = 64;

bool valid_identifier( std::string_view value )
{
    return !value.empty() && value.size() <= maximum_manifest_id_bytes &&
    std::all_of( value.begin(), value.end(), []( const unsigned char ch ) {
        return std::isalnum( ch ) != 0 || ch == '_' || ch == '-' || ch == '.' || ch == ':';
    } );
}

} // namespace

bool script_manifest::has_capability( std::string_view capability ) const
{
    return capabilities.count( std::string( capability ) ) != 0;
}

const std::set<std::string> &supported_script_capabilities()
{
    static const std::set<std::string> capabilities = {
        "events",
        "game.actions",
        "game.read",
        "state.character",
        "ui.hud",
        "ui.pages"
    };
    return capabilities;
}

script_manifest read_script_manifest( const JsonValue &input )
{
    if( !input.test_object() ) {
        throw std::invalid_argument( "Lua manifest root must be an object" );
    }
    const JsonObject root = input.get_object();
    script_manifest result;
    result.id = root.get_string( "id" );
    result.version = root.get_string( "version" );
    result.api_version = root.get_int( "api_version" );
    if( !valid_identifier( result.id ) ) {
        throw std::invalid_argument( "Lua manifest id is empty, too long, or contains invalid characters" );
    }
    if( result.version.empty() || result.version.size() > maximum_manifest_version_bytes ) {
        throw std::invalid_argument( "Lua manifest version must contain 1 to 64 bytes" );
    }
    if( result.api_version != api_version ) {
        throw std::invalid_argument( "Lua manifest '" + result.id + "' requires API " +
                                     std::to_string( result.api_version ) + ", runtime provides " +
                                     std::to_string( api_version ) );
    }

    const std::vector<std::string> capabilities = root.get_string_array( "capabilities" );
    const std::vector<std::string> dependencies = root.get_string_array( "dependencies" );
    if( capabilities.size() > maximum_manifest_entries ||
        dependencies.size() > maximum_manifest_entries ) {
        throw std::invalid_argument( "Lua manifest exceeds 64 capabilities or dependencies" );
    }
    for( const std::string &capability : capabilities ) {
        if( supported_script_capabilities().count( capability ) == 0 ) {
            throw std::invalid_argument( "Lua manifest '" + result.id +
                                         "' requests unknown capability '" + capability + "'" );
        }
        if( !result.capabilities.insert( capability ).second ) {
            throw std::invalid_argument( "Lua manifest '" + result.id +
                                         "' repeats capability '" + capability + "'" );
        }
    }
    for( const std::string &dependency : dependencies ) {
        if( !valid_identifier( dependency ) ) {
            throw std::invalid_argument( "Lua manifest '" + result.id +
                                         "' has an invalid dependency id" );
        }
        if( dependency == result.id ) {
            throw std::invalid_argument( "Lua manifest '" + result.id + "' depends on itself" );
        }
        if( std::find( result.dependencies.begin(), result.dependencies.end(), dependency ) !=
            result.dependencies.end() ) {
            throw std::invalid_argument( "Lua manifest '" + result.id +
                                         "' repeats dependency '" + dependency + "'" );
        }
        result.dependencies.push_back( dependency );
    }
    root.allow_omitted_members();
    return result;
}

script_manifest default_script_manifest( const std::string &id, bool allow_actions )
{
    script_manifest result;
    result.id = id;
    result.version = "legacy";
    result.api_version = api_version;
    result.capabilities = supported_script_capabilities();
    if( !allow_actions ) {
        result.capabilities.erase( "game.actions" );
    }
    return result;
}

void validate_script_manifests( const std::vector<script_manifest> &manifests )
{
    std::unordered_map<std::string, std::size_t> positions;
    for( std::size_t index = 0; index < manifests.size(); ++index ) {
        if( !positions.emplace( manifests[index].id, index ).second ) {
            throw std::invalid_argument( "Duplicate Lua manifest id '" + manifests[index].id + "'" );
        }
    }
    for( std::size_t index = 0; index < manifests.size(); ++index ) {
        for( const std::string &dependency : manifests[index].dependencies ) {
            const auto found = positions.find( dependency );
            if( found == positions.end() ) {
                throw std::invalid_argument( "Lua manifest '" + manifests[index].id +
                                             "' requires missing dependency '" + dependency + "'" );
            }
            if( found->second >= index ) {
                throw std::invalid_argument( "Lua manifest '" + manifests[index].id +
                                             "' dependency '" + dependency +
                                             "' must load earlier" );
            }
        }
    }
}

} // namespace cata::lua_ui
