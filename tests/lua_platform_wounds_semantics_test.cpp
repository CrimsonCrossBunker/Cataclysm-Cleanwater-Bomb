#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <creature.h>
#include "flexbuffer_json.h"
#include <talker.h>
#include <cstddef>
#include <functional>
#include <initializer_list>
#include <memory>
#include <string>
#include <vector>

#include "avatar.h"
#include "bodypart.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "character_id.h"
#include "debug.h"
#include "dialogue.h"
#include "dialogue_helpers.h"
#include "json_loader.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_handle.h"
#include "lua_platform_runtime.h"
#include "lua_platform_sol.h"
#include "npc.h"
#include "type_id.h"
#include "wound.h"

static const bodypart_str_id body_part_head_dragonfly( "head_dragonfly" );
static const efftype_id effect_incorporeal( "incorporeal" );
static const trait_id trait_MASOCHIST( "MASOCHIST" );
static const wound_type_id wound_wound_platform_effect_test( "wound_platform_effect_test" );

namespace cata::lua_platform
{
class runtime;
}  // namespace cata::lua_platform


TEST_CASE( "lua_platform_direct_wound_services_match_native_effects",
           "[lua][platform][wounds][semantic][thermal_burn]" )
{
    wound_type::load_wounds(
        json_loader::from_string( R"({
            "id": "wound_platform_effect_test",
            "name": "test wound",
            "description": "A wound used to compare direct native effects.",
            "damage_types": [ "bash" ],
            "damage_required": [ 1, 2 ],
            "weight": 0,
            "pain": [ 10, 10 ],
            "healing_time": [ "10 minutes", "10 minutes" ],
            "limit": 1
        })" ).get_object(), "lua_platform_wounds_semantics_test" );
    wound_type::finalize_all();
    REQUIRE( wound_wound_platform_effect_test.is_valid() );

    cata::lua_platform::clear_active_runtimes();
    avatar native_alpha;
    avatar platform_alpha;
    avatar capped_alpha;
    npc native_beta;
    npc platform_beta;
    native_alpha.normalize();
    platform_alpha.normalize();
    capped_alpha.normalize();
    native_beta.normalize();
    platform_beta.normalize();
    native_alpha.setID( character_id( 7311 ), true );
    platform_alpha.setID( character_id( 7312 ), true );
    capped_alpha.setID( character_id( 7313 ), true );
    native_beta.setID( character_id( 7315 ), true );
    platform_beta.setID( character_id( 7316 ), true );
    cata::lua_platform::register_npc_handle_identity( platform_beta );
    const on_out_of_scope retire_npc( [&]() {
        cata::lua_platform::retire_npc_handle_identity( platform_beta );
    } );

    dialogue native_alpha_dialogue( get_talker_for( native_alpha ), nullptr );
    dialogue native_npc_dialogue( get_talker_for( native_alpha ), get_talker_for( native_beta ) );
    const bodypart_id requested_part = body_part_head_dragonfly.id();
    native_alpha.set_mutation( trait_MASOCHIST );
    platform_alpha.set_mutation( trait_MASOCHIST );
    capped_alpha.set_mutation( trait_MASOCHIST );
    REQUIRE_FALSE( native_alpha.has_part( requested_part, body_part_filter::strict ) );
    REQUIRE( native_alpha.get_part( requested_part ) != nullptr );
    CHECK( native_alpha.get_part( requested_part )->get_id() == body_part_head.id() );

    sol::state lua;
    sol::table ccb = lua.create_table();
    const auto runtime = cata::lua_platform::make_runtime(
                             "wound_effect_semantics", 7317, lua );
    const on_out_of_scope cleanup( []() {
        cata::lua_platform::clear_active_runtimes();
    } );
    cata::lua_platform::install_runtime_api( runtime, lua, ccb );
    cata::lua_platform::set_active_runtimes( { runtime } );

    bool completed = false;
    lua.set_function( "accept", [&]( const sol::table & ) {
        const auto handle_for = [&]( Character & creature, const bool is_npc ) {
            return cata::lua_platform::game_handle::from_creature(
                       creature,
            { is_npc ? "npc" : "avatar", creature.getID().get_value(), 0, 0, 0, {} },
            cata::lua_platform::detail::runtime_handle_identity( runtime ),
            cata::lua_platform::runtime_world_generation() );
        };
        const cata::lua_platform::game_handle alpha_handle = handle_for( platform_alpha, false );
        const cata::lua_platform::game_handle beta_handle = handle_for( platform_beta, true );
        const cata::lua_platform::game_handle capped_handle = handle_for( capped_alpha, false );
        const cata::lua_platform::script_game_id part_id( "body_part", "head_dragonfly" );
        const cata::lua_platform::script_game_id exact_part_id( "body_part", "head" );
        const cata::lua_platform::script_game_id wound_id(
            "wound", wound_wound_platform_effect_test.str() );
        REQUIRE( part_id.is_valid() );
        REQUIRE( exact_part_id.is_valid() );
        REQUIRE( wound_id.is_valid() );
        const sol::table services = ccb["services"];

        const auto apply_native = []( dialogue & context, const std::string & source ) {
            talk_effect_t effect;
            effect.parse_sub_effect( json_loader::from_string( source ).get_object(),
                                     "lua_platform_wounds_semantics_test" );
            for( const talk_effect_fun_t &function : effect.effects ) {
                function( context );
            }
        };
        const auto apply_platform = [&]( const std::string & method,
        const cata::lua_platform::game_handle & handle ) {
            sol::protected_function function = services["wounds"][method];
            const sol::protected_function_result call = function( handle, part_id, wound_id );
            REQUIRE( call.valid() );
            const sol::table result = call;
            REQUIRE( result["ok"].get<bool>() );
            return result["value"]["changed"].get<bool>();
        };
        const auto wound_count = [&]( Character & character ) {
            return static_cast<int>( character.get_part( requested_part )->get_wounds().size() );
        };

        for( int repeat = 0; repeat < 2; ++repeat ) {
            apply_native( native_alpha_dialogue,
                          R"({"u_add_wound":"head_dragonfly","wound_id":"wound_platform_effect_test"})" );
            CHECK( apply_platform( "add_unbounded", alpha_handle ) );
            CHECK( wound_count( native_alpha ) == repeat + 1 );
            CHECK( wound_count( platform_alpha ) == repeat + 1 );
        }
        CHECK( wound_count( native_alpha ) == 2 );
        CHECK( wound_count( platform_alpha ) == 2 );
        CHECK( native_alpha.get_morale_level() == 0 );
        CHECK( platform_alpha.get_morale_level() == 0 );
        native_alpha.on_stat_change( "perceived_pain", native_alpha.get_perceived_pain() );
        platform_alpha.on_stat_change( "perceived_pain", platform_alpha.get_perceived_pain() );
        CHECK( native_alpha.get_morale_level() == platform_alpha.get_morale_level() );
        CHECK( native_alpha.get_morale_level() > 0 );

        const auto capped_add = [&]() {
            sol::protected_function function = services["wounds"]["add"];
            const sol::protected_function_result call = function(
                        capped_handle, exact_part_id, wound_id );
            REQUIRE( call.valid() );
            const sol::table result = call;
            REQUIRE( result["ok"].get<bool>() );
        };
        capped_add();
        capped_add();
        CHECK( wound_count( capped_alpha ) == 1 );
        CHECK( capped_alpha.get_morale_level() > 0 );

        const int native_morale_before_direct_remove = native_alpha.get_morale_level();
        const int platform_morale_before_direct_remove = platform_alpha.get_morale_level();

        apply_native( native_alpha_dialogue,
                      R"({"u_remove_wound":"head_dragonfly","wound_id":["wound_platform_effect_test"]})" );
        CHECK( apply_platform( "remove_all_direct", alpha_handle ) );
        CHECK( wound_count( native_alpha ) == 0 );
        CHECK( wound_count( platform_alpha ) == 0 );
        CHECK( native_alpha.get_morale_level() == native_morale_before_direct_remove );
        CHECK( platform_alpha.get_morale_level() == platform_morale_before_direct_remove );

        constexpr const char *npc_add =
            R"({"npc_add_wound":"head_dragonfly","wound_id":"wound_platform_effect_test"})";
        constexpr const char *npc_remove =
            R"({"npc_remove_wound":"head_dragonfly","wound_id":["wound_platform_effect_test"]})";
        const std::string add_beta_fallback_diagnostic = capture_debugmsg_during( [&]() {
            apply_native( native_alpha_dialogue, npc_add );
        } );
        CHECK( add_beta_fallback_diagnostic.find( "Tried to use an invalid beta talker." ) !=
               std::string::npos );
        REQUIRE( wound_count( native_alpha ) == 1 );
        CHECK( wound_count( native_beta ) == 0 );

        apply_native( native_npc_dialogue, npc_add );
        CHECK( apply_platform( "add_unbounded", beta_handle ) );
        REQUIRE( wound_count( native_beta ) == 1 );
        CHECK( wound_count( platform_beta ) == 1 );
        const std::string missing_beta_diagnostic = capture_debugmsg_during( [&]() {
            apply_native( native_alpha_dialogue, npc_remove );
        } );
        CHECK( missing_beta_diagnostic.empty() );
        CHECK( wound_count( native_alpha ) == 1 );
        apply_native( native_npc_dialogue, npc_remove );
        CHECK( apply_platform( "remove_all_direct", beta_handle ) );
        CHECK( wound_count( native_beta ) == 0 );
        CHECK( wound_count( platform_beta ) == 0 );
        CHECK( wound_count( native_alpha ) == 1 );

        sol::protected_function legacy_remove = services["wounds"]["remove"];
        const sol::protected_function_result legacy_remove_call = legacy_remove(
                    capped_handle, exact_part_id, wound_id );
        REQUIRE( legacy_remove_call.valid() );
        const sol::table legacy_remove_result = legacy_remove_call;
        REQUIRE( legacy_remove_result["ok"].get<bool>() );
        CHECK( wound_count( capped_alpha ) == 0 );
        CHECK( capped_alpha.get_morale_level() == 0 );

        sol::protected_function unknown_add = services["wounds"]["add_unbounded"];
        const sol::protected_function_result unknown_call = unknown_add(
                    alpha_handle, part_id,
                    cata::lua_platform::script_game_id( "wound", "wound_not_registered" ) );
        CHECK_FALSE( unknown_call.valid() );
        const sol::protected_function_result unknown_part_call = unknown_add(
                    alpha_handle,
                    cata::lua_platform::script_game_id( "body_part", "part_not_registered" ),
                    wound_id );
        CHECK_FALSE( unknown_part_call.valid() );
        sol::protected_function unknown_remove = services["wounds"]["remove_all_direct"];
        const sol::protected_function_result unknown_remove_call = unknown_remove(
                    alpha_handle, part_id,
                    cata::lua_platform::script_game_id( "wound", "wound_not_registered" ) );
        CHECK_FALSE( unknown_remove_call.valid() );
        CHECK( wound_count( platform_alpha ) == 0 );

        const cata::lua_platform::script_game_id hand( "body_part", "hand_l" );
        const cata::lua_platform::script_game_id arm( "body_part", "arm_l" );
        const cata::lua_platform::script_game_id blister( "wound", "thermal_blister" );
        const cata::lua_platform::script_game_id burn( "wound", "thermal_burn" );
        const auto invoke = [&]( const char *method, const auto &...args ) {
            sol::protected_function function = services["wounds"][method];
            const sol::protected_function_result call = function( alpha_handle, args... );
            REQUIRE( call.valid() );
            const sol::table result = call;
            REQUIRE( result["ok"].get<bool>() );
            return result["value"].get<sol::table>();
        };
        const auto check_snapshot = []( const sol::table &snapshot,
        std::initializer_list<const char *> expected ) {
            REQUIRE( snapshot.size() == expected.size() );
            std::size_t index = 1;
            for( const char *id : expected ) {
                const auto actual = snapshot[index]["id"].get<cata::lua_platform::script_game_id>();
                CHECK( actual.value() == id );
                ++index;
            }
        };
        const auto check_change = [&]( const sol::table &value, bool changed,
        std::initializer_list<const char *> before, std::initializer_list<const char *> after ) {
            CHECK( value["changed"].get<bool>() == changed );
            check_snapshot( value["before"].get<sol::table>(), before );
            check_snapshot( value["after"].get<sol::table>(), after );
        };

        check_change( invoke( "remove_all_direct", arm, burn ), false, {}, {} );
        CHECK( platform_alpha.get_morale_level() == platform_morale_before_direct_remove );

        const sol::table applied = invoke( "add", hand, blister );
        check_change( applied, true, {}, { "thermal_blister" } );
        check_snapshot( invoke( "snapshot", hand ), {} );
        check_snapshot( invoke( "snapshot", arm ), { "thermal_blister" } );
        check_change( invoke( "add_unbounded", hand, blister ), false,
                      { "thermal_blister" }, { "thermal_blister" } );

        platform_alpha.add_effect( effect_incorporeal, 1_minutes );
        REQUIRE( platform_alpha.has_effect( effect_incorporeal ) );
        check_change( invoke( "add_unbounded", hand, burn ), false,
                      { "thermal_blister" }, { "thermal_blister" } );
        platform_alpha.remove_effect( effect_incorporeal );

        check_change( invoke( "add_unbounded", hand, burn ), true,
                      { "thermal_blister" }, { "thermal_burn" } );
        check_change( invoke( "add", hand, blister ), false, { "thermal_burn" }, { "thermal_burn" } );
        check_change( applied, true, {}, { "thermal_blister" } ); // Detached from the later upgrade.

        const int burn_morale = platform_alpha.get_morale_level();
        REQUIRE( burn_morale > 0 );
        check_change( invoke( "remove", hand, burn ), false, {}, {} );
        check_change( invoke( "remove_all_direct", hand, burn ), false, {}, {} );
        check_snapshot( invoke( "snapshot", arm ), { "thermal_burn" } );
        CHECK( platform_alpha.get_morale_level() == burn_morale );
        check_change( invoke( "remove_all_direct", arm, burn ), true, { "thermal_burn" }, {} );
        check_snapshot( invoke( "snapshot", arm ), {} );
        CHECK( platform_alpha.get_morale_level() == 0 );

        check_change( invoke( "add_unbounded", part_id, blister ), true, {}, { "thermal_blister" } );
        check_snapshot( invoke( "snapshot", exact_part_id ), { "thermal_blister" } );
        REQUIRE( platform_alpha.get_morale_level() > 0 );
        check_change( invoke( "remove", exact_part_id, blister ), true, { "thermal_blister" }, {} );
        CHECK( platform_alpha.get_morale_level() == 0 );
        completed = true;
    } );
    sol::protected_function_result registered = ccb["runtime"]["handler"](
                "accept", lua["accept"] );
    REQUIRE( registered.valid() );
    registered = ccb["runtime"]["on"]( "world_ready", "accept" );
    REQUIRE( registered.valid() );
    cata::lua_platform::runtime_world_ready( true );
    REQUIRE( completed );
}

#endif
