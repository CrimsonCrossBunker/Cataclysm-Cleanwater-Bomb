#include <functional>
#include <string>

#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "coordinates.h"
#include "flexbuffer_json.h"
#include "item.h"
#include "item_category.h"
#include "json_loader.h"
#include "map.h"
#include "map_helpers.h"
#include "mapgen.h"
#include "mapgendata.h"
#include "options_helpers.h"
#include "point.h"
#include "type_id.h"

static const faction_id faction_free_merchants( "free_merchants" );
static const furn_str_id furn_f_plant_seedling( "f_plant_seedling" );
static const itype_id itype_seed_rose( "seed_rose" );

TEST_CASE( "sealed_plant_keeps_its_seed_at_any_item_spawn_rate", "[mapgen][plant]" )
{
    const std::string spawn_rate = GENERATE( "0.00", "0.50", "1.00", "5.00" );
    const override_option spawn_rate_override( "ITEM_SPAWNRATE", spawn_rate );
    item_category_spawn_rates &rates = item_category_spawn_rates::get_item_category_spawn_rates();
    const item_category_id category = item( itype_seed_rose ).get_category_shallow().id;
    const float previous_rate = rates.get_spawn_rate( category );
    const on_out_of_scope restore_rate( [&rates, &category, previous_rate]() {
        rates.set_spawn_rate( category, previous_rate );
    } );
    rates.set_spawn_rate( category, 0.0f );
    map &here = get_map();
    clear_map_without_vision();
    mapgen_function_json_nested generator( json_loader::from_string( R"({
        "mapgensize": [1, 1],
        "rows": ["P"],
        "sealed_item": {
            "P": {
                "furniture": "f_plant_seedling",
                "items": {
                    "item": [{ "item": "seed_rose", "prob": 100 }],
                    "chance": 100,
                    "faction": "free_merchants"
                }
            }
        }
    })" ).get_object(), "sealed plant regression" );
    generator.setup();
    generator.finalize_parameters();
    mapgendata md( here, mapgendata::dummy_settings );
    generator.nest( md, tripoint_rel_ms::zero, "sealed plant regression" );
    const tripoint_bub_ms plot( 0, 0, 0 );
    REQUIRE( here.furn( plot ) == furn_f_plant_seedling );
    REQUIRE( here.i_at( plot ).size() == 1 );
    CHECK( here.i_at( plot ).begin()->is_seed() );
    CHECK( here.i_at( plot ).begin()->typeId() == itype_seed_rose );
    CHECK( here.i_at( plot ).begin()->get_owner() == faction_free_merchants );
    here.grow_plant( plot );
    CHECK_FALSE( here.i_at( plot ).empty() );
}

