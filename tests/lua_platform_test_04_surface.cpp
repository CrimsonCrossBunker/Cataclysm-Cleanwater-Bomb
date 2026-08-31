#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_support.h"

namespace
{

TEST_CASE( "lua_platform_dialogue_context_has_no_legacy_trade_helpers",
           "[lua][platform][dialogue][trade]" )
{
    using context = cata::lua_platform::dialogue::context;
    CHECK_FALSE( has_legacy_dialogue_quote_trade_item<context>::value );
    CHECK_FALSE( has_legacy_dialogue_buy_quoted_item<context>::value );
}

TEST_CASE( "lua_platform_trade_root_exposes_only_explicit_quote_get_commit",
           "[lua][platform][trade][contract]" )
{
    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_trade_api(
        services,
        []() {
        return cata::lua_platform::game_handle_runtime();
    },
    []() {
        return std::size_t( 1 );
    },
    []() {},
    []() {} );

    const sol::table trade = services["trade"];
    REQUIRE( trade.valid() );
    const std::set<std::string> expected = { "commit", "get", "quote" };
    std::set<std::string> exposed;
    for( const auto &entry : trade ) {
        REQUIRE( entry.first.is<std::string>() );
        exposed.insert( entry.first.as<std::string>() );
    }
    CHECK( exposed == expected );
    CHECK( trade["quote"].valid() );
    CHECK( trade["get"].valid() );
    CHECK( trade["commit"].valid() );
    CHECK_FALSE( trade["transfer"].valid() );
    CHECK_FALSE( trade["transfer_matching"].valid() );
    CHECK_FALSE( trade["open"].valid() );
    CHECK_FALSE( trade["pay"].valid() );
    CHECK_FALSE( trade["settle"].valid() );
    CHECK_FALSE( trade["settle_credit"].valid() );
    CHECK_FALSE( trade["buy_monsters"].valid() );
    CHECK_FALSE( trade["matching_stock"].valid() );
    CHECK_FALSE( trade["cash_to_favor"].valid() );
    CHECK_FALSE( trade["settle_faction_account"].valid() );
    CHECK_FALSE( trade["balance"].valid() );
    CHECK_FALSE( trade["set_balance"].valid() );
    CHECK_FALSE( trade["adjust_balance"].valid() );
}

} // namespace

#endif // CATA_ENABLE_LUA_PLATFORM
