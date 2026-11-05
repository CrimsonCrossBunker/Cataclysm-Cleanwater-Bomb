#include <list>
#include <sstream>
#include <string>

#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "character.h"
#include "character_attire.h"
#include "coordinates.h"
#include "flexbuffer_json.h"
#include "item.h"
#include "item_group.h"
#include "item_location.h"
#include "item_pocket.h"
#include "json.h"
#include "json_loader.h"
#include "map.h"
#include "map_helpers.h"
#include "player_helpers.h"
#include "pocket_type.h"
#include "ret_val.h"
#include "type_id.h"
#include "units.h"

static const ammotype ammo_battery( "battery" );
static const flag_id flag_IRREMOVABLE( "IRREMOVABLE" );
static const itype_id itype_UPS_ON( "UPS_ON" );
static const itype_id itype_backpack( "backpack" );
static const itype_id itype_battery( "battery" );
static const itype_id itype_battery_bionic( "battery_bionic" );
static const itype_id itype_battery_ups( "battery_ups" );
static const itype_id itype_rebreather_cartridge_regen( "rebreather_cartridge_regen" );
static const itype_id itype_rm13_armor( "rm13_armor" );
static const itype_id itype_rm13_armor_on( "rm13_armor_on" );
static const itype_id itype_rm13_armor_rebreather_on( "rm13_armor_rebreather_on" );
static const itype_id itype_rm13_battery( "rm13_battery" );

TEST_CASE( "rm13_default_battery_can_be_unloaded", "[item][battery][rm13]" )
{
    clear_avatar();
    clear_map();
    avatar &you = get_avatar();
    item armor( itype_rm13_armor );
    armor.ammo_set( itype_battery, 5000 );
    REQUIRE( armor.magazine_current() != nullptr );
    REQUIRE( armor.magazine_current()->typeId() == itype_rm13_battery );
    CHECK_FALSE( armor.magazine_current()->has_flag( flag_IRREMOVABLE ) );
    REQUIRE( armor.ammo_remaining_in_pocket( "battery" ) == 5000 );
    item_location carried = you.i_add( armor );
    REQUIRE( you.unload( carried, true ) );
    CHECK( carried->magazine_current() == nullptr );
    CHECK( carried->ammo_remaining_in_pocket( "battery" ) == 0 );
    CHECK( carried->can_reload_with( item( itype_rm13_battery ), true ) );
}

TEST_CASE( "rm13_magazine_wells_hold_one_magazine", "[item][battery][rm13]" )
{
    item armor( itype_rm13_armor );
    armor.dress_magazine_wells( true, true );
    REQUIRE( armor.magazines_current().size() == 2 );
    CHECK( armor.ammo_remaining_in_pocket( "battery" ) == 5000 );
    CHECK_FALSE( armor.pocket_by_id( "battery" )->can_contain(
                     item( itype_rm13_battery ) ).success() );
    CHECK_FALSE( armor.pocket_by_id( "rebreather" )->can_contain(
                     item( itype_rebreather_cartridge_regen ) ).success() );
    armor.dress_magazine_wells( true, true );
    CHECK( armor.magazines_current().size() == 2 );
}

TEST_CASE( "rm13_item_group_populates_default_magazines", "[item][battery][rm13][item_group]" )
{
    item armor( itype_rm13_armor );
    Item_modifier modifier;
    modifier.with_ammo = 100;
    modifier.with_magazine = 100;
    modifier.modify( armor, "RM13 default magazine regression" );
    REQUIRE( armor.magazines_current().size() == 2 );
    CHECK( armor.ammo_remaining_in_pocket( "battery" ) == 5000 );
    REQUIRE( armor.pocket_by_id( "rebreather" )->magazine_current() != nullptr );
    CHECK( armor.pocket_by_id( "rebreather" )->magazine_current()->typeId() ==
           itype_rebreather_cartridge_regen );
}

TEST_CASE( "rm13_power_mod_removes_only_battery_well", "[item][battery][toolmod][rm13][save]" )
{
    const itype_id mod = GENERATE( itype_battery_ups, itype_battery_bionic );
    const itype_id armor_type = GENERATE( itype_rm13_armor, itype_rm13_armor_on,
                                          itype_rm13_armor_rebreather_on );
    item armor( armor_type );
    REQUIRE( armor.put_in( item( itype_rebreather_cartridge_regen ),
                           pocket_type::MAGAZINE_WELL ).success() );
    const int rebreather_charges = armor.ammo_remaining_in_pocket( "rebreather" );
    REQUIRE( armor.put_in( item( mod ), pocket_type::MOD ).success() );
    for( const itype_id &state : {
             armor_type, itype_rm13_armor_on, itype_rm13_armor
         } ) {
        armor.convert( state );
        armor.dress_magazine_wells( true, false );
        CHECK( armor.pocket_by_id( "battery" ) == nullptr );
        REQUIRE( armor.pocket_by_id( "rebreather" ) != nullptr );
        CHECK( armor.ammo_capacity( ammo_battery ) == 0 );
        CHECK_FALSE( armor.is_chargeable() );
        CHECK_FALSE( armor.can_reload_with( item( itype_rm13_battery ), false ) );
        CHECK( armor.can_reload_with( item( itype_rebreather_cartridge_regen ), false ) );
        CHECK( armor.magazines_current().size() == 1 );
        CHECK( armor.ammo_remaining_in_pocket( "rebreather" ) == rebreather_charges );
        std::ostringstream stream;
        JsonOut json( stream );
        armor.serialize( json );
        item restored;
        restored.deserialize( json_loader::from_string( stream.str() ).get_object() );
        armor = restored;
        CHECK( armor.pocket_by_id( "battery" ) == nullptr );
        CHECK( armor.magazines_current().size() == 1 );
        CHECK( armor.ammo_remaining_in_pocket( "rebreather" ) == rebreather_charges );
    }
}

TEST_CASE( "rm13_power_mod_consumes_external_energy", "[item][battery][toolmod][rm13]" )
{
    clear_avatar();
    clear_map();
    avatar &you = get_avatar();
    you.set_power_level( 0_kJ );
    you.worn.wear_item( you, item( itype_backpack ), false, false );
    map &here = get_map();
    const bool ups_power = GENERATE( false, true );
    const bool rebreather = GENERATE( false, true );
    item armor( rebreather ? itype_rm13_armor_rebreather_on : itype_rm13_armor_on );
    REQUIRE( armor.put_in( item( ups_power ? itype_battery_ups : itype_battery_bionic ),
                           pocket_type::MOD ).success() );
    if( rebreather ) {
        item cartridge( itype_rebreather_cartridge_regen );
        cartridge.ammo_set( cartridge.ammo_default() );
        REQUIRE( armor.put_in( cartridge,
                               pocket_type::MAGAZINE_WELL ).success() );
    }
    CHECK( armor.consume_tool_uses( 1, here, you.pos_bub(), &you ) == 0 );
    const int rebreather_before = armor.ammo_remaining_in_pocket( "rebreather" );
    if( ups_power ) {
        item ups( itype_UPS_ON );
        item battery( ups.magazine_default() );
        battery.ammo_set( battery.ammo_default(), 10 );
        REQUIRE( ups.put_in( battery, pocket_type::MAGAZINE_WELL ).success() );
        you.i_add( ups );
        REQUIRE( you.available_ups() == 10_kJ );
    } else {
        you.set_max_power_level( 10_kJ );
        you.set_power_level( 10_kJ );
    }
    REQUIRE( armor.consume_tool_uses( 1, here, you.pos_bub(), &you ) == 1 );
    const units::energy remaining = ups_power ? you.available_ups() : you.get_power_level();
    CHECK( remaining == ( rebreather ? 7_kJ : 9_kJ ) );
    CHECK( armor.ammo_remaining_in_pocket( "rebreather" ) ==
           rebreather_before - ( rebreather ? 1 : 0 ) );
    CHECK( armor.pocket_by_id( "battery" ) == nullptr );
    CHECK_FALSE( armor.is_chargeable() );
}

TEST_CASE( "external_power_mod_removes_battery_only_tool_wells", "[item][battery][toolmod]" )
{
    const itype_id mod = GENERATE( itype_battery_ups, itype_battery_bionic );
    const std::string tool_id = GENERATE( "diving_flashlight_small_hipower", "wearable_light" );
    item tool{ itype_id( tool_id ) };
    REQUIRE( tool.put_in( item( mod ), pocket_type::MOD ).success() );
    CHECK_FALSE( tool.has_pocket_type( pocket_type::MAGAZINE_WELL ) );
    CHECK( tool.ammo_capacity( ammo_battery ) == 0 );
    CHECK_FALSE( tool.is_reloadable() );
    CHECK_FALSE( tool.is_chargeable() );
}

TEST_CASE( "rm13_power_mod_preserves_preexisting_battery", "[item][battery][toolmod][rm13][save]" )
{
    item armor( itype_rm13_armor );
    armor.ammo_set( itype_battery, 1234 );
    REQUIRE( armor.put_in( item( itype_battery_ups ), pocket_type::MOD ).success() );
    for( const itype_id &state : {
             itype_rm13_armor, itype_rm13_armor_on, itype_rm13_armor
         } ) {
        armor.convert( state );
        CHECK( armor.pocket_by_id( "battery" ) == nullptr );
        const std::list<item *> batteries = armor.all_items_top( pocket_type::MIGRATION );
        REQUIRE( batteries.size() == 1 );
        CHECK( batteries.front()->typeId() == itype_rm13_battery );
        CHECK( batteries.front()->ammo_remaining() == 1234 );
        std::ostringstream stream;
        JsonOut json( stream );
        armor.serialize( json );
        item restored;
        restored.deserialize( json_loader::from_string( stream.str() ).get_object() );
        armor = restored;
    }
}
