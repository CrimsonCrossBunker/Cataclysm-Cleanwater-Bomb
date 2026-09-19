#include "avatar.h"
#include "avatar_action.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "coordinates.h"
#include "game.h"
#include "item.h"
#include "map.h"
#include "map_helpers.h"
#include "options_helpers.h"
#include "player_activity.h"
#include "player_helpers.h"
#include "point.h"
#include "type_id.h"

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
    here.ter_set( target, ter_id( "t_rock" ) );
    const bool fueled = GENERATE( false, true );
    item tool( itype_id( "elec_jackhammer_mining" ) );
    tool.ammo_set( itype_id( "battery" ), fueled ? 7920 : 0 );
    REQUIRE( you.wield( tool ) );

    avatar_action::move( you, here, tripoint_rel_ms::east );

    CHECK( you.pos_bub() == pos );
    if( fueled ) {
        CHECK( you.activity.id() == activity_id( "ACT_JACKHAMMER" ) );
        CHECK( you.has_destination() );
    } else {
        CHECK_FALSE( you.activity );
        CHECK_FALSE( you.has_destination() );
    }
}
