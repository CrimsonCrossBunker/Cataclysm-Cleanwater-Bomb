#include <string>

#include "clone_ptr.h"
#include "activity_actor.h"
#include "activity_actor_definitions.h"
#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "dialogue.h"
#include "flexbuffer_json.h"
#include "json_loader.h"
#include "npc.h"
#include "player_activity.h"
#include "player_helpers.h"
#include "type_id.h"

static const activity_id ACT_GENERIC_GAME( "ACT_GENERIC_GAME" );

TEST_CASE( "dialogue_starts_tabletop_game_actor", "[npc][activity][dialogue]" )
{
    avatar &you = get_avatar();
    clear_character( you );
    calendar::turn = calendar::turn_zero;
    npc partner;
    dialogue d( get_talker_for( you ), get_talker_for( partner ) );
    const JsonObject definition = json_loader::from_string( R"({
        "effect": { "u_assign_activity": "ACT_GENERIC_GAME", "duration": "45 minutes" }
    })" ).get_object();
    const talk_effect_t effect( definition, "effect", "test_data" );
    effect.apply( d );
    REQUIRE( you.activity.id() == ACT_GENERIC_GAME );
    REQUIRE( dynamic_cast<tabletop_game_activity_actor *>( you.activity.actor.get() ) != nullptr );
    CHECK( you.activity.moves_total == to_moves<int>( 45_minutes ) );
    CHECK( you.activity.moves_left == you.activity.moves_total );
    you.activity.actor->do_turn( you.activity, you );
    CHECK( you.get_morale_level() > 0 );
    you.activity.actor->finish( you.activity, you );
    CHECK_FALSE( you.activity );
}

