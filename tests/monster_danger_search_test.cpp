#include "cata_catch.h"

#include "monster_danger_search.h"

TEST_CASE( "monster_danger_skips_only_impossible_faction_groups", "[monster][danger_search]" )
{
    CHECK_FALSE( monster_danger_group_possible( MFA_FRIENDLY, false ) );
    CHECK_FALSE( monster_danger_group_possible( MFA_NEUTRAL, false ) );
    CHECK( monster_danger_group_possible( MFA_HATE, false ) );
    CHECK( monster_danger_group_possible( MFA_BY_MOOD, false ) );
    // A hostile NPC may share a faction that is friendly to the observer.
    for( mf_attitude relation : { MFA_FRIENDLY, MFA_NEUTRAL, MFA_HATE, MFA_BY_MOOD } ) {
        CHECK( monster_danger_group_possible( relation, true ) );
    }
}

TEST_CASE( "monster_danger_values_preserve_hostility_rules", "[monster][danger_search]" )
{
    const tripoint origin{ 100, 100, 0 };
    for( mf_attitude relation : { MFA_FRIENDLY, MFA_NEUTRAL, MFA_HATE, MFA_BY_MOOD } ) {
        for( bool angry : { false, true } ) {
            for( bool hallucination : { false, true } ) {
                for( bool character : { false, true } ) {
                    for( bool character_hostile : { false, true } ) {
                        monster_danger_candidate candidate;
                        candidate.position = { 101, 100, 0 };
                        candidate.attitude = relation;
                        candidate.angry = angry;
                        candidate.hallucination = hallucination;
                        candidate.character = character;
                        candidate.character_hostile = character_hostile;
                        const bool expected = !hallucination && ( character ? character_hostile :
                                              relation == MFA_HATE || ( angry && relation == MFA_BY_MOOD ) );
                        CHECK( monster_danger_possible( origin, candidate, false ) == expected );
                        CHECK( monster_danger_possible( origin, candidate, true ) == expected );
                    }
                }
            }
        }
    }
}

TEST_CASE( "monster_danger_distance_matches_visibility_hard_bounds", "[monster][danger_search]" )
{
    const tripoint origin{ 100, 100, 0 };
    monster_danger_candidate candidate;
    candidate.attitude = MFA_HATE;
    for( int dx = -MAX_VIEW_DISTANCE - 2; dx <= MAX_VIEW_DISTANCE + 2; ++dx ) {
        for( int dy : { 0, 1, MAX_VIEW_DISTANCE } ) {
            for( int dz : { 0, fov_3d_z_range, fov_3d_z_range + 1 } ) {
                candidate.position = origin + tripoint{ dx, dy, dz };
                const bool same_level_range = dz <= fov_3d_z_range;
                CHECK( monster_danger_possible( origin, candidate, false ) ==
                       ( same_level_range && square_dist( origin, candidate.position ) <= MAX_VIEW_DISTANCE ) );
                CHECK( monster_danger_possible( origin, candidate, true ) ==
                       ( same_level_range && static_cast<int>( trig_dist( origin, candidate.position ) ) <=
                         MAX_VIEW_DISTANCE ) );
            }
        }
    }
    // A distance just above the integer limit is still visible after truncation.
    candidate.position = origin + tripoint{ MAX_VIEW_DISTANCE, 1, 0 };
    CHECK( monster_danger_possible( origin, candidate, true ) );
}
