#include <algorithm>
#include <set>
#include <string>
#include <vector>

#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_utility.h"
#include "coordinates.h"
#include "crafting.h"
#include "item.h"
#include "iteminfo_query.h"
#include "localized_comparator.h"
#include "map.h"
#include "map_helpers.h"
#include "output.h"
#include "player_helpers.h"
#include "point.h"
#include "recipe.h"
#include "recipe_dictionary.h"
#include "requirements.h"
#include "rng.h"
#include "string_formatter.h"
#include "temp_crafting_inventory.h"
#include "translations.h"
#include "type_id.h"
#include "visitable.h"

static const itype_id itype_leather( "leather" );
static const itype_id itype_hammer( "hammer" );
static const itype_id itype_plant_fibre( "plant_fibre" );
static const itype_id itype_rock( "rock" );
static const itype_id itype_sinew( "sinew" );
static const quality_id qual_HAMMER( "HAMMER" );

static void prepare_material_inspection()
{
    clear_avatar();
    clear_map_without_vision();
    avatar &you = get_avatar();
    recipe_subset &known = const_cast<recipe_subset &>( you.get_learned_recipes() );
    known.clear();
    for( const auto &entry : recipe_dict ) {
        if( !entry.second.result().is_null() ) {
            known.include( &entry.second );
        }
    }
    // Distinct items exercise inventory requirement scans without relying on
    // whether a particular material is represented as a charge stack.
    map &here = get_map();
    for( int i = 0; i < 1300; ++i ) {
        item rock( itype_rock );
        rock.set_var( "material_inspection_fixture", i );
        const tripoint_bub_ms pos = you.pos_bub() + point( i % 5 - 2, i / 5 % 5 - 2 );
        here.add_item_or_charges( pos, rock );
    }
    you.invalidate_crafting_inventory();
}

static std::string material_recipe_info( const itype_id &type )
{
    std::vector<iteminfo> info;
    const iteminfo_query query( { iteminfo_parts::DESCRIPTION_APPLICABLE_RECIPES } );
    item( type ).info( info, &query );
    return format_item_info( info, {} );
}

// The original exhaustive listing is an oracle for both availability colors
// and locale-dependent ordering; omitted entries must still contribute to the count.
static std::string exhaustive_recipe_info( const itype_id &type )
{
    avatar &you = get_avatar();
    const temp_crafting_inventory &inv = you.crafting_inventory();
    scoped_provider_quality_cache qualities( inv );
    const std::set<const recipe *> &recipes = you.get_group_available_recipes().of_component( type );
    std::vector<std::string> names;
    for( const recipe *r : recipes ) {
        const bool can_make = r->deduped_requirements().can_make_with_inventory(
                                  &you, inv, r->get_component_filter() );
        const std::string name = r->result_name( true );
        names.push_back( can_make ? name : string_format( "<dark>%s</dark>", name ) );
    }
    std::vector<std::string> shown( std::min<size_t>( 15, names.size() ) );
    std::partial_sort_copy( names.begin(), names.end(), shown.begin(), shown.end(), localized_compare );
    const std::string listing = names.size() == shown.size() ? enumerate_as_string( shown ) :
                                string_format( _( "%s, and %d more" ),
                                        enumerate_as_string( shown, enumeration_conjunction::none ),
                                        static_cast<int>( names.size() - shown.size() ) );
    std::vector<iteminfo> info;
    info.emplace_back( "DESCRIPTION", "--" );
    info.emplace_back( " DESCRIPTION", string_format( _( "You could use it to craft: %s" ), listing ) );
    return format_item_info( info, {} );
}

TEST_CASE( "material_recipe_preview_matches_the_exhaustive_listing",
           "[iteminfo][material_iteminfo]" )
{
    const itype_id type = GENERATE( itype_sinew, itype_leather, itype_plant_fibre );
    CAPTURE( type.str() );
    prepare_material_inspection();
    REQUIRE( get_avatar().get_group_available_recipes().of_component( type ).size() > 15 );
    const std::string expected = exhaustive_recipe_info( type );
    calendar::turn += 1_turns;
    CHECK( material_recipe_info( type ) == expected );
}

TEST_CASE( "boolean_requirement_queries_skip_unnecessary_inventory_scans",
           "[requirement][material_iteminfo]" )
{
    clear_avatar();
    temp_crafting_inventory inv;
    inv.add_item_copy( item( itype_rock ) );
    requirement_data req;
    SECTION( "missing_quality" ) {
        req = requirement_data( {}, { { quality_requirement( qual_HAMMER, 2, 1 ) } },
        { { item_comp( itype_rock, 1 ) } } );
    }
    SECTION( "missing_tool" ) {
        req = requirement_data( { { tool_comp( itype_hammer, -1 ) } }, {},
        { { item_comp( itype_rock, 1 ) } } );
    }
    SECTION( "missing_first_component" ) {
        req = requirement_data( {}, {},
        { { item_comp( itype_leather, 1 ) }, { item_comp( itype_rock, 1 ) } } );
    }
    int scans = 0;
    const auto filter = [&scans]( const item & ) {
        ++scans;
        return true;
    };
    CHECK_FALSE( req.can_make_with_inventory( &get_avatar(), inv, filter, 1,
                 craft_flags::stop_on_failure ) );
    CHECK( scans == 0 );
    CHECK_FALSE( req.can_make_with_inventory( &get_avatar(), inv, filter ) );
    CHECK( scans > 0 );
}

TEST_CASE( "boolean_requirement_queries_preserve_shared_tool_and_component_rules",
           "[requirement][material_iteminfo]" )
{
    clear_avatar();
    const int hammers = GENERATE( 0, 1, 2 );
    const bool rock = GENERATE( false, true );
    const bool pseudo_hammer = GENERATE( false, true );
    CAPTURE( hammers, rock, pseudo_hammer );
    temp_crafting_inventory inv;
    for( int i = 0; i < hammers; ++i ) {
        inv.add_item_copy( item( itype_hammer ) );
    }
    if( pseudo_hammer ) {
        inv.add_pseudo_item( itype_hammer );
    }
    if( rock ) {
        inv.add_item_copy( item( itype_rock ) );
    }
    const requirement_data req( { { tool_comp( itype_hammer, -1 ) } },
    { { quality_requirement( qual_HAMMER, 1, 1 ) } },
    { { item_comp( itype_hammer, 1 ) }, { item_comp( itype_rock, 1 ) } } );
    scoped_provider_quality_cache qualities( inv );
    const bool complete = req.can_make_with_inventory( &get_avatar(), inv, return_true<item> );
    CHECK( req.can_make_with_inventory( &get_avatar(), inv, return_true<item>, 1,
                                        craft_flags::stop_on_failure ) == complete );
    CHECK( complete == ( rock && hammers > 0 && ( hammers > 1 || pseudo_hammer ) ) );
}

TEST_CASE( "boolean_recipe_queries_preserve_results_and_random_state",
           "[requirement][material_iteminfo]" )
{
    const itype_id type = GENERATE( itype_sinew, itype_leather, itype_plant_fibre );
    prepare_material_inspection();
    avatar &you = get_avatar();
    const temp_crafting_inventory &inv = you.crafting_inventory();
    scoped_provider_quality_cache qualities( inv );
    for( const recipe *r : you.get_group_available_recipes().of_component( type ) ) {
        CAPTURE( type.str(), r->ident().str() );
        const auto initial_rng = rng_get_engine();
        const bool complete = r->deduped_requirements().can_make_with_inventory(
                                  &you, inv, r->get_component_filter() );
        const auto expected_rng = rng_get_engine();
        rng_get_engine() = initial_rng;
        CHECK( r->deduped_requirements().can_make_with_inventory(
                   &you, inv, r->get_component_filter(), 1, craft_flags::stop_on_failure ) == complete );
        CHECK( rng_get_engine() == expected_rng );
    }
}

BENCHMARK_TEST_CASE( "material_recipe_preview_cold_inventory_benchmark", "[material_iteminfo]" )
{
    const itype_id type = GENERATE( itype_sinew, itype_leather, itype_plant_fibre );
    prepare_material_inspection();
    CAPTURE( type.str(), get_avatar().get_group_available_recipes().of_component( type ).size() );
    BENCHMARK( type.str() + " preview with 1300 distinct nearby items" ) {
        // Advancing time invalidates the existing per-turn craftability cache.
        calendar::turn += 1_turns;
        get_avatar().invalidate_crafting_inventory();
        return material_recipe_info( type );
    };
}
