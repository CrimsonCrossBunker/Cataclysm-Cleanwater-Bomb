#include <list>
#include <memory>
#include <optional>
#include <sstream>
#include <string>
#include <tuple>
#include <vector>

#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "calendar.h"
#include "character.h"
#include "character_id.h"
#include "coordinates.h"
#include "creature_tracker.h"
#include "event.h"
#include "event_bus.h"
#include "event_subscriber.h"
#include "flag.h"
#include "flexbuffer_json.h"
#include "game.h"
#include "game_constants.h"
#include "gun_mode.h"
#include "item.h"
#include "item_location.h"
#include "json.h"
#include "json_loader.h"
#include "map.h"
#include "map_helpers.h"
#include "map_iterator.h"
#include "monster.h"
#include "npc.h"
#include "npc_attack.h"
#include "options_helpers.h"
#include "overmap_ui.h"
#include "player_helpers.h"
#include "pocket_type.h"
#include "point.h"
#include "ranged.h"
#include "ret_val.h"
#include "type_id.h"

class Creature;

static const faction_id faction_your_followers( "your_followers" );

static const gun_mode_id gun_mode_AUTO( "AUTO" );
static const gun_mode_id gun_mode_BURST( "BURST" );

static const itype_id itype_combat_exoskeleton_medium( "combat_exoskeleton_medium" );
static const itype_id itype_combat_exoskeleton_medium_on( "combat_exoskeleton_medium_on" );
static const itype_id itype_test_sling_payload_active( "test_sling_payload_active" );
static const itype_id itype_heavy_battery_cell( "heavy_battery_cell" );
static const itype_id itype_knife_large( "knife_large" );
static const itype_id itype_modular_m16_auto_rifle( "modular_m16_auto_rifle" );
static const itype_id itype_modular_m16a4( "modular_m16a4" );
static const itype_id itype_wearable_light( "wearable_light" );

static const mtype_id mon_zombie( "mon_zombie" );

static const skill_id skill_throw( "throw" );

static const string_id<npc_template> npc_template_test_talker( "test_talker" );
static const string_id<npc_template> npc_template_test_throwing( "test_throwing_npc" );

static const ter_str_id ter_test_t_throwing_wall( "test_t_throwing_wall" );

static const weather_type_id weather_sunny( "sunny" );

static constexpr point_bub_ms main_npc_start{ 50, 50 };
static constexpr tripoint_bub_ms main_npc_start_tripoint{ main_npc_start, 0 };

namespace npc_attack_setup
{
static npc &spawn_main_npc( const string_id<npc_template> &template_id = npc_template_test_talker )
{
    map &here = get_map();
    creature_tracker &creatures = get_creature_tracker();
    get_player_character().setpos( here, { main_npc_start, -1 } );
    REQUIRE( creatures.creature_at<Creature>( main_npc_start_tripoint ) == nullptr );
    const character_id model_id = here.place_npc( main_npc_start, template_id );

    npc &model_npc = *g->find_npc( model_id );
    clear_character( model_npc );
    model_npc.setpos( here, main_npc_start_tripoint );

    g->load_npcs();

    REQUIRE( creatures.creature_at<npc>( main_npc_start_tripoint ) != nullptr );

    return model_npc;
}

static npc &respawn_main_npc( const string_id<npc_template> &template_id = npc_template_test_talker )
{
    npc *guy = get_creature_tracker().creature_at<npc>( main_npc_start_tripoint );
    if( guy ) {
        guy->die( &get_map(), nullptr );
    }
    return spawn_main_npc( template_id );
}

static monster *spawn_zombie_at_range( const int range )
{
    return g->place_critter_at( mon_zombie, main_npc_start_tripoint + tripoint( range, 0, 0 ) );
}

static npc &spawn_armed_grenade_npc()
{
    clear_avatar();
    get_player_character().setpos( get_map(), main_npc_start_tripoint );
    clear_map_and_put_player_underground();
    clear_vehicles();
    npc &model = respawn_main_npc( npc_template_test_throwing );
    // Respawning can leave the previous NPC's corpse and gear on this tile.
    get_map().i_clear( model.pos_bub() );
    model.set_fac( faction_your_followers );
    model.set_attitude( NPCATT_FOLLOW );
    model.set_knowledge_level( skill_throw, 10 );
    model.rules.set_flag( ally_rule::avoid_friendly_fire );
    model.rules.engagement = combat_engagement::NO_MOVE;
    item grenade( itype_test_sling_payload_active );
    grenade.active = true;
    model.set_wielded_item( grenade );
    REQUIRE( model.get_wielded_item()->has_flag( flag_NPC_THROW_NOW ) );
    model.set_moves( 1000 );
    model.regen_ai_cache();
    return model;
}
} // namespace npc_attack_setup

TEST_CASE( "armed_grenade_chooses_a_throwable_tile_past_an_obstructed_corner",
           "[npc_attack][npc_explosive]" )
{
    npc &model = npc_attack_setup::spawn_armed_grenade_npc();
    map &here = get_map();
    item &grenade = *model.get_wielded_item();
    const bool best_weapon = GENERATE( false, true );
    CAPTURE( best_weapon );
    const int range = model.throw_range( grenade );
    REQUIRE( range > 2 );
    for( const tripoint_bub_ms &point : here.points_in_radius( model.pos_bub(), range ) ) {
        if( point.x() == model.pos_bub().x() - 1 ) {
            here.ter_set( point, ter_test_t_throwing_wall.id() );
        }
    }
    npc_attack_throw attack( grenade, best_weapon ? &grenade : nullptr, model.speed_rating() );

    const npc_attack_rating rating = attack.evaluate( model, nullptr );
    REQUIRE( rating.value() );
    REQUIRE( *rating.value() > 0 );
    CHECK( rating.target() != model.pos_bub() );
    attack.use( model, rating.target() );
    CHECK_FALSE( model.get_wielded_item() );
}

TEST_CASE( "npc_discards_armed_grenade_even_without_a_combat_target",
           "[npc_attack][npc_explosive]" )
{
    npc &model = npc_attack_setup::spawn_armed_grenade_npc();
    REQUIRE( model.current_target() == nullptr );
    model.move();
    CHECK_FALSE( model.get_wielded_item() );
    CHECK( get_map().i_at( model.pos_bub() ).empty() );
}

TEST_CASE( "armed_grenade_throw_avoids_a_nearby_friend_in_the_first_direction",
           "[npc_attack][npc_explosive]" )
{
    npc &model = npc_attack_setup::spawn_armed_grenade_npc();
    calendar::turn = calendar::turn_zero + 12_hours;
    map &here = get_map();
    item &grenade = *model.get_wielded_item();
    const int range = model.throw_range( grenade );
    REQUIRE( range > 1 );
    const tripoint_bub_ms corner = *here.points_in_radius( model.pos_bub(), range ).begin();
    const auto ray = here.find_clear_path( model.pos_bub(), corner );
    REQUIRE( ray.size() > 1 );
    const tripoint_bub_ms friend_pos = ray.front();
    get_player_character().setpos( here, friend_pos );
    here.build_map_cache( 0 );
    model.regen_ai_cache();
    REQUIRE_FALSE( model.get_cached_friends().empty() );
    npc_attack_throw attack( grenade, nullptr, model.speed_rating() );

    const npc_attack_rating rating = attack.evaluate( model, nullptr );
    REQUIRE( rating.value() );
    CHECK( rl_dist( rating.target(), friend_pos ) > 1 );
    attack.use( model, rating.target() );
    CHECK_FALSE( model.get_wielded_item() );
}

TEST_CASE( "npc_drops_armed_grenade_when_surrounded_by_walls",
           "[npc_attack][npc_explosive]" )
{
    npc &model = npc_attack_setup::spawn_armed_grenade_npc();
    map &here = get_map();
    for( const tripoint_bub_ms &point : here.points_in_radius( model.pos_bub(), 1 ) ) {
        if( point != model.pos_bub() ) {
            here.ter_set( point, ter_test_t_throwing_wall.id() );
        }
    }
    model.move();
    CHECK_FALSE( model.get_wielded_item() );
    map_stack at_feet = here.i_at( model.pos_bub() );
    REQUIRE( at_feet.size() == 1 );
    CHECK( at_feet.only_item().typeId() == itype_test_sling_payload_active );
    CHECK( at_feet.only_item().active );
}

TEST_CASE( "npc_leaves_armed_grenade_at_its_feet_if_retired_during_disposal",
           "[npc_attack][npc_explosive]" )
{
    npc &model = npc_attack_setup::spawn_armed_grenade_npc();
    map &here = get_map();
    const tripoint_bub_ms origin = model.pos_bub();
    const bool surrounded = GENERATE( false, true );
    CAPTURE( surrounded );
    if( surrounded ) {
        for( const tripoint_bub_ms &point : here.points_in_radius( origin, 1 ) ) {
            if( point != origin ) {
                here.ter_set( point, ter_test_t_throwing_wall.id() );
            }
        }
    }

    class retire_on_unwield : public event_subscriber
    {
        public:
            using event_subscriber::notify;

            explicit retire_on_unwield( character_id id ) : id( id ) {
                get_event_bus().subscribe( this );
            }
            void notify( const cata::event &event ) override {
                if( event.type() == event_type::character_wields_item &&
                    event.get<character_id>( "character" ) == id ) {
                    fired = true;
                    g->remove_npc( id );
                }
            }

            const character_id id;
            bool fired = false;
    } callback( model.getID() );

    model.move();
    REQUIRE( callback.fired );
    CHECK( get_creature_tracker().creature_at<npc>( origin ) == nullptr );
    map_stack at_origin = here.i_at( origin );
    REQUIRE( at_origin.size() == 1 );
    CHECK( at_origin.only_item().typeId() == itype_test_sling_payload_active );
    CHECK( at_origin.only_item().active );
}

TEST_CASE( "npc_throw_attack_consumes_one_test_projectile", "[npc_attack][throwing]" )
{
    get_player_character().setpos( get_map(), main_npc_start_tripoint );
    clear_map_and_put_player_underground();
    clear_vehicles();
    scoped_weather_override sunny_weather( weather_sunny );
    npc &model = npc_attack_setup::respawn_main_npc( npc_template_test_throwing );
    model.set_fac( faction_your_followers );
    model.set_skill_level( skill_throw, 10 );
    model.set_moves( 1000 );
    item projectile( itype_id( "test_throwing_stack" ), calendar::turn, 3 );
    model.set_wielded_item( projectile );
    monster *target = g->place_critter_at( mtype_id( "mon_test_zombie" ),
                                         model.pos_bub() + tripoint( 4, 0, 0 ) );
    REQUIRE( target != nullptr );
    model.regen_ai_cache();
    item &held = *model.get_wielded_item();
    const int count = held.count();
    const int moves = model.get_moves();
    npc_attack_throw attack( held, nullptr, model.speed_rating() );
    const npc_attack_rating rating = attack.evaluate( model, target );
    REQUIRE( rating.value() );
    REQUIRE( *rating.value() > 0 );
    attack.use( model, rating.target() );
    REQUIRE( model.get_wielded_item() );
    CHECK( model.get_wielded_item()->count() == count - 1 );
    CHECK( model.get_moves() < moves );
}

TEST_CASE( "NPC_automatic_fire_respects_distance_and_burst_orders", "[npc_attack][gun_rpm]" )
{
    const auto [skill, distance, order, estimate] = GENERATE(
    table<int, int, burst_rule, int>( {
        { 10, 4, burst_rule::ADAPTIVE, 0 },
        { 10, 5, burst_rule::ADAPTIVE, 7 },
        { 10, 12, burst_rule::ADAPTIVE, 7 },
        { 10, 13, burst_rule::ADAPTIVE, 3 },
        { 0, 5, burst_rule::ADAPTIVE, 3 },
        { 10, 4, burst_rule::SHORT, 3 },
        { 10, 13, burst_rule::LONG, 7 },
        { 10, 13, burst_rule::FULL_AUTO, 0 }
    } ) );
    CAPTURE( skill, distance, static_cast<int>( order ), estimate );
    clear_map_and_put_player_underground();
    scoped_weather_override sunny_weather( weather_sunny );
    npc &shooter = npc_attack_setup::respawn_main_npc();
    arm_shooter( shooter, itype_modular_m16_auto_rifle );
    item &rifle = *shooter.get_wielded_item();
    REQUIRE( rifle.gun_set_mode( gun_mode_AUTO ) );
    const gun_mode mode = rifle.gun_current_mode();
    REQUIRE( mode.full_auto() );
    const int turn_shots = mode.shots_available( calendar::turn );
    REQUIRE( turn_shots > 7 );
    shooter.rules.burst = order;
    shooter.set_skill_level( rifle.gun_skill(), skill );
    monster *zombie = npc_attack_setup::spawn_zombie_at_range( distance );
    REQUIRE( zombie );
    zombie->set_hp( 10000 );
    const tripoint_bub_ms target = zombie->pos_bub();
    shooter.last_target_pos = get_map().get_abs( target );
    shooter.recoil = 0;
    const int turn_moves = shooter.get_speed();
    shooter.set_moves( turn_moves );
    const int ammo_before = rifle.ammo_remaining();
    REQUIRE( ammo_before >= turn_shots );

    npc_attack_gun( rifle, gun_mode_AUTO, mode ).use( shooter, target );
    const int fired = ammo_before - rifle.ammo_remaining();
    if( estimate == 0 ) {
        CHECK( fired == turn_shots );
        CHECK( shooter.get_moves() == 0 );
    } else {
        const auto [minimum, maximum] = firearm_burst_round_range( estimate, skill );
        CHECK( fired >= minimum );
        CHECK( fired <= maximum );
        CHECK( shooter.get_moves() == turn_moves -
               firearm_burst_move_cost( fired, mode.rpm, turn_moves ) );
        CHECK( mode.shots_available( calendar::turn ) == turn_shots );
    }
}

TEST_CASE( "NPC_automatic_bursts_use_remaining_moves_and_resume_aim",
           "[npc_attack][gun_rpm]" )
{
    clear_map_and_put_player_underground();
    scoped_weather_override sunny_weather( weather_sunny );
    npc &shooter = npc_attack_setup::respawn_main_npc();
    arm_shooter( shooter, itype_modular_m16_auto_rifle );
    item &rifle = *shooter.get_wielded_item();
    REQUIRE( rifle.gun_set_mode( gun_mode_AUTO ) );
    const gun_mode mode = rifle.gun_current_mode();
    REQUIRE( mode.full_auto() );
    shooter.rules.burst = burst_rule::SHORT;
    shooter.set_skill_level( rifle.gun_skill(), MAX_SKILL );
    monster *zombie = npc_attack_setup::spawn_zombie_at_range( 4 );
    REQUIRE( zombie );
    zombie->set_hp( 10000 );
    const tripoint_bub_ms target = zombie->pos_bub();
    shooter.last_target_pos = get_map().get_abs( target );
    const int ammo_before = rifle.ammo_remaining();
    const npc_attack_gun burst( rifle, gun_mode_AUTO, mode );

    SECTION( "Aim continues on the next turn when moves run out" ) {
        shooter.recoil = MAX_RECOIL;
        shooter.set_moves( 1 );
        burst.use( shooter, target );
        CHECK( shooter.get_moves() == 0 );
        CHECK( rifle.ammo_remaining() == ammo_before );
        REQUIRE( shooter.recoil < MAX_RECOIL );
        restore_on_out_of_scope restore_turn( calendar::turn );
        calendar::turn += 1_seconds;
        shooter.mod_moves( shooter.get_speed() );
        burst.use( shooter, target );
        CHECK( rifle.ammo_remaining() == ammo_before - 3 );
    }

    SECTION( "A second burst spends moves on aim and firing in the same second" ) {
        const int regular_aim = shooter.get_aim_types( rifle )[1].threshold;
        shooter.recoil = regular_aim;
        shooter.set_moves( shooter.get_speed() );
        burst.use( shooter, target );
        REQUIRE( rifle.ammo_remaining() == ammo_before - 3 );
        REQUIRE( shooter.recoil > regular_aim );
        const int moves_after_first = shooter.get_moves();
        REQUIRE( moves_after_first > 0 );
        burst.use( shooter, target );
        CHECK( rifle.ammo_remaining() == ammo_before - 6 );
        CHECK( moves_after_first - shooter.get_moves() >
               firearm_burst_move_cost( 3, mode.rpm, shooter.get_speed() ) );
    }
}

TEST_CASE( "NPC_fixed_bursts_keep_the_configured_count_under_full_auto_orders",
           "[npc_attack][gun_rpm]" )
{
    clear_map_and_put_player_underground();
    scoped_weather_override sunny_weather( weather_sunny );
    npc &shooter = npc_attack_setup::respawn_main_npc();
    arm_shooter( shooter, itype_modular_m16a4 );
    item &rifle = *shooter.get_wielded_item();
    rifle.set_flag( flag_id( "NEVER_JAMS" ) );
    REQUIRE( rifle.gun_set_mode( gun_mode_BURST ) );
    const gun_mode mode = rifle.gun_current_mode();
    REQUIRE( mode.fixed_burst() );
    REQUIRE( mode.qty == 3 );
    REQUIRE( mode.rpm == 800 );
    shooter.rules.burst = burst_rule::FULL_AUTO;
    shooter.set_skill_level( rifle.gun_skill(), 0 );
    monster *zombie = npc_attack_setup::spawn_zombie_at_range( 4 );
    REQUIRE( zombie );
    const tripoint_bub_ms target = zombie->pos_bub();
    shooter.last_target_pos = get_map().get_abs( target );
    const npc_attack_gun burst( rifle, gun_mode_BURST, mode );
    const int ammo_before = rifle.ammo_remaining();
    REQUIRE( ammo_before >= 3 );

    shooter.recoil = MAX_RECOIL;
    shooter.set_moves( 1 );
    burst.use( shooter, target );
    CHECK( rifle.ammo_remaining() == ammo_before );
    CHECK( shooter.get_moves() == 0 );
    CHECK( shooter.recoil < MAX_RECOIL );

    shooter.recoil = 0;
    shooter.set_moves( shooter.get_speed() );
    const int moves_before = shooter.get_moves();

    burst.use( shooter, target );
    CHECK( rifle.ammo_remaining() == ammo_before - 3 );
    CHECK( shooter.get_moves() == moves_before -
           firearm_burst_move_cost( 3, mode.rpm, shooter.get_speed() ) );
}

TEST_CASE( "NPC_burst_orders_survive_save_load", "[npc_rules][gun_rpm]" )
{
    npc_follower_rules rules;
    CHECK( rules.burst == burst_rule::ADAPTIVE );
    rules.burst = burst_rule::LONG;
    std::ostringstream saved;
    JsonOut json( saved );
    rules.serialize( json );
    npc_follower_rules restored;
    restored.deserialize( json_loader::from_string( saved.str() ).get_object() );
    CHECK( restored.burst == burst_rule::LONG );

    restored.deserialize( json_loader::from_string( R"({ "aim": 0 })" ).get_object() );
    CHECK( restored.burst == burst_rule::ADAPTIVE );
}

TEST_CASE( "NPC_faces_zombies", "[npc_attack]" )
{
    map &here = get_map();

    get_player_character().setpos( here, main_npc_start_tripoint );
    clear_map_and_put_player_underground();
    clear_vehicles();
    scoped_weather_override sunny_weather( weather_sunny );
    npc &main_npc = npc_attack_setup::respawn_main_npc();
    // Allied NPC for behavior testing purposes
    main_npc.set_fac( faction_your_followers );

    GIVEN( "There is a zombie 1 tile away" ) {
        monster *zombie = npc_attack_setup::spawn_zombie_at_range( 1 );

        WHEN( "NPC only has a large knife" ) {
            item weapon( itype_knife_large );
            main_npc.set_wielded_item( weapon );
            REQUIRE( main_npc.get_wielded_item()->typeId() == itype_knife_large );

            THEN( "NPC attempts to melee the enemy target" ) {
                main_npc.evaluate_best_attack( zombie );
                const std::shared_ptr<npc_attack> &attack = main_npc.get_current_attack();
                npc_attack_melee *melee_attack = dynamic_cast<npc_attack_melee *>( attack.get() );
                CHECK( melee_attack );
                const npc_attack_rating &rating = main_npc.get_current_attack_evaluation();
                CHECK( rating.value() );
                CHECK( *rating.value() > 0 );
                CHECK( rating.target() == zombie->pos_bub() );
            }
        }
        WHEN( "NPC only has an m16a4" ) {
            arm_shooter( main_npc, itype_modular_m16a4 );

            WHEN( "NPC is allowed to use loud ranged weapons" ) {
                main_npc.rules.set_flag( ally_rule::use_guns );
                REQUIRE( main_npc.rules.has_flag( ally_rule::use_guns ) );
                main_npc.rules.clear_flag( ally_rule::use_silent );
                REQUIRE( !main_npc.rules.has_flag( ally_rule::use_silent ) );

                THEN( "NPC tries to shoot the enemy target" ) {
                    main_npc.evaluate_best_attack( zombie );
                    const std::shared_ptr<npc_attack> &attack = main_npc.get_current_attack();
                    npc_attack_gun *ranged_attack = dynamic_cast<npc_attack_gun *>( attack.get() );
                    CHECK( ranged_attack );
                    const npc_attack_rating &rating = main_npc.get_current_attack_evaluation();
                    CHECK( rating.value() );
                    CHECK( *rating.value() > 0 );
                    CHECK( rating.target() == zombie->pos_bub() );
                }
            }
            WHEN( "NPC isn't allowed to use loud weapons" ) {
                main_npc.rules.set_flag( ally_rule::use_silent );
                REQUIRE( main_npc.rules.has_flag( ally_rule::use_silent ) );

                THEN( "NPC can't fire his weapon" ) {
                    main_npc.evaluate_best_attack( zombie );
                    const std::shared_ptr<npc_attack> &attack = main_npc.get_current_attack();
                    npc_attack_gun *ranged_attack = dynamic_cast<npc_attack_gun *>( attack.get() );
                    CHECK( !ranged_attack );
                }
            }
            WHEN( "NPC isn't allowed to use ranged weapons" ) {
                main_npc.rules.clear_flag( ally_rule::use_guns );
                REQUIRE( !main_npc.rules.has_flag( ally_rule::use_guns ) );

                THEN( "NPC can't fire his weapon" ) {
                    main_npc.evaluate_best_attack( zombie );
                    const std::shared_ptr<npc_attack> &attack = main_npc.get_current_attack();
                    npc_attack_gun *ranged_attack = dynamic_cast<npc_attack_gun *>( attack.get() );
                    CHECK( !ranged_attack );
                }
            }
        }
        WHEN( "NPC has an exoskeleton" ) {
            main_npc.clear_worn();
            item armor( itype_combat_exoskeleton_medium );
            std::optional<std::list<item>::iterator> wear_success = main_npc.wear_item( armor );
            item &worn_armor = **wear_success;

            REQUIRE( wear_success );

            // If the flag gets removed from power armor, some other item with the flag will need to replace it.
            REQUIRE( main_npc.worn_with_flag( flag_COMBAT_TOGGLEABLE ) );

            WHEN( "NPC has a battery for their armor" ) {

                item battery = item( itype_heavy_battery_cell );
                battery.ammo_set( battery.ammo_default() );
                worn_armor.put_in( battery, pocket_type::MAGAZINE_WELL );

                REQUIRE( worn_armor.ammo_remaining( ) > 0 );

                THEN( "NPC activates their exoskeleton successfully" ) {

                    // target is not exposed, so regen_ai_cache is used to have the npc re-assess threat and store the target.
                    main_npc.regen_ai_cache();
                    main_npc.method_of_attack();
                    CHECK( main_npc.is_wearing( itype_combat_exoskeleton_medium_on ) );
                    CHECK( !main_npc.is_wearing( itype_combat_exoskeleton_medium ) );
                }
            }

            WHEN( "NPC has no power supply for their exoskeleton" ) {
                THEN( "NPC fails to activate their exoskeleton" ) {
                    main_npc.regen_ai_cache();
                    main_npc.method_of_attack();
                    CHECK( main_npc.is_wearing( itype_combat_exoskeleton_medium ) );
                    CHECK( !main_npc.is_wearing( itype_combat_exoskeleton_medium_on ) );
                }
            }
        }
        WHEN( "NPC has a headlamp" ) {
            main_npc.clear_worn();

            item headlamp( itype_wearable_light );
            std::optional<std::list<item>::iterator> wear_success = main_npc.wear_item( headlamp );
            REQUIRE( wear_success );

            // If the flag gets added, some other item without the flag will need to replace it.
            REQUIRE( !main_npc.worn_with_flag( flag_COMBAT_TOGGLEABLE ) );

            // This test is to ensure NPCs do not randomly activate items in their inventory.
            THEN( "NPC does not activate their headlamp" ) {
                main_npc.regen_ai_cache();
                main_npc.method_of_attack();
                CHECK( main_npc.is_wearing( itype_wearable_light ) );
            }
        }
    }
    GIVEN( "There is a zombie 5 tiles away" ) {
        monster *zombie = npc_attack_setup::spawn_zombie_at_range( 5 );

        WHEN( "NPC only has a large knife" ) {
            item weapon( itype_knife_large );
            main_npc.set_wielded_item( weapon );
            REQUIRE( main_npc.get_wielded_item()->typeId() == itype_knife_large );

            THEN( "NPC attempts to melee the enemy target" ) {
                main_npc.evaluate_best_attack( zombie );
                const std::shared_ptr<npc_attack> &attack = main_npc.get_current_attack();
                npc_attack_melee *melee_attack = dynamic_cast<npc_attack_melee *>( attack.get() );
                CHECK( melee_attack );
                const npc_attack_rating &rating = main_npc.get_current_attack_evaluation();
                CHECK( rating.value() );
                CHECK( *rating.value() > 0 );
                CHECK( rating.target() == zombie->pos_bub() );
            }
        }

    }
    GIVEN( "There is a zombie 1 tile away and another 8 tiles away" ) {
        monster *zombie = npc_attack_setup::spawn_zombie_at_range( 1 );
        monster *zombie_far = npc_attack_setup::spawn_zombie_at_range( 8 );

        WHEN( "NPC only has a large knife" ) {
            item weapon( itype_knife_large );
            main_npc.set_wielded_item( weapon );
            REQUIRE( main_npc.get_wielded_item()->typeId() == itype_knife_large );

            WHEN( "NPC is targetting closest zombie" ) {
                main_npc.evaluate_best_attack( zombie );

                THEN( "NPC tries to attack closest zombie" ) {
                    const std::shared_ptr<npc_attack> &attack = main_npc.get_current_attack();
                    npc_attack_melee *melee_attack = dynamic_cast<npc_attack_melee *>( attack.get() );
                    CHECK( melee_attack );
                    const npc_attack_rating &rating = main_npc.get_current_attack_evaluation();
                    CHECK( rating.value() );
                    CHECK( *rating.value() > 0 );
                    CHECK( rating.target() == zombie->pos_bub() );
                }
            }
            WHEN( "NPC is targetting farthest zombie" ) {
                WHEN( "Furthest zombie is at full HP" ) {
                    main_npc.evaluate_best_attack( zombie_far );

                    THEN( "NPC tries to attack closest zombie" ) {
                        const std::shared_ptr<npc_attack> &attack = main_npc.get_current_attack();
                        npc_attack_melee *melee_attack = dynamic_cast<npc_attack_melee *>( attack.get() );
                        CHECK( melee_attack );
                        const npc_attack_rating &rating = main_npc.get_current_attack_evaluation();
                        CHECK( rating.value() );
                        CHECK( *rating.value() > 0 );
                        CHECK( rating.target() == zombie->pos_bub() );
                    }
                }
                WHEN( "Furthest zombie is at low HP" ) {
                    zombie_far->set_hp( 1 );
                    main_npc.evaluate_best_attack( zombie_far );

                    THEN( "NPC tries to attack furthest zombie" ) {
                        const std::shared_ptr<npc_attack> &attack = main_npc.get_current_attack();
                        npc_attack_melee *melee_attack = dynamic_cast<npc_attack_melee *>( attack.get() );
                        CHECK( melee_attack );
                        const npc_attack_rating &rating = main_npc.get_current_attack_evaluation();
                        CHECK( rating.value() );
                        CHECK( *rating.value() > 0 );
                        CHECK( rating.target() == zombie_far->pos_bub() );
                    }
                }
            }
        }
    }
    GIVEN( "There is no zombie nearby. " ) {
        WHEN( "NPC is wearing active exoskeleton. " ) {
            item armor( itype_combat_exoskeleton_medium_on );
            armor.activate();
            std::optional<std::list<item>::iterator> wear_success = main_npc.wear_item( armor );
            REQUIRE( wear_success );

            THEN( "NPC deactivates their exoskeleton. " ) {
                // This is somewhat cheating, but going up one level is testing all of npc::move.
                main_npc.cleanup_on_no_danger();

                CHECK( !main_npc.is_wearing( itype_combat_exoskeleton_medium_on ) );
                CHECK( main_npc.is_wearing( itype_combat_exoskeleton_medium ) );
            }
        }
    }
}

// TODO: Add scenarios for:
// - NPCs carrying a mix of weapons
// - NPCs trying to shoot through allies
