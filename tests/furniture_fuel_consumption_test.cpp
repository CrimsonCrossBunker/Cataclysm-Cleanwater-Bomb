#include <functional>
#include <list>
#include <string>
#include <vector>

#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "craft_reservation.h"
#include "iexamine.h"
#include "inventory.h"
#include "item.h"
#include "itype.h"
#include "map.h"
#include "map_helpers.h"
#include "mapdata.h"
#include "point.h"
#include "temp_crafting_inventory.h"
#include "type_id.h"

static const itype_id itype_carbon_electrode( "carbon_electrode" );
static const itype_id itype_charcoal( "charcoal" );
static const itype_id itype_fake_char_smoker( "fake_char_smoker" );
static const furn_str_id furn_f_forge_rock( "f_forge_rock" );
static const furn_str_id furn_f_smoking_rack( "f_smoking_rack" );
static const furn_str_id furn_f_metal_smoking_rack( "f_metal_smoking_rack" );

static int consume_furniture_fuel( map &here, const tripoint_bub_ms &pos,
                                   const itype_id &type, int quantity, bool in_tools = false )
{
    here.use_charges( { pos }, type, quantity, []( const item & ) {
        return true;
    }, nullptr, in_tools );
    return quantity;
}

TEST_CASE( "smoking_rack_fuel_can_be_exhausted_and_reloaded",
           "[crafting][smoking][furniture_fuel]" )
{
    clear_map_without_vision();
    map &here = get_map();
    const tripoint_bub_ms pos( 60, 60, 0 );
    const furn_str_id furniture = GENERATE( furn_f_smoking_rack, furn_f_metal_smoking_rack );
    // Exercise both the crafting tool and explicit requests for ammo inside tools.
    const itype_id requested = GENERATE( itype_charcoal, itype_fake_char_smoker );
    here.furn_set( pos, furniture );
    for( int cycle = 0; cycle < 2; ++cycle ) {
        CAPTURE( furniture, requested, cycle );
        here.add_item( pos, item( itype_charcoal, calendar::turn_zero, 90000 ) );
        temp_crafting_inventory inventory;
        inventory.form_from_map( here, { pos }, nullptr );
        CHECK( inventory.charges_of( itype_fake_char_smoker ) == 90000 );
        CHECK( consume_furniture_fuel( here, pos, requested, 90000, requested == itype_charcoal ) == 0 );
        CHECK( here.i_at( pos ).empty() );
    }
}

TEST_CASE( "smoking_rack_counts_and_consumes_all_charcoal_stacks",
           "[crafting][smoking][furniture_fuel]" )
{
    clear_map_without_vision();
    map &here = get_map();
    const tripoint_bub_ms pos( 60, 60, 0 );
    here.furn_set( pos, furn_f_smoking_rack );
    const int residual = GENERATE( 0, 1 );
    item old_fuel( itype_charcoal, calendar::turn_zero, residual );
    old_fuel.set_var( "item_note", "previous load" );
    item refill( itype_charcoal, calendar::turn_zero, 90000 - residual );
    REQUIRE_FALSE( old_fuel.stacks_with( refill, true ) );
    here.add_item( pos, old_fuel );
    here.add_item( pos, refill );
    REQUIRE( here.i_at( pos ).size() == 2 );

    // The reload capacity check and crafting inventory must see the fuel behind the residue.
    CHECK( count_charges_in_list( item::find_type( itype_charcoal ), here.i_at( pos ) ) == 90000 );
    temp_crafting_inventory inventory;
    inventory.form_from_map( here, { pos }, nullptr );
    CHECK( inventory.charges_of( itype_fake_char_smoker ) == 90000 );
    CHECK( consume_furniture_fuel( here, pos, itype_fake_char_smoker, 100 ) == 0 );
    REQUIRE( here.i_at( pos ).size() == 1 );
    CHECK( here.i_at( pos ).begin()->charges == 89900 );
    CHECK( consume_furniture_fuel( here, pos, itype_fake_char_smoker, 89901 ) == 1 );
    CHECK( here.i_at( pos ).empty() );
}

TEST_CASE( "smoking_rack_preserves_preexisting_excess_fuel", "[crafting][smoking][furniture_fuel]" )
{
    clear_map_without_vision();
    map &here = get_map();
    const tripoint_bub_ms pos( 60, 60, 0 );
    here.furn_set( pos, furn_f_smoking_rack );
    here.add_item( pos, item( itype_charcoal, calendar::turn_zero, 180000 ) );
    CHECK( consume_furniture_fuel( here, pos, itype_fake_char_smoker, 100 ) == 0 );
    REQUIRE( here.i_at( pos ).size() == 1 );
    CHECK( here.i_at( pos ).begin()->charges == 179900 );
    CHECK( consume_furniture_fuel( here, pos, itype_fake_char_smoker, 180000 ) == 100 );
    CHECK( here.i_at( pos ).empty() );
}

TEST_CASE( "furniture_fuel_respects_filter_and_ammo_variant", "[crafting][furniture_fuel]" )
{
    clear_map_without_vision();
    map &here = get_map();
    const tripoint_bub_ms pos( 60, 60, 0 );
    here.furn_set( pos, furn_f_forge_rock );
    here.add_item( pos, item( itype_charcoal, calendar::turn_zero, 0 ) );
    here.add_item( pos, item( itype_carbon_electrode, calendar::turn_zero, 20 ) );
    here.add_item( pos, item( itype_carbon_electrode, calendar::turn_zero, 30 ) );
    here.add_item( pos, item( itype_charcoal, calendar::turn_zero, 100 ) );
    const ammotype &ammo = itype_charcoal->ammo->type;
    itype_id selected = itype_charcoal;
    CHECK( count_charges_in_list( &ammo, here.i_at( pos ), selected ) == 50 );
    CHECK( selected == itype_carbon_electrode );

    int requested = 50;
    here.use_charges( { pos }, itype_carbon_electrode, requested, []( const item & ) {
        return false;
    } );
    CHECK( requested == 50 );
    CHECK( here.i_at( pos ).size() == 4 );
    CHECK( consume_furniture_fuel( here, pos, itype_carbon_electrode, 50, true ) == 0 );
    REQUIRE( here.i_at( pos ).size() == 1 );
    CHECK( here.i_at( pos ).begin()->typeId() == itype_charcoal );
    CHECK( here.i_at( pos ).begin()->charges == 100 );
}

TEST_CASE( "reserved_furniture_fuel_is_untouched", "[crafting][furniture_fuel][reservation]" )
{
    clear_map_without_vision();
    map &here = get_map();
    const tripoint_bub_ms pos( 60, 60, 0 );
    here.furn_set( pos, furn_f_smoking_rack );
    here.add_item( pos, item( itype_charcoal, calendar::turn_zero, 0 ) );
    here.add_item( pos, item( itype_charcoal, calendar::turn_zero, 100 ) );
    craft_reservation_index::record reservation;
    reservation.craft_uid = 4242;
    reservation.provider_tiles.push_back( here.get_abs( pos ) );
    reservation.expires_at = calendar::turn + 1_hours;
    get_craft_reservations().set( reservation );
    CHECK( consume_furniture_fuel( here, pos, itype_fake_char_smoker, 100 ) == 100 );
    CHECK( here.i_at( pos ).size() == 2 );
    get_craft_reservations().erase( reservation.craft_uid );
    CHECK( consume_furniture_fuel( here, pos, itype_fake_char_smoker, 100 ) == 0 );
    CHECK( here.i_at( pos ).empty() );
}

TEST_CASE( "lighting_smoking_rack_consumes_split_charcoal", "[crafting][smoking][furniture_fuel]" )
{
    clear_map_without_vision();
    map &here = get_map();
    const tripoint_bub_ms pos( 60, 60, 0 );
    here.furn_set( pos, furn_f_smoking_rack );
    // One piece of meat needs the minimum 1200 charges, spread across two stacks.
    here.add_item( pos, item( itype_id( "meat" ), calendar::turn, 1 ) );
    here.add_item( pos, item( itype_charcoal, calendar::turn_zero, 0 ) );
    here.add_item( pos, item( itype_charcoal, calendar::turn_zero, 800 ) );
    here.add_item( pos, item( itype_charcoal, calendar::turn_zero, 800 ) );
    REQUIRE( iexamine::smoker_fire( get_avatar(), pos ) );
    CHECK( here.furn( pos ) == furn_str_id( "f_smoking_rack_active" ) );
    int charcoal_stacks = 0;
    for( const item &it : here.i_at( pos ) ) {
        if( it.typeId() == itype_charcoal ) {
            ++charcoal_stacks;
            CHECK( it.charges == 400 );
        }
    }
    CHECK( charcoal_stacks == 1 );
}
