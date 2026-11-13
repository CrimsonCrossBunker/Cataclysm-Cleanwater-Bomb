#pragma once
#ifndef CATA_SRC_MP_PLAYER_VIEW_H
#define CATA_SRC_MP_PLAYER_VIEW_H

#include <string>
#include <vector>

#include "character_id.h"
#include "mp_actor_binding.h"
#include "mp_world_state.h"
#include "type_id.h"

class Character;
class JsonArray;
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

struct npc_view {
    actor_binding actor;
    character_id host_id;
};

struct radio_contact_view {
    character_id host_id;
    faction_id faction;
    std::string name;
};

character_id host_npc_identity( const npc &actor );
void write_player_view( JsonOut &out, const player_id &id, const npc &actor,
                        const peer_observation &observation, std::string &appearance_baseline );
void apply_player_view( const JsonObject &message, player_view &view );
void remove_player_view( player_view &view );

void write_npc_view( JsonOut &out, const npc &actor, const Character &viewer,
                     std::string &appearance_baseline );
void apply_npc_view( const JsonObject &message, npc_view &view );
void remove_npc_view( npc_view &view );

void write_mission_view( JsonOut &out, const Character &who );
void apply_mission_view( const JsonObject &message, Character &who );
void write_radio_contacts( JsonOut &out, const Character &who );
void apply_radio_contacts( const JsonArray &message, std::vector<radio_contact_view> &contacts );
} // namespace cata_mp

#endif // CATA_SRC_MP_PLAYER_VIEW_H
