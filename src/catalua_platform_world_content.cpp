#include "catalua_platform_world_content.h"

#if defined(CATA_ENABLE_LUA_UI) && CATA_ENABLE_LUA_UI

#include <algorithm>
#include <array>
#include <bitset>
#include <cmath>
#include <cstddef>
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
#include "catalua_platform_content.h"
#include "color.h"
#include "coordinates.h"
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

namespace cata::lua_platform
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
        dice
    };
    kind type = kind::constant;
    int first = 0;
    int second = 0;
    int add = 0;
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
    int food_calories = 0;
    std::map<std::string, int> food_vitamins;
    bool consumes_food = false;
    bool lone_wolf = false;
    bool limited_area = false;
    std::string currency;
    std::string monster_faction = "human";
    std::map<std::string, std::set<std::string>> relations;
};

struct price_rule_data {
    std::string item;
    std::string group;
    std::string category;
    double markup = 1.0;
    double premium = 1.0;
    std::optional<double> fixed_adjustment;
    std::optional<int> price;
};

struct shop_group_data {
    std::string id;
    int trust = 0;
    bool strict = false;
    bool rigid = false;
};

struct npc_class_data : definition_base {
    std::string name;
    std::string job_description;
    bool common = false;
    bool sells_belongings = true;
    std::string worn;
    std::string carry;
    std::string weapon;
    std::string traits = "EMPTY_GROUP";
    std::string consumption_rates;
    distribution_data strength;
    distribution_data dexterity;
    distribution_data intelligence;
    distribution_data perception;
    std::map<std::string, distribution_data> skills;
    std::map<std::string, distribution_data> bonus_skills;
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
    std::optional<int> age;
    std::optional<int> height;
};

struct overmap_terrain_data : definition_base {
    std::string name;
    std::string symbol = "?";
    std::string color = "white";
    std::string see_cost = "none";
    std::string default_map_data = "full_omt";
    std::string vision_levels = "default";
    int monster_density = 0;
    std::set<std::string> flags;
};

struct special_terrain_data {
    int x = 0;
    int y = 0;
    int z = 0;
    std::string terrain;
    std::set<std::string> locations;
    std::set<std::string> flags;
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

struct overmap_special_data : definition_base {
    std::vector<special_terrain_data> terrains;
    std::vector<special_connection_data> connections;
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

struct vehicle_part_data : definition_base {
    std::string copy_from;
    std::optional<std::string> name;
    std::optional<std::string> description;
    std::optional<std::string> item;
    std::optional<std::string> location;
    std::optional<std::string> looks_like;
    std::optional<std::string> color;
    std::optional<std::string> broken_color;
    std::optional<std::string> fuel_type;
    std::optional<int> durability;
    std::optional<int> size_ml;
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
    std::optional<std::set<std::string>> categories;
    std::optional<std::set<std::string>> flags;
    std::optional<std::vector<vpart_variant_data>> variants;
    std::vector<std::string> fuel_options;
    std::map<std::string, float> damage_reduction;
    std::string breaks_into;
    vpart_requirement_data install;
    vpart_requirement_data removal;
    vpart_requirement_data repair;
    std::optional<std::set<std::string>> air_proficiencies;
    std::optional<std::set<std::string>> land_proficiencies;
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
    std::vector<std::string> items;
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
    std::string name;
    std::string color_palette;
    std::vector<vehicle_part_placement_data> parts;
    std::vector<vehicle_item_data> items;
    std::vector<vehicle_zone_data> zones;
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

distribution_data read_distribution( const sol::optional<sol::table> &source )
{
    distribution_data result;
    if( !source ) {
        return result;
    }
    result.add = source->get_or( "add", 0 );
    if( const sol::optional<sol::table> random = source->get<sol::optional<sol::table>>( "rng" ) ) {
        const std::vector<int> values = read_dense_array<int>( *random, "distribution rng" );
        if( values.size() != 2 ) {
            throw std::invalid_argument( "distribution rng must have two integers" );
        }
        result.type = distribution_data::kind::random;
        result.first = values[0];
        result.second = values[1];
    } else if( const sol::optional<sol::table> dice =
                   source->get<sol::optional<sol::table>>( "dice" ) ) {
        const std::vector<int> values = read_dense_array<int>( *dice, "distribution dice" );
        if( values.size() != 2 ) {
            throw std::invalid_argument( "distribution dice must have two integers" );
        }
        result.type = distribution_data::kind::dice;
        result.first = values[0];
        result.second = values[1];
    } else {
        result.first = source->get_or( "constant", 0 );
    }
    return result;
}

distribution make_distribution( const distribution_data &source )
{
    distribution result;
    switch( source.type ) {
        case distribution_data::kind::constant:
            result = distribution::constant( source.first );
            break;
        case distribution_data::kind::random:
            result = distribution::rng_roll( source.first, source.second );
            break;
        case distribution_data::kind::dice:
            result = distribution::dice_roll( source.first, source.second );
            break;
    }
    return source.add == 0 ? result : result + distribution::constant( source.add );
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
    for( const auto &[faction, flags] : value.relations ) {
        hash_part( state, faction );
        hash_strings( state, flags );
    }
}

void hash_definition( std::uint64_t &state, const npc_class_data &value )
{
    hash_part( state, value.id );
    hash_part( state, value.name );
    hash_part( state, value.job_description );
    hash_bool( state, value.common );
    hash_bool( state, value.sells_belongings );
    hash_part( state, value.worn );
    hash_part( state, value.carry );
    hash_part( state, value.weapon );
    hash_part( state, value.traits );
    hash_part( state, value.consumption_rates );
    hash_distribution( state, value.strength );
    hash_distribution( state, value.dexterity );
    hash_distribution( state, value.intelligence );
    hash_distribution( state, value.perception );
    for( const auto &[skill, distribution] : value.skills ) {
        hash_part( state, skill );
        hash_distribution( state, distribution );
    }
    for( const auto &[skill, distribution] : value.bonus_skills ) {
        hash_part( state, skill );
        hash_distribution( state, distribution );
    }
    for( const shop_group_data &group : value.shop_groups ) {
        hash_part( state, group.id );
        hash_number( state, group.trust );
        hash_bool( state, group.strict );
        hash_bool( state, group.rigid );
    }
    for( const price_rule_data &rule : value.price_rules ) {
        hash_part( state, rule.item );
        hash_part( state, rule.group );
        hash_part( state, rule.category );
        hash_number( state, rule.markup );
        hash_number( state, rule.premium );
        hash_optional_number( state, rule.fixed_adjustment );
        hash_optional_number( state, rule.price );
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
    hash_optional_number( state, value.age );
    hash_optional_number( state, value.height );
}

void hash_definition( std::uint64_t &state, const overmap_terrain_data &value )
{
    hash_part( state, value.id );
    hash_part( state, value.name );
    hash_part( state, value.symbol );
    hash_part( state, value.color );
    hash_part( state, value.see_cost );
    hash_part( state, value.default_map_data );
    hash_part( state, value.vision_levels );
    hash_number( state, value.monster_density );
    hash_strings( state, value.flags );
}

void hash_definition( std::uint64_t &state, const overmap_special_data &value )
{
    hash_part( state, value.id );
    for( const special_terrain_data &terrain : value.terrains ) {
        hash_number( state, terrain.x );
        hash_number( state, terrain.y );
        hash_number( state, terrain.z );
        hash_part( state, terrain.terrain );
        hash_strings( state, terrain.locations );
        hash_strings( state, terrain.flags );
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
    hash_optional_string( state, value.location );
    hash_optional_string( state, value.looks_like );
    hash_optional_string( state, value.color );
    hash_optional_string( state, value.broken_color );
    hash_optional_string( state, value.fuel_type );
    hash_optional_number( state, value.durability );
    hash_optional_number( state, value.size_ml );
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
    hash_optional_strings( state, value.categories );
    hash_optional_strings( state, value.flags );
    hash_part( state, value.variants ? "present" : "absent" );
    if( value.variants ) {
        for( const vpart_variant_data &variant : *value.variants ) {
            hash_part( state, variant.id );
            hash_part( state, variant.label );
            hash_part( state, variant.symbols );
            hash_part( state, variant.broken_symbols );
        }
    }
    hash_strings( state, value.fuel_options );
    for( const auto &[damage, amount] : value.damage_reduction ) {
        hash_part( state, damage );
        hash_number( state, amount );
    }
    hash_part( state, value.breaks_into );
    hash_vpart_requirement( state, value.install );
    hash_vpart_requirement( state, value.removal );
    hash_vpart_requirement( state, value.repair );
    hash_optional_strings( state, value.air_proficiencies );
    hash_optional_strings( state, value.land_proficiencies );
}

void hash_definition( std::uint64_t &state, const vehicle_data &value )
{
    hash_part( state, value.id );
    hash_part( state, value.name );
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
        hash_strings( state, item.items );
        hash_strings( state, item.groups );
    }
    for( const vehicle_zone_data &zone : value.zones ) {
        hash_number( state, zone.x );
        hash_number( state, zone.y );
        hash_part( state, zone.type );
        hash_part( state, zone.name );
        hash_part( state, zone.filter );
    }
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
        value->food_calories = options.get_or( "food_calories", 0 );
        if( const sol::optional<sol::table> vitamins =
                options.get<sol::optional<sol::table>>( "food_vitamins" ) ) {
            for( const auto &entry : *vitamins ) {
                value->food_vitamins[entry.first.as<std::string>()] = entry.second.as<int>();
            }
        }
        value->consumes_food = options.get_or( "consumes_food", false );
        value->lone_wolf = options.get_or( "lone_wolf", false );
        value->limited_area = options.get_or( "limited_area", false );
        value->currency = options.get_or( "currency", std::string() );
        value->monster_faction = options.get_or( "monster_faction", std::string( "human" ) );
        if( const sol::optional<sol::table> relations =
                options.get<sol::optional<sol::table>>( "relations" ) ) {
            for( const auto &entry : *relations ) {
                const std::string target = entry.first.as<std::string>();
                value->relations[target] = read_string_set(
                                               entry.second.as<sol::table>(), "faction relations" );
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
        value->common = options.get_or( "common", false );
        value->sells_belongings = options.get_or( "sells_belongings", true );
        value->worn = options.get_or( "worn", std::string() );
        value->carry = options.get_or( "carry", std::string() );
        value->weapon = options.get_or( "weapon", std::string() );
        value->traits = options.get_or( "traits", std::string( "EMPTY_GROUP" ) );
        value->consumption_rates = options.get_or( "consumption_rates", std::string() );
        value->strength = read_distribution(
                              options.get<sol::optional<sol::table>>( "strength" ) );
        value->dexterity = read_distribution(
                               options.get<sol::optional<sol::table>>( "dexterity" ) );
        value->intelligence = read_distribution(
                                  options.get<sol::optional<sol::table>>( "intelligence" ) );
        value->perception = read_distribution(
                                options.get<sol::optional<sol::table>>( "perception" ) );
        const auto read_skills = []( const sol::optional<sol::table> &source,
        std::map<std::string, distribution_data> &target ) {
            if( !source ) {
                return;
            }
            for( const auto &entry : *source ) {
                target[entry.first.as<std::string>()] = read_distribution(
                        entry.second.as<sol::table>() );
            }
        };
        read_skills( options.get<sol::optional<sol::table>>( "skills" ), value->skills );
        read_skills( options.get<sol::optional<sol::table>>( "bonus_skills" ),
                     value->bonus_skills );
        if( const sol::optional<sol::table> groups =
                options.get<sol::optional<sol::table>>( "shop_groups" ) ) {
            for( const sol::table &group : read_dense_array<sol::table>( *groups,
                    "NPC class shop groups" ) ) {
                value->shop_groups.push_back( {
                    group.get_or( "id", std::string() ), group.get_or( "trust", 0 ),
                    group.get_or( "strict", false ), group.get_or( "rigid", false )
                } );
            }
        }
        if( const sol::optional<sol::table> rules =
                options.get<sol::optional<sol::table>>( "price_rules" ) ) {
            for( const sol::table &rule : read_dense_array<sol::table>( *rules,
                    "NPC class price rules" ) ) {
                price_rule_data parsed;
                parsed.item = rule.get_or( "item", std::string() );
                parsed.group = rule.get_or( "group", std::string() );
                parsed.category = rule.get_or( "category", std::string() );
                parsed.markup = rule.get_or( "markup", 1.0 );
                parsed.premium = rule.get_or( "premium", 1.0 );
                parsed.fixed_adjustment = read_optional<double>( rule, "fixed_adjustment" );
                parsed.price = read_optional<int>( rule, "price" );
                value->price_rules.push_back( std::move( parsed ) );
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
        value->age = read_optional<int>( options, "age" );
        value->height = read_optional<int>( options, "height" );
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
        value->default_map_data = options.get_or( "default_map_data", std::string( "full_omt" ) );
        value->vision_levels = options.get_or( "vision_levels", std::string( "default" ) );
        value->monster_density = options.get_or( "monster_density", 0 );
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
        value->default_locations = read_string_set(
                                       options.get<sol::optional<sol::table>>( "locations" ),
                                       "overmap special locations" );
        value->flags = read_string_set(
                           options.get<sol::optional<sol::table>>( "flags" ), "overmap special flags" );
        value->city_size = read_interval(
                               options.get<sol::optional<sol::table>>( "city_size" ), value->city_size,
                               "overmap special city size" );
        value->city_distance = read_interval(
                                   options.get<sol::optional<sol::table>>( "city_distance" ),
                                   value->city_distance, "overmap special city distance" );
        value->occurrences = read_interval(
                                 options.get<sol::optional<sol::table>>( "occurrences" ), value->occurrences,
                                 "overmap special occurrences" );
        value->priority = options.get_or( "priority", 0 );
        value->rotate = options.get_or( "rotate", true );
        if( const sol::optional<sol::table> terrains =
                options.get<sol::optional<sol::table>>( "terrains" ) ) {
            for( const sol::table &terrain : read_dense_array<sol::table>( *terrains,
                    "overmap special terrains" ) ) {
                const std::array<int, 3> point = read_point(
                        terrain.get<sol::table>( "point" ), "overmap special point" );
                value->terrains.push_back( {
                    point[0], point[1], point[2],
                    terrain.get_or( "terrain", std::string() ),
                    read_string_set( terrain.get<sol::optional<sol::table>>( "locations" ),
                                     "overmap special terrain locations" ),
                    read_string_set( terrain.get<sol::optional<sol::table>>( "flags" ),
                                     "overmap special terrain flags" )
                } );
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
        return special_handle{ std::move( value ), owner };
    } );
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
        value->location = read_optional<std::string>( options, "location" );
        value->looks_like = read_optional<std::string>( options, "looks_like" );
        value->color = read_optional<std::string>( options, "color" );
        value->broken_color = read_optional<std::string>( options, "broken_color" );
        value->fuel_type = read_optional<std::string>( options, "fuel_type" );
        value->durability = read_optional<int>( options, "durability" );
        value->size_ml = read_optional<int>( options, "size_ml" );
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
        if( const sol::optional<sol::table> categories =
                options.get<sol::optional<sol::table>>( "categories" ) ) {
            value->categories = read_string_set( categories, "vehicle part categories" );
        }
        if( const sol::optional<sol::table> flags =
                options.get<sol::optional<sol::table>>( "flags" ) ) {
            value->flags = read_string_set( flags, "vehicle part flags" );
        }
        value->fuel_options = read_string_vector(
                                  options.get<sol::optional<sol::table>>( "fuel_options" ),
                                  "vehicle part fuel options" );
        value->breaks_into = options.get_or( "breaks_into", std::string() );
        if( const sol::optional<sol::table> reductions =
                options.get<sol::optional<sol::table>>( "damage_reduction" ) ) {
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
        }
        return vpart_handle{ std::move( value ), owner };
    } );
    content.set_function( "Vehicle", [owner]( const sol::table &options ) {
        if( owner->state != lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto value = std::make_shared<vehicle_data>();
        value->id = options.get_or( "id", std::string() );
        value->name = options.get_or( "name", value->id );
        value->color_palette = options.get_or( "color_palette", std::string() );
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
            for( const sol::table &item : read_dense_array<sol::table>( *items,
                    "vehicle item spawns" ) ) {
                vehicle_item_data parsed;
                parsed.x = item.get_or( "x", 0 );
                parsed.y = item.get_or( "y", 0 );
                parsed.chance = item.get_or( "chance", 0 );
                parsed.with_ammo = item.get_or( "with_ammo", 0 );
                parsed.with_magazine = item.get_or( "with_magazine", 0 );
                parsed.items = read_string_vector(
                                   item.get<sol::optional<sol::table>>( "items" ), "vehicle spawn items" );
                parsed.groups = read_string_vector(
                                    item.get<sol::optional<sol::table>>( "groups" ), "vehicle spawn groups" );
                value->items.push_back( std::move( parsed ) );
            }
        }
        if( const sol::optional<sol::table> zones =
                options.get<sol::optional<sol::table>>( "zones" ) ) {
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

bool world_content_transaction::validate( const bool check_engine_state,
        std::string &error ) const
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
        for( const registration<overmap_terrain_data> &entry : pimpl_->overmap_terrains ) {
            if( UTF8_getch( entry.definition->symbol ) == UNKNOWN_UNICODE ||
                color_from_string( entry.definition->color, report_color_error::no ) == c_unset ) {
                throw std::runtime_error( "overmap terrain '" + entry.definition->id +
                                          "' has an invalid symbol or color" );
            }
        }
        for( const registration<vehicle_part_data> &entry : pimpl_->vehicle_parts ) {
            if( !entry.definition->copy_from.empty() &&
                !vpart_id( entry.definition->copy_from ).is_valid() ) {
                throw std::runtime_error( "vehicle part '" + entry.definition->id +
                                          "' has unknown copy_from '" + entry.definition->copy_from + "'" );
            }
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
            native.consumes_food = source.consumes_food;
            native.lone_wolf_faction = source.lone_wolf;
            native.limited_area_claim = source.limited_area;
            if( !source.currency.empty() ) {
                native.currency = itype_id( source.currency );
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
            native.sells_belongings = source.sells_belongings;
            native.worn_override = item_group_id( source.worn );
            native.carry_override = item_group_id( source.carry );
            native.weapon_override = item_group_id( source.weapon );
            native.traits = trait_group::Trait_group_tag( source.traits );
            native.shop_cons_rates_id = shopkeeper_cons_rates_id( source.consumption_rates );
            native.bonus_str = make_distribution( source.strength );
            native.bonus_dex = make_distribution( source.dexterity );
            native.bonus_int = make_distribution( source.intelligence );
            native.bonus_per = make_distribution( source.perception );
            for( const auto &[skill, value] : source.skills ) {
                native.skills[skill_id( skill )] = make_distribution( value );
            }
            for( const auto &[skill, value] : source.bonus_skills ) {
                native.bonus_skills[skill_id( skill )] = make_distribution( value );
            }
            for( const shop_group_data &group : source.shop_groups ) {
                native.shop_item_groups.emplace_back( group.id, group.trust,
                                                      group.strict, group.rigid );
            }
            for( const price_rule_data &rule : source.price_rules ) {
                icg_entry base{ itype_id( rule.item ), item_category_id( rule.category ),
                                item_group_id( rule.group ), translation(), {} };
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
            native.name_unique = no_translation( source.unique_name );
            native.name_suffix = no_translation( source.suffix );
            native.temp_suffix = no_translation( source.temporary_suffix );
            native.gender_override = source.gender == "male" ? npc_template::gender::male :
                                     source.gender == "female" ? npc_template::gender::female :
                                     npc_template::gender::random;
            native.age = source.age;
            native.height = source.height;
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
            native.default_map_data = string_id<map_data_summary>( source.default_map_data );
            native.vision_levels = oter_vision_id( source.vision_levels );
            native.mondensity = source.monster_density;
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
            native.subtype_ = overmap_special_subtype::fixed;
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
            for( const std::string &location : source.default_locations ) {
                native.default_locations_.insert( overmap_location_id( location ) );
            }
            auto fixed = make_shared_fast<fixed_overmap_special_data>();
            for( const special_terrain_data &terrain : source.terrains ) {
                cata::flat_set<overmap_location_id> locations;
                for( const std::string &location : terrain.locations ) {
                    locations.insert( overmap_location_id( location ) );
                }
                fixed->terrains.emplace_back(
                    tripoint_rel_omt( terrain.x, terrain.y, terrain.z ),
                    oter_str_id( terrain.terrain ), locations, terrain.flags );
            }
            for( const special_connection_data &connection : source.connections ) {
                overmap_special_connection native_connection;
                native_connection.p = tripoint_rel_omt( connection.x, connection.y, connection.z );
                if( connection.from ) {
                    native_connection.from = tripoint_rel_omt(
                                                 ( *connection.from )[0], ( *connection.from )[1],
                                                 ( *connection.from )[2] );
                }
                native_connection.terrain = oter_type_str_id( connection.terrain );
                native_connection.connection = overmap_connection_id( connection.connection );
                native_connection.existing = connection.existing;
                fixed->connections.push_back( std::move( native_connection ) );
            }
            native.data_ = std::move( fixed );
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
            if( source.durability ) {
                native.durability = *source.durability;
            }
            if( source.size_ml ) {
                native.size = units::from_milliliter( *source.size_ml );
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
            if( !source.fuel_options.empty() || source.backfire_threshold ||
                source.backfire_frequency || source.damaged_power_factor ||
                source.noise_factor || source.m2c ) {
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
                if( !source.fuel_options.empty() ) {
                    native.engine_info->fuel_opts.clear();
                    for( const std::string &fuel : source.fuel_options ) {
                        native.engine_info->fuel_opts.emplace_back( fuel );
                    }
                }
            }
            if( !source.breaks_into.empty() ) {
                native.breaks_into_group = item_group_id( source.breaks_into );
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
            detail::vehicle_part_registry().insert( native );
        }

        for( const registration<vehicle_data> &entry : pimpl_->vehicles ) {
            const vehicle_data &source = *entry.definition;
            const vproto_id id( source.id );
            pimpl_->vehicle_undo.emplace_back(
                id, id.is_valid() ? std::optional<vehicle_prototype>( id.obj() ) : std::nullopt );
            vehicle_prototype native;
            native.id = id;
            native.name = no_translation( source.name );
            native.src.emplace_back( id, mod_id( pimpl_->owner ) );
            native.was_loaded = true;
            native.color_palette = vpalette_id( source.color_palette );
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
            for( const vehicle_item_data &spawn : source.items ) {
                vehicle_item_spawn native_spawn;
                native_spawn.pos = point_rel_ms( spawn.x, spawn.y );
                native_spawn.chance = spawn.chance;
                native_spawn.with_ammo = spawn.with_ammo;
                native_spawn.with_magazine = spawn.with_magazine;
                for( const std::string &item : spawn.items ) {
                    native_spawn.item_ids.emplace_back( itype_id( item ), std::string() );
                }
                for( const std::string &group : spawn.groups ) {
                    native_spawn.item_groups.emplace_back( group );
                }
                native.item_spawns.push_back( std::move( native_spawn ) );
            }
            for( const vehicle_zone_data &zone : source.zones ) {
                native.zone_defs.push_back( {
                    zone_type_id( zone.type ), zone.name, zone.filter,
                    point_rel_ms( zone.x, zone.y )
                } );
            }
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

} // namespace cata::lua_platform

#else

namespace cata::lua_platform
{

struct world_content_transaction::impl {};

world_content_transaction::world_content_transaction( std::string, std::size_t ) :
    pimpl_( std::make_unique<impl>() )
{
}

world_content_transaction::~world_content_transaction() = default;

bool world_content_transaction::validate( bool, std::string &error ) const
{
    error.clear();
    return true;
}

bool world_content_transaction::defines_overmap_terrain_type( const std::string & ) const
{
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

} // namespace cata::lua_platform

#endif
