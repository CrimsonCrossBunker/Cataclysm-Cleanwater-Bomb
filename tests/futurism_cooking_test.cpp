#include <initializer_list>
#include <vector>

#include "cata_catch.h"
#include "cata_utility.h"
#include "item.h"
#include "itype.h"
#include "requirements.h"
#include "temp_crafting_inventory.h"
#include "type_id.h"

static const itype_id itype_fcl_atomic_coffeemaker( "fcl_atomic_coffeemaker" );
static const itype_id itype_fcl_atompot( "fcl_atompot" );
static const itype_id itype_pressure_cooker( "pressure_cooker" );

static const quality_id qual_HOTPLATE( "HOTPLATE" );

static const requirement_id requirement_surface_heat( "surface_heat" );
static const requirement_id requirement_water_boiling_heat( "water_boiling_heat" );

TEST_CASE( "futurism_atomic_cooking_heat_sources", "[.][futurism][requirement]" )
{
    REQUIRE( itype_fcl_atompot.is_valid() );
    REQUIRE( itype_fcl_atomic_coffeemaker.is_valid() );

    for( const requirement_id &heat : {
             requirement_surface_heat, requirement_water_boiling_heat
         } ) {
        CAPTURE( heat );
        REQUIRE( heat.is_valid() );
        CHECK( heat->get_tools().size() == 1 );

        for( const itype_id &heater : {
                 itype_fcl_atompot, itype_fcl_atomic_coffeemaker
             } ) {
            CAPTURE( heater );
            temp_crafting_inventory inventory;
            inventory.add_item_copy( item( heater ) );
            CHECK( heat->can_make_with_inventory( nullptr, inventory, return_true<item> ) );
            CHECK( ( heat.obj() * 10 ).can_make_with_inventory( nullptr, inventory,
                    return_true<item> ) );
        }

        temp_crafting_inventory unheated;
        CHECK_FALSE( heat->can_make_with_inventory( nullptr, unheated, return_true<item> ) );
        unheated.add_item_copy( item( itype_pressure_cooker ) );
        CHECK_FALSE( heat->can_make_with_inventory( nullptr, unheated, return_true<item> ) );
    }
}

TEST_CASE( "futurism_atompot_is_a_self_powered_heater", "[.][futurism][item]" )
{
    REQUIRE( itype_fcl_atompot.is_valid() );
    const item atompot( itype_fcl_atompot );

    CHECK( atompot.has_quality( qual_HOTPLATE, 2 ) );
    CHECK( atompot.type->can_use( "HEAT_ALL_ITEMS" ) );
    CHECK( atompot.type->charges_to_use() == 0 );
    CHECK( atompot.ammo_remaining() >= atompot.type->charges_to_use() );
}
