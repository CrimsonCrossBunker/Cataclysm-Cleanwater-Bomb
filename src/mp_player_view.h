#pragma once
#ifndef CATA_SRC_MP_PLAYER_VIEW_H
#define CATA_SRC_MP_PLAYER_VIEW_H

#include <string>

#include "mp_actor_binding.h"
#include "mp_world_state.h"

class JsonObject;
class JsonOut;
class npc;

namespace cata_mp
{
// A client presentation replica has no player_control and cannot run gameplay.
struct player_view {
    actor_binding actor;
    peer_observation observation;
};

void write_player_view( JsonOut &out, const player_id &id, const npc &actor,
                        const peer_observation &observation, std::string &appearance_baseline );
void apply_player_view( const JsonObject &message, player_view &view );
void remove_player_view( player_view &view );
} // namespace cata_mp

#endif // CATA_SRC_MP_PLAYER_VIEW_H
