#include <algorithm>
#include <iterator>
#include <vector>

#include "cata_catch.h"
#include "creature_tracker.h"
#include "map.h"
#include "line.h"
#include "mtype.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "monster.h"
#include "player_helpers.h"

TEST_CASE( "monster_candidate_owner_tracks_move_swap_remove_and_add", "[monster][target_candidates_owner]" )
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    creature_tracker &tracker = get_creature_tracker();
    for( int i = 0; i < 258; ++i ) {
        spawn_test_monster( "mon_zombie", tripoint_bub_ms( 80 + i % 16, 80 + i / 16, 0 ) );
    }
    std::vector<shared_ptr_fast<monster>> result;
    const tripoint_abs_ms origin = here.get_abs( tripoint_bub_ms( 1, 1, 0 ) );
    REQUIRE( tracker.nearby_monster_targets( origin, result ) );
    // Absolute grid alignment can include an extra band; no actually nearby
    // target may be omitted. Move one across several cells and then swap it.
    auto first = tracker.get_monsters_list().front();
    auto last = tracker.get_monsters_list().back();
    last->setpos( here, tripoint_bub_ms( 2, 1, 0 ) );
    REQUIRE( tracker.nearby_monster_targets( origin, result ) );
    CHECK( std::find( result.begin(), result.end(), last ) != result.end() );
    tracker.swap_positions( *first, *last );
    REQUIRE( tracker.nearby_monster_targets( origin, result ) );
    CHECK( std::find( result.begin(), result.end(), first ) != result.end() );
    tracker.remove( *first );
    REQUIRE( tracker.nearby_monster_targets( origin, result ) );
    CHECK( std::find( result.begin(), result.end(), first ) == result.end() );
    monster &replacement = spawn_test_monster( "mon_zombie", tripoint_bub_ms( 2, 1, 0 ) );
    REQUIRE( tracker.nearby_monster_targets( origin, result ) );
    CHECK( std::any_of( result.begin(), result.end(), [&]( const auto &ptr ) {
        return ptr.get() == &replacement;
    } ) );
    const auto &ordered = tracker.get_monsters_list();
    std::size_t previous = 0;
    for( const auto &candidate : result ) {
        const auto found = std::find( ordered.begin() + previous, ordered.end(), candidate );
        REQUIRE( found != ordered.end() );
        previous = std::distance( ordered.begin(), found ) + 1;
    }
    tracker.clear();
    CHECK_FALSE( tracker.nearby_monster_targets( origin, result ) );
    CHECK( result.empty() );
}

TEST_CASE( "monster_group_bash_matches_uncached_rays", "[monster][group_bash]" )
{
    clear_avatar();
    clear_map_without_vision();
    creature_tracker &tracker = get_creature_tracker();
    for( int x = 50; x <= 62; ++x ) {
        for( int y = 50; y <= 62; ++y ) {
            spawn_test_monster( "mon_zombie", tripoint_bub_ms( x, y, 0 ) );
        }
    }
    const tripoint_bub_ms origin( 56, 56, 0 );
    monster &basher = *tracker.creature_at<monster>( origin );
    REQUIRE( basher.has_flag( mon_flag_GROUP_BASH ) );
    for( int pass = 0; pass < 2; ++pass ) {
        if( pass == 1 ) {
            tracker.remove( *tracker.creature_at<monster>( tripoint_bub_ms( 57, 56, 0 ) ) );
            tracker.remove( *tracker.creature_at<monster>( tripoint_bub_ms( 55, 55, 0 ) ) );
        }
        for( int dx = -1; dx <= 1; ++dx ) {
            for( int dy = -1; dy <= 1; ++dy ) {
                if( dx == 0 && dy == 0 ) {
                    continue;
                }
                const tripoint_bub_ms target = origin + tripoint_rel_ms( dx, dy, 0 );
                std::vector<tripoint_bub_ms> path = continue_line(
                            std::vector<tripoint_bub_ms>{target, origin}, 5 );
                path.insert( path.begin(), origin );
                tripoint_bub_ms previous = target;
                std::map<damage_type_id, int> expected;
                for( const tripoint_bub_ms &p : path ) {
                    for( const point_bub_ms &q : squares_in_direction( previous.xy(), p.xy() ) ) {
                        const tripoint_bub_ms candidate( q, target.z() );
                        monster *helper = nullptr;
                        for( const tripoint_bub_ms &step : line_to( target, candidate, 0, 0 ) ) {
                            helper = tracker.creature_at<monster>( step );
                            if( !helper || !helper->has_flag( mon_flag_GROUP_BASH ) ||
                                helper->is_hallucination() ) {
                                helper = nullptr;
                                break;
                            }
                        }
                        if( helper ) {
                            const double distance = rl_dist( candidate, target );
                            for( const auto &damage : helper->bash_skill() ) {
                                expected[damage.first] += damage.second / distance;
                            }
                        }
                    }
                    previous = p;
                }
                CHECK( basher.group_bash_skill( target ) == expected );
            }
        }
    }
    tracker.clear();
}
