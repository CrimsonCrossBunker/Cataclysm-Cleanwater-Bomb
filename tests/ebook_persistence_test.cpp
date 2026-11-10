#include <string>
#include <utility>
#include <vector>

#include "activity_actor_definitions.h"
#include "avatar.h"
#include "bionics.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_utility.h"
#include "character_id.h"
#include "flexbuffer_json.h"
#include "item.h"
#include "item_action.h"
#include "item_contents.h"
#include "item_location.h"
#include "map.h"
#include "map_helpers.h"
#include "player_activity.h"
#include "player_helpers.h"
#include "pocket_type.h"
#include "recipe_dictionary.h"
#include "ret_val.h"
#include "type_id.h"
#include "units.h"

static const activity_id ACT_READ( "ACT_READ" );
static const bionic_id bio_ar( "bio_ar" );
static const bionic_id bio_power_storage( "bio_power_storage" );
static const itype_id itype_integrated_ar( "integrated_ar" );
static const itype_id itype_manual_electronics( "manual_electronics" );
static const itype_id itype_test_ebook_reader( "test_ebook_reader" );
static const itype_id itype_test_lamp( "test_lamp" );
static const skill_id skill_electronics( "electronics" );

TEST_CASE( "ebook_storage_survives_item_save_reload", "[reading][ereader][save]" )
{
    const itype_id device_type = GENERATE( itype_integrated_ar, itype_test_ebook_reader );
    CAPTURE( device_type.str() );
    item device( device_type );
    REQUIRE( device.put_in( item( itype_manual_electronics ), pocket_type::E_FILE_STORAGE ).success() );
    device.set_browsed( true );

    for( int cycle = 0; cycle < 3; ++cycle ) {
        CAPTURE( cycle );
        const std::string saved = serialize( device );
        item loaded;
        deserialize_from_string( loaded, saved );
        REQUIRE( loaded.get_contents().ebooks().size() == 1 );
        CHECK( loaded.get_contents().ebooks().front()->typeId() == itype_manual_electronics );
        CHECK( loaded.is_browsed() );
        device = std::move( loaded );
    }
}

TEST_CASE( "integrated_ar_books_remain_readable_and_supply_recipes_after_reload",
           "[reading][ereader][bionics][save][crafting]" )
{
    clear_avatar();
    clear_map_without_vision();
    avatar &you = get_avatar();
    you.add_bionic( bio_power_storage );
    you.add_bionic( bio_ar );
    you.set_power_level( you.get_max_power_level() );
    you.set_knowledge_level( skill_electronics, 2 );
    you.i_add( item( itype_test_lamp ) );

    const auto find_ar = [&you]() {
        for( const item_location &loc : you.top_items_loc() ) {
            if( loc->typeId() == itype_integrated_ar ) {
                return loc;
            }
        }
        return item_location();
    };
    item_location device = find_ar();
    REQUIRE( device );
    REQUIRE( device->put_in( item( itype_manual_electronics ),
                             pocket_type::E_FILE_STORAGE ).success() );
    you.identify( *device->get_contents().ebooks().front() );
    const auto recipes = device->get_contents().ebooks().front()->get_available_recipes( you );
    REQUIRE_FALSE( recipes.empty() );
    const recipe *expected_recipe = recipes.front().first;

    for( int cycle = 0; cycle < 3; ++cycle ) {
        CAPTURE( cycle );
        device = find_ar();
        REQUIRE( device );
        REQUIRE( device->get_contents().ebooks().size() == 1 );
        REQUIRE( device->is_estorage_usable( you ) );
        item_location book( device, device->get_contents().ebooks().front() );
        CHECK( you.has_identified( book->typeId() ) );
        you.invalidate_crafting_inventory();
        CHECK( you.get_recipes_from_ebooks( you.crafting_inventory() ).contains( expected_recipe ) );
        REQUIRE( you.fine_detail_vision_mod() == 1 );
        you.activity = player_activity( read_activity_actor( 1_minutes, book, device, false ) );
        you.activity.start_or_resume( you, false );
        you.activity.do_turn( you );
        CHECK( you.activity.id() == ACT_READ );
        you.cancel_activity();

        const std::string saved = serialize( you );
        clear_avatar();
        you.setID( character_id(), true );
        deserialize_from_string( you, saved );
    }
}

TEST_CASE( "scanning_via_integrated_ar_item_action_persists_the_actual_books",
           "[reading][ereader][bionics][save][crafting]" )
{
    clear_avatar();
    clear_map_without_vision();
    avatar &you = get_avatar();
    you.add_bionic( bio_power_storage );
    you.add_bionic( bio_ar );
    you.set_power_level( you.get_max_power_level() );
    you.set_knowledge_level( skill_electronics, 2 );
    you.i_add( item( itype_test_lamp ) );

    std::vector<item *> pseudos;
    for( const item *pseudo : you.get_pseudo_items() ) {
        pseudos.push_back( const_cast<item *>( pseudo ) );
    }
    const item_action_map actions = item_action_generator::generator().map_actions_to_items(
                                        you, pseudos, true );
    const auto scan = actions.find( "EBOOKSAVE" );
    REQUIRE( scan != actions.end() );
    item_location reader( you, scan->second );
    REQUIRE( reader );
    item_location paper = get_map().add_item_or_charges_ret_loc( you.pos_bub(),
                          item( itype_manual_electronics ) );
    you.activity = player_activity( ebooksave_activity_actor( { paper }, reader ) );
    you.activity.start_or_resume( you, false );
    process_activity( you, true );
    REQUIRE( reader->get_contents().ebooks().size() == 1 );
    const auto recipes = reader->get_contents().ebooks().front()->get_available_recipes( you );
    REQUIRE_FALSE( recipes.empty() );
    const recipe *expected_recipe = recipes.front().first;
    you.invalidate_crafting_inventory();
    CHECK( you.get_recipes_from_ebooks( you.crafting_inventory() ).contains( expected_recipe ) );

    const std::string saved = serialize( you );
    clear_avatar();
    you.setID( character_id(), true );
    deserialize_from_string( you, saved );

    int readers = 0;
    for( const item_location &loc : you.top_items_loc() ) {
        if( loc->typeId() == itype_integrated_ar ) {
            ++readers;
            reader = loc;
        }
    }
    REQUIRE( readers == 1 );
    REQUIRE( reader->get_contents().ebooks().size() == 1 );
    item_location book( reader, reader->get_contents().ebooks().front() );
    CHECK( book->typeId() == itype_manual_electronics );
    CHECK( you.has_identified( book->typeId() ) );
    you.invalidate_crafting_inventory();
    CHECK( you.get_recipes_from_ebooks( you.crafting_inventory() ).contains( expected_recipe ) );
    you.activity = player_activity( read_activity_actor( 1_minutes, book, reader, false ) );
    you.activity.start_or_resume( you, false );
    you.activity.do_turn( you );
    CHECK( you.activity.id() == ACT_READ );
    you.cancel_activity();
}
