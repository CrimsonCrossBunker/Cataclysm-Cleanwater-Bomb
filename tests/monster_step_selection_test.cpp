#include <cstddef>
#include <vector>

#include "cata_catch.h"
#include "monster_step_selection.h"
#include "rng.h"

namespace
{
struct selection_run {
    monster_step_selection selection;
    size_t examined = 0;
    size_t draws = 0;
};

// The original owner loop is the comparison oracle. In particular, doors retain
// earlier weight, and non-positive progress changes weight without a draw.
selection_run original_selection( const std::vector<monster_step_candidate> &candidates,
                                  bool staggers, bool pathed )
{
    selection_run run;
    for( const monster_step_candidate &candidate : candidates ) {
        ++run.examined;
        if( candidate.kind != monster_step_kind::weighted ) {
            run.selection.selected = true;
            run.selection.destination = candidate.destination;
            if( candidate.kind == monster_step_kind::attack ) {
                break;
            }
            continue;
        }
        run.selection.switch_chance += candidate.progress * 2;
        bool selected = false;
        if( candidate.progress > 0 ) {
            if( !run.selection.selected ) {
                selected = true;
            } else {
                ++run.draws;
                selected = x_in_y( candidate.progress, run.selection.switch_chance );
            }
        }
        if( selected ) {
            run.selection.selected = true;
            run.selection.destination = candidate.destination;
            if( !staggers && ( !candidate.bad_choice || pathed ) ) {
                break;
            }
        }
    }
    return run;
}

selection_run proposed_selection( const std::vector<monster_step_candidate> &candidates,
                                  bool staggers, bool pathed )
{
    selection_run run;
    for( const monster_step_candidate &candidate : candidates ) {
        ++run.examined;
        const monster_step_proposal proposal = propose_monster_step( run.selection, candidate,
                                               staggers, pathed );
        bool selected = proposal.select_without_draw;
        if( proposal.needs_draw ) {
            ++run.draws;
            selected = x_in_y( proposal.numerator, proposal.next.switch_chance );
        }
        run.selection = resolve_monster_step( proposal, selected );
        if( selected && proposal.stop_if_selected ) {
            break;
        }
    }
    return run;
}
} // namespace

TEST_CASE( "monster_step_proposals_preserve_choices_and_rng", "[monster][step_selection]" )
{
    const tripoint_abs_ms a{ 30, 31, 0 };
    const tripoint_abs_ms b{ 31, 31, 0 };
    const tripoint_abs_ms c{ 32, 31, 1 };
    const std::vector<std::vector<monster_step_candidate>> sequences = {
        {},
        {   { a, monster_step_kind::weighted, 0.0f },
            { b, monster_step_kind::weighted, -0.1f }
        },
        {   { a, monster_step_kind::weighted, 1.0f, true },
            { b, monster_step_kind::weighted, 0.2f, false },
            { c, monster_step_kind::weighted, 0.15f, true }
        },
        {   { a, monster_step_kind::weighted, 1.0f, true },
            { b, monster_step_kind::weighted, -0.1f },
            { c, monster_step_kind::weighted, 0.25f }
        },
        {   { a, monster_step_kind::weighted, 1.0f, true },
            { b, monster_step_kind::door },
            { c, monster_step_kind::weighted, 0.5f }
        },
        {   { a, monster_step_kind::door },
            { b, monster_step_kind::door },
            { c, monster_step_kind::weighted, 1.0f }
        },
        {   { a, monster_step_kind::weighted, 1.0f, true },
            { b, monster_step_kind::attack },
            { c, monster_step_kind::door }
        },
        {   { a, monster_step_kind::door },
            { b, monster_step_kind::weighted, -1.0f },
            { c, monster_step_kind::weighted, 1.0f }
        }
    };
    for( unsigned int seed : {
             1u, 1234u, 4242424242u
         } ) {
        for( bool staggers : {
                 false, true
             } ) {
            for( bool pathed : {
                     false, true
                 } ) {
                for( size_t i = 0; i < sequences.size(); ++i ) {
                    CAPTURE( seed, staggers, pathed, i );
                    rng_set_engine_seed( seed );
                    const selection_run expected = original_selection( sequences[i], staggers, pathed );
                    const cata_default_random_engine expected_engine = rng_get_engine();
                    rng_set_engine_seed( seed );
                    const selection_run actual = proposed_selection( sequences[i], staggers, pathed );
                    CHECK( actual.selection.selected == expected.selection.selected );
                    CHECK( actual.selection.destination == expected.selection.destination );
                    CHECK( actual.selection.switch_chance == expected.selection.switch_chance );
                    CHECK( actual.examined == expected.examined );
                    CHECK( actual.draws == expected.draws );
                    CHECK( rng_get_engine() == expected_engine );
                }
            }
        }
    }
}

TEST_CASE( "monster_step_evaluation_does_not_consume_rng_or_modify_input",
           "[monster][step_selection]" )
{
    const tripoint_abs_ms old_destination{ 35, 35, 0 };
    const tripoint_abs_ms new_destination{ 36, 35, 0 };
    const monster_step_selection input{ true, old_destination, 2.0f };
    const monster_step_candidate candidate{ new_destination, monster_step_kind::weighted, 0.5f };
    const cata_default_random_engine engine = rng_get_engine();
    const monster_step_proposal proposal = propose_monster_step( input, candidate, true, false );
    CHECK( rng_get_engine() == engine );
    CHECK( input.destination == old_destination );
    CHECK( input.switch_chance == 2.0f );
    REQUIRE( proposal.needs_draw );
    CHECK( proposal.numerator == 0.5f );
    CHECK( proposal.next.switch_chance == 3.0f );
    CHECK( resolve_monster_step( proposal, false ).destination == old_destination );
    CHECK( resolve_monster_step( proposal, true ).destination == new_destination );
    CHECK( rng_get_engine() == engine );
}
