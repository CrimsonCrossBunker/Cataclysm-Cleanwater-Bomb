#include <algorithm>
#include <string>
#include <utility>
#include <vector>

#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "color.h"
#include "debug.h"
#include "effect.h"
#include "item.h"
#include "iteminfo_query.h"
#include "itype.h"
#include "map_helpers.h"
#include "mapdata.h"
#include "mod_manager.h"
#include "monster.h"
#include "mtype.h"
#include "options_helpers.h"
#include "output.h"
#include "player_helpers.h"
#include "type_id.h"
#include "veh_type.h"
#include "vehicle.h"
#include "vpart_position.h"

static const efftype_id effect_bleed( "bleed" );
static const faction_id faction_your_followers( "your_followers" );
static const furn_str_id furn_f_chair( "f_chair" );
static const itype_id itype_rock( "rock" );
static const mtype_id mon_zombie( "mon_zombie" );
static const ter_str_id ter_t_grass( "t_grass" );
static const vproto_id vehicle_prototype_car( "car" );

TEST_CASE( "mod_source_display_follows_option_without_debug_mode", "[mod_source]" )
{
    const bool enabled = GENERATE( false, true );
    const override_option source_option( "SHOW_OVERMAP_MOD_SOURCE", enabled ? "true" : "false" );
    restore_on_out_of_scope restore_debug( debug_mode );
    debug_mode = GENERATE( false, true );
    CAPTURE( enabled, debug_mode );
    clear_avatar();
    clear_map();

    SECTION( "item_info_respects_both_option_and_requested_parts" ) {
        const item rock( itype_rock );
        REQUIRE_FALSE( rock.type->src.empty() );
        const std::string origin = get_origin( rock.type->src );
        std::vector<iteminfo> info;
        const iteminfo_query source_query( { iteminfo_parts::BASE_MOD_SRC } );
        rock.basic_info( info, &source_query, 1, false );
        CHECK( ( format_item_info( info, {} ).find( origin ) != std::string::npos ) == enabled );

        // Comparisons and other callers requesting only weight must not gain an origin line.
        info.clear();
        const iteminfo_query weight_query( { iteminfo_parts::BASE_WEIGHT } );
        rock.basic_info( info, &weight_query, 1, false );
        CHECK( format_item_info( info, {} ).find( origin ) == std::string::npos );
    }

    SECTION( "monster_description_keeps_internal_ids_debug_only" ) {
        const monster zombie( mon_zombie );
        REQUIRE_FALSE( zombie.type->src.empty() );
        const std::vector<std::string> info = zombie.monster::extended_description();
        const std::string origin = get_origin( zombie.type->src );
        CHECK( ( std::find( info.begin(), info.end(), origin ) != info.end() ) == enabled );
        const std::string internal_id = colorize( mon_zombie.str(), c_white );
        CHECK( ( std::find( info.begin(), info.end(), internal_id ) != info.end() ) == debug_mode );
    }

    SECTION( "terrain_and_furniture_descriptions" ) {
        REQUIRE_FALSE( ter_t_grass->src.empty() );
        const std::string terrain_origin = get_origin( ter_t_grass->src );
        const std::vector<std::string> terrain_info = ter_t_grass->ter_t::extended_description();
        CHECK( ( std::find( terrain_info.begin(), terrain_info.end(), terrain_origin ) !=
                 terrain_info.end() ) == enabled );

        REQUIRE_FALSE( furn_f_chair->src.empty() );
        const std::string furniture_origin = get_origin( furn_f_chair->src );
        const std::vector<std::string> furniture_info = furn_f_chair->furn_t::extended_description();
        CHECK( ( std::find( furniture_info.begin(), furniture_info.end(), furniture_origin ) !=
                 furniture_info.end() ) == enabled );
    }

    SECTION( "effect_description" ) {
        const effect bleeding( &effect_bleed.obj() );
        const std::vector<std::pair<efftype_id, mod_id>> source = { { effect_bleed, mod_id( "dda" ) } };
        CHECK( bleeding.disp_mod_source_info() == ( enabled ? get_origin( source ) : "" ) );
    }

    SECTION( "vehicle_description_handles_missing_prototype" ) {
        vehicle car( vehicle_prototype_car );
        REQUIRE( car.part_count() > 0 );
        car.owner = faction_your_followers;
        const optional_vpart_position part( vpart_position( car, 0 ) );
        REQUIRE_FALSE( car.type->src.empty() );
        const std::string origin = get_origin( car.type->src );
        const std::vector<std::string> info = part.extended_description();
        CHECK( ( std::find( info.begin(), info.end(), origin ) != info.end() ) == enabled );

        // Player-built vehicles do not necessarily retain a valid prototype.
        car.type = vproto_id::NULL_ID();
        const std::vector<std::string> custom_info = part.extended_description();
        REQUIRE_FALSE( custom_info.empty() );
        CHECK( custom_info.front().find( car.name ) != std::string::npos );
    }
}
