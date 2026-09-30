#include <memory>

#include "cata_catch.h"
#include "input_context.h"

TEST_CASE( "input_context_activation_preserves_later_contexts", "[input]" )
{
    input_context_stack_impl stack;
    input_context menu( "MAIN_MENU" );
    input_context tab( "CHARACTER_CREATION" );
    auto menu_handle = std::make_shared<input_context_handle>( input_context_handle{ &menu } );
    auto activation = std::make_shared<input_context_handle>( input_context_handle{ &menu } );
    auto tab_handle = std::make_shared<input_context_handle>( input_context_handle{ &tab } );
    stack.push( menu_handle );
    stack.push( activation );
    stack.push( tab_handle );
    REQUIRE( stack.back() == &tab );

    // A persistent context may have been created while the menu was active.
    // Ending that activation must remove its own entry, not the newer context.
    stack.remove( activation );
    CHECK( stack.back() == &tab );
    tab_handle.reset();
    CHECK( stack.back() == &menu );
    menu_handle.reset();
    CHECK( stack.back() == nullptr );
}
