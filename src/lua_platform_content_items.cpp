#include "lua_platform_content_items.h"
#include "lua_platform_content_text.h"
#include "lua_platform_runtime.h"

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <character_id.h>
#include <damage.h>
#include <explosion.h>
#include <fire.h>
#include <flat_set.h>
#include <game_constants.h>
#include <item_pocket.h>
#include <item_uid.h>
#include <magic.h>
#include <math_parser_diag_value.h>
#include <monster_uid.h>
#include <pocket_type.h>
#include <stomach.h>
#include <value_ptr.h>
#include <vehicle_uid.h>
#include <exception>
#include <initializer_list>
#include <optional>

#include <algorithm>
#include <cctype>
#include <cmath>
#include <cstdint>
#include <functional>
extern "C" {
#include <lua.h>
}
#include <limits>
#include <map>
#include <set>
#include <sstream>
#include <stdexcept>
#include <string_view>
#include <tuple>
#include <type_traits>
#include <unordered_map>
#include <utility>
#include <variant>

#include "ammo.h"
#include "ammo_effect.h"
#include "bonuses.h"
#include "butchery.h"
#include "butchery_requirements.h"
#include "body_part_set.h"
#include "bodypart.h"
#include "build_reqs.h"
#include "calendar.h"
#include "color.h"
#include "coordinates.h"
#include "crafting_gui.h"
#include "creature.h"
#include "debug.h"
#include "effect.h"
#include "enum_conversions.h"
#include "enums.h"
#include "flag.h"
#include "generic_factory.h"
#include "init.h"
#include "item.h"
#include "item_action.h"
#include "item_category.h"
#include "item_factory.h"
#include "item_group.h"
#include "item_transformation.h"
#include "itype.h"
#include "iuse.h"
#include "iuse_actor.h"
#include "json.h"
#include "lua_platform_content.h"
#include "lua_platform_values.h"
#include "martialarts.h"
#include "material.h"
#include "mod_tracker.h"
#include "math_parser_diag.h"
#include "math_parser_jmath.h"
#include "options.h"
#include "proficiency.h"
#include "recipe.h"
#include "recipe_dictionary.h"
#include "recipe_groups.h"
#include "relic.h"
#include "requirements.h"
#include "scent_map.h"
#include "skill.h"
#include "sounds.h"
#include "subbodypart.h"
#include "translation.h"
#include "type_id.h"
#include "units.h"
#include "vitamin.h"

static const damage_type_id damage_heat( "heat" );

namespace cata::lua_platform
{

using detail::authored_text;
using detail::localized_text;
using detail::read_singular_text;

namespace
{

authored_text read_text_option( const sol::table &options, const char *key,
                                const authored_text &fallback, const std::string &field )
{
    return detail::read_singular_text_or( options.get<sol::object>( key ), fallback, field );
}

enum class definition_operation : int { add, replace, edit, extend, upsert };
enum class handle_lifecycle : int { building, committed, discarded };

std::size_t require_dense_array( const sol::table &values,
                                 const std::string_view description,
                                 const std::size_t minimum,
                                 const std::size_t maximum = std::numeric_limits<std::size_t>::max() )
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

struct owner_token {
    std::string mod_id;
    std::size_t generation = 0;
    handle_lifecycle lifecycle = handle_lifecycle::building;
};

struct material_part {
    std::string id;
    std::int64_t portions = 1;
};

struct quality_level {
    std::string id;
    std::int64_t level = 1;
    float speed = 1.0f;
};

quality_level read_item_quality( const std::string &id, const std::int64_t level,
                                 const double speed )
{
    if( id.empty() || level < std::numeric_limits<int>::min() ||
        level > std::numeric_limits<int>::max() || !std::isfinite( speed ) ||
        speed <= 0.0 || speed > std::numeric_limits<float>::max() ||
        static_cast<float>( speed ) == 0.0f ) {
        throw std::runtime_error( "item quality requires an id, native level and positive speed" );
    }
    return { id, level, static_cast<float>( speed ) };
}

struct item_numeric_adjustment {
    std::optional<double> factor;
    std::int64_t offset = 0;
};

struct item_measurement_changes {
    std::optional<item_numeric_adjustment> mass;
    std::optional<item_numeric_adjustment> volume;
    std::optional<item_numeric_adjustment> length;
    std::optional<item_numeric_adjustment> price;
    std::optional<item_numeric_adjustment> postapoc_price;
    std::optional<item_numeric_adjustment> accuracy;

    static constexpr std::pair<const char *, std::optional<item_numeric_adjustment>
           item_measurement_changes::*> fields[] = {
        { "mass_milligrams", &item_measurement_changes::mass },
        { "volume_ml", &item_measurement_changes::volume },
        { "longest_side_mm", &item_measurement_changes::length },
        { "price_cents", &item_measurement_changes::price },
        { "price_postapoc_cents", &item_measurement_changes::postapoc_price },
        { "melee_to_hit", &item_measurement_changes::accuracy }
    };
};

template<typename T>
T apply_item_adjustment( T current, const item_numeric_adjustment &adjustment )
{
    constexpr auto minimum = std::numeric_limits<T>::min();
    constexpr auto maximum = std::numeric_limits<T>::max();
    if( adjustment.factor ) {
        const double result = std::trunc( current * *adjustment.factor );
        if( result < static_cast<double>( minimum ) ||
            result >= -static_cast<double>( minimum ) ) {
            throw std::runtime_error( "scaled item measurement exceeds its native range" );
        }
        return static_cast<T>( result );
    }
    const std::int64_t offset = adjustment.offset;
    if( ( offset > 0 && current > maximum - offset ) ||
        ( offset < 0 && current < minimum - offset ) ) {
        throw std::runtime_error( "item measurement offset exceeds its native range" );
    }
    return static_cast<T>( current + offset );
}

template<typename V, typename U>
void apply_item_adjustment( units::quantity<V, U> &current,
                            const std::optional<item_numeric_adjustment> &adjustment )
{
    if( adjustment ) {
        current = units::quantity<V, U>( apply_item_adjustment( current.value(), *adjustment ), U{} );
    }
}

int item_option_int( const std::int64_t value, const char *field )
{
    if( value < std::numeric_limits<int>::min() || value > std::numeric_limits<int>::max() ) {
        throw std::invalid_argument( std::string( field ) + " exceeds the native item integer range" );
    }
    return static_cast<int>( value );
}

float item_option_float( const sol::table &options, const char *field, double fallback )
{
    const double value = options.get_or<double>( field, fallback );
    if( !std::isfinite( value ) || std::abs( value ) > std::numeric_limits<float>::max() ) {
        throw std::invalid_argument( std::string( field ) + " exceeds the native item number range" );
    }
    return static_cast<float>( value );
}

std::optional<int> read_nonnegative_item_int( const sol::table &options, const char *field )
{
    const auto raw = options.get<sol::optional<std::int64_t>>( field );
    if( !raw ) {
        return std::nullopt;
    }
    const int value = item_option_int( *raw, field );
    if( value < 0 ) {
        throw std::invalid_argument( std::string( field ) + " cannot be negative" );
    }
    return value;
}

damage_instance read_item_damage( const sol::table &entries )
{
    const std::size_t count = require_dense_array( entries, "item damage entries", 0 );
    damage_instance result;
    for( std::size_t index = 1; index <= count; ++index ) {
        const sol::table options = entries.raw_get<sol::table>( index );
        const std::string type = options.get<std::string>( "type" );
        if( type.empty() ) {
            throw std::invalid_argument( "item damage type cannot be empty" );
        }
        result.add_damage( damage_type_id( type ),
                           item_option_float( options, "amount", 0.0 ),
                           item_option_float( options, "armor_penetration", 0.0 ),
                           item_option_float( options, "armor_multiplier", 1.0 ),
                           item_option_float( options, "damage_multiplier", 1.0 ),
                           item_option_float( options, "constant_armor_multiplier", 1.0 ),
                           item_option_float( options, "constant_damage_multiplier", 1.0 ) );
    }
    return result;
}

throw_correction_data read_throw_correction( const sol::table &options )
{
    throw_correction_data correction;
    if( const auto flags = options.get<sol::optional<sol::table>>( "required_flags" ) ) {
        const std::size_t count = require_dense_array( *flags, "throw correction flag alternatives", 0 );
        for( std::size_t i = 1; i <= count; ++i ) {
            const sol::table required = flags->raw_get<sol::table>( i );
            const std::size_t clause_size = require_dense_array( required, "throw correction flag clause", 1 );
            std::vector<flag_id> clause;
            for( std::size_t j = 1; j <= clause_size; ++j ) {
                clause.emplace_back( required.raw_get<std::string>( j ) );
            }
            correction.required_flags.push_back( std::move( clause ) );
        }
    }
    if( const auto ammo = options.get<sol::optional<sol::table>>( "allowed_ammo" ) ) {
        const std::size_t count = require_dense_array( *ammo, "throw correction ammunition types", 0 );
        for( std::size_t index = 1; index <= count; ++index ) {
            correction.allowed_ammo.emplace( ammo->raw_get<std::string>( index ) );
        }
    }
    const auto mass = [&options]( const char *field ) -> std::optional<units::mass> {
        const auto value = options.get<sol::optional<std::int64_t>>( field );
        if( !value ) {
            return std::nullopt;
        }
        if( *value < 0 ) {
            throw std::invalid_argument( std::string( field ) + " cannot be negative" );
        }
        return units::from_milligram( *value );
    };
    correction.min_weight = mass( "min_mass_milligrams" );
    correction.max_weight = mass( "max_mass_milligrams" );
    if( correction.min_weight && correction.max_weight && *correction.min_weight > *correction.max_weight ) {
        throw std::invalid_argument( "throw correction minimum mass exceeds its maximum" );
    }
    if( const auto volume = read_nonnegative_item_int( options, "max_volume_ml" ) ) {
        correction.max_volume = units::from_milliliter( *volume );
    }
    if( const auto length = read_nonnegative_item_int( options, "max_length_mm" ) ) {
        correction.max_length = units::from_millimeter( *length );
    }
    correction.full_bonus_skill = read_nonnegative_item_int( options, "full_bonus_skill" );
    correction.damage_multiplier = item_option_float( options, "damage_multiplier", 1.0 );
    correction.range_multiplier = item_option_float( options, "range_multiplier", 1.0 );
    correction.stamina_multiplier = item_option_float( options, "stamina_multiplier", 1.0 );
    correction.dispersion_multiplier = item_option_float( options, "dispersion_multiplier", 1.0 );
    correction.speed_multiplier = item_option_float( options, "speed_multiplier", 1.0 );
    correction.weight_multiplier = item_option_float( options, "weight_multiplier", 1.0 );
    correction.was_loaded = true;
    return correction;
}

item_transformation read_item_transformation( const sol::table &options )
{
    item_transformation result;
    result.target = itype_id( options.get_or( "target", std::string() ) );
    result.target_group = item_group_id( options.get_or( "target_group", std::string() ) );
    result.container = itype_id( options.get_or( "container", std::string() ) );
    result.ammo_type = itype_id( options.get_or( "ammo_type", std::string() ) );
    result.variant_type = options.get_or( "variant", std::string( "<any>" ) );
    result.sealed = options.get_or( "sealed", true );
    const auto charges = options.get<sol::optional<std::int64_t>>( "charges" );
    if( charges ) {
        result.ammo_qty = item_option_int( *charges, "transformation charges" );
    }
    if( const auto range = options.get<sol::optional<sol::table>>( "random_charges" ) ) {
        if( charges ) {
            throw std::invalid_argument( "item transformation cannot specify fixed and random charges" );
        }
        const std::size_t count = require_dense_array( *range, "transformation random charges", 2 );
        result.random_ammo_qty.reserve( count );
        for( std::size_t i = 1; i <= count; ++i ) {
            result.random_ammo_qty.push_back( item_option_int( range->raw_get<std::int64_t>( i ),
                                              "transformation random charges" ) );
        }
    }
    const int timer = item_option_int( options.get_or<std::int64_t>( "timer_turns", 0 ),
                                      "transformation timer" );
    if( result.target.is_empty() == result.target_group.is_empty() ||
        ( !result.container.is_empty() && ( !result.ammo_type.is_empty() || result.target.is_empty() ) ) ||
        timer < 0 ) {
        throw std::invalid_argument( "invalid item transformation target, packaging, ammunition or timer" );
    }
    result.target_timer = time_duration::from_turns( timer );
    return result;
}

struct item_transform_action {
    item_transformation result;
    authored_text message;
    authored_text menu_text;
    authored_text not_ready;
    std::optional<authored_text> damage_failure_message;
    std::optional<authored_text> need_charges_message;
    std::optional<authored_text> need_fire_message;
    std::optional<int> minimum_age;
    std::optional<int> ammo_scale;
    int moves = 0;
    int chance = 100;
    int sound_volume = 0;
    int need_charges = 0;
    int need_fire = 0;
    bool set_timer = false;
    bool need_empty = false;
    bool need_wielding = false;
    bool need_worn = false;
};

item_transform_action read_item_transform_action( const sol::table &options )
{
    item_transform_action action;
    action.result = read_item_transformation( options.get<sol::table>( "result" ) );
    action.message = read_text_option( options, "message", {}, "item transform message" );
    action.menu_text = read_text_option( options, "menu_text", {}, "item transform menu text" );
    action.moves = item_option_int( options.get_or<std::int64_t>( "moves", 0 ), "item transform move cost" );
    if( action.moves < 0 ) {
        throw std::invalid_argument( "item transform move cost cannot be negative" );
    }
    action.need_empty = options.get_or( "need_empty", false );
    action.need_wielding = options.get_or( "need_wielding", false );
    action.need_worn = options.get_or( "need_worn", false );
    action.chance = read_nonnegative_item_int( options, "chance" ).value_or( 100 );
    action.sound_volume = item_option_int( options.get_or<std::int64_t>( "sound_volume", 0 ),
                                           "item transform sound volume" );
    action.need_charges = read_nonnegative_item_int( options, "need_charges" ).value_or( 0 );
    action.need_fire = read_nonnegative_item_int( options, "need_fire" ).value_or( 0 );
    action.ammo_scale = read_nonnegative_item_int( options, "ammo_scale" );
    action.set_timer = options.get_or( "set_timer", false );
    if( action.chance > 100 || ( action.set_timer && action.result.target_timer != 0_seconds ) ) {
        throw std::invalid_argument( "item transform chance or timer is invalid" );
    }
    const auto read_message = [&options]( const char *field ) -> std::optional<authored_text> {
        const sol::object value = options[field];
        if( value.valid() && value.get_type() != sol::type::nil ) {
            return read_singular_text( value, {}, field );
        }
        return std::nullopt;
    };
    action.damage_failure_message = read_message( "damage_failure_message" );
    action.need_charges_message = read_message( "need_charges_message" );
    action.need_fire_message = read_message( "need_fire_message" );
    if( const auto minimum_age = options.get<sol::optional<std::int64_t>>( "minimum_age_turns" ) ) {
        action.minimum_age = item_option_int( *minimum_age, "item transform minimum age" );
        action.not_ready = read_text_option( options, "not_ready_message", {}, "delayed transform message" );
        if( *action.minimum_age < 0 || action.not_ready.empty() ) {
            throw std::invalid_argument( "delayed item transform requires a nonnegative age and a message" );
        }
    }
    return action;
}

std::unique_ptr<iuse_transform> make_item_transform_actor( const item_transform_action &action )
{
    std::unique_ptr<iuse_transform> actor;
    if( action.minimum_age ) {
        auto delayed = std::make_unique<delayed_transform_iuse>();
        delayed->transform_age = *action.minimum_age;
        delayed->not_ready_msg = action.not_ready.native();
        actor = std::move( delayed );
    } else {
        actor = std::make_unique<iuse_transform>();
    }
    actor->transform = action.result;
    actor->msg_transform = action.message.native();
    actor->menu_text = action.menu_text.native();
    actor->moves = action.moves;
    actor->need_empty = action.need_empty;
    actor->need_wielding = action.need_wielding;
    actor->need_worn = action.need_worn;
    actor->chance = action.chance;
    actor->sound_volume = action.sound_volume;
    actor->need_charges = action.need_charges;
    actor->need_fire = action.need_fire;
    actor->set_timer = action.set_timer;
    actor->damage_failure_msg = action.damage_failure_message ?
                                action.damage_failure_message->native() :
                                to_translation( "Activation of your damaged %s fails." );
    actor->need_charges_msg = action.need_charges_message ? action.need_charges_message->native() :
                              to_translation( "The %s is empty!" );
    actor->need_fire_msg = action.need_fire_message ? action.need_fire_message->native() :
                           to_translation( "You need a source of fire!" );
    return actor;
}

struct item_definition_data {
    struct cable_link_data {
        link_up_actor actor;
        authored_text menu_text;
        std::optional<int> ammo_scale;
    };
    struct tick_sound_data {
        sound_iuse actor;
        authored_text message;
    };
    struct tick_music_data {
        musical_instrument_actor actor;
        std::vector<authored_text> player_text;
        std::vector<authored_text> npc_text;
    };
    struct tool_data {
        std::optional<std::set<std::string>> ammo_types;
        std::optional<int> charges_per_use;
        std::optional<int> max_charges;
        std::optional<int> initial_charges;
        std::optional<int> charge_factor;
        std::optional<int> turns_per_charge;
        std::optional<units::power> power_draw;
        std::optional<itype_id> subtype;
        std::optional<authored_text> revert_message;

        struct charge_setting {
            const char *name;
            std::optional<int> tool_data::*authored;
            int islot_tool::*native;
        };
        static constexpr charge_setting charge_settings[] = {
            { "charges_per_use", &tool_data::charges_per_use, &islot_tool::charges_per_use },
            { "max_charges", &tool_data::max_charges, &islot_tool::max_charges },
            { "initial_charges", &tool_data::initial_charges, &islot_tool::def_charges },
            { "charge_factor", &tool_data::charge_factor, &islot_tool::charge_factor },
            { "turns_per_charge", &tool_data::turns_per_charge, &islot_tool::turns_per_charge },
        };
    };
    struct authored_pocket {
        pocket_data native;
        authored_text description;
    };
    struct use_message_data {
        authored_text message;
        authored_text name;
    };
    struct armor_data {
        std::optional<std::int64_t> warmth;
        std::optional<std::int64_t> max_worn;
    };
    struct armor_portion_definition {
        std::set<std::string> covers;
        std::set<std::string> sub_parts;
        std::int64_t encumbrance = 0;
        std::int64_t coverage = 0;
        std::set<std::string> materials;
        double material_thickness = 0.0;
        std::int64_t environmental_protection = 0;
    };
    struct activation_effect_data {
        std::string id;
        std::int64_t duration_turns = 0;
        std::int64_t intensity = 0;
        bool permanent = false;
    };
    struct activation_data {
        authored_text message;
        std::int64_t move_cost = 100;
        std::vector<activation_effect_data> effects;
    };
    struct ammunition_data {
        std::string type;
        std::optional<std::int64_t> count;
        std::optional<std::int64_t> stack_size;
        std::optional<damage_instance> damage;
        std::optional<int> dispersion;
        std::optional<int> loudness;
        std::optional<int> recovery_chance;
    };
    struct comestible_data {
        std::string type;
        std::int64_t calories = 0;
        std::int64_t fun = 0;
        std::int64_t healthy = 0;
        std::int64_t quench = 0;
        std::int64_t spoils_in_turns = 0;
        double freezing_point_celsius = 0.0;
        std::int64_t charges = 1;
        std::int64_t stack_size = 1;
        std::map<std::string, std::int64_t> vitamins;
    };
    struct book_data {
        std::string skill;
        std::string martial_art;
        std::int64_t required_level = 0;
        std::int64_t maximum_level = 0;
        std::int64_t intelligence = 0;
        std::int64_t read_time_turns = 0;
        std::int64_t fun = 0;
        std::int64_t chapters = 0;
        bool scannable = false;
        bool generic = false;
        std::vector<book_proficiency_bonus> proficiencies;
    };
    struct item_variant {
        std::string id;
        authored_text name;
        authored_text description;
        std::optional<std::string> symbol;
        std::optional<std::string> color;
        std::string ascii_picture;
        std::int64_t weight = 1;
        bool append = false;
        bool expand_snippets = false;
    };
    struct name_rule {
        condition_type kind;
        std::string key;
        std::string value;
        authored_text name;
    };
    struct map_reveal {
        std::int64_t radius = 0;
        std::string atlas_jurisdiction;
        std::vector<std::pair<std::string, ot_match_type>> terrains;
        authored_text message;
    };
    std::string id;
    std::string copy_from;
    bool is_abstract = false;
    std::string name;
    std::string description;
    std::optional<localized_text> translated_name;
    std::optional<localized_text> translated_description;
    std::string symbol = "?";
    std::int64_t mass_grams = 0;
    std::optional<std::int64_t> mass_milligrams;
    std::int64_t volume_ml = 0;
    std::optional<units::length> longest_side;
    std::int64_t price_cents = 0;
    std::int64_t price_postapoc_cents = 0;
    std::string color = "white";
    std::string category;
    std::string looks_like;
    std::optional<std::string> default_container;
    std::optional<std::string> ascii_picture;
    std::optional<std::string> snippet_category;
    std::optional<itype_variant_kind> variant_kind;
    std::optional<std::vector<item_variant>> variants;
    std::optional<std::vector<name_rule>> conditional_names;
    std::optional<std::int64_t> melee_to_hit;
    std::optional<std::int64_t> electronic_size_kb;
    std::optional<bool> stackable;
    std::optional<std::int64_t> stack_size;
    std::optional<std::int64_t> light;
    std::optional<std::int64_t> max_worn;
    std::optional<double> insulation;
    std::optional<bool> expand_snippets;
    std::optional<item_display_type> display_type;
    std::optional<phase_id> phase;
    std::optional<int> fall_damage_reduction;
    std::optional<itype_id> repair_like;
    std::optional<mtype_id> source_monster;
    std::optional<std::vector<std::string>> techniques;
    std::optional<std::vector<std::string>> weapon_categories;
    std::optional<std::vector<std::string>> field_emissions;
    std::optional<std::vector<std::string>> repair_materials;
    std::optional<std::vector<std::string>> removed_techniques;
    std::optional<std::vector<std::string>> removed_qualities;
    bool has_name = false;
    bool has_description = false;
    bool has_symbol = false;
    bool has_mass = false;
    bool has_volume = false;
    bool has_price = false;
    bool has_price_postapoc = false;
    bool has_color = false;
    bool has_category = false;
    bool has_looks_like = false;
    std::vector<material_part> materials;
    std::vector<std::pair<material_id, material_id>> material_replacements;
    item_measurement_changes measurements;
    std::vector<std::pair<fault_id, int>> faults;
    std::vector<std::tuple<int, int, float, std::string>> fault_groups;
    std::optional<mounted_charge_profile> mounted_charge;
    bool clear_mounted_charge = false;
    std::vector<quality_level> qualities;
    std::optional<std::vector<quality_level>> charged_qualities;
    std::vector<std::pair<quality_id, int>> quality_adjustments;
    bool replace_qualities = false;
    std::set<std::string> flags;
    bool clear_flags = false;
    std::map<std::string, double> melee_damage;
    bool clear_melee_damage = false;
    std::optional<damage_instance> throwing_damage;
    std::optional<int> throwing_recovery_chance;
    std::optional<throw_correction_data> throw_correction;
    bool replace_throw_correction = false;
    std::optional<std::map<skill_id, int>> minimum_skills;
    std::optional<item_melee_damage> melee_bonuses;
    std::optional<item_melee_damage> melee_factors;
    std::map<std::string, std::int64_t> magazine_ammo;
    std::int64_t magazine_capacity = 0;
    bool has_magazine_capacity = false;
    bool clear_use_actions = false;
    bool clear_tick_actions = false;
    std::set<std::string> native_tick_actions;
    std::optional<item_transform_action> tick_transform;
    std::optional<tick_sound_data> tick_sound;
    std::optional<tick_music_data> tick_music;
    std::variant<std::monostate, std::string, cast_spell_actor> expiry_action;
    bool play_instrument = false;
    bool has_tool = false;
    bool has_armor = false;
    std::optional<tool_data> tool;
    std::vector<authored_pocket> pockets;
    bool replace_pockets = false;
    std::optional<armor_data> armor;
    std::vector<armor_portion_definition> armor_portions;
    std::map<std::string, std::int64_t> ammo_pocket;
    std::vector<std::string> passive_enchantments;
    std::string deploy_furniture;
    std::string deploy_appliance;
    std::optional<map_reveal> reveal_map;
    std::set<std::string> native_use_actions;
    std::optional<cable_link_data> cable_link;
    std::string capture_size;
    std::optional<use_message_data> use_message;
    std::optional<heal_actor> healing;
    std::optional<cast_spell_actor> spell_use;
    itype_id assembled_belt;
    std::optional<item_transform_action> transform_use;
    std::optional<item_transform_action> delayed_transform_use;
    std::optional<item_transformation> transform_result;
    std::optional<time_duration> countdown_interval;
    std::optional<activation_data> activation;
    std::vector<std::string> learned_spells;
    bool martial_arts_manual = false;
    std::string use_handler;
    std::string tick_handler;
    authored_text use_label;
    std::optional<authored_text> use_description;
    std::string consume_handler;
    std::optional<ammunition_data> ammunition;
    std::optional<comestible_data> comestible;
    std::optional<book_data> book;
    bool registered = false;
};

struct quality_requirement_definition {
    std::string id;
    std::int64_t level = 1;
    std::int64_t count = 1;
};

std::vector<quality_requirement_definition> read_quality_alternatives( const sol::table &choices,
        const std::string_view description )
{
    const std::size_t count = require_dense_array(
                                  choices, description, 1 );
    std::vector<quality_requirement_definition> group;
    group.reserve( count );
    for( std::size_t index = 1; index <= count; ++index ) {
        const sol::table choice = choices.raw_get<sol::table>( index );
        quality_requirement_definition entry;
        entry.id = choice.get_or( "id", std::string() );
        entry.level = choice.get_or<std::int64_t>( "level", 1 );
        entry.count = choice.get_or<std::int64_t>( "count", 1 );
        if( entry.id.empty() || entry.level <= 0 || entry.count <= 0 ||
            entry.level > std::numeric_limits<int>::max() ||
            entry.count > std::numeric_limits<int>::max() ) {
            throw std::runtime_error(
                std::string( description ) + " contain invalid values" );
        }
        group.push_back( std::move( entry ) );
    }
    return group;
}

struct component_requirement {
    std::string id;
    std::int64_t count = 1;
    bool requirement = false;
    bool recoverable = true;
};

struct recipe_proficiency_data {
    std::string id;
    bool required = false;
    double time_multiplier = 0.0;
    double skill_penalty = 0.0;
    bool skill_penalty_assigned = false;
    double learning_time_multiplier = 1.0;
    std::optional<time_duration> max_experience;
};

std::optional<time_duration> read_recipe_turns( const sol::table &options, const char *key )
{
    const auto turns = options.get<sol::optional<std::int64_t>>( key );
    if( !turns ) {
        return std::nullopt;
    }
    if( *turns < 0 || *turns > std::numeric_limits<int>::max() ) {
        throw std::runtime_error( std::string( key ) + " is outside the native duration range" );
    }
    return time_duration::from_turns( static_cast<int>( *turns ) );
}

recipe_proficiency_data read_recipe_proficiency( const std::string &id,
        const sol::optional<sol::table> &options )
{
    if( id.empty() ) {
        throw std::runtime_error( "recipe proficiency id cannot be empty" );
    }
    recipe_proficiency_data value;
    value.id = id;
    if( options ) {
        value.required = options->get_or( "required", false );
        value.time_multiplier = options->get_or( "time_multiplier", 0.0 );
        if( const auto penalty = options->get<sol::optional<double>>( "skill_penalty" ) ) {
            value.skill_penalty = *penalty;
            value.skill_penalty_assigned = true;
        }
        value.learning_time_multiplier = options->get_or( "learning_time_multiplier", 1.0 );
        value.max_experience = read_recipe_turns( *options, "max_experience_turns" );
    }
    return value;
}

recipe_proficiency make_recipe_proficiency( const recipe_proficiency_data &source )
{
    recipe_proficiency native;
    native.id = proficiency_id( source.id );
    native.required = source.required;
    native.time_multiplier = static_cast<float>( source.time_multiplier );
    native.skill_penalty = static_cast<float>( source.skill_penalty );
    native._skill_penalty_assigned = source.skill_penalty_assigned;
    native.learning_time_mult = static_cast<float>( source.learning_time_multiplier );
    native.max_experience = source.max_experience;
    return native;
}

using recipe_requirement_sets = std::vector<std::pair<std::string, std::int64_t>>;

struct recipe_step_definition_data {
    authored_text name;
    std::int64_t moves = 0;
    double activity = NO_EXERCISE;
    step_attention attention = step_attention::none;
    std::optional<time_duration> max_time;
    std::optional<time_duration> grace_period;
    authored_text unattended_message;
    batch_savings batching;
    std::vector<std::vector<component_requirement>> tools;
    std::vector<std::vector<quality_requirement_definition>> qualities;
    recipe_requirement_sets requirements;
    std::vector<recipe_proficiency_data> proficiencies;
};

using blueprint_tokens = std::vector<std::pair<std::string, int>>;

struct recipe_blueprint_needs_data {
    int time = 0;
    std::map<std::string, int> skills;
    std::vector<std::vector<component_requirement>> components;
    std::vector<std::vector<component_requirement>> tools;
    std::vector<std::vector<quality_requirement_definition>> qualities;
};

struct recipe_blueprint_data {
    std::string update;
    authored_text name;
    std::vector<std::string> resources;
    blueprint_tokens provides;
    blueprint_tokens requires_tokens;
    blueprint_tokens excludes;
    std::map<std::string, std::map<std::string, authored_text>> parameter_labels;
    bool check_needs = true;
    std::optional<recipe_blueprint_needs_data> needs;
};

struct recipe_definition_data {
    std::string id;
    bool nested_category = false;
    std::optional<practice_recipe_data> practice;
    character_resource_costs character_resources;
    bool uncraft = false;
    bool obsolete = false;
    std::string result;
    authored_text name;
    authored_text description;
    std::string category = "CC_OTHER";
    std::string subcategory = "CSC_OTHER_OTHER";
    std::set<std::string> flags;
    double activity_level = NO_EXERCISE;
    std::map<std::string, bool> nested_recipes;
    std::string skill;
    std::int64_t difficulty = 0;
    std::int64_t time_moves = 100;
    bool autolearn = true;
    bool never_learn = false;
    bool reversible = false;
    std::optional<recipe_blueprint_data> blueprint;
    std::string variant;
    std::string container;
    std::string container_variant;
    bool contained = false;
    bool sealed = true;
    batch_savings batching;
    std::set<std::string> removed_result_flags;
    std::map<std::string, int> byproducts;
    std::string byproduct_group;
    std::map<std::string, int> autolearn_skills;
    std::optional<std::int64_t> result_charges;
    std::int64_t result_multiplier = 1;
    std::vector<std::vector<quality_requirement_definition>> qualities;
    std::vector<std::vector<component_requirement>> components;
    std::vector<std::vector<component_requirement>> tools;
    std::map<std::string, std::int64_t> required_skills;
    std::map<scaling_stat, int> required_stats;
    recipe_requirement_sets external_requirements;
    std::vector<recipe_step_definition_data> steps;
    std::int64_t disassembly_moves = 0;
    std::map<std::string, std::int64_t> disassembly_learning;
    int morale_bonus = 0;
    time_duration morale_duration;
    std::vector<recipe_proficiency_data> proficiencies;
    struct book_data {
        int level = -1;
        authored_text name;
        bool hidden = false;
    };
    std::map<std::string, book_data> books;
    std::string result_handler;
    bool scripted_output = false;
    bool registered = false;

    void add_required_skill( const std::string &skill_name, std::int64_t level ) {
        if( skill_name.empty() || level < 0 || level > MAX_SKILL ) {
            throw std::runtime_error( "recipe skill requires a non-empty id and non-negative level" );
        }
        required_skills[skill_name] = level;
    }
};

requirement_id recipe_root_requirement_id( const recipe_id &id,
        const recipe_definition_data &definition )
{
    const char *prefix = definition.uncraft ? "inline_uncraft_" :
                         definition.practice ? "inline_practice_" : "inline_recipe_";
    return requirement_id( prefix + id.str() );
}

struct plant_lifecycle_definition_data {
    std::string id;
    std::string target = "seed";
    std::map<std::string, std::string> handlers;
    bool registered = false;
};

struct requirement_definition_data {
    std::string id;
    authored_text name;
    std::vector<std::vector<component_requirement>> components;
    std::vector<std::vector<component_requirement>> tools;
    std::vector<std::vector<quality_requirement_definition>> qualities;
    std::shared_ptr<const requirement_definition_data> alternatives;
    bool merge = false;
    bool registered = false;
};

struct recipe_group_terrain_data {
    std::string overmap_terrain;
    std::string match_type = "TYPE";
    std::map<std::string, std::set<std::string>> parameters;
};

struct recipe_group_recipe_data {
    std::string id;
    authored_text description;
    std::vector<recipe_group_terrain_data> terrains;
};

requirement_data native_requirement_groups( const requirement_definition_data &source )
{
    requirement_data::alter_item_comp_vector components;
    for( const auto &source_group : source.components ) {
        std::vector<item_comp> group;
        group.reserve( source_group.size() );
        for( const component_requirement &component : source_group ) {
            item_comp native( itype_id( component.id ), static_cast<int>( component.count ) );
            native.requirement = component.requirement;
            group.push_back( std::move( native ) );
        }
        components.push_back( std::move( group ) );
    }
    requirement_data::alter_tool_comp_vector tools;
    for( const auto &source_group : source.tools ) {
        std::vector<tool_comp> group;
        group.reserve( source_group.size() );
        for( const component_requirement &tool : source_group ) {
            tool_comp native( itype_id( tool.id ), static_cast<int>( tool.count ) );
            native.requirement = tool.requirement;
            group.push_back( std::move( native ) );
        }
        tools.push_back( std::move( group ) );
    }
    requirement_data::alter_quali_req_vector qualities;
    for( const auto &source_group : source.qualities ) {
        std::vector<quality_requirement> group;
        group.reserve( source_group.size() );
        for( const quality_requirement_definition &quality : source_group ) {
            group.emplace_back( quality_id( quality.id ), static_cast<int>( quality.count ),
                                static_cast<int>( quality.level ) );
        }
        qualities.push_back( std::move( group ) );
    }
    return requirement_data( tools, qualities, components );
}

requirement_source_layer native_requirement_layer( const requirement_definition_data &source,
        const std::string &owner )
{
    return {
        native_requirement_groups( source ),
        source.alternatives ? std::make_optional( native_requirement_groups( *source.alternatives ) ) :
        std::nullopt,
        owner, !source.merge
    };
}

struct recipe_group_definition_data {
    std::string id;
    std::string building_type = "NONE";
    std::vector<recipe_group_recipe_data> recipes;
    bool registered = false;
};

struct scent_type_definition_data {
    std::string id;
    std::set<std::string> receptive_species;
    bool registered = false;
};

struct butchery_requirement_definition_data {
    std::string id;
    struct requirement_entry {
        double speed = 0.0;
        std::string size;
        std::string butcher;
        std::string requirement;
    };
    std::vector<requirement_entry> entries;
    bool registered = false;
};

struct item_action_definition_data {
    std::string id;
    authored_text name;
    bool registered = false;
};

struct item_group_reference {
    std::string id;
    bool group;
};

struct item_group_entry_definition_data {
    std::string id;
    bool group = false;
    std::int64_t probability = 100;
    std::string variant;
    bool variant_specified = false;
    bool count_specified = false;
    std::int64_t count_min = 1;
    std::int64_t count_max = 1;
    bool charges_specified = false;
    std::int64_t charges_min = -1;
    std::int64_t charges_max = -1;
    std::optional<item_group_reference> container = std::nullopt;
    std::optional<item_group_reference> ammo = std::nullopt;
    std::optional<std::string> wrapper = std::nullopt;
    std::optional<std::string> wrapper_variant = std::nullopt;
    std::optional<bool> sealed = std::nullopt;
    std::optional<bool> active = std::nullopt;
    holiday event = holiday::none;
    std::optional<Item_spawn_data::relic_generator> artifact = std::nullopt;
    std::vector<std::string> components = {};
    std::vector<std::string> flags = {};
    std::optional<std::map<std::string, diag_value>> variables = std::nullopt;
    std::optional<Item_group::Type> subgroup = std::nullopt;
    std::vector<item_group_entry_definition_data> children = {};
    std::optional<std::pair<int, int>> damage = std::nullopt;
    std::optional<std::pair<int, int>> dirt = std::nullopt;
    std::vector<item_group_reference> contents = {};
};

struct item_group_definition_data {
    std::string id;
    std::string kind = "distribution";
    std::int64_t with_ammo = 0;
    std::int64_t with_magazine = 0;
    std::optional<std::string> container;
    std::optional<std::string> container_variant;
    Item_spawn_data::overflow_behaviour overflow = Item_spawn_data::overflow_behaviour::none;
    bool sealed = true;
    std::vector<item_group_entry_definition_data> entries;
    bool registered = false;
};

struct ammo_field_definition_data {
    std::string field;
    std::int64_t intensity_min = 1;
    std::int64_t intensity_max = 1;
    std::int64_t radius = 1;
    std::int64_t height = 0;
    std::int64_t chance = 100;
    std::int64_t footprint = 0;
    bool passable_only = false;
};

struct ammo_character_effect_definition_data {
    std::string effect;
    std::int64_t duration_turns = 1;
    std::int64_t intensity_min = 1;
    std::int64_t intensity_max = 1;
    std::int64_t chance = 100;
    std::int64_t radius = 1;
    std::int64_t hits_min = 1;
    std::int64_t hits_max = 1;
    bool touch_skin = false;
    bool all_body_parts = false;
};

struct ammo_spell_definition_data {
    std::string spell;
    std::int64_t level = 0;
    bool self = false;
};

struct ammo_effect_definition_data {
    std::string id;
    std::int64_t trigger_chance = 100;
    std::vector<ammo_field_definition_data> field_bursts;
    std::vector<ammo_field_definition_data> trails;
    std::vector<ammo_character_effect_definition_data> on_hit_effects;
    std::vector<ammo_character_effect_definition_data> area_effects;
    bool has_explosion = false;
    double explosion_power = 0.0;
    double explosion_distance_factor = 0.8;
    std::int64_t explosion_max_noise = 90000000;
    bool explosion_fire = false;
    std::string explosion_light;
    bool has_shrapnel = false;
    std::int64_t casing_mass = 0;
    double fragment_mass = 0.005;
    std::int64_t fragment_recovery = 0;
    std::string fragment_drop = "null";
    bool flashbang = false;
    bool emp = false;
    bool foamcrete = false;
    bool cast_spells_on_miss = false;
    std::vector<ammo_spell_definition_data> spells;
    std::string impact_handler;
    bool registered = false;
};

struct tool_quality_definition_data {
    std::string id;
    authored_text name;
    std::vector<std::pair<std::int64_t, std::string>> usages;
    bool registered = false;
};

struct skill_display_definition_data {
    std::string id;
    authored_text label;
    bool registered = false;
};

struct skill_definition_data {
    std::string id;
    authored_text name;
    authored_text description;
    std::string display_category = "none";
    std::int64_t sort_rank = 1000000;
    std::set<std::string> tags;
    std::map<std::string, std::int64_t> companion_practice;
    std::map<std::int64_t, authored_text> theory_descriptions;
    std::map<std::int64_t, authored_text> practice_descriptions;
    std::set<std::string> requires_all_traits;
    std::set<std::string> requires_any_traits;
    std::int64_t attack_min_time = 50;
    std::int64_t attack_base_time = 220;
    std::int64_t attack_reduction_per_level = 25;
    std::int64_t companion_combat_rank_factor = 0;
    std::int64_t companion_survival_rank_factor = 0;
    std::int64_t companion_industry_rank_factor = 0;
    bool teachable = true;
    bool obsolete = false;
    bool consumes_focus = true;
    bool registered = false;
};

struct vitamin_definition_data {
    std::string id;
    authored_text name;
    std::string type = "vitamin";
    std::string deficiency;
    std::string excess;
    std::int64_t minimum = 0;
    std::int64_t maximum = 0;
    std::int64_t rate_turns = 1;
    std::optional<std::int64_t> weight_micrograms;
    std::vector<std::pair<std::int64_t, std::int64_t>> disease;
    std::vector<std::pair<std::int64_t, std::int64_t>> disease_excess;
    std::vector<std::pair<std::string, std::int64_t>> decays_into;
    std::set<std::string> flags;
    bool registered = false;
};

struct json_flag_definition_data {
    std::string id;
    authored_text info;
    authored_text restriction;
    authored_text name;
    authored_text item_prefix;
    authored_text item_suffix;
    std::string requires_flag;
    std::set<std::string> conflicts;
    std::int64_t taste_modifier = 0;
    bool inherit = true;
    bool craft_inherit = false;
    bool registered = false;
};

struct math_function_definition_data {
    std::string id;
    std::int64_t num_args = 0;
    std::string expression;
    bool registered = false;
};

struct material_burn_definition {
    bool immune = false;
    std::int64_t volume_ml_per_turn = 0;
    double fuel = 0.0;
    double smoke = 0.0;
    double burn = 0.0;
};

struct material_definition_data {
    std::string id;
    std::string copy_from;
    authored_text name;
    std::string salvaged_into;
    std::vector<std::string> repaired_with;
    authored_text repaired_with_name;
    authored_text bash_damage_verb;
    authored_text cut_damage_verb;
    std::vector<authored_text> damage_adjectives = {
        { "lightly damaged", std::nullopt }, { "damaged", std::nullopt },
        { "very damaged", std::nullopt }, { "thoroughly damaged", std::nullopt }
    };
    std::map<std::string, double> resistances;
    std::map<std::string, double> vitamins;
    std::vector<material_burn_definition> burn_data;
    std::vector<std::pair<std::string, double>> burn_products;
    std::optional<std::int64_t> chip_resistance;
    std::optional<std::int64_t> breathability;
    std::optional<std::int64_t> repair_difficulty;
    std::optional<std::int64_t> wind_resistance;
    std::optional<double> density;
    std::optional<double> sheet_thickness;
    std::optional<double> specific_heat_liquid;
    std::optional<double> specific_heat_solid;
    std::optional<double> latent_heat;
    std::optional<double> freezing_point;
    std::optional<bool> rotting;
    std::optional<bool> soft;
    std::optional<bool> uncomfortable;
    std::optional<bool> conductive;
    bool has_fuel = false;
    std::int64_t fuel_energy_kilojoules = 0;
    std::string fuel_pump_terrain = "t_null";
    bool perpetual_fuel = false;
    std::int64_t explosion_chance_hot = 0;
    std::int64_t explosion_chance_cold = 0;
    double explosion_factor = 0.0;
    bool fiery_explosion = false;
    double fuel_size_factor = 0.0;
    bool registered = false;
};

struct damage_type_definition_data {
    std::string id;
    authored_text name;
    std::string skill;
    std::string magic_color = "black";
    std::string derived_from;
    std::string on_hit_handler;
    std::string on_damage_handler;
    double derived_factor = 0.0;
    double bash_conversion_factor = 0.1;
    double melee_crit_dmg_mult = 0.0;
    double melee_crit_dmg_mult_per_skill = 0.0;
    double melee_crit_armor_mult = 1.0;
    double melee_crit_armor_penetration = 0.0;
    std::set<std::string> character_immune_flags;
    std::set<std::string> monster_immune_flags;
    bool melee_only = false;
    bool physical = false;
    bool monster_difficulty = false;
    bool no_resist = false;
    bool edged = false;
    bool environmental = false;
    bool material_required = false;
    bool registered = false;
};

struct ammunition_type_definition_data {
    std::string id;
    authored_text name;
    std::string default_item;
    bool registered = false;
};

struct item_category_priority_definition {
    std::string zone;
    bool filthy = false;
    std::set<std::string> flags;
};

struct item_category_definition_data {
    std::string id;
    authored_text header;
    authored_text noun;
    std::int64_t sort_rank = 0;
    double spawn_rate = 1.0;
    std::string zone;
    std::vector<item_category_priority_definition> priority_zones;
    bool registered = false;
};

struct crafting_category_definition_data {
    std::string id;
    std::vector<std::string> subcategories;
    bool hidden = false;
    bool practice = false;
    bool building = false;
    bool wildcard = false;
    bool registered = false;
};

struct proficiency_category_definition_data {
    std::string id;
    authored_text name;
    authored_text description;
    bool registered = false;
};

struct proficiency_bonus_definition {
    std::string category;
    std::string attribute;
    double value = 0.0;
};

struct proficiency_definition_data {
    std::string id;
    authored_text name;
    authored_text description;
    std::string category;
    std::int64_t time_to_learn_turns = 35996400;
    std::set<std::string> required;
    std::vector<proficiency_bonus_definition> bonuses;
    double time_multiplier = 2.0;
    double skill_penalty = 1.0;
    double weakpoint_bonus = 0.0;
    double weakpoint_penalty = 0.0;
    bool can_learn = false;
    bool ignore_focus = false;
    bool teachable = true;
    bool registered = false;
};

struct weapon_category_definition_data {
    std::string id;
    authored_text name;
    std::vector<std::string> proficiencies;
    bool registered = false;
};

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

struct item_definition_handle {
    std::shared_ptr<item_definition_data> definition;
    std::shared_ptr<owner_token> token;

    item_definition_handle &mass( std::int64_t grams ) {
        require_building_handle( token, *definition, "item" );
        if( grams < 0 || grams > std::numeric_limits<std::int64_t>::max() / 1000 ) {
            throw std::runtime_error( "item mass is outside the native range" );
        }
        definition->mass_grams = grams;
        definition->mass_milligrams.reset();
        definition->has_mass = true;
        return *this;
    }

    item_definition_handle &mass_milligrams( std::int64_t milligrams ) {
        require_building_handle( token, *definition, "item" );
        if( milligrams < 0 ) {
            throw std::invalid_argument( "item mass cannot be negative" );
        }
        definition->mass_grams = 0;
        definition->mass_milligrams = milligrams;
        definition->has_mass = true;
        return *this;
    }

    item_definition_handle &volume( std::int64_t milliliters ) {
        require_building_handle( token, *definition, "item" );
        if( milliliters < 0 ||
            milliliters > std::numeric_limits<units::volume::value_type>::max() ) {
            throw std::runtime_error( "item volume is outside the native range" );
        }
        definition->volume_ml = milliliters;
        definition->has_volume = true;
        return *this;
    }

    item_definition_handle &price( std::int64_t cents ) {
        require_building_handle( token, *definition, "item" );
        if( cents < 0 || cents > std::numeric_limits<units::money::value_type>::max() ) {
            throw std::runtime_error( "item price is outside the native range" );
        }
        definition->price_cents = cents;
        definition->has_price = true;
        return *this;
    }

    item_definition_handle &price_postapoc( std::int64_t cents ) {
        require_building_handle( token, *definition, "item" );
        if( cents < 0 || cents > std::numeric_limits<units::money::value_type>::max() ) {
            throw std::runtime_error( "item post-Cataclysm price is outside the native range" );
        }
        definition->price_postapoc_cents = cents;
        definition->has_price_postapoc = true;
        return *this;
    }

    item_definition_handle &melee( const std::string &damage_type, double amount ) {
        require_building_handle( token, *definition, "item" );
        if( damage_type.empty() || !std::isfinite( amount ) ) {
            throw std::runtime_error( "item melee damage requires a type and finite amount" );
        }
        definition->melee_damage[damage_type] = amount;
        return *this;
    }

    item_definition_handle &throwing_damage( const sol::table &entries ) {
        require_building_handle( token, *definition, "item" );
        definition->throwing_damage = read_item_damage( entries );
        return *this;
    }

    item_definition_handle &throw_correction( const sol::optional<sol::table> &options ) {
        require_building_handle( token, *definition, "item" );
        definition->throw_correction = options ?
                                       std::make_optional( read_throw_correction( *options ) ) : std::nullopt;
        definition->replace_throw_correction = true;
        return *this;
    }

    item_definition_handle &adjust_measurements( const sol::table &options ) {
        require_building_handle( token, *definition, "item" );
        for( const auto &[field, member] : item_measurement_changes::fields ) {
            if( const auto value = options.get<sol::optional<sol::table>>( field ) ) {
                const auto factor = value->get<sol::optional<double>>( "factor" );
                const auto offset = value->get<sol::optional<std::int64_t>>( "offset" );
                if( factor.has_value() == offset.has_value() ||
                    ( factor && ( !std::isfinite( *factor ) || *factor <= 0.0 ) ) ) {
                    throw std::invalid_argument( "item measurement requires a positive factor or an integer offset" );
                }
                auto &adjustment = ( definition->measurements.*member ).emplace();
                adjustment.factor = factor ? std::optional<double>( *factor ) : std::nullopt;
                adjustment.offset = offset.value_or( 0 );
            }
        }
        return *this;
    }

    item_definition_handle &adjust_melee_damage( const sol::table &options ) {
        require_building_handle( token, *definition, "item" );
        const auto read_values = [&]( const char *key, float default_value,
                                      std::optional<item_melee_damage> &target ) {
            if( const auto values = options.get<sol::optional<sol::table>>( key ) ) {
                item_melee_damage &damage = target.emplace();
                damage.default_value = default_value;
                for( const auto &entry : *values ) {
                    const std::string id = entry.first.as<std::string>();
                    const double value = entry.second.as<double>();
                    if( id.empty() || !std::isfinite( value ) ||
                        std::abs( value ) > std::numeric_limits<float>::max() ) {
                        throw std::invalid_argument( "item melee adjustment requires damage ids and finite values" );
                    }
                    damage.damage_map.emplace( damage_type_id( id ), static_cast<float>( value ) );
                }
            }
        };
        read_values( "factors", 1.0f, definition->melee_factors );
        read_values( "bonuses", 0.0f, definition->melee_bonuses );
        return *this;
    }

    item_definition_handle &magazine_ammo( const std::string &ammo_type,
                                           std::int64_t capacity ) {
        require_building_handle( token, *definition, "item" );
        if( ammo_type.empty() || capacity <= 0 ||
            capacity > std::numeric_limits<int>::max() ) {
            throw std::runtime_error(
                "item magazine ammo requires a type and positive native capacity" );
        }
        definition->magazine_ammo[ammo_type] = capacity;
        return *this;
    }

    item_definition_handle &magazine_capacity( std::int64_t capacity ) {
        require_building_handle( token, *definition, "item" );
        if( capacity <= 0 || capacity > std::numeric_limits<int>::max() ) {
            throw std::runtime_error( "item magazine capacity is outside the native range" );
        }
        definition->magazine_capacity = capacity;
        definition->has_magazine_capacity = true;
        return *this;
    }

    item_definition_handle &material( const std::string &id, std::int64_t portions ) {
        require_building_handle( token, *definition, "item" );
        if( id.empty() || portions <= 0 || portions > std::numeric_limits<int>::max() ) {
            throw std::runtime_error( "item material requires a non-empty id and positive portions" );
        }
        definition->materials.push_back( { id, portions } );
        return *this;
    }

    item_definition_handle &replace_material( const std::string &original, const std::string &replacement ) {
        require_building_handle( token, *definition, "item" );
        if( original.empty() || replacement.empty() || original == replacement ) {
            throw std::invalid_argument( "item material replacement requires two different ids" );
        }
        definition->material_replacements.emplace_back( material_id( original ), material_id( replacement ) );
        return *this;
    }

    item_definition_handle &fault( const std::string &id, std::int64_t weight ) {
        require_building_handle( token, *definition, "item" );
        if( id.empty() || weight < 0 || weight > std::numeric_limits<int>::max() ) {
            throw std::invalid_argument( "item fault requires an id and nonnegative integer weight" );
        }
        definition->faults.emplace_back( fault_id( id ), static_cast<int>( weight ) );
        return *this;
    }

    item_definition_handle &fault_group( const std::string &id, const sol::table &options ) {
        require_building_handle( token, *definition, "item" );
        const auto weight = options.get_or<std::int64_t>( "weight_override", -1 );
        const auto add = options.get_or<std::int64_t>( "weight_add", 0 );
        const auto multiplier = options.get_or<double>( "weight_multiplier", 1.0 );
        if( id.empty() || weight < -1 || weight > std::numeric_limits<int>::max() ||
            add < std::numeric_limits<int>::min() || add > std::numeric_limits<int>::max() ||
            !std::isfinite( multiplier ) || std::abs( multiplier ) > std::numeric_limits<float>::max() ) {
            throw std::invalid_argument( "item fault group has invalid weight options" );
        }
        definition->fault_groups.emplace_back( static_cast<int>( weight ), static_cast<int>( add ),
                                               static_cast<float>( multiplier ), id );
        return *this;
    }

    item_definition_handle &mounted_charge( const sol::table &options ) {
        require_building_handle( token, *definition, "item" );
        const auto steps = options.get<std::int64_t>( "max_steps" );
        const auto per_step = options.get_or<double>( "multiplier_per_step", 0.10 );
        const auto maximum = options.get_or<double>( "max_multiplier", 1.50 );
        if( steps < 1 || steps > std::numeric_limits<int>::max() ||
            !( per_step >= 0.0 && per_step <= 0.5 ) || !( maximum >= 1.0 && maximum <= 2.0 ) ) {
            throw std::invalid_argument( "invalid mounted charge range or multipliers" );
        }
        mounted_charge_profile profile;
        profile.max_steps = static_cast<int>( steps );
        profile.damage_type = options.get_or( "damage_type", std::string( "stab" ) );
        profile.multiplier_per_step = static_cast<float>( per_step );
        profile.max_multiplier = static_cast<float>( maximum );
        if( !profile.valid() ) {
            throw std::invalid_argument( "invalid mounted charge damage type" );
        }
        definition->mounted_charge = profile;
        definition->clear_mounted_charge = false;
        return *this;
    }

    item_definition_handle &clear_mounted_charge() {
        require_building_handle( token, *definition, "item" );
        definition->mounted_charge.reset();
        definition->clear_mounted_charge = true;
        return *this;
    }

    item_definition_handle &quality( const std::string &id, std::int64_t level,
                                     const sol::optional<double> &speed ) {
        require_building_handle( token, *definition, "item" );
        definition->qualities.push_back( read_item_quality( id, level, speed.value_or( 1.0 ) ) );
        return *this;
    }

    item_definition_handle &adjust_quality( const std::string &quality, std::int64_t offset ) {
        require_building_handle( token, *definition, "item" );
        definition->quality_adjustments.emplace_back( quality_id( quality ),
                item_option_int( offset, "quality level offset" ) );
        return *this;
    }

    item_definition_handle &flag( const std::string &id ) {
        require_building_handle( token, *definition, "item" );
        if( id.empty() ) {
            throw std::runtime_error( "item flag id cannot be empty" );
        }
        definition->flags.insert( id );
        return *this;
    }

    item_definition_handle &clear_flags() {
        require_building_handle( token, *definition, "item" );
        definition->clear_flags = true;
        definition->flags.clear();
        return *this;
    }

    item_definition_handle &clear_melee_damage() {
        require_building_handle( token, *definition, "item" );
        definition->clear_melee_damage = true;
        definition->melee_damage.clear();
        return *this;
    }

    item_definition_handle &variants( const sol::table &variants ) {
        require_building_handle( token, *definition, "item" );
        const std::size_t count = require_dense_array( variants, "item variants", 0 );
        std::vector<item_definition_data::item_variant> values;
        values.reserve( count );
        for( std::size_t index = 1; index <= count; ++index ) {
            const sol::table options = variants.raw_get<sol::table>( index );
            item_definition_data::item_variant variant;
            variant.id = options.get<std::string>( "id" );
            const sol::object name = options.get<sol::object>( "name" );
            if( name.is<localized_text>() ) {
                const localized_text &value = name.as<const localized_text &>();
                variant.name = { value.singular, value };
            } else {
                variant.name = read_singular_text( name, "", "item variant name" );
            }
            variant.description = read_text_option( options, "description", {}, "item variant description" );
            if( const auto symbol = options.get<sol::optional<std::string>>( "symbol" ) ) {
                variant.symbol = *symbol;
            }
            if( const auto color = options.get<sol::optional<std::string>>( "color" ) ) {
                variant.color = *color;
            }
            variant.ascii_picture = options.get_or( "ascii_picture", std::string() );
            variant.weight = options.get_or<std::int64_t>( "weight", 1 );
            variant.append = options.get_or( "append", false );
            variant.expand_snippets = options.get_or( "expand_snippets", false );
            values.push_back( std::move( variant ) );
        }
        definition->variants = std::move( values );
        return *this;
    }

    item_definition_handle &conditional_names( const sol::table &rules ) {
        require_building_handle( token, *definition, "item" );
        static const std::map<std::string_view, condition_type> kinds = {
            { "flag", condition_type::FLAG },
            { "vitamin", condition_type::VITAMIN },
            { "component", condition_type::COMPONENT_ID },
            { "component_substring", condition_type::COMPONENT_ID_SUBSTRING },
            { "variable", condition_type::VAR },
            { "snippet", condition_type::SNIPPET_ID },
        };
        const std::size_t count = require_dense_array( rules, "item conditional names", 0 );
        std::vector<item_definition_data::name_rule> staged;
        staged.reserve( count );
        for( std::size_t index = 1; index <= count; ++index ) {
            const sol::table options = rules.raw_get<sol::table>( index );
            const std::string kind_name = options.get<std::string>( "kind" );
            const auto kind = kinds.find( kind_name );
            if( kind == kinds.end() ) {
                throw std::invalid_argument( "unknown item conditional name kind: " + kind_name );
            }
            const std::string key = options.get<std::string>( "key" );
            const bool compares_value = kind->second == condition_type::VAR ||
                                        kind->second == condition_type::SNIPPET_ID;
            const std::string value = compares_value ? options.get<std::string>( "value" ) : "";
            const sol::object name = options.get<sol::object>( "name" );
            authored_text label;
            if( name.is<localized_text>() ) {
                const localized_text &translated = name.as<const localized_text &>();
                label = { translated.singular, translated };
            } else if( name.is<std::string>() ) {
                label.raw = name.as<std::string>();
            } else {
                throw std::invalid_argument( "item conditional names require a string or localized name" );
            }
            staged.push_back( { kind->second, key, value, std::move( label ) } );
        }
        definition->conditional_names = std::move( staged );
        return *this;
    }

    item_definition_handle &ammunition( const sol::table &options ) {
        require_building_handle( token, *definition, "item" );
        item_definition_data::ammunition_data value;
        value.type = options.get_or( "type", std::string() );
        if( const auto count = options.get<sol::optional<std::int64_t>>( "count" ) ) {
            value.count = *count;
        }
        if( const auto stack_size = options.get<sol::optional<std::int64_t>>( "stack_size" ) ) {
            value.stack_size = *stack_size;
        }
        if( const auto damage = options.get<sol::optional<sol::table>>( "damage" ) ) {
            value.damage = read_item_damage( *damage );
        }
        value.dispersion = read_nonnegative_item_int( options, "dispersion" );
        value.loudness = read_nonnegative_item_int( options, "loudness" );
        value.recovery_chance = read_nonnegative_item_int( options, "recovery_chance" );
        definition->ammunition = std::move( value );
        return *this;
    }

    item_definition_handle &comestible( const sol::table &options ) {
        require_building_handle( token, *definition, "item" );
        if( definition->book ) {
            throw std::runtime_error( "an item cannot be both comestible and a book" );
        }
        item_definition_data::comestible_data value;
        value.type = options.get_or( "type", std::string() );
        value.calories = options.get_or<std::int64_t>( "calories", value.type == "MED" ? 0 : -1 );
        value.fun = options.get_or<std::int64_t>( "fun", 0 );
        value.healthy = options.get_or<std::int64_t>( "healthy", 0 );
        value.quench = options.get_or<std::int64_t>( "quench", 0 );
        value.spoils_in_turns = options.get_or<std::int64_t>( "spoils_in_turns", 0 );
        value.freezing_point_celsius = options.get_or( "freezing_point_celsius", 0.0 );
        value.charges = options.get_or<std::int64_t>( "charges", value.type == "MED" ? 0 : 1 );
        value.stack_size = options.get_or<std::int64_t>( "stack_size", value.charges );
        definition->comestible = std::move( value );
        return *this;
    }

    item_definition_handle &vitamin( const std::string &id, std::int64_t amount ) {
        require_building_handle( token, *definition, "item" );
        if( !definition->comestible ) {
            throw std::runtime_error( "item vitamins require a comestible definition" );
        }
        if( id.empty() || amount < std::numeric_limits<int>::min() ||
            amount > std::numeric_limits<int>::max() ) {
            throw std::runtime_error( "item vitamin requires a valid id and native amount" );
        }
        definition->comestible->vitamins[id] = amount;
        return *this;
    }

    item_definition_handle &book( const sol::table &options ) {
        require_building_handle( token, *definition, "item" );
        if( definition->comestible ) {
            throw std::runtime_error( "an item cannot be both a book and comestible" );
        }
        item_definition_data::book_data value;
        value.skill = options.get_or( "skill", std::string() );
        value.martial_art = options.get_or( "martial_art", std::string() );
        value.required_level = options.get_or<std::int64_t>( "required_level", 0 );
        value.maximum_level = options.get_or<std::int64_t>( "maximum_level", 0 );
        value.intelligence = options.get_or<std::int64_t>( "intelligence", 0 );
        value.read_time_turns = options.get_or<std::int64_t>( "read_time_turns", 0 );
        value.fun = options.get_or<std::int64_t>( "fun", 0 );
        value.chapters = options.get_or<std::int64_t>( "chapters", 0 );
        value.scannable = options.get_or( "scannable", false );
        value.generic = options.get_or( "generic", false );
        if( const auto proficiencies = options.get<sol::optional<sol::table>>( "proficiencies" ) ) {
            const std::size_t count = require_dense_array( *proficiencies, "book proficiencies", 0 );
            value.proficiencies.reserve( count );
            for( std::size_t index = 1; index <= count; ++index ) {
                const sol::table choice = proficiencies->raw_get<sol::table>( index );
                book_proficiency_bonus bonus;
                bonus.id = proficiency_id( choice.get<std::string>( "id" ) );
                bonus.time_factor = choice.get_or( "time_factor", bonus.time_factor );
                bonus.fail_factor = choice.get_or( "fail_factor", bonus.fail_factor );
                bonus.include_prereqs = choice.get_or( "include_prereqs", bonus.include_prereqs );
                bonus.cap = choice.get_or( "cap", bonus.cap );
                value.proficiencies.push_back( std::move( bonus ) );
            }
        }
        definition->book = std::move( value );
        return *this;
    }

    item_definition_handle &tool( const sol::optional<sol::table> &options ) {
        require_building_handle( token, *definition, "item" );
        if( options ) {
            auto value = definition->tool.value_or( item_definition_data::tool_data{} );
            if( const auto ammo = options->get<sol::optional<sol::table>>( "ammo_types" ) ) {
                const std::size_t count = require_dense_array( *ammo, "tool ammo types", 0 );
                value.ammo_types = std::set<std::string>{};
                for( std::size_t index = 1; index <= count; ++index ) {
                    value.ammo_types->insert( ammo->get<std::string>( index ) );
                }
            }
            for( const auto &setting : item_definition_data::tool_data::charge_settings ) {
                if( const auto charge = read_nonnegative_item_int( *options, setting.name ) ) {
                    value.*setting.authored = *charge;
                }
            }
            if( value.charge_factor && *value.charge_factor == 0 ) {
                throw std::invalid_argument( "tool charge_factor must be positive" );
            }
            if( const auto power = options->get<sol::optional<std::int64_t>>( "power_milliwatts" ) ) {
                if( *power < 0 ) {
                    throw std::invalid_argument( "tool power draw must be nonnegative" );
                }
                value.power_draw = units::from_milliwatt( *power );
            }
            if( const auto subtype = options->get<sol::optional<std::string>>( "crafting_subtype" ) ) {
                value.subtype = itype_id( *subtype );
            }
            const sol::object revert_message = ( *options )["revert_message"];
            if( revert_message.valid() && revert_message.get_type() != sol::type::nil ) {
                value.revert_message = read_singular_text( revert_message, {}, "tool revert message" );
            }
            definition->tool = std::move( value );
        }
        definition->has_tool = true;
        return *this;
    }

    item_definition_handle &magazine_well( const sol::table &options ) {
        return stage_pocket( options, pocket_type::MAGAZINE_WELL );
    }

    item_definition_handle &armor( const sol::optional<sol::table> &options ) {
        require_building_handle( token, *definition, "item" );
        if( options ) {
            auto value = definition->armor.value_or( item_definition_data::armor_data{} );
            if( const auto warmth = options->get<sol::optional<std::int64_t>>( "warmth" ) ) {
                value.warmth = *warmth;
            }
            if( const auto worn = options->get<sol::optional<std::int64_t>>( "max_worn" ) ) {
                value.max_worn = *worn;
            }
            definition->armor = std::move( value );
        }
        definition->has_armor = true;
        return *this;
    }

    item_definition_handle &armor_portion( const sol::table &options ) {
        require_building_handle( token, *definition, "item" );
        item_definition_data::armor_portion_definition value;
        const sol::table covers = options.get<sol::table>( "covers" );
        const std::size_t count = require_dense_array( covers, "armor covered parts", 0 );
        for( std::size_t index = 1; index <= count; ++index ) {
            value.covers.insert( covers.get<std::string>( index ) );
        }
        if( const auto sub_parts = options.get<sol::optional<sol::table>>( "sub_parts" ) ) {
            const std::size_t sub_count = require_dense_array( *sub_parts, "armor covered subparts", 0 );
            for( std::size_t index = 1; index <= sub_count; ++index ) {
                value.sub_parts.insert( sub_parts->get<std::string>( index ) );
            }
        }
        value.encumbrance = options.get_or<std::int64_t>( "encumbrance", 0 );
        value.coverage = options.get_or<std::int64_t>( "coverage", 0 );
        value.material_thickness = options.get_or( "material_thickness", 0.0 );
        value.environmental_protection = options.get_or<std::int64_t>( "environmental_protection", 0 );
        if( const auto materials = options.get<sol::optional<sol::table>>( "materials" ) ) {
            const std::size_t material_count = require_dense_array( *materials, "armor materials", 0 );
            for( std::size_t index = 1; index <= material_count; ++index ) {
                value.materials.insert( materials->get<std::string>( index ) );
            }
        }
        definition->armor_portions.push_back( std::move( value ) );
        definition->has_armor = true;
        return *this;
    }

    item_definition_handle &container_pocket( const sol::table &options ) {
        return stage_pocket( options, pocket_type::CONTAINER );
    }

    item_definition_handle &magazine_pocket( const sol::table &options ) {
        return stage_pocket( options, pocket_type::MAGAZINE );
    }

    item_definition_handle &file_storage_pocket( const sol::table &options ) {
        return stage_pocket( options, pocket_type::E_FILE_STORAGE );
    }

    item_definition_handle &stage_pocket( const sol::table &options, pocket_type kind ) {
        require_building_handle( token, *definition, "item" );
        pocket_data pocket;
        pocket.type = kind;
        pocket.was_loaded = true;
        const std::int64_t volume = kind == pocket_type::CONTAINER ?
                                    options.get<std::int64_t>( "max_volume_ml" ) :
                                    options.get_or<std::int64_t>( "max_volume_ml",
                                            units::to_milliliter( pocket.raw_volume_capacity ) );
        const std::int64_t mass = kind == pocket_type::CONTAINER ?
                                  options.get<std::int64_t>( "max_weight_milligrams" ) :
                                  options.get_or<std::int64_t>( "max_weight_milligrams",
                                          units::to_milligram( pocket.max_contains_weight ) );
        const auto length = options.get<std::optional<std::int64_t>>( "max_item_length_mm" );
        const std::int64_t moves = options.get_or<std::int64_t>( "moves", 100 );
        const double weight_multiplier = options.get_or( "weight_multiplier", 1.0 );
        const double encumbrance_multiplier = options.get_or( "volume_encumber_modifier", 1.0 );
        const double spoil_multiplier = options.get_or( "spoil_multiplier", 1.0 );
        const double volume_multiplier = options.get_or( "volume_multiplier", 1.0 );
        const double insulation = options.get_or( "insulation", 1.0 );
        const auto sealed_spoil = options.get<sol::optional<double>>( "sealed_spoil_multiplier" );
        const auto nonnegative_int = []( const std::int64_t value ) {
            return value >= 0 && value <= std::numeric_limits<int>::max();
        };
        const auto nonnegative_float = []( const double value ) {
            return std::isfinite( value ) && value >= 0.0 && value <= std::numeric_limits<float>::max();
        };
        if( !nonnegative_int( volume ) || mass < 0 || ( length && !nonnegative_int( *length ) ) ||
            !nonnegative_int( moves ) || !nonnegative_float( weight_multiplier ) ||
            !nonnegative_float( encumbrance_multiplier ) || !nonnegative_float( spoil_multiplier ) ||
            !nonnegative_float( volume_multiplier ) || !nonnegative_float( insulation ) ||
            ( sealed_spoil && !nonnegative_float( *sealed_spoil ) ) ) {
            throw std::invalid_argument( "item pocket has an invalid capacity, cost or multiplier" );
        }
        const auto size_option = [&options, &nonnegative_int]( const char *field ) -> std::optional<int> {
            if( const auto size = options.get<sol::optional<std::int64_t>>( field ) ) {
                if( !nonnegative_int( *size ) ) {
                    throw std::invalid_argument( std::string( "invalid item pocket " ) + field );
                }
                return static_cast<int>( *size );
            }
            return std::nullopt;
        };
        if( kind == pocket_type::MAGAZINE ) {
            const sol::table capacities = options.get<sol::table>( "ammo_capacities" );
            for( const auto &entry : capacities ) {
                if( entry.first.get_type() != sol::type::string || !entry.second.is<lua_Integer>() ) {
                    throw std::invalid_argument( "magazine pocket needs ammunition IDs and integer capacities" );
                }
                const int capacity = item_option_int( entry.second.as<std::int64_t>(),
                                                      "magazine pocket capacity" );
                if( capacity <= 0 ) {
                    throw std::invalid_argument( "magazine pocket capacity must be positive" );
                }
                pocket.ammo_restriction.emplace( ammotype( entry.first.as<std::string>() ), capacity );
            }
            if( pocket.ammo_restriction.empty() ) {
                throw std::invalid_argument( "magazine pocket needs at least one ammunition type" );
            }
        } else {
            pocket.raw_volume_capacity = units::from_milliliter( static_cast<int>( volume ) );
            pocket.max_contains_weight = units::from_milligram( mass );
            pocket.max_item_length = length ? units::from_millimeter( static_cast<int>( *length ) ) :
                                     units::default_length_from_volume( pocket.raw_volume_capacity ) * M_SQRT2;
            if( const auto item_volume = size_option( "max_item_volume_ml" ) ) {
                pocket.max_item_volume = units::from_milliliter( *item_volume );
            }
            pocket.min_item_volume = units::from_milliliter( size_option( "min_item_volume_ml" ).value_or( 0 ) );
            pocket.min_item_length = units::from_millimeter( size_option( "min_item_length_mm" ).value_or( 0 ) );
            pocket.volume_encumber_modifier = static_cast<float>( encumbrance_multiplier );
        }
        if( kind == pocket_type::E_FILE_STORAGE ) {
            const std::int64_t memory = options.get<std::int64_t>( "memory_kb" );
            if( memory < 0 ) {
                throw std::invalid_argument( "file storage capacity must be nonnegative" );
            }
            pocket.ememory_max = units::from_kilobytes( memory );
        }
        pocket.magazine_well = units::from_milliliter( size_option( "magazine_well_ml" ).value_or( 0 ) );
        pocket.moves = static_cast<int>( moves );
        pocket.weight_multiplier = static_cast<float>( weight_multiplier );
        pocket.spoil_multiplier = static_cast<float>( spoil_multiplier );
        pocket.volume_multiplier = static_cast<float>( volume_multiplier );
        pocket.insulation = static_cast<float>( insulation );
        if( sealed_spoil ) {
            pocket.sealed_data = cata::make_value<sealable_data>();
            pocket.sealed_data->spoil_multiplier = static_cast<float>( *sealed_spoil );
            pocket.sealed_data->was_loaded = true;
        }
        pocket.watertight = options.get_or( "watertight", false );
        pocket.airtight = options.get_or( "airtight", false );
        pocket.open_container = options.get_or( "open_container", false );
        pocket.transparent = options.get_or( "transparent", false );
        pocket.fire_protection = options.get_or( "fire_protection", false );
        pocket.rigid = options.get_or( "rigid", false );
        pocket.holster = options.get_or( "holster", false );
        pocket.forbidden = options.get_or( "forbidden", false );
        const authored_text description = read_text_option( options, "description", {},
                                          "item pocket description" );
        pocket.description = description.native();
        if( const auto materials = options.get<sol::optional<sol::table>>( "allowed_materials" ) ) {
            const std::size_t count = require_dense_array( *materials, "item pocket allowed materials", 0 );
            for( std::size_t index = 1; index <= count; ++index ) {
                pocket.material_restriction.insert( material_id( materials->raw_get<std::string>( index ) ) );
            }
        }
        auto flags = options.get<sol::optional<sol::table>>( "allowed_flags" );
        if( !flags && kind == pocket_type::MAGAZINE_WELL ) {
            flags = options.get<sol::optional<sol::table>>( "flags" );
        }
        if( flags ) {
            const std::size_t count = require_dense_array( *flags, "item pocket allowed flags", 0 );
            for( std::size_t index = 1; index <= count; ++index ) {
                pocket.add_flag_restriction( flag_id( flags->raw_get<std::string>( index ) ) );
            }
        }
        if( const auto magazine = options.get<sol::optional<std::string>>( "default_magazine" ) ) {
            if( magazine->empty() ) {
                throw std::invalid_argument( "item pocket default magazine ID is empty" );
            }
            pocket.default_magazine = itype_id( *magazine );
        }
        if( const auto restriction = options.get<sol::optional<sol::table>>( "allowed_items" ) ) {
            const std::size_t count = require_dense_array( *restriction, "item pocket allowed items", 1 );
            for( std::size_t index = 1; index <= count; ++index ) {
                const itype_id id( restriction->get<std::string>( index ) );
                pocket.item_id_restriction.insert( id );
                if( index == 1 ) {
                    pocket.default_magazine = id;
                }
            }
        }
        definition->pockets.push_back( { std::move( pocket ), description } );
        return *this;
    }

    item_definition_handle &deploy_furniture( const std::string &id ) {
        require_building_handle( token, *definition, "item" );
        if( id.empty() ) {
            throw std::invalid_argument( "item deployment requires a furniture id" );
        }
        definition->deploy_furniture = id;
        return *this;
    }

    item_definition_handle &deploy_appliance( const std::string &base_id ) {
        require_building_handle( token, *definition, "item" );
        if( base_id.empty() ) {
            throw std::invalid_argument( "item deployment requires an appliance base item id" );
        }
        definition->deploy_appliance = base_id;
        return *this;
    }

    item_definition_handle &reveal_map( const sol::table &options ) {
        require_building_handle( token, *definition, "item" );
        item_definition_data::map_reveal reveal;
        reveal.radius = options.get<std::int64_t>( "radius" );
        reveal.atlas_jurisdiction = options.get_or( "atlas_jurisdiction", std::string() );
        reveal.message = read_text_option( options, "message", {}, "map reveal message" );
        if( const auto targets = options.get<sol::optional<sol::table>>( "terrains" ) ) {
            const std::size_t count = require_dense_array( *targets, "map reveal terrains", 0 );
            for( std::size_t index = 1; index <= count; ++index ) {
                const sol::table target = targets->raw_get<sol::table>( index );
                reveal.terrains.emplace_back( target.get<std::string>( "id" ),
                                              io::string_to_enum<ot_match_type>( target.get_or( "match", std::string( "CONTAINS" ) ) ) );
            }
        }
        definition->reveal_map = std::move( reveal );
        return *this;
    }

    item_definition_handle &native_use( const std::string &action ) {
        require_building_handle( token, *definition, "item" );
        if( !Item_factory::has_parameterless_iuse( action ) ) {
            throw std::invalid_argument( "Unknown or unavailable native item action '" + action + "'" );
        }
        definition->native_use_actions.insert( action );
        return *this;
    }

    item_definition_handle &capture_creature( const std::string &size ) {
        require_building_handle( token, *definition, "item" );
        if( Creature::size_map.count( size ) == 0 ) {
            throw std::invalid_argument( "item capture requires a native creature size" );
        }
        definition->capture_size = size;
        return *this;
    }

    item_definition_handle &link_cable( const sol::table &options ) {
        require_building_handle( token, *definition, "item" );
        item_definition_data::cable_link_data data;
        link_up_actor &actor = data.actor;
        actor.cable_length = item_option_int( options.get_or<std::int64_t>( "cable_length", -1 ),
                                             "cable length" );
        actor.charge_rate = units::from_milliwatt( options.get_or<std::int64_t>( "charge_milliwatts", 0 ) );
        actor.efficiency = item_option_float( options, "efficiency", 0.85 );
        actor.move_cost = item_option_int( options.get_or<std::int64_t>( "move_cost", 5 ),
                                          "cable link move cost" );
        actor.targets = { link_state::no_link, link_state::vehicle_port };
        if( const auto targets = options.get<sol::optional<sol::table>>( "targets" ) ) {
            actor.targets.clear();
            const std::size_t count = require_dense_array( *targets, "cable link targets", 0 );
            for( std::size_t i = 1; i <= count; ++i ) {
                actor.targets.insert( io::string_to_enum<link_state>( targets->raw_get<std::string>( i ) ) );
            }
        }
        if( const auto extend = options.get<sol::optional<sol::table>>( "can_extend" ) ) {
            const std::size_t count = require_dense_array( *extend, "cable extension IDs", 0 );
            for( std::size_t i = 1; i <= count; ++i ) {
                actor.can_extend.insert( extend->raw_get<std::string>( i ) );
            }
        }
        data.ammo_scale = read_nonnegative_item_int( options, "ammo_scale" );
        data.menu_text = read_text_option( options, "menu_text", {}, "cable link menu text" );
        actor.menu_text = data.menu_text.native();
        definition->cable_link.emplace( std::move( data ) );
        return *this;
    }

    item_definition_handle &message_on_use( const sol::table &options ) {
        require_building_handle( token, *definition, "item" );
        definition->use_message = item_definition_data::use_message_data{
            read_text_option( options, "message", {}, "item use message" ),
            read_text_option( options, "menu_text", {}, "item use message menu text" )
        };
        return *this;
    }

    item_definition_handle &heal( const sol::table &options ) {
        require_building_handle( token, *definition, "item" );
        heal_actor treatment;
        treatment.move_cost = item_option_int( options.get<std::int64_t>( "move_cost" ), "healing move cost" );
        treatment.limb_power = item_option_float( options, "limb_power", 0.0 );
        treatment.head_power = item_option_float( options, "head_power", 0.8f * treatment.limb_power );
        treatment.torso_power = item_option_float( options, "torso_power", 1.5f * treatment.limb_power );
        treatment.limb_scaling = item_option_float( options, "limb_scaling", 0.25f * treatment.limb_power );
        const double ratio = treatment.limb_power < 0.0001f ? 0.0 :
                             static_cast<double>( treatment.limb_scaling / treatment.limb_power );
        treatment.head_scaling = item_option_float( options, "head_scaling", ratio * treatment.head_power );
        treatment.torso_scaling = item_option_float( options, "torso_scaling", ratio * treatment.torso_power );
        treatment.bandages_power = item_option_float( options, "bandages_power", 0.0 );
        treatment.bandages_scaling = item_option_float( options, "bandages_scaling",
                                     0.25f * treatment.bandages_power );
        treatment.disinfectant_power = item_option_float( options, "disinfectant_power", 0.0 );
        treatment.disinfectant_scaling = item_option_float( options, "disinfectant_scaling",
                                         0.25f * treatment.disinfectant_power );
        treatment.bleed = item_option_int( options.get_or<std::int64_t>( "bleed", 0 ), "healing bleeding reduction" );
        treatment.bite = item_option_float( options, "bite", 0.0 );
        treatment.infect = item_option_float( options, "infect", 0.0 );
        if( treatment.move_cost < 0 ||
            !( treatment.limb_power || treatment.head_power || treatment.torso_power ||
               treatment.bandages_power || treatment.bleed || treatment.disinfectant_power ||
               treatment.bite || treatment.infect ) ) {
            throw std::invalid_argument( "item healing requires a nonnegative move cost and a treatment effect" );
        }
        if( const auto used = options.get<sol::optional<sol::table>>( "used_up_item" ) ) {
            const std::string id = used->get<std::string>( "id" );
            if( id.empty() ) {
                throw std::invalid_argument( "healing used-up item requires an id" );
            }
            treatment.used_up_item_id = itype_id( id );
            treatment.used_up_item_quantity = item_option_int( used->get_or<std::int64_t>( "quantity", 1 ),
                                              "healing used-up item quantity" );
            treatment.used_up_item_charges = item_option_int( used->get_or<std::int64_t>( "charges", 1 ),
                                             "healing used-up item charges" );
            if( const auto flags = used->get<sol::optional<sol::table>>( "flags" ) ) {
                const std::size_t count = require_dense_array( *flags, "healing used-up item flags", 0 );
                for( std::size_t i = 1; i <= count; ++i ) {
                    treatment.used_up_item_flags.emplace( flags->raw_get<std::string>( i ) );
                }
            }
        }
        definition->healing.emplace( std::move( treatment ) );
        return *this;
    }

    static cast_spell_actor read_spell_action( const sol::table &options ) {
        cast_spell_actor action;
        action.item_spell = spell_id( options.get<std::string>( "spell" ) );
        action.spell_level = item_option_int( options.get<std::int64_t>( "level" ), "item spell level" );
        if( action.item_spell.is_empty() ) {
            throw std::invalid_argument( "item spell action requires a spell id" );
        }
        action.no_fail = options.get_or( "no_fail", false );
        action.need_worn = options.get_or( "need_worn", false );
        action.need_wielding = options.get_or( "need_wielding", false );
        action.mundane = options.get_or( "mundane", false );
        return action;
    }

    item_definition_handle &cast_spell( const sol::table &options ) {
        require_building_handle( token, *definition, "item" );
        definition->spell_use.emplace( read_spell_action( options ) );
        return *this;
    }

    item_definition_handle &cast_spell_on_expiry( const sol::table &options ) {
        require_building_handle( token, *definition, "item" );
        definition->expiry_action.emplace<cast_spell_actor>( read_spell_action( options ) );
        return *this;
    }

    item_definition_handle &play_instrument() {
        require_building_handle( token, *definition, "item" );
        definition->play_instrument = true;
        return *this;
    }

    item_definition_handle &assemble_ammo_belt( const std::string &belt ) {
        require_building_handle( token, *definition, "item" );
        if( belt.empty() ) {
            throw std::invalid_argument( "ammo belt assembly requires the resulting item id" );
        }
        definition->assembled_belt = itype_id( belt );
        return *this;
    }

    item_definition_handle &transform_on_use( const sol::table &options ) {
        require_building_handle( token, *definition, "item" );
        item_transform_action action = read_item_transform_action( options );
        if( action.minimum_age ) {
            definition->delayed_transform_use = std::move( action );
        } else {
            definition->transform_use = std::move( action );
        }
        return *this;
    }

    item_definition_handle &transform_into( const sol::table &result ) {
        require_building_handle( token, *definition, "item" );
        item_transformation transformation = read_item_transformation( result );
        if( transformation.target.is_empty() ) {
            throw std::invalid_argument( "an automatic item transformation requires a specific target" );
        }
        definition->transform_result = std::move( transformation );
        return *this;
    }

    item_definition_handle &activate_effects( const sol::table &options ) {
        require_building_handle( token, *definition, "item" );
        item_definition_data::activation_data value;
        value.message = read_singular_text( options["message"], {}, "item activation message" );
        value.move_cost = options.get_or<std::int64_t>( "move_cost", 100 );
        const sol::table effects = options.get<sol::table>( "effects" );
        const std::size_t count = require_dense_array( effects, "item activation effects", 1 );
        for( std::size_t index = 1; index <= count; ++index ) {
            const sol::table effect = effects.get<sol::table>( index );
            value.effects.push_back( {
                effect.get<std::string>( "id" ),
                effect.get_or<std::int64_t>( "duration_turns", 0 ),
                effect.get_or<std::int64_t>( "intensity", 0 ),
                effect.get_or( "permanent", false )
            } );
        }
        definition->activation = std::move( value );
        return *this;
    }

    item_definition_handle &ammo_pocket( const std::string &ammo, std::int64_t capacity ) {
        require_building_handle( token, *definition, "item" );
        if( ammo.empty() || capacity <= 0 || capacity > std::numeric_limits<int>::max() ) {
            throw std::invalid_argument( "ammo pocket requires an ammunition type and positive native capacity" );
        }
        definition->ammo_pocket[ammo] = capacity;
        return *this;
    }

    item_definition_handle &passive_enchantment( const std::string &id ) {
        require_building_handle( token, *definition, "item" );
        if( id.empty() ) {
            throw std::invalid_argument( "item passive enchantment id cannot be empty" );
        }
        definition->passive_enchantments.push_back( id );
        return *this;
    }

    item_definition_handle &teach_spells( const sol::table &spells ) {
        require_building_handle( token, *definition, "item" );
        const std::size_t count = require_dense_array( spells, "learnable spells", 1 );
        std::vector<std::string> ids;
        ids.reserve( count );
        for( std::size_t index = 1; index <= count; ++index ) {
            ids.push_back( spells.raw_get<std::string>( index ) );
        }
        definition->learned_spells = std::move( ids );
        return *this;
    }

    item_definition_handle &martial_arts_manual() {
        require_building_handle( token, *definition, "item" );
        definition->martial_arts_manual = true;
        return *this;
    }

    item_definition_handle &clear_use_actions() {
        require_building_handle( token, *definition, "item" );
        definition->clear_use_actions = true;
        definition->deploy_appliance.clear();
        definition->reveal_map.reset();
        definition->healing.reset();
        definition->use_message.reset();
        definition->cable_link.reset();
        definition->play_instrument = false;
        definition->spell_use.reset();
        definition->assembled_belt = itype_id();
        definition->transform_use.reset();
        definition->delayed_transform_use.reset();
        definition->native_use_actions.clear();
        definition->learned_spells.clear();
        definition->martial_arts_manual = false;
        definition->use_handler.clear();
        definition->use_label = {};
        definition->use_description.reset();
        return *this;
    }

    item_definition_handle &on_use( const std::string &handler,
                                    const sol::optional<sol::object> &label,
                                    const sol::optional<sol::object> &description ) {
        require_building_handle( token, *definition, "item" );
        if( handler.empty() ) {
            throw std::runtime_error( "item use handler id cannot be empty" );
        }
        authored_text parsed_label = label ?
                                     read_singular_text( *label, handler, "item use label" ) :
                                     authored_text{ handler, std::nullopt };
        std::optional<authored_text> parsed_description;
        if( description ) {
            parsed_description = read_singular_text( *description, "", "item use description" );
        }
        definition->use_handler = handler;
        definition->use_label = std::move( parsed_label );
        definition->use_description = std::move( parsed_description );
        return *this;
    }

    item_definition_handle &on_consume( const std::string &handler_id ) {
        require_building_handle( token, *definition, "item" );
        if( handler_id.empty() ) {
            throw std::runtime_error( "item consumption handler id cannot be empty" );
        }
        definition->consume_handler = handler_id;
        return *this;
    }

    item_definition_handle &clear_tick_actions() {
        require_building_handle( token, *definition, "item" );
        definition->clear_tick_actions = true;
        definition->tick_handler.clear();
        definition->native_tick_actions.clear();
        definition->tick_transform.reset();
        definition->tick_sound.reset();
        definition->tick_music.reset();
        return *this;
    }

    item_definition_handle &native_on_tick( const std::string &action ) {
        require_building_handle( token, *definition, "item" );
        if( !Item_factory::has_parameterless_iuse( action ) ) {
            throw std::invalid_argument( "unknown native item tick action '" + action + "'" );
        }
        definition->native_tick_actions.insert( action );
        return *this;
    }

    item_definition_handle &native_on_expiry( const std::string &action ) {
        require_building_handle( token, *definition, "item" );
        if( !Item_factory::has_parameterless_iuse( action ) ) {
            throw std::invalid_argument( "unknown native item expiry action '" + action + "'" );
        }
        definition->expiry_action.emplace<std::string>( action );
        return *this;
    }

    item_definition_handle &transform_on_tick( const sol::table &options ) {
        require_building_handle( token, *definition, "item" );
        item_transform_action action = read_item_transform_action( options );
        if( action.set_timer || action.minimum_age ) {
            throw std::invalid_argument( "item tick transformations do not offer interactive choices or delays" );
        }
        definition->tick_transform = std::move( action );
        return *this;
    }

    item_definition_handle &sound_on_tick( const sol::table &options ) {
        require_building_handle( token, *definition, "item" );
        item_definition_data::tick_sound_data data;
        sound_iuse &actor = data.actor;
        actor.sound_volume = item_option_int( options.get_or<std::int64_t>( "volume", 0 ), "tick sound volume" );
        actor.sound_type = io::string_to_enum<sounds::sound_t>(
                               options.get_or( "kind", std::string( "alarm" ) ) );
        actor.sound_id = options.get_or( "sound_id", std::string( "misc" ) );
        actor.sound_variant = options.get_or( "sound_variant", std::string( "default" ) );
        data.message = read_text_option( options, "message", {}, "item tick sound" );
        actor.sound_message = data.message.native();
        definition->tick_sound.emplace( std::move( data ) );
        return *this;
    }

    item_definition_handle &music_on_tick( const sol::table &options ) {
        require_building_handle( token, *definition, "item" );
        item_definition_data::tick_music_data data;
        musical_instrument_actor &actor = data.actor;
        actor.volume = item_option_int( options.get<std::int64_t>( "volume" ), "instrument volume" );
        actor.fun = item_option_int( options.get<std::int64_t>( "fun" ), "instrument fun" );
        actor.fun_bonus = item_option_int( options.get_or<std::int64_t>( "fun_bonus", 0 ), "instrument fun bonus" );
        actor.speed_penalty = item_option_int( options.get_or<std::int64_t>( "speed_penalty", 10 ),
                                              "instrument speed penalty" );
        const int interval = item_option_int( options.get<std::int64_t>( "description_interval_turns" ),
                                              "instrument description interval" );
        if( interval <= 0 ) {
            throw std::invalid_argument( "instrument description interval must be positive" );
        }
        actor.description_frequency = time_duration::from_turns( interval );
        const auto read_descriptions = [&options]( const char *key, auto &authored, auto &messages ) {
            if( const auto list = options.get<sol::optional<sol::table>>( key ) ) {
                const std::size_t count = require_dense_array( *list, key, 0 );
                for( std::size_t i = 1; i <= count; ++i ) {
                    authored.push_back( read_singular_text( list->raw_get<sol::object>( i ), {}, key ) );
                    messages.push_back( authored.back().native() );
                }
            }
        };
        read_descriptions( "player_descriptions", data.player_text, actor.player_descriptions );
        read_descriptions( "npc_descriptions", data.npc_text, actor.npc_descriptions );
        definition->tick_music.emplace( std::move( data ) );
        return *this;
    }

    item_definition_handle &on_tick( const std::string &handler_id ) {
        require_building_handle( token, *definition, "item" );
        if( handler_id.empty() ) {
            throw std::runtime_error( "item tick handler id cannot be empty" );
        }
        definition->tick_handler = handler_id;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "item" );
        return definition->id;
    }
};

std::vector<component_requirement> read_recipe_component_alternatives( const sol::table &choices )
{
    const std::size_t count = require_dense_array(
                                  choices, "recipe component alternatives", 1, 128 );
    std::vector<component_requirement> group;
    group.reserve( count );
    for( std::size_t index = 1; index <= count; ++index ) {
        const sol::object value = choices.raw_get<sol::object>( index );
        if( !value.is<sol::table>() ) {
            throw std::runtime_error( "recipe component alternatives must be tables" );
        }
        const sol::table choice = value.as<sol::table>();
        const std::string id = choice.get_or( "id", std::string() );
        const std::int64_t count = choice.get_or<std::int64_t>( "count", 1 );
        if( id.empty() || count <= 0 || count > std::numeric_limits<int>::max() ) {
            throw std::runtime_error( "recipe component alternative requires an id and positive count" );
        }
        group.push_back( { id, count, choice.get_or( "requirement", false ),
                           choice.get_or( "recoverable", true ) } );
    }
    return group;
}

std::vector<component_requirement> read_recipe_tool_alternatives( const sol::table &choices )
{
    const std::size_t count = require_dense_array(
                                  choices, "recipe tool alternatives", 1, 128 );
    std::vector<component_requirement> group;
    group.reserve( count );
    for( std::size_t index = 1; index <= count; ++index ) {
        const sol::object value = choices.raw_get<sol::object>( index );
        if( !value.is<sol::table>() ) {
            throw std::runtime_error( "recipe tool alternatives must be tables" );
        }
        const sol::table choice = value.as<sol::table>();
        const std::string id = choice.get_or( "id", std::string() );
        const sol::object raw_count = choice.raw_get<sol::object>( "count" );
        const sol::object raw_charges = choice.raw_get<sol::object>( "charges" );
        if( raw_count.valid() && raw_count.get_type() != sol::type::nil &&
            raw_charges.valid() && raw_charges.get_type() != sol::type::nil ) {
            throw std::runtime_error(
                "recipe tool alternative cannot specify both count and charges" );
        }
        const bool consumes_charges = raw_charges.valid() &&
                                      raw_charges.get_type() != sol::type::nil;
        const std::int64_t amount = consumes_charges ?
                                    raw_charges.as<std::int64_t>() :
                                    choice.get_or<std::int64_t>( "count", 1 );
        if( id.empty() || amount <= 0 || amount > std::numeric_limits<int>::max() ) {
            throw std::runtime_error(
                "recipe tool alternative requires an id and positive amount" );
        }
        group.push_back( { id, consumes_charges ? amount : -amount,
                           choice.get_or( "requirement", false ) } );
    }
    return group;
}

batch_savings::linear recipe_batch_setup( std::int64_t moves,
        const sol::optional<std::int64_t> &max_batch )
{
    if( moves < 0 || max_batch.value_or( 1 ) < 1 ||
        max_batch.value_or( 1 ) > std::numeric_limits<int>::max() ) {
        throw std::runtime_error( "recipe batch setup needs a non-negative duration and a positive maximum" );
    }
    return { moves, max_batch ? std::make_optional( static_cast<int>( *max_batch ) ) : std::nullopt };
}

batch_savings::logistic recipe_batch_discount( double max_percent, std::int64_t at_batch )
{
    if( !std::isfinite( max_percent ) || max_percent < 0.0 || max_percent > 100.0 ||
        at_batch < 1 || at_batch > std::numeric_limits<int>::max() ) {
        throw std::runtime_error( "recipe batch discount needs a percentage and a positive batch size" );
    }
    return { max_percent / 100.0, static_cast<int>( at_batch ) };
}

requirement_data make_recipe_requirements(
    const std::vector<std::vector<component_requirement>> &tool_groups,
    const std::vector<std::vector<quality_requirement_definition>> &quality_groups,
    const std::vector<std::vector<component_requirement>> &component_groups = {} )
{
    requirement_data::alter_item_comp_vector components;
    for( const std::vector<component_requirement> &group : component_groups ) {
        std::vector<item_comp> alternatives;
        for( const component_requirement &component : group ) {
            item_comp native_component( itype_id( component.id ),
                                        static_cast<int>( component.count ) );
            native_component.requirement = component.requirement;
            native_component.recoverable = component.recoverable;
            alternatives.push_back( native_component );
        }
        components.push_back( std::move( alternatives ) );
    }
    requirement_data::alter_tool_comp_vector tools;
    for( const std::vector<component_requirement> &group : tool_groups ) {
        std::vector<tool_comp> alternatives;
        for( const component_requirement &tool : group ) {
            tool_comp native_tool( itype_id( tool.id ), static_cast<int>( tool.count ) );
            native_tool.requirement = tool.requirement;
            alternatives.push_back( native_tool );
        }
        tools.push_back( std::move( alternatives ) );
    }
    requirement_data::alter_quali_req_vector qualities;
    for( const auto &group : quality_groups ) {
        auto &alternatives = qualities.emplace_back();
        for( const quality_requirement_definition &quality : group ) {
            alternatives.emplace_back( quality_id( quality.id ), static_cast<int>( quality.count ),
                                       static_cast<int>( quality.level ) );
        }
    }
    return requirement_data( tools, qualities, components );
}

blueprint_tokens read_blueprint_tokens( const sol::table &options, const char *field )
{
    blueprint_tokens result;
    if( const auto entries = options.get<sol::optional<sol::table>>( field ) ) {
        const auto size = require_dense_array( *entries, field, 0 );
        for( std::size_t i = 1; i <= size; ++i ) {
            const sol::table token = entries->raw_get<sol::table>( i );
            const std::string id = token.get<std::string>( "id" );
            const auto amount = token.get_or<std::int64_t>( "amount", 1 );
            if( id.empty() || amount <= 0 || amount > std::numeric_limits<int>::max() ) {
                throw std::runtime_error( "blueprint token needs an ID and a positive amount" );
            }
            result.emplace_back( id, static_cast<int>( amount ) );
        }
    }
    return result;
}

recipe_blueprint_needs_data read_blueprint_needs( const sol::table &options )
{
    recipe_blueprint_needs_data needs;
    const auto moves = options.get_or<std::int64_t>( "duration_moves", 0 );
    if( moves < 0 || moves > std::numeric_limits<int>::max() ) {
        throw std::runtime_error( "blueprint needs duration is outside the native range" );
    }
    needs.time = static_cast<int>( moves );
    if( const auto skills = options.get<sol::optional<sol::table>>( "skills" ) ) {
        for( const auto &[id, level] : *skills ) {
            if( !id.is<std::string>() || !level.is<std::int64_t>() ) {
                throw std::runtime_error( "blueprint needs skills must map skill IDs to levels" );
            }
            const std::string skill = id.as<std::string>();
            const auto required_level = level.as<std::int64_t>();
            if( skill.empty() || required_level < 0 || required_level > MAX_SKILL ) {
                throw std::runtime_error( "blueprint needs contains an invalid skill or level" );
            }
            needs.skills.emplace( skill, static_cast<int>( required_level ) );
        }
    }
    if( const auto components = options.get<sol::optional<sol::table>>( "components" ) ) {
        const auto size = require_dense_array( *components, "blueprint component groups", 0 );
        for( std::size_t i = 1; i <= size; ++i ) {
            needs.components.push_back( read_recipe_component_alternatives( components->raw_get<sol::table>( i ) ) );
        }
    }
    if( const auto tools = options.get<sol::optional<sol::table>>( "tools" ) ) {
        const auto size = require_dense_array( *tools, "blueprint tool groups", 0 );
        for( std::size_t i = 1; i <= size; ++i ) {
            needs.tools.push_back( read_recipe_tool_alternatives( tools->raw_get<sol::table>( i ) ) );
        }
    }
    if( const auto qualities = options.get<sol::optional<sol::table>>( "qualities" ) ) {
        const auto size = require_dense_array( *qualities, "blueprint quality groups", 0 );
        for( std::size_t i = 1; i <= size; ++i ) {
            needs.qualities.push_back( read_quality_alternatives( qualities->raw_get<sol::table>( i ),
                                       "blueprint quality alternatives" ) );
        }
    }
    return needs;
}

practice_recipe_data read_practice_recipe( const sol::table &options )
{
    const auto min = options.get<std::int64_t>( "min_difficulty" );
    const auto max = options.get_or<std::int64_t>( "max_difficulty", MAX_SKILL - 1 );
    const auto limit = options.get_or<std::int64_t>( "skill_limit", MAX_SKILL );
    if( min < 0 || max < min || max > MAX_SKILL || limit < 0 || limit > MAX_SKILL ) {
        throw std::runtime_error( "practice recipe has an invalid difficulty or skill limit" );
    }
    return { static_cast<int>( min ), static_cast<int>( max ), static_cast<int>( limit ) };
}

struct recipe_definition_handle {
    std::shared_ptr<recipe_definition_data> definition;
    std::shared_ptr<owner_token> token;

    recipe_definition_handle &duration( std::int64_t moves ) {
        require_building_handle( token, *definition, "recipe" );
        if( moves < 0 ) {
            throw std::runtime_error( "recipe duration must be nonnegative" );
        }
        definition->time_moves = moves;
        return *this;
    }

    recipe_definition_handle &result_charges( std::int64_t charges ) {
        require_building_handle( token, *definition, "recipe" );
        if( charges <= 0 || charges > std::numeric_limits<int>::max() ) {
            throw std::runtime_error( "recipe result charges are outside the native range" );
        }
        definition->result_charges = charges;
        return *this;
    }

    recipe_definition_handle &component( const std::string &id, std::int64_t count,
                                         const sol::optional<bool> &requirement,
                                         const sol::optional<bool> &recoverable ) {
        require_building_handle( token, *definition, "recipe" );
        if( id.empty() || count <= 0 || count > std::numeric_limits<int>::max() ) {
            throw std::runtime_error( "recipe component requires a non-empty id and positive count" );
        }
        definition->components.push_back( {
            { id, count, requirement.value_or( false ), recoverable.value_or( true ) }
        } );
        return *this;
    }

    recipe_definition_handle &component_any( const sol::table &choices ) {
        require_building_handle( token, *definition, "recipe" );
        definition->components.push_back( read_recipe_component_alternatives( choices ) );
        return *this;
    }

    recipe_definition_handle &tool( const std::string &id, std::int64_t count,
                                    const sol::optional<bool> &requirement ) {
        require_building_handle( token, *definition, "recipe" );
        if( id.empty() || count <= 0 || count > std::numeric_limits<int>::max() ) {
            throw std::runtime_error(
                "recipe tool requires a non-empty id and positive instance count" );
        }
        definition->tools.push_back( { { id, -count, requirement.value_or( false ) } } );
        return *this;
    }

    recipe_definition_handle &tool_charges( const std::string &id, std::int64_t charges,
                                            const sol::optional<bool> &requirement ) {
        require_building_handle( token, *definition, "recipe" );
        if( id.empty() || charges <= 0 || charges > std::numeric_limits<int>::max() ) {
            throw std::runtime_error(
                "recipe tool charges require a non-empty id and positive charge count" );
        }
        definition->tools.push_back( { { id, charges, requirement.value_or( false ) } } );
        return *this;
    }

    recipe_definition_handle &tool_any( const sol::table &choices ) {
        require_building_handle( token, *definition, "recipe" );
        definition->tools.push_back( read_recipe_tool_alternatives( choices ) );
        return *this;
    }

    recipe_definition_handle &quality( const std::string &id, std::int64_t level,
                                       std::int64_t count ) {
        require_building_handle( token, *definition, "recipe" );
        if( id.empty() || level <= 0 || count <= 0 ||
            level > std::numeric_limits<int>::max() ||
            count > std::numeric_limits<int>::max() ) {
            throw std::runtime_error( "recipe quality needs an id, positive level, and positive count" );
        }
        definition->qualities.push_back( { { id, level, count } } );
        return *this;
    }

    recipe_definition_handle &quality_any( const sol::table &choices ) {
        require_building_handle( token, *definition, "recipe" );
        definition->qualities.push_back( read_quality_alternatives( choices,
                                         "recipe quality alternatives" ) );
        return *this;
    }

    recipe_definition_handle &learn_by_disassembly( const std::string &id, std::int64_t level ) {
        require_building_handle( token, *definition, "recipe" );
        if( id.empty() || level < 0 || level > MAX_SKILL ) {
            throw std::runtime_error( "disassembly learning needs a skill id and a valid skill level" );
        }
        definition->disassembly_learning[id] = level;
        return *this;
    }

    recipe_definition_handle &requires_skill( const std::string &id, std::int64_t level ) {
        require_building_handle( token, *definition, "recipe" );
        definition->add_required_skill( id, level );
        return *this;
    }

    recipe_definition_handle &requires_stat( const std::string &name, std::int64_t minimum ) {
        require_building_handle( token, *definition, "recipe" );
        static const std::map<std::string_view, scaling_stat> stats = {
            { "strength", STAT_STR }, { "dexterity", STAT_DEX },
            { "intelligence", STAT_INT }, { "perception", STAT_PER }
        };
        const auto stat = stats.find( name );
        if( stat == stats.end() || minimum < 0 || minimum > std::numeric_limits<int>::max() ) {
            throw std::runtime_error(
                "recipe stat requirement needs a primary stat and a native non-negative minimum" );
        }
        if( minimum == 0 ) {
            definition->required_stats.erase( stat->second );
        } else {
            definition->required_stats[stat->second] = static_cast<int>( minimum );
        }
        return *this;
    }

    recipe_definition_handle &requirement( const std::string &id,
                                           std::int64_t multiplier ) {
        require_building_handle( token, *definition, "recipe" );
        if( id.empty() || multiplier <= 0 || multiplier > std::numeric_limits<int>::max() ) {
            throw std::runtime_error(
                "recipe external requirement needs a non-empty id and positive multiplier" );
        }
        auto &requirements = definition->external_requirements;
        const auto existing = std::find_if( requirements.begin(), requirements.end(),
        [&]( const auto & entry ) {
            return entry.first == id;
        } );
        if( existing == requirements.end() ) {
            requirements.emplace_back( id, multiplier );
        } else {
            existing->second = multiplier;
        }
        return *this;
    }

    recipe_definition_handle &proficiency( const std::string &id,
                                           const sol::optional<sol::table> &options ) {
        require_building_handle( token, *definition, "recipe" );
        definition->proficiencies.push_back( read_recipe_proficiency( id, options ) );
        return *this;
    }

    recipe_definition_handle &book( const std::string &id, const sol::optional<std::int64_t> &skill_level,
                                    const sol::optional<sol::table> &options ) {
        require_building_handle( token, *definition, "recipe" );
        const std::int64_t level = skill_level.value_or( -1 );
        if( id.empty() || level < -1 || level > MAX_SKILL ) {
            throw std::runtime_error( "recipe book needs an id and valid skill level" );
        }
        recipe_definition_data::book_data book;
        book.level = static_cast<int>( level );
        if( options ) {
            book.name = read_text_option( *options, "name", {}, "recipe book name" );
            book.hidden = options->get_or( "hidden", false );
        }
        definition->books[id] = std::move( book );
        return *this;
    }

    recipe_definition_handle &learn_automatically( const std::string &id, std::int64_t level ) {
        require_building_handle( token, *definition, "recipe" );
        if( id.empty() || level < 0 || level > MAX_SKILL ) {
            throw std::runtime_error( "recipe autolearn needs a skill id and a valid level" );
        }
        definition->autolearn = true;
        definition->autolearn_skills[id] = static_cast<int>( level );
        return *this;
    }

    recipe_definition_handle &batch_discount( double max_percent, std::int64_t at_batch ) {
        require_building_handle( token, *definition, "recipe" );
        definition->batching.data = recipe_batch_discount( max_percent, at_batch );
        return *this;
    }

    recipe_definition_handle &batch_setup( std::int64_t moves,
                                          const sol::optional<std::int64_t> &max_batch ) {
        require_building_handle( token, *definition, "recipe" );
        definition->batching.data = recipe_batch_setup( moves, max_batch );
        return *this;
    }

    recipe_definition_handle &step( const sol::table &options ) {
        require_building_handle( token, *definition, "recipe" );
        recipe_step_definition_data step;
        step.name = read_text_option( options, "name", {}, "crafting step name" );
        step.moves = options.get<std::int64_t>( "duration_moves" );
        step.activity = options.get<double>( "activity_level" );
        step.unattended_message = read_text_option( options, "unattended_message", {},
                                  "crafting step unattended message" );
        const std::string attention = options.get_or( "attention", std::string( "none" ) );
        if( attention == "unattended" ) {
            step.attention = step_attention::unattended;
        } else if( attention != "none" ) {
            throw std::runtime_error( "unsupported crafting step attention '" + attention + "'" );
        }
        step.max_time = read_recipe_turns( options, "max_time_turns" );
        step.grace_period = read_recipe_turns( options, "grace_period_turns" );
        if( const auto batch = options.get<sol::optional<sol::table>>( "batch" ) ) {
            if( const auto setup = batch->get<sol::optional<std::int64_t>>( "setup_moves" ) ) {
                step.batching.data = recipe_batch_setup( *setup,
                                     batch->get<sol::optional<std::int64_t>>( "max_batch" ) );
            } else {
                step.batching.data = recipe_batch_discount( batch->get<double>( "discount_percent" ),
                                     batch->get<std::int64_t>( "at_batch" ) );
            }
        }
        if( const auto tools = options.get<sol::optional<sol::table>>( "tools" ) ) {
            const auto size = require_dense_array( *tools, "crafting step tool groups", 0 );
            for( std::size_t i = 1; i <= size; ++i ) {
                step.tools.push_back( read_recipe_tool_alternatives( tools->raw_get<sol::table>( i ) ) );
            }
        }
        if( const auto qualities = options.get<sol::optional<sol::table>>( "qualities" ) ) {
            const auto size = require_dense_array( *qualities, "crafting step quality groups", 0 );
            for( std::size_t i = 1; i <= size; ++i ) {
                step.qualities.push_back( read_quality_alternatives( qualities->raw_get<sol::table>( i ),
                                          "crafting step quality alternatives" ) );
            }
        }
        if( const auto requirements = options.get<sol::optional<sol::table>>( "requirements" ) ) {
            const auto size = require_dense_array( *requirements, "crafting step requirements", 0 );
            for( std::size_t i = 1; i <= size; ++i ) {
                const sol::table entry = requirements->raw_get<sol::table>( i );
                step.requirements.emplace_back( entry.get<std::string>( "id" ),
                                                entry.get_or<std::int64_t>( "multiplier", 1 ) );
            }
        }
        if( const auto proficiencies = options.get<sol::optional<sol::table>>( "proficiencies" ) ) {
            const auto size = require_dense_array( *proficiencies, "crafting step proficiencies", 0 );
            for( std::size_t i = 1; i <= size; ++i ) {
                const sol::table entry = proficiencies->raw_get<sol::table>( i );
                step.proficiencies.push_back( read_recipe_proficiency( entry.get<std::string>( "id" ),
                                              sol::optional<sol::table>( entry ) ) );
            }
        }
        definition->steps.push_back( std::move( step ) );
        return *this;
    }

    recipe_definition_handle &camp_blueprint( const sol::table &options ) {
        require_building_handle( token, *definition, "recipe" );
        recipe_blueprint_data blueprint;
        blueprint.update = options.get<std::string>( "update" );
        if( blueprint.update.empty() ) {
            throw std::runtime_error( "camp blueprint needs an update mapgen ID" );
        }
        blueprint.name = read_text_option( options, "name", {}, "camp blueprint name" );
        blueprint.provides = read_blueprint_tokens( options, "provides" );
        blueprint.requires_tokens = read_blueprint_tokens( options, "requires" );
        blueprint.excludes = read_blueprint_tokens( options, "excludes" );
        blueprint.check_needs = options.get_or( "check_needs", true );
        if( const auto resources = options.get<sol::optional<sol::table>>( "resources" ) ) {
            const auto size = require_dense_array( *resources, "camp blueprint resources", 0 );
            for( std::size_t i = 1; i <= size; ++i ) {
                const std::string id = resources->raw_get<std::string>( i );
                if( id.empty() ) {
                    throw std::runtime_error( "camp blueprint resource needs an item ID" );
                }
                blueprint.resources.push_back( id );
            }
        }
        if( const auto parameters = options.get<sol::optional<sol::table>>( "parameter_labels" ) ) {
            for( const auto &[parameter, labels] : *parameters ) {
                if( !parameter.is<std::string>() || !labels.is<sol::table>() ) {
                    throw std::runtime_error( "camp blueprint parameters must map names to value labels" );
                }
                auto &choices = blueprint.parameter_labels[parameter.as<std::string>()];
                for( const auto &[id, label] : labels.as<sol::table>() ) {
                    if( !id.is<std::string>() ) {
                        throw std::runtime_error( "camp blueprint parameter values must have string IDs" );
                    }
                    choices.emplace( id.as<std::string>(),
                                     detail::read_singular_text( label, {}, "camp blueprint parameter label" ) );
                }
            }
        }
        if( const auto needs = options.get<sol::optional<sol::table>>( "needs" ) ) {
            blueprint.needs = read_blueprint_needs( *needs );
        }
        if( !blueprint.parameter_labels.empty() && ( blueprint.needs || !blueprint.check_needs ) ) {
            throw std::runtime_error( "parameterized camp blueprints need automatic requirements" );
        }
        definition->blueprint = std::move( blueprint );
        return *this;
    }

    recipe_definition_handle &byproduct( const std::string &id, std::int64_t count ) {
        require_building_handle( token, *definition, "recipe" );
        if( id.empty() || count <= 0 ) {
            throw std::runtime_error( "recipe byproduct needs an item id and positive count" );
        }
        int &total = definition->byproducts[id];
        if( count > std::numeric_limits<int>::max() - total ) {
            throw std::runtime_error( "recipe byproduct count is outside the native range" );
        }
        total += static_cast<int>( count );
        return *this;
    }

    recipe_definition_handle &byproducts_from_group( const std::string &id ) {
        require_building_handle( token, *definition, "recipe" );
        if( id.empty() ) {
            throw std::runtime_error( "recipe byproduct group needs an id" );
        }
        definition->byproduct_group = id;
        return *this;
    }

    recipe_definition_handle &remove_result_flag( const std::string &id ) {
        require_building_handle( token, *definition, "recipe" );
        if( id.empty() ) {
            throw std::runtime_error( "recipe result flag needs an id" );
        }
        definition->removed_result_flags.insert( id );
        return *this;
    }

    recipe_definition_handle &on_complete( const std::string &handler_id ) {
        require_building_handle( token, *definition, "recipe" );
        if( handler_id.empty() ) {
            throw std::runtime_error( "recipe completion handler id cannot be empty" );
        }
        definition->result_handler = handler_id;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "recipe" );
        return definition->id;
    }
};

struct plant_lifecycle_definition_handle {
    std::shared_ptr<plant_lifecycle_definition_data> definition;
    std::shared_ptr<owner_token> token;

    plant_lifecycle_definition_handle &on( const std::string &phase,
                                           const std::string &handler_id ) {
        require_building_handle( token, *definition, "plant lifecycle" );
        static const std::set<std::string> phases = {
            "plant", "grow", "mature", "overgrow", "harvest", "fertilize", "water"
        };
        if( phases.count( phase ) == 0 ) {
            throw std::runtime_error( "unknown plant lifecycle phase '" + phase + "'" );
        }
        if( handler_id.empty() ) {
            throw std::runtime_error( "plant lifecycle handler id cannot be empty" );
        }
        definition->handlers[phase] = handler_id;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "plant lifecycle" );
        return definition->id;
    }
};

struct nested_recipe_category_definition_handle {
    std::shared_ptr<recipe_definition_data> definition;
    std::shared_ptr<owner_token> token;

    nested_recipe_category_definition_handle &recipe( const std::string &id,
            const sol::optional<bool> &optional ) {
        require_building_handle( token, *definition, "nested recipe category" );
        if( id.empty() || !definition->nested_recipes.emplace( id, optional.value_or( false ) ).second ) {
            throw std::runtime_error(
                "nested recipe category requires unique non-empty recipe ids" );
        }
        return *this;
    }

    nested_recipe_category_definition_handle &requires_skill( const std::string &id,
            std::int64_t level ) {
        require_building_handle( token, *definition, "nested recipe category" );
        definition->add_required_skill( id, level );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "nested recipe category" );
        return definition->id;
    }
};

struct requirement_definition_handle {
    std::shared_ptr<requirement_definition_data> definition;
    std::shared_ptr<owner_token> token;

    requirement_definition_handle &component( const std::string &id, std::int64_t count,
            const sol::optional<bool> &requirement ) {
        require_building_handle( token, *definition, "requirement" );
        if( id.empty() || count <= 0 || count > std::numeric_limits<int>::max() ) {
            throw std::runtime_error( "requirement component needs an id and positive count" );
        }
        definition->components.push_back( { { id, count, requirement.value_or( false ) } } );
        return *this;
    }

    requirement_definition_handle &component_any( const sol::table &choices ) {
        require_building_handle( token, *definition, "requirement" );
        const std::size_t count = require_dense_array(
                                      choices, "requirement component alternatives", 1 );
        std::vector<component_requirement> group;
        group.reserve( count );
        for( std::size_t index = 1; index <= count; ++index ) {
            const sol::table choice = choices.raw_get<sol::table>( index );
            const std::string id = choice.get_or( "id", std::string() );
            const std::int64_t amount = choice.get_or<std::int64_t>( "count", 1 );
            if( id.empty() || amount <= 0 || amount > std::numeric_limits<int>::max() ) {
                throw std::runtime_error(
                    "requirement component alternative needs an id and positive count" );
            }
            group.push_back( { id, amount, choice.get_or( "requirement", false ) } );
        }
        definition->components.push_back( std::move( group ) );
        return *this;
    }

    requirement_definition_handle &tool( const std::string &id, std::int64_t count,
                                         const sol::optional<bool> &requirement ) {
        require_building_handle( token, *definition, "requirement" );
        if( id.empty() || count <= 0 || count > std::numeric_limits<int>::max() ) {
            throw std::runtime_error( "requirement tool needs an id and positive count" );
        }
        definition->tools.push_back( { { id, -count, requirement.value_or( false ) } } );
        return *this;
    }

    requirement_definition_handle &tool_charges( const std::string &id,
            std::int64_t charges, const sol::optional<bool> &requirement ) {
        require_building_handle( token, *definition, "requirement" );
        if( id.empty() || charges <= 0 || charges > std::numeric_limits<int>::max() ) {
            throw std::runtime_error( "requirement tool charges need an id and positive amount" );
        }
        definition->tools.push_back( { { id, charges, requirement.value_or( false ) } } );
        return *this;
    }

    requirement_definition_handle &tool_any( const sol::table &choices ) {
        require_building_handle( token, *definition, "requirement" );
        const std::size_t count = require_dense_array(
                                      choices, "requirement tool alternatives", 1 );
        std::vector<component_requirement> group;
        group.reserve( count );
        for( std::size_t index = 1; index <= count; ++index ) {
            const sol::table choice = choices.raw_get<sol::table>( index );
            const std::string id = choice.get_or( "id", std::string() );
            const sol::object raw_count = choice.raw_get<sol::object>( "count" );
            const sol::object raw_charges = choice.raw_get<sol::object>( "charges" );
            if( raw_count.valid() && raw_count.get_type() != sol::type::nil &&
                raw_charges.valid() && raw_charges.get_type() != sol::type::nil ) {
                throw std::runtime_error(
                    "requirement tool alternative cannot specify count and charges" );
            }
            const bool charges = raw_charges.valid() &&
                                 raw_charges.get_type() != sol::type::nil;
            const std::int64_t amount = charges ? raw_charges.as<std::int64_t>() :
                                        choice.get_or<std::int64_t>( "count", 1 );
            if( id.empty() || amount <= 0 || amount > std::numeric_limits<int>::max() ) {
                throw std::runtime_error(
                    "requirement tool alternative needs an id and positive amount" );
            }
            group.push_back( { id, charges ? amount : -amount,
                               choice.get_or( "requirement", false ) } );
        }
        definition->tools.push_back( std::move( group ) );
        return *this;
    }

    requirement_definition_handle &quality( const std::string &id,
                                            std::int64_t level, std::int64_t count ) {
        require_building_handle( token, *definition, "requirement" );
        if( id.empty() || level <= 0 || count <= 0 ||
            level > std::numeric_limits<int>::max() ||
            count > std::numeric_limits<int>::max() ) {
            throw std::runtime_error(
                "requirement quality needs an id, positive level, and positive count" );
        }
        definition->qualities.push_back( { { id, level, count } } );
        return *this;
    }

    requirement_definition_handle &quality_any( const sol::table &choices ) {
        require_building_handle( token, *definition, "requirement" );
        definition->qualities.push_back( read_quality_alternatives( choices,
                                         "requirement quality alternatives" ) );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "requirement" );
        return definition->id;
    }
};

struct tool_quality_definition_handle {
    std::shared_ptr<tool_quality_definition_data> definition;
    std::shared_ptr<owner_token> token;

    tool_quality_definition_handle &usage( std::int64_t level, const std::string &text ) {
        require_building_handle( token, *definition, "tool quality" );
        if( level < 0 || level > std::numeric_limits<int>::max() || text.empty() ) {
            throw std::runtime_error(
                "tool quality usage requires a non-negative native level and text" );
        }
        definition->usages.emplace_back( level, text );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "tool quality" );
        return definition->id;
    }
};

struct skill_display_definition_handle {
    std::shared_ptr<skill_display_definition_data> definition;
    std::shared_ptr<owner_token> token;

    std::string id() const {
        require_readable_handle( token, *definition, "skill display category" );
        return definition->id;
    }
};

struct skill_definition_handle {
    std::shared_ptr<skill_definition_data> definition;
    std::shared_ptr<owner_token> token;

    skill_definition_handle &tag( const std::string &value ) {
        require_building_handle( token, *definition, "skill" );
        if( value.empty() ) {
            throw std::runtime_error( "skill tag cannot be empty" );
        }
        definition->tags.insert( value );
        return *this;
    }

    skill_definition_handle &companion_practice( const std::string &id,
            std::int64_t weight ) {
        require_building_handle( token, *definition, "skill" );
        // An empty practice id is a deliberate legacy value: the skill
        // practices itself when no companion skill is specified.
        if( weight < std::numeric_limits<int>::min() ||
            weight > std::numeric_limits<int>::max() ) {
            throw std::runtime_error( "skill companion practice entry is outside the native range" );
        }
        definition->companion_practice[id] = weight;
        return *this;
    }

    skill_definition_handle &level_description( std::int64_t level,
            const sol::object &theory_value, const sol::optional<sol::object> &practice_value ) {
        require_building_handle( token, *definition, "skill" );
        authored_text theory = read_singular_text( theory_value, "", "skill theory description" );
        std::optional<authored_text> practice;
        if( practice_value ) {
            practice = read_singular_text( *practice_value, "", "skill practice description" );
        }
        if( level < 0 || level > MAX_SKILL || theory.empty() ) {
            throw std::runtime_error( "skill level description is invalid" );
        }
        // Parse both texts before changing either independent description map.
        definition->theory_descriptions[level] = std::move( theory );
        if( practice ) {
            definition->practice_descriptions[level] = std::move( *practice );
        }
        return *this;
    }

    skill_definition_handle &level_description_practice( std::int64_t level,
            const sol::object &practice_value ) {
        require_building_handle( token, *definition, "skill" );
        authored_text practice = read_singular_text( practice_value, "", "skill practice description" );
        if( level < 0 || level > MAX_SKILL || practice.empty() ) {
            throw std::runtime_error( "skill level description is invalid" );
        }
        definition->practice_descriptions[level] = std::move( practice );
        return *this;
    }

    skill_definition_handle &requires_all_trait( const std::string &id ) {
        require_building_handle( token, *definition, "skill" );
        if( id.empty() ) {
            throw std::runtime_error( "skill required trait id cannot be empty" );
        }
        definition->requires_all_traits.insert( id );
        return *this;
    }

    skill_definition_handle &requires_any_trait( const std::string &id ) {
        require_building_handle( token, *definition, "skill" );
        if( id.empty() ) {
            throw std::runtime_error( "skill required trait id cannot be empty" );
        }
        definition->requires_any_traits.insert( id );
        return *this;
    }

    skill_definition_handle &attack_time( std::int64_t minimum,
                                          std::int64_t base,
                                          std::int64_t reduction_per_level ) {
        require_building_handle( token, *definition, "skill" );
        if( minimum < 0 || base < minimum ||
            base > std::numeric_limits<int>::max() ||
            reduction_per_level < 0 || reduction_per_level > std::numeric_limits<int>::max() ) {
            throw std::runtime_error( "skill attack timing is outside the native range" );
        }
        definition->attack_min_time = minimum;
        definition->attack_base_time = base;
        definition->attack_reduction_per_level = reduction_per_level;
        return *this;
    }

    skill_definition_handle &companion_rank_factors( std::int64_t combat,
            std::int64_t survival, std::int64_t industry ) {
        require_building_handle( token, *definition, "skill" );
        const auto in_range = []( const std::int64_t value ) {
            return value >= std::numeric_limits<int>::min() &&
                   value <= std::numeric_limits<int>::max();
        };
        if( !in_range( combat ) || !in_range( survival ) || !in_range( industry ) ) {
            throw std::runtime_error( "skill companion rank factor is outside the native range" );
        }
        definition->companion_combat_rank_factor = combat;
        definition->companion_survival_rank_factor = survival;
        definition->companion_industry_rank_factor = industry;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "skill" );
        return definition->id;
    }
};

struct vitamin_definition_handle {
    std::shared_ptr<vitamin_definition_data> definition;
    std::shared_ptr<owner_token> token;

    vitamin_definition_handle &weight_micrograms( std::int64_t value ) {
        require_building_handle( token, *definition, "vitamin" );
        if( value <= 0 || value > std::numeric_limits<int>::max() ) {
            throw std::runtime_error( "vitamin unit weight is outside the native range" );
        }
        definition->weight_micrograms = value;
        return *this;
    }

    vitamin_definition_handle &deficiency_range( std::int64_t start,
            std::int64_t end ) {
        require_building_handle( token, *definition, "vitamin" );
        if( start < std::numeric_limits<int>::min() || start > std::numeric_limits<int>::max() ||
            end < std::numeric_limits<int>::min() || end > std::numeric_limits<int>::max() ) {
            throw std::runtime_error( "vitamin deficiency range is outside the native range" );
        }
        definition->disease.emplace_back( start, end );
        return *this;
    }

    vitamin_definition_handle &excess_range( std::int64_t start, std::int64_t end ) {
        require_building_handle( token, *definition, "vitamin" );
        if( start < std::numeric_limits<int>::min() || start > std::numeric_limits<int>::max() ||
            end < std::numeric_limits<int>::min() || end > std::numeric_limits<int>::max() ) {
            throw std::runtime_error( "vitamin excess range is outside the native range" );
        }
        definition->disease_excess.emplace_back( start, end );
        return *this;
    }

    vitamin_definition_handle &decays_into( const std::string &id, std::int64_t rate ) {
        require_building_handle( token, *definition, "vitamin" );
        if( id.empty() || rate < std::numeric_limits<int>::min() ||
            rate > std::numeric_limits<int>::max() ) {
            throw std::runtime_error( "vitamin decay requires an id and a signed native proportion" );
        }
        definition->decays_into.emplace_back( id, rate );
        return *this;
    }

    vitamin_definition_handle &flag( const std::string &id ) {
        require_building_handle( token, *definition, "vitamin" );
        if( id.empty() ) {
            throw std::runtime_error( "vitamin flag cannot be empty" );
        }
        definition->flags.insert( id );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "vitamin" );
        return definition->id;
    }
};

struct json_flag_definition_handle {
    std::shared_ptr<json_flag_definition_data> definition;
    std::shared_ptr<owner_token> token;

    json_flag_definition_handle &conflicts_with( const std::string &id ) {
        require_building_handle( token, *definition, "JSON flag" );
        if( id.empty() ) {
            throw std::runtime_error( "JSON flag conflict id cannot be empty" );
        }
        definition->conflicts.insert( id );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "JSON flag" );
        return definition->id;
    }
};

struct math_function_definition_handle {
    std::shared_ptr<math_function_definition_data> definition;
    std::shared_ptr<owner_token> token;

    math_function_definition_handle &arguments( const std::int64_t count ) {
        require_building_handle( token, *definition, "math function" );
        definition->num_args = count;
        return *this;
    }

    math_function_definition_handle &returns( const std::string &expression ) {
        require_building_handle( token, *definition, "math function" );
        definition->expression = expression;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "math function" );
        return definition->id;
    }
};

struct material_definition_handle {
    std::shared_ptr<material_definition_data> definition;
    std::shared_ptr<owner_token> token;

    material_definition_handle &resistance( const std::string &damage_id, double value ) {
        require_building_handle( token, *definition, "material" );
        if( damage_id.empty() || !std::isfinite( value ) ) {
            throw std::runtime_error( "material resistance requires a damage id and finite value" );
        }
        definition->resistances[damage_id] = value;
        return *this;
    }

    material_definition_handle &vitamin( const std::string &vitamin_id, double value ) {
        require_building_handle( token, *definition, "material" );
        if( vitamin_id.empty() || !std::isfinite( value ) ) {
            throw std::runtime_error( "material vitamin requires an id and finite value" );
        }
        definition->vitamins[vitamin_id] = value;
        return *this;
    }

    material_definition_handle &damage_adjective( const std::int64_t level,
            const sol::object &value ) {
        require_building_handle( token, *definition, "material" );
        authored_text parsed = read_singular_text( value, "", "material damage adjective" );
        if( level < 1 || level > 64 || parsed.empty() ) {
            throw std::runtime_error( "material damage adjective level is invalid" );
        }
        if( definition->damage_adjectives.size() < static_cast<std::size_t>( level ) ) {
            definition->damage_adjectives.resize( static_cast<std::size_t>( level ) );
        }
        definition->damage_adjectives[static_cast<std::size_t>( level - 1 )] = std::move( parsed );
        return *this;
    }

    material_definition_handle &burn( const std::int64_t intensity,
                                      const bool immune,
                                      const std::int64_t volume_ml_per_turn,
                                      const double fuel, const double smoke,
                                      const double burned ) {
        require_building_handle( token, *definition, "material" );
        if( intensity < 1 || intensity > 64 || volume_ml_per_turn < 0 ||
            volume_ml_per_turn > std::numeric_limits<units::volume::value_type>::max() ||
            !std::isfinite( fuel ) || !std::isfinite( smoke ) || !std::isfinite( burned ) ) {
            throw std::runtime_error( "material burn data is outside the native range" );
        }
        if( definition->burn_data.size() < static_cast<std::size_t>( intensity ) ) {
            definition->burn_data.resize( static_cast<std::size_t>( intensity ) );
        }
        definition->burn_data[static_cast<std::size_t>( intensity - 1 )] = {
            immune, volume_ml_per_turn, fuel, smoke, burned
        };
        return *this;
    }

    material_definition_handle &burn_product( const std::string &item_id,
            const double efficiency ) {
        require_building_handle( token, *definition, "material" );
        if( item_id.empty() || !std::isfinite( efficiency ) ) {
            throw std::runtime_error( "material burn product is invalid" );
        }
        definition->burn_products.emplace_back( item_id, efficiency );
        return *this;
    }

    material_definition_handle &fuel( const std::int64_t energy_kilojoules,
                                      const sol::optional<std::string> &pump_terrain,
                                      const sol::optional<bool> &perpetual ) {
        require_building_handle( token, *definition, "material" );
        if( energy_kilojoules < 0 ||
            energy_kilojoules > std::numeric_limits<std::int64_t>::max() / 1000000 ) {
            throw std::runtime_error( "material fuel energy is outside the native range" );
        }
        definition->has_fuel = true;
        definition->fuel_energy_kilojoules = energy_kilojoules;
        definition->fuel_pump_terrain = pump_terrain.value_or( "t_null" );
        definition->perpetual_fuel = perpetual.value_or( false );
        return *this;
    }

    material_definition_handle &fuel_explosion( const std::int64_t chance_hot,
            const std::int64_t chance_cold, const double factor, const bool fiery,
            const double size_factor ) {
        require_building_handle( token, *definition, "material" );
        if( chance_hot < 0 || chance_hot > std::numeric_limits<int>::max() ||
            chance_cold < 0 || chance_cold > std::numeric_limits<int>::max() ||
            !std::isfinite( factor ) || !std::isfinite( size_factor ) ) {
            throw std::runtime_error( "material fuel explosion data is outside the native range" );
        }
        definition->explosion_chance_hot = chance_hot;
        definition->explosion_chance_cold = chance_cold;
        definition->explosion_factor = factor;
        definition->fiery_explosion = fiery;
        definition->fuel_size_factor = size_factor;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "material" );
        return definition->id;
    }
};

struct damage_type_definition_handle {
    std::shared_ptr<damage_type_definition_data> definition;
    std::shared_ptr<owner_token> token;

    damage_type_definition_handle &derived( const std::string &id, const double factor ) {
        require_building_handle( token, *definition, "damage type" );
        if( id.empty() || !std::isfinite( factor ) ) {
            throw std::runtime_error( "derived damage requires an id and finite factor" );
        }
        definition->derived_from = id;
        definition->derived_factor = factor;
        return *this;
    }

    damage_type_definition_handle &immune_character_flag( const std::string &id ) {
        require_building_handle( token, *definition, "damage type" );
        if( id.empty() ) {
            throw std::runtime_error( "damage immunity flag cannot be empty" );
        }
        definition->character_immune_flags.insert( id );
        return *this;
    }

    damage_type_definition_handle &immune_monster_flag( const std::string &id ) {
        require_building_handle( token, *definition, "damage type" );
        if( id.empty() ) {
            throw std::runtime_error( "damage immunity flag cannot be empty" );
        }
        definition->monster_immune_flags.insert( id );
        return *this;
    }

    damage_type_definition_handle &on_hit( const std::string &handler_id ) {
        require_building_handle( token, *definition, "damage type" );
        if( handler_id.empty() ) {
            throw std::runtime_error( "damage on-hit handler id cannot be empty" );
        }
        definition->on_hit_handler = handler_id;
        return *this;
    }

    damage_type_definition_handle &on_damage( const std::string &handler_id ) {
        require_building_handle( token, *definition, "damage type" );
        if( handler_id.empty() ) {
            throw std::runtime_error( "damage on-damage handler id cannot be empty" );
        }
        definition->on_damage_handler = handler_id;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "damage type" );
        return definition->id;
    }
};

struct recipe_group_definition_handle {
    std::shared_ptr<recipe_group_definition_data> definition;
    std::shared_ptr<owner_token> token;

    recipe_group_definition_handle &recipe( const std::string &id,
                                            const sol::object &description_value ) {
        require_building_handle( token, *definition, "recipe group" );
        authored_text description = read_singular_text( description_value, "",
                                    "recipe-group entry description" );
        if( id.empty() || description.empty() ) {
            throw std::runtime_error( "recipe-group entry needs an id and description" );
        }
        definition->recipes.push_back( { id, std::move( description ), {} } );
        return *this;
    }

    recipe_group_definition_handle &terrain( const std::string &recipe_id,
            const std::string &overmap_terrain, const std::string &match_type ) {
        require_building_handle( token, *definition, "recipe group" );
        const auto found = std::find_if(
                               definition->recipes.rbegin(), definition->recipes.rend(),
        [&recipe_id]( const recipe_group_recipe_data & entry ) {
            return entry.id == recipe_id;
        } );
        if( found == definition->recipes.rend() || overmap_terrain.empty() ||
            match_type.empty() ) {
            throw std::runtime_error(
                "recipe-group terrain needs an existing recipe, terrain id, and match type" );
        }
        found->terrains.push_back( { overmap_terrain, match_type, {} } );
        return *this;
    }

    recipe_group_definition_handle &terrain_parameter( const std::string &recipe_id,
            const std::string &parameter, const sol::table &values ) {
        require_building_handle( token, *definition, "recipe group" );
        const auto found = std::find_if(
                               definition->recipes.rbegin(), definition->recipes.rend(),
        [&recipe_id]( const recipe_group_recipe_data & entry ) {
            return entry.id == recipe_id;
        } );
        if( found == definition->recipes.rend() || found->terrains.empty() || parameter.empty() ) {
            throw std::runtime_error(
                "recipe-group terrain parameter needs an existing terrain and parameter name" );
        }
        const std::size_t count = require_dense_array(
                                      values, "recipe-group terrain parameter values", 1, 128 );
        std::set<std::string> &target = found->terrains.back().parameters[parameter];
        for( std::size_t index = 1; index <= count; ++index ) {
            const std::string value = values.raw_get<std::string>( index );
            if( value.empty() ) {
                throw std::runtime_error(
                    "recipe-group terrain parameter value cannot be empty" );
            }
            target.insert( value );
        }
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "recipe group" );
        return definition->id;
    }
};

struct scent_type_definition_handle {
    std::shared_ptr<scent_type_definition_data> definition;
    std::shared_ptr<owner_token> token;

    scent_type_definition_handle &receptive_species( const std::string &id ) {
        require_building_handle( token, *definition, "scent type" );
        if( id.empty() ) {
            throw std::runtime_error( "scent receptive species id cannot be empty" );
        }
        definition->receptive_species.insert( id );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "scent type" );
        return definition->id;
    }
};

struct butchery_requirement_definition_handle {
    std::shared_ptr<butchery_requirement_definition_data> definition;
    std::shared_ptr<owner_token> token;

    butchery_requirement_definition_handle &requirement( double speed,
            const std::string &size, const std::string &butcher,
            const std::string &requirement_id ) {
        require_building_handle( token, *definition, "butchery requirement" );
        if( !std::isfinite( speed ) || speed < 0.0 ) {
            throw std::runtime_error(
                "butchery requirement speed must be a finite non-negative number" );
        }
        if( size.empty() || butcher.empty() || requirement_id.empty() ) {
            throw std::runtime_error(
                "butchery requirement size, butcher, and requirement cannot be empty" );
        }
        definition->entries.push_back(
        butchery_requirement_definition_data::requirement_entry{
            speed, size, butcher, requirement_id
        } );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "butchery requirement" );
        return definition->id;
    }
};

struct item_migration_definition_data {
    std::vector<itype_id> from;
    migration specification;
    bool registered = false;
};

struct item_migration_definition_handle {
    std::shared_ptr<item_migration_definition_data> definition;
    std::shared_ptr<owner_token> token;
};

struct item_action_definition_handle {
    std::shared_ptr<item_action_definition_data> definition;
    std::shared_ptr<owner_token> token;

    std::string id() const {
        require_readable_handle( token, *definition, "item action" );
        return definition->id;
    }
};

struct item_group_definition_handle {
        std::shared_ptr<item_group_definition_data> definition;
        std::shared_ptr<owner_token> token;

        item_group_definition_handle &item( const std::string &id,
                                            const sol::optional<std::int64_t> &probability,
                                            const sol::optional<std::string> &variant ) {
            return add_entry( id, false, probability.value_or( 100 ),
                              variant.value_or( std::string() ) );
        }

        item_group_definition_handle &group( const std::string &id,
                                             const sol::optional<std::int64_t> &probability ) {
            return add_entry( id, true, probability.value_or( 100 ), std::string() );
        }

        item_group_definition_handle &entry( const sol::table &options ) {
            require_building_handle( token, *definition, "item group" );
            std::vector<const void *> ancestors;
            definition->entries.push_back( read_entry( options, ancestors ) );
            return *this;
        }

        std::string id() const {
            require_readable_handle( token, *definition, "item group" );
            return definition->id;
        }

    private:
        static item_group_reference read_reference( const sol::table &options ) {
            const std::string item = options.get_or( "item", std::string() );
            const std::string group_id = options.get_or( "group", std::string() );
            if( item.empty() == group_id.empty() ) {
                throw std::invalid_argument( "Item-group reference requires exactly one of item or group" );
            }
            return { item.empty() ? group_id : item, item.empty() };
        }

        static std::vector<std::string> read_string_list( const sol::table &options, const char *field ) {
            std::vector<std::string> result;
            if( const auto values = options.get<sol::optional<sol::table>>( field ) ) {
                const std::size_t count = require_dense_array( *values, field, 0 );
                result.reserve( count );
                for( std::size_t i = 1; i <= count; ++i ) {
                    result.push_back( values->raw_get<std::string>( i ) );
                }
            }
            return result;
        }

        static std::optional<std::pair<int, int>> read_modifier_range( const sol::table &options,
                const char *field, int minimum, int maximum ) {
            const sol::optional<sol::table> range = options.get<sol::optional<sol::table>>( field );
            if( !range ) {
                return std::nullopt;
            }
            require_dense_array( *range, field, 2, 2 );
            const auto first = range->raw_get<std::int64_t>( 1 );
            const auto last = range->raw_get<std::int64_t>( 2 );
            if( first < minimum || first > last || last > maximum ) {
                throw std::invalid_argument( std::string( "Invalid item-group " ) + field + " range" );
            }
            return std::pair<int, int>( static_cast<int>( first ), static_cast<int>( last ) );
        }

        static item_group_entry_definition_data read_entry( const sol::table &options,
                std::vector<const void *> &ancestors ) {
            item_group_entry_definition_data value;
            value.probability = options.get_or<std::int64_t>( "probability", 100 );
            if( const auto event = options.get<sol::optional<std::string>>( "event" ) ) {
                value.event = io::string_to_enum<holiday>( *event );
            }
            const std::string item = options.get_or( "item", std::string() );
            const std::string group_id = options.get_or( "group", std::string() );
            const sol::optional<sol::table> collection =
                options.get<sol::optional<sol::table>>( "collection" );
            const sol::optional<sol::table> distribution =
                options.get<sol::optional<sol::table>>( "distribution" );
            if( static_cast<int>( !item.empty() ) + static_cast<int>( !group_id.empty() ) +
                static_cast<int>( static_cast<bool>( collection ) ) +
                static_cast<int>( static_cast<bool>( distribution ) ) != 1 ) {
                throw std::runtime_error(
                    "item-group entry requires exactly one of item, group, collection or distribution" );
            }
            if( collection || distribution ) {
                lua_State *const state = options.lua_state();
                const int top = lua_gettop( state );
                options.push();
                const void *identity = lua_topointer( state, -1 );
                lua_settop( state, top );
                if( std::find( ancestors.begin(), ancestors.end(), identity ) != ancestors.end() ) {
                    throw std::invalid_argument( "Item-group child entries must not contain table cycles" );
                }
                ancestors.push_back( identity );
                value.subgroup = collection ? Item_group::G_COLLECTION : Item_group::G_DISTRIBUTION;
                const sol::table &entries = collection ? *collection : *distribution;
                const std::size_t count = require_dense_array( entries, "item-group child entries", 0 );
                value.children.reserve( count );
                for( std::size_t i = 1; i <= count; ++i ) {
                    value.children.push_back( read_entry( entries.raw_get<sol::table>( i ), ancestors ) );
                }
                ancestors.pop_back();
                return value;
            }
            value.id = item.empty() ? group_id : item;
            value.group = item.empty();
            if( const auto variant = options.get<sol::optional<std::string>>( "variant" ) ) {
                value.variant = *variant;
                value.variant_specified = true;
            }
            if( const auto container = options.get<sol::optional<std::string>>( "container" ) ) {
                value.container = item_group_reference{ *container, false };
            }
            if( const auto container = options.get<sol::optional<std::string>>( "container_group" ) ) {
                if( value.container ) {
                    throw std::invalid_argument( "Item-group entry accepts either container or container_group" );
                }
                value.container = item_group_reference{ *container, true };
            }
            if( const auto ammo = options.get<sol::optional<sol::table>>( "ammo" ) ) {
                value.ammo = read_reference( *ammo );
            }
            if( const auto wrapper = options.get<sol::optional<std::string>>( "wrapper" ) ) {
                value.wrapper = *wrapper;
            }
            if( const auto variant = options.get<sol::optional<std::string>>( "wrapper_variant" ) ) {
                value.wrapper_variant = *variant;
            }
            if( const auto sealed = options.get<sol::optional<bool>>( "sealed" ) ) {
                value.sealed = *sealed;
            }
            if( const auto active = options.get<sol::optional<bool>>( "active" ) ) {
                value.active = *active;
            }
            value.components = read_string_list( options, "components" );
            value.flags = read_string_list( options, "flags" );
            if( const auto variables = options.get<sol::optional<sol::table>>( "variables" ) ) {
                value.variables.emplace();
                for( const auto &entry : *variables ) {
                    if( entry.first.get_type() != sol::type::string ) {
                        throw std::invalid_argument( "Item-group variable keys must be strings" );
                    }
                    const auto key = entry.first.as<std::string>();
                    value.variables->emplace( key, script_diag_value_from_lua(
                                                 entry.second, "Item-group variable '" + key + "'",
                                                 std::numeric_limits<std::size_t>::max(),
                                                 script_diag_value_read_policy::native_range ) );
                }
            }
            if( const auto artifact = options.get<sol::optional<sol::table>>( "artifact" ) ) {
                value.artifact.emplace();
                value.artifact->id = relic_procgen_id( artifact->get<std::string>( "preset" ) );
                value.artifact->rules.power_level = artifact->get<int>( "power_level" );
                value.artifact->rules.max_attributes = artifact->get<int>( "max_attributes" );
                value.artifact->rules.max_negative_power = artifact->get_or( "max_negative_power", 0 );
                value.artifact->rules.resonant = artifact->get_or( "resonant", false );
            }
            if( const sol::optional<sol::table> count =
                    options.get<sol::optional<sol::table>>( "count" ) ) {
                require_dense_array( *count, "item-group count", 2, 2 );
                value.count_specified = true;
                value.count_min = count->raw_get<std::int64_t>( 1 );
                value.count_max = count->raw_get<std::int64_t>( 2 );
            }
            if( const sol::optional<sol::table> charges =
                    options.get<sol::optional<sol::table>>( "charges" ) ) {
                require_dense_array( *charges, "item-group charges", 2, 2 );
                value.charges_specified = true;
                value.charges_min = charges->raw_get<std::int64_t>( 1 );
                value.charges_max = charges->raw_get<std::int64_t>( 2 );
            }
            value.damage = read_modifier_range( options, "damage",
                                                std::numeric_limits<int>::min() / itype::damage_scale,
                                                std::numeric_limits<int>::max() / itype::damage_scale );
            value.dirt = read_modifier_range( options, "dirt",
                                              std::numeric_limits<int>::min(), std::numeric_limits<int>::max() );
            if( const sol::optional<sol::table> contents =
                    options.get<sol::optional<sol::table>>( "contents" ) ) {
                const std::size_t count = require_dense_array( *contents, "item-group contents", 0 );
                value.contents.reserve( count );
                for( std::size_t i = 1; i <= count; ++i ) {
                    value.contents.push_back( read_reference( contents->raw_get<sol::table>( i ) ) );
                }
            }
            return value;
        }

        item_group_definition_handle &add_entry( const std::string &id, const bool group,
                const std::int64_t probability, const std::string &variant ) {
            require_building_handle( token, *definition, "item group" );
            if( id.empty() ) {
                throw std::runtime_error( "item-group entry id cannot be empty" );
            }
            definition->entries.push_back( { id, group, probability, variant } );
            return *this;
        }
};

struct ammo_effect_definition_handle {
    std::shared_ptr<ammo_effect_definition_data> definition;
    std::shared_ptr<owner_token> token;

    ammo_effect_definition_handle &field_burst( const sol::table &options ) {
        require_building_handle( token, *definition, "ammo effect" );
        ammo_field_definition_data value;
        value.field = options.get_or( "field", std::string() );
        value.intensity_min = options.get_or<std::int64_t>( "intensity_min", 1 );
        value.intensity_max = options.get_or<std::int64_t>(
                                  "intensity_max", value.intensity_min );
        value.radius = options.get_or<std::int64_t>( "radius", 1 );
        value.height = options.get_or<std::int64_t>( "height", 0 );
        value.chance = options.get_or<std::int64_t>( "chance", 100 );
        value.footprint = options.get_or<std::int64_t>( "footprint", 0 );
        value.passable_only = options.get_or( "passable_only", false );
        definition->field_bursts.push_back( std::move( value ) );
        return *this;
    }

    ammo_effect_definition_handle &trail( const sol::table &options ) {
        require_building_handle( token, *definition, "ammo effect" );
        ammo_field_definition_data value;
        value.field = options.get_or( "field", std::string() );
        value.intensity_min = options.get_or<std::int64_t>( "intensity_min", 1 );
        value.intensity_max = options.get_or<std::int64_t>(
                                  "intensity_max", value.intensity_min );
        value.chance = options.get_or<std::int64_t>( "chance", 100 );
        definition->trails.push_back( std::move( value ) );
        return *this;
    }

    ammo_effect_definition_handle &on_hit( const sol::table &options ) {
        require_building_handle( token, *definition, "ammo effect" );
        ammo_character_effect_definition_data value;
        value.effect = options.get_or( "effect", std::string() );
        value.duration_turns = options.get_or<std::int64_t>( "duration_turns", 1 );
        value.intensity_min = options.get_or<std::int64_t>( "intensity", 1 );
        value.intensity_max = value.intensity_min;
        value.touch_skin = options.get_or( "touch_skin", false );
        definition->on_hit_effects.push_back( std::move( value ) );
        return *this;
    }

    ammo_effect_definition_handle &area_effect( const sol::table &options ) {
        require_building_handle( token, *definition, "ammo effect" );
        ammo_character_effect_definition_data value;
        value.effect = options.get_or( "effect", std::string() );
        value.duration_turns = options.get_or<std::int64_t>( "duration_turns", 1 );
        value.intensity_min = options.get_or<std::int64_t>( "intensity_min", 1 );
        value.intensity_max = options.get_or<std::int64_t>(
                                  "intensity_max", value.intensity_min );
        value.chance = options.get_or<std::int64_t>( "chance", 100 );
        value.radius = options.get_or<std::int64_t>( "radius", 1 );
        value.hits_min = options.get_or<std::int64_t>( "hits_min", 1 );
        value.hits_max = options.get_or<std::int64_t>( "hits_max", value.hits_min );
        value.all_body_parts = options.get_or( "all_body_parts", false );
        definition->area_effects.push_back( std::move( value ) );
        return *this;
    }

    ammo_effect_definition_handle &explosion( const sol::table &options ) {
        require_building_handle( token, *definition, "ammo effect" );
        definition->has_explosion = true;
        definition->explosion_power = options.get_or( "power", 0.0 );
        definition->explosion_distance_factor = options.get_or( "distance_factor", 0.8 );
        definition->explosion_max_noise = options.get_or<std::int64_t>(
                                              "max_noise", 90000000 );
        definition->explosion_fire = options.get_or( "fire", false );
        definition->explosion_light = options.get_or( "light", std::string() );
        return *this;
    }

    ammo_effect_definition_handle &shrapnel( const sol::table &options ) {
        require_building_handle( token, *definition, "ammo effect" );
        definition->has_shrapnel = true;
        definition->casing_mass = options.get_or<std::int64_t>( "casing_mass", 0 );
        definition->fragment_mass = options.get_or( "fragment_mass", 0.005 );
        definition->fragment_recovery = options.get_or<std::int64_t>( "recovery", 0 );
        definition->fragment_drop = options.get_or( "drop", std::string( "null" ) );
        return *this;
    }

    ammo_effect_definition_handle &flashbang() {
        require_building_handle( token, *definition, "ammo effect" );
        definition->flashbang = true;
        return *this;
    }

    ammo_effect_definition_handle &emp() {
        require_building_handle( token, *definition, "ammo effect" );
        definition->emp = true;
        return *this;
    }

    ammo_effect_definition_handle &foamcrete() {
        require_building_handle( token, *definition, "ammo effect" );
        definition->foamcrete = true;
        return *this;
    }

    ammo_effect_definition_handle &spell( const std::string &spell_id,
                                          const sol::optional<sol::table> &options ) {
        require_building_handle( token, *definition, "ammo effect" );
        ammo_spell_definition_data value;
        value.spell = spell_id;
        if( options ) {
            value.level = options->get_or<std::int64_t>( "level", 0 );
            value.self = options->get_or( "self", false );
        }
        definition->spells.push_back( std::move( value ) );
        return *this;
    }

    ammo_effect_definition_handle &cast_spells_on_miss( const bool enabled = true ) {
        require_building_handle( token, *definition, "ammo effect" );
        definition->cast_spells_on_miss = enabled;
        return *this;
    }

    ammo_effect_definition_handle &impact_policy( const std::string &handler_id ) {
        require_building_handle( token, *definition, "ammo effect" );
        definition->impact_handler = handler_id;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "ammo effect" );
        return definition->id;
    }
};

struct ammunition_type_definition_handle {
    std::shared_ptr<ammunition_type_definition_data> definition;
    std::shared_ptr<owner_token> token;

    std::string id() const {
        require_readable_handle( token, *definition, "ammunition type" );
        return definition->id;
    }
};

struct item_category_definition_handle {
    std::shared_ptr<item_category_definition_data> definition;
    std::shared_ptr<owner_token> token;

    item_category_definition_handle &priority_zone( const std::string &zone,
            const sol::table &flags, bool filthy ) {
        require_building_handle( token, *definition, "item category" );
        if( zone.empty() ) {
            throw std::runtime_error( "item category priority zone id cannot be empty" );
        }
        item_category_priority_definition priority;
        priority.zone = zone;
        priority.filthy = filthy;
        const std::size_t count = require_dense_array(
                                      flags, "item category priority flags", 0, 128 );
        for( std::size_t index = 1; index <= count; ++index ) {
            const std::string flag = flags.raw_get<std::string>( index );
            if( flag.empty() ) {
                throw std::runtime_error( "item category priority flag cannot be empty" );
            }
            priority.flags.insert( flag );
        }
        definition->priority_zones.push_back( std::move( priority ) );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "item category" );
        return definition->id;
    }
};

struct crafting_category_definition_handle {
    std::shared_ptr<crafting_category_definition_data> definition;
    std::shared_ptr<owner_token> token;

    crafting_category_definition_handle &subcategory( const std::string &id ) {
        require_building_handle( token, *definition, "recipe category" );
        if( id.empty() ) {
            throw std::runtime_error( "recipe subcategory id cannot be empty" );
        }
        definition->subcategories.push_back( id );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "recipe category" );
        return definition->id;
    }
};

struct proficiency_category_definition_handle {
    std::shared_ptr<proficiency_category_definition_data> definition;
    std::shared_ptr<owner_token> token;

    std::string id() const {
        require_readable_handle( token, *definition, "proficiency category" );
        return definition->id;
    }
};

struct proficiency_definition_handle {
    std::shared_ptr<proficiency_definition_data> definition;
    std::shared_ptr<owner_token> token;

    proficiency_definition_handle &requires( const std::string &id ) {
        require_building_handle( token, *definition, "proficiency" );
        if( id.empty() || id == definition->id ) {
            throw std::runtime_error( "proficiency prerequisite must be another non-empty id" );
        }
        definition->required.insert( id );
        return *this;
    }

    proficiency_definition_handle &bonus( const std::string &category,
                                          const std::string &attribute, double value ) {
        require_building_handle( token, *definition, "proficiency" );
        if( category.empty() || attribute.empty() || !std::isfinite( value ) ) {
            throw std::runtime_error( "proficiency bonus requires a category, attribute, and finite value" );
        }
        definition->bonuses.push_back( { category, attribute, value } );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "proficiency" );
        return definition->id;
    }
};

struct weapon_category_definition_handle {
    std::shared_ptr<weapon_category_definition_data> definition;
    std::shared_ptr<owner_token> token;

    weapon_category_definition_handle &proficiency( const std::string &id ) {
        require_building_handle( token, *definition, "weapon category" );
        if( id.empty() ) {
            throw std::runtime_error( "weapon category proficiency id cannot be empty" );
        }
        definition->proficiencies.push_back( id );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "weapon category" );
        return definition->id;
    }
};

struct item_registration {
    definition_operation operation = definition_operation::add;
    std::shared_ptr<item_definition_data> definition;
};

struct recipe_registration {
    definition_operation operation = definition_operation::add;
    std::shared_ptr<recipe_definition_data> definition;
    bool shadowed_by_later_source = false;
};

template<typename Definition>
struct catalog_registration {
    definition_operation operation = definition_operation::add;
    std::shared_ptr<Definition> definition;
};

using plant_lifecycle_registration = catalog_registration<plant_lifecycle_definition_data>;
using tool_quality_registration = catalog_registration<tool_quality_definition_data>;
using skill_display_registration = catalog_registration<skill_display_definition_data>;
using skill_registration = catalog_registration<skill_definition_data>;
using vitamin_registration = catalog_registration<vitamin_definition_data>;
using json_flag_registration = catalog_registration<json_flag_definition_data>;
using math_function_registration = catalog_registration<math_function_definition_data>;
using material_registration = catalog_registration<material_definition_data>;
using damage_type_registration = catalog_registration<damage_type_definition_data>;
using ammunition_type_registration = catalog_registration<ammunition_type_definition_data>;
using item_category_registration = catalog_registration<item_category_definition_data>;
using crafting_category_registration = catalog_registration<crafting_category_definition_data>;
using proficiency_category_registration =
    catalog_registration<proficiency_category_definition_data>;
using proficiency_registration = catalog_registration<proficiency_definition_data>;
using weapon_category_registration = catalog_registration<weapon_category_definition_data>;
using requirement_registration = catalog_registration<requirement_definition_data>;
using recipe_group_registration = catalog_registration<recipe_group_definition_data>;
using scent_type_registration = catalog_registration<scent_type_definition_data>;
using butchery_requirement_registration =
    catalog_registration<butchery_requirement_definition_data>;
using item_action_registration = catalog_registration<item_action_definition_data>;
using item_group_registration = catalog_registration<item_group_definition_data>;
using ammo_effect_registration = catalog_registration<ammo_effect_definition_data>;

std::string operation_name( const definition_operation operation )
{
    return operation == definition_operation::add ? "add" :
           operation == definition_operation::replace ? "replace" :
           operation == definition_operation::upsert ? "upsert" :
           operation == definition_operation::extend ? "extend" : "edit";
}

std::optional<creature_size> platform_creature_size( std::string value )
{
    std::transform( value.begin(), value.end(), value.begin(), []( const unsigned char ch ) {
        return static_cast<char>( std::toupper( ch ) );
    } );
    if( value == "TINY" ) {
        return creature_size::tiny;
    }
    if( value == "SMALL" ) {
        return creature_size::small;
    }
    if( value == "MEDIUM" ) {
        return creature_size::medium;
    }
    if( value == "LARGE" ) {
        return creature_size::large;
    }
    if( value == "HUGE" ) {
        return creature_size::huge;
    }
    return std::nullopt;
}

std::optional<butcher_type> platform_butcher_type( std::string value )
{
    std::transform( value.begin(), value.end(), value.begin(), []( const unsigned char ch ) {
        return static_cast<char>( std::toupper( ch ) );
    } );
    if( value == "BLEED" ) {
        return butcher_type::BLEED;
    }
    if( value == "QUICK" ) {
        return butcher_type::QUICK;
    }
    if( value == "FULL" ) {
        return butcher_type::FULL;
    }
    if( value == "FIELD_DRESS" ) {
        return butcher_type::FIELD_DRESS;
    }
    if( value == "SKIN" ) {
        return butcher_type::SKIN;
    }
    if( value == "QUARTER" ) {
        return butcher_type::QUARTER;
    }
    if( value == "DISMEMBER" ) {
        return butcher_type::DISMEMBER;
    }
    if( value == "DISSECT" ) {
        return butcher_type::DISSECT;
    }
    return std::nullopt;
}

class lua_platform_iuse_actor : public iuse_actor
{
    public:
        lua_platform_iuse_actor( std::string mod_id, std::string handler_id,
                                 authored_text label, std::optional<authored_text> description ) :
            iuse_actor( "lua_platform" ), mod_id_( std::move( mod_id ) ),
            handler_id_( std::move( handler_id ) ), label_( std::move( label ) ),
            description_( std::move( description ) ) {}

        void load( const JsonObject &, const std::string & ) override {}

        std::optional<int> use( Character *character, item &used_item, map *here,
                                const tripoint_bub_ms &position ) const override {
            return invoke_use_handler( mod_id_, handler_id_, character, used_item,
                                       here, position );
        }

        bool supports_owned_activation() const override {
            return true;
        }

        std::unique_ptr<iuse_actor> clone() const override {
            return std::make_unique<lua_platform_iuse_actor>( *this );
        }

        std::string get_name() const override {
            return label_.native().translated();
        }

        void info( const item &, std::vector<iteminfo> &dump ) const override {
            if( description_ ) {
                dump.emplace_back( "DESCRIPTION", description_->native().translated() );
            }
        }

    private:
        std::string mod_id_;
        std::string handler_id_;
        authored_text label_;
        std::optional<authored_text> description_;
};

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

void hash_part( std::uint64_t &state, const authored_text &text )
{
    hash_part( state, text.raw );
    hash_part( state, text.translated ? "localized" : "literal" );
    if( text.translated ) {
        hash_part( state, text.translated->context ? "context" : "no_context" );
        if( text.translated->context ) {
            hash_part( state, *text.translated->context );
        }
    }
}

void hash_item_damage( std::uint64_t &state, const damage_instance &damage )
{
    hash_part( state, std::to_string( damage.damage_units.size() ) );
    for( const damage_unit &unit : damage ) {
        hash_part( state, unit.type.str() );
        std::ostringstream values;
        values << std::hexfloat << unit.amount << ' ' << unit.res_pen << ' ' << unit.res_mult << ' '
               << unit.damage_multiplier << ' ' << unit.unconditional_res_mult << ' '
               << unit.unconditional_damage_mult;
        hash_part( state, values.str() );
    }
}

void hash_throw_correction( std::uint64_t &state, const throw_correction_data &correction )
{
    hash_part( state, std::to_string( correction.required_flags.size() ) );
    for( const auto &clause : correction.required_flags ) {
        hash_part( state, std::to_string( clause.size() ) );
        for( const flag_id &flag : clause ) {
            hash_part( state, flag.str() );
        }
    }
    hash_part( state, std::to_string( correction.allowed_ammo.size() ) );
    for( const ammotype &ammo : correction.allowed_ammo ) {
        hash_part( state, ammo.str() );
    }
    for( const auto &bound : { correction.min_weight, correction.max_weight } ) {
        hash_part( state, bound ? std::to_string( units::to_milligram( *bound ) ) : "unbounded" );
    }
    hash_part( state, correction.max_volume ?
               std::to_string( units::to_milliliter( *correction.max_volume ) ) : "unbounded" );
    hash_part( state, correction.max_length ?
               std::to_string( units::to_millimeter( *correction.max_length ) ) : "unbounded" );
    hash_part( state, correction.full_bonus_skill ? std::to_string( *correction.full_bonus_skill ) : "none" );
    std::ostringstream values;
    values << std::hexfloat << correction.damage_multiplier << ' ' << correction.range_multiplier << ' '
           << correction.stamina_multiplier << ' ' << correction.dispersion_multiplier << ' '
           << correction.speed_multiplier << ' ' << correction.weight_multiplier;
    hash_part( state, values.str() );
}

void hash_item_transformation( std::uint64_t &state, const item_transformation &result )
{
    hash_part( state, result.target.str() );
    hash_part( state, result.target_group.str() );
    hash_part( state, result.container.str() );
    hash_part( state, result.variant_type );
    hash_part( state, result.sealed ? "sealed" : "unsealed" );
    hash_part( state, std::to_string( result.ammo_qty ) );
    hash_part( state, std::to_string( result.random_ammo_qty.size() ) );
    for( const int charges : result.random_ammo_qty ) {
        hash_part( state, std::to_string( charges ) );
    }
    hash_part( state, result.ammo_type.str() );
    hash_part( state, std::to_string( to_turns<int>( result.target_timer ) ) );
}

void hash_item_transform_action( std::uint64_t &state, const item_transform_action &action )
{
    hash_part( state, action.minimum_age ? "delayed_transform" : "transform" );
    hash_item_transformation( state, action.result );
    hash_part( state, action.message );
    hash_part( state, action.menu_text );
    hash_part( state, std::to_string( action.moves ) );
    hash_part( state, std::to_string( action.chance ) );
    hash_part( state, std::to_string( action.sound_volume ) );
    hash_part( state, std::to_string( action.need_charges ) );
    hash_part( state, std::to_string( action.need_fire ) );
    hash_part( state, action.ammo_scale ? std::to_string( *action.ammo_scale ) : "inherit_ammo_scale" );
    for( const bool required : { action.need_empty, action.need_wielding, action.need_worn,
                                  action.set_timer } ) {
        hash_part( state, required ? "required" : "optional" );
    }
    for( const auto *message : { &action.damage_failure_message, &action.need_charges_message,
                                 &action.need_fire_message } ) {
        hash_part( state, *message ? "specified" : "default" );
        if( *message ) {
            hash_part( state, **message );
        }
    }
    if( action.minimum_age ) {
        hash_part( state, std::to_string( *action.minimum_age ) );
        hash_part( state, action.not_ready );
    }
}

void hash_item_spell_action( std::uint64_t &state, const cast_spell_actor &spell )
{
    hash_part( state, "cast_spell" );
    hash_part( state, spell.item_spell.str() );
    hash_part( state, std::to_string( spell.spell_level ) );
    for( const bool option : { spell.no_fail, spell.need_worn, spell.need_wielding, spell.mundane } ) {
        hash_part( state, option ? "enabled" : "disabled" );
    }
}

template<typename Registration>
bool defines_registration(
    const std::vector<Registration> &entries, const std::string_view id )
{
    return std::any_of( entries.begin(), entries.end(), [id]( const Registration & entry ) {
        return entry.definition->id == id;
    } );
}

} // namespace

struct items_content_transaction::impl {
    impl( std::string owner_id, std::size_t owner_generation ) :
        owner( std::move( owner_id ) ), generation( owner_generation ),
        token( std::make_shared<owner_token>( owner_token{ owner, generation,
                                              handle_lifecycle::building } ) ) {}

    std::string owner;
    std::size_t generation = 0;
    std::shared_ptr<owner_token> token;
    std::vector<plant_lifecycle_registration> plant_lifecycles;
    std::vector<tool_quality_registration> tool_qualities;
    std::vector<skill_display_registration> skill_displays;
    std::vector<skill_registration> skills;
    std::vector<vitamin_registration> vitamins;
    std::vector<json_flag_registration> json_flags;
    std::vector<math_function_registration> math_functions;
    std::vector<material_registration> materials;
    std::vector<std::shared_ptr<item_migration_definition_data>> item_migrations;
    std::vector<std::pair<itype_id, std::optional<std::vector<migration>>>> item_migration_undo;
    std::vector<damage_type_registration> damage_types;
    std::vector<ammunition_type_registration> ammunition_types;
    std::vector<item_category_registration> item_categories;
    std::vector<crafting_category_registration> crafting_categories;
    std::vector<proficiency_category_registration> proficiency_categories;
    std::vector<proficiency_registration> proficiencies;
    std::vector<weapon_category_registration> weapon_categories;
    std::vector<requirement_registration> requirements;
    std::vector<recipe_group_registration> recipe_groups;
    std::vector<scent_type_registration> scent_types;
    std::vector<butchery_requirement_registration> butchery_requirement_entries;
    std::vector<item_action_registration> item_actions;
    std::vector<item_group_registration> item_groups;
    std::vector<ammo_effect_registration> ammo_effects;
    std::vector<item_registration> items;
    std::vector<recipe_registration> recipes;

    std::vector<std::pair<quality_id, std::optional<quality>>> tool_quality_undo;
    std::vector<std::pair<skill_displayType_id, std::optional<SkillDisplayType>>>
    skill_display_undo;
    std::vector<std::pair<skill_id, std::optional<Skill>>> skill_undo;
    std::vector<std::pair<vitamin_id, std::optional<vitamin>>> vitamin_undo;
    std::vector<std::pair<flag_id, std::optional<json_flag>>> json_flag_undo;
    std::vector<std::pair<jmath_func_id, std::optional<jmath_func>>> math_function_undo;
    std::vector<std::pair<damage_type_id, std::optional<damage_type>>> damage_type_undo;
    std::vector<std::pair<material_id, std::optional<material_type>>> material_undo;
    std::vector<std::pair<ammotype, std::optional<ammunition_type>>> ammunition_type_undo;
    std::vector<std::tuple<item_category_id, std::optional<item_category>, float>>
            item_category_undo;
    std::vector<std::pair<crafting_category_id, std::optional<crafting_category>>>
    crafting_category_undo;
    std::vector<std::pair<proficiency_category_id, std::optional<proficiency_category>>>
    proficiency_category_undo;
    std::vector<std::pair<proficiency_id, std::optional<proficiency>>> proficiency_undo;
    std::vector<std::pair<weapon_category_id, std::optional<weapon_category>>>
    weapon_category_undo;
    std::vector<std::pair<requirement_id, std::optional<requirement_data>>> requirement_undo;
    std::vector<std::pair<std::string,
        std::optional<detail::recipe_group_native_definition>>> recipe_group_undo;
    std::vector<std::pair<scenttype_id, std::optional<scent_type>>> scent_type_undo;
    std::vector<std::pair<string_id<butchery_requirements>,
        std::optional<butchery_requirements>>> butchery_requirements_undo;
    std::vector<std::pair<std::string, std::optional<item_action>>> item_action_undo;
    std::vector<std::pair<item_group_id, std::unique_ptr<Item_spawn_data>>> item_group_undo;
    std::vector<std::pair<item_group_id, std::size_t>> item_group_extension_undo;
    std::vector<std::pair<ammo_effect_str_id, std::optional<ammo_effect>>> ammo_effect_undo;
    std::vector<std::pair<itype_id, std::optional<itype>>> item_undo;
    std::vector<std::pair<std::string, std::optional<itype>>> item_abstract_undo;
    std::vector<std::pair<recipe_id, std::optional<recipe>>> recipe_undo;
    std::vector<std::pair<recipe_id, std::optional<recipe>>> uncraft_undo;
    std::vector<std::pair<requirement_id, std::optional<requirement_data>>> recipe_requirement_undo;

    mutable bool finalization_validated = false;
    items_content_apply_phase next_apply_phase = items_content_apply_phase::foundations;
    // A phase is considered applied only after all of its native writes have
    // completed.  Keeping this separate from `next_apply_phase` lets a
    // failed phase be rolled back without disturbing the strict phase order.
    int applied_phase_count = 0;
    bool requirement_changes = false;
    bool applied = false;
};

items_content_transaction::items_content_transaction( std::string owner,
        const std::size_t generation ) :
    pimpl_( std::make_unique<impl>( std::move( owner ), generation ) )
{}

items_content_transaction::~items_content_transaction() = default;

void items_content_transaction::install_lua_api( sol::state &lua, sol::table &ccb,
        sol::table &content )
{
    detail::install_content_text( content );
    ccb.new_usertype<tool_quality_definition_handle>(
        "ToolQualityDefinition", sol::no_constructor,
        "id", sol::property( &tool_quality_definition_handle::id ),
        "usage", &tool_quality_definition_handle::usage );
    ccb.new_usertype<skill_display_definition_handle>(
        "SkillDisplayDefinition", sol::no_constructor,
        "id", sol::property( &skill_display_definition_handle::id ) );
    ccb.new_usertype<skill_definition_handle>(
        "SkillDefinition", sol::no_constructor,
        "id", sol::property( &skill_definition_handle::id ),
        "tag", &skill_definition_handle::tag,
        "companion_practice", &skill_definition_handle::companion_practice,
        "level_description", &skill_definition_handle::level_description,
        "level_description_practice", &skill_definition_handle::level_description_practice,
        "requires_all_trait", &skill_definition_handle::requires_all_trait,
        "requires_any_trait", &skill_definition_handle::requires_any_trait,
        "attack_time", &skill_definition_handle::attack_time,
        "companion_rank_factors", &skill_definition_handle::companion_rank_factors );
    ccb.new_usertype<vitamin_definition_handle>(
        "VitaminDefinition", sol::no_constructor,
        "id", sol::property( &vitamin_definition_handle::id ),
        "weight_micrograms", &vitamin_definition_handle::weight_micrograms,
        "deficiency_range", &vitamin_definition_handle::deficiency_range,
        "excess_range", &vitamin_definition_handle::excess_range,
        "decays_into", &vitamin_definition_handle::decays_into,
        "flag", &vitamin_definition_handle::flag );
    ccb.new_usertype<json_flag_definition_handle>(
        "JsonFlagDefinition", sol::no_constructor,
        "id", sol::property( &json_flag_definition_handle::id ),
        "conflicts_with", &json_flag_definition_handle::conflicts_with );
    ccb.new_usertype<math_function_definition_handle>(
        "MathFunctionDefinition", sol::no_constructor,
        "id", sol::property( &math_function_definition_handle::id ),
        "arguments", &math_function_definition_handle::arguments,
        "returns", &math_function_definition_handle::returns );
    ccb.new_usertype<damage_type_definition_handle>(
        "DamageTypeDefinition", sol::no_constructor,
        "id", sol::property( &damage_type_definition_handle::id ),
        "derived", &damage_type_definition_handle::derived,
        "immune_character_flag", &damage_type_definition_handle::immune_character_flag,
        "immune_monster_flag", &damage_type_definition_handle::immune_monster_flag,
        "on_hit", &damage_type_definition_handle::on_hit,
        "on_damage", &damage_type_definition_handle::on_damage );
    ccb.new_usertype<material_definition_handle>(
        "MaterialDefinition", sol::no_constructor,
        "id", sol::property( &material_definition_handle::id ),
        "resistance", &material_definition_handle::resistance,
        "vitamin", &material_definition_handle::vitamin,
        "damage_adjective", &material_definition_handle::damage_adjective,
        "burn", &material_definition_handle::burn,
        "burn_product", &material_definition_handle::burn_product,
        "fuel", &material_definition_handle::fuel,
        "fuel_explosion", &material_definition_handle::fuel_explosion );
    ccb.new_usertype<ammunition_type_definition_handle>(
        "AmmunitionTypeDefinition", sol::no_constructor,
        "id", sol::property( &ammunition_type_definition_handle::id ) );
    ccb.new_usertype<item_category_definition_handle>(
        "ItemCategoryDefinition", sol::no_constructor,
        "id", sol::property( &item_category_definition_handle::id ),
        "priority_zone", &item_category_definition_handle::priority_zone );
    ccb.new_usertype<crafting_category_definition_handle>(
        "RecipeCategoryDefinition", sol::no_constructor,
        "id", sol::property( &crafting_category_definition_handle::id ),
        "subcategory", &crafting_category_definition_handle::subcategory );
    ccb.new_usertype<proficiency_category_definition_handle>(
        "ProficiencyCategoryDefinition", sol::no_constructor,
        "id", sol::property( &proficiency_category_definition_handle::id ) );
    ccb.new_usertype<proficiency_definition_handle>(
        "ProficiencyDefinition", sol::no_constructor,
        "id", sol::property( &proficiency_definition_handle::id ),
        "requires", &proficiency_definition_handle::requires,
        "bonus", &proficiency_definition_handle::bonus );
    ccb.new_usertype<weapon_category_definition_handle>(
        "WeaponCategoryDefinition", sol::no_constructor,
        "id", sol::property( &weapon_category_definition_handle::id ),
        "proficiency", &weapon_category_definition_handle::proficiency );
    ccb.new_usertype<item_definition_handle>(
        "ItemDefinition", sol::no_constructor,
        "id", sol::property( &item_definition_handle::id ),
        "mass_grams", &item_definition_handle::mass,
        "mass_milligrams", &item_definition_handle::mass_milligrams,
        "volume_ml", &item_definition_handle::volume,
        "price_cents", &item_definition_handle::price,
        "price_postapoc_cents", &item_definition_handle::price_postapoc,
        "melee_damage", &item_definition_handle::melee,
        "clear_melee_damage", &item_definition_handle::clear_melee_damage,
        "throwing_damage", &item_definition_handle::throwing_damage,
        "throw_correction", &item_definition_handle::throw_correction,
        "adjust_measurements", &item_definition_handle::adjust_measurements,
        "adjust_melee_damage", &item_definition_handle::adjust_melee_damage,
        "magazine_ammo", &item_definition_handle::magazine_ammo,
        "magazine_capacity", &item_definition_handle::magazine_capacity,
        "material", &item_definition_handle::material,
        "replace_material", &item_definition_handle::replace_material,
        "fault", &item_definition_handle::fault,
        "fault_group", &item_definition_handle::fault_group,
        "mounted_charge", &item_definition_handle::mounted_charge,
        "clear_mounted_charge", &item_definition_handle::clear_mounted_charge,
        "quality", &item_definition_handle::quality,
        "adjust_quality", &item_definition_handle::adjust_quality,
        "flag", &item_definition_handle::flag,
        "clear_flags", &item_definition_handle::clear_flags,
        "variants", &item_definition_handle::variants,
        "conditional_names", &item_definition_handle::conditional_names,
        "ammunition", &item_definition_handle::ammunition,
        "comestible", &item_definition_handle::comestible,
        "vitamin", &item_definition_handle::vitamin,
        "book", &item_definition_handle::book,
        "tool", &item_definition_handle::tool,
        "magazine_well", &item_definition_handle::magazine_well,
        "armor", &item_definition_handle::armor,
        "armor_portion", &item_definition_handle::armor_portion,
        "container_pocket", &item_definition_handle::container_pocket,
        "magazine_pocket", &item_definition_handle::magazine_pocket,
        "file_storage_pocket", &item_definition_handle::file_storage_pocket,
        "deploy_furniture", &item_definition_handle::deploy_furniture,
        "deploy_appliance", &item_definition_handle::deploy_appliance,
        "reveal_map", &item_definition_handle::reveal_map,
        "native_use", &item_definition_handle::native_use,
        "link_cable", &item_definition_handle::link_cable,
        "message_on_use", &item_definition_handle::message_on_use,
        "capture_creature", &item_definition_handle::capture_creature,
        "heal", &item_definition_handle::heal,
        "cast_spell", &item_definition_handle::cast_spell,
        "cast_spell_on_expiry", &item_definition_handle::cast_spell_on_expiry,
        "play_instrument", &item_definition_handle::play_instrument,
        "assemble_ammo_belt", &item_definition_handle::assemble_ammo_belt,
        "transform_on_use", &item_definition_handle::transform_on_use,
        "transform_into", &item_definition_handle::transform_into,
        "activate_effects", &item_definition_handle::activate_effects,
        "ammo_pocket", &item_definition_handle::ammo_pocket,
        "passive_enchantment", &item_definition_handle::passive_enchantment,
        "teach_spells", &item_definition_handle::teach_spells,
        "martial_arts_manual", &item_definition_handle::martial_arts_manual,
        "clear_use_actions", &item_definition_handle::clear_use_actions,
        "on_use", &item_definition_handle::on_use,
        "clear_tick_actions", &item_definition_handle::clear_tick_actions,
        "native_on_tick", &item_definition_handle::native_on_tick,
        "native_on_expiry", &item_definition_handle::native_on_expiry,
        "transform_on_tick", &item_definition_handle::transform_on_tick,
        "sound_on_tick", &item_definition_handle::sound_on_tick,
        "music_on_tick", &item_definition_handle::music_on_tick,
        "on_tick", &item_definition_handle::on_tick,
        "on_consume", &item_definition_handle::on_consume );
    ccb.new_usertype<recipe_definition_handle>(
        "RecipeDefinition", sol::no_constructor,
        "id", sol::property( &recipe_definition_handle::id ),
        "duration_moves", &recipe_definition_handle::duration,
        "result_charges", &recipe_definition_handle::result_charges,
        "component", &recipe_definition_handle::component,
        "component_any", &recipe_definition_handle::component_any,
        "tool", &recipe_definition_handle::tool,
        "tool_charges", &recipe_definition_handle::tool_charges,
        "tool_any", &recipe_definition_handle::tool_any,
        "quality", &recipe_definition_handle::quality,
        "quality_any", &recipe_definition_handle::quality_any,
        "learn_by_disassembly", &recipe_definition_handle::learn_by_disassembly,
        "requires_skill", &recipe_definition_handle::requires_skill,
        "requires_stat", &recipe_definition_handle::requires_stat,
        "requirement", &recipe_definition_handle::requirement,
        "proficiency", &recipe_definition_handle::proficiency,
        "book", &recipe_definition_handle::book,
        "learn_automatically", &recipe_definition_handle::learn_automatically,
        "batch_discount", &recipe_definition_handle::batch_discount,
        "batch_setup", &recipe_definition_handle::batch_setup,
        "step", &recipe_definition_handle::step,
        "camp_blueprint", &recipe_definition_handle::camp_blueprint,
        "byproduct", &recipe_definition_handle::byproduct,
        "byproducts_from_group", &recipe_definition_handle::byproducts_from_group,
        "remove_result_flag", &recipe_definition_handle::remove_result_flag,
        "on_complete", &recipe_definition_handle::on_complete );
    ccb.new_usertype<plant_lifecycle_definition_handle>(
        "PlantLifecycleDefinition", sol::no_constructor,
        "id", sol::property( &plant_lifecycle_definition_handle::id ),
        "on", &plant_lifecycle_definition_handle::on );
    ccb.new_usertype<nested_recipe_category_definition_handle>(
        "NestedRecipeCategoryDefinition", sol::no_constructor,
        "id", sol::property( &nested_recipe_category_definition_handle::id ),
        "requires_skill", &nested_recipe_category_definition_handle::requires_skill,
        "recipe", &nested_recipe_category_definition_handle::recipe );
    ccb.new_usertype<requirement_definition_handle>(
        "RequirementDefinition", sol::no_constructor,
        "id", sol::property( &requirement_definition_handle::id ),
        "component", &requirement_definition_handle::component,
        "component_any", &requirement_definition_handle::component_any,
        "tool", &requirement_definition_handle::tool,
        "tool_charges", &requirement_definition_handle::tool_charges,
        "tool_any", &requirement_definition_handle::tool_any,
        "quality", &requirement_definition_handle::quality,
        "quality_any", &requirement_definition_handle::quality_any );
    ccb.new_usertype<recipe_group_definition_handle>(
        "RecipeGroupDefinition", sol::no_constructor,
        "id", sol::property( &recipe_group_definition_handle::id ),
        "recipe", &recipe_group_definition_handle::recipe,
        "terrain", &recipe_group_definition_handle::terrain,
        "terrain_parameter", &recipe_group_definition_handle::terrain_parameter );
    ccb.new_usertype<scent_type_definition_handle>(
        "ScentTypeDefinition", sol::no_constructor,
        "id", sol::property( &scent_type_definition_handle::id ),
        "receptive_species", &scent_type_definition_handle::receptive_species );
    ccb.new_usertype<butchery_requirement_definition_handle>(
        "ButcheryRequirementDefinition", sol::no_constructor,
        "id", sol::property( &butchery_requirement_definition_handle::id ),
        "requirement", &butchery_requirement_definition_handle::requirement );
    ccb.new_usertype<item_migration_definition_handle>( "ItemMigrationDefinition", sol::no_constructor );
    ccb.new_usertype<item_action_definition_handle>(
        "ItemActionDefinition", sol::no_constructor,
        "id", sol::property( &item_action_definition_handle::id ) );
    ccb.new_usertype<item_group_definition_handle>(
        "ItemGroupDefinition", sol::no_constructor,
        "id", sol::property( &item_group_definition_handle::id ),
        "item", &item_group_definition_handle::item,
        "group", &item_group_definition_handle::group,
        "entry", &item_group_definition_handle::entry );
    ccb.new_usertype<ammo_effect_definition_handle>(
        "AmmoEffectDefinition", sol::no_constructor,
        "id", sol::property( &ammo_effect_definition_handle::id ),
        "field_burst", &ammo_effect_definition_handle::field_burst,
        "trail", &ammo_effect_definition_handle::trail,
        "on_hit", &ammo_effect_definition_handle::on_hit,
        "area_effect", &ammo_effect_definition_handle::area_effect,
        "explosion", &ammo_effect_definition_handle::explosion,
        "shrapnel", &ammo_effect_definition_handle::shrapnel,
        "flashbang", &ammo_effect_definition_handle::flashbang,
        "emp", &ammo_effect_definition_handle::emp,
        "foamcrete", &ammo_effect_definition_handle::foamcrete,
        "spell", &ammo_effect_definition_handle::spell,
        "cast_spells_on_miss", &ammo_effect_definition_handle::cast_spells_on_miss,
        "impact_policy", &ammo_effect_definition_handle::impact_policy );
    impl *const transaction = pimpl_.get();
    content.set_function( "ToolQuality", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<tool_quality_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = read_text_option( options, "name",
        { definition->id, std::nullopt }, "tool quality name" );
        return tool_quality_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "SkillDisplay", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<skill_display_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->label = read_singular_text( options.get<sol::object>( "label" ),
                                                definition->id, "skill display label" );
        return skill_display_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "Skill", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<skill_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = read_singular_text( options.get<sol::object>( "name" ),
                                               definition->id, "skill name" );
        definition->description = read_singular_text( options.get<sol::object>( "description" ),
                                  "", "skill description" );
        definition->display_category = options.get_or( "display_category", std::string( "none" ) );
        definition->sort_rank = options.get_or<std::int64_t>( "sort_rank", 1000000 );
        definition->teachable = options.get_or( "teachable", true );
        definition->obsolete = options.get_or( "obsolete", false );
        definition->consumes_focus = options.get_or( "consumes_focus", true );
        return skill_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "Vitamin", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<vitamin_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = read_text_option( options, "name",
        { definition->id, std::nullopt }, "vitamin name" );
        definition->type = options.get_or( "kind", std::string( "vitamin" ) );
        definition->deficiency = options.get_or( "deficiency", std::string() );
        definition->excess = options.get_or( "excess", std::string() );
        definition->minimum = options.get_or<std::int64_t>( "minimum", 0 );
        definition->maximum = options.get_or<std::int64_t>( "maximum", 0 );
        definition->rate_turns = options.get_or<std::int64_t>( "rate_turns", 1 );
        return vitamin_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "JsonFlag", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<json_flag_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->info = read_text_option( options, "info", {}, "JSON flag info" );
        definition->restriction = read_text_option( options, "restriction", {},
                                  "JSON flag restriction" );
        definition->name = read_text_option( options, "name", {}, "JSON flag name" );
        definition->item_prefix = read_text_option( options, "item_prefix", {},
                                  "JSON flag item prefix" );
        definition->item_suffix = read_text_option( options, "item_suffix", {},
                                  "JSON flag item suffix" );
        definition->requires_flag = options.get_or( "requires_flag", std::string() );
        definition->taste_modifier = options.get_or<std::int64_t>( "taste_modifier", 0 );
        definition->inherit = options.get_or( "inherit", true );
        definition->craft_inherit = options.get_or( "craft_inherit", false );
        return json_flag_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "MathFunction", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<math_function_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->num_args = options.get_or<std::int64_t>( "arguments", 0 );
        definition->expression = options.get_or( "expression", std::string() );
        return math_function_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "DamageType", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<damage_type_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = read_text_option( options, "name",
        { definition->id, std::nullopt }, "damage type name" );
        definition->skill = options.get_or( "skill", std::string() );
        definition->magic_color = options.get_or( "magic_color", std::string( "black" ) );
        definition->melee_only = options.get_or( "melee_only", false );
        definition->physical = options.get_or( "physical", false );
        definition->monster_difficulty = options.get_or( "monster_difficulty", false );
        definition->no_resist = options.get_or( "no_resist", false );
        definition->edged = options.get_or( "edged", false );
        definition->environmental = options.get_or( "environmental", false );
        definition->material_required = options.get_or( "material_required", false );
        definition->bash_conversion_factor = options.get_or(
                "bash_conversion_factor", definition->physical ? 0.5 : 0.1 );
        definition->melee_crit_dmg_mult = options.get_or( "melee_crit_dmg_mult", 0.0 );
        definition->melee_crit_dmg_mult_per_skill = options.get_or(
                    "melee_crit_dmg_mult_per_skill", 0.0 );
        definition->melee_crit_armor_mult = options.get_or( "melee_crit_armor_mult", 1.0 );
        definition->melee_crit_armor_penetration = options.get_or(
                    "melee_crit_armor_penetration", 0.0 );
        return damage_type_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "Material", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<material_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->copy_from = options.get_or( "copy_from", std::string() );
        if( !definition->copy_from.empty() ) {
            definition->damage_adjectives.clear();
        }
        const authored_text default_name{ definition->copy_from.empty() ? definition->id : "",
                                         std::nullopt };
        definition->name = read_text_option( options, "name", default_name, "material name" );
        definition->salvaged_into = options.get_or( "salvaged_into", std::string() );
        if( const sol::object rw = options["repaired_with"] ) {
            if( rw.is<sol::table>() ) {
                const std::size_t count = require_dense_array( rw.as<sol::table>(), "repaired_with", 1, 128 );
                for( std::size_t index = 1; index <= count; ++index ) {
                    definition->repaired_with.push_back( rw.as<sol::table>().raw_get<std::string>( index ) );
                }
            } else {
                definition->repaired_with.push_back( rw.as<std::string>() );
            }
        }
        definition->repaired_with_name = read_text_option( options, "repaired_with_name", {},
                                         "material repair display name" );
        definition->bash_damage_verb = read_text_option( options, "bash_damage_verb", {},
                                       "material bash damage verb" );
        definition->cut_damage_verb = read_text_option( options, "cut_damage_verb", {},
                                      "material cut damage verb" );
        if( ( options.get<sol::object>( "bash_damage_verb" ).get_type() != sol::type::nil &&
              definition->bash_damage_verb.empty() ) ||
            ( options.get<sol::object>( "cut_damage_verb" ).get_type() != sol::type::nil &&
              definition->cut_damage_verb.empty() ) ) {
            throw std::runtime_error( "material damage verbs cannot be empty" );
        }
        definition->chip_resistance = options.get<std::optional<std::int64_t>>( "chip_resistance" );
        definition->breathability = options.get<std::optional<std::int64_t>>( "breathability" );
        definition->repair_difficulty = options.get<std::optional<std::int64_t>>( "repair_difficulty" );
        definition->density = options.get<std::optional<double>>( "density" );
        definition->sheet_thickness = options.get<std::optional<double>>( "sheet_thickness" );
        definition->specific_heat_liquid = options.get<std::optional<double>>( "specific_heat_liquid" );
        definition->specific_heat_solid = options.get<std::optional<double>>( "specific_heat_solid" );
        definition->latent_heat = options.get<std::optional<double>>( "latent_heat" );
        definition->freezing_point = options.get<std::optional<double>>( "freezing_point" );
        definition->rotting = options.get<std::optional<bool>>( "rotting" );
        definition->soft = options.get<std::optional<bool>>( "soft" );
        definition->uncomfortable = options.get<std::optional<bool>>( "uncomfortable" );
        definition->conductive = options.get<std::optional<bool>>( "conductive" );
        if( const sol::optional<std::int64_t> wind =
                options.get<sol::optional<std::int64_t>>( "wind_resistance" ) ) {
            definition->wind_resistance = *wind;
        }
        return material_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "AmmunitionType", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<ammunition_type_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = read_text_option( options, "name",
        { definition->id, std::nullopt }, "ammunition type name" );
        definition->default_item = options.get_or( "default_item", std::string() );
        return ammunition_type_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "ItemCategory", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<item_category_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->header = read_text_option( options, "header",
        { definition->id, std::nullopt }, "item category header" );
        definition->noun = read_text_option( options, "noun", definition->header,
                                             "item category noun" );
        definition->sort_rank = options.get_or<std::int64_t>( "sort_rank", 0 );
        definition->spawn_rate = options.get_or( "spawn_rate", 1.0 );
        definition->zone = options.get_or( "zone", std::string() );
        return item_category_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "RecipeCategory", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<crafting_category_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->hidden = options.get_or( "hidden", false );
        definition->practice = options.get_or( "practice", false );
        definition->building = options.get_or( "building", false );
        definition->wildcard = options.get_or( "wildcard", false );
        return crafting_category_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "ProficiencyCategory", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<proficiency_category_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = read_text_option( options, "name",
        { definition->id, std::nullopt }, "proficiency category name" );
        definition->description = read_text_option( options, "description", {},
                                  "proficiency category description" );
        return proficiency_category_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "Proficiency", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<proficiency_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = read_text_option( options, "name",
        { definition->id, std::nullopt }, "proficiency name" );
        definition->description = read_text_option( options, "description", {},
                                  "proficiency description" );
        definition->category = options.get_or( "category", std::string() );
        definition->time_to_learn_turns = options.get_or<std::int64_t>(
                                              "time_to_learn_turns", 35996400 );
        definition->time_multiplier = options.get_or( "time_multiplier", 2.0 );
        definition->skill_penalty = options.get_or( "skill_penalty", 1.0 );
        definition->weakpoint_bonus = options.get_or( "weakpoint_bonus", 0.0 );
        definition->weakpoint_penalty = options.get_or( "weakpoint_penalty", 0.0 );
        definition->can_learn = options.get_or( "can_learn", false );
        definition->ignore_focus = options.get_or( "ignore_focus", false );
        definition->teachable = options.get_or( "teachable", true );
        return proficiency_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "WeaponCategory", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<weapon_category_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = read_text_option( options, "name",
        { definition->id, std::nullopt }, "weapon category name" );
        return weapon_category_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "Item", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<item_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->copy_from = options.get_or( "copy_from", std::string() );
        definition->is_abstract = options.get_or( "abstract", false );
        const auto read_string = [&options]( const char *key, std::string & target,
        bool & present ) {
            if( const sol::optional<std::string> value =
                    options.get<sol::optional<std::string>>( key ) ) {
                target = *value;
                present = true;
            }
        };
        const auto read_text = [&options, &read_string]( const char *key, std::string & raw,
        bool & present, std::optional<localized_text> &translated, const bool allow_plural ) {
            const sol::object value = options[key];
            if( value.is<localized_text>() ) {
                translated = value.as<localized_text>();
                if( translated->plural && !allow_plural ) {
                    throw std::runtime_error( "item description does not accept plural text" );
                }
                raw = translated->singular;
                present = true;
            } else {
                read_string( key, raw, present );
            }
        };
        read_text( "name", definition->name, definition->has_name, definition->translated_name, true );
        read_text( "description", definition->description, definition->has_description,
                   definition->translated_description, false );
        read_string( "symbol", definition->symbol, definition->has_symbol );
        read_string( "color", definition->color, definition->has_color );
        read_string( "category", definition->category, definition->has_category );
        read_string( "looks_like", definition->looks_like, definition->has_looks_like );
        if( const auto picture = options.get<sol::optional<std::string>>( "ascii_picture" ) ) {
            definition->ascii_picture = *picture;
        }
        if( const auto category = options.get<sol::optional<std::string>>( "snippet_category" ) ) {
            definition->snippet_category = *category;
        }
        if( const auto kind = options.get<sol::optional<std::string>>( "variant_kind" ) ) {
            definition->variant_kind = io::string_to_enum<itype_variant_kind>( *kind );
        }
        if( const auto to_hit = options.get<sol::optional<std::int64_t>>( "melee_to_hit" ) ) {
            definition->melee_to_hit = *to_hit;
        }
        if( const auto size = options.get<sol::optional<std::int64_t>>( "electronic_size_kb" ) ) {
            if( *size < 0 || *size > std::numeric_limits<units::ememory::value_type>::max() ) {
                throw std::runtime_error( "item electronic storage size is outside the native range" );
            }
            definition->electronic_size_kb = *size;
        }
        const auto read_optional = [&options]( const char *key, auto &target ) {
            using value_type = typename std::decay_t<decltype( target )>::value_type;
            if( const auto value = options.get<sol::optional<value_type>>( key ) ) {
                target = *value;
            }
        };
        read_optional( "stackable", definition->stackable );
        read_optional( "stack_size", definition->stack_size );
        read_optional( "light", definition->light );
        read_optional( "max_worn", definition->max_worn );
        read_optional( "insulation", definition->insulation );
        read_optional( "expand_snippets", definition->expand_snippets );
        if( const auto phase = options.get<sol::optional<std::string>>( "phase" ) ) {
            definition->phase = io::string_to_enum<phase_id>( *phase );
        }
        if( const auto reduction = options.get<sol::optional<std::int64_t>>( "fall_damage_reduction" ) ) {
            definition->fall_damage_reduction = item_option_int( *reduction, "fall damage reduction" );
        }
        if( const auto base = options.get<sol::optional<std::string>>( "repair_like" ) ) {
            definition->repair_like = itype_id( *base );
        }
        if( const auto monster = options.get<sol::optional<std::string>>( "source_monster" ) ) {
            definition->source_monster = mtype_id( *monster );
        }
        if( const auto duration = options.get<sol::optional<std::int64_t>>( "countdown_turns" ) ) {
            const int count = item_option_int( *duration, "item countdown" );
            if( count < 0 ) {
                throw std::invalid_argument( "item countdown cannot be negative" );
            }
            definition->countdown_interval = time_duration::from_turns( count );
        }
        definition->replace_qualities = options.get_or( "replace_qualities", false );
        if( const auto qualities = options.get<sol::optional<sol::table>>( "charged_qualities" ) ) {
            const std::size_t count = require_dense_array( *qualities, "charged tool qualities", 0 );
            auto &values = definition->charged_qualities.emplace();
            values.reserve( count );
            for( std::size_t i = 1; i <= count; ++i ) {
                const sol::table entry = qualities->raw_get<sol::table>( i );
                values.push_back( read_item_quality( entry.get<std::string>( "id" ),
                                                     entry.get<std::int64_t>( "level" ),
                                                     entry.get_or( "speed", 1.0 ) ) );
            }
        }
        definition->replace_pockets = options.get_or( "replace_pockets", false );
        definition->throwing_recovery_chance = read_nonnegative_item_int( options, "throwing_recovery_chance" );
        if( definition->throwing_recovery_chance && *definition->throwing_recovery_chance > 100 ) {
            throw std::invalid_argument( "throwing_recovery_chance must be within 0..100" );
        }
        if( const auto skills = options.get<sol::optional<sol::table>>( "minimum_skills" ) ) {
            std::map<skill_id, int> required;
            for( const auto &entry : *skills ) {
                if( entry.first.get_type() != sol::type::string || !entry.second.is<lua_Integer>() ) {
                    throw std::invalid_argument( "minimum_skills requires skill IDs and integer levels" );
                }
                required.emplace( skill_id( entry.first.as<std::string>() ),
                                  item_option_int( entry.second.as<std::int64_t>(), "minimum skill level" ) );
            }
            definition->minimum_skills = std::move( required );
        }
        if( const auto display = options.get<sol::optional<std::string>>( "display_type" ) ) {
            definition->display_type = io::string_to_enum<item_display_type>( *display );
        }
        const auto read_ids = [&options]( const char *key, auto &target ) {
            if( const auto ids = options.get<sol::optional<sol::table>>( key ) ) {
                const std::size_t count = require_dense_array( *ids, key, 0 );
                auto &values = target.emplace();
                values.reserve( count );
                for( std::size_t index = 1; index <= count; ++index ) {
                    values.push_back( ids->raw_get<std::string>( index ) );
                }
            }
        };
        read_ids( "techniques", definition->techniques );
        read_ids( "weapon_categories", definition->weapon_categories );
        read_ids( "field_emissions", definition->field_emissions );
        read_ids( "repair_materials", definition->repair_materials );
        read_ids( "remove_techniques", definition->removed_techniques );
        read_ids( "remove_qualities", definition->removed_qualities );
        if( const auto container = options.get<sol::optional<std::string>>( "default_container" ) ) {
            definition->default_container = *container;
        }
        definition->consume_handler = options.get_or(
                                          "on_consume",
                                          options.get_or( "consume_handler", std::string() ) );
        if( !definition->has_name && definition->copy_from.empty() ) {
            definition->name = definition->id;
            definition->has_name = true;
        }
        if( const sol::optional<std::int64_t> mass =
                options.get<sol::optional<std::int64_t>>( "mass_grams" ) ) {
            definition->mass_grams = *mass;
            definition->has_mass = true;
        }
        if( const auto mass = options.get<sol::optional<std::int64_t>>( "mass_milligrams" ) ) {
            if( definition->has_mass || *mass < 0 ) {
                throw std::invalid_argument( "item mass_milligrams must be non-negative and excludes mass_grams" );
            }
            definition->mass_milligrams = *mass;
            definition->has_mass = true;
        }
        if( const sol::optional<std::int64_t> volume =
                options.get<sol::optional<std::int64_t>>( "volume_ml" ) ) {
            definition->volume_ml = *volume;
            definition->has_volume = true;
        }
        if( const auto longest_side = options.get<sol::optional<std::int64_t>>( "longest_side_mm" ) ) {
            if( *longest_side < -1 ||
                *longest_side > std::numeric_limits<units::length::value_type>::max() ) {
                throw std::runtime_error( "item longest side is outside the native range" );
            }
            definition->longest_side = units::from_millimeter(
                                           static_cast<units::length::value_type>( *longest_side ) );
        }
        if( const sol::optional<std::int64_t> price =
                options.get<sol::optional<std::int64_t>>( "price_cents" ) ) {
            definition->price_cents = *price;
            definition->has_price = true;
        }
        if( const sol::optional<std::int64_t> price_postapoc =
                options.get<sol::optional<std::int64_t>>( "price_postapoc_cents" ) ) {
            definition->price_postapoc_cents = *price_postapoc;
            definition->has_price_postapoc = true;
        }
        if( const sol::optional<std::int64_t> magazine_capacity =
                options.get<sol::optional<std::int64_t>>( "magazine_capacity" ) ) {
            if( *magazine_capacity <= 0 ||
                *magazine_capacity > std::numeric_limits<int>::max() ) {
                throw std::runtime_error( "item magazine capacity is outside the native range" );
            }
            definition->magazine_capacity = *magazine_capacity;
            definition->has_magazine_capacity = true;
        }
        return item_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "ItemMigration", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<item_migration_definition_data>();
        const sol::object from = options["from"];
        if( from.is<sol::table>() ) {
            const sol::table ids = from.as<sol::table>();
            const std::size_t count = require_dense_array( ids, "item migration source ids", 1, 4096 );
            definition->from.reserve( count );
            for( std::size_t index = 1; index <= count; ++index ) {
                definition->from.emplace_back( ids.raw_get<std::string>( index ) );
            }
        } else {
            definition->from.emplace_back( from.as<std::string>() );
        }
        migration &native = definition->specification;
        native.replace = itype_id( options.get<std::string>( "to" ) );
        native.variant = options.get_or( "variant", std::string() );
        native.from_variant = options.get<std::optional<std::string>>( "from_variant" );
        const auto charges = options.get_or<std::int64_t>( "charges", 0 );
        if( charges < 0 || charges > std::numeric_limits<int>::max() ) {
            throw std::runtime_error( "item migration charges must be a nonnegative native integer" );
        }
        native.charges = static_cast<int>( charges );
        native.sealed = options.get_or( "sealed", true );
        native.reset_item_vars = options.get_or( "reset_item_vars", false );
        if( const auto flags = options.get<std::optional<sol::table>>( "flags" ) ) {
            const std::size_t count = require_dense_array( *flags, "item migration flags", 0, 4096 );
            for( std::size_t index = 1; index <= count; ++index ) {
                native.flags.insert( flags->raw_get<std::string>( index ) );
            }
        }
        if( const auto contents = options.get<std::optional<sol::table>>( "contents" ) ) {
            const std::size_t count = require_dense_array( *contents, "item migration contents", 0, 4096 );
            native.contents.reserve( count );
            for( std::size_t index = 1; index <= count; ++index ) {
                const sol::table entry = contents->raw_get<sol::table>( index );
                const auto quantity = entry.get<std::int64_t>( "count" );
                if( quantity < 0 || quantity > std::numeric_limits<int>::max() ) {
                    throw std::runtime_error( "item migration content count must be a nonnegative native integer" );
                }
                native.contents.push_back( { itype_id( entry.get<std::string>( "id" ) ),
                                             static_cast<int>( quantity ) } );
            }
        }
        return item_migration_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "Recipe", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<recipe_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->result = options.get_or( "result", std::string() );
        definition->name = read_text_option( options, "name", {}, "recipe name" );
        definition->description = read_text_option( options, "description", {}, "recipe description" );
        if( const sol::optional<sol::table> flags = options.get<sol::optional<sol::table>>( "flags" ) ) {
            const std::size_t count = require_dense_array( *flags, "recipe flags", 0, 256 );
            for( std::size_t index = 1; index <= count; ++index ) {
                const std::string flag = flags->raw_get<std::string>( index );
                if( flag.empty() ) {
                    throw std::runtime_error( "recipe flag cannot be empty" );
                }
                definition->flags.insert( flag );
            }
        }
        definition->uncraft = options.get_or( "uncraft", false );
        definition->obsolete = options.get_or( "obsolete", false );
        definition->category = options.get_or(
                                   "category", std::string( definition->uncraft ? "" : "CC_OTHER" ) );
        definition->subcategory = options.get_or(
                                      "subcategory", std::string( definition->uncraft ? "" : "CSC_OTHER_OTHER" ) );
        definition->skill = options.get_or( "skill", std::string() );
        definition->difficulty = options.get_or<std::int64_t>( "difficulty", 0 );
        definition->time_moves = options.get_or<std::int64_t>( "duration_moves", 100 );
        definition->result_multiplier = options.get_or<std::int64_t>( "result_multiplier", 1 );
        definition->autolearn = options.get_or( "autolearn", true );
        definition->never_learn = options.get_or( "never_learn", false );
        definition->disassembly_moves = options.get_or<std::int64_t>( "disassembly_moves", 0 );
        definition->reversible = options.get_or( "reversible", false ) || definition->disassembly_moves > 0;
        definition->variant = options.get_or( "variant", std::string() );
        definition->container = options.get_or( "container", std::string() );
        definition->contained = !definition->container.empty() || options.get_or( "contained", false );
        definition->sealed = options.get_or( "sealed", true );
        definition->container_variant = options.get_or( "container_variant", std::string() );
        const sol::object practice = options["practice"];
        if( practice.is<sol::table>() ) {
            definition->practice = read_practice_recipe( practice.as<sol::table>() );
        } else if( practice.valid() && practice.get_type() != sol::type::nil && !practice.is<bool>() ) {
            throw std::runtime_error( "practice recipe needs a practice definition" );
        }
        if( const auto resources = options.get<sol::optional<sol::table>>( "character_resources" ) ) {
            const auto mana = resources->get_or<std::int64_t>( "mana", 0 );
            const auto stamina = resources->get_or<std::int64_t>( "stamina", 0 );
            if( mana < 0 || mana > std::numeric_limits<int>::max() ||
                stamina < 0 || stamina > std::numeric_limits<int>::max() ) {
                throw std::runtime_error( "recipe character resource cost is outside the native range" );
            }
            definition->character_resources.mana = static_cast<int>( mana );
            definition->character_resources.stamina = static_cast<int>( stamina );
        }
        definition->activity_level = options.get_or( "activity_level", 1.0 );
        const std::int64_t morale_bonus = options.get_or<std::int64_t>( "morale_bonus", 0 );
        const std::int64_t morale_turns = options.get_or<std::int64_t>( "morale_duration_turns", 0 );
        if( morale_bonus < std::numeric_limits<int>::min() ||
            morale_bonus > std::numeric_limits<int>::max() ||
            morale_turns < 0 || morale_turns > std::numeric_limits<int>::max() ) {
            throw std::runtime_error( "recipe morale bonus or duration is outside the native range" );
        }
        definition->morale_bonus = static_cast<int>( morale_bonus );
        definition->morale_duration = time_duration::from_turns( static_cast<int>( morale_turns ) );
        definition->result_handler = options.get_or(
                                         "on_complete",
                                         options.get_or( "result_handler", std::string() ) );
        definition->scripted_output = options.get_or( "scripted_output", false );
        return recipe_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "retire_recipe", [transaction]( const std::string & id,
    const std::string & result ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<recipe_definition_data>();
        definition->id = id;
        definition->result = result;
        definition->obsolete = true;
        definition->registered = true;
        transaction->recipes.push_back( { definition_operation::upsert, std::move( definition ) } );
    } );
    content.set_function( "upsert_uncraft", [transaction]( const recipe_definition_handle & handle ) {
        if( handle.token != transaction->token || !handle.definition->uncraft ) {
            throw std::runtime_error( "upsert_uncraft requires a disassembly definition owned by this Mod" );
        }
        require_building_handle( handle.token, *handle.definition, "recipe" );
        handle.definition->registered = true;
        transaction->recipes.push_back( { definition_operation::upsert, handle.definition } );
    } );
    content.set_function( "PlantLifecycle", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<plant_lifecycle_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->target = options.get_or( "target", std::string( "seed" ) );
        for( const char *phase : {
                 "plant", "grow", "mature", "overgrow", "harvest", "fertilize", "water"
             } ) {
            const std::string handler = options.get_or(
                                            std::string( "on_" ) + phase, std::string() );
            if( !handler.empty() ) {
                definition->handlers.emplace( phase, handler );
            }
        }
        return plant_lifecycle_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "NestedRecipeCategory", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<recipe_definition_data>();
        definition->nested_category = true;
        definition->id = options.get_or( "id", std::string() );
        definition->name = read_text_option( options, "name", {},
                                             "nested recipe category name" );
        definition->description = read_text_option( options, "description", {},
                                  "nested recipe category description" );
        definition->category = options.get_or( "category", std::string() );
        definition->subcategory = options.get_or( "subcategory", std::string() );
        definition->activity_level = options.get_or( "activity_level", 1.0 );
        definition->skill = options.get_or( "skill", std::string() );
        definition->difficulty = options.get_or<std::int64_t>( "difficulty", 0 );
        return nested_recipe_category_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "Requirement", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<requirement_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = read_text_option( options, "name", {}, "requirement name" );
        return requirement_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "merge_requirement", [transaction]( const requirement_definition_handle & handle,
    const sol::optional<requirement_definition_handle> & alternatives ) {
        if( handle.token != transaction->token ) {
            throw std::runtime_error( "cannot merge a requirement owned by another Mod" );
        }
        require_building_handle( handle.token, *handle.definition, "requirement" );
        if( alternatives ) {
            if( alternatives->token != transaction->token || alternatives->definition == handle.definition ) {
                throw std::runtime_error( "requirement alternatives need a separate builder from this Mod" );
            }
            require_building_handle( alternatives->token, *alternatives->definition,
                                     "requirement alternatives" );
            if( !alternatives->definition->id.empty() || !alternatives->definition->name.empty() ) {
                throw std::runtime_error( "requirement alternatives cannot have an id or a name" );
            }
            alternatives->definition->registered = true;
            handle.definition->alternatives = alternatives->definition;
        }
        handle.definition->merge = true;
        handle.definition->registered = true;
        transaction->requirements.push_back( { definition_operation::add, handle.definition } );
    } );
    content.set_function( "RecipeGroup", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<recipe_group_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->building_type = options.get_or( "building_type", std::string( "NONE" ) );
        return recipe_group_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "ScentType", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<scent_type_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        return scent_type_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "ButcheryRequirement",
    [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<butchery_requirement_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        return butchery_requirement_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "ItemAction", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<item_action_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = read_text_option( options, "name",
        { definition->id, std::nullopt }, "item action name" );
        return item_action_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "ItemGroup", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<item_group_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->kind = options.get_or( "kind", std::string( "distribution" ) );
        definition->with_ammo = options.get_or<std::int64_t>( "with_ammo", 0 );
        definition->with_magazine = options.get_or<std::int64_t>( "with_magazine", 0 );
        if( const auto container = options.get<sol::optional<std::string>>( "container" ) ) {
            definition->container = *container;
        }
        if( const auto variant = options.get<sol::optional<std::string>>( "container_variant" ) ) {
            definition->container_variant = *variant;
        }
        const std::string overflow = options.get_or( "overflow", std::string( "none" ) );
        definition->overflow = io::string_to_enum<Item_spawn_data::overflow_behaviour>( overflow );
        definition->sealed = options.get_or( "sealed", true );
        return item_group_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
        const auto register_item_group = [transaction]( const item_group_definition_handle &handle,
    const definition_operation operation ) {
        if( handle.token != transaction->token ) {
            throw std::runtime_error( "cannot register an item group definition owned by another Mod" );
        }
        require_building_handle( handle.token, *handle.definition, "item group" );
        handle.definition->registered = true;
        transaction->item_groups.push_back( { operation, handle.definition } );
    };
    content.set_function( "extend_item_group",
    [register_item_group]( const item_group_definition_handle & handle ) {
        register_item_group( handle, definition_operation::extend );
    } );
    content.set_function( "upsert_item_group",
    [register_item_group]( const item_group_definition_handle & handle ) {
        register_item_group( handle, definition_operation::upsert );
    } );
    content.set_function( "AmmoEffect", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<ammo_effect_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->trigger_chance = options.get_or<std::int64_t>( "trigger_chance", 100 );
        return ammo_effect_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    auto edit_catalog = [transaction]( const std::string & id, auto & registrations,
    const char *kind ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        const auto found = std::find_if( registrations.rbegin(), registrations.rend(),
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
    content.set_function( "edit_tool_quality", [transaction, edit_catalog]( const std::string & id ) {
        return tool_quality_definition_handle{
            edit_catalog( id, transaction->tool_qualities, "tool_quality" ), transaction->token
        };
    } );
    content.set_function( "edit_skill_display", [transaction, edit_catalog]( const std::string & id ) {
        return skill_display_definition_handle{
            edit_catalog( id, transaction->skill_displays, "skill_display" ), transaction->token
        };
    } );
    content.set_function( "edit_skill", [transaction, edit_catalog]( const std::string & id ) {
        return skill_definition_handle{
            edit_catalog( id, transaction->skills, "skill" ), transaction->token
        };
    } );
    content.set_function( "edit_vitamin", [transaction, edit_catalog]( const std::string & id ) {
        return vitamin_definition_handle{
            edit_catalog( id, transaction->vitamins, "vitamin" ), transaction->token
        };
    } );
    content.set_function( "edit_json_flag", [transaction, edit_catalog]( const std::string & id ) {
        return json_flag_definition_handle{
            edit_catalog( id, transaction->json_flags, "json_flag" ), transaction->token
        };
    } );
    content.set_function( "upsert_json_flag", [transaction]( const json_flag_definition_handle &
    handle ) {
        if( handle.token != transaction->token ) {
            throw std::runtime_error( "cannot register a JSON flag definition owned by another Mod" );
        }
        require_building_handle( handle.token, *handle.definition, "JSON flag" );
        handle.definition->registered = true;
        transaction->json_flags.push_back( { definition_operation::upsert, handle.definition } );
    } );
    content.set_function( "edit_math_function", [transaction, edit_catalog](
    const std::string & id ) {
        return math_function_definition_handle{
            edit_catalog( id, transaction->math_functions, "math_function" ), transaction->token
        };
    } );
    content.set_function( "edit_damage_type", [transaction, edit_catalog]( const std::string & id ) {
        return damage_type_definition_handle{
            edit_catalog( id, transaction->damage_types, "damage_type" ), transaction->token
        };
    } );
    content.set_function( "edit_material", [transaction, edit_catalog]( const std::string & id ) {
        return material_definition_handle{
            edit_catalog( id, transaction->materials, "material" ), transaction->token
        };
    } );
    content.set_function( "edit_ammunition_type", [transaction, edit_catalog](
    const std::string & id ) {
        return ammunition_type_definition_handle{
            edit_catalog( id, transaction->ammunition_types, "ammunition_type" ),
            transaction->token
        };
    } );
    content.set_function( "upsert_ammunition_type", [transaction](
    const ammunition_type_definition_handle & handle ) {
        if( handle.token != transaction->token ) {
            throw std::runtime_error( "cannot register an ammunition type definition owned by another Mod" );
        }
        require_building_handle( handle.token, *handle.definition, "ammunition type" );
        handle.definition->registered = true;
        transaction->ammunition_types.push_back( { definition_operation::upsert, handle.definition } );
    } );
    content.set_function( "edit_item_category", [transaction, edit_catalog](
    const std::string & id ) {
        return item_category_definition_handle{
            edit_catalog( id, transaction->item_categories, "item_category" ), transaction->token
        };
    } );
    content.set_function( "edit_recipe_category", [transaction, edit_catalog](
    const std::string & id ) {
        return crafting_category_definition_handle{
            edit_catalog( id, transaction->crafting_categories, "recipe_category" ),
            transaction->token
        };
    } );
    content.set_function( "edit_proficiency_category", [transaction, edit_catalog](
    const std::string & id ) {
        return proficiency_category_definition_handle{
            edit_catalog( id, transaction->proficiency_categories, "proficiency_category" ),
            transaction->token
        };
    } );
    content.set_function( "edit_proficiency", [transaction, edit_catalog](
    const std::string & id ) {
        return proficiency_definition_handle{
            edit_catalog( id, transaction->proficiencies, "proficiency" ), transaction->token
        };
    } );
    content.set_function( "edit_weapon_category", [transaction, edit_catalog](
    const std::string & id ) {
        return weapon_category_definition_handle{
            edit_catalog( id, transaction->weapon_categories, "weapon_category" ),
            transaction->token
        };
    } );
    content.set_function( "edit_requirement", [transaction, edit_catalog](
    const std::string & id ) {
        return requirement_definition_handle{
            edit_catalog( id, transaction->requirements, "requirement" ), transaction->token
        };
    } );
    content.set_function( "edit_recipe_group", [transaction, edit_catalog](
    const std::string & id ) {
        return recipe_group_definition_handle{
            edit_catalog( id, transaction->recipe_groups, "recipe_group" ), transaction->token
        };
    } );
    content.set_function( "edit_scent_type", [transaction, edit_catalog](
    const std::string & id ) {
        return scent_type_definition_handle{
            edit_catalog( id, transaction->scent_types, "scent_type" ), transaction->token
        };
    } );
    content.set_function( "edit_item_group", [transaction, edit_catalog](
    const std::string & id ) {
        return item_group_definition_handle{
            edit_catalog( id, transaction->item_groups, "item_group" ),
            transaction->token
        };
    } );
    content.set_function( "edit_ammo_effect", [transaction, edit_catalog](
    const std::string & id ) {
        return ammo_effect_definition_handle{
            edit_catalog( id, transaction->ammo_effects, "ammo_effect" ),
            transaction->token
        };
    } );
    content.set_function( "edit_item", [transaction]( const std::string & id ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        const auto found = std::find_if(
                               transaction->items.rbegin(), transaction->items.rend(),
        [&id]( const item_registration & entry ) {
            return entry.definition->id == id;
        } );
        if( found == transaction->items.rend() ) {
            throw std::runtime_error(
                "edit_item requires an item staged earlier by this Mod" );
        }
        auto definition = std::make_shared<item_definition_data>( *found->definition );
        definition->registered = false;
        return item_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "upsert_item", [transaction]( const item_definition_handle & handle ) {
        if( handle.token != transaction->token ) {
            throw std::runtime_error( "cannot register an item definition owned by another Mod" );
        }
        require_building_handle( handle.token, *handle.definition, "item" );
        handle.definition->registered = true;
        transaction->items.push_back( { definition_operation::upsert, handle.definition } );
    } );
    content.set_function( "edit_recipe", [transaction]( const std::string & id ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        const auto found = std::find_if(
                               transaction->recipes.rbegin(), transaction->recipes.rend(),
        [&id]( const recipe_registration & entry ) {
            return entry.definition->id == id;
        } );
        if( found == transaction->recipes.rend() ) {
            throw std::runtime_error(
                "edit_recipe requires a recipe staged earlier by this Mod" );
        }
        auto definition = std::make_shared<recipe_definition_data>( *found->definition );
        if( definition->nested_category ) {
            throw std::runtime_error(
                "edit_recipe cannot edit a nested category; use edit_nested_recipe_category" );
        }
        definition->registered = false;
        return recipe_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "edit_nested_recipe_category", [transaction](
    const std::string & id ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        const auto found = std::find_if(
                               transaction->recipes.rbegin(), transaction->recipes.rend(),
        [&id]( const recipe_registration & entry ) {
            return entry.definition->id == id;
        } );
        if( found == transaction->recipes.rend() || !found->definition->nested_category ) {
            throw std::runtime_error(
                "edit_nested_recipe_category requires a nested category staged earlier by this Mod" );
        }
        auto definition = std::make_shared<recipe_definition_data>( *found->definition );
        definition->registered = false;
        return nested_recipe_category_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    static_cast<void>( lua );
}

requirement_data items_content_transaction::read_inline_requirement( const sol::object &value ) const
{
    if( !value.is<requirement_definition_handle>() ) {
        throw std::runtime_error( "inline requirements must use a Requirement builder" );
    }
    const auto handle = value.as<requirement_definition_handle>();
    if( handle.token != pimpl_->token ) {
        throw std::runtime_error( "inline requirements must come from the same Mod" );
    }
    require_building_handle( handle.token, *handle.definition, "inline requirement" );
    if( !handle.definition->id.empty() || !handle.definition->name.empty() ) {
        throw std::runtime_error( "inline requirements cannot have an id or a name" );
    }
    return native_requirement_groups( *handle.definition );
}

bool items_content_transaction::register_definition( const sol::object &value,
        const int raw_operation )
{
    if( raw_operation < 0 || raw_operation > 2 ) {
        throw std::runtime_error( "invalid Platform content operation" );
    }
    const definition_operation operation = static_cast<definition_operation>( raw_operation );
    if( pimpl_->token->lifecycle != handle_lifecycle::building ) {
        throw std::runtime_error( "content transaction is no longer building" );
    }
    const auto register_catalog = [this, operation]( auto handle, auto & registrations,
    const char *kind ) {
        if( handle.token != pimpl_->token ) {
            throw std::runtime_error( std::string( "cannot register a " ) + kind +
                                      " definition owned by another Mod" );
        }
        require_building_handle( handle.token, *handle.definition, kind );
        handle.definition->registered = true;
        if( operation == definition_operation::edit ) {
            const auto target = std::find_if( registrations.rbegin(), registrations.rend(),
            [&handle]( const auto & entry ) {
                return entry.definition->id == handle.definition->id;
            } );
            if( target == registrations.rend() ) {
                handle.definition->registered = false;
                throw std::runtime_error( std::string( "edit requires a " ) + kind +
                                          " staged earlier by this Mod" );
            }
            target->definition = handle.definition;
            return;
        }
        registrations.push_back( { operation, handle.definition } );
    };
    if( value.is<item_migration_definition_handle>() ) {
        const auto handle = value.as<item_migration_definition_handle>();
        if( handle.token != pimpl_->token || operation != definition_operation::add ) {
            throw std::runtime_error( "item migrations must be added by their owning Mod" );
        }
        require_building_handle( handle.token, *handle.definition, "item migration" );
        handle.definition->registered = true;
        pimpl_->item_migrations.push_back( handle.definition );
        return true;
    }
    if( value.is<item_definition_handle>() ) {
        const item_definition_handle &handle = value.as<item_definition_handle>();
        register_catalog( handle, pimpl_->items, "item" );
        return true;
    }
    if( value.is<tool_quality_definition_handle>() ) {
        register_catalog( value.as<tool_quality_definition_handle>(), pimpl_->tool_qualities,
                          "tool quality" );
        return true;
    }
    if( value.is<skill_display_definition_handle>() ) {
        register_catalog( value.as<skill_display_definition_handle>(), pimpl_->skill_displays,
                          "skill display category" );
        return true;
    }
    if( value.is<skill_definition_handle>() ) {
        register_catalog( value.as<skill_definition_handle>(), pimpl_->skills, "skill" );
        return true;
    }
    if( value.is<vitamin_definition_handle>() ) {
        register_catalog( value.as<vitamin_definition_handle>(), pimpl_->vitamins, "vitamin" );
        return true;
    }
    if( value.is<json_flag_definition_handle>() ) {
        register_catalog( value.as<json_flag_definition_handle>(), pimpl_->json_flags, "JSON flag" );
        return true;
    }
    if( value.is<math_function_definition_handle>() ) {
        register_catalog( value.as<math_function_definition_handle>(), pimpl_->math_functions,
                          "math function" );
        return true;
    }
    if( value.is<damage_type_definition_handle>() ) {
        register_catalog( value.as<damage_type_definition_handle>(), pimpl_->damage_types, "damage type" );
        return true;
    }
    if( value.is<material_definition_handle>() ) {
        register_catalog( value.as<material_definition_handle>(), pimpl_->materials, "material" );
        return true;
    }
    if( value.is<ammunition_type_definition_handle>() ) {
        register_catalog( value.as<ammunition_type_definition_handle>(), pimpl_->ammunition_types,
                          "ammunition type" );
        return true;
    }
    if( value.is<item_category_definition_handle>() ) {
        register_catalog( value.as<item_category_definition_handle>(), pimpl_->item_categories,
                          "item category" );
        return true;
    }
    if( value.is<crafting_category_definition_handle>() ) {
        register_catalog( value.as<crafting_category_definition_handle>(), pimpl_->crafting_categories,
                          "recipe category" );
        return true;
    }
    if( value.is<proficiency_category_definition_handle>() ) {
        register_catalog( value.as<proficiency_category_definition_handle>(),
                          pimpl_->proficiency_categories, "proficiency category" );
        return true;
    }
    if( value.is<proficiency_definition_handle>() ) {
        register_catalog( value.as<proficiency_definition_handle>(), pimpl_->proficiencies, "proficiency" );
        return true;
    }
    if( value.is<weapon_category_definition_handle>() ) {
        register_catalog( value.as<weapon_category_definition_handle>(), pimpl_->weapon_categories,
                          "weapon category" );
        return true;
    }
    if( value.is<requirement_definition_handle>() ) {
        register_catalog( value.as<requirement_definition_handle>(), pimpl_->requirements, "requirement" );
        return true;
    }
    if( value.is<recipe_group_definition_handle>() ) {
        register_catalog( value.as<recipe_group_definition_handle>(), pimpl_->recipe_groups,
                          "recipe group" );
        return true;
    }
    if( value.is<scent_type_definition_handle>() ) {
        register_catalog( value.as<scent_type_definition_handle>(), pimpl_->scent_types, "scent type" );
        return true;
    }
    if( value.is<butchery_requirement_definition_handle>() ) {
        register_catalog( value.as<butchery_requirement_definition_handle>(),
                          pimpl_->butchery_requirement_entries, "butchery requirement" );
        return true;
    }
    if( value.is<item_action_definition_handle>() ) {
        register_catalog( value.as<item_action_definition_handle>(), pimpl_->item_actions, "item action" );
        return true;
    }
    if( value.is<item_group_definition_handle>() ) {
        register_catalog( value.as<item_group_definition_handle>(), pimpl_->item_groups, "item group" );
        return true;
    }
    if( value.is<ammo_effect_definition_handle>() ) {
        register_catalog( value.as<ammo_effect_definition_handle>(), pimpl_->ammo_effects, "ammo effect" );
        return true;
    }
    if( value.is<nested_recipe_category_definition_handle>() ) {
        register_catalog( value.as<nested_recipe_category_definition_handle>(),
                          pimpl_->recipes, "nested recipe category" );
        return true;
    }
    if( value.is<recipe_definition_handle>() ) {
        register_catalog( value.as<recipe_definition_handle>(), pimpl_->recipes, "recipe" );
        return true;
    }
    if( value.is<plant_lifecycle_definition_handle>() ) {
        if( operation != definition_operation::add ) {
            throw std::runtime_error( "plant lifecycle definitions can only be added" );
        }
        register_catalog( value.as<plant_lifecycle_definition_handle>(),
                          pimpl_->plant_lifecycles, "plant lifecycle" );
        return true;
    }
    return false;
}

// NOLINTNEXTLINE(readability-function-size)
bool items_content_transaction::validate( const runtime &owner_runtime,
        const bool check_engine_state, const items_content_validation_context &context,
        std::string &error ) const
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
            if( operation == definition_operation::extend && !exists ) {
                throw std::runtime_error( std::string( "extend requires existing " ) +
                                          kind + " '" + id + "'" );
            }
        };
        const auto native_int = []( const std::int64_t value ) {
            return value >= std::numeric_limits<int>::min() &&
                   value <= std::numeric_limits<int>::max();
        };
        const auto native_nonnegative_int = []( const std::int64_t value ) {
            return value >= 0 && value <= std::numeric_limits<int>::max();
        };
        const auto finite_native_float = []( const double value ) {
            return std::isfinite( value ) &&
                   std::abs( value ) <= std::numeric_limits<float>::max();
        };

        std::set<std::string> tool_quality_ids;
        for( const tool_quality_registration &entry : pimpl_->tool_qualities ) {
            const tool_quality_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "tool quality" );
            if( definition.name.empty() || !tool_quality_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "tool quality '" + definition.id +
                                          "' requires a name and one registration per transaction" );
            }
            for( const auto &[level, text] : definition.usages ) {
                if( level <= 0 || !native_int( level ) || text.empty() ) {
                    throw std::runtime_error( "tool quality '" + definition.id +
                                              "' has an invalid usage" );
                }
            }
            validate_operation( entry.operation, quality_id( definition.id ).is_valid(),
                                definition.id, "tool quality" );
        }

        std::set<std::string> skill_display_ids;
        for( const skill_display_registration &entry : pimpl_->skill_displays ) {
            const skill_display_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "skill display category" );
            if( definition.label.empty() || !skill_display_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "skill display category '" + definition.id +
                                          "' requires a label and one registration per transaction" );
            }
            validate_operation( entry.operation, skill_displayType_id( definition.id ).is_valid(),
                                definition.id, "skill display category" );
        }

        std::set<std::string> skill_ids;
        for( const skill_registration &entry : pimpl_->skills ) {
            const skill_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "skill" );
            if( definition.name.empty() || definition.description.empty() ||
                !skill_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "skill '" + definition.id +
                                          "' requires name, description, and one registration per transaction" );
            }
            if( !native_int( definition.sort_rank ) || !native_nonnegative_int( definition.attack_min_time ) ||
                !native_nonnegative_int( definition.attack_base_time ) ||
                !native_nonnegative_int( definition.attack_reduction_per_level ) ||
                definition.attack_base_time < definition.attack_min_time ||
                !native_int( definition.companion_combat_rank_factor ) ||
                !native_int( definition.companion_survival_rank_factor ) ||
                !native_int( definition.companion_industry_rank_factor ) ) {
                throw std::runtime_error( "skill '" + definition.id +
                                          "' has values outside the native range" );
            }
            if( definition.tags.count( "contextual_skill" ) == 0 &&
                skill_display_ids.count( definition.display_category ) == 0 &&
                !skill_displayType_id( definition.display_category ).is_valid() ) {
                throw std::runtime_error( "skill '" + definition.id +
                                          "' references unknown display category '" +
                                          definition.display_category + "'" );
            }
            for( const auto &[id, weight] : definition.companion_practice ) {
                if( id.empty() || !native_int( weight ) ) {
                    throw std::runtime_error( "skill '" + definition.id +
                                              "' has an invalid companion practice" );
                }
            }
            validate_operation( entry.operation, skill_id( definition.id ).is_valid(),
                                definition.id, "skill" );
        }

        std::set<std::string> vitamin_ids;
        for( const vitamin_registration &entry : pimpl_->vitamins ) {
            const vitamin_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "vitamin" );
            if( definition.name.empty() || !vitamin_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "vitamin '" + definition.id +
                                          "' requires a name and one registration per transaction" );
            }
            if( definition.type != "vitamin" && definition.type != "toxin" &&
                definition.type != "drug" && definition.type != "counter" ) {
                throw std::runtime_error( "vitamin '" + definition.id +
                                          "' has unknown kind '" + definition.type + "'" );
            }
            if( !native_int( definition.minimum ) || !native_int( definition.maximum ) ||
                !native_int( definition.rate_turns ) ||
                ( definition.weight_micrograms &&
                  ( *definition.weight_micrograms <= 0 || !native_int( *definition.weight_micrograms ) ) ) ) {
                throw std::runtime_error( "vitamin '" + definition.id +
                                          "' bounds or rate are outside the native range" );
            }
            if( !definition.deficiency.empty() && !efftype_id( definition.deficiency ).is_valid() ) {
                throw std::runtime_error( "vitamin '" + definition.id +
                                          "' references unknown deficiency effect '" +
                                          definition.deficiency + "'" );
            }
            if( !definition.excess.empty() && !efftype_id( definition.excess ).is_valid() ) {
                throw std::runtime_error( "vitamin '" + definition.id +
                                          "' references unknown excess effect '" + definition.excess + "'" );
            }
            validate_operation( entry.operation, vitamin_id( definition.id ).is_valid(),
                                definition.id, "vitamin" );
        }
        for( const vitamin_registration &entry : pimpl_->vitamins ) {
            const vitamin_definition_data &definition = *entry.definition;
            for( const auto &[decay_id, rate] : definition.decays_into ) {
                if( decay_id.empty() || !native_int( rate ) ||
                    ( vitamin_ids.count( decay_id ) == 0 && !vitamin_id( decay_id ).is_valid() ) ) {
                    throw std::runtime_error( "vitamin '" + definition.id +
                                              "' decays into unknown vitamin '" + decay_id + "'" );
                }
            }
        }

        std::set<std::string> json_flag_ids;
        for( const json_flag_registration &entry : pimpl_->json_flags ) {
            const json_flag_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "JSON flag" );
            if( !json_flag_ids.insert( definition.id ).second ||
                !native_int( definition.taste_modifier ) ) {
                throw std::runtime_error( "JSON flag '" + definition.id +
                                          "' is registered more than once or has an invalid taste modifier" );
            }
            validate_operation( entry.operation, flag_id( definition.id ).is_valid(),
                                definition.id, "JSON flag" );
        }
        for( const json_flag_registration &entry : pimpl_->json_flags ) {
            const json_flag_definition_data &definition = *entry.definition;
            if( !definition.requires_flag.empty() &&
                json_flag_ids.count( definition.requires_flag ) == 0 &&
                !flag_id( definition.requires_flag ).is_valid() ) {
                throw std::runtime_error( "JSON flag '" + definition.id +
                                          "' requires unknown flag '" + definition.requires_flag + "'" );
            }
            for( const std::string &conflict : definition.conflicts ) {
                if( conflict.empty() || ( json_flag_ids.count( conflict ) == 0 &&
                                          !flag_id( conflict ).is_valid() ) ) {
                    throw std::runtime_error( "JSON flag '" + definition.id +
                                              "' conflicts with unknown flag '" + conflict + "'" );
                }
            }
        }

        std::set<std::string> math_function_ids;
        for( const math_function_registration &entry : pimpl_->math_functions ) {
            const math_function_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "math function" );
            if( !math_function_ids.insert( definition.id ).second || definition.num_args < 0 ||
                definition.num_args > 1024 || definition.expression.empty() ||
                definition.expression.size() > 65536 ||
                definition.expression.find( '\0' ) != std::string::npos ||
                get_all_diag_funcs().find( definition.id ) != get_all_diag_funcs().end() ) {
                throw std::runtime_error( "math function '" + definition.id +
                                          "' has invalid or duplicate definition data" );
            }
            validate_operation( entry.operation, jmath_func_id( definition.id ).is_valid(),
                                definition.id, "math function" );
        }

        std::set<std::string> damage_type_ids;
        for( const damage_type_registration &entry : pimpl_->damage_types ) {
            const damage_type_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "damage type" );
            if( definition.name.empty() || !damage_type_ids.insert( definition.id ).second ||
                !finite_native_float( definition.bash_conversion_factor ) ||
                definition.bash_conversion_factor < 0.0 ||
                !finite_native_float( definition.melee_crit_dmg_mult ) ||
                definition.melee_crit_dmg_mult < 0.0 ||
                !finite_native_float( definition.melee_crit_dmg_mult_per_skill ) ||
                definition.melee_crit_dmg_mult_per_skill < 0.0 ||
                !finite_native_float( definition.melee_crit_armor_mult ) ||
                !finite_native_float( definition.melee_crit_armor_penetration ) ||
                definition.melee_crit_armor_penetration < 0.0 ) {
                throw std::runtime_error( "damage type '" + definition.id +
                                          "' has invalid values or a duplicate registration" );
            }
            if( !definition.skill.empty() && skill_ids.count( definition.skill ) == 0 &&
                !skill_id( definition.skill ).is_valid() ) {
                throw std::runtime_error( "damage type '" + definition.id +
                                          "' references unknown skill '" + definition.skill + "'" );
            }
            if( !definition.on_hit_handler.empty() &&
                !runtime_has_handler( owner_runtime, definition.on_hit_handler ) ) {
                throw std::runtime_error( "damage type '" + definition.id +
                                          "' references missing on-hit handler '" +
                                          definition.on_hit_handler + "'" );
            }
            if( !definition.on_damage_handler.empty() &&
                !runtime_has_handler( owner_runtime, definition.on_damage_handler ) ) {
                throw std::runtime_error( "damage type '" + definition.id +
                                          "' references missing on-damage handler '" +
                                          definition.on_damage_handler + "'" );
            }
            validate_operation( entry.operation, damage_type_id( definition.id ).is_valid(),
                                definition.id, "damage type" );
        }
        for( const damage_type_registration &entry : pimpl_->damage_types ) {
            const damage_type_definition_data &definition = *entry.definition;
            if( !definition.derived_from.empty() &&
                damage_type_ids.count( definition.derived_from ) == 0 &&
                !damage_type_id( definition.derived_from ).is_valid() ) {
                throw std::runtime_error( "damage type '" + definition.id +
                                          "' derives from unknown damage type '" +
                                          definition.derived_from + "'" );
            }
        }

        std::set<std::string> declared_item_ids;
        for( const item_registration &entry : pimpl_->items ) {
            if( !entry.definition->is_abstract ) {
                declared_item_ids.insert( entry.definition->id );
            }
        }
        for( const auto &entry : pimpl_->item_migrations ) {
            const migration &native = entry->specification;
            require_valid_id( native.replace.str(), "item migration replacement" );
            for( const itype_id &id : entry->from ) {
                require_valid_id( id.str(), "item migration source" );
                if( id == native.replace ) {
                    throw std::runtime_error( "item migration cannot replace '" + id.str() + "' with itself" );
                }
            }
            for( const migration::content &carried : native.contents ) {
                require_valid_id( carried.id.str(), "item migration content" );
            }
        }
        std::set<std::string> declared_recipe_ids;
        for( const recipe_registration &entry : pimpl_->recipes ) {
            if( !entry.definition->uncraft ) {
                declared_recipe_ids.insert( entry.definition->id );
            }
        }

        std::set<std::string> material_ids;
        for( const material_registration &entry : pimpl_->materials ) {
            const material_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "material" );
            if( ( definition.copy_from.empty() && definition.name.empty() ) ||
                definition.chip_resistance.value_or( 0 ) < 0 || !native_int( definition.chip_resistance.value_or( 0 ) ) ||
                definition.breathability.value_or( 0 ) < 0 ||
                definition.breathability.value_or( 0 ) >= static_cast<std::int64_t>( breathability_rating::last ) ||
                definition.repair_difficulty.value_or( 10 ) < 0 || definition.repair_difficulty.value_or( 10 ) > MAX_SKILL ||
                !finite_native_float( definition.density.value_or( 1.0 ) ) || definition.density.value_or( 1.0 ) <= 0.0 ||
                !finite_native_float( definition.sheet_thickness.value_or( 0.0 ) ) || definition.sheet_thickness.value_or( 0.0 ) < 0.0 ||
                !finite_native_float( definition.specific_heat_liquid.value_or( 4.186 ) ) ||
                !finite_native_float( definition.specific_heat_solid.value_or( 2.108 ) ) ||
                !finite_native_float( definition.latent_heat.value_or( 334.0 ) ) ||
                !finite_native_float( definition.freezing_point.value_or( 0.0 ) ) ||
                !material_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "material '" + definition.id +
                                          "' has invalid values or a duplicate registration" );
            }
            if( definition.wind_resistance && ( *definition.wind_resistance < 0 ||
                                                *definition.wind_resistance > 100 ) ) {
                throw std::runtime_error( "material '" + definition.id +
                                          "' has invalid wind resistance" );
            }
            for( const authored_text &adjective : definition.damage_adjectives ) {
                if( definition.copy_from.empty() && adjective.empty() ) {
                    throw std::runtime_error( "material '" + definition.id +
                                              "' has an empty damage adjective" );
                }
            }
            for( const auto &[damage_id, amount] : definition.resistances ) {
                if( damage_type_ids.count( damage_id ) == 0 &&
                    !damage_type_id( damage_id ).is_valid() ) {
                    throw std::runtime_error( "material '" + definition.id +
                                              "' references unknown damage type '" + damage_id + "'" );
                }
                if( !finite_native_float( amount ) ) {
                    throw std::runtime_error( "material '" + definition.id +
                                              "' has an invalid resistance" );
                }
            }
            for( const auto &[vitamin_key, amount] : definition.vitamins ) {
                if( vitamin_ids.count( vitamin_key ) == 0 && !vitamin_id( vitamin_key ).is_valid() ) {
                    throw std::runtime_error( "material '" + definition.id +
                                              "' references unknown vitamin '" + vitamin_key + "'" );
                }
                if( !finite_native_float( amount ) ) {
                    throw std::runtime_error( "material '" + definition.id +
                                              "' has an invalid vitamin amount" );
                }
            }
            const auto known_item = [&declared_item_ids]( const std::string & id ) {
                return id.empty() || declared_item_ids.count( id ) != 0 ||
                       item::type_is_defined( itype_id( id ) );
            };
            if( !known_item( definition.salvaged_into ) ) {
                throw std::runtime_error( "material '" + definition.id +
                                          "' references an unknown salvage item" );
            }
            for( const std::string &rep : definition.repaired_with ) {
                if( !known_item( rep ) ) {
                    throw std::runtime_error( "material '" + definition.id +
                                              "' references an unknown repair item '" + rep + "'" );
                }
            }
            for( const auto &[product, efficiency] : definition.burn_products ) {
                if( !known_item( product ) || !finite_native_float( efficiency ) ) {
                    throw std::runtime_error( "material '" + definition.id +
                                              "' references an invalid burn product '" + product + "'" );
                }
            }
            for( const material_burn_definition &burn : definition.burn_data ) {
                if( burn.volume_ml_per_turn < 0 || !native_int( burn.volume_ml_per_turn ) ||
                    !finite_native_float( burn.fuel ) || !finite_native_float( burn.smoke ) ||
                    !finite_native_float( burn.burn ) ) {
                    throw std::runtime_error( "material '" + definition.id +
                                              "' has invalid burn data" );
                }
            }
            validate_operation( entry.operation, material_id( definition.id ).is_valid(),
                                definition.id, "material" );
        }

        std::set<std::string> proficiency_category_ids;
        for( const proficiency_category_registration &entry : pimpl_->proficiency_categories ) {
            const proficiency_category_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "proficiency category" );
            if( definition.name.empty() || definition.description.empty() ||
                !proficiency_category_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "proficiency category '" + definition.id +
                                          "' requires name, description, and one registration per transaction" );
            }
            validate_operation( entry.operation, proficiency_category_id( definition.id ).is_valid(),
                                definition.id, "proficiency category" );
        }
        std::set<std::string> proficiency_ids;
        static const std::set<std::string> proficiency_attributes = {
            "strength", "dexterity", "intelligence", "perception", "stamina"
        };
        for( const proficiency_registration &entry : pimpl_->proficiencies ) {
            const proficiency_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "proficiency" );
            if( definition.name.empty() || definition.description.empty() || definition.category.empty() ||
                definition.time_to_learn_turns <= 0 || !native_int( definition.time_to_learn_turns ) ||
                !finite_native_float( definition.time_multiplier ) || definition.time_multiplier < 0.0 ||
                !finite_native_float( definition.skill_penalty ) || definition.skill_penalty < 0.0 ||
                !finite_native_float( definition.weakpoint_bonus ) ||
                !finite_native_float( definition.weakpoint_penalty ) ||
                !proficiency_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "proficiency '" + definition.id +
                                          "' has invalid values or a duplicate registration" );
            }
            if( proficiency_category_ids.count( definition.category ) == 0 &&
                !proficiency_category_id( definition.category ).is_valid() ) {
                throw std::runtime_error( "proficiency '" + definition.id +
                                          "' references unknown category '" + definition.category + "'" );
            }
            for( const proficiency_bonus_definition &bonus : definition.bonuses ) {
                if( proficiency_attributes.count( bonus.attribute ) == 0 || bonus.category.empty() ||
                    !finite_native_float( bonus.value ) ) {
                    throw std::runtime_error( "proficiency '" + definition.id + "' has an invalid bonus" );
                }
            }
            validate_operation( entry.operation, proficiency_id( definition.id ).is_valid(),
                                definition.id, "proficiency" );
        }
        for( const proficiency_registration &entry : pimpl_->proficiencies ) {
            for( const std::string &required : entry.definition->required ) {
                if( proficiency_ids.count( required ) == 0 && !proficiency_id( required ).is_valid() ) {
                    throw std::runtime_error( "proficiency '" + entry.definition->id +
                                              "' requires unknown proficiency '" + required + "'" );
                }
            }
        }

        std::set<std::string> weapon_category_ids;
        for( const weapon_category_registration &entry : pimpl_->weapon_categories ) {
            const weapon_category_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "weapon category" );
            if( definition.name.empty() || !weapon_category_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "weapon category '" + definition.id +
                                          "' requires a name and one registration per transaction" );
            }
            for( const std::string &proficiency : definition.proficiencies ) {
                if( proficiency_ids.count( proficiency ) == 0 && !proficiency_id( proficiency ).is_valid() ) {
                    throw std::runtime_error( "weapon category '" + definition.id +
                                              "' references unknown proficiency '" + proficiency + "'" );
                }
            }
            validate_operation( entry.operation, weapon_category_id( definition.id ).is_valid(),
                                definition.id, "weapon category" );
        }

        std::set<std::string> item_category_ids;
        for( const item_category_registration &entry : pimpl_->item_categories ) {
            const item_category_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "item category" );
            if( definition.header.empty() || definition.noun.empty() || !native_int( definition.sort_rank ) ||
                !finite_native_float( definition.spawn_rate ) || definition.spawn_rate < 0.0 ||
                !item_category_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "item category '" + definition.id +
                                          "' has invalid values or a duplicate registration" );
            }
            for( const item_category_priority_definition &priority : definition.priority_zones ) {
                if( priority.zone.empty() || ( !priority.filthy && priority.flags.empty() ) ) {
                    throw std::runtime_error( "item category '" + definition.id +
                                              "' has an unusable priority-zone rule" );
                }
                for( const std::string &flag : priority.flags ) {
                    if( json_flag_ids.count( flag ) == 0 && !flag_id( flag ).is_valid() ) {
                        throw std::runtime_error( "item category '" + definition.id +
                                                  "' references unknown flag '" + flag + "'" );
                    }
                }
            }
            validate_operation( entry.operation, item_category_id( definition.id ).is_valid(),
                                definition.id, "item category" );
        }

        std::set<std::string> crafting_category_ids;
        for( const crafting_category_registration &entry : pimpl_->crafting_categories ) {
            const crafting_category_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "recipe category" );
            if( definition.id.rfind( "CC_", 0 ) != 0 || definition.subcategories.empty() ||
                !crafting_category_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "recipe category '" + definition.id +
                                          "' requires a CC_ id, subcategories, and one registration per transaction" );
            }
            const std::string prefix = "CSC_" + definition.id.substr( 3 ) + "_";
            std::set<std::string> subcategory_ids;
            for( const std::string &subcategory : definition.subcategories ) {
                if( ( subcategory != "CSC_ALL" && subcategory.rfind( prefix, 0 ) != 0 ) ||
                    !subcategory_ids.insert( subcategory ).second ) {
                    throw std::runtime_error( "recipe category '" + definition.id +
                                              "' has an invalid or duplicate subcategory '" + subcategory + "'" );
                }
            }
            validate_operation( entry.operation, crafting_category_id( definition.id ).is_valid(),
                                definition.id, "recipe category" );
        }

        std::set<std::string> ammunition_type_ids;
        for( const ammunition_type_registration &entry : pimpl_->ammunition_types ) {
            const ammunition_type_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "ammunition type" );
            if( definition.name.empty() || !ammunition_type_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "ammunition type '" + definition.id +
                                          "' requires a name and one registration per transaction" );
            }
            validate_operation( entry.operation, ammotype( definition.id ).is_valid(),
                                definition.id, "ammunition type" );
        }

        std::set<std::string> requirement_ids;
        std::set<std::string> exclusive_requirement_ids;
        for( const requirement_registration &entry : pimpl_->requirements ) {
            const requirement_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "requirement" );
            if( !definition.merge && definition.components.empty() && definition.tools.empty() &&
                definition.qualities.empty() ) {
                throw std::runtime_error( "requirement '" + definition.id + "' must contain native requirements" );
            }
            const bool first = requirement_ids.insert( definition.id ).second;
            if( !first && ( !definition.merge || exclusive_requirement_ids.count( definition.id ) != 0 ) ) {
                throw std::runtime_error( "requirement '" + definition.id +
                                          "' is registered more than once per transaction" );
            }
            if( !definition.merge ) {
                exclusive_requirement_ids.insert( definition.id );
            }
        }
        const auto validate_requirement_groups = [&]( const std::string & id,
                const std::vector<std::vector<component_requirement>> &groups,
        const char *kind, const bool tools ) {
            for( const std::vector<component_requirement> &group : groups ) {
                if( group.empty() ) {
                    throw std::runtime_error( "requirement '" + id +
                                              "' has an empty alternative group" );
                }
                for( const component_requirement &component : group ) {
                    if( component.id.empty() || ( tools ? component.count == 0 : component.count <= 0 ) ||
                        !native_int( component.count ) ) {
                        throw std::runtime_error( "requirement '" + id + "' has an invalid " + kind );
                    }
                    // Some native definitions are still waiting for copy-from resolution during preparation.
                    if( !check_engine_state ) {
                        continue;
                    }
                    const itype_id item_id( component.id );
                    const bool valid = component.requirement ?
                                       requirement_ids.count( component.id ) != 0 ||
                                       requirement_data::registry().count( requirement_id( component.id ) ) != 0 :
                                       declared_item_ids.count( component.id ) != 0 ||
                                       item::type_is_defined( item_id ) || item_controller->has_template_migration( item_id );
                    if( !valid ) {
                        throw std::runtime_error( "requirement '" + id + "' references unknown " +
                                                  ( component.requirement ? std::string( "requirement" ) : kind ) +
                                                  " '" + component.id + "'" );
                    }
                }
            }
        };
        const auto validate_requirement = [&]( const std::string &id,
        const requirement_definition_data &groups ) {
            validate_requirement_groups( id, groups.components, "component", false );
            validate_requirement_groups( id, groups.tools, "tool", true );
            for( const std::vector<quality_requirement_definition> &group : groups.qualities ) {
                if( group.empty() ) {
                    throw std::runtime_error( "requirement '" + id + "' has an empty quality alternative group" );
                }
                for( const quality_requirement_definition &quality : group ) {
                    if( quality.id.empty() || quality.level <= 0 || !native_int( quality.level ) ||
                        quality.count <= 0 || !native_int( quality.count ) ||
                        ( check_engine_state && tool_quality_ids.count( quality.id ) == 0 &&
                          !quality_id( quality.id ).is_valid() ) ) {
                        throw std::runtime_error( "requirement '" + id + "' references an invalid quality" );
                    }
                }
            }
        };
        for( const requirement_registration &entry : pimpl_->requirements ) {
            const requirement_definition_data &definition = *entry.definition;
            validate_requirement( definition.id, definition );
            if( definition.alternatives ) {
                validate_requirement( definition.id, *definition.alternatives );
            }
            if( !definition.merge ) {
                validate_operation( entry.operation,
                                    requirement_data::registry().count( requirement_id( definition.id ) ) != 0,
                                    definition.id, "requirement" );
            }
        }

        std::set<std::string> recipe_group_ids;
        static const std::set<std::string> recipe_group_match_types = {
            "EXACT", "TYPE", "SUBTYPE", "PREFIX", "CONTAINS"
        };
        for( const recipe_group_registration &entry : pimpl_->recipe_groups ) {
            const recipe_group_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "recipe group" );
            if( definition.building_type.empty() || !recipe_group_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "recipe group '" + definition.id +
                                          "' requires a building type and one registration per transaction" );
            }
            std::set<std::string> group_recipe_ids;
            for( const recipe_group_recipe_data &recipe : definition.recipes ) {
                if( recipe.id.empty() || recipe.description.empty() ||
                    !group_recipe_ids.insert( recipe.id ).second ) {
                    throw std::runtime_error( "recipe group '" + definition.id +
                                              "' has an invalid or duplicate recipe entry" );
                }
                if( declared_recipe_ids.count( recipe.id ) == 0 && !recipe_id( recipe.id ).is_valid() ) {
                    throw std::runtime_error( "recipe group '" + definition.id +
                                              "' references unknown recipe '" + recipe.id + "'" );
                }
                for( const recipe_group_terrain_data &terrain : recipe.terrains ) {
                    std::string match_type = terrain.match_type;
                    std::transform( match_type.begin(), match_type.end(), match_type.begin(),
                    []( const unsigned char ch ) {
                        return static_cast<char>( std::toupper( ch ) );
                    } );
                    if( terrain.overmap_terrain.empty() || recipe_group_match_types.count( match_type ) == 0 ) {
                        throw std::runtime_error( "recipe group '" + definition.id +
                                                  "' has an invalid overmap-terrain matcher" );
                    }
                    for( const auto &[parameter, values] : terrain.parameters ) {
                        if( parameter.empty() || values.empty() || values.count( "" ) != 0 ) {
                            throw std::runtime_error( "recipe group '" + definition.id +
                                                      "' has an invalid terrain parameter" );
                        }
                    }
                }
            }
            validate_operation( entry.operation, detail::recipe_group_exists( definition.id ),
                                definition.id, "recipe group" );
        }

        std::set<std::string> scent_type_ids;
        for( const scent_type_registration &entry : pimpl_->scent_types ) {
            const scent_type_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "scent type" );
            if( definition.receptive_species.empty() || !scent_type_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "scent type '" + definition.id +
                                          "' requires receptive species and one registration per transaction" );
            }
            for( const std::string &species : definition.receptive_species ) {
                if( !species_id( species ).is_valid() ) {
                    throw std::runtime_error( "scent type '" + definition.id +
                                              "' references unknown species '" + species + "'" );
                }
            }
            validate_operation( entry.operation, scenttype_id( definition.id ).is_valid(),
                                definition.id, "scent type" );
        }

        std::set<std::string> butchery_requirement_ids;
        for( const butchery_requirement_registration &entry : pimpl_->butchery_requirement_entries ) {
            const butchery_requirement_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "butchery requirement" );
            if( definition.entries.empty() || !butchery_requirement_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "butchery requirement '" + definition.id +
                                          "' requires entries and one registration per transaction" );
            }
            for( const auto &requirement : definition.entries ) {
                if( !finite_native_float( requirement.speed ) || requirement.speed < 0.0 ||
                    !platform_creature_size( requirement.size ) || !platform_butcher_type( requirement.butcher ) ||
                    !requirement_id( requirement.requirement ).is_valid() ) {
                    throw std::runtime_error( "butchery requirement '" + definition.id +
                                              "' has an invalid entry" );
                }
            }
            validate_operation( entry.operation,
                                string_id<butchery_requirements>( definition.id ).is_valid(),
                                definition.id, "butchery requirement" );
        }

        std::set<std::string> item_action_ids;
        for( const item_action_registration &entry : pimpl_->item_actions ) {
            const item_action_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "item action" );
            if( definition.name.empty() || !item_action_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "item action '" + definition.id +
                                          "' requires a name and one registration per transaction" );
            }
            validate_operation( entry.operation,
                                detail::item_action_registry_find( definition.id ) != nullptr,
                                definition.id, "item action" );
        }

        std::set<std::string> item_group_ids;
        std::map<std::string, std::vector<std::string>> item_group_children;
        for( const item_group_registration &entry : pimpl_->item_groups ) {
            const item_group_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "item group" );
            if( !item_group_ids.insert( definition.id ).second ||
                ( definition.kind != "collection" && definition.kind != "distribution" ) ||
                definition.with_ammo < 0 || definition.with_ammo > 100 ||
                definition.with_magazine < 0 || definition.with_magazine > 100 ) {
                throw std::runtime_error( "item group '" + definition.id +
                                          "' has invalid kind, chances, or duplicate registration" );
            }
            if( ( definition.container && ( definition.container->empty() ||
                                            ( *definition.container != "null" && check_engine_state &&
                                              declared_item_ids.count( *definition.container ) == 0 &&
                                              !item::type_is_defined( itype_id( *definition.container ) ) ) ) ) ||
                ( definition.container_variant && !definition.container ) ||
                ( definition.overflow != Item_spawn_data::overflow_behaviour::none &&
                  !definition.container ) ) {
                throw std::runtime_error( "item group '" + definition.id + "' has an invalid container" );
            }
            item_group_children.emplace( definition.id, std::vector<std::string>() );
            validate_operation( entry.operation,
                                item_group::group_is_defined( item_group_id( definition.id ) ),
                                definition.id, "item group" );
            if( entry.operation == definition_operation::extend ) {
                if( definition.with_ammo != 0 || definition.with_magazine != 0 ||
                    definition.container || !definition.sealed ) {
                    throw std::runtime_error( "item group extension '" + definition.id +
                                              "' may only append entries" );
                }
                if( check_engine_state ) {
                    const auto existing = item_controller->m_template_groups.find(
                                              item_group_id( definition.id ) );
                    const Item_group *const native = existing == item_controller->m_template_groups.end() ?
                                                     nullptr : dynamic_cast<const Item_group *>( existing->second.get() );
                    const Item_group::Type expected = definition.kind == "collection" ?
                                                      Item_group::G_COLLECTION : Item_group::G_DISTRIBUTION;
                    if( native == nullptr || native->type != expected ) {
                        throw std::runtime_error( "item group extension '" + definition.id +
                                                  "' must match the existing group kind" );
                    }
                }
            }
        }
        const auto validate_group_reference = [&]( const std::string &id, const std::string &target ) {
            if( target == id || ( item_group_ids.count( target ) == 0 && check_engine_state &&
                                  !item_group::group_is_defined( item_group_id( target ) ) ) ) {
                throw std::runtime_error( "item group '" + id +
                                          "' references unknown or recursive group '" + target + "'" );
            }
            if( item_group_ids.count( target ) != 0 ) {
                item_group_children[id].push_back( target );
            }
        };
        const auto validate_group_item = [&]( const std::string &id, const std::string &target,
        const std::string_view field, const bool migrate ) {
            const itype_id item_id( target );
            if( target.empty() || ( target != "null" && declared_item_ids.count( target ) == 0 &&
                                    check_engine_state &&
                                    !item::type_is_defined( item_id ) &&
                                    ( !migrate || !item::type_is_defined( item_controller->migrate_id( item_id ) ) ) ) ) {
                throw std::runtime_error( "item group '" + id + "' references an unknown " +
                                          std::string( field ) + " item '" + target + "'" );
            }
        };
        const auto validate_spawn_reference = [&]( const std::string &id,
        const item_group_reference &reference, const std::string_view field ) {
            if( reference.group ) {
                validate_group_reference( id, reference.id );
            } else {
                validate_group_item( id, reference.id, field, true );
            }
        };
        const auto validate_group_entries = [&]( const auto &self, const std::string &id,
        const std::vector<item_group_entry_definition_data> &entries, bool collection ) -> void {
            for( const item_group_entry_definition_data &group_entry : entries ) {
                const bool probability_valid = group_entry.probability > 0 &&
                                               native_int( group_entry.probability ) &&
                                               ( !collection || group_entry.probability <= 100 );
                if( !probability_valid ) {
                    throw std::runtime_error( "item group '" + id + "' has an invalid probability" );
                }
                if( group_entry.subgroup ) {
                    self( self, id, group_entry.children, *group_entry.subgroup == Item_group::G_COLLECTION );
                    continue;
                }
                if( group_entry.id.empty() || group_entry.variant.size() > 256 ||
                    group_entry.variant.find( '\0' ) != std::string::npos ||
                    !native_int( group_entry.count_min ) || !native_int( group_entry.count_max ) ||
                    group_entry.charges_min < -1 || group_entry.charges_max < -1 ||
                    !native_int( group_entry.charges_min ) || !native_int( group_entry.charges_max ) ||
                    ( group_entry.wrapper_variant && !group_entry.wrapper ) ) {
                    throw std::runtime_error( "item group '" + id + "' contains an invalid entry" );
                }
                if( group_entry.wrapper ) {
                    validate_group_item( id, *group_entry.wrapper, "wrapper", false );
                }
                if( group_entry.container ) {
                    validate_spawn_reference( id, *group_entry.container, "container" );
                }
                if( group_entry.ammo ) {
                    validate_spawn_reference( id, *group_entry.ammo, "ammo" );
                }
                for( const std::string &component : group_entry.components ) {
                    validate_group_item( id, component, "component", false );
                }
                if( group_entry.artifact && ( group_entry.artifact->id.is_empty() ||
                                              ( check_engine_state && !group_entry.artifact->id.is_valid() ) ) ) {
                    throw std::runtime_error( "item group '" + id + "' references an unknown relic preset" );
                }
                if( group_entry.group ) {
                    validate_group_reference( id, group_entry.id );
                }
                for( const item_group_reference &child : group_entry.contents ) {
                    validate_spawn_reference( id, child, "contents" );
                }
            }
        };
        for( const auto &registration : pimpl_->item_groups ) {
            const auto &definition = *registration.definition;
            validate_group_entries( validate_group_entries, definition.id, definition.entries,
                                    definition.kind == "collection" );
        }
        std::set<std::string> visiting_item_groups;
        std::set<std::string> visited_item_groups;
        std::function<void( const std::string & )> visit_item_group;
        visit_item_group = [&]( const std::string & id ) {
            if( visited_item_groups.count( id ) != 0 ) {
                return;
            }
            if( !visiting_item_groups.insert( id ).second ) {
                throw std::runtime_error( "item-group graph contains a cycle at '" + id + "'" );
            }
            for( const std::string &child : item_group_children.at( id ) ) {
                visit_item_group( child );
            }
            visiting_item_groups.erase( id );
            visited_item_groups.insert( id );
        };
        for( const auto &[id, children] : item_group_children ) {
            static_cast<void>( children );
            visit_item_group( id );
        }

        std::set<std::string> ammo_effect_ids;
        const auto defines_explosion_light = [&context]( const std::string & id ) {
            return id.empty() || ( context.defines_explosion_light && context.defines_explosion_light( id ) ) ||
                   explosion_light_str_id( id ).is_valid();
        };
        for( const ammo_effect_registration &entry : pimpl_->ammo_effects ) {
            const ammo_effect_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "ammo effect" );
            const auto percent = []( const std::int64_t value ) {
                return value >= 0 && value <= 100;
            };
            if( !ammo_effect_ids.insert( definition.id ).second || !percent( definition.trigger_chance ) ) {
                throw std::runtime_error( "ammo effect '" + definition.id +
                                          "' has a duplicate id or invalid trigger chance" );
            }
            const auto validate_field = [&]( const ammo_field_definition_data & field, const bool trail ) {
                if( field.field.empty() || !native_nonnegative_int( field.intensity_min ) ||
                    !native_nonnegative_int( field.intensity_max ) || field.intensity_max < field.intensity_min ||
                    !percent( field.chance ) || ( !trail && ( !native_nonnegative_int( field.radius ) ||
                                                  !native_nonnegative_int( field.height ) || !native_nonnegative_int( field.footprint ) ) ) ||
                    ( check_engine_state && !field_type_str_id( field.field ).is_valid() ) ) {
                    throw std::runtime_error( "ammo effect '" + definition.id + "' has an invalid " +
                                              ( trail ? "trail" : "field burst" ) );
                }
            };
            for( const ammo_field_definition_data &field : definition.field_bursts ) {
                validate_field( field, false );
            }
            for( const ammo_field_definition_data &field : definition.trails ) {
                validate_field( field, true );
            }
            const auto validate_character_effect = [&]( const ammo_character_effect_definition_data & effect,
            const bool area ) {
                if( effect.effect.empty() || effect.duration_turns <= 0 || !native_int( effect.duration_turns ) ||
                    effect.intensity_min <= 0 || !native_nonnegative_int( effect.intensity_max ) ||
                    effect.intensity_max < effect.intensity_min || ( area && ( !percent( effect.chance ) ||
                            !native_nonnegative_int( effect.radius ) || effect.hits_min <= 0 ||
                            effect.hits_max < effect.hits_min || !native_nonnegative_int( effect.hits_max ) ) ) ||
                    ( check_engine_state && !efftype_id( effect.effect ).is_valid() ) ) {
                    throw std::runtime_error( "ammo effect '" + definition.id + "' has an invalid " +
                                              ( area ? "area effect" : "on-hit effect" ) );
                }
            };
            for( const ammo_character_effect_definition_data &effect : definition.on_hit_effects ) {
                validate_character_effect( effect, false );
            }
            for( const ammo_character_effect_definition_data &effect : definition.area_effects ) {
                validate_character_effect( effect, true );
            }
            if( definition.has_explosion && ( !finite_native_float( definition.explosion_power ) ||
                                              definition.explosion_power < 0.0 || !finite_native_float( definition.explosion_distance_factor ) ||
                                              definition.explosion_distance_factor < 0.0 || definition.explosion_distance_factor > 1.0 ||
                                              !native_nonnegative_int( definition.explosion_max_noise ) ||
                                              !native_nonnegative_int( definition.casing_mass ) ||
                                              !finite_native_float( definition.fragment_mass ) ||
                                              definition.fragment_mass <= 0.0 || !percent( definition.fragment_recovery ) ||
                                              ( check_engine_state && !defines_explosion_light( definition.explosion_light ) ) ||
                                              ( check_engine_state && definition.fragment_drop != "null" &&
                                                declared_item_ids.count( definition.fragment_drop ) == 0 &&
                                                !item::type_is_defined( itype_id( definition.fragment_drop ) ) ) ) ) {
                throw std::runtime_error( "ammo effect '" + definition.id +
                                          "' has invalid explosion or shrapnel values" );
            }
            if( definition.has_shrapnel && !definition.has_explosion ) {
                throw std::runtime_error( "ammo effect '" + definition.id +
                                          "' attaches shrapnel without an explosion" );
            }
            for( const ammo_spell_definition_data &spell : definition.spells ) {
                if( spell.spell.empty() || spell.level < 0 || !native_int( spell.level ) ||
                    ( check_engine_state && !spell_id( spell.spell ).is_valid() ) ) {
                    throw std::runtime_error( "ammo effect '" + definition.id + "' has an invalid spell" );
                }
            }
            if( !definition.impact_handler.empty() &&
                !runtime_has_handler( owner_runtime, definition.impact_handler ) ) {
                throw std::runtime_error( "ammo effect '" + definition.id +
                                          "' references missing impact handler '" + definition.impact_handler + "'" );
            }
            validate_operation( entry.operation, ammo_effect_str_id( definition.id ).is_valid(),
                                definition.id, "ammo effect" );
        }

        std::vector<std::size_t> item_order;
        std::string inheritance_error;
        if( !detail::resolve_platform_inheritance_order( pimpl_->items,
        []( const item_registration & entry ) {
        return entry.definition->id;
    },
    []( const item_registration & entry ) {
        return entry.definition->copy_from;
    },
    [check_engine_state]( const std::string & id ) {
        if( !check_engine_state ) {
                return true;
            }
            const generic_factory<itype> &factory = item_controller->get_generic_factory();
            return factory.is_valid( itype_id( id ) ) ||
                   factory.find_abstract( id ) != nullptr;
        }, item_order, inheritance_error, "item" ) ) {
            throw std::runtime_error( inheritance_error );
        }
        for( const std::size_t index : item_order ) {
            const item_registration &entry = pimpl_->items[index];
            const item_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "item" );
            if( definition.copy_from.empty() && ( definition.name.empty() || definition.symbol.empty() ) ) {
                throw std::runtime_error( "item '" + definition.id + "' requires a name and symbol" );
            }
            if( definition.has_color &&
                color_from_string( definition.color, report_color_error::no ) == c_unset ) {
                throw std::runtime_error( "item '" + definition.id + "' has an invalid color" );
            }
            if( definition.melee_to_hit && !native_int( *definition.melee_to_hit ) ) {
                throw std::runtime_error( "item '" + definition.id + "' has invalid melee accuracy" );
            }
            if( ( definition.stack_size && ( *definition.stack_size < 1 ||
                                             !native_int( *definition.stack_size ) ) ) ||
                ( definition.light && ( *definition.light < 0 ||
                                        *definition.light > std::numeric_limits<unsigned>::max() ) ) ||
                ( definition.max_worn && !native_int( *definition.max_worn ) ) ||
                ( definition.insulation && !finite_native_float( *definition.insulation ) ) ) {
                throw std::runtime_error( "item '" + definition.id + "' has invalid item properties" );
            }
            if( definition.reveal_map ) {
                const auto &reveal = *definition.reveal_map;
                if( !native_int( reveal.radius ) ) {
                    throw std::runtime_error( "item '" + definition.id + "' has invalid map reveal radius" );
                }
                for( const auto &terrain : reveal.terrains ) {
                    require_valid_id( terrain.first, "map reveal terrain" );
                }
            }
            if( definition.variants ) {
                for( const auto &variant : *definition.variants ) {
                    require_valid_id( variant.id, "item variant" );
                    if( variant.weight < 0 || !native_int( variant.weight ) ||
                        ( variant.color && color_from_string( *variant.color, report_color_error::no ) == c_unset ) ) {
                        throw std::runtime_error( "item '" + definition.id + "' has an invalid variant '" +
                                                  variant.id + "'" );
                    }
                }
            }
            std::int64_t material_portions = 0;
            std::map<std::string, std::int64_t> portions_by_material;
            for( const material_part &material : definition.materials ) {
                if( material_ids.count( material.id ) == 0 && !material_id( material.id ).is_valid() ) {
                    throw std::runtime_error( "item '" + definition.id +
                                              "' references unknown material '" + material.id + "'" );
                }
                material_portions += material.portions;
                portions_by_material[material.id] += material.portions;
                if( material_portions > std::numeric_limits<int>::max() ||
                    portions_by_material[material.id] > std::numeric_limits<int>::max() ) {
                    throw std::runtime_error( "item '" + definition.id + "' has too many material portions" );
                }
            }
            for( const auto &[original, replacement] : definition.material_replacements ) {
                for( const material_id &id : { original, replacement } ) {
                    if( material_ids.count( id.str() ) == 0 && !id.is_valid() ) {
                        throw std::runtime_error( "item '" + definition.id +
                                                  "' replaces an unknown material '" + id.str() + "'" );
                    }
                }
            }
            for( const auto *adjustment : { &definition.melee_factors, &definition.melee_bonuses } ) {
                if( *adjustment ) {
                    for( const auto &entry : ( *adjustment )->damage_map ) {
                        const damage_type_id &id = entry.first;
                        if( damage_type_ids.count( id.str() ) == 0 && !id.is_valid() &&
                            id.str() != "all" && id.str() != "physical" && id.str() != "non_physical" ) {
                            throw std::runtime_error( "item '" + definition.id +
                                                      "' adjusts an unknown damage type '" + id.str() + "'" );
                        }
                    }
                }
            }
            for( const quality_level &quality : definition.qualities ) {
                if( tool_quality_ids.count( quality.id ) == 0 && !quality_id( quality.id ).is_valid() ) {
                    throw std::runtime_error( "item '" + definition.id +
                                              "' references unknown quality '" + quality.id + "'" );
                }
                if( !native_int( quality.level ) ) {
                    throw std::runtime_error( "item '" + definition.id + "' has an invalid quality level" );
                }
            }
            if( definition.charged_qualities ) {
                std::set<std::string> ids;
                for( const quality_level &quality : *definition.charged_qualities ) {
                    if( !ids.insert( quality.id ).second ||
                        ( tool_quality_ids.count( quality.id ) == 0 && !quality_id( quality.id ).is_valid() ) ) {
                        throw std::runtime_error( "item '" + definition.id +
                                                  "' has a duplicate or unknown charged quality '" +
                                                  quality.id + "'" );
                    }
                }
            }
            for( const std::string &flag : definition.flags ) {
                if( check_engine_state && json_flag_ids.count( flag ) == 0 && !flag_id( flag ).is_valid() ) {
                    throw std::runtime_error( "item '" + definition.id +
                                              "' references unknown flag '" + flag + "'" );
                }
            }
            for( const auto &[damage, amount] : definition.melee_damage ) {
                if( damage_type_ids.count( damage ) == 0 && !damage_type_id( damage ).is_valid() ) {
                    throw std::runtime_error( "item '" + definition.id +
                                              "' references unknown damage type '" + damage + "'" );
                }
                if( !finite_native_float( amount ) ) {
                    throw std::runtime_error( "item '" + definition.id + "' has invalid melee damage" );
                }
            }
            if( definition.ammunition ) {
                const item_definition_data::ammunition_data &ammo = *definition.ammunition;
                if( ammo.type.empty() ||
                    ( ammunition_type_ids.count( ammo.type ) == 0 && !ammotype( ammo.type ).is_valid() ) ||
                    ( ammo.count && ( *ammo.count < 1 || !native_int( *ammo.count ) ) ) ||
                    ( ammo.stack_size && ( *ammo.stack_size < 1 || !native_int( *ammo.stack_size ) ) ) ) {
                    throw std::runtime_error( "item '" + definition.id + "' has invalid ammunition values" );
                }
            }
            if( definition.tool ) {
                const auto &tool = *definition.tool;
                if( tool.ammo_types ) {
                    for( const std::string &ammo : *tool.ammo_types ) {
                        if( ammo.empty() || ( ammunition_type_ids.count( ammo ) == 0 && !ammotype( ammo ).is_valid() ) ) {
                            throw std::runtime_error( "item '" + definition.id + "' references unknown tool ammo '" + ammo + "'" );
                        }
                    }
                }
            }
            for( const auto &[ammo, capacity] : definition.magazine_ammo ) {
                if( ammo.empty() || capacity <= 0 || !native_int( capacity ) ||
                    ( ammunition_type_ids.count( ammo ) == 0 && !ammotype( ammo ).is_valid() ) ) {
                    throw std::runtime_error( "item '" + definition.id + "' has invalid magazine ammo" );
                }
            }
            for( const auto &[ammo, capacity] : definition.ammo_pocket ) {
                if( ammunition_type_ids.count( ammo ) == 0 && !ammotype( ammo ).is_valid() ) {
                    throw std::runtime_error( "item '" + definition.id + "' references unknown pocket ammo '" + ammo + "'" );
                }
            }
            if( definition.armor &&
                ( ( definition.armor->warmth && !native_int( *definition.armor->warmth ) ) ||
                  ( definition.armor->max_worn && !native_int( *definition.armor->max_worn ) ) ) ) {
                throw std::runtime_error( "item '" + definition.id + "' has invalid armor values" );
            }
            for( const auto &authored : definition.pockets ) {
                const pocket_data &pocket = authored.native;
                for( const auto &[ammo, capacity] : pocket.ammo_restriction ) {
                    if( ammunition_type_ids.count( ammo.str() ) == 0 && !ammo.is_valid() ) {
                        throw std::runtime_error( "item '" + definition.id +
                                                  "' references unknown pocket ammo '" + ammo.str() + "'" );
                    }
                }
                if( check_engine_state && !pocket.default_magazine.is_null() &&
                    !pocket.default_magazine.is_empty() &&
                    declared_item_ids.count( pocket.default_magazine.str() ) == 0 &&
                    !item::type_is_defined( pocket.default_magazine ) ) {
                    throw std::runtime_error( "item '" + definition.id + "' references an unknown default magazine" );
                }
                for( const material_id &material : pocket.material_restriction ) {
                    if( material_ids.count( material.str() ) == 0 && !material.is_valid() ) {
                        throw std::runtime_error( "item '" + definition.id +
                                                  "' has an unknown container pocket material '" +
                                                  material.str() + "'" );
                    }
                }
                for( const flag_id &flag : pocket.get_flag_restrictions() ) {
                    if( flag.is_null() || flag.str().empty() ||
                        ( check_engine_state && json_flag_ids.count( flag.str() ) == 0 && !flag.is_valid() ) ) {
                        throw std::runtime_error( "item '" + definition.id +
                                                  "' has an unknown container pocket flag '" + flag.str() + "'" );
                    }
                }
                for( const itype_id &item_id : pocket.item_id_restriction ) {
                    if( item_id.is_null() || item_id.str().empty() ||
                        ( check_engine_state && declared_item_ids.count( item_id.str() ) == 0 &&
                          !item::type_is_defined( item_id ) ) ) {
                        throw std::runtime_error( "item '" + definition.id +
                                                  "' has an unknown container pocket item '" + item_id.str() + "'" );
                    }
                }
            }
            for( const auto &portion : definition.armor_portions ) {
                if( !native_int( portion.encumbrance ) || !native_int( portion.coverage ) ||
                    !finite_native_float( portion.material_thickness ) || portion.material_thickness < 0.0 ||
                    !native_int( portion.environmental_protection ) ) {
                    throw std::runtime_error( "item '" + definition.id + "' has invalid armor portion values" );
                }
                for( const std::string &part : portion.covers ) {
                    if( part.empty() || ( check_engine_state && !bodypart_str_id( part ).is_valid() ) ) {
                        throw std::runtime_error( "item '" + definition.id + "' references unknown body part '" + part + "'" );
                    }
                }
                for( const std::string &part : portion.sub_parts ) {
                    if( part.empty() || ( check_engine_state && !sub_bodypart_str_id( part ).is_valid() ) ) {
                        throw std::runtime_error( "item '" + definition.id + "' references unknown body subpart '" + part + "'" );
                    }
                }
                for( const std::string &material : portion.materials ) {
                    if( material_ids.count( material ) == 0 && !material_id( material ).is_valid() ) {
                        throw std::runtime_error( "item '" + definition.id +
                                                  "' references unknown armor material '" + material + "'" );
                    }
                }
            }
            if( !definition.deploy_furniture.empty() && check_engine_state &&
                !( context.defines_furniture && context.defines_furniture( definition.deploy_furniture ) ) &&
                !furn_str_id( definition.deploy_furniture ).is_valid() ) {
                throw std::runtime_error( "item '" + definition.id + "' deploys unknown furniture '" +
                                          definition.deploy_furniture + "'" );
            }
            if( definition.activation ) {
                const auto &activation = *definition.activation;
                if( activation.move_cost < 0 || !native_int( activation.move_cost ) ) {
                    throw std::runtime_error( "item '" + definition.id + "' has an invalid activation cost" );
                }
                for( const auto &effect : activation.effects ) {
                    if( effect.id.empty() || effect.duration_turns < 0 || !native_int( effect.duration_turns ) ||
                        effect.intensity < 0 || !native_int( effect.intensity ) ) {
                        throw std::runtime_error( "item '" + definition.id + "' has invalid activation effect values" );
                    }
                }
            }
            if( definition.has_magazine_capacity &&
                ( definition.magazine_capacity <= 0 || !native_int( definition.magazine_capacity ) ) ) {
                throw std::runtime_error( "item '" + definition.id + "' has an invalid magazine capacity" );
            }
            if( definition.has_category && item_category_ids.count( definition.category ) == 0 &&
                !item_category_id( definition.category ).is_valid() ) {
                throw std::runtime_error( "item '" + definition.id +
                                          "' references unknown category '" + definition.category + "'" );
            }
            if( definition.comestible ) {
                const item_definition_data::comestible_data &food = *definition.comestible;
                if( ( food.type != "FOOD" && food.type != "DRINK" && food.type != "MED" ) ||
                    food.calories < 0 || food.calories > std::numeric_limits<int>::max() ||
                    food.fun < std::numeric_limits<int>::min() ||
                    food.fun > std::numeric_limits<int>::max() ||
                    food.healthy < std::numeric_limits<int>::min() ||
                    food.healthy > std::numeric_limits<int>::max() ||
                    food.quench < std::numeric_limits<int>::min() ||
                    food.quench > std::numeric_limits<int>::max() ||
                    food.spoils_in_turns < 0 ||
                    food.spoils_in_turns > std::numeric_limits<int>::max() ||
                    !finite_native_float( food.freezing_point_celsius ) ||
                    food.charges < 0 || food.charges > std::numeric_limits<int>::max() ||
                    food.stack_size < 0 ||
                    food.stack_size > std::numeric_limits<int>::max() ) {
                    throw std::runtime_error( "item '" + definition.id +
                                              "' has invalid comestible values" );
                }
                for( const auto &[vitamin_key, amount] : food.vitamins ) {
                    if( ( vitamin_ids.count( vitamin_key ) == 0 &&
                          !vitamin_id( vitamin_key ).is_valid() ) ||
                        amount < std::numeric_limits<int>::min() ||
                        amount > std::numeric_limits<int>::max() ) {
                        throw std::runtime_error( "item '" + definition.id +
                                                  "' references an invalid vitamin '" +
                                                  vitamin_key + "'" );
                    }
                }
            }
            if( definition.default_container &&
                ( definition.default_container->empty() ||
                  ( *definition.default_container != "null" &&
                    declared_item_ids.count( *definition.default_container ) == 0 &&
                    check_engine_state && !item::type_is_defined( itype_id( *definition.default_container ) ) ) ) ) {
                throw std::runtime_error( "item '" + definition.id + "' references an unknown default container" );
            }
            if( definition.book ) {
                const item_definition_data::book_data &book = *definition.book;
                if( ( !book.skill.empty() && book.skill != skill_id::NULL_ID().str() &&
                      skill_ids.count( book.skill ) == 0 && !skill_id( book.skill ).is_valid() ) ||
                    !native_int( book.required_level ) || !native_int( book.maximum_level ) ||
                    book.intelligence < 0 ||
                    book.intelligence > std::numeric_limits<int>::max() ||
                    book.read_time_turns < 0 ||
                    book.read_time_turns > std::numeric_limits<int>::max() ||
                    book.fun < std::numeric_limits<int>::min() ||
                    book.fun > std::numeric_limits<int>::max() ||
                    book.chapters < 0 || book.chapters > std::numeric_limits<int>::max() ) {
                    throw std::runtime_error( "item '" + definition.id +
                                              "' has invalid book values" );
                }
                for( const book_proficiency_bonus &bonus : book.proficiencies ) {
                    if( ( proficiency_ids.count( bonus.id.str() ) == 0 && !bonus.id.is_valid() ) ||
                        !( bonus.time_factor >= 0.0f && bonus.time_factor < 1.0f ) ||
                        !( bonus.fail_factor >= 0.0f && bonus.fail_factor < 1.0f ) ||
                        !( bonus.cap > 0.0f && bonus.cap <= 1.0f ) ) {
                        throw std::runtime_error( "item '" + definition.id +
                                                  "' has an invalid book proficiency bonus" );
                    }
                }
            }
            for( const std::string &spell : definition.learned_spells ) {
                require_valid_id( spell, "learnable spell" );
            }
            const auto &item_factory = item_controller->get_generic_factory();
            const bool exists = definition.is_abstract ?
                                item_factory.find_abstract( definition.id ) != nullptr :
                                item_factory.is_valid( itype_id( definition.id ) );
            validate_operation( entry.operation, exists,
                                definition.id, "item" );
            if( !definition.use_handler.empty() &&
                !runtime_has_handler( owner_runtime, definition.use_handler ) ) {
                throw std::runtime_error( "item '" + definition.id +
                                          "' references missing handler '" + definition.use_handler + "'" );
            }
            if( !definition.tick_handler.empty() &&
                !runtime_has_handler( owner_runtime, definition.tick_handler ) ) {
                throw std::runtime_error( "item '" + definition.id +
                                          "' references missing tick handler '" + definition.tick_handler + "'" );
            }
            if( !definition.consume_handler.empty() &&
                !runtime_has_handler( owner_runtime, definition.consume_handler ) ) {
                throw std::runtime_error( "item '" + definition.id +
                                          "' references missing consumption handler '" +
                                          definition.consume_handler + "'" );
            }
        }

        const auto validate_recipe_skills = [&]( const recipe_definition_data & definition ) {
            if( check_engine_state && !definition.skill.empty() && skill_ids.count( definition.skill ) == 0 &&
                !skill_id( definition.skill ).is_valid() ) {
                throw std::runtime_error( "recipe '" + definition.id +
                                          "' references unknown skill '" + definition.skill + "'" );
            }
            for( const auto &[skill, level] : definition.required_skills ) {
                if( ( check_engine_state && skill_ids.count( skill ) == 0 && !skill_id( skill ).is_valid() ) ||
                    level < 0 || level > MAX_SKILL ) {
                    throw std::runtime_error( "recipe '" + definition.id +
                                              "' has an invalid required skill '" + skill + "'" );
                }
            }
        };
        std::set<std::string> recipe_ids;
        std::set<std::string> uncraft_results;
        for( const recipe_registration &entry : pimpl_->recipes ) {
            const recipe_definition_data &definition = *entry.definition;
            require_valid_id( definition.id,
                              definition.nested_category ? "nested recipe category" : "recipe" );
            if( !recipe_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "recipe '" + definition.id +
                                          "' is registered more than once in one transaction" );
            }
            if( definition.uncraft && !uncraft_results.insert( definition.result ).second ) {
                throw std::runtime_error( "disassembly result '" + definition.result +
                                          "' is registered more than once in one transaction" );
            }
            const bool exists = definition.uncraft ?
                                recipe_dict.uncraft.count( recipe_id( definition.result ) ) != 0 :
                                recipe_dict.recipes.count( recipe_id( definition.id ) ) != 0;
            validate_operation( entry.operation, exists, definition.id,
                                definition.nested_category ? "nested recipe category" : "recipe" );
            if( definition.obsolete ) {
                if( definition.result.empty() || definition.uncraft || !definition.steps.empty() ) {
                    throw std::runtime_error( "obsolete recipe '" + definition.id +
                                              "' requires a result and cannot define disassembly or steps" );
                }
                continue;
            }
            if( definition.nested_category ) {
                if( definition.name.empty() || definition.category.empty() || definition.subcategory.empty() ||
                    definition.nested_recipes.empty() || definition.difficulty < 0 ||
                    definition.difficulty > MAX_SKILL || !finite_native_float( definition.activity_level ) ||
                    definition.activity_level <= 0.0 ) {
                    throw std::runtime_error( "nested recipe category '" + definition.id +
                                              "' has invalid presentation, difficulty, activity, or members" );
                }
                if( crafting_category_ids.count( definition.category ) == 0 &&
                    !crafting_category_id( definition.category ).is_valid() ) {
                    throw std::runtime_error( "nested recipe category '" + definition.id +
                                              "' references unknown category '" + definition.category + "'" );
                }
                validate_recipe_skills( definition );
                if( check_engine_state ) {
                    for( const auto &[member, optional] : definition.nested_recipes ) {
                        if( !optional && declared_recipe_ids.count( member ) == 0 &&
                            recipe_dict.recipes.count( recipe_id( member ) ) == 0 ) {
                            throw std::runtime_error( "nested recipe category '" + definition.id +
                                                      "' references unknown recipe '" + member + "'" );
                        }
                    }
                }
                continue;
            }
            if( definition.practice &&
                ( !definition.result.empty() || definition.name.empty() || definition.skill.empty() ||
                  definition.blueprint || !definition.steps.empty() ) ) {
                throw std::runtime_error( "practice recipe '" + definition.id +
                                          "' needs a name and skill without an item result, blueprint or steps" );
            }
            if( definition.result.empty() &&
                ( definition.name.empty() || ( !definition.practice && definition.result_handler.empty() ) ||
                  definition.uncraft || definition.reversible || definition.result_charges ) ) {
                throw std::runtime_error( "recipe '" + definition.id +
                                          "' without an item result requires a name and completion handler, and cannot supply disassembly or result charges" );
            }
            if( definition.time_moves < 0 ||
                definition.difficulty < 0 || definition.difficulty > MAX_SKILL ||
                !finite_native_float( definition.activity_level ) || definition.activity_level <= 0.0 ) {
                throw std::runtime_error( "recipe '" + definition.id +
                                          "' has invalid result, duration, difficulty, or activity" );
            }
            if( ( !definition.uncraft || !definition.category.empty() ) &&
                crafting_category_ids.count( definition.category ) == 0 &&
                !crafting_category_id( definition.category ).is_valid() ) {
                throw std::runtime_error( "recipe '" + definition.id +
                                          "' references unknown category '" + definition.category + "'" );
            }
            validate_recipe_skills( definition );
            for( const auto &[skill, level] : definition.autolearn_skills ) {
                if( ( check_engine_state && skill_ids.count( skill ) == 0 && !skill_id( skill ).is_valid() ) ||
                    level < 0 || level > MAX_SKILL ) {
                    throw std::runtime_error( "recipe '" + definition.id +
                                              "' has an invalid autolearn skill '" + skill + "'" );
                }
            }
            if( const auto *linear = std::get_if<batch_savings::linear>( &definition.batching.data );
                linear && linear->offset > definition.time_moves ) {
                throw std::runtime_error( "recipe '" + definition.id + "' has a batch setup longer than its base duration" );
            }
            if( definition.reversible && ( !definition.byproducts.empty() ||
                                           !definition.byproduct_group.empty() ) ) {
                throw std::runtime_error( "recipe '" + definition.id + "' cannot be reversible and have byproducts" );
            }
            if( check_engine_state && !definition.byproduct_group.empty() &&
                item_group_ids.count( definition.byproduct_group ) == 0 &&
                !item_group::group_is_defined( item_group_id( definition.byproduct_group ) ) ) {
                throw std::runtime_error( "recipe '" + definition.id + "' references an unknown byproduct group" );
            }
            for( const auto &[skill, level] : definition.disassembly_learning ) {
                if( ( check_engine_state && skill_ids.count( skill ) == 0 && !skill_id( skill ).is_valid() ) ||
                    level < 0 || level > MAX_SKILL ) {
                    throw std::runtime_error( "recipe '" + definition.id +
                                              "' has an invalid disassembly learning skill '" + skill + "'" );
                }
            }
            const auto validate_recipe_requirements = [&]( const recipe_requirement_sets &requirements ) {
                for( const auto &[requirement, multiplier] : requirements ) {
                    if( requirement.empty() || multiplier <= 0 || !native_int( multiplier ) ||
                        ( check_engine_state && requirement_ids.count( requirement ) == 0 &&
                          requirement_data::registry().count( requirement_id( requirement ) ) == 0 ) ) {
                        throw std::runtime_error( "recipe '" + definition.id +
                                                  "' references invalid requirement '" + requirement + "'" );
                    }
                }
            };
            validate_recipe_requirements( definition.external_requirements );
            const auto validate_recipe_groups = [&]( const std::vector<std::vector<component_requirement>>
                                                &groups,
            const char *kind, const bool tools ) {
                for( const std::vector<component_requirement> &group : groups ) {
                    if( group.empty() ) {
                        throw std::runtime_error( "recipe '" + definition.id +
                                                  "' has an empty " + kind + " group" );
                    }
                    for( const component_requirement &component : group ) {
                        if( component.id.empty() || ( tools ? component.count == 0 : component.count <= 0 ) ||
                            !native_int( component.count ) ) {
                            throw std::runtime_error( "recipe '" + definition.id + "' has an invalid " + kind );
                        }
                        const bool valid = component.requirement ?
                                           requirement_ids.count( component.id ) != 0 ||
                                           requirement_data::registry().count( requirement_id( component.id ) ) != 0 :
                                           declared_item_ids.count( component.id ) != 0 ||
                                           item::type_is_defined( itype_id( component.id ) ) ||
                                           item_controller->has_template_migration( itype_id( component.id ) );
                        // Native item inheritance is resolved before the engine-state pass.
                        if( check_engine_state && !valid ) {
                            throw std::runtime_error( "recipe '" + definition.id +
                                                      "' references unknown " +
                                                      ( component.requirement ? std::string( "requirement" ) : kind ) +
                                                      " '" + component.id + "'" );
                        }
                    }
                }
            };
            if( definition.result_charges &&
                ( *definition.result_charges <= 0 ||
                  *definition.result_charges > std::numeric_limits<int>::max() ) ) {
                throw std::runtime_error( "recipe '" + definition.id +
                                          "' has invalid result charges" );
            }
            if( definition.result_multiplier <= 0 || !native_int( definition.result_multiplier ) ) {
                throw std::runtime_error( "recipe '" + definition.id + "' has an invalid result multiplier" );
            }
            const auto validate_recipe_qualities = [&]( const auto & groups ) {
                for( const auto &group : groups ) {
                    for( const quality_requirement_definition &quality : group ) {
                        if( check_engine_state && tool_quality_ids.count( quality.id ) == 0 &&
                            !quality_id( quality.id ).is_valid() ) {
                            throw std::runtime_error( "recipe '" + definition.id + "' references an invalid quality" );
                        }
                    }
                }
            };
            const auto validate_recipe_proficiencies = [&]( const std::vector<recipe_proficiency_data> &values ) {
                for( const recipe_proficiency_data &proficiency : values ) {
                    if( proficiency.id.empty() ||
                        ( check_engine_state && proficiency_ids.count( proficiency.id ) == 0 &&
                          !proficiency_id( proficiency.id ).is_valid() ) ||
                        !finite_native_float( proficiency.time_multiplier ) ||
                        !finite_native_float( proficiency.skill_penalty ) ||
                        !finite_native_float( proficiency.learning_time_multiplier ) ) {
                        throw std::runtime_error( "recipe '" + definition.id + "' has an invalid proficiency" );
                    }
                }
            };
            validate_recipe_qualities( definition.qualities );
            validate_recipe_groups( definition.components, "component", false );
            validate_recipe_groups( definition.tools, "tool", true );
            validate_recipe_proficiencies( definition.proficiencies );
            if( definition.disassembly_moves < 0 ||
                definition.disassembly_moves > std::numeric_limits<int>::max() ) {
                throw std::runtime_error( "recipe '" + definition.id + "' has an invalid disassembly duration" );
            }
            if( !definition.steps.empty() && ( definition.uncraft || !definition.tools.empty() ||
                                               !definition.qualities.empty() || !definition.proficiencies.empty() ||
                                               !std::holds_alternative<batch_savings::none>( definition.batching.data ) ) ) {
                throw std::runtime_error( "stepped recipe '" + definition.id +
                                          "' must define tools, qualities, proficiencies and batch rules on each step" );
            }
            std::int64_t total_step_moves = 0;
            for( const recipe_step_definition_data &step : definition.steps ) {
                if( step.name.empty() || step.moves <= 0 ||
                    step.moves > std::numeric_limits<std::int64_t>::max() - total_step_moves ||
                    !finite_native_float( step.activity ) || step.activity <= 0.0 ||
                    ( step.max_time && to_turns<int>( *step.max_time ) <= step.moves / 100 ) ||
                    ( step.grace_period && ( !step.max_time ||
                                             to_turns<int>( *step.grace_period ) >
                                             std::numeric_limits<int>::max() - to_turns<int>( *step.max_time ) ) ) ) {
                    throw std::runtime_error( "recipe '" + definition.id + "' has an invalid crafting step" );
                }
                total_step_moves += step.moves;
                if( const auto *linear = std::get_if<batch_savings::linear>( &step.batching.data );
                    linear && linear->offset > step.moves ) {
                    throw std::runtime_error( "recipe '" + definition.id + "' has a batch setup longer than its step" );
                }
                validate_recipe_qualities( step.qualities );
                validate_recipe_groups( step.tools, "step tool", true );
                validate_recipe_requirements( step.requirements );
                validate_recipe_proficiencies( step.proficiencies );
            }
            if( definition.blueprint ) {
                if( definition.result.empty() || definition.uncraft || !definition.steps.empty() ||
                    definition.time_moves > std::numeric_limits<int>::max() ) {
                    throw std::runtime_error( "recipe '" + definition.id + "' has invalid camp blueprint options" );
                }
                if( const auto &needs = definition.blueprint->needs ) {
                    if( needs->time > std::numeric_limits<int>::max() - definition.time_moves ) {
                        throw std::runtime_error( "recipe '" + definition.id + "' has an invalid blueprint duration" );
                    }
                    for( const auto &[skill, level] : needs->skills ) {
                        if( check_engine_state && skill_ids.count( skill ) == 0 && !skill_id( skill ).is_valid() ) {
                            throw std::runtime_error( "recipe '" + definition.id + "' has an unknown blueprint skill" );
                        }
                    }
                    validate_recipe_groups( needs->components, "blueprint component", false );
                    validate_recipe_groups( needs->tools, "blueprint tool", true );
                    validate_recipe_qualities( needs->qualities );
                }
            }
            for( const auto &[book, properties] : definition.books ) {
                if( book.empty() || properties.level < -1 || properties.level > MAX_SKILL ||
                    ( check_engine_state && !item::type_is_defined( itype_id( book ) ) &&
                      declared_item_ids.count( book ) == 0 ) ) {
                    throw std::runtime_error( "recipe '" + definition.id + "' has an invalid book" );
                }
            }
            if( definition.scripted_output && definition.result_handler.empty() ) {
                throw std::runtime_error( "recipe '" + definition.id + "' with scripted output needs a completion handler" );
            }
            if( !definition.result_handler.empty() &&
                !runtime_has_handler( owner_runtime, definition.result_handler ) ) {
                throw std::runtime_error( "recipe '" + definition.id +
                                          "' references missing completion handler '" + definition.result_handler + "'" );
            }
        }

        static const std::set<std::string> plant_lifecycle_phases = {
            "plant", "grow", "mature", "overgrow", "harvest", "fertilize", "water"
        };
        std::set<std::pair<std::string, std::string>> plant_lifecycle_targets;
        for( const plant_lifecycle_registration &entry : pimpl_->plant_lifecycles ) {
            const plant_lifecycle_definition_data &definition = *entry.definition;
            if( entry.operation != definition_operation::add || definition.id.empty() ||
                definition.id.find( '#' ) != std::string::npos ||
                ( definition.target != "seed" && definition.target != "furniture" ) ||
                definition.handlers.empty() ||
                !plant_lifecycle_targets.emplace( definition.target, definition.id ).second ) {
                throw std::runtime_error( "plant lifecycle definition has an invalid or duplicate target" );
            }
            if( check_engine_state ) {
                if( definition.target == "seed" ) {
                    if( declared_item_ids.count( definition.id ) == 0 &&
                        !item::type_is_defined( itype_id( definition.id ) ) ) {
                        throw std::runtime_error( "plant lifecycle references unknown seed item '" +
                                                  definition.id + "'" );
                    }
                } else if( context.defines_furniture && !context.defines_furniture( definition.id ) &&
                           !furn_str_id( definition.id ).is_valid() ) {
                    throw std::runtime_error( "plant lifecycle references unknown furniture '" +
                                              definition.id + "'" );
                }
            }
            for( const auto &[phase, handler] : definition.handlers ) {
                if( plant_lifecycle_phases.count( phase ) == 0 || handler.empty() ||
                    !runtime_has_handler( owner_runtime, handler ) ) {
                    throw std::runtime_error( "plant lifecycle '" + definition.target + ":" + definition.id +
                                              "' has an invalid " + phase + " handler" );
                }
            }
        }
    } catch( const std::exception &exception ) {
        error = "Lua-first Mod '" + pimpl_->owner + "': " + exception.what();
        return false;
    }
    error.clear();
    return true;
}

bool items_content_transaction::validate_scaled_requirement_set(
    const std::vector<std::pair<std::string, std::int64_t>> &requirements,
    std::string &error ) const
{
    try {
        struct scaled_requirement_component {
            std::string type;
            bool is_requirement = false;
            std::int64_t count = 0;
        };
        using scaled_requirement_groups =
            std::vector<std::vector<scaled_requirement_component>>;
        scaled_requirement_groups scaled_component_groups;
        scaled_requirement_groups scaled_tool_groups;
        std::set<std::string> ids;
        for( const std::pair<std::string, std::int64_t> &requirement : requirements ) {
            const std::string &id = requirement.first;
            const std::int64_t count = requirement.second;
            if( id.empty() || id.size() > 256 || id.find( '\0' ) != std::string::npos ||
                count <= 0 || count > std::numeric_limits<int>::max() ||
                !ids.insert( id ).second ) {
                throw std::runtime_error( "has invalid requirement '" + id + "'" );
            }
            const requirement_id native_id( id );
            std::vector<requirement_source_layer> pending;
            for( const requirement_registration &entry : pimpl_->requirements ) {
                if( entry.definition->id == id ) {
                    pending.push_back( native_requirement_layer( *entry.definition, pimpl_->owner ) );
                    pending.back().definition.id_ = native_id;
                    pending.back().definition.name_ = entry.definition->name.native();
                }
            }
            const auto existing = requirement_data::registry().find( native_id );
            std::optional<requirement_data> staged;
            if( !pending.empty() ) {
                staged = requirement_data::resolve_requirement_layers( native_id, pending );
            }
            const requirement_data *effective = staged ? &*staged :
                                                existing == requirement_data::registry().end() ? nullptr :
                                                &existing->second;
            if( !effective ) {
                throw std::runtime_error( "has invalid requirement '" + id + "'" );
            }
            const auto scaled_counts_fit = [count]( const auto & groups ) {
                constexpr std::int64_t native_min = std::numeric_limits<int>::min();
                constexpr std::int64_t native_max = std::numeric_limits<int>::max();
                for( const auto &group : groups ) {
                    for( const auto &component : group ) {
                        const std::int64_t component_count = component.count;
                        if( ( component_count < 0 && component_count < native_min / count ) ||
                            ( component_count > 0 && component_count > native_max / count ) ) {
                            return false;
                        }
                    }
                }
                return true;
            };
            const auto append_scaled_groups = [count](
                                                  const auto & groups,
                                                  scaled_requirement_groups & target,
            const auto & type_of, const auto & is_requirement ) {
                for( const auto &group : groups ) {
                    std::vector<scaled_requirement_component> scaled_group;
                    scaled_group.reserve( group.size() );
                    for( const auto &component : group ) {
                        const std::int64_t scaled_count =
                            static_cast<std::int64_t>( component.count ) * count;
                        scaled_group.push_back( {
                            type_of( component ), is_requirement( component ),
                            std::max<std::int64_t>( scaled_count, -1 )
                        } );
                    }
                    target.push_back( std::move( scaled_group ) );
                }
            };
            const bool counts_fit = scaled_counts_fit( effective->get_components() ) &&
                                    scaled_counts_fit( effective->get_tools() );
            if( counts_fit ) {
                append_scaled_groups(
                    effective->get_components(), scaled_component_groups,
                []( const item_comp & component ) {
                    return component.type.str();
                }, []( const item_comp & component ) {
                    return component.requirement;
                } );
                append_scaled_groups(
                    effective->get_tools(), scaled_tool_groups,
                []( const tool_comp & component ) {
                    return component.type.str();
                }, []( const tool_comp & component ) {
                    return component.requirement;
                } );
            }
            if( !counts_fit ) {
                throw std::runtime_error(
                    "requirement '" + id +
                    "' exceeds the native component/tool count range when scaled" );
            }
        }
        const auto consolidated_counts_fit = []( scaled_requirement_groups old_groups,
        const bool tools ) {
            const auto type_less = []( const scaled_requirement_component & lhs,
            const scaled_requirement_component & rhs ) {
                return std::tie( lhs.type, lhs.is_requirement ) <
                       std::tie( rhs.type, rhs.is_requirement );
            };
            for( std::vector<scaled_requirement_component> &group : old_groups ) {
                std::sort( group.begin(), group.end(), type_less );
            }
            std::sort( old_groups.begin(), old_groups.end(),
            [&type_less]( const auto & lhs, const auto & rhs ) {
                return std::lexicographical_compare(
                           lhs.begin(), lhs.end(), rhs.begin(), rhs.end(), type_less );
            } );
            std::vector<std::vector<scaled_requirement_component>> consolidated;
            for( std::vector<scaled_requirement_component> &old_group : old_groups ) {
                bool match = false;
                for( std::vector<scaled_requirement_component> &new_group : consolidated ) {
                    if( std::includes( new_group.begin(), new_group.end(),
                                       old_group.begin(), old_group.end(), type_less ) ) {
                        match = true;
                        std::swap( old_group, new_group );
                    } else if( std::includes( old_group.begin(), old_group.end(),
                                              new_group.begin(), new_group.end(), type_less ) ) {
                        match = true;
                    }
                    if( !match ) {
                        continue;
                    }
                    auto old_component = old_group.begin();
                    for( auto new_component = new_group.begin();
                         new_component != new_group.end(); ++old_component ) {
                        if( !type_less( *old_component, *new_component ) ) {
                            if( tools ) {
                                if( new_component->count < 0 && old_component->count < 0 ) {
                                    new_component->count = std::min(
                                                               new_component->count,
                                                               old_component->count );
                                } else if( new_component->count > 0 && old_component->count > 0 ) {
                                    const std::int64_t sum =
                                        new_component->count + old_component->count;
                                    if( sum > std::numeric_limits<int>::max() ) {
                                        return false;
                                    }
                                    new_component->count = sum;
                                }
                            } else {
                                const std::int64_t sum =
                                    new_component->count + old_component->count;
                                if( sum < std::numeric_limits<int>::min() ||
                                    sum > std::numeric_limits<int>::max() ) {
                                    return false;
                                }
                                new_component->count = sum;
                            }
                            ++new_component;
                        }
                    }
                    break;
                }
                if( !match ) {
                    consolidated.push_back( std::move( old_group ) );
                }
            }
            return true;
        };
        if( !consolidated_counts_fit( std::move( scaled_component_groups ), false ) ||
            !consolidated_counts_fit( std::move( scaled_tool_groups ), true ) ) {
            throw std::runtime_error(
                "combined requirements exceed the native count range during consolidation" );
        }
    } catch( const std::exception &exception ) {
        error = exception.what();
        return false;
    }
    error.clear();
    return true;
}

// NOLINTNEXTLINE(readability-function-size)
bool items_content_transaction::apply_phase( const items_content_apply_phase phase,
        std::string &error )
{
    if( pimpl_->applied ) {
        error = "items content transaction for '" + pimpl_->owner + "' was already applied";
        return false;
    }
    if( pimpl_->token->lifecycle != handle_lifecycle::building ) {
        error = "items content transaction for '" + pimpl_->owner + "' is no longer building";
        return false;
    }
    if( static_cast<int>( phase ) != pimpl_->applied_phase_count ) {
        error = "items content phases must be applied in declaration order";
        return false;
    }
    try {
        switch( phase ) {
            case items_content_apply_phase::foundations: {
                for( const auto &entry : pimpl_->item_migrations ) {
                    migration native = entry->specification;
                    native.source = pimpl_->owner;
                    auto &registry = item_controller->migrations;
                    for( const itype_id &id : entry->from ) {
                        const auto previous = registry.find( id );
                        pimpl_->item_migration_undo.emplace_back(
                            id, previous == registry.end() ? std::nullopt :
                            std::optional<std::vector<migration>>( previous->second ) );
                        native.id = id;
                        item_controller->add_migration( native );
                    }
                }
                for( const json_flag_registration &entry : pimpl_->json_flags ) {
                    const flag_id id( entry.definition->id );
                    pimpl_->json_flag_undo.emplace_back(
                        id, id.is_valid() ? std::optional<json_flag>( id.obj() ) : std::nullopt );
                    const json_flag_definition_data &source = *entry.definition;
                    json_flag native;
                    native.id = id;
                    native.was_loaded = true;
                    native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                    native.info_ = source.info.native();
                    native.restriction_ = source.restriction.native();
                    native.name_ = source.name.native();
                    native.item_prefix_ = source.item_prefix.native();
                    native.item_suffix_ = source.item_suffix.native();
                    native.conflicts_ = source.conflicts;
                    native.inherit_ = source.inherit;
                    native.craft_inherit_ = source.craft_inherit;
                    native.requires_flag_ = source.requires_flag;
                    native.taste_mod_ = static_cast<int>( source.taste_modifier );
                    detail::json_flag_registry().insert( native );
                }

                for( const math_function_registration &entry : pimpl_->math_functions ) {
                    const jmath_func_id id( entry.definition->id );
                    pimpl_->math_function_undo.emplace_back(
                        id, id.is_valid() ? std::optional<jmath_func>( id.obj() ) : std::nullopt );
                    const math_function_definition_data &source = *entry.definition;
                    jmath_func native;
                    native.id = id;
                    native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                    native.was_loaded = true;
                    native.num_params = static_cast<int>( source.num_args );
                    native._str = source.expression;
                    detail::jmath_func_registry().insert( native );
                }
                if( !pimpl_->math_functions.empty() ) {
                    detail::jmath_func_registry().finalize();
                }

                for( const tool_quality_registration &entry : pimpl_->tool_qualities ) {
                    const quality_id id( entry.definition->id );
                    pimpl_->tool_quality_undo.emplace_back(
                        id, id.is_valid() ? std::optional<quality>( id.obj() ) : std::nullopt );
                    quality native;
                    native.id = id;
                    native.name = entry.definition->name.native();
                    native.was_loaded = true;
                    native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                    for( const auto &[level, text] : entry.definition->usages ) {
                        native.usages.emplace_back( static_cast<int>( level ), text );
                    }
                    detail::tool_quality_registry().insert( native );
                }

                for( const skill_display_registration &entry : pimpl_->skill_displays ) {
                    const skill_displayType_id id( entry.definition->id );
                    pimpl_->skill_display_undo.emplace_back(
                        id, id.is_valid() ? std::optional<SkillDisplayType>( id.obj() ) : std::nullopt );
                    SkillDisplayType::skillTypes.erase(
                        std::remove_if( SkillDisplayType::skillTypes.begin(),
                                        SkillDisplayType::skillTypes.end(),
                    [&id]( const SkillDisplayType & value ) {
                        return value.ident() == id;
                    } ),
                    SkillDisplayType::skillTypes.end() );
                    SkillDisplayType::skillTypes.emplace_back(
                        id, entry.definition->label.native() );
                }

                for( const skill_registration &entry : pimpl_->skills ) {
                    const skill_id id( entry.definition->id );
                    pimpl_->skill_undo.emplace_back(
                        id, id.is_valid() ? std::optional<Skill>( id.obj() ) : std::nullopt );
                    Skill::skills.erase( std::remove_if( Skill::skills.begin(), Skill::skills.end(),
                    [&id]( const Skill & value ) {
                        return value.ident() == id;
                    } ), Skill::skills.end() );
                    Skill::contextual_skills.erase( id );
                    const skill_definition_data &source = *entry.definition;
                    Skill native( id, source.name.native(), source.description.native(),
                                  source.tags, skill_displayType_id( source.display_category ) );
                    native._sort_rank = static_cast<int>( source.sort_rank );
                    native.consumes_focus = source.consumes_focus;
                    native._teachable = source.teachable;
                    native._obsolete = source.obsolete;
                    native._time_to_attack = {
                        static_cast<int>( source.attack_min_time ),
                        static_cast<int>( source.attack_base_time ),
                        static_cast<int>( source.attack_reduction_per_level )
                    };
                    native._companion_combat_rank_factor =
                        static_cast<int>( source.companion_combat_rank_factor );
                    native._companion_survival_rank_factor =
                        static_cast<int>( source.companion_survival_rank_factor );
                    native._companion_industry_rank_factor =
                        static_cast<int>( source.companion_industry_rank_factor );
                    for( const auto &[practice_id, weight] : source.companion_practice ) {
                        native._companion_skill_practice[practice_id] = static_cast<int>( weight );
                    }
                    for( const auto &[level, description] : source.theory_descriptions ) {
                        native._level_descriptions_theory[static_cast<int>( level )] =
                            description.native();
                    }
                    for( const auto &[level, description] : source.practice_descriptions ) {
                        native._level_descriptions_practice[static_cast<int>( level )] =
                            description.native();
                    }
                    native._requires_all_traits = source.requires_all_traits;
                    native._requires_any_traits = source.requires_any_traits;
                    if( native.is_contextual_skill() ) {
                        Skill::contextual_skills[id] = std::move( native );
                    } else {
                        Skill::skills.push_back( std::move( native ) );
                    }
                }

                for( const vitamin_registration &entry : pimpl_->vitamins ) {
                    const vitamin_id id( entry.definition->id );
                    pimpl_->vitamin_undo.emplace_back(
                        id, id.is_valid() ? std::optional<vitamin>( id.obj() ) : std::nullopt );
                    const vitamin_definition_data &source = *entry.definition;
                    vitamin native;
                    native.id = id;
                    native.was_loaded = true;
                    native.name_ = source.name.native();
                    native.type_ = source.type == "vitamin" ? vitamin_type::VITAMIN :
                                   source.type == "toxin" ? vitamin_type::TOXIN :
                                   source.type == "drug" ? vitamin_type::DRUG : vitamin_type::COUNTER;
                    native.deficiency_ = source.deficiency.empty() ? efftype_id::NULL_ID() :
                                         efftype_id( source.deficiency );
                    native.excess_ = source.excess.empty() ? efftype_id::NULL_ID() :
                                     efftype_id( source.excess );
                    native.min_ = static_cast<int>( source.minimum );
                    native.max_ = static_cast<int>( source.maximum );
                    native.rate_ = time_duration::from_turns( source.rate_turns );
                    if( source.weight_micrograms ) {
                        native.weight_per_unit = vitamin_units::mass(
                                                     static_cast<int>( *source.weight_micrograms ), {} );
                    }
                    for( const auto &[start, end] : source.disease ) {
                        native.disease_.emplace_back( static_cast<int>( start ), static_cast<int>( end ) );
                    }
                    for( const auto &[start, end] : source.disease_excess ) {
                        native.disease_excess_.emplace_back( static_cast<int>( start ), static_cast<int>( end ) );
                    }
                    for( const auto &[decay_id, rate] : source.decays_into ) {
                        native.decays_into_.emplace_back( vitamin_id( decay_id ), static_cast<int>( rate ) );
                    }
                    native.flags_ = source.flags;
                    detail::vitamin_registry().insert( native );
                }

                for( const damage_type_registration &entry : pimpl_->damage_types ) {
                    const damage_type_id id( entry.definition->id );
                    pimpl_->damage_type_undo.emplace_back(
                        id, id.is_valid() ? std::optional<damage_type>( id.obj() ) : std::nullopt );
                    const damage_type_definition_data &source = *entry.definition;
                    damage_type native;
                    native.id = id;
                    native.name = source.name.native();
                    native.skill = source.skill.empty() ? skill_id::NULL_ID() : skill_id( source.skill );
                    native.magic_color = color_from_string( source.magic_color );
                    native.bash_conversion_factor = source.bash_conversion_factor;
                    native.melee_crit_dmg_mult = source.melee_crit_dmg_mult;
                    native.melee_crit_dmg_mult_per_skill = source.melee_crit_dmg_mult_per_skill;
                    native.melee_crit_armor_mult = source.melee_crit_armor_mult;
                    native.melee_crit_armor_penetration = source.melee_crit_armor_penetration;
                    native.melee_only = source.melee_only;
                    native.physical = source.physical;
                    native.mon_difficulty = source.monster_difficulty;
                    native.no_resist = source.no_resist;
                    native.edged = source.edged;
                    native.env = source.environmental;
                    native.material_required = source.material_required;
                    native.immune_flags = cata::flat_set<std::string>(
                                              source.character_immune_flags.begin(),
                                              source.character_immune_flags.end() );
                    native.mon_immune_flags = cata::flat_set<std::string>(
                                                  source.monster_immune_flags.begin(),
                                                  source.monster_immune_flags.end() );
                    if( !source.derived_from.empty() ) {
                        native.derived_from = {
                            damage_type_id( source.derived_from ),
                            static_cast<float>( source.derived_factor )
                        };
                    }
                    native.was_loaded = true;
                    detail::damage_type_registry().insert( native );
                }

                break;
            }
            case items_content_apply_phase::materials: {
                auto &registry = detail::material_registry();
                const auto find_parent = [&registry]( const std::string & id ) -> const material_type * {
                    const material_id parent_id( id );
                    return registry.is_valid( parent_id ) ? &registry.obj( parent_id ) :
                           registry.find_abstract( id );
                };
                std::vector<std::size_t> order;
                std::string inheritance_error;
                if( !detail::resolve_platform_inheritance_order( pimpl_->materials,
                []( const material_registration & entry ) {
                    return entry.definition->id;
                }, []( const material_registration & entry ) {
                    return entry.definition->copy_from;
                }, [&find_parent]( const std::string & id ) {
                    return find_parent( id ) != nullptr;
                }, order, inheritance_error, "material" ) ) {
                    throw std::runtime_error( inheritance_error );
                }
                for( const std::size_t index : order ) {
                    const material_definition_data &source = *pimpl_->materials[index].definition;
                    const material_id id( source.id );
                    pimpl_->material_undo.emplace_back(
                        id, id.is_valid() ? std::optional<material_type>( id.obj() ) : std::nullopt );
                    material_type native;
                    if( !source.copy_from.empty() ) {
                        native = *find_parent( source.copy_from );
                    } else {
                        native._bash_dmg_verb = no_translation( "damages" );
                        native._cut_dmg_verb = no_translation( "damages" );
                    }
                    native.id = id;
                    mod_tracker::assign_src( native, pimpl_->owner );
                    native.was_loaded = true;
                    if( !source.name.empty() ) {
                        native._name = source.name.native();
                    }
                    if( !source.salvaged_into.empty() ) {
                        native._salvaged_into = itype_id( source.salvaged_into );
                    }
                    if( !source.repaired_with.empty() ) {
                        native._repaired_with = { itype_id::NULL_ID() };
                        for( const std::string &rep : source.repaired_with ) {
                            native._repaired_with.insert( itype_id( rep ) );
                        }
                    }
                    if( !source.repaired_with_name.empty() ) {
                        native._repaired_with_name = source.repaired_with_name.native();
                    }
                    if( source.chip_resistance ) {
                        native._chip_resist = static_cast<int>( *source.chip_resistance );
                    }
                    if( source.breathability ) {
                        native._breathability = static_cast<breathability_rating>( *source.breathability );
                    }
                    if( source.repair_difficulty ) {
                        native._repair_difficulty = static_cast<int>( *source.repair_difficulty );
                    }
                    if( source.density ) {
                        native._density = static_cast<float>( *source.density );
                    }
                    if( source.sheet_thickness ) {
                        native._sheet_thickness = static_cast<float>( *source.sheet_thickness );
                    }
                    if( source.specific_heat_liquid ) {
                        native._specific_heat_liquid = static_cast<float>( *source.specific_heat_liquid );
                    }
                    if( source.specific_heat_solid ) {
                        native._specific_heat_solid = static_cast<float>( *source.specific_heat_solid );
                    }
                    if( source.latent_heat ) {
                        native._latent_heat = static_cast<float>( *source.latent_heat );
                    }
                    if( source.freezing_point ) {
                        native._freeze_point = static_cast<float>( *source.freezing_point );
                    }
                    if( source.rotting ) {
                        native._rotting = *source.rotting;
                    }
                    if( source.soft ) {
                        native._soft = *source.soft;
                    }
                    if( source.uncomfortable ) {
                        native._uncomfortable = *source.uncomfortable;
                    }
                    if( source.conductive ) {
                        native._conductive = *source.conductive;
                    }
                    if( source.wind_resistance ) {
                        native._wind_resist = static_cast<int>( *source.wind_resistance );
                    }
                    if( !source.bash_damage_verb.empty() ) {
                        native._bash_dmg_verb = source.bash_damage_verb.native();
                    }
                    if( !source.cut_damage_verb.empty() ) {
                        native._cut_dmg_verb = source.cut_damage_verb.native();
                    }
                    for( std::size_t level = 0; level < source.damage_adjectives.size(); ++level ) {
                        const authored_text &adjective = source.damage_adjectives[level];
                        if( adjective.empty() ) {
                            continue;
                        }
                        if( level > native._dmg_adj.size() ) {
                            throw std::runtime_error( "material '" + source.id +
                                                      "' has an undefined intermediate adjective level" );
                        }
                        if( level == native._dmg_adj.size() ) {
                            native._dmg_adj.push_back( adjective.native() );
                        } else {
                            native._dmg_adj[level] = adjective.native();
                        }
                    }
                    for( const auto &[damage_id, amount] : source.resistances ) {
                        const damage_type_id damage_key( damage_id );
                        native._resistances.set_resist( damage_key, static_cast<float>( amount ) );
                        if( !native.has_dedicated_resist( damage_key ) ) {
                            native._res_was_loaded.push_back( damage_key );
                        }
                    }
                    for( const auto &[vitamin_key, amount] : source.vitamins ) {
                        native._vitamins[vitamin_id( vitamin_key )] = amount;
                    }
                    if( !source.burn_data.empty() ) {
                        native._burn_data.clear();
                    }
                    for( const material_burn_definition &burn : source.burn_data ) {
                        native._burn_data.push_back( {
                            burn.immune,
                            units::from_milliliter<std::int64_t>( burn.volume_ml_per_turn ),
                            static_cast<float>( burn.fuel ), static_cast<float>( burn.smoke ),
                            static_cast<float>( burn.burn )
                        } );
                    }
                    if( native._burn_data.empty() ) {
                        mat_burn_data default_burn;
                        default_burn.burn = native._resistances.type_resist( damage_heat ) <= 0.0F;
                        native._burn_data.push_back( default_burn );
                    }
                    if( !source.burn_products.empty() ) {
                        native._burn_products.clear();
                    }
                    for( const auto &[product, efficiency] : source.burn_products ) {
                        native._burn_products.emplace_back( itype_id( product ),
                                                            static_cast<float>( efficiency ) );
                    }
                    if( source.has_fuel ) {
                        native.fuel.energy = units::from_kilojoule<std::int64_t>(
                                                 source.fuel_energy_kilojoules );
                        native.fuel.pump_terrain = source.fuel_pump_terrain;
                        native.fuel.is_perpetual_fuel = source.perpetual_fuel;
                        native.fuel.explosion_data.explosion_chance_hot =
                            static_cast<int>( source.explosion_chance_hot );
                        native.fuel.explosion_data.explosion_chance_cold =
                            static_cast<int>( source.explosion_chance_cold );
                        native.fuel.explosion_data.explosion_factor =
                            static_cast<float>( source.explosion_factor );
                        native.fuel.explosion_data.fiery_explosion = source.fiery_explosion;
                        native.fuel.explosion_data.fuel_size_factor =
                            static_cast<float>( source.fuel_size_factor );
                    }
                    registry.insert( native );
                }
                break;
            }
            case items_content_apply_phase::catalogs: {
                for( const proficiency_category_registration &entry : pimpl_->proficiency_categories ) {
                    const proficiency_category_id id( entry.definition->id );
                    pimpl_->proficiency_category_undo.emplace_back(
                        id, id.is_valid() ? std::optional<proficiency_category>( id.obj() ) : std::nullopt );
                    proficiency_category native;
                    native.id = id;
                    native._name = entry.definition->name.native();
                    native._description = entry.definition->description.native();
                    native.was_loaded = true;
                    detail::proficiency_category_registry().insert( native );
                }
                const auto proficiency_attribute = []( const std::string & attribute ) {
                    if( attribute == "strength" ) {
                        return proficiency_bonus_type::strength;
                    }
                    if( attribute == "dexterity" ) {
                        return proficiency_bonus_type::dexterity;
                    }
                    if( attribute == "intelligence" ) {
                        return proficiency_bonus_type::intelligence;
                    }
                    if( attribute == "perception" ) {
                        return proficiency_bonus_type::perception;
                    }
                    return proficiency_bonus_type::stamina;
                };
                for( const proficiency_registration &entry : pimpl_->proficiencies ) {
                    const proficiency_id id( entry.definition->id );
                    pimpl_->proficiency_undo.emplace_back(
                        id, id.is_valid() ? std::optional<proficiency>( id.obj() ) : std::nullopt );
                    const proficiency_definition_data &source = *entry.definition;
                    proficiency native;
                    native.id = id;
                    native._category = proficiency_category_id( source.category );
                    native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                    native.was_loaded = true;
                    native._name = source.name.native();
                    native._description = source.description.native();
                    native._can_learn = source.can_learn;
                    native._ignore_focus = source.ignore_focus;
                    native._teachable = source.teachable;
                    native._default_time_multiplier = static_cast<float>( source.time_multiplier );
                    native._default_skill_penalty = static_cast<float>( source.skill_penalty );
                    native._default_weakpoint_bonus = static_cast<float>( source.weakpoint_bonus );
                    native._default_weakpoint_penalty = static_cast<float>( source.weakpoint_penalty );
                    native._time_to_learn = time_duration::from_turns(
                                                static_cast<int>( source.time_to_learn_turns ) );
                    for( const std::string &required : source.required ) {
                        native._required.insert( proficiency_id( required ) );
                    }
                    for( const proficiency_bonus_definition &bonus : source.bonuses ) {
                        native._bonuses[bonus.category].push_back( {
                            proficiency_attribute( bonus.attribute ), static_cast<float>( bonus.value )
                        } );
                    }
                    detail::proficiency_registry().insert( native );
                }
                for( const weapon_category_registration &entry : pimpl_->weapon_categories ) {
                    const weapon_category_id id( entry.definition->id );
                    pimpl_->weapon_category_undo.emplace_back(
                        id, id.is_valid() ? std::optional<weapon_category>( id.obj() ) : std::nullopt );
                    weapon_category native;
                    native.id = id;
                    native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                    native.was_loaded = true;
                    native.name_ = entry.definition->name.native();
                    for( const std::string &proficiency : entry.definition->proficiencies ) {
                        native.proficiencies_.emplace_back( proficiency );
                    }
                    detail::weapon_category_registry().insert( native );
                }
                for( const item_category_registration &entry : pimpl_->item_categories ) {
                    const item_category_id id( entry.definition->id );
                    pimpl_->item_category_undo.emplace_back(
                        id, id.is_valid() ? std::optional<item_category>( id.obj() ) : std::nullopt,
                        id.is_valid() ? id.obj().get_spawn_rate() : 1.0F );
                    const item_category_definition_data &source = *entry.definition;
                    item_category native( id, source.header.native(),
                                          source.noun.native(),
                                          static_cast<int>( source.sort_rank ) );
                    native.was_loaded = true;
                    native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                    if( !source.zone.empty() ) {
                        native.zone_ = zone_type_id( source.zone );
                    }
                    for( const item_category_priority_definition &priority : source.priority_zones ) {
                        zone_priority_data rule;
                        rule.was_loaded = true;
                        rule.id = zone_type_id( priority.zone );
                        rule.filthy = priority.filthy;
                        for( const std::string &flag : priority.flags ) {
                            rule.flags.insert( flag_id( flag ) );
                        }
                        native.zone_priority_.push_back( std::move( rule ) );
                    }
                    detail::item_category_registry().insert( native );
                    if( id.is_valid() ) {
                        id.obj().set_spawn_rate( static_cast<float>( source.spawn_rate ) );
                    }
                }
                for( const crafting_category_registration &entry : pimpl_->crafting_categories ) {
                    const crafting_category_id id( entry.definition->id );
                    pimpl_->crafting_category_undo.emplace_back(
                        id, id.is_valid() ? std::optional<crafting_category>( id.obj() ) : std::nullopt );
                    crafting_category native;
                    native.id = id;
                    native.was_loaded = true;
                    native.is_hidden = entry.definition->hidden;
                    native.is_practice = entry.definition->practice;
                    native.is_building = entry.definition->building;
                    native.is_wildcard = entry.definition->wildcard;
                    native.subcategories = entry.definition->subcategories;
                    detail::crafting_category_registry().insert( native );
                }
                const std::size_t load_index = ammunition_type::mod_load_index( pimpl_->owner );
                for( const ammunition_type_registration &entry : pimpl_->ammunition_types ) {
                    const ammotype id( entry.definition->id );
                    const auto previous = ammunition_type::registry().find( id );
                    pimpl_->ammunition_type_undo.emplace_back(
                        id, previous == ammunition_type::registry().end() ?
                        std::optional<ammunition_type>() : std::optional<ammunition_type>( previous->second ) );
                    ammunition_type native;
                    if( entry.operation == definition_operation::upsert &&
                        previous != ammunition_type::registry().end() ) {
                        native = previous->second;
                    }
                    if( load_index >= native.json_name_order_ ) {
                        native.name_ = entry.definition->name.native();
                    }
                    if( load_index >= native.json_default_order_ ) {
                        native.default_ammotype_ = itype_id( entry.definition->default_item );
                    }
                    ammunition_type::registry()[id] = std::move( native );
                }
                break;
            }
            case items_content_apply_phase::ammunition_effects: {
                for( const ammo_effect_registration &entry : pimpl_->ammo_effects ) {
                    const ammo_effect_str_id id( entry.definition->id );
                    pimpl_->ammo_effect_undo.emplace_back(
                        id, id.is_valid() ? std::optional<ammo_effect>( id.obj() ) : std::nullopt );
                    const ammo_effect_definition_data &source = *entry.definition;
                    ammo_effect native;
                    native.id = id;
                    native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                    native.was_loaded = true;
                    native.trigger_chance = static_cast<int>( source.trigger_chance );
                    for( const ammo_field_definition_data &field : source.field_bursts ) {
                        aoe_field_effect value;
                        value.field_type = field_type_str_id( field.field );
                        value.intensity_min = static_cast<int>( field.intensity_min );
                        value.intensity_max = static_cast<int>( field.intensity_max );
                        value.radius = static_cast<int>( field.radius );
                        value.radius_z = static_cast<int>( field.height );
                        value.chance = static_cast<int>( field.chance );
                        value.size = static_cast<int>( field.footprint );
                        value.check_passable = field.passable_only;
                        native.aoe_field_types.push_back( value );
                    }
                    for( const ammo_field_definition_data &field : source.trails ) {
                        trail_field_effect value;
                        value.field_type = field_type_str_id( field.field );
                        value.intensity_min = static_cast<int>( field.intensity_min );
                        value.intensity_max = static_cast<int>( field.intensity_max );
                        value.chance = static_cast<int>( field.chance );
                        native.trail_field_types.push_back( value );
                    }
                    for( const ammo_character_effect_definition_data &effect : source.on_hit_effects ) {
                        on_hit_effect value;
                        value.effect = efftype_id( effect.effect );
                        value.duration = time_duration::from_turns(
                                             static_cast<int>( effect.duration_turns ) );
                        value.intensity = static_cast<int>( effect.intensity_min );
                        value.need_touch_skin = effect.touch_skin;
                        native.on_hit_effects.push_back( value );
                    }
                    for( const ammo_character_effect_definition_data &effect : source.area_effects ) {
                        aoe_effect value;
                        value.effect = efftype_id( effect.effect );
                        value.duration = time_duration::from_turns(
                                             static_cast<int>( effect.duration_turns ) );
                        value.intensity_min = static_cast<int>( effect.intensity_min );
                        value.intensity_max = static_cast<int>( effect.intensity_max );
                        value.chance = static_cast<int>( effect.chance );
                        value.radius = static_cast<int>( effect.radius );
                        value.hits_amount = { static_cast<int>( effect.hits_min ),
                                              static_cast<int>( effect.hits_max )
                                            };
                        value.all_bp = effect.all_body_parts;
                        native.aoe_effects.push_back( std::move( value ) );
                    }
                    if( source.has_explosion ) {
                        native.aoe_explosion_data.power = static_cast<float>( source.explosion_power );
                        native.aoe_explosion_data.distance_factor =
                            static_cast<float>( source.explosion_distance_factor );
                        native.aoe_explosion_data.max_noise = static_cast<int>( source.explosion_max_noise );
                        native.aoe_explosion_data.fire = source.explosion_fire;
                        native.aoe_explosion_data.light_effect = explosion_light_str_id( source.explosion_light );
                        if( source.has_shrapnel ) {
                            native.aoe_explosion_data.shrapnel = shrapnel_data(
                                    static_cast<int>( source.casing_mass ),
                                    static_cast<float>( source.fragment_mass ),
                                    static_cast<int>( source.fragment_recovery ),
                                    itype_id( source.fragment_drop ) );
                        }
                    }
                    native.do_flashbang = source.flashbang;
                    native.do_emp_blast = source.emp;
                    native.foamcrete_build = source.foamcrete;
                    native.always_cast_spell = source.cast_spells_on_miss;
                    for( const ammo_spell_definition_data &spell_source : source.spells ) {
                        fake_spell spell( spell_id( spell_source.spell ), spell_source.self );
                        spell.level = static_cast<int>( spell_source.level );
                        native.spell_data.push_back( std::move( spell ) );
                    }
                    get_all_ammo_effects().insert( native );
                }
                if( !pimpl_->ammo_effects.empty() ) {
                    get_all_ammo_effects().finalize();
                }
                break;
            }
            case items_content_apply_phase::metadata: {
                for( const scent_type_registration &entry : pimpl_->scent_types ) {
                    const scenttype_id id( entry.definition->id );
                    pimpl_->scent_type_undo.emplace_back(
                        id, id.is_valid() ? std::optional<scent_type>( id.obj() ) : std::nullopt );
                    scent_type native;
                    native.id = id;
                    native.was_loaded = true;
                    native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                    for( const std::string &species : entry.definition->receptive_species ) {
                        native.receptive_species.insert( species_id( species ) );
                    }
                    detail::scent_type_registry().insert( native );
                }
                for( const butchery_requirement_registration &entry : pimpl_->butchery_requirement_entries ) {
                    const string_id<butchery_requirements> id( entry.definition->id );
                    pimpl_->butchery_requirements_undo.emplace_back(
                        id, id.is_valid() ? std::optional<butchery_requirements>( id.obj() ) : std::nullopt );
                    butchery_requirements native;
                    native.id = id;
                    native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                    native.was_loaded = true;
                    for( const auto &requirement : entry.definition->entries ) {
                        native.requirements[static_cast<float>( requirement.speed )]
                        [*platform_creature_size( requirement.size )]
                        [*platform_butcher_type( requirement.butcher )] =
                            requirement_id( requirement.requirement );
                    }
                    detail::butchery_requirements_registry().insert( native );
                }
                for( const item_action_registration &entry : pimpl_->item_actions ) {
                    const item_action_definition_data &source = *entry.definition;
                    const item_action *previous = detail::item_action_registry_find( source.id );
                    pimpl_->item_action_undo.emplace_back(
                        source.id, previous == nullptr ? std::optional<item_action>() :
                        std::optional<item_action>( *previous ) );
                    item_action native;
                    native.id = source.id;
                    native.name = source.name.native();
                    detail::item_action_registry_set( native );
                }
                break;
            }
            case items_content_apply_phase::item_groups: {
                for( const item_group_registration &entry : pimpl_->item_groups ) {
                    const item_group_id id( entry.definition->id );
                    auto previous = item_controller->m_template_groups.find( id );
                    const item_group_definition_data &source = *entry.definition;
                    const Item_group::Type kind = source.kind == "collection" ?
                                                  Item_group::G_COLLECTION : Item_group::G_DISTRIBUTION;
                    std::unique_ptr<Item_group> replacement;
                    Item_group *native = nullptr;
                    if( entry.operation == definition_operation::extend ) {
                        native = previous == item_controller->m_template_groups.end() ?
                                 nullptr : dynamic_cast<Item_group *>( previous->second.get() );
                        if( native == nullptr || native->type != kind ) {
                            throw std::runtime_error( "cannot extend missing or mismatched item group '" +
                                                      source.id + "'" );
                        }
                        pimpl_->item_group_extension_undo.emplace_back( id, native->entry_count() );
                    } else {
                        std::unique_ptr<Item_spawn_data> snapshot;
                        if( previous != item_controller->m_template_groups.end() ) {
                            snapshot = std::move( previous->second );
                        }
                        pimpl_->item_group_undo.emplace_back( id, std::move( snapshot ) );
                        replacement = std::make_unique<Item_group>(
                                          kind, 100, static_cast<int>( source.with_ammo ),
                                          static_cast<int>( source.with_magazine ),
                                          "Lua-first item group " + source.id );
                        if( source.container ) {
                            replacement->container_item = itype_id( *source.container );
                        }
                        replacement->container_item_variant = source.container_variant;
                        replacement->on_overflow = source.overflow;
                        replacement->sealed = source.sealed;
                        native = replacement.get();
                    }
                    const auto load_reference = []( const item_group_reference &reference,
                    const Item_group &parent, const std::string &context ) {
                        auto result = std::make_unique<Single_item_creator>(
                                          reference.id, reference.group ? Single_item_creator::S_ITEM_GROUP :
                                          Single_item_creator::S_ITEM, 100, context );
                        result->inherit_ammo_mag_chances( parent.with_ammo, parent.with_magazine );
                        return result;
                    };
                    const auto load_contents = [&load_reference]( const std::vector<item_group_reference> &contents,
                    const Item_group &parent ) -> std::unique_ptr<Item_spawn_data> {
                        const std::string context = "contents of " + parent.context();
                        if( contents.size() == 1 ) {
                            return load_reference( contents.front(), parent, context );
                        }
                        auto result = std::make_unique<Item_group>( Item_group::G_COLLECTION, 100,
                                      parent.with_ammo, parent.with_magazine, context );
                        for( const item_group_reference &child : contents ) {
                            if( child.group ) {
                                result->add_group_entry( item_group_id( child.id ), 100 );
                            } else {
                                result->add_item_entry( itype_id( child.id ), 100 );
                            }
                        }
                        return result;
                    };
                    const auto append_entries = [&]( const auto &self, Item_group &parent,
                    const std::vector<item_group_entry_definition_data> &entries ) -> void {
                        for( const item_group_entry_definition_data &source_entry : entries ) {
                            if( source_entry.subgroup ) {
                                auto subgroup = std::make_unique<Item_group>(
                                                    *source_entry.subgroup, static_cast<int>( source_entry.probability ),
                                                    parent.with_ammo, parent.with_magazine, parent.context(), source_entry.event );
                                self( self, *subgroup, source_entry.children );
                                parent.add_entry( std::move( subgroup ) );
                                continue;
                            }
                            const Single_item_creator::Type entry_type = source_entry.group ?
                                    Single_item_creator::S_ITEM_GROUP : Single_item_creator::S_ITEM;
                            // The native finalizer applies blacklists and migrations after all Mods
                            // have loaded. Replacing or skipping here would change the spawn pool.
                            auto native_entry = std::make_unique<Single_item_creator>(
                                                    source_entry.id, entry_type,
                                                    static_cast<int>( source_entry.probability ),
                                                    "Lua-first item-group entry " + source.id, source_entry.event );
                            native_entry->active = source_entry.active;
                            if( source_entry.artifact ) {
                                native_entry->artifact = cata::make_value<Item_spawn_data::relic_generator>(
                                                             *source_entry.artifact );
                            }
                            if( !source_entry.components.empty() ) {
                                auto &components = native_entry->components_items.emplace();
                                components.reserve( source_entry.components.size() );
                                for( const std::string &component : source_entry.components ) {
                                    components.emplace_back( component );
                                }
                            }
                            if( source_entry.count_specified || source_entry.variant_specified || !source_entry.variant.empty() ||
                                source_entry.charges_specified || source_entry.container || source_entry.ammo ||
                                source_entry.sealed || source_entry.damage || source_entry.dirt ||
                                source_entry.variables || !source_entry.flags.empty() || !source_entry.contents.empty() ) {
                                native_entry->modifier.emplace();
                                native_entry->modifier->count = {
                                    static_cast<int>( source_entry.count_min ),
                                    static_cast<int>( source_entry.count_max )
                                };
                                native_entry->modifier->variant = source_entry.variant;
                                native_entry->modifier->charges = {
                                    static_cast<int>( source_entry.charges_min ),
                                    static_cast<int>( source_entry.charges_max )
                                };
                                if( source_entry.damage ) {
                                    native_entry->modifier->damage = {
                                        source_entry.damage->first * itype::damage_scale,
                                        source_entry.damage->second * itype::damage_scale
                                    };
                                }
                                if( source_entry.dirt ) {
                                    native_entry->modifier->dirt = *source_entry.dirt;
                                }
                                if( !source_entry.contents.empty() ) {
                                    native_entry->modifier->contents = load_contents( source_entry.contents, parent );
                                }
                                if( source_entry.container ) {
                                    native_entry->modifier->container = load_reference( *source_entry.container, parent,
                                                                        "container of " + parent.context() );
                                }
                                if( source_entry.ammo ) {
                                    native_entry->modifier->ammo = load_reference( *source_entry.ammo, parent,
                                                                   "ammo of " + parent.context() );
                                }
                                if( source_entry.sealed ) {
                                    native_entry->modifier->sealed = *source_entry.sealed;
                                }
                                for( const std::string &flag : source_entry.flags ) {
                                    native_entry->modifier->custom_flags.emplace_back( flag );
                                }
                                if( source_entry.variables ) {
                                    native_entry->modifier->item_vars.insert( source_entry.variables->begin(),
                                            source_entry.variables->end() );
                                }
                            }
                            if( source_entry.wrapper ) {
                                native_entry->container_item = itype_id( *source_entry.wrapper );
                                native_entry->container_item_variant = source_entry.wrapper_variant;
                            }
                            parent.add_entry( std::move( native_entry ) );
                        }
                    };
                    append_entries( append_entries, *native, source.entries );
                    if( replacement ) {
                        item_controller->m_template_groups[id] = std::move( replacement );
                    }
                }
                break;
            }
            case items_content_apply_phase::requirements: {
                pimpl_->requirement_changes = !pimpl_->requirements.empty();
                for( const requirement_registration &entry : pimpl_->requirements ) {
                    const requirement_id id( entry.definition->id );
                    const auto previous = requirement_data::registry().find( id );
                    pimpl_->requirement_undo.emplace_back(
                        id, previous == requirement_data::registry().end() ?
                        std::optional<requirement_data>() : std::optional<requirement_data>( previous->second ) );
                    const requirement_definition_data &source = *entry.definition;
                    requirement_source_layer native = native_requirement_layer( source, pimpl_->owner );
                    native.definition.id_ = id;
                    native.definition.name_ = source.name.native();
                    requirement_data::register_requirement_layer( std::move( native ) );
                }
                break;
            }
            case items_content_apply_phase::recipe_groups: {
                for( const recipe_group_registration &entry : pimpl_->recipe_groups ) {
                    pimpl_->recipe_group_undo.emplace_back(
                        entry.definition->id, detail::recipe_group_get( entry.definition->id ) );
                    detail::recipe_group_native_definition native;
                    native.id = entry.definition->id;
                    native.building_type = entry.definition->building_type;
                    native.sources.emplace_back( native.id, mod_id( pimpl_->owner ) );
                    for( const recipe_group_recipe_data &recipe_entry : entry.definition->recipes ) {
                        detail::recipe_group_recipe_definition native_recipe;
                        native_recipe.id = recipe_entry.id;
                        native_recipe.description = recipe_entry.description.native();
                        for( const recipe_group_terrain_data &terrain : recipe_entry.terrains ) {
                            detail::recipe_group_terrain_definition native_terrain;
                            native_terrain.overmap_terrain = terrain.overmap_terrain;
                            native_terrain.match_type = terrain.match_type;
                            native_terrain.parameters = terrain.parameters;
                            native_recipe.overmap_terrains.push_back( std::move( native_terrain ) );
                        }
                        native.recipes.push_back( std::move( native_recipe ) );
                    }
                    detail::recipe_group_set( native );
                }
                break;
            }
            case items_content_apply_phase::definitions: {
                generic_factory<itype> &factory = item_controller->get_generic_factory();
                std::vector<std::size_t> item_order;
                std::string inheritance_error;
                if( !detail::resolve_platform_inheritance_order( pimpl_->items,
                []( const item_registration & entry ) {
                return entry.definition->id;
            },
            []( const item_registration & entry ) {
                return entry.definition->copy_from;
            },
            [&factory]( const std::string & id ) {
                return factory.is_valid( itype_id( id ) ) || factory.find_abstract( id ) != nullptr;
                }, item_order, inheritance_error, "item" ) ) {
                    throw std::runtime_error( inheritance_error );
                }
                for( const std::size_t index : item_order ) {
                    const item_registration &entry = pimpl_->items[index];
                    const item_definition_data &definition = *entry.definition;
                    const itype_id id( definition.id );
                    std::unique_ptr<itype> native;
                    if( definition.copy_from.empty() ) {
                        native = std::make_unique<itype>();
                    } else {
                        const itype_id source_id( definition.copy_from );
                        const itype *const source = factory.is_valid( source_id ) ?
                                                    &factory.obj( source_id ) : factory.find_abstract( definition.copy_from );
                        if( source == nullptr ) {
                            throw std::runtime_error( "item '" + definition.id +
                                                      "' lost its copy-from source '" +
                                                      definition.copy_from + "' while being applied" );
                        }
                        native = std::make_unique<itype>( *source );
                    }
                    native->id = id;
                    if( definition.has_name ) {
                        native->name = definition.translated_name ? definition.translated_name->native() :
                                       no_translation( definition.name );
                        if( definition.translated_name ) {
                            native->name.make_plural();
                        }
                    }
                    if( definition.has_description ) {
                        native->description = definition.translated_description ?
                                              definition.translated_description->native() : no_translation( definition.description );
                    }
                    if( definition.has_symbol ) {
                        native->sym = definition.symbol;
                    }
                    if( definition.has_mass ) {
                        native->weight = definition.mass_milligrams ?
                                         units::from_milligram<std::int64_t>( *definition.mass_milligrams ) :
                                         units::from_gram<std::int64_t>( definition.mass_grams );
                    }
                    if( definition.has_volume ) {
                        native->volume = units::from_milliliter<std::int64_t>( definition.volume_ml );
                    }
                    if( definition.longest_side ) {
                        native->longest_side = *definition.longest_side;
                    }
                    if( definition.has_price ) {
                        native->price = units::from_cent<std::int64_t>( definition.price_cents );
                    }
                    if( definition.has_price_postapoc ) {
                        native->price_post = units::from_cent<std::int64_t>( definition.price_postapoc_cents );
                    }
                    if( definition.has_color ) {
                        native->color = color_from_string( definition.color, report_color_error::no );
                    }
                    if( definition.has_category ) {
                        native->category_force = item_category_id( definition.category );
                    }
                    if( definition.stackable ) {
                        native->stackable_ = *definition.stackable;
                    }
                    if( definition.stack_size ) {
                        native->stack_size = static_cast<int>( *definition.stack_size );
                    }
                    if( definition.light ) {
                        native->light_emission = static_cast<unsigned>( *definition.light );
                    }
                    if( definition.max_worn ) {
                        native->max_worn = static_cast<int>( *definition.max_worn );
                    }
                    if( definition.insulation ) {
                        native->insulation_factor = static_cast<float>( *definition.insulation );
                    }
                    if( definition.phase ) {
                        native->phase = *definition.phase;
                    }
                    if( definition.display_type ) {
                        native->display_type = *definition.display_type;
                    } else if( definition.copy_from.empty() && native->phase == phase_id::LIQUID &&
                               native->volume > 0_ml && get_option<bool>( "SMART_DEFAULT_DISPLAY_TYPE" ) ) {
                        native->display_type = item_display_type::BY_VOLUME;
                    }
                    if( definition.fall_damage_reduction ) {
                        native->fall_damage_reduction = *definition.fall_damage_reduction;
                    }
                    if( definition.repair_like ) {
                        native->repairs_like = *definition.repair_like;
                    }
                    if( definition.source_monster ) {
                        native->source_monster = *definition.source_monster;
                    }
                    if( definition.field_emissions ) {
                        native->emits.clear();
                        for( const std::string &emission : *definition.field_emissions ) {
                            native->emits.emplace( emission );
                        }
                    }
                    if( definition.repair_materials ) {
                        native->repairs_with.clear();
                        for( const std::string &material : *definition.repair_materials ) {
                            native->repairs_with.emplace( material );
                        }
                    }
                    if( definition.expand_snippets ) {
                        native->expand_snippets = *definition.expand_snippets;
                    }
                    native->set_degradation_multiplier( 1.0f );
                    if( definition.has_looks_like ) {
                        // Tileset fallback keys can name sprites without registered item types.
                        native->looks_like = itype_id( definition.looks_like );
                    }
                    if( definition.ascii_picture ) {
                        native->picture_id = ascii_art_id( *definition.ascii_picture );
                    }
                    if( definition.snippet_category ) {
                        native->snippet_category = *definition.snippet_category;
                    }
                    if( definition.melee_to_hit ) {
                        native->m_to_hit = static_cast<int>( *definition.melee_to_hit );
                    }
                    apply_item_adjustment( native->weight, definition.measurements.mass );
                    apply_item_adjustment( native->volume, definition.measurements.volume );
                    apply_item_adjustment( native->longest_side, definition.measurements.length );
                    apply_item_adjustment( native->price, definition.measurements.price );
                    apply_item_adjustment( native->price_post, definition.measurements.postapoc_price );
                    if( definition.measurements.accuracy ) {
                        native->m_to_hit = apply_item_adjustment( native->m_to_hit, *definition.measurements.accuracy );
                    }
                    if( definition.mounted_charge || definition.clear_mounted_charge ) {
                        native->mounted_charge = definition.mounted_charge;
                    }
                    for( const auto &[fault, weight] : definition.faults ) {
                        native->faults.add( fault, weight );
                    }
                    native->fault_groups.insert( native->fault_groups.end(), definition.fault_groups.begin(),
                                                 definition.fault_groups.end() );
                    if( definition.electronic_size_kb ) {
                        native->ememory_size = units::from_kilobytes(
                                                   static_cast<units::ememory::value_type>( *definition.electronic_size_kb ) );
                    }
                    if( definition.throwing_damage ) {
                        native->thrown_damage = *definition.throwing_damage;
                    }
                    if( definition.throwing_recovery_chance ) {
                        native->thrown_recovery_chance = *definition.throwing_recovery_chance;
                    }
                    if( definition.replace_throw_correction ) {
                        native->throw_correction = definition.throw_correction;
                    }
                    if( definition.minimum_skills ) {
                        native->min_skills = *definition.minimum_skills;
                    }
                    if( definition.conditional_names ) {
                        native->conditional_names.clear();
                        native->conditional_names.reserve( definition.conditional_names->size() );
                        for( const auto &rule : *definition.conditional_names ) {
                            translation label = rule.name.native();
                            label.make_plural();
                            native->conditional_names.push_back( {
                                rule.kind, rule.key, rule.value, std::move( label )
                            } );
                        }
                    }
                    if( definition.variant_kind ) {
                        native->variant_kind = *definition.variant_kind;
                    }
                    if( definition.variants ) {
                        native->variants.clear();
                        for( const auto &variant : *definition.variants ) {
                            itype_variant_data value;
                            value.id = variant.id;
                            value.alt_name = variant.name.native();
                            value.alt_name.make_plural();
                            value.alt_description = variant.description.native();
                            value.alt_sym = variant.symbol;
                            if( variant.color ) {
                                value.alt_color = color_from_string( *variant.color, report_color_error::no );
                            }
                            value.art = ascii_art_id( variant.ascii_picture );
                            value.weight = static_cast<int>( variant.weight );
                            value.append = variant.append;
                            value.expand_snippets = variant.expand_snippets;
                            native->variants.push_back( std::move( value ) );
                        }
                    }
                    if( definition.default_container ) {
                        native->default_container = itype_id( *definition.default_container );
                        native->default_container_variant.reset();
                    }
                    native->was_loaded = true;
                    native->src.clear();
                    native->src.emplace_back( id, mod_id( pimpl_->owner ) );
                    if( !definition.materials.empty() ) {
                        native->materials.clear();
                        native->mat_portion_total = 0;
                        for( const material_part &material : definition.materials ) {
                            native->materials[material_id( material.id )] += static_cast<int>( material.portions );
                            native->mat_portion_total += static_cast<int>( material.portions );
                        }
                        native->default_mat = native->materials.begin()->first;
                    }
                    if( native->materials.empty() ) {
                        native->default_mat = material_id::NULL_ID();
                    }
                    if( definition.replace_qualities ) {
                        native->qualities.clear();
                    }
                    for( const quality_level &quality : definition.qualities ) {
                        native->qualities[quality_id( quality.id )] = {
                            static_cast<int>( quality.level ), quality.speed
                        };
                    }
                    if( definition.charged_qualities ) {
                        native->charged_qualities.clear();
                        for( const quality_level &quality : *definition.charged_qualities ) {
                            native->charged_qualities.emplace( quality_id( quality.id ),
                                    itype::item_quality{ static_cast<int>( quality.level ), quality.speed } );
                        }
                    }
                    for( const auto &[quality, offset] : definition.quality_adjustments ) {
                        const auto existing_quality = native->qualities.find( quality );
                        if( existing_quality == native->qualities.end() ) {
                            throw std::runtime_error( "item '" + definition.id +
                                                      "' cannot adjust missing quality '" + quality.str() + "'" );
                        }
                        int &level = existing_quality->second.level;
                        level = item_option_int( static_cast<std::int64_t>( level ) + offset,
                                                 "adjusted quality level" );
                    }
                    if( definition.removed_qualities ) {
                        for( const std::string &quality : *definition.removed_qualities ) {
                            if( native->qualities.erase( quality_id( quality ) ) == 0 ) {
                                throw std::runtime_error( "item '" + definition.id +
                                                          "' cannot remove missing quality '" + quality + "'" );
                            }
                        }
                    }
                    if( definition.techniques ) {
                        native->techniques.clear();
                        for( const std::string &id : *definition.techniques ) {
                            native->techniques.emplace( id );
                        }
                    }
                    if( definition.removed_techniques ) {
                        for( const std::string &technique : *definition.removed_techniques ) {
                            if( native->techniques.erase( matec_id( technique ) ) == 0 ) {
                                throw std::runtime_error( "item '" + definition.id +
                                                          "' cannot remove missing technique '" + technique + "'" );
                            }
                        }
                    }
                    if( definition.weapon_categories ) {
                        native->weapon_category.clear();
                        for( const std::string &id : *definition.weapon_categories ) {
                            native->weapon_category.emplace( id );
                        }
                    }
                    if( definition.clear_flags ) {
                        native->item_tags.clear();
                    }
                    for( const std::string &flag : definition.flags ) {
                        native->item_tags.insert( flag_id( flag ) );
                    }
                    if( definition.has_tool && !native->tool ) {
                        native->tool = cata::make_value<islot_tool>();
                        native->tool->was_loaded = true;
                    }
                    if( definition.tool ) {
                        const auto &tool = *definition.tool;
                        if( tool.ammo_types ) {
                            native->tool->ammo_id.clear();
                            for( const std::string &ammo : *tool.ammo_types ) {
                                native->tool->ammo_id.insert( ammotype( ammo ) );
                            }
                        }
                        for( const auto &setting : item_definition_data::tool_data::charge_settings ) {
                            if( const auto &charge = tool.*setting.authored ) {
                                ( *native->tool ).*setting.native = *charge;
                            }
                        }
                        if( tool.power_draw ) {
                            native->tool->power_draw = *tool.power_draw;
                        }
                        if( tool.subtype ) {
                            native->tool->subtype = *tool.subtype;
                        }
                        if( tool.revert_message ) {
                            native->tool->revert_msg = tool.revert_message->native();
                        }
                    }
                    if( definition.replace_pockets ) {
                        native->pockets.clear();
                    }
                    for( const auto &pocket : definition.pockets ) {
                        native->pockets.push_back( pocket.native );
                    }
                    if( definition.has_armor && !native->armor ) {
                        native->armor = cata::make_value<islot_armor>();
                        native->armor->was_loaded = true;
                    }
                    if( definition.armor ) {
                        if( definition.armor->warmth ) {
                            native->armor->warmth = static_cast<int>( *definition.armor->warmth );
                        }
                        if( definition.armor->max_worn ) {
                            native->max_worn = static_cast<int>( *definition.armor->max_worn );
                        }
                    }
                    for( const auto &portion : definition.armor_portions ) {
                        armor_portion_data data;
                        data.covers = body_part_set();
                        for( const std::string &part : portion.covers ) {
                            data.covers->set( bodypart_str_id( part ) );
                        }
                        for( const std::string &part : portion.sub_parts ) {
                            data.sub_coverage.insert( sub_bodypart_str_id( part ) );
                        }
                        data.encumber = static_cast<int>( portion.encumbrance );
                        data.coverage = static_cast<int>( portion.coverage );
                        data.cover_melee = data.coverage;
                        data.cover_ranged = data.coverage;
                        data.avg_thickness = static_cast<float>( portion.material_thickness );
                        data.env_resist = static_cast<int>( portion.environmental_protection );
                        for( const std::string &material : portion.materials ) {
                            data.materials.emplace_back( material_id( material ), 100, 0.0f );
                        }
                        native->armor->sub_data.push_back( std::move( data ) );
                    }
                    if( !definition.ammo_pocket.empty() ) {
                        pocket_data pocket( pocket_type::MAGAZINE );
                        pocket.was_loaded = true;
                        for( const auto &[ammo, capacity] : definition.ammo_pocket ) {
                            pocket.ammo_restriction.emplace( ammotype( ammo ), static_cast<int>( capacity ) );
                        }
                        native->pockets.push_back( std::move( pocket ) );
                    }
                    for( const std::string &name : definition.passive_enchantments ) {
                        const enchantment_id id( name );
                        if( !id.is_valid() ) {
                            throw std::runtime_error( "item '" + definition.id +
                                                      "' references unknown passive enchantment '" + name + "'" );
                        }
                        if( !native->relic_data ) {
                            native->relic_data = cata::make_value<relic>();
                            // Fresh authored relics use the same activation cost as relic::load.
                            native->relic_data->moves = 100;
                            native->relic_data->was_loaded = true;
                        }
                        // Match relic::finalize, including anonymous passives stored on each item.
                        if( id->item_instance ) {
                            native->relic_data->add_passive_effect( enchant_cache::from_item_definition( id.obj() ) );
                        } else {
                            native->relic_data->add_passive_effect( id.obj() );
                        }
                    }
                    if( definition.ammunition ) {
                        const item_definition_data::ammunition_data &ammo = *definition.ammunition;
                        if( !native->ammo ) {
                            native->ammo = cata::make_value<islot_ammo>();
                        }
                        native->ammo->type = ammotype( ammo.type );
                        if( ammo.count ) {
                            native->ammo->def_charges = static_cast<int>( *ammo.count );
                        }
                        if( ammo.stack_size ) {
                            native->ammo->stack_size = static_cast<int>( *ammo.stack_size );
                        }
                        if( ammo.damage ) {
                            native->ammo->damage = *ammo.damage;
                        }
                        if( ammo.dispersion ) {
                            native->ammo->dispersion = *ammo.dispersion;
                        }
                        if( ammo.loudness ) {
                            native->ammo->loudness = *ammo.loudness;
                        }
                        if( ammo.recovery_chance ) {
                            native->ammo->recovery_chance = *ammo.recovery_chance;
                        }
                        native->ammo->was_loaded = true;
                    }
                    if( entry.definition->comestible ) {
                        const item_definition_data::comestible_data &source =
                            *entry.definition->comestible;
                        native->book.reset();
                        native->comestible = cata::make_value<islot_comestible>();
                        native->comestible->was_loaded = true;
                        native->comestible->comesttype = source.type;
                        native->comestible->def_charges = static_cast<int>( source.charges );
                        native->comestible->stack_size = static_cast<int>( source.stack_size );
                        native->comestible->quench = static_cast<int>( source.quench );
                        native->comestible->healthy = static_cast<int>( source.healthy );
                        native->comestible->freeze_point = static_cast<float>( source.freezing_point_celsius );
                        native->comestible->spoils = time_duration::from_turns(
                                                         static_cast<int>( source.spoils_in_turns ) );
                        native->comestible->set_fun( static_cast<int>( source.fun ) );
                        nutrients nutrition;
                        nutrition.calories = source.calories * 1000;
                        for( const auto &[vitamin_key, amount] : source.vitamins ) {
                            nutrition.set_vitamin( vitamin_id( vitamin_key ),
                                                   static_cast<int>( amount ) );
                        }
                        native->comestible->set_default_nutrition( std::move( nutrition ) );
                    }
                    if( entry.definition->book ) {
                        const item_definition_data::book_data &source = *entry.definition->book;
                        native->comestible.reset();
                        native->book = cata::make_value<islot_book>();
                        native->book->was_loaded = true;
                        native->book->skill = source.skill.empty() ? skill_id::NULL_ID() :
                                               skill_id( source.skill );
                        native->book->martial_art = source.martial_art.empty() ? matype_id::NULL_ID() :
                                                    matype_id( source.martial_art );
                        native->book->req = static_cast<int>( source.required_level );
                        native->book->level = static_cast<int>( source.maximum_level );
                        native->book->intel = static_cast<int>( source.intelligence );
                        native->book->time = time_duration::from_turns(
                                                 static_cast<int>( source.read_time_turns ) );
                        native->book->fun = static_cast<int>( source.fun );
                        native->book->chapters = static_cast<int>( source.chapters );
                        native->book->is_scannable = source.scannable;
                        native->book->generic = source.generic;
                        native->book->proficiencies = source.proficiencies;
                    }
                    if( definition.clear_melee_damage ) {
                        native->melee.damage_map.clear();
                    }
                    for( const auto &[damage, amount] : definition.melee_damage ) {
                        native->melee.damage_map[damage_type_id( damage )] = static_cast<float>( amount );
                    }
                    if( definition.clear_melee_damage || !definition.melee_damage.empty() ) {
                        native->melee.finalize();
                    }
                    if( definition.melee_factors ) {
                        item_melee_damage factors = *definition.melee_factors;
                        factors.finalize();
                        native->melee.scale( factors );
                    }
                    if( definition.melee_bonuses ) {
                        item_melee_damage bonuses = *definition.melee_bonuses;
                        bonuses.finalize();
                        native->melee += bonuses;
                    }
                    if( !definition.magazine_ammo.empty() ) {
                        if( !native->magazine ) {
                            native->magazine = cata::make_value<islot_magazine>();
                        }
                        native->magazine->was_loaded = true;
                        native->magazine->type.clear();
                        native->magazine->capacity = 0;
                        pocket_data pocket( pocket_type::MAGAZINE );
                        for( const auto &[ammo, capacity] : definition.magazine_ammo ) {
                            native->magazine->type.emplace( ammo );
                            native->magazine->capacity = std::max(
                                                             native->magazine->capacity,
                                                             static_cast<int>( capacity ) );
                            pocket.ammo_restriction.emplace(
                                ammotype( ammo ), static_cast<int>( capacity ) );
                        }
                        if( definition.has_magazine_capacity ) {
                            native->magazine->capacity = static_cast<int>( definition.magazine_capacity );
                        }
                        native->pockets.erase( std::remove_if( native->pockets.begin(), native->pockets.end(),
                        []( const pocket_data & value ) {
                            return value.type == pocket_type::MAGAZINE;
                        } ),
                        native->pockets.end() );
                        native->pockets.push_back( std::move( pocket ) );
                    }
                    if( definition.countdown_interval ) {
                        native->countdown_interval = *definition.countdown_interval;
                    }
                    if( definition.transform_result ) {
                        native->transform_into = *definition.transform_result;
                    }
                    if( definition.clear_use_actions ) {
                        native->use_methods.clear();
                    }
                    for( const auto *action : { &definition.transform_use, &definition.delayed_transform_use } ) {
                        if( *action ) {
                            auto actor = make_item_transform_actor( **action );
                            const std::string type = actor->type;
                            if( ( *action )->ammo_scale ) {
                                native->ammo_scale.emplace( type, *( *action )->ammo_scale );
                            }
                            native->use_methods.insert_or_assign( type, use_function( std::move( actor ) ) );
                        }
                    }
                    for( const std::string &action : definition.native_use_actions ) {
                        native->use_methods.insert_or_assign( action, Item_factory::usage_from_string( action ) );
                    }
                    if( !definition.deploy_appliance.empty() ) {
                        auto actor = std::make_unique<deploy_appliance_actor>();
                        actor->appliance_base = itype_id( definition.deploy_appliance );
                        native->use_methods.insert_or_assign( "deploy_appliance", use_function( std::move( actor ) ) );
                    }
                    if( definition.reveal_map ) {
                        const auto &reveal = *definition.reveal_map;
                        auto actor = std::make_unique<reveal_map_actor>();
                        actor->radius = static_cast<int>( reveal.radius );
                        actor->atlas_jurisdiction = reveal.atlas_jurisdiction;
                        actor->omt_types = reveal.terrains;
                        actor->message = reveal.message.native();
                        native->use_methods.insert_or_assign( "reveal_map", use_function( std::move( actor ) ) );
                    }
                    if( !definition.learned_spells.empty() ) {
                        auto actor = std::make_unique<learn_spell_actor>();
                        actor->spells = definition.learned_spells;
                        native->use_methods.insert_or_assign( "learn_spell", use_function( std::move( actor ) ) );
                    }
                    if( definition.martial_arts_manual ) {
                        native->use_methods.insert_or_assign( "MA_MANUAL",
                                Item_factory::usage_from_string( "MA_MANUAL" ) );
                    }
                    if( !definition.deploy_furniture.empty() ) {
                        auto actor = std::make_unique<deploy_furn_actor>();
                        actor->furn_type = furn_str_id( definition.deploy_furniture );
                        native->use_methods.insert_or_assign( "deploy_furn", use_function( std::move( actor ) ) );
                    }
                    if( !definition.capture_size.empty() ) {
                        native->properties["creature_size_capacity"] = definition.capture_size;
                        native->use_methods.insert_or_assign( "CAPTURE_MONSTER_ACT",
                                Item_factory::usage_from_string( "CAPTURE_MONSTER_ACT" ) );
                    }
                    if( definition.healing ) {
                        native->use_methods.insert_or_assign( "heal",
                                use_function( std::make_unique<heal_actor>( *definition.healing ) ) );
                    }
                    if( definition.use_message ) {
                        auto actor = std::make_unique<message_iuse>();
                        actor->name = definition.use_message->name.native();
                        actor->message = definition.use_message->message.native();
                        native->use_methods.insert_or_assign( "message", use_function( std::move( actor ) ) );
                    }
                    if( definition.spell_use ) {
                        native->use_methods.insert_or_assign( "cast_spell",
                                use_function( std::make_unique<cast_spell_actor>( *definition.spell_use ) ) );
                    }
                    if( definition.cable_link ) {
                        const auto &link = *definition.cable_link;
                        if( link.ammo_scale ) {
                            native->ammo_scale.emplace( "link_up", *link.ammo_scale );
                        }
                        native->use_methods.insert_or_assign( "link_up",
                                use_function( std::make_unique<link_up_actor>( link.actor ) ) );
                    }
                    if( definition.play_instrument ) {
                        native->use_methods.insert_or_assign( "play_instrument",
                                use_function( std::make_unique<play_instrument_iuse>() ) );
                    }
                    if( !definition.assembled_belt.is_empty() ) {
                        auto actor = std::make_unique<ammobelt_actor>();
                        actor->belt = definition.assembled_belt;
                        native->use_methods.insert_or_assign( "ammobelt", use_function( std::move( actor ) ) );
                    }
                    if( definition.activation ) {
                        const auto &source = *definition.activation;
                        auto actor = std::make_unique<consume_drug_iuse>();
                        actor->activation_message = source.message.native();
                        actor->moves = static_cast<int>( source.move_cost );
                        for( const auto &effect : source.effects ) {
                            const efftype_id effect_id( effect.id );
                            if( !effect_id.is_valid() ) {
                                throw std::runtime_error( "item '" + definition.id +
                                                          "' activates unknown effect '" + effect.id + "'" );
                            }
                            iuse::effect_data native_effect( effect_id,
                                    time_duration::from_turns( static_cast<int>( effect.duration_turns ) ),
                                    bodypart_str_id::NULL_ID().id(), effect.permanent );
                            native_effect.intensity = static_cast<int>( effect.intensity );
                            actor->effects.push_back( std::move( native_effect ) );
                        }
                        native->use_methods.insert_or_assign( "consume_drug", use_function( std::move( actor ) ) );
                    }
                    if( !definition.use_handler.empty() ) {
                        const std::string action_id = "lua_platform:" + pimpl_->owner + ":" +
                                                      definition.use_handler;
                        native->use_methods.emplace(
                            action_id,
                            use_function( std::make_unique<lua_platform_iuse_actor>(
                                              pimpl_->owner, definition.use_handler, definition.use_label,
                                              definition.use_description ) ) );
                    }
                    if( definition.clear_tick_actions ) {
                        native->tick_action.clear();
                    }
                    for( const std::string &action : definition.native_tick_actions ) {
                        native->tick_action.insert_or_assign( action, Item_factory::usage_from_string( action ) );
                    }
                    if( definition.tick_transform ) {
                        const item_transform_action &transform = *definition.tick_transform;
                        if( transform.ammo_scale ) {
                            native->ammo_scale.emplace( "transform", *transform.ammo_scale );
                        }
                        native->tick_action.insert_or_assign( "transform",
                                use_function( make_item_transform_actor( transform ) ) );
                    }
                    if( definition.tick_sound ) {
                        native->tick_action.insert_or_assign( "sound",
                                use_function( std::make_unique<sound_iuse>( definition.tick_sound->actor ) ) );
                    }
                    if( definition.tick_music ) {
                        native->tick_action.insert_or_assign( "musical_instrument",
                                use_function( std::make_unique<musical_instrument_actor>( definition.tick_music->actor ) ) );
                    }
                    if( const auto *action = std::get_if<std::string>( &definition.expiry_action ) ) {
                        native->countdown_action = Item_factory::usage_from_string( *action );
                    } else if( const auto *spell = std::get_if<cast_spell_actor>( &definition.expiry_action ) ) {
                        native->countdown_action = use_function( std::make_unique<cast_spell_actor>( *spell ) );
                    }
                    if( !definition.tick_handler.empty() ) {
                        const std::string action_id = "lua_platform:" + pimpl_->owner + ":" +
                                                      definition.tick_handler;
                        native->tick_action.emplace(
                            action_id,
                            use_function( std::make_unique<lua_platform_iuse_actor>(
                                              pimpl_->owner, definition.tick_handler,
                                              authored_text{ definition.tick_handler, std::nullopt }, std::nullopt ) ) );
                    }
                    if( !definition.consume_handler.empty() ) {
                        if( !native->comestible ) {
                            throw std::runtime_error( "item '" + definition.id +
                                                      "' has on_consume but no comestible slot" );
                        }
                        native->comestible->lua_platform_mod = pimpl_->owner;
                        native->comestible->lua_platform_consume_handler = definition.consume_handler;
                    }
                    for( const auto &[original, replacement] : definition.material_replacements ) {
                        native->replace_material( original, replacement );
                    }
                    if( definition.is_abstract ) {
                        const itype *previous = factory.find_abstract( definition.id );
                        pimpl_->item_abstract_undo.emplace_back(
                            definition.id, previous ? std::optional<itype>( *previous ) : std::nullopt );
                        factory.restore_abstract( *native );
                    } else {
                        pimpl_->item_undo.emplace_back(
                            id, factory.is_valid( id ) ?
                            std::optional<itype>( factory.obj( id ) ) : std::nullopt );
                        // Match native inheritance, migration and item caches.
                        factory.restore( *native );
                        item_controller->m_runtimes_dirty = true;
                        item_controller->templates_all_cache.clear();
                        item_controller->armor_containers.clear();
                    }
                }
                break;
            }
            case items_content_apply_phase::recipes: {
                const DynamicDataLoader &loader = DynamicDataLoader::get_instance();
                const auto owner_order = loader.source_load_order( pimpl_->owner );
                for( recipe_registration &entry : pimpl_->recipes ) {
                    const bool targets_uncraft = entry.definition->uncraft;
                    const recipe_id id( targets_uncraft ? recipe_id( entry.definition->result ) :
                                        recipe_id( entry.definition->id ) );
                    auto &native_dict = targets_uncraft ? recipe_dict.uncraft : recipe_dict.recipes;
                    auto &undo_list = targets_uncraft ? pimpl_->uncraft_undo : pimpl_->recipe_undo;
                    const auto previous = native_dict.find( id );
                    // Lua transactions follow JSON loading. A retirement must keep the normal Mod precedence.
                    entry.shadowed_by_later_source = entry.definition->obsolete &&
                                                   entry.operation == definition_operation::upsert &&
                                                   previous != native_dict.end() && !previous->second.src.empty() &&
                                                   loader.source_load_order( previous->second.src.back().second.str() ) > owner_order;
                    if( entry.shadowed_by_later_source ) {
                        continue;
                    }
                    undo_list.emplace_back(
                        id, previous == native_dict.end() ? std::optional<recipe>() :
                        std::optional<recipe>( previous->second ) );
                    recipe native;
                    native.id = id;
                    if( entry.definition->obsolete ) {
                        native.result_ = itype_id( entry.definition->result );
                        native.obsolete = true;
                        native.was_loaded = true;
                        native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                        native_dict[id] = std::move( native );
                        continue;
                    }
                    native.difficulty = static_cast<int>( entry.definition->difficulty );
                    native.skill_used = entry.definition->skill.empty() ? skill_id::NULL_ID() :
                                        skill_id( entry.definition->skill );
                    for( const auto &[skill, level] : entry.definition->required_skills ) {
                        native.required_skills[skill_id( skill )] = static_cast<int>( level );
                    }
                    if( entry.definition->nested_category ) {
                        native.name_ = entry.definition->name.native();
                        native.description = entry.definition->description.empty() ? translation() :
                                             entry.definition->description.native();
                        native.category = crafting_category_id( entry.definition->category );
                        native.subcategory = entry.definition->subcategory;
                        native.exertion = static_cast<float>( entry.definition->activity_level );
                        native.never_learn = true;
                        for( const auto &member : entry.definition->nested_recipes ) {
                            native.nested_category_data.emplace( member.first );
                        }
                        native.was_loaded = true;
                        native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                        recipe_dict.recipes[id] = std::move( native );
                        continue;
                    }
                    if( !entry.definition->result.empty() ) {
                        native.result_ = itype_id( entry.definition->result );
                    }
                    native.name_ = entry.definition->name.native();
                    native.description = entry.definition->description.native();
                    native.flags = entry.definition->flags;
                    if( entry.definition->result_charges ) {
                        native.charges = static_cast<int>( *entry.definition->result_charges );
                    }
                    native.result_mult = static_cast<int>( entry.definition->result_multiplier );
                    native.time = entry.definition->time_moves;
                    if( !entry.definition->category.empty() ) {
                        native.category = crafting_category_id( entry.definition->category );
                    }
                    native.subcategory = entry.definition->subcategory;
                    native.autolearn = entry.definition->autolearn;
                    native.never_learn = entry.definition->never_learn;
                    for( const auto &[skill, level] : entry.definition->autolearn_skills ) {
                        native.autolearn_requirements.emplace( skill_id( skill ), level );
                    }
                    native.reversible = entry.definition->reversible;
                    native.uncraft_time = entry.definition->disassembly_moves;
                    native.variant_ = entry.definition->variant;
                    native.contained = entry.definition->contained;
                    native.sealed = entry.definition->sealed;
                    if( !entry.definition->container.empty() ) {
                        native.container = itype_id( entry.definition->container );
                    }
                    native.container_variant = entry.definition->container_variant;
                    native.batch_info = entry.definition->batching;
                    for( const auto &[byproduct, count] : entry.definition->byproducts ) {
                        native.byproducts.emplace( itype_id( byproduct ), count );
                    }
                    if( !entry.definition->byproduct_group.empty() ) {
                        native.byproduct_group = item_group_id( entry.definition->byproduct_group );
                    }
                    for( const std::string &flag : entry.definition->removed_result_flags ) {
                        native.flags_to_delete.emplace( flag );
                    }
                    native.morale_modifier = { entry.definition->morale_bonus, entry.definition->morale_duration };
                    native.practice_data = entry.definition->practice;
                    native.character_resources = entry.definition->character_resources;
                    native.character_requirements_ = entry.definition->required_stats;
                    for( const auto &[skill, level] : entry.definition->disassembly_learning ) {
                        native.learn_by_disassembly[skill_id( skill )] = static_cast<int>( level );
                    }
                    native.exertion = static_cast<float>( entry.definition->activity_level );
                    native.was_loaded = true;
                    native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                    native.lua_platform_mod = pimpl_->owner;
                    native.lua_platform_result_handler = entry.definition->result_handler;
                    native.lua_platform_scripted_output = entry.definition->scripted_output;
                    for( const recipe_proficiency_data &source : entry.definition->proficiencies ) {
                        native.proficiencies.push_back( make_recipe_proficiency( source ) );
                    }
                    for( const auto &[book, properties] : entry.definition->books ) {
                        native.booksets.emplace( itype_id( book ), book_recipe_data{
                            properties.level,
                            properties.name.empty() ? std::nullopt : std::make_optional( properties.name.native() ),
                            properties.hidden
                        } );
                    }
                    const requirement_id inline_id = recipe_root_requirement_id( id, *entry.definition );
                    const auto stage_requirements = [&]( const requirement_id & req_id,
                                                         requirement_data inline_requirements ) {
                        const auto old_requirements = requirement_data::registry().find( req_id );
                        pimpl_->recipe_requirement_undo.emplace_back(
                            req_id, old_requirements == requirement_data::registry().end() ?
                            std::nullopt : std::make_optional( old_requirements->second ) );
                        inline_requirements.id_ = req_id;
                        requirement_data::register_requirement_layer( {
                            std::move( inline_requirements ), std::nullopt, pimpl_->owner, !targets_uncraft
                        } );
                        pimpl_->requirement_changes = true;
                    };
                    const auto assign_requirement_sets = []( auto & destination,
                    const recipe_requirement_sets & source ) {
                        for( const auto &[requirement, multiplier] : source ) {
                            destination.emplace_back( requirement_id( requirement ), static_cast<int>( multiplier ) );
                        }
                    };
                    stage_requirements( inline_id, make_recipe_requirements(
                                            entry.definition->tools, entry.definition->qualities, entry.definition->components ) );
                    native.reqs_internal.emplace_back( inline_id, 1 );
                    assign_requirement_sets( native.reqs_external, entry.definition->external_requirements );
                    for( const recipe_step_definition_data &source : entry.definition->steps ) {
                        const requirement_id step_id( inline_id.str() + "_step_" +
                                                      std::to_string( native.steps_.size() ) );
                        stage_requirements( step_id, make_recipe_requirements( source.tools, source.qualities ) );
                        recipe_step &step = native.steps_.emplace_back();
                        step.name = source.name.native();
                        step.time = source.moves;
                        step.exertion = static_cast<float>( source.activity );
                        step.attention = source.attention;
                        step.max_time = source.max_time;
                        step.grace_period = source.grace_period;
                        step.unattend_message = source.unattended_message.native();
                        step.batch_info = source.batching;
                        step.reqs_internal.emplace_back( step_id, 1 );
                        assign_requirement_sets( step.reqs_external, source.requirements );
                        for( const recipe_proficiency_data &proficiency : source.proficiencies ) {
                            step.proficiencies.push_back( make_recipe_proficiency( proficiency ) );
                        }
                    }
                    if( const auto &blueprint = entry.definition->blueprint ) {
                        native.blueprint = update_mapgen_id( blueprint->update );
                        native.bp_name = blueprint->name.native();
                        for( const std::string &resource : blueprint->resources ) {
                            native.bp_resources.emplace_back( resource );
                        }
                        native.bp_provides = blueprint->provides;
                        native.bp_provides.emplace_back( native.result_.str(), 1 );
                        native.bp_requires = blueprint->requires_tokens;
                        native.bp_excludes.emplace_back( native.result_.str(), 1 );
                        native.bp_excludes.insert( native.bp_excludes.end(), blueprint->excludes.begin(),
                                                   blueprint->excludes.end() );
                        for( const auto &[parameter, labels] : blueprint->parameter_labels ) {
                            auto &translations = native.bp_parameter_names[parameter];
                            for( const auto &[value, label] : labels ) {
                                translations.emplace( value, label.native() );
                            }
                        }
                        native.check_blueprint_needs = blueprint->check_needs;
                        native.bp_autocalc = blueprint->check_needs && !blueprint->needs;
                        if( native.bp_parameter_names.empty() ) {
                            native.bp_build_reqs = cata::make_value<parameterized_build_reqs>();
                            build_reqs &requirements = native.bp_build_reqs->reqs_by_parameters.emplace().first->second;
                            if( const auto &needs = blueprint->needs ) {
                                requirements.time = needs->time;
                                for( const auto &[skill, level] : needs->skills ) {
                                    requirements.skills.emplace( skill_id( skill ), level );
                                }
                                if( !needs->tools.empty() || !needs->qualities.empty() || !needs->components.empty() ) {
                                    const requirement_id needs_id( "inline_blueprint_recipe_" + id.str() );
                                    stage_requirements( needs_id, make_recipe_requirements( needs->tools, needs->qualities,
                                                        needs->components ) );
                                    requirements.raw_reqs.emplace( needs_id, 1 );
                                }
                            }
                        }
                    }
                    native_dict[id] = std::move( native );
                }
                for( const plant_lifecycle_registration &entry : pimpl_->plant_lifecycles ) {
                    // Plant lifecycle definitions are consumed by the Lua
                    // lookup path and deliberately have no native registry.
                    static_cast<void>( entry );
                }
                break;
            }
        }
        ++pimpl_->applied_phase_count;
        pimpl_->next_apply_phase = pimpl_->applied_phase_count == 10 ?
                                   items_content_apply_phase::recipes :
                                   static_cast<items_content_apply_phase>( pimpl_->applied_phase_count );
        if( pimpl_->applied_phase_count == 10 ) {
            pimpl_->applied = true;
        }
        error.clear();
        return true;
    } catch( const std::exception &exception ) {
        rollback_phase( static_cast<items_content_rollback_phase>( static_cast<int>( phase ) ) );
        rollback_all();
        error = "Lua-first Mod '" + pimpl_->owner + "': " + exception.what();
        return false;
    }
}

bool items_content_transaction::validate_finalized( std::string &error ) const
{
    if( !pimpl_->applied ) {
        error = "items content transaction is not fully applied";
        return false;
    }
    if( pimpl_->finalization_validated ) {
        error = "items content finalization was already validated";
        return false;
    }
    const auto check = [&error]( const bool valid, const std::string & kind,
    const std::string & id ) {
        if( !valid ) {
            error = "Lua-first " + kind + " '" + id + "' did not survive global finalization";
            return false;
        }
        return true;
    };
    for( const tool_quality_registration &entry : pimpl_->tool_qualities ) {
        if( !check( quality_id( entry.definition->id ).is_valid(), "tool quality",
                    entry.definition->id ) ) {
            return false;
        }
    }
    for( const skill_display_registration &entry : pimpl_->skill_displays ) {
        if( !check( skill_displayType_id( entry.definition->id ).is_valid(), "skill display category",
                    entry.definition->id ) ) {
            return false;
        }
    }
    for( const skill_registration &entry : pimpl_->skills ) {
        if( !check( skill_id( entry.definition->id ).is_valid(), "skill", entry.definition->id ) ) {
            return false;
        }
    }
    for( const vitamin_registration &entry : pimpl_->vitamins ) {
        if( !check( vitamin_id( entry.definition->id ).is_valid(), "vitamin", entry.definition->id ) ) {
            return false;
        }
    }
    for( const json_flag_registration &entry : pimpl_->json_flags ) {
        if( !check( flag_id( entry.definition->id ).is_valid(), "JSON flag", entry.definition->id ) ) {
            return false;
        }
    }
    for( const math_function_registration &entry : pimpl_->math_functions ) {
        if( !check( jmath_func_id( entry.definition->id ).is_valid(), "math function",
                    entry.definition->id ) ) {
            return false;
        }
    }
    for( const damage_type_registration &entry : pimpl_->damage_types ) {
        if( !check( damage_type_id( entry.definition->id ).is_valid(), "damage type",
                    entry.definition->id ) ) {
            return false;
        }
    }
    for( const material_registration &entry : pimpl_->materials ) {
        if( !check( material_id( entry.definition->id ).is_valid(), "material", entry.definition->id ) ) {
            return false;
        }
    }
    for( const ammunition_type_registration &entry : pimpl_->ammunition_types ) {
        const ammotype id( entry.definition->id );
        if( !check( id.is_valid(), "ammunition type",
                    entry.definition->id ) ) {
            return false;
        }
        // A default item can inherit its definition from a later JSON file or
        // be defined by another Mod. Check the final overlaid ammunition type.
        const itype_id &item_id = id->default_ammotype();
        if( !item_id.is_empty() && item_id.str() != "components" &&
            item_id.str() != "thrown" && !item::type_is_defined( item_id ) ) {
            error = "Lua-first ammunition type '" + id.str() +
                    "' references unknown default item '" + item_id.str() + "'";
            return false;
        }
    }
    for( const item_category_registration &entry : pimpl_->item_categories ) {
        if( !check( item_category_id( entry.definition->id ).is_valid(), "item category",
                    entry.definition->id ) ) {
            return false;
        }
    }
    for( const crafting_category_registration &entry : pimpl_->crafting_categories ) {
        if( !check( crafting_category_id( entry.definition->id ).is_valid(), "recipe category",
                    entry.definition->id ) ) {
            return false;
        }
    }
    for( const proficiency_category_registration &entry : pimpl_->proficiency_categories ) {
        if( !check( proficiency_category_id( entry.definition->id ).is_valid(), "proficiency category",
                    entry.definition->id ) ) {
            return false;
        }
    }
    for( const proficiency_registration &entry : pimpl_->proficiencies ) {
        if( !check( proficiency_id( entry.definition->id ).is_valid(), "proficiency",
                    entry.definition->id ) ) {
            return false;
        }
    }
    for( const weapon_category_registration &entry : pimpl_->weapon_categories ) {
        if( !check( weapon_category_id( entry.definition->id ).is_valid(), "weapon category",
                    entry.definition->id ) ) {
            return false;
        }
    }
    for( const requirement_registration &entry : pimpl_->requirements ) {
        if( !check( requirement_data::registry().count( requirement_id( entry.definition->id ) ) != 0,
                    "requirement", entry.definition->id ) ) {
            return false;
        }
    }
    for( const recipe_group_registration &entry : pimpl_->recipe_groups ) {
        if( !check( detail::recipe_group_exists( entry.definition->id ), "recipe group",
                    entry.definition->id ) ) {
            return false;
        }
    }
    for( const scent_type_registration &entry : pimpl_->scent_types ) {
        if( !check( scenttype_id( entry.definition->id ).is_valid(), "scent type",
                    entry.definition->id ) ) {
            return false;
        }
    }
    for( const butchery_requirement_registration &entry : pimpl_->butchery_requirement_entries ) {
        if( !check( string_id<butchery_requirements>( entry.definition->id ).is_valid(),
                    "butchery requirement", entry.definition->id ) ) {
            return false;
        }
    }
    for( const item_action_registration &entry : pimpl_->item_actions ) {
        if( !check( detail::item_action_registry_find( entry.definition->id ) != nullptr,
                    "item action", entry.definition->id ) ) {
            return false;
        }
    }
    for( const item_group_registration &entry : pimpl_->item_groups ) {
        if( !check( item_group::group_is_defined( item_group_id( entry.definition->id ) ),
                    "item group", entry.definition->id ) ) {
            return false;
        }
    }
    for( const ammo_effect_registration &entry : pimpl_->ammo_effects ) {
        if( !check( ammo_effect_str_id( entry.definition->id ).is_valid(), "ammo effect",
                    entry.definition->id ) ) {
            return false;
        }
    }
    for( const item_registration &entry : pimpl_->items ) {
        const item_definition_data &definition = *entry.definition;
        if( !definition.is_abstract &&
            !check( item_controller->get_generic_factory().is_valid( itype_id( definition.id ) ),
                    "item", definition.id ) ) {
            return false;
        }
        if( definition.book && !definition.book->martial_art.empty() &&
            !matype_id( definition.book->martial_art ).is_valid() ) {
            error = "Lua-first item '" + definition.id + "' teaches an unknown martial art '" +
                    definition.book->martial_art + "'";
            return false;
        }
        for( const std::string &spell : definition.learned_spells ) {
            if( !spell_id( spell ).is_valid() ) {
                error = "Lua-first item '" + definition.id + "' teaches an unknown spell '" + spell + "'";
                return false;
            }
        }
    }
    for( const recipe_registration &entry : pimpl_->recipes ) {
        if( entry.shadowed_by_later_source ) {
            continue;
        }
        const auto &native_dict = entry.definition->uncraft ? recipe_dict.uncraft : recipe_dict.recipes;
        const recipe_id id( entry.definition->uncraft ? recipe_id( entry.definition->result ) :
                            recipe_id( entry.definition->id ) );
        if( !entry.definition->nested_category && native_dict.count( id ) == 0 ) {
            const itype_id result( entry.definition->result );
            const requirement_id inline_id = recipe_root_requirement_id( id, *entry.definition );
            const auto uses_blacklisted_requirement = []( const recipe_requirement_sets &requirements ) {
                return std::any_of( requirements.begin(), requirements.end(), []( const auto & req ) {
                    return requirement_id( req.first )->is_blacklisted();
                } );
            };
            // The native finalizer discards recipes affected by item blacklists or migrations.
            if( ( !entry.definition->result.empty() &&
                  ( item_is_blacklisted( result ) || item_controller->has_template_migration( result ) ) ) ||
                ( inline_id.is_valid() && inline_id->is_blacklisted() ) ||
                uses_blacklisted_requirement( entry.definition->external_requirements ) ) {
                continue;
            }
            bool step_blacklisted = false;
            for( std::size_t i = 0; i < entry.definition->steps.size(); ++i ) {
                const requirement_id step_id( inline_id.str() + "_step_" + std::to_string( i ) );
                if( step_id->is_blacklisted() ||
                    uses_blacklisted_requirement( entry.definition->steps[i].requirements ) ) {
                    step_blacklisted = true;
                    break;
                }
            }
            if( step_blacklisted ) {
                continue;
            }
        }
        if( !check( native_dict.count( id ) != 0, "recipe", entry.definition->id ) ) {
            return false;
        }
    }
    pimpl_->finalization_validated = true;
    error.clear();
    return true;
}

void items_content_transaction::rollback_phase( const items_content_rollback_phase phase )
{
    auto restore_factory = []( auto & factory, auto & undo ) {
        for( auto it = undo.rbegin(); it != undo.rend(); ++it ) {
            if( it->second ) {
                factory.restore( *it->second );
            } else {
                factory.erase( it->first );
            }
        }
        undo.clear();
    };
    const auto restore_requirements = []( auto & undo ) {
        for( auto it = undo.rbegin(); it != undo.rend(); ++it ) {
            requirement_data::pop_requirement_layer( it->first );
            requirement_data::registry().erase( it->first );
            if( it->second ) {
                requirement_data::registry()[it->first] = *it->second;
            }
        }
        undo.clear();
    };
    switch( phase ) {
        case items_content_rollback_phase::foundations:
            for( auto it = pimpl_->item_migration_undo.rbegin(); it != pimpl_->item_migration_undo.rend();
                 ++it ) {
                if( it->second ) {
                    item_controller->migrations[it->first] = std::move( *it->second );
                } else {
                    item_controller->migrations.erase( it->first );
                }
            }
            pimpl_->item_migration_undo.clear();
            restore_factory( detail::damage_type_registry(), pimpl_->damage_type_undo );
            restore_factory( detail::vitamin_registry(), pimpl_->vitamin_undo );
            for( auto it = pimpl_->skill_undo.rbegin(); it != pimpl_->skill_undo.rend(); ++it ) {
                const skill_id id = it->first;
                Skill::skills.erase( std::remove_if( Skill::skills.begin(), Skill::skills.end(),
                [&id]( const Skill & value ) {
                    return value.ident() == id;
                } ), Skill::skills.end() );
                Skill::contextual_skills.erase( id );
                if( it->second ) {
                    if( it->second->is_contextual_skill() ) {
                        Skill::contextual_skills[id] = *it->second;
                    } else {
                        Skill::skills.push_back( *it->second );
                    }
                }
            }
            pimpl_->skill_undo.clear();
            for( auto it = pimpl_->skill_display_undo.rbegin(); it != pimpl_->skill_display_undo.rend();
                 ++it ) {
                const skill_displayType_id id = it->first;
                SkillDisplayType::skillTypes.erase(
                    std::remove_if( SkillDisplayType::skillTypes.begin(), SkillDisplayType::skillTypes.end(),
                [&id]( const SkillDisplayType & value ) {
                    return value.ident() == id;
                } ),
                SkillDisplayType::skillTypes.end() );
                if( it->second ) {
                    SkillDisplayType::skillTypes.push_back( *it->second );
                }
            }
            pimpl_->skill_display_undo.clear();
            restore_factory( detail::tool_quality_registry(), pimpl_->tool_quality_undo );
            restore_factory( detail::jmath_func_registry(), pimpl_->math_function_undo );
            restore_factory( detail::json_flag_registry(), pimpl_->json_flag_undo );
            break;
        case items_content_rollback_phase::materials:
            restore_factory( detail::material_registry(), pimpl_->material_undo );
            break;
        case items_content_rollback_phase::recipes:
            for( auto it = pimpl_->recipe_undo.rbegin(); it != pimpl_->recipe_undo.rend(); ++it ) {
                if( it->second ) {
                    recipe_dict.recipes[it->first] = *it->second;
                } else {
                    recipe_dict.recipes.erase( it->first );
                }
            }
            pimpl_->recipe_undo.clear();
            for( auto it = pimpl_->uncraft_undo.rbegin(); it != pimpl_->uncraft_undo.rend(); ++it ) {
                if( it->second ) {
                    recipe_dict.uncraft[it->first] = *it->second;
                } else {
                    recipe_dict.uncraft.erase( it->first );
                }
            }
            pimpl_->uncraft_undo.clear();
            restore_requirements( pimpl_->recipe_requirement_undo );
            break;
        case items_content_rollback_phase::definitions:
            for( auto it = pimpl_->item_abstract_undo.rbegin(); it != pimpl_->item_abstract_undo.rend(); ++it ) {
                auto &factory = item_controller->get_generic_factory();
                if( it->second ) {
                    factory.restore_abstract( *it->second );
                } else {
                    factory.erase_abstract( it->first );
                }
            }
            pimpl_->item_abstract_undo.clear();
            if( !pimpl_->item_undo.empty() ) {
                restore_factory( item_controller->get_generic_factory(), pimpl_->item_undo );
                item_controller->m_runtimes_dirty = true;
                item_controller->templates_all_cache.clear();
                item_controller->armor_containers.clear();
            }
            break;
        case items_content_rollback_phase::requirements:
            restore_requirements( pimpl_->requirement_undo );
            break;
        case items_content_rollback_phase::recipe_groups:
            for( auto it = pimpl_->recipe_group_undo.rbegin(); it != pimpl_->recipe_group_undo.rend(); ++it ) {
                detail::recipe_group_erase( it->first );
                if( it->second ) {
                    detail::recipe_group_set( *it->second );
                }
            }
            pimpl_->recipe_group_undo.clear();
            break;
        case items_content_rollback_phase::item_groups:
            for( auto it = pimpl_->item_group_extension_undo.rbegin();
                 it != pimpl_->item_group_extension_undo.rend(); ++it ) {
                const auto existing = item_controller->m_template_groups.find( it->first );
                if( existing != item_controller->m_template_groups.end() ) {
                    Item_group *const native = dynamic_cast<Item_group *>( existing->second.get() );
                    if( native != nullptr ) {
                        native->truncate_entries( it->second );
                    }
                }
            }
            pimpl_->item_group_extension_undo.clear();
            for( auto it = pimpl_->item_group_undo.rbegin(); it != pimpl_->item_group_undo.rend(); ++it ) {
                item_controller->m_template_groups.erase( it->first );
                if( it->second ) {
                    item_controller->m_template_groups[it->first] = std::move( it->second );
                }
            }
            pimpl_->item_group_undo.clear();
            break;
        case items_content_rollback_phase::metadata:
            for( auto it = pimpl_->item_action_undo.rbegin(); it != pimpl_->item_action_undo.rend(); ++it ) {
                detail::item_action_registry_erase( it->first );
                if( it->second ) {
                    detail::item_action_registry_set( *it->second );
                }
            }
            pimpl_->item_action_undo.clear();
            restore_factory( detail::butchery_requirements_registry(), pimpl_->butchery_requirements_undo );
            restore_factory( detail::scent_type_registry(), pimpl_->scent_type_undo );
            break;
        case items_content_rollback_phase::ammunition_effects:
            restore_factory( get_all_ammo_effects(), pimpl_->ammo_effect_undo );
            if( !pimpl_->ammo_effects.empty() ) {
                get_all_ammo_effects().finalize();
            }
            break;
        case items_content_rollback_phase::catalogs:
            for( auto it = pimpl_->ammunition_type_undo.rbegin(); it != pimpl_->ammunition_type_undo.rend();
                 ++it ) {
                if( it->second ) {
                    ammunition_type::registry()[it->first] = *it->second;
                } else {
                    ammunition_type::registry().erase( it->first );
                }
            }
            pimpl_->ammunition_type_undo.clear();
            restore_factory( detail::crafting_category_registry(), pimpl_->crafting_category_undo );
            for( auto it = pimpl_->item_category_undo.rbegin(); it != pimpl_->item_category_undo.rend();
                 ++it ) {
                const item_category_id &id = std::get<0>( *it );
                if( std::get<1>( *it ) ) {
                    detail::item_category_registry().restore( *std::get<1>( *it ) );
                } else {
                    detail::item_category_registry().erase( id );
                }
                item_category_spawn_rates::get_item_category_spawn_rates().set_spawn_rate(
                    id, std::get<2>( *it ) );
            }
            pimpl_->item_category_undo.clear();
            restore_factory( detail::weapon_category_registry(), pimpl_->weapon_category_undo );
            restore_factory( detail::proficiency_registry(), pimpl_->proficiency_undo );
            restore_factory( detail::proficiency_category_registry(), pimpl_->proficiency_category_undo );
            break;
    }
    pimpl_->applied = false;
    pimpl_->finalization_validated = false;
    pimpl_->token->lifecycle = handle_lifecycle::discarded;
}

void items_content_transaction::rollback_all()
{
    while( pimpl_->applied_phase_count > 0 ) {
        rollback_phase( static_cast<items_content_rollback_phase>( pimpl_->applied_phase_count - 1 ) );
        --pimpl_->applied_phase_count;
    }
    pimpl_->next_apply_phase = items_content_apply_phase::foundations;
    pimpl_->applied = false;
    pimpl_->finalization_validated = false;
    pimpl_->token->lifecycle = handle_lifecycle::discarded;
}

void items_content_transaction::commit()
{
    if( !pimpl_->applied ) {
        return;
    }
    pimpl_->item_migration_undo.clear();
    pimpl_->tool_quality_undo.clear();
    pimpl_->skill_display_undo.clear();
    pimpl_->skill_undo.clear();
    pimpl_->vitamin_undo.clear();
    pimpl_->json_flag_undo.clear();
    pimpl_->math_function_undo.clear();
    pimpl_->damage_type_undo.clear();
    pimpl_->material_undo.clear();
    pimpl_->ammunition_type_undo.clear();
    pimpl_->item_category_undo.clear();
    pimpl_->crafting_category_undo.clear();
    pimpl_->proficiency_category_undo.clear();
    pimpl_->proficiency_undo.clear();
    pimpl_->weapon_category_undo.clear();
    pimpl_->requirement_undo.clear();
    pimpl_->recipe_group_undo.clear();
    pimpl_->scent_type_undo.clear();
    pimpl_->butchery_requirements_undo.clear();
    pimpl_->item_action_undo.clear();
    pimpl_->item_group_undo.clear();
    pimpl_->item_group_extension_undo.clear();
    pimpl_->ammo_effect_undo.clear();
    pimpl_->item_undo.clear();
    pimpl_->item_abstract_undo.clear();
    pimpl_->recipe_undo.clear();
    pimpl_->uncraft_undo.clear();
    pimpl_->recipe_requirement_undo.clear();
    pimpl_->token->lifecycle = handle_lifecycle::committed;
}

void items_content_transaction::seal()
{
    if( pimpl_->applied && pimpl_->token->lifecycle == handle_lifecycle::building ) {
        pimpl_->token->lifecycle = handle_lifecycle::committed;
    }
}

void items_content_transaction::discard()
{
    rollback_all();
}

bool items_content_transaction::was_applied() const
{
    return pimpl_->applied;
}

bool items_content_transaction::has_requirements() const
{
    return !pimpl_->requirements.empty();
}

bool items_content_transaction::has_requirement_changes() const
{
    return pimpl_->requirement_changes;
}

bool items_content_transaction::defines_tool_quality( const std::string_view id ) const
{
    return defines_registration( pimpl_->tool_qualities, id );
}

items_content_staged_ids items_content_transaction::staged_ids() const
{
    items_content_staged_ids result;
    const auto collect = []( const auto & registrations, std::set<std::string> &ids ) {
        for( const auto &entry : registrations ) {
            ids.insert( entry.definition->id );
        }
    };
    collect( pimpl_->tool_qualities, result.tool_qualities );
    collect( pimpl_->skill_displays, result.skill_displays );
    collect( pimpl_->skills, result.skills );
    collect( pimpl_->vitamins, result.vitamins );
    collect( pimpl_->json_flags, result.json_flags );
    collect( pimpl_->math_functions, result.math_functions );
    collect( pimpl_->damage_types, result.damage_types );
    collect( pimpl_->materials, result.materials );
    collect( pimpl_->proficiencies, result.proficiencies );
    collect( pimpl_->proficiency_categories, result.proficiency_categories );
    collect( pimpl_->weapon_categories, result.weapon_categories );
    collect( pimpl_->ammunition_types, result.ammunition_types );
    collect( pimpl_->item_categories, result.item_categories );
    collect( pimpl_->crafting_categories, result.crafting_categories );
    for( const item_registration &entry : pimpl_->items ) {
        if( !entry.definition->is_abstract ) {
            result.items.insert( entry.definition->id );
        }
    }
    collect( pimpl_->item_groups, result.item_groups );
    collect( pimpl_->recipes, result.recipes );
    collect( pimpl_->requirements, result.requirements );
    collect( pimpl_->scent_types, result.scent_types );
    collect( pimpl_->ammo_effects, result.ammo_effects );
    collect( pimpl_->butchery_requirement_entries, result.butchery_requirements );
    collect( pimpl_->item_actions, result.item_actions );
    return result;
}
bool items_content_transaction::defines_skill( const std::string_view id ) const
{
    return defines_registration( pimpl_->skills, id );
}
bool items_content_transaction::defines_vitamin( const std::string_view id ) const
{
    return defines_registration( pimpl_->vitamins, id );
}
bool items_content_transaction::defines_json_flag( const std::string_view id ) const
{
    return defines_registration( pimpl_->json_flags, id );
}
bool items_content_transaction::defines_math_function( const std::string_view id ) const
{
    return defines_registration( pimpl_->math_functions, id );
}
bool items_content_transaction::defines_damage_type( const std::string_view id ) const
{
    return defines_registration( pimpl_->damage_types, id );
}
bool items_content_transaction::defines_material( const std::string_view id ) const
{
    return defines_registration( pimpl_->materials, id );
}
bool items_content_transaction::defines_proficiency( const std::string_view id ) const
{
    return defines_registration( pimpl_->proficiencies, id );
}
bool items_content_transaction::defines_item( const std::string_view id ) const
{
    return std::any_of( pimpl_->items.begin(), pimpl_->items.end(), [id]( const item_registration &entry ) {
        return !entry.definition->is_abstract && entry.definition->id == id;
    } );
}
bool items_content_transaction::defines_item_group( const std::string_view id ) const
{
    return defines_registration( pimpl_->item_groups, id );
}
bool items_content_transaction::defines_recipe( const std::string_view id ) const
{
    return defines_registration( pimpl_->recipes, id );
}
bool items_content_transaction::defines_requirement( const std::string_view id ) const
{
    return defines_registration( pimpl_->requirements, id );
}
bool items_content_transaction::defines_scent_type( const std::string_view id ) const
{
    return defines_registration( pimpl_->scent_types, id );
}

bool items_content_transaction::find_item_handler( const std::string_view item_id,
        const std::string_view phase, std::string &handler_id ) const
{
    const auto found = std::find_if( pimpl_->items.rbegin(), pimpl_->items.rend(),
    [item_id]( const item_registration & entry ) {
        return entry.definition->id == item_id;
    } );
    if( found == pimpl_->items.rend() ) {
        handler_id.clear();
        return false;
    }
    handler_id = phase == "use" ? found->definition->use_handler :
                 phase == "consume" ? found->definition->consume_handler : std::string();
    return true;
}

bool items_content_transaction::find_damage_handler( const std::string_view damage_id,
        const std::string_view phase, std::string &handler_id ) const
{
    const auto found = std::find_if( pimpl_->damage_types.rbegin(), pimpl_->damage_types.rend(),
    [damage_id]( const damage_type_registration & entry ) {
        return entry.definition->id == damage_id;
    } );
    if( found == pimpl_->damage_types.rend() ) {
        return false;
    }
    handler_id = phase == "on_hit" ? found->definition->on_hit_handler :
                 phase == "on_damage" ? found->definition->on_damage_handler : std::string();
    return true;
}

bool items_content_transaction::find_ammo_effect_handler( const std::string_view ammo_effect_id,
        std::string &handler_id ) const
{
    const auto found = std::find_if( pimpl_->ammo_effects.rbegin(), pimpl_->ammo_effects.rend(),
    [ammo_effect_id]( const ammo_effect_registration & entry ) {
        return entry.definition->id == ammo_effect_id;
    } );
    if( found == pimpl_->ammo_effects.rend() ) {
        return false;
    }
    handler_id = found->definition->impact_handler;
    return true;
}

bool items_content_transaction::find_plant_lifecycle_handler( const std::string_view target,
        const std::string_view target_id, const std::string_view phase,
        std::string &handler_id ) const
{
    const auto found = std::find_if( pimpl_->plant_lifecycles.rbegin(), pimpl_->plant_lifecycles.rend(),
    [target, target_id]( const plant_lifecycle_registration & entry ) {
        return entry.definition->target == target && entry.definition->id == target_id;
    } );
    if( found == pimpl_->plant_lifecycles.rend() ) {
        handler_id.clear();
        return false;
    }
    const auto handler = found->definition->handlers.find( std::string( phase ) );
    handler_id = handler == found->definition->handlers.end() ? std::string() : handler->second;
    return true;
}

void items_content_transaction::append_fingerprint( const items_content_fingerprint_phase phase,
        std::uint64_t &state ) const
{
    // Keep each phase's encoding identical to the old monolithic transaction.
    // The order of registrations is intentional: maps/sets retain their
    // deterministic iteration order while vectors retain Lua declaration order.
    switch( phase ) {
        case items_content_fingerprint_phase::foundations:
            for( const auto &entry : pimpl_->item_migrations ) {
                const migration &native = entry->specification;
                hash_part( state, "item_migration" );
                hash_part( state, std::to_string( entry->from.size() ) );
                for( const itype_id &id : entry->from ) {
                    hash_part( state, id.str() );
                }
                hash_part( state, native.replace.str() );
                hash_part( state, native.variant );
                hash_part( state, native.from_variant ? "from_variant" : "blanket" );
                if( native.from_variant ) {
                    hash_part( state, *native.from_variant );
                }
                hash_part( state, std::to_string( native.charges ) );
                hash_part( state, native.sealed ? "sealed" : "unsealed" );
                hash_part( state, native.reset_item_vars ? "reset_vars" : "keep_vars" );
                hash_part( state, std::to_string( native.flags.size() ) );
                for( const std::string &flag : native.flags ) {
                    hash_part( state, flag );
                }
                hash_part( state, std::to_string( native.contents.size() ) );
                for( const migration::content &carried : native.contents ) {
                    hash_part( state, carried.id.str() );
                    hash_part( state, std::to_string( carried.count ) );
                }
            }
            for( const json_flag_registration &entry : pimpl_->json_flags ) {
                hash_part( state, "json_flag" );
                hash_part( state, operation_name( entry.operation ) );
                const auto &v = *entry.definition;
                hash_part( state, v.id );
                hash_part( state, v.info );
                hash_part( state, v.restriction );
                hash_part( state, v.name );
                hash_part( state, v.item_prefix );
                hash_part( state, v.item_suffix );
                hash_part( state, v.requires_flag );
                hash_part( state, std::to_string( v.taste_modifier ) );
                hash_part( state, v.inherit ? "inherit" : "local" );
                hash_part( state, v.craft_inherit ? "craft_inherit" : "no_craft_inherit" );
                for( const auto &id : v.conflicts ) {
                    hash_part( state, id );
                }
            }
            for( const math_function_registration &entry : pimpl_->math_functions ) {
                hash_part( state, "math_function" );
                hash_part( state, operation_name( entry.operation ) );
                hash_part( state, entry.definition->id );
                hash_part( state, std::to_string( entry.definition->num_args ) );
                hash_part( state, entry.definition->expression );
            }
            for( const tool_quality_registration &entry : pimpl_->tool_qualities ) {
                hash_part( state, "tool_quality" );
                hash_part( state, operation_name( entry.operation ) );
                hash_part( state, entry.definition->id );
                hash_part( state, entry.definition->name );
                for( const auto &[level, text] : entry.definition->usages ) {
                    hash_part( state, std::to_string( level ) );
                    hash_part( state, text );
                }
            }
            for( const skill_display_registration &entry : pimpl_->skill_displays ) {
                hash_part( state, "skill_display" );
                hash_part( state, operation_name( entry.operation ) );
                hash_part( state, entry.definition->id );
                hash_part( state, entry.definition->label );
            }
            for( const skill_registration &entry : pimpl_->skills ) {
                hash_part( state, "skill" );
                hash_part( state, operation_name( entry.operation ) );
                const auto &v = *entry.definition;
                hash_part( state, v.id );
                hash_part( state, v.name );
                hash_part( state, v.description );
                hash_part( state, v.display_category );
                hash_part( state, std::to_string( v.sort_rank ) );
                hash_part( state, v.consumes_focus ? "focus" : "no_focus" );
                hash_part( state, v.teachable ? "teachable" : "not_teachable" );
                hash_part( state, v.obsolete ? "obsolete" : "current" );
                hash_part( state, std::to_string( v.attack_min_time ) );
                hash_part( state, std::to_string( v.attack_base_time ) );
                hash_part( state, std::to_string( v.attack_reduction_per_level ) );
                hash_part( state, std::to_string( v.companion_combat_rank_factor ) );
                hash_part( state, std::to_string( v.companion_survival_rank_factor ) );
                hash_part( state, std::to_string( v.companion_industry_rank_factor ) );
                hash_part( state, "tags" );
                for( const auto &tag : v.tags ) {
                    hash_part( state, tag );
                }
                hash_part( state, "companion_practice" );
                for( const auto &[id, weight] : v.companion_practice ) {
                    hash_part( state, id );
                    hash_part( state, std::to_string( weight ) );
                }
                hash_part( state, "theory_descriptions" );
                for( const auto &[level, description] : v.theory_descriptions ) {
                    hash_part( state, std::to_string( level ) );
                    hash_part( state, description );
                }
                hash_part( state, "practice_descriptions" );
                for( const auto &[level, description] : v.practice_descriptions ) {
                    hash_part( state, std::to_string( level ) );
                    hash_part( state, description );
                }
                for( const auto &id : v.requires_all_traits ) {
                    hash_part( state, "all" );
                    hash_part( state, id );
                }
                for( const auto &id : v.requires_any_traits ) {
                    hash_part( state, "any" );
                    hash_part( state, id );
                }
            }
            for( const vitamin_registration &entry : pimpl_->vitamins ) {
                hash_part( state, "vitamin" );
                hash_part( state, operation_name( entry.operation ) );
                const auto &v = *entry.definition;
                hash_part( state, v.id );
                hash_part( state, v.name );
                hash_part( state, v.type );
                hash_part( state, v.deficiency );
                hash_part( state, v.excess );
                hash_part( state, std::to_string( v.minimum ) );
                hash_part( state, std::to_string( v.maximum ) );
                hash_part( state, std::to_string( v.rate_turns ) );
                hash_part( state, v.weight_micrograms ? std::to_string( *v.weight_micrograms ) : "no_weight" );
                for( const auto &[start, end] : v.disease ) {
                    hash_part( state, std::to_string( start ) );
                    hash_part( state, std::to_string( end ) );
                }
                for( const auto &[start, end] : v.disease_excess ) {
                    hash_part( state, std::to_string( start ) );
                    hash_part( state, std::to_string( end ) );
                }
                for( const auto &[id, rate] : v.decays_into ) {
                    hash_part( state, id );
                    hash_part( state, std::to_string( rate ) );
                }
                for( const auto &id : v.flags ) {
                    hash_part( state, id );
                }
            }
            break;
        case items_content_fingerprint_phase::damage_types:
            for( const damage_type_registration &entry : pimpl_->damage_types ) {
                hash_part( state, "damage_type" );
                hash_part( state, operation_name( entry.operation ) );
                const auto &v = *entry.definition;
                hash_part( state, v.id );
                hash_part( state, v.name );
                hash_part( state, v.skill );
                hash_part( state, v.magic_color );
                hash_part( state, v.derived_from );
                hash_part( state, v.on_hit_handler );
                hash_part( state, v.on_damage_handler );
                hash_part( state, std::to_string( v.derived_factor ) );
                hash_part( state, std::to_string( v.bash_conversion_factor ) );
                hash_part( state, std::to_string( v.melee_crit_dmg_mult ) );
                hash_part( state, std::to_string( v.melee_crit_dmg_mult_per_skill ) );
                hash_part( state, std::to_string( v.melee_crit_armor_mult ) );
                hash_part( state, std::to_string( v.melee_crit_armor_penetration ) );
                hash_part( state, v.melee_only ? "melee" : "ranged" );
                hash_part( state, v.physical ? "physical" : "nonphysical" );
                hash_part( state, v.monster_difficulty ? "monster_difficulty" : "ordinary" );
                hash_part( state, v.no_resist ? "no_resist" : "resisted" );
                hash_part( state, v.edged ? "edged" : "blunt" );
                hash_part( state, v.environmental ? "environmental" : "direct" );
                hash_part( state, v.material_required ? "material_required" : "material_optional" );
                for( const auto &id : v.character_immune_flags ) {
                    hash_part( state, "character" );
                    hash_part( state, id );
                }
                for( const auto &id : v.monster_immune_flags ) {
                    hash_part( state, "monster" );
                    hash_part( state, id );
                }
            }
            break;
        case items_content_fingerprint_phase::materials:
            for( const material_registration &entry : pimpl_->materials ) {
                hash_part( state, "material" );
                hash_part( state, operation_name( entry.operation ) );
                const auto &v = *entry.definition;
                hash_part( state, v.id );
                hash_part( state, v.copy_from );
                hash_part( state, v.name );
                hash_part( state, v.salvaged_into );
                for( const std::string &rep : v.repaired_with ) {
                    hash_part( state, rep );
                }
                hash_part( state, v.repaired_with_name );
                hash_part( state, v.bash_damage_verb );
                hash_part( state, v.cut_damage_verb );
                hash_part( state, v.chip_resistance ? std::to_string( *v.chip_resistance ) : "default" );
                hash_part( state, v.breathability ? std::to_string( *v.breathability ) : "default" );
                hash_part( state, v.repair_difficulty ? std::to_string( *v.repair_difficulty ) : "default" );
                hash_part( state, v.wind_resistance ? std::to_string( *v.wind_resistance ) : "no_wind" );
                hash_part( state, v.density ? std::to_string( *v.density ) : "default" );
                hash_part( state, v.sheet_thickness ? std::to_string( *v.sheet_thickness ) : "default" );
                hash_part( state, v.specific_heat_liquid ? std::to_string( *v.specific_heat_liquid ) : "default" );
                hash_part( state, v.specific_heat_solid ? std::to_string( *v.specific_heat_solid ) : "default" );
                hash_part( state, v.latent_heat ? std::to_string( *v.latent_heat ) : "default" );
                hash_part( state, v.freezing_point ? std::to_string( *v.freezing_point ) : "default" );
                hash_part( state, !v.rotting ? "default" : *v.rotting ? "rotting" : "stable" );
                hash_part( state, !v.soft ? "default" : *v.soft ? "soft" : "hard" );
                hash_part( state, !v.uncomfortable ? "default" : *v.uncomfortable ? "uncomfortable" : "comfortable" );
                hash_part( state, !v.conductive ? "default" : *v.conductive ? "conductive" : "insulating" );
                for( const authored_text &id : v.damage_adjectives ) {
                    hash_part( state, id );
                }
                for( const auto &[id, amount] : v.resistances ) {
                    hash_part( state, id );
                    hash_part( state, std::to_string( amount ) );
                }
                for( const auto &[id, amount] : v.vitamins ) {
                    hash_part( state, id );
                    hash_part( state, std::to_string( amount ) );
                }
                for( const auto &burn : v.burn_data ) {
                    hash_part( state, burn.immune ? "immune" : "burnable" );
                    hash_part( state, std::to_string( burn.volume_ml_per_turn ) );
                    hash_part( state, std::to_string( burn.fuel ) );
                    hash_part( state, std::to_string( burn.smoke ) );
                    hash_part( state, std::to_string( burn.burn ) );
                }
                for( const auto &[id, amount] : v.burn_products ) {
                    hash_part( state, id );
                    hash_part( state, std::to_string( amount ) );
                }
                hash_part( state, v.has_fuel ? "fuel" : "no_fuel" );
                hash_part( state, std::to_string( v.fuel_energy_kilojoules ) );
                hash_part( state, v.fuel_pump_terrain );
                hash_part( state, v.perpetual_fuel ? "perpetual" : "consumed" );
                hash_part( state, std::to_string( v.explosion_chance_hot ) );
                hash_part( state, std::to_string( v.explosion_chance_cold ) );
                hash_part( state, std::to_string( v.explosion_factor ) );
                hash_part( state, v.fiery_explosion ? "fiery" : "ordinary" );
                hash_part( state, std::to_string( v.fuel_size_factor ) );
            }
            break;
        case items_content_fingerprint_phase::catalogs:
            for( const auto &entry : pimpl_->proficiency_categories ) {
                hash_part( state, "proficiency_category" );
                hash_part( state, operation_name( entry.operation ) );
                hash_part( state, entry.definition->id );
                hash_part( state, entry.definition->name );
                hash_part( state, entry.definition->description );
            }
            for( const auto &entry : pimpl_->proficiencies ) {
                const auto &v = *entry.definition;
                hash_part( state, "proficiency" );
                hash_part( state, operation_name( entry.operation ) );
                hash_part( state, v.id );
                hash_part( state, v.name );
                hash_part( state, v.description );
                hash_part( state, v.category );
                hash_part( state, std::to_string( v.time_to_learn_turns ) );
                hash_part( state, std::to_string( v.time_multiplier ) );
                hash_part( state, std::to_string( v.skill_penalty ) );
                hash_part( state, std::to_string( v.weakpoint_bonus ) );
                hash_part( state, std::to_string( v.weakpoint_penalty ) );
                hash_part( state, v.can_learn ? "learnable" : "fixed" );
                hash_part( state, v.ignore_focus ? "ignore_focus" : "use_focus" );
                hash_part( state, v.teachable ? "teachable" : "not_teachable" );
                for( const auto &id : v.required ) {
                    hash_part( state, id );
                }
                for( const auto &bonus : v.bonuses ) {
                    hash_part( state, bonus.category );
                    hash_part( state, bonus.attribute );
                    hash_part( state, std::to_string( bonus.value ) );
                }
            }
            for( const auto &entry : pimpl_->weapon_categories ) {
                hash_part( state, "weapon_category" );
                hash_part( state, operation_name( entry.operation ) );
                hash_part( state, entry.definition->id );
                hash_part( state, entry.definition->name );
                for( const auto &id : entry.definition->proficiencies ) {
                    hash_part( state, id );
                }
            }
            for( const auto &entry : pimpl_->item_categories ) {
                const auto &v = *entry.definition;
                hash_part( state, "item_category" );
                hash_part( state, operation_name( entry.operation ) );
                hash_part( state, v.id );
                hash_part( state, v.header );
                hash_part( state, v.noun );
                hash_part( state, std::to_string( v.sort_rank ) );
                hash_part( state, std::to_string( v.spawn_rate ) );
                hash_part( state, v.zone );
                for( const auto &p : v.priority_zones ) {
                    hash_part( state, p.zone );
                    hash_part( state, p.filthy ? "filthy" : "flagged" );
                    for( const auto &id : p.flags ) {
                        hash_part( state, id );
                    }
                }
            }
            for( const auto &entry : pimpl_->crafting_categories ) {
                const auto &v = *entry.definition;
                hash_part( state, "recipe_category" );
                hash_part( state, operation_name( entry.operation ) );
                hash_part( state, v.id );
                hash_part( state, v.hidden ? "hidden" : "visible" );
                hash_part( state, v.practice ? "practice" : "ordinary" );
                hash_part( state, v.building ? "building" : "not_building" );
                hash_part( state, v.wildcard ? "wildcard" : "concrete" );
                for( const auto &id : v.subcategories ) {
                    hash_part( state, id );
                }
            }
            for( const auto &entry : pimpl_->ammunition_types ) {
                hash_part( state, "ammunition_type" );
                hash_part( state, operation_name( entry.operation ) );
                hash_part( state, entry.definition->id );
                hash_part( state, entry.definition->name );
                hash_part( state, entry.definition->default_item );
            }
            break;
        case items_content_fingerprint_phase::ammunition_effects:
            for( const auto &entry : pimpl_->ammo_effects ) {
                const auto &v = *entry.definition;
                hash_part( state, "ammo_effect" );
                hash_part( state, operation_name( entry.operation ) );
                hash_part( state, v.id );
                hash_part( state, std::to_string( v.trigger_chance ) );
                const auto field = [&state]( const auto & f ) {
                    hash_part( state, f.field );
                    hash_part( state, std::to_string( f.intensity_min ) );
                    hash_part( state, std::to_string( f.intensity_max ) );
                    hash_part( state, std::to_string( f.radius ) );
                    hash_part( state, std::to_string( f.height ) );
                    hash_part( state, std::to_string( f.chance ) );
                    hash_part( state, std::to_string( f.footprint ) );
                    hash_part( state, f.passable_only ? "passable" : "any_tile" );
                };
                for( const auto &f : v.field_bursts ) {
                    hash_part( state, "field_burst" );
                    field( f );
                }
                for( const auto &f : v.trails ) {
                    hash_part( state, "trail" );
                    field( f );
                }
                const auto effect = [&state]( const auto & e ) {
                    hash_part( state, e.effect );
                    hash_part( state, std::to_string( e.duration_turns ) );
                    hash_part( state, std::to_string( e.intensity_min ) );
                    hash_part( state, std::to_string( e.intensity_max ) );
                    hash_part( state, std::to_string( e.chance ) );
                    hash_part( state, std::to_string( e.radius ) );
                    hash_part( state, std::to_string( e.hits_min ) );
                    hash_part( state, std::to_string( e.hits_max ) );
                    hash_part( state, e.touch_skin ? "touch_skin" : "through_armor" );
                    hash_part( state, e.all_body_parts ? "all_body_parts" : "random_parts" );
                };
                for( const auto &e : v.on_hit_effects ) {
                    hash_part( state, "on_hit" );
                    effect( e );
                }
                for( const auto &e : v.area_effects ) {
                    hash_part( state, "area_effect" );
                    effect( e );
                }
                hash_part( state, v.has_explosion ? "explosion" : "no_explosion" );
                hash_part( state, std::to_string( v.explosion_power ) );
                hash_part( state, std::to_string( v.explosion_distance_factor ) );
                hash_part( state, std::to_string( v.explosion_max_noise ) );
                hash_part( state, v.explosion_fire ? "fire" : "no_fire" );
                hash_part( state, v.explosion_light );
                hash_part( state, v.has_shrapnel ? "shrapnel" : "no_shrapnel" );
                hash_part( state, std::to_string( v.casing_mass ) );
                hash_part( state, std::to_string( v.fragment_mass ) );
                hash_part( state, std::to_string( v.fragment_recovery ) );
                hash_part( state, v.fragment_drop );
                hash_part( state, v.flashbang ? "flashbang" : "no_flashbang" );
                hash_part( state, v.emp ? "emp" : "no_emp" );
                hash_part( state, v.foamcrete ? "foamcrete" : "no_foamcrete" );
                hash_part( state, v.cast_spells_on_miss ? "spells_always" : "spells_on_damage" );
                for( const auto &s : v.spells ) {
                    hash_part( state, s.spell );
                    hash_part( state, std::to_string( s.level ) );
                    hash_part( state, s.self ? "self" : "impact" );
                }
                hash_part( state, v.impact_handler );
            }
            break;
        case items_content_fingerprint_phase::metadata:
            for( const auto &entry : pimpl_->scent_types ) {
                hash_part( state, "scent_type" );
                hash_part( state, operation_name( entry.operation ) );
                hash_part( state, entry.definition->id );
                for( const auto &id : entry.definition->receptive_species ) {
                    hash_part( state, id );
                }
            }
            break;
        case items_content_fingerprint_phase::item_groups: {
            const auto hash_entries = [&state]( const auto &self,
            const std::vector<item_group_entry_definition_data> &entries ) -> void {
                for( const auto &e : entries ) {
                    if( e.event != holiday::none ) {
                        hash_part( state, "event" );
                        hash_part( state, io::enum_to_string( e.event ) );
                    }
                    if( e.subgroup ) {
                        hash_part( state, *e.subgroup == Item_group::G_COLLECTION ? "collection" : "distribution" );
                        hash_part( state, std::to_string( e.probability ) );
                        hash_part( state, std::to_string( e.children.size() ) );
                        self( self, e.children );
                        continue;
                    }
                    hash_part( state, e.group ? "group" : "item" );
                    hash_part( state, e.id );
                    hash_part( state, std::to_string( e.probability ) );
                    hash_part( state, e.variant );
                    if( e.variant_specified && e.variant.empty() ) {
                        hash_part( state, "explicit_empty_variant" );
                    }
                    if( e.count_specified && e.count_min == 1 && e.count_max == 1 ) {
                        hash_part( state, "explicit_single_count" );
                    }
                    hash_part( state, std::to_string( e.count_min ) );
                    hash_part( state, std::to_string( e.count_max ) );
                    hash_part( state, std::to_string( e.charges_min ) );
                    hash_part( state, std::to_string( e.charges_max ) );
                    if( e.charges_specified && e.charges_min == -1 && e.charges_max == -1 ) {
                        hash_part( state, "explicit_default_charges" );
                    }
                    if( e.wrapper_variant ) {
                        hash_part( state, "wrapper_variant" );
                        hash_part( state, *e.wrapper_variant );
                    }
                    if( e.sealed ) {
                        hash_part( state, *e.sealed ? "sealed" : "unsealed" );
                    }
                    if( e.active ) {
                        hash_part( state, *e.active ? "active" : "inactive" );
                    }
                    hash_part( state, e.container ? ( e.container->group ? "container_group" :
                                                      "container" ) : "default_container" );
                    hash_part( state, e.container ? e.container->id : "" );
                    if( e.ammo ) {
                        hash_part( state, e.ammo->group ? "ammo_group" : "ammo_item" );
                        hash_part( state, e.ammo->id );
                    }
                    if( e.artifact ) {
                        hash_part( state, "artifact" );
                        hash_part( state, e.artifact->id.str() );
                        hash_part( state, std::to_string( e.artifact->rules.power_level ) );
                        hash_part( state, std::to_string( e.artifact->rules.max_attributes ) );
                        hash_part( state, std::to_string( e.artifact->rules.max_negative_power ) );
                        hash_part( state, e.artifact->rules.resonant ? "resonant" : "ordinary" );
                    }
                    for( const std::string &flag : e.flags ) {
                        hash_part( state, "flag" );
                        hash_part( state, flag );
                    }
                    for( const std::string &component : e.components ) {
                        hash_part( state, "component" );
                        hash_part( state, component );
                    }
                    if( e.variables ) {
                        hash_part( state, "variables" );
                        hash_part( state, std::to_string( e.variables->size() ) );
                        for( const auto &[key, value] : *e.variables ) {
                            std::ostringstream encoded;
                            JsonOut out( encoded, false );
                            value.serialize( out );
                            hash_part( state, key );
                            hash_part( state, encoded.str() );
                        }
                    }
                    hash_part( state, e.wrapper ? "wrapper" : "no_wrapper" );
                    hash_part( state, e.wrapper.value_or( "" ) );
                    if( e.damage ) {
                        hash_part( state, "damage" );
                        hash_part( state, std::to_string( e.damage->first ) );
                        hash_part( state, std::to_string( e.damage->second ) );
                    }
                    if( e.dirt ) {
                        hash_part( state, "dirt" );
                        hash_part( state, std::to_string( e.dirt->first ) );
                        hash_part( state, std::to_string( e.dirt->second ) );
                    }
                    if( !e.contents.empty() ) {
                        hash_part( state, "contents" );
                        hash_part( state, std::to_string( e.contents.size() ) );
                        for( const auto &child : e.contents ) {
                            hash_part( state, child.group ? "group" : "item" );
                            hash_part( state, child.id );
                        }
                    }
                }
            };
            for( const auto &entry : pimpl_->item_groups ) {
                const auto &v = *entry.definition;
                hash_part( state, "item_group" );
                hash_part( state, operation_name( entry.operation ) );
                hash_part( state, v.id );
                hash_part( state, v.kind );
                hash_part( state, std::to_string( v.with_ammo ) );
                hash_part( state, std::to_string( v.with_magazine ) );
                if( v.container ) {
                    hash_part( state, "container" );
                    hash_part( state, *v.container );
                    if( v.container_variant ) {
                        hash_part( state, "container_variant" );
                        hash_part( state, *v.container_variant );
                    }
                    hash_part( state, io::enum_to_string( v.overflow ) );
                }
                if( !v.sealed ) {
                    hash_part( state, "unsealed" );
                }
                hash_entries( hash_entries, v.entries );
            }
            break;
        }
        case items_content_fingerprint_phase::requirements:
            for( const auto &entry : pimpl_->requirements ) {
                const auto &v = *entry.definition;
                hash_part( state, "requirement" );
                hash_part( state, operation_name( entry.operation ) );
                hash_part( state, v.id );
                hash_part( state, v.name );
                hash_part( state, v.merge ? "merge" : "whole" );
                const auto hash_groups = [&]( const requirement_definition_data &source ) {
                    for( const auto &g : source.components ) {
                        hash_part( state, "components" );
                        for( const auto &e : g ) {
                            hash_part( state, e.id );
                            hash_part( state, std::to_string( e.count ) );
                            hash_part( state, e.requirement ? "requirement" : "item" );
                        }
                    }
                    for( const auto &g : source.tools ) {
                        hash_part( state, "tools" );
                        for( const auto &e : g ) {
                            hash_part( state, e.id );
                            hash_part( state, std::to_string( e.count ) );
                            hash_part( state, e.requirement ? "requirement" : "item" );
                        }
                    }
                    for( const auto &g : source.qualities ) {
                        hash_part( state, "qualities" );
                        for( const auto &e : g ) {
                            hash_part( state, e.id );
                            hash_part( state, std::to_string( e.level ) );
                            hash_part( state, std::to_string( e.count ) );
                        }
                    }
                };
                hash_groups( v );
                if( v.alternatives ) {
                    hash_part( state, "alternatives" );
                    hash_groups( *v.alternatives );
                }
            }
            break;
        case items_content_fingerprint_phase::recipe_groups:
            for( const auto &entry : pimpl_->recipe_groups ) {
                const auto &v = *entry.definition;
                hash_part( state, "recipe_group" );
                hash_part( state, operation_name( entry.operation ) );
                hash_part( state, v.id );
                hash_part( state, v.building_type );
                for( const auto &r : v.recipes ) {
                    hash_part( state, r.id );
                    hash_part( state, r.description );
                    for( const auto &t : r.terrains ) {
                        hash_part( state, t.overmap_terrain );
                        hash_part( state, t.match_type );
                        for( const auto &[p, values] : t.parameters ) {
                            hash_part( state, p );
                            for( const auto &value : values ) {
                                hash_part( state, value );
                            }
                        }
                    }
                }
            }
            break;
        case items_content_fingerprint_phase::definitions:
            for( const auto &entry : pimpl_->items ) {
                const auto &v = *entry.definition;
                hash_part( state, "item" );
                hash_part( state, operation_name( entry.operation ) );
                hash_part( state, v.is_abstract ? "abstract" : "concrete" );
                // An omitted patch field inherits its source; an explicitly
                // supplied default value overwrites it. Both have identical
                // stored values, so include presence in the reload fingerprint.
                for( const bool present : {
                         v.has_name, v.has_description, v.has_symbol,
                         v.has_mass, v.has_volume, v.has_price, v.has_price_postapoc,
                         v.has_color, v.has_category, v.has_looks_like, v.has_magazine_capacity
                     } ) {
                    hash_part( state, present ? "present" : "absent" );
                }
                hash_part( state, v.id );
                hash_part( state, v.copy_from );
                hash_part( state, v.name );
                hash_part( state, v.description );
                const auto hash_text = [&state]( const std::optional<localized_text> &text ) {
                    hash_part( state, text ? "localized" : "literal" );
                    if( text ) {
                        hash_part( state, text->context ? "context" : "no_context" );
                        hash_part( state, text->context.value_or( "" ) );
                        hash_part( state, text->plural ? "plural" : "no_plural" );
                        hash_part( state, text->plural.value_or( "" ) );
                    }
                };
                hash_text( v.translated_name );
                hash_text( v.translated_description );
                hash_part( state, v.symbol );
                hash_part( state, std::to_string( v.mass_grams ) );
                if( v.mass_milligrams ) {
                    hash_part( state, "mass_milligrams" );
                    hash_part( state, std::to_string( *v.mass_milligrams ) );
                }
                hash_part( state, std::to_string( v.volume_ml ) );
                hash_part( state, v.longest_side ? std::to_string( units::to_millimeter( *v.longest_side ) ) :
                           "inherit_length" );
                hash_part( state, std::to_string( v.price_cents ) );
                hash_part( state, std::to_string( v.price_postapoc_cents ) );
                hash_part( state, v.color );
                hash_part( state, v.category );
                hash_part( state, v.looks_like );
                hash_part( state, v.ascii_picture.value_or( "inherit_picture" ) );
                hash_part( state, v.snippet_category.value_or( "inherit_snippets" ) );
                hash_part( state, v.melee_to_hit ? std::to_string( *v.melee_to_hit ) : "inherit_accuracy" );
                hash_part( state, v.electronic_size_kb ? std::to_string( *v.electronic_size_kb ) : "inherit_file_size" );
                hash_part( state, v.stackable ? ( *v.stackable ? "stackable" : "nonstackable" ) : "inherit_stackable" );
                hash_part( state, v.stack_size ? std::to_string( *v.stack_size ) : "inherit_stack_size" );
                hash_part( state, v.light ? std::to_string( *v.light ) : "inherit_light" );
                hash_part( state, v.max_worn ? std::to_string( *v.max_worn ) : "inherit_max_worn" );
                hash_part( state, v.insulation ? std::to_string( *v.insulation ) : "inherit_insulation" );
                hash_part( state, v.display_type ? std::to_string( static_cast<int>( *v.display_type ) ) :
                           "inherit_display_type" );
                hash_part( state, v.expand_snippets ? ( *v.expand_snippets ? "expand" : "unexpanded" ) :
                           "inherit_expand_snippets" );
                for( const auto &list : {
                         &v.techniques, &v.weapon_categories, &v.field_emissions, &v.repair_materials,
                         &v.removed_techniques, &v.removed_qualities
                     } ) {
                    hash_part( state, *list ? std::to_string( ( *list )->size() ) : "inherit_list" );
                    if( *list ) {
                        for( const auto &id : **list ) {
                            hash_part( state, id );
                        }
                    }
                }
                hash_part( state, v.phase ? std::to_string( static_cast<int>( *v.phase ) ) :
                           "inherit_phase" );
                hash_part( state, v.fall_damage_reduction ? std::to_string( *v.fall_damage_reduction ) :
                           "inherit_fall_damage_reduction" );
                hash_part( state, v.repair_like ? v.repair_like->str() : "inherit_repair_like" );
                hash_part( state, v.source_monster ? v.source_monster->str() : "inherit_source_monster" );
                for( const auto &[field, member] : item_measurement_changes::fields ) {
                    if( const auto &change = v.measurements.*member ) {
                        hash_part( state, field );
                        if( change->factor ) {
                            std::ostringstream factor;
                            factor << std::hexfloat << *change->factor;
                            hash_part( state, factor.str() );
                        } else {
                            hash_part( state, std::to_string( change->offset ) );
                        }
                    }
                }
                for( const auto &[original, replacement] : v.material_replacements ) {
                    hash_part( state, "replace_material" );
                    hash_part( state, original.str() );
                    hash_part( state, replacement.str() );
                }
                for( const auto &[id, weight] : v.faults ) {
                    hash_part( state, "item_fault" );
                    hash_part( state, id.str() );
                    hash_part( state, std::to_string( weight ) );
                }
                for( const auto &[weight, extra, multiplier, id] : v.fault_groups ) {
                    std::ostringstream factor;
                    factor << std::hexfloat << multiplier;
                    hash_part( state, "item_fault_group" );
                    hash_part( state, id );
                    hash_part( state, std::to_string( weight ) );
                    hash_part( state, std::to_string( extra ) );
                    hash_part( state, factor.str() );
                }
                if( v.throwing_damage ) {
                    hash_part( state, "throwing_damage" );
                    hash_item_damage( state, *v.throwing_damage );
                }
                if( v.throwing_recovery_chance ) {
                    hash_part( state, "throwing_recovery_chance" );
                    hash_part( state, std::to_string( *v.throwing_recovery_chance ) );
                }
                if( v.replace_throw_correction ) {
                    hash_part( state, v.throw_correction ? "replace_throw_correction" : "clear_throw_correction" );
                    if( v.throw_correction ) {
                        hash_throw_correction( state, *v.throw_correction );
                    }
                }
                if( v.minimum_skills ) {
                    hash_part( state, "minimum_skills" );
                    hash_part( state, std::to_string( v.minimum_skills->size() ) );
                    for( const auto &[skill, level] : *v.minimum_skills ) {
                        hash_part( state, skill.str() );
                        hash_part( state, std::to_string( level ) );
                    }
                }
                if( v.clear_mounted_charge ) {
                    hash_part( state, "clear_mounted_charge" );
                } else if( v.mounted_charge ) {
                    std::ostringstream factors;
                    factors << std::hexfloat << v.mounted_charge->multiplier_per_step << ' '
                            << v.mounted_charge->max_multiplier;
                    hash_part( state, "mounted_charge" );
                    hash_part( state, v.mounted_charge->damage_type );
                    hash_part( state, std::to_string( v.mounted_charge->max_steps ) );
                    hash_part( state, factors.str() );
                }
                for( const auto *adjustment : { &v.melee_factors, &v.melee_bonuses } ) {
                    if( *adjustment ) {
                        const item_melee_damage &damage = **adjustment;
                        const std::map<damage_type_id, float> ordered( damage.damage_map.begin(),
                                damage.damage_map.end() );
                        hash_part( state, damage.default_value == 1.0f ? "melee_factors" : "melee_bonuses" );
                        for( const auto &[type, value] : ordered ) {
                            std::ostringstream exact;
                            exact << std::hexfloat << value;
                            hash_part( state, type.str() );
                            hash_part( state, exact.str() );
                        }
                    }
                }
                hash_part( state, v.replace_qualities ? "replace_qualities" : "inherit_qualities" );
                if( v.charged_qualities ) {
                    hash_part( state, "charged_qualities" );
                    hash_part( state, std::to_string( v.charged_qualities->size() ) );
                    for( const quality_level &quality : *v.charged_qualities ) {
                        std::ostringstream speed;
                        speed << std::hexfloat << quality.speed;
                        hash_part( state, quality.id );
                        hash_part( state, std::to_string( quality.level ) );
                        hash_part( state, speed.str() );
                    }
                }
                for( const auto &[quality, offset] : v.quality_adjustments ) {
                    hash_part( state, "adjust_quality" );
                    hash_part( state, quality.str() );
                    hash_part( state, std::to_string( offset ) );
                }
                hash_part( state, v.replace_pockets ? "replace_pockets" : "inherit_pockets" );
                hash_part( state, v.variant_kind ? std::to_string( static_cast<int>( *v.variant_kind ) ) :
                           "inherit_variant_kind" );
                if( v.variants ) {
                    hash_part( state, "replace_item_variants" );
                    for( const auto &variant : *v.variants ) {
                        hash_part( state, variant.id );
                        hash_part( state, variant.name.raw );
                        hash_text( variant.name.translated );
                        hash_part( state, variant.description );
                        hash_part( state, variant.symbol.value_or( "inherit_symbol" ) );
                        hash_part( state, variant.color.value_or( "inherit_color" ) );
                        hash_part( state, variant.ascii_picture );
                        hash_part( state, std::to_string( variant.weight ) );
                        hash_part( state, variant.append ? "append" : "replace" );
                        hash_part( state, variant.expand_snippets ? "expand" : "keep_snippets" );
                    }
                }
                if( v.conditional_names ) {
                    hash_part( state, "replace_item_conditional_names" );
                    hash_part( state, std::to_string( v.conditional_names->size() ) );
                    for( const auto &rule : *v.conditional_names ) {
                        hash_part( state, std::to_string( rule.kind ) );
                        hash_part( state, rule.key );
                        hash_part( state, rule.value );
                        hash_part( state, rule.name.raw );
                        hash_text( rule.name.translated );
                    }
                }
                hash_part( state, v.default_container ? "container" : "inherit_container" );
                hash_part( state, v.default_container.value_or( "" ) );
                hash_part( state, std::to_string( v.magazine_capacity ) );
                hash_part( state, v.clear_use_actions ? "clear_use_actions" : "inherit_use_actions" );
                hash_part( state, v.deploy_appliance );
                if( v.reveal_map ) {
                    hash_part( state, "reveal_map" );
                    hash_part( state, std::to_string( v.reveal_map->radius ) );
                    hash_part( state, v.reveal_map->atlas_jurisdiction );
                    hash_part( state, v.reveal_map->message );
                    for( const auto &[target, match] : v.reveal_map->terrains ) {
                        hash_part( state, target );
                        hash_part( state, std::to_string( static_cast<int>( match ) ) );
                    }
                }
                hash_part( state, std::to_string( v.native_use_actions.size() ) );
                for( const auto &action : v.native_use_actions ) {
                    hash_part( state, action );
                }
                hash_part( state, v.martial_arts_manual ? "martial_arts_manual" : "inherit_manual" );
                hash_part( state, v.clear_flags ? "clear_item_flags" : "inherit_item_flags" );
                hash_part( state, v.clear_melee_damage ? "clear_melee_damage" : "inherit_melee_damage" );
                hash_part( state, v.clear_tick_actions ? "clear_tick_actions" : "inherit_tick_actions" );
                for( const std::string &action : v.native_tick_actions ) {
                    hash_part( state, "native_on_tick" );
                    hash_part( state, action );
                }
                if( v.tick_transform ) {
                    hash_part( state, "transform_on_tick" );
                    hash_item_transform_action( state, *v.tick_transform );
                }
                if( v.tick_sound ) {
                    const auto &sound = *v.tick_sound;
                    hash_part( state, "sound_on_tick" );
                    hash_part( state, sound.message );
                    hash_part( state, std::to_string( sound.actor.sound_volume ) );
                    hash_part( state, io::enum_to_string( sound.actor.sound_type ) );
                    hash_part( state, sound.actor.sound_id );
                    hash_part( state, sound.actor.sound_variant );
                }
                if( v.tick_music ) {
                    const auto &music = *v.tick_music;
                    hash_part( state, "music_on_tick" );
                    for( const int value : { music.actor.volume, music.actor.fun, music.actor.fun_bonus,
                                             music.actor.speed_penalty, to_turns<int>( music.actor.description_frequency ) } ) {
                        hash_part( state, std::to_string( value ) );
                    }
                    for( const auto *texts : { &music.player_text, &music.npc_text } ) {
                        hash_part( state, std::to_string( texts->size() ) );
                        for( const authored_text &message : *texts ) {
                            hash_part( state, message );
                        }
                    }
                }
                hash_part( state, v.tick_handler );
                hash_part( state, v.has_tool ? "tool" : "inherit_tool" );
                if( v.tool ) {
                    for( const auto &setting : item_definition_data::tool_data::charge_settings ) {
                        const auto &charge = ( *v.tool ).*setting.authored;
                        hash_part( state, charge ? std::to_string( *charge ) : "inherit" );
                    }
                    hash_part( state, v.tool->power_draw ?
                               std::to_string( units::to_milliwatt( *v.tool->power_draw ) ) : "inherit_power" );
                    hash_part( state, v.tool->subtype ? v.tool->subtype->str() : "inherit_subtype" );
                    if( v.tool->revert_message ) {
                        hash_part( state, "tool_revert_message" );
                        hash_part( state, *v.tool->revert_message );
                    }
                    hash_part( state, v.tool->ammo_types ? "tool_ammo" : "inherit_tool_ammo" );
                    if( v.tool->ammo_types ) {
                        for( const std::string &ammo : *v.tool->ammo_types ) {
                            hash_part( state, ammo );
                        }
                    }
                }
                for( const auto &authored : v.pockets ) {
                    const pocket_data &pocket = authored.native;
                    hash_part( state, io::enum_to_string( pocket.type ) );
                    hash_part( state, std::to_string( pocket.ememory_max / 1_KB ) );
                    for( const auto &[ammo, capacity] : pocket.ammo_restriction ) {
                        hash_part( state, "pocket_ammo" );
                        hash_part( state, ammo.str() );
                        hash_part( state, std::to_string( capacity ) );
                    }
                    hash_part( state, std::to_string( units::to_milliliter( pocket.raw_volume_capacity ) ) );
                    hash_part( state, std::to_string( units::to_milligram( pocket.max_contains_weight ) ) );
                    hash_part( state, std::to_string( units::to_millimeter( pocket.max_item_length ) ) );
                    hash_part( state, std::to_string( units::to_millimeter( pocket.min_item_length ) ) );
                    hash_part( state, std::to_string( units::to_milliliter( pocket.min_item_volume ) ) );
                    hash_part( state, pocket.max_item_volume ?
                               std::to_string( units::to_milliliter( *pocket.max_item_volume ) ) : "no_maximum_item_volume" );
                    hash_part( state, std::to_string( units::to_milliliter( pocket.magazine_well ) ) );
                    hash_part( state, std::to_string( pocket.moves ) );
                    hash_part( state, std::to_string( pocket.weight_multiplier ) );
                    hash_part( state, std::to_string( pocket.volume_encumber_modifier ) );
                    std::ostringstream factors;
                    factors << std::hexfloat << pocket.spoil_multiplier << ' ' << pocket.volume_multiplier << ' '
                            << pocket.insulation;
                    if( pocket.sealed_data ) {
                        factors << ' ' << pocket.sealed_data->spoil_multiplier;
                    }
                    hash_part( state, factors.str() );
                    for( const bool option : { pocket.watertight, pocket.airtight, pocket.open_container,
                                              pocket.transparent, pocket.fire_protection, pocket.rigid, pocket.holster,
                                              pocket.forbidden } ) {
                        hash_part( state, option ? "yes" : "no" );
                    }
                    hash_part( state, pocket.default_magazine.str() );
                    hash_part( state, authored.description );
                    for( const material_id &material : pocket.material_restriction ) {
                        hash_part( state, "allowed_material" );
                        hash_part( state, material.str() );
                    }
                    for( const flag_id &flag : pocket.get_flag_restrictions() ) {
                        hash_part( state, "allowed_flag" );
                        hash_part( state, flag.str() );
                    }
                    for( const itype_id &item_id : pocket.item_id_restriction ) {
                        hash_part( state, "allowed_item" );
                        hash_part( state, item_id.str() );
                    }
                }
                hash_part( state, v.has_armor ? "armor" : "inherit_armor" );
                if( v.armor ) {
                    hash_part( state, v.armor->warmth ? std::to_string( *v.armor->warmth ) : "inherit_warmth" );
                    hash_part( state, v.armor->max_worn ? std::to_string( *v.armor->max_worn ) : "inherit_max_worn" );
                }
                for( const auto &portion : v.armor_portions ) {
                    hash_part( state, "armor_portion" );
                    hash_part( state, std::to_string( portion.encumbrance ) );
                    hash_part( state, std::to_string( portion.coverage ) );
                    hash_part( state, std::to_string( portion.material_thickness ) );
                    hash_part( state, std::to_string( portion.environmental_protection ) );
                    for( const std::string &material : portion.materials ) {
                        hash_part( state, "armor_material" );
                        hash_part( state, material );
                    }
                    for( const std::string &part : portion.covers ) {
                        hash_part( state, "body_part" );
                        hash_part( state, part );
                    }
                    for( const std::string &part : portion.sub_parts ) {
                        hash_part( state, "sub_part" );
                        hash_part( state, part );
                    }
                }
                for( const auto &[ammo, capacity] : v.ammo_pocket ) {
                    hash_part( state, "ammo_pocket" );
                    hash_part( state, ammo );
                    hash_part( state, std::to_string( capacity ) );
                }
                for( const std::string &enchantment : v.passive_enchantments ) {
                    hash_part( state, "passive_enchantment" );
                    hash_part( state, enchantment );
                }
                hash_part( state, v.deploy_furniture );
                hash_part( state, v.capture_size );
                if( v.use_message ) {
                    hash_part( state, "message_on_use" );
                    hash_part( state, v.use_message->name );
                    hash_part( state, v.use_message->message );
                }
                if( v.cable_link ) {
                    const auto &link = *v.cable_link;
                    const link_up_actor &actor = link.actor;
                    hash_part( state, "link_cable" );
                    hash_part( state, link.menu_text );
                    hash_part( state, std::to_string( actor.cable_length ) );
                    hash_part( state, std::to_string( units::to_milliwatt( actor.charge_rate ) ) );
                    hash_part( state, std::to_string( actor.move_cost ) );
                    std::ostringstream efficiency;
                    efficiency << std::hexfloat << actor.efficiency;
                    hash_part( state, efficiency.str() );
                    hash_part( state, link.ammo_scale ? std::to_string( *link.ammo_scale ) : "inherit_ammo_scale" );
                    for( const link_state target : actor.targets ) {
                        hash_part( state, "target" );
                        hash_part( state, io::enum_to_string( target ) );
                    }
                    for( const std::string &id : actor.can_extend ) {
                        hash_part( state, "can_extend" );
                        hash_part( state, id );
                    }
                }
                if( v.play_instrument ) {
                    hash_part( state, "play_instrument" );
                }
                if( v.healing ) {
                    const heal_actor &heal = *v.healing;
                    hash_part( state, "heal" );
                    hash_part( state, std::to_string( heal.move_cost ) );
                    hash_part( state, std::to_string( heal.bleed ) );
                    std::ostringstream values;
                    values << std::hexfloat;
                    for( float value : { heal.limb_power, heal.head_power, heal.torso_power,
                                         heal.limb_scaling, heal.head_scaling, heal.torso_scaling,
                                         heal.bandages_power, heal.bandages_scaling, heal.disinfectant_power,
                                         heal.disinfectant_scaling, heal.bite, heal.infect } ) {
                        values << value << ' ';
                    }
                    hash_part( state, values.str() );
                    hash_part( state, heal.used_up_item_id.str() );
                    hash_part( state, std::to_string( heal.used_up_item_quantity ) );
                    hash_part( state, std::to_string( heal.used_up_item_charges ) );
                    for( const flag_id &flag : heal.used_up_item_flags ) {
                        hash_part( state, flag.str() );
                    }
                }
                for( const auto *entry : { &v.transform_use, &v.delayed_transform_use } ) {
                    if( *entry ) {
                        hash_item_transform_action( state, **entry );
                    }
                }
                if( v.transform_result ) {
                    hash_part( state, "automatic_transform" );
                    hash_item_transformation( state, *v.transform_result );
                }
                if( v.countdown_interval ) {
                    hash_part( state, "countdown" );
                    hash_part( state, std::to_string( to_turns<int>( *v.countdown_interval ) ) );
                }
                if( v.spell_use ) {
                    hash_item_spell_action( state, *v.spell_use );
                }
                if( const auto *action = std::get_if<std::string>( &v.expiry_action ) ) {
                    hash_part( state, "native_on_expiry" );
                    hash_part( state, *action );
                } else if( const auto *spell = std::get_if<cast_spell_actor>( &v.expiry_action ) ) {
                    hash_part( state, "spell_on_expiry" );
                    hash_item_spell_action( state, *spell );
                }
                if( !v.assembled_belt.is_empty() ) {
                    hash_part( state, "ammobelt" );
                    hash_part( state, v.assembled_belt.str() );
                }
                if( v.activation ) {
                    hash_part( state, "activate_effects" );
                    hash_part( state, v.activation->message );
                    hash_part( state, std::to_string( v.activation->move_cost ) );
                    for( const auto &effect : v.activation->effects ) {
                        hash_part( state, effect.id );
                        hash_part( state, std::to_string( effect.duration_turns ) );
                        hash_part( state, std::to_string( effect.intensity ) );
                        hash_part( state, effect.permanent ? "permanent" : "temporary" );
                    }
                }
                if( !v.learned_spells.empty() ) {
                    hash_part( state, "learn_spells" );
                    for( const std::string &spell : v.learned_spells ) {
                        hash_part( state, spell );
                    }
                }
                hash_part( state, v.use_handler );
                hash_part( state, v.use_label.raw );
                hash_text( v.use_label.translated );
                hash_part( state, v.use_description ? "use_description" : "no_use_description" );
                if( v.use_description ) {
                    hash_part( state, v.use_description->raw );
                    hash_text( v.use_description->translated );
                }
                hash_part( state, v.consume_handler );
                if( v.ammunition ) {
                    const item_definition_data::ammunition_data &ammo = *v.ammunition;
                    hash_part( state, "ammunition" );
                    hash_part( state, ammo.type );
                    hash_part( state, ammo.count ? std::to_string( *ammo.count ) : "inherited_count" );
                    hash_part( state, ammo.stack_size ? std::to_string( *ammo.stack_size ) : "inherited_stack_size" );
                    if( ammo.damage ) {
                        hash_part( state, "ammo_damage" );
                        hash_item_damage( state, *ammo.damage );
                    }
                    if( ammo.dispersion ) {
                        hash_part( state, "ammo_dispersion" );
                        hash_part( state, std::to_string( *ammo.dispersion ) );
                    }
                    if( ammo.loudness ) {
                        hash_part( state, "ammo_loudness" );
                        hash_part( state, std::to_string( *ammo.loudness ) );
                    }
                    if( ammo.recovery_chance ) {
                        hash_part( state, "ammo_recovery_chance" );
                        hash_part( state, std::to_string( *ammo.recovery_chance ) );
                    }
                }
                if( v.comestible ) {
                    const item_definition_data::comestible_data &food = *v.comestible;
                    hash_part( state, "comestible" );
                    hash_part( state, food.type );
                    hash_part( state, std::to_string( food.calories ) );
                    hash_part( state, std::to_string( food.fun ) );
                    hash_part( state, std::to_string( food.healthy ) );
                    hash_part( state, std::to_string( food.quench ) );
                    hash_part( state, std::to_string( food.spoils_in_turns ) );
                    hash_part( state, std::to_string( food.freezing_point_celsius ) );
                    hash_part( state, std::to_string( food.charges ) );
                    hash_part( state, std::to_string( food.stack_size ) );
                    for( const auto &[vitamin_key, amount] : food.vitamins ) {
                        hash_part( state, vitamin_key );
                        hash_part( state, std::to_string( amount ) );
                    }
                }
                if( v.book ) {
                    const item_definition_data::book_data &book = *v.book;
                    hash_part( state, "book" );
                    hash_part( state, book.skill );
                    hash_part( state, book.martial_art );
                    hash_part( state, std::to_string( book.required_level ) );
                    hash_part( state, std::to_string( book.maximum_level ) );
                    hash_part( state, std::to_string( book.intelligence ) );
                    hash_part( state, std::to_string( book.read_time_turns ) );
                    hash_part( state, std::to_string( book.fun ) );
                    hash_part( state, std::to_string( book.chapters ) );
                    hash_part( state, book.scannable ? "scannable" : "unscannable" );
                    hash_part( state, book.generic ? "generic" : "specific" );
                    for( const book_proficiency_bonus &bonus : book.proficiencies ) {
                        hash_part( state, bonus.id.str() );
                        std::ostringstream factors;
                        factors << std::hexfloat << bonus.time_factor << ' ' << bonus.fail_factor << ' ' << bonus.cap;
                        hash_part( state, factors.str() );
                        hash_part( state, bonus.include_prereqs ? "include_prerequisites" : "no_prerequisites" );
                    }
                }
                for( const auto &m : v.materials ) {
                    hash_part( state, m.id );
                    hash_part( state, std::to_string( m.portions ) );
                }
                for( const auto &q : v.qualities ) {
                    hash_part( state, q.id );
                    hash_part( state, std::to_string( q.level ) );
                    hash_part( state, std::to_string( q.speed ) );
                }
                for( const auto &id : v.flags ) {
                    hash_part( state, id );
                }
                for( const auto &[id, amount] : v.melee_damage ) {
                    hash_part( state, id );
                    hash_part( state, std::to_string( amount ) );
                }
                for( const auto &[id, amount] : v.magazine_ammo ) {
                    hash_part( state, id );
                    hash_part( state, std::to_string( amount ) );
                }
            }
            break;
        case items_content_fingerprint_phase::recipes: {
            const auto hash_qualities = [&]( const auto & groups ) {
                for( const auto &group : groups ) {
                    hash_part( state, "quality_group" );
                    for( const quality_requirement_definition &quality : group ) {
                        hash_part( state, quality.id );
                        hash_part( state, std::to_string( quality.level ) );
                        hash_part( state, std::to_string( quality.count ) );
                    }
                }
            };
            const auto hash_tools = [&]( const auto & groups ) {
                for( const auto &group : groups ) {
                    hash_part( state, "tool_group" );
                    for( const component_requirement &tool : group ) {
                        hash_part( state, tool.id );
                        hash_part( state, std::to_string( tool.count ) );
                        hash_part( state, tool.requirement ? "requirement" : "item" );
                    }
                }
            };
            const auto hash_components = [&]( const auto & groups ) {
                for( const auto &group : groups ) {
                    hash_part( state, "component_group" );
                    for( const component_requirement &component : group ) {
                        hash_part( state, component.id );
                        hash_part( state, std::to_string( component.count ) );
                        hash_part( state, component.requirement ? "requirement" : "item" );
                        hash_part( state, component.recoverable ? "recoverable" : "consumed" );
                    }
                }
            };
            const auto hash_blueprint_tokens = [&]( const char *name, const blueprint_tokens & tokens ) {
                hash_part( state, name );
                for( const auto &[id, amount] : tokens ) {
                    hash_part( state, id );
                    hash_part( state, std::to_string( amount ) );
                }
            };
            const auto hash_batch = [&]( const batch_savings & batch ) {
                if( const auto *linear = std::get_if<batch_savings::linear>( &batch.data ) ) {
                    hash_part( state, "linear" );
                    hash_part( state, std::to_string( linear->offset ) );
                    hash_part( state, std::to_string( linear->max_batch.value_or( 0 ) ) );
                } else if( const auto *logistic = std::get_if<batch_savings::logistic>( &batch.data ) ) {
                    hash_part( state, "logistic" );
                    hash_part( state, std::to_string( logistic->rscale ) );
                    hash_part( state, std::to_string( logistic->rsize ) );
                }
            };
            const auto hash_proficiencies = [&]( const std::vector<recipe_proficiency_data> &values ) {
                for( const recipe_proficiency_data &p : values ) {
                    hash_part( state, "recipe_proficiency" );
                    hash_part( state, p.id );
                    hash_part( state, p.required ? "required" : "optional" );
                    hash_part( state, std::to_string( p.time_multiplier ) );
                    hash_part( state, p.skill_penalty_assigned ? "assigned" : "default" );
                    hash_part( state, std::to_string( p.skill_penalty ) );
                    hash_part( state, std::to_string( p.learning_time_multiplier ) );
                    hash_part( state, p.max_experience ?
                               std::to_string( to_turns<int>( *p.max_experience ) ) : "unlimited" );
                }
            };
            for( const auto &entry : pimpl_->recipes ) {
                const auto &v = *entry.definition;
                hash_part( state, "recipe" );
                hash_part( state, operation_name( entry.operation ) );
                hash_part( state, v.id );
                hash_part( state, v.nested_category ? "nested_category" :
                           v.uncraft ? "uncraft_recipe" : "craft_recipe" );
                hash_part( state, v.result );
                hash_part( state, v.obsolete ? "obsolete" : "available" );
                hash_part( state, v.result_charges ?
                           std::to_string( *v.result_charges ) : "default_charges" );
                hash_part( state, std::to_string( v.result_multiplier ) );
                hash_qualities( v.qualities );
                hash_part( state, std::to_string( v.morale_bonus ) );
                hash_part( state, std::to_string( to_turns<int>( v.morale_duration ) ) );
                for( const auto &[id, level] : v.disassembly_learning ) {
                    hash_part( state, "disassembly_learning" );
                    hash_part( state, id );
                    hash_part( state, std::to_string( level ) );
                }
                hash_part( state, v.name );
                hash_part( state, v.description );
                hash_part( state, v.category );
                hash_part( state, v.subcategory );
                for( const std::string &flag : v.flags ) {
                    hash_part( state, flag );
                }
                hash_part( state, std::to_string( v.activity_level ) );
                for( const auto &[id, optional] : v.nested_recipes ) {
                    hash_part( state, id );
                    hash_part( state, optional ? "optional" : "required" );
                }
                hash_part( state, v.skill );
                hash_part( state, std::to_string( v.difficulty ) );
                hash_part( state, std::to_string( v.time_moves ) );
                hash_part( state, v.autolearn ? "autolearn" : "manual" );
                hash_part( state, v.never_learn ? "never_learn" : "learnable" );
                if( const auto &practice = v.practice ) {
                    hash_part( state, "recipe_practice" );
                    hash_part( state, std::to_string( practice->min_difficulty ) );
                    hash_part( state, std::to_string( practice->max_difficulty ) );
                    hash_part( state, std::to_string( practice->skill_limit ) );
                }
                hash_part( state, std::to_string( v.character_resources.mana ) );
                hash_part( state, std::to_string( v.character_resources.stamina ) );
                for( const auto &[stat, minimum] : v.required_stats ) {
                    hash_part( state, "recipe_stat_requirement" );
                    hash_part( state, std::to_string( static_cast<int>( stat ) ) );
                    hash_part( state, std::to_string( minimum ) );
                }
                hash_part( state, v.reversible ? "reversible" : "irreversible" );
                hash_part( state, v.variant );
                hash_part( state, v.container );
                hash_part( state, v.container_variant );
                hash_part( state, v.contained ? "contained" : "uncontained" );
                hash_part( state, v.sealed ? "sealed" : "unsealed" );
                hash_batch( v.batching );
                hash_part( state, std::to_string( v.disassembly_moves ) );
                for( const recipe_step_definition_data &step : v.steps ) {
                    hash_part( state, "recipe_step" );
                    hash_part( state, step.name );
                    hash_part( state, std::to_string( step.moves ) );
                    hash_part( state, std::to_string( step.activity ) );
                    hash_part( state, step.attention == step_attention::unattended ? "unattended" : "none" );
                    hash_part( state, step.unattended_message );
                    hash_part( state, step.max_time ? std::to_string( to_turns<int>( *step.max_time ) ) : "no_max_time" );
                    hash_part( state, step.grace_period ? std::to_string( to_turns<int>( *step.grace_period ) ) : "no_grace_period" );
                    hash_batch( step.batching );
                    hash_qualities( step.qualities );
                    hash_tools( step.tools );
                    for( const auto &[id, amount] : step.requirements ) {
                        hash_part( state, "step_requirement" );
                        hash_part( state, id );
                        hash_part( state, std::to_string( amount ) );
                    }
                    hash_proficiencies( step.proficiencies );
                }
                for( const std::string &flag : v.removed_result_flags ) {
                    hash_part( state, "removed_result_flag" );
                    hash_part( state, flag );
                }
                for( const auto &[id, count] : v.byproducts ) {
                    hash_part( state, "byproduct" );
                    hash_part( state, id );
                    hash_part( state, std::to_string( count ) );
                }
                hash_part( state, v.byproduct_group );
                if( const auto &blueprint = v.blueprint ) {
                    hash_part( state, "camp_blueprint" );
                    hash_part( state, blueprint->update );
                    hash_part( state, blueprint->name );
                    for( const std::string &resource : blueprint->resources ) {
                        hash_part( state, "blueprint_resource" );
                        hash_part( state, resource );
                    }
                    hash_blueprint_tokens( "blueprint_provides", blueprint->provides );
                    hash_blueprint_tokens( "blueprint_requires", blueprint->requires_tokens );
                    hash_blueprint_tokens( "blueprint_excludes", blueprint->excludes );
                    for( const auto &[parameter, labels] : blueprint->parameter_labels ) {
                        hash_part( state, "blueprint_parameter" );
                        hash_part( state, parameter );
                        for( const auto &[value, label] : labels ) {
                            hash_part( state, value );
                            hash_part( state, label );
                        }
                    }
                    hash_part( state, blueprint->check_needs ? "check_needs" : "unchecked_needs" );
                    if( const auto &needs = blueprint->needs ) {
                        hash_part( state, "explicit_needs" );
                        hash_part( state, std::to_string( needs->time ) );
                        for( const auto &[skill, level] : needs->skills ) {
                            hash_part( state, skill );
                            hash_part( state, std::to_string( level ) );
                        }
                        hash_components( needs->components );
                        hash_tools( needs->tools );
                        hash_qualities( needs->qualities );
                    }
                }
                for( const auto &[skill, level] : v.autolearn_skills ) {
                    hash_part( state, "autolearn_skill" );
                    hash_part( state, skill );
                    hash_part( state, std::to_string( level ) );
                }
                hash_components( v.components );
                hash_tools( v.tools );
                for( const auto &[id, level] : v.required_skills ) {
                    hash_part( state, id );
                    hash_part( state, std::to_string( level ) );
                }
                for( const auto &[id, amount] : v.external_requirements ) {
                    hash_part( state, id );
                    hash_part( state, std::to_string( amount ) );
                }
                hash_proficiencies( v.proficiencies );
                for( const auto &[id, book] : v.books ) {
                    hash_part( state, id );
                    hash_part( state, std::to_string( book.level ) );
                    hash_part( state, book.name );
                    hash_part( state, book.hidden ? "hidden" : "visible" );
                }
                hash_part( state, v.result_handler );
                hash_part( state, v.scripted_output ? "scripted_output" : "ordinary_output" );
            }
            for( const auto &entry : pimpl_->plant_lifecycles ) {
                hash_part( state, "plant_lifecycle" );
                hash_part( state, operation_name( entry.operation ) );
                hash_part( state, entry.definition->target );
                hash_part( state, entry.definition->id );
                for( const auto &[id, handler] : entry.definition->handlers ) {
                    hash_part( state, id );
                    hash_part( state, handler );
                }
            }
            break;
        }
    }
}

} // namespace cata::lua_platform

#else

namespace cata::lua_platform
{

struct items_content_transaction::impl {};

items_content_transaction::items_content_transaction( std::string, std::size_t ) :
    pimpl_( std::make_unique<impl>() )
{}

items_content_transaction::~items_content_transaction() = default;

bool items_content_transaction::validate( const runtime &, bool,
        const items_content_validation_context &, std::string &error ) const
{
    error = "Lua-first Platform is not enabled in this build";
    return false;
}

bool items_content_transaction::validate_scaled_requirement_set(
    const std::vector<std::pair<std::string, std::int64_t>> &, std::string &error ) const
{
    error = "Lua-first Platform is not enabled in this build";
    return false;
}

bool items_content_transaction::apply_phase( items_content_apply_phase, std::string &error )
{
    error = "Lua-first Platform is not enabled in this build";
    return false;
}

bool items_content_transaction::validate_finalized( std::string &error ) const
{
    error = "Lua-first Platform is not enabled in this build";
    return false;
}

void items_content_transaction::rollback_phase( items_content_rollback_phase ) {}
void items_content_transaction::rollback_all() {}
void items_content_transaction::commit() {}
void items_content_transaction::seal() {}
void items_content_transaction::discard() {}
void items_content_transaction::append_fingerprint( items_content_fingerprint_phase,
        std::uint64_t & ) const {}
bool items_content_transaction::was_applied() const
{
    return false;
}
bool items_content_transaction::has_requirements() const
{
    return false;
}
bool items_content_transaction::has_requirement_changes() const
{
    return false;
}
items_content_staged_ids items_content_transaction::staged_ids() const
{
    return {};
}
bool items_content_transaction::defines_tool_quality( std::string_view ) const
{
    return false;
}
bool items_content_transaction::defines_skill( std::string_view ) const
{
    return false;
}
bool items_content_transaction::defines_vitamin( std::string_view ) const
{
    return false;
}
bool items_content_transaction::defines_json_flag( std::string_view ) const
{
    return false;
}
bool items_content_transaction::defines_math_function( std::string_view ) const
{
    return false;
}
bool items_content_transaction::defines_damage_type( std::string_view ) const
{
    return false;
}
bool items_content_transaction::defines_material( std::string_view ) const
{
    return false;
}
bool items_content_transaction::defines_proficiency( std::string_view ) const
{
    return false;
}
bool items_content_transaction::defines_item( std::string_view ) const
{
    return false;
}
bool items_content_transaction::defines_item_group( std::string_view ) const
{
    return false;
}
bool items_content_transaction::defines_recipe( std::string_view ) const
{
    return false;
}
bool items_content_transaction::defines_requirement( std::string_view ) const
{
    return false;
}
bool items_content_transaction::defines_scent_type( std::string_view ) const
{
    return false;
}
bool items_content_transaction::find_item_handler( std::string_view, std::string_view,
        std::string &handler_id ) const
{
    handler_id.clear();
    return false;
}
bool items_content_transaction::find_damage_handler( std::string_view, std::string_view,
        std::string &handler_id ) const
{
    handler_id.clear();
    return false;
}
bool items_content_transaction::find_ammo_effect_handler( std::string_view,
        std::string &handler_id ) const
{
    handler_id.clear();
    return false;
}
bool items_content_transaction::find_plant_lifecycle_handler( std::string_view, std::string_view,
        std::string_view, std::string &handler_id ) const
{
    handler_id.clear();
    return false;
}

} // namespace cata::lua_platform

#endif
