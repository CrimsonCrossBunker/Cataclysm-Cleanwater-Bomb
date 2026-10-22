#pragma once
#ifndef CATA_SRC_MOUNTED_CHARGE_H
#define CATA_SRC_MOUNTED_CHARGE_H

#include <algorithm>
#include <string>

class JsonObject;

/** Typed, opt-in data for a weapon that can start a mounted charge. */
struct mounted_charge_profile {
    // Maximum selectable range in map tiles, defined by the weapon's JSON.
    int max_steps = 0;
    std::string damage_type = "stab";
    float multiplier_per_step = 0.10f;
    float max_multiplier = 1.50f;

    void deserialize( const JsonObject &jo );

    bool valid() const {
        return max_steps > 0 &&
               ( damage_type == "stab" || damage_type == "cut" ) &&
               multiplier_per_step >= 0.0f && multiplier_per_step <= 0.5f &&
               max_multiplier >= 1.0f && max_multiplier <= 2.0f;
    }
};

inline float mounted_charge_multiplier( const mounted_charge_profile &profile,
                                        int completed_steps, int mount_speed )
{
    if( completed_steps <= 0 ) {
        return 1.0f;
    }

    const float speed_factor = std::clamp( static_cast<float>( mount_speed ) / 200.0f,
                                           0.5f, 1.5f );
    return std::min( profile.max_multiplier,
                     1.0f + profile.multiplier_per_step *
                     std::min( 5.0f, completed_steps * speed_factor ) );
}

inline float mounted_charge_stab_multiplier( const mounted_charge_profile &profile,
        int completed_steps, int mount_speed )
{
    return profile.damage_type == "stab" ?
           mounted_charge_multiplier( profile, completed_steps, mount_speed ) : 1.0f;
}

#endif // CATA_SRC_MOUNTED_CHARGE_H
