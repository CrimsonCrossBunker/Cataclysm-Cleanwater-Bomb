#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include "cata_catch.h"

#include <atomic>
#include <cstddef>
#include <functional>
#include <initializer_list>
#include <memory>
#include <type_traits>
#include <utility>

#include "lua_platform_sol.h"

namespace
{

std::atomic<int> first_capture_destructions{ 0 };
std::atomic<int> second_capture_destructions{ 0 };

struct first_capture {
    unsigned char marker = 1;

    ~first_capture() {
        first_capture_destructions.fetch_add( 1, std::memory_order_relaxed );
    }
};

struct second_capture {
    unsigned char marker = 2;

    ~second_capture() {
        second_capture_destructions.fetch_add( 1, std::memory_order_relaxed );
    }
};

template<bool IsYielding, bool NoTrampoline>
bool distinct_functor_gc_keys_for_equal_and_different_layouts()
{
    std::function<int()> current_runtime_generation = [] {
        return 1;
    };
    std::function<std::size_t()> current_world_generation = [] {
        return 2;
    };
    std::function<void()> require_read = [] {};

    auto large_callback = [current_runtime_generation, current_world_generation,
                                require_read]( sol::this_state state ) -> int {
        ( void )state;
        ( void )current_runtime_generation();
        ( void )current_world_generation();
        require_read();
        return 0;
    };
    auto small_callback = [require_read]( sol::this_state state ) -> int {
        ( void )state;
        require_read();
        return 0;
    };

    using large_functor = sol::function_detail::functor_function <
                          decltype( large_callback ), IsYielding, NoTrampoline >;
    using small_functor = sol::function_detail::functor_function <
                          decltype( small_callback ), IsYielding, NoTrampoline >;

    auto first_callback = [captured = first_capture{}]( sol::this_state state ) -> int {
        ( void )state;
        ( void )captured.marker;
        return 0;
    };
    auto second_callback = [captured = second_capture{}]( sol::this_state state ) -> int {
        ( void )state;
        ( void )captured.marker;
        return 0;
    };

    using first_functor = sol::function_detail::functor_function <
                          decltype( first_callback ), IsYielding, NoTrampoline >;
    using second_functor = sol::function_detail::functor_function <
                           decltype( second_callback ), IsYielding, NoTrampoline >;

    static_assert( !std::is_same_v<large_functor, small_functor> );
    static_assert( !std::is_same_v<first_functor, second_functor> );
    static_assert( sizeof( large_functor ) > sizeof( small_functor ) );
    static_assert( sizeof( first_functor ) == sizeof( second_functor ) );

    return sol::usertype_traits<large_functor>::user_gc_metatable() !=
           sol::usertype_traits<small_functor>::user_gc_metatable() &&
           sol::usertype_traits<first_functor>::user_gc_metatable() !=
           sol::usertype_traits<second_functor>::user_gc_metatable();
}

struct shared_capture_targets {
    std::weak_ptr<int> runtime_generation;
    std::weak_ptr<int> world_generation;
    std::weak_ptr<int> require_read;
};

struct capture_lifetime_result {
    bool keys_are_distinct = false;
    bool captures_are_alive_before_cleanup = false;
    bool captures_are_released_after_cleanup = false;
};

capture_lifetime_result exercise_large_and_small_callbacks( const bool large_first,
        const bool collect_before_state_close )
{
    capture_lifetime_result result;
    shared_capture_targets targets;
    {
        sol::state lua;
        {
            std::shared_ptr<int> runtime_target = std::make_shared<int>( 1 );
            std::shared_ptr<int> world_target = std::make_shared<int>( 2 );
            std::shared_ptr<int> read_target = std::make_shared<int>( 3 );
            targets.runtime_generation = runtime_target;
            targets.world_generation = world_target;
            targets.require_read = read_target;

            std::function<int()> current_runtime_generation = [target = std::move(
                   runtime_target )]() {
                return *target;
            };
            std::function<std::size_t()> current_world_generation = [target = std::move(
                   world_target )]() {
                return static_cast<std::size_t>( *target );
            };
            std::function<void()> require_read = [target = std::move( read_target )]() {
                ( void )target;
            };

            auto visible_allies = [current_runtime_generation, current_world_generation,
                                        require_read]( sol::this_state state ) -> int {
                ( void )state;
                ( void )current_runtime_generation();
                ( void )current_world_generation();
                require_read();
                return 0;
            };
            auto ai_rule_catalog = [require_read]( sol::this_state state ) -> int {
                ( void )state;
                require_read();
                return 0;
            };

            using visible_allies_functor = sol::function_detail::functor_function <
                                           decltype( visible_allies ), false, true >;
            using ai_rule_catalog_functor = sol::function_detail::functor_function <
                                            decltype( ai_rule_catalog ), false, true >;

            result.keys_are_distinct =
                sol::usertype_traits<visible_allies_functor>::user_gc_metatable() !=
                sol::usertype_traits<ai_rule_catalog_functor>::user_gc_metatable();
            if( !result.keys_are_distinct ) {
                return result;
            }

            if( large_first ) {
                lua.set_function( "visible_allies", visible_allies );
                lua.set_function( "ai_rule_catalog", ai_rule_catalog );
            } else {
                lua.set_function( "ai_rule_catalog", ai_rule_catalog );
                lua.set_function( "visible_allies", visible_allies );
            }
        }

        result.captures_are_alive_before_cleanup =
            !targets.runtime_generation.expired() && !targets.world_generation.expired() &&
            !targets.require_read.expired();

        if( collect_before_state_close ) {
            lua["visible_allies"] = sol::lua_nil;
            lua["ai_rule_catalog"] = sol::lua_nil;
            lua.collect_garbage();
            result.captures_are_released_after_cleanup =
                targets.runtime_generation.expired() && targets.world_generation.expired() &&
                targets.require_read.expired();
        }
    }

    if( !collect_before_state_close ) {
        result.captures_are_released_after_cleanup =
            targets.runtime_generation.expired() && targets.world_generation.expired() &&
            targets.require_read.expired();
    }
    return result;
}

struct destructor_effect_result {
    bool keys_are_distinct = false;
    int first_delta = 0;
    int second_delta = 0;
};

destructor_effect_result exercise_equal_size_callbacks( const bool first_capture_first,
        const bool collect_before_state_close )
{
    destructor_effect_result result;
    first_capture_destructions.store( 0, std::memory_order_relaxed );
    second_capture_destructions.store( 0, std::memory_order_relaxed );
    int first_baseline = 0;
    int second_baseline = 0;

    {
        sol::state lua;
        {
            auto first_callback = [captured = first_capture{}]( sol::this_state state ) -> int {
                ( void )state;
                ( void )captured.marker;
                return 0;
            };
            auto second_callback = [captured = second_capture{}]( sol::this_state state ) -> int {
                ( void )state;
                ( void )captured.marker;
                return 0;
            };

            using first_functor = sol::function_detail::functor_function <
                                  decltype( first_callback ), false, true >;
            using second_functor = sol::function_detail::functor_function <
                                   decltype( second_callback ), false, true >;

            static_assert( sizeof( first_functor ) == sizeof( second_functor ) );
            result.keys_are_distinct =
                sol::usertype_traits<first_functor>::user_gc_metatable() !=
                sol::usertype_traits<second_functor>::user_gc_metatable();
            if( !result.keys_are_distinct ) {
                return result;
            }

            if( first_capture_first ) {
                lua.set_function( "first", first_callback );
                lua.set_function( "second", second_callback );
            } else {
                lua.set_function( "second", second_callback );
                lua.set_function( "first", first_callback );
            }
        }

        first_baseline = first_capture_destructions.load( std::memory_order_relaxed );
        second_baseline = second_capture_destructions.load( std::memory_order_relaxed );

        if( collect_before_state_close ) {
            lua["first"] = sol::lua_nil;
            lua["second"] = sol::lua_nil;
            lua.collect_garbage();
            result.first_delta = first_capture_destructions.load( std::memory_order_relaxed ) -
                                 first_baseline;
            result.second_delta = second_capture_destructions.load( std::memory_order_relaxed ) -
                                  second_baseline;
        }
    }

    if( !collect_before_state_close ) {
        result.first_delta = first_capture_destructions.load( std::memory_order_relaxed ) -
                             first_baseline;
        result.second_delta = second_capture_destructions.load( std::memory_order_relaxed ) -
                              second_baseline;
    }
    return result;
}

} // namespace

TEST_CASE( "lua_platform_sol_functor_gc_keys_distinguish_callback_types",
           "[lua][lifetime]" )
{
    REQUIRE( distinct_functor_gc_keys_for_equal_and_different_layouts<false, false>() );
    REQUIRE( distinct_functor_gc_keys_for_equal_and_different_layouts<false, true>() );
    REQUIRE( distinct_functor_gc_keys_for_equal_and_different_layouts<true, false>() );
    REQUIRE( distinct_functor_gc_keys_for_equal_and_different_layouts<true, true>() );
}

TEST_CASE( "lua_platform_sol_functor_userdata_releases_all_captures",
           "[lua][lifetime]" )
{
    for( const bool large_first : {
             false, true
         } ) {
        for( const bool collect_before_state_close : {
                 false, true
             } ) {
            const capture_lifetime_result result = exercise_large_and_small_callbacks(
                    large_first, collect_before_state_close );
            INFO( "large callback registered first: " << large_first );
            INFO( "collect before state close: " << collect_before_state_close );
            REQUIRE( result.keys_are_distinct );
            CHECK( result.captures_are_alive_before_cleanup );
            CHECK( result.captures_are_released_after_cleanup );
        }
    }
}

TEST_CASE( "lua_platform_sol_functor_userdata_calls_each_same_size_destructor",
           "[lua][lifetime]" )
{
    for( const bool first_capture_first : {
             false, true
         } ) {
        for( const bool collect_before_state_close : {
                 false, true
             } ) {
            const destructor_effect_result result = exercise_equal_size_callbacks(
                    first_capture_first, collect_before_state_close );
            INFO( "first capture registered first: " << first_capture_first );
            INFO( "collect before state close: " << collect_before_state_close );
            REQUIRE( result.keys_are_distinct );
            CHECK( result.first_delta == 1 );
            CHECK( result.second_delta == 1 );
        }
    }
}

#endif // defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
