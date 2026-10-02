#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <cstdint>
#include <memory>
#include <sstream>
#include <string>
#include <vector>

#include "avatar.h"
#include "bionics.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "character_id.h"
#include "dialogue.h"
#include "dialogue_helpers.h"
#include "item.h"
#include "item_location.h"
#include "json_loader.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_handle.h"
#include "lua_platform_runtime.h"
#include "lua_platform_runtime_internal.h"
#include "lua_platform_sol.h"
#include "magic.h"
#include "mutation.h"
#include "npctalk.h"
#include "recipe.h"
#include "recipe_dictionary.h"
#include "rng.h"
#include "talker.h"
#include "type_id.h"
#include "units.h"

namespace cata::lua_platform
{
class runtime;
} // namespace cata::lua_platform

namespace
{

std::string roll_remainder_effect_json( const std::string &kind,
                                        const std::vector<std::string> &ids )
{
    std::ostringstream json;
    json << R"({"u_roll_remainder":[)";
    for( std::size_t index = 0; index < ids.size(); ++index ) {
        if( index > 0 ) {
            json << ',';
        }
        json << '"' << ids[index] << '"';
    }
    json << R"(],"type":")" << kind << R"("})";
    return json.str();
}

void run_native_roll_remainder( Character &character, const std::string &kind,
                                const std::vector<std::string> &ids )
{
    talk_effect_t effect;
    effect.parse_sub_effect( json_loader::from_string(
                                 roll_remainder_effect_json( kind, ids ) ).get_object(),
                             "lua_platform_progression_semantics" );
    dialogue context( get_talker_for( character ), nullptr );
    for( const talk_effect_fun_t &operation : effect.effects ) {
        operation( context );
    }
}

void prepare_book_recipe_availability( Character &character )
{
    const item_location book = character.i_add( item( itype_id( "brewing_cookbook" ) ) );
    character.identify( *book );
    character.set_skill_level( skill_id( "cooking" ), 3 );
    character.set_knowledge_level( skill_id( "cooking" ), 3 );
    character.invalidate_crafting_inventory();
}

} // namespace

TEST_CASE( "lua_platform_progression_grant_random_missing_matches_native_roll_remainder",
           "[lua][platform][progression][semantic]" )
{
    using namespace cata::lua_platform;
    clear_active_runtimes();
    const cata_default_random_engine saved_rng = rng_get_engine(); // NOLINT(cata-determinism)
    const on_out_of_scope restore_rng( [saved_rng]() {
        rng_get_engine() = saved_rng;
    } );

    avatar native_actor;
    avatar platform_actor;
    native_actor.normalize();
    platform_actor.normalize();
    native_actor.setID( character_id( 6401 ), true );
    platform_actor.setID( character_id( 6402 ), true );
    native_actor.set_mutation( trait_id( "QUICK" ) );
    platform_actor.set_mutation( trait_id( "QUICK" ) );
    native_actor.set_max_power_level( 10_kJ );
    platform_actor.set_max_power_level( 10_kJ );
    prepare_book_recipe_availability( native_actor );
    prepare_book_recipe_availability( platform_actor );

    const recipe_id book_available_recipe( "brew_mead" );
    REQUIRE( book_available_recipe.is_valid() );
    // Character::has_recipe includes book availability, but the talker method
    // used by f_roll_remainder reports only recipes already learned.
    REQUIRE_FALSE( native_actor.knows_recipe( &book_available_recipe.obj() ) );
    REQUIRE( native_actor.has_recipe( &book_available_recipe.obj() ) );
    REQUIRE_FALSE( get_talker_for( native_actor )->has_recipe( book_available_recipe ) );
    REQUIRE_FALSE( platform_actor.knows_recipe( &book_available_recipe.obj() ) );
    REQUIRE( platform_actor.has_recipe( &book_available_recipe.obj() ) );
    REQUIRE_FALSE( get_talker_for( platform_actor )->has_recipe( book_available_recipe ) );

    std::vector<std::string> weighted_mutation_ids = { "QUICK" };
    weighted_mutation_ids.insert( weighted_mutation_ids.end(), 31, "FELINE_EARS" );
    weighted_mutation_ids.insert( weighted_mutation_ids.end(), 32, "SNAIL_TRAIL" );
    REQUIRE( weighted_mutation_ids.size() == 64 );

    constexpr unsigned int seed = 84621;
    rng_set_engine_seed( seed );
    run_native_roll_remainder( native_actor, "mutation", weighted_mutation_ids );
    const bool native_has_feline_ears = native_actor.has_trait( trait_id( "FELINE_EARS" ) );
    const bool native_has_snail_trail = native_actor.has_trait( trait_id( "SNAIL_TRAIL" ) );
    REQUIRE( native_has_feline_ears != native_has_snail_trail );
    const std::string native_mutation_id = native_has_feline_ears ? "FELINE_EARS" : "SNAIL_TRAIL";
    const int native_mutation_following_draw = rng( -100, 100 );

    rng_set_engine_seed( seed );
    run_native_roll_remainder( native_actor, "mutation", { "QUICK" } );
    const int native_no_missing_following_draw = rng( -100, 100 );

    rng_set_engine_seed( seed );
    run_native_roll_remainder( native_actor, "spell", { "test_spell_pew" } );
    REQUIRE( get_talker_for( native_actor )->get_spell_level( spell_id( "test_spell_pew" ) ) == 1 );
    const int native_spell_following_draw = rng( -100, 100 );

    rng_set_engine_seed( seed );
    run_native_roll_remainder( native_actor, "bionic", { "bio_batteries" } );
    REQUIRE( native_actor.has_bionic( bionic_id( "bio_batteries" ) ) );
    const int native_bionic_following_draw = rng( -100, 100 );

    rng_set_engine_seed( seed );
    run_native_roll_remainder( native_actor, "recipe", { "brew_mead" } );
    REQUIRE( native_actor.knows_recipe( &book_available_recipe.obj() ) );
    REQUIRE( get_talker_for( native_actor )->has_recipe( book_available_recipe ) );
    const int native_book_recipe_following_draw = rng( -100, 100 );

    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::math, sol::lib::table );
    sol::table ccb = lua.create_table();
    const std::shared_ptr<runtime> owner = make_runtime( "progression_semantics", 6403, lua );
    const on_out_of_scope cleanup( []() {
        clear_active_runtimes();
    } );
    install_runtime_api( owner, lua, ccb );
    set_active_runtimes( { owner } );
    lua["ccb"] = ccb;
    lua["native_seed"] = seed;
    lua["mutation_candidates"] = lua.create_table( weighted_mutation_ids.size(), 0 );
    sol::table mutation_candidates = lua["mutation_candidates"];
    for( std::size_t index = 0; index < weighted_mutation_ids.size(); ++index ) {
        mutation_candidates[index + 1] = weighted_mutation_ids[index];
    }
    lua.set_function( "seed_native_rng", []( const unsigned int selected_seed ) {
        rng_set_engine_seed( selected_seed );
    } );
    lua.set_function( "make_actor_handle", [&]() {
        return game_handle::from_creature(
                   platform_actor,
        { "avatar", platform_actor.getID().get_value(), 0, 0, 0, {} },
        cata::lua_platform::detail::runtime_handle_identity( owner ), runtime_world_generation() );
    } );

    const sol::protected_function_result installed = lua.safe_script( R"(
local progression = ccb.services.progression
local random = ccb.services.random
local function typed_ids(kind, values)
    local result = {}
    for index, value in ipairs(values) do
        result[index] = ccb.services.types.id(kind, value)
    end
    return result
end
ccb.runtime.handler("check_progression", function()
local actor = make_actor_handle()
local function grant(kind, values)
    local result = progression.grant_random_missing(actor, kind, typed_ids(kind, values))
    assert(result.ok, result.error and result.error.message or "progression grant failed")
    return result
end
local too_many_ids = {}
for index = 1, 65 do
    too_many_ids[index] = ccb.services.types.id("mutation", "QUICK")
end
untyped_ids_rejected = not pcall(progression.grant_random_missing, actor, "mutation", { "QUICK" })
wrong_kind_ids_rejected = not pcall(progression.grant_random_missing, actor, "mutation",
    { ccb.services.types.id("spell", "test_spell_pew") })
empty_ids_rejected = not pcall(progression.grant_random_missing, actor, "mutation", {})
oversized_list_rejected = not pcall(progression.grant_random_missing, actor, "mutation", too_many_ids)
seed_native_rng(native_seed)
mutation_result = grant("mutation", mutation_candidates)
mutation_following_draw = random.native_int(-100, 100)
seed_native_rng(native_seed)
no_missing_result = grant("mutation", { "QUICK" })
no_missing_following_draw = random.native_int(-100, 100)
seed_native_rng(native_seed)
spell_result = grant("spell", { "test_spell_pew" })
spell_following_draw = random.native_int(-100, 100)
seed_native_rng(native_seed)
bionic_result = grant("bionic", { "bio_batteries" })
bionic_following_draw = random.native_int(-100, 100)
seed_native_rng(native_seed)
book_recipe_result = grant("recipe", { "brew_mead" })
book_recipe_following_draw = random.native_int(-100, 100)
done = true
end)
ccb.runtime.on("world_ready", "check_progression")
)" );
    REQUIRE( installed.valid() );
    runtime_world_ready( true );
    REQUIRE( lua["done"].get_or( false ) );
    CHECK( lua["untyped_ids_rejected"].get_or( false ) );
    CHECK( lua["wrong_kind_ids_rejected"].get_or( false ) );
    CHECK( lua["empty_ids_rejected"].get_or( false ) );
    CHECK( lua["oversized_list_rejected"].get_or( false ) );

    const auto value_for = [&]( const char *name ) {
        const sol::table envelope = lua[name];
        REQUIRE( envelope["ok"].get<bool>() );
        return envelope;
    };
    const sol::table mutation_result = value_for( "mutation_result" );
    const sol::table mutation_value = mutation_result["value"];
    REQUIRE( mutation_value["granted"].get<bool>() );
    const script_game_id selected_mutation = mutation_value["id"].get<script_game_id>();
    CHECK( selected_mutation.kind() == "mutation" );
    CHECK( selected_mutation.value() == native_mutation_id );
    CHECK( mutation_value["name"].get<std::string>() == trait_id( native_mutation_id )->name() );
    CHECK( platform_actor.has_trait( trait_id( native_mutation_id ) ) );
    CHECK( lua["mutation_following_draw"].get<int>() == native_mutation_following_draw );

    const sol::table no_missing_result = value_for( "no_missing_result" );
    CHECK_FALSE( no_missing_result["value"]["granted"].get<bool>() );
    CHECK( no_missing_result["value"]["id"].get_type() == sol::type::nil );
    CHECK( no_missing_result["value"]["name"].get_type() == sol::type::nil );
    CHECK( lua["no_missing_following_draw"].get<int>() == native_no_missing_following_draw );

    const sol::table spell_result = value_for( "spell_result" );
    CHECK( spell_result["value"]["granted"].get<bool>() );
    CHECK( spell_result["value"]["id"].get<script_game_id>().value() == "test_spell_pew" );
    CHECK( spell_result["value"]["name"].get<std::string>() ==
           spell_id( "test_spell_pew" )->name.translated() );
    CHECK( get_talker_for( platform_actor )->get_spell_level( spell_id( "test_spell_pew" ) ) == 1 );
    CHECK( lua["spell_following_draw"].get<int>() == native_spell_following_draw );

    const sol::table bionic_result = value_for( "bionic_result" );
    CHECK( bionic_result["value"]["granted"].get<bool>() );
    CHECK( bionic_result["value"]["id"].get<script_game_id>().value() == "bio_batteries" );
    CHECK( bionic_result["value"]["name"].get<std::string>() ==
           bionic_id( "bio_batteries" )->name.translated() );
    CHECK( platform_actor.has_bionic( bionic_id( "bio_batteries" ) ) );
    CHECK( lua["bionic_following_draw"].get<int>() == native_bionic_following_draw );

    const sol::table book_recipe_result = value_for( "book_recipe_result" );
    CHECK( book_recipe_result["value"]["granted"].get<bool>() );
    CHECK( book_recipe_result["value"]["id"].get<script_game_id>().value() == "brew_mead" );
    CHECK( book_recipe_result["value"]["name"].get<std::string>() ==
           book_available_recipe->result_name() );
    CHECK( lua["book_recipe_following_draw"].get<int>() == native_book_recipe_following_draw );
    CHECK( platform_actor.knows_recipe( &book_available_recipe.obj() ) );
    CHECK( platform_actor.has_recipe( &book_available_recipe.obj() ) );
    CHECK( get_talker_for( platform_actor )->has_recipe( book_available_recipe ) );
}
#endif
