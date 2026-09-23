#include <string>

#include "cata_catch.h"
#include "input.h"
#include "input_context.h"
#include "input_enums.h"

TEST_CASE( "item_action_info_scroll_bindings", "[input][keybindings][upstream_ports]" )
{
    input_context ctxt( "UILIST" );
    ctxt.register_action( "SCROLL_ITEM_INFO_UP" );
    ctxt.register_action( "SCROLL_ITEM_INFO_DOWN" );
    const bool down = GENERATE( false, true );
    const std::string action = down ? "SCROLL_ITEM_INFO_DOWN" : "SCROLL_ITEM_INFO_UP";
    CHECK( ctxt.input_to_action( input_event( down ? '}' : '{',
                                 input_event_t::keyboard_char ) ) == action );
    CHECK( ctxt.input_to_action( input_event( { keymod_t::shift }, down ? ']' : '[',
                                 input_event_t::keyboard_code ) ) == action );
    CHECK( ctxt.input_to_action( input_event( down ? JOY_ALT_DOWN : JOY_ALT_UP,
                                 input_event_t::gamepad ) ) == action );
}
