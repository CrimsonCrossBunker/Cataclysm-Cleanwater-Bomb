#pragma once
#ifndef CATA_SRC_MP_EQUIPMENT_H
#define CATA_SRC_MP_EQUIPMENT_H

#include <cstdint>
#include <optional>
#include <string>

#include "coordinates.h"
#include "item_disposition.h"
#include "mp_item_source.h"

class Character;
class item_location;
class JsonObject;
class JsonOut;
class map;

namespace cata_mp
{
struct equipment_intent {
    std::string operation;
    tripoint_abs_ms origin;
    item_source source;
    int64_t wielded = 0;
    bool allow_theft = false;
    bool unseal = false;
    std::optional<item_disposition> disposition;

    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &object );
};

equipment_intent make_equipment_intent( const Character &who, item_location source,
                                        const std::string &operation, bool unseal = false );
bool execute_equipment_intent( Character &who, map &here, const equipment_intent &intent );
// Only selection/consent on the client; inventory and callbacks stay on the host.
void client_select_equipment( const std::string &operation, item_location source,
                              bool unseal = false );
void client_request_equipment( const equipment_intent &intent );
} // namespace cata_mp
#endif // CATA_SRC_MP_EQUIPMENT_H
