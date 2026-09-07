#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_support.h"
#include "profession.h"

namespace
{
struct profession_test_mod : platform_lua_test_directory {
    ~profession_test_mod() {
        cata::lua_platform::shutdown();
    }
    cata::lua_platform::mod_source source( const std::string &id ) const {
        return { id, root, root / "main.lua" };
    }
};
} // namespace

TEST_CASE( "lua_platform_profession_resolves_staged_traits",
           "[lua][platform][content][profession]" )
{
    cata::lua_platform::shutdown();
    profession_test_mod files;
    const bool invalid_variant = GENERATE( false, true );
    files.write( "main.lua", std::string( R"lua(
local ccb = require("ccb")
local profession = ccb.content.Profession {
    id = "platform_staged_trait_profession", name = "Staged trait profession",
    description = "Exercises same-transaction trait references.", points = 0,
}
profession:trait("platform_staged_trait", ")lua" ) +
                 ( invalid_variant ? "missing" : "golden" ) + R"lua(")
profession:forbid_trait("platform_staged_forbidden")
ccb.content.add(profession)
-- Deliberately declare the referenced mutations after the profession.
local mutation = ccb.content.Mutation {
    id = "platform_staged_trait", name = "Staged trait",
    description = "A mutation declared in the same transaction.",
}
mutation:variant { id = "golden", name = "Golden", description = "Golden fur.", weight = 1 }
ccb.content.add(mutation)
ccb.content.add(ccb.content.Mutation {
    id = "platform_staged_forbidden", name = "Forbidden staged trait",
    description = "A forbidden mutation declared in the same transaction.",
})
)lua" );
    std::string error;
    REQUIRE( cata::lua_platform::prepare_mods( { files.source( "profession_staged_traits" ) },
            error ) );
    CAPTURE( error );
    REQUIRE( cata::lua_platform::apply_prepared_content( error ) );
    const profession_id id( "platform_staged_trait_profession" );
    REQUIRE( id.is_valid() );
    if( invalid_variant ) {
        CHECK_FALSE( cata::lua_platform::validate_finalized_prepared_content( error ) );
        CHECK( error.find( "invalid finalized trait" ) != std::string::npos );
    } else {
        REQUIRE( cata::lua_platform::validate_finalized_prepared_content( error ) );
        const auto traits = id->get_locked_traits();
        REQUIRE( traits.size() == 1 );
        CHECK( traits.front().trait == trait_id( "platform_staged_trait" ) );
        CHECK( traits.front().variant == "golden" );
        CHECK( id->get_forbidden_traits().count( trait_id( "platform_staged_forbidden" ) ) == 1 );
    }
    cata::lua_platform::discard_prepared_mods();
    CHECK_FALSE( id.is_valid() );
    CHECK_FALSE( trait_id( "platform_staged_trait" ).is_valid() );
    CHECK_FALSE( trait_id( "platform_staged_forbidden" ).is_valid() );
}

TEST_CASE( "lua_platform_profession_rejects_invalid_trait_references",
           "[lua][platform][content][profession]" )
{
    cata::lua_platform::shutdown();
    profession_test_mod files;
    std::string references;
    SECTION( "unknown starting trait" ) {
        references = "profession:trait('platform_missing_trait', '')";
    }
    SECTION( "unknown forbidden trait" ) {
        references = "profession:forbid_trait('platform_missing_trait')";
    }
    SECTION( "duplicate staged trait" ) {
        references = "profession:trait('platform_staged_trait', '')\n"
                     "profession:trait('platform_staged_trait', '')";
    }
    SECTION( "contradictory staged trait" ) {
        references = "profession:trait('platform_staged_trait', '')\n"
                     "profession:forbid_trait('platform_staged_trait')";
    }
    files.write( "main.lua", std::string( R"lua(
local ccb = require("ccb")
ccb.content.add(ccb.content.Mutation {
    id = "platform_staged_trait", name = "Staged trait", description = "Test trait.",
})
local profession = ccb.content.Profession {
    id = "platform_invalid_trait_profession", name = "Invalid trait profession",
    description = "Must be rejected without publishing content.", points = 0,
}
)lua" ) + references + "\nccb.content.add(profession)\n" );
    std::string error;
    const bool prepared = cata::lua_platform::prepare_mods(
    { files.source( "profession_invalid_traits" ) }, error );
    const bool applied = prepared && cata::lua_platform::apply_prepared_content( error );
    CHECK_FALSE( applied );
    CHECK( error.find( "trait" ) != std::string::npos );
    cata::lua_platform::discard_prepared_mods();
    CHECK_FALSE( profession_id( "platform_invalid_trait_profession" ).is_valid() );
    CHECK_FALSE( trait_id( "platform_staged_trait" ).is_valid() );
}

#endif
