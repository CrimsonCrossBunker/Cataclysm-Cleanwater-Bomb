#include <initializer_list>
#include <string>

#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "character.h"
#include "character_attire.h"
#include "craft_command.h"
#include "crafting.h"
#include "faction.h"
#include "item.h"
#include "item_location.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "player_helpers.h"
#include "pocket_type.h"
#include "recipe.h"
#include "requirements.h"
#include "ret_val.h"
#include "skill.h"
#include "temp_crafting_inventory.h"
#include "type_id.h"
#include "units.h"
#include "veh_type.h"
#include "vehicle.h"
#include "vehicle_selector.h"

TEST_CASE( "crafting_inventory_filters_nested_map_ownership", "[crafting][inventory][ownership]" )
{
    const bool cargo = GENERATE( false, true );
    CAPTURE( cargo );
    clear_avatar();
    clear_map_without_vision();
    avatar &crafter = get_avatar();
    item bag( itype_id( "debug_backpack" ) );
    bag.set_owner( crafter );
    for( const bool foreign : {
             true, false
         } ) {
        item pipe( itype_id( "pipe" ) );
        item nails( itype_id( "nail" ), calendar::turn, 20 );
        pipe.set_owner( crafter );
        nails.set_owner( crafter );
        if( foreign ) {
            pipe.set_owner( faction_id( "free_merchants" ) );
            nails.set_owner( faction_id( "free_merchants" ) );
        }
        REQUIRE( bag.put_in( pipe, pocket_type::CONTAINER ).success() );
        REQUIRE( bag.put_in( nails, pocket_type::CONTAINER ).success() );
    }
    item inner( itype_id( "backpack" ) );
    inner.set_owner( crafter );
    item nested_pipe( itype_id( "pipe" ) );
    nested_pipe.set_owner( faction_id( "free_merchants" ) );
    REQUIRE( inner.put_in( nested_pipe, pocket_type::CONTAINER ).success() );
    REQUIRE( bag.put_in( inner, pocket_type::CONTAINER ).success() );
    map &here = get_map();
    if( cargo ) {
        const tripoint_bub_ms position = crafter.pos_bub() + point::east;
        vehicle *cart = here.add_vehicle( vproto_id( "shopping_cart" ), position, 0_degrees, 100,
                                          veh_spawn_status::UNDAMAGED );
        REQUIRE( cart );
        const auto storage = here.veh_at( position ).cargo();
        REQUIRE( storage );
        REQUIRE( cart->add_item( here, storage->part(), bag ) );
    } else {
        here.add_item_or_charges( crafter.pos_bub(), bag );
    }

    temp_crafting_inventory inventory;
    inventory.form_from_map( crafter.pos_bub(), 1, &crafter );
    const auto check = []( const temp_crafting_inventory & source ) {
        CHECK( source.amount_of( itype_id( "pipe" ) ) == 1 );
        CHECK( source.charges_of( itype_id( "nail" ) ) == 20 );
        CHECK_FALSE( source.has_amount( itype_id( "pipe" ), 2 ) );
        CHECK_FALSE( source.has_charges( itype_id( "nail" ), 21 ) );
    };
    check( inventory );
    {
        scoped_crafting_inventory_cache cache( inventory );
        check( inventory );
    }
    temp_crafting_inventory copied( inventory );
    check( copied );
    temp_crafting_inventory assigned;
    assigned = inventory;
    check( assigned );
    assigned.form_from_map( crafter.pos_bub(), 1 );
    CHECK( assigned.amount_of( itype_id( "pipe" ) ) == 3 );
    CHECK( assigned.charges_of( itype_id( "nail" ) ) == 40 );

    comp_selection<item_comp> selection;
    selection.use_from = usage_from::map;
    selection.comp = item_comp( itype_id( "pipe" ), 1 );
    const auto consumed = crafter.consume_items( selection, 1, return_true<item> );
    REQUIRE( consumed.size() == 1 );
    CHECK( consumed.front().is_owned_by( crafter, true ) );
    CHECK( assigned.amount_of( itype_id( "pipe" ) ) == 2 );
    CHECK( inventory.amount_of( itype_id( "pipe" ) ) == 0 );

    crafter.set_wielded_item( bag );
    inventory.add_all_ref( crafter );
    CHECK( inventory.amount_of( itype_id( "pipe" ) ) == 3 );
    CHECK( inventory.charges_of( itype_id( "nail" ) ) == 60 );
}

TEST_CASE( "cage_crafting_rejects_foreign_contents_before_selection", "[crafting][ownership]" )
{
    for( const std::string recipe_name : {
             "chicken_cage", "livestock_carrier"
         } ) {
        for( const bool foreign : {
                 false, true
             } ) {
            DYNAMIC_SECTION( recipe_name << " foreign=" << foreign ) {
                clear_avatar();
                clear_map_without_vision();
                set_time_to_day();
                avatar &crafter = get_avatar();
                map &here = get_map();
                const recipe_id selected_recipe( recipe_name );
                REQUIRE( selected_recipe.is_valid() );
                crafter.learn_recipe( &*selected_recipe );
                crafter.set_skill_level( skill_id( "fabrication" ), 10 );
                crafter.set_skill_level( skill_id( "mechanics" ), 10 );
                crafter.set_wielded_item( item( itype_id( "small_repairkit" ) ) );
                here.add_item_or_charges( crafter.pos_bub(), item( itype_id( "goggles_welding" ) ) );
                item torch( itype_id( "oxy_torch" ) );
                item tank( itype_id( "weldtank" ) );
                tank.ammo_set( tank.ammo_default(), 1000 );
                REQUIRE( torch.put_in( tank, pocket_type::MAGAZINE_WELL ).success() );
                here.add_item_or_charges( crafter.pos_bub(), torch );
                item bag( itype_id( "debug_backpack" ) );
                bag.set_owner( crafter );
                const itype_id nested_type( recipe_name == "livestock_carrier" ? "pipe" : "lc_wire" );
                for( const auto &alternatives : selected_recipe->simple_requirements().get_components() ) {
                    REQUIRE_FALSE( alternatives.empty() );
                    const item_comp &component = alternatives.front();
                    const bool by_charges = item::count_by_charges( component.type );
                    for( int index = 0; index < ( by_charges ? 1 : component.count ); ++index ) {
                        item material( component.type );
                        if( by_charges ) {
                            material.charges = component.count;
                        }
                        if( component.type == nested_type ) {
                            material.set_owner( crafter );
                            if( foreign ) {
                                material.set_owner( faction_id( "free_merchants" ) );
                            }
                            REQUIRE( bag.put_in( material, pocket_type::CONTAINER ).success() );
                        } else {
                            here.add_item_or_charges( crafter.pos_bub(), material );
                        }
                    }
                }
                here.add_item_or_charges( crafter.pos_bub(), bag );
                crafter.invalidate_crafting_inventory();
                CHECK( crafter.can_make( &*selected_recipe, 1 ) == !foreign );
                if( !foreign ) {
                    craft_command command( &*selected_recipe, 1, false, &crafter, crafter.pos_bub() );
                    command.execute( true );
                    REQUIRE( command.has_cached_selections() );
                    CHECK( command.create_in_progress_craft().is_craft() );
                }
            }
        }
    }
}
