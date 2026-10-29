#include <sstream>
#include <string>

#include "avatar.h"
#include "cata_catch.h"
#include "debug.h"
#include "item.h"
#include "item_location.h"
#include "json.h"
#include "json_loader.h"
#include "map.h"
#include "map_helpers.h"
#include "player_helpers.h"
#include "type_id.h"
#include "uistate.h"

static const itype_id itype_jeans( "jeans" );

TEST_CASE( "consume_menu_only_persists_cursor_and_filters", "[inventory][ui][save]" )
{
    clear_avatar();
    clear_map_without_vision();
    avatar &you = get_avatar();
    item &selected = get_map().add_item_or_charges( you.pos_bub(), item( itype_jeans ) );
    item_location location( map_cursor( you.pos_bub() ), &selected );
    consume_menu_uistate state;
    state.consume_menu_selections = { 1, 2 };
    state.consume_menu_selected_items = { location };
    state.consume_menu_filter = "apple";
    state.consume_menu_comestype = "FOOD";
    state.collated = true;

    std::ostringstream output;
    JsonOut json( output );
    state.serialize( json );
    JsonValue value = json_loader::from_string( output.str() );
    JsonObject object = value;
    CHECK_FALSE( object.has_member( "consume_menu_selected_items" ) );
    REQUIRE( state.consume_menu_selected_items.size() == 1 );
    CHECK( state.consume_menu_selected_items.front() == location );

    consume_menu_uistate loaded;
    loaded.consume_menu_selected_items = { location };
    loaded.deserialize( object );
    CHECK( loaded.consume_menu_selected_items.empty() );
    CHECK( loaded.consume_menu_selections == state.consume_menu_selections );
    CHECK( loaded.consume_menu_filter == state.consume_menu_filter );
    CHECK( loaded.consume_menu_comestype == state.consume_menu_comestype );
    CHECK( loaded.collated == state.collated );
}

TEST_CASE( "consume_menu_discards_legacy_item_locations_without_resolving_them",
           "[inventory][ui][save]" )
{
    clear_avatar();
    clear_map_without_vision();
    const std::string saved = R"({
        "consume_menu_selections": [1, 2],
        "consume_menu_selected_items": [{
            "type": "in_container", "idx": 0, "uid": 9223372036854775806,
            "parent": {
                "type": "character", "character": 0, "idx": 0,
                "uid": 9223372036854775807
            }
        }],
        "consume_menu_filter": "apple",
        "consume_menu_comestype": "FOOD",
        "collated": true
    })";
    consume_menu_uistate state;
    state.consume_menu_selected_items = { item_location::nowhere };
    const std::string diagnostics = capture_debugmsg_during( [&]() {
        JsonValue value = json_loader::from_string( saved );
        JsonObject object = value;
        state.deserialize( object );
        std::ostringstream output;
        JsonOut json( output );
        state.serialize( json );
    } );

    CHECK( diagnostics.empty() );
    CHECK( state.consume_menu_selected_items.empty() );
    REQUIRE( state.consume_menu_selections.size() == 2 );
    CHECK( state.consume_menu_selections[0] == 1 );
    CHECK( state.consume_menu_selections[1] == 2 );
    CHECK( state.consume_menu_filter == "apple" );
    CHECK( state.consume_menu_comestype == "FOOD" );
    CHECK( state.collated );
}
