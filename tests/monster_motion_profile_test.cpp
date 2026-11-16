#include <chrono>

#include "cata_catch.h"
#include "monster_motion_profile.h"

TEST_CASE( "monster_motion_profile_nested_scopes_restore_owner", "[monster][profiling]" )
{
    namespace p = monster_motion_profile;
    REQUIRE( p::active == nullptr );
    {
        p::scope disabled( p::stage::plan_setup );
        p::increment( p::counter::ratings );
    }
    {
        p::frame frame;
        const auto start = std::chrono::steady_clock::now();
        {
            p::scope outer( p::stage::move_commit );
            {
                p::scope inner( p::stage::push );
                p::scope recursive( p::stage::push );
                p::increment( p::counter::ratings );
            }
            outer.next( p::stage::step );
            {
                p::frame nested;
                p::scope other( p::stage::plan_setup );
                CHECK( p::active == &nested );
            }
            CHECK( p::active == &frame );
        }
        const auto elapsed = std::chrono::steady_clock::now() - start;
        std::chrono::steady_clock::duration charged{};
        for( const auto &sample : frame.samples ) {
            charged += sample.elapsed;
        }
        CHECK( charged <= elapsed );
        CHECK( frame.samples[static_cast<std::size_t>( p::stage::push )].calls == 2 );
        CHECK( frame.samples[static_cast<std::size_t>( p::stage::step )].calls == 1 );
        CHECK( frame.samples[static_cast<std::size_t>( p::stage::plan_setup )].calls == 0 );
        CHECK( frame.counters[static_cast<std::size_t>( p::counter::ratings )] == 1 );
        CHECK( frame.top == nullptr );
    }
    CHECK( p::active == nullptr );
}
