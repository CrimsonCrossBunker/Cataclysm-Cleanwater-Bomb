#include <string>

#include "calendar.h"
#include "cata_catch.h"
#include "coordinates.h"
#include "game.h"
#include "item.h"
#include "itype.h"
#include "map.h"
#include "map_helpers.h"
#include "type_id.h"

// Test data lives in data/mods/TEST_DATA/auto_process.json:
// - test_f_auto_process_station: furniture station, actions COOK/DRY, power 1000 W
//   (exactly 1000 J of processing energy per turn, deterministic).
// - test_ap_meat: COOK rule, 10 kJ -> test_ap_meat_cooked (10 turns at 1000 W).
// - test_ap_multi: COOK 10 kJ and DRY 40 kJ rules on the same item type.
// - test_ap_byproduct: COOK 10 kJ -> cooked + test_ap_drippings (extra result).

static const furn_id test_station_furn( "test_f_auto_process_station" );
static const itype_id test_meat_id( "test_ap_meat" );
static const itype_id test_meat_cooked_id( "test_ap_meat_cooked" );
static const itype_id test_multi_id( "test_ap_multi" );
static const itype_id test_multi_cooked_id( "test_ap_multi_cooked" );
static const itype_id test_byproduct_id( "test_ap_byproduct" );
static const itype_id test_byproduct_cooked_id( "test_ap_byproduct_cooked" );
static const itype_id test_drippings_id( "test_ap_drippings" );

static int count_items_of_type( map &here, const tripoint_bub_ms &pos, const itype_id &type )
{
    int count = 0;
    for( const item &it : here.i_at( pos ) ) {
        if( it.typeId() == type ) {
            count++;
        }
    }
    return count;
}

TEST_CASE( "auto_process_furniture_serial_processing", "[auto_process]" )
{
    clear_map_without_vision();
    map &here = get_map();
    const tripoint_bub_ms pos( 60, 60, 0 );
    REQUIRE( here.furn_set( pos, test_station_furn ) );

    GIVEN( "two processable items on the station tile" ) {
        here.add_item( pos, item( test_meat_id, calendar::turn ) );
        here.add_item( pos, item( test_meat_id, calendar::turn ) );
        REQUIRE( count_items_of_type( here, pos, test_meat_id ) == 2 );

        WHEN( "processed for 5 turns" ) {
            for( int i = 0; i < 5; i++ ) {
                here.process_auto_process_furniture();
            }
            THEN( "only the first item accumulated energy (serial semantics)" ) {
                int progressed = 0;
                for( const item &it : here.i_at( pos ) ) {
                    CHECK( it.typeId() == test_meat_id );
                    const std::string progress = it.get_var( "auto_process_COOK", "0" );
                    if( progress != "0" ) {
                        progressed++;
                        CHECK( progress == "5000" );
                    }
                }
                CHECK( progressed == 1 );
            }
        }

        WHEN( "processed for 10 turns" ) {
            for( int i = 0; i < 10; i++ ) {
                here.process_auto_process_furniture();
            }
            THEN( "the first item transformed and the second is still untouched" ) {
                CHECK( count_items_of_type( here, pos, test_meat_cooked_id ) == 1 );
                CHECK( count_items_of_type( here, pos, test_meat_id ) == 1 );
                for( const item &it : here.i_at( pos ) ) {
                    if( it.typeId() == test_meat_id ) {
                        CHECK( it.get_var( "auto_process_COOK", "0" ) == "0" );
                    }
                }
            }
        }

        WHEN( "processed for 20 turns" ) {
            for( int i = 0; i < 20; i++ ) {
                here.process_auto_process_furniture();
            }
            THEN( "both items transformed" ) {
                CHECK( count_items_of_type( here, pos, test_meat_cooked_id ) == 2 );
                CHECK( count_items_of_type( here, pos, test_meat_id ) == 0 );
            }
        }
    }
}

TEST_CASE( "auto_process_furniture_catch_up", "[auto_process]" )
{
    clear_map_without_vision();
    map &here = get_map();
    const tripoint_bub_ms pos( 60, 60, 0 );
    REQUIRE( here.furn_set( pos, test_station_furn ) );

    GIVEN( "two processable items on the station tile" ) {
        here.add_item( pos, item( test_meat_id, calendar::turn ) );
        here.add_item( pos, item( test_meat_id, calendar::turn ) );

        WHEN( "catching up 20 turns of off-map time" ) {
            here.catch_up_auto_process_furniture( pos, 20_turns );
            THEN( "both items transformed, matching per-turn processing" ) {
                CHECK( count_items_of_type( here, pos, test_meat_cooked_id ) == 2 );
                CHECK( count_items_of_type( here, pos, test_meat_id ) == 0 );
            }
        }

        WHEN( "catching up 10 turns of off-map time" ) {
            here.catch_up_auto_process_furniture( pos, 10_turns );
            THEN( "only the first item transformed (serial pool distribution)" ) {
                CHECK( count_items_of_type( here, pos, test_meat_cooked_id ) == 1 );
                CHECK( count_items_of_type( here, pos, test_meat_id ) == 1 );
            }
        }
    }

    GIVEN( "one item and an extremely long off-map span" ) {
        here.add_item( pos, item( test_meat_id, calendar::turn ) );

        WHEN( "catching up far more energy than int can hold" ) {
            // 1000 W over 20000 days is ~1.7 TJ, far beyond INT_MAX joules;
            // the energy pool must be capped at the remaining demand instead.
            here.catch_up_auto_process_furniture( pos, 20000_days );
            THEN( "the item still transformed exactly once" ) {
                CHECK( count_items_of_type( here, pos, test_meat_cooked_id ) == 1 );
                CHECK( count_items_of_type( here, pos, test_meat_id ) == 0 );
            }
        }
    }
}

TEST_CASE( "auto_process_charges_scaling", "[auto_process]" )
{
    clear_map_without_vision();
    map &here = get_map();
    const tripoint_bub_ms pos( 60, 60, 0 );
    REQUIRE( here.furn_set( pos, test_station_furn ) );

    GIVEN( "a single stack of 4 charges" ) {
        item meat( test_meat_id, calendar::turn, 4 );
        REQUIRE( meat.count_by_charges() );
        here.add_item( pos, meat );

        WHEN( "processed for 39 turns (energy cost is per charge: 40 kJ total)" ) {
            for( int i = 0; i < 39; i++ ) {
                here.process_auto_process_furniture();
            }
            THEN( "the stack is still raw with 39 kJ accumulated" ) {
                CHECK( count_items_of_type( here, pos, test_meat_cooked_id ) == 0 );
                for( const item &it : here.i_at( pos ) ) {
                    CHECK( it.get_var( "auto_process_COOK", "0" ) == "39000" );
                }
            }
        }

        WHEN( "processed for 40 turns" ) {
            for( int i = 0; i < 40; i++ ) {
                here.process_auto_process_furniture();
            }
            THEN( "the stack transformed keeping its 4 charges" ) {
                CHECK( count_items_of_type( here, pos, test_meat_id ) == 0 );
                REQUIRE( count_items_of_type( here, pos, test_meat_cooked_id ) == 1 );
                for( const item &it : here.i_at( pos ) ) {
                    CHECK( it.charges == 4 );
                }
            }
        }
    }
}

TEST_CASE( "auto_process_preserves_other_action_progress", "[auto_process]" )
{
    clear_map_without_vision();
    map &here = get_map();
    const tripoint_bub_ms pos( 60, 60, 0 );
    REQUIRE( here.furn_set( pos, test_station_furn ) );

    GIVEN( "an item with partial DRY progress on top of a pending COOK rule" ) {
        here.add_item( pos, item( test_multi_id, calendar::turn ) );
        for( item &it : here.i_at( pos ) ) {
            it.set_var( "auto_process_DRY", "15000" );
        }

        WHEN( "the COOK rule completes after 10 turns" ) {
            for( int i = 0; i < 10; i++ ) {
                here.process_auto_process_furniture();
            }
            THEN( "the result keeps the accumulated DRY progress" ) {
                CHECK( count_items_of_type( here, pos, test_multi_id ) == 0 );
                REQUIRE( count_items_of_type( here, pos, test_multi_cooked_id ) == 1 );
                for( const item &it : here.i_at( pos ) ) {
                    CHECK( it.get_var( "auto_process_DRY", "0" ) == "15000" );
                }
            }
        }
    }
}

TEST_CASE( "auto_process_extra_results_scale_with_charges", "[auto_process]" )
{
    clear_map_without_vision();
    map &here = get_map();
    const tripoint_bub_ms pos( 60, 60, 0 );
    REQUIRE( here.furn_set( pos, test_station_furn ) );

    GIVEN( "a stack of 3 charges of a multi-result item" ) {
        item meat( test_byproduct_id, calendar::turn, 3 );
        REQUIRE( meat.count_by_charges() );
        here.add_item( pos, meat );

        WHEN( "processed for 30 turns (10 kJ per charge)" ) {
            for( int i = 0; i < 30; i++ ) {
                here.process_auto_process_furniture();
            }
            THEN( "both the first result and the extra result have 3 charges" ) {
                CHECK( count_items_of_type( here, pos, test_byproduct_id ) == 0 );
                REQUIRE( count_items_of_type( here, pos, test_byproduct_cooked_id ) == 1 );
                REQUIRE( count_items_of_type( here, pos, test_drippings_id ) == 1 );
                for( const item &it : here.i_at( pos ) ) {
                    CHECK( it.charges == 3 );
                }
            }
        }
    }
}

TEST_CASE( "auto_process_tile_tracking", "[auto_process]" )
{
    clear_map_without_vision();
    map &here = get_map();
    const tripoint_bub_ms pos( 60, 60, 0 );

    GIVEN( "an auto-process furniture is placed" ) {
        REQUIRE( here.furn_set( pos, test_station_furn ) );
        THEN( "its tile is tracked" ) {
            CHECK( here.auto_process_tiles.count( pos ) == 1 );
        }

        WHEN( "the furniture is removed" ) {
            REQUIRE( here.furn_set( pos, furn_str_id::NULL_ID() ) );
            THEN( "the tile is no longer tracked" ) {
                CHECK( here.auto_process_tiles.count( pos ) == 0 );
            }
        }
    }
}
