#pragma once
#ifndef CATA_TESTS_MP_TEST_HELPERS_H
#define CATA_TESTS_MP_TEST_HELPERS_H

#include "cata_catch.h"
#include "mp_world_session.h"

inline cata_mp::remote_player_session &make_test_remote( cata_mp::world_session &session,
        uint64_t peer_id = 701 )
{
    auto peer = std::make_unique<cata_mp::remote_player_session>();
    peer->admission = cata_mp::peer_admission::create( peer_id );
    peer->turn.grant_seq = 1;
    peer->turn.remote_moves = 100;
    const auto inserted = session.remote_players.emplace( peer_id, std::move( peer ) );
    REQUIRE( inserted.second );
    return *inserted.first->second;
}

inline cata_mp::remote_player_session &only_test_remote( cata_mp::world_session &session )
{
    REQUIRE( session.remote_players.size() == 1 );
    return *session.remote_players.begin()->second;
}

// Build the wire envelope for a deliberately selected fixture grant.
inline std::string test_granted_action( const std::string &message, uint32_t sequence )
{
    REQUIRE( !message.empty() );
    REQUIRE( message.back() == '}' );
    return message.substr( 0, message.size() - 1 ) + ",\"grant_seq\":" +
           std::to_string( sequence ) + "}";
}

inline void next_test_remote_turn( cata_mp::remote_player_session &peer )
{
    ++peer.turn.grant_seq;
    peer.turn.remote_moves = 100;
    peer.turn.granted_this_turn = true;
    peer.turn.client_acted_this_turn = false;
}

// Fixture setup only. Runtime reconnect coverage uses the real queued connect.
inline void set_test_admission( cata_mp::world_session &session,
                                const cata_mp::peer_admission &admission )
{
    REQUIRE( session.remote_players.size() == 1 );
    auto peer = session.remote_players.extract( session.remote_players.begin() );
    peer.key() = admission.peer_id();
    peer.mapped()->admission = admission;
    REQUIRE( session.remote_players.insert( std::move( peer ) ).inserted );
}

#endif // CATA_TESTS_MP_TEST_HELPERS_H
