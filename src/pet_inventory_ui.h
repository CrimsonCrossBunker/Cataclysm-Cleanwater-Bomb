#pragma once
#ifndef CATA_SRC_PET_INVENTORY_UI_H
#define CATA_SRC_PET_INVENTORY_UI_H

#include <cstdint>
#include <memory>
#include <optional>
#include <string>
#include <utility>
#include <vector>

#include "activity_actor.h"
#include "character_id.h"
#include "item_location.h"
#include "pet_slot.h"
#include "ret_val.h"
#include "type_id.h"

class Character;
class JsonObject;
class item;
class monster;

namespace pet_inventory_ui
{
struct transfer_request {
    bool to_pet = true;
    item_location source;
    int64_t cargo_uid = 0;
    int quantity = 1;

    void serialize( JsonOut &json ) const;
    void deserialize( const JsonObject &json );
};

ret_val<void> transfer_item( Character &who, monster &pet, const transfer_request &request );

class transfer_activity_actor : public activity_actor
{
    public:
        transfer_activity_actor() = default;
        transfer_activity_actor( int64_t pet_uid, character_id operator_id,
                                 std::vector<transfer_request> requests ) :
            pet_uid( pet_uid ), operator_id( operator_id ), requests( std::move( requests ) ) {}

        const activity_id &get_type() const override;
        void start( player_activity &act, Character &who ) override;
        void do_turn( player_activity &act, Character &who ) override;
        void finish( player_activity &act, Character &who ) override;
        std::unique_ptr<activity_actor> clone() const override {
            return std::make_unique<transfer_activity_actor>( *this );
        }
        void serialize( JsonOut &json ) const override;
        static std::unique_ptr<activity_actor> deserialize( JsonValue &json );

    private:
        int64_t pet_uid = 0;
        character_id operator_id;
        std::vector<transfer_request> requests;
        int next_request = 0;
};

std::string load_summary( const monster &pet, const Character &who );
ret_val<void> install_equipment( Character &who, monster &pet, const pet_slot_id &slot,
                                 item_location source );
/** The first missing tool quality needed to install an item, if any. */
std::optional<std::pair<quality_id, int>> missing_install_quality( const Character &who,
                                       const item &equipment );
void show_equipment( monster &pet );
void show_transfer( monster &pet );
} // namespace pet_inventory_ui

#endif // CATA_SRC_PET_INVENTORY_UI_H
