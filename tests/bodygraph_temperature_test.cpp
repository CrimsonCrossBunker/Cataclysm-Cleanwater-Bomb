#include "bodygraph.h"
#include "cata_catch.h"
#include "units.h"

TEST_CASE( "bodygraph_decodes_legacy_bodypart_temperature",
           "[bodygraph][temperature][upstream_ports]" )
{
    const int legacy = GENERATE( 4500, 5000, 6250 );
    bodygraph_info info;
    info.temperature.first = legacy;
    const double expected_celsius = 37.0 + ( legacy - 5000 ) * 0.002;
    CHECK( units::to_celsius( info.body_temperature() ) == Approx( expected_celsius ) );
    CHECK( units::to_fahrenheit( info.body_temperature() ) ==
           Approx( expected_celsius * 1.8 + 32.0 ) );
}
