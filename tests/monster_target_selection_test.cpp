#include <cfloat>
#include <cmath>
#include <cstddef>
#include <vector>

#include "cata_catch.h"
#include "monster_target_selection.h"
#include "rng.h"

namespace
{
struct selection_observer {
    std::vector<bool> attitudes;
    size_t next = 0;
    std::vector<monster_target_request> requests;
    std::vector<int> chances;

    bool answer( monster_target_request request, int chance ) {
        requests.push_back( request );
        if( request == monster_target_request::tie_draw ) {
            chances.push_back( chance );
            return one_in( chance );
        }
        return attitudes[next++ % attitudes.size()];
    }
};

// Original friendly, reachable-monster and NPC selection blocks. Preserve their
// lazy query expressions so the oracle checks request order as well as results.
monster_target_choice original_choice( monster_target_state state, monster_target_kind kind,
                                       float rating, bool fleeing_from, bool hate, selection_observer &observer )
{
    bool selected = false;
    if( kind == monster_target_kind::friendly_monster ) {
        if( rating < state.best ) {
            selected = true;
            state.best = rating;
        }
        return { state, selected };
    }
    if( kind == monster_target_kind::reachable_monster ) {
        if( rating == state.best ) {
            ++state.valid_targets;
            if( observer.answer( monster_target_request::tie_draw, state.valid_targets ) ) {
                selected = true;
            }
        }
        if( rating < state.best ) {
            selected = true;
            state.best = rating;
            state.valid_targets = 1;
        }
        return { state, selected };
    }
    if( rating == state.best && ( state.fleeing ||
                                  observer.answer( monster_target_request::tie_attack, 0 ) ||
                                  observer.answer( monster_target_request::tie_follow, 0 ) ) ) {
        ++state.valid_targets;
        if( observer.answer( monster_target_request::tie_draw, state.valid_targets ) ) {
            selected = true;
        }
    }
    if( ( rating < state.best && state.fleeing ) || hate ||
        ( rating < state.best && observer.answer( monster_target_request::replacement_attack, 0 ) ) ||
        ( !state.fleeing && fleeing_from ) ) {
        selected = true;
        state.best = rating;
        state.valid_targets = 1;
    }
    state.fleeing = state.fleeing || fleeing_from;
    return { state, selected };
}
} // namespace

TEST_CASE( "monster_target_continuations_preserve_queries_choices_and_rng",
           "[monster][target_selection]" )
{
    const std::vector<std::vector<bool>> scripts = {
        { false }, { true }, { false, true }, { true, false, false }
    };
    for( unsigned int seed : {
             1u, 1234u, 4242424242u
         } ) {
        for( monster_target_kind kind : {
                 monster_target_kind::npc,
                 monster_target_kind::reachable_monster, monster_target_kind::friendly_monster
             } ) {
            for( bool fleeing : {
                     false, true
                 } ) {
                for( int valid : {
                         0, 1, 3
                     } ) {
                    for( float best : {
                             4.0f, FLT_MAX
                         } ) {
                        for( float rating : {
                                 -1.0f, 3.0f, 4.0f, 5.0f, FLT_MAX
                             } ) {
                            for( bool fleeing_from : {
                                     false, true
                                 } ) {
                                for( bool hate : {
                                         false, true
                                     } ) {
                                    for( size_t script = 0; script < scripts.size(); ++script ) {
                                        CAPTURE( seed, kind, fleeing, valid, best, rating, fleeing_from, hate, script );
                                        selection_observer original{ scripts[script], 0, {}, {} };
                                        rng_set_engine_seed( seed );
                                        const monster_target_choice expected = original_choice( { best, valid, fleeing }, kind,
                                            rating, fleeing_from, hate, original );
                                        const cata_default_random_engine expected_engine = rng_get_engine();
                                        selection_observer observed{ scripts[script], 0, {}, {} };
                                        rng_set_engine_seed( seed );
                                        monster_target_selection selection( { best, valid, fleeing }, kind,
                                                                            rating, fleeing_from, hate );
                                        size_t steps = 0;
                                        while( selection.request() != monster_target_request::none ) {
                                            REQUIRE( ++steps <= 4 );
                                            const bool accepted = observed.answer( selection.request(), selection.tie_chance() );
                                            selection.answer( accepted );
                                        }
                                        const monster_target_choice actual = selection.result();
                                        CHECK( actual.selected == expected.selected );
                                        CHECK( actual.state.best == expected.state.best );
                                        CHECK( actual.state.fleeing == expected.state.fleeing );
                                        CHECK( actual.state.valid_targets == expected.state.valid_targets );
                                        CHECK( observed.requests == original.requests );
                                        CHECK( observed.chances == original.chances );
                                        CHECK( rng_get_engine() == expected_engine );
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

TEST_CASE( "monster_target_scoring_uses_observed_values", "[monster][target_selection]" )
{
    const cata_default_random_engine engine = rng_get_engine();
    CHECK( observed_monster_target_power( 3.0f, false ) == 3.0f );
    CHECK( observed_monster_target_power( 3.0f, true ) == 5.0f );
    CHECK( score_visible_monster_target( 20, 5.0f ) == 4.0f );
    CHECK( score_visible_monster_target( 20, 0.0f ) == FLT_MAX );
    CHECK( score_visible_monster_target( 20, -1.0f ) == FLT_MAX );
    CHECK( score_visible_monster_target( 3, 2.0f ) == 1.5f );
    CHECK( rng_get_engine() == engine );
}
