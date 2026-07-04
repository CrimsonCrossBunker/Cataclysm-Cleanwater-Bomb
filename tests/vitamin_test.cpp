#include <set>
#include <string>
#include <utility>
#include <vector>

#include "cata_catch.h"
#include "type_id.h"
#include "vitamin.h"

static const vitamin_id vitamin_test_vit_extend_base( "test_vit_extend_base" );
static const vitamin_id vitamin_test_vit_extend_derived( "test_vit_extend_derived" );
static const vitamin_id vitamin_test_vitv( "test_vitv" );
static const vitamin_id vitamin_test_vitx( "test_vitx" );

TEST_CASE( "vitamin_copy_from_with_extend_and_delete", "[vitamin]" )
{
    REQUIRE( vitamin_test_vit_extend_base.is_valid() );
    REQUIRE( vitamin_test_vit_extend_derived.is_valid() );

    const vitamin &base = vitamin_test_vit_extend_base.obj();
    const vitamin &derived = vitamin_test_vit_extend_derived.obj();

    CHECK( base.name() == "Vitamin Extend Base" );
    CHECK( derived.name() == "Vitamin Extend Derived" );

    // Inherited scalar values should be copied from the base.
    CHECK( derived.min() == base.min() );
    CHECK( derived.max() == base.max() );
    CHECK( derived.rate() == base.rate() );

    // flags: base has TEST_FLAG_A; derived should also have TEST_FLAG_B.
    CHECK( base.has_flag( "TEST_FLAG_A" ) );
    CHECK_FALSE( base.has_flag( "TEST_FLAG_B" ) );
    CHECK( derived.has_flag( "TEST_FLAG_A" ) );
    CHECK( derived.has_flag( "TEST_FLAG_B" ) );

    // disease thresholds: base has two ranges; derived deletes the second and adds a third.
    CHECK( base.severity( -90 ) == 1 );
    CHECK( base.severity( -70 ) == 2 );
    CHECK( base.severity( -50 ) == 0 );

    CHECK( derived.severity( -90 ) == 1 );
    CHECK( derived.severity( -70 ) == 0 );
    CHECK( derived.severity( -50 ) == 2 );

    // decays_into: derived should keep the base entry and add the extended entry.
    const std::vector<std::pair<vitamin_id, int>> derived_decays = derived.decays_into();
    REQUIRE( derived_decays.size() == 2 );
    CHECK( derived_decays[0].first == vitamin_test_vitv );
    CHECK( derived_decays[0].second == 1 );
    CHECK( derived_decays[1].first == vitamin_test_vitx );
    CHECK( derived_decays[1].second == 2 );
}
