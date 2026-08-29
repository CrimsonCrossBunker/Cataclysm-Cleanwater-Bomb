#include "wound.h"

#include <algorithm>
#include <cstddef>
#include <limits>
#include <memory>
#include <set>

#include "bodypart.h"
#include "lua_platform_content.h"
#include "debug.h"
#include "flexbuffer_json.h"
#include "generic_factory.h"
#include "json.h"
#include "rng.h"

enum class bp_type;

void wound_type::load( const JsonObject &jo, const std::string_view & )
{
    name_.make_plural();
    mandatory( jo, was_loaded, "name", name_ );
    mandatory( jo, was_loaded, "description", description_ );
    optional( jo, was_loaded, "pain", pain_, std::make_pair( 0, 0 ) );
    optional( jo, was_loaded, "healing_time", healing_time_,
              std::make_pair( calendar::INDEFINITELY_LONG_DURATION, calendar::INDEFINITELY_LONG_DURATION ) );

    mandatory( jo, was_loaded, "damage_types", damage_types );
    mandatory( jo, was_loaded, "damage_required", damage_required );
    optional( jo, was_loaded, "weight", weight, 1 );
    optional( jo, was_loaded, "limb_scores", limb_scores );
    optional( jo, was_loaded, "limit", limit, 0 );

    optional( jo, was_loaded, "wound_progression", wound_progression );
    optional( jo, was_loaded, "whitelist_bp_with_flag", whitelist_bp_with_flag );
    optional( jo, was_loaded, "whitelist_body_part_types", whitelist_body_part_types );
    optional( jo, was_loaded, "blacklist_bp_with_flag", blacklist_bp_with_flag );
    optional( jo, was_loaded, "blacklist_body_part_types", blacklist_body_part_types );
}

wound::wound( wound_type_id wd ) :
    type( wd ),
    healing_time( wd->evaluate_healing_time() ),
    pain( wd->evaluate_pain() )
{}

namespace
{
generic_factory<wound_type> wound_type_factory( "wound" );
} // namespace

generic_factory<wound_type> &cata::lua_platform::detail::wound_type_registry()
{
    return wound_type_factory;
}

void wound_type::load_wounds( const JsonObject &jo, const std::string &src )
{
    wound_type_factory.load( jo, src );
}

/** @relates string_id */
template<>
const wound_type &string_id<wound_type>::obj() const
{
    return wound_type_factory.obj( *this );
}

/** @relates string_id */
template<>
bool string_id<wound_type>::is_valid() const
{
    return wound_type_factory.is_valid( *this );
}

void wound_type::reset()
{
    wound_type_factory.reset();
    cata::lua_platform::detail::refresh_body_part_wound_cache();
}

void wound_type::check_consistency()
{
    wound_type_factory.check();
}

void wound_type::check() const
{

}

const std::vector<wound_type> &wound_type::get_all()
{
    return wound_type_factory.get_all();
}

void wound_type::finalize_all()
{
    wound_type_factory.finalize();
    cata::lua_platform::detail::refresh_body_part_wound_cache();
}

void wound_type::finalize()
{

}

namespace
{
generic_factory<wound_fix> wound_fix_factory( "wound_fix" );
} // namespace

generic_factory<wound_fix> &cata::lua_platform::detail::wound_fix_registry()
{
    return wound_fix_factory;
}

void cata::lua_platform::detail::refresh_wound_fix_links()
{
    for( wound_type &wound_def : wound_type_factory.get_all_mod() ) {
        wound_def.fixes.clear();
    }

    for( const wound_fix &fix : wound_fix_factory.get_all() ) {
        for( const wound_type_id &wound_id : fix.wounds_removed ) {
            if( wound_id.is_valid() ) {
                const_cast<wound_type &>( *wound_id ).fixes.emplace( fix.id );
            }
        }
    }
}

void wound_fix::load_wound_fixes( const JsonObject &jo, const std::string &src )
{
    wound_fix_factory.load( jo, src );
}

std::string wound_fix::get_name() const
{
    return name.translated();
}

std::string wound_fix::get_description() const
{
    return description.translated();
}

/** @relates string_id */
template<>
const wound_fix &string_id<wound_fix>::obj() const
{
    return wound_fix_factory.obj( *this );
}

/** @relates string_id */
template<>
bool string_id<wound_fix>::is_valid() const
{
    return wound_fix_factory.is_valid( *this );
}

void wound_fix::reset()
{
    wound_fix_factory.reset();
    cata::lua_platform::detail::refresh_wound_fix_links();
}

void wound_fix::check_consistency()
{
    wound_fix_factory.check();
}

void wound_fix::check() const
{
    for( const auto &[skill_id, lvl] : skills ) {
        if( !skill_id.is_valid() ) {
            debugmsg( "wound_fix %s requires unknown skill '%s'", id.str(), skill_id.str() );
        }
    }
    for( const wound_type_id &wd_id : wounds_removed ) {
        if( !wd_id.is_valid() ) {
            debugmsg( "wound_fix '%s' has invalid wound id '%s' in 'wounds_removed' field",
                      id.str(), wd_id.str() );
        }
    }
    for( const wound_type_id &wd_id : wounds_added ) {
        if( !wd_id.is_valid() ) {
            debugmsg( "wound_fix '%s' has invalid wound id '%s' in 'wounds_added' field",
                      id.str(), wd_id.str() );
        }
    }

    for( const wound_proficiency &wound_prof : proficiencies ) {
        if( !wound_prof.prof.is_valid() ) {
            debugmsg( "wound_fix '%s' has invalid proficiency '%s' in 'proficiencies' field",
                      id.str(), wound_prof.prof.str() );
        }
    }
}

void wound_fix::finalize_all()
{
    wound_fix_factory.finalize();
    cata::lua_platform::detail::refresh_wound_fix_links();
}

void wound_fix::finalize()
{
    requirements = cata::make_value<requirement_data>();
    for( const auto &[req_id, amount] : requirement_refs ) {
        if( !req_id.is_valid() ) {
            debugmsg( "wound_fix '%s' has invalid requirement_id '%s'", id.str(), req_id.str() );
            continue;
        }
        *requirements = *requirements + ( *req_id ) * amount;
    }
    requirements->consolidate();
}

void wound_limb_score::deserialize( const JsonObject &jo )
{
    mandatory( jo, false, "score", score );
    optional( jo, false, "value", value, 0.f );
}

void wound_progress::deserialize( const JsonObject &jo )
{
    mandatory( jo, false, "id", id );
    optional( jo, false, "chance", chance, numeric_bound_reader<int> {0, 100} );
}

void wound_proficiency::deserialize( const JsonObject &jo )
{
    mandatory( jo, false, "proficiency", prof );
    optional( jo, false, "time_save", time_save, 1.f );
    optional( jo, false, "is_mandatory", is_mandatory, false );
}

void wound_fix::load( const JsonObject &jo, const std::string_view & )
{
    mandatory( jo, was_loaded, "name", name );
    mandatory( jo, was_loaded, "description", description );
    optional( jo, was_loaded, "success_msg", success_msg );
    optional( jo, was_loaded, "mod_hp", mod_hp, 0 );
    optional( jo, was_loaded, "time", time );
    optional( jo, was_loaded, "skills", skills );
    optional( jo, was_loaded, "wounds_removed", wounds_removed );
    optional( jo, was_loaded, "wounds_added", wounds_added );

    if( jo.has_array( "proficiencies" ) ) {
        proficiencies.clear();
        for( JsonObject job : jo.get_array( "proficiencies" ) ) {
            wound_proficiency wound_prof;
            wound_prof.deserialize( job );
            proficiencies.emplace_back( wound_prof );
        }
    }

    if( jo.has_array( "requirements" ) ) {
        requirement_refs.clear();
        std::size_t inline_requirement_index = 0;
        for( const JsonValue &jv : jo.get_array( "requirements" ) ) {
            if( jv.test_array() ) {
                // array of 2 elements filled with [requirement_id, count]
                const JsonArray &req = static_cast<JsonArray>( jv );
                const requirement_id req_id( req.get_string( 0 ) );
                const int req_amount = req.get_int( 1 );
                requirement_refs.emplace_back( req_id, req_amount );
            } else if( jv.test_object() ) {
                // defining single requirement inline
                const JsonObject &req = static_cast<JsonObject>( jv );
                std::string inline_requirement_id = "wound_fix_" + id.str() + "_inline_req";
                if( inline_requirement_index > 0 ) {
                    inline_requirement_id += "_" + std::to_string( inline_requirement_index + 1 );
                }
                ++inline_requirement_index;
                const requirement_id req_id( inline_requirement_id );
                requirement_data::load_requirement( req, req_id );
                requirement_refs.emplace_back( req_id, 1 );
            } else {
                debugmsg( "wound_fix '%s' has has invalid requirement element", id.str() );
            }
        }
    }
}

const requirement_data &wound_fix::get_requirements() const
{
    return *requirements;
}

bool wound_type::allowed_on_bodypart( bodypart_str_id bp_id ) const
{

    // doesn't have bp type we want
    for( const bp_type &bp_type : whitelist_body_part_types ) {
        if( !bp_id->has_type( bp_type ) ) {
            return false;
        }
    }

    // has no flag we want
    if( !bp_id->has_flag( whitelist_bp_with_flag ) &&
        !whitelist_bp_with_flag.is_empty() ) {
        return false;
    }

    // has type we do not want
    for( const bp_type &bp_type : blacklist_body_part_types ) {
        if( bp_id->has_type( bp_type ) ) {
            return false;
        }
    }

    // has flag we do not want
    if( bp_id->has_flag( blacklist_bp_with_flag ) ) {
        return false;
    }

    return true;
}

int wound_type::evaluate_pain() const
{
    return rng( pain_.first, pain_.second );
}

time_duration wound_type::evaluate_healing_time() const
{
    return rng( healing_time_.first, healing_time_.second );
}

int wound_type::get_limit() const
{
    return limit;
}

std::vector<wound_limb_score> wound_type::get_limb_scores() const
{
    return limb_scores;
}

std::string wound_type::get_name() const
{
    return name_.translated();
}

std::string wound_type::get_description() const
{
    return description_.translated();
}

void wound::serialize( JsonOut &jsout ) const
{
    jsout.start_object();
    jsout.member( "type", type );
    jsout.member( "healing_time", healing_time );
    jsout.member( "healing_progress", healing_progress );
    jsout.member( "pain", pain );
    jsout.end_object();
}

void wound::deserialize( const JsonObject &jsin )
{
    jsin.read( "type", type );
    jsin.read( "healing_time", healing_time );
    jsin.read( "healing_progress", healing_progress );
    jsin.read( "pain", pain );
}

float wound::healing_percentage() const
{
    if( healing_time <= 0_seconds ) {
        return healing_progress <= 0_seconds ? 0.0f : 1.0f;
    }
    const float progress = healing_progress / healing_time;
    return std::clamp( progress, 0.0f, 1.0f );
}

int wound::get_pain() const
{
    const double current_pain = static_cast<double>( pain ) *
                                ( 1.0 - static_cast<double>( healing_percentage() ) );
    return static_cast<int>( std::clamp(
                                 current_pain,
                                 static_cast<double>( std::numeric_limits<int>::min() ),
                                 static_cast<double>( std::numeric_limits<int>::max() ) ) );
}

int wound::get_base_pain() const
{
    return pain;
}

time_duration wound::get_healing_time() const
{
    return healing_time;
}

time_duration wound::get_healing_progress() const
{
    return healing_progress;
}

bool wound::update_wound( const time_duration time_passed )
{
    healing_progress += time_passed;
    return healing_progress >= healing_time;
}
