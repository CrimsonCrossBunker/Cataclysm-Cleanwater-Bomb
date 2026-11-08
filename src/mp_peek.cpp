#include "mp_peek.h"

#include <algorithm>
#include <cmath>

#include "cached_options.h"
#include "character.h"
#include "game_constants.h"
#include "json.h"
#include "map.h"
#include "type_id.h"
#include "vertical_movement.h"

namespace cata_mp
{
static bool can_peek( const Character &who )
{
    return !who.is_dead_state() && !who.is_mounted() &&
           !who.has_active_mutation( trait_id( "SHELL2" ) ) &&
           !who.has_active_mutation( trait_id( "SHELL3" ) );
}

bool peek_authorization::valid_for( const Character &who, const map &here ) const
{
    if( request <= 0 || owner != who.getID() || origin != who.pos_abs() || !can_peek( who ) ) {
        return false;
    }
    if( over_ledge ) {
        return ledge_peek_position( who, here, target ) == viewpoint;
    }
    const auto positions = peek_destinations( who, here, direction );
    return viewpoint == target && standing == ( target == origin && who.is_crouching() ) &&
           std::find( positions.begin(), positions.end(), target ) != positions.end();
}

bool peek_authorization::contains( const tripoint_abs_ms &position, int radius ) const
{
    return std::abs( position.x() - viewpoint.x() ) <= radius &&
           std::abs( position.y() - viewpoint.y() ) <= radius &&
           std::abs( position.z() - viewpoint.z() ) <= z_range;
}

void peek_authorization::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "owner", owner );
    out.member( "request", request );
    out.member( "origin", origin );
    out.member( "target", target );
    out.member( "viewpoint", viewpoint );
    out.member( "z_range", z_range );
    out.member( "over_ledge", over_ledge );
    out.member( "direction", direction );
    out.member( "standing", standing );
    out.end_object();
}

void peek_authorization::deserialize( const JsonObject &data )
{
    data.read( "owner", owner, true );
    data.read( "request", request, true );
    data.read( "origin", origin, true );
    data.read( "target", target, true );
    data.read( "viewpoint", viewpoint, true );
    z_range = std::clamp( data.get_int( "z_range" ), 0, OVERMAP_DEPTH + OVERMAP_HEIGHT );
    data.read( "over_ledge", over_ledge, true );
    data.read( "direction", direction, true );
    data.read( "standing", standing, true );
}

std::optional<peek_authorization> authorize_ledge_peek( Character &who, map &here,
        const tripoint_abs_ms &origin, const tripoint_abs_ms &ledge, int64_t request )
{
    if( request <= 0 || !can_peek( who ) || who.activity || who.get_moves() <= 0 ||
        who.pos_abs() != origin ) {
        return std::nullopt;
    }
    const auto viewpoint = ledge_peek_position( who, here, ledge );
    if( !viewpoint ) {
        return std::nullopt;
    }
    who.mod_moves( -who.get_speed() * 2 );
    return peek_authorization{ who.getID(), request, origin, ledge, *viewpoint,
                               std::clamp( fov_3d_z_range, 0, OVERMAP_DEPTH + OVERMAP_HEIGHT ) };
}
std::optional<peek_authorization> authorize_peek( Character &who, map &here,
        const tripoint_abs_ms &origin, const tripoint_abs_ms &target, int direction, int64_t request )
{
    if( request <= 0 || !can_peek( who ) || who.activity || who.get_moves() <= 0 ||
        who.pos_abs() != origin ) {
        return std::nullopt;
    }
    peek_authorization result{ who.getID(), request, origin, target, target,
                               std::clamp( fov_3d_z_range, 0, OVERMAP_DEPTH + OVERMAP_HEIGHT ),
                               false, direction, target == origin &&who.is_crouching() };
    if( !result.valid_for( who, here ) ) {
        return std::nullopt;
    }
    who.mod_moves( -who.get_speed() * 2 );
    return result;
}
} // namespace cata_mp
