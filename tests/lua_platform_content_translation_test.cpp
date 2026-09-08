#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_support.h"
#include "itype.h"
#include "skill.h"
#include "translation.h"

static const itype_id itype_lua_text_literal_child( "lua_text_literal_child" );
static const itype_id itype_lua_text_same_plural( "lua_text_same_plural" );
static const itype_id itype_lua_text_translated_child( "lua_text_translated_child" );
static const itype_id itype_lua_text_translated_parent( "lua_text_translated_parent" );
static const skill_displayType_id
SkillDisplayType_lua_translated_skill_display( "lua_translated_skill_display" );
static const skill_id skill_lua_translated_skill( "lua_translated_skill" );

TEST_CASE( "lua_platform_item_text_preserves_deferred_native_translations",
           "[lua][platform][content][translations]" )
{
    namespace platform = cata::lua_platform;
    platform::shutdown();
    const platform_lua_test_directory files;
    const on_out_of_scope cleanup( []() {
        platform::shutdown();
    } );
    files.write( std::filesystem::u8path( "main.lua" ), R"lua(
local ccb = require("ccb")
assert(not pcall(ccb.content.text, ""))
assert(not pcall(ccb.content.text, "a\0b"))
assert(not pcall(ccb.content.text, "source", "a\0b"))
assert(not pcall(ccb.content.plural_text, "source", ""))
assert(not pcall(ccb.content.plural_text, "source", "a\0b"))
assert(not pcall(ccb.content.Item, {
    id = "lua_text_invalid_description",
    description = ccb.content.plural_text("one", "many")
}))
ccb.content.add(ccb.content.Item {
    id = "lua_text_translated_parent", mass_grams = 1, volume_ml = 1,
    name = ccb.content.plural_text("ccb text pebble", "ccb text pebbles", "item name"),
    description = ccb.content.text("ccb text description", "item description")
})
ccb.content.add(ccb.content.Item {
    id = "lua_text_translated_child", copy_from = "lua_text_translated_parent"
})
ccb.content.add(ccb.content.Item {
    id = "lua_text_literal_child", copy_from = "lua_text_translated_parent", name = "literal name"
})
ccb.content.add(ccb.content.Item {
    id = "lua_text_same_plural", copy_from = "lua_text_translated_parent",
    name = ccb.content.text("ccb text water")
})
)lua" );
    const platform::mod_source source { "item-text", files.root, files.root / std::filesystem::u8path( "main.lua" ) };
    std::string error;
    const bool prepared = platform::prepare_mods( { source }, error );
    INFO( error );
    REQUIRE( prepared );
    REQUIRE( platform::apply_prepared_content( error ) );
    const translation expected_name = translation::pl_translation(
                                          "item name", "ccb text pebble", "ccb text pebbles" );
    const translation expected_description = translation::to_translation(
            "item description", "ccb text description" );
    const itype &parent = itype_lua_text_translated_parent.obj();
    CHECK( parent.nname( 1 ) == expected_name.translated( 1 ) );
    CHECK( parent.nname( 2 ) == expected_name.translated( 2 ) );
    CHECK( parent.description == expected_description );
    const itype &child = itype_lua_text_translated_child.obj();
    CHECK( child.nname( 1 ) == expected_name.translated( 1 ) );
    CHECK( child.nname( 2 ) == expected_name.translated( 2 ) );
    CHECK( child.description == expected_description );
    const itype &literal = itype_lua_text_literal_child.obj();
    CHECK( literal.nname( 1 ) == "literal name" );
    CHECK( literal.nname( 2 ) == "literal name" );
    CHECK( literal.description == expected_description );
    translation uncounted = translation::to_translation( "ccb text water" );
    uncounted.make_plural();
    CHECK( itype_lua_text_same_plural.obj().nname( 1 ) == uncounted.translated( 1 ) );
    CHECK( itype_lua_text_same_plural.obj().nname( 2 ) == uncounted.translated( 2 ) );
    // Candidate application remains reversible, including translation objects.
    platform::discard_prepared_mods();
    CHECK_FALSE( itype_lua_text_translated_parent.is_valid() );
    CHECK_FALSE( itype_lua_text_translated_child.is_valid() );
}

TEST_CASE( "lua_platform_item_text_fingerprints_translation_semantics",
           "[lua][platform][content][translations][reload]" )
{
    namespace platform = cata::lua_platform;
    platform::shutdown();
    const platform_lua_test_directory files;
    const on_out_of_scope cleanup( []() {
        platform::shutdown();
    } );
    const platform::mod_source source { "item-text-hash", files.root, files.root / std::filesystem::u8path( "main.lua" ) };
    const auto fingerprint = [&]( const std::string & name ) {
        files.write( std::filesystem::u8path( "main.lua" ), "local ccb = require('ccb')\n"
                     "ccb.content.add(ccb.content.Item { id = 'lua_text_hash', "
                     "copy_from = 'rock', name = " + name + " })\n" );
        std::string error;
        const bool prepared = platform::prepare_mods( { source }, error );
        INFO( error );
        REQUIRE( prepared );
        const std::string value = platform::prepared_content_fingerprint();
        platform::discard_prepared_mods();
        return value;
    };
    const std::string literal = fingerprint( "'stone'" );
    const std::string marked = fingerprint( "ccb.content.text('stone')" );
    CHECK( marked != literal );
    CHECK( fingerprint( "ccb.content.text('stone')" ) == marked );
    CHECK( fingerprint( "ccb.content.text('stone', '')" ) != marked );
    CHECK( fingerprint( "ccb.content.text('stone', 'name')" ) !=
           fingerprint( "ccb.content.text('stone', 'material')" ) );
    CHECK( fingerprint( "ccb.content.plural_text('stone', 'stones')" ) !=
           fingerprint( "ccb.content.plural_text('stone', 'stone pieces')" ) );
}

TEST_CASE( "lua_platform_skill_text_accepts_deferred_markers_and_rolls_back",
           "[lua][platform][content][translations]" )
{
    namespace platform = cata::lua_platform;
    platform::shutdown();
    const platform_lua_test_directory files;
    const on_out_of_scope cleanup( []() {
        platform::shutdown();
    } );
    files.write( std::filesystem::u8path( "main.lua" ), R"lua(
local ccb = require("ccb")
local plural = ccb.content.plural_text("one", "many")
assert(not pcall(ccb.content.SkillDisplay, {id="bad_label", label=plural}))
assert(not pcall(ccb.content.Skill, {id="bad_name", name=plural, description="text"}))
assert(not pcall(ccb.content.Skill, {id="bad_description", description=plural}))
ccb.content.add(ccb.content.SkillDisplay {
    id = "lua_translated_skill_display", label = ccb.content.text("ccb skill category", "skill category")
})
local skill = ccb.content.Skill {
    id = "lua_translated_skill", name = ccb.content.text("ccb skill name", "skill name"),
    description = ccb.content.text("ccb skill description", "skill description"),
    display_category = "lua_translated_skill_display"
}
skill:level_description(1, ccb.content.text("ccb skill theory", "skill theory"),
                          ccb.content.text("ccb skill practice", "skill practice"))
assert(not pcall(function() skill:level_description(1, "must not replace", plural) end))
assert(not pcall(function() skill:level_description_practice(2, plural) end))
skill:level_description_practice(2, ccb.content.text("ccb advanced practice", "skill practice"))
skill:level_description(3, ccb.content.text("marked then replaced"))
skill:level_description(3, "literal theory")
ccb.content.add(skill)
)lua" );
    std::string error;
    const bool prepared = platform::prepare_mods( {
        { "skill-text", files.root, files.root / std::filesystem::u8path( "main.lua" ) }
    }, error );
    INFO( error );
    REQUIRE( prepared );
    REQUIRE( platform::apply_prepared_content( error ) );
    REQUIRE( skill_lua_translated_skill.is_valid() );
    CHECK( skill_lua_translated_skill.obj().name() == "ccb skill name" );
    CHECK( skill_lua_translated_skill.obj().description() == "ccb skill description" );
    CHECK( SkillDisplayType_lua_translated_skill_display.obj().display_string() ==
           "ccb skill category" );
    CHECK( skill_lua_translated_skill.obj().get_level_description( 1, false ) == "ccb skill theory" );
    CHECK( skill_lua_translated_skill.obj().get_level_description( 1, true ) == "ccb skill practice" );
    CHECK( skill_lua_translated_skill.obj().get_level_description( 2, true ) == "ccb advanced practice" );
    CHECK( skill_lua_translated_skill.obj().get_level_description( 3, false ) == "literal theory" );
    platform::discard_prepared_mods();
    CHECK_FALSE( skill_lua_translated_skill.is_valid() );
    CHECK_FALSE( SkillDisplayType_lua_translated_skill_display.is_valid() );
}

TEST_CASE( "lua_platform_skill_text_context_changes_static_fingerprints",
           "[lua][platform][content][translations][reload]" )
{
    namespace platform = cata::lua_platform;
    platform::shutdown();
    const platform_lua_test_directory files;
    const on_out_of_scope cleanup( []() {
        platform::shutdown();
    } );
    const auto fingerprint = [&]( const std::string & text, const std::string &configure = "" ) {
        files.write( std::filesystem::u8path( "main.lua" ), "local ccb = require('ccb')\n"
                     "local skill = ccb.content.Skill {id='lua_skill_text_hash', "
                     "name=" + text + ", description='description'}\n" +
                     configure + "\nccb.content.add(skill)\n" );
        std::string error;
        const bool prepared = platform::prepare_mods( {
            { "skill-text-hash", files.root, files.root / std::filesystem::u8path( "main.lua" ) }
        }, error );
        INFO( error );
        REQUIRE( prepared );
        const std::string result = platform::prepared_content_fingerprint();
        platform::discard_prepared_mods();
        return result;
    };
    CHECK( fingerprint( "'same source'", "skill:level_description(1, 'same text')" ) !=
           fingerprint( "'same source'", "skill:level_description_practice(1, 'same text')" ) );
    const std::string marked = fingerprint( "ccb.content.text('same source')" );
    CHECK( fingerprint( "ccb.content.text('same source')" ) == marked );
    CHECK( fingerprint( "'same source'" ) != marked );
    CHECK( fingerprint( "ccb.content.text('same source', '')" ) != marked );
    CHECK( fingerprint( "ccb.content.text('same source', 'skill name')" ) !=
           fingerprint( "ccb.content.text('same source', 'other context')" ) );
}
#endif
