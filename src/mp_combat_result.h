#pragma once
#ifndef CATA_SRC_MP_COMBAT_RESULT_H
#define CATA_SRC_MP_COMBAT_RESULT_H

#include <string>

class Character;
class JsonObject;
namespace cata_mp
{
struct pickup_host_state;
struct pickup_client_state;
// Owner-produced combat state. Replica application never reruns effect hooks.
std::string make_combat_result( const Character &actor, pickup_host_state &state );
bool apply_combat_result( Character &actor, const JsonObject &message, pickup_client_state &state );
// Restore a returning player's carried items and needs before accepting uploads
// from that connection. The inventory revision rejects its stale local save.
std::string make_player_resume_result( const Character &actor, pickup_host_state &state );
bool apply_player_resume_result( Character &actor, const JsonObject &message,
                                 pickup_client_state &state );
} // namespace cata_mp
#endif // CATA_SRC_MP_COMBAT_RESULT_H
