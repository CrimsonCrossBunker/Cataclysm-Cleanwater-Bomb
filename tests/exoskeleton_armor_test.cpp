#include <initializer_list>
#include <string>
#include <vector>

#include "cata_catch.h"
#include "item.h"
#include "subbodypart.h"
#include "type_id.h"

TEST_CASE( "exoskeleton_reinforcement_preserves_plate_protection",
           "[item][armor][exoskeleton_reinforcement]" )
{
    const std::string weight = GENERATE( "light", "medium", "heavy" );
    const std::string part = GENERATE( "head", "torso", "arm", "leg" );
    const std::string id = "combat_exoskeleton_armor_" + part + "_" + weight;
    const item original{ itype_id( id ) };
    const item reinforced{ itype_id( id + "_reinforced" ) };
    const std::vector<sub_bodypart_id> covered = original.get_covered_sub_body_parts();
    REQUIRE_FALSE( covered.empty() );

    bool improved_protection = false;
    for( const sub_bodypart_id &bp : covered ) {
        for( const std::string &damage : {
                 "bash", "cut", "bullet"
             } ) {
            // Compare the same impact on the same body part, including plate gaps.
            // Adding chainmail must not reduce the protection of the original plate.
            for( int roll = 0; roll <= 100; ++roll ) {
                CAPTURE( id, bp, damage, roll );
                const float before = original.resist( damage_type_id( damage ), false, bp, roll );
                const float after = reinforced.resist( damage_type_id( damage ), false, bp, roll );
                CHECK( after >= before );
                improved_protection |= after > before;
            }
        }
    }
    CHECK( improved_protection );
}
