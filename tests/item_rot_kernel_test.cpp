#include <algorithm>
#include <array>

#include "cata_catch.h"
#include "game_constants.h"
#include "item_rot.h"

TEST_CASE( "daily_rot_batch_preserves_scalar_rounding", "[item][rot][threading]" )
{
    for( const int fahrenheit : { -321, -10, 32, 35, 38, 65, 105, 145, 180 } ) {
        for( const float modifier : { 0.0f, 0.125f, 0.7f, 1.0f } ) {
            for( const time_duration elapsed : { 601_seconds, 937_seconds, 1_hours } ) {
                for( unsigned flags = 0; flags < 8; ++flags ) {
                    const item_rot_input input{ units::from_fahrenheit( fahrenheit ), modifier,
                                                elapsed, bool( flags & 1 ), bool( flags & 2 ), bool( flags & 4 ) };
                    const auto increments = calculate_item_rot_increments( input );
                    for( unsigned mushy = 0; mushy < 2; ++mushy ) {
                        for( unsigned cold = 0; cold < 2; ++cold ) {
                            float factor = modifier;
                            if( input.field_dressed ) {
                                factor *= 0.75;
                            }
                            if( mushy ) {
                                factor *= 3.0;
                            }
                            if( input.irradiated ) {
                                factor *= 0.25;
                            }
                            const auto temperature = cold ? std::min( temperatures::fridge, input.temperature ) :
                                                     input.temperature;
                            const float rate = hourly_item_rotpoints( temperature, input.cryogenic );
                            const time_duration expected = factor * elapsed / 1_seconds * rate * 1_turns /
                                                           ( 1_hours / 1_seconds );
                            CHECK( to_turns<int>( increments[mushy * 2 + cold] ) == to_turns<int>( expected ) );
                        }
                    }
                }
            }
        }
    }
}

TEST_CASE( "daily_rot_snapshot_detects_changed_inputs", "[item][rot][threading]" )
{
    const item_rot_input input{ units::from_fahrenheit( 65 ), 0.7f, 937_seconds,
                                false, false, false };
    item_rot_input changed = input;
    CHECK( changed == input );
    changed.temperature += units::from_kelvin_delta( 1 );
    CHECK_FALSE( changed == input );
    changed = input;
    changed.spoil_modifier = 1;
    CHECK_FALSE( changed == input );
    changed = input;
    changed.elapsed += 1_seconds;
    CHECK_FALSE( changed == input );
    changed = input;
    changed.field_dressed = true;
    CHECK_FALSE( changed == input );
    changed = input;
    changed.irradiated = true;
    CHECK_FALSE( changed == input );
    changed = input;
    changed.cryogenic = true;
    CHECK_FALSE( changed == input );
}
