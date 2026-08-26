#include "catalua_content_world.h"

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <algorithm>
#include <array>
#include <bitset>
#include <cmath>
#include <cstddef>
#include <cstdint>
#include <iterator>
#include <limits>
#include <map>
#include <optional>
#include <set>
#include <stdexcept>
#include <string>
#include <string_view>
#include <tuple>
#include <utility>
#include <vector>

#include "calendar.h"
#include "catacharset.h"
#include "catalua_content.h"
#include "catalua_runtime.h"
#include "color.h"
#include "coordinates.h"
#include "dialogue_chatbin.h"
#include "distribution.h"
#include "enum_conversions.h"
#include "faction.h"
#include "generic_factory.h"
#include "item_group.h"
#include "memory_fast.h"
#include "mod_manager.h"
#include "npc.h"
#include "npc_class.h"
#include "omdata.h"
#include "requirements.h"
#include "shop_cons_rate.h"
#include "translations.h"
#include "type_id.h"
#include "units.h"
#include "veh_type.h"
#include "vehicle_group.h"

namespace cata::lua
{

namespace
{

enum class lifecycle : int {
    building,
    committed,
    discarded
};

enum class operation : int {
    add,
    replace,
    edit
};

struct token {
    lifecycle state = lifecycle::building;
};

struct definition_base {
    std::string id;
    bool registered = false;
};

struct interval_data {
    int minimum = 0;
    int maximum = 0;
};

struct distribution_data {
    enum class kind : int {
        constant,
        random,
        dice,
        one_in,
        sum,
        multiply
    };
    kind type = kind::constant;
    double first = 0.0;
    double second = 0.0;
    double add = 0.0;
    std::vector<distribution_data> terms;
};

struct faction_epilogue_condition_data {
    std::string faction;
    std::optional<int> power_min;
    std::optional<int> power_max;
};

struct faction_epilogue_data_definition {
    std::string id;
    std::optional<int> power_min;
    std::optional<int> power_max;
    std::vector<faction_epilogue_condition_data> dynamic;
};

struct price_rule_data {
    std::string item;
    std::string group;
    std::string category;
    std::string message;
    double markup = 1.0;
    double premium = 1.0;
    std::optional<double> fixed_adjustment;
    std::optional<int> price;
    std::string condition_handler;
};

struct faction_data : definition_base {
    std::string name;
    std::string description;
    int likes = 0;
    int respects = 0;
    int trusts = 0;
    bool known = true;
    int size = 0;
    int power = 0;
    int wealth = 0;
    std::optional<bool> steal_persist;
    std::int64_t food_calories = 0;
    std::map<std::string, int> food_vitamins;
    bool consumes_food = false;
    bool lone_wolf = false;
    bool limited_area = false;
    std::string currency;
    std::string monster_faction = "human";
    std::vector<price_rule_data> price_rules;
    std::map<std::string, std::set<std::string>> relations;
    std::vector<faction_epilogue_data_definition> epilogues;
};

struct shop_group_data {
    std::string id;
    int trust = 0;
    bool strict = false;
    bool rigid = false;
    std::string refusal;
    std::string condition_handler;
};

struct npc_class_data : definition_base {
    std::string name;
    std::string job_description;
    bool common = true;
    double common_spawn_weight = 1.0;
    bool sells_belongings = true;
    std::string worn;
    std::string carry;
    std::string weapon;
    std::optional<std::string> bye_message;
    std::string traits = "EMPTY_GROUP";
    std::string consumption_rates;
    std::string blacklist;
    std::string whitelist;
    std::int64_t restock_minutes = 6 * 24 * 60;
    std::pair<int, int> work_hours = { 0, 24 };
    distribution_data strength;
    distribution_data dexterity;
    distribution_data intelligence;
    distribution_data perception;
    distribution_data aggression;
    distribution_data bravery;
    distribution_data collector;
    distribution_data altruism;
    std::map<std::string, distribution_data> mutation_rounds;
    std::map<std::string, distribution_data> skills;
    std::map<std::string, distribution_data> bonus_skills;
    std::map<std::string, int> spells;
    std::map<std::string, int> bionics;
    std::vector<std::string> proficiencies;
    std::vector<shop_group_data> shop_groups;
    std::vector<price_rule_data> price_rules;
};

struct npc_data : definition_base {
    std::string unique_name;
    std::string suffix;
    std::string temporary_suffix;
    std::string gender = "random";
    std::string npc_class;
    std::string faction;
    int attitude = 0;
    std::string mission = "NULL";
    std::string chat = "TALK_NONE";
    std::string stole_item_chat;
    std::vector<std::string> missions_offered;
    std::map<std::string, std::string> dialogue_topics;
    std::map<std::string, std::string> snippets;
    std::optional<int> age;
    std::optional<int> height;
    std::optional<int> strength;
    std::optional<int> dexterity;
    std::optional<int> intelligence;
    std::optional<int> perception;
    std::optional<std::array<int, 4>> personality;
    std::vector<std::string> death_eocs;
    std::string death_handler;
};

struct overmap_terrain_data : definition_base {
    std::string name;
    std::string symbol = "?";
    std::string color = "white";
    std::string see_cost = "none";
    std::string travel_cost = "other";
    std::string default_map_data = "full_omt";
    std::string vision_levels = "default";
    std::string land_use_code;
    std::string extras = "none";
    std::string connect_group;
    std::string entry_eoc;
    std::string exit_eoc;
    std::string entry_handler;
    std::string exit_handler;
    std::optional<std::string> uniform_terrain;
    std::vector<std::string> looks_like;
    std::vector<std::string> post_process_generators;
    int monster_density = 0;
    struct static_spawn_data {
        std::string group;
        interval_data population;
        int chance = 0;
    };
    std::optional<static_spawn_data> static_spawns;
    std::set<std::string> flags;
};

struct special_terrain_data {
    int x = 0;
    int y = 0;
    int z = 0;
    std::string terrain;
    std::set<std::string> locations;
    std::set<std::string> flags;
    std::optional<std::string> camp_owner;
    std::string camp_name;
};

struct special_connection_data {
    int x = 0;
    int y = 0;
    int z = 0;
    std::optional<std::array<int, 3>> from;
    std::string terrain;
    std::string connection;
    bool existing = false;
};

struct special_location_data {
    int x = 0;
    int y = 0;
    int z = 0;
    std::set<std::string> locations;
};

struct special_spawn_data {
    std::string group;
    interval_data population;
    interval_data radius;
};

struct special_join_data {
    std::string id;
    std::string opposite;
    std::set<std::string> into_locations;
};

struct special_terrain_join_data {
    std::string id;
    std::string type = "mandatory";
    std::set<std::string> alternatives;
};

struct mutable_special_terrain_data {
    std::string terrain;
    std::set<std::string> locations;
    std::map<std::string, special_terrain_join_data> joins;
    std::map<std::string, std::string> connections;
    std::optional<std::string> camp_owner;
    std::string camp_name;
};

struct integer_distribution_data {
    enum class kind : int {
        fixed,
        uniform,
        poisson,
        binomial
    };
    kind type = kind::fixed;
    int fixed = 0;
    interval_data bounds{ 0, std::numeric_limits<int>::max() };
    double parameter = 0.0;
    int trials = 0;
};

struct mutable_special_piece_data {
    std::string overmap;
    int x = 0;
    int y = 0;
    int z = 0;
    std::string rotation = "north";
};

struct mutable_special_rule_data {
    std::string name;
    std::vector<mutable_special_piece_data> pieces;
    std::optional<integer_distribution_data> maximum;
    std::optional<int> weight;
};

struct overmap_special_data : definition_base {
    std::string subtype = "fixed";
    std::string eoc;
    std::string condition_handler;
    std::string placement_handler;
    std::optional<special_spawn_data> spawns;
    std::vector<special_terrain_data> terrains;
    std::vector<special_connection_data> connections;
    std::vector<special_location_data> check_for_locations;
    std::vector<special_join_data> joins;
    std::map<std::string, mutable_special_terrain_data> mutable_terrains;
    std::string root;
    std::vector<std::vector<mutable_special_rule_data>> phases;
    std::set<std::string> default_locations;
    std::set<std::string> flags;
    interval_data city_size{ 0, std::numeric_limits<int>::max() };
    interval_data city_distance{ 0, std::numeric_limits<int>::max() };
    interval_data occurrences{ 0, 0 };
    int priority = 0;
    bool rotate = true;
};

struct vpart_variant_data {
    std::string id;
    std::string label;
    std::string symbols = "?";
    std::string broken_symbols = "?";
};

struct vpart_requirement_data {
    std::string id;
    int multiplier = 1;
    std::vector<std::pair<std::string, int>> using_requirements;
    int time_minutes = -1;
    std::map<std::string, int> skills;
};

struct vpart_pseudo_tool_data {
    std::string id;
    int hotkey = -1;
};

struct vpart_wheel_terrain_modifier_data {
    std::string flag;
    int move_override = 0;
    int move_penalty = 0;
};

struct vpart_wheel_data {
    float rolling_resistance = 1.0f;
    int contact_area = 1;
    float offroad_rating = 0.5f;
    std::vector<vpart_wheel_terrain_modifier_data> terrain_modifiers;
};

struct vpart_workbench_data {
    float multiplier = 1.0f;
    std::int64_t mass_grams = 0;
    std::int64_t volume_ml = 0;
};

struct vpart_terrain_transform_data {
    std::set<std::string> pre_flags;
    std::optional<std::string> post_terrain;
    std::optional<std::string> post_furniture;
    std::optional<std::string> post_field;
    int post_field_intensity = 0;
    std::int64_t post_field_age_seconds = 0;
};

struct vehicle_part_data : definition_base {
    std::string copy_from;
    std::optional<std::string> name;
    std::optional<std::string> description;
    std::optional<std::string> item;
    std::optional<std::string> remove_as;
    std::optional<std::string> location;
    std::optional<std::string> looks_like;
    std::optional<std::string> color;
    std::optional<std::string> broken_color;
    std::optional<std::string> fuel_type;
    std::optional<std::string> default_ammo;
    std::optional<int> durability;
    std::optional<int> size_ml;
    std::optional<int> folded_volume_ml;
    std::optional<int> damage_modifier;
    std::optional<int> power_watts;
    std::optional<int> epower_watts;
    std::optional<int> energy_consumption_watts;
    std::optional<float> balloon_height;
    std::optional<float> backfire_threshold;
    std::optional<int> backfire_frequency;
    std::optional<float> damaged_power_factor;
    std::optional<int> noise_factor;
    std::optional<int> m2c;
    std::optional<int> muscle_power_factor;
    std::optional<int> bonus;
    std::optional<std::array<int, 3>> light_color;
    std::optional<int> cargo_weight_modifier;
    std::optional<int> cargo_spoil_multiplier;
    std::optional<int> comfort;
    std::optional<double> floor_bedding_warmth_celsius;
    std::optional<double> bonus_fire_warmth_feet_celsius;
    std::optional<std::string> default_tint_color;
    std::optional<std::string> activatable_eoc;
    std::string activation_handler;
    std::optional<std::set<std::string>> categories;
    std::optional<std::set<std::string>> flags;
    std::optional<std::set<std::string>> emissions;
    std::optional<std::set<std::string>> exhaust;
    std::optional<std::vector<vpart_variant_data>> variants;
    std::optional<std::vector<std::pair<std::string, std::string>>> variant_bases;
    std::optional<std::vector<std::string>> enchantments;
    std::optional<std::map<std::string, int>> qualities;
    std::optional<std::vector<vpart_pseudo_tool_data>> pseudo_tools;
    std::vector<std::string> fuel_options;
    bool fuel_options_set = false;
    std::optional<std::set<std::string>> engine_exclusions;
    std::map<std::string, float> damage_reduction;
    bool damage_reduction_set = false;
    std::string breaks_into;
    std::optional<std::vector<std::string>> folding_tools;
    std::optional<std::vector<std::string>> unfolding_tools;
    std::optional<std::int64_t> folding_time_seconds;
    std::optional<std::int64_t> unfolding_time_seconds;
    std::optional<vpart_wheel_data> wheel;
    std::optional<int> rotor_diameter;
    std::optional<int> propeller_diameter;
    std::optional<int> ladder_length;
    std::optional<vpart_workbench_data> workbench;
    std::optional<std::set<std::string>> toolkit_allowed_tools;
    std::optional<vpart_terrain_transform_data> terrain_transform;
    vpart_requirement_data install;
    vpart_requirement_data removal;
    vpart_requirement_data repair;
    std::optional<std::set<std::string>> air_proficiencies;
    std::optional<std::set<std::string>> land_proficiencies;
    std::optional<std::map<std::string, int>> air_skills;
    std::optional<std::map<std::string, int>> land_skills;
};

struct vehicle_part_placement_data {
    int x = 0;
    int y = 0;
    std::string part;
    std::string variant;
    int with_ammo = 0;
    std::set<std::string> ammo_types;
    std::pair<int, int> ammo_quantity = { -1, -1 };
    std::string fuel;
    std::vector<std::string> tools;
};

struct vehicle_item_data {
    int x = 0;
    int y = 0;
    int chance = 0;
    int with_ammo = 0;
    int with_magazine = 0;
    std::vector<std::pair<std::string, std::string>> items;
    std::vector<std::string> groups;
};

struct vehicle_zone_data {
    int x = 0;
    int y = 0;
    std::string type;
    std::string name;
    std::string filter;
};

struct vehicle_data : definition_base {
    std::string copy_from;
    std::optional<std::string> name;
    std::string color_palette;
    bool color_palette_set = false;
    std::vector<vehicle_part_placement_data> parts;
    std::vector<vehicle_item_data> items;
    bool items_set = false;
    std::vector<vehicle_zone_data> zones;
    bool zones_set = false;
};

template<typename Definition>
struct definition_handle {
    std::shared_ptr<Definition> definition;
    std::shared_ptr<token> owner;

    std::string id() const {
        if( !owner || owner->state == lifecycle::discarded ) {
            throw std::runtime_error( "Platform content handle is no longer readable" );
        }
        return definition->id;
    }
};

template<typename Definition>
struct registration {
    operation op = operation::add;
    std::shared_ptr<Definition> definition;
};

template<typename T>
std::vector<T> read_dense_array( const sol::table &source, const char *description )
{
    if( source.size() > 8192 ) {
        throw std::invalid_argument( std::string( description ) + " is too large" );
    }
    std::vector<T> result;
    result.reserve( source.size() );
    for( std::size_t index = 1; index <= source.size(); ++index ) {
        const sol::object value = source.raw_get<sol::object>( index );
        if( !value.valid() || value.get_type() == sol::type::nil ) {
            throw std::invalid_argument( std::string( description ) + " must be a dense array" );
        }
        result.push_back( value.as<T>() );
    }
    return result;
}

template<typename T>
std::optional<T> read_optional( const sol::table &source, const char *key )
{
    const sol::optional<T> value = source.get<sol::optional<T>>( key );
    return value ? std::optional<T>( *value ) : std::nullopt;
}

std::set<std::string> read_string_set( const sol::optional<sol::table> &source,
                                       const char *description )
{
    if( !source ) {
        return {};
    }
    const std::vector<std::string> values = read_dense_array<std::string>( *source, description );
    return std::set<std::string>( values.begin(), values.end() );
}

std::vector<std::string> read_string_vector( const sol::optional<sol::table> &source,
        const char *description )
{
    return source ? read_dense_array<std::string>( *source, description ) :
           std::vector<std::string>();
}

price_rule_data read_price_rule( const sol::table &rule )
{
    price_rule_data result;
    result.item = rule.get_or( "item", std::string() );
    result.group = rule.get_or( "group", std::string() );
    result.category = rule.get_or( "category", std::string() );
    result.message = rule.get_or( "message", std::string() );
    result.markup = rule.get_or( "markup", 1.0 );
    result.premium = rule.get_or( "premium", 1.0 );
    result.fixed_adjustment = read_optional<double>( rule, "fixed_adjustment" );
    if( !result.fixed_adjustment ) {
        result.fixed_adjustment = read_optional<double>( rule, "fixed_adj" );
    }
    result.price = read_optional<int>( rule, "price" );
    result.condition_handler = rule.get_or(
                                   "when", rule.get_or(
                                       "condition", rule.get_or(
                                           "condition_handler", std::string() ) ) );
    if( !std::isfinite( result.markup ) || !std::isfinite( result.premium ) ||
        ( result.fixed_adjustment && !std::isfinite( *result.fixed_adjustment ) ) ) {
        throw std::invalid_argument( "price rule numeric values must be finite" );
    }
    return result;
}

std::array<int, 3> read_point( const sol::table &source, const char *description )
{
    const std::vector<int> values = read_dense_array<int>( source, description );
    if( values.size() != 3 ) {
        throw std::invalid_argument( std::string( description ) + " must have three integers" );
    }
    return { values[0], values[1], values[2] };
}

interval_data read_interval( const sol::optional<sol::table> &source,
                             interval_data fallback, const char *description )
{
    if( !source ) {
        return fallback;
    }
    const std::vector<int> values = read_dense_array<int>( *source, description );
    if( values.size() != 2 ) {
        throw std::invalid_argument( std::string( description ) + " must have two integers" );
    }
    int maximum = values[1];
    if( maximum < values[0] ) {
        if( maximum >= 0 ) {
            throw std::invalid_argument(
                std::string( description ) + " must be an ordered interval" );
        }
        maximum = std::numeric_limits<int>::max();
    }
    return { values[0], maximum };
}

integer_distribution_data read_integer_distribution( const sol::object &source,
        const char *description )
{
    integer_distribution_data result;
    if( source.get_type() == sol::type::number ) {
        if( !source.is<lua_Integer>() ) {
            throw std::invalid_argument( std::string( description ) +
                                         " fixed value must be an integer" );
        }
        result.fixed = source.as<int>();
        return result;
    }
    if( source.get_type() != sol::type::table ) {
        throw std::invalid_argument( std::string( description ) +
                                     " must be an integer or distribution table" );
    }
    const sol::table descriptor = source.as<sol::table>();
    const sol::object fixed = descriptor.raw_get<sol::object>( "fixed" );
    const sol::object uniform = descriptor.raw_get<sol::object>( "uniform" );
    const sol::object poisson = descriptor.raw_get<sol::object>( "poisson" );
    const sol::object binomial = descriptor.raw_get<sol::object>( "binomial" );
    const auto present = []( const sol::object &value ) {
        return value.valid() && value.get_type() != sol::type::nil;
    };
    const int alternatives = static_cast<int>( present( fixed ) ) +
                             static_cast<int>( present( uniform ) ) +
                             static_cast<int>( present( poisson ) ) +
                             static_cast<int>( present( binomial ) );
    if( alternatives != 1 ) {
        throw std::invalid_argument( std::string( description ) +
                                     " requires exactly one of fixed, uniform, poisson, or binomial" );
    }
    if( const sol::optional<sol::table> bounds =
            descriptor.get<sol::optional<sol::table>>( "bounds" ) ) {
        result.bounds = read_interval( bounds, result.bounds, description );
    }
    if( present( fixed ) ) {
        if( !fixed.is<lua_Integer>() ) {
            throw std::invalid_argument( std::string( description ) +
                                         " fixed value must be an integer" );
        }
        result.fixed = fixed.as<int>();
    } else if( present( uniform ) ) {
        if( uniform.get_type() != sol::type::table ) {
            throw std::invalid_argument( std::string( description ) +
                                         " uniform value must be a two-integer array" );
        }
        result.type = integer_distribution_data::kind::uniform;
        const sol::optional<sol::table> uniform_values = uniform.as<sol::table>();
        result.bounds = read_interval( uniform_values, result.bounds, description );
    } else if( present( poisson ) ) {
        result.type = integer_distribution_data::kind::poisson;
        result.parameter = poisson.as<double>();
        if( !std::isfinite( result.parameter ) || result.parameter <= 0.0 ) {
            throw std::invalid_argument( std::string( description ) +
                                         " poisson mean must be finite and positive" );
        }
    } else {
        if( binomial.get_type() != sol::type::table ) {
            throw std::invalid_argument( std::string( description ) +
                                         " binomial value must be { trials, probability }" );
        }
        const sol::table values = binomial.as<sol::table>();
        if( values.size() != 2 || !values.raw_get<sol::object>( 1 ).is<lua_Integer>() ) {
            throw std::invalid_argument( std::string( description ) +
                                         " binomial value must be { integer trials, probability }" );
        }
        result.type = integer_distribution_data::kind::binomial;
        result.trials = values.raw_get<int>( 1 );
        result.parameter = values.raw_get<double>( 2 );
        if( result.trials < 0 || !std::isfinite( result.parameter ) ||
            result.parameter < 0.0 || result.parameter > 1.0 ) {
            throw std::invalid_argument( std::string( description ) +
                                         " has invalid binomial parameters" );
        }
    }
    if( result.bounds.minimum < 0 || result.bounds.maximum < result.bounds.minimum ) {
        throw std::invalid_argument( std::string( description ) + " has invalid bounds" );
    }
    return result;
}

int_distribution make_integer_distribution( const integer_distribution_data &source )
{
    switch( source.type ) {
        case integer_distribution_data::kind::fixed:
            return int_distribution( source.fixed );
        case integer_distribution_data::kind::uniform:
            return int_distribution::uniform( source.bounds.minimum, source.bounds.maximum );
        case integer_distribution_data::kind::poisson:
            return int_distribution::poisson( source.parameter, source.bounds.minimum,
                                               source.bounds.maximum );
        case integer_distribution_data::kind::binomial:
            return int_distribution::binomial( source.trials, source.parameter,
                                                source.bounds.minimum, source.bounds.maximum );
    }
    throw std::invalid_argument( "unknown integer distribution type" );
}

cube_direction read_cube_direction( const std::string &value )
{
    static const std::map<std::string, cube_direction> directions = {
        { "north", cube_direction::north }, { "east", cube_direction::east },
        { "south", cube_direction::south }, { "west", cube_direction::west },
        { "above", cube_direction::above }, { "below", cube_direction::below }
    };
    const auto found = directions.find( value );
    if( found == directions.end() ) {
        throw std::invalid_argument( "unknown cube direction '" + value + "'" );
    }
    return found->second;
}

om_direction::type read_rotation( const std::string &value )
{
    static const std::map<std::string, om_direction::type> directions = {
        { "north", om_direction::type::north }, { "east", om_direction::type::east },
        { "south", om_direction::type::south }, { "west", om_direction::type::west }
    };
    const auto found = directions.find( value );
    if( found == directions.end() ) {
        throw std::invalid_argument( "unknown overmap rotation '" + value + "'" );
    }
    return found->second;
}

distribution_data read_distribution_object( const sol::object &source,
        const std::size_t depth )
{
    if( depth > 16 ) {
        throw std::invalid_argument( "distribution nesting exceeds 16 levels" );
    }
    distribution_data result;
    if( !source.valid() || source.get_type() == sol::type::nil ) {
        return result;
    }
    if( source.get_type() == sol::type::number ) {
        result.first = source.as<double>();
        if( !std::isfinite( result.first ) ) {
            throw std::invalid_argument( "distribution constant must be finite" );
        }
        return result;
    }
    if( source.get_type() != sol::type::table ) {
        throw std::invalid_argument( "distribution must be a number or table" );
    }
    const sol::table descriptor = source.as<sol::table>();
    result.add = descriptor.get_or( "add", 0.0 );
    if( !std::isfinite( result.add ) ) {
        throw std::invalid_argument( "distribution add must be finite" );
    }
    int alternatives = 0;
    for( const char *key : { "constant", "one_in", "rng", "dice", "sum", "mul" } ) {
        const sol::object value = descriptor.raw_get<sol::object>( key );
        alternatives += value.valid() && value.get_type() != sol::type::nil ? 1 : 0;
    }
    if( alternatives != 1 ) {
        throw std::invalid_argument(
            "distribution requires exactly one of constant, one_in, rng, dice, sum, or mul" );
    }
    if( const sol::optional<sol::table> random =
            descriptor.get<sol::optional<sol::table>>( "rng" ) ) {
        const std::vector<int> values = read_dense_array<int>( *random, "distribution rng" );
        if( values.size() != 2 ) {
            throw std::invalid_argument( "distribution rng must have two integers" );
        }
        result.type = distribution_data::kind::random;
        result.first = values[0];
        result.second = values[1];
    } else if( const sol::optional<sol::table> dice =
                   descriptor.get<sol::optional<sol::table>>( "dice" ) ) {
        const std::vector<int> values = read_dense_array<int>( *dice, "distribution dice" );
        if( values.size() != 2 ) {
            throw std::invalid_argument( "distribution dice must have two integers" );
        }
        result.type = distribution_data::kind::dice;
        result.first = values[0];
        result.second = values[1];
    } else if( const sol::optional<double> one_in =
                   descriptor.get<sol::optional<double>>( "one_in" ) ) {
        if( !std::isfinite( *one_in ) || *one_in <= 0.0 ) {
            throw std::invalid_argument( "distribution one_in must be finite and positive" );
        }
        result.type = distribution_data::kind::one_in;
        result.first = *one_in;
    } else if( const sol::optional<sol::table> sum =
                   descriptor.get<sol::optional<sol::table>>( "sum" ) ) {
        result.type = distribution_data::kind::sum;
        const std::size_t count = sum->size();
        if( count == 0 || count > 64 ) {
            throw std::invalid_argument( "distribution sum needs 1 to 64 terms" );
        }
        result.terms.reserve( count );
        for( std::size_t index = 1; index <= count; ++index ) {
            const sol::object term = sum->raw_get<sol::object>( index );
            if( !term.valid() || term.get_type() == sol::type::nil ) {
                throw std::invalid_argument( "distribution sum must be a dense array" );
            }
            result.terms.push_back( read_distribution_object( term, depth + 1 ) );
        }
    } else if( const sol::optional<sol::table> multiply =
                   descriptor.get<sol::optional<sol::table>>( "mul" ) ) {
        result.type = distribution_data::kind::multiply;
        const std::size_t count = multiply->size();
        if( count == 0 || count > 64 ) {
            throw std::invalid_argument( "distribution mul needs 1 to 64 terms" );
        }
        result.terms.reserve( count );
        for( std::size_t index = 1; index <= count; ++index ) {
            const sol::object term = multiply->raw_get<sol::object>( index );
            if( !term.valid() || term.get_type() == sol::type::nil ) {
                throw std::invalid_argument( "distribution mul must be a dense array" );
            }
            result.terms.push_back( read_distribution_object( term, depth + 1 ) );
        }
    } else {
        result.first = descriptor.get<double>( "constant" );
        if( !std::isfinite( result.first ) ) {
            throw std::invalid_argument( "distribution constant must be finite" );
        }
    }
    return result;
}

distribution_data read_distribution_member( const sol::table &source,
        const char *key )
{
    return read_distribution_object( source.raw_get<sol::object>( key ), 0 );
}

distribution make_distribution( const distribution_data &source )
{
    distribution result;
    switch( source.type ) {
        case distribution_data::kind::constant:
            result = distribution::constant( source.first );
            break;
        case distribution_data::kind::random:
            result = distribution::rng_roll( static_cast<int>( source.first ),
                                              static_cast<int>( source.second ) );
            break;
        case distribution_data::kind::dice:
            result = distribution::dice_roll( static_cast<int>( source.first ),
                                               static_cast<int>( source.second ) );
            break;
        case distribution_data::kind::one_in:
            result = distribution::one_in( static_cast<float>( source.first ) );
            break;
        case distribution_data::kind::sum:
        case distribution_data::kind::multiply:
            result = make_distribution( source.terms.front() );
            for( auto term = std::next( source.terms.begin() );
                 term != source.terms.end(); ++term ) {
                result = source.type == distribution_data::kind::sum ?
                         result + make_distribution( *term ) :
                         result * make_distribution( *term );
            }
            break;
    }
    return source.add == 0.0 ? result :
           result + distribution::constant( static_cast<float>( source.add ) );
}

template<typename Definition>
void require_definition_id( const Definition &definition, const char *kind )
{
    if( definition.id.empty() || definition.id.size() > 256 ||
        definition.id.find( '#' ) != std::string::npos ) {
        throw std::runtime_error( std::string( "invalid " ) + kind + " id '" +
                                  definition.id + "'" );
    }
}

template<typename Definition, typename Exists>
void validate_registrations( const std::vector<registration<Definition>> &entries,
                             const char *kind, bool check_engine_state, Exists exists )
{
    std::set<std::string> ids;
    for( const registration<Definition> &entry : entries ) {
        require_definition_id( *entry.definition, kind );
        if( !ids.insert( entry.definition->id ).second ) {
            throw std::runtime_error( std::string( kind ) + " '" + entry.definition->id +
                                      "' is registered more than once" );
        }
        if( !check_engine_state ) {
            continue;
        }
        const bool present = exists( entry.definition->id );
        if( entry.op == operation::add && present ) {
            throw std::runtime_error( std::string( "add would overwrite existing " ) + kind +
                                      " '" + entry.definition->id + "'" );
        }
        if( entry.op == operation::replace && !present ) {
            throw std::runtime_error( std::string( "replace requires existing " ) + kind +
                                      " '" + entry.definition->id + "'" );
        }
    }
}

void hash_part( std::uint64_t &state, const std::string_view value )
{
    for( const unsigned char byte : value ) {
        state ^= byte;
        state *= 1099511628211ULL;
    }
    state ^= 0xff;
    state *= 1099511628211ULL;
}

template<typename Value>
void hash_number( std::uint64_t &state, const Value value )
{
    hash_part( state, std::to_string( value ) );
}

void hash_bool( std::uint64_t &state, const bool value )
{
    hash_part( state, value ? "true" : "false" );
}

template<typename Value>
void hash_optional_number( std::uint64_t &state, const std::optional<Value> &value )
{
    hash_part( state, value ? "present" : "absent" );
    if( value ) {
        hash_number( state, *value );
    }
}

void hash_optional_string( std::uint64_t &state, const std::optional<std::string> &value )
{
    hash_part( state, value ? "present" : "absent" );
    if( value ) {
        hash_part( state, *value );
    }
}

template<typename Collection>
void hash_strings( std::uint64_t &state, const Collection &values )
{
    hash_number( state, values.size() );
    for( const std::string &value : values ) {
        hash_part( state, value );
    }
}

void hash_distribution( std::uint64_t &state, const distribution_data &value )
{
    hash_number( state, static_cast<int>( value.type ) );
    hash_number( state, value.first );
    hash_number( state, value.second );
    hash_number( state, value.add );
    hash_number( state, value.terms.size() );
    for( const distribution_data &term : value.terms ) {
        hash_distribution( state, term );
    }
}

void hash_integer_distribution( std::uint64_t &state,
                                const integer_distribution_data &value )
{
    hash_number( state, static_cast<int>( value.type ) );
    hash_number( state, value.fixed );
    hash_number( state, value.bounds.minimum );
    hash_number( state, value.bounds.maximum );
    hash_number( state, value.parameter );
    hash_number( state, value.trials );
}

void hash_interval( std::uint64_t &state, const interval_data &value )
{
    hash_number( state, value.minimum );
    hash_number( state, value.maximum );
}

void hash_definition( std::uint64_t &state, const faction_data &value )
{
    hash_part( state, value.id );
    hash_part( state, value.name );
    hash_part( state, value.description );
    hash_number( state, value.likes );
    hash_number( state, value.respects );
    hash_number( state, value.trusts );
    hash_bool( state, value.known );
    hash_number( state, value.size );
    hash_number( state, value.power );
    hash_number( state, value.wealth );
    hash_part( state, value.steal_persist ?
               ( *value.steal_persist ? "always" : "never" ) : "ask" );
    hash_number( state, value.food_calories );
    for( const auto &[vitamin, amount] : value.food_vitamins ) {
        hash_part( state, vitamin );
        hash_number( state, amount );
    }
    hash_bool( state, value.consumes_food );
    hash_bool( state, value.lone_wolf );
    hash_bool( state, value.limited_area );
    hash_part( state, value.currency );
    hash_part( state, value.monster_faction );
    for( const price_rule_data &rule : value.price_rules ) {
        hash_part( state, rule.item );
        hash_part( state, rule.group );
        hash_part( state, rule.category );
        hash_part( state, rule.message );
        hash_number( state, rule.markup );
        hash_number( state, rule.premium );
        hash_optional_number( state, rule.fixed_adjustment );
        hash_optional_number( state, rule.price );
        hash_part( state, rule.condition_handler );
    }
    for( const auto &[faction, flags] : value.relations ) {
        hash_part( state, faction );
        hash_strings( state, flags );
    }
    for( const faction_epilogue_data_definition &epilogue : value.epilogues ) {
        hash_part( state, epilogue.id );
        hash_optional_number( state, epilogue.power_min );
        hash_optional_number( state, epilogue.power_max );
        for( const faction_epilogue_condition_data &condition : epilogue.dynamic ) {
            hash_part( state, condition.faction );
            hash_optional_number( state, condition.power_min );
            hash_optional_number( state, condition.power_max );
        }
    }
}

void hash_definition( std::uint64_t &state, const npc_class_data &value )
{
    hash_part( state, value.id );
    hash_part( state, value.name );
    hash_part( state, value.job_description );
    hash_bool( state, value.common );
    hash_number( state, value.common_spawn_weight );
    hash_bool( state, value.sells_belongings );
    hash_part( state, value.worn );
    hash_part( state, value.carry );
    hash_part( state, value.weapon );
    hash_optional_string( state, value.bye_message );
    hash_part( state, value.traits );
    hash_part( state, value.consumption_rates );
    hash_part( state, value.blacklist );
    hash_part( state, value.whitelist );
    hash_number( state, value.restock_minutes );
    hash_number( state, value.work_hours.first );
    hash_number( state, value.work_hours.second );
    hash_distribution( state, value.strength );
    hash_distribution( state, value.dexterity );
    hash_distribution( state, value.intelligence );
    hash_distribution( state, value.perception );
    hash_distribution( state, value.aggression );
    hash_distribution( state, value.bravery );
    hash_distribution( state, value.collector );
    hash_distribution( state, value.altruism );
    for( const auto &[category, rounds] : value.mutation_rounds ) {
        hash_part( state, category );
        hash_distribution( state, rounds );
    }
    for( const auto &[skill, distribution] : value.skills ) {
        hash_part( state, skill );
        hash_distribution( state, distribution );
    }
    for( const auto &[skill, distribution] : value.bonus_skills ) {
        hash_part( state, skill );
        hash_distribution( state, distribution );
    }
    for( const auto &[spell, level] : value.spells ) {
        hash_part( state, spell );
        hash_number( state, level );
    }
    for( const auto &[bionic, chance] : value.bionics ) {
        hash_part( state, bionic );
        hash_number( state, chance );
    }
    hash_strings( state, value.proficiencies );
    for( const shop_group_data &group : value.shop_groups ) {
        hash_part( state, group.id );
        hash_number( state, group.trust );
        hash_bool( state, group.strict );
        hash_bool( state, group.rigid );
        hash_part( state, group.refusal );
        hash_part( state, group.condition_handler );
    }
    for( const price_rule_data &rule : value.price_rules ) {
        hash_part( state, rule.item );
        hash_part( state, rule.group );
        hash_part( state, rule.category );
        hash_part( state, rule.message );
        hash_number( state, rule.markup );
        hash_number( state, rule.premium );
        hash_optional_number( state, rule.fixed_adjustment );
        hash_optional_number( state, rule.price );
        hash_part( state, rule.condition_handler );
    }
}

void hash_definition( std::uint64_t &state, const npc_data &value )
{
    hash_part( state, value.id );
    hash_part( state, value.unique_name );
    hash_part( state, value.suffix );
    hash_part( state, value.temporary_suffix );
    hash_part( state, value.gender );
    hash_part( state, value.npc_class );
    hash_part( state, value.faction );
    hash_number( state, value.attitude );
    hash_part( state, value.mission );
    hash_part( state, value.chat );
    hash_part( state, value.stole_item_chat );
    hash_strings( state, value.missions_offered );
    for( const auto &[topic, id] : value.dialogue_topics ) {
        hash_part( state, topic );
        hash_part( state, id );
    }
    for( const auto &[name, text] : value.snippets ) {
        hash_part( state, name );
        hash_part( state, text );
    }
    hash_optional_number( state, value.age );
    hash_optional_number( state, value.height );
    hash_optional_number( state, value.strength );
    hash_optional_number( state, value.dexterity );
    hash_optional_number( state, value.intelligence );
    hash_optional_number( state, value.perception );
    hash_part( state, value.personality ? "present" : "absent" );
    if( value.personality ) {
        for( const int component : *value.personality ) {
            hash_number( state, component );
        }
    }
    hash_strings( state, value.death_eocs );
    hash_part( state, value.death_handler );
}

void hash_definition( std::uint64_t &state, const overmap_terrain_data &value )
{
    hash_part( state, value.id );
    hash_part( state, value.name );
    hash_part( state, value.symbol );
    hash_part( state, value.color );
    hash_part( state, value.see_cost );
    hash_part( state, value.travel_cost );
    hash_part( state, value.default_map_data );
    hash_part( state, value.vision_levels );
    hash_part( state, value.land_use_code );
    hash_part( state, value.extras );
    hash_part( state, value.connect_group );
    hash_part( state, value.entry_eoc );
    hash_part( state, value.exit_eoc );
    hash_part( state, value.entry_handler );
    hash_part( state, value.exit_handler );
    hash_optional_string( state, value.uniform_terrain );
    hash_strings( state, value.looks_like );
    hash_strings( state, value.post_process_generators );
    hash_number( state, value.monster_density );
    hash_part( state, value.static_spawns ? "present" : "absent" );
    if( value.static_spawns ) {
        hash_part( state, value.static_spawns->group );
        hash_interval( state, value.static_spawns->population );
        hash_number( state, value.static_spawns->chance );
    }
    hash_strings( state, value.flags );
}

void hash_definition( std::uint64_t &state, const overmap_special_data &value )
{
    hash_part( state, value.id );
    hash_part( state, value.subtype );
    hash_part( state, value.eoc );
    hash_part( state, value.condition_handler );
    hash_part( state, value.placement_handler );
    hash_part( state, value.spawns ? "present" : "absent" );
    if( value.spawns ) {
        hash_part( state, value.spawns->group );
        hash_interval( state, value.spawns->population );
        hash_interval( state, value.spawns->radius );
    }
    for( const special_terrain_data &terrain : value.terrains ) {
        hash_number( state, terrain.x );
        hash_number( state, terrain.y );
        hash_number( state, terrain.z );
        hash_part( state, terrain.terrain );
        hash_strings( state, terrain.locations );
        hash_strings( state, terrain.flags );
        hash_optional_string( state, terrain.camp_owner );
        hash_part( state, terrain.camp_name );
    }
    for( const special_connection_data &connection : value.connections ) {
        hash_number( state, connection.x );
        hash_number( state, connection.y );
        hash_number( state, connection.z );
        hash_part( state, connection.from ? "present" : "absent" );
        if( connection.from ) {
            for( const int coordinate : *connection.from ) {
                hash_number( state, coordinate );
            }
        }
        hash_part( state, connection.terrain );
        hash_part( state, connection.connection );
        hash_bool( state, connection.existing );
    }
    for( const special_location_data &location : value.check_for_locations ) {
        hash_number( state, location.x );
        hash_number( state, location.y );
        hash_number( state, location.z );
        hash_strings( state, location.locations );
    }
    for( const special_join_data &join : value.joins ) {
        hash_part( state, join.id );
        hash_part( state, join.opposite );
        hash_strings( state, join.into_locations );
    }
    for( const auto &[id, terrain] : value.mutable_terrains ) {
        hash_part( state, id );
        hash_part( state, terrain.terrain );
        hash_strings( state, terrain.locations );
        for( const auto &[direction, join] : terrain.joins ) {
            hash_part( state, direction );
            hash_part( state, join.id );
            hash_part( state, join.type );
            hash_strings( state, join.alternatives );
        }
        for( const auto &[direction, connection] : terrain.connections ) {
            hash_part( state, direction );
            hash_part( state, connection );
        }
        hash_optional_string( state, terrain.camp_owner );
        hash_part( state, terrain.camp_name );
    }
    hash_part( state, value.root );
    for( const std::vector<mutable_special_rule_data> &phase : value.phases ) {
        hash_number( state, phase.size() );
        for( const mutable_special_rule_data &rule : phase ) {
            hash_part( state, rule.name );
            hash_part( state, rule.maximum ? "present" : "absent" );
            if( rule.maximum ) {
                hash_integer_distribution( state, *rule.maximum );
            }
            hash_optional_number( state, rule.weight );
            for( const mutable_special_piece_data &piece : rule.pieces ) {
                hash_part( state, piece.overmap );
                hash_number( state, piece.x );
                hash_number( state, piece.y );
                hash_number( state, piece.z );
                hash_part( state, piece.rotation );
            }
        }
    }
    hash_strings( state, value.default_locations );
    hash_strings( state, value.flags );
    hash_interval( state, value.city_size );
    hash_interval( state, value.city_distance );
    hash_interval( state, value.occurrences );
    hash_number( state, value.priority );
    hash_bool( state, value.rotate );
}

void hash_vpart_requirement( std::uint64_t &state, const vpart_requirement_data &value )
{
    hash_part( state, value.id );
    hash_number( state, value.multiplier );
    for( const auto &[requirement, multiplier] : value.using_requirements ) {
        hash_part( state, requirement );
        hash_number( state, multiplier );
    }
    hash_number( state, value.time_minutes );
    for( const auto &[skill, level] : value.skills ) {
        hash_part( state, skill );
        hash_number( state, level );
    }
}

void hash_optional_strings( std::uint64_t &state,
                            const std::optional<std::set<std::string>> &value )
{
    hash_part( state, value ? "present" : "absent" );
    if( value ) {
        hash_strings( state, *value );
    }
}

void hash_definition( std::uint64_t &state, const vehicle_part_data &value )
{
    hash_part( state, value.id );
    hash_part( state, value.copy_from );
    hash_optional_string( state, value.name );
    hash_optional_string( state, value.description );
    hash_optional_string( state, value.item );
    hash_optional_string( state, value.remove_as );
    hash_optional_string( state, value.location );
    hash_optional_string( state, value.looks_like );
    hash_optional_string( state, value.color );
    hash_optional_string( state, value.broken_color );
    hash_optional_string( state, value.fuel_type );
    hash_optional_string( state, value.default_ammo );
    hash_optional_number( state, value.durability );
    hash_optional_number( state, value.size_ml );
    hash_optional_number( state, value.folded_volume_ml );
    hash_optional_number( state, value.damage_modifier );
    hash_optional_number( state, value.power_watts );
    hash_optional_number( state, value.epower_watts );
    hash_optional_number( state, value.energy_consumption_watts );
    hash_optional_number( state, value.balloon_height );
    hash_optional_number( state, value.backfire_threshold );
    hash_optional_number( state, value.backfire_frequency );
    hash_optional_number( state, value.damaged_power_factor );
    hash_optional_number( state, value.noise_factor );
    hash_optional_number( state, value.m2c );
    hash_optional_number( state, value.muscle_power_factor );
    hash_optional_number( state, value.bonus );
    hash_part( state, value.light_color ? "present" : "absent" );
    if( value.light_color ) {
        for( const int channel : *value.light_color ) {
            hash_number( state, channel );
        }
    }
    hash_optional_number( state, value.cargo_weight_modifier );
    hash_optional_number( state, value.cargo_spoil_multiplier );
    hash_optional_number( state, value.comfort );
    hash_optional_number( state, value.floor_bedding_warmth_celsius );
    hash_optional_number( state, value.bonus_fire_warmth_feet_celsius );
    hash_optional_string( state, value.default_tint_color );
    hash_optional_string( state, value.activatable_eoc );
    hash_part( state, value.activation_handler );
    hash_optional_strings( state, value.categories );
    hash_optional_strings( state, value.flags );
    hash_optional_strings( state, value.emissions );
    hash_optional_strings( state, value.exhaust );
    hash_part( state, value.variants ? "present" : "absent" );
    if( value.variants ) {
        for( const vpart_variant_data &variant : *value.variants ) {
            hash_part( state, variant.id );
            hash_part( state, variant.label );
            hash_part( state, variant.symbols );
            hash_part( state, variant.broken_symbols );
        }
    }
    hash_part( state, value.variant_bases ? "present" : "absent" );
    if( value.variant_bases ) {
        for( const auto &[id, label] : *value.variant_bases ) {
            hash_part( state, id );
            hash_part( state, label );
        }
    }
    hash_part( state, value.enchantments ? "present" : "absent" );
    if( value.enchantments ) {
        hash_strings( state, *value.enchantments );
    }
    hash_part( state, value.qualities ? "present" : "absent" );
    if( value.qualities ) {
        for( const auto &[quality, level] : *value.qualities ) {
            hash_part( state, quality );
            hash_number( state, level );
        }
    }
    hash_part( state, value.pseudo_tools ? "present" : "absent" );
    if( value.pseudo_tools ) {
        for( const vpart_pseudo_tool_data &tool : *value.pseudo_tools ) {
            hash_part( state, tool.id );
            hash_number( state, tool.hotkey );
        }
    }
    hash_bool( state, value.fuel_options_set );
    hash_strings( state, value.fuel_options );
    hash_optional_strings( state, value.engine_exclusions );
    hash_bool( state, value.damage_reduction_set );
    for( const auto &[damage, amount] : value.damage_reduction ) {
        hash_part( state, damage );
        hash_number( state, amount );
    }
    hash_part( state, value.breaks_into );
    hash_part( state, value.folding_tools ? "present" : "absent" );
    if( value.folding_tools ) {
        hash_strings( state, *value.folding_tools );
    }
    hash_part( state, value.unfolding_tools ? "present" : "absent" );
    if( value.unfolding_tools ) {
        hash_strings( state, *value.unfolding_tools );
    }
    hash_optional_number( state, value.folding_time_seconds );
    hash_optional_number( state, value.unfolding_time_seconds );
    hash_part( state, value.wheel ? "present" : "absent" );
    if( value.wheel ) {
        hash_number( state, value.wheel->rolling_resistance );
        hash_number( state, value.wheel->contact_area );
        hash_number( state, value.wheel->offroad_rating );
        for( const vpart_wheel_terrain_modifier_data &modifier :
             value.wheel->terrain_modifiers ) {
            hash_part( state, modifier.flag );
            hash_number( state, modifier.move_override );
            hash_number( state, modifier.move_penalty );
        }
    }
    hash_optional_number( state, value.rotor_diameter );
    hash_optional_number( state, value.propeller_diameter );
    hash_optional_number( state, value.ladder_length );
    hash_part( state, value.workbench ? "present" : "absent" );
    if( value.workbench ) {
        hash_number( state, value.workbench->multiplier );
        hash_number( state, value.workbench->mass_grams );
        hash_number( state, value.workbench->volume_ml );
    }
    hash_optional_strings( state, value.toolkit_allowed_tools );
    hash_part( state, value.terrain_transform ? "present" : "absent" );
    if( value.terrain_transform ) {
        hash_strings( state, value.terrain_transform->pre_flags );
        hash_optional_string( state, value.terrain_transform->post_terrain );
        hash_optional_string( state, value.terrain_transform->post_furniture );
        hash_optional_string( state, value.terrain_transform->post_field );
        hash_number( state, value.terrain_transform->post_field_intensity );
        hash_number( state, value.terrain_transform->post_field_age_seconds );
    }
    hash_vpart_requirement( state, value.install );
    hash_vpart_requirement( state, value.removal );
    hash_vpart_requirement( state, value.repair );
    hash_optional_strings( state, value.air_proficiencies );
    hash_optional_strings( state, value.land_proficiencies );
    hash_part( state, value.air_skills ? "present" : "absent" );
    if( value.air_skills ) {
        for( const auto &[skill, level] : *value.air_skills ) {
            hash_part( state, skill );
            hash_number( state, level );
        }
    }
    hash_part( state, value.land_skills ? "present" : "absent" );
    if( value.land_skills ) {
        for( const auto &[skill, level] : *value.land_skills ) {
            hash_part( state, skill );
            hash_number( state, level );
        }
    }
}

void hash_definition( std::uint64_t &state, const vehicle_data &value )
{
    hash_part( state, value.id );
    hash_part( state, value.copy_from );
    hash_optional_string( state, value.name );
    hash_bool( state, value.color_palette_set );
    hash_part( state, value.color_palette );
    for( const vehicle_part_placement_data &part : value.parts ) {
        hash_number( state, part.x );
        hash_number( state, part.y );
        hash_part( state, part.part );
        hash_part( state, part.variant );
        hash_number( state, part.with_ammo );
        hash_strings( state, part.ammo_types );
        hash_number( state, part.ammo_quantity.first );
        hash_number( state, part.ammo_quantity.second );
        hash_part( state, part.fuel );
        hash_strings( state, part.tools );
    }
    for( const vehicle_item_data &item : value.items ) {
        hash_number( state, item.x );
        hash_number( state, item.y );
        hash_number( state, item.chance );
        hash_number( state, item.with_ammo );
        hash_number( state, item.with_magazine );
        for( const auto &[id, variant] : item.items ) {
            hash_part( state, id );
            hash_part( state, variant );
        }
        hash_strings( state, item.groups );
    }
    hash_bool( state, value.items_set );
    for( const vehicle_zone_data &zone : value.zones ) {
        hash_number( state, zone.x );
        hash_number( state, zone.y );
        hash_part( state, zone.type );
        hash_part( state, zone.name );
        hash_part( state, zone.filter );
    }
    hash_bool( state, value.zones_set );
}

template<typename Definition>
void hash_registrations( std::uint64_t &state, const char *kind,
                         const std::vector<registration<Definition>> &entries )
{
    for( const registration<Definition> &entry : entries ) {
        hash_part( state, kind );
        hash_part( state, std::to_string( static_cast<int>( entry.op ) ) );
        hash_definition( state, *entry.definition );
    }
}

std::array<char32_t, 8> read_variant_symbols( const std::string &source,
        const std::string &part_id )
{
    const std::vector<std::string> symbols = utf8_display_split( source );
    std::array<char32_t, 8> result;
    if( symbols.size() == 1 ) {
        result.fill( UTF8_getch( symbols.front() ) );
        return result;
    }
    if( symbols.size() != result.size() ) {
        throw std::runtime_error( "vehicle part '" + part_id +
                                  "' variant symbols need one or eight characters" );
    }
    for( std::size_t index = 0; index < result.size(); ++index ) {
        result[index] = UTF8_getch( symbols[index] );
    }
    return result;
}

void set_npc_dialogue_topic( dialogue_chatbin &chat, const std::string &name,
                             const std::string &topic )
{
    static const std::map<std::string, std::string dialogue_chatbin::*> fields = {
        { "talk_radio", &dialogue_chatbin::talk_radio },
        { "talk_leader", &dialogue_chatbin::talk_leader },
        { "talk_friend", &dialogue_chatbin::talk_friend },
        { "talk_stole_item", &dialogue_chatbin::talk_stole_item },
        { "talk_wake_up", &dialogue_chatbin::talk_wake_up },
        { "talk_mug", &dialogue_chatbin::talk_mug },
        { "talk_stranger_aggressive", &dialogue_chatbin::talk_stranger_aggressive },
        { "talk_stranger_scared", &dialogue_chatbin::talk_stranger_scared },
        { "talk_stranger_wary", &dialogue_chatbin::talk_stranger_wary },
        { "talk_stranger_friendly", &dialogue_chatbin::talk_stranger_friendly },
        { "talk_stranger_neutral", &dialogue_chatbin::talk_stranger_neutral },
        { "talk_friend_guard", &dialogue_chatbin::talk_friend_guard },
        { "talk_mission_inquire", &dialogue_chatbin::talk_mission_inquire },
        { "talk_mission_describe_urgent", &dialogue_chatbin::talk_mission_describe_urgent }
    };
    const auto found = fields.find( name );
    if( found == fields.end() ) {
        throw std::runtime_error( "unknown NPC dialogue topic slot '" + name + "'" );
    }
    chat.*found->second = topic;
}

void set_npc_snippet( dialogue_chatbin_snippets &snippets,
                      const std::string &name, const std::string &text )
{
    static const std::map<std::string, translation dialogue_chatbin_snippets::*> fields = {
        { "<acknowledged>", &dialogue_chatbin_snippets::snip_acknowledged },
        { "<camp_food_thanks>", &dialogue_chatbin_snippets::snip_camp_food_thanks },
        { "<camp_larder_empty>", &dialogue_chatbin_snippets::snip_camp_larder_empty },
        { "<camp_water_thanks>", &dialogue_chatbin_snippets::snip_camp_water_thanks },
        { "<cant_flee>", &dialogue_chatbin_snippets::snip_cant_flee },
        { "<close_distance>", &dialogue_chatbin_snippets::snip_close_distance },
        { "<combat_noise_warning>", &dialogue_chatbin_snippets::snip_combat_noise_warning },
        { "<danger_close_distance>", &dialogue_chatbin_snippets::snip_danger_close_distance },
        { "<done_mugging>", &dialogue_chatbin_snippets::snip_done_mugging },
        { "<far_distance>", &dialogue_chatbin_snippets::snip_far_distance },
        { "<fire_bad>", &dialogue_chatbin_snippets::snip_fire_bad },
        { "<fire_in_the_hole_h>", &dialogue_chatbin_snippets::snip_fire_in_the_hole_h },
        { "<fire_in_the_hole>", &dialogue_chatbin_snippets::snip_fire_in_the_hole },
        { "<general_danger_h>", &dialogue_chatbin_snippets::snip_general_danger_h },
        { "<general_danger>", &dialogue_chatbin_snippets::snip_general_danger },
        { "<heal_self>", &dialogue_chatbin_snippets::snip_heal_self },
        { "<hungry>", &dialogue_chatbin_snippets::snip_hungry },
        { "<im_leaving_you>", &dialogue_chatbin_snippets::snip_im_leaving_you },
        { "<its_safe_h>", &dialogue_chatbin_snippets::snip_its_safe_h },
        { "<its_safe>", &dialogue_chatbin_snippets::snip_its_safe },
        { "<keep_up>", &dialogue_chatbin_snippets::snip_keep_up },
        { "<kill_npc_h>", &dialogue_chatbin_snippets::snip_kill_npc_h },
        { "<kill_npc>", &dialogue_chatbin_snippets::snip_kill_npc },
        { "<kill_player_h>", &dialogue_chatbin_snippets::snip_kill_player_h },
        { "<let_me_pass>", &dialogue_chatbin_snippets::snip_let_me_pass },
        { "<lets_talk>", &dialogue_chatbin_snippets::snip_lets_talk },
        { "<medium_distance>", &dialogue_chatbin_snippets::snip_medium_distance },
        { "<monster_warning_h>", &dialogue_chatbin_snippets::snip_monster_warning_h },
        { "<monster_warning>", &dialogue_chatbin_snippets::snip_monster_warning },
        { "<movement_noise_warning>", &dialogue_chatbin_snippets::snip_movement_noise_warning },
        { "<need_batteries>", &dialogue_chatbin_snippets::snip_need_batteries },
        { "<need_booze>", &dialogue_chatbin_snippets::snip_need_booze },
        { "<need_fuel>", &dialogue_chatbin_snippets::snip_need_fuel },
        { "<no_to_thorazine>", &dialogue_chatbin_snippets::snip_no_to_thorazine },
        { "<run_away>", &dialogue_chatbin_snippets::snip_run_away },
        { "<speech_warning>", &dialogue_chatbin_snippets::snip_speech_warning },
        { "<thirsty>", &dialogue_chatbin_snippets::snip_thirsty },
        { "<wait>", &dialogue_chatbin_snippets::snip_wait },
        { "<warn_sleep>", &dialogue_chatbin_snippets::snip_warn_sleep },
        { "<yawn>", &dialogue_chatbin_snippets::snip_yawn },
        { "<yes_to_lsd>", &dialogue_chatbin_snippets::snip_yes_to_lsd },
        { "snip_pulp_zombie", &dialogue_chatbin_snippets::snip_pulp_zombie },
        { "snip_heal_player", &dialogue_chatbin_snippets::snip_heal_player },
        { "snip_mug_dontmove", &dialogue_chatbin_snippets::snip_mug_dontmove },
        { "snip_wound_infected", &dialogue_chatbin_snippets::snip_wound_infected },
        { "snip_wound_bite", &dialogue_chatbin_snippets::snip_wound_bite },
        { "snip_radiation_sickness", &dialogue_chatbin_snippets::snip_radiation_sickness },
        { "snip_bleeding", &dialogue_chatbin_snippets::snip_bleeding },
        { "snip_bleeding_badly", &dialogue_chatbin_snippets::snip_bleeding_badly },
        { "snip_lost_blood", &dialogue_chatbin_snippets::snip_lost_blood },
        { "snip_bye", &dialogue_chatbin_snippets::snip_bye },
        { "snip_consume_cant_accept", &dialogue_chatbin_snippets::snip_consume_cant_accept },
        { "snip_consume_cant_consume", &dialogue_chatbin_snippets::snip_consume_cant_consume },
        { "snip_consume_rotten", &dialogue_chatbin_snippets::snip_consume_rotten },
        { "snip_consume_eat", &dialogue_chatbin_snippets::snip_consume_eat },
        { "snip_consume_need_item", &dialogue_chatbin_snippets::snip_consume_need_item },
        { "snip_consume_med", &dialogue_chatbin_snippets::snip_consume_med },
        { "snip_consume_nocharge", &dialogue_chatbin_snippets::snip_consume_nocharge },
        { "snip_consume_use_med", &dialogue_chatbin_snippets::snip_consume_use_med },
        { "snip_give_nope", &dialogue_chatbin_snippets::snip_give_nope },
        { "snip_give_to_hallucination", &dialogue_chatbin_snippets::snip_give_to_hallucination },
        { "snip_give_cancel", &dialogue_chatbin_snippets::snip_give_cancel },
        { "snip_give_dangerous", &dialogue_chatbin_snippets::snip_give_dangerous },
        { "snip_give_wield", &dialogue_chatbin_snippets::snip_give_wield },
        { "snip_give_weapon_weak", &dialogue_chatbin_snippets::snip_give_weapon_weak },
        { "snip_give_carry", &dialogue_chatbin_snippets::snip_give_carry },
        { "snip_give_carry_cant", &dialogue_chatbin_snippets::snip_give_carry_cant },
        { "snip_give_carry_cant_few_space", &dialogue_chatbin_snippets::snip_give_carry_cant_few_space },
        { "snip_give_carry_cant_no_space", &dialogue_chatbin_snippets::snip_give_carry_cant_no_space },
        { "snip_give_carry_too_heavy", &dialogue_chatbin_snippets::snip_give_carry_too_heavy },
        { "snip_wear", &dialogue_chatbin_snippets::snip_wear }
    };
    const auto found = fields.find( name );
    if( found == fields.end() ) {
        throw std::runtime_error( "unknown NPC snippet slot '" + name + "'" );
    }
    snippets.*found->second = no_translation( text );
}

} // namespace

struct world_content_transaction::impl {
    impl( std::string owner_id, std::size_t owner_generation ) :
        owner( std::move( owner_id ) ), generation( owner_generation ),
        handle_token( std::make_shared<token>() ) {}

    std::string owner;
    std::size_t generation = 0;
    std::shared_ptr<token> handle_token;
    bool applied = false;

    std::vector<registration<faction_data>> factions;
    std::vector<registration<npc_class_data>> npc_classes;
    std::vector<registration<npc_data>> npcs;
    std::vector<registration<overmap_terrain_data>> overmap_terrains;
    std::vector<registration<overmap_special_data>> overmap_specials;
    std::vector<registration<vehicle_part_data>> vehicle_parts;
    std::vector<registration<vehicle_data>> vehicles;

    std::vector<std::pair<faction_id, std::optional<faction_template>>> faction_undo;
    std::vector<std::pair<npc_class_id, std::optional<npc_class>>> npc_class_undo;
    std::vector<std::pair<npc_template_id,
        std::map<npc_template_id, npc_template>::node_type>> npc_undo;
    struct overmap_terrain_undo_data {
        oter_type_str_id id;
        std::optional<oter_type_t> previous;
        std::vector<oter_id> generated;
    };
    std::vector<overmap_terrain_undo_data> overmap_terrain_undo;
    std::vector<std::pair<overmap_special_id, std::optional<overmap_special>>>
    overmap_special_undo;
    std::vector<std::pair<vpart_id, std::optional<vpart_info>>> vehicle_part_undo;
    std::vector<std::pair<vproto_id, std::optional<vehicle_prototype>>> vehicle_undo;
    std::vector<std::pair<std::string, std::optional<VehicleGroup>>>
    vehicle_self_group_undo;
};

world_content_transaction::world_content_transaction( std::string owner,
        const std::size_t generation ) :
    pimpl_( std::make_unique<impl>( std::move( owner ), generation ) )
{
}

world_content_transaction::~world_content_transaction() = default;

void world_content_transaction::install_lua_api( sol::state &lua, sol::table &ccb,
        sol::table &content )
{
    using faction_handle = definition_handle<faction_data>;
    using npc_class_handle = definition_handle<npc_class_data>;
    using npc_handle = definition_handle<npc_data>;
    using omt_handle = definition_handle<overmap_terrain_data>;
    using special_handle = definition_handle<overmap_special_data>;
    using vpart_handle = definition_handle<vehicle_part_data>;
    using vehicle_handle = definition_handle<vehicle_data>;

    ccb.new_usertype<faction_handle>( "FactionDefinition", sol::no_constructor,
                                     "id", sol::property( &faction_handle::id ) );
    ccb.new_usertype<npc_class_handle>( "NpcClassDefinition", sol::no_constructor,
                                       "id", sol::property( &npc_class_handle::id ) );
    ccb.new_usertype<npc_handle>( "NpcDefinition", sol::no_constructor,
                                 "id", sol::property( &npc_handle::id ) );
    ccb.new_usertype<omt_handle>( "OvermapTerrainDefinition", sol::no_constructor,
                                 "id", sol::property( &omt_handle::id ) );
    ccb.new_usertype<special_handle>( "OvermapSpecialDefinition", sol::no_constructor,
                                     "id", sol::property( &special_handle::id ) );
    ccb.new_usertype<vpart_handle>( "VehiclePartDefinition", sol::no_constructor,
                                   "id", sol::property( &vpart_handle::id ) );
    ccb.new_usertype<vehicle_handle>( "VehicleDefinition", sol::no_constructor,
                                     "id", sol::property( &vehicle_handle::id ) );

    const std::shared_ptr<token> owner = pimpl_->handle_token;
    content.set_function( "Faction", [owner]( const sol::table &options ) {
        if( owner->state != lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto value = std::make_shared<faction_data>();
        value->id = options.get_or( "id", std::string() );
        value->name = options.get_or( "name", value->id );
        value->description = options.get_or( "description", std::string() );
        value->likes = options.get_or( "likes", 0 );
        value->respects = options.get_or( "respects", 0 );
        value->trusts = options.get_or( "trusts", 0 );
        value->known = options.get_or( "known", true );
        value->size = options.get_or( "size", 0 );
        value->power = options.get_or( "power", 0 );
        value->wealth = options.get_or( "wealth", 0 );
        value->steal_persist = read_optional<bool>( options, "steal_persist" );
        value->food_calories = options.get_or<std::int64_t>( "food_calories", 0 );
        if( const sol::optional<sol::table> vitamins =
                options.get<sol::optional<sol::table>>( "food_vitamins" ) ) {
            for( const auto &entry : *vitamins ) {
                value->food_vitamins[entry.first.as<std::string>()] =
                    entry.second.as<int>();
            }
        }
        value->consumes_food = options.get_or( "consumes_food", false );
        value->lone_wolf = options.get_or( "lone_wolf", false );
        value->limited_area = options.get_or( "limited_area", false );
        value->currency = options.get_or( "currency", std::string() );
        value->monster_faction = options.get_or( "monster_faction", std::string( "human" ) );
        if( const sol::optional<sol::table> rules =
                options.get<sol::optional<sol::table>>( "price_rules" ) ) {
            for( const sol::table &rule : read_dense_array<sol::table>(
                        *rules, "faction price rules" ) ) {
                value->price_rules.push_back( read_price_rule( rule ) );
            }
        }
        if( const sol::optional<sol::table> relations =
                options.get<sol::optional<sol::table>>( "relations" ) ) {
            for( const auto &entry : *relations ) {
                const std::string target = entry.first.as<std::string>();
                value->relations[target] = read_string_set(
                                               entry.second.as<sol::table>(), "faction relations" );
            }
        }
        if( const sol::optional<sol::table> epilogues =
                options.get<sol::optional<sol::table>>( "epilogues" ) ) {
            for( const sol::table &epilogue : read_dense_array<sol::table>(
                        *epilogues, "faction epilogues" ) ) {
                faction_epilogue_data_definition parsed;
                parsed.id = epilogue.get_or( "id", std::string() );
                parsed.power_min = read_optional<int>( epilogue, "power_min" );
                parsed.power_max = read_optional<int>( epilogue, "power_max" );
                if( const sol::optional<sol::table> dynamic =
                        epilogue.get<sol::optional<sol::table>>( "dynamic" ) ) {
                    for( const sol::table &condition : read_dense_array<sol::table>(
                                *dynamic, "faction epilogue dynamic conditions" ) ) {
                        faction_epilogue_condition_data native_condition;
                        native_condition.faction = condition.get_or(
                                                       "faction", std::string() );
                        native_condition.power_min = read_optional<int>(
                                                         condition, "power_min" );
                        native_condition.power_max = read_optional<int>(
                                                         condition, "power_max" );
                        parsed.dynamic.push_back( std::move( native_condition ) );
                    }
                }
                value->epilogues.push_back( std::move( parsed ) );
            }
        }
        return faction_handle{ std::move( value ), owner };
    } );
    content.set_function( "NpcClass", [owner]( const sol::table &options ) {
        if( owner->state != lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto value = std::make_shared<npc_class_data>();
        value->id = options.get_or( "id", std::string() );
        value->name = options.get_or( "name", value->id );
        value->job_description = options.get_or( "job_description", std::string() );
        value->common = options.get_or( "common", true );
        value->common_spawn_weight = options.get_or( "common_spawn_weight", 1.0 );
        value->sells_belongings = options.get_or( "sells_belongings", true );
        value->worn = options.get_or( "worn", std::string() );
        value->carry = options.get_or( "carry", std::string() );
        value->weapon = options.get_or( "weapon", std::string() );
        value->bye_message = read_optional<std::string>( options, "bye_message" );
        value->traits = options.get_or( "traits", std::string( "EMPTY_GROUP" ) );
        value->consumption_rates = options.get_or( "consumption_rates", std::string() );
        value->blacklist = options.get_or( "blacklist", std::string() );
        value->whitelist = options.get_or( "whitelist", std::string() );
        value->restock_minutes = options.get_or<std::int64_t>(
                                     "restock_minutes", 6 * 24 * 60 );
        if( const sol::optional<sol::table> work_hours =
                options.get<sol::optional<sol::table>>( "work_hours" ) ) {
            const std::vector<int> hours = read_dense_array<int>(
                                               *work_hours, "NPC class work hours" );
            if( hours.size() != 2 ) {
                throw std::invalid_argument(
                    "NPC class work_hours must contain start and end hours" );
            }
            value->work_hours = { hours[0], hours[1] };
        }
        value->strength = read_distribution_member( options, "strength" );
        value->dexterity = read_distribution_member( options, "dexterity" );
        value->intelligence = read_distribution_member( options, "intelligence" );
        value->perception = read_distribution_member( options, "perception" );
        value->aggression = read_distribution_member( options, "aggression" );
        value->bravery = read_distribution_member( options, "bravery" );
        value->collector = read_distribution_member( options, "collector" );
        value->altruism = read_distribution_member( options, "altruism" );
        const auto read_skills = []( const sol::optional<sol::table> &source,
        std::map<std::string, distribution_data> &target ) {
            if( !source ) {
                return;
            }
            for( const auto &entry : *source ) {
                target[entry.first.as<std::string>()] =
                    read_distribution_object( entry.second, 0 );
            }
        };
        read_skills( options.get<sol::optional<sol::table>>( "skills" ), value->skills );
        read_skills( options.get<sol::optional<sol::table>>( "bonus_skills" ),
                     value->bonus_skills );
        read_skills( options.get<sol::optional<sol::table>>( "mutation_rounds" ),
                     value->mutation_rounds );
        const auto read_integer_map = []( const sol::optional<sol::table> &source,
        std::map<std::string, int> &target, const char *description ) {
            if( !source ) {
                return;
            }
            if( source->size() > 8192 ) {
                throw std::invalid_argument( std::string( description ) + " is too large" );
            }
            for( const auto &entry : *source ) {
                if( entry.first.get_type() != sol::type::string ||
                    !entry.second.is<lua_Integer>() ) {
                    throw std::invalid_argument( std::string( description ) +
                                                 " must map string ids to integers" );
                }
                target[entry.first.as<std::string>()] = entry.second.as<int>();
            }
        };
        read_integer_map( options.get<sol::optional<sol::table>>( "spells" ),
                          value->spells, "NPC class spells" );
        read_integer_map( options.get<sol::optional<sol::table>>( "bionics" ),
                          value->bionics, "NPC class bionics" );
        value->proficiencies = read_string_vector(
                                   options.get<sol::optional<sol::table>>( "proficiencies" ),
                                   "NPC class proficiencies" );
        if( const sol::optional<sol::table> groups =
                options.get<sol::optional<sol::table>>( "shop_groups" ) ) {
            for( const sol::table &group : read_dense_array<sol::table>( *groups,
                    "NPC class shop groups" ) ) {
                value->shop_groups.push_back( {
                    group.get_or( "id", std::string() ), group.get_or( "trust", 0 ),
                    group.get_or( "strict", false ), group.get_or( "rigid", false ),
                    group.get_or( "refusal", std::string() ),
                    group.get_or( "when", group.get_or(
                                      "condition", group.get_or(
                                          "condition_handler", std::string() ) ) )
                } );
            }
        }
        if( const sol::optional<sol::table> rules =
                options.get<sol::optional<sol::table>>( "price_rules" ) ) {
            for( const sol::table &rule : read_dense_array<sol::table>( *rules,
                    "NPC class price rules" ) ) {
                value->price_rules.push_back( read_price_rule( rule ) );
            }
        }
        return npc_class_handle{ std::move( value ), owner };
    } );
    content.set_function( "Npc", [owner]( const sol::table &options ) {
        if( owner->state != lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto value = std::make_shared<npc_data>();
        value->id = options.get_or( "id", std::string() );
        value->unique_name = options.get_or( "unique_name", std::string() );
        value->suffix = options.get_or( "suffix", std::string() );
        value->temporary_suffix = options.get_or( "temporary_suffix", std::string() );
        value->gender = options.get_or( "gender", std::string( "random" ) );
        value->npc_class = options.get_or( "class", std::string() );
        value->faction = options.get_or( "faction", std::string() );
        value->attitude = options.get_or( "attitude", 0 );
        value->mission = options.get_or( "mission", std::string( "NULL" ) );
        value->chat = options.get_or( "chat", std::string( "TALK_NONE" ) );
        value->stole_item_chat = options.get_or( "stole_item_chat", std::string() );
        value->missions_offered = read_string_vector(
                                      options.get<sol::optional<sol::table>>( "missions_offered" ),
                                      "NPC offered missions" );
        if( const sol::optional<sol::table> topics =
                options.get<sol::optional<sol::table>>( "dialogue_topics" ) ) {
            for( const auto &entry : *topics ) {
                if( entry.first.get_type() != sol::type::string ||
                    entry.second.get_type() != sol::type::string ) {
                    throw std::invalid_argument(
                        "NPC dialogue_topics must map names to topic ids" );
                }
                value->dialogue_topics[entry.first.as<std::string>()] =
                    entry.second.as<std::string>();
            }
        }
        if( const sol::optional<sol::table> snippets =
                options.get<sol::optional<sol::table>>( "snippets" ) ) {
            for( const auto &entry : *snippets ) {
                if( entry.first.get_type() != sol::type::string ||
                    entry.second.get_type() != sol::type::string ) {
                    throw std::invalid_argument(
                        "NPC snippets must map names to text" );
                }
                value->snippets[entry.first.as<std::string>()] =
                    entry.second.as<std::string>();
            }
        }
        value->age = read_optional<int>( options, "age" );
        value->height = read_optional<int>( options, "height" );
        value->strength = read_optional<int>( options, "strength" );
        value->dexterity = read_optional<int>( options, "dexterity" );
        value->intelligence = read_optional<int>( options, "intelligence" );
        value->perception = read_optional<int>( options, "perception" );
        if( const sol::optional<sol::table> personality =
                options.get<sol::optional<sol::table>>( "personality" ) ) {
            value->personality = std::array<int, 4> {
                personality->get_or( "aggression", 0 ),
                personality->get_or( "bravery", 0 ),
                personality->get_or( "collector", 0 ),
                personality->get_or( "altruism", 0 )
            };
        }
        value->death_eocs = read_string_vector(
                                options.get<sol::optional<sol::table>>( "death_eocs" ),
                                "NPC death EOCs" );
        value->death_handler = options.get_or(
                                   "on_death",
                                   options.get_or( "death_handler", std::string() ) );
        return npc_handle{ std::move( value ), owner };
    } );
    content.set_function( "OvermapTerrain", [owner]( const sol::table &options ) {
        if( owner->state != lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto value = std::make_shared<overmap_terrain_data>();
        value->id = options.get_or( "id", std::string() );
        value->name = options.get_or( "name", value->id );
        value->symbol = options.get_or( "symbol", std::string( "?" ) );
        value->color = options.get_or( "color", std::string( "white" ) );
        value->see_cost = options.get_or( "see_cost", std::string( "none" ) );
        value->travel_cost = options.get_or(
                                 "travel_cost",
                                 options.get_or( "travel_cost_type", std::string( "other" ) ) );
        value->default_map_data = options.get_or( "default_map_data", std::string( "full_omt" ) );
        value->vision_levels = options.get_or( "vision_levels", std::string( "default" ) );
        value->land_use_code = options.get_or( "land_use_code", std::string() );
        value->extras = options.get_or( "extras", std::string( "none" ) );
        value->connect_group = options.get_or( "connect_group", std::string() );
        value->entry_eoc = options.get_or( "entry_eoc", std::string() );
        value->exit_eoc = options.get_or( "exit_eoc", std::string() );
        value->entry_handler = options.get_or(
                                   "on_entry", options.get_or(
                                       "entry_handler", std::string() ) );
        value->exit_handler = options.get_or(
                                  "on_exit", options.get_or(
                                      "exit_handler", std::string() ) );
        value->uniform_terrain = read_optional<std::string>( options, "uniform_terrain" );
        value->looks_like = read_string_vector(
                                options.get<sol::optional<sol::table>>( "looks_like" ),
                                "overmap terrain looks_like" );
        value->post_process_generators = read_string_vector(
                                             options.get<sol::optional<sol::table>>(
                                                 "post_process_generators" ),
                                             "overmap terrain post-process generators" );
        value->monster_density = options.get_or( "monster_density", 0 );
        if( const sol::optional<sol::table> spawns =
                options.get<sol::optional<sol::table>>( "spawns" ) ) {
            overmap_terrain_data::static_spawn_data parsed;
            parsed.group = spawns->get_or( "group", std::string() );
            parsed.population = read_interval(
                                    spawns->get<sol::optional<sol::table>>( "population" ),
                                    {}, "overmap terrain spawn population" );
            parsed.chance = spawns->get_or( "chance", 0 );
            value->static_spawns = std::move( parsed );
        }
        value->flags = read_string_set(
                           options.get<sol::optional<sol::table>>( "flags" ), "overmap terrain flags" );
        return omt_handle{ std::move( value ), owner };
    } );
    content.set_function( "OvermapSpecial", [owner]( const sol::table &options ) {
        if( owner->state != lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto value = std::make_shared<overmap_special_data>();
        value->id = options.get_or( "id", std::string() );
        value->subtype = options.get_or( "subtype", std::string( "fixed" ) );
        value->eoc = options.get_or( "eoc", std::string() );
        value->condition_handler = options.get_or(
                                       "when", options.get_or(
                                           "condition_handler", std::string() ) );
        value->placement_handler = options.get_or(
                                       "on_place", options.get_or(
                                           "placement_handler", std::string() ) );
        value->default_locations = read_string_set(
                                       options.get<sol::optional<sol::table>>( "locations" ),
                                       "overmap special locations" );
        value->flags = read_string_set(
                           options.get<sol::optional<sol::table>>( "flags" ), "overmap special flags" );
        sol::optional<sol::table> city_size =
            options.get<sol::optional<sol::table>>( "city_size" );
        if( !city_size ) {
            city_size = options.get<sol::optional<sol::table>>( "city_sizes" );
        }
        value->city_size = read_interval( city_size, value->city_size,
                                         "overmap special city size" );
        value->city_distance = read_interval(
                                   options.get<sol::optional<sol::table>>( "city_distance" ),
                                   value->city_distance, "overmap special city distance" );
        value->occurrences = read_interval(
                                 options.get<sol::optional<sol::table>>( "occurrences" ), value->occurrences,
                                 "overmap special occurrences" );
        value->priority = options.get_or( "priority", 0 );
        value->rotate = options.get_or( "rotate", true );
        if( const sol::optional<sol::table> spawns =
                options.get<sol::optional<sol::table>>( "spawns" ) ) {
            special_spawn_data parsed;
            parsed.group = spawns->get_or( "group", std::string() );
            parsed.population = read_interval(
                                    spawns->get<sol::optional<sol::table>>( "population" ), {},
                                    "overmap special spawn population" );
            parsed.radius = read_interval(
                                spawns->get<sol::optional<sol::table>>( "radius" ), {},
                                "overmap special spawn radius" );
            value->spawns = std::move( parsed );
        }
        if( value->subtype == "fixed" ) {
            sol::optional<sol::table> terrains =
                options.get<sol::optional<sol::table>>( "terrains" );
            if( !terrains ) {
                terrains = options.get<sol::optional<sol::table>>( "overmaps" );
            }
            if( terrains ) {
                for( const sol::table &terrain : read_dense_array<sol::table>( *terrains,
                        "overmap special terrains" ) ) {
                    const std::array<int, 3> point = read_point(
                            terrain.get<sol::table>( "point" ), "overmap special point" );
                    special_terrain_data parsed;
                    parsed.x = point[0];
                    parsed.y = point[1];
                    parsed.z = point[2];
                    parsed.terrain = terrain.get_or( "terrain", terrain.get_or(
                                                        "overmap", std::string() ) );
                    parsed.locations = read_string_set(
                                           terrain.get<sol::optional<sol::table>>( "locations" ),
                                           "overmap special terrain locations" );
                    parsed.flags = read_string_set(
                                       terrain.get<sol::optional<sol::table>>( "flags" ),
                                       "overmap special terrain flags" );
                    parsed.camp_owner = read_optional<std::string>( terrain, "camp" );
                    parsed.camp_name = terrain.get_or( "camp_name", std::string() );
                    value->terrains.push_back( std::move( parsed ) );
                }
            }
            if( const sol::optional<sol::table> connections =
                    options.get<sol::optional<sol::table>>( "connections" ) ) {
                for( const sol::table &connection : read_dense_array<sol::table>( *connections,
                        "overmap special connections" ) ) {
                    const std::array<int, 3> point = read_point(
                            connection.get<sol::table>( "point" ), "overmap connection point" );
                    special_connection_data parsed;
                    parsed.x = point[0];
                    parsed.y = point[1];
                    parsed.z = point[2];
                    if( const sol::optional<sol::table> from =
                            connection.get<sol::optional<sol::table>>( "from" ) ) {
                        parsed.from = read_point( *from, "overmap connection from" );
                    }
                    parsed.terrain = connection.get_or( "terrain", std::string() );
                    parsed.connection = connection.get_or( "connection", std::string() );
                    parsed.existing = connection.get_or( "existing", false );
                    value->connections.push_back( std::move( parsed ) );
                }
            }
        } else if( value->subtype == "mutable" ) {
            if( const sol::optional<sol::table> locations =
                    options.get<sol::optional<sol::table>>( "check_for_locations" ) ) {
                for( const sol::table &entry : read_dense_array<sol::table>( *locations,
                        "mutable special checked locations" ) ) {
                    sol::optional<sol::table> point =
                        entry.get<sol::optional<sol::table>>( "point" );
                    sol::optional<sol::table> allowed =
                        entry.get<sol::optional<sol::table>>( "locations" );
                    if( !point ) {
                        point = entry.raw_get<sol::optional<sol::table>>( 1 );
                    }
                    if( !allowed ) {
                        allowed = entry.raw_get<sol::optional<sol::table>>( 2 );
                    }
                    if( !point || !allowed ) {
                        throw std::invalid_argument(
                            "mutable special checked location requires point and locations" );
                    }
                    const std::array<int, 3> coordinates = read_point(
                            *point, "mutable special checked point" );
                    value->check_for_locations.push_back( {
                        coordinates[0], coordinates[1], coordinates[2],
                        read_string_set( allowed, "mutable special checked location types" )
                    } );
                }
            }
            if( const sol::optional<sol::table> areas =
                    options.get<sol::optional<sol::table>>( "check_for_locations_area" ) ) {
                for( const sol::table &area : read_dense_array<sol::table>( *areas,
                        "mutable special checked location areas" ) ) {
                    const std::array<int, 3> from = read_point(
                            area.get<sol::table>( "from" ), "mutable special checked area start" );
                    const std::array<int, 3> to = read_point(
                            area.get<sol::table>( "to" ), "mutable special checked area end" );
                    const std::set<std::string> allowed = read_string_set(
                            area.get<sol::optional<sol::table>>( "locations" ) ?
                            area.get<sol::optional<sol::table>>( "locations" ) :
                            area.get<sol::optional<sol::table>>( "type" ),
                            "mutable special checked area location types" );
                    const int min_x = std::min( from[0], to[0] );
                    const int max_x = std::max( from[0], to[0] );
                    const int min_y = std::min( from[1], to[1] );
                    const int max_y = std::max( from[1], to[1] );
                    const int min_z = std::min( from[2], to[2] );
                    const int max_z = std::max( from[2], to[2] );
                    const std::int64_t count =
                        ( static_cast<std::int64_t>( max_x ) - min_x + 1 ) *
                        ( static_cast<std::int64_t>( max_y ) - min_y + 1 ) *
                        ( static_cast<std::int64_t>( max_z ) - min_z + 1 );
                    if( count > 262144 ) {
                        throw std::invalid_argument(
                            "mutable special checked location area is too large" );
                    }
                    for( int x = min_x; x <= max_x; ++x ) {
                        for( int y = min_y; y <= max_y; ++y ) {
                            for( int z = min_z; z <= max_z; ++z ) {
                                value->check_for_locations.push_back( { x, y, z, allowed } );
                            }
                        }
                    }
                }
            }
            if( const sol::optional<sol::table> joins =
                    options.get<sol::optional<sol::table>>( "joins" ) ) {
                for( const sol::object &entry : read_dense_array<sol::object>(
                            *joins, "mutable special joins" ) ) {
                    special_join_data parsed;
                    if( entry.get_type() == sol::type::string ) {
                        parsed.id = entry.as<std::string>();
                    } else if( entry.get_type() == sol::type::table ) {
                        const sol::table descriptor = entry.as<sol::table>();
                        parsed.id = descriptor.get_or( "id", std::string() );
                        parsed.opposite = descriptor.get_or( "opposite", std::string() );
                        parsed.into_locations = read_string_set(
                                                    descriptor.get<sol::optional<sol::table>>( "into_locations" ),
                                                    "mutable special join locations" );
                    } else {
                        throw std::invalid_argument(
                            "mutable special join must be a string or table" );
                    }
                    value->joins.push_back( std::move( parsed ) );
                }
            }
            sol::optional<sol::table> overmaps =
                options.get<sol::optional<sol::table>>( "mutable_overmaps" );
            if( !overmaps ) {
                overmaps = options.get<sol::optional<sol::table>>( "overmaps" );
            }
            if( overmaps ) {
                for( const auto &entry : *overmaps ) {
                    if( entry.first.get_type() != sol::type::string ||
                        entry.second.get_type() != sol::type::table ) {
                        throw std::invalid_argument(
                            "mutable special overmaps must map string ids to tables" );
                    }
                    const std::string key = entry.first.as<std::string>();
                    const sol::table descriptor = entry.second.as<sol::table>();
                    mutable_special_terrain_data parsed;
                    parsed.terrain = descriptor.get_or( "terrain", descriptor.get_or(
                                                            "overmap", std::string() ) );
                    parsed.locations = read_string_set(
                                           descriptor.get<sol::optional<sol::table>>( "locations" ),
                                           "mutable special overmap locations" );
                    parsed.camp_owner = read_optional<std::string>( descriptor, "camp" );
                    parsed.camp_name = descriptor.get_or( "camp_name", std::string() );
                    for( const char *direction : {
                             "north", "east", "south", "west", "above", "below"
                         } ) {
                        const sol::object join = descriptor.raw_get<sol::object>( direction );
                        if( !join.valid() || join.get_type() == sol::type::nil ) {
                            continue;
                        }
                        special_terrain_join_data parsed_join;
                        if( join.get_type() == sol::type::string ) {
                            parsed_join.id = join.as<std::string>();
                        } else if( join.get_type() == sol::type::table ) {
                            const sol::table join_descriptor = join.as<sol::table>();
                            parsed_join.id = join_descriptor.get_or( "id", std::string() );
                            parsed_join.type = join_descriptor.get_or(
                                                   "type", std::string( "mandatory" ) );
                            parsed_join.alternatives = read_string_set(
                                join_descriptor.get<sol::optional<sol::table>>( "alternatives" ),
                                "mutable special alternative joins" );
                        } else {
                            throw std::invalid_argument(
                                "mutable special terrain join must be a string or table" );
                        }
                        parsed.joins[direction] = std::move( parsed_join );
                    }
                    if( const sol::optional<sol::table> connections =
                            descriptor.get<sol::optional<sol::table>>( "connections" ) ) {
                        for( const auto &connection : *connections ) {
                            if( connection.first.get_type() != sol::type::string ) {
                                throw std::invalid_argument(
                                    "mutable special connection direction must be a string" );
                            }
                            const std::string direction = connection.first.as<std::string>();
                            if( connection.second.get_type() == sol::type::string ) {
                                parsed.connections[direction] =
                                    connection.second.as<std::string>();
                            } else if( connection.second.get_type() == sol::type::table ) {
                                parsed.connections[direction] =
                                    connection.second.as<sol::table>().get_or(
                                        "connection", std::string() );
                            } else {
                                throw std::invalid_argument(
                                    "mutable special connection must be a string or table" );
                            }
                        }
                    }
                    value->mutable_terrains[key] = std::move( parsed );
                }
            }
            value->root = options.get_or( "root", std::string() );
            if( const sol::optional<sol::table> phases =
                    options.get<sol::optional<sol::table>>( "phases" ) ) {
                for( const sol::table &phase : read_dense_array<sol::table>(
                            *phases, "mutable special phases" ) ) {
                    std::vector<mutable_special_rule_data> parsed_phase;
                    for( const sol::table &rule : read_dense_array<sol::table>(
                                phase, "mutable special phase rules" ) ) {
                        mutable_special_rule_data parsed_rule;
                        parsed_rule.name = rule.get_or( "name", std::string() );
                        const sol::object maximum = rule.raw_get<sol::object>( "max" );
                        if( maximum.valid() && maximum.get_type() != sol::type::nil ) {
                            parsed_rule.maximum = read_integer_distribution(
                                                      maximum, "mutable special rule maximum" );
                        }
                        parsed_rule.weight = read_optional<int>( rule, "weight" );
                        const std::string single = rule.get_or( "overmap", std::string() );
                        if( !single.empty() ) {
                            parsed_rule.pieces.push_back( { single, 0, 0, 0, "north" } );
                        } else if( const sol::optional<sol::table> chunk =
                                       rule.get<sol::optional<sol::table>>( "chunk" ) ) {
                            for( const sol::table &piece : read_dense_array<sol::table>(
                                        *chunk, "mutable special rule pieces" ) ) {
                                std::array<int, 3> point = { 0, 0, 0 };
                                if( const sol::optional<sol::table> position =
                                        piece.get<sol::optional<sol::table>>( "pos" ) ) {
                                    point = read_point( *position,
                                                        "mutable special rule piece position" );
                                }
                                parsed_rule.pieces.push_back( {
                                    piece.get_or( "overmap", std::string() ),
                                    point[0], point[1], point[2],
                                    piece.get_or( "rotation", piece.get_or(
                                                      "rot", std::string( "north" ) ) )
                                } );
                            }
                        }
                        parsed_phase.push_back( std::move( parsed_rule ) );
                    }
                    value->phases.push_back( std::move( parsed_phase ) );
                }
            }
        } else {
            throw std::invalid_argument( "overmap special subtype must be fixed or mutable" );
        }
        return special_handle{ std::move( value ), owner };
    } );
    // The native loader treats city_building as a fixed overmap_special alias.
    // Keep one implementation and registry path while exposing both authoring names.
    content["CityBuilding"] = content["OvermapSpecial"];
    content.set_function( "VehiclePart", [owner]( const sol::table &options ) {
        if( owner->state != lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto value = std::make_shared<vehicle_part_data>();
        value->id = options.get_or( "id", std::string() );
        value->copy_from = options.get_or( "copy_from", std::string() );
        value->name = read_optional<std::string>( options, "name" );
        value->description = read_optional<std::string>( options, "description" );
        value->item = read_optional<std::string>( options, "item" );
        value->remove_as = read_optional<std::string>( options, "remove_as" );
        value->location = read_optional<std::string>( options, "location" );
        value->looks_like = read_optional<std::string>( options, "looks_like" );
        value->color = read_optional<std::string>( options, "color" );
        value->broken_color = read_optional<std::string>( options, "broken_color" );
        value->fuel_type = read_optional<std::string>( options, "fuel_type" );
        value->default_ammo = read_optional<std::string>( options, "default_ammo" );
        value->durability = read_optional<int>( options, "durability" );
        value->size_ml = read_optional<int>( options, "size_ml" );
        value->folded_volume_ml = read_optional<int>( options, "folded_volume_ml" );
        value->damage_modifier = read_optional<int>( options, "damage_modifier" );
        value->power_watts = read_optional<int>( options, "power_watts" );
        value->epower_watts = read_optional<int>( options, "epower_watts" );
        value->energy_consumption_watts =
            read_optional<int>( options, "energy_consumption_watts" );
        value->balloon_height = read_optional<float>( options, "balloon_height" );
        value->backfire_threshold = read_optional<float>( options, "backfire_threshold" );
        value->backfire_frequency = read_optional<int>( options, "backfire_frequency" );
        value->damaged_power_factor = read_optional<float>( options, "damaged_power_factor" );
        value->noise_factor = read_optional<int>( options, "noise_factor" );
        value->m2c = read_optional<int>( options, "m2c" );
        value->muscle_power_factor = read_optional<int>( options, "muscle_power_factor" );
        value->bonus = read_optional<int>( options, "bonus" );
        value->cargo_weight_modifier = read_optional<int>( options, "cargo_weight_modifier" );
        value->cargo_spoil_multiplier = read_optional<int>( options, "cargo_spoil_multiplier" );
        value->comfort = read_optional<int>( options, "comfort" );
        value->floor_bedding_warmth_celsius = read_optional<double>(
                    options, "floor_bedding_warmth_celsius" );
        value->bonus_fire_warmth_feet_celsius = read_optional<double>(
                    options, "bonus_fire_warmth_feet_celsius" );
        value->default_tint_color = read_optional<std::string>(
                                        options, "default_tint_color" );
        value->activatable_eoc = read_optional<std::string>( options, "activatable_eoc" );
        value->activation_handler = options.get_or(
                                        "on_activate", options.get_or(
                                            "activation_handler", std::string() ) );
        if( const sol::optional<sol::table> light_color =
                options.get<sol::optional<sol::table>>( "light_color" ) ) {
            const std::vector<int> channels = read_dense_array<int>(
                                                  *light_color, "vehicle part light color" );
            if( channels.size() != 3 ) {
                throw std::invalid_argument(
                    "vehicle part light_color must have red, green, and blue channels" );
            }
            value->light_color = std::array<int, 3>{ channels[0], channels[1], channels[2] };
        }
        if( const sol::optional<sol::table> categories =
                options.get<sol::optional<sol::table>>( "categories" ) ) {
            value->categories = read_string_set( categories, "vehicle part categories" );
        }
        if( const sol::optional<sol::table> flags =
                options.get<sol::optional<sol::table>>( "flags" ) ) {
            value->flags = read_string_set( flags, "vehicle part flags" );
        }
        if( const sol::optional<sol::table> emissions =
                options.get<sol::optional<sol::table>>( "emissions" ) ) {
            value->emissions = read_string_set( emissions, "vehicle part emissions" );
        }
        if( const sol::optional<sol::table> exhaust =
                options.get<sol::optional<sol::table>>( "exhaust" ) ) {
            value->exhaust = read_string_set( exhaust, "vehicle part exhaust emissions" );
        }
        if( const sol::optional<sol::table> fuel_options =
                options.get<sol::optional<sol::table>>( "fuel_options" ) ) {
            value->fuel_options = read_string_vector(
                                      fuel_options, "vehicle part fuel options" );
            value->fuel_options_set = true;
        }
        sol::optional<sol::table> exclusions =
            options.get<sol::optional<sol::table>>( "engine_exclusions" );
        if( !exclusions ) {
            exclusions = options.get<sol::optional<sol::table>>( "exclusions" );
        }
        if( exclusions ) {
            value->engine_exclusions = read_string_set(
                                           exclusions, "vehicle part engine exclusions" );
        }
        value->breaks_into = options.get_or( "breaks_into", std::string() );
        if( const sol::optional<sol::table> reductions =
                options.get<sol::optional<sol::table>>( "damage_reduction" ) ) {
            value->damage_reduction_set = true;
            for( const auto &entry : *reductions ) {
                value->damage_reduction[entry.first.as<std::string>()] = entry.second.as<float>();
            }
        }
        if( const sol::optional<sol::table> variants =
                options.get<sol::optional<sol::table>>( "variants" ) ) {
            value->variants.emplace();
            for( const sol::table &variant : read_dense_array<sol::table>( *variants,
                    "vehicle part variants" ) ) {
                value->variants->push_back( {
                    variant.get_or( "id", std::string() ),
                    variant.get_or( "label", std::string() ),
                    variant.get_or( "symbols", std::string( "?" ) ),
                    variant.get_or( "broken_symbols", std::string( "?" ) )
                } );
            }
        }
        sol::optional<sol::table> bases =
            options.get<sol::optional<sol::table>>( "variants_bases" );
        if( !bases ) {
            bases = options.get<sol::optional<sol::table>>( "variant_bases" );
        }
        if( bases ) {
            value->variant_bases.emplace();
            for( const sol::table &base : read_dense_array<sol::table>(
                        *bases, "vehicle part variant bases" ) ) {
                value->variant_bases->emplace_back(
                    base.get_or( "id", std::string() ),
                    base.get_or( "label", std::string() ) );
            }
        }
        if( const sol::optional<sol::table> enchantments =
                options.get<sol::optional<sol::table>>( "enchantments" ) ) {
            value->enchantments = read_string_vector(
                                      enchantments, "vehicle part enchantments" );
        }
        const auto read_integer_map = []( const sol::table &source,
        const char *description ) {
            std::map<std::string, int> result;
            for( const auto &entry : source ) {
                if( entry.first.get_type() != sol::type::string ||
                    !entry.second.is<lua_Integer>() ) {
                    throw std::invalid_argument( std::string( description ) +
                                                 " must map string ids to integers" );
                }
                result[entry.first.as<std::string>()] = entry.second.as<int>();
            }
            return result;
        };
        if( const sol::optional<sol::table> qualities =
                options.get<sol::optional<sol::table>>( "qualities" ) ) {
            value->qualities = read_integer_map( *qualities, "vehicle part qualities" );
        }
        if( const sol::optional<sol::table> tools =
                options.get<sol::optional<sol::table>>( "pseudo_tools" ) ) {
            value->pseudo_tools.emplace();
            for( const sol::table &tool : read_dense_array<sol::table>(
                        *tools, "vehicle part pseudo tools" ) ) {
                const std::string hotkey = tool.get_or( "hotkey", std::string() );
                value->pseudo_tools->push_back( {
                    tool.get_or( "id", std::string() ),
                    hotkey.empty() ? -1 : static_cast<unsigned char>( hotkey.front() )
                } );
            }
        }
        if( const sol::optional<sol::table> tools =
                options.get<sol::optional<sol::table>>( "folding_tools" ) ) {
            value->folding_tools = read_string_vector(
                                       tools, "vehicle part folding tools" );
        }
        if( const sol::optional<sol::table> tools =
                options.get<sol::optional<sol::table>>( "unfolding_tools" ) ) {
            value->unfolding_tools = read_string_vector(
                                         tools, "vehicle part unfolding tools" );
        }
        value->folding_time_seconds = read_optional<std::int64_t>(
                                          options, "folding_time_seconds" );
        value->unfolding_time_seconds = read_optional<std::int64_t>(
                                            options, "unfolding_time_seconds" );
        if( const sol::optional<sol::table> wheel =
                options.get<sol::optional<sol::table>>( "wheel" ) ) {
            vpart_wheel_data parsed;
            parsed.rolling_resistance = wheel->get_or( "rolling_resistance", 1.0f );
            parsed.contact_area = wheel->get_or( "contact_area", 1 );
            parsed.offroad_rating = wheel->get_or( "offroad_rating", 0.5f );
            if( const sol::optional<sol::table> modifiers =
                    wheel->get<sol::optional<sol::table>>( "terrain_modifiers" ) ) {
                for( const auto &modifier : *modifiers ) {
                    if( modifier.first.get_type() != sol::type::string ||
                        modifier.second.get_type() != sol::type::table ) {
                        throw std::invalid_argument(
                            "vehicle wheel terrain modifiers must map flags to pairs" );
                    }
                    const std::vector<int> values = read_dense_array<int>(
                                modifier.second.as<sol::table>(),
                                "vehicle wheel terrain modifier" );
                    if( values.size() != 2 ) {
                        throw std::invalid_argument(
                            "vehicle wheel terrain modifier needs override and penalty" );
                    }
                    parsed.terrain_modifiers.push_back( {
                        modifier.first.as<std::string>(), values[0], values[1]
                    } );
                }
            }
            value->wheel = std::move( parsed );
        }
        value->rotor_diameter = read_optional<int>( options, "rotor_diameter" );
        value->propeller_diameter = read_optional<int>( options, "propeller_diameter" );
        value->ladder_length = read_optional<int>( options, "ladder_length" );
        if( const sol::optional<sol::table> workbench =
                options.get<sol::optional<sol::table>>( "workbench" ) ) {
            value->workbench = vpart_workbench_data {
                workbench->get_or( "multiplier", 1.0f ),
                workbench->get_or<std::int64_t>( "mass_grams", 0 ),
                workbench->get_or<std::int64_t>( "volume_ml", 0 )
            };
        }
        if( const sol::optional<sol::table> toolkit =
                options.get<sol::optional<sol::table>>( "toolkit_allowed_tools" ) ) {
            value->toolkit_allowed_tools = read_string_set(
                                               toolkit, "vehicle part toolkit tools" );
        }
        if( const sol::optional<sol::table> transform =
                options.get<sol::optional<sol::table>>( "terrain_transform" ) ) {
            vpart_terrain_transform_data parsed;
            parsed.pre_flags = read_string_set(
                                   transform->get<sol::optional<sol::table>>( "pre_flags" ),
                                   "vehicle terrain transform pre-flags" );
            parsed.post_terrain = read_optional<std::string>( *transform, "post_terrain" );
            parsed.post_furniture = read_optional<std::string>(
                                        *transform, "post_furniture" );
            parsed.post_field = read_optional<std::string>( *transform, "post_field" );
            parsed.post_field_intensity = transform->get_or( "post_field_intensity", 0 );
            parsed.post_field_age_seconds = transform->get_or<std::int64_t>(
                                                "post_field_age_seconds", 0 );
            value->terrain_transform = std::move( parsed );
        }
        const auto read_requirement = []( const sol::optional<sol::table> &source,
        vpart_requirement_data &target ) {
            if( !source ) {
                return;
            }
            target.id = source->get_or( "id", std::string() );
            target.multiplier = source->get_or( "multiplier", 1 );
            if( const sol::optional<sol::table> requirements =
                    source->get<sol::optional<sol::table>>( "using" ) ) {
                for( const sol::table &requirement : read_dense_array<sol::table>(
                            *requirements, "vehicle part requirements" ) ) {
                    target.using_requirements.emplace_back(
                        requirement.get_or( "id", std::string() ),
                        requirement.get_or( "multiplier", 1 ) );
                }
            }
            target.time_minutes = source->get_or( "time_minutes", -1 );
            if( const sol::optional<sol::table> skills =
                    source->get<sol::optional<sol::table>>( "skills" ) ) {
                for( const auto &entry : *skills ) {
                    target.skills[entry.first.as<std::string>()] = entry.second.as<int>();
                }
            }
        };
        read_requirement( options.get<sol::optional<sol::table>>( "install" ), value->install );
        read_requirement( options.get<sol::optional<sol::table>>( "removal" ), value->removal );
        read_requirement( options.get<sol::optional<sol::table>>( "repair" ), value->repair );
        if( const sol::optional<sol::table> control =
                options.get<sol::optional<sol::table>>( "control" ) ) {
            if( const sol::optional<sol::table> proficiencies =
                    control->get<sol::optional<sol::table>>( "air_proficiencies" ) ) {
                value->air_proficiencies = read_string_set(
                                               proficiencies, "air control proficiencies" );
            }
            if( const sol::optional<sol::table> proficiencies =
                    control->get<sol::optional<sol::table>>( "land_proficiencies" ) ) {
                value->land_proficiencies = read_string_set(
                                                proficiencies, "land control proficiencies" );
            }
            if( const sol::optional<sol::table> skills =
                    control->get<sol::optional<sol::table>>( "air_skills" ) ) {
                value->air_skills = read_integer_map( *skills, "air control skills" );
            }
            if( const sol::optional<sol::table> skills =
                    control->get<sol::optional<sol::table>>( "land_skills" ) ) {
                value->land_skills = read_integer_map( *skills, "land control skills" );
            }
        }
        return vpart_handle{ std::move( value ), owner };
    } );
    content.set_function( "Vehicle", [owner]( const sol::table &options ) {
        if( owner->state != lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto value = std::make_shared<vehicle_data>();
        value->id = options.get_or( "id", std::string() );
        value->copy_from = options.get_or( "copy_from", std::string() );
        value->name = read_optional<std::string>( options, "name" );
        if( const std::optional<std::string> palette = read_optional<std::string>(
                    options, "color_palette" ) ) {
            value->color_palette = *palette;
            value->color_palette_set = true;
        }
        if( const sol::optional<sol::table> parts =
                options.get<sol::optional<sol::table>>( "parts" ) ) {
            for( const sol::table &part : read_dense_array<sol::table>( *parts,
                    "vehicle parts" ) ) {
                vehicle_part_placement_data parsed;
                parsed.x = part.get_or( "x", 0 );
                parsed.y = part.get_or( "y", 0 );
                parsed.part = part.get_or( "part", std::string() );
                parsed.variant = part.get_or( "variant", std::string() );
                parsed.with_ammo = part.get_or( "with_ammo", 0 );
                parsed.ammo_types = read_string_set(
                                        part.get<sol::optional<sol::table>>( "ammo_types" ),
                                        "vehicle part ammo types" );
                if( const sol::optional<sol::table> quantity =
                        part.get<sol::optional<sol::table>>( "ammo_quantity" ) ) {
                    const std::vector<int> range = read_dense_array<int>( *quantity,
                                                   "vehicle part ammo quantity" );
                    if( range.size() != 2 ) {
                        throw std::invalid_argument( "vehicle part ammo quantity needs two integers" );
                    }
                    parsed.ammo_quantity = { range[0], range[1] };
                }
                parsed.fuel = part.get_or( "fuel", std::string() );
                parsed.tools = read_string_vector(
                                   part.get<sol::optional<sol::table>>( "tools" ), "vehicle part tools" );
                value->parts.push_back( std::move( parsed ) );
            }
        }
        if( const sol::optional<sol::table> items =
                options.get<sol::optional<sol::table>>( "items" ) ) {
            value->items_set = true;
            for( const sol::table &item : read_dense_array<sol::table>( *items,
                    "vehicle item spawns" ) ) {
                vehicle_item_data parsed;
                parsed.x = item.get_or( "x", 0 );
                parsed.y = item.get_or( "y", 0 );
                parsed.chance = item.get_or( "chance", 0 );
                parsed.with_ammo = item.get_or( "with_ammo", item.get_or( "ammo", 0 ) );
                parsed.with_magazine = item.get_or(
                                           "with_magazine", item.get_or( "magazine", 0 ) );
                if( const sol::optional<sol::table> spawned =
                        item.get<sol::optional<sol::table>>( "items" ) ) {
                    for( const sol::object &spawn : read_dense_array<sol::object>(
                                *spawned, "vehicle spawn items" ) ) {
                        if( spawn.get_type() == sol::type::string ) {
                            parsed.items.emplace_back( spawn.as<std::string>(), std::string() );
                        } else if( spawn.get_type() == sol::type::table ) {
                            const sol::table descriptor = spawn.as<sol::table>();
                            parsed.items.emplace_back(
                                descriptor.get_or( "id", std::string() ),
                                descriptor.get_or( "variant", std::string() ) );
                        } else {
                            throw std::invalid_argument(
                                "vehicle spawn item must be a string or table" );
                        }
                    }
                }
                sol::optional<sol::table> groups =
                    item.get<sol::optional<sol::table>>( "groups" );
                if( !groups ) {
                    groups = item.get<sol::optional<sol::table>>( "item_groups" );
                }
                parsed.groups = read_string_vector( groups, "vehicle spawn groups" );
                value->items.push_back( std::move( parsed ) );
            }
        }
        if( const sol::optional<sol::table> zones =
                options.get<sol::optional<sol::table>>( "zones" ) ) {
            value->zones_set = true;
            for( const sol::table &zone : read_dense_array<sol::table>( *zones,
                    "vehicle zones" ) ) {
                value->zones.push_back( {
                    zone.get_or( "x", 0 ), zone.get_or( "y", 0 ),
                    zone.get_or( "type", std::string() ),
                    zone.get_or( "name", std::string() ),
                    zone.get_or( "filter", std::string() )
                } );
            }
        }
        return vehicle_handle{ std::move( value ), owner };
    } );

    static_cast<void>( lua );
}

bool world_content_transaction::register_definition( const sol::object &value,
        const int raw_operation )
{
    if( raw_operation < 0 || raw_operation > 2 ) {
        throw std::runtime_error( "invalid Platform content operation" );
    }
    const operation op = static_cast<operation>( raw_operation );
    const auto register_value = [this, op]( auto handle, auto &entries, const char *kind ) {
        if( handle.owner != pimpl_->handle_token ) {
            throw std::runtime_error( std::string( "cannot register a " ) + kind +
                                      " definition owned by another Mod" );
        }
        if( handle.owner->state != lifecycle::building || handle.definition->registered ) {
            throw std::runtime_error( std::string( kind ) + " definition is not building" );
        }
        handle.definition->registered = true;
        if( op == operation::edit ) {
            const auto target = std::find_if( entries.rbegin(), entries.rend(),
            [&handle]( const auto &entry ) {
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
        entries.push_back( { op, handle.definition } );
    };

#define CATA_REGISTER_WORLD_DEFINITION( Data, Entries, Label ) \
    if( value.is<definition_handle<Data>>() ) { \
        register_value( value.as<definition_handle<Data>>(), pimpl_->Entries, Label ); \
        return true; \
    }
    CATA_REGISTER_WORLD_DEFINITION( faction_data, factions, "faction" )
    CATA_REGISTER_WORLD_DEFINITION( npc_class_data, npc_classes, "NPC class" )
    CATA_REGISTER_WORLD_DEFINITION( npc_data, npcs, "NPC" )
    CATA_REGISTER_WORLD_DEFINITION( overmap_terrain_data, overmap_terrains, "overmap terrain" )
    CATA_REGISTER_WORLD_DEFINITION( overmap_special_data, overmap_specials, "overmap special" )
    CATA_REGISTER_WORLD_DEFINITION( vehicle_part_data, vehicle_parts, "vehicle part" )
    CATA_REGISTER_WORLD_DEFINITION( vehicle_data, vehicles, "vehicle" )
#undef CATA_REGISTER_WORLD_DEFINITION
    return false;
}

bool world_content_transaction::validate( const runtime &owner_runtime,
        const bool check_engine_state, std::string &error ) const
{
    try {
        const auto faction_exists = []( const std::string &id ) {
            const auto &values = detail::faction_template_registry();
            return std::any_of( values.begin(), values.end(), [&id]( const faction_template &value ) {
                return value.id == faction_id( id );
            } );
        };
        validate_registrations( pimpl_->factions, "faction", check_engine_state, faction_exists );
        validate_registrations( pimpl_->npc_classes, "NPC class", check_engine_state,
        []( const std::string &id ) { return npc_class_id( id ).is_valid(); } );
        validate_registrations( pimpl_->npcs, "NPC", check_engine_state,
        []( const std::string &id ) { return npc_template_id( id ).is_valid(); } );
        validate_registrations( pimpl_->overmap_terrains, "overmap terrain", check_engine_state,
        []( const std::string &id ) { return oter_type_str_id( id ).is_valid(); } );
        validate_registrations( pimpl_->overmap_specials, "overmap special", check_engine_state,
        []( const std::string &id ) { return overmap_special_id( id ).is_valid(); } );
        validate_registrations( pimpl_->vehicle_parts, "vehicle part", check_engine_state,
        []( const std::string &id ) { return vpart_id( id ).is_valid(); } );
        validate_registrations( pimpl_->vehicles, "vehicle", check_engine_state,
        []( const std::string &id ) { return vproto_id( id ).is_valid(); } );
        for( const registration<faction_data> &entry : pimpl_->factions ) {
            const faction_data &faction = *entry.definition;
            if( faction.food_calories < 0 || faction.food_calories >
                std::numeric_limits<std::int64_t>::max() / 1000 ) {
                throw std::runtime_error( "faction '" + faction.id +
                                          "' has invalid food calories" );
            }
            for( const auto &[vitamin, amount] : faction.food_vitamins ) {
                if( vitamin.empty() || amount < 0 ) {
                    throw std::runtime_error( "faction '" + faction.id +
                                              "' has invalid food vitamins" );
                }
            }
            for( const auto &[target, flags] : faction.relations ) {
                if( target.empty() ) {
                    throw std::runtime_error( "faction '" + faction.id +
                                              "' has an empty relation target" );
                }
                for( const std::string &flag : flags ) {
                    if( npc_factions::relation_strs.count( flag ) == 0 ) {
                        throw std::runtime_error( "faction '" + faction.id +
                                                  "' has unknown relation flag '" + flag + "'" );
                    }
                }
            }
            for( const faction_epilogue_data_definition &epilogue : faction.epilogues ) {
                if( epilogue.id.empty() ) {
                    throw std::runtime_error( "faction '" + faction.id +
                                              "' has an epilogue without an id" );
                }
                for( const faction_epilogue_condition_data &condition : epilogue.dynamic ) {
                    if( condition.faction.empty() ||
                        ( !condition.power_min && !condition.power_max ) ) {
                        throw std::runtime_error( "faction '" + faction.id +
                                                  "' has an invalid dynamic epilogue condition" );
                    }
                }
            }
            for( const price_rule_data &rule : faction.price_rules ) {
                if( !rule.condition_handler.empty() &&
                    !runtime_has_handler( owner_runtime, rule.condition_handler ) ) {
                    throw std::runtime_error( "faction '" + faction.id +
                                              "' price rule references missing handler '" +
                                              rule.condition_handler + "'" );
                }
            }
        }
        for( const registration<npc_class_data> &entry : pimpl_->npc_classes ) {
            const npc_class_data &npc_class = *entry.definition;
            if( !std::isfinite( npc_class.common_spawn_weight ) ||
                npc_class.common_spawn_weight <= 0.0 ) {
                throw std::runtime_error( "NPC class '" + npc_class.id +
                                          "' has invalid common spawn weight" );
            }
            if( npc_class.restock_minutes < 0 || npc_class.restock_minutes >
                std::numeric_limits<int>::max() / 60 ||
                npc_class.work_hours.first < 0 || npc_class.work_hours.first > 24 ||
                npc_class.work_hours.second < 0 || npc_class.work_hours.second > 24 ) {
                throw std::runtime_error( "NPC class '" + npc_class.id +
                                          "' has invalid schedule values" );
            }
            for( const auto &[bionic, chance] : npc_class.bionics ) {
                if( bionic.empty() || chance < 0 || chance > 100 ) {
                    throw std::runtime_error( "NPC class '" + npc_class.id +
                                              "' has invalid bionic chance" );
                }
            }
            for( const shop_group_data &group : npc_class.shop_groups ) {
                if( !group.condition_handler.empty() &&
                    !runtime_has_handler( owner_runtime, group.condition_handler ) ) {
                    throw std::runtime_error( "NPC class '" + npc_class.id +
                                              "' shop group references missing handler '" +
                                              group.condition_handler + "'" );
                }
            }
            for( const price_rule_data &rule : npc_class.price_rules ) {
                if( !rule.condition_handler.empty() &&
                    !runtime_has_handler( owner_runtime, rule.condition_handler ) ) {
                    throw std::runtime_error( "NPC class '" + npc_class.id +
                                              "' price rule references missing handler '" +
                                              rule.condition_handler + "'" );
                }
            }
        }
        for( const registration<npc_data> &entry : pimpl_->npcs ) {
            const npc_data &definition = *entry.definition;
            if( !definition.death_handler.empty() &&
                !runtime_has_handler( owner_runtime, definition.death_handler ) ) {
                throw std::runtime_error( "NPC '" + definition.id +
                                          "' references missing death handler '" +
                                          definition.death_handler + "'" );
            }
        }
        for( const registration<overmap_terrain_data> &entry : pimpl_->overmap_terrains ) {
            if( UTF8_getch( entry.definition->symbol ) == UNKNOWN_UNICODE ||
                color_from_string( entry.definition->color, report_color_error::no ) == c_unset ) {
                throw std::runtime_error( "overmap terrain '" + entry.definition->id +
                                          "' has an invalid symbol or color" );
            }
            static_cast<void>( io::string_to_enum<oter_type_t::see_costs>(
                                    entry.definition->see_cost ) );
            static_cast<void>( io::string_to_enum<oter_travel_cost_type>(
                                    entry.definition->travel_cost ) );
            if( entry.definition->static_spawns &&
                ( entry.definition->static_spawns->group.empty() ||
                  entry.definition->static_spawns->population.minimum < 0 ||
                  entry.definition->static_spawns->population.maximum <
                  entry.definition->static_spawns->population.minimum ||
                  entry.definition->static_spawns->chance < 0 ||
                  entry.definition->static_spawns->chance > 100 ) ) {
                throw std::runtime_error( "overmap terrain '" + entry.definition->id +
                                          "' has invalid static spawns" );
            }
            for( const std::string *handler : {
                     &entry.definition->entry_handler, &entry.definition->exit_handler
                 } ) {
                if( !handler->empty() && !runtime_has_handler( owner_runtime, *handler ) ) {
                    throw std::runtime_error( "overmap terrain '" + entry.definition->id +
                                              "' references missing handler '" + *handler + "'" );
                }
            }
        }
        for( const registration<overmap_special_data> &entry : pimpl_->overmap_specials ) {
            const overmap_special_data &special = *entry.definition;
            for( const std::string *handler : {
                     &special.condition_handler, &special.placement_handler
                 } ) {
                if( !handler->empty() && !runtime_has_handler( owner_runtime, *handler ) ) {
                    throw std::runtime_error( "overmap special '" + special.id +
                                              "' references missing handler '" + *handler + "'" );
                }
            }
            if( special.city_size.minimum < 0 ||
                special.city_size.maximum < special.city_size.minimum ||
                special.city_distance.minimum < 0 ||
                special.city_distance.maximum < special.city_distance.minimum ||
                special.occurrences.minimum < 0 ||
                special.occurrences.maximum < special.occurrences.minimum ) {
                throw std::runtime_error( "overmap special '" + special.id +
                                          "' has invalid placement constraints" );
            }
            if( special.spawns &&
                ( special.spawns->group.empty() ||
                  special.spawns->population.minimum < 0 ||
                  special.spawns->population.maximum < special.spawns->population.minimum ||
                  special.spawns->radius.minimum < 0 ||
                  special.spawns->radius.maximum < special.spawns->radius.minimum ) ) {
                throw std::runtime_error( "overmap special '" + special.id +
                                          "' has invalid monster spawns" );
            }
            if( special.subtype == "fixed" ) {
                std::set<std::tuple<int, int, int>> points;
                for( const special_terrain_data &terrain : special.terrains ) {
                    if( !points.emplace( terrain.x, terrain.y, terrain.z ).second ) {
                        throw std::runtime_error( "overmap special '" + special.id +
                                                  "' has duplicate terrain coordinates" );
                    }
                    if( terrain.camp_owner.has_value() != !terrain.camp_name.empty() ) {
                        throw std::runtime_error( "overmap special '" + special.id +
                                                  "' terrain camp needs both owner and name" );
                    }
                }
            } else if( special.subtype == "mutable" ) {
                if( special.root.empty() || special.mutable_terrains.count( special.root ) == 0 ) {
                    throw std::runtime_error( "mutable overmap special '" + special.id +
                                              "' has an unknown root" );
                }
                std::set<std::string> join_ids;
                for( const special_join_data &join : special.joins ) {
                    if( join.id.empty() || !join_ids.insert( join.id ).second ) {
                        throw std::runtime_error( "mutable overmap special '" + special.id +
                                                  "' has an empty or duplicate join id" );
                    }
                }
                for( const special_join_data &join : special.joins ) {
                    if( !join.opposite.empty() && join_ids.count( join.opposite ) == 0 ) {
                        throw std::runtime_error( "mutable overmap special '" + special.id +
                                                  "' has an unknown opposite join '" +
                                                  join.opposite + "'" );
                    }
                }
                for( const auto &[terrain_id, terrain] : special.mutable_terrains ) {
                    if( terrain_id.empty() || terrain.terrain.empty() ||
                        terrain.camp_owner.has_value() != !terrain.camp_name.empty() ) {
                        throw std::runtime_error( "mutable overmap special '" + special.id +
                                                  "' has invalid terrain '" + terrain_id + "'" );
                    }
                    for( const auto &[direction, join] : terrain.joins ) {
                        static_cast<void>( read_cube_direction( direction ) );
                        if( join_ids.count( join.id ) == 0 ||
                            ( join.type != "mandatory" && join.type != "available" ) ) {
                            throw std::runtime_error( "mutable overmap special '" + special.id +
                                                      "' terrain has an invalid join" );
                        }
                        for( const std::string &alternative : join.alternatives ) {
                            if( join_ids.count( alternative ) == 0 ) {
                                throw std::runtime_error( "mutable overmap special '" +
                                                          special.id +
                                                          "' terrain has an unknown alternative join" );
                            }
                        }
                    }
                    for( const auto &[direction, connection] : terrain.connections ) {
                        static_cast<void>( read_cube_direction( direction ) );
                        if( connection.empty() ) {
                            throw std::runtime_error( "mutable overmap special '" + special.id +
                                                      "' terrain has an empty connection" );
                        }
                    }
                }
                if( special.phases.empty() ) {
                    throw std::runtime_error( "mutable overmap special '" + special.id +
                                              "' has no phases" );
                }
                for( const std::vector<mutable_special_rule_data> &phase : special.phases ) {
                    if( phase.empty() ) {
                        throw std::runtime_error( "mutable overmap special '" + special.id +
                                                  "' has an empty phase" );
                    }
                    for( const mutable_special_rule_data &rule : phase ) {
                        if( rule.pieces.empty() || ( !rule.maximum && !rule.weight ) ||
                            ( rule.weight && *rule.weight < 0 ) ||
                            ( rule.maximum &&
                              rule.maximum->type == integer_distribution_data::kind::fixed &&
                              rule.maximum->fixed < 0 ) ) {
                            throw std::runtime_error( "mutable overmap special '" + special.id +
                                                      "' has an invalid placement rule" );
                        }
                        std::set<std::tuple<int, int, int>> positions;
                        for( const mutable_special_piece_data &piece : rule.pieces ) {
                            if( special.mutable_terrains.count( piece.overmap ) == 0 ||
                                !positions.emplace( piece.x, piece.y, piece.z ).second ) {
                                throw std::runtime_error( "mutable overmap special '" +
                                                          special.id +
                                                          "' rule has an invalid piece" );
                            }
                            static_cast<void>( read_rotation( piece.rotation ) );
                        }
                    }
                }
            } else {
                throw std::runtime_error( "overmap special '" + special.id +
                                          "' has an unknown subtype" );
            }
        }
        std::set<std::string> staged_vehicle_parts;
        for( const registration<vehicle_part_data> &entry : pimpl_->vehicle_parts ) {
            const vehicle_part_data &part = *entry.definition;
            if( !part.copy_from.empty() && !vpart_id( part.copy_from ).is_valid() &&
                staged_vehicle_parts.count( part.copy_from ) == 0 ) {
                throw std::runtime_error( "vehicle part '" + part.id +
                                          "' has unknown copy_from '" + part.copy_from + "'" );
            }
            if( ( part.color && color_from_string( *part.color,
                                                  report_color_error::no ) == c_unset ) ||
                ( part.broken_color && color_from_string( *part.broken_color,
                        report_color_error::no ) == c_unset ) ) {
                throw std::runtime_error( "vehicle part '" + part.id +
                                          "' has an invalid color" );
            }
            if( part.light_color && std::any_of( part.light_color->begin(),
            part.light_color->end(), []( const int channel ) {
            return channel < 0 || channel > 255;
        } ) ) {
                throw std::runtime_error( "vehicle part '" + part.id +
                                          "' has an invalid light color" );
            }
            if( ( part.size_ml && *part.size_ml < 0 ) ||
                ( part.folded_volume_ml && *part.folded_volume_ml < 0 ) ||
                ( part.folding_time_seconds && *part.folding_time_seconds < 0 ) ||
                ( part.unfolding_time_seconds && *part.unfolding_time_seconds < 0 ) ||
                ( part.balloon_height && ( !std::isfinite( *part.balloon_height ) ||
                                           *part.balloon_height < 0.0f ) ) ) {
                throw std::runtime_error( "vehicle part '" + part.id +
                                          "' has invalid size or duration values" );
            }
            if( part.wheel &&
                ( !std::isfinite( part.wheel->rolling_resistance ) ||
                  !std::isfinite( part.wheel->offroad_rating ) ||
                  part.wheel->rolling_resistance < 0.0f || part.wheel->contact_area <= 0 ) ) {
                throw std::runtime_error( "vehicle part '" + part.id +
                                          "' has invalid wheel data" );
            }
            if( ( part.rotor_diameter && *part.rotor_diameter <= 0 ) ||
                ( part.propeller_diameter && *part.propeller_diameter <= 0 ) ||
                ( part.ladder_length && *part.ladder_length < 0 ) ) {
                throw std::runtime_error( "vehicle part '" + part.id +
                                          "' has invalid dimensional slot data" );
            }
            if( part.workbench &&
                ( !std::isfinite( part.workbench->multiplier ) ||
                  part.workbench->multiplier <= 0.0f || part.workbench->mass_grams < 0 ||
                  part.workbench->volume_ml < 0 ) ) {
                throw std::runtime_error( "vehicle part '" + part.id +
                                          "' has invalid workbench data" );
            }
            if( part.terrain_transform && part.terrain_transform->post_field &&
                ( part.terrain_transform->post_field_intensity <= 0 ||
                  part.terrain_transform->post_field_age_seconds < 0 ) ) {
                throw std::runtime_error( "vehicle part '" + part.id +
                                          "' has invalid terrain transform field data" );
            }
            if( !part.activation_handler.empty() &&
                !runtime_has_handler( owner_runtime, part.activation_handler ) ) {
                throw std::runtime_error( "vehicle part '" + part.id +
                                          "' references missing handler '" +
                                          part.activation_handler + "'" );
            }
            staged_vehicle_parts.insert( part.id );
        }
        std::set<std::string> staged_vehicles;
        for( const registration<vehicle_data> &entry : pimpl_->vehicles ) {
            const vehicle_data &vehicle = *entry.definition;
            if( !vehicle.copy_from.empty() && !vproto_id( vehicle.copy_from ).is_valid() &&
                staged_vehicles.count( vehicle.copy_from ) == 0 ) {
                throw std::runtime_error( "vehicle '" + vehicle.id +
                                          "' has unknown copy_from '" + vehicle.copy_from + "'" );
            }
            for( const vehicle_part_placement_data &part : vehicle.parts ) {
                if( part.part.empty() ||
                    ( !vpart_id( part.part ).is_valid() &&
                      staged_vehicle_parts.count( part.part ) == 0 ) ||
                    part.with_ammo < 0 || part.with_ammo > 100 ||
                    ( part.ammo_quantity.first >= 0 &&
                      part.ammo_quantity.second < part.ammo_quantity.first ) ) {
                    throw std::runtime_error( "vehicle '" + vehicle.id +
                                              "' has an invalid part placement" );
                }
            }
            for( const vehicle_item_data &spawn : vehicle.items ) {
                if( spawn.chance < 0 || spawn.chance > 100 ||
                    spawn.with_ammo < 0 || spawn.with_ammo > 100 ||
                    spawn.with_magazine < 0 || spawn.with_magazine > 100 ) {
                    throw std::runtime_error( "vehicle '" + vehicle.id +
                                              "' has an invalid item spawn" );
                }
            }
            staged_vehicles.insert( vehicle.id );
        }
        error.clear();
        return true;
    } catch( const std::exception &exception ) {
        error = "Lua-first Mod '" + pimpl_->owner + "': " + exception.what();
        return false;
    }
}

bool world_content_transaction::defines_overmap_terrain_type( const std::string &id ) const
{
    return std::any_of( pimpl_->overmap_terrains.begin(), pimpl_->overmap_terrains.end(),
    [&id]( const registration<overmap_terrain_data> &entry ) {
        return entry.definition->id == id;
    } );
}

bool world_content_transaction::find_overmap_terrain_handler(
    const std::string &id, const std::string &phase, std::string &handler_id ) const
{
    const auto found = std::find_if(
                           pimpl_->overmap_terrains.rbegin(), pimpl_->overmap_terrains.rend(),
    [&id]( const registration<overmap_terrain_data> & entry ) {
        return entry.definition->id == id;
    } );
    if( found == pimpl_->overmap_terrains.rend() ) {
        return false;
    }
    handler_id = phase == "entry" ? found->definition->entry_handler :
                 phase == "exit" ? found->definition->exit_handler : std::string();
    return true;
}

bool world_content_transaction::find_overmap_special_handler(
    const std::string &id, const std::string &phase, std::string &handler_id ) const
{
    const auto found = std::find_if(
                           pimpl_->overmap_specials.rbegin(), pimpl_->overmap_specials.rend(),
    [&id]( const registration<overmap_special_data> & entry ) {
        return entry.definition->id == id;
    } );
    if( found == pimpl_->overmap_specials.rend() ) {
        return false;
    }
    handler_id = phase == "condition" ? found->definition->condition_handler :
                 phase == "placement" ? found->definition->placement_handler : std::string();
    return true;
}

bool world_content_transaction::find_vehicle_part_handler(
    const std::string &id, const std::string &phase, std::string &handler_id ) const
{
    const auto found = std::find_if(
                           pimpl_->vehicle_parts.rbegin(), pimpl_->vehicle_parts.rend(),
    [&id]( const registration<vehicle_part_data> & entry ) {
        return entry.definition->id == id;
    } );
    if( found == pimpl_->vehicle_parts.rend() ) {
        return false;
    }
    handler_id = phase == "activation" ? found->definition->activation_handler : std::string();
    return true;
}

bool world_content_transaction::apply( std::string &error )
{
    if( pimpl_->applied ) {
        error = "world content transaction was already applied";
        return false;
    }
    try {
        for( const registration<faction_data> &entry : pimpl_->factions ) {
            const faction_data &source = *entry.definition;
            const faction_id id( source.id );
            std::vector<faction_template> &registry = detail::faction_template_registry();
            const auto previous = std::find_if( registry.begin(), registry.end(),
            [&id]( const faction_template &value ) { return value.id == id; } );
            pimpl_->faction_undo.emplace_back(
                id, previous == registry.end() ? std::nullopt :
                std::optional<faction_template>( *previous ) );
            if( previous != registry.end() ) {
                registry.erase( previous );
            }
            faction_template native;
            native.id = id;
            native.set_name( source.name );
            native.desc = no_translation( source.description );
            native.likes_u = source.likes;
            native.respects_u = source.respects;
            native.trusts_u = source.trusts;
            native.known_by_u = source.known;
            native.size = source.size;
            native.power = source.power;
            native.wealth = source.wealth;
            native.steal_persist = source.steal_persist;
            native.consumes_food = source.consumes_food;
            native.lone_wolf_faction = source.lone_wolf;
            native.limited_area_claim = source.limited_area;
            if( !source.currency.empty() ) {
                native.currency = itype_id( source.currency );
            } else {
                native.currency = itype_id::NULL_ID();
            }
            native.mon_faction = mfaction_str_id( source.monster_faction );
            if( source.food_calories > 0 || !source.food_vitamins.empty() ) {
                nutrients supply;
                supply.calories = static_cast<std::int64_t>( source.food_calories ) * 1000;
                for( const auto &[vitamin, amount] : source.food_vitamins ) {
                    supply.set_vitamin( vitamin_id( vitamin ), amount );
                }
                native.add_to_food_supply( { { calendar::turn_zero, std::move( supply ) } } );
            }
            for( const price_rule_data &rule : source.price_rules ) {
                icg_entry base{ itype_id( rule.item ), item_category_id( rule.category ),
                                item_group_id( rule.group ), no_translation( rule.message ), {}, {} };
                if( !rule.condition_handler.empty() ) {
                    const std::string mod = pimpl_->owner;
                    const std::string owner_id = source.id;
                    const std::string selector_kind = !rule.item.empty() ? "item" :
                                                      !rule.group.empty() ? "group" :
                                                      !rule.category.empty() ? "category" : "all";
                    const std::string selector_id = !rule.item.empty() ? rule.item :
                                                    !rule.group.empty() ? rule.group : rule.category;
                    const std::string handler = rule.condition_handler;
                    base.platform_condition = [mod, owner_id, selector_kind, selector_id,
                                                   handler]( const item & candidate,
                                                            const npc & shopkeeper ) {
                        return invoke_shop_condition_handler(
                                   mod, owner_id, "faction_price_rule", selector_kind,
                                   selector_id, handler, &candidate, shopkeeper ).value_or( false );
                    };
                }
                faction_price_rule native_rule( base );
                native_rule.markup = rule.markup;
                native_rule.premium = rule.premium;
                native_rule.fixed_adj = rule.fixed_adjustment;
                native_rule.price = rule.price;
                native.price_rules.push_back( std::move( native_rule ) );
            }
            if( !source.currency.empty() ) {
                native.price_rules.emplace_back( native.currency, 1.0, 0.0 );
            }
            for( const auto &[target, flags] : source.relations ) {
                std::bitset<static_cast<std::size_t>( npc_factions::relationship::rel_types )> bits;
                for( const std::string &flag : flags ) {
                    const auto relation = npc_factions::relation_strs.find( flag );
                    if( relation == npc_factions::relation_strs.end() ) {
                        throw std::runtime_error( "faction '" + source.id +
                                                  "' has unknown relation flag '" + flag + "'" );
                    }
                    bits.set( static_cast<std::size_t>( relation->second ) );
                }
                native.relations[target] = bits;
            }
            for( const faction_epilogue_data_definition &epilogue : source.epilogues ) {
                faction_epilogue_data native_epilogue;
                native_epilogue.epilogue = snippet_id( epilogue.id );
                native_epilogue.power_min = epilogue.power_min;
                native_epilogue.power_max = epilogue.power_max;
                for( const faction_epilogue_condition_data &condition :
                     epilogue.dynamic ) {
                    faction_power_spec native_condition;
                    native_condition.faction = faction_id( condition.faction );
                    native_condition.power_min = condition.power_min;
                    native_condition.power_max = condition.power_max;
                    native_epilogue.dynamic_conditions.push_back(
                        std::move( native_condition ) );
                }
                native.epilogue_data.push_back( std::move( native_epilogue ) );
            }
            registry.push_back( std::move( native ) );
        }

        for( const registration<npc_class_data> &entry : pimpl_->npc_classes ) {
            const npc_class_data &source = *entry.definition;
            const npc_class_id id( source.id );
            pimpl_->npc_class_undo.emplace_back(
                id, id.is_valid() ? std::optional<npc_class>( id.obj() ) : std::nullopt );
            npc_class native;
            native.id = id;
            native.src.emplace_back( id, mod_id( pimpl_->owner ) );
            native.was_loaded = true;
            native.name = no_translation( source.name );
            native.job_description = no_translation( source.job_description );
            native.common = source.common;
            native.common_spawn_weight = source.common_spawn_weight;
            native.sells_belongings = source.sells_belongings;
            native.worn_override = item_group_id( source.worn );
            native.carry_override = item_group_id( source.carry );
            native.weapon_override = item_group_id( source.weapon );
            native.bye_message_override = source.bye_message;
            native.traits = trait_group::Trait_group_tag( source.traits );
            native.shop_cons_rates_id = shopkeeper_cons_rates_id( source.consumption_rates );
            native.shop_blacklist_id = shopkeeper_blacklist_id( source.blacklist );
            native.shop_whitelist_id = shopkeeper_whitelist_id( source.whitelist );
            native.restock_interval = time_duration::from_minutes( source.restock_minutes );
            native.work_hours_ = source.work_hours;
            native.bonus_str = make_distribution( source.strength );
            native.bonus_dex = make_distribution( source.dexterity );
            native.bonus_int = make_distribution( source.intelligence );
            native.bonus_per = make_distribution( source.perception );
            native.bonus_aggression = make_distribution( source.aggression );
            native.bonus_bravery = make_distribution( source.bravery );
            native.bonus_collector = make_distribution( source.collector );
            native.bonus_altruism = make_distribution( source.altruism );
            for( const auto &[category, rounds] : source.mutation_rounds ) {
                native.mutation_rounds[mutation_category_id( category )] =
                    make_distribution( rounds );
            }
            for( const auto &[skill, value] : source.skills ) {
                native.skills[skill_id( skill )] = make_distribution( value );
            }
            for( const auto &[skill, value] : source.bonus_skills ) {
                native.bonus_skills[skill_id( skill )] = make_distribution( value );
            }
            for( const auto &[spell, level] : source.spells ) {
                native._starting_spells[spell_id( spell )] = level;
            }
            for( const auto &[bionic, chance] : source.bionics ) {
                native.bionic_list[bionic_id( bionic )] = chance;
            }
            for( const std::string &proficiency : source.proficiencies ) {
                native._starting_proficiencies.emplace_back( proficiency );
            }
            for( const shop_group_data &group : source.shop_groups ) {
                shopkeeper_item_group native_group( group.id, group.trust,
                                                    group.strict, group.rigid );
                if( !group.refusal.empty() ) {
                    native_group.refusal = no_translation( group.refusal );
                }
                if( !group.condition_handler.empty() ) {
                    const std::string mod = pimpl_->owner;
                    const std::string owner_id = source.id;
                    const std::string group_id = group.id;
                    const std::string handler = group.condition_handler;
                    native_group.platform_condition = [mod, owner_id, group_id, handler](
                    const npc & shopkeeper ) {
                        return invoke_shop_condition_handler(
                                   mod, owner_id, "npc_class_shop_group", "group", group_id,
                                   handler, nullptr, shopkeeper ).value_or( false );
                    };
                }
                native.shop_item_groups.push_back( std::move( native_group ) );
            }
            for( const price_rule_data &rule : source.price_rules ) {
                icg_entry base{ itype_id( rule.item ), item_category_id( rule.category ),
                                item_group_id( rule.group ), no_translation( rule.message ), {}, {} };
                if( !rule.condition_handler.empty() ) {
                    const std::string mod = pimpl_->owner;
                    const std::string owner_id = source.id;
                    const std::string selector_kind = !rule.item.empty() ? "item" :
                                                      !rule.group.empty() ? "group" :
                                                      !rule.category.empty() ? "category" : "all";
                    const std::string selector_id = !rule.item.empty() ? rule.item :
                                                    !rule.group.empty() ? rule.group : rule.category;
                    const std::string handler = rule.condition_handler;
                    base.platform_condition = [mod, owner_id, selector_kind, selector_id,
                                                   handler]( const item & candidate,
                                                            const npc & shopkeeper ) {
                        return invoke_shop_condition_handler(
                                   mod, owner_id, "npc_class_price_rule", selector_kind,
                                   selector_id, handler, &candidate, shopkeeper ).value_or( false );
                    };
                }
                faction_price_rule native_rule( base );
                native_rule.markup = rule.markup;
                native_rule.premium = rule.premium;
                native_rule.fixed_adj = rule.fixed_adjustment;
                native_rule.price = rule.price;
                native.shop_price_rules.push_back( std::move( native_rule ) );
            }
            detail::npc_class_registry().insert( native );
        }
        for( const registration<npc_data> &entry : pimpl_->npcs ) {
            const npc_data &source = *entry.definition;
            const npc_template_id id( source.id );
            std::map<npc_template_id, npc_template> &registry = npc_template::get_npc_templates();
            pimpl_->npc_undo.emplace_back( id, registry.extract( id ) );
            npc_template native;
            native.guy.idz = id;
            native.guy.myclass = npc_class_id( source.npc_class );
            if( !source.faction.empty() ) {
                native.guy.set_fac_id( source.faction );
            }
            native.guy.set_attitude( static_cast<npc_attitude>( source.attitude ) );
            native.guy.mission = io::string_to_enum<npc_mission>( source.mission );
            native.guy.chatbin.first_topic = source.chat;
            if( !source.stole_item_chat.empty() ) {
                native.guy.chatbin.talk_stole_item = source.stole_item_chat;
            }
            for( const std::string &mission : source.missions_offered ) {
                native.guy.miss_ids.emplace_back( mission );
            }
            for( const auto &[slot, topic] : source.dialogue_topics ) {
                set_npc_dialogue_topic( native.guy.chatbin, slot, topic );
            }
            for( const auto &[slot, text] : source.snippets ) {
                set_npc_snippet( native.snippets, slot, text );
            }
            native.name_unique = no_translation( source.unique_name );
            native.name_suffix = no_translation( source.suffix );
            native.temp_suffix = no_translation( source.temporary_suffix );
            native.gender_override = source.gender == "male" ? npc_template::gender::male :
                                     source.gender == "female" ? npc_template::gender::female :
                                     npc_template::gender::random;
            native.age = source.age;
            native.height = source.height;
            native.str = source.strength;
            native.dex = source.dexterity;
            native.intl = source.intelligence;
            native.per = source.perception;
            if( source.personality ) {
                native.personality.emplace();
                native.personality->aggression = ( *source.personality )[0];
                native.personality->bravery = ( *source.personality )[1];
                native.personality->collector = ( *source.personality )[2];
                native.personality->altruism = ( *source.personality )[3];
            }
            for( const std::string &eoc : source.death_eocs ) {
                native.guy.death_eocs.emplace_back( eoc );
            }
            native.guy.lua_platform_death_mod = pimpl_->owner;
            native.guy.lua_platform_death_handler = source.death_handler;
            registry.emplace( id, std::move( native ) );
        }

        for( const registration<overmap_terrain_data> &entry : pimpl_->overmap_terrains ) {
            const overmap_terrain_data &source = *entry.definition;
            const oter_type_str_id id( source.id );
            pimpl_->overmap_terrain_undo.push_back( {
                id, id.is_valid() ? std::optional<oter_type_t>( id.obj() ) : std::nullopt, {}
            } );
            if( pimpl_->overmap_terrain_undo.back().previous ) {
                for( const oter_id &terrain :
                     pimpl_->overmap_terrain_undo.back().previous->directional_peers ) {
                    detail::overmap_terrain_registry().erase( terrain.id() );
                }
            }
            oter_type_t native;
            native.id = id;
            native.src.emplace_back( id, mod_id( pimpl_->owner ) );
            native.was_loaded = true;
            native.name = no_translation( source.name );
            native.symbol = UTF8_getch( source.symbol );
            native.color = color_from_string( source.color, report_color_error::no );
            native.see_cost = io::string_to_enum<oter_type_t::see_costs>( source.see_cost );
            native.travel_cost_type = io::string_to_enum<oter_travel_cost_type>(
                                          source.travel_cost );
            native.default_map_data = string_id<map_data_summary>( source.default_map_data );
            native.vision_levels = oter_vision_id( source.vision_levels );
            native.land_use_code = overmap_land_use_code_id( source.land_use_code );
            native.extras = source.extras;
            native.connect_group = source.connect_group;
            native.entry_EOC = effect_on_condition_id( source.entry_eoc );
            native.exit_EOC = effect_on_condition_id( source.exit_eoc );
            if( source.uniform_terrain ) {
                native.uniform_terrain = ter_str_id( *source.uniform_terrain );
            }
            for( const std::string &looks_like : source.looks_like ) {
                native.looks_like.push_back( looks_like );
            }
            for( const std::string &generator : source.post_process_generators ) {
                native.post_process_generators.emplace_back( generator );
            }
            native.mondensity = source.monster_density;
            if( source.static_spawns ) {
                native.static_spawns.group = mongroup_id( source.static_spawns->group );
                native.static_spawns.population = {
                    source.static_spawns->population.minimum,
                    source.static_spawns->population.maximum
                };
                native.static_spawns.chance = source.static_spawns->chance;
            }
            for( const std::string &flag : source.flags ) {
                native.set_flag( io::string_to_enum<oter_flags>( flag ) );
            }
            detail::overmap_terrain_type_registry().insert( native );
        }

        for( const registration<overmap_special_data> &entry : pimpl_->overmap_specials ) {
            const overmap_special_data &source = *entry.definition;
            const overmap_special_id id( source.id );
            pimpl_->overmap_special_undo.emplace_back(
                id, id.is_valid() ? std::optional<overmap_special>( id.obj() ) : std::nullopt );
            overmap_special native;
            native.id = id;
            native.was_loaded = true;
            native.subtype_ = source.subtype == "mutable" ?
                              overmap_special_subtype::mutable_ : overmap_special_subtype::fixed;
            native.constraints_.city_size = { source.city_size.minimum, source.city_size.maximum };
            native.constraints_.city_distance = {
                source.city_distance.minimum, source.city_distance.maximum
            };
            native.constraints_.occurrences = {
                source.occurrences.minimum, source.occurrences.maximum
            };
            native.rotatable_ = source.rotate;
            native.priority_ = source.priority;
            native.flags_.insert( source.flags.begin(), source.flags.end() );
            if( !source.eoc.empty() ) {
                native.eoc = effect_on_condition_id( source.eoc );
                native.has_eoc_ = true;
            }
            if( source.spawns ) {
                native.monster_spawns_.group = mongroup_id( source.spawns->group );
                native.monster_spawns_.population = {
                    source.spawns->population.minimum, source.spawns->population.maximum
                };
                native.monster_spawns_.radius = {
                    source.spawns->radius.minimum, source.spawns->radius.maximum
                };
            }
            for( const std::string &location : source.default_locations ) {
                native.default_locations_.insert( overmap_location_id( location ) );
            }
            if( source.subtype == "fixed" ) {
                auto fixed = make_shared_fast<fixed_overmap_special_data>();
                for( const special_terrain_data &terrain : source.terrains ) {
                    cata::flat_set<overmap_location_id> locations;
                    for( const std::string &location : terrain.locations ) {
                        locations.insert( overmap_location_id( location ) );
                    }
                    fixed->terrains.emplace_back(
                        tripoint_rel_omt( terrain.x, terrain.y, terrain.z ),
                        oter_str_id( terrain.terrain ), locations, terrain.flags );
                    if( terrain.camp_owner ) {
                        fixed->terrains.back().camp_owner = faction_id( *terrain.camp_owner );
                        fixed->terrains.back().camp_name = no_translation( terrain.camp_name );
                    }
                }
                for( const special_connection_data &connection : source.connections ) {
                    overmap_special_connection native_connection;
                    native_connection.p = tripoint_rel_omt(
                                              connection.x, connection.y, connection.z );
                    if( connection.from ) {
                        native_connection.from = tripoint_rel_omt(
                                                     ( *connection.from )[0], ( *connection.from )[1],
                                                     ( *connection.from )[2] );
                    }
                    native_connection.terrain = oter_type_str_id( connection.terrain );
                    native_connection.connection = overmap_connection_id(
                                                       connection.connection );
                    native_connection.existing = connection.existing;
                    fixed->connections.push_back( std::move( native_connection ) );
                }
                native.data_ = std::move( fixed );
            } else {
                auto mutable_data = make_shared_fast<mutable_overmap_special_data>( id );
                for( const special_location_data &location : source.check_for_locations ) {
                    overmap_special_locations native_location;
                    native_location.p = tripoint_rel_omt(
                                            location.x, location.y, location.z );
                    for( const std::string &allowed : location.locations ) {
                        native_location.locations.insert( overmap_location_id( allowed ) );
                    }
                    mutable_data->check_for_locations.push_back(
                        std::move( native_location ) );
                }
                for( const special_join_data &join : source.joins ) {
                    mutable_overmap_join native_join;
                    native_join.id = join.id;
                    native_join.opposite_id = join.opposite;
                    for( const std::string &location : join.into_locations ) {
                        native_join.into_locations.insert( overmap_location_id( location ) );
                    }
                    mutable_data->joins_vec.push_back( std::move( native_join ) );
                }
                for( const auto &[terrain_id, terrain] : source.mutable_terrains ) {
                    mutable_overmap_terrain native_terrain;
                    native_terrain.terrain = oter_str_id( terrain.terrain );
                    for( const std::string &location : terrain.locations ) {
                        native_terrain.locations.insert( overmap_location_id( location ) );
                    }
                    for( const auto &[direction, join] : terrain.joins ) {
                        mutable_overmap_terrain_join native_join;
                        native_join.join_id = join.id;
                        native_join.alternative_join_ids.insert(
                            join.alternatives.begin(), join.alternatives.end() );
                        native_join.type = join.type == "available" ?
                                           join_type::available : join_type::mandatory;
                        native_terrain.joins.emplace(
                            read_cube_direction( direction ), std::move( native_join ) );
                    }
                    for( const auto &[direction, connection] : terrain.connections ) {
                        mutable_special_connection native_connection;
                        native_connection.connection = overmap_connection_id( connection );
                        native_terrain.connections.emplace(
                            read_cube_direction( direction ), std::move( native_connection ) );
                    }
                    if( terrain.camp_owner ) {
                        native_terrain.camp_owner = faction_id( *terrain.camp_owner );
                        native_terrain.camp_name = no_translation( terrain.camp_name );
                    }
                    mutable_data->overmaps.emplace( terrain_id, std::move( native_terrain ) );
                }
                mutable_data->root = source.root;
                for( const std::vector<mutable_special_rule_data> &phase : source.phases ) {
                    mutable_overmap_phase native_phase;
                    for( const mutable_special_rule_data &rule : phase ) {
                        mutable_overmap_placement_rule native_rule;
                        native_rule.name = rule.name;
                        if( rule.maximum ) {
                            native_rule.max = make_integer_distribution( *rule.maximum );
                        }
                        if( rule.weight ) {
                            native_rule.weight = *rule.weight;
                        }
                        for( const mutable_special_piece_data &piece : rule.pieces ) {
                            mutable_overmap_placement_rule_piece native_piece;
                            native_piece.overmap_id = piece.overmap;
                            native_piece.pos = tripoint_rel_omt(
                                                   piece.x, piece.y, piece.z );
                            native_piece.rot = read_rotation( piece.rotation );
                            native_rule.pieces.push_back( std::move( native_piece ) );
                        }
                        native_phase.rules.push_back( std::move( native_rule ) );
                    }
                    mutable_data->phases.push_back( std::move( native_phase ) );
                }
                native.data_ = std::move( mutable_data );
            }
            detail::overmap_special_registry().insert( native );
        }

        for( const registration<vehicle_part_data> &entry : pimpl_->vehicle_parts ) {
            const vehicle_part_data &source = *entry.definition;
            const vpart_id id( source.id );
            pimpl_->vehicle_part_undo.emplace_back(
                id, id.is_valid() ? std::optional<vpart_info>( id.obj() ) : std::nullopt );
            vpart_info native = source.copy_from.empty() ? vpart_info() :
                                vpart_id( source.copy_from ).obj();
            native.id = id;
            native.src.clear();
            native.src.emplace_back( id, mod_id( pimpl_->owner ) );
            native.was_loaded = true;
            if( source.name ) {
                native.name_ = no_translation( *source.name );
            }
            if( source.description ) {
                native.description = no_translation( *source.description );
            }
            if( source.item ) {
                native.base_item = itype_id( *source.item );
            }
            if( source.remove_as ) {
                native.removed_item = itype_id( *source.remove_as );
            }
            if( source.location ) {
                native.location = vpart_location_id( *source.location );
            }
            if( source.looks_like ) {
                native.looks_like = *source.looks_like;
            }
            if( source.color ) {
                native.color = color_from_string( *source.color, report_color_error::no );
            }
            if( source.broken_color ) {
                native.color_broken = color_from_string( *source.broken_color,
                                      report_color_error::no );
            }
            if( source.fuel_type ) {
                native.fuel_type = itype_id( *source.fuel_type );
            }
            if( source.default_ammo ) {
                native.default_ammo = itype_id( *source.default_ammo );
            }
            if( source.durability ) {
                native.durability = *source.durability;
            }
            if( source.size_ml ) {
                native.size = units::from_milliliter( *source.size_ml );
            }
            if( source.folded_volume_ml ) {
                native.folded_volume = units::from_milliliter( *source.folded_volume_ml );
            }
            if( source.damage_modifier ) {
                native.dmg_mod = *source.damage_modifier;
            }
            if( source.power_watts ) {
                native.power = units::from_watt( *source.power_watts );
            }
            if( source.epower_watts ) {
                native.epower = units::from_watt( *source.epower_watts );
            }
            if( source.energy_consumption_watts ) {
                native.energy_consumption = units::from_watt( *source.energy_consumption_watts );
            }
            if( source.bonus ) {
                native.bonus = *source.bonus;
            }
            if( source.light_color ) {
                native.light_color = {
                    ( *source.light_color )[0] / 255.0f,
                    ( *source.light_color )[1] / 255.0f,
                    ( *source.light_color )[2] / 255.0f
                };
            }
            if( source.cargo_weight_modifier ) {
                native.cargo_weight_modifier = *source.cargo_weight_modifier;
            }
            if( source.cargo_spoil_multiplier ) {
                native.cargo_spoil_multiplier = *source.cargo_spoil_multiplier;
            }
            if( source.comfort ) {
                native.comfort = *source.comfort;
            }
            if( source.floor_bedding_warmth_celsius ) {
                native.floor_bedding_warmth = units::from_celsius_delta(
                                                   *source.floor_bedding_warmth_celsius );
            }
            if( source.bonus_fire_warmth_feet_celsius ) {
                native.bonus_fire_warmth_feet = units::from_celsius_delta(
                                                    *source.bonus_fire_warmth_feet_celsius );
            }
            if( source.default_tint_color ) {
                native.default_tint_color_string = *source.default_tint_color;
            }
            if( source.activatable_eoc ) {
                native.activatable_eoc = effect_on_condition_id( *source.activatable_eoc );
            }
            if( source.emissions ) {
                native.emissions.clear();
                for( const std::string &emission : *source.emissions ) {
                    native.emissions.emplace( emission );
                }
            }
            if( source.exhaust ) {
                native.exhaust.clear();
                for( const std::string &emission : *source.exhaust ) {
                    native.exhaust.emplace( emission );
                }
            }
            if( source.enchantments ) {
                native.enchantments.clear();
                for( const std::string &enchantment : *source.enchantments ) {
                    native.enchantments.emplace_back( enchantment );
                }
            }
            if( source.balloon_height ) {
                native.balloon_info = vpslot_balloon{ true, *source.balloon_height };
            }
            if( source.categories ) {
                native.categories = *source.categories;
            }
            if( source.flags ) {
                native.flags.clear();
                native.bitflags.reset();
                for( const std::string &flag : *source.flags ) {
                    native.set_flag( flag );
                }
            }
            if( !source.activation_handler.empty() ) {
                native.set_flag( "EOC_ACTIVATION" );
            }
            if( source.variants ) {
                native.variants.clear();
                native.variant_default.clear();
                for( const vpart_variant_data &variant : *source.variants ) {
                    vpart_variant native_variant;
                    native_variant.id = variant.id;
                    native_variant.label_ = variant.label;
                    native_variant.symbols = read_variant_symbols( variant.symbols, source.id );
                    native_variant.symbols_broken = read_variant_symbols(
                                                        variant.broken_symbols, source.id );
                    if( native.variants.empty() ) {
                        native.variant_default = native_variant.id;
                    }
                    native.variants[native_variant.id] = std::move( native_variant );
                }
            }
            if( source.variant_bases ) {
                native.variants_bases = *source.variant_bases;
            }
            if( source.qualities ) {
                native.qualities.clear();
                for( const auto &[quality, level] : *source.qualities ) {
                    native.qualities[quality_id( quality )] = level;
                }
            }
            if( source.pseudo_tools ) {
                native.pseudo_tools.clear();
                for( const vpart_pseudo_tool_data &tool : *source.pseudo_tools ) {
                    native.pseudo_tools.emplace( itype_id( tool.id ), tool.hotkey );
                }
            }
            if( source.folding_tools ) {
                native.folding_tools.clear();
                for( const std::string &tool : *source.folding_tools ) {
                    native.folding_tools.emplace_back( tool );
                }
            }
            if( source.unfolding_tools ) {
                native.unfolding_tools.clear();
                for( const std::string &tool : *source.unfolding_tools ) {
                    native.unfolding_tools.emplace_back( tool );
                }
            }
            if( source.folding_time_seconds ) {
                native.folding_time = time_duration::from_seconds(
                                          *source.folding_time_seconds );
            }
            if( source.unfolding_time_seconds ) {
                native.unfolding_time = time_duration::from_seconds(
                                            *source.unfolding_time_seconds );
            }
            if( source.fuel_options_set || source.backfire_threshold ||
                source.backfire_frequency || source.damaged_power_factor ||
                source.noise_factor || source.m2c || source.muscle_power_factor ||
                source.engine_exclusions ) {
                if( !native.engine_info ) {
                    native.engine_info.emplace();
                }
                native.engine_info->was_loaded = true;
                if( source.backfire_threshold ) {
                    native.engine_info->backfire_threshold = *source.backfire_threshold;
                }
                if( source.backfire_frequency ) {
                    native.engine_info->backfire_freq = *source.backfire_frequency;
                }
                if( source.damaged_power_factor ) {
                    native.engine_info->damaged_power_factor = *source.damaged_power_factor;
                }
                if( source.noise_factor ) {
                    native.engine_info->noise_factor = *source.noise_factor;
                }
                if( source.m2c ) {
                    native.engine_info->m2c = *source.m2c;
                }
                if( source.muscle_power_factor ) {
                    native.engine_info->muscle_power_factor = *source.muscle_power_factor;
                }
                if( source.engine_exclusions ) {
                    native.engine_info->exclusions.assign(
                        source.engine_exclusions->begin(), source.engine_exclusions->end() );
                }
                if( source.fuel_options_set ) {
                    native.engine_info->fuel_opts.clear();
                    for( const std::string &fuel : source.fuel_options ) {
                        native.engine_info->fuel_opts.emplace_back( fuel );
                    }
                }
            }
            if( source.wheel ) {
                native.wheel_info.emplace();
                native.wheel_info->was_loaded = true;
                native.wheel_info->rolling_resistance = source.wheel->rolling_resistance;
                native.wheel_info->contact_area = source.wheel->contact_area;
                native.wheel_info->offroad_rating = source.wheel->offroad_rating;
                native.wheel_info->terrain_modifiers.clear();
                for( const vpart_wheel_terrain_modifier_data &modifier :
                     source.wheel->terrain_modifiers ) {
                    native.wheel_info->terrain_modifiers.push_back( {
                        modifier.flag, modifier.move_override, modifier.move_penalty
                    } );
                }
            }
            if( source.rotor_diameter ) {
                native.rotor_info = vpslot_rotor{ true, *source.rotor_diameter };
            }
            if( source.propeller_diameter ) {
                native.propeller_info = vpslot_propeller{
                    true, *source.propeller_diameter
                };
            }
            if( source.ladder_length ) {
                native.ladder_info = vpslot_ladder{ *source.ladder_length };
            }
            if( source.workbench ) {
                native.workbench_info.emplace();
                native.workbench_info->multiplier = source.workbench->multiplier;
                native.workbench_info->allowed_mass = units::from_gram(
                                                          source.workbench->mass_grams );
                native.workbench_info->allowed_volume = units::from_milliliter(
                                                            source.workbench->volume_ml );
            }
            if( source.toolkit_allowed_tools ) {
                native.toolkit_info.emplace();
                native.toolkit_info->was_loaded = true;
                native.toolkit_info->allowed_types.clear();
                for( const std::string &tool : *source.toolkit_allowed_tools ) {
                    native.toolkit_info->allowed_types.emplace( tool );
                }
            }
            if( source.terrain_transform ) {
                native.transform_terrain_info.emplace();
                native.transform_terrain_info->pre_flags =
                    source.terrain_transform->pre_flags;
                if( source.terrain_transform->post_terrain ) {
                    native.transform_terrain_info->post_terrain = ter_str_id(
                                *source.terrain_transform->post_terrain );
                }
                if( source.terrain_transform->post_furniture ) {
                    native.transform_terrain_info->post_furniture = furn_str_id(
                                *source.terrain_transform->post_furniture );
                }
                if( source.terrain_transform->post_field ) {
                    native.transform_terrain_info->post_field = field_type_str_id(
                                *source.terrain_transform->post_field );
                    native.transform_terrain_info->post_field_intensity =
                        source.terrain_transform->post_field_intensity;
                    native.transform_terrain_info->post_field_age =
                        time_duration::from_seconds(
                            source.terrain_transform->post_field_age_seconds );
                }
            }
            if( !source.breaks_into.empty() ) {
                native.breaks_into_group = item_group_id( source.breaks_into );
            }
            if( source.damage_reduction_set ) {
                native.damage_reduction.clear();
            }
            for( const auto &[damage, amount] : source.damage_reduction ) {
                native.damage_reduction[damage_type_id( damage )] = amount;
            }
            const auto apply_requirement = []( const vpart_requirement_data &value,
            std::vector<std::pair<requirement_id, int>> &requirements,
            std::map<skill_id, int> &skills, time_duration &time ) {
                if( !value.id.empty() ) {
                    requirements = { { requirement_id( value.id ), value.multiplier } };
                }
                if( !value.using_requirements.empty() ) {
                    requirements.clear();
                    for( const auto &[id, multiplier] : value.using_requirements ) {
                        requirements.emplace_back( requirement_id( id ), multiplier );
                    }
                }
                for( const auto &[skill, level] : value.skills ) {
                    skills[skill_id( skill )] = level;
                }
                if( value.time_minutes >= 0 ) {
                    time = time_duration::from_minutes( value.time_minutes );
                }
            };
            apply_requirement( source.install, native.install_reqs,
                               native.install_skills, native.install_moves );
            apply_requirement( source.removal, native.removal_reqs,
                               native.removal_skills, native.removal_moves );
            apply_requirement( source.repair, native.repair_reqs,
                               native.repair_skills, native.repair_moves );
            if( source.air_proficiencies ) {
                native.control_air.proficiencies.clear();
                for( const std::string &proficiency : *source.air_proficiencies ) {
                    native.control_air.proficiencies.emplace( proficiency );
                }
            }
            if( source.land_proficiencies ) {
                native.control_land.proficiencies.clear();
                for( const std::string &proficiency : *source.land_proficiencies ) {
                    native.control_land.proficiencies.emplace( proficiency );
                }
            }
            if( source.air_skills ) {
                native.control_air.skills.clear();
                for( const auto &[skill, level] : *source.air_skills ) {
                    native.control_air.skills.emplace( skill_id( skill ), level );
                }
            }
            if( source.land_skills ) {
                native.control_land.skills.clear();
                for( const auto &[skill, level] : *source.land_skills ) {
                    native.control_land.skills.emplace( skill_id( skill ), level );
                }
            }
            detail::vehicle_part_registry().insert( native );
        }

        for( const registration<vehicle_data> &entry : pimpl_->vehicles ) {
            const vehicle_data &source = *entry.definition;
            const vproto_id id( source.id );
            pimpl_->vehicle_undo.emplace_back(
                id, id.is_valid() ? std::optional<vehicle_prototype>( id.obj() ) : std::nullopt );
            vehicle_prototype native = source.copy_from.empty() ? vehicle_prototype() :
                                       vproto_id( source.copy_from ).obj();
            native.id = id;
            if( source.name ) {
                native.name = no_translation( *source.name );
            } else if( source.copy_from.empty() ) {
                native.name = no_translation( source.id );
            }
            native.src.clear();
            native.src.emplace_back( id, mod_id( pimpl_->owner ) );
            native.was_loaded = true;
            native.blueprint.reset();
            if( source.color_palette_set ) {
                native.color_palette = vpalette_id( source.color_palette );
            }
            for( const vehicle_part_placement_data &part : source.parts ) {
                vehicle_prototype::part_def native_part;
                native_part.pos = point_rel_ms( part.x, part.y );
                native_part.part = vpart_id( part.part );
                native_part.variant = part.variant;
                native_part.with_ammo = part.with_ammo;
                for( const std::string &ammo : part.ammo_types ) {
                    native_part.ammo_types.emplace( ammo );
                }
                native_part.ammo_qty = part.ammo_quantity;
                if( !part.fuel.empty() ) {
                    native_part.fuel = itype_id( part.fuel );
                }
                for( const std::string &tool : part.tools ) {
                    native_part.tools.emplace_back( tool );
                }
                native.parts.push_back( std::move( native_part ) );
            }
            if( source.items_set ) {
                native.item_spawns.clear();
            }
            for( const vehicle_item_data &spawn : source.items ) {
                vehicle_item_spawn native_spawn;
                native_spawn.pos = point_rel_ms( spawn.x, spawn.y );
                native_spawn.chance = spawn.chance;
                native_spawn.with_ammo = spawn.with_ammo;
                native_spawn.with_magazine = spawn.with_magazine;
                for( const auto &[item, variant] : spawn.items ) {
                    native_spawn.item_ids.emplace_back( itype_id( item ), variant );
                }
                for( const std::string &group : spawn.groups ) {
                    native_spawn.item_groups.emplace_back( group );
                }
                native.item_spawns.push_back( std::move( native_spawn ) );
            }
            if( source.zones_set ) {
                native.zone_defs.clear();
            }
            for( const vehicle_zone_data &zone : source.zones ) {
                native.zone_defs.push_back( {
                    zone_type_id( zone.type ), zone.name, zone.filter,
                    point_rel_ms( zone.x, zone.y )
                } );
            }
            const VehicleGroup *previous_group =
                detail::vehicle_group_registry_find( source.id );
            pimpl_->vehicle_self_group_undo.emplace_back(
                source.id, previous_group ? std::optional<VehicleGroup>( *previous_group ) :
                std::nullopt );
            VehicleGroup self_group = previous_group ? *previous_group : VehicleGroup();
            self_group.add_vehicle( id, 100 );
            detail::vehicle_group_registry_set( source.id, self_group );
            detail::vehicle_prototype_registry().insert( native );
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

bool world_content_transaction::validate_finalized( std::string &error ) const
{
    if( !pimpl_->applied ) {
        error = "world content transaction is not applied";
        return false;
    }
    const auto validate = [&error]( const auto &entries, auto make_id, const char *kind ) {
        for( const auto &entry : entries ) {
            if( !make_id( entry.definition->id ).is_valid() ) {
                error = std::string( "Lua-first " ) + kind + " '" + entry.definition->id +
                        "' did not survive global finalization";
                return false;
            }
        }
        return true;
    };
    const std::vector<faction_template> &factions = detail::faction_template_registry();
    for( const registration<faction_data> &entry : pimpl_->factions ) {
        if( std::none_of( factions.begin(), factions.end(), [&entry]( const faction_template &value ) {
        return value.id == faction_id( entry.definition->id );
    } ) ) {
            error = "Lua-first faction '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    if( !validate( pimpl_->npc_classes, []( const std::string &id ) {
    return npc_class_id( id );
}, "NPC class" ) ||
    !validate( pimpl_->npcs, []( const std::string &id ) {
    return npc_template_id( id );
}, "NPC" ) ||
    !validate( pimpl_->overmap_terrains, []( const std::string &id ) {
    return oter_type_str_id( id );
}, "overmap terrain" ) ||
    !validate( pimpl_->overmap_specials, []( const std::string &id ) {
    return overmap_special_id( id );
}, "overmap special" ) ||
    !validate( pimpl_->vehicle_parts, []( const std::string &id ) {
    return vpart_id( id );
}, "vehicle part" ) ||
    !validate( pimpl_->vehicles, []( const std::string &id ) {
    return vproto_id( id );
}, "vehicle" ) ) {
        return false;
    }
    error.clear();
    return true;
}

void world_content_transaction::rollback()
{
    const bool rebuild_vehicles = !pimpl_->vehicle_undo.empty() ||
                                  !pimpl_->vehicle_part_undo.empty();
    for( auto it = pimpl_->vehicle_undo.rbegin(); it != pimpl_->vehicle_undo.rend(); ++it ) {
        if( it->second ) {
            detail::vehicle_prototype_registry().restore( *it->second );
        } else {
            detail::vehicle_prototype_registry().erase( it->first );
        }
    }
    pimpl_->vehicle_undo.clear();
    for( auto it = pimpl_->vehicle_self_group_undo.rbegin();
         it != pimpl_->vehicle_self_group_undo.rend(); ++it ) {
        if( it->second ) {
            detail::vehicle_group_registry_set( it->first, *it->second );
        } else {
            detail::vehicle_group_registry_erase( it->first );
        }
    }
    pimpl_->vehicle_self_group_undo.clear();
    for( auto it = pimpl_->vehicle_part_undo.rbegin();
         it != pimpl_->vehicle_part_undo.rend(); ++it ) {
        if( it->second ) {
            detail::vehicle_part_registry().restore( *it->second );
        } else {
            detail::vehicle_part_registry().erase( it->first );
        }
    }
    pimpl_->vehicle_part_undo.clear();
    if( rebuild_vehicles ) {
        vehicles::finalize_prototypes();
    }
    for( auto it = pimpl_->overmap_special_undo.rbegin();
         it != pimpl_->overmap_special_undo.rend(); ++it ) {
        if( it->second ) {
            detail::overmap_special_registry().restore( *it->second );
        } else {
            detail::overmap_special_registry().erase( it->first );
        }
    }
    pimpl_->overmap_special_undo.clear();
    for( auto it = pimpl_->overmap_terrain_undo.rbegin();
         it != pimpl_->overmap_terrain_undo.rend(); ++it ) {
        std::vector<oter_id> generated = it->generated;
        if( generated.empty() && it->id.is_valid() ) {
            generated = it->id.obj().directional_peers;
        }
        for( const oter_id &terrain : generated ) {
            detail::overmap_terrain_registry().erase( terrain.id() );
        }
        detail::overmap_terrain_type_registry().erase( it->id );
        if( it->previous ) {
            oter_type_t &restored = detail::overmap_terrain_type_registry().restore(
                                        *it->previous );
            restored.finalize();
        }
    }
    pimpl_->overmap_terrain_undo.clear();
    std::map<npc_template_id, npc_template> &npc_registry = npc_template::get_npc_templates();
    for( auto it = pimpl_->npc_undo.rbegin(); it != pimpl_->npc_undo.rend(); ++it ) {
        npc_registry.erase( it->first );
        if( !it->second.empty() ) {
            npc_registry.insert( std::move( it->second ) );
        }
    }
    pimpl_->npc_undo.clear();
    for( auto it = pimpl_->npc_class_undo.rbegin();
         it != pimpl_->npc_class_undo.rend(); ++it ) {
        if( it->second ) {
            detail::npc_class_registry().restore( *it->second );
        } else {
            detail::npc_class_registry().erase( it->first );
        }
    }
    pimpl_->npc_class_undo.clear();
    std::vector<faction_template> &factions = detail::faction_template_registry();
    for( auto it = pimpl_->faction_undo.rbegin(); it != pimpl_->faction_undo.rend(); ++it ) {
        const auto current = std::find_if( factions.begin(), factions.end(),
        [&it]( const faction_template &value ) { return value.id == it->first; } );
        if( current != factions.end() ) {
            factions.erase( current );
        }
        if( it->second ) {
            factions.push_back( *it->second );
        }
    }
    pimpl_->faction_undo.clear();
    pimpl_->applied = false;
}

void world_content_transaction::commit()
{
    pimpl_->faction_undo.clear();
    pimpl_->npc_class_undo.clear();
    pimpl_->npc_undo.clear();
    pimpl_->overmap_terrain_undo.clear();
    pimpl_->overmap_special_undo.clear();
    pimpl_->vehicle_part_undo.clear();
    pimpl_->vehicle_undo.clear();
    pimpl_->vehicle_self_group_undo.clear();
    pimpl_->handle_token->state = lifecycle::committed;
}

void world_content_transaction::seal()
{
    if( pimpl_->handle_token->state == lifecycle::building ) {
        pimpl_->handle_token->state = lifecycle::committed;
    }
}

void world_content_transaction::discard()
{
    rollback();
    pimpl_->handle_token->state = lifecycle::discarded;
}

void world_content_transaction::append_fingerprint( std::uint64_t &state ) const
{
    hash_registrations( state, "faction", pimpl_->factions );
    hash_registrations( state, "npc_class", pimpl_->npc_classes );
    hash_registrations( state, "npc", pimpl_->npcs );
    hash_registrations( state, "overmap_terrain", pimpl_->overmap_terrains );
    hash_registrations( state, "overmap_special", pimpl_->overmap_specials );
    hash_registrations( state, "vehicle_part", pimpl_->vehicle_parts );
    hash_registrations( state, "vehicle", pimpl_->vehicles );
}

} // namespace cata::lua

#else

namespace cata::lua
{

struct world_content_transaction::impl {};

world_content_transaction::world_content_transaction( std::string, std::size_t ) :
    pimpl_( std::make_unique<impl>() )
{
}

world_content_transaction::~world_content_transaction() = default;

bool world_content_transaction::validate( const runtime &, bool, std::string &error ) const
{
    error.clear();
    return true;
}

bool world_content_transaction::defines_overmap_terrain_type( const std::string & ) const
{
    return false;
}

bool world_content_transaction::find_overmap_terrain_handler(
    const std::string &, const std::string &, std::string &handler_id ) const
{
    handler_id.clear();
    return false;
}

bool world_content_transaction::find_overmap_special_handler(
    const std::string &, const std::string &, std::string &handler_id ) const
{
    handler_id.clear();
    return false;
}

bool world_content_transaction::find_vehicle_part_handler(
    const std::string &, const std::string &, std::string &handler_id ) const
{
    handler_id.clear();
    return false;
}

bool world_content_transaction::apply( std::string &error )
{
    error.clear();
    return true;
}

bool world_content_transaction::validate_finalized( std::string &error ) const
{
    error.clear();
    return true;
}

void world_content_transaction::rollback() {}
void world_content_transaction::commit() {}
void world_content_transaction::seal() {}
void world_content_transaction::discard() {}
void world_content_transaction::append_fingerprint( std::uint64_t & ) const {}

} // namespace cata::lua

#endif
