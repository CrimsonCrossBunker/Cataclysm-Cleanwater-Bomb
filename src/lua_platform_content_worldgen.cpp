#include "lua_platform_content_worldgen.h"

#include <algorithm>
#include <array>
#include <cctype>
#include <cmath>
#include <cstdint>
#include <iomanip>
#include <limits>
#include <map>
#include <memory>
#include <optional>
#include <sstream>
#include <stdexcept>
#include <string>
#include <string_view>
#include <type_traits>
#include <utility>
#include <vector>

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

extern "C" {
#include <lua.h>
}

#include "city.h"
#include "faction_camp.h"
#include "game_constants.h"
#include "generic_factory.h"
#include "lua_platform_content.h"
#include "mapdata.h"
#include "omdata.h"
#include "options.h"
#include "overmap_map_data_cache.h"
#include "overmap_worldgen.h"
#include "point.h"
#include "regional_settings.h"
#include "translation.h"

namespace cata::lua_platform
{

namespace
{

enum class definition_operation : int {
    add,
    replace,
    edit
};

enum class handle_lifecycle : int {
    building,
    committed,
    discarded
};

struct owner_token {
    std::string mod_id;
    std::size_t generation = 0;
    handle_lifecycle lifecycle = handle_lifecycle::building;
};

std::string operation_name( const definition_operation operation )
{
    return operation == definition_operation::add ? "add" :
           operation == definition_operation::replace ? "replace" : "edit";
}

void hash_part( std::uint64_t &state, const std::string_view value )
{
    const auto append = [&state]( const std::string_view part ) {
        for( const unsigned char byte : part ) {
            state ^= byte;
            state *= 1099511628211ULL;
        }
    };
    append( std::to_string( value.size() ) );
    append( ":" );
    append( value );
    append( ";" );
}

template<typename Definition>
void require_building_handle( const std::shared_ptr<owner_token> &token,
                              const Definition &definition,
                              const char *kind )
{
    if( !token || token->lifecycle != handle_lifecycle::building ) {
        throw std::runtime_error( std::string( "stale " ) + kind +
                                  " definition handle" );
    }
    if( definition.registered ) {
        throw std::runtime_error( std::string( kind ) +
                                  " definition is already registered" );
    }
}

template<typename Definition>
void require_readable_handle( const std::shared_ptr<owner_token> &token,
                              const Definition &, const char *kind )
{
    if( !token || token->lifecycle != handle_lifecycle::building ) {
        throw std::runtime_error( std::string( "stale " ) + kind +
                                  " definition handle" );
    }
}

std::size_t require_dense_array( const sol::table &values,
                                 const std::string_view description,
                                 const std::size_t minimum,
                                 const std::size_t maximum )
{
    const std::size_t count = values.size();
    if( count < minimum || count > maximum ) {
        throw std::invalid_argument( std::string( description ) +
                                     " has an invalid number of entries" );
    }
    std::size_t observed = 0;
    for( const auto &entry : values ) {
        const sol::object key = entry.first;
        if( !key.is<lua_Integer>() ) {
            throw std::invalid_argument( std::string( description ) +
                                         " must be a dense array" );
        }
        const lua_Integer index = key.as<lua_Integer>();
        if( index < 1 || static_cast<std::uint64_t>( index ) > count ) {
            throw std::invalid_argument( std::string( description ) +
                                         " must be a dense array" );
        }
        ++observed;
    }
    if( observed != count ) {
        throw std::invalid_argument( std::string( description ) +
                                     " must be a dense array" );
    }
    return count;
}

bool fits_native_int( const std::int64_t value )
{
    return value >= std::numeric_limits<int>::min() &&
           value <= std::numeric_limits<int>::max();
}

std::pair<std::int64_t, std::int64_t> read_exact_coordinate_table(
    const sol::table &table, const std::string_view description )
{
    bool has_x = false;
    bool has_y = false;
    bool named_coordinate = true;
    std::size_t observed = 0;
    for( const auto &entry : table ) {
        ++observed;
        const sol::object key = entry.first;
        if( !key.is<std::string>() ) {
            named_coordinate = false;
            continue;
        }
        const std::string name = key.as<std::string>();
        if( name == "x" ) {
            has_x = true;
        } else if( name == "y" ) {
            has_y = true;
        } else {
            throw std::runtime_error( std::string( description ) +
                                      " contains an unknown coordinate member" );
        }
    }

    sol::object x;
    sol::object y;
    if( named_coordinate ) {
        if( observed != 2 || !has_x || !has_y ) {
            throw std::runtime_error( std::string( description ) +
                                      " must contain exactly x and y" );
        }
        x = table.raw_get<sol::object>( "x" );
        y = table.raw_get<sol::object>( "y" );
    } else {
        require_dense_array( table, description, 2, 2 );
        x = table.raw_get<sol::object>( 1 );
        y = table.raw_get<sol::object>( 2 );
    }
    if( !x.is<lua_Integer>() || !y.is<lua_Integer>() ) {
        throw std::runtime_error( std::string( description ) +
                                  " coordinates must be native integers" );
    }
    const std::int64_t native_x = x.as<std::int64_t>();
    const std::int64_t native_y = y.as<std::int64_t>();
    if( !fits_native_int( native_x ) || !fits_native_int( native_y ) ) {
        throw std::runtime_error( std::string( description ) +
                                  " coordinate is outside the native integer range" );
    }
    return { native_x, native_y };
}

void add_or_replace_weighted_entry(
    std::vector<std::pair<std::string, std::int64_t>> &entries,
    const std::string &id,
    const std::int64_t weight )
{
    const auto existing = std::find_if( entries.begin(), entries.end(), [&id]( const auto & entry ) {
        return entry.first == id;
    } );
    if( existing != entries.end() ) {
        existing->second = weight;
    } else {
        entries.emplace_back( id, weight );
    }
}

void parse_weighted_table_entries(
    const sol::table &table,
    const std::string &label,
    std::vector<std::pair<std::string, std::int64_t>> &out_entries )
{
    const std::size_t count = require_dense_array( table, label.c_str(), 0, 1024 );
    for( std::size_t i = 1; i <= count; ++i ) {
        const sol::object elem = table.raw_get<sol::object>( i );
        std::string id;
        std::int64_t weight = 1;
        if( elem.is<std::string>() ) {
            id = elem.as<std::string>();
        } else if( elem.is<sol::table>() ) {
            const sol::table item = elem.as<sol::table>();
            if( require_dense_array( item, ( label + " entry" ).c_str(), 2, 2 ) != 2 ) {
                throw std::runtime_error( label + " entries must contain exactly an id and weight" );
            }
            const sol::object id_value = item.raw_get<sol::object>( 1 );
            const sol::object weight_value = item.raw_get<sol::object>( 2 );
            if( !id_value.is<std::string>() || !weight_value.is<lua_Integer>() ) {
                throw std::runtime_error( label + " entries must contain a string id and integer weight" );
            }
            id = id_value.as<std::string>();
            weight = weight_value.as<std::int64_t>();
        } else {
            throw std::runtime_error( label + " entries must be strings or { id, weight } arrays" );
        }
        if( id.empty() || weight <= 0 ) {
            throw std::runtime_error( label + " entries need a non-empty id and positive weight" );
        }
        add_or_replace_weighted_entry( out_entries, id, weight );
    }
}

std::optional<ot_match_type> platform_ot_match_type( std::string value )
{
    std::transform( value.begin(), value.end(), value.begin(), []( const unsigned char ch ) {
        return static_cast<char>( std::tolower( ch ) );
    } );
    if( value == "exact" ) {
        return ot_match_type::exact;
    }
    if( value == "type" ) {
        return ot_match_type::type;
    }
    if( value == "subtype" ) {
        return ot_match_type::subtype;
    }
    if( value == "prefix" ) {
        return ot_match_type::prefix;
    }
    if( value == "contains" ) {
        return ot_match_type::contains;
    }
    return std::nullopt;
}

struct region_settings_ravine_definition_data {
    std::string id;
    std::int64_t num_ravines = 0;
    std::int64_t ravine_range = 45;
    std::int64_t ravine_width = 1;
    std::int64_t ravine_depth = -3;
    bool registered = false;
};

struct region_settings_ravine_definition_handle {
    std::shared_ptr<region_settings_ravine_definition_data> definition;
    std::shared_ptr<owner_token> token;

    region_settings_ravine_definition_handle &num_ravines( const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings ravine" );
        definition->num_ravines = value;
        return *this;
    }

    region_settings_ravine_definition_handle &ravine_range( const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings ravine" );
        definition->ravine_range = value;
        return *this;
    }

    region_settings_ravine_definition_handle &ravine_width( const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings ravine" );
        definition->ravine_width = value;
        return *this;
    }

    region_settings_ravine_definition_handle &ravine_depth( const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings ravine" );
        definition->ravine_depth = value;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "region settings ravine" );
        return definition->id;
    }
};

struct region_settings_lake_alias_data {
    std::string om_terrain;
    std::string alias;
    std::string match_type = "exact";
};

struct region_settings_lake_definition_data {
    std::string id;
    double noise_threshold_lake = 0.25;
    std::int64_t lake_size_min = 20;
    std::int64_t lake_depth = -5;
    bool invert_lakes = false;
    std::string surface = "lake_surface";
    std::string shore = "lake_shore";
    std::string interior = "lake_water_cube";
    std::string bed = "lake_bed";
    std::vector<std::string> shore_extendable_overmap_terrain;
    std::vector<region_settings_lake_alias_data> shore_extendable_overmap_terrain_aliases;
    bool registered = false;
};

struct region_settings_lake_definition_handle {
    std::shared_ptr<region_settings_lake_definition_data> definition;
    std::shared_ptr<owner_token> token;

    region_settings_lake_definition_handle &noise_threshold_lake( const double value ) {
        require_building_handle( token, *definition, "region settings lake" );
        if( !std::isfinite( value ) ) {
            throw std::runtime_error( "lake noise threshold must be finite" );
        }
        definition->noise_threshold_lake = value;
        return *this;
    }

    region_settings_lake_definition_handle &lake_size_min( const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings lake" );
        definition->lake_size_min = value;
        return *this;
    }

    region_settings_lake_definition_handle &lake_depth( const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings lake" );
        definition->lake_depth = value;
        return *this;
    }

    region_settings_lake_definition_handle &invert_lakes( const bool value ) {
        require_building_handle( token, *definition, "region settings lake" );
        definition->invert_lakes = value;
        return *this;
    }

    region_settings_lake_definition_handle &surface_ter( const std::string &value ) {
        require_building_handle( token, *definition, "region settings lake" );
        if( value.empty() ) {
            throw std::runtime_error( "lake surface terrain cannot be empty" );
        }
        definition->surface = value;
        return *this;
    }

    region_settings_lake_definition_handle &shore_ter( const std::string &value ) {
        require_building_handle( token, *definition, "region settings lake" );
        if( value.empty() ) {
            throw std::runtime_error( "lake shore terrain cannot be empty" );
        }
        definition->shore = value;
        return *this;
    }

    region_settings_lake_definition_handle &interior_ter( const std::string &value ) {
        require_building_handle( token, *definition, "region settings lake" );
        if( value.empty() ) {
            throw std::runtime_error( "lake interior terrain cannot be empty" );
        }
        definition->interior = value;
        return *this;
    }

    region_settings_lake_definition_handle &bed_ter( const std::string &value ) {
        require_building_handle( token, *definition, "region settings lake" );
        if( value.empty() ) {
            throw std::runtime_error( "lake bed terrain cannot be empty" );
        }
        definition->bed = value;
        return *this;
    }

    region_settings_lake_definition_handle &shore_extendable_terrain( const std::string &value ) {
        require_building_handle( token, *definition, "region settings lake" );
        if( value.empty() ) {
            throw std::runtime_error( "shore extendable terrain cannot be empty" );
        }
        definition->shore_extendable_overmap_terrain.push_back( value );
        return *this;
    }

    region_settings_lake_definition_handle &shore_extendable_alias(
        const sol::object &om_terrain_or_options,
        sol::optional<std::string> alias = sol::nullopt,
        sol::optional<std::string> match_type = sol::nullopt ) {
        require_building_handle( token, *definition, "region settings lake" );
        if( om_terrain_or_options.is<sol::table>() ) {
            const sol::table options = om_terrain_or_options.as<sol::table>();
            const std::string om_terrain =
                options.get<std::optional<std::string>>( "om_terrain" ).value_or( "" );
            const std::string alias_str = options.get<std::optional<std::string>>( "alias" ).value_or( "" );
            const std::string match = options.get<std::optional<std::string>>( "om_terrain_match_type" )
                                      .value_or( options.get<std::optional<std::string>>( "match_type" ).value_or( "exact" ) );
            if( om_terrain.empty() || alias_str.empty() ) {
                throw std::runtime_error( "shore extendable alias requires non-empty om_terrain and alias" );
            }
            if( !platform_ot_match_type( match ).has_value() ) {
                throw std::runtime_error( "invalid overmap terrain match type: " + match );
            }
            definition->shore_extendable_overmap_terrain_aliases.push_back( {
                om_terrain, alias_str, match
            } );
            return *this;
        }
        if( om_terrain_or_options.is<std::string>() && alias.has_value() ) {
            const std::string om_terrain = om_terrain_or_options.as<std::string>();
            const std::string alias_str = *alias;
            const std::string match = match_type.value_or( "exact" );
            if( om_terrain.empty() || alias_str.empty() ) {
                throw std::runtime_error( "shore extendable alias requires non-empty om_terrain and alias" );
            }
            if( !platform_ot_match_type( match ).has_value() ) {
                throw std::runtime_error( "invalid overmap terrain match type: " + match );
            }
            definition->shore_extendable_overmap_terrain_aliases.push_back( {
                om_terrain, alias_str, match
            } );
            return *this;
        }
        throw std::runtime_error(
            "shore_extendable_alias expects a table { om_terrain = ..., alias = ..., [om_terrain_match_type = ...] } or positional strings" );
    }

    std::string id() const {
        require_readable_handle( token, *definition, "region settings lake" );
        return definition->id;
    }
};

struct region_settings_ocean_definition_data {
    std::string id;
    double noise_threshold_ocean = 0.25;
    std::int64_t ocean_size_min = 100;
    std::int64_t ocean_depth = -9;
    std::optional<std::int64_t> ocean_start_north;
    std::optional<std::int64_t> ocean_start_east;
    std::optional<std::int64_t> ocean_start_west;
    std::optional<std::int64_t> ocean_start_south;
    std::int64_t sandy_beach_width = 2;
    bool registered = false;
};

struct region_settings_ocean_definition_handle {
    std::shared_ptr<region_settings_ocean_definition_data> definition;
    std::shared_ptr<owner_token> token;

    region_settings_ocean_definition_handle &noise_threshold_ocean( const double value ) {
        require_building_handle( token, *definition, "region settings ocean" );
        if( !std::isfinite( value ) ) {
            throw std::runtime_error( "ocean noise threshold must be finite" );
        }
        definition->noise_threshold_ocean = value;
        return *this;
    }

    region_settings_ocean_definition_handle &ocean_size_min( const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings ocean" );
        definition->ocean_size_min = value;
        return *this;
    }

    region_settings_ocean_definition_handle &ocean_depth( const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings ocean" );
        definition->ocean_depth = value;
        return *this;
    }

    region_settings_ocean_definition_handle &ocean_start_north( const sol::object &value ) {
        require_building_handle( token, *definition, "region settings ocean" );
        if( value.is<std::int64_t>() ) {
            definition->ocean_start_north = value.as<std::int64_t>();
        } else if( value.get_type() == sol::type::lua_nil || value.get_type() == sol::type::none ) {
            definition->ocean_start_north.reset();
        } else {
            throw std::runtime_error( "ocean_start_north must be an integer or nil" );
        }
        return *this;
    }

    region_settings_ocean_definition_handle &ocean_start_east( const sol::object &value ) {
        require_building_handle( token, *definition, "region settings ocean" );
        if( value.is<std::int64_t>() ) {
            definition->ocean_start_east = value.as<std::int64_t>();
        } else if( value.get_type() == sol::type::lua_nil || value.get_type() == sol::type::none ) {
            definition->ocean_start_east.reset();
        } else {
            throw std::runtime_error( "ocean_start_east must be an integer or nil" );
        }
        return *this;
    }

    region_settings_ocean_definition_handle &ocean_start_west( const sol::object &value ) {
        require_building_handle( token, *definition, "region settings ocean" );
        if( value.is<std::int64_t>() ) {
            definition->ocean_start_west = value.as<std::int64_t>();
        } else if( value.get_type() == sol::type::lua_nil || value.get_type() == sol::type::none ) {
            definition->ocean_start_west.reset();
        } else {
            throw std::runtime_error( "ocean_start_west must be an integer or nil" );
        }
        return *this;
    }

    region_settings_ocean_definition_handle &ocean_start_south( const sol::object &value ) {
        require_building_handle( token, *definition, "region settings ocean" );
        if( value.is<std::int64_t>() ) {
            definition->ocean_start_south = value.as<std::int64_t>();
        } else if( value.get_type() == sol::type::lua_nil || value.get_type() == sol::type::none ) {
            definition->ocean_start_south.reset();
        } else {
            throw std::runtime_error( "ocean_start_south must be an integer or nil" );
        }
        return *this;
    }

    region_settings_ocean_definition_handle &sandy_beach_width( const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings ocean" );
        definition->sandy_beach_width = value;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "region settings ocean" );
        return definition->id;
    }
};

struct region_settings_forest_definition_data {
    std::string id;
    double noise_threshold_forest = 0.25;
    double noise_threshold_forest_thick = 0.3;
    double noise_threshold_swamp_adjacent_water = 0.3;
    double noise_threshold_swamp_isolated = 0.6;
    std::int64_t river_floodplain_buffer_distance_min = 3;
    std::int64_t river_floodplain_buffer_distance_max = 15;
    double forest_threshold_limit = 0.395;
    std::array<float, 4> forest_threshold_increase = { { 0.0f, 0.0f, 0.0f, 0.0f } };
    bool registered = false;
};

struct region_settings_forest_definition_handle {
    std::shared_ptr<region_settings_forest_definition_data> definition;
    std::shared_ptr<owner_token> token;

    region_settings_forest_definition_handle &noise_threshold_forest( const double value ) {
        require_building_handle( token, *definition, "region settings forest" );
        if( !std::isfinite( value ) ) {
            throw std::runtime_error( "forest noise threshold must be finite" );
        }
        definition->noise_threshold_forest = value;
        return *this;
    }

    region_settings_forest_definition_handle &noise_threshold_forest_thick( const double value ) {
        require_building_handle( token, *definition, "region settings forest" );
        if( !std::isfinite( value ) ) {
            throw std::runtime_error( "thick forest noise threshold must be finite" );
        }
        definition->noise_threshold_forest_thick = value;
        return *this;
    }

    region_settings_forest_definition_handle &noise_threshold_swamp_adjacent_water(
        const double value ) {
        require_building_handle( token, *definition, "region settings forest" );
        if( !std::isfinite( value ) ) {
            throw std::runtime_error( "swamp adjacent water noise threshold must be finite" );
        }
        definition->noise_threshold_swamp_adjacent_water = value;
        return *this;
    }

    region_settings_forest_definition_handle &noise_threshold_swamp_isolated( const double value ) {
        require_building_handle( token, *definition, "region settings forest" );
        if( !std::isfinite( value ) ) {
            throw std::runtime_error( "swamp isolated noise threshold must be finite" );
        }
        definition->noise_threshold_swamp_isolated = value;
        return *this;
    }

    region_settings_forest_definition_handle &river_floodplain_buffer_distance_min(
        const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings forest" );
        definition->river_floodplain_buffer_distance_min = value;
        return *this;
    }

    region_settings_forest_definition_handle &river_floodplain_buffer_distance_max(
        const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings forest" );
        definition->river_floodplain_buffer_distance_max = value;
        return *this;
    }

    region_settings_forest_definition_handle &forest_threshold_limit( const double value ) {
        require_building_handle( token, *definition, "region settings forest" );
        if( !std::isfinite( value ) ) {
            throw std::runtime_error( "forest threshold limit must be finite" );
        }
        definition->forest_threshold_limit = value;
        return *this;
    }

    region_settings_forest_definition_handle &forest_threshold_increase( const sol::table &values ) {
        require_building_handle( token, *definition, "region settings forest" );
        const std::size_t count = require_dense_array( values, "forest threshold increase", 4, 4 );
        for( std::size_t i = 1; i <= count; ++i ) {
            const double value = values.get<double>( i );
            if( !std::isfinite( value ) ) {
                throw std::runtime_error( "forest threshold increase entries must be finite" );
            }
            definition->forest_threshold_increase[i - 1] = static_cast<float>( value );
        }
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "region settings forest" );
        return definition->id;
    }
};

struct region_settings_river_definition_data {
    std::string id;
    std::int64_t river_scale = 1;
    double river_frequency = 1.5;
    double river_branch_chance = 64.0;
    double river_branch_remerge_chance = 4.0;
    double river_branch_scale_decrease = 1.0;
    bool registered = false;
};

struct region_settings_river_definition_handle {
    std::shared_ptr<region_settings_river_definition_data> definition;
    std::shared_ptr<owner_token> token;

    region_settings_river_definition_handle &river_scale( const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings river" );
        if( value < std::numeric_limits<int>::min() ||
            value > std::numeric_limits<int>::max() ) {
            throw std::runtime_error( "river_scale out of range of int" );
        }
        definition->river_scale = value;
        return *this;
    }

    region_settings_river_definition_handle &river_frequency( const double value ) {
        require_building_handle( token, *definition, "region settings river" );
        if( !std::isfinite( value ) ) {
            throw std::runtime_error( "river_frequency must be finite" );
        }
        definition->river_frequency = value;
        return *this;
    }

    region_settings_river_definition_handle &river_branch_chance( const double value ) {
        require_building_handle( token, *definition, "region settings river" );
        if( !std::isfinite( value ) ) {
            throw std::runtime_error( "river_branch_chance must be finite" );
        }
        definition->river_branch_chance = value;
        return *this;
    }

    region_settings_river_definition_handle &river_branch_remerge_chance( const double value ) {
        require_building_handle( token, *definition, "region settings river" );
        if( !std::isfinite( value ) ) {
            throw std::runtime_error( "river_branch_remerge_chance must be finite" );
        }
        definition->river_branch_remerge_chance = value;
        return *this;
    }

    region_settings_river_definition_handle &river_branch_scale_decrease( const double value ) {
        require_building_handle( token, *definition, "region settings river" );
        if( !std::isfinite( value ) ) {
            throw std::runtime_error( "river_branch_scale_decrease must be finite" );
        }
        definition->river_branch_scale_decrease = value;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "region settings river" );
        return definition->id;
    }
};

struct region_settings_forest_mapgen_definition_data {
    std::string id;
    std::vector<std::string> biomes;
    bool registered = false;
};

struct region_settings_forest_mapgen_definition_handle {
    std::shared_ptr<region_settings_forest_mapgen_definition_data> definition;
    std::shared_ptr<owner_token> token;

    region_settings_forest_mapgen_definition_handle &biome( const std::string &value ) {
        require_building_handle( token, *definition, "region settings forest mapgen" );
        if( value.empty() ) {
            throw std::runtime_error( "forest biome mapgen id must be non-empty" );
        }
        if( std::find( definition->biomes.begin(), definition->biomes.end(), value ) !=
            definition->biomes.end() ) {
            throw std::runtime_error( "duplicate biome in region settings forest mapgen: " + value );
        }
        definition->biomes.push_back( value );
        return *this;
    }

    region_settings_forest_mapgen_definition_handle &biomes( const sol::table &values ) {
        require_building_handle( token, *definition, "region settings forest mapgen" );
        const std::size_t count = require_dense_array( values, "region settings forest mapgen biomes", 0,
                                  1024 );
        for( std::size_t i = 1; i <= count; ++i ) {
            const std::string val = values.get<std::string>( i );
            if( val.empty() ) {
                throw std::runtime_error( "forest biome mapgen id must be non-empty" );
            }
            if( std::find( definition->biomes.begin(), definition->biomes.end(), val ) !=
                definition->biomes.end() ) {
                throw std::runtime_error( "duplicate biome in region settings forest mapgen: " + val );
            }
            definition->biomes.push_back( val );
        }
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "region settings forest mapgen" );
        return definition->id;
    }
};

struct region_settings_map_extras_definition_data {
    std::string id;
    std::vector<std::string> extras;
    bool registered = false;
};

struct region_settings_map_extras_definition_handle {
    std::shared_ptr<region_settings_map_extras_definition_data> definition;
    std::shared_ptr<owner_token> token;

    region_settings_map_extras_definition_handle &extra( const std::string &value ) {
        require_building_handle( token, *definition, "region settings map extras" );
        if( value.empty() ) {
            throw std::runtime_error( "map extra collection id must be non-empty" );
        }
        if( std::find( definition->extras.begin(), definition->extras.end(), value ) !=
            definition->extras.end() ) {
            throw std::runtime_error( "duplicate extra in region settings map extras: " + value );
        }
        definition->extras.push_back( value );
        return *this;
    }

    region_settings_map_extras_definition_handle &extras( const sol::table &values ) {
        require_building_handle( token, *definition, "region settings map extras" );
        const std::size_t count = require_dense_array( values, "region settings map extras", 0, 1024 );
        for( std::size_t i = 1; i <= count; ++i ) {
            const std::string val = values.get<std::string>( i );
            if( val.empty() ) {
                throw std::runtime_error( "map extra collection id must be non-empty" );
            }
            if( std::find( definition->extras.begin(), definition->extras.end(), val ) !=
                definition->extras.end() ) {
                throw std::runtime_error( "duplicate extra in region settings map extras: " + val );
            }
            definition->extras.push_back( val );
        }
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "region settings map extras" );
        return definition->id;
    }
};

struct region_settings_terrain_furniture_definition_data {
    std::string id;
    std::vector<std::string> ter_furn;
    bool registered = false;
};

struct region_settings_terrain_furniture_definition_handle {
    std::shared_ptr<region_settings_terrain_furniture_definition_data> definition;
    std::shared_ptr<owner_token> token;

    region_settings_terrain_furniture_definition_handle &terrain_furniture( const std::string &value ) {
        require_building_handle( token, *definition, "region settings terrain furniture" );
        if( value.empty() ) {
            throw std::runtime_error( "region terrain furniture id must be non-empty" );
        }
        if( std::find( definition->ter_furn.begin(), definition->ter_furn.end(), value ) !=
            definition->ter_furn.end() ) {
            throw std::runtime_error(
                "duplicate terrain furniture in region settings terrain furniture: " + value );
        }
        definition->ter_furn.push_back( value );
        return *this;
    }

    region_settings_terrain_furniture_definition_handle &ter_furn( const sol::table &values ) {
        require_building_handle( token, *definition, "region settings terrain furniture" );
        const std::size_t count = require_dense_array( values, "region settings terrain furniture", 0,
                                  1024 );
        for( std::size_t i = 1; i <= count; ++i ) {
            const std::string val = values.get<std::string>( i );
            if( val.empty() ) {
                throw std::runtime_error( "region terrain furniture id must be non-empty" );
            }
            if( std::find( definition->ter_furn.begin(), definition->ter_furn.end(), val ) !=
                definition->ter_furn.end() ) {
                throw std::runtime_error(
                    "duplicate terrain furniture in region settings terrain furniture: " + val );
            }
            definition->ter_furn.push_back( val );
        }
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "region settings terrain furniture" );
        return definition->id;
    }
};

struct region_settings_forest_trail_definition_data {
    std::string id;
    std::int64_t chance = 1;
    std::int64_t border_point_chance = 2;
    std::int64_t minimum_forest_size = 50;
    std::int64_t random_point_min = 4;
    std::int64_t random_point_max = 50;
    std::int64_t random_point_size_scalar = 100;
    std::int64_t trailhead_chance = 1;
    std::int64_t trailhead_road_distance = 6;
    std::vector<std::pair<std::string, std::int64_t>> trailheads;
    bool registered = false;
};

struct region_settings_forest_trail_definition_handle {
    std::shared_ptr<region_settings_forest_trail_definition_data> definition;
    std::shared_ptr<owner_token> token;

    region_settings_forest_trail_definition_handle &chance( const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings forest trail" );
        definition->chance = value;
        return *this;
    }

    region_settings_forest_trail_definition_handle &border_point_chance( const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings forest trail" );
        definition->border_point_chance = value;
        return *this;
    }

    region_settings_forest_trail_definition_handle &minimum_forest_size( const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings forest trail" );
        definition->minimum_forest_size = value;
        return *this;
    }

    region_settings_forest_trail_definition_handle &random_point_min( const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings forest trail" );
        definition->random_point_min = value;
        return *this;
    }

    region_settings_forest_trail_definition_handle &random_point_max( const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings forest trail" );
        definition->random_point_max = value;
        return *this;
    }

    region_settings_forest_trail_definition_handle &random_point_size_scalar(
        const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings forest trail" );
        definition->random_point_size_scalar = value;
        return *this;
    }

    region_settings_forest_trail_definition_handle &trailhead_chance( const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings forest trail" );
        definition->trailhead_chance = value;
        return *this;
    }

    region_settings_forest_trail_definition_handle &trailhead_road_distance(
        const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings forest trail" );
        definition->trailhead_road_distance = value;
        return *this;
    }

    region_settings_forest_trail_definition_handle &trailhead( const std::string &special_id,
            const std::int64_t weight ) {
        require_building_handle( token, *definition, "region settings forest trail" );
        if( special_id.empty() || weight <= 0 ) {
            throw std::runtime_error( "region settings forest trail trailhead needs an id and positive weight" );
        }
        add_or_replace_weighted_entry( definition->trailheads, special_id, weight );
        return *this;
    }

    region_settings_forest_trail_definition_handle &add_trailhead( const std::string &special_id,
            const std::int64_t weight ) {
        return trailhead( special_id, weight );
    }

    std::string id() const {
        require_readable_handle( token, *definition, "region settings forest trail" );
        return definition->id;
    }
};

struct region_settings_highway_definition_data {
    std::string id;
    std::int64_t width_of_segments = 2;
    double straightness_chance = 0.6;
    std::string reserved_terrain_id;
    std::string reserved_terrain_water_id;
    std::string segment_flat_special;
    std::string segment_ramp_special;
    std::string segment_road_bridge_special;
    std::string segment_bridge_special;
    std::string segment_bridge_supports_special;
    std::string segment_overpass_special;
    std::string clockwise_slant_special;
    std::string counterclockwise_slant_special;
    std::string fallback_onramp_special;
    std::string fallback_bend_special;
    std::string fallback_three_way_intersection_special;
    std::string fallback_four_way_intersection_special;
    std::string fallback_supports;
    std::vector<std::pair<std::string, std::int64_t>> four_way_intersections;
    std::vector<std::pair<std::string, std::int64_t>> three_way_intersections;
    std::vector<std::pair<std::string, std::int64_t>> bends;
    std::vector<std::pair<std::string, std::int64_t>> road_connections;
    std::vector<std::pair<std::string, std::int64_t>> interchanges;
    bool registered = false;
};

struct region_settings_highway_definition_handle {
    std::shared_ptr<region_settings_highway_definition_data> definition;
    std::shared_ptr<owner_token> token;

    region_settings_highway_definition_handle &width_of_segments( const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings highway" );
        definition->width_of_segments = value;
        return *this;
    }

    region_settings_highway_definition_handle &straightness_chance( const double value ) {
        require_building_handle( token, *definition, "region settings highway" );
        if( !std::isfinite( value ) ) {
            throw std::runtime_error( "highway straightness chance must be finite" );
        }
        definition->straightness_chance = value;
        return *this;
    }

#define CCB_WORLDGEN_HIGHWAY_STRING_SETTER( name ) \
    region_settings_highway_definition_handle &name( const std::string &value ) { \
        require_building_handle( token, *definition, "region settings highway" ); \
        definition->name = value; \
        return *this; \
    }

    CCB_WORLDGEN_HIGHWAY_STRING_SETTER( reserved_terrain_id )
    CCB_WORLDGEN_HIGHWAY_STRING_SETTER( reserved_terrain_water_id )
    CCB_WORLDGEN_HIGHWAY_STRING_SETTER( segment_flat_special )
    CCB_WORLDGEN_HIGHWAY_STRING_SETTER( segment_ramp_special )
    CCB_WORLDGEN_HIGHWAY_STRING_SETTER( segment_road_bridge_special )
    CCB_WORLDGEN_HIGHWAY_STRING_SETTER( segment_bridge_special )
    CCB_WORLDGEN_HIGHWAY_STRING_SETTER( segment_bridge_supports_special )
    CCB_WORLDGEN_HIGHWAY_STRING_SETTER( segment_overpass_special )
    CCB_WORLDGEN_HIGHWAY_STRING_SETTER( clockwise_slant_special )
    CCB_WORLDGEN_HIGHWAY_STRING_SETTER( counterclockwise_slant_special )
    CCB_WORLDGEN_HIGHWAY_STRING_SETTER( fallback_onramp_special )
    CCB_WORLDGEN_HIGHWAY_STRING_SETTER( fallback_bend_special )
    CCB_WORLDGEN_HIGHWAY_STRING_SETTER( fallback_three_way_intersection_special )
    CCB_WORLDGEN_HIGHWAY_STRING_SETTER( fallback_four_way_intersection_special )
    CCB_WORLDGEN_HIGHWAY_STRING_SETTER( fallback_supports )

#undef CCB_WORLDGEN_HIGHWAY_STRING_SETTER

    region_settings_highway_definition_handle &four_way_intersection( const std::string &special_id,
            const std::int64_t weight ) {
        require_building_handle( token, *definition, "region settings highway" );
        if( special_id.empty() || weight <= 0 ) {
            throw std::runtime_error( "highway four_way_intersection needs an id and positive weight" );
        }
        add_or_replace_weighted_entry( definition->four_way_intersections, special_id, weight );
        return *this;
    }

    region_settings_highway_definition_handle &three_way_intersection( const std::string &special_id,
            const std::int64_t weight ) {
        require_building_handle( token, *definition, "region settings highway" );
        if( special_id.empty() || weight <= 0 ) {
            throw std::runtime_error( "highway three_way_intersection needs an id and positive weight" );
        }
        add_or_replace_weighted_entry( definition->three_way_intersections, special_id, weight );
        return *this;
    }

    region_settings_highway_definition_handle &bend( const std::string &special_id,
            const std::int64_t weight ) {
        require_building_handle( token, *definition, "region settings highway" );
        if( special_id.empty() || weight <= 0 ) {
            throw std::runtime_error( "highway bend needs an id and positive weight" );
        }
        add_or_replace_weighted_entry( definition->bends, special_id, weight );
        return *this;
    }

    region_settings_highway_definition_handle &road_connection( const std::string &special_id,
            const std::int64_t weight ) {
        require_building_handle( token, *definition, "region settings highway" );
        if( special_id.empty() || weight <= 0 ) {
            throw std::runtime_error( "highway road_connection needs an id and positive weight" );
        }
        add_or_replace_weighted_entry( definition->road_connections, special_id, weight );
        return *this;
    }

    region_settings_highway_definition_handle &interchange( const std::string &special_id,
            const std::int64_t weight ) {
        require_building_handle( token, *definition, "region settings highway" );
        if( special_id.empty() || weight <= 0 ) {
            throw std::runtime_error( "highway interchange needs an id and positive weight" );
        }
        add_or_replace_weighted_entry( definition->interchanges, special_id, weight );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "region settings highway" );
        return definition->id;
    }
};

struct region_settings_definition_data {
    std::string id;
    std::vector<std::string> default_oter;
    std::vector<std::pair<std::string, std::int64_t>> default_groundcover;
    bool default_groundcover_set = false;
    std::string cities;
    std::string forest_composition;
    std::string forest_trails;
    std::string weather;
    std::string forests;
    std::string rivers;
    std::string lakes;
    std::string ocean;
    std::string highways;
    std::string ravines;
    std::string map_extras;
    std::string terrain_furniture;
    std::vector<std::string> feature_blacklist;
    std::vector<std::string> feature_whitelist;
    std::string trail_connection;
    std::string sewer_connection;
    std::string subway_connection;
    std::string rail_connection;
    std::string intra_city_road_connection;
    std::string inter_city_road_connection;
    bool place_swamps = true;
    bool place_roads = true;
    bool place_railroads = false;
    bool place_railroads_before_roads = false;
    bool place_specials = true;
    bool neighbor_connections = true;
    double max_urbanity = 8.0;
    std::array<float, 4> urbanity_increase = { 0.0f, 0.0f, 0.0f, 0.0f };
    bool registered = false;
};

struct region_settings_definition_handle {
    std::shared_ptr<region_settings_definition_data> definition;
    std::shared_ptr<owner_token> token;

    region_settings_definition_handle &default_oter( const sol::table &values ) {
        require_building_handle( token, *definition, "region settings" );
        const std::size_t count = require_dense_array(
                                      values, "region settings default_oter",
                                      OVERMAP_LAYERS, OVERMAP_LAYERS );
        definition->default_oter.clear();
        definition->default_oter.reserve( count );
        for( std::size_t index = 1; index <= count; ++index ) {
            definition->default_oter.push_back( values.get<std::string>( index ) );
        }
        return *this;
    }

    region_settings_definition_handle &default_groundcover( const sol::table &values ) {
        require_building_handle( token, *definition, "region settings" );
        definition->default_groundcover.clear();
        definition->default_groundcover_set = true;
        parse_weighted_table_entries( values, "region settings default_groundcover",
                                      definition->default_groundcover );
        return *this;
    }

    region_settings_definition_handle &groundcover( const std::string &terrain_id,
            const std::int64_t weight ) {
        require_building_handle( token, *definition, "region settings" );
        if( terrain_id.empty() || weight <= 0 ) {
            throw std::runtime_error(
                "region settings groundcover needs a terrain id and positive weight" );
        }
        definition->default_groundcover_set = true;
        add_or_replace_weighted_entry( definition->default_groundcover,
                                       terrain_id, weight );
        return *this;
    }

    region_settings_definition_handle &feature_blacklisted( const std::string &flag ) {
        require_building_handle( token, *definition, "region settings" );
        if( flag.empty() ) {
            throw std::runtime_error( "region settings feature flag cannot be empty" );
        }
        if( std::find( definition->feature_blacklist.begin(),
                       definition->feature_blacklist.end(), flag ) ==
            definition->feature_blacklist.end() ) {
            definition->feature_blacklist.push_back( flag );
        }
        return *this;
    }

    region_settings_definition_handle &feature_whitelisted( const std::string &flag ) {
        require_building_handle( token, *definition, "region settings" );
        if( flag.empty() ) {
            throw std::runtime_error( "region settings feature flag cannot be empty" );
        }
        if( std::find( definition->feature_whitelist.begin(),
                       definition->feature_whitelist.end(), flag ) ==
            definition->feature_whitelist.end() ) {
            definition->feature_whitelist.push_back( flag );
        }
        return *this;
    }

#define CCB_WORLDGEN_REGION_SETTINGS_STRING_SETTER( name ) \
    region_settings_definition_handle &name( const std::string &value ) { \
        require_building_handle( token, *definition, "region settings" ); \
        definition->name = value; \
        return *this; \
    }

    CCB_WORLDGEN_REGION_SETTINGS_STRING_SETTER( cities )
    CCB_WORLDGEN_REGION_SETTINGS_STRING_SETTER( forest_composition )
    CCB_WORLDGEN_REGION_SETTINGS_STRING_SETTER( forest_trails )
    CCB_WORLDGEN_REGION_SETTINGS_STRING_SETTER( weather )
    CCB_WORLDGEN_REGION_SETTINGS_STRING_SETTER( forests )
    CCB_WORLDGEN_REGION_SETTINGS_STRING_SETTER( rivers )
    CCB_WORLDGEN_REGION_SETTINGS_STRING_SETTER( lakes )
    CCB_WORLDGEN_REGION_SETTINGS_STRING_SETTER( ocean )
    CCB_WORLDGEN_REGION_SETTINGS_STRING_SETTER( highways )
    CCB_WORLDGEN_REGION_SETTINGS_STRING_SETTER( ravines )
    CCB_WORLDGEN_REGION_SETTINGS_STRING_SETTER( map_extras )
    CCB_WORLDGEN_REGION_SETTINGS_STRING_SETTER( terrain_furniture )
    CCB_WORLDGEN_REGION_SETTINGS_STRING_SETTER( trail_connection )
    CCB_WORLDGEN_REGION_SETTINGS_STRING_SETTER( sewer_connection )
    CCB_WORLDGEN_REGION_SETTINGS_STRING_SETTER( subway_connection )
    CCB_WORLDGEN_REGION_SETTINGS_STRING_SETTER( rail_connection )
    CCB_WORLDGEN_REGION_SETTINGS_STRING_SETTER( intra_city_road_connection )
    CCB_WORLDGEN_REGION_SETTINGS_STRING_SETTER( inter_city_road_connection )

#undef CCB_WORLDGEN_REGION_SETTINGS_STRING_SETTER

#define CCB_WORLDGEN_REGION_SETTINGS_BOOL_SETTER( name ) \
    region_settings_definition_handle &name( const bool value ) { \
        require_building_handle( token, *definition, "region settings" ); \
        definition->name = value; \
        return *this; \
    }

    CCB_WORLDGEN_REGION_SETTINGS_BOOL_SETTER( place_swamps )
    CCB_WORLDGEN_REGION_SETTINGS_BOOL_SETTER( place_roads )
    CCB_WORLDGEN_REGION_SETTINGS_BOOL_SETTER( place_railroads )
    CCB_WORLDGEN_REGION_SETTINGS_BOOL_SETTER( place_railroads_before_roads )
    CCB_WORLDGEN_REGION_SETTINGS_BOOL_SETTER( place_specials )
    CCB_WORLDGEN_REGION_SETTINGS_BOOL_SETTER( neighbor_connections )

#undef CCB_WORLDGEN_REGION_SETTINGS_BOOL_SETTER

    region_settings_definition_handle &max_urbanity( const double value ) {
        require_building_handle( token, *definition, "region settings" );
        if( !std::isfinite( value ) ) {
            throw std::runtime_error( "region settings max urbanity must be finite" );
        }
        definition->max_urbanity = value;
        return *this;
    }

    region_settings_definition_handle &urbanity_increase( const sol::table &values ) {
        require_building_handle( token, *definition, "region settings" );
        const std::size_t count = require_dense_array(
                                      values, "region settings urbanity_increase", 4, 4 );
        for( std::size_t index = 1; index <= count; ++index ) {
            const double value = values.get<double>( index );
            if( !std::isfinite( value ) ||
                value < std::numeric_limits<float>::lowest() ||
                value > std::numeric_limits<float>::max() ) {
                throw std::runtime_error(
                    "region settings urbanity increase must contain finite native floats" );
            }
            definition->urbanity_increase[index - 1] = static_cast<float>( value );
        }
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "region settings" );
        return definition->id;
    }
};

detail::option_slider_native_level read_option_slider_level(
    const sol::table &value )
{
    detail::option_slider_native_level result;
    const sol::object level_value = value.raw_get<sol::object>( "level" );
    const sol::object name_value = value.raw_get<sol::object>( "name" );
    if( !level_value.is<lua_Integer>() || !name_value.is<std::string>() ) {
        throw std::runtime_error(
            "option slider levels require a native integer level and string name" );
    }
    result.level = level_value.as<std::int64_t>();
    result.name = name_value.as<std::string>();
    result.description = value.get_or( "description", std::string() );

    const sol::optional<sol::table> options =
        value.get<sol::optional<sol::table>>( "options" );
    if( !options ) {
        return result;
    }
    const std::size_t count = require_dense_array(
                                  *options, "option slider level options", 0, 512 );
    result.options.reserve( count );
    for( std::size_t index = 1; index <= count; ++index ) {
        const sol::object entry = options->raw_get<sol::object>( index );
        if( !entry.is<sol::table>() ) {
            throw std::runtime_error( "option slider options must be tables" );
        }
        const sol::table option = entry.as<sol::table>();
        detail::option_slider_native_option native_option;
        native_option.option = option.get_or( "option", std::string() );
        native_option.type = option.get_or( "type", std::string() );
        const sol::object option_value = option.raw_get<sol::object>( "value" );
        if( native_option.type == "int" ) {
            if( !option_value.is<lua_Integer>() ) {
                throw std::runtime_error(
                    "option slider int values must be native integers" );
            }
            const std::int64_t integer = option_value.as<std::int64_t>();
            if( !fits_native_int( integer ) ) {
                throw std::runtime_error(
                    "option slider int value is outside the native range" );
            }
            native_option.value = std::to_string( integer );
        } else if( native_option.type == "float" ) {
            if( !option_value.is<double>() ) {
                throw std::runtime_error( "option slider float values must be numbers" );
            }
            const double number = option_value.as<double>();
            if( !std::isfinite( number ) ) {
                throw std::runtime_error( "option slider float values must be finite" );
            }
            std::ostringstream stream;
            stream << std::setprecision( std::numeric_limits<double>::max_digits10 ) << number;
            native_option.value = stream.str();
        } else if( native_option.type == "bool" ) {
            if( !option_value.is<bool>() ) {
                throw std::runtime_error( "option slider bool values must be booleans" );
            }
            native_option.value = option_value.as<bool>() ? "true" : "false";
        } else if( native_option.type == "string" ) {
            if( !option_value.is<std::string>() ) {
                throw std::runtime_error( "option slider string values must be strings" );
            }
            native_option.value = option_value.as<std::string>();
        } else {
            throw std::runtime_error( "option slider option has unknown value type '" +
                                      native_option.type + "'" );
        }
        result.options.push_back( std::move( native_option ) );
    }
    return result;
}

struct option_slider_definition_handle {
    std::shared_ptr<detail::option_slider_native_definition> definition;
    std::shared_ptr<owner_token> token;

    option_slider_definition_handle &name( const std::string &value ) {
        require_building_handle( token, *definition, "option slider" );
        definition->name = value;
        return *this;
    }

    option_slider_definition_handle &context( const std::string &value ) {
        require_building_handle( token, *definition, "option slider" );
        definition->context = value;
        return *this;
    }

    option_slider_definition_handle &default_level( const std::int64_t value ) {
        require_building_handle( token, *definition, "option slider" );
        definition->default_level = value;
        return *this;
    }

    option_slider_definition_handle &levels( const sol::table &values ) {
        require_building_handle( token, *definition, "option slider" );
        const std::size_t count = require_dense_array(
                                      values, "option slider levels", 1, 256 );
        definition->levels.clear();
        definition->levels.reserve( count );
        for( std::size_t index = 1; index <= count; ++index ) {
            const sol::object value = values.raw_get<sol::object>( index );
            if( !value.is<sol::table>() ) {
                throw std::runtime_error( "option slider levels must be tables" );
            }
            definition->levels.push_back(
                read_option_slider_level( value.as<sol::table>() ) );
        }
        return *this;
    }

    option_slider_definition_handle &level( const sol::table &value ) {
        require_building_handle( token, *definition, "option slider" );
        detail::option_slider_native_level replacement = read_option_slider_level( value );
        const auto found = std::find_if(
                               definition->levels.begin(), definition->levels.end(),
        [&replacement]( const detail::option_slider_native_level & existing ) {
            return existing.level == replacement.level;
        } );
        if( found == definition->levels.end() ) {
            if( definition->levels.size() >= 256 ) {
                throw std::runtime_error( "option slider exceeds the Platform level limit" );
            }
            definition->levels.push_back( std::move( replacement ) );
        } else {
            *found = std::move( replacement );
        }
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "option slider" );
        return definition->id;
    }
};

struct dimension_definition_handle {
    std::shared_ptr<detail::dimension_native_definition> definition;
    std::shared_ptr<owner_token> token;

    dimension_definition_handle &region_layout( const std::string &value ) {
        require_building_handle( token, *definition, "dimension" );
        definition->region_layout = value;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "dimension" );
        return definition->id;
    }
};

struct dimension_region_layout_definition_handle {
    std::shared_ptr<detail::dimension_region_layout_native_definition> definition;
    std::shared_ptr<owner_token> token;

    dimension_region_layout_definition_handle &generation_mode(
        const std::string &value ) {
        require_building_handle( token, *definition, "dimension region layout" );
        definition->generation_mode = value;
        return *this;
    }

    dimension_region_layout_definition_handle &uniform_region(
        const std::string &value ) {
        require_building_handle( token, *definition, "dimension region layout" );
        definition->uniform_region = value;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "dimension region layout" );
        return definition->id;
    }
};

struct omt_placeholder_definition_data {
    std::string id;
    std::array<std::string, 24> grid;
    bool grid_set = false;
    bool registered = false;
};

struct omt_placeholder_definition_handle {
    std::shared_ptr<omt_placeholder_definition_data> definition;
    std::shared_ptr<owner_token> token;

    omt_placeholder_definition_handle &grid( const sol::table &values ) {
        require_building_handle( token, *definition, "overmap terrain placeholder" );
        require_dense_array( values, "overmap terrain placeholder grid", 24, 24 );
        for( std::size_t index = 1; index <= definition->grid.size(); ++index ) {
            const std::string row = values.get<std::string>( index );
            if( row.size() != 24 ||
            std::any_of( row.begin(), row.end(), []( const char value ) {
            return value != '0' && value != '1';
        } ) ) {
                throw std::runtime_error(
                    "overmap terrain placeholder grid rows need exactly 24 binary cells" );
            }
            definition->grid[index - 1] = row;
        }
        definition->grid_set = true;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "overmap terrain placeholder" );
        return definition->id;
    }
};

struct region_terrain_furniture_definition_data {
    std::string id;
    std::string ter_id;
    std::string furn_id;
    std::vector<std::pair<std::string, std::int64_t>> replace_with_terrain;
    std::vector<std::pair<std::string, std::int64_t>> replace_with_furniture;
    bool registered = false;
};

struct region_terrain_furniture_definition_handle {
    std::shared_ptr<region_terrain_furniture_definition_data> definition;
    std::shared_ptr<owner_token> token;

    region_terrain_furniture_definition_handle &ter_id( const std::string &value ) {
        require_building_handle( token, *definition, "region terrain furniture" );
        definition->ter_id = value;
        return *this;
    }

    region_terrain_furniture_definition_handle &furn_id( const std::string &value ) {
        require_building_handle( token, *definition, "region terrain furniture" );
        definition->furn_id = value;
        return *this;
    }

    region_terrain_furniture_definition_handle &replace_terrain( const std::string &terrain_id,
            const std::int64_t weight ) {
        require_building_handle( token, *definition, "region terrain furniture" );
        if( terrain_id.empty() || weight <= 0 ) {
            throw std::runtime_error( "region terrain furniture replace_terrain needs an id and positive weight" );
        }
        add_or_replace_weighted_entry( definition->replace_with_terrain, terrain_id, weight );
        return *this;
    }

    region_terrain_furniture_definition_handle &replace_with_terrain( const std::string &terrain_id,
            const std::int64_t weight ) {
        return replace_terrain( terrain_id, weight );
    }

    region_terrain_furniture_definition_handle &replace_furniture( const std::string &furniture_id,
            const std::int64_t weight ) {
        require_building_handle( token, *definition, "region terrain furniture" );
        if( furniture_id.empty() || weight <= 0 ) {
            throw std::runtime_error( "region terrain furniture replace_furniture needs an id and positive weight" );
        }
        add_or_replace_weighted_entry( definition->replace_with_furniture, furniture_id, weight );
        return *this;
    }

    region_terrain_furniture_definition_handle &replace_with_furniture( const std::string &furniture_id,
            const std::int64_t weight ) {
        return replace_furniture( furniture_id, weight );
    }

    std::string id() const {
        require_readable_handle( token, *definition, "region terrain furniture" );
        return definition->id;
    }
};

struct forest_biome_component_definition_data {
    std::string id;
    std::int64_t chance = 0;
    std::int64_t sequence = 0;
    std::vector<std::pair<std::string, std::int64_t>> types;
    bool registered = false;
};

struct forest_biome_component_definition_handle {
    std::shared_ptr<forest_biome_component_definition_data> definition;
    std::shared_ptr<owner_token> token;

    forest_biome_component_definition_handle &chance( const std::int64_t value ) {
        require_building_handle( token, *definition, "forest biome component" );
        definition->chance = value;
        return *this;
    }

    forest_biome_component_definition_handle &sequence( const std::int64_t value ) {
        require_building_handle( token, *definition, "forest biome component" );
        definition->sequence = value;
        return *this;
    }

    forest_biome_component_definition_handle &type( const std::string &ter_furn_id,
            const std::int64_t weight ) {
        require_building_handle( token, *definition, "forest biome component" );
        if( ter_furn_id.empty() || weight <= 0 ) {
            throw std::runtime_error( "forest biome component type needs an id and positive weight" );
        }
        add_or_replace_weighted_entry( definition->types, ter_furn_id, weight );
        return *this;
    }

    forest_biome_component_definition_handle &add_type( const std::string &ter_furn_id,
            const std::int64_t weight ) {
        return type( ter_furn_id, weight );
    }

    std::string id() const {
        require_readable_handle( token, *definition, "forest biome component" );
        return definition->id;
    }
};

struct city_definition_data {
    std::string id;
    std::int64_t database_id = 0;
    bool database_id_set = false;
    std::string name;
    std::int64_t population = 0;
    std::int64_t size = -1;
    std::int64_t pos_om_x = 0;
    std::int64_t pos_om_y = 0;
    bool pos_om_set = false;
    std::int64_t pos_x = 0;
    std::int64_t pos_y = 0;
    bool pos_set = false;
    bool registered = false;
};

struct city_definition_handle {
    std::shared_ptr<city_definition_data> definition;
    std::shared_ptr<owner_token> token;

    city_definition_handle &database_id( const std::int64_t value ) {
        require_building_handle( token, *definition, "city" );
        if( !fits_native_int( value ) ) {
            throw std::runtime_error( "city database_id outside native integer range" );
        }
        definition->database_id = value;
        definition->database_id_set = true;
        return *this;
    }

    city_definition_handle &name( const std::string &value ) {
        require_building_handle( token, *definition, "city" );
        definition->name = value;
        return *this;
    }

    city_definition_handle &population( const std::int64_t value ) {
        require_building_handle( token, *definition, "city" );
        if( !fits_native_int( value ) || value < 0 ) {
            throw std::runtime_error( "city population must be a non-negative native integer" );
        }
        definition->population = value;
        return *this;
    }

    city_definition_handle &size( const std::int64_t value ) {
        require_building_handle( token, *definition, "city" );
        if( !fits_native_int( value ) || value < -1 ) {
            throw std::runtime_error( "city size must be >= -1" );
        }
        definition->size = value;
        return *this;
    }

    city_definition_handle &pos_om( const std::int64_t x, const std::int64_t y ) {
        require_building_handle( token, *definition, "city" );
        if( !fits_native_int( x ) || !fits_native_int( y ) ) {
            throw std::runtime_error( "city pos_om coordinate outside native integer range" );
        }
        definition->pos_om_x = x;
        definition->pos_om_y = y;
        definition->pos_om_set = true;
        return *this;
    }

    city_definition_handle &pos_om_table( const sol::table &table ) {
        require_building_handle( token, *definition, "city" );
        const auto [x, y] = read_exact_coordinate_table( table, "city pos_om" );
        return pos_om( x, y );
    }

    city_definition_handle &pos( const std::int64_t x, const std::int64_t y ) {
        require_building_handle( token, *definition, "city" );
        if( !fits_native_int( x ) || !fits_native_int( y ) ) {
            throw std::runtime_error( "city pos coordinate outside native integer range" );
        }
        definition->pos_x = x;
        definition->pos_y = y;
        definition->pos_set = true;
        return *this;
    }

    city_definition_handle &pos_table( const sol::table &table ) {
        require_building_handle( token, *definition, "city" );
        const auto [x, y] = read_exact_coordinate_table( table, "city pos" );
        return pos( x, y );
    }

    std::string id() const {
        require_readable_handle( token, *definition, "city" );
        return definition->id;
    }
};

struct faction_mission_definition_data {
    std::string id;
    std::string name;
    std::string description;
    std::string skill;
    std::string difficulty;
    std::string risk;
    std::string activity;
    std::string time;
    std::int64_t positions = 0;
    std::string items_label;
    std::vector<std::string> items_possibilities;
    std::vector<std::string> effects;
    std::string footer;
    bool registered = false;
};

struct faction_mission_definition_handle {
    std::shared_ptr<faction_mission_definition_data> definition;
    std::shared_ptr<owner_token> token;

    faction_mission_definition_handle &name( const std::string &value ) {
        require_building_handle( token, *definition, "faction_mission" );
        definition->name = value;
        return *this;
    }

    faction_mission_definition_handle &desc( const std::string &value ) {
        require_building_handle( token, *definition, "faction_mission" );
        definition->description = value;
        return *this;
    }

    faction_mission_definition_handle &description( const std::string &value ) {
        return desc( value );
    }

    faction_mission_definition_handle &skill( const std::string &value ) {
        require_building_handle( token, *definition, "faction_mission" );
        definition->skill = value;
        return *this;
    }

    faction_mission_definition_handle &difficulty( const std::string &value ) {
        require_building_handle( token, *definition, "faction_mission" );
        definition->difficulty = value;
        return *this;
    }

    faction_mission_definition_handle &risk( const std::string &value ) {
        require_building_handle( token, *definition, "faction_mission" );
        definition->risk = value;
        return *this;
    }

    faction_mission_definition_handle &activity( const std::string &value ) {
        require_building_handle( token, *definition, "faction_mission" );
        definition->activity = value;
        return *this;
    }

    faction_mission_definition_handle &time( const std::string &value ) {
        require_building_handle( token, *definition, "faction_mission" );
        definition->time = value;
        return *this;
    }

    faction_mission_definition_handle &positions( const std::int64_t value ) {
        require_building_handle( token, *definition, "faction_mission" );
        if( !fits_native_int( value ) || value < 0 || value > 65535 ) {
            throw std::runtime_error( "faction_mission positions must be between 0 and 65535" );
        }
        definition->positions = value;
        return *this;
    }

    faction_mission_definition_handle &items_label( const std::string &value ) {
        require_building_handle( token, *definition, "faction_mission" );
        definition->items_label = value;
        return *this;
    }

    faction_mission_definition_handle &items_possibility( const std::string &value ) {
        require_building_handle( token, *definition, "faction_mission" );
        if( value.empty() ) {
            throw std::runtime_error( "faction_mission items_possibility needs non-empty string" );
        }
        if( definition->items_possibilities.size() >= 1024 ) {
            throw std::runtime_error( "faction_mission items_possibilities exceeds Platform limit" );
        }
        definition->items_possibilities.push_back( value );
        return *this;
    }

    faction_mission_definition_handle &add_items_possibility( const std::string &value ) {
        return items_possibility( value );
    }

    faction_mission_definition_handle &items_possibilities( const sol::table &table ) {
        require_building_handle( token, *definition, "faction_mission" );
        const std::size_t count = require_dense_array( table, "faction_mission items_possibilities", 0,
                                  1024 );
        definition->items_possibilities.clear();
        for( std::size_t i = 1; i <= count; ++i ) {
            const sol::object elem = table.raw_get<sol::object>( i );
            if( !elem.is<std::string>() ) {
                throw std::runtime_error( "faction_mission items_possibilities entries must be strings" );
            }
            const std::string s = elem.as<std::string>();
            if( s.empty() ) {
                throw std::runtime_error( "faction_mission items_possibilities entries cannot be empty" );
            }
            definition->items_possibilities.push_back( s );
        }
        return *this;
    }

    faction_mission_definition_handle &effect( const std::string &value ) {
        require_building_handle( token, *definition, "faction_mission" );
        if( value.empty() ) {
            throw std::runtime_error( "faction_mission effect needs non-empty string" );
        }
        if( definition->effects.size() >= 1024 ) {
            throw std::runtime_error( "faction_mission effects exceeds Platform limit" );
        }
        definition->effects.push_back( value );
        return *this;
    }

    faction_mission_definition_handle &add_effect( const std::string &value ) {
        return effect( value );
    }

    faction_mission_definition_handle &effects( const sol::table &table ) {
        require_building_handle( token, *definition, "faction_mission" );
        const std::size_t count = require_dense_array( table, "faction_mission effects", 0, 1024 );
        definition->effects.clear();
        for( std::size_t i = 1; i <= count; ++i ) {
            const sol::object elem = table.raw_get<sol::object>( i );
            if( !elem.is<std::string>() ) {
                throw std::runtime_error( "faction_mission effects entries must be strings" );
            }
            const std::string s = elem.as<std::string>();
            if( s.empty() ) {
                throw std::runtime_error( "faction_mission effects entries cannot be empty" );
            }
            definition->effects.push_back( s );
        }
        return *this;
    }

    faction_mission_definition_handle &footer( const std::string &value ) {
        require_building_handle( token, *definition, "faction_mission" );
        definition->footer = value;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "faction_mission" );
        return definition->id;
    }
};

struct region_settings_city_definition_data {
    std::string id;
    bool is_megacity = false;
    std::int64_t city_size = 8;
    bool city_size_set = false;
    std::int64_t city_spacing = 4;
    std::int64_t shop_radius = 30;
    std::int64_t shop_sigma = 20;
    std::int64_t park_radius = 30;
    std::int64_t park_sigma = 70;
    std::string name_snippet = "<city_name>";
    std::vector<std::pair<std::string, std::int64_t>> houses;
    std::vector<std::pair<std::string, std::int64_t>> shops;
    std::vector<std::pair<std::string, std::int64_t>> parks;
    bool registered = false;
};

struct region_settings_city_definition_handle {
    std::shared_ptr<region_settings_city_definition_data> definition;
    std::shared_ptr<owner_token> token;

    region_settings_city_definition_handle &is_megacity( const bool value ) {
        require_building_handle( token, *definition, "region_settings_city" );
        definition->is_megacity = value;
        return *this;
    }

    region_settings_city_definition_handle &city_size( const std::int64_t value ) {
        require_building_handle( token, *definition, "region_settings_city" );
        if( !fits_native_int( value ) || value < 0 || value > 16 ) {
            throw std::runtime_error( "region_settings_city city_size must be between 0 and 16" );
        }
        definition->city_size = value;
        definition->city_size_set = true;
        return *this;
    }

    region_settings_city_definition_handle &city_spacing( const std::int64_t value ) {
        require_building_handle( token, *definition, "region_settings_city" );
        if( !fits_native_int( value ) || value < 0 || value > 8 ) {
            throw std::runtime_error( "region_settings_city city_spacing must be between 0 and 8" );
        }
        definition->city_spacing = value;
        return *this;
    }

    region_settings_city_definition_handle &shop_radius( const std::int64_t value ) {
        require_building_handle( token, *definition, "region_settings_city" );
        if( !fits_native_int( value ) || value < 0 ) {
            throw std::runtime_error( "region_settings_city shop_radius must be a non-negative integer" );
        }
        definition->shop_radius = value;
        return *this;
    }

    region_settings_city_definition_handle &shop_sigma( const std::int64_t value ) {
        require_building_handle( token, *definition, "region_settings_city" );
        if( !fits_native_int( value ) || value < 0 ) {
            throw std::runtime_error( "region_settings_city shop_sigma must be a non-negative integer" );
        }
        definition->shop_sigma = value;
        return *this;
    }

    region_settings_city_definition_handle &park_radius( const std::int64_t value ) {
        require_building_handle( token, *definition, "region_settings_city" );
        if( !fits_native_int( value ) || value < 0 ) {
            throw std::runtime_error( "region_settings_city park_radius must be a non-negative integer" );
        }
        definition->park_radius = value;
        return *this;
    }

    region_settings_city_definition_handle &park_sigma( const std::int64_t value ) {
        require_building_handle( token, *definition, "region_settings_city" );
        if( !fits_native_int( value ) || value < 0 ) {
            throw std::runtime_error( "region_settings_city park_sigma must be a non-negative integer" );
        }
        definition->park_sigma = value;
        return *this;
    }

    region_settings_city_definition_handle &name_snippet( const std::string &value ) {
        require_building_handle( token, *definition, "region_settings_city" );
        definition->name_snippet = value;
        return *this;
    }

    region_settings_city_definition_handle &house( const std::string &special_id,
            const std::int64_t weight ) {
        require_building_handle( token, *definition, "region_settings_city" );
        if( special_id.empty() || weight <= 0 ) {
            throw std::runtime_error( "region_settings_city house needs an id and positive weight" );
        }
        add_or_replace_weighted_entry( definition->houses, special_id, weight );
        return *this;
    }

    region_settings_city_definition_handle &add_house( const std::string &special_id,
            const std::int64_t weight ) {
        return house( special_id, weight );
    }

    region_settings_city_definition_handle &houses( const sol::table &table ) {
        require_building_handle( token, *definition, "region_settings_city" );
        definition->houses.clear();
        parse_weighted_table_entries( table, "region_settings_city houses", definition->houses );
        return *this;
    }

    region_settings_city_definition_handle &shop( const std::string &special_id,
            const std::int64_t weight ) {
        require_building_handle( token, *definition, "region_settings_city" );
        if( special_id.empty() || weight <= 0 ) {
            throw std::runtime_error( "region_settings_city shop needs an id and positive weight" );
        }
        add_or_replace_weighted_entry( definition->shops, special_id, weight );
        return *this;
    }

    region_settings_city_definition_handle &add_shop( const std::string &special_id,
            const std::int64_t weight ) {
        return shop( special_id, weight );
    }

    region_settings_city_definition_handle &shops( const sol::table &table ) {
        require_building_handle( token, *definition, "region_settings_city" );
        definition->shops.clear();
        parse_weighted_table_entries( table, "region_settings_city shops", definition->shops );
        return *this;
    }

    region_settings_city_definition_handle &park( const std::string &special_id,
            const std::int64_t weight ) {
        require_building_handle( token, *definition, "region_settings_city" );
        if( special_id.empty() || weight <= 0 ) {
            throw std::runtime_error( "region_settings_city park needs an id and positive weight" );
        }
        add_or_replace_weighted_entry( definition->parks, special_id, weight );
        return *this;
    }

    region_settings_city_definition_handle &add_park( const std::string &special_id,
            const std::int64_t weight ) {
        return park( special_id, weight );
    }

    region_settings_city_definition_handle &parks( const sol::table &table ) {
        require_building_handle( token, *definition, "region_settings_city" );
        definition->parks.clear();
        parse_weighted_table_entries( table, "region_settings_city parks", definition->parks );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "region_settings_city" );
        return definition->id;
    }
};

struct forest_biome_terrain_furniture_data {
    std::string ter_id;
    std::int64_t chance = 0;
    std::vector<std::pair<std::string, std::int64_t>> furniture;
};

struct forest_biome_mapgen_definition_data {
    std::string id;
    std::vector<std::string> terrains;
    std::vector<std::string> components;
    std::vector<std::pair<std::string, std::int64_t>> groundcover;
    std::vector<forest_biome_terrain_furniture_data> terrain_furniture;
    std::int64_t sparseness_adjacency_factor = 0;
    std::string item_group;
    std::int64_t item_group_chance = 0;
    std::int64_t item_spawn_iterations = 0;
    bool registered = false;
};

struct forest_biome_mapgen_definition_handle {
    std::shared_ptr<forest_biome_mapgen_definition_data> definition;
    std::shared_ptr<owner_token> token;

    forest_biome_mapgen_definition_handle &sparseness_adjacency_factor( const std::int64_t value ) {
        require_building_handle( token, *definition, "forest_biome_mapgen" );
        if( !fits_native_int( value ) ) {
            throw std::runtime_error( "forest_biome_mapgen sparseness_adjacency_factor outside native integer range" );
        }
        definition->sparseness_adjacency_factor = value;
        return *this;
    }

    forest_biome_mapgen_definition_handle &item_group( const std::string &value ) {
        require_building_handle( token, *definition, "forest_biome_mapgen" );
        definition->item_group = value;
        return *this;
    }

    forest_biome_mapgen_definition_handle &item_group_chance( const std::int64_t value ) {
        require_building_handle( token, *definition, "forest_biome_mapgen" );
        if( !fits_native_int( value ) || value < 0 ) {
            throw std::runtime_error( "forest_biome_mapgen item_group_chance must be >= 0" );
        }
        definition->item_group_chance = value;
        return *this;
    }

    forest_biome_mapgen_definition_handle &item_spawn_iterations( const std::int64_t value ) {
        require_building_handle( token, *definition, "forest_biome_mapgen" );
        if( !fits_native_int( value ) || value < 0 ) {
            throw std::runtime_error( "forest_biome_mapgen item_spawn_iterations must be >= 0" );
        }
        definition->item_spawn_iterations = value;
        return *this;
    }

    forest_biome_mapgen_definition_handle &terrain( const std::string &value ) {
        require_building_handle( token, *definition, "forest_biome_mapgen" );
        if( value.empty() ) {
            throw std::runtime_error( "forest_biome_mapgen terrain cannot be empty" );
        }
        if( definition->terrains.size() >= 1024 ) {
            throw std::runtime_error( "forest_biome_mapgen terrains exceeds Platform limit" );
        }
        if( std::find( definition->terrains.begin(), definition->terrains.end(), value ) ==
            definition->terrains.end() ) {
            definition->terrains.push_back( value );
            std::sort( definition->terrains.begin(), definition->terrains.end() );
        }
        return *this;
    }

    forest_biome_mapgen_definition_handle &add_terrain( const std::string &value ) {
        return terrain( value );
    }

    forest_biome_mapgen_definition_handle &terrains( const sol::table &table ) {
        require_building_handle( token, *definition, "forest_biome_mapgen" );
        const std::size_t count = require_dense_array( table, "forest_biome_mapgen terrains", 0, 1024 );
        definition->terrains.clear();
        for( std::size_t i = 1; i <= count; ++i ) {
            const sol::object elem = table.raw_get<sol::object>( i );
            if( !elem.is<std::string>() ) {
                throw std::runtime_error( "forest_biome_mapgen terrains entries must be strings" );
            }
            terrain( elem.as<std::string>() );
        }
        return *this;
    }

    forest_biome_mapgen_definition_handle &component( const std::string &value ) {
        require_building_handle( token, *definition, "forest_biome_mapgen" );
        if( value.empty() ) {
            throw std::runtime_error( "forest_biome_mapgen component cannot be empty" );
        }
        if( definition->components.size() >= 1024 ) {
            throw std::runtime_error( "forest_biome_mapgen components exceeds Platform limit" );
        }
        if( std::find( definition->components.begin(), definition->components.end(), value ) ==
            definition->components.end() ) {
            definition->components.push_back( value );
            std::sort( definition->components.begin(), definition->components.end() );
        }
        return *this;
    }

    forest_biome_mapgen_definition_handle &add_component( const std::string &value ) {
        return component( value );
    }

    forest_biome_mapgen_definition_handle &components( const sol::table &table ) {
        require_building_handle( token, *definition, "forest_biome_mapgen" );
        const std::size_t count = require_dense_array( table, "forest_biome_mapgen components", 0, 1024 );
        definition->components.clear();
        for( std::size_t i = 1; i <= count; ++i ) {
            const sol::object elem = table.raw_get<sol::object>( i );
            if( !elem.is<std::string>() ) {
                throw std::runtime_error( "forest_biome_mapgen components entries must be strings" );
            }
            component( elem.as<std::string>() );
        }
        return *this;
    }

    forest_biome_mapgen_definition_handle &groundcover_entry( const std::string &ter_id,
            const std::int64_t weight ) {
        require_building_handle( token, *definition, "forest_biome_mapgen" );
        if( ter_id.empty() || weight <= 0 ) {
            throw std::runtime_error( "forest_biome_mapgen groundcover needs terrain id and positive weight" );
        }
        add_or_replace_weighted_entry( definition->groundcover, ter_id, weight );
        return *this;
    }

    forest_biome_mapgen_definition_handle &add_groundcover( const std::string &ter_id,
            const std::int64_t weight ) {
        return groundcover_entry( ter_id, weight );
    }

    forest_biome_mapgen_definition_handle &groundcover( const sol::table &table ) {
        require_building_handle( token, *definition, "forest_biome_mapgen" );
        definition->groundcover.clear();
        parse_weighted_table_entries( table, "forest_biome_mapgen groundcover", definition->groundcover );
        return *this;
    }

    forest_biome_mapgen_definition_handle &terrain_furniture_entry(
        const std::string &ter_id, const std::int64_t chance, const sol::table &furniture_table ) {
        require_building_handle( token, *definition, "forest_biome_mapgen" );
        if( ter_id.empty() ) {
            throw std::runtime_error( "forest_biome_mapgen terrain_furniture needs a terrain id" );
        }
        if( !fits_native_int( chance ) || chance < 0 ) {
            throw std::runtime_error( "forest_biome_mapgen terrain_furniture chance must be >= 0" );
        }
        auto it = std::find_if( definition->terrain_furniture.begin(), definition->terrain_furniture.end(),
        [&ter_id]( const forest_biome_terrain_furniture_data & entry ) {
            return entry.ter_id == ter_id;
        } );
        if( it == definition->terrain_furniture.end() ) {
            if( definition->terrain_furniture.size() >= 1024 ) {
                throw std::runtime_error( "forest_biome_mapgen terrain_furniture exceeds Platform limit" );
            }
            definition->terrain_furniture.push_back( { ter_id, chance, {} } );
            it = definition->terrain_furniture.end() - 1;
        } else {
            it->chance = chance;
        }
        it->furniture.clear();
        parse_weighted_table_entries( furniture_table, "forest_biome_mapgen terrain_furniture furniture",
                                      it->furniture );
        std::sort( definition->terrain_furniture.begin(), definition->terrain_furniture.end(),
                   []( const forest_biome_terrain_furniture_data & lhs,
        const forest_biome_terrain_furniture_data & rhs ) {
            return lhs.ter_id < rhs.ter_id;
        } );
        return *this;
    }

    forest_biome_mapgen_definition_handle &add_terrain_furniture(
        const std::string &ter_id, const std::int64_t chance, const sol::table &furniture_table ) {
        return terrain_furniture_entry( ter_id, chance, furniture_table );
    }

    forest_biome_mapgen_definition_handle &terrain_furniture_table( const sol::table &table ) {
        require_building_handle( token, *definition, "forest_biome_mapgen" );
        definition->terrain_furniture.clear();
        for( const auto &[key, val] : table ) {
            if( !key.is<std::string>() || !val.is<sol::table>() ) {
                throw std::runtime_error( "forest_biome_mapgen terrain_furniture map keys must be terrain strings and values tables" );
            }
            const std::string ter_id = key.as<std::string>();
            const sol::table entry_tbl = val.as<sol::table>();
            const std::int64_t chance = entry_tbl.get_or<std::int64_t>( "chance", 0 );
            const sol::optional<sol::table> furn_tbl = entry_tbl.get<sol::optional<sol::table>>( "furniture" );
            if( !furn_tbl ) {
                throw std::runtime_error( "forest_biome_mapgen terrain_furniture entry missing furniture table" );
            }
            terrain_furniture_entry( ter_id, chance, *furn_tbl );
        }
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "forest_biome_mapgen" );
        return definition->id;
    }
};

template<typename Definition>
struct catalog_registration {
    definition_operation operation = definition_operation::add;
    std::shared_ptr<Definition> definition;
};

using region_settings_ravine_registration =
    catalog_registration<region_settings_ravine_definition_data>;
using region_settings_lake_registration =
    catalog_registration<region_settings_lake_definition_data>;
using region_settings_ocean_registration =
    catalog_registration<region_settings_ocean_definition_data>;
using region_settings_forest_registration =
    catalog_registration<region_settings_forest_definition_data>;
using region_settings_river_registration =
    catalog_registration<region_settings_river_definition_data>;
using region_settings_forest_mapgen_registration =
    catalog_registration<region_settings_forest_mapgen_definition_data>;
using region_settings_map_extras_registration =
    catalog_registration<region_settings_map_extras_definition_data>;
using region_settings_terrain_furniture_registration =
    catalog_registration<region_settings_terrain_furniture_definition_data>;
using region_settings_forest_trail_registration =
    catalog_registration<region_settings_forest_trail_definition_data>;
using region_settings_highway_registration =
    catalog_registration<region_settings_highway_definition_data>;
using region_settings_registration =
    catalog_registration<region_settings_definition_data>;
using option_slider_registration =
    catalog_registration<detail::option_slider_native_definition>;
using dimension_registration =
    catalog_registration<detail::dimension_native_definition>;
using dimension_region_layout_registration =
    catalog_registration<detail::dimension_region_layout_native_definition>;
using omt_placeholder_registration =
    catalog_registration<omt_placeholder_definition_data>;
using region_terrain_furniture_registration =
    catalog_registration<region_terrain_furniture_definition_data>;
using forest_biome_component_registration =
    catalog_registration<forest_biome_component_definition_data>;
using city_registration = catalog_registration<city_definition_data>;
using faction_mission_registration = catalog_registration<faction_mission_definition_data>;
using region_settings_city_registration =
    catalog_registration<region_settings_city_definition_data>;
using forest_biome_mapgen_registration =
    catalog_registration<forest_biome_mapgen_definition_data>;

} // namespace

struct worldgen_content_transaction::impl {
    impl( std::string owner_id, const std::size_t owner_generation ) :
        owner( std::move( owner_id ) ), generation( owner_generation ),
        token( std::make_shared<owner_token>( owner_token{ owner, generation,
                                              handle_lifecycle::building } ) ) {}

    std::string owner;
    std::size_t generation = 0;
    std::shared_ptr<owner_token> token;
    bool applied = false;
    mutable bool finalization_validated = false;

    std::vector<region_settings_ravine_registration> region_settings_ravines;
    std::vector<region_settings_lake_registration> region_settings_lakes;
    std::vector<region_settings_ocean_registration> region_settings_oceans;
    std::vector<region_settings_forest_registration> region_settings_forests;
    std::vector<region_settings_river_registration> region_settings_rivers;
    std::vector<region_settings_forest_mapgen_registration> region_settings_forest_mapgens;
    std::vector<region_settings_map_extras_registration> region_settings_map_extrases;
    std::vector<region_settings_terrain_furniture_registration> region_settings_terrain_furnitures;
    std::vector<region_settings_forest_trail_registration> region_settings_forest_trails;
    std::vector<region_settings_highway_registration> region_settings_highways;
    std::vector<region_settings_registration> region_settings;
    std::vector<option_slider_registration> option_sliders;
    std::vector<dimension_region_layout_registration> dimension_region_layouts;
    std::vector<dimension_registration> dimensions;
    std::vector<omt_placeholder_registration> omt_placeholders;
    std::vector<region_terrain_furniture_registration> region_terrain_furnitures;
    std::vector<forest_biome_component_registration> forest_biome_components;
    std::vector<city_registration> cities;
    std::vector<faction_mission_registration> faction_missions;
    std::vector<region_settings_city_registration> region_settings_cities;
    std::vector<forest_biome_mapgen_registration> forest_biome_mapgens;

    std::vector<std::pair<region_settings_ravine_id, std::optional<region_settings_ravine>>>
    region_settings_ravine_undo;
    std::vector<std::pair<region_settings_lake_id, std::optional<region_settings_lake>>>
    region_settings_lake_undo;
    std::vector<std::pair<region_settings_ocean_id, std::optional<region_settings_ocean>>>
    region_settings_ocean_undo;
    std::vector<std::pair<region_settings_forest_id, std::optional<region_settings_forest>>>
    region_settings_forest_undo;
    std::vector<std::pair<region_settings_river_id, std::optional<region_settings_river>>>
    region_settings_river_undo;
    std::vector<std::pair<region_settings_forest_mapgen_id,
        std::optional<region_settings_forest_mapgen>>>
        region_settings_forest_mapgen_undo;
    std::vector<std::pair<region_settings_map_extras_id,
        std::optional<region_settings_map_extras>>>
        region_settings_map_extras_undo;
    std::vector<std::pair<region_settings_terrain_furniture_id,
        std::optional<region_settings_terrain_furniture>>>
        region_settings_terrain_furniture_undo;
    std::vector<std::pair<region_settings_forest_trail_id,
        std::optional<region_settings_forest_trail>>>
        region_settings_forest_trail_undo;
    std::vector<std::pair<region_settings_highway_id,
        std::optional<region_settings_highway>>>
        region_settings_highway_undo;
    std::vector<std::pair<region_settings_id, std::optional<::region_settings>>>
    region_settings_undo;
    std::vector<std::pair<option_slider_id, std::optional<option_slider>>>
    option_slider_undo;
    std::vector<std::pair<dimension_region_layout_id,
        std::optional<dimension_region_layout>>> dimension_region_layout_undo;
    std::vector<std::pair<dimension_id, std::optional<dimension_world>>>
    dimension_undo;
    std::vector<std::pair<string_id<map_data_summary>,
        std::optional<map_data_summary>>> omt_placeholder_undo;
    std::vector<std::pair<region_terrain_furniture_id,
        std::optional<region_terrain_furniture>>> region_terrain_furniture_undo;
    std::vector<std::pair<forest_biome_component_id,
        std::optional<forest_biome_component>>> forest_biome_component_undo;
    std::vector<std::pair<city_id, std::optional<city>>> city_undo;
    std::vector<std::pair<faction_mission_id,
        std::optional<faction_mission>>> faction_mission_undo;
    std::vector<std::pair<region_settings_city_id,
        std::optional<region_settings_city>>> region_settings_city_undo;
    std::vector<std::pair<forest_biome_mapgen_id,
        std::optional<forest_biome_mapgen>>> forest_biome_mapgen_undo;
};

worldgen_content_transaction::worldgen_content_transaction( std::string owner,
        const std::size_t generation ) :
    pimpl_( std::make_unique<impl>( std::move( owner ), generation ) )
{
}

worldgen_content_transaction::~worldgen_content_transaction() = default;

void worldgen_content_transaction::install_lua_api( sol::state &lua, sol::table &ccb,
        sol::table &content )
{
    ccb.new_usertype<region_settings_ravine_definition_handle>(
        "RegionSettingsRavineDefinition", sol::no_constructor,
        "id", sol::property( &region_settings_ravine_definition_handle::id ),
        "num_ravines", &region_settings_ravine_definition_handle::num_ravines,
        "ravine_range", &region_settings_ravine_definition_handle::ravine_range,
        "ravine_width", &region_settings_ravine_definition_handle::ravine_width,
        "ravine_depth", &region_settings_ravine_definition_handle::ravine_depth );
    ccb.new_usertype<region_settings_lake_definition_handle>(
        "RegionSettingsLakeDefinition", sol::no_constructor,
        "id", sol::property( &region_settings_lake_definition_handle::id ),
        "noise_threshold_lake", &region_settings_lake_definition_handle::noise_threshold_lake,
        "lake_size_min", &region_settings_lake_definition_handle::lake_size_min,
        "lake_depth", &region_settings_lake_definition_handle::lake_depth,
        "invert_lakes", &region_settings_lake_definition_handle::invert_lakes,
        "surface_ter", &region_settings_lake_definition_handle::surface_ter,
        "shore_ter", &region_settings_lake_definition_handle::shore_ter,
        "interior_ter", &region_settings_lake_definition_handle::interior_ter,
        "bed_ter", &region_settings_lake_definition_handle::bed_ter,
        "shore_extendable_terrain", &region_settings_lake_definition_handle::shore_extendable_terrain,
        "shore_extendable_alias", &region_settings_lake_definition_handle::shore_extendable_alias );
    ccb.new_usertype<region_settings_ocean_definition_handle>(
        "RegionSettingsOceanDefinition", sol::no_constructor,
        "id", sol::property( &region_settings_ocean_definition_handle::id ),
        "noise_threshold_ocean", &region_settings_ocean_definition_handle::noise_threshold_ocean,
        "ocean_size_min", &region_settings_ocean_definition_handle::ocean_size_min,
        "ocean_depth", &region_settings_ocean_definition_handle::ocean_depth,
        "ocean_start_north", &region_settings_ocean_definition_handle::ocean_start_north,
        "ocean_start_east", &region_settings_ocean_definition_handle::ocean_start_east,
        "ocean_start_west", &region_settings_ocean_definition_handle::ocean_start_west,
        "ocean_start_south", &region_settings_ocean_definition_handle::ocean_start_south,
        "sandy_beach_width", &region_settings_ocean_definition_handle::sandy_beach_width );
    ccb.new_usertype<region_settings_forest_definition_handle>(
        "RegionSettingsForestDefinition", sol::no_constructor,
        "id", sol::property( &region_settings_forest_definition_handle::id ),
        "noise_threshold_forest", &region_settings_forest_definition_handle::noise_threshold_forest,
        "noise_threshold_forest_thick",
        &region_settings_forest_definition_handle::noise_threshold_forest_thick,
        "noise_threshold_swamp_adjacent_water",
        &region_settings_forest_definition_handle::noise_threshold_swamp_adjacent_water,
        "noise_threshold_swamp_isolated",
        &region_settings_forest_definition_handle::noise_threshold_swamp_isolated,
        "river_floodplain_buffer_distance_min",
        &region_settings_forest_definition_handle::river_floodplain_buffer_distance_min,
        "river_floodplain_buffer_distance_max",
        &region_settings_forest_definition_handle::river_floodplain_buffer_distance_max,
        "forest_threshold_limit", &region_settings_forest_definition_handle::forest_threshold_limit,
        "forest_threshold_increase",
        &region_settings_forest_definition_handle::forest_threshold_increase );
    ccb.new_usertype<region_settings_river_definition_handle>(
        "RegionSettingsRiverDefinition", sol::no_constructor,
        "id", sol::property( &region_settings_river_definition_handle::id ),
        "river_scale", &region_settings_river_definition_handle::river_scale,
        "river_frequency", &region_settings_river_definition_handle::river_frequency,
        "river_branch_chance", &region_settings_river_definition_handle::river_branch_chance,
        "river_branch_remerge_chance",
        &region_settings_river_definition_handle::river_branch_remerge_chance,
        "river_branch_scale_decrease",
        &region_settings_river_definition_handle::river_branch_scale_decrease );
    ccb.new_usertype<region_settings_forest_mapgen_definition_handle>(
        "RegionSettingsForestMapgenDefinition", sol::no_constructor,
        "id", sol::property( &region_settings_forest_mapgen_definition_handle::id ),
        "biome", &region_settings_forest_mapgen_definition_handle::biome,
        "biomes", &region_settings_forest_mapgen_definition_handle::biomes );
    ccb.new_usertype<region_settings_map_extras_definition_handle>(
        "RegionSettingsMapExtrasDefinition", sol::no_constructor,
        "id", sol::property( &region_settings_map_extras_definition_handle::id ),
        "extra", &region_settings_map_extras_definition_handle::extra,
        "extras", &region_settings_map_extras_definition_handle::extras );
    ccb.new_usertype<region_settings_terrain_furniture_definition_handle>(
        "RegionSettingsTerrainFurnitureDefinition", sol::no_constructor,
        "id", sol::property( &region_settings_terrain_furniture_definition_handle::id ),
        "terrain_furniture",
        &region_settings_terrain_furniture_definition_handle::terrain_furniture,
        "ter_furn", &region_settings_terrain_furniture_definition_handle::ter_furn );
    ccb.new_usertype<region_settings_forest_trail_definition_handle>(
        "RegionSettingsForestTrailDefinition", sol::no_constructor,
        "id", sol::property( &region_settings_forest_trail_definition_handle::id ),
        "chance", &region_settings_forest_trail_definition_handle::chance,
        "border_point_chance", &region_settings_forest_trail_definition_handle::border_point_chance,
        "minimum_forest_size", &region_settings_forest_trail_definition_handle::minimum_forest_size,
        "random_point_min", &region_settings_forest_trail_definition_handle::random_point_min,
        "random_point_max", &region_settings_forest_trail_definition_handle::random_point_max,
        "random_point_size_scalar",
        &region_settings_forest_trail_definition_handle::random_point_size_scalar,
        "trailhead_chance", &region_settings_forest_trail_definition_handle::trailhead_chance,
        "trailhead_road_distance",
        &region_settings_forest_trail_definition_handle::trailhead_road_distance,
        "trailhead", &region_settings_forest_trail_definition_handle::trailhead,
        "add_trailhead", &region_settings_forest_trail_definition_handle::add_trailhead );
    ccb.new_usertype<region_settings_highway_definition_handle>(
        "RegionSettingsHighwayDefinition", sol::no_constructor,
        "id", sol::property( &region_settings_highway_definition_handle::id ),
        "width_of_segments", &region_settings_highway_definition_handle::width_of_segments,
        "straightness_chance", &region_settings_highway_definition_handle::straightness_chance,
        "reserved_terrain_id", &region_settings_highway_definition_handle::reserved_terrain_id,
        "reserved_terrain_water_id",
        &region_settings_highway_definition_handle::reserved_terrain_water_id,
        "segment_flat_special", &region_settings_highway_definition_handle::segment_flat_special,
        "segment_ramp_special", &region_settings_highway_definition_handle::segment_ramp_special,
        "segment_road_bridge_special",
        &region_settings_highway_definition_handle::segment_road_bridge_special,
        "segment_bridge_special", &region_settings_highway_definition_handle::segment_bridge_special,
        "segment_bridge_supports_special",
        &region_settings_highway_definition_handle::segment_bridge_supports_special,
        "segment_overpass_special", &region_settings_highway_definition_handle::segment_overpass_special,
        "clockwise_slant_special", &region_settings_highway_definition_handle::clockwise_slant_special,
        "counterclockwise_slant_special",
        &region_settings_highway_definition_handle::counterclockwise_slant_special,
        "fallback_onramp_special",
        &region_settings_highway_definition_handle::fallback_onramp_special,
        "fallback_bend_special", &region_settings_highway_definition_handle::fallback_bend_special,
        "fallback_three_way_intersection_special",
        &region_settings_highway_definition_handle::fallback_three_way_intersection_special,
        "fallback_four_way_intersection_special",
        &region_settings_highway_definition_handle::fallback_four_way_intersection_special,
        "fallback_supports", &region_settings_highway_definition_handle::fallback_supports,
        "four_way_intersection", &region_settings_highway_definition_handle::four_way_intersection,
        "three_way_intersection", &region_settings_highway_definition_handle::three_way_intersection,
        "bend", &region_settings_highway_definition_handle::bend,
        "road_connection", &region_settings_highway_definition_handle::road_connection,
        "interchange", &region_settings_highway_definition_handle::interchange );
    ccb.new_usertype<region_settings_definition_handle>(
        "RegionSettingsDefinition", sol::no_constructor,
        "id", sol::property( &region_settings_definition_handle::id ),
        "default_oter", &region_settings_definition_handle::default_oter,
        "default_groundcover", &region_settings_definition_handle::default_groundcover,
        "groundcover", &region_settings_definition_handle::groundcover,
        "feature_blacklisted", &region_settings_definition_handle::feature_blacklisted,
        "feature_whitelisted", &region_settings_definition_handle::feature_whitelisted,
        "cities", &region_settings_definition_handle::cities,
        "forest_composition", &region_settings_definition_handle::forest_composition,
        "forest_trails", &region_settings_definition_handle::forest_trails,
        "weather", &region_settings_definition_handle::weather,
        "forests", &region_settings_definition_handle::forests,
        "rivers", &region_settings_definition_handle::rivers,
        "lakes", &region_settings_definition_handle::lakes,
        "ocean", &region_settings_definition_handle::ocean,
        "highways", &region_settings_definition_handle::highways,
        "ravines", &region_settings_definition_handle::ravines,
        "map_extras", &region_settings_definition_handle::map_extras,
        "terrain_furniture", &region_settings_definition_handle::terrain_furniture,
        "trail_connection", &region_settings_definition_handle::trail_connection,
        "sewer_connection", &region_settings_definition_handle::sewer_connection,
        "subway_connection", &region_settings_definition_handle::subway_connection,
        "rail_connection", &region_settings_definition_handle::rail_connection,
        "intra_city_road_connection",
        &region_settings_definition_handle::intra_city_road_connection,
        "inter_city_road_connection",
        &region_settings_definition_handle::inter_city_road_connection,
        "place_swamps", &region_settings_definition_handle::place_swamps,
        "place_roads", &region_settings_definition_handle::place_roads,
        "place_railroads", &region_settings_definition_handle::place_railroads,
        "place_railroads_before_roads",
        &region_settings_definition_handle::place_railroads_before_roads,
        "place_specials", &region_settings_definition_handle::place_specials,
        "neighbor_connections", &region_settings_definition_handle::neighbor_connections,
        "max_urbanity", &region_settings_definition_handle::max_urbanity,
        "urbanity_increase", &region_settings_definition_handle::urbanity_increase );
    ccb.new_usertype<option_slider_definition_handle>(
        "OptionSliderDefinition", sol::no_constructor,
        "id", sol::property( &option_slider_definition_handle::id ),
        "name", &option_slider_definition_handle::name,
        "context", &option_slider_definition_handle::context,
        "default_level", &option_slider_definition_handle::default_level,
        "levels", &option_slider_definition_handle::levels,
        "level", &option_slider_definition_handle::level );
    ccb.new_usertype<dimension_region_layout_definition_handle>(
        "DimensionRegionLayoutDefinition", sol::no_constructor,
        "id", sol::property( &dimension_region_layout_definition_handle::id ),
        "generation_mode", &dimension_region_layout_definition_handle::generation_mode,
        "uniform_region", &dimension_region_layout_definition_handle::uniform_region );
    ccb.new_usertype<dimension_definition_handle>(
        "DimensionDefinition", sol::no_constructor,
        "id", sol::property( &dimension_definition_handle::id ),
        "region_layout", &dimension_definition_handle::region_layout );
    ccb.new_usertype<omt_placeholder_definition_handle>(
        "OmtPlaceholderDefinition", sol::no_constructor,
        "id", sol::property( &omt_placeholder_definition_handle::id ),
        "grid", &omt_placeholder_definition_handle::grid );
    ccb.new_usertype<region_terrain_furniture_definition_handle>(
        "RegionTerrainFurnitureDefinition", sol::no_constructor,
        "id", sol::property( &region_terrain_furniture_definition_handle::id ),
        "ter_id", &region_terrain_furniture_definition_handle::ter_id,
        "furn_id", &region_terrain_furniture_definition_handle::furn_id,
        "replace_terrain", &region_terrain_furniture_definition_handle::replace_terrain,
        "replace_with_terrain", &region_terrain_furniture_definition_handle::replace_with_terrain,
        "replace_furniture", &region_terrain_furniture_definition_handle::replace_furniture,
        "replace_with_furniture", &region_terrain_furniture_definition_handle::replace_with_furniture );
    ccb.new_usertype<forest_biome_component_definition_handle>(
        "ForestBiomeComponentDefinition", sol::no_constructor,
        "id", sol::property( &forest_biome_component_definition_handle::id ),
        "chance", &forest_biome_component_definition_handle::chance,
        "sequence", &forest_biome_component_definition_handle::sequence,
        "type", &forest_biome_component_definition_handle::type,
        "add_type", &forest_biome_component_definition_handle::add_type );
    ccb.new_usertype<city_definition_handle>(
        "CityDefinition", sol::no_constructor,
        "id", sol::property( &city_definition_handle::id ),
        "database_id", &city_definition_handle::database_id,
        "name", &city_definition_handle::name,
        "population", &city_definition_handle::population,
        "size", &city_definition_handle::size,
        "pos_om", sol::overload(
            static_cast<city_definition_handle&( city_definition_handle::* )( std::int64_t, std::int64_t )>
            ( &city_definition_handle::pos_om ),
            &city_definition_handle::pos_om_table ),
        "pos", sol::overload(
            static_cast<city_definition_handle&( city_definition_handle::* )( std::int64_t, std::int64_t )>
            ( &city_definition_handle::pos ),
            &city_definition_handle::pos_table ) );
    ccb.new_usertype<faction_mission_definition_handle>(
        "FactionMissionDefinition", sol::no_constructor,
        "id", sol::property( &faction_mission_definition_handle::id ),
        "name", &faction_mission_definition_handle::name,
        "desc", &faction_mission_definition_handle::desc,
        "description", &faction_mission_definition_handle::description,
        "skill", &faction_mission_definition_handle::skill,
        "difficulty", &faction_mission_definition_handle::difficulty,
        "risk", &faction_mission_definition_handle::risk,
        "activity", &faction_mission_definition_handle::activity,
        "time", &faction_mission_definition_handle::time,
        "positions", &faction_mission_definition_handle::positions,
        "items_label", &faction_mission_definition_handle::items_label,
        "items_possibility", &faction_mission_definition_handle::items_possibility,
        "add_items_possibility", &faction_mission_definition_handle::add_items_possibility,
        "items_possibilities", &faction_mission_definition_handle::items_possibilities,
        "effect", &faction_mission_definition_handle::effect,
        "add_effect", &faction_mission_definition_handle::add_effect,
        "effects", &faction_mission_definition_handle::effects,
        "footer", &faction_mission_definition_handle::footer );
    ccb.new_usertype<region_settings_city_definition_handle>(
        "RegionSettingsCityDefinition", sol::no_constructor,
        "id", sol::property( &region_settings_city_definition_handle::id ),
        "is_megacity", &region_settings_city_definition_handle::is_megacity,
        "city_size", &region_settings_city_definition_handle::city_size,
        "city_spacing", &region_settings_city_definition_handle::city_spacing,
        "shop_radius", &region_settings_city_definition_handle::shop_radius,
        "shop_sigma", &region_settings_city_definition_handle::shop_sigma,
        "park_radius", &region_settings_city_definition_handle::park_radius,
        "park_sigma", &region_settings_city_definition_handle::park_sigma,
        "name_snippet", &region_settings_city_definition_handle::name_snippet,
        "house", &region_settings_city_definition_handle::house,
        "add_house", &region_settings_city_definition_handle::add_house,
        "houses", &region_settings_city_definition_handle::houses,
        "shop", &region_settings_city_definition_handle::shop,
        "add_shop", &region_settings_city_definition_handle::add_shop,
        "shops", &region_settings_city_definition_handle::shops,
        "park", &region_settings_city_definition_handle::park,
        "add_park", &region_settings_city_definition_handle::add_park,
        "parks", &region_settings_city_definition_handle::parks );
    ccb.new_usertype<forest_biome_mapgen_definition_handle>(
        "ForestBiomeMapgenDefinition", sol::no_constructor,
        "id", sol::property( &forest_biome_mapgen_definition_handle::id ),
        "sparseness_adjacency_factor", &forest_biome_mapgen_definition_handle::sparseness_adjacency_factor,
        "item_group", &forest_biome_mapgen_definition_handle::item_group,
        "item_group_chance", &forest_biome_mapgen_definition_handle::item_group_chance,
        "item_spawn_iterations", &forest_biome_mapgen_definition_handle::item_spawn_iterations,
        "terrain", &forest_biome_mapgen_definition_handle::terrain,
        "add_terrain", &forest_biome_mapgen_definition_handle::add_terrain,
        "terrains", &forest_biome_mapgen_definition_handle::terrains,
        "component", &forest_biome_mapgen_definition_handle::component,
        "add_component", &forest_biome_mapgen_definition_handle::add_component,
        "components", &forest_biome_mapgen_definition_handle::components,
        "groundcover", sol::overload(
            &forest_biome_mapgen_definition_handle::groundcover_entry,
            &forest_biome_mapgen_definition_handle::groundcover ),
        "add_groundcover", &forest_biome_mapgen_definition_handle::add_groundcover,
        "terrain_furniture", sol::overload(
            &forest_biome_mapgen_definition_handle::terrain_furniture_entry,
            &forest_biome_mapgen_definition_handle::terrain_furniture_table ),
        "add_terrain_furniture", &forest_biome_mapgen_definition_handle::add_terrain_furniture );

    impl *const transaction = pimpl_.get();

    content.set_function( "RegionSettingsRavine", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<region_settings_ravine_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->num_ravines = options.get_or<std::int64_t>( "num_ravines", 0 );
        definition->ravine_range = options.get_or<std::int64_t>( "ravine_range", 45 );
        definition->ravine_width = options.get_or<std::int64_t>( "ravine_width", 1 );
        definition->ravine_depth = options.get_or<std::int64_t>( "ravine_depth", -3 );
        return region_settings_ravine_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "RegionSettingsLake", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<region_settings_lake_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->noise_threshold_lake = options.get_or( "noise_threshold_lake", 0.25 );
        definition->lake_size_min = options.get_or<std::int64_t>( "lake_size_min", 20 );
        definition->lake_depth = options.get_or<std::int64_t>( "lake_depth", -5 );
        definition->invert_lakes = options.get_or( "invert_lakes", false );
        definition->surface = options.get_or( "surface_ter", options.get_or( "surface",
                                              std::string( "lake_surface" ) ) );
        definition->shore = options.get_or( "shore_ter", options.get_or( "shore",
                                            std::string( "lake_shore" ) ) );
        definition->interior = options.get_or( "interior_ter", options.get_or( "interior",
                                               std::string( "lake_water_cube" ) ) );
        definition->bed = options.get_or( "bed_ter", options.get_or( "bed", std::string( "lake_bed" ) ) );
        if( const sol::optional<sol::table> shore_tbl =
                options.get<sol::optional<sol::table>>( "shore_extendable_overmap_terrain" ) ) {
            const std::size_t count = require_dense_array( *shore_tbl, "shore extendable overmap terrain", 0,
                                      1024 );
            for( std::size_t i = 1; i <= count; ++i ) {
                definition->shore_extendable_overmap_terrain.push_back( ( *shore_tbl ).get<std::string>( i ) );
            }
        }
        if( const sol::optional<sol::table> aliases_tbl =
                options.get<sol::optional<sol::table>>( "shore_extendable_overmap_terrain_aliases" ) ) {
            const std::size_t count = require_dense_array( *aliases_tbl,
                                      "shore extendable overmap terrain aliases", 0, 1024 );
            for( std::size_t i = 1; i <= count; ++i ) {
                const sol::table alias_tbl = ( *aliases_tbl ).get<sol::table>( i );
                region_settings_lake_alias_data alias_entry;
                alias_entry.om_terrain = alias_tbl.get_or( "om_terrain", std::string() );
                alias_entry.alias = alias_tbl.get_or( "alias", std::string() );
                alias_entry.match_type = alias_tbl.get_or( "om_terrain_match_type", std::string( "exact" ) );
                definition->shore_extendable_overmap_terrain_aliases.push_back( std::move( alias_entry ) );
            }
        }
        return region_settings_lake_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "RegionSettingsOcean", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<region_settings_ocean_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->noise_threshold_ocean = options.get_or( "noise_threshold_ocean", 0.25 );
        definition->ocean_size_min = options.get_or<std::int64_t>( "ocean_size_min", 100 );
        definition->ocean_depth = options.get_or<std::int64_t>( "ocean_depth", -9 );
        if( const sol::optional<std::int64_t> n =
                options.get<sol::optional<std::int64_t>>( "ocean_start_north" ) ) {
            definition->ocean_start_north = *n;
        }
        if( const sol::optional<std::int64_t> e =
                options.get<sol::optional<std::int64_t>>( "ocean_start_east" ) ) {
            definition->ocean_start_east = *e;
        }
        if( const sol::optional<std::int64_t> w =
                options.get<sol::optional<std::int64_t>>( "ocean_start_west" ) ) {
            definition->ocean_start_west = *w;
        }
        if( const sol::optional<std::int64_t> s =
                options.get<sol::optional<std::int64_t>>( "ocean_start_south" ) ) {
            definition->ocean_start_south = *s;
        }
        definition->sandy_beach_width = options.get_or<std::int64_t>( "sandy_beach_width", 2 );
        return region_settings_ocean_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "RegionSettingsForest", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<region_settings_forest_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->noise_threshold_forest = options.get_or( "noise_threshold_forest", 0.25 );
        definition->noise_threshold_forest_thick = options.get_or( "noise_threshold_forest_thick", 0.3 );
        definition->noise_threshold_swamp_adjacent_water =
            options.get_or( "noise_threshold_swamp_adjacent_water", 0.3 );
        definition->noise_threshold_swamp_isolated = options.get_or( "noise_threshold_swamp_isolated",
                0.6 );
        definition->river_floodplain_buffer_distance_min =
            options.get_or<std::int64_t>( "river_floodplain_buffer_distance_min", 3 );
        definition->river_floodplain_buffer_distance_max =
            options.get_or<std::int64_t>( "river_floodplain_buffer_distance_max", 15 );
        definition->forest_threshold_limit = options.get_or( "forest_threshold_limit",
                                             options.get_or( "max_forest", 0.395 ) );
        if( const sol::optional<sol::table> inc_tbl =
                options.get<sol::optional<sol::table>>( "forest_threshold_increase" ) ) {
            const std::size_t count = require_dense_array( *inc_tbl, "forest threshold increase", 4, 4 );
            for( std::size_t i = 1; i <= count; ++i ) {
                definition->forest_threshold_increase[i - 1] = static_cast<float>( ( *inc_tbl ).get<double>( i ) );
            }
        }
        return region_settings_forest_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "RegionSettingsRiver", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<region_settings_river_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->river_scale = options.get_or<std::int64_t>( "river_scale", 1 );
        definition->river_frequency = options.get_or( "river_frequency", 1.5 );
        definition->river_branch_chance = options.get_or( "river_branch_chance", 64.0 );
        definition->river_branch_remerge_chance = options.get_or( "river_branch_remerge_chance", 4.0 );
        definition->river_branch_scale_decrease = options.get_or( "river_branch_scale_decrease", 1.0 );
        return region_settings_river_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "RegionSettingsForestMapgen", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<region_settings_forest_mapgen_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        if( const sol::optional<sol::table> biomes_tbl =
                options.get<sol::optional<sol::table>>( "biomes" ) ) {
            const std::size_t count = require_dense_array( *biomes_tbl,
                                      "region settings forest mapgen biomes", 0, 1024 );
            for( std::size_t i = 1; i <= count; ++i ) {
                const std::string val = ( *biomes_tbl ).get<std::string>( i );
                if( val.empty() ) {
                    throw std::runtime_error( "forest biome mapgen id must be non-empty" );
                }
                if( std::find( definition->biomes.begin(), definition->biomes.end(), val ) !=
                    definition->biomes.end() ) {
                    throw std::runtime_error( "duplicate biome in region settings forest mapgen: " + val );
                }
                definition->biomes.push_back( val );
            }
        }
        return region_settings_forest_mapgen_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "RegionSettingsMapExtras", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<region_settings_map_extras_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        if( const sol::optional<sol::table> extras_tbl =
                options.get<sol::optional<sol::table>>( "extras" ) ) {
            const std::size_t count = require_dense_array( *extras_tbl, "region settings map extras", 0,
                                      1024 );
            for( std::size_t i = 1; i <= count; ++i ) {
                const std::string val = ( *extras_tbl ).get<std::string>( i );
                if( val.empty() ) {
                    throw std::runtime_error( "map extra collection id must be non-empty" );
                }
                if( std::find( definition->extras.begin(), definition->extras.end(), val ) !=
                    definition->extras.end() ) {
                    throw std::runtime_error( "duplicate extra in region settings map extras: " + val );
                }
                definition->extras.push_back( val );
            }
        }
        return region_settings_map_extras_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "RegionSettingsTerrainFurniture", [transaction](
    const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<region_settings_terrain_furniture_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        if( const sol::optional<sol::table> tf_tbl =
                options.get<sol::optional<sol::table>>( "ter_furn" ) ) {
            const std::size_t count = require_dense_array( *tf_tbl, "region settings terrain furniture", 0,
                                      1024 );
            for( std::size_t i = 1; i <= count; ++i ) {
                const std::string val = ( *tf_tbl ).get<std::string>( i );
                if( val.empty() ) {
                    throw std::runtime_error( "region terrain furniture id must be non-empty" );
                }
                if( std::find( definition->ter_furn.begin(), definition->ter_furn.end(), val ) !=
                    definition->ter_furn.end() ) {
                    throw std::runtime_error(
                        "duplicate terrain furniture in region settings terrain furniture: " + val );
                }
                definition->ter_furn.push_back( val );
            }
        }
        return region_settings_terrain_furniture_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "RegionSettingsForestTrail", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<region_settings_forest_trail_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->chance = options.get_or<std::int64_t>( "chance", 1 );
        definition->border_point_chance = options.get_or<std::int64_t>( "border_point_chance", 2 );
        definition->minimum_forest_size = options.get_or<std::int64_t>( "minimum_forest_size", 50 );
        definition->random_point_min = options.get_or<std::int64_t>( "random_point_min", 4 );
        definition->random_point_max = options.get_or<std::int64_t>( "random_point_max", 50 );
        definition->random_point_size_scalar =
            options.get_or<std::int64_t>( "random_point_size_scalar", 100 );
        definition->trailhead_chance = options.get_or<std::int64_t>( "trailhead_chance", 1 );
        definition->trailhead_road_distance =
            options.get_or<std::int64_t>( "trailhead_road_distance", 6 );
        if( const sol::optional<sol::table> th_tbl =
                options.get<sol::optional<sol::table>>( "trailheads" ) ) {
            parse_weighted_table_entries( *th_tbl, "region settings forest trail trailheads",
                                          definition->trailheads );
        }
        return region_settings_forest_trail_definition_handle{
            std::move( definition ), transaction->token
        };
    } );

    content.set_function( "RegionSettingsHighway", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<region_settings_highway_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->width_of_segments = options.get_or<std::int64_t>( "width_of_segments", 2 );
        definition->straightness_chance = options.get_or( "straightness_chance", 0.6 );
        definition->reserved_terrain_id = options.get_or( "reserved_terrain_id", std::string() );
        definition->reserved_terrain_water_id =
            options.get_or( "reserved_terrain_water_id", std::string() );
        definition->segment_flat_special = options.get_or( "segment_flat_special",
                                           options.get_or( "segment_flat", std::string() ) );
        definition->segment_ramp_special = options.get_or( "segment_ramp_special",
                                           options.get_or( "segment_ramp", std::string() ) );
        definition->segment_road_bridge_special =
            options.get_or( "segment_road_bridge_special",
                            options.get_or( "segment_road_bridge", std::string() ) );
        definition->segment_bridge_special = options.get_or( "segment_bridge_special",
                                             options.get_or( "segment_bridge", std::string() ) );
        definition->segment_bridge_supports_special =
            options.get_or( "segment_bridge_supports_special",
                            options.get_or( "segment_bridge_supports", std::string() ) );
        definition->segment_overpass_special = options.get_or( "segment_overpass_special",
                                               options.get_or( "segment_overpass", std::string() ) );
        definition->clockwise_slant_special = options.get_or( "clockwise_slant_special",
                                              options.get_or( "clockwise_slant", std::string() ) );
        definition->counterclockwise_slant_special =
            options.get_or( "counterclockwise_slant_special",
                            options.get_or( "counterclockwise_slant", std::string() ) );
        definition->fallback_onramp_special = options.get_or( "fallback_onramp_special",
                                              options.get_or( "fallback_onramp", std::string() ) );
        definition->fallback_bend_special = options.get_or( "fallback_bend_special",
                                            options.get_or( "fallback_bend", std::string() ) );
        definition->fallback_three_way_intersection_special =
            options.get_or( "fallback_three_way_intersection_special",
                            options.get_or( "fallback_three_way_intersection", std::string() ) );
        definition->fallback_four_way_intersection_special =
            options.get_or( "fallback_four_way_intersection_special",
                            options.get_or( "fallback_four_way_intersection", std::string() ) );
        definition->fallback_supports = options.get_or( "fallback_supports", std::string() );

        if( const sol::optional<sol::table> fwi_tbl =
                options.get<sol::optional<sol::table>>( "four_way_intersections" ) ) {
            parse_weighted_table_entries( *fwi_tbl, "highway four_way_intersections",
                                          definition->four_way_intersections );
        }
        if( const sol::optional<sol::table> twi_tbl =
                options.get<sol::optional<sol::table>>( "three_way_intersections" ) ) {
            parse_weighted_table_entries( *twi_tbl, "highway three_way_intersections",
                                          definition->three_way_intersections );
        }
        if( const sol::optional<sol::table> bends_tbl =
                options.get<sol::optional<sol::table>>( "bends" ) ) {
            parse_weighted_table_entries( *bends_tbl, "highway bends", definition->bends );
        }
        if( const sol::optional<sol::table> rc_tbl =
                options.get<sol::optional<sol::table>>( "road_connections" ) ) {
            parse_weighted_table_entries( *rc_tbl, "highway road_connections",
                                          definition->road_connections );
        }
        if( const sol::optional<sol::table> ic_tbl =
                options.get<sol::optional<sol::table>>( "interchanges" ) ) {
            parse_weighted_table_entries( *ic_tbl, "highway interchanges", definition->interchanges );
        }
        return region_settings_highway_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "RegionSettings", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<region_settings_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->cities = options.get_or( "cities", std::string() );
        definition->forest_composition = options.get_or(
                                             "forest_composition", std::string() );
        definition->forest_trails = options.get_or( "forest_trails", std::string() );
        definition->weather = options.get_or( "weather", std::string() );
        definition->forests = options.get_or( "forests", std::string() );
        definition->rivers = options.get_or( "rivers", std::string() );
        definition->lakes = options.get_or( "lakes", std::string() );
        definition->ocean = options.get_or( "ocean", std::string() );
        definition->highways = options.get_or( "highways", std::string() );
        definition->ravines = options.get_or( "ravines", std::string() );
        definition->map_extras = options.get_or( "map_extras", std::string() );
        definition->terrain_furniture = options.get_or(
                                            "terrain_furniture", std::string() );
        definition->place_swamps = options.get_or( "place_swamps", true );
        definition->place_roads = options.get_or( "place_roads", true );
        definition->place_railroads = options.get_or( "place_railroads", false );
        definition->place_railroads_before_roads = options.get_or(
                    "place_railroads_before_roads", false );
        definition->place_specials = options.get_or( "place_specials", true );
        definition->neighbor_connections = options.get_or(
                                               "neighbor_connections", true );
        definition->max_urbanity = options.get_or( "max_urbanity", 8.0 );

        region_settings_definition_handle handle{ definition, transaction->token };
        if( const sol::optional<sol::table> default_oter =
                options.get<sol::optional<sol::table>>( "default_oter" ) ) {
            handle.default_oter( *default_oter );
        }
        if( const sol::optional<sol::table> groundcover =
                options.get<sol::optional<sol::table>>( "default_groundcover" ) ) {
            handle.default_groundcover( *groundcover );
        }
        if( const sol::optional<sol::table> increases =
                options.get<sol::optional<sol::table>>( "urbanity_increase" ) ) {
            handle.urbanity_increase( *increases );
        }
        if( const sol::optional<sol::table> features =
                options.get<sol::optional<sol::table>>( "feature_flag_settings" ) ) {
            const auto read_flags = [&features]( const char *member,
            std::vector<std::string> &destination ) {
                if( const sol::optional<sol::table> values =
                        features->get<sol::optional<sol::table>>( member ) ) {
                    const std::size_t count = require_dense_array(
                                                  *values, "region settings feature flags", 0, 1024 );
                    for( std::size_t index = 1; index <= count; ++index ) {
                        const std::string flag = values->get<std::string>( index );
                        if( flag.empty() ) {
                            throw std::runtime_error(
                                "region settings feature flags must be non-empty" );
                        }
                        if( std::find( destination.begin(), destination.end(), flag ) ==
                            destination.end() ) {
                            destination.push_back( flag );
                        }
                    }
                }
            };
            read_flags( "blacklist", definition->feature_blacklist );
            read_flags( "whitelist", definition->feature_whitelist );
        }
        if( const sol::optional<sol::table> connections =
                options.get<sol::optional<sol::table>>( "connections" ) ) {
            definition->trail_connection = connections->get_or(
                                               "trail_connection", std::string() );
            definition->sewer_connection = connections->get_or(
                                               "sewer_connection", std::string() );
            definition->subway_connection = connections->get_or(
                                                "subway_connection", std::string() );
            definition->rail_connection = connections->get_or(
                                              "rail_connection", std::string() );
            definition->intra_city_road_connection = connections->get_or(
                        "intra_city_road_connection", std::string() );
            definition->inter_city_road_connection = connections->get_or(
                        "inter_city_road_connection", std::string() );
        }
        return handle;
    } );

    content.set_function( "OptionSlider", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<detail::option_slider_native_definition>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = options.get_or( "name", std::string() );
        definition->context = options.get_or( "context", std::string() );
        definition->default_level = options.get_or<std::int64_t>( "default_level", 0 );
        option_slider_definition_handle handle{ definition, transaction->token };
        if( const sol::optional<sol::table> levels =
                options.get<sol::optional<sol::table>>( "levels" ) ) {
            handle.levels( *levels );
        }
        return handle;
    } );
    content.set_function( "DimensionRegionLayout", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition =
            std::make_shared<detail::dimension_region_layout_native_definition>();
        definition->id = options.get_or( "id", std::string() );
        definition->generation_mode = options.get_or(
                                          "generation_mode", std::string( "UNIFORM" ) );
        definition->uniform_region = options.get_or( "uniform_region", std::string() );
        return dimension_region_layout_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "Dimension", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<detail::dimension_native_definition>();
        definition->id = options.get_or( "id", std::string() );
        definition->region_layout = options.get_or( "region_layout", std::string() );
        return dimension_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "OmtPlaceholder", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<omt_placeholder_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        omt_placeholder_definition_handle handle{ definition, transaction->token };
        if( const sol::optional<sol::table> grid =
                options.get<sol::optional<sol::table>>( "grid" ) ) {
            handle.grid( *grid );
        }
        return handle;
    } );
    content.set_function( "RegionTerrainFurniture", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<region_terrain_furniture_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->ter_id = options.get_or( "ter_id", std::string() );
        definition->furn_id = options.get_or( "furn_id", std::string() );
        if( const sol::optional<sol::table> rwt_tbl =
                options.get<sol::optional<sol::table>>( "replace_with_terrain" ) ) {
            parse_weighted_table_entries( *rwt_tbl, "region terrain furniture replace_with_terrain",
                                          definition->replace_with_terrain );
        }
        if( const sol::optional<sol::table> rwf_tbl =
                options.get<sol::optional<sol::table>>( "replace_with_furniture" ) ) {
            parse_weighted_table_entries( *rwf_tbl, "region terrain furniture replace_with_furniture",
                                          definition->replace_with_furniture );
        }
        return region_terrain_furniture_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "ForestBiomeComponent", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<forest_biome_component_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->chance = options.get_or<std::int64_t>( "chance", 0 );
        definition->sequence = options.get_or<std::int64_t>( "sequence", 0 );
        if( const sol::optional<sol::table> types_tbl =
                options.get<sol::optional<sol::table>>( "types" ) ) {
            parse_weighted_table_entries( *types_tbl, "forest biome component types", definition->types );
        }
        return forest_biome_component_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "City", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<city_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        if( options["database_id"].valid() ) {
            definition->database_id = options.get<std::int64_t>( "database_id" );
            definition->database_id_set = true;
        }
        definition->name = options.get_or( "name", std::string() );
        definition->population = options.get_or<std::int64_t>( "population", 0 );
        definition->size = options.get_or<std::int64_t>( "size", -1 );
        if( const sol::optional<sol::table> pos_om_tbl =
                options.get<sol::optional<sol::table>>( "pos_om" ) ) {
            const auto [x, y] = read_exact_coordinate_table( *pos_om_tbl, "city pos_om" );
            definition->pos_om_x = x;
            definition->pos_om_y = y;
            definition->pos_om_set = true;
        }
        if( const sol::optional<sol::table> pos_tbl =
                options.get<sol::optional<sol::table>>( "pos" ) ) {
            const auto [x, y] = read_exact_coordinate_table( *pos_tbl, "city pos" );
            definition->pos_x = x;
            definition->pos_y = y;
            definition->pos_set = true;
        }
        return city_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "FactionMission", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<faction_mission_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = options.get_or( "name", std::string() );
        definition->description = options.get_or( "desc", options.get_or( "description", std::string() ) );
        definition->skill = options.get_or( "skill", std::string() );
        definition->difficulty = options.get_or( "difficulty", std::string() );
        definition->risk = options.get_or( "risk", std::string() );
        definition->activity = options.get_or( "activity", std::string() );
        definition->time = options.get_or( "time", std::string() );
        definition->positions = options.get_or<std::int64_t>( "positions", 0 );
        definition->items_label = options.get_or( "items_label", std::string() );
        if( const sol::optional<sol::table> items_tbl =
                options.get<sol::optional<sol::table>>( "items_possibilities" ) ) {
            const std::size_t count = require_dense_array( *items_tbl, "faction_mission items_possibilities", 0,
                                      1024 );
            for( std::size_t i = 1; i <= count; ++i ) {
                const sol::object elem = items_tbl->raw_get<sol::object>( i );
                if( !elem.is<std::string>() ) {
                    throw std::runtime_error( "faction_mission items_possibilities entries must be strings" );
                }
                definition->items_possibilities.push_back( elem.as<std::string>() );
            }
        }
        if( const sol::optional<sol::table> eff_tbl =
                options.get<sol::optional<sol::table>>( "effects" ) ) {
            const std::size_t count = require_dense_array( *eff_tbl, "faction_mission effects", 0, 1024 );
            for( std::size_t i = 1; i <= count; ++i ) {
                const sol::object elem = eff_tbl->raw_get<sol::object>( i );
                if( !elem.is<std::string>() ) {
                    throw std::runtime_error( "faction_mission effects entries must be strings" );
                }
                definition->effects.push_back( elem.as<std::string>() );
            }
        }
        definition->footer = options.get_or( "footer", std::string() );
        return faction_mission_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "RegionSettingsCity", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<region_settings_city_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->is_megacity = options.get_or( "is_megacity", false );
        if( options["city_size"].valid() ) {
            definition->city_size = options.get<std::int64_t>( "city_size" );
            definition->city_size_set = true;
        }
        definition->city_spacing = options.get_or<std::int64_t>( "city_spacing", 4 );
        definition->shop_radius = options.get_or<std::int64_t>( "shop_radius", 30 );
        definition->shop_sigma = options.get_or<std::int64_t>( "shop_sigma", 20 );
        definition->park_radius = options.get_or<std::int64_t>( "park_radius", 30 );
        definition->park_sigma = options.get_or<std::int64_t>( "park_sigma", 70 );
        definition->name_snippet = options.get_or( "name_snippet", std::string( "<city_name>" ) );
        if( const sol::optional<sol::table> houses_tbl =
                options.get<sol::optional<sol::table>>( "houses" ) ) {
            parse_weighted_table_entries( *houses_tbl, "region_settings_city houses", definition->houses );
        }
        if( const sol::optional<sol::table> shops_tbl =
                options.get<sol::optional<sol::table>>( "shops" ) ) {
            parse_weighted_table_entries( *shops_tbl, "region_settings_city shops", definition->shops );
        }
        if( const sol::optional<sol::table> parks_tbl =
                options.get<sol::optional<sol::table>>( "parks" ) ) {
            parse_weighted_table_entries( *parks_tbl, "region_settings_city parks", definition->parks );
        }
        return region_settings_city_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "ForestBiomeMapgen", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<forest_biome_mapgen_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->sparseness_adjacency_factor =
            options.get_or<std::int64_t>( "sparseness_adjacency_factor", 0 );
        definition->item_group = options.get_or( "item_group", std::string() );
        definition->item_group_chance = options.get_or<std::int64_t>( "item_group_chance", 0 );
        definition->item_spawn_iterations = options.get_or<std::int64_t>( "item_spawn_iterations", 0 );
        forest_biome_mapgen_definition_handle handle{ definition, transaction->token };
        if( const sol::optional<sol::table> ter_tbl =
                options.get<sol::optional<sol::table>>( "terrains" ) ) {
            handle.terrains( *ter_tbl );
        }
        if( const sol::optional<sol::table> comp_tbl =
                options.get<sol::optional<sol::table>>( "components" ) ) {
            handle.components( *comp_tbl );
        }
        if( const sol::optional<sol::table> gc_tbl =
                options.get<sol::optional<sol::table>>( "groundcover" ) ) {
            handle.groundcover( *gc_tbl );
        }
        if( const sol::optional<sol::table> tf_tbl =
                options.get<sol::optional<sol::table>>( "terrain_furniture" ) ) {
            handle.terrain_furniture_table( *tf_tbl );
        }
        return handle;
    } );

    auto edit_catalog = [transaction]( const std::string & id, auto & registrations,
    const char *kind ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        const auto found = std::find_if(
                               registrations.rbegin(), registrations.rend(),
        [&id]( const auto & entry ) {
            return entry.definition->id == id;
        } );
        if( found == registrations.rend() ) {
            throw std::runtime_error( std::string( "edit_" ) + kind +
                                      " requires a definition staged earlier by this Mod" );
        }
        auto definition = std::make_shared < std::decay_t < decltype( *found->definition ) >> (
                              *found->definition );
        definition->registered = false;
        return definition;
    };

    content.set_function( "edit_region_settings_ravine", [transaction, edit_catalog](
    const std::string & id ) {
        return region_settings_ravine_definition_handle{
            edit_catalog( id, transaction->region_settings_ravines, "region_settings_ravine" ),
            transaction->token
        };
    } );
    content.set_function( "edit_region_settings_lake", [transaction, edit_catalog](
    const std::string & id ) {
        return region_settings_lake_definition_handle{
            edit_catalog( id, transaction->region_settings_lakes, "region_settings_lake" ),
            transaction->token
        };
    } );
    content.set_function( "edit_region_settings_ocean", [transaction, edit_catalog](
    const std::string & id ) {
        return region_settings_ocean_definition_handle{
            edit_catalog( id, transaction->region_settings_oceans, "region_settings_ocean" ),
            transaction->token
        };
    } );
    content.set_function( "edit_region_settings_forest", [transaction, edit_catalog](
    const std::string & id ) {
        return region_settings_forest_definition_handle{
            edit_catalog( id, transaction->region_settings_forests, "region_settings_forest" ),
            transaction->token
        };
    } );
    content.set_function( "edit_region_settings_river", [transaction, edit_catalog](
    const std::string & id ) {
        return region_settings_river_definition_handle{
            edit_catalog( id, transaction->region_settings_rivers, "region_settings_river" ),
            transaction->token
        };
    } );
    content.set_function( "edit_region_settings_forest_mapgen", [transaction, edit_catalog](
    const std::string & id ) {
        return region_settings_forest_mapgen_definition_handle{
            edit_catalog( id, transaction->region_settings_forest_mapgens,
                          "region_settings_forest_mapgen" ),
            transaction->token
        };
    } );
    content.set_function( "edit_region_settings_map_extras", [transaction, edit_catalog](
    const std::string & id ) {
        return region_settings_map_extras_definition_handle{
            edit_catalog( id, transaction->region_settings_map_extrases,
                          "region_settings_map_extras" ),
            transaction->token
        };
    } );
    content.set_function( "edit_region_settings_terrain_furniture", [transaction, edit_catalog](
    const std::string & id ) {
        return region_settings_terrain_furniture_definition_handle{
            edit_catalog( id, transaction->region_settings_terrain_furnitures,
                          "region_settings_terrain_furniture" ),
            transaction->token
        };
    } );
    content.set_function( "edit_region_settings_forest_trail", [transaction, edit_catalog](
    const std::string & id ) {
        return region_settings_forest_trail_definition_handle{
            edit_catalog( id, transaction->region_settings_forest_trails,
                          "region_settings_forest_trail" ),
            transaction->token
        };
    } );
    content.set_function( "edit_region_settings_highway", [transaction, edit_catalog](
    const std::string & id ) {
        return region_settings_highway_definition_handle{
            edit_catalog( id, transaction->region_settings_highways,
                          "region_settings_highway" ),
            transaction->token
        };
    } );
    content.set_function( "edit_region_settings", [transaction, edit_catalog](
    const std::string & id ) {
        return region_settings_definition_handle{
            edit_catalog( id, transaction->region_settings, "region_settings" ),
            transaction->token
        };
    } );
    content.set_function( "edit_option_slider", [transaction, edit_catalog](
    const std::string & id ) {
        return option_slider_definition_handle{
            edit_catalog( id, transaction->option_sliders, "option_slider" ),
            transaction->token
        };
    } );
    content.set_function( "edit_dimension_region_layout", [transaction, edit_catalog](
    const std::string & id ) {
        return dimension_region_layout_definition_handle{
            edit_catalog( id, transaction->dimension_region_layouts,
                          "dimension_region_layout" ),
            transaction->token
        };
    } );
    content.set_function( "edit_dimension", [transaction, edit_catalog](
    const std::string & id ) {
        return dimension_definition_handle{
            edit_catalog( id, transaction->dimensions, "dimension" ),
            transaction->token
        };
    } );
    content.set_function( "edit_omt_placeholder", [transaction, edit_catalog](
    const std::string & id ) {
        return omt_placeholder_definition_handle{
            edit_catalog( id, transaction->omt_placeholders, "omt_placeholder" ),
            transaction->token
        };
    } );
    content.set_function( "edit_region_terrain_furniture", [transaction, edit_catalog](
    const std::string & id ) {
        return region_terrain_furniture_definition_handle{
            edit_catalog( id, transaction->region_terrain_furnitures,
                          "region_terrain_furniture" ),
            transaction->token
        };
    } );
    content.set_function( "edit_forest_biome_component", [transaction, edit_catalog](
    const std::string & id ) {
        return forest_biome_component_definition_handle{
            edit_catalog( id, transaction->forest_biome_components,
                          "forest_biome_component" ),
            transaction->token
        };
    } );
    content.set_function( "edit_city", [transaction, edit_catalog]( const std::string & id ) {
        return city_definition_handle{
            edit_catalog( id, transaction->cities, "city" ),
            transaction->token
        };
    } );
    content.set_function( "edit_faction_mission", [transaction, edit_catalog](
    const std::string & id ) {
        return faction_mission_definition_handle{
            edit_catalog( id, transaction->faction_missions, "faction_mission" ),
            transaction->token
        };
    } );
    content.set_function( "edit_region_settings_city", [transaction, edit_catalog](
    const std::string & id ) {
        return region_settings_city_definition_handle{
            edit_catalog( id, transaction->region_settings_cities, "region_settings_city" ),
            transaction->token
        };
    } );
    content.set_function( "edit_forest_biome_mapgen", [transaction, edit_catalog](
    const std::string & id ) {
        return forest_biome_mapgen_definition_handle{
            edit_catalog( id, transaction->forest_biome_mapgens, "forest_biome_mapgen" ),
            transaction->token
        };
    } );

    static_cast<void>( lua );
}

bool worldgen_content_transaction::register_definition( const sol::object &value,
        const int raw_operation )
{
    if( raw_operation < 0 || raw_operation > 2 ) {
        throw std::runtime_error( "invalid Platform content operation" );
    }
    const definition_operation operation = static_cast<definition_operation>( raw_operation );
    const auto register_value = [this, operation]( auto handle, auto & entries,
    const char *kind ) {
        if( handle.token != pimpl_->token ) {
            throw std::runtime_error( std::string( "cannot register a " ) + kind +
                                      " definition owned by another Mod" );
        }
        require_building_handle( handle.token, *handle.definition, kind );
        handle.definition->registered = true;
        if( operation == definition_operation::edit ) {
            const auto target = std::find_if( entries.rbegin(), entries.rend(),
            [&handle]( const auto & entry ) {
                return entry.definition->id == handle.definition->id;
            } );
            if( target == entries.rend() ) {
                handle.definition->registered = false;
                throw std::runtime_error( std::string( "edit requires a " ) + kind +
                                          " staged earlier by this Mod" );
            }
            target->definition = handle.definition;
            return;
        }
        entries.push_back( { operation, handle.definition } );
    };

    if( value.is<region_settings_ravine_definition_handle>() ) {
        register_value( value.as<region_settings_ravine_definition_handle>(),
                        pimpl_->region_settings_ravines, "region settings ravine" );
        return true;
    }
    if( value.is<region_settings_lake_definition_handle>() ) {
        register_value( value.as<region_settings_lake_definition_handle>(),
                        pimpl_->region_settings_lakes, "region settings lake" );
        return true;
    }
    if( value.is<region_settings_ocean_definition_handle>() ) {
        register_value( value.as<region_settings_ocean_definition_handle>(),
                        pimpl_->region_settings_oceans, "region settings ocean" );
        return true;
    }
    if( value.is<region_settings_forest_definition_handle>() ) {
        register_value( value.as<region_settings_forest_definition_handle>(),
                        pimpl_->region_settings_forests, "region settings forest" );
        return true;
    }
    if( value.is<region_settings_river_definition_handle>() ) {
        register_value( value.as<region_settings_river_definition_handle>(),
                        pimpl_->region_settings_rivers, "region settings river" );
        return true;
    }
    if( value.is<region_settings_forest_mapgen_definition_handle>() ) {
        register_value( value.as<region_settings_forest_mapgen_definition_handle>(),
                        pimpl_->region_settings_forest_mapgens, "region settings forest mapgen" );
        return true;
    }
    if( value.is<region_settings_map_extras_definition_handle>() ) {
        register_value( value.as<region_settings_map_extras_definition_handle>(),
                        pimpl_->region_settings_map_extrases, "region settings map extras" );
        return true;
    }
    if( value.is<region_settings_terrain_furniture_definition_handle>() ) {
        register_value( value.as<region_settings_terrain_furniture_definition_handle>(),
                        pimpl_->region_settings_terrain_furnitures,
                        "region settings terrain furniture" );
        return true;
    }
    if( value.is<region_settings_forest_trail_definition_handle>() ) {
        register_value( value.as<region_settings_forest_trail_definition_handle>(),
                        pimpl_->region_settings_forest_trails,
                        "region settings forest trail" );
        return true;
    }
    if( value.is<region_settings_highway_definition_handle>() ) {
        register_value( value.as<region_settings_highway_definition_handle>(),
                        pimpl_->region_settings_highways, "region settings highway" );
        return true;
    }
    if( value.is<region_settings_definition_handle>() ) {
        register_value( value.as<region_settings_definition_handle>(),
                        pimpl_->region_settings, "region settings" );
        return true;
    }
    if( value.is<option_slider_definition_handle>() ) {
        register_value( value.as<option_slider_definition_handle>(),
                        pimpl_->option_sliders, "option slider" );
        return true;
    }
    if( value.is<dimension_region_layout_definition_handle>() ) {
        register_value( value.as<dimension_region_layout_definition_handle>(),
                        pimpl_->dimension_region_layouts, "dimension region layout" );
        return true;
    }
    if( value.is<dimension_definition_handle>() ) {
        register_value( value.as<dimension_definition_handle>(),
                        pimpl_->dimensions, "dimension" );
        return true;
    }
    if( value.is<omt_placeholder_definition_handle>() ) {
        register_value( value.as<omt_placeholder_definition_handle>(),
                        pimpl_->omt_placeholders, "overmap terrain placeholder" );
        return true;
    }
    if( value.is<region_terrain_furniture_definition_handle>() ) {
        register_value( value.as<region_terrain_furniture_definition_handle>(),
                        pimpl_->region_terrain_furnitures, "region terrain furniture" );
        return true;
    }
    if( value.is<forest_biome_component_definition_handle>() ) {
        register_value( value.as<forest_biome_component_definition_handle>(),
                        pimpl_->forest_biome_components, "forest biome component" );
        return true;
    }
    if( value.is<city_definition_handle>() ) {
        register_value( value.as<city_definition_handle>(), pimpl_->cities, "city" );
        return true;
    }
    if( value.is<faction_mission_definition_handle>() ) {
        register_value( value.as<faction_mission_definition_handle>(),
                        pimpl_->faction_missions, "faction mission" );
        return true;
    }
    if( value.is<region_settings_city_definition_handle>() ) {
        register_value( value.as<region_settings_city_definition_handle>(),
                        pimpl_->region_settings_cities, "region settings city" );
        return true;
    }
    if( value.is<forest_biome_mapgen_definition_handle>() ) {
        register_value( value.as<forest_biome_mapgen_definition_handle>(),
                        pimpl_->forest_biome_mapgens, "forest biome mapgen" );
        return true;
    }
    return false;
}

bool worldgen_content_transaction::validate( const worldgen_validation_index &index,
        const bool check_engine_state, std::string &error ) const
{
    try {
        const auto require_valid_id = []( const std::string & id, const char *kind ) {
            if( id.empty() || id.find( '#' ) != std::string::npos ||
                id.find( '\0' ) != std::string::npos || id.size() > 256 ) {
                throw std::runtime_error( std::string( "invalid " ) + kind + " id '" + id + "'" );
            }
        };
        const auto validate_operation = [check_engine_state]( const definition_operation operation,
        const bool exists, const std::string & id, const char *kind ) {
            if( !check_engine_state ) {
                return;
            }
            if( operation == definition_operation::add && exists ) {
                throw std::runtime_error( std::string( "add would overwrite existing " ) +
                                          kind + " '" + id + "'; use replace explicitly" );
            }
            if( operation == definition_operation::replace && !exists ) {
                throw std::runtime_error( std::string( "replace requires existing " ) +
                                          kind + " '" + id + "'" );
            }
        };
        const auto native_int = []( const std::int64_t value ) {
            return value >= std::numeric_limits<int>::min() &&
                   value <= std::numeric_limits<int>::max();
        };

        std::set<std::string> region_settings_ravine_ids;
        for( const region_settings_ravine_registration &entry : pimpl_->region_settings_ravines ) {
            const region_settings_ravine_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "region settings ravine" );
            if( !region_settings_ravine_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "region settings ravine '" + definition.id +
                                          "' is registered more than once per transaction" );
            }
            if( !native_int( definition.num_ravines ) ||
                !native_int( definition.ravine_range ) ||
                !native_int( definition.ravine_width ) ||
                !native_int( definition.ravine_depth ) ) {
                throw std::runtime_error( "region settings ravine '" + definition.id +
                                          "' has a value outside the native integer range" );
            }
            validate_operation( entry.operation,
                                region_settings_ravine_id( definition.id ).is_valid(),
                                definition.id, "region settings ravine" );
        }

        std::set<std::string> region_settings_lake_ids;
        for( const region_settings_lake_registration &entry : pimpl_->region_settings_lakes ) {
            const region_settings_lake_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "region settings lake" );
            if( !region_settings_lake_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "region settings lake '" + definition.id +
                                          "' is registered more than once per transaction" );
            }
            if( !std::isfinite( definition.noise_threshold_lake ) ||
                !native_int( definition.lake_size_min ) ||
                !native_int( definition.lake_depth ) ||
                definition.surface.empty() || definition.shore.empty() ||
                definition.interior.empty() || definition.bed.empty() ) {
                throw std::runtime_error(
                    "region settings lake '" + definition.id +
                    "' has invalid thresholds, native integers, or terrain definitions" );
            }
            if( definition.shore_extendable_overmap_terrain.size() > 1024 ||
                definition.shore_extendable_overmap_terrain_aliases.size() > 1024 ) {
                throw std::runtime_error( "region settings lake '" + definition.id +
                                          "' exceeds the Platform shore-entry limit" );
            }
            for( const std::string &terrain : definition.shore_extendable_overmap_terrain ) {
                if( terrain.empty() ) {
                    throw std::runtime_error( "region settings lake '" + definition.id +
                                              "' has an empty shore-extendable terrain" );
                }
            }
            for( const region_settings_lake_alias_data &alias :
                 definition.shore_extendable_overmap_terrain_aliases ) {
                if( alias.om_terrain.empty() || alias.alias.empty() ||
                    !platform_ot_match_type( alias.match_type ).has_value() ) {
                    throw std::runtime_error( "region settings lake '" + definition.id +
                                              "' has an invalid shore terrain alias" );
                }
            }
            validate_operation( entry.operation,
                                region_settings_lake_id( definition.id ).is_valid(),
                                definition.id, "region settings lake" );
        }

        std::set<std::string> region_settings_ocean_ids;
        for( const region_settings_ocean_registration &entry : pimpl_->region_settings_oceans ) {
            const region_settings_ocean_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "region settings ocean" );
            if( !region_settings_ocean_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "region settings ocean '" + definition.id +
                                          "' is registered more than once per transaction" );
            }
            const auto valid_optional_int = [&native_int](
            const std::optional<std::int64_t> &value ) {
                return !value || native_int( *value );
            };
            if( !std::isfinite( definition.noise_threshold_ocean ) ||
                !native_int( definition.ocean_size_min ) ||
                !native_int( definition.ocean_depth ) ||
                !valid_optional_int( definition.ocean_start_north ) ||
                !valid_optional_int( definition.ocean_start_east ) ||
                !valid_optional_int( definition.ocean_start_west ) ||
                !valid_optional_int( definition.ocean_start_south ) ||
                !native_int( definition.sandy_beach_width ) ) {
                throw std::runtime_error( "region settings ocean '" + definition.id +
                                          "' has an invalid threshold or native integer" );
            }
            validate_operation( entry.operation,
                                region_settings_ocean_id( definition.id ).is_valid(),
                                definition.id, "region settings ocean" );
        }

        std::set<std::string> region_settings_forest_ids;
        for( const region_settings_forest_registration &entry : pimpl_->region_settings_forests ) {
            const region_settings_forest_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "region settings forest" );
            if( !region_settings_forest_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "region settings forest '" + definition.id +
                                          "' is registered more than once per transaction" );
            }
            const auto native_float = []( const double value ) {
                return std::isfinite( value ) &&
                       value >= std::numeric_limits<float>::lowest() &&
                       value <= std::numeric_limits<float>::max();
            };
            if( !std::isfinite( definition.noise_threshold_forest ) ||
                !std::isfinite( definition.noise_threshold_forest_thick ) ||
                !std::isfinite( definition.noise_threshold_swamp_adjacent_water ) ||
                !std::isfinite( definition.noise_threshold_swamp_isolated ) ||
                !native_int( definition.river_floodplain_buffer_distance_min ) ||
                !native_int( definition.river_floodplain_buffer_distance_max ) ||
                !native_float( definition.forest_threshold_limit ) ) {
                throw std::runtime_error(
                    "region settings forest '" + definition.id +
                    "' has non-finite thresholds or values outside native ranges" );
            }
            for( const float inc : definition.forest_threshold_increase ) {
                if( !std::isfinite( inc ) ) {
                    throw std::runtime_error( "region settings forest '" + definition.id +
                                              "' has non-finite threshold increase values" );
                }
            }
            validate_operation( entry.operation,
                                region_settings_forest_id( definition.id ).is_valid(),
                                definition.id, "region settings forest" );
        }

        std::set<std::string> region_settings_river_ids;
        for( const region_settings_river_registration &entry : pimpl_->region_settings_rivers ) {
            const region_settings_river_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "region settings river" );
            if( !region_settings_river_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "region settings river '" + definition.id +
                                          "' is registered more than once per transaction" );
            }
            if( !native_int( definition.river_scale ) ||
                !std::isfinite( definition.river_frequency ) ||
                !std::isfinite( definition.river_branch_chance ) ||
                !std::isfinite( definition.river_branch_remerge_chance ) ||
                !std::isfinite( definition.river_branch_scale_decrease ) ) {
                throw std::runtime_error(
                    "region settings river '" + definition.id +
                    "' has non-finite properties or a value outside the native integer range" );
            }
            validate_operation( entry.operation,
                                region_settings_river_id( definition.id ).is_valid(),
                                definition.id, "region settings river" );
        }

        std::set<std::string> region_settings_forest_mapgen_ids;
        for( const region_settings_forest_mapgen_registration &entry :
             pimpl_->region_settings_forest_mapgens ) {
            const region_settings_forest_mapgen_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "region settings forest mapgen" );
            if( !region_settings_forest_mapgen_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "region settings forest mapgen '" + definition.id +
                                          "' is registered more than once per transaction" );
            }
            if( definition.biomes.size() > 1024 ) {
                throw std::runtime_error( "region settings forest mapgen '" + definition.id +
                                          "' exceeds the Platform biomes limit" );
            }
            std::set<std::string> seen_biomes;
            for( const std::string &biome_id : definition.biomes ) {
                require_valid_id( biome_id, "forest biome mapgen reference" );
                if( !seen_biomes.insert( biome_id ).second ) {
                    throw std::runtime_error( "region settings forest mapgen '" + definition.id +
                                              "' contains duplicate biome id: " + biome_id );
                }
                if( check_engine_state && !forest_biome_mapgen_id( biome_id ).is_valid() ) {
                    throw std::runtime_error( "region settings forest mapgen '" + definition.id +
                                              "' references unknown forest biome mapgen: " + biome_id );
                }
            }
            validate_operation( entry.operation,
                                region_settings_forest_mapgen_id( definition.id ).is_valid(),
                                definition.id, "region settings forest mapgen" );
        }

        std::set<std::string> region_settings_map_extras_ids;
        for( const region_settings_map_extras_registration &entry : pimpl_->region_settings_map_extrases ) {
            const region_settings_map_extras_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "region settings map extras" );
            if( !region_settings_map_extras_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "region settings map extras '" + definition.id +
                                          "' is registered more than once per transaction" );
            }
            if( definition.extras.size() > 1024 ) {
                throw std::runtime_error( "region settings map extras '" + definition.id +
                                          "' exceeds the Platform extras limit" );
            }
            std::set<std::string> seen_extras;
            for( const std::string &extra_id : definition.extras ) {
                require_valid_id( extra_id, "map extra collection reference" );
                if( !seen_extras.insert( extra_id ).second ) {
                    throw std::runtime_error( "region settings map extras '" + definition.id +
                                              "' contains duplicate extra collection id: " + extra_id );
                }
                if( check_engine_state && index.map_extra_collection_ids.count( extra_id ) == 0 &&
                    !map_extra_collection_id( extra_id ).is_valid() ) {
                    throw std::runtime_error( "region settings map extras '" + definition.id +
                                              "' references unknown map extra collection: " + extra_id );
                }
            }
            validate_operation( entry.operation,
                                region_settings_map_extras_id( definition.id ).is_valid(),
                                definition.id, "region settings map extras" );
        }

        std::set<std::string> region_terrain_furniture_ids;
        for( const region_terrain_furniture_registration &entry :
             pimpl_->region_terrain_furnitures ) {
            const std::string &id = entry.definition->id;
            require_valid_id( id, "region terrain furniture" );
            if( !region_terrain_furniture_ids.insert( id ).second ) {
                throw std::runtime_error( "region terrain furniture '" + id +
                                          "' is registered more than once per transaction" );
            }
        }

        std::set<std::string> region_settings_terrain_furniture_ids;
        for( const region_settings_terrain_furniture_registration &entry :
             pimpl_->region_settings_terrain_furnitures ) {
            const region_settings_terrain_furniture_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "region settings terrain furniture" );
            if( !region_settings_terrain_furniture_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "region settings terrain furniture '" + definition.id +
                                          "' is registered more than once per transaction" );
            }
            if( definition.ter_furn.size() > 1024 ) {
                throw std::runtime_error( "region settings terrain furniture '" + definition.id +
                                          "' exceeds the Platform terrain-furniture limit" );
            }
            std::set<std::string> seen_ter_furn;
            for( const std::string &tf_id : definition.ter_furn ) {
                require_valid_id( tf_id, "region terrain furniture reference" );
                if( !seen_ter_furn.insert( tf_id ).second ) {
                    throw std::runtime_error( "region settings terrain furniture '" + definition.id +
                                              "' contains duplicate region terrain furniture id: " + tf_id );
                }
                if( check_engine_state && region_terrain_furniture_ids.count( tf_id ) == 0 &&
                    !region_terrain_furniture_id( tf_id ).is_valid() ) {
                    throw std::runtime_error( "region settings terrain furniture '" + definition.id +
                                              "' references unknown region terrain furniture: " + tf_id );
                }
            }
            validate_operation( entry.operation,
                                region_settings_terrain_furniture_id( definition.id ).is_valid(),
                                definition.id, "region settings terrain furniture" );
        }

        std::set<std::string> region_settings_forest_trail_ids;
        for( const region_settings_forest_trail_registration &entry :
             pimpl_->region_settings_forest_trails ) {
            const region_settings_forest_trail_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "region settings forest trail" );
            if( !region_settings_forest_trail_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "region settings forest trail '" + definition.id +
                                          "' is registered more than once per transaction" );
            }
            if( !native_int( definition.chance ) ||
                !native_int( definition.border_point_chance ) ||
                !native_int( definition.minimum_forest_size ) ||
                !native_int( definition.random_point_min ) ||
                !native_int( definition.random_point_max ) ||
                !native_int( definition.random_point_size_scalar ) ||
                !native_int( definition.trailhead_chance ) ||
                !native_int( definition.trailhead_road_distance ) ) {
                throw std::runtime_error( "region settings forest trail '" + definition.id +
                                          "' has values outside the native integer range" );
            }
            if( definition.trailheads.size() > 1024 ) {
                throw std::runtime_error( "region settings forest trail '" + definition.id +
                                          "' exceeds the Platform trailhead limit" );
            }
            for( const auto &[special, weight] : definition.trailheads ) {
                require_valid_id( special, "trailhead special" );
                if( !native_int( weight ) || weight <= 0 ) {
                    throw std::runtime_error( "region settings forest trail '" + definition.id +
                                              "' has invalid weight for trailhead: " + special );
                }
                if( check_engine_state && !overmap_special_id( special ).is_valid() &&
                    !oter_type_str_id( special ).is_valid() ) {
                    throw std::runtime_error( "region settings forest trail '" + definition.id +
                                              "' references unknown overmap special or terrain type: " +
                                              special );
                }
            }
            validate_operation( entry.operation,
                                region_settings_forest_trail_id( definition.id ).is_valid(),
                                definition.id, "region settings forest trail" );
        }

        std::set<std::string> region_settings_highway_ids;
        for( const region_settings_highway_registration &entry :
             pimpl_->region_settings_highways ) {
            const region_settings_highway_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "region settings highway" );
            if( !region_settings_highway_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "region settings highway '" + definition.id +
                                          "' is registered more than once per transaction" );
            }
            if( !native_int( definition.width_of_segments ) ||
                !std::isfinite( definition.straightness_chance ) ) {
                throw std::runtime_error( "region settings highway '" + definition.id +
                                          "' has non-finite properties or integer out of range" );
            }
            if( definition.clockwise_slant_special.empty() ||
                definition.counterclockwise_slant_special.empty() ) {
                throw std::runtime_error( "region settings highway '" + definition.id +
                                          "' requires clockwise and counterclockwise slant specials" );
            }
            const auto check_oter_type = [&]( const std::string & oter, const char *label ) {
                if( !oter.empty() ) {
                    require_valid_id( oter, label );
                    if( check_engine_state && !oter_type_str_id( oter ).is_valid() ) {
                        throw std::runtime_error( "region settings highway '" + definition.id +
                                                  "' references unknown " + label + ": " + oter );
                    }
                }
            };
            const auto check_special = [&]( const std::string & spec, const char *label ) {
                if( !spec.empty() ) {
                    require_valid_id( spec, label );
                    if( check_engine_state && !overmap_special_id( spec ).is_valid() ) {
                        throw std::runtime_error( "region settings highway '" + definition.id +
                                                  "' references unknown " + label + ": " + spec );
                    }
                }
            };
            check_oter_type( definition.reserved_terrain_id, "reserved terrain id" );
            check_oter_type( definition.reserved_terrain_water_id, "reserved terrain water id" );
            check_oter_type( definition.fallback_supports, "fallback supports" );

            check_special( definition.segment_flat_special, "segment_flat" );
            check_special( definition.segment_ramp_special, "segment_ramp" );
            check_special( definition.segment_road_bridge_special, "segment_road_bridge" );
            check_special( definition.segment_bridge_special, "segment_bridge" );
            check_special( definition.segment_bridge_supports_special, "segment_bridge_supports" );
            check_special( definition.segment_overpass_special, "segment_overpass" );
            check_special( definition.clockwise_slant_special, "clockwise_slant" );
            check_special( definition.counterclockwise_slant_special, "counterclockwise_slant" );
            check_special( definition.fallback_onramp_special, "fallback_onramp" );
            check_special( definition.fallback_bend_special, "fallback_bend" );
            check_special( definition.fallback_three_way_intersection_special,
                           "fallback_three_way_intersection" );
            check_special( definition.fallback_four_way_intersection_special,
                           "fallback_four_way_intersection" );

            const auto check_building_bin = [&](
                                                const std::vector<std::pair<std::string, std::int64_t>> &bin,
            const char *label ) {
                if( bin.size() > 1024 ) {
                    throw std::runtime_error( "region settings highway '" + definition.id +
                                              "' exceeds the Platform limit for " + label );
                }
                for( const auto &[special, weight] : bin ) {
                    require_valid_id( special, label );
                    if( !native_int( weight ) || weight <= 0 ) {
                        throw std::runtime_error( "region settings highway '" + definition.id +
                                                  "' has invalid weight for " + label + ": " + special );
                    }
                    if( check_engine_state && !overmap_special_id( special ).is_valid() &&
                        !oter_type_str_id( special ).is_valid() ) {
                        throw std::runtime_error( "region settings highway '" + definition.id +
                                                  "' references unknown overmap special or terrain type: " +
                                                  special );
                    }
                }
            };
            check_building_bin( definition.four_way_intersections, "four_way_intersection" );
            check_building_bin( definition.three_way_intersections, "three_way_intersection" );
            check_building_bin( definition.bends, "bend" );
            check_building_bin( definition.road_connections, "road_connection" );
            check_building_bin( definition.interchanges, "interchange" );

            validate_operation( entry.operation,
                                region_settings_highway_id( definition.id ).is_valid(),
                                definition.id, "region settings highway" );
        }

        for( const region_terrain_furniture_registration &entry :
             pimpl_->region_terrain_furnitures ) {
            const region_terrain_furniture_definition_data &definition = *entry.definition;
            if( !definition.ter_id.empty() ) {
                require_valid_id( definition.ter_id, "replaced terrain id" );
                if( check_engine_state && index.terrain_ids.count( definition.ter_id ) == 0 &&
                    !ter_str_id( definition.ter_id ).is_valid() ) {
                    throw std::runtime_error( "region terrain furniture '" + definition.id +
                                              "' references unknown terrain: " + definition.ter_id );
                }
            }
            if( !definition.furn_id.empty() ) {
                require_valid_id( definition.furn_id, "replaced furniture id" );
                if( check_engine_state && index.furniture_ids.count( definition.furn_id ) == 0 &&
                    !furn_str_id( definition.furn_id ).is_valid() ) {
                    throw std::runtime_error( "region terrain furniture '" + definition.id +
                                              "' references unknown furniture: " + definition.furn_id );
                }
            }
            if( definition.replace_with_terrain.size() > 1024 ||
                definition.replace_with_furniture.size() > 1024 ) {
                throw std::runtime_error( "region terrain furniture '" + definition.id +
                                          "' exceeds the Platform replacement limit" );
            }
            for( const auto &[terrain, weight] : definition.replace_with_terrain ) {
                require_valid_id( terrain, "replace terrain id" );
                if( !native_int( weight ) || weight <= 0 ) {
                    throw std::runtime_error( "region terrain furniture '" + definition.id +
                                              "' has invalid weight for terrain: " + terrain );
                }
                if( check_engine_state && index.terrain_ids.count( terrain ) == 0 &&
                    !ter_str_id( terrain ).is_valid() ) {
                    throw std::runtime_error( "region terrain furniture '" + definition.id +
                                              "' references unknown terrain: " + terrain );
                }
            }
            for( const auto &[furniture, weight] : definition.replace_with_furniture ) {
                require_valid_id( furniture, "replace furniture id" );
                if( !native_int( weight ) || weight <= 0 ) {
                    throw std::runtime_error( "region terrain furniture '" + definition.id +
                                              "' has invalid weight for furniture: " + furniture );
                }
                if( check_engine_state && index.furniture_ids.count( furniture ) == 0 &&
                    !furn_str_id( furniture ).is_valid() ) {
                    throw std::runtime_error( "region terrain furniture '" + definition.id +
                                              "' references unknown furniture: " + furniture );
                }
            }
            validate_operation( entry.operation,
                                region_terrain_furniture_id( definition.id ).is_valid(),
                                definition.id, "region terrain furniture" );
        }

        std::set<std::string> forest_biome_component_ids;
        for( const forest_biome_component_registration &entry :
             pimpl_->forest_biome_components ) {
            const forest_biome_component_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "forest biome component" );
            if( !forest_biome_component_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "forest biome component '" + definition.id +
                                          "' is registered more than once per transaction" );
            }
            if( !native_int( definition.chance ) || !native_int( definition.sequence ) ) {
                throw std::runtime_error( "forest biome component '" + definition.id +
                                          "' has integer values outside the native range" );
            }
            if( definition.types.size() > 1024 ) {
                throw std::runtime_error( "forest biome component '" + definition.id +
                                          "' exceeds the Platform type limit" );
            }
            for( const auto &[type, weight] : definition.types ) {
                require_valid_id( type, "forest biome component type" );
                if( !native_int( weight ) || weight <= 0 ) {
                    throw std::runtime_error( "forest biome component '" + definition.id +
                                              "' has invalid weight for type: " + type );
                }
                if( check_engine_state ) {
                    const bool valid_type = ter_str_id( type ).is_valid() ||
                                            furn_str_id( type ).is_valid() ||
                                            region_terrain_furniture_id( type ).is_valid() ||
                                            index.terrain_ids.count( type ) > 0 ||
                                            index.furniture_ids.count( type ) > 0 ||
                                            region_terrain_furniture_ids.count( type ) > 0;
                    if( !valid_type ) {
                        throw std::runtime_error( "forest biome component '" + definition.id +
                                                  "' references unknown type: " + type );
                    }
                }
            }
            validate_operation( entry.operation,
                                forest_biome_component_id( definition.id ).is_valid(),
                                definition.id, "forest biome component" );
        }

        std::set<std::string> city_ids;
        for( const city_registration &entry : pimpl_->cities ) {
            const city_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "city" );
            if( !city_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "city '" + definition.id +
                                          "' is registered more than once per transaction" );
            }
            if( !definition.database_id_set || !definition.pos_om_set ||
                !definition.pos_set ) {
                throw std::runtime_error( "city '" + definition.id +
                                          "' requires database_id, pos_om, and pos" );
            }
            if( !native_int( definition.database_id ) ||
                !native_int( definition.population ) ||
                !native_int( definition.size ) ||
                !native_int( definition.pos_om_x ) ||
                !native_int( definition.pos_om_y ) ||
                !native_int( definition.pos_x ) ||
                !native_int( definition.pos_y ) ) {
                throw std::runtime_error( "city '" + definition.id +
                                          "' has integer values outside the native range" );
            }
            if( definition.population < 0 ) {
                throw std::runtime_error( "city '" + definition.id +
                                          "' population must be non-negative" );
            }
            if( definition.size < -1 ) {
                throw std::runtime_error( "city '" + definition.id +
                                          "' size must be >= -1" );
            }
            validate_operation( entry.operation,
                                city_id( definition.id ).is_valid(),
                                definition.id, "city" );
        }

        std::set<std::string> faction_mission_ids;
        for( const faction_mission_registration &entry : pimpl_->faction_missions ) {
            const faction_mission_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "faction_mission" );
            if( !faction_mission_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "faction_mission '" + definition.id +
                                          "' is registered more than once per transaction" );
            }
            if( definition.name.empty() || definition.description.empty() ) {
                throw std::runtime_error( "faction_mission '" + definition.id +
                                          "' requires name and description" );
            }
            if( !definition.difficulty.empty() ) {
                if( definition.difficulty != "NONE" &&
                    definition.difficulty != "VERY_LOW" &&
                    definition.difficulty != "LOW" &&
                    definition.difficulty != "MEDIUM" &&
                    definition.difficulty != "HIGH" &&
                    definition.difficulty != "VERY_HIGH" ) {
                    throw std::runtime_error( "faction_mission '" + definition.id +
                                              "' has invalid difficulty: " + definition.difficulty );
                }
            }
            if( !definition.risk.empty() ) {
                if( definition.risk != "NONE" &&
                    definition.risk != "VERY_LOW" &&
                    definition.risk != "LOW" &&
                    definition.risk != "MEDIUM" &&
                    definition.risk != "HIGH" &&
                    definition.risk != "VERY_HIGH" ) {
                    throw std::runtime_error( "faction_mission '" + definition.id +
                                              "' has invalid risk: " + definition.risk );
                }
            }
            if( !definition.activity.empty() ) {
                if( activity_levels_map.find( definition.activity ) == activity_levels_map.end() ) {
                    throw std::runtime_error( "faction_mission '" + definition.id +
                                              "' has invalid activity level: " + definition.activity );
                }
            }
            if( !native_int( definition.positions ) || definition.positions < 0 ||
                definition.positions > 65535 ) {
                throw std::runtime_error( "faction_mission '" + definition.id +
                                          "' positions must be between 0 and 65535" );
            }
            if( !definition.skill.empty() ) {
                require_valid_id( definition.skill, "skill" );
                if( check_engine_state && index.skill_ids.count( definition.skill ) == 0 &&
                    !skill_id( definition.skill ).is_valid() ) {
                    throw std::runtime_error( "faction_mission '" + definition.id +
                                              "' references unknown skill: " + definition.skill );
                }
            }
            if( definition.items_possibilities.size() > 1024 ) {
                throw std::runtime_error( "faction_mission '" + definition.id +
                                          "' exceeds items_possibilities Platform limit" );
            }
            for( const std::string &item : definition.items_possibilities ) {
                if( item.empty() ) {
                    throw std::runtime_error( "faction_mission '" + definition.id +
                                              "' has empty items_possibility" );
                }
            }
            if( definition.effects.size() > 1024 ) {
                throw std::runtime_error( "faction_mission '" + definition.id +
                                          "' exceeds effects Platform limit" );
            }
            for( const std::string &eff : definition.effects ) {
                if( eff.empty() ) {
                    throw std::runtime_error( "faction_mission '" + definition.id +
                                              "' has empty effect" );
                }
            }
            validate_operation( entry.operation,
                                faction_mission_id( definition.id ).is_valid(),
                                definition.id, "faction_mission" );
        }

        std::set<std::string> region_settings_city_ids;
        for( const region_settings_city_registration &entry : pimpl_->region_settings_cities ) {
            const region_settings_city_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "region_settings_city" );
            if( !region_settings_city_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "region_settings_city '" + definition.id +
                                          "' is registered more than once per transaction" );
            }
            if( !definition.city_size_set ) {
                throw std::runtime_error( "region_settings_city '" + definition.id +
                                          "' requires city_size" );
            }
            if( !native_int( definition.city_size ) || definition.city_size < 0 || definition.city_size > 16 ) {
                throw std::runtime_error( "region_settings_city '" + definition.id +
                                          "' city_size must be between 0 and 16" );
            }
            if( !native_int( definition.city_spacing ) || definition.city_spacing < 0 ||
                definition.city_spacing > 8 ) {
                throw std::runtime_error( "region_settings_city '" + definition.id +
                                          "' city_spacing must be between 0 and 8" );
            }
            if( !native_int( definition.shop_radius ) || definition.shop_radius < 0 ||
                !native_int( definition.shop_sigma ) || definition.shop_sigma < 0 ||
                !native_int( definition.park_radius ) || definition.park_radius < 0 ||
                !native_int( definition.park_sigma ) || definition.park_sigma < 0 ) {
                throw std::runtime_error( "region_settings_city '" + definition.id +
                                          "' radius and sigma values must be non-negative native integers" );
            }
            const auto check_city_bin = [&](
                                            const std::vector<std::pair<std::string, std::int64_t>> &bin,
            const char *label ) {
                if( bin.size() > 1024 ) {
                    throw std::runtime_error( "region_settings_city '" + definition.id +
                                              "' exceeds Platform limit for " + label );
                }
                for( const auto &[special, weight] : bin ) {
                    require_valid_id( special, label );
                    if( !native_int( weight ) || weight <= 0 ) {
                        throw std::runtime_error( "region_settings_city '" + definition.id +
                                                  "' has invalid weight for " + label + ": " + special );
                    }
                    if( check_engine_state && !overmap_special_id( special ).is_valid() &&
                        !oter_type_str_id( special ).is_valid() ) {
                        throw std::runtime_error( "region_settings_city '" + definition.id +
                                                  "' references unknown overmap special or terrain type: " +
                                                  special );
                    }
                }
            };
            check_city_bin( definition.houses, "houses" );
            check_city_bin( definition.shops, "shops" );
            check_city_bin( definition.parks, "parks" );

            validate_operation( entry.operation,
                                region_settings_city_id( definition.id ).is_valid(),
                                definition.id, "region_settings_city" );
        }

        std::set<std::string> forest_biome_mapgen_ids;
        for( const forest_biome_mapgen_registration &entry : pimpl_->forest_biome_mapgens ) {
            const forest_biome_mapgen_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "forest_biome_mapgen" );
            if( !forest_biome_mapgen_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "forest_biome_mapgen '" + definition.id +
                                          "' is registered more than once per transaction" );
            }
            if( !native_int( definition.sparseness_adjacency_factor ) ||
                !native_int( definition.item_group_chance ) ||
                !native_int( definition.item_spawn_iterations ) ) {
                throw std::runtime_error( "forest_biome_mapgen '" + definition.id +
                                          "' has integer values outside the native range" );
            }
            if( definition.item_group_chance < 0 ) {
                throw std::runtime_error( "forest_biome_mapgen '" + definition.id +
                                          "' item_group_chance must be non-negative" );
            }
            if( definition.item_spawn_iterations < 0 ) {
                throw std::runtime_error( "forest_biome_mapgen '" + definition.id +
                                          "' item_spawn_iterations must be non-negative" );
            }
            if( !definition.item_group.empty() ) {
                require_valid_id( definition.item_group, "item_group" );
                if( check_engine_state && index.item_group_ids.count( definition.item_group ) == 0 &&
                    !item_group_id( definition.item_group ).is_valid() ) {
                    throw std::runtime_error( "forest_biome_mapgen '" + definition.id +
                                              "' references unknown item_group: " + definition.item_group );
                }
            }
            if( definition.terrains.size() > 1024 ) {
                throw std::runtime_error( "forest_biome_mapgen '" + definition.id +
                                          "' exceeds terrains Platform limit" );
            }
            for( const std::string &terrain : definition.terrains ) {
                require_valid_id( terrain, "terrain" );
                if( check_engine_state && !oter_type_str_id( terrain ).is_valid() ) {
                    throw std::runtime_error( "forest_biome_mapgen '" + definition.id +
                                              "' references unknown overmap terrain: " + terrain );
                }
            }
            if( definition.components.size() > 1024 ) {
                throw std::runtime_error( "forest_biome_mapgen '" + definition.id +
                                          "' exceeds components Platform limit" );
            }
            for( const std::string &component : definition.components ) {
                require_valid_id( component, "forest_biome_component" );
                if( check_engine_state && forest_biome_component_ids.count( component ) == 0 &&
                    !forest_biome_component_id( component ).is_valid() ) {
                    throw std::runtime_error( "forest_biome_mapgen '" + definition.id +
                                              "' references unknown forest biome component: " + component );
                }
            }
            if( definition.groundcover.size() > 1024 ) {
                throw std::runtime_error( "forest_biome_mapgen '" + definition.id +
                                          "' exceeds groundcover Platform limit" );
            }
            for( const auto &[ter, weight] : definition.groundcover ) {
                require_valid_id( ter, "groundcover terrain" );
                if( !native_int( weight ) || weight <= 0 ) {
                    throw std::runtime_error( "forest_biome_mapgen '" + definition.id +
                                              "' has invalid weight for groundcover: " + ter );
                }
                if( check_engine_state && index.terrain_ids.count( ter ) == 0 &&
                    !ter_str_id( ter ).is_valid() ) {
                    throw std::runtime_error( "forest_biome_mapgen '" + definition.id +
                                              "' references unknown groundcover terrain: " + ter );
                }
            }
            if( definition.terrain_furniture.size() > 1024 ) {
                throw std::runtime_error( "forest_biome_mapgen '" + definition.id +
                                          "' exceeds terrain_furniture Platform limit" );
            }
            for( const auto &tdf : definition.terrain_furniture ) {
                require_valid_id( tdf.ter_id, "terrain_furniture terrain" );
                if( check_engine_state && index.terrain_ids.count( tdf.ter_id ) == 0 &&
                    !ter_str_id( tdf.ter_id ).is_valid() ) {
                    throw std::runtime_error( "forest_biome_mapgen '" + definition.id +
                                              "' references unknown terrain_furniture terrain: " + tdf.ter_id );
                }
                if( !native_int( tdf.chance ) || tdf.chance < 0 ) {
                    throw std::runtime_error( "forest_biome_mapgen '" + definition.id +
                                              "' has invalid chance for terrain_furniture: " + tdf.ter_id );
                }
                if( tdf.furniture.size() > 1024 ) {
                    throw std::runtime_error( "forest_biome_mapgen '" + definition.id +
                                              "' exceeds furniture Platform limit for: " + tdf.ter_id );
                }
                for( const auto &[furn, weight] : tdf.furniture ) {
                    require_valid_id( furn, "furniture" );
                    if( !native_int( weight ) || weight <= 0 ) {
                        throw std::runtime_error( "forest_biome_mapgen '" + definition.id +
                                                  "' has invalid weight for furniture: " + furn );
                    }
                    if( check_engine_state && index.furniture_ids.count( furn ) == 0 &&
                        !furn_str_id( furn ).is_valid() ) {
                        throw std::runtime_error( "forest_biome_mapgen '" + definition.id +
                                                  "' references unknown furniture: " + furn );
                    }
                }
            }

            validate_operation( entry.operation,
                                forest_biome_mapgen_id( definition.id ).is_valid(),
                                definition.id, "forest_biome_mapgen" );
        }

        std::set<std::string> region_settings_ids;
        for( const region_settings_registration &entry : pimpl_->region_settings ) {
            const region_settings_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "region settings" );
            if( !region_settings_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "region settings '" + definition.id +
                                          "' is registered more than once per transaction" );
            }
            if( !definition.default_oter.empty() &&
                definition.default_oter.size() != OVERMAP_LAYERS ) {
                throw std::runtime_error( "region settings '" + definition.id +
                                          "' requires exactly " +
                                          std::to_string( OVERMAP_LAYERS ) +
                                          " default overmap terrains" );
            }
            for( const std::string &terrain : definition.default_oter ) {
                require_valid_id( terrain, "default overmap terrain" );
                if( check_engine_state && !oter_str_id( terrain ).is_valid() ) {
                    throw std::runtime_error( "region settings '" + definition.id +
                                              "' references unknown default overmap terrain '" +
                                              terrain + "'" );
                }
            }
            for( const auto &[terrain, weight] : definition.default_groundcover ) {
                require_valid_id( terrain, "default groundcover terrain" );
                if( !native_int( weight ) || weight <= 0 ||
                    ( check_engine_state && index.terrain_ids.count( terrain ) == 0 &&
                      !ter_str_id( terrain ).is_valid() ) ) {
                    throw std::runtime_error( "region settings '" + definition.id +
                                              "' has unknown or invalidly weighted groundcover '" +
                                              terrain + "'" );
                }
            }
            const auto require_reference = [&]( const std::string & reference,
                                                const std::set<std::string> &staged,
                                                const bool native_valid,
            const char *label, const bool required ) {
                if( reference.empty() ) {
                    if( required ) {
                        throw std::runtime_error( "region settings '" + definition.id +
                                                  "' requires " + label );
                    }
                    return;
                }
                require_valid_id( reference, label );
                if( check_engine_state && staged.count( reference ) == 0 && !native_valid ) {
                    throw std::runtime_error( "region settings '" + definition.id +
                                              "' references unknown " + label + " '" +
                                              reference + "'" );
                }
            };
            require_reference( definition.cities, region_settings_city_ids,
                               region_settings_city_id( definition.cities ).is_valid(),
                               "city settings", true );
            require_reference( definition.forest_composition,
                               region_settings_forest_mapgen_ids,
                               region_settings_forest_mapgen_id(
                                   definition.forest_composition ).is_valid(),
                               "forest composition", false );
            require_reference( definition.forest_trails,
                               region_settings_forest_trail_ids,
                               region_settings_forest_trail_id(
                                   definition.forest_trails ).is_valid(),
                               "forest trail settings", false );
            require_reference( definition.weather, index.weather_generator_ids,
                               weather_generator_id( definition.weather ).is_valid(),
                               "weather generator", false );
            require_reference( definition.forests, region_settings_forest_ids,
                               region_settings_forest_id( definition.forests ).is_valid(),
                               "forest settings", false );
            require_reference( definition.rivers, region_settings_river_ids,
                               region_settings_river_id( definition.rivers ).is_valid(),
                               "river settings", false );
            require_reference( definition.lakes, region_settings_lake_ids,
                               region_settings_lake_id( definition.lakes ).is_valid(),
                               "lake settings", false );
            require_reference( definition.ocean, region_settings_ocean_ids,
                               region_settings_ocean_id( definition.ocean ).is_valid(),
                               "ocean settings", false );
            require_reference( definition.highways, region_settings_highway_ids,
                               region_settings_highway_id( definition.highways ).is_valid(),
                               "highway settings", false );
            require_reference( definition.ravines, region_settings_ravine_ids,
                               region_settings_ravine_id( definition.ravines ).is_valid(),
                               "ravine settings", false );
            require_reference( definition.map_extras, region_settings_map_extras_ids,
                               region_settings_map_extras_id(
                                   definition.map_extras ).is_valid(),
                               "map extras settings", false );
            require_reference( definition.terrain_furniture,
                               region_settings_terrain_furniture_ids,
                               region_settings_terrain_furniture_id(
                                   definition.terrain_furniture ).is_valid(),
                               "terrain furniture settings", false );

            std::set<std::string> feature_flags;
            for( const std::string &flag : definition.feature_blacklist ) {
                if( flag.empty() || !feature_flags.insert( flag ).second ) {
                    throw std::runtime_error( "region settings '" + definition.id +
                                              "' has an empty or repeated feature flag" );
                }
            }
            feature_flags.clear();
            for( const std::string &flag : definition.feature_whitelist ) {
                if( flag.empty() || !feature_flags.insert( flag ).second ) {
                    throw std::runtime_error( "region settings '" + definition.id +
                                              "' has an empty or repeated feature flag" );
                }
            }
            const auto check_connection = [&]( const char *label,
            const std::string & connection, const bool require_resolved = true ) {
                if( connection.empty() ) {
                    return;
                }
                require_valid_id( connection, label );
                if( check_engine_state && require_resolved &&
                    index.overmap_connection_ids.count( connection ) == 0 &&
                    !overmap_connection_id( connection ).is_valid() ) {
                    throw std::runtime_error( "region settings '" + definition.id +
                                              "' references unknown " + std::string( label ) +
                                              " '" + connection + "'" );
                }
            };
            check_connection( "trail connection", definition.trail_connection );
            check_connection( "sewer connection", definition.sewer_connection );
            check_connection( "subway connection", definition.subway_connection );
            check_connection( "rail connection", definition.rail_connection,
                              definition.place_railroads );
            check_connection( "intra-city road connection",
                              definition.intra_city_road_connection );
            check_connection( "inter-city road connection",
                              definition.inter_city_road_connection );
            if( !std::isfinite( definition.max_urbanity ) ||
                definition.max_urbanity < std::numeric_limits<float>::lowest() ||
                definition.max_urbanity > std::numeric_limits<float>::max() ) {
                throw std::runtime_error( "region settings '" + definition.id +
                                          "' has max urbanity outside the native float range" );
            }
            for( const float increase : definition.urbanity_increase ) {
                if( !std::isfinite( increase ) ) {
                    throw std::runtime_error( "region settings '" + definition.id +
                                              "' has non-finite urbanity increase" );
                }
            }
            validate_operation( entry.operation,
                                region_settings_id( definition.id ).is_valid(),
                                definition.id, "region settings" );
        }

        std::set<std::string> option_slider_ids;
        for( const option_slider_registration &entry : pimpl_->option_sliders ) {
            const detail::option_slider_native_definition &definition = *entry.definition;
            require_valid_id( definition.id, "option slider" );
            if( definition.name.empty() ||
                !option_slider_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "option slider '" + definition.id +
                                          "' requires a name and one registration per transaction" );
            }
            if( definition.levels.empty() || definition.levels.size() > 256 ||
                !native_int( definition.default_level ) ) {
                throw std::runtime_error( "option slider '" + definition.id +
                                          "' has invalid levels or default level" );
            }
            std::set<std::int64_t> levels;
            for( const detail::option_slider_native_level &level : definition.levels ) {
                if( !native_int( level.level ) || level.level < 0 ||
                    static_cast<std::size_t>( level.level ) >= definition.levels.size() ||
                    level.name.empty() || !levels.insert( level.level ).second ) {
                    throw std::runtime_error( "option slider '" + definition.id +
                                              "' needs unique dense numbered levels with names" );
                }
                if( level.options.size() > 512 ) {
                    throw std::runtime_error( "option slider '" + definition.id +
                                              "' exceeds the Platform option limit" );
                }
                for( const detail::option_slider_native_option &option : level.options ) {
                    if( option.option.empty() ||
                        ( option.type != "int" && option.type != "float" &&
                          option.type != "bool" && option.type != "string" ) ) {
                        throw std::runtime_error( "option slider '" + definition.id +
                                                  "' has an invalid option entry" );
                    }
                }
            }
            if( levels.count( definition.default_level ) == 0 ) {
                throw std::runtime_error( "option slider '" + definition.id +
                                          "' default level is not defined" );
            }
            validate_operation( entry.operation,
                                option_slider_id( definition.id ).is_valid(),
                                definition.id, "option slider" );
        }

        std::set<std::string> dimension_region_layout_ids;
        for( const dimension_region_layout_registration &entry :
             pimpl_->dimension_region_layouts ) {
            const detail::dimension_region_layout_native_definition &definition =
                *entry.definition;
            require_valid_id( definition.id, "dimension region layout" );
            if( !dimension_region_layout_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "dimension region layout '" + definition.id +
                                          "' is registered more than once per transaction" );
            }
            if( definition.generation_mode != "UNIFORM" ) {
                throw std::runtime_error( "dimension region layout '" + definition.id +
                                          "' only supports the native UNIFORM mode" );
            }
            require_valid_id( definition.uniform_region, "uniform region" );
            if( check_engine_state &&
                region_settings_ids.count( definition.uniform_region ) == 0 &&
                !region_settings_id( definition.uniform_region ).is_valid() ) {
                throw std::runtime_error( "dimension region layout '" + definition.id +
                                          "' references unknown region settings '" +
                                          definition.uniform_region + "'" );
            }
            validate_operation( entry.operation,
                                dimension_region_layout_id( definition.id ).is_valid(),
                                definition.id, "dimension region layout" );
        }

        std::set<std::string> dimension_ids;
        for( const dimension_registration &entry : pimpl_->dimensions ) {
            const detail::dimension_native_definition &definition = *entry.definition;
            require_valid_id( definition.id, "dimension" );
            if( !dimension_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "dimension '" + definition.id +
                                          "' is registered more than once per transaction" );
            }
            require_valid_id( definition.region_layout, "dimension region layout" );
            if( check_engine_state &&
                dimension_region_layout_ids.count( definition.region_layout ) == 0 &&
                !dimension_region_layout_id( definition.region_layout ).is_valid() ) {
                throw std::runtime_error( "dimension '" + definition.id +
                                          "' references unknown region layout '" +
                                          definition.region_layout + "'" );
            }
            validate_operation( entry.operation,
                                dimension_id( definition.id ).is_valid(),
                                definition.id, "dimension" );
        }

        std::set<std::string> omt_placeholder_ids;
        for( const omt_placeholder_registration &entry : pimpl_->omt_placeholders ) {
            const omt_placeholder_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "overmap terrain placeholder" );
            if( !definition.grid_set ||
                !omt_placeholder_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "overmap terrain placeholder '" + definition.id +
                                          "' requires a 24 by 24 grid and one registration per transaction" );
            }
            validate_operation( entry.operation,
                                string_id<map_data_summary>( definition.id ).is_valid(),
                                definition.id, "overmap terrain placeholder" );
        }

        error.clear();
        return true;
    } catch( const std::exception &exception ) {
        error = "Lua-first Mod '" + pimpl_->owner + "': " + exception.what();
        return false;
    }
}

bool worldgen_content_transaction::apply( std::string &error )
{
    if( pimpl_->applied ) {
        error = "worldgen content transaction for '" + pimpl_->owner + "' was already applied";
        return false;
    }
    if( pimpl_->token->lifecycle != handle_lifecycle::building ) {
        error = "worldgen content transaction for '" + pimpl_->owner +
                "' is no longer building";
        return false;
    }
    try {
        for( const region_settings_ravine_registration &entry : pimpl_->region_settings_ravines ) {
            const region_settings_ravine_id id( entry.definition->id );
            pimpl_->region_settings_ravine_undo.emplace_back(
                id, id.is_valid() ? std::optional<region_settings_ravine>( id.obj() ) : std::nullopt );
            region_settings_ravine native;
            native.id = id;
            native.num_ravines = static_cast<int>( entry.definition->num_ravines );
            native.ravine_range = static_cast<int>( entry.definition->ravine_range );
            native.ravine_width = static_cast<int>( entry.definition->ravine_width );
            native.ravine_depth = static_cast<int>( entry.definition->ravine_depth );
            native.was_loaded = true;
            detail::region_settings_ravine_registry().insert( native );
        }
        if( !pimpl_->region_settings_ravines.empty() ) {
            detail::region_settings_ravine_registry().finalize();
        }

        for( const region_settings_lake_registration &entry : pimpl_->region_settings_lakes ) {
            const region_settings_lake_id id( entry.definition->id );
            pimpl_->region_settings_lake_undo.emplace_back(
                id, id.is_valid() ? std::optional<region_settings_lake>( id.obj() ) : std::nullopt );
            region_settings_lake native;
            native.id = id;
            native.noise_threshold_lake = entry.definition->noise_threshold_lake;
            native.lake_size_min = static_cast<int>( entry.definition->lake_size_min );
            native.lake_depth = static_cast<int>( entry.definition->lake_depth );
            native.invert_lakes = entry.definition->invert_lakes;
            native.surface = oter_str_id( entry.definition->surface );
            native.shore = oter_str_id( entry.definition->shore );
            native.interior = oter_str_id( entry.definition->interior );
            native.bed = oter_str_id( entry.definition->bed );
            for( const std::string &oter : entry.definition->shore_extendable_overmap_terrain ) {
                native.shore_extendable_overmap_terrain.emplace_back( oter );
            }
            for( const region_settings_lake_alias_data &alias_data :
                 entry.definition->shore_extendable_overmap_terrain_aliases ) {
                shore_extendable_overmap_terrain_alias alias;
                alias.overmap_terrain = alias_data.om_terrain;
                alias.alias = oter_str_id( alias_data.alias );
                const std::optional<ot_match_type> match = platform_ot_match_type( alias_data.match_type );
                alias.match_type = match.value_or( ot_match_type::exact );
                native.shore_extendable_overmap_terrain_aliases.push_back( std::move( alias ) );
            }
            native.was_loaded = true;
            detail::region_settings_lake_registry().insert( native );
        }
        if( !pimpl_->region_settings_lakes.empty() ) {
            detail::region_settings_lake_registry().finalize();
        }

        for( const region_settings_ocean_registration &entry : pimpl_->region_settings_oceans ) {
            const region_settings_ocean_id id( entry.definition->id );
            pimpl_->region_settings_ocean_undo.emplace_back(
                id, id.is_valid() ? std::optional<region_settings_ocean>( id.obj() ) : std::nullopt );
            region_settings_ocean native;
            native.id = id;
            native.noise_threshold_ocean = entry.definition->noise_threshold_ocean;
            native.ocean_size_min = static_cast<int>( entry.definition->ocean_size_min );
            native.ocean_depth = static_cast<int>( entry.definition->ocean_depth );
            if( entry.definition->ocean_start_north.has_value() ) {
                native.ocean_start_north = static_cast<int>( *entry.definition->ocean_start_north );
            }
            if( entry.definition->ocean_start_east.has_value() ) {
                native.ocean_start_east = static_cast<int>( *entry.definition->ocean_start_east );
            }
            if( entry.definition->ocean_start_west.has_value() ) {
                native.ocean_start_west = static_cast<int>( *entry.definition->ocean_start_west );
            }
            if( entry.definition->ocean_start_south.has_value() ) {
                native.ocean_start_south = static_cast<int>( *entry.definition->ocean_start_south );
            }
            native.sandy_beach_width = static_cast<int>( entry.definition->sandy_beach_width );
            native.was_loaded = true;
            detail::region_settings_ocean_registry().insert( native );
        }
        if( !pimpl_->region_settings_oceans.empty() ) {
            detail::region_settings_ocean_registry().finalize();
        }

        for( const region_settings_forest_registration &entry : pimpl_->region_settings_forests ) {
            const region_settings_forest_id id( entry.definition->id );
            pimpl_->region_settings_forest_undo.emplace_back(
                id, id.is_valid() ? std::optional<region_settings_forest>( id.obj() ) : std::nullopt );
            region_settings_forest native;
            native.id = id;
            native.noise_threshold_forest = entry.definition->noise_threshold_forest;
            native.noise_threshold_forest_thick = entry.definition->noise_threshold_forest_thick;
            native.noise_threshold_swamp_adjacent_water =
                entry.definition->noise_threshold_swamp_adjacent_water;
            native.noise_threshold_swamp_isolated = entry.definition->noise_threshold_swamp_isolated;
            native.river_floodplain_buffer_distance_min = static_cast<int>
                    ( entry.definition->river_floodplain_buffer_distance_min );
            native.river_floodplain_buffer_distance_max = static_cast<int>
                    ( entry.definition->river_floodplain_buffer_distance_max );
            native.max_forest = static_cast<float>( entry.definition->forest_threshold_limit );
            native.forest_increase = entry.definition->forest_threshold_increase;
            native.was_loaded = true;
            detail::region_settings_forest_registry().insert( native );
        }
        if( !pimpl_->region_settings_forests.empty() ) {
            detail::region_settings_forest_registry().finalize();
        }

        for( const region_settings_river_registration &entry : pimpl_->region_settings_rivers ) {
            const region_settings_river_id id( entry.definition->id );
            pimpl_->region_settings_river_undo.emplace_back(
                id, id.is_valid() ? std::optional<region_settings_river>( id.obj() ) : std::nullopt );
            region_settings_river native;
            native.id = id;
            native.river_scale = static_cast<int>( entry.definition->river_scale );
            native.river_frequency = entry.definition->river_frequency;
            native.river_branch_chance = entry.definition->river_branch_chance;
            native.river_branch_remerge_chance = entry.definition->river_branch_remerge_chance;
            native.river_branch_scale_decrease = entry.definition->river_branch_scale_decrease;
            native.was_loaded = true;
            detail::region_settings_river_registry().insert( native );
        }
        if( !pimpl_->region_settings_rivers.empty() ) {
            detail::region_settings_river_registry().finalize();
        }

        for( const region_settings_forest_mapgen_registration &entry :
             pimpl_->region_settings_forest_mapgens ) {
            const region_settings_forest_mapgen_id id( entry.definition->id );
            pimpl_->region_settings_forest_mapgen_undo.emplace_back(
                id, id.is_valid() ? std::optional<region_settings_forest_mapgen>( id.obj() ) : std::nullopt );
            region_settings_forest_mapgen native;
            native.id = id;
            for( const std::string &biome_id : entry.definition->biomes ) {
                native.biomes.insert( forest_biome_mapgen_id( biome_id ) );
            }
            native.was_loaded = true;
            detail::region_settings_forest_mapgen_registry().insert( native );
        }
        if( !pimpl_->region_settings_forest_mapgens.empty() ) {
            detail::region_settings_forest_mapgen_registry().finalize();
        }

        for( const region_settings_map_extras_registration &entry : pimpl_->region_settings_map_extrases ) {
            const region_settings_map_extras_id id( entry.definition->id );
            pimpl_->region_settings_map_extras_undo.emplace_back(
                id, id.is_valid() ? std::optional<region_settings_map_extras>( id.obj() ) : std::nullopt );
            region_settings_map_extras native;
            native.id = id;
            for( const std::string &extra_id : entry.definition->extras ) {
                native.extras.insert( map_extra_collection_id( extra_id ) );
            }
            native.was_loaded = true;
            detail::region_settings_map_extras_registry().insert( native );
        }
        if( !pimpl_->region_settings_map_extrases.empty() ) {
            detail::region_settings_map_extras_registry().finalize();
        }

        for( const region_settings_terrain_furniture_registration &entry :
             pimpl_->region_settings_terrain_furnitures ) {
            const region_settings_terrain_furniture_id id( entry.definition->id );
            pimpl_->region_settings_terrain_furniture_undo.emplace_back(
                id, id.is_valid() ? std::optional<region_settings_terrain_furniture>( id.obj() ) : std::nullopt );
            region_settings_terrain_furniture native;
            native.id = id;
            for( const std::string &tf_id : entry.definition->ter_furn ) {
                native.ter_furn.insert( region_terrain_furniture_id( tf_id ) );
            }
            native.was_loaded = true;
            detail::region_settings_terrain_furniture_registry().insert( native );
        }
        if( !pimpl_->region_settings_terrain_furnitures.empty() ) {
            detail::region_settings_terrain_furniture_registry().finalize();
        }

        for( const region_settings_forest_trail_registration &entry :
             pimpl_->region_settings_forest_trails ) {
            const region_settings_forest_trail_id id( entry.definition->id );
            pimpl_->region_settings_forest_trail_undo.emplace_back(
                id, id.is_valid() ? std::optional<region_settings_forest_trail>( id.obj() ) : std::nullopt );
            region_settings_forest_trail native;
            native.id = id;
            native.chance = static_cast<int>( entry.definition->chance );
            native.border_point_chance = static_cast<int>( entry.definition->border_point_chance );
            native.minimum_forest_size = static_cast<int>( entry.definition->minimum_forest_size );
            native.random_point_min = static_cast<int>( entry.definition->random_point_min );
            native.random_point_max = static_cast<int>( entry.definition->random_point_max );
            native.random_point_size_scalar = static_cast<int>( entry.definition->random_point_size_scalar );
            native.trailhead_chance = static_cast<int>( entry.definition->trailhead_chance );
            native.trailhead_road_distance = static_cast<int>( entry.definition->trailhead_road_distance );
            for( const auto &[special, weight] : entry.definition->trailheads ) {
                native.trailheads.add( overmap_special_id( special ), static_cast<int>( weight ) );
            }
            native.was_loaded = true;
            detail::region_settings_forest_trail_registry().insert( native );
        }

        for( const region_settings_highway_registration &entry :
             pimpl_->region_settings_highways ) {
            const region_settings_highway_id id( entry.definition->id );
            pimpl_->region_settings_highway_undo.emplace_back(
                id, id.is_valid() ? std::optional<region_settings_highway>( id.obj() ) : std::nullopt );
            region_settings_highway native;
            native.id = id;
            native.width_of_segments = static_cast<int>( entry.definition->width_of_segments );
            native.straightness_chance = entry.definition->straightness_chance;
            if( !entry.definition->reserved_terrain_id.empty() ) {
                native.reserved_terrain_id = oter_type_str_id( entry.definition->reserved_terrain_id );
            }
            if( !entry.definition->reserved_terrain_water_id.empty() ) {
                native.reserved_terrain_water_id = oter_type_str_id( entry.definition->reserved_terrain_water_id );
            }
            if( !entry.definition->segment_flat_special.empty() ) {
                native.segment_flat = overmap_special_id( entry.definition->segment_flat_special );
            }
            if( !entry.definition->segment_ramp_special.empty() ) {
                native.segment_ramp = overmap_special_id( entry.definition->segment_ramp_special );
            }
            if( !entry.definition->segment_road_bridge_special.empty() ) {
                native.segment_road_bridge = overmap_special_id( entry.definition->segment_road_bridge_special );
            }
            if( !entry.definition->segment_bridge_special.empty() ) {
                native.segment_bridge = overmap_special_id( entry.definition->segment_bridge_special );
            }
            if( !entry.definition->segment_bridge_supports_special.empty() ) {
                native.segment_bridge_supports =
                    overmap_special_id( entry.definition->segment_bridge_supports_special );
            }
            if( !entry.definition->segment_overpass_special.empty() ) {
                native.segment_overpass = overmap_special_id( entry.definition->segment_overpass_special );
            }
            if( !entry.definition->clockwise_slant_special.empty() ) {
                native.clockwise_slant = overmap_special_id( entry.definition->clockwise_slant_special );
            }
            if( !entry.definition->counterclockwise_slant_special.empty() ) {
                native.counterclockwise_slant =
                    overmap_special_id( entry.definition->counterclockwise_slant_special );
            }
            if( !entry.definition->fallback_onramp_special.empty() ) {
                native.fallback_onramp = overmap_special_id( entry.definition->fallback_onramp_special );
            }
            if( !entry.definition->fallback_bend_special.empty() ) {
                native.fallback_bend = overmap_special_id( entry.definition->fallback_bend_special );
            }
            if( !entry.definition->fallback_three_way_intersection_special.empty() ) {
                native.fallback_three_way_intersection =
                    overmap_special_id( entry.definition->fallback_three_way_intersection_special );
            }
            if( !entry.definition->fallback_four_way_intersection_special.empty() ) {
                native.fallback_four_way_intersection =
                    overmap_special_id( entry.definition->fallback_four_way_intersection_special );
            }
            if( !entry.definition->fallback_supports.empty() ) {
                native.fallback_supports = oter_type_str_id( entry.definition->fallback_supports );
            }
            for( const auto &[special, weight] : entry.definition->four_way_intersections ) {
                native.four_way_intersections.add( overmap_special_id( special ), static_cast<int>( weight ) );
            }
            for( const auto &[special, weight] : entry.definition->three_way_intersections ) {
                native.three_way_intersections.add( overmap_special_id( special ), static_cast<int>( weight ) );
            }
            for( const auto &[special, weight] : entry.definition->bends ) {
                native.bends.add( overmap_special_id( special ), static_cast<int>( weight ) );
            }
            for( const auto &[special, weight] : entry.definition->road_connections ) {
                native.road_connections.add( overmap_special_id( special ), static_cast<int>( weight ) );
            }
            for( const auto &[special, weight] : entry.definition->interchanges ) {
                native.interchanges.add( overmap_special_id( special ), static_cast<int>( weight ) );
            }
            native.was_loaded = true;
            detail::region_settings_highway_registry().insert( native );
        }

        for( const region_settings_registration &entry : pimpl_->region_settings ) {
            const region_settings_id id( entry.definition->id );
            pimpl_->region_settings_undo.emplace_back(
                id, id.is_valid() ? std::optional<::region_settings>( id.obj() ) : std::nullopt );
            ::region_settings native;
            native.id = id;
            if( !entry.definition->default_oter.empty() ) {
                for( std::size_t index = 0; index < OVERMAP_LAYERS; ++index ) {
                    native.default_oter[index] = oter_str_id( entry.definition->default_oter[index] );
                }
            }
            if( entry.definition->default_groundcover_set ) {
                native.default_groundcover.clear();
                for( const auto &[terrain, weight] : entry.definition->default_groundcover ) {
                    native.default_groundcover.add( ter_id( terrain ), static_cast<int>( weight ) );
                }
            }
            if( !entry.definition->cities.empty() ) {
                native.city_spec = region_settings_city_id( entry.definition->cities );
            }
            if( !entry.definition->forest_composition.empty() ) {
                native.forest_composition = region_settings_forest_mapgen_id(
                                                entry.definition->forest_composition );
            }
            if( !entry.definition->forest_trails.empty() ) {
                native.forest_trail = region_settings_forest_trail_id(
                                          entry.definition->forest_trails );
            }
            if( !entry.definition->weather.empty() ) {
                native.weather = weather_generator_id( entry.definition->weather );
            }
            if( !entry.definition->forests.empty() ) {
                native.overmap_forest = region_settings_forest_id( entry.definition->forests );
            }
            if( !entry.definition->rivers.empty() ) {
                native.overmap_river = region_settings_river_id( entry.definition->rivers );
            }
            if( !entry.definition->lakes.empty() ) {
                native.overmap_lake = region_settings_lake_id( entry.definition->lakes );
            }
            if( !entry.definition->ocean.empty() ) {
                native.overmap_ocean = region_settings_ocean_id( entry.definition->ocean );
            }
            if( !entry.definition->highways.empty() ) {
                native.overmap_highway = region_settings_highway_id( entry.definition->highways );
            }
            if( !entry.definition->ravines.empty() ) {
                native.overmap_ravine = region_settings_ravine_id( entry.definition->ravines );
            }
            if( !entry.definition->map_extras.empty() ) {
                native.region_extras = region_settings_map_extras_id(
                                           entry.definition->map_extras );
            }
            if( !entry.definition->terrain_furniture.empty() ) {
                native.region_terrain_and_furniture = region_settings_terrain_furniture_id(
                        entry.definition->terrain_furniture );
            }
            native.overmap_feature_flag.blacklist.insert(
                entry.definition->feature_blacklist.begin(),
                entry.definition->feature_blacklist.end() );
            native.overmap_feature_flag.whitelist.insert(
                entry.definition->feature_whitelist.begin(),
                entry.definition->feature_whitelist.end() );
            if( !entry.definition->trail_connection.empty() ) {
                native.overmap_connection.trail_connection = overmap_connection_id(
                            entry.definition->trail_connection );
            }
            if( !entry.definition->sewer_connection.empty() ) {
                native.overmap_connection.sewer_connection = overmap_connection_id(
                            entry.definition->sewer_connection );
            }
            if( !entry.definition->subway_connection.empty() ) {
                native.overmap_connection.subway_connection = overmap_connection_id(
                            entry.definition->subway_connection );
            }
            if( !entry.definition->rail_connection.empty() ) {
                native.overmap_connection.rail_connection = overmap_connection_id(
                            entry.definition->rail_connection );
            }
            if( !entry.definition->intra_city_road_connection.empty() ) {
                native.overmap_connection.intra_city_road_connection = overmap_connection_id(
                            entry.definition->intra_city_road_connection );
            }
            if( !entry.definition->inter_city_road_connection.empty() ) {
                native.overmap_connection.inter_city_road_connection = overmap_connection_id(
                            entry.definition->inter_city_road_connection );
            }
            native.place_swamps = entry.definition->place_swamps;
            native.place_roads = entry.definition->place_roads;
            native.place_railroads = entry.definition->place_railroads;
            native.place_railroads_before_roads = entry.definition->place_railroads_before_roads;
            native.place_specials = entry.definition->place_specials;
            native.neighbor_connections = entry.definition->neighbor_connections;
            native.max_urban = static_cast<float>( entry.definition->max_urbanity );
            native.urban_increase = entry.definition->urbanity_increase;
            native.was_loaded = true;
            detail::region_settings_registry().insert( native );
        }
        if( !pimpl_->region_settings.empty() ) {
            detail::region_settings_registry().finalize();
        }
        for( const option_slider_registration &entry : pimpl_->option_sliders ) {
            const option_slider_id id( entry.definition->id );
            pimpl_->option_slider_undo.emplace_back(
                id, id.is_valid() ? std::optional<option_slider>( id.obj() ) : std::nullopt );
            detail::option_slider_registry().insert(
                detail::make_option_slider_native( *entry.definition ) );
        }
        if( !pimpl_->option_sliders.empty() ) {
            detail::option_slider_registry().finalize();
        }

        for( const dimension_region_layout_registration &entry :
             pimpl_->dimension_region_layouts ) {
            const dimension_region_layout_id id( entry.definition->id );
            pimpl_->dimension_region_layout_undo.emplace_back(
                id, id.is_valid() ? std::optional<dimension_region_layout>( id.obj() ) :
                std::nullopt );
            detail::dimension_region_layout_registry().insert(
                detail::make_dimension_region_layout_native( *entry.definition ) );
        }
        if( !pimpl_->dimension_region_layouts.empty() ) {
            detail::dimension_region_layout_registry().finalize();
        }

        for( const dimension_registration &entry : pimpl_->dimensions ) {
            const dimension_id id( entry.definition->id );
            pimpl_->dimension_undo.emplace_back(
                id, id.is_valid() ? std::optional<dimension_world>( id.obj() ) : std::nullopt );
            detail::dimension_registry().insert(
                detail::make_dimension_native( *entry.definition ) );
        }
        if( !pimpl_->dimensions.empty() ) {
            detail::dimension_registry().finalize();
        }

        for( const omt_placeholder_registration &entry : pimpl_->omt_placeholders ) {
            const string_id<map_data_summary> id( entry.definition->id );
            pimpl_->omt_placeholder_undo.emplace_back(
                id, id.is_valid() ? std::optional<map_data_summary>( id.obj() ) : std::nullopt );
            map_data_summary native;
            native.id = id;
            native.placeholder = true;
            std::size_t cell = 0;
            for( const std::string &row : entry.definition->grid ) {
                for( const char value : row ) {
                    native.passable.set( cell++, value == '1' );
                }
            }
            native.was_loaded = true;
            detail::omt_placeholder_registry().insert( native );
        }
        if( !pimpl_->omt_placeholders.empty() ) {
            detail::omt_placeholder_registry().finalize();
        }

        for( const region_terrain_furniture_registration &entry :
             pimpl_->region_terrain_furnitures ) {
            const region_terrain_furniture_id id( entry.definition->id );
            pimpl_->region_terrain_furniture_undo.emplace_back(
                id, id.is_valid() ? std::optional<region_terrain_furniture>( id.obj() ) : std::nullopt );
            region_terrain_furniture native;
            native.id = id;
            if( !entry.definition->ter_id.empty() ) {
                native.replaced_ter_id = ter_id( entry.definition->ter_id );
            }
            if( !entry.definition->furn_id.empty() ) {
                native.replaced_furn_id = furn_id( entry.definition->furn_id );
            }
            for( const auto &[terrain, weight] : entry.definition->replace_with_terrain ) {
                native.terrain.add( ter_id( terrain ), static_cast<int>( weight ) );
            }
            for( const auto &[furniture, weight] : entry.definition->replace_with_furniture ) {
                native.furniture.add( furn_id( furniture ), static_cast<int>( weight ) );
            }
            native.was_loaded = true;
            detail::region_terrain_furniture_registry().insert( native );
        }

        for( const forest_biome_component_registration &entry :
             pimpl_->forest_biome_components ) {
            const forest_biome_component_id id( entry.definition->id );
            pimpl_->forest_biome_component_undo.emplace_back(
                id, id.is_valid() ? std::optional<forest_biome_component>( id.obj() ) : std::nullopt );
            forest_biome_component native;
            native.id = id;
            native.chance = static_cast<int>( entry.definition->chance );
            native.sequence = static_cast<int>( entry.definition->sequence );
            for( const auto &[type, weight] : entry.definition->types ) {
                native.types.add( ter_furn_id( type ), static_cast<int>( weight ) );
            }
            native.was_loaded = true;
            detail::forest_biome_component_registry().insert( native );
        }

        for( const city_registration &entry : pimpl_->cities ) {
            const city_id id( entry.definition->id );
            pimpl_->city_undo.emplace_back(
                id, id.is_valid() ? std::optional<city>( id.obj() ) : std::nullopt );
            city native;
            native.id = id;
            native.database_id = static_cast<int>( entry.definition->database_id );
            native.name = entry.definition->name;
            native.population = static_cast<int>( entry.definition->population );
            native.size = static_cast<int>( entry.definition->size );
            native.pos_om = point_abs_om( static_cast<int>( entry.definition->pos_om_x ),
                                          static_cast<int>( entry.definition->pos_om_y ) );
            native.pos = point_om_omt( static_cast<int>( entry.definition->pos_x ),
                                       static_cast<int>( entry.definition->pos_y ) );
            native.was_loaded = true;
            detail::city_registry().insert( native );
        }

        for( const faction_mission_registration &entry : pimpl_->faction_missions ) {
            const faction_mission_id id( entry.definition->id );
            pimpl_->faction_mission_undo.emplace_back(
                id, id.is_valid() ? std::optional<faction_mission>( id.obj() ) : std::nullopt );
            faction_mission native;
            native.id = id;
            native.name = to_translation( entry.definition->name );
            native.description = to_translation( entry.definition->description );
            if( !entry.definition->skill.empty() ) {
                native.skill_used = skill_id( entry.definition->skill );
            }
            if( !entry.definition->difficulty.empty() ) {
                if( entry.definition->difficulty == "NONE" ) {
                    native.difficulty = risk_diff_level::NONE;
                } else if( entry.definition->difficulty == "VERY_LOW" ) {
                    native.difficulty = risk_diff_level::VERY_LOW;
                } else if( entry.definition->difficulty == "LOW" ) {
                    native.difficulty = risk_diff_level::LOW;
                } else if( entry.definition->difficulty == "MEDIUM" ) {
                    native.difficulty = risk_diff_level::MEDIUM;
                } else if( entry.definition->difficulty == "HIGH" ) {
                    native.difficulty = risk_diff_level::HIGH;
                } else if( entry.definition->difficulty == "VERY_HIGH" ) {
                    native.difficulty = risk_diff_level::VERY_HIGH;
                }
            } else {
                native.difficulty = risk_diff_level::NUM_RISK_DIFF_LEVELS;
            }
            if( !entry.definition->risk.empty() ) {
                if( entry.definition->risk == "NONE" ) {
                    native.risk = risk_diff_level::NONE;
                } else if( entry.definition->risk == "VERY_LOW" ) {
                    native.risk = risk_diff_level::VERY_LOW;
                } else if( entry.definition->risk == "LOW" ) {
                    native.risk = risk_diff_level::LOW;
                } else if( entry.definition->risk == "MEDIUM" ) {
                    native.risk = risk_diff_level::MEDIUM;
                } else if( entry.definition->risk == "HIGH" ) {
                    native.risk = risk_diff_level::HIGH;
                } else if( entry.definition->risk == "VERY_HIGH" ) {
                    native.risk = risk_diff_level::VERY_HIGH;
                }
            } else {
                native.risk = risk_diff_level::NUM_RISK_DIFF_LEVELS;
            }
            if( !entry.definition->activity.empty() ) {
                auto it = activity_levels_map.find( entry.definition->activity );
                if( it != activity_levels_map.end() ) {
                    native.activity_level = it->second;
                }
            } else {
                native.activity_level = 0.0f;
            }
            native.time = to_translation( entry.definition->time );
            native.positions = static_cast<uint16_t>( entry.definition->positions );
            native.items_label = to_translation( entry.definition->items_label );
            for( const std::string &poss : entry.definition->items_possibilities ) {
                native.items_possibilities.push_back( to_translation( poss ) );
            }
            for( const std::string &eff : entry.definition->effects ) {
                native.effects.push_back( to_translation( eff ) );
            }
            native.footer = to_translation( entry.definition->footer );
            native.was_loaded = true;
            detail::faction_mission_registry().insert( native );
        }

        for( const region_settings_city_registration &entry : pimpl_->region_settings_cities ) {
            const region_settings_city_id id( entry.definition->id );
            pimpl_->region_settings_city_undo.emplace_back(
                id, id.is_valid() ? std::optional<region_settings_city>( id.obj() ) : std::nullopt );
            region_settings_city native;
            native.id = id;
            native.is_megacity = entry.definition->is_megacity;
            native.city_size = static_cast<int>( entry.definition->city_size );
            native.city_spacing = static_cast<int>( entry.definition->city_spacing );
            native.shop_radius = static_cast<int>( entry.definition->shop_radius );
            native.shop_sigma = static_cast<int>( entry.definition->shop_sigma );
            native.park_radius = static_cast<int>( entry.definition->park_radius );
            native.park_sigma = static_cast<int>( entry.definition->park_sigma );
            native.name_snippet = entry.definition->name_snippet;
            for( const auto &[special, weight] : entry.definition->houses ) {
                native.houses.add( overmap_special_id( special ), static_cast<int>( weight ) );
            }
            for( const auto &[special, weight] : entry.definition->shops ) {
                native.shops.add( overmap_special_id( special ), static_cast<int>( weight ) );
            }
            for( const auto &[special, weight] : entry.definition->parks ) {
                native.parks.add( overmap_special_id( special ), static_cast<int>( weight ) );
            }
            native.was_loaded = true;
            detail::region_settings_city_registry().insert( native );
        }

        for( const forest_biome_mapgen_registration &entry : pimpl_->forest_biome_mapgens ) {
            const forest_biome_mapgen_id id( entry.definition->id );
            pimpl_->forest_biome_mapgen_undo.emplace_back(
                id, id.is_valid() ? std::optional<forest_biome_mapgen>( id.obj() ) : std::nullopt );
            forest_biome_mapgen native;
            native.id = id;
            for( const std::string &terrain : entry.definition->terrains ) {
                native.terrains.insert( oter_type_str_id( terrain ) );
            }
            for( const std::string &component : entry.definition->components ) {
                native.biome_components.insert( forest_biome_component_id( component ) );
            }
            for( const auto &[ter, weight] : entry.definition->groundcover ) {
                native.groundcover.add( ter_id( ter ), static_cast<int>( weight ) );
            }
            for( const auto &tdf : entry.definition->terrain_furniture ) {
                forest_biome_terrain_dependent_furniture_new ftdf;
                ftdf.chance = static_cast<int>( tdf.chance );
                for( const auto &[furn, weight] : tdf.furniture ) {
                    ftdf.furniture.add( furn_id( furn ), static_cast<int>( weight ) );
                }
                native.terrain_dependent_furniture[ter_id( tdf.ter_id )] = std::move( ftdf );
            }
            native.sparseness_adjacency_factor = static_cast<int>
                                                 ( entry.definition->sparseness_adjacency_factor );
            if( !entry.definition->item_group.empty() ) {
                native.item_group = item_group_id( entry.definition->item_group );
            }
            native.item_group_chance = static_cast<int>( entry.definition->item_group_chance );
            native.item_spawn_iterations = static_cast<int>( entry.definition->item_spawn_iterations );
            native.was_loaded = true;
            detail::forest_biome_mapgen_registry().insert( native );
        }

        pimpl_->applied = true;
        error.clear();
        return true;
    } catch( const std::exception &exception ) {
        rollback();
        error = "Lua-first Mod '" + pimpl_->owner + "': " + exception.what();
        return false;
    }
}

bool worldgen_content_transaction::validate_finalized( std::string &error ) const
{
    if( !pimpl_->applied ) {
        error = "worldgen content transaction for '" + pimpl_->owner + "' is not applied";
        return false;
    }
    if( pimpl_->finalization_validated ) {
        error = "worldgen content finalization for '" + pimpl_->owner +
                "' was already validated";
        return false;
    }
    for( const region_settings_ravine_registration &entry : pimpl_->region_settings_ravines ) {
        if( !region_settings_ravine_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first region settings ravine '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const region_settings_lake_registration &entry : pimpl_->region_settings_lakes ) {
        if( !region_settings_lake_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first region settings lake '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const region_settings_ocean_registration &entry : pimpl_->region_settings_oceans ) {
        if( !region_settings_ocean_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first region settings ocean '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const region_settings_forest_registration &entry : pimpl_->region_settings_forests ) {
        if( !region_settings_forest_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first region settings forest '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const region_settings_river_registration &entry : pimpl_->region_settings_rivers ) {
        if( !region_settings_river_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first region settings river '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const region_settings_forest_mapgen_registration &entry :
         pimpl_->region_settings_forest_mapgens ) {
        if( !region_settings_forest_mapgen_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first region settings forest mapgen '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const region_settings_map_extras_registration &entry : pimpl_->region_settings_map_extrases ) {
        if( !region_settings_map_extras_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first region settings map extras '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const region_settings_terrain_furniture_registration &entry :
         pimpl_->region_settings_terrain_furnitures ) {
        if( !region_settings_terrain_furniture_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first region settings terrain furniture '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const region_settings_forest_trail_registration &entry :
         pimpl_->region_settings_forest_trails ) {
        if( !region_settings_forest_trail_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first region settings forest trail '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const region_settings_highway_registration &entry :
         pimpl_->region_settings_highways ) {
        if( !region_settings_highway_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first region settings highway '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const region_settings_registration &entry : pimpl_->region_settings ) {
        if( !region_settings_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first region settings '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const option_slider_registration &entry : pimpl_->option_sliders ) {
        if( !option_slider_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first option slider '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const dimension_region_layout_registration &entry :
         pimpl_->dimension_region_layouts ) {
        if( !dimension_region_layout_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first dimension region layout '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const dimension_registration &entry : pimpl_->dimensions ) {
        if( !dimension_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first dimension '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const omt_placeholder_registration &entry : pimpl_->omt_placeholders ) {
        if( !string_id<map_data_summary>( entry.definition->id ).is_valid() ) {
            error = "Lua-first overmap terrain placeholder '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const region_terrain_furniture_registration &entry :
         pimpl_->region_terrain_furnitures ) {
        if( !region_terrain_furniture_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first region terrain furniture '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const forest_biome_component_registration &entry :
         pimpl_->forest_biome_components ) {
        if( !forest_biome_component_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first forest biome component '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const city_registration &entry : pimpl_->cities ) {
        if( !city_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first city '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const faction_mission_registration &entry : pimpl_->faction_missions ) {
        if( !faction_mission_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first faction mission '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const region_settings_city_registration &entry : pimpl_->region_settings_cities ) {
        if( !region_settings_city_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first region settings city '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const forest_biome_mapgen_registration &entry : pimpl_->forest_biome_mapgens ) {
        if( !forest_biome_mapgen_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first forest biome mapgen '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    pimpl_->finalization_validated = true;
    error.clear();
    return true;
}

void worldgen_content_transaction::rollback()
{
    for( auto it = pimpl_->omt_placeholder_undo.rbegin();
         it != pimpl_->omt_placeholder_undo.rend(); ++it ) {
        if( it->second ) {
            detail::omt_placeholder_registry().restore( *it->second );
        } else {
            detail::omt_placeholder_registry().erase( it->first );
        }
    }
    if( !pimpl_->omt_placeholder_undo.empty() ) {
        detail::omt_placeholder_registry().finalize();
    }
    pimpl_->omt_placeholder_undo.clear();

    for( auto it = pimpl_->dimension_undo.rbegin();
         it != pimpl_->dimension_undo.rend(); ++it ) {
        if( it->second ) {
            detail::dimension_registry().restore( *it->second );
        } else {
            detail::dimension_registry().erase( it->first );
        }
    }
    if( !pimpl_->dimension_undo.empty() ) {
        detail::dimension_registry().finalize();
    }
    pimpl_->dimension_undo.clear();

    for( auto it = pimpl_->dimension_region_layout_undo.rbegin();
         it != pimpl_->dimension_region_layout_undo.rend(); ++it ) {
        if( it->second ) {
            detail::dimension_region_layout_registry().restore( *it->second );
        } else {
            detail::dimension_region_layout_registry().erase( it->first );
        }
    }
    if( !pimpl_->dimension_region_layout_undo.empty() ) {
        detail::dimension_region_layout_registry().finalize();
    }
    pimpl_->dimension_region_layout_undo.clear();

    for( auto it = pimpl_->option_slider_undo.rbegin();
         it != pimpl_->option_slider_undo.rend(); ++it ) {
        if( it->second ) {
            detail::option_slider_registry().restore( *it->second );
        } else {
            detail::option_slider_registry().erase( it->first );
        }
    }
    if( !pimpl_->option_slider_undo.empty() ) {
        detail::option_slider_registry().finalize();
    }
    pimpl_->option_slider_undo.clear();

    for( auto it = pimpl_->region_settings_undo.rbegin();
         it != pimpl_->region_settings_undo.rend(); ++it ) {
        if( it->second ) {
            detail::region_settings_registry().restore( *it->second );
        } else {
            detail::region_settings_registry().erase( it->first );
        }
    }
    if( !pimpl_->region_settings_undo.empty() ) {
        detail::region_settings_registry().finalize();
    }
    pimpl_->region_settings_undo.clear();

    for( auto it = pimpl_->region_settings_ravine_undo.rbegin();
         it != pimpl_->region_settings_ravine_undo.rend(); ++it ) {
        if( it->second ) {
            detail::region_settings_ravine_registry().restore( *it->second );
        } else {
            detail::region_settings_ravine_registry().erase( it->first );
        }
    }
    if( !pimpl_->region_settings_ravine_undo.empty() ) {
        detail::region_settings_ravine_registry().finalize();
    }
    pimpl_->region_settings_ravine_undo.clear();

    for( auto it = pimpl_->region_settings_lake_undo.rbegin();
         it != pimpl_->region_settings_lake_undo.rend(); ++it ) {
        if( it->second ) {
            detail::region_settings_lake_registry().restore( *it->second );
        } else {
            detail::region_settings_lake_registry().erase( it->first );
        }
    }
    if( !pimpl_->region_settings_lake_undo.empty() ) {
        detail::region_settings_lake_registry().finalize();
    }
    pimpl_->region_settings_lake_undo.clear();

    for( auto it = pimpl_->region_settings_ocean_undo.rbegin();
         it != pimpl_->region_settings_ocean_undo.rend(); ++it ) {
        if( it->second ) {
            detail::region_settings_ocean_registry().restore( *it->second );
        } else {
            detail::region_settings_ocean_registry().erase( it->first );
        }
    }
    if( !pimpl_->region_settings_ocean_undo.empty() ) {
        detail::region_settings_ocean_registry().finalize();
    }
    pimpl_->region_settings_ocean_undo.clear();

    for( auto it = pimpl_->region_settings_forest_undo.rbegin();
         it != pimpl_->region_settings_forest_undo.rend(); ++it ) {
        if( it->second ) {
            detail::region_settings_forest_registry().restore( *it->second );
        } else {
            detail::region_settings_forest_registry().erase( it->first );
        }
    }
    if( !pimpl_->region_settings_forest_undo.empty() ) {
        detail::region_settings_forest_registry().finalize();
    }
    pimpl_->region_settings_forest_undo.clear();

    for( auto it = pimpl_->region_settings_river_undo.rbegin();
         it != pimpl_->region_settings_river_undo.rend(); ++it ) {
        if( it->second ) {
            detail::region_settings_river_registry().restore( *it->second );
        } else {
            detail::region_settings_river_registry().erase( it->first );
        }
    }
    if( !pimpl_->region_settings_river_undo.empty() ) {
        detail::region_settings_river_registry().finalize();
    }
    pimpl_->region_settings_river_undo.clear();

    for( auto it = pimpl_->region_settings_forest_mapgen_undo.rbegin();
         it != pimpl_->region_settings_forest_mapgen_undo.rend(); ++it ) {
        if( it->second ) {
            detail::region_settings_forest_mapgen_registry().restore( *it->second );
        } else {
            detail::region_settings_forest_mapgen_registry().erase( it->first );
        }
    }
    if( !pimpl_->region_settings_forest_mapgen_undo.empty() ) {
        detail::region_settings_forest_mapgen_registry().finalize();
    }
    pimpl_->region_settings_forest_mapgen_undo.clear();

    for( auto it = pimpl_->region_settings_map_extras_undo.rbegin();
         it != pimpl_->region_settings_map_extras_undo.rend(); ++it ) {
        if( it->second ) {
            detail::region_settings_map_extras_registry().restore( *it->second );
        } else {
            detail::region_settings_map_extras_registry().erase( it->first );
        }
    }
    if( !pimpl_->region_settings_map_extras_undo.empty() ) {
        detail::region_settings_map_extras_registry().finalize();
    }
    pimpl_->region_settings_map_extras_undo.clear();

    for( auto it = pimpl_->region_settings_terrain_furniture_undo.rbegin();
         it != pimpl_->region_settings_terrain_furniture_undo.rend(); ++it ) {
        if( it->second ) {
            detail::region_settings_terrain_furniture_registry().restore( *it->second );
        } else {
            detail::region_settings_terrain_furniture_registry().erase( it->first );
        }
    }
    if( !pimpl_->region_settings_terrain_furniture_undo.empty() ) {
        detail::region_settings_terrain_furniture_registry().finalize();
    }
    pimpl_->region_settings_terrain_furniture_undo.clear();

    for( auto it = pimpl_->region_settings_forest_trail_undo.rbegin();
         it != pimpl_->region_settings_forest_trail_undo.rend(); ++it ) {
        if( it->second ) {
            detail::region_settings_forest_trail_registry().restore( *it->second );
        } else {
            detail::region_settings_forest_trail_registry().erase( it->first );
        }
    }
    pimpl_->region_settings_forest_trail_undo.clear();

    for( auto it = pimpl_->region_settings_highway_undo.rbegin();
         it != pimpl_->region_settings_highway_undo.rend(); ++it ) {
        if( it->second ) {
            detail::region_settings_highway_registry().restore( *it->second );
        } else {
            detail::region_settings_highway_registry().erase( it->first );
        }
    }
    pimpl_->region_settings_highway_undo.clear();

    for( auto it = pimpl_->region_terrain_furniture_undo.rbegin();
         it != pimpl_->region_terrain_furniture_undo.rend(); ++it ) {
        if( it->second ) {
            detail::region_terrain_furniture_registry().restore( *it->second );
        } else {
            detail::region_terrain_furniture_registry().erase( it->first );
        }
    }
    if( !pimpl_->region_terrain_furniture_undo.empty() ) {
        detail::region_terrain_furniture_registry().finalize();
    }
    pimpl_->region_terrain_furniture_undo.clear();

    for( auto it = pimpl_->forest_biome_component_undo.rbegin();
         it != pimpl_->forest_biome_component_undo.rend(); ++it ) {
        if( it->second ) {
            detail::forest_biome_component_registry().restore( *it->second );
        } else {
            detail::forest_biome_component_registry().erase( it->first );
        }
    }
    if( !pimpl_->forest_biome_component_undo.empty() ) {
        detail::forest_biome_component_registry().finalize();
    }
    pimpl_->forest_biome_component_undo.clear();

    for( auto it = pimpl_->city_undo.rbegin();
         it != pimpl_->city_undo.rend(); ++it ) {
        if( it->second ) {
            detail::city_registry().restore( *it->second );
        } else {
            detail::city_registry().erase( it->first );
        }
    }
    if( !pimpl_->city_undo.empty() ) {
        detail::city_registry().finalize();
    }
    pimpl_->city_undo.clear();

    for( auto it = pimpl_->faction_mission_undo.rbegin();
         it != pimpl_->faction_mission_undo.rend(); ++it ) {
        if( it->second ) {
            detail::faction_mission_registry().restore( *it->second );
        } else {
            detail::faction_mission_registry().erase( it->first );
        }
    }
    if( !pimpl_->faction_mission_undo.empty() ) {
        detail::faction_mission_registry().finalize();
    }
    pimpl_->faction_mission_undo.clear();

    for( auto it = pimpl_->region_settings_city_undo.rbegin();
         it != pimpl_->region_settings_city_undo.rend(); ++it ) {
        if( it->second ) {
            detail::region_settings_city_registry().restore( *it->second );
        } else {
            detail::region_settings_city_registry().erase( it->first );
        }
    }
    pimpl_->region_settings_city_undo.clear();

    for( auto it = pimpl_->forest_biome_mapgen_undo.rbegin();
         it != pimpl_->forest_biome_mapgen_undo.rend(); ++it ) {
        if( it->second ) {
            detail::forest_biome_mapgen_registry().restore( *it->second );
        } else {
            detail::forest_biome_mapgen_registry().erase( it->first );
        }
    }
    if( !pimpl_->forest_biome_mapgen_undo.empty() ) {
        detail::forest_biome_mapgen_registry().finalize();
    }
    pimpl_->forest_biome_mapgen_undo.clear();
    pimpl_->applied = false;
    pimpl_->finalization_validated = false;
    pimpl_->token->lifecycle = handle_lifecycle::discarded;
}

void worldgen_content_transaction::append_fingerprint( std::uint64_t &state ) const
{
    for( const region_settings_ravine_registration &entry : pimpl_->region_settings_ravines ) {
        hash_part( state, "region_settings_ravine" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        hash_part( state, std::to_string( entry.definition->num_ravines ) );
        hash_part( state, std::to_string( entry.definition->ravine_range ) );
        hash_part( state, std::to_string( entry.definition->ravine_width ) );
        hash_part( state, std::to_string( entry.definition->ravine_depth ) );
    }
    for( const region_settings_lake_registration &entry : pimpl_->region_settings_lakes ) {
        hash_part( state, "region_settings_lake" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        hash_part( state, std::to_string( entry.definition->noise_threshold_lake ) );
        hash_part( state, std::to_string( entry.definition->lake_size_min ) );
        hash_part( state, std::to_string( entry.definition->lake_depth ) );
        hash_part( state, entry.definition->invert_lakes ? "invert" : "no_invert" );
        hash_part( state, entry.definition->surface );
        hash_part( state, entry.definition->shore );
        hash_part( state, entry.definition->interior );
        hash_part( state, entry.definition->bed );
        hash_part( state, "shore_extendable_overmap_terrain" );
        hash_part( state, std::to_string(
                       entry.definition->shore_extendable_overmap_terrain.size() ) );
        for( const std::string &oter : entry.definition->shore_extendable_overmap_terrain ) {
            hash_part( state, oter );
        }
        hash_part( state, "shore_extendable_overmap_terrain_aliases" );
        hash_part( state, std::to_string(
                       entry.definition->shore_extendable_overmap_terrain_aliases.size() ) );
        for( const region_settings_lake_alias_data &alias :
             entry.definition->shore_extendable_overmap_terrain_aliases ) {
            hash_part( state, alias.om_terrain );
            hash_part( state, alias.alias );
            hash_part( state, alias.match_type );
        }
    }
    for( const region_settings_ocean_registration &entry : pimpl_->region_settings_oceans ) {
        hash_part( state, "region_settings_ocean" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        hash_part( state, std::to_string( entry.definition->noise_threshold_ocean ) );
        hash_part( state, std::to_string( entry.definition->ocean_size_min ) );
        hash_part( state, std::to_string( entry.definition->ocean_depth ) );
        const auto hash_optional_distance = [&state]( const std::string_view name,
        const std::optional<std::int64_t> &value ) {
            hash_part( state, name );
            hash_part( state, value ? std::to_string( *value ) : "nil" );
        };
        hash_optional_distance( "ocean_start_north", entry.definition->ocean_start_north );
        hash_optional_distance( "ocean_start_east", entry.definition->ocean_start_east );
        hash_optional_distance( "ocean_start_west", entry.definition->ocean_start_west );
        hash_optional_distance( "ocean_start_south", entry.definition->ocean_start_south );
        hash_part( state, std::to_string( entry.definition->sandy_beach_width ) );
    }
    for( const region_settings_forest_registration &entry : pimpl_->region_settings_forests ) {
        hash_part( state, "region_settings_forest" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        hash_part( state, std::to_string( entry.definition->noise_threshold_forest ) );
        hash_part( state, std::to_string( entry.definition->noise_threshold_forest_thick ) );
        hash_part( state, std::to_string( entry.definition->noise_threshold_swamp_adjacent_water ) );
        hash_part( state, std::to_string( entry.definition->noise_threshold_swamp_isolated ) );
        hash_part( state, std::to_string( entry.definition->river_floodplain_buffer_distance_min ) );
        hash_part( state, std::to_string( entry.definition->river_floodplain_buffer_distance_max ) );
        hash_part( state, std::to_string( entry.definition->forest_threshold_limit ) );
        for( const float inc : entry.definition->forest_threshold_increase ) {
            hash_part( state, std::to_string( inc ) );
        }
    }
    for( const region_settings_river_registration &entry : pimpl_->region_settings_rivers ) {
        hash_part( state, "region_settings_river" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        hash_part( state, std::to_string( entry.definition->river_scale ) );
        hash_part( state, std::to_string( entry.definition->river_frequency ) );
        hash_part( state, std::to_string( entry.definition->river_branch_chance ) );
        hash_part( state, std::to_string( entry.definition->river_branch_remerge_chance ) );
        hash_part( state, std::to_string( entry.definition->river_branch_scale_decrease ) );
    }
    for( const region_settings_forest_mapgen_registration &entry :
         pimpl_->region_settings_forest_mapgens ) {
        hash_part( state, "region_settings_forest_mapgen" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        hash_part( state, "biomes" );
        hash_part( state, std::to_string( entry.definition->biomes.size() ) );
        for( const std::string &biome_id : entry.definition->biomes ) {
            hash_part( state, biome_id );
        }
    }
    for( const region_settings_map_extras_registration &entry : pimpl_->region_settings_map_extrases ) {
        hash_part( state, "region_settings_map_extras" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        hash_part( state, "extras" );
        hash_part( state, std::to_string( entry.definition->extras.size() ) );
        for( const std::string &extra_id : entry.definition->extras ) {
            hash_part( state, extra_id );
        }
    }
    for( const region_settings_terrain_furniture_registration &entry :
         pimpl_->region_settings_terrain_furnitures ) {
        hash_part( state, "region_settings_terrain_furniture" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        hash_part( state, "ter_furn" );
        hash_part( state, std::to_string( entry.definition->ter_furn.size() ) );
        for( const std::string &tf_id : entry.definition->ter_furn ) {
            hash_part( state, tf_id );
        }
    }
    for( const region_settings_forest_trail_registration &entry :
         pimpl_->region_settings_forest_trails ) {
        hash_part( state, "region_settings_forest_trail" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        hash_part( state, std::to_string( entry.definition->chance ) );
        hash_part( state, std::to_string( entry.definition->border_point_chance ) );
        hash_part( state, std::to_string( entry.definition->minimum_forest_size ) );
        hash_part( state, std::to_string( entry.definition->random_point_min ) );
        hash_part( state, std::to_string( entry.definition->random_point_max ) );
        hash_part( state, std::to_string( entry.definition->random_point_size_scalar ) );
        hash_part( state, std::to_string( entry.definition->trailhead_chance ) );
        hash_part( state, std::to_string( entry.definition->trailhead_road_distance ) );
        hash_part( state, "trailheads" );
        hash_part( state, std::to_string( entry.definition->trailheads.size() ) );
        for( const auto &[special, weight] : entry.definition->trailheads ) {
            hash_part( state, special );
            hash_part( state, std::to_string( weight ) );
        }
    }
    for( const region_settings_highway_registration &entry :
         pimpl_->region_settings_highways ) {
        hash_part( state, "region_settings_highway" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        hash_part( state, std::to_string( entry.definition->width_of_segments ) );
        hash_part( state, std::to_string( entry.definition->straightness_chance ) );
        hash_part( state, entry.definition->reserved_terrain_id );
        hash_part( state, entry.definition->reserved_terrain_water_id );
        hash_part( state, entry.definition->segment_flat_special );
        hash_part( state, entry.definition->segment_ramp_special );
        hash_part( state, entry.definition->segment_road_bridge_special );
        hash_part( state, entry.definition->segment_bridge_special );
        hash_part( state, entry.definition->segment_bridge_supports_special );
        hash_part( state, entry.definition->segment_overpass_special );
        hash_part( state, entry.definition->clockwise_slant_special );
        hash_part( state, entry.definition->counterclockwise_slant_special );
        hash_part( state, entry.definition->fallback_onramp_special );
        hash_part( state, entry.definition->fallback_bend_special );
        hash_part( state, entry.definition->fallback_three_way_intersection_special );
        hash_part( state, entry.definition->fallback_four_way_intersection_special );
        hash_part( state, entry.definition->fallback_supports );

        const auto hash_building_bin = [&]( const char *name,
        const std::vector<std::pair<std::string, std::int64_t>> &bin ) {
            hash_part( state, name );
            hash_part( state, std::to_string( bin.size() ) );
            for( const auto &[special, weight] : bin ) {
                hash_part( state, special );
                hash_part( state, std::to_string( weight ) );
            }
        };
        hash_building_bin( "four_way_intersections", entry.definition->four_way_intersections );
        hash_building_bin( "three_way_intersections", entry.definition->three_way_intersections );
        hash_building_bin( "bends", entry.definition->bends );
        hash_building_bin( "road_connections", entry.definition->road_connections );
        hash_building_bin( "interchanges", entry.definition->interchanges );
    }
    for( const region_settings_registration &entry : pimpl_->region_settings ) {
        const region_settings_definition_data &value = *entry.definition;
        hash_part( state, "region_settings" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, value.id );
        hash_part( state, "default_oter" );
        hash_part( state, std::to_string( value.default_oter.size() ) );
        for( const std::string &terrain : value.default_oter ) {
            hash_part( state, terrain );
        }
        hash_part( state, "default_groundcover" );
        hash_part( state, value.default_groundcover_set ? "set" : "default" );
        hash_part( state, std::to_string( value.default_groundcover.size() ) );
        for( const auto &[terrain, weight] : value.default_groundcover ) {
            hash_part( state, terrain );
            hash_part( state, std::to_string( weight ) );
        }
        hash_part( state, value.cities );
        hash_part( state, value.forest_composition );
        hash_part( state, value.forest_trails );
        hash_part( state, value.weather );
        hash_part( state, value.forests );
        hash_part( state, value.rivers );
        hash_part( state, value.lakes );
        hash_part( state, value.ocean );
        hash_part( state, value.highways );
        hash_part( state, value.ravines );
        hash_part( state, value.map_extras );
        hash_part( state, value.terrain_furniture );
        hash_part( state, "feature_blacklist" );
        hash_part( state, std::to_string( value.feature_blacklist.size() ) );
        for( const std::string &flag : value.feature_blacklist ) {
            hash_part( state, flag );
        }
        hash_part( state, "feature_whitelist" );
        hash_part( state, std::to_string( value.feature_whitelist.size() ) );
        for( const std::string &flag : value.feature_whitelist ) {
            hash_part( state, flag );
        }
        hash_part( state, value.trail_connection );
        hash_part( state, value.sewer_connection );
        hash_part( state, value.subway_connection );
        hash_part( state, value.rail_connection );
        hash_part( state, value.intra_city_road_connection );
        hash_part( state, value.inter_city_road_connection );
        hash_part( state, value.place_swamps ? "true" : "false" );
        hash_part( state, value.place_roads ? "true" : "false" );
        hash_part( state, value.place_railroads ? "true" : "false" );
        hash_part( state, value.place_railroads_before_roads ? "true" : "false" );
        hash_part( state, value.place_specials ? "true" : "false" );
        hash_part( state, value.neighbor_connections ? "true" : "false" );
        hash_part( state, std::to_string( value.max_urbanity ) );
        for( const float increase : value.urbanity_increase ) {
            hash_part( state, std::to_string( increase ) );
        }
    }
    for( const option_slider_registration &entry : pimpl_->option_sliders ) {
        const detail::option_slider_native_definition &value = *entry.definition;
        hash_part( state, "option_slider" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, value.id );
        hash_part( state, value.name );
        hash_part( state, value.context );
        hash_part( state, std::to_string( value.default_level ) );
        hash_part( state, std::to_string( value.levels.size() ) );
        for( const detail::option_slider_native_level &level : value.levels ) {
            hash_part( state, std::to_string( level.level ) );
            hash_part( state, level.name );
            hash_part( state, level.description );
            hash_part( state, std::to_string( level.options.size() ) );
            for( const detail::option_slider_native_option &option : level.options ) {
                hash_part( state, option.option );
                hash_part( state, option.type );
                hash_part( state, option.value );
            }
        }
    }
    for( const dimension_region_layout_registration &entry :
         pimpl_->dimension_region_layouts ) {
        hash_part( state, "dimension_region_layout" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        hash_part( state, entry.definition->generation_mode );
        hash_part( state, entry.definition->uniform_region );
    }
    for( const dimension_registration &entry : pimpl_->dimensions ) {
        hash_part( state, "dimension" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        hash_part( state, entry.definition->region_layout );
    }
    for( const omt_placeholder_registration &entry : pimpl_->omt_placeholders ) {
        hash_part( state, "omt_placeholder" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        hash_part( state, entry.definition->grid_set ? "set" : "unset" );
        for( const std::string &row : entry.definition->grid ) {
            hash_part( state, row );
        }
    }
    for( const region_terrain_furniture_registration &entry :
         pimpl_->region_terrain_furnitures ) {
        hash_part( state, "region_terrain_furniture" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        hash_part( state, entry.definition->ter_id );
        hash_part( state, entry.definition->furn_id );
        hash_part( state, "replace_with_terrain" );
        hash_part( state, std::to_string( entry.definition->replace_with_terrain.size() ) );
        for( const auto &[terrain, weight] : entry.definition->replace_with_terrain ) {
            hash_part( state, terrain );
            hash_part( state, std::to_string( weight ) );
        }
        hash_part( state, "replace_with_furniture" );
        hash_part( state, std::to_string( entry.definition->replace_with_furniture.size() ) );
        for( const auto &[furniture, weight] : entry.definition->replace_with_furniture ) {
            hash_part( state, furniture );
            hash_part( state, std::to_string( weight ) );
        }
    }
    for( const forest_biome_component_registration &entry :
         pimpl_->forest_biome_components ) {
        hash_part( state, "forest_biome_component" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        hash_part( state, std::to_string( entry.definition->chance ) );
        hash_part( state, std::to_string( entry.definition->sequence ) );
        hash_part( state, "types" );
        hash_part( state, std::to_string( entry.definition->types.size() ) );
        for( const auto &[type, weight] : entry.definition->types ) {
            hash_part( state, type );
            hash_part( state, std::to_string( weight ) );
        }
    }
    for( const city_registration &entry : pimpl_->cities ) {
        hash_part( state, "city" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        hash_part( state, std::to_string( entry.definition->database_id ) );
        hash_part( state, entry.definition->name );
        hash_part( state, std::to_string( entry.definition->population ) );
        hash_part( state, std::to_string( entry.definition->size ) );
        hash_part( state, std::to_string( entry.definition->pos_om_x ) );
        hash_part( state, std::to_string( entry.definition->pos_om_y ) );
        hash_part( state, std::to_string( entry.definition->pos_x ) );
        hash_part( state, std::to_string( entry.definition->pos_y ) );
    }
    for( const faction_mission_registration &entry : pimpl_->faction_missions ) {
        hash_part( state, "faction_mission" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        hash_part( state, entry.definition->name );
        hash_part( state, entry.definition->description );
        hash_part( state, entry.definition->skill );
        hash_part( state, entry.definition->difficulty );
        hash_part( state, entry.definition->risk );
        hash_part( state, entry.definition->activity );
        hash_part( state, entry.definition->time );
        hash_part( state, std::to_string( entry.definition->positions ) );
        hash_part( state, entry.definition->items_label );
        hash_part( state, "items_possibilities" );
        hash_part( state, std::to_string( entry.definition->items_possibilities.size() ) );
        for( const std::string &item : entry.definition->items_possibilities ) {
            hash_part( state, item );
        }
        hash_part( state, "effects" );
        hash_part( state, std::to_string( entry.definition->effects.size() ) );
        for( const std::string &eff : entry.definition->effects ) {
            hash_part( state, eff );
        }
        hash_part( state, entry.definition->footer );
    }
    for( const region_settings_city_registration &entry : pimpl_->region_settings_cities ) {
        hash_part( state, "region_settings_city" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        hash_part( state, entry.definition->is_megacity ? "true" : "false" );
        hash_part( state, std::to_string( entry.definition->city_size ) );
        hash_part( state, std::to_string( entry.definition->city_spacing ) );
        hash_part( state, std::to_string( entry.definition->shop_radius ) );
        hash_part( state, std::to_string( entry.definition->shop_sigma ) );
        hash_part( state, std::to_string( entry.definition->park_radius ) );
        hash_part( state, std::to_string( entry.definition->park_sigma ) );
        hash_part( state, entry.definition->name_snippet );
        hash_part( state, "houses" );
        hash_part( state, std::to_string( entry.definition->houses.size() ) );
        for( const auto &[special, weight] : entry.definition->houses ) {
            hash_part( state, special );
            hash_part( state, std::to_string( weight ) );
        }
        hash_part( state, "shops" );
        hash_part( state, std::to_string( entry.definition->shops.size() ) );
        for( const auto &[special, weight] : entry.definition->shops ) {
            hash_part( state, special );
            hash_part( state, std::to_string( weight ) );
        }
        hash_part( state, "parks" );
        hash_part( state, std::to_string( entry.definition->parks.size() ) );
        for( const auto &[special, weight] : entry.definition->parks ) {
            hash_part( state, special );
            hash_part( state, std::to_string( weight ) );
        }
    }
    for( const forest_biome_mapgen_registration &entry : pimpl_->forest_biome_mapgens ) {
        hash_part( state, "forest_biome_mapgen" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        hash_part( state, std::to_string( entry.definition->sparseness_adjacency_factor ) );
        hash_part( state, entry.definition->item_group );
        hash_part( state, std::to_string( entry.definition->item_group_chance ) );
        hash_part( state, std::to_string( entry.definition->item_spawn_iterations ) );
        hash_part( state, "terrains" );
        hash_part( state, std::to_string( entry.definition->terrains.size() ) );
        for( const std::string &terrain : entry.definition->terrains ) {
            hash_part( state, terrain );
        }
        hash_part( state, "components" );
        hash_part( state, std::to_string( entry.definition->components.size() ) );
        for( const std::string &component : entry.definition->components ) {
            hash_part( state, component );
        }
        hash_part( state, "groundcover" );
        hash_part( state, std::to_string( entry.definition->groundcover.size() ) );
        for( const auto &[ter, weight] : entry.definition->groundcover ) {
            hash_part( state, ter );
            hash_part( state, std::to_string( weight ) );
        }
        hash_part( state, "terrain_furniture" );
        hash_part( state, std::to_string( entry.definition->terrain_furniture.size() ) );
        for( const auto &tdf : entry.definition->terrain_furniture ) {
            hash_part( state, tdf.ter_id );
            hash_part( state, std::to_string( tdf.chance ) );
            hash_part( state, std::to_string( tdf.furniture.size() ) );
            for( const auto &[furn, weight] : tdf.furniture ) {
                hash_part( state, furn );
                hash_part( state, std::to_string( weight ) );
            }
        }
    }
}

void worldgen_content_transaction::commit()
{
    if( !pimpl_->applied ) {
        return;
    }
    pimpl_->region_settings_ravine_undo.clear();
    pimpl_->region_settings_lake_undo.clear();
    pimpl_->region_settings_ocean_undo.clear();
    pimpl_->region_settings_forest_undo.clear();
    pimpl_->region_settings_river_undo.clear();
    pimpl_->region_settings_forest_mapgen_undo.clear();
    pimpl_->region_settings_map_extras_undo.clear();
    pimpl_->region_settings_terrain_furniture_undo.clear();
    pimpl_->region_settings_forest_trail_undo.clear();
    pimpl_->region_settings_highway_undo.clear();
    pimpl_->region_settings_undo.clear();
    pimpl_->option_slider_undo.clear();
    pimpl_->dimension_region_layout_undo.clear();
    pimpl_->dimension_undo.clear();
    pimpl_->omt_placeholder_undo.clear();
    pimpl_->region_terrain_furniture_undo.clear();
    pimpl_->forest_biome_component_undo.clear();
    pimpl_->city_undo.clear();
    pimpl_->faction_mission_undo.clear();
    pimpl_->region_settings_city_undo.clear();
    pimpl_->forest_biome_mapgen_undo.clear();
    pimpl_->token->lifecycle = handle_lifecycle::committed;
}

void worldgen_content_transaction::seal()
{
    if( !pimpl_->applied ) {
        return;
    }
    if( pimpl_->token->lifecycle == handle_lifecycle::building ) {
        pimpl_->token->lifecycle = handle_lifecycle::committed;
    }
}

void worldgen_content_transaction::discard()
{
    rollback();
    pimpl_->token->lifecycle = handle_lifecycle::discarded;
}

} // namespace cata::lua_platform

#else

namespace cata::lua_platform
{

struct worldgen_content_transaction::impl {};

worldgen_content_transaction::worldgen_content_transaction( std::string, std::size_t ) :
    pimpl_( std::make_unique<impl>() )
{
}

worldgen_content_transaction::~worldgen_content_transaction() = default;

bool worldgen_content_transaction::validate( const worldgen_validation_index &, bool,
        std::string &error ) const
{
    error = "Lua-first Platform is not enabled in this build";
    return false;
}

bool worldgen_content_transaction::apply( std::string &error )
{
    error = "Lua-first Platform is not enabled in this build";
    return false;
}

bool worldgen_content_transaction::validate_finalized( std::string &error ) const
{
    error = "Lua-first Platform is not enabled in this build";
    return false;
}

void worldgen_content_transaction::rollback() {}
void worldgen_content_transaction::commit() {}
void worldgen_content_transaction::seal() {}
void worldgen_content_transaction::discard() {}
void worldgen_content_transaction::append_fingerprint( std::uint64_t & ) const {}

} // namespace cata::lua_platform

#endif
