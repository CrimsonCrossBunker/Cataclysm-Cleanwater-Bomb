#if CATA_ENABLE_LUA_UI

#include "catalua_ui_game_info.h"

#include <algorithm>
#include <array>
#include <cstddef>
#include <cstdint>
#include <stdexcept>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

#include "avatar.h"
#include "game.h"
#include "lightmap.h"
#include "messages.h"
#include "type_id.h"
#include "worldfactory.h"
#include "rng.h"
#include "units.h"
#include "weather.h"
#include "widget.h"

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

void validate_mod_id_text(
    const std::string &id, const std::string_view api_name )
{
    if( id.empty() || id.size() > 256 ||
        std::any_of( id.begin(), id.end(),
    []( const unsigned char ch ) {
        return ch < 0x20U || ch == 0x7fU;
    } ) ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " id must contain 1 to 256 non-control bytes" );
    }
}

bool mod_is_active( const std::string &id )
{
    validate_mod_id_text( id, "game.mods.is_active" );
    if( !world_generator ||
        world_generator->active_world == nullptr ) {
        return false;
    }
    const mod_id requested( id );
    const std::vector<mod_id> &active =
        world_generator->active_world->active_mod_order;
    return std::find(
               active.begin(), active.end(), requested ) !=
           active.end();
}

sol::table active_mods( sol::this_state lua )
{
    sol::state_view state( lua );
    const std::vector<mod_id> empty;
    const std::vector<mod_id> &active =
        world_generator && world_generator->active_world != nullptr ?
        world_generator->active_world->active_mod_order : empty;
    sol::table items = state.create_table(
                           static_cast<int>( active.size() ), 0 );
    for( std::size_t index = 0; index < active.size(); ++index ) {
        items[index + 1] = active[index].str();
    }
    sol::table result = state.create_table();
    result["items"] = std::move( items );
    result["total"] = active.size();
    result["world_active"] =
        world_generator && world_generator->active_world != nullptr;
    return result;
}

std::string safe_mode_name( const safe_mode_type mode )
{
    switch( mode ) {
        case SAFE_MODE_OFF:
            return "off";
        case SAFE_MODE_ON:
            return "on";
        case SAFE_MODE_STOP:
            return "triggered";
    }
    return "unknown";
}

sol::table safety_snapshot( sol::this_state lua )
{
    sol::state_view state( lua );
    if( g == nullptr ) {
        throw std::runtime_error(
            "game.safety.snapshot requires an active game" );
    }
    static constexpr std::array<std::string_view, 9> direction_names = {
        "north", "northeast", "east", "southeast", "south",
        "southwest", "west", "northwest", "local"
    };
    const monster_visible_info &visible =
        get_avatar().get_mon_visible();
    sol::table directions = state.create_table( 9, 0 );
    for( std::size_t index = 0;
         index < direction_names.size(); ++index ) {
        sol::table direction = state.create_table();
        direction["id"] = std::string( direction_names[index] );
        direction["monster_groups"] = visible.unique_mons[index].size();
        std::int64_t monster_count = 0;
        for( const auto &entry : visible.unique_mons[index] ) {
            monster_count += entry.second;
        }
        direction["monsters"] = monster_count;
        direction["npcs"] = visible.unique_types[index].size();
        direction["dangerous"] = index < visible.dangerous.size() ?
                                 visible.dangerous[index] : false;
        directions[index + 1] = std::move( direction );
    }
    sol::table result = state.create_table();
    result["mode"] = safe_mode_name( g->safe_mode );
    result["triggered"] = g->safe_mode == SAFE_MODE_STOP;
    result["dangerous_in_proximity"] =
        visible.has_dangerous_creature_in_proximity;
    result["newly_seen"] = visible.new_seen_mon.size();
    result["directions"] = std::move( directions );
    return result;
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

    sol::table mods = state.create_table();
    mods.set_function(
        "is_active",
        [require_read]( const std::string &id ) {
        require_read();
        return mod_is_active( id );
    } );
    mods.set_function(
        "active",
        [require_read]( sol::this_state lua ) {
        require_read();
        return active_mods( lua );
    } );
    game["mods"] = std::move( mods );

    sol::table safety = state.create_table();
    safety.set_function(
        "snapshot",
        [require_read]( sol::this_state lua ) {
        require_read();
        return safety_snapshot( lua );
    } );
    game["safety"] = std::move( safety );
}

} // namespace cata::lua_ui

#endif // CATA_ENABLE_LUA_UI
