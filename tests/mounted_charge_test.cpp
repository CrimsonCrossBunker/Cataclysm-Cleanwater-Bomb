#include "cata_catch.h"

#include <algorithm>
#include <sstream>

#include "activity_actor_definitions.h"
#include "avatar.h"
#include "avatar_action.h"
#include "calendar.h"
#include "damage.h"
#include "flag.h"
#include "item.h"
#include "itype.h"
#include "json.h"
#include "json_loader.h"
#include "lua_platform_loader.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "monster.h"
#include "martialarts.h"
#include "mounted_charge.h"
#include "npc.h"
#include "player_helpers.h"
#include "type_id.h"

namespace
{

monster &setup_mounted_weapon( avatar &player, const itype_id &weapon_type )
{
#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
    static bool platform_world_ready = false;
    if( !platform_world_ready ) {
        cata::lua_platform::on_world_ready( true );
        platform_world_ready = true;
    }
#endif
    clear_avatar();
    clear_map_without_vision();
    clear_creatures();

    monster &horse = spawn_test_monster( "mon_horse", player.pos_bub() + tripoint::east );
    horse.friendly = -1;
    player.mount_creature( horse );
    player.set_wielded_item( item( weapon_type ) );
    player.set_moves( 1000 );
    return horse;
}

monster &setup_mounted_lance( avatar &player )
{
    return setup_mounted_weapon( player, itype_id( "mounted_lance" ) );
}

void start_mounted_charge( avatar &player, monster &horse )
{
    const item_location lance = player.get_wielded_item();
    REQUIRE( lance );
    player.set_moves( 10000 );
    player.assign_activity( mounted_charge_activity_actor(
                                player.pos_abs() + tripoint( 4, 0, 0 ),
                                horse.uid().get_value(), lance->uid().get_value(),
                                player.pos_abs(), lance->typeId() ) );
}

} // namespace

TEST_CASE( "mounted_charge_profile_has_bounded_momentum", "[mounted][charge]" )
{
    mounted_charge_profile profile;
    CHECK_FALSE( profile.valid() );

    profile.max_steps = 15;
    CHECK( profile.valid() );
    CHECK( mounted_charge_stab_multiplier( profile, 0, 300 ) == 1.0f );
    CHECK( mounted_charge_multiplier( profile, 1, 100 ) == Approx( 1.05f ) );
    CHECK( mounted_charge_multiplier( profile, 1, 200 ) == Approx( 1.10f ) );
    CHECK( mounted_charge_multiplier( profile, 4, 300 ) == Approx( 1.50f ) );
    CHECK( mounted_charge_multiplier( profile, 4, 40 ) == Approx( 1.20f ) );

    profile.max_multiplier = 2.1f;
    CHECK_FALSE( profile.valid() );

    profile.max_multiplier = 1.5f;
    profile.max_steps = 16;
    CHECK( profile.valid() );

    JsonObject charge_data = json_loader::from_string( R"({
        "max_steps": 30,
        "damage_type": "stab",
        "multiplier_per_step": 0.1,
        "max_multiplier": 1.5
    })" ).get_object();
    mounted_charge_profile loaded_profile;
    loaded_profile.deserialize( charge_data );
    CHECK( loaded_profile.max_steps == 30 );
    CHECK( loaded_profile.valid() );
}

TEST_CASE( "mounted_lance_loads_an_explicit_charge_profile", "[mounted][charge][json]" )
{
    const item lance( itype_id( "mounted_lance" ) );
    REQUIRE( lance.type != nullptr );
    REQUIRE( lance.type->mounted_charge.has_value() );
    CHECK( lance.type->mounted_charge->max_steps == 15 );
    CHECK( lance.type->mounted_charge->damage_type == "stab" );
    CHECK( lance.type->mounted_charge->multiplier_per_step == Approx( 0.10f ) );
    CHECK( lance.type->mounted_charge->max_multiplier == Approx( 1.50f ) );
    CHECK( !lance.has_flag( flag_REACH_ATTACK ) );
    CHECK( !lance.has_flag( flag_POLEARM ) );
}

TEST_CASE( "mounted_saber_loads_a_short_cut_profile", "[mounted][charge][json]" )
{
    const item saber( itype_id( "mounted_saber" ) );
    REQUIRE( saber.type != nullptr );
    REQUIRE( saber.type->mounted_charge.has_value() );
    CHECK( saber.type->mounted_charge->max_steps == 15 );
    CHECK( saber.type->mounted_charge->damage_type == "cut" );
    CHECK( saber.type->mounted_charge->multiplier_per_step == Approx( 0.08f ) );
    CHECK( saber.type->mounted_charge->max_multiplier == Approx( 1.30f ) );
    CHECK( !saber.has_flag( flag_POLEARM ) );
}

TEST_CASE( "mounted_charge_is_available_only_as_a_usable_weapon_technique",
           "[mounted][charge][active_technique]" )
{
    avatar &player = get_avatar();
    setup_mounted_weapon( player, itype_id( "mounted_saber" ) );
#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
    REQUIRE( tec_mounted_charge.is_valid() );
    CHECK( tec_mounted_charge->lua_platform_mod == "ccb" );
    CHECK( tec_mounted_charge->lua_platform_condition_handler ==
           "ccb_mounted_charge_available" );
#endif
    CHECK( avatar_action::mounted_charge_available( player ) );

    player.set_moves( 0 );
    CHECK_FALSE( avatar_action::mounted_charge_available( player ) );
    player.set_moves( 1000 );

    player.set_wielded_item( item( itype_id( "mc_cavalry_sabre" ) ) );
    CHECK_FALSE( avatar_action::mounted_charge_available( player ) );

    player.set_wielded_item( item( itype_id( "mounted_lance" ) ) );
    CHECK( avatar_action::mounted_charge_available( player ) );
    player.forced_dismount();
    CHECK_FALSE( avatar_action::mounted_charge_available( player ) );
}

TEST_CASE( "mounted_saber_charge_scales_cut_damage_only", "[mounted][charge][damage]" )
{
    avatar &player = get_avatar();
    setup_mounted_weapon( player, itype_id( "mounted_saber" ) );
    const item &saber = *player.get_wielded_item();
    REQUIRE( saber.type->mounted_charge.has_value() );

    const auto roll = [&]() {
        damage_instance result;
        player.roll_all_damage( false, result, true, saber, attack_vector_id::NULL_ID(),
                                sub_bodypart_str_id::NULL_ID(), nullptr, bodypart_id( "torso" ) );
        return result;
    };
    const damage_instance ordinary = roll();
    REQUIRE( ordinary.type_damage( damage_type_id( "cut" ) ) > 0.0f );
    player.set_mounted_charge_damage_multiplier( damage_type_id( "cut" ),
            mounted_charge_multiplier( *saber.type->mounted_charge, 1, 300 ) );
    const damage_instance charged = roll();
    player.clear_mounted_charge_stab_multiplier();
    const damage_instance restored = roll();

    CHECK( charged.type_damage( damage_type_id( "cut" ) ) ==
           Approx( ordinary.type_damage( damage_type_id( "cut" ) ) * 1.12f ) );
    CHECK( charged.type_damage( damage_type_id( "bash" ) ) ==
           Approx( ordinary.type_damage( damage_type_id( "bash" ) ) ) );
    CHECK( charged.type_damage( damage_type_id( "stab" ) ) ==
           Approx( ordinary.type_damage( damage_type_id( "stab" ) ) ) );
    CHECK( restored.type_damage( damage_type_id( "cut" ) ) ==
           Approx( ordinary.type_damage( damage_type_id( "cut" ) ) ) );
    player.forced_dismount();
}

TEST_CASE( "mounted_charge_is_provided_by_the_weapon_technique_list",
           "[mounted][charge][martial_arts]" )
{
    avatar &player = get_avatar();
    setup_mounted_weapon( player, itype_id( "mounted_saber" ) );

    const item_location weapon = player.get_wielded_item();
    REQUIRE( weapon );
    CHECK( weapon->has_technique( tec_mounted_charge ) );

    const std::vector<matec_id> mounted_techniques = player.active_techniques();
    CHECK( std::find( mounted_techniques.begin(), mounted_techniques.end(), tec_mounted_charge ) !=
           mounted_techniques.end() );

    player.forced_dismount();
    const std::vector<matec_id> unmounted_techniques = player.active_techniques();
    CHECK( std::find( unmounted_techniques.begin(), unmounted_techniques.end(), tec_mounted_charge ) ==
           unmounted_techniques.end() );
}

TEST_CASE( "mounted_charge_stops_at_heavy_monster", "[mounted][charge][activity]" )
{
    avatar &player = get_avatar();
    monster &horse = setup_mounted_weapon( player, itype_id( "mounted_saber" ) );
    player.set_skill_level( skill_id( "melee" ), 10 );
    player.set_skill_level( skill_id( "cutting" ), 10 );
    map &here = get_map();
    const tripoint_bub_ms start = player.pos_bub();
    here.ter_set( start + tripoint::east, ter_id( "t_floor" ) );
    here.ter_set( start + tripoint( 2, 0, 0 ), ter_id( "t_floor" ) );
    monster &target = spawn_test_monster( "mon_zombie_hulk", start + tripoint( 2, 0, 0 ) );
    const int hp_before = target.get_hp();

    start_mounted_charge( player, horse );
    REQUIRE( player.activity );
    player.activity.do_turn( player );
    REQUIRE( player.pos_bub() == start + tripoint::east );
    REQUIRE( player.activity );
    player.activity.do_turn( player );

    CHECK_FALSE( player.activity );
    CHECK( player.pos_bub() == start + tripoint::east );
    CHECK( target.get_hp() < hp_before );
    player.forced_dismount();
}

TEST_CASE( "mounted_charge_knocks_light_survivor_aside_and_continues",
           "[mounted][charge][activity]" )
{
    avatar &player = get_avatar();
    monster &horse = setup_mounted_lance( player );
    player.set_dex_base( 30 );
    player.set_skill_level( skill_id( "melee" ), 10 );
    player.set_skill_level( skill_id( "stabbing" ), 10 );
    map &here = get_map();
    const tripoint_bub_ms start = player.pos_bub();
    for( int x = 1; x <= 4; ++x ) {
        here.ter_set( start + tripoint( x, 0, 0 ), ter_id( "t_floor" ) );
    }
    here.ter_set( start + tripoint( 2, 1, 0 ), ter_id( "t_floor" ) );
    here.ter_set( start + tripoint( 2, -1, 0 ), ter_id( "t_floor" ) );
    monster &target = spawn_test_monster( "mon_zombie", start + tripoint( 2, 0, 0 ) );
    target.set_hp( 500 );

    start_mounted_charge( player, horse );
    player.activity.do_turn( player );
    REQUIRE( player.activity );
    player.activity.do_turn( player );

    CHECK( target.get_hp() < 500 );
    CHECK_FALSE( target.is_dead() );
    CHECK( ( target.pos_bub( here ) == start + tripoint( 2, 1, 0 ) ||
             target.pos_bub( here ) == start + tripoint( 2, -1, 0 ) ) );
    CHECK( player.pos_bub() == start + tripoint( 2, 0, 0 ) );
    REQUIRE( player.activity );
    player.activity.do_turn( player );
    CHECK( player.pos_bub() == start + tripoint( 3, 0, 0 ) );
    player.cancel_activity();
    player.forced_dismount();
}

TEST_CASE( "mounted_charge_does_not_fling_heavy_corpse", "[mounted][charge][activity]" )
{
    avatar &player = get_avatar();
    monster &horse = setup_mounted_lance( player );
    player.set_dex_base( 30 );
    player.set_skill_level( skill_id( "melee" ), 10 );
    player.set_skill_level( skill_id( "stabbing" ), 10 );
    map &here = get_map();
    const tripoint_bub_ms start = player.pos_bub();
    monster &target = spawn_test_monster( "mon_moose", start + tripoint::east );
    target.set_hp( 1 );

    start_mounted_charge( player, horse );
    REQUIRE( player.activity );
    player.activity.do_turn( player );

    CHECK( target.is_dead() );
    CHECK( player.pos_bub() == start );
    CHECK_FALSE( player.activity );
    bool corpse_at_impact = false;
    for( const item &ground_item : here.i_at( start + tripoint::east ) ) {
        corpse_at_impact |= ground_item.is_corpse() && ground_item.get_corpse_mon() == target.type;
    }
    CHECK( corpse_at_impact );
    player.forced_dismount();
}

TEST_CASE( "mounted_charge_fling_light_corpse_and_hits_next_monster",
           "[mounted][charge][activity]" )
{
    avatar &player = get_avatar();
    monster &horse = setup_mounted_lance( player );
    player.set_dex_base( 30 );
    player.set_skill_level( skill_id( "melee" ), 10 );
    player.set_skill_level( skill_id( "stabbing" ), 10 );
    map &here = get_map();
    const tripoint_bub_ms start = player.pos_bub();
    for( int x = 1; x <= 4; ++x ) {
        here.ter_set( start + tripoint( x, 0, 0 ), ter_id( "t_floor" ) );
    }
    here.ter_set( start + tripoint( 2, 1, 0 ), ter_id( "t_floor" ) );
    here.ter_set( start + tripoint( 2, -1, 0 ), ter_id( "t_floor" ) );
    monster &first = spawn_test_monster( "mon_zombie", start + tripoint( 2, 0, 0 ) );
    first.set_hp( 1 );
    monster &second = spawn_test_monster( "mon_zombie_hulk", start + tripoint( 3, 0, 0 ) );
    const int second_hp = second.get_hp();

    start_mounted_charge( player, horse );
    player.activity.do_turn( player );
    REQUIRE( player.activity );
    player.activity.do_turn( player );
    REQUIRE( first.is_dead() );
    CHECK( player.pos_bub() == start + tripoint( 2, 0, 0 ) );
    bool corpse_aside = false;
    for( const int dy : { -1, 1 } ) {
        for( const item &ground_item : here.i_at( start + tripoint( 2, dy, 0 ) ) ) {
            corpse_aside |= ground_item.is_corpse() && ground_item.get_corpse_mon() == first.type;
        }
    }
    CHECK( corpse_aside );
    REQUIRE( player.activity );
    player.activity.do_turn( player );
    CHECK( second.get_hp() < second_hp );
    CHECK_FALSE( player.activity );
    player.forced_dismount();
}

TEST_CASE( "mounted_charge_moves_one_tile_and_stops_at_wall", "[mounted][charge][activity]" )
{
    avatar &player = get_avatar();
    monster &horse = setup_mounted_lance( player );
    map &here = get_map();
    const tripoint_bub_ms start = player.pos_bub();
    here.ter_set( start + tripoint::east, ter_id( "t_floor" ) );
    here.ter_set( start + tripoint( 2, 0, 0 ), ter_id( "t_wall" ) );

    start_mounted_charge( player, horse );
    REQUIRE( player.activity );
    player.activity.do_turn( player );
    CHECK( player.pos_bub() == start + tripoint::east );
    CHECK( horse.pos_bub( here ) == player.pos_bub() );
    REQUIRE( player.activity );

    player.activity.do_turn( player );
    CHECK( player.pos_bub() == start + tripoint::east );
    CHECK_FALSE( player.activity );
    player.forced_dismount();
}

TEST_CASE( "mounted_charge_reaches_selected_endpoint", "[mounted][charge][activity]" )
{
    avatar &player = get_avatar();
    monster &horse = setup_mounted_lance( player );
    map &here = get_map();
    const tripoint_bub_ms start = player.pos_bub();
    const tripoint_bub_ms endpoint = start + tripoint( 15, 0, 0 );
    for( const tripoint_bub_ms &point : line_to( start, endpoint ) ) {
        here.ter_set( point, ter_id( "t_floor" ) );
    }
    const tripoint_abs_ms endpoint_abs = here.get_abs( endpoint );

    const item_location lance = player.get_wielded_item();
    REQUIRE( lance );
    player.set_moves( 100000 );
    player.assign_activity( mounted_charge_activity_actor(
                                here.get_abs( endpoint ), horse.uid().get_value(), lance->uid().get_value(),
                                player.pos_abs(), lance->typeId() ) );
    REQUIRE( player.activity );

    for( int step = 0; step < 15 && player.activity; ++step ) {
        player.activity.do_turn( player );
    }

    CHECK_FALSE( player.activity );
    CHECK( player.pos_abs() == endpoint_abs );
    player.forced_dismount();
}

TEST_CASE( "mounted_charge_attacks_friendly_creature", "[mounted][charge][activity]" )
{
    avatar &player = get_avatar();
    monster &horse = setup_mounted_lance( player );
    player.set_dex_base( 30 );
    player.set_skill_level( skill_id( "melee" ), 10 );
    player.set_skill_level( skill_id( "stabbing" ), 10 );
    map &here = get_map();
    const tripoint_bub_ms start = player.pos_bub();
    monster &pet = spawn_test_monster( "mon_dog", start + tripoint::east );
    pet.friendly = 1;
    pet.add_effect( efftype_id( "pet" ), 1_turns, true );
    const int hp_before = pet.get_hp();

    start_mounted_charge( player, horse );
    REQUIRE( player.activity );
    player.activity.do_turn( player );

    CHECK( player.pos_bub() == start + tripoint::east );
    CHECK( pet.get_hp() < hp_before );
    CHECK( player.activity );
    player.cancel_activity();
    player.forced_dismount();
}

TEST_CASE( "mounted_charge_attacks_non_hostile_npc", "[mounted][charge][activity]" )
{
    avatar &player = get_avatar();
    monster &horse = setup_mounted_lance( player );
    player.set_skill_level( skill_id( "melee" ), 10 );
    player.set_skill_level( skill_id( "stabbing" ), 10 );
    const tripoint_bub_ms start = player.pos_bub();
    npc &target = spawn_npc( ( start + tripoint::east ).xy(), "test_talker" );
    REQUIRE_FALSE( target.is_enemy() );
    const int hp_before = target.get_hp();

    start_mounted_charge( player, horse );
    REQUIRE( player.activity );
    player.activity.do_turn( player );

    CHECK( player.pos_bub() == start );
    CHECK( target.get_hp() < hp_before );
    CHECK( target.is_enemy() );
    CHECK_FALSE( player.activity );
    player.forced_dismount();
}

TEST_CASE( "mounted_charge_activity_serializes_route_identity", "[mounted][charge][save]" )
{
    avatar &player = get_avatar();
    monster &horse = setup_mounted_lance( player );
    start_mounted_charge( player, horse );
    REQUIRE( player.activity );

    std::ostringstream serialized;
    JsonOut output( serialized );
    player.activity.serialize( output );
    JsonObject activity = json_loader::from_string( serialized.str() ).get_object();
    activity.allow_omitted_members();
    CHECK( activity.get_string( "type" ) == "ACT_MOUNTED_CHARGE" );

    JsonObject actor = activity.get_object( "actor" );
    actor.allow_omitted_members();
    CHECK( actor.get_string( "actor_type" ) == "ACT_MOUNTED_CHARGE" );
    JsonObject actor_data = actor.get_object( "actor_data" );
    actor_data.allow_omitted_members();
    tripoint_abs_ms destination;
    int completed_steps = -1;
    int64_t mount_uid = 0;
    int64_t weapon_uid = 0;
    itype_id item_type;
    actor_data.read( "destination", destination );
    actor_data.read( "completed_steps", completed_steps );
    actor_data.read( "mount_uid", mount_uid );
    actor_data.read( "weapon_uid", weapon_uid );
    actor_data.read( "charge_item_type", item_type );

    CHECK( destination == player.pos_abs() + tripoint( 4, 0, 0 ) );
    CHECK( completed_steps == 0 );
    CHECK( mount_uid == horse.uid().get_value() );
    CHECK( weapon_uid == player.get_wielded_item()->uid().get_value() );
    CHECK( item_type == itype_id( "mounted_lance" ) );
    player.cancel_activity();
    player.forced_dismount();
}
