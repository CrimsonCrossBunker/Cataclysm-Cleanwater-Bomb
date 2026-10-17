#include <future>
#include <memory>
#include <optional>
#include <utility>

#include "cata_catch.h"
#include "pathfinding.h"

TEST_CASE( "pathfinding_workspace_reentrancy_moves_and_owner_retirement",
           "[pathfinding][workspace]" )
{
    pathfinding_workspace owner;
    pathfinding_workspace other;
    pathfinding_workspace::state *primary = nullptr;
    {
        auto first = owner.acquire();
        primary = &first.get();
        auto nested = owner.acquire();
        CHECK( &nested.get() != primary );
        auto moved = std::move( nested );
        CHECK( &moved.get() != primary );
        auto independent = other.acquire();
        CHECK( &independent.get() != primary );
        CHECK( &independent.get() != &moved.get() );
    }
    {
        auto reused = owner.acquire();
        CHECK( &reused.get() == primary );
    }

    std::optional<pathfinding_workspace::lease> survivor;
    pathfinding_workspace::state *pinned = nullptr;
    {
        pathfinding_workspace retiring;
        auto lease = retiring.acquire();
        pinned = &lease.get();
        survivor.emplace( std::move( lease ) );
    }
    CHECK( &survivor->get() == pinned );
    survivor.reset();
}

TEST_CASE( "pathfinding_workspace_independent_owners_on_two_threads", "[pathfinding][workspace]" )
{
    const auto query = []() {
        pathfinding_workspace owner;
        pathfinding_workspace::state *retained = nullptr;
        for( unsigned i = 0; i < 100; ++i ) {
            auto outer = owner.acquire();
            if( retained && &outer.get() != retained ) {
                return false;
            }
            retained = &outer.get();
            auto nested = owner.acquire();
            if( &nested.get() == retained ) {
                return false;
            }
        }
        return true;
    };
    auto first = std::async( std::launch::async, query );
    auto second = std::async( std::launch::async, query );
    CHECK( first.get() );
    CHECK( second.get() );
}
