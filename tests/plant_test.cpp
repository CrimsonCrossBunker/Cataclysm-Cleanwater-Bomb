#include <cstdint>
#include <functional>
#include <memory>
#include <optional>
#include <set>
#include <sstream>
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
#include "game.h"
#include "farming.h"
#include "fungal_effects.h"
#include "flexbuffer_json.h"
#include "iexamine.h"
#include "item.h"
#include "itype.h"
#include "json.h"
#include "json_loader.h"
#include "magic.h"
#include "magic_ter_furn_transform.h"
#include "map.h"
#include "map_helpers.h"
#include "map_selector.h"
#include "mapdata.h"
#include "math_parser_diag_value.h"
#include "npc.h"
#include "npc_lifetime.h"
#include "options.h"
#include "player_helpers.h"
#include "player_activity.h"
#include "pocket_type.h"
#include "point.h"
#include "ret_val.h"
#include "rng.h"
#include "submap.h"
#include "type_id.h"
#include "units.h"
#include "value_ptr.h"
#include "vehicle.h"
#include "vehicle_control.h"
#include "mp_client_conn.h"
#include "vpart_position.h"
#include "vpart_range.h"

static const furn_str_id furn_f_planter_seed( "f_planter_seed" );
static const furn_str_id furn_test_f_plant_harvest( "test_f_plant_harvest" );
static const furn_str_id furn_test_f_plant_mature( "test_f_plant_mature" );
static const furn_str_id furn_test_f_plant_overgrown( "test_f_plant_overgrown" );
static const furn_str_id furn_test_f_plant_seed( "test_f_plant_seed" );
static const furn_str_id furn_test_f_plant_seedling( "test_f_plant_seedling" );
static const furn_str_id
furn_test_f_planter_no_overgrowth_seed( "test_f_planter_no_overgrowth_seed" );
static const furn_str_id
furn_test_f_planter_no_overgrowth_seedling( "test_f_planter_no_overgrowth_seedling" );
static const furn_str_id
furn_test_f_planter_no_overgrowth_mature( "test_f_planter_no_overgrowth_mature" );
static const furn_str_id
furn_test_f_planter_no_overgrowth_harvest( "test_f_planter_no_overgrowth_harvest" );
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
static const ter_str_id ter_test_t_terrain_growth_final( "test_t_terrain_growth_final" );
static const ter_str_id ter_test_t_terrain_growth_middle( "test_t_terrain_growth_middle" );
static const ter_str_id ter_test_t_terrain_growth_seed( "test_t_terrain_growth_seed" );
static const ter_str_id ter_t_dirt( "t_dirt" );
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
            if( on_event ) {
                on_event( e );
            }
        }
    }

    std::vector<cata::event> events;
    std::function<void( const cata::event & )> on_event;
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

    u.setpos( here, vehicle_pos );
    u.controlling_vehicle = true;
    REQUIRE( veh->get_driver( here ) == &u );
    const on_out_of_scope release_controls( [&]() {
        u.controlling_vehicle = false;
    } );

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

TEST_CASE( "planter_flag_prevents_crop_overgrowth", "[plant][furniture][flag]" )
{
    map &here = get_map();
    avatar &u = get_avatar();
    clear_avatar();
    clear_map_without_vision();
    reset_test_globals();

    options_manager::options_container world_opts = get_options().get_world_defaults();
    world_opts["CROP_OVERGROWN_ENABLED"].setValue( "true" );
    get_options().set_world_options( &world_opts );
    on_out_of_scope cleanup( [&]() {
        get_options().set_world_options( nullptr );
    } );

    const tripoint_bub_ms plot = u.pos_bub() + tripoint::east;
    here.add_item( plot, item( itype_test_seed_eoc ) );
    here.furn_set( plot, furn_test_f_planter_no_overgrowth_seed );

    for( const furn_str_id &expected : {
             furn_test_f_planter_no_overgrowth_seedling,
             furn_test_f_planter_no_overgrowth_mature,
             furn_test_f_planter_no_overgrowth_harvest
         } ) {
        calendar::turn += 1_hours;
        here.grow_plant( plot );
        CHECK( here.furn( plot ) == expected );
        CHECK( here.furn( plot ).obj().has_flag( "NO_CROP_OVERGROWTH" ) );
    }

    calendar::turn += 1_hours;
    here.grow_plant( plot );

    CHECK( here.furn( plot ) == furn_test_f_planter_no_overgrowth_harvest );
    CHECK( !iexamine::is_plant_overgrown( here, plot ) );
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

TEST_CASE( "terrain_growth_data_loads_from_json", "[terrain_growth][plant]" )
{
    REQUIRE( ter_test_t_terrain_growth_seed.is_valid() );
    REQUIRE( ter_test_t_terrain_growth_middle.is_valid() );
    REQUIRE( ter_test_t_terrain_growth_final.is_valid() );

    const ter_t &seed = ter_test_t_terrain_growth_seed.obj();
    REQUIRE( seed.terrain_growth );
    CHECK( seed.has_examine( iexamine::fertilize_terrain ) );
    CHECK( seed.terrain_growth->transform == ter_test_t_terrain_growth_middle );
    CHECK( seed.terrain_growth->growth_time == 2_days );
    CHECK( seed.terrain_growth->growth_multiplier == 1.0f );
    CHECK( seed.terrain_growth->fertilize_seasons == std::set<season_type> { SPRING } );

    const ter_t &middle = ter_test_t_terrain_growth_middle.obj();
    REQUIRE( middle.terrain_growth );
    CHECK( middle.has_examine( iexamine::fertilize_terrain ) );
    CHECK( middle.terrain_growth->transform == ter_test_t_terrain_growth_final );
    CHECK( middle.terrain_growth->growth_time == 4_days );
    CHECK( middle.terrain_growth->growth_multiplier == 1.0f );
    CHECK( middle.terrain_growth->fertilize_seasons == std::set<season_type> { SPRING, SUMMER } );

    CHECK( !ter_test_t_terrain_growth_final->terrain_growth );
}

TEST_CASE( "terrain_growth_advances_after_fertilized_time", "[terrain_growth][plant]" )
{
    map &here = get_map();
    avatar &u = get_avatar();
    clear_avatar();
    clear_map_without_vision();

    const time_point old_turn = calendar::turn;
    on_out_of_scope restore_turn( [&]() {
        calendar::turn = old_turn;
    } );

    options_manager::options_container world_opts = get_options().get_world_defaults();
    world_opts["CROP_GROWTH_SPEED"].setValue( "1.0" );
    get_options().set_world_options( &world_opts );
    on_out_of_scope restore_options( [&]() {
        get_options().set_world_options( nullptr );
    } );

    const tripoint_bub_ms plot = u.pos_bub() + tripoint::east;
    calendar::turn = calendar::turn_zero + 12_hours;
    here.ter_set( plot, ter_test_t_terrain_growth_seed );

    here.grow_terrain_plant( plot );
    CHECK( here.ter( plot ).obj().id == ter_test_t_terrain_growth_seed );

    terrain_growth_state state;
    state.fertilized_at = calendar::turn - 2_days + 1_turns;
    here.set_terrain_growth( plot, state );

    here.grow_terrain_plant( plot );
    CHECK( here.ter( plot ).obj().id == ter_test_t_terrain_growth_seed );
    REQUIRE( here.get_terrain_growth( plot ) != nullptr );

    calendar::turn += 1_turns;
    here.grow_terrain_plant( plot );
    CHECK( here.ter( plot ).obj().id == ter_test_t_terrain_growth_middle );
    CHECK( here.get_terrain_growth( plot ) == nullptr );
}

TEST_CASE( "terrain_growth_respects_crop_growth_speed", "[terrain_growth][plant][world_option]" )
{
    map &here = get_map();
    avatar &u = get_avatar();
    clear_avatar();
    clear_map_without_vision();

    const time_point old_turn = calendar::turn;
    on_out_of_scope restore_turn( [&]() {
        calendar::turn = old_turn;
    } );

    options_manager::options_container world_opts = get_options().get_world_defaults();
    world_opts["CROP_GROWTH_SPEED"].setValue( "2.0" );
    get_options().set_world_options( &world_opts );
    on_out_of_scope restore_options( [&]() {
        get_options().set_world_options( nullptr );
    } );

    const tripoint_bub_ms plot = u.pos_bub() + tripoint::east;
    calendar::turn = calendar::turn_zero + 12_hours;
    here.ter_set( plot, ter_test_t_terrain_growth_seed );

    terrain_growth_state state;
    state.fertilized_at = calendar::turn - 2_days / 2;
    here.set_terrain_growth( plot, state );

    here.grow_terrain_plant( plot );
    CHECK( here.ter( plot ).obj().id == ter_test_t_terrain_growth_middle );
}

TEST_CASE( "terrain_growth_state_is_cleared_when_terrain_changes", "[terrain_growth][plant]" )
{
    map &here = get_map();
    avatar &u = get_avatar();
    clear_avatar();
    clear_map_without_vision();

    const tripoint_bub_ms plot = u.pos_bub() + tripoint::east;
    here.ter_set( plot, ter_test_t_terrain_growth_seed );

    terrain_growth_state state;
    state.fertilized_at = calendar::turn;
    here.set_terrain_growth( plot, state );
    REQUIRE( here.get_terrain_growth( plot ) != nullptr );

    here.ter_set( plot, ter_t_dirt );
    CHECK( here.get_terrain_growth( plot ) == nullptr );
}

TEST_CASE( "terrain_growth_fertilize_checks_season_and_existing_state",
           "[terrain_growth][plant][fertilize]" )
{
    map &here = get_map();
    avatar &u = get_avatar();
    clear_avatar();
    clear_map_without_vision();

    const time_point old_turn = calendar::turn;
    on_out_of_scope restore_turn( [&]() {
        calendar::turn = old_turn;
    } );

    const tripoint_bub_ms plot = u.pos_bub() + tripoint::east;
    here.ter_set( plot, ter_test_t_terrain_growth_seed );

    calendar::turn = calendar::turn_zero + calendar::season_length();
    ret_val<void> wrong_season = multi_farm_activity_actor::can_fertilize( u, plot );
    CHECK( !wrong_season.success() );
    CHECK( wrong_season.str().find( "correct season" ) != std::string::npos );

    calendar::turn = calendar::turn_zero + 12_hours;
    ret_val<void> correct_season = multi_farm_activity_actor::can_fertilize( u, plot );
    CHECK( correct_season.success() );

    terrain_growth_state state;
    state.fertilized_at = calendar::turn;
    here.set_terrain_growth( plot, state );

    ret_val<void> already_fertilized = multi_farm_activity_actor::can_fertilize( u, plot );
    CHECK( !already_fertilized.success() );
    CHECK( already_fertilized.str().find( "already been fertilized" ) != std::string::npos );
}

TEST_CASE( "terrain_growth_can_fertilize_syncs_expired_growth",
           "[terrain_growth][plant][fertilize]" )
{
    map &here = get_map();
    avatar &u = get_avatar();
    clear_avatar();
    clear_map_without_vision();

    const time_point old_turn = calendar::turn;
    on_out_of_scope restore_turn( [&]() {
        calendar::turn = old_turn;
    } );

    options_manager::options_container world_opts = get_options().get_world_defaults();
    world_opts["CROP_GROWTH_SPEED"].setValue( "1.0" );
    get_options().set_world_options( &world_opts );
    on_out_of_scope restore_options( [&]() {
        get_options().set_world_options( nullptr );
    } );

    const tripoint_bub_ms plot = u.pos_bub() + tripoint::east;
    calendar::turn = calendar::turn_zero + 12_hours;
    here.ter_set( plot, ter_test_t_terrain_growth_seed );

    terrain_growth_state state;
    state.fertilized_at = calendar::turn - 2_days;
    here.set_terrain_growth( plot, state );
    REQUIRE( here.get_terrain_growth( plot ) != nullptr );

    ret_val<void> result = multi_farm_activity_actor::can_fertilize( u, plot );

    CHECK( here.ter( plot ).obj().id == ter_test_t_terrain_growth_middle );
    CHECK( here.get_terrain_growth( plot ) == nullptr );
    CHECK( result.success() );
}

TEST_CASE( "terrain_growth_fertilize_ignores_loose_seed_items",
           "[terrain_growth][plant][fertilize]" )
{
    map &here = get_map();
    avatar &u = get_avatar();
    clear_avatar();
    clear_map_without_vision();

    const time_point old_turn = calendar::turn;
    on_out_of_scope restore_turn( [&]() {
        calendar::turn = old_turn;
    } );

    const tripoint_bub_ms plot = u.pos_bub() + tripoint::east;
    calendar::turn = calendar::turn_zero + 12_hours;
    here.ter_set( plot, ter_test_t_terrain_growth_seed );
    here.add_item( plot, item( itype_test_seed_simple ) );
    u.i_add( item( itype_fertilizer_commercial, calendar::turn ) );

    iexamine::fertilize_plant( u, plot, itype_fertilizer_commercial );
    process_activity( u );

    CHECK( here.ter( plot ).obj().id == ter_test_t_terrain_growth_seed );
    CHECK( here.get_terrain_growth( plot ) != nullptr );
    CHECK( !here.i_at( plot ).empty() );
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

TEST_CASE( "delayed_planting_owns_the_character_and_unoccupied_plot",
           "[plant][activity][multiplayer]" )
{
    clear_avatar();
    clear_map_without_vision();
    reset_test_globals();
    avatar &host = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms plot = host.pos_bub() + tripoint::east;
    npc &remote = spawn_npc( ( host.pos_bub() + tripoint::south ).xy(), "test_talker" );
    clear_character( remote, true );
    remote.setpos( here, host.pos_bub() + tripoint::south );
    const on_out_of_scope cleanup( [&]() {
        host.activity.set_to_null();
        clear_npcs();
    } );
    here.ter_set( plot, ter_t_dirtmound );
    item seeds( itype_test_seed_eoc );
    seeds.charges = 5;
    host.i_add( seeds );
    remote.i_add( seeds );
    iexamine::plant_seed( host, plot, itype_test_seed_eoc );
    iexamine::plant_seed( remote, plot, itype_test_seed_eoc );
    REQUIRE( host.activity.actor );
    REQUIRE( remote.activity.actor );

    SECTION( "only_the_first_completion_consumes_a_seed" ) {
        remote.activity.actor->finish( remote.activity, remote );
        host.activity.actor->finish( host.activity, host );
        CHECK( remote.charges_of( itype_test_seed_eoc ) == 4 );
        CHECK( host.charges_of( itype_test_seed_eoc ) == 5 );
        REQUIRE( iexamine::get_seed_at( here, plot ) );
        CHECK( iexamine::get_seed_at( here, plot )->charges == 1 );
    }
    SECTION( "saved_work_cannot_be_finished_by_another_character" ) {
        std::ostringstream serialized;
        JsonOut out( serialized );
        remote.activity.serialize( out );
        player_activity restored;
        restored.deserialize( json_loader::from_string( serialized.str() ).get_object() );
        REQUIRE( restored.actor );
        restored.actor->finish( restored, host );
        CHECK_FALSE( restored );
        CHECK( here.i_at( plot ).empty() );
        CHECK( host.charges_of( itype_test_seed_eoc ) == 5 );
        CHECK( remote.charges_of( itype_test_seed_eoc ) == 5 );
        // The original owner's activity remains usable.
        remote.activity.actor->finish( remote.activity, remote );
        CHECK( remote.charges_of( itype_test_seed_eoc ) == 4 );
    }
    SECTION( "event_can_remove_the_seed_and_replace_the_activity" ) {
        plant_event_subscriber sub;
        sub.on_event = [&]( const cata::event & event ) {
            if( event.type() == event_type::character_plants_seed ) {
                CHECK( event.get<character_id>( "character" ) == remote.getID() );
                here.i_clear( plot );
                remote.assign_activity( player_activity( activity_id( "ACT_WAIT" ), 321 ) );
            }
        };
        get_event_bus().subscribe( &sub );
        const on_out_of_scope unsubscribe( [&]() {
            get_event_bus().unsubscribe( &sub );
        } );
        remote.activity.actor->finish( remote.activity, remote );
        CHECK( remote.activity.id() == activity_id( "ACT_WAIT" ) );
        CHECK( remote.activity.moves_left == 321 );
        CHECK( remote.charges_of( itype_test_seed_eoc ) == 4 );
        CHECK( here.i_at( plot ).empty() );
        // The per-seed hook must not dereference the erased seed after the event.
        CHECK( get_globals().get_global_value( "test_planted" ).to_string() != "1" );
    }
}

TEST_CASE( "fertilizing_revalidates_the_original_plant_before_spending_material",
           "[plant][activity][multiplayer][save]" )
{
    clear_avatar();
    clear_map_without_vision();
    avatar &host = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms plot = host.pos_bub() + tripoint::east;
    npc &remote = spawn_npc( ( host.pos_bub() + tripoint::south ).xy(), "test_talker" );
    clear_character( remote, true );
    remote.setpos( here, host.pos_bub() + tripoint::south );
    const on_out_of_scope cleanup( [&]() {
        host.activity.set_to_null();
        clear_npcs();
    } );
    here.add_item( plot, item( itype_test_seed_eoc, calendar::turn ) );
    here.furn_set( plot, furn_test_f_plant_seed );
    item fertilizer( itype_fertilizer_commercial, calendar::turn );
    fertilizer.charges = 5;
    host.i_add( fertilizer );
    remote.i_add( fertilizer );
    iexamine::fertilize_plant( host, plot, itype_fertilizer_commercial );
    iexamine::fertilize_plant( remote, plot, itype_fertilizer_commercial );
    REQUIRE( host.activity.actor );
    REQUIRE( remote.activity.actor );

    SECTION( "two_players_do_not_fertilize_the_same_plant_twice" ) {
        remote.activity.actor->finish( remote.activity, remote );
        host.activity.actor->finish( host.activity, host );
        CHECK( remote.charges_of( itype_fertilizer_commercial ) == 4 );
        CHECK( host.charges_of( itype_fertilizer_commercial ) == 5 );
        REQUIRE( iexamine::get_seed_at( here, plot ) );
        CHECK( iexamine::is_plant_fertilized( *iexamine::get_seed_at( here, plot ) ) );
    }
    SECTION( "saved_activity_tracks_absolute_plot_and_seed_identity" ) {
        std::ostringstream serialized;
        JsonOut out( serialized );
        remote.activity.serialize( out );
        player_activity restored;
        restored.deserialize( json_loader::from_string( serialized.str() ).get_object() );
        REQUIRE( restored.actor );
        std::ostringstream actor_json;
        JsonOut actor_out( actor_json );
        restored.actor->serialize( actor_out );
        const JsonObject saved = json_loader::from_string( actor_json.str() ).get_object();
        tripoint_abs_ms position;
        saved.read( "position_abs", position );
        CHECK( position == here.get_abs( plot ) );
        CHECK_FALSE( saved.has_member( "plant_position" ) );
        here.i_clear( plot );
        here.add_item( plot, item( itype_test_seed_eoc, calendar::turn ) );
        restored.actor->finish( restored, remote );
        CHECK_FALSE( restored );
        CHECK( remote.charges_of( itype_fertilizer_commercial ) == 5 );
        CHECK_FALSE( iexamine::is_plant_fertilized( *iexamine::get_seed_at( here, plot ) ) );
    }
    SECTION( "event_removes_seed_without_cancelling_replacement_work" ) {
        plant_event_subscriber sub;
        sub.on_event = [&]( const cata::event & event ) {
            if( event.type() == event_type::character_fertilizes_plant ) {
                CHECK( event.get<character_id>( "character" ) == remote.getID() );
                here.i_clear( plot );
                remote.assign_activity( player_activity( activity_id( "ACT_WAIT" ), 432 ) );
            }
        };
        get_event_bus().subscribe( &sub );
        const on_out_of_scope unsubscribe( [&]() {
            get_event_bus().unsubscribe( &sub );
        } );
        remote.activity.actor->finish( remote.activity, remote );
        CHECK( remote.activity.id() == activity_id( "ACT_WAIT" ) );
        CHECK( remote.activity.moves_left == 432 );
        CHECK( remote.charges_of( itype_fertilizer_commercial ) == 4 );
        CHECK( here.i_at( plot ).empty() );
    }
}

TEST_CASE( "harvest_commits_once_before_reentrant_events_and_preserves_new_work",
           "[plant][activity][ownership]" )
{
    clear_avatar();
    clear_map_without_vision();
    reset_test_globals();
    avatar &who = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms plot = who.pos_bub() + tripoint::east;
    here.add_item( plot, item( itype_test_seed_eoc ) );
    here.furn_set( plot, furn_test_f_plant_harvest );
    plant_event_subscriber sub;
    int committed_items = 0;
    const auto product_count = [&]() {
        int count = 0;
        for( const item &value : here.i_at( who.pos_bub() ) ) {
            count += value.count();
        }
        return count;
    };
    sub.on_event = [&]( const cata::event & event ) {
        if( event.type() != event_type::character_harvests_plant || sub.events.size() > 1 ) {
            return;
        }
        committed_items = product_count();
        CHECK( committed_items > 0 );
        CHECK( iexamine::get_seed_at( here, plot ) == nullptr );
        iexamine::harvest_plant( who, plot, false );
        CHECK( product_count() == committed_items );
        // New objects and work installed by the event must survive settlement.
        here.add_item( plot, item( itype_test_seed_simple ) );
        here.furn_set( plot, furn_test_f_plant_seed );
        who.assign_activity( player_activity( activity_id( "ACT_WAIT" ), 654 ) );
    };
    get_event_bus().subscribe( &sub );
    const on_out_of_scope cleanup( [&]() {
        get_event_bus().unsubscribe( &sub );
        who.activity.set_to_null();
    } );
    iexamine::harvest_plant( who, plot, false );
    REQUIRE( sub.events.size() == 1 );
    REQUIRE( iexamine::get_seed_at( here, plot ) );
    CHECK( iexamine::get_seed_at( here, plot )->typeId() == itype_test_seed_simple );
    CHECK( here.furn( plot ) == furn_test_f_plant_seed );
    CHECK( product_count() == committed_items );
    CHECK( who.activity.id() == activity_id( "ACT_WAIT" ) );
    CHECK( who.activity.moves_left == 654 );
    CHECK( get_globals().get_global_value( "test_harvest_count" ).to_string() ==
           std::to_string( sub.events.front().get<int>( "plant_count" ) ) );
}

TEST_CASE( "watering_event_can_replace_crop_without_dereferencing_the_old_seed",
           "[plant][water][multiplayer]" )
{
    clear_avatar();
    clear_map_without_vision();
    reset_test_globals();
    avatar &host = get_avatar();
    map &here = get_map();
    npc &remote = spawn_npc( ( host.pos_bub() + tripoint::south ).xy(), "test_talker" );
    clear_character( remote, true );
    remote.setpos( here, host.pos_bub() + tripoint::south );
    const tripoint_bub_ms plot = host.pos_bub() + tripoint::east;
    here.add_item( plot, item( itype_test_seed_eoc ) );
    here.furn_set( plot, furn_f_planter_seed );
    item bottle( itype_bottle_plastic );
    REQUIRE( bottle.put_in( item( itype_water_clean, calendar::turn, 2 ),
                            pocket_type::CONTAINER ).success() );
    host.i_add( bottle );
    remote.i_add( bottle );
    plant_event_subscriber sub;
    sub.on_event = [&]( const cata::event & event ) {
        if( event.type() == event_type::character_waters_plant ) {
            CHECK( event.get<character_id>( "character" ) == remote.getID() );
            here.i_clear( plot );
            here.add_item( plot, item( itype_test_seed_simple ) );
            remote.assign_activity( player_activity( activity_id( "ACT_WAIT" ), 456 ) );
        }
    };
    get_event_bus().subscribe( &sub );
    const on_out_of_scope cleanup( [&]() {
        get_event_bus().unsubscribe( &sub );
        clear_npcs();
    } );
    iexamine::water_plant( remote, plot );
    REQUIRE( sub.events.size() == 1 );
    REQUIRE( iexamine::get_seed_at( here, plot ) );
    CHECK( iexamine::get_plant_water( *iexamine::get_seed_at( here, plot ) ) == 0 );
    CHECK( host.charges_of( itype_water_clean ) == 2 );
    CHECK( remote.charges_of( itype_water_clean ) == 1 );
    CHECK( remote.activity.id() == activity_id( "ACT_WAIT" ) );
    CHECK( remote.activity.moves_left == 456 );
}

TEST_CASE( "spore_exposure_uses_each_players_body_with_the_same_native_random_sequence",
           "[plant][fungus][multiplayer]" )
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    avatar &host = get_avatar();
    clear_character( host, true );
    npc &remote = spawn_npc( ( host.pos_bub() + tripoint::south ).xy(), "test_talker" );
    clear_character( remote, true );
    remote.setpos( here, host.pos_bub() + tripoint::south );
    remote.set_value( "mp_proxy", std::string( "1" ) );
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    const on_out_of_scope cleanup( []() {
        clear_npcs();
    } );
    rng_set_engine_seed( 713 );
    for( int repeat = 0; repeat < 8; ++repeat ) {
        fungal_effects().fungalize( host.pos_bub() );
    }
    const auto host_rng = rng_get_engine();
    rng_set_engine_seed( 713 );
    for( int repeat = 0; repeat < 8; ++repeat ) {
        fungal_effects().fungalize( remote.pos_bub() );
    }
    CHECK( rng_get_engine() == host_rng );
    int exposed_parts = 0;
    const efftype_id spores( "spores" );
    for( const char *name : {
             "head", "torso", "arm_l", "arm_r", "leg_l", "leg_r"
         } ) {
        const bodypart_id part( name );
        CHECK( remote.get_effect_int( spores, part ) == host.get_effect_int( spores, part ) );
        CHECK( remote.get_effect_dur( spores, part ) == host.get_effect_dur( spores, part ) );
        exposed_parts += remote.has_effect( spores, part );
    }
    CHECK( exposed_parts > 0 );
}

TEST_CASE( "vehicle_farming_uses_the_driver_and_commits_before_callbacks",
           "[plant][vehicle][multiplayer][ownership]" )
{
    clear_avatar();
    clear_map_without_vision();
    reset_test_globals();
    avatar &host = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms origin = host.pos_bub() + tripoint::east * 6;
    vehicle *machine = here.add_vehicle( vehicle_prototype_oldtractor, origin, 0_degrees, 0,
                                         veh_spawn_status::UNDAMAGED );
    REQUIRE( machine );
    npc &driver = spawn_npc( origin.xy(), "test_talker" );
    clear_character( driver, true );
    driver.setpos( here, origin );
    driver.controlling_vehicle = true;
    const character_id driver_id = driver.getID();
    REQUIRE( vehicle_operator( *machine, here ) == &driver );
    int planter = -1;
    int reaper = -1;
    for( const vpart_reference &part : machine->get_all_parts() ) {
        if( part.has_feature( "PLANTER" ) ) {
            part.part().enabled = true;
            planter = part.part_index();
        }
        if( part.has_feature( "REAPER" ) ) {
            part.part().enabled = true;
            reaper = part.part_index();
        }
    }
    REQUIRE( planter >= 0 );
    REQUIRE( reaper >= 0 );
    const tripoint_bub_ms planting = machine->bub_part_pos( here, machine->part( planter ) );
    const tripoint_bub_ms harvesting = machine->bub_part_pos( here, machine->part( reaper ) );
    here.ter_set( planting, ter_t_dirtmound );
    item supply( itype_test_seed_eoc );
    supply.charges = 5;
    REQUIRE( machine->add_item( here, machine->part( planter ), supply ) );
    item crop( itype_test_seed_eoc );
    crop.set_age( 4_hours );
    here.add_item( harvesting, crop );
    here.furn_set( harvesting, furn_test_f_plant_harvest );
    plant_event_subscriber sub;
    get_event_bus().subscribe( &sub );
    const on_out_of_scope cleanup( [&]() {
        cata_mp::set_client_mode( false );
        get_event_bus().unsubscribe( &sub );
        clear_npcs();
    } );
    const auto supplies = [&]() {
        int count = 0;
        for( const item &value : machine->get_items( machine->part( planter ) ) ) {
            count += value.count();
        }
        return count;
    };

    SECTION( "planting_reentry_cannot_spend_twice_or_run_hooks_on_a_replacement_seed" ) {
        sub.on_event = [&]( const cata::event & event ) {
            CHECK( event.type() == event_type::character_plants_seed );
            CHECK( event.get<character_id>( "character" ) == driver_id );
            CHECK( supplies() == 4 );
            machine->operate_planter( here );
            CHECK( supplies() == 4 );
            here.i_clear( planting );
            here.add_item( planting, item( itype_test_seed_simple ) );
        };
        machine->operate_planter( here );
        REQUIRE( sub.events.size() == 1 );
        CHECK( supplies() == 4 );
        REQUIRE( iexamine::get_seed_at( here, planting ) );
        CHECK( iexamine::get_seed_at( here, planting )->typeId() == itype_test_seed_simple );
        CHECK( get_globals().get_global_value( "test_planted" ).to_string() != "1" );
    }
    SECTION( "harvest_callback_can_replace_the_plot_without_another_harvest_or_item_loss" ) {
        int committed = 0;
        int64_t replacement = 0;
        sub.on_event = [&]( const cata::event & event ) {
            CHECK( event.type() == event_type::character_harvests_plant );
            CHECK( event.get<character_id>( "character" ) == driver_id );
            CHECK( here.furn( harvesting ) == furn_str_id::NULL_ID() );
            for( const item &value : here.i_at( harvesting ) ) {
                committed += value.count();
            }
            CHECK( committed > 0 );
            machine->operate_reaper( here );
            item &seed = here.add_item( harvesting, item( itype_test_seed_simple ) );
            replacement = seed.uid().get_value();
            here.furn_set( harvesting, furn_test_f_plant_seed );
        };
        machine->operate_reaper( here );
        REQUIRE( sub.events.size() == 1 );
        CHECK( here.furn( harvesting ) == furn_test_f_plant_seed );
        int total = 0;
        bool kept_replacement = false;
        for( const item &value : here.i_at( harvesting ) ) {
            if( value.uid().get_value() == replacement ) {
                kept_replacement = true;
            } else {
                total += value.count();
            }
        }
        CHECK( kept_replacement );
        CHECK( total == committed );
        CHECK( get_globals().get_global_value( "test_harvest_count" ).to_string() ==
               std::to_string( sub.events.front().get<int>( "plant_count" ) ) );
    }
    SECTION( "removing_the_machine_during_planting_stops_the_rest_of_on_move" ) {
        const auto lifetime = machine->get_safe_reference();
        sub.on_event = [&]( const cata::event & event ) {
            CHECK( event.type() == event_type::character_plants_seed );
            CHECK( event.get<character_id>( "character" ) == driver_id );
            here.destroy_vehicle( machine );
        };
        machine->on_move( here );
        CHECK_FALSE( lifetime );
        CHECK( sub.events.size() == 1 );
        CHECK( here.furn( harvesting ) == furn_test_f_plant_harvest );
        REQUIRE( iexamine::get_seed_at( here, planting ) );
        CHECK( iexamine::get_seed_at( here, planting )->count() == 1 );
    }
    SECTION( "harvest_callback_can_remove_the_working_part_and_rebuild_the_part_vector" ) {
        sub.on_event = [&]( const cata::event & event ) {
            CHECK( event.get<character_id>( "character" ) == driver_id );
            machine->remove_part( machine->part( reaper ) );
            machine->part_removal_cleanup( here );
        };
        machine->operate_reaper( here );
        REQUIRE( sub.events.size() == 1 );
        CHECK( here.furn( harvesting ) == furn_str_id::NULL_ID() );
        CHECK_FALSE( here.i_at( harvesting ).empty() );
    }
    SECTION( "removing_the_operator_after_harvesting_does_not_lose_the_committed_yield" ) {
        int committed = 0;
        sub.on_event = [&]( const cata::event & event ) {
            CHECK( event.get<character_id>( "character" ) == driver_id );
            for( const item &value : here.i_at( harvesting ) ) {
                committed += value.count();
            }
            g->remove_npc( driver_id );
        };
        machine->operate_reaper( here );
        REQUIRE( sub.events.size() == 1 );
        CHECK( committed > 0 );
        int remaining = 0;
        for( const item &value : here.i_at( harvesting ) ) {
            remaining += value.count();
        }
        CHECK( remaining == committed );
        CHECK( here.furn( harvesting ) == furn_str_id::NULL_ID() );
    }
    SECTION( "unattended_machinery_produces_items_without_assigning_host_effects" ) {
        driver.controlling_vehicle = false;
        REQUIRE( vehicle_operator( *machine, here ) == nullptr );
        machine->operate_planter( here );
        machine->operate_reaper( here );
        CHECK( sub.events.empty() );
        CHECK( supplies() == 4 );
        CHECK( iexamine::get_seed_at( here, planting ) != nullptr );
        CHECK( here.furn( harvesting ) == furn_str_id::NULL_ID() );
        CHECK_FALSE( here.i_at( harvesting ).empty() );
        CHECK( get_globals().get_global_value( "test_planted" ).to_string() != "1" );
        CHECK( get_globals().get_global_value( "test_harvest_count" ).to_string().empty() );
    }
    SECTION( "client_replica_cannot_simulate_farming_or_advance_gameplay_rng" ) {
        cata_mp::set_client_mode( true );
        const auto random_before = rng_get_engine();
        machine->operate_planter( here );
        machine->operate_reaper( here );
        machine->on_move( here );
        CHECK( rng_get_engine() == random_before );
        CHECK( sub.events.empty() );
        CHECK( supplies() == 5 );
        CHECK( here.i_at( planting ).empty() );
        CHECK( here.furn( harvesting ) == furn_test_f_plant_harvest );
    }
}

TEST_CASE( "remote_reaper_collects_its_yield_without_using_the_operators_walking_reach",
           "[plant][vehicle][multiplayer][remote_control]" )
{
    clear_avatar();
    clear_map_without_vision();
    reset_test_globals();
    map &here = get_map();
    avatar &host = get_avatar();
    const tripoint_bub_ms origin = host.pos_bub() + tripoint::east * 12;
    vehicle *machine = here.add_vehicle( vproto_id( "autotractor" ), origin, 0_degrees, 100,
                                         veh_spawn_status::UNDAMAGED );
    REQUIRE( machine );
    npc &remote = spawn_npc( ( host.pos_bub() + tripoint::south ).xy(), "test_talker" );
    clear_character( remote, true );
    remote.setpos( here, host.pos_bub() + tripoint::south );
    item controller( itype_id( "remotevehcontrol" ) );
    controller.active = true;
    remote.i_add( controller );
    REQUIRE( set_remote_vehicle( remote, here, machine ) );
    REQUIRE( vehicle_operator( *machine, here ) == &remote );
    int reaper = -1;
    for( const vpart_reference &part : machine->get_all_parts() ) {
        if( part.has_feature( "REAPER" ) ) {
            part.part().enabled = true;
            reaper = part.part_index();
            break;
        }
    }
    REQUIRE( reaper >= 0 );
    const tripoint_bub_ms plot = machine->bub_part_pos( here, machine->part( reaper ) );
    REQUIRE( rl_dist( remote.pos_bub(), plot ) > 1 );
    item seed( itype_test_seed_eoc );
    seed.set_age( 4_hours );
    here.add_item( plot, seed );
    here.furn_set( plot, furn_test_f_plant_harvest );
    plant_event_subscriber sub;
    int committed = 0;
    sub.on_event = [&]( const cata::event & event ) {
        CHECK( event.get<character_id>( "character" ) == remote.getID() );
        for( const item &value : here.i_at( plot ) ) {
            committed += value.count();
        }
    };
    get_event_bus().subscribe( &sub );
    const on_out_of_scope cleanup( [&]() {
        get_event_bus().unsubscribe( &sub );
        clear_npcs();
    } );
    machine->operate_reaper( here );
    REQUIRE( sub.events.size() == 1 );
    CHECK( committed > 0 );
    int collected = 0;
    for( const item &value : machine->get_items( machine->part( reaper ) ) ) {
        collected += value.count();
    }
    CHECK( collected == committed );
    CHECK( here.i_at( plot ).empty() );
    CHECK( here.furn( plot ) == furn_str_id::NULL_ID() );
}

TEST_CASE( "wild_harvest_owns_its_worker_and_depletes_the_observed_plant_once",
           "[plant][harvest][multiplayer][save]" )
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    avatar &host = get_avatar();
    const time_point previous_time = calendar::turn;
    calendar::turn = calendar::turn_zero + 2 * calendar::season_length() + 12_hours;
    const tripoint_bub_ms tree = host.pos_bub() + tripoint::east;
    here.ter_set( tree, ter_str_id( "t_tree_apple" ) );
    npc &remote = spawn_npc( ( host.pos_bub() + tripoint::south ).xy(), "test_talker" );
    clear_character( remote, true );
    remote.setpos( here, host.pos_bub() + tripoint::south );
    remote.set_skill_level( skill_survival, 10 );
    remote.set_moves( 100 );
    host.set_moves( 100 );
    const on_out_of_scope cleanup( [&]() {
        host.activity.set_to_null();
        clear_npcs();
        calendar::turn = previous_time;
        cata_mp::set_client_mode( false );
    } );
    const auto command = capture_farming_command( remote, here, here.get_abs( tree ),
                         farming_action::gather );
    REQUIRE( execute_farming_command( remote, command ) );
    REQUIRE( execute_farming_command( host, command ) );
    REQUIRE( remote.activity.actor );
    REQUIRE( host.activity.actor );
    const auto yield_count = [&]() {
        int count = 0;
        const itype_id apple( "apple" );
        for( Character *who : {
                 static_cast<Character *>( &host ), static_cast<Character *>( &remote )
             } ) {
            for( const item *value : who->items_with( [&]( const item & candidate ) {
            return candidate.typeId() == apple;
            } ) ) {
                count += value->count();
            }
            for( const item &value : here.i_at( who->pos_bub() ) ) {
                if( value.typeId() == apple ) {
                    count += value.count();
                }
            }
        }
        return count;
    };
    SECTION( "the_second_worker_cannot_repeat_the_yield" ) {
        remote.activity.actor->finish( remote.activity, remote );
        CHECK_FALSE( remote.activity );
        const int harvested = yield_count();
        REQUIRE( harvested > 0 );
        const auto random_before = rng_get_engine();
        host.activity.actor->finish( host.activity, host );
        CHECK_FALSE( host.activity );
        CHECK( yield_count() == harvested );
        CHECK( rng_get_engine() == random_before );
    }
    SECTION( "a_saved_activity_rejects_another_operator_but_can_resume_for_its_owner" ) {
        std::ostringstream saved;
        JsonOut out( saved );
        remote.activity.serialize( out );
        player_activity restored;
        restored.deserialize( json_loader::from_string( saved.str() ).get_object() );
        REQUIRE( restored.actor );
        restored.actor->finish( restored, host );
        CHECK_FALSE( restored );
        CHECK( yield_count() == 0 );
        remote.activity.deserialize( json_loader::from_string( saved.str() ).get_object() );
        REQUIRE( remote.activity.actor );
        remote.activity.actor->finish( remote.activity, remote );
        CHECK( yield_count() > 0 );
    }
    SECTION( "changed_ground_cancels_before_rng_or_yield" ) {
        here.ter_set( tree, ter_t_dirt );
        const auto random_before = rng_get_engine();
        remote.activity.actor->finish( remote.activity, remote );
        CHECK_FALSE( remote.activity );
        CHECK( yield_count() == 0 );
        CHECK( rng_get_engine() == random_before );
        CHECK( here.ter( tree ) == ter_t_dirt );
    }
}

TEST_CASE( "foraging_duration_and_completion_are_authoritative_and_bound_to_the_bush",
           "[plant][forage][multiplayer][save]" )
{
    clear_avatar();
    clear_map_without_vision();
    avatar &host = get_avatar();
    map &here = get_map();
    npc &remote = spawn_npc( ( host.pos_bub() + tripoint::south ).xy(), "test_talker" );
    clear_character( remote, true );
    remote.setpos( here, host.pos_bub() + tripoint::south );
    remote.set_skill_level( skill_survival, 10 );
    remote.set_moves( 100 );
    const tripoint_bub_ms bush = host.pos_bub() + tripoint::east;
    here.ter_set( bush, ter_str_id( "t_underbrush" ) );
    const auto choice = capture_farming_command( remote, here, here.get_abs( bush ),
                        farming_action::forage );
    const on_out_of_scope cleanup( [&]() {
        cata_mp::set_client_mode( false );
        host.activity.set_to_null();
        clear_npcs();
    } );
    SECTION( "a_client_cannot_start_native_work_or_draw_its_duration" ) {
        cata_mp::set_client_mode( true );
        const auto random_before = rng_get_engine();
        CHECK_FALSE( execute_farming_command( remote, choice ) );
        remote.assign_activity( forage_activity_actor( here.get_abs( bush ) ) );
        CHECK_FALSE( remote.activity );
        CHECK( rng_get_engine() == random_before );
        CHECK( here.ter( bush ) == ter_str_id( "t_underbrush" ) );
    }
    SECTION( "saved_work_finishes_for_the_remote_player_once" ) {
        REQUIRE( execute_farming_command( remote, choice ) );
        REQUIRE( remote.activity.id() == activity_id( "ACT_FORAGE" ) );
        CHECK( remote.activity.execution() == activity_execution::authoritative );
        CHECK( remote.activity.moves_total > 0 );
        CHECK_FALSE( host.activity );
        std::ostringstream saved;
        JsonOut out( saved );
        remote.activity.serialize( out );
        remote.activity.deserialize( json_loader::from_string( saved.str() ).get_object() );
        REQUIRE( remote.activity.actor );
        remote.activity.actor->finish( remote.activity, remote );
        CHECK_FALSE( remote.activity );
        CHECK( here.ter( bush ) != ter_str_id( "t_underbrush" ) );
        const auto random_before = rng_get_engine();
        remote.activity.deserialize( json_loader::from_string( saved.str() ).get_object() );
        REQUIRE( remote.activity.actor );
        remote.activity.actor->finish( remote.activity, remote );
        CHECK_FALSE( remote.activity );
        CHECK( rng_get_engine() == random_before );
    }
    SECTION( "moving_away_cancels_before_completion" ) {
        REQUIRE( execute_farming_command( remote, choice ) );
        remote.setpos( here, remote.pos_bub() + tripoint::south * 3 );
        const auto random_before = rng_get_engine();
        remote.activity.actor->finish( remote.activity, remote );
        CHECK_FALSE( remote.activity );
        CHECK( here.ter( bush ) == ter_str_id( "t_underbrush" ) );
        CHECK( rng_get_engine() == random_before );
    }
}

TEST_CASE( "harvest_self_care_callbacks_cannot_erase_new_work_or_the_remaining_yield",
           "[plant][harvest][npc][ownership]" )
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    avatar &host = get_avatar();
    const time_point previous_time = calendar::turn;
    calendar::turn = calendar::turn_zero + 2 * calendar::season_length() + 12_hours;
    const tripoint_bub_ms origin = host.pos_bub() + tripoint::south;
    npc &worker = spawn_npc( origin.xy(), "test_talker" );
    clear_character( worker, true );
    worker.setpos( here, origin );
    worker.set_stored_kcal( 1000 );
    worker.set_hunger( 300 );
    worker.set_skill_level( skill_survival, 10 );
    worker.set_committed_goal( "eat_food" );
    const tripoint_bub_ms tree = origin + tripoint::east;
    here.ter_set( tree, ter_str_id( "t_tree_apple" ) );
    worker.assign_activity( harvest_activity_actor( tree ) );
    REQUIRE( worker.activity.actor );
    class observer : public event_subscriber
    {
        public:
            std::function<void( const cata::event & )> callback;
            void notify( const cata::event &event ) override {
                if( event.type() == event_type::character_consumes_item ) {
                    callback( event );
                }
            }
    } sub;
    int events = 0;
    int remaining_at_callback = 0;
    const character_id worker_id = worker.getID();
    const auto ground_yield = [&]() {
        int count = 0;
        for( const item &value : here.i_at( origin ) ) {
            count += value.count();
        }
        return count;
    };
    bool retire = false;
    SECTION( "replacement_activity_survives" ) {}
    SECTION( "retired_operator_leaves_unconsumed_products_on_the_map" ) {
        retire = true;
    }
    sub.callback = [&]( const cata::event & event ) {
        ++events;
        CHECK( event.get<character_id>( "character" ) == worker_id );
        CHECK( here.ter( tree ) != ter_str_id( "t_tree_apple" ) );
        remaining_at_callback = ground_yield();
        if( retire ) {
            g->remove_npc( worker_id );
        } else {
            worker.assign_activity( player_activity( activity_id( "ACT_WAIT" ), 321 ) );
        }
    };
    get_event_bus().subscribe( &sub );
    const on_out_of_scope cleanup( [&]() {
        get_event_bus().unsubscribe( &sub );
        clear_npcs();
        calendar::turn = previous_time;
    } );
    worker.activity.actor->finish( worker.activity, worker );
    REQUIRE( events == 1 );
    CHECK( ground_yield() == remaining_at_callback );
    if( !retire ) {
        CHECK( worker.activity.id() == activity_id( "ACT_WAIT" ) );
        CHECK( worker.activity.moves_left == 321 );
    }
}

TEST_CASE( "special_flower_choices_are_authoritative_and_deplete_only_once",
           "[plant][harvest][multiplayer]" )
{
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    const restore_on_out_of_scope restore_time( calendar::turn );
    calendar::turn = calendar::turn_zero + 12_hours;
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    avatar &host = get_avatar();
    npc &remote = spawn_npc( ( host.pos_bub() + tripoint::south ).xy(), "test_talker" );
    clear_character( remote, true );
    remote.setpos( here, host.pos_bub() + tripoint::south );
    remote.set_moves( 100 );
    host.set_moves( 100 );
    const on_out_of_scope cleanup( []() {
        cata_mp::set_client_mode( false );
        clear_npcs();
    } );
    const tripoint_bub_ms flower = remote.pos_bub() + tripoint::east;
    const furn_str_id dahlia( "f_dahlia" );
    here.furn_set( flower, dahlia );
    farming_command choice = capture_farming_command( remote, here, here.get_abs( flower ),
                             farming_action::flower );
    const auto yield = [&]( Character & who, const itype_id & type ) {
        int count = 0;
        for( const item *value : who.items_with( [&]( const item & candidate ) {
        return candidate.typeId() == type;
        } ) ) {
            count += value->count();
        }
        for( const item &value : here.i_at( who.pos_bub() ) ) {
            if( value.typeId() == type ) {
                count += value.count();
            }
        }
        return count;
    };
    SECTION( "client_cannot_run_native_harvest_or_advance_gameplay_rng" ) {
        cata_mp::set_client_mode( true );
        const auto random_before = rng_get_engine();
        CHECK_FALSE( execute_farming_command( remote, choice ) );
        CHECK( rng_get_engine() == random_before );
        CHECK( here.furn( flower ) == dahlia );
        CHECK( yield( remote, itype_id( "seed_dahlia" ) ) == 0 );
    }
    SECTION( "winter_and_forged_nectar_choices_are_rejected_without_rng" ) {
        calendar::turn = calendar::turn_zero + 3 * calendar::season_length() + 12_hours;
        REQUIRE( season_of_year( calendar::turn ) == WINTER );
        const auto random_before = rng_get_engine();
        CHECK_FALSE( execute_farming_command( remote, choice ) );
        calendar::turn = calendar::turn_zero + 12_hours;
        choice.drink = true;
        choice.pick = false;
        REQUIRE_FALSE( iexamine_helper::can_drink_nectar( remote ) );
        CHECK_FALSE( execute_farming_command( remote, choice ) );
        CHECK( rng_get_engine() == random_before );
        CHECK( here.furn( flower ) == dahlia );
    }
    SECTION( "changed_surface_rejects_an_old_choice" ) {
        here.furn_set( flower, furn_str_id( "f_mutpoppy" ) );
        const auto random_before = rng_get_engine();
        CHECK_FALSE( execute_farming_command( remote, choice ) );
        CHECK( rng_get_engine() == random_before );
        CHECK( here.furn( flower ) == furn_str_id( "f_mutpoppy" ) );
    }
    SECTION( "native_digging_capability_controls_roots_and_the_other_player_gets_nothing" ) {
        bool dig = false;
        SECTION( "without_digging" ) {}
        SECTION( "burrowing_can_collect_roots" ) {
            remote.set_mutation( trait_id( "BURROW" ) );
            dig = true;
        }
        REQUIRE( execute_farming_command( remote, choice ) );
        CHECK_FALSE( here.has_furn( flower ) );
        const int seeds = yield( remote, itype_id( "seed_dahlia" ) );
        REQUIRE( seeds > 0 );
        CHECK( ( yield( remote, itype_id( "dahlia_root" ) ) > 0 ) == dig );
        CHECK( yield( host, itype_id( "seed_dahlia" ) ) == 0 );
        const auto random_after = rng_get_engine();
        CHECK_FALSE( execute_farming_command( host, choice ) );
        CHECK_FALSE( execute_farming_command( remote, choice ) );
        CHECK( rng_get_engine() == random_after );
        CHECK( yield( remote, itype_id( "seed_dahlia" ) ) == seeds );
    }
}

TEST_CASE( "marloss_flower_commits_before_callbacks_and_keeps_remaining_output",
           "[plant][harvest][multiplayer][ownership]" )
{
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    avatar &host = get_avatar();
    const tripoint_bub_ms origin = host.pos_bub() + tripoint::south;
    npc &remote = spawn_npc( origin.xy(), "test_talker" );
    clear_character( remote, true );
    remote.setpos( here, origin );
    remote.set_moves( 100 );
    host.set_moves( 100 );
    const character_id remote_id = remote.getID();
    const tripoint_bub_ms flower = origin + tripoint::east;
    here.furn_set( flower, furn_str_id( "f_flower_marloss" ) );
    const auto choice = capture_farming_command( remote, here, here.get_abs( flower ),
                        farming_action::flower );
    const auto seeds = [&]() {
        int count = 0;
        for( const item &value : here.i_at( origin ) ) {
            if( value.typeId() == itype_marloss_seed ) {
                count += value.count();
            }
        }
        return count;
    };
    bool remove_operator = false;
    SECTION( "callback_replaces_activity_and_furniture" ) {}
    SECTION( "callback_removes_the_operator" ) {
        remove_operator = true;
    }
    plant_event_subscriber sub;
    sub.on_event = [&]( const cata::event & event ) {
        REQUIRE( sub.events.size() == 1 );
        CHECK( event.get<character_id>( "character" ) == remote_id );
        CHECK_FALSE( here.has_furn( flower ) );
        CHECK( seeds() == 3 );
        const auto random_before = rng_get_engine();
        CHECK_FALSE( execute_farming_command( remote, choice ) );
        CHECK_FALSE( execute_farming_command( host, choice ) );
        CHECK( rng_get_engine() == random_before );
        if( remove_operator ) {
            g->remove_npc( remote_id );
        } else {
            here.furn_set( flower, furn_str_id( "f_dahlia" ) );
            remote.assign_activity( player_activity( activity_id( "ACT_WAIT" ), 321 ) );
        }
    };
    get_event_bus().subscribe( &sub );
    const on_out_of_scope cleanup( [&]() {
        get_event_bus().unsubscribe( &sub );
        clear_npcs();
    } );
    CHECK( execute_farming_command( remote, choice ) );
    REQUIRE( sub.events.size() == 1 );
    CHECK( seeds() == 3 );
    CHECK( here.i_at( origin ).size() == 2 );
    CHECK_FALSE( host.activity );
    if( !remove_operator ) {
        CHECK( here.furn( flower ) == furn_str_id( "f_dahlia" ) );
        CHECK( remote.activity.id() == activity_id( "ACT_WAIT" ) );
        CHECK( remote.activity.moves_left == 321 );
    }
}

TEST_CASE( "special_tree_harvest_uses_native_traits_and_tools_of_the_operator",
           "[plant][harvest][multiplayer]" )
{
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    avatar &host = get_avatar();
    npc &remote = spawn_npc( ( host.pos_bub() + tripoint::south ).xy(), "test_talker" );
    clear_character( remote, true );
    remote.setpos( here, host.pos_bub() + tripoint::south );
    remote.set_moves( 100 );
    const on_out_of_scope cleanup( []() {
        clear_npcs();
    } );
    const tripoint_bub_ms tree = remote.pos_bub() + tripoint::east;
    SECTION( "marloss_offering_depends_on_remote_traits_not_host_traits" ) {
        here.ter_set( tree, ter_str_id( "t_marloss" ) );
        host.set_mutation( trait_id( "THRESH_MYCUS" ) );
        remote.set_mutation( trait_id( "THRESH_MARLOSS" ) );
        const auto choice = capture_farming_command( remote, here, here.get_abs( tree ),
                            farming_action::marloss );
        REQUIRE( execute_farming_command( remote, choice ) );
        CHECK( here.ter( tree ) == ter_str_id( "t_fungus" ) );
        REQUIRE( here.i_at( remote.pos_bub() ).size() == 1 );
        CHECK( here.i_at( remote.pos_bub() ).begin()->typeId() == itype_id( "mycus_fruit" ) );
        CHECK( here.i_at( host.pos_bub() ).empty() );
        const auto random_after = rng_get_engine();
        CHECK_FALSE( execute_farming_command( remote, choice ) );
        CHECK( rng_get_engine() == random_after );
    }
    SECTION( "hickory_roots_require_an_actual_tool_and_spend_the_native_time_once" ) {
        here.ter_set( tree, ter_str_id( "t_tree_hickory" ) );
        remote.set_skill_level( skill_survival, 3 );
        const auto choice = capture_farming_command( remote, here, here.get_abs( tree ),
                            farming_action::hickory_roots );
        const auto random_before = rng_get_engine();
        CHECK_FALSE( execute_farming_command( remote, choice ) );
        CHECK( rng_get_engine() == random_before );
        remote.wield( remote.i_add( item( itype_id( "shovel" ) ) ) );
        REQUIRE( remote.has_quality( quality_id( "DIG" ) ) );
        remote.set_moves( 1000 );
        REQUIRE( execute_farming_command( remote, choice ) );
        CHECK( remote.get_moves() == 1000 - to_moves<int>( 20_seconds ) / 4 + 100 );
        CHECK( here.ter( tree ) == ter_str_id( "t_tree_hickory_dead" ) );
        CHECK_FALSE( remote.activity );
        const auto random_after = rng_get_engine();
        const auto repeated = capture_farming_command( remote, here, here.get_abs( tree ),
                              farming_action::hickory_roots );
        CHECK_FALSE( execute_farming_command( remote, repeated ) );
        CHECK( rng_get_engine() == random_after );
        CHECK( here.i_at( host.pos_bub() ).empty() );
    }
}

TEST_CASE( "plant_damage_events_can_remove_the_victim_or_start_replacement_work",
           "[plant][damage][ownership]" )
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    avatar &host = get_avatar();
    npc &worker = spawn_npc( ( host.pos_bub() + tripoint::south ).xy(), "test_talker" );
    clear_character( worker, true );
    worker.setpos( here, host.pos_bub() + tripoint::south );
    const character_id worker_id = worker.getID();
    const auto reference = g->npc_lifetimes().track_active( worker );
    const bodypart_id leg( "leg_l" );
    const int host_hp = host.get_part_hp_cur( leg );
    const int worker_hp = worker.get_part_hp_cur( leg );
    worker.add_effect( efftype_id( "sleep" ), 2_hours );
    bool remove_worker = false;
    SECTION( "removed_character_is_not_used_after_the_damage_callback" ) {
        remove_worker = true;
    }
    SECTION( "new_activity_is_not_cancelled_by_the_old_damage_operation" ) {}
    class observer : public event_subscriber
    {
        public:
            std::function<void()> callback;
            int wakes = 0;
            void notify( const cata::event &event ) override {
                if( event.type() == event_type::character_takes_damage ) {
                    callback();
                } else if( event.type() == event_type::character_wakes_up ) {
                    ++wakes;
                }
            }
    } sub;
    int calls = 0;
    sub.callback = [&]() {
        ++calls;
        CHECK( worker.get_part_hp_cur( leg ) == worker_hp - 4 );
        if( remove_worker ) {
            g->remove_npc( worker_id );
        } else {
            worker.assign_activity( player_activity( activity_id( "ACT_WAIT" ), 321 ) );
        }
    };
    get_event_bus().subscribe( &sub );
    const on_out_of_scope cleanup( [&]() {
        get_event_bus().unsubscribe( &sub );
        clear_npcs();
    } );
    worker.apply_damage( nullptr, leg, 4 );
    CHECK( calls == 1 );
    CHECK( sub.wakes == 0 );
    CHECK( host.get_part_hp_cur( leg ) == host_hp );
    if( remove_worker ) {
        CHECK( reference.resolve( g->npc_lifetimes() ) == nullptr );
    } else {
        CHECK( worker.activity.id() == activity_id( "ACT_WAIT" ) );
        CHECK( worker.activity.moves_left == 321 );
    }
}


TEST_CASE( "maple_tapping_uses_owned_supplies_and_removes_only_installed_items",
           "[plant][maple][multiplayer]" )
{
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    avatar &host = get_avatar();
    const tripoint_bub_ms origin = host.pos_bub() + tripoint::south;
    npc &remote = spawn_npc( origin.xy(), "test_talker" );
    clear_character( remote, true );
    remote.setpos( here, origin );
    const on_out_of_scope cleanup( []() {
        clear_npcs();
    } );
    const tripoint_bub_ms tree = origin + tripoint::east;
    here.ter_set( tree, ter_str_id( "t_tree_maple" ) );
    host.i_add( item( itype_id( "hand_drill" ) ) );
    host.i_add( item( itype_id( "hammer" ) ) );
    item_location tap = remote.i_add( item( itype_id( "tree_spile" ) ) );
    item &bottle = here.add_item_unprocessed( origin, item( itype_id( "bottle_plastic" ) ) );
    item_location container( map_cursor( origin ), &bottle );
    auto choice = capture_farming_command( remote, here, here.get_abs( tree ),
                                           farming_action::maple_tap );
    choice.tap = capture_item_source( remote, tap );
    choice.container = capture_item_source( remote, container );
    remote.set_moves( 10000 );
    host.set_moves( 10000 );
    const auto random_before = rng_get_engine();
    CHECK_FALSE( execute_farming_command( host, choice ) );
    CHECK_FALSE( execute_farming_command( remote, choice ) );
    CHECK( rng_get_engine() == random_before );
    REQUIRE( tap );
    REQUIRE( container );
    CHECK( remote.get_moves() == 10000 );
    remote.i_add( item( itype_id( "hand_drill" ) ) );
    remote.i_add( item( itype_id( "hammer" ) ) );
    REQUIRE( execute_farming_command( remote, choice ) );
    CHECK( remote.get_moves() == 10000 - to_moves<int>( 20_seconds ) );
    CHECK( host.get_moves() == 10000 );
    CHECK_FALSE( tap );
    CHECK_FALSE( container );
    const auto installed = inspect_maple_tree( here, here.get_abs( tree ) );
    REQUIRE( installed.tap );
    REQUIRE( installed.container );
    CHECK( here.ter( tree ) == ter_str_id( "t_tree_maple_tapped" ) );
    CHECK_FALSE( execute_farming_command( remote, choice ) );

    item &unrelated = here.add_item_unprocessed( tree, item( itype_id( "rock" ) ) );
    const item_location unrelated_location( map_cursor( tree ), &unrelated );
    auto remove = capture_farming_command( remote, here, here.get_abs( tree ),
                                           farming_action::maple_untap );
    remove.tap = capture_item_source( remote, installed.tap );
    remove.container = capture_item_source( remote, installed.container );
    REQUIRE( execute_farming_command( remote, remove ) );
    CHECK( here.ter( tree ) == ter_str_id( "t_tree_maple" ) );
    CHECK( remote.get_moves() == 10000 - to_moves<int>( 40_seconds ) );
    REQUIRE( unrelated_location );
    CHECK( unrelated_location.pos_bub( here ) == tree );
    REQUIRE( here.i_at( tree ).size() == 1 );
    const auto removed = inspect_maple_tree( here, here.get_abs( origin ) );
    REQUIRE( removed.tap );
    REQUIRE( removed.container );
    CHECK_FALSE( execute_farming_command( remote, remove ) );
}

TEST_CASE( "maple_container_choices_preserve_partial_sap_and_reject_stale_items",
           "[plant][maple][multiplayer]" )
{
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    avatar &host = get_avatar();
    const tripoint_bub_ms origin = host.pos_bub() + tripoint::south;
    npc &remote = spawn_npc( origin.xy(), "test_talker" );
    clear_character( remote, true );
    remote.setpos( here, origin );
    remote.set_moves( 10000 );
    host.set_moves( 10000 );
    const on_out_of_scope cleanup( []() {
        clear_npcs();
    } );
    const tripoint_bub_ms tree = origin + tripoint::east;
    here.ter_set( tree, ter_str_id( "t_tree_maple_tapped" ) );
    here.add_item_unprocessed( tree, item( itype_id( "tree_spile" ) ) );
    item bottle( itype_id( "bottle_plastic" ) );
    item sap( itype_id( "maple_sap" ), calendar::turn, 2 );
    REQUIRE( bottle.fill_with( sap, 2, true ) == 2 );
    here.add_item_unprocessed( tree, bottle );
    const auto installed = inspect_maple_tree( here, here.get_abs( tree ) );
    REQUIRE( installed.tap );
    REQUIRE( installed.container );
    REQUIRE( installed.sap );
    auto choice = capture_farming_command( remote, here, here.get_abs( tree ),
                                           farming_action::maple_sap );
    choice.tap = capture_item_source( remote, installed.tap );
    choice.container = capture_item_source( remote, installed.container );
    item destination( itype_id( "bottle_plastic" ) );
    REQUIRE( destination.fill_with( sap, 1, true ) == 1 );
    item_location receiver = remote.i_add( destination );
    unload_liquid_choice liquid;
    liquid.source = installed.sap->uid().get_value();
    liquid.kind = LD_ITEM;
    liquid.container = capture_item_source( remote, receiver );
    choice.sap_destination = liquid;

    SECTION( "partial_transfer_leaves_unmoved_sap_and_cannot_repeat_old_identity" ) {
        REQUIRE( execute_farming_command( remote, choice ) );
        const auto remaining = inspect_maple_tree( here, here.get_abs( tree ) );
        REQUIRE( remaining.sap );
        CHECK( remaining.sap->charges == 1 );
        CHECK( receiver->charges_of( itype_id( "maple_sap" ) ) == 2 );
        CHECK( remote.get_moves() == 9900 );
        CHECK( host.get_moves() == 10000 );
        CHECK_FALSE( execute_farming_command( remote, choice ) );
        CHECK( remaining.sap->charges == 1 );
    }
    SECTION( "another_characters_container_is_not_a_valid_receiver" ) {
        item_location other = host.i_add( destination );
        choice.sap_destination->container = capture_item_source( host, other );
        CHECK_FALSE( execute_farming_command( remote, choice ) );
        CHECK( installed.sap->charges == 2 );
        CHECK( other->charges_of( itype_id( "maple_sap" ) ) == 1 );
        CHECK( remote.get_moves() == 10000 );
    }
    SECTION( "replacing_the_collecting_container_invalidates_an_old_remove_choice" ) {
        choice.action = farming_action::maple_remove_container;
        choice.sap_destination.reset();
        item_location replaced = installed.container;
        replaced.remove_item();
        here.add_item_unprocessed( tree, bottle );
        CHECK_FALSE( execute_farming_command( remote, choice ) );
        const auto replacement = inspect_maple_tree( here, here.get_abs( tree ) );
        REQUIRE( replacement.sap );
        CHECK( replacement.sap->charges == 2 );
        CHECK( remote.get_moves() == 10000 );
    }
    SECTION( "client_never_executes_transfer_locally" ) {
        const auto before = rng_get_engine();
        const bool previous_mode = cata_mp::is_client_mode();
        const on_out_of_scope restore_mode( [previous_mode]() {
            cata_mp::set_client_mode( previous_mode );
        } );
        cata_mp::set_client_mode( true );
        CHECK_FALSE( execute_farming_command( remote, choice ) );
        CHECK( installed.sap->charges == 2 );
        CHECK( rng_get_engine() == before );
        CHECK( remote.get_moves() == 10000 );
    }
}
