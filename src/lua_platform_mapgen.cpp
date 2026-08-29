#if CATA_ENABLE_LUA_PLATFORM

#include "lua_platform_mapgen.h"

#include <algorithm>
#include <array>
#include <cmath>
#include <stdexcept>
#include <string_view>
#include <utility>

#include "calendar.h"
#include "computer.h"
#include "field_type.h"
#include "game_constants.h"
#include "item.h"
#include "item_group.h"
#include "map.h"
#include "mapgen.h"
#include "mapgen_functions.h"
#include "mapgendata.h"
#include "mission.h"
#include "mongroup.h"
#include "omdata.h"
#include "point.h"
#include "trap.h"
#include "type_id.h"
#include "lua_platform_overmap.h"
#include "lua_platform_world.h"

namespace cata::lua_platform
{

std::optional<game_handle_error> validate_mapgen_update_token(
    const mapgen_update_token &token,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( !token.owner_is_current() ) {
        return game_handle_error{
            "stale_owner",
            "Mapgen update token runtime owner is no longer live"
        };
    }
    if( !token.runtime_matches( runtime_generation ) ) {
        return game_handle_error{
            "stale_runtime",
            "Mapgen update token belongs to a different runtime generation"
        };
    }
    if( !token.world_matches( world_generation ) ) {
        return game_handle_error{
            "stale_world",
            "Mapgen update token belongs to a different world generation"
        };
    }
    if( !token.native_id().is_valid() ||
        !has_update_mapgen_for( token.native_id() ) ) {
        return game_handle_error{
            "invalid_id",
            "Mapgen update token has no valid registered update-mapgen id"
        };
    }
    return std::nullopt;
}

mapgen_update_token::mapgen_update_token(
    const update_mapgen_id &id,
    const game_handle_runtime &runtime,
    const std::size_t world_generation ) :
    id_( id ),
    runtime_( runtime ),
    world_generation_( world_generation )
{
}

const update_mapgen_id &mapgen_update_token::native_id() const noexcept
{
    return id_;
}

script_game_id mapgen_update_token::id() const
{
    return script_game_id( "update_mapgen", id_.str() );
}

std::size_t mapgen_update_token::runtime_generation() const noexcept
{
    return runtime_.generation();
}

std::size_t mapgen_update_token::world_generation() const noexcept
{
    return world_generation_;
}

bool mapgen_update_token::owner_is_current() const noexcept
{
    return runtime_.has_live_owner();
}

bool mapgen_update_token::runtime_matches(
    const game_handle_runtime &runtime ) const noexcept
{
    return runtime_.is_active_match( runtime );
}

bool mapgen_update_token::world_matches(
    const std::size_t world_generation ) const noexcept
{
    return world_generation_ != 0 && world_generation != 0 &&
           world_generation_ == world_generation;
}

std::string mapgen_update_token::to_string() const
{
    return "MapgenUpdateToken<" + id_.str() + ":" +
           std::to_string( runtime_generation() ) + ":" +
           std::to_string( world_generation_ ) + ">";
}

bool operator==( const mapgen_update_token &lhs,
                 const mapgen_update_token &rhs ) noexcept
{
    return lhs.id_ == rhs.id_ &&
           lhs.world_generation_ == rhs.world_generation_ &&
           lhs.runtime_.same_identity( rhs.runtime_ );
}

namespace
{

struct mapgen_apply_options {
    bool mirror_horizontal = false;
    bool mirror_vertical = false;
    bool cancel_on_collision = true;
    int rotation = 0;
};

std::optional<game_handle_error> read_mapgen_apply_options(
    const sol::optional<sol::object> &requested,
    mapgen_apply_options &result )
{
    constexpr std::string_view api_name = "services.mapgen.apply";
    if( !requested ) {
        return std::nullopt;
    }
    if( requested->get_type() != sol::type::table ) {
        return game_handle_error{
            "invalid_options",
            std::string( api_name ) + " options must be a table"
        };
    }

    const sol::table options = requested->as<sol::table>();
    for( const auto &entry : options ) {
        if( entry.first.get_type() != sol::type::string ) {
            return game_handle_error{
                "invalid_options",
                std::string( api_name ) + " option keys must be strings"
            };
        }
        const std::string key = entry.first.as<std::string>();
        const sol::object value = entry.second;
        if( key == "mirror_horizontal" ||
            key == "mirror_vertical" ||
            key == "cancel_on_collision" ) {
            if( !value.is<bool>() ) {
                return game_handle_error{
                    "invalid_options",
                    std::string( api_name ) + " option '" + key +
                    "' must be a boolean"
                };
            }
            const bool enabled = value.as<bool>();
            if( key == "mirror_horizontal" ) {
                if( enabled ) {
                    return game_handle_error{
                        "unsupported_transform",
                        std::string( api_name ) +
                        " option 'mirror_horizontal' only supports false"
                    };
                }
                result.mirror_horizontal = enabled;
            } else if( key == "mirror_vertical" ) {
                if( enabled ) {
                    return game_handle_error{
                        "unsupported_transform",
                        std::string( api_name ) +
                        " option 'mirror_vertical' only supports false"
                    };
                }
                result.mirror_vertical = enabled;
            } else if( !enabled ) {
                return game_handle_error{
                    "invalid_options",
                    std::string( api_name ) +
                    " option 'cancel_on_collision' must be true"
                };
            }
        } else if( key == "rotation" ) {
            if( !value.is<lua_Integer>() ) {
                return game_handle_error{
                    "invalid_options",
                    std::string( api_name ) +
                    " option 'rotation' must be an integer"
                };
            }
            const lua_Integer rotation = value.as<lua_Integer>();
            if( rotation != 0 ) {
                return game_handle_error{
                    "unsupported_transform",
                    std::string( api_name ) +
                    " option 'rotation' only supports 0"
                };
            }
            result.rotation = static_cast<int>( rotation );
        } else {
            return game_handle_error{
                "invalid_options",
                std::string( api_name ) +
                " received unknown option '" + key + "'"
            };
        }
    }
    return std::nullopt;
}

bool mapgen_transaction_has_footprint(
    const platform_mapgen_transaction_footprint &footprint )
{
    return footprint.max_submap_x >= footprint.min_submap_x &&
           footprint.max_submap_y >= footprint.min_submap_y &&
           footprint.max_z >= footprint.min_z;
}

sol::table mapgen_transaction_footprint_value(
    sol::state_view state,
    const platform_mapgen_transaction_footprint &footprint )
{
    sol::table result = state.create_table();
    result["min_submap_x"] = footprint.min_submap_x;
    result["max_submap_x"] = footprint.max_submap_x;
    result["min_submap_y"] = footprint.min_submap_y;
    result["max_submap_y"] = footprint.max_submap_y;
    result["min_z"] = footprint.min_z;
    result["max_z"] = footprint.max_z;
    result["complete_omt_z_stack"] = footprint.complete_omt_z_stack;
    return result;
}

const char *mapgen_transaction_state_name(
    const platform_mapgen_transaction_state state )
{
    switch( state ) {
        case platform_mapgen_transaction_state::committed:
            return "committed";
        case platform_mapgen_transaction_state::rejected:
            return "rejected";
        case platform_mapgen_transaction_state::rolled_back:
            return "rolled_back";
        case platform_mapgen_transaction_state::rollback_failed:
            return "rollback_failed";
    }
    return "rejected";
}

sol::table mapgen_transaction_value(
    sol::state_view state,
    const overmap_tile_token &target,
    const mapgen_update_token &update,
    const platform_mapgen_transaction_report &report )
{
    sol::table value = state.create_table();
    value["state"] = mapgen_transaction_state_name( report.state );
    value["code"] = report.code;
    value["message"] = report.message;
    if( mapgen_transaction_has_footprint( report.footprint ) ) {
        value["footprint"] = mapgen_transaction_footprint_value(
                                  state, report.footprint );
    }
    value["target"] = target;
    value["update"] = update;
    return value;
}

sol::table mapgen_transaction_error(
    sol::state_view state,
    const overmap_tile_token &target,
    const mapgen_update_token &update,
    const platform_mapgen_transaction_report &report )
{
    sol::table result = make_game_error_result( state, {
        report.code.empty() ? "mapgen_rejected" : report.code,
        report.message
    } );
    result["error"]["state"] = mapgen_transaction_state_name( report.state );
    result["error"]["target"] = target;
    result["error"]["update"] = update;
    if( mapgen_transaction_has_footprint( report.footprint ) ) {
        result["error"]["footprint"] = mapgen_transaction_footprint_value(
                                             state, report.footprint );
    }
    return result;
}

sol::table apply_mapgen_update(
    sol::this_state lua,
    const sol::object &requested_target,
    const sol::object &requested_update,
    const sol::optional<sol::object> &requested_options,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation,
    std::function<void()> require_write )
{
    sol::state_view state( lua );
    if( !requested_target.is<overmap_tile_token>() ) {
        return make_game_error_result( state, {
            "invalid_target",
            "services.mapgen.apply requires an OvermapTileToken target"
        } );
    }
    const overmap_tile_token &target =
        requested_target.as<const overmap_tile_token &>();
    if( const std::optional<game_handle_error> error =
                validate_overmap_tile_token(
                    target, runtime_generation, world_generation ) ) {
        return make_game_error_result( state, *error );
    }

    if( !requested_update.is<mapgen_update_token>() ) {
        return make_game_error_result( state, {
            "invalid_update",
            "services.mapgen.apply requires a MapgenUpdateToken update"
        } );
    }
    const mapgen_update_token &update =
        requested_update.as<const mapgen_update_token &>();
    if( const std::optional<game_handle_error> error =
                validate_mapgen_update_token(
                    update, runtime_generation, world_generation ) ) {
        return make_game_error_result( state, *error );
    }

    mapgen_apply_options options;
    if( const std::optional<game_handle_error> error =
                read_mapgen_apply_options( requested_options, options ) ) {
        return make_game_error_result( state, *error );
    }

    platform_mapgen_transaction_footprint footprint;
    std::string preflight_error;
    if( !platform_transaction_safe( update.native_id(), target.native_position(),
                                     footprint, preflight_error ) ) {
        platform_mapgen_transaction_report report;
        report.state = platform_mapgen_transaction_state::rejected;
        report.code = "unsafe_operator";
        report.message = preflight_error;
        return mapgen_transaction_error( state, target, update, report );
    }

    require_write();
    platform_mapgen_transaction_report report;
    run_mapgen_update_func_transactional(
        update.native_id(), target.native_position(), {}, nullptr,
        options.cancel_on_collision, options.mirror_horizontal,
        options.mirror_vertical, options.rotation, std::nullopt,
        std::nullopt, &report );

    if( report.state == platform_mapgen_transaction_state::committed ) {
        set_queued_points();
        reality_bubble().invalidate_map_cache( target.native_position().z() );
        bump_map_mutation_epoch();
        notify_overmap_tile_mutation( target.native_position() );
        return make_game_value_result(
                   state, sol::make_object(
                       state, mapgen_transaction_value(
                           state, target, update, report ) ) );
    }

    if( report.state == platform_mapgen_transaction_state::rollback_failed ) {
        reality_bubble().invalidate_map_cache( target.native_position().z() );
        bump_map_mutation_epoch();
        notify_overmap_tile_mutation( target.native_position() );
    }

    return mapgen_transaction_error( state, target, update, report );
}

} // namespace

void install_mapgen_service_api(
    sol::table &services,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write )
{
    sol::state_view lua( services.lua_state() );
    lua.new_usertype<mapgen_update_token>(
        "MapgenUpdateToken", sol::no_constructor,
        "id", sol::property( &mapgen_update_token::id ),
        "runtime_generation",
        sol::property( &mapgen_update_token::runtime_generation ),
        "world_generation",
        sol::property( &mapgen_update_token::world_generation ),
        "owner_is_current", &mapgen_update_token::owner_is_current,
        "is_valid",
        [current_runtime_generation, current_world_generation, require_read](
            const mapgen_update_token &token ) {
        require_read();
        return !validate_mapgen_update_token(
                   token, current_runtime_generation(),
                   current_world_generation() ).has_value();
    },
    sol::meta_function::to_string,
    &mapgen_update_token::to_string,
    sol::meta_function::equal_to,
    []( const mapgen_update_token &lhs, const mapgen_update_token &rhs ) {
        return lhs == rhs;
    } );

    sol::object existing_mapgen = services["mapgen"];
    sol::table mapgen = existing_mapgen.is<sol::table>() ?
                        existing_mapgen.as<sol::table>() :
                        lua.create_table();
    mapgen.set_function(
        "update_token",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state state, const script_game_id &id ) {
        require_read();
        sol::state_view lua_state( state );
        if( id.kind() != "update_mapgen" || !id.is_valid() ||
            !has_update_mapgen_for( update_mapgen_id( id.value() ) ) ) {
            return make_game_error_result( lua_state, {
                "invalid_id",
                "services.mapgen.update_token requires an existing "
                "GameId<update_mapgen>"
            } );
        }
        const update_mapgen_id native_id( id.value() );
        return make_game_value_result(
                   lua_state,
                   sol::make_object(
                       lua_state,
                       mapgen_update_token(
                           native_id, current_runtime_generation(),
                           current_world_generation() ) ) );
    } );
    mapgen.set_function(
        "apply",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state state, sol::object target,
            sol::object update, sol::optional<sol::object> options ) {
        return apply_mapgen_update(
                   state, target, update, options,
                   current_runtime_generation(),
                   current_world_generation(), require_write );
    } );
    services["mapgen"] = std::move( mapgen );
}

namespace
{

constexpr std::int64_t minimum_direction_factor = -1000000;
constexpr std::int64_t maximum_direction_factor = 1000000;
constexpr int minimum_random_integer = -1000000000;
constexpr int maximum_random_integer = 1000000000;
constexpr std::array<std::string_view, 4> rotation_suffixes = {
    "_north", "_east", "_south", "_west"
};
static_assert( script_mapgen_context::map_width == SEEX * 2 );
static_assert( script_mapgen_context::map_height == SEEY * 2 );

void require_id_kind( const script_game_id &id, const std::string_view kind,
                      const std::string_view api_name )
{
    if( id.kind() != kind || !id.is_valid() ) {
        throw std::invalid_argument(
            std::string( api_name ) + " requires a valid GameId<" +
            std::string( kind ) + ">" );
    }
}

void require_mapgen_id( const std::string &id, const std::string_view api_name )
{
    if( id.empty() || id.size() > 256 ||
        id.find( '\0' ) != std::string::npos ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " id must contain 1 to 256 non-NUL bytes" );
    }
}

void require_rectangle( const int x1, const int y1, const int x2, const int y2,
                        const std::string_view api_name )
{
    if( x1 < 0 || y1 < 0 || x2 < x1 || y2 < y1 ||
        x2 >= script_mapgen_context::map_width ||
        y2 >= script_mapgen_context::map_height ) {
        throw std::out_of_range(
            std::string( api_name ) +
            " rectangle must stay within the current 24x24 OMT" );
    }
}

script_game_id overmap_terrain_id( const oter_id &id )
{
    return script_game_id( "overmap_terrain", id.id().str() );
}

} // namespace

struct script_mapgen_context::context_state {
    mapgendata *data = nullptr;
    bool allow_write = false;
    std::string platform_mod_id;
    std::uint64_t random_state = 0;
    std::size_t operations = 0;
};

script_mapgen_context::script_mapgen_context(
    mapgendata &data, const bool allow_write,
    const std::uint64_t deterministic_seed, std::string platform_mod_id )
    : state_( std::make_shared<context_state>() )
{
    state_->data = &data;
    state_->allow_write = allow_write;
    state_->random_state = deterministic_seed;
    state_->platform_mod_id = std::move( platform_mod_id );
}

bool script_mapgen_context::valid() const noexcept
{
    return state_ != nullptr && state_->data != nullptr;
}

void script_mapgen_context::invalidate() noexcept
{
    if( state_ != nullptr ) {
        state_->data = nullptr;
    }
}

script_mapgen_context::context_state &script_mapgen_context::require_state() const
{
    if( !valid() ) {
        throw std::runtime_error(
            "Lua mapgen context is no longer valid" );
    }
    return *state_;
}

script_mapgen_context::context_state &
script_mapgen_context::require_write_state() const
{
    context_state &state = require_state();
    if( !state.allow_write ) {
        throw std::runtime_error(
            "Lua mapgen mutation requires an active Platform write callback" );
    }
    return state;
}

[[noreturn]] void script_mapgen_context::reject_external_mutation() const
{
    throw std::runtime_error( "Lua mapgen external mutation is unsupported" );
}

void script_mapgen_context::consume( const std::size_t amount ) const
{
    context_state &state = require_state();
    if( amount > maximum_operations - state.operations ) {
        throw std::runtime_error(
            "Lua mapgen operation budget exceeded" );
    }
    state.operations += amount;
}

std::size_t script_mapgen_context::operations_used() const
{
    return require_state().operations;
}

std::size_t script_mapgen_context::operations_remaining() const
{
    return maximum_operations - require_state().operations;
}

script_game_id script_mapgen_context::id() const
{
    consume( 1 );
    return overmap_terrain_id(
               require_state().data->terrain_type() );
}

script_game_id script_mapgen_context::north() const
{
    return get_nesw( 0 );
}

script_game_id script_mapgen_context::east() const
{
    return get_nesw( 1 );
}

script_game_id script_mapgen_context::south() const
{
    return get_nesw( 2 );
}

script_game_id script_mapgen_context::west() const
{
    return get_nesw( 3 );
}

script_game_id script_mapgen_context::neast() const
{
    return get_nesw( 4 );
}

script_game_id script_mapgen_context::seast() const
{
    return get_nesw( 5 );
}

script_game_id script_mapgen_context::swest() const
{
    return get_nesw( 6 );
}

script_game_id script_mapgen_context::nwest() const
{
    return get_nesw( 7 );
}

script_game_id script_mapgen_context::above() const
{
    consume( 1 );
    return overmap_terrain_id(
               require_state().data->above() );
}

script_game_id script_mapgen_context::below() const
{
    consume( 1 );
    return overmap_terrain_id(
               require_state().data->below() );
}

script_game_id script_mapgen_context::get_nesw( const int index ) const
{
    if( index < 0 || index >= 8 ) {
        throw std::out_of_range(
            "Lua mapgen neighbor index must be within 0..7" );
    }
    consume( 1 );
    return overmap_terrain_id(
               require_state().data->t_nesw[
                static_cast<std::size_t>( index )] );
}

int script_mapgen_context::zlevel() const
{
    consume( 1 );
    return require_state().data->zlevel();
}

int script_mapgen_context::get_direction( const int index ) const
{
    if( index < 0 || index >= 8 ) {
        throw std::out_of_range(
            "Lua mapgen direction index must be within 0..7" );
    }
    consume( 1 );
    return require_state().data->dir( index );
}

void script_mapgen_context::set_dir( const int index, const int value )
{
    if( index < 0 || index >= 8 ) {
        throw std::out_of_range(
            "Lua mapgen direction index must be within 0..7" );
    }
    if( value < minimum_direction_factor ||
        value > maximum_direction_factor ) {
        throw std::out_of_range(
            "Lua mapgen direction value must be within "
            "-1000000..1000000" );
    }
    require_write_state();
    consume( 1 );
    require_state().data->set_dir( index, value );
}

int script_mapgen_context::get_rotation() const
{
    consume( 1 );
    return require_state().data->terrain_type()->get_rotation();
}

std::string script_mapgen_context::get_rot_suffix() const
{
    const int rotation = get_rotation();
    if( rotation < 0 ||
        rotation >= static_cast<int>( rotation_suffixes.size() ) ) {
        throw std::runtime_error(
            "Lua mapgen terrain has an invalid rotation" );
    }
    return std::string(
               rotation_suffixes[static_cast<std::size_t>( rotation )] );
}

std::uint64_t script_mapgen_context::next_random()
{
    context_state &state = require_state();
    state.random_state += UINT64_C( 0x9e3779b97f4a7c15 );
    std::uint64_t value = state.random_state;
    value = ( value ^ ( value >> 30 ) ) *
            UINT64_C( 0xbf58476d1ce4e5b9 );
    value = ( value ^ ( value >> 27 ) ) *
            UINT64_C( 0x94d049bb133111eb );
    return value ^ ( value >> 31 );
}

int script_mapgen_context::random_int( const int minimum, const int maximum )
{
    if( minimum < minimum_random_integer ||
        maximum > maximum_random_integer ||
        minimum > maximum ) {
        throw std::invalid_argument(
            "Lua mapgen random integer bounds must be ordered and "
            "within -1000000000..1000000000" );
    }
    consume( 1 );
    const std::uint64_t range =
        static_cast<std::uint64_t>(
            static_cast<std::int64_t>( maximum ) -
            static_cast<std::int64_t>( minimum ) ) + 1;
    const std::uint64_t threshold =
        static_cast<std::uint64_t>( -range ) % range;
    std::uint64_t value;
    do {
        value = next_random();
    } while( value < threshold );
    return static_cast<int>(
               static_cast<std::int64_t>( minimum ) +
               static_cast<std::int64_t>( value % range ) );
}

bool script_mapgen_context::random_chance(
    const std::uint64_t numerator, const std::uint64_t denominator )
{
    if( denominator == 0 || numerator > denominator ||
        denominator > UINT64_C( 1000000000 ) ) {
        throw std::invalid_argument(
            "Lua mapgen chance requires 0 <= numerator <= "
            "denominator <= 1000000000" );
    }
    consume( 1 );
    if( numerator == 0 ) {
        return false;
    }
    if( numerator == denominator ) {
        return true;
    }
    const std::uint64_t threshold =
        static_cast<std::uint64_t>( -denominator ) % denominator;
    std::uint64_t value;
    do {
        value = next_random();
    } while( value < threshold );
    return value % denominator < numerator;
}

namespace
{

template<typename State>
tripoint_bub_ms bounded_position(
    State &state,
    const int x, const int y )
{
    if( x < 0 || x >= script_mapgen_context::map_width ||
        y < 0 || y >= script_mapgen_context::map_height ) {
        throw std::out_of_range(
            "Lua mapgen coordinates must stay within the current "
            "24x24 OMT" );
    }
    const tripoint_bub_ms result(
        x, y, state.data->zlevel() );
    if( !state.data->m.inbounds( result ) ) {
        throw std::out_of_range(
            "Lua mapgen coordinate is outside the bound map" );
    }
    return result;
}

} // namespace

script_game_id script_mapgen_context::terrain_at(
    const int x, const int y ) const
{
    context_state &state = require_state();
    const tripoint_bub_ms position =
        bounded_position( state, x, y );
    consume( 1 );
    return script_game_id(
               "terrain", state.data->m.ter( position ).id().str() );
}

std::optional<script_game_id> script_mapgen_context::furniture_at(
    const int x, const int y ) const
{
    context_state &state = require_state();
    const tripoint_bub_ms position =
        bounded_position( state, x, y );
    consume( 1 );
    const furn_str_id id =
        state.data->m.furn( position ).id();
    if( id.is_null() ) {
        return std::nullopt;
    }
    return script_game_id( "furniture", id.str() );
}

std::optional<script_game_id> script_mapgen_context::trap_at(
    const int x, const int y ) const
{
    context_state &state = require_state();
    const tripoint_bub_ms position =
        bounded_position( state, x, y );
    consume( 1 );
    const trap_str_id id =
        state.data->m.tr_at( position ).id;
    if( id.is_null() ) {
        return std::nullopt;
    }
    return script_game_id( "trap", id.str() );
}

bool script_mapgen_context::set_terrain(
    const int x, const int y, const script_game_id &id )
{
    require_id_kind(
        id, "terrain", "Lua mapgen set_terrain" );
    context_state &state = require_write_state();
    const tripoint_bub_ms position =
        bounded_position( state, x, y );
    consume( 1 );
    return state.data->m.ter_set(
               position, ter_str_id( id.value() ).id() );
}

bool script_mapgen_context::set_furniture(
    const int x, const int y,
    const std::optional<script_game_id> &id )
{
    furn_id target = furn_str_id::NULL_ID().id();
    if( id ) {
        require_id_kind(
            *id, "furniture", "Lua mapgen set_furniture" );
        target = furn_str_id( id->value() ).id();
    }
    context_state &state = require_write_state();
    const tripoint_bub_ms position =
        bounded_position( state, x, y );
    consume( 1 );
    return state.data->m.furn_set( position, target );
}

bool script_mapgen_context::set_trap(
    const int x, const int y,
    const std::optional<script_game_id> &id )
{
    trap_id target = tr_null;
    if( id ) {
        require_id_kind(
            *id, "trap", "Lua mapgen set_trap" );
        target = trap_str_id( id->value() ).id();
    }
    context_state &state = require_write_state();
    const tripoint_bub_ms position =
        bounded_position( state, x, y );
    consume( 1 );
    state.data->m.trap_set( position, target );
    return state.data->m.tr_at( position ).id.id() == target;
}

bool script_mapgen_context::set_terrain_id(
    const int x, const int y, const std::string &id )
{
    require_mapgen_id( id, "Lua mapgen set_terrain_id" );
    const ter_str_id target( id );
    if( !target.is_valid() ) {
        throw std::invalid_argument(
            "Lua mapgen set_terrain_id received unknown terrain '" + id + "'" );
    }
    context_state &state = require_write_state();
    const tripoint_bub_ms position = bounded_position( state, x, y );
    consume( 1 );
    return state.data->m.ter_set( position, target.id() );
}

bool script_mapgen_context::set_furniture_id(
    const int x, const int y, const std::string &id )
{
    furn_id target = furn_str_id::NULL_ID().id();
    if( !id.empty() ) {
        require_mapgen_id( id, "Lua mapgen set_furniture_id" );
        const furn_str_id source( id );
        if( !source.is_valid() ) {
            throw std::invalid_argument(
                "Lua mapgen set_furniture_id received unknown furniture '" + id + "'" );
        }
        target = source.id();
    }
    context_state &state = require_write_state();
    const tripoint_bub_ms position = bounded_position( state, x, y );
    consume( 1 );
    return state.data->m.furn_set( position, target );
}

bool script_mapgen_context::set_trap_id(
    const int x, const int y, const std::string &id )
{
    trap_id target = tr_null;
    if( !id.empty() ) {
        require_mapgen_id( id, "Lua mapgen set_trap_id" );
        const trap_str_id source( id );
        if( !source.is_valid() ) {
            throw std::invalid_argument(
                "Lua mapgen set_trap_id received unknown trap '" + id + "'" );
        }
        target = source.id();
    }
    context_state &state = require_write_state();
    const tripoint_bub_ms position = bounded_position( state, x, y );
    consume( 1 );
    state.data->m.trap_set( position, target );
    return state.data->m.tr_at( position ).id.id() == target;
}

void script_mapgen_context::reset( const std::string &terrain_id )
{
    require_mapgen_id( terrain_id, "Lua mapgen reset" );
    const ter_str_id target( terrain_id );
    if( !target.is_valid() ) {
        throw std::invalid_argument(
            "Lua mapgen reset received unknown terrain '" + terrain_id + "'" );
    }
    context_state &state = require_write_state();
    consume( static_cast<std::size_t>( map_width ) * map_height );
    for( int y = 0; y < map_height; ++y ) {
        for( int x = 0; x < map_width; ++x ) {
            const tripoint_bub_ms position = bounded_position( state, x, y );
            state.data->m.i_clear( position );
            state.data->m.clear_fields( position );
            state.data->m.trap_set( position, tr_null );
            state.data->m.furn_set( position, furn_str_id::NULL_ID().id() );
            state.data->m.ter_set( position, target.id() );
        }
    }
}

void script_mapgen_context::place_item(
    const int x, const int y, const std::string &item_id,
    const int quantity, const int charges, const std::string &faction_id )
{
    require_mapgen_id( item_id, "Lua mapgen place_item" );
    const itype_id type( item_id );
    if( !item::type_is_defined( type ) ) {
        throw std::invalid_argument(
            "Lua mapgen place_item received unknown item '" + item_id + "'" );
    }
    if( quantity <= 0 || quantity > 10000 || charges < 0 ) {
        throw std::invalid_argument(
            "Lua mapgen place_item quantity or charges are outside native limits" );
    }
    context_state &state = require_write_state();
    const tripoint_bub_ms position = bounded_position( state, x, y );
    consume( static_cast<std::size_t>( quantity ) );
    state.data->m.spawn_item(
        position, type, static_cast<unsigned>( quantity ), charges,
        calendar::start_of_cataclysm, 0, {}, "", faction_id );
}

void script_mapgen_context::place_item_group(
    const int x1, const int y1, const int x2, const int y2,
    const std::string &group_id, const int chance,
    const std::string &faction_id )
{
    require_rectangle( x1, y1, x2, y2, "Lua mapgen place_item_group" );
    require_mapgen_id( group_id, "Lua mapgen place_item_group" );
    const item_group_id group( group_id );
    if( !item_group::group_is_defined( group ) || chance <= 0 || chance > 100 ) {
        throw std::invalid_argument(
            "Lua mapgen place_item_group requires a known group and chance from 1 to 100" );
    }
    context_state &state = require_write_state();
    const tripoint_bub_ms start = bounded_position( state, x1, y1 );
    const tripoint_bub_ms end = bounded_position( state, x2, y2 );
    consume( static_cast<std::size_t>( x2 - x1 + 1 ) *
             static_cast<std::size_t>( y2 - y1 + 1 ) );
    state.data->m.place_items( group, chance, start, end, true,
                               calendar::start_of_cataclysm, 0, 0, faction_id );
}

void script_mapgen_context::place_liquid(
    const int x, const int y, const std::string &item_id, const int charges )
{
    if( charges <= 0 ) {
        throw std::invalid_argument( "Lua mapgen liquid charges must be positive" );
    }
    place_item( x, y, item_id, 1, charges, "" );
}

void script_mapgen_context::place_toilet(
    const int x, const int y, const int charges )
{
    if( charges < 0 ) {
        throw std::invalid_argument( "Lua mapgen toilet charges cannot be negative" );
    }
    context_state &state = require_write_state();
    const tripoint_bub_ms position = bounded_position( state, x, y );
    consume( 1 );
    if( charges == 0 ) {
        state.data->m.place_toilet( position );
    } else {
        state.data->m.place_toilet( position, charges );
    }
}

bool script_mapgen_context::add_field(
    const int x, const int y, const std::string &field_id,
    const int intensity, const std::int64_t age_turns )
{
    require_mapgen_id( field_id, "Lua mapgen add_field" );
    const field_type_str_id source( field_id );
    if( !source.is_valid() || intensity <= 0 || intensity > 100 ||
        age_turns < 0 || age_turns > INT64_C( 1000000000000 ) ) {
        throw std::invalid_argument(
            "Lua mapgen add_field received an unknown field or invalid intensity/age" );
    }
    context_state &state = require_write_state();
    const tripoint_bub_ms position = bounded_position( state, x, y );
    consume( 1 );
    return state.data->m.add_field(
               position, source.id(), intensity,
               time_duration::from_turns( age_turns ), false );
}

bool script_mapgen_context::remove_field(
    const int x, const int y, const std::string &field_id )
{
    require_mapgen_id( field_id, "Lua mapgen remove_field" );
    const field_type_str_id source( field_id );
    if( !source.is_valid() ) {
        throw std::invalid_argument(
            "Lua mapgen remove_field received unknown field '" + field_id + "'" );
    }
    context_state &state = require_write_state();
    const tripoint_bub_ms position = bounded_position( state, x, y );
    consume( 1 );
    const field_type_id type = source.id();
    const bool existed = state.data->m.get_field( position, type ) != nullptr;
    state.data->m.remove_field( position, type );
    return existed;
}

void script_mapgen_context::place_vending_machine(
    const int x, const int y, const std::string &item_group_name,
    const bool reinforced, const bool lootable,
    const bool powered, const bool networked )
{
    require_mapgen_id( item_group_name, "Lua mapgen place_vending_machine" );
    const item_group_id group( item_group_name );
    if( !item_group::group_is_defined( group ) ) {
        throw std::invalid_argument(
            "Lua mapgen place_vending_machine received unknown item group '" +
            item_group_name + "'" );
    }
    context_state &state = require_write_state();
    const tripoint_bub_ms position = bounded_position( state, x, y );
    consume( 1 );
    state.data->m.furn_set( position, furn_str_id::NULL_ID().id() );
    state.data->m.place_vending(
        position, group, reinforced, lootable, powered, networked );
}

void script_mapgen_context::place_gas_pump(
    const int x, const int y, const int charges,
    const std::string &fuel_id )
{
    if( charges <= 0 || charges > 1000000000 ) {
        throw std::invalid_argument(
            "Lua mapgen gas pump charges must be within 1..1000000000" );
    }
    std::optional<itype_id> fuel;
    if( !fuel_id.empty() ) {
        require_mapgen_id( fuel_id, "Lua mapgen place_gas_pump" );
        fuel.emplace( fuel_id );
        if( !item::type_is_defined( *fuel ) ) {
            throw std::invalid_argument(
                "Lua mapgen place_gas_pump received unknown fuel '" + fuel_id + "'" );
        }
    }
    context_state &state = require_write_state();
    const tripoint_bub_ms position = bounded_position( state, x, y );
    consume( 1 );
    state.data->m.furn_set( position, furn_str_id::NULL_ID().id() );
    if( fuel ) {
        state.data->m.place_gas_pump( position, charges, *fuel );
    } else {
        state.data->m.place_gas_pump( position, charges );
    }
}

void script_mapgen_context::place_monster_group(
    const int x1, const int y1, const int x2, const int y2,
    const std::string &group_id, const int chance, const double density,
    const bool individual, const bool friendly, const std::string &name,
    const bool mission_target )
{
    require_rectangle( x1, y1, x2, y2,
                       "Lua mapgen place_monster_group" );
    require_mapgen_id( group_id, "Lua mapgen place_monster_group" );
    const mongroup_id group( group_id );
    if( !group.is_valid() || chance <= 0 || chance > 1000000 ||
        !std::isfinite( density ) || density < -1.0 || density > 1000000.0 ||
        name.size() > 4096 || name.find( '\0' ) != std::string::npos ) {
        throw std::invalid_argument(
            "Lua mapgen place_monster_group received invalid group, chance, density, or name" );
    }
    context_state &state = require_write_state();
    consume( static_cast<std::size_t>( x2 - x1 + 1 ) *
             static_cast<std::size_t>( y2 - y1 + 1 ) );
    int mission_id = -1;
    if( mission_target && state.data->mission() != nullptr ) {
        mission_id = state.data->mission()->get_id();
    }
    const float selected_density = density < 0.0 ?
                                   state.data->monster_density() : static_cast<float>( density );
    state.data->m.place_spawns(
        group, chance, point_bub_ms( x1, y1 ), point_bub_ms( x2, y2 ),
        state.data->zlevel(), selected_density, individual, friendly,
        name.empty() ? std::nullopt : std::optional<std::string>( name ),
        mission_id );
}

void script_mapgen_context::place_monster(
    const int x, const int y, const std::string &monster_id,
    const int count, const bool friendly, const std::string &name,
    const bool mission_target )
{
    require_mapgen_id( monster_id, "Lua mapgen place_monster" );
    const mtype_id type( monster_id );
    if( !type.is_valid() || count <= 0 || count > 10000 ||
        name.size() > 4096 || name.find( '\0' ) != std::string::npos ) {
        throw std::invalid_argument(
            "Lua mapgen place_monster received invalid monster, count, or name" );
    }
    context_state &state = require_write_state();
    const tripoint_bub_ms position = bounded_position( state, x, y );
    consume( static_cast<std::size_t>( count ) );
    int mission_id = -1;
    if( mission_target && state.data->mission() != nullptr ) {
        mission_id = state.data->mission()->get_id();
    }
    state.data->m.add_spawn(
        type, count, position, friendly, -1, mission_id,
        name.empty() ? std::nullopt : std::optional<std::string>( name ) );
}

void script_mapgen_context::place_corpse(
    const int x, const int y, const std::string &monster_id,
    const int age_days )
{
    require_mapgen_id( monster_id, "Lua mapgen place_corpse" );
    const mtype_id type( monster_id );
    if( !type.is_valid() || age_days < 0 || age_days > 1000000 ) {
        throw std::invalid_argument(
            "Lua mapgen place_corpse received invalid monster or age" );
    }
    context_state &state = require_write_state();
    const tripoint_bub_ms position = bounded_position( state, x, y );
    consume( 1 );
    item corpse = item::make_corpse(
                      type, std::max( calendar::turn - time_duration::from_days( age_days ),
                                     calendar::start_of_cataclysm ) );
    state.data->m.add_item_or_charges( position, corpse );
}

void script_mapgen_context::place_corpse_from_group(
    const int x, const int y, const std::string &group_id,
    const int age_days )
{
    require_mapgen_id( group_id, "Lua mapgen place_corpse_from_group" );
    const mongroup_id group( group_id );
    if( !group.is_valid() || age_days < 0 || age_days > 1000000 ) {
        throw std::invalid_argument(
            "Lua mapgen place_corpse_from_group received invalid group or age" );
    }
    const std::vector<mtype_id> types =
        MonsterGroupManager::GetMonstersFromGroup( group, true );
    if( types.empty() ) {
        return;
    }
    const int selected = random_int( 0, static_cast<int>( types.size() ) - 1 );
    place_corpse( x, y, types[static_cast<std::size_t>( selected )].str(), age_days );
}

void script_mapgen_context::make_rubble(
    const int x, const int y, const std::string &furniture_id,
    const bool items, const std::string &floor_terrain_id,
    const bool overwrite )
{
    const std::string rubble_name = furniture_id.empty() ? "f_rubble" : furniture_id;
    const std::string floor_name = floor_terrain_id.empty() ? "t_dirt" : floor_terrain_id;
    const furn_str_id rubble( rubble_name );
    const ter_str_id floor( floor_name );
    if( !rubble.is_valid() || !floor.is_valid() ) {
        throw std::invalid_argument(
            "Lua mapgen make_rubble received unknown furniture or terrain" );
    }
    context_state &state = require_write_state();
    const tripoint_bub_ms position = bounded_position( state, x, y );
    consume( 1 );
    state.data->m.make_rubble(
        position, rubble.id(), items, floor.id(), overwrite );
}

bool script_mapgen_context::place_computer(
    const int x, const int y, const std::string &name,
    const int security, const std::string &access_denied,
    const bool mission_target )
{
    if( name.empty() || name.size() > 4096 || name.find( '\0' ) != std::string::npos ||
        access_denied.size() > 4096 || access_denied.find( '\0' ) != std::string::npos ||
        security < -1000000 || security > 1000000 ) {
        throw std::invalid_argument(
            "Lua mapgen computer name, access message, or security is invalid" );
    }
    context_state &state = require_write_state();
    const tripoint_bub_ms position = bounded_position( state, x, y );
    consume( 1 );
    state.data->m.furn_set( position, furn_str_id( "f_console" ).id() );
    computer *const placed = state.data->m.add_computer( position, name, security );
    if( placed == nullptr ) {
        return false;
    }
    if( !access_denied.empty() ) {
        placed->set_access_denied_msg( access_denied );
    }
    if( mission_target && state.data->mission() != nullptr ) {
        placed->set_mission( state.data->mission()->get_id() );
    }
    return true;
}

void script_mapgen_context::add_computer_option(
    const int x, const int y, const std::string &name,
    const std::string &action, const int security )
{
    const std::optional<computer_action> parsed =
        computer_action_from_ident( action );
    if( name.empty() || name.size() > 4096 || name.find( '\0' ) != std::string::npos ||
        !parsed || security < -1000000 || security > 1000000 ) {
        throw std::invalid_argument(
            "Lua mapgen computer option name, action, or security is invalid" );
    }
    context_state &state = require_write_state();
    const tripoint_bub_ms position = bounded_position( state, x, y );
    consume( 1 );
    computer *const target = state.data->m.computer_at( position );
    if( target == nullptr ) {
        throw std::runtime_error( "Lua mapgen computer option has no computer at target" );
    }
    target->add_option( name, *parsed, security );
}

void script_mapgen_context::add_computer_failure(
    const int x, const int y, const std::string &failure )
{
    const std::optional<computer_failure_type> parsed =
        computer_failure_from_ident( failure );
    if( !parsed ) {
        throw std::invalid_argument(
            "Lua mapgen computer failure id is invalid" );
    }
    context_state &state = require_write_state();
    const tripoint_bub_ms position = bounded_position( state, x, y );
    consume( 1 );
    computer *const target = state.data->m.computer_at( position );
    if( target == nullptr ) {
        throw std::runtime_error( "Lua mapgen computer failure has no computer at target" );
    }
    target->add_failure( *parsed );
}

void script_mapgen_context::add_computer_eoc(
    const int x, const int y, const std::string &eoc_id )
{
    require_mapgen_id( eoc_id, "Lua mapgen add_computer_eoc" );
    const effect_on_condition_id eoc( eoc_id );
    if( !eoc.is_valid() ) {
        throw std::invalid_argument(
            "Lua mapgen add_computer_eoc received unknown EOC '" + eoc_id + "'" );
    }
    context_state &state = require_write_state();
    const tripoint_bub_ms position = bounded_position( state, x, y );
    consume( 1 );
    computer *const target = state.data->m.computer_at( position );
    if( target == nullptr ) {
        throw std::runtime_error( "Lua mapgen computer EOC has no computer at target" );
    }
    target->add_eoc( eoc );
}

void script_mapgen_context::set_computer_access_handler(
    const int x, const int y, const std::string &handler_id )
{
    require_mapgen_id( handler_id, "Lua mapgen set_computer_access_handler" );
    context_state &state = require_write_state();
    if( state.platform_mod_id.empty() ) {
        throw std::runtime_error(
            "Lua mapgen computer handlers require a Lua-first Platform owner" );
    }
    const tripoint_bub_ms position = bounded_position( state, x, y );
    consume( 1 );
    computer *const target = state.data->m.computer_at( position );
    if( target == nullptr ) {
        throw std::runtime_error(
            "Lua mapgen computer handler has no computer at target" );
    }
    target->set_platform_access_handler( state.platform_mod_id, handler_id );
}

void script_mapgen_context::add_computer_chat_topic(
    const int x, const int y, const std::string &topic_id )
{
    require_mapgen_id( topic_id, "Lua mapgen add_computer_chat_topic" );
    context_state &state = require_write_state();
    const tripoint_bub_ms position = bounded_position( state, x, y );
    consume( 1 );
    computer *const target = state.data->m.computer_at( position );
    if( target == nullptr ) {
        throw std::runtime_error( "Lua mapgen computer topic has no computer at target" );
    }
    target->add_chat_topic( topic_id );
}

void script_mapgen_context::place_sealed_item(
    const int x, const int y, const std::string &furniture_id,
    const std::string &item_id, const int quantity, const int charges,
    const std::string &item_group_name, const int item_group_chance,
    const std::string &faction_id )
{
    require_mapgen_id( furniture_id, "Lua mapgen place_sealed_item" );
    const furn_str_id furniture( furniture_id );
    if( !furniture.is_valid() || ( item_id.empty() && item_group_name.empty() ) ||
        quantity < 0 || quantity > 10000 || charges < 0 ||
        item_group_chance <= 0 || item_group_chance > 100 ) {
        throw std::invalid_argument(
            "Lua mapgen sealed item furniture, content, quantity, charges, or chance is invalid" );
    }
    std::optional<itype_id> item_type;
    if( !item_id.empty() ) {
        require_mapgen_id( item_id, "Lua mapgen place_sealed_item item" );
        item_type.emplace( item_id );
        if( !item::type_is_defined( *item_type ) || quantity == 0 ) {
            throw std::invalid_argument(
                "Lua mapgen sealed item received an unknown item or zero quantity" );
        }
    }
    std::optional<item_group_id> group;
    if( !item_group_name.empty() ) {
        require_mapgen_id( item_group_name, "Lua mapgen place_sealed_item group" );
        group.emplace( item_group_name );
        if( !item_group::group_is_defined( *group ) ) {
            throw std::invalid_argument(
                "Lua mapgen sealed item received an unknown item group" );
        }
    }
    context_state &state = require_write_state();
    const tripoint_bub_ms position = bounded_position( state, x, y );
    const std::size_t cost = item_type ? static_cast<std::size_t>( quantity ) : 1;
    consume( cost + ( group ? 1 : 0 ) );
    state.data->m.furn_set( position, furn_str_id::NULL_ID().id() );
    if( item_type ) {
        state.data->m.spawn_item(
            position, *item_type, static_cast<unsigned>( quantity ), charges,
            calendar::start_of_cataclysm, 0, {}, "", faction_id );
    }
    if( group ) {
        state.data->m.place_items(
            *group, item_group_chance, position, position, true,
            calendar::start_of_cataclysm, 0, 0, faction_id );
    }
    state.data->m.furn_set( position, furniture.id() );
}

void script_mapgen_context::place_sign(
    const int x, const int y, const std::string &text,
    const std::string &furniture_id )
{
    if( text.empty() || text.size() > 4096 || text.find( '\0' ) != std::string::npos ) {
        throw std::invalid_argument( "Lua mapgen sign text is invalid" );
    }
    const std::string target_id = furniture_id.empty() ? "f_sign" : furniture_id;
    const furn_str_id target( target_id );
    if( !target.is_valid() ) {
        throw std::invalid_argument(
            "Lua mapgen place_sign received unknown furniture '" + target_id + "'" );
    }
    context_state &state = require_write_state();
    const tripoint_bub_ms position = bounded_position( state, x, y );
    consume( 1 );
    state.data->m.furn_set( position, target.id() );
    state.data->m.set_signage( position, text );
}

void script_mapgen_context::set_graffiti(
    const int x, const int y, const std::string &text )
{
    if( text.size() > 4096 || text.find( '\0' ) != std::string::npos ) {
        throw std::invalid_argument( "Lua mapgen graffiti text is invalid" );
    }
    context_state &state = require_write_state();
    const tripoint_bub_ms position = bounded_position( state, x, y );
    consume( 1 );
    if( text.empty() ) {
        state.data->m.delete_graffiti( position );
    } else {
        state.data->m.set_graffiti( position, text );
    }
}

[[noreturn]] void script_mapgen_context::place_zone(
    const int, const int, const int, const int,
    const std::string &, const std::string &,
    const std::string &, const std::string & )
{
    reject_external_mutation();
}

[[noreturn]] std::int64_t script_mapgen_context::place_npc(
    const int, const int, const std::string &,
    const std::string & )
{
    reject_external_mutation();
}

[[noreturn]] std::int64_t script_mapgen_context::place_npc_configured(
    const int, const int, const std::string &,
    const std::string &, const std::vector<std::string> &, const bool )
{
    reject_external_mutation();
}

[[noreturn]] bool script_mapgen_context::place_vehicle(
    const int, const int, const std::string &,
    const int, const int, const int, const std::string & )
{
    reject_external_mutation();
}

[[noreturn]] void script_mapgen_context::apply_faction_ownership(
    const int, const int, const int, const int,
    const std::string & )
{
    reject_external_mutation();
}

[[noreturn]] void script_mapgen_context::transform(
    const int, const int, const int, const int,
    const std::string & )
{
    reject_external_mutation();
}

[[noreturn]] std::size_t script_mapgen_context::remove_vehicles(
    const int, const int, const int, const int,
    const std::vector<std::string> & )
{
    reject_external_mutation();
}

[[noreturn]] std::size_t script_mapgen_context::remove_npcs(
    const std::string &, const std::string & )
{
    reject_external_mutation();
}

[[noreturn]] void script_mapgen_context::remove_all(
    const int, const int, const int, const int )
{
    reject_external_mutation();
}

void script_mapgen_context::queue_point(
    const std::string &name, const int x, const int y )
{
    require_mapgen_id( name, "Lua mapgen queue_point" );
    context_state &state = require_write_state();
    const tripoint_bub_ms position = bounded_position( state, x, y );
    consume( 1 );
    queue_mapgen_point( name, state.data->m.get_abs( position ) );
}

void script_mapgen_context::fill_groundcover()
{
    context_state &state = require_write_state();
    consume(
        static_cast<std::size_t>( map_width ) *
        static_cast<std::size_t>( map_height ) );
    state.data->fill_groundcover();
}

[[noreturn]] void script_mapgen_context::nest(
    const std::string &, const int, const int )
{
    reject_external_mutation();
}

[[noreturn]] void script_mapgen_context::generate( const std::string & )
{
    reject_external_mutation();
}

void install_script_mapgen_context_api( sol::state &lua )
{
    lua.new_usertype<script_mapgen_context>(
        "ScriptMapgenContext", sol::no_constructor,
        "valid", &script_mapgen_context::valid,
        "operations_used", &script_mapgen_context::operations_used,
        "operations_remaining", &script_mapgen_context::operations_remaining,
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
        "set_terrain_id", &script_mapgen_context::set_terrain_id,
        "set_furniture_id", &script_mapgen_context::set_furniture_id,
        "set_trap_id", &script_mapgen_context::set_trap_id,
        "reset", &script_mapgen_context::reset,
        "place_item", &script_mapgen_context::place_item,
        "place_item_group", &script_mapgen_context::place_item_group,
        "place_liquid", &script_mapgen_context::place_liquid,
        "place_toilet", &script_mapgen_context::place_toilet,
        "add_field", &script_mapgen_context::add_field,
        "remove_field", &script_mapgen_context::remove_field,
        "place_vending_machine", &script_mapgen_context::place_vending_machine,
        "place_gas_pump", &script_mapgen_context::place_gas_pump,
        "place_monster_group", &script_mapgen_context::place_monster_group,
        "place_monster", &script_mapgen_context::place_monster,
        "place_corpse", &script_mapgen_context::place_corpse,
        "place_corpse_from_group", &script_mapgen_context::place_corpse_from_group,
        "make_rubble", &script_mapgen_context::make_rubble,
        "place_computer", &script_mapgen_context::place_computer,
        "add_computer_option", &script_mapgen_context::add_computer_option,
        "add_computer_failure", &script_mapgen_context::add_computer_failure,
        "add_computer_eoc", &script_mapgen_context::add_computer_eoc,
        "set_computer_access_handler",
        &script_mapgen_context::set_computer_access_handler,
        "add_computer_chat_topic", &script_mapgen_context::add_computer_chat_topic,
        "place_sealed_item", &script_mapgen_context::place_sealed_item,
        "place_sign", &script_mapgen_context::place_sign,
        "set_graffiti", &script_mapgen_context::set_graffiti,
        "queue_point", &script_mapgen_context::queue_point,
        "fill_groundcover", &script_mapgen_context::fill_groundcover );
}

} // namespace cata::lua_platform

#endif // CATA_ENABLE_LUA_PLATFORM
