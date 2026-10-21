#include <sstream>
#include <string>

#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "flag.h"
#include "item.h"
#include "item_location.h"
#include "itype.h"
#include "json.h"
#include "json_loader.h"
#include "map.h"
#include "map_helpers.h"
#include "map_selector.h"
#include "player_helpers.h"
#include "pocket_type.h"
#include "point.h"
#include "type_id.h"

static const ammotype ammo_shot( "shot" );
static const gun_mode_id gun_mode_BURST( "BURST" );
static const gun_mode_id gun_mode_DEFAULT( "DEFAULT" );
static const gun_mode_id gun_mode_KSG_AUX_SHOTGUN_DEFAULT( "KSG_AUX_SHOTGUN_DEFAULT" );
static const itype_id itype_dp_12( "dp_12" );
static const itype_id itype_ksg( "ksg" );
static const itype_id itype_ksg_aux_shotgun( "ksg_aux_shotgun" );
static const itype_id itype_shot_00( "shot_00" );
static const itype_id itype_shot_slug( "shot_slug" );

static item saved_and_loaded( const item &original )
{
    std::ostringstream stream;
    JsonOut json( stream );
    original.serialize( json );
    item loaded;
    loaded.deserialize( json_loader::from_string( stream.str() ).get_object() );
    return loaded;
}

TEST_CASE( "ksg_tubes_reload_and_fire_independently", "[gun][reload][shotgun_tubes]" )
{
    clear_avatar();
    clear_map();
    avatar &you = get_avatar();
    map &here = get_map();
    you.set_wielded_item( item( itype_ksg ) );
    item &gun = *you.get_wielded_item();
    item *second = gun.gunmod_find( itype_ksg_aux_shotgun );
    REQUIRE( second != nullptr );
    REQUIRE( gun.ammo_capacity( ammo_shot ) == 7 );
    REQUIRE( second->ammo_capacity( ammo_shot ) == 7 );
    CHECK( second->has_flag( flag_IRREMOVABLE ) );

    item buckshot( itype_shot_00, calendar::turn_zero, 20 );
    item slugs( itype_shot_slug, calendar::turn_zero, 20 );
    item_location buckshot_loc( map_cursor( you.pos_bub() ),
                                &here.add_item_or_charges( you.pos_bub(), buckshot ) );
    item_location slugs_loc( map_cursor( you.pos_bub() ),
                             &here.add_item_or_charges( you.pos_bub(), slugs ) );
    for( int i = 0; i < 7; ++i ) {
        REQUIRE( gun.reload( you, buckshot_loc, 1 ) );
        REQUIRE( second->reload( you, slugs_loc, 1 ) );
    }
    CHECK_FALSE( gun.reload( you, buckshot_loc, 1 ) );
    CHECK_FALSE( second->reload( you, slugs_loc, 1 ) );
    CHECK( buckshot_loc->charges == 13 );
    CHECK( slugs_loc->charges == 13 );

    // Suppress random mechanical failures; exercise the real firing/ammo path.
    gun.set_flag( flag_NEVER_JAMS );
    second->set_flag( flag_NEVER_JAMS );
    REQUIRE( gun.gun_set_mode( gun_mode_DEFAULT ) );
    REQUIRE( gun.gun_current_mode().target == &gun );
    CHECK( you.fire_gun( here, you.pos_bub() + tripoint( 5, 0, 0 ), 1, gun ) == 1 );
    CHECK( gun.ammo_remaining() == 6 );
    CHECK( second->ammo_remaining() == 7 );

    REQUIRE( gun.gun_set_mode( gun_mode_KSG_AUX_SHOTGUN_DEFAULT ) );
    REQUIRE( gun.gun_current_mode().target == second );
    CHECK( gun.gun_current_mode().target->ammo_current() == itype_shot_slug );
    CHECK( you.fire_gun( here, you.pos_bub() + tripoint( 5, 0, 0 ), 1, *second ) == 1 );
    CHECK( gun.ammo_remaining() == 6 );
    CHECK( second->ammo_remaining() == 6 );

    item loaded = saved_and_loaded( gun );
    REQUIRE( loaded.gunmod_find( itype_ksg_aux_shotgun ) != nullptr );
    CHECK( loaded.gunmods().size() == 1 );
    CHECK( loaded.ammo_remaining() == 6 );
    CHECK( loaded.gunmod_find( itype_ksg_aux_shotgun )->ammo_remaining() == 6 );
    CHECK( loaded.gun_current_mode().target->typeId() == itype_ksg_aux_shotgun );
}

TEST_CASE( "ksg_restores_missing_second_tube_on_load", "[item][save][shotgun_tubes]" )
{
    item gun( itype_ksg );
    gun.remove_items_with( []( const item & mod ) {
        return mod.typeId() == itype_ksg_aux_shotgun;
    } );
    REQUIRE( gun.gunmod_find( itype_ksg_aux_shotgun ) == nullptr );
    const int rounds = GENERATE( 0, 7, 14 );
    CAPTURE( rounds );
    if( rounds > 0 ) {
        gun.ammo_set( itype_shot_00, 7 );
        gun.first_ammo().charges = rounds; // Reproduce the old combined magazine.
    }
    item loaded = saved_and_loaded( gun );
    REQUIRE( loaded.gunmod_find( itype_ksg_aux_shotgun ) != nullptr );
    CHECK( loaded.ammo_remaining() == ( rounds > 7 ? 7 : rounds ) );
    CHECK( loaded.gunmod_find( itype_ksg_aux_shotgun )->ammo_remaining() ==
           ( rounds > 7 ? rounds - 7 : 0 ) );
    CHECK( loaded.gunmods().size() == 1 );
    CHECK( saved_and_loaded( loaded ).gunmods().size() == 1 );
}

TEST_CASE( "dp12_double_mode_fires_two_shells", "[gun][shotgun_tubes]" )
{
    clear_avatar();
    clear_map();
    avatar &you = get_avatar();
    map &here = get_map();
    you.set_wielded_item( item( itype_dp_12 ) );
    item &gun = *you.get_wielded_item();
    REQUIRE( gun.ammo_capacity( ammo_shot ) == 14 );
    gun.set_flag( flag_NEVER_JAMS );
    REQUIRE( gun.gun_set_mode( gun_mode_DEFAULT ) );
    CHECK( gun.gun_current_mode().qty == 1 );
    REQUIRE( gun.gun_set_mode( gun_mode_BURST ) );
    REQUIRE( gun.gun_current_mode().qty == 2 );

    const int rounds = GENERATE( 1, 14 );
    gun.ammo_set( itype_shot_00, rounds );
    const int expected = rounds == 1 ? 1 : 2;
    CHECK( you.fire_gun( here, you.pos_bub() + tripoint( 5, 0, 0 ),
                         gun.gun_current_mode().qty, gun ) == expected );
    CHECK( gun.ammo_remaining() == rounds - expected );
}
