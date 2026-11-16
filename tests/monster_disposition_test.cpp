#include "cata_catch.h"
#include "monster_disposition.h"

TEST_CASE( "monster_friendliness_invalidates_only_membership_changes", "[monster][disposition]" )
{
    monster_friendliness value;
    auto revision = monster_friendliness::revision();
    value = -1;
    CHECK( monster_friendliness::revision() == revision + 1 );
    revision = monster_friendliness::revision();
    value = 2;
    CHECK( monster_friendliness::revision() == revision );
    CHECK( value-- == 2 );
    CHECK( monster_friendliness::revision() == revision );
    --value;
    CHECK( static_cast<int>( value ) == 0 );
    CHECK( monster_friendliness::revision() == revision + 1 );
    value += 10;
    CHECK( monster_friendliness::revision() == revision + 2 );
    monster_friendliness other;
    other = value;
    CHECK( static_cast<int>( other ) == 10 );
    CHECK( monster_friendliness::revision() == revision + 3 );
    value = monster_friendliness();
    CHECK( monster_friendliness::revision() == revision + 4 );
}

TEST_CASE( "monster_faction_assignment_invalidates_groups", "[monster][disposition]" )
{
    monster_faction value;
    auto revision = monster_faction::revision();
    value = mfaction_id( 5 );
    CHECK( monster_faction::revision() == revision + 1 );
    value = mfaction_id( 5 );
    CHECK( monster_faction::revision() == revision + 1 );
    monster_faction other;
    other = value;
    CHECK( other.to_i() == 5 );
    CHECK( monster_faction::revision() == revision + 2 );
    const mfaction_id base = other;
    CHECK( base.to_i() == 5 );
}
