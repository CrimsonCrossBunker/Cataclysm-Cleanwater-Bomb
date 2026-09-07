#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_support.h"
#include "itype.h"
#include "translation.h"

TEST_CASE( "lua_platform_item_text_preserves_deferred_native_translations",
           "[lua][platform][content][translations]" )
{
    namespace platform = cata::lua_platform;
    platform::shutdown();
    const platform_lua_test_directory files;
    const on_out_of_scope cleanup( []() {
        platform::shutdown();
    } );
    files.write( "main.lua", R"lua(
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
    const platform::mod_source source { "item-text", files.root, files.root / "main.lua" };
    std::string error;
    const bool prepared = platform::prepare_mods( { source }, error );
    INFO( error );
    REQUIRE( prepared );
    REQUIRE( platform::apply_prepared_content( error ) );
    const translation expected_name = translation::pl_translation(
                                         "item name", "ccb text pebble", "ccb text pebbles" );
    const translation expected_description = translation::to_translation(
            "item description", "ccb text description" );
    const itype &parent = itype_id( "lua_text_translated_parent" ).obj();
    CHECK( parent.name == expected_name );
    CHECK( parent.description == expected_description );
    const itype &child = itype_id( "lua_text_translated_child" ).obj();
    CHECK( child.name == expected_name );
    CHECK( child.description == expected_description );
    const itype &literal = itype_id( "lua_text_literal_child" ).obj();
    CHECK( literal.name == translation::no_translation( "literal name" ) );
    CHECK( literal.description == expected_description );
    translation uncounted = translation::to_translation( "ccb text water" );
    uncounted.make_plural();
    CHECK( itype_id( "lua_text_same_plural" ).obj().name == uncounted );
    // Candidate application remains reversible, including translation objects.
    platform::discard_prepared_mods();
    CHECK_FALSE( itype_id( "lua_text_translated_parent" ).is_valid() );
    CHECK_FALSE( itype_id( "lua_text_translated_child" ).is_valid() );
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
    const platform::mod_source source { "item-text-hash", files.root, files.root / "main.lua" };
    const auto fingerprint = [&]( const std::string &name ) {
        files.write( "main.lua", "local ccb = require('ccb')\n"
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
#endif
