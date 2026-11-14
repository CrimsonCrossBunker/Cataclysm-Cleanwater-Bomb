// CCB: Focused tests for the feral-human and military spawn scaling world options
// (FERAL_SPAWN_SCALE, MILITARY_SITE_SPAWN, MILITARY_VEHICLE_SPAWN).
#include <string>
#include <utility>

#include "cata_catch.h"

#include "coordinates.h"
#include "creature.h"
#include "map.h"
#include "map_helpers.h"
#include "map_scale_constants.h"
#include "mongroup.h"
#include "monster.h"
#include "mtype.h"
#include "omdata.h"
#include "options_helpers.h"
#include "point.h"
#include "rng.h"
#include "type_id.h"
#include "vehicle_group.h"

static const mtype_id mon_test_zombie( "mon_test_zombie" );
static const mtype_id mon_feral_human_pipe( "mon_feral_human_pipe" );
static const mongroup_id GROUP_ZOMBIE( "GROUP_ZOMBIE" );
static const vgroup_id vg_military_vehicles( "military_vehicles" );
static const vgroup_id vg_city_vehicles( "city_vehicles" );
static const vgroup_id vg_parkinglot( "parkinglot" );
static const vproto_id veh_humvee( "humvee" );
static const vproto_id veh_policecar( "policecar" );
static const vproto_id veh_ambulance( "ambulance" );
static const vproto_id veh_fire_truck( "fire_truck" );
static const vproto_id veh_car_sedan( "car_sedan" );

namespace
{

// Snapshot the shared engine to restore global state, not to generate random values.
struct restore_rng {
    cata_default_random_engine saved = rng_get_engine(); // NOLINT(cata-determinism)
    ~restore_rng() {
        rng_get_engine() = saved;
    }
};

} // namespace

TEST_CASE( "military_and_feral_spawn_options_default_to_vanilla", "[military_spawn][option]" )
{
    CHECK( MonsterGroupManager::spawn_gate_density() == Approx( 1.0 ) );
    CHECK( MonsterGroupManager::spawn_multiplier( mon_test_zombie ) == Approx( 1.0 ) );
    CHECK( MonsterGroupManager::spawn_multiplier( mon_feral_human_pipe ) == Approx( 1.0 ) );
}

TEST_CASE( "feral_spawn_scale_splits_spawn_density_by_species", "[military_spawn][mongroup]" )
{
    SECTION( "zombies disabled, ferals enabled" ) {
        override_option spawn_density( "SPAWN_DENSITY", "0" );
        override_option feral_scale( "FERAL_SPAWN_SCALE", "1" );
        CHECK( MonsterGroupManager::spawn_gate_density() == Approx( 1.0 ) );
        CHECK( MonsterGroupManager::spawn_multiplier( mon_test_zombie ) == Approx( 0.0 ) );
        CHECK( MonsterGroupManager::spawn_multiplier( mon_feral_human_pipe ) == Approx( 1.0 ) );
    }

    SECTION( "ferals disabled, zombies enabled" ) {
        override_option spawn_density( "SPAWN_DENSITY", "1" );
        override_option feral_scale( "FERAL_SPAWN_SCALE", "0" );
        CHECK( MonsterGroupManager::spawn_gate_density() == Approx( 1.0 ) );
        CHECK( MonsterGroupManager::spawn_multiplier( mon_test_zombie ) == Approx( 1.0 ) );
        CHECK( MonsterGroupManager::spawn_multiplier( mon_feral_human_pipe ) == Approx( 0.0 ) );
    }

    SECTION( "independent values scale each species on its own" ) {
        override_option spawn_density( "SPAWN_DENSITY", "0.5" );
        override_option feral_scale( "FERAL_SPAWN_SCALE", "2" );
        CHECK( MonsterGroupManager::spawn_gate_density() == Approx( 2.0 ) );
        CHECK( MonsterGroupManager::spawn_multiplier( mon_test_zombie ) == Approx( 0.25 ) );
        CHECK( MonsterGroupManager::spawn_multiplier( mon_feral_human_pipe ) == Approx( 1.0 ) );
    }

    SECTION( "everything disabled gates at zero" ) {
        override_option spawn_density( "SPAWN_DENSITY", "0" );
        override_option feral_scale( "FERAL_SPAWN_SCALE", "0" );
        CHECK( MonsterGroupManager::spawn_gate_density() == Approx( 0.0 ) );
        CHECK( MonsterGroupManager::spawn_multiplier( mon_test_zombie ) == Approx( 0.0 ) );
        CHECK( MonsterGroupManager::spawn_multiplier( mon_feral_human_pipe ) == Approx( 0.0 ) );
    }
}

TEST_CASE( "place_spawns_splits_zombies_and_ferals_by_spawn_scale",
           "[military_spawn][monster][mapgen][spawn]" )
{
    restore_rng keep_rng;
    rng_set_engine_seed( 20261114 );

    static const species_id species_FERAL( "FERAL" );
    const point_bub_ms p1( 40, 40 );
    const point_bub_ms p2( 160, 160 );
    const tripoint_bub_ms center( 100, 100, 0 );

    const auto count_spawned = [ &center ]( map & here ) {
        int zombies = 0;
        int ferals = 0;
        for( const Creature *creature : here.get_creatures_in_radius( center, 2 * SEEX ) ) {
            if( const monster *spawned = creature->as_monster() ) {
                if( spawned->type->in_species( species_FERAL ) ) {
                    ++ferals;
                } else {
                    ++zombies;
                }
            }
        }
        return std::make_pair( zombies, ferals );
    };

    SECTION( "zombie scale zero leaves only ferals" ) {
        override_option spawn_density( "SPAWN_DENSITY", "0" );
        override_option feral_scale( "FERAL_SPAWN_SCALE", "1" );
        bool saw_ferals = false;
        for( int attempt = 0; attempt < 5 && !saw_ferals; ++attempt ) {
            clear_map_without_vision();
            map &here = get_map();
            here.place_spawns( GROUP_ZOMBIE, 1, p1, p2, 0, 1.0f );
            here.spawn_monsters( true );
            const auto [ zombies, ferals ] = count_spawned( here );
            CHECK( zombies == 0 );
            saw_ferals = ferals > 0;
        }
        CHECK( saw_ferals );
    }

    SECTION( "feral scale zero removes ferals" ) {
        override_option spawn_density( "SPAWN_DENSITY", "1" );
        override_option feral_scale( "FERAL_SPAWN_SCALE", "0" );
        bool saw_zombies = false;
        for( int attempt = 0; attempt < 5 && !saw_zombies; ++attempt ) {
            clear_map_without_vision();
            map &here = get_map();
            here.place_spawns( GROUP_ZOMBIE, 1, p1, p2, 0, 1.0f );
            here.spawn_monsters( true );
            const auto [ zombies, ferals ] = count_spawned( here );
            CHECK( ferals == 0 );
            saw_zombies = zombies > 0;
        }
        CHECK( saw_zombies );
    }
}

TEST_CASE( "military_vehicle_spawn_helpers", "[military_spawn][vehicle]" )
{
    CHECK( is_military_or_police_vehicle( veh_humvee ) );
    CHECK( is_military_or_police_vehicle( veh_policecar ) );
    CHECK( is_military_or_police_vehicle( veh_ambulance ) );
    CHECK( is_military_or_police_vehicle( veh_fire_truck ) );
    CHECK( !is_military_or_police_vehicle( veh_car_sedan ) );

    CHECK( vgroup_is_military( vg_military_vehicles ) );
    CHECK( !vgroup_is_military( vg_city_vehicles ) );
    CHECK( !vgroup_is_military( vg_parkinglot ) );

    SECTION( "option zero disables military vehicles" ) {
        override_option military_spawn( "MILITARY_VEHICLE_SPAWN", "0" );
        CHECK( !vehicle_spawn_roll( veh_humvee ) );
        CHECK( vehicle_spawn_roll( veh_car_sedan ) );
    }

    SECTION( "option one keeps them" ) {
        override_option military_spawn( "MILITARY_VEHICLE_SPAWN", "1" );
        CHECK( vehicle_spawn_roll( veh_humvee ) );
        CHECK( vehicle_spawn_roll( veh_car_sedan ) );
    }
}

TEST_CASE( "military_overmap_specials_carry_military_flag", "[military_spawn][overmap]" )
{
    CHECK( overmap_special_id( "mil_base" )->has_flag( "MILITARY" ) );
    CHECK( overmap_special_id( "military_outpost" )->has_flag( "MILITARY" ) );
    CHECK( overmap_special_id( "military helipad" )->has_flag( "MILITARY" ) );
    CHECK( overmap_special_id( "military_bunker_1" )->has_flag( "MILITARY" ) );
    CHECK( !overmap_special_id( "LMOE Shelter" )->has_flag( "MILITARY" ) );
}
