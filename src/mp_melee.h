#pragma once
#ifndef CATA_SRC_MP_MELEE_H
#define CATA_SRC_MP_MELEE_H

#include <string>
#include "coordinates.h"
#include "type_id.h"

class Character;
class JsonObject;
class map;

namespace cata_mp
{
struct pickup_host_state;
struct pickup_client_state;

enum class melee_action { strike, reach, technique };
struct melee_intent {
    melee_action action = melee_action::strike;
    tripoint_abs_ms origin;
    tripoint_abs_ms target;
    matec_id technique;
    bool allow_collateral = false;
};
// Actor and map are authoritative. No client damage/stats are inputs.
void execute_melee_intent( Character &actor, map &here, const melee_intent &intent );
std::string make_melee_result( const Character &actor, pickup_host_state &state );
bool apply_melee_result( Character &actor, const JsonObject &message, pickup_client_state &state );
} // namespace cata_mp
#endif // CATA_SRC_MP_MELEE_H
