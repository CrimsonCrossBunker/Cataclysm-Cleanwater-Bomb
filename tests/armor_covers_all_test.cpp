#include <array>
#include <set>
#include <string>
#include <vector>

#include "bodypart.h"
#include "cata_catch.h"
#include "item.h"
#include "itype.h"
#include "subbodypart.h"
#include "type_id.h"

static const itype_id itype_artifact_energy_shield( "artifact_energy_shield" );
static const itype_id itype_debug_energy_shield( "debug_energy_shield" );
static const itype_id itype_integrated_interstice_aura( "integrated_interstice_aura" );

static const sub_bodypart_str_id sub_body_part_torso_upper( "torso_upper" );

TEST_CASE( "covers_all_does_not_double_count_overlapping_sublocations", "[armor][coverage]" )
{
    armor_portion_data portion;
    for( const sub_bodypart_str_id &sublocation : body_part_torso->sub_parts ) {
        portion.sub_coverage.insert( sublocation );
    }
    REQUIRE( portion.max_coverage( body_part_torso ) > 100 );

    portion.covers_all = true;
    CHECK( portion.max_coverage( body_part_torso ) == 100 );

    SECTION( "excluded_sublocations_do_not_restore_full_coverage" ) {
        portion.sub_coverage = { sub_body_part_torso_upper };
        CHECK( portion.max_coverage( body_part_torso ) == sub_body_part_torso_upper->max_coverage );
    }
    SECTION( "excluding_all_sublocations_preserves_zero_coverage" ) {
        portion.sub_coverage.clear();
        CHECK( portion.max_coverage( body_part_torso ) == 0 );
    }
}

TEST_CASE( "covers_all_shields_and_aura_have_full_body_coverage", "[armor][coverage]" )
{
    const std::array<itype_id, 3> armor_types = {
        itype_artifact_energy_shield, itype_debug_energy_shield, itype_integrated_interstice_aura
    };
    for( const itype_id &armor_type : armor_types ) {
        const item armor( armor_type );
        for( const body_part_type &body_part : body_part_type::get_all() ) {
            CAPTURE( armor_type, body_part.id );
            CHECK( armor.get_coverage( body_part.id.id() ) == 100 );
            CHECK( armor.get_coverage( body_part.id.id(), item::cover_type::COVER_MELEE ) == 100 );
            CHECK( armor.get_coverage( body_part.id.id(), item::cover_type::COVER_RANGED ) == 100 );
        }
    }
}
