#include <initializer_list>
#include <list>
#include <optional>
#include <sstream>
#include <string>
#include <utility>
#include <vector>

#include "avatar.h"
#include "cata_catch.h"
#include "character_attire.h"
#include "coordinates.h"
#include "damage.h"
#include "flexbuffer_json.h"
#include "item.h"
#include "item_group.h"
#include "item_location.h"
#include "item_pocket.h"
#include "json.h"
#include "json_loader.h"
#include "map.h"
#include "map_helpers.h"
#include "messages.h"
#include "player_helpers.h"
#include "pocket_type.h"
#include "ret_val.h"
#include "type_id.h"
#include "units.h"

static const ammotype ammo_battery( "battery" );
static const damage_type_id damage_bash( "bash" );
static const flag_id json_flag_IRREMOVABLE( "IRREMOVABLE" );
static const itype_id itype_UPS_ON( "UPS_ON" );
static const itype_id itype_backpack( "backpack" );
static const itype_id itype_battery( "battery" );
static const itype_id itype_battery_bionic( "battery_bionic" );
static const itype_id itype_battery_ups( "battery_ups" );
static const itype_id itype_methanol_fuel_cell( "methanol_fuel_cell" );
static const itype_id itype_rebreather_cartridge_regen( "rebreather_cartridge_regen" );
static const itype_id itype_rm13_armor( "rm13_armor" );
static const itype_id itype_rm13_armor_on( "rm13_armor_on" );
static const itype_id itype_rm13_armor_rebreather_on( "rm13_armor_rebreather_on" );
static const itype_id itype_rm13_battery( "rm13_battery" );
static const sub_bodypart_str_id sub_body_part_torso_upper( "torso_upper" );

TEST_CASE( "rm13_default_battery_can_be_unloaded", "[item][battery][rm13]" )
{
    clear_avatar();
    clear_map();
    avatar &you = get_avatar();
    item armor( itype_rm13_armor );
    armor.ammo_set( itype_battery, 5000 );
    REQUIRE( armor.magazine_current() != nullptr );
    REQUIRE( armor.magazine_current()->typeId() == itype_rm13_battery );
    CHECK_FALSE( armor.magazine_current()->has_flag( json_flag_IRREMOVABLE ) );
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

TEST_CASE( "rm13_hit_uses_the_installed_power_source", "[item][battery][toolmod][rm13][armor]" )
{
    clear_avatar();
    clear_map();
    avatar &you = get_avatar();
    you.set_power_level( 0_kJ );
    you.worn.wear_item( you, item( itype_backpack ), false, false );
    const itype_id source = GENERATE( itype_rm13_battery, itype_battery_ups, itype_battery_bionic );
    const bool rebreather = GENERATE( false, true );
    const bool subpart = GENERATE( false, true );
    const int stored = GENERATE( 0, 10 );
    const float hit_damage = GENERATE( 0.25f, 3.0f, 10.0f, 11.0f );
    item armor( rebreather ? itype_rm13_armor_rebreather_on : itype_rm13_armor_on );
    if( source == itype_rm13_battery ) {
        armor.ammo_set( itype_battery, stored );
    } else {
        REQUIRE( armor.put_in( item( source ), pocket_type::MOD ).success() );
        if( source == itype_battery_ups ) {
            item ups( itype_UPS_ON );
            item battery( ups.magazine_default() );
            battery.ammo_set( battery.ammo_default(), stored );
            REQUIRE( ups.put_in( battery, pocket_type::MAGAZINE_WELL ).success() );
            you.i_add( ups );
        } else {
            you.set_max_power_level( 10_kJ );
            you.set_power_level( stored * 1_kJ );
        }
    }
    if( rebreather ) {
        item cartridge( itype_rebreather_cartridge_regen );
        cartridge.ammo_set( cartridge.ammo_default() );
        REQUIRE( armor.put_in( cartridge, pocket_type::MAGAZINE_WELL ).success() );
    }
    const std::optional<std::list<item>::iterator> worn =
        you.worn.wear_item( you, armor, false, false );
    REQUIRE( worn.has_value() );
    item &worn_armor = **worn;
    REQUIRE( worn_armor.active );
    REQUIRE( worn_armor.energy_remaining( &you ) == stored * 1_kJ );
    const int rebreather_before = worn_armor.ammo_remaining_in_pocket( "rebreather" );
    damage_unit hit( damage_bash, hit_damage );
    const bodypart_id torso( "torso" );
    if( subpart ) {
        const sub_bodypart_id upper_torso = sub_body_part_torso_upper.id();
        you.armor_absorb( hit, worn_armor, torso, upper_torso, 0, false );
    } else {
        you.armor_absorb( hit, worn_armor, torso, 0, false );
    }
    const bool sufficient = stored >= hit_damage;
    CHECK( worn_armor.active == sufficient );
    CHECK( worn_armor.typeId() == ( sufficient ? armor.typeId() : itype_rm13_armor ) );
    CHECK( worn_armor.energy_remaining( &you ) ==
           units::from_kilojoule( sufficient ? stored - hit_damage : stored ) );
    CHECK( worn_armor.ammo_remaining_in_pocket( "rebreather" ) == rebreather_before );
}

TEST_CASE( "ups_available_energy_includes_partial_battery_charges", "[item][battery][rm13][ups]" )
{
    clear_avatar();
    avatar &you = get_avatar();
    you.set_power_level( 0_kJ );
    you.worn.wear_item( you, item( itype_backpack ), false, false );
    item ups( itype_UPS_ON );
    item battery( ups.magazine_default() );
    battery.ammo_set( battery.ammo_default(), 1 );
    REQUIRE( ups.put_in( battery, pocket_type::MAGAZINE_WELL ).success() );
    you.i_add( ups );
    REQUIRE( you.available_ups() == 1_kJ );
    CHECK( you.consume_ups( 250_J ) == 250_J );
    CHECK( you.available_ups() == 750_J );
    CHECK( you.consume_ups( 750_J ) == 750_J );
    CHECK( you.available_ups() == 0_J );
}

TEST_CASE( "rm13_external_power_requirements_do_not_request_batteries",
           "[item][battery][toolmod][rm13][messages]" )
{
    clear_avatar();
    avatar &you = get_avatar();
    you.set_power_level( 0_kJ );
    const itype_id mod = GENERATE( itype_battery_ups, itype_battery_bionic );
    const bool rebreather = GENERATE( false, true );
    item armor( rebreather ? itype_rm13_armor_rebreather_on : itype_rm13_armor );
    REQUIRE( armor.put_in( item( mod ), pocket_type::MOD ).success() );
    const std::string source = mod == itype_battery_ups ? "UPS" : "bionic";
    const std::string requirements = armor.format_consumption_requirements();
    CHECK( requirements.find( source ) != std::string::npos );
    CHECK( requirements.find( "battery" ) == std::string::npos );
    if( mod == itype_battery_ups ) {
        CHECK( requirements.find( rebreather ? "3 charges from some UPS" :
                                  "1 charge from some UPS" ) == 0 );
    } else {
        CHECK( requirements.find( rebreather ? "3 kJ of bionic power" :
                                  "1 kJ of bionic power" ) == 0 );
    }
    if( rebreather ) {
        CHECK( requirements.find( " + " ) != std::string::npos );
    }
    Messages::clear_messages();
    const itype_id original_type = armor.typeId();
    CHECK_FALSE( you.invoke_item( &armor, "transform" ) );
    CHECK( armor.typeId() == original_type );
    REQUIRE( Messages::size() > 0 );
    for( const std::pair<std::string, std::string> &message : Messages::recent_messages( 0 ) ) {
        INFO( message.second );
        CHECK( message.second.find( source ) != std::string::npos );
        CHECK( message.second.find( "battery" ) == std::string::npos );
    }
}

TEST_CASE( "ups_fuel_sources_keep_charge_based_availability", "[item][battery][ups]" )
{
    clear_avatar();
    avatar &you = get_avatar();
    you.set_power_level( 0_kJ );
    you.worn.wear_item( you, item( itype_backpack ), false, false );
    item ups( itype_methanol_fuel_cell );
    item fuel( ups.magazine_default() );
    fuel.ammo_set( fuel.ammo_default(), 2 );
    REQUIRE( ups.put_in( fuel, pocket_type::MAGAZINE_WELL ).success() );
    REQUIRE_FALSE( ups.uses_energy() );
    REQUIRE( ups.ammo_remaining() == 2 );
    you.i_add( ups );
    CHECK( you.available_ups() == 2_kJ );
}

TEST_CASE( "rm13_external_power_activation_does_not_require_a_battery",
           "[item][battery][toolmod][rm13][messages]" )
{
    clear_avatar();
    clear_map();
    avatar &you = get_avatar();
    you.set_power_level( 0_kJ );
    you.worn.wear_item( you, item( itype_backpack ), false, false );
    const bool ups_power = GENERATE( false, true );
    const bool rebreather = GENERATE( false, true );
    item armor( itype_rm13_armor );
    REQUIRE( armor.put_in( item( ups_power ? itype_battery_ups : itype_battery_bionic ),
                           pocket_type::MOD ).success() );
    if( ups_power ) {
        item ups( itype_UPS_ON );
        item battery( ups.magazine_default() );
        battery.ammo_set( battery.ammo_default(), 10 );
        REQUIRE( ups.put_in( battery, pocket_type::MAGAZINE_WELL ).success() );
        you.i_add( ups );
    } else {
        you.set_max_power_level( 10_kJ );
        you.set_power_level( 10_kJ );
    }
    if( rebreather ) {
        item cartridge( itype_rebreather_cartridge_regen );
        cartridge.ammo_set( cartridge.ammo_default() );
        REQUIRE( armor.put_in( cartridge, pocket_type::MAGAZINE_WELL ).success() );
    }
    const std::optional<std::list<item>::iterator> worn =
        you.worn.wear_item( you, armor, false, false );
    REQUIRE( worn.has_value() );
    item &worn_armor = **worn;
    Messages::clear_messages();
    you.invoke_item( &worn_armor, rebreather ? "transform" : "effect_on_conditions" );
    CHECK( worn_armor.active );
    CHECK( worn_armor.typeId() ==
           ( rebreather ? itype_rm13_armor_rebreather_on : itype_rm13_armor_on ) );
    CHECK( worn_armor.pocket_by_id( "battery" ) == nullptr );
    for( const std::pair<std::string, std::string> &message : Messages::recent_messages( 0 ) ) {
        INFO( message.second );
        CHECK( message.second.find( "battery" ) == std::string::npos );
    }
}
