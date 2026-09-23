#include <array>
#include <functional>

#include "calendar.h"
#include "cata_catch.h"
#include "cata_utility.h"
#include "inventory.h"
#include "item.h"
#include "pocket_type.h"
#include "requirements.h"
#include "ret_val.h"
#include "type_id.h"

static const requirement_id requirement_smelting_standard( "smelting_standard" );

TEST_CASE( "smelting_requires_each_tool_group", "[requirements][smelting][upstream_ports]" )
{
    const bool alternatives = GENERATE( false, true );
    const int missing = GENERATE( -1, 0, 1, 2, 3 );
    const std::array<itype_id, 4> tools = alternatives ?
                                          std::array<itype_id, 4> { itype_id( "oxy_torch" ), itype_id( "crucible_clay" ),
                                                  itype_id( "metalworking_tongs_bronze" ), itype_id( "casting_mold" )
                                                                  } :
                                          std::array<itype_id, 4> { itype_id( "oxy_torch" ), itype_id( "crucible" ),
                                                  itype_id( "metalworking_tongs" ), itype_id( "casting_mold" )
                                                                  };
    inventory inv;
    for( int i = 0; i < 4; ++i ) {
        if( i != missing ) {
            item tool( tools[i], calendar::turn );
            if( i == 0 ) {
                item tank( itype_id( "tinyweldtank" ) );
                tank.ammo_set( itype_id( "oxyacetylene" ), 100 );
                REQUIRE( tool.put_in( tank, pocket_type::MAGAZINE_WELL ).success() );
                REQUIRE( tool.ammo_remaining() == 100 );
            }
            inv.add_item( tool, false, false );
        }
    }
    CAPTURE( alternatives, missing );
    CHECK( requirement_smelting_standard->can_make_with_inventory(
               nullptr, inv, return_true<item> ) == ( missing == -1 ) );
}

TEST_CASE( "a_crucible_alone_is_not_a_smelting_toolset",
           "[requirements][smelting][upstream_ports]" )
{
    inventory inv;
    inv.add_item( item( itype_id( "crucible" ) ), false, false );
    CHECK_FALSE( requirement_smelting_standard->can_make_with_inventory(
                     nullptr, inv, return_true<item> ) );
}
