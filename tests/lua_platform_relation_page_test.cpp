#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <algorithm>
#include <cstddef>
#include <functional>
#include <initializer_list>
#include <map>
#include <optional>
#include <set>
#include <string>
#include <utility>
#include <vector>

#include "bionics.h"
#include "cata_catch.h"
#include "flat_set.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_bionics.h"
#include "lua_platform_handle.h"
#include "lua_platform_magic.h"
#include "lua_platform_martial_arts.h"
#include "lua_platform_mutations.h"
#include "lua_platform_relation_page.h"
#include "lua_platform_sol.h"
#include "magic.h"
#include "martialarts.h"
#include "mutation.h"
#include "translation.h"
#include "type_id.h"

static const bionic_id bio_flashlight( "bio_flashlight" );
static const matec_id tech_base_headbutt( "tech_base_headbutt" );
static const matype_id style_karate( "style_karate" );
static const spell_id spell_test_spell_json( "test_spell_json" );
static const trait_id trait_STRONGER_VULNERABLEWARM( "STRONGER_VULNERABLEWARM" );
static const trait_id trait_hair_buzzcut( "hair_buzzcut" );

namespace
{
sol::table check_page_shape( const sol::table &page, std::size_t total, std::size_t maximum )
{
    const std::size_t returned = std::min( total, maximum );
    CHECK( page["total"].get<std::size_t>() == total );
    CHECK( page["returned"].get<std::size_t>() == returned );
    CHECK( page["truncated"].get<bool>() == ( total > maximum ) );
    sol::table items = page["items"];
    REQUIRE( items.size() == returned );
    CHECK( items.get<sol::object>( 0 ).get_type() == sol::type::nil );
    CHECK( items.get<sol::object>( returned + 1 ).get_type() == sol::type::nil );
    return items;
}

template<typename Range>
void check_native_ids( const sol::table &page, const Range &ids, std::size_t maximum,
                       const std::string &kind = {} )
{
    sol::table items = check_page_shape( page, ids.size(), maximum );
    std::size_t index = 0;
    for( const auto &id : ids ) {
        if( index == maximum ) {
            break;
        }
        ++index;
        if( kind.empty() ) {
            CHECK( items[index].get<std::string>() == id.str() );
        } else {
            const cata::lua_platform::script_game_id value =
                items[index].get<cata::lua_platform::script_game_id>();
            CHECK( value.kind() == kind );
            CHECK( value.value() == id.str() );
        }
    }
}

template<typename Range>
void check_native_strings( const sol::table &page, const Range &values, std::size_t maximum )
{
    sol::table items = check_page_shape( page, values.size(), maximum );
    std::size_t index = 0;
    for( const std::string &value : values ) {
        if( index == maximum ) {
            break;
        }
        CHECK( items[++index].get<std::string>() == value );
    }
}

sol::table definition_snapshot( const sol::table &services, const std::string &domain,
                                const std::string &kind, const std::string &id,
                                const std::string &method = "definition" )
{
    sol::protected_function get = services[domain][method];
    sol::protected_function_result call = get( cata::lua_platform::script_game_id( kind, id ) );
    REQUIRE( call.valid() );
    return call.get<sol::table>();
}
} // namespace

TEST_CASE( "lua_platform_relation_pages_preserve_boundaries_order_and_value_types",
           "[lua][platform][semantic][relation_page]" )
{
    const std::size_t maximum = GENERATE( 64, 128, 256 );
    const int boundary = GENERATE( 0, 1, 2 );
    const std::size_t total = boundary == 0 ? 0 : maximum + ( boundary == 2 ? 1 : 0 );
    CAPTURE( maximum, total );
    std::vector<std::string> values;
    std::vector<trait_id> ids;
    for( std::size_t index = 0; index < total; ++index ) {
        // Deliberately descending: the builder must preserve, not sort, native order.
        values.push_back( "relation_" + std::to_string( total - index ) );
        ids.emplace_back( values.back() );
    }
    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_value_type_api( lua, services, []() {} );
    sol::state_view view( lua.lua_state() );
    const sol::table typed = cata::lua_platform::detail::make_typed_id_page(
                                 view, maximum, ids, "mutation" );
    const sol::table string_ids = cata::lua_platform::detail::make_string_id_page(
                                      view, maximum, ids );
    const sol::table strings = cata::lua_platform::detail::make_string_page(
                                   view, maximum, values );
    check_native_ids( typed, ids, maximum, "mutation" );
    check_native_ids( string_ids, ids, maximum );
    check_native_strings( strings, values, maximum );
    if( total != 0 ) {
        const std::string first = values.front();
        values.front() = "changed";
        ids.front() = trait_id( values.front() );
        CHECK( strings["items"][1].get<std::string>() == first );
        CHECK( string_ids["items"][1].get<std::string>() == first );
        CHECK( typed["items"][1].get<cata::lua_platform::script_game_id>().value() == first );
    }
}

TEST_CASE( "lua_platform_definition_relation_pages_match_native_values",
           "[lua][platform][semantic][relation_page]" )
{
    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_value_type_api( lua, services, []() {} );
    const cata::lua_platform::game_handle_runtime_owner_ptr owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime generation{ owner, 1 };
    const auto runtime = [generation]() {
        return generation;
    };
    const auto world = []() {
        return std::size_t( 1 );
    };
    const auto require_access = []() {};

    SECTION( "bionics retain typed flags and raw enchantment ids" ) {
        REQUIRE( bio_flashlight.is_valid() );
        REQUIRE_FALSE( bio_flashlight->flags.empty() );
        REQUIRE_FALSE( bio_flashlight->enchantments.empty() );
        cata::lua_platform::install_bionic_api( services, runtime, world,
                                                require_access, require_access );
        sol::table snapshot = definition_snapshot( services, "bionics", "bionic", bio_flashlight.str() );
        check_native_ids( snapshot["flags"], bio_flashlight->flags, 128, "json_flag" );
        check_native_ids( snapshot["included_bionics"], bio_flashlight->included_bionics, 128, "bionic" );
        check_native_ids( snapshot["enchantments"], bio_flashlight->enchantments, 128 );
        for( const char *id : {
                 "test_bio_purifier", "bio_armor_arms"
             } ) {
            const bionic_data &native = bionic_id( id ).obj();
            snapshot = definition_snapshot( services, "bionics", "bionic", id );
            const auto check_body_parts = [&]( const char *field, const auto & values ) {
                sol::table items = check_page_shape( snapshot[field], values.size(), 64 );
                std::size_t index = 0;
                for( const auto &entry : values ) {
                    sol::table record = items[++index];
                    CHECK( record["body_part"].get<cata::lua_platform::script_game_id>() ==
                           cata::lua_platform::script_game_id( "body_part", entry.first.str() ) );
                    CHECK( record["value"].get<int>() == static_cast<int>( entry.second ) );
                }
            };
            check_body_parts( "environmental_protection", native.env_protec );
            check_body_parts( "occupied_body_parts", native.occupied_bodyparts );
            check_body_parts( "encumbrance", native.encumbrance );
        }
    }
    SECTION( "mutations retain typed relations, strings, and raw enchantment ids" ) {
        REQUIRE( trait_STRONGER_VULNERABLEWARM.is_valid() );
        const mutation_branch &native = trait_STRONGER_VULNERABLEWARM.obj();
        REQUIRE_FALSE( native.prereqs.empty() );
        REQUIRE_FALSE( native.types.empty() );
        REQUIRE_FALSE( native.enchantments.empty() );
        cata::lua_platform::install_mutation_api( services, runtime, world,
                require_access, require_access );
        sol::table snapshot = definition_snapshot( services, "mutations", "mutation", native.id.str() );
        sol::table relations = snapshot["relations"];
        check_native_ids( relations["prerequisites"], native.prereqs, 128, "mutation" );
        check_native_ids( relations["conflicts_with"], native.cancels, 128, "mutation" );
        check_native_strings( relations["types"], native.types, 128 );
        check_native_ids( snapshot["enchantments"], native.enchantments, 128 );
        snapshot = definition_snapshot( services, "mutations", "mutation", "hair_buzzcut" );
        const auto &variants = trait_hair_buzzcut->variants;
        REQUIRE_FALSE( variants.empty() );
        sol::table variants_page = check_page_shape( snapshot["variants"], variants.size(), 128 );
        std::size_t index = 0;
        for( const auto &entry : variants ) {
            sol::table record = variants_page[++index];
            CHECK( record["id"].get<std::string>() == entry.second.id );
            CHECK( record["name"].get<std::string>() == entry.second.alt_name.translated() );
            CHECK( record["description"].get<std::string>() == entry.second.alt_description.translated() );
            CHECK( record["append_description"].get<bool>() == entry.second.append_desc );
            CHECK( record["weight"].get<int>() == entry.second.weight );
        }
        snapshot = definition_snapshot( services, "mutations", "mutation", "TEST_LUA_MUTATION_LIFECYCLE" );
        sol::table learned = check_page_shape( snapshot["learned_spells"], 1, 128 )[1];
        CHECK( learned["id"].get<cata::lua_platform::script_game_id>() ==
               cata::lua_platform::script_game_id( "spell", "test_spell_kiss" ) );
        CHECK( learned["level"].get<int>() == 1 );
        snapshot = definition_snapshot( services, "mutations", "mutation", "MANDIBLES" );
        sol::table quality = check_page_shape( snapshot["equipment"]["provided_qualities"], 1, 128 )[1];
        CHECK( quality["id"].get<cata::lua_platform::script_game_id>() ==
               cata::lua_platform::script_game_id( "quality", "BUTCHER" ) );
        CHECK( quality["level"].get<int>() == 4 );
    }
    SECTION( "spells retain string flags and typed monster relations" ) {
        REQUIRE( spell_test_spell_json.is_valid() );
        const spell_type &native = spell_test_spell_json.obj();
        REQUIRE_FALSE( native.flags.empty() );
        REQUIRE_FALSE( native.targeted_monster_ids.empty() );
        cata::lua_platform::install_magic_api( services, runtime, world,
                                               require_access, require_access );
        sol::table snapshot = definition_snapshot( services, "spells", "spell", native.id.str() );
        check_native_strings( snapshot["flags"], native.flags, 128 );
        check_native_ids( snapshot["targeted_monsters"], native.targeted_monster_ids, 128, "monster" );
        REQUIRE( native.additional_spells.size() == 1 );
        const fake_spell &extra = native.additional_spells.front();
        sol::table additional = check_page_shape( snapshot["additional_spells"], 1, 128 )[1];
        CHECK( additional["id"].get<cata::lua_platform::script_game_id>() ==
               cata::lua_platform::script_game_id( "spell", extra.id.str() ) );
        CHECK( additional["level"].get<int>() == extra.level );
        CHECK( additional["force_target_source"].get<bool>() == extra.self );
        CHECK( additional["trigger_once_in"].get<int>() == extra.trigger_once_in );
        CHECK_FALSE( extra.max_level.has_value() );
        CHECK( additional["maximum_level"].get<sol::object>().get_type() == sol::type::nil );
        sol::table learned = check_page_shape( snapshot["learned_spells"], 1, 128 )[1];
        CHECK( learned["id"].get<cata::lua_platform::script_game_id>() ==
               cata::lua_platform::script_game_id( "spell", "test_fake_spell" ) );
        CHECK( learned["level"].get<int>() == 1 );
        REQUIRE_FALSE( native.src.empty() );
        sol::table sources = check_page_shape( snapshot["sources"], native.src.size(), 128 );
        for( std::size_t index = 0; index < native.src.size(); ++index ) {
            sol::table record = sources[index + 1];
            CHECK( record["spell"].get<cata::lua_platform::script_game_id>() ==
                   cata::lua_platform::script_game_id( "spell", native.src[index].first.str() ) );
            CHECK( record["mod"].get<cata::lua_platform::script_game_id>() ==
                   cata::lua_platform::script_game_id( "mod", native.src[index].second.str() ) );
        }
    }
    SECTION( "martial arts retain technique order and string flags" ) {
        REQUIRE( style_karate.is_valid() );
        REQUIRE( tech_base_headbutt.is_valid() );
        REQUIRE_FALSE( style_karate->techniques.empty() );
        cata::lua_platform::install_martial_art_api( services, runtime, world,
                require_access, require_access );
        sol::table snapshot = definition_snapshot( services, "martial_arts", "martial_art",
                              style_karate.str() );
        check_native_ids( snapshot["techniques"], style_karate->techniques, 256, "martial_art_technique" );
        snapshot = definition_snapshot( services, "martial_arts", "martial_art_technique",
                                        tech_base_headbutt.str(), "technique_definition" );
        check_native_strings( snapshot["flags"], tech_base_headbutt->flags, 256 );
        check_native_ids( snapshot["attack_vectors"], tech_base_headbutt->attack_vectors, 256,
                          "attack_vector" );
    }
}

#endif
