#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "enums.h"
#include "item.h"
#include "lua_platform_runtime.h"
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
#endif
