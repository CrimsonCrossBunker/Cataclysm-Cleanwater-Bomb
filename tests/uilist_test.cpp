#include "catch/catch.hpp"

#include "uilist.h"

TEST_CASE( "forced_uilist_menu_uses_the_remaining_content_region", "[ui][uilist]" )
{
    const ImVec2 available_after_tabs( 926.0F, 789.0F );
    const ImVec2 menu_size = uilist_menu_size_for_available_region(
                                 available_after_tabs, 4.0F, 4.0F );

    CHECK( menu_size.x == 918.0F );
    CHECK( menu_size.y == available_after_tabs.y );
}

TEST_CASE( "forced_uilist_menu_size_stays_positive_in_tiny_regions", "[ui][uilist]" )
{
    const ImVec2 menu_size = uilist_menu_size_for_available_region(
                                 ImVec2( 5.0F, -2.0F ), 4.0F, 4.0F );

    CHECK( menu_size.x == 1.0F );
    CHECK( menu_size.y == 1.0F );
}
