#include "catalua_bindings_values.h"

#include <algorithm>
#include <array>
#include <stdexcept>
#include <string>
#include <utility>

#include "ammo.h"
#include "ammo_effect.h"
#include "bionics.h"
#include "bodypart.h"
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
}

} // namespace cata::lua_ui
