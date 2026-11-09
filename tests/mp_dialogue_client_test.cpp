#include <cstdint>
#include <memory>
#include <string>

#include "avatar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "game.h"
#include "mp_client_conn.h"
#include "mp_gamestate.h"
#include "mp_inventory_activity.h"
#include "mp_queue.h"
#include "mp_world_session.h"
#include "player_helpers.h"

TEST_CASE( "client_dialogue_actions_reject_stale_prompts", "[multiplayer][dialogue]" )
{
    clear_avatar();
    cata_mp::world_session &session = g->multiplayer_session();
    session.reset();
    on_out_of_scope cleanup( [&]() {
        session.reset();
        cata_mp::get_mp_queue().clear();
        clear_avatar();
    } );
    cata_mp::set_client_mode( true );
    REQUIRE( cata_mp::is_client_mode() );
    get_avatar().set_moves( 100 );
    cata_mp::inventory_activity_client_state &view = session.client_inventory_activity;
    view.active = true;
    view.dialogue_prompt = std::make_shared<cata_mp::dialogue_view_prompt>();
    view.dialogue_prompt->session_id = 42;
    view.dialogue_prompt->response_revision = 8;
    view.dialogue_prompt->options.emplace_back();

    const std::string prompt = GENERATE( "current", "old_session", "old_revision" );
    const bool special_action = GENERATE( false, true );
    CAPTURE( prompt, special_action );
    const uint64_t session_id = prompt == "old_session" ? 41 : 42;
    const uint64_t revision = prompt == "old_revision" ? 7 : 8;
    const bool submitted = special_action ?
                           cata_mp::client_dialogue_special_action( session_id, revision, "LOOK_AT" ) :
                           cata_mp::client_choose_dialogue_response( session_id, revision, 0 );
    const bool current = prompt == "current";
    CHECK( submitted == current );
    CHECK( view.next_request == ( current ? 1 : 0 ) );
    CHECK( view.pending_request == ( current ? 1 : 0 ) );
    CHECK( get_avatar().get_moves() == ( current ? 0 : 100 ) );
}
