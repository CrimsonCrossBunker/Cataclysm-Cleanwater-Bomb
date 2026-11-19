#include <cstddef>
#include <functional>
#include <memory>
#include <string>
#include <vector>

#include "activity_actor_definitions.h"
#include "avatar.h"
#include "bodypart.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "character_id.h"
#include "coordinates.h"
#include "debug.h"
#include "event.h"
#include "event_bus.h"
#include "event_subscriber.h"
#include "game.h"
#include "generic_factory.h"
#include "item.h"
#include "item_location.h"
#include "json.h"
#include "json_loader.h"
#include "lua_platform_content.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "morale.h"
#include "npc.h"
#include "options_helpers.h"
#include "pimpl.h"
#include "player_activity.h"
#include "player_helpers.h"
#include "point.h"
#include "subbodypart.h"
#include "type_id.h"
#include "units.h"
#include "weather.h"
#include "weather_type.h"
#include "wound.h"

static const damage_type_id damage_heat( "heat" );

static const efftype_id effect_cold( "cold" );
static const efftype_id effect_hot( "hot" );
static const efftype_id effect_took_prozac( "took_prozac" );

static const field_type_str_id field_fd_fire( "fd_fire" );

static const itype_id itype_boots( "boots" );
static const itype_id itype_legpouch( "legpouch" );
static const itype_id itype_shotgun_s( "shotgun_s" );
static const itype_id itype_test_protective_clothing( "test_protective_clothing" );
static const itype_id itype_test_zentai( "test_zentai" );
static const itype_id itype_test_zentai_immune_test_fire( "test_zentai_immune_test_fire" );
static const itype_id itype_tinfoil_hat( "tinfoil_hat" );

static const json_character_flag json_flag_HEAT_IMMUNE( "HEAT_IMMUNE" );
static const json_character_flag json_flag_IGNORE_TEMP( "IGNORE_TEMP" );

static const morale_type morale_book( "morale_book" );
static const morale_type morale_food_bad( "morale_food_bad" );
static const morale_type morale_food_good( "morale_food_good" );
static const morale_type morale_killed_innocent( "morale_killed_innocent" );
static const morale_type morale_perm_badtemper( "morale_perm_badtemper" );
static const morale_type morale_perm_constrained( "morale_perm_constrained" );
static const morale_type morale_perm_masochist( "morale_perm_masochist" );
static const morale_type morale_perm_optimist( "morale_perm_optimist" );
static const morale_type morale_pyromania_nearfire( "morale_pyromania_nearfire" );
static const morale_type morale_pyromania_nofire( "morale_pyromania_nofire" );
static const morale_type morale_wet( "morale_wet" );

static const ter_str_id ter_t_water_hot( "t_water_hot" );

static const trait_id trait_BADTEMPER( "BADTEMPER" );
static const trait_id trait_CENOBITE( "CENOBITE" );
static const trait_id trait_DEBUG_CLAIRVOYANCE( "DEBUG_CLAIRVOYANCE" );
static const trait_id trait_FLOWERS( "FLOWERS" );
static const trait_id trait_MASOCHIST( "MASOCHIST" );
static const trait_id trait_OPTIMISTIC( "OPTIMISTIC" );
static const trait_id trait_PLANT( "PLANT" );
static const trait_id trait_PYROMANIA( "PYROMANIA" );
static const trait_id trait_ROOTS1( "ROOTS1" );

TEST_CASE( "player_morale_empty", "[player_morale]" )
{
    player_morale m;

    GIVEN( "an empty morale" ) {
        CHECK( m.get_level() == 0 );
    }
}

TEST_CASE( "temporary_pain_relief_and_ceiling_leave_wounds_and_painkillers_intact",
           "[player_morale][thermal_burn]" )
{
    clear_avatar();
    avatar &u = get_avatar();
    const efftype_id relief( "pain_relief" );
    const efftype_id ceiling( "pain_ceiling" );
    REQUIRE( u.apply_thermal_burn( body_part_arm_l, true ) );
    u.set_pain( 47 );
    u.set_painkiller( 5 );
    REQUIRE( u.get_perceived_pain() == 52 );

    u.add_effect( ceiling, 1_hours, false, 40 );
    CHECK( u.get_perceived_pain() == 40 );
    u.add_effect( relief, 3_minutes, false, 30 );
    CHECK( u.get_perceived_pain() == 10 );
    u.set_pain( 0 );
    CHECK( u.get_perceived_pain() == 0 );

    REQUIRE( u.remove_effect( relief ) );
    CHECK( u.get_perceived_pain() == 5 );
    REQUIRE( u.remove_effect( ceiling ) );
    CHECK( u.get_painkiller() == 5 );
    CHECK( u.Creature::get_pain() == 0 );
    CHECK( u.get_pain() == 10 );
}

TEST_CASE( "environmental_blisters_react_to_the_combined_felt_pain",
           "[player_morale][thermal_burn][pain_transition]" )
{
    clear_map_without_vision();
    auto storage = std::make_unique<standard_npc>( "Heat exposure test NPC",
                   tripoint_bub_ms( 50, 50, 0 ) );
    standard_npc &target = *storage;
    clear_character( target, true );
    target.toggle_trait( trait_MASOCHIST );
    // A 4–6 wake threshold is above either individual blister, but not their sum.
    target.set_sensitive( 75 );

    const restore_on_out_of_scope restore_turn( calendar::turn );
    const restore_on_out_of_scope restore_temperature( get_weather().forced_temperature );
    get_weather().forced_temperature = 19_C;
    calendar::turn = calendar::turn_zero;
    const auto sample_heat = [&target]() {
        calendar::turn += 1_turns;
        target.set_all_parts_temp_cur( BODYTEMP_NORM );
        target.set_part_temp_cur( body_part_arm_l, BODYTEMP_SCORCHING + 2_C_delta );
        target.set_part_temp_cur( body_part_arm_r, BODYTEMP_SCORCHING + 2_C_delta );
        return target.update_bodytemp( true );
    };
    for( int turn = 0; turn < 29; ++turn ) {
        REQUIRE( sample_heat() );
    }
    REQUIRE( target.get_perceived_pain() == 0 );
    const efftype_id sleep( "sleep" );
    target.add_effect( sleep, 1_hours );
    REQUIRE( target.get_effect_dur( sleep ) > 0_turns );

    SECTION( "the blisters together wake the sleeper" ) {
        REQUIRE( sample_heat() );
        CHECK( target.get_perceived_pain() == 6 );
        CHECK( target.has_morale( morale_perm_masochist ) == 6 );
        CHECK( target.get_effect_dur( sleep ) == 0_turns );
        CHECK( target.Creature::get_pain() == 0 );
    }
    SECTION( "analgesia masks the reaction, but not the wounds" ) {
        target.set_painkiller( 6 );
        REQUIRE( sample_heat() );
        CHECK( target.get_pain() == 6 );
        CHECK( target.get_perceived_pain() == 0 );
        CHECK( target.has_morale( morale_perm_masochist ) == 0 );
        CHECK( target.get_effect_dur( sleep ) == 1_hours );
        CHECK( target.Creature::get_pain() == 0 );
    }
    SECTION( "waking can invalidate the heated character" ) {
        struct wake_observer : event_subscriber {
            using event_subscriber::notify;

            std::unique_ptr<standard_npc> &target_storage;
            character_id target_id;

            explicit wake_observer( std::unique_ptr<standard_npc> &storage ) :
                target_storage( storage ), target_id( storage->getID() ) {
                get_event_bus().subscribe( this );
            }

            void notify( const cata::event &e ) override {
                if( e.type() == event_type::character_wakes_up &&
                    e.get<character_id>( "character" ) == target_id ) {
                    target_storage.reset();
                }
            }
        } observer( storage );
        CHECK_FALSE( sample_heat() );
        CHECK_FALSE( storage );
    }
}

TEST_CASE( "treating_a_burn_updates_pain_morale_immediately",
           "[player_morale][thermal_burn][pain_transition]" )
{
    const wound_fix_id fix( "test_pain_morale_after_burn_treatment" );
    wound_fix::load_wound_fixes( json_loader::from_string( R"({
        "id": "test_pain_morale_after_burn_treatment",
        "name": "test burn treatment",
        "description": "A treatment that removes a severe burn.",
        "success_msg": "Test treatment finished.",
        "wounds_removed": [ "thermal_burn" ]
    })" ).get_object(), "TEST_DATA" );
    const on_out_of_scope cleanup( [&fix]() {
        cata::lua_platform::detail::wound_fix_registry().erase( fix );
    } );
    REQUIRE( fix.is_valid() );
    const_cast<wound_fix &>( *fix ).finalize();

    clear_map_without_vision();
    standard_npc patient( "Burn treatment test NPC", tripoint_bub_ms( 50, 50, 0 ) );
    clear_character( patient, true );
    patient.toggle_trait( trait_MASOCHIST );
    REQUIRE( patient.apply_thermal_burn( body_part_arm_l, true ) );
    patient.set_pain( 2 );
    REQUIRE( patient.has_morale( morale_perm_masochist ) == 12 );

    const wound_type_id burn( "thermal_burn" );
    fix_wound_activity_actor treatment( 1_turns, body_part_arm_l, burn, fix );
    player_activity activity( treatment );
    treatment.finish( activity, patient );

    CHECK_FALSE( patient.get_part( body_part_arm_l )->has_wound( burn ) );
    CHECK( patient.get_perceived_pain() == 2 );
    CHECK( patient.has_morale( morale_perm_masochist ) == 2 );
}

TEST_CASE( "player_morale_decay", "[player_morale]" )
{
    player_morale m;

    GIVEN( "temporary morale (food)" ) {
        m.add( morale_food_good, 20, 40, 20_turns, 10_turns );
        m.add( morale_food_bad, -10, -20, 20_turns, 10_turns );

        CHECK( m.has( morale_food_good ) == 20 );
        CHECK( m.has( morale_food_bad ) == -10 );
        CHECK( m.get_level() == 10 );

        WHEN( "it decays" ) {
            AND_WHEN( "it's just started" ) {
                m.decay( 10_turns );
                CHECK( m.has( morale_food_good ) == 20 );
                CHECK( m.has( morale_food_bad ) == -10 );
                CHECK( m.get_level() == 10 );
            }
            AND_WHEN( "it's halfway there" ) {
                m.decay( 15_turns );
                CHECK( m.has( morale_food_good ) == 10 );
                CHECK( m.has( morale_food_bad ) == -5 );
                CHECK( m.get_level() == 5 );
            }
            AND_WHEN( "it's finished" ) {
                m.decay( 20_turns );
                CHECK( m.has( morale_food_good ) == 0 );
                CHECK( m.has( morale_food_bad ) == 0 );
                CHECK( m.get_level() == 0 );
            }
        }

        WHEN( "it gets deleted" ) {
            AND_WHEN( "good one gets deleted" ) {
                m.remove( morale_food_good );
                CHECK( m.get_level() == -10 );
            }
            AND_WHEN( "bad one gets deleted" ) {
                m.remove( morale_food_bad );
                CHECK( m.get_level() == 20 );
            }
            AND_WHEN( "both get deleted" ) {
                m.remove( morale_food_bad );
                m.remove( morale_food_good );
                CHECK( m.get_level() == 0 );
            }
        }

        WHEN( "it gets cleared" ) {
            m.clear();
            CHECK( m.get_level() == 0 );
        }

        WHEN( "it's added/subtracted (no cap)" ) {
            m.add( morale_food_good, 10, 40, 20_turns, 10_turns, false );
            m.add( morale_food_bad, -10, -20, 20_turns, 10_turns, false );

            CHECK( m.has( morale_food_good ) == 22 );
            CHECK( m.has( morale_food_bad ) == -14 );
            CHECK( m.get_level() == 8 );

        }

        WHEN( "it's added/subtracted (with a cap)" ) {
            m.add( morale_food_good, 5, 10, 20_turns, 10_turns, true );
            m.add( morale_food_bad, -5, -10, 20_turns, 10_turns, true );

            CHECK( m.has( morale_food_good ) == 10 );
            CHECK( m.has( morale_food_bad ) == -10 );
            CHECK( m.get_level() == 0 );
        }
    }
}

TEST_CASE( "player_morale_persistent", "[player_morale]" )
{
    player_morale m;

    GIVEN( "persistent morale" ) {
        m.set_permanent( morale_perm_masochist, 5 );

        CHECK( m.has( morale_perm_masochist ) == 5 );

        WHEN( "it decays" ) {
            m.decay( 100_turns );
            THEN( "nothing happens" ) {
                CHECK( m.has( morale_perm_masochist ) == 5 );
                CHECK( m.get_level() == 5 );
            }
        }
    }
}

TEST_CASE( "player_morale_optimist", "[player_morale]" )
{
    player_morale m;

    GIVEN( "OPTIMISTIC trait" ) {
        m.on_mutation_gain( trait_OPTIMISTIC );
        CHECK( m.has( morale_perm_optimist ) == 9 );
        CHECK( m.get_level() == 10 );

        WHEN( "lost the trait" ) {
            m.on_mutation_loss( trait_OPTIMISTIC );
            CHECK( m.has( morale_perm_optimist ) == 0 );
            CHECK( m.get_level() == 0 );
        }
    }
}

TEST_CASE( "player_morale_bad_temper", "[player_morale]" )
{
    player_morale m;

    GIVEN( "BADTEMPER trait" ) {
        m.on_mutation_gain( trait_BADTEMPER );
        CHECK( m.has( morale_perm_badtemper ) == -9 );
        CHECK( m.get_level() == -10 );

        WHEN( "lost the trait" ) {
            m.on_mutation_loss( trait_BADTEMPER );
            CHECK( m.has( morale_perm_badtemper ) == 0 );
            CHECK( m.get_level() == 0 );
        }
    }
}

TEST_CASE( "player_morale_killed_innocent_affected_by_prozac", "[player_morale]" )
{
    player_morale m;

    GIVEN( "killed an innocent" ) {
        m.add( morale_killed_innocent, -100 );

        WHEN( "took prozac" ) {
            m.on_effect_int_change( effect_took_prozac, 1 );

            THEN( "it's not so bad" ) {
                CHECK( m.get_level() == -25 );

                AND_WHEN( "the effect ends" ) {
                    m.on_effect_int_change( effect_took_prozac, 0 );

                    THEN( "guilt returns" ) {
                        CHECK( m.get_level() == -100 );
                    }
                }
            }
        }
    }
}

TEST_CASE( "player_morale_murdered_innocent", "[player_morale]" )
{
    map &here = get_map();
    clear_avatar();
    Character &player = get_player_character();
    player_morale &m = *player.morale;
    tripoint_bub_ms next_to = player.adjacent_tile();
    standard_npc innocent( "Lapin", next_to, {}, 0, 8, 8, 8, 7 );
    // Innocent as could be.
    faction_id lapin( "lapin" );
    innocent.set_fac( lapin );
    innocent.setpos( here, next_to );
    innocent.set_all_parts_hp_cur( 1 );
    CHECK( m.get_total_positive_value() == 0 );
    CHECK( m.get_total_negative_value() == 0 );
    CHECK( innocent.hit_by_player == false );
    while( !innocent.is_dead_state() ) {
        player.mod_moves( 1000 );
        player.melee_attack( innocent, true );
    }
    // Death is just a data state, we can still do useful checks even after they're dead.
    CHECK( innocent.hit_by_player == true );
    REQUIRE( m.get_total_negative_value() == 90 );
}

TEST_CASE( "player_morale_kills_hostile_bandit", "[player_morale]" )
{
    map &here = get_map();
    clear_avatar();
    Character &player = get_player_character();
    player_morale &m = *player.morale;
    tripoint_bub_ms next_to = player.adjacent_tile();
    standard_npc badguy( "Raider", next_to, {}, 0, 8, 8, 8, 7 );
    // Always-hostile
    faction_id hells_raiders( "hells_raiders" );
    badguy.set_fac( hells_raiders );
    badguy.setpos( here, next_to );
    badguy.set_all_parts_hp_cur( 1 );
    CHECK( m.get_total_positive_value() == 0 );
    CHECK( m.get_total_negative_value() == 0 );
    CHECK( badguy.guaranteed_hostile() == true );
    while( !badguy.is_dead_state() ) {
        player.mod_moves( 1000 );
        player.melee_attack( badguy, true );
    }
    REQUIRE( m.get_total_negative_value() == 0 );
}

TEST_CASE( "player_morale_ranged_kill_of_unaware_hostile_bandit", "[player_morale]" )
{
    map &here = get_map();
    clear_map();
    clear_avatar();
    avatar &player = get_avatar();
    // Set the time to midnight to ensure the bandit doesn't notice the player.
    set_time( calendar::turn_zero + 0_hours );
    // Give us a clairvoyance to clearly see the target in the night.
    player.set_mutation( trait_DEBUG_CLAIRVOYANCE );
    player_morale &m = *player.morale;
    const tripoint_bub_ms bandit_pos = player.pos_bub() + ( point::east * 2 );
    npc &badguy = spawn_npc( bandit_pos.xy(), "thug" );
    badguy.set_all_parts_hp_cur( 1 );
    CHECK( m.get_total_positive_value() == 0 );
    CHECK( m.get_total_negative_value() == 0 );
    CHECK( badguy.guaranteed_hostile() == true );
    CHECK( badguy.sees( here,  player.pos_bub( here ) ) == false );
    for( size_t loop = 0; loop < 1000; loop++ ) {
        player.set_body();
        arm_shooter( player, itype_shotgun_s );
        player.recoil = 0;
        player.fire_gun( here, bandit_pos, 1, *player.get_wielded_item() );
        if( badguy.is_dead_state() ) {
            break;
        }
    }
    CHECK( badguy.is_dead_state() == true );
    REQUIRE( m.get_total_negative_value() == 0 );
}

TEST_CASE( "player_morale_masochist", "[player_morale]" )
{
    player_morale m;

    GIVEN( "masochist trait" ) {
        m.on_mutation_gain( trait_MASOCHIST );

        CHECK( m.has( morale_perm_masochist ) == 0 );

        WHEN( "in minimal pain" ) {
            m.on_stat_change( "perceived_pain", 10 );
            CHECK( m.has( morale_perm_masochist ) == 10 );
        }

        WHEN( "in mind pain" ) {
            m.on_stat_change( "perceived_pain", 20 );
            CHECK( m.has( morale_perm_masochist ) == 20 );
        }

        WHEN( "in an insufferable pain" ) {
            m.on_stat_change( "perceived_pain", 120 );
            THEN( "there's a limit" ) {
                CHECK( m.has( morale_perm_masochist ) == 20 );
            }
        }
    }

    GIVEN( "masochist morale table" ) {
        m.on_mutation_gain( trait_MASOCHIST );

        CHECK( m.has( morale_perm_masochist ) == 0 );

        WHEN( "in minimal pain" ) {
            m.on_stat_change( "perceived_pain", 10 );
            CHECK( m.has( morale_perm_masochist ) - ( m.get_perceived_pain() > 20 ? m.get_perceived_pain() -
                    20 : 0 ) == 10 );
        }

        WHEN( "in mind pain" ) {
            m.on_stat_change( "perceived_pain", 20 );
            CHECK( m.has( morale_perm_masochist ) - ( m.get_perceived_pain() > 20 ? m.get_perceived_pain() -
                    20 : 0 ) == 20 );
        }

        WHEN( "in moderate pain" ) {
            m.on_stat_change( "perceived_pain", 30 );
            CHECK( m.has( morale_perm_masochist ) - ( m.get_perceived_pain() > 20 ? m.get_perceived_pain() -
                    20 : 0 ) == 10 );
        }

        WHEN( "in distracting pain" ) {
            m.on_stat_change( "perceived_pain", 40 );
            CHECK( m.has( morale_perm_masochist ) - ( m.get_perceived_pain() > 20 ? m.get_perceived_pain() -
                    20 : 0 ) == 0 );
        }

        WHEN( "in distressing pain" ) {
            m.on_stat_change( "perceived_pain", 50 );
            CHECK( m.has( morale_perm_masochist ) - ( m.get_perceived_pain() > 20 ? m.get_perceived_pain() -
                    20 : 0 ) == -10 );
        }

        WHEN( "in unmanagable pain" ) {
            m.on_stat_change( "perceived_pain", 60 );
            CHECK( m.has( morale_perm_masochist ) - ( m.get_perceived_pain() > 20 ? m.get_perceived_pain() -
                    20 : 0 ) == -20 );
        }

        WHEN( "in intense pain" ) {
            m.on_stat_change( "perceived_pain", 70 );
            CHECK( m.has( morale_perm_masochist ) - ( m.get_perceived_pain() > 20 ? m.get_perceived_pain() -
                    20 : 0 ) == -30 );
        }

        WHEN( "in severe pain" ) {
            m.on_stat_change( "perceived_pain", 80 );
            CHECK( m.has( morale_perm_masochist ) - ( m.get_perceived_pain() > 20 ? m.get_perceived_pain() -
                    20 : 0 ) == -40 );
        }
    }
}

TEST_CASE( "player_morale_cenobite", "[player_morale]" )
{
    player_morale m;

    GIVEN( "cenobite trait" ) {
        m.on_mutation_gain( trait_CENOBITE );

        CHECK( m.has( morale_perm_masochist ) == 0 );

        WHEN( "in an insufferable pain" ) {
            m.on_stat_change( "perceived_pain", 120 );

            THEN( "there's no limit" ) {
                CHECK( m.has( morale_perm_masochist ) == 120 );
            }

            AND_WHEN( "took prozac" ) {
                m.on_effect_int_change( effect_took_prozac, 1 );
                THEN( "it spoils all fun" ) {
                    CHECK( m.has( morale_perm_masochist ) == 60 );
                }
            }
        }
    }
}

TEST_CASE( "player_morale_plant", "[player_morale]" )
{
    player_morale m;

    GIVEN( "a humanoid plant" ) {
        m.on_mutation_gain( trait_PLANT );
        m.on_mutation_gain( trait_FLOWERS );
        m.on_mutation_gain( trait_ROOTS1 );

        CHECK( m.has( morale_perm_constrained ) == 0 );

        WHEN( "wearing a hat" ) {
            const item hat( itype_tinfoil_hat, calendar::turn_zero );

            m.on_item_wear( hat );
            THEN( "the flowers need sunlight" ) {
                CHECK( m.has( morale_perm_constrained ) == -10 );

                AND_WHEN( "taking it off again" ) {
                    m.on_item_takeoff( hat );
                    CHECK( m.has( morale_perm_constrained ) == 0 );
                }
            }
        }

        WHEN( "wearing a legpouch" ) {
            item legpouch( itype_legpouch, calendar::turn_zero );
            legpouch.set_side( side::LEFT );

            m.on_item_wear( legpouch );
            THEN( "half of the roots are suffering" ) {
                CHECK( m.has( morale_perm_constrained ) == -5 );
            }
        }

        WHEN( "wearing a pair of boots" ) {
            const item boots( itype_boots, calendar::turn_zero );

            m.on_item_wear( boots );
            THEN( "all of the roots are suffering" ) {
                CHECK( m.has( morale_perm_constrained ) == -10 );
            }

            AND_WHEN( "even more constrains" ) {
                const item hat( itype_tinfoil_hat, calendar::turn_zero );

                m.on_item_wear( hat );
                THEN( "it can't be worse" ) {
                    CHECK( m.has( morale_perm_constrained ) == -10 );
                }
            }
        }
    }
}

TEST_CASE( "player_morale_tough_temperature", "[player_morale]" )
{
    player_morale m;

    GIVEN( "tough temperature conditions" ) {
        WHEN( "chilly" ) {
            m.on_effect_int_change( effect_cold, 1, bodypart_id( "torso" ) );
            m.on_effect_int_change( effect_cold, 1, bodypart_id( "head" ) );
            m.on_effect_int_change( effect_cold, 1, bodypart_id( "eyes" ) );
            m.on_effect_int_change( effect_cold, 1, bodypart_id( "mouth" ) );
            m.on_effect_int_change( effect_cold, 1, bodypart_id( "arm_l" ) );
            m.on_effect_int_change( effect_cold, 1, bodypart_id( "arm_r" ) );
            m.on_effect_int_change( effect_cold, 1, bodypart_id( "leg_l" ) );
            m.on_effect_int_change( effect_cold, 1, bodypart_id( "leg_r" ) );
            m.on_effect_int_change( effect_cold, 1, bodypart_id( "hand_l" ) );
            m.on_effect_int_change( effect_cold, 1, bodypart_id( "hand_r" ) );
            m.on_effect_int_change( effect_cold, 1, bodypart_id( "foot_l" ) );
            m.on_effect_int_change( effect_cold, 1, bodypart_id( "foot_r" ) );

            AND_WHEN( "no time has passed" ) {
                CHECK( m.get_level() == 0 );
            }
            AND_WHEN( "1 turn has passed" ) {
                m.decay( 1_turns );
                CHECK( m.get_level() == -2 );
            }
            AND_WHEN( "2 turns have passed" ) {
                m.decay( 2_turns );
                CHECK( m.get_level() == -4 );
            }
            AND_WHEN( "3 turns have passed" ) {
                m.decay( 3_turns );
                CHECK( m.get_level() == -6 );
            }
            AND_WHEN( "6 minutes have passed" ) {
                m.decay( 6_minutes );
                CHECK( m.get_level() == -10 );
            }
        }

        WHEN( "cold" ) {
            m.on_effect_int_change( effect_cold, 2, bodypart_id( "torso" ) );
            m.on_effect_int_change( effect_cold, 2, bodypart_id( "head" ) );
            m.on_effect_int_change( effect_cold, 2, bodypart_id( "eyes" ) );
            m.on_effect_int_change( effect_cold, 2, bodypart_id( "mouth" ) );
            m.on_effect_int_change( effect_cold, 2, bodypart_id( "arm_l" ) );
            m.on_effect_int_change( effect_cold, 2, bodypart_id( "arm_r" ) );
            m.on_effect_int_change( effect_cold, 2, bodypart_id( "leg_l" ) );
            m.on_effect_int_change( effect_cold, 2, bodypart_id( "leg_r" ) );
            m.on_effect_int_change( effect_cold, 2, bodypart_id( "hand_l" ) );
            m.on_effect_int_change( effect_cold, 2, bodypart_id( "hand_r" ) );
            m.on_effect_int_change( effect_cold, 2, bodypart_id( "foot_l" ) );
            m.on_effect_int_change( effect_cold, 2, bodypart_id( "foot_r" ) );

            AND_WHEN( "no time has passed" ) {
                CHECK( m.get_level() == 0 );
            }
            AND_WHEN( "1 turn has passed" ) {
                m.decay( 1_turns );
                CHECK( m.get_level() == -2 );
            }
            AND_WHEN( "9 turns have passed" ) {
                m.decay( 9_turns );
                CHECK( m.get_level() == -18 );
            }
            AND_WHEN( "1 minute has passed" ) {
                m.decay( 1_minutes );
                CHECK( m.get_level() == -20 );
            }
            AND_WHEN( "6 minutes have passed" ) {
                m.decay( 6_minutes );
                CHECK( m.get_level() == -20 );
            }
            AND_WHEN( "warmed up afterwards" ) {
                m.on_effect_int_change( effect_cold, 0, bodypart_id( "torso" ) );
                m.on_effect_int_change( effect_cold, 0, bodypart_id( "head" ) );
                m.on_effect_int_change( effect_cold, 0, bodypart_id( "eyes" ) );
                m.on_effect_int_change( effect_cold, 0, bodypart_id( "mouth" ) );
                m.on_effect_int_change( effect_cold, 0, bodypart_id( "arm_l" ) );
                m.on_effect_int_change( effect_cold, 0, bodypart_id( "arm_r" ) );
                m.on_effect_int_change( effect_cold, 0, bodypart_id( "leg_l" ) );
                m.on_effect_int_change( effect_cold, 0, bodypart_id( "leg_r" ) );
                m.on_effect_int_change( effect_cold, 0, bodypart_id( "hand_l" ) );
                m.on_effect_int_change( effect_cold, 0, bodypart_id( "hand_r" ) );
                m.on_effect_int_change( effect_cold, 0, bodypart_id( "foot_l" ) );
                m.on_effect_int_change( effect_cold, 0, bodypart_id( "foot_r" ) );

                m.decay( 1_minutes );
                CHECK( m.get_level() == 0 );
            }
        }

        WHEN( "warm" ) {
            m.on_effect_int_change( effect_hot, 1, bodypart_id( "torso" ) );
            m.on_effect_int_change( effect_hot, 1, bodypart_id( "head" ) );
            m.on_effect_int_change( effect_hot, 1, bodypart_id( "eyes" ) );
            m.on_effect_int_change( effect_hot, 1, bodypart_id( "mouth" ) );
            m.on_effect_int_change( effect_hot, 1, bodypart_id( "arm_l" ) );
            m.on_effect_int_change( effect_hot, 1, bodypart_id( "arm_r" ) );
            m.on_effect_int_change( effect_hot, 1, bodypart_id( "leg_l" ) );
            m.on_effect_int_change( effect_hot, 1, bodypart_id( "leg_r" ) );
            m.on_effect_int_change( effect_hot, 1, bodypart_id( "hand_l" ) );
            m.on_effect_int_change( effect_hot, 1, bodypart_id( "hand_r" ) );
            m.on_effect_int_change( effect_hot, 1, bodypart_id( "foot_l" ) );
            m.on_effect_int_change( effect_hot, 1, bodypart_id( "foot_r" ) );

            AND_WHEN( "no time has passed" ) {
                CHECK( m.get_level() == 0 );
            }
            AND_WHEN( "1 turn has passed" ) {
                m.decay( 1_turns );
                CHECK( m.get_level() == -2 );
            }
            AND_WHEN( "2 turns have passed" ) {
                m.decay( 2_turns );
                CHECK( m.get_level() == -4 );
            }
            AND_WHEN( "3 turns have passed" ) {
                m.decay( 3_turns );
                CHECK( m.get_level() == -6 );
            }
            AND_WHEN( "6 minutes have passed" ) {
                m.decay( 6_minutes );
                CHECK( m.get_level() == -10 );
            }
        }

        WHEN( "hot" ) {
            m.on_effect_int_change( effect_hot, 2, bodypart_id( "torso" ) );
            m.on_effect_int_change( effect_hot, 2, bodypart_id( "head" ) );
            m.on_effect_int_change( effect_hot, 2, bodypart_id( "eyes" ) );
            m.on_effect_int_change( effect_hot, 2, bodypart_id( "mouth" ) );
            m.on_effect_int_change( effect_hot, 2, bodypart_id( "arm_l" ) );
            m.on_effect_int_change( effect_hot, 2, bodypart_id( "arm_r" ) );
            m.on_effect_int_change( effect_hot, 2, bodypart_id( "leg_l" ) );
            m.on_effect_int_change( effect_hot, 2, bodypart_id( "leg_r" ) );
            m.on_effect_int_change( effect_hot, 2, bodypart_id( "hand_l" ) );
            m.on_effect_int_change( effect_hot, 2, bodypart_id( "hand_r" ) );
            m.on_effect_int_change( effect_hot, 2, bodypart_id( "foot_l" ) );
            m.on_effect_int_change( effect_hot, 2, bodypart_id( "foot_r" ) );

            AND_WHEN( "no time has passed" ) {
                CHECK( m.get_level() == 0 );
            }
            AND_WHEN( "1 turn has passed" ) {
                m.decay( 1_turns );
                CHECK( m.get_level() == -2 );
            }
            AND_WHEN( "9 turns have passed" ) {
                m.decay( 9_turns );
                CHECK( m.get_level() == -18 );
            }
            AND_WHEN( "1 minute has passed" ) {
                m.decay( 1_minutes );
                CHECK( m.get_level() == -20 );
            }
            AND_WHEN( "6 minutes have passed" ) {
                m.decay( 6_minutes );
                CHECK( m.get_level() == -20 );
            }
            AND_WHEN( "cooled afterwards" ) {
                m.on_effect_int_change( effect_hot, 0, bodypart_id( "torso" ) );
                m.on_effect_int_change( effect_hot, 0, bodypart_id( "head" ) );
                m.on_effect_int_change( effect_hot, 0, bodypart_id( "eyes" ) );
                m.on_effect_int_change( effect_hot, 0, bodypart_id( "mouth" ) );
                m.on_effect_int_change( effect_hot, 0, bodypart_id( "arm_l" ) );
                m.on_effect_int_change( effect_hot, 0, bodypart_id( "arm_r" ) );
                m.on_effect_int_change( effect_hot, 0, bodypart_id( "leg_l" ) );
                m.on_effect_int_change( effect_hot, 0, bodypart_id( "leg_r" ) );
                m.on_effect_int_change( effect_hot, 0, bodypart_id( "hand_l" ) );
                m.on_effect_int_change( effect_hot, 0, bodypart_id( "hand_r" ) );
                m.on_effect_int_change( effect_hot, 0, bodypart_id( "foot_l" ) );
                m.on_effect_int_change( effect_hot, 0, bodypart_id( "foot_r" ) );

                m.decay( 1_minutes );
                CHECK( m.get_level() == 0 );
            }
        }
    }
}

TEST_CASE( "player_morale_stacking", "[player_morale]" )
{
    player_morale m;

    GIVEN( "stacking of bonuses" ) {
        m.add( morale_food_good, 10, 40, 20_turns, 10_turns );
        m.add( morale_book, 10, 40, 20_turns, 10_turns );

        CHECK( m.has( morale_food_good ) == 10 );
        CHECK( m.has( morale_book ) == 10 );
        CHECK( m.get_level() == 14 );

        WHEN( "a bonus is added" ) {
            m.set_permanent( morale_perm_masochist, 50 );

            CHECK( m.has( morale_food_good ) == 10 );
            CHECK( m.has( morale_book ) == 10 );
            CHECK( m.has( morale_perm_masochist ) == 50 );

            CHECK( m.get_level() == 51 );
        }

        WHEN( "a negative bonus is added" ) {
            m.add( morale_wet, -10, -40, 20_turns, 10_turns );

            CHECK( m.has( morale_food_good ) == 10 );
            CHECK( m.has( morale_book ) == 10 );
            CHECK( m.has( morale_wet ) == -10 );

            CHECK( m.get_level() == 4 );
        }

        WHEN( "a bonus is lost" ) {
            m.remove( morale_book );

            CHECK( m.has( morale_food_good ) == 10 );
            CHECK( m.has( morale_book ) == 0 );

            CHECK( m.get_level() == 10 );
        }
    }
}

// Regression test for GitHub #85895: check_and_recover_morale was replacing
// the entire morale object when it found a permanent-point inconsistency,
// which destroyed all temporary morale (food, music, etc.).
TEST_CASE( "check_and_recover_morale_preserves_temporary_morale", "[player_morale]" )
{
    clear_avatar();
    avatar &dummy = get_avatar();
    player_morale &m = *dummy.morale;

    SECTION( "temporary morale survives when permanent point is inconsistent" ) {
        // Add temporary morale
        m.add( morale_food_good, 20, 40, 20_turns, 10_turns );
        REQUIRE( m.has( morale_food_good ) == 20 );

        // Inject a stale permanent point that the character should not have.
        // The avatar has no constrained mutations, so test_morale will
        // compute constrained = 0 and detect an inconsistency.
        m.set_permanent( morale_perm_constrained, -5 );
        REQUIRE( m.has( morale_perm_constrained ) == -5 );

        // The inconsistency triggers a debugmsg; capture it so the test
        // framework does not treat it as a failure.
        std::string dmsg = capture_debugmsg_during( [&dummy]() {
            dummy.check_and_recover_morale();
        } );
        CHECK( dmsg.empty() );

        // Recovery should fix the permanent point...
        CHECK( m.has( morale_perm_constrained ) == 0 );
        // ...without destroying the temporary morale
        CHECK( m.has( morale_food_good ) == 20 );
    }

    SECTION( "multiple temporary bonuses survive recovery" ) {
        m.add( morale_food_good, 15, 30, 20_turns, 10_turns );
        m.add( morale_book, 8, 16, 30_turns, 15_turns );
        REQUIRE( m.has( morale_food_good ) == 15 );
        REQUIRE( m.has( morale_book ) == 8 );

        // Inject inconsistency
        m.set_permanent( morale_perm_constrained, -3 );

        std::string dmsg = capture_debugmsg_during( [&dummy]() {
            dummy.check_and_recover_morale();
        } );
        CHECK( dmsg.empty() );

        CHECK( m.has( morale_food_good ) == 15 );
        CHECK( m.has( morale_book ) == 8 );
        CHECK( m.has( morale_perm_constrained ) == 0 );
    }
}

// Regression test for the save-load root cause: player_morale's mutation
// tracking is not initialized during load, so update_constrained_penalty()
// and update_masochist_bonus() compute wrong values when triggered.
TEST_CASE( "morale_mutation_state_after_load_like_sequence", "[player_morale]" )
{
    clear_avatar();
    avatar &dummy = get_avatar();
    player_morale &m = *dummy.morale;

    SECTION( "constrained penalty without mutation activation" ) {
        dummy.toggle_trait( trait_FLOWERS );
        REQUIRE( dummy.has_trait( trait_FLOWERS ) );

        // First verify correct behavior when properly set up
        const item hat( itype_tinfoil_hat, calendar::turn_zero );
        m.on_mutation_gain( trait_FLOWERS );
        m.on_item_wear( hat );
        REQUIRE( m.has( morale_perm_constrained ) == -10 );

        // Now simulate what save-load does: clear morale and rebuild
        // WITHOUT activating mutations (the bug)
        dummy.clear_morale();
        // Only replay item wear (as savegame_json.cpp:918 does)
        m.on_item_wear( hat );
        // Without mutation activation, constrained penalty is wrong
        CHECK( m.has( morale_perm_constrained ) == 0 );

        // After activating mutations (the fix), penalty is correct
        m.on_mutation_gain( trait_FLOWERS );
        CHECK( m.has( morale_perm_constrained ) == -10 );
    }

    SECTION( "temporary morale preserved through recovery after load fix" ) {
        dummy.toggle_trait( trait_FLOWERS );

        // Wear the hat through the Character so check_and_recover_morale
        // will see it when rebuilding test_morale from worn items.
        dummy.wear_item( item( itype_tinfoil_hat ) );

        // Activate mutations in morale (simulates the fix in savegame_json)
        for( const trait_id &mut : dummy.get_functioning_mutations() ) {
            m.on_mutation_gain( mut );
        }

        // Add temporary morale
        m.add( morale_food_good, 20, 40, 20_turns, 10_turns );
        REQUIRE( m.has( morale_food_good ) == 20 );
        REQUIRE( m.has( morale_perm_constrained ) == -10 );

        // check_and_recover should find consistency -- no wipe
        dummy.check_and_recover_morale();
        CHECK( m.has( morale_food_good ) == 20 );
        CHECK( m.has( morale_perm_constrained ) == -10 );
    }
}

TEST_CASE( "near_fire_pyromania_morale", "[player_morale][temperature]" )
{
    clear_map();
    clear_avatar();
    avatar &u = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms pos = u.pos_bub();
    const scoped_weather_override weather_clear( WEATHER_CLEAR );
    const restore_on_out_of_scope restore_temperature( get_weather().forced_temperature );
    get_weather().forced_temperature = 19_C;
    u.set_mutation( trait_PYROMANIA );
    u.set_all_parts_temp_cur( BODYTEMP_NORM );
    u.add_morale( morale_pyromania_nofire, -10, -30, 24_hours, 24_hours, true );

    const auto add_flame = [&here, &pos]( const tripoint & offset, int intensity ) {
        REQUIRE( here.add_field( pos + offset, field_fd_fire.id(), intensity, 0_turns, false ) );
    };
    int expected = 0;
    bool long_decay = false;
    bool thawing = false;
    bool overheating = false;

    SECTION( "hot spring radiation thaws frostbite without supplying a fire thrill" ) {
        for( const tripoint_bub_ms &p : here.points_in_radius( pos, 2 ) ) {
            if( p != pos ) {
                here.ter_set( p, ter_t_water_hot.id() );
            }
        }
        REQUIRE( get_best_fire( pos ) == 1 );
        REQUIRE( units::to_celsius_delta( get_heat_radiation( pos ) ) > 44 );
        u.set_part_frostbite_timer( body_part_hand_l, 100 );
        thawing = true;

        SECTION( "without flames" ) {
            expected = 0;
        }
        SECTION( "with a small flame, only the flame counts for morale" ) {
            add_flame( tripoint::east, 1 );
            expected = 5;
        }
    }
    SECTION( "an overheated clothed character does not mistake radiant terrain for fire" ) {
        REQUIRE( u.wear_item( item( itype_test_zentai ), false ).has_value() );
        u.set_all_parts_temp_cur( BODYTEMP_SCORCHING + 2_C_delta );
        here.ter_set( pos + tripoint::east, ter_t_water_hot.id() );
        REQUIRE( get_best_fire( pos ) == 1 );
        overheating = true;
    }
    SECTION( "strong flames can give the thrill beyond the adjacent tiles" ) {
        // The two nearer flames are not enough; radiation from six tiles away supplies the rest.
        add_flame( tripoint::north * 2, 3 );
        add_flame( tripoint::south * 2, 3 );
        add_flame( tripoint::north * 6, 3 );
        add_flame( tripoint::east * 6, 3 );
        add_flame( tripoint::west * 6, 3 );
        REQUIRE( get_best_fire( pos ) == 0 );
        expected = 10;
        long_decay = true;
    }
    SECTION( "adjacent flames strong enough for the thrill" ) {
        // Two adjacent intensity-3 flames give a legacy thrill score of 5 before armor.
        add_flame( tripoint::east, 3 );
        add_flame( tripoint::west, 3 );
        expected = 10;
        long_decay = true;

        SECTION( "worn-only heat immunity is not the intrinsic morale shield" ) {
            REQUIRE( u.wear_item( item( itype_test_zentai_immune_test_fire ), false ).has_value() );
            REQUIRE( u.is_immune_damage( damage_heat ) );
            REQUIRE_FALSE( u.has_flag( json_flag_HEAT_IMMUNE ) );
        }
        SECTION( "mixed shielding preserves the cap of the last eligible body part" ) {
            REQUIRE( u.wear_item( item( itype_test_protective_clothing ), false ).has_value() );
            REQUIRE( u.get_armor_type( damage_heat, body_part_torso ) >= 5 );
            REQUIRE( u.get_armor_type( damage_heat, body_part_head ) < 5 );
            // Body part iteration follows interned IDs rather than anatomical order.
            for( const bodypart_id &bp : u.get_all_body_parts() ) {
                if( !bp->has_flag( json_flag_IGNORE_TEMP ) ) {
                    expected = u.get_armor_type( damage_heat, bp ) >= 5 ? 5 : 10;
                }
            }
        }
    }

    u.update_bodytemp();
    CHECK( u.has_morale( morale_pyromania_nearfire ) == expected );
    CHECK( u.has_morale( morale_pyromania_nofire ) == ( expected == 0 ? -10 : 0 ) );
    if( thawing ) {
        CHECK( u.get_part_frostbite_timer( body_part_hand_l ) < 5 );
    }
    if( overheating ) {
        CHECK( u.get_part_temp_cur( body_part_torso ) > BODYTEMP_SCORCHING );
    }
    u.morale->decay( 30_minutes );
    CHECK( u.has_morale( morale_pyromania_nearfire ) == ( long_decay ? expected : 0 ) );
    u.morale->decay( 30_minutes );
    CHECK( u.has_morale( morale_pyromania_nearfire ) == 0 );
}
