#include "catch/catch.hpp"

#include "hover_mouse_input.h"

TEST_CASE( "hover mouse input follows the active pointer source", "[input][mouse]" )
{
    hover_mouse_input_state state;

    CHECK_FALSE( state.active() );

    state.activate();
    CHECK( state.active() );

    SECTION( "touch input retires the last mouse position" ) {
        state.deactivate();
        CHECK_FALSE( state.active() );
    }

    SECTION( "a real mouse can become active again" ) {
        state.deactivate();
        state.activate();
        CHECK( state.active() );
    }
}
