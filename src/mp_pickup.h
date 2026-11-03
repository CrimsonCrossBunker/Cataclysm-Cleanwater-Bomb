#pragma once
#ifndef CATA_SRC_MP_PICKUP_H
#define CATA_SRC_MP_PICKUP_H

#include <cstdint>
#include <optional>
#include <string>

class Character;
class JsonObject;
class map;
namespace Pickup
{
struct selection;
}

namespace cata_mp
{
// These are simulation-owned admission-local values, not worker state.
struct pickup_host_state {
    int64_t revision = 0;
    int64_t last_request = 0;
    std::string last_result;
};

struct pickup_client_state {
    int64_t revision = 0;
    int64_t next_request = 0;
    int64_t pending_request = 0;
};

std::optional<std::string> make_pickup_request( const Pickup::selection &selection,
        const map &here, pickup_client_state &state );
std::string execute_pickup_request( Character &who, map &here, const JsonObject &request,
                                    pickup_host_state &state );
bool apply_pickup_result( Character &who, const JsonObject &result, pickup_client_state &state );
bool pickup_inventory_revision_matches( const JsonObject &message, const pickup_host_state &state );
} // namespace cata_mp

#endif // CATA_SRC_MP_PICKUP_H
