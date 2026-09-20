#include <functional>

#include "avatar.h"
#include "cata_catch.h"
#include "inventory.h"
#include "item.h"
#include "player_helpers.h"
#include "type_id.h"
#include "visitable.h"

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
    inv.add_item( item( itype_id( "test_reserve_tool_a" ) ) );
    const quality_id present( "TEST_RESERVE_A" );
    const quality_id absent( "TEST_RESERVE_B" );
    inv.traversals = 0;
    {
        scoped_provider_quality_cache cache( inv );
        for( int n = 0; n < 100; ++n ) {
            CHECK( inv.has_provider_quality( present, 1, 1, nullptr ) );
            CHECK_FALSE( inv.has_provider_quality( absent, 1, 1, nullptr ) );
        }
        CHECK( inv.traversals == 2 );
        CHECK( inv.has_provider_quality( present, 1, 1, &get_avatar() ) );
        CHECK( inv.traversals == 3 );
        CHECK_FALSE( inv.has_provider_quality( present, 2, 1, nullptr ) );
        CHECK_FALSE( inv.has_provider_quality( present, 1, 2, nullptr ) );
        CHECK( inv.traversals == 5 );

        counting_quality_inventory other;
        {
            scoped_provider_quality_cache nested( other );
            CHECK_FALSE( other.has_provider_quality( present, 1, 1, nullptr ) );
            CHECK( inv.has_provider_quality( present, 1, 1, nullptr ) );
            CHECK( inv.traversals == 5 );
        }
        CHECK( inv.has_provider_quality( present, 1, 1, nullptr ) );
        CHECK( inv.traversals == 5 );
    }
    inv.clear();
    CHECK_FALSE( inv.has_provider_quality( present, 1, 1, nullptr ) );
    const int before = inv.traversals;
    CHECK_FALSE( inv.has_provider_quality( present, 1, 1, nullptr ) );
    CHECK( inv.traversals == before + 1 );
    inv.add_item( item( itype_id( "test_reserve_tool_a" ) ) );
    {
        scoped_provider_quality_cache reopened( inv );
        CHECK( inv.has_provider_quality( present, 1, 1, nullptr ) );
    }
}
