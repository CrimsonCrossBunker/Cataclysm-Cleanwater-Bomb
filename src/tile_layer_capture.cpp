#include "tile_layer_capture.h"

#if defined(TILES)
#include <bitset>
#include <string>

#include "avatar.h"
#include "enums.h"
#include "game_constants.h"
#include "map.h"
#include "map_memory.h"
#include "mapdata.h"
#include "point.h"
#include "cata_utility.h"
#include "trap.h"

bool capture_terrain_layer( map &here, const avatar &you,
                            const tile_layer_capture_input &input, const std::map<tripoint_bub_ms, ter_id> &overrides,
                            tile_layer_view &output )
{
    const tripoint_bub_ms &p = input.position;
    const lit_level ll = input.light;
    const std::array<bool, 5> &invisible = input.invisible;

    const auto override = overrides.find( p );
    const bool overridden = override != overrides.end();
    bool neighborhood_overridden = overridden;
    if( !neighborhood_overridden && !overrides.empty() ) {
        for( const point &dir : neighborhood ) {
            if( overrides.find( p + dir ) != overrides.end() ) {
                neighborhood_overridden = true;
                break;
            }
        }
    }
    // Normal path: read from the cache populated during the rebuild pass.
    // No live map access — terrain content and orientation were captured
    // when the draw cache was rebuilt (dirty-gated).
    if( !invisible[0] && !neighborhood_overridden ) {
        const tile_render_info::sprite &cap =
            input.cached;

        if( !cap.ter_content ) {
            return false;
        }
        // Legacy mode does not draw fog sprites
        if( input.legacy_no_fog && cap.ter_content.id().str() == "t_open_air" ) {
            return false;
        }
        output.assign( cap.ter_content.id().str(),
                       TILE_CATEGORY::TERRAIN, std::string{}, p,
                       cap.ter_content_subtile, cap.ter_content_rotation, ll, input.night_vision, here.get_abs( p ) );
        return true;
    }
    // Override / memory / invisible path: live-read from the map because
    // override previews and memory tiles are not captured into the cache.
    const ter_id &t = here.ter( p );
    const std::string &tname = t.id().str();
    // Legacy mode does not draw fog sprites
    if( input.legacy_no_fog && tname == "t_open_air" ) {
        return false;
    }
    if( invisible[0] ? overridden : neighborhood_overridden ) {
        // and then draw the override terrain
        const ter_id &t2 = overridden ? override->second : t;
        if( t2 ) {
            // both the current and neighboring overrides may change the appearance
            // of the tile, so always re-calculate it.
            int subtile = 0;
            int rotation = 0;
            const std::bitset<NUM_TERCONN> &connect_group = t2.obj().connect_to_groups;
            const std::bitset<NUM_TERCONN> &rotate_group = t2.obj().rotate_to_groups;

            if( connect_group.any() ) {
                map::get_connect_values( p, subtile, rotation, connect_group, rotate_group,
                                         overrides );
            } else {
                map::get_terrain_orientation( p, rotation, subtile, overrides, invisible,
                                              rotate_group );
            }
            const std::string &tname = t2.id().str();
            // tile overrides are never memorized
            // tile overrides are always shown with full visibility
            const lit_level lit = overridden ? lit_level::LIT : ll;
            const bool nv = overridden ? false : input.night_vision;
            output.assign( tname, TILE_CATEGORY::TERRAIN, std::string{},
                           p, subtile, rotation, lit, nv,
                           here.get_abs( p ), overridden );
            return true;
        }
    } else if( invisible[0] ) {
        // try drawing memory if invisible and not overridden
        const memorized_tile &mt = you.get_memorized_tile( here.get_abs( p ) );
        if( !mt.get_ter_id().empty() ) {
            output.assign( mt.get_ter_id(), TILE_CATEGORY::TERRAIN,
                           std::string{}, p,
                           mt.get_ter_subtile(), mt.get_ter_rotation(), lit_level::MEMORIZED, input.night_vision,
                           here.get_abs( p ) );
            return true;
        }
    }
    return false;

}

bool capture_furniture_layer( map &here, const avatar &you,
                              const tile_layer_capture_input &input, const std::map<tripoint_bub_ms, furn_id> &overrides,
                              tile_layer_view &output )
{
    const tripoint_bub_ms &p = input.position;
    const lit_level ll = input.light;
    const std::array<bool, 5> &invisible = input.invisible;

    const auto display_override =
        [&here, &overrides]( const tripoint_bub_ms & q,
    const bool allow_vehicle_ladder ) -> std::optional<furn_id> {
        const auto override = overrides.find( q );
        if( override != overrides.end() )
        {
            return override->second;
        }
        return allow_vehicle_ladder ? here.vehicle_ladder_furniture_at( q ) : std::nullopt;
    };
    const auto explicit_override = overrides.find( p );
    const bool explicitly_overridden = explicit_override != overrides.end();
    std::optional<furn_id> override;
    if( explicitly_overridden ) {
        override = explicit_override->second;
    } else if( !invisible[0] ) {
        override = display_override( p, true );
    }
    const bool vehicle_ladder_overridden = override.has_value() && !explicitly_overridden;
    const bool overridden = override.has_value();
    bool neighborhood_overridden = overridden;
    if( !neighborhood_overridden ) {
        for( std::size_t i = 0; i < neighborhood.size(); ++i ) {
            if( display_override( p + neighborhood[i], !invisible[i + 1] ) ) {
                neighborhood_overridden = true;
                break;
            }
        }
    }
    // Normal path: read from the cache populated during the rebuild pass.
    // No live map access — furniture content and orientation were captured
    // when the draw cache was rebuilt (dirty-gated).
    if( !invisible[0] && !neighborhood_overridden ) {
        const tile_render_info::sprite &cap =
            input.cached;

        if( !cap.furn_content ) {
            return false;
        }
        output.assign( cap.furn_content.id().str(),
                       TILE_CATEGORY::FURNITURE, std::string{}, p,
                       cap.furn_content_subtile, cap.furn_content_rotation, ll, input.night_vision, here.get_abs( p ) );
        return true;
    }
    // Override / memory / invisible path: live-read from the map because
    // override previews and memory tiles are not captured into the cache.
    const furn_id &f = here.furn( p );
    if( invisible[0] ? overridden : neighborhood_overridden ) {
        // and then draw the override furniture
        const furn_id f2 = overridden ? *override : f;
        if( f2 ) {
            // both the current and neighboring overrides may change the appearance
            // of the tile, so always re-calculate it.
            const auto furn = [&]( const tripoint_bub_ms & q, const bool invis ) -> furn_id {
                const std::optional<furn_id> override = display_override( q, !invis );
                return override ? *override :
                ( !overridden || !invis ) ? here.furn( q ) : furn_str_id::NULL_ID().id();
            };
            const std::array<int, 4> neighborhood = {
                static_cast<int>( furn( p + point::south, invisible[1] ) ),
                static_cast<int>( furn( p + point::east, invisible[2] ) ),
                static_cast<int>( furn( p + point::west, invisible[3] ) ),
                static_cast<int>( furn( p + point::north, invisible[4] ) )
            };
            int subtile = 0;
            int rotation = 0;
            const furn_id &tile_values_furn = vehicle_ladder_overridden ? f2 : f;
            const std::bitset<NUM_TERCONN> &connect_group = tile_values_furn.obj().connect_to_groups;
            const std::bitset<NUM_TERCONN> &rotate_group = tile_values_furn.obj().rotate_to_groups;

            if( connect_group.any() ) {
                map::get_furn_connect_values( p, subtile, rotation, connect_group, rotate_group, {} );
            } else {
                map::get_tile_values_with_ter( p, tile_values_furn.to_i(), neighborhood, subtile,
                                               rotation, rotate_group );
            }
            map::get_tile_values_with_ter( p, f2.to_i(), neighborhood, subtile, rotation, 0 );
            const std::string &fname = f2.id().str();
            // tile overrides are never memorized
            // tile overrides are always shown with full visibility
            const lit_level lit = explicitly_overridden ? lit_level::LIT : ll;
            const bool nv = explicitly_overridden ? false : input.night_vision;
            output.assign( fname, TILE_CATEGORY::FURNITURE, std::string{},
                           p, subtile, rotation, lit,
                           nv, here.get_abs( p ), explicitly_overridden );
            return true;
        }
    } else if( invisible[0] ) {
        // try drawing memory if invisible and not overridden
        const memorized_tile &mt = you.get_memorized_tile( here.get_abs( p ) );
        if( string_starts_with( mt.get_dec_id(), "f_" ) ) {
            output.assign( mt.get_dec_id(), TILE_CATEGORY::FURNITURE,
                           std::string{}, p,
                           mt.get_dec_subtile(), mt.get_dec_rotation(), lit_level::MEMORIZED, input.night_vision,
                           here.get_abs( p ) );
            return true;
        }
    }
    return false;

}

bool capture_trap_layer( map &here, const avatar &you,
                         const tile_layer_capture_input &input, const std::map<tripoint_bub_ms, trap_id> &overrides,
                         tile_layer_view &output )
{
    const tripoint_bub_ms &p = input.position;
    const lit_level ll = input.light;
    const std::array<bool, 5> &invisible = input.invisible;

    const auto override = overrides.find( p );
    const bool overridden = override != overrides.end();
    bool neighborhood_overridden = overridden;
    if( !neighborhood_overridden && !overrides.empty() ) {
        for( const point &dir : neighborhood ) {
            if( overrides.find( p + dir ) != overrides.end() ) {
                neighborhood_overridden = true;
                break;
            }
        }
    }

    // Normal path: read from the cache populated during the rebuild pass.
    // The rebuild only captures a trap when it is visible to the avatar
    // (tr.can_see gate), so a non-null trap_content here implies both
    // "trap present" and "trap visible to the observer".  No live map access.
    if( !invisible[0] && !neighborhood_overridden ) {
        const tile_render_info::sprite &cap =
            input.cached;

        if( !cap.trap_content ) {
            return false;
        }
        output.assign( cap.trap_content.id().str(),
                       TILE_CATEGORY::TRAP, std::string{}, p,
                       cap.trap_content_subtile, cap.trap_content_rotation, ll, input.night_vision, here.get_abs( p ) );
        return true;
    }
    // Override / memory / invisible path: live-read from the map because
    // override previews and memory tiles are not captured into the cache.
    const trap &tr = here.tr_at( p );
    if( overridden || ( !invisible[0] && neighborhood_overridden &&
                        tr.can_see( p, you ) ) ) {
        // and then draw the override trap
        const trap_id &tr2 = overridden ? override->second : tr.loadid;
        if( tr2 ) {
            // both the current and neighboring overrides may change the appearance
            // of the tile, so always re-calculate it.
            const auto tr_at = [&]( const tripoint_bub_ms & q, const bool invis ) -> trap_id {
                const auto it = overrides.find( q );
                return it != overrides.end() ? it->second :
                                      ( !overridden || !invis ) ? here.tr_at( q ).loadid : tr_null;
            };
            const std::array<int, 4> neighborhood = {
                static_cast<int>( tr_at( p + point::south, invisible[1] ) ),
                static_cast<int>( tr_at( p + point::east, invisible[2] ) ),
                static_cast<int>( tr_at( p + point::west, invisible[3] ) ),
                static_cast<int>( tr_at( p + point::north, invisible[4] ) )
            };
            int subtile = 0;
            int rotation = 0;
            map::get_tile_values( tr2.to_i(), neighborhood, subtile, rotation, 0 );
            const std::string &trname = tr2.id().str();
            // tile overrides are never memorized
            // tile overrides are always shown with full visibility
            const lit_level lit = overridden ? lit_level::LIT : ll;
            const bool nv = overridden ? false : input.night_vision;
            output.assign( trname, TILE_CATEGORY::TRAP, std::string{}, p,
                           subtile, rotation, lit, nv,
                           here.get_abs( p ), overridden );
            return true;
        }
    } else if( invisible[0] ) {
        // try drawing memory if invisible and not overridden
        const memorized_tile &mt = you.get_memorized_tile( here.get_abs( p ) );
        if( string_starts_with( mt.get_dec_id(), "tr_" ) ) {
            output.assign( mt.get_dec_id(), TILE_CATEGORY::TRAP,
                           std::string{}, p,
                           mt.get_dec_subtile(), mt.get_dec_rotation(), lit_level::MEMORIZED, input.night_vision,
                           here.get_abs( p ) );
            return true;
        }
    }
    return false;

}


std::optional<tile_layer_view> capture_terrain_layer( map &here, const avatar &you,
        const tile_layer_capture_input &input, const std::map<tripoint_bub_ms, ter_id> &overrides )
{
    tile_layer_view output{ std::string{}, TILE_CATEGORY::NONE, std::string{}, input.position,
                            0, 0, input.light, false, tripoint_abs_ms::zero };
    if( !capture_terrain_layer( here, you, input, overrides, output ) ) {
        return std::nullopt;
    }
    return output;
}

std::optional<tile_layer_view> capture_furniture_layer( map &here, const avatar &you,
        const tile_layer_capture_input &input, const std::map<tripoint_bub_ms, furn_id> &overrides )
{
    tile_layer_view output{ std::string{}, TILE_CATEGORY::NONE, std::string{}, input.position,
                            0, 0, input.light, false, tripoint_abs_ms::zero };
    if( !capture_furniture_layer( here, you, input, overrides, output ) ) {
        return std::nullopt;
    }
    return output;
}

std::optional<tile_layer_view> capture_trap_layer( map &here, const avatar &you,
        const tile_layer_capture_input &input, const std::map<tripoint_bub_ms, trap_id> &overrides )
{
    tile_layer_view output{ std::string{}, TILE_CATEGORY::NONE, std::string{}, input.position,
                            0, 0, input.light, false, tripoint_abs_ms::zero };
    if( !capture_trap_layer( here, you, input, overrides, output ) ) {
        return std::nullopt;
    }
    return output;
}

#endif // TILES
