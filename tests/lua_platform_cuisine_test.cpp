#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include <cstdint>
#include <filesystem>
#include <functional>
#include <initializer_list>
#include <map>
#include <memory>
#include <string>
#include <string_view>
#include <vector>
#include "avatar.h"
#include "calendar.h"
#include "cata_scope_helpers.h"
#include "character_martial_arts.h"
#include "coordinates.h"
#include "dialogue.h"
#include "dialogue_helpers.h"
#include "global_vars.h"
#include "flexbuffer_json.h"
#include "item.h"
#include "json_loader.h"
#include "lua_platform_loader.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "npc.h"
#include "point.h"
#include "recipe.h"
#include "ret_val.h"
#include "rng.h"
#include "stomach.h"
#include "talker.h"
#include "type_id.h"
#include "units.h"
#include "value_ptr.h"
#include "veh_type.h"
#include "cata_catch.h"
#include "lua_platform_sol.h"
#include <limits>
#include <stdexcept>

#include "lua_platform_test_support.h"
#include "damage.h"
#include "effect.h"
#include "generic_factory.h"
#include "item_factory.h"
#include "item_group.h"
#include "itype.h"
#include "lua_platform_canvas.h"
#include "lua_platform_content.h"
#include "lua_platform_content_items.h"
#include "magic.h"
#include "magic_enchantment.h"
#include "mapdata.h"
#include "monster.h"
#include "mtype.h"
#include "npc_class.h"
#include "options_helpers.h"
#include "overmap.h"
#include "overmapbuffer.h"
#include "scenario.h"
#include "shop_cons_rate.h"
#include "trap.h"

static const damage_type_id damage_bash( "bash" );
static const damage_type_id damage_cut( "cut" );

static const efftype_id effect_ccb_platform_cuisine_effect( "ccb_platform_cuisine_effect" );

static const enchantment_id
enchantment_ccb_platform_cuisine_enchantment( "ccb_platform_cuisine_enchantment" );

static const furn_str_id furn_f_platform_movement_test( "f_platform_movement_test" );
static const furn_str_id furn_f_platform_overflow_test( "f_platform_overflow_test" );

static const item_group_id
Item_spawn_data_ccb_platform_extended_group( "ccb_platform_extended_group" );
static const item_group_id
Item_spawn_data_ccb_platform_extension_native( "ccb_platform_extension_native" );
static const item_group_id
Item_spawn_data_ccb_platform_extension_stock( "ccb_platform_extension_stock" );

static const itype_id itype_battery( "battery" );
static const itype_id itype_ccb_deferred_lua_child( "ccb_deferred_lua_child" );
static const itype_id itype_ccb_deferred_native_child( "ccb_deferred_native_child" );
static const itype_id itype_ccb_deferred_native_parent( "ccb_deferred_native_parent" );
static const itype_id itype_ccb_platform_cuisine_book( "ccb_platform_cuisine_book" );
static const itype_id itype_ccb_platform_cuisine_food( "ccb_platform_cuisine_food" );
static const itype_id itype_rock( "rock" );
static const itype_id itype_sandwich_deluxe( "sandwich_deluxe" );
static const itype_id itype_stick( "stick" );

static const mtype_id mon_platform_missing_reference( "mon_platform_missing_reference" );
static const mtype_id mon_platform_native_references( "mon_platform_native_references" );

static const npc_class_id NC_CCB_DYNAMIC_WHITELIST( "NC_CCB_DYNAMIC_WHITELIST" );

static const recipe_id recipe_ccb_platform_cuisine_recipe( "ccb_platform_cuisine_recipe" );

static const skill_id skill_cooking( "cooking" );

static const string_id<scenario>
scenario_platform_calendar_json_reference( "platform_calendar_json_reference" );
static const string_id<scenario>
scenario_platform_calendar_lua_scenario( "platform_calendar_lua_scenario" );

static const ter_str_id ter_t_cuisine_door_closed( "t_cuisine_door_closed" );
static const ter_str_id ter_t_cuisine_door_open( "t_cuisine_door_open" );
static const ter_str_id ter_t_floor( "t_floor" );

static const vitamin_id vitamin_vitC( "vitC" );

static const vpart_id vpart_turret_laser_rifle( "turret_laser_rifle" );

static const vproto_id
vehicle_prototype_ccb_platform_delayed_turret_extension( "ccb_platform_delayed_turret_extension" );
static const vproto_id
vehicle_prototype_ccb_platform_delayed_turret_vehicle( "ccb_platform_delayed_turret_vehicle" );
static const vproto_id
vehicle_prototype_ccb_platform_invalid_placement( "ccb_platform_invalid_placement" );

namespace
{
struct cuisine_test_mod : platform_lua_test_directory {
    explicit cuisine_test_mod( std::string_view ) {}
    ~cuisine_test_mod() {
        cata::lua_platform::shutdown();
    }
    cata::lua_platform::mod_source source( const std::string &id ) const {
        return { id, root, root / std::filesystem::u8path( "main.lua" ) };
    }
};
} // namespace

TEST_CASE( "lua_platform_canvas_frame_is_bounded_and_expires",
           "[lua][platform][presentation]" )
{
    using cata::lua_platform::platform_canvas_context;
    const float nan = std::numeric_limits<float>::quiet_NaN();
    CHECK_THROWS_AS( platform_canvas_context( 0, 720, 0, 0 ), std::invalid_argument );
    CHECK_THROWS_AS( platform_canvas_context( 960, 2049, 0, 0 ), std::invalid_argument );
    CHECK_THROWS_AS( platform_canvas_context( 960, 720, -1, 0 ), std::invalid_argument );
    CHECK_THROWS_AS( platform_canvas_context( 960, 720, 0, 251 ), std::invalid_argument );
    CHECK_THROWS_AS( platform_canvas_context( 960, 720, 0, 0, 0, 0, nan ),
                     std::invalid_argument );
    platform_canvas_context frame( 960, 720, 500, 33, 10, 20, 0.5F );
    CHECK( frame.width() == 960 );
    CHECK( frame.height() == 720 );
    CHECK( frame.elapsed_ms() == 500 );
    CHECK( frame.delta_ms() == 33 );
    // Invalid primitives must fail before reaching the graphical renderer.
    CHECK_THROWS_AS( frame.rect( nan, 0, 10, 10, 1, 1, 1, 1 ), std::invalid_argument );
    CHECK_THROWS_AS( frame.rect( 0, 0, -1, 10, 1, 1, 1, 1 ), std::invalid_argument );
    CHECK_THROWS_AS( frame.rect( 0, 0, 10, 10, 2, 1, 1, 1 ), std::invalid_argument );
    CHECK_THROWS_AS( frame.text( 0, 0, std::string( 4097, 'x' ), 1, 1, 1, 1 ),
                     std::invalid_argument );
    CHECK_THROWS_AS( frame.sprite( std::string( 257, 'x' ), 0, 0, 32, 32 ),
                     std::invalid_argument );
    CHECK_THROWS_AS( frame.button( "", "Close", 0, 0, 90, 30, false ),
                     std::invalid_argument );
    CHECK( frame.is_open() );
    frame.close();
    CHECK_FALSE( frame.is_open() );
    frame.invalidate();
    CHECK_THROWS_AS( frame.width(), std::runtime_error );
    CHECK_THROWS_AS( frame.height(), std::runtime_error );
    CHECK_THROWS_AS( frame.elapsed_ms(), std::runtime_error );
    CHECK_THROWS_AS( frame.delta_ms(), std::runtime_error );
    CHECK_THROWS_AS( frame.is_open(), std::runtime_error );
    CHECK_THROWS_AS( frame.close(), std::runtime_error );
    CHECK_THROWS_AS( frame.rect( 0, 0, 10, 10, 1, 1, 1, 1 ), std::runtime_error );
    CHECK_THROWS_AS( frame.text( 0, 0, "expired", 1, 1, 1, 1 ), std::runtime_error );
    CHECK_THROWS_AS( frame.sprite( "rock", 0, 0, 32, 32 ), std::runtime_error );
    CHECK_THROWS_AS( frame.button( "close", "Close", 0, 0, 90, 30, false ), std::runtime_error );
}

TEST_CASE( "lua_platform_presentation_canvas_is_registered_but_not_available_at_load_time",
           "[lua][platform][presentation]" )
{
    cata::lua_platform::shutdown();
    cuisine_test_mod test_mod( "ccb_platform_canvas_registration" );
    test_mod.write( std::filesystem::u8path( "main.lua" ), R"lua(
local ccb = require("ccb")
assert(type(ccb.presentation.canvas) == "function")
assert(type(ccb.presentation.play_sound) == "function")
assert(ccb.PlatformCanvasContext == nil)
local called = false
local ok = pcall(ccb.presentation.canvas, { width = 960, height = 720 }, function()
    called = true
end)
assert(not ok and not called)
assert(not pcall(ccb.presentation.play_sound, "assets/win.ogg"))
)lua" );
    std::string error;
    REQUIRE( cata::lua_platform::prepare_mods(
                 { test_mod.source( "ccb_platform_canvas_registration" ) }, error ) );
}

TEST_CASE( "lua_first_comestible_book_recipe_and_effect_enchantment_content_is_transactional",
           "[lua][platform][content][item][recipe][effect]" )
{
    cata::lua_platform::shutdown();
    cuisine_test_mod test_mod( "ccb_platform_cuisine_content" );
    test_mod.write( std::filesystem::u8path( "main.lua" ), R"lua(
local ccb = require("ccb")

local invalid_item = ccb.content.Item {
    id = "ccb_platform_invalid_cuisine_item",
    name = "Invalid cuisine item",
    symbol = "!",
}
invalid_item:comestible { type = "FOOD", calories = 1, fun = 1 }
assert(not pcall(invalid_item.book, invalid_item, {
    skill = "cooking",
    required_level = 0,
    maximum_level = 1,
    intelligence = 1,
    read_time_turns = 1,
    fun = 0,
}))

local invalid_recipe = ccb.content.Recipe {
    id = "ccb_platform_invalid_cuisine_recipe",
    result = "rock",
    duration_moves = 1,
}
assert(not pcall(invalid_recipe.result_charges, invalid_recipe, 0))

local invalid_effect = ccb.content.EffectType {
    id = "ccb_platform_invalid_cuisine_effect",
    name = "Invalid cuisine effect",
    description = "Must remain unregistered.",
}
assert(not pcall(invalid_effect.enchantment, invalid_effect, ""))

local food = ccb.content.Item {
    id = "ccb_platform_cuisine_food",
    copy_from = "cookbook",
    name = "Platform cuisine food",
    symbol = "%",
}
food:comestible {
    type = "FOOD",
    calories = 420,
    fun = 12,
    healthy = 3,
    quench = -2,
    spoils_in_turns = 600,
    charges = 2,
    stack_size = 4,
}
food:vitamin("vitC", 7)
ccb.content.add(food)

local book = ccb.content.Item {
    id = "ccb_platform_cuisine_book",
    copy_from = "test_apple",
    name = "Platform cuisine book",
    symbol = "?",
}
book:book {
    skill = "cooking",
    required_level = 2,
    maximum_level = 6,
    intelligence = 9,
    read_time_turns = 1800,
    fun = 4,
}
ccb.content.add(book)

local recipe = ccb.content.Recipe {
    id = "ccb_platform_cuisine_recipe",
    result = "ccb_platform_cuisine_food",
    duration_moves = 500,
}
recipe:result_charges(3)
recipe:book("ccb_platform_cuisine_book", 5)
recipe:component("scrap", 1)
ccb.content.add(recipe)

local effect = ccb.content.EffectType {
    id = "ccb_platform_cuisine_effect",
    name = "Platform cuisine effect",
    description = "Exercises effect-backed enchantments.",
}
local enchantment = ccb.content.Enchantment { id = "ccb_platform_cuisine_enchantment", condition = "ALWAYS" }
enchantment:value("STRENGTH", { add = 1, multiply = 0.25 })
enchantment:incoming_damage("bash", { add = -3, multiply = -0.25 })
ccb.content.add(enchantment)
effect:enchantment("ccb_platform_cuisine_enchantment")
ccb.content.add(effect)
)lua" );

    std::string error;
    REQUIRE( cata::lua_platform::prepare_mods(
                 { test_mod.source( "ccb_platform_cuisine_content" ) }, error ) );
    REQUIRE( cata::lua_platform::apply_prepared_content( error ) );

    const itype *food = item_controller->find_template(
                            itype_ccb_platform_cuisine_food );
    REQUIRE( food != nullptr );
    REQUIRE( food->comestible );
    CHECK_FALSE( food->book );
    CHECK( food->comestible->comesttype == "FOOD" );
    CHECK( food->comestible->default_nutrition_read_only().kcal() == 420 );
    CHECK( food->comestible->default_nutrition_read_only().get_vitamin(
               vitamin_vitC ) == 7 );
    CHECK( food->comestible->get_fun() == 12 );
    CHECK( food->comestible->healthy == 3 );
    CHECK( food->comestible->quench == -2 );
    CHECK( food->comestible->spoils == 600_turns );
    CHECK( food->comestible->def_charges == 2 );
    CHECK( food->comestible->stack_size == 4 );

    const itype *book = item_controller->find_template(
                            itype_ccb_platform_cuisine_book );
    REQUIRE( book != nullptr );
    REQUIRE( book->book );
    CHECK_FALSE( book->comestible );
    CHECK( book->book->skill == skill_cooking );
    CHECK( book->book->req == 2 );
    CHECK( book->book->level == 6 );
    CHECK( book->book->intel == 9 );
    CHECK( book->book->time == 1800_turns );
    CHECK( book->book->fun == 4 );

    const recipe_id &recipe_key = recipe_ccb_platform_cuisine_recipe;
    REQUIRE( recipe_key.is_valid() );
    CHECK( recipe_key->makes_amount() == 3 );
    CHECK( recipe_key->booksets.count( itype_ccb_platform_cuisine_book ) == 1 );

    const efftype_id &effect_key = effect_ccb_platform_cuisine_effect;
    const enchantment_id &enchantment_key = enchantment_ccb_platform_cuisine_enchantment;
    REQUIRE( effect_key.is_valid() );
    REQUIRE( enchantment_key.is_valid() );
    REQUIRE( effect_key->enchantments.size() == 1 );
    CHECK( effect_key->enchantments.front() == enchantment_key );
    CHECK( enchantment_key->values_add.count( enchant_vals::mod::STRENGTH ) == 1 );
    CHECK( enchantment_key->values_multiply.count( enchant_vals::mod::STRENGTH ) == 1 );
    CHECK( enchantment_key->armor_values_add.count( damage_bash ) == 1 );
    CHECK( enchantment_key->armor_values_multiply.count( damage_bash ) == 1 );

    cata::lua_platform::discard_prepared_mods();
    CHECK_FALSE( item_controller->has_template( itype_ccb_platform_cuisine_food ) );
    CHECK_FALSE( item_controller->has_template( itype_ccb_platform_cuisine_book ) );
    CHECK_FALSE( recipe_key.is_valid() );
    CHECK_FALSE( effect_key.is_valid() );
    CHECK_FALSE( enchantment_key.is_valid() );
}

TEST_CASE( "lua_first_enchantment_values_work_during_save_reconstruction",
           "[lua][platform][content][effect][regression]" )
{
    cata::lua_platform::shutdown();
    on_out_of_scope cleanup( []() {
        cata::lua_platform::shutdown();
    } );
    cuisine_test_mod test_mod( "ccb_platform_load_enchantment" );
    test_mod.write( std::filesystem::u8path( "main.lua" ), R"lua(
local ccb = require("ccb")
local enchantment = ccb.content.Enchantment { id = "ccb_platform_load_enchantment" }
ccb.runtime.handler("loaded_strength", function(ctx)
    assert(ctx.stats and ctx.skills)
    assert(ctx.skills.cooking == 4)
    return ctx.stats.strength + ctx.skills.cooking
end)
ccb.runtime.handler("ready_speed", function()
    assert(ccb.services.characters.avatar())
    return 6
end)
ccb.runtime.handler("loaded_perception", function(ctx)
    return ctx.spell_levels.test_spell_pew
end)
enchantment:value("STRENGTH", { add_handler = "loaded_strength", load_skills = { "cooking" } })
enchantment:value("SPEED", { add_handler = "ready_speed" })
enchantment:value("PERCEPTION", { add_handler = "loaded_perception", load_spell_levels = { "test_spell_pew" } })
ccb.content.add(enchantment)
)lua" );
    std::string error;
    REQUIRE( cata::lua_platform::prepare_mods(
                 { test_mod.source( "ccb_platform_load_enchantment" ) }, error ) );
    REQUIRE( cata::lua_platform::apply_prepared_content( error ) );
    REQUIRE( cata::lua_platform::validate_finalized_prepared_content( error ) );
    cata::lua_platform::commit_prepared_mods();

    npc restoring_npc;
    restoring_npc.set_skill_level( skill_id( "cooking" ), 4 );
    const enchantment_id id( "ccb_platform_load_enchantment" );
    REQUIRE( id.is_valid() );
    const auto check_load_values = [&]( const int spell_level ) {
        enchant_cache cache;
        cache.force_add( id.obj(), restoring_npc );
        CHECK( cache.get_value_add( enchant_vals::mod::STRENGTH ) == restoring_npc.get_str() + 4 );
        CHECK( cache.get_value_add( enchant_vals::mod::SPEED ) == 0 );
        CHECK( cache.get_value_add( enchant_vals::mod::PERCEPTION ) == spell_level );
    };
    check_load_values( -1 );
    restoring_npc.magic->set_spell_level( spell_id( "test_spell_pew" ), 4, &restoring_npc );
    check_load_values( 4 );
    bool finished_native_load = false;
    cata::lua_platform::on_world_ready( false, [&]() {
        enchant_cache cache;
        cache.force_add( id.obj(), restoring_npc );
        CHECK( cache.get_value_add( enchant_vals::mod::SPEED ) == 6 );
        finished_native_load = true;
    } );
    CHECK( finished_native_load );
    cata::lua_platform::on_world_load_started();
    check_load_values( 4 );
}

TEST_CASE( "lua_first_enchantment_activation_reads_loaded_character_inputs",
           "[lua][platform][content][effect][regression]" )
{
    cata::lua_platform::shutdown();
    on_out_of_scope cleanup( []() {
        cata::lua_platform::shutdown();
    } );
    cuisine_test_mod test_mod( "ccb_platform_load_activation" );
    test_mod.write( std::filesystem::u8path( "main.lua" ), R"lua(
local ccb = require("ccb")
ccb.runtime.handler("matching_inputs", function(ctx)
    assert(ctx.speaker == nil)
    local inputs = ctx.character_inputs
    return inputs.effects.sleep and inputs.traits.TOUGH
        and inputs.worn_items.backpack and inputs.worn_flags.WATERPROOF
        and inputs.character_flags.QUADRUPED_CROUCH and inputs.move_mode == "crouch"
end)
ccb.runtime.handler("learning_state", function(ctx)
    assert(ctx.speaker == nil)
    local state = ctx.character_inputs
    return state.proficiency_percentages.prof_test + state.spell_levels.test_eoc_spell
        + state.spell_school_levels.test_trait + state.spell_school_level_sums.test_trait
end)
ccb.runtime.handler("loaded_strength", function(ctx)
    assert(ctx.speaker == nil)
    local state = ctx.character_inputs
    local saved = state.character_variables
    assert(saved.lua_test_enchantment_missing == 0)
    if state.pain > 20 then
        local ok, problem = pcall(function() return saved.lua_test_enchantment_invalid end)
        assert(not ok and string.find(problem, "Type mismatch", 1, true))
    end
    return state.pain + state.effect_intensities.sleep + (state.armed and 10 or 0)
        + saved.lua_test_enchantment_bonus + state.global_variables.lua_test_enchantment_bonus
end)
ccb.content.add(ccb.content.Enchantment {
    id = "ccb_platform_load_activation",
    condition_handler = "matching_inputs",
    load_character_inputs = {
        effects = { "sleep" },
        traits = { "TOUGH" },
        worn_items = { "backpack" },
        worn_flags = { "WATERPROOF" },
        effect_intensities = { "sleep" },
        character_variables = {
            "lua_test_enchantment_bonus", "lua_test_enchantment_invalid", "lua_test_enchantment_missing",
        },
        global_variables = { "lua_test_enchantment_bonus" },
        character_flags = { "QUADRUPED_CROUCH" },
        move_mode = true,
        proficiency_percentages = { "prof_test" },
        spell_levels = { "test_eoc_spell" },
        spell_school_levels = { "test_trait" },
        spell_school_level_sums = { "test_trait" },
        pain = true,
        armed = true,
    },
}
    :value("STRENGTH", { add_handler = "loaded_strength" })
    :value("PERCEPTION", { add_handler = "learning_state" }))
)lua" );
    std::string error;
    REQUIRE( cata::lua_platform::prepare_mods(
                 { test_mod.source( "ccb_platform_load_activation" ) }, error ) );
    REQUIRE( cata::lua_platform::apply_prepared_content( error ) );
    REQUIRE( cata::lua_platform::validate_finalized_prepared_content( error ) );
    cata::lua_platform::commit_prepared_mods();

    npc restoring_npc;
    const enchantment_id id( "ccb_platform_load_activation" );
    REQUIRE( id.is_valid() );
    REQUIRE( get_globals().maybe_get_global_value( "lua_test_enchantment_bonus" ) == nullptr );
    on_out_of_scope restore_global( []() {
        get_globals().remove_global_value( "lua_test_enchantment_bonus" );
    } );
    restoring_npc.set_value( "lua_test_enchantment_invalid", "typed text" );
    const auto bonus = [&]( const enchant_vals::mod value ) {
        enchant_cache cache;
        cache.force_add( id.obj(), restoring_npc );
        return cache.get_value_add( value );
    };
    const auto strength_bonus = [&]() {
        return bonus( enchant_vals::mod::STRENGTH );
    };
    restoring_npc.set_pain( 12 );
    CHECK( strength_bonus() == 11 );
    CHECK( bonus( enchant_vals::mod::PERCEPTION ) == -2 );
    restoring_npc.set_proficiency_practiced_time( proficiency_id( "prof_test" ), 43200 );
    restoring_npc.magic->set_spell_level( spell_id( "test_eoc_spell" ), 4, &restoring_npc );
    // The native maximum requires membership in the school. The sum and
    // individual spell level still count a spell learned without that trait.
    CHECK( bonus( enchant_vals::mod::PERCEPTION ) == 57 );
    restoring_npc.set_mutation( trait_id( "test_trait" ) );
    CHECK( bonus( enchant_vals::mod::PERCEPTION ) == 62 );
    restoring_npc.set_value( "lua_test_enchantment_bonus",
                             diag_value( diag_value::legacy_value( "3.5" ) ) );
    get_globals().set_global_value( "lua_test_enchantment_bonus", 4 );
    CHECK( strength_bonus() == 18.5 );
    restoring_npc.set_pain( 25 );
    CHECK( strength_bonus() == 31.5 );
    restoring_npc.set_pain( 12 );
    CHECK_FALSE( id->is_active( restoring_npc, false ) );
    restoring_npc.add_effect( efftype_id( "sleep" ), 2_minutes );
    restoring_npc.set_mutation( trait_id( "TOUGH" ) );
    CHECK_FALSE( id->is_active( restoring_npc, false ) );

    item backpack( itype_id( "backpack" ) );
    backpack.set_flag( flag_id( "WATERPROOF" ) );
    restoring_npc.worn.wear_item( restoring_npc, backpack, false, false );
    CHECK_FALSE( id->is_active( restoring_npc, false ) );
    restoring_npc.set_mutation( trait_id( "PAWS" ) );
    CHECK_FALSE( id->is_active( restoring_npc, false ) );
    restoring_npc.set_movement_mode( move_mode_id( "crouch" ) );
    CHECK( id->is_active( restoring_npc, false ) );
    item rock( itype_rock );
    REQUIRE( restoring_npc.wield( rock ) );
    restoring_npc.martial_arts_data->set_style( matype_id( "style_none" ), true );
    REQUIRE_FALSE( restoring_npc.unarmed_attack() );
    CHECK( strength_bonus() == 29.5 + restoring_npc.get_effect_int( efftype_id( "sleep" ) ) );

    restoring_npc.remove_effect( efftype_id( "sleep" ) );
    CHECK_FALSE( id->is_active( restoring_npc, false ) );
    CHECK( strength_bonus() == 28.5 );
    restoring_npc.martial_arts_data->set_style( matype_id( "style_kicks" ), true );
    REQUIRE( restoring_npc.unarmed_attack() );
    CHECK( strength_bonus() == 18.5 );
}

TEST_CASE( "lua_first_enchantment_reads_tile_and_overmap_during_character_load",
           "[lua][platform][content][effect][regression]" )
{
    cata::lua_platform::shutdown();
    clear_map();
    const on_out_of_scope cleanup( []() {
        cata::lua_platform::shutdown();
        clear_map();
    } );
    cuisine_test_mod test_mod( "ccb_platform_environment_enchantment" );
    test_mod.write( std::filesystem::u8path( "main.lua" ), R"lua(
local ccb = require("ccb")
ccb.runtime.handler("local_water_and_road", function(ctx)
    assert(ctx.speaker == nil)
    local environment = ctx.character_inputs.environment
    return environment.position_z == 0 and environment.divable
        and environment.terrain == "t_water_dp" and environment.terrain_flags.SWIMMABLE
        and environment.fields.fd_smoke and environment.overmap_terrain == "forest"
        and environment.nearby_overmap_terrain.road
end)
ccb.content.add(ccb.content.Enchantment {
    id = "lua_test_enchantment_environment",
    condition_handler = "local_water_and_road",
    load_character_inputs = { environment = {
        position_z = true, divable = true, terrain = true, terrain_flags = { "SWIMMABLE" },
        fields = { "fd_smoke" }, overmap_terrain = true, nearby_overmap_terrain = { road = 1 },
    } },
})
)lua" );
    std::string error;
    REQUIRE( cata::lua_platform::prepare_mods(
                 { test_mod.source( "ccb_platform_environment_enchantment" ) }, error ) );
    REQUIRE( cata::lua_platform::apply_prepared_content( error ) );
    REQUIRE( cata::lua_platform::validate_finalized_prepared_content( error ) );
    cata::lua_platform::commit_prepared_mods();

    const enchantment_id id( "lua_test_enchantment_environment" );
    REQUIRE( id.is_valid() );
    npc restoring_npc;
    map &here = get_map();
    const tripoint_bub_ms where( 60, 60, 0 );
    restoring_npc.setpos( here, where, false );
    const tripoint_abs_omt center = restoring_npc.pos_abs_omt();
    const tripoint_abs_omt diagonal = center + tripoint( 1, 1, 0 );
    const oter_id saved_center = overmap_buffer.ter( center );
    const oter_id saved_diagonal = overmap_buffer.ter( diagonal );
    const on_out_of_scope restore_overmap( [&]() {
        overmap_buffer.ter_set( center, saved_center );
        overmap_buffer.ter_set( diagonal, saved_diagonal );
    } );
    overmap_buffer.ter_set( center, oter_id( "forest" ) );
    const oter_id road( "road_nesw" );
    REQUIRE( oter_no_dir_or_connections( road ) == "road" );
    overmap_buffer.ter_set( diagonal, road );
    here.ter_set( where, ter_str_id( "t_floor" ) );
    CHECK_FALSE( id->is_active( restoring_npc, false ) );
    here.ter_set( where, ter_str_id( "t_water_dp" ) );
    CHECK_FALSE( id->is_active( restoring_npc, false ) );
    REQUIRE( here.add_field( where, field_type_id( "fd_smoke" ), 1 ) );
    CHECK_FALSE( restoring_npc.is_underwater() );
    CHECK( id->is_active( restoring_npc, false ) );
}

TEST_CASE( "lua_first_enchantment_vision_reads_range_and_target_without_live_handles",
           "[lua][platform][content][effect][regression]" )
{
    cata::lua_platform::shutdown();
    clear_map();
    const on_out_of_scope cleanup( []() {
        cata::lua_platform::shutdown();
        clear_map();
    } );
    cuisine_test_mod test_mod( "ccb_platform_vision_enchantment" );
    test_mod.write( std::filesystem::u8path( "main.lua" ), R"lua(
local ccb = require("ccb")
ccb.runtime.handler("range", function(ctx)
    assert(ctx.speaker == nil)
    return 3 * ctx.character_inputs.spell_school_counts.test_trait
end)
ccb.runtime.handler("clear_airway", function(ctx)
    return not ctx.character_inputs.body_part_effects.mouth.smoke
end)
ccb.runtime.handler("warm_npc", function(ctx)
    assert(ctx.interlocutor == nil)
    local target = ctx.target_inputs
    return target.line_of_sight and target.warm and target.npc
end)
ccb.runtime.handler("tiny", function(ctx) return ctx.target_inputs.size == 1 end)
ccb.runtime.handler("medium", function(ctx) return ctx.target_inputs.size == 3 end)
ccb.content.add(ccb.content.Enchantment {
    id = "lua_test_enchantment_vision",
    condition_handler = "clear_airway",
    load_character_inputs = { spell_school_counts = { "test_trait" }, body_part_effects = { mouth = { "smoke" } } },
}:vision {
    distance_handler = "range",
    condition_handler = "warm_npc",
    target_inputs = { line_of_sight = true, warm = true, npc = true },
    descriptions = {
        { id = "tiny", text = "Tiny.", condition_handler = "tiny", target_inputs = { size = true } },
        { id = "medium", text = "Medium.", condition_handler = "medium", target_inputs = { size = true } },
    },
})
)lua" );
    std::string error;
    REQUIRE( cata::lua_platform::prepare_mods(
                 { test_mod.source( "ccb_platform_vision_enchantment" ) }, error ) );
    REQUIRE( cata::lua_platform::apply_prepared_content( error ) );
    REQUIRE( cata::lua_platform::validate_finalized_prepared_content( error ) );
    cata::lua_platform::commit_prepared_mods();

    npc observer;
    npc target;
    map &here = get_map();
    observer.setpos( here, tripoint_bub_ms( 60, 60, 0 ), false );
    target.setpos( here, tripoint_bub_ms( 62, 60, 0 ), false );
    const_dialogue dialogue( get_const_talker_for( observer ), get_const_talker_for( target ) );
    const enchantment_id id( "lua_test_enchantment_vision" );
    REQUIRE( id.is_valid() );
    CHECK( id->is_active( observer, false ) );
    observer.add_effect( efftype_id( "smoke" ), 1_minutes, bodypart_id( "mouth" ) );
    CHECK_FALSE( id->is_active( observer, false ) );
    observer.remove_effect( efftype_id( "smoke" ), bodypart_id( "mouth" ) );

    enchant_cache unknown;
    unknown.force_add( id.obj(), observer );
    CHECK_FALSE( unknown.get_vision_can_see( unknown.get_vision( dialogue ) ) );
    observer.magic->set_spell_level( spell_id( "test_eoc_spell" ), 1, &observer );
    enchant_cache learned;
    learned.force_add( id.obj(), observer );
    const enchant_cache::special_vision vision = learned.get_vision( dialogue );
    REQUIRE( learned.get_vision_can_see( vision ) );
    CHECK( vision.range == 3 );
    CHECK( learned.get_vision_description_struct( vision, dialogue ).id == "medium" );
}

TEST_CASE( "lua_first_enchantment_native_modifier_order_matches_the_game_rng",
           "[lua][platform][content][effect][regression]" )
{
    cata::lua_platform::shutdown();
    const on_out_of_scope cleanup( []() {
        cata::lua_platform::shutdown();
    } );
    cuisine_test_mod test_mod( "ccb_platform_native_random_enchantment" );
    test_mod.write( std::filesystem::u8path( "main.lua" ), R"lua(
local ccb = require("ccb")
local random = ccb.services.random
ccb.runtime.handler("roll_resistance", function(ctx)
    assert(ctx.speaker == nil)
    return -random.native_int(0, 3)
end)
ccb.runtime.handler("roll_evasion", function()
    return random.native_int(0, 5) * 0.01
end)
ccb.runtime.handler("roll_regeneration", function()
    return random.native_float(-2, -5)
end)
ccb.content.add(ccb.content.Enchantment {
    id = "lua_test_enchantment_native_order",
    native_modifier_order = true,
    load_character_inputs = {},
}
    :incoming_damage("cut", { add_handler = "roll_resistance" })
    :value("EVASION", { add_handler = "roll_evasion" })
    :value("REGEN_HP", { multiply_handler = "roll_regeneration" })
    :incoming_damage("bash", { add_handler = "roll_resistance" })
    :value("PAIN", { add_handler = "roll_resistance" }))
)lua" );
    std::string error;
    REQUIRE( cata::lua_platform::prepare_mods(
                 { test_mod.source( "ccb_platform_native_random_enchantment" ) }, error ) );
    REQUIRE( cata::lua_platform::apply_prepared_content( error ) );
    REQUIRE( cata::lua_platform::validate_finalized_prepared_content( error ) );
    cata::lua_platform::commit_prepared_mods();

    const enchantment_id id( "lua_test_enchantment_native_order" );
    REQUIRE( id.is_valid() );
    npc subject;
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    rng_set_engine_seed( 70731 );
    const cata_default_random_engine start = rng_get_engine();
    const int expected_pain = -rng( 0, 3 );
    const double expected_evasion = rng( 0, 5 ) * 0.01;
    const double expected_regeneration = rng_float( -2, -5 );
    std::map<damage_type_id, int> armor{ { damage_bash, 0 }, { damage_cut, 0 } };
    for( auto &[type, value] : armor ) {
        value = -rng( 0, 3 );
    }
    const cata_default_random_engine after = rng_get_engine();

    rng_get_engine() = start;
    enchant_cache cache;
    cache.force_add( id.obj(), subject );
    CHECK( cache.get_value_add( enchant_vals::mod::PAIN ) == expected_pain );
    CHECK( cache.get_value_add( enchant_vals::mod::EVASION ) == expected_evasion );
    CHECK( cache.get_value_multiply( enchant_vals::mod::REGEN_HP ) == expected_regeneration );
    for( const auto &[type, value] : armor ) {
        CHECK( cache.get_armor_add( type ) == value );
    }
    CHECK( rng_get_engine() == after );
}

TEST_CASE( "lua_first_enchantment_counts_nearby_monsters_while_loading",
           "[lua][platform][content][effect][regression]" )
{
    cata::lua_platform::shutdown();
    clear_map();
    const on_out_of_scope cleanup( []() {
        cata::lua_platform::shutdown();
        clear_map();
    } );
    cuisine_test_mod test_mod( "ccb_platform_enchantment_nearby" );
    test_mod.write( std::filesystem::u8path( "main.lua" ), R"lua(
local ccb = require("ccb")
ccb.runtime.handler("count_nearby", function(ctx)
    assert(ctx.speaker == nil)
    local counts = ctx.character_inputs.nearby_monsters
    return 10 * counts.hostiles + counts.zombies
end)
ccb.content.add(ccb.content.Enchantment {
    id = "lua_test_enchantment_nearby",
    load_character_inputs = { nearby_monsters = {
        hostiles = { radius = 2 },
        zombies = { radius = 2, attitude = "both", species = { "ZOMBIE" } },
    } },
}:value("SPEED", { add_handler = "count_nearby" }))
)lua" );
    std::string error;
    REQUIRE( cata::lua_platform::prepare_mods(
                 { test_mod.source( "ccb_platform_enchantment_nearby" ) }, error ) );
    REQUIRE( cata::lua_platform::apply_prepared_content( error ) );
    REQUIRE( cata::lua_platform::validate_finalized_prepared_content( error ) );
    cata::lua_platform::commit_prepared_mods();

    npc subject;
    const tripoint_bub_ms origin( 60, 60, 0 );
    subject.setpos( get_map(), origin, false );
    spawn_test_monster( "mon_zombie", origin + tripoint::east ).friendly = 0;
    spawn_test_monster( "mon_zombie", origin + tripoint( 2, 0, 0 ) ).friendly = 1;
    spawn_test_monster( "mon_zombie", origin + tripoint( 3, 0, 0 ) ).friendly = 0;
    spawn_test_monster( "mon_dog", origin + tripoint::north ).friendly = 1;
    const enchantment_id id( "lua_test_enchantment_nearby" );
    REQUIRE( id.is_valid() );
    enchant_cache cache;
    cache.force_add( id.obj(), subject );
    CHECK( cache.get_value_add( enchant_vals::mod::SPEED ) == 12 );
}

TEST_CASE( "lua_first_enchantment_upsert_uses_active_mod_order",
           "[lua][platform][content][effect][regression]" )
{
    cata::lua_platform::shutdown();
    const on_out_of_scope cleanup( []() {
        cata::lua_platform::shutdown();
    } );
    cuisine_test_mod first( "ccb_platform_enchantment_order_first" );
    cuisine_test_mod second( "ccb_platform_enchantment_order_second" );
    const auto write = []( const cuisine_test_mod &mod, const int amount ) {
        mod.write( std::filesystem::u8path( "main.lua" ),
                   "local c = require('ccb').content\n"
                   "c.upsert_enchantment(c.Enchantment { id = 'lua_test_enchantment_upsert' }"
                   ":value('STRENGTH', { add = " + std::to_string( amount ) + " }))\n" );
    };
    write( first, 1 );
    write( second, 2 );
    const bool reversed = GENERATE( false, true );
    auto sources = std::vector<cata::lua_platform::mod_source>{
        first.source( "ccb_platform_enchantment_order_first" ),
        second.source( "ccb_platform_enchantment_order_second" ),
    };
    if( reversed ) {
        std::swap( sources[0], sources[1] );
    }
    const enchantment_id id( "lua_test_enchantment_upsert" );
    REQUIRE_FALSE( id.is_valid() );
    std::string error;
    REQUIRE( cata::lua_platform::prepare_mods( sources, error ) );
    REQUIRE( cata::lua_platform::apply_prepared_content( error ) );
    REQUIRE( cata::lua_platform::validate_finalized_prepared_content( error ) );
    REQUIRE( id.is_valid() );
    npc subject;
    CHECK( id->get_value_add( enchant_vals::mod::STRENGTH, subject ) == ( reversed ? 1 : 2 ) );
    cata::lua_platform::discard_prepared_mods();
    CHECK_FALSE( id.is_valid() );
}

TEST_CASE( "lua_first_shopkeeper_whitelist_supports_bounded_item_predicates",
           "[lua][platform][content][shopkeeper]" )
{
    cata::lua_platform::shutdown();
    cuisine_test_mod test_mod( "ccb_platform_dynamic_shopkeeper_whitelist" );
    test_mod.write( std::filesystem::u8path( "main.lua" ), R"lua(
local ccb = require("ccb")

ccb.runtime.handler("accept_food", function(payload)
    assert(payload.item.id.kind == "item")
    assert(type(payload.item.food) == "boolean")
    assert(math.type(payload.item.base_enjoyment) == "integer")
    assert(type(payload.shopkeeper.name) == "string")
    return payload.item.food
        and not payload.item.medication
        and payload.item.base_enjoyment >= 5
        and not payload.item.rotten
end, 1)

ccb.content.add(ccb.content.ShopkeeperWhitelist {
    id = "ccb_platform_dynamic_food_whitelist",
    message = "Only fresh gourmet food is accepted.",
    predicate = "accept_food",
})

ccb.content.add(ccb.content.NpcClass {
    id = "NC_CCB_DYNAMIC_WHITELIST",
    name = "dynamic whitelist trader",
    job_description = "tests detached item predicates",
    common = false,
    sells_belongings = false,
    whitelist = "ccb_platform_dynamic_food_whitelist",
})

for _, fun in ipairs({ 4, 5, 6 }) do
    local food = ccb.content.Item {
        id = "ccb_platform_trade_food_" .. fun,
        copy_from = "test_apple",
        name = "Trade boundary food",
    }
    food:comestible {
        type = "FOOD", calories = 95, fun = fun, spoils_in_turns = 3600,
    }
    ccb.content.add(food)
end
)lua" );

    std::string error;
    REQUIRE( cata::lua_platform::prepare_mods(
                 { test_mod.source( "ccb_platform_dynamic_shopkeeper_whitelist" ) }, error ) );
    REQUIRE( cata::lua_platform::apply_prepared_content( error ) );
    REQUIRE( cata::lua_platform::validate_finalized_prepared_content( error ) );
    cata::lua_platform::commit_prepared_mods();
    cata::lua_platform::on_world_ready( true );

    const npc_class_id &class_id = NC_CCB_DYNAMIC_WHITELIST;
    REQUIRE( class_id.is_valid() );
    REQUIRE( class_id->has_whitelist() );
    const shopkeeper_whitelist &whitelist = class_id->get_shopkeeper_whitelist();

    npc trader;
    trader.myclass = class_id;
    REQUIRE_FALSE( trader.will_exchange_items_freely() );
    npc seller;
    const auto check_acceptance = [&]( const item &candidate, const bool expected ) {
        CAPTURE( candidate.typeId().str(), expected );
        const icg_entry *legacy = whitelist.matches( candidate, trader );
        CHECK( ( legacy != nullptr ) == expected );
        CHECK( legacy == whitelist.matches( candidate, trader, get_avatar() ) );
        CHECK( ( whitelist.matches( candidate, trader, seller ) != nullptr ) == expected );
        CHECK( trader.wants_to_buy( candidate, 100 ).success() == expected );
        CHECK( trader.wants_to_buy( candidate, 100, seller ).success() == expected );
    };

    item gourmet( itype_sandwich_deluxe );
    item non_food( itype_rock );
    REQUIRE_FALSE( gourmet.rotten() );
    check_acceptance( gourmet, true );
    check_acceptance( non_food, false );
    for( const int enjoyment : { 4, 5, 6 } ) {
        item candidate( itype_id( "ccb_platform_trade_food_" + std::to_string( enjoyment ) ) );
        REQUIRE( candidate.get_comestible()->get_fun() == enjoyment );
        REQUIRE_FALSE( candidate.rotten() );
        check_acceptance( candidate, enjoyment >= 5 );
    }

    gourmet.set_rot( 1000_hours );
    REQUIRE( gourmet.rotten() );
    check_acceptance( gourmet, false );

    // Native conditions must still see the exact seller, not an implicit avatar.
    shopkeeper_whitelist conditional = whitelist;
    icg_entry native_rule;
    native_rule.itype = itype_rock;
    native_rule.condition = [&seller]( const const_dialogue &dialogue ) {
        return dialogue.const_actor( false )->get_const_character() == &seller;
    };
    conditional.entries.push_back( native_rule );
    CHECK( conditional.matches( non_food, trader ) == nullptr );
    CHECK( conditional.matches( non_food, trader, get_avatar() ) == nullptr );
    CHECK( conditional.matches( non_food, trader, seller ) == &conditional.entries.front() );
}

TEST_CASE( "lua_first_resolves_deferred_native_item_parents_before_validation",
           "[lua][platform][content][item]" )
{
    cata::lua_platform::shutdown();
    auto &factory = item_controller->get_generic_factory();
    const itype_id &parent = itype_ccb_deferred_native_parent;
    const itype_id &child = itype_ccb_deferred_native_child;
    const itype_id &result = itype_ccb_deferred_lua_child;
    const auto load_parent = [&]() {
        JsonObject jo = json_loader::from_string( R"json({
            "type": "ITEM", "id": "ccb_deferred_native_parent",
            "copy-from": "rock", "name": "deferred parent", "weight": "123 g"
        })json" ).get_object();
        REQUIRE( jo.get_string( "type" ) == "ITEM" );
        items::load( jo, "dda" );
    };
    on_out_of_scope cleanup( [&]() {
        cata::lua_platform::shutdown();
        if( !factory.is_valid( parent ) ) {
            load_parent();
        }
        factory.resolve_deferred();
        factory.erase( child );
        factory.erase( parent );
    } );

    JsonObject child_json = json_loader::from_string( R"json({
        "type": "ITEM", "id": "ccb_deferred_native_child",
        "copy-from": "ccb_deferred_native_parent", "name": "deferred child"
    })json" ).get_object();
    REQUIRE( child_json.get_string( "type" ) == "ITEM" );
    items::load( child_json, "dda" );
    REQUIRE_FALSE( factory.is_valid( child ) );
    // An early pass must retain dependencies that cannot be resolved yet.
    factory.resolve_deferred();
    REQUIRE_FALSE( factory.is_valid( child ) );
    load_parent();
    REQUIRE_FALSE( factory.is_valid( child ) );

    cuisine_test_mod test_mod( "ccb_deferred_native_inheritance" );
    test_mod.write( std::filesystem::u8path( "main.lua" ), R"lua(
local ccb = require("ccb")
ccb.content.add(ccb.content.Item {
    id = "ccb_deferred_lua_child",
    copy_from = "ccb_deferred_native_child",
    name = "Lua inherited child",
})
)lua" );
    std::string error;
    REQUIRE( cata::lua_platform::prepare_mods(
                 { test_mod.source( "ccb_deferred_native_inheritance" ) }, error ) );
    REQUIRE( cata::lua_platform::apply_prepared_content( error ) );
    REQUIRE( factory.is_valid( child ) );
    REQUIRE( item::type_is_defined( result ) );
    CHECK( result->weight == child->weight );
    cata::lua_platform::discard_prepared_mods();
    CHECK_FALSE( item::type_is_defined( result ) );
    CHECK( factory.is_valid( child ) );

    test_mod.write( std::filesystem::u8path( "main.lua" ), R"lua(
local ccb = require("ccb")
ccb.content.add(ccb.content.Item {
    id = "ccb_deferred_lua_child",
    copy_from = "ccb_truly_missing_native_parent",
    name = "Invalid Lua child",
})
)lua" );
    REQUIRE( cata::lua_platform::prepare_mods(
                 { test_mod.source( "ccb_deferred_native_inheritance" ) }, error ) );
    CHECK_FALSE( cata::lua_platform::apply_prepared_content( error ) );
    INFO( error );
    CHECK( error.find( "unknown copy_from parent" ) != std::string::npos );
    CHECK( error.find( "ccb_truly_missing_native_parent" ) != std::string::npos );
    CHECK_FALSE( item::type_is_defined( result ) );
}

TEST_CASE( "lua_platform_terrain_forward_links_and_empty_traps",
           "[lua][platform][content][terrain]" )
{
    cata::lua_platform::shutdown();
    cuisine_test_mod files( "terrain_links" );
    files.write( std::filesystem::u8path( "main.lua" ), R"lua(
local ccb = require("ccb")
ccb.content.add(ccb.content.Terrain {
    id = "t_cuisine_door_closed", name = "Closed door", symbol = "+",
    color = "brown", move_cost = 0, open = "t_cuisine_door_open",
})
ccb.content.add(ccb.content.Terrain {
    id = "t_cuisine_door_open", name = "Open door", symbol = ".",
    color = "brown", move_cost = 2, close = "t_cuisine_door_closed",
})
)lua" );
    std::string error;
    REQUIRE( cata::lua_platform::prepare_mods( { files.source( "terrain_links" ) }, error ) );
    REQUIRE( cata::lua_platform::apply_prepared_content( error ) );
    const ter_str_id &closed = ter_t_cuisine_door_closed;
    const ter_str_id &open = ter_t_cuisine_door_open;
    REQUIRE( closed.is_valid() );
    REQUIRE( open.is_valid() );
    CHECK( closed->open == open );
    CHECK( open->close == closed );
    CHECK( closed->trap_id_str.empty() );
    CHECK( closed->trap == tr_null );
}

TEST_CASE( "lua_platform_item_group_extensions_preserve_native_and_prior_mod_entries",
           "[lua][platform][content][item_group]" )
{
    cata::lua_platform::shutdown();
    const bool collection = GENERATE( true, false );
    const std::string kind = collection ? "collection" : "distribution";
    const item_group_id &group_id = Item_spawn_data_ccb_platform_extension_native;
    REQUIRE_FALSE( item_group::group_is_defined( group_id ) );
    // Create a native baseline outside the loader's candidate transaction.
    sol::state fixture_lua;
    cata::lua_platform::items_content_transaction fixture( "extension_fixture", 1 );
    on_out_of_scope cleanup( [&fixture]() {
        cata::lua_platform::shutdown();
        fixture.rollback_all();
    } );
    sol::table fixture_ccb = fixture_lua.create_table();
    sol::table fixture_content = fixture_lua.create_table();
    fixture_ccb["content"] = fixture_content;
    fixture_lua["ccb"] = fixture_ccb;
    fixture.install_lua_api( fixture_lua, fixture_ccb, fixture_content );
    const sol::protected_function_result definition = fixture_lua.safe_script(
                "local group = ccb.content.ItemGroup { id = '" + group_id.str() +
                "', kind = '" + kind + "' }\ngroup:item('rock', 100)\nreturn group",
                sol::script_pass_on_error );
    REQUIRE( definition.valid() );
    REQUIRE( fixture.register_definition( definition.get<sol::object>(), 0 ) );
    std::string error;
    using phase = cata::lua_platform::items_content_apply_phase;
    for( const phase step : { phase::foundations, phase::materials, phase::catalogs,
                             phase::ammunition_effects, phase::metadata, phase::item_groups } ) {
        const bool applied = fixture.apply_phase( step, error );
        INFO( error );
        REQUIRE( applied );
    }
    Item_group *const original = dynamic_cast<Item_group *>( item_controller->get_group( group_id ) );
    REQUIRE( original != nullptr );

    cuisine_test_mod provider( "extension_provider" );
    cuisine_test_mod consumer( "extension_consumer" );
    provider.write( std::filesystem::u8path( "main.lua" ), "local kind = '" + kind + R"lua('
local ccb = require("ccb")
local stock = ccb.content.ItemGroup {
    id = "ccb_platform_extension_stock", kind = "collection",
}
stock:entry { item = "battery", probability = 100, charges = { 7, 7 } }
ccb.content.add(stock)
local extension = ccb.content.ItemGroup {
    id = "ccb_platform_extension_native", kind = kind,
}
extension:entry { group = "ccb_platform_extension_stock", probability = 100, count = { 2, 2 } }
ccb.content.extend_item_group(extension)
assert(not pcall(ccb.content.extend_item_group, extension))
assert(not pcall(extension.item, extension, "stick", 100))
)lua" );

    std::string target = group_id.str();
    std::string extension_kind = kind;
    int with_ammo = 0;
    int with_magazine = 0;
    std::string expected_error;
    SECTION( "multiple Mods append without replacing native entries" ) {
    }
    SECTION( "missing target rolls back the preceding Mod" ) {
        target = "ccb_platform_extension_missing";
        expected_error = "extend requires existing item group";
    }
    SECTION( "mismatched kind rolls back the preceding Mod" ) {
        extension_kind = collection ? "distribution" : "collection";
        expected_error = "must match the existing group kind";
    }
    SECTION( "extensions cannot override ammo defaults" ) {
        with_ammo = 25;
        expected_error = "may only append entries";
    }
    SECTION( "extensions cannot override magazine defaults" ) {
        with_magazine = 25;
        expected_error = "may only append entries";
    }
    consumer.write( std::filesystem::u8path( "main.lua" ), "local ccb = require('ccb')\n"
                    "local extension = ccb.content.ItemGroup { id = '" + target +
                    "', kind = '" + extension_kind + "', with_ammo = " + std::to_string( with_ammo ) +
                    ", with_magazine = " + std::to_string( with_magazine ) + " }\n"
                    "extension:item('stick', 100)\n"
                    "ccb.content.extend_item_group(extension)\n" );
    const bool prepared = cata::lua_platform::prepare_mods( {
        provider.source( "extension_provider" ), consumer.source( "extension_consumer" )
    }, error );
    const bool applied = prepared && cata::lua_platform::apply_prepared_content( error );
    CAPTURE( kind, error );
    if( expected_error.empty() ) {
        REQUIRE( applied );
        CHECK( original->entry_count() == 3 );
        CHECK( item_controller->get_group( group_id ) == original );
        CHECK( item_group::group_contains_item( group_id, itype_rock ) );
        CHECK( item_group::group_contains_item( group_id, itype_stick ) );
        CHECK( item_group::group_contains_item( group_id, itype_battery ) );
        if( collection ) {
            int battery_charges = 0;
            for( const item &spawned : item_group::items_from( group_id ) ) {
                if( spawned.typeId() == itype_battery ) {
                    battery_charges += spawned.charges;
                }
            }
            CHECK( battery_charges == 14 );
        }
    } else {
        CHECK_FALSE( applied );
        CHECK( error.find( expected_error ) != std::string::npos );
        // A later Mod's validation failure must already have undone prior appends.
        CHECK( original->entry_count() == 1 );
    }
    cata::lua_platform::discard_prepared_mods();
    CHECK( item_controller->get_group( group_id ) == original );
    CHECK( original->entry_count() == 1 );
    CHECK_FALSE( item_group::group_is_defined( Item_spawn_data_ccb_platform_extension_stock ) );
    CHECK_FALSE( item_group::group_contains_item( group_id, itype_stick ) );
    // Exercise distribution bookkeeping after truncating the appended entries.
    for( int trial = 0; trial < 8; ++trial ) {
        const std::vector<item> spawned = item_group::items_from( group_id );
        REQUIRE( spawned.size() == 1 );
        CHECK( spawned.front().typeId() == itype_rock );
    }
}

TEST_CASE( "lua_platform_item_group_extensions_can_target_earlier_mod_definitions",
           "[lua][platform][content][item_group]" )
{
    cata::lua_platform::shutdown();
    cuisine_test_mod provider( "extension_provider" );
    cuisine_test_mod consumer( "extension_consumer" );
    provider.write( std::filesystem::u8path( "main.lua" ), R"lua(
local ccb = require("ccb")
local group = ccb.content.ItemGroup { id = "ccb_platform_extended_group", kind = "collection" }
group:item("rock", 100)
ccb.content.add(group)
)lua" );
    consumer.write( std::filesystem::u8path( "main.lua" ), R"lua(
local ccb = require("ccb")
local extension = ccb.content.ItemGroup { id = "ccb_platform_extended_group", kind = "collection" }
extension:item("stick", 100)
ccb.content.extend_item_group(extension)
)lua" );
    std::string error;
    REQUIRE( cata::lua_platform::prepare_mods( {
        provider.source( "extension_provider" ), consumer.source( "extension_consumer" )
    }, error ) );
    REQUIRE( cata::lua_platform::apply_prepared_content( error ) );
    const item_group_id &group_id = Item_spawn_data_ccb_platform_extended_group;
    CHECK( item_group::group_contains_item( group_id, itype_rock ) );
    CHECK( item_group::group_contains_item( group_id, itype_stick ) );
    cata::lua_platform::discard_prepared_mods();
    CHECK_FALSE( item_group::group_is_defined( group_id ) );
}

TEST_CASE( "lua_platform_furniture_accepts_native_impassable_movement_costs",
           "[lua][platform][content][furniture]" )
{
    cata::lua_platform::shutdown();
    clear_map();
    const int movement = GENERATE( -10, -1, 0, 2 );
    cuisine_test_mod files( "furniture_movement" );
    files.write( std::filesystem::u8path( "main.lua" ), R"lua(
local ccb = require("ccb")
ccb.content.add(ccb.content.Furniture {
    id = "f_platform_movement_test", name = "Movement test", symbol = "6",
    color = "light_green", move_cost_mod = )lua" + std::to_string( movement ) + R"lua(,
})
)lua" );
    std::string error;
    REQUIRE( cata::lua_platform::prepare_mods( { files.source( "furniture_movement" ) }, error ) );
    REQUIRE( cata::lua_platform::apply_prepared_content( error ) );
    const furn_str_id &furniture = furn_f_platform_movement_test;
    REQUIRE( furniture.is_valid() );
    CHECK( furniture->movecost == movement );
    map &here = get_map();
    const tripoint_bub_ms position( 60, 60, 0 );
    const ter_id previous_terrain = here.ter( position );
    const furn_id previous_furniture = here.furn( position );
    {
        on_out_of_scope restore( [&here, position, previous_terrain, previous_furniture]() {
            here.furn_set( position, previous_furniture );
            here.ter_set( position, previous_terrain );
        } );
        here.ter_set( position, ter_t_floor.id() );
        here.furn_set( position, furniture.id() );
        CHECK( here.move_cost( position ) == ( movement < 0 ? 0 : 2 + movement ) );
    }
    cata::lua_platform::discard_prepared_mods();
    CHECK_FALSE( furniture.is_valid() );
}

TEST_CASE( "lua_platform_furniture_rejects_movement_cost_integer_overflow",
           "[lua][platform][content][furniture]" )
{
    cata::lua_platform::shutdown();
    const std::int64_t movement = GENERATE(
                                     static_cast<std::int64_t>( std::numeric_limits<int>::min() ) - 1,
                                     static_cast<std::int64_t>( std::numeric_limits<int>::max() ) + 1 );
    cuisine_test_mod files( "furniture_overflow" );
    files.write( std::filesystem::u8path( "main.lua" ), R"lua(
local ccb = require("ccb")
ccb.content.add(ccb.content.Furniture {
    id = "f_platform_overflow_test", name = "Invalid movement", symbol = "6",
    color = "light_green", move_cost_mod = )lua" + std::to_string( movement ) + R"lua(,
})
)lua" );
    std::string error;
    CHECK_FALSE( cata::lua_platform::prepare_mods( { files.source( "furniture_overflow" ) }, error ) );
    CHECK( error.find( "invalid ranges" ) != std::string::npos );
    CHECK_FALSE( furn_f_platform_overflow_test.is_valid() );
}

TEST_CASE( "lua_platform_vehicle_part_references_wait_for_native_finalization",
           "[lua][platform][content][vehicle]" )
{
    cata::lua_platform::shutdown();
    const vpart_id &turret = vpart_turret_laser_rifle;
    REQUIRE( turret.is_valid() );
    // The registry entry is erased below; the rollback snapshot must own a copy.
    const vpart_info saved_turret = turret.obj(); // NOLINT(performance-unnecessary-copy-initialization)
    auto &parts = cata::lua_platform::detail::vehicle_part_registry();
    on_out_of_scope cleanup( [&parts, &saved_turret]() {
        cata::lua_platform::shutdown();
        parts.restore( saved_turret );
    } );
    // Reproduce cold-load state: the gun exists, but native turret generation
    // has not run yet.  Do not run the global finalizers in this focused test.
    parts.erase( turret );
    REQUIRE_FALSE( turret.is_valid() );
    cuisine_test_mod files( "delayed_vehicle_parts" );
    files.write( std::filesystem::u8path( "main.lua" ), R"lua(
local ccb = require("ccb")
ccb.content.add(ccb.content.Vehicle {
    id = "ccb_platform_delayed_turret_vehicle", name = "Deferred turret vehicle",
    parts = {
        { x = 0, y = 0, part = "frame" },
        { x = 0, y = 0, part = "turret_mount" },
        { x = 0, y = 0, part = "turret_laser_rifle" },
    },
})
ccb.content.add(ccb.content.Vehicle {
    id = "ccb_platform_delayed_turret_extension",
    copy_from = "ccb_platform_delayed_turret_vehicle",
    patch = { extend_parts = {
        { x = 1, y = 0, part = "frame" },
        { x = 1, y = 0, part = "turret_mount" },
        { x = 1, y = 0, part = "turret_laser_rifle" },
    } },
})
)lua" );
    std::string error;
    REQUIRE( cata::lua_platform::prepare_mods( { files.source( "delayed_vehicle_parts" ) }, error ) );
    REQUIRE( cata::lua_platform::apply_prepared_content( error ) );
    const vproto_id &base = vehicle_prototype_ccb_platform_delayed_turret_vehicle;
    const vproto_id &extended = vehicle_prototype_ccb_platform_delayed_turret_extension;
    REQUIRE( base.is_valid() );
    REQUIRE( extended.is_valid() );
    CHECK( base->parts.size() == 3 );
    CHECK( extended->parts.size() == 6 );
    SECTION( "native generation resolves normal and extended placements" ) {
        parts.restore( saved_turret );
        REQUIRE( cata::lua_platform::validate_finalized_prepared_content( error ) );
        CHECK( base->parts.back().part == turret );
        CHECK( extended->parts.back().part == turret );
    }
    SECTION( "unresolved parts still reject and roll back the candidate" ) {
        CHECK_FALSE( cata::lua_platform::validate_finalized_prepared_content( error ) );
        CHECK( error.find( base.str() ) != std::string::npos );
        CHECK( error.find( turret.str() ) != std::string::npos );
        CHECK( error.find( "(0, 0)" ) != std::string::npos );
        CHECK_FALSE( base.is_valid() );
        CHECK_FALSE( extended.is_valid() );
    }
    cata::lua_platform::discard_prepared_mods();
    CHECK_FALSE( base.is_valid() );
    CHECK_FALSE( extended.is_valid() );
}

TEST_CASE( "lua_platform_vehicle_part_placement_ranges_are_checked_before_finalization",
           "[lua][platform][content][vehicle]" )
{
    cata::lua_platform::shutdown();
    const std::string invalid = GENERATE( std::string( "with_ammo = -1" ),
                                        std::string( "with_ammo = 101" ),
                                        std::string( "ammo_quantity = { 2, 1 }" ) );
    const bool patch = GENERATE( false, true );
    cuisine_test_mod files( "invalid_vehicle_placement" );
    const std::string placement = "{ x = 1, y = 2, part = 'turret_laser_rifle', " + invalid + " }";
    files.write( std::filesystem::u8path( "main.lua" ), "local ccb = require('ccb')\n"
                 "ccb.content.add(ccb.content.Vehicle { id = 'ccb_platform_invalid_placement', " +
                 ( patch ? "copy_from = 'car', patch = { extend_parts = { " + placement + " } }" :
                   "name = 'Invalid vehicle', parts = { " + placement + " }" ) + " })\n" );
    std::string error;
    CHECK_FALSE( cata::lua_platform::prepare_mods( { files.source( "invalid_vehicle_placement" ) }, error ) );
    CHECK( error.find( "turret_laser_rifle" ) != std::string::npos );
    CHECK( error.find( "(1, 2)" ) != std::string::npos );
    CHECK_FALSE( vehicle_prototype_ccb_platform_invalid_placement.is_valid() );
}

TEST_CASE( "lua_platform_monster_bootstrap_accepts_native_damage_and_catalog_references",
           "[lua][platform][content][monster]" )
{
    cata::lua_platform::shutdown();
    cuisine_test_mod files( "native_monster_references" );
    files.write( std::filesystem::u8path( "main.lua" ), R"lua(
local ccb = require("ccb")
local monster = ccb.content.Monster {
    id = "mon_platform_native_references", name = "Native reference test",
    symbol = "Z", color = "white", default_faction = "zombie",
    hp = 50, speed = 100, melee_dice = 0, melee_sides = 0,
}
monster:material("flesh", 1)
monster:species("ZOMBIE")
monster:melee_damage("bash", 22, 8)
monster:melee_damage("cut", 10, 5)
monster:armor("bash", 30)
monster:starting_ammo("battery", 2)
monster:regeneration_modifier("stunned", 1)
assert(not pcall(monster.melee_damage, monster, "bash", -1, 0))
assert(not pcall(monster.melee_damage, monster, "bash", 1, -1))
assert(not pcall(monster.melee_damage, monster, "bash", 0/0, 0))
assert(not pcall(monster.melee_damage, monster, "", 1, 0))
ccb.content.add(monster)
)lua" );
    std::string error;
    REQUIRE( cata::lua_platform::prepare_mods( { files.source( "native_monster_references" ) }, error ) );
    REQUIRE( cata::lua_platform::apply_prepared_content( error ) );
    const mtype_id &monster = mon_platform_native_references;
    REQUIRE( monster.is_valid() );
    CHECK( monster->melee_damage.type_damage( damage_bash ) == 22.0f );
    CHECK( monster->melee_damage.type_damage( damage_cut ) == 10.0f );
    CHECK( monster->armor.type_resist( damage_bash ) == 30.0f );
    for( const damage_unit &unit : monster->melee_damage.damage_units ) {
        if( unit.type == damage_bash ) {
            CHECK( unit.res_pen == 8.0f );
        } else if( unit.type == damage_cut ) {
            CHECK( unit.res_pen == 5.0f );
        }
    }
    CHECK( monster->starting_ammo.at( itype_battery ) == 2 );
    cata::lua_platform::discard_prepared_mods();
    CHECK_FALSE( monster.is_valid() );
}

TEST_CASE( "lua_platform_monster_unknown_references_are_rejected_before_apply",
           "[lua][platform][content][monster]" )
{
    cata::lua_platform::shutdown();
    const std::string reference = GENERATE(
                                     std::string( "melee_damage('missing_platform_damage', 22, 8)" ),
                                     std::string( "armor('missing_platform_damage', 30)" ),
                                     std::string( "species('missing_platform_species')" ),
                                     std::string( "starting_ammo('missing_platform_item', 2)" ),
                                     std::string( "regeneration_modifier('missing_platform_effect', 1)" ) );
    cuisine_test_mod files( "missing_monster_reference" );
    files.write( std::filesystem::u8path( "main.lua" ), R"lua(
local ccb = require("ccb")
local monster = ccb.content.Monster {
    id = "mon_platform_missing_reference", name = "Invalid reference test",
    symbol = "Z", color = "white", default_faction = "zombie",
    hp = 50, speed = 100,
}
monster:)lua" + reference + R"lua(
ccb.content.add(monster)
)lua" );
    std::string error;
    REQUIRE( cata::lua_platform::prepare_mods( { files.source( "missing_monster_reference" ) }, error ) );
    CHECK_FALSE( cata::lua_platform::apply_prepared_content( error ) );
    CHECK( error.find( "mon_platform_missing_reference" ) != std::string::npos );
    CHECK_FALSE( mon_platform_missing_reference.is_valid() );
}

TEST_CASE( "lua_platform_scenario_calendar_defaults_match_json",
           "[lua][platform][content][scenario][calendar]" )
{
    cata::lua_platform::shutdown();
    const int season_days = GENERATE( 91, 30, 73 );
    CAPTURE( season_days );
    override_option season_length( "SEASON_LENGTH", std::to_string( season_days ) );
    const string_id<scenario> &json_id = scenario_platform_calendar_json_reference;
    const string_id<scenario> &lua_id = scenario_platform_calendar_lua_scenario;
    REQUIRE_FALSE( json_id.is_valid() );
    REQUIRE_FALSE( lua_id.is_valid() );
    on_out_of_scope remove_reference( [&]() {
        cata::lua_platform::detail::scenario_registry().erase( json_id );
        cata::lua_platform::detail::scenario_registry().finalize();
    } );
    const JsonValue reference = json_loader::from_string( R"json({
        "id": "platform_calendar_json_reference",
        "name": "Calendar reference",
        "description": "A calendar test scenario.",
        "start_name": "Shelter",
        "points": 0,
        "allowed_locs": [ "sloc_shelter_safe" ]
    })json" );
    scenario::load_scenario( reference.get_object(), "test" );
    REQUIRE( json_id.is_valid() );
    const time_point expected_game = json_id->start_of_game();
    const time_point expected_cataclysm = json_id->start_of_cataclysm();

    cuisine_test_mod files( "scenario_calendar" );
    files.write( std::filesystem::u8path( "main.lua" ), R"lua(
local ccb = require("ccb")
local scenario = ccb.content.Scenario {
    id = "platform_calendar_lua_scenario",
    name = "Calendar test",
    description = "A calendar test scenario.",
    start_name = "Shelter",
}
scenario:location("sloc_shelter_safe")
ccb.content.add(scenario)
)lua" );
    std::string error;
    REQUIRE( cata::lua_platform::prepare_mods( { files.source( "scenario_calendar" ) }, error ) );
    REQUIRE( cata::lua_platform::apply_prepared_content( error ) );
    REQUIRE( lua_id.is_valid() );
    CHECK( lua_id->start_of_game() == expected_game );
    CHECK( lua_id->start_of_cataclysm() == expected_cataclysm );
    CHECK( expected_game == calendar::turn_zero + 1_days * ( season_days / 3 * 2 ) + 8_hours );
    CHECK( expected_game - expected_cataclysm == 5_days + 8_hours );

    // Character-creation edits remain possible; resetting restores the initialized defaults.
    lua_id->change_start_of_game( expected_game + 10_days );
    lua_id->change_start_of_cataclysm( expected_cataclysm + 2_days );
    CHECK( lua_id->start_of_game() == expected_game + 10_days );
    CHECK( lua_id->start_of_cataclysm() == expected_cataclysm + 2_days );
    lua_id->reset_calendar();
    CHECK( lua_id->start_of_game() == expected_game );
    CHECK( lua_id->start_of_cataclysm() == expected_cataclysm );

    cata::lua_platform::discard_prepared_mods();
    CHECK_FALSE( lua_id.is_valid() );
    CHECK( json_id->start_of_game() == expected_game );
    CHECK( json_id->start_of_cataclysm() == expected_cataclysm );
}

#endif
