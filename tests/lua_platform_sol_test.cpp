#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <memory>
#include <string>
#include <utility>

#include "cata_catch.h"
#include "lua_platform_sol.h"

TEST_CASE( "lua_platform_callbacks_destroy_their_own_capture_layout",
           "[lua][platform][semantic]" )
{
    const bool small_first = GENERATE( false, true );
    std::weak_ptr<int> first_lifetime;
    std::weak_ptr<int> second_lifetime;
    std::weak_ptr<int> third_lifetime;
    {
        sol::state lua;
        auto first = std::make_shared<int>( 1 );
        auto second = std::make_shared<int>( 2 );
        auto third = std::make_shared<int>( 3 );
        first_lifetime = first;
        second_lifetime = second;
        third_lifetime = third;
        auto large = [first, second, third]( int input ) {
            return *first + *second + *third + input;
        };
        auto small = [first]( int input ) {
            return *first + input;
        };
        if( small_first ) {
            lua.set_function( "small", std::move( small ) );
            lua.set_function( "large", std::move( large ) );
        } else {
            lua.set_function( "large", std::move( large ) );
            lua.set_function( "small", std::move( small ) );
        }
        first.reset();
        second.reset();
        third.reset();
        {
            sol::protected_function large_call = lua["large"];
            sol::protected_function small_call = lua["small"];
            const sol::protected_function_result large_result = large_call( 4 );
            const sol::protected_function_result small_result = small_call( 4 );
            REQUIRE( large_result.valid() );
            REQUIRE( small_result.valid() );
            CHECK( large_result.get<int>() == 10 );
            CHECK( small_result.get<int>() == 5 );
        }
        SECTION( "garbage collection releases both layouts" ) {
            lua["large"] = sol::nil;
            lua["small"] = sol::nil;
            lua.collect_garbage();
            CHECK( first_lifetime.expired() );
            CHECK( second_lifetime.expired() );
            CHECK( third_lifetime.expired() );
        }
        SECTION( "state destruction releases both layouts" ) {}
    }
    CHECK( first_lifetime.expired() );
    CHECK( second_lifetime.expired() );
    CHECK( third_lifetime.expired() );
}

#endif
