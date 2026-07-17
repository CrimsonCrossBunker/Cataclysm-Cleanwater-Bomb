#include <functional>
#include <memory>
#include <optional>
#include <string>
#include <utility>
#include <vector>

#include "activity_actor_definitions.h"
#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character_attire.h"
#include "coordinates.h"
#include "enums.h"
#include "event.h"
#include "event_bus.h"
#include "event_subscriber.h"
#include "global_vars.h"
#include "iexamine.h"
#include "item.h"
#include "itype.h"
#include "magic.h"
#include "magic_ter_furn_transform.h"
#include "map.h"
#include "map_helpers.h"
#include "mapdata.h"
#include "math_parser_diag_value.h"
#include "options.h"
#include "player_helpers.h"
#include "pocket_type.h"
#include "point.h"
#include "ret_val.h"
#include "type_id.h"
#include "units.h"
#include "value_ptr.h"
#include "vehicle.h"
#include "vpart_position.h"
#include "vpart_range.h"

static const furn_str_id furn_f_planter_seed( "f_planter_seed" );
static const furn_str_id furn_test_f_plant_harvest( "test_f_plant_harvest" );
static const furn_str_id furn_test_f_plant_mature( "test_f_plant_mature" );
static const furn_str_id furn_test_f_plant_overgrown( "test_f_plant_overgrown" );
static const furn_str_id furn_test_f_plant_seed( "test_f_plant_seed" );
static const furn_str_id furn_test_f_plant_seedling( "test_f_plant_seedling" );
static const furn_str_id
furn_test_f_planter_high_water_mature( "test_f_planter_high_water_mature" );
static const furn_str_id furn_test_f_planter_high_water_seed( "test_f_planter_high_water_seed" );

static const itype_id itype_bottle_plastic( "bottle_plastic" );
static const itype_id itype_debug_backpack( "debug_backpack" );
static const itype_id itype_fertilizer_commercial( "fertilizer_commercial" );
static const itype_id itype_fertilizer_liquid( "fertilizer_liquid" );
static const itype_id itype_fungal_seeds( "fungal_seeds" );
static const itype_id itype_marloss_seed( "marloss_seed" );
static const itype_id itype_test_seed_eoc( "test_seed_eoc" );
static const itype_id itype_test_seed_simple( "test_seed_simple" );
static const itype_id itype_water_clean( "water_clean" );

static const skill_id skill_survival( "survival" );
static const spell_id spell_test_spell_fertilize_plant( "test_spell_fertilize_plant" );
static const ter_furn_transform_id
ter_furn_transform_ter_test_plant_seed_to_harvest( "ter_test_plant_seed_to_harvest" );
static const ter_furn_transform_id
ter_furn_transform_ter_test_plant_seedling_to_mature( "ter_test_plant_seedling_to_mature" );
static const ter_str_id ter_t_dirtmound( "t_dirtmound" );
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
        here.furn_set( plot, furn_test_f_plant_seed );

        calendar::turn += 1_hours;
        here.grow_plant( plot );

        CHECK( here.furn( plot ) == furn_test_f_plant_seedling );
        CHECK( get_globals().get_global_value( "test_grow_stage" ) == "GROWTH_SEEDLING" );

        calendar::turn += 1_hours;
        here.grow_plant( plot );

        CHECK( here.furn( plot ) == furn_test_f_plant_mature );
        CHECK( get_globals().get_global_value( "test_mature" ).to_string() == "1" );
    }

    SECTION( "on_harvest fires and reports plant_count" ) {
        here.add_item( plot, item( itype_test_seed_eoc ) );
        here.furn_set( plot, furn_test_f_plant_harvest );

        iexamine::harvest_plant( u, plot, false );

        const std::string harvest_count =
            get_globals().get_global_value( "test_harvest_count" ).to_string();
        REQUIRE( !harvest_count.empty() );
        CHECK( std::stoi( harvest_count ) > 0 );
    }

    SECTION( "on_overgrow fires when plant becomes overgrown" ) {
        here.add_item( plot, item( itype_test_seed_eoc ) );
        here.furn_set( plot, furn_test_f_plant_seed );

        calendar::turn += 1_hours;
        here.grow_plant( plot );
        CHECK( here.furn( plot ) == furn_test_f_plant_seedling );

        calendar::turn += 1_hours;
        here.grow_plant( plot );
        CHECK( here.furn( plot ) == furn_test_f_plant_mature );

        calendar::turn += 1_hours;
        here.grow_plant( plot );
        CHECK( here.furn( plot ) == furn_test_f_plant_harvest );

        calendar::turn += 1_hours;
        here.grow_plant( plot );

        CHECK( here.furn( plot ) == furn_test_f_plant_overgrown );
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
        here.furn_set( plot, furn_test_f_plant_harvest );

        iexamine::harvest_plant( u, plot, false );

        REQUIRE( sub.events.size() == 1 );
        const cata::event &e = sub.events.front();
        CHECK( e.type() == event_type::character_harvests_plant );
        CHECK( e.get<itype_id>( "seed_id" ) == itype_test_seed_eoc );
        CHECK( e.get<int>( "plant_count" ) > 0 );
        CHECK( e.get<int>( "seed_count" ) >= 0 );
    }

    SECTION( "special_seed_harvests_send_event" ) {
        here.furn_set( plot, furn_test_f_plant_harvest );

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
        here.furn_set( plot, furn_test_f_plant_seedling );
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
    // Use the test (non-irrigated) plant furniture so sub-day growth stages
    // are processed immediately instead of being deferred to the daily loop.
    item seed( itype_test_seed_simple );
    seed.set_birthday( calendar::turn );
    here.add_item( plot, seed );
    here.furn_set( plot, furn_test_f_plant_seed );

    item *planted_seed = iexamine::get_seed_at( here, plot );
    REQUIRE( planted_seed != nullptr );
    CHECK( iexamine::get_plant_effective_growth_turns( *planted_seed ) == 0 );

    calendar::turn += 2_seconds;
    here.grow_plant( plot );

    planted_seed = iexamine::get_seed_at( here, plot );
    REQUIRE( planted_seed != nullptr );
    CHECK( iexamine::get_plant_effective_growth_turns( *planted_seed ) > 0 );
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
    here.furn_set( plot, furn_test_f_plant_mature );

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
    here.furn_set( plot, furn_test_f_plant_seedling );
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

    const std::string reduction =
        get_globals().get_global_value( "test_fertilize_reduction_turns" ).to_string();
    REQUIRE( !reduction.empty() );
    CHECK( std::stoi( reduction ) > 0 );
}

TEST_CASE( "plant_fertilize_speed_independence", "[plant][fertilize][world_option]" )
{
    map &here = get_map();
    avatar &u = get_avatar();
    clear_avatar();
    clear_map_without_vision();
    reset_test_globals();

    options_manager::options_container world_opts = get_options().get_world_defaults();
    world_opts["CROP_GROWTH_SPEED"].setValue( "2.0" );
    get_options().set_world_options( &world_opts );
    on_out_of_scope cleanup( [&]() {
        get_options().set_world_options( nullptr );
    } );

    const tripoint_bub_ms plot = u.pos_bub() + tripoint::east;

    // Pre-actualize the seed at the seedling stage in base effective units.
    item seed( itype_test_seed_eoc );
    seed.set_birthday( calendar::turn );
    // The seedling threshold is 1h of base effective time.
    iexamine::set_plant_effective_growth_turns( seed, to_turns<int>( 1_hours ) );
    iexamine::set_plant_last_water_check( seed, calendar::turn );
    here.add_item( plot, seed );
    here.furn_set( plot, furn_test_f_plant_seedling );

    item *planted_seed = iexamine::get_seed_at( here, plot );
    REQUIRE( planted_seed != nullptr );
    const int effective_before = iexamine::get_plant_effective_growth_turns( *planted_seed );

    u.i_add( item( itype_fertilizer_commercial, calendar::turn ) );
    iexamine::fertilize_plant( u, plot, itype_fertilizer_commercial );
    process_activity( u );

    planted_seed = iexamine::get_seed_at( here, plot );
    REQUIRE( planted_seed != nullptr );
    const int effective_after = iexamine::get_plant_effective_growth_turns( *planted_seed );

    // Commercial fertilizer with survival 0 reduces base remaining distance by 20%.
    // Base remaining distance to mature = 2h - 1h = 1h.
    // Effective advancement should be 0.2h, independent of CROP_GROWTH_SPEED.
    const time_duration expected_increase = 1_hours * 0.20f;
    CHECK( time_duration::from_turns( effective_after - effective_before ) == expected_increase );
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
    here.furn_set( plot, furn_test_f_plant_seedling );
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
    u.worn.wear_item( u, item( itype_debug_backpack ), false, false );

    const tripoint_bub_ms plot_commercial = u.pos_bub() + tripoint::east;
    const tripoint_bub_ms plot_liquid = u.pos_bub() + tripoint::west;
    here.add_item( plot_commercial, item( itype_test_seed_eoc ) );
    here.furn_set( plot_commercial, furn_test_f_plant_seedling );
    here.add_item( plot_liquid, item( itype_test_seed_eoc ) );
    here.furn_set( plot_liquid, furn_test_f_plant_seedling );

    u.i_add( item( itype_fertilizer_commercial, calendar::turn ) );
    item liquid_fertilizer = item( itype_fertilizer_liquid,
                                   calendar::turn ).in_its_container();
    REQUIRE( u.wield( liquid_fertilizer ) );
    REQUIRE( u.has_charges( itype_fertilizer_liquid, 1 ) );

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
        here.furn_set( *reaper_pos, furn_test_f_plant_harvest );

        veh->operate_reaper( here );

        REQUIRE( sub.events.size() == 1 );
        const cata::event &e = sub.events.front();
        CHECK( e.type() == event_type::character_harvests_plant );
        CHECK( e.get<itype_id>( "seed_id" ) == itype_test_seed_eoc );
        CHECK( e.get<int>( "plant_count" ) > 0 );

        const std::string harvest_count =
            get_globals().get_global_value( "test_harvest_count" ).to_string();
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
    here.furn_set( plot, furn_test_f_plant_seedling );

    REQUIRE( here.furn( plot ) == furn_test_f_plant_seedling );

    // Use a ter_furn_transform to jump the furniture straight to mature.
    REQUIRE( ter_furn_transform_ter_test_plant_seedling_to_mature.is_valid() );
    ter_furn_transform_ter_test_plant_seedling_to_mature->transform( here, plot );

    CHECK( here.furn( plot ) == furn_test_f_plant_mature );

    // The seed's effective growth time must now match the mature stage,
    // otherwise later grow_plant calls would see a mismatch and stall.
    item *synced_seed = iexamine::get_seed_at( here, plot );
    REQUIRE( synced_seed != nullptr );
    CHECK( iexamine::get_plant_current_stage_idx_from_effective( here, plot ) >=
           iexamine::get_plant_mature_stage_idx( *synced_seed->type->seed ) );

    // After the forced jump the plant should still be able to reach harvest
    // through normal growth processing.
    calendar::turn += 2_seconds;
    here.grow_plant( plot );

    CHECK( here.furn( plot ) == furn_test_f_plant_harvest );
    CHECK( iexamine::is_plant_harvestable( here, plot ) );

    SECTION( "jump from seed straight to harvest" ) {
        here.i_clear( plot );
        here.furn_set( plot, furn_test_f_plant_seed );
        item seed2( itype_test_seed_simple );
        seed2.set_birthday( calendar::turn );
        iexamine::set_plant_effective_growth_turns( seed2, 0 );
        here.add_item( plot, seed2 );

        REQUIRE( ter_furn_transform_ter_test_plant_seed_to_harvest.is_valid() );
        ter_furn_transform_ter_test_plant_seed_to_harvest->transform( here, plot );

        CHECK( here.furn( plot ) == furn_test_f_plant_harvest );

        item *synced_seed2 = iexamine::get_seed_at( here, plot );
        REQUIRE( synced_seed2 != nullptr );
        CHECK( iexamine::is_plant_harvestable( here, plot ) );
    }
}

TEST_CASE( "crop_growth_speed_world_option", "[plant][world_option]" )
{
    map &here = get_map();
    avatar &u = get_avatar();
    clear_avatar();
    clear_map_without_vision();
    reset_test_globals();

    options_manager::options_container world_opts = get_options().get_world_defaults();
    world_opts["CROP_GROWTH_SPEED"].setValue( "2.0" );
    get_options().set_world_options( &world_opts );
    on_out_of_scope cleanup( [&]() {
        get_options().set_world_options( nullptr );
    } );

    const tripoint_bub_ms plot = u.pos_bub() + tripoint::east;

    // Use the test (non-irrigated) furniture so sub-day growth stages are
    // processed immediately instead of being deferred to the daily loop.
    item seed( itype_test_seed_simple );
    seed.set_birthday( calendar::turn );
    // Initialize the authoritative variables so the test exercises normal growth,
    // not the old-save migration path.
    iexamine::set_plant_effective_growth_turns( seed, 0 );
    iexamine::set_plant_last_water_check( seed, calendar::turn );
    here.add_item( plot, seed );
    here.furn_set( plot, furn_test_f_plant_seed );

    item *planted_seed = iexamine::get_seed_at( here, plot );
    REQUIRE( planted_seed != nullptr );
    CHECK( here.furn( plot ) == furn_test_f_plant_seed );

    // With double growth speed, 1 second of real time equals 2 seconds of effective growth.
    calendar::turn += 1_seconds;
    here.grow_plant( plot );

    planted_seed = iexamine::get_seed_at( here, plot );
    REQUIRE( planted_seed != nullptr );
    CHECK( iexamine::get_plant_effective_growth_turns( *planted_seed ) >= to_turns<int>( 2_seconds ) );
    CHECK( iexamine::is_plant_mature( here, plot ) );

    // Another second should be enough to reach harvest.
    calendar::turn += 1_seconds;
    here.grow_plant( plot );

    CHECK( iexamine::is_plant_harvestable( here, plot ) );
}

TEST_CASE( "crop_harvest_multiplier_world_option", "[plant][world_option]" )
{
    map &here = get_map();
    avatar &u = get_avatar();
    clear_avatar();
    clear_map_without_vision();
    reset_test_globals();
    u.set_skill_level( skill_survival, 2 );

    options_manager::options_container world_opts = get_options().get_world_defaults();
    world_opts["CROP_HARVEST_MULTIPLIER"].setValue( "2.0" );
    get_options().set_world_options( &world_opts );
    on_out_of_scope cleanup( [&]() {
        get_options().set_world_options( nullptr );
    } );

    const tripoint_bub_ms plot = u.pos_bub() + tripoint::east;
    here.add_item( plot, item( itype_test_seed_eoc ) );
    here.furn_set( plot, furn_test_f_plant_harvest );

    iexamine::harvest_plant( u, plot, false );

    const std::string harvest_count =
        get_globals().get_global_value( "test_harvest_count" ).to_string();
    REQUIRE( !harvest_count.empty() );
    CHECK( std::stoi( harvest_count ) >= 2 );
}

TEST_CASE( "crop_water_consumption_world_option", "[plant][world_option][water]" )
{
    map &here = get_map();
    avatar &u = get_avatar();
    clear_avatar();
    clear_map_without_vision();
    reset_test_globals();

    const tripoint_bub_ms plot = u.pos_bub() + tripoint::east;
    here.add_item( plot, item( itype_test_seed_eoc ) );
    here.furn_set( plot, furn_f_planter_seed );
    item *seed = iexamine::get_seed_at( here, plot );
    REQUIRE( seed != nullptr );
    iexamine::set_plant_water( *seed, 100 );
    iexamine::set_plant_effective_growth_turns( *seed, 0 );

    // Advance time before recording the last check so the stored timestamp is
    // non-zero.  This avoids the old-save actualization path and lets the
    // irrigated daily loop see a full day of elapsed time.
    calendar::turn += 1_days;
    iexamine::set_plant_last_water_check( *seed, calendar::turn );

    SECTION( "default consumption" ) {
        options_manager::options_container world_opts = get_options().get_world_defaults();
        get_options().set_world_options( &world_opts );
        on_out_of_scope cleanup( [&]() {
            get_options().set_world_options( nullptr );
        } );

        calendar::turn += 1_days;
        here.grow_plant( plot );

        seed = iexamine::get_seed_at( here, plot );
        REQUIRE( seed != nullptr );
        const int water_default = iexamine::get_plant_water( *seed );
        CHECK( water_default < 100 );
        CHECK( water_default >= 80 );
    }

    SECTION( "doubled consumption" ) {
        options_manager::options_container world_opts = get_options().get_world_defaults();
        world_opts["CROP_WATER_CONSUMPTION"].setValue( "2.0" );
        get_options().set_world_options( &world_opts );
        on_out_of_scope cleanup( [&]() {
            get_options().set_world_options( nullptr );
        } );

        calendar::turn += 1_days;
        here.grow_plant( plot );

        seed = iexamine::get_seed_at( here, plot );
        REQUIRE( seed != nullptr );
        const int water_doubled = iexamine::get_plant_water( *seed );
        CHECK( water_doubled < 100 );
        CHECK( water_doubled <= 60 );
    }
}

TEST_CASE( "crop_overgrown_enabled_world_option", "[plant][world_option]" )
{
    map &here = get_map();
    avatar &u = get_avatar();
    clear_avatar();
    clear_map_without_vision();
    reset_test_globals();

    options_manager::options_container world_opts = get_options().get_world_defaults();
    world_opts["CROP_OVERGROWN_ENABLED"].setValue( "false" );
    get_options().set_world_options( &world_opts );
    on_out_of_scope cleanup( [&]() {
        get_options().set_world_options( nullptr );
    } );

    const tripoint_bub_ms plot = u.pos_bub() + tripoint::east;
    here.add_item( plot, item( itype_test_seed_eoc ) );
    here.furn_set( plot, furn_test_f_plant_mature );

    item *seed = iexamine::get_seed_at( here, plot );
    REQUIRE( seed != nullptr );

    // Advance time before recording state so the last-check timestamp is non-zero.
    // This prevents the non-irrigated path from falling back to seed age (which is
    // also zero at turn zero) and makes the elapsed-time calculation meaningful.
    calendar::turn += 1_hours;
    iexamine::set_plant_last_water_check( *seed, calendar::turn );
    // Enough effective time to normally reach overgrown stage.
    iexamine::set_plant_effective_growth_turns( *seed, to_turns<int>( 10_hours ) );

    calendar::turn += 1_hours;
    here.grow_plant( plot );

    seed = iexamine::get_seed_at( here, plot );
    REQUIRE( seed != nullptr );
    // Overgrown must still be prevented.
    CHECK( !iexamine::is_plant_overgrown( here, plot ) );
    CHECK( here.furn( plot ) != furn_test_f_plant_overgrown );
    // But the plant must be allowed to reach harvest, not be stuck at mature.
    CHECK( here.furn( plot ) == furn_test_f_plant_harvest );
    CHECK( iexamine::is_plant_harvestable( here, plot ) );
}

TEST_CASE( "crop_growth_speed_does_not_boost_ter_transform",
           "[plant][world_option][magic][ter_transform]" )
{
    map &here = get_map();
    avatar &u = get_avatar();
    clear_avatar();
    clear_map_without_vision();

    options_manager::options_container world_opts = get_options().get_world_defaults();
    world_opts["CROP_GROWTH_SPEED"].setValue( "2.0" );
    get_options().set_world_options( &world_opts );
    on_out_of_scope cleanup( [&]() {
        get_options().set_world_options( nullptr );
    } );

    const tripoint_bub_ms plot = u.pos_bub() + tripoint::east;

    // Advance time before creating the seed so the birthday and any derived
    // timestamps stay positive.  At turn zero, subtracting the mature threshold
    // produces a negative value that gets clamped back to zero.
    calendar::turn += 1_days;

    // Set up a seedling whose internal timer has not advanced at all.
    item seed( itype_test_seed_simple );
    seed.set_birthday( calendar::turn );
    here.add_item( plot, seed );
    here.furn_set( plot, furn_test_f_plant_seedling );

    REQUIRE( here.furn( plot ) == furn_test_f_plant_seedling );

    REQUIRE( ter_furn_transform_ter_test_plant_seedling_to_mature.is_valid() );
    ter_furn_transform_ter_test_plant_seedling_to_mature->transform( here, plot );

    CHECK( here.furn( plot ) == furn_test_f_plant_mature );

    item *synced_seed = iexamine::get_seed_at( here, plot );
    REQUIRE( synced_seed != nullptr );

    const int mature_stage_idx = iexamine::get_plant_mature_stage_idx( *synced_seed->type->seed );
    REQUIRE( mature_stage_idx >= 0 );
    const time_duration mature_threshold = iexamine::get_plant_stage_threshold(
            *synced_seed->type->seed, mature_stage_idx );
    const float growth_multiplier = here.furn( plot )->plant->growth_multiplier;

    // The transform should synchronize to the mature threshold in base time.
    const time_duration expected_effective = mature_threshold;
    const time_duration actual_effective = iexamine::get_plant_effective_growth_time(
            *synced_seed, growth_multiplier );
    CHECK( actual_effective == expected_effective );
    CHECK( synced_seed->birthday() == calendar::turn - mature_threshold /
           ( growth_multiplier * 2.0f ) );
}

TEST_CASE( "ter_transform_does_not_boost_stage_with_high_crop_speed",
           "[plant][world_option][magic][ter_transform]" )
{
    map &here = get_map();
    avatar &u = get_avatar();
    clear_avatar();
    clear_map_without_vision();

    options_manager::options_container world_opts = get_options().get_world_defaults();
    world_opts["CROP_GROWTH_SPEED"].setValue( "2.0" );
    get_options().set_world_options( &world_opts );
    on_out_of_scope cleanup( [&]() {
        get_options().set_world_options( nullptr );
    } );

    const tripoint_bub_ms plot = u.pos_bub() + tripoint::east;

    calendar::turn += 1_days;

    // Set up a seedling with zero effective growth time.
    item seed( itype_test_seed_simple );
    seed.set_birthday( calendar::turn );
    // Initialize the authoritative variables so the subsequent grow_plant() sees
    // zero elapsed time and does not advance the plant past the transformed stage.
    iexamine::set_plant_effective_growth_turns( seed, 0 );
    iexamine::set_plant_last_water_check( seed, calendar::turn );
    here.add_item( plot, seed );
    here.furn_set( plot, furn_test_f_plant_seedling );

    REQUIRE( here.furn( plot ) == furn_test_f_plant_seedling );

    // Transform to mature.  With CROP_GROWTH_SPEED = 2.0 the old code would have
    // written effective = mature_threshold * 2, causing grow_plant to overshoot to
    // harvest.  After the fix it must stay at mature even if grow_plant is called
    // immediately.
    REQUIRE( ter_furn_transform_ter_test_plant_seedling_to_mature.is_valid() );
    ter_furn_transform_ter_test_plant_seedling_to_mature->transform( here, plot );

    CHECK( here.furn( plot ) == furn_test_f_plant_mature );

    here.grow_plant( plot );

    // Should still be mature, not boosted to harvest.
    CHECK( here.furn( plot ) == furn_test_f_plant_mature );
    CHECK( !iexamine::is_plant_harvestable( here, plot ) );
}

TEST_CASE( "crop_growth_speed_does_not_boost_spell_fertilize", "[plant][world_option][magic]" )
{
    map &here = get_map();
    avatar &u = get_avatar();
    clear_avatar();
    clear_map_without_vision();
    reset_test_globals();

    options_manager::options_container world_opts = get_options().get_world_defaults();
    world_opts["CROP_GROWTH_SPEED"].setValue( "2.0" );
    get_options().set_world_options( &world_opts );
    on_out_of_scope cleanup( [&]() {
        get_options().set_world_options( nullptr );
    } );

    const tripoint_bub_ms plot = u.pos_bub() + tripoint::east;
    here.ter_set( plot, ter_t_dirtmound );

    u.i_add( item( itype_test_seed_simple ) );
    iexamine::plant_seed( u, plot, itype_test_seed_simple );
    process_activity( u );

    item *seed = iexamine::get_seed_at( here, plot );
    REQUIRE( seed != nullptr );
    REQUIRE( seed->has_var( "seed_effective_growth_turns" ) );

    // Let a small amount of real time pass so the plant has a non-zero base effective time.
    calendar::turn += 1_seconds;
    here.grow_plant( plot );

    seed = iexamine::get_seed_at( here, plot );
    REQUIRE( seed != nullptr );
    const float growth_multiplier = here.furn( plot )->plant->growth_multiplier;
    const time_duration before_effective = iexamine::get_plant_effective_growth_time( *seed,
                                           growth_multiplier );

    const spell sp( spell_test_spell_fertilize_plant );
    spell_effect::fertilize_plant( sp, u, plot );

    seed = iexamine::get_seed_at( here, plot );
    REQUIRE( seed != nullptr );
    const time_duration after_effective = iexamine::get_plant_effective_growth_time( *seed,
                                          growth_multiplier );

    // The spell should advance the plant by 25% of its total growth duration,
    // regardless of world speed.
    const std::vector<std::pair<flag_id, time_duration>> &growth_stages =
                seed->type->seed->get_growth_stages();
    time_duration total_growth_time = 0_seconds;
    for( const auto &stage : growth_stages ) {
        total_growth_time += stage.second;
    }
    const time_duration expected_advance = total_growth_time * 0.25f;
    CHECK( after_effective - before_effective == expected_advance );
}

TEST_CASE( "old_save_crop_actualization_scales_with_speed", "[plant][world_option]" )
{
    map &here = get_map();
    avatar &u = get_avatar();
    clear_avatar();
    clear_map_without_vision();

    options_manager::options_container world_opts = get_options().get_world_defaults();
    world_opts["CROP_GROWTH_SPEED"].setValue( "2.0" );
    get_options().set_world_options( &world_opts );
    on_out_of_scope cleanup( [&]() {
        get_options().set_world_options( nullptr );
    } );

    const tripoint_bub_ms plot = u.pos_bub() + tripoint::east;

    // Advance time before creating the old-format seed so the birthday is
    // positive and age() reflects the intended 5 seconds.
    calendar::turn += 1_days;

    // Old-format seed: no seed_effective_growth_turns, birthday in the past.
    item seed( itype_test_seed_simple );
    seed.set_birthday( calendar::turn - 5_seconds );
    here.add_item( plot, seed );
    here.furn_set( plot, furn_test_f_plant_seedling );

    // grow_plant actualizes the old save crop into the new base-time format.
    here.grow_plant( plot );

    item *synced_seed = iexamine::get_seed_at( here, plot );
    REQUIRE( synced_seed != nullptr );
    REQUIRE( synced_seed->has_var( "seed_effective_growth_turns" ) );

    const float growth_multiplier = here.furn( plot )->plant->growth_multiplier;
    const time_duration expected_effective = 5_seconds * growth_multiplier * 2.0f;
    const time_duration actual_effective = iexamine::get_plant_effective_growth_time(
            *synced_seed, growth_multiplier );
    CHECK( actual_effective == expected_effective );
}

TEST_CASE( "mapgen_crop_actualization_scales_with_speed", "[plant][world_option][mapgen]" )
{
    map &here = get_map();
    avatar &u = get_avatar();
    clear_avatar();
    clear_map_without_vision();

    options_manager::options_container world_opts = get_options().get_world_defaults();
    world_opts["CROP_GROWTH_SPEED"].setValue( "4.0" );
    get_options().set_world_options( &world_opts );
    on_out_of_scope cleanup( [&]() {
        get_options().set_world_options( nullptr );
    } );

    const tripoint_bub_ms plot = u.pos_bub() + tripoint::east;

    // Simulate a mapgen-planted seed: birthday at start of cataclysm and a
    // visual stage already set by the mapgen definition.
    item seed( itype_test_seed_simple );
    seed.set_birthday( calendar::start_of_cataclysm );
    here.add_item( plot, seed );
    here.furn_set( plot, furn_test_f_plant_seedling );

    // Advance world time before actualization, as if the player is only now
    // entering the reality bubble.
    calendar::turn = calendar::start_of_cataclysm + 1_seconds;

    here.grow_plant( plot );

    item *synced_seed = iexamine::get_seed_at( here, plot );
    REQUIRE( synced_seed != nullptr );
    REQUIRE( synced_seed->has_var( "seed_effective_growth_turns" ) );

    // With 4x speed, 1 second of real age should yield 4 seconds of base
    // effective growth, pushing the plant well past the harvest threshold.
    CHECK( iexamine::is_plant_harvestable( here, plot ) );

    const float growth_multiplier = here.furn( plot )->plant->growth_multiplier;
    const time_duration expected_effective = 1_seconds * growth_multiplier * 4.0f;
    const time_duration actual_effective = iexamine::get_plant_effective_growth_time(
            *synced_seed, growth_multiplier );
    CHECK( actual_effective == expected_effective );
}

TEST_CASE( "old_save_slow_speed_does_not_regress_stage", "[plant][world_option]" )
{
    map &here = get_map();
    avatar &u = get_avatar();
    clear_avatar();
    clear_map_without_vision();

    options_manager::options_container world_opts = get_options().get_world_defaults();
    world_opts["CROP_GROWTH_SPEED"].setValue( "0.5" );
    get_options().set_world_options( &world_opts );
    on_out_of_scope cleanup( [&]() {
        get_options().set_world_options( nullptr );
    } );

    const tripoint_bub_ms plot = u.pos_bub() + tripoint::east;

    // Advance time before creating the old-format seed so the birthday is positive.
    calendar::turn += 1_days;

    // Old-format seed with very little real age but furniture already at mature.
    // With 0.5x speed the un-clamped effective time would fall below the mature
    // threshold, but the actualization must preserve the visible stage.
    item seed( itype_test_seed_simple );
    seed.set_birthday( calendar::turn - 1_seconds );
    here.add_item( plot, seed );
    here.furn_set( plot, furn_test_f_plant_mature );

    here.grow_plant( plot );

    item *synced_seed = iexamine::get_seed_at( here, plot );
    REQUIRE( synced_seed != nullptr );
    REQUIRE( synced_seed->has_var( "seed_effective_growth_turns" ) );

    // The furniture stage is the authority: the plant must still read as mature.
    CHECK( iexamine::is_plant_mature( here, plot ) );
    CHECK( here.furn( plot ) == furn_test_f_plant_mature );

    const float growth_multiplier = here.furn( plot )->plant->growth_multiplier;
    const int mature_stage_idx = iexamine::get_plant_mature_stage_idx( *synced_seed->type->seed );
    REQUIRE( mature_stage_idx >= 0 );
    const time_duration mature_threshold = iexamine::get_plant_stage_threshold(
            *synced_seed->type->seed, mature_stage_idx );

    // Effective time must be at least the mature threshold to match the visible stage,
    // even though the real age is much smaller.
    const time_duration actual_effective = iexamine::get_plant_effective_growth_time(
            *synced_seed, growth_multiplier );
    CHECK( actual_effective >= mature_threshold );
}

TEST_CASE( "plant_helper_follows_effective_time", "[plant][stage]" )
{
    map &here = get_map();
    avatar &u = get_avatar();
    clear_avatar();
    clear_map_without_vision();
    reset_test_globals();

    const tripoint_bub_ms plot = u.pos_bub() + tripoint::east;

    // Furniture is still at seed, but the effective growth time already says harvest.
    // The helper must follow effective time, not the stale furniture flag.
    item seed( itype_test_seed_simple );
    seed.set_birthday( calendar::turn );
    iexamine::set_plant_effective_growth_turns( seed, to_turns<int>( 10_seconds ) );
    here.add_item( plot, seed );
    here.furn_set( plot, furn_test_f_plant_seed );

    CHECK( iexamine::is_plant_harvestable( here, plot ) );
    CHECK( iexamine::is_plant_mature( here, plot ) );
}

TEST_CASE( "can_fertilize_syncs_furniture_with_effective_time", "[plant][fertilize]" )
{
    map &here = get_map();
    avatar &u = get_avatar();
    clear_avatar();
    clear_map_without_vision();
    reset_test_globals();

    const tripoint_bub_ms plot = u.pos_bub() + tripoint::east;

    // Furniture is seedling, but effective time is already past mature.
    // can_fertilize() should call grow_plant() first, see the plant is mature,
    // and reject fertilization.
    item seed( itype_test_seed_eoc );
    seed.set_birthday( calendar::turn );
    // Effective time past mature (2h) but below overgrown (4h) so the result is
    // deterministic regardless of CROP_OVERGROWN_ENABLED.
    iexamine::set_plant_effective_growth_turns( seed, to_turns<int>( 150_minutes ) );
    here.add_item( plot, seed );
    here.furn_set( plot, furn_test_f_plant_seedling );

    ret_val<void> result = multi_farm_activity_actor::can_fertilize( u, plot );
    CHECK( !result.success() );
    // grow_plant() should also have advanced the furniture to match effective time.
    CHECK( here.furn( plot ) == furn_test_f_plant_mature );
}

namespace
{
// Verify that seed->birthday() is consistent with seed_effective_growth_turns for the
// current world options.  This catches drift between the authoritative variable and
// the derived birthday cache.
void check_seed_birthday_consistency( const item &seed, float growth_multiplier,
                                      float crop_growth_speed )
{
    REQUIRE( seed.has_var( "seed_effective_growth_turns" ) );
    const time_duration effective = time_duration::from_turns(
                                        iexamine::get_plant_effective_growth_turns( seed ) );
    const time_point expected_birthday = calendar::turn - effective /
                                         ( growth_multiplier * crop_growth_speed );
    CHECK( seed.birthday() == expected_birthday );
}
} // namespace

TEST_CASE( "plant_birthday_stays_consistent_after_fertilize", "[plant][fertilize]" )
{
    map &here = get_map();
    avatar &u = get_avatar();
    clear_avatar();
    clear_map_without_vision();
    reset_test_globals();

    options_manager::options_container world_opts = get_options().get_world_defaults();
    world_opts["CROP_GROWTH_SPEED"].setValue( "2.0" );
    get_options().set_world_options( &world_opts );
    on_out_of_scope cleanup( [&]() {
        get_options().set_world_options( nullptr );
    } );

    const tripoint_bub_ms plot = u.pos_bub() + tripoint::east;

    // Advance time before creating the seed so the post-fertilize birthday does not
    // get clamped to turn_zero by item::set_birthday.
    calendar::turn += 1_days;

    item seed( itype_test_seed_eoc );
    seed.set_birthday( calendar::turn );
    // Pre-initialize authoritative variables so the test exercises the normal path.
    iexamine::set_plant_effective_growth_turns( seed, 0 );
    iexamine::set_plant_last_water_check( seed, calendar::turn );
    here.add_item( plot, seed );
    here.furn_set( plot, furn_test_f_plant_seedling );
    u.i_add( item( itype_fertilizer_commercial, calendar::turn ) );

    item *planted_seed = iexamine::get_seed_at( here, plot );
    REQUIRE( planted_seed != nullptr );

    iexamine::fertilize_plant( u, plot, itype_fertilizer_commercial );
    process_activity( u );

    planted_seed = iexamine::get_seed_at( here, plot );
    REQUIRE( planted_seed != nullptr );
    check_seed_birthday_consistency( *planted_seed, here.furn( plot )->plant->growth_multiplier, 2.0f );
}

TEST_CASE( "plant_birthday_stays_consistent_after_transform", "[plant][magic][ter_transform]" )
{
    map &here = get_map();
    avatar &u = get_avatar();
    clear_avatar();
    clear_map_without_vision();

    options_manager::options_container world_opts = get_options().get_world_defaults();
    world_opts["CROP_GROWTH_SPEED"].setValue( "2.0" );
    get_options().set_world_options( &world_opts );
    on_out_of_scope cleanup( [&]() {
        get_options().set_world_options( nullptr );
    } );

    const tripoint_bub_ms plot = u.pos_bub() + tripoint::east;

    calendar::turn += 1_days;

    item seed( itype_test_seed_simple );
    seed.set_birthday( calendar::turn );
    here.add_item( plot, seed );
    here.furn_set( plot, furn_test_f_plant_seedling );

    REQUIRE( ter_furn_transform_ter_test_plant_seedling_to_mature.is_valid() );
    ter_furn_transform_ter_test_plant_seedling_to_mature->transform( here, plot );

    CHECK( here.furn( plot ) == furn_test_f_plant_mature );

    item *synced_seed = iexamine::get_seed_at( here, plot );
    REQUIRE( synced_seed != nullptr );
    check_seed_birthday_consistency( *synced_seed, here.furn( plot )->plant->growth_multiplier, 2.0f );
}

TEST_CASE( "plant_old_save_irrigated_planter_migration", "[plant][world_option][water]" )
{
    map &here = get_map();
    avatar &u = get_avatar();
    clear_avatar();
    clear_map_without_vision();

    options_manager::options_container world_opts = get_options().get_world_defaults();
    world_opts["CROP_GROWTH_SPEED"].setValue( "2.0" );
    get_options().set_world_options( &world_opts );
    on_out_of_scope cleanup( [&]() {
        get_options().set_world_options( nullptr );
    } );

    const tripoint_bub_ms plot = u.pos_bub() + tripoint::east;

    // Advance time so the seed's birthday can be positive.
    calendar::turn += 1_days;

    // Old-format seed in an irrigable planter: no seed_effective_growth_turns, but the
    // furniture already shows a later stage.  The irrigated migration branch must still
    // clamp effective time to the visible stage threshold.
    item seed( itype_test_seed_simple );
    seed.set_birthday( calendar::turn - 1_seconds );
    seed.erase_var( "seed_effective_growth_turns" );
    here.add_item( plot, seed );
    here.furn_set( plot, furn_test_f_planter_high_water_seed );

    here.grow_plant( plot );

    item *synced_seed = iexamine::get_seed_at( here, plot );
    REQUIRE( synced_seed != nullptr );
    REQUIRE( synced_seed->has_var( "seed_effective_growth_turns" ) );

    const int mature_stage_idx = iexamine::get_plant_mature_stage_idx( *synced_seed->type->seed );
    REQUIRE( mature_stage_idx >= 0 );
    const time_duration mature_threshold = iexamine::get_plant_stage_threshold(
            *synced_seed->type->seed, mature_stage_idx );

    // The furniture is still at seed, so effective time only needs to be non-negative.
    // The migration path deliberately preserves the original birthday (real planting time),
    // so we only check that a valid effective time was created.
    const time_duration actual_effective = iexamine::get_plant_effective_growth_time(
            *synced_seed, here.furn( plot )->plant->growth_multiplier );
    CHECK( actual_effective >= 0_seconds );

    // Now test the mature-stage clamp by jumping the furniture forward and migrating again.
    here.furn_set( plot, furn_test_f_planter_high_water_mature );
    synced_seed->erase_var( "seed_effective_growth_turns" );
    here.grow_plant( plot );

    synced_seed = iexamine::get_seed_at( here, plot );
    REQUIRE( synced_seed != nullptr );
    const time_duration mature_effective = iexamine::get_plant_effective_growth_time(
            *synced_seed, here.furn( plot )->plant->growth_multiplier );
    CHECK( mature_effective >= mature_threshold );
}
