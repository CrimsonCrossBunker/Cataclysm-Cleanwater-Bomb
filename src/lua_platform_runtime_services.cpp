#include "lua_platform_runtime.h"
#include "lua_platform_runtime_internal.h"

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <character_id.h>
#include <common_types.h>
#include <enums.h>
#include <game_constants.h>
#include <item_uid.h>
#include <lua_platform_hooks.h>
#include <mapgen_primitives.h>
#include <math_parser_diag_value.h>
#include <pimpl.h>
#include <pocket_type.h>
#include <point.h>
#include <sleep.h>
#include <stomach.h>
#include <value_ptr.h>
#include <vehicle_uid.h>
#include <weighted_list.h>
#include <bitset>
#include <exception>
#include <initializer_list>
#include <iterator>
#include <list>

namespace cata::lua_platform::detail
{
struct event_statistic_snapshot;
struct event_transformation_snapshot;
}  // namespace cata::lua_platform::detail

#include <algorithm>
#include <array>
#include <cctype>
#include <cmath>
#include <cstdint>
#include <filesystem>
#include <functional>
#include <iomanip>
extern "C" {
#include <lua.h>
}
#include <limits>
#include <map>
#include <random>
#include <set>
#include <sstream>
#include <stdexcept>
#include <system_error>
#include <tuple>
#include <type_traits>
#include <unordered_map>
#include <unordered_set>
#include <utility>
#include <variant>

#include "achievement.h"
#include "activity_actor.h"
#include "activity_handlers.h"
#include "activity_type.h"
#include "addiction.h"
#include "ammo.h"
#include "ammo_effect.h"
#include "anatomy.h"
#include "ascii_art.h"
#include "avatar.h"
#include "behavior.h"
#include "behavior_oracle.h"
#include "behavior_strategy.h"
#include "bionics.h"
#include "bodygraph.h"
#include "bodypart.h"
#include "butchery.h"
#include "butchery_requirements.h"
#include "calendar.h"
#include "cata_path.h"
#include "cata_scope_helpers.h"
#include "cata_utility.h"
#include "cata_variant.h"
#include "catacharset.h"
#include "character.h"
#include "character_martial_arts.h"
#include "character_modifier.h"
#include "city.h"
#include "climbing.h"
#include "clothing_mod.h"
#include "clzones.h"
#include "color.h"
#include "computer.h"
#include "construction.h"
#include "construction_category.h"
#include "construction_group.h"
#include "coordinates.h"
#include "crafting_gui.h"
#include "creature.h"
#include "creature_tracker.h"
#include "debug.h"
#include "dialogue.h"
#include "dialogue_helpers.h"
#include "disease.h"
#include "effect.h"
#include "emit.h"
#include "end_screen.h"
#include "enum_conversions.h"
#include "event.h"
#include "event_bus.h"
#include "event_field_transformations.h"
#include "event_statistics.h"
#include "event_subscriber.h"
#include "explosion_light.h"
#include "faction_camp.h"
#include "fault.h"
#include "field.h"
#include "field_type.h"
#include "filesystem.h"
#include "flag.h"
#include "flexbuffer_json.h"
#include "game.h"
#include "gates.h"
#include "generic_factory.h"
#include "harvest.h"
#include "help.h"
#include "hsv_color.h"
#include "init.h"
#include "item.h"
#include "item_action.h"
#include "item_category.h"
#include "item_factory.h"
#include "item_group.h"
#include "item_location.h"
#include "item_wakeup.h"
#include "itype.h"
#include "iuse.h"
#include "json.h"
#include "json_loader.h"
#include "lua_platform_achievements.h"
#include "lua_platform_activities.h"
#include "lua_platform_addictions.h"
#include "lua_platform_bindings_coords.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_bionics.h"
#include "lua_platform_camps.h"
#include "lua_platform_content.h"
#include "lua_platform_crafting.h"
#include "lua_platform_creatures.h"
#include "lua_platform_dialogue.h"
#include "lua_platform_effects.h"
#include "lua_platform_factions.h"
#include "lua_platform_handle.h"
#include "lua_platform_hordes.h"
#include "lua_platform_interaction.h"
#include "lua_platform_items.h"
#include "lua_platform_magic.h"
#include "lua_platform_mapgen.h"
#include "lua_platform_martial_arts.h"
#include "lua_platform_missions.h"
#include "lua_platform_mutations.h"
#include "lua_platform_needs.h"
#include "lua_platform_npcs.h"
#include "lua_platform_overmap.h"
#include "lua_platform_proficiencies.h"
#include "lua_platform_registry.h"
#include "lua_platform_skills.h"
#include "lua_platform_snapshots.h"
#include "lua_platform_state.h"
#include "lua_platform_statistics.h"
#include "lua_platform_time.h"
#include "lua_platform_trade.h"
#include "lua_platform_variables.h"
#include "lua_platform_vehicles.h"
#include "lua_platform_vitamins.h"
#include "lua_platform_weather.h"
#include "lua_platform_world.h"
#include "lua_platform_world_content.h"
#include "lua_platform_world_info.h"
#include "lua_platform_world_services.h"
#include "lua_platform_zones.h"
#include "magic_enchantment.h"
#include "magic_ter_furn_transform.h"
#include "magic_type.h"
#include "map.h"
#include "map_accessories.h"
#include "map_extras.h"
#include "map_scale_constants.h"
#include "mapdata.h"
#include "mapgen.h"
#include "mapgen_functions.h"
#include "mapgen_post_process.h"
#include "mapgendata.h"
#include "martialarts.h"
#include "material.h"
#include "math_parser.h"
#include "math_parser_diag.h"
#include "math_parser_jmath.h"
#include "mattack_actors.h"
#include "mattack_common.h"
#include "messages.h"
#include "mission.h"
#include "mod_tileset.h"
#include "mondefense.h"
#include "monfaction.h"
#include "mongroup.h"
#include "monster.h"
#include "monstergenerator.h"
#include "mood_face.h"
#include "morale_types.h"
#include "move_mode.h"
#include "mtype.h"
#include "mutation.h"
#include "npc.h"
#include "omdata.h"
#include "options.h"
#include "output.h"
#include "overlay_ordering.h"
#include "overmap_connection.h"
#include "overmap_location.h"
#include "overmap_map_data_cache.h"
#include "overmap_worldgen.h"
#include "path_info.h"
#include "player_activity.h"
#include "profession.h"
#include "profession_group.h"
#include "proficiency.h"
#include "recipe.h"
#include "recipe_dictionary.h"
#include "recipe_groups.h"
#include "regional_settings.h"
#include "relic.h"
#include "requirements.h"
#include "safe_reference.h"
#include "scenario.h"
#include "scent_map.h"
#include "shop_cons_rate.h"
#include "skill.h"
#include "sounds.h"
#include "speech.h"
#include "speed_description.h"
#include "start_location.h"
#include "string_input_popup.h"
#include "subbodypart.h"
#include "talker.h"
#include "text_snippets.h"
#include "translation.h"
#include "trap.h"
#include "type_id.h"
#include "uilist.h"
#include "units.h"
#include "veh_type.h"
#include "vehicle.h"
#include "vehicle_group.h"
#include "vehicle_palette.h"
#include "vehicle_part_location.h"
#include "vitamin.h"
#include "weakpoint.h"
#include "weather_gen.h"
#include "weather_type.h"
#include "widget.h"
#include "worldfactory.h"
#include "wound.h"

namespace cata::lua_platform
{

using detail::callback_scope;
using detail::dispatch_lifecycle;
using detail::platform_callback_payload;
using detail::platform_event_dispatch_scope;
using detail::report_callback_error;
using detail::require_live_runtime;
using detail::runtime_callback_is_active;

namespace
{

std::size_t require_dense_array( const sol::table &values,
                                 const std::string_view description,
                                 const std::size_t minimum,
                                 const std::size_t maximum )
{
    return detail::checked_dense_array(
               values, description, minimum, maximum );
}

std::uint64_t fnv1a( const std::string_view value,
                     std::uint64_t state = 1469598103934665603ULL )
{
    for( const unsigned char byte : value ) {
        state ^= byte;
        state *= 1099511628211ULL;
    }
    return state;
}

void hash_part( std::uint64_t &state, const std::string_view value )
{
    state = fnv1a( std::to_string( value.size() ), state );
    state = fnv1a( ":", state );
    state = fnv1a( value, state );
    state = fnv1a( ";", state );
}

struct use_context_data {
    use_context_data() = default;
    use_context_data( const use_context_data & ) = delete;
    use_context_data &operator=( const use_context_data & ) = delete;
    use_context_data( use_context_data && ) = delete;
    use_context_data &operator=( use_context_data && ) = delete;

    Character *character = nullptr;
    item *used_item = nullptr;
    tripoint_bub_ms position;
    cata::lua_platform::game_handle_runtime handle_runtime;
    std::size_t world_generation = 0;
    bool active = true;

    void require_active() const {
        if( !active || character == nullptr || used_item == nullptr ) {
            throw std::runtime_error( "stale item-use context" );
        }
    }

    void message( const std::string &value ) const {
        require_active();
        character->add_msg_if_player( value );
    }

    std::string player_name() const {
        require_active();
        return character->get_name();
    }

    std::string item_id() const {
        require_active();
        return used_item->typeId().str();
    }

    int charges() const {
        require_active();
        return used_item->charges;
    }

    void set_charges( std::int64_t value ) {
        require_active();
        if( value < 0 || value > std::numeric_limits<int>::max() ) {
            throw std::runtime_error( "item charges are outside the native range" );
        }
        used_item->charges = static_cast<int>( value );
    }

    cata::lua_platform::game_handle character_handle() const {
        require_active();
        const tripoint_abs_ms absolute = character->pos_abs();
        return cata::lua_platform::game_handle::from_creature( *character, {
            "platform_item_use_character", character->getID().get_value(),
            absolute.x(), absolute.y(), absolute.z(), {}
        }, handle_runtime, world_generation );
    }

    cata::lua_platform::game_handle item_handle() const {
        require_active();
        return cata::lua_platform::game_handle::from_item( *used_item, {
            "platform_item_use_item", used_item->uid().get_value(), 0, 0, 0, {}
        }, handle_runtime, world_generation );
    }

    cata::lua_platform::script_tripoint_coord use_position() const {
        require_active();
        return cata::lua_platform::script_tripoint_coord::from_native(
                   coords::origin::reality_bubble, coords::scale::map_square,
                   position.raw() );
    }
};

constexpr std::size_t maximum_computer_value_entries = 256;
constexpr std::size_t maximum_computer_value_nodes = 512;
constexpr std::size_t maximum_computer_value_bytes = 8192;
constexpr int maximum_computer_value_depth = 8;

void require_computer_value_key( const std::string &key )
{
    if( key.empty() || key.size() > 128 ||
    std::any_of( key.begin(), key.end(), []( const unsigned char ch ) {
    return ch == '\0' || ch < 0x20U || ch == 0x7fU;
} ) ) {
        throw std::invalid_argument(
            "computer value keys must contain 1 to 128 printable bytes" );
    }
}

diag_value computer_value_from_lua(
    const sol::object &value, const std::string &key,
    const int depth, std::size_t &nodes )
{
    if( ++nodes > maximum_computer_value_nodes ||
        depth > maximum_computer_value_depth ) {
        throw std::invalid_argument(
            "computer value exceeds its structural limits" );
    }
    if( value.get_type() == sol::type::boolean ) {
        return diag_value( value.as<bool>() ? 1.0 : 0.0 );
    }
    if( value.get_type() == sol::type::number ) {
        const double number = value.as<double>();
        if( !std::isfinite( number ) ) {
            throw std::invalid_argument(
                "computer value '" + key + "' must be finite" );
        }
        return diag_value( number );
    }
    if( value.get_type() == sol::type::string ) {
        const std::string text = value.as<std::string>();
        if( text.size() > maximum_computer_value_bytes ) {
            throw std::invalid_argument(
                "computer value '" + key + "' exceeds 8192 bytes" );
        }
        return diag_value( text );
    }
    if( value.is<cata::lua_platform::script_tripoint_coord>() ) {
        const cata::lua_platform::script_tripoint_coord position =
            value.as<cata::lua_platform::script_tripoint_coord>();
        if( position.native_origin() != coords::origin::abs ||
            position.native_scale() != coords::scale::map_square ) {
            throw std::invalid_argument(
                "computer coordinates must be absolute map-square coordinates" );
        }
        return diag_value( tripoint_abs_ms( position.to_native() ) );
    }
    if( value.get_type() == sol::type::table ) {
        const sol::table entries = value.as<sol::table>();
        const std::size_t count = require_dense_array(
                                      entries, "computer value array", 0,
                                      maximum_computer_value_entries );
        diag_array result;
        result.reserve( count );
        for( std::size_t index = 1; index <= count; ++index ) {
            result.push_back( computer_value_from_lua(
                                  entries.raw_get<sol::object>( index ), key,
                                  depth + 1, nodes ) );
        }
        return diag_value( std::move( result ) );
    }
    throw std::invalid_argument(
        "computer value '" + key +
        "' must be boolean, number, string, TripointCoord, or a dense array" );
}

sol::object computer_value_to_lua(
    sol::state_view lua, const diag_value &value,
    const int depth, std::size_t &nodes )
{
    if( ++nodes > maximum_computer_value_nodes ||
        depth > maximum_computer_value_depth ) {
        throw std::runtime_error(
            "computer value exceeds its structural limits" );
    }
    if( value.is_empty() ) {
        return sol::make_object( lua, sol::nil );
    }
    if( value.is_dbl() ) {
        return sol::make_object( lua, value.dbl() );
    }
    if( value.is_str() ) {
        const std::string &text = value.str();
        if( text.size() > maximum_computer_value_bytes ) {
            throw std::runtime_error(
                "computer value string exceeds 8192 bytes" );
        }
        return sol::make_object( lua, text );
    }
    if( value.is_tripoint() ) {
        return sol::make_object(
                   lua, cata::lua_platform::script_tripoint_coord::from_native(
                       coords::origin::abs, coords::scale::map_square,
                       value.tripoint().raw() ) );
    }
    if( value.is_array() ) {
        const diag_array &entries = value.array();
        if( entries.size() > maximum_computer_value_entries ) {
            throw std::runtime_error(
                "computer value array exceeds 256 entries" );
        }
        sol::table result = lua.create_table(
                                static_cast<int>( entries.size() ), 0 );
        for( std::size_t index = 0; index < entries.size(); ++index ) {
            result[index + 1] = computer_value_to_lua(
                                    lua, entries[index], depth + 1, nodes );
        }
        return sol::make_object( lua, std::move( result ) );
    }
    return sol::make_object( lua, value.to_string() );
}

struct computer_access_context {
    computer_access_context() = default;
    computer_access_context( const computer_access_context & ) = delete;
    computer_access_context &operator=( const computer_access_context & ) = delete;
    computer_access_context( computer_access_context && ) = delete;
    computer_access_context &operator=( computer_access_context && ) = delete;

    computer *terminal = nullptr;
    Character *character = nullptr;
    cata::lua_platform::game_handle_runtime handle_runtime;
    std::size_t world_generation = 0;
    bool active = true;

    void require_active() const {
        if( !active || terminal == nullptr || character == nullptr ) {
            throw std::runtime_error( "stale computer access context" );
        }
    }

    void message( const std::string &value ) const {
        require_active();
        character->add_msg_if_player( value );
    }

    std::string name() const {
        require_active();
        return terminal->name;
    }

    void set_name( const std::string &value ) {
        require_active();
        if( value.empty() || value.size() > 4096 ||
            value.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                "computer name must contain 1 to 4096 non-NUL bytes" );
        }
        terminal->name = value;
    }

    std::string access_denied() const {
        require_active();
        return terminal->access_denied;
    }

    void set_access_denied( const std::string &value ) {
        require_active();
        if( value.size() > 4096 || value.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                "computer access-denied text exceeds its native limit" );
        }
        terminal->set_access_denied_msg( value );
    }

    int security() const {
        require_active();
        return terminal->security;
    }

    void set_security( const std::int64_t value ) {
        require_active();
        if( value < -1000000 || value > 1000000 ) {
            throw std::invalid_argument(
                "computer security must be between -1000000 and 1000000" );
        }
        terminal->set_security( static_cast<int>( value ) );
    }

    int alerts() const {
        require_active();
        return terminal->alerts;
    }

    void set_alerts( const std::int64_t value ) {
        require_active();
        if( value < 0 || value > 1000000 ) {
            throw std::invalid_argument(
                "computer alerts must be between 0 and 1000000" );
        }
        terminal->alerts = static_cast<int>( value );
    }

    int mission_id() const {
        require_active();
        return terminal->mission_id;
    }

    void set_mission_id( const std::int64_t value ) {
        require_active();
        if( value < -1 || value > std::numeric_limits<int>::max() ) {
            throw std::invalid_argument(
                "computer mission id is outside the native range" );
        }
        terminal->set_mission( static_cast<int>( value ) );
    }

    cata::lua_platform::game_handle character_handle() const {
        require_active();
        const tripoint_abs_ms absolute = character->pos_abs();
        return cata::lua_platform::game_handle::from_creature( *character, {
            "platform_computer_character", character->getID().get_value(),
            absolute.x(), absolute.y(), absolute.z(), {}
        }, handle_runtime, world_generation );
    }

    cata::lua_platform::script_tripoint_coord position() const {
        require_active();
        return cata::lua_platform::script_tripoint_coord::from_native(
                   coords::origin::abs, coords::scale::map_square,
                   terminal->loc.raw() );
    }

    sol::object get_value( sol::this_state state, const std::string &key ) const {
        require_active();
        require_computer_value_key( key );
        const diag_value *stored = terminal->maybe_get_value( key );
        if( stored == nullptr ) {
            return sol::make_object( state, sol::lua_nil );
        }
        std::size_t nodes = 0;
        return computer_value_to_lua( sol::state_view( state ), *stored, 0, nodes );
    }

    void set_value( const std::string &key, const sol::object &value ) {
        require_active();
        require_computer_value_key( key );
        if( value.get_type() == sol::type::nil ) {
            terminal->remove_value( key );
            return;
        }
        if( terminal->maybe_get_value( key ) == nullptr &&
            terminal->values.size() >= maximum_computer_value_entries ) {
            throw std::runtime_error(
                "computer value store exceeds 256 entries" );
        }
        std::size_t nodes = 0;
        terminal->set_value(
            key, computer_value_from_lua( value, key, 0, nodes ) );
    }

    bool remove_value( const std::string &key ) {
        require_active();
        require_computer_value_key( key );
        const bool existed = terminal->maybe_get_value( key ) != nullptr;
        terminal->remove_value( key );
        return existed;
    }
};

class computer_access_context_lease
{
    public:
        explicit computer_access_context_lease( computer_access_context &context ) :
            context_( context ) {}

        computer_access_context_lease( const computer_access_context_lease & ) = delete;
        computer_access_context_lease &operator=( const computer_access_context_lease & ) = delete;

        ~computer_access_context_lease() noexcept {
            context_.active = false;
            context_.terminal = nullptr;
            context_.character = nullptr;
        }

    private:
        computer_access_context &context_;
};

class use_context_lease
{
    public:
        explicit use_context_lease( use_context_data &context ) : context_( context ) {}

        use_context_lease( const use_context_lease & ) = delete;
        use_context_lease &operator=( const use_context_lease & ) = delete;

        ~use_context_lease() noexcept {
            context_.active = false;
            context_.character = nullptr;
            context_.used_item = nullptr;
        }

    private:
        use_context_data &context_;
};


} // namespace

std::optional<int> invoke_use_handler( std::string_view mod_id,
                                       std::string_view handler_id,
                                       Character *character, item &used_item,
                                       map *, const tripoint_bub_ms &position )
{
    const std::shared_ptr<runtime> owner = detail::find_active_runtime( mod_id );
    if( character == nullptr ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first item handler '" << mod_id << ':'
                                    << handler_id << "' was invoked without a Character";
        return std::nullopt;
    }
    if( !owner || !owner->world_is_ready ) {
        character->add_msg_if_player( "Lua-first Mod runtime is not ready." );
        return std::nullopt;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() ) {
        character->add_msg_if_player( "Lua-first item handler is no longer registered." );
        return std::nullopt;
    }
    auto context = std::make_shared<use_context_data>();
    context->character = character;
    context->used_item = &used_item;
    context->position = position;
    context->handle_runtime = owner->handle_runtime();
    context->world_generation = detail::runtime_world_generation_storage();
    use_context_lease context_lease( *context );
    sol::protected_function callback = handler->second.callback;
    callback_scope scope( *owner );
    const sol::protected_function_result result = callback( context );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
        return std::nullopt;
    }
    if( result.return_count() == 0 ) {
        return 0;
    }
    const sol::object returned = result.get<sol::object>();
    if( returned.get_type() == sol::type::nil ) {
        return std::nullopt;
    }
    if( returned.get_type() != sol::type::number || !returned.is<lua_Integer>() ) {
        ::add_msg( m_bad, "Lua-first item handler must return an integer or nil." );
        return std::nullopt;
    }
    const lua_Integer native_result = returned.as<lua_Integer>();
    if( native_result < std::numeric_limits<int>::min() ||
        native_result > std::numeric_limits<int>::max() ) {
        ::add_msg( m_bad, "Lua-first item handler result is outside the native range." );
        return std::nullopt;
    }
    return static_cast<int>( native_result );
}

std::optional<bool> invoke_computer_access_handler(
    computer &terminal, Character &character )
{
    if( !terminal.has_platform_access_handler() ) {
        return std::nullopt;
    }
    const std::shared_ptr<runtime> owner = detail::find_active_runtime(
            terminal.platform_access_mod() );
    if( !owner || !owner->world_is_ready ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first computer runtime unavailable for '"
                                    << terminal.platform_access_mod() << ':'
                                    << terminal.platform_access_handler() << "'";
        return false;
    }
    const auto handler = owner->handlers.find(
                             terminal.platform_access_handler() );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first computer handler unavailable for '"
                                    << terminal.platform_access_mod() << ':'
                                    << terminal.platform_access_handler() << "'";
        return false;
    }

    auto context = std::make_shared<computer_access_context>();
    context->terminal = &terminal;
    context->character = &character;
    context->handle_runtime = owner->handle_runtime();
    context->world_generation = detail::runtime_world_generation_storage();
    computer_access_context_lease lease( *context );
    sol::protected_function callback = handler->second.callback;
    callback_scope scope( *owner );
    const sol::protected_function_result result = callback( context );
    if( !result.valid() ) {
        report_callback_error(
            *owner, terminal.platform_access_handler(), result );
        return false;
    }
    if( result.return_count() == 0 || result.get_type() == sol::type::nil ) {
        return false;
    }
    if( result.return_count() != 1 || result.get_type() != sol::type::boolean ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first computer handler '"
                                    << terminal.platform_access_mod() << ':'
                                    << terminal.platform_access_handler()
                                    << "' must return nil or exactly one boolean";
        return false;
    }
    return result.get<bool>();
}

namespace
{

using detail::active_runtimes;
using detail::active_world_generation;
using detail::find_active_runtime;

thread_local std::size_t platform_mapgen_callback_write_depth = 0;

class platform_mapgen_callback_write_scope
{
    public:
        platform_mapgen_callback_write_scope() {
            ++platform_mapgen_callback_write_depth;
        }

        platform_mapgen_callback_write_scope(
            const platform_mapgen_callback_write_scope & ) = delete;
        platform_mapgen_callback_write_scope &operator=(
            const platform_mapgen_callback_write_scope & ) = delete;

        ~platform_mapgen_callback_write_scope() {
            --platform_mapgen_callback_write_depth;
        }
};

void validate_platform_mapgen_descriptor_keys(
    const sol::table &descriptor, const std::set<std::string> &allowed,
    const std::string_view operation )
{
    for( const auto &entry : descriptor ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument( "ccb.services.mapgen " +
                                         std::string( operation ) +
                                         " option keys must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        if( allowed.count( key ) == 0 ) {
            throw std::invalid_argument( "ccb.services.mapgen " +
                                         std::string( operation ) +
                                         " received unknown option '" + key + "'" );
        }
    }
}

std::vector<std::string> platform_mapgen_string_array(
    const sol::object &source, const std::string_view label,
    const std::size_t maximum, const bool allow_string = false,
    const bool sort_values = true )
{
    if( !source.valid() || source.get_type() == sol::type::nil ) {
        return {};
    }
    if( allow_string && source.get_type() == sol::type::string ) {
        return { source.as<std::string>() };
    }
    if( source.get_type() != sol::type::table ) {
        throw std::invalid_argument( std::string( label ) +
                                     " must be an array table" );
    }
    const sol::table values = source.as<sol::table>();
    const std::size_t count = require_dense_array( values, label, 0, maximum );
    std::vector<std::string> result;
    result.reserve( count );
    for( std::size_t index = 1; index <= count; ++index ) {
        const sol::object value = values.raw_get<sol::object>( index );
        if( value.get_type() != sol::type::string ) {
            throw std::invalid_argument( std::string( label ) +
                                         " must contain strings" );
        }
        const std::string id = value.as<std::string>();
        if( id.empty() || id.size() > 256 ||
            id.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument( std::string( label ) +
                                         " contains an invalid id" );
        }
        result.push_back( id );
    }
    if( sort_values ) {
        std::sort( result.begin(), result.end() );
        if( std::adjacent_find( result.begin(), result.end() ) != result.end() ) {
            throw std::invalid_argument( std::string( label ) +
                                         " cannot contain duplicates" );
        }
    } else {
        std::set<std::string> unique;
        for( const std::string &value : result ) {
            if( !unique.insert( value ).second ) {
                throw std::invalid_argument( std::string( label ) +
                                             " cannot contain duplicates" );
            }
        }
    }
    return result;
}

std::map<std::string, sol::object> platform_mapgen_symbol_map(
    const sol::object &source, const std::string_view label )
{
    if( !source.valid() || source.get_type() == sol::type::nil ) {
        return {};
    }
    if( source.get_type() != sol::type::table ) {
        throw std::invalid_argument( std::string( label ) + " must be a table" );
    }
    std::map<std::string, sol::object> result;
    const sol::table symbols = source.as<sol::table>();
    if( symbols.size() > 4096 ) {
        throw std::invalid_argument( std::string( label ) + " has too many symbols" );
    }
    for( const auto &entry : symbols ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument( std::string( label ) +
                                         " keys must be strings" );
        }
        const std::string glyph = entry.first.as<std::string>();
        static_cast<void>( map_key( glyph ) );
        if( !entry.second.valid() || entry.second.get_type() == sol::type::nil ||
            ( entry.second.get_type() != sol::type::string &&
              entry.second.get_type() != sol::type::function &&
              entry.second.get_type() != sol::type::table ) ) {
            throw std::invalid_argument( std::string( label ) +
                                         " values must be strings, functions, or tables" );
        }
        result.emplace( glyph, entry.second );
    }
    return result;
}

std::uint64_t next_platform_mapgen_registration_id( runtime &owner )
{
    if( owner.next_mapgen_registration_id == 0 ) {
        throw std::runtime_error( "ccb.services.mapgen registration id space is exhausted" );
    }
    return owner.next_mapgen_registration_id++;
}

std::uint64_t register_platform_mapgen_palette(
    runtime &owner, const sol::table &descriptor )
{
    if( owner.world_is_ready ) {
        throw std::runtime_error(
            "ccb.services.mapgen register_palette is only available during bootstrap" );
    }
    validate_platform_mapgen_descriptor_keys(
        descriptor, { "id", "palettes", "symbols", "mapping" },
        "register_palette" );
    const std::string id = descriptor.get_or( "id", std::string() );
    if( id.empty() || id.size() > 256 || id.find( '\0' ) != std::string::npos ) {
        throw std::invalid_argument(
            "ccb.services.mapgen palette id must contain 1 to 256 non-NUL bytes" );
    }
    runtime::declarative_mapgen_palette replacement;
    replacement.parents = platform_mapgen_string_array(
                              descriptor.raw_get<sol::object>( "palettes" ),
                              "mapgen palette parents", 256, true, false );
    sol::object symbols = descriptor.raw_get<sol::object>( "symbols" );
    if( ( !symbols.valid() || symbols.get_type() == sol::type::nil ) &&
        descriptor.raw_get<sol::object>( "mapping" ).valid() ) {
        symbols = descriptor.raw_get<sol::object>( "mapping" );
    }
    replacement.symbols = platform_mapgen_symbol_map(
                              symbols, "mapgen palette symbols" );
    const auto existing = owner.mapgen_palettes.find( id );
    if( existing != owner.mapgen_palettes.end() ) {
        replacement.registration_id = existing->second.registration_id;
        existing->second = std::move( replacement );
        return existing->second.registration_id;
    }
    if( owner.mapgen_palettes.size() >= 4096 ) {
        throw std::runtime_error( "ccb.services.mapgen palette limit reached" );
    }
    replacement.registration_id = next_platform_mapgen_registration_id( owner );
    const std::uint64_t result = replacement.registration_id;
    owner.mapgen_palettes.emplace( id, std::move( replacement ) );
    return result;
}

std::uint64_t register_platform_declarative_mapgen(
    runtime &owner, const sol::table &descriptor )
{
    if( owner.world_is_ready ) {
        throw std::runtime_error(
            "ccb.services.mapgen define is only available during bootstrap" );
    }
    validate_platform_mapgen_descriptor_keys( descriptor, {
        "id", "terrain_ids", "z_min", "z_max", "primary", "offset_x",
        "offset_y", "fill_terrain", "rows", "palettes", "symbols", "mapping",
        "before_generate", "after_generate", "on_generate"
    }, "define" );
    runtime::declarative_mapgen_definition replacement;
    replacement.id = descriptor.get_or( "id", std::string() );
    if( replacement.id.empty() || replacement.id.size() > 256 ||
        replacement.id.find( '\0' ) != std::string::npos ) {
        throw std::invalid_argument(
            "ccb.services.mapgen definition id must contain 1 to 256 non-NUL bytes" );
    }
    replacement.terrain_ids = platform_mapgen_string_array(
                                  descriptor.raw_get<sol::object>( "terrain_ids" ),
                                  "mapgen terrain_ids", 4096, true );
    replacement.z_min = descriptor.get_or( "z_min", std::numeric_limits<int>::min() );
    replacement.z_max = descriptor.get_or( "z_max", std::numeric_limits<int>::max() );
    replacement.primary = descriptor.get_or( "primary", true );
    replacement.offset_x = descriptor.get_or( "offset_x", 0 );
    replacement.offset_y = descriptor.get_or( "offset_y", 0 );
    replacement.fill_terrain = descriptor.get_or( "fill_terrain", std::string() );
    if( replacement.z_min > replacement.z_max || replacement.offset_x < 0 ||
        replacement.offset_y < 0 || replacement.offset_x >= 24 ||
        replacement.offset_y >= 24 || replacement.fill_terrain.size() > 256 ||
        replacement.fill_terrain.find( '\0' ) != std::string::npos ) {
        throw std::invalid_argument(
            "ccb.services.mapgen definition bounds are invalid" );
    }
    const sol::object rows = descriptor.raw_get<sol::object>( "rows" );
    if( rows.valid() && rows.get_type() != sol::type::nil ) {
        if( rows.get_type() != sol::type::table ) {
            throw std::invalid_argument( "mapgen rows must be an array table" );
        }
        const sol::table row_values = rows.as<sol::table>();
        const std::size_t height = require_dense_array( row_values, "mapgen rows", 0, 24 );
        replacement.rows.reserve( height );
        std::size_t width = 0;
        for( std::size_t index = 1; index <= height; ++index ) {
            const sol::object raw_row = row_values.raw_get<sol::object>( index );
            if( raw_row.get_type() != sol::type::string ) {
                throw std::invalid_argument( "mapgen rows must contain strings" );
            }
            std::vector<std::string> row = utf8_display_split(
                                               raw_row.as<std::string>() );
            if( index == 1 ) {
                width = row.size();
            } else if( row.size() != width ) {
                throw std::invalid_argument( "mapgen rows must have equal display width" );
            }
            if( width > 24 || replacement.offset_x + static_cast<int>( width ) > 24 ) {
                throw std::invalid_argument( "mapgen rows exceed the 24-cell map width" );
            }
            replacement.rows.push_back( std::move( row ) );
        }
        if( replacement.offset_y + static_cast<int>( height ) > 24 ) {
            throw std::invalid_argument( "mapgen rows exceed the 24-cell map height" );
        }
    }
    replacement.palettes = platform_mapgen_string_array(
                               descriptor.raw_get<sol::object>( "palettes" ),
                               "mapgen palettes", 256, true, false );
    sol::object symbols = descriptor.raw_get<sol::object>( "symbols" );
    if( ( !symbols.valid() || symbols.get_type() == sol::type::nil ) &&
        descriptor.raw_get<sol::object>( "mapping" ).valid() ) {
        symbols = descriptor.raw_get<sol::object>( "mapping" );
    }
    replacement.symbols = platform_mapgen_symbol_map(
                              symbols, "mapgen definition symbols" );
    replacement.before_generate = descriptor.raw_get<sol::object>( "before_generate" );
    replacement.after_generate = descriptor.raw_get<sol::object>( "after_generate" );
    if( ( !replacement.after_generate.valid() ||
          replacement.after_generate.get_type() == sol::type::nil ) &&
        descriptor.raw_get<sol::object>( "on_generate" ).valid() ) {
        replacement.after_generate = descriptor.raw_get<sol::object>( "on_generate" );
    }
    for( const std::pair<const char *, sol::object *> &callback : {
             std::pair<const char *, sol::object *>( "before_generate",
                     &replacement.before_generate ),
             std::pair<const char *, sol::object *>( "after_generate",
                     &replacement.after_generate )
         } ) {
        if( callback.second->valid() && callback.second->get_type() != sol::type::nil &&
            callback.second->get_type() != sol::type::function ) {
            throw std::invalid_argument( std::string( "mapgen " ) + callback.first +
                                         " must be a function" );
        }
    }
    if( replacement.rows.empty() && replacement.fill_terrain.empty() &&
        ( !replacement.before_generate.valid() ||
          replacement.before_generate.get_type() == sol::type::nil ) &&
        ( !replacement.after_generate.valid() ||
          replacement.after_generate.get_type() == sol::type::nil ) ) {
        throw std::invalid_argument(
            "mapgen definition requires rows, fill_terrain, or a callback" );
    }
    const auto existing = std::find_if(
                              owner.declarative_mapgens.begin(),
                              owner.declarative_mapgens.end(),
    [&replacement]( const runtime::declarative_mapgen_definition & entry ) {
        return entry.id == replacement.id;
    } );
    if( existing != owner.declarative_mapgens.end() ) {
        replacement.registration_id = existing->registration_id;
        *existing = std::move( replacement );
        return existing->registration_id;
    }
    if( owner.declarative_mapgens.size() >= 4096 ) {
        throw std::runtime_error( "ccb.services.mapgen definition limit reached" );
    }
    replacement.registration_id = next_platform_mapgen_registration_id( owner );
    const std::uint64_t result = replacement.registration_id;
    owner.declarative_mapgens.push_back( std::move( replacement ) );
    return result;
}

void validate_platform_tileset_descriptor_keys(
    const sol::table &descriptor, const std::set<std::string> &allowed,
    const std::string_view description )
{
    for( const auto &entry : descriptor ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument( std::string( description ) +
                                         " keys must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        if( allowed.count( key ) == 0 ) {
            throw std::invalid_argument( std::string( description ) +
                                         " received unknown option '" + key + "'" );
        }
    }
}

std::int64_t platform_tileset_integer(
    const sol::table &descriptor, const std::string_view key,
    const std::int64_t fallback, const std::int64_t minimum,
    const std::int64_t maximum )
{
    const sol::object value = descriptor.raw_get<sol::object>( std::string( key ) );
    if( !value.valid() || value.get_type() == sol::type::nil ) {
        return fallback;
    }
    if( !value.is<lua_Integer>() ) {
        throw std::invalid_argument( "Lua-first tileset " + std::string( key ) +
                                     " must be an integer" );
    }
    const std::int64_t result = value.as<std::int64_t>();
    if( result < minimum || result > maximum ) {
        throw std::invalid_argument( "Lua-first tileset " + std::string( key ) +
                                     " is outside its supported range" );
    }
    return result;
}

double platform_tileset_number(
    const sol::table &descriptor, const std::string_view key,
    const double fallback, const double minimum, const double maximum )
{
    const sol::object value = descriptor.raw_get<sol::object>( std::string( key ) );
    if( !value.valid() || value.get_type() == sol::type::nil ) {
        return fallback;
    }
    if( value.get_type() != sol::type::number ) {
        throw std::invalid_argument( "Lua-first tileset " + std::string( key ) +
                                     " must be a number" );
    }
    const double result = value.as<double>();
    if( !std::isfinite( result ) || result < minimum || result > maximum ) {
        throw std::invalid_argument( "Lua-first tileset " + std::string( key ) +
                                     " is outside its supported range" );
    }
    return result;
}

bool platform_tileset_boolean(
    const sol::table &descriptor, const std::string_view key,
    const bool fallback )
{
    const sol::object value = descriptor.raw_get<sol::object>( std::string( key ) );
    if( !value.valid() || value.get_type() == sol::type::nil ) {
        return fallback;
    }
    if( value.get_type() != sol::type::boolean ) {
        throw std::invalid_argument( "Lua-first tileset " + std::string( key ) +
                                     " must be a boolean" );
    }
    return value.as<bool>();
}

std::vector<int> platform_tileset_sprite_tuple(
    const sol::object &source, const std::string_view description )
{
    std::vector<int> result;
    if( source.is<lua_Integer>() ) {
        const std::int64_t sprite = source.as<std::int64_t>();
        if( sprite < 0 || sprite > std::numeric_limits<int>::max() ) {
            throw std::invalid_argument( std::string( description ) +
                                         " contains an invalid sprite index" );
        }
        result.push_back( static_cast<int>( sprite ) );
        return result;
    }
    if( source.get_type() != sol::type::table ) {
        throw std::invalid_argument( std::string( description ) +
                                     " must be an integer or a 1/2/4-integer array" );
    }
    const sol::table values = source.as<sol::table>();
    const std::size_t count = require_dense_array( values, description, 1, 4 );
    if( count != 1 && count != 2 && count != 4 ) {
        throw std::invalid_argument( std::string( description ) +
                                     " must contain 1, 2, or 4 sprite indices" );
    }
    result.reserve( count );
    for( std::size_t index = 1; index <= count; ++index ) {
        const sol::object value = values.raw_get<sol::object>( index );
        if( !value.is<lua_Integer>() ) {
            throw std::invalid_argument( std::string( description ) +
                                         " must contain native integers" );
        }
        const std::int64_t sprite = value.as<std::int64_t>();
        if( sprite < 0 || sprite > std::numeric_limits<int>::max() ) {
            throw std::invalid_argument( std::string( description ) +
                                         " contains an invalid sprite index" );
        }
        result.push_back( static_cast<int>( sprite ) );
    }
    return result;
}

std::vector<mod_tileset_sprite_variation> platform_tileset_sprite_variations(
    const sol::object &source, const std::string_view description )
{
    if( !source.valid() || source.get_type() == sol::type::nil ) {
        return {};
    }
    if( source.is<lua_Integer>() ) {
        return { { platform_tileset_sprite_tuple( source, description ), 1 } };
    }
    if( source.get_type() != sol::type::table ) {
        throw std::invalid_argument( std::string( description ) +
                                     " must be a sprite or variation array" );
    }
    const sol::table values = source.as<sol::table>();
    const std::size_t count = require_dense_array( values, description, 1, 1024 );
    const sol::object first = values.raw_get<sol::object>( 1 );
    if( first.is<lua_Integer>() ) {
        return { { platform_tileset_sprite_tuple( source, description ), 1 } };
    }
    std::vector<mod_tileset_sprite_variation> result;
    result.reserve( count );
    std::int64_t total_weight = 0;
    for( std::size_t index = 1; index <= count; ++index ) {
        const sol::object raw_variation = values.raw_get<sol::object>( index );
        if( raw_variation.get_type() != sol::type::table ) {
            throw std::invalid_argument( std::string( description ) +
                                         " cannot mix sprites and weighted variations" );
        }
        const sol::table variation = raw_variation.as<sol::table>();
        validate_platform_tileset_descriptor_keys(
            variation, { "weight", "sprite" }, description );
        const sol::object sprite = variation.raw_get<sol::object>( "sprite" );
        if( !sprite.valid() || sprite.get_type() == sol::type::nil ) {
            throw std::invalid_argument( std::string( description ) +
                                         " variation requires sprite" );
        }
        const std::int64_t weight = platform_tileset_integer(
                                        variation, "weight", 1, 1, 1000000 );
        if( total_weight > 1000000000 - weight ) {
            throw std::invalid_argument( std::string( description ) +
                                         " total variation weight is too large" );
        }
        total_weight += weight;
        result.push_back( {
            platform_tileset_sprite_tuple( sprite, description ),
            static_cast<int>( weight )
        } );
    }
    return result;
}

std::vector<std::string> platform_tileset_ids(
    const sol::object &source, const std::string_view description,
    const bool single )
{
    if( single && source.get_type() != sol::type::string ) {
        throw std::invalid_argument( std::string( description ) +
                                     " must be a single string id" );
    }
    return platform_mapgen_string_array(
               source, description, single ? 1 : 256, true, false );
}

mod_tileset_tile_definition platform_tileset_tile(
    const sol::table &descriptor, const bool subtile )
{
    validate_platform_tileset_descriptor_keys(
    descriptor, {
        "id", "fg", "bg", "multitile", "rotates", "animated",
        "height_3d", "additional_tiles"
    },
    subtile ? "Lua-first tileset subtile" : "Lua-first tileset tile" );
    mod_tileset_tile_definition result;
    result.ids = platform_tileset_ids(
                     descriptor.raw_get<sol::object>( "id" ),
                     subtile ? "Lua-first tileset subtile id" :
                     "Lua-first tileset tile id", subtile );
    if( result.ids.empty() ) {
        throw std::invalid_argument( "Lua-first tileset tile requires id" );
    }
    result.foreground = platform_tileset_sprite_variations(
                            descriptor.raw_get<sol::object>( "fg" ),
                            "Lua-first tileset foreground" );
    result.background = platform_tileset_sprite_variations(
                            descriptor.raw_get<sol::object>( "bg" ),
                            "Lua-first tileset background" );
    if( result.foreground.empty() && result.background.empty() ) {
        throw std::invalid_argument(
            "Lua-first tileset tile requires fg or bg sprites" );
    }
    result.multitile = platform_tileset_boolean(
                           descriptor, "multitile", false );
    const sol::object rotates = descriptor.raw_get<sol::object>( "rotates" );
    if( rotates.valid() && rotates.get_type() != sol::type::nil ) {
        if( rotates.get_type() != sol::type::boolean ) {
            throw std::invalid_argument(
                "Lua-first tileset rotates must be a boolean" );
        }
        result.rotates = rotates.as<bool>();
    }
    result.animated = platform_tileset_boolean(
                          descriptor, "animated", false );
    result.height_3d = static_cast<int>( platform_tileset_integer(
            descriptor, "height_3d", 0,
            -4096, 4096 ) );
    const sol::object raw_additional = descriptor.raw_get<sol::object>(
                                           "additional_tiles" );
    if( raw_additional.valid() && raw_additional.get_type() != sol::type::nil ) {
        if( raw_additional.get_type() != sol::type::table ) {
            throw std::invalid_argument(
                "Lua-first tileset additional_tiles must be an array table" );
        }
        const sol::table additional = raw_additional.as<sol::table>();
        const std::size_t count = require_dense_array(
                                      additional, "Lua-first tileset additional_tiles",
                                      0, 256 );
        result.additional_tiles.reserve( count );
        for( std::size_t index = 1; index <= count; ++index ) {
            const sol::object raw_entry = additional.raw_get<sol::object>( index );
            if( raw_entry.get_type() != sol::type::table ) {
                throw std::invalid_argument(
                    "Lua-first tileset additional_tiles must contain tables" );
            }
            result.additional_tiles.push_back(
                platform_tileset_tile( raw_entry.as<sol::table>(), true ) );
        }
    }
    if( subtile && ( result.multitile || !result.additional_tiles.empty() ) ) {
        throw std::invalid_argument(
            "Lua-first tileset subtiles cannot contain nested multitiles" );
    }
    if( !subtile && result.multitile != !result.additional_tiles.empty() ) {
        throw std::invalid_argument(
            "Lua-first tileset multitile and additional_tiles must be provided together" );
    }
    return result;
}

bool platform_tileset_relative_file(
    const std::string &value, std::filesystem::path &relative )
{
    if( value.empty() || value.size() > 4096 ||
        value.find( '\0' ) != std::string::npos ) {
        return false;
    }
    relative = std::filesystem::u8path( value );
    if( relative.empty() || relative.is_absolute() || relative.has_root_path() ) {
        return false;
    }
    for( const std::filesystem::path &part : relative ) {
        if( part == "." || part == ".." ) {
            return false;
        }
    }
    relative = relative.lexically_normal();
    return !relative.empty();
}

[[maybe_unused]] bool platform_filesystem_path_is_within(
    const std::filesystem::path &path,
    const std::filesystem::path &directory )
{
    auto path_part = path.begin();
    for( auto directory_part = directory.begin();
         directory_part != directory.end(); ++directory_part, ++path_part ) {
        if( path_part == path.end() || *path_part != *directory_part ) {
            return false;
        }
    }
    return true;
}

mod_tileset_ascii_definition platform_tileset_ascii(
    const sol::table &descriptor )
{
    validate_platform_tileset_descriptor_keys(
        descriptor, { "offset", "color", "bold" },
        "Lua-first tileset ASCII set" );
    mod_tileset_ascii_definition result;
    result.offset = static_cast<int>( platform_tileset_integer(
                                          descriptor, "offset", 0, -255,
                                          std::numeric_limits<int>::max() ) );
    const sol::object raw_color = descriptor.raw_get<sol::object>( "color" );
    std::string color = "DEFAULT";
    if( raw_color.valid() && raw_color.get_type() != sol::type::nil ) {
        if( raw_color.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "Lua-first tileset ASCII color must be a string" );
        }
        color = raw_color.as<std::string>();
    }
    static const std::map<std::string, mod_tileset_ascii_color> colors = {
        { "DEFAULT", mod_tileset_ascii_color::default_color },
        { "BLACK", mod_tileset_ascii_color::black },
        { "RED", mod_tileset_ascii_color::red },
        { "GREEN", mod_tileset_ascii_color::green },
        { "YELLOW", mod_tileset_ascii_color::yellow },
        { "BLUE", mod_tileset_ascii_color::blue },
        { "MAGENTA", mod_tileset_ascii_color::magenta },
        { "CYAN", mod_tileset_ascii_color::cyan },
        { "WHITE", mod_tileset_ascii_color::white }
    };
    const auto found = colors.find( color );
    if( found == colors.end() ) {
        throw std::invalid_argument(
            "Lua-first tileset ASCII color is invalid" );
    }
    result.color = found->second;
    result.bold = platform_tileset_boolean( descriptor, "bold", false );
    return result;
}

mod_tileset_atlas_definition platform_tileset_atlas(
    const sol::table &descriptor )
{
    validate_platform_tileset_descriptor_keys(
    descriptor, {
        "file", "sprite_width", "sprite_height", "sprite_offset_x",
        "sprite_offset_y", "sprite_offset_x_retracted",
        "sprite_offset_y_retracted", "pixelscale", "transparency", "tiles",
        "ascii"
    },
    "Lua-first tileset atlas" );
    mod_tileset_atlas_definition result;
    const sol::object file = descriptor.raw_get<sol::object>( "file" );
    if( file.get_type() != sol::type::string ) {
        throw std::invalid_argument(
            "Lua-first tileset atlas requires a relative file" );
    }
    std::filesystem::path relative;
    if( !platform_tileset_relative_file( file.as<std::string>(), relative ) ) {
        throw std::invalid_argument(
            "Lua-first tileset atlas file must stay within the Mod root" );
    }
    result.file = relative.generic_u8string();
    result.sprite_width = static_cast<int>( platform_tileset_integer(
            descriptor, "sprite_width", 0, 0, 4096 ) );
    result.sprite_height = static_cast<int>( platform_tileset_integer(
                               descriptor, "sprite_height", 0, 0, 4096 ) );
    if( ( result.sprite_width == 0 ) != ( result.sprite_height == 0 ) ) {
        throw std::invalid_argument(
            "Lua-first tileset sprite_width and sprite_height must be provided together" );
    }
    result.sprite_offset_x = static_cast<int>( platform_tileset_integer(
                                 descriptor, "sprite_offset_x", 0, -4096, 4096 ) );
    result.sprite_offset_y = static_cast<int>( platform_tileset_integer(
                                 descriptor, "sprite_offset_y", 0, -4096, 4096 ) );
    result.sprite_offset_x_retracted = static_cast<int>( platform_tileset_integer(
                                           descriptor, "sprite_offset_x_retracted", result.sprite_offset_x,
                                           -4096, 4096 ) );
    result.sprite_offset_y_retracted = static_cast<int>( platform_tileset_integer(
                                           descriptor, "sprite_offset_y_retracted", result.sprite_offset_y,
                                           -4096, 4096 ) );
    result.pixelscale = static_cast<float>( platform_tileset_number(
            descriptor, "pixelscale", 1.0, 0.0001, 64.0 ) );
    const sol::object transparency = descriptor.raw_get<sol::object>( "transparency" );
    if( transparency.valid() && transparency.get_type() != sol::type::nil ) {
        if( transparency.get_type() != sol::type::table ) {
            throw std::invalid_argument(
                "Lua-first tileset transparency must be a table" );
        }
        const sol::table color = transparency.as<sol::table>();
        validate_platform_tileset_descriptor_keys(
            color, { "r", "g", "b" }, "Lua-first tileset transparency" );
        result.transparency_r = static_cast<int>( platform_tileset_integer(
                                    color, "r", -1, -1, 255 ) );
        result.transparency_g = static_cast<int>( platform_tileset_integer(
                                    color, "g", -1, -1, 255 ) );
        result.transparency_b = static_cast<int>( platform_tileset_integer(
                                    color, "b", -1, -1, 255 ) );
        const bool disabled = result.transparency_r == -1 &&
                              result.transparency_g == -1 &&
                              result.transparency_b == -1;
        const bool enabled = result.transparency_r >= 0 &&
                             result.transparency_g >= 0 &&
                             result.transparency_b >= 0;
        if( !disabled && !enabled ) {
            throw std::invalid_argument(
                "Lua-first tileset transparency must provide all RGB channels or disable all" );
        }
    }
    const sol::object raw_tiles = descriptor.raw_get<sol::object>( "tiles" );
    if( raw_tiles.get_type() != sol::type::table ) {
        throw std::invalid_argument(
            "Lua-first tileset atlas requires a tiles array" );
    }
    const sol::table tiles = raw_tiles.as<sol::table>();
    const std::size_t count = require_dense_array(
                                  tiles, "Lua-first tileset atlas tiles", 0, 65536 );
    result.tiles.reserve( count );
    for( std::size_t index = 1; index <= count; ++index ) {
        const sol::object raw_tile = tiles.raw_get<sol::object>( index );
        if( raw_tile.get_type() != sol::type::table ) {
            throw std::invalid_argument(
                "Lua-first tileset atlas tiles must contain tables" );
        }
        result.tiles.push_back(
            platform_tileset_tile( raw_tile.as<sol::table>(), false ) );
    }
    const sol::object raw_ascii = descriptor.raw_get<sol::object>( "ascii" );
    if( raw_ascii.valid() && raw_ascii.get_type() != sol::type::nil ) {
        if( raw_ascii.get_type() != sol::type::table ) {
            throw std::invalid_argument(
                "Lua-first tileset ascii must be an array table" );
        }
        const sol::table ascii = raw_ascii.as<sol::table>();
        const std::size_t ascii_count = require_dense_array(
                                            ascii, "Lua-first tileset ascii", 0, 256 );
        result.ascii.reserve( ascii_count );
        for( std::size_t index = 1; index <= ascii_count; ++index ) {
            const sol::object raw_entry = ascii.raw_get<sol::object>( index );
            if( raw_entry.get_type() != sol::type::table ) {
                throw std::invalid_argument(
                    "Lua-first tileset ascii must contain tables" );
            }
            result.ascii.push_back(
                platform_tileset_ascii( raw_entry.as<sol::table>() ) );
        }
    }
    if( result.tiles.empty() && result.ascii.empty() ) {
        throw std::invalid_argument(
            "Lua-first tileset atlas requires tiles or ascii mappings" );
    }
    return result;
}

mod_tileset_definition platform_tileset_definition(
    const sol::table &descriptor )
{
    validate_platform_tileset_descriptor_keys(
        descriptor, { "id", "compatibility", "atlases", "overlay_ordering" },
        "ccb.services.tileset.register" );
    mod_tileset_definition result;
    result.id = descriptor.get_or( "id", std::string() );
    if( result.id.empty() || result.id.size() > 256 ||
        result.id.find( '\0' ) != std::string::npos ) {
        throw std::invalid_argument(
            "Lua-first tileset id must contain 1 to 256 non-NUL bytes" );
    }
    result.compatibility = platform_tileset_ids(
                               descriptor.raw_get<sol::object>( "compatibility" ),
                               "Lua-first tileset compatibility", false );
    if( result.compatibility.empty() ) {
        throw std::invalid_argument(
            "Lua-first tileset compatibility must not be empty" );
    }
    const sol::object raw_atlases = descriptor.raw_get<sol::object>( "atlases" );
    if( raw_atlases.valid() && raw_atlases.get_type() != sol::type::nil ) {
        if( raw_atlases.get_type() != sol::type::table ) {
            throw std::invalid_argument(
                "Lua-first tileset atlases must be an array table" );
        }
        const sol::table atlases = raw_atlases.as<sol::table>();
        const std::size_t count = require_dense_array(
                                      atlases, "Lua-first tileset atlases", 0, 64 );
        result.atlases.reserve( count );
        for( std::size_t index = 1; index <= count; ++index ) {
            const sol::object raw_atlas = atlases.raw_get<sol::object>( index );
            if( raw_atlas.get_type() != sol::type::table ) {
                throw std::invalid_argument(
                    "Lua-first tileset atlases must contain tables" );
            }
            result.atlases.push_back(
                platform_tileset_atlas( raw_atlas.as<sol::table>() ) );
        }
    }
    const sol::object raw_ordering = descriptor.raw_get<sol::object>(
                                         "overlay_ordering" );
    if( raw_ordering.valid() && raw_ordering.get_type() != sol::type::nil ) {
        if( raw_ordering.get_type() != sol::type::table ) {
            throw std::invalid_argument(
                "Lua-first tileset overlay_ordering must be an array table" );
        }
        const sol::table orderings = raw_ordering.as<sol::table>();
        const std::size_t count = require_dense_array(
                                      orderings, "Lua-first tileset overlay_ordering",
                                      0, 4096 );
        result.overlay_ordering.reserve( count );
        for( std::size_t index = 1; index <= count; ++index ) {
            const sol::object raw_order = orderings.raw_get<sol::object>( index );
            if( raw_order.get_type() != sol::type::table ) {
                throw std::invalid_argument(
                    "Lua-first tileset overlay_ordering must contain tables" );
            }
            const sol::table ordering = raw_order.as<sol::table>();
            validate_platform_tileset_descriptor_keys(
                ordering, { "id", "order" },
                "Lua-first tileset overlay ordering entry" );
            mod_tileset_overlay_ordering entry;
            entry.ids = platform_tileset_ids(
                            ordering.raw_get<sol::object>( "id" ),
                            "Lua-first tileset overlay ordering id", false );
            if( entry.ids.empty() ) {
                throw std::invalid_argument(
                    "Lua-first tileset overlay ordering requires id" );
            }
            entry.order = static_cast<int>( platform_tileset_integer(
                                                ordering, "order", 9999,
                                                std::numeric_limits<int>::min(),
                                                std::numeric_limits<int>::max() ) );
            result.overlay_ordering.push_back( std::move( entry ) );
        }
    }
    if( result.atlases.empty() && result.overlay_ordering.empty() ) {
        throw std::invalid_argument(
            "Lua-first tileset requires atlases or overlay_ordering" );
    }

    std::set<std::string> mapped_ids;
    for( const mod_tileset_atlas_definition &atlas : result.atlases ) {
        for( const mod_tileset_tile_definition &tile : atlas.tiles ) {
            for( const std::string &id : tile.ids ) {
                if( !mapped_ids.insert( id ).second ) {
                    throw std::invalid_argument(
                        "Lua-first tileset contains duplicate tile id '" + id + "'" );
                }
                for( const mod_tileset_tile_definition &subtile :
                     tile.additional_tiles ) {
                    const std::string generated = id + "_" + subtile.ids.front();
                    if( !mapped_ids.insert( generated ).second ) {
                        throw std::invalid_argument(
                            "Lua-first tileset contains duplicate tile id '" +
                            generated + "'" );
                    }
                }
            }
        }
    }
    std::set<std::string> overlay_ids;
    for( const mod_tileset_overlay_ordering &ordering : result.overlay_ordering ) {
        for( const std::string &id : ordering.ids ) {
            if( !overlay_ids.insert( id ).second ) {
                throw std::invalid_argument(
                    "Lua-first tileset contains duplicate overlay ordering id '" +
                    id + "'" );
            }
        }
    }
    return result;
}

std::string register_platform_tileset( runtime &owner,
                                       const sol::table &descriptor )
{
    if( owner.world_is_ready ) {
        throw std::runtime_error(
            "ccb.services.tileset.register is only available during bootstrap" );
    }
    if( owner.mod_root.empty() ) {
        throw std::runtime_error(
            "ccb.services.tileset.register requires a filesystem-backed Mod runtime" );
    }
    mod_tileset_definition definition = platform_tileset_definition( descriptor );
    if( owner.native_tilesets.size() >= 256 ) {
        throw std::runtime_error(
            "Lua-first tileset registration limit reached" );
    }
    const auto existing = std::find_if(
                              owner.native_tilesets.begin(), owner.native_tilesets.end(),
    [&definition]( const mod_tileset_definition & entry ) {
        return entry.id == definition.id;
    } );
    if( existing != owner.native_tilesets.end() ) {
        throw std::invalid_argument(
            "duplicate Lua-first tileset id '" + definition.id + "'" );
    }
    const std::string result = definition.id;
    owner.native_tilesets.push_back( std::move( definition ) );
    return result;
}


} // namespace

void install_runtime_api( const std::shared_ptr<runtime> &value,
                          sol::state &lua, sol::table &ccb )
{
    value->content.install_lua_api( lua, ccb, value );
    cata::lua_platform::install_script_mapgen_context_api( lua );

    ccb.new_usertype<use_context_data>(
        "ItemUseContext", sol::no_constructor,
        "message", &use_context_data::message,
        "player_name", sol::property( &use_context_data::player_name ),
        "item_id", sol::property( &use_context_data::item_id ),
        "character", sol::property( &use_context_data::character_handle ),
        "item", sol::property( &use_context_data::item_handle ),
        "position", sol::property( &use_context_data::use_position ),
        "charges", sol::property( &use_context_data::charges,
                                  &use_context_data::set_charges ) );
    ccb.new_usertype<computer_access_context>(
        "ComputerAccessContext", sol::no_constructor,
        "message", &computer_access_context::message,
        "name", sol::property( &computer_access_context::name,
                               &computer_access_context::set_name ),
        "access_denied", sol::property( &computer_access_context::access_denied,
                                        &computer_access_context::set_access_denied ),
        "security", sol::property( &computer_access_context::security,
                                   &computer_access_context::set_security ),
        "alerts", sol::property( &computer_access_context::alerts,
                                 &computer_access_context::set_alerts ),
        "mission_id", sol::property( &computer_access_context::mission_id,
                                     &computer_access_context::set_mission_id ),
        "character", sol::property( &computer_access_context::character_handle ),
        "position", sol::property( &computer_access_context::position ),
        "get_value", &computer_access_context::get_value,
        "set_value", &computer_access_context::set_value,
        "remove_value", &computer_access_context::remove_value );
    detail::install_runtime_dialogue_presentation_api( value, lua, ccb );

    detail::install_runtime_callback_api( value, lua, ccb );

    detail::install_runtime_state_task_api( value, lua, ccb );

    const std::weak_ptr<runtime> weak = value;


    sol::table services = lua.create_table();
    services.set_function( "message", [weak]( const std::string & message ) {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner || !owner->world_is_ready ) {
            throw std::runtime_error( "services are only available after world_ready" );
        }
        ::add_msg( message );
    } );
    services.set_function( "turn", [weak]() {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner || !owner->world_is_ready ) {
            throw std::runtime_error( "services are only available after world_ready" );
        }
        return to_turn<std::int64_t>( calendar::turn );
    } );
    sol::table mapgen = lua.create_table();
    const auto register_mapgen = [weak](
                                     const std::string & handler_id,
                                     const sol::optional<sol::table> &options,
                                     const bool primary,
    const std::string_view api_name ) {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner ) {
            throw std::runtime_error( "stale Platform runtime" );
        }
        if( handler_id.empty() ) {
            throw std::invalid_argument(
                std::string( api_name ) + " requires a handler id" );
        }
        runtime::mapgen_registration registration;
        registration.handler_id = handler_id;
        registration.primary = primary;
        if( options ) {
            if( const sol::optional<int> z_min =
                    options->get<sol::optional<int>>( "z_min" ) ) {
                registration.z_min = *z_min;
            }
            if( const sol::optional<int> z_max =
                    options->get<sol::optional<int>>( "z_max" ) ) {
                registration.z_max = *z_max;
            }
            const sol::object terrain_ids = options->raw_get<sol::object>(
                                                "terrain_ids" );
            if( terrain_ids.valid() && terrain_ids.get_type() != sol::type::nil ) {
                if( terrain_ids.get_type() != sol::type::table ) {
                    throw std::invalid_argument(
                        "mapgen terrain_ids must be a dense string array" );
                }
                const sol::table values = terrain_ids.as<sol::table>();
                const std::size_t count = require_dense_array(
                                              values, "mapgen terrain_ids", 1, 256 );
                registration.terrain_ids.reserve( count );
                for( std::size_t index = 1; index <= count; ++index ) {
                    const sol::object entry = values.raw_get<sol::object>( index );
                    if( entry.get_type() != sol::type::string ) {
                        throw std::invalid_argument(
                            "mapgen terrain_ids must contain only strings" );
                    }
                    registration.terrain_ids.push_back( entry.as<std::string>() );
                }
                std::sort( registration.terrain_ids.begin(),
                           registration.terrain_ids.end() );
                if( std::adjacent_find( registration.terrain_ids.begin(),
                                        registration.terrain_ids.end() ) !=
                    registration.terrain_ids.end() ) {
                    throw std::invalid_argument(
                        "mapgen terrain_ids cannot contain duplicates" );
                }
            }
        }
        if( registration.z_min > registration.z_max ) {
            throw std::invalid_argument( "mapgen z_min cannot exceed z_max" );
        }
        owner->mapgen_handlers.push_back( std::move( registration ) );
    };
    mapgen.set_function( "on_generate", [register_mapgen](
    const std::string & handler_id, const sol::optional<sol::table> &options ) {
        register_mapgen( handler_id, options, true,
                         "services.mapgen.on_generate" );
    } );
    mapgen.set_function( "on_postprocess", [register_mapgen](
    const std::string & handler_id, const sol::optional<sol::table> &options ) {
        register_mapgen( handler_id, options, false,
                         "services.mapgen.on_postprocess" );
    } );
    mapgen.set_function( "register_palette", [weak]( const sol::table & descriptor ) {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner ) {
            throw std::runtime_error( "stale Platform runtime" );
        }
        return register_platform_mapgen_palette( *owner, descriptor );
    } );
    mapgen.set_function( "define", [weak]( const sol::table & descriptor ) {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner ) {
            throw std::runtime_error( "stale Platform runtime" );
        }
        return register_platform_declarative_mapgen( *owner, descriptor );
    } );
    mapgen.set_function( "limits", []( sol::this_state state ) {
        sol::state_view lua_state( state );
        return lua_state.create_table_with(
                   "palettes", 4096,
                   "definitions", 4096,
                   "symbols_per_palette", 4096,
                   "palettes_per_definition", 256,
                   "terrain_ids_per_definition", 4096,
                   "width", cata::lua_platform::script_mapgen_context::map_width,
                   "height", cata::lua_platform::script_mapgen_context::map_height );
    } );
    services["mapgen"] = std::move( mapgen );

    sol::table tileset = lua.create_table();
    tileset.set_function( "register", [weak]( const sol::table & descriptor ) {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner ) {
            throw std::runtime_error( "stale Platform runtime" );
        }
        return register_platform_tileset( *owner, descriptor );
    } );
    tileset.set_function( "limits", []( sol::this_state state ) {
        sol::state_view lua_state( state );
        return lua_state.create_table_with(
                   "definitions", 256,
                   "atlases_per_definition", 64,
                   "tiles_per_atlas", 65536,
                   "ids_per_tile", 256,
                   "variations_per_layer", 1024,
                   "additional_tiles_per_tile", 256,
                   "overlay_entries_per_definition", 4096 );
    } );
    services["tileset"] = std::move( tileset );

    // Platform installs the domain-shaped services directly into its one
    // authoring contract. No legacy global table or compatibility namespace is
    // created.
    const auto runtime_generation = [weak]() {
        const std::shared_ptr<runtime> owner = weak.lock();
        return owner ? owner->handle_runtime() :
               cata::lua_platform::game_handle_runtime();
    };
    const auto world_generation = []() {
        return active_world_generation;
    };
    const auto require_read = [weak]() {
        require_live_runtime( weak, "Platform domain services" );
    };
    const auto require_write = [weak]() {
        require_live_runtime( weak, "Platform domain mutations" );
        if( !runtime_callback_is_active( weak ) ) {
            throw std::runtime_error(
                "Platform domain mutations are only available inside a runtime callback" );
        }
        if( platform_mapgen_callback_write_depth > 0 ) {
            throw std::runtime_error(
                "Mapgen callbacks may mutate only through ScriptMapgenContext" );
        }
        cata::lua_platform::bump_item_query_mutation_epoch();
    };
    const auto has_callback = [weak]() {
        return runtime_callback_is_active( weak );
    };
    const auto source_id = [weak]() {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner ) {
            throw std::runtime_error( "stale Platform runtime" );
        }
        return owner->mod_id;
    };
    const auto random_index = [weak]( const std::size_t count ) {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner || !owner->world_is_ready || owner->callback_depth <= 0 ) {
            throw std::runtime_error(
                "Platform gameplay randomness is only available inside a runtime callback" );
        }
        if( count == 0 ) {
            throw std::invalid_argument( "Platform random selection requires a non-empty range" );
        }
        std::uniform_int_distribution<std::size_t> distribution( 0, count - 1 );
        return distribution( owner->random_engine );
    };

    cata::lua_platform::install_mapgen_service_api(
        services, runtime_generation, world_generation, require_read, require_write );

    cata::lua_platform::install_value_type_api( lua, services, require_read );
    cata::lua_platform::install_registry_api( lua, services, require_read, require_read );
    cata::lua_platform::install_time_api( services, require_read, require_write );
    cata::lua_platform::install_game_handle_api( lua, services, runtime_generation,
            world_generation, require_read );
    cata::lua_platform::install_creature_api( services, runtime_generation, world_generation,
            require_read, require_write );
    cata::lua_platform::install_effect_api( services, runtime_generation, world_generation,
                                            require_read, require_write );
    cata::lua_platform::install_bionic_api( services, runtime_generation, world_generation,
                                            require_read, require_write );
    sol::table bionics = services["bionics"];
    bionics.set_function( "summary", [require_read, runtime_generation, world_generation](
    sol::this_state state, const cata::lua_platform::game_handle & handle ) {
        require_read();
        sol::state_view lua_state( state );
        const cata::lua_platform::native_handle_result<Creature> resolved =
            handle.resolve_creature( runtime_generation(), world_generation() );
        if( !resolved ) {
            return cata::lua_platform::make_game_error_result( lua_state, *resolved.error );
        }
        Character *character = dynamic_cast<Character *>( resolved.value );
        if( character == nullptr ) {
            return cata::lua_platform::make_game_error_result( lua_state, {
                "wrong_target", "services.bionics.summary requires a character handle"
            } );
        }
        const auto energy_value = []( const units::energy & value ) {
            return cata::lua_platform::script_unit_value::from_canonical_integer(
                       "energy", "millijoule", value.value() );
        };
        sol::table value = lua_state.create_table();
        value["installed_count"] = character->num_bionics();
        value["power"] = energy_value( character->get_power_level() );
        value["maximum_power"] = energy_value( character->get_max_power_level() );
        value["has_capacity"] = character->has_max_power();
        return cata::lua_platform::make_game_value_result(
                   lua_state, sol::make_object( lua_state, std::move( value ) ) );
    } );
    bionics.set_function( "grant", [require_write, runtime_generation, world_generation](
                              sol::this_state state, const cata::lua_platform::game_handle & handle,
    const cata::lua_platform::script_game_id & id ) {
        require_write();
        if( id.kind() != "bionic" || !id.is_valid() ) {
            throw std::invalid_argument(
                "services.bionics.grant requires a valid GameId<bionic>" );
        }
        sol::state_view lua_state( state );
        const cata::lua_platform::native_handle_result<Creature> resolved =
            handle.resolve_creature( runtime_generation(), world_generation() );
        if( !resolved ) {
            return cata::lua_platform::make_game_error_result( lua_state, *resolved.error );
        }
        Character *character = dynamic_cast<Character *>( resolved.value );
        if( character == nullptr ) {
            return cata::lua_platform::make_game_error_result( lua_state, {
                "wrong_target", "services.bionics.grant requires a character handle"
            } );
        }
        const int before = character->num_bionics();
        const bionic_uid uid = character->add_bionic( bionic_id( id.value() ) );
        sol::table value = lua_state.create_table();
        value["changed"] = character->num_bionics() != before;
        value["uid"] = static_cast<std::uint64_t>( uid );
        value["count"] = character->num_bionics();
        return cata::lua_platform::make_game_value_result(
                   lua_state, sol::make_object( lua_state, std::move( value ) ) );
    } );
    bionics.set_function( "remove_type", [require_write, runtime_generation, world_generation](
                              sol::this_state state, const cata::lua_platform::game_handle & handle,
    const cata::lua_platform::script_game_id & id ) {
        require_write();
        if( id.kind() != "bionic" || !id.is_valid() ) {
            throw std::invalid_argument(
                "services.bionics.remove_type requires a valid GameId<bionic>" );
        }
        sol::state_view lua_state( state );
        const cata::lua_platform::native_handle_result<Creature> resolved =
            handle.resolve_creature( runtime_generation(), world_generation() );
        if( !resolved ) {
            return cata::lua_platform::make_game_error_result( lua_state, *resolved.error );
        }
        Character *character = dynamic_cast<Character *>( resolved.value );
        if( character == nullptr ) {
            return cata::lua_platform::make_game_error_result( lua_state, {
                "wrong_target", "services.bionics.remove_type requires a character handle"
            } );
        }
        bool changed = false;
        if( const std::optional<bionic *> installed =
                character->find_bionic_by_type( bionic_id( id.value() ) ) ) {
            character->remove_bionic( **installed );
            changed = true;
        }
        sol::table value = lua_state.create_table();
        value["changed"] = changed;
        value["count"] = character->num_bionics();
        return cata::lua_platform::make_game_value_result(
                   lua_state, sol::make_object( lua_state, std::move( value ) ) );
    } );
    services["bionics"] = std::move( bionics );
    const auto make_wound_snapshot = []( sol::state_view lua_state,
    const bodypart & part ) {
        sol::table snapshot = lua_state.create_table();
        const std::vector<wound> &native_wounds = part.get_wounds();
        for( std::size_t index = 0; index < native_wounds.size(); ++index ) {
            const wound &entry = native_wounds[index];
            double healing_fraction = static_cast<double>( entry.healing_percentage() );
            if( !std::isfinite( healing_fraction ) ) {
                healing_fraction = 0.0;
            }
            healing_fraction = std::clamp( healing_fraction, 0.0, 1.0 );
            sol::table value = lua_state.create_table();
            value["id"] = cata::lua_platform::script_game_id( "wound", entry.type.str() );
            value["base_pain"] = entry.get_base_pain();
            value["current_pain"] = entry.get_pain();
            value["healing_time"] =
                cata::lua_platform::script_time_duration::from_native( entry.get_healing_time() );
            value["healing_progress"] =
                cata::lua_platform::script_time_duration::from_native( entry.get_healing_progress() );
            value["healing_fraction"] = healing_fraction;
            snapshot[index + 1] = std::move( value );
        }
        return snapshot;
    };
    const auto same_wounds = []( const std::vector<wound> &lhs,
    const std::vector<wound> &rhs ) {
        if( lhs.size() != rhs.size() ) {
            return false;
        }
        for( std::size_t index = 0; index < lhs.size(); ++index ) {
            if( lhs[index].type != rhs[index].type ||
                lhs[index].get_base_pain() != rhs[index].get_base_pain() ||
                lhs[index].get_pain() != rhs[index].get_pain() ||
                lhs[index].get_healing_time() != rhs[index].get_healing_time() ||
                lhs[index].get_healing_progress() != rhs[index].get_healing_progress() ) {
                return false;
            }
        }
        return true;
    };
    sol::table wounds = lua.create_table();
    wounds.set_function( "snapshot", [require_read, runtime_generation, world_generation,
                                                    make_wound_snapshot]( sol::this_state state,
                                              const cata::lua_platform::game_handle & handle,
    const cata::lua_platform::script_game_id & body_part_id ) {
        require_read();
        if( body_part_id.kind() != "body_part" || !body_part_id.is_valid() ) {
            throw std::invalid_argument(
                "services.wounds.snapshot requires a valid GameId<body_part>" );
        }
        sol::state_view lua_state( state );
        const cata::lua_platform::native_handle_result<Creature> resolved =
            handle.resolve_creature( runtime_generation(), world_generation() );
        if( !resolved ) {
            return cata::lua_platform::make_game_error_result( lua_state, *resolved.error );
        }
        Character *character = dynamic_cast<Character *>( resolved.value );
        if( character == nullptr ) {
            return cata::lua_platform::make_game_error_result( lua_state, {
                "wrong_target", "services.wounds.snapshot requires a character handle"
            } );
        }
        const bodypart_id native_part_id = bodypart_str_id( body_part_id.value() ).id();
        if( !character->has_part( native_part_id, body_part_filter::strict ) ) {
            return cata::lua_platform::make_game_error_result( lua_state, {
                "missing_part", "services.wounds.snapshot requires an exact character body part"
            } );
        }
        const bodypart *part = character->get_part( native_part_id );
        return cata::lua_platform::make_game_value_result(
                   lua_state, sol::make_object( lua_state,
                                                make_wound_snapshot( lua_state, *part ) ) );
    } );
    wounds.set_function( "add", [require_write, runtime_generation, world_generation,
                                                make_wound_snapshot, same_wounds]( sol::this_state state,
                                         const cata::lua_platform::game_handle & handle,
                                         const cata::lua_platform::script_game_id & body_part_id,
    const cata::lua_platform::script_game_id & wound_id ) {
        require_write();
        if( body_part_id.kind() != "body_part" || !body_part_id.is_valid() ) {
            throw std::invalid_argument(
                "services.wounds.add requires a valid GameId<body_part>" );
        }
        if( wound_id.kind() != "wound" || !wound_id.is_valid() ) {
            throw std::invalid_argument(
                "services.wounds.add requires a valid GameId<wound>" );
        }
        sol::state_view lua_state( state );
        const cata::lua_platform::native_handle_result<Creature> resolved =
            handle.resolve_creature( runtime_generation(), world_generation() );
        if( !resolved ) {
            return cata::lua_platform::make_game_error_result( lua_state, *resolved.error );
        }
        Character *character = dynamic_cast<Character *>( resolved.value );
        if( character == nullptr ) {
            return cata::lua_platform::make_game_error_result( lua_state, {
                "wrong_target", "services.wounds.add requires a character handle"
            } );
        }
        const bodypart_id native_part_id = bodypart_str_id( body_part_id.value() ).id();
        if( !character->has_part( native_part_id, body_part_filter::strict ) ) {
            return cata::lua_platform::make_game_error_result( lua_state, {
                "missing_part", "services.wounds.add requires an exact character body part"
            } );
        }
        bodypart *part = character->get_part( native_part_id );
        const std::vector<wound> before_native = part->get_wounds();
        sol::table before = make_wound_snapshot( lua_state, *part );
        const wound_type_id native_wound_id( wound_id.value() );
        const int limit = native_wound_id->get_limit();
        const std::size_t existing_count = std::count_if(
                                               before_native.begin(), before_native.end(),
        [&native_wound_id]( const wound & existing ) {
            return existing.type == native_wound_id;
        } );
        if( limit == 0 || existing_count < static_cast<std::size_t>( limit ) ) {
            character->apply_wound( native_part_id, native_wound_id );
        }
        sol::table after = make_wound_snapshot( lua_state, *part );
        sol::table value = lua_state.create_table();
        value["changed"] = !same_wounds( before_native, part->get_wounds() );
        value["before"] = std::move( before );
        value["after"] = std::move( after );
        return cata::lua_platform::make_game_value_result(
                   lua_state, sol::make_object( lua_state, std::move( value ) ) );
    } );
    wounds.set_function( "remove", [require_write, runtime_generation, world_generation,
                                                   make_wound_snapshot]( sol::this_state state,
                                            const cata::lua_platform::game_handle & handle,
                                            const cata::lua_platform::script_game_id & body_part_id,
    const cata::lua_platform::script_game_id & wound_id ) {
        require_write();
        if( body_part_id.kind() != "body_part" || !body_part_id.is_valid() ) {
            throw std::invalid_argument(
                "services.wounds.remove requires a valid GameId<body_part>" );
        }
        if( wound_id.kind() != "wound" || !wound_id.is_valid() ) {
            throw std::invalid_argument(
                "services.wounds.remove requires a valid GameId<wound>" );
        }
        sol::state_view lua_state( state );
        const cata::lua_platform::native_handle_result<Creature> resolved =
            handle.resolve_creature( runtime_generation(), world_generation() );
        if( !resolved ) {
            return cata::lua_platform::make_game_error_result( lua_state, *resolved.error );
        }
        Character *character = dynamic_cast<Character *>( resolved.value );
        if( character == nullptr ) {
            return cata::lua_platform::make_game_error_result( lua_state, {
                "wrong_target", "services.wounds.remove requires a character handle"
            } );
        }
        const bodypart_id native_part_id = bodypart_str_id( body_part_id.value() ).id();
        if( !character->has_part( native_part_id, body_part_filter::strict ) ) {
            return cata::lua_platform::make_game_error_result( lua_state, {
                "missing_part", "services.wounds.remove requires an exact character body part"
            } );
        }
        bodypart *part = character->get_part( native_part_id );
        sol::table before = make_wound_snapshot( lua_state, *part );
        const std::size_t count_before = part->get_wounds().size();
        part->remove_all_wounds_of_type( wound_type_id( wound_id.value() ) );
        sol::table after = make_wound_snapshot( lua_state, *part );
        sol::table value = lua_state.create_table();
        const bool changed = part->get_wounds().size() != count_before;
        if( changed ) {
            character->on_stat_change(
                "perceived_pain", character->get_perceived_pain() );
        }
        value["changed"] = changed;
        value["before"] = std::move( before );
        value["after"] = std::move( after );
        return cata::lua_platform::make_game_value_result(
                   lua_state, sol::make_object( lua_state, std::move( value ) ) );
    } );
    services["wounds"] = std::move( wounds );
    cata::lua_platform::install_mutation_api( services, runtime_generation, world_generation,
            require_read, require_write );
    cata::lua_platform::install_skill_api( services, runtime_generation, world_generation,
                                           require_read, require_write );
    cata::lua_platform::install_proficiency_api( services, runtime_generation, world_generation,
            require_read, require_write );
    cata::lua_platform::install_vitamin_api( services, runtime_generation, world_generation,
            require_read, require_write );
    cata::lua_platform::install_addiction_api( services, runtime_generation, world_generation,
            require_read, require_write );
    cata::lua_platform::install_need_api( services, runtime_generation, world_generation,
                                          require_read, require_write );
    cata::lua_platform::install_activity_api(
        services, runtime_generation, world_generation,
        require_read, require_write );
    sol::table morale = lua.create_table();
    morale.set_function( "add", [require_write, runtime_generation, world_generation](
                             sol::this_state state, const cata::lua_platform::game_handle & handle,
                             const cata::lua_platform::script_game_id & id, const std::int64_t bonus,
    const std::int64_t max_bonus, const sol::optional<sol::table> &options ) {
        require_write();
        if( id.kind() != "morale" || !id.is_valid() ) {
            throw std::invalid_argument(
                "services.morale.add requires a valid GameId<morale>" );
        }
        if( bonus < std::numeric_limits<int>::min() ||
            bonus > std::numeric_limits<int>::max() ||
            max_bonus < std::numeric_limits<int>::min() ||
            max_bonus > std::numeric_limits<int>::max() ) {
            throw std::invalid_argument(
                "services.morale.add bonus values exceed native integer bounds" );
        }
        time_duration duration = 1_hours;
        time_duration decay_start = 30_minutes;
        bool capped = false;
        if( options ) {
            for( const auto &entry : *options ) {
                const sol::object key_object = entry.first;
                if( key_object.get_type() != sol::type::string ) {
                    throw std::invalid_argument(
                        "services.morale.add option keys must be strings" );
                }
                const std::string key = key_object.as<std::string>();
                const sol::object value = entry.second;
                if( key == "duration" || key == "decay_start" ) {
                    if( !value.is<cata::lua_platform::script_time_duration>() ) {
                        throw std::invalid_argument(
                            "services.morale.add time options must be TimeDuration values" );
                    }
                    const time_duration native =
                        value.as<cata::lua_platform::script_time_duration>().to_native();
                    if( native < 0_turns ) {
                        throw std::invalid_argument(
                            "services.morale.add time options cannot be negative" );
                    }
                    if( key == "duration" ) {
                        duration = native;
                    } else {
                        decay_start = native;
                    }
                } else if( key == "capped" ) {
                    if( !value.is<bool>() ) {
                        throw std::invalid_argument(
                            "services.morale.add capped must be a boolean" );
                    }
                    capped = value.as<bool>();
                } else {
                    throw std::invalid_argument(
                        "services.morale.add received unknown option '" + key + "'" );
                }
            }
        }
        sol::state_view lua_state( state );
        const cata::lua_platform::native_handle_result<Creature> resolved =
            handle.resolve_creature( runtime_generation(), world_generation() );
        if( !resolved ) {
            return cata::lua_platform::make_game_error_result( lua_state, *resolved.error );
        }
        Character *character = dynamic_cast<Character *>( resolved.value );
        if( character == nullptr ) {
            return cata::lua_platform::make_game_error_result( lua_state, {
                "wrong_target", "services.morale.add requires a character handle"
            } );
        }
        const morale_type native_id( id.value() );
        const int before = character->has_morale( native_id );
        character->add_morale( native_id, static_cast<int>( bonus ),
                               static_cast<int>( max_bonus ), duration, decay_start, capped );
        const int after = character->has_morale( native_id );
        sol::table result = lua_state.create_table();
        result["changed"] = after != before;
        result["before"] = before;
        result["after"] = after;
        return cata::lua_platform::make_game_value_result(
                   lua_state, sol::make_object( lua_state, std::move( result ) ) );
    } );
    morale.set_function( "remove", [require_write, runtime_generation, world_generation](
                             sol::this_state state, const cata::lua_platform::game_handle & handle,
    const cata::lua_platform::script_game_id & id ) {
        require_write();
        if( id.kind() != "morale" || !id.is_valid() ) {
            throw std::invalid_argument(
                "services.morale.remove requires a valid GameId<morale>" );
        }
        sol::state_view lua_state( state );
        const cata::lua_platform::native_handle_result<Creature> resolved =
            handle.resolve_creature( runtime_generation(), world_generation() );
        if( !resolved ) {
            return cata::lua_platform::make_game_error_result( lua_state, *resolved.error );
        }
        Character *character = dynamic_cast<Character *>( resolved.value );
        if( character == nullptr ) {
            return cata::lua_platform::make_game_error_result( lua_state, {
                "wrong_target", "services.morale.remove requires a character handle"
            } );
        }
        const morale_type native_id( id.value() );
        const int before = character->has_morale( native_id );
        character->rem_morale( native_id );
        const int after = character->has_morale( native_id );
        sol::table result = lua_state.create_table();
        result["changed"] = after != before;
        result["before"] = before;
        result["after"] = after;
        return cata::lua_platform::make_game_value_result(
                   lua_state, sol::make_object( lua_state, std::move( result ) ) );
    } );
    services["morale"] = std::move( morale );
    cata::lua_platform::install_martial_art_api( services, runtime_generation, world_generation,
            require_read, require_write );
    sol::table martial_arts = services["martial_arts"];
    martial_arts.set_function( "learn", [require_write, runtime_generation, world_generation](
                                   sol::this_state state, const cata::lua_platform::game_handle & handle,
    const cata::lua_platform::script_game_id & id ) {
        require_write();
        if( id.kind() != "martial_art" || !id.is_valid() ) {
            throw std::invalid_argument(
                "services.martial_arts.learn requires a valid GameId<martial_art>" );
        }
        sol::state_view lua_state( state );
        const cata::lua_platform::native_handle_result<Creature> resolved =
            handle.resolve_creature( runtime_generation(), world_generation() );
        if( !resolved ) {
            return cata::lua_platform::make_game_error_result( lua_state, *resolved.error );
        }
        Character *character = dynamic_cast<Character *>( resolved.value );
        if( character == nullptr ) {
            return cata::lua_platform::make_game_error_result( lua_state, {
                "wrong_target", "services.martial_arts.learn requires a character handle"
            } );
        }
        const matype_id native_id( id.value() );
        const bool before = character->has_martialart( native_id );
        character->martial_arts_data->add_martialart( native_id );
        const bool known = character->has_martialart( native_id );
        sol::table value = lua_state.create_table();
        value["changed"] = known != before;
        value["known"] = known;
        return cata::lua_platform::make_game_value_result(
                   lua_state, sol::make_object( lua_state, std::move( value ) ) );
    } );
    martial_arts.set_function( "forget", [require_write, runtime_generation, world_generation](
                                   sol::this_state state, const cata::lua_platform::game_handle & handle,
    const cata::lua_platform::script_game_id & id ) {
        require_write();
        if( id.kind() != "martial_art" || !id.is_valid() ) {
            throw std::invalid_argument(
                "services.martial_arts.forget requires a valid GameId<martial_art>" );
        }
        sol::state_view lua_state( state );
        const cata::lua_platform::native_handle_result<Creature> resolved =
            handle.resolve_creature( runtime_generation(), world_generation() );
        if( !resolved ) {
            return cata::lua_platform::make_game_error_result( lua_state, *resolved.error );
        }
        Character *character = dynamic_cast<Character *>( resolved.value );
        if( character == nullptr ) {
            return cata::lua_platform::make_game_error_result( lua_state, {
                "wrong_target", "services.martial_arts.forget requires a character handle"
            } );
        }
        const matype_id native_id( id.value() );
        const bool before = character->has_martialart( native_id );
        character->martial_arts_data->clear_style( native_id );
        const bool known = character->has_martialart( native_id );
        sol::table value = lua_state.create_table();
        value["changed"] = known != before;
        value["known"] = known;
        return cata::lua_platform::make_game_value_result(
                   lua_state, sol::make_object( lua_state, std::move( value ) ) );
    } );
    services["martial_arts"] = std::move( martial_arts );
    cata::lua_platform::install_vehicle_api( services, runtime_generation, world_generation,
            require_read, require_write );
    cata::lua_platform::install_npc_api(
        services, runtime_generation, world_generation,
        require_read, require_write, runtime_npc_identity_changed );
    cata::lua_platform::install_trade_api( services, runtime_generation, world_generation,
                                           require_read, require_write );
    cata::lua_platform::install_magic_api( services, runtime_generation, world_generation,
                                           require_read, require_write );
    cata::lua_platform::install_mission_api( services, runtime_generation, world_generation,
            require_read, require_write );
    cata::lua_platform::install_horde_api( services, runtime_generation, world_generation,
                                           require_read, require_write );
    cata::lua_platform::install_world_api( services, runtime_generation, world_generation,
                                           require_read, require_write );
    cata::lua_platform::install_map_api( services, runtime_generation, world_generation,
                                         require_read, require_write );
    cata::lua_platform::install_item_api( services, runtime_generation, world_generation,
                                          require_read, require_write );
    sol::table inventory = services["inventory"];
    inventory.set_function( "wielded", [require_read, runtime_generation,
                                                      world_generation]( sol::this_state state,
    const cata::lua_platform::game_handle & handle ) {
        require_read();
        sol::state_view lua_state( state );
        std::optional<cata::lua_platform::game_handle_error> error;
        Character *character = cata::lua_platform::resolve_exact_character(
                                   handle, runtime_generation(),
                                   world_generation(), error );
        if( character == nullptr ) {
            return cata::lua_platform::make_game_error_result(
                       lua_state, *error );
        }
        item_location wielded = character->get_wielded_item();
        if( !wielded ) {
            return cata::lua_platform::make_game_value_result(
                       lua_state, sol::make_object( lua_state, sol::lua_nil ) );
        }
        const tripoint_abs_ms position = character->pos_abs();
        cata::lua_platform::game_handle_locator locator;
        locator.scope = "character_wielded";
        locator.stable_id = wielded->uid().get_value();
        locator.x = position.x();
        locator.y = position.y();
        locator.z = position.z();
        return cata::lua_platform::make_game_value_result(
                   lua_state, sol::make_object(
                       lua_state, cata::lua_platform::game_handle::from_item(
                           *wielded, std::move( locator ), runtime_generation(),
                           world_generation() ) ) );
    } );
    inventory.set_function( "is_wearing", [require_read, runtime_generation,
                                                         world_generation]( sol::this_state state,
                                                   const cata::lua_platform::game_handle & handle,
    const cata::lua_platform::script_game_id & id ) {
        require_read();
        if( id.kind() != "item" ) {
            throw std::invalid_argument(
                "services.inventory.is_wearing requires a GameId<item>" );
        }
        sol::state_view lua_state( state );
        std::optional<cata::lua_platform::game_handle_error> error;
        Character *character = cata::lua_platform::resolve_exact_character(
                                   handle, runtime_generation(),
                                   world_generation(), error );
        if( character == nullptr ) {
            return cata::lua_platform::make_game_error_result(
                       lua_state, *error );
        }
        const itype_id native_id( id.value() );
        return cata::lua_platform::make_game_value_result(
                   lua_state, sol::make_object(
                       lua_state, character->is_wearing( native_id ) ) );
    } );
    services["inventory"] = std::move( inventory );
    cata::lua_platform::install_zone_api( lua, services, runtime_generation, world_generation,
                                          require_read, require_write );
    cata::lua_platform::install_achievement_api( services, require_read, require_write );
    sol::table achievements = services["achievements"];
    achievements.set_function( "complete", [require_write](
    sol::this_state state, const cata::lua_platform::script_game_id & id ) {
        require_write();
        if( id.kind() != "achievement" || !id.is_valid() ) {
            throw std::invalid_argument(
                "services.achievements.complete requires a valid GameId<achievement>" );
        }
        const achievement_id native_id( id.value() );
        achievements_tracker &tracker = get_achievements();
        const std::vector<const achievement *> valid = tracker.valid_achievements();
        const auto found = std::find_if( valid.begin(), valid.end(), [&native_id](
        const achievement * entry ) {
            return entry != nullptr && entry->id == native_id;
        } );
        bool changed = false;
        if( found != valid.end() &&
            tracker.is_completed( native_id ) == achievement_completion::pending ) {
            tracker.report_achievement( *found, achievement_completion::completed );
            changed = true;
        }
        sol::state_view lua_state( state );
        return cata::lua_platform::make_game_value_result(
                   lua_state, sol::make_object( lua_state, changed ) );
    } );
    services["achievements"] = std::move( achievements );
    cata::lua_platform::install_statistics_api( services, require_read );
    cata::lua_platform::install_faction_api(
        services, runtime_generation, world_generation,
        require_read, require_write );
    cata::lua_platform::install_camp_api(
        services, runtime_generation, world_generation,
        require_read, require_write );
    cata::lua_platform::install_weather_api( services, require_read, require_write );
    cata::lua_platform::install_crafting_api(
        services, runtime_generation, world_generation,
        require_read, require_write );
    sol::table recipes = services["recipes"];
    recipes.set_function( "knows", [require_read, runtime_generation, world_generation](
                              sol::this_state state, const cata::lua_platform::game_handle & handle,
    const cata::lua_platform::script_game_id & id ) {
        require_read();
        if( id.kind() != "recipe" || !id.is_valid() ) {
            throw std::invalid_argument(
                "services.recipes.knows requires a valid GameId<recipe>" );
        }
        sol::state_view lua_state( state );
        std::optional<cata::lua_platform::game_handle_error> error;
        Character *character = cata::lua_platform::resolve_exact_character(
                                   handle, runtime_generation(),
                                   world_generation(), error );
        if( character == nullptr ) {
            return cata::lua_platform::make_game_error_result(
                       lua_state, *error );
        }
        const bool known = character->knows_recipe( &recipe_id( id.value() ).obj() );
        return cata::lua_platform::make_game_value_result(
                   lua_state, sol::make_object( lua_state, known ) );
    } );
    recipes.set_function( "learn", [require_write, runtime_generation, world_generation](
                              sol::this_state state, const cata::lua_platform::game_handle & handle,
    const cata::lua_platform::script_game_id & id ) {
        require_write();
        if( id.kind() != "recipe" || !id.is_valid() ) {
            throw std::invalid_argument(
                "services.recipes.learn requires a valid GameId<recipe>" );
        }
        sol::state_view lua_state( state );
        std::optional<cata::lua_platform::game_handle_error> error;
        Character *character = cata::lua_platform::resolve_exact_character(
                                   handle, runtime_generation(),
                                   world_generation(), error );
        if( character == nullptr ) {
            return cata::lua_platform::make_game_error_result(
                       lua_state, *error );
        }
        const recipe *target = &recipe_id( id.value() ).obj();
        const bool before = character->knows_recipe( target );
        character->learn_recipe( target );
        const bool known = character->knows_recipe( target );
        sol::table value = lua_state.create_table();
        value["changed"] = known != before;
        value["known"] = known;
        return cata::lua_platform::make_game_value_result(
                   lua_state, sol::make_object( lua_state, std::move( value ) ) );
    } );
    recipes.set_function( "forget", [require_write, runtime_generation, world_generation](
                              sol::this_state state, const cata::lua_platform::game_handle & handle,
    const cata::lua_platform::script_game_id & id ) {
        require_write();
        if( id.kind() != "recipe" || !id.is_valid() ) {
            throw std::invalid_argument(
                "services.recipes.forget requires a valid GameId<recipe>" );
        }
        sol::state_view lua_state( state );
        std::optional<cata::lua_platform::game_handle_error> error;
        Character *character = cata::lua_platform::resolve_exact_character(
                                   handle, runtime_generation(),
                                   world_generation(), error );
        if( character == nullptr ) {
            return cata::lua_platform::make_game_error_result(
                       lua_state, *error );
        }
        const recipe *target = &recipe_id( id.value() ).obj();
        const bool before = character->knows_recipe( target );
        character->forget_recipe( target );
        const bool known = character->knows_recipe( target );
        sol::table value = lua_state.create_table();
        value["changed"] = known != before;
        value["known"] = known;
        return cata::lua_platform::make_game_value_result(
                   lua_state, sol::make_object( lua_state, std::move( value ) ) );
    } );
    recipes.set_function( "forget_category", [require_write, runtime_generation,
                                         world_generation]( sol::this_state state,
                                  const cata::lua_platform::game_handle & handle,
                                  const cata::lua_platform::script_game_id & category,
    const sol::optional<std::string> &subcategory ) {
        require_write();
        if( category.kind() != "crafting_category" || !category.is_valid() ) {
            throw std::invalid_argument(
                "services.recipes.forget_category requires a valid "
                "GameId<crafting_category>" );
        }
        const std::string native_subcategory = subcategory.value_or( std::string() );
        if( native_subcategory.size() > 256 ||
            native_subcategory.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                "services.recipes.forget_category subcategory exceeds its native limit" );
        }
        sol::state_view lua_state( state );
        std::optional<cata::lua_platform::game_handle_error> error;
        Character *character = cata::lua_platform::resolve_exact_character(
                                   handle, runtime_generation(),
                                   world_generation(), error );
        if( character == nullptr ) {
            return cata::lua_platform::make_game_error_result(
                       lua_state, *error );
        }
        const recipe_subset &known_recipes = character->get_learned_recipes();
        const std::size_t known_before = known_recipes.size();
        const std::vector<const recipe *> recipes_to_forget =
            recipes_from_cat( known_recipes, crafting_category_id( category.value() ),
                              native_subcategory ).first;
        for( const recipe *entry : recipes_to_forget ) {
            character->forget_recipe( entry );
        }
        const std::size_t known_after = character->get_learned_recipes().size();
        const std::size_t forgotten_count = known_before > known_after ?
                                            known_before - known_after : 0;
        sol::table value = lua_state.create_table();
        value["changed"] = forgotten_count > 0;
        value["forgotten_count"] = forgotten_count;
        value["known_before"] = known_before;
        value["known_after"] = known_after;
        value["category"] = cata::lua_platform::script_game_id(
                                "crafting_category", category.value() );
        if( subcategory ) {
            value["subcategory"] = *subcategory;
        } else {
            value["subcategory"] = sol::nil;
        }
        return cata::lua_platform::make_game_value_result(
                   lua_state, sol::make_object( lua_state, std::move( value ) ) );
    } );
    services["recipes"] = std::move( recipes );
    cata::lua_platform::install_overmap_api( services, runtime_generation, world_generation,
            require_read, require_write, random_index );
    cata::lua_platform::install_snapshot_api(
        services, runtime_generation, world_generation, require_read );
    cata::lua_platform::install_world_info_api( services, require_read, require_write,
            has_callback );

    const auto require_snippet_key = []( const std::string & value,
    const std::string_view api_name ) {
        if( value.empty() || value.size() > 512 ||
            value.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                std::string( api_name ) +
                " requires 1 to 512 non-NUL bytes" );
        }
    };
    const auto next_snippet_seed = [weak]() {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner || !owner->world_is_ready || owner->callback_depth <= 0 ) {
            throw std::runtime_error(
                "Platform snippet randomness is only available inside a runtime callback" );
        }
        return static_cast<unsigned int>( owner->random_engine() );
    };
    const auto snippet_record = []( sol::state_view state,
    const snippet_id & id ) {
        sol::table record = state.create_table();
        record["id"] = id.str();
        const std::optional<translation> text =
            SNIPPET.get_snippet_by_id( id );
        record["text"] = text ? text->translated() : std::string();
        const std::optional<translation> name =
            SNIPPET.get_name_by_id( id );
        if( name ) {
            record["name"] = name->translated();
        } else {
            record["name"] = sol::nil;
        }
        return record;
    };

    sol::table snippets = lua.create_table();
    snippets.set_function( "has_category", [require_read, require_snippet_key](
    const std::string & category ) {
        require_read();
        require_snippet_key( category, "services.snippets.has_category" );
        return SNIPPET.has_category( category );
    } );
    snippets.set_function( "has", [require_read, require_snippet_key](
    const std::string & id ) {
        require_read();
        require_snippet_key( id, "services.snippets.has" );
        return SNIPPET.has_snippet_with_id( snippet_id( id ) );
    } );
    snippets.set_function( "get", [require_read, require_snippet_key,
                                                 snippet_record](
    sol::this_state state, const std::string & id ) {
        require_read();
        require_snippet_key( id, "services.snippets.get" );
        sol::state_view lua_state( state );
        const snippet_id native_id( id );
        if( !SNIPPET.has_snippet_with_id( native_id ) ) {
            return sol::make_object( lua_state, sol::lua_nil );
        }
        return sol::make_object(
                   lua_state, snippet_record( lua_state, native_id ) );
    } );
    snippets.set_function( "expand", [require_read, next_snippet_seed](
    const std::string & text ) {
        require_read();
        if( text.size() > maximum_presentation_text_bytes ||
            text.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                "services.snippets.expand text exceeds its native string limit" );
        }
        return SNIPPET.expand( text, next_snippet_seed() );
    } );
    snippets.set_function( "random", [require_read, require_snippet_key,
                                                    next_snippet_seed](
    sol::this_state state, const std::string & category ) {
        require_read();
        require_snippet_key( category, "services.snippets.random" );
        sol::state_view lua_state( state );
        const std::optional<translation> selected =
            SNIPPET.random_from_category(
                category, next_snippet_seed() );
        if( !selected ) {
            return sol::make_object( lua_state, sol::lua_nil );
        }
        return sol::make_object(
                   lua_state, SNIPPET.expand(
                       selected->translated(), next_snippet_seed() ) );
    } );
    snippets.set_function( "random_named", [require_read, require_snippet_key,
                                                          next_snippet_seed, snippet_record](
    sol::this_state state, const std::string & category ) {
        require_read();
        require_snippet_key( category, "services.snippets.random_named" );
        sol::state_view lua_state( state );
        const snippet_id selected = SNIPPET.random_id_from_category(
                                        category, next_snippet_seed() );
        if( selected.is_null() ) {
            return sol::make_object( lua_state, sol::lua_nil );
        }
        return sol::make_object(
                   lua_state, snippet_record( lua_state, selected ) );
    } );
    services["snippets"] = std::move( snippets );

    sol::table text_services = lua.create_table();
    text_services.set_function( "expand_for", [require_read, next_snippet_seed,
                                              runtime_generation, world_generation](
                                    sol::this_state state, const std::string & text,
                                    const cata::lua_platform::game_handle & speaker_handle,
                                    const sol::optional<cata::lua_platform::game_handle> &interlocutor_handle,
    const sol::optional<std::string> &item_id ) {
        require_read();
        if( text.size() > maximum_presentation_text_bytes ||
            text.find( '\0' ) != std::string::npos ||
            ( item_id && ( item_id->size() > 256 ||
                           item_id->find( '\0' ) != std::string::npos ) ) ) {
            throw std::invalid_argument(
                "services.text.expand_for input exceeds its native string limit" );
        }
        sol::state_view lua_state( state );
        const cata::lua_platform::native_handle_result<Creature> speaker =
            speaker_handle.resolve_creature(
                runtime_generation(), world_generation() );
        if( !speaker ) {
            return cata::lua_platform::make_game_error_result(
                       lua_state, *speaker.error );
        }
        const Creature *interlocutor = nullptr;
        if( interlocutor_handle ) {
            const cata::lua_platform::native_handle_result<Creature> resolved =
                interlocutor_handle->resolve_creature(
                    runtime_generation(), world_generation() );
            if( !resolved ) {
                return cata::lua_platform::make_game_error_result(
                           lua_state, *resolved.error );
            }
            interlocutor = resolved.value;
        }
        const_dialogue dialogue_context(
            get_const_talker_for( *speaker.value ),
            interlocutor == nullptr ? nullptr : get_const_talker_for( *interlocutor ) );
        const_talker empty_interlocutor;
        std::string expanded = SNIPPET.expand(
                                   text, next_snippet_seed() );
        parse_tags(
            expanded, *dialogue_context.const_actor( false ),
            dialogue_context.has_beta ?
            *dialogue_context.const_actor( true ) : empty_interlocutor,
            dialogue_context,
            item_id && !item_id->empty() ?
            itype_id( *item_id ) : itype_id::NULL_ID() );
        return cata::lua_platform::make_game_value_result(
                   lua_state, sol::make_object(
                       lua_state, std::move( expanded ) ) );
    } );
    services["text"] = std::move( text_services );

    sol::table lore = lua.create_table();
    lore.set_function( "knows_snippet", [require_read, require_snippet_key](
    const std::string & id ) {
        require_read();
        require_snippet_key( id, "services.lore.knows_snippet" );
        return get_avatar().has_seen_snippet( snippet_id( id ) );
    } );
    lore.set_function( "remember_snippet", [require_write, require_snippet_key](
    const std::string & id ) {
        require_write();
        require_snippet_key( id, "services.lore.remember_snippet" );
        const snippet_id native_id( id );
        if( !SNIPPET.has_snippet_with_id( native_id ) ) {
            throw std::invalid_argument(
                "services.lore.remember_snippet requires an existing identified snippet" );
        }
        avatar &player = get_avatar();
        const bool known = player.has_seen_snippet( native_id );
        player.add_snippet( native_id );
        return !known;
    } );
    lore.set_function( "known_snippets", [require_read]( sol::this_state state ) {
        require_read();
        sol::state_view lua_state( state );
        const std::set<snippet_id> &known = get_avatar().get_snippets();
        sol::table result = lua_state.create_table(
                                static_cast<int>( known.size() ), 0 );
        std::size_t index = 0;
        for( const snippet_id &id : known ) {
            result[++index] = id.str();
        }
        return result;
    } );
    services["lore"] = std::move( lore );

    const auto platform_message_type = []( const std::string & name ) {
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
            "services.messages received unknown message type '" + name + "'" );
    };
    const auto add_audible_message = [weak, require_write,
                                            platform_message_type]( const std::string & message,
                                              const sol::optional<std::string> &type,
    const bool from_outdoors ) {
        require_write();
        if( message.size() > 8192 ||
            message.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                "services.messages audible message exceeds its native string limit" );
        }
        avatar &player = get_avatar();
        static const efftype_id effect_sleep( "sleep" );
        if( player.has_effect( effect_sleep ) || player.is_deaf() ) {
            return false;
        }
        if( from_outdoors ) {
            const int depth = std::max( 0, -get_map().get_abs_sub().z() );
            if( depth > 0 ) {
                const double hearing = std::max(
                                           0.01, static_cast<double>( player.hearing_ability() ) );
                const int denominator = std::max(
                                            1, static_cast<int>( std::ceil(
                                                        2.0 * depth / hearing ) ) );
                const std::shared_ptr<runtime> owner = weak.lock();
                if( !owner ) {
                    throw std::runtime_error( "stale Platform runtime" );
                }
                std::uniform_int_distribution<int> distribution( 1, denominator );
                if( distribution( owner->random_engine ) != 1 ) {
                    return false;
                }
            }
        }
        player.add_msg_if_player(
            game_message_params( platform_message_type(
                                     type.value_or( "neutral" ) ) ), message );
        return true;
    };
    sol::table platform_messages = services["messages"];
    platform_messages.set_function( "add", [weak, platform_message_type](
    const std::string & message, const sol::optional<std::string> &type ) {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner || !owner->world_is_ready ) {
            throw std::runtime_error(
                "services.messages.add is only available after world_ready" );
        }
        if( message.size() > 8192 || message.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                "services.messages.add message exceeds its native string limit" );
        }
        ::add_msg(
            game_message_params( platform_message_type(
                                     type.value_or( "neutral" ) ) ), message );
        return true;
    } );
    platform_messages.set_function( "add_if_audible", [add_audible_message](
    const std::string & message, const sol::optional<std::string> &type ) {
        return add_audible_message( message, type, false );
    } );
    platform_messages.set_function( "add_from_outdoors", [add_audible_message](
    const std::string & message, const sol::optional<std::string> &type ) {
        return add_audible_message( message, type, true );
    } );
    services["messages"] = std::move( platform_messages );

    // Platform owns an isolated gameplay random stream backed by the runtime's
    // deterministic generator.
    sol::table random = services["random"];
    const auto require_random_runtime = [weak]() {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner || !owner->world_is_ready || owner->callback_depth <= 0 ) {
            throw std::runtime_error(
                "Platform gameplay randomness is only available inside a runtime callback" );
        }
        return owner;
    };
    const auto random_integer = [require_random_runtime]( const std::int64_t minimum,
    const std::int64_t maximum ) {
        if( minimum < -1000000000LL || maximum > 1000000000LL || minimum > maximum ) {
            throw std::invalid_argument(
                "services.random.int requires an ordered range within -1000000000..1000000000" );
        }
        const std::shared_ptr<runtime> owner = require_random_runtime();
        std::uniform_int_distribution<std::int64_t> distribution( minimum, maximum );
        return distribution( owner->random_engine );
    };
    random.set_function( "int", random_integer );
    random.set_function( "chance", [require_random_runtime]( const std::int64_t numerator,
    const std::int64_t denominator ) {
        const std::shared_ptr<runtime> owner = require_random_runtime();
        if( denominator <= 0 || denominator > 1000000000LL || numerator < 0 ||
            numerator > denominator ) {
            throw std::invalid_argument(
                "services.random.chance requires 0 <= numerator <= denominator <= 1000000000" );
        }
        if( numerator == 0 ) {
            return false;
        }
        if( numerator == denominator ) {
            return true;
        }
        std::uniform_int_distribution<std::int64_t> distribution( 1, denominator );
        return distribution( owner->random_engine ) <= numerator;
    } );
    random.set_function( "one_in", [require_random_runtime]( const double raw_denominator ) {
        const std::shared_ptr<runtime> owner = require_random_runtime();
        if( !std::isfinite( raw_denominator ) || raw_denominator < -1000000000.0 ||
            raw_denominator > 1000000000.0 ) {
            throw std::invalid_argument(
                "services.random.one_in requires a finite denominator within native bounds" );
        }
        const std::int64_t denominator = static_cast<std::int64_t>( raw_denominator );
        if( denominator <= 1 ) {
            return true;
        }
        std::uniform_int_distribution<std::int64_t> distribution( 0, denominator - 1 );
        return distribution( owner->random_engine ) == 0;
    } );
    random.set_function( "probability", [require_random_runtime]( const double numerator,
    const double denominator ) {
        const std::shared_ptr<runtime> owner = require_random_runtime();
        if( !std::isfinite( numerator ) || !std::isfinite( denominator ) ||
            denominator <= 0.0 || numerator < 0.0 || numerator > denominator ) {
            throw std::invalid_argument(
                "services.random.probability requires finite 0 <= numerator <= denominator" );
        }
        if( numerator == 0.0 ) {
            return false;
        }
        if( numerator == denominator ) {
            return true;
        }
        std::uniform_real_distribution<double> distribution( 0.0, 1.0 );
        return distribution( owner->random_engine ) <= numerator / denominator;
    } );
    random.set_function( "sample_integers", [require_random_runtime](
                             sol::this_state state, const std::int64_t minimum, const std::int64_t maximum,
    const std::int64_t requested_count, const sol::optional<bool> &with_replacement ) {
        if( minimum < -1000000000LL || maximum > 1000000000LL || minimum > maximum ||
            requested_count < 0 || requested_count > 1024 ) {
            throw std::invalid_argument(
                "services.random.sample_integers requires an ordered bounded range and 0..1024 samples" );
        }
        const bool replace = with_replacement.value_or( false );
        const std::uint64_t population = static_cast<std::uint64_t>( maximum - minimum ) + 1;
        if( !replace && static_cast<std::uint64_t>( requested_count ) > population ) {
            throw std::invalid_argument(
                "services.random.sample_integers cannot exceed the range without replacement" );
        }
        const std::shared_ptr<runtime> owner = require_random_runtime();
        std::uniform_int_distribution<std::int64_t> distribution( minimum, maximum );
        sol::state_view lua_state( state );
        sol::table result = lua_state.create_table( requested_count, 0 );
        std::unordered_set<std::int64_t> selected;
        for( std::int64_t index = 1; index <= requested_count; ++index ) {
            std::int64_t value = distribution( owner->random_engine );
            if( !replace ) {
                while( !selected.insert( value ).second ) {
                    value = distribution( owner->random_engine );
                }
            }
            result[index] = value;
        }
        return result;
    } );
    random.set_function( "contested", [random_integer]( const double check,
    const double difficulty, const sol::optional<std::int64_t> &optional_die_size ) {
        const std::int64_t die_size = optional_die_size.value_or( 10 );
        if( !std::isfinite( check ) || !std::isfinite( difficulty ) ||
            die_size <= 0 || die_size > 1000000000LL ) {
            throw std::invalid_argument(
                "services.random.contested requires finite values and a die size within 1..1000000000" );
        }
        return static_cast<double>( random_integer( 1, die_size ) ) + check > difficulty;
    } );
    services["random"] = std::move( random );

    sol::table gameplay = lua.create_table();
    const auto make_math_dialogue = [runtime_generation, world_generation](
                                        const sol::optional<cata::lua_platform::game_handle> &requested_actor,
    const sol::optional<sol::table> &requested_context ) {
        std::unique_ptr<talker> alpha;
        if( requested_actor ) {
            const cata::lua_platform::native_handle_result<Creature> resolved =
                requested_actor->resolve_creature(
                    runtime_generation(), world_generation() );
            if( !resolved ) {
                throw std::invalid_argument( resolved.error->message );
            }
            alpha = get_talker_for( *resolved.value );
        } else {
            alpha = get_talker_for( get_avatar() );
        }
        auto result = std::make_unique<::dialogue>( std::move( alpha ), nullptr );
        if( requested_context ) {
            for( const auto &entry : *requested_context ) {
                if( !entry.first.is<std::string>() ) {
                    throw std::invalid_argument(
                        "services.gameplay.math context keys must be strings" );
                }
                const std::string key = entry.first.as<std::string>();
                if( key.empty() || key.size() > 128 ||
                std::any_of( key.begin(), key.end(), []( const unsigned char ch ) {
                return ch == '\0' || ch < 0x20U || ch == 0x7fU;
            } ) ) {
                    throw std::invalid_argument(
                        "services.gameplay.math context keys must be printable and bounded" );
                }
                const sol::object value = entry.second;
                if( value.is<bool>() ) {
                    result->set_value( key, value.as<bool>() ? 1.0 : 0.0 );
                } else if( value.get_type() == sol::type::number ) {
                    const double number = value.as<double>();
                    if( !std::isfinite( number ) ) {
                        throw std::invalid_argument(
                            "services.gameplay.math context numbers must be finite" );
                    }
                    result->set_value( key, number );
                } else if( value.is<std::string>() ) {
                    result->set_value( key, value.as<std::string>() );
                } else if( value.is<cata::lua_platform::script_tripoint_coord>() ) {
                    const cata::lua_platform::script_tripoint_coord position =
                        value.as<cata::lua_platform::script_tripoint_coord>();
                    if( position.native_origin() != coords::origin::abs ||
                        position.native_scale() != coords::scale::map_square ) {
                        throw std::invalid_argument(
                            "services.gameplay.math context coordinates must be absolute map-square" );
                    }
                    result->set_value( key, tripoint_abs_ms( position.to_native() ) );
                } else {
                    throw std::invalid_argument(
                        "services.gameplay.math context values must be scalar or Tripoint" );
                }
            }
        }
        return result;
    };
    sol::table math = lua.create_table();
    math.set_function( "evaluate", [require_read, make_math_dialogue](
                           sol::this_state state, const std::string & source,
                           const sol::optional<cata::lua_platform::game_handle> &actor,
    const sol::optional<sol::table> &context ) {
        require_read();
        if( source.empty() || source.size() > 8192 || source.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                "services.gameplay.math.evaluate expression must be 1..8192 bytes" );
        }
        math_exp expression;
        if( !expression.parse( source, true ) ) {
            throw std::invalid_argument(
                "services.gameplay.math.evaluate could not parse expression" );
        }
        std::unique_ptr<::dialogue> conversation = make_math_dialogue( actor, context );
        const double result = expression.eval( *conversation );
        if( !std::isfinite( result ) ) {
            throw std::runtime_error(
                "services.gameplay.math.evaluate produced a non-finite result" );
        }
        sol::state_view lua_state( state );
        return cata::lua_platform::make_game_value_result(
                   lua_state, sol::make_object( lua_state, result ) );
    } );
    math.set_function( "apply", [require_write, make_math_dialogue](
                           sol::this_state state, const std::string & source,
                           const sol::optional<cata::lua_platform::game_handle> &actor,
    const sol::optional<sol::table> &context ) {
        require_write();
        if( source.empty() || source.size() > 8192 || source.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                "services.gameplay.math.apply expression must be 1..8192 bytes" );
        }
        math_exp expression;
        if( !expression.parse( source, true ) ) {
            throw std::invalid_argument(
                "services.gameplay.math.apply could not parse expression" );
        }
        std::unique_ptr<::dialogue> conversation = make_math_dialogue( actor, context );
        const double result = expression.eval( *conversation );
        if( !std::isfinite( result ) ) {
            throw std::runtime_error(
                "services.gameplay.math.apply produced a non-finite result" );
        }
        sol::state_view lua_state( state );
        return cata::lua_platform::make_game_value_result(
                   lua_state, sol::make_object( lua_state, result ) );
    } );
    gameplay["math"] = std::move( math );
    sol::table strings = lua.create_table();
    strings.set_function( "any_equal", []( const sol::table & values ) {
        const std::size_t count = require_dense_array(
                                      values, "services.gameplay.strings.any_equal values", 2, 1024 );
        std::unordered_set<std::string> seen;
        for( std::size_t index = 1; index <= count; ++index ) {
            const sol::object value = values[index];
            if( !value.is<std::string>() ) {
                throw std::invalid_argument(
                    "services.gameplay.strings.any_equal accepts only strings" );
            }
            if( !seen.insert( value.as<std::string>() ).second ) {
                return true;
            }
        }
        return false;
    } );
    strings.set_function( "all_equal", []( const sol::table & values ) {
        const std::size_t count = require_dense_array(
                                      values, "services.gameplay.strings.all_equal values", 1, 1024 );
        const sol::object first = values[1];
        if( !first.is<std::string>() ) {
            throw std::invalid_argument(
                "services.gameplay.strings.all_equal accepts only strings" );
        }
        const std::string expected = first.as<std::string>();
        for( std::size_t index = 2; index <= count; ++index ) {
            const sol::object value = values[index];
            if( !value.is<std::string>() ) {
                throw std::invalid_argument(
                    "services.gameplay.strings.all_equal accepts only strings" );
            }
            if( value.as<std::string>() != expected ) {
                return false;
            }
        }
        return true;
    } );
    gameplay["strings"] = std::move( strings );

    sol::table mods = lua.create_table();
    mods.set_function( "is_loaded", [require_read]( const std::string & id ) {
        require_read();
        if( id.empty() || id.size() > 256 || id.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                "services.gameplay.mods.is_loaded requires a bounded non-empty Mod id" );
        }
        if( find_active_runtime( id ) ) {
            return true;
        }
        if( !world_generator || world_generator->active_world == nullptr ) {
            return false;
        }
        const mod_id requested( id );
        const std::vector<mod_id> &order = world_generator->active_world->active_mod_order;
        return std::find( order.begin(), order.end(), requested ) != order.end();
    } );
    mods.set_function( "load_order", [require_read]( const std::string & id ) {
        require_read();
        if( id.empty() || id.size() > 256 || id.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                "services.gameplay.mods.load_order requires a bounded non-empty Mod id" );
        }
        if( !world_generator || world_generator->active_world == nullptr ) {
            return -1;
        }
        const mod_id requested( id );
        const std::vector<mod_id> &order =
            world_generator->active_world->active_mod_order;
        const auto found = std::find(
                               order.begin(), order.end(), requested );
        return found == order.end() ? -1 :
               static_cast<int>( std::distance( order.begin(), found ) );
    } );
    gameplay["mods"] = std::move( mods );

    const auto require_option_id = []( const std::string & id ) {
        if( id.empty() || id.size() > 256 ||
            !std::all_of(
                id.begin(), id.end(),
        []( const unsigned char ch ) {
        return ch >= 0x20U && ch != 0x7fU;
    } ) ) {
            throw std::invalid_argument(
                "services.gameplay.options requires a 1..256 byte "
                "non-control option id" );
        }
    };
    const auto option_snapshot = []( sol::state_view state,
    const std::string & id ) {
        options_manager::cOpt &entry =
            get_options().get_option( id );
        sol::table value = state.create_table();
        value["id"] = id;
        value["type"] = entry.getType();
        value["value"] = entry.getValue();
        value["display_value"] = entry.getValueName();
        value["default_value"] = entry.getDefaultText( false );
        value["name"] = entry.getMenuText();
        value["description"] = entry.getTooltip();
        value["page"] = entry.getPage();
        value["hidden"] = entry.is_hidden();
        value["prerequisite_satisfied"] =
            entry.checkPrerequisite();
        return value;
    };
    sol::table gameplay_options = lua.create_table();
    gameplay_options.set_function(
    "has", [require_read, require_option_id]( const std::string & id ) {
        require_read();
        require_option_id( id );
        return get_options().has_option( id );
    } );
    gameplay_options.set_function(
        "get", [require_read, require_option_id, option_snapshot](
    sol::this_state lua_state, const std::string & id ) {
        require_read();
        require_option_id( id );
        sol::state_view state( lua_state );
        if( !get_options().has_option( id ) ) {
            return sol::make_object( state, sol::lua_nil );
        }
        return sol::make_object(
                   state, option_snapshot( state, id ) );
    } );
    gameplay_options.set_function(
        "value", [require_read, require_option_id](
    sol::this_state lua_state, const std::string & id ) {
        require_read();
        require_option_id( id );
        sol::state_view state( lua_state );
        if( !get_options().has_option( id ) ) {
            return sol::make_object( state, sol::lua_nil );
        }
        return sol::make_object(
                   state, get_options().get_option( id ).getValue() );
    } );
    gameplay["options"] = std::move( gameplay_options );

    sol::table environment = lua.create_table();
    environment.set_function( "dimension", [require_read]() {
        require_read();
        if( g == nullptr ) {
            throw std::runtime_error(
                "services.gameplay.environment.dimension requires an active game" );
        }
        return g->get_dimension_prefix().str();
    } );
    environment.set_function(
        "clear_saved_dimension",
        [require_write]( sol::this_state lua_state,
    const std::string & dimension ) {
        require_write();
        if( g == nullptr ) {
            throw std::runtime_error(
                "services.gameplay.environment.clear_saved_dimension requires an active game" );
        }
        if( dimension.empty() || dimension.size() > 128 ||
            !std::all_of(
                dimension.begin(), dimension.end(),
        []( const unsigned char ch ) {
        return std::isalnum( ch ) || ch == '_' || ch == '-';
        } ) ) {
            throw std::invalid_argument(
                "services.gameplay.environment.clear_saved_dimension requires a safe 1..128 byte dimension id" );
        }
        if( dimension == g->get_dimension_prefix().str() ) {
            throw std::invalid_argument(
                "services.gameplay.environment.clear_saved_dimension cannot clear the active dimension" );
        }
        const cata_path target =
            PATH_INFO::dimensions_save_path() / dimension;
        const std::filesystem::path native_target =
            target.get_unrelative_path();
        const bool existed =
            std::filesystem::is_directory( native_target );
        std::uintmax_t removed = 0;
        if( existed ) {
            removed = std::filesystem::remove_all(
                          native_target );
        }
        sol::state_view state( lua_state );
        sol::table value = state.create_table();
        value["dimension"] = dimension;
        value["existed"] = existed;
        value["removed_entries"] = removed;
        value["removed"] = removed > 0;
        return cata::lua_platform::make_game_value_result(
                   state, sol::make_object(
                       state, std::move( value ) ) );
    } );
    environment.set_function( "is_night", [require_read]() {
        require_read();
        return ::is_night( calendar::turn );
    } );
    const auto require_environment_position = []( const cata::lua_platform::script_tripoint_coord &
    position, const std::string & api_name ) {
        if( position.native_origin() != coords::origin::abs ||
            position.native_scale() != coords::scale::map_square ) {
            throw std::invalid_argument(
                api_name + " requires an absolute map-square Tripoint" );
        }
        map &here = get_map();
        const tripoint_abs_ms absolute( position.to_native() );
        if( !here.inbounds( absolute ) ) {
            throw std::invalid_argument( api_name + " position is outside the active map" );
        }
        return here.get_bub( absolute );
    };
    environment.set_function( "is_outside", [require_read, require_environment_position](
    const cata::lua_platform::script_tripoint_coord & position ) {
        require_read();
        map &here = get_map();
        return here.is_outside( require_environment_position(
                                    position, "services.gameplay.environment.is_outside" ) );
    } );
    environment.set_function( "line_of_sight", [require_read, require_environment_position](
                                  const cata::lua_platform::script_tripoint_coord & from,
                                  const cata::lua_platform::script_tripoint_coord & to, const std::int64_t range,
    const sol::optional<bool> &with_fields ) {
        require_read();
        if( range < 0 || range > 100000 ) {
            throw std::invalid_argument(
                "services.gameplay.environment.line_of_sight range must be within 0..100000" );
        }
        map &here = get_map();
        const tripoint_bub_ms first = require_environment_position(
                                          from, "services.gameplay.environment.line_of_sight" );
        const tripoint_bub_ms second = require_environment_position(
                                           to, "services.gameplay.environment.line_of_sight" );
        return here.sees( first, second, static_cast<int>( range ),
                          with_fields.value_or( true ) );
    } );
    environment.set_function( "furniture_has_flag", [require_read](
    const cata::lua_platform::script_tripoint_coord & position, const std::string & flag ) {
        require_read();
        if( flag.empty() || flag.size() > 256 || flag.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                "services.gameplay.environment.furniture_has_flag requires a bounded non-empty furniture flag" );
        }
        if( position.native_origin() != coords::origin::abs ||
            position.native_scale() != coords::scale::map_square ) {
            throw std::invalid_argument(
                "services.gameplay.environment.furniture_has_flag requires an absolute map-square Tripoint" );
        }
        map &here = get_map();
        const tripoint_abs_ms absolute( position.to_native() );
        if( !here.inbounds( absolute ) ) {
            return false;
        }
        return here.furn( here.get_bub( absolute ) )->has_flag( flag );
    } );
    environment.set_function( "terrain_id", [require_read](
    const cata::lua_platform::script_tripoint_coord & position ) {
        require_read();
        if( position.native_origin() != coords::origin::abs ||
            position.native_scale() != coords::scale::map_square ) {
            throw std::invalid_argument(
                "services.gameplay.environment.terrain_id requires an absolute map-square Tripoint" );
        }
        map &here = get_map();
        const tripoint_abs_ms absolute( position.to_native() );
        return here.ter( here.get_bub( absolute ) ).id().str();
    } );
    environment.set_function( "furniture_id", [require_read](
    const cata::lua_platform::script_tripoint_coord & position ) {
        require_read();
        if( position.native_origin() != coords::origin::abs ||
            position.native_scale() != coords::scale::map_square ) {
            throw std::invalid_argument(
                "services.gameplay.environment.furniture_id requires an absolute map-square Tripoint" );
        }
        map &here = get_map();
        const tripoint_abs_ms absolute( position.to_native() );
        return here.furn( here.get_bub( absolute ) ).id().str();
    } );
    environment.set_function( "field_exists", [require_read](
    const cata::lua_platform::script_tripoint_coord & position, const std::string & field_id ) {
        require_read();
        if( field_id.empty() || field_id.size() > 256 || field_id.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                "services.gameplay.environment.field_exists requires a bounded non-empty field id" );
        }
        if( position.native_origin() != coords::origin::abs ||
            position.native_scale() != coords::scale::map_square ) {
            throw std::invalid_argument(
                "services.gameplay.environment.field_exists requires an absolute map-square Tripoint" );
        }
        map &here = get_map();
        const tripoint_abs_ms absolute( position.to_native() );
        return !!here.field_at( here.get_bub( absolute ) ).find_field(
                   field_type_id( field_id ) );
    } );
    environment.set_function( "terrain_has_flag", [require_read](
    const cata::lua_platform::script_tripoint_coord & position, const std::string & flag ) {
        require_read();
        if( flag.empty() || flag.size() > 256 || flag.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                "services.gameplay.environment.terrain_has_flag requires a bounded non-empty terrain flag" );
        }
        if( position.native_origin() != coords::origin::abs ||
            position.native_scale() != coords::scale::map_square ) {
            throw std::invalid_argument(
                "services.gameplay.environment.terrain_has_flag requires an absolute map-square Tripoint" );
        }
        map &here = get_map();
        const tripoint_abs_ms absolute( position.to_native() );
        return here.ter( here.get_bub( absolute ) )->has_flag( flag );
    } );
    environment.set_function( "is_indoor_tile", [require_read](
    const cata::lua_platform::script_tripoint_coord & position ) {
        require_read();
        if( position.native_origin() != coords::origin::abs ||
            position.native_scale() != coords::scale::map_square ) {
            throw std::invalid_argument(
                "services.gameplay.environment.is_indoor_tile requires an absolute map-square Tripoint" );
        }
        map &here = get_map();
        const tripoint_bub_ms bub = here.get_bub(
                                        tripoint_abs_ms( position.to_native() ) );
        if( !here.inbounds( bub ) ) {
            return false;
        }
        return !here.is_outside( bub );
    } );
    environment.set_function( "safe_mode_dangerous", [require_read](
    const std::string & direction ) {
        require_read();
        const std::optional<cardinal_direction> dir =
            io::string_to_enum_optional<cardinal_direction>( direction );
        if( !dir ) {
            throw std::invalid_argument(
                "services.gameplay.environment.safe_mode_dangerous requires a valid cardinal direction" );
        }
        return get_avatar().get_mon_visible().dangerous[
            static_cast<int>( *dir )];
    } );
    gameplay["environment"] = std::move( environment );
    services["gameplay"] = std::move( gameplay );

    sol::table native_events = lua.create_table();
    native_events.set_function(
        "emit",
        [require_write]( const std::string & type_name,
    const sol::optional<sol::table> &requested_args ) {
        require_write();
        if( type_name.empty() || type_name.size() > 128 ) {
            throw std::invalid_argument(
                "services.native_events.emit type must contain 1..128 bytes" );
        }
        const std::optional<event_type> type =
            io::string_to_enum_optional<event_type>( type_name );
        if( !type ) {
            throw std::invalid_argument(
                "services.native_events.emit received an unknown event type" );
        }
        std::map<std::size_t, std::string> indexed_args;
        if( requested_args ) {
            for( const auto &entry : *requested_args ) {
                if( !entry.first.is<lua_Integer>() ||
                    !entry.second.is<std::string>() ) {
                    throw std::invalid_argument(
                        "services.native_events.emit args must be a dense string array" );
                }
                const lua_Integer raw_index =
                    entry.first.as<lua_Integer>();
                if( raw_index <= 0 || raw_index > 64 ) {
                    throw std::invalid_argument(
                        "services.native_events.emit arg index must be within 1..64" );
                }
                std::string value =
                    entry.second.as<std::string>();
                if( value.size() > 1024 ) {
                    throw std::invalid_argument(
                        "services.native_events.emit args cannot exceed 1024 bytes" );
                }
                indexed_args.emplace(
                    static_cast<std::size_t>( raw_index ),
                    std::move( value ) );
            }
        }
        if( !indexed_args.empty() &&
            indexed_args.rbegin()->first != indexed_args.size() ) {
            throw std::invalid_argument(
                "services.native_events.emit args must not contain holes" );
        }
        std::vector<std::string> args;
        args.reserve( indexed_args.size() );
        for( auto &[index, value] : indexed_args ) {
            static_cast<void>( index );
            args.push_back( std::move( value ) );
        }
        get_event_bus().send(
            cata::event::make_dyn( *type, args ) );
        return true;
    } );
    services["native_events"] = std::move( native_events );

    cata::lua_platform::install_game_interaction_api( services, require_write, has_callback );
    const auto play_audible_sound = [weak, require_write](
                                        const std::string & id, const std::string & variant,
                                        const sol::optional<int> &requested_volume,
    const bool from_outdoors ) {
        require_write();
        if( id.empty() || id.size() > 128 || id.find( '\0' ) != std::string::npos ||
            variant.empty() || variant.size() > 128 ||
            variant.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                "services.sound audible playback requires bounded sound and variant ids" );
        }
        const int requested = requested_volume.value_or( 80 );
        if( requested < 0 || requested > 128 ) {
            throw std::invalid_argument(
                "services.sound audible playback volume must be within 0..128" );
        }
        avatar &player = get_avatar();
        static const efftype_id effect_sleep( "sleep" );
        if( player.has_effect( effect_sleep ) || player.is_deaf() ) {
            return false;
        }
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner ) {
            throw std::runtime_error( "stale Platform runtime" );
        }
        int volume = requested;
        if( from_outdoors ) {
            const int depth = std::max( 0, -get_map().get_abs_sub().z() );
            if( depth > 0 ) {
                const double hearing = std::max(
                                           0.01, static_cast<double>( player.hearing_ability() ) );
                const int denominator = std::max(
                                            1, static_cast<int>( std::ceil(
                                                        2.0 * depth / hearing ) ) );
                std::uniform_int_distribution<int> gate( 1, denominator );
                if( gate( owner->random_engine ) != 1 ) {
                    return false;
                }
                if( !requested_volume ) {
                    volume = std::clamp(
                                 static_cast<int>( std::round( 80.0 * hearing ) ),
                                 0, 128 );
                }
            }
        }
        std::uniform_real_distribution<double> direction( 0.0, 360.0 );
        sfx::play_variant_sound(
            id, variant, volume,
            units::from_degrees( direction( owner->random_engine ) ) );
        return true;
    };
    sol::table platform_sound = services["sound"];
    platform_sound.set_function( "play_if_audible", [play_audible_sound](
                                     const std::string & id, const std::string & variant,
    const sol::optional<int> &volume ) {
        return play_audible_sound( id, variant, volume, false );
    } );
    platform_sound.set_function( "play_from_outdoors", [play_audible_sound](
                                     const std::string & id, const std::string & variant,
    const sol::optional<int> &volume ) {
        return play_audible_sound( id, variant, volume, true );
    } );
    services["sound"] = std::move( platform_sound );
    cata::lua_platform::install_game_world_service_api(
        services, runtime_generation, world_generation, require_read, require_write,
        require_write, has_callback );
    cata::lua_platform::install_variable_api( services, runtime_generation, world_generation,
            require_read, require_write, has_callback );
    ccb["services"] = std::move( services );
}

namespace
{

bool platform_declarative_mapgen_matches(
    const runtime::declarative_mapgen_definition &definition,
    const mapgendata &data, const bool primary )
{
    if( definition.primary != primary || data.zlevel() < definition.z_min ||
        data.zlevel() > definition.z_max ) {
        return false;
    }
    if( definition.terrain_ids.empty() ) {
        return true;
    }
    const std::string terrain_id = data.terrain_type().id().str();
    return std::binary_search( definition.terrain_ids.begin(),
                               definition.terrain_ids.end(), terrain_id );
}

std::uint64_t platform_mapgen_seed(
    const runtime &owner, const mapgendata &data,
    const std::string_view salt )
{
    std::uint64_t seed = fnv1a( owner.mod_id );
    seed = fnv1a( data.terrain_type().id().str(), seed );
    seed = fnv1a( std::to_string( data.pos().x() ), seed );
    seed = fnv1a( std::to_string( data.pos().y() ), seed );
    seed = fnv1a( std::to_string( data.pos().z() ), seed );
    seed = fnv1a( salt, seed );
    if( g != nullptr ) {
        seed ^= static_cast<std::uint64_t>( g->get_seed() );
    }
    return seed;
}

void merge_platform_mapgen_palette(
    const runtime &owner, const std::string &id,
    std::map<std::string, sol::object> &symbols,
    std::set<std::string> &active )
{
    const auto found = owner.mapgen_palettes.find( id );
    if( found == owner.mapgen_palettes.end() ) {
        throw std::runtime_error( "missing mapgen palette '" + id + "'" );
    }
    if( !active.insert( id ).second ) {
        throw std::runtime_error( "mapgen palette inheritance cycle at '" + id + "'" );
    }
    for( const std::string &parent : found->second.parents ) {
        merge_platform_mapgen_palette( owner, parent, symbols, active );
    }
    active.erase( id );
    for( const auto &entry : found->second.symbols ) {
        symbols[entry.first] = entry.second;
    }
}

sol::object select_platform_mapgen_value(
    const std::shared_ptr<cata::lua_platform::script_mapgen_context> &context,
    const sol::object &source, const std::string_view label )
{
    if( source.get_type() == sol::type::string ) {
        return source;
    }
    if( source.get_type() != sol::type::table ) {
        throw std::invalid_argument( std::string( label ) +
                                     " must be a string or choices array" );
    }
    const sol::table choices = source.as<sol::table>();
    const std::size_t count = require_dense_array( choices, label, 1, 1024 );
    std::vector<std::pair<sol::object, std::int64_t>> weighted;
    weighted.reserve( count );
    std::int64_t total = 0;
    for( std::size_t index = 1; index <= count; ++index ) {
        sol::object value = choices.raw_get<sol::object>( index );
        std::int64_t weight = 1;
        if( value.get_type() == sol::type::table ) {
            const sol::table weighted_value = value.as<sol::table>();
            const sol::object raw_value = weighted_value.raw_get<sol::object>( "value" );
            const sol::object raw_weight = weighted_value.raw_get<sol::object>( "weight" );
            if( raw_value.valid() && raw_value.get_type() != sol::type::nil ) {
                validate_platform_mapgen_descriptor_keys(
                    weighted_value, { "value", "weight" }, "weighted choice" );
                value = raw_value;
                if( raw_weight.valid() && raw_weight.get_type() != sol::type::nil ) {
                    if( !raw_weight.is<lua_Integer>() ) {
                        throw std::invalid_argument(
                            std::string( label ) + " weight must be an integer" );
                    }
                    weight = raw_weight.as<std::int64_t>();
                }
            } else {
                require_dense_array( weighted_value, "mapgen weighted choice", 2, 2 );
                value = weighted_value.raw_get<sol::object>( 1 );
                const sol::object raw_tuple_weight =
                    weighted_value.raw_get<sol::object>( 2 );
                if( !raw_tuple_weight.is<lua_Integer>() ) {
                    throw std::invalid_argument(
                        std::string( label ) + " weight must be an integer" );
                }
                weight = raw_tuple_weight.as<std::int64_t>();
            }
        }
        if( value.get_type() != sol::type::string || weight <= 0 ||
            weight > 1000000 || total > 1000000000 - weight ) {
            throw std::invalid_argument( std::string( label ) +
                                         " contains an invalid weighted choice" );
        }
        total += weight;
        weighted.emplace_back( std::move( value ), weight );
    }
    std::int64_t roll = context->random_int( 1, static_cast<int>( total ) );
    for( const auto &entry : weighted ) {
        roll -= entry.second;
        if( roll <= 0 ) {
            return entry.first;
        }
    }
    throw std::runtime_error( "mapgen weighted choice failed to select a value" );
}

void invoke_platform_mapgen_callback(
    runtime &owner, sol::protected_function callback,
    const std::shared_ptr<cata::lua_platform::script_mapgen_context> &context,
    const std::optional<int> x = std::nullopt,
    const std::optional<int> y = std::nullopt,
    const std::string &glyph = {} )
{
    if( owner.callback_depth >= 16 ) {
        throw std::runtime_error( "mapgen callback recursion limit reached" );
    }
    callback_scope scope( owner );
    platform_mapgen_callback_write_scope mapgen_write_scope;
    sol::protected_function_result result = x && y ?
                                            callback( context, *x, *y, glyph ) : callback( context );
    if( !result.valid() ) {
        const sol::error error = result;
        throw std::runtime_error( error.what() );
    }
}

sol::object platform_mapgen_field(
    const sol::table &descriptor, const std::string_view name )
{
    return descriptor.raw_get<sol::object>( std::string( name ) );
}

std::string platform_mapgen_string(
    const sol::table &descriptor, const std::string_view name,
    const std::string &fallback = {} )
{
    const sol::object value = platform_mapgen_field( descriptor, name );
    if( !value.valid() || value.get_type() == sol::type::nil ) {
        return fallback;
    }
    if( value.get_type() != sol::type::string ) {
        throw std::invalid_argument( "mapgen symbol '" + std::string( name ) +
                                     "' must be a string" );
    }
    return value.as<std::string>();
}

std::int64_t platform_mapgen_integer(
    const sol::table &descriptor, const std::string_view name,
    const std::int64_t fallback, const std::int64_t minimum,
    const std::int64_t maximum )
{
    const sol::object value = platform_mapgen_field( descriptor, name );
    if( !value.valid() || value.get_type() == sol::type::nil ) {
        return fallback;
    }
    if( !value.is<lua_Integer>() ) {
        throw std::invalid_argument( "mapgen symbol '" + std::string( name ) +
                                     "' must be an integer" );
    }
    const std::int64_t result = value.as<std::int64_t>();
    if( result < minimum || result > maximum ) {
        throw std::invalid_argument( "mapgen symbol '" + std::string( name ) +
                                     "' is outside its supported range" );
    }
    return result;
}

double platform_mapgen_number(
    const sol::table &descriptor, const std::string_view name,
    const double fallback, const double minimum, const double maximum )
{
    const sol::object value = platform_mapgen_field( descriptor, name );
    if( !value.valid() || value.get_type() == sol::type::nil ) {
        return fallback;
    }
    if( value.get_type() != sol::type::number ) {
        throw std::invalid_argument( "mapgen symbol '" + std::string( name ) +
                                     "' must be a number" );
    }
    const double result = value.as<double>();
    if( !std::isfinite( result ) || result < minimum || result > maximum ) {
        throw std::invalid_argument( "mapgen symbol '" + std::string( name ) +
                                     "' is outside its supported range" );
    }
    return result;
}

bool platform_mapgen_boolean(
    const sol::table &descriptor, const std::string_view name,
    const bool fallback )
{
    const sol::object value = platform_mapgen_field( descriptor, name );
    if( !value.valid() || value.get_type() == sol::type::nil ) {
        return fallback;
    }
    if( value.get_type() != sol::type::boolean ) {
        throw std::invalid_argument( "mapgen symbol '" + std::string( name ) +
                                     "' must be a boolean" );
    }
    return value.as<bool>();
}

sol::table platform_mapgen_table(
    const sol::object &source, const std::string_view label )
{
    if( source.get_type() != sol::type::table ) {
        throw std::invalid_argument( std::string( label ) + " must be a table" );
    }
    return source.as<sol::table>();
}

void apply_platform_mapgen_computer(
    runtime &owner,
    const std::shared_ptr<cata::lua_platform::script_mapgen_context> &context,
    const sol::object &source, const int x, const int y )
{
    const sol::table descriptor = platform_mapgen_table(
                                      source, "mapgen symbol computer" );
    validate_platform_mapgen_descriptor_keys(
    descriptor, {
        "name", "security", "access_denied", "mission_target", "options",
        "failures", "eocs", "chat_topics", "on_access", "access_handler"
    },
    "symbol computer" );
    const std::string name = platform_mapgen_string( descriptor, "name" );
    const int security = static_cast<int>( platform_mapgen_integer(
            descriptor, "security", 0, -1000000, 1000000 ) );
    context->place_computer(
        x, y, name, security,
        platform_mapgen_string( descriptor, "access_denied" ),
        platform_mapgen_boolean( descriptor, "mission_target", false ) );

    const sol::object options = platform_mapgen_field( descriptor, "options" );
    if( options.valid() && options.get_type() != sol::type::nil ) {
        const sol::table values = platform_mapgen_table(
                                      options, "mapgen computer options" );
        const std::size_t count = require_dense_array(
                                      values, "mapgen computer options", 0, 256 );
        for( std::size_t index = 1; index <= count; ++index ) {
            const sol::table option = platform_mapgen_table(
                                          values.raw_get<sol::object>( index ),
                                          "mapgen computer option" );
            validate_platform_mapgen_descriptor_keys(
                option, { "name", "action", "security" },
                "symbol computer option" );
            context->add_computer_option(
                x, y, platform_mapgen_string( option, "name" ),
                platform_mapgen_string( option, "action" ),
                static_cast<int>( platform_mapgen_integer(
                                      option, "security", 0, -1000000, 1000000 ) ) );
        }
    }
    for( const std::string &failure : platform_mapgen_string_array(
             platform_mapgen_field( descriptor, "failures" ),
             "mapgen computer failures", 256, true, false ) ) {
        context->add_computer_failure( x, y, failure );
    }
    for( const std::string &eoc : platform_mapgen_string_array(
             platform_mapgen_field( descriptor, "eocs" ),
             "mapgen computer eocs", 256, true, false ) ) {
        context->add_computer_eoc( x, y, eoc );
    }
    const std::string on_access = platform_mapgen_string(
                                      descriptor, "on_access" );
    const std::string access_handler = platform_mapgen_string(
                                           descriptor, "access_handler" );
    if( !on_access.empty() && !access_handler.empty() &&
        on_access != access_handler ) {
        throw std::invalid_argument(
            "mapgen computer on_access and access_handler must identify the same handler" );
    }
    const std::string &handler_id = on_access.empty() ? access_handler : on_access;
    if( !handler_id.empty() ) {
        if( owner.handlers.count( handler_id ) == 0 ) {
            throw std::invalid_argument(
                "mapgen computer references missing handler '" + handler_id + "'" );
        }
        context->set_computer_access_handler( x, y, handler_id );
    }
    for( const std::string &topic : platform_mapgen_string_array(
             platform_mapgen_field( descriptor, "chat_topics" ),
             "mapgen computer chat topics", 256, true, false ) ) {
        context->add_computer_chat_topic( x, y, topic );
    }
}

void apply_platform_mapgen_sealed_item(
    const std::shared_ptr<cata::lua_platform::script_mapgen_context> &context,
    const sol::object &source, const int x, const int y )
{
    const sol::table descriptor = platform_mapgen_table(
                                      source, "mapgen symbol sealed_item" );
    validate_platform_mapgen_descriptor_keys(
    descriptor, {
        "furniture", "item", "quantity", "charges", "item_group",
        "item_group_chance", "faction"
    }, "symbol sealed_item" );
    context->place_sealed_item(
        x, y, platform_mapgen_string( descriptor, "furniture" ),
        platform_mapgen_string( descriptor, "item" ),
        static_cast<int>( platform_mapgen_integer(
                              descriptor, "quantity", 1, 0, 10000 ) ),
        static_cast<int>( platform_mapgen_integer(
                              descriptor, "charges", 0, 0, 1000000000 ) ),
        platform_mapgen_string( descriptor, "item_group" ),
        static_cast<int>( platform_mapgen_integer(
                              descriptor, "item_group_chance", 100, 1, 100 ) ),
        platform_mapgen_string( descriptor, "faction" ) );
}

[[noreturn]] void apply_platform_mapgen_zone(
    const std::shared_ptr<cata::lua_platform::script_mapgen_context> &context,
    const sol::object &source, const int x, const int y )
{
    const sol::table descriptor = platform_mapgen_table(
                                      source, "mapgen symbol zone" );
    validate_platform_mapgen_descriptor_keys(
        descriptor, { "type", "faction", "name", "filter" },
        "symbol zone" );
    context->place_zone(
        x, y, x, y, platform_mapgen_string( descriptor, "type" ),
        platform_mapgen_string( descriptor, "faction" ),
        platform_mapgen_string( descriptor, "name" ),
        platform_mapgen_string( descriptor, "filter" ) );
}

void apply_platform_mapgen_symbol(
    runtime &owner,
    const std::shared_ptr<cata::lua_platform::script_mapgen_context> &context,
    const sol::object &source, const int x, const int y,
    const std::string &glyph, const std::size_t depth = 0 )
{
    if( depth >= 16 ) {
        throw std::runtime_error( "mapgen symbol descriptor nesting limit reached" );
    }
    if( source.get_type() == sol::type::string ) {
        context->set_terrain_id( x, y, source.as<std::string>() );
        return;
    }
    if( source.get_type() == sol::type::function ) {
        invoke_platform_mapgen_callback(
            owner, source.as<sol::protected_function>(), context, x, y, glyph );
        return;
    }
    if( source.get_type() != sol::type::table ) {
        throw std::invalid_argument(
            "mapgen symbol descriptor must be a string, function, or table" );
    }
    const sol::table descriptor = source.as<sol::table>();
    const sol::object first = descriptor.raw_get<sol::object>( 1 );
    if( first.valid() && first.get_type() != sol::type::nil ) {
        const std::size_t count = require_dense_array(
                                      descriptor, "mapgen symbol sequence", 1, 256 );
        for( std::size_t index = 1; index <= count; ++index ) {
            apply_platform_mapgen_symbol(
                owner, context, descriptor.raw_get<sol::object>( index ),
                x, y, glyph, depth + 1 );
        }
        return;
    }
    validate_platform_mapgen_descriptor_keys( descriptor, {
        "chance", "repeat", "one_of", "sequence", "terrain", "furniture",
        "trap", "field", "field_intensity", "field_age_turns", "field_remove",
        "item", "item_quantity", "item_charges", "item_group",
        "item_group_chance", "item_faction", "liquid", "liquid_charges",
        "toilet", "sign", "sign_furniture", "graffiti", "vending",
        "vending_reinforced", "vending_lootable", "vending_powered",
        "vending_networked", "gas_pump", "gas_pump_charges",
        "monster_group", "monster_group_chance", "monster_density",
        "monster_individual", "monster_friendly", "monster_name",
        "monster_mission_target", "monster", "monster_count", "monster_chance",
        "corpse", "corpse_group", "corpse_age_days", "rubble", "rubble_floor",
        "rubble_items", "rubble_overwrite", "computer", "sealed_item",
        "queue_point", "callback"
    }, "symbol" );
    const std::int64_t chance = platform_mapgen_integer(
                                    descriptor, "chance", 100, 0, 100 );
    const std::int64_t repeat = platform_mapgen_integer(
                                    descriptor, "repeat", 1, 1, 64 );
    if( !context->random_chance( static_cast<std::uint64_t>( chance ), 100 ) ) {
        return;
    }
    const sol::object one_of = descriptor.raw_get<sol::object>( "one_of" );
    if( one_of.valid() && one_of.get_type() != sol::type::nil ) {
        if( one_of.get_type() != sol::type::table ) {
            throw std::invalid_argument( "mapgen symbol one_of must be an array table" );
        }
        const sol::table choices = one_of.as<sol::table>();
        const std::size_t count = require_dense_array(
                                      choices, "mapgen symbol one_of", 1, 256 );
        const int selected = context->random_int( 1, static_cast<int>( count ) );
        apply_platform_mapgen_symbol(
            owner, context, choices.raw_get<sol::object>( selected ),
            x, y, glyph, depth + 1 );
    }
    const sol::object sequence = descriptor.raw_get<sol::object>( "sequence" );
    if( sequence.valid() && sequence.get_type() != sol::type::nil ) {
        if( sequence.get_type() != sol::type::table ) {
            throw std::invalid_argument( "mapgen symbol sequence must be an array table" );
        }
        const sol::table values = sequence.as<sol::table>();
        const std::size_t count = require_dense_array(
                                      values, "mapgen symbol sequence", 0, 256 );
        for( std::size_t index = 1; index <= count; ++index ) {
            apply_platform_mapgen_symbol(
                owner, context, values.raw_get<sol::object>( index ),
                x, y, glyph, depth + 1 );
        }
    }
    for( std::int64_t iteration = 0; iteration < repeat; ++iteration ) {
        const sol::object remove_all = platform_mapgen_field( descriptor, "remove_all" );
        if( remove_all.valid() && remove_all.get_type() != sol::type::nil ) {
            if( remove_all.get_type() != sol::type::boolean ) {
                throw std::invalid_argument( "mapgen symbol remove_all must be a boolean" );
            }
            if( remove_all.as<bool>() ) {
                context->remove_all( x, y, x, y );
            }
        }
        const sol::object remove_vehicles =
            platform_mapgen_field( descriptor, "remove_vehicles" );
        if( remove_vehicles.valid() && remove_vehicles.get_type() != sol::type::nil ) {
            std::vector<std::string> prototypes;
            if( remove_vehicles.get_type() == sol::type::boolean ) {
                if( !remove_vehicles.as<bool>() ) {
                    prototypes.clear();
                } else {
                    context->remove_vehicles( x, y, x, y, prototypes );
                }
            } else {
                prototypes = platform_mapgen_string_array(
                                 remove_vehicles, "mapgen remove_vehicles", 1024, true );
                context->remove_vehicles( x, y, x, y, prototypes );
            }
        }
        const sol::object remove_npcs =
            platform_mapgen_field( descriptor, "remove_npcs" );
        if( remove_npcs.valid() && remove_npcs.get_type() != sol::type::nil ) {
            if( remove_npcs.get_type() == sol::type::boolean ) {
                if( remove_npcs.as<bool>() ) {
                    context->remove_npcs( "", "" );
                }
            } else {
                const sol::table removal = platform_mapgen_table(
                                               remove_npcs, "mapgen remove_npcs" );
                validate_platform_mapgen_descriptor_keys(
                    removal, { "template", "unique_id" }, "symbol remove_npcs" );
                context->remove_npcs(
                    platform_mapgen_string( removal, "template" ),
                    platform_mapgen_string( removal, "unique_id" ) );
            }
        }
        const sol::object terrain = descriptor.raw_get<sol::object>( "terrain" );
        if( terrain.valid() && terrain.get_type() != sol::type::nil ) {
            context->set_terrain_id( x, y,
                                     select_platform_mapgen_value(
                                         context, terrain, "mapgen terrain choices" ).as<std::string>() );
        }
        const sol::object furniture = descriptor.raw_get<sol::object>( "furniture" );
        if( furniture.valid() && furniture.get_type() != sol::type::nil ) {
            context->set_furniture_id( x, y,
                                       select_platform_mapgen_value(
                                           context, furniture,
                                           "mapgen furniture choices" ).as<std::string>() );
        }
        const sol::object trap = descriptor.raw_get<sol::object>( "trap" );
        if( trap.valid() && trap.get_type() != sol::type::nil ) {
            context->set_trap_id( x, y,
                                  select_platform_mapgen_value(
                                      context, trap, "mapgen trap choices" ).as<std::string>() );
        }
        const sol::object field = platform_mapgen_field( descriptor, "field" );
        if( field.valid() && field.get_type() != sol::type::nil ) {
            const std::string id = select_platform_mapgen_value(
                                       context, field, "mapgen field choices" ).as<std::string>();
            if( platform_mapgen_boolean( descriptor, "field_remove", false ) ) {
                context->remove_field( x, y, id );
            } else {
                context->add_field(
                    x, y, id,
                    static_cast<int>( platform_mapgen_integer(
                                          descriptor, "field_intensity", 1, 1, 100 ) ),
                    platform_mapgen_integer(
                        descriptor, "field_age_turns", 0, 0,
                        INT64_C( 1000000000000 ) ) );
            }
        }
        const std::string item_faction =
            platform_mapgen_string( descriptor, "item_faction" );
        const sol::object item = platform_mapgen_field( descriptor, "item" );
        if( item.valid() && item.get_type() != sol::type::nil ) {
            context->place_item(
                x, y, select_platform_mapgen_value(
                    context, item, "mapgen item choices" ).as<std::string>(),
                static_cast<int>( platform_mapgen_integer(
                                      descriptor, "item_quantity", 1, 1, 10000 ) ),
                static_cast<int>( platform_mapgen_integer(
                                      descriptor, "item_charges", 0, 0, 1000000000 ) ),
                item_faction );
        }
        const sol::object item_group =
            platform_mapgen_field( descriptor, "item_group" );
        if( item_group.valid() && item_group.get_type() != sol::type::nil ) {
            context->place_item_group(
                x, y, x, y, select_platform_mapgen_value(
                    context, item_group, "mapgen item group choices" ).as<std::string>(),
                static_cast<int>( platform_mapgen_integer(
                                      descriptor, "item_group_chance", 100, 1, 100 ) ),
                item_faction );
        }
        const sol::object liquid = platform_mapgen_field( descriptor, "liquid" );
        if( liquid.valid() && liquid.get_type() != sol::type::nil ) {
            context->place_liquid(
                x, y, select_platform_mapgen_value(
                    context, liquid, "mapgen liquid choices" ).as<std::string>(),
                static_cast<int>( platform_mapgen_integer(
                                      descriptor, "liquid_charges", 1, 1, 1000000000 ) ) );
        }
        const sol::object toilet = platform_mapgen_field( descriptor, "toilet" );
        if( toilet.valid() && toilet.get_type() != sol::type::nil ) {
            int charges = 0;
            if( toilet.get_type() == sol::type::boolean ) {
                if( !toilet.as<bool>() ) {
                    charges = -1;
                }
            } else if( toilet.is<lua_Integer>() ) {
                const std::int64_t raw_charges = toilet.as<std::int64_t>();
                if( raw_charges < 0 || raw_charges > 1000000000 ) {
                    throw std::invalid_argument( "mapgen toilet charges are invalid" );
                }
                charges = static_cast<int>( raw_charges );
            } else {
                throw std::invalid_argument(
                    "mapgen symbol toilet must be a boolean or integer" );
            }
            if( charges >= 0 ) {
                context->place_toilet( x, y, charges );
            }
        }
        const sol::object sign = platform_mapgen_field( descriptor, "sign" );
        if( sign.valid() && sign.get_type() != sol::type::nil ) {
            if( sign.get_type() != sol::type::string ) {
                throw std::invalid_argument( "mapgen symbol sign must be a string" );
            }
            context->place_sign(
                x, y, sign.as<std::string>(),
                platform_mapgen_string( descriptor, "sign_furniture" ) );
        }
        const sol::object graffiti = platform_mapgen_field( descriptor, "graffiti" );
        if( graffiti.valid() && graffiti.get_type() != sol::type::nil ) {
            if( graffiti.get_type() != sol::type::string ) {
                throw std::invalid_argument( "mapgen symbol graffiti must be a string" );
            }
            context->set_graffiti( x, y, graffiti.as<std::string>() );
        }
        const sol::object vending = platform_mapgen_field( descriptor, "vending" );
        if( vending.valid() && vending.get_type() != sol::type::nil ) {
            context->place_vending_machine(
                x, y, select_platform_mapgen_value(
                    context, vending, "mapgen vending choices" ).as<std::string>(),
                platform_mapgen_boolean( descriptor, "vending_reinforced", false ),
                platform_mapgen_boolean( descriptor, "vending_lootable", false ),
                platform_mapgen_boolean( descriptor, "vending_powered", false ),
                platform_mapgen_boolean( descriptor, "vending_networked", false ) );
        }
        const sol::object gas_pump = platform_mapgen_field( descriptor, "gas_pump" );
        if( gas_pump.valid() && gas_pump.get_type() != sol::type::nil ) {
            std::string fuel;
            bool place = true;
            if( gas_pump.get_type() == sol::type::boolean ) {
                place = gas_pump.as<bool>();
            } else if( gas_pump.get_type() == sol::type::string ) {
                fuel = gas_pump.as<std::string>();
            } else {
                throw std::invalid_argument(
                    "mapgen symbol gas_pump must be a boolean or fuel id string" );
            }
            if( place ) {
                context->place_gas_pump(
                    x, y, static_cast<int>( platform_mapgen_integer(
                                                descriptor, "gas_pump_charges", 10000,
                                                1, 1000000000 ) ), fuel );
            }
        }
        const sol::object monster_group =
            platform_mapgen_field( descriptor, "monster_group" );
        if( monster_group.valid() && monster_group.get_type() != sol::type::nil ) {
            context->place_monster_group(
                x, y, x, y, select_platform_mapgen_value(
                    context, monster_group,
                    "mapgen monster group choices" ).as<std::string>(),
                static_cast<int>( platform_mapgen_integer(
                                      descriptor, "monster_group_chance", 1,
                                      1, 1000000 ) ),
                platform_mapgen_number(
                    descriptor, "monster_density", -1.0, -1.0, 1000000.0 ),
                platform_mapgen_boolean( descriptor, "monster_individual", false ),
                platform_mapgen_boolean( descriptor, "monster_friendly", false ),
                platform_mapgen_string( descriptor, "monster_name" ),
                platform_mapgen_boolean(
                    descriptor, "monster_mission_target", false ) );
        }
        const sol::object monster = platform_mapgen_field( descriptor, "monster" );
        if( monster.valid() && monster.get_type() != sol::type::nil &&
            context->random_chance(
                static_cast<std::uint64_t>( platform_mapgen_integer(
                                                descriptor, "monster_chance", 100, 0, 100 ) ),
                100 ) ) {
            context->place_monster(
                x, y, select_platform_mapgen_value(
                    context, monster, "mapgen monster choices" ).as<std::string>(),
                static_cast<int>( platform_mapgen_integer(
                                      descriptor, "monster_count", 1, 1, 10000 ) ),
                platform_mapgen_boolean( descriptor, "monster_friendly", false ),
                platform_mapgen_string( descriptor, "monster_name" ),
                platform_mapgen_boolean(
                    descriptor, "monster_mission_target", false ) );
        }
        const int corpse_age_days = static_cast<int>( platform_mapgen_integer(
                                        descriptor, "corpse_age_days", 0, 0, 1000000 ) );
        const sol::object corpse = platform_mapgen_field( descriptor, "corpse" );
        if( corpse.valid() && corpse.get_type() != sol::type::nil ) {
            context->place_corpse(
                x, y, select_platform_mapgen_value(
                    context, corpse, "mapgen corpse choices" ).as<std::string>(),
                corpse_age_days );
        }
        const sol::object corpse_group =
            platform_mapgen_field( descriptor, "corpse_group" );
        if( corpse_group.valid() && corpse_group.get_type() != sol::type::nil ) {
            context->place_corpse_from_group(
                x, y, select_platform_mapgen_value(
                    context, corpse_group,
                    "mapgen corpse group choices" ).as<std::string>(),
                corpse_age_days );
        }
        const sol::object rubble = platform_mapgen_field( descriptor, "rubble" );
        if( rubble.valid() && rubble.get_type() != sol::type::nil ) {
            std::string rubble_id;
            bool place = true;
            if( rubble.get_type() == sol::type::boolean ) {
                place = rubble.as<bool>();
            } else if( rubble.get_type() == sol::type::string ) {
                rubble_id = rubble.as<std::string>();
            } else {
                throw std::invalid_argument(
                    "mapgen symbol rubble must be a boolean or furniture id string" );
            }
            if( place ) {
                context->make_rubble(
                    x, y, rubble_id,
                    platform_mapgen_boolean( descriptor, "rubble_items", false ),
                    platform_mapgen_string( descriptor, "rubble_floor" ),
                    platform_mapgen_boolean( descriptor, "rubble_overwrite", false ) );
            }
        }
        const sol::object computer = platform_mapgen_field( descriptor, "computer" );
        if( computer.valid() && computer.get_type() != sol::type::nil ) {
            apply_platform_mapgen_computer( owner, context, computer, x, y );
        }
        const sol::object sealed_item =
            platform_mapgen_field( descriptor, "sealed_item" );
        if( sealed_item.valid() && sealed_item.get_type() != sol::type::nil ) {
            apply_platform_mapgen_sealed_item( context, sealed_item, x, y );
        }
        const sol::object npc = platform_mapgen_field( descriptor, "npc" );
        if( npc.valid() && npc.get_type() != sol::type::nil ) {
            context->place_npc_configured(
                x, y, select_platform_mapgen_value(
                    context, npc, "mapgen npc choices" ).as<std::string>(),
                platform_mapgen_string( descriptor, "npc_unique_id" ),
                platform_mapgen_string_array(
                    platform_mapgen_field( descriptor, "npc_traits" ),
                    "mapgen npc traits", 256, true, false ),
                platform_mapgen_boolean(
                    descriptor, "npc_mission_target", false ) );
        }
        const sol::object vehicle = platform_mapgen_field( descriptor, "vehicle" );
        if( vehicle.valid() && vehicle.get_type() != sol::type::nil ) {
            context->place_vehicle(
                x, y, select_platform_mapgen_value(
                    context, vehicle, "mapgen vehicle choices" ).as<std::string>(),
                static_cast<int>( platform_mapgen_integer(
                                      descriptor, "vehicle_rotation", 0,
                                      -1000000, 1000000 ) ),
                static_cast<int>( platform_mapgen_integer(
                                      descriptor, "vehicle_fuel", -1, -1, 100 ) ),
                static_cast<int>( platform_mapgen_integer(
                                      descriptor, "vehicle_status", -1, -1, 2 ) ),
                platform_mapgen_string( descriptor, "vehicle_faction" ) );
        }
        const sol::object faction = platform_mapgen_field( descriptor, "faction" );
        if( faction.valid() && faction.get_type() != sol::type::nil ) {
            context->apply_faction_ownership(
                x, y, x, y, select_platform_mapgen_value(
                    context, faction, "mapgen faction choices" ).as<std::string>() );
        }
        const sol::object zone = platform_mapgen_field( descriptor, "zone" );
        if( zone.valid() && zone.get_type() != sol::type::nil ) {
            apply_platform_mapgen_zone( context, zone, x, y );
        }
        const sol::object transform = platform_mapgen_field( descriptor, "transform" );
        if( transform.valid() && transform.get_type() != sol::type::nil ) {
            context->transform(
                x, y, x, y, select_platform_mapgen_value(
                    context, transform, "mapgen transform choices" ).as<std::string>() );
        }
        const sol::object queue_point =
            platform_mapgen_field( descriptor, "queue_point" );
        if( queue_point.valid() && queue_point.get_type() != sol::type::nil ) {
            if( queue_point.get_type() != sol::type::string ) {
                throw std::invalid_argument( "mapgen symbol queue_point must be a string" );
            }
            context->queue_point( queue_point.as<std::string>(), x, y );
        }
        const sol::object nested = platform_mapgen_field( descriptor, "nested" );
        if( nested.valid() && nested.get_type() != sol::type::nil ) {
            context->nest(
                select_platform_mapgen_value(
                    context, nested, "mapgen nested choices" ).as<std::string>(),
                x, y );
        }
        const sol::object generator = platform_mapgen_field( descriptor, "generator" );
        if( generator.valid() && generator.get_type() != sol::type::nil ) {
            context->generate(
                select_platform_mapgen_value(
                    context, generator, "mapgen generator choices" ).as<std::string>() );
        }
        const sol::object callback = descriptor.raw_get<sol::object>( "callback" );
        if( callback.valid() && callback.get_type() != sol::type::nil ) {
            if( callback.get_type() != sol::type::function ) {
                throw std::invalid_argument( "mapgen symbol callback must be a function" );
            }
            invoke_platform_mapgen_callback(
                owner, callback.as<sol::protected_function>(), context, x, y, glyph );
        }
    }
}

void apply_platform_declarative_mapgen(
    const std::shared_ptr<runtime> &owner,
    const runtime::declarative_mapgen_definition &definition,
    mapgendata &data )
{
    platform_mapgen_transaction_report report;
    platform_mapgen_callback_transaction transaction( data, &report );
    if( !transaction.ready() ) {
        throw std::runtime_error( report.message );
    }
    std::shared_ptr<cata::lua_platform::script_mapgen_context> context;
    try {
        const std::uint64_t seed = platform_mapgen_seed(
                                       *owner, data, definition.id );
        context = std::make_shared<cata::lua_platform::script_mapgen_context>(
                      data, true, seed, owner->mod_id );
        if( definition.before_generate.valid() &&
            definition.before_generate.get_type() != sol::type::nil ) {
            invoke_platform_mapgen_callback(
                *owner, definition.before_generate.as<sol::protected_function>(), context );
        }
        if( !definition.fill_terrain.empty() ) {
            context->reset( definition.fill_terrain );
        }
        std::map<std::string, sol::object> symbols;
        std::set<std::string> active_palettes;
        for( const std::string &palette : definition.palettes ) {
            merge_platform_mapgen_palette(
                *owner, palette, symbols, active_palettes );
        }
        for( const auto &entry : definition.symbols ) {
            symbols[entry.first] = entry.second;
        }
        for( std::size_t y = 0; y < definition.rows.size(); ++y ) {
            for( std::size_t x = 0; x < definition.rows[y].size(); ++x ) {
                const std::string &glyph = definition.rows[y][x];
                const auto found = symbols.find( glyph );
                if( found == symbols.end() ) {
                    if( glyph == " " || !definition.fill_terrain.empty() ) {
                        continue;
                    }
                    throw std::runtime_error( "mapgen definition '" + definition.id +
                                              "' has no symbol mapping for '" + glyph + "'" );
                }
                apply_platform_mapgen_symbol(
                    *owner, context, found->second,
                    definition.offset_x + static_cast<int>( x ),
                    definition.offset_y + static_cast<int>( y ), glyph );
            }
        }
        if( definition.after_generate.valid() &&
            definition.after_generate.get_type() != sol::type::nil ) {
            invoke_platform_mapgen_callback(
                *owner, definition.after_generate.as<sol::protected_function>(), context );
        }
        transaction.commit();
        set_queued_points();
        context->invalidate();
    } catch( const std::exception &exception ) {
        const std::string message = exception.what();
        const bool rolled_back = transaction.rollback( "callback_failed", message );
        if( context ) {
            context->invalidate();
        }
        if( !rolled_back ) {
            throw std::runtime_error(
                "Lua-first mapgen callback failed and rollback_failed: " + message );
        }
        throw;
    } catch( ... ) {
        const std::string message = "unknown exception";
        const bool rolled_back = transaction.rollback( "callback_failed", message );
        if( context ) {
            context->invalidate();
        }
        if( !rolled_back ) {
            throw std::runtime_error(
                "Lua-first mapgen callback failed and rollback_failed: " + message );
        }
        throw;
    }
}

bool dispatch_platform_mapgen_phase( mapgendata &data, const bool primary )
{
    if( detail::current_platform_event_dispatch_depth() >= 4 ) {
        DebugLog( D_ERROR, D_MAP_GEN ) <<
                                       "Lua-first Platform mapgen recursion limit reached";
        return false;
    }
    platform_event_dispatch_scope dispatch_scope;
    bool matched = false;
    const std::vector<std::shared_ptr<runtime>> runtimes = active_runtimes;
    for( const std::shared_ptr<runtime> &owner : runtimes ) {
        if( !owner || owner->lua == nullptr ) {
            continue;
        }
        for( const runtime::declarative_mapgen_definition &definition :
             owner->declarative_mapgens ) {
            if( !platform_declarative_mapgen_matches( definition, data, primary ) ) {
                continue;
            }
            try {
                apply_platform_declarative_mapgen( owner, definition, data );
                matched = true;
            } catch( const std::exception &exception ) {
                DebugLog( D_ERROR, D_MAP_GEN ) << "Lua-first Mod '" << owner->mod_id
                                               << "' mapgen definition '"
                                               << definition.id << "': "
                                               << exception.what();
            } catch( ... ) {
                DebugLog( D_ERROR, D_MAP_GEN ) << "Lua-first Mod '" << owner->mod_id
                                               << "' mapgen definition '"
                                               << definition.id
                                               << "': unknown exception";
            }
        }
        for( const runtime::mapgen_registration &registration :
             owner->mapgen_handlers ) {
            if( registration.primary != primary ||
                data.zlevel() < registration.z_min ||
                data.zlevel() > registration.z_max ) {
                continue;
            }
            const std::string terrain_id = data.terrain_type().id().str();
            if( !registration.terrain_ids.empty() &&
                !std::binary_search( registration.terrain_ids.begin(),
                                     registration.terrain_ids.end(), terrain_id ) ) {
                continue;
            }
            const auto handler = owner->handlers.find( registration.handler_id );
            if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
                continue;
            }
            platform_mapgen_transaction_report report;
            platform_mapgen_callback_transaction transaction( data, &report );
            if( !transaction.ready() ) {
                DebugLog( D_ERROR, D_MAP_GEN ) << "Lua-first Mod '" << owner->mod_id
                                               << "' mapgen handler '"
                                               << registration.handler_id
                                               << "' transaction rejected: "
                                               << report.message;
                continue;
            }
            std::shared_ptr<cata::lua_platform::script_mapgen_context> context;
            try {
                const std::uint64_t seed = platform_mapgen_seed(
                                               *owner, data, registration.handler_id );
                context = std::make_shared<cata::lua_platform::script_mapgen_context>(
                              data, true, seed, owner->mod_id );
                sol::table payload = owner->lua->create_table();
                payload["context"] = context;
                sol::protected_function callback = handler->second.callback;
                callback_scope scope( *owner );
                platform_mapgen_callback_write_scope mapgen_write_scope;
                const sol::protected_function_result result = callback( payload );
                if( !result.valid() ) {
                    const sol::error error = result;
                    const std::string message = error.what();
                    const bool rolled_back = transaction.rollback(
                                                 "callback_failed", message );
                    context->invalidate();
                    report_callback_error( *owner, registration.handler_id, result );
                    if( !rolled_back ) {
                        DebugLog( D_ERROR, D_MAP_GEN ) << "Lua-first Mod '"
                                                       << owner->mod_id
                                                       << "' mapgen handler '"
                                                       << registration.handler_id
                                                       << "' callback failed and rollback_failed: "
                                                       << message;
                    }
                    continue;
                }
                transaction.commit();
                set_queued_points();
                context->invalidate();
                matched = true;
            } catch( const std::exception &exception ) {
                const std::string message = exception.what();
                const bool rolled_back = transaction.rollback(
                                             "callback_failed", message );
                if( context ) {
                    context->invalidate();
                }
                DebugLog( D_ERROR, D_MAP_GEN ) << "Lua-first Mod '" << owner->mod_id
                                               << "' mapgen handler '"
                                               << registration.handler_id << "': "
                                               << ( rolled_back ? message :
                                                    "rollback_failed: " + message );
                continue;
            } catch( ... ) {
                const std::string message = "unknown exception";
                const bool rolled_back = transaction.rollback(
                                             "callback_failed", message );
                if( context ) {
                    context->invalidate();
                }
                DebugLog( D_ERROR, D_MAP_GEN ) << "Lua-first Mod '" << owner->mod_id
                                               << "' mapgen handler '"
                                               << registration.handler_id << "': "
                                               << ( rolled_back ? message :
                                                    "rollback_failed: " + message );
                continue;
            }
        }
    }
    return matched;
}

} // namespace

bool runtime_has_primary_mapgen_for( const std::shared_ptr<runtime> &value,
                                     const std::string_view terrain_id )
{
    if( !value ) {
        return false;
    }
    const bool declarative = std::any_of(
                                 value->declarative_mapgens.begin(), value->declarative_mapgens.end(),
    [terrain_id]( const runtime::declarative_mapgen_definition & definition ) {
        return definition.primary &&
               ( definition.terrain_ids.empty() ||
                 std::binary_search( definition.terrain_ids.begin(),
                                     definition.terrain_ids.end(),
                                     std::string( terrain_id ) ) );
    } );
    return declarative || std::any_of(
               value->mapgen_handlers.begin(), value->mapgen_handlers.end(),
    [terrain_id]( const runtime::mapgen_registration & registration ) {
        return registration.primary &&
               ( registration.terrain_ids.empty() ||
                 std::binary_search( registration.terrain_ids.begin(),
                                     registration.terrain_ids.end(), std::string( terrain_id ) ) );
    } );
}

bool dispatch_platform_mapgen_generate( mapgendata &data )
{
    return dispatch_platform_mapgen_phase( data, true );
}

void dispatch_platform_mapgen_postprocess( mapgendata &data )
{
    static_cast<void>( dispatch_platform_mapgen_phase( data, false ) );
}

bool apply_runtime_content( const std::shared_ptr<runtime> &value, std::string &error )
{
    if( !value ) {
        error = "missing Platform runtime";
        return false;
    }
    if( !value->content.apply( error ) ) {
        value->game_handle_owner->retire();
        return false;
    }
    try {
        const cata_path base_path(
            cata_path::root_path::unknown, value->mod_root );
        for( const mod_tileset_definition &definition : value->native_tilesets ) {
            add_native_mod_tileset(
                base_path, value->mod_id, value->generation, definition );
        }
        if( !value->native_tilesets.empty() ) {
            value->tileset_registry_generation = value->generation;
        }
    } catch( const std::exception &exception ) {
        remove_native_mod_tilesets( value->mod_id, value->generation );
        value->content.rollback();
        value->game_handle_owner->retire();
        error = "Lua-first Mod '" + value->mod_id +
                "' could not register its native tileset: " + exception.what();
        return false;
    }
    error.clear();
    return true;
}

bool validate_finalized_runtime_content( const std::shared_ptr<runtime> &value,
        std::string &error )
{
    if( !value ) {
        error = "missing Platform runtime";
        return false;
    }
    const bool valid = value->content.validate_finalized( error );
    if( !valid ) {
        rollback_runtime_content( value );
    }
    return valid;
}

void rollback_runtime_content( const std::shared_ptr<runtime> &value )
{
    if( value ) {
        if( value->tileset_registry_generation ) {
            remove_native_mod_tilesets(
                value->mod_id, *value->tileset_registry_generation );
            value->tileset_registry_generation.reset();
        }
        value->content.rollback();
        value->game_handle_owner->retire();
    }
}

void commit_runtime( const std::shared_ptr<runtime> &value )
{
    if( value ) {
        value->content.commit();
    }
}

void seal_runtime_content( const std::shared_ptr<runtime> &value )
{
    if( value ) {
        value->content.seal();
    }
}

void discard_runtime( const std::shared_ptr<runtime> &value )
{
    cata::lua_platform::reset_map_tile_tokens();
    cata::lua_platform::reset_overmap_tile_tokens();
    cata::lua_platform::reset_horde_tokens();
    if( value ) {
        value->game_handle_owner->retire();
        if( value->tileset_registry_generation ) {
            remove_native_mod_tilesets(
                value->mod_id, *value->tileset_registry_generation );
            value->tileset_registry_generation.reset();
        }
        value->content.discard();
    }
}

std::string runtime_fingerprint( const std::shared_ptr<runtime> &value )
{
    if( !value ) {
        return {};
    }
    const std::string content_fingerprint = value->content.fingerprint();
    if( value->native_tilesets.empty() ) {
        return content_fingerprint;
    }
    std::uint64_t state = fnv1a( content_fingerprint );
    const auto hash_variations = [&state](
    const std::vector<mod_tileset_sprite_variation> &variations ) {
        hash_part( state, std::to_string( variations.size() ) );
        for( const mod_tileset_sprite_variation &variation : variations ) {
            hash_part( state, std::to_string( variation.weight ) );
            hash_part( state, std::to_string( variation.sprites.size() ) );
            for( const int sprite : variation.sprites ) {
                hash_part( state, std::to_string( sprite ) );
            }
        }
    };
    std::function<void( const mod_tileset_tile_definition & )> hash_tile;
    hash_tile = [&state, &hash_variations, &hash_tile](
    const mod_tileset_tile_definition & tile ) {
        hash_part( state, std::to_string( tile.ids.size() ) );
        for( const std::string &id : tile.ids ) {
            hash_part( state, id );
        }
        hash_variations( tile.foreground );
        hash_variations( tile.background );
        hash_part( state, tile.multitile ? "multitile" : "single" );
        hash_part( state, tile.rotates ? ( *tile.rotates ? "rotates" : "fixed" ) :
                   "default_rotation" );
        hash_part( state, tile.animated ? "animated" : "static" );
        hash_part( state, std::to_string( tile.height_3d ) );
        hash_part( state, std::to_string( tile.additional_tiles.size() ) );
        for( const mod_tileset_tile_definition &subtile : tile.additional_tiles ) {
            hash_tile( subtile );
        }
    };
    hash_part( state, "native_tilesets" );
    hash_part( state, std::to_string( value->native_tilesets.size() ) );
    for( const mod_tileset_definition &definition : value->native_tilesets ) {
        hash_part( state, definition.id );
        hash_part( state, std::to_string( definition.compatibility.size() ) );
        for( const std::string &compatible : definition.compatibility ) {
            hash_part( state, compatible );
        }
        hash_part( state, std::to_string( definition.atlases.size() ) );
        for( const mod_tileset_atlas_definition &atlas : definition.atlases ) {
            hash_part( state, atlas.file );
            hash_part( state, std::to_string( atlas.sprite_width ) );
            hash_part( state, std::to_string( atlas.sprite_height ) );
            hash_part( state, std::to_string( atlas.sprite_offset_x ) );
            hash_part( state, std::to_string( atlas.sprite_offset_y ) );
            hash_part( state, std::to_string( atlas.sprite_offset_x_retracted ) );
            hash_part( state, std::to_string( atlas.sprite_offset_y_retracted ) );
            hash_part( state, std::to_string( atlas.pixelscale ) );
            hash_part( state, std::to_string( atlas.transparency_r ) );
            hash_part( state, std::to_string( atlas.transparency_g ) );
            hash_part( state, std::to_string( atlas.transparency_b ) );
            hash_part( state, std::to_string( atlas.tiles.size() ) );
            for( const mod_tileset_tile_definition &tile : atlas.tiles ) {
                hash_tile( tile );
            }
            hash_part( state, std::to_string( atlas.ascii.size() ) );
            for( const mod_tileset_ascii_definition &entry : atlas.ascii ) {
                hash_part( state, std::to_string( entry.offset ) );
                hash_part( state, std::to_string( static_cast<int>( entry.color ) ) );
                hash_part( state, entry.bold ? "bold" : "normal" );
            }
        }
        hash_part( state, std::to_string( definition.overlay_ordering.size() ) );
        for( const mod_tileset_overlay_ordering &ordering :
             definition.overlay_ordering ) {
            hash_part( state, std::to_string( ordering.ids.size() ) );
            for( const std::string &id : ordering.ids ) {
                hash_part( state, id );
            }
            hash_part( state, std::to_string( ordering.order ) );
        }
    }
    std::ostringstream result;
    result << std::hex << state;
    return result.str();
}

std::size_t runtime_world_generation() noexcept
{
    return active_world_generation;
}

void runtime_npc_identity_changed() noexcept
{
    const std::size_t previous_world_generation = active_world_generation;
    if( active_world_generation == std::numeric_limits<std::size_t>::max() ) {
        active_world_generation = 1;
    } else {
        ++active_world_generation;
    }
    cata::lua_platform::dialogue::retire_sessions_for_world(
        previous_world_generation );
}

void set_active_runtimes( const std::vector<std::shared_ptr<runtime>> &values )
{
    cata::lua_platform::dialogue::retire_all_sessions();
    cata::lua_platform::reset_map_tile_tokens();
    cata::lua_platform::reset_overmap_tile_tokens();
    cata::lua_platform::reset_horde_tokens();
    cata::lua_platform::retire_trade_quote_registry();
    cata::lua_platform::dialogue::clear_response_callbacks(
        cata::lua_platform::dialogue::response_callback_origin::platform );
    active_runtimes = values;
}

void hot_swap_active_runtimes(
    const std::vector<std::shared_ptr<runtime>> &values )
{
    cata::lua_platform::dialogue::retire_all_sessions();
    cata::lua_platform::reset_map_tile_tokens();
    cata::lua_platform::reset_overmap_tile_tokens();
    cata::lua_platform::reset_horde_tokens();
    cata::lua_platform::retire_trade_quote_registry();
    cata::lua_platform::dialogue::clear_response_callbacks(
        cata::lua_platform::dialogue::response_callback_origin::platform );
    std::unordered_map<std::string, std::shared_ptr<runtime>> previous;
    std::set<std::string> previously_ready;
    for( const std::shared_ptr<runtime> &owner : active_runtimes ) {
        if( owner ) {
            previous.emplace( owner->mod_id, owner );
            if( owner->world_is_ready ) {
                previously_ready.insert( owner->mod_id );
            }
        }
    }
    for( auto owner = active_runtimes.rbegin(); owner != active_runtimes.rend(); ++owner ) {
        const std::shared_ptr<runtime> &value = *owner;
        if( value && value->world_is_ready ) {
            dispatch_lifecycle( *value, "shutdown" );
            value->world_is_ready = false;
        }
        if( value ) {
            value->game_handle_owner->retire();
        }
    }
    for( const std::shared_ptr<runtime> &owner : values ) {
        if( !owner ) {
            continue;
        }
        const auto found = previous.find( owner->mod_id );
        if( found == previous.end() || !found->second ) {
            continue;
        }
        runtime &old = *found->second;
        owner->character_state = std::move( old.character_state );
        owner->world_state = std::move( old.world_state );
        owner->tasks = std::move( old.tasks );
        owner->reported_task_migration_failures =
            std::move( old.reported_task_migration_failures );
        owner->next_task_id = old.next_task_id;
        owner->random_engine = std::move( old.random_engine );
        owner->world_is_ready = previously_ready.count( owner->mod_id ) != 0;
        owner->tileset_registry_generation = old.tileset_registry_generation;
        old.tileset_registry_generation.reset();
    }
    active_runtimes = values;
    for( const std::shared_ptr<runtime> &owner : active_runtimes ) {
        if( !owner || !owner->world_is_ready ) {
            continue;
        }
        sol::table payload = owner->lua->create_table();
        payload["new_game"] = false;
        payload["reloaded"] = true;
        dispatch_lifecycle( *owner, "world_ready", payload );
    }
    runtime_process_tasks();
}

void clear_active_runtimes()
{
    cata::lua_platform::dialogue::retire_all_sessions();
    cata::lua_platform::reset_map_tile_tokens();
    cata::lua_platform::reset_overmap_tile_tokens();
    cata::lua_platform::reset_horde_tokens();
    cata::lua_platform::retire_trade_quote_registry();
    cata::lua_platform::dialogue::clear_response_callbacks(
        cata::lua_platform::dialogue::response_callback_origin::platform );
    const bool had_active_world = !active_runtimes.empty();
    for( auto owner = active_runtimes.rbegin(); owner != active_runtimes.rend(); ++owner ) {
        const std::shared_ptr<runtime> &value = *owner;
        if( value && value->world_is_ready ) {
            dispatch_lifecycle( *value, "shutdown" );
            value->world_is_ready = false;
        }
        if( value ) {
            value->game_handle_owner->retire();
        }
        if( value && value->tileset_registry_generation ) {
            remove_native_mod_tilesets(
                value->mod_id, *value->tileset_registry_generation );
            value->tileset_registry_generation.reset();
        }
    }
    detail::stop_runtime_event_bridge();
    active_runtimes.clear();
    detail::clear_orphan_runtime_records();
    if( had_active_world ) {
        const std::size_t previous_world_generation = active_world_generation;
        if( active_world_generation != std::numeric_limits<std::size_t>::max() ) {
            ++active_world_generation;
        }
        cata::lua_platform::dialogue::retire_sessions_for_world(
            previous_world_generation );
    }
}


} // namespace cata::lua_platform

#endif // CATA_ENABLE_LUA_PLATFORM
