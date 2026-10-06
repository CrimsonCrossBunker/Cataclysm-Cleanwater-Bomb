#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include <algorithm>
#include <enums.h>
#include <pimpl.h>
#include <memory>
#include <sstream>
#include <vector>

#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "effect.h"
#include "flexbuffer_json.h"
#include "inventory.h"
#include "item.h"
#include "item_location.h"
#include "json.h"
#include "json_loader.h"
#include "lua_platform_runtime.h"
#include "mission.h"
#include "player_helpers.h"
#include "scenario.h"
#include "type_id.h"

static const itype_id itype_antivirals( "antivirals" );
static const efftype_id effect_antivirals( "antivirals" );
static const efftype_id effect_zombie_virus( "zombie_virus" );
static const mission_type_id mission_find_antivirals( "MISSION_INFECTED_START_FIND_ANTIVIRALS" );
static const string_id<scenario> scenario_deadly_virus( "deadly_virus" );

// Run explicitly with --mods deadly_bites. Ordinary engine suites need not load this Mod.
TEST_CASE( "deadly_bites_lua_medication_treats_once_and_consumes_one_dose",
           "[.][mods][deadly_bites]" )
{
    INFO( "This gameplay regression requires --mods deadly_bites" );
    REQUIRE( itype_antivirals.is_valid() );
    clear_avatar();
    avatar &patient = get_avatar();
    cata::lua_platform::runtime_world_ready( true );
    const int intensity = GENERATE( 0, 1, 2, 3, 4 );
    const bool protected_before = GENERATE( false, true );
    if( intensity > 0 ) {
        patient.add_effect( effect_zombie_virus, 1_turns, true, intensity );
    }
    if( protected_before ) {
        patient.add_effect( effect_antivirals, 16_hours );
    }
    // Solid medication is stored as individual items in CCB, not charge stacks.
    item &first_dose = patient.inv->add_item( item( itype_antivirals, calendar::turn ),
        false, false, false );
    item &second_dose = patient.inv->add_item( item( itype_antivirals, calendar::turn ),
        false, false, false );
    item &third_dose = patient.inv->add_item( item( itype_antivirals, calendar::turn ),
        false, false, false );
    const item_location first( patient, &first_dose );
    const item_location second( patient, &second_dose );
    const item_location third( patient, &third_dose );
    REQUIRE( patient.consume( first, true ) != trinary::NONE );
    CHECK_FALSE( first );
    CHECK( second );
    CHECK( third );
    CHECK( patient.get_effect_int( effect_zombie_virus ) ==
           ( protected_before ? intensity : ( intensity > 0 ? std::max( 1, intensity - 1 ) : 0 ) ) );
    CHECK( patient.get_effect_dur( effect_antivirals ) ==
           ( protected_before ? 20_hours : 16_hours ) );
    if( intensity > 0 ) {
        CHECK( patient.get_effect( effect_zombie_virus ).is_permanent() );
    }
    REQUIRE( patient.consume( second, true ) != trinary::NONE );
    CHECK_FALSE( second );
    CHECK( third );
    CHECK( patient.get_effect_int( effect_zombie_virus ) ==
           ( protected_before ? intensity : ( intensity > 0 ? std::max( 1, intensity - 1 ) : 0 ) ) );
    CHECK( patient.get_effect_dur( effect_antivirals ) ==
           ( protected_before ? 24_hours : 20_hours ) );
}

TEST_CASE( "deadly_bites_lua_scenario_starts_infection_and_find_medicine_mission",
           "[.][mods][deadly_bites]" )
{
    INFO( "This gameplay regression requires --mods deadly_bites" );
    REQUIRE( scenario_deadly_virus.is_valid() );
    REQUIRE( scenario_deadly_virus->has_platform_start_handler() );
    clear_avatar();
    avatar &patient = get_avatar();
    cata::lua_platform::runtime_world_ready( true );
    cata::lua_platform::invoke_character_start_handler(
        "scenario", "deadly_virus", "deadly_bites", "begin_deadly_virus", patient );
    CHECK( patient.get_effect_int( effect_zombie_virus ) == 1 );
    CHECK( patient.get_effect( effect_zombie_virus ).is_permanent() );
    const std::vector<mission *> missions = patient.get_active_missions();
    CHECK( std::any_of( missions.begin(), missions.end(), []( const mission * entry ) {
        return entry->mission_id() == mission_find_antivirals;
    } ) );
}

TEST_CASE( "deadly_bites_lua_infection_and_medicine_survive_character_save_load",
           "[.][mods][deadly_bites][save]" )
{
    REQUIRE( itype_antivirals.is_valid() );
    clear_avatar();
    avatar &patient = get_avatar();
    cata::lua_platform::runtime_world_ready( true );
    patient.add_effect( effect_zombie_virus, 1_turns, true, 3 );
    patient.inv->add_item( item( itype_antivirals, calendar::turn ), false, false, false );
    std::ostringstream stream;
    JsonOut json( stream );
    patient.serialize( json );

    clear_avatar();
    patient.deserialize( json_loader::from_string( stream.str() ).get_object() );
    cata::lua_platform::runtime_world_ready( false );
    REQUIRE( patient.get_effect_int( effect_zombie_virus ) == 3 );
    REQUIRE( patient.get_effect( effect_zombie_virus ).is_permanent() );
    REQUIRE( patient.amount_of( itype_antivirals ) == 1 );
    // Legacy inventory entries are not included in all_items_loc().
    item &stored = patient.inv->find_item( 0 );
    const item_location medication( patient, &stored );
    REQUIRE( medication->typeId() == itype_antivirals );
    REQUIRE( patient.consume( medication, true ) != trinary::NONE );
    CHECK( patient.amount_of( itype_antivirals ) == 0 );
    CHECK( patient.get_effect_int( effect_zombie_virus ) == 2 );
    CHECK( patient.get_effect_dur( effect_antivirals ) == 16_hours );
}
#endif
