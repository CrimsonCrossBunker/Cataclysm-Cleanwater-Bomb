#include <string>
#include <utility>

#include "activity_actor_definitions.h"
#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_utility.h"
#include "flexbuffer_json.h"
#include "flag.h"
#include "item.h"
#include "item_factory.h"
#include "item_group.h"
#include "item_location.h"
#include "itype.h"
#include "map_helpers.h"
#include "player_activity.h"
#include "player_helpers.h"
#include "pocket_type.h"
#include "ret_val.h"
#include "type_id.h"

static const item_group_id item_group_m27iar( "m27iar" );
static const itype_id itype_bipod( "bipod" );
static const itype_id itype_butt_hook( "butt_hook" );
static const itype_id itype_cheek_pad( "cheek_pad" );
static const itype_id itype_debug_backpack( "debug_backpack" );
static const itype_id itype_grip( "grip" );
static const itype_id itype_high_end_folding_stock( "high_end_folding_stock" );
static const itype_id itype_recoil_stock( "recoil_stock" );
static const itype_id itype_remington_870( "remington_870" );
static const itype_id itype_ree_33( "ree_33" );
static const itype_id itype_ree_33_tripod( "ree_33_tripod" );
static const itype_id itype_scar_h( "scar_h" );
static const itype_id itype_scar_h_mk20( "scar_h_mk20" );
static const itype_id itype_tac338( "tac338" );
static const itype_id itype_wooden_grip( "wooden_grip" );

static void remove_and_reinstall_gunmod( item_location gun, const itype_id &mod_type )
{
    avatar &you = get_avatar();
    item *installed = gun->gunmod_find( mod_type );
    REQUIRE( installed );
    REQUIRE_FALSE( installed->is_irremovable() );
    const auto before_weight = gun->weight();
    REQUIRE( you.gunmod_remove( gun, *installed ) );
    process_activity( you, true );
    REQUIRE_FALSE( gun->gunmod_find( mod_type ) );

    item_location detached;
    for( const item_location &loc : you.all_items_loc() ) {
        if( loc->typeId() == mod_type ) {
            detached = loc;
            break;
        }
    }
    REQUIRE( detached );
    const ret_val<void> compatible = gun->is_gunmod_compatible( *detached );
    INFO( compatible.str() );
    REQUIRE( compatible.success() );
    you.activity = player_activity( gunmod_add_activity_actor( 100, "" ) );
    you.activity.targets = { gun, detached };
    you.activity.values = { 0, 100, 0, 0 };
    you.activity.start_or_resume( you, false );
    process_activity( you, true );
    REQUIRE( gun->gunmod_find( mod_type ) );
    CHECK( gun->weight() == before_weight );

    item loaded;
    deserialize_from_string( loaded, serialize( *gun ) );
    CHECK( loaded.gunmod_find( mod_type ) );
    CHECK( loaded.weight() == before_weight );
}

static void prepare_gunmod_owner()
{
    clear_avatar();
    clear_map_without_vision();
    avatar &you = get_avatar();
    you.set_str_base( 100 );
    REQUIRE( you.wear_item( item( itype_debug_backpack ) ) );
}

TEST_CASE( "detachable_default_stocks_and_naval_tripod_can_be_reinstalled",
           "[item][gunmod][gunmod_mount]" )
{
    const auto example = GENERATE( std::make_pair( itype_scar_h, itype_high_end_folding_stock ),
                                   std::make_pair( itype_scar_h_mk20, itype_recoil_stock ),
                                   std::make_pair( itype_ree_33, itype_ree_33_tripod ),
                                   std::make_pair( itype_tac338, itype_cheek_pad ),
                                   std::make_pair( itype_tac338, itype_butt_hook ) );
    CAPTURE( example.first.str(), example.second.str() );
    prepare_gunmod_owner();
    item_location gun = get_avatar().i_add( item( example.first ) );
    REQUIRE( gun );
    remove_and_reinstall_gunmod( gun, example.second );
}

TEST_CASE( "spawned_m27_keeps_its_bipod_and_foregrip_after_reinstallation",
           "[item][gunmod][gunmod_mount]" )
{
    const itype_id removed = GENERATE( itype_bipod, itype_grip );
    CAPTURE( removed.str() );
    prepare_gunmod_owner();
    item_location gun = get_avatar().i_add( item_group::item_from( item_group_m27iar ) );
    REQUIRE( gun );
    REQUIRE( gun->gunmod_find( itype_bipod ) );
    REQUIRE( gun->gunmod_find( itype_grip ) );
    remove_and_reinstall_gunmod( gun, removed );
    CHECK( gun->gunmod_find( itype_bipod ) );
    CHECK( gun->gunmod_find( itype_grip ) );
    CHECK_FALSE( gun->is_gunmod_compatible( item( itype_wooden_grip ) ).success() );
    CHECK_FALSE( gun->is_gunmod_compatible( item( itype_bipod ) ).success() );
}

TEST_CASE( "bipod_mount_preserves_pump_rail_clearance", "[item][gunmod][gunmod_mount]" )
{
    item gun( itype_remington_870 );
    REQUIRE( gun.get_free_mod_locations( gunmod_location( "bipod" ) ) == 1 );
    gun.set_flag( flag_PUMP_RAIL );
    CHECK_FALSE( gun.is_gunmod_compatible( item( itype_bipod ) ).success() );
}

TEST_CASE( "detachable_default_gunmods_fit_their_mounts", "[item][gunmod][gunmod_mount]" )
{
    for( const itype *type : item_controller->all() ) {
        if( !type->gun || type->gun->default_mods.empty() ) {
            continue;
        }
        item gun( type->get_id() );
        for( const item *mod : gun.gunmods() ) {
            if( mod->is_irremovable() ) {
                continue;
            }
            const gunmod_location &location = mod->type->gunmod->location;
            CAPTURE( type->get_id().str(), mod->typeId().str(), location.str() );
            CHECK( gun.get_free_mod_locations( location ) >= 0 );
        }
    }
}
