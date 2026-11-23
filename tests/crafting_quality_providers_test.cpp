#include <algorithm>
#include <set>
#include <string>
#include <vector>

#include "avatar.h"
#include "bionics.h"
#include "cata_catch.h"
#include "cata_utility.h"
#include "coordinates.h"
#include "crafting_gui.h"
#include "input_context.h"
#include "item.h"
#include "itype.h"
#include "localized_comparator.h"
#include "map.h"
#include "map_helpers.h"
#include "player_helpers.h"
#include "point.h"
#include "requirements.h"
#include "string_formatter.h"
#include "temp_crafting_inventory.h"
#include "type_id.h"
#include "units.h"
#include "vehicle.h"

static const bionic_id test_bio_reserve_two_pseudo( "test_bio_reserve_two_pseudo" );

static const furn_str_id furn_test_f_reserve_qual( "test_f_reserve_qual" );

static const itype_id itype_battery( "battery" );
static const itype_id itype_brick_oven_pseudo( "brick_oven_pseudo" );
static const itype_id itype_test_reserve_bionic_tool_1( "test_reserve_bionic_tool_1" );
static const itype_id
itype_test_reserve_charged_quality_tool( "test_reserve_charged_quality_tool" );
static const itype_id itype_test_reserve_pseudo_kiln( "test_reserve_pseudo_kiln" );
static const itype_id itype_test_reserve_tool_a( "test_reserve_tool_a" );
static const itype_id itype_test_reserve_tool_a_good( "test_reserve_tool_a_good" );
static const itype_id itype_test_reserve_tool_b( "test_reserve_tool_b" );

static const quality_id qual_TEST_RESERVE_A( "TEST_RESERVE_A" );
static const quality_id qual_TEST_RESERVE_C( "TEST_RESERVE_C" );

static const ter_str_id ter_t_brick_oven( "t_brick_oven" );

static const trait_id trait_TEST_RESERVE_QUALITIES( "TEST_RESERVE_QUALITIES" );

static const vpart_id vpart_frame( "frame" );
static const vpart_id vpart_test_vp_reserve_qual( "test_vp_reserve_qual" );

static const vproto_id vehicle_prototype_none( "none" );

static const quality_provider *find_provider( const std::vector<quality_provider> &providers,
        const itype_id &type )
{
    const std::vector<quality_provider>::const_iterator found = std::find_if( providers.begin(),
    providers.end(), [&type]( const quality_provider & provider ) {
        return provider.type == type;
    } );
    return found == providers.end() ? nullptr : &*found;
}

static quality_provider_list list_for( avatar &u, const quality_requirement &need )
{
    u.invalidate_crafting_inventory();
    return list_quality_providers( need, u.crafting_inventory(), u );
}

static std::string nearby_name( avatar &u, const quality_requirement &need, const itype_id &type )
{
    const quality_provider_list found = list_for( u, need );
    const quality_provider *provider = find_provider( found.nearby, type );
    REQUIRE( provider != nullptr );
    CHECK( find_provider( found.others, type ) == nullptr );
    return provider->name;
}

static void add_rig( map &here, const tripoint_bub_ms &pos, bool appliance )
{
    vehicle *veh = here.add_vehicle( vehicle_prototype_none, pos, 0_degrees, 0,
                                     veh_spawn_status::UNDAMAGED );
    REQUIRE( veh != nullptr );
    REQUIRE( veh->install_part( here, point_rel_ms::zero, vpart_frame ) != -1 );
    REQUIRE( veh->install_part( here, point_rel_ms::zero, vpart_test_vp_reserve_qual ) != -1 );
    if( appliance ) {
        veh->add_tag( "APPLIANCE" );
    }
    veh->refresh();
    here.add_vehicle_to_cache( veh );
}

TEST_CASE( "quality_providers_separate_nearby_tools_from_other_items",
           "[crafting][quality_providers]" )
{
    clear_avatar();
    clear_map_without_vision();
    avatar &u = get_avatar();

    SECTION( "nothing in reach" ) {
        const quality_provider_list found = list_for( u, quality_requirement( qual_TEST_RESERVE_A, 1,
                                            1 ) );
        CHECK( found.intrinsic.empty() );
        CHECK( found.nearby.empty() );
        const quality_provider *plain = find_provider( found.others, itype_test_reserve_tool_a );
        REQUIRE( plain != nullptr );
        CHECK( plain->name == itype_test_reserve_tool_a->nname( 1 ) );
        CHECK( plain->level == 1 );
    }

    SECTION( "a level the carried tool meets" ) {
        u.i_add( item( itype_test_reserve_tool_a ) );
        const quality_provider_list found = list_for( u, quality_requirement( qual_TEST_RESERVE_A, 1,
                                            1 ) );
        const quality_provider *carried = find_provider( found.nearby, itype_test_reserve_tool_a );
        REQUIRE( carried != nullptr );
        CHECK( carried->name == itype_test_reserve_tool_a->nname( 1 ) );
        CHECK( carried->level == 1 );
        CHECK( find_provider( found.others, itype_test_reserve_tool_a ) == nullptr );
        const quality_provider *better = find_provider( found.others, itype_test_reserve_tool_a_good );
        REQUIRE( better != nullptr );
        CHECK( better->level == 3 );
        CHECK( find_provider( found.others, itype_test_reserve_tool_b ) == nullptr );
        CHECK( find_provider( found.others, itype_test_reserve_pseudo_kiln ) == nullptr );
    }

    SECTION( "a level only another item type meets" ) {
        u.i_add( item( itype_test_reserve_tool_a ) );
        const quality_provider_list found = list_for( u, quality_requirement( qual_TEST_RESERVE_A, 1,
                                            2 ) );
        CHECK( find_provider( found.nearby, itype_test_reserve_tool_a ) == nullptr );
        CHECK( find_provider( found.others, itype_test_reserve_tool_a ) == nullptr );
        const quality_provider *better = find_provider( found.others, itype_test_reserve_tool_a_good );
        REQUIRE( better != nullptr );
        CHECK( better->level == 3 );
    }

    SECTION( "entries are sorted by name" ) {
        u.i_add( item( itype_test_reserve_tool_a ) );
        u.i_add( item( itype_test_reserve_tool_a_good ) );
        const quality_provider_list found = list_for( u, quality_requirement( qual_TEST_RESERVE_A, 1,
                                            1 ) );
        const auto by_name = []( const quality_provider & a, const quality_provider & b ) {
            return localized_compare( a.name, b.name );
        };
        CHECK( found.nearby.size() >= 2 );
        CHECK( found.others.size() >= 2 );
        CHECK( std::is_sorted( found.nearby.begin(), found.nearby.end(), by_name ) );
        CHECK( std::is_sorted( found.others.begin(), found.others.end(), by_name ) );
    }
}

TEST_CASE( "quality_providers_need_charges_for_charged_qualities", "[crafting][quality_providers]" )
{
    clear_avatar();
    clear_map_without_vision();
    avatar &u = get_avatar();
    const quality_requirement need( qual_TEST_RESERVE_C, 1, 1 );

    SECTION( "a tool without charges" ) {
        u.i_add( item( itype_test_reserve_charged_quality_tool ) );
        const quality_provider_list found = list_for( u, need );
        CHECK( find_provider( found.nearby, itype_test_reserve_charged_quality_tool ) == nullptr );
        const quality_provider *listed = find_provider( found.others,
                                         itype_test_reserve_charged_quality_tool );
        REQUIRE( listed != nullptr );
        CHECK( listed->name == string_format( "%s (needs charges)",
                                              itype_test_reserve_charged_quality_tool->nname( 1 ) ) );
        CHECK( listed->level == 1 );
    }

    SECTION( "a tool with charges" ) {
        item tool( itype_test_reserve_charged_quality_tool );
        tool.ammo_set( itype_battery, 10 );
        REQUIRE( tool.ammo_remaining() > 0 );
        u.i_add( tool );
        const quality_provider_list found = list_for( u, need );
        const quality_provider *carried = find_provider( found.nearby,
                                          itype_test_reserve_charged_quality_tool );
        REQUIRE( carried != nullptr );
        CHECK( carried->level == 1 );
        CHECK( find_provider( found.others, itype_test_reserve_charged_quality_tool ) == nullptr );
    }
}

TEST_CASE( "quality_providers_name_the_source_of_pseudo_tools", "[crafting][quality_providers]" )
{
    clear_avatar();
    clear_map_without_vision();
    clear_vehicles();
    avatar &u = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms origin( 60, 60, 0 );
    u.setpos( here, origin );
    const tripoint_bub_ms east = origin + point::east;
    const quality_requirement need( qual_TEST_RESERVE_A, 1, 1 );
    const std::string furniture = string_format( "%s (furniture)",
                                  furn_test_f_reserve_qual->name() );
    const std::string part = vpart_test_vp_reserve_qual->name();

    SECTION( "furniture" ) {
        REQUIRE( here.furn_set( east, furn_test_f_reserve_qual ) );
        CHECK( nearby_name( u, need, itype_test_reserve_pseudo_kiln ) == furniture );
    }

    SECTION( "terrain" ) {
        const itype &oven = itype_brick_oven_pseudo.obj();
        REQUIRE( !oven.qualities.empty() );
        const quality_requirement oven_need( oven.qualities.begin()->first, 1,
                                             oven.qualities.begin()->second.level );
        REQUIRE( here.ter_set( east, ter_t_brick_oven ) );
        CHECK( nearby_name( u, oven_need, itype_brick_oven_pseudo ) ==
               string_format( "%s (terrain)", ter_t_brick_oven->name() ) );
    }

    SECTION( "vehicle part" ) {
        add_rig( here, east, false );
        CHECK( nearby_name( u, need, itype_test_reserve_pseudo_kiln ) ==
               string_format( "%s (vehicle)", part ) );
    }

    SECTION( "appliance" ) {
        add_rig( here, east, true );
        CHECK( nearby_name( u, need, itype_test_reserve_pseudo_kiln ) ==
               string_format( "%s (appliance)", part ) );
    }

    SECTION( "furniture and vehicle part supplying the same tool" ) {
        REQUIRE( here.furn_set( east, furn_test_f_reserve_qual ) );
        add_rig( here, origin + point::west, false );
        CHECK( nearby_name( u, need, itype_test_reserve_pseudo_kiln ) ==
               string_format( "%s, %s (vehicle)", furniture, part ) );
    }
}

TEST_CASE( "quality_providers_name_the_crafters_own_sources", "[crafting][quality_providers]" )
{
    clear_avatar();
    clear_map_without_vision();
    avatar &u = get_avatar();
    const quality_requirement need( qual_TEST_RESERVE_A, 1, 1 );

    SECTION( "nothing of the crafter's own" ) {
        CHECK( list_for( u, need ).intrinsic.empty() );
    }

    SECTION( "mutation" ) {
        u.set_mutation( trait_TEST_RESERVE_QUALITIES );
        CHECK( list_for( u, need ).intrinsic ==
               std::set<std::string> { u.mutation_name( trait_TEST_RESERVE_QUALITIES ) } );
    }

    SECTION( "bionic" ) {
        u.add_bionic( test_bio_reserve_two_pseudo );
        const quality_provider_list found = list_for( u, need );
        CHECK( found.intrinsic ==
               std::set<std::string> { test_bio_reserve_two_pseudo->name.translated() } );
        CHECK( find_provider( found.nearby, itype_test_reserve_bionic_tool_1 ) == nullptr );
        CHECK( find_provider( found.others, itype_test_reserve_bionic_tool_1 ) == nullptr );
    }
}

TEST_CASE( "quality_providers_agree_with_the_requirement_availability",
           "[crafting][quality_providers]" )
{
    clear_avatar();
    clear_map_without_vision();
    avatar &u = get_avatar();
    const quality_requirement level_one( qual_TEST_RESERVE_A, 1, 1 );
    const quality_requirement level_two( qual_TEST_RESERVE_A, 1, 2 );
    const quality_requirement charged( qual_TEST_RESERVE_C, 1, 1 );
    const auto check = [&u]( const quality_requirement & need, bool available ) {
        const quality_provider_list found = list_for( u, need );
        CHECK( ( !found.intrinsic.empty() || !found.nearby.empty() ) == available );
        CHECK( need.has( &u, u.crafting_inventory(), return_true<item>, 1 ) == available );
    };

    SECTION( "nothing in reach" ) {
        check( level_one, false );
        check( charged, false );
    }

    SECTION( "a carried tool" ) {
        u.i_add( item( itype_test_reserve_tool_a ) );
        check( level_one, true );
        check( level_two, false );
    }

    SECTION( "a carried tool of a higher level" ) {
        u.i_add( item( itype_test_reserve_tool_a_good ) );
        check( level_two, true );
    }

    SECTION( "a mutation" ) {
        u.set_mutation( trait_TEST_RESERVE_QUALITIES );
        check( level_one, true );
        check( level_two, false );
    }

    SECTION( "a charged tool" ) {
        item tool( itype_test_reserve_charged_quality_tool );
        SECTION( "without charges" ) {
            u.i_add( tool );
            check( charged, false );
        }
        SECTION( "with charges" ) {
            tool.ammo_set( itype_battery, 10 );
            u.i_add( tool );
            check( charged, true );
        }
    }
}

TEST_CASE( "construction_menu_binds_t_to_the_quality_item_list", "[construction][keybindings]" )
{
    input_context ctxt( "CONSTRUCTION" );
    ctxt.register_action( "LIST_QUALITY_ITEMS" );
    CHECK( ctxt.get_desc( "LIST_QUALITY_ITEMS" ) == "t" );
}
