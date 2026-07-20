#include "cata_catch.h"
#include "catalua_ui.h"

TEST_CASE( "lua_module_names_stay_inside_script_roots", "[lua][ui][sandbox]" )
{
    using cata::lua_ui::is_safe_module_name;

    CHECK( is_safe_module_name( "widgets" ) );
    CHECK( is_safe_module_name( "lib.widgets.hud-v2" ) );

    CHECK_FALSE( is_safe_module_name( "" ) );
    CHECK_FALSE( is_safe_module_name( ".hidden" ) );
    CHECK_FALSE( is_safe_module_name( "hidden." ) );
    CHECK_FALSE( is_safe_module_name( "../outside" ) );
    CHECK_FALSE( is_safe_module_name( "lib..outside" ) );
    CHECK_FALSE( is_safe_module_name( "lib/widgets" ) );
    CHECK_FALSE( is_safe_module_name( "C:\\outside" ) );
}
