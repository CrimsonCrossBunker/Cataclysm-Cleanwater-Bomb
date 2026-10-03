#include "cata_catch.h"
#include "overmap_ui.h"

TEST_CASE( "overmap_labels_do_not_reveal_underground_camps", "[overmap][ui]" )
{
    CHECK( ui::omap::label_visible_at_z( -2, -2 ) );
    CHECK_FALSE( ui::omap::label_visible_at_z( -2, -1 ) );
    CHECK_FALSE( ui::omap::label_visible_at_z( -2, 0 ) );
    CHECK_FALSE( ui::omap::label_visible_at_z( -2, 3 ) );
    CHECK_FALSE( ui::omap::label_visible_at_z( 0, -2 ) );
    CHECK( ui::omap::label_visible_at_z( 0, 0 ) );
    CHECK( ui::omap::label_visible_at_z( 0, 3 ) );
    CHECK( ui::omap::label_visible_at_z( 3, 3 ) );
    CHECK_FALSE( ui::omap::label_visible_at_z( 3, 0 ) );
}
