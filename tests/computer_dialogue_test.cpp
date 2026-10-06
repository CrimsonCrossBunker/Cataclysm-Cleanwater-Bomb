#include <functional>
#include <initializer_list>
#include <memory>
#include <optional>
#include <string>
#include <vector>

#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "computer.h"
#include "coordinates.h"
#include "game.h"
#include "item_location.h"
#include "map.h"
#include "map_helpers.h"
#include "math_parser_diag_value.h"
#include "player_helpers.h"
#include "point.h"
#include "talker.h"
#include "type_id.h"
#include "worldfactory.h"

static const dimension_id dimension_netherum_labyrinth_safehouse( "netherum_labyrinth_safehouse" );

TEST_CASE( "terminal_dialogue_survives_unloading_its_computer", "[dialogue][computer][dimension]" )
{
    const tripoint_abs_ms position( 120, 240, -2 );
    auto terminal = std::make_unique<computer>( "Labyrinth terminal", 0, position );
    auto speaker = get_talker_for( *terminal );
    auto cloned_speaker = speaker->clone();
    speaker->set_value( "test", diag_value( "before travel" ) );
    REQUIRE( terminal->maybe_get_value( "test" ) );
    CHECK( speaker->get_computer() == terminal.get() );
    CHECK( speaker->pos_abs_omt() == project_to<coords::omt>( position ) );

    terminal.reset();
    for( talker *talker : {
             speaker.get(), cloned_speaker.get()
         } ) {
        CHECK( talker->get_computer() == nullptr );
        CHECK( talker->get_const_computer() == nullptr );
        CHECK( talker->disp_name() == "Labyrinth terminal" );
        CHECK( talker->pos_abs() == position );
        CHECK( talker->pos_bub( get_map() ) == get_map().get_bub( position ) );
        CHECK( talker->maybe_get_value( "test" ) == nullptr );
        CHECK( talker->get_topics( false ).empty() );
        talker->set_value( "test", diag_value( "after travel" ) );
        talker->remove_value( "test" );
    }
}

TEST_CASE( "dimension_travel_invalidates_the_departed_terminal_safely",
           "[dialogue][computer][dimension]" )
{
    clear_avatar();
    clear_map_without_vision();
    REQUIRE( world_generator->active_world );
    restore_on_out_of_scope restore_saves( world_generator->active_world->world_saves );
    world_generator->active_world->world_saves.clear();
    const dimension_id origin = g->get_dimension_prefix();
    const bool previous_checkpoint = g->dimension_checkpoint_pending;
    on_out_of_scope return_home( [&]() {
        if( g->get_dimension_prefix() != origin ) {
            g->travel_to_dimension( origin, {}, {}, std::nullopt, nullptr );
        }
        g->dimension_checkpoint_pending = previous_checkpoint;
    } );
    map &here = get_map();
    const tripoint_bub_ms position( 60, 60, 0 );
    computer *terminal = here.add_computer( position, "Labyrinth terminal", 0 );
    REQUIRE( terminal );
    const tripoint_abs_ms original_position = terminal->loc;
    auto speaker = get_talker_for( *terminal );

    REQUIRE( g->travel_to_dimension( dimension_netherum_labyrinth_safehouse, {}, {},
                                     std::nullopt, nullptr ) );

    CHECK( g->dimension_checkpoint_pending );
    CHECK( speaker->get_computer() == nullptr );
    CHECK( speaker->disp_name() == "Labyrinth terminal" );
    CHECK( speaker->pos_abs() == original_position );
    CHECK( speaker->maybe_get_value( "departed" ) == nullptr );
}
