#include <algorithm>
#include <functional>
#include <sstream>
#include <string>
#include <tuple>
#include <vector>

#include "calendar.h"
#include "cata_catch.h"
#include "construction.h"
#include "finite_water.h"
#include "game_constants.h"
#include "inventory.h"
#include "item.h"
#include "json.h"
#include "json_loader.h"
#include "map.h"
#include "mapbuffer.h"
#include "map_helpers.h"
#include "map_scale_constants.h"
#include "npc.h"
#include "omdata.h"
#include "overmap.h"
#include "overmapbuffer.h"
#include "player_helpers.h"
#include "point.h"
#include "cata_scope_helpers.h"
#include "submap.h"
#include "type_id.h"

static const construction_str_id construction_constr_water_channel( "constr_water_channel" );
static const construction_str_id
construction_constr_small_water_basin( "constr_small_water_basin" );
static const construction_str_id
construction_constr_fill_water_channel( "constr_fill_water_channel" );

static const itype_id itype_water( "water" );
static const itype_id itype_water_clean( "water_clean" );
static const itype_id itype_salt_water( "salt_water" );
static const itype_id itype_water_murky( "water_murky" );
static const itype_id itype_water_sewage( "water_sewage" );
static const itype_id itype_mutagen_interstice( "mutagen_interstice" );

static const oter_str_id oter_river( "river_center" );
static const oter_str_id oter_ocean( "ocean_surface" );
static const oter_str_id oter_lake( "lake_surface" );
static const oter_str_id oter_stream( "stream_north" );
static const oter_str_id oter_field( "field" );

static const ter_str_id ter_grass( "t_grass" );
static const ter_str_id ter_water_sh( "t_water_sh" );
static const ter_str_id ter_swater_sh( "t_swater_sh" );
static const ter_str_id ter_water_moving_sh( "t_water_moving_sh" );
static const ter_str_id ter_water_moving_dp( "t_water_moving_dp" );
static const ter_str_id ter_water_pool( "t_water_pool" );
static const ter_str_id ter_water_murky( "t_water_murky" );
static const ter_str_id ter_water_sh_murky_underground( "t_water_sh_murky_underground" );
static const ter_str_id ter_sewage( "t_sewage" );
static const ter_str_id ter_water_hot( "t_water_hot" );
static const ter_str_id ter_water_sh_flood( "t_water_sh_flood" );
static const ter_str_id ter_nl_water_pool( "t_nl_water_pool" );
static const ter_str_id ter_nl_water_pool_low( "t_nl_water_pool_low" );
static const ter_str_id ter_interstice_mutagen_sh( "t_interstice_mutagen_sh" );
static const ter_str_id ter_interstice_mutagen_pool( "t_interstice_mutagen_pool" );
static const ter_str_id ter_puddle( "t_puddle" );
static const ter_str_id ter_ice_sh_thick( "t_ice_sh_thick" );
static const ter_str_id ter_pond_water_sh( "t_pond_water_sh" );
static const ter_str_id ter_pond_water_dp( "t_pond_water_dp" );
static const ter_str_id ter_pond_water_dp_low( "t_pond_water_dp_low" );
static const ter_str_id ter_pond_bottom_dry_sh( "t_pond_bottom_dry_sh" );
static const ter_str_id ter_pond_bottom_dry_dp( "t_pond_bottom_dry_dp" );
static const ter_str_id ter_salt_pond_water_sh( "t_salt_pond_water_sh" );
static const ter_str_id ter_murky_bottom_dry( "t_murky_bottom_dry" );
static const ter_str_id ter_murky_bottom_dry_underground( "t_murky_bottom_dry_underground" );
static const ter_str_id ter_sewage_bottom_dry( "t_sewage_bottom_dry" );
static const ter_str_id ter_hot_spring_bottom_dry( "t_hot_spring_bottom_dry" );
static const ter_str_id ter_flood_bottom_dry( "t_flood_bottom_dry" );
static const ter_str_id ter_nl_pool_bottom_dry( "t_nl_pool_bottom_dry" );
static const ter_str_id ter_interstice_bottom_dry_sh( "t_interstice_bottom_dry_sh" );
static const ter_str_id ter_interstice_pool_bottom_dry( "t_interstice_pool_bottom_dry" );
static const ter_str_id ter_pool_water( "t_pool_water" );
static const ter_str_id ter_pool_water_shallow( "t_pool_water_shallow" );
static const ter_str_id ter_pool_bottom_dry( "t_pool_bottom_dry" );
static const ter_str_id ter_pool_bottom_dry_shallow( "t_pool_bottom_dry_shallow" );
static const ter_str_id ter_channel_dry( "t_channel_dry" );
static const ter_str_id ter_channel_water_fresh( "t_channel_water_fresh" );
static const ter_str_id ter_channel_water_salt( "t_channel_water_salt" );
static const ter_str_id ter_channel_flowing_fresh( "t_channel_flowing_fresh" );
static const ter_str_id ter_channel_flowing_salt( "t_channel_flowing_salt" );

namespace
{

tripoint_abs_ms setup_finite_water_test()
{
    clear_map_and_put_player_underground();
    map &here = get_map();
    const tripoint_bub_ms center( SEEX * MAPSIZE / 2, SEEY * MAPSIZE / 2, 0 );
    return here.get_abs( center );
}

void set_omt_ter( const tripoint_abs_ms &p, const oter_str_id &oter )
{
    overmap_buffer.ter_set( project_to<coords::omt>( p ), oter.id() );
}

int ground_charges( const tripoint_bub_ms &p, const itype_id &type )
{
    int result = 0;
    for( const item &it : get_map().i_at( p ) ) {
        if( it.typeId() == type && it.charges > 0 ) {
            result += it.charges;
        }
    }
    return result;
}

int finite_charges( const tripoint_bub_ms &p, const itype_id &type = itype_water )
{
    item source = finite_water::finite_liquid_from( get_map().get_abs( p ) );
    if( source.typeId() != type ) {
        return 0;
    }
    return source.charges;
}

item water_item( int charges )
{
    item result( itype_water, calendar::turn_zero );
    result.charges = charges;
    return result;
}

void set_finite_charges( const tripoint_bub_ms &p, int charges )
{
    const int current = finite_charges( p );
    if( current > charges ) {
        REQUIRE( finite_water::withdraw_finite_liquid( get_map().get_abs( p ),
                 current - charges ) == current - charges );
    } else if( current < charges ) {
        item added = water_item( charges - current );
        REQUIRE( finite_water::pour_into_finite_water( get_map().get_abs( p ), added ) ==
                 charges - current );
    }
}

const std::function<bool( const item & )> any_item = []( const item & )
{
    return true;
};

} // namespace

TEST_CASE( "finite_water_terrain_contract", "[finite_water]" )
{
    map &here = get_map();
    const tripoint_bub_ms center = here.get_bub( setup_finite_water_test() );

    here.ter_set( center, ter_pond_water_sh );
    CHECK( finite_charges( center ) == 400 );
    CHECK( ground_charges( center, itype_water ) == 0 );
    CHECK( here.has_flag( ter_furn_flag::TFLAG_LIQUIDCONT, center ) );
    CHECK( here.has_flag( ter_furn_flag::TFLAG_FISHABLE, center ) );
    CHECK( ter_pond_water_sh->dries_to == ter_pond_bottom_dry_sh );
    set_finite_charges( center, 123 );
    here.ter_set( center, ter_pond_water_sh );
    CHECK( finite_charges( center ) == 123 );

    const tripoint_bub_ms deep = center + tripoint::east * 2;
    here.ter_set( deep, ter_pond_water_dp );
    CHECK( finite_charges( deep ) == 1600 );
    CHECK( ground_charges( deep, itype_water ) == 0 );
    CHECK( ter_pond_water_dp->dries_to == ter_pond_bottom_dry_dp );

    const tripoint_bub_ms pool = deep + tripoint::east * 2;
    here.ter_set( pool, ter_pool_water );
    CHECK( finite_charges( pool ) == 1600 );
    CHECK( here.has_flag( ter_furn_flag::TFLAG_LIQUIDCONT, pool ) );
    CHECK_FALSE( here.has_flag( ter_furn_flag::TFLAG_FISHABLE, pool ) );

    const tripoint_bub_ms shallow_pool = pool + tripoint::east * 2;
    here.ter_set( shallow_pool, ter_pool_water_shallow );
    CHECK( finite_charges( shallow_pool ) == 400 );
    CHECK( ter_pool_water_shallow->dries_to == ter_pool_bottom_dry_shallow );

    const tripoint_bub_ms channel = shallow_pool + tripoint::east * 2;
    here.ter_set( channel, ter_channel_water_fresh );
    CHECK( finite_charges( channel ) == 400 );
    CHECK( ground_charges( channel, itype_water ) == 0 );
    CHECK( here.has_flag( ter_furn_flag::TFLAG_LIQUIDCONT, channel ) );

    const tripoint_bub_ms puddle = channel + tripoint::east * 2;
    here.ter_set( puddle, ter_puddle );
    CHECK( ground_charges( puddle, itype_water_murky ) >= 40 );
    CHECK( ground_charges( puddle, itype_water_murky ) <= 240 );
}

TEST_CASE( "finite_water_other_closed_liquids_are_finite", "[finite_water]" )
{
    map &here = get_map();
    const tripoint_bub_ms center = here.get_bub( setup_finite_water_test() );
    const std::vector<std::tuple<ter_str_id, ter_str_id, itype_id, int>> cases = {
        { ter_water_murky, ter_murky_bottom_dry, itype_water_murky, 400 },
        { ter_water_sh_murky_underground, ter_murky_bottom_dry_underground,
          itype_water_murky, 400 },
        { ter_sewage, ter_sewage_bottom_dry, itype_water_sewage, 400 },
        { ter_water_hot, ter_hot_spring_bottom_dry, itype_water_murky, 400 },
        { ter_water_sh_flood, ter_flood_bottom_dry, itype_water, 400 },
        { ter_nl_water_pool, ter_nl_pool_bottom_dry, itype_salt_water, 1600 },
        { ter_interstice_mutagen_sh, ter_interstice_bottom_dry_sh,
          itype_mutagen_interstice, 400 },
        { ter_interstice_mutagen_pool, ter_interstice_pool_bottom_dry,
          itype_mutagen_interstice, 400 }
    };

    int index = 0;
    for( const auto &[wet, dry, liquid_type, capacity] : cases ) {
        CAPTURE( wet.str(), liquid_type.str() );
        const tripoint_bub_ms p = center + tripoint::east * ( index++ * 2 );
        here.ter_set( p, wet );

        CHECK( here.liquid_from( p ).is_null() );
        CHECK( finite_charges( p, liquid_type ) == capacity );
        CHECK( ground_charges( p, liquid_type ) == 0 );

        REQUIRE( finite_water::withdraw_finite_liquid( here.get_abs( p ), capacity - 1 ) ==
                 capacity - 1 );
        const ter_str_id low_water = wet == ter_nl_water_pool ? ter_nl_water_pool_low : wet;
        CHECK( here.ter( p ) == low_water );
        CHECK( finite_charges( p, liquid_type ) == 1 );
        REQUIRE( finite_water::withdraw_finite_liquid( here.get_abs( p ), 1 ) == 1 );
        CHECK( here.ter( p ) == dry );

        item refill( liquid_type, calendar::turn_zero );
        refill.charges = 7;
        CHECK( finite_water::pour_into_finite_water( here.get_abs( p ), refill ) == 7 );
        CHECK( refill.charges == 0 );
        CHECK( here.ter( p ) == low_water );
        CHECK( finite_charges( p, liquid_type ) == 7 );
    }

    const tripoint_bub_ms hot = center + tripoint::south * 3;
    here.ter_set( hot, ter_water_hot );
    const item hot_water = finite_water::finite_liquid_from( here.get_abs( hot ) );
    CHECK( hot_water.typeId() == itype_water_murky );
    CHECK( units::to_celsius( hot_water.temperature ) >= 70.0 );
}

TEST_CASE( "finite_sewage_uses_one_connected_water_level", "[finite_water]" )
{
    map &here = get_map();
    const tripoint_bub_ms first = here.get_bub( setup_finite_water_test() );
    const tripoint_bub_ms second = first + tripoint::east;
    here.ter_set( first, ter_sewage );
    here.ter_set( second, ter_sewage );

    CHECK( finite_charges( first, itype_water_sewage ) == 800 );
    inventory crafting_sources;
    crafting_sources.form_from_map( here, { first, second }, nullptr, false );
    CHECK( crafting_sources.charges_of( itype_water_sewage ) == 800 );
    REQUIRE( finite_water::withdraw_finite_liquid( here.get_abs( first ), 1 ) == 1 );
    CHECK( here.ter( first ) == ter_sewage );
    CHECK( here.ter( second ) == ter_sewage );
    CHECK( finite_charges( second, itype_water_sewage ) == 799 );

    REQUIRE( finite_water::withdraw_finite_liquid( here.get_abs( second ), 799 ) == 799 );
    CHECK( here.ter( first ) == ter_sewage_bottom_dry );
    CHECK( here.ter( second ) == ter_sewage_bottom_dry );

    item wrong_liquid = water_item( 5 );
    CHECK( finite_water::pour_into_finite_water( here.get_abs( first ), wrong_liquid ) == 0 );
    CHECK( wrong_liquid.charges == 5 );
    CHECK( here.ter( first ) == ter_sewage_bottom_dry );
}

TEST_CASE( "finite_water_depletion_and_restoration", "[finite_water]" )
{
    map &here = get_map();
    const tripoint_bub_ms shallow = here.get_bub( setup_finite_water_test() );
    here.ter_set( shallow, ter_pond_water_sh );

    set_finite_charges( shallow, 3 );
    int wanted = 2;
    here.use_charges( { shallow }, itype_water, wanted, any_item );
    CHECK( wanted == 0 );
    CHECK( here.ter( shallow ) == ter_pond_water_sh );
    CHECK( finite_charges( shallow ) == 1 );

    wanted = 1;
    here.use_charges( { shallow }, itype_water, wanted, any_item );
    CHECK( wanted == 0 );
    CHECK( here.ter( shallow ) == ter_pond_bottom_dry_sh );
    CHECK( finite_charges( shallow ) == 0 );

    item refill = water_item( 50 );
    CHECK( finite_water::pour_into_finite_water( here.get_abs( shallow ), refill ) == 50 );
    CHECK( here.ter( shallow ) == ter_pond_water_sh );
    CHECK( finite_charges( shallow ) == 50 );

    const tripoint_bub_ms deep = shallow + tripoint::east * 2;
    here.ter_set( deep, ter_pond_water_dp );
    REQUIRE( finite_water::withdraw_finite_liquid( here.get_abs( deep ), 1600 ) == 1600 );
    REQUIRE( here.ter( deep ) == ter_pond_bottom_dry_dp );
    item deep_refill = water_item( 100 );
    CHECK( finite_water::pour_into_finite_water( here.get_abs( deep ), deep_refill ) == 100 );
    CHECK( here.ter( deep ) == ter_pond_water_dp_low );
    CHECK( here.has_flag( ter_furn_flag::TFLAG_SHALLOW_WATER, deep ) );
    CHECK_FALSE( here.has_flag( ter_furn_flag::TFLAG_DEEP_WATER, deep ) );
    CHECK( finite_charges( deep ) == 100 );

    item deep_top_up = water_item( 2000 );
    CHECK( finite_water::pour_into_finite_water( here.get_abs( deep ), deep_top_up ) == 1500 );
    CHECK( deep_top_up.charges == 500 );
    CHECK( finite_charges( deep ) == 1600 );
}

TEST_CASE( "finite_water_connected_pond_has_one_surface_level", "[finite_water]" )
{
    map &here = get_map();
    const tripoint_bub_ms shallow = here.get_bub( setup_finite_water_test() );
    const tripoint_bub_ms deep_a = shallow + tripoint::east;
    const tripoint_bub_ms deep_b = deep_a + tripoint::east;
    here.ter_set( shallow, ter_pond_water_sh );
    here.ter_set( deep_a, ter_pond_water_dp );
    here.ter_set( deep_b, ter_pond_water_dp );
    REQUIRE( finite_charges( deep_a ) == 3600 );

    // Taking a bucket from one deep square lowers the whole pond slightly;
    // the selected square must not become an isolated dry hole.
    CHECK( finite_water::withdraw_finite_liquid( here.get_abs( deep_a ), 8 ) == 8 );
    CHECK( finite_charges( deep_a ) == 3592 );
    CHECK( here.ter( shallow ) == ter_pond_water_sh );
    CHECK( here.ter( deep_a ) == ter_pond_water_dp );
    CHECK( here.ter( deep_b ) == ter_pond_water_dp );
    CHECK( ground_charges( shallow, itype_water ) == 0 );
    CHECK( ground_charges( deep_a, itype_water ) == 0 );
    CHECK( ground_charges( deep_b, itype_water ) == 0 );

    // Once the common surface drops to the shallow bottom, the edge dries
    // while both deep squares still contain water.
    CHECK( finite_water::withdraw_finite_liquid( here.get_abs( deep_a ), 1192 ) == 1192 );
    CHECK( finite_charges( deep_a ) == 2400 );
    CHECK( here.ter( shallow ) == ter_pond_bottom_dry_sh );
    CHECK( here.ter( deep_a ) == ter_pond_water_dp );
    CHECK( here.ter( deep_b ) == ter_pond_water_dp );
}

TEST_CASE( "finite_water_freezing_does_not_duplicate_water", "[finite_water]" )
{
    map &here = get_map();
    const tripoint_bub_ms pond_kept = here.get_bub( setup_finite_water_test() );
    here.ter_set( pond_kept, ter_pond_water_sh );
    set_finite_charges( pond_kept, 37 );

    // This is the exact state produced by the phase-change code: generic ice
    // terrain plus a record of the finite terrain it must thaw back into.
    here.ter_set( pond_kept, ter_ice_sh_thick );
    here.set_original_terrain_at( pond_kept, ter_pond_water_sh.id() );
    REQUIRE( here.has_original_terrain_at( pond_kept ) );
    REQUIRE( ground_charges( pond_kept, itype_water ) == 0 );

    // Ground item operations cannot remove the hidden water while frozen.
    here.i_clear( pond_kept );

    // Thawing by restoring the recorded terrain keeps the real stored amount.
    here.ter_set( pond_kept, here.get_original_terrain_at( pond_kept ) );
    CHECK( here.ter( pond_kept ) == ter_pond_water_sh );
    CHECK( finite_charges( pond_kept ) == 37 );
}

TEST_CASE( "finite_water_hidden_amount_survives_submap_save", "[finite_water][submap][load]" )
{
    const point_sm_ms pond( 4, 7 );
    submap original;
    original.set_all_ter( ter_grass.id(), true );
    original.set_ter( pond, ter_pond_water_sh.id() );
    original.set_finite_liquid( pond, 137 );

    std::ostringstream saved;
    JsonOut jsout( saved );
    jsout.start_object();
    original.store( jsout );
    jsout.end_object();

    submap restored;
    JsonValue saved_value = json_loader::from_string( saved.str() );
    JsonObject serialized = saved_value.get_object();
    for( JsonMember member : serialized ) {
        const std::string member_name = member.name();
        restored.load( member, member_name, 39 );
    }

    CHECK( restored.get_ter( pond ) == ter_pond_water_sh );
    CHECK( restored.get_finite_liquid( pond ) == 137 );
    CHECK( restored.get_items( pond ).empty() );
}

TEST_CASE( "finite_water_legacy_ground_item_is_absorbed", "[finite_water][load]" )
{
    map &here = get_map();
    const tripoint_bub_ms pond = here.get_bub( setup_finite_water_test() );
    here.ter_set( pond, ter_pond_water_sh );

    tripoint_abs_sm abs_sm;
    point_sm_ms local;
    std::tie( abs_sm, local ) = project_remain<coords::sm>( here.get_abs( pond ) );
    submap *sm = MAPBUFFER.lookup_submap( abs_sm );
    REQUIRE( sm != nullptr );
    sm->set_finite_liquid( local, 0 );

    item legacy = water_item( 123 );
    sm->get_items( local ).insert( legacy );
    REQUIRE( ground_charges( pond, itype_water ) == 123 );

    CHECK( finite_charges( pond ) == 123 );
    CHECK( ground_charges( pond, itype_water ) == 0 );
    CHECK( sm->get_finite_liquid( local ) == 123 );
}

TEST_CASE( "finite_water_natural_source_classification", "[finite_water]" )
{
    map &here = get_map();
    const tripoint_bub_ms center = here.get_bub( setup_finite_water_test() );
    const int omt_width = SEEX * 2;

    const tripoint_bub_ms river = center + tripoint::north;
    set_omt_ter( here.get_abs( river ), oter_river );
    here.ter_set( river, ter_water_sh );
    CHECK( finite_water::check_connection( here.get_abs( center ), true ) ==
           water_source_kind::fresh_infinite );

    const tripoint_bub_ms stream = center + tripoint::south * omt_width;
    set_omt_ter( here.get_abs( stream ), oter_stream );
    here.ter_set( stream, ter_water_moving_sh );
    CHECK( finite_water::check_connection( here.get_abs( stream + tripoint::east ), true ) ==
           water_source_kind::fresh_infinite );

    const tripoint_bub_ms lake = center + tripoint::west * omt_width;
    set_omt_ter( here.get_abs( lake ), oter_lake );
    here.ter_set( lake, ter_water_sh );
    CHECK( finite_water::check_connection( here.get_abs( lake + tripoint::east ), true ) ==
           water_source_kind::fresh_infinite );

    const tripoint_bub_ms ocean = center + tripoint::east * omt_width;
    set_omt_ter( here.get_abs( ocean ), oter_ocean );
    here.ter_set( ocean, ter_swater_sh );
    CHECK( finite_water::check_connection( here.get_abs( ocean + tripoint::west ), true ) ==
           water_source_kind::salt_infinite );

    const tripoint_bub_ms legacy_channel = center + tripoint::north * omt_width +
                                       tripoint::west * omt_width;
    set_omt_ter( here.get_abs( legacy_channel ), oter_field );
    here.ter_set( legacy_channel, ter_water_moving_sh );
    CHECK( finite_water::check_connection( here.get_abs( legacy_channel + tripoint::east ), true ) ==
           water_source_kind::fresh_finite );

    // A legacy swimming-pool tile remains finite even when its overmap tile
    // happens to be labeled as a river; the label cannot make it infinite.
    const tripoint_bub_ms legacy_pool = center + tripoint::south * omt_width +
                                         tripoint::east * omt_width;
    set_omt_ter( here.get_abs( legacy_pool ), oter_river );
    here.ter_set( legacy_pool, ter_water_pool );
    CHECK( finite_water::check_connection( here.get_abs( legacy_pool + tripoint::north ), true ) ==
           water_source_kind::fresh_finite );
}

TEST_CASE( "finite_water_salt_source_refills_dry_channels", "[finite_water]" )
{
    map &here = get_map();
    const tripoint_bub_ms ocean = here.get_bub( setup_finite_water_test() );
    set_omt_ter( here.get_abs( ocean ), oter_ocean );
    here.ter_set( ocean, ter_swater_sh );
    std::vector<tripoint_bub_ms> channels;
    for( int index = 1; index <= 3; ++index ) {
        const tripoint_bub_ms channel = ocean + tripoint::east * index;
        here.ter_set( channel, ter_channel_dry );
        channels.push_back( channel );
    }

    finite_water::fill_channel_at( here.get_abs( channels.front() ) );
    for( const tripoint_bub_ms &channel : channels ) {
        CHECK( here.ter( channel ) == ter_channel_flowing_salt );
        CHECK( ground_charges( channel, itype_salt_water ) == 0 );
        const item from_sea = here.liquid_from( channel );
        CHECK( from_sea.typeId() == itype_salt_water );
        CHECK( from_sea.charges == item::INFINITE_CHARGES );
    }
}

TEST_CASE( "finite_water_connected_channel_is_really_infinite", "[finite_water]" )
{
    map &here = get_map();
    const tripoint_bub_ms river = here.get_bub( setup_finite_water_test() );
    set_omt_ter( here.get_abs( river ), oter_river );
    here.ter_set( river, ter_water_sh );
    const tripoint_bub_ms channel = river + tripoint::east;
    here.ter_set( channel, ter_channel_dry );
    finite_water::fill_channel_at( here.get_abs( channel ) );
    REQUIRE( here.ter( channel ) == ter_channel_flowing_fresh );
    CHECK( here.has_flag( ter_furn_flag::TFLAG_CURRENT, channel ) );

    for( int draw = 0; draw < 3; ++draw ) {
        item source = here.liquid_from( channel );
        CHECK( source.typeId() == itype_water );
        CHECK( source.charges == item::INFINITE_CHARGES );
    }
    int crafting_water = 1200;
    here.use_charges( { channel }, itype_water, crafting_water, any_item );
    CHECK( crafting_water == 0 );
    CHECK( finite_charges( channel ) == 400 );

    here.ter_set( river, ter_grass );
    CHECK( here.liquid_from( channel ).is_null() );
    finite_water::refresh_connected_water( here.get_abs( channel ) );
    CHECK( here.ter( channel ) == ter_channel_water_fresh );
    CHECK_FALSE( here.has_flag( ter_furn_flag::TFLAG_CURRENT, channel ) );
    int finite_draw = 400;
    here.use_charges( { channel }, itype_water, finite_draw, any_item );
    CHECK( finite_draw == 0 );
    CHECK( here.ter( channel ) == ter_channel_dry );
}

TEST_CASE( "finite_water_dry_channels_refill_when_a_source_is_reconnected", "[finite_water]" )
{
    map &here = get_map();
    const tripoint_bub_ms river = here.get_bub( setup_finite_water_test() );
    set_omt_ter( here.get_abs( river ), oter_river );
    here.ter_set( river, ter_water_sh );

    const tripoint_bub_ms connector = river + tripoint::east;
    std::vector<tripoint_bub_ms> dry_channels;
    for( int index = 2; index <= 5; ++index ) {
        const tripoint_bub_ms channel = river + tripoint::east * index;
        here.ter_set( channel, ter_channel_dry );
        dry_channels.push_back( channel );
    }

    const tripoint_bub_ms far_end = dry_channels.back();
    CHECK( finite_water::check_connection( here.get_abs( far_end ), false ) ==
           water_source_kind::none );
    CHECK( finite_water::check_connection( here.get_abs( connector ), true ) ==
           water_source_kind::fresh_infinite );

    // This is the terrain change performed when construction finishes.  The
    // newly excavated connector reaches the previously isolated dry route.
    here.ter_set( connector, ter_channel_dry );
    CHECK( finite_water::check_connection( here.get_abs( far_end ), false ) ==
           water_source_kind::fresh_infinite );

    finite_water::fill_channel_at( here.get_abs( connector ) );
    CHECK( here.ter( connector ) == ter_channel_flowing_fresh );
    for( const tripoint_bub_ms &channel : dry_channels ) {
        CHECK( here.ter( channel ) == ter_channel_flowing_fresh );
        CHECK( ground_charges( channel, itype_water ) == 0 );
        CHECK( here.liquid_from( channel ).charges == item::INFINITE_CHARGES );
    }
}

TEST_CASE( "finite_water_dry_channels_share_only_existing_pond_water", "[finite_water]" )
{
    map &here = get_map();
    const tripoint_bub_ms pond = here.get_bub( setup_finite_water_test() );
    const tripoint_bub_ms channel1 = pond + tripoint::east;
    const tripoint_bub_ms channel2 = channel1 + tripoint::east;
    here.ter_set( pond, ter_pond_water_sh );
    here.ter_set( channel1, ter_channel_dry );
    here.ter_set( channel2, ter_channel_dry );

    finite_water::refresh_connected_water( here.get_abs( pond ) );

    CHECK( here.ter( channel1 ) == ter_channel_water_fresh );
    CHECK( here.ter( channel2 ) == ter_channel_water_fresh );
    CHECK( finite_charges( pond ) == 400 );
    CHECK( ground_charges( channel1, itype_water ) == 0 );
    CHECK( ground_charges( channel2, itype_water ) == 0 );

    CHECK( finite_water::withdraw_finite_liquid( here.get_abs( channel2 ), 400 ) == 400 );
    CHECK( here.ter( pond ) == ter_pond_bottom_dry_sh );
    CHECK( here.ter( channel1 ) == ter_channel_dry );
    CHECK( here.ter( channel2 ) == ter_channel_dry );
}

TEST_CASE( "finite_water_pond_channel_conserves_water", "[finite_water]" )
{
    map &here = get_map();
    const tripoint_bub_ms shallow = here.get_bub( setup_finite_water_test() );
    const tripoint_bub_ms deep = shallow + tripoint::east;
    here.ter_set( shallow, ter_pond_water_sh );
    here.ter_set( deep, ter_pond_water_dp );

    std::vector<tripoint_bub_ms> channels;
    for( int index = 1; index <= 5; ++index ) {
        const tripoint_bub_ms target = shallow + tripoint::west * index;
        here.ter_set( target, ter_channel_dry );
        finite_water::fill_channel_at( here.get_abs( target ) );
        REQUIRE( here.ter( target ) == ter_channel_water_fresh );
        channels.push_back( target );
    }
    CHECK( finite_charges( shallow ) == 2000 );
    CHECK( here.ter( shallow ) == ter_pond_water_sh );
    CHECK( here.ter( deep ) == ter_pond_water_dp );
    for( const tripoint_bub_ms &channel : channels ) {
        CHECK( ground_charges( channel, itype_water ) == 0 );
    }

    const tripoint_bub_ms extension = shallow + tripoint::west * 6;
    here.ter_set( extension, ter_channel_dry );
    finite_water::fill_channel_at( here.get_abs( extension ) );
    CHECK( here.ter( extension ) == ter_channel_water_fresh );
    CHECK( finite_charges( extension ) == 2000 );
}

TEST_CASE( "finite_water_pond_connected_to_river", "[finite_water]" )
{
    map &here = get_map();
    const tripoint_bub_ms river = here.get_bub( setup_finite_water_test() );
    set_omt_ter( here.get_abs( river ), oter_river );
    here.ter_set( river, ter_water_sh );
    const tripoint_bub_ms channel = river + tripoint::east;
    const tripoint_bub_ms pond = channel + tripoint::east;
    here.ter_set( channel, ter_channel_water_fresh );
    here.ter_set( pond, ter_pond_water_sh );
    set_finite_charges( pond, 25 );

    finite_water::refresh_connected_water( here.get_abs( channel ) );
    CHECK( finite_charges( pond ) == 800 );
    CHECK( here.liquid_from( pond ).charges == item::INFINITE_CHARGES );

    // An empty excavated channel remains an open route.  Only removing or
    // filling the channel actually disconnects the pond from the river.
    here.ter_set( channel, ter_grass );
    CHECK( here.liquid_from( pond ).is_null() );
    int wanted = 100;
    here.use_charges( { pond }, itype_water, wanted, any_item );
    CHECK( wanted == 0 );
    CHECK( finite_charges( pond ) == 300 );
}

TEST_CASE( "finite_water_fresh_salt_conflict", "[finite_water]" )
{
    map &here = get_map();
    const tripoint_bub_ms center = here.get_bub( setup_finite_water_test() );
    const tripoint_bub_ms salt_side = center + tripoint::west;
    const tripoint_bub_ms fresh_side = center + tripoint::east;
    here.ter_set( salt_side, ter_channel_water_salt );
    here.ter_set( fresh_side, ter_channel_water_fresh );
    here.ter_set( center, ter_channel_dry );

    CHECK( finite_water::check_connection( here.get_abs( center ), true ) ==
           water_source_kind::conflict );
    finite_water::fill_channel_at( here.get_abs( center ) );
    CHECK( here.ter( center ) == ter_channel_dry );

    const tripoint_bub_ms pond = salt_side + tripoint::north;
    const tripoint_bub_ms salt_channel = pond + tripoint::south;
    here.ter_set( pond, ter_pond_water_sh );
    here.ter_set( salt_channel, ter_channel_water_salt );
    CHECK( finite_water::check_connection( here.get_abs( pond ), false ) ==
           water_source_kind::conflict );
}

TEST_CASE( "finite_water_pouring_is_one_to_one", "[finite_water]" )
{
    map &here = get_map();
    const tripoint_bub_ms pond = here.get_bub( setup_finite_water_test() );
    here.ter_set( pond, ter_pond_water_sh );
    set_finite_charges( pond, 350 );

    item overflow = water_item( 100 );
    CHECK( finite_water::pour_into_finite_water( here.get_abs( pond ), overflow ) == 50 );
    CHECK( overflow.charges == 50 );
    CHECK( finite_charges( pond ) == 400 );

    item clean( itype_water_clean, calendar::turn_zero );
    clean.charges = 10;
    set_finite_charges( pond, 390 );
    CHECK( finite_water::pour_into_finite_water( here.get_abs( pond ), clean ) == 10 );
    CHECK( finite_charges( pond ) == 400 );

    item salt( itype_salt_water, calendar::turn_zero );
    salt.charges = 10;
    CHECK( finite_water::pour_into_finite_water( here.get_abs( pond ), salt ) == 0 );
    CHECK( salt.charges == 10 );
    item sewage( itype_water_sewage, calendar::turn_zero );
    sewage.charges = 10;
    CHECK( finite_water::pour_into_finite_water( here.get_abs( pond ), sewage ) == 0 );

    const tripoint_bub_ms channel = pond + tripoint::south;
    here.ter_set( channel, ter_channel_dry );
    set_finite_charges( pond, 390 );
    item accepted = water_item( 10 );
    CHECK( finite_water::pour_into_finite_water( here.get_abs( channel ), accepted ) == 10 );
    CHECK( accepted.charges == 0 );
    CHECK( finite_charges( channel ) == 400 );

    const tripoint_bub_ms isolated_fresh = pond + tripoint::south * 3;
    here.ter_set( isolated_fresh, ter_channel_dry );
    item fresh_fill = water_item( 5 );
    CHECK( finite_water::pour_into_finite_water( here.get_abs( isolated_fresh ), fresh_fill ) == 5 );
    CHECK( here.ter( isolated_fresh ) == ter_channel_water_fresh );
    item wrong_salt( itype_salt_water, calendar::turn_zero );
    wrong_salt.charges = 5;
    CHECK( finite_water::pour_into_finite_water( here.get_abs( isolated_fresh ), wrong_salt ) == 0 );
    CHECK( wrong_salt.charges == 5 );

    const tripoint_bub_ms isolated_salt = pond + tripoint::north * 3;
    here.ter_set( isolated_salt, ter_channel_dry );
    item salt_fill( itype_salt_water, calendar::turn_zero );
    salt_fill.charges = 5;
    CHECK( finite_water::pour_into_finite_water( here.get_abs( isolated_salt ), salt_fill ) == 5 );
    CHECK( here.ter( isolated_salt ) == ter_channel_water_salt );
    item wrong_fresh = water_item( 5 );
    CHECK( finite_water::pour_into_finite_water( here.get_abs( isolated_salt ), wrong_fresh ) == 0 );
    CHECK( wrong_fresh.charges == 5 );
}

TEST_CASE( "finite_water_connection_survives_map_shift", "[finite_water]" )
{
    map &here = get_map();
    const tripoint_abs_ms river_abs = setup_finite_water_test();
    const tripoint_bub_ms river = here.get_bub( river_abs );
    set_omt_ter( river_abs, oter_river );
    here.ter_set( river, ter_water_sh );

    constexpr int channel_length = 30;
    tripoint_abs_ms far_abs = river_abs;
    for( int index = 1; index <= channel_length; ++index ) {
        const tripoint_bub_ms channel = river + tripoint::east * index;
        here.ter_set( channel, ter_channel_water_fresh );
        far_abs = here.get_abs( channel );
    }
    REQUIRE( finite_water::check_connection( far_abs, false ) ==
             water_source_kind::fresh_infinite );

    int east_shifts = 0;
    const on_out_of_scope restore_map_position( [&here, &east_shifts]() {
        while( east_shifts > 0 ) {
            here.shift( point_rel_sm::west );
            --east_shifts;
        }
    } );
    for( ; east_shifts < 6; ++east_shifts ) {
        here.shift( point_rel_sm::east );
    }
    REQUIRE_FALSE( here.inbounds( here.get_bub( river_abs ) ) );
    REQUIRE( here.inbounds( here.get_bub( far_abs ) ) );
    CHECK( finite_water::check_connection( far_abs, false ) ==
           water_source_kind::fresh_infinite );
    CHECK( here.liquid_from( here.get_bub( far_abs ) ).charges == item::INFINITE_CHARGES );

}

TEST_CASE( "finite_water_can_drain_a_saved_pond_outside_the_bubble", "[finite_water]" )
{
    map &here = get_map();
    const tripoint_abs_ms pond_abs = setup_finite_water_test();
    const tripoint_bub_ms pond = here.get_bub( pond_abs );
    here.ter_set( pond, ter_pond_water_sh );

    constexpr int channel_length = 30;
    tripoint_abs_ms far_abs = pond_abs;
    for( int index = 1; index <= channel_length; ++index ) {
        const tripoint_bub_ms channel = pond + tripoint::east * index;
        here.ter_set( channel, ter_channel_water_fresh );
        far_abs = here.get_abs( channel );
    }
    const int initial_total = finite_charges( here.get_bub( far_abs ) );

    int east_shifts = 0;
    const on_out_of_scope restore_map_position( [&here, &east_shifts]() {
        while( east_shifts > 0 ) {
            here.shift( point_rel_sm::west );
            --east_shifts;
        }
    } );
    for( ; east_shifts < 6; ++east_shifts ) {
        here.shift( point_rel_sm::east );
    }
    REQUIRE_FALSE( here.inbounds( here.get_bub( pond_abs ) ) );

    const tripoint_abs_ms target_abs = far_abs + tripoint::east;
    const tripoint_bub_ms target = here.get_bub( target_abs );
    REQUIRE( here.inbounds( target ) );
    here.ter_set( target, ter_channel_dry );
    finite_water::fill_channel_at( target_abs );
    CHECK( here.ter( target ) == ter_channel_water_fresh );
    CHECK( finite_charges( target ) == initial_total );

    while( east_shifts > 0 ) {
        here.shift( point_rel_sm::west );
        --east_shifts;
    }
    CHECK( here.ter( here.get_bub( pond_abs ) ) == ter_pond_water_sh );
    CHECK( finite_charges( here.get_bub( pond_abs ) ) == initial_total );
}

TEST_CASE( "finite_water_npc_drinking", "[finite_water]" )
{
    map &here = get_map();
    const tripoint_bub_ms pond = here.get_bub( setup_finite_water_test() );
    here.ter_set( pond, ter_pond_water_sh );
    npc &guy = spawn_npc( point_bub_ms( ( pond + tripoint::west ).xy() ), "test_talker" );
    guy.set_thirst( 200 );

    CHECK( guy.drink_from_water_source( pond ) );
    CHECK( finite_charges( pond ) == 396 );

    set_finite_charges( pond, 1 );
    guy.set_thirst( 2000 );
    CHECK( guy.drink_from_water_source( pond ) );
    CHECK( here.ter( pond ) == ter_pond_bottom_dry_sh );

    const tripoint_bub_ms salt = pond + tripoint::east;
    here.ter_set( salt, ter_channel_water_salt );
    guy.set_thirst( 2000 );
    CHECK_FALSE( guy.drink_from_water_source( salt ) );
    CHECK( finite_charges( salt, itype_salt_water ) == 400 );
}

TEST_CASE( "finite_water_legacy_closed_water_migrates_on_first_use", "[finite_water][load]" )
{
    map &here = get_map();
    const tripoint_bub_ms pond = here.get_bub( setup_finite_water_test() );
    set_omt_ter( here.get_abs( pond ), oter_field );
    here.ter_set( pond, ter_water_sh );

    // Ordinary water in a field was an infinite source in old saves.  Its
    // first use now turns it into a finite pond without a visible ground item.
    CHECK( here.liquid_from( pond ).is_null() );
    CHECK( here.ter( pond ) == ter_pond_water_sh );
    CHECK( finite_charges( pond ) == 400 );
    CHECK( ground_charges( pond, itype_water ) == 0 );

    int wanted = 25;
    here.use_charges( { pond }, itype_water, wanted, any_item );
    CHECK( wanted == 0 );
    CHECK( finite_charges( pond ) == 375 );

    const tripoint_bub_ms pool = pond + tripoint::east * 2;
    here.ter_set( pool, ter_water_pool );
    CHECK( here.liquid_from( pool ).is_null() );
    CHECK( here.ter( pool ) == ter_pool_water );
    CHECK( finite_charges( pool ) == 1600 );

    const tripoint_bub_ms old_channel = pond + tripoint::west * 2;
    here.ter_set( old_channel, ter_water_moving_sh );
    CHECK( here.liquid_from( old_channel ).is_null() );
    CHECK( here.ter( old_channel ) == ter_channel_water_fresh );
    CHECK( finite_charges( old_channel ) == 400 );

    const tripoint_bub_ms closed_deep_current = pond + tripoint::west * 4;
    here.ter_set( closed_deep_current, ter_water_moving_dp );
    CHECK( here.liquid_from( closed_deep_current ).is_null() );
    CHECK( here.ter( closed_deep_current ) == ter_pond_water_dp );
    CHECK( finite_charges( closed_deep_current ) == 1600 );

    const tripoint_bub_ms salt_basin = pond + tripoint::south * 3;
    here.ter_set( salt_basin, ter_swater_sh );
    CHECK( here.liquid_from( salt_basin ).is_null() );
    CHECK( here.ter( salt_basin ) == ter_salt_pond_water_sh );
    CHECK( finite_charges( salt_basin, itype_salt_water ) == 400 );
}

TEST_CASE( "finite_water_deep_tile_becomes_shallow_before_drying", "[finite_water]" )
{
    map &here = get_map();
    const tripoint_bub_ms deep = here.get_bub( setup_finite_water_test() );
    here.ter_set( deep, ter_pond_water_dp );

    set_finite_charges( deep, 400 );
    CHECK( here.ter( deep ) == ter_pond_water_dp_low );
    CHECK( here.has_flag( ter_furn_flag::TFLAG_SHALLOW_WATER, deep ) );
    CHECK_FALSE( here.has_flag( ter_furn_flag::TFLAG_DEEP_WATER, deep ) );

    item refill = water_item( 1 );
    CHECK( finite_water::pour_into_finite_water( here.get_abs( deep ), refill ) == 1 );
    CHECK( here.ter( deep ) == ter_pond_water_dp );
    CHECK( here.has_flag( ter_furn_flag::TFLAG_DEEP_WATER, deep ) );
}

TEST_CASE( "finite_water_tiny_remainder_does_not_jump_to_new_channel", "[finite_water]" )
{
    map &here = get_map();
    const tripoint_bub_ms original = here.get_bub( setup_finite_water_test() );
    here.ter_set( original, ter_channel_water_fresh );
    REQUIRE( finite_water::withdraw_finite_liquid( here.get_abs( original ), 399 ) == 399 );
    REQUIRE( finite_charges( original ) == 1 );

    const tripoint_bub_ms east = original + tripoint::east;
    here.ter_set( east, ter_channel_dry );
    finite_water::refresh_connected_water( here.get_abs( east ) );
    CHECK( here.ter( original ) == ter_channel_water_fresh );
    CHECK( here.ter( east ) == ter_channel_dry );

    const tripoint_bub_ms west = original + tripoint::west;
    here.ter_set( west, ter_channel_dry );
    finite_water::refresh_connected_water( here.get_abs( west ) );
    CHECK( here.ter( original ) == ter_channel_water_fresh );
    CHECK( here.ter( east ) == ter_channel_dry );
    CHECK( here.ter( west ) == ter_channel_dry );
    CHECK( finite_charges( original ) == 1 );
}

TEST_CASE( "finite_water_disconnected_salt_channel_can_be_extended", "[finite_water]" )
{
    map &here = get_map();
    const tripoint_bub_ms salt = here.get_bub( setup_finite_water_test() );
    const tripoint_bub_ms extension = salt + tripoint::east;
    here.ter_set( salt, ter_channel_water_salt );

    CHECK( finite_water::check_connection( here.get_abs( extension ), true ) ==
           water_source_kind::salt_finite );
    here.ter_set( extension, ter_channel_dry );
    finite_water::fill_channel_at( here.get_abs( extension ) );
    CHECK( here.ter( extension ) == ter_channel_water_salt );
    CHECK_FALSE( here.has_flag( ter_furn_flag::TFLAG_CURRENT, extension ) );
    CHECK( finite_charges( extension, itype_salt_water ) == 400 );
}

TEST_CASE( "finite_water_replacing_surface_clears_hidden_amount", "[finite_water]" )
{
    map &here = get_map();
    const tripoint_bub_ms pond = here.get_bub( setup_finite_water_test() );
    here.ter_set( pond, ter_pond_water_sh );
    set_finite_charges( pond, 123 );

    here.ter_set( pond, ter_grass );
    here.ter_set( pond, ter_pond_water_sh );
    CHECK( finite_charges( pond ) == 400 );
}

TEST_CASE( "finite_water_construction_data", "[finite_water][construction]" )
{
    const construction &dig = construction_constr_water_channel.obj();
    CHECK( dig.time == to_moves<int>( 20_minutes ) );
    CHECK( dig.byproduct_item_group.has_value() );
    CHECK( dig.pre_flags.count( "DIGGABLE" ) > 0 );
    CHECK( dig.pre_flags.count( "FLAT" ) > 0 );

    const construction &basin = construction_constr_small_water_basin.obj();
    CHECK( basin.post_terrain == "t_pond_bottom_dry_sh" );
    CHECK( basin.time == to_moves<int>( 30_minutes ) );

    const construction &close = construction_constr_fill_water_channel.obj();
    CHECK( close.post_terrain == "t_dirt" );
    CHECK( close.time == to_moves<int>( 10_minutes ) );
}
