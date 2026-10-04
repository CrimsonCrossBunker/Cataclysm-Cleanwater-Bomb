#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_support.h"
#include "effect.h"
#include "item.h"
#include "item_group.h"
#include "itype.h"
#include "translation.h"

TEST_CASE( "lua_platform_effect_definitions_preserve_native_symptoms_and_death_rules",
           "[lua][platform][content][effects]" )
{
    namespace platform = cata::lua_platform;
    platform::shutdown();
    const platform_lua_test_directory files;
    const on_out_of_scope cleanup( []() {
        platform::shutdown();
    } );
    files.write( std::filesystem::u8path( "main.lua" ), R"lua(
local ccb = require("ccb")
local virus = ccb.content.EffectType {
    id = "lua_effect_symptoms", name = "", description = "",
    maximum_intensity = 4, intensity_decay_step = 1, intensity_decay_tick = 86400,
    rating = "bad", harmful_cough = true,
    apply_message = ccb.content.text("Infection begins."),
    death_message = ccb.content.text("Infection ends."), death_event = "dies_of_infection",
}
for i = 2, 4 do
    virus:name("Stage " .. i):description("Description " .. i)
end
for i = 1, 4 do
    virus:death_chance { numerator = i == 4 and 1 or 0, denominator = 1,
                        resisted_numerator = 0, resisted_denominator = 1 }
end
assert(not pcall(function()
    virus:death_chance { numerator = 1, denominator = 0,
                        resisted_numerator = 0, resisted_denominator = 1 }
end))
assert(not pcall(function() virus:modifier("cough", "minimum", {}) end))
assert(not pcall(function() virus:modifier("pain", "minimum", {base = math.huge}) end))
virus:modifier("cough", "chance_numerator", {
    base = -10, per_intensity = 5.5, resisted_base = -10, resisted_per_intensity = 3.5,
})
virus:modifier("cough", "chance_denominator", {
    base = 1000, per_intensity = 1, resisted_base = 10000, resisted_per_intensity = 5,
})
virus:modifier("pain", "minimum", {base = 1, resisted_base = 0})
ccb.content.add(virus)
)lua" );
    const platform::mod_source source { "effect-definition", files.root, files.root / std::filesystem::u8path( "main.lua" ) };
    std::string error;
    INFO( error );
    REQUIRE( platform::prepare_mods( { source }, error ) );
    REQUIRE( platform::apply_prepared_content( error ) );
    const efftype_id id( "lua_effect_symptoms" );
    {
        const effect_type &native = id.obj();
        CHECK( native.use_name_ints() );
        CHECK( native.use_desc_ints( false ) );
        CHECK( native.get_rating() == m_bad );
        CHECK( native.get_mod_value( "COUGH", mod_action::CHANCE_TOP, 0, 4 ) == 6.5 );
        CHECK( native.get_mod_value( "COUGH", mod_action::CHANCE_TOP, 1, 4 ) == 0.5 );
        CHECK( native.get_mod_value( "COUGH", mod_action::CHANCE_BOT, 0, 4 ) == 1003 );
        CHECK( native.get_mod_value( "COUGH", mod_action::CHANCE_BOT, 1, 4 ) == 10015 );
        CHECK( native.get_mod_value( "PAIN", mod_action::MIN, 0, 4 ) == 1 );
        effect infection( &native );
        infection.set_intensity( 1 );
        CHECK_FALSE( infection.kill_roll( false ) );
        infection.set_intensity( 4 );
        CHECK( infection.kill_roll( false ) );
        CHECK_FALSE( infection.kill_roll( true ) );
        CHECK( infection.get_harmful_cough() );
        CHECK( infection.death_event() == event_type::dies_of_infection );
        CHECK( infection.get_death_message() == to_translation( "Infection ends." ).translated() );
    }
    platform::discard_prepared_mods();
    CHECK_FALSE( id.is_valid() );
}

TEST_CASE( "lua_platform_medicine_group_wraps_counted_doses_once",
           "[lua][platform][content][items]" )
{
    namespace platform = cata::lua_platform;
    platform::shutdown();
    const platform_lua_test_directory files;
    const on_out_of_scope cleanup( []() {
        platform::shutdown();
    } );
    files.write( std::filesystem::u8path( "main.lua" ), R"lua(
local ccb = require("ccb")
local medicine = ccb.content.Item {
    id = "lua_packaged_medicine", mass_grams = 1, volume_ml = 1,
    default_container = "bottle_plastic_pill_prescription",
}
medicine:comestible {type = "MED"}
ccb.content.add(medicine)
local group = ccb.content.ItemGroup {id = "lua_medicine_group"}
group:entry {item = "lua_packaged_medicine", count = {3, 3}, container = "null",
             wrapper = "bottle_plastic_pill_prescription"}
ccb.content.add(group)
)lua" );
    const platform::mod_source source { "medicine-group", files.root, files.root / std::filesystem::u8path( "main.lua" ) };
    std::string error;
    INFO( error );
    REQUIRE( platform::prepare_mods( { source }, error ) );
    REQUIRE( platform::apply_prepared_content( error ) );
    const itype_id medicine_id( "lua_packaged_medicine" );
    const item_group_id group_id( "lua_medicine_group" );
    CHECK( medicine_id->comestible->comesttype == "MED" );
    CHECK( medicine_id->comestible->def_charges == 0 );
    CHECK( medicine_id->default_container == itype_id( "bottle_plastic_pill_prescription" ) );
    {
        const auto items = item_group::items_from( group_id );
        REQUIRE( items.size() == 1 );
        CHECK( items.front().typeId() == itype_id( "bottle_plastic_pill_prescription" ) );
        const auto contents = items.front().all_items_top();
        REQUIRE( contents.size() == 3 );
        for( const item *dose : contents ) {
            CHECK( dose->typeId() == medicine_id );
            CHECK_FALSE( dose->count_by_charges() );
        }
    }
    platform::discard_prepared_mods();
    CHECK_FALSE( medicine_id.is_valid() );
    CHECK_FALSE( item_group::group_is_defined( group_id ) );
}

TEST_CASE( "lua_platform_effect_modifier_fingerprints_retain_fractional_precision",
           "[lua][platform][content][effects]" )
{
    namespace platform = cata::lua_platform;
    platform::shutdown();
    const platform_lua_test_directory files;
    const on_out_of_scope cleanup( []() {
        platform::shutdown();
    } );
    const platform::mod_source source { "effect-fingerprint", files.root, files.root / std::filesystem::u8path( "main.lua" ) };
    const auto fingerprint = [&]( const std::string & base ) {
        files.write( std::filesystem::u8path( "main.lua" ),
                     "local ccb = require('ccb')\n"
                     "local effect = ccb.content.EffectType {id = 'lua_precise_modifier'}\n"
                     "effect:modifier('pain', 'minimum', {base = " + base + "})\n"
                     "ccb.content.add(effect)\n" );
        std::string error;
        INFO( error );
        REQUIRE( platform::prepare_mods( { source }, error ) );
        const std::string result = platform::prepared_content_fingerprint();
        platform::discard_prepared_mods();
        return result;
    };
    CHECK( fingerprint( "1.0000001" ) != fingerprint( "1.0000002" ) );
    CHECK( fingerprint( "1.0000001" ) == fingerprint( "1.0000001" ) );
}
#endif
