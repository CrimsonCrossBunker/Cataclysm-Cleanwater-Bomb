#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <vector>
#include <set>
#include <memory>
#include "units.h"
#include "point.h"
#include "pimpl.h"
#include "item.h"
#include "creature.h"
#include "coordinates.h"
#include "calendar.h"
#include "bonuses.h"
#include <cstddef>
#include <cstdint>
#include <functional>
#include <initializer_list>
#include <string>

#include "cata_catch.h"
#include "avatar.h"
#include "cata_scope_helpers.h"
#include "character_martial_arts.h"
#include "condition.h"
#include "dialogue.h"
#include "dialogue_helpers.h"
#include "debug.h"
#include "effect.h"
#include "effect_source.h"
#include "flexbuffer_json.h"
#include "json_loader.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_handle.h"
#include "lua_platform_martial_arts.h"
#include "lua_platform_runtime.h"
#include "lua_platform_runtime_internal.h"
#include "lua_platform_sol.h"
#include "martialarts.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "monster.h"
#include "player_helpers.h"
#include "skill.h"
#include "translation.h"
#include "type_id.h"

static const efftype_id effect_downed( "downed" );
static const efftype_id effect_martial_grapple( "martial_grapple" );

static const itype_id itype_i_staff( "i_staff" );
static const itype_id itype_test_weapon1( "test_weapon1" );

static const matec_id RAPID( "RAPID" );
static const matec_id lua_cooldown_validation( "lua_cooldown_validation" );
static const matec_id lua_local_strike( "lua_local_strike" );
static const matec_id lua_position_authoring( "lua_position_authoring" );
static const matec_id lua_style_grip( "lua_style_grip" );
static const matec_id tec_grapple_hold( "tec_grapple_hold" );
static const matec_id tec_lua_boxing_cross( "tec_lua_boxing_cross" );
static const matec_id tec_lua_boxing_double_jab( "tec_lua_boxing_double_jab" );
static const matec_id tec_lua_boxing_opening_cross( "tec_lua_boxing_opening_cross" );
static const matec_id tec_lua_muay_clinch_knee( "tec_lua_muay_clinch_knee" );
static const matec_id tec_lua_muay_push_kick( "tec_lua_muay_push_kick" );
static const matec_id tec_lua_staff_long_thrust( "tec_lua_staff_long_thrust" );
static const matec_id tec_rapid_window_break( "tec_rapid_window_break" );
static const matec_id tec_shadow_combination( "tec_shadow_combination" );
static const matec_id tec_weapon_breach( "tec_weapon_breach" );
static const matec_id tech_base_headbutt( "tech_base_headbutt" );
static const matec_id test_active_strike( "test_active_strike" );
static const matec_id test_manual_cooldown_strike( "test_manual_cooldown_strike" );

static const matype_id lua_local_style( "lua_local_style" );
static const matype_id style_brawling( "style_brawling" );
static const matype_id style_judo( "style_judo" );
static const matype_id test_style_ma1( "test_style_ma1" );

static const skill_id skill_unarmed( "unarmed" );

TEST_CASE( "lua_platform_technique_short_description_matches_native_string_mutator",
           "[lua][platform][martial_arts][semantic]" )
{
    REQUIRE( tech_base_headbutt.is_valid() );
    dialogue context;
    const JsonObject input = json_loader::from_string(
                                 R"({"value":{"mutator":"ma_technique_description","matec_id":"tech_base_headbutt"}})" ).get_object();
    const str_or_var legacy = get_str_or_var( input.get_member( "value" ), "value" );
    const std::string expected = legacy.evaluate( context );
    REQUIRE_FALSE( expected.empty() );
    REQUIRE( expected != tech_base_headbutt->get_description() );

    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_value_type_api( lua, services, []() {} );
    const cata::lua_platform::game_handle_runtime_owner_ptr owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime generation{ owner, 1 };
    cata::lua_platform::install_martial_art_api(
    services, [generation]() {
        return generation;
    }, []() {
        return std::size_t( 1 );
    }, []() {}, []() {} );
    sol::protected_function get = services["martial_arts"]["technique_definition"];
    sol::protected_function_result call = get(
            cata::lua_platform::script_game_id( "martial_art_technique", tech_base_headbutt.str() ) );
    REQUIRE( call.valid() );
    sol::table snapshot = call;
    CHECK( snapshot["flavor_description"].get<std::string>() == expected );
    CHECK( snapshot["description"].get<std::string>() == tech_base_headbutt->get_description() );
    CHECK( snapshot["name"].get<std::string>() == tech_base_headbutt->name.translated() );
    CHECK( snapshot["manual_activation"].get<bool>() );
    CHECK( snapshot["cooldown_turns"].get<int>() == 0 );

    call = get( cata::lua_platform::script_game_id( "martial_art_technique",
                "test_manual_cooldown_strike" ) );
    REQUIRE( call.valid() );
    snapshot = call;
    CHECK( snapshot["cooldown_turns"].get<int>() == 10 );

    REQUIRE( RAPID.is_valid() );
    call = get( cata::lua_platform::script_game_id( "martial_art_technique", RAPID.str() ) );
    REQUIRE( call.valid() );
    snapshot = call;
    CHECK( snapshot["manual_activation"].get<bool>() );

    call = get( cata::lua_platform::script_game_id( "martial_art_technique",
                "tec_bojutsu_frontstrike" ) );
    REQUIRE( call.valid() );
    snapshot = call;
    CHECK_FALSE( snapshot["manual_activation"].get<bool>() );

    call = get( cata::lua_platform::script_game_id( "martial_art_technique", "PENETRATE" ) );
    REQUIRE( call.valid() );
    snapshot = call;
    CHECK_FALSE( snapshot["manual_activation"].get<bool>() );
}

TEST_CASE( "lua_platform_technique_cooldown_authoring_validates_ranges",
           "[lua][platform][martial_arts][cooldown][content]" )
{
    namespace platform = cata::lua_platform;
    const bool manual_activation = GENERATE( false, true );
    const std::int64_t cooldown = GENERATE( std::int64_t( -1 ), std::int64_t( 0 ),
                                            std::int64_t( 10 ),
                                            std::int64_t( 86400 ),
                                            std::int64_t( 86400 ) + 1 );
    CAPTURE( manual_activation, cooldown );
    sol::state lua;
    sol::table ccb = lua.create_table();
    const auto runtime = platform::make_runtime( "technique-cooldown", 1, lua );
    const on_out_of_scope cleanup( [runtime]() {
        platform::rollback_runtime_content( runtime );
    } );
    platform::install_runtime_api( runtime, lua, ccb );
    lua["ccb"] = ccb;
    lua["manual_activation"] = manual_activation;
    lua["cooldown"] = cooldown;
    const sol::protected_function_result call = lua.safe_script( R"lua(
local technique = ccb.content.Technique {
    id = "lua_cooldown_validation", name = "Cooldown validation",
    manual_activation = manual_activation, cooldown_turns = cooldown,
}
technique:attack_vector("vector_null")
ccb.content.add(technique)
)lua", sol::script_pass_on_error );
    REQUIRE( call.valid() );
    std::string error;
    const bool valid = platform::validate_runtime( runtime, true, error );
    INFO( error );
    const bool expected = cooldown >= 0 && cooldown <= 86400 &&
                          ( cooldown == 0 || manual_activation );
    CHECK( valid == expected );
    if( valid ) {
        REQUIRE( platform::apply_runtime_content( runtime, error ) );

        REQUIRE( lua_cooldown_validation.is_valid() );
        CHECK( lua_cooldown_validation->cooldown == time_duration::from_turns( cooldown ) );
        platform::rollback_runtime_content( runtime );
        CHECK_FALSE( lua_cooldown_validation.is_valid() );
    } else {
        CHECK_FALSE( error.empty() );
    }
}

TEST_CASE( "lua_platform_technique_cooldown_replacement_restores_native_definition",
           "[lua][platform][martial_arts][cooldown][content]" )
{
    namespace platform = cata::lua_platform;
    const bool explicit_cooldown = GENERATE( false, true );

    REQUIRE( test_manual_cooldown_strike.is_valid() );
    const time_duration original_cooldown = test_manual_cooldown_strike->cooldown;
    REQUIRE( original_cooldown == 10_seconds );
    sol::state lua;
    sol::table ccb = lua.create_table();
    const auto runtime = platform::make_runtime( "technique-cooldown-replacement", 1, lua );
    const on_out_of_scope cleanup( [runtime]() {
        platform::rollback_runtime_content( runtime );
    } );
    platform::install_runtime_api( runtime, lua, ccb );
    lua["ccb"] = ccb;
    if( explicit_cooldown ) {
        lua["cooldown"] = 17;
    }
    const sol::protected_function_result call = lua.safe_script( R"lua(
local technique = ccb.content.Technique {
    id = "test_manual_cooldown_strike", name = "Replacement cooldown",
    manual_activation = true, cooldown_turns = cooldown,
}
technique:attack_vector("vector_null")
ccb.content.replace(technique)
)lua", sol::script_pass_on_error );
    REQUIRE( call.valid() );
    std::string error;
    INFO( error );
    REQUIRE( platform::validate_runtime( runtime, true, error ) );
    REQUIRE( platform::apply_runtime_content( runtime, error ) );
    CHECK( test_manual_cooldown_strike->cooldown == ( explicit_cooldown ? 17_seconds : 0_turns ) );
    platform::rollback_runtime_content( runtime );
    REQUIRE( test_manual_cooldown_strike.is_valid() );
    CHECK( test_manual_cooldown_strike->cooldown == original_cooldown );
}

TEST_CASE( "lua_platform_technique_cooldown_changes_content_fingerprint",
           "[lua][platform][martial_arts][cooldown][content]" )
{
    namespace platform = cata::lua_platform;
    std::string previous_fingerprint;
    for( const int cooldown : { 0, 10 } ) {
        sol::state lua;
        sol::table ccb = lua.create_table();
        const auto runtime = platform::make_runtime( "technique-cooldown-fingerprint", 1, lua );
        const on_out_of_scope cleanup( [runtime]() {
            platform::rollback_runtime_content( runtime );
        } );
        platform::install_runtime_api( runtime, lua, ccb );
        lua["ccb"] = ccb;
        lua["cooldown"] = cooldown;
        const sol::protected_function_result call = lua.safe_script( R"lua(
local technique = ccb.content.Technique {
    id = "lua_cooldown_fingerprint", name = "Cooldown fingerprint",
    manual_activation = true, cooldown_turns = cooldown,
}
technique:attack_vector("vector_null")
ccb.content.add(technique)
)lua", sol::script_pass_on_error );
        REQUIRE( call.valid() );
        std::string error;
        INFO( error );
        REQUIRE( platform::validate_runtime( runtime, true, error ) );
        const std::string fingerprint = platform::runtime_fingerprint( runtime );
        CHECK_FALSE( fingerprint.empty() );
        if( !previous_fingerprint.empty() ) {
            CHECK( fingerprint != previous_fingerprint );
        }
        previous_fingerprint = fingerprint;
    }
}

TEST_CASE( "lua_platform_grapple_authoring_validates_and_rolls_back",
           "[lua][platform][martial_arts][grappling][content]" )
{
    namespace platform = cata::lua_platform;
    const std::string fields = GENERATE( std::string(),
                                         std::string( "grapple_action = 'invalid'," ),
                                         std::string( "manual_activation = false," ),
                                         std::string( "crit_tec = true," ),
                                         std::string( "strictly_unarmed = false," ),
                                         std::string( "reach_ok = true," ),
                                         std::string( "grapple_power = 0," ),
                                         std::string( "grapple_power = 2147483648," ),
                                         std::string( "grapple_stamina = -1," ),
                                         std::string( "grapple_cooldown_turns = 0," ),
                                         std::string( "grapple_cooldown_turns = 2147483648," ),
                                         std::string( "grapple_plan = 'missing'," ) );
    CAPTURE( fields );

    REQUIRE( tec_grapple_hold.is_valid() );
    const ma_technique original = ma_technique( tec_grapple_hold.obj() );
    sol::state lua;
    sol::table ccb = lua.create_table();
    const auto runtime = platform::make_runtime( "grapple-authoring", 1, lua );
    const on_out_of_scope cleanup( [runtime]() {
        platform::rollback_runtime_content( runtime );
    } );
    platform::install_runtime_api( runtime, lua, ccb );
    lua["ccb"] = ccb;
    const sol::protected_function_result call = lua.safe_script( R"lua(
ccb.runtime.handler("plan", function(context) return {allowed = false} end, 1)
local technique = ccb.content.Technique {
    id = "tec_grapple_hold", name = "Lua grip",
    manual_activation = true, unarmed_allowed = true, strictly_unarmed = true,
    grapple_action = "hold", grapple_power = 110, grapple_stamina = 5,
    grapple_cooldown_turns = 2, grapple_plan = "plan",
)lua" + fields + R"lua(
}
technique:attack_vector("vector_punch")
ccb.content.replace(technique)
)lua", sol::script_pass_on_error );
    REQUIRE( call.valid() );
    std::string error;
    const bool valid = platform::validate_runtime( runtime, true, error );
    INFO( error );
    REQUIRE( valid == fields.empty() );
    if( valid ) {
        REQUIRE( platform::apply_runtime_content( runtime, error ) );
        CHECK( tec_grapple_hold->grapple_action == "hold" );
        CHECK( tec_grapple_hold->grapple_power == 110 );
        CHECK( tec_grapple_hold->grapple_stamina == 5 );
        CHECK( tec_grapple_hold->grapple_cooldown == 2_seconds );
        CHECK( tec_grapple_hold->lua_platform_grapple_handler == "plan" );
        platform::rollback_runtime_content( runtime );
        CHECK( tec_grapple_hold->grapple_power == original.grapple_power );
        CHECK( tec_grapple_hold->lua_platform_grapple_handler == original.lua_platform_grapple_handler );
        CHECK( tec_grapple_hold->lua_platform_mod == original.lua_platform_mod );
    }
}

TEST_CASE( "lua_platform_grapple_execution_uses_plan_without_double_charging",
           "[lua][platform][martial_arts][grappling][active_technique]" )
{
    namespace platform = cata::lua_platform;
    const std::string mode = GENERATE( "ok", "reject", "missing_runtime", "exception",
                                       "missing_field", "fractional_cost", "negative_cost", "overflow", "nan_damage",
                                       "non_table", "string_allowed", "string_cost", "zero_duration", "infinite_damage" );
    CAPTURE( mode );
    clear_avatar();
    clear_map();
    avatar &attacker = get_avatar();
    const tripoint_bub_ms origin( 60, 60, 0 );
    attacker.setpos( get_map(), origin );
    attacker.set_all_skills( 5 );
    attacker.remove_weapon();

    attacker.martial_arts_data->add_martialart( style_judo );
    attacker.martial_arts_data->set_style( style_judo );
    attacker.set_moves( 1000 );
    attacker.set_stamina( attacker.get_stamina_max() );
    monster &target = spawn_test_monster( "mon_zombie", origin + tripoint::east );

    const auto previous_runtimes = std::vector( platform::detail::active_runtime_values() );
    sol::state lua;
    sol::table ccb = lua.create_table();
    const auto runtime = platform::make_runtime( "grapple-execution", 1, lua );
    const on_out_of_scope cleanup( [previous_runtimes, runtime]() {
        platform::rollback_runtime_content( runtime );
        platform::discard_runtime( runtime );
        platform::set_active_runtimes( previous_runtimes );
    } );
    platform::install_runtime_api( runtime, lua, ccb );
    lua["ccb"] = ccb;
    lua["mode"] = mode;
    const sol::protected_function_result call = lua.safe_script( R"lua(
calls = 0
ccb.runtime.handler("plan", function(context)
    calls = calls + 1
    payload = context
    local plan = {allowed = true, stamina_cost = 17, move_cost = 123, duration_turns = 7, damage = 0}
    if mode == "reject" then return {allowed = false} end
    if mode == "exception" then return context.missing.field end
    if mode == "non_table" then return true end
    if mode == "string_allowed" then plan.allowed = "true" end
    if mode == "string_cost" then plan.stamina_cost = "17" end
    if mode == "zero_duration" then plan.duration_turns = 0 end
    if mode == "infinite_damage" then plan.damage = 1 / 0 end
    if mode == "missing_field" then plan.move_cost = nil end
    if mode == "fractional_cost" then plan.move_cost = 1.5 end
    if mode == "negative_cost" then plan.stamina_cost = -1 end
    if mode == "overflow" then plan.duration_turns = 2147483648 end
    if mode == "nan_damage" then plan.damage = 0 / 0 end
    return plan
end, 1)
local technique = ccb.content.Technique {
    id = "tec_grapple_hold", name = "Scripted grip",
    manual_activation = true, unarmed_allowed = true, strictly_unarmed = true,
    grapple_action = "hold", grapple_power = 100, grapple_stamina = 5,
    grapple_cooldown_turns = 2, grapple_plan = "plan",
}
technique:attack_vector("vector_punch")
ccb.content.replace(technique)
)lua", sol::script_pass_on_error );
    REQUIRE( call.valid() );
    std::string error;
    INFO( error );
    REQUIRE( platform::validate_runtime( runtime, true, error ) );
    REQUIRE( platform::apply_runtime_content( runtime, error ) );
    platform::set_active_runtimes( { runtime } );
    platform::runtime_world_ready( true );
    if( mode == "missing_runtime" ) {
        platform::set_active_runtimes( {} );
    }
    const int stamina = attacker.get_stamina();
    const int moves = attacker.get_moves();
    const int hitpoints = target.get_hp();

    REQUIRE_FALSE( debug_has_error_been_observed() );
    const bool executed = attacker.use_active_technique( target, tec_grapple_hold );
    const bool expected_diagnostic = mode != "ok" && mode != "reject" && mode != "missing_runtime";
    CHECK( debug_has_error_been_observed() == expected_diagnostic );
    if( expected_diagnostic ) {
        debug_reset_error_observed();
    }
    CHECK( executed == ( mode == "ok" ) );
    CHECK( lua["calls"].get<int>() == ( mode == "missing_runtime" ? 0 : 1 ) );
    CHECK( target.get_hp() == hitpoints );
    if( executed ) {
        CHECK( attacker.get_stamina() == stamina - 17 );
        CHECK( attacker.get_moves() == moves - 123 );
        REQUIRE( target.has_effect( effect_martial_grapple ) );
        CHECK( target.get_effect( effect_martial_grapple ).get_duration() == 7_seconds );
        CHECK( attacker.has_effect( tec_grapple_hold->grapple_cooldown_effect() ) );
        sol::table payload = lua["payload"];
        CHECK( payload["technique_id"].get<std::string>() == tec_grapple_hold.str() );
        CHECK( payload["strength"].get<int>() == attacker.get_str() );
        CHECK( payload["unarmed_skill"].get<double>() == Approx( 5.0 ) );
        CHECK( payload["target_weight_kg"].get<double>() > 0.0 );
    } else {
        CHECK( attacker.get_stamina() == stamina );
        CHECK( attacker.get_moves() == moves );
        CHECK_FALSE( target.has_effect( effect_martial_grapple ) );
        CHECK_FALSE( attacker.has_effect( tec_grapple_hold->grapple_cooldown_effect() ) );
    }
}

TEST_CASE( "lua_platform_technique_style_additions_preserve_and_rollback_native_styles",
           "[lua][platform][martial_arts][content]" )
{
    namespace platform = cata::lua_platform;
    const bool invalid_style = GENERATE( false, true );

    const martialart original = martialart( *style_brawling );
    sol::state lua;
    sol::table ccb = lua.create_table();
    const auto runtime = platform::make_runtime( "technique-styles", 1, lua );
    const on_out_of_scope cleanup( [runtime]() {
        platform::rollback_runtime_content( runtime );
    } );
    platform::install_runtime_api( runtime, lua, ccb );
    lua["ccb"] = ccb;
    lua["style_id"] = invalid_style ? "missing_lua_style" : style_brawling.str();
    const sol::protected_function_result call = lua.safe_script( R"lua(
local technique = ccb.content.Technique { id = "lua_style_grip", name = "Style grip" }
technique:attack_vector("vector_punch")
technique:style(style_id):style(style_id)
ccb.content.add(technique)
local local_style = ccb.content.MartialArt { id = "lua_local_style", name = "Local style" }
ccb.content.add(local_style)
local second = ccb.content.Technique { id = "lua_local_strike", name = "Local strike" }
second:attack_vector("vector_punch"):style("lua_local_style")
ccb.content.add(second)
)lua", sol::script_pass_on_error );
    REQUIRE( call.valid() );
    std::string error;
    const bool valid = platform::validate_runtime( runtime, true, error );
    INFO( error );
    REQUIRE( valid == !invalid_style );
    if( !valid ) {
        CHECK( style_brawling->techniques == original.techniques );
        return;
    }
    REQUIRE( platform::apply_runtime_content( runtime, error ) );
    CHECK( style_brawling->techniques.size() == original.techniques.size() + 1 );
    CHECK( style_brawling->techniques.count( lua_style_grip ) == 1 );
    CHECK( style_brawling->static_buffs == original.static_buffs );
    CHECK( style_brawling->onpause_buffs == original.onpause_buffs );
    CHECK( style_brawling->allow_all_weapons == original.allow_all_weapons );
    CHECK( lua_local_style->techniques.count( lua_local_strike ) == 1 );
    platform::rollback_runtime_content( runtime );
    CHECK( style_brawling->techniques == original.techniques );
    CHECK( style_brawling->static_buffs == original.static_buffs );
    CHECK_FALSE( lua_style_grip.is_valid() );
    CHECK_FALSE( lua_local_style.is_valid() );
}

TEST_CASE( "lua_platform_target_policy_rechecks_non_hostile_targets_before_costs",
           "[lua][platform][martial_arts][active_technique]" )
{
    namespace platform = cata::lua_platform;
    const std::string mode = GENERATE( "allow", "deny", "changed", "missing_runtime", "exception", "non_boolean" );
    CAPTURE( mode );
    clear_avatar();
    clear_map();
    avatar &attacker = get_avatar();
    const tripoint_bub_ms origin( 60, 60, 0 );
    attacker.setpos( get_map(), origin );
    attacker.set_wielded_item( item( itype_test_weapon1 ) );
    attacker.set_all_skills( 5 );

    attacker.martial_arts_data->add_martialart( test_style_ma1 );
    attacker.martial_arts_data->set_style( test_style_ma1 );
    attacker.set_moves( 1000 );
    attacker.set_stamina( attacker.get_stamina_max() );
    monster &target = spawn_test_monster( "mon_zombie", origin + tripoint::east );
    target.friendly = -1;
    REQUIRE( target.attitude_to( attacker ) != Creature::Attitude::HOSTILE );
    const auto previous_runtimes = std::vector( platform::detail::active_runtime_values() );
    sol::state lua;
    sol::table ccb = lua.create_table();
    const auto runtime = platform::make_runtime( "technique-targets", 1, lua );
    const on_out_of_scope cleanup( [previous_runtimes, runtime]() {
        platform::rollback_runtime_content( runtime );
        platform::discard_runtime( runtime );
        platform::set_active_runtimes( previous_runtimes );
    } );
    platform::install_runtime_api( runtime, lua, ccb );
    lua["ccb"] = ccb;
    lua["mode"] = mode;
    const sol::protected_function_result call = lua.safe_script( R"lua(
target_calls = 0
reject = false
ccb.runtime.handler("available", function(context)
    if context.phase ~= "target" then return true end
    target_calls = target_calls + 1
    selected = context.target
    if mode == "exception" then return context.missing.field end
    if mode == "non_boolean" then return 1 end
    return not reject and mode ~= "deny" and selected.alive and selected.adjacent
end, 1)
local technique = ccb.content.Technique {
    id = "test_active_strike", name = "Target policy strike",
    manual_activation = true, melee_allowed = true, active_when = "available",
}
technique:attack_vector("vector_foot_sole")
ccb.content.replace(technique)
)lua", sol::script_pass_on_error );
    REQUIRE( call.valid() );
    std::string error;
    REQUIRE( platform::validate_runtime( runtime, true, error ) );
    REQUIRE( platform::apply_runtime_content( runtime, error ) );
    platform::set_active_runtimes( { runtime } );
    platform::runtime_world_ready( true );

    if( mode == "changed" ) {
        REQUIRE( test_active_strike->activation_allowed( attacker, "target", &target ) );
        lua["reject"] = true;
    }
    if( mode == "missing_runtime" ) {
        platform::set_active_runtimes( {} );
    }
    const int stamina = attacker.get_stamina();
    const int moves = attacker.get_moves();
    const int hitpoints = target.get_hp();
    REQUIRE_FALSE( debug_has_error_been_observed() );
    const bool executed = attacker.use_active_technique( target, test_active_strike );
    const bool diagnostic = mode == "exception" || mode == "non_boolean";
    CHECK( debug_has_error_been_observed() == diagnostic );
    if( diagnostic ) {
        debug_reset_error_observed();
    }
    CHECK( executed == ( mode == "allow" ) );
    if( mode != "missing_runtime" ) {
        CHECK( lua["target_calls"].get<int>() == ( mode == "changed" ? 2 : 1 ) );
        sol::table snapshot = lua["selected"];
        CHECK( snapshot["kind"].get<std::string>() == "monster" );
        CHECK_FALSE( snapshot["hostile"].get<bool>() );
        CHECK( snapshot["adjacent"].get<bool>() );
        CHECK_FALSE( snapshot["gripped"].get<bool>() );
        CHECK_FALSE( snapshot["own_grip"].get<bool>() );
        CHECK( snapshot["weight_kg"].get<double>() > 0 );
    }
    if( executed ) {
        CHECK( attacker.get_stamina() < stamina );
        CHECK( attacker.get_moves() < moves );
    } else {
        CHECK( attacker.get_stamina() == stamina );
        CHECK( attacker.get_moves() == moves );
        CHECK( target.get_hp() == hitpoints );
    }
}

TEST_CASE( "lua_technique_position_and_bonus_authoring_validates_and_rolls_back",
           "[lua][platform][martial_arts][content][position_technique]" )
{
    namespace platform = cata::lua_platform;
    const std::string mode = GENERATE( "valid", "damage_zero", "damage_nan", "damage_unknown",
                                       "move_negative", "accuracy_overflow", "category_unknown",
                                       "unregistered", "on_apply", "reach", "knockdown", "reserved" );
    CAPTURE( mode );
    sol::state lua;
    sol::table ccb = lua.create_table();
    const auto runtime = platform::make_runtime( "technique-position-authoring", 1, lua );
    const on_out_of_scope cleanup( [runtime]() {
        platform::rollback_runtime_content( runtime );
    } );
    platform::install_runtime_api( runtime, lua, ccb );
    lua["ccb"] = ccb;
    lua["mode"] = mode;
    const sol::protected_function_result call = lua.safe_script( R"lua(
ccb.runtime.handler("position", function() return { allowed = false } end, 1)
local technique = ccb.content.Technique {
    id = "lua_position_authoring", name = "Position authoring", manual_activation = true,
    melee_allowed = true, position_plan = mode == "unregistered" and "missing" or "position",
    reach_ok = mode == "reach", down_dur = mode == "knockdown" and 1 or 0,
}
technique:attack_vector("vector_null"):weapon_category(mode == "category_unknown" and "missing" or "MACES")
    :damage_multiplier(mode == "damage_unknown" and "missing" or "bash",
        mode == "damage_zero" and 0 or mode == "damage_nan" and 0/0 or 1.4)
    :move_cost_multiplier(mode == "move_negative" and -1 or 1.3)
    :accuracy_bonus(mode == "accuracy_overflow" and 21 or -1)
if mode == "on_apply" then technique:on_apply("position") end
if mode == "reserved" then technique:flag("LUA_POSITION_TECHNIQUE") end
ccb.content.add(technique)
)lua", sol::script_pass_on_error );
    const bool bad_number = mode == "damage_zero" || mode == "damage_nan" ||
                            mode == "move_negative" || mode == "accuracy_overflow";
    REQUIRE( call.valid() == !bad_number );
    if( bad_number ) {
        return;
    }
    std::string error;
    const bool valid = platform::validate_runtime( runtime, true, error );
    INFO( error );
    REQUIRE( valid == ( mode == "valid" ) );

    CHECK_FALSE( lua_position_authoring.is_valid() );
    if( valid ) {
        REQUIRE( platform::apply_runtime_content( runtime, error ) );
        REQUIRE( lua_position_authoring.is_valid() );
        CHECK( lua_position_authoring->targets_position() );
        CHECK( lua_position_authoring->move_cost_multiplier( get_avatar() ) == Approx( 1.3 ) );
        CHECK( lua_position_authoring->damage_multiplier( get_avatar(), damage_type_id( "bash" ) ) == Approx( 1.4 ) );
        CHECK( lua_position_authoring->bonuses.get_flat( get_avatar(), affected_stat::HIT ) == Approx( -1 ) );
        platform::rollback_runtime_content( runtime );
        CHECK_FALSE( lua_position_authoring.is_valid() );
    }
}

TEST_CASE( "lua_technique_position_and_bonuses_change_content_fingerprint",
           "[lua][platform][martial_arts][content][position_technique]" )
{
    namespace platform = cata::lua_platform;
    std::string baseline;
    for( const std::string mode : { "baseline", "plan", "category", "damage", "moves", "accuracy" } ) {
        CAPTURE( mode );
        sol::state lua;
        sol::table ccb = lua.create_table();
        const auto runtime = platform::make_runtime( "technique-position-fingerprint", 1, lua );
        const on_out_of_scope cleanup( [runtime]() {
            platform::rollback_runtime_content( runtime );
        } );
        platform::install_runtime_api( runtime, lua, ccb );
        lua["ccb"] = ccb;
        lua["mode"] = mode;
        const sol::protected_function_result call = lua.safe_script( R"lua(
ccb.runtime.handler("position", function() return { allowed = false } end, 1)
ccb.runtime.handler("other", function() return { allowed = false } end, 1)
local technique = ccb.content.Technique {
    id = "lua_position_fingerprint", name = "Position fingerprint", manual_activation = true,
    melee_allowed = true, position_plan = mode == "plan" and "other" or "position",
}
technique:attack_vector("vector_null")
    :weapon_category(mode == "category" and "BATONS" or "MACES")
    :damage_multiplier("bash", mode == "damage" and 1.5 or 1.4)
    :move_cost_multiplier(mode == "moves" and 1.2 or 1.3)
    :accuracy_bonus(mode == "accuracy" and 0 or -1)
ccb.content.add(technique)
)lua", sol::script_pass_on_error );
        REQUIRE( call.valid() );
        std::string error;
        REQUIRE( platform::validate_runtime( runtime, true, error ) );
        const std::string fingerprint = platform::runtime_fingerprint( runtime );
        CHECK_FALSE( fingerprint.empty() );
        if( mode == "baseline" ) {
            baseline = fingerprint;
        } else {
            CHECK( fingerprint != baseline );
        }
    }
}

TEST_CASE( "lua_core_position_techniques_execute_real_plans",
           "[lua][platform][martial_arts][position_technique]" )
{
    clear_avatar();
    clear_map();
    cata::lua_platform::runtime_world_ready( true );
    avatar &attacker = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms origin( 60, 60, 0 );
    const tripoint_bub_ms position = origin + tripoint::east;
    attacker.setpos( here, origin );
    attacker.set_all_skills( 5 );

    attacker.martial_arts_data->add_martialart( style_brawling );
    attacker.martial_arts_data->set_style( style_brawling );
    attacker.set_moves( 1000 );
    attacker.set_stamina( attacker.get_stamina_max() );

    REQUIRE( tec_rapid_window_break.is_valid() );
    REQUIRE( tec_shadow_combination.is_valid() );
    REQUIRE( tec_weapon_breach.is_valid() );
    REQUIRE( tec_rapid_window_break->targets_position() );
    SECTION( "ordinary_window_uses_native_bashing" ) {
        here.ter_set( position, ter_str_id( "t_window_domestic" ) );
        REQUIRE( attacker.can_use_active_technique_at( position, tec_rapid_window_break ) );
        const int stamina = attacker.get_stamina();
        REQUIRE( attacker.use_active_technique( position, tec_rapid_window_break ) );
        CHECK( here.ter( position ) != ter_str_id( "t_window_domestic" ) );
        CHECK( attacker.get_stamina() == stamina - 110 );
        CHECK( attacker.get_moves() == 930 );
        CHECK( attacker.technique_cooldown_remaining( tec_rapid_window_break ) == 3_turns );
    }
    SECTION( "reinforced_glass_is_not_force_destroyed" ) {
        here.ter_set( position, ter_str_id( "t_reinforced_glass" ) );
        const ter_id before = here.ter( position );
        if( attacker.can_use_active_technique_at( position, tec_rapid_window_break ) ) {
            REQUIRE( attacker.use_active_technique( position, tec_rapid_window_break ) );
        } else {
            CHECK_FALSE( attacker.use_active_technique( position, tec_rapid_window_break ) );
            CHECK( attacker.get_moves() == 1000 );
        }
        CHECK( here.ter( position ) == before );
    }
    SECTION( "empty_space_consumes_resources_but_not_terrain_or_experience" ) {
        here.ter_set( position, ter_str_id( "t_pavement" ) );
        const ter_id before = here.ter( position );
        const int experience = attacker.get_skill_level_object( skill_unarmed ).exercise();
        const int stamina = attacker.get_stamina();
        REQUIRE( attacker.can_use_active_technique_at( position, tec_shadow_combination ) );
        CHECK( attacker.get_moves() == 1000 );
        CHECK( attacker.get_stamina() == stamina );
        REQUIRE( attacker.use_active_technique( position, tec_shadow_combination ) );
        CHECK( attacker.get_moves() == 915 );
        CHECK( attacker.get_stamina() == stamina - 70 );
        CHECK( here.ter( position ) == before );
        CHECK( attacker.get_skill_level_object( skill_unarmed ).exercise() == experience );
    }
    SECTION( "wrong_terrain_and_weapon_fail_without_cost" ) {
        here.ter_set( position, ter_str_id( "t_pavement" ) );
        CHECK_FALSE( attacker.use_active_technique( position, tec_rapid_window_break ) );
        CHECK_FALSE( attacker.use_active_technique( position, tec_weapon_breach ) );
        CHECK( attacker.get_moves() == 1000 );
    }
    SECTION( "weapon_breach_requires_the_correct_weapon_and_charges_once" ) {
        attacker.set_wielded_item( item( itype_i_staff ) );
        here.ter_set( position, ter_str_id( "t_window_domestic" ) );
        const int stamina = attacker.get_stamina();
        REQUIRE( attacker.can_use_active_technique_at( position, tec_weapon_breach ) );
        CHECK( attacker.get_stamina() == stamina );
        REQUIRE( attacker.use_active_technique( position, tec_weapon_breach ) );
        CHECK( attacker.get_stamina() == stamina - 220 );
        CHECK( attacker.get_moves() == 850 );
        CHECK( here.ter( position ) != ter_str_id( "t_window_domestic" ) );
        CHECK_FALSE( attacker.use_active_technique( position, tec_weapon_breach ) );
        CHECK( attacker.get_moves() == 850 );
    }
    SECTION( "vehicle_positions_are_excluded" ) {
        REQUIRE( here.add_vehicle( vproto_id( "bicycle" ), position, 0_degrees ) );
        REQUIRE( here.veh_at( position ) );
        CHECK_FALSE( attacker.can_use_active_technique_at( position, tec_shadow_combination ) );
        CHECK_FALSE( attacker.use_active_technique( position, tec_shadow_combination ) );
        CHECK( attacker.get_moves() == 1000 );
    }
    SECTION( "occupied_positions_and_creature_overload_are_rejected" ) {
        monster &target = spawn_test_monster( "mon_zombie", position );
        target.friendly = -1;
        CHECK_FALSE( attacker.can_use_active_technique_at( position, tec_shadow_combination ) );
        CHECK_FALSE( attacker.use_active_technique( position, tec_shadow_combination ) );
        CHECK_FALSE( attacker.use_active_technique( target, tec_shadow_combination ) );
        CHECK_FALSE( attacker.evaluate_technique( tec_shadow_combination, target, attacker.used_weapon(),
                     false, false, false, false ) );
        CHECK( attacker.get_moves() == 1000 );
    }
}

TEST_CASE( "lua_core_combat_library_has_distinct_bonuses_and_target_rules",
           "[lua][platform][martial_arts][technique_library]" )
{
    clear_avatar();
    clear_map();
    cata::lua_platform::runtime_world_ready( true );
    avatar &attacker = get_avatar();
    attacker.setpos( get_map(), tripoint_bub_ms( 60, 60, 0 ) );
    attacker.set_all_skills( 5 );
    attacker.set_stamina( attacker.get_stamina_max() );

    REQUIRE( tec_lua_boxing_double_jab.is_valid() );
    REQUIRE( tec_lua_boxing_cross.is_valid() );
    REQUIRE( tec_lua_boxing_opening_cross.is_valid() );
    REQUIRE( tec_lua_muay_clinch_knee.is_valid() );
    REQUIRE( tec_lua_staff_long_thrust.is_valid() );
    int library_count = 0;
    for( const ma_technique &technique : ma_technique::get_all() ) {
        if( technique.id.str().find( "tec_lua_" ) != 0 ) {
            continue;
        }
        CAPTURE( technique.id.str() );
        ++library_count;
        CHECK( technique.lua_platform_mod == "ccb" );
        CHECK_FALSE( technique.lua_platform_condition_handler.empty() );
        CHECK_FALSE( technique.attack_vectors.empty() );
        CHECK_FALSE( technique.reqs.min_skill.empty() );
        CHECK( technique.manual_activation != technique.crit_tec );
    }
    CHECK( library_count == 26 );
    CHECK( tec_lua_boxing_double_jab->repeat_min == 2 );
    CHECK( tec_lua_boxing_double_jab->repeat_max == 2 );
    CHECK( tec_lua_boxing_double_jab->damage_multiplier( attacker, damage_type_id( "bash" ) ) == Approx( 0.65 ) );
    CHECK( tec_lua_boxing_cross->damage_multiplier( attacker, damage_type_id( "bash" ) ) == Approx( 1.3 ) );
    CHECK( tec_lua_boxing_double_jab->move_cost_multiplier( attacker ) < tec_lua_boxing_cross->move_cost_multiplier( attacker ) );
    CHECK( tec_lua_boxing_double_jab->bonuses.get_flat( attacker, affected_stat::HIT ) == Approx( 1 ) );
    CHECK( tec_lua_staff_long_thrust->reqs.weapon_categories_allowed == std::vector<weapon_category_id> {
               weapon_category_id( "QUARTERSTAVES" )
           } );
    CHECK( tec_lua_boxing_opening_cross->crit_tec );
    CHECK_FALSE( tec_lua_boxing_opening_cross->can_activate() );
    monster &target = spawn_test_monster( "mon_zombie", attacker.pos_bub() + tripoint::east );
    target.friendly = -1;
    CHECK( tec_lua_boxing_double_jab->activation_allowed( attacker, "target", &target ) );
    CHECK_FALSE( tec_lua_muay_clinch_knee->activation_allowed( attacker, "target", &target ) );
    target.add_effect( effect_source( &attacker ), effect_martial_grapple, 5_turns );
    CHECK( tec_lua_muay_clinch_knee->activation_allowed( attacker, "target", &target ) );

    REQUIRE( tec_lua_muay_push_kick.is_valid() );
    CHECK( tec_lua_muay_push_kick->activation_allowed( attacker, "target", &target ) );
    target.add_effect( effect_downed, 1_turns );
    CHECK_FALSE( tec_lua_muay_push_kick->activation_allowed( attacker, "target", &target ) );
    monster &flying = spawn_test_monster( "mon_manhack", attacker.pos_bub() + tripoint::west );
    CHECK_FALSE( tec_lua_muay_push_kick->activation_allowed( attacker, "target", &flying ) );
    monster &large = spawn_test_monster( "mon_zombie_hulk", attacker.pos_bub() + tripoint::north );
    CHECK_FALSE( tec_lua_muay_push_kick->activation_allowed( attacker, "target", &large ) );

    attacker.martial_arts_data->add_martialart( style_brawling );
    attacker.martial_arts_data->set_style( style_brawling );
    CHECK_FALSE( tec_lua_staff_long_thrust->is_valid_character( attacker ) );
    attacker.set_wielded_item( item( itype_i_staff ) );
    CHECK( tec_lua_staff_long_thrust->is_valid_character( attacker ) );
    attacker.set_wielded_item( item( itype_test_weapon1 ) );
    CHECK_FALSE( tec_lua_staff_long_thrust->is_valid_character( attacker ) );
    attacker.remove_weapon();
    CHECK( attacker.evaluate_technique( tec_lua_boxing_opening_cross, target, attacker.used_weapon(),
                                        true, false, false, false ) );
    CHECK_FALSE( attacker.evaluate_technique( tec_lua_boxing_opening_cross, target, attacker.used_weapon(),
                 false, false, false, false ) );
    CHECK_FALSE( attacker.evaluate_technique( tec_lua_boxing_opening_cross, target, attacker.used_weapon(),
                 true, false, false, true ) );
    attacker.set_stamina( 0 );
    CHECK_FALSE( tec_lua_boxing_double_jab->activation_allowed( attacker, "target", &target ) );
    CHECK_FALSE( attacker.evaluate_technique( tec_lua_boxing_opening_cross, target, attacker.used_weapon(),
                 true, false, false, false ) );
}

TEST_CASE( "lua_position_plan_rejects_invalid_results_without_native_costs",
           "[lua][platform][martial_arts][position_technique]" )
{
    namespace platform = cata::lua_platform;
    const std::string mode = GENERATE( "allow", "deny", "exception", "missing", "boolean",
                                       "fraction", "negative", "overflow", "nan", "metatable", "zero_moves",
                                       "insufficient", "missing_runtime", "occupied", "self", "range", "zlevel", "changed" );
    CAPTURE( mode );
    clear_avatar();
    clear_map();
    avatar &attacker = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms origin( 60, 60, 0 );
    attacker.setpos( here, origin );
    attacker.set_wielded_item( item( itype_test_weapon1 ) );
    attacker.set_all_skills( 5 );

    attacker.martial_arts_data->add_martialart( test_style_ma1 );
    attacker.martial_arts_data->set_style( test_style_ma1 );
    attacker.set_moves( 1000 );
    attacker.set_stamina( mode == "insufficient" ? 1 : attacker.get_stamina_max() );
    const auto previous_runtimes = std::vector( platform::detail::active_runtime_values() );
    sol::state lua;
    sol::table ccb = lua.create_table();
    const auto runtime = platform::make_runtime( "technique-position", 1, lua );
    lua.open_libraries( sol::lib::base );
    const on_out_of_scope cleanup( [previous_runtimes, runtime]() {
        platform::rollback_runtime_content( runtime );
        platform::discard_runtime( runtime );
        platform::set_active_runtimes( previous_runtimes );
    } );
    platform::install_runtime_api( runtime, lua, ccb );
    lua["ccb"] = ccb;
    lua["mode"] = mode;
    const sol::protected_function_result call = lua.safe_script( R"lua(
ccb.runtime.handler("position", function(context)
    last_phase = context.phase
    if mode == "exception" then return context.missing.field end
    if mode == "boolean" then return true end
    if mode == "deny" then return { allowed = false } end
    if mode == "changed" and context.phase == "execute" then return { allowed = false } end
    local plan = { allowed = true, stamina_cost = 80, move_cost = 90, bash_power = 0 }
    if mode == "missing" then plan.bash_power = nil end
    if mode == "fraction" then plan.stamina_cost = 1.5 end
    if mode == "negative" then plan.bash_power = -1 end
    if mode == "overflow" then plan.move_cost = 1000001 end
    if mode == "nan" then plan.bash_power = 0/0 end
    if mode == "zero_moves" then plan.move_cost = 0 end
    if mode == "metatable" then
        return setmetatable({}, { __index = plan })
    end
    return plan
end, 1)
local technique = ccb.content.Technique {
    id = "test_active_strike", name = "Position test", manual_activation = true,
    melee_allowed = true, position_plan = "position", cooldown_turns = 3,
}
technique:attack_vector("vector_foot_sole")
ccb.content.replace(technique)
)lua", sol::script_pass_on_error );
    REQUIRE( call.valid() );
    std::string error;
    REQUIRE( platform::validate_runtime( runtime, true, error ) );
    REQUIRE( platform::apply_runtime_content( runtime, error ) );
    platform::set_active_runtimes( { runtime } );
    platform::runtime_world_ready( true );

    tripoint_bub_ms position = origin + tripoint::east;
    if( mode == "missing_runtime" ) {
        platform::set_active_runtimes( {} );
    } else if( mode == "occupied" ) {
        monster &target = spawn_test_monster( "mon_zombie", position );
        target.friendly = -1;
        CHECK_FALSE( attacker.use_active_technique( target, test_active_strike ) );
    } else if( mode == "self" ) {
        position = origin;
    } else if( mode == "range" ) {
        position = origin + tripoint( 2, 0, 0 );
    } else if( mode == "zlevel" ) {
        position = origin + tripoint( 1, 0, 1 );
    }
    const int stamina = attacker.get_stamina();
    const int moves = attacker.get_moves();
    const ter_id terrain = here.ter( position );
    if( mode == "changed" ) {
        REQUIRE( attacker.can_use_active_technique_at( position, test_active_strike ) );
        CHECK( lua["last_phase"].get<std::string>() == "target" );
        CHECK( attacker.get_moves() == moves );
        CHECK( attacker.get_stamina() == stamina );
    }
    REQUIRE_FALSE( debug_has_error_been_observed() );
    const bool executed = attacker.use_active_technique( position, test_active_strike );
    const bool diagnostic = mode == "exception" || mode == "boolean" || mode == "missing" ||
                            mode == "fraction" || mode == "negative" || mode == "overflow" ||
                            mode == "nan" || mode == "metatable" || mode == "zero_moves";
    CHECK( debug_has_error_been_observed() == diagnostic );
    if( diagnostic ) {
        debug_reset_error_observed();
    }
    CHECK( executed == ( mode == "allow" ) );
    CHECK( attacker.get_stamina() == stamina - ( executed ? 80 : 0 ) );
    CHECK( attacker.get_moves() == moves - ( executed ? 90 : 0 ) );
    CHECK( here.ter( position ) == terrain );
    CHECK( attacker.technique_cooldown_remaining( test_active_strike ) == ( executed ? 3_turns : 0_turns ) );
    if( executed ) {
        CHECK( lua["last_phase"].get<std::string>() == "execute" );
        CHECK_FALSE( attacker.use_active_technique( position, test_active_strike ) );
        CHECK( attacker.get_moves() == moves - 90 );
    }
}

#endif
