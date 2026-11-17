#include <optional>
#include <string>

#include "avatar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "item.h"
#include "flexbuffer_json.h"
#include "json.h"
#include "json_loader.h"
#include "lua_platform_runtime.h"
#include "math_parser_diag_value.h"
#include "player_helpers.h"
#include "text_snippets.h"
#include "translation.h"

TEST_CASE( "random_snippet_with_small_seed", "[text_snippets][rng]" )
{
    const int seed_start = -10;
    const int seed_end = 10;
    int snip_change = 0;
    std::optional<translation> prev_snip;
    for( int seed = seed_start; seed <= seed_end; ++seed ) {
        const std::optional<translation> snip = SNIPPET.random_from_category( "lab_notes", seed );
        REQUIRE( snip.has_value() );
        if( prev_snip.has_value() && *prev_snip != *snip ) {
            snip_change++;
        }
        prev_snip = snip;
    }
    // Random snippets change at least 90% of the time when the seed has changed.
    // This is a very weak requirement, but should rule out the possibility of
    // using `std::minstd_rand0` with `std::uniform_int_distribution`.
    CHECK( snip_change >= ( seed_end - seed_start ) * 0.9 );
}

TEST_CASE( "text_snippet_escape", "[text_snippets]" )
{
    CHECK( SNIPPET.expand( "Foo <lt> bar <gt> baz" ) == "Foo < bar > baz" );
    CHECK( SNIPPET.expand( "Foo <lt>lt<gt> baz" ) == "Foo <lt> baz" );
}

TEST_CASE( "tarot_orientation_keeps_the_empty_choice", "[text_snippets]" )
{
    bool upright = false;
    bool reversed = false;
    for( unsigned int seed = 0; seed < 64; ++seed ) {
        const auto orientation = SNIPPET.random_from_category( "<card_orientation>", seed );
        REQUIRE( orientation );
        upright |= orientation->translated().empty();
        reversed |= orientation->translated() == " reversed";
    }
    CHECK( upright );
    CHECK( reversed );
}

TEST_CASE( "first_read_of_artisan_sketches_sets_the_dialogue_flag", "[text_snippets]" )
{
    clear_avatar();
    avatar &reader = get_avatar();
    cata::lua_platform::runtime_world_ready( true );
    const std::string key = "dialogue_artisans_seen_blacksmith_sketches";
    for( int index = 1; index <= 4; ++index ) {
        const snippet_id id( "artisan_prototypes_" + std::to_string( index ) );
        REQUIRE( SNIPPET.has_snippet_with_id( id ) );
        item sketches( itype_id( "blacksmith_prototypes" ) );
        sketches.set_snippet( id );
        reader.set_value( key, "unseen" );
        CHECK_FALSE( reader.has_seen_snippet( id ) );
        sketches.info( true );
        CHECK( reader.has_seen_snippet( id ) );
        CHECK( reader.get_value( key ).str() == "yes" );
        reader.set_value( key, "already read" );
        sketches.info( true );
        CHECK( reader.get_value( key ).str() == "already read" );
    }
    reader.remove_value( key );
}

TEST_CASE( "old_snippet_hash_prefers_the_titled_copy_of_identical_text", "[text_snippets]" )
{
    const restore_on_out_of_scope restore( SNIPPET );
    SNIPPET = snippet_library{};
    SNIPPET.load_snippet( json_loader::from_string( R"({
        "category": "old_news",
        "text": [
            { "id": "titled_news", "text": "An old report.", "name": "Archive" },
            { "id": "untitled_news", "text": "An old report." }
        ]
    })" ).get_object(), "test" );
    const auto report = SNIPPET.get_snippet_by_id( snippet_id( "untitled_news" ) );
    REQUIRE( report );
    const auto old_hash = report->legacy_hash();
    REQUIRE( old_hash );
    CHECK( SNIPPET.migrate_hash_to_id( *old_hash ) == snippet_id( "titled_news" ) );
}
