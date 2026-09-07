#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <cstddef>
#include <set>
#include <stdexcept>
#include <string>

#include "avatar.h"
#include "cata_catch.h"
#include "character.h"
#include "character_id.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_handle.h"
#include "lua_platform_mutations.h"
#include "npc.h"
#include "type_id.h"

namespace
{
struct mutation_fixture {
    mutation_fixture() {
        player.normalize();
        player.setID( character_id( 1801 ), true );
        other.normalize();
        other.setID( character_id( 1802 ), true );
        cata::lua_platform::register_npc_handle_identity( other );
        cata::lua_platform::install_value_type_api( lua, services, []() {} );
        cata::lua_platform::install_game_handle_api(
        lua, services, [this]() {
            return runtime;
        },
        [this]() {
            return world;
        }, []() {} );
        cata::lua_platform::install_mutation_api(
        services, [this]() {
            return runtime;
        }, [this]() {
            return world;
        },
        []() {}, [this]() {
            if( !writable ) {
                throw std::runtime_error( "test: mutation outside write phase" );
            }
        } );
    }

    ~mutation_fixture() {
        cata::lua_platform::retire_npc_handle_identity( other );
    }

    cata::lua_platform::game_handle handle( const bool npc_target ) {
        Character &target = npc_target ? static_cast<Character &>( other ) : player;
        return cata::lua_platform::game_handle::from_creature(
                   target, { npc_target ? "npc" : "avatar", target.getID().get_value(), 0, 0, 0, {} },
                   runtime, world );
    }

    sol::protected_function remove_type() {
        return services["mutations"]["remove_type"];
    }

    cata::lua_platform::game_handle_runtime_owner_ptr owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    cata::lua_platform::game_handle_runtime runtime{ owner, 1 };
    std::size_t world = 1;
    bool writable = true;
    avatar player;
    npc other;
    sol::state lua;
    sol::table services = lua.create_table();
};
} // namespace

TEST_CASE( "lua_platform_mutations_remove_type_targets_exact_character",
           "[lua][platform][mutations]" )
{
    mutation_fixture fixture;
    const bool npc_target = GENERATE( false, true );
    Character &target = npc_target ? static_cast<Character &>( fixture.other ) : fixture.player;
    Character &untouched = npc_target ? static_cast<Character &>( fixture.player ) : fixture.other;
    const trait_id cold( "VULNERABLECHILL" );
    const trait_id heat( "STRONGER_VULNERABLEWARM" );
    const trait_id keep( "QUICK" );
    target.set_mutation( cold );
    target.set_mutation( heat );
    target.set_mutation( keep );
    untouched.set_mutation( cold );
    REQUIRE( target.has_trait( cold ) );
    REQUIRE( target.has_trait( heat ) );

    sol::protected_function_result call = fixture.remove_type()( fixture.handle( npc_target ),
        "ACCLIMATIZATION" );
    REQUIRE( call.valid() );
    sol::table result = call;
    REQUIRE( result["ok"].get<bool>() );
    sol::table value = result["value"];
    CHECK( value["type"].get<std::string>() == "ACCLIMATIZATION" );
    CHECK( value["removed_count"].get<int>() == 2 );
    sol::table removed = value["removed"];
    std::set<std::string> ids;
    for( const auto &entry : removed ) {
        const auto id = entry.second.as<cata::lua_platform::script_game_id>();
        CHECK( id.kind() == "mutation" );
        ids.insert( id.value() );
    }
    CHECK( ids == std::set<std::string> { cold.str(), heat.str() } );
    CHECK_FALSE( target.has_trait( cold ) );
    CHECK_FALSE( target.has_trait( heat ) );
    CHECK_FALSE( target.has_trait( trait_id( "VULNERABLEWARM" ) ) );
    CHECK( target.has_trait( keep ) );
    CHECK( untouched.has_trait( cold ) );

    // Repeating a removal and requesting an unknown type both succeed unchanged.
    for( const char *type : {
             "ACCLIMATIZATION", "test_unknown_mutation_type"
         } ) {
        sol::protected_function_result again = fixture.remove_type()( fixture.handle( npc_target ), type );
        REQUIRE( again.valid() );
        sol::table unchanged = again;
        REQUIRE( unchanged["ok"].get<bool>() );
        CHECK( unchanged["value"]["removed_count"].get<int>() == 0 );
        CHECK( unchanged["value"]["removed"].get<sol::table>().size() == 0 );
        CHECK( target.has_trait( keep ) );
    }
}

TEST_CASE( "lua_platform_mutations_remove_type_rejects_invalid_inputs_before_mutating",
           "[lua][platform][mutations]" )
{
    mutation_fixture fixture;
    const trait_id cold( "VULNERABLECHILL" );
    fixture.player.set_mutation( cold );
    const auto handle = fixture.handle( false );

    SECTION( "invalid_type" ) {
        for( const std::string &type : {
                 std::string(), std::string( 257, 'x' ),
                 std::string( "ACCLIMATIZATION\0ignored", 23 )
             } ) {
            sol::protected_function_result call = fixture.remove_type()( handle, type );
            CHECK_FALSE( call.valid() );
            CHECK( fixture.player.has_trait( cold ) );
        }
    }
    SECTION( "wrong_phase" ) {
        fixture.writable = false;
        sol::protected_function_result call = fixture.remove_type()( handle, "ACCLIMATIZATION" );
        CHECK_FALSE( call.valid() );
    }
    SECTION( "stale_world" ) {
        ++fixture.world;
        sol::protected_function_result call = fixture.remove_type()( handle, "ACCLIMATIZATION" );
        REQUIRE( call.valid() );
        sol::table result = call;
        CHECK_FALSE( result["ok"].get<bool>() );
        CHECK( result["error"]["code"].get<std::string>() == "stale_world" );
    }
    SECTION( "retired_runtime" ) {
        fixture.owner->retire();
        sol::protected_function_result call = fixture.remove_type()( handle, "ACCLIMATIZATION" );
        REQUIRE( call.valid() );
        sol::table result = call;
        CHECK_FALSE( result["ok"].get<bool>() );
        CHECK( result["error"]["code"].get<std::string>() == "stale_runtime" );
    }
    CHECK( fixture.player.has_trait( cold ) );
}


#endif
