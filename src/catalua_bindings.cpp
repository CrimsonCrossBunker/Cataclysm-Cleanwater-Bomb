#include "catalua_bindings.h"

#include <algorithm>
#include <stdexcept>
#include <string>

namespace cata::lua_ui
{

const std::vector<binding_domain> &binding_catalog()
{
    static const std::vector<binding_domain> catalog = {
        {
            "value_types_and_ids", "game.types", "game.read", 5,
            binding_implementation_status::partial
        },
        {
            "coordinates", "game.coords", "game.read", 5,
            binding_implementation_status::planned
        },
        {
            "bionics", "game.bionics", "game.read", 5,
            binding_implementation_status::partial
        },
        {
            "creatures_and_effects", "game.creatures", "game.read", 5,
            binding_implementation_status::partial
        },
        {
            "items_and_inventory", "game.items", "game.read", 5,
            binding_implementation_status::partial
        },
        {
            "character_powers", "game.character", "game.read", 5,
            binding_implementation_status::partial
        },
        {
            "map_and_world", "game.world", "game.read", 5,
            binding_implementation_status::partial
        },
        {
            "mapgen", "game.mapgen", "game.write", 5,
            binding_implementation_status::planned
        },
        {
            "missions", "game.missions", "game.read", 5,
            binding_implementation_status::partial
        },
        {
            "crafting", "game.crafting", "game.read", 5,
            binding_implementation_status::partial
        },
        {
            "game_services", "game", "game.read", 2,
            binding_implementation_status::partial
        },
        {
            "runtime_and_definitions", "registry", "registry.read", 4,
            binding_implementation_status::partial
        },
        {
            "hooks", "game.hooks", "game.hooks", 5,
            binding_implementation_status::planned
        },
        {
            "callback_actors", "game.callbacks", "game.callbacks", 5,
            binding_implementation_status::planned
        }
    };
    return catalog;
}

const binding_domain *find_binding_domain( const std::string_view id )
{
    const std::vector<binding_domain> &catalog = binding_catalog();
    const auto found = std::find_if( catalog.begin(), catalog.end(),
    [id]( const binding_domain & entry ) {
        return entry.id == id;
    } );
    return found == catalog.end() ? nullptr : &*found;
}

std::string_view binding_status_name( const binding_implementation_status status )
{
    switch( status ) {
        case binding_implementation_status::planned:
            return "planned";
        case binding_implementation_status::partial:
            return "partial";
        case binding_implementation_status::covered:
            return "covered";
        case binding_implementation_status::not_applicable:
            return "not_applicable";
    }
    throw std::invalid_argument( "unknown Lua binding implementation status" );
}

bool binding_domain_is_covered( const std::string_view id )
{
    const binding_domain *domain = find_binding_domain( id );
    return domain != nullptr && domain->status == binding_implementation_status::covered;
}

void install_binding_catalog_api( sol::table &game, std::function<void()> require_read )
{
    game.set_function( "api_catalog", [require_read]( sol::this_state lua ) {
        require_read();
        sol::state_view state( lua );
        sol::table result = state.create_table();
        const std::vector<binding_domain> &catalog = binding_catalog();
        for( std::size_t index = 0; index < catalog.size(); ++index ) {
            const binding_domain &domain = catalog[index];
            sol::table entry = state.create_table();
            entry["id"] = std::string( domain.id );
            entry["namespace"] = std::string( domain.lua_namespace );
            entry["capability"] = std::string( domain.capability );
            entry["minimum_api_version"] = domain.minimum_api_version;
            entry["status"] = std::string( binding_status_name( domain.status ) );
            result[index + 1] = std::move( entry );
        }
        return result;
    } );
    game.set_function( "api_supports", [require_read]( const std::string & domain ) {
        require_read();
        return binding_domain_is_covered( domain );
    } );
}

} // namespace cata::lua_ui
