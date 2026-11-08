#pragma once
#ifndef CATA_SRC_MP_PLAYER_IDENTITY_H
#define CATA_SRC_MP_PLAYER_IDENTITY_H

#include <string>

#include "player_identity.h"

namespace cata_mp
{
// Local profiles and remote principals use the same native identity type.
using ::player_id;

// A local profile owns this bearer capability. Never log it or include it in
// replicated character data. The authoritative host stores it privately.
struct player_credentials {
    player_id id;
    std::string resume_secret;
    bool valid() const;
};

// Does not use the simulation RNG. The caller must persist before use.
player_credentials create_player_credentials();
} // namespace cata_mp

#endif // CATA_SRC_MP_PLAYER_IDENTITY_H
