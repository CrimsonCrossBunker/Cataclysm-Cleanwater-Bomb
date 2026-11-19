#include <algorithm>
#include <list>
#include <sstream>
#include <string>
#include <utility>
#include <vector>

#include "avatar.h"
#include "bionics.h"
#include "bodypart.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "damage.h"
#include "effect.h"
#include "enums.h"
#include "event.h"
#include "event_bus.h"
#include "event_subscriber.h"
#include "fire.h"
#include "game.h"
#include "generic_factory.h"
#include "item.h"
#include "item_location.h"
#include "json.h"
#include "json_loader.h"
#include "lua_platform_content.h"
#include "magic_enchantment.h"
#include "map.h"
#include "map_helpers.h"
#include "material.h"
#include "monster.h"
#include "options_helpers.h"
#include "player_helpers.h"
#include "rng.h"
#include "type_id.h"
#include "weather.h"
#include "weakpoint.h"
#include "wound.h"

static const damage_type_id damage_bash( "bash" );
static const damage_type_id damage_cold( "cold" );
static const damage_type_id damage_heat( "heat" );
static const efftype_id effect_onfire( "onfire" );
static const itype_id itype_test_bird_boots( "test_bird_boots" );
static const itype_id itype_test_protective_clothing( "test_protective_clothing" );
static const itype_id itype_test_winglets( "test_winglets" );
static const itype_id itype_test_zentai_immune_test_fire( "test_zentai_immune_test_fire" );
static const wound_type_id wound_thermal_blister( "thermal_blister" );
static const wound_type_id wound_thermal_burn( "thermal_burn" );

TEST_CASE( "thermal_contact_uses_resolved_damage_at_the_contacted_part",
           "[character][thermal_burn]" )
{
    avatar &u = get_avatar();
    clear_character( u );
    const override_option always_wound( "WOUND_CHANCE", "1" );
    u.set_all_parts_temp_cur( BODYTEMP_NORM );
    u.set_part_temp_cur( body_part_hand_l, BODYTEMP_COLD );
    bodypart &arm = *u.get_part( body_part_arm_l );
    // An existing fire can be extended, but will not deal its first tick as a side effect of the hit.
    u.add_effect( effect_onfire, 1_turns, body_part_hand_l, false, 1, false, true );

    SECTION( "cold hand can burn before it feels hot; HP and wound belong to the arm" ) {
        const int hp = arm.get_hp_cur();
        const units::temperature target = u.get_part_temp_conv( body_part_hand_l );
        const dealt_damage_instance dealt = u.deal_damage( nullptr, body_part_hand_l,
                                            damage_instance( damage_heat, 8 ) );
        REQUIRE( dealt.type_damage( damage_heat ) == 8 );
        CHECK( hp - arm.get_hp_cur() == 8 );
        CHECK( u.get_part_temp_cur( body_part_hand_l ) == BODYTEMP_COLD + 2_C_delta );
        CHECK( u.get_part_temp_cur( body_part_arm_l ) == BODYTEMP_NORM );
        CHECK( u.get_part_temp_conv( body_part_hand_l ) == target );
        REQUIRE( arm.has_wound( wound_thermal_blister ) );
        CHECK_FALSE( u.get_part( body_part_hand_l )->has_wounds() );

        u.update_wounds( 1_minutes );
        u.apply_thermal_burn( body_part_arm_l, false );
        REQUIRE( arm.get_wounds().size() == 1 );
        CHECK( arm.get_wounds().front().get_healing_progress() == 1_minutes );
        u.deal_damage( nullptr, body_part_hand_l, damage_instance( damage_heat, 15 ) );
        REQUIRE( arm.get_wounds().size() == 1 );
        CHECK( arm.has_wound( wound_thermal_burn ) );
        CHECK_FALSE( arm.has_wound( wound_thermal_blister ) );
    }
    SECTION( "cold outweighs heat without cancelling the contact burn" ) {
        damage_instance mixed( damage_cold, 15 );
        mixed.add_damage( damage_heat, 7 );
        u.deal_damage( nullptr, body_part_hand_l, mixed );
        CHECK( u.get_part_temp_cur( body_part_hand_l ) == BODYTEMP_COLD - 2_C_delta );
        CHECK( arm.has_wound( wound_thermal_blister ) );
    }
    SECTION( "mixed heat and cold commit before callbacks even on a broken limb" ) {
        class temperature_observer : public event_subscriber
        {
            public:
                explicit temperature_observer( avatar &u ) : u( u ) {}

                void notify( const cata::event &e ) override {
                    if( e.type() != event_type::character_takes_damage ) {
                        return;
                    }
                    ++hits;
                    CHECK( u.get_part_temp_cur( body_part_hand_l ) == BODYTEMP_COLD - 2_C_delta );
                    CHECK( u.get_part( body_part_arm_l )->has_wound( wound_thermal_blister ) );
                    u.set_part_temp_cur( body_part_hand_l, BODYTEMP_NORM );
                }

                int hits = 0;

            private:
                avatar &u;
        } observer( u );

        u.set_part_hp_cur( body_part_arm_l, 0 );
        REQUIRE_FALSE( u.is_dead_state() );
        get_event_bus().subscribe( &observer );
        damage_instance mixed( damage_cold, 15 );
        mixed.add_damage( damage_heat, 7 );
        mixed.add_damage( damage_bash, 1 );
        const dealt_damage_instance dealt = u.deal_damage( nullptr, body_part_hand_l, mixed );
        REQUIRE( dealt.type_damage( damage_heat ) == 7 );
        REQUIRE( dealt.type_damage( damage_cold ) == 15 );
        CHECK( observer.hits == 1 );
        CHECK( arm.get_hp_cur() == 0 );
        CHECK( u.get_part_temp_cur( body_part_hand_l ) == BODYTEMP_NORM );
    }
    SECTION( "disabling random wounds does not disable temperature impulses" ) {
        const override_option no_wounds( "WOUND_CHANCE", "0" );
        u.deal_damage( nullptr, body_part_hand_l, damage_instance( damage_heat, 30 ) );
        CHECK( u.get_part_temp_cur( body_part_hand_l ) == BODYTEMP_COLD + 5_C_delta );
        CHECK_FALSE( arm.has_wounds() );
    }
    SECTION( "pain immunity suppresses burn pain but not injury or limb penalties" ) {
        const trait_id deadened( "NOPAIN" );
        const limb_score_id manip( "manip" );
        u.set_mutation( deadened );
        REQUIRE( u.has_flag( json_character_flag( "PAIN_IMMUNE" ) ) );
        const int hp = arm.get_hp_cur();
        const float unwounded_score = arm.get_limb_score( u, manip );

        u.deal_damage( nullptr, body_part_hand_l, damage_instance( damage_heat, 15 ) );
        CHECK( hp - arm.get_hp_cur() == 15 );
        REQUIRE( arm.has_wound( wound_thermal_burn ) );
        CHECK( u.get_pain() == 0 );
        CHECK( u.get_perceived_pain() == 0 );
        arm.set_hp_to_max();
        CHECK( arm.get_limb_score( u, manip ) < unwounded_score );

        u.unset_mutation( deadened );
        CHECK( u.get_perceived_pain() > 0 );
    }
    SECTION( "fully absorbed heat leaves neither a wound nor a temperature impulse" ) {
        REQUIRE( u.wear_item( item( itype_test_protective_clothing ), false ).has_value() );
        const int armor = u.get_armor_type( damage_heat, body_part_torso );
        REQUIRE( armor >= 4 );
        const int hp = u.get_hp( body_part_torso );
        const auto dealt = u.deal_damage( nullptr, body_part_torso, damage_instance( damage_heat, 4 ) );
        CHECK( dealt.type_damage( damage_heat ) == 0 );
        CHECK( u.get_hp( body_part_torso ) == hp );
        CHECK( u.get_part_temp_cur( body_part_torso ) == BODYTEMP_NORM );
        CHECK_FALSE( u.get_part( body_part_torso )->has_wounds() );
    }
}

TEST_CASE( "thermal_contact_resolves_replacement_anatomy", "[character][thermal_burn]" )
{
    avatar &u = get_avatar();
    clear_character( u );
    const override_option always_wound( "WOUND_CHANCE", "1" );

    SECTION( "a missing hand alias warms and cools its actual contact without redirecting HP" ) {
        const enchantment_id bird_parts( "ENCH_TEST_BIRD_PARTS" );
        u.enchantment_cache->force_add( *bird_parts, u );
        u.recalculate_bodyparts();
        REQUIRE_FALSE( u.has_part( body_part_hand_l, body_part_filter::strict ) );
        CHECK( u.thermal_wound_part( body_part_hand_l ) == bodypart_str_id::NULL_ID() );
        const bodypart_id contact = u.get_part_id( body_part_hand_l );
        const bodypart_id main = contact->main_part;
        REQUIRE( u.has_part( main, body_part_filter::strict ) );
        REQUIRE( main != body_part_arm_l );
        u.set_all_parts_temp_cur( BODYTEMP_NORM );
        u.add_effect( effect_onfire, 1_turns, contact, false, 1, false, true );
        const int arm_hp = u.get_part_hp_cur( body_part_arm_l );
        const int main_hp = u.get_part_hp_cur( main );

        u.deal_damage( nullptr, body_part_hand_l, damage_instance( damage_heat, 8 ) );
        CHECK( u.get_part_temp_cur( contact ) == BODYTEMP_NORM + 2_C_delta );
        CHECK( u.get_part( main )->has_wound( wound_thermal_blister ) );
        CHECK_FALSE( u.get_part( body_part_arm_l )->has_wounds() );
        CHECK( u.get_part_hp_cur( body_part_arm_l ) == arm_hp - 8 );
        CHECK( u.get_part_hp_cur( main ) == main_hp );

        SECTION( "a subsequent cold hit keeps sending HP damage to the same arm" ) {
            u.deal_damage( nullptr, body_part_hand_l, damage_instance( damage_cold, 8 ) );
            CHECK( u.get_part_temp_cur( contact ) == BODYTEMP_NORM );
            CHECK( u.get_part_hp_cur( body_part_arm_l ) == arm_hp - 16 );
            CHECK( u.get_part_hp_cur( main ) == main_hp );
        }
        SECTION( "losing the HP recipient does not prevent undoing the surviving burn" ) {
            u.save_thermal_wounds( "before_arm_replacement" );
            u.enchantment_cache->force_add( *enchantment_id( "ENCH_TEST_ALT_ARMS" ), u );
            u.recalculate_bodyparts();
            REQUIRE_FALSE( u.has_part( body_part_arm_l ) );
            REQUIRE( u.has_part( body_part_arm_l, body_part_filter::next_best ) );
            REQUIRE( u.has_part( main ) );
            if( GENERATE( false, true ) ) {
                REQUIRE( u.restore_thermal_wounds( "before_arm_replacement" ) );
            }
            REQUIRE( u.get_part( main )->has_wound( wound_thermal_blister ) );
            const auto hit = u.take_recent_damage();
            REQUIRE( hit );
            CHECK( hit->amount == 0 );
            CHECK( hit->pain == 0 );
            CHECK( hit->burn_reverted );
            CHECK_FALSE( u.get_part( main )->has_wound( wound_thermal_blister ) );
        }
    }
    SECTION( "a fresh fire still deals its first tick at an unchanged contact" ) {
        const enchantment_id bird_parts( "ENCH_TEST_BIRD_PARTS" );
        u.enchantment_cache->force_add( *bird_parts, u );
        u.recalculate_bodyparts();
        REQUIRE_FALSE( u.has_part( body_part_hand_l ) );
        const bodypart_id contact = u.get_part_id( body_part_hand_l );
        const bodypart_id main = contact->main_part;
        REQUIRE( u.has_part( main ) );
        REQUIRE( main != body_part_arm_l );

        u.set_part_hp_max( body_part_arm_l, 200 );
        u.set_part_hp_cur( body_part_arm_l, 200 );
        const int main_hp = u.get_part_hp_cur( main );
        REQUIRE( u.deal_damage( nullptr, body_part_hand_l,
                                damage_instance( damage_heat, 150 ) ).type_damage( damage_heat ) == 150 );
        CHECK( u.get_part_hp_cur( body_part_arm_l ) == 50 );
        CHECK( u.get_part_hp_cur( main ) < main_hp );
        CHECK( u.has_effect( effect_onfire, contact ) );
    }
    SECTION( "an actual hand can burn its replacement main part" ) {
        const enchantment_id alt_arms( "ENCH_TEST_ALT_ARMS" );
        const bodypart_id alt_arm( "test_alt_arm_l" );
        u.enchantment_cache->force_add( *alt_arms, u );
        u.recalculate_bodyparts();
        REQUIRE( u.has_part( body_part_hand_l, body_part_filter::strict ) );
        REQUIRE_FALSE( u.has_part( body_part_arm_l, body_part_filter::strict ) );
        REQUIRE( u.has_part( alt_arm, body_part_filter::strict ) );
        CHECK( u.thermal_wound_part( body_part_hand_l ) == alt_arm );
        u.set_all_parts_temp_cur( BODYTEMP_NORM );
        u.add_effect( effect_onfire, 1_turns, body_part_hand_l, false, 1, false, true );
        const int hp = u.get_part_hp_cur( alt_arm );

        u.deal_damage( nullptr, body_part_hand_l, damage_instance( damage_heat, 8 ) );
        CHECK( u.get_part_hp_cur( alt_arm ) == hp - 8 );
        CHECK( u.get_part_temp_cur( body_part_hand_l ) == BODYTEMP_NORM + 2_C_delta );
        CHECK( u.get_part_temp_cur( alt_arm ) == BODYTEMP_NORM );
        CHECK( u.get_part( alt_arm )->has_wound( wound_thermal_blister ) );
        CHECK_FALSE( u.get_part( body_part_hand_l )->has_wounds() );
        const auto hit = u.take_recent_damage();
        REQUIRE( hit );
        CHECK( hit->part == alt_arm.id() );
        CHECK( hit->amount == 8 );
        CHECK( hit->burn_reverted );
        bodypart_str_id &main = const_cast<body_part_type &>( *alt_arm ).main_part;
        const restore_on_out_of_scope restore_main( main );
        SECTION( "follow a remapped main that is itself a minor part" ) {
            main = body_part_torso;
            CHECK( u.thermal_wound_part( body_part_hand_l ) == body_part_torso );
            REQUIRE( u.apply_thermal_burn( body_part_hand_l, false ) );
            CHECK( u.get_part( body_part_torso )->has_wound( wound_thermal_blister ) );
        }
        SECTION( "reject a cycle through the replacement" ) {
            main = body_part_hand_l;
            CHECK( u.thermal_wound_part( body_part_hand_l ) == bodypart_str_id::NULL_ID() );
            CHECK_FALSE( u.apply_thermal_burn( body_part_hand_l, true ) );
        }
        SECTION( "reject a missing main with no equivalent" ) {
            main = bodypart_str_id( "test_bird_wing_l" );
            REQUIRE_FALSE( u.has_part( main, body_part_filter::next_best ) );
            CHECK( u.thermal_wound_part( body_part_hand_l ) == bodypart_str_id::NULL_ID() );
            CHECK_FALSE( u.apply_thermal_burn( body_part_hand_l, true ) );
        }
    }
    SECTION( "a bionic replacement takes HP damage without a temperature impulse or burn" ) {
        const bionic_id leg_cbm( "test_bio_limb_leg_l" );
        const bodypart_id bionic_leg( "test_bionic_basic_leg_l" );
        u.add_bionic( leg_cbm );
        REQUIRE_FALSE( u.has_part( body_part_leg_l, body_part_filter::strict ) );
        REQUIRE( u.has_part( bionic_leg, body_part_filter::strict ) );
        CHECK( u.thermal_wound_part( bionic_leg ) == bodypart_str_id::NULL_ID() );
        u.set_all_parts_temp_cur( BODYTEMP_NORM );
        u.add_effect( effect_onfire, 1_turns, bionic_leg, false, 1, false, true );
        const int hp = u.get_part_hp_cur( bionic_leg );

        u.deal_damage( nullptr, body_part_leg_l, damage_instance( damage_heat, 8 ) );
        CHECK( u.get_part_hp_cur( bionic_leg ) == hp - 8 );
        CHECK( u.get_part_temp_cur( bionic_leg ) == BODYTEMP_NORM );
        CHECK_FALSE( u.get_part( bionic_leg )->has_wounds() );

        // Give the installed CBM cold resistance only on the actual leg.
        auto &protection = const_cast<bionic_data &>( *leg_cbm ).protec;
        const restore_on_out_of_scope restore_protection( protection );
        protection[bionic_leg.id()].set_resist( damage_cold, 5 );
        const dealt_damage_instance dealt = u.deal_damage( nullptr, body_part_leg_l,
                                            damage_instance( damage_cold, 8 ) );
        CHECK( dealt.type_damage( damage_cold ) == 3 );
        CHECK( u.get_part_hp_cur( bionic_leg ) == hp - 11 );
        CHECK( u.get_part_temp_cur( bionic_leg ) == BODYTEMP_NORM );
    }
}

TEST_CASE( "thermal_contact_mitigates_only_thermal_units_on_replacement_parts",
           "[character][thermal_burn]" )
{
    avatar &u = get_avatar();
    clear_character( u );
    const override_option always_wound( "WOUND_CHANCE", "1" );
    const enchantment_id bird_parts( "ENCH_TEST_BIRD_PARTS" );
    u.enchantment_cache->force_add( *bird_parts, u );
    u.recalculate_bodyparts();
    REQUIRE_FALSE( u.has_part( body_part_hand_l, body_part_filter::strict ) );
    const bodypart_id contact = u.get_part_id( body_part_hand_l );
    const bodypart_id main = u.thermal_wound_part( contact );
    REQUIRE( main != bodypart_str_id::NULL_ID() );
    REQUIRE( main != body_part_arm_l );

    // With either kind of bird limb as the contact, its armor covers that limb's
    // subpart, not the missing hand.
    const item armor( contact->primary_limb_type() == bp_type::wing ?
                      itype_test_winglets : itype_test_bird_boots );
    REQUIRE( armor.covers( contact ) );
    REQUIRE_FALSE( armor.covers( body_part_hand_l ) );
    REQUIRE( u.wear_item( armor, false ).has_value() );
    REQUIRE( u.get_armor_type( damage_heat, contact ) > 0 );
    REQUIRE( u.get_armor_type( damage_bash, contact ) > 0 );

    u.set_all_parts_temp_cur( BODYTEMP_NORM );
    // An existing fire can be extended without dealing an immediate first tick.
    u.add_effect( effect_onfire, 1_turns, contact, false, 0, false, true );
    const int main_hp = u.get_part_hp_cur( main );
    SECTION( "mitigation applies only to heat, not bash or the HP target" ) {
        const int arm_hp = u.get_part_hp_cur( body_part_arm_l );
        damage_instance mixed( damage_heat, 4 );
        mixed.add_damage( damage_bash, 4 );
        const dealt_damage_instance dealt = u.deal_damage( nullptr, body_part_hand_l, mixed );
        const int heat = dealt.type_damage( damage_heat );
        CHECK( heat < 4 );
        CHECK( dealt.type_damage( damage_bash ) == 4 );
        CHECK( u.get_part_temp_cur( contact ) == BODYTEMP_NORM + 0.25_C_delta * heat );
        CHECK_FALSE( u.get_part( main )->has_wound( wound_thermal_blister ) );
        CHECK( u.get_part_hp_cur( body_part_arm_l ) == arm_hp - ( 4 + heat ) );
        CHECK( u.get_part_hp_cur( main ) == main_hp );
    }
    SECTION( "heat reuses the replacement's fire key rather than igniting the missing hand" ) {
        u.set_part_hp_max( body_part_arm_l, 200 );
        u.set_part_hp_cur( body_part_arm_l, 200 );
        const dealt_damage_instance dealt = u.deal_damage( nullptr, body_part_hand_l,
                                            damage_instance( damage_heat, 150 ) );
        const int heat = dealt.type_damage( damage_heat );
        REQUIRE( heat > 100 ); // Guarantee the creature-side ignition roll.
        CHECK( u.get_effect_dur( effect_onfire, contact ) > 1_turns );
        CHECK_FALSE( u.has_effect( effect_onfire, body_part_hand_l ) );
        CHECK( u.get_part_hp_cur( body_part_arm_l ) == 200 - heat );
        CHECK( u.get_part_hp_cur( main ) == main_hp );
    }
    SECTION( "burning armor and penetrating heat start only one fire without extra HP damage" ) {
        REQUIRE( u.remove_effect( effect_onfire, contact ) );
        // Guarantee that the armor provides fuel before the penetrating heat ignites.
        mat_burn_data &leather = const_cast<mat_burn_data &>( material_id( "leather" )->burn_data( 2 ) );
        const restore_on_out_of_scope restore_burn_data( leather );
        leather.volume_per_turn = 0_ml;
        leather.fuel = 10.0f;
        fire_data fire( 2 );
        armor.simulate_burn( fire );
        REQUIRE( fire.fuel_produced >= 10.0f );
        SECTION( "an armor ignition callback invalidates later ignition on the old contact" ) {
            const bool recreate_contact = GENERATE( false, true );
            CAPTURE( recreate_contact );
            class ignition_observer : public event_subscriber
            {
                public:
                    ignition_observer( avatar &u, const enchantment &parts, bool recreate ) :
                        u( u ), parts( parts ), recreate( recreate ) {}

                    void notify( const cata::event &e ) override {
                        if( e.type() != event_type::character_gains_effect ||
                            e.get<efftype_id>( "effect" ) != effect_onfire ) {
                            return;
                        }
                        if( ++ignitions != 1 ) {
                            return;
                        }
                        u.clear_effects();
                        u.enchantment_cache->clear();
                        u.recalculate_bodyparts();
                        if( recreate ) {
                            u.enchantment_cache->force_add( parts, u );
                            u.recalculate_bodyparts();
                        }
                        u.set_all_parts_temp_cur( BODYTEMP_NORM );
                    }

                    int ignitions = 0;

                private:
                    avatar &u;
                    const enchantment &parts;
                    bool recreate;
            } observer( u, *bird_parts, recreate_contact );
            get_event_bus().subscribe( &observer );

            u.set_part_hp_max( body_part_arm_l, 400 );
            u.set_part_hp_cur( body_part_arm_l, 400 );
            damage_instance hit( damage_heat, 150 );
            hit.damage_units.emplace_back( damage_heat, 150 );
            const auto dealt = u.deal_damage( nullptr, body_part_hand_l, hit );
            const int heat = dealt.type_damage( damage_heat );
            REQUIRE( heat > 250 ); // Both units would independently ignite through armor.
            CHECK( observer.ignitions == 1 );
            CHECK_FALSE( u.has_effect( effect_onfire ) );
            CHECK( u.get_part_hp_cur( body_part_arm_l ) == 400 - heat );
            const bodypart_id current = u.get_part_id( body_part_hand_l );
            REQUIRE( current == ( recreate_contact ? contact : body_part_hand_l.id() ) );
            CHECK( u.get_part_temp_cur( current ) == BODYTEMP_NORM );
            CHECK_FALSE( u.get_part( u.thermal_wound_part( current ) )->has_wounds() );
        }

        SECTION( "the ignition event takes off the burning layer before it can absorb damage" ) {
            // Produce one burn point whether leather is explicit or inferred from the armor.
            leather.burn = 1.0f / armor.made_of().at( material_id( "leather" ) );
            const item_location inner( u, u.item_worn_with_id( armor.typeId() ) );
            REQUIRE( inner );
            const auto outer = u.wear_item( armor, false );
            REQUIRE( outer );

            class ignition_observer : public event_subscriber
            {
                public:
                    ignition_observer( avatar &u, const item_location &outer ) :
                        u( u ), outer( outer ) {}

                    void notify( const cata::event &e ) override {
                        if( e.type() == event_type::character_gains_effect &&
                            e.get<character_id>( "character" ) == u.getID() &&
                            e.get<efftype_id>( "effect" ) == effect_onfire && ++ignitions == 1 ) {
                            part = e.get<bodypart_id>( "bodypart" );
                            u.takeoff( outer, &removed );
                        }
                    }

                    int ignitions = 0;
                    bodypart_id part;
                    std::list<item> removed;

                private:
                    avatar &u;
                    item_location outer;
            } observer( u, item_location( u, &**outer ) );
            get_event_bus().subscribe( &observer );

            damage_instance hit( damage_heat, 20 );
            damage_unit expected = hit.damage_units.front();
            REQUIRE( contact->sub_parts.size() == 1 );
            armor.mitigate_damage( expected, contact->sub_parts.front().id(), -1 );
            REQUIRE( expected.amount < hit.type_damage( damage_heat ) );
            u.absorb_hit( weakpoint_attack(), body_part_hand_l, hit, weakpoint(), false );

            CHECK( observer.ignitions == 1 );
            CHECK( observer.part == contact );
            REQUIRE( observer.removed.size() == 1 );
            CHECK( observer.removed.front().burnt == 1 );
            CHECK( u.amount_worn( armor.typeId() ) == 1 );
            REQUIRE( inner );
            CHECK( inner->burnt == 0 );
            CHECK( hit.type_damage( damage_heat ) == Approx( expected.amount ) );
        }

        SECTION( "the same contact's fire is extended by penetrating heat" ) {
            u.set_part_hp_max( body_part_arm_l, 200 );
            u.set_part_hp_cur( body_part_arm_l, 200 );
            const dealt_damage_instance dealt = u.deal_damage( nullptr, body_part_hand_l,
                                                damage_instance( damage_heat, 150 ) );
            const int heat = dealt.type_damage( damage_heat );
            REQUIRE( heat > 100 );
            REQUIRE( u.get_effects().size() == 1 );
            CHECK( u.get_effect_dur( effect_onfire, contact ) >= 12_turns );
            CHECK_FALSE( u.has_effect( effect_onfire, body_part_hand_l ) );
            CHECK( u.get_part_hp_cur( body_part_arm_l ) == 200 - heat );
            CHECK( u.get_part_hp_cur( main ) == main_hp );
        }
    }
}

TEST_CASE( "thermal_contact_does_not_retarget_after_a_limb_break", "[character][thermal_burn]" )
{
    avatar &u = get_avatar();
    clear_character( u );
    const override_option always_wound( "WOUND_CHANCE", "1" );
    enum class contact_change { remove, retain, recreate };
    const contact_change change = GENERATE( contact_change::remove, contact_change::retain,
                                            contact_change::recreate );
    CAPTURE( static_cast<int>( change ) );
    const bodypart_id wing( "test_bird_wing_l" );
    enchantment replacement;
    replacement.load( json_loader::from_string( R"({
        "modified_bodyparts": [ { "lose": "hand_l" }, { "gain": "test_bird_wing_l" } ]
    })" ).get_object() );
    u.enchantment_cache->force_add( replacement, u );
    u.recalculate_bodyparts();
    REQUIRE_FALSE( u.has_part( body_part_hand_l ) );
    REQUIRE( u.get_part_id( body_part_hand_l ) == wing );
    REQUIRE( u.wear_item( item( itype_test_winglets ), false ).has_value() );
    const int heat_armor = u.get_armor_type( damage_heat, wing );
    REQUIRE( heat_armor > 0 );
    u.set_all_parts_temp_cur( BODYTEMP_NORM );
    u.add_effect( effect_onfire, 1_turns, wing, false, 1, false, true );
    u.set_part_hp_cur( body_part_arm_l, 1 );
    const int wing_hp = u.get_part_hp_cur( wing );

    class anatomy_changer : public event_subscriber
    {
        public:
            anatomy_changer( avatar &u, contact_change change ) : u( u ), change( change ) {}

            void notify( const cata::event &e ) override {
                if( e.type() != event_type::broken_bone ) {
                    return;
                }
                ++breaks;
                u.enchantment_cache->clear();
                if( change == contact_change::recreate ) {
                    u.recalculate_bodyparts();
                }
                if( change != contact_change::remove ) {
                    enchantment keep;
                    keep.load( json_loader::from_string( R"({
                        "modified_bodyparts": [ { "gain": "test_bird_wing_l" } ]
                    })" ).get_object() );
                    u.enchantment_cache->force_add( keep, u );
                }
                u.recalculate_bodyparts();
                u.set_part_temp_cur( body_part_hand_l, BODYTEMP_NORM );
            }

            int breaks = 0;

        private:
            avatar &u;
            contact_change change;
    } changer( u, change );
    get_event_bus().subscribe( &changer );

    const int raw_heat = 8 + heat_armor;
    damage_instance mixed( damage_heat, raw_heat );
    mixed.add_damage( damage_bash, 4 );
    const auto dealt = u.deal_damage( nullptr, body_part_hand_l, mixed );
    const int heat = dealt.type_damage( damage_heat );
    REQUIRE( heat >= 4 );
    CHECK( heat < raw_heat );
    CHECK( dealt.type_damage( damage_bash ) == 4 );
    CHECK( changer.breaks == 1 );
    CHECK( u.get_part_hp_cur( body_part_arm_l ) == 0 );
    REQUIRE( u.has_part( body_part_hand_l ) );
    CHECK( u.get_part_temp_cur( body_part_hand_l ) == BODYTEMP_NORM );
    CHECK_FALSE( u.get_part( body_part_arm_l )->has_wound( wound_thermal_blister ) );
    CHECK_FALSE( u.get_part( body_part_arm_l )->has_wound( wound_thermal_burn ) );
    CHECK( u.has_part( wing ) == ( change != contact_change::remove ) );
    if( change != contact_change::remove ) {
        const bool survived = change == contact_change::retain;
        CHECK( u.get_part_hp_cur( wing ) == wing_hp );
        CHECK( u.get_part_temp_cur( wing ) == BODYTEMP_NORM +
               0.25_C_delta * ( survived ? heat : 0 ) );
        CHECK( u.get_part( wing )->has_wound( wound_thermal_blister ) == survived );
        CHECK_FALSE( u.get_part( wing )->has_wound( wound_thermal_burn ) );
    }
}

TEST_CASE( "thermal_contact_tracks_the_final_wound_site_across_anatomy_changes",
           "[character][thermal_burn]" )
{
    avatar &u = get_avatar();
    clear_character( u );
    const bodypart_id wing( "test_bird_wing_l" );
    const bodypart_id alt_wing( "test_partial_wing_l" );
    bodypart_str_id &arm_main = const_cast<body_part_type &>( *body_part_arm_l ).main_part;
    const restore_on_out_of_scope restore_main( arm_main );
    arm_main = wing.id();

    enchantment add_wing;
    add_wing.load( json_loader::from_string( R"({
        "modified_bodyparts": [ { "gain": "test_bird_wing_l" } ]
    })" ).get_object() );
    enchantment add_alt_wing;
    add_alt_wing.load( json_loader::from_string( R"({
        "modified_bodyparts": [ { "gain": "test_partial_wing_l" } ]
    })" ).get_object() );
    u.enchantment_cache->force_add( add_wing, u );
    u.recalculate_bodyparts();
    REQUIRE( u.thermal_wound_part( body_part_hand_l ) == wing );

    SECTION( "the original contact still warms, but a changed main gets no burn" ) {
        const bool recreate_main = GENERATE( false, true );
        CAPTURE( recreate_main );
        const override_option always_wound( "WOUND_CHANCE", "1" );
        u.set_all_parts_temp_cur( BODYTEMP_NORM );
        u.add_effect( effect_onfire, 1_turns, body_part_hand_l, false, 1, false, true );
        u.set_part_hp_cur( body_part_arm_l, 1 );

        class anatomy_changer : public event_subscriber
        {
            public:
                anatomy_changer( avatar &u, const enchantment &replacement ) :
                    u( u ), replacement( replacement ) {}

                void notify( const cata::event &e ) override {
                    if( e.type() != event_type::broken_bone ) {
                        return;
                    }
                    u.enchantment_cache->clear();
                    u.recalculate_bodyparts();
                    u.enchantment_cache->force_add( replacement, u );
                    u.recalculate_bodyparts();
                }

            private:
                avatar &u;
                const enchantment &replacement;
        } changer( u, recreate_main ? add_wing : add_alt_wing );
        get_event_bus().subscribe( &changer );

        const auto dealt = u.deal_damage( nullptr, body_part_hand_l, damage_instance( damage_heat, 8 ) );
        REQUIRE( dealt.type_damage( damage_heat ) == 8 );
        CHECK( u.get_part_hp_cur( body_part_arm_l ) == 0 );
        CHECK( u.get_part_temp_cur( body_part_hand_l ) == BODYTEMP_NORM + 2_C_delta );
        const bodypart_id current_main = recreate_main ? wing : alt_wing;
        REQUIRE( u.thermal_wound_part( body_part_hand_l ) == current_main );
        CHECK_FALSE( u.get_part( current_main )->has_wounds() );
    }
    SECTION( "dose is kept only while the final wound site is unchanged" ) {
        bodypart &hand = *u.get_part( body_part_hand_l );
        hand.update_heat_exposure( 1 );
        REQUIRE( hand.has_heat_exposure() );

        u.enchantment_cache->force_add( add_alt_wing, u );
        u.recalculate_bodyparts();
        REQUIRE( u.thermal_wound_part( body_part_hand_l ) == wing );
        CHECK( hand.has_heat_exposure() );

        u.enchantment_cache->clear();
        u.enchantment_cache->force_add( add_alt_wing, u );
        u.recalculate_bodyparts();
        REQUIRE( u.thermal_wound_part( body_part_hand_l ) == alt_wing );
        CHECK_FALSE( hand.has_heat_exposure() );
    }
}

TEST_CASE( "recent_damage_records_only_adjusted_direct_hit_pain", "[character][thermal_burn]" )
{
    struct pain_callback_avatar : avatar {
        bool nest_hit = false;

        void on_stat_change( const std::string &stat, int value ) override {
            avatar::on_stat_change( stat, value );
            if( stat != "pain" || !nest_hit ) {
                return;
            }
            nest_hit = false;
            deal_damage( nullptr, body_part_torso, damage_instance( damage_bash, 40 ) );
            const auto nested = take_recent_damage();
            REQUIRE( nested );
            CHECK( nested->part == body_part_torso );
            CHECK( nested->pain == 6 );
            mod_pain_noresist( 7 );
        }
    } u;
    clear_character( u );
    const override_option no_wounds( "WOUND_CHANCE", "0" );
    u.set_sensitive( 50 ); // 75% of the raw pain.
    u.set_pain( 9 );
    int hit_pain = 3;
    int extra_pain = 0;
    SECTION( "resisted pain is recorded, not the nominal pain" ) {
    }
    SECTION( "pain immunity records no pain" ) {
        u.set_mutation( trait_id( "NOPAIN" ) );
        REQUIRE( u.has_flag( json_character_flag( "PAIN_IMMUNE" ) ) );
        hit_pain = 0;
    }
    SECTION( "pain callbacks can deal other hits and change pain" ) {
        u.nest_hit = true;
        extra_pain = 6 + 7;
    }

    struct damage_observer : event_subscriber {
        int hits = 0;

        void notify( const cata::event &e ) override {
            if( e.type() == event_type::character_takes_damage ) {
                ++hits;
                CHECK( e.get<int>( "pain" ) == 0 );
            }
        }
    } observer;
    get_event_bus().subscribe( &observer );
    const auto dealt = u.deal_damage( nullptr, body_part_arm_l, damage_instance( damage_bash, 20 ) );
    REQUIRE( dealt.type_damage( damage_bash ) == 20 );
    CHECK( observer.hits == ( extra_pain == 0 ? 1 : 2 ) );
    CHECK( u.Creature::get_pain() == 9 + hit_pain + extra_pain );
    const auto recent = u.take_recent_damage();
    REQUIRE( recent );
    CHECK( recent->part == body_part_arm_l );
    CHECK( recent->amount == 20 );
    CHECK( recent->pain == hit_pain );
}

TEST_CASE( "incendiary_field_refreshes_fire_on_the_actual_torso", "[character][thermal_burn]" )
{
    clear_map();
    avatar &u = get_avatar();
    clear_character( u );
    enchantment replacement;
    replacement.load( json_loader::from_string( R"({
        "modified_bodyparts": [ { "lose": "torso" }, { "gain": "torso_slime" } ]
    })" ).get_object() );
    const bodypart_id actual_torso( "torso_slime" );
    u.enchantment_cache->force_add( replacement, u );
    u.recalculate_bodyparts();
    REQUIRE_FALSE( u.has_part( body_part_torso ) );
    REQUIRE( u.get_part_id( body_part_torso ) == actual_torso );
    u.add_effect( effect_onfire, 5_turns, actual_torso, false, 0, false, true );
    const int hp_before = u.get_part_hp_cur( actual_torso );
    const int arm_hp_before = u.get_part_hp_cur( body_part_arm_l );

    map &here = get_map();
    const tripoint_bub_ms pos = u.pos_bub();
    const field_type_id incendiary( "fd_incendiary" );
    REQUIRE( here.add_field( pos, incendiary, 2, 0_turns, false ) );
    const on_out_of_scope remove_field( [&]() {
        here.remove_field( pos, incendiary );
    } );
    here.creature_in_field( u );

    REQUIRE( u.get_effects().size() == 1 );
    CHECK_FALSE( u.has_effect( effect_onfire, body_part_torso ) );
    CHECK( u.get_effect( effect_onfire, body_part_torso ).is_null() );
    CHECK( u.get_effect( effect_onfire ).is_null() ); // A null query targets only untargeted fire.
    CHECK( u.get_effect( effect_onfire, actual_torso ).get_bp() == actual_torso );
    CHECK( u.get_effect_dur( effect_onfire, actual_torso ) == 13_turns );
    // The untyped field damage is still applied equally, without a second ignition hit.
    const int lost_hp = hp_before - u.get_part_hp_cur( actual_torso );
    CHECK( lost_hp >= 2 );
    CHECK( lost_hp <= 6 );
    CHECK( lost_hp == arm_hp_before - u.get_part_hp_cur( body_part_arm_l ) );
    CHECK_FALSE( u.remove_effect( effect_onfire, body_part_torso ) );
    CHECK( u.remove_effect( effect_onfire, actual_torso ) );
    CHECK_FALSE( u.has_effect( effect_onfire ) );
}

TEST_CASE( "onfire_follows_character_anatomy_without_reapplying_damage",
           "[character][thermal_burn]" )
{
    avatar &u = get_avatar();
    clear_character( u );
    const enchantment_id alt_arms( "ENCH_TEST_ALT_ARMS" );
    const bodypart_id alt_arm( "test_alt_arm_l" );
    u.add_effect( effect_onfire, 12_turns, body_part_arm_l, false, 0, false, true );
    u.add_effect( effect_onfire, 4_turns, body_part_hand_l, false, 0, false, true );
    u.enchantment_cache->force_add( *alt_arms, u );
    u.recalculate_bodyparts();

    REQUIRE_FALSE( u.has_part( body_part_arm_l ) );
    REQUIRE( u.has_part( alt_arm ) );
    CHECK_FALSE( u.has_effect( effect_onfire, body_part_arm_l ) );
    CHECK( u.get_effect( effect_onfire, alt_arm ).get_bp() == alt_arm );
    CHECK( u.get_effect_dur( effect_onfire, alt_arm ) == 12_turns );
    CHECK( u.get_part_hp_cur( alt_arm ) == u.get_part_hp_max( alt_arm ) );
    CHECK( u.get_effect_dur( effect_onfire, body_part_hand_l ) == 4_turns );

    u.enchantment_cache->clear();
    u.recalculate_bodyparts();
    REQUIRE_FALSE( u.has_part( alt_arm ) );
    CHECK_FALSE( u.has_effect( effect_onfire, alt_arm ) );
    CHECK( u.get_effect( effect_onfire, body_part_arm_l ).get_bp() == body_part_arm_l );
    CHECK( u.get_effect_dur( effect_onfire, body_part_arm_l ) == 12_turns );
    CHECK( u.get_part_hp_cur( body_part_arm_l ) == u.get_part_hp_max( body_part_arm_l ) );
    CHECK( u.get_effect_dur( effect_onfire, body_part_hand_l ) == 4_turns );
    CHECK( u.remove_effect( effect_onfire, body_part_arm_l ) );
    CHECK( u.has_effect( effect_onfire, body_part_hand_l ) );
    CHECK( u.remove_effect( effect_onfire ) );
    CHECK_FALSE( u.has_effect( effect_onfire ) );

    // A removed part with no equivalent must not strand a targeted or untargeted fire.
    const bodypart_id wing( "test_bird_wing_l" );
    u.enchantment_cache->force_add( *enchantment_id( "ENCH_TEST_BIRD_PARTS" ), u );
    u.recalculate_bodyparts();
    REQUIRE( u.has_part( wing ) );
    u.add_effect( effect_onfire, 4_turns, wing, false, 0, false, true );
    REQUIRE( u.has_effect( effect_onfire, wing ) );
    u.enchantment_cache->clear();
    u.recalculate_bodyparts();
    REQUIRE_FALSE( u.has_part( wing, body_part_filter::next_best ) );
    CHECK_FALSE( u.has_effect( effect_onfire ) );
}

TEST_CASE( "onfire_rekeys_after_base_decay_and_removal_callbacks",
           "[character][thermal_burn]" )
{
    struct changing_avatar : avatar {
        int change_at_intensity = -1;
        void on_effect_int_change( const efftype_id &id, int intensity,
                                   const bodypart_id &bp ) override {
            avatar::on_effect_int_change( id, intensity, bp );
            if( id == effect_onfire && intensity == change_at_intensity ) {
                change_at_intensity = -1;
                enchantment_cache->force_add( *enchantment_id( "ENCH_TEST_ALT_ARMS" ), *this );
                recalculate_bodyparts();
                const bodypart_id pending = intensity == 0 && bp == body_part_arm_r ?
                                            body_part_arm_l : body_part_arm_r;
                REQUIRE( has_effect( effect_onfire, pending ) );
            }
        }
    } u;
    u.set_body();
    u.add_effect( effect_onfire, 0_turns, body_part_arm_l, false, 1, false, true );
    u.add_effect( effect_onfire, 10_turns, body_part_hand_l, false, 1, false, true );
    const bodypart_id alt_arm_l( "test_alt_arm_l" );
    const bodypart_id alt_arm_r( "test_alt_arm_r" );

    SECTION( "an intensity change during decay keeps the pending expiry key stable" ) {
        u.add_effect( effect_onfire, 6_turns, body_part_arm_r, false, 1, false, true );
        REQUIRE( u.get_effect_int( effect_onfire, body_part_arm_r ) == 2 );
        u.change_at_intensity = 1;
        u.Creature::process_effects();
        CHECK( u.get_effect_dur( effect_onfire, alt_arm_r ) == 5_turns );
        CHECK( u.get_effect_int( effect_onfire, alt_arm_r ) == 1 );
    }
    SECTION( "an expiry callback cannot rekey the next queued expiry" ) {
        u.add_effect( effect_onfire, 0_turns, body_part_arm_r, false, 1, false, true );
        u.change_at_intensity = 0;
        u.Creature::process_effects();
        CHECK_FALSE( u.has_effect( effect_onfire, alt_arm_r ) );
    }
    CHECK( u.change_at_intensity == -1 );
    CHECK( u.has_part( alt_arm_l ) );
    CHECK_FALSE( u.has_effect( effect_onfire, alt_arm_l ) );
    CHECK_FALSE( u.has_effect( effect_onfire, body_part_arm_l ) );
    CHECK_FALSE( u.has_effect( effect_onfire, body_part_arm_r ) );
    CHECK( u.get_effect_dur( effect_onfire, body_part_hand_l ) == 9_turns );
}

TEST_CASE( "queued_onfire_expiration_ignores_refreshed_or_replaced_records",
           "[character][thermal_burn]" )
{
    avatar u;
    u.setID( character_id( 941803 ), true );
    u.set_body();
    const bodypart_id first = body_part_arm_l.id();
    const bodypart_id second = body_part_arm_r.id();
    REQUIRE( first < second );
    for( bodypart_id part : { first, second } ) {
        u.add_effect( effect_onfire, 0_turns, part, false, 1, false, true );
        REQUIRE( u.has_effect( effect_onfire, part ) );
    }

    const bool replace = GENERATE( false, true );
    struct expiry_observer : event_subscriber {
        avatar &who;
        bodypart_id first;
        bodypart_id second;
        bool replace;
        int losses = 0;

        expiry_observer( avatar &who, bodypart_id first, bodypart_id second, bool replace ) :
            who( who ), first( first ), second( second ), replace( replace ) {}

        using event_subscriber::notify;
        void notify( const cata::event &event ) override {
            if( event.type() != event_type::character_loses_effect ||
                event.get<character_id>( "character" ) != who.getID() ||
                event.get<efftype_id>( "effect" ) != effect_onfire ) {
                return;
            }
            if( ++losses == 1 ) {
                REQUIRE( event.get<bodypart_id>( "bodypart" ) == first );
                // Native subscribers can still see the record, but its loss is committed.
                who.get_effect( effect_onfire, first ).set_duration( 15_turns );
                if( replace ) {
                    // Even an already-expired replacement was not queued by this pass.
                    REQUIRE( who.remove_effect( effect_onfire, second ) );
                    who.add_effect( effect_onfire, 0_turns, second, false, 1, false, true );
                } else {
                    who.add_effect( effect_onfire, 12_turns, second, false, 1, false, true );
                }
            }
        }
    } observer( u, first, second, replace );
    get_event_bus().subscribe( &observer );

    u.Creature::process_effects();
    CHECK_FALSE( u.has_effect( effect_onfire, first ) );
    REQUIRE( u.has_effect( effect_onfire, second ) );
    CHECK( u.get_effect_dur( effect_onfire, second ) == ( replace ? 0_turns : 12_turns ) );
    CHECK( observer.losses == ( replace ? 2 : 1 ) );
}

TEST_CASE( "onfire_loss_callback_can_reapply_an_erased_key", "[character][thermal_burn]" )
{
    avatar u;
    u.setID( character_id( 941804 ), true );
    u.set_body();
    const bodypart_id part = body_part_arm_l.id();
    u.add_effect( effect_onfire, 12_turns, part, false, 1, false, true );

    struct loss_observer : event_subscriber {
        avatar &who;
        bodypart_id part;
        int losses = 0;

        loss_observer( avatar &who, bodypart_id part ) : who( who ), part( part ) {}

        using event_subscriber::notify;
        void notify( const cata::event &event ) override {
            if( event.type() != event_type::character_loses_effect ||
                event.get<character_id>( "character" ) != who.getID() ||
                event.get<efftype_id>( "effect" ) != effect_onfire ) {
                return;
            }
            ++losses;
            who.clear_effects();
            who.add_effect( effect_onfire, 7_turns, part, false, 1, false, true );
        }
    } observer( u, part );
    get_event_bus().subscribe( &observer );

    SECTION( "remove one part" ) {
        CHECK( u.remove_effect( effect_onfire, part ) );
    }
    SECTION( "remove all parts" ) {
        CHECK( u.remove_effect( effect_onfire ) );
    }
    CHECK( observer.losses == 1 );
    CHECK( u.get_effect_dur( effect_onfire, part ) == 7_turns );
}

TEST_CASE( "onfire_survives_anatomy_or_record_removal_in_its_death_event",
           "[character][thermal_burn]" )
{
    // Model a mod that gives burning a guaranteed death event.
    struct lethal_fire_type : effect_type {
        lethal_fire_type() : effect_type( effect_onfire.obj() ) {
            kill_chance = { { 1, 1 } };
            death_event = event_type::dies_of_infection;
        }
    } lethal_fire;
    struct death_test_avatar : avatar {
        bool died = false;
        void die( map *, Creature * ) override {
            died = true;
        }
    } u;
    u.setID( character_id( 941801 ), true );
    u.enchantment_cache->force_add( *enchantment_id( "ENCH_TEST_BIRD_PARTS" ), u );
    u.recalculate_bodyparts();
    const bodypart_id wing( "test_bird_wing_l" );
    REQUIRE( u.has_part( wing ) );
    u.restore_effects_snapshot( { effect( effect_source::empty(), &lethal_fire, 10_turns,
                                          wing.id(), false, 1, calendar::turn ) } );
    const bool erase_during_event = GENERATE( false, true );

    struct death_observer : event_subscriber {
        avatar &actor;
        const bodypart_id part;
        bool erase_during_event;
        death_observer( avatar &actor, bodypart_id part, bool erase_during_event ) :
            actor( actor ), part( part ), erase_during_event( erase_during_event ) {}
        using event_subscriber::notify;
        void notify( const cata::event &event ) override {
            if( event.type() == event_type::dies_of_infection &&
                event.get<character_id>( "character" ) == actor.getID() ) {
                actor.enchantment_cache->clear();
                actor.recalculate_bodyparts();
                REQUIRE_FALSE( actor.has_part( part, body_part_filter::next_best ) );
                REQUIRE( actor.has_effect( effect_onfire, part ) );
                if( erase_during_event ) {
                    actor.clear_effects();
                }
            }
        }
    } observer( u, wing, erase_during_event );
    get_event_bus().subscribe( &observer );
    u.Creature::process_effects();
    CHECK( u.died );
    CHECK_FALSE( u.has_effect( effect_onfire ) );
}

TEST_CASE( "onfire_ticks_each_of_five_distinct_parts", "[character][thermal_burn]" )
{
    struct burning_avatar : avatar {
        std::vector<bodypart_id> hits;
        dealt_damage_instance deal_damage( Creature *, bodypart_id bp, const damage_instance &,
                                           const weakpoint_attack &, const weakpoint & ) override {
            hits.push_back( bp );
            return dealt_damage_instance();
        }
    } u;
    u.set_body();
    u.set_pos_abs_only( get_avatar().pos_abs() );
    const std::vector<bodypart_id> parts = {
        body_part_head, body_part_arm_l, body_part_arm_r, body_part_leg_l, body_part_leg_r
    };
    for( const bodypart_id &bp : parts ) {
        u.add_effect( effect_onfire, 10_turns, bp, false, 1, false, true );
    }
    u.process_effects();
    CHECK( std::is_permutation( parts.begin(), parts.end(), u.hits.begin(), u.hits.end() ) );
}

TEST_CASE( "onfire_tick_survives_replacement_of_the_effect_group", "[character][thermal_burn]" )
{
    struct burning_avatar : avatar {
        std::vector<bodypart_id> hits;

        dealt_damage_instance deal_damage( Creature *, bodypart_id part, const damage_instance &,
                                           const weakpoint_attack &, const weakpoint & ) override {
            hits.push_back( part );
            if( hits.size() == 1 ) {
                clear_effects();
                add_effect( effect_onfire, 20_turns, body_part_arm_r, false, 1, false, true );
            }
            return dealt_damage_instance();
        }
    } u;
    u.set_body();
    u.set_pos_abs_only( get_avatar().pos_abs() );
    REQUIRE( body_part_arm_l.id() < body_part_arm_r.id() );
    u.add_effect( effect_onfire, 10_turns, body_part_arm_l, false, 1, false, true );
    u.add_effect( effect_onfire, 10_turns, body_part_arm_r, false, 1, false, true );

    u.process_effects();
    REQUIRE( u.hits.size() == 1 );
    CHECK( u.hits.front() == body_part_arm_l );
    CHECK_FALSE( u.has_effect( effect_onfire, body_part_arm_l ) );
    CHECK( u.get_effect_dur( effect_onfire, body_part_arm_r ) == 19_turns );

    u.process_effects();
    REQUIRE( u.hits.size() == 2 );
    CHECK( u.hits.back() == body_part_arm_r );
}

TEST_CASE( "onfire_ticks_only_once_when_live_fire_keys_converge",
           "[character][thermal_burn]" )
{
    struct changing_avatar : avatar {
        int heat_ticks = 0;
        dealt_damage_instance deal_damage( Creature *, bodypart_id, const damage_instance &,
                                           const weakpoint_attack &, const weakpoint & ) override {
            if( ++heat_ticks == 1 ) {
                enchantment_cache->force_add( *enchantment_id( "ENCH_TEST_ALT_ARMS" ), *this );
                recalculate_bodyparts();
            }
            return dealt_damage_instance();
        }
    } u;
    u.set_pos_abs_only( get_avatar().pos_abs() );
    enchantment extra_arm;
    extra_arm.load( json_loader::from_string( R"({
        "modified_bodyparts": [ { "gain": "test_alt_arm_l" } ]
    })" ).get_object() );
    u.enchantment_cache->force_add( extra_arm, u );
    u.recalculate_bodyparts();
    const bodypart_id alt_arm( "test_alt_arm_l" );
    REQUIRE( u.has_part( body_part_arm_l ) );
    REQUIRE( u.has_part( alt_arm ) );
    u.add_effect( effect_onfire, 12_turns, body_part_arm_l, false, 1, false, true );
    u.add_effect( effect_onfire, 4_turns, alt_arm, false, 1, false, true );

    u.process_effects();
    CHECK( u.heat_ticks == 1 );
    CHECK_FALSE( u.has_part( body_part_arm_l ) );
    CHECK_FALSE( u.has_effect( effect_onfire, body_part_arm_l ) );
    CHECK( u.get_effect_dur( effect_onfire, alt_arm ) == 11_turns );
}

TEST_CASE( "onfire_ticks_the_strongest_live_record_when_unticked_keys_converge",
           "[character][thermal_burn]" )
{
    struct fixed_intensity_fire : effect_type {
        fixed_intensity_fire() : effect_type( effect_onfire.obj() ) {
            int_dur_factor = 0_turns;
        }
    } fire_type;
    struct changing_avatar : avatar {
        const enchantment *lose_arm = nullptr;
        bool break_arm = false;
        std::vector<std::pair<bodypart_id, int>> hits;

        dealt_damage_instance deal_damage( Creature *, bodypart_id bp, const damage_instance &damage,
                                           const weakpoint_attack &, const weakpoint & ) override {
            REQUIRE( damage.damage_units.size() == 1 );
            const int heat = static_cast<int>( damage.damage_units.front().amount );
            hits.emplace_back( bp, heat );
            if( hits.size() == 1 ) {
                enchantment_cache->force_add( *lose_arm, *this );
                recalculate_bodyparts();
            } else if( hits.size() == 2 && break_arm ) {
                mod_part_hp_cur( bp, -std::min( heat, get_part_hp_cur( bp ) ) );
            }
            return dealt_damage_instance();
        }
    } u;

    const bodypart_id trigger = body_part_arm_l.id();
    const bodypart_id alias = body_part_arm_r.id();
    const bodypart_id actual( "test_alt_arm_r" );
    REQUIRE( trigger < alias );
    REQUIRE( alias < actual );
    enchantment gain_arm;
    gain_arm.load( json_loader::from_string( R"({
        "modified_bodyparts": [ { "gain": "test_alt_arm_r" } ]
    })" ).get_object() );
    enchantment lose_arm;
    lose_arm.load( json_loader::from_string( R"({
        "modified_bodyparts": [ { "lose": "arm_r" } ]
    })" ).get_object() );
    u.lose_arm = &lose_arm;
    u.setID( character_id( 941802 ), true );
    u.set_pos_abs_only( get_avatar().pos_abs() );
    u.enchantment_cache->force_add( gain_arm, u );
    u.recalculate_bodyparts();
    REQUIRE( u.has_part( alias ) );
    REQUIRE( u.has_part( actual ) );

    const auto add_fires = [&]( time_duration weak_duration, time_duration strong_duration,
                                bool permanent ) {
        u.restore_effects_snapshot( {
            effect( effect_source::empty(), &fire_type, 10_turns, trigger.id(), false, 1, time_point( 10 ) ),
            effect( effect_source::empty(), &fire_type, weak_duration, alias.id(), false, 1,
                    time_point( 20 ) ),
            effect( effect_source::empty(), &fire_type, strong_duration, actual.id(), permanent, 3,
                    time_point( 30 ) )
        } );
    };

    SECTION( "the strongest record supplies the tick and survives normalization" ) {
        const bool permanent = GENERATE( false, true );
        const time_duration duration = permanent ? 4_turns : 20_turns;
        add_fires( 12_turns, duration, permanent );

        u.process_effects();

        REQUIRE( u.hits.size() == 2 );
        CHECK( u.hits[0].first == trigger );
        CHECK( u.hits[1].first == actual );
        CHECK( u.hits[1].second >= 3 ); // The weaker record can only deal 1 or 2.
        CHECK_FALSE( u.has_effect( effect_onfire, alias ) );
        const effect &remaining = u.get_effect( effect_onfire, actual );
        REQUIRE_FALSE( remaining.is_null() );
        CHECK( remaining.get_duration() == duration - ( permanent ? 0_turns : 1_turns ) );
        CHECK( remaining.get_start_time() == time_point( 30 ) );
    }

    SECTION( "a break expires the winner and all aliases even if anatomy changes again" ) {
        enum class anatomy_after_break { unchanged, replace, split };
        const anatomy_after_break change = GENERATE( anatomy_after_break::unchanged,
                                           anatomy_after_break::replace, anatomy_after_break::split );
        struct break_observer : event_subscriber {
            using event_subscriber::notify;
            avatar &who;
            const enchantment &gain_arm;
            const bodypart_id limb;
            const anatomy_after_break change;
            int breaks = 0;

            break_observer( avatar &who, const enchantment &gain_arm, bodypart_id limb,
                            anatomy_after_break change ) :
                who( who ), gain_arm( gain_arm ), limb( limb ), change( change ) {}

            void notify( const cata::event &event ) override {
                if( event.type() != event_type::broken_bone ||
                    event.get<character_id>( "character" ) != who.getID() ) {
                    return;
                }
                CHECK( event.get<bodypart_id>( "part" ) == limb );
                ++breaks;
                if( change != anatomy_after_break::unchanged ) {
                    who.enchantment_cache->clear();
                    who.recalculate_bodyparts();
                    CHECK_FALSE( who.has_part( limb ) );
                    if( change == anatomy_after_break::split ) {
                        who.enchantment_cache->force_add( gain_arm, who );
                        who.recalculate_bodyparts();
                    }
                }
            }
        } observer( u, gain_arm, actual, change );
        get_event_bus().subscribe( &observer );
        u.break_arm = true;
        u.set_part_hp_cur( actual, 1 );
        add_fires( 12_turns, 20_turns, false );

        u.process_effects();

        REQUIRE( u.hits.size() == 2 );
        CHECK( u.hits[1].first == actual );
        CHECK( u.hits[1].second >= 3 );
        CHECK( observer.breaks == 1 );
        CHECK_FALSE( u.has_effect( effect_onfire, alias ) );
        CHECK_FALSE( u.has_effect( effect_onfire, actual ) );
        REQUIRE( u.get_effects().size() == 1 );
        CHECK( u.has_effect( effect_onfire, trigger ) );

        u.process_effects();
        REQUIRE( u.hits.size() == 3 );
        CHECK( u.hits.back().first == trigger );
    }
    SECTION( "a break callback removes and replaces a key before stale cleanup runs" ) {
        const bool replace_winner = GENERATE( false, true );
        const bodypart_id replacement = replace_winner ? actual : alias;
        struct break_reapply : event_subscriber {
            using event_subscriber::notify;
            avatar &who;
            const enchantment &gain_arm;
            bodypart_id replacement;
            int breaks = 0;

            break_reapply( avatar &who, const enchantment &gain_arm, bodypart_id replacement ) :
                who( who ), gain_arm( gain_arm ), replacement( replacement ) {}

            void notify( const cata::event &event ) override {
                if( event.type() != event_type::broken_bone ||
                    event.get<character_id>( "character" ) != who.getID() ) {
                    return;
                }
                ++breaks;
                // Restore the original arm so each key is independently targetable.
                who.enchantment_cache->clear();
                who.enchantment_cache->force_add( gain_arm, who );
                who.recalculate_bodyparts();
                REQUIRE( who.has_part( replacement ) );
                REQUIRE( who.remove_effect( effect_onfire, replacement ) );
                who.add_effect( effect_onfire, 25_turns, replacement, false, 1, false, true );
            }
        } observer( u, gain_arm, replacement );
        get_event_bus().subscribe( &observer );
        u.break_arm = true;
        u.set_part_hp_cur( actual, 1 );
        add_fires( 12_turns, 20_turns, false );

        u.process_effects();

        REQUIRE( u.hits.size() == 2 );
        CHECK( u.hits.back().first == actual );
        CHECK( observer.breaks == 1 );
        CHECK( u.get_effect_dur( effect_onfire, replacement ) == 24_turns );
        CHECK_FALSE( u.has_effect( effect_onfire, replace_winner ? alias : actual ) );
    }
}

TEST_CASE( "saved_onfire_aliases_merge_without_extending_or_ticking_fire",
           "[character][thermal_burn][save]" )
{
    struct save_test_avatar : avatar {
        using Creature::load;
    };
    save_test_avatar u;
    u.enchantment_cache->force_add( *enchantment_id( "ENCH_TEST_ALT_ARMS" ), u );
    u.recalculate_bodyparts();
    const bodypart_id alt_arm( "test_alt_arm_l" );
    REQUIRE( u.has_part( alt_arm ) );
    const int hp_before = u.get_part_hp_cur( alt_arm );
    const std::string effects = R"("effects":{"onfire":{
        "arm_l":{"eff_type":"onfire","bp":"arm_l","duration":20,"intensity":3,"start_turn":42},
        "test_alt_arm_l":{"eff_type":"onfire","bp":"test_alt_arm_l","duration":10,"intensity":2},
        "bp_null":{"eff_type":"onfire","bp":"bp_null","duration":4,"intensity":1}
    }})";

    SECTION( "save" ) {
        const restore_on_out_of_scope restore_version( savegame_loading_version );
        savegame_loading_version = savegame_version;
        u.load( json_loader::from_string( "{" + effects + "}" ).get_object() );
    }
    SECTION( "turn and player snapshots" ) {
        const bool full_snapshot = GENERATE( false, true );
        const auto store = full_snapshot ? &Character::store_player_state :
                           &Character::store_turn_state;
        const auto load = full_snapshot ? &Character::load_player_state : &Character::load_turn_state;
        std::ostringstream text;
        JsonOut out( text );
        ( u.*store )( out );
        std::string snapshot = text.str();
        const std::string empty_effects = "\"effects\":{}";
        const size_t pos = snapshot.find( empty_effects );
        REQUIRE( pos != std::string::npos );
        snapshot.replace( pos, empty_effects.size(), effects );
        ( u.*load )( json_loader::from_string( snapshot ).get_object() );
    }

    REQUIRE( u.get_effects().size() == 2 );
    CHECK_FALSE( u.has_effect( effect_onfire, body_part_arm_l ) );
    const effect &fire = u.get_effect( effect_onfire, alt_arm );
    REQUIRE_FALSE( fire.is_null() );
    CHECK( fire.get_bp() == alt_arm );
    CHECK( fire.get_duration() == 20_turns );
    CHECK( fire.get_intensity() == 3 );
    CHECK( fire.get_start_time() == time_point( 42 ) );
    CHECK( u.get_part_hp_cur( alt_arm ) == hp_before );
    CHECK( u.get_effect_dur( effect_onfire ) == 4_turns );
    CHECK( u.remove_effect( effect_onfire, alt_arm ) );
    CHECK( u.has_effect( effect_onfire ) );
    CHECK( u.remove_effect( effect_onfire ) );
    CHECK_FALSE( u.has_effect( effect_onfire ) );
}

TEST_CASE( "monster_onfire_keeps_targeted_and_untargeted_keys", "[thermal_burn][monster]" )
{
    monster z( mtype_id( "mon_zombie" ) );
    z.add_effect( effect_onfire, 10_turns, false, 0, false, true );
    z.add_effect( effect_onfire, 5_turns, body_part_arm_l, false, 0, false, true );
    REQUIRE( z.get_effects().size() == 2 );
    CHECK( z.get_effect_dur( effect_onfire ) == 10_turns );
    CHECK( z.get_effect_dur( effect_onfire, body_part_arm_l ) == 5_turns );
    SECTION( "explicit removal keeps exact and bulk behavior" ) {
        CHECK( z.remove_effect( effect_onfire, body_part_arm_l ) );
        CHECK( z.has_effect( effect_onfire ) );
        CHECK( z.remove_effect( effect_onfire ) );
    }
    SECTION( "expiring the untargeted fire keeps the targeted fire" ) {
        z.get_effect( effect_onfire ).set_duration( 0_turns );
        z.Creature::process_effects();
        CHECK( z.get_effect( effect_onfire ).is_null() );
        CHECK( z.get_effect_dur( effect_onfire, body_part_arm_l ) == 4_turns );
    }
}

TEST_CASE( "contact_burn_and_random_wound_share_one_chance_per_hit",
           "[character][thermal_burn]" )
{
    const wound_type_id bruise( "test_thermal_contact_bruise" );
    wound_type::load_wounds( json_loader::from_string( R"({
        "id": "test_thermal_contact_bruise",
        "name": "test bruise",
        "description": "A bruise for the thermal contact test.",
        "damage_types": [ "bash" ],
        "damage_required": [ 1, 1 ],
        "healing_time": [ "10 minutes", "10 minutes" ]
    })" ).get_object(), "thermal_burn_test" );
    const on_out_of_scope remove_bruise( [&]() {
        cata::lua_platform::detail::wound_type_registry().erase( bruise );
        cata::lua_platform::detail::refresh_body_part_wound_cache();
    } );
    wound_type::finalize_all();
    REQUIRE( bruise.is_valid() );

    avatar &u = get_avatar();
    clear_character( u );
    bodypart &arm = *u.get_part( body_part_arm_l );
    u.add_effect( effect_onfire, 1_turns, body_part_arm_l, false, 1, false, true );
    damage_instance mixed( damage_heat, 8 );
    mixed.add_damage( damage_bash, 1 );
    constexpr unsigned int seed = 462172;
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    rng_set_engine_seed( seed );
    constexpr int chances[] = { 0, 25, 100 };
    for( const int percent : chances ) {
        const override_option chance( "WOUND_CHANCE", std::to_string( percent / 100.0 ) );
        const int attempts = percent == 25 ? 64 : 1;
        int successes = 0;
        CAPTURE( seed, percent );
        for( int attempt = 0; attempt < attempts; ++attempt ) {
            CAPTURE( attempt );
            arm.set_hp_to_max();
            u.deal_damage( nullptr, body_part_arm_l, mixed );
            const bool burn = arm.has_wound( wound_thermal_blister );
            const bool random_wound = arm.has_wound( bruise );
            successes += burn;
            arm.remove_all_wounds_of_type( bruise );
            arm.remove_all_wounds_of_type( wound_thermal_blister );
            REQUIRE( random_wound == burn );
        }
        if( percent == 25 ) {
            CHECK( successes >= 5 );
            CHECK( successes <= 28 );
        } else {
            CHECK( successes == percent / 100 );
        }
    }
}

TEST_CASE( "thermal_exposure_depends_on_elapsed_time_at_actual_part_temperature",
           "[character][thermal_burn]" )
{
    clear_map();
    avatar &u = get_avatar();
    clear_character( u );
    const override_option no_contact_wounds( "WOUND_CHANCE", "0" );
    restore_on_out_of_scope restore_turn( calendar::turn );
    restore_on_out_of_scope restore_temperature( get_weather().forced_temperature );
    get_weather().forced_temperature = 19_C;
    u.set_all_parts_temp_cur( BODYTEMP_NORM );
    bodypart &arm = *u.get_part( body_part_arm_l );
    // No fire field. Hold only the hand above the threshold while the normal simulation runs.
    const auto sample = [&]() {
        u.set_part_temp_cur( body_part_hand_l, BODYTEMP_SCORCHING + 2_C_delta );
        u.update_bodytemp( true );
    };
    SECTION( "strong radiant heat does not blister a still-cool part" ) {
        const restore_on_out_of_scope restore_new_game( g->new_game );
        g->new_game = false;
        get_weather().forced_temperature.reset();
        map &here = get_map();
        const tripoint_bub_ms pos = u.pos_bub();
        const field_type_id fire( "fd_fire" );
        get_weather().clear_temp_cache();
        const units::temperature without_fire = get_weather().get_temperature( pos );
        const on_out_of_scope remove_fire( [&]() {
            here.remove_field( pos + tripoint::east, fire );
            here.remove_field( pos + tripoint::west, fire );
            get_weather().clear_temp_cache();
        } );
        REQUIRE( here.add_field( pos + tripoint::east, fire, 3, 0_turns, false ) );
        REQUIRE( here.add_field( pos + tripoint::west, fire, 3, 0_turns, false ) );
        get_weather().clear_temp_cache();
        REQUIRE( units::to_celsius_delta( get_heat_radiation( pos ) ) > 44.0 );
        REQUIRE( get_weather().get_temperature( pos ) > without_fire );
        for( int turn = 0; turn <= 30; ++turn ) {
            u.set_all_parts_temp_cur( BODYTEMP_NORM );
            u.update_bodytemp( true );
            REQUIRE( u.get_part_temp_cur( body_part_hand_l ) < BODYTEMP_SCORCHING );
            if( turn < 30 ) {
                calendar::turn += 1_turns;
            }
        }
        CHECK_FALSE( arm.has_wounds() );
    }
    SECTION( "repeated refreshes are not extra exposure; prolonged heat upgrades once" ) {
        calendar::turn += 1_turns; // First hot sample, independent of character setup.
        sample();
        for( int i = 0; i < 40; ++i ) {
            sample();
        }
        REQUIRE_FALSE( arm.has_wounds() );
        for( int i = 1; i < 29; ++i ) {
            calendar::turn += 1_turns;
            sample();
        }
        REQUIRE_FALSE( arm.has_wounds() );
        calendar::turn += 1_turns;
        sample();
        REQUIRE( arm.has_wound( wound_thermal_blister ) );
        CHECK_FALSE( u.get_part( body_part_arm_r )->has_wounds() );
        for( int i = 0; i < 90; ++i ) {
            calendar::turn += 1_turns;
            sample();
        }
        REQUIRE( arm.get_wounds().size() == 1 );
        REQUIRE( arm.has_wound( wound_thermal_burn ) );
        u.update_wounds( 1_hours );
        std::ostringstream save;
        JsonOut out( save );
        arm.serialize( out );
        bodypart restored;
        restored.deserialize( json_loader::from_string( save.str() ).get_object() );
        REQUIRE( restored.has_wound( wound_thermal_burn ) );
        CHECK( restored.get_wounds().front().get_healing_progress() == 1_hours );
        restored.update_wounds( restored.get_wounds().front().get_healing_time() );
        CHECK_FALSE( restored.has_wounds() );
    }
    SECTION( "worn heat immunity prevents new wounds without healing old ones" ) {
        u.apply_thermal_burn( body_part_hand_l, false );
        REQUIRE( arm.has_wound( wound_thermal_blister ) );
        REQUIRE( u.wear_item( item( itype_test_zentai_immune_test_fire ), false ).has_value() );
        REQUIRE( u.is_immune_damage( damage_heat ) );
        for( int i = 0; i < 125; ++i ) {
            calendar::turn += 1_turns;
            sample();
        }
        u.apply_thermal_burn( body_part_hand_l, true );
        REQUIRE( arm.get_wounds().size() == 1 );
        CHECK( arm.has_wound( wound_thermal_blister ) );
    }
}
