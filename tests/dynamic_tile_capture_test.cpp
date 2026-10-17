#if defined(TILES)
#include <array>
#include <map>
#include <string>
#include <vector>

#include "cata_catch.h"
#include "calendar.h"
#include "dynamic_tile_capture.h"
#include "field.h"
#include "field_type.h"
#include "item.h"
#include "itype.h"
#include "map.h"
#include "map_helpers.h"
#include "mapdata.h"
#include "rng.h"
#include "submap.h"
#include "type_id.h"

// Retain the old connection rule as an oracle, including invisible live
// neighbors, preview precedence and the primary-field contextual connection.
static std::vector<field_render_view> legacy_field_views( map &here, const tripoint_bub_ms &pos,
        const field_type_id primary, const std::array<bool, 5> &invisible,
        const std::map<tripoint_bub_ms, field_type_id> &overrides )
{
    std::vector<field_render_view> result;
    const bool overridden = overrides.count( pos ) != 0;
    const auto emit = [&]( const field_type_id id, const int intensity ) {
        const auto neighbor = [&]( const point & offset, const bool hidden ) {
            const tripoint_bub_ms p = pos + offset;
            field_type_id value;
            if( overridden ) {
                if( !hidden ) {
                    value = here.field_at( p ).displayed_field_type();
                }
            } else {
                for( const auto &entry : here.field_at( p ) ) {
                    if( entry.first == id ) {
                        value = id;
                    }
                }
            }
            const auto preview = overrides.find( p );
            return ( preview == overrides.end() ? value : preview->second ).to_i();
        };
        const std::array<int, 4> adjacent = { neighbor( point::south, invisible[1] ),
                                              neighbor( point::east, invisible[2] ), neighbor( point::west, invisible[3] ),
                                              neighbor( point::north, invisible[4] )
                                            };
        field_render_view view;
        view.id = id.id().str();
        view.intensity = intensity;
        map::get_tile_values( id.to_i(), adjacent, view.subtile, view.rotation, 0 );
        map::get_tile_values( primary.to_i(), adjacent, view.context_subtile,
                              view.context_rotation, 0 );
        result.push_back( view );
    };
    if( overridden ) {
        const field_type_id id = overrides.at( pos );
        if( id.obj().display_field ) {
            emit( id, 0 );
        }
    } else if( primary && !invisible[0] ) {
        for( const auto &entry : here.field_at( pos ) ) {
            if( entry.first.obj().display_field ) {
                emit( entry.first, entry.second.get_field_intensity() );
            }
        }
    }
    return result;
}

TEST_CASE( "owned_field_views_preserve_live_and_preview_connections", "[tiles][dynamic_view]" )
{
    clear_map_without_vision();
    map &here = get_map();
    const tripoint_bub_ms pos( 50, 50, 0 );
    const field_type_id smoke( "fd_smoke" );
    const field_type_id acid( "fd_acid" );
    REQUIRE( here.add_field( pos, smoke, 2 ) );
    REQUIRE( here.add_field( pos, acid, 1 ) );
    REQUIRE( here.add_field( pos + point::north, smoke, 1 ) );
    REQUIRE( here.add_field( pos + point::east, acid, 2 ) );
    // An entry scheduled for removal still existed in the legacy field loop.
    here.field_at( pos + point::north ).find_field( smoke )->set_field_intensity( 0 );
    for( int flags = 0; flags < 32; ++flags ) {
        std::array<bool, 5> invisible;
        for( size_t i = 0; i < invisible.size(); ++i ) {
            invisible[i] = ( flags & ( 1 << i ) ) != 0;
        }
        for( bool preview : {
                 false, true
             } ) {
            INFO( flags );
            INFO( preview );
            std::map<tripoint_bub_ms, field_type_id> overrides{ { pos + point::south, smoke } };
            if( preview ) {
                overrides.emplace( pos, acid );
            }
            const auto engine = rng_get_engine();
            const auto actual = capture_field_render_views( here, pos, smoke, invisible, overrides );
            CHECK( rng_get_engine() == engine );
            const auto expected = legacy_field_views( here, pos, smoke, invisible, overrides );
            REQUIRE( actual.size() == expected.size() );
            for( size_t i = 0; i < actual.size(); ++i ) {
                CHECK( actual[i].id == expected[i].id );
                CHECK( actual[i].intensity == expected[i].intensity );
                CHECK( actual[i].subtile == expected[i].subtile );
                CHECK( actual[i].rotation == expected[i].rotation );
                CHECK( actual[i].context_subtile == expected[i].context_subtile );
                CHECK( actual[i].context_rotation == expected[i].context_rotation );
            }
        }
    }
}

TEST_CASE( "dynamic_context_and_items_survive_world_stack_changes", "[tiles][dynamic_view]" )
{
    clear_map_without_vision();
    map &here = get_map();
    const tripoint_bub_ms pos( 50, 50, 0 );
    here.ter_set( pos, ter_id( "t_floor" ) );
    here.furn_set( pos, furn_id( "f_chair" ) );
    item rock( itype_id( "rock" ), calendar::turn );
    rock.seed = 19;
    item stick( itype_id( "stick" ), calendar::turn );
    stick.seed = 37;
    here.add_item_or_charges( pos, rock );
    here.add_item_or_charges( pos, stick );
    const auto tile = here.maptile_at( pos );
    const auto uppermost = tile.get_uppermost_item().typeId();
    const auto engine = rng_get_engine();
    const auto context = capture_dynamic_tile_context( here, pos );
    const auto items = capture_item_layer_views( here, pos );
    CHECK( rng_get_engine() == engine );
    REQUIRE( items.size() == 2 );
    size_t i = 0;
    for( const item &original : tile.get_items() ) {
        CHECK( items[i].id == original.typeId().str() );
        CHECK( items[i].category == original.typeId()->get_item_type_string() );
        CHECK( items[i].seed == original.seed );
        CHECK( items[i].same_type_as_uppermost == ( original.typeId() == uppermost ) );
        ++i;
    }
    const auto furniture_flags = here.furn( pos ).obj().get_flags();
    CHECK( context.furniture_flags == std::vector<std::string>( furniture_flags.begin(),
            furniture_flags.end() ) );
    here.i_clear( pos );
    here.ter_set( pos, ter_id( "t_wall" ) );
    here.furn_set( pos, furn_id() );
    CHECK( context.furniture == "f_chair" );
    CHECK( context.terrain == "t_floor" );
    CHECK( items[0].id == "rock" );
    CHECK( items[0].seed == 19 );
    CHECK( items[1].id == "stick" );
    CHECK( items[1].seed == 37 );
    CHECK( capture_item_layer_views( here, pos ).empty() );
}

TEST_CASE( "field_views_keep_content_after_fields_are_removed", "[tiles][dynamic_view]" )
{
    clear_map_without_vision();
    map &here = get_map();
    const tripoint_bub_ms pos( 50, 50, 0 );
    const field_type_id smoke( "fd_smoke" );
    REQUIRE( here.add_field( pos, smoke, 2 ) );
    const auto views = capture_field_render_views( here, pos, smoke, {}, {} );
    REQUIRE( views.size() == 1 );
    here.delete_field( pos, smoke );
    CHECK( views[0].id == "fd_smoke" );
    CHECK( views[0].intensity == 2 );
    CHECK( capture_field_render_views( here, pos, smoke, {}, {} ).empty() );
    CHECK( capture_field_render_views( here, pos, field_type_id(), {}, {} ).empty() );
}
#endif // TILES
