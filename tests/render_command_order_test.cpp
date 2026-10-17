#include "cata_catch.h"
#include "render_command_order.h"

TEST_CASE( "render_commands_keep_painter_order_and_single_use", "[tiles][render_commands]" )
{
    render_command_order stream;
    const render_resource_stamp resources{ 7, 11 };
    REQUIRE( stream.begin( resources, 42 ) );
    const auto background = stream.issue();
    const auto foreground = stream.issue();
    REQUIRE( background );
    REQUIRE( foreground );
    SECTION( "ordered background then foreground" ) {
        CHECK( stream.accept( *background, resources ) );
        CHECK( stream.accept( *foreground, resources ) );
        CHECK( stream.accepted() == 2 );
        CHECK_FALSE( stream.accept( *foreground, resources ) );
        CHECK( stream.cancelled() );
    }
    SECTION( "out of order cancels the entire stream" ) {
        CHECK_FALSE( stream.accept( *foreground, resources ) );
        CHECK_FALSE( stream.accept( *background, resources ) );
        CHECK( stream.accepted() == 0 );
    }
}

TEST_CASE( "render_commands_reject_old_resources_and_same_epoch_restarts",
           "[tiles][render_commands]" )
{
    render_command_order stream;
    const render_resource_stamp resources{ 7, 11 };
    REQUIRE( stream.begin( resources, 42 ) );
    const auto old = stream.issue();
    REQUIRE( old );
    SECTION( "renderer resources recreated" ) {
        CHECK_FALSE( stream.accept( *old, { 8, 11 } ) );
    }
    SECTION( "sprite sheets reloaded" ) {
        CHECK_FALSE( stream.accept( *old, { 7, 12 } ) );
    }
    SECTION( "new stream uses identical epochs" ) {
        REQUIRE( stream.begin( resources, 42 ) );
        CHECK_FALSE( stream.accept( *old, resources ) );
    }
    SECTION( "explicit cancellation closes pending work" ) {
        stream.cancel();
        CHECK_FALSE( stream.accept( *old, resources ) );
        CHECK_FALSE( stream.issue() );
    }
    CHECK( stream.accepted() == 0 );
}

TEST_CASE( "render_commands_cannot_cross_independent_owner_frames", "[tiles][render_commands]" )
{
    render_command_order old_frame;
    render_command_order next_frame;
    const render_resource_stamp resources{ 7, 11 };
    REQUIRE( old_frame.begin( resources, 42 ) );
    REQUIRE( next_frame.begin( resources, 43 ) );
    const auto old = old_frame.issue();
    const auto next = next_frame.issue();
    REQUIRE( old );
    REQUIRE( next );
    CHECK_FALSE( next_frame.accept( *old, resources ) );
    CHECK_FALSE( next_frame.accept( *next, resources ) );
    CHECK( next_frame.accepted() == 0 );
    REQUIRE( next_frame.begin( resources, 44 ) );
    const auto fresh = next_frame.issue();
    REQUIRE( fresh );
    CHECK( next_frame.accept( *fresh, resources ) );
}
