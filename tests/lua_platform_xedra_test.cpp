#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "effect.h"
#include "enums.h"
#include "item.h"
#include "lua_platform_runtime.h"
#include "math_parser_diag_value.h"
#include "player_helpers.h"
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
static const itype_id itype_vampire_blood( "vampire_blood" );
static const efftype_id effect_anathema_need_vampire_blood( "effect_anathema_need_vampire_blood" );
static const efftype_id effect_recent_vampire_drink( "effect_recent_vampire_drink" );
static const efftype_id effect_vampire_virus( "vampire_virus" );
static const morale_type morale_drank_blood( "morale_drank_blood" );
static const trait_id trait_ANATHEMA_WEAKNESS_MIND_CHAOS( "ANATHEMA_WEAKNESS_MIND_CHAOS" );
static const trait_id trait_ANATHEMA_WEAKNESS_NEED_VAMPIRE_BLOOD( "ANATHEMA_WEAKNESS_NEED_VAMPIRE_BLOOD" );
static const trait_id trait_BLOOD_FUN( "BLOOD_FUN" );
static const trait_id trait_BLOOD_FUN_UPGRADE( "BLOOD_FUN_UPGRADE" );
static const trait_id trait_VAMPIRE( "VAMPIRE" );
static const trait_id trait_VAMPIRE_ANATHEMA( "VAMPIRE_ANATHEMA" );
static const trait_id trait_VAMPIRE_DRINK_VAMPIRE_BLOOD( "VAMPIRE_DRINK_VAMPIRE_BLOOD" );
static const trait_id trait_VAMPIRE_WEAKNESS_NEED_HUMAN_BLOOD( "VAMPIRE_WEAKNESS_NEED_HUMAN_BLOOD" );
static const vitamin_id vitamin_human_blood_vitamin( "human_blood_vitamin" );
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
#endif
