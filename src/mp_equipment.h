#pragma once
#ifndef CATA_SRC_MP_EQUIPMENT_H
#define CATA_SRC_MP_EQUIPMENT_H

#include <cstddef>
#include <cstdint>
#include <optional>
#include <string>
#include <vector>

#include "coordinates.h"
#include "item_disposition.h"
#include "mp_item_source.h"

class Character;
class item_location;
class JsonObject;
class JsonOut;
class map;
class player_activity;

namespace cata_mp
{
constexpr size_t max_wear_selection = 128;

struct equipment_intent {
    std::string operation;
    tripoint_abs_ms origin;
    item_source source;
    int64_t wielded = 0;
    bool allow_theft = false;
    bool unseal = false;
    std::optional<item_disposition> disposition;
    int quantity = 0;

    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &object );
};

equipment_intent make_equipment_intent( const Character &who, item_location source,
                                        const std::string &operation, bool unseal = false );
bool execute_equipment_intent( Character &who, map &here, const equipment_intent &intent );
bool start_owned_wear( Character &who, map &here, std::vector<equipment_intent> selection );
void do_owned_wear( player_activity &activity, Character &who, std::vector<equipment_intent> &pending );
// Only selection/consent on the client; inventory and callbacks stay on the host.
void client_select_equipment( const std::string &operation, item_location source,
                              bool unseal = false, int quantity = 0 );
void client_select_wear( const std::vector<item_location> &sources, const std::vector<int> &quantities );
void client_request_equipment( const equipment_intent &intent );
} // namespace cata_mp
#endif // CATA_SRC_MP_EQUIPMENT_H
