#include <cstdint>
#include <functional>
#include <list>
#include <sstream>
#include <string>

#include "cata_catch.h"
#include "coordinates.h"
#include "debug.h"
#include "flexbuffer_json.h"
#include "item.h"
#include "item_contents.h"
#include "item_location.h"
#include "item_uid.h"
#include "itype.h"
#include "json.h"
#include "json_loader.h"
#include "map.h"
#include "map_helpers.h"
#include "map_selector.h"
#include "pocket_type.h"
#include "point.h"
#include "ret_val.h"
#include "type_id.h"
#include "units.h"

static const faction_id faction_your_followers( "your_followers" );

static const itype_id itype_battery( "battery" );
static const itype_id itype_crowbar_pocket_test( "crowbar_pocket_test" );
static const itype_id itype_gasfilter_med( "gasfilter_med" );
static const itype_id itype_hammer_pocket_test( "hammer_pocket_test" );
static const itype_id itype_jar_glass_sealed( "jar_glass_sealed" );
static const itype_id itype_log( "log" );
static const itype_id itype_mask_bunker( "mask_bunker" );
static const itype_id itype_mask_hsurvivor( "mask_hsurvivor" );
static const itype_id itype_pickle( "pickle" );
static const itype_id itype_purse( "purse" );
static const itype_id itype_rm13_armor( "rm13_armor" );
static const itype_id itype_rm13_battery( "rm13_battery" );
static const itype_id itype_test_tool_belt( "test_tool_belt" );
static const itype_id itype_tongs_pocket_test( "tongs_pocket_test" );
static const itype_id itype_wrench_pocket_test( "wrench_pocket_test" );

static std::string saved_item_with_legacy_pocket( const itype_id &type,
        const pocket_type saved_type, const item &contained )
{
    std::ostringstream saved;
    JsonOut out( saved );
    out.start_object();
    out.member( "typeid", type.str() );
    out.member( "contents" );
    out.start_object();
    out.member( "contents" );
    out.start_array();
    out.start_object();
    out.member( "pocket_type", static_cast<int>( saved_type ) );
    out.member( "contents" );
    out.start_array();
    contained.serialize( out );
    out.end_array();
    out.end_object();
    out.end_array();
    out.end_object();
    out.end_object();
    return saved.str();
}

TEST_CASE( "removed_ammo_pockets_migrate_saved_items_without_debug_errors",
           "[item][pocket][savegame]" )
{
    item contained( itype_gasfilter_med );
    contained.ammo_set( contained.ammo_default(), 37 );
    const pocket_type removed_type = pocket_type::MAGAZINE_WELL;
    contained.set_owner( faction_your_followers );
    contained.set_var( "legacy_pocket_test", "preserved" );
    const int64_t original_uid = contained.uid().get_value();
    item loaded( itype_mask_bunker );
    REQUIRE_FALSE( loaded.has_pocket_type( removed_type ) );

    const std::string saved = saved_item_with_legacy_pocket( itype_mask_bunker, removed_type,
        contained );
    CHECK( capture_debugmsg_during( [&]() {
        loaded.deserialize( json_loader::from_string( saved ).get_object() );
    } ).empty() );
    REQUIRE( loaded.all_items_top( pocket_type::MIGRATION ).size() == 1 );

    // A second save/load before overflow must not lose or duplicate the contents.
    std::ostringstream roundtrip;
    JsonOut out( roundtrip );
    loaded.serialize( out );
    item reloaded;
    CHECK( capture_debugmsg_during( [&]() {
        reloaded.deserialize( json_loader::from_string( roundtrip.str() ).get_object() );
    } ).empty() );
    const std::list<item *> migrated = reloaded.all_items_top( pocket_type::MIGRATION );
    REQUIRE( migrated.size() == 1 );
    CHECK( migrated.front()->typeId() == contained.typeId() );
    CHECK( migrated.front()->uid().get_value() == original_uid );
    CHECK( migrated.front()->charges == contained.charges );
    CHECK( migrated.front()->ammo_remaining() == contained.ammo_remaining() );
    CHECK( migrated.front()->get_owner() == contained.get_owner() );
    CHECK( migrated.front()->get_var( "legacy_pocket_test" ) == "preserved" );

    clear_map_without_vision();
    map &here = get_map();
    const tripoint_bub_ms origin{ 60, 60, 0 };
    here.i_clear( origin );
    reloaded.overflow( here, origin );
    CHECK( reloaded.all_items_top( pocket_type::MIGRATION ).empty() );
    REQUIRE( here.i_at( origin ).size() == 1 );
    CHECK( here.i_at( origin ).begin()->typeId() == contained.typeId() );
    CHECK( here.i_at( origin ).begin()->ammo_remaining() == contained.ammo_remaining() );
    CHECK( here.i_at( origin ).begin()->get_owner() == contained.get_owner() );
    CHECK( here.i_at( origin ).begin()->get_var( "legacy_pocket_test" ) == "preserved" );
    reloaded.overflow( here, origin );
    CHECK( here.i_at( origin ).size() == 1 );
}

TEST_CASE( "removed_integral_battery_loads_into_replacement_magazine", "[item][pocket][savegame]" )
{
    item charge( itype_battery );
    const int saved_charges = GENERATE( 731, 5000 );
    charge.charges = saved_charges;
    charge.set_owner( faction_your_followers );
    charge.set_var( "legacy_pocket_test", "preserved" );
    const int64_t original_uid = charge.uid().get_value();
    item loaded( itype_rm13_armor );
    REQUIRE_FALSE( loaded.has_pocket_type( pocket_type::MAGAZINE ) );
    const std::string saved = saved_item_with_legacy_pocket( itype_rm13_armor, pocket_type::MAGAZINE,
        charge );
    CHECK( capture_debugmsg_during( [&]() {
        loaded.deserialize( json_loader::from_string( saved ).get_object() );
    } ).empty() );
    REQUIRE( loaded.magazine_current() != nullptr );
    CHECK( loaded.magazine_current()->typeId() == itype_rm13_battery );
    CHECK( loaded.magazine_current()->ammo_remaining() == saved_charges );
    CHECK( loaded.magazine_current()->first_ammo().uid().get_value() == original_uid );
    CHECK( loaded.magazine_current()->first_ammo().get_owner() == charge.get_owner() );
    CHECK( loaded.magazine_current()->first_ammo().get_var( "legacy_pocket_test" ) == "preserved" );
    CHECK( loaded.all_items_top( pocket_type::MIGRATION ).empty() );

    std::ostringstream roundtrip;
    JsonOut out( roundtrip );
    loaded.serialize( out );
    item reloaded;
    CHECK( capture_debugmsg_during( [&]() {
        reloaded.deserialize( json_loader::from_string( roundtrip.str() ).get_object() );
    } ).empty() );
    REQUIRE( reloaded.all_items_top( pocket_type::MAGAZINE_WELL ).size() == 1 );
    REQUIRE( reloaded.magazine_current() != nullptr );
    CHECK( reloaded.magazine_current()->ammo_remaining() == saved_charges );
    CHECK( reloaded.magazine_current()->first_ammo().uid().get_value() == original_uid );

    clear_map_without_vision();
    map &here = get_map();
    const tripoint_bub_ms origin{ 60, 60, 0 };
    here.i_clear( origin );
    reloaded.overflow( here, origin );
    CHECK( here.i_at( origin ).empty() );
    REQUIRE( reloaded.magazine_current() != nullptr );
    CHECK( reloaded.magazine_current()->ammo_remaining() == saved_charges );
}

TEST_CASE( "existing_filter_pocket_keeps_saved_filter_installed", "[item][pocket][savegame]" )
{
    item filter( itype_gasfilter_med );
    filter.ammo_set( filter.ammo_default(), 37 );
    item loaded( itype_mask_hsurvivor );
    const std::string saved = saved_item_with_legacy_pocket( itype_mask_hsurvivor,
        pocket_type::MAGAZINE_WELL,
        filter );
    CHECK( capture_debugmsg_during( [&]() {
        loaded.deserialize( json_loader::from_string( saved ).get_object() );
    } ).empty() );
    REQUIRE( loaded.magazine_current() != nullptr );
    CHECK( loaded.magazine_current()->uid() == filter.uid() );
    CHECK( loaded.magazine_current()->ammo_remaining() == 37 );
    CHECK( loaded.all_items_top( pocket_type::MIGRATION ).empty() );
}

TEST_CASE( "item_contents" )
{
    map &here = get_map();

    clear_map_without_vision();
    item tool_belt( itype_test_tool_belt );

    const units::volume tool_belt_vol = tool_belt.volume();
    const units::mass tool_belt_weight = tool_belt.weight();

    //check empty weight is consistent
    CHECK( tool_belt.weight( true ) == tool_belt.type->weight );
    CHECK( tool_belt.weight( false ) == tool_belt.type->weight );

    item hammer( itype_hammer_pocket_test );
    item tongs( itype_tongs_pocket_test );
    item wrench( itype_wrench_pocket_test );
    item crowbar( itype_crowbar_pocket_test );

    ret_val<void> i1 = tool_belt.put_in( hammer, pocket_type::CONTAINER );
    ret_val<void> i2 = tool_belt.put_in( tongs, pocket_type::CONTAINER );
    ret_val<void> i3 = tool_belt.put_in( wrench, pocket_type::CONTAINER );
    ret_val<void> i4 = tool_belt.put_in( crowbar, pocket_type::CONTAINER );

    {
        CAPTURE( i1.str() );
        CHECK( i1.success() );
    }
    {
        CAPTURE( i2.str() );
        CHECK( i2.success() );
    }
    {
        CAPTURE( i3.str() );
        CHECK( i3.success() );
    }
    {
        CAPTURE( i4.str() );
        CHECK( i4.success() );
    }

    // check the items actually got added to the tool belt
    REQUIRE( tool_belt.num_item_stacks() == 4 );
    // tool belts are non-rigid
    CHECK( tool_belt.volume() == tool_belt_vol +
           hammer.volume() + tongs.volume() + wrench.volume() + crowbar.volume() );
    // check that the tool belt's weight adds up all its contents properly
    CHECK( tool_belt.weight() == tool_belt_weight +
           hammer.weight() + tongs.weight() + wrench.weight() + crowbar.weight() );
    // check that individual (not including contained items) weight is correct
    CHECK( tool_belt.weight( false ) == tool_belt.type->weight );
    // check that the tool belt is "full"
    CHECK( !tool_belt.can_contain( crowbar ).success() );

    tool_belt.force_insert_item( crowbar, pocket_type::CONTAINER );
    CHECK( tool_belt.num_item_stacks() == 5 );
    tool_belt.force_insert_item( crowbar, pocket_type::CONTAINER );
    tool_belt.overflow( here, tripoint_bub_ms::zero );
    CHECK( tool_belt.num_item_stacks() == 4 );
    tool_belt.overflow( here, tripoint_bub_ms::zero );
    // overflow should only spill items if they can't fit
    CHECK( tool_belt.num_item_stacks() == 4 );

    tool_belt.remove_items_with( []( const item & it ) {
        return it.typeId() == itype_crowbar_pocket_test;
    } );
    // check to see that removing an item works
    CHECK( tool_belt.num_item_stacks() == 3 );
    tool_belt.spill_contents( tripoint_bub_ms::zero );
    CHECK( tool_belt.empty() );
}

TEST_CASE( "overflow_on_combine", "[item]" )
{
    clear_map_without_vision();
    tripoint_bub_ms origin{ 60, 60, 0 };
    item purse( itype_purse );
    item log( itype_log );
    item_contents overfull_contents( purse.type->pockets );
    overfull_contents.force_insert_item( log, pocket_type::CONTAINER );
    capture_debugmsg_during( [&purse, &overfull_contents]() {
        purse.combine( overfull_contents );
    } );
    map &here = get_map();
    here.i_clear( origin );
    purse.overflow( here, origin );
    CHECK( here.i_at( origin ).size() == 1 );
}

TEST_CASE( "overflow_test", "[item]" )
{
    clear_map_without_vision();
    tripoint_bub_ms origin{ 60, 60, 0 };
    item purse( itype_purse );
    item log( itype_log );
    purse.force_insert_item( log, pocket_type::MIGRATION );
    map &here = get_map();
    purse.overflow( here, origin );
    CHECK( here.i_at( origin ).size() == 1 );
}

TEST_CASE( "overflow_test_into_parent_item", "[item]" )
{
    map &here = get_map();

    clear_map_without_vision();
    tripoint_bub_ms origin{ 60, 60, 0 };
    item jar( itype_jar_glass_sealed );
    item pickle( itype_pickle );
    pickle.force_insert_item( pickle, pocket_type::MIGRATION );
    jar.put_in( pickle, pocket_type::CONTAINER );
    int contents_pre = 0;
    for( item *it : jar.all_items_top() ) {
        contents_pre += it->count();
    }
    REQUIRE( contents_pre == 1 );

    item_location jar_loc( map_cursor( origin ), &jar );
    jar_loc.overflow( here );
    CHECK( here.i_at( origin ).empty() );

    int contents_count = 0;
    for( item *it : jar.all_items_top() ) {
        contents_count += it->count();
    }
    CHECK( contents_count == 2 );
}
