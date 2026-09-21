#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include <functional>
#include <memory>
#include <string>
#include <type_traits>

#include "cata_catch.h"
#include "lua_platform_sol.h"

TEST_CASE( "lua_platform_callback_gc_distinguishes_same_signature_closures",
           "[lua][platform][semantic][callbacks]" )
{
    const bool reverse_order = GENERATE( false, true );
    const bool explicit_collection = GENERATE( false, true );
    CAPTURE( reverse_order, explicit_collection );
    std::weak_ptr<int> lifetime;
    {
        sol::state lua;
        {
            const std::shared_ptr<int> token = std::make_shared<int>( 7 );
            lifetime = token;
            const std::function<int()> first = [token]() {
                return *token;
            };
            const std::function<int()> second = first;
            const std::function<int()> third = first;
            const auto large = [first, second, third]( sol::this_state ) {
                return first() + second() + third();
            };
            const auto small = [first]( sol::this_state ) {
                return first();
            };
            using large_storage = sol::function_detail::functor_function <
                                  std::decay_t<decltype( large )>, false, true >;
            using small_storage = sol::function_detail::functor_function <
                                  std::decay_t<decltype( small )>, false, true >;
            // Fail before installing a mismatched __gc destructor on old GCC builds.
            REQUIRE( sol::usertype_traits<large_storage>::user_gc_metatable() !=
                     sol::usertype_traits<small_storage>::user_gc_metatable() );
            if( reverse_order ) {
                lua.set_function( "small", small );
                lua.set_function( "large", large );
            } else {
                lua.set_function( "large", large );
                lua.set_function( "small", small );
            }
        }
        REQUIRE_FALSE( lifetime.expired() );
        {
            const sol::protected_function large = lua["large"];
            const sol::protected_function small = lua["small"];
            const sol::protected_function_result large_result = large();
            const sol::protected_function_result small_result = small();
            REQUIRE( large_result.valid() );
            REQUIRE( small_result.valid() );
            CHECK( large_result.get<int>() == 21 );
            CHECK( small_result.get<int>() == 7 );
        }
        if( explicit_collection ) {
            lua["large"] = sol::nil;
            lua["small"] = sol::nil;
            lua.collect_garbage();
            lua.collect_garbage();
            CHECK( lifetime.expired() );
        } else {
            CHECK_FALSE( lifetime.expired() );
        }
    }
    CHECK( lifetime.expired() );
}
#endif
