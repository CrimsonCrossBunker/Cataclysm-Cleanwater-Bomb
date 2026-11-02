#include "cata_catch.h"

#include <sstream>
#include <string>
#include <utility>

#include "avatar.h"
#include "debug.h"
#include "game.h"
#include "json.h"
#include "map.h"
#include "map_helpers.h"
#include "mp_actor_binding.h"
#include "npc.h"
#include "player_helpers.h"
#include "rng.h"

namespace
{
template<typename T>
std::string saved_character( const T &actor )
{
    std::ostringstream saved;
    JsonOut out( saved );
    actor.serialize( out );
    return saved.str();
}

class control_fixture
{
    public:
        avatar previous = std::move( get_avatar() );
        avatar &local = get_avatar();

        control_fixture() {
            local = avatar();
            clear_avatar();
            clear_map();
            local.setID( g->assign_npc_id(), true );
            local.name = "Local controller";
            local.set_save_id( "local-control-slot" );
            local.ensure_player_id();
            local.setpos( get_map(), tripoint_bub_ms( 60, 60, 0 ) );
        }

        ~control_fixture() {
            clear_npcs();
            local = std::move( previous );
        }

        npc &follower() {
            npc &actor = spawn_npc( point_bub_ms( 61, 60 ), "test_talker" );
            actor.set_fac( faction_id( "your_followers" ) );
            actor.set_attitude( NPCATT_FOLLOW );
            return actor;
        }
};
} // namespace

TEST_CASE( "local_takeover_cannot_steal_a_multiplayer_actor", "[avatar][control][multiplayer]" )
{
    control_fixture fixture;
    npc &remote = fixture.follower();
    const bool debug = GENERATE( false, true );
    const bool player_owned = GENERATE( false, true );
    CAPTURE( debug, player_owned );
    remote.set_value( "mp_proxy", std::string( "1" ) );
    cata_mp::actor_binding binding;
    if( player_owned ) {
        const cata_mp::player_id owner( std::string( 32, '4' ) );
        remote.set_value( "mp_player_id", owner.str() );
        binding.bind_player( remote, owner, g->npc_lifetimes() );
    } else {
        // The host's client-side view has no player credential tag.
        binding.bind_view( remote, g->npc_lifetimes() );
    }
    REQUIRE( remote.is_player_ally() );
    const auto before_local = saved_character( fixture.local );
    const auto before_remote = saved_character( remote );
    const auto before_rng = rng_get_engine();
    const std::string diagnostic = capture_debugmsg_during( [&]() {
        fixture.local.control_npc( remote, debug );
    } );
    CHECK( diagnostic.find( "multiplayer" ) != std::string::npos );
    CHECK( saved_character( fixture.local ) == before_local );
    CHECK( saved_character( remote ) == before_remote );
    CHECK( rng_get_engine() == before_rng );
    CHECK( binding.resolve_loaded( &remote, g->npc_lifetimes() ) == &remote );
}

TEST_CASE( "local_takeover_keeps_the_save_slot_and_exchanges_character_roles", "[avatar][control]" )
{
    control_fixture fixture;
    npc &follower = fixture.follower();
    const auto original = fixture.local.getID();
    const auto player = fixture.local.get_player_id();
    const auto target = follower.getID();
    const auto target_position = follower.pos_abs();
    REQUIRE( original != target );
    fixture.local.control_npc( follower );
    CHECK( fixture.local.getID() == target );
    CHECK( follower.getID() == original );
    CHECK( fixture.local.pos_abs() == target_position );
    CHECK( fixture.local.get_save_id() == "local-control-slot" );
    CHECK( fixture.local.get_player_id() == player );
    // Returning control must preserve the same local save ownership.
    fixture.local.control_npc( follower );
    CHECK( fixture.local.getID() == original );
    CHECK( follower.getID() == target );
    CHECK( fixture.local.get_save_id() == "local-control-slot" );
    CHECK( fixture.local.get_player_id() == player );
}
