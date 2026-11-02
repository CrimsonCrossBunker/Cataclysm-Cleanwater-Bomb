#include "item_rot.h"

#include <algorithm>
#include <cmath>

#include "game_constants.h"

float hourly_item_rotpoints( const units::temperature &temp, bool cryogenic )
{
    const units::temperature dropoff = units::from_fahrenheit( 38 ); // F, ~3 C
    const float max_rot_temp = 105; // F, ~41 C, Maximum rotting rate is at this temperature
    const float safe_temp = 145; // F, ~63 C, threshold above which rot is severely slowed

    // Cryogenic rot is much simpler, rot simply idicates how many turns the item might survive outside of cryogenic storage, so they rot as if temperature was 65F.
    if( cryogenic && temp > units::from_fahrenheit( -320 ) ) {
        return 3600.f;
    }
    if( temp <= temperatures::freezing ) {
        return 0.f;
    } else if( temp < dropoff ) {
        // ditch our fancy equation and do a linear approach to 0 rot from 38 F (3 C) -> 32 F (0 C)
        return 600.f * std::exp2( -27.f / 16.f ) * ( units::to_fahrenheit( temp ) - units::to_fahrenheit(
                    temperatures::freezing ) );
    } else if( temp < units::from_fahrenheit( max_rot_temp ) ) {
        // Exponential progress from 38 F (3 C) to 105 F (41 C)
        // Max rot from 105 F (41 C) is approximately 20364.67 rot/hour
        return 3600.f * std::exp2( ( units::to_fahrenheit( temp ) - 65.f ) / 16.f );
    } else {
        // Exponential decay from 105 F to 145 F
        // Rate halves every 8 F (~4.44 C) above 105 F, min approach 636 rot/hour
        // Constant very slowly rot from 145 F (63 C) upwards.
        const float capped_temp = std::min( units::to_fahrenheit( temp ), safe_temp );
        return 3600.f * std::exp2( ( max_rot_temp - 65.f ) / 16.f
                                   - ( capped_temp - max_rot_temp ) / 8.f );
    }
}
