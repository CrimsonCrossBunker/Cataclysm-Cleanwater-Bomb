#include "catalua_game_handle.h"

#include <stdexcept>
#include <utility>

#include "avatar.h"
#include "character_id.h"
#include "coordinates.h"
#include "creature.h"
#include "item.h"
#include "vehicle.h"

namespace cata::lua_ui
{

namespace
{

game_handle_error wrong_kind_error( const game_handle_kind expected,
                                    const game_handle_kind actual )
{
    return {
        "wrong_kind",
        "GameHandle kind '" + std::string( game_handle_kind_name( actual ) ) +
        "' cannot be used as '" + std::string( game_handle_kind_name( expected ) ) + "'"
    };
}

game_handle_error destroyed_error( const game_handle_kind kind )
{
    return {
        "destroyed",
        "The native " + std::string( game_handle_kind_name( kind ) ) +
        " referenced by this GameHandle no longer exists"
    };
}

sol::table locator_to_lua( sol::state_view lua, const game_handle_locator &locator )
{
    sol::table result = lua.create_table();
    result["scope"] = locator.scope;
    result["stable_id"] = locator.stable_id;
    sol::table position = lua.create_table();
    position["x"] = locator.x;
    position["y"] = locator.y;
    position["z"] = locator.z;
    result["position"] = std::move( position );
    sol::table path = lua.create_table();
    for( std::size_t index = 0; index < locator.path.size(); ++index ) {
        path[index + 1] = locator.path[index];
    }
    result["path"] = std::move( path );
    return result;
}

sol::table handle_value_to_lua( sol::state_view lua, const game_handle &handle )
{
    sol::table result = lua.create_table();
    result["kind"] = handle.kind_name();
    result["locator"] = locator_to_lua( lua, handle.locator() );
    return result;
}

} // namespace

game_handle game_handle::from_creature(
    Creature &value, game_handle_locator locator,
    const std::size_t runtime_generation, const std::size_t world_generation )
{
    game_handle result;
    result.kind_ = game_handle_kind::creature;
    result.locator_ = std::move( locator );
    result.runtime_generation_ = runtime_generation;
    result.world_generation_ = world_generation;
    result.creature_ = value.get_safe_reference();
    return result;
}

game_handle game_handle::from_item(
    item &value, game_handle_locator locator,
    const std::size_t runtime_generation, const std::size_t world_generation )
{
    game_handle result;
    result.kind_ = game_handle_kind::item;
    result.locator_ = std::move( locator );
    result.runtime_generation_ = runtime_generation;
    result.world_generation_ = world_generation;
    result.item_ = value.get_safe_reference();
    return result;
}

game_handle game_handle::from_vehicle(
    vehicle &value, game_handle_locator locator,
    const std::size_t runtime_generation, const std::size_t world_generation )
{
    game_handle result;
    result.kind_ = game_handle_kind::vehicle;
    result.locator_ = std::move( locator );
    result.runtime_generation_ = runtime_generation;
    result.world_generation_ = world_generation;
    result.vehicle_ = value.get_safe_reference();
    return result;
}

game_handle_kind game_handle::kind() const noexcept
{
    return kind_;
}

std::string game_handle::kind_name() const
{
    return std::string( game_handle_kind_name( kind_ ) );
}

const game_handle_locator &game_handle::locator() const noexcept
{
    return locator_;
}

std::size_t game_handle::runtime_generation() const noexcept
{
    return runtime_generation_;
}

std::size_t game_handle::world_generation() const noexcept
{
    return world_generation_;
}

std::optional<game_handle_error> game_handle::validation_error(
    const std::size_t current_runtime_generation,
    const std::size_t current_world_generation ) const
{
    if( runtime_generation_ != current_runtime_generation ) {
        return game_handle_error{
            "stale_runtime",
            "GameHandle belongs to an inactive Lua runtime generation"
        };
    }
    if( world_generation_ != current_world_generation ) {
        return game_handle_error{
            "stale_world",
            "GameHandle belongs to a different world generation"
        };
    }
    switch( kind_ ) {
        case game_handle_kind::creature:
            if( !creature_ ) {
                return destroyed_error( kind_ );
            }
            break;
        case game_handle_kind::item:
            if( !item_ ) {
                return destroyed_error( kind_ );
            }
            break;
        case game_handle_kind::vehicle:
            if( !vehicle_ ) {
                return destroyed_error( kind_ );
            }
            break;
        case game_handle_kind::none:
            return game_handle_error{
                "wrong_kind", "GameHandle does not reference a game object"
            };
    }
    return std::nullopt;
}

native_handle_result<Creature> game_handle::resolve_creature(
    const std::size_t current_runtime_generation,
    const std::size_t current_world_generation ) const
{
    if( kind_ != game_handle_kind::creature ) {
        return { nullptr, wrong_kind_error( game_handle_kind::creature, kind_ ) };
    }
    if( const std::optional<game_handle_error> error =
            validation_error( current_runtime_generation, current_world_generation ) ) {
        return { nullptr, error };
    }
    Creature *value = creature_.get();
    return value == nullptr ?
           native_handle_result<Creature> { nullptr, destroyed_error( kind_ ) } :
           native_handle_result<Creature> { value, std::nullopt };
}

native_handle_result<item> game_handle::resolve_item(
    const std::size_t current_runtime_generation,
    const std::size_t current_world_generation ) const
{
    if( kind_ != game_handle_kind::item ) {
        return { nullptr, wrong_kind_error( game_handle_kind::item, kind_ ) };
    }
    if( const std::optional<game_handle_error> error =
            validation_error( current_runtime_generation, current_world_generation ) ) {
        return { nullptr, error };
    }
    item *value = item_.get();
    return value == nullptr ?
           native_handle_result<item> { nullptr, destroyed_error( kind_ ) } :
           native_handle_result<item> { value, std::nullopt };
}

native_handle_result<vehicle> game_handle::resolve_vehicle(
    const std::size_t current_runtime_generation,
    const std::size_t current_world_generation ) const
{
    if( kind_ != game_handle_kind::vehicle ) {
        return { nullptr, wrong_kind_error( game_handle_kind::vehicle, kind_ ) };
    }
    if( const std::optional<game_handle_error> error =
            validation_error( current_runtime_generation, current_world_generation ) ) {
        return { nullptr, error };
    }
    vehicle *value = vehicle_.get();
    return value == nullptr ?
           native_handle_result<vehicle> { nullptr, destroyed_error( kind_ ) } :
           native_handle_result<vehicle> { value, std::nullopt };
}

std::string_view game_handle_kind_name( const game_handle_kind kind )
{
    switch( kind ) {
        case game_handle_kind::none:
            return "none";
        case game_handle_kind::creature:
            return "creature";
        case game_handle_kind::item:
            return "item";
        case game_handle_kind::vehicle:
            return "vehicle";
    }
    throw std::invalid_argument( "unknown GameHandle kind" );
}

sol::table make_game_value_result( sol::state_view lua, const sol::object &value )
{
    sol::table result = lua.create_table();
    result["ok"] = true;
    result["value"] = value;
    return result;
}

sol::table make_game_error_result( sol::state_view lua, const game_handle_error &error )
{
    sol::table result = lua.create_table();
    result["ok"] = false;
    sol::table detail = lua.create_table();
    detail["code"] = error.code;
    detail["message"] = error.message;
    result["error"] = std::move( detail );
    return result;
}

void install_game_handle_api(
    sol::state &lua, sol::table &game,
    std::function<std::size_t()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read )
{
    lua.new_usertype<game_handle>(
        "GameHandle", sol::no_constructor,
        "kind", sol::property( &game_handle::kind_name ),
    "locator", []( sol::this_state lua_state, const game_handle & self ) {
        return locator_to_lua( sol::state_view( lua_state ), self.locator() );
    },
    "is_valid",
    [current_runtime_generation, current_world_generation]( const game_handle & self ) {
        return !self.validation_error(
                   current_runtime_generation(), current_world_generation() );
    },
    "status",
    [current_runtime_generation, current_world_generation](
        sol::this_state lua_state, const game_handle & self ) {
        sol::state_view state( lua_state );
        if( const std::optional<game_handle_error> error =
                self.validation_error(
                    current_runtime_generation(), current_world_generation() ) ) {
            return make_game_error_result( state, *error );
        }
        return make_game_value_result(
                   state, sol::make_object( state, handle_value_to_lua( state, self ) ) );
    } );

    sol::table handles = lua.create_table();
    handles.set_function( "avatar", [
                           current_runtime_generation,
                           current_world_generation,
                           require_read
    ]() {
        require_read();
        avatar &player = get_avatar();
        const tripoint_abs_ms position = player.pos_abs();
        return game_handle::from_creature(
        player, {
            "avatar", player.getID().get_value(),
            position.x(), position.y(), position.z(), {}
        },
        current_runtime_generation(), current_world_generation() );
    } );
    game["handles"] = std::move( handles );
}

} // namespace cata::lua_ui
