#include <map>
#include <vector>

#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "inventory.h"
#include "item.h"
#include "player_helpers.h"
#include "type_id.h"
#include "veh_interact.h"
#include "veh_type.h"
#include "visitable.h"

static const itype_id itype_frame_wood( "frame_wood" );
static const itype_id itype_hammer( "hammer" );
static const itype_id itype_nail( "nail" );
static const itype_id itype_rock( "rock" );
static const itype_id itype_test_reserve_tool_a( "test_reserve_tool_a" );

static const quality_id qual_TEST_RESERVE_A( "TEST_RESERVE_A" );
static const quality_id qual_TEST_RESERVE_B( "TEST_RESERVE_B" );

static const vpart_id vpart_frame_wood( "frame_wood" );

namespace
{
class counting_quality_inventory : public inventory
{
    public:
        mutable int traversals = 0;
        VisitResponse visit_items( const std::function<VisitResponse( item *, item * )> &func ) const
        override {
            ++traversals;
            return inventory::visit_items( func );
        }
};
} // namespace

TEST_CASE( "provider_quality_cache_is_scoped_and_actor_specific", "[craft][quality][cache]" )
{
    clear_avatar();
    counting_quality_inventory inv;
    inv.add_item( item( itype_test_reserve_tool_a ) );
    inv.traversals = 0;
    {
        scoped_provider_quality_cache cache( inv );
        for( int n = 0; n < 100; ++n ) {
            CHECK( inv.has_provider_quality( qual_TEST_RESERVE_A, 1, 1, nullptr ) );
            CHECK_FALSE( inv.has_provider_quality( qual_TEST_RESERVE_B, 1, 1, nullptr ) );
        }
        CHECK( inv.traversals == 2 );
        CHECK( inv.has_provider_quality( qual_TEST_RESERVE_A, 1, 1, &get_avatar() ) );
        CHECK( inv.traversals == 3 );
        CHECK_FALSE( inv.has_provider_quality( qual_TEST_RESERVE_A, 2, 1, nullptr ) );
        CHECK_FALSE( inv.has_provider_quality( qual_TEST_RESERVE_A, 1, 2, nullptr ) );
        CHECK( inv.traversals == 5 );

        counting_quality_inventory other;
        {
            scoped_provider_quality_cache nested( other );
            CHECK_FALSE( other.has_provider_quality( qual_TEST_RESERVE_A, 1, 1, nullptr ) );
            CHECK( inv.has_provider_quality( qual_TEST_RESERVE_A, 1, 1, nullptr ) );
            CHECK( inv.traversals == 5 );
        }
        CHECK( inv.has_provider_quality( qual_TEST_RESERVE_A, 1, 1, nullptr ) );
        CHECK( inv.traversals == 5 );
    }
    inv.clear();
    CHECK_FALSE( inv.has_provider_quality( qual_TEST_RESERVE_A, 1, 1, nullptr ) );
    const int before = inv.traversals;
    CHECK_FALSE( inv.has_provider_quality( qual_TEST_RESERVE_A, 1, 1, nullptr ) );
    CHECK( inv.traversals == before + 1 );
    inv.add_item( item( itype_test_reserve_tool_a ) );
    {
        scoped_provider_quality_cache reopened( inv );
        CHECK( inv.has_provider_quality( qual_TEST_RESERVE_A, 1, 1, nullptr ) );
    }
}

TEST_CASE( "vehicle_installation_inventory_checks_are_bounded_and_refreshable",
           "[vehicle][quality][cache]" )
{
    clear_avatar();
    counting_quality_inventory inv;
    for( int n = 0; n < 5000; ++n ) {
        inv.add_item( item( itype_rock ) );
    }
    inv.traversals = 0;
    const auto available = veh_interact::installation_requirement_availability( get_avatar(), inv );
    REQUIRE( available.size() == vehicles::parts::get_all().size() );
    // Thousands of part definitions share a small set of quality queries.
    // The inventory must not be traversed once for every definition/cursor.
    CHECK( inv.traversals < 100 );
    CHECK_FALSE( available.at( &vpart_frame_wood.obj() ) );

    inv.clear();
    inv.add_item( item( itype_frame_wood ) );
    inv.add_item( item( itype_hammer ) );
    inv.add_item( item( itype_nail, calendar::turn, 100 ) );
    const auto refreshed = veh_interact::installation_requirement_availability( get_avatar(), inv );
    CHECK( refreshed.at( &vpart_frame_wood.obj() ) );
}
