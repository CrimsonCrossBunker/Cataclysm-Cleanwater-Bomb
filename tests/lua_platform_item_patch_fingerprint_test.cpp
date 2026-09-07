#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_support.h"

TEST_CASE( "lua_platform_item_patch_fingerprint_distinguishes_omitted_fields",
           "[lua][platform][content][reload]" )
{
    namespace platform = cata::lua_platform;
    platform::shutdown();
    const platform_lua_test_directory files;
    const on_out_of_scope cleanup( []() {
        platform::shutdown();
    } );
    const platform::mod_source source {
        "item-patch-fingerprint", files.root, files.root / "main.lua"
    };
    const auto fingerprint = [&]( const std::string &field ) {
        files.write( "main.lua", "local ccb = require('ccb')\n"
                     "ccb.content.add(ccb.content.Item { id = 'lua_patch_fingerprint_item', "
                     "copy_from = 'rock', " + field + " })\n" );
        std::string error;
        const bool prepared = platform::prepare_mods( { source }, error );
        INFO( error );
        REQUIRE( prepared );
        const std::string result = platform::prepared_content_fingerprint();
        platform::discard_prepared_mods();
        return result;
    };
    const std::string inherited = fingerprint( "" );
    REQUIRE_FALSE( inherited.empty() );
    CHECK( fingerprint( "" ) == inherited );
    // These explicit values equal the C++ defaults of omitted fields, but
    // applying them replaces rather than inherits the source item's values.
    for( const char *field : {
             "name = ''", "description = ''", "symbol = '?'", "mass_grams = 0",
             "volume_ml = 0", "price_cents = 0", "price_postapoc_cents = 0",
             "color = 'white'"
         } ) {
        INFO( field );
        const std::string overridden = fingerprint( field );
        CHECK( overridden != inherited );
        CHECK( fingerprint( field ) == overridden );
    }
}
#endif
