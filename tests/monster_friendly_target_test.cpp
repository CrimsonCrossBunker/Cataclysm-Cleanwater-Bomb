#include <cfloat>
#include <vector>

#include "cata_catch.h"
#include "monster_target_selection.h"

TEST_CASE( "friendly_target_filter_matches_mixed_attitude_branch", "[monster][targeting]" )
{
    // The observer is a player ally; test every candidate faction attitude.
    for( int faction = 0; faction < 4; ++faction ) {
        for( int friendly : { -1, 0, 1, 100 } ) {
            for( int morale : { -100, -1, 0, 1, 100 } ) {
                for( int anger : { -1, 0, 9, 10, 100 } ) {
                    const int observer_friendly = -1;
                    bool original_hostile;
                    if( ( friendly != 0 && observer_friendly != 0 ) ||
                        ( friendly == 0 && observer_friendly == 0 && faction == 2 ) ) {
                        original_hostile = false;
                    } else if( friendly == 0 && observer_friendly == 0 && faction == 3 ) {
                        original_hostile = true;
                    } else if( ( friendly == 0 && observer_friendly == 0 && faction == 1 ) ||
                               morale < 0 || anger < 10 ) {
                        original_hostile = false;
                    } else {
                        original_hostile = true;
                    }
                    CAPTURE( faction, friendly, morale, anger );
                    CHECK( hostile_to_player_ally( friendly, morale, anger ) == original_hostile );
                }
            }
        }
    }
}

TEST_CASE( "friendly_target_selection_keeps_first_tie_and_filters_current_values",
           "[monster][targeting]" )
{
    struct candidate {
        int friendly;
        int morale;
        int anger;
        float rating;
    };
    std::vector<candidate> candidates{
        { 1, 100, 100, 1 }, { 0, -1, 100, 1 }, { 0, 0, 9, 1 },
        { 0, 0, 10, 3 }, { 0, 100, 100, 3 }, { 0, 0, 10, FLT_MAX }
    };
    const auto choose = [&]() {
        monster_target_state state{ 60, 0, false };
        int selected = -1;
        for( std::size_t i = 0; i < candidates.size(); ++i ) {
            const auto &entry = candidates[i];
            if( !hostile_to_player_ally( entry.friendly, entry.morale, entry.anger ) ) {
                continue;
            }
            const auto choice = monster_target_selection( state,
                                monster_target_kind::friendly_monster, entry.rating ).result();
            if( choice.selected ) {
                selected = static_cast<int>( i );
            }
            state = choice.state;
        }
        return selected;
    };
    CHECK( choose() == 3 );
    candidates[3].friendly = -1;
    CHECK( choose() == 4 );
    candidates[4].anger = 9;
    CHECK( choose() == -1 );
    candidates[2].anger = 10;
    CHECK( choose() == 2 );
}
