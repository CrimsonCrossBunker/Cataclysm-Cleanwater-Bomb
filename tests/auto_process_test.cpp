#include <string>

#include "calendar.h"
#include "cata_catch.h"
#include "coordinates.h"
#include "enums.h"
#include "game.h"
#include "global_vars.h"
#include "item.h"
#include "itype.h"
#include "map.h"
#include "map_helpers.h"
#include "player_helpers.h"
#include "type_id.h"
#include "units.h"
#include "vehicle.h"

// Test data lives in data/mods/TEST_DATA/auto_process.json:
// - test_f_auto_process_station: furniture station, actions COOK/DRY, power 1000 W
//   (exactly 1000 J of processing energy per turn, deterministic).
// - test_ap_meat: COOK rule, 10 kJ -> test_ap_meat_cooked (10 turns at 1000 W).
// - test_ap_multi: COOK 10 kJ and DRY 40 kJ rules on the same item type.
// - test_ap_byproduct: COOK 10 kJ -> cooked + test_ap_drippings (extra result).
// - test_ap_box: container with a COOK rule; contents must be spilled on completion.
// - test_ap_eoc_meat: COOK rule with completion_eoc test_EOC_auto_process_done
//   (increments the global var test_ap_eoc_done) -> test_ap_eoc_meat_cooked.

static const furn_id test_station_furn( "test_f_auto_process_station" );
static const itype_id test_meat_id( "test_ap_meat" );
static const itype_id test_meat_cooked_id( "test_ap_meat_cooked" );
static const itype_id test_multi_id( "test_ap_multi" );
static const itype_id test_multi_cooked_id( "test_ap_multi_cooked" );
static const itype_id test_byproduct_id( "test_ap_byproduct" );
static const itype_id test_byproduct_cooked_id( "test_ap_byproduct_cooked" );
static const itype_id test_drippings_id( "test_ap_drippings" );
static const itype_id test_box_id( "test_ap_box" );
static const itype_id test_box_done_id( "test_ap_box_done" );
static const itype_id test_eoc_meat_id( "test_ap_eoc_meat" );
static const itype_id test_eoc_meat_cooked_id( "test_ap_eoc_meat_cooked" );

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

// Vehicle part tests.  The station part (test_auto_process_station, epower
// -1000 W, COOK) is defined in data/mods/TEST_DATA/auto_process.json.  At
// 1000 W it injects exactly 1000 J per turn, so a 10 kJ item takes 10 turns.

static const vproto_id vehicle_prototype_car( "car" );
static const vpart_id test_station_vpart( "test_auto_process_station" );

static int count_items_of_type( const vehicle_stack &items, const itype_id &type )
{
    int count = 0;
    for( const item &it : items ) {
        if( it.typeId() == type ) {
            count++;
        }
    }
    return count;
}

static vehicle &setup_auto_process_vehicle( map &here, int &part_index_out )
{
    const tripoint_bub_ms veh_pos( 60, 60, 0 );
    vehicle *veh_ptr = here.add_vehicle( vehicle_prototype_car, veh_pos, -90_degrees, 100,
                                         veh_spawn_status::UNDAMAGED, false );
    REQUIRE( veh_ptr != nullptr );
    vehicle &veh = *veh_ptr;
    vehicle_part vp( test_station_vpart, item( test_station_vpart->base_item ) );
    const int part_index = veh.install_part( here, point_rel_ms::zero, std::move( vp ) );
    REQUIRE( part_index >= 0 );
    veh.refresh();
    part_index_out = part_index;
    return veh;
}

TEST_CASE( "auto_process_vehicle_part_per_turn", "[auto_process][vehicle]" )
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    int part_index = -1;
    vehicle &veh = setup_auto_process_vehicle( here, part_index );
    vehicle_part &vp = veh.part( part_index );
    vp.enabled = true;

    GIVEN( "one raw item in the auto-process part" ) {
        veh.get_items( vp ).insert( here, item( test_meat_id, calendar::turn ) );

        WHEN( "processed for 9 turns" ) {
            for( int i = 0; i < 9; i++ ) {
                veh.process_auto_process_part( here, part_index );
            }
            THEN( "the item accumulated 9 kJ and the part stays on" ) {
                bool found = false;
                for( const item &it : veh.get_items( vp ) ) {
                    if( it.typeId() == test_meat_id ) {
                        found = true;
                        CHECK( it.get_var( "auto_process_COOK", "0" ) == "9000" );
                    }
                }
                CHECK( found );
                CHECK( vp.enabled );
            }
        }

        WHEN( "processed for 10 turns" ) {
            for( int i = 0; i < 10; i++ ) {
                veh.process_auto_process_part( here, part_index );
            }
            THEN( "the item transformed into the cooked result" ) {
                CHECK( count_items_of_type( veh.get_items( vp ), test_meat_cooked_id ) == 1 );
                CHECK( count_items_of_type( veh.get_items( vp ), test_meat_id ) == 0 );
            }
        }

        WHEN( "processed for 11 turns" ) {
            for( int i = 0; i < 11; i++ ) {
                veh.process_auto_process_part( here, part_index );
            }
            THEN( "the part turns itself off after the last item is done" ) {
                CHECK( count_items_of_type( veh.get_items( vp ), test_meat_cooked_id ) == 1 );
                CHECK( !vp.enabled );
            }
        }
    }
    clear_vehicles( &here );
}

TEST_CASE( "auto_process_vehicle_part_catch_up", "[auto_process][vehicle]" )
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    int part_index = -1;
    vehicle &veh = setup_auto_process_vehicle( here, part_index );
    vehicle_part &vp = veh.part( part_index );
    vp.enabled = true;

    GIVEN( "two raw items and 20 turns of off-map time" ) {
        veh.get_items( vp ).insert( here, item( test_meat_id, calendar::turn ) );
        veh.get_items( vp ).insert( here, item( test_meat_id, calendar::turn ) );
        WHEN( "catching up 20 turns" ) {
            veh.catch_up_auto_process( here, part_index, 20_turns );
            THEN( "both items transformed" ) {
                CHECK( count_items_of_type( veh.get_items( vp ), test_meat_cooked_id ) == 2 );
                CHECK( count_items_of_type( veh.get_items( vp ), test_meat_id ) == 0 );
            }
        }
    }

    GIVEN( "no processable items" ) {
        WHEN( "catching up" ) {
            vp.enabled = true;
            veh.catch_up_auto_process( here, part_index, 10_turns );
            THEN( "the part turns itself off" ) {
                CHECK( !vp.enabled );
            }
        }
    }
    clear_vehicles( &here );
}

TEST_CASE( "auto_process_spills_container_contents", "[auto_process]" )
{
    clear_map_without_vision();
    map &here = get_map();
    const tripoint_bub_ms pos( 60, 60, 0 );
    REQUIRE( here.furn_set( pos, test_station_furn ) );

    const auto make_filled_box = []() {
        item box( test_box_id, calendar::turn );
        REQUIRE( box.put_in( item( test_meat_id, calendar::turn ),
                             pocket_type::CONTAINER ).success() );
        return box;
    };

    GIVEN( "a processable container holding raw meat" ) {
        here.add_item( pos, make_filled_box() );

        WHEN( "processed per-turn until the container completes" ) {
            for( int i = 0; i < 10; i++ ) {
                here.process_auto_process_furniture();
            }
            THEN( "the container transformed and its contents were spilled unprocessed" ) {
                CHECK( count_items_of_type( here, pos, test_box_id ) == 0 );
                CHECK( count_items_of_type( here, pos, test_box_done_id ) == 1 );
                CHECK( count_items_of_type( here, pos, test_meat_id ) == 1 );
                CHECK( count_items_of_type( here, pos, test_meat_cooked_id ) == 0 );
            }
        }
    }

    GIVEN( "a processable container holding raw meat and off-map time" ) {
        here.add_item( pos, make_filled_box() );

        WHEN( "catching up 20 turns of off-map time" ) {
            here.catch_up_auto_process_furniture( pos, 20_turns );
            THEN( "the container transformed and its contents were spilled unprocessed" ) {
                CHECK( count_items_of_type( here, pos, test_box_id ) == 0 );
                CHECK( count_items_of_type( here, pos, test_box_done_id ) == 1 );
                CHECK( count_items_of_type( here, pos, test_meat_id ) == 1 );
                CHECK( count_items_of_type( here, pos, test_meat_cooked_id ) == 0 );
            }
        }
    }
}

// Battery accounting tests.  The station part draws -1000 W while enabled;
// catch-up discharges it only for energy actually injected into the cargo.

static const vpart_id small_storage_battery_vpart( "small_storage_battery" );
static const itype_id fuel_type_battery_id( "battery" );

static void setup_charged_battery( vehicle &veh, map &here )
{
    const int bat_idx = veh.install_part( here, point_rel_ms::zero, small_storage_battery_vpart );
    REQUIRE( bat_idx >= 0 );
    veh.refresh();
    veh.discharge_battery( here, 1000000 );
    REQUIRE( veh.fuel_left( here, fuel_type_battery_id ) == 0 );
    // Charged well above what any test below spends.
    REQUIRE( veh.charge_battery( here, 1000 ) == 0 );
}

TEST_CASE( "auto_process_on_map_turns_do_not_discharge_battery", "[auto_process][vehicle]" )
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    int part_index = -1;
    vehicle &veh = setup_auto_process_vehicle( here, part_index );
    setup_charged_battery( veh, here );
    veh.part( part_index ).enabled = true;
    const units::power drain = veh.total_accessory_epower();
    REQUIRE( drain < 0_W );

    // Simulate an on-map minute batch: update_time()'s body runs (last_update is
    // one minute stale), but idle() already marked every on-map turn as covered
    // by power_parts(), so there is no genuine off-map span to settle.
    veh.last_update = calendar::turn - 1_minutes;
    veh.last_auto_process_update = calendar::turn - 1_turns;
    veh.update_time( here, calendar::turn );

    CHECK( veh.fuel_left( here, fuel_type_battery_id ) == 1000 );
    clear_vehicles( &here );
}

TEST_CASE( "auto_process_catch_up_discharges_only_energy_used", "[auto_process][vehicle]" )
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    int part_index = -1;
    vehicle &veh = setup_auto_process_vehicle( here, part_index );
    setup_charged_battery( veh, here );
    veh.part( part_index ).enabled = true;
    const units::power drain = veh.total_accessory_epower();
    REQUIRE( drain == -1000_W );

    GIVEN( "one 10 kJ item in the cargo and ten off-map minutes" ) {
        veh.get_items( veh.part( part_index ) ).insert( here, item( test_meat_id, calendar::turn ) );
        veh.last_update = calendar::turn - 1_minutes;
        veh.last_auto_process_update = calendar::turn - 10_minutes;
        veh.update_time( here, calendar::turn );
        THEN( "only the injected 10 kJ was drawn and the station switched off" ) {
            // -1000 W over 10 minutes could supply 600 kJ, but the cargo only
            // needed 10 kJ; the station switches off instead of draining the rest.
            CHECK( veh.fuel_left( here, fuel_type_battery_id ) == 990 );
            CHECK( count_items_of_type( veh.get_items( veh.part( part_index ) ),
                                        test_meat_cooked_id ) == 1 );
            CHECK( !veh.part( part_index ).enabled );
        }
    }

    GIVEN( "no cargo at all and ten off-map minutes" ) {
        veh.last_update = calendar::turn - 1_minutes;
        veh.last_auto_process_update = calendar::turn - 10_minutes;
        veh.update_time( here, calendar::turn );
        THEN( "nothing was drawn and the station switched off" ) {
            CHECK( veh.fuel_left( here, fuel_type_battery_id ) == 1000 );
            CHECK( !veh.part( part_index ).enabled );
        }
    }
    clear_vehicles( &here );
}

TEST_CASE( "auto_process_catch_up_partial_on_deficit", "[auto_process][vehicle]" )
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    int part_index = -1;
    vehicle &veh = setup_auto_process_vehicle( here, part_index );
    setup_charged_battery( veh, here );
    // Drain down to 5 kJ so the battery dies mid-span.
    REQUIRE( veh.discharge_battery( here, 995 ) == 0 );
    REQUIRE( veh.fuel_left( here, fuel_type_battery_id ) == 5 );
    veh.part( part_index ).enabled = true;

    GIVEN( "30 kJ of demand but only 5 kJ of battery" ) {
        for( int i = 0; i < 3; i++ ) {
            veh.get_items( veh.part( part_index ) ).insert( here, item( test_meat_id,
                    calendar::turn ) );
        }
        veh.last_update = calendar::turn - 1_minutes;
        veh.last_auto_process_update = calendar::turn - 10_minutes;
        veh.update_time( here, calendar::turn );
        THEN( "the covered fraction became progress instead of vanishing" ) {
            CHECK( veh.fuel_left( here, fuel_type_battery_id ) == 0 );
            CHECK( count_items_of_type( veh.get_items( veh.part( part_index ) ),
                                        test_meat_cooked_id ) == 0 );
            CHECK( !veh.part( part_index ).enabled );
            CHECK( veh.part( part_index ).power_disabled );
            bool found = false;
            for( const item &it : veh.get_items( veh.part( part_index ) ) ) {
                if( it.typeId() == test_meat_id ) {
                    found = true;
                    CHECK( it.get_var( "auto_process_COOK", "0" ) == "5000" );
                    break;
                }
            }
            CHECK( found );
        }
    }
    clear_vehicles( &here );
}

TEST_CASE( "auto_process_grid_connected_no_double_discharge", "[auto_process][vehicle]" )
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    int part_index = -1;
    vehicle &veh = setup_auto_process_vehicle( here, part_index );
    setup_charged_battery( veh, here );
    veh.part( part_index ).enabled = true;
    veh.get_items( veh.part( part_index ) ).insert( here, item( test_meat_id, calendar::turn ) );

    // A grid-connected off-map turn: idle() runs power_parts() (draining the
    // station for this turn) and marks the turn as covered.
    veh.idle( here, false );
    const int fuel_after_idle = veh.fuel_left( here, fuel_type_battery_id );
    CHECK( fuel_after_idle == 999 );

    // When the vehicle loads back on-map, update_time() must not settle the
    // already-covered span a second time.
    veh.last_update = calendar::turn - 10_minutes;
    veh.update_time( here, calendar::turn );
    CHECK( veh.fuel_left( here, fuel_type_battery_id ) == fuel_after_idle );
    clear_vehicles( &here );
}

TEST_CASE( "auto_process_large_stack_no_overflow", "[auto_process]" )
{
    clear_map_without_vision();
    map &here = get_map();
    const tripoint_bub_ms pos( 60, 60, 0 );
    REQUIRE( here.furn_set( pos, test_station_furn ) );

    GIVEN( "a stack whose total energy cost exceeds the 32-bit int range" ) {
        // 300000 charges x 10 kJ = 3 GJ, beyond INT_MAX joules.
        item meat( test_meat_id, calendar::turn, 300000 );
        REQUIRE( meat.count_by_charges() );
        here.add_item( pos, meat );

        WHEN( "catching up 10 turns" ) {
            here.catch_up_auto_process_furniture( pos, 10_turns );
            THEN( "progress accumulates normally (int64 math)" ) {
                CHECK( count_items_of_type( here, pos, test_meat_cooked_id ) == 0 );
                for( const item &it : here.i_at( pos ) ) {
                    CHECK( it.get_var( "auto_process_COOK", "0" ) == "10000" );
                }
            }
        }
    }
}

TEST_CASE( "auto_process_completion_eoc_catch_up", "[auto_process]" )
{
    clear_map_without_vision();
    map &here = get_map();
    const tripoint_bub_ms pos( 60, 60, 0 );
    REQUIRE( here.furn_set( pos, test_station_furn ) );
    global_variables &globvars = get_globals();
    globvars.clear_global_values();

    GIVEN( "an item whose rule has a completion EOC" ) {
        here.add_item( pos, item( test_eoc_meat_id, calendar::turn ) );

        WHEN( "catching up enough off-map time to finish it" ) {
            here.catch_up_auto_process_furniture( pos, 20_turns );
            THEN( "it transformed and the completion EOC fired exactly once" ) {
                CHECK( count_items_of_type( here, pos, test_eoc_meat_cooked_id ) == 1 );
                CHECK( globvars.get_global_value( "test_ap_eoc_done" ) == 1 );
            }
        }
    }
}
