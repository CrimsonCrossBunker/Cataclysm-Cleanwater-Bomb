#include <cstddef>
#include <functional>
#include <list>
#include <optional>
#include <set>
#include <sstream>
#include <string>
#include <vector>

#include "activity_actor.h"
#include "activity_actor_definitions.h"
#include "avatar.h"
#include "avatar_action.h"
#include "calendar.h"
#include "cata_catch.h"
#include "clone_ptr.h"
#include "coordinates.h"
#include "debug.h"
#include "enums.h"
#include "flexbuffer_json.h"
#include "item.h"
#include "item_contents.h"
#include "item_location.h"
#include "iuse.h"
#include "json.h"
#include "json_loader.h"
#include "map.h"
#include "map_helpers.h"
#include "map_selector.h"
#include "player_activity.h"
#include "player_helpers.h"
#include "pocket_type.h"
#include "point.h"
#include "ret_val.h"
#include "type_id.h"
#include "units.h"
#include "vehicle.h"
#include "vehicle_selector.h"
#include "vpart_position.h"

static const itype_id itype_backpack( "backpack" );
static const itype_id itype_diving_flashlight_small_hipower( "diving_flashlight_small_hipower" );
static const itype_id itype_light_battery_cell( "light_battery_cell" );
static const itype_id itype_magazine_battery_medium_mod( "magazine_battery_medium_mod" );
static const itype_id itype_medium_battery_cell( "medium_battery_cell" );

static const vproto_id vehicle_prototype_test_shopping_cart( "test_shopping_cart" );

static void finish_toolmod_installation( avatar &you, const item_location &tool,
        const item_location &mod )
{
    toolmod_add_activity_actor actor( 1_minutes, tool, mod );
    player_activity activity;
    actor.finish( activity, you );
}

TEST_CASE( "activating_installed_toolmod_does_not_obtain_it", "[item][toolmod][regression]" )
{
    clear_avatar();
    clear_map();
    avatar &you = get_avatar();
    map &here = get_map();
    REQUIRE( you.wear_item( item( itype_backpack ) ).has_value() );
    const bool explicit_method = GENERATE( false, true );
    item_location tool;

    SECTION( "carried_tool" ) {
        tool = you.i_add( item( itype_diving_flashlight_small_hipower ) );
    }
    SECTION( "ground_tool" ) {
        tool = item_location( map_cursor( you.pos_bub() ),
                              &here.add_item( you.pos_bub(), item( itype_diving_flashlight_small_hipower ) ) );
    }
    SECTION( "vehicle_cargo_tool" ) {
        const tripoint_bub_ms vehicle_pos = you.pos_bub() + tripoint::east;
        REQUIRE( here.add_vehicle( vehicle_prototype_test_shopping_cart, vehicle_pos, 0_degrees,
                                   0, veh_spawn_status::UNDAMAGED ) );
        const std::optional<vpart_reference> cargo = here.veh_at( here.get_abs( vehicle_pos ) ).cargo();
        REQUIRE( cargo );
        const std::optional<vehicle_stack::iterator> added = cargo->vehicle().add_item(
                    here, cargo->part(), item( itype_diving_flashlight_small_hipower ) );
        REQUIRE( added );
        tool = item_location( vehicle_cursor( cargo->vehicle(), cargo->part_index() ), & **added );
    }

    REQUIRE( tool );
    REQUIRE( tool->put_in( item( itype_magazine_battery_medium_mod ), pocket_type::MOD ).success() );
    REQUIRE( tool->put_in( item( itype_medium_battery_cell ), pocket_type::MAGAZINE_WELL ).success() );
    item *installed = tool->toolmods().front();
    item *battery = tool->magazine_current();
    REQUIRE( battery );
    battery->ammo_set( battery->ammo_default(), 20 );
    const int charges = battery->ammo_remaining();
    REQUIRE( charges > 0 );
    const std::set<itype_id> batteries = tool->magazine_compatible();
    item_location mod( tool, installed );
    const std::string method = explicit_method ? "TOOLMOD_ATTACH" : "";
    const int moves = you.get_moves();

    avatar_action::use_item( you, mod, method );

    REQUIRE( mod );
    REQUIRE( mod.has_parent() );
    CHECK( mod.parent_item() == tool );
    CHECK( mod.get_item() == installed );
    REQUIRE( tool->toolmods().size() == 1 );
    CHECK( tool->toolmods().front() == installed );
    CHECK( tool->magazine_compatible() == batteries );
    CHECK( tool->magazine_current() == battery );
    CHECK( battery->ammo_remaining() == charges );
    CHECK( you.get_moves() == moves );
    CHECK_FALSE( you.activity );
}

TEST_CASE( "installed_toolmod_cannot_be_reused", "[item][toolmod][activity][regression]" )
{
    clear_avatar();
    clear_map();
    avatar &you = get_avatar();
    map &here = get_map();
    const bool on_map = GENERATE( false, true );
    item_location first = on_map ?
                          item_location( map_cursor( you.pos_bub() ),
                                         &here.add_item( you.pos_bub(), item( itype_diving_flashlight_small_hipower ) ) ) :
                          you.i_add( item( itype_diving_flashlight_small_hipower ) );
    item_location second = you.i_add( item( itype_diving_flashlight_small_hipower ) );
    REQUIRE( first->put_in( item( itype_magazine_battery_medium_mod ), pocket_type::MOD ).success() );
    item *installed = first->toolmods().front();
    item_location mod( first, installed );
    if( GENERATE( false, true ) ) {
        mod = on_map ? item_location( map_cursor( you.pos_bub() ), installed ) :
              item_location( you, installed );
    }
    const std::set<itype_id> first_batteries = first->magazine_compatible();
    const std::set<itype_id> second_batteries = second->magazine_compatible();

    finish_toolmod_installation( you, second, mod );

    REQUIRE( first->toolmods().size() == 1 );
    CHECK( first->toolmods().front() == installed );
    CHECK( first->magazine_compatible() == first_batteries );
    CHECK( second->toolmods().empty() );
    CHECK( second->magazine_compatible() == second_batteries );

    you.toolmod_add( second, mod );
    CHECK_FALSE( you.activity );
    if( !on_map ) {
        CHECK_FALSE( iuse::toolmod_attach( &you, installed, you.pos_bub() ).has_value() );
    }
}

TEST_CASE( "toolmod_installation_revalidates_target", "[item][toolmod][activity][regression]" )
{
    clear_avatar();
    avatar &you = get_avatar();
    item_location tool = you.i_add( item( itype_diving_flashlight_small_hipower ) );
    item_location mod = you.i_add( item( itype_magazine_battery_medium_mod ) );
    mod->set_var( "toolmod_test", "original" );
    toolmod_add_activity_actor actor( 1_minutes, tool, mod );
    player_activity activity;

    SECTION( "battery_inserted_during_installation" ) {
        REQUIRE( tool->put_in( item( itype_light_battery_cell ), pocket_type::MAGAZINE_WELL ).success() );
    }
    SECTION( "another_mod_installed_during_installation" ) {
        REQUIRE( tool->put_in( item( itype_magazine_battery_medium_mod ), pocket_type::MOD ).success() );
    }
    SECTION( "target_no_longer_a_tool" ) {
        tool->convert( itype_light_battery_cell );
    }
    SECTION( "source_no_longer_a_toolmod" ) {
        mod->convert( itype_light_battery_cell );
    }
    const std::set<itype_id> batteries = tool->magazine_compatible();
    const std::size_t mod_count = tool->toolmods().size();

    actor.finish( activity, you );

    REQUIRE( mod );
    CHECK( mod->get_var( "toolmod_test" ) == "original" );
    CHECK( tool->toolmods().size() == mod_count );
    CHECK( tool->magazine_compatible() == batteries );
}

TEST_CASE( "loose_toolmod_can_be_removed_and_reinstalled", "[item][toolmod][activity][regression]" )
{
    clear_avatar();
    avatar &you = get_avatar();
    item_location first = you.i_add( item( itype_diving_flashlight_small_hipower ) );
    item_location second = you.i_add( item( itype_diving_flashlight_small_hipower ) );
    item_location backpack = you.i_add( item( itype_backpack ) );
    item loose_mod( itype_magazine_battery_medium_mod );
    loose_mod.set_var( "toolmod_test", "original" );
    REQUIRE( backpack->put_in( loose_mod, pocket_type::CONTAINER ).success() );
    item_location mod( backpack, backpack->all_items_container_top().front() );
    const std::set<itype_id> base_batteries = first->magazine_compatible();

    you.toolmod_add( first, mod );
    REQUIRE( you.activity );
    you.activity.actor->finish( you.activity, you );

    REQUIRE( first->toolmods().size() == 1 );
    CHECK( backpack->all_items_container_top().empty() );
    CHECK( first->can_reload_with( item( itype_medium_battery_cell ), true ) );
    CHECK_FALSE( first->can_reload_with( item( itype_light_battery_cell ), true ) );
    item *installed = first->toolmods().front();
    CHECK( installed->get_var( "toolmod_test" ) == "original" );
    item removed = first->remove_item( *installed );
    first->on_contents_changed();
    REQUIRE( first->toolmods().empty() );
    CHECK( first->magazine_compatible() == base_batteries );
    item_location detached = you.i_add( removed );

    finish_toolmod_installation( you, second, detached );

    REQUIRE( second->toolmods().size() == 1 );
    CHECK( second->toolmods().front()->get_var( "toolmod_test" ) == "original" );
    CHECK( first->magazine_compatible() == base_batteries );
    CHECK( second->can_reload_with( item( itype_medium_battery_cell ), true ) );
}

TEST_CASE( "recursive_toolmod_removal_restores_battery_well",
           "[item][toolmod][pocket][regression]" )
{
    clear_avatar();
    avatar &you = get_avatar();
    item_location tool = you.i_add( item( itype_diving_flashlight_small_hipower ) );
    const std::set<itype_id> base_batteries = tool->magazine_compatible();
    REQUIRE( tool->put_in( item( itype_magazine_battery_medium_mod ), pocket_type::MOD ).success() );
    item *mod = tool->toolmods().front();
    const bool with_battery = GENERATE( false, true );
    int battery_charges = 0;
    if( with_battery ) {
        item battery( itype_medium_battery_cell );
        battery.ammo_set( battery.ammo_default(), 123 );
        battery_charges = battery.ammo_remaining();
        REQUIRE( battery_charges > 0 );
        battery.set_var( "toolmod_test", "preserved_battery" );
        REQUIRE( tool->put_in( battery, pocket_type::MAGAZINE_WELL ).success() );
    }

    item removed = you.remove_item( *mod );

    CHECK( removed.typeId() == itype_magazine_battery_medium_mod );
    CHECK( tool->toolmods().empty() );
    CHECK( tool->magazine_compatible() == base_batteries );
    CHECK( tool->can_reload_with( item( itype_light_battery_cell ), true ) );
    CHECK_FALSE( tool->can_reload_with( item( itype_medium_battery_cell ), true ) );
    if( with_battery ) {
        const auto migrated = tool->all_items_top( pocket_type::MIGRATION );
        REQUIRE( migrated.size() == 1 );
        CHECK( migrated.front()->typeId() == itype_medium_battery_cell );
        CHECK( migrated.front()->get_var( "toolmod_test" ) == "preserved_battery" );
        CHECK( migrated.front()->ammo_remaining() == battery_charges );
    }

    std::ostringstream stream;
    JsonOut json( stream );
    tool->serialize( json );
    item restored;
    restored.deserialize( json_loader::from_string( stream.str() ).get_object() );
    CHECK( restored.toolmods().empty() );
    CHECK( restored.magazine_compatible() == base_batteries );
}

TEST_CASE( "toolmod_installation_rejects_missing_locations",
           "[item][toolmod][activity][regression]" )
{
    clear_avatar();
    avatar &you = get_avatar();
    item_location tool = you.i_add( item( itype_diving_flashlight_small_hipower ) );
    item_location mod = you.i_add( item( itype_magazine_battery_medium_mod ) );
    const bool missing_tool = GENERATE( false, true );
    const std::string diagnostic = capture_debugmsg_during( [&]() {
        you.toolmod_add( missing_tool ? item_location::nowhere : tool,
                         missing_tool ? mod : item_location::nowhere );
    } );
    CHECK_THAT( diagnostic, Catch::Matchers::Contains( "mod/tool not available" ) );
    CHECK_FALSE( you.activity );
    CHECK( tool->toolmods().empty() );
    CHECK( mod );
}

TEST_CASE( "toolmod_activity_handles_disappearing_items", "[item][toolmod][activity][regression]" )
{
    clear_avatar();
    avatar &you = get_avatar();
    item_location tool = you.i_add( item( itype_diving_flashlight_small_hipower ) );
    item_location mod = you.i_add( item( itype_magazine_battery_medium_mod ) );
    toolmod_add_activity_actor actor( 1_minutes, tool, mod );
    player_activity activity;
    const bool remove_tool = GENERATE( false, true );
    if( remove_tool ) {
        tool.remove_item();
    } else {
        mod.remove_item();
    }

    const std::string diagnostic = capture_debugmsg_during( [&]() {
        actor.finish( activity, you );
    } );

    CHECK_THAT( diagnostic, Catch::Matchers::Contains( "lost target tool or toolmod" ) );
    if( remove_tool ) {
        CHECK( mod );
    } else {
        CHECK( tool->toolmods().empty() );
    }
}

TEST_CASE( "failed_toolmod_insertion_preserves_source", "[item][toolmod][activity][regression]" )
{
    clear_avatar();
    avatar &you = get_avatar();
    item_location tool = you.i_add( item( itype_diving_flashlight_small_hipower ) );
    item_location mod = you.i_add( item( itype_magazine_battery_medium_mod ) );
    mod->set_var( "toolmod_test", "original" );
    tool->get_contents() = item_contents();

    const std::string diagnostic = capture_debugmsg_during( [&]() {
        finish_toolmod_installation( you, tool, mod );
    } );

    CHECK_THAT( diagnostic, Catch::Matchers::Contains( "pocket with type (MOD) not found" ) );
    REQUIRE( mod );
    CHECK( mod->get_var( "toolmod_test" ) == "original" );
    CHECK( tool->toolmods().empty() );
}
