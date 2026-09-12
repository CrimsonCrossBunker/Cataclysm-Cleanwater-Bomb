#include "activity_actor_definitions.h"
#include "avatar.h"
#include "cata_catch.h"
#include "item.h"
#include "item_location.h"
#include "iuse.h"
#include "player_activity.h"
#include "player_helpers.h"
#include "type_id.h"
#include "units.h"

static const itype_id itype_water_clean( "water_clean" );

TEST_CASE( "heating_completion_handles_removed_target", "[activity][heating]" )
{
    clear_avatar();
    avatar &guy = get_avatar();
    item_location water = guy.i_add( item( itype_water_clean ) );
    REQUIRE( water );
    heating_requirements cost{ 250_ml, 1, 100 };
    heater source{};
    source.consume_flag = false;
    guy.assign_activity( heat_activity_actor( { { water, 1 } }, cost, source ) );
    water.remove_item();
    REQUIRE_FALSE( water );

    guy.activity.actor->finish( guy.activity, guy );

    CHECK_FALSE( guy.activity );
    CHECK( guy.backlog.empty() );
}

TEST_CASE( "heating_completion_handles_removed_heater", "[activity][heating]" )
{
    clear_avatar();
    avatar &guy = get_avatar();
    item_location water = guy.i_add( item( itype_water_clean ) );
    REQUIRE( water );
    const int charges = water->charges;
    heating_requirements cost{ 250_ml, 1, 100 };
    heater source{};
    source.consume_flag = true;
    // A heater location may become invalid while the activity completes.
    guy.assign_activity( heat_activity_actor( { { water, 1 } }, cost, source ) );

    guy.activity.actor->finish( guy.activity, guy );

    CHECK_FALSE( guy.activity );
    REQUIRE( water );
    CHECK( water->charges == charges );
}
