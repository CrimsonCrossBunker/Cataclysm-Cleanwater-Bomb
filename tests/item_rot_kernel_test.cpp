#include <algorithm>
#include <cmath>

#include "cata_catch.h"
#include "game_constants.h"
#include "item_rot.h"

TEST_CASE( "captured_rot_rates_match_legacy_formula", "[rot][threading]" )
{
    for( int fahrenheit = -340; fahrenheit <= 200; ++fahrenheit ) {
        const auto temp = units::from_fahrenheit( fahrenheit );
        float expected = 0;
        if( temp > temperatures::freezing ) {
            if( temp < units::from_fahrenheit( 38 ) ) {
                expected = 600.f * std::exp2( -27.f / 16.f ) *
                           ( units::to_fahrenheit( temp ) - units::to_fahrenheit( temperatures::freezing ) );
            } else if( temp < units::from_fahrenheit( 105 ) ) {
                expected = 3600.f * std::exp2( ( units::to_fahrenheit( temp ) - 65.f ) / 16.f );
            } else {
                expected = 3600.f * std::exp2( ( 105.f - 65.f ) / 16.f -
                                              ( std::min( units::to_fahrenheit( temp ), 145.f ) - 105.f ) / 8.f );
            }
        }
        CAPTURE( fahrenheit );
        CHECK( hourly_item_rotpoints( temp, false ) == expected );
        CHECK( hourly_item_rotpoints( temp, true ) ==
               ( temp > units::from_fahrenheit( -320 ) ? 3600.f : expected ) );
    }
}
