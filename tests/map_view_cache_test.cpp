#include <optional>
#include <stdexcept>

#include "cata_catch.h"
#include "character_id.h"
#include "draw_cache_rebuild_guard.h"
#include "map.h"
#include "map_helpers.h"
#include "map_view_cache_state.h"
#include "rng.h"

namespace
{
class view_test_map : public map
{
    public:
        view_test_map() : map( 1, false ) {}
        using map::set_abs_sub;
};

void finish_view_rebuild( map_view_cache_state &view )
{
    draw_cache_rebuild_guard rebuild( view.dirty );
    rebuild.complete();
}
} // namespace

TEST_CASE( "map_views_acknowledge_changes_independently", "[map_view_cache][regression]" )
{
    view_test_map source;
    view_test_map other_source;
    map_view_cache_state first;
    map_view_cache_state second;
    const character_id observer( 1 );
    const auto rng_before = rng_get_engine();
    first.observe( source, observer );
    second.observe( source, observer );
    REQUIRE( first.dirty );
    REQUIRE( second.dirty );
    finish_view_rebuild( first );
    finish_view_rebuild( second );
    first.observe( source, observer );
    second.observe( source, observer );
    CHECK_FALSE( first.dirty );
    CHECK_FALSE( second.dirty );

    const auto revision = source.draw_cache_revision();
    source.set_draw_points_cache_dirty();
    CHECK( source.draw_cache_revision() > revision );
    first.observe( source, observer );
    REQUIRE( first.dirty );
    finish_view_rebuild( first );
    second.observe( source, observer );
    CHECK( second.dirty ); // The first view did not consume this change.
    finish_view_rebuild( second );

    other_source.set_draw_points_cache_dirty();
    CHECK( other_source.draw_cache_revision() == source.draw_cache_revision() );
    first.observe( source, observer );
    CHECK_FALSE( first.dirty );
    first.observe( other_source, observer );
    CHECK( first.dirty ); // Equal revisions in different maps are unrelated.
    second.observe( source, observer );
    CHECK_FALSE( second.dirty );
    CHECK( rng_get_engine() == rng_before );
}

TEST_CASE( "map_view_cache_follows_observer_and_context_lifetime",
           "[map_view_cache][regression]" )
{
    std::optional<view_test_map> source;
    source.emplace();
    map_view_cache_state view;
    const character_id first( 1 );
    const character_id second( 2 );
    view.observe( *source, first );
    finish_view_rebuild( view );
    view.observe( *source, second );
    REQUIRE( view.dirty );
    finish_view_rebuild( view );

    SECTION( "reset_at_the_same_origin" ) {
        source->set_abs_sub( source->get_abs_sub() );
        view.observe( *source, second );
        CHECK( view.dirty );
    }
    SECTION( "new_map_reuses_the_same_address_and_revision" ) {
        const map *address = &*source;
        source.reset();
        source.emplace();
        REQUIRE( &*source == address );
        view.observe( *source, second );
        CHECK( view.dirty );
    }
}

TEST_CASE( "map_view_cache_retries_failed_or_invalidated_rebuilds",
           "[map_view_cache][regression]" )
{
    view_test_map source;
    map_view_cache_state view;
    const character_id observer( 1 );
    view.observe( source, observer );

    SECTION( "failed_capture" ) {
        CHECK_THROWS_AS( [&]() {
            draw_cache_rebuild_guard rebuild( view.dirty );
            throw std::runtime_error( "capture failed" );
        }
        (), std::runtime_error );
        view.observe( source, observer );
        CHECK( view.dirty );
    }
    SECTION( "world_changed_during_capture" ) {
        {
            draw_cache_rebuild_guard rebuild( view.dirty );
            source.set_draw_points_cache_dirty();
            rebuild.complete();
        }
        view.observe( source, observer );
        CHECK( view.dirty );
    }
}

TEST_CASE( "map_decoration_changes_invalidate_all_views", "[map_view_cache][regression]" )
{
    clear_map_without_vision();
    map &source = get_map();
    const tripoint_bub_ms pos( 60, 60, 0 );
    map_view_cache_state first;
    map_view_cache_state second;
    const character_id observer( 1 );
    const auto observe_both = [&]() {
        first.observe( source, observer );
        second.observe( source, observer );
        REQUIRE( first.dirty );
        REQUIRE( second.dirty );
        finish_view_rebuild( first );
        finish_view_rebuild( second );
    };
    observe_both();
    source.set_graffiti( pos, "view cache invalidation" );
    observe_both();
    source.delete_graffiti( pos );
    observe_both();
}
