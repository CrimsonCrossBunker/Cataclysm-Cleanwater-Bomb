#include "cata_catch.h"

#include <chrono>
#include <sstream>
#include <stdexcept>

#include "monster_move_profile.h"

namespace
{
struct movement_test_clock {
    using time_point = std::chrono::steady_clock::time_point;
    inline static time_point current{};
    inline static int reads = 0;
    static time_point now() {
        ++reads;
        return current;
    }
    static void advance( int milliseconds ) {
        current += std::chrono::milliseconds( milliseconds );
    }
};
using test_profile = basic_monster_move_profile<movement_test_clock>;
using stage = monster_move_stage;
} // namespace

TEST_CASE( "monster_move_profile_charges_nested_stages_exclusively", "[monster][profiling]" )
{
    test_profile profile( true );
    {
        test_profile::scope outer( stage::other );
        movement_test_clock::advance( 2 );
        outer.set( stage::neighbors );
        movement_test_clock::advance( 3 );
        {
            test_profile::scope inner( stage::scent );
            movement_test_clock::advance( 7 );
            inner.set( stage::path );
            movement_test_clock::advance( 11 );
        }
        movement_test_clock::advance( 3 );
    }
    CHECK( profile.get( stage::other ).milliseconds == 2 );
    CHECK( profile.get( stage::neighbors ).milliseconds == 6 );
    CHECK( profile.get( stage::scent ).milliseconds == 7 );
    CHECK( profile.get( stage::path ).milliseconds == 11 );
    CHECK( profile.get( stage::neighbors ).calls == 1 );
    CHECK( profile.get( stage::path ).calls == 1 );
    std::ostringstream log;
    profile.write( log );
    CHECK( log.str().find( "hottest=path" ) != std::string::npos );
}

TEST_CASE( "monster_move_profile_handles_early_exits", "[monster][profiling]" )
{
    test_profile profile( true );
    const auto early_return = []() {
        test_profile::scope timing( stage::effects );
        movement_test_clock::advance( 5 );
        return;
    };
    early_return();
    CHECK( profile.get( stage::effects ).milliseconds == 5 );
    CHECK_THROWS_AS( []() {
        test_profile::scope timing( stage::attack );
        movement_test_clock::advance( 9 );
        throw std::runtime_error( "test" );
    }(), std::runtime_error );
    CHECK( profile.get( stage::attack ).milliseconds == 9 );
}

TEST_CASE( "disabled_monster_move_profile_does_not_read_clock", "[monster][profiling]" )
{
    test_profile profile( true );
    const int reads = movement_test_clock::reads;
    {
        test_profile disabled( false );
        test_profile::scope timing( stage::path );
        timing.set( stage::scent );
    }
    CHECK( movement_test_clock::reads == reads );
    {
        test_profile::scope timing( stage::path );
        movement_test_clock::advance( 4 );
    }
    CHECK( profile.get( stage::path ).milliseconds == 4 );
}
