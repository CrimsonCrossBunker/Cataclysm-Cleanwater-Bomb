#include <functional>
#include <list>
#include <optional>
#include <vector>

#include "calendar.h"
#include "cata_catch.h"
#include "character.h"
#include "coordinates.h"
#include "craft_command.h"
#include "finite_water.h"
#include "item.h"
#include "item_components.h"
#include "map.h"
#include "map_helpers.h"
#include "map_scale_constants.h"
#include "mapdata.h"
#include "player_helpers.h"
#include "pocket_type.h"
#include "point.h"
#include "recipe.h"
#include "requirements.h"
#include "ret_val.h"
#include "temp_crafting_inventory.h"
#include "type_id.h"

static const itype_id itype_bottle_plastic( "bottle_plastic" );
static const itype_id itype_water( "water" );
static const itype_id itype_water_clean( "water_clean" );
static const recipe_id recipe_glue_weak_from_bones( "glue_weak_from_bones" );
static const ter_str_id ter_pond_water_sh( "t_pond_water_sh" );
static const ter_str_id ter_wooden_well( "t_wooden_well" );

namespace
{

int preview_water_charges( const item_components &components )
{
    int result = 0;
    for( const item_components::type_vector_pair &entry : components ) {
        if( entry.first == itype_water ) {
            for( const item &component : entry.second ) {
                result += component.charges;
            }
        }
    }
    return result;
}

} // namespace

TEST_CASE( "crafting_previews_finite_water_without_consuming_it",
           "[crafting][finite_water][component_preview]" )
{
    clear_avatar();
    clear_map_and_put_player_underground();
    map &here = get_map();
    Character &crafter = get_player_character();
    const tripoint_bub_ms pond( SEEX * MAPSIZE / 2, SEEY * MAPSIZE / 2, 0 );
    const tripoint_bub_ms adjacent = pond + tripoint::east;
    crafter.setpos( here, pond + tripoint::west );
    here.ter_set( pond, ter_pond_water_sh );
    here.ter_set( adjacent, ter_pond_water_sh );
    const tripoint_abs_ms source_pos = here.get_abs( pond );
    const auto water_left = [&]() {
        const item source = finite_water::finite_liquid_from( source_pos );
        return source.is_null() ? 0 : source.charges;
    };
    REQUIRE( water_left() == 800 );
    REQUIRE( finite_water::withdraw_finite_liquid( source_pos, 794 ) == 794 );
    REQUIRE( water_left() == 6 );
    REQUIRE( finite_water::finite_liquid_from( here.get_abs( adjacent ) ).charges == 6 );
    REQUIRE( here.liquid_from( pond ).is_null() );

    temp_crafting_inventory inventory;
    inventory.form_from_map( here, { pond, adjacent }, &crafter );
    REQUIRE( inventory.charges_of( itype_water ) == 6 );
    const comp_selection<item_comp> water = { usage_from::map, item_comp( itype_water, 2 ) };
    const std::function<bool( const item & )> filter = []( const item & ) {
        return true;
    };

    SECTION( "bone_glue_water_selection_is_previewable" ) {
        const recipe &glue = recipe_glue_weak_from_bones.obj();
        const auto glue_filter = glue.get_component_filter();
        const comp_selection<item_comp> glue_water = { usage_from::map, item_comp( itype_water, 1 ) };
        const auto preview = crafter.preview_crafting_components( { glue_water }, 1, glue_filter );
        REQUIRE( preview.has_value() );
        CHECK( preview_water_charges( *preview ) == 1 );
        CHECK( water_left() == 6 );
    }
    SECTION( "batch_preview_is_repeatable_and_only_consumption_drains_water" ) {
        for( int attempt = 0; attempt < 2; ++attempt ) {
            const auto preview = crafter.preview_crafting_components( { water }, 3, filter );
            REQUIRE( preview.has_value() );
            CHECK( preview_water_charges( *preview ) == 6 );
            CHECK( water_left() == 6 );
        }
        int consumed = 0;
        for( const item &component : crafter.consume_items( water, 3, filter ) ) {
            consumed += component.charges;
        }
        CHECK( consumed == 6 );
        CHECK( water_left() == 0 );
    }
    SECTION( "multiple_selections_share_one_body_budget" ) {
        const auto preview = crafter.preview_crafting_components( { water, water, water }, 1, filter );
        REQUIRE( preview.has_value() );
        CHECK( preview_water_charges( *preview ) == 6 );
        CHECK( water_left() == 6 );
    }
    SECTION( "adjacent_tiles_and_repeated_selections_do_not_multiply_available_water" ) {
        CHECK_FALSE( crafter.preview_crafting_components( { water }, 4, filter ).has_value() );
        CHECK_FALSE( crafter.preview_crafting_components( { water, water }, 2, filter ).has_value() );
        CHECK( water_left() == 6 );
    }
    SECTION( "finite_water_can_be_combined_with_bottled_water" ) {
        item bottle( itype_bottle_plastic, calendar::turn_zero );
        item stored_water( itype_water, calendar::turn_zero );
        stored_water.charges = 2;
        REQUIRE( bottle.put_in( stored_water, pocket_type::CONTAINER ).success() );
        here.add_item_or_charges( crafter.pos_bub(), bottle );
        const auto preview = crafter.preview_crafting_components( { water }, 4, filter );
        REQUIRE( preview.has_value() );
        CHECK( preview_water_charges( *preview ) == 8 );
        CHECK( water_left() == 6 );
        int consumed = 0;
        for( const item &component : crafter.consume_items( water, 4, filter ) ) {
            consumed += component.charges;
        }
        CHECK( consumed == 8 );
        CHECK( water_left() == 0 );
    }
    SECTION( "separate_bodies_can_supply_one_selection" ) {
        const tripoint_bub_ms other = crafter.pos_bub() + tripoint::north * 2;
        here.ter_set( other, ter_pond_water_sh );
        REQUIRE( finite_water::withdraw_finite_liquid( here.get_abs( other ), 396 ) == 396 );
        const auto preview = crafter.preview_crafting_components( { water }, 5, filter );
        REQUIRE( preview.has_value() );
        CHECK( preview_water_charges( *preview ) == 10 );
        CHECK( water_left() == 6 );
        CHECK( finite_water::finite_liquid_from( here.get_abs( other ) ).charges == 4 );
    }
    SECTION( "recipe_filters_liquid_type_and_source_selection_are_respected" ) {
        const auto reject_water = []( const item & ) {
            return false;
        };
        CHECK_FALSE( crafter.preview_crafting_components( { water }, 1, reject_water ).has_value() );
        comp_selection<item_comp> clean_water = water;
        clean_water.comp.type = itype_water_clean;
        CHECK_FALSE( crafter.preview_crafting_components( { clean_water }, 1, filter ).has_value() );
        comp_selection<item_comp> carried_water = water;
        carried_water.use_from = usage_from::player;
        CHECK_FALSE( crafter.preview_crafting_components( { carried_water }, 1, filter ).has_value() );
        CHECK( water_left() == 6 );
    }
    SECTION( "an_infinite_well_still_takes_priority" ) {
        const tripoint_bub_ms well = crafter.pos_bub() + tripoint::west;
        here.ter_set( well, ter_wooden_well );
        REQUIRE( here.liquid_from( well ).charges == item::INFINITE_CHARGES );
        const auto preview = crafter.preview_crafting_components( { water }, 100, filter );
        REQUIRE( preview.has_value() );
        CHECK( preview_water_charges( *preview ) == 200 );
        int consumed = 0;
        for( const item &component : crafter.consume_items( water, 100, filter ) ) {
            consumed += component.charges;
        }
        CHECK( consumed == 200 );
        CHECK( water_left() == 6 );
    }
}
