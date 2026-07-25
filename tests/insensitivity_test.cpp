#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character_id.h"
#include "event.h"
#include "event_bus.h"
#include "game.h"
#include "player_helpers.h"
#include "type_id.h"

static const efftype_id effect_sleep( "sleep" );
static const mtype_id mon_zombie( "mon_zombie" );
static const trait_id trait_insensitivity( "INSENSITIVITY" );

TEST_CASE( "insensitivity_is_awarded_when_the_player_wakes_after_accumulating_behavior",
           "[character][mutation][insensitivity]" )
{
    avatar &u = get_avatar();
    clear_character( u );
    u.clear_mutations();

    restore_on_out_of_scope restore_turn( calendar::turn );
    restore_on_out_of_scope restore_start( calendar::start_of_cataclysm );
    calendar::start_of_cataclysm = calendar::turn_zero;
    calendar::turn = calendar::turn_zero + 30_days;

    // Feed monster kills through the same event path used by the kill tracker.
    for( int i = 0; i < 100; ++i ) {
        get_event_bus().send<event_type::character_kills_monster>( u.getID(), mon_zombie, 0 );
    }

    // These are behavior-metric recording points used by the guilt, butchery, and consumption
    // code paths.  The exact score arithmetic is intentionally not tested here.
    for( int i = 0; i < 200; ++i ) {
        u.record_mental_metric_guilt_kill();
    }
    u.record_mental_metric_human_dissection();
    u.record_mental_metric_cannibalism();

    // Reaching the score must not grant the trait from an individual recording call.
    CHECK_FALSE( u.has_trait( trait_insensitivity ) );

    // The normal acquisition point is waking up; this also covers the deferred-check behavior.
    u.add_effect( effect_sleep, 1_hours );
    u.wake_up();

    CHECK( u.has_trait( trait_insensitivity ) );
}
