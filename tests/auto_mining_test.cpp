#include <string>

#include "avatar.h"
#include "avatar_action.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "coordinates.h"
#include "game.h"
#include "item.h"
#include "item_location.h"
#include "itype.h"
#include "flag.h"
#include "map.h"
#include "map_helpers.h"
#include "options_helpers.h"
#include "player_activity.h"
#include "player_helpers.h"
#include "point.h"
#include "type_id.h"

static const activity_id ACT_JACKHAMMER( "ACT_JACKHAMMER" );

static const itype_id itype_battery( "battery" );
static const itype_id itype_bronze_pickaxe( "bronze_pickaxe" );
static const itype_id itype_corded_demolition_hammer( "corded_demolition_hammer" );
static const itype_id itype_elec_jackhammer( "elec_jackhammer" );
static const itype_id itype_elec_jackhammer_mining( "elec_jackhammer_mining" );
static const itype_id itype_exodii_digger( "exodii_digger" );
static const itype_id itype_gasoline( "gasoline" );
static const itype_id itype_jackhammer( "jackhammer" );
static const itype_id itype_jackhammer_mining( "jackhammer_mining" );
static const itype_id itype_pickaxe( "pickaxe" );

static const ter_str_id ter_t_rock( "t_rock" );

TEST_CASE( "automatic_mining_recognizes_powered_mining_tools", "[movement][mining]" )
{
    clear_avatar();
    clear_map_without_vision();
    avatar &you = get_avatar();
    map &here = get_map();
    const override_option auto_features( "AUTO_FEATURES", "true" );
    const override_option auto_mining( "AUTO_MINING", "true" );
    restore_on_out_of_scope restore_mostseen( g->mostseen );
    g->mostseen = 0;
    const tripoint_bub_ms pos = you.pos_bub();
    const tripoint_bub_ms target = pos + tripoint::east;
    here.ter_set( target, ter_t_rock );
    const bool fueled = GENERATE( false, true );
    const itype_id tool_id = GENERATE( itype_elec_jackhammer, itype_elec_jackhammer_mining,
                                       itype_jackhammer, itype_jackhammer_mining );
    CAPTURE( tool_id.str() );
    item tool( tool_id );
    const bool electric = tool_id == itype_elec_jackhammer || tool_id == itype_elec_jackhammer_mining;
    tool.ammo_set( electric ? itype_battery : itype_gasoline, fueled ? ( electric ? 7920 : 1200 ) : 0 );
    REQUIRE( you.wield( tool ) );

    const bool automatic = GENERATE( false, true );
    if( automatic ) {
        avatar_action::move( you, here, tripoint_rel_ms::east );
    } else {
        you.invoke_item( &*you.get_wielded_item(), "JACKHAMMER", target );
    }

    CHECK( you.pos_bub() == pos );
    if( fueled ) {
        CHECK( you.activity.id() == ACT_JACKHAMMER );
        CHECK( you.has_destination() == automatic );
    } else {
        CHECK_FALSE( you.activity );
        CHECK_FALSE( you.has_destination() );
    }
}

TEST_CASE( "listed_dig_tools_have_usable_rock_mining_actions", "[items][mining]" )
{
    const itype_id id = GENERATE( itype_corded_demolition_hammer, itype_elec_jackhammer,
                                  itype_elec_jackhammer_mining, itype_jackhammer,
                                  itype_jackhammer_mining, itype_exodii_digger,
                                  itype_pickaxe, itype_bronze_pickaxe );
    CAPTURE( id.str() );
    item tool( id );
    REQUIRE( tool.has_flag( flag_DIG_TOOL ) );
    const bool pickaxe = tool.type->can_use( "PICKAXE" );
    REQUIRE( ( pickaxe || tool.type->can_use( "JACKHAMMER" ) ) );
    if( !pickaxe ) {
        CHECK( tool.has_flag( flag_MULTI_DRILL ) );
    }
}
