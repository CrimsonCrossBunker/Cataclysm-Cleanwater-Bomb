#include <set>
#include <optional>
#include <list>
#include <string>

#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "explosion.h"
#include "item.h"
#include "item_location.h"
#include "itype.h"
#include "iuse.h"
#include "iuse_actor.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "monster.h"
#include "player_helpers.h"
#include "pocket_type.h"
#include "projectile.h"
#include "sling.h"
#include "coordinates.h"
#include "item_transformation.h"
#include "point.h"
#include "ret_val.h"
#include "type_id.h"

static const ammo_effect_str_id ammo_effect_STOP_ON_CONTACT( "STOP_ON_CONTACT" );
static const itype_id itype_test_backpack( "test_backpack" );
static const itype_id itype_test_sling_payload( "test_sling_payload" );
static const itype_id itype_test_sling_payload_active( "test_sling_payload_active" );
static const itype_id itype_test_throwing_aid( "test_throwing_aid" );
static const itype_id itype_test_throwing_firestarter( "test_throwing_firestarter" );
static const itype_id itype_test_throwing_plain( "test_throwing_plain" );
static const itype_id itype_test_throwing_stack( "test_throwing_stack" );
static const skill_id skill_throw( "throw" );
static const ter_str_id ter_test_t_throwing_wall( "test_t_throwing_wall" );

static item_location prepare_sling( const itype_id &ammo_id = itype_test_sling_payload,
                                    int count = 2 )
{
    clear_avatar();
    clear_map_without_vision();
    set_time_to_day();
    avatar &you = get_avatar();
    you.setpos( get_map(), tripoint_bub_ms( 60, 60, 0 ) );
    you.set_skill_level( skill_throw, 10 );
    item sling( itype_test_throwing_aid );
    REQUIRE( you.wield( sling ) );
    item bag( itype_test_backpack );
    item ammo( ammo_id );
    if( ammo.count_by_charges() ) {
        ammo.charges = count;
    }
    REQUIRE( bag.put_in( ammo, pocket_type::CONTAINER ).success() );
    const auto worn = you.wear_item( bag, false, false );
    REQUIRE( worn );
    item_location bag_loc( you, & **worn );
    item_location result( bag_loc, &bag_loc->only_item() );
    REQUIRE( result.held_by( you ) );
    return result;
}

TEST_CASE( "sling_cancel_and_invalid_shots_preserve_inventory", "[ranged][sling]" )
{
    item_location ammo = prepare_sling();
    avatar &you = get_avatar();
    const int moves = you.get_moves();
    const int stamina = you.get_stamina();
    REQUIRE( can_launch_sling( you, ammo ).success() );

    SECTION( "cancel" ) {
        CHECK_FALSE( launch_sling( you, ammo, std::nullopt ) );
    }
    SECTION( "self" ) {
        CHECK_FALSE( launch_sling( you, ammo, you.pos_bub() ) );
    }
    SECTION( "out_of_range" ) {
        CHECK_FALSE( launch_sling( you, ammo, you.pos_bub() + tripoint( 100, 0, 0 ) ) );
    }
    CHECK( ammo );
    CHECK( ammo->count() == 2 );
    CHECK( ammo->typeId() == itype_test_sling_payload );
    CHECK_FALSE( ammo->active );
    CHECK( you.get_moves() == moves );
    CHECK( you.get_stamina() == stamina );
    CHECK( you.get_wielded_item()->typeId() == itype_test_throwing_aid );
}

TEST_CASE( "sling_launch_uses_one_round_and_retains_fuse", "[ranged][sling]" )
{
    const int count = GENERATE( 1, 3 );
    item_location ammo = prepare_sling( itype_test_sling_payload, count );
    avatar &you = get_avatar();
    const int moves = you.get_moves();
    const int stamina = you.get_stamina();
    const int cost = sling_launch_moves( you, ammo );
    const auto attack = launch_sling( you, ammo, you.pos_bub() + tripoint( 4, 0, 0 ) );
    REQUIRE( attack );
    CHECK( you.get_moves() == moves - cost );
    CHECK( you.get_stamina() < stamina );
    CHECK( you.get_wielded_item()->typeId() == itype_test_throwing_aid );
    if( count > 1 ) {
        REQUIRE( ammo );
        CHECK( ammo->count() == count - 1 );
        CHECK_FALSE( ammo->active );
    } else {
        CHECK_FALSE( ammo );
    }
    const item &drop = attack->proj.get_drop();
    CHECK( drop.typeId() == itype_test_sling_payload_active );
    CHECK( drop.active );
    CHECK( drop.countdown_point == calendar::turn + 5_seconds );
    CHECK( attack->proj.proj_effects.count( ammo_effect_STOP_ON_CONTACT ) == 1 );
    // No gun-ammo immediate explosion: the live item must be on the ground.
    map_stack stack = get_map().i_at( attack->end_point );
    REQUIRE( stack.size() == 1 );
    item &landed = *stack.begin();
    CHECK( landed.typeId() == itype_test_sling_payload_active );
    CHECK_FALSE( landed.process( get_map(), nullptr, attack->end_point ) );
    calendar::turn += 5_seconds;
    CHECK( landed.process( get_map(), nullptr, attack->end_point ) );
    explosion_handler::process_explosions();
}

TEST_CASE( "sling_stops_at_front_creature_or_wall", "[ranged][sling]" )
{
    item_location ammo = prepare_sling();
    avatar &you = get_avatar();
    const tripoint_bub_ms front = you.pos_bub() + tripoint::east;
    const tripoint_bub_ms back = you.pos_bub() + tripoint( 4, 0, 0 );
    SECTION( "front_creature" ) {
        monster &mon = spawn_test_monster( "mon_test_zombie", front );
        mon.set_moves( 0 );
        const auto attack = launch_sling( you, ammo, back );
        REQUIRE( attack );
        CHECK( attack->end_point == front );
        CHECK( get_map().i_at( front ).size() == 1 );
        CHECK( get_map().i_at( back ).empty() );
    }
    SECTION( "wall" ) {
        get_map().ter_set( front, ter_test_t_throwing_wall );
        const auto attack = launch_sling( you, ammo, back );
        REQUIRE( attack );
        CHECK( attack->end_point == you.pos_bub() );
        CHECK( get_map().i_at( back ).empty() );
    }
}

TEST_CASE( "sling_ignition_requirements_and_hand_activation", "[ranged][sling]" )
{
    const std::string id = GENERATE( "test_sling_payload", "test_sling_payload_fire" );
    CAPTURE( id );
    item_location ammo = prepare_sling( itype_id( id ) );
    avatar &you = get_avatar();
    const iuse_transform *activation = dynamic_cast<const iuse_transform *>(
                                           ammo->type->get_use( "transform" )->get_actor_ptr() );
    REQUIRE( activation );
    if( activation->need_fire ) {
        CHECK_FALSE( can_launch_sling( you, ammo ).success() );
        const int before = you.get_moves();
        CHECK_FALSE( launch_sling( you, ammo, you.pos_bub() + tripoint( 4, 0, 0 ) ) );
        CHECK( you.get_moves() == before );
        CHECK_FALSE( ammo->active );
    }
    const item_location lighter = you.i_add( tool_with_ammo( itype_test_throwing_firestarter,
                                  100 ) );
    REQUIRE( lighter );
    INFO( can_launch_sling( you, ammo ).str() );
    REQUIRE( can_launch_sling( you, ammo ).success() );
    SECTION( "underwater_ignition" ) {
        you.set_underwater( true );
        CHECK( can_launch_sling( you, ammo ).success() == ( activation->need_fire == 0 ) );
    }
    SECTION( "cancel_does_not_use_fire" ) {
        const int charges = lighter->ammo_remaining();
        CHECK_FALSE( launch_sling( you, ammo, std::nullopt ) );
        CHECK( lighter->ammo_remaining() == charges );
        CHECK_FALSE( ammo->active );
    }
    SECTION( "launch_activates_matching_item" ) {
        const auto attack = launch_sling( you, ammo, you.pos_bub() + tripoint( 4, 0, 0 ) );
        REQUIRE( attack );
        CHECK( attack->proj.get_drop().typeId() == activation->transform.target );
        CHECK( attack->proj.get_drop().active );
    }
    SECTION( "hand_use_keeps_original_requirements" ) {
        CHECK_FALSE( activation->can_use( you, *ammo, &get_map(), you.pos_bub() ).success() );
        item round = *ammo;
        round.charges = 1;
        you.remove_weapon();
        REQUIRE( you.wield( round ) );
        item &held = *you.get_wielded_item();
        REQUIRE( activation->can_use( you, held, &get_map(), you.pos_bub() ).success() );
        REQUIRE( activation->use( &you, held, &get_map(), you.pos_bub() ) );
        CHECK( held.typeId() == activation->transform.target );
        CHECK( held.active );
        const dealt_projectile_attack thrown = you.throw_item( you.pos_bub() + tripoint( 4, 0, 0 ),
                                               held );
        CHECK( thrown.proj.proj_effects.count( ammo_effect_STOP_ON_CONTACT ) == 0 );
    }
}

TEST_CASE( "sling_rejects_incompatible_ammunition_and_missing_launcher", "[ranged][sling]" )
{
    item_location ammo = prepare_sling();
    avatar &you = get_avatar();
    CHECK_FALSE( is_sling_ammunition( item( itype_test_throwing_plain ) ) );
    CHECK_FALSE( is_sling_ammunition( item( itype_test_sling_payload_active ) ) );
    CHECK_FALSE( is_sling_ammunition( item( itype_test_throwing_stack ) ) );
    CHECK_FALSE( can_launch_sling( you, item_location() ).success() );
    you.remove_weapon();
    item rock( itype_test_throwing_stack );
    REQUIRE( you.wield( rock ) );
    CHECK_FALSE( can_launch_sling( you, ammo ).success() );
}
