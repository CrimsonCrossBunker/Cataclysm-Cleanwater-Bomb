#include <functional>
#include <memory>

#include "avatar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "dialogue.h"
#include "math_parser.h"
#include "math_parser_type.h"
#include "npc.h"
#include "player_helpers.h"
#include "talker.h"
#include "type_id.h"

TEST_CASE( "upstream_hunger_math_preserves_character_scopes", "[upstream_math]" )
{
    clear_avatar();
    on_out_of_scope restore( [] { clear_avatar(); } );
    avatar &you = get_avatar();
    standard_npc other;
    you.set_hunger( 31 );
    other.set_hunger( 22 );
    dialogue d( get_talker_for( you ), get_talker_for( &other ) );
    math_exp expression;

    REQUIRE( expression.parse( "u_hunger()" ) );
    CHECK( expression.eval( d ) == 31 );
    REQUIRE( expression.parse( "n_hunger()" ) );
    CHECK( expression.eval( d ) == 22 );
    REQUIRE( expression.parse( "u_hunger() = 56" ) );
    expression.eval( d );
    CHECK( you.get_hunger() == 56 );
    CHECK( other.get_hunger() == 22 );
    REQUIRE( expression.parse( "u_val('hunger')" ) );
    CHECK( expression.eval( d ) == 56 );

    dialogue without_character( get_talker_for( you ), std::make_unique<talker>() );
    REQUIRE( expression.parse( "n_hunger() = 1" ) );
    CHECK_THROWS_AS( expression.eval( without_character ), math::runtime_error );
}

TEST_CASE( "upstream_morale_math_preserves_ccb_unmodified_morale", "[upstream_math]" )
{
    clear_avatar();
    on_out_of_scope restore( [] { clear_avatar(); } );
    avatar &you = get_avatar();
    dialogue d( get_talker_for( you ), std::make_unique<talker>() );
    math_exp expression;
    you.add_morale( morale_type( "morale_food_bad" ), -7, -7 );
    const int expected = you.get_morale_level();
    REQUIRE( expected < 0 );

    REQUIRE( expression.parse( "u_morale()" ) );
    CHECK( expression.eval( d ) == expected );
    REQUIRE( expression.parse( "u_morale('raw': 1)" ) );
    CHECK( expression.eval( d ) == expected );
    REQUIRE( expression.parse( "u_morale('raw': 0)" ) );
    CHECK( expression.eval( d ) == expected );
    REQUIRE( expression.parse( "u_val('morale')" ) );
    CHECK( expression.eval( d ) == expected );
}
