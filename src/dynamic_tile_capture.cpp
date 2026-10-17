#include "dynamic_tile_capture.h"

#include <array>
#include <utility>

#include "coordinates.h"
#include "field.h"
#include "field_type.h"
#include "item.h"
#include "itype.h"
#include "map.h"
#include "mapdata.h"
#include "point.h"
#include "submap.h"

dynamic_tile_context capture_dynamic_tile_context( const map &here, const tripoint_bub_ms &pos )
{
    const auto tile = here.maptile_at( pos );
    const furn_t &furniture = tile.get_furn_t();
    const ter_t &terrain = tile.get_ter_t();
    return { furniture.id.str(), terrain.id.str(),
        { furniture.get_flags().begin(), furniture.get_flags().end() },
        { terrain.get_flags().begin(), terrain.get_flags().end() } };
}

std::vector<field_render_view> capture_field_render_views( map &here, const tripoint_bub_ms &pos,
        const field_type_id primary, const std::array<bool, 5> &invisible,
        const std::map<tripoint_bub_ms, field_type_id> &overrides )
{
    std::vector<field_render_view> result;
    const auto override = overrides.find( pos );
    const bool overridden = override != overrides.end();
    const std::array<point, 4> offsets = { point::south, point::east, point::west, point::north };
    const auto capture = [&]( const field_type_id id, const int intensity ) {
        std::array<int, 4> neighborhood;
        for( size_t i = 0; i < offsets.size(); ++i ) {
            const tripoint_bub_ms neighbor = pos + offsets[i];
            const auto preview = overrides.find( neighbor );
            field_type_id adjacent;
            if( overridden ) {
                adjacent = preview != overrides.end() ? preview->second :
                           !invisible[i + 1] ? here.field_at( neighbor ).displayed_field_type() : field_type_id();
            } else {
                // The live path historically checks the same field type even
                // in an invisible neighbor; explicit overrides take precedence.
                adjacent = here.field_at( neighbor ).find_field( id, false ) ? id : field_type_id();
                if( preview != overrides.end() ) {
                    adjacent = preview->second;
                }
            }
            neighborhood[i] = adjacent.to_i();
        }
        field_render_view view;
        view.id = id.id().str();
        view.intensity = intensity;
        map::get_tile_values( id.to_i(), neighborhood, view.subtile, view.rotation, 0 );
        map::get_tile_values( primary.to_i(), neighborhood, view.context_subtile,
                              view.context_rotation, 0 );
        result.push_back( std::move( view ) );
    };
    if( overridden ) {
        if( override->second.obj().display_field ) {
            capture( override->second, 0 );
        }
    } else if( primary && !invisible[0] ) {
        for( const auto &entry : here.field_at( pos ) ) {
            if( entry.first.obj().display_field ) {
                capture( entry.first, entry.second.get_field_intensity() );
            }
        }
    }
    return result;
}

std::vector<item_layer_view> capture_item_layer_views( const map &here, const tripoint_bub_ms &pos )
{
    const auto tile = here.maptile_at( pos );
    std::vector<item_layer_view> result;
    const auto &items = tile.get_items();
    if( items.empty() ) {
        return result;
    }
    const itype_id uppermost = tile.get_uppermost_item().typeId();
    for( const item &entry : items ) {
        result.push_back( { entry.typeId().str(), entry.typeId()->get_item_type_string(),
                            entry.has_itype_variant() ? entry.itype_variant().id : std::string{},
                            entry.seed, entry.typeId() == uppermost } );
    }
    return result;
}
