#include <cfloat>
#include <vector>

#include "cata_catch.h"
#include "monster_planning_reaction.h"
#include "rng.h"

namespace
{
struct reaction_flags {
    int anger_seen;
    int fear_seen;
    int anger_near;
    int fear_near;
    int mating;
};
struct draw_record {
    int numerator;
    int denominator;
    bool result;
    bool operator==( const draw_record &other ) const {
        return numerator == other.numerator && denominator == other.denominator && result == other.result;
    }
};
struct reaction_run {
    monster_planning_values values;
    bool aggro = false;
    std::vector<draw_record> draws;
    void draw( int denominator ) {
        const bool result = x_in_y( values.anger, denominator );
        draws.push_back( { values.anger, denominator, result } );
        aggro = aggro || result;
    }
};

reaction_run original_reactions( monster_planning_values values, reaction_flags flags,
                                 int kind, bool fleeing, bool has_target, bool nearby, bool season )
{
    reaction_run run{ values, false, {} };
    if( kind == 0 ) {
        if( !fleeing && run.values.anger <= 20 ) {
            run.values.anger += flags.anger_seen;
        }
        if( !fleeing && flags.anger_seen ) {
            run.draw( 200 );
        }
    }
    if( nearby ) {
        if( run.values.anger <= 30 ) {
            run.values.anger += flags.anger_near;
        }
        if( kind != 2 && flags.anger_near ) {
            run.draw( 100 );
        }
        run.values.morale -= flags.fear_near;
        if( kind != 2 && flags.mating > 0 && run.values.anger <= 30 && season ) {
            run.values.anger += flags.mating;
            run.draw( 100 );
        }
    }
    if( kind != 0 ) {
        if( !fleeing && run.values.anger <= 20 && has_target ) {
            run.values.anger += flags.anger_seen;
        }
        if( !fleeing && has_target ) {
            run.values.morale -= flags.fear_seen;
            if( kind == 1 && flags.anger_seen ) {
                run.draw( 200 );
            }
        }
    }
    return run;
}

reaction_run proposed_reactions( monster_planning_values values, reaction_flags flags,
                                 int kind, bool fleeing, bool has_target, bool nearby, bool season )
{
    reaction_run run{ values, false, {} };
    if( kind == 0 ) {
        run.values.anger = react_to_seen_hostile( run.values, flags.anger_seen, 0, fleeing, true ).anger;
        const auto seen = react_to_hostile_sighting( run.values, flags.anger_seen, fleeing );
        if( seen.draw_aggro ) {
            run.draw( seen.denominator );
        }
    }
    if( nearby ) {
        const auto near = react_to_near_hostile( run.values, flags.anger_near, flags.fear_near );
        run.values.anger = near.values.anger;
        if( kind != 2 && near.draw_aggro ) {
            run.draw( near.denominator );
        }
        run.values.morale = near.values.morale;
        if( kind != 2 && flags.mating > 0 && run.values.anger <= 30 && season ) {
            const auto mating = react_to_mating_season( run.values, flags.mating, true );
            run.values.anger = mating.values.anger;
            if( mating.draw_aggro ) {
                run.draw( mating.denominator );
            }
        }
    }
    if( kind != 0 ) {
        const auto seen = react_to_seen_hostile( run.values, flags.anger_seen, flags.fear_seen,
                          fleeing, has_target );
        run.values.anger = seen.anger;
        if( !fleeing && has_target ) {
            run.values.morale = seen.morale;
            if( kind == 1 ) {
                const auto sighting = react_to_hostile_sighting( run.values, flags.anger_seen, fleeing );
                if( sighting.draw_aggro ) {
                    run.draw( sighting.denominator );
                }
            }
        }
    }
    return run;
}
} // namespace

TEST_CASE( "monster_planning_reactions_preserve_effect_and_rng_sequence",
           "[monster][planning_reaction]" )
{
    const std::vector<reaction_flags> profiles = {
        { 0, 0, 0, 0, 0 }, { 2, 2, 5, 5, 3 }, { 0, 0, 5, 5, 0 },
        { 2, 2, 0, 0, 0 }, { 0, 0, 0, 0, 3 }, { 0, 2, 0, 5, 0 }
    };
    for( unsigned int seed : {
             1u, 1234u, 4242424242u
         } ) {
        for( int anger : {
                 -10, 0, 19, 20, 21, 29, 30, 31, 39, 40, 41, 99
                 } ) {
            for( int morale : {
                     -11, 20
                     } ) {
                for( int kind : {
                         0, 1, 2
                     } ) {
                    for( const auto &flags : profiles ) {
                        for( bool fleeing : {
                                 false, true
                             } ) {
                            for( bool has_target : {
                                     false, true
                                 } ) {
                                for( bool nearby : {
                                         false, true
                                     } ) {
                                    for( bool season : {
                                             false, true
                                         } ) {
                                        CAPTURE( seed, anger, morale, kind, fleeing, has_target, nearby, season );
                                        rng_set_engine_seed( seed );
                                        const auto expected = original_reactions( { anger, morale }, flags, kind,
                                                              fleeing, has_target, nearby, season );
                                        const auto engine = rng_get_engine();
                                        rng_set_engine_seed( seed );
                                        const auto actual = proposed_reactions( { anger, morale }, flags, kind,
                                                                                fleeing, has_target, nearby, season );
                                        CHECK( actual.values.anger == expected.values.anger );
                                        CHECK( actual.values.morale == expected.values.morale );
                                        CHECK( actual.aggro == expected.aggro );
                                        CHECK( actual.draws == expected.draws );
                                        CHECK( rng_get_engine() == engine );
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

TEST_CASE( "monster_weak_target_reaction_preserves_priority_and_thresholds",
           "[monster][planning_reaction]" )
{
    for( int anger : {
             -1, 20, 40, 41, 99
             } ) {
        for( int morale : {
                 -10, 0, 20
                 } ) {
            for( int hp : {
                     0, 9, 10, 69, 70, 71, 100
                 } ) {
                for( bool angry : {
                         false, true
                     } ) {
                    for( bool fear : {
                             false, true
                         } ) {
                        for( bool placate : {
                                 false, true
                             } ) {
                            CAPTURE( anger, morale, hp, angry, fear, placate );
                            monster_planning_values expected{ anger, morale };
                            bool draw = false;
                            if( hp <= 70 ) {
                                if( angry && expected.anger <= 40 ) {
                                    expected.anger += 10 - static_cast<int>( hp / 10 );
                                    draw = true;
                                } else if( fear ) {
                                    expected.morale -= 10 - static_cast<int>( hp / 10 );
                                } else if( placate ) {
                                    expected.anger -= 10 - static_cast<int>( hp / 10 );
                                }
                            }
                            const auto actual = react_to_weak_target( { anger, morale }, hp, angry, fear, placate );
                            CHECK( actual.values.anger == expected.anger );
                            CHECK( actual.values.morale == expected.morale );
                            CHECK( actual.draw_aggro == draw );
                            CHECK( actual.denominator == 100 );
                        }
                    }
                }
            }
        }
    }
}

TEST_CASE( "monster_group_morale_and_swarm_preserve_float_and_branch_semantics",
           "[monster][planning_reaction]" )
{
    CHECK( morale_after_group_observation( -10, 0.5f, true ) == 0 );
    const auto engine = rng_get_engine();
    for( int morale : {
             -100, -10, -1, 0, 10, 99
             } ) {
        for( float rating : {
                 0.5f, 4.99f, 5.0f, 8.6f, 10.0f, 10.1f, FLT_MAX
             } ) {
            for( bool group : {
                     false, true
                 } ) {
                int expected = morale;
                if( group && rating <= 10 ) {
                    expected += 10 - rating;
                }
                CHECK( morale_after_group_observation( morale, rating, group ) == expected );
            }
            for( bool swarms : {
                     false, true
                 } ) {
                for( int wandering : {
                         -1, 0, 1
                         } ) {
                    monster_swarm_action expected = monster_swarm_action::none;
                    if( swarms ) {
                        if( rating < 5 ) {
                            expected = monster_swarm_action::disperse;
                        } else if( rating < FLT_MAX && rating > 6.0f && wandering <= 0 ) {
                            expected = monster_swarm_action::follow_ally;
                        }
                    }
                    CHECK( choose_monster_swarm_action( rating, 6.0f, wandering, swarms ) == expected );
                }
            }
        }
    }
    for( int cub : {
             0, 1, 8
         } ) {
        const auto result = react_to_threatened_cub( { 10, -5 }, cub );
        CHECK( result.anger == 10 + cub );
        CHECK( result.morale == -5 + cub / 2 );
    }
    CHECK( rng_get_engine() == engine );
}
