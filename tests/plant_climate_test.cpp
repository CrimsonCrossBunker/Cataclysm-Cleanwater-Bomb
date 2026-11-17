#include <clone_ptr.h>
#include <coordinates.h>
#include <dialogue_helpers.h>
#include <overmap_ui.h>
#include <point.h>
#include <ret_val.h>
#include <value_ptr.h>
#include <algorithm>
#include <array>
#include <cmath>
#include <functional>
#include <memory>
#include <optional>
#include <sstream>
#include <string>
#include <vector>

#include "activity_actor.h"
#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "dialogue.h"
#include "effect_on_condition.h"
#include "flexbuffer_json.h"
#include "game.h"
#include "iexamine.h"
#include "item.h"
#include "itype.h"
#include "json.h"
#include "json_loader.h"
#include "map.h"
#include "map_helpers.h"
#include "mapdata.h"
#include "options_helpers.h"
#include "plant_climate.h"
#include "player_activity.h"
#include "player_helpers.h"
#include "pocket_type.h"
#include "type_id.h"
#include "units.h"
#include "weather.h"
#include "weather_gen.h"
#include "weather_type.h"

static const activity_id activity_ACT_WAIT( "ACT_WAIT" );
static const effect_on_condition_id
effect_on_condition_EOC_TEST_PLANT_GROW( "EOC_TEST_PLANT_GROW" );
static const furn_str_id furn_f_plant_harvest( "f_plant_harvest" );
static const furn_str_id furn_f_plant_seed( "f_plant_seed" );
static const furn_str_id furn_f_plant_seedling( "f_plant_seedling" );
static const furn_str_id furn_f_planter_seed( "f_planter_seed" );
static const furn_str_id furn_f_planter_seedling( "f_planter_seedling" );
static const itype_id itype_bottle_plastic( "bottle_plastic" );
static const itype_id itype_fertilizer_commercial( "fertilizer_commercial" );
static const itype_id itype_seed_corn( "seed_corn" );
static const itype_id itype_seed_potato_raw( "seed_potato_raw" );
static const itype_id itype_seed_red_winter_wheat( "seed_red_winter_wheat" );
static const itype_id itype_water_clean( "water_clean" );
static const ter_str_id ter_t_atlas_soil_gravelly( "t_atlas_soil_gravelly" );
static const ter_str_id ter_t_dirt( "t_dirt" );
static const ter_str_id ter_t_flat_roof( "t_flat_roof" );
static const weather_type_id weather_rain( "rain" );

namespace
{
struct crop_water_fixture {
    restore_on_out_of_scope<time_point> restore_time{ calendar::turn };
    restore_on_out_of_scope<std::optional<units::temperature>> restore_temperature{
        get_weather().forced_temperature
    };
    override_option normal_weather{ "ETERNAL_WEATHER", "normal" };
    override_option water_use{ "CROP_WATER_CONSUMPTION", "1.0" };
    override_option growth_speed{ "CROP_GROWTH_SPEED", "1.0" };
    map &here = get_map();
    tripoint_bub_ms plot;

    crop_water_fixture() {
        clear_avatar();
        clear_map_without_vision();
        calendar::turn = calendar::turn_zero;
        get_weather().forced_temperature = units::from_celsius( 24 );
        get_weather().clear_temp_cache();
        clear_plant_climate_cache();
        plot = get_avatar().pos_bub() + tripoint::east;
        here.ter_set( plot, ter_t_dirt );
        here.furn_set( plot, furn_f_plant_seed );
        here.add_item( plot, item( itype_seed_corn, calendar::turn ) );
        iexamine::set_plant_water( seed(), 0 );
        iexamine::set_plant_effective_growth_turns( seed(), 0 );
        iexamine::set_plant_last_water_check( seed(), calendar::turn );
        seed().set_var( "crop_soil_moisture_mm", 0.0 );
    }

    ~crop_water_fixture() {
        get_weather().clear_temp_cache();
        clear_plant_climate_cache();
    }

    item &seed() {
        return *iexamine::get_seed_at( here, plot );
    }

    crop_water_status status() {
        return get_crop_water_status( here, plot, seed() );
    }

    double growth() {
        return iexamine::get_plant_effective_growth_turns( seed() ) +
               seed().get_var( "crop_growth_fraction", 0.0 );
    }
};
} // namespace

TEST_CASE( "crop_rain_recharges_soil_before_irrigation", "[farming][weather][water]" )
{
    crop_water_fixture crop;
    scoped_weather_override rain( weather_rain );
    REQUIRE_FALSE( crop.here.is_roofed( crop.plot ) );
    iexamine::set_plant_water( crop.seed(), 80 );

    SECTION( "outdoor_field" ) {
        calendar::turn += 1_days;
        crop.here.grow_plant( crop.plot );
        CHECK( crop.status().soil_moisture_mm > 0 );
        CHECK( crop.status().irrigation_mm == Approx( 20 ) );
        CHECK( crop.growth() > 0 );
    }

    SECTION( "roof_blocks_rain" ) {
        crop.here.ter_set( crop.plot + tripoint::above, ter_t_flat_roof );
        REQUIRE( crop.here.is_roofed( crop.plot ) );
        calendar::turn += 1_days;
        crop.here.grow_plant( crop.plot );
        CHECK( crop.status().soil_moisture_mm == 0 );
        CHECK( crop.status().irrigation_mm < 20 );
    }

    SECTION( "frozen_precipitation_is_not_liquid_water" ) {
        get_weather().forced_temperature = units::from_celsius( -5 );
        get_weather().clear_temp_cache();
        calendar::turn += 1_days;
        crop.here.grow_plant( crop.plot );
        CHECK( crop.status().soil_moisture_mm == 0 );
        CHECK( crop.growth() == 0 );
    }
}

TEST_CASE( "crop_query_cadence_does_not_change_hourly_water_or_growth",
           "[farming][weather][water]" )
{
    crop_water_fixture crop;
    scoped_weather_override rain( weather_rain );
    const item initial = crop.seed();
    const furn_id initial_furniture = crop.here.furn( crop.plot );
    const time_point start = calendar::turn;

    for( int query = 1; query <= 3 * 24 * 12; ++query ) {
        calendar::turn = start + query * 5_minutes;
        crop.here.grow_plant( crop.plot );
    }
    const double frequent_growth = crop.growth();
    const crop_water_status frequent_water = crop.status();

    crop.seed() = initial;
    crop.here.furn_set( crop.plot, initial_furniture );
    crop.here.grow_plant( crop.plot );
    CHECK( crop.growth() == Approx( frequent_growth ) );
    CHECK( crop.status().soil_moisture_mm == Approx( frequent_water.soil_moisture_mm ) );
    CHECK( crop.status().irrigation_mm == Approx( frequent_water.irrigation_mm ) );
}

TEST_CASE( "crop_subhour_queries_do_not_settle_pending_time", "[farming][water]" )
{
    crop_water_fixture crop;
    scoped_weather_override dry( WEATHER_CLEAR );
    iexamine::set_plant_water( crop.seed(), 100 );
    calendar::turn += 59_minutes;
    crop.here.grow_plant( crop.plot );
    CHECK( crop.growth() == 0 );
    CHECK( crop.status().irrigation_mm == Approx( 25 ) );
    CHECK( iexamine::get_plant_last_water_check( crop.seed() ) == calendar::turn_zero );

    calendar::turn += 1_minutes;
    crop.here.grow_plant( crop.plot );
    CHECK( crop.growth() > 0 );
    CHECK( crop.status().irrigation_mm < 25 );
    CHECK( iexamine::get_plant_last_water_check( crop.seed() ) == calendar::turn );
}

TEST_CASE( "crop_accounts_for_each_hour_of_a_regional_rain_event", "[farming][weather][water]" )
{
    crop_water_fixture crop;
    scoped_weather_override natural( WEATHER_NULL );
    const unsigned int original_seed = g->get_seed();
    const on_out_of_scope restore_seed( [original_seed]() {
        g->set_seed( original_seed );
    } );
    g->set_seed( 713 );
    const weather_generator &generator = get_weather().get_cur_weather_gen();
    const tripoint_abs_omt cell = snow_climate_cell( project_to<coords::omt>( crop.here.get_abs(
                                      crop.plot ) ) );
    const tripoint_abs_ms location = project_to<coords::ms>( cell ) + point( 384, 384 );
    const auto normals = generator.climate_at( location );
    REQUIRE( normals );
    std::array<double, 24> rain{};
    bool found_short_event = false;
    for( int day = 150; day < 240 && !found_short_event; ++day ) {
        calendar::turn = calendar::turn_zero + day * 1_days;
        double hourly_total = 0;
        double old_sample_total = 0;
        for( int hour = 0; hour < 24; ++hour ) {
            const w_point sample = generator.get_weather( location, calendar::turn + hour * 1_hours,
                                   g->get_seed(), false, &normals );
            const weather_type_id type = generator.get_weather_conditions( sample );
            rain[hour] = type->rains ? regional_precipitation_rate( type, sample ).value_or(
                             precip_mm_per_hour( type->precip ) ) : 0;
            hourly_total += rain[hour];
            if( hour % 6 == 3 ) {
                old_sample_total += 6 * rain[hour];
            }
        }
        found_short_event = hourly_total > 0 &&
                            std::abs( hourly_total - old_sample_total ) > 0.01;
    }
    REQUIRE( found_short_event );
    iexamine::set_plant_last_water_check( crop.seed(), calendar::turn );
    double expected_moisture = 0;
    for( int hour = 0; hour < 24; ++hour ) {
        const crop_water_status before = crop.status();
        expected_moisture = std::max( 0.0,
                                      std::min( before.soil_capacity_mm, expected_moisture + rain[hour] ) -
                                      before.daily_need_mm / 24 );
        calendar::turn += 1_hours;
        crop.here.grow_plant( crop.plot );
        CAPTURE( hour, rain[hour] );
        CHECK( crop.status().soil_moisture_mm == Approx( expected_moisture ).margin( 0.0001 ) );
    }
}

TEST_CASE( "crop_fractional_progress_and_irrigation_survive_serialization", "[farming][water]" )
{
    crop_water_fixture crop;
    scoped_weather_override dry( WEATHER_CLEAR );
    iexamine::set_plant_water( crop.seed(), 100 );
    calendar::turn += 1_seconds;
    crop.here.grow_plant( crop.plot, &get_avatar(), true );
    REQUIRE( crop.seed().get_var( "crop_growth_fraction", 0.0 ) > 0 );
    REQUIRE( crop.seed().get_var( "crop_irrigation_fraction", 0.0 ) > 0 );
    const double growth = crop.growth();
    const double water = crop.status().irrigation_mm;
    std::ostringstream saved;
    JsonOut output( saved );
    crop.seed().serialize( output );
    item restored;
    restored.deserialize( json_loader::from_string( saved.str() ).get_object() );
    crop.seed() = restored;
    CHECK( crop.growth() == Approx( growth ) );
    CHECK( crop.status().irrigation_mm == Approx( water ) );
    calendar::turn += 1_seconds;
    crop.here.grow_plant( crop.plot, &get_avatar(), true );
    CHECK( crop.growth() > growth );
    CHECK( crop.status().irrigation_mm < water );
}

TEST_CASE( "crop_soil_capacity_uses_terrain_but_planters_use_substrate", "[farming][water]" )
{
    crop_water_fixture crop;
    const double loam_capacity = crop.status().soil_capacity_mm;
    crop.here.ter_set( crop.plot, ter_t_atlas_soil_gravelly );
    CHECK( crop.status().soil_capacity_mm == Approx( loam_capacity * 0.51 ) );
    crop.here.furn_set( crop.plot, furn_f_planter_seed );
    CHECK( crop.status().soil_capacity_mm == Approx( loam_capacity ) );
    crop.here.furn_set( crop.plot, furn_f_planter_seedling );
    CHECK( crop.status().soil_capacity_mm == Approx( loam_capacity ) );

    SECTION( "consumption_does_not_scale_capacity" ) {
        override_option thirsty( "CROP_WATER_CONSUMPTION", "2.0" );
        CHECK( crop.status().soil_capacity_mm == Approx( loam_capacity ) );
    }

    SECTION( "season_length_does_not_scale_capacity" ) {
        const int original_days = to_days<int>( calendar::season_length() );
        const on_out_of_scope restore_season( [original_days]() {
            calendar::set_season_length( original_days );
        } );
        calendar::set_season_length( original_days * 2 );
        CHECK( crop.status().soil_capacity_mm == Approx( loam_capacity ) );
    }

    SECTION( "stage_can_explicitly_use_terrain" ) {
        plant_data &stage = *furn_f_planter_seedling->plant;
        const restore_on_out_of_scope restore_source( stage.soil_source );
        stage.soil_source = "terrain";
        CHECK( crop.status().soil_capacity_mm == Approx( loam_capacity * 0.51 ) );
    }

    SECTION( "cyclic_base_chain_falls_back_to_terrain" ) {
        plant_data &stage = *furn_f_planter_seedling->plant;
        const restore_on_out_of_scope restore_base( stage.base );
        stage.base = furn_f_planter_seedling;
        CHECK( crop.status().soil_capacity_mm == Approx( loam_capacity * 0.51 ) );
    }
}

TEST_CASE( "crop_rainfed_growth_matches_a_watered_control_through_stage_changes",
           "[farming][weather][water]" )
{
    crop_water_fixture crop;
    scoped_weather_override rain( weather_rain );
    override_option no_overgrowth( "CROP_OVERGROWN_ENABLED", "false" );
    const item initial = crop.seed();
    const time_point start = calendar::turn;
    for( int day = 1; day <= 100; ++day ) {
        calendar::turn = start + day * 1_days;
        iexamine::set_plant_water( crop.seed(), 100 );
        crop.here.grow_plant( crop.plot );
    }
    const double watered_growth = crop.growth();
    const furn_id watered_furniture = crop.here.furn( crop.plot );
    REQUIRE( watered_furniture == furn_f_plant_harvest );

    crop.seed() = initial;
    crop.here.furn_set( crop.plot, furn_f_plant_seed );
    crop.here.grow_plant( crop.plot );
    CHECK( crop.here.furn( crop.plot ) == watered_furniture );
    CHECK( crop.growth() == Approx( watered_growth ) );
    CHECK( iexamine::get_plant_water( crop.seed() ) == 0 );
}

TEST_CASE( "crop_watering_is_not_retroactive_and_automation_checks_total_water",
           "[farming][water]" )
{
    crop_water_fixture crop;
    scoped_weather_override dry( WEATHER_CLEAR );
    item bottle( itype_bottle_plastic );
    REQUIRE( bottle.put_in( item( itype_water_clean, calendar::turn, 2 ),
                            pocket_type::CONTAINER ).success() );
    get_avatar().i_add( bottle );

    SECTION( "manual_watering_settles_elapsed_drought" ) {
        calendar::turn += 2_days + 30_minutes;
        iexamine::water_plant( get_avatar(), crop.plot );
        CHECK( crop.growth() == 0 );
        CHECK( crop.status().irrigation_mm == Approx( 12.5 ) );
        CHECK( iexamine::get_plant_last_water_check( crop.seed() ) == calendar::turn );
        calendar::turn += 1_hours;
        crop.here.grow_plant( crop.plot );
        CHECK( crop.growth() > 0 );
    }

    SECTION( "automatic_watering_counts_soil_and_reserve" ) {
        CHECK( iexamine::plant_needs_water( get_avatar(), crop.plot ) );
        const double daily_need = crop.status().daily_need_mm;
        crop.seed().set_var( "crop_soil_moisture_mm", daily_need );
        CHECK( iexamine::can_water_plant( get_avatar(), crop.plot ) );
        CHECK_FALSE( iexamine::plant_needs_water( get_avatar(), crop.plot ) );
        crop.seed().set_var( "crop_soil_moisture_mm", 0.0 );
        iexamine::set_plant_water( crop.seed(), 50 );
        CHECK_FALSE( iexamine::plant_needs_water( get_avatar(), crop.plot ) );
    }
}

TEST_CASE( "crop_fertilizing_settles_the_pending_partial_hour", "[farming][water][fertilize]" )
{
    crop_water_fixture crop;
    scoped_weather_override dry( WEATHER_CLEAR );
    crop.here.furn_set( crop.plot, furn_f_plant_seedling );
    iexamine::set_plant_effective_growth_turns( crop.seed(), to_turns<int>( 20_days ) );
    get_avatar().i_add( item( itype_fertilizer_commercial, calendar::turn ) );
    calendar::turn += 2_days + 30_minutes;
    iexamine::fertilize_plant( get_avatar(), crop.plot, itype_fertilizer_commercial );
    process_activity( get_avatar() );
    CHECK( iexamine::is_plant_fertilized( crop.seed() ) );
    CHECK( iexamine::get_plant_last_water_check( crop.seed() ) == calendar::turn );
    CHECK( crop.status().soil_moisture_mm == 0 );
    CHECK( crop.growth() == Approx( to_turns<double>( 24_days ) ) );
}

TEST_CASE( "crop_growth_callbacks_revalidate_watering_and_fertilizing_reach",
           "[farming][water][fertilize][activity]" )
{
    crop_water_fixture crop;
    scoped_weather_override dry( WEATHER_CLEAR );
    avatar &who = get_avatar();
    const bool fertilizing = GENERATE( false, true );
    const int callback_result = GENERATE( 0, 1, 2 );
    CAPTURE( fertilizing, callback_result );
    const bool out_of_reach = callback_result != 0;
    const bool replace_activity = callback_result == 2;
    const tripoint_bub_ms destination = crop.plot +
                                        ( out_of_reach ? tripoint::south * 3 : tripoint::north );
    const on_out_of_scope clear_activity( [&who]() {
        who.activity.set_to_null();
    } );
    const time_duration seedling = iexamine::get_plant_stage_threshold( *crop.seed().type->seed, 1 );
    iexamine::set_plant_effective_growth_turns( crop.seed(), to_turns<int>( seedling - 1_seconds ) );
    crop.seed().set_var( "crop_soil_moisture_mm", 10.0 );

    effect_on_condition &hook = const_cast<effect_on_condition &>
                                ( effect_on_condition_EOC_TEST_PLANT_GROW.obj() );
    const restore_on_out_of_scope restore_effect( hook.true_effect );
    auto &growth_hooks = furn_f_plant_seedling->plant->eoc_on_grow;
    const restore_on_out_of_scope restore_hooks( growth_hooks );
    growth_hooks = { effect_on_condition_EOC_TEST_PLANT_GROW };
    int callbacks = 0;
    hook.true_effect.effects.clear();
    hook.true_effect.effects.emplace_back( [&who, &crop, &callbacks, destination,
          replace_activity]( dialogue & ) {
        ++callbacks;
        who.setpos( crop.here, destination );
        if( replace_activity ) {
            who.assign_activity( player_activity( activity_ACT_WAIT, 321 ) );
        }
    } );

    if( fertilizing ) {
        item material( itype_fertilizer_commercial, calendar::turn );
        material.charges = 2;
        who.i_add( material );
    } else {
        item bottle( itype_bottle_plastic );
        REQUIRE( bottle.put_in( item( itype_water_clean, calendar::turn, 2 ),
                                pocket_type::CONTAINER ).success() );
        who.i_add( bottle );
    }
    REQUIRE( who.charges_of( fertilizing ? itype_fertilizer_commercial : itype_water_clean ) == 2 );
    const int water_before = who.charges_of( itype_water_clean );
    const int fertilizer_before = who.charges_of( itype_fertilizer_commercial );
    if( fertilizing ) {
        iexamine::fertilize_plant( who, crop.plot, itype_fertilizer_commercial );
        REQUIRE( who.activity.actor );
    }
    REQUIRE( callbacks == 0 );
    calendar::turn += 30_minutes;
    if( fertilizing ) {
        who.activity.actor->finish( who.activity, who );
    } else {
        iexamine::water_plant( who, crop.plot );
    }

    REQUIRE( callbacks == 1 );
    CHECK( who.pos_bub() == destination );
    CHECK( crop.here.furn( crop.plot ) == furn_f_plant_seedling );
    CHECK( iexamine::get_plant_last_water_check( crop.seed() ) == calendar::turn );
    CHECK( who.charges_of( itype_water_clean ) == water_before - ( !fertilizing &&
            !out_of_reach ? 1 : 0 ) );
    CHECK( who.charges_of( itype_fertilizer_commercial ) ==
           fertilizer_before - ( fertilizing && !out_of_reach ? 1 : 0 ) );
    CHECK( iexamine::get_plant_water( crop.seed() ) == ( !fertilizing && !out_of_reach ? 50 : 0 ) );
    CHECK( iexamine::is_plant_fertilized( crop.seed() ) == ( fertilizing && !out_of_reach ) );
    if( replace_activity ) {
        CHECK( who.activity.id() == activity_ACT_WAIT );
        CHECK( who.activity.moves_left == 321 );
    } else {
        CHECK_FALSE( who.activity );
    }
}

TEST_CASE( "crop_existing_stage_and_missing_timestamp_are_preserved", "[farming][water]" )
{
    crop_water_fixture crop;
    scoped_weather_override dry( WEATHER_CLEAR );
    crop.here.furn_set( crop.plot, furn_f_plant_seedling );
    crop.seed().erase_var( "seed_last_water_check" );
    calendar::turn += 3_hours;
    crop.here.grow_plant( crop.plot );
    CHECK( crop.growth() == Approx( to_turns<double>( 20_days ) ) );
    CHECK( crop.here.furn( crop.plot ) == furn_f_plant_seedling );
    CHECK( iexamine::get_plant_last_water_check( crop.seed() ) == calendar::turn );
    const double moisture = crop.status().soil_moisture_mm;
    crop.here.grow_plant( crop.plot );
    CHECK( crop.growth() == Approx( to_turns<double>( 20_days ) ) );
    CHECK( crop.status().soil_moisture_mm == Approx( moisture ) );
}

TEST_CASE( "crop_soil_source_rejects_unknown_values", "[farming][json]" )
{
    plant_data plant;
    const JsonObject definition = json_loader::from_string(
                                      R"({ "plant_data": { "soil_source": "unknown" } })" ).get_object();
    CHECK_THROWS_AS( plant.load( definition, "plant_data", "test_data" ), JsonError );
}

TEST_CASE( "crop_heat_units_account_for_cold_and_heat_stress", "[farming][weather]" )
{
    const crop_climate_profile tomato{ 10, 26, 0, 38, 690, 510, 88, 0.68 };
    const crop_climate_profile pea{ 4.4, 19, -4, 29, 480, 320, 63, 0.7 };

    CHECK( tomato.heat_units( 14, 24 ) == Approx( 9 ) );
    CHECK( tomato.heat_units( 7, 11 ) == 0 );
    CHECK( pea.heat_units( 7, 11 ) > 0 );
    CHECK( tomato.heat_units( -2, 26 ) == 0 );
    CHECK( tomato.heat_units( 18, 33 ) < tomato.heat_units( 18, 26 ) );
    CHECK( tomato.heat_units( 18, 39 ) == 0 );
}

TEST_CASE( "closed_windows_and_walls_retain_heat_longer", "[weather]" )
{
    const double masonry = indoor_heat_retention( 0.28, 0, 5 );
    const double closed_window = indoor_heat_retention( 0.53, 0, 5 );
    const double open_window = indoor_heat_retention( 0.21, 1, 5 );

    CHECK( masonry > closed_window );
    CHECK( closed_window > open_window );
    CHECK( indoor_heat_retention( 0.21, 1, 20 ) < open_window );
    CHECK( indoor_heat_retention( 0.28, 0, 20 ) == Approx( masonry ) );
}


TEST_CASE( "regional_field_calendar_tracks_pre_cataclysm_sowing", "[farming][weather]" )
{
    const field_crop spring{ itype_seed_potato_raw, 116, 294 };
    const field_crop winter{ itype_seed_red_winter_wheat, 275, 200 };
    const time_duration year = calendar::year_length();
    const time_point new_year = calendar::turn_zero - calendar::turn_zero_offset();
    const time_point may = new_year + year * ( 139.0 / 365 );
    const time_point march = new_year + year * ( 80.0 / 365 );
    CHECK_FALSE( spring.sowing_date( march ) );
    REQUIRE( spring.sowing_date( may ) );
    CHECK( *spring.sowing_date( may ) < may );
    REQUIRE( winter.sowing_date( may ) );
    CHECK( *winter.sowing_date( may ) < new_year );
    CHECK_FALSE( spring.sowing_date( new_year + year * ( 310.0 / 365 ) ) );
}

TEST_CASE( "regional_farms_select_distinct_local_mix", "[farming][north_america]" )
{
    const auto iowa = regional_field_crop( "US-IA", 0 );
    const auto maine = regional_field_crop( "US-ME", 0 );
    const auto sinaloa = regional_field_crop( "MX-SIN", 0 );
    REQUIRE( iowa );
    REQUIRE( maine );
    REQUIRE( sinaloa );
    CHECK( iowa->seed == itype_seed_corn );
    CHECK( maine->seed == itype_seed_potato_raw );
    CHECK( sinaloa->planting_day > sinaloa->harvest_day );
}
