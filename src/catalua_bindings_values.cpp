#include "catalua_bindings_values.h"

#include <algorithm>
#include <array>
#include <cmath>
#include <iomanip>
#include <limits>
#include <optional>
#include <sstream>
#include <stdexcept>
#include <string>
#include <utility>

#include "ammo.h"
#include "ammo_effect.h"
#include "bionics.h"
#include "bodypart.h"
#include "calendar.h"
#include "catalua_bindings_coords.h"
#include "disease.h"
#include "effect.h"
#include "emit.h"
#include "faction.h"
#include "fault.h"
#include "field_type.h"
#include "flag.h"
#include "mapdata.h"
#include "martialarts.h"
#include "material.h"
#include "mission.h"
#include "mod_manager.h"
#include "monfaction.h"
#include "mongroup.h"
#include "monstergenerator.h"
#include "morale_types.h"
#include "mtype.h"
#include "mutation.h"
#include "omdata.h"
#include "recipe.h"
#include "requirements.h"
#include "skill.h"
#include "string_id.h"
#include "trap.h"
#include "type_id.h"
#include "vitamin.h"

namespace cata::lua_ui
{

namespace
{

using id_validator = bool ( * )( std::string_view );

template<typename T>
bool valid_id( const std::string_view value )
{
    return string_id<T>( std::string( value ) ).is_valid();
}

struct id_kind_definition {
    std::string_view name;
    id_validator validate;
};

const std::array<id_kind_definition, 37> &id_kind_definitions()
{
    static const std::array<id_kind_definition, 37> definitions = {{
            { "activity", &valid_id<activity_type> },
            { "ammo_effect", &valid_id<ammo_effect> },
            { "ammunition", &valid_id<ammunition_type> },
            { "bionic", &valid_id<bionic_data> },
            { "body_part", &valid_id<body_part_type> },
            { "disease", &valid_id<disease_type> },
            { "effect", &valid_id<effect_type> },
            { "emit", &valid_id<emit> },
            { "faction", &valid_id<faction> },
            { "fault", &valid_id<fault> },
            { "field", &valid_id<field_type> },
            { "furniture", &valid_id<furn_t> },
            { "item", &valid_id<itype> },
            { "json_flag", &valid_id<json_flag> },
            { "martial_art", &valid_id<martialart> },
            { "martial_art_buff", &valid_id<ma_buff> },
            { "martial_art_technique", &valid_id<ma_technique> },
            { "material", &valid_id<material_type> },
            { "mission", &valid_id<mission_type> },
            { "mod", &valid_id<MOD_INFORMATION> },
            { "monster", &valid_id<mtype> },
            { "monster_faction", &valid_id<monfaction> },
            { "monster_group", &valid_id<MonsterGroup> },
            { "morale", &valid_id<morale_type_data> },
            { "mutation", &valid_id<mutation_branch> },
            { "mutation_category", &valid_id<mutation_category_trait> },
            { "overmap_terrain", &valid_id<oter_t> },
            { "quality", &valid_id<quality> },
            { "recipe", &valid_id<recipe> },
            { "skill", &valid_id<Skill> },
            { "species", &valid_id<species_type> },
            { "spell", &valid_id<spell_type> },
            { "terrain", &valid_id<ter_t> },
            // CCB intentionally aliases character trait flags to json_flag.
            { "trait_flag", &valid_id<json_flag> },
            { "trap", &valid_id<trap> },
            { "vitamin", &valid_id<vitamin> },
            { "weapon_category", &valid_id<weapon_category> }
        }
    };
    return definitions;
}

const id_kind_definition *find_id_kind( const std::string_view kind )
{
    const auto &definitions = id_kind_definitions();
    const auto found = std::lower_bound(
                           definitions.begin(), definitions.end(), kind,
    []( const id_kind_definition & entry, const std::string_view key ) {
        return entry.name < key;
    } );
    return found != definitions.end() && found->name == kind ? &*found : nullptr;
}

void validate_id_text( const std::string &value )
{
    if( value.size() > 256 ) {
        throw std::invalid_argument( "game.types.id value exceeds 256 bytes" );
    }
    if( std::any_of( value.begin(), value.end(), []( const unsigned char ch ) {
    return ch == '\0' || ch < 0x20U || ch == 0x7fU;
} ) ) {
        throw std::invalid_argument(
            "game.types.id value cannot contain control characters" );
    }
}

struct unit_conversion {
    std::string_view name;
    long double factor;
    long double offset;
};

struct unit_kind_definition {
    std::string_view name;
    std::string_view canonical_unit;
    bool integral;
    const unit_conversion *conversions;
    std::size_t conversion_count;
};

constexpr std::array<unit_conversion, 2> angle_conversions = {{
        { "degree", 0.017453292519943295769L, 0.0L },
        { "radian", 1.0L, 0.0L }
    }
};
constexpr std::array<unit_conversion, 3> energy_conversions = {{
        { "joule", 1000.0L, 0.0L },
        { "kilojoule", 1000000.0L, 0.0L },
        { "millijoule", 1.0L, 0.0L }
    }
};
constexpr std::array<unit_conversion, 3> length_conversions = {{
        { "centimeter", 10.0L, 0.0L },
        { "meter", 1000.0L, 0.0L },
        { "millimeter", 1.0L, 0.0L }
    }
};
constexpr std::array<unit_conversion, 3> mass_conversions = {{
        { "gram", 1000.0L, 0.0L },
        { "kilogram", 1000000.0L, 0.0L },
        { "milligram", 1.0L, 0.0L }
    }
};
constexpr std::array<unit_conversion, 2> memory_conversions = {{
        { "kilobyte", 1.0L, 0.0L },
        { "megabyte", 1000.0L, 0.0L }
    }
};
constexpr std::array<unit_conversion, 2> money_conversions = {{
        { "cent", 1.0L, 0.0L },
        { "dollar", 100.0L, 0.0L }
    }
};
constexpr std::array<unit_conversion, 3> power_conversions = {{
        { "kilowatt", 1000000.0L, 0.0L },
        { "milliwatt", 1.0L, 0.0L },
        { "watt", 1000.0L, 0.0L }
    }
};
constexpr std::array<unit_conversion, 1> sound_conversions = {{
        { "decibel", 1.0L, 0.0L }
    }
};
constexpr std::array<unit_conversion, 1> specific_energy_conversions = {{
        { "joule_per_gram", 1.0L, 0.0L }
    }
};
constexpr std::array<unit_conversion, 3> temperature_conversions = {{
        { "celsius", 1.0L, 273.15L },
        { "fahrenheit", 0.555555555555555555556L, 255.372222222222222222L },
        { "kelvin", 1.0L, 0.0L }
    }
};
constexpr std::array<unit_conversion, 2> volume_conversions = {{
        { "liter", 1000.0L, 0.0L },
        { "milliliter", 1.0L, 0.0L }
    }
};

const std::array<unit_kind_definition, 11> &unit_kind_definitions()
{
    static const std::array<unit_kind_definition, 11> definitions = {{
            {
                "angle", "radian", false,
                angle_conversions.data(), angle_conversions.size()
            },
            {
                "energy", "millijoule", true,
                energy_conversions.data(), energy_conversions.size()
            },
            {
                "length", "millimeter", true,
                length_conversions.data(), length_conversions.size()
            },
            {
                "mass", "milligram", true,
                mass_conversions.data(), mass_conversions.size()
            },
            {
                "memory", "kilobyte", true,
                memory_conversions.data(), memory_conversions.size()
            },
            {
                "money", "cent", true,
                money_conversions.data(), money_conversions.size()
            },
            {
                "power", "milliwatt", true,
                power_conversions.data(), power_conversions.size()
            },
            {
                "sound", "decibel", false,
                sound_conversions.data(), sound_conversions.size()
            },
            {
                "specific_energy", "joule_per_gram", false,
                specific_energy_conversions.data(), specific_energy_conversions.size()
            },
            {
                "temperature", "kelvin", false,
                temperature_conversions.data(), temperature_conversions.size()
            },
            {
                "volume", "milliliter", true,
                volume_conversions.data(), volume_conversions.size()
            }
        }
    };
    return definitions;
}

const unit_kind_definition *find_unit_kind( const std::string_view kind )
{
    const auto &definitions = unit_kind_definitions();
    const auto found = std::lower_bound(
                           definitions.begin(), definitions.end(), kind,
    []( const unit_kind_definition & entry, const std::string_view key ) {
        return entry.name < key;
    } );
    return found != definitions.end() && found->name == kind ? &*found : nullptr;
}

const unit_conversion *find_unit_conversion(
    const unit_kind_definition &kind, const std::string_view unit )
{
    const unit_conversion *begin = kind.conversions;
    const unit_conversion *end = begin + kind.conversion_count;
    const auto found = std::lower_bound(
                           begin, end, unit,
    []( const unit_conversion & entry, const std::string_view key ) {
        return entry.name < key;
    } );
    return found != end && found->name == unit ? &*found : nullptr;
}

std::variant<std::int64_t, double> checked_canonical_value(
    const unit_kind_definition &kind, const long double value,
    const std::optional<std::pair<long double, long double>> &floating_error_bounds =
        std::nullopt )
{
    if( !std::isfinite( value ) ) {
        throw std::invalid_argument( "game.units values must be finite" );
    }
    if( kind.integral ) {
        const long double rounded = std::round( value );
        bool exactly_representable = value == rounded;
        if( floating_error_bounds ) {
            const long double lower =
                std::min( floating_error_bounds->first,
                          floating_error_bounds->second );
            const long double upper =
                std::max( floating_error_bounds->first,
                          floating_error_bounds->second );
            const long double first_integer = std::ceil( lower );
            const long double last_integer = std::floor( upper );
            exactly_representable =
                first_integer == last_integer && first_integer == rounded;
        }
        if( !exactly_representable ) {
            throw std::invalid_argument(
                "game.units value is not exactly representable in " +
                std::string( kind.canonical_unit ) );
        }
        if( rounded < static_cast<long double>( std::numeric_limits<std::int64_t>::min() ) ||
            rounded > static_cast<long double>( std::numeric_limits<std::int64_t>::max() ) ) {
            throw std::overflow_error( "game.units integral value is out of range" );
        }
        return static_cast<std::int64_t>( rounded );
    }
    const double result = static_cast<double>( value );
    if( !std::isfinite( result ) ) {
        throw std::overflow_error( "game.units floating-point value is out of range" );
    }
    return result;
}

std::int64_t checked_integral_conversion(
    const unit_conversion &conversion, const std::int64_t value )
{
    const std::int64_t factor =
        static_cast<std::int64_t>( conversion.factor );
    const std::int64_t offset =
        static_cast<std::int64_t>( conversion.offset );
    if( factor <= 0 ||
        static_cast<long double>( factor ) != conversion.factor ||
        static_cast<long double>( offset ) != conversion.offset ) {
        throw std::logic_error(
            "game.units integral conversion is not an integer transform" );
    }
    if( value > std::numeric_limits<std::int64_t>::max() / factor ||
        value < std::numeric_limits<std::int64_t>::min() / factor ) {
        throw std::overflow_error( "game.units integral value is out of range" );
    }
    const std::int64_t product = value * factor;
    if( ( offset > 0 &&
          product > std::numeric_limits<std::int64_t>::max() - offset ) ||
        ( offset < 0 &&
          product < std::numeric_limits<std::int64_t>::min() - offset ) ) {
        throw std::overflow_error( "game.units integral value is out of range" );
    }
    return product + offset;
}

const unit_kind_definition &require_same_unit_kind(
    const script_unit_value &lhs, const script_unit_value &rhs,
    const std::string_view operation )
{
    if( lhs.kind() != rhs.kind() ) {
        throw std::invalid_argument(
            "game.units cannot " + std::string( operation ) + " '" + lhs.kind() +
            "' and '" + rhs.kind() + "'" );
    }
    const unit_kind_definition *kind = find_unit_kind( lhs.kind() );
    if( kind == nullptr ) {
        throw std::runtime_error( "game.units value has an unknown kind" );
    }
    return *kind;
}

struct time_unit_definition {
    std::string_view name;
    std::int64_t turns;
};

constexpr std::array<time_unit_definition, 6> time_units = {{
        { "day", 24LL * 60LL * 60LL },
        { "hour", 60LL * 60LL },
        { "minute", 60LL },
        { "second", 1LL },
        { "turn", 1LL },
        { "week", 7LL * 24LL * 60LL * 60LL }
    }
};

const time_unit_definition *find_time_unit( const std::string_view unit )
{
    const auto found = std::lower_bound(
                           time_units.begin(), time_units.end(), unit,
    []( const time_unit_definition & entry, const std::string_view key ) {
        return entry.name < key;
    } );
    return found != time_units.end() && found->name == unit ? &*found : nullptr;
}

std::int64_t checked_turn_count( const long double turns, const std::string_view operation )
{
    constexpr std::int64_t minimum = std::numeric_limits<int>::min();
    constexpr std::int64_t maximum = std::numeric_limits<int>::max();
    if( !std::isfinite( turns ) || turns < static_cast<long double>( minimum ) ||
        turns > static_cast<long double>( maximum ) ) {
        throw std::overflow_error(
            "game.time " + std::string( operation ) + " exceeds the engine time range" );
    }
    const long double rounded = std::round( turns );
    if( turns != rounded ) {
        throw std::invalid_argument(
            "game.time " + std::string( operation ) + " must resolve to whole turns" );
    }
    return static_cast<std::int64_t>( rounded );
}

int positive_mod( const std::int64_t value, const int divisor )
{
    const int remainder = static_cast<int>( value % divisor );
    return remainder < 0 ? remainder + divisor : remainder;
}

std::string moon_phase_id( const enum moon_phase phase )
{
    static constexpr std::array<std::string_view, MOON_PHASE_MAX> names = {
        "new",
        "waxing_crescent",
        "waxing_half",
        "waxing_gibbous",
        "full",
        "waning_gibbous",
        "waning_half",
        "waning_crescent"
    };
    const int index = static_cast<int>( phase );
    return index >= 0 && index < static_cast<int>( names.size() ) ?
           std::string( names[static_cast<std::size_t>( index )] ) : "unknown";
}

std::string season_id( const enum season_type season )
{
    static constexpr std::array<std::string_view, NUM_SEASONS> names = {
        "spring", "summer", "autumn", "winter"
    };
    const int index = static_cast<int>( season );
    return index >= 0 && index < static_cast<int>( names.size() ) ?
           std::string( names[static_cast<std::size_t>( index )] ) : "unknown";
}

} // namespace

script_game_id::script_game_id( std::string kind, std::string value )
    : kind_( std::move( kind ) ), value_( std::move( value ) )
{
    if( !is_supported_game_id_kind( kind_ ) ) {
        throw std::invalid_argument( "game.types.id received an unknown id kind: " + kind_ );
    }
    validate_id_text( value_ );
}

const std::string &script_game_id::kind() const noexcept
{
    return kind_;
}

const std::string &script_game_id::value() const noexcept
{
    return value_;
}

bool script_game_id::is_null() const noexcept
{
    return value_.empty();
}

bool script_game_id::is_valid() const
{
    const id_kind_definition *definition = find_id_kind( kind_ );
    return definition != nullptr && !value_.empty() && definition->validate( value_ );
}

std::string script_game_id::to_string() const
{
    return "GameId<" + kind_ + ">(" + value_ + ")";
}

const std::vector<std::string> &supported_game_id_kinds()
{
    static const std::vector<std::string> result = [] {
        std::vector<std::string> values;
        values.reserve( id_kind_definitions().size() );
        for( const id_kind_definition &definition : id_kind_definitions() )
        {
            values.emplace_back( definition.name );
        }
        return values;
    }();
    return result;
}

bool is_supported_game_id_kind( const std::string_view kind )
{
    return find_id_kind( kind ) != nullptr;
}

script_unit_value::script_unit_value(
    std::string kind, std::string canonical_unit,
    std::variant<std::int64_t, double> canonical )
    : kind_( std::move( kind ) ), canonical_unit_( std::move( canonical_unit ) ),
      canonical_( std::move( canonical ) )
{
}

script_unit_value script_unit_value::from(
    const std::string_view kind_name, const double value,
    const std::string_view unit_name )
{
    const unit_kind_definition *kind = find_unit_kind( kind_name );
    if( kind == nullptr ) {
        throw std::invalid_argument(
            "game.units.new received an unknown unit kind: " + std::string( kind_name ) );
    }
    const unit_conversion *conversion = find_unit_conversion( *kind, unit_name );
    if( conversion == nullptr ) {
        throw std::invalid_argument(
            "game.units.new received an unknown " + std::string( kind_name ) +
            " unit: " + std::string( unit_name ) );
    }
    const auto convert = [conversion]( const double input ) {
        return static_cast<long double>( input ) * conversion->factor +
               conversion->offset;
    };
    const long double canonical = convert( value );
    const std::pair<long double, long double> floating_error_bounds = {
        convert( std::nextafter(
                     value, -std::numeric_limits<double>::infinity() ) ),
        convert( std::nextafter(
                     value, std::numeric_limits<double>::infinity() ) )
    };
    return script_unit_value(
               std::string( kind->name ), std::string( kind->canonical_unit ),
               checked_canonical_value(
                   *kind, canonical, floating_error_bounds ) );
}

script_unit_value script_unit_value::from_integer(
    const std::string_view kind_name, const std::int64_t value,
    const std::string_view unit_name )
{
    const unit_kind_definition *kind = find_unit_kind( kind_name );
    if( kind == nullptr ) {
        throw std::invalid_argument(
            "game.units.new received an unknown unit kind: " +
            std::string( kind_name ) );
    }
    const unit_conversion *conversion =
        find_unit_conversion( *kind, unit_name );
    if( conversion == nullptr ) {
        throw std::invalid_argument(
            "game.units.new received an unknown " +
            std::string( kind_name ) + " unit: " +
            std::string( unit_name ) );
    }
    if( kind->integral ) {
        return script_unit_value(
                   std::string( kind->name ),
                   std::string( kind->canonical_unit ),
                   checked_integral_conversion( *conversion, value ) );
    }
    const long double canonical =
        static_cast<long double>( value ) * conversion->factor +
        conversion->offset;
    return script_unit_value(
               std::string( kind->name ),
               std::string( kind->canonical_unit ),
               checked_canonical_value( *kind, canonical ) );
}

const std::string &script_unit_value::kind() const noexcept
{
    return kind_;
}

const std::string &script_unit_value::canonical_unit() const noexcept
{
    return canonical_unit_;
}

bool script_unit_value::is_integral() const noexcept
{
    return std::holds_alternative<std::int64_t>( canonical_ );
}

std::int64_t script_unit_value::canonical_integer() const
{
    if( !is_integral() ) {
        throw std::logic_error( "game.units value does not use an integral canonical unit" );
    }
    return std::get<std::int64_t>( canonical_ );
}

double script_unit_value::canonical_number() const
{
    return static_cast<double>( canonical_wide() );
}

long double script_unit_value::canonical_wide() const
{
    return std::visit( []( const auto value ) {
        return static_cast<long double>( value );
    }, canonical_ );
}

double script_unit_value::value_as( const std::string_view unit_name ) const
{
    const unit_kind_definition *kind = find_unit_kind( kind_ );
    if( kind == nullptr ) {
        throw std::runtime_error( "game.units value has an unknown kind" );
    }
    const unit_conversion *conversion = find_unit_conversion( *kind, unit_name );
    if( conversion == nullptr ) {
        throw std::invalid_argument(
            "game.units.value received an unknown " + kind_ +
            " unit: " + std::string( unit_name ) );
    }
    return static_cast<double>(
               ( canonical_wide() - conversion->offset ) /
               conversion->factor );
}

script_unit_value script_unit_value::add( const script_unit_value &rhs ) const
{
    const unit_kind_definition &kind = require_same_unit_kind( *this, rhs, "add" );
    const long double sum =
        canonical_wide() + rhs.canonical_wide();
    return script_unit_value(
               kind_, canonical_unit_, checked_canonical_value( kind, sum ) );
}

script_unit_value script_unit_value::subtract( const script_unit_value &rhs ) const
{
    const unit_kind_definition &kind = require_same_unit_kind( *this, rhs, "subtract" );
    const long double difference =
        canonical_wide() - rhs.canonical_wide();
    return script_unit_value(
               kind_, canonical_unit_, checked_canonical_value( kind, difference ) );
}

script_unit_value script_unit_value::scale( const double factor ) const
{
    const unit_kind_definition *kind = find_unit_kind( kind_ );
    if( kind == nullptr ) {
        throw std::runtime_error( "game.units value has an unknown kind" );
    }
    if( !std::isfinite( factor ) ) {
        throw std::invalid_argument( "game.units scale factor must be finite" );
    }
    const long double product =
        canonical_wide() * factor;
    return script_unit_value(
               kind_, canonical_unit_, checked_canonical_value( *kind, product ) );
}

int script_unit_value::compare( const script_unit_value &rhs ) const
{
    require_same_unit_kind( *this, rhs, "compare" );
    if( canonical_ == rhs.canonical_ ) {
        return 0;
    }
    return canonical_wide() < rhs.canonical_wide() ? -1 : 1;
}

std::string script_unit_value::to_string() const
{
    std::ostringstream output;
    output << "Unit<" << kind_ << ">(";
    if( is_integral() ) {
        output << canonical_integer();
    } else {
        output << std::setprecision( 12 ) << canonical_number();
    }
    output << ' ' << canonical_unit_ << ')';
    return output.str();
}

const std::vector<std::string> &supported_script_unit_kinds()
{
    static const std::vector<std::string> result = [] {
        std::vector<std::string> values;
        values.reserve( unit_kind_definitions().size() );
        for( const unit_kind_definition &definition : unit_kind_definitions() )
        {
            values.emplace_back( definition.name );
        }
        return values;
    }();
    return result;
}

std::vector<std::string> supported_units_for_kind( const std::string_view kind_name )
{
    const unit_kind_definition *kind = find_unit_kind( kind_name );
    if( kind == nullptr ) {
        throw std::invalid_argument(
            "game.units.units received an unknown unit kind: " + std::string( kind_name ) );
    }
    std::vector<std::string> result;
    result.reserve( kind->conversion_count );
    for( std::size_t index = 0; index < kind->conversion_count; ++index ) {
        result.emplace_back( kind->conversions[index].name );
    }
    return result;
}

script_time_duration::script_time_duration( const std::int64_t turns )
    : turns_( checked_turn_count( static_cast<long double>( turns ), "duration" ) )
{
}

script_time_duration script_time_duration::from(
    const std::int64_t value, const std::string_view unit )
{
    const time_unit_definition *definition = find_time_unit( unit );
    if( definition == nullptr ) {
        throw std::invalid_argument(
            "game.time.duration received an unknown unit: " + std::string( unit ) );
    }
    return script_time_duration( checked_turn_count(
                                     static_cast<long double>( value ) * definition->turns,
                                     "duration" ) );
}

script_time_duration script_time_duration::from_native( const ::time_duration &value )
{
    return script_time_duration( to_turns<std::int64_t>( value ) );
}

std::int64_t script_time_duration::turns() const noexcept
{
    return turns_;
}

double script_time_duration::value_as( const std::string_view unit ) const
{
    const time_unit_definition *definition = find_time_unit( unit );
    if( definition == nullptr ) {
        throw std::invalid_argument(
            "TimeDuration:value received an unknown unit: " + std::string( unit ) );
    }
    return static_cast<double>( turns_ ) / static_cast<double>( definition->turns );
}

script_time_duration script_time_duration::add( const script_time_duration &rhs ) const
{
    return script_time_duration( checked_turn_count(
                                     static_cast<long double>( turns_ ) + rhs.turns_, "addition" ) );
}

script_time_duration script_time_duration::subtract( const script_time_duration &rhs ) const
{
    return script_time_duration( checked_turn_count(
                                     static_cast<long double>( turns_ ) - rhs.turns_, "subtraction" ) );
}

script_time_duration script_time_duration::scale( const std::int64_t factor ) const
{
    return script_time_duration( checked_turn_count(
                                     static_cast<long double>( turns_ ) * factor, "scaling" ) );
}

script_time_duration script_time_duration::divide( const std::int64_t divisor ) const
{
    if( divisor == 0 ) {
        throw std::invalid_argument( "TimeDuration division by zero" );
    }
    if( turns_ % divisor != 0 ) {
        throw std::invalid_argument(
            "TimeDuration division must resolve to whole turns" );
    }
    return script_time_duration( turns_ / divisor );
}

script_time_duration script_time_duration::negate() const
{
    return script_time_duration( checked_turn_count(
                                     -static_cast<long double>( turns_ ), "negation" ) );
}

int script_time_duration::compare( const script_time_duration &rhs ) const noexcept
{
    return turns_ == rhs.turns_ ? 0 : ( turns_ < rhs.turns_ ? -1 : 1 );
}

::time_duration script_time_duration::to_native() const
{
    return ::time_duration::from_turns( static_cast<int>( turns_ ) );
}

std::string script_time_duration::display() const
{
    return ::to_string( to_native() );
}

std::string script_time_duration::to_string() const
{
    return "TimeDuration(" + std::to_string( turns_ ) + " turns)";
}

script_time_point::script_time_point( const std::int64_t turn )
    : turn_( checked_turn_count( static_cast<long double>( turn ), "point" ) )
{
}

script_time_point script_time_point::from_turn( const std::int64_t turn )
{
    return script_time_point( turn );
}

script_time_point script_time_point::from_native( const ::time_point &value )
{
    return script_time_point( to_turn<std::int64_t>( value ) );
}

std::int64_t script_time_point::turn() const noexcept
{
    return turn_;
}

script_time_point script_time_point::add( const script_time_duration &duration ) const
{
    return script_time_point( checked_turn_count(
                                  static_cast<long double>( turn_ ) + duration.turns(), "point addition" ) );
}

script_time_point script_time_point::subtract( const script_time_duration &duration ) const
{
    return script_time_point( checked_turn_count(
                                  static_cast<long double>( turn_ ) - duration.turns(), "point subtraction" ) );
}

script_time_duration script_time_point::difference( const script_time_point &rhs ) const
{
    return script_time_duration::from(
               checked_turn_count(
                   static_cast<long double>( turn_ ) - rhs.turn_, "point difference" ),
               "turn" );
}

int script_time_point::compare( const script_time_point &rhs ) const noexcept
{
    return turn_ == rhs.turn_ ? 0 : ( turn_ < rhs.turn_ ? -1 : 1 );
}

::time_point script_time_point::to_native() const
{
    return ::time_point::from_turn( static_cast<int>( turn_ ) );
}

int script_time_point::second_of_minute() const
{
    return positive_mod( turn_, 60 );
}

int script_time_point::minute_of_hour() const
{
    return ::minute_of_hour<int>( to_native() );
}

int script_time_point::hour_of_day() const
{
    return ::hour_of_day<int>( to_native() );
}

bool script_time_point::is_day() const
{
    return ::is_day( to_native() );
}

bool script_time_point::is_night() const
{
    return ::is_night( to_native() );
}

bool script_time_point::is_dawn() const
{
    return ::is_dawn( to_native() );
}

bool script_time_point::is_dusk() const
{
    return ::is_dusk( to_native() );
}

script_time_point script_time_point::sunrise() const
{
    return from_native( ::sunrise( to_native() ) );
}

script_time_point script_time_point::sunset() const
{
    return from_native( ::sunset( to_native() ) );
}

std::string script_time_point::moon_phase() const
{
    return moon_phase_id( get_moon_phase( to_native() ) );
}

std::string script_time_point::season() const
{
    return season_id( season_of_year( to_native() ) );
}

std::string script_time_point::display() const
{
    return ::to_string( to_native() );
}

std::string script_time_point::to_string() const
{
    return "TimePoint(" + std::to_string( turn_ ) + ")";
}

void install_value_type_api(
    sol::state &lua, sol::table &game, std::function<void()> require_values )
{
    lua.new_usertype<script_game_id>(
        "GameId", sol::no_constructor,
        "kind", sol::property( &script_game_id::kind ),
        "value", sol::property( &script_game_id::value ),
        "is_null", &script_game_id::is_null,
        "is_valid", &script_game_id::is_valid,
        sol::meta_function::to_string, &script_game_id::to_string,
        sol::meta_function::equal_to,
    []( const script_game_id & lhs, const script_game_id & rhs ) {
        return lhs == rhs;
    } );

    lua.new_usertype<script_unit_value>(
        "UnitValue", sol::no_constructor,
        "kind", sol::property( &script_unit_value::kind ),
        "canonical_unit", sol::property( &script_unit_value::canonical_unit ),
        "is_integral", &script_unit_value::is_integral,
        "value", &script_unit_value::value_as,
        "add", &script_unit_value::add,
        "subtract", &script_unit_value::subtract,
        "scale", &script_unit_value::scale,
        "compare", &script_unit_value::compare,
        sol::meta_function::to_string, &script_unit_value::to_string,
        sol::meta_function::equal_to,
    []( const script_unit_value & lhs, const script_unit_value & rhs ) {
        return lhs == rhs;
    },
    sol::meta_function::addition, &script_unit_value::add,
    sol::meta_function::subtraction, &script_unit_value::subtract,
    sol::meta_function::less_than,
    []( const script_unit_value & lhs, const script_unit_value & rhs ) {
        return lhs.compare( rhs ) < 0;
    },
    sol::meta_function::less_than_or_equal_to,
    []( const script_unit_value & lhs, const script_unit_value & rhs ) {
        return lhs.compare( rhs ) <= 0;
    } );

    sol::table types = lua.create_table();
    types.set_function(
        "id",
    [require_values]( const std::string & kind, const std::string & value ) {
        require_values();
        return script_game_id( kind, value );
    } );
    types.set_function( "id_kinds", [require_values]( sol::this_state lua_state ) {
        require_values();
        sol::state_view state( lua_state );
        sol::table result = state.create_table();
        const std::vector<std::string> &kinds = supported_game_id_kinds();
        for( std::size_t index = 0; index < kinds.size(); ++index ) {
            result[index + 1] = kinds[index];
        }
        return result;
    } );
    game["types"] = std::move( types );

    sol::table units = lua.create_table();
    units.set_function(
        "new",
        [require_values]( const std::string & kind, const sol::object & value,
    const std::string & unit ) {
        require_values();
        if( value.get_type() != sol::type::number ) {
            throw std::invalid_argument(
                "game.units.new value must be a number" );
        }
        if( value.is<lua_Integer>() ) {
            return script_unit_value::from_integer(
                       kind,
                       static_cast<std::int64_t>(
                           value.as<lua_Integer>() ),
                       unit );
        }
        return script_unit_value::from(
                   kind, value.as<double>(), unit );
    } );
    units.set_function( "kinds", [require_values]( sol::this_state lua_state ) {
        require_values();
        sol::state_view state( lua_state );
        sol::table result = state.create_table();
        const std::vector<std::string> &kinds = supported_script_unit_kinds();
        for( std::size_t index = 0; index < kinds.size(); ++index ) {
            result[index + 1] = kinds[index];
        }
        return result;
    } );
    units.set_function(
        "units",
    [require_values]( sol::this_state lua_state, const std::string & kind ) {
        require_values();
        sol::state_view state( lua_state );
        sol::table result = state.create_table();
        const std::vector<std::string> names = supported_units_for_kind( kind );
        for( std::size_t index = 0; index < names.size(); ++index ) {
            result[index + 1] = names[index];
        }
        return result;
    } );
    game["units"] = std::move( units );

    lua.new_usertype<script_time_duration>(
        "TimeDuration", sol::no_constructor,
        "turns", sol::property( &script_time_duration::turns ),
        "value", &script_time_duration::value_as,
        "display", &script_time_duration::display,
        "compare", &script_time_duration::compare,
        "scale", &script_time_duration::scale,
        "divide", &script_time_duration::divide,
        sol::meta_function::to_string, &script_time_duration::to_string,
        sol::meta_function::equal_to,
    []( const script_time_duration & lhs, const script_time_duration & rhs ) {
        return lhs == rhs;
    },
    sol::meta_function::less_than,
    []( const script_time_duration & lhs, const script_time_duration & rhs ) {
        return lhs.compare( rhs ) < 0;
    },
    sol::meta_function::less_than_or_equal_to,
    []( const script_time_duration & lhs, const script_time_duration & rhs ) {
        return lhs.compare( rhs ) <= 0;
    },
    sol::meta_function::addition, &script_time_duration::add,
    sol::meta_function::subtraction, &script_time_duration::subtract,
    sol::meta_function::multiplication, &script_time_duration::scale,
    sol::meta_function::division, &script_time_duration::divide,
    sol::meta_function::unary_minus, &script_time_duration::negate );

    lua.new_usertype<script_time_point>(
        "TimePoint", sol::no_constructor,
        "turn", sol::property( &script_time_point::turn ),
        "second_of_minute", &script_time_point::second_of_minute,
        "minute_of_hour", &script_time_point::minute_of_hour,
        "hour_of_day", &script_time_point::hour_of_day,
        "is_day", &script_time_point::is_day,
        "is_night", &script_time_point::is_night,
        "is_dawn", &script_time_point::is_dawn,
        "is_dusk", &script_time_point::is_dusk,
        "sunrise", &script_time_point::sunrise,
        "sunset", &script_time_point::sunset,
        "moon_phase", &script_time_point::moon_phase,
        "season", &script_time_point::season,
        "display", &script_time_point::display,
        "compare", &script_time_point::compare,
        sol::meta_function::to_string, &script_time_point::to_string,
        sol::meta_function::equal_to,
    []( const script_time_point & lhs, const script_time_point & rhs ) {
        return lhs == rhs;
    },
    sol::meta_function::less_than,
    []( const script_time_point & lhs, const script_time_point & rhs ) {
        return lhs.compare( rhs ) < 0;
    },
    sol::meta_function::less_than_or_equal_to,
    []( const script_time_point & lhs, const script_time_point & rhs ) {
        return lhs.compare( rhs ) <= 0;
    },
    sol::meta_function::addition, &script_time_point::add,
    sol::meta_function::subtraction,
    sol::overload(
    []( const script_time_point & lhs, const script_time_point & rhs ) {
        return lhs.difference( rhs );
    },
    []( const script_time_point & lhs, const script_time_duration & rhs ) {
        return lhs.subtract( rhs );
    } ) );

    sol::table time = lua.create_table();
    time.set_function(
        "duration",
    [require_values]( const std::int64_t value, const std::string & unit ) {
        require_values();
        return script_time_duration::from( value, unit );
    } );
    time.set_function( "point", [require_values]( const std::int64_t turn ) {
        require_values();
        return script_time_point::from_turn( turn );
    } );
    time.set_function( "now", [require_values]() {
        require_values();
        return script_time_point::from_native( calendar::turn );
    } );
    time.set_function( "turn_zero", [require_values]() {
        require_values();
        return script_time_point::from_native( calendar::turn_zero );
    } );
    time.set_function( "before_time_starts", [require_values]() {
        require_values();
        return script_time_point::from_native(
                   calendar::before_time_starts );
    } );
    game["time"] = std::move( time );

    install_coordinate_value_api( lua, game, std::move( require_values ) );
}

} // namespace cata::lua_ui
