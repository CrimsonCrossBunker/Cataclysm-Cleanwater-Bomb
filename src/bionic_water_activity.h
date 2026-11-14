#pragma once
#ifndef CATA_SRC_BIONIC_WATER_ACTIVITY_H
#define CATA_SRC_BIONIC_WATER_ACTIVITY_H

#include <optional>

#include "activity_actor.h"
#include "item.h"
#include "item_location.h"
#include "item_source.h"
#include "units.h"

struct unload_liquid_choice;

item_location resolve_bionic_water_source( Character &who, const item_source &source );
std::optional<item_source> query_bionic_water_source( Character &who );
bool run_local_bionic_water( Character &who );

// Water remains on the corpse between choices. The activity owns only source
// identity and the once-per-activation charge, including cancellation refunds.
class bionic_water_activity_actor : public activity_actor
{
    public:
        bionic_water_activity_actor( item_source source, unsigned int uid, units::energy cost );
        const activity_id &get_type() const override;
        void start( player_activity &act, Character &who ) override;
        void do_turn( player_activity &act, Character &who ) override;
        void finish( player_activity &act, Character &who ) override;
        void canceled( player_activity &act, Character &who ) override;
        std::unique_ptr<activity_actor> clone() const override;
        void serialize( JsonOut &out ) const override;
        static std::unique_ptr<activity_actor> deserialize( JsonValue &input );

        bool prepare( Character &who );
        std::optional<item> preview( Character &who ) const;
        int64_t source_uid() const;
        bool apply_choice( Character &who, const unload_liquid_choice &choice,
                           bool allow_consequences );

    private:
        item_source corpse;
        unsigned int bionic_uid = 0;
        units::energy refundable_power = 0_kJ;
};

#endif // CATA_SRC_BIONIC_WATER_ACTIVITY_H
