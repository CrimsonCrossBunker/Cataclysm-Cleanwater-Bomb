#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "debug.h"
#include "event.h"
#include "event_bus.h"
#include "event_subscriber.h"
#include "game.h"
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
    g->should_draw = true;
    g->uquit = QUIT_NO;
    g->new_game = true;
    save_observer observer;
    get_event_bus().subscribe( &observer );
    CHECK( capture_debugmsg_during( []() {
        g->quicksave();
    } ).empty() );
    CHECK( observer.saves == 0 );
    CHECK( world_generator->active_world->world_saves.empty() );
}
