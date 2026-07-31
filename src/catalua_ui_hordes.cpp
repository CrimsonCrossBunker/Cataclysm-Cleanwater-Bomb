#if CATA_ENABLE_LUA_UI

#include "catalua_ui_hordes.h"

#include <algorithm>
#include <array>
#include <cstddef>
#include <cstdint>
#include <iterator>
#include <limits>
#include <map>
#include <optional>
#include <stdexcept>
#include <string>
#include <string_view>
#include <tuple>
#include <unordered_set>
#include <utility>
#include <vector>

#include "calendar.h"
#include "catalua_bindings_coords.h"
#include "catalua_bindings_values.h"
#include "catalua_game_handle.h"
#include "coordinates.h"
#include "horde_entity.h"
#include "horde_map.h"
#include "mongroup.h"
#include "monster.h"
#include "mtype.h"
#include "overmap.h"
#include "overmapbuffer.h"
#include "point.h"
#include "type_id.h"

namespace cata::lua_ui
{

namespace
{

constexpr int default_page_limit = 64;
constexpr int maximum_page_limit = 256;
constexpr std::size_t maximum_offset = 1000000;
constexpr int maximum_query_radius = 30;
constexpr int maximum_query_radius_z = 5;
constexpr int maximum_signal_power = 60;
constexpr int maximum_tracking_intensity = 1000000;
constexpr unsigned int maximum_legacy_population = 1000000;
constexpr std::size_t maximum_conditions = 64;
constexpr std::size_t maximum_legacy_monsters = 64;
constexpr int all_horde_flavors =
    horde_map_flavors::active |
    horde_map_flavors::idle |
    horde_map_flavors::dormant |
    horde_map_flavors::immobile;

const std::array<int, 4> individual_horde_flavors = {
    horde_map_flavors::active,
    horde_map_flavors::idle,
    horde_map_flavors::dormant,
    horde_map_flavors::immobile
};

std::string horde_flavor_name( const int flavor )
{
    switch( flavor ) {
        case horde_map_flavors::active:
            return "active";
        case horde_map_flavors::idle:
            return "idle";
        case horde_map_flavors::dormant:
            return "dormant";
        case horde_map_flavors::immobile:
            return "immobile";
        default:
            throw std::invalid_argument( "unknown horde entity flavor" );
    }
}

int horde_flavor_value( const std::string &name, const std::string &api_name )
{
    for( const int flavor : individual_horde_flavors ) {
        if( horde_flavor_name( flavor ) == name ) {
            return flavor;
        }
    }
    throw std::invalid_argument(
        api_name + " received unknown horde flavor '" + name + "'" );
}

class horde_entity_token
{
    public:
        horde_entity_token(
            const tripoint_abs_ms &position,
            const horde_entity &entry,
            const std::size_t runtime_generation,
            const std::size_t world_generation )
            : position_( position ),
              monster_( entry.get_type()->id.str() ),
              runtime_generation_( runtime_generation ),
              world_generation_( world_generation ),
              identity_( reinterpret_cast<std::uintptr_t>( &entry ) ) {
        }

        script_tripoint_coord position() const {
            return script_tripoint_coord::from_native(
                       coords::origin::abs,
                       coords::scale::map_square,
                       position_.raw() );
        }

        script_game_id monster() const {
            return script_game_id( "monster", monster_ );
        }

        std::size_t runtime_generation() const noexcept {
            return runtime_generation_;
        }

        std::size_t world_generation() const noexcept {
            return world_generation_;
        }

        std::string to_string() const {
            return "HordeEntityToken<" + monster_ + "@" +
                   std::to_string( position_.x() ) + "," +
                   std::to_string( position_.y() ) + "," +
                   std::to_string( position_.z() ) + ">";
        }

        const tripoint_abs_ms &native_position() const noexcept {
            return position_;
        }

        const std::string &native_monster() const noexcept {
            return monster_;
        }

        std::uintptr_t native_identity() const noexcept {
            return identity_;
        }

        friend bool operator==(
            const horde_entity_token &lhs,
            const horde_entity_token &rhs ) {
            return lhs.position_ == rhs.position_ &&
                   lhs.monster_ == rhs.monster_ &&
                   lhs.runtime_generation_ == rhs.runtime_generation_ &&
                   lhs.world_generation_ == rhs.world_generation_ &&
                   lhs.identity_ == rhs.identity_;
        }

    private:
        tripoint_abs_ms position_;
        std::string monster_;
        std::size_t runtime_generation_ = 0;
        std::size_t world_generation_ = 0;
        std::uintptr_t identity_ = 0;
};

class legacy_horde_token
{
    public:
        legacy_horde_token(
            const mongroup &group,
            const std::size_t runtime_generation,
            const std::size_t world_generation )
            : position_( group.abs_pos ),
              group_( group.type.str() ),
              runtime_generation_( runtime_generation ),
              world_generation_( world_generation ),
              identity_( reinterpret_cast<std::uintptr_t>( &group ) ) {
        }

        script_tripoint_coord position() const {
            return script_tripoint_coord::from_native(
                       coords::origin::abs,
                       coords::scale::submap,
                       position_.raw() );
        }

        script_game_id group() const {
            return script_game_id( "monster_group", group_ );
        }

        std::size_t runtime_generation() const noexcept {
            return runtime_generation_;
        }

        std::size_t world_generation() const noexcept {
            return world_generation_;
        }

        std::string to_string() const {
            return "LegacyHordeToken<" + group_ + "@" +
                   std::to_string( position_.x() ) + "," +
                   std::to_string( position_.y() ) + "," +
                   std::to_string( position_.z() ) + ">";
        }

        const tripoint_abs_sm &native_position() const noexcept {
            return position_;
        }

        const std::string &native_group() const noexcept {
            return group_;
        }

        std::uintptr_t native_identity() const noexcept {
            return identity_;
        }

        friend bool operator==(
            const legacy_horde_token &lhs,
            const legacy_horde_token &rhs ) {
            return lhs.position_ == rhs.position_ &&
                   lhs.group_ == rhs.group_ &&
                   lhs.runtime_generation_ == rhs.runtime_generation_ &&
                   lhs.world_generation_ == rhs.world_generation_ &&
                   lhs.identity_ == rhs.identity_;
        }

    private:
        tripoint_abs_sm position_;
        std::string group_;
        std::size_t runtime_generation_ = 0;
        std::size_t world_generation_ = 0;
        std::uintptr_t identity_ = 0;
};

struct page_options {
    std::size_t offset = 0;
    int limit = default_page_limit;
};

struct horde_query_options : page_options {
    int radius = 0;
    int radius_z = 0;
    int flavors = all_horde_flavors;
    std::optional<std::string> monster;
    bool horde_only = false;
};

lua_Integer require_integer(
    const sol::object &requested,
    const std::string &api_name,
    const std::string &option_name )
{
    if( !requested.is<lua_Integer>() ) {
        throw std::invalid_argument(
            api_name + " option '" + option_name + "' must be an integer" );
    }
    return requested.as<lua_Integer>();
}

bool require_boolean(
    const sol::object &requested,
    const std::string &api_name,
    const std::string &option_name )
{
    if( !requested.is<bool>() ) {
        throw std::invalid_argument(
            api_name + " option '" + option_name + "' must be a boolean" );
    }
    return requested.as<bool>();
}

page_options read_page_options(
    const sol::optional<sol::table> &requested,
    const std::string &api_name )
{
    page_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                api_name + " option keys must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        if( key == "offset" ) {
            const lua_Integer value = require_integer(
                                          entry.second, api_name, key );
            if( value < 0 ||
                value > static_cast<lua_Integer>( maximum_offset ) ) {
                throw std::invalid_argument(
                    api_name + " offset is outside its limit" );
            }
            result.offset = static_cast<std::size_t>( value );
        } else if( key == "limit" ) {
            const lua_Integer value = require_integer(
                                          entry.second, api_name, key );
            if( value < 0 ) {
                throw std::invalid_argument(
                    api_name + " limit cannot be negative" );
            }
            result.limit = static_cast<int>(
                               std::min<lua_Integer>(
                                   value, maximum_page_limit ) );
        } else {
            throw std::invalid_argument(
                api_name + " received unknown option '" + key + "'" );
        }
    }
    return result;
}

int read_flavors(
    const sol::object &requested,
    const std::string &api_name )
{
    if( !requested.is<sol::table>() ) {
        throw std::invalid_argument(
            api_name + " option 'flavors' must be an array" );
    }
    std::vector<std::pair<std::size_t, int>> ordered;
    for( const auto &entry : requested.as<sol::table>() ) {
        if( !entry.first.is<lua_Integer>() ) {
            throw std::invalid_argument(
                api_name + " option 'flavors' must use integer keys" );
        }
        const lua_Integer index = entry.first.as<lua_Integer>();
        if( index < 1 || index > 4 ) {
            throw std::invalid_argument(
                api_name + " option 'flavors' supports at most four values" );
        }
        if( !entry.second.is<std::string>() ) {
            throw std::invalid_argument(
                api_name + " option 'flavors' values must be strings" );
        }
        ordered.emplace_back(
            static_cast<std::size_t>( index ),
            horde_flavor_value(
                entry.second.as<std::string>(), api_name ) );
    }
    std::sort(
        ordered.begin(), ordered.end(),
    []( const auto & lhs, const auto & rhs ) {
        return lhs.first < rhs.first;
    } );
    int result = 0;
    for( std::size_t index = 0; index < ordered.size(); ++index ) {
        if( ordered[index].first != index + 1 ) {
            throw std::invalid_argument(
                api_name + " option 'flavors' must use consecutive keys" );
        }
        result |= ordered[index].second;
    }
    return result;
}

horde_query_options read_query_options(
    const sol::optional<sol::table> &requested,
    const std::string &api_name,
    const bool legacy )
{
    horde_query_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                api_name + " option keys must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        if( key == "offset" ) {
            const lua_Integer value = require_integer(
                                          entry.second, api_name, key );
            if( value < 0 ||
                value > static_cast<lua_Integer>( maximum_offset ) ) {
                throw std::invalid_argument(
                    api_name + " offset is outside its limit" );
            }
            result.offset = static_cast<std::size_t>( value );
        } else if( key == "limit" ) {
            const lua_Integer value = require_integer(
                                          entry.second, api_name, key );
            if( value < 0 ) {
                throw std::invalid_argument(
                    api_name + " limit cannot be negative" );
            }
            result.limit = static_cast<int>(
                               std::min<lua_Integer>(
                                   value, maximum_page_limit ) );
        } else if( key == "radius" ) {
            const lua_Integer value = require_integer(
                                          entry.second, api_name, key );
            if( value < 0 || value > maximum_query_radius ) {
                throw std::invalid_argument(
                    api_name + " radius must be within 0..30" );
            }
            result.radius = static_cast<int>( value );
        } else if( key == "radius_z" ) {
            const lua_Integer value = require_integer(
                                          entry.second, api_name, key );
            if( value < 0 || value > maximum_query_radius_z ) {
                throw std::invalid_argument(
                    api_name + " radius_z must be within 0..5" );
            }
            result.radius_z = static_cast<int>( value );
        } else if( key == "flavors" && !legacy ) {
            result.flavors = read_flavors( entry.second, api_name );
        } else if( key == "monster" && !legacy ) {
            if( !entry.second.is<script_game_id>() ) {
                throw std::invalid_argument(
                    api_name +
                    " option 'monster' must be GameId<monster>" );
            }
            const script_game_id &id =
                entry.second.as<const script_game_id &>();
            if( id.kind() != "monster" || !id.is_valid() ) {
                throw std::invalid_argument(
                    api_name +
                    " option 'monster' must be a valid GameId<monster>" );
            }
            result.monster = id.value();
        } else if( key == "horde_only" && legacy ) {
            result.horde_only = require_boolean(
                                    entry.second, api_name, key );
        } else {
            throw std::invalid_argument(
                api_name + " received unknown option '" + key + "'" );
        }
    }
    return result;
}

tripoint_abs_omt require_absolute_omt(
    const script_tripoint_coord &position,
    const std::string &api_name )
{
    if( position.native_origin() != coords::origin::abs ||
        position.native_scale() != coords::scale::overmap_terrain ) {
        throw std::invalid_argument(
            api_name +
            " requires an absolute overmap-terrain Tripoint" );
    }
    const tripoint_abs_omt result( position.to_native() );
    if( result.z() < -OVERMAP_DEPTH ||
        result.z() > OVERMAP_HEIGHT ) {
        throw std::invalid_argument(
            api_name + " z-level is outside the overmap bounds" );
    }
    return result;
}

tripoint_abs_ms require_absolute_ms(
    const script_tripoint_coord &position,
    const std::string &api_name )
{
    if( position.native_origin() != coords::origin::abs ||
        position.native_scale() != coords::scale::map_square ) {
        throw std::invalid_argument(
            api_name +
            " requires an absolute map-square Tripoint" );
    }
    const tripoint_abs_ms result( position.to_native() );
    if( result.z() < -OVERMAP_DEPTH ||
        result.z() > OVERMAP_HEIGHT ) {
        throw std::invalid_argument(
            api_name + " z-level is outside the overmap bounds" );
    }
    return result;
}

tripoint_abs_sm require_absolute_sm(
    const script_tripoint_coord &position,
    const std::string &api_name )
{
    if( position.native_origin() != coords::origin::abs ||
        position.native_scale() != coords::scale::submap ) {
        throw std::invalid_argument(
            api_name +
            " requires an absolute submap Tripoint" );
    }
    const tripoint_abs_sm result( position.to_native() );
    if( result.z() < -OVERMAP_DEPTH ||
        result.z() > OVERMAP_HEIGHT ) {
        throw std::invalid_argument(
            api_name + " z-level is outside the overmap bounds" );
    }
    return result;
}

int checked_axis_offset(
    const int value, const int offset,
    const std::string &api_name )
{
    const std::int64_t result =
        static_cast<std::int64_t>( value ) + offset;
    if( result < std::numeric_limits<int>::min() ||
        result > std::numeric_limits<int>::max() ) {
        throw std::invalid_argument(
            api_name + " query bounds overflow native coordinates" );
    }
    return static_cast<int>( result );
}

struct overmap_scan_bounds {
    point_abs_om minimum;
    point_abs_om maximum;
};

overmap_scan_bounds query_overmap_bounds(
    const tripoint_abs_omt &center,
    const int radius,
    const std::string &api_name )
{
    const tripoint_abs_omt minimum(
        checked_axis_offset(
            center.x(), -radius, api_name ),
        checked_axis_offset(
            center.y(), -radius, api_name ),
        center.z() );
    const tripoint_abs_omt maximum(
        checked_axis_offset(
            center.x(), radius, api_name ),
        checked_axis_offset(
            center.y(), radius, api_name ),
        center.z() );
    return {
        project_to<coords::om>( minimum.xy() ),
        project_to<coords::om>( maximum.xy() )
    };
}

bool within_query(
    const tripoint_abs_omt &position,
    const tripoint_abs_omt &center,
    const horde_query_options &options )
{
    const std::int64_t dx =
        static_cast<std::int64_t>( position.x() ) - center.x();
    const std::int64_t dy =
        static_cast<std::int64_t>( position.y() ) - center.y();
    const std::int64_t dz =
        static_cast<std::int64_t>( position.z() ) - center.z();
    return dx >= -options.radius && dx <= options.radius &&
           dy >= -options.radius && dy <= options.radius &&
           dz >= -options.radius_z && dz <= options.radius_z;
}

struct entity_match {
    tripoint_abs_ms position;
    horde_entity *entry = nullptr;
    overmap *owner = nullptr;
    int flavor = 0;
    horde_map::iterator native_iterator;
};

struct entity_scan {
    std::vector<entity_match> matches;
    std::size_t existing_overmaps = 0;
};

entity_scan scan_entities(
    const tripoint_abs_omt &center,
    const horde_query_options &options,
    const std::string &api_name )
{
    entity_scan result;
    const overmap_scan_bounds bounds =
        query_overmap_bounds(
            center, options.radius, api_name );
    for( int x = bounds.minimum.x();
         x <= bounds.maximum.x(); ++x ) {
        for( int y = bounds.minimum.y();
             y <= bounds.maximum.y(); ++y ) {
            overmap *existing =
                overmap_buffer.get_existing(
                    point_abs_om( x, y ) );
            if( existing == nullptr ) {
                continue;
            }
            ++result.existing_overmaps;
            for( const int flavor : individual_horde_flavors ) {
                if( !( options.flavors & flavor ) ) {
                    continue;
                }
                for( horde_map::iterator entry =
                         existing->hordes.get_view( flavor ).begin();
                     entry != existing->hordes.end(); ++entry ) {
                    const tripoint_abs_omt position =
                        project_to<coords::omt>( entry->first );
                    if( !within_query(
                            position, center, options ) ) {
                        continue;
                    }
                    const std::string monster =
                        entry->second.get_type()->id.str();
                    if( options.monster &&
                        monster != *options.monster ) {
                        continue;
                    }
                    result.matches.push_back( {
                        entry->first, &entry->second,
                        existing, flavor, entry
                    } );
                }
            }
        }
    }
    std::sort(
        result.matches.begin(), result.matches.end(),
    []( const entity_match & lhs, const entity_match & rhs ) {
        if( lhs.position != rhs.position ) {
            return lhs.position < rhs.position;
        }
        if( lhs.flavor != rhs.flavor ) {
            return lhs.flavor < rhs.flavor;
        }
        return lhs.entry->get_type()->id.str() <
               rhs.entry->get_type()->id.str();
    } );
    return result;
}

struct legacy_match {
    mongroup *group = nullptr;
};

struct legacy_scan {
    std::vector<legacy_match> matches;
    std::size_t existing_overmaps = 0;
};

legacy_scan scan_legacy_groups(
    const tripoint_abs_omt &center,
    const horde_query_options &options,
    const std::string &api_name )
{
    legacy_scan result;
    const overmap_scan_bounds bounds =
        query_overmap_bounds(
            center, options.radius, api_name );
    for( int x = bounds.minimum.x();
         x <= bounds.maximum.x(); ++x ) {
        for( int y = bounds.minimum.y();
             y <= bounds.maximum.y(); ++y ) {
            if( overmap_buffer.get_existing(
                    point_abs_om( x, y ) ) != nullptr ) {
                ++result.existing_overmaps;
            }
        }
    }

    const int minimum_x = checked_axis_offset(
                              center.x(), -options.radius, api_name );
    const int maximum_x = checked_axis_offset(
                              center.x(), options.radius, api_name );
    const int minimum_y = checked_axis_offset(
                              center.y(), -options.radius, api_name );
    const int maximum_y = checked_axis_offset(
                              center.y(), options.radius, api_name );
    const int minimum_z = std::max(
                              -OVERMAP_DEPTH,
                              center.z() - options.radius_z );
    const int maximum_z = std::min(
                              OVERMAP_HEIGHT,
                              center.z() + options.radius_z );
    std::unordered_set<const mongroup *> seen;
    for( int z = minimum_z; z <= maximum_z; ++z ) {
        for( int x = minimum_x; x <= maximum_x; ++x ) {
            for( int y = minimum_y; y <= maximum_y; ++y ) {
                const tripoint_abs_omt omt( x, y, z );
                const tripoint_abs_sm base =
                    project_to<coords::sm>( omt );
                for( const point &offset :
                std::array<point, 4> {
                point::zero, point::south,
                point::east, point::south_east
            } ) {
                    for( mongroup *group :
                         overmap_buffer.groups_at(
                             base + offset ) ) {
                        if( !seen.insert( group ).second ) {
                            continue;
                        }
                        if( options.horde_only &&
                            !group->horde ) {
                            continue;
                        }
                        result.matches.push_back( { group } );
                    }
                }
            }
        }
    }
    std::sort(
        result.matches.begin(), result.matches.end(),
    []( const legacy_match & lhs, const legacy_match & rhs ) {
        if( lhs.group->abs_pos != rhs.group->abs_pos ) {
            return lhs.group->abs_pos < rhs.group->abs_pos;
        }
        if( lhs.group->type != rhs.group->type ) {
            return lhs.group->type.str() <
                   rhs.group->type.str();
        }
        if( lhs.group->population != rhs.group->population ) {
            return lhs.group->population <
                   rhs.group->population;
        }
        return lhs.group < rhs.group;
    } );
    return result;
}

std::string legacy_behavior_name(
    const mongroup::horde_behaviour behavior )
{
    switch( behavior ) {
        case mongroup::horde_behaviour::none:
            return "none";
        case mongroup::horde_behaviour::city:
            return "city";
        case mongroup::horde_behaviour::roam:
            return "roam";
        case mongroup::horde_behaviour::nemesis:
            return "nemesis";
        case mongroup::horde_behaviour::last:
            break;
    }
    throw std::invalid_argument( "unknown legacy horde behavior" );
}

mongroup::horde_behaviour require_legacy_behavior(
    const std::string &requested,
    const std::string &api_name )
{
    for( const mongroup::horde_behaviour behavior : {
             mongroup::horde_behaviour::none,
             mongroup::horde_behaviour::city,
             mongroup::horde_behaviour::roam,
             mongroup::horde_behaviour::nemesis
         } ) {
        if( legacy_behavior_name( behavior ) == requested ) {
            return behavior;
        }
    }
    throw std::invalid_argument(
        api_name + " received unknown behavior '" + requested + "'" );
}

std::string holiday_name( const holiday event )
{
    switch( event ) {
        case holiday::none:
            return "none";
        case holiday::new_year:
            return "new_year";
        case holiday::easter:
            return "easter";
        case holiday::independence_day:
            return "independence_day";
        case holiday::halloween:
            return "halloween";
        case holiday::thanksgiving:
            return "thanksgiving";
        case holiday::christmas:
            return "christmas";
        case holiday::num_holiday:
            return "any";
    }
    return "unknown";
}

sol::table string_page(
    sol::state_view lua,
    const std::vector<std::string> &values,
    const std::size_t limit )
{
    const std::size_t returned =
        std::min( values.size(), limit );
    sol::table items = lua.create_table(
                           static_cast<int>( returned ), 0 );
    for( std::size_t index = 0;
         index < returned; ++index ) {
        items[index + 1] = values[index];
    }
    sol::table result = lua.create_table();
    result["items"] = std::move( items );
    result["total"] = values.size();
    result["returned"] = returned;
    result["limit"] = limit;
    result["truncated"] = returned < values.size();
    return result;
}

sol::table snapshot_group_entry(
    sol::state_view lua,
    const MonsterGroupEntry &entry )
{
    sol::table result = lua.create_table();
    result["kind"] = entry.is_group() ?
                     "group" : "monster";
    if( entry.is_group() ) {
        result["id"] = script_game_id(
                           "monster_group",
                           entry.group.str() );
    } else {
        result["id"] = script_game_id(
                           "monster",
                           entry.mtype.str() );
    }
    result["frequency"] = entry.frequency;
    result["cost_multiplier"] =
        entry.cost_multiplier;
    result["pack_minimum"] =
        entry.pack_minimum;
    result["pack_maximum"] =
        entry.pack_maximum;
    result["starts"] =
        script_time_duration::from_native(
            entry.starts );
    result["ends"] =
        script_time_duration::from_native(
            entry.ends );
    result["lasts_forever"] =
        entry.lasts_forever();
    result["event"] =
        holiday_name( entry.event );
    result["conditions"] = string_page(
                               lua, entry.conditions,
                               maximum_conditions );
    return result;
}

sol::table snapshot_group_definition(
    sol::state_view lua,
    const MonsterGroup &definition,
    const page_options &options )
{
    sol::table result = lua.create_table();
    result["id"] = script_game_id(
                       "monster_group",
                       definition.id.str() );
    if( definition.defaultMonster.is_null() ) {
        result["default_monster"] = sol::nil;
    } else {
        result["default_monster"] =
            script_game_id(
                "monster",
                definition.defaultMonster.str() );
    }
    result["is_animal"] = definition.is_animal;
    result["replace_monster_group"] =
        definition.replace_monster_group;
    if( definition.new_monster_group.is_null() ) {
        result["new_monster_group"] = sol::nil;
    } else {
        result["new_monster_group"] =
            script_game_id(
                "monster_group",
                definition.new_monster_group.str() );
    }
    result["replacement_time"] =
        script_time_duration::from_native(
            definition.monster_group_time );
    result["safe"] = definition.is_safe;
    result["frequency_total"] =
        definition.freq_total;

    const std::size_t offset =
        std::min(
            options.offset,
            definition.monsters.size() );
    const std::size_t returned =
        std::min<std::size_t>(
            definition.monsters.size() - offset,
            static_cast<std::size_t>(
                options.limit ) );
    sol::table entries = lua.create_table(
                             static_cast<int>( returned ), 0 );
    for( std::size_t index = 0;
         index < returned; ++index ) {
        entries[index + 1] =
            snapshot_group_entry(
                lua,
                definition.monsters[
             offset + index] );
    }
    sol::table page = lua.create_table();
    page["items"] = std::move( entries );
    page["total"] =
        definition.monsters.size();
    page["offset"] = offset;
    page["limit"] = options.limit;
    page["returned"] = returned;
    page["has_more"] =
        offset + returned <
        definition.monsters.size();
    result["entries"] = std::move( page );
    return result;
}

sol::table list_group_definitions(
    sol::this_state lua,
    const sol::optional<sol::table> &requested )
{
    constexpr std::string_view api_name =
        "game.hordes.definitions";
    const page_options options =
        read_page_options(
            requested, std::string( api_name ) );
    const std::map<mongroup_id, MonsterGroup> &definitions =
        MonsterGroupManager::Get_all_Groups();
    const std::size_t offset =
        std::min( options.offset, definitions.size() );
    const std::size_t returned =
        std::min<std::size_t>(
            definitions.size() - offset,
            static_cast<std::size_t>(
                options.limit ) );
    sol::state_view state( lua );
    sol::table items = state.create_table(
                           static_cast<int>( returned ), 0 );
    auto entry = definitions.begin();
    std::advance(
        entry,
        static_cast<std::ptrdiff_t>( offset ) );
    for( std::size_t index = 0;
         index < returned; ++index, ++entry ) {
        sol::table value = state.create_table();
        value["id"] = script_game_id(
                          "monster_group",
                          entry->first.str() );
        value["default_monster"] =
            entry->second.defaultMonster.is_null() ?
            sol::make_object( state, sol::nil ) :
            sol::make_object(
                state,
                script_game_id(
                    "monster",
                    entry->second.defaultMonster.str() ) );
        value["entries"] =
            entry->second.monsters.size();
        value["is_animal"] =
            entry->second.is_animal;
        value["safe"] =
            entry->second.is_safe;
        items[index + 1] = std::move( value );
    }
    sol::table result = state.create_table();
    result["items"] = std::move( items );
    result["total"] = definitions.size();
    result["offset"] = offset;
    result["limit"] = options.limit;
    result["returned"] = returned;
    result["has_more"] =
        offset + returned < definitions.size();
    return result;
}

sol::table get_group_definition(
    sol::this_state lua,
    const script_game_id &requested_id,
    const sol::optional<sol::table> &requested )
{
    constexpr std::string_view api_name =
        "game.hordes.definition";
    if( requested_id.kind() != "monster_group" ||
        !requested_id.is_valid() ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires a valid GameId<monster_group>" );
    }
    const page_options options =
        read_page_options(
            requested, std::string( api_name ) );
    sol::state_view state( lua );
    return snapshot_group_definition(
               state,
               MonsterGroupManager::GetMonsterGroup(
                   mongroup_id(
                       requested_id.value() ) ),
               options );
}

sol::table group_monsters(
    sol::this_state lua,
    const script_game_id &requested_group,
    const bool recursive,
    const sol::optional<sol::table> &requested )
{
    constexpr std::string_view api_name =
        "game.hordes.monsters";
    if( requested_group.kind() != "monster_group" ||
        !requested_group.is_valid() ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires a valid GameId<monster_group>" );
    }
    const page_options options =
        read_page_options(
            requested, std::string( api_name ) );
    std::vector<mtype_id> monsters =
        MonsterGroupManager::GetMonstersFromGroup(
            mongroup_id( requested_group.value() ),
            recursive );
    std::sort(
        monsters.begin(), monsters.end(),
    []( const mtype_id & lhs, const mtype_id & rhs ) {
        return lhs.str() < rhs.str();
    } );
    monsters.erase(
        std::unique(
            monsters.begin(), monsters.end() ),
        monsters.end() );
    const std::size_t offset =
        std::min( options.offset, monsters.size() );
    const std::size_t returned =
        std::min<std::size_t>(
            monsters.size() - offset,
            static_cast<std::size_t>(
                options.limit ) );
    sol::state_view state( lua );
    sol::table items = state.create_table(
                           static_cast<int>( returned ), 0 );
    for( std::size_t index = 0;
         index < returned; ++index ) {
        items[index + 1] =
            script_game_id(
                "monster",
                monsters[offset + index].str() );
    }
    sol::table result = state.create_table();
    result["items"] = std::move( items );
    result["group"] = requested_group;
    result["recursive"] = recursive;
    result["total"] = monsters.size();
    result["offset"] = offset;
    result["limit"] = options.limit;
    result["returned"] = returned;
    result["has_more"] =
        offset + returned < monsters.size();
    return result;
}

bool group_contains(
    const script_game_id &requested_group,
    const script_game_id &requested_monster )
{
    constexpr std::string_view api_name =
        "game.hordes.contains";
    if( requested_group.kind() != "monster_group" ||
        !requested_group.is_valid() ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires a valid GameId<monster_group>" );
    }
    if( requested_monster.kind() != "monster" ||
        !requested_monster.is_valid() ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires a valid GameId<monster>" );
    }
    return MonsterGroupManager::IsMonsterInGroup(
               mongroup_id( requested_group.value() ),
               mtype_id( requested_monster.value() ) );
}

sol::table snapshot_entity(
    sol::state_view lua,
    const entity_match &match,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    const horde_entity &entry = *match.entry;
    sol::table result = lua.create_table();
    result["token"] = horde_entity_token(
                          match.position, entry,
                          runtime_generation,
                          world_generation );
    result["position"] =
        script_tripoint_coord::from_native(
            coords::origin::abs,
            coords::scale::map_square,
            match.position.raw() );
    result["overmap_position"] =
        script_tripoint_coord::from_native(
            coords::origin::abs,
            coords::scale::overmap_terrain,
            project_to<coords::omt>(
                match.position ).raw() );
    result["monster"] = script_game_id(
                            "monster",
                            entry.get_type()->id.str() );
    result["name"] =
        entry.get_type()->nname();
    result["flavor"] =
        horde_flavor_name( match.flavor );
    result["active"] = entry.is_active();
    result["heavy"] =
        entry.monster_data != nullptr;
    result["destination"] =
        script_tripoint_coord::from_native(
            coords::origin::abs,
            coords::scale::map_square,
            entry.destination.raw() );
    result["tracking_intensity"] =
        entry.tracking_intensity;
    result["moves"] = entry.moves;
    result["last_processed"] =
        script_time_point::from_native(
            entry.last_processed );
    return result;
}

sol::table snapshot_legacy_group(
    sol::state_view lua,
    const mongroup &group,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    sol::table result = lua.create_table();
    result["token"] = legacy_horde_token(
                          group,
                          runtime_generation,
                          world_generation );
    result["group"] = script_game_id(
                          "monster_group",
                          group.type.str() );
    result["position"] =
        script_tripoint_coord::from_native(
            coords::origin::abs,
            coords::scale::submap,
            group.abs_pos.raw() );
    result["overmap_position"] =
        script_tripoint_coord::from_native(
            coords::origin::abs,
            coords::scale::overmap_terrain,
            project_to<coords::omt>(
                group.abs_pos ).raw() );
    result["target"] =
        script_tripoint_coord::from_native(
            coords::origin::abs,
            coords::scale::submap,
            tripoint_abs_sm(
                group.target,
                group.abs_pos.z() ).raw() );
    result["nemesis_target"] =
        script_tripoint_coord::from_native(
            coords::origin::abs,
            coords::scale::submap,
            tripoint_abs_sm(
                group.nemesis_target,
                group.abs_pos.z() ).raw() );
    result["population"] = group.population;
    result["tracked_monsters"] =
        group.monsters.size();
    result["interest"] = group.interest;
    result["dying"] = group.dying;
    result["horde"] = group.horde;
    result["behavior"] =
        legacy_behavior_name( group.behaviour );
    result["empty"] = group.empty();
    result["safe"] = group.is_safe();
    result["average_speed"] = group.avg_speed();

    const std::size_t returned =
        std::min(
            group.monsters.size(),
            maximum_legacy_monsters );
    sol::table monsters = lua.create_table(
                              static_cast<int>( returned ), 0 );
    for( std::size_t index = 0;
         index < returned; ++index ) {
        const monster &entry =
            group.monsters[index];
        sol::table value = lua.create_table();
        value["id"] = script_game_id(
                          "monster",
                          entry.type->id.str() );
        value["name"] = entry.name();
        value["position"] =
            script_tripoint_coord::from_native(
                coords::origin::abs,
                coords::scale::map_square,
                entry.pos_abs().raw() );
        monsters[index + 1] =
            std::move( value );
    }
    sol::table monster_page = lua.create_table();
    monster_page["items"] =
        std::move( monsters );
    monster_page["total"] =
        group.monsters.size();
    monster_page["limit"] =
        maximum_legacy_monsters;
    monster_page["returned"] = returned;
    monster_page["truncated"] =
        returned < group.monsters.size();
    result["monsters"] =
        std::move( monster_page );
    return result;
}

std::optional<entity_match> resolve_entity_token(
    const horde_entity_token &token,
    const std::size_t runtime_generation,
    const std::size_t world_generation,
    std::optional<game_handle_error> &error )
{
    if( token.runtime_generation() != runtime_generation ) {
        error = game_handle_error{
            "stale_runtime",
            "HordeEntityToken belongs to an inactive Lua runtime generation"
        };
        return std::nullopt;
    }
    if( token.world_generation() != world_generation ) {
        error = game_handle_error{
            "stale_world",
            "HordeEntityToken belongs to a different world generation"
        };
        return std::nullopt;
    }
    point_abs_om overmap_position;
    tripoint_om_ms local_position;
    std::tie( overmap_position, local_position ) =
        project_remain<coords::om>(
            token.native_position() );
    overmap *existing =
        overmap_buffer.get_existing(
            overmap_position );
    if( existing != nullptr ) {
        for( const int flavor : individual_horde_flavors ) {
            for( horde_map::iterator entry =
                     existing->hordes.get_view( flavor ).begin();
                 entry != existing->hordes.end(); ++entry ) {
                if( entry->first !=
                    token.native_position() ) {
                    continue;
                }
                if( entry->second.get_type()->id.str() !=
                    token.native_monster() ) {
                    continue;
                }
                if( reinterpret_cast<std::uintptr_t>(
                        &entry->second ) !=
                    token.native_identity() ) {
                    continue;
                }
                return entity_match{
                    entry->first, &entry->second,
                    existing, flavor, entry
                };
            }
        }
    }
    error = game_handle_error{
        "missing_horde_entity",
        "The horde entity referenced by this token no longer exists"
    };
    return std::nullopt;
}

mongroup *resolve_legacy_token(
    const legacy_horde_token &token,
    const std::size_t runtime_generation,
    const std::size_t world_generation,
    std::optional<game_handle_error> &error )
{
    if( token.runtime_generation() != runtime_generation ) {
        error = game_handle_error{
            "stale_runtime",
            "LegacyHordeToken belongs to an inactive Lua runtime generation"
        };
        return nullptr;
    }
    if( token.world_generation() != world_generation ) {
        error = game_handle_error{
            "stale_world",
            "LegacyHordeToken belongs to a different world generation"
        };
        return nullptr;
    }
    for( mongroup *group :
         overmap_buffer.groups_at(
             token.native_position() ) ) {
        if( group->type.str() !=
            token.native_group() ) {
            continue;
        }
        if( reinterpret_cast<std::uintptr_t>( group ) !=
            token.native_identity() ) {
            continue;
        }
        return group;
    }
    error = game_handle_error{
        "missing_legacy_horde",
        "The legacy monster group referenced by this token no longer exists"
    };
    return nullptr;
}

sol::table list_entities(
    sol::this_state lua,
    const script_tripoint_coord &center,
    const sol::optional<sol::table> &requested,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name =
        "game.hordes.entities";
    const tripoint_abs_omt native_center =
        require_absolute_omt(
            center, std::string( api_name ) );
    const horde_query_options options =
        read_query_options(
            requested, std::string( api_name ),
            false );
    const entity_scan scan =
        scan_entities(
            native_center, options,
            std::string( api_name ) );
    const std::size_t offset =
        std::min(
            options.offset,
            scan.matches.size() );
    const std::size_t returned =
        std::min<std::size_t>(
            scan.matches.size() - offset,
            static_cast<std::size_t>(
                options.limit ) );
    sol::state_view state( lua );
    sol::table items = state.create_table(
                           static_cast<int>( returned ), 0 );
    for( std::size_t index = 0;
         index < returned; ++index ) {
        items[index + 1] =
            snapshot_entity(
                state,
                scan.matches[offset + index],
                runtime_generation,
                world_generation );
    }
    sol::table result = state.create_table();
    result["items"] = std::move( items );
    result["total"] = scan.matches.size();
    result["offset"] = offset;
    result["limit"] = options.limit;
    result["returned"] = returned;
    result["has_more"] =
        offset + returned < scan.matches.size();
    result["radius"] = options.radius;
    result["radius_z"] = options.radius_z;
    result["existing_overmaps"] =
        scan.existing_overmaps;
    result["existing_only"] = true;
    result["flavors"] = options.flavors;
    return result;
}

sol::table list_legacy_groups(
    sol::this_state lua,
    const script_tripoint_coord &center,
    const sol::optional<sol::table> &requested,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name =
        "game.hordes.legacy_groups";
    const tripoint_abs_omt native_center =
        require_absolute_omt(
            center, std::string( api_name ) );
    const horde_query_options options =
        read_query_options(
            requested, std::string( api_name ),
            true );
    const legacy_scan scan =
        scan_legacy_groups(
            native_center, options,
            std::string( api_name ) );
    const std::size_t offset =
        std::min(
            options.offset,
            scan.matches.size() );
    const std::size_t returned =
        std::min<std::size_t>(
            scan.matches.size() - offset,
            static_cast<std::size_t>(
                options.limit ) );
    sol::state_view state( lua );
    sol::table items = state.create_table(
                           static_cast<int>( returned ), 0 );
    for( std::size_t index = 0;
         index < returned; ++index ) {
        items[index + 1] =
            snapshot_legacy_group(
                state,
                *scan.matches[offset + index].group,
                runtime_generation,
                world_generation );
    }
    sol::table result = state.create_table();
    result["items"] = std::move( items );
    result["total"] = scan.matches.size();
    result["offset"] = offset;
    result["limit"] = options.limit;
    result["returned"] = returned;
    result["has_more"] =
        offset + returned < scan.matches.size();
    result["radius"] = options.radius;
    result["radius_z"] = options.radius_z;
    result["horde_only"] = options.horde_only;
    result["existing_overmaps"] =
        scan.existing_overmaps;
    result["existing_only"] = true;
    return result;
}

sol::table get_entity(
    sol::this_state lua,
    const horde_entity_token &token,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    const std::optional<entity_match> resolved =
        resolve_entity_token(
            token, runtime_generation,
            world_generation, error );
    if( !resolved ) {
        return make_game_error_result(
                   state, *error );
    }
    sol::table value = snapshot_entity(
                           state, *resolved,
                           runtime_generation,
                           world_generation );
    return make_game_value_result(
               state,
               sol::make_object(
                   state, std::move( value ) ) );
}

sol::table get_legacy_group(
    sol::this_state lua,
    const legacy_horde_token &token,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    mongroup *resolved =
        resolve_legacy_token(
            token, runtime_generation,
            world_generation, error );
    if( resolved == nullptr ) {
        return make_game_error_result(
                   state, *error );
    }
    sol::table value = snapshot_legacy_group(
                           state, *resolved,
                           runtime_generation,
                           world_generation );
    return make_game_value_result(
               state,
               sol::make_object(
                   state, std::move( value ) ) );
}

sol::table spawn_entity(
    sol::this_state lua,
    const script_tripoint_coord &position,
    const script_game_id &requested_monster,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name =
        "game.hordes.spawn_entity";
    if( requested_monster.kind() != "monster" ||
        !requested_monster.is_valid() ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires a valid GameId<monster>" );
    }
    const tripoint_abs_ms native_position =
        require_absolute_ms(
            position, std::string( api_name ) );
    point_abs_om overmap_position;
    tripoint_om_ms local_position;
    std::tie( overmap_position, local_position ) =
        project_remain<coords::om>(
            native_position );
    overmap *existing =
        overmap_buffer.get_existing(
            overmap_position );
    sol::state_view state( lua );
    if( existing == nullptr ) {
        return make_game_error_result(
        state, game_handle_error{
            "not_found",
            "The target overmap does not already exist"
        } );
    }
    for( const int flavor : individual_horde_flavors ) {
        for( horde_map::iterator entry =
                 existing->hordes.get_view( flavor ).begin();
             entry != existing->hordes.end(); ++entry ) {
            if( entry->first == native_position ) {
                return make_game_error_result(
                state, game_handle_error{
                    "occupied",
                    "A horde entity already occupies the target map square"
                } );
            }
        }
    }
    const auto inserted =
        existing->hordes.spawn_entity(
            native_position,
            mtype_id(
                requested_monster.value() ) );
    if( !inserted ) {
        return make_game_error_result(
        state, game_handle_error{
            "rejected",
            "The engine rejected horde entity creation"
        } );
    }
    horde_entity *created =
        &( *inserted )->second;
    for( const int flavor : individual_horde_flavors ) {
        for( horde_map::iterator entry =
                 existing->hordes.get_view( flavor ).begin();
             entry != existing->hordes.end(); ++entry ) {
            if( &entry->second == created ) {
                sol::table value = snapshot_entity(
                                       state,
                entity_match{
                    entry->first,
                    &entry->second,
                    existing, flavor,
                    entry
                },
                runtime_generation,
                world_generation );
                return make_game_value_result(
                           state,
                           sol::make_object(
                               state,
                               std::move( value ) ) );
            }
        }
    }
    return make_game_error_result(
    state, game_handle_error{
        "rejected",
        "The created horde entity could not be resolved"
    } );
}

sol::table alert_entity(
    sol::this_state lua,
    const horde_entity_token &token,
    const script_tripoint_coord &destination,
    const int intensity,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name =
        "game.hordes.alert_entity";
    if( intensity < 0 ||
        intensity > maximum_tracking_intensity ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " intensity must be within 0..1000000" );
    }
    const tripoint_abs_ms native_destination =
        require_absolute_ms(
            destination, std::string( api_name ) );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    const std::optional<entity_match> resolved =
        resolve_entity_token(
            token, runtime_generation,
            world_generation, error );
    if( !resolved ) {
        return make_game_error_result(
                   state, *error );
    }
    sol::table before = snapshot_entity(
                            state, *resolved,
                            runtime_generation,
                            world_generation );
    horde_map::node_type node =
        resolved->owner->hordes.extract(
            resolved->native_iterator );
    node.mapped().destination =
        native_destination;
    node.mapped().tracking_intensity =
        intensity;
    resolved->owner->hordes.insert(
        std::move( node ) );
    std::optional<game_handle_error> after_error;
    const std::optional<entity_match> after =
        resolve_entity_token(
            token, runtime_generation,
            world_generation, after_error );
    if( !after ) {
        return make_game_error_result(
                   state, *after_error );
    }
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] = snapshot_entity(
                         state, *after,
                         runtime_generation,
                         world_generation );
    return make_game_value_result(
               state,
               sol::make_object(
                   state, std::move( value ) ) );
}

sol::table remove_entity(
    sol::this_state lua,
    const horde_entity_token &token,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    const std::optional<entity_match> resolved =
        resolve_entity_token(
            token, runtime_generation,
            world_generation, error );
    if( !resolved ) {
        return make_game_error_result(
                   state, *error );
    }
    sol::table value = snapshot_entity(
                           state, *resolved,
                           runtime_generation,
                           world_generation );
    resolved->owner->hordes.erase(
        resolved->native_iterator );
    value["removed"] = true;
    return make_game_value_result(
               state,
               sol::make_object(
                   state, std::move( value ) ) );
}

struct legacy_settings {
    std::optional<unsigned int> population;
    std::optional<int> interest;
    std::optional<bool> dying;
    std::optional<bool> horde;
    std::optional<mongroup::horde_behaviour> behavior;
    std::optional<tripoint_abs_sm> target;
    std::optional<tripoint_abs_sm> nemesis_target;
};

void read_legacy_setting(
    legacy_settings &settings,
    const std::string &key,
    const sol::object &value,
    const std::string &api_name )
{
    if( key == "population" ) {
        const lua_Integer requested =
            require_integer(
                value, api_name, key );
        if( requested < 0 ||
            requested >
            static_cast<lua_Integer>(
                maximum_legacy_population ) ) {
            throw std::invalid_argument(
                api_name +
                " population must be within 0..1000000" );
        }
        settings.population =
            static_cast<unsigned int>( requested );
    } else if( key == "interest" ) {
        const lua_Integer requested =
            require_integer(
                value, api_name, key );
        if( requested < 15 || requested > 100 ) {
            throw std::invalid_argument(
                api_name +
                " interest must be within 15..100" );
        }
        settings.interest =
            static_cast<int>( requested );
    } else if( key == "dying" ) {
        settings.dying =
            require_boolean(
                value, api_name, key );
    } else if( key == "horde" ) {
        settings.horde =
            require_boolean(
                value, api_name, key );
    } else if( key == "behavior" ) {
        if( !value.is<std::string>() ) {
            throw std::invalid_argument(
                api_name +
                " option 'behavior' must be a string" );
        }
        settings.behavior =
            require_legacy_behavior(
                value.as<std::string>(),
                api_name );
    } else if( key == "target" ||
               key == "nemesis_target" ) {
        if( !value.is<script_tripoint_coord>() ) {
            throw std::invalid_argument(
                api_name + " option '" + key +
                "' must be an absolute submap Tripoint" );
        }
        const tripoint_abs_sm requested =
            require_absolute_sm(
                value.as<const script_tripoint_coord &>(),
                api_name );
        if( key == "target" ) {
            settings.target = requested;
        } else {
            settings.nemesis_target = requested;
        }
    } else {
        throw std::invalid_argument(
            api_name + " received unknown option '" + key + "'" );
    }
}

legacy_settings read_legacy_settings(
    const sol::table &requested,
    const std::string &api_name )
{
    legacy_settings result;
    for( const auto &entry : requested ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                api_name + " option keys must be strings" );
        }
        read_legacy_setting(
            result,
            entry.first.as<std::string>(),
            entry.second,
            api_name );
    }
    return result;
}

void apply_legacy_settings(
    mongroup &group,
    const legacy_settings &settings,
    const std::string &api_name )
{
    if( settings.target &&
        settings.target->z() != group.abs_pos.z() ) {
        throw std::invalid_argument(
            api_name +
            " target must use the group's z-level" );
    }
    if( settings.nemesis_target &&
        settings.nemesis_target->z() !=
        group.abs_pos.z() ) {
        throw std::invalid_argument(
            api_name +
            " nemesis_target must use the group's z-level" );
    }
    if( settings.population ) {
        group.population = *settings.population;
    }
    if( settings.interest ) {
        group.set_interest( *settings.interest );
    }
    if( settings.dying ) {
        group.dying = *settings.dying;
    }
    if( settings.horde ) {
        group.horde = *settings.horde;
    }
    if( settings.behavior ) {
        group.behaviour = *settings.behavior;
    }
    if( settings.target ) {
        group.set_target(
            settings.target->xy() );
    }
    if( settings.nemesis_target ) {
        group.set_nemesis_target(
            settings.nemesis_target->xy() );
    }
}

sol::table spawn_legacy_group(
    sol::this_state lua,
    const sol::table &requested,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name =
        "game.hordes.spawn_legacy_group";
    std::optional<std::string> group_id;
    std::optional<tripoint_abs_sm> position;
    legacy_settings settings;
    settings.population = 100;
    settings.horde = true;
    settings.behavior =
        mongroup::horde_behaviour::roam;
    for( const auto &entry : requested ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                std::string( api_name ) +
                " option keys must be strings" );
        }
        const std::string key =
            entry.first.as<std::string>();
        if( key == "group" ) {
            if( !entry.second.is<script_game_id>() ) {
                throw std::invalid_argument(
                    std::string( api_name ) +
                    " option 'group' must be GameId<monster_group>" );
            }
            const script_game_id &id =
                entry.second.as<const script_game_id &>();
            if( id.kind() != "monster_group" ||
                !id.is_valid() ) {
                throw std::invalid_argument(
                    std::string( api_name ) +
                    " option 'group' must be a valid GameId<monster_group>" );
            }
            group_id = id.value();
        } else if( key == "position" ) {
            if( !entry.second.is<script_tripoint_coord>() ) {
                throw std::invalid_argument(
                    std::string( api_name ) +
                    " option 'position' must be an absolute submap Tripoint" );
            }
            position = require_absolute_sm(
                           entry.second.as<const script_tripoint_coord &>(),
                           std::string( api_name ) );
        } else {
            read_legacy_setting(
                settings, key, entry.second,
                std::string( api_name ) );
        }
    }
    if( !group_id || !position ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires group and position" );
    }
    mongroup created(
        mongroup_id( *group_id ),
        *position,
        settings.population.value_or( 100 ) );
    apply_legacy_settings(
        created, settings,
        std::string( api_name ) );
    mongroup *inserted =
        overmap_buffer.add_mongroup_existing(
            created );
    sol::state_view state( lua );
    if( inserted == nullptr ) {
        return make_game_error_result(
        state, game_handle_error{
            "not_found",
            "The target overmap does not already exist"
        } );
    }
    sol::table value = snapshot_legacy_group(
                           state, *inserted,
                           runtime_generation,
                           world_generation );
    return make_game_value_result(
               state,
               sol::make_object(
                   state, std::move( value ) ) );
}

sol::table update_legacy_group(
    sol::this_state lua,
    const legacy_horde_token &token,
    const sol::table &requested,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name =
        "game.hordes.update_legacy_group";
    const legacy_settings settings =
        read_legacy_settings(
            requested, std::string( api_name ) );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    mongroup *resolved =
        resolve_legacy_token(
            token, runtime_generation,
            world_generation, error );
    if( resolved == nullptr ) {
        return make_game_error_result(
                   state, *error );
    }
    sol::table before = snapshot_legacy_group(
                            state, *resolved,
                            runtime_generation,
                            world_generation );
    apply_legacy_settings(
        *resolved, settings,
        std::string( api_name ) );
    sol::table after = snapshot_legacy_group(
                           state, *resolved,
                           runtime_generation,
                           world_generation );
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] = std::move( after );
    return make_game_value_result(
               state,
               sol::make_object(
                   state, std::move( value ) ) );
}

sol::table remove_legacy_group(
    sol::this_state lua,
    const legacy_horde_token &token,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    mongroup *resolved =
        resolve_legacy_token(
            token, runtime_generation,
            world_generation, error );
    if( resolved == nullptr ) {
        return make_game_error_result(
                   state, *error );
    }
    sol::table value = snapshot_legacy_group(
                           state, *resolved,
                           runtime_generation,
                           world_generation );
    const bool removed =
        overmap_buffer.remove_mongroup_existing(
            token.native_position(), resolved );
    if( !removed ) {
        return make_game_error_result(
        state, game_handle_error{
            "missing_legacy_horde",
            "The legacy monster group disappeared before removal"
        } );
    }
    value["removed"] = true;
    return make_game_value_result(
               state,
               sol::make_object(
                   state, std::move( value ) ) );
}

sol::table horde_summary(
    sol::this_state lua,
    const script_tripoint_coord &position )
{
    constexpr std::string_view api_name =
        "game.hordes.summary";
    const tripoint_abs_omt native_position =
        require_absolute_omt(
            position, std::string( api_name ) );
    horde_query_options entity_options;
    const entity_scan entities =
        scan_entities(
            native_position, entity_options,
            std::string( api_name ) );
    horde_query_options legacy_options;
    legacy_options.horde_only = true;
    const legacy_scan legacy =
        scan_legacy_groups(
            native_position, legacy_options,
            std::string( api_name ) );

    std::size_t active = 0;
    std::size_t idle = 0;
    std::size_t dormant = 0;
    std::size_t immobile = 0;
    for( const entity_match &entry :
         entities.matches ) {
        switch( entry.flavor ) {
            case horde_map_flavors::active:
                ++active;
                break;
            case horde_map_flavors::idle:
                ++idle;
                break;
            case horde_map_flavors::dormant:
                ++dormant;
                break;
            case horde_map_flavors::immobile:
                ++immobile;
                break;
        }
    }
    std::uint64_t legacy_population = 0;
    for( const legacy_match &entry :
         legacy.matches ) {
        legacy_population +=
            entry.group->monsters.empty() ?
            entry.group->population :
            entry.group->monsters.size();
    }
    sol::state_view state( lua );
    sol::table result = state.create_table();
    result["position"] = position;
    result["entities"] =
        entities.matches.size();
    result["active"] = active;
    result["idle"] = idle;
    result["dormant"] = dormant;
    result["immobile"] = immobile;
    result["legacy_hordes"] =
        legacy.matches.size();
    result["legacy_population"] =
        legacy_population;
    result["estimated_size"] =
        legacy_population +
        entities.matches.size();
    result["has_horde"] =
        !entities.matches.empty() ||
        !legacy.matches.empty();
    result["existing_only"] = true;
    return result;
}

sol::table signal_hordes(
    sol::this_state lua,
    const script_tripoint_coord &position,
    const int power )
{
    constexpr std::string_view api_name =
        "game.hordes.signal";
    if( power < 0 ||
        power > maximum_signal_power ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " power must be within 0..60" );
    }
    const tripoint_abs_sm native_position =
        require_absolute_sm(
            position, std::string( api_name ) );
    overmap_buffer.signal_hordes(
        native_position, power );
    sol::state_view state( lua );
    sol::table value = state.create_table();
    value["position"] = position;
    value["power"] = power;
    value["accepted"] = true;
    value["existing_only"] = true;
    return make_game_value_result(
               state,
               sol::make_object(
                   state, std::move( value ) ) );
}

sol::table advance_hordes( sol::this_state lua )
{
    overmap_buffer.move_hordes();
    sol::state_view state( lua );
    sol::table value = state.create_table();
    value["accepted"] = true;
    value["turn"] =
        script_time_point::from_native(
            calendar::turn );
    value["existing_only"] = true;
    return make_game_value_result(
               state,
               sol::make_object(
                   state, std::move( value ) ) );
}

sol::table horde_limits( sol::this_state lua )
{
    sol::state_view state( lua );
    sol::table flavors = state.create_table( 4, 0 );
    for( std::size_t index = 0;
         index < individual_horde_flavors.size();
         ++index ) {
        flavors[index + 1] =
            horde_flavor_name(
                individual_horde_flavors[index] );
    }
    sol::table result = state.create_table();
    result["maximum_radius"] =
        maximum_query_radius;
    result["maximum_radius_z"] =
        maximum_query_radius_z;
    result["maximum_limit"] =
        maximum_page_limit;
    result["maximum_offset"] =
        maximum_offset;
    result["maximum_signal_power"] =
        maximum_signal_power;
    result["maximum_tracking_intensity"] =
        maximum_tracking_intensity;
    result["maximum_legacy_population"] =
        maximum_legacy_population;
    result["flavors"] = std::move( flavors );
    result["existing_only"] = true;
    return result;
}

} // namespace

void install_horde_api(
    sol::table &game,
    std::function<std::size_t()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write )
{
    sol::state_view lua( game.lua_state() );
    lua.new_usertype<horde_entity_token>(
        "HordeEntityToken", sol::no_constructor,
        "position",
        sol::property(
            &horde_entity_token::position ),
        "monster",
        sol::property(
            &horde_entity_token::monster ),
        "runtime_generation",
        sol::property(
            &horde_entity_token::runtime_generation ),
        "world_generation",
        sol::property(
            &horde_entity_token::world_generation ),
        "is_valid",
        [current_runtime_generation,
         current_world_generation,
         require_read](
    const horde_entity_token & token ) {
        require_read();
        std::optional<game_handle_error> error;
        return resolve_entity_token(
                   token,
                   current_runtime_generation(),
                   current_world_generation(),
                   error ).has_value();
    },
    sol::meta_function::to_string,
    &horde_entity_token::to_string,
    sol::meta_function::equal_to,
    []( const horde_entity_token & lhs,
        const horde_entity_token & rhs ) {
        return lhs == rhs;
    } );
    lua.new_usertype<legacy_horde_token>(
        "LegacyHordeToken", sol::no_constructor,
        "position",
        sol::property(
            &legacy_horde_token::position ),
        "group",
        sol::property(
            &legacy_horde_token::group ),
        "runtime_generation",
        sol::property(
            &legacy_horde_token::runtime_generation ),
        "world_generation",
        sol::property(
            &legacy_horde_token::world_generation ),
        "is_valid",
        [current_runtime_generation,
         current_world_generation,
         require_read](
    const legacy_horde_token & token ) {
        require_read();
        std::optional<game_handle_error> error;
        return resolve_legacy_token(
                   token,
                   current_runtime_generation(),
                   current_world_generation(),
                   error ) != nullptr;
    },
    sol::meta_function::to_string,
    &legacy_horde_token::to_string,
    sol::meta_function::equal_to,
    []( const legacy_horde_token & lhs,
        const legacy_horde_token & rhs ) {
        return lhs == rhs;
    } );

    sol::table hordes = lua.create_table();
    hordes.set_function(
        "limits",
    [require_read]( sol::this_state lua_state ) {
        require_read();
        return horde_limits( lua_state );
    } );
    hordes.set_function(
        "definitions",
        [require_read](
            sol::this_state lua_state,
    const sol::optional<sol::table> &options ) {
        require_read();
        return list_group_definitions(
                   lua_state, options );
    } );
    hordes.set_function(
        "definition",
        [require_read](
            sol::this_state lua_state,
            const script_game_id & id,
    const sol::optional<sol::table> &options ) {
        require_read();
        return get_group_definition(
                   lua_state, id, options );
    } );
    hordes.set_function(
        "monsters",
        [require_read](
            sol::this_state lua_state,
            const script_game_id & id,
            const sol::optional<bool> &recursive,
    const sol::optional<sol::table> &options ) {
        require_read();
        return group_monsters(
                   lua_state, id,
                   recursive.value_or( false ),
                   options );
    } );
    hordes.set_function(
        "contains",
        [require_read](
            const script_game_id & group,
    const script_game_id & monster ) {
        require_read();
        return group_contains(
                   group, monster );
    } );
    hordes.set_function(
        "entities",
        [current_runtime_generation,
         current_world_generation,
         require_read](
            sol::this_state lua_state,
            const script_tripoint_coord & center,
    const sol::optional<sol::table> &options ) {
        require_read();
        return list_entities(
                   lua_state, center, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    hordes.set_function(
        "entity",
        [current_runtime_generation,
         current_world_generation,
         require_read](
            sol::this_state lua_state,
    const horde_entity_token & token ) {
        require_read();
        return get_entity(
                   lua_state, token,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    hordes.set_function(
        "legacy_groups",
        [current_runtime_generation,
         current_world_generation,
         require_read](
            sol::this_state lua_state,
            const script_tripoint_coord & center,
    const sol::optional<sol::table> &options ) {
        require_read();
        return list_legacy_groups(
                   lua_state, center, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    hordes.set_function(
        "legacy_group",
        [current_runtime_generation,
         current_world_generation,
         require_read](
            sol::this_state lua_state,
    const legacy_horde_token & token ) {
        require_read();
        return get_legacy_group(
                   lua_state, token,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    hordes.set_function(
        "summary",
        [require_read](
            sol::this_state lua_state,
    const script_tripoint_coord & position ) {
        require_read();
        return horde_summary(
                   lua_state, position );
    } );
    hordes.set_function(
        "spawn_entity",
        [current_runtime_generation,
         current_world_generation,
         require_write](
            sol::this_state lua_state,
            const script_tripoint_coord & position,
    const script_game_id & monster ) {
        require_write();
        return spawn_entity(
                   lua_state, position, monster,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    hordes.set_function(
        "alert_entity",
        [current_runtime_generation,
         current_world_generation,
         require_write](
            sol::this_state lua_state,
            const horde_entity_token & token,
            const script_tripoint_coord & destination,
    const int intensity ) {
        require_write();
        return alert_entity(
                   lua_state, token,
                   destination, intensity,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    hordes.set_function(
        "remove_entity",
        [current_runtime_generation,
         current_world_generation,
         require_write](
            sol::this_state lua_state,
    const horde_entity_token & token ) {
        require_write();
        return remove_entity(
                   lua_state, token,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    hordes.set_function(
        "spawn_legacy_group",
        [current_runtime_generation,
         current_world_generation,
         require_write](
            sol::this_state lua_state,
    const sol::table & options ) {
        require_write();
        return spawn_legacy_group(
                   lua_state, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    hordes.set_function(
        "update_legacy_group",
        [current_runtime_generation,
         current_world_generation,
         require_write](
            sol::this_state lua_state,
            const legacy_horde_token & token,
    const sol::table & options ) {
        require_write();
        return update_legacy_group(
                   lua_state, token, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    hordes.set_function(
        "remove_legacy_group",
        [current_runtime_generation,
         current_world_generation,
         require_write](
            sol::this_state lua_state,
    const legacy_horde_token & token ) {
        require_write();
        return remove_legacy_group(
                   lua_state, token,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    hordes.set_function(
        "signal",
        [require_write](
            sol::this_state lua_state,
            const script_tripoint_coord & position,
    const int power ) {
        require_write();
        return signal_hordes(
                   lua_state, position, power );
    } );
    hordes.set_function(
        "advance",
    [require_write]( sol::this_state lua_state ) {
        require_write();
        return advance_hordes( lua_state );
    } );
    game["hordes"] = std::move( hordes );
}

} // namespace cata::lua_ui

#endif // CATA_ENABLE_LUA_UI
