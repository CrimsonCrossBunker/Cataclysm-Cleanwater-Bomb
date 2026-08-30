#if CATA_ENABLE_LUA_PLATFORM

#include "lua_platform_world.h"

#include <algorithm>
#include <array>
#include <atomic>
#include <cmath>
#include <cstddef>
#include <cstdint>
#include <limits>
#include <memory>
#include <optional>
#include <set>
#include <stdexcept>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

#include "avatar.h"
#include "calendar.h"
#include "cata_scope_helpers.h"
#include "lua_platform_bindings_coords.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_handle.h"
#include "lua_platform_missions.h"
#include "clzones.h"
#include "coordinates.h"
#include "creature_tracker.h"
#include "emit.h"
#include "field.h"
#include "field_type.h"
#include "game.h"
#include "item.h"
#include "item_category.h"
#include "item_location.h"
#include "item_group.h"
#include "line.h"
#include "map.h"
#include "map_scale_constants.h"
#include "mapbuffer.h"
#include "mission.h"
#include "monster.h"
#include "mtype.h"
#include "npc.h"
#include "overmapbuffer.h"
#include "point.h"
#include "ret_val.h"
#include "rng.h"
#include "submap.h"
#include "timed_event.h"
#include "trap.h"
#include "type_id.h"
#include "vehicle.h"
#include "visitable.h"
#include "vpart_position.h"

namespace cata::lua_platform
{

struct map_tile_token_owner {
        explicit map_tile_token_owner( const std::size_t generation ) :
            generation_( generation ) {}

        bool is_active() const noexcept {
            return active_.load( std::memory_order_acquire );
        }

        void retire() noexcept {
            active_.store( false, std::memory_order_release );
        }

        std::size_t generation() const noexcept {
            return generation_;
        }

    private:
        std::atomic<bool> active_ { true };
        std::size_t generation_ = 0;
};

namespace
{

constexpr int default_tile_item_limit = 32;
constexpr int maximum_tile_item_limit = 128;
constexpr int default_tile_field_limit = 32;
constexpr int maximum_tile_field_limit = 128;
constexpr int default_map_snapshot_field_limit = 32;
constexpr int maximum_map_snapshot_field_limit = 128;
constexpr std::size_t maximum_map_snapshot_signage_bytes = 4096;
constexpr int default_region_radius = 10;
constexpr int maximum_region_radius = 30;
constexpr int maximum_region_radius_z = 5;
constexpr int default_region_limit = 128;
constexpr int maximum_region_limit = 1024;
constexpr int default_map_item_limit = 128;
constexpr int maximum_map_item_limit = 1024;
constexpr int default_vehicle_limit = 64;
constexpr int maximum_vehicle_limit = 256;
constexpr std::int64_t maximum_spawn_quantity = 1000000;
constexpr int maximum_spawn_instances = 100;
constexpr time_duration maximum_field_age = 365_days;
constexpr std::size_t maximum_offset = 1000000;
constexpr int maximum_transform_line_length = 4096;
constexpr int maximum_transform_radius = 60;
constexpr time_duration maximum_world_change_delay = 10000_days;
constexpr std::size_t maximum_world_event_key_bytes = 256;
constexpr std::size_t maximum_place_name_bytes = 1024;
constexpr std::size_t maximum_world_spawn_flags = 128;
constexpr std::size_t maximum_world_group_items = 256;
constexpr int maximum_location_search_radius = 1000;
constexpr int maximum_location_random_attempts = 1000;
constexpr int maximum_location_adjustment = 1000000;

constexpr std::size_t initial_map_tile_owner_generation = 1;
constexpr std::uint64_t initial_map_mutation_epoch = 1;

std::shared_ptr<map_tile_token_owner> &active_map_tile_owner()
{
    static std::shared_ptr<map_tile_token_owner> owner =
        std::make_shared<map_tile_token_owner>( initial_map_tile_owner_generation );
    return owner;
}

std::atomic<std::uint64_t> &active_map_mutation_epoch()
{
    static std::atomic<std::uint64_t> epoch { initial_map_mutation_epoch };
    return epoch;
}

bool same_map_tile_owner(
    const std::shared_ptr<const map_tile_token_owner> &lhs,
    const std::shared_ptr<const map_tile_token_owner> &rhs ) noexcept
{
    return lhs && rhs && lhs.get() == rhs.get();
}

const std::string eoc_cable_relocation_turn_var(
    "eoc_cable_relocation_turn" );

struct tile_options {
    int item_limit = default_tile_item_limit;
    int field_limit = default_tile_field_limit;
};

struct region_options {
    int radius = default_region_radius;
    int radius_z = 0;
    std::size_t offset = 0;
    int limit = default_region_limit;
    tile_options tile;
};

struct vehicle_options {
    std::size_t offset = 0;
    int limit = default_vehicle_limit;
};

struct map_item_options {
    int min_radius = 0;
    int max_radius = 0;
    std::size_t offset = 0;
    int limit = default_map_item_limit;
    std::optional<sol::table> filters;
};

std::size_t require_dense_lua_array(
    const sol::table &values, const std::string &description,
    const std::size_t minimum, const std::size_t maximum )
{
    const std::size_t count = values.size();
    if( count < minimum || count > maximum ) {
        throw std::invalid_argument( description + " has an invalid length" );
    }
    for( std::size_t index = 1; index <= count; ++index ) {
        const sol::object value = values.raw_get<sol::object>( index );
        if( !value.valid() || value.get_type() == sol::type::nil ) {
            throw std::invalid_argument( description + " must be a dense array" );
        }
    }
    return count;
}

std::vector<std::string> map_filter_values(
    const sol::table &descriptor, const std::string &key )
{
    const sol::object raw = descriptor.raw_get<sol::object>( key );
    if( !raw.valid() || raw.get_type() == sol::type::nil ) {
        return {};
    }
    std::vector<std::string> result;
    const auto append = [&result, &key]( const sol::object & entry ) {
        if( !entry.is<std::string>() ) {
            throw std::invalid_argument( "services.world.items_nearby filter '" + key +
                                         "' values must be strings" );
        }
        const std::string value = entry.as<std::string>();
        if( value.empty() || value.size() > 256 || value.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument( "services.world.items_nearby filter values are out of bounds" );
        }
        result.push_back( value );
    };
    if( raw.is<std::string>() ) {
        append( raw );
    } else if( raw.get_type() == sol::type::table ) {
        const sol::table values = raw.as<sol::table>();
        const std::size_t count = require_dense_lua_array(
                                      values, "services.world.items_nearby filter", 0, 128 );
        for( std::size_t index = 1; index <= count; ++index ) {
            append( values.raw_get<sol::object>( index ) );
        }
    } else {
        throw std::invalid_argument( "services.world.items_nearby filter values must be strings or arrays" );
    }
    return result;
}

bool map_item_matches_filter( const item &entry, const sol::table &descriptor )
{
    const std::vector<std::string> ids = map_filter_values( descriptor, "id" );
    const std::vector<std::string> excluded_ids = map_filter_values( descriptor, "id_blacklist" );
    const std::vector<std::string> categories = map_filter_values( descriptor, "category" );
    const std::vector<std::string> materials = map_filter_values( descriptor, "material" );
    const std::vector<std::string> flags = map_filter_values( descriptor, "flags" );
    const std::vector<std::string> excluded_flags = map_filter_values( descriptor, "excluded_flags" );
    const std::string id = entry.typeId().str();
    if( !ids.empty() && std::find( ids.begin(), ids.end(), id ) == ids.end() ) {
        return false;
    }
    if( std::find( excluded_ids.begin(), excluded_ids.end(), id ) != excluded_ids.end() ) {
        return false;
    }
    const std::string category = entry.get_category_shallow().get_id().str();
    if( !categories.empty() &&
        std::find( categories.begin(), categories.end(), category ) == categories.end() ) {
        return false;
    }
    if( !materials.empty() && std::none_of( materials.begin(), materials.end(),
    [&entry]( const std::string & value ) {
    return entry.made_of( material_id( value ) ) > 0;
    } ) ) {
        return false;
    }
    if( !flags.empty() && std::none_of( flags.begin(), flags.end(),
    [&entry]( const std::string & value ) {
    return entry.has_flag( flag_id( value ) );
    } ) ) {
        return false;
    }
    if( std::any_of( excluded_flags.begin(), excluded_flags.end(),
    [&entry]( const std::string & value ) {
    return entry.has_flag( flag_id( value ) );
    } ) ) {
        return false;
    }
    for( const char *key : {
             "uses_energy", "is_chargeable"
         } ) {
        const sol::object raw = descriptor.raw_get<sol::object>( key );
        if( raw.valid() && raw.get_type() != sol::type::nil ) {
            if( !raw.is<bool>() ) {
                throw std::invalid_argument( "services.world.items_nearby filter booleans are required" );
            }
            const bool actual = std::string_view( key ) == "uses_energy" ?
                                entry.uses_energy() : entry.is_chargeable();
            if( actual != raw.as<bool>() ) {
                return false;
            }
        }
    }
    for( const char *key : {
             "worn_only", "wielded_only", "held_only"
         } ) {
        const sol::object raw = descriptor.raw_get<sol::object>( key );
        if( raw.valid() && raw.get_type() != sol::type::nil ) {
            if( !raw.is<bool>() ) {
                throw std::invalid_argument( "services.world.items_nearby filter booleans are required" );
            }
            if( raw.as<bool>() ) {
                return false;
            }
        }
    }
    for( const auto &member : descriptor ) {
        if( !member.first.is<std::string>() ) {
            throw std::invalid_argument( "services.world.items_nearby filter keys must be strings" );
        }
        const std::string key = member.first.as<std::string>();
        if( key != "id" && key != "id_blacklist" && key != "category" &&
            key != "material" && key != "flags" && key != "excluded_flags" &&
            key != "uses_energy" && key != "is_chargeable" && key != "worn_only" &&
            key != "wielded_only" && key != "held_only" ) {
            throw std::invalid_argument( "services.world.items_nearby unknown filter field '" + key + "'" );
        }
    }
    return true;
}

enum class location_selector_kind {
    none,
    terrain,
    furniture,
    field,
    trap,
    monster,
    species,
    npc,
    zone
};

struct location_selector {
    location_selector_kind kind = location_selector_kind::none;
    std::optional<script_game_id> id;
};

struct location_search_options {
    int min_radius = 0;
    int max_radius = 0;
    int target_min_radius = 0;
    int target_max_radius = 0;
    int random_attempts = 25;
    int x_adjust = 0;
    int y_adjust = 0;
    int z_adjust = 0;
    bool z_override = false;
    bool outdoor_only = false;
    bool passable_only = false;
};

script_tripoint_coord world_to_absolute(
    const script_tripoint_coord &position )
{
    if( position.native_origin() !=
        coords::origin::reality_bubble ) {
        throw std::invalid_argument(
            "services.world.to_absolute requires a reality-bubble Tripoint" );
    }

    map &here = get_map();
    if( position.native_scale() == coords::scale::map_square ) {
        const tripoint_abs_ms absolute = here.get_abs(
                                             tripoint_bub_ms(
                                                     position.to_native() ) );
        return script_tripoint_coord::from_native(
                   coords::origin::abs, coords::scale::map_square,
                   absolute.raw() );
    }
    if( position.native_scale() == coords::scale::submap ) {
        const tripoint_bub_ms local_ms =
            coords::project_to<coords::ms>(
                tripoint_bub_sm( position.to_native() ) );
        const tripoint_abs_sm absolute =
            coords::project_to<coords::sm>(
                here.get_abs( local_ms ) );
        return script_tripoint_coord::from_native(
                   coords::origin::abs, coords::scale::submap,
                   absolute.raw() );
    }
    throw std::invalid_argument(
        "services.world.to_absolute supports map-square and submap Tripoints" );
}

script_tripoint_coord world_to_bubble(
    const script_tripoint_coord &position )
{
    if( position.native_origin() != coords::origin::abs ) {
        throw std::invalid_argument(
            "services.world.to_bubble requires an absolute Tripoint" );
    }

    map &here = get_map();
    if( position.native_scale() == coords::scale::map_square ) {
        const tripoint_bub_ms local = here.get_bub(
                                          tripoint_abs_ms(
                                              position.to_native() ) );
        return script_tripoint_coord::from_native(
                   coords::origin::reality_bubble,
                   coords::scale::map_square, local.raw() );
    }
    if( position.native_scale() == coords::scale::submap ) {
        const tripoint_abs_ms absolute_ms =
            coords::project_to<coords::ms>(
                tripoint_abs_sm( position.to_native() ) );
        const tripoint_bub_sm local =
            coords::project_to<coords::sm>(
                here.get_bub( absolute_ms ) );
        return script_tripoint_coord::from_native(
                   coords::origin::reality_bubble,
                   coords::scale::submap, local.raw() );
    }
    throw std::invalid_argument(
        "services.world.to_bubble supports map-square and submap Tripoints" );
}

tripoint_abs_ms require_absolute_ms(
    const script_tripoint_coord &position,
    const std::string &api_name )
{
    if( position.native_origin() != coords::origin::abs ||
        position.native_scale() != coords::scale::map_square ) {
        throw std::invalid_argument(
            api_name + " requires an absolute map-square Tripoint" );
    }
    return tripoint_abs_ms( position.to_native() );
}

tripoint_bub_ms require_loaded_position(
    map &here, const script_tripoint_coord &position,
    const std::string &api_name )
{
    const tripoint_abs_ms absolute =
        require_absolute_ms( position, api_name );
    if( !here.inbounds( absolute ) ) {
        throw std::invalid_argument(
            api_name + " position is outside the active map" );
    }
    return here.get_bub( absolute );
}

bool world_has_line_of_sight(
    const script_tripoint_coord &first,
    const script_tripoint_coord &second,
    const sol::optional<int> &requested_range,
    const sol::optional<bool> &requested_with_fields )
{
    constexpr std::string_view api_name =
        "services.world.has_line_of_sight";
    const int range = requested_range.value_or(
                          MAX_VIEW_DISTANCE );
    if( range < 0 || range > MAX_VIEW_DISTANCE ) {
        throw std::invalid_argument(
            std::string( api_name ) + " range must be within 0.." +
            std::to_string( MAX_VIEW_DISTANCE ) );
    }
    map &here = get_map();
    const tripoint_bub_ms first_local =
        require_loaded_position( here, first, std::string( api_name ) );
    const tripoint_bub_ms second_local =
        require_loaded_position( here, second, std::string( api_name ) );
    return here.sees(
               first_local, second_local, range,
               requested_with_fields.value_or( true ) );
}

bool world_tile_has_flag(
    const script_tripoint_coord &position,
    const std::string &layer, const std::string &flag )
{
    constexpr std::string_view api_name =
        "services.world.tile_has_flag";
    if( layer != "terrain" && layer != "furniture" ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " layer must be terrain or furniture" );
    }
    if( flag.empty() || flag.size() > 256 ||
        std::any_of( flag.begin(), flag.end(),
    []( const unsigned char ch ) {
    return ch < 0x20U || ch == 0x7fU;
} ) ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " flag must contain 1 to 256 non-control bytes" );
    }
    map &here = get_map();
    const tripoint_bub_ms local = require_loaded_position(
                                      here, position,
                                      std::string( api_name ) );
    return layer == "terrain" ?
           here.ter( local )->has_flag( flag ) :
           here.furn( local )->has_flag( flag );
}

int world_light_level(
    const script_tripoint_coord &position )
{
    constexpr std::string_view api_name =
        "services.world.light_level";
    map &here = get_map();
    const tripoint_bub_ms local = require_loaded_position(
                                      here, position,
                                      std::string( api_name ) );
    return static_cast<int>( here.light_at( local ) );
}

int world_field_strength(
    const script_tripoint_coord &position,
    const script_game_id &requested_field )
{
    constexpr std::string_view api_name =
        "services.world.field_strength";
    if( requested_field.kind() != "field" ||
        !requested_field.is_valid() ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires a valid GameId<field>" );
    }
    map &here = get_map();
    const tripoint_bub_ms local = require_loaded_position(
                                      here, position,
                                      std::string( api_name ) );
    const field_entry *entry = here.field_at( local ).find_field(
                                   field_type_id( requested_field.value() ) );
    return entry == nullptr ? 0 : entry->get_field_intensity();
}

void require_id_kind(
    const script_game_id &id, const std::string &kind,
    const std::string &api_name )
{
    if( id.kind() != kind ) {
        throw std::invalid_argument(
            api_name + " requires GameId<" + kind + ">" );
    }
    if( !id.is_valid() ) {
        throw std::invalid_argument(
            api_name + " requires a valid GameId<" + kind + ">" );
    }
}

int require_integer_option(
    const sol::object &value, const std::string &api_name,
    const std::string &key )
{
    if( !value.is<lua_Integer>() ) {
        throw std::invalid_argument(
            api_name + " option '" + key + "' must be an integer" );
    }
    const lua_Integer number = value.as<lua_Integer>();
    if( number < 0 ) {
        throw std::invalid_argument(
            api_name + " option '" + key + "' cannot be negative" );
    }
    return static_cast<int>(
               std::min<lua_Integer>(
                   number, std::numeric_limits<int>::max() ) );
}

void read_tile_option(
    tile_options &result, const std::string &key,
    const sol::object &value, const std::string &api_name )
{
    const int number =
        require_integer_option( value, api_name, key );
    if( key == "item_limit" ) {
        result.item_limit =
            std::min( number, maximum_tile_item_limit );
    } else if( key == "field_limit" ) {
        result.field_limit =
            std::min( number, maximum_tile_field_limit );
    } else {
        throw std::invalid_argument(
            api_name + " received unknown option '" + key + "'" );
    }
}

struct map_snapshot_options {
    int field_limit = default_map_snapshot_field_limit;
    std::size_t signage_limit = maximum_map_snapshot_signage_bytes;
};

struct map_tile_field_change {
    std::string id;
    int intensity = 1;
    time_duration age = 0_turns;
    bool hit_player = false;
    bool remove = false;
};

struct map_tile_field_plan {
    field_type_id id = INVALID_FIELD_TYPE_ID;
    int intensity = 1;
    time_duration age = 0_turns;
    bool remove = false;
    bool alive = true;
};

struct map_tile_changes {
    std::optional<std::string> terrain;
    bool furniture_requested = false;
    std::optional<std::string> furniture;
    bool trap_requested = false;
    std::optional<std::string> trap;
    std::vector<map_tile_field_change> fields;
};

struct map_tile_edit_plan {
    std::optional<ter_id> terrain;
    bool furniture_requested = false;
    furn_id furniture = furn_str_id::NULL_ID().id();
    bool trap_requested = false;
    trap_id trap = tr_null;
    std::vector<map_tile_field_plan> fields;
};

struct map_tile_original_state {
    ter_id terrain;
    furn_id furniture;
    trap_id trap = tr_null;
    std::vector<map_tile_field_plan> fields;
};

struct resolved_map_tile {
    map *value = nullptr;
    tripoint_bub_ms local = tripoint_bub_ms::zero;
};

map_snapshot_options read_map_snapshot_options(
    const sol::optional<sol::table> &requested )
{
    map_snapshot_options result;
    if( !requested ) {
        return result;
    }
    constexpr std::string_view api_name = "services.map.snapshot";
    for( const auto &entry : *requested ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                std::string( api_name ) + " option keys must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        if( key == "field_limit" ) {
            result.field_limit = std::min(
                                     require_integer_option(
                                         entry.second, std::string( api_name ), key ),
                                     maximum_map_snapshot_field_limit );
        } else if( key == "signage_limit" ) {
            const int limit = require_integer_option(
                                  entry.second, std::string( api_name ), key );
            result.signage_limit = std::min<std::size_t>(
                                       static_cast<std::size_t>( limit ),
                                       maximum_map_snapshot_signage_bytes );
        } else {
            throw std::invalid_argument(
                std::string( api_name ) + " received unknown option '" + key + "'" );
        }
    }
    return result;
}

std::string read_map_tile_id(
    const sol::object &requested, const std::string &kind,
    const std::string &api_name )
{
    if( !requested.is<script_game_id>() ) {
        throw std::invalid_argument(
            api_name + " requires GameId<" + kind + ">" );
    }
    const script_game_id &id = requested.as<const script_game_id &>();
    require_id_kind( id, kind, api_name );
    return id.value();
}

std::string read_nested_map_tile_id(
    const sol::table &descriptor, const std::string &kind,
    const std::string &api_name )
{
    const sol::object id = descriptor.raw_get<sol::object>( "id" );
    if( !id.valid() || id.get_type() == sol::type::nil ) {
        throw std::invalid_argument(
            api_name + " requires an id" );
    }
    return read_map_tile_id( id, kind, api_name );
}

void require_map_tile_change_keys(
    const sol::table &descriptor,
    const std::set<std::string> &allowed,
    const std::string &api_name )
{
    for( const auto &entry : descriptor ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                api_name + " keys must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        if( allowed.count( key ) == 0 ) {
            throw std::invalid_argument(
                api_name + " received unknown field '" + key + "'" );
        }
    }
}

map_tile_field_change read_map_tile_field_change(
    const sol::table &descriptor, const std::string &api_name )
{
    require_map_tile_change_keys(
        descriptor, { "id", "intensity", "age", "hit_player", "remove" },
        api_name );
    map_tile_field_change result;
    result.id = read_nested_map_tile_id( descriptor, "field", api_name );
    const sol::object intensity = descriptor.raw_get<sol::object>( "intensity" );
    if( intensity.valid() && intensity.get_type() != sol::type::nil ) {
        if( !intensity.is<lua_Integer>() ) {
            throw std::invalid_argument(
                api_name + " intensity must be an integer" );
        }
        const lua_Integer value = intensity.as<lua_Integer>();
        if( value < 1 || value > std::numeric_limits<int>::max() ) {
            throw std::invalid_argument(
                api_name + " intensity is outside the native integer range" );
        }
        result.intensity = static_cast<int>( value );
    }
    const sol::object age = descriptor.raw_get<sol::object>( "age" );
    if( age.valid() && age.get_type() != sol::type::nil ) {
        if( !age.is<script_time_duration>() ) {
            throw std::invalid_argument(
                api_name + " age must be a TimeDuration" );
        }
        result.age = age.as<const script_time_duration &>().to_native();
    }
    if( result.age < 0_turns || result.age > maximum_field_age ) {
        throw std::invalid_argument(
            api_name + " age must be between zero turns and 365 days" );
    }
    const sol::object hit_player = descriptor.raw_get<sol::object>( "hit_player" );
    if( hit_player.valid() && hit_player.get_type() != sol::type::nil ) {
        if( !hit_player.is<bool>() ) {
            throw std::invalid_argument(
                api_name + " hit_player must be a boolean" );
        }
        result.hit_player = hit_player.as<bool>();
    }
    const sol::object remove = descriptor.raw_get<sol::object>( "remove" );
    if( remove.valid() && remove.get_type() != sol::type::nil ) {
        if( !remove.is<bool>() ) {
            throw std::invalid_argument(
                api_name + " remove must be a boolean" );
        }
        result.remove = remove.as<bool>();
    }
    if( result.remove && result.hit_player ) {
        throw std::invalid_argument(
            api_name + " remove cannot request hit_player" );
    }
    return result;
}

void append_map_tile_field_change(
    map_tile_changes &result, const map_tile_field_change &change,
    const std::string &api_name )
{
    const auto duplicate = std::find_if(
                               result.fields.begin(), result.fields.end(),
    [&change]( const map_tile_field_change & existing ) {
        return existing.id == change.id;
    } );
    if( duplicate != result.fields.end() ) {
        throw std::invalid_argument(
            api_name + " cannot change the same field more than once" );
    }
    if( result.fields.size() >= maximum_map_snapshot_field_limit ) {
        throw std::invalid_argument(
            api_name + " field changes exceed the 128-entry limit" );
    }
    result.fields.push_back( change );
}

void read_map_tile_field_changes(
    map_tile_changes &result, const sol::object &requested,
    const std::string &api_name )
{
    if( requested.get_type() != sol::type::table ) {
        throw std::invalid_argument(
            api_name + " must be a field descriptor or an array of descriptors" );
    }
    const sol::table values = requested.as<sol::table>();
    const sol::object id = values.raw_get<sol::object>( "id" );
    if( id.valid() && id.get_type() != sol::type::nil ) {
        append_map_tile_field_change(
            result, read_map_tile_field_change( values, api_name ), api_name );
        return;
    }
    const std::size_t count = require_dense_lua_array(
                                  values, api_name, 0,
                                  maximum_map_snapshot_field_limit );
    for( std::size_t index = 1; index <= count; ++index ) {
        const sol::object entry = values.raw_get<sol::object>( index );
        if( entry.get_type() != sol::type::table ) {
            throw std::invalid_argument(
                api_name + " array entries must be descriptor tables" );
        }
        append_map_tile_field_change(
            result,
            read_map_tile_field_change( entry.as<sol::table>(), api_name ),
            api_name );
    }
}

map_tile_changes read_map_tile_changes( const sol::table &requested )
{
    constexpr std::string_view api_name = "services.map.edit changes";
    map_tile_changes result;
    require_map_tile_change_keys(
    requested, {
        "terrain", "furniture", "furniture_clear", "trap", "trap_clear",
        "field", "fields", "remove_field"
    },
    std::string( api_name ) );
    for( const auto &entry : requested ) {
        const std::string key = entry.first.as<std::string>();
        const sol::object value = entry.second;
        if( key == "terrain" ) {
            result.terrain = read_map_tile_id(
                                 value, "terrain", std::string( api_name ) );
        } else if( key == "furniture" ) {
            if( value.get_type() == sol::type::table ) {
                const sol::table descriptor = value.as<sol::table>();
                require_map_tile_change_keys(
                    descriptor, { "id", "clear" },
                    std::string( api_name ) + " furniture" );
                const sol::object clear = descriptor.raw_get<sol::object>( "clear" );
                if( clear.valid() && clear.get_type() != sol::type::nil &&
                    ( !clear.is<bool>() || !clear.as<bool>() ) ) {
                    throw std::invalid_argument(
                        std::string( api_name ) + " furniture clear must be true" );
                }
                if( clear.valid() && clear.is<bool>() && clear.as<bool>() ) {
                    result.furniture_requested = true;
                    result.furniture.reset();
                } else {
                    result.furniture_requested = true;
                    result.furniture = read_nested_map_tile_id(
                                           descriptor, "furniture",
                                           std::string( api_name ) + " furniture" );
                }
            } else {
                result.furniture_requested = true;
                result.furniture = read_map_tile_id(
                                       value, "furniture", std::string( api_name ) );
            }
        } else if( key == "furniture_clear" ) {
            if( !value.is<bool>() || !value.as<bool>() ) {
                throw std::invalid_argument(
                    std::string( api_name ) + " furniture_clear must be true" );
            }
            result.furniture_requested = true;
            result.furniture.reset();
        } else if( key == "trap" ) {
            if( value.get_type() == sol::type::table ) {
                const sol::table descriptor = value.as<sol::table>();
                require_map_tile_change_keys(
                    descriptor, { "id", "clear" },
                    std::string( api_name ) + " trap" );
                const sol::object clear = descriptor.raw_get<sol::object>( "clear" );
                if( clear.valid() && clear.get_type() != sol::type::nil &&
                    ( !clear.is<bool>() || !clear.as<bool>() ) ) {
                    throw std::invalid_argument(
                        std::string( api_name ) + " trap clear must be true" );
                }
                if( clear.valid() && clear.is<bool>() && clear.as<bool>() ) {
                    result.trap_requested = true;
                    result.trap.reset();
                } else {
                    result.trap_requested = true;
                    result.trap = read_nested_map_tile_id(
                                      descriptor, "trap",
                                      std::string( api_name ) + " trap" );
                }
            } else {
                result.trap_requested = true;
                result.trap = read_map_tile_id(
                                  value, "trap", std::string( api_name ) );
            }
        } else if( key == "trap_clear" ) {
            if( !value.is<bool>() || !value.as<bool>() ) {
                throw std::invalid_argument(
                    std::string( api_name ) + " trap_clear must be true" );
            }
            result.trap_requested = true;
            result.trap.reset();
        } else if( key == "field" ) {
            read_map_tile_field_changes( result, value,
                                         std::string( api_name ) + " field" );
        } else if( key == "fields" ) {
            read_map_tile_field_changes( result, value,
                                         std::string( api_name ) + " fields" );
        } else if( key == "remove_field" ) {
            if( value.get_type() == sol::type::table ) {
                const sol::table values = value.as<sol::table>();
                const std::size_t count = require_dense_lua_array(
                                              values,
                                              std::string( api_name ) + " remove_field",
                                              0, maximum_map_snapshot_field_limit );
                for( std::size_t index = 1; index <= count; ++index ) {
                    const sol::object id = values.raw_get<sol::object>( index );
                    append_map_tile_field_change(
                    result, {
                        read_map_tile_id( id, "field", std::string( api_name ) +
                                          " remove_field" ), 1, 0_turns, false, true
                    },
                    std::string( api_name ) + " remove_field" );
                }
            } else {
                append_map_tile_field_change(
                result, {
                    read_map_tile_id( value, "field", std::string( api_name ) +
                                      " remove_field" ), 1, 0_turns, false, true
                },
                std::string( api_name ) + " remove_field" );
            }
        }
    }
    if( !result.terrain && !result.furniture_requested &&
        !result.trap_requested && result.fields.empty() ) {
        throw std::invalid_argument(
            std::string( api_name ) + " must contain at least one change" );
    }
    return result;
}

region_options read_region_options(
    const sol::optional<sol::table> &requested )
{
    region_options result;
    if( !requested ) {
        return result;
    }
    constexpr std::string_view api_name = "services.world.region";
    for( const auto &entry : *requested ) {
        const sol::object key_object = entry.first;
        if( key_object.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                std::string( api_name ) +
                " option keys must be strings" );
        }
        const std::string key =
            key_object.as<std::string>();
        const int number = key == "filters" ? 0 :
                           require_integer_option(
                               entry.second, std::string( api_name ), key );
        if( key != "filters" && number < 0 ) {
            throw std::invalid_argument(
                std::string( api_name ) + " numeric options cannot be negative" );
        }
        if( key == "radius" ) {
            result.radius =
                std::min( number, maximum_region_radius );
        } else if( key == "radius_z" ) {
            result.radius_z =
                std::min( number, maximum_region_radius_z );
        } else if( key == "offset" ) {
            result.offset = static_cast<std::size_t>(
                                std::min(
                                    number,
                                    static_cast<int>(
                                        maximum_offset ) ) );
        } else if( key == "limit" ) {
            result.limit =
                std::min( number, maximum_region_limit );
        } else {
            read_tile_option(
                result.tile, key, entry.second,
                std::string( api_name ) );
        }
    }
    return result;
}

map_item_options read_map_item_options(
    const sol::optional<sol::table> &requested )
{
    map_item_options result;
    if( !requested ) {
        return result;
    }
    constexpr std::string_view api_name =
        "services.world.items_nearby";
    for( const auto &entry : *requested ) {
        const sol::object key_object = entry.first;
        if( key_object.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                std::string( api_name ) +
                " option keys must be strings" );
        }
        const std::string key =
            key_object.as<std::string>();
        const int number = key == "filters" ? 0 :
                           require_integer_option(
                               entry.second, std::string( api_name ), key );
        if( key != "filters" && number < 0 ) {
            throw std::invalid_argument(
                std::string( api_name ) + " numeric options cannot be negative" );
        }
        if( key == "min_radius" ) {
            result.min_radius =
                std::min( number, maximum_location_search_radius );
        } else if( key == "max_radius" ) {
            result.max_radius =
                std::min( number, maximum_location_search_radius );
        } else if( key == "offset" ) {
            result.offset = static_cast<std::size_t>(
                                std::min(
                                    number,
                                    static_cast<int>(
                                        maximum_offset ) ) );
        } else if( key == "limit" ) {
            result.limit =
                std::min( number, maximum_map_item_limit );
        } else if( key == "filters" ) {
            if( entry.second.get_type() != sol::type::table ) {
                throw std::invalid_argument(
                    std::string( api_name ) + " filters must be a dense descriptor array" );
            }
            result.filters = entry.second.as<sol::table>();
        } else {
            throw std::invalid_argument(
                std::string( api_name ) +
                " received unknown option '" + key + "'" );
        }
    }
    if( result.min_radius > result.max_radius ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " min_radius cannot exceed max_radius" );
    }
    return result;
}

map_item_options read_point_page_options(
    const sol::optional<sol::table> &requested )
{
    map_item_options result;
    if( !requested ) {
        return result;
    }
    constexpr std::string_view api_name =
        "services.world.points_nearby";
    for( const auto &entry : *requested ) {
        const sol::object key_object = entry.first;
        if( key_object.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                std::string( api_name ) +
                " option keys must be strings" );
        }
        const std::string key =
            key_object.as<std::string>();
        const int number =
            require_integer_option(
                entry.second, std::string( api_name ), key );
        if( key != "filters" && number < 0 ) {
            throw std::invalid_argument(
                std::string( api_name ) + " numeric options cannot be negative" );
        }
        if( key == "min_radius" ) {
            result.min_radius =
                std::min( number, maximum_location_search_radius );
        } else if( key == "max_radius" ) {
            result.max_radius =
                std::min( number, maximum_location_search_radius );
        } else if( key == "offset" ) {
            result.offset = static_cast<std::size_t>(
                                std::min(
                                    number,
                                    static_cast<int>(
                                        maximum_offset ) ) );
        } else if( key == "limit" ) {
            result.limit =
                std::min( number, maximum_map_item_limit );
        } else {
            throw std::invalid_argument(
                std::string( api_name ) +
                " received unknown option '" + key + "'" );
        }
    }
    if( result.min_radius > result.max_radius ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " min_radius cannot exceed max_radius" );
    }
    return result;
}

vehicle_options read_vehicle_options(
    const sol::optional<sol::table> &requested )
{
    vehicle_options result;
    if( !requested ) {
        return result;
    }
    constexpr std::string_view api_name =
        "services.world.vehicles";
    for( const auto &entry : *requested ) {
        const sol::object key_object = entry.first;
        if( key_object.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                std::string( api_name ) +
                " option keys must be strings" );
        }
        const std::string key =
            key_object.as<std::string>();
        const int number =
            require_integer_option(
                entry.second, std::string( api_name ), key );
        if( number < 0 ) {
            throw std::invalid_argument(
                std::string( api_name ) + " numeric options cannot be negative" );
        }
        if( key == "offset" ) {
            result.offset = static_cast<std::size_t>(
                                std::min(
                                    number,
                                    static_cast<int>(
                                        maximum_offset ) ) );
        } else if( key == "limit" ) {
            result.limit =
                std::min( number, maximum_vehicle_limit );
        } else {
            throw std::invalid_argument(
                std::string( api_name ) +
                " received unknown option '" + key + "'" );
        }
    }
    return result;
}

int read_location_integer(
    const sol::object &value, const std::string &key,
    const int minimum, const int maximum )
{
    constexpr std::string_view api_name =
        "services.world.find_location";
    if( !value.is<lua_Integer>() ) {
        throw std::invalid_argument(
            std::string( api_name ) + " option '" + key +
            "' must be an integer" );
    }
    const lua_Integer number = value.as<lua_Integer>();
    if( number < minimum || number > maximum ) {
        throw std::invalid_argument(
            std::string( api_name ) + " option '" + key +
            "' must be within " + std::to_string( minimum ) + ".." +
            std::to_string( maximum ) );
    }
    return static_cast<int>( number );
}

bool read_location_bool(
    const sol::object &value, const std::string &key )
{
    if( !value.is<bool>() ) {
        throw std::invalid_argument(
            "services.world.find_location option '" + key +
            "' must be a boolean" );
    }
    return value.as<bool>();
}

location_selector read_location_selector(
    const sol::optional<sol::table> &requested )
{
    location_selector result;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "services.world.find_location selector keys must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        if( key != "kind" && key != "id" ) {
            throw std::invalid_argument(
                "services.world.find_location received unknown selector '" +
                key + "'" );
        }
    }
    const sol::object kind_value = ( *requested )["kind"];
    if( !kind_value.is<std::string>() ) {
        throw std::invalid_argument(
            "services.world.find_location selector 'kind' must be a string" );
    }
    const std::string kind = kind_value.as<std::string>();
    std::string id_kind;
    if( kind == "terrain" ) {
        result.kind = location_selector_kind::terrain;
        id_kind = "terrain";
    } else if( kind == "furniture" ) {
        result.kind = location_selector_kind::furniture;
        id_kind = "furniture";
    } else if( kind == "field" ) {
        result.kind = location_selector_kind::field;
        id_kind = "field";
    } else if( kind == "trap" ) {
        result.kind = location_selector_kind::trap;
        id_kind = "trap";
    } else if( kind == "monster" ) {
        result.kind = location_selector_kind::monster;
        id_kind = "monster";
    } else if( kind == "species" ) {
        result.kind = location_selector_kind::species;
        id_kind = "species";
    } else if( kind == "npc" ) {
        result.kind = location_selector_kind::npc;
        id_kind = "npc_class";
    } else if( kind == "zone" ) {
        result.kind = location_selector_kind::zone;
        id_kind = "zone";
    } else {
        throw std::invalid_argument(
            "services.world.find_location selector 'kind' must be terrain, furniture, field, trap, monster, species, npc, or zone" );
    }
    const sol::object id_value = ( *requested )["id"];
    if( id_value.valid() && id_value.get_type() != sol::type::nil ) {
        if( !id_value.is<script_game_id>() ) {
            throw std::invalid_argument(
                "services.world.find_location selector 'id' must be a GameId" );
        }
        const script_game_id id = id_value.as<script_game_id>();
        require_id_kind(
            id, id_kind,
            "services.world.find_location selector 'id'" );
        result.id = id;
    }
    return result;
}

location_search_options read_location_search_options(
    const sol::optional<sol::table> &requested )
{
    location_search_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "services.world.find_location option keys must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        const sol::object value = entry.second;
        if( key == "min_radius" ) {
            result.min_radius = read_location_integer(
                                    value, key, 0,
                                    maximum_location_search_radius );
        } else if( key == "max_radius" ) {
            result.max_radius = read_location_integer(
                                    value, key, 0,
                                    maximum_location_search_radius );
        } else if( key == "target_min_radius" ) {
            result.target_min_radius = read_location_integer(
                                           value, key, 0,
                                           maximum_location_search_radius );
        } else if( key == "target_max_radius" ) {
            result.target_max_radius = read_location_integer(
                                           value, key, 0,
                                           maximum_location_search_radius );
        } else if( key == "random_attempts" ) {
            result.random_attempts = read_location_integer(
                                         value, key, 1,
                                         maximum_location_random_attempts );
        } else if( key == "x_adjust" ) {
            result.x_adjust = read_location_integer(
                                  value, key,
                                  -maximum_location_adjustment,
                                  maximum_location_adjustment );
        } else if( key == "y_adjust" ) {
            result.y_adjust = read_location_integer(
                                  value, key,
                                  -maximum_location_adjustment,
                                  maximum_location_adjustment );
        } else if( key == "z_adjust" ) {
            result.z_adjust = read_location_integer(
                                  value, key, -OVERMAP_DEPTH,
                                  OVERMAP_HEIGHT );
        } else if( key == "z_override" ) {
            result.z_override = read_location_bool( value, key );
        } else if( key == "outdoor_only" ) {
            result.outdoor_only = read_location_bool( value, key );
        } else if( key == "passable_only" ) {
            result.passable_only = read_location_bool( value, key );
        } else {
            throw std::invalid_argument(
                "services.world.find_location received unknown option '" +
                key + "'" );
        }
    }
    if( result.min_radius > result.max_radius ) {
        throw std::invalid_argument(
            "services.world.find_location min_radius cannot exceed max_radius" );
    }
    if( result.target_min_radius > result.target_max_radius ) {
        throw std::invalid_argument(
            "services.world.find_location target_min_radius cannot exceed target_max_radius" );
    }
    return result;
}

game_handle make_map_item_handle(
    item &entry, const tripoint_abs_ms &position,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    game_handle_locator locator;
    locator.scope = "map";
    locator.stable_id = entry.uid().get_value();
    locator.x = position.x();
    locator.y = position.y();
    locator.z = position.z();
    return game_handle::from_item(
               entry, std::move( locator ),
               runtime_generation, world_generation );
}

game_handle make_vehicle_handle(
    vehicle &entry, const tripoint_abs_ms &position,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    game_handle_locator locator;
    locator.scope = "map_vehicle";
    locator.x = position.x();
    locator.y = position.y();
    locator.z = position.z();
    return game_handle::from_vehicle(
               entry, std::move( locator ),
               runtime_generation, world_generation );
}

sol::table snapshot_fields(
    sol::state_view lua, const field &entries,
    const int limit )
{
    std::vector<const field_entry *> ordered;
    ordered.reserve( entries.field_count() );
    for( const auto &pair : entries ) {
        ordered.push_back( &pair.second );
    }
    std::sort(
        ordered.begin(), ordered.end(),
    []( const field_entry * lhs, const field_entry * rhs ) {
        return lhs->get_field_type().id().str() <
               rhs->get_field_type().id().str();
    } );

    const std::size_t returned = std::min(
                                     ordered.size(),
                                     static_cast<std::size_t>( limit ) );
    sol::table items = lua.create_table(
                           static_cast<int>( returned ), 0 );
    for( std::size_t index = 0; index < returned; ++index ) {
        const field_entry &entry = *ordered[index];
        sol::table value = lua.create_table();
        value["id"] = script_game_id(
                          "field",
                          entry.get_field_type().id().str() );
        value["name"] = entry.name();
        value["intensity"] =
            entry.get_field_intensity();
        value["maximum_intensity"] =
            entry.get_max_field_intensity();
        value["age"] =
            script_time_duration::from_native(
                entry.get_field_age() );
        value["dangerous"] = entry.is_dangerous();
        value["mop_safe"] = entry.is_mopsafe();
        items[index + 1] = std::move( value );
    }
    sol::table result = lua.create_table();
    result["items"] = std::move( items );
    result["total"] = ordered.size();
    result["returned"] = returned;
    result["limit"] = limit;
    result["truncated"] = returned < ordered.size();
    return result;
}

sol::table snapshot_items(
    sol::state_view lua, map_stack entries,
    const tripoint_abs_ms &position, const int limit,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const std::size_t total = entries.size();
    const std::size_t returned = std::min(
                                     total,
                                     static_cast<std::size_t>( limit ) );
    sol::table items = lua.create_table(
                           static_cast<int>( returned ), 0 );
    std::size_t index = 0;
    for( item &entry : entries ) {
        if( index >= returned ) {
            break;
        }
        sol::table value = lua.create_table();
        value["handle"] = make_map_item_handle(
                              entry, position,
                              runtime_generation,
                              world_generation );
        value["uid"] = entry.uid().get_value();
        value["id"] = script_game_id(
                          "item", entry.typeId().str() );
        value["name"] = entry.tname();
        value["charges"] = entry.charges;
        value["count_by_charges"] =
            entry.count_by_charges();
        value["active"] = entry.active;
        items[index + 1] = std::move( value );
        ++index;
    }
    sol::table result = lua.create_table();
    result["items"] = std::move( items );
    result["total"] = total;
    result["returned"] = returned;
    result["limit"] = limit;
    result["truncated"] = returned < total;
    return result;
}

sol::table snapshot_vehicle_at(
    sol::state_view lua, map &here,
    const tripoint_bub_ms &position,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::table result = lua.create_table();
    const optional_vpart_position found =
        here.veh_at( position );
    if( !found ) {
        result["present"] = false;
        return result;
    }
    vehicle &entry = found->vehicle();
    const tripoint_abs_ms absolute =
        found->pos_abs();
    result["present"] = true;
    result["handle"] = make_vehicle_handle(
                           entry, absolute,
                           runtime_generation,
                           world_generation );
    result["name"] = entry.disp_name();
    result["prototype"] = entry.type.str();
    result["position"] =
        script_tripoint_coord::from_native(
            coords::origin::abs,
            coords::scale::map_square,
            absolute.raw() );
    result["part_index"] =
        static_cast<std::size_t>(
            found->part_index() );
    result["inside"] = found->is_inside();
    if( const std::optional<std::string> label =
            found->get_label() ) {
        result["label"] = *label;
    } else {
        result["label"] = sol::nil;
    }
    return result;
}

std::string location_selector_name(
    const location_selector_kind kind )
{
    switch( kind ) {
        case location_selector_kind::terrain:
            return "terrain";
        case location_selector_kind::furniture:
            return "furniture";
        case location_selector_kind::field:
            return "field";
        case location_selector_kind::trap:
            return "trap";
        case location_selector_kind::monster:
            return "monster";
        case location_selector_kind::species:
            return "species";
        case location_selector_kind::npc:
            return "npc";
        case location_selector_kind::zone:
            return "zone";
        case location_selector_kind::none:
            break;
    }
    return "none";
}

bool location_matches_selector(
    map &here, const tripoint_bub_ms &position,
    const location_selector &selector,
    const std::vector<shared_ptr_fast<npc>> &nearby_npcs )
{
    const tripoint_abs_ms absolute = here.get_abs( position );
    const std::optional<std::string> requested =
        selector.id ?
        std::optional<std::string>( selector.id->value() ) :
        std::nullopt;
    switch( selector.kind ) {
        case location_selector_kind::terrain:
            return !requested ||
                   here.ter( position ).id().str() == *requested;
        case location_selector_kind::furniture: {
            const furn_str_id id = here.furn( position ).id();
            return requested ? id.str() == *requested : !id.is_null();
        }
        case location_selector_kind::field: {
            field &fields = here.field_at( position );
            return requested ?
                   fields.find_field( field_type_id( *requested ) ) != nullptr :
                   fields.field_count() > 0;
        }
        case location_selector_kind::trap: {
            const trap &entry = here.tr_at( position );
            return requested ? entry.id.str() == *requested : !entry.is_null();
        }
        case location_selector_kind::monster: {
            const monster *entry =
                get_creature_tracker().creature_at<monster>( absolute, true );
            return entry != nullptr &&
                   ( !requested || entry->type->id.str() == *requested );
        }
        case location_selector_kind::species: {
            const monster *entry =
                get_creature_tracker().creature_at<monster>( absolute, true );
            return entry != nullptr &&
                   ( !requested || entry->in_species( species_id( *requested ) ) );
        }
        case location_selector_kind::npc:
            return std::any_of(
                       nearby_npcs.begin(), nearby_npcs.end(),
            [&]( const shared_ptr_fast<npc> &entry ) {
                return entry && entry->pos_abs() == absolute &&
                       ( !requested || entry->myclass.str() == *requested );
            } );
        case location_selector_kind::zone: {
            const zone_manager &zones = zone_manager::get_manager();
            return requested ?
                   zones.get_zone_at(
                       absolute, zone_type_id( *requested ) ) != nullptr :
                   zones.get_zone_at( absolute, false ) != nullptr;
        }
        case location_selector_kind::none:
            return true;
    }
    return false;
}

sol::table find_world_location(
    sol::this_state lua,
    const script_tripoint_coord &requested_origin,
    const sol::optional<sol::table> &requested_selector,
    const sol::optional<sol::table> &requested_options )
{
    constexpr std::string_view api_name =
        "services.world.find_location";
    const tripoint_abs_ms origin = require_absolute_ms(
                                       requested_origin,
                                       std::string( api_name ) );
    const location_selector selector =
        read_location_selector( requested_selector );
    const location_search_options options =
        read_location_search_options( requested_options );

    map &active_map = get_map();
    map *selected_map = &active_map;
    std::unique_ptr<map> distant_map;
    const bool distant = !active_map.inbounds( origin );
    if( distant ) {
        distant_map = std::make_unique<map>();
        distant_map->load(
            project_to<coords::sm>( origin ), false );
        selected_map = distant_map.get();
    }
    map &here = *selected_map;
    const bool spawned_nonlocal_monsters =
        distant &&
        ( selector.kind == location_selector_kind::monster ||
          selector.kind == location_selector_kind::species );
    if( spawned_nonlocal_monsters ) {
        here.spawn_monsters( true, true );
    }
    on_out_of_scope cleanup_nonlocal_monsters( [spawned_nonlocal_monsters]() {
        if( spawned_nonlocal_monsters && g != nullptr ) {
            g->despawn_nonlocal_monsters();
        }
    } );
    sol::state_view state( lua );
    sol::table result = state.create_table();
    result["found"] = false;
    result["selector"] = location_selector_name( selector.kind );
    result["distant_map"] = distant;
    result["origin"] = script_tripoint_coord::from_native(
                           coords::origin::abs,
                           coords::scale::map_square,
                           origin.raw() );
    if( !here.inbounds( origin ) ) {
        result["reason"] = "origin_not_loaded";
        result["position"] = sol::nil;
        return result;
    }

    tripoint_abs_ms anchor = origin;
    if( selector.kind != location_selector_kind::none ) {
        std::vector<shared_ptr_fast<npc>> nearby_npcs;
        if( selector.kind == location_selector_kind::npc ) {
            const int submap_radius = std::max(
                                          1,
                                          options.target_max_radius / SEEX + 1 );
            nearby_npcs = overmap_buffer.get_npcs_near(
                              project_to<coords::sm>( origin ),
                              submap_radius );
        }
        const tripoint_bub_ms center = here.get_bub( origin );
        bool matched = false;
        for( const tripoint_bub_ms &position :
             here.points_in_radius(
                 center,
                 static_cast<std::size_t>(
                     options.target_max_radius ), 0 ) ) {
            const int distance = rl_dist( center, position );
            if( distance <= options.target_min_radius ) {
                continue;
            }
            if( location_matches_selector(
                    here, position, selector, nearby_npcs ) ) {
                anchor = here.get_abs( position );
                matched = true;
                break;
            }
        }
        if( !matched ) {
            result["reason"] = "selector_not_found";
            result["position"] = sol::nil;
            return result;
        }
    }

    tripoint_abs_ms selected = anchor;
    if( options.max_radius > 0 ) {
        bool found_random = false;
        for( int attempt = 0;
             attempt < options.random_attempts; ++attempt ) {
            const tripoint_abs_ms candidate =
                anchor + tripoint_rel_ms(
                    rng( -options.max_radius,
                         options.max_radius ),
                    rng( -options.max_radius,
                         options.max_radius ), 0 );
            if( rl_dist( anchor, candidate ) <
                options.min_radius ||
                !here.inbounds( candidate ) ) {
                continue;
            }
            const tripoint_bub_ms local =
                here.get_bub( candidate );
            if( options.outdoor_only &&
                !here.is_outside( local ) ) {
                continue;
            }
            if( options.passable_only &&
                !here.passable_through( local ) ) {
                continue;
            }
            selected = candidate;
            found_random = true;
            break;
        }
        if( !found_random ) {
            result["reason"] = "no_valid_random_position";
            result["position"] = sol::nil;
            return result;
        }
    }

    selected = selected + tripoint_rel_ms(
                   options.x_adjust,
                   options.y_adjust, 0 );
    if( options.z_override ) {
        selected = tripoint_abs_ms(
                       selected.xy(), options.z_adjust );
    } else {
        selected = selected + tripoint_rel_ms(
                       0, 0, options.z_adjust );
    }
    if( selected.z() < -OVERMAP_DEPTH ||
        selected.z() > OVERMAP_HEIGHT ) {
        result["reason"] = "z_out_of_bounds";
        result["position"] = sol::nil;
        return result;
    }
    result["found"] = true;
    result["reason"] = sol::nil;
    result["anchor"] = script_tripoint_coord::from_native(
                           coords::origin::abs,
                           coords::scale::map_square,
                           anchor.raw() );
    result["position"] = script_tripoint_coord::from_native(
                             coords::origin::abs,
                             coords::scale::map_square,
                             selected.raw() );
    result["distance_from_origin"] =
        rl_dist( origin, selected );
    return result;
}

sol::table snapshot_tile(
    sol::state_view lua, map &here,
    const tripoint_bub_ms &position,
    const tile_options &options,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const tripoint_abs_ms absolute =
        here.get_abs( position );
    const ter_id terrain = here.ter( position );
    const furn_id furniture = here.furn( position );
    const trap &trap_at_position =
        here.tr_at( position );
    sol::table result = lua.create_table();
    result["position"] =
        script_tripoint_coord::from_native(
            coords::origin::abs,
            coords::scale::map_square,
            absolute.raw() );
    result["terrain"] = script_game_id(
                            "terrain",
                            terrain.id().str() );
    result["terrain_name"] =
        here.tername( position );
    if( furniture.id().is_null() ) {
        result["furniture"] = sol::nil;
        result["furniture_name"] = sol::nil;
    } else {
        result["furniture"] = script_game_id(
                                  "furniture",
                                  furniture.id().str() );
        result["furniture_name"] =
            here.furnname( position );
    }
    if( trap_at_position.is_null() ) {
        result["trap"] = sol::nil;
        result["trap_name"] = sol::nil;
        result["trap_benign"] = sol::nil;
    } else {
        result["trap"] = script_game_id(
                             "trap",
                             trap_at_position.id.str() );
        result["trap_name"] =
            trap_at_position.name();
        result["trap_benign"] =
            trap_at_position.is_benign();
    }
    result["outside"] =
        here.is_outside( position );
    result["passable"] =
        here.passable( position );
    result["move_cost"] =
        here.move_cost( position );
    result["ambient_light"] =
        here.ambient_light_at( position );
    result["light_level"] =
        static_cast<int>( here.light_at( position ) );
    result["dangerous_field"] =
        here.dangerous_field_at( position );
    result["fields"] = snapshot_fields(
                           lua, here.field_at( position ),
                           options.field_limit );
    result["items"] = snapshot_items(
                          lua, here.i_at( position ),
                          absolute, options.item_limit,
                          runtime_generation,
                          world_generation );
    result["vehicle"] = snapshot_vehicle_at(
                            lua, here, position,
                            runtime_generation,
                            world_generation );
    return result;
}

sol::table world_bounds( sol::this_state lua )
{
    map &here = get_map();
    const int size = here.getmapsize() * SEEX;
    const int z = get_avatar().pos_bub().z();
    const tripoint_abs_ms minimum =
        here.get_abs( tripoint_bub_ms( 0, 0, z ) );
    const tripoint_abs_ms maximum =
        here.get_abs(
            tripoint_bub_ms(
                size - 1, size - 1, z ) );
    sol::state_view state( lua );
    sol::table result = state.create_table();
    result["minimum"] =
        script_tripoint_coord::from_native(
            coords::origin::abs,
            coords::scale::map_square,
            minimum.raw() );
    result["maximum"] =
        script_tripoint_coord::from_native(
            coords::origin::abs,
            coords::scale::map_square,
            maximum.raw() );
    result["map_squares"] = size;
    result["submaps"] = here.getmapsize();
    result["z"] = z;
    return result;
}

sol::table world_region(
    sol::this_state lua,
    const script_tripoint_coord &center,
    const sol::optional<sol::table> &requested_options,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    map &here = get_map();
    const tripoint_bub_ms local_center =
        require_loaded_position(
            here, center, "services.world.region" );
    const region_options options =
        read_region_options( requested_options );
    std::vector<tripoint_bub_ms> positions;
    for( const tripoint_bub_ms &position :
         here.points_in_radius(
             local_center, options.radius,
             options.radius_z ) ) {
        if( here.inbounds( position ) ) {
            positions.push_back( position );
        }
    }
    std::sort(
        positions.begin(), positions.end(),
        [&here]( const tripoint_bub_ms & lhs,
    const tripoint_bub_ms & rhs ) {
        const tripoint_abs_ms left = here.get_abs( lhs );
        const tripoint_abs_ms right = here.get_abs( rhs );
        if( left.z() != right.z() ) {
            return left.z() < right.z();
        }
        if( left.y() != right.y() ) {
            return left.y() < right.y();
        }
        return left.x() < right.x();
    } );
    const std::size_t offset =
        std::min( options.offset, positions.size() );
    const std::size_t returned = std::min(
                                     positions.size() - offset,
                                     static_cast<std::size_t>(
                                         options.limit ) );
    sol::state_view state( lua );
    sol::table items = state.create_table(
                           static_cast<int>( returned ), 0 );
    for( std::size_t index = 0; index < returned; ++index ) {
        items[index + 1] = snapshot_tile(
                               state, here,
                               positions[offset + index],
                               options.tile,
                               runtime_generation,
                               world_generation );
    }
    sol::table result = state.create_table();
    result["items"] = std::move( items );
    result["total"] = positions.size();
    result["offset"] = offset;
    result["limit"] = options.limit;
    result["returned"] = returned;
    result["has_more"] =
        offset + returned < positions.size();
    result["radius"] = options.radius;
    result["radius_z"] = options.radius_z;
    return result;
}

sol::table world_points_nearby(
    sol::this_state lua,
    const script_tripoint_coord &origin,
    const sol::optional<sol::table> &requested_options )
{
    constexpr std::string_view api_name =
        "services.world.points_nearby";
    if( origin.native_origin() != coords::origin::abs ||
        origin.native_scale() != coords::scale::map_square ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires an absolute map-square Tripoint" );
    }
    const map_item_options options =
        read_point_page_options(
            requested_options );
    const tripoint_abs_ms center(
        origin.to_native() );
    const std::vector<tripoint_abs_ms> positions =
        closest_points_first(
            center, options.min_radius,
            options.max_radius );
    const std::size_t first =
        std::min( options.offset, positions.size() );
    const std::size_t last =
        std::min<std::size_t>(
            first + options.limit,
            positions.size() );
    sol::state_view state( lua );
    sol::table items = state.create_table(
                           static_cast<int>( last - first ), 0 );
    for( std::size_t index = first;
         index < last; ++index ) {
        sol::table value = state.create_table();
        value["position"] =
            script_tripoint_coord::from_native(
                coords::origin::abs,
                coords::scale::map_square,
                positions[index].raw() );
        value["distance"] =
            rl_dist( center, positions[index] );
        items[index - first + 1] =
            std::move( value );
    }
    sol::table result = state.create_table();
    result["items"] = std::move( items );
    result["origin"] = origin;
    result["min_radius"] = options.min_radius;
    result["max_radius"] = options.max_radius;
    result["offset"] = options.offset;
    result["limit"] = options.limit;
    result["total"] = positions.size();
    result["returned"] = last - first;
    result["has_more"] = last < positions.size();
    return result;
}

sol::table world_items_nearby(
    sol::this_state lua,
    const script_tripoint_coord &origin,
    const sol::optional<sol::table> &requested_options,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name =
        "services.world.items_nearby";
    map &here = get_map();
    const tripoint_bub_ms center =
        require_loaded_position(
            here, origin, std::string( api_name ) );
    const map_item_options options =
        read_map_item_options( requested_options );
    std::vector<sol::table> filters;
    if( options.filters ) {
        const std::size_t count = require_dense_lua_array(
                                      *options.filters, "services.world.items_nearby filters", 0, 128 );
        filters.reserve( count );
        for( std::size_t index = 1; index <= count; ++index ) {
            const sol::object descriptor = options.filters->raw_get<sol::object>( index );
            if( !descriptor.is<sol::table>() ) {
                throw std::invalid_argument(
                    "services.world.items_nearby filters must contain descriptor tables" );
            }
            filters.push_back( descriptor.as<sol::table>() );
        }
    }

    struct match {
        item *value = nullptr;
        tripoint_abs_ms position = tripoint_abs_ms::zero;
        int distance = 0;
    };
    std::vector<match> matches;
    for( const tripoint_bub_ms &position :
         here.points_in_radius(
             center, options.max_radius ) ) {
        if( !here.inbounds( position ) ) {
            continue;
        }
        const int distance =
            rl_dist( center, position );
        if( distance < options.min_radius ) {
            continue;
        }
        const tripoint_abs_ms absolute =
            here.get_abs( position );
        for( item &entry : here.i_at( position ) ) {
            if( !filters.empty() && std::none_of( filters.begin(), filters.end(),
            [&entry]( const sol::table & descriptor ) {
            return map_item_matches_filter( entry, descriptor );
            } ) ) {
                continue;
            }
            matches.push_back( {
                &entry, absolute, distance
            } );
        }
    }
    std::sort(
        matches.begin(), matches.end(),
    []( const match & lhs, const match & rhs ) {
        if( lhs.position.z() != rhs.position.z() ) {
            return lhs.position.z() < rhs.position.z();
        }
        if( lhs.position.y() != rhs.position.y() ) {
            return lhs.position.y() < rhs.position.y();
        }
        if( lhs.position.x() != rhs.position.x() ) {
            return lhs.position.x() < rhs.position.x();
        }
        return lhs.value->uid().get_value() <
               rhs.value->uid().get_value();
    } );

    const std::size_t first =
        std::min( options.offset, matches.size() );
    const std::size_t last =
        std::min<std::size_t>(
            first + options.limit,
            matches.size() );
    sol::state_view state( lua );
    sol::table items = state.create_table(
                           static_cast<int>( last - first ), 0 );
    for( std::size_t index = first;
         index < last; ++index ) {
        const match &found = matches[index];
        item &entry = *found.value;
        sol::table value = state.create_table();
        value["handle"] = make_map_item_handle(
                              entry, found.position,
                              runtime_generation,
                              world_generation );
        value["uid"] = entry.uid().get_value();
        value["id"] = script_game_id(
                          "item", entry.typeId().str() );
        value["name"] = entry.tname();
        value["position"] =
            script_tripoint_coord::from_native(
                coords::origin::abs,
                coords::scale::map_square,
                found.position.raw() );
        value["distance"] = found.distance;
        value["charges"] = entry.charges;
        value["count_by_charges"] =
            entry.count_by_charges();
        value["active"] = entry.active;
        items[index - first + 1] =
            std::move( value );
    }
    sol::table result = state.create_table();
    result["items"] = std::move( items );
    result["origin"] = origin;
    result["min_radius"] = options.min_radius;
    result["max_radius"] = options.max_radius;
    result["offset"] = options.offset;
    result["limit"] = options.limit;
    result["total"] = matches.size();
    result["returned"] = last - first;
    result["has_more"] = last < matches.size();
    return result;
}

sol::table world_vehicles(
    sol::this_state lua,
    const sol::optional<sol::table> &requested_options,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const vehicle_options options =
        read_vehicle_options( requested_options );
    map &here = get_map();
    VehicleList entries = here.get_vehicles();
    entries.erase(
        std::remove_if(
            entries.begin(), entries.end(),
    []( const wrapped_vehicle & entry ) {
        return entry.v == nullptr;
    } ),
    entries.end() );
    std::sort(
        entries.begin(), entries.end(),
        [&here]( const wrapped_vehicle & lhs,
    const wrapped_vehicle & rhs ) {
        const tripoint_abs_ms left =
            here.get_abs( lhs.pos );
        const tripoint_abs_ms right =
            here.get_abs( rhs.pos );
        if( left.z() != right.z() ) {
            return left.z() < right.z();
        }
        if( left.y() != right.y() ) {
            return left.y() < right.y();
        }
        return left.x() < right.x();
    } );
    const std::size_t offset =
        std::min( options.offset, entries.size() );
    const std::size_t returned = std::min(
                                     entries.size() - offset,
                                     static_cast<std::size_t>(
                                         options.limit ) );
    sol::state_view state( lua );
    sol::table items = state.create_table(
                           static_cast<int>( returned ), 0 );
    for( std::size_t index = 0; index < returned; ++index ) {
        const wrapped_vehicle &wrapped =
            entries[offset + index];
        vehicle &entry = *wrapped.v;
        const tripoint_abs_ms position =
            here.get_abs( wrapped.pos );
        sol::table value = state.create_table();
        value["handle"] = make_vehicle_handle(
                              entry, position,
                              runtime_generation,
                              world_generation );
        value["name"] = entry.disp_name();
        value["prototype"] = entry.type.str();
        value["position"] =
            script_tripoint_coord::from_native(
                coords::origin::abs,
                coords::scale::map_square,
                position.raw() );
        items[index + 1] = std::move( value );
    }
    sol::table result = state.create_table();
    result["items"] = std::move( items );
    result["total"] = entries.size();
    result["offset"] = offset;
    result["limit"] = options.limit;
    result["returned"] = returned;
    result["has_more"] =
        offset + returned < entries.size();
    return result;
}

sol::table transform_line(
    sol::this_state lua,
    const script_tripoint_coord &first_position,
    const script_tripoint_coord &second_position,
    const script_game_id &requested_transform )
{
    constexpr std::string_view api_name =
        "services.world.transform_line";
    require_id_kind(
        requested_transform, "terrain_furniture_transform",
        std::string( api_name ) );
    map &here = get_map();
    const tripoint_bub_ms first = require_loaded_position(
                                      here, first_position,
                                      std::string( api_name ) );
    const tripoint_bub_ms second = require_loaded_position(
                                       here, second_position,
                                       std::string( api_name ) );
    const int length = std::max( {
        std::abs( first.x() - second.x() ),
        std::abs( first.y() - second.y() ),
        std::abs( first.z() - second.z() )
    } ) + 1;
    if( length > maximum_transform_line_length ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " line length exceeds the 4096-tile limit" );
    }
    const tripoint_abs_ms first_absolute =
        here.get_abs( first );
    const tripoint_abs_ms second_absolute =
        here.get_abs( second );
    const std::vector<tripoint_abs_ms> points =
        line_to( first_absolute, second_absolute );
    std::vector<std::pair<ter_str_id, furn_str_id>> before;
    before.reserve( points.size() );
    for( const tripoint_abs_ms &point : points ) {
        const tripoint_bub_ms local = here.get_bub( point );
        before.emplace_back( here.ter( local ).id(), here.furn( local ).id() );
    }
    const ter_furn_transform_id transform( requested_transform.value() );
    here.transform_line( transform, first_absolute, second_absolute );
    std::size_t changed = 0;
    for( std::size_t index = 0; index < points.size(); ++index ) {
        const tripoint_bub_ms local = here.get_bub( points[index] );
        if( before[index].first != here.ter( local ).id() ||
            before[index].second != here.furn( local ).id() ) {
            ++changed;
        }
    }
    sol::state_view state( lua );
    sol::table value = state.create_table();
    value["first"] = first_position;
    value["second"] = second_position;
    value["tiles"] = points.size();
    value["changed"] = changed;
    value["transform"] = requested_transform;
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

sol::table emit_field_at(
    sol::this_state lua,
    const script_tripoint_coord &position,
    const std::string &requested_emission,
    const sol::optional<double> &requested_chance )
{
    constexpr std::string_view api_name =
        "services.world.emit";
    const emit_id emission( requested_emission );
    if( requested_emission.empty() ||
        requested_emission.size() > 256 ||
        !emission.is_valid() ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires a valid bounded emission id" );
    }
    const double chance = requested_chance.value_or( 1.0 );
    if( !std::isfinite( chance ) ||
        chance < 0.0 || chance > 1000.0 ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " chance must be finite and within 0..1000" );
    }
    map &here = get_map();
    const tripoint_bub_ms local =
        require_loaded_position(
            here, position, std::string( api_name ) );
    here.emit_field(
        local, emission, static_cast<float>( chance ) );
    sol::state_view state( lua );
    sol::table value = state.create_table();
    value["emission"] = requested_emission;
    value["position"] = position;
    value["chance"] = chance;
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

sol::table spawn_item(
    sol::this_state lua,
    const script_tripoint_coord &position,
    const script_game_id &requested,
    const std::int64_t quantity,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name =
        "services.world.spawn_item";
    require_id_kind(
        requested, "item", std::string( api_name ) );
    if( quantity <= 0 ||
        quantity > maximum_spawn_quantity ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " quantity is outside its limit" );
    }
    map &here = get_map();
    const tripoint_bub_ms local =
        require_loaded_position(
            here, position, std::string( api_name ) );
    const tripoint_abs_ms absolute =
        here.get_abs( local );
    const itype_id native( requested.value() );
    const item prototype( native, calendar::turn );
    const bool count_by_charges =
        prototype.count_by_charges();
    if( !count_by_charges &&
        quantity > maximum_spawn_instances ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " cannot create more than 100 item instances at once" );
    }
    const int attempts = count_by_charges ? 1 :
                         static_cast<int>( quantity );
    sol::state_view state( lua );
    sol::table items = state.create_table( attempts, 0 );
    int returned = 0;
    std::int64_t added_quantity = 0;
    for( int index = 0; index < attempts; ++index ) {
        item created(
            native, calendar::turn,
            count_by_charges ?
            static_cast<int>( quantity ) : -1 );
        item_location added =
            here.add_item_or_charges_ret_loc(
                local, std::move( created ), false );
        if( !added ) {
            break;
        }
        ++returned;
        added_quantity += count_by_charges ?
                          quantity : 1;
        sol::table value = state.create_table();
        value["handle"] = make_map_item_handle(
                              *added, absolute,
                              runtime_generation,
                              world_generation );
        value["uid"] = added->uid().get_value();
        value["id"] = requested;
        value["name"] = added->tname();
        value["charges"] = added->charges;
        items[returned] = std::move( value );
    }
    sol::table value = state.create_table();
    value["id"] = requested;
    value["requested"] = quantity;
    value["added"] = added_quantity;
    value["rejected"] =
        quantity - added_quantity;
    value["count_by_charges"] =
        count_by_charges;
    value["instances"] = returned;
    value["items"] = std::move( items );
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

std::vector<flag_id> read_world_spawn_flags(
    const sol::optional<sol::table> &requested,
    const std::string_view api_name )
{
    std::map<std::size_t, flag_id> indexed;
    if( requested ) {
        for( const auto &entry : *requested ) {
            if( !entry.first.is<lua_Integer>() ||
                !entry.second.is<script_game_id>() ) {
                throw std::invalid_argument(
                    std::string( api_name ) +
                    " flags must be a dense GameId<json_flag> array" );
            }
            const lua_Integer raw_index =
                entry.first.as<lua_Integer>();
            if( raw_index <= 0 ||
                static_cast<std::uint64_t>( raw_index ) >
                maximum_world_spawn_flags ) {
                throw std::invalid_argument(
                    std::string( api_name ) +
                    " flag index must be within 1..128" );
            }
            const script_game_id id =
                entry.second.as<script_game_id>();
            require_id_kind(
                id, "json_flag", std::string( api_name ) );
            indexed.emplace(
                static_cast<std::size_t>( raw_index ),
                flag_id( id.value() ) );
        }
    }
    if( !indexed.empty() &&
        indexed.rbegin()->first != indexed.size() ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " flags must not contain holes" );
    }
    std::vector<flag_id> result;
    result.reserve( indexed.size() );
    for( const auto &[index, flag] : indexed ) {
        static_cast<void>( index );
        result.push_back( flag );
    }
    return result;
}

void configure_world_spawn_item(
    item &entry, const std::vector<flag_id> &flags,
    const tripoint_abs_ms &position )
{
    for( const flag_id &flag : flags ) {
        entry.set_flag( flag );
    }
    if( entry.has_flag(
            flag_id( "PRESERVE_SPAWN_LOC" ) ) ) {
        entry.preserve_location( position );
    }
}

sol::table place_world_spawn_items(
    sol::this_state lua, std::vector<item> generated,
    const script_tripoint_coord &position,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const tripoint_abs_ms absolute = require_absolute_ms(
                                         position,
                                         "services.world item spawning" );
    map &here = get_map();
    const bool loaded = here.inbounds( absolute );
    sol::state_view state( lua );
    sol::table items = state.create_table(
                           static_cast<int>( generated.size() ), 0 );
    std::size_t added_count = 0;
    if( loaded ) {
        const tripoint_bub_ms local = here.get_bub( absolute );
        for( item &created : generated ) {
            item_location added =
                here.add_item_or_charges_ret_loc(
                    local, std::move( created ), false );
            if( !added ) {
                break;
            }
            sol::table entry = state.create_table();
            entry["handle"] = make_map_item_handle(
                                  *added, absolute,
                                  runtime_generation,
                                  world_generation );
            entry["uid"] = added->uid().get_value();
            entry["id"] = script_game_id(
                              "item", added->typeId().str() );
            entry["name"] = added->tname();
            entry["charges"] = added->charges;
            items[++added_count] = std::move( entry );
        }
    } else {
        tinymap distant;
        distant.load(
            project_to<coords::omt>( absolute ), false );
        const tripoint_omt_ms local = distant.get_omt( absolute );
        for( item &created : generated ) {
            item &added = distant.add_item_or_charges(
                              local, std::move( created ), false );
            if( added.is_null() ) {
                break;
            }
            sol::table entry = state.create_table();
            entry["handle"] = sol::nil;
            entry["uid"] = added.uid().get_value();
            entry["id"] = script_game_id(
                              "item", added.typeId().str() );
            entry["name"] = added.tname();
            entry["charges"] = added.charges;
            items[++added_count] = std::move( entry );
        }
    }
    sol::table value = state.create_table();
    value["position"] = position;
    value["loaded"] = loaded;
    value["generated"] = generated.size();
    value["added"] = added_count;
    value["rejected"] = generated.size() - added_count;
    value["items"] = std::move( items );
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table spawn_world_item_group(
    sol::this_state lua, const script_tripoint_coord &position,
    const script_game_id &group,
    const sol::optional<sol::table> &requested_flags,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name =
        "services.world.spawn_item_group";
    require_id_kind(
        group, "item_group", std::string( api_name ) );
    const tripoint_abs_ms absolute = require_absolute_ms(
                                         position,
                                         std::string( api_name ) );
    const std::vector<flag_id> flags =
        read_world_spawn_flags(
            requested_flags, api_name );
    item_group::ItemList generated = item_group::items_from(
                                         item_group_id( group.value() ),
                                         calendar::turn );
    if( generated.size() > maximum_world_group_items ) {
        sol::state_view state( lua );
        return make_game_error_result( state, {
            "result_limit",
            "The item group generated more than 256 top-level items"
        } );
    }
    for( item &entry : generated ) {
        configure_world_spawn_item(
            entry, flags, absolute );
    }
    return place_world_spawn_items(
               lua, std::move( generated ), position,
               runtime_generation, world_generation );
}

sol::table spawn_world_item_in_container(
    sol::this_state lua, const script_tripoint_coord &position,
    const script_game_id &contents_id,
    const std::int64_t quantity,
    const script_game_id &container_id,
    const sol::optional<sol::table> &requested_flags,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name =
        "services.world.spawn_item_in_container";
    require_id_kind(
        contents_id, "item", std::string( api_name ) );
    require_id_kind(
        container_id, "item", std::string( api_name ) );
    if( quantity <= 0 || quantity > maximum_spawn_quantity ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " quantity is outside its limit" );
    }
    const tripoint_abs_ms absolute = require_absolute_ms(
                                         position,
                                         std::string( api_name ) );
    const std::vector<flag_id> flags =
        read_world_spawn_flags(
            requested_flags, api_name );
    item contents(
        itype_id( contents_id.value() ),
        calendar::turn );
    contents.charges = static_cast<int>( quantity );
    configure_world_spawn_item(
        contents, flags, absolute );
    item container(
        itype_id( container_id.value() ),
        calendar::turn );
    container.put_in(
        contents, pocket_type::CONTAINER );
    std::vector<item> generated;
    generated.push_back( std::move( container ) );
    return place_world_spawn_items(
               lua, std::move( generated ), position,
               runtime_generation, world_generation );
}

sol::table remove_item(
    sol::this_state lua,
    const script_tripoint_coord &position,
    const game_handle &handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name =
        "services.world.remove_item";
    sol::state_view state( lua );
    const native_handle_result<item> resolved =
        handle.resolve_item(
            runtime_generation, world_generation );
    if( !resolved ) {
        return make_game_error_result(
                   state, *resolved.error );
    }
    map &here = get_map();
    const tripoint_bub_ms local =
        require_loaded_position(
            here, position, std::string( api_name ) );
    map_stack entries = here.i_at( local );
    const auto found = std::find_if(
                           entries.begin(), entries.end(),
    [&resolved]( const item & entry ) {
        return &entry == resolved.value;
    } );
    if( found == entries.end() ) {
        return make_game_error_result(
        state, game_handle_error{
            "wrong_location",
            "The item is not a top-level item at the requested map tile"
        } );
    }
    sol::table value = state.create_table();
    value["uid"] =
        resolved.value->uid().get_value();
    value["id"] = script_game_id(
                      "item",
                      resolved.value->typeId().str() );
    value["name"] = resolved.value->tname();
    here.i_rem( local, resolved.value );
    value["removed"] = true;
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

tripoint_abs_omt require_absolute_omt(
    const script_tripoint_coord &position,
    const std::string_view api_name )
{
    if( position.native_origin() != coords::origin::abs ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires an absolute Tripoint" );
    }
    if( position.native_scale() ==
        coords::scale::overmap_terrain ) {
        return tripoint_abs_omt( position.to_native() );
    }
    if( position.native_scale() ==
        coords::scale::map_square ) {
        return project_to<coords::omt>(
                   tripoint_abs_ms( position.to_native() ) );
    }
    throw std::invalid_argument(
        std::string( api_name ) +
        " requires an absolute map-square or overmap-terrain Tripoint" );
}

void require_world_event_key(
    const std::string &key, const std::string_view api_name )
{
    if( key.size() > maximum_world_event_key_bytes ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " key exceeds 256 bytes" );
    }
}

time_duration require_world_change_delay(
    const script_time_duration &requested,
    const std::string_view api_name, const bool allow_zero )
{
    const time_duration delay = requested.to_native();
    if( delay < 0_turns || ( !allow_zero && delay == 0_turns ) ||
        delay > maximum_world_change_delay ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            ( allow_zero ?
              " delay must be within 0 turns..10000 days" :
              " delay must be within 1 turn..10000 days" ) );
    }
    return delay;
}

struct transform_radius_options {
    time_duration delay = 0_turns;
    std::string key;
};

transform_radius_options read_transform_radius_options(
    const sol::optional<sol::table> &requested )
{
    constexpr std::string_view api_name =
        "services.world.transform_radius";
    transform_radius_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                std::string( api_name ) +
                " option keys must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        const sol::object value = entry.second;
        if( key == "delay" ) {
            if( !value.is<script_time_duration>() ) {
                throw std::invalid_argument(
                    std::string( api_name ) +
                    " delay must be a TimeDuration" );
            }
            result.delay = require_world_change_delay(
                               value.as<script_time_duration>(),
                               api_name, true );
        } else if( key == "key" ) {
            if( !value.is<std::string>() ) {
                throw std::invalid_argument(
                    std::string( api_name ) +
                    " key must be a string" );
            }
            result.key = value.as<std::string>();
            require_world_event_key( result.key, api_name );
        } else {
            throw std::invalid_argument(
                std::string( api_name ) +
                " received unknown option '" + key + "'" );
        }
    }
    return result;
}

sol::table transform_world_radius(
    sol::this_state lua, const script_tripoint_coord &position,
    const int radius, const script_game_id &requested_transform,
    const sol::optional<sol::table> &requested_options )
{
    constexpr std::string_view api_name =
        "services.world.transform_radius";
    require_id_kind(
        requested_transform, "terrain_furniture_transform",
        std::string( api_name ) );
    if( radius < 0 || radius > maximum_transform_radius ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " radius must be within 0..60" );
    }
    const tripoint_abs_ms center = require_absolute_ms(
                                       position,
                                       std::string( api_name ) );
    const transform_radius_options options =
        read_transform_radius_options( requested_options );
    sol::state_view state( lua );
    sol::table value = state.create_table();
    value["position"] = position;
    value["radius"] = radius;
    value["transform"] = requested_transform;
    if( options.delay > 0_turns ) {
        const time_point when =
            calendar::turn + options.delay + 1_seconds;
        get_timed_events().add(
            timed_event_type::TRANSFORM_RADIUS,
            when, -1, center, radius,
            requested_transform.value(), options.key );
        value["scheduled"] = true;
        value["when"] = script_time_point::from_native( when );
        value["key"] = options.key;
    } else {
        map &bubble = reality_bubble();
        std::unique_ptr<map> distant;
        map *target = &bubble;
        const tripoint_abs_ms lower =
            center - point( radius, radius );
        const tripoint_abs_ms upper =
            center + point( radius, radius );
        if( !bubble.inbounds( lower ) ||
            !bubble.inbounds( upper ) ) {
            distant = std::make_unique<map>();
            distant->load(
                project_to<coords::sm>( lower ), false );
            target = distant.get();
        }
        target->transform_radius(
            ter_furn_transform_id(
                requested_transform.value() ),
            radius, center );
        value["scheduled"] = false;
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

void translate_world_linked_items(
    visitable &items, const tripoint_rel_ms &offset )
{
    items.visit_items( [&]( item * value, item * ) {
        if( value->has_link_data() && !value->has_no_links() &&
            value->link().t_abs_pos != tripoint_abs_ms::invalid ) {
            value->link().t_abs_pos += offset;
            value->link().s_bub_pos = tripoint_bub_ms::invalid;
            value->set_var( eoc_cable_relocation_turn_var, -1 );
        }
        return VisitResponse::NEXT;
    } );
}

void translate_submap_linked_items(
    submap &value, const tripoint_rel_ms &offset )
{
    for( int x = 0; x < SEEX; ++x ) {
        for( int y = 0; y < SEEY; ++y ) {
            for( item &entry :
                 value.get_items( point_sm_ms( x, y ) ) ) {
                translate_world_linked_items( entry, offset );
            }
        }
    }
}

void ensure_omt_submaps( const tripoint_abs_omt &position )
{
    const tripoint_abs_sm base =
        project_to<coords::sm>( position );
    if( !MAPBUFFER.submap_exists( base ) ) {
        tinymap generated;
        generated.load( position, true );
    }
}

std::array<submap, 4> snapshot_omt_submaps(
    const tripoint_abs_omt &position )
{
    ensure_omt_submaps( position );
    const tripoint_abs_sm base =
        project_to<coords::sm>( position );
    std::array<submap, 4> snapshots;
    std::size_t index = 0;
    for( int x = 0; x < 2; ++x ) {
        for( int y = 0; y < 2; ++y ) {
            submap *source = MAPBUFFER.lookup_submap(
                                 base + point( x, y ) );
            if( source == nullptr ) {
                throw std::runtime_error(
                    "world OMT snapshot could not load a source submap" );
            }
            snapshots[index++] = source->get_revert_submap();
        }
    }
    return snapshots;
}

void schedule_omt_snapshots(
    const tripoint_abs_omt &destination,
    std::array<submap, 4> snapshots,
    const time_point &when, const std::string &key )
{
    ensure_omt_submaps( destination );
    const tripoint_abs_sm base =
        project_to<coords::sm>( destination );
    std::size_t index = 0;
    for( int x = 0; x < 2; ++x ) {
        for( int y = 0; y < 2; ++y ) {
            get_timed_events().add(
                timed_event_type::REVERT_SUBMAP,
                when, -1,
                project_to<coords::ms>(
                    base + point( x, y ) ),
                0, "", std::move( snapshots[index++] ), key );
        }
    }
}

sol::table schedule_world_location_revert(
    sol::this_state lua, const script_tripoint_coord &position,
    const script_time_duration &requested_delay,
    const sol::optional<std::string> &requested_key )
{
    constexpr std::string_view api_name =
        "services.world.schedule_location_revert";
    const tripoint_abs_omt omt = require_absolute_omt(
                                     position, api_name );
    const time_duration delay = require_world_change_delay(
                                    requested_delay, api_name, false );
    const std::string key = requested_key.value_or( "" );
    require_world_event_key( key, api_name );
    std::array<submap, 4> snapshots =
        snapshot_omt_submaps( omt );
    const time_point when = calendar::turn + delay + 1_seconds;
    schedule_omt_snapshots(
        omt, std::move( snapshots ), when, key );
    reality_bubble().invalidate_map_cache( omt.z() );
    sol::state_view state( lua );
    sol::table value = state.create_table();
    value["position"] = script_tripoint_coord::from_native(
                            coords::origin::abs,
                            coords::scale::overmap_terrain,
                            omt.raw() );
    value["when"] = script_time_point::from_native( when );
    value["key"] = key;
    value["events"] = 4;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table schedule_world_location_copy(
    sol::this_state lua, const script_tripoint_coord &source_position,
    const script_tripoint_coord &destination_position,
    const script_time_duration &requested_delay,
    const sol::optional<std::string> &requested_key )
{
    constexpr std::string_view api_name =
        "services.world.schedule_location_copy";
    const tripoint_abs_omt source = require_absolute_omt(
                                        source_position, api_name );
    const tripoint_abs_omt destination = require_absolute_omt(
            destination_position,
            api_name );
    const time_duration delay = require_world_change_delay(
                                    requested_delay, api_name, false );
    const std::string key = requested_key.value_or( "" );
    require_world_event_key( key, api_name );
    std::array<submap, 4> snapshots =
        snapshot_omt_submaps( source );
    const tripoint_rel_ms offset =
        project_to<coords::ms>( destination ) -
        project_to<coords::ms>( source );
    for( submap &snapshot : snapshots ) {
        translate_submap_linked_items( snapshot, offset );
    }
    const time_point when = calendar::turn + delay + 1_seconds;
    schedule_omt_snapshots(
        destination, std::move( snapshots ), when, key );
    get_avatar().translocators.copy_translocator(
        source, destination );
    reality_bubble().invalidate_map_cache(
        destination.z() );
    sol::state_view state( lua );
    sol::table value = state.create_table();
    value["source"] = script_tripoint_coord::from_native(
                          coords::origin::abs,
                          coords::scale::overmap_terrain,
                          source.raw() );
    value["destination"] = script_tripoint_coord::from_native(
                               coords::origin::abs,
                               coords::scale::overmap_terrain,
                               destination.raw() );
    value["when"] = script_time_point::from_native( when );
    value["key"] = key;
    value["events"] = 4;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table override_world_place_name(
    sol::this_state lua, const std::string &name,
    const script_time_duration &requested_duration,
    const sol::optional<std::string> &requested_key )
{
    constexpr std::string_view api_name =
        "services.world.override_place_name";
    if( name.empty() || name.size() > maximum_place_name_bytes ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " name must contain 1..1024 bytes" );
    }
    const time_duration duration = require_world_change_delay(
                                       requested_duration,
                                       api_name, false );
    const std::string key = requested_key.value_or( "" );
    require_world_event_key( key, api_name );
    const time_point when =
        calendar::turn + duration + 1_seconds;
    get_timed_events().add(
        timed_event_type::OVERRIDE_PLACE,
        when, -1, tripoint_abs_ms::zero,
        -1, name, key );
    sol::state_view state( lua );
    sol::table value = state.create_table();
    value["name"] = name;
    value["when"] = script_time_point::from_native( when );
    value["key"] = key;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table reschedule_world_events(
    sol::this_state lua, const std::string &key,
    const script_time_duration &requested_delay )
{
    constexpr std::string_view api_name =
        "services.world.reschedule_events";
    if( key.empty() ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " key cannot be empty" );
    }
    require_world_event_key( key, api_name );
    const time_duration delay = require_world_change_delay(
                                    requested_delay, api_name, true );
    std::size_t matched = 0;
    for( const timed_event &event :
         get_timed_events().get_all() ) {
        if( event.key == key ) {
            ++matched;
        }
    }
    get_timed_events().set_all( key, delay );
    sol::state_view state( lua );
    sol::table value = state.create_table();
    value["key"] = key;
    value["matched"] = matched;
    value["when"] = script_time_point::from_native(
                        calendar::turn + delay );
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

std::optional<resolved_map_tile> resolve_map_tile_token(
    const map_tile_token &token,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation,
    std::optional<game_handle_error> &error )
{
    if( !token.owner_is_current() ) {
        error = game_handle_error{
            "stale_owner",
            "The MapTileToken belongs to an inactive map-token owner"
        };
        return std::nullopt;
    }
    if( !token.runtime_matches( runtime_generation ) ) {
        error = game_handle_error{
            "stale_runtime",
            "The MapTileToken belongs to an inactive or different Lua runtime"
        };
        return std::nullopt;
    }
    if( !token.world_matches( world_generation ) ) {
        error = game_handle_error{
            "stale_world",
            "The MapTileToken belongs to a different world generation"
        };
        return std::nullopt;
    }
    if( g == nullptr ) {
        error = game_handle_error{
            "map_unavailable",
            "The active map is not available"
        };
        return std::nullopt;
    }

    map &here = get_map();
    const tripoint_abs_ms absolute = token.native_position();
    if( absolute == tripoint_abs_ms::invalid ) {
        error = game_handle_error{
            "invalid_position",
            "The MapTileToken does not contain a valid absolute map-square position"
        };
        return std::nullopt;
    }
    if( !here.inbounds_z( absolute.z() ) ) {
        error = game_handle_error{
            "out_of_world",
            "The MapTileToken position is outside the supported world z range"
        };
        return std::nullopt;
    }
    if( !here.supports_zlevels() &&
        absolute.z() != here.get_abs_sub().z() ) {
        error = game_handle_error{
            "z_unloaded",
            "The MapTileToken position is on a z-level not loaded by the active map"
        };
        return std::nullopt;
    }

    const tripoint_bub_ms local = here.get_bub( absolute );
    if( !here.inbounds( local ) ) {
        error = game_handle_error{
            "out_of_world",
            "The MapTileToken position is outside the active map bounds"
        };
        return std::nullopt;
    }
    if( here.maptile_at( local ).wrapped_submap() == nullptr ) {
        error = game_handle_error{
            "unloaded",
            "The MapTileToken position is not in a loaded map bubble"
        };
        return std::nullopt;
    }
    return resolved_map_tile{ &here, local };
}

sol::table snapshot_map_vehicle_part(
    sol::state_view lua, map &here, const tripoint_bub_ms &position )
{
    sol::table result = lua.create_table();
    const optional_vpart_position found = here.veh_at( position );
    if( !found ) {
        result["present"] = false;
        return result;
    }

    vehicle &entry = found->vehicle();
    const std::size_t part_index = found->part_index();
    if( part_index >= static_cast<std::size_t>( std::max( 0, entry.part_count() ) ) ) {
        result["present"] = false;
        return result;
    }
    const vehicle_part &part = entry.part( static_cast<int>( part_index ) );
    const vpart_info &definition = part.info();
    const std::int64_t part_uid = part.get_base().uid().get_value();

    result["present"] = true;
    result["id"] = script_game_id(
                       "vehicle_part", definition.id.str() );
    result["location"] = script_game_id(
                             "vehicle_part_location", definition.location.str() );
    result["name"] = part.name( false );
    sol::table mount = lua.create_table();
    mount["x"] = part.mount.x();
    mount["y"] = part.mount.y();
    result["mount"] = std::move( mount );
    result["position"] = script_tripoint_coord::from_native(
                             coords::origin::abs,
                             coords::scale::map_square,
                             found->pos_abs().raw() );
    result["vehicle_prototype"] = script_game_id(
                                      "vehicle_prototype", entry.type.str() );
    result["index"] = part_index;
    if( part_uid > 0 ) {
        result["part_uid"] = part_uid;
    } else {
        result["part_uid"] = sol::nil;
    }
    result["variant"] = part.variant;
    result["hp"] = part.hp();
    result["durability"] = definition.durability;
    result["damage_percent"] = part.damage_percent();
    result["broken"] = part.is_broken();
    result["available"] = part.is_available();
    result["enabled"] = part.enabled;
    result["power_disabled"] = part.power_disabled;
    result["removed"] = part.removed;
    result["fake"] = part.is_fake;
    result["inside"] = found->is_inside();
    if( const std::optional<std::string> label = found->get_label() ) {
        result["label"] = *label;
    } else {
        result["label"] = sol::nil;
    }
    return result;
}

sol::table snapshot_map_tile_value(
    sol::state_view lua, const map_tile_token &token,
    const resolved_map_tile &resolved, const map_snapshot_options &options,
    const std::uint64_t revision )
{
    map &here = *resolved.value;
    const tripoint_bub_ms &position = resolved.local;
    const ter_id terrain = here.ter( position );
    const furn_id furniture = here.furn( position );
    const trap &trap_at_position = here.tr_at( position );

    sol::table result = lua.create_table();
    result["position"] = script_tripoint_coord::from_native(
                             coords::origin::abs,
                             coords::scale::map_square,
                             token.native_position().raw() );
    result["terrain"] = script_game_id(
                            "terrain", terrain.id().str() );
    result["terrain_name"] = terrain->name();
    if( furniture.id().is_null() ) {
        result["furniture"] = sol::nil;
        result["furniture_name"] = sol::nil;
    } else {
        result["furniture"] = script_game_id(
                                  "furniture", furniture.id().str() );
        result["furniture_name"] = furniture->name();
    }
    if( trap_at_position.is_null() ) {
        result["trap"] = sol::nil;
        result["trap_name"] = sol::nil;
        result["trap_benign"] = sol::nil;
    } else {
        result["trap"] = script_game_id(
                             "trap", trap_at_position.id.str() );
        result["trap_name"] = trap_at_position.name();
        result["trap_benign"] = trap_at_position.is_benign();
    }
    result["fields"] = snapshot_fields(
                           lua, here.field_at( position ),
                           options.field_limit );
    const std::string signage = here.get_signage( position );
    const bool signage_truncated = signage.size() > options.signage_limit;
    result["signage"] = signage.substr( 0, options.signage_limit );
    result["signage_truncated"] = signage_truncated;
    result["vehicle_part"] = snapshot_map_vehicle_part(
                                 lua, here, position );
    result["item_count"] = here.i_at( position ).size();
    result["revision"] = revision;
    return result;
}

map_tile_edit_plan make_map_tile_edit_plan(
    const map_tile_changes &changes, const map &here,
    const tripoint_bub_ms &position )
{
    constexpr std::string_view api_name = "services.map.edit";
    map_tile_edit_plan result;
    result.fields.reserve( changes.fields.size() );

    if( changes.terrain ) {
        const ter_str_id id( *changes.terrain );
        if( !id.is_valid() ) {
            throw std::invalid_argument(
                std::string( api_name ) + " requires a valid terrain id" );
        }
        result.terrain = id.id();
    }
    if( changes.furniture_requested ) {
        result.furniture_requested = true;
        if( changes.furniture ) {
            const furn_str_id id( *changes.furniture );
            if( !id.is_valid() ) {
                throw std::invalid_argument(
                    std::string( api_name ) + " requires a valid furniture id" );
            }
            result.furniture = id.id();
        } else {
            result.furniture = furn_str_id::NULL_ID().id();
        }
    }
    if( changes.trap_requested ) {
        result.trap_requested = true;
        if( changes.trap ) {
            const trap_str_id id( *changes.trap );
            if( !id.is_valid() ) {
                throw std::invalid_argument(
                    std::string( api_name ) + " requires a valid trap id" );
            }
            result.trap = id.id();
        } else {
            result.trap = tr_null;
        }
    }

    const ter_id final_terrain = result.terrain.value_or( here.ter( position ) );
    const furn_id final_furniture = result.furniture_requested ?
                                    result.furniture : here.furn( position );
    const auto final_has_flag = [&final_terrain, &final_furniture](
    const ter_furn_flag flag ) {
        return final_terrain->has_flag( flag ) ||
               final_furniture->has_flag( flag );
    };
    for( const map_tile_field_change &change : changes.fields ) {
        if( change.hit_player ) {
            throw std::invalid_argument(
                std::string( api_name ) +
                " is limited to tile state and cannot hit a player" );
        }
        const field_type_str_id string_id( change.id );
        if( !string_id.is_valid() ) {
            throw std::invalid_argument(
                std::string( api_name ) + " requires a valid field id" );
        }
        const field_type_id id = string_id.id();
        if( !id ) {
            throw std::invalid_argument(
                std::string( api_name ) + " requires a valid field type" );
        }
        if( !change.remove &&
            change.intensity > id->get_max_intensity() ) {
            throw std::invalid_argument(
                std::string( api_name ) +
                " field intensity exceeds the field definition limit" );
        }
        if( !change.remove &&
            ( final_has_flag( ter_furn_flag::TFLAG_NO_FLOOR ) &&
              id->phase != phase_id::GAS ) ) {
            throw std::invalid_argument(
                std::string( api_name ) +
                " cannot place a non-gas field on an open-air tile" );
        }
        if( !change.remove &&
            final_has_flag( ter_furn_flag::TFLAG_SWIMMABLE ) &&
            id->phase == phase_id::LIQUID ) {
            throw std::invalid_argument(
                std::string( api_name ) +
                " cannot place a liquid field on a swimmable tile" );
        }
        map_tile_field_plan staged;
        staged.id = id;
        staged.intensity = change.intensity;
        staged.age = change.age;
        staged.remove = change.remove;
        result.fields.push_back( staged );
    }
    return result;
}

map_tile_original_state capture_map_tile_original_state(
    const map &here, const tripoint_bub_ms &position )
{
    map_tile_original_state result;
    result.terrain = here.ter( position );
    result.furniture = here.furn( position );
    result.trap = here.tr_at( position ).id;
    const field &fields = here.field_at( position );
    result.fields.reserve( fields.field_count() );
    for( const auto &entry : fields ) {
        map_tile_field_plan saved;
        saved.id = entry.second.get_field_type();
        saved.intensity = entry.second.get_field_intensity();
        saved.age = entry.second.get_field_age();
        saved.alive = entry.second.is_field_alive();
        result.fields.push_back( saved );
    }
    return result;
}

void restore_map_tile_original_state(
    map &here, const tripoint_bub_ms &position,
    const map_tile_original_state &original )
{
    // Furniture can have native side effects (for example, plant furniture
    // can adjust terrain), so restore it before restoring terrain.
    if( here.furn( position ) != original.furniture &&
        !here.furn_set( position, original.furniture, true, false, true ) ) {
        throw std::runtime_error( "map tile furniture rollback was rejected" );
    }
    if( here.ter( position ) != original.terrain &&
        !here.ter_set( position, original.terrain, false ) ) {
        throw std::runtime_error( "map tile terrain rollback was rejected" );
    }
    if( here.tr_at( position ).id.id() != original.trap ) {
        here.trap_set( position, original.trap );
    }

    here.clear_fields( position );
    for( const map_tile_field_plan &saved : original.fields ) {
        if( !saved.id ||
            !here.add_field( position, saved.id, saved.intensity,
                             saved.age, false ) ) {
            throw std::runtime_error( "map tile field rollback was rejected" );
        }
        if( !saved.alive ) {
            here.remove_field( position, saved.id );
        }
    }
}

void commit_map_tile_edit(
    map &here, const tripoint_bub_ms &position,
    const map_tile_edit_plan &plan,
    const map_tile_original_state &original )
{
    const ter_id desired_terrain = plan.terrain.value_or( original.terrain );
    if( plan.terrain && here.ter( position ) != desired_terrain &&
        !here.ter_set( position, desired_terrain, false ) ) {
        throw std::runtime_error( "map tile terrain edit was rejected" );
    }
    if( plan.furniture_requested &&
        here.furn( position ) != plan.furniture &&
        !here.furn_set( position, plan.furniture, true, false, true ) ) {
        throw std::runtime_error( "map tile furniture edit was rejected" );
    }
    // A furniture setter may normalize a terrain (notably for plant
    // furniture).  The edit contract changes terrain only when requested.
    if( here.ter( position ) != desired_terrain &&
        !here.ter_set( position, desired_terrain, false ) ) {
        throw std::runtime_error( "map tile terrain normalization was rejected" );
    }
    if( plan.terrain && here.ter( position ) != desired_terrain ) {
        throw std::runtime_error( "map tile terrain edit did not commit" );
    }
    if( plan.furniture_requested &&
        here.furn( position ) != plan.furniture ) {
        throw std::runtime_error( "map tile furniture edit did not commit" );
    }
    if( plan.trap_requested ) {
        if( here.tr_at( position ).id.id() != plan.trap ) {
            here.trap_set( position, plan.trap );
        }
        if( here.tr_at( position ).id.id() != plan.trap ) {
            throw std::runtime_error( "map tile trap edit did not commit" );
        }
    }
    for( const map_tile_field_plan &change : plan.fields ) {
        if( change.remove ) {
            here.remove_field( position, change.id );
        } else if( !here.add_field( position, change.id, change.intensity,
                                    change.age, false ) ) {
            throw std::runtime_error( "map tile field edit was rejected" );
        }
        if( !change.remove && here.get_field( position, change.id ) == nullptr ) {
            throw std::runtime_error( "map tile field edit did not commit" );
        }
    }
}

sol::table map_tile_from_position(
    sol::this_state lua, const script_tripoint_coord &position,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    const tripoint_abs_ms absolute = require_absolute_ms(
                                         position, "services.map.tile" );
    const map_tile_token token(
        absolute, runtime_generation, world_generation );
    std::optional<game_handle_error> error;
    if( !resolve_map_tile_token(
            token, runtime_generation, world_generation, error ) ) {
        return make_game_error_result( state, *error );
    }
    return make_game_value_result(
               state, sol::make_object( state, token ) );
}

sol::table snapshot_map_tile(
    sol::this_state lua, const map_tile_token &token,
    const sol::optional<sol::table> &requested_options,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    const map_snapshot_options options = read_map_snapshot_options(
            requested_options );
    std::optional<game_handle_error> error;
    const std::optional<resolved_map_tile> resolved = resolve_map_tile_token(
                token, runtime_generation, world_generation, error );
    if( !resolved ) {
        return make_game_error_result( state, *error );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, snapshot_map_tile_value(
                       state, token, *resolved, options,
                       map_mutation_epoch() ) ) );
}

sol::table edit_map_tile(
    sol::this_state lua, const map_tile_token &token,
    const std::uint64_t expected_revision,
    const map_tile_changes &changes,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    const std::optional<resolved_map_tile> resolved = resolve_map_tile_token(
                token, runtime_generation, world_generation, error );
    if( !resolved ) {
        return make_game_error_result( state, *error );
    }
    const std::uint64_t current_revision = map_mutation_epoch();
    if( current_revision != expected_revision ) {
        return make_game_error_result( state, {
            "revision_conflict",
            "The MapTileToken edit expected revision " +
            std::to_string( expected_revision ) +
            " but the active map revision is " +
            std::to_string( current_revision )
        } );
    }

    const map_tile_edit_plan plan = make_map_tile_edit_plan(
                                        changes, *resolved->value,
                                        resolved->local );
    const map_tile_original_state original = capture_map_tile_original_state(
                *resolved->value, resolved->local );
    try {
        commit_map_tile_edit(
            *resolved->value, resolved->local, plan, original );
    } catch( const std::exception &exception ) {
        try {
            restore_map_tile_original_state(
                *resolved->value, resolved->local, original );
        } catch( const std::exception &rollback_exception ) {
            return make_game_error_result( state, {
                "rollback_failed",
                std::string( "Map tile edit failed and rollback failed: " ) +
                rollback_exception.what()
            } );
        }
        return make_game_error_result( state, {
            "edit_failed",
            std::string( "Map tile edit failed: " ) + exception.what()
        } );
    }

    bump_map_mutation_epoch();
    const map_snapshot_options snapshot_options;
    return make_game_value_result(
               state, sol::make_object(
                   state, snapshot_map_tile_value(
                       state, token, *resolved, snapshot_options,
                       map_mutation_epoch() ) ) );
}

} // namespace

std::optional<game_handle_error> validate_map_tile_token(
    const map_tile_token &token,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    std::optional<game_handle_error> error;
    static_cast<void>( resolve_map_tile_token(
                           token, runtime_generation, world_generation, error ) );
    return error;
}

map_tile_token::map_tile_token(
    const tripoint_abs_ms &position,
    const game_handle_runtime &runtime,
    const std::size_t world_generation ) :
    position_( position ),
    runtime_( runtime ),
    world_generation_( world_generation ),
    owner_( active_map_tile_owner() ),
    owner_generation_( owner_ ? owner_->generation() : 0 )
{
}

const tripoint_abs_ms &map_tile_token::native_position() const noexcept
{
    return position_;
}

std::size_t map_tile_token::runtime_generation() const noexcept
{
    return runtime_.generation();
}

std::size_t map_tile_token::world_generation() const noexcept
{
    return world_generation_;
}

std::size_t map_tile_token::owner_generation() const noexcept
{
    return owner_generation_;
}

bool map_tile_token::owner_is_current() const noexcept
{
    const std::shared_ptr<map_tile_token_owner> &current =
        active_map_tile_owner();
    return owner_ && current &&
           same_map_tile_owner( owner_, current ) &&
           owner_generation_ == current->generation() &&
           current->is_active();
}

bool map_tile_token::runtime_matches(
    const game_handle_runtime &runtime ) const noexcept
{
    return runtime_.is_active_match( runtime );
}

bool map_tile_token::world_matches(
    const std::size_t world_generation ) const noexcept
{
    return world_generation_ != 0 && world_generation != 0 &&
           world_generation_ == world_generation;
}

std::string map_tile_token::to_string() const
{
    return "MapTileToken<" + position_.to_string() + ":" +
           std::to_string( runtime_generation() ) + ":" +
           std::to_string( world_generation_ ) + ":" +
           std::to_string( owner_generation_ ) + ">";
}

bool operator==( const map_tile_token &lhs,
                 const map_tile_token &rhs ) noexcept
{
    return lhs.position_ == rhs.position_ &&
           lhs.world_generation_ == rhs.world_generation_ &&
           lhs.owner_generation_ == rhs.owner_generation_ &&
           same_map_tile_owner( lhs.owner_, rhs.owner_ ) &&
           lhs.runtime_.same_identity( rhs.runtime_ );
}

std::uint64_t map_mutation_epoch() noexcept
{
    return active_map_mutation_epoch().load( std::memory_order_acquire );
}

void bump_map_mutation_epoch() noexcept
{
    std::atomic<std::uint64_t> &epoch = active_map_mutation_epoch();
    std::uint64_t current = epoch.load( std::memory_order_acquire );
    while( true ) {
        const std::uint64_t next =
            current == std::numeric_limits<std::uint64_t>::max() ?
            initial_map_mutation_epoch : current + 1;
        if( epoch.compare_exchange_weak(
                current, next,
                std::memory_order_acq_rel,
                std::memory_order_acquire ) ) {
            return;
        }
    }
}

void reset_map_tile_tokens() noexcept
{
    std::shared_ptr<map_tile_token_owner> &owner = active_map_tile_owner();
    if( owner ) {
        owner->retire();
    }
    const std::size_t next_generation =
        !owner || owner->generation() == std::numeric_limits<std::size_t>::max() ?
        initial_map_tile_owner_generation : owner->generation() + 1;
    owner = std::make_shared<map_tile_token_owner>( next_generation );
    active_map_mutation_epoch().store(
        initial_map_mutation_epoch, std::memory_order_release );
}

void install_map_api(
    sol::table &services,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write )
{
    sol::state_view lua( services.lua_state() );
    lua.new_usertype<map_tile_token>(
        "MapTileToken", sol::no_constructor,
        "position", sol::property(
    []( const map_tile_token & token ) {
        return script_tripoint_coord::from_native(
                   coords::origin::abs,
                   coords::scale::map_square,
                   token.native_position().raw() );
    } ),
    "runtime_generation",
    sol::property( &map_tile_token::runtime_generation ),
    "world_generation",
    sol::property( &map_tile_token::world_generation ),
    "owner_generation",
    sol::property( &map_tile_token::owner_generation ),
    "is_valid",
    [current_runtime_generation, current_world_generation, require_read](
        const map_tile_token & token ) {
        require_read();
        std::optional<game_handle_error> error;
        return resolve_map_tile_token(
                   token, current_runtime_generation(),
                   current_world_generation(), error ).has_value();
    },
    sol::meta_function::to_string,
    &map_tile_token::to_string,
    sol::meta_function::equal_to,
    []( const map_tile_token & lhs, const map_tile_token & rhs ) {
        return lhs == rhs;
    } );

    sol::table map_api = lua.create_table();
    map_api.set_function(
        "tile",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state state,
    const script_tripoint_coord & position ) {
        require_read();
        return map_tile_from_position(
                   state, position, current_runtime_generation(),
                   current_world_generation() );
    } );
    map_api.set_function(
        "snapshot",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state state,
            const map_tile_token & token,
    const sol::optional<sol::table> &options ) {
        require_read();
        return snapshot_map_tile(
                   state, token, options, current_runtime_generation(),
                   current_world_generation() );
    } );
    map_api.set_function(
        "edit",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state state,
            const map_tile_token & token,
            const lua_Integer expected_revision,
    const sol::table & requested_changes ) {
        if( expected_revision < 0 ) {
            throw std::invalid_argument(
                "services.map.edit expected_revision cannot be negative" );
        }
        const map_tile_changes changes = read_map_tile_changes(
                                             requested_changes );
        require_write();
        return edit_map_tile(
                   state, token,
                   static_cast<std::uint64_t>( expected_revision ),
                   changes, current_runtime_generation(),
                   current_world_generation() );
    } );
    services["map"] = std::move( map_api );
}

void install_world_api(
    sol::table &services,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write )
{
    sol::state_view lua( services.lua_state() );
    sol::table world = lua.create_table();
    world.set_function(
        "to_absolute",
    [require_read]( const script_tripoint_coord & position ) {
        require_read();
        return world_to_absolute( position );
    } );
    world.set_function(
        "to_bubble",
    [require_read]( const script_tripoint_coord & position ) {
        require_read();
        return world_to_bubble( position );
    } );
    world.set_function(
        "bounds",
    [require_read]( sol::this_state lua_state ) {
        require_read();
        return world_bounds( lua_state );
    } );
    world.set_function(
        "dimension",
    [require_read]() {
        require_read();
        return g->get_dimension_prefix().str();
    } );
    world.set_function(
        "has_line_of_sight",
        [require_read](
            const script_tripoint_coord & first,
            const script_tripoint_coord & second,
            const sol::optional<int> &range,
    const sol::optional<bool> &with_fields ) {
        require_read();
        return world_has_line_of_sight(
                   first, second, range, with_fields );
    } );
    world.set_function(
        "tile_has_flag",
        [require_read](
            const script_tripoint_coord & position,
            const std::string & layer,
    const std::string & flag ) {
        require_read();
        return world_tile_has_flag(
                   position, layer, flag );
    } );
    world.set_function(
        "light_level",
        [require_read](
    const script_tripoint_coord & position ) {
        require_read();
        return world_light_level( position );
    } );
    world.set_function(
        "field_strength",
        [require_read](
            const script_tripoint_coord & position,
    const script_game_id & field ) {
        require_read();
        return world_field_strength( position, field );
    } );
    world.set_function(
        "find_location",
        [require_read](
            sol::this_state lua_state,
            const script_tripoint_coord & origin,
            const sol::optional<sol::table> &selector,
    const sol::optional<sol::table> &options ) {
        require_read();
        return find_world_location(
                   lua_state, origin, selector, options );
    } );
    world.set_function(
        "region",
        [current_runtime_generation,
         current_world_generation,
         require_read](
            sol::this_state lua_state,
            const script_tripoint_coord & center,
    const sol::optional<sol::table> &options ) {
        require_read();
        return world_region(
                   lua_state, center, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    world.set_function(
        "items_nearby",
        [current_runtime_generation,
         current_world_generation,
         require_read](
            sol::this_state lua_state,
            const script_tripoint_coord & origin,
    const sol::optional<sol::table> &options ) {
        require_read();
        return world_items_nearby(
                   lua_state, origin, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    world.set_function(
        "points_nearby",
        std::function<sol::table(
            sol::this_state,
            const script_tripoint_coord &,
            const sol::optional<sol::table> & )>(
            [require_read](
                sol::this_state lua_state,
                const script_tripoint_coord & origin,
    const sol::optional<sol::table> &options ) {
        require_read();
        return world_points_nearby(
                   lua_state, origin, options );
    } ) );
    world.set_function(
        "vehicles",
        [current_runtime_generation,
         current_world_generation,
         require_read](
            sol::this_state lua_state,
    const sol::optional<sol::table> &options ) {
        require_read();
        return world_vehicles(
                   lua_state, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    world.set_function(
        "transform_line",
        [require_write](
            sol::this_state lua_state,
            const script_tripoint_coord & first,
            const script_tripoint_coord & second,
    const script_game_id & transform_id ) {
        require_write();
        return transform_line(
                   lua_state, first, second, transform_id );
    } );
    world.set_function(
        "transform_radius",
        [require_write](
            sol::this_state lua_state,
            const script_tripoint_coord & position,
            const int radius,
            const script_game_id & transform_id,
    const sol::optional<sol::table> &options ) {
        require_write();
        return transform_world_radius(
                   lua_state, position, radius,
                   transform_id, options );
    } );
    world.set_function(
        "schedule_location_revert",
        [require_write](
            sol::this_state lua_state,
            const script_tripoint_coord & position,
            const script_time_duration & delay,
    const sol::optional<std::string> &key ) {
        require_write();
        return schedule_world_location_revert(
                   lua_state, position, delay, key );
    } );
    world.set_function(
        "schedule_location_copy",
        [require_write](
            sol::this_state lua_state,
            const script_tripoint_coord & source,
            const script_tripoint_coord & destination,
            const script_time_duration & delay,
    const sol::optional<std::string> &key ) {
        require_write();
        return schedule_world_location_copy(
                   lua_state, source, destination,
                   delay, key );
    } );
    world.set_function(
        "override_place_name",
        [require_write](
            sol::this_state lua_state,
            const std::string & name,
            const script_time_duration & duration,
    const sol::optional<std::string> &key ) {
        require_write();
        return override_world_place_name(
                   lua_state, name, duration, key );
    } );
    world.set_function(
        "reschedule_events",
        [require_write](
            sol::this_state lua_state,
            const std::string & key,
    const script_time_duration & delay ) {
        require_write();
        return reschedule_world_events(
                   lua_state, key, delay );
    } );
    world.set_function(
        "emit",
        [require_write](
            sol::this_state lua_state,
            const script_tripoint_coord & position,
            const std::string & emission,
    const sol::optional<double> &chance ) {
        require_write();
        return emit_field_at(
                   lua_state, position, emission, chance );
    } );
    world.set_function(
        "spawn_item",
        [current_runtime_generation,
         current_world_generation,
         require_write](
            sol::this_state lua_state,
            const script_tripoint_coord & position,
            const script_game_id & id,
    const std::int64_t quantity ) {
        require_write();
        return spawn_item(
                   lua_state, position, id, quantity,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    world.set_function(
        "spawn_item_group",
        [current_runtime_generation,
         current_world_generation,
         require_write](
            sol::this_state lua_state,
            const script_tripoint_coord & position,
            const script_game_id & group,
    const sol::optional<sol::table> &flags ) {
        require_write();
        return spawn_world_item_group(
                   lua_state, position, group, flags,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    world.set_function(
        "spawn_item_in_container",
        [current_runtime_generation,
         current_world_generation,
         require_write](
            sol::this_state lua_state,
            const script_tripoint_coord & position,
            const script_game_id & contents,
            const std::int64_t quantity,
            const script_game_id & container,
    const sol::optional<sol::table> &flags ) {
        require_write();
        return spawn_world_item_in_container(
                   lua_state, position, contents,
                   quantity, container, flags,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    world.set_function(
        "remove_item",
        [current_runtime_generation,
         current_world_generation,
         require_write](
            sol::this_state lua_state,
            const script_tripoint_coord & position,
    const game_handle & handle ) {
        require_write();
        return remove_item(
                   lua_state, position, handle,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    services["world"] = std::move( world );
}

} // namespace cata::lua_platform

#endif // CATA_ENABLE_LUA_PLATFORM
