#include <string>

#include "activity_actor_definitions.h"
#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "coordinates.h"
#include "enums.h"
#include "event.h"
#include "event_bus.h"
#include "event_subscriber.h"
#include "global_vars.h"
#include "iexamine.h"
#include "item.h"
#include "itype.h"
#include "magic_ter_furn_transform.h"
#include "map.h"
#include "map_helpers.h"
#include "player_helpers.h"
#include "point.h"
#include "type_id.h"
#include "veh_type.h"
#include "vehicle.h"
#include "vpart_position.h"

static const furn_str_id furn_f_planter_seed( "f_planter_seed" );
static const furn_str_id furn_f_plant_seed( "f_plant_seed" );
static const furn_str_id furn_f_test_plant_harvest( "test_f_plant_harvest" );
static const furn_str_id furn_f_test_plant_mature( "test_f_plant_mature" );
static const furn_str_id furn_f_test_plant_overgrown( "test_f_plant_overgrown" );
static const furn_str_id furn_f_test_plant_seed( "test_f_plant_seed" );
static const furn_str_id furn_f_test_plant_seedling( "test_f_plant_seedling" );

static const itype_id itype_bottle_plastic( "bottle_plastic" );
static const itype_id itype_fertilizer_commercial( "fertilizer_commercial" );
static const itype_id itype_fertilizer_liquid( "fertilizer_liquid" );
static const itype_id itype_fungal_seeds( "fungal_seeds" );
static const itype_id itype_marloss_seed( "marloss_seed" );
static const itype_id itype_test_seed_eoc( "test_seed_eoc" );
static const itype_id itype_test_seed_simple( "test_seed_simple" );
static const itype_id itype_water_clean( "water_clean" );

static const ter_str_id ter_t_dirtmound( "t_dirtmound" );
static const ter_furn_transform_id ter_test_plant_seedling_to_mature( "ter_test_plant_seedling_to_mature" );
static const ter_furn_transform_id ter_test_plant_seed_to_harvest( "ter_test_plant_seed_to_harvest" );
static const vproto_id vehicle_prototype_oldtractor( "oldtractor" );

namespace
{

struct plant_event_subscriber : public event_subscriber {
    using event_subscriber::notify;
    void notify( const cata::event &e ) override {
        if( e.type() == event_type::character_plants_seed ||
            e.type() == event_type::character_harvests_plant ||
            e.type() == event_type::character_fertilizes_plant ||
            e.type() == event_type::character_waters_plant ) {
            events.push_back( e );
        }
    }

    std::vector<cata::event> events;
};

void reset_test_globals()
{
    global_variables &globvars = get_globals();
    globvars.clear_global_values();
}

} // namespace

TEST_CASE( "plant_lifecycle_eocs", "[plant][eoc]" )
{
    map &here = get_map();
    avatar &u = get_avatar();
    clear_avatar();
    clear_map_without_vision();
    reset_test_globals();

    const tripoint_bub_ms plot = u.pos_bub() + tripoint::east;

    SECTION( "on_plant fires when seed is planted" ) {
        here.ter_set( plot, ter_t_dirtmound );
        u.i_add( item( itype_test_seed_eoc ) );

        iexamine::plant_seed( u, plot, itype_test_seed_eoc );
        process_activity( u );

        CHECK( get_globals().get_global_value( "test_planted" ).to_string() == "1" );
    }

    SECTION( "on_grow and on_mature fire as plant advances stages" ) {
        // Manually set up a test plant to exercise furniture-level EOC hooks.
        here.add_item( plot, item( itype_test_seed_eoc ) );
        here.furn_set( plot, furn_f_test_plant_seed );

        calendar::turn += 1_hours;
        here.grow_plant( plot );

        CHECK( here.furn( plot ) == furn_f_test_plant_seedling );
        CHECK( get_globals().get_global_value( "test_grow_stage" ) == "GROWTH_SEEDLING" );

        calendar::turn += 1_hours;
        here.grow_plant( plot );

        CHECK( here.furn( plot ) == furn_f_test_plant_mature );
        CHECK( get_globals().get_global_value( "test_mature" ).to_string() == "1" );
    }

    SECTION( "on_harvest fires and reports plant_count" ) {
        here.add_item( plot, item( itype_test_seed_eoc ) );
        here.furn_set( plot, furn_f_test_plant_harvest );

        iexamine::harvest_plant( u, plot, false );

        const std::string harvest_count = get_globals().get_global_value( "test_harvest_count" ).to_string();
        REQUIRE( !harvest_count.empty() );
        CHECK( std::stoi( harvest_count ) > 0 );
    }

    SECTION( "on_overgrow fires when plant becomes overgrown" ) {
        here.add_item( plot, item( itype_test_seed_eoc ) );
        here.furn_set( plot, furn_f_test_plant_seed );

        calendar::turn += 1_hours;
        here.grow_plant( plot );
        CHECK( here.furn( plot ) == furn_f_test_plant_seedling );

        calendar::turn += 1_hours;
        here.grow_plant( plot );
        CHECK( here.furn( plot ) == furn_f_test_plant_mature );

        calendar::turn += 1_hours;
        here.grow_plant( plot );
        CHECK( here.furn( plot ) == furn_f_test_plant_harvest );

        calendar::turn += 1_hours;
        here.grow_plant( plot );

        CHECK( here.furn( plot ) == furn_f_test_plant_overgrown );
        CHECK( get_globals().get_global_value( "test_overgrow" ).to_string() == "1" );
    }
}

TEST_CASE( "plant_global_events", "[plant][event]" )
{
    map &here = get_map();
    avatar &u = get_avatar();
    clear_avatar();
    clear_map_without_vision();
    reset_test_globals();

    plant_event_subscriber sub;
    event_bus &bus = get_event_bus();
    bus.subscribe( &sub );
    on_out_of_scope cleanup( [&]() {
        bus.unsubscribe( &sub );
    } );

    const tripoint_bub_ms plot = u.pos_bub() + tripoint::east;

    SECTION( "character_plants_seed" ) {
        here.ter_set( plot, ter_t_dirtmound );
        u.i_add( item( itype_test_seed_eoc ) );

        iexamine::plant_seed( u, plot, itype_test_seed_eoc );
        process_activity( u );

        REQUIRE( sub.events.size() == 1 );
        const cata::event &e = sub.events.front();
        CHECK( e.type() == event_type::character_plants_seed );
        CHECK( e.get<itype_id>( "seed_id" ) == itype_test_seed_eoc );
        CHECK( e.get<furn_str_id>( "furniture_id" ).str() == "f_plant_seed" );
    }

    SECTION( "character_harvests_plant" ) {
        here.add_item( plot, item( itype_test_seed_eoc ) );
        here.furn_set( plot, furn_f_test_plant_harvest );

        iexamine::harvest_plant( u, plot, false );

        REQUIRE( sub.events.size() == 1 );
        const cata::event &e = sub.events.front();
        CHECK( e.type() == event_type::character_harvests_plant );
        CHECK( e.get<itype_id>( "seed_id" ) == itype_test_seed_eoc );
        CHECK( e.get<int>( "plant_count" ) > 0 );
        CHECK( e.get<int>( "seed_count" ) >= 0 );
    }

    SECTION( "special_seed_harvests_send_event" ) {
        here.furn_set( plot, furn_f_test_plant_harvest );

        SECTION( "fungal_seeds" ) {
            here.add_item( plot, item( itype_fungal_seeds ) );
            iexamine::harvest_plant( u, plot, false );

            REQUIRE( sub.events.size() == 1 );
            const cata::event &e = sub.events.front();
            CHECK( e.type() == event_type::character_harvests_plant );
            CHECK( e.get<itype_id>( "seed_id" ) == itype_fungal_seeds );
            CHECK( e.get<int>( "plant_count" ) == 0 );
            CHECK( e.get<int>( "seed_count" ) == 0 );
        }

        SECTION( "marloss_seed" ) {
            here.add_item( plot, item( itype_marloss_seed ) );
            iexamine::harvest_plant( u, plot, false );

            REQUIRE( sub.events.size() == 1 );
            const cata::event &e = sub.events.front();
            CHECK( e.type() == event_type::character_harvests_plant );
            CHECK( e.get<itype_id>( "seed_id" ) == itype_marloss_seed );
            CHECK( e.get<int>( "plant_count" ) == 0 );
            CHECK( e.get<int>( "seed_count" ) == 0 );
        }
    }

    SECTION( "character_fertilizes_plant" ) {
        here.add_item( plot, item( itype_test_seed_eoc ) );
        here.furn_set( plot, furn_f_test_plant_seedling );
        u.i_add( item( itype_fertilizer_commercial, calendar::turn ) );

        iexamine::fertilize_plant( u, plot, itype_fertilizer_commercial );
        process_activity( u );

        REQUIRE( sub.events.size() == 1 );
        const cata::event &e = sub.events.front();
        CHECK( e.type() == event_type::character_fertilizes_plant );
        CHECK( e.get<itype_id>( "fertilizer_id" ) == itype_fertilizer_commercial );
        CHECK( e.get<int>( "reduction_turns" ) > 0 );
    }

    SECTION( "character_waters_plant" ) {
        here.add_item( plot, item( itype_test_seed_eoc ) );
        here.furn_set( plot, furn_f_planter_seed );
        item water( itype_water_clean, calendar::turn, 1 );
        item bottle( itype_bottle_plastic );
        REQUIRE( bottle.put_in( water, pocket_type::CONTAINER ).success() );
        u.i_add( bottle );

        iexamine::water_plant( u, plot );

        REQUIRE( sub.events.size() == 1 );
        const cata::event &e = sub.events.front();
        CHECK( e.type() == event_type::character_waters_plant );
        CHECK( e.get<int>( "water_added" ) > 0 );
    }
}

TEST_CASE( "plant_effective_growth_time_authority", "[plant][growth]" )
{
    map &here = get_map();
    avatar &u = get_avatar();
    clear_avatar();
    clear_map_without_vision();
    reset_test_globals();

    const tripoint_bub_ms plot = u.pos_bub() + tripoint::east;
    here.ter_set( plot, ter_t_dirtmound );
    u.i_add( item( itype_test_seed_simple ) );

    iexamine::plant_seed( u, plot, itype_test_seed_simple );
    process_activity( u );

    item *seed = iexamine::get_seed_at( here, plot );
    REQUIRE( seed != nullptr );
    CHECK( iexamine::get_plant_effective_growth_turns( *seed ) == 0 );
    CHECK( here.furn( plot ) == furn_f_plant_seed );

    calendar::turn += 2_seconds;
    here.grow_plant( plot );

    seed = iexamine::get_seed_at( here, plot );
    REQUIRE( seed != nullptr );
    CHECK( iexamine::get_plant_effective_growth_turns( *seed ) > 0 );
    CHECK( iexamine::is_plant_mature( here, plot ) );

    calendar::turn += 2_seconds;
    here.grow_plant( plot );

    CHECK( iexamine::is_plant_harvestable( here, plot ) );
}

TEST_CASE( "plant_old_save_effective_growth_time_migration", "[plant][growth]" )
{
    map &here = get_map();
    avatar &u = get_avatar();
    clear_avatar();
    clear_map_without_vision();
    reset_test_globals();

    const tripoint_bub_ms plot = u.pos_bub() + tripoint::east;

    item old_seed( itype_test_seed_simple );
    old_seed.set_birthday( calendar::turn - 1_seconds );
    old_seed.erase_var( "seed_effective_growth_turns" );
    here.add_item( plot, old_seed );
    here.furn_set( plot, furn_f_test_plant_mature );

    here.grow_plant( plot );

    item *seed = iexamine::get_seed_at( here, plot );
    REQUIRE( seed != nullptr );
    const int effective = iexamine::get_plant_effective_growth_turns( *seed );
    CHECK( effective > 0 );
    // Mature stage threshold for test_seed_simple is 2 seconds.
    CHECK( effective >= to_turns<int>( 2_seconds ) );
}

TEST_CASE( "plant_fertilize_reduces_remaining_time", "[plant][fertilize]" )
{
    map &here = get_map();
    avatar &u = get_avatar();
    clear_avatar();
    clear_map_without_vision();
    reset_test_globals();

    const tripoint_bub_ms plot = u.pos_bub() + tripoint::east;
    here.add_item( plot, item( itype_test_seed_eoc ) );
    here.furn_set( plot, furn_f_test_plant_seedling );
    u.i_add( item( itype_fertilizer_commercial, calendar::turn ) );

    item *seed = iexamine::get_seed_at( here, plot );
    REQUIRE( seed != nullptr );
    const int effective_before = iexamine::get_plant_effective_growth_turns( *seed );

    iexamine::fertilize_plant( u, plot, itype_fertilizer_commercial );
    process_activity( u );

    seed = iexamine::get_seed_at( here, plot );
    REQUIRE( seed != nullptr );
    const int effective_after = iexamine::get_plant_effective_growth_turns( *seed );

    CHECK( effective_after > effective_before );

    const std::string reduction = get_globals().get_global_value( "test_fertilize_reduction_turns" ).to_string();
    REQUIRE( !reduction.empty() );
    CHECK( std::stoi( reduction ) > 0 );
}

TEST_CASE( "plant_cannot_be_fertilized_twice", "[plant][fertilize]" )
{
    map &here = get_map();
    avatar &u = get_avatar();
    clear_avatar();
    clear_map_without_vision();
    reset_test_globals();

    const tripoint_bub_ms plot = u.pos_bub() + tripoint::east;
    here.add_item( plot, item( itype_test_seed_eoc ) );
    here.furn_set( plot, furn_f_test_plant_seedling );
    u.i_add( item( itype_fertilizer_commercial, calendar::turn ) );
    u.i_add( item( itype_fertilizer_commercial, calendar::turn ) );

    iexamine::fertilize_plant( u, plot, itype_fertilizer_commercial );
    process_activity( u );

    item *seed = iexamine::get_seed_at( here, plot );
    REQUIRE( seed != nullptr );
    CHECK( iexamine::is_plant_fertilized( *seed ) );

    ret_val<void> second_fertilize = multi_farm_activity_actor::can_fertilize( u, plot );
    CHECK( !second_fertilize.success() );
}

TEST_CASE( "plant_fertilizer_quality_affects_reduction", "[plant][fertilize]" )
{
    map &here = get_map();
    avatar &u = get_avatar();
    clear_avatar();
    clear_map_without_vision();
    reset_test_globals();

    const tripoint_bub_ms plot_commercial = u.pos_bub() + tripoint::east;
    const tripoint_bub_ms plot_liquid = u.pos_bub() + tripoint::west;
    here.add_item( plot_commercial, item( itype_test_seed_eoc ) );
    here.furn_set( plot_commercial, furn_f_test_plant_seedling );
    here.add_item( plot_liquid, item( itype_test_seed_eoc ) );
    here.furn_set( plot_liquid, furn_f_test_plant_seedling );

    u.i_add( item( itype_fertilizer_commercial, calendar::turn ) );
    u.i_add( item( itype_fertilizer_liquid, calendar::turn ) );

    iexamine::fertilize_plant( u, plot_commercial, itype_fertilizer_commercial );
    process_activity( u );
    iexamine::fertilize_plant( u, plot_liquid, itype_fertilizer_liquid );
    process_activity( u );

    item *seed_commercial = iexamine::get_seed_at( here, plot_commercial );
    item *seed_liquid = iexamine::get_seed_at( here, plot_liquid );
    REQUIRE( seed_commercial != nullptr );
    REQUIRE( seed_liquid != nullptr );

    // Commercial fertilizer has quality 1.0, liquid fertilizer has quality 0.8.
    CHECK( iexamine::get_plant_effective_growth_turns( *seed_commercial ) >
           iexamine::get_plant_effective_growth_turns( *seed_liquid ) );
}

TEST_CASE( "plant_water_eoc_and_event", "[plant][water]" )
{
    map &here = get_map();
    avatar &u = get_avatar();
    clear_avatar();
    clear_map_without_vision();
    reset_test_globals();

    const tripoint_bub_ms plot = u.pos_bub() + tripoint::east;
    here.add_item( plot, item( itype_test_seed_eoc ) );
    here.furn_set( plot, furn_f_planter_seed );
    item water( itype_water_clean, calendar::turn, 1 );
    item bottle( itype_bottle_plastic );
    REQUIRE( bottle.put_in( water, pocket_type::CONTAINER ).success() );
    u.i_add( bottle );

    iexamine::water_plant( u, plot );

    const std::string water_added = get_globals().get_global_value( "test_water_added" ).to_string();
    REQUIRE( !water_added.empty() );
    CHECK( std::stoi( water_added ) > 0 );
}

TEST_CASE( "plant_vehicle_operations", "[plant][vehicle]" )
{
    map &here = get_map();
    avatar &u = get_avatar();
    clear_avatar();
    clear_map_without_vision();
    reset_test_globals();

    plant_event_subscriber sub;
    event_bus &bus = get_event_bus();
    bus.subscribe( &sub );
    on_out_of_scope cleanup( [&]() {
        bus.unsubscribe( &sub );
    } );

    const tripoint_bub_ms vehicle_pos = u.pos_bub() + tripoint::east * 4;
    vehicle *veh = here.add_vehicle( vehicle_prototype_oldtractor, vehicle_pos, 0_degrees, 0,
                                     veh_spawn_status::UNDAMAGED );
    REQUIRE( veh != nullptr );

    // Spawning a vehicle leaves most parts disabled; enable the ones we test.
    for( const vpart_reference &vp : veh->get_all_parts() ) {
        if( vp.has_feature( "REAPER" ) || vp.has_feature( "PLANTER" ) ) {
            vp.part().enabled = true;
        }
    }

    SECTION( "vehicle reaper sends harvest event and runs harvest EOC" ) {
        std::optional<tripoint_bub_ms> reaper_pos;
        for( const vpart_reference &vp : veh->get_enabled_parts( "REAPER" ) ) {
            reaper_pos = vp.pos_bub( here );
            break;
        }
        REQUIRE( reaper_pos );

        // The reaper decides harvestability from effective growth time, so give
        // the seed enough age to match the harvest furniture.
        item harvest_seed( itype_test_seed_eoc );
        harvest_seed.set_age( 4_hours );
        here.add_item( *reaper_pos, harvest_seed );
        here.furn_set( *reaper_pos, furn_f_test_plant_harvest );

        veh->operate_reaper( here );

        REQUIRE( sub.events.size() == 1 );
        const cata::event &e = sub.events.front();
        CHECK( e.type() == event_type::character_harvests_plant );
        CHECK( e.get<itype_id>( "seed_id" ) == itype_test_seed_eoc );
        CHECK( e.get<int>( "plant_count" ) > 0 );

        const std::string harvest_count = get_globals().get_global_value( "test_harvest_count" ).to_string();
        REQUIRE( !harvest_count.empty() );
        CHECK( std::stoi( harvest_count ) > 0 );
    }

    SECTION( "vehicle planter sends plant event and runs plant EOC" ) {
        std::optional<vpart_reference> planter_part;
        for( const vpart_reference &vp : veh->get_enabled_parts( "PLANTER" ) ) {
            planter_part = vp;
            break;
        }
        REQUIRE( planter_part );

        const tripoint_bub_ms planter_pos = planter_part->pos_bub( here );
        here.ter_set( planter_pos, ter_t_dirtmound );
        veh->add_item( here, planter_part->part(), item( itype_test_seed_eoc ) );

        veh->operate_planter( here );

        REQUIRE( sub.events.size() == 1 );
        const cata::event &e = sub.events.front();
        CHECK( e.type() == event_type::character_plants_seed );
        CHECK( e.get<itype_id>( "seed_id" ) == itype_test_seed_eoc );

        CHECK( get_globals().get_global_value( "test_planted" ).to_string() == "1" );
    }
}

TEST_CASE( "ter_transform_syncs_plant_seed_effective_growth_time", "[plant][magic][ter_transform]" )
{
    map &here = get_map();
    avatar &u = get_avatar();
    clear_avatar();
    clear_map_without_vision();

    const tripoint_bub_ms plot = u.pos_bub() + tripoint::east;

    // Set up a seedling whose internal timer has not advanced at all.
    item seed( itype_test_seed_simple );
    seed.set_birthday( calendar::turn );
    here.add_item( plot, seed );
    here.furn_set( plot, furn_f_test_plant_seedling );

    REQUIRE( here.furn( plot ) == furn_f_test_plant_seedling );

    // Use a ter_furn_transform to jump the furniture straight to mature.
    REQUIRE( ter_test_plant_seedling_to_mature.is_valid() );
    ter_test_plant_seedling_to_mature->transform( here, plot );

    CHECK( here.furn( plot ) == furn_f_test_plant_mature );

    // The seed's effective growth time must now match the mature stage,
    // otherwise later grow_plant calls would see a mismatch and stall.
    item *synced_seed = iexamine::get_seed_at( here, plot );
    REQUIRE( synced_seed != nullptr );
    CHECK( iexamine::get_plant_current_stage_idx_from_effective( here, plot ) >=
           iexamine::get_plant_mature_stage_idx( synced_seed->type->seed->get_growth_stages() ) );

    // After the forced jump the plant should still be able to reach harvest
    // through normal growth processing.
    calendar::turn += 2_seconds;
    here.grow_plant( plot );

    CHECK( here.furn( plot ) == furn_f_test_plant_harvest );
    CHECK( iexamine::is_plant_harvestable( here, plot ) );

    SECTION( "jump from seed straight to harvest" ) {
        here.i_clear( plot );
        here.furn_set( plot, furn_f_test_plant_seed );
        item seed2( itype_test_seed_simple );
        seed2.set_birthday( calendar::turn );
        iexamine::set_plant_effective_growth_turns( seed2, 0 );
        here.add_item( plot, seed2 );

        REQUIRE( ter_test_plant_seed_to_harvest.is_valid() );
        ter_test_plant_seed_to_harvest->transform( here, plot );

        CHECK( here.furn( plot ) == furn_f_test_plant_harvest );

        item *synced_seed2 = iexamine::get_seed_at( here, plot );
        REQUIRE( synced_seed2 != nullptr );
        CHECK( iexamine::is_plant_harvestable( here, plot ) );
    }
}
