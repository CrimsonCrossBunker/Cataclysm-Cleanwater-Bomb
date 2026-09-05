#if defined(TILES)
#include "avatar.h"
#include "cata_catch.h"
#include "player_helpers.h"
#include "sdl_renderer_recovery.h"

TEST_CASE( "character_preview_uses_scaled_opaque_sprite_bounds", "[tiles][character_preview]" )
{
    clear_avatar();
    software_render_fixture fixture;
    REQUIRE( fixture.available() );
    const int scale = GENERATE( 16, 32, 48 );
    get_avatar().male = GENERATE( false, true );
    CHECK( renderer_recovery_test_support::character_preview_size( get_avatar(), scale ) ==
           point( scale / 16, scale / 16 ) );
}
#endif
