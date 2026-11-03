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
    const auto inserted = session.remote_players.emplace( peer_id, std::move( peer ) );
    REQUIRE( inserted.second );
    return *inserted.first->second;
}

inline cata_mp::remote_player_session &only_test_remote( cata_mp::world_session &session )
{
    REQUIRE( session.remote_players.size() == 1 );
    return *session.remote_players.begin()->second;
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
