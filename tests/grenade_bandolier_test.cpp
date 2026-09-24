#include <stddef.h>
#include <string>

#include "cata_catch.h"
#include "item.h"
#include "pocket_type.h"
#include "ret_val.h"
#include "type_id.h"

TEST_CASE( "large_grenade_bandoliers_hold_molotovs", "[item][pocket][bandolier][upstream_ports]" )
{
    const std::string bandolier_id = GENERATE( "bandolier_pipebomb", "bandolier_pipebomb_xs",
                                     "bandolier_pipebomb_xl" );
    const std::string grenade_id = GENERATE( "molotov", "gelled_molotov" );
    const int capacity = bandolier_id == "bandolier_pipebomb_xs" ? 3 :
                         bandolier_id == "bandolier_pipebomb_xl" ? 7 : 5;
    item bandolier{ itype_id( bandolier_id ) };
    const item grenade{ itype_id( grenade_id ) };
    CAPTURE( bandolier_id, grenade_id, capacity );
    for( int i = 0; i < capacity; ++i ) {
        REQUIRE( bandolier.can_contain( grenade ).success() );
        REQUIRE( bandolier.put_in( grenade, pocket_type::CONTAINER ).success() );
    }
    CHECK_FALSE( bandolier.can_contain( grenade ).success() );
    CHECK( bandolier.num_item_stacks() == static_cast<size_t>( capacity ) );
}
