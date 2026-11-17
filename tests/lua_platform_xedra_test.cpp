#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include <algorithm>
#include <array>
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
#include "event.h"
#include "event_bus.h"
#include "flag.h"
#include "game.h"
#include "global_vars.h"
#include "item.h"
#include "flexbuffer_json.h"
#include "json.h"
#include "json_loader.h"
#include "lua_platform_hooks.h"
#include "lua_platform_runtime.h"
#include "magic.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "mattack_actors.h"
#include "math_parser_diag_value.h"
#include "messages.h"
#include "monster.h"
#include "npc.h"
#include "npc_opinion.h"
#include "player_helpers.h"
#include "recipe.h"
#include "rng.h"
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

TEST_CASE( "xedra_weakness_messages_follow_native_mutation_events",
           "[.][mods][xedra_evolved]" )
{
    clear_avatar();
    clear_map();
    const on_out_of_scope cleanup( []() {
        Messages::clear_messages();
        clear_npcs();
        clear_avatar();
    } );
    cata::lua_platform::runtime_world_ready( true );
    avatar &player = get_avatar();
    npc &other = spawn_npc( player.pos_bub().xy() + point::east, "test_talker" );
    REQUIRE( player.getID().is_valid() );
    REQUIRE( g->find_npc( other.getID() ) == &other );
    const trait_id thirst( "VAMPIRE_WEAKNESS_MORE_BLOOD" );
    const trait_id sunlight( "ANATHEMA_WEAKNESS_SUN_BURN" );
    REQUIRE( thirst.is_valid() );
    REQUIRE( sunlight.is_valid() );

    const auto heard = []( const std::string &text ) {
        const auto messages = Messages::recent_messages( 10 );
        return std::any_of( messages.begin(), messages.end(), [&]( const auto &message ) {
            return message.second == text;
        } );
    };
    Messages::clear_messages();
    get_event_bus().send<event_type::gains_mutation>( other.getID(), thirst );
    CHECK_FALSE( heard( "Your thirst for blood intensifies." ) );
    get_event_bus().send<event_type::gains_mutation>( player.getID(), thirst );
    CHECK( heard( "Your thirst for blood intensifies." ) );
    get_event_bus().send<event_type::gains_mutation>( player.getID(), sunlight );
    CHECK( heard( "You know with certainty that standing under the sun will slay you in moments." ) );

    Messages::clear_messages();
    get_event_bus().send<event_type::gains_mutation>( player.getID(), trait_id( "TOUGH" ) );
    CHECK( Messages::recent_messages( 10 ).empty() );
}

TEST_CASE( "xedra_warping_poison_uses_native_melee_and_only_mutates_on_damage",
           "[.][mods][xedra_evolved]" )
{
    clear_avatar();
    clear_map();
    const on_out_of_scope cleanup( []() {
        clear_creatures();
        clear_avatar();
    } );
    const restore_on_out_of_scope restore_turn( calendar::turn );
    cata::lua_platform::runtime_world_ready( true );

    avatar &player = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms player_tile( 60, 60, 0 );
    player.setpos( here, player_tile );
    monster &warper = spawn_test_monster( "mon_mi_go_stalking_warper",
                                        player_tile + tripoint_rel_ms::east );
    warper.set_dest( player.pos_abs() );
    set_time( calendar::turn - time_past_midnight( calendar::turn ) + 12_hours );
    REQUIRE( warper.attack_target() == &player );

    const auto found = warper.type->special_attacks.find( "inject_warping_poison" );
    REQUIRE( found != warper.type->special_attacks.end() );
    const auto *attack = dynamic_cast<const melee_actor *>( found->second.get() );
    REQUIRE( attack != nullptr );
    CHECK( attack->cooldown.evaluate( {} ) == 25 );
    CHECK( attack->move_cost == 150 );
    CHECK( attack->hitsize_min == 4 );
    CHECK( attack->dodgeable );
    CHECK( attack->blockable );
    REQUIRE( attack->damage_max_instance.damage_units.size() == 1 );
    const damage_unit &stab = attack->damage_max_instance.damage_units.front();
    CHECK( stab.type == damage_type_id( "stab" ) );
    CHECK( stab.amount == 15 );
    CHECK( stab.res_pen == 8 );
    CHECK( stab.res_mult == Approx( 0.5 ) );
    CHECK( attack->hit_dmg_u.translated() == "%1$s bites and injects poison into your %2$s!" );

    const bool prevent_damage = GENERATE( false, true );
    CAPTURE( prevent_damage );
    if( prevent_damage ) {
        player.set_mutation( trait_id( "DEBUG_NODMG" ) );
    }
    const auto before = player.get_mutations();
    const int moves = warper.get_moves();
    rng_set_engine_seed( 70731 );
    REQUIRE( attack->call( warper ) );
    CHECK( warper.get_moves() == moves - 150 );
    if( prevent_damage ) {
        CHECK( player.get_mutations() == before );
    } else {
        CHECK( player.get_mutations() != before );
    }
}

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

    std::optional<time_point> due( const queued_eocs &tasks ) const {
        const auto &queue = tasks.list;
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

    std::optional<time_point> due( const Character &character ) const {
        return due( character.queued_effect_on_conditions );
    }

    void isolate( queued_eocs &tasks ) const {
        queued_eocs selected;
        for( const queued_eoc &entry : tasks.list ) {
            if( matches( entry ) ) {
                selected.push( entry );
            }
        }
        tasks = std::move( selected );
    }

    void isolate( Character &character ) const {
        isolate( character.queued_effect_on_conditions );
        if( character.is_avatar() ) {
            g->queued_global_effect_on_conditions = queued_eocs();
        }
    }
};
} // namespace

TEST_CASE( "xedra_anathema_sunlight_preserves_burn_and_sunrise_deadlines",
           "[.][mods][xedra_evolved]" )
{
    const restore_on_out_of_scope restore_time( calendar::turn );
    const on_out_of_scope cleanup( [] {
        effect_on_conditions::clear( get_avatar() );
        clear_avatar();
    } );
    clear_avatar();
    clear_map();
    avatar &player = get_avatar();
    effect_on_conditions::clear( player );
    cata::lua_platform::runtime_world_ready( true );
    map &here = get_map();
    const tripoint_bub_ms tile( 60, 60, 0 );
    player.setpos( here, tile );
    set_time( calendar::turn_zero + 12_hours );
    REQUIRE( here.is_outside( tile ) );
    player.set_mutation( trait_id( "ANATHEMA_WEAKNESS_SUN_BURN" ) );

    const efftype_id burning( "effect_slain_by_the_sun" );
    const efftype_id limiter( "effect_slain_by_the_sun_limiter" );
    const efftype_id resilience( "effect_vampiric_resilience" );
    const efftype_id fire( "onfire" );
    const xedra_timer burn_tick{ effect_on_condition_id( "EOC_VAMPIRE_ANATHEMA_BURN_IN_SUNLIGHT_CONTINUAL" ),
                                 "anathema_sun_burn_due" };
    const xedra_timer daily{ effect_on_condition_id( "EOC_XE_VAMPIRE_ANATHEMA_BURN_IN_SUNLIGHT_AT_SUNRISE" ),
                             "anathema_sunrise_due" };
    queued_eocs &global_tasks = g->queued_global_effect_on_conditions;
    const auto move = [&] {
        get_event_bus().send<event_type::avatar_moves>( mtype_id::NULL_ID(), here.ter( tile ).id(),
                move_mode_id( "walk" ), false, tile.z() );
    };

    SECTION( "outdoors rolls separately for six parts and shelter stops the pending tick" ) {
        enum class protection { none, resilience, fireproof };
        const protection active = GENERATE( protection::none, protection::resilience,
                                             protection::fireproof );
        const bool resistant = active == protection::resilience;
        const bool fireproof = active == protection::fireproof;
        if( resistant ) {
            player.add_effect( resilience, 1_hours );
        }
        if( fireproof ) {
            player.set_mutation( trait_id( "M_SKIN2" ) );
            REQUIRE( player.is_immune_effect( fire ) );
        }
        const std::array<bodypart_id, 6> parts = {
            bodypart_id( "arm_l" ), bodypart_id( "arm_r" ), bodypart_id( "leg_l" ),
            bodypart_id( "leg_r" ), bodypart_id( "torso" ), bodypart_id( "head" )
        };
        unsigned int seed = 1;
        std::array<double, parts.size()> rolls{};
        for( ; seed < 1000; ++seed ) {
            rng_set_engine_seed( seed );
            for( double &roll : rolls ) {
                roll = rng_float( 0, 1 );
            }
            const double smallest = *std::min_element( rolls.begin(), rolls.end() );
            if( smallest > 1.0 / 120.0 && smallest <= 1.0 / 30.0 ) {
                break;
            }
        }
        CAPTURE( resistant, fireproof, seed );
        REQUIRE( seed < 1000 );
        rng_set_engine_seed( seed );
        move();
        REQUIRE( player.has_effect( burning ) );
        REQUIRE( player.has_effect( limiter ) );
        CHECK( burn_tick.due( player ) == calendar::turn + 1_turns );
        for( std::size_t i = 0; i < parts.size(); ++i ) {
            const bool ignited = !fireproof && rolls[i] <= ( resistant ? 1.0 / 120.0 : 1.0 / 30.0 );
            CAPTURE( i, ignited );
            CHECK( player.get_effect_dur( fire, parts[i] ) == ( ignited ? 30_turns : 0_turns ) );
        }

        move();
        CHECK( burn_tick.due( player ) == calendar::turn + 1_turns );
        here.ter_set( tile, ter_id( "t_floor" ) );
        set_time( calendar::turn );
        REQUIRE_FALSE( here.is_outside( tile ) );
        move();
        CHECK_FALSE( player.has_effect( burning ) );
        CHECK_FALSE( player.has_effect( limiter ) );
        CHECK( burn_tick.due( player ) == calendar::turn + 1_turns );
        calendar::turn += 1_turns;
        effect_on_conditions::process_effect_on_conditions( player );
        CHECK_FALSE( burn_tick.due( player ).has_value() );
    }

    SECTION( "sunrise requeues at the same deadline for the next pass without starting a burn" ) {
        const time_point at_sunrise = sunrise( calendar::turn );
        set_time( at_sunrise - 1_turns );
        effect_on_conditions::load_existing_character( player );
        CHECK( daily.due( global_tasks ) == at_sunrise );
        effect_on_conditions::load_existing_character( player );
        CHECK( daily.due( global_tasks ) == at_sunrise );
        daily.isolate( global_tasks );
        player.queued_effect_on_conditions = queued_eocs();

        calendar::turn = at_sunrise;
        effect_on_conditions::process_effect_on_conditions( player );
        CHECK_FALSE( player.has_effect( burning ) );
        CHECK_FALSE( burn_tick.due( player ).has_value() );
        CHECK( daily.due( global_tasks ) == at_sunrise );
        calendar::turn += 1_turns;
        effect_on_conditions::process_effect_on_conditions( player );
        CHECK( daily.due( global_tasks ) == sunrise( calendar::turn ) + 1_days );
    }

    SECTION( "old character and world queue entries keep their original deadlines" ) {
        const time_point next_burn = calendar::turn + 3_turns;
        const time_point saved_sunrise = calendar::turn + 2_hours;
        player.add_effect( burning, 1_turns, true );
        player.add_effect( limiter, 1_turns, true );
        player.queued_effect_on_conditions.push( { burn_tick.legacy_id, next_burn, {} } );
        global_tasks.push( { daily.legacy_id, saved_sunrise, {} } );

        reload_xedra_avatar( player );
        CHECK( burn_tick.due( player ) == next_burn );
        CHECK( daily.due( global_tasks ) == saved_sunrise );
        reload_xedra_avatar( player );
        CHECK( burn_tick.due( player ) == next_burn );
        CHECK( daily.due( global_tasks ) == saved_sunrise );
        burn_tick.isolate( player.queued_effect_on_conditions );
        daily.isolate( global_tasks );

        calendar::turn = next_burn;
        rng_set_engine_seed( 70731 );
        effect_on_conditions::process_effect_on_conditions( player );
        CHECK( burn_tick.due( player ) == next_burn + 1_turns );
        CHECK( daily.due( global_tasks ) == saved_sunrise );
    }
}

TEST_CASE( "xedra_weakness_reshuffle_preserves_crafting_and_saved_attempts",
           "[.][mods][xedra_evolved]" )
{
    const restore_on_out_of_scope restore_time( calendar::turn );
    const on_out_of_scope cleanup( [] {
        effect_on_conditions::clear( get_avatar() );
        clear_avatar();
    } );
    clear_avatar();
    clear_map();
    avatar &player = get_avatar();
    effect_on_conditions::clear( player );
    cata::lua_platform::runtime_world_ready( true );
    player.setpos( get_map(), tripoint_bub_ms( 60, 60, 0 ) );
    set_time( calendar::turn_zero + 12_hours );

    const recipe_id reshuffle_recipe( "xe_vampire_blood_weaknesses_reshuffle" );
    const activity_id reshuffle_activity( "ACT_VAMPIRE_RESHUFFLING_WEAKNESSES" );
    const effect_on_condition_id old_attempt( "EOC_XE_VAMPIRE_WEAKNESS_RESHUFFLE_SWITCHER" );
    const xedra_timer attempt{ old_attempt, "vampire_weakness_reshuffle_due" };
    const efftype_id reshuffling( "effect_vampire_reshuffling_weaknesses" );
    const efftype_id recently_reshuffled( "effect_vampire_recently_reshuffled_weaknesses" );
    REQUIRE( reshuffle_recipe.is_valid() );
    REQUIRE( reshuffle_activity.is_valid() );
    CHECK( reshuffle_recipe->result().is_null() );
    CHECK( reshuffle_recipe->result_name() == "reshuffle vampiric weaknesses" );
    CHECK( reshuffle_recipe->has_flag( "NO_BENCH" ) );
    CHECK( reshuffle_recipe->has_flag( "NO_ENCHANTMENT" ) );

    SECTION( "craft spends blood, starts an eight-hour activity, and cancellation stops the attempt" ) {
        const int blood = GENERATE( 2999, 3000 );
        player.vitamin_set( vitamin_human_blood_vitamin, blood );
        player.learn_recipe( &reshuffle_recipe.obj() );
        player.make_craft( reshuffle_recipe, 1 );
        REQUIRE( player.activity.id() == activity_id( "ACT_CRAFT" ) );
        for( int turn = 0; turn < 120 && player.activity.id() == activity_id( "ACT_CRAFT" ); ++turn ) {
            player.set_moves( 100 );
            player.activity.do_turn( player );
        }
        REQUIRE( player.activity.id() != activity_id( "ACT_CRAFT" ) );
        if( blood == 2999 ) {
            CHECK_FALSE( player.activity );
            CHECK_FALSE( player.has_effect( reshuffling ) );
            CHECK_FALSE( attempt.due( player ).has_value() );
            CHECK( player.vitamin_get( vitamin_human_blood_vitamin ) == 2999 );
        } else {
            REQUIRE( player.activity.id() == reshuffle_activity );
            CHECK( player.activity.moves_left == to_moves<int>( 8_hours ) );
            CHECK( player.get_effect_dur( reshuffling ) == 8_hours );
            CHECK( player.vitamin_get( vitamin_human_blood_vitamin ) == 0 );
            const std::optional<time_point> due = attempt.due( player );
            REQUIRE( due.has_value() );
            CHECK( *due >= calendar::turn + 120_minutes );
            CHECK( *due <= calendar::turn + 180_minutes );

            player.cancel_activity();
            CHECK_FALSE( player.has_effect( reshuffling ) );
            attempt.isolate( player );
            calendar::turn = *due;
            effect_on_conditions::process_effect_on_conditions( player );
            CHECK_FALSE( attempt.due( player ).has_value() );
            CHECK_FALSE( player.has_effect( recently_reshuffled ) );
        }
    }

    SECTION( "a restored original attempt preserves its due turn and retries or replaces weaknesses" ) {
        const bool succeeds = GENERATE( false, true );
        player.set_mutation( trait_id( "VAMPIRE3" ) );
        player.set_mutation( trait_id( "VAMPIRE_WEAKNESS_NO_FUN" ) );
        int seed = 1;
        if( !succeeds ) {
            rng_set_engine_seed( seed );
            while( rng( 0, 9 ) + rng( 0, 9 ) + 2 + player.get_int() / 2.0 >= 17 ) {
                rng_set_engine_seed( ++seed );
            }
        } else {
            player.set_skill_level( skill_id( "deduction" ), 20 );
        }
        player.add_effect( reshuffling, 8_hours );
        const time_point deadline = calendar::turn + 5_turns;
        player.queued_effect_on_conditions.push( { old_attempt, deadline, {} } );
        reload_xedra_avatar( player );
        CHECK( attempt.due( player ) == deadline );
        attempt.isolate( player );

        calendar::turn = deadline;
        rng_set_engine_seed( seed );
        effect_on_conditions::process_effect_on_conditions( player );
        CHECK( player.has_effect( reshuffling ) == !succeeds );
        CHECK( player.get_effect_dur( recently_reshuffled ) == ( succeeds ? 5_days : 0_turns ) );
        if( succeeds ) {
            CHECK_FALSE( attempt.due( player ).has_value() );
            std::vector<std::string> new_weaknesses;
            for( const trait_id &trait : player.get_mutations() ) {
                if( trait.str().find( "VAMPIRE_WEAKNESS_" ) == 0 ) {
                    new_weaknesses.push_back( trait.str() );
                }
            }
            CAPTURE( new_weaknesses );
            CHECK( new_weaknesses.size() == 1 );
        } else {
            CHECK( player.has_trait( trait_id( "VAMPIRE_WEAKNESS_NO_FUN" ) ) );
            REQUIRE( attempt.due( player ).has_value() );
            CHECK( *attempt.due( player ) >= deadline + 90_minutes );
            CHECK( *attempt.due( player ) <= deadline + 150_minutes );
        }
    }
}

TEST_CASE( "xedra_anathema_catalyst_and_progression_preserve_native_outcomes",
           "[.][mods][xedra_evolved]" )
{
    const restore_on_out_of_scope restore_time( calendar::turn );
    const on_out_of_scope cleanup( [] {
        effect_on_conditions::clear( get_avatar() );
        Messages::clear_messages();
        clear_avatar();
    } );
    clear_avatar();
    avatar &player = get_avatar();
    effect_on_conditions::clear( player );
    cata::lua_platform::runtime_world_ready( true );

    const trait_id threshold( "THRESH_VAMPIRE_ANATHEMA" );
    const vitamin_id blood( "vampire_blood_vitamin" );
    const efftype_id potency( "effect_player_anathema_potency_boost" );
    const effect_on_condition_id old_timer( "EOC_VAMPIRE_ANATHEMA_GAIN_POWERS" );
    const xedra_timer progression{ old_timer, "anathema_progression_due" };
    const std::array<const char *, 18> powers = {
        "VAMPIRE_STORE_MORE_BLOOD", "EYEGLEAM_UPGRADE", "VAMPIRE_INSTANT_BLEED",
        "VAMPIRE_DETECT_VAMPIRES", "VAMPIRE_BIG_STOMACH", "VAMPIRE_SEE_THROUGH_NIGHT_EYES",
        "BLOOD_FUN_UPGRADE", "VAMPIRE_SILENT_MOVE_UPGRADE", "VAMPIRE_STORE_MORE_BLOOD_UPGRADE",
        "VAMPIRE_INVISIBLE_IN_DARK", "VAMPIRE_HEAL_IN_DARK", "VAMPIRE_BLOOD_FOR_POTENCY",
        "VAMPIRE_NO_ILLNESS_UPGRADE", "VAMPIRE_FORM_UPGRADE", "VAMPIRE_LAST_BREATH_MIST_UPGRADE",
        "VAMPIRE_DRINK_VAMPIRE_BLOOD", "VAMPIRE_GAIN_BLOOD_GIFTS", "VAMPIRE_MASTER_MORTAL_MIND_UPGRADE"
    };
    const auto matching = [&]( std::string_view prefix ) {
        std::vector<std::string> out;
        for( const trait_id &trait : player.get_mutations() ) {
            if( trait.str().compare( 0, prefix.size(), prefix ) == 0 ) {
                out.emplace_back( trait.str() );
            }
        }
        std::sort( out.begin(), out.end() );
        return out;
    };

    SECTION( "drinking the catalyst requires tier five and no existing threshold" ) {
        const int state = GENERATE( 0, 1, 2 );
        if( state > 0 ) {
            player.set_mutation( trait_id( "BLOOD_DRINKER" ) );
        }
        if( state == 2 ) {
            player.set_mutation( trait_id( "THRESH_FISH" ) );
            REQUIRE( player.crossed_threshold() );
        }
        item catalyst( itype_id( "anathema_blood_catalyst" ), calendar::turn );
        CHECK( catalyst.charges == 0 );
        CHECK( catalyst.tname() == "blood of the Anathema" );
        CHECK( catalyst.volume() == 250_ml );
        CHECK( catalyst.weight() == 235_gram );
        CHECK( catalyst.has_flag( flag_TRADER_AVOID ) );
        rng_set_engine_seed( 70731 );
        REQUIRE( player.consume( catalyst, true, true ) != trinary::NONE );
        const auto weaknesses = matching( "VAMPIRE_WEAKNESS_" );
        const int next_draw = rng( 0, 1000000 );
        CAPTURE( state, weaknesses, next_draw );
        CHECK( player.has_trait( trait_VAMPIRE_ANATHEMA ) == ( state == 1 ) );
        CHECK( weaknesses.size() == ( state == 1 ? 2 : 0 ) );
    }

    SECTION( "a saved turn spends blood on initial powers, threshold or potency" ) {
        const int stage = GENERATE( 0, 1, 2, 3 );
        player.set_mutation( trait_VAMPIRE_ANATHEMA );
        if( stage == 2 ) {
            for( std::size_t n = 0; n < 7; ++n ) {
                player.set_mutation( trait_id( powers[n] ) );
            }
        } else if( stage == 3 ) {
            player.set_mutation( threshold );
            for( const char *power : powers ) {
                player.set_mutation( trait_id( power ) );
            }
        }
        const int stored_blood = stage == 0 ? 599 : 700;
        player.vitamin_set( blood, stored_blood );
        CHECK( player.vitamin_get( blood ) == stored_blood );
        const time_point due = calendar::turn + 5_turns;
        player.queued_effect_on_conditions.push( { old_timer, due, {} } );
        reload_xedra_avatar( player );
        CHECK( progression.due( player ) == due );
        progression.isolate( player );

        rng_set_engine_seed( 70731 );
        calendar::turn = due;
        effect_on_conditions::process_effect_on_conditions( player );
        const auto weaknesses = matching( "VAMPIRE_WEAKNESS_" );
        const auto curses = matching( "ANATHEMA_WEAKNESS_" );
        const auto mutations = player.get_mutations();
        const int next_draw = rng( 0, 1000000 );
        CAPTURE( stage, mutations, weaknesses, curses, next_draw );
        CHECK( player.vitamin_get( blood ) == ( stage == 0 ? 599 : 100 ) );
        CHECK( player.has_trait( threshold ) == ( stage >= 2 ) );
        CHECK( weaknesses.size() == ( stage == 2 ? 3 : 0 ) );
        CHECK( curses.size() == ( stage == 2 ? 1 : 0 ) );
        CHECK( player.get_effect_int( potency ) == ( stage == 3 ? 1 : 0 ) );
        REQUIRE( progression.due( player ).has_value() );
        CAPTURE( *progression.due( player ) - due );
        CHECK( *progression.due( player ) >= due + 3_hours );
        CHECK( *progression.due( player ) <= due + 4_hours );
    }
}

TEST_CASE( "xedra_vampire_infection_preserves_progression_and_saved_timers",
           "[.][mods][xedra_evolved]" )
{
    const restore_on_out_of_scope restore_time( calendar::turn );
    const restore_on_out_of_scope restore_globals( get_globals().get_global_values() );
    const on_out_of_scope cleanup( [] {
        effect_on_conditions::clear( get_avatar() );
        Messages::clear_messages();
        clear_avatar();
    } );
    clear_avatar();
    avatar &player = get_avatar();
    effect_on_conditions::clear( player );
    cata::lua_platform::runtime_world_ready( true );

    const efftype_id sickness( "vampire_virus" );
    const trait_id stage_three( "VAMPIRE3" );
    const xedra_timer infection{ effect_on_condition_id( "EOC_vampire_virus_escalation" ),
                                 "vampire_infection_due" };
    const xedra_timer change_intensity{ effect_on_condition_id( "EOC_ADD_VAMPIRUS_INTENSITY1" ),
                                        "vampire_intensity_two_due" };
    const xedra_timer avatar_infection{ effect_on_condition_id( "EOC_VAMPIRES" ),
                                        "avatar_vampire_infection_due" };
    const xedra_timer hunger{ effect_on_condition_id( "EOC_vampire_virus_blood_needs" ),
                              "vampire_hunger_due" };
    const time_point due = calendar::turn + 5_turns;

    SECTION( "a restored infection grants third tier and a weakness only without treatment" ) {
        const bool treated = GENERATE( false, true );
        player.set_mutation( trait_id( "VAMPIRE2" ) );
        player.add_effect( sickness, 1_turns, true, 3 );
        if( treated ) {
            player.add_effect( efftype_id( "blood_treatment" ), 1_hours );
        }
        player.queued_effect_on_conditions.push( { infection.legacy_id, due, {} } );
        reload_xedra_avatar( player );
        CHECK( infection.due( player ) == due );
        infection.isolate( player );

        calendar::turn = due;
        rng_set_engine_seed( 70731 );
        effect_on_conditions::process_effect_on_conditions( player );
        std::vector<std::string> granted;
        for( const trait_id &mutation : player.get_mutations() ) {
            if( mutation.str().find( "VAMPIRE_WEAKNESS_" ) == 0 ) {
                granted.push_back( mutation.str() );
            }
        }
        const int next_draw = rng( 0, 1000000 );
        CAPTURE( granted, next_draw );
        CHECK( player.has_trait( stage_three ) == !treated );
        CHECK( granted.size() == ( treated ? 0 : 1 ) );
        REQUIRE( infection.due( player ).has_value() );
        CHECK( *infection.due( player ) >= due + 48_hours );
        CHECK( *infection.due( player ) <= due + 72_hours + 15_minutes );
    }

    SECTION( "a restored delayed intensity change counts the original extra trait" ) {
        for( const char *trait : { "EYEGLEAM", "BLOOD_FUN", "COMMUNE_NIGHT", "DHAMPIR_REDUCED_COLD_TEMPS" } ) {
            player.set_mutation( trait_id( trait ) );
        }
        player.add_effect( sickness, 1_turns, true, 1 );
        player.queued_effect_on_conditions.push( { change_intensity.legacy_id, due, {} } );
        reload_xedra_avatar( player );
        CHECK( change_intensity.due( player ) == due );
        change_intensity.isolate( player );
        calendar::turn = due;
        effect_on_conditions::process_effect_on_conditions( player );
        CHECK( player.get_effect_int( sickness ) == 2 );
        CHECK_FALSE( change_intensity.due( player ).has_value() );
    }

    SECTION( "an existing global task keeps its deadline and uses the world interval on recurrence" ) {
        get_globals().set_global_value( "ps_min_woc", diag_value( 600.0 ) );
        get_globals().set_global_value( "ps_max_woc", diag_value( 900.0 ) );
        player.add_effect( sickness, 1_turns, true, 3 );
        queued_eocs &global = g->queued_global_effect_on_conditions;
        global.push( { avatar_infection.legacy_id, due, {} } );
        reload_xedra_avatar( player );
        CHECK( avatar_infection.due( global ) == due );
        rng_set_engine_seed( 70731 );
        const int expected = rng( 0, 1000000 );
        rng_set_engine_seed( 70731 );
        effect_on_conditions::load_existing_character( player );
        CHECK( rng( 0, 1000000 ) == expected );
        CHECK( avatar_infection.due( global ) == due );
        avatar_infection.isolate( global );
        player.queued_effect_on_conditions = queued_eocs();

        calendar::turn = due;
        rng_set_engine_seed( 70731 );
        effect_on_conditions::process_effect_on_conditions( player );
        CHECK( player.has_trait( stage_three ) );
        REQUIRE( avatar_infection.due( global ).has_value() );
        CHECK( *avatar_infection.due( global ) >= due + 10_minutes );
        CHECK( *avatar_infection.due( global ) <= due + 15_minutes );
    }

    SECTION( "a restored hunger timer warns only at the original blood threshold" ) {
        const int blood = GENERATE( -450, -449 );
        player.set_mutation( trait_VAMPIRE );
        player.add_effect( sickness, 1_turns, true, 1 );
        player.vitamin_set( vitamin_human_blood_vitamin, blood );
        player.queued_effect_on_conditions.push( { hunger.legacy_id, due, {} } );
        reload_xedra_avatar( player );
        CHECK( hunger.due( player ) == due );
        hunger.isolate( player );
        Messages::clear_messages();
        calendar::turn = due;
        rng_set_engine_seed( 70731 );
        effect_on_conditions::process_effect_on_conditions( player );
        const auto recent = Messages::recent_messages( 5 );
        const bool warned = std::any_of( recent.begin(), recent.end(), []( const auto &entry ) {
            return entry.second == "You need to consume human blood to stay alive.";
        } );
        CHECK( warned == ( blood == -450 ) );
        REQUIRE( hunger.due( player ).has_value() );
        CHECK( *hunger.due( player ) >= due + 8_hours );
        CHECK( *hunger.due( player ) <= due + 14_hours + 15_minutes );
    }
}

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
