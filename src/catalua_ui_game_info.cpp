#include "catalua_ui_game_info.h"

#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <stdexcept>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

#include "lightmap.h"
#include "messages.h"
#include "rng.h"
#include "units.h"
#include "weather.h"

namespace cata::lua_ui
{

namespace
{

constexpr std::int64_t default_message_limit = 20;
constexpr std::int64_t maximum_message_limit = 256;
constexpr std::size_t maximum_message_bytes = 8192;
constexpr std::int64_t minimum_random_integer = -1000000000;
constexpr std::int64_t maximum_random_integer = 1000000000;
constexpr std::int64_t maximum_random_denominator = 1000000000;

void require_active_callback(
    const std::function<bool()> &has_active_callback,
    const std::string_view api_name )
{
    if( !has_active_callback() ) {
        throw std::runtime_error(
            std::string( api_name ) +
            " is only available from an active callback" );
    }
}

std::size_t message_limit(
    const sol::optional<std::int64_t> &requested )
{
    const std::int64_t value =
        requested.value_or( default_message_limit );
    if( value < 0 || value > maximum_message_limit ) {
        throw std::invalid_argument(
            "game.messages.recent limit must be within 0..256" );
    }
    return static_cast<std::size_t>( value );
}

sol::table recent_messages(
    sol::this_state lua,
    const sol::optional<std::int64_t> &requested )
{
    const std::size_t limit = message_limit( requested );
    const std::size_t total = Messages::size();
    const std::vector<std::pair<std::string, std::string>> entries =
                limit == 0 ?
                std::vector<std::pair<std::string, std::string>>() :
                Messages::recent_messages( limit );

    sol::state_view state( lua );
    sol::table items = state.create_table(
                           static_cast<int>( entries.size() ), 0 );
    for( std::size_t index = 0; index < entries.size(); ++index ) {
        sol::table entry = state.create_table();
        entry["time"] = entries[index].first;
        entry["text"] = entries[index].second;
        items[index + 1] = std::move( entry );
    }

    sol::table result = state.create_table();
    result["items"] = std::move( items );
    result["total"] = total;
    result["returned"] = entries.size();
    result["limit"] = limit;
    result["truncated"] = entries.size() < total;
    return result;
}

game_message_type message_type_from_name( const std::string_view name )
{
    if( name == "good" ) {
        return m_good;
    }
    if( name == "bad" ) {
        return m_bad;
    }
    if( name == "mixed" ) {
        return m_mixed;
    }
    if( name == "warning" ) {
        return m_warning;
    }
    if( name == "info" ) {
        return m_info;
    }
    if( name == "neutral" ) {
        return m_neutral;
    }
    if( name == "debug" ) {
        return m_debug;
    }
    if( name == "headshot" ) {
        return m_headshot;
    }
    if( name == "critical" ) {
        return m_critical;
    }
    if( name == "grazing" ) {
        return m_grazing;
    }
    throw std::invalid_argument(
        "game.messages.add received unknown message type '" +
        std::string( name ) + "'" );
}

void add_script_message(
    const std::string &message,
    const sol::optional<std::string> &requested_type )
{
    if( message.size() > maximum_message_bytes ) {
        throw std::invalid_argument(
            "game.messages.add message exceeds 8192 bytes" );
    }
    const game_message_type type = message_type_from_name(
                                       requested_type.value_or( "neutral" ) );
    ::add_msg( game_message_params( type ), message );
}

sol::table constants_snapshot( sol::this_state lua )
{
    sol::state_view state( lua );
    sol::table body_temperature = state.create_table();
    body_temperature["cold_c"] = units::to_celsius( BODYTEMP_COLD );
    body_temperature["normal_c"] = units::to_celsius( BODYTEMP_NORM );
    body_temperature["hot_c"] = units::to_celsius( BODYTEMP_HOT );

    sol::table lighting = state.create_table();
    lighting["ambient_lit"] = LIGHT_AMBIENT_LIT;

    sol::table result = state.create_table();
    result["body_temperature"] = std::move( body_temperature );
    result["lighting"] = std::move( lighting );
    return result;
}

int random_integer(
    const std::int64_t minimum,
    const std::int64_t maximum )
{
    if( minimum < minimum_random_integer ||
        maximum > maximum_random_integer ||
        minimum > maximum ) {
        throw std::invalid_argument(
            "game.random.int requires an ordered range within "
            "-1000000000..1000000000" );
    }
    return rng( static_cast<int>( minimum ), static_cast<int>( maximum ) );
}

bool random_chance(
    const std::int64_t numerator,
    const std::int64_t denominator )
{
    if( denominator <= 0 ||
        denominator > maximum_random_denominator ||
        numerator < 0 ||
        numerator > denominator ) {
        throw std::invalid_argument(
            "game.random.chance requires 0 <= numerator <= denominator "
            "<= 1000000000" );
    }
    return x_in_y(
               static_cast<double>( numerator ),
               static_cast<double>( denominator ) );
}

} // namespace

void install_game_info_api(
    sol::table &game,
    std::function<void()> require_read,
    std::function<void()> require_actions,
    std::function<bool()> has_active_callback )
{
    sol::state_view state( game.lua_state() );

    sol::table messages = state.create_table();
    messages.set_function(
        "recent",
        [require_read](
            sol::this_state lua,
    const sol::optional<std::int64_t> &limit ) {
        require_read();
        return recent_messages( lua, limit );
    } );
    messages.set_function(
        "add",
        [require_actions, has_active_callback](
            const std::string & message,
    const sol::optional<std::string> &type ) {
        require_actions();
        require_active_callback(
            has_active_callback, "game.messages.add" );
        add_script_message( message, type );
    } );
    game["messages"] = std::move( messages );

    sol::table constants = state.create_table();
    constants.set_function(
        "snapshot",
    [require_read]( sol::this_state lua ) {
        require_read();
        return constants_snapshot( lua );
    } );
    game["constants"] = std::move( constants );

    sol::table random = state.create_table();
    random.set_function(
        "int",
        [require_read, has_active_callback](
            const std::int64_t minimum,
    const std::int64_t maximum ) {
        require_read();
        require_active_callback(
            has_active_callback, "game.random.int" );
        return random_integer( minimum, maximum );
    } );
    random.set_function(
        "chance",
        [require_read, has_active_callback](
            const std::int64_t numerator,
    const std::int64_t denominator ) {
        require_read();
        require_active_callback(
            has_active_callback, "game.random.chance" );
        return random_chance( numerator, denominator );
    } );
    game["random"] = std::move( random );
}

} // namespace cata::lua_ui
