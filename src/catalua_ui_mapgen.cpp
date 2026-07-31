#if CATA_ENABLE_LUA_UI

#include "catalua_ui_mapgen.h"

#include <algorithm>
#include <array>
#include <limits>
#include <stdexcept>
#include <string_view>

#include "game_constants.h"
#include "map.h"
#include "mapgen.h"
#include "mapgen_functions.h"
#include "mapgendata.h"
#include "omdata.h"
#include "point.h"
#include "trap.h"
#include "type_id.h"

namespace cata::lua_ui
{

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

script_game_id overmap_terrain_id( const oter_id &id )
{
    return script_game_id( "overmap_terrain", id.id().str() );
}

} // namespace

struct script_mapgen_context::context_state {
    mapgendata *data = nullptr;
    bool allow_write = false;
    std::uint64_t random_state = 0;
    std::size_t operations = 0;
    std::size_t nested_generators = 0;
    std::size_t full_generators = 0;
};

script_mapgen_context::script_mapgen_context(
    mapgendata &data, const bool allow_write,
    const std::uint64_t deterministic_seed )
    : state_( std::make_shared<context_state>() )
{
    state_->data = &data;
    state_->allow_write = allow_write;
    state_->random_state = deterministic_seed;
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
            "Lua mapgen mutation requires capability 'game.write'" );
    }
    return state;
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

void script_mapgen_context::fill_groundcover()
{
    context_state &state = require_write_state();
    consume(
        static_cast<std::size_t>( map_width ) *
        static_cast<std::size_t>( map_height ) );
    state.data->fill_groundcover();
}

void script_mapgen_context::nest(
    const std::string &id, const int x, const int y )
{
    require_mapgen_id( id, "Lua mapgen nest" );
    context_state &state = require_write_state();
    if( state.nested_generators >= maximum_nested_generators ) {
        throw std::runtime_error(
            "Lua mapgen nested generator limit reached" );
    }
    const auto found =
        nested_mapgens.find( nested_mapgen_id( id ) );
    if( found == nested_mapgens.end() ||
        found->second.funcs().empty() ) {
        throw std::invalid_argument(
            "Lua mapgen received an unknown nested generator id" );
    }

    std::size_t operation_cost = 64;
    for( const auto &entry : found->second.funcs() ) {
        if( entry.first == nullptr ) {
            continue;
        }
        const point_rel_ms size =
            entry.first->get_mapgensize();
        if( size.x() <= 0 || size.y() <= 0 ||
            x < 0 || y < 0 ||
            x + size.x() > map_width ||
            y + size.y() > map_height ) {
            throw std::out_of_range(
                "Lua nested mapgen must fit entirely within the "
                "current 24x24 OMT" );
        }
        operation_cost = std::max(
                             operation_cost,
                             static_cast<std::size_t>( size.x() ) *
                             static_cast<std::size_t>( size.y() ) );
    }
    consume( operation_cost );

    const std::shared_ptr<mapgen_function_json_nested> *selected =
        found->second.funcs().pick(
            static_cast<unsigned int>( next_random() ) );
    if( selected == nullptr || *selected == nullptr ) {
        throw std::runtime_error(
            "Lua nested mapgen has no selectable generator" );
    }
    ++state.nested_generators;
    ( *selected )->nest(
        *state.data, tripoint_rel_ms( x, y, 0 ),
        "Lua mapgen callback" );
}

void script_mapgen_context::generate( const std::string &id )
{
    require_mapgen_id( id, "Lua mapgen generate" );
    context_state &state = require_write_state();
    if( state.full_generators >= maximum_full_generators ) {
        throw std::runtime_error(
            "Lua mapgen full generator limit reached" );
    }
    if( !has_mapgen_for( id ) ) {
        throw std::invalid_argument(
            "Lua mapgen received an unknown full generator id" );
    }
    consume(
        static_cast<std::size_t>( map_width ) *
        static_cast<std::size_t>( map_height ) * 2 );
    ++state.full_generators;
    if( !run_mapgen_func( id, *state.data ) ) {
        throw std::runtime_error(
            "Lua mapgen full generator had no selectable implementation" );
    }
    resolve_regional_terrain_and_furniture( *state.data );
}

} // namespace cata::lua_ui

#endif // CATA_ENABLE_LUA_UI
