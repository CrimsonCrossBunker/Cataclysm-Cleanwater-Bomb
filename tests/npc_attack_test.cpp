#include <algorithm>
#include <list>
#include <memory>
#include <optional>

#include "cata_catch.h"
#include "character.h"
#include "character_id.h"
#include "coordinates.h"
#include "creature_tracker.h"
#include "flag.h"
#include "game.h"
#include "gun_mode.h"
#include "item.h"
#include "item_location.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "monster.h"
#include "npc.h"
#include "npc_attack.h"
#include "options_helpers.h"
#include "overmap_ui.h"
#include "player_helpers.h"
#include "pocket_type.h"
#include "point.h"
#include "ret_val.h"
#include "type_id.h"

class Creature;

static const faction_id faction_your_followers( "your_followers" );

static const itype_id itype_backpack( "backpack" );
static const itype_id itype_combat_exoskeleton_medium( "combat_exoskeleton_medium" );
static const itype_id itype_combat_exoskeleton_medium_on( "combat_exoskeleton_medium_on" );
static const itype_id itype_heavy_battery_cell( "heavy_battery_cell" );
static const itype_id itype_knife_large( "knife_large" );
static const itype_id itype_modular_m16a4( "modular_m16a4" );
static const itype_id itype_rock( "rock" );
static const itype_id itype_wearable_light( "wearable_light" );

static const mtype_id mon_zombie( "mon_zombie" );

static const skill_id skill_throw( "throw" );

static const string_id<npc_template> npc_template_test_talker( "test_talker" );

static const weather_type_id weather_sunny( "sunny" );

static constexpr point_bub_ms main_npc_start{ 50, 50 };
static constexpr tripoint_bub_ms main_npc_start_tripoint{ main_npc_start, 0 };

namespace npc_attack_setup
{
static npc &spawn_main_npc()
{
    map &here = get_map();
    creature_tracker &creatures = get_creature_tracker();
    get_player_character().setpos( here, { main_npc_start, -1 } );
    REQUIRE( creatures.creature_at<Creature>( main_npc_start_tripoint ) == nullptr );
    const character_id model_id = here.place_npc( main_npc_start, npc_template_test_talker );

    npc &model_npc = *g->find_npc( model_id );
    clear_character( model_npc );
    model_npc.setpos( here, main_npc_start_tripoint );

    g->load_npcs();

    REQUIRE( creatures.creature_at<npc>( main_npc_start_tripoint ) != nullptr );

    return model_npc;
}

static npc &respawn_main_npc()
{
    npc *guy = get_creature_tracker().creature_at<npc>( main_npc_start_tripoint );
    if( guy ) {
        guy->die( &get_map(), nullptr );
    }
    return spawn_main_npc();
}

static monster *spawn_zombie_at_range( const int range )
{
    return g->place_critter_at( mon_zombie, main_npc_start_tripoint + tripoint( range, 0, 0 ) );
}
} // namespace npc_attack_setup

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
        WHEN( "NPC only has a bunch of rocks" ) {
            item weapon( itype_rock );
            main_npc.set_wielded_item( weapon );
            REQUIRE( main_npc.get_wielded_item()->typeId() == itype_rock );

            THEN( "NPC doesn't bother throwing the rocks so close" ) {
                main_npc.evaluate_best_attack( zombie );
                const std::shared_ptr<npc_attack> &attack = main_npc.get_current_attack();
                npc_attack_throw *throw_attack = dynamic_cast<npc_attack_throw *>( attack.get() );
                CHECK( !throw_attack );
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

        WHEN( "NPC only has a bunch of rocks" ) {
            // Make the intended ranged attack useful and explicitly allowed.
            main_npc.set_skill_level( skill_throw, 10 );
            main_npc.rules.set_flag( ally_rule::use_guns );
            REQUIRE( main_npc.wear_item( item( itype_backpack ) ) );
            for( int n = 0; n < 4; ++n ) {
                REQUIRE( main_npc.i_add( item( itype_rock ) ) );
            }
            item weapon( itype_rock );
            main_npc.set_wielded_item( weapon );
            REQUIRE( main_npc.get_wielded_item()->typeId() == itype_rock );

            THEN( "NPC throws rocks at the zombie" ) {
                main_npc.regen_ai_cache();
                REQUIRE( ( main_npc.amount_of( itype_rock ) > 1 ||
                           main_npc.charges_of( itype_rock ) > 1 ) );
                main_npc.evaluate_best_attack( zombie );
                const std::shared_ptr<npc_attack> &attack = main_npc.get_current_attack();
                npc_attack_throw *throw_attack = dynamic_cast<npc_attack_throw *>( attack.get() );
                CHECK( throw_attack );
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


TEST_CASE( "NPC_sniper_acquires_a_visible_distant_enemy_without_advancing",
           "[npc_attack][ranged][autonomy]" )
{
    clear_map_and_put_player_underground();
    clear_vehicles();
    scoped_weather_override sunny_weather( weather_sunny );
    npc &shooter = npc_attack_setup::respawn_main_npc();
    shooter.set_fac( faction_your_followers );
    shooter.set_attitude( NPCATT_FOLLOW );
    shooter.rules = npc_follower_rules();
    shooter.set_skill_level( skill_id( "gun" ), 10 );
    shooter.set_skill_level( skill_id( "rifle" ), 10 );
    arm_shooter( shooter, itype_id( "remington_700" ), { itype_id( "rifle_scope" ) } );
    get_player_character().setpos( get_map(), main_npc_start_tripoint + tripoint( 0, 2, 0 ) );
    monster *enemy = npc_attack_setup::spawn_zombie_at_range( 24 );
    REQUIRE( enemy != nullptr );
    set_time_to_day();
    REQUIRE( shooter.rules.engagement == combat_engagement::CLOSE );
    REQUIRE( shooter.sees( get_map(), *enemy ) );
    const item_location gun = shooter.get_wielded_item();
    REQUIRE( gun );
    REQUIRE( shooter.confident_shoot_range( *gun,
                                          shooter.most_accurate_aiming_method_limit( *gun ) ) >= 24 );
    shooter.invalidate_range_cache();
    shooter.regen_ai_cache();
    CHECK( shooter.current_target() == enemy );
    shooter.evaluate_best_attack( enemy );
    CHECK( dynamic_cast<npc_attack_gun *>( shooter.get_current_attack().get() ) != nullptr );
    const tripoint_bub_ms position = shooter.pos_bub();
    shooter.set_moves( 100 );
    CHECK_FALSE( shooter.autonomous_tactical_step() );
    CHECK( shooter.pos_bub() == position );
}

TEST_CASE( "NPC_can_schedule_an_empty_firearm_with_a_loaded_spare_magazine",
           "[npc_attack][ranged][reload]" )
{
    clear_map_and_put_player_underground();
    scoped_weather_override sunny_weather( weather_sunny );
    npc &shooter = npc_attack_setup::respawn_main_npc();
    shooter.set_fac( faction_your_followers );
    shooter.rules = npc_follower_rules();
    REQUIRE( shooter.wear_item( item( itype_id( "debug_backpack" ) ), false ).has_value() );
    shooter.set_wielded_item( item( itype_id( "glock_19" ) ) );
    item magazine( itype_id( "glockmag" ) );
    magazine.ammo_set( itype_id( "9mm" ), 15 );
    const item_location spare = shooter.i_add( magazine );
    REQUIRE( spare );
    monster *enemy = npc_attack_setup::spawn_zombie_at_range( 5 );
    REQUIRE( enemy != nullptr );
    set_time_to_day();
    REQUIRE( shooter.sees( get_map(), *enemy ) );
    item_location gun = shooter.get_wielded_item();
    REQUIRE( gun );
    REQUIRE( gun->ammo_remaining() == 0 );
    npc_attack_gun attack( *gun, gun->gun_current_mode() );
    const npc_attack_rating rating = attack.evaluate( shooter, enemy );
    REQUIRE( rating.value().has_value() );
    CHECK( rating.target() == enemy->pos_bub() );
    CHECK( gun->ammo_remaining() == 0 );
    CHECK( spare->ammo_remaining() == 15 );
    shooter.set_moves( 100 );
    attack.use( shooter, enemy->pos_bub() );
    CHECK( gun->ammo_remaining() == 15 );
    CHECK( shooter.get_moves() < 100 );
}

TEST_CASE( "NPC_reload_prefers_a_ready_magazine_over_loose_rounds_and_inferior_magazines",
           "[npc_attack][reload]" )
{
    clear_map_and_put_player_underground();
    npc &shooter = npc_attack_setup::respawn_main_npc();
    shooter.set_fac( faction_your_followers );
    REQUIRE( shooter.wear_item( item( itype_id( "debug_backpack" ) ), false ).has_value() );
    item weapon( itype_id( "glock_19" ) );
    weapon.ammo_set( itype_id( "9mm" ), 5 );
    shooter.set_wielded_item( weapon );
    item magazine( itype_id( "glockmag" ) );
    magazine.ammo_set( itype_id( "9mm" ), 2 );
    REQUIRE( shooter.i_add( magazine ) );
    magazine.ammo_set( itype_id( "9mm" ), 15 );
    const item_location full_magazine = shooter.i_add( magazine );
    REQUIRE( full_magazine );
    REQUIRE( shooter.i_add( item( itype_id( "9mm" ), calendar::turn, 100 ) ) );
    const item_location gun = shooter.get_wielded_item();
    REQUIRE( gun );
    SECTION( "a full magazine wins over filling the inserted one" ) {
        const item::reload_option reload = shooter.select_ammo( gun );
        REQUIRE( reload );
        CHECK( reload.ammo == full_magazine );
        CHECK( shooter.find_usable_ammo( gun ) == full_magazine );
        shooter.set_moves( 100 );
        const int cost = reload.moves();
        shooter.do_reload( gun );
        CHECK( gun->ammo_remaining() == 15 );
        CHECK( shooter.get_moves() == 100 - cost );
    }
    SECTION( "private magazines are not used" ) {
        full_magazine->set_owner( faction_id( "free_merchants" ) );
        const item::reload_option reload = shooter.select_ammo( gun );
        REQUIRE( reload );
        CHECK( reload.ammo != full_magazine );
        CHECK( reload.ammo->is_ammo() );
    }
}


TEST_CASE( "NPC_can_load_a_first_shot_without_filling_a_magazine_during_combat",
           "[npc_attack][reload]" )
{
    clear_map_and_put_player_underground();
    npc &shooter = npc_attack_setup::respawn_main_npc();
    shooter.set_fac( faction_your_followers );
    REQUIRE( shooter.wear_item( item( itype_id( "debug_backpack" ) ), false ).has_value() );
    item weapon( itype_id( "glock_19" ) );
    weapon.ammo_set( itype_id( "9mm" ), 15 );
    REQUIRE( weapon.magazine_current() != nullptr );
    weapon.magazine_current()->ammo_unset();
    shooter.set_wielded_item( weapon );
    REQUIRE( shooter.i_add( item( itype_id( "9mm" ), calendar::turn, 100 ) ) );
    const item_location gun = shooter.get_wielded_item();
    REQUIRE( gun );
    REQUIRE( shooter.select_ammo( gun ).qty() == 15 );
    shooter.ai_cache.total_danger = 1;
    REQUIRE_FALSE( shooter.is_safe() );
    const item::reload_option reload = shooter.select_ammo( gun );
    REQUIRE( reload );
    CHECK( reload.qty() == 1 );
    shooter.set_moves( 100 );
    shooter.do_reload( gun );
    CHECK( gun->ammo_remaining() == 1 );
}


TEST_CASE( "NPC_fires_the_evaluated_burst_instead_of_the_previous_single_shot_mode",
           "[npc_attack][ranged]" )
{
    clear_map_and_put_player_underground();
    npc &shooter = npc_attack_setup::respawn_main_npc();
    shooter.set_fac( faction_your_followers );
    arm_shooter( shooter, itype_modular_m16a4 );
    const item_location gun = shooter.get_wielded_item();
    REQUIRE( gun );
    gun->set_flag( flag_NEVER_JAMS );
    REQUIRE( gun->gun_set_mode( gun_mode_id( "DEFAULT" ) ) );
    const gun_mode burst = gun->gun_all_modes().at( gun_mode_id( "BURST" ) );
    REQUIRE( burst.qty == 3 );
    const int rounds = gun->ammo_remaining();
    REQUIRE( rounds >= burst.qty );
    shooter.recoil = 0;
    shooter.set_moves( 1000 );
    npc_attack_gun attack( *gun, burst );
    attack.use( shooter, shooter.pos_bub() + tripoint( 1, 0, 0 ) );
    CHECK( gun->gun_current_mode().qty == burst.qty );
    CHECK( gun->ammo_remaining() == rounds - burst.qty );
}

TEST_CASE( "NPC_sparse_gun_candidates_preserve_occupied_tile_order_and_best_attack",
           "[npc_attack][ranged][autonomy][candidates]" )
{
    clear_map_and_put_player_underground();
    scoped_weather_override sunny_weather( weather_sunny );
    npc &shooter = npc_attack_setup::respawn_main_npc();
    shooter.set_fac( faction_your_followers );
    shooter.rules = npc_follower_rules();
    item weapon( itype_id( "glock_19" ) );
    weapon.ammo_set( itype_id( "9mm" ), 15 );
    shooter.set_wielded_item( weapon );
    get_player_character().setpos( get_map(), main_npc_start_tripoint + tripoint( 0, 2, 0 ) );
    monster *enemy = npc_attack_setup::spawn_zombie_at_range( 5 );
    REQUIRE( enemy != nullptr );
    REQUIRE( g->place_critter_at( mon_zombie, main_npc_start_tripoint + tripoint( 2, -3, 0 ) ) );
    set_time_to_day();
    item_location gun = shooter.get_wielded_item();
    REQUIRE( gun );
    npc_attack_gun attack( *gun, gun->gun_current_mode() );
    std::vector<tripoint_bub_ms> expected;
    for( const tripoint_bub_ms &p : get_map().points_in_radius( shooter.pos_bub(),
            gun->gun_range( &shooter ) ) ) {
        if( get_creature_tracker().creature_at( p ) ) {
            expected.push_back( p );
        }
    }
    const auto evaluations = attack.all_evaluations( shooter, enemy );
    REQUIRE( evaluations.size() == expected.size() );
    npc_attack_rating best( std::nullopt, shooter.pos_bub() );
    for( size_t i = 0; i < evaluations.size(); ++i ) {
        if( evaluations[i].value() ) {
            CHECK( evaluations[i].target() == expected[i] );
        }
        if( evaluations[i] > best ) {
            best = evaluations[i];
        }
    }
    const npc_attack_rating selected = attack.evaluate( shooter, enemy );
    CHECK( selected.value() == best.value() );
    CHECK( selected.target() == best.target() );
    CHECK( gun->ammo_remaining() == 15 );
}
