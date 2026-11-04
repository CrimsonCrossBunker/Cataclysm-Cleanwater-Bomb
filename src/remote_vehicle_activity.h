#pragma once
#ifndef CATA_SRC_REMOTE_VEHICLE_ACTIVITY_H
#define CATA_SRC_REMOTE_VEHICLE_ACTIVITY_H

#include <cstdint>
#include <optional>
#include <string>

#include "activity_actor.h"
#include "item_location.h"
#include "item_source.h"

struct item_activation_choices;
struct vehicle_control_selection;
class vehicle;

bool query_remote_vehicle_choices( Character &who, const item &controller,
                                   item_activation_choices &choices );
bool valid_remote_vehicle_choices( const item_activation_choices &choices );
std::optional<int> begin_remote_vehicle_access( Character &who, item &controller,
        const item_activation_choices &choices );

// The scan belongs to the operator's activity. Save/reload and network retries
// retain its roll; no client supplies a security result or an authorized target.
class remote_vehicle_activity_actor : public activity_actor
{
    public:
        remote_vehicle_activity_actor( item_source controller, int64_t vehicle_id,
                                       bool one_action );
        const activity_id &get_type() const override;
        void start( player_activity &act, Character &who ) override;
        void do_turn( player_activity &act, Character &who ) override;
        void finish( player_activity &act, Character &who ) override;
        void canceled( player_activity &act, Character &who ) override;
        std::unique_ptr<activity_actor> clone() const override;
        void serialize( JsonOut &out ) const override;
        static std::unique_ptr<activity_actor> deserialize( JsonValue &input );

        bool prepare( Character &who );
        bool waiting_for_security() const;
        bool waiting_for_action() const;
        int64_t target_id() const;
        item_location source( Character &who ) const;
        void answer_security( Character &who, bool consent );
        bool apply_action( Character &who, const vehicle_control_selection &selection );
        void run_local( Character &who );

    private:
        item_source controller;
        int64_t vehicle_id = 0;
        bool one_action = false;
        bool advanced_security = false;
        std::optional<int> security_roll;
        bool authorized = false;
        bool access_locked = false;

        vehicle *target( Character &who ) const;
        void complete_control( Character &who );
};

#endif // CATA_SRC_REMOTE_VEHICLE_ACTIVITY_H
