#include "vehicle.h"

#include <utility>

#include "map.h"
#include "veh_type.h"
#include "vpart_position.h"

ret_val<void> vehicle::can_mount( const point_rel_ms &dp, const vpart_info &vpi ) const
{
    return can_mount( tripoint_rel_ms( dp, 0 ), vpi );
}

int vehicle::install_part( map &here, const point_rel_ms &dp, const vpart_id &type )
{
    return install_part( here, tripoint_rel_ms( dp, 0 ), type );
}

int vehicle::install_part( map &here, const point_rel_ms &dp, const vpart_id &type, item &&base )
{
    return install_part( here, tripoint_rel_ms( dp, 0 ), type, std::move( base ) );
}

int vehicle::install_part( map &here, const point_rel_ms &dp, const vpart_id &type, item &&base,
                           std::vector<item> &installed_with )
{
    return install_part( here, tripoint_rel_ms( dp, 0 ), type, std::move( base ), installed_with );
}

int vehicle::install_part( map &here, const point_rel_ms &dp, vehicle_part &&vp )
{
    return install_part( here, tripoint_rel_ms( dp, vp.mount_level ), std::move( vp ) );
}

std::vector<int> vehicle::parts_at_relative( const point_rel_ms &dp, const bool use_cache,
        bool include_fake ) const
{
    return parts_at_relative( tripoint_rel_ms( dp, 0 ), use_cache, include_fake );
}

int vehicle::part_with_feature( const point_rel_ms &pt, vpart_bitflags f, bool unbroken,
                                bool include_fake ) const
{
    return part_with_feature( tripoint_rel_ms( pt, 0 ), f, unbroken, include_fake );
}

int vehicle::part_with_feature( const point_rel_ms &pt, const std::string &flag, bool unbroken,
                                bool include_fake ) const
{
    return part_with_feature( tripoint_rel_ms( pt, 0 ), flag, unbroken, include_fake );
}

int vehicle::avail_part_with_feature( const point_rel_ms &pt, const std::string &flag ) const
{
    return avail_part_with_feature( tripoint_rel_ms( pt, 0 ), flag );
}

int vehicle::avail_linkable_part( const point_rel_ms &pt, bool to_ports ) const
{
    return avail_linkable_part( tripoint_rel_ms( pt, 0 ), to_ports );
}

int vehicle::part_displayed_at( const point_rel_ms &dp, bool include_fake, bool below_roof,
                                bool roof ) const
{
    return part_displayed_at( tripoint_rel_ms( dp, 0 ), include_fake, below_roof, roof );
}

bool vehicle::has_structural_part( const point_rel_ms &dp ) const
{
    return has_structural_part( tripoint_rel_ms( dp, 0 ) );
}

vpart_edge_info vehicle::get_edge_info( const point_rel_ms &mount ) const
{
    return get_edge_info( tripoint_rel_ms( mount, 0 ) );
}

tripoint_rel_ms vpart_position::mount_pos3() const
{
    return vehicle().part( part_index() ).mount_pos3();
}

tripoint_abs_ms vehicle::mount_to_tripoint_abs( const tripoint_rel_ms &mount ) const
{
    const std::vector<int> at_mount = parts_at_relative( mount, true );
    if( !at_mount.empty() ) {
        return abs_part_pos( at_mount.front() );
    }
    tripoint_rel_ms translated( 0, 0, mount.z() );
    coord_translate( pivot_rotation[0], pivot_anchor[0], mount.xy(), translated );
    // A new upper deck follows the ramp displacement of the column below it.
    for( int level = mount.z() - 1; level >= 0; --level ) {
        const auto below = parts_at_relative( tripoint_rel_ms( mount.xy(), level ), true );
        if( !below.empty() ) {
            translated.z() = parts[below.front()].precalc[0].z() + mount.z() - level;
            break;
        }
    }
    return pos_abs() + translated;
}

tripoint_bub_ms vehicle::mount_to_tripoint( map *here, const tripoint_rel_ms &mount ) const
{
    return here->get_bub( mount_to_tripoint_abs( mount ) );
}

std::optional<tripoint_bub_ms> vehicle::deck_transition( const map &here,
        const tripoint_bub_ms &from, int dz ) const
{
    if( dz != 1 && dz != -1 ) {
        return std::nullopt;
    }
    const auto source = here.veh_at( from );
    if( !source || &source->vehicle() != this ||
        !source.part_with_feature( VPFLAG_BOARDABLE, true ) ) {
        return std::nullopt;
    }
    const tripoint_rel_ms mount = source->mount_pos3();
    const tripoint_rel_ms lower( mount.xy(), mount.z() + ( dz < 0 ? -1 : 0 ) );
    const int ladder = avail_part_with_feature( lower, "DECK_STAIRS" );
    const auto destination_parts = parts_at_relative( mount + tripoint( 0, 0, dz ), true );
    if( ladder < 0 || destination_parts.empty() ) {
        return std::nullopt;
    }
    const tripoint_bub_ms dest = bub_part_pos( here, destination_parts.front() );
    if( !here.inbounds( dest ) || !here.passable( dest ) ||
        !here.veh_at( dest ).part_with_feature( VPFLAG_BOARDABLE, true ) ) {
        return std::nullopt;
    }
    return dest;
}

vpart_display vehicle::get_display_of_tile( const point_rel_ms &dp, bool rotate, bool include_fake,
        bool below_roof, bool roof ) const
{
    return get_display_of_tile( tripoint_rel_ms( dp, 0 ), rotate, include_fake, below_roof, roof );
}

void vehicle::unlink_cables( map &here, const point_rel_ms &mount, Character &remover,
                             bool unlink_items, bool unlink_tow_cables, bool unlink_power_cords )
{
    unlink_cables( here, tripoint_rel_ms( mount, 0 ), remover, unlink_items,
                   unlink_tow_cables, unlink_power_cords );
}
