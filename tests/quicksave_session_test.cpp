#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "debug.h"
#include "event.h"
#include "event_bus.h"
#include "event_subscriber.h"
#include "game.h"
#include "options_helpers.h"
#include "player_helpers.h"
#include "worldfactory.h"

namespace
{
struct save_observer : event_subscriber {
    using event_subscriber::notify;
    void notify( const cata::event &e ) override {
        if( e.type() == event_type::game_save ) {
            ++saves;
        }
    }
    int saves = 0;
};
} // namespace

TEST_CASE( "quicksave_ignores_a_session_still_loading", "[save][regression]" )
{
    REQUIRE( world_generator != nullptr );
    REQUIRE( world_generator->active_world != nullptr );
    restore_on_out_of_scope restore_saves( world_generator->active_world->world_saves );
    world_generator->active_world->world_saves.clear();
    restore_on_out_of_scope restore_should_draw( g->should_draw );
    restore_on_out_of_scope restore_quit( g->uquit );
    restore_on_out_of_scope restore_new_game( g->new_game );
    restore_on_out_of_scope restore_checkpoint( g->dimension_checkpoint_pending );
    g->dimension_checkpoint_pending = GENERATE( false, true );
    const bool pending = g->dimension_checkpoint_pending;
    g->should_draw = true;
    g->uquit = QUIT_NO;
    g->new_game = true;
    save_observer observer;
    get_event_bus().subscribe( &observer );
    CHECK( capture_debugmsg_during( []() {
        g->quicksave();
    } ).empty() );
    CHECK( observer.saves == 0 );
    CHECK( g->dimension_checkpoint_pending == pending );
    CHECK( world_generator->active_world->world_saves.empty() );
}

namespace
{
struct checkpoint_save_started {};

struct stop_checkpoint_before_writing : event_subscriber {
    using event_subscriber::notify;
    void notify( const cata::event &e ) override {
        if( e.type() == event_type::game_save ) {
            throw checkpoint_save_started{};
        }
    }
};
} // namespace

TEST_CASE( "dimension_checkpoint_ignores_periodic_autosave_settings", "[save][dimension]" )
{
    clear_avatar();
    REQUIRE( world_generator != nullptr );
    REQUIRE( world_generator->active_world != nullptr );
    const override_option autosave( "AUTOSAVE", "false" );
    restore_on_out_of_scope restore_should_draw( g->should_draw );
    restore_on_out_of_scope restore_quit( g->uquit );
    restore_on_out_of_scope restore_new_game( g->new_game );
    restore_on_out_of_scope restore_checkpoint( g->dimension_checkpoint_pending );
    g->should_draw = true;
    g->uquit = QUIT_NO;
    g->new_game = false;
    g->dimension_checkpoint_pending = true;
    // Stop at the save event, before any test-world files are written. This
    // also verifies that an interrupted checkpoint remains pending for retry.
    stop_checkpoint_before_writing observer;
    get_event_bus().subscribe( &observer );
    REQUIRE_THROWS_AS( g->save_pending_dimension_checkpoint(), checkpoint_save_started );
    CHECK( g->dimension_checkpoint_pending );

    g->new_game = true;
    CHECK_NOTHROW( g->save_pending_dimension_checkpoint() );
    CHECK( g->dimension_checkpoint_pending );
}
