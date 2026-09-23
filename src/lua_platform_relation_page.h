#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_RELATION_PAGE_H
#define CATA_SRC_LUA_PLATFORM_RELATION_PAGE_H

#include <algorithm>
#include <cstddef>
#include <string>
#include <string_view>
#include <utility>

#include "lua_platform_bindings_values.h"
#include "lua_platform_sol.h"

namespace cata::lua_platform::detail
{

// Detached, 1-based relation snapshots preserve the native range order.
// Each domain supplies its own bound; this is not a paginated registry query.
template<typename Range, typename Convert>
sol::table make_bounded_relation_page( sol::state_view lua, const Range &values,
                                       std::size_t maximum, const Convert &convert )
{
    const std::size_t total = values.size();
    const std::size_t returned = std::min( total, maximum );
    sol::table items = lua.create_table( static_cast<int>( returned ), 0 );
    std::size_t index = 0;
    for( const auto &value : values ) {
        if( index >= returned ) {
            break;
        }
        items[++index] = convert( value );
    }
    sol::table result = lua.create_table();
    result["items"] = std::move( items );
    result["total"] = total;
    result["returned"] = returned;
    result["truncated"] = returned < total;
    return result;
}

template<typename Range>
sol::table make_typed_id_page( sol::state_view lua, std::size_t maximum,
                               const Range &ids, std::string_view kind )
{
    return make_bounded_relation_page( std::move( lua ), ids, maximum, [kind]( const auto & id ) {
        return script_game_id( std::string( kind ), id.str() );
    } );
}

template<typename Range>
sol::table make_string_id_page( sol::state_view lua, std::size_t maximum, const Range &ids )
{
    return make_bounded_relation_page( std::move( lua ), ids, maximum, []( const auto & id ) -> decltype( auto ) {
        return id.str();
    } );
}

template<typename Range>
sol::table make_string_page( sol::state_view lua, std::size_t maximum, const Range &values )
{
    return make_bounded_relation_page( std::move( lua ), values,
    maximum, []( const auto & value ) -> decltype( auto ) {
        return value;
    } );
}

} // namespace cata::lua_platform::detail

#endif // CATA_SRC_LUA_PLATFORM_RELATION_PAGE_H
