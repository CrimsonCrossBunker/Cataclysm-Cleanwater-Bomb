#include "lua_platform_runtime_internal.h"
#include "item_category.h"
#include "itype.h"

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <algorithm>
#include <cmath>
#include <cstdint>
#include <limits>
#include <map>
#include <memory>
#include <optional>
#include <set>
#include <stdexcept>
#include <string>
#include <string_view>
#include <tuple>
#include <utility>
#include <vector>

#include "avatar.h"
#include "calendar.h"
#include "cata_variant.h"
#include "character.h"
#include "computer.h"
#include "creature.h"
#include "creature_tracker.h"
#include "debug.h"
#include "dialogue.h"
#include "effect.h"
#include "event.h"
#include "event_bus.h"
#include "event_field_transformations.h"
#include "event_statistics.h"
#include "event_subscriber.h"
#include "field_type.h"
#include "game.h"
#include "item.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_dialogue.h"
#include "lua_platform_missions.h"
#include "map.h"
#include "messages.h"
#include "mission.h"
#include "monster.h"
#include "npc.h"
#include "player_activity.h"
#include "profession.h"
#include "scenario.h"
#include "talker.h"
#include "type_id.h"
#include "vehicle.h"
#include "weakpoint.h"

namespace cata::lua_platform
{

namespace detail
{

int platform_event_dispatch_depth = 0;

int current_platform_event_dispatch_depth() noexcept
{
    return platform_event_dispatch_depth;
}

platform_event_dispatch_scope::platform_event_dispatch_scope()
{
    ++platform_event_dispatch_depth;
}

platform_event_dispatch_scope::~platform_event_dispatch_scope()
{
    --platform_event_dispatch_depth;
}

void require_live_runtime( const std::weak_ptr<runtime> &weak,
                           const std::string_view api_name )
{
    const std::shared_ptr<runtime> owner = weak.lock();
    if( !owner || !owner->world_is_ready ) {
        throw std::runtime_error( std::string( api_name ) +
                                  " is only available after world_ready" );
    }
}

bool runtime_callback_is_active( const std::weak_ptr<runtime> &weak )
{
    const std::shared_ptr<runtime> owner = weak.lock();
    return owner && owner->world_is_ready && owner->callback_depth > 0;
}

void report_callback_error( const runtime &owner, std::string_view handler,
                            const sol::protected_function_result &result )
{
    const sol::error error = result;
    const std::string message = "Lua-first handler '" + owner.mod_id + ":" +
                                std::string( handler ) + "' failed: " + error.what();
    DebugLog( D_ERROR, D_MAIN ) << message;
    ::add_msg( m_bad, message );
}

static sol::object platform_callback_entity_to_lua(
    runtime &owner, const cata::lua_platform::native_callback_entity &entity )
{
    sol::state_view lua( *owner.lua );
    switch( entity.kind() ) {
        case cata::lua_platform::native_callback_entity_kind::creature: {
            const safe_reference<Creature> reference = entity.creature_reference();
            Creature *value = reference.get();
            return value == nullptr ?
                   sol::make_object( lua, sol::lua_nil ) :
                   sol::make_object( lua, platform_creature_handle( owner, *value ) );
        }
        case cata::lua_platform::native_callback_entity_kind::item: {
            const safe_reference<item> reference = entity.item_reference();
            item *value = reference.get();
            if( value == nullptr ) {
                return sol::make_object( lua, sol::lua_nil );
            }
            return sol::make_object( lua, cata::lua_platform::game_handle::from_item(
            *value, {
                "platform_callback_item", value->uid().get_value(),
                0, 0, 0, {}
            }, owner.handle_runtime(), runtime_world_generation_storage() ) );
        }
        case cata::lua_platform::native_callback_entity_kind::vehicle: {
            const safe_reference<vehicle> reference = entity.vehicle_reference();
            vehicle *value = reference.get();
            if( value == nullptr ) {
                return sol::make_object( lua, sol::lua_nil );
            }
            const tripoint_abs_ms position = value->pos_abs();
            return sol::make_object( lua, cata::lua_platform::game_handle::from_vehicle(
            *value, {
                "platform_callback_vehicle", 0,
                position.x(), position.y(), position.z(), {}
            }, owner.handle_runtime(), runtime_world_generation_storage() ) );
        }
        case cata::lua_platform::native_callback_entity_kind::none:
            return sol::make_object( lua, sol::lua_nil );
    }
    return sol::make_object( lua, sol::lua_nil );
}

sol::object platform_callback_talker_to_lua(
    runtime &owner, const cata::lua_platform::native_callback_talker &talker )
{
    sol::state_view lua( *owner.lua );
    if( talker.entity ) {
        return platform_callback_entity_to_lua( owner, *talker.entity );
    }
    sol::table snapshot = owner.lua->create_table();
    snapshot["kind"] = talker.kind;
    snapshot["name"] = talker.name;
    sol::table position = owner.lua->create_table();
    position["coordinate_space"] = talker.coordinate_space;
    position["x"] = talker.pos.x();
    position["y"] = talker.pos.y();
    position["z"] = talker.pos.z();
    snapshot["position"] = std::move( position );
    return sol::make_object( lua, std::move( snapshot ) );
}

Character *platform_event_character( const character_id &id )
{
    avatar &player = get_avatar();
    if( player.getID() == id ) {
        return &player;
    }
    return g == nullptr ? nullptr : g->find_npc( id );
}

static bool platform_event_contract_exists( const std::string_view name )
{
    for( int raw = 0; raw < static_cast<int>( event_type::num_event_types ); ++raw ) {
        if( io::enum_to_string( static_cast<event_type>( raw ) ) == name ) {
            return true;
        }
    }
    return false;
}

static std::map<std::string, Character *> platform_event_characters( const cata::event &event )
{
    std::map<std::string, Character *> result;
    for( const auto &[name, value] : event.data() ) {
        if( value.type() != cata_variant_type::character_id ) {
            continue;
        }
        const character_id id = value.get<cata_variant_type::character_id>();
        if( Character *character = platform_event_character( id ) ) {
            result.emplace( name, character );
        }
    }
    return result;
}

static const item *platform_event_item( const cata::event &event, const talker *item_actor )
{
    if( item_actor == nullptr ) {
        return nullptr;
    }
    // These native producers explicitly attach their semantic item_location as
    // the second talker.  Do not treat that position as a generic actor fallback.
    switch( event.type() ) {
        case event_type::character_wields_item:
        case event_type::character_wears_item:
        case event_type::character_takeoff_item:
        case event_type::character_armor_destroyed:
            break;
        default:
            return nullptr;
    }
    const item_location *location = item_actor->get_const_item();
    return location == nullptr ? nullptr : location->get_item();
}

static sol::table event_to_lua( runtime &owner, const cata::event &event,
                         const std::map<std::string, Character *> &characters,
                         const item *event_item, const talker *speaker_actor,
                         const talker *interlocutor_actor )
{
    sol::table result = owner.lua->create_table();
    sol::table data = owner.lua->create_table();
    sol::table data_types = owner.lua->create_table();
    sol::table actors = owner.lua->create_table();
    result["type"] = io::enum_to_string( event.type() );
    result["turn"] = to_turn<std::int64_t>( event.time() );
    for( const auto &[name, value] : event.data() ) {
        switch( value.type() ) {
            case cata_variant_type::bool_:
                data[name] = value.get<cata_variant_type::bool_>();
                break;
            case cata_variant_type::int_:
                data[name] = value.get<cata_variant_type::int_>();
                break;
            case cata_variant_type::character_id: {
                const character_id id =
                    value.get<cata_variant_type::character_id>();
                data[name] = id.get_value();
                const auto character = characters.find( name );
                if( character != characters.end() ) {
                    const cata::lua_platform::game_handle handle = platform_creature_handle(
                                owner, *character->second );
                    actors[name] = handle;
                }
            }
            break;
            case cata_variant_type::chrono_seconds:
                data[name] = value.get<cata_variant_type::chrono_seconds>().count();
                break;
            default:
                data[name] = value.get_string();
                break;
        }
        data_types[name] = io::enum_to_string( value.type() );
    }
    if( event_item != nullptr ) {
        actors["item"] = cata::lua_platform::game_handle::from_item(
        const_cast<item &>( *event_item ), {
            "platform_event_item", event_item->uid().get_value(), 0, 0, 0, {}
        }, owner.handle_runtime(), runtime_world_generation_storage() );
    }
    // Some native events carry semantic participants only through the two
    // talkers supplied by the event bus.  Keep those participants under
    // explicit speaker/interlocutor names; never infer an avatar from
    // position or create compatibility aliases.
    if( speaker_actor != nullptr ) {
        actors["speaker"] = platform_talker_to_lua( owner, *speaker_actor );
        if( const Creature *creature = speaker_actor->get_const_creature() ) {
            actors["speaker"] = platform_creature_handle( owner, *creature );
        }
    }
    if( interlocutor_actor != nullptr ) {
        actors["interlocutor"] = platform_talker_to_lua( owner, *interlocutor_actor );
        if( const Creature *creature = interlocutor_actor->get_const_creature() ) {
            actors["interlocutor"] = platform_creature_handle( owner, *creature );
        }
    }
    result["data"] = std::move( data );
    result["data_types"] = std::move( data_types );
    result["actors"] = std::move( actors );
    return result;
}

static void dispatch_event_handler( runtime &owner, const std::string &name,
                                    const std::string &handler_id, const sol::object &payload )
{
    if( owner.callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first event recursion limit reached for '"
                                    << owner.mod_id << ':' << name << "'";
        return;
    }
    const auto handler = owner.handlers.find( handler_id );
    if( handler == owner.handlers.end() ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first event '" << name
                                    << "' references missing handler '"
                                    << owner.mod_id << ":" << handler_id << "'";
        return;
    }
    sol::protected_function callback = handler->second.callback;
    callback_scope scope( owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( owner, handler_id, result );
    }
}

static void dispatch_event( runtime &owner, const std::string &name, sol::object payload )
{
    const auto subscription = owner.subscriptions.find( name );
    if( subscription == owner.subscriptions.end() ) {
        return;
    }
    if( owner.callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first event recursion limit reached for '"
                                    << owner.mod_id << ':' << name << "'";
        return;
    }
    const std::vector<std::string> handler_ids = subscription->second;
    for( const std::string &handler_id : handler_ids ) {
        dispatch_event_handler( owner, name, handler_id, payload );
    }
}

void dispatch_lifecycle( runtime &owner, const std::string &name,
                         const sol::optional<sol::table> &payload )
{
    sol::object argument = payload ? sol::make_object( *owner.lua, *payload ) :
                           sol::make_object( *owner.lua, sol::lua_nil );
    dispatch_event( owner, name, std::move( argument ) );
}

cata::lua_platform::game_handle platform_creature_handle( const runtime &owner,
        const Creature &creature )
{
    Creature &mutable_creature = const_cast<Creature &>( creature );
    const tripoint_abs_ms position = creature.pos_abs();
    cata::lua_platform::game_handle_locator locator;
    locator.scope = creature.is_avatar() ? "avatar" :
                    creature.is_npc() ? "npc" :
                    creature.as_character() != nullptr ? "character" : "monster";
    locator.x = position.x();
    locator.y = position.y();
    locator.z = position.z();
    if( const Character *character = creature.as_character() ) {
        locator.stable_id = character->getID().get_value();
    } else if( const monster *monster_value = creature.as_monster() ) {
        locator.stable_id = monster_value->uid().get_value();
    }
    return cata::lua_platform::game_handle::from_creature(
               mutable_creature, std::move( locator ), owner.handle_runtime(),
               runtime_world_generation_storage() );
}

item_locator_hint persistent_item_hint(
    const cata::lua_platform::game_handle_locator &stored )
{
    item_locator_hint result;
    const tripoint_abs_ms position( stored.x, stored.y, stored.z );
    if( stored.scope.find( "vehicle" ) != std::string::npos ) {
        vehicle_hint hint;
        hint.cargo_square = position;
        result.where = item_locator_hint::place::vehicle;
        result.location = hint;
    } else if( stored.scope.find( "map" ) != std::string::npos ) {
        result.where = item_locator_hint::place::map;
        result.location = position;
    }
    return result;
}

item_locator_hint persistent_task_item_hint( const persistent_task &task )
{
    return task.actor_item_hint ? persistent_item_hint( *task.actor_item_hint ) :
           item_locator_hint{};
}

cata::lua_platform::game_handle platform_item_handle(
    const runtime &owner, item_location &location,
    const cata::lua_platform::game_handle_locator &stored_hint )
{
    cata::lua_platform::game_handle_locator locator = stored_hint;
    const tripoint_abs_ms position = location.pos_abs();
    locator.stable_id = location->uid().get_value();
    locator.x = position.x();
    locator.y = position.y();
    locator.z = position.z();
    locator.path.clear();
    locator.owner_generation = 0;
    switch( location.where_recursive() ) {
        case item_location::type::character: {
            Character *carrier = location.carrier();
            locator.scope = carrier != nullptr && carrier->is_avatar() ?
                            "avatar_item" : "character_item";
            break;
        }
        case item_location::type::map:
            locator.scope = "map_item";
            break;
        case item_location::type::vehicle:
            locator.scope = "vehicle_item";
            break;
        case item_location::type::container:
        case item_location::type::invalid:
            locator.scope = "item";
            break;
    }
    return cata::lua_platform::game_handle::from_item(
               *location, std::move( locator ), owner.handle_runtime(),
               runtime_world_generation_storage() );
}

cata::lua_platform::game_handle platform_vehicle_handle(
    const runtime &owner, vehicle &value )
{
    const tripoint_abs_ms position = value.pos_abs();
    cata::lua_platform::game_handle_locator locator;
    locator.scope = "vehicle";
    locator.stable_id = value.uid().get_value();
    locator.x = position.x();
    locator.y = position.y();
    locator.z = position.z();
    return cata::lua_platform::game_handle::from_vehicle(
               value, std::move( locator ), owner.handle_runtime(),
               runtime_world_generation_storage() );
}

sol::object platform_talker_to_lua( runtime &owner, const const_talker &talker )
{
    constexpr std::size_t maximum_detached_participant_name_bytes = 256;
    sol::state_view lua( *owner.lua );
    if( const Creature *creature = talker.get_const_creature() ) {
        return sol::make_object( lua, platform_creature_handle( owner, *creature ) );
    }
    if( const item_location *location = talker.get_const_item() ) {
        if( const item *value = location->get_item() ) {
            return sol::make_object( lua, cata::lua_platform::game_handle::from_item(
            const_cast<item &>( *value ), {
                "platform_callback_talker_item", value->uid().get_value(), 0, 0, 0, {}
            }, owner.handle_runtime(), runtime_world_generation_storage() ) );
        }
    }
    if( const vehicle *value = talker.get_const_vehicle() ) {
        const tripoint_abs_ms position = value->pos_abs();
        return sol::make_object( lua, cata::lua_platform::game_handle::from_vehicle(
        const_cast<vehicle &>( *value ), {
            "platform_callback_talker_vehicle", 0,
            position.x(), position.y(), position.z(), {}
        }, owner.handle_runtime(), runtime_world_generation_storage() ) );
    }

    sol::table snapshot = owner.lua->create_table();
    std::string kind = "talker";
    if( talker.get_const_computer() != nullptr ) {
        kind = "computer";
    } else if( talker.get_const_zone() != nullptr ) {
        kind = "zone";
    } else if( talker.disp_name().empty() ) {
        kind = "topic";
    }
    const std::string name = talker.disp_name();
    if( name.size() > maximum_detached_participant_name_bytes ||
        name.find( '\0' ) != std::string::npos ) {
        throw std::runtime_error(
            "dialogue participant snapshot name exceeds its native limit" );
    }
    snapshot["kind"] = std::move( kind );
    snapshot["name"] = name;
    const tripoint_abs_ms position = talker.pos_abs();
    sol::table position_value = owner.lua->create_table();
    position_value["coordinate_space"] = "abs_ms";
    position_value["x"] = position.x();
    position_value["y"] = position.y();
    position_value["z"] = position.z();
    snapshot["position"] = std::move( position_value );
    return sol::make_object( lua, std::move( snapshot ) );
}

static sol::object platform_callback_value_to_lua(
    runtime &owner, const cata::lua_platform::native_callback_value &value )
{
    sol::state_view lua( *owner.lua );
    return std::visit( [&owner, lua]( const auto & entry ) -> sol::object {
        using value_type = std::decay_t<decltype( entry )>;
        if constexpr( std::is_same_v<value_type,
                      cata::lua_platform::native_callback_entity> )
        {
            return platform_callback_entity_to_lua( owner, entry );
        } else if constexpr( std::is_same_v<value_type,
                             cata::lua_platform::native_callback_point> )
        {
            sol::table point = owner.lua->create_table();
            point["coordinate_space"] = entry.coordinate_space;
            point["x"] = entry.pos.x();
            point["y"] = entry.pos.y();
            point["z"] = entry.pos.z();
            return sol::make_object( lua, std::move( point ) );
        } else if constexpr( std::is_same_v<value_type,
                             cata::lua_platform::native_callback_id> )
        {
            return sol::make_object( lua,
                                     cata::lua_platform::script_game_id( entry.kind, entry.value ) );
        } else if constexpr( std::is_same_v<value_type, std::vector<std::string>> )
        {
            sol::table strings = owner.lua->create_table();
            for( std::size_t index = 0; index < entry.size(); ++index ) {
                strings[index + 1] = entry[index];
            }
            return sol::make_object( lua, std::move( strings ) );
        } else if constexpr( std::is_same_v<value_type,
                             cata::lua_platform::native_callback_talker> )
        {
            return entry.present ? platform_callback_talker_to_lua( owner, entry ) :
                   sol::make_object( lua, sol::lua_nil );
        } else if constexpr( std::is_same_v<value_type,
                             cata::lua_platform::native_callback_mission> )
        {
            return sol::make_object( lua, cata::lua_platform::mission_token(
                                         entry.uid, entry.identity_generation,
                                         owner.handle_runtime(),
                                         runtime_world_generation_storage() ) );
        } else
        {
            return sol::make_object( lua, entry );
        }
    }, value.storage() );
}

sol::table platform_callback_payload(
    runtime &owner, const cata::lua_platform::native_callback_arguments &arguments )
{
    if( arguments.size() > 64 ) {
        throw std::invalid_argument( "Platform native hook payload exceeds 64 fields" );
    }
    sol::table result = owner.lua->create_table();
    std::set<std::string> names;
    for( const cata::lua_platform::native_callback_argument &argument : arguments ) {
        if( argument.name.empty() || argument.name.size() > 128 ||
            !names.insert( argument.name ).second ) {
            throw std::invalid_argument( "Platform native hook payload has an invalid field name" );
        }
        result[argument.name] = platform_callback_value_to_lua( owner, argument.value );
    }
    return result;
}

std::optional<bool> invoke_widget_condition_handler(
    const std::string_view mod_id, const std::string_view widget_id_value,
    const std::string_view clause_id, const std::string_view handler_id,
    const std::string_view bodypart )
{
    const std::shared_ptr<runtime> owner = find_active_runtime( mod_id );
    if( !owner || !owner->world_is_ready ) {
        return std::nullopt;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first widget condition unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return std::nullopt;
    }
    sol::table payload = platform_callback_payload( *owner, {
        { "avatar", static_cast<const Character *>( &get_avatar() ) },
        { "widget", std::string( widget_id_value ) },
        { "clause", std::string( clause_id ) },
        { "bodypart", std::string( bodypart ) }
    } );
    sol::protected_function callback = handler->second.callback;
    callback_scope scope( *owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
        return std::nullopt;
    }
    if( result.return_count() != 1 || result.get_type() != sol::type::boolean ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first widget condition '"
                                    << mod_id << ':' << handler_id
                                    << "' must return exactly one boolean";
        return std::nullopt;
    }
    return result.get<bool>();
}

std::optional<widget_custom_handler_result> invoke_widget_custom_handler(
    const std::string_view mod_id, const std::string_view widget_id_value,
    const std::string_view handler_id, const avatar &subject )
{
    const std::shared_ptr<runtime> owner = find_active_runtime( mod_id );
    if( !owner || !owner->world_is_ready ) {
        return std::nullopt;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first custom widget unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return std::nullopt;
    }
    sol::table payload = platform_callback_payload( *owner, {
        { "avatar", static_cast<const Character *>( &subject ) },
        { "widget", std::string( widget_id_value ) }
    } );
    sol::protected_function callback = handler->second.callback;
    callback_scope scope( *owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
        return std::nullopt;
    }
    if( result.return_count() != 1 || result.get_type() != sol::type::table ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first custom widget '"
                                    << mod_id << ':' << handler_id
                                    << "' must return exactly one value/range table";
        return std::nullopt;
    }
    const sol::table values = result.get<sol::table>();
    const auto read_integer = [&values]( const char *key, const int fallback ) {
        const sol::object value = values.raw_get<sol::object>( key );
        if( value.get_type() == sol::type::nil ) {
            return fallback;
        }
        if( !value.is<lua_Integer>() ) {
            throw std::runtime_error( std::string( "custom widget field '" ) + key +
                                      "' must be an integer" );
        }
        const std::int64_t raw = value.as<std::int64_t>();
        if( !fits_native_int( raw ) ) {
            throw std::runtime_error( std::string( "custom widget field '" ) + key +
                                      "' is outside the native range" );
        }
        return static_cast<int>( raw );
    };
    try {
        widget_custom_handler_result value;
        value.value = read_integer( "value", 0 );
        value.minimum = read_integer( "minimum", std::numeric_limits<int>::min() );
        value.normal_minimum = read_integer( "normal_minimum", value.minimum );
        value.normal_maximum = read_integer( "normal_maximum", value.normal_minimum );
        value.maximum = read_integer( "maximum", std::numeric_limits<int>::max() );
        if( value.minimum > value.normal_minimum ||
            value.normal_minimum > value.normal_maximum ||
            value.normal_maximum > value.maximum ) {
            throw std::runtime_error( "custom widget range must be monotonically increasing" );
        }
        return value;
    } catch( const std::exception &exception ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first custom widget '"
                                    << mod_id << ':' << handler_id
                                    << "' returned invalid data: " << exception.what();
        return std::nullopt;
    }
}

static sol::table enchantment_handler_payload( runtime &owner,
        const const_dialogue &dialogue,
        const std::string_view enchantment,
        const std::string_view scope,
        const std::string_view target,
        const std::string_view part )
{
    const const_talker *speaker = dialogue.has_alpha ? dialogue.const_actor( false ) : nullptr;
    const const_talker *interlocutor = dialogue.has_beta ? dialogue.const_actor( true ) : nullptr;
    return platform_callback_payload( owner, {
        { "speaker", speaker },
        { "interlocutor", interlocutor },
        { "has_speaker", dialogue.has_alpha },
        { "has_interlocutor", dialogue.has_beta },
        { "enchantment", std::string( enchantment ) },
        { "scope", std::string( scope ) },
        { "target", std::string( target ) },
        { "part", std::string( part ) }
    } );
}

std::optional<bool> invoke_enchantment_condition_handler(
    const std::string_view mod_id, const std::string_view enchantment,
    const std::string_view scope, const std::string_view target,
    const std::string_view handler_id, const const_dialogue &dialogue )
{
    const std::shared_ptr<runtime> owner = find_active_runtime( mod_id );
    if( !owner || !owner->world_is_ready ) {
        return std::nullopt;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first enchantment condition unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return std::nullopt;
    }
    sol::table payload = enchantment_handler_payload(
                             *owner, dialogue, enchantment, scope, target, std::string_view() );
    sol::protected_function callback = handler->second.callback;
    callback_scope callback_guard( *owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
        return std::nullopt;
    }
    if( result.return_count() != 1 || result.get_type() != sol::type::boolean ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first enchantment condition '"
                                    << mod_id << ':' << handler_id
                                    << "' must return exactly one boolean";
        return std::nullopt;
    }
    return result.get<bool>();
}

std::optional<double> invoke_enchantment_number_handler(
    const std::string_view mod_id, const std::string_view enchantment,
    const std::string_view scope, const std::string_view target,
    const std::string_view part, const std::string_view handler_id,
    const const_dialogue &dialogue )
{
    const std::shared_ptr<runtime> owner = find_active_runtime( mod_id );
    if( !owner || !owner->world_is_ready ) {
        return std::nullopt;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first enchantment value unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return std::nullopt;
    }
    sol::table payload = enchantment_handler_payload(
                             *owner, dialogue, enchantment, scope, target, part );
    sol::protected_function callback = handler->second.callback;
    callback_scope callback_guard( *owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
        return std::nullopt;
    }
    if( result.return_count() != 1 || result.get_type() != sol::type::number ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first enchantment value '"
                                    << mod_id << ':' << handler_id
                                    << "' must return exactly one finite number";
        return std::nullopt;
    }
    const double value = result.get<double>();
    if( !std::isfinite( value ) ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first enchantment value '"
                                    << mod_id << ':' << handler_id
                                    << "' returned a non-finite number";
        return std::nullopt;
    }
    return value;
}

std::optional<bool> invoke_spell_condition_handler(
    const std::string_view mod_id, const std::string_view spell_id_value,
    const std::string_view phase, const std::string_view handler_id,
    const const_dialogue &dialogue )
{
    const std::shared_ptr<runtime> owner = find_active_runtime( mod_id );
    if( !owner || !owner->world_is_ready ) {
        return std::nullopt;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first spell condition unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return std::nullopt;
    }
    const const_talker *speaker = dialogue.has_alpha ? dialogue.const_actor( false ) : nullptr;
    const const_talker *interlocutor = dialogue.has_beta ? dialogue.const_actor( true ) : nullptr;
    sol::table payload = platform_callback_payload( *owner, {
        { "speaker", speaker },
        { "interlocutor", interlocutor },
        { "has_speaker", dialogue.has_alpha },
        { "has_interlocutor", dialogue.has_beta },
        {
            "spell", cata::lua_platform::native_callback_id{
                "spell", std::string( spell_id_value ) }
        },
        { "phase", std::string( phase ) }
    } );
    sol::protected_function callback = handler->second.callback;
    callback_scope callback_guard( *owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
        return std::nullopt;
    }
    if( result.return_count() != 1 || result.get_type() != sol::type::boolean ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first spell condition '"
                                    << mod_id << ':' << handler_id
                                    << "' must return exactly one boolean";
        return std::nullopt;
    }
    return result.get<bool>();
}

std::optional<double> invoke_spell_stat_handler(
    const std::string_view mod_id, const std::string_view spell_id_value,
    const std::string_view stat, const std::string_view handler_id,
    const const_dialogue &dialogue )
{
    const std::shared_ptr<runtime> owner = find_active_runtime( mod_id );
    if( !owner || !owner->world_is_ready ) {
        return std::nullopt;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first spell stat unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return std::nullopt;
    }
    const const_talker *speaker = dialogue.has_alpha ? dialogue.const_actor( false ) : nullptr;
    const const_talker *interlocutor = dialogue.has_beta ? dialogue.const_actor( true ) : nullptr;
    sol::table payload = platform_callback_payload( *owner, {
        { "speaker", speaker },
        { "interlocutor", interlocutor },
        { "has_speaker", dialogue.has_alpha },
        { "has_interlocutor", dialogue.has_beta },
        {
            "spell", cata::lua_platform::native_callback_id{
                "spell", std::string( spell_id_value ) }
        },
        { "stat", std::string( stat ) }
    } );
    sol::protected_function callback = handler->second.callback;
    callback_scope callback_guard( *owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
        return std::nullopt;
    }
    if( result.return_count() != 1 || result.get_type() != sol::type::number ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first spell stat '"
                                    << mod_id << ':' << handler_id
                                    << "' must return exactly one finite number";
        return std::nullopt;
    }
    const double value = result.get<double>();
    if( !std::isfinite( value ) ||
        std::abs( value ) > std::numeric_limits<int>::max() ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first spell stat '"
                                    << mod_id << ':' << handler_id
                                    << "' returned a value outside the native range";
        return std::nullopt;
    }
    return value;
}

void invoke_spell_effect_handler(
    const std::string_view mod_id, const std::string_view spell_id_value,
    const std::string_view handler_id, const spell &cast_spell,
    Creature &caster, const tripoint_bub_ms &target )
{
    const std::shared_ptr<runtime> owner = find_active_runtime( mod_id );
    if( !owner || !owner->world_is_ready ) {
        return;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first spell effect unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return;
    }
    sol::table payload = platform_callback_payload( *owner, {
        { "caster", static_cast<const Creature *>( &caster ) },
        {
            "spell", cata::lua_platform::native_callback_id{
                "spell", std::string( spell_id_value ) }
        },
        {
            "target", cata::lua_platform::native_callback_point{
                "bubble", tripoint_rel_ms( target.x(), target.y(), target.z() ) }
        },
        { "level", static_cast<std::int64_t>( cast_spell.get_level() ) }
    } );
    sol::protected_function callback = handler->second.callback;
    callback_scope callback_guard( *owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
    }
}

std::optional<bool> invoke_mission_condition_handler(
    const std::string_view mod_id, const std::string_view mission_type,
    const std::string_view phase, const std::string_view handler_id,
    const const_dialogue &dialogue )
{
    const std::shared_ptr<runtime> owner = find_active_runtime( mod_id );
    if( !owner || !owner->world_is_ready ) {
        return std::nullopt;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first mission condition unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return std::nullopt;
    }
    const const_talker *speaker = dialogue.has_alpha ? dialogue.const_actor( false ) : nullptr;
    const const_talker *interlocutor = dialogue.has_beta ? dialogue.const_actor( true ) : nullptr;
    sol::table payload = platform_callback_payload( *owner, {
        { "speaker", speaker },
        { "interlocutor", interlocutor },
        { "has_speaker", dialogue.has_alpha },
        { "has_interlocutor", dialogue.has_beta },
        {
            "mission_type", cata::lua_platform::native_callback_id{
                "mission_type", std::string( mission_type ) }
        },
        { "phase", std::string( phase ) }
    } );
    sol::protected_function callback = handler->second.callback;
    callback_scope callback_guard( *owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
        return std::nullopt;
    }
    if( result.return_count() != 1 || result.get_type() != sol::type::boolean ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first mission condition '"
                                    << mod_id << ':' << handler_id
                                    << "' must return exactly one boolean";
        return std::nullopt;
    }
    return result.get<bool>();
}

std::optional<std::int64_t> invoke_mission_deadline_handler(
    const std::string_view mod_id, const std::string_view mission_type,
    const std::string_view handler_id, const const_dialogue &dialogue )
{
    const std::shared_ptr<runtime> owner = find_active_runtime( mod_id );
    if( !owner || !owner->world_is_ready ) {
        return std::nullopt;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first mission deadline unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return std::nullopt;
    }
    const const_talker *speaker = dialogue.has_alpha ? dialogue.const_actor( false ) : nullptr;
    const const_talker *interlocutor = dialogue.has_beta ? dialogue.const_actor( true ) : nullptr;
    sol::table payload = platform_callback_payload( *owner, {
        { "speaker", speaker },
        { "interlocutor", interlocutor },
        { "has_speaker", dialogue.has_alpha },
        { "has_interlocutor", dialogue.has_beta },
        {
            "mission_type", cata::lua_platform::native_callback_id{
                "mission_type", std::string( mission_type ) }
        },
        { "phase", std::string( "deadline" ) }
    } );
    sol::protected_function callback = handler->second.callback;
    callback_scope callback_guard( *owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
        return std::nullopt;
    }
    if( result.return_count() != 1 || !result.get<sol::object>().is<lua_Integer>() ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first mission deadline '"
                                    << mod_id << ':' << handler_id
                                    << "' must return exactly one integer turn count";
        return std::nullopt;
    }
    const std::int64_t turns = result.get<std::int64_t>();
    if( turns < 0 || !fits_native_int( turns ) ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first mission deadline '"
                                    << mod_id << ':' << handler_id
                                    << "' returned an invalid turn count";
        return std::nullopt;
    }
    return turns;
}

std::optional<bool> invoke_mission_place_handler(
    const std::string_view mod_id, const std::string_view mission_type,
    const std::string_view handler_id, const tripoint_abs_omt &position )
{
    const std::shared_ptr<runtime> owner = find_active_runtime( mod_id );
    if( !owner || !owner->world_is_ready ) {
        return std::nullopt;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        return std::nullopt;
    }
    sol::table payload = platform_callback_payload( *owner, {
        {
            "mission_type", cata::lua_platform::native_callback_id{
                "mission_type", std::string( mission_type ) }
        },
        {
            "position", cata::lua_platform::native_callback_point{
                "abs_omt", tripoint_rel_ms( position.x(), position.y(), position.z() ) }
        }
    } );
    sol::protected_function callback = handler->second.callback;
    callback_scope callback_guard( *owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
        return std::nullopt;
    }
    if( result.return_count() != 1 || result.get_type() != sol::type::boolean ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first mission place handler '"
                                    << mod_id << ':' << handler_id
                                    << "' must return exactly one boolean";
        return std::nullopt;
    }
    return result.get<bool>();
}

void invoke_mission_phase_handler(
    const std::string_view mod_id, const std::string_view mission_type,
    const std::string_view phase, const std::string_view handler_id,
    mission *active_mission )
{
    if( active_mission == nullptr ) {
        return;
    }
    const std::shared_ptr<runtime> owner = find_active_runtime( mod_id );
    if( !owner || !owner->world_is_ready ) {
        return;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        return;
    }
    sol::table payload = platform_callback_payload( *owner, {
        {
            "mission", cata::lua_platform::native_callback_mission{
                active_mission->get_id(), active_mission->identity_generation() }
        },
        {
            "mission_type", cata::lua_platform::native_callback_id{
                "mission_type", std::string( mission_type ) }
        },
        { "phase", std::string( phase ) }
    } );
    sol::protected_function callback = handler->second.callback;
    callback_scope callback_guard( *owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
    }
}

std::optional<bool> invoke_mutation_condition_handler(
    const std::string_view mod_id, const std::string_view mutation_id,
    const std::string_view handler_id, const const_dialogue &dialogue )
{
    const std::shared_ptr<runtime> owner = find_active_runtime( mod_id );
    if( !owner || !owner->world_is_ready ) {
        return std::nullopt;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first mutation condition unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return std::nullopt;
    }
    const const_talker *speaker = dialogue.has_alpha ? dialogue.const_actor( false ) : nullptr;
    const const_talker *interlocutor = dialogue.has_beta ? dialogue.const_actor( true ) : nullptr;
    sol::table payload = platform_callback_payload( *owner, {
        { "speaker", speaker },
        { "interlocutor", interlocutor },
        { "has_speaker", dialogue.has_alpha },
        { "has_interlocutor", dialogue.has_beta },
        {
            "mutation", cata::lua_platform::native_callback_id{
                "mutation", std::string( mutation_id ) }
        }
    } );
    sol::protected_function callback = handler->second.callback;
    callback_scope callback_guard( *owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
        return std::nullopt;
    }
    if( result.return_count() != 1 || result.get_type() != sol::type::boolean ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first mutation condition '"
                                    << mod_id << ':' << handler_id
                                    << "' must return exactly one boolean";
        return std::nullopt;
    }
    return result.get<bool>();
}

static std::optional<bool> platform_hook_bool( const sol::table &table, const char *name )
{
    const sol::object value = table.raw_get<sol::object>( name );
    if( !value.valid() || value.get_type() == sol::type::nil ) {
        return std::nullopt;
    }
    if( value.get_type() != sol::type::boolean ) {
        throw std::invalid_argument( std::string( "Platform hook result '" ) + name +
                                     "' must be boolean" );
    }
    return value.as<bool>();
}

static std::optional<std::string> platform_hook_string( const sol::table &table,
        const char *name, const std::size_t maximum )
{
    const sol::object value = table.raw_get<sol::object>( name );
    if( !value.valid() || value.get_type() == sol::type::nil ) {
        return std::nullopt;
    }
    if( value.get_type() != sol::type::string ) {
        throw std::invalid_argument( std::string( "Platform hook result '" ) + name +
                                     "' must be a string" );
    }
    std::string result = value.as<std::string>();
    if( result.size() > maximum ) {
        throw std::invalid_argument( std::string( "Platform hook result '" ) + name +
                                     "' is too large" );
    }
    return result;
}

static void apply_platform_hook_table( const std::string_view name, const sol::table &table,
                                cata::lua_platform::native_hook_result &aggregate,
                                bool &stop, const bool shared_results )
{
    using cata::lua_platform::native_hook_supports_result_field;
    if( native_hook_supports_result_field( name, "allow" ) ) {
        std::optional<bool> allow = platform_hook_bool( table, "allow" );
        if( !allow ) {
            allow = platform_hook_bool( table, "allowed" );
        }
        if( allow ) {
            aggregate.allowed = aggregate.allowed && *allow;
            stop = stop || !*allow;
        }
    }
    if( native_hook_supports_result_field( name, "handled" ) ) {
        if( const std::optional<bool> handled = platform_hook_bool( table, "handled" ) ) {
            aggregate.handled = aggregate.handled || *handled;
        }
    }
    if( native_hook_supports_result_field( name, "text" ) ) {
        if( const std::optional<std::string> text =
                platform_hook_string( table, "text", 32768 ) ) {
            if( shared_results ) {
                aggregate.text = *text;
            } else if( !text->empty() ) {
                if( aggregate.text.size() + ( aggregate.text.empty() ? 0 : 1 ) +
                    text->size() > 32768 ) {
                    throw std::invalid_argument(
                        "Platform hook aggregate text exceeds 32768 bytes" );
                }
                if( !aggregate.text.empty() ) {
                    aggregate.text.push_back( '\n' );
                }
                aggregate.text += *text;
            }
        }
    }
    if( native_hook_supports_result_field( name, "result" ) ) {
        if( std::optional<std::string> result =
                platform_hook_string( table, "result", 512 ) ) {
            aggregate.result = std::move( result );
        }
    }
    if( native_hook_supports_result_field( name, "results" ) ) {
        const sol::object raw = table.raw_get<sol::object>( "results" );
        if( raw.valid() && raw.get_type() != sol::type::nil ) {
            if( raw.get_type() != sol::type::table ) {
                throw std::invalid_argument( "Platform hook result 'results' must be a table" );
            }
            const sol::table values = raw.as<sol::table>();
            const std::size_t value_count = checked_dense_array(
                                                values, "Platform hook result strings", 0,
                                                shared_results ? 256 : 64 );
            std::vector<std::string> parsed;
            parsed.reserve( value_count );
            for( std::size_t index = 1; index <= value_count; ++index ) {
                const sol::object entry = values.raw_get<sol::object>( index );
                if( entry.get_type() != sol::type::string ) {
                    throw std::invalid_argument(
                        "Platform hook result string lists may only contain strings" );
                }
                const std::string text = entry.as<std::string>();
                if( text.empty() || text.size() > 512 ) {
                    throw std::invalid_argument( "Platform hook result string is invalid" );
                }
                if( std::find( parsed.begin(), parsed.end(), text ) == parsed.end() ) {
                    parsed.push_back( text );
                }
            }
            if( shared_results ) {
                aggregate.results = std::move( parsed );
            } else {
                for( std::string &text : parsed ) {
                    if( std::find( aggregate.results.begin(), aggregate.results.end(), text ) ==
                        aggregate.results.end() ) {
                        aggregate.results.push_back( std::move( text ) );
                    }
                }
            }
            if( aggregate.results.size() > 256 ) {
                throw std::invalid_argument(
                    "Platform hook aggregate has too many strings" );
            }
        }
    }
    if( native_hook_supports_result_field( name, "entries" ) ) {
        const sol::object raw = table.raw_get<sol::object>( "entries" );
        if( raw.valid() && raw.get_type() != sol::type::nil ) {
            if( raw.get_type() != sol::type::table ) {
                throw std::invalid_argument( "Platform hook result 'entries' must be a table" );
            }
            const sol::table entries = raw.as<sol::table>();
            const std::size_t entry_count = checked_dense_array(
                                                entries, "Platform hook menu entries", 0, 64 );
            if( aggregate.menu_entries.size() + entry_count > 128 ) {
                throw std::invalid_argument( "Platform hook result has too many menu entries" );
            }
            std::set<std::string> known_ids;
            for( const cata::lua_platform::native_menu_entry &entry : aggregate.menu_entries ) {
                known_ids.insert( entry.id );
            }
            for( std::size_t index = 1; index <= entry_count; ++index ) {
                const sol::object raw_entry = entries.raw_get<sol::object>( index );
                if( raw_entry.get_type() != sol::type::table ) {
                    throw std::invalid_argument( "Platform hook menu entries must be tables" );
                }
                const sol::table entry = raw_entry.as<sol::table>();
                cata::lua_platform::native_menu_entry native;
                native.id = entry.get_or( "id", std::string() );
                native.label = entry.get_or( "label", std::string() );
                native.enabled = entry.get_or( "enabled", true );
                if( native.id.empty() || native.label.empty() ||
                    native.id.size() > 96 || native.label.size() > 512 ) {
                    throw std::invalid_argument( "Platform hook menu entry is invalid" );
                }
                if( known_ids.insert( native.id ).second ) {
                    aggregate.menu_entries.push_back( std::move( native ) );
                }
            }
        }
    }
    stop = stop || platform_hook_bool( table, "stop" ).value_or( false );
}

static void dispatch_platform_event( const cata::event &event, const item *event_item,
                              const talker *alpha_actor,
                              const talker *beta_actor )
{
    if( g == nullptr || event.type() == event_type::num_event_types ) {
        return;
    }
    const std::string event_name = "game:" + io::enum_to_string( event.type() );
    const bool has_subscriber = std::any_of(
                                    active_runtime_values().begin(), active_runtime_values().end(),
    [&event_name]( const std::shared_ptr<runtime> &owner ) {
        return owner && owner->world_is_ready &&
               owner->subscriptions.find( event_name ) != owner->subscriptions.end();
    } );
    if( !has_subscriber ) {
        return;
    }
    if( platform_event_dispatch_depth >= 16 ) {
        DebugLog( D_WARNING, D_MAIN ) << "Lua-first global event recursion limit reached for '"
                                      << event_name << "'";
        return;
    }
    platform_event_dispatch_scope event_scope;
    const std::map<std::string, Character *> characters =
        platform_event_characters( event );
    struct pending_callback {
        std::shared_ptr<runtime> owner;
        std::string handler_id;
        sol::object payload;
    };
    std::vector<pending_callback> pending;
    for( const std::shared_ptr<runtime> &owner : active_runtime_values() ) {
        if( !owner || !owner->world_is_ready ) {
            continue;
        }
        const auto subscription = owner->subscriptions.find( event_name );
        if( subscription == owner->subscriptions.end() ) {
            continue;
        }
        if( owner->callback_depth >= 16 ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first event recursion limit reached for '"
                                        << owner->mod_id << ':' << event_name << "'";
            continue;
        }
        const std::vector<std::string> handler_ids = subscription->second;
        for( const std::string &handler_id : handler_ids ) {
            try {
                pending.push_back( {
                    owner,
                    handler_id,
                    sol::make_object(
                        *owner->lua, event_to_lua( *owner, event, characters,
                                                   event_item, alpha_actor,
                                                   beta_actor ) )
                } );
            } catch( const std::exception &exception ) {
                DebugLog( D_ERROR, D_MAIN ) << "Lua-first event payload for '"
                                            << owner->mod_id << ':' << event_name << ':'
                                            << handler_id << "' failed: " << exception.what();
            }
        }
    }
    for( const pending_callback &callback : pending ) {
        dispatch_event_handler( *callback.owner, event_name, callback.handler_id,
                                callback.payload );
    }
}

class platform_event_bridge : public event_subscriber
{
    public:
        void notify( const cata::event &event ) override {
            dispatch_platform_event( event, nullptr, nullptr, nullptr );
        }

        void notify( const cata::event &event, std::unique_ptr<talker> alpha_actor,
                     std::unique_ptr<talker> beta_actor ) override {
            dispatch_platform_event(
                event, platform_event_item( event, beta_actor.get() ),
                alpha_actor.get(), beta_actor.get() );
        }
};

std::unique_ptr<platform_event_bridge> event_bridge;

void start_runtime_event_bridge()
{
    if( !event_bridge ) {
        event_bridge = std::make_unique<platform_event_bridge>();
        get_event_bus().subscribe( event_bridge.get() );
    }
}

void stop_runtime_event_bridge()
{
    if( event_bridge ) {
        get_event_bus().unsubscribe( event_bridge.get() );
        event_bridge.reset();
    }
}


void install_runtime_callback_api(
    const std::shared_ptr<runtime> &value, sol::state &lua, sol::table &ccb )
{
    const std::weak_ptr<runtime> weak = value;
    sol::table runtime_api = lua.create_table();
    runtime_api.set_function( "handler", [weak]( const std::string & id,
    const sol::object & callback, const sol::optional<std::int64_t> &payload_version ) {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner ) {
            throw std::runtime_error( "stale Platform runtime" );
        }
        if( id.empty() || id.find( '#' ) != std::string::npos ) {
            throw std::runtime_error( "handler id must be non-empty and cannot contain '#'" );
        }
        if( callback.get_type() != sol::type::function ) {
            throw std::runtime_error( "handler callback must be a Lua function" );
        }
        const std::int64_t requested_version = payload_version.value_or( 1 );
        if( requested_version <= 0 || requested_version > std::numeric_limits<int>::max() ) {
            throw std::runtime_error( "handler payload version is outside the native range" );
        }
        const int version = static_cast<int>( requested_version );
        if( !owner->handlers.emplace( id, handler_definition{
        version, callback.as<sol::protected_function>()
        } ).second ) {
            throw std::runtime_error( "duplicate handler id '" + id + "'" );
        }
    } );
    runtime_api.set_function( "character_recurring", [weak](
                                  const std::string & effect_handler,
    const std::string & interval_handler ) {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner ) {
            throw std::runtime_error( "stale Platform runtime" );
        }
        if( effect_handler.empty() || interval_handler.empty() ) {
            throw std::runtime_error(
                "character recurring handler ids cannot be empty" );
        }
        if( owner->handlers.count( effect_handler ) == 0 ) {
            throw std::runtime_error(
                "character recurring effect references missing handler '" +
                effect_handler + "'" );
        }
        if( owner->handlers.count( interval_handler ) == 0 ) {
            throw std::runtime_error(
                "character recurring interval references missing handler '" +
                interval_handler + "'" );
        }
        if( owner->character_recurring_handlers.size() >=
            maximum_character_recurring_handlers_per_mod ) {
            throw std::runtime_error(
                "character recurring handler registration limit reached" );
        }
        if( std::any_of(
                owner->character_recurring_handlers.begin(),
                owner->character_recurring_handlers.end(),
        [&effect_handler]( const runtime::character_recurring_registration & entry ) {
        return entry.effect_handler == effect_handler;
    } ) ) {
            throw std::runtime_error(
                "duplicate character recurring effect handler '" +
                effect_handler + "'" );
        }
        const std::string identity = owner->mod_id + '\0' + effect_handler +
                                     '\0' + interval_handler;
        runtime::character_recurring_registration registration;
        registration.effect_handler = effect_handler;
        registration.interval_handler = interval_handler;
        registration.due_variable = "__ccb_recurring_" +
                                    std::to_string( runtime_hash( identity ) );
        if( std::any_of(
                owner->character_recurring_handlers.begin(),
                owner->character_recurring_handlers.end(),
        [&registration]( const runtime::character_recurring_registration & entry ) {
        return entry.due_variable == registration.due_variable;
    } ) ) {
            throw std::runtime_error(
                "character recurring state-key collision" );
        }
        owner->character_recurring_handlers.push_back(
            std::move( registration ) );
    } );
    runtime_api.set_function( "on", [weak]( const std::string & event_name,
    const std::string & handler_id ) {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner ) {
            throw std::runtime_error( "stale Platform runtime" );
        }
        if( event_name.empty() || handler_id.empty() ) {
            throw std::runtime_error( "event and handler ids cannot be empty" );
        }
        const bool lifecycle = event_name == "world_ready" || event_name == "before_save" ||
                               event_name == "after_save" || event_name == "shutdown";
        if( !lifecycle && ( event_name.size() <= 5 || event_name.compare( 0, 5, "game:" ) != 0 ) ) {
            throw std::runtime_error( "event must be a lifecycle name or game:<event>" );
        }
        if( !lifecycle && !platform_event_contract_exists(
                std::string_view( event_name ).substr( 5 ) ) ) {
            throw std::runtime_error( "unknown native event '" + event_name + "'" );
        }
        std::vector<std::string> &subscriptions = owner->subscriptions[event_name];
        if( std::find( subscriptions.begin(), subscriptions.end(), handler_id ) !=
            subscriptions.end() ) {
            throw std::runtime_error( "duplicate event subscription '" + event_name +
                                      "' for handler '" + handler_id + "'" );
        }
        subscriptions.push_back( handler_id );
    } );
    runtime_api.set_function( "migrate_task_payload", [weak](
                                  const std::string & handler_id, const std::int64_t from_version,
    const std::int64_t to_version, const sol::object & callback ) {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner ) {
            throw std::runtime_error( "stale Platform runtime" );
        }
        if( handler_id.empty() || handler_id.find( '#' ) != std::string::npos ) {
            throw std::runtime_error(
                "task migration handler id must be non-empty and cannot contain '#'" );
        }
        if( from_version <= 0 || to_version <= 0 ||
            from_version > std::numeric_limits<int>::max() ||
            to_version > std::numeric_limits<int>::max() ||
            from_version == to_version ) {
            throw std::runtime_error( "task migration versions are outside the native range" );
        }
        if( callback.get_type() != sol::type::function ) {
            throw std::runtime_error( "task migration callback must be a Lua function" );
        }
        std::map<int, task_payload_migration> &migrations =
            owner->task_migrations[handler_id];
        const int source = static_cast<int>( from_version );
        if( !migrations.emplace( source, task_payload_migration{
        static_cast<int>( to_version ), callback.as<sol::protected_function>()
        } ).second ) {
            throw std::runtime_error(
                "duplicate task payload migration for handler '" + handler_id +
                "' from version " + std::to_string( from_version ) );
        }
    } );
    runtime_api.set_function( "hook", [weak]( const std::string & hook_name,
    const std::string & handler_id ) {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner ) {
            throw std::runtime_error( "stale Platform runtime" );
        }
        if( hook_name.empty() || !cata::lua_platform::native_hook_contract_exists( hook_name ) ) {
            throw std::runtime_error( "unknown native hook '" + hook_name + "'" );
        }
        if( handler_id.empty() ) {
            throw std::runtime_error( "native hook handler id cannot be empty" );
        }
        std::vector<std::string> &handlers = owner->hooks[hook_name];
        if( std::find( handlers.begin(), handlers.end(), handler_id ) != handlers.end() ) {
            throw std::runtime_error( "duplicate native hook subscription '" + hook_name +
                                      "' for handler '" + handler_id + "'" );
        }
        handlers.push_back( handler_id );
    } );
    runtime_api.set_function( "dialogue_topic", [weak]( const std::string & topic_id,
    const std::string & handler_id ) {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner ) {
            throw std::runtime_error( "stale Platform runtime" );
        }
        if( topic_id.empty() || topic_id.size() > 256 ||
            topic_id.find( '\0' ) != std::string::npos ) {
            throw std::runtime_error( "dialogue topic id must contain 1 to 256 non-NUL bytes" );
        }
        if( handler_id.empty() ) {
            throw std::runtime_error( "dialogue topic handler id cannot be empty" );
        }
        if( owner->declarative_dialogue_topics.count( topic_id ) != 0 ) {
            throw std::runtime_error(
                "dialogue topic conflicts with ccb.dialogue.register_topic '" +
                topic_id + "'" );
        }
        if( owner->dialogue_topics.size() >= maximum_platform_dialogue_topics ) {
            throw std::runtime_error( "dialogue topic registration limit reached" );
        }
        if( !owner->dialogue_topics.emplace( topic_id, handler_id ).second ) {
            throw std::runtime_error( "duplicate dialogue topic '" + topic_id + "'" );
        }
    } );
    ccb["runtime"] = std::move( runtime_api );

}

} // namespace detail

using detail::apply_platform_hook_table;
using detail::callback_scope;
using detail::persistent_item_hint;
using detail::persistent_task_item_hint;
using detail::platform_callback_payload;
using detail::platform_callback_talker_to_lua;
using detail::platform_creature_handle;
using detail::platform_event_character;
using detail::platform_item_handle;
using detail::platform_talker_to_lua;
using detail::platform_vehicle_handle;
using detail::report_callback_error;

bool has_runtime_hook( const std::string_view name )
{
    return std::any_of( detail::active_runtime_values().begin(), detail::active_runtime_values().end(),
    [name]( const std::shared_ptr<runtime> &owner ) {
        if( !owner || !owner->world_is_ready ) {
            return false;
        }
        const auto found = owner->hooks.find( std::string( name ) );
        return found != owner->hooks.end() && !found->second.empty();
    } );
}

cata::lua_platform::native_hook_result dispatch_runtime_hook(
    const std::string_view name,
    const cata::lua_platform::native_callback_arguments &arguments,
    const cata::lua_platform::native_hook_result &initial )
{
    cata::lua_platform::native_hook_result aggregate = initial;
    if( cata::lua_platform::native_hook_supports_result_field( name, "allow" ) &&
        !aggregate.allowed ) {
        return aggregate;
    }
    for( const std::shared_ptr<runtime> &owner : detail::active_runtime_values() ) {
        if( !owner || !owner->world_is_ready ) {
            continue;
        }
        const auto subscription = owner->hooks.find( std::string( name ) );
        if( subscription == owner->hooks.end() ) {
            continue;
        }
        const std::vector<std::string> handler_ids = subscription->second;
        sol::object previous = sol::make_object( *owner->lua, sol::lua_nil );
        for( const std::string &handler_id : handler_ids ) {
            const auto handler = owner->handlers.find( handler_id );
            if( handler == owner->handlers.end() ) {
                continue;
            }
            if( owner->callback_depth >= 16 ) {
                DebugLog( D_ERROR, D_MAIN ) << "Lua-first native hook recursion limit reached for '"
                                            << owner->mod_id << ':' << name << "'";
                continue;
            }
            sol::table payload = platform_callback_payload( *owner, arguments );
            payload["hook"] = std::string( name );
            payload["cancellable"] =
                cata::lua_platform::native_hook_supports_result_field( name, "allow" );
            sol::table shared = owner->lua->create_table();
            shared["allowed"] = aggregate.allowed;
            shared["handled"] = aggregate.handled;
            shared["text"] = aggregate.text;
            if( aggregate.result ) {
                shared["result"] = *aggregate.result;
            }
            sol::table strings = owner->lua->create_table();
            for( std::size_t index = 0; index < aggregate.results.size(); ++index ) {
                strings[index + 1] = aggregate.results[index];
            }
            shared["results"] = std::move( strings );
            payload["results"] = shared;
            payload["prev"] = previous;

            sol::protected_function callback = handler->second.callback;
            callback_scope scope( *owner );
            const sol::protected_function_result result = callback( payload );
            if( !result.valid() ) {
                report_callback_error( *owner, handler_id, result );
                continue;
            }

            bool stop = false;
            cata::lua_platform::native_hook_result candidate = aggregate;
            try {
                apply_platform_hook_table( name, shared, candidate, stop, true );
            } catch( const std::exception &exception ) {
                DebugLog( D_ERROR, D_MAIN ) << "Lua-first native hook '" << owner->mod_id
                                            << ':' << handler_id
                                            << "' mutated invalid shared results: "
                                            << exception.what();
                continue;
            }
            sol::object returned = sol::make_object( *owner->lua, sol::lua_nil );
            bool accept_candidate = true;
            if( result.return_count() > 0 ) {
                returned = result.get<sol::object>();
                if( returned.get_type() == sol::type::boolean ) {
                    if( !cata::lua_platform::native_hook_supports_result_field( name, "allow" ) ) {
                        DebugLog( D_ERROR, D_MAIN ) << "Lua-first signal hook '" << name
                                                    << "' ignored a boolean result from '"
                                                    << owner->mod_id << ':' << handler_id << "'";
                    } else {
                        const bool allowed = returned.as<bool>();
                        candidate.allowed = candidate.allowed && allowed;
                        stop = stop || !allowed;
                    }
                } else if( returned.get_type() == sol::type::string &&
                           cata::lua_platform::native_hook_supports_result_field( name, "result" ) ) {
                    const std::string replacement = returned.as<std::string>();
                    if( replacement.size() > 512 ) {
                        DebugLog( D_ERROR, D_MAIN ) << "Lua-first native hook result exceeds 512 bytes";
                        accept_candidate = false;
                    } else {
                        candidate.result = replacement;
                    }
                } else if( returned.get_type() == sol::type::table ) {
                    try {
                        apply_platform_hook_table( name, returned.as<sol::table>(),
                                                   candidate, stop, false );
                    } catch( const std::exception &exception ) {
                        DebugLog( D_ERROR, D_MAIN ) << "Lua-first native hook '" << owner->mod_id
                                                    << ':' << handler_id << "' returned invalid data: "
                                                    << exception.what();
                        accept_candidate = false;
                    }
                } else if( returned.get_type() != sol::type::nil ) {
                    DebugLog( D_ERROR, D_MAIN ) << "Lua-first native hook '" << owner->mod_id
                                                << ':' << handler_id
                                                << "' must return nil, boolean, string, or table";
                    accept_candidate = false;
                }
            }
            if( !accept_candidate ) {
                continue;
            }
            aggregate = std::move( candidate );
            previous = std::move( returned );
            if( stop ) {
                return aggregate;
            }
        }
    }
    return aggregate;
}

bool has_platform_item_use_handler( const std::string_view item_id )
{
    for( auto iterator = detail::active_runtime_values().rbegin();
         iterator != detail::active_runtime_values().rend(); ++iterator ) {
        const std::shared_ptr<runtime> &owner = *iterator;
        if( !owner || !owner->world_is_ready ) {
            continue;
        }
        std::string handler_id;
        if( !owner->content.find_item_handler(
                item_id, "use", handler_id ) ) {
            continue;
        }
        return !handler_id.empty();
    }
    return false;
}

std::optional<int> invoke_platform_item_use_handler(
    Character *character, item &used_item, map *here,
    const tripoint_bub_ms &position )
{
    for( auto iterator = detail::active_runtime_values().rbegin();
         iterator != detail::active_runtime_values().rend(); ++iterator ) {
        const std::shared_ptr<runtime> &owner = *iterator;
        if( !owner || !owner->world_is_ready ) {
            continue;
        }
        std::string handler_id;
        if( !owner->content.find_item_handler(
                used_item.typeId().str(), "use", handler_id ) ) {
            continue;
        }
        if( handler_id.empty() ) {
            return std::nullopt;
        }
        return invoke_use_handler(
                   owner->mod_id, handler_id, character, used_item, here,
                   position );
    }
    return std::nullopt;
}

std::optional<bool> invoke_shop_condition_handler(
    const std::string_view mod_id, const std::string_view owner_id,
    const std::string_view policy_kind, const std::string_view selector_kind,
    const std::string_view selector_id, const std::string_view handler_id,
    const item *candidate, const npc &shopkeeper )
{
    const std::shared_ptr<runtime> owner = detail::find_active_runtime( mod_id );
    if( !owner || !owner->world_is_ready ) {
        return std::nullopt;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first shop policy unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return std::nullopt;
    }

    sol::table payload = platform_callback_payload( *owner, {
        { "avatar", static_cast<const Character *>( &get_avatar() ) },
        { "shopkeeper", static_cast<const Character *>( &shopkeeper ) },
        { "item", candidate },
        { "owner_id", std::string( owner_id ) },
        { "policy_kind", std::string( policy_kind ) },
        { "selector_kind", std::string( selector_kind ) },
        { "selector_id", std::string( selector_id ) }
    } );
    sol::protected_function callback = handler->second.callback;
    callback_scope scope( *owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
        return std::nullopt;
    }
    if( result.return_count() != 1 || result.get_type() != sol::type::boolean ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first shop policy '"
                                    << mod_id << ':' << handler_id
                                    << "' must return exactly one boolean";
        return std::nullopt;
    }
    return result.get<bool>();
}

void invoke_overmap_terrain_handler(
    const std::string_view terrain_id, const std::string_view phase,
    const tripoint_abs_omt &old_position, const tripoint_abs_omt &new_position,
    const Character &character )
{
    for( auto iterator = detail::active_runtime_values().rbegin(); iterator != detail::active_runtime_values().rend(); ++iterator ) {
        const std::shared_ptr<runtime> &owner = *iterator;
        if( !owner ) {
            continue;
        }
        std::string handler_id;
        if( !owner->content.find_overmap_terrain_handler( terrain_id, phase, handler_id ) ) {
            continue;
        }
        if( handler_id.empty() || !owner->world_is_ready ) {
            return;
        }
        const auto handler = owner->handlers.find( handler_id );
        if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first overmap terrain policy unavailable for '"
                                        << owner->mod_id << ':' << handler_id << "'";
            return;
        }
        sol::table payload = owner->lua->create_table();
        payload["terrain_id"] = std::string( terrain_id );
        payload["phase"] = std::string( phase );
        payload["character"] = platform_creature_handle( *owner, character );
        const auto add_position = [&payload, &owner](
        const char *name, const tripoint_abs_omt & value ) {
            sol::table point = owner->lua->create_table();
            point["coordinate_space"] = "abs_omt";
            point["x"] = value.x();
            point["y"] = value.y();
            point["z"] = value.z();
            payload[name] = std::move( point );
        };
        add_position( "old_position", old_position );
        add_position( "new_position", new_position );
        sol::protected_function callback = handler->second.callback;
        callback_scope scope( *owner );
        const sol::protected_function_result result = callback( payload );
        if( !result.valid() ) {
            report_callback_error( *owner, handler_id, result );
        }
        return;
    }
}

namespace
{

sol::table overmap_special_handler_payload(
    runtime &owner, const std::string_view special_id,
    const std::string_view phase, const tripoint_abs_omt &position,
    const int rotation, const std::string_view city_name,
    const int city_size, const int city_population )
{
    sol::table payload = owner.lua->create_table();
    payload["special_id"] = std::string( special_id );
    payload["phase"] = std::string( phase );
    payload["rotation"] = rotation;
    payload["city_name"] = std::string( city_name );
    payload["city_size"] = city_size;
    payload["city_population"] = city_population;
    sol::table point = owner.lua->create_table();
    point["coordinate_space"] = "abs_omt";
    point["x"] = position.x();
    point["y"] = position.y();
    point["z"] = position.z();
    payload["position"] = std::move( point );
    return payload;
}

} // namespace

std::optional<bool> invoke_overmap_special_condition_handler(
    const std::string_view special_id, const tripoint_abs_omt &position,
    const int rotation, const std::string_view city_name, const int city_size,
    const int city_population )
{
    for( auto iterator = detail::active_runtime_values().rbegin(); iterator != detail::active_runtime_values().rend(); ++iterator ) {
        const std::shared_ptr<runtime> &owner = *iterator;
        if( !owner ) {
            continue;
        }
        std::string handler_id;
        if( !owner->content.find_overmap_special_handler(
                special_id, "condition", handler_id ) ) {
            continue;
        }
        if( handler_id.empty() ) {
            return true;
        }
        if( !owner->world_is_ready ) {
            return false;
        }
        const auto handler = owner->handlers.find( handler_id );
        if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first overmap-special condition unavailable for '"
                                        << owner->mod_id << ':' << handler_id << "'";
            return false;
        }
        sol::table payload = overmap_special_handler_payload(
                                 *owner, special_id, "condition", position, rotation,
                                 city_name, city_size, city_population );
        sol::protected_function callback = handler->second.callback;
        callback_scope scope( *owner );
        const sol::protected_function_result result = callback( payload );
        if( !result.valid() ) {
            report_callback_error( *owner, handler_id, result );
            return false;
        }
        if( result.return_count() != 1 || result.get_type() != sol::type::boolean ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first overmap-special condition '"
                                        << owner->mod_id << ':' << handler_id
                                        << "' must return exactly one boolean";
            return false;
        }
        return result.get<bool>();
    }
    return std::nullopt;
}

void invoke_overmap_special_placement_handler(
    const std::string_view special_id, const tripoint_abs_omt &position,
    const int rotation, const std::string_view city_name, const int city_size,
    const int city_population )
{
    for( auto iterator = detail::active_runtime_values().rbegin(); iterator != detail::active_runtime_values().rend(); ++iterator ) {
        const std::shared_ptr<runtime> &owner = *iterator;
        if( !owner ) {
            continue;
        }
        std::string handler_id;
        if( !owner->content.find_overmap_special_handler(
                special_id, "placement", handler_id ) ) {
            continue;
        }
        if( handler_id.empty() || !owner->world_is_ready ) {
            return;
        }
        const auto handler = owner->handlers.find( handler_id );
        if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first overmap-special placement unavailable for '"
                                        << owner->mod_id << ':' << handler_id << "'";
            return;
        }
        sol::table payload = overmap_special_handler_payload(
                                 *owner, special_id, "placement", position, rotation,
                                 city_name, city_size, city_population );
        sol::protected_function callback = handler->second.callback;
        callback_scope scope( *owner );
        const sol::protected_function_result result = callback( payload );
        if( !result.valid() ) {
            report_callback_error( *owner, handler_id, result );
        }
        return;
    }
}

void invoke_vehicle_part_activation_handler(
    const std::string_view part_id, vehicle &subject, vehicle_part &part,
    Character &character )
{
    for( auto iterator = detail::active_runtime_values().rbegin(); iterator != detail::active_runtime_values().rend(); ++iterator ) {
        const std::shared_ptr<runtime> &owner = *iterator;
        if( !owner ) {
            continue;
        }
        std::string handler_id;
        if( !owner->content.find_vehicle_part_handler(
                part_id, "activation", handler_id ) ) {
            continue;
        }
        if( handler_id.empty() || !owner->world_is_ready ) {
            return;
        }
        const auto handler = owner->handlers.find( handler_id );
        if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first vehicle-part activation unavailable for '"
                                        << owner->mod_id << ':' << handler_id << "'";
            return;
        }

        const tripoint_abs_ms position = subject.pos_abs();
        sol::table payload = owner->lua->create_table();
        payload["part_id"] = std::string( part_id );
        payload["part_index"] = subject.index_of_part( &part, true );
        payload["character"] = platform_creature_handle( *owner, character );
        payload["vehicle"] = cata::lua_platform::game_handle::from_vehicle(
        subject, {
            "platform_vehicle_part_activation", 0,
            position.x(), position.y(), position.z(), {}
        }, owner->handle_runtime(), detail::runtime_world_generation_storage() );
        sol::table mount = owner->lua->create_table();
        mount["coordinate_space"] = "vehicle_mount_ms";
        mount["x"] = part.mount.x();
        mount["y"] = part.mount.y();
        mount["z"] = 0;
        payload["mount"] = std::move( mount );

        sol::protected_function callback = handler->second.callback;
        callback_scope scope( *owner );
        const sol::protected_function_result result = callback( payload );
        if( !result.valid() ) {
            report_callback_error( *owner, handler_id, result );
        }
        return;
    }
}

void invoke_character_start_handler(
    const std::string_view kind, const std::string_view definition_id,
    const std::string_view mod_id, const std::string_view handler_id,
    Character &character )
{
    const std::shared_ptr<runtime> owner = detail::find_active_runtime( mod_id );
    if( !owner || !owner->world_is_ready ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first " << kind
                                    << " start runtime unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first " << kind
                                    << " start handler unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return;
    }
    sol::table payload = owner->lua->create_table();
    payload["kind"] = std::string( kind );
    payload["definition_id"] = std::string( definition_id );
    payload["character"] = platform_creature_handle( *owner, character );
    payload["is_avatar"] = character.is_avatar();
    if( const profession *selected = character.get_profession() ) {
        payload["profession_id"] = selected->ident().str();
    } else {
        payload["profession_id"] = sol::lua_nil;
    }
    if( const scenario *selected = get_scenario() ) {
        payload["scenario_id"] = selected->ident().str();
    } else {
        payload["scenario_id"] = sol::lua_nil;
    }
    sol::protected_function callback = handler->second.callback;
    callback_scope scope( *owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
    }
}

void invoke_recipe_completion_handler(
    const std::string_view recipe_id, const std::string_view mod_id,
    const std::string_view handler_id, Character &character, const int batch )
{
    if( mod_id.empty() || handler_id.empty() ) {
        return;
    }
    const std::shared_ptr<runtime> owner = detail::find_active_runtime( mod_id );
    if( !owner || !owner->world_is_ready ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first recipe completion runtime unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first recipe completion handler unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return;
    }
    sol::table payload = owner->lua->create_table();
    payload["recipe_id"] = std::string( recipe_id );
    payload["character"] = platform_creature_handle( *owner, character );
    payload["batch"] = batch;
    sol::protected_function callback = handler->second.callback;
    callback_scope scope( *owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
    }
}

std::optional<bool> invoke_trap_trigger_handler(
    const std::string_view trap_id, const std::string_view mod_id,
    const std::string_view handler_id, const tripoint_abs_ms &position,
    Creature *creature, const item *triggering_item )
{
    if( mod_id.empty() || handler_id.empty() ) {
        return std::nullopt;
    }
    const std::shared_ptr<runtime> owner = detail::find_active_runtime( mod_id );
    if( !owner || !owner->world_is_ready ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first trap runtime unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return false;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first trap handler unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return false;
    }
    sol::table payload = owner->lua->create_table();
    payload["trap_id"] = std::string( trap_id );
    sol::table point = owner->lua->create_table();
    point["coordinate_space"] = "abs_ms";
    point["x"] = position.x();
    point["y"] = position.y();
    point["z"] = position.z();
    payload["position"] = std::move( point );
    if( creature != nullptr ) {
        payload["trigger_kind"] = "creature";
        payload["creature"] = platform_creature_handle( *owner, *creature );
    } else {
        payload["creature"] = sol::lua_nil;
        payload["trigger_kind"] = triggering_item != nullptr ? "item" : "environment";
    }
    if( triggering_item != nullptr ) {
        payload["item_id"] = triggering_item->typeId().str();
    } else {
        payload["item_id"] = sol::lua_nil;
    }
    sol::protected_function callback = handler->second.callback;
    callback_scope scope( *owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
        return false;
    }
    if( result.return_count() == 0 ) {
        return false;
    }
    const sol::object returned = result.get<sol::object>();
    if( returned.get_type() == sol::type::nil ) {
        return false;
    }
    if( returned.get_type() != sol::type::boolean ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first trap handler '" << mod_id << ':'
                                    << handler_id << "' must return nil or one boolean";
        return false;
    }
    return returned.as<bool>();
}

void invoke_plant_lifecycle_handlers(
    const std::string_view phase, Character &character, map &here,
    const tripoint_bub_ms &position, const std::string_view seed_id_value,
    const std::string_view old_stage, const std::string_view new_stage,
    const int effective_growth_turns, const int water,
    const std::map<std::string, std::string> &string_context,
    const std::map<std::string, double> &number_context )
{
    const std::string seed_id( seed_id_value );
    const std::string furniture_id = here.furn( position ).id().str();
    const tripoint_abs_ms absolute = here.get_abs( position );
    for( auto iterator = detail::active_runtime_values().rbegin(); iterator != detail::active_runtime_values().rend(); ++iterator ) {
        const std::shared_ptr<runtime> &owner = *iterator;
        if( !owner || !owner->world_is_ready ) {
            continue;
        }
        const auto dispatch_target = [&]( const std::string_view target,
        const std::string & target_id ) {
            std::string handler_id;
            if( !owner->content.find_plant_lifecycle_handler(
                    target, target_id, phase, handler_id ) || handler_id.empty() ) {
                return;
            }
            const auto handler = owner->handlers.find( handler_id );
            if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
                DebugLog( D_ERROR, D_MAIN )
                        << "Lua-first plant lifecycle handler unavailable for '"
                        << owner->mod_id << ':' << handler_id << "'";
                return;
            }
            sol::table payload = owner->lua->create_table();
            payload["phase"] = std::string( phase );
            payload["target"] = std::string( target );
            payload["target_id"] = target_id;
            payload["seed_id"] = seed_id;
            payload["furniture_id"] = furniture_id;
            payload["old_stage"] = std::string( old_stage );
            payload["new_stage"] = std::string( new_stage );
            payload["effective_growth_turns"] = effective_growth_turns;
            payload["water"] = water;
            payload["character"] = platform_creature_handle( *owner, character );
            sol::table position_value = owner->lua->create_table();
            position_value["coordinate_space"] = "abs_ms";
            position_value["x"] = absolute.x();
            position_value["y"] = absolute.y();
            position_value["z"] = absolute.z();
            payload["position"] = std::move( position_value );
            sol::table strings = owner->lua->create_table();
            for( const auto &[key, value] : string_context ) {
                strings[key] = value;
            }
            payload["strings"] = std::move( strings );
            sol::table numbers = owner->lua->create_table();
            for( const auto &[key, value] : number_context ) {
                numbers[key] = value;
            }
            payload["numbers"] = std::move( numbers );
            sol::protected_function callback = handler->second.callback;
            callback_scope scope( *owner );
            const sol::protected_function_result result = callback( payload );
            if( !result.valid() ) {
                report_callback_error( *owner, handler_id, result );
            }
        };
        dispatch_target( "furniture", furniture_id );
        dispatch_target( "seed", seed_id );
    }
}

void invoke_martial_art_handler( const std::string_view martial_art_id,
                                 const std::string_view phase,
                                 Character &character )
{
    for( auto iterator = detail::active_runtime_values().rbegin(); iterator != detail::active_runtime_values().rend(); ++iterator ) {
        const std::shared_ptr<runtime> &owner = *iterator;
        if( !owner ) {
            continue;
        }
        std::string handler_id;
        if( !owner->content.find_martial_art_handler(
                martial_art_id, phase, handler_id ) ) {
            continue;
        }
        if( handler_id.empty() || !owner->world_is_ready ) {
            return;
        }
        const auto handler = owner->handlers.find( handler_id );
        if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
            DebugLog( D_ERROR, D_MAIN )
                    << "Lua-first martial-art handler unavailable for '"
                    << owner->mod_id << ':' << handler_id << "'";
            return;
        }
        sol::table payload = owner->lua->create_table();
        payload["martial_art_id"] = std::string( martial_art_id );
        payload["phase"] = std::string( phase );
        payload["character"] = platform_creature_handle( *owner, character );
        sol::protected_function callback = handler->second.callback;
        callback_scope scope( *owner );
        const sol::protected_function_result result = callback( payload );
        if( !result.valid() ) {
            report_callback_error( *owner, handler_id, result );
        }
        return;
    }
}

void invoke_technique_application_handler(
    const std::string_view technique_id, const std::string_view mod_id,
    const std::string_view handler_id, Character &attacker, Creature &target,
    const int repeat_index, const int repeat_count, const double total_damage,
    const std::string_view weapon_id )
{
    if( mod_id.empty() || handler_id.empty() ) {
        return;
    }
    const std::shared_ptr<runtime> owner = detail::find_active_runtime( mod_id );
    if( !owner || !owner->world_is_ready ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first technique runtime unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first technique handler unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return;
    }
    sol::table payload = owner->lua->create_table();
    payload["technique_id"] = std::string( technique_id );
    payload["attacker"] = platform_creature_handle( *owner, attacker );
    payload["target"] = platform_creature_handle( *owner, target );
    payload["repeat_index"] = repeat_index;
    payload["repeat_count"] = repeat_count;
    if( total_damage < 0 ) {
        payload["total_damage"] = sol::lua_nil;
    } else {
        payload["total_damage"] = total_damage;
    }
    if( weapon_id.empty() ) {
        payload["weapon_id"] = sol::lua_nil;
    } else {
        payload["weapon_id"] = std::string( weapon_id );
    }
    sol::protected_function callback = handler->second.callback;
    callback_scope scope( *owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
    }
}

void invoke_item_consumption_handler(
    const std::string_view item_id, const std::string_view mod_id,
    const std::string_view handler_id, Character &character, item &consumed_item )
{
    if( mod_id.empty() || handler_id.empty() ) {
        return;
    }
    const std::shared_ptr<runtime> owner = detail::find_active_runtime( mod_id );
    if( !owner || !owner->world_is_ready ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first consumption runtime unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first consumption handler unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return;
    }
    sol::table payload = owner->lua->create_table();
    payload["item_id"] = std::string( item_id );
    payload["character"] = platform_creature_handle( *owner, character );
    payload["item"] = cata::lua_platform::game_handle::from_item(
    consumed_item, {
        "platform_item_consumption", consumed_item.uid().get_value(), 0, 0, 0, {}
    }, owner->handle_runtime(), detail::runtime_world_generation_storage() );
    sol::protected_function callback = handler->second.callback;
    callback_scope scope( *owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
    }
}

void invoke_weakpoint_effect_handler(
    const std::string_view set_id, const std::string_view weakpoint_id,
    const std::string_view mod_id, const std::string_view handler_id,
    Creature &target, const int total_damage, const weakpoint_attack &attack )
{
    if( mod_id.empty() || handler_id.empty() ) {
        return;
    }
    const std::shared_ptr<runtime> owner = detail::find_active_runtime( mod_id );
    if( !owner || !owner->world_is_ready ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first weakpoint runtime unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first weakpoint handler unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return;
    }
    const auto attack_type_name = []( const weakpoint_attack::attack_type type ) {
        switch( type ) {
            case weakpoint_attack::attack_type::NONE:
                return "none";
            case weakpoint_attack::attack_type::MELEE_BASH:
                return "melee_bash";
            case weakpoint_attack::attack_type::MELEE_CUT:
                return "melee_cut";
            case weakpoint_attack::attack_type::MELEE_STAB:
                return "melee_stab";
            case weakpoint_attack::attack_type::PROJECTILE:
                return "projectile";
            case weakpoint_attack::attack_type::NUM:
                break;
        }
        return "unknown";
    };
    sol::table payload = owner->lua->create_table();
    payload["set_id"] = std::string( set_id );
    payload["weakpoint_id"] = std::string( weakpoint_id );
    payload["target"] = platform_creature_handle( *owner, target );
    if( attack.source != nullptr ) {
        payload["source"] = platform_creature_handle( *owner, *attack.source );
    } else {
        payload["source"] = sol::lua_nil;
    }
    if( attack.weapon != nullptr ) {
        payload["weapon_id"] = attack.weapon->typeId().str();
    } else {
        payload["weapon_id"] = sol::lua_nil;
    }
    payload["attack_type"] = attack_type_name( attack.type );
    payload["total_damage"] = total_damage;
    payload["is_thrown"] = attack.is_thrown;
    payload["accuracy"] = attack.accuracy;
    payload["is_critical"] = attack.is_crit;
    payload["weakpoint_skill"] = attack.wp_skill;
    sol::protected_function callback = handler->second.callback;
    callback_scope scope( *owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
    }
}

std::optional<bool> invoke_behavior_condition_handler(
    const std::string_view mod_id, const std::string_view behavior_id,
    const std::string_view handler_id, const Creature *subject,
    const std::string_view argument )
{
    const std::shared_ptr<runtime> owner = detail::find_active_runtime( mod_id );
    if( !owner || !owner->world_is_ready ) {
        return std::nullopt;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first behavior condition unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return std::nullopt;
    }

    sol::table payload = owner->lua->create_table();
    payload["behavior_id"] = std::string( behavior_id );
    payload["argument"] = std::string( argument );
    if( subject == nullptr ) {
        payload["subject_kind"] = "none";
        payload["subject"] = sol::lua_nil;
    } else {
        payload["subject_kind"] = subject->is_avatar() ? "avatar" :
                                  subject->is_npc() ? "npc" :
                                  subject->is_monster() ? "monster" : "creature";
        payload["subject"] = platform_creature_handle( *owner, *subject );
    }

    sol::protected_function callback = handler->second.callback;
    callback_scope scope( *owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
        return std::nullopt;
    }
    if( result.return_count() != 1 || result.get_type() != sol::type::boolean ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first behavior condition '"
                                    << mod_id << ':' << handler_id
                                    << "' must return exactly one boolean";
        return std::nullopt;
    }
    return result.get<bool>();
}

std::optional<bool> invoke_shopkeeper_whitelist_handler(
    const std::string_view mod_id, const std::string_view handler_id,
    const item &candidate, const npc &shopkeeper )
{
    const std::shared_ptr<runtime> owner = detail::find_active_runtime( mod_id );
    if( !owner || !owner->world_is_ready ) {
        return std::nullopt;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first shopkeeper whitelist unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return std::nullopt;
    }

    sol::table payload = owner->lua->create_table();
    sol::table item_value = owner->lua->create_table();
    item_value["id"] = cata::lua_platform::script_game_id(
                           "item", candidate.typeId().str() );
    item_value["category_id"] = candidate.get_category_shallow().get_id().str();
    item_value["comestible"] = candidate.is_comestible();
    item_value["food"] = candidate.is_food();
    item_value["medication"] = candidate.is_medication();
    item_value["base_enjoyment"] = candidate.is_comestible() ?
                                     candidate.get_comestible()->get_fun() : 0;
    item_value["fresh"] = candidate.is_fresh();
    item_value["going_bad"] = candidate.is_going_bad();
    item_value["rotten"] = candidate.rotten();
    payload["item"] = std::move( item_value );

    sol::table shopkeeper_value = owner->lua->create_table();
    shopkeeper_value["name"] = shopkeeper.get_name();
    shopkeeper_value["class_id"] = shopkeeper.myclass.str();
    shopkeeper_value["faction_id"] = shopkeeper.get_fac_id().str();
    payload["shopkeeper"] = std::move( shopkeeper_value );

    sol::protected_function callback = handler->second.callback;
    callback_scope scope( *owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
        return std::nullopt;
    }
    if( result.return_count() != 1 || result.get_type() != sol::type::boolean ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first shopkeeper whitelist '"
                                    << mod_id << ':' << handler_id
                                    << "' must return exactly one boolean";
        return std::nullopt;
    }
    return result.get<bool>();
}

std::optional<double> invoke_behavior_score_handler(
    const std::string_view mod_id, const std::string_view behavior_id,
    const std::string_view handler_id, const Creature *subject,
    const std::string_view argument )
{
    const std::shared_ptr<runtime> owner = detail::find_active_runtime( mod_id );
    if( !owner || !owner->world_is_ready ) {
        return std::nullopt;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first behavior score unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return std::nullopt;
    }

    sol::table payload = owner->lua->create_table();
    payload["behavior_id"] = std::string( behavior_id );
    payload["argument"] = std::string( argument );
    if( subject == nullptr ) {
        payload["subject_kind"] = "none";
        payload["subject"] = sol::lua_nil;
    } else {
        payload["subject_kind"] = subject->is_avatar() ? "avatar" :
                                  subject->is_npc() ? "npc" :
                                  subject->is_monster() ? "monster" : "creature";
        payload["subject"] = platform_creature_handle( *owner, *subject );
    }

    sol::protected_function callback = handler->second.callback;
    callback_scope scope( *owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
        return std::nullopt;
    }
    if( result.return_count() != 1 || result.get_type() != sol::type::number ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first behavior score '"
                                    << mod_id << ':' << handler_id
                                    << "' must return exactly one finite number";
        return std::nullopt;
    }
    const double value = result.get<double>();
    if( !std::isfinite( value ) ||
        std::abs( value ) > std::numeric_limits<float>::max() ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first behavior score '"
                                    << mod_id << ':' << handler_id
                                    << "' returned a value outside the native float range";
        return std::nullopt;
    }
    return value;
}

std::optional<bool> invoke_monster_attack_handler(
    const std::string_view mod_id, const std::string_view attack_id,
    const std::string_view handler_id, Creature &attacker )
{
    const std::shared_ptr<runtime> owner = detail::find_active_runtime( mod_id );
    if( !owner || !owner->world_is_ready ) {
        return std::nullopt;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first monster attack unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return std::nullopt;
    }

    sol::table payload = owner->lua->create_table();
    payload["attack_id"] = std::string( attack_id );
    payload["attacker"] = platform_creature_handle( *owner, attacker );
    Creature *target = nullptr;
    if( monster *attacking_monster = attacker.as_monster() ) {
        target = attacking_monster->attack_target();
    }
    payload["target"] = target == nullptr ?
                        sol::make_object( *owner->lua, sol::lua_nil ) :
                        sol::make_object( *owner->lua,
                                          platform_creature_handle( *owner, *target ) );

    sol::protected_function callback = handler->second.callback;
    callback_scope scope( *owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
        return std::nullopt;
    }
    if( result.return_count() != 1 || result.get_type() != sol::type::boolean ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first monster attack '"
                                    << mod_id << ':' << handler_id
                                    << "' must return exactly one boolean";
        return std::nullopt;
    }
    return result.get<bool>();
}

void invoke_monster_attack_result_handler(
    const std::string_view monster_type_id, const std::string_view attack_id,
    const std::string_view mod_id, const std::string_view handler_id,
    Creature &attacker, Creature *target, const int total_damage )
{
    if( mod_id.empty() || handler_id.empty() ) {
        return;
    }
    const std::shared_ptr<runtime> owner = detail::find_active_runtime( mod_id );
    if( !owner || !owner->world_is_ready ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first monster attack result runtime unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first monster attack result handler unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return;
    }
    sol::table payload = owner->lua->create_table();
    payload["monster_type_id"] = std::string( monster_type_id );
    payload["attack_id"] = std::string( attack_id );
    payload["attacker"] = platform_creature_handle( *owner, attacker );
    payload["target"] = target == nullptr ?
                        sol::make_object( *owner->lua, sol::lua_nil ) :
                        sol::make_object( *owner->lua,
                                          platform_creature_handle( *owner, *target ) );
    payload["total_damage"] = total_damage;
    sol::protected_function callback = handler->second.callback;
    callback_scope scope( *owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
    }
}

void invoke_monster_death_handler(
    const std::string_view monster_type_id, const std::string_view mod_id,
    const std::string_view handler_id, Creature &monster, Creature *killer,
    const tripoint_abs_ms &position )
{
    if( mod_id.empty() || handler_id.empty() ) {
        return;
    }
    const std::shared_ptr<runtime> owner = detail::find_active_runtime( mod_id );
    if( !owner || !owner->world_is_ready ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first monster death runtime unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first monster death handler unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return;
    }
    sol::table payload = owner->lua->create_table();
    payload["monster_type_id"] = std::string( monster_type_id );
    payload["monster"] = platform_creature_handle( *owner, monster );
    payload["killer"] = killer == nullptr ?
                        sol::make_object( *owner->lua, sol::lua_nil ) :
                        sol::make_object( *owner->lua,
                                          platform_creature_handle( *owner, *killer ) );
    sol::table point = owner->lua->create_table();
    point["coordinate_space"] = "abs_ms";
    point["x"] = position.x();
    point["y"] = position.y();
    point["z"] = position.z();
    payload["position"] = std::move( point );
    sol::protected_function callback = handler->second.callback;
    callback_scope scope( *owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
    }
}

std::optional<bool> invoke_npc_death_handler(
    const std::string_view npc_template_id, const std::string_view mod_id,
    const std::string_view handler_id, npc &subject, Creature *killer,
    const tripoint_abs_ms &position )
{
    if( mod_id.empty() || handler_id.empty() ) {
        return std::nullopt;
    }
    const std::shared_ptr<runtime> owner = detail::find_active_runtime( mod_id );
    if( !owner || !owner->world_is_ready ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first NPC death runtime unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return false;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first NPC death handler unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return false;
    }
    sol::table payload = owner->lua->create_table();
    payload["npc_template_id"] = std::string( npc_template_id );
    payload["npc"] = platform_creature_handle( *owner, subject );
    payload["killer"] = killer == nullptr ?
                        sol::make_object( *owner->lua, sol::lua_nil ) :
                        sol::make_object( *owner->lua,
                                          platform_creature_handle( *owner, *killer ) );
    sol::table point = owner->lua->create_table();
    point["coordinate_space"] = "abs_ms";
    point["x"] = position.x();
    point["y"] = position.y();
    point["z"] = position.z();
    payload["position"] = std::move( point );
    sol::protected_function callback = handler->second.callback;
    callback_scope scope( *owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
        return false;
    }
    if( result.return_count() == 0 || result.get_type() == sol::type::nil ) {
        return true;
    }
    if( result.return_count() != 1 || result.get_type() != sol::type::boolean ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first NPC death handler '"
                                    << mod_id << ':' << handler_id
                                    << "' must return a boolean or nil";
        return false;
    }
    return result.get<bool>();
}

void invoke_examine_handler(
    const std::string_view target_kind, const std::string_view target_id,
    const std::string_view mod_id, const std::string_view handler_id,
    Character &character, const tripoint_bub_ms &position )
{
    if( mod_id.empty() || handler_id.empty() ) {
        return;
    }
    const std::shared_ptr<runtime> owner = detail::find_active_runtime( mod_id );
    if( !owner || !owner->world_is_ready ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first examine runtime unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first examine handler unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return;
    }
    map &here = get_map();
    const tripoint_abs_ms absolute = here.get_abs( position );
    sol::table payload = owner->lua->create_table();
    payload["target_kind"] = std::string( target_kind );
    payload["target_id"] = std::string( target_id );
    payload["terrain_id"] = here.ter( position ).id().str();
    payload["furniture_id"] = here.furn( position ).id().str();
    payload["character"] = platform_creature_handle( *owner, character );
    sol::table point = owner->lua->create_table();
    point["coordinate_space"] = "abs_ms";
    point["x"] = absolute.x();
    point["y"] = absolute.y();
    point["z"] = absolute.z();
    payload["position"] = std::move( point );
    sol::protected_function callback = handler->second.callback;
    callback_scope scope( *owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
    }
}

void invoke_damage_type_handler( const std::string_view damage_id,
                                 const std::string_view phase,
                                 Creature *source, Creature *target,
                                 const std::string_view body_part,
                                 const double total_damage,
                                 const double damage_taken )
{
    for( auto iterator = detail::active_runtime_values().rbegin(); iterator != detail::active_runtime_values().rend(); ++iterator ) {
        const std::shared_ptr<runtime> &owner = *iterator;
        if( !owner ) {
            continue;
        }
        std::string handler_id;
        if( !owner->content.find_damage_handler( damage_id, phase, handler_id ) ) {
            continue;
        }
        // A later replacement owns the definition even when it deliberately
        // omits this callback, so an earlier layer must not leak through.
        if( handler_id.empty() || !owner->world_is_ready ) {
            return;
        }
        const auto handler = owner->handlers.find( handler_id );
        if( handler == owner->handlers.end() ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first damage handler '"
                                        << owner->mod_id << ':' << handler_id
                                        << "' is no longer registered";
            return;
        }
        if( owner->callback_depth >= 16 ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first damage handler recursion limit reached for '"
                                        << owner->mod_id << ':' << handler_id << "'";
            return;
        }
        sol::table payload = owner->lua->create_table();
        payload["damage_type_id"] = std::string( damage_id );
        payload["phase"] = std::string( phase );
        payload["body_part"] = std::string( body_part );
        payload["total_damage"] = total_damage;
        payload["damage_taken"] = damage_taken;
        payload["source"] = source ?
                            sol::make_object( *owner->lua,
                                              platform_creature_handle( *owner, *source ) ) :
                            sol::make_object( *owner->lua, sol::lua_nil );
        payload["target"] = target ?
                            sol::make_object( *owner->lua,
                                              platform_creature_handle( *owner, *target ) ) :
                            sol::make_object( *owner->lua, sol::lua_nil );
        sol::protected_function callback = handler->second.callback;
        callback_scope scope( *owner );
        const sol::protected_function_result result = callback( payload );
        if( !result.valid() ) {
            report_callback_error( *owner, handler_id, result );
        }
        return;
    }
}

void invoke_ammo_effect_handler( const std::string_view ammo_effect_id,
                                 Creature *source, Creature *target,
                                 const tripoint_bub_ms &position,
                                 const int dealt_damage )
{
    for( auto iterator = detail::active_runtime_values().rbegin(); iterator != detail::active_runtime_values().rend(); ++iterator ) {
        const std::shared_ptr<runtime> &owner = *iterator;
        if( !owner ) {
            continue;
        }
        std::string handler_id;
        if( !owner->content.find_ammo_effect_handler( ammo_effect_id, handler_id ) ) {
            continue;
        }
        // The most recent replacement owns the effect even if it deliberately
        // has no Lua impact policy.
        if( handler_id.empty() || !owner->world_is_ready ) {
            return;
        }
        const auto handler = owner->handlers.find( handler_id );
        if( handler == owner->handlers.end() ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first ammo-effect handler '"
                                        << owner->mod_id << ':' << handler_id
                                        << "' is no longer registered";
            return;
        }
        if( owner->callback_depth >= 16 ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first ammo-effect handler recursion limit reached for '"
                                        << owner->mod_id << ':' << handler_id << "'";
            return;
        }
        sol::table payload = owner->lua->create_table();
        payload["ammo_effect_id"] = std::string( ammo_effect_id );
        payload["dealt_damage"] = dealt_damage;
        payload["source"] = source ?
                            sol::make_object( *owner->lua,
                                              platform_creature_handle( *owner, *source ) ) :
                            sol::make_object( *owner->lua, sol::lua_nil );
        payload["target"] = target ?
                            sol::make_object( *owner->lua,
                                              platform_creature_handle( *owner, *target ) ) :
                            sol::make_object( *owner->lua, sol::lua_nil );
        sol::table point = owner->lua->create_table();
        point["coordinate_space"] = "bub_ms";
        point["x"] = position.x();
        point["y"] = position.y();
        point["z"] = position.z();
        payload["position"] = std::move( point );
        sol::protected_function callback = handler->second.callback;
        callback_scope scope( *owner );
        const sol::protected_function_result result = callback( payload );
        if( !result.valid() ) {
            report_callback_error( *owner, handler_id, result );
        }
        return;
    }
}

std::optional<bool> invoke_addiction_type_handler(
    const std::string_view addiction_type_id, Character &character,
    const int intensity, const std::int64_t sated_turns )
{
    for( auto iterator = detail::active_runtime_values().rbegin(); iterator != detail::active_runtime_values().rend(); ++iterator ) {
        const std::shared_ptr<runtime> &owner = *iterator;
        if( !owner ) {
            continue;
        }
        std::string handler_id;
        if( !owner->content.find_addiction_type_handler( addiction_type_id, handler_id ) ) {
            continue;
        }
        if( handler_id.empty() || !owner->world_is_ready ) {
            return false;
        }
        const auto handler = owner->handlers.find( handler_id );
        if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first addiction policy unavailable for '"
                                        << owner->mod_id << ':' << handler_id << "'";
            return false;
        }
        sol::table payload = owner->lua->create_table();
        payload["addiction_type_id"] = std::string( addiction_type_id );
        payload["intensity"] = intensity;
        payload["sated_turns"] = sated_turns;
        payload["character"] = platform_creature_handle( *owner, character );
        sol::protected_function callback = handler->second.callback;
        callback_scope scope( *owner );
        const sol::protected_function_result result = callback( payload );
        if( !result.valid() ) {
            report_callback_error( *owner, handler_id, result );
            return false;
        }
        if( result.return_count() != 1 || result.get_type() != sol::type::boolean ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first addiction policy '"
                                        << owner->mod_id << ':' << handler_id
                                        << "' must return one boolean";
            return false;
        }
        return result.get<bool>();
    }
    return std::nullopt;
}

std::optional<double> invoke_character_modifier_handler(
    const std::string_view modifier_id, const Character &character,
    const std::string_view skill_id_value )
{
    for( auto iterator = detail::active_runtime_values().rbegin(); iterator != detail::active_runtime_values().rend(); ++iterator ) {
        const std::shared_ptr<runtime> &owner = *iterator;
        if( !owner ) {
            continue;
        }
        std::string handler_id;
        if( !owner->content.find_character_modifier_handler( modifier_id, handler_id ) ) {
            continue;
        }
        if( handler_id.empty() || !owner->world_is_ready ) {
            return 0.0;
        }
        const auto handler = owner->handlers.find( handler_id );
        if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first character-modifier evaluator unavailable for '"
                                        << owner->mod_id << ':' << handler_id << "'";
            return 0.0;
        }
        sol::table payload = owner->lua->create_table();
        payload["modifier_id"] = std::string( modifier_id );
        payload["skill_id"] = std::string( skill_id_value );
        payload["character"] = platform_creature_handle( *owner, character );
        sol::protected_function callback = handler->second.callback;
        callback_scope scope( *owner );
        const sol::protected_function_result result = callback( payload );
        if( !result.valid() ) {
            report_callback_error( *owner, handler_id, result );
            return 0.0;
        }
        if( result.return_count() != 1 || result.get_type() != sol::type::number ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first character-modifier evaluator '"
                                        << owner->mod_id << ':' << handler_id
                                        << "' must return one finite number";
            return 0.0;
        }
        const double value = result.get<double>();
        if( !std::isfinite( value ) ||
            std::abs( value ) > std::numeric_limits<float>::max() ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first character-modifier evaluator '"
                                        << owner->mod_id << ':' << handler_id
                                        << "' returned a value outside the native float range";
            return 0.0;
        }
        return value;
    }
    return std::nullopt;
}

std::optional<bool> invoke_weather_type_handler(
    const std::string_view weather_type_id_value, const w_point &sample )
{
    for( auto iterator = detail::active_runtime_values().rbegin(); iterator != detail::active_runtime_values().rend(); ++iterator ) {
        const std::shared_ptr<runtime> &owner = *iterator;
        if( !owner ) {
            continue;
        }
        std::string handler_id;
        if( !owner->content.find_weather_type_handler(
                weather_type_id_value, handler_id ) ) {
            continue;
        }
        if( handler_id.empty() || !owner->world_is_ready ) {
            return false;
        }
        const auto handler = owner->handlers.find( handler_id );
        if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first weather condition unavailable for '"
                                        << owner->mod_id << ':' << handler_id << "'";
            return false;
        }
        sol::table payload = owner->lua->create_table();
        payload["weather_type_id"] = std::string( weather_type_id_value );
        payload["temperature_kelvin"] = units::to_kelvin( sample.temperature );
        payload["humidity"] = sample.humidity;
        payload["pressure"] = sample.pressure;
        payload["windpower"] = sample.windpower;
        payload["wind_description"] = sample.wind_desc;
        payload["wind_direction"] = sample.winddirection;
        payload["turn"] = to_turn<std::int64_t>( sample.time.t );
        sol::table location = owner->lua->create_table();
        location["coordinate_space"] = "abs_ms";
        location["x"] = sample.location.x();
        location["y"] = sample.location.y();
        location["z"] = sample.location.z();
        payload["location"] = std::move( location );
        sol::protected_function callback = handler->second.callback;
        callback_scope scope( *owner );
        const sol::protected_function_result result = callback( payload );
        if( !result.valid() ) {
            report_callback_error( *owner, handler_id, result );
            return false;
        }
        if( result.return_count() != 1 || result.get_type() != sol::type::boolean ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first weather condition '"
                                        << owner->mod_id << ':' << handler_id
                                        << "' must return one boolean";
            return false;
        }
        return result.get<bool>();
    }
    return std::nullopt;
}

std::optional<bool> invoke_end_screen_handler(
    const std::string_view end_screen_id_value, const Character &character )
{
    for( auto iterator = detail::active_runtime_values().rbegin(); iterator != detail::active_runtime_values().rend(); ++iterator ) {
        const std::shared_ptr<runtime> &owner = *iterator;
        if( !owner ) {
            continue;
        }
        std::string handler_id;
        if( !owner->content.find_end_screen_handler(
                end_screen_id_value, handler_id ) ) {
            continue;
        }
        if( handler_id.empty() || !owner->world_is_ready ) {
            return false;
        }
        const auto handler = owner->handlers.find( handler_id );
        if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first end-screen policy unavailable for '"
                                        << owner->mod_id << ':' << handler_id << "'";
            return false;
        }
        sol::table payload = owner->lua->create_table();
        payload["end_screen_id"] = std::string( end_screen_id_value );
        payload["character"] = platform_creature_handle( *owner, character );
        sol::protected_function callback = handler->second.callback;
        callback_scope scope( *owner );
        const sol::protected_function_result result = callback( payload );
        if( !result.valid() ) {
            report_callback_error( *owner, handler_id, result );
            return false;
        }
        if( result.return_count() != 1 || result.get_type() != sol::type::boolean ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first end-screen policy '"
                                        << owner->mod_id << ':' << handler_id
                                        << "' must return one boolean";
            return false;
        }
        return result.get<bool>();
    }
    return std::nullopt;
}

bool invoke_activity_type_handler(
    const std::string_view activity_type_id_value, const std::string_view phase,
    player_activity &activity, Character &character )
{
    for( auto iterator = detail::active_runtime_values().rbegin(); iterator != detail::active_runtime_values().rend(); ++iterator ) {
        const std::shared_ptr<runtime> &owner = *iterator;
        if( !owner ) {
            continue;
        }
        std::string handler_id;
        if( !owner->content.find_activity_type_handler(
                activity_type_id_value, phase, handler_id ) ) {
            continue;
        }
        // The newest Lua-first definition owns both policy slots.  An omitted
        // slot intentionally suppresses the legacy EOC rather than exposing a
        // callback from an older replacement layer.
        if( handler_id.empty() || !owner->world_is_ready ) {
            return true;
        }
        const auto handler = owner->handlers.find( handler_id );
        if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first activity policy unavailable for '"
                                        << owner->mod_id << ':' << handler_id << "'";
            return true;
        }

        sol::table payload = owner->lua->create_table();
        payload["activity_type_id"] = std::string( activity_type_id_value );
        payload["phase"] = std::string( phase );
        payload["character"] = platform_creature_handle( *owner, character );
        payload["moves_total"] = activity.moves_total;
        payload["moves_left"] = activity.moves_left;
        payload["index"] = activity.index;
        payload["position"] = activity.position;
        payload["name"] = activity.name;

        sol::protected_function callback = handler->second.callback;
        callback_scope scope( *owner );
        const sol::protected_function_result result = callback( payload );
        if( !result.valid() ) {
            report_callback_error( *owner, handler_id, result );
            return true;
        }
        if( result.return_count() == 0 || result.get_type() == sol::type::nil ) {
            return true;
        }
        if( result.return_count() != 1 || result.get_type() != sol::type::table ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first activity policy '"
                                        << owner->mod_id << ':' << handler_id
                                        << "' must return nil or one result table";
            return true;
        }

        try {
            const sol::table returned = result.get<sol::table>();
            const auto integer_field = [&returned]( const std::string & field,
            const int fallback ) {
                const sol::optional<sol::object> candidate =
                    returned.get<sol::optional<sol::object>>( field );
                if( !candidate ) {
                    return fallback;
                }
                if( candidate->get_type() != sol::type::number ||
                    !candidate->is<lua_Integer>() ) {
                    throw std::invalid_argument( "activity result field '" + field +
                                                 "' must be an integer" );
                }
                const lua_Integer value = candidate->as<lua_Integer>();
                if( value < std::numeric_limits<int>::min() ||
                    value > std::numeric_limits<int>::max() ) {
                    throw std::invalid_argument( "activity result field '" + field +
                                                 "' is outside the native integer range" );
                }
                return static_cast<int>( value );
            };

            const int moves_total = integer_field( "moves_total", activity.moves_total );
            const int moves_left = integer_field( "moves_left", activity.moves_left );
            const int index = integer_field( "index", activity.index );
            const int position = integer_field( "position", activity.position );
            if( moves_total < 0 ) {
                throw std::invalid_argument(
                    "activity result field 'moves_total' cannot be negative" );
            }

            bool cancel = false;
            if( const sol::optional<sol::object> candidate =
                    returned.get<sol::optional<sol::object>>( "cancel" ) ) {
                if( candidate->get_type() != sol::type::boolean ) {
                    throw std::invalid_argument(
                        "activity result field 'cancel' must be a boolean" );
                }
                cancel = candidate->as<bool>();
            }

            std::string name = activity.name;
            if( const sol::optional<sol::object> candidate =
                    returned.get<sol::optional<sol::object>>( "name" ) ) {
                if( candidate->get_type() != sol::type::string ) {
                    throw std::invalid_argument(
                        "activity result field 'name' must be a string" );
                }
                name = candidate->as<std::string>();
                if( name.size() > 1024 || name.find( '\0' ) != std::string::npos ) {
                    throw std::invalid_argument(
                        "activity result field 'name' exceeds its native bound" );
                }
            }

            activity.moves_total = moves_total;
            activity.moves_left = moves_left;
            activity.index = index;
            activity.position = position;
            activity.name = std::move( name );
            if( cancel ) {
                activity.set_to_null();
            }
        } catch( const std::exception &exception ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first activity policy '"
                                        << owner->mod_id << ':' << handler_id
                                        << "' returned invalid data: " << exception.what();
        }
        return true;
    }
    return false;
}

bool invoke_snippet_examine_handler( const std::string_view snippet_id_value,
                                     const std::string_view item_type_id,
                                     Character &character )
{
    for( auto iterator = detail::active_runtime_values().rbegin(); iterator != detail::active_runtime_values().rend(); ++iterator ) {
        const std::shared_ptr<runtime> &owner = *iterator;
        if( !owner ) {
            continue;
        }
        std::string category_id;
        std::string handler_id;
        if( !owner->content.find_snippet_handler(
                snippet_id_value, category_id, handler_id ) ) {
            continue;
        }
        if( handler_id.empty() || !owner->world_is_ready ) {
            return true;
        }
        const auto handler = owner->handlers.find( handler_id );
        if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first snippet examine policy unavailable for '"
                                        << owner->mod_id << ':' << handler_id << "'";
            return true;
        }
        sol::table payload = owner->lua->create_table();
        payload["snippet_id"] = std::string( snippet_id_value );
        payload["category_id"] = category_id;
        payload["item_type_id"] = std::string( item_type_id );
        payload["character"] = platform_creature_handle( *owner, character );
        sol::protected_function callback = handler->second.callback;
        callback_scope scope( *owner );
        const sol::protected_function_result result = callback( payload );
        if( !result.valid() ) {
            report_callback_error( *owner, handler_id, result );
        }
        return true;
    }
    return false;
}

std::optional<double> invoke_magic_type_number_handler(
    const std::string_view magic_type_id, const std::string_view phase,
    const std::string_view spell_id, const Creature *caster, const double input )
{
    for( auto iterator = detail::active_runtime_values().rbegin(); iterator != detail::active_runtime_values().rend(); ++iterator ) {
        const std::shared_ptr<runtime> &owner = *iterator;
        if( !owner ) {
            continue;
        }
        std::string handler_id;
        if( !owner->content.find_magic_type_handler( magic_type_id, phase, handler_id ) ) {
            continue;
        }
        // A later replacement owns the policy even if it intentionally uses
        // the engine default for this phase.
        if( handler_id.empty() || !owner->world_is_ready ) {
            return std::nullopt;
        }
        const auto handler = owner->handlers.find( handler_id );
        if( handler == owner->handlers.end() ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first magic-type handler '"
                                        << owner->mod_id << ':' << handler_id
                                        << "' is no longer registered";
            return std::nullopt;
        }
        if( owner->callback_depth >= 16 ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first magic-type handler recursion limit reached for '"
                                        << owner->mod_id << ':' << handler_id << "'";
            return std::nullopt;
        }
        sol::table payload = owner->lua->create_table();
        payload["magic_type_id"] = std::string( magic_type_id );
        payload["spell_id"] = std::string( spell_id );
        payload["phase"] = std::string( phase );
        payload["input"] = input;
        if( phase == "level_for_experience" ) {
            payload["experience"] = input;
        } else if( phase == "experience_for_level" ) {
            payload["level"] = input;
        }
        payload["caster"] = caster ?
                            sol::make_object( *owner->lua,
                                              platform_creature_handle( *owner, *caster ) ) :
                            sol::make_object( *owner->lua, sol::lua_nil );
        sol::protected_function callback = handler->second.callback;
        callback_scope scope( *owner );
        const sol::protected_function_result result = callback( payload );
        if( !result.valid() ) {
            report_callback_error( *owner, handler_id, result );
            return std::nullopt;
        }
        if( result.return_count() != 1 ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first magic-type handler '"
                                        << owner->mod_id << ':' << handler_id
                                        << "' must return one finite number";
            return std::nullopt;
        }
        const sol::object returned = result.get<sol::object>();
        if( returned.get_type() != sol::type::number ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first magic-type handler '"
                                        << owner->mod_id << ':' << handler_id
                                        << "' must return one finite number";
            return std::nullopt;
        }
        const double value = returned.as<double>();
        const bool integral_domain = phase == "level_for_experience" ||
                                     phase == "experience_for_level" ||
                                     phase == "casting_experience";
        const bool fraction_domain = phase == "failure_chance";
        if( !std::isfinite( value ) || value < 0.0 ||
            ( integral_domain && value > std::numeric_limits<int>::max() ) ||
            ( fraction_domain && value > 1.0 ) ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first magic-type handler '"
                                        << owner->mod_id << ':' << handler_id
                                        << "' returned a value outside the " << phase << " domain";
            return std::nullopt;
        }
        return value;
    }
    return std::nullopt;
}

void invoke_magic_type_failure_handler( const std::string_view magic_type_id,
                                        const std::string_view spell_id,
                                        Character &caster )
{
    for( auto iterator = detail::active_runtime_values().rbegin(); iterator != detail::active_runtime_values().rend(); ++iterator ) {
        const std::shared_ptr<runtime> &owner = *iterator;
        if( !owner ) {
            continue;
        }
        std::string handler_id;
        if( !owner->content.find_magic_type_handler(
                magic_type_id, "on_failure", handler_id ) ) {
            continue;
        }
        if( handler_id.empty() || !owner->world_is_ready ) {
            return;
        }
        const auto handler = owner->handlers.find( handler_id );
        if( handler == owner->handlers.end() ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first magic-type failure handler '"
                                        << owner->mod_id << ':' << handler_id
                                        << "' is no longer registered";
            return;
        }
        if( owner->callback_depth >= 16 ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first magic-type failure handler recursion limit reached for '"
                                        << owner->mod_id << ':' << handler_id << "'";
            return;
        }
        sol::table payload = owner->lua->create_table();
        payload["magic_type_id"] = std::string( magic_type_id );
        payload["spell_id"] = std::string( spell_id );
        payload["caster"] = platform_creature_handle( *owner, caster );
        sol::protected_function callback = handler->second.callback;
        callback_scope scope( *owner );
        const sol::protected_function_result result = callback( payload );
        if( !result.valid() ) {
            report_callback_error( *owner, handler_id, result );
        }
        return;
    }
}

std::optional<emission_profile> invoke_emission_profile_handler(
    const std::string_view emission_id, const tripoint_bub_ms &position,
    const emission_profile &fallback )
{
    for( auto iterator = detail::active_runtime_values().rbegin(); iterator != detail::active_runtime_values().rend(); ++iterator ) {
        const std::shared_ptr<runtime> &owner = *iterator;
        if( !owner ) {
            continue;
        }
        std::string handler_id;
        if( !owner->content.find_emission_handler( emission_id, handler_id ) ) {
            continue;
        }
        // A later static replacement owns the emission even when it omits a
        // dynamic profile, so an older replacement's callback must not leak.
        if( handler_id.empty() || !owner->world_is_ready ) {
            return std::nullopt;
        }
        const auto handler = owner->handlers.find( handler_id );
        if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first emission profile unavailable for '"
                                        << owner->mod_id << ':' << handler_id << "'";
            return std::nullopt;
        }

        sol::table payload = owner->lua->create_table();
        payload["emission_id"] = std::string( emission_id );
        sol::table point = owner->lua->create_table();
        point["coordinate_space"] = "bub_ms";
        point["x"] = position.x();
        point["y"] = position.y();
        point["z"] = position.z();
        payload["position"] = std::move( point );
        sol::table fallback_value = owner->lua->create_table();
        fallback_value["field"] = fallback.field;
        fallback_value["intensity"] = fallback.intensity;
        fallback_value["quantity"] = fallback.quantity;
        fallback_value["chance"] = fallback.chance;
        payload["fallback"] = std::move( fallback_value );

        sol::protected_function callback = handler->second.callback;
        callback_scope scope( *owner );
        const sol::protected_function_result result = callback( payload );
        if( !result.valid() ) {
            report_callback_error( *owner, handler_id, result );
            return std::nullopt;
        }
        if( result.return_count() == 0 || result.get_type() == sol::type::nil ) {
            return std::nullopt;
        }
        if( result.return_count() != 1 || result.get_type() != sol::type::table ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first emission profile '"
                                        << owner->mod_id << ':' << handler_id
                                        << "' must return nil or one complete profile table";
            return std::nullopt;
        }

        try {
            const sol::table returned = result.get<sol::table>();
            const sol::object field_value = returned.raw_get<sol::object>( "field" );
            if( field_value.get_type() != sol::type::string ) {
                throw std::invalid_argument( "field must be a string" );
            }
            emission_profile profile;
            profile.field = field_value.as<std::string>();
            const auto integer_field = [&returned]( const char *name ) {
                const sol::object candidate = returned.raw_get<sol::object>( name );
                if( candidate.get_type() != sol::type::number ||
                    !candidate.is<lua_Integer>() ) {
                    throw std::invalid_argument( std::string( name ) + " must be an integer" );
                }
                const lua_Integer value = candidate.as<lua_Integer>();
                if( value < std::numeric_limits<int>::min() ||
                    value > std::numeric_limits<int>::max() ) {
                    throw std::invalid_argument( std::string( name ) +
                                                 " is outside the native integer range" );
                }
                return static_cast<int>( value );
            };
            profile.intensity = integer_field( "intensity" );
            profile.quantity = integer_field( "quantity" );
            profile.chance = integer_field( "chance" );

            const field_type_str_id field( profile.field );
            if( profile.field.empty() || profile.field == "fd_null" ||
                profile.field.find( '\0' ) != std::string::npos || !field.is_valid() ||
                profile.intensity <= 0 ||
                profile.intensity > field->get_max_intensity() ||
                profile.quantity < 0 || profile.chance < 0 || profile.chance > 100 ) {
                throw std::invalid_argument( "field profile is outside native bounds" );
            }
            return profile;
        } catch( const std::exception &exception ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first emission profile '"
                                        << owner->mod_id << ':' << handler_id
                                        << "' returned invalid data: " << exception.what();
            return std::nullopt;
        }
    }
    return std::nullopt;
}


} // namespace cata::lua_platform

#endif // CATA_ENABLE_LUA_PLATFORM
