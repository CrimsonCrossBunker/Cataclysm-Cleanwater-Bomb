#include "cata_catch.h"

#include <set>

#include "cata_scope_helpers.h"
#include "enums.h"
#include "loading_ui_random.h"
#include "options_helpers.h"
#include "path_info.h"
#include "rng.h"

TEST_CASE( "loading_choices_do_not_advance_simulation_rng", "[loading_ui][rng][regression]" )
{
    const override_option ascii( "ENABLE_ASCII_TITLE", "true" );
    const override_option seasonal( "SEASONAL_TITLE", "false" );
    const override_option alternate( "ALT_TITLE", "50" );
    const auto before = rng_get_engine();
    const std::vector<cata_path> images = {
        PATH_INFO::gfxdir() / "first.png", PATH_INFO::gfxdir() / "second.png"
    };
    loading_ui::random_choices choices( 20261103 );
    std::set<std::string> tips;
    std::set<std::string> selected_images;
    std::set<std::string> titles;
    for( int i = 0; i < 64; ++i ) {
        tips.insert( choices.tip() );
        const cata_path selected = choices.image( images );
        CHECK( ( selected == images[0] || selected == images[1] ) );
        selected_images.insert( selected.get_unrelative_path().u8string() );
        titles.insert( choices.title( holiday::none ) );
    }
    CHECK( tips.size() > 1 );
    CHECK( tips.count( "" ) == 0 );
    CHECK( selected_images.size() == 2 );
    const std::set<std::string> expected_titles = {
        PATH_INFO::title( holiday::none, false ), PATH_INFO::title( holiday::none, true )
    };
    CHECK( titles == expected_titles );
    CHECK( choices.image( {} ) == cata_path() );
    CHECK( choices.image( { images.front() } ) == images.front() );
    // Default construction and repeated loading sessions are also isolated.
    loading_ui::random_choices another;
    another.tip();
    another.title( holiday::christmas );
    CHECK( rng_get_engine() == before );
}

TEST_CASE( "loading_sessions_own_their_random_choices", "[loading_ui][rng]" )
{
    loading_ui::random_choices first( 20261103 );
    loading_ui::random_choices repeat( 20261103 );
    loading_ui::random_choices other( 73 );
    for( int i = 0; i < 16; ++i ) {
        const std::string expected = first.tip();
        other.tip();
        other.title( holiday::none );
        CHECK( repeat.tip() == expected );
    }
}

TEST_CASE( "loading_title_preserves_disabled_alternate_and_seasonal_options", "[loading_ui]" )
{
    const override_option ascii( "ENABLE_ASCII_TITLE", "true" );
    const override_option seasonal( "SEASONAL_TITLE", "false" );
    const std::string chance = GENERATE( "0", "100" );
    const override_option alternate( "ALT_TITLE", chance );
    loading_ui::random_choices choices( 17 );
    CHECK( choices.title( holiday::none ) == PATH_INFO::title( holiday::none, chance == "100" ) );
    {
        const override_option enable_seasonal( "SEASONAL_TITLE", "true" );
        CHECK( choices.title( holiday::christmas ) == PATH_INFO::title( holiday::christmas, false ) );
    }
    {
        const override_option disable_ascii( "ENABLE_ASCII_TITLE", "false" );
        CHECK( choices.title( holiday::none ) == PATH_INFO::title( holiday::none, false ) );
    }
}

TEST_CASE( "main_menu_title_does_not_advance_simulation_rng", "[loading_ui][rng]" )
{
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    const override_option seasonal( "SEASONAL_TITLE", "false" );
    const std::string chance = GENERATE( "0", "50", "100" );
    const override_option alternate( "ALT_TITLE", chance );
    const std::string enabled = GENERATE( "true", "false" );
    const override_option ascii( "ENABLE_ASCII_TITLE", enabled );
    const auto before = rng_get_engine();
    const std::string selected = PATH_INFO::title( holiday::none );
    if( enabled == "false" || chance == "0" ) {
        CHECK( selected == PATH_INFO::title( holiday::none, false ) );
    } else if( chance == "100" ) {
        CHECK( selected == PATH_INFO::title( holiday::none, true ) );
    } else {
        CHECK( ( selected == PATH_INFO::title( holiday::none, false ) ||
                 selected == PATH_INFO::title( holiday::none, true ) ) );
    }
    CHECK( rng_get_engine() == before );
}
