#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "dialogue.h"
#include "effect.h"
#include "effect_on_condition.h"
#include "enums.h"
#include "item.h"
#include "lua_platform_hooks.h"
#include "lua_platform_runtime.h"
#include "math_parser_diag_value.h"
#include "npc.h"
#include "npc_opinion.h"
#include "player_helpers.h"
#include "talker.h"
#include "type_id.h"

static const itype_id itype_item_hedge_cure_cold_or_flu( "item_hedge_cure_cold_or_flu" );
static const itype_id itype_mutagen( "mutagen" );
static const itype_id itype_water_thirsttrouncer( "water_thirsttrouncer" );
static const efftype_id effect_common_cold( "common_cold" );
static const efftype_id effect_hedge_cure_cold_or_flu( "effect_hedge_cure_cold_or_flu" );
static const efftype_id effect_xe_hydrating_gout( "xe_hydrating_gout" );
static const trait_id trait_HOMULLUS_EXPANDED_MUTATIONS( "HOMULLUS_EXPANDED_MUTATIONS" );
static const trait_id trait_HOMULLUS_NO_DOLL_MUTATIONS( "HOMULLUS_NO_DOLL_MUTATIONS" );

// Run explicitly with --mods xedra_evolved.
TEST_CASE( "xedra_lua_consumables_apply_native_effects", "[.][mods][xedra_evolved]" )
{
    REQUIRE( itype_water_thirsttrouncer.is_valid() );
    clear_avatar();
    avatar &player = get_avatar();
    cata::lua_platform::runtime_world_ready( true );

    SECTION( "ThirstTrouncer applies hydrating gout" ) {
        item drink( itype_water_thirsttrouncer, calendar::turn, 1 );
        REQUIRE( player.consume( drink, true, true ) != trinary::NONE );
        const time_duration duration = player.get_effect_dur( effect_xe_hydrating_gout );
        CHECK( duration >= 8400_turns );
        CHECK( duration <= 16800_turns );
    }
    SECTION( "curative tea treats an existing cold" ) {
        const bool has_cold = GENERATE( false, true );
        if( has_cold ) {
            player.add_effect( effect_common_cold, 4_hours );
        }
        item tea( itype_item_hedge_cure_cold_or_flu, calendar::turn, 1 );
        REQUIRE( player.consume( tea, true, true ) != trinary::NONE );
        CHECK( player.has_effect( effect_hedge_cure_cold_or_flu ) == has_cold );
    }
    SECTION( "mutagen limits further Homullus mutations" ) {
        const bool has_expanded_mutations = GENERATE( false, true );
        if( has_expanded_mutations ) {
            player.set_mutation( trait_HOMULLUS_EXPANDED_MUTATIONS );
        }
        item mutagen( itype_mutagen, calendar::turn );
        REQUIRE( player.consume( mutagen, true, true ) != trinary::NONE );
        CHECK( player.has_trait( trait_HOMULLUS_NO_DOLL_MUTATIONS ) == has_expanded_mutations );
    }
}

static const itype_id itype_demihuman_blood( "demihuman_blood" );
static const itype_id itype_fae_blood( "fae_blood" );
static const itype_id itype_vampire_blood( "vampire_blood" );
static const efftype_id effect_anathema_need_vampire_blood( "effect_anathema_need_vampire_blood" );
static const efftype_id effect_feed_from_recently( "feed_from_recently" );
static const efftype_id effect_recent_vampire_drink( "effect_recent_vampire_drink" );
static const efftype_id effect_vampire_blood_drinking( "effect_vampire_blood_drinking" );
static const efftype_id effect_vampire_virus( "vampire_virus" );
static const activity_id ACT_VAMPIRE_DRINKING_BLOOD( "ACT_VAMPIRE_DRINKING_BLOOD" );
static const effect_on_condition_id eoc_combat_blood_reward( "EOC_VAMPIRE_DRINK_FROM_HUMAN_IN_COMBAT" );
static const morale_type morale_drank_blood( "morale_drank_blood" );
static const trait_id trait_ANATHEMA_WEAKNESS_MIND_CHAOS( "ANATHEMA_WEAKNESS_MIND_CHAOS" );
static const trait_id trait_ANATHEMA_WEAKNESS_NEED_VAMPIRE_BLOOD( "ANATHEMA_WEAKNESS_NEED_VAMPIRE_BLOOD" );
static const trait_id trait_BLOOD_FUN( "BLOOD_FUN" );
static const trait_id trait_BLOOD_FUN_UPGRADE( "BLOOD_FUN_UPGRADE" );
static const trait_id trait_DHAMPIR_TRAIT( "DHAMPIR_TRAIT" );
static const trait_id trait_DHAMPIR_WEAKNESS_LOWER_KCAL_FROM_FOOD( "DHAMPIR_WEAKNESS_LOWER_KCAL_FROM_FOOD" );
static const trait_id trait_VAMPIRE( "VAMPIRE" );
static const trait_id trait_VAMPIRE_ANATHEMA( "VAMPIRE_ANATHEMA" );
static const trait_id trait_VAMPIRE_DRINK_VAMPIRE_BLOOD( "VAMPIRE_DRINK_VAMPIRE_BLOOD" );
static const trait_id trait_VAMPIRE_WEAKNESS_NEED_HUMAN_BLOOD( "VAMPIRE_WEAKNESS_NEED_HUMAN_BLOOD" );
static const vitamin_id vitamin_human_blood_vitamin( "human_blood_vitamin" );
static const vitamin_id vitamin_drank_fae_blood( "drank_fae_blood" );
static const vitamin_id vitamin_blood( "blood" );
static const vitamin_id vitamin_redcells( "redcells" );
static const vitamin_id vitamin_vampire_blood_vitamin( "vampire_blood_vitamin" );

TEST_CASE( "xedra_lua_vampire_diet_preserves_blood_effects", "[.][mods][xedra_evolved]" )
{
    REQUIRE( itype_vampire_blood.is_valid() );
    clear_avatar();
    avatar &player = get_avatar();
    cata::lua_platform::runtime_world_ready( true );

    SECTION( "raw vampire blood infects an ordinary character" ) {
        item blood( itype_vampire_blood, calendar::turn, 1 );
        REQUIRE( player.consume( blood, true, true ) != trinary::NONE );
        REQUIRE( player.has_effect( effect_vampire_virus ) );
        CHECK( player.get_effect_int( effect_vampire_virus ) == 1 );
        CHECK( player.get_effect( effect_vampire_virus ).is_permanent() );
        CHECK( player.vitamin_get( vitamin_human_blood_vitamin ) == 1200 );
        CHECK( player.vitamin_get( vitamin_vampire_blood_vitamin ) == 0 );
    }

    SECTION( "anathema gains power with nourishment only if the trait permits it" ) {
        const bool nourishes = GENERATE( false, true );
        player.set_mutation( trait_VAMPIRE );
        player.set_mutation( trait_VAMPIRE_ANATHEMA );
        player.set_mutation( trait_ANATHEMA_WEAKNESS_MIND_CHAOS );
        player.set_mutation( trait_ANATHEMA_WEAKNESS_NEED_VAMPIRE_BLOOD );
        player.set_mutation( trait_BLOOD_FUN );
        player.set_mutation( trait_BLOOD_FUN_UPGRADE );
        if( nourishes ) {
            player.set_mutation( trait_VAMPIRE_DRINK_VAMPIRE_BLOOD );
        }
        player.add_effect( effect_vampire_virus, 1_turns, true, 1 );
        player.vitamin_set( vitamin_human_blood_vitamin, 0 );
        player.add_effect( effect_anathema_need_vampire_blood, 4_hours );
        const std::string counter = "counter_anathema_mind_chaos";
        player.set_value( counter, diag_value( nourishes ? 100.0 : -1.0 ) );
        item blood( itype_vampire_blood, calendar::turn, 1 );
        REQUIRE( player.consume( blood, true, true ) != trinary::NONE );
        const int power = player.vitamin_get( vitamin_vampire_blood_vitamin );
        const int nourishment = player.vitamin_get( vitamin_human_blood_vitamin );
        CHECK( power >= 30 );
        CHECK( power <= 50 );
        CHECK( nourishment >= ( nourishes ? 400 : 0 ) );
        CHECK( nourishment <= ( nourishes ? 500 : 0 ) );
        CHECK( player.has_morale( morale_drank_blood ) == ( nourishes ? 90 : 0 ) );
        CHECK( player.get_effect_dur( effect_recent_vampire_drink ) == 4_days );
        CHECK_FALSE( player.has_effect( effect_anathema_need_vampire_blood ) );
        CHECK( player.get_value( counter ).dbl() == 0.0 );
    }

    SECTION( "feed from a demihuman applies the withdrawal after direct feeding" ) {
        player.set_mutation( trait_VAMPIRE );
        player.set_mutation( trait_VAMPIRE_WEAKNESS_NEED_HUMAN_BLOOD );
        player.vitamin_set( vitamin_human_blood_vitamin, 1000 );
        item blood( itype_demihuman_blood, calendar::turn, 1 );
        REQUIRE( player.consume( blood, true, true ) != trinary::NONE );
        const int nourishment = player.vitamin_get( vitamin_human_blood_vitamin );
        CHECK( nourishment >= 1150 );
        CHECK( nourishment <= 1300 );
    }
}

TEST_CASE( "xedra_lua_living_blood_through_item_and_dialogue", "[.][mods][xedra_evolved]" )
{
    const std::string feeding_count = "dhampir_have_ever_drunk_blood";
    const std::string pending_fae_blood = "vampire_just_drank_fae_blood";
    clear_avatar();
    avatar &player = get_avatar();
    cata::lua_platform::runtime_world_ready( true );
    player.set_mutation( trait_DHAMPIR_TRAIT );
    player.set_mutation( trait_DHAMPIR_WEAKNESS_LOWER_KCAL_FROM_FOOD );
    player.vitamin_set( vitamin_human_blood_vitamin, 0 );
    player.vitamin_set( vitamin_drank_fae_blood, 0 );

    SECTION( "a bag of fae blood feeds the player and advances the dhampir counter" ) {
        const bool repeated = GENERATE( false, true );
        player.set_value( feeding_count, diag_value( repeated ? 20000.0 : 0.0 ) );
        const int kcal_before = player.get_stored_kcal();
        item blood( itype_fae_blood, calendar::turn, 1 );
        REQUIRE( player.consume( blood, true, true ) != trinary::NONE );
        const int gained_kcal = player.get_stored_kcal() - kcal_before;
        CHECK( gained_kcal >= 350 );
        CHECK( gained_kcal <= 500 );
        CHECK( player.get_value( feeding_count ).dbl() == ( repeated ? 1.0 : 2.0 ) );
        CHECK( player.get_value( pending_fae_blood ).dbl() == 0.0 );
        CHECK( player.vitamin_get( vitamin_drank_fae_blood ) == 5 );
        CHECK( player.vitamin_get( vitamin_human_blood_vitamin ) >= 250 );
        CHECK( player.vitamin_get( vitamin_human_blood_vitamin ) <= 350 );
    }

    SECTION( "a friend or ally gives blood once and keeps the original cooldown" ) {
        const bool friend_donor = GENERATE( false, true );
        npc donor;
        donor.normalize();
        donor.setID( character_id( 2718 ), true );
        donor.vitamin_set( vitamin_blood, 0 );
        donor.vitamin_set( vitamin_redcells, 0 );
        const int trust_before = donor.op_of_u.trust;
        const int opinion_before = donor.op_of_u.value;
        const int kcal_before = player.get_stored_kcal();

        const talk_topic topic( friend_donor ?
                                "TALK_FRIEND_FOLLOWER_BLOODFEED_YES" :
                                "TALK_FRIEND_FOLLOWER_BLOODFEED_KINDA" );
        dialogue conversation( get_talker_for( player ), get_talker_for( donor ) );
        cata::lua_platform::begin_dialogue_session( conversation );
        conversation.gen_responses( topic );
        REQUIRE( conversation.responses.size() == 3 );
        CHECK( conversation.responses.front().success.apply( conversation ).id == "TALK_NONE" );

        const int gained_kcal = player.get_stored_kcal() - kcal_before;
        CHECK( gained_kcal >= 450 );
        CHECK( gained_kcal <= 675 );
        CHECK( player.vitamin_get( vitamin_human_blood_vitamin ) >= 250 );
        CHECK( player.vitamin_get( vitamin_human_blood_vitamin ) <= 350 );
        CHECK( player.vitamin_get( vitamin_drank_fae_blood ) == 0 );
        CHECK( player.get_value( feeding_count ).dbl() == 2.0 );
        CHECK( player.has_morale( morale_drank_blood ) == 45 );
        CHECK( donor.get_effect_dur( effect_feed_from_recently ) == ( friend_donor ? 5_days : 10_days ) );
        CHECK( donor.vitamin_get( vitamin_blood ) >= -500 );
        CHECK( donor.vitamin_get( vitamin_blood ) <= -400 );
        CHECK( donor.vitamin_get( vitamin_redcells ) >= -500 );
        CHECK( donor.vitamin_get( vitamin_redcells ) <= -400 );
        CHECK( donor.op_of_u.trust == trust_before - ( friend_donor ? 0 : 1 ) );
        CHECK( donor.op_of_u.value == opinion_before - ( friend_donor ? 0 : 1 ) );

        conversation.gen_responses( topic );
        REQUIRE( conversation.responses.size() == 2 );
        CHECK( conversation.responses.front().success.next_topic.id ==
               ( friend_donor ? "TALK_NONE" : "TALK_FRIEND" ) );
        cata::lua_platform::end_dialogue_session( conversation );
    }
}

TEST_CASE( "xedra_lua_interrupts_the_queued_combat_blood_reward", "[.][mods][xedra_evolved]" )
{
    const restore_on_out_of_scope restore_time( calendar::turn );
    const bool interrupted = GENERATE( false, true );
    clear_avatar();
    avatar &player = get_avatar();
    cata::lua_platform::runtime_world_ready( true );
    player.set_mutation( trait_VAMPIRE );
    player.vitamin_set( vitamin_human_blood_vitamin, 0 );
    player.add_effect( effect_vampire_blood_drinking, 4_turns );
    effect_on_conditions::queue_effect_on_condition( 2_turns, eoc_combat_blood_reward, player, {} );
    player.assign_activity( ACT_VAMPIRE_DRINKING_BLOOD, to_moves<int>( 3_turns ) );
    REQUIRE( player.has_activity( ACT_VAMPIRE_DRINKING_BLOOD ) );

    if( interrupted ) {
        player.cancel_activity();
        CHECK_FALSE( player.has_activity( ACT_VAMPIRE_DRINKING_BLOOD ) );
        CHECK( player.backlog.empty() );
    }
    CHECK( player.has_effect( effect_vampire_blood_drinking ) == !interrupted );

    calendar::turn += 2_turns;
    effect_on_conditions::process_effect_on_conditions( player );
    const int blood = player.vitamin_get( vitamin_human_blood_vitamin );
    CHECK( blood >= ( interrupted ? 0 : 400 ) );
    CHECK( blood <= ( interrupted ? 0 : 500 ) );
    clear_avatar();
}
#endif
