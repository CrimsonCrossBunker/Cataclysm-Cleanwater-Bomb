#include "catalua_bindings_enums.h"

#include <algorithm>
#include <cstdint>
#include <initializer_list>
#include <iterator>
#include <stdexcept>
#include <string>
#include <utility>
#include <vector>

#include "action.h"
#include "addiction.h"
#include "calendar.h"
#include "damage.h"
#include "enum_conversions.h"
#include "enums.h"
#include "field_type.h"
#include "line.h"
#include "mission.h"
#include "move_mode.h"
#include "mtype.h"
#include "npc.h"
#include "vitamin.h"

namespace cata::lua_ui
{

namespace
{

enum class enum_family_status : int {
    native,
    dynamic_id,
    not_applicable
};

using enum_values_factory = std::vector<std::string> ( * )();

struct enum_family_definition {
    std::string_view name;
    enum_family_status status;
    std::string_view replacement;
    std::string_view reason;
    enum_values_factory values;
};

std::vector<std::string> fixed_values(
    const std::initializer_list<std::string_view> values )
{
    std::vector<std::string> result;
    result.reserve( values.size() );
    for( const std::string_view value : values ) {
        result.emplace_back( value );
    }
    return result;
}

template<typename Entry, typename Convert>
std::vector<std::string> sorted_dynamic_values(
    const std::vector<Entry> &entries, Convert convert )
{
    std::vector<std::string> result;
    result.reserve( entries.size() );
    for( const Entry &entry : entries ) {
        result.push_back( convert( entry ) );
    }
    std::sort( result.begin(), result.end() );
    result.erase( std::unique( result.begin(), result.end() ), result.end() );
    return result;
}

std::vector<std::string> action_values()
{
    std::vector<std::string> result;
    result.reserve( NUM_ACTIONS );
    for( int value = 0; value < NUM_ACTIONS; ++value ) {
        const std::string name =
            action_ident( static_cast<action_id>( value ) );
        if( !name.empty() ) {
            result.push_back( name );
        }
    }
    return result;
}

std::vector<std::string> addiction_values()
{
    return sorted_dynamic_values(
    add_type::get_all(), []( const add_type & value ) {
        return value.id.str();
    } );
}

std::vector<std::string> attitude_values()
{
    return fixed_values( { "hostile", "neutral", "friendly", "any" } );
}

std::vector<std::string> body_part_values()
{
    return fixed_values( {
        "torso", "head", "eyes", "mouth",
        "arm_l", "arm_r", "hand_l", "hand_r",
        "leg_l", "leg_r", "foot_l", "foot_r"
    } );
}

std::vector<std::string> move_mode_values()
{
    const std::vector<move_mode_id> &modes = move_modes_by_speed();
    return sorted_dynamic_values(
    modes, []( const move_mode_id & value ) {
        return value.str();
    } );
}

std::vector<std::string> monster_size_values()
{
    return fixed_values( { "tiny", "small", "medium", "large", "huge" } );
}

std::vector<std::string> damage_type_values()
{
    return sorted_dynamic_values(
    damage_type::get_all(), []( const damage_type & value ) {
        return value.id.str();
    } );
}

template<typename Enum>
std::vector<std::string> converted_enum_values(
    const int first, const int last )
{
    std::vector<std::string> result;
    result.reserve( static_cast<std::size_t>( last - first ) );
    for( int value = first; value < last; ++value ) {
        result.push_back(
            io::enum_to_string<Enum>( static_cast<Enum>( value ) ) );
    }
    return result;
}

std::vector<std::string> direction_values()
{
    return converted_enum_values<direction>(
               0, static_cast<int>( direction::last ) );
}

std::vector<std::string> message_type_values()
{
    return converted_enum_values<game_message_type>(
               0, static_cast<int>( game_message_type::num_game_message_type ) );
}

std::vector<std::string> monster_flag_values()
{
    return sorted_dynamic_values(
    mon_flag::get_all(), []( const mon_flag & value ) {
        return value.id.str();
    } );
}

std::vector<std::string> monster_faction_attitude_values()
{
    return fixed_values( { "by_mood", "neutral", "friendly", "hate" } );
}

std::vector<std::string> mission_goal_values()
{
    return converted_enum_values<mission_goal>( 0, NUM_MGOAL );
}

std::vector<std::string> mission_origin_values()
{
    return converted_enum_values<mission_origin>( 0, NUM_ORIGIN );
}

std::vector<std::string> monster_attitude_values()
{
    return fixed_values( {
        "null", "friend", "friendly_passive", "flee",
        "ignore", "follow", "attack"
    } );
}

std::vector<std::string> moon_phase_values()
{
    return converted_enum_values<moon_phase>( 0, MOON_PHASE_MAX );
}

std::vector<std::string> npc_attitude_values()
{
    std::vector<std::string> result;
    result.reserve( NPCATT_END );
    for( int value = 0; value < NPCATT_END; ++value ) {
        const std::string name =
            npc_attitude_id( static_cast<npc_attitude>( value ) );
        if( !name.empty() ) {
            result.push_back( name );
        }
    }
    return result;
}

std::vector<std::string> npc_need_values()
{
    return fixed_values( {
        "none", "ammo", "weapon", "gun", "food", "drink", "safety"
    } );
}

std::vector<std::string> overmap_match_values()
{
    return fixed_values( { "exact", "type", "subtype", "prefix", "contains" } );
}

std::vector<std::string> overmap_vision_values()
{
    return fixed_values( { "unseen", "vague", "outlines", "details", "full" } );
}

std::vector<std::string> phase_values()
{
    return converted_enum_values<phase_id>(
               0, static_cast<int>( phase_id::num_phases ) );
}

std::vector<std::string> sfx_channel_values()
{
    return fixed_values( {
        "daytime_outdoors_env",
        "nighttime_outdoors_env",
        "underground_env",
        "indoors_env",
        "indoors_rain_env",
        "outdoors_snow_env",
        "outdoors_flurry_env",
        "outdoors_thunderstorm_env",
        "outdoors_rainstorm_env",
        "outdoors_rain_env",
        "outdoors_drizzle_env",
        "outdoor_blizzard",
        "deafness_tone",
        "danger_extreme_theme",
        "danger_high_theme",
        "danger_medium_theme",
        "danger_low_theme",
        "stamina_75",
        "stamina_50",
        "stamina_35",
        "idle_chainsaw",
        "chainsaw_theme",
        "player_activities",
        "exterior_engine_sound",
        "interior_engine_sound",
        "radio",
        "outdoors_portal_storm_env",
        "outdoors_clear_env",
        "outdoors_cloudy_env",
        "outdoors_sunny_env"
    } );
}

std::vector<std::string> artifact_passive_values()
{
    return fixed_values( {
        "null",
        "str_up", "dex_up", "per_up", "int_up", "all_up", "speed_up",
        "pblue", "snakes", "invisible", "clairvoyance",
        "super_clairvoyance", "stealth", "extinguish", "glow",
        "psyshield", "resist_electricity", "carry_more", "sap_life", "fun",
        "split",
        "hunger", "thirst", "smoke", "evil", "schizo", "radioactive",
        "mutagenic", "attention", "str_down", "dex_down", "per_down",
        "int_down", "all_down", "speed_down", "force_teleport",
        "movement_noise", "bad_weather", "sick", "clairvoyance_plus"
    } );
}

std::vector<std::string> vitamin_type_values()
{
    return converted_enum_values<vitamin_type>(
               0, static_cast<int>( vitamin_type::num_vitamin_types ) );
}

std::vector<std::string> no_values()
{
    return {};
}

const std::vector<enum_family_definition> &enum_families()
{
    static const std::vector<enum_family_definition> families = {
        {
            "ActionId", enum_family_status::native, "", "", &action_values
        },
        {
            "AddictionType", enum_family_status::dynamic_id, "GameId<addiction>",
            "CCB addiction types are JSON-defined string IDs.", &addiction_values
        },
        {
            "ArtifactCharge", enum_family_status::not_applicable, "",
            "CCB removed the legacy artifact charge enum.", &no_values
        },
        {
            "ArtifactChargeReq", enum_family_status::not_applicable, "",
            "CCB removed the legacy artifact charge requirement enum.", &no_values
        },
        {
            "ArtifactEffectActive", enum_family_status::native, "", "",
            &artifact_passive_values
        },
        {
            "ArtifactEffectPassive", enum_family_status::not_applicable, "",
            "CCB no longer models active artifact effects with this legacy enum.", &no_values
        },
        {
            "Attitude", enum_family_status::native, "", "", &attitude_values
        },
        {
            "BodyPart", enum_family_status::native, "", "", &body_part_values
        },
        {
            "CharacterMoveMode", enum_family_status::dynamic_id, "GameId<move_mode>",
            "CCB movement modes are JSON-defined string IDs.", &move_mode_values
        },
        {
            "DamageType", enum_family_status::dynamic_id, "GameId<damage_type>",
            "CCB damage types are JSON-defined string IDs.", &damage_type_values
        },
        {
            "Direction", enum_family_status::native, "", "", &direction_values
        },
        {
            "MissionGoal", enum_family_status::native, "", "", &mission_goal_values
        },
        {
            "MissionOrigin", enum_family_status::native, "", "", &mission_origin_values
        },
        {
            "MonsterAttitude", enum_family_status::native, "", "",
            &monster_attitude_values
        },
        {
            "MonsterFactionAttitude", enum_family_status::native, "", "",
            &monster_faction_attitude_values
        },
        {
            "MonsterFlag", enum_family_status::dynamic_id, "GameId<monster_flag>",
            "CCB monster flags are JSON-defined string IDs.", &monster_flag_values
        },
        {
            "MonsterSize", enum_family_status::native, "", "", &monster_size_values
        },
        {
            "MoonPhase", enum_family_status::native, "", "", &moon_phase_values
        },
        {
            "MsgType", enum_family_status::native, "", "", &message_type_values
        },
        {
            "NpcAttitude", enum_family_status::native, "", "", &npc_attitude_values
        },
        {
            "NpcNeed", enum_family_status::native, "", "", &npc_need_values
        },
        {
            "OtMatchType", enum_family_status::native, "", "", &overmap_match_values
        },
        {
            "OmVisionLevel", enum_family_status::native, "", "", &overmap_vision_values
        },
        {
            "Phase", enum_family_status::native, "", "", &phase_values
        },
        {
            "SfxChannel", enum_family_status::native, "", "", &sfx_channel_values
        },
        {
            "VitaminType", enum_family_status::native, "", "", &vitamin_type_values
        }
    };
    return families;
}

const enum_family_definition *find_enum_family( const std::string_view name )
{
    const std::vector<enum_family_definition> &families = enum_families();
    const auto found = std::find_if(
    families.begin(), families.end(), [name]( const enum_family_definition & family ) {
        return family.name == name;
    } );
    return found == families.end() ? nullptr : &*found;
}

std::string_view enum_status_name( const enum_family_status status )
{
    switch( status ) {
        case enum_family_status::native:
            return "native";
        case enum_family_status::dynamic_id:
            return "dynamic_id";
        case enum_family_status::not_applicable:
            return "not_applicable";
    }
    throw std::logic_error( "unknown game.enums family status" );
}

const enum_family_definition &require_enum_family( const std::string_view kind )
{
    const enum_family_definition *family = find_enum_family( kind );
    if( family == nullptr ) {
        throw std::invalid_argument(
            "game.enums received an unknown enum family: " + std::string( kind ) );
    }
    return *family;
}

std::size_t require_enum_entry(
    const std::string_view kind, const std::string_view name )
{
    const enum_family_definition &family = require_enum_family( kind );
    if( family.status == enum_family_status::not_applicable ) {
        throw std::invalid_argument(
            "game.enums family " + std::string( kind ) +
            " is not applicable in this CCB engine" );
    }
    std::vector<std::string> values = family.values();
    const auto found = std::find( values.begin(), values.end(), name );
    if( found == values.end() ) {
        throw std::invalid_argument(
            "game.enums received an unknown " + std::string( kind ) +
            " value: " + std::string( name ) );
    }
    return static_cast<std::size_t>( std::distance( values.begin(), found ) );
}

sol::table enum_values_table(
    sol::state_view lua, const std::string_view kind,
    const std::vector<std::string> &names,
    const std::size_t offset, const std::size_t limit )
{
    const std::size_t first = std::min( offset, names.size() );
    const std::size_t last = std::min( first + limit, names.size() );
    sol::table result = lua.create_table(
                            static_cast<int>( last - first ), 0 );
    for( std::size_t index = first; index < last; ++index ) {
        result[index - first + 1] =
            script_enum_value::from( kind, names[index] );
    }
    return result;
}

} // namespace

script_enum_value::script_enum_value(
    std::string kind, std::string name, const std::size_t ordinal )
    : kind_( std::move( kind ) ), name_( std::move( name ) ),
      ordinal_( ordinal )
{
}

script_enum_value script_enum_value::from(
    const std::string_view kind, const std::string_view name )
{
    const std::size_t ordinal = require_enum_entry( kind, name );
    return script_enum_value(
               std::string( kind ), std::string( name ), ordinal );
}

const std::string &script_enum_value::kind() const noexcept
{
    return kind_;
}

const std::string &script_enum_value::name() const noexcept
{
    return name_;
}

std::size_t script_enum_value::ordinal() const noexcept
{
    return ordinal_;
}

std::string script_enum_value::to_string() const
{
    return kind_ + "." + name_;
}

std::vector<std::string> supported_script_enum_kinds()
{
    std::vector<std::string> result;
    result.reserve( enum_families().size() );
    for( const enum_family_definition &family : enum_families() ) {
        result.emplace_back( family.name );
    }
    return result;
}

std::vector<std::string> script_enum_names( const std::string_view kind )
{
    return require_enum_family( kind ).values();
}

bool script_enum_kind_is_available( const std::string_view kind )
{
    const enum_family_definition *family = find_enum_family( kind );
    return family != nullptr &&
           family->status != enum_family_status::not_applicable;
}

void install_enum_value_api(
    sol::state &lua, sol::table &game, std::function<void()> require_values )
{
    lua.new_usertype<script_enum_value>(
        "GameEnum", sol::no_constructor,
        "kind", sol::property( &script_enum_value::kind ),
        "name", sol::property( &script_enum_value::name ),
        "ordinal", sol::property( &script_enum_value::ordinal ),
        sol::meta_function::to_string, &script_enum_value::to_string,
        sol::meta_function::equal_to,
    []( const script_enum_value & lhs, const script_enum_value & rhs ) {
        return lhs == rhs;
    } );

    sol::table enum_api = lua.create_table();
    enum_api.set_function(
        "value",
    [require_values]( const std::string & kind, const std::string & name ) {
        require_values();
        return script_enum_value::from( kind, name );
    } );
    enum_api.set_function( "kinds", [require_values]( sol::this_state lua_state ) {
        require_values();
        sol::state_view state( lua_state );
        const std::vector<std::string> kinds = supported_script_enum_kinds();
        sol::table result = state.create_table(
                                static_cast<int>( kinds.size() ), 0 );
        for( std::size_t index = 0; index < kinds.size(); ++index ) {
            result[index + 1] = kinds[index];
        }
        return result;
    } );
    enum_api.set_function(
        "describe",
    [require_values]( sol::this_state lua_state, const std::string & kind ) {
        require_values();
        sol::state_view state( lua_state );
        const enum_family_definition &family = require_enum_family( kind );
        const std::vector<std::string> names = family.values();
        sol::table result = state.create_table();
        result["kind"] = std::string( family.name );
        result["status"] = std::string( enum_status_name( family.status ) );
        result["available"] =
            family.status != enum_family_status::not_applicable;
        result["replacement"] = std::string( family.replacement );
        result["reason"] = std::string( family.reason );
        result["count"] = names.size();
        return result;
    } );
    enum_api.set_function(
        "values",
        [require_values](
            sol::this_state lua_state, const std::string & kind,
            const sol::optional<std::int64_t> &raw_offset,
    const sol::optional<std::int64_t> &raw_limit ) {
        require_values();
        const enum_family_definition &family = require_enum_family( kind );
        if( family.status == enum_family_status::not_applicable ) {
            throw std::invalid_argument(
                "game.enums.values cannot enumerate a not-applicable family" );
        }
        const std::int64_t offset = raw_offset.value_or( 0 );
        const std::int64_t limit = raw_limit.value_or( 128 );
        if( offset < 0 || offset > 1000000 ) {
            throw std::invalid_argument(
                "game.enums.values offset must be within 0..1000000" );
        }
        if( limit < 0 || limit > 512 ) {
            throw std::invalid_argument(
                "game.enums.values limit must be within 0..512" );
        }
        return enum_values_table(
                   sol::state_view( lua_state ), kind, family.values(),
                   static_cast<std::size_t>( offset ),
                   static_cast<std::size_t>( limit ) );
    } );
    enum_api.set_function(
        "has",
    [require_values]( const std::string & kind, const std::string & name ) {
        require_values();
        const enum_family_definition &family = require_enum_family( kind );
        if( family.status == enum_family_status::not_applicable ) {
            return false;
        }
        const std::vector<std::string> values = family.values();
        return std::find( values.begin(), values.end(), name ) != values.end();
    } );
    game["enums"] = std::move( enum_api );
}

} // namespace cata::lua_ui
