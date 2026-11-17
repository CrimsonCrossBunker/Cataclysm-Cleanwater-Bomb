#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include <algorithm>
#include <optional>
#include <sstream>
#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "dialogue.h"
#include "effect.h"
#include "effect_on_condition.h"
#include "enums.h"
#include "game.h"
#include "item.h"
#include "flexbuffer_json.h"
#include "json.h"
#include "json_loader.h"
#include "lua_platform_hooks.h"
#include "lua_platform_runtime.h"
#include "magic.h"
#include "map_helpers.h"
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
static const efftype_id effect_stunned( "stunned" );
static const efftype_id effect_psi_stunned( "psi_stunned" );
static const activity_id ACT_VAMPIRE_DRINKING_BLOOD( "ACT_VAMPIRE_DRINKING_BLOOD" );
static const spell_id spell_vampire_drink_blood_with_fangs( "vampire_drink_blood_with_fangs_spell" );
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
static const trait_id trait_VAMPIRE_WEAKNESS_HOLY_BURN( "VAMPIRE_WEAKNESS_HOLY_BURN" );
static const trait_id trait_VAMPIRE_WEAKNESS_NEED_HUMAN_BLOOD( "VAMPIRE_WEAKNESS_NEED_HUMAN_BLOOD" );
static const vitamin_id vitamin_human_blood_vitamin( "human_blood_vitamin" );
static const vitamin_id vitamin_drank_fae_blood( "drank_fae_blood" );
static const vitamin_id vitamin_blood( "blood" );
static const vitamin_id vitamin_redcells( "redcells" );
static const vitamin_id vitamin_vampire_blood_vitamin( "vampire_blood_vitamin" );

static void reload_xedra_avatar( avatar &player )
{
    std::ostringstream buffer;
    JsonOut json( buffer );
    player.serialize( json );
    player.queued_effect_on_conditions = queued_eocs();
    player.setID( character_id(), true );
    player.deserialize( json_loader::from_string( buffer.str() ).get_object() );
    effect_on_conditions::load_existing_character( player );
}

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
    clear_map();
    clear_avatar();
    const on_out_of_scope cleanup( [] {
        clear_npcs();
        clear_avatar();
    } );
    avatar &player = get_avatar();
    cata::lua_platform::runtime_world_ready( true );
    player.set_mutation( trait_VAMPIRE );
    player.set_mutation( trait_VAMPIRE_WEAKNESS_HOLY_BURN );
    player.vitamin_set( vitamin_human_blood_vitamin, 0 );
    npc &donor = spawn_npc( player.pos_bub().xy() + point::east, "test_talker" );
    donor.set_attitude( NPCATT_KILL );
    donor.vitamin_set( vitamin_blood, 0 );
    donor.vitamin_set( vitamin_redcells, 0 );
    const spell fangs( spell_vampire_drink_blood_with_fangs );
    REQUIRE( fangs.is_valid_target( player, donor.pos_bub() ) );
    fangs.cast_all_effects( player, donor.pos_bub() );
    CHECK_FALSE( player.has_activity( ACT_VAMPIRE_DRINKING_BLOOD ) );
    CHECK( player.queued_effect_on_conditions.empty() );

    const itype_id holy_symbol( "holy_symbol" );
    REQUIRE( donor.wear_item( item( holy_symbol ), false ) );
    donor.add_effect( effect_psi_stunned.is_valid() ? effect_psi_stunned : effect_stunned, 10_turns );
    const int pain_before = player.get_pain();
    const npc_opinion opinion_before = donor.op_of_u;
    fangs.cast_all_effects( player, donor.pos_bub() );
    REQUIRE( player.has_activity( ACT_VAMPIRE_DRINKING_BLOOD ) );
    REQUIRE_FALSE( player.queued_effect_on_conditions.empty() );
    CHECK( player.queued_effect_on_conditions.top().time == calendar::turn + 2_turns );
    CHECK( donor.vitamin_get( vitamin_blood ) <= -750 );
    CHECK( donor.vitamin_get( vitamin_blood ) >= -1200 );
    CHECK( donor.vitamin_get( vitamin_redcells ) <= -750 );
    CHECK( donor.vitamin_get( vitamin_redcells ) >= -1200 );
    CHECK( donor.op_of_u.trust <= opinion_before.trust - 2 );
    CHECK( donor.op_of_u.fear >= opinion_before.fear + 2 );
    CHECK( player.get_pain() >= pain_before + 10 );
    CHECK( player.get_pain() <= pain_before + 14 );
    CHECK( player.vitamin_get( vitamin_human_blood_vitamin ) == 0 );

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
}

TEST_CASE( "xedra_lua_restores_a_saved_combat_blood_reward", "[.][mods][xedra_evolved]" )
{
    const restore_on_out_of_scope restore_time( calendar::turn );
    const on_out_of_scope cleanup( [] {
        clear_avatar();
    } );
    clear_avatar();
    avatar &player = get_avatar();
    cata::lua_platform::runtime_world_ready( true );
    player.set_mutation( trait_VAMPIRE );
    player.vitamin_set( vitamin_human_blood_vitamin, 0 );
    player.add_effect( effect_vampire_blood_drinking, 4_turns );
    const time_point due = calendar::turn + 2_turns;
    player.queued_effect_on_conditions.push( {
        effect_on_condition_id( "EOC_VAMPIRE_DRINK_FROM_HUMAN_IN_COMBAT" ), due, {}
    } );

    reload_xedra_avatar( player );

    calendar::turn = due - 1_turns;
    effect_on_conditions::process_effect_on_conditions( player );
    CHECK( player.vitamin_get( vitamin_human_blood_vitamin ) == 0 );
    calendar::turn = due;
    effect_on_conditions::process_effect_on_conditions( player );
    const int reward = player.vitamin_get( vitamin_human_blood_vitamin );
    CHECK( reward >= 400 );
    CHECK( reward <= 500 );
    effect_on_conditions::process_effect_on_conditions( player );
    CHECK( player.vitamin_get( vitamin_human_blood_vitamin ) == reward );
}

namespace
{
struct xedra_timer {
    effect_on_condition_id legacy_id;
    std::string handler;

    bool matches( const queued_eoc &entry ) const {
        const auto name = entry.context.find( "handler" );
        return entry.eoc == legacy_id ||
               ( name != entry.context.end() && name->second.to_string() == handler );
    }

    std::optional<time_point> due( const Character &character ) const {
        const auto &queue = character.queued_effect_on_conditions.list;
        const auto found = std::find_if( queue.begin(), queue.end(), [this]( const queued_eoc & entry ) {
            return matches( entry );
        } );
        if( found == queue.end() ) {
            return std::nullopt;
        }
        CHECK( std::count_if( queue.begin(), queue.end(), [this]( const queued_eoc & entry ) {
            return matches( entry );
        } ) == 1 );
        return found->time;
    }

    void isolate( Character &character ) const {
        queued_eocs selected;
        for( const queued_eoc &entry : character.queued_effect_on_conditions.list ) {
            if( matches( entry ) ) {
                selected.push( entry );
            }
        }
        character.queued_effect_on_conditions = std::move( selected );
        if( character.is_avatar() ) {
            g->queued_global_effect_on_conditions = queued_eocs();
        }
    }
};
} // namespace

TEST_CASE( "xedra_recurring_timers_keep_saved_deadlines_and_reactivate", "[.][mods][xedra_evolved]" )
{
    const restore_on_out_of_scope restore_time( calendar::turn );
    const on_out_of_scope cleanup( [] {
        effect_on_conditions::clear( get_avatar() );
        clear_npcs();
        clear_avatar();
    } );
    clear_avatar();
    avatar &player = get_avatar();
    effect_on_conditions::clear( player );
    cata::lua_platform::runtime_world_ready( true );

    const xedra_timer inventor{ effect_on_condition_id( "EOC_INVENTOR_RECIPE_GAIN" ),
                                "inventor_recipe_due" };
    const xedra_timer blood{ effect_on_condition_id( "EOC_VAMPIRE_BLOOD_NUMBER_UI" ),
                             "vampire_blood_display_due" };
    const recipe_id research( "inventor_research_base_1" );
    const trait_id inventor_trait( "INVENTOR" );

    SECTION( "fresh characters enroll without an inventor trait" ) {
        effect_on_conditions::load_new_character( player );
        const std::optional<time_point> due = inventor.due( player );
        REQUIRE( due.has_value() );
        CHECK( *due >= calendar::turn + 20_hours );
        CHECK( *due <= calendar::turn + 28_hours );
        player.set_mutation( inventor_trait );
        CHECK( inventor.due( player ) == due );
    }

    SECTION( "a queued legacy deadline survives a save round trip and grants the recipe once due" ) {
        player.set_mutation( inventor_trait );
        player.forget_recipe( &research.obj() );
        REQUIRE_FALSE( player.knows_recipe( &research.obj() ) );
        const time_point due = calendar::turn + 2_hours;
        player.queued_effect_on_conditions.push( { inventor.legacy_id, due, {} } );
        reload_xedra_avatar( player );
        CHECK( inventor.due( player ) == due );
        reload_xedra_avatar( player );
        CHECK( inventor.due( player ) == due );
        inventor.isolate( player );
        calendar::turn = due - 1_turns;
        effect_on_conditions::process_effect_on_conditions( player );
        CHECK_FALSE( player.knows_recipe( &research.obj() ) );
        calendar::turn = due;
        effect_on_conditions::process_effect_on_conditions( player );
        CHECK( player.knows_recipe( &research.obj() ) );
        const auto next = inventor.due( player );
        REQUIRE( next.has_value() );
        CHECK( *next >= due + 20_hours );
        CHECK( *next <= due + 28_hours );
        effect_on_conditions::process_effect_on_conditions( player );
        CHECK( inventor.due( player ) == next );
    }

    SECTION( "legacy and new dormant timers stay stopped until an inventor trait returns" ) {
        player.inactive_effect_on_condition_vector.push_back( inventor.legacy_id );
        reload_xedra_avatar( player );
        CHECK_FALSE( inventor.due( player ).has_value() );
        player.set_mutation( inventor_trait );
        const auto resumed = inventor.due( player );
        REQUIRE( resumed.has_value() );
        CHECK( *resumed >= calendar::turn + 20_hours );
        CHECK( *resumed <= calendar::turn + 28_hours );

        player.unset_mutation( inventor_trait );
        CHECK( inventor.due( player ) == resumed );
        inventor.isolate( player );
        calendar::turn = *resumed;
        effect_on_conditions::process_effect_on_conditions( player );
        CHECK_FALSE( inventor.due( player ).has_value() );
        reload_xedra_avatar( player );
        CHECK_FALSE( inventor.due( player ).has_value() );
        player.set_mutation( inventor_trait );
        const auto second = inventor.due( player );
        REQUIRE( second.has_value() );
        CHECK( *second >= calendar::turn + 20_hours );
        CHECK( *second <= calendar::turn + 28_hours );
    }

    SECTION( "the saved blood display tick records unclamped blood before enforcing capacity" ) {
        const int storage = GENERATE( 0, 1, 2 );
        player.set_mutation( trait_VAMPIRE );
        if( storage >= 1 ) {
            player.set_mutation( trait_id( "VAMPIRE_STORE_MORE_BLOOD" ) );
        }
        if( storage == 2 ) {
            player.set_mutation( trait_id( "VAMPIRE_STORE_MORE_BLOOD_UPGRADE" ) );
        }
        player.vitamin_set( vitamin_human_blood_vitamin, 14000 );
        const int capacity = storage == 2 ? 13500 : storage == 1 ? 7900 : 5600;
        const time_point due = calendar::turn + 1_turns;
        player.queued_effect_on_conditions.push( { blood.legacy_id, due, {} } );
        reload_xedra_avatar( player );
        CHECK( blood.due( player ) == due );
        blood.isolate( player );
        calendar::turn = due;
        effect_on_conditions::process_effect_on_conditions( player );
        CHECK( player.get_value( "blood_amount_for_graph" ).dbl() == 14000.0 );
        CHECK( player.get_value( "max_blood_amount_for_graph" ).dbl() == capacity );
        CHECK( player.vitamin_get( vitamin_human_blood_vitamin ) == capacity );
        CHECK( blood.due( player ) == due + 1_turns );
    }

    SECTION( "an NPC initialized during world loading gets its own timers" ) {
        clear_map();
        cata::lua_platform::runtime_world_load_started();
        npc &actor = spawn_npc( player.pos_bub().xy() + point::east, "test_talker" );
        effect_on_conditions::load_existing_character( actor );
        cata::lua_platform::runtime_world_ready( false );
        const auto due = inventor.due( actor );
        REQUIRE( due.has_value() );
        CHECK( *due >= calendar::turn + 20_hours );
        CHECK( *due <= calendar::turn + 28_hours );
        CHECK_FALSE( inventor.due( player ).has_value() );
        effect_on_conditions::load_existing_character( actor );
        CHECK( inventor.due( actor ) == due );
    }
}
#endif
