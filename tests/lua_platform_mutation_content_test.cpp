#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <filesystem>
#include <string>

#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "lua_platform_loader.h"
#include "lua_platform_test_support.h"
#include "mutation.h"
#include "type_id.h"

TEST_CASE( "lua_platform_mutation_content_keeps_array_visitor_alive",
           "[lua][platform][content][mutations]" )
{
    namespace platform = cata::lua_platform;
    platform::shutdown();
    const platform_lua_test_directory files;
    const on_out_of_scope cleanup( []() {
        platform::shutdown();
    } );
    files.write( std::filesystem::u8path( "main.lua" ), R"lua(
local ccb = require("ccb")

ccb.content.add(ccb.content.MutationCategory {
    id = "lua_probe_category",
    name = "Probe category",
    skip_consistency_test = true,
})

ccb.content.add(ccb.content.Mutation {
    id = "lua_probe_trait",
    name = "Probe trait",
    description = "Probe mutation",
    categories = { "lua_probe_category" },
    flags = { "NO_THIRST" },
    variants = {
        { id = "lua_probe_variant", name = "Probe variant" },
    },
    valid = false,
})
)lua" );
    const platform::mod_source source {
        "mutation-array-visitor", files.root,
        files.root / std::filesystem::u8path( "main.lua" )
    };
    std::string error;
    INFO( error );
    REQUIRE( platform::prepare_mods( { source }, error ) );
    REQUIRE( platform::apply_prepared_content( error ) );

    const mutation_category_id category( "lua_probe_category" );
    const trait_id trait( "lua_probe_trait" );
    REQUIRE( mutation_category_is_valid( category ) );
    REQUIRE( trait.is_valid() );
    CHECK( std::find( trait->category.begin(), trait->category.end(), category ) !=
           trait->category.end() );
    CHECK( trait->variants.count( "lua_probe_variant" ) == 1 );

    platform::discard_prepared_mods();
    CHECK_FALSE( mutation_category_is_valid( category ) );
    CHECK_FALSE( trait.is_valid() );
}

#endif
