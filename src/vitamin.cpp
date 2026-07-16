#include "vitamin.h"

#include "calendar.h"
#include "debug.h"
#include "enum_conversions.h"
#include "flexbuffer_json.h"
#include "generic_factory.h"
#include "options.h"
#include "units.h"
#include "units_utility.h"

namespace
{

generic_factory<vitamin> vitamin_factory( "vitamin" );

} // namespace

/** @relates string_id */
template<>
bool string_id<vitamin>::is_valid() const
{
    return vitamin_factory.is_valid( *this );
}

/** @relates string_id */
template<>
const vitamin &string_id<vitamin>::obj() const
{
    return vitamin_factory.obj( *this );
}

int vitamin::severity( int qty ) const
{
    for( int i = 0; i != static_cast<int>( disease_.size() ); ++i ) {
        if( ( qty >= disease_[ i ].first && qty <= disease_[ i ].second ) ||
            ( qty <= disease_[ i ].first && qty >= disease_[ i ].second ) ) {
            return i + 1;
        }
    }
    for( int i = 0; i != static_cast<int>( disease_excess_.size() ); ++i ) {
        if( ( qty >= disease_excess_[ i ].first && qty <= disease_excess_[ i ].second ) ||
            ( qty <= disease_excess_[ i ].first && qty >= disease_excess_[ i ].second ) ) {
            return -i - 1;
        }
    }
    return 0;
}

void vitamin::load( const JsonObject &jo, const std::string_view )
{
    mandatory( jo, was_loaded, "name", name_ );

    if( jo.has_string( "vit_type" ) ) {
        type_ = jo.get_enum_value<vitamin_type>( "vit_type" );
    } else if( !was_loaded ) {
        jo.throw_error_at( "vit_type", "vitamin must have a vitamin type" );
    }

    mandatory( jo, was_loaded, "min", min_ );
    optional( jo, was_loaded, "max", max_, 0 );
    mandatory( jo, was_loaded, "rate", rate_ );

    optional( jo, was_loaded, "deficiency", deficiency_, efftype_id::NULL_ID() );

    optional( jo, was_loaded, "excess", excess_, efftype_id::NULL_ID() );

    if( jo.has_string( "weight_per_unit" ) ) {
        weight_per_unit = read_from_json_string( jo.get_member( "weight_per_unit" ),
                          vitamin_units::mass_units );
    } else if( !was_loaded ) {
        weight_per_unit.reset();
    }

    optional( jo, was_loaded, "disease", disease_, pair_reader<int, int> {} );
    optional( jo, was_loaded, "disease_excess", disease_excess_, pair_reader<int, int> {} );
    optional( jo, was_loaded, "decays_into", decays_into_, pair_reader<vitamin_id, int> {} );
    optional( jo, was_loaded, "flags", flags_, string_reader{} );
}

const std::vector<vitamin> &vitamin::all()
{
    return vitamin_factory.get_all();
}

void vitamin::check_consistency()
{
    for( const vitamin &v : vitamin_factory.get_all() ) {
        if( !( v.deficiency_.is_null() || v.deficiency_.is_valid() ) ) {
            debugmsg( "vitamin %s has unknown deficiency %s", v.id.c_str(),
                      v.deficiency_.c_str() );
        }
        if( !( v.excess_.is_null() || v.excess_.is_valid() ) ) {
            debugmsg( "vitamin %s has unknown excess %s", v.id.c_str(), v.excess_.c_str() );
        }
    }
}

void vitamin::reset()
{
    vitamin_factory.reset();
}

float vitamin::RDA_to_default( int percent ) const
{
    // if not a vitamin it's in Units and doesn't need conversion
    if( type_ != vitamin_type::VITAMIN ) {
        return percent;
    }
    return 24_hours * ( percent / 100.0f ) / rate_;
}

int vitamin::units_absorption_per_day() const
{
    return ( 24_hours / rate_ );
}

int vitamin::units_from_mass( vitamin_units::mass val ) const
{
    if( !weight_per_unit.has_value() ) {
        debugmsg( "Tried to convert vitamin in mass to units, but %s doesn't support mass for vitamins",
                  id.str() );
        return 1;
    }
    return val / *weight_per_unit;
}

std::pair<std::string, std::string> vitamin::mass_str_from_units( int units ) const
{
    if( !weight_per_unit.has_value() || !get_option<bool>( "SHOW_VITAMIN_MASS" ) ) {
        return {"", ""};
    }
    return weight_to_string( units * *weight_per_unit );
}

namespace io
{
template<>
std::string enum_to_string<vitamin_type>( vitamin_type data )
{
    switch( data ) {
        case vitamin_type::VITAMIN:
            return "vitamin";
        case vitamin_type::TOXIN:
            return "toxin";
        case vitamin_type::DRUG:
            return "drug";
        case vitamin_type::COUNTER:
            return "counter";
        case vitamin_type::num_vitamin_types:
            break;
    }
    cata_fatal( "Invalid vitamin_type" );
}
} // namespace io

namespace vitamins
{

void load( const JsonObject &jo, const std::string &src )
{
    vitamin_factory.load( jo, src );
}

void check()
{
    vitamin::check_consistency();
}

void reset()
{
    vitamin_factory.reset();
}

} // namespace vitamins
