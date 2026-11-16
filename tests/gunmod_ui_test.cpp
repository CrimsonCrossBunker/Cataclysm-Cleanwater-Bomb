#include <algorithm>
#include <functional>
#include <list>
#include <map>
#include <memory>
#include <optional>
#include <sstream>
#include <string>
#include <utility>
#include <vector>

#include "activity_actor.h"
#include "activity_actor_definitions.h"
#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "clone_ptr.h"
#include "flag.h"
#include "flexbuffer_json.h"
#include "gunmod_ui.h"
#include "item.h"
#include "item_location.h"
#include "item_pocket.h"
#include "itype.h"
#include "json.h"
#include "json_loader.h"
#include "player_activity.h"
#include "player_helpers.h"
#include "pocket_type.h"
#include "ret_val.h"
#include "type_id.h"
#include "value_ptr.h"

static const activity_id ACT_GUNMOD_ADD( "ACT_GUNMOD_ADD" );
static const itype_id itype_223( "223" );
static const itype_id itype_backpack( "backpack" );
static const itype_id itype_battery( "battery" );
static const itype_id itype_bow_sight( "bow_sight" );
static const itype_id itype_match_trigger( "match_trigger" );
static const itype_id itype_medium_battery_cell( "medium_battery_cell" );
static const itype_id itype_offset_sight_rail( "offset_sight_rail" );
static const itype_id itype_rail_mount( "rail_mount" );
static const itype_id itype_red_dot_sight( "red_dot_sight" );
static const itype_id itype_shoulder_strap( "shoulder_strap" );
static const itype_id itype_sl8( "sl8" );
static const itype_id itype_small_repairkit( "small_repairkit" );
static const trait_id trait_DEBUG_HS( "DEBUG_HS" );
static const gunmod_location location_mechanism( "mechanism" );
static const gunmod_location location_rail( "rail" );
static const gunmod_location location_sights( "sights" );

TEST_CASE( "gunmod_menu_layout_fits_terminal", "[gunmod][ui]" )
{
    const int width = GENERATE( 40, 80, 120, 200 );
    const int height = GENERATE( 10, 24, 40, 60 );
    const gunmod_ui::menu_layout layout = gunmod_ui::layout_for_terminal( width, height );
    CAPTURE( width, height );
    CHECK( layout.width == width );
    CHECK( layout.height == height );
    CHECK( layout.body_height > 0 );
    CHECK( layout.detail_height > 0 );
    CHECK( layout.body_height + layout.detail_height + 4 == height );
    CHECK( layout.left_width > 0 );
    CHECK( layout.left_width <= width - 2 );
    if( width == 40 ) {
        CHECK( layout.single_pane );
        CHECK( layout.left_width == width - 2 );
    }
    if( width >= 120 ) {
        CHECK_FALSE( layout.single_pane );
    }
}

TEST_CASE( "gunmod_preview_adds_and_expands_slots_without_mutating_items", "[gunmod][ui]" )
{
    std::unique_ptr<itype> gun_type = std::make_unique<itype>( *itype_sl8 );
    const bool existing_slot = GENERATE( false, true );
    if( !existing_slot ) {
        gun_type->gun->valid_mod_locations.erase( location_sights );
    }
    item gun( gun_type.get(), calendar::turn );
    item mod( itype_offset_sight_rail );
    const auto original_slots = gun.get_mod_locations();
    REQUIRE( gun.is_gunmod_compatible( mod ).success() );
    const item preview = gunmod_ui::preview_change( gun, mod, true );
    CHECK( gun.gunmods().empty() );
    CHECK( gun.get_mod_locations() == original_slots );
    CHECK( mod.typeId() == itype_offset_sight_rail );
    CHECK( preview.gunmod_find( itype_offset_sight_rail ) );
    const auto slots = gunmod_ui::preview_slots( gun, preview );
    const auto sight_slot = std::find_if( slots.begin(), slots.end(), []( const auto & entry ) {
        return entry.location == location_sights;
    } );
    REQUIRE( sight_slot != slots.end() );
    CHECK( sight_slot->capacity == ( existing_slot ? 1 : 0 ) );
    CHECK( sight_slot->preview_capacity == sight_slot->capacity + 1 );
    CHECK( sight_slot->used == 0 );
    CHECK( sight_slot->preview_used == 0 );
    const auto rail_slot = std::find_if( slots.begin(), slots.end(), []( const auto & entry ) {
        return entry.location == location_rail;
    } );
    REQUIRE( rail_slot != slots.end() );
    CHECK( rail_slot->preview_used == rail_slot->used + 1 );
}

TEST_CASE( "gunmod_removal_preview_restores_slots", "[gunmod][ui]" )
{
    item gun( itype_sl8 );
    item adapter( itype_offset_sight_rail );
    const auto original_slots = gun.get_mod_locations();
    REQUIRE( gun.put_in( adapter, pocket_type::MOD ).success() );
    const item preview = gunmod_ui::preview_change( gun, adapter, false );
    CHECK( gun.gunmod_find( itype_offset_sight_rail ) );
    CHECK_FALSE( preview.gunmod_find( itype_offset_sight_rail ) );
    CHECK( preview.get_mod_locations() == original_slots );
}

TEST_CASE( "gunmod_removal_accounts_for_every_added_slot", "[gunmod][ui]" )
{
    std::unique_ptr<itype> gun_type = std::make_unique<itype>( *itype_sl8 );
    gun_type->gun->valid_mod_locations.erase( location_sights );
    std::unique_ptr<itype> adapter_type = std::make_unique<itype>( *itype_offset_sight_rail );
    adapter_type->gunmod->add_mod[location_sights] = 2;
    item gun( gun_type.get(), calendar::turn );
    item adapter( adapter_type.get(), calendar::turn );
    REQUIRE( gun.put_in( adapter, pocket_type::MOD ).success() );
    REQUIRE( gunmod_ui::removal_denial( gun, adapter ).empty() );
    REQUIRE( gun.put_in( item( itype_red_dot_sight ), pocket_type::MOD ).success() );
    REQUIRE( gun.get_free_mod_locations( location_sights ) == 1 );
    CHECK_FALSE( gunmod_ui::removal_denial( gun, adapter ).empty() );
    const item preview = gunmod_ui::preview_change( gun, adapter, false );
    const auto slots = gunmod_ui::preview_slots( gun, preview );
    const auto sight_slot = std::find_if( slots.begin(), slots.end(), []( const auto & entry ) {
        return entry.location == location_sights;
    } );
    REQUIRE( sight_slot != slots.end() );
    CHECK( sight_slot->preview_capacity == 0 );
    CHECK( sight_slot->preview_used == 1 );
}

TEST_CASE( "gunmod_removal_blocks_permanent_and_loaded_modifications", "[gunmod][ui]" )
{
    item gun( itype_sl8 );
    CHECK_FALSE( gunmod_ui::removal_denial( gun, item( itype_rail_mount ) ).empty() );
    item trigger( itype_match_trigger );
    CHECK( gunmod_ui::removal_denial( gun, trigger ).empty() );
    gun.ammo_set( itype_223, 1 );
    REQUIRE( gun.ammo_remaining() == 1 );
    CHECK_FALSE( gunmod_ui::removal_denial( gun, trigger ).empty() );
}

TEST_CASE( "gunmod_removal_frees_its_own_added_slot_type", "[gunmod][ui]" )
{
    std::unique_ptr<itype> gun_type = std::make_unique<itype>( *itype_sl8 );
    gun_type->gun->valid_mod_locations[location_mechanism] = 2;
    std::unique_ptr<itype> adapter_type = std::make_unique<itype>( *itype_offset_sight_rail );
    adapter_type->gunmod->location = location_mechanism;
    adapter_type->gunmod->add_mod.clear();
    adapter_type->gunmod->add_mod[location_mechanism] = 2;
    item gun( gun_type.get(), calendar::turn );
    REQUIRE( gun.put_in( item( adapter_type.get(), calendar::turn ), pocket_type::MOD ).success() );
    const int other_mods = GENERATE( 1, 2, 3 );
    for( int index = 0; index < other_mods; ++index ) {
        REQUIRE( gun.put_in( item( itype_match_trigger ), pocket_type::MOD ).success() );
    }
    const item *adapter = gun.gunmod_find( itype_offset_sight_rail );
    REQUIRE( adapter );
    CHECK( gunmod_ui::removal_denial( gun, *adapter ).empty() == ( other_mods <= 2 ) );
}

TEST_CASE( "gunmod_menu_uses_authoritative_compatibility_reason", "[gunmod][ui]" )
{
    clear_avatar();
    avatar &you = get_avatar();
    arm_shooter( you, itype_sl8 );
    const item_location gun = you.get_wielded_item();
    item mod( itype_bow_sight );
    const auto result = gun->is_gunmod_compatible( mod );
    REQUIRE_FALSE( result.success() );
    CHECK( gunmod_ui::installation_denial( you, gun, mod ) == result.str() );
}

TEST_CASE( "gunmod_tool_preview_matches_installation_choices", "[gunmod][ui]" )
{
    clear_avatar();
    avatar &you = get_avatar();
    arm_shooter( you, itype_sl8 );
    const item_location gun = you.get_wielded_item();
    item mod( itype_shoulder_strap );
    mod.set_flag( flag_INSTALL_DIFFICULT );
    const auto odds = you.gunmod_installation_odds( gun, mod );
    REQUIRE( odds.first < 100 );
    auto options = gunmod_ui::installation_options( you, gun, mod );
    REQUIRE( options.size() == 3 );
    CHECK( options[0].success == odds.first );
    CHECK( options[0].damage == odds.second );
    CHECK( options[0].available );
    CHECK( options[1].success == std::min( odds.first * 2, 100 ) );
    CHECK( options[1].damage == odds.second / 2 );
    CHECK_FALSE( options[1].available );
    CHECK( options[2].success == std::min( odds.first * 3, 100 ) );
    CHECK( options[2].damage == 0 );
    CHECK_FALSE( options[2].available );
    item kit( options[1].tool );
    item battery( itype_medium_battery_cell );
    battery.ammo_set( itype_battery, 56 );
    REQUIRE( kit.put_in( battery, pocket_type::MAGAZINE_WELL ).success() );
    REQUIRE( kit.ammo_remaining() == 56 );
    const item_location stored_kit = you.i_add( kit );
    REQUIRE( stored_kit );
    you.i_add( kit );
    CAPTURE( stored_kit->ammo_remaining(), you.charges_of( options[1].tool ) );
    options = gunmod_ui::installation_options( you, gun, mod );
    CHECK( options[1].available );
}

TEST_CASE( "gunmod_installation_consumes_only_the_selected_tool", "[gunmod][activities]" )
{
    clear_avatar();
    avatar &you = get_avatar();
    arm_shooter( you, itype_sl8 );
    item_location gun = you.get_wielded_item();
    item_location mod = you.i_add( item( itype_shoulder_strap ) );
    item kit( itype_small_repairkit );
    item battery( itype_medium_battery_cell );
    battery.ammo_set( itype_battery, 56 );
    REQUIRE( kit.put_in( battery, pocket_type::MAGAZINE_WELL ).success() );
    item_location stored_kit = you.i_add( kit );
    REQUIRE( stored_kit );
    item_location second_kit = you.i_add( kit );
    REQUIRE( second_kit );
    REQUIRE( you.has_charges( kit.typeId(), 100 ) );
    you.assign_activity( gunmod_add_activity_actor( 0, "small_repairkit" ) );
    you.activity.targets = { gun, mod };
    you.activity.values = { 0, 100, 0, 100 };
    you.activity.actor->finish( you.activity, you );
    CHECK( gun->gunmod_find( itype_shoulder_strap ) );
    CHECK( stored_kit->ammo_remaining() + second_kit->ammo_remaining() == 12 );
}

TEST_CASE( "gunmod_installation_keeps_selected_item_instance", "[gunmod][activities]" )
{
    clear_avatar();
    avatar &you = get_avatar();
    arm_shooter( you, itype_sl8 );
    REQUIRE( you.wear_item( item( itype_backpack ), false, false ) );
    you.set_mutation( trait_DEBUG_HS );
    item first( itype_shoulder_strap );
    first.set_damage( 1000 );
    you.i_add( first );
    item second( itype_shoulder_strap );
    second.set_damage( 2000 );
    item_location selected = you.i_add( second );
    item_location gun = you.get_wielded_item();
    const bool wielded_mod = GENERATE( false, true );
    if( wielded_mod ) {
        selected.remove_item();
        gun = you.i_add( you.remove_weapon() );
        REQUIRE( gun );
        REQUIRE( you.wield( second ) );
        selected = you.get_wielded_item();
    }
    you.gunmod_add( *gun, *selected, itype_id::NULL_ID() );
    REQUIRE( you.activity.id() == ACT_GUNMOD_ADD );
    REQUIRE( you.activity.targets.size() == 2 );
    if( !wielded_mod ) {
        CHECK( you.activity.targets[1] == selected );
    }
    CHECK( you.activity.targets[1]->damage() == 2000 );
    you.activity.actor->finish( you.activity, you );
    const item *installed = you.get_wielded_item()->gunmod_find( itype_shoulder_strap );
    REQUIRE( installed );
    CHECK( installed->damage() == 2000 );
}

TEST_CASE( "gunmod_installation_preserves_mod_inside_relocated_gun", "[gunmod][activities]" )
{
    std::unique_ptr<itype> gun_type = std::make_unique<itype>( *itype_sl8 );
    gun_type->pockets.insert( gun_type->pockets.end(), itype_backpack->pockets.begin(),
                              itype_backpack->pockets.end() );
    clear_avatar();
    const on_out_of_scope cleanup( clear_avatar );
    avatar &you = get_avatar();
    REQUIRE( you.wear_item( item( itype_backpack ), false, false ) );
    you.set_mutation( trait_DEBUG_HS );
    item first( itype_shoulder_strap );
    first.set_damage( 1000 );
    you.i_add( first );
    item gun( gun_type.get(), calendar::turn );
    item second( itype_shoulder_strap );
    second.set_damage( 2000 );
    REQUIRE( gun.put_in( second, pocket_type::CONTAINER ).success() );
    item_location stored_gun = you.i_add( gun );
    REQUIRE( stored_gun );
    REQUIRE_FALSE( you.get_wielded_item() );
    item &selected = *stored_gun->all_items_top( pocket_type::CONTAINER ).front();
    you.gunmod_add( *stored_gun, selected, itype_id::NULL_ID() );
    REQUIRE( you.activity.id() == ACT_GUNMOD_ADD );
    REQUIRE( you.activity.targets.size() == 2 );
    CHECK( you.activity.targets[1]->damage() == 2000 );
    CHECK( you.get_wielded_item()->all_items_top( pocket_type::CONTAINER ).empty() );
    you.activity.actor->finish( you.activity, you );
    const item *installed = you.get_wielded_item()->gunmod_find( itype_shoulder_strap );
    REQUIRE( installed );
    CHECK( installed->damage() == 2000 );
}

TEST_CASE( "gunmod_installation_stages_mod_outside_wielded_container", "[gunmod][activities]" )
{
    clear_avatar();
    avatar &you = get_avatar();
    const bool storage_available = GENERATE( false, true );
    item gun( itype_sl8 );
    if( storage_available ) {
        REQUIRE( you.wear_item( item( itype_backpack ), false, false ) );
    }
    you.set_mutation( trait_DEBUG_HS );
    item bag( itype_backpack );
    item mod( itype_shoulder_strap );
    mod.set_damage( 2000 );
    REQUIRE( bag.put_in( mod, pocket_type::CONTAINER ).success() );
    REQUIRE( you.wield( bag ) );
    item_location held_bag = you.get_wielded_item();
    item &selected = *held_bag->all_items_top( pocket_type::CONTAINER ).front();
    you.gunmod_add( gun, selected, itype_id::NULL_ID() );
    CHECK_FALSE( you.activity );
    REQUIRE( held_bag );
    CHECK( held_bag->all_items_top( pocket_type::CONTAINER ).empty() == storage_available );
    const std::vector<item *> mods = you.items_with( []( const item & candidate ) {
        return candidate.typeId() == itype_shoulder_strap;
    } );
    REQUIRE( mods.size() == 1 );
    CHECK( mods.front()->damage() == 2000 );
}

TEST_CASE( "gunmod_installation_rechecks_tool_charges_at_completion", "[gunmod][activities]" )
{
    clear_avatar();
    avatar &you = get_avatar();
    arm_shooter( you, itype_sl8 );
    item_location gun = you.get_wielded_item();
    item_location mod = you.i_add( item( itype_shoulder_strap ) );
    you.assign_activity( gunmod_add_activity_actor( 0, "small_repairkit" ) );
    you.activity.targets = { gun, mod };
    you.activity.values = { 0, 100, 0, 100 };
    you.activity.actor->finish( you.activity, you );
    CHECK_FALSE( gun->gunmod_find( itype_shoulder_strap ) );
    CHECK( mod );
    CHECK_FALSE( you.activity );
}

TEST_CASE( "gunmod_menu_return_flag_round_trips_and_defaults_off", "[gunmod][activities][save]" )
{
    gunmod_add_activity_actor actor( 100, "" );
    CHECK_FALSE( actor.reopen_menu );
    actor.reopen_menu = true;
    std::ostringstream stream;
    JsonOut output( stream );
    actor.serialize( output );
    JsonValue data = json_loader::from_string( stream.str() );
    const auto restored = gunmod_add_activity_actor::deserialize( data );
    CHECK( dynamic_cast<const gunmod_add_activity_actor &>( *restored ).reopen_menu );
    JsonValue legacy = json_loader::from_string( R"({"moves":100,"name":""})" );
    const auto old_actor = gunmod_add_activity_actor::deserialize( legacy );
    CHECK_FALSE( dynamic_cast<const gunmod_add_activity_actor &>( *old_actor ).reopen_menu );

    gunmod_remove_activity_actor removal( 100, item_location::nowhere, 0 );
    CHECK_FALSE( removal.reopen_menu );
    removal.reopen_menu = true;
    std::ostringstream removal_stream;
    JsonOut removal_output( removal_stream );
    removal.serialize( removal_output );
    JsonValue removal_data = json_loader::from_string( removal_stream.str() );
    const auto restored_removal = gunmod_remove_activity_actor::deserialize( removal_data );
    CHECK( dynamic_cast<const gunmod_remove_activity_actor &>( *restored_removal ).reopen_menu );
}
