#include "vehicle_control.h"

#include <charconv>
#include <string>
#include <system_error>

#include "character.h"
#include "character_action_guard.h"
#include "cata_scope_helpers.h"
#include "game.h"
#include "flag.h"
#include "item.h"
#include "item_location.h"
#include "json.h"
#include "player_activity.h"
#include "translations.h"
#include "map.h"
#include "line.h"
#include "math_parser_diag_value.h"
#include "vehicle.h"
#include "vpart_position.h"
#include "vpart_range.h"

namespace
{
constexpr const char *binding_uid = "remote_vehicle_uid";
constexpr const char *binding_position = "remote_vehicle_position";
constexpr const char *legacy_position = "remote_controlling_vehicle";

bool has_remote_controller( const Character &who )
{
    return who.has_active_bionic( bionic_id( "bio_remote" ) ) ||
           who.has_active_item( itype_id( "remotevehcontrol" ) );
}

bool connection_available( const Character &who, map &here, const vehicle &target )
{
    if( target.fuel_left( here, itype_id( "battery" ) ) <= 0 ) {
        return false;
    }
    for( const vpart_reference &part : target.get_avail_parts( "REMOTE_CONTROLS" ) ) {
        if( rl_dist( who.pos_abs(), part.pos_abs() ) <= 40 ) {
            return true;
        }
    }
    return false;
}

vehicle *bound_vehicle( const Character &who, map &here )
{
    if( const diag_value *value = who.maybe_get_value( binding_uid ) ) {
        const std::string &text = value->str();
        int64_t uid = 0;
        const auto parsed = std::from_chars( text.data(), text.data() + text.size(), uid );
        if( parsed.ec != std::errc() || parsed.ptr != text.data() + text.size() || uid <= 0 ) {
            return nullptr;
        }
        // The saved absolute position is only a lookup hint. Identity is always
        // checked, and movement can be resolved through the loaded vehicle set.
        if( const diag_value *position = who.maybe_get_value( binding_position ) ) {
            const tripoint_abs_ms at = position->tripoint();
            if( here.inbounds( at ) ) {
                const optional_vpart_position found = here.veh_at( at );
                if( found && found->vehicle().uid().get_value() == uid ) {
                    return &found->vehicle();
                }
            }
        }
        return vehicle::find_vehicle_by_uid( here, uid );
    }
    if( const diag_value *legacy = who.maybe_get_value( legacy_position ) ) {
        // Old saves stored bubble coordinates under an absolute-coordinate type.
        // Read that format once, then the mutable accessor records the real UID.
        const tripoint_bub_ms at( legacy->tripoint().raw() );
        return here.inbounds( at ) ? veh_pointer_or_null( here.veh_at( at ) ) : nullptr;
    }
    return nullptr;
}
} // namespace

vehicle *resolve_remote_vehicle( const Character &who, map &here )
{
    if( ( !who.maybe_get_value( binding_uid ) && !who.maybe_get_value( legacy_position ) ) ||
        !has_remote_controller( who ) ) {
        return nullptr;
    }
    vehicle *target = bound_vehicle( who, here );
    return target && connection_available( who, here, *target ) ? target : nullptr;
}

bool set_remote_vehicle( Character &who, map &here, vehicle *target )
{
    if( !target || !has_remote_controller( who ) || !connection_available( who, here, *target ) ) {
        who.remove_value( binding_uid );
        who.remove_value( binding_position );
        who.remove_value( legacy_position );
        return target == nullptr;
    }
    who.set_value( binding_uid, std::to_string( target->uid().get_value() ) );
    who.set_value( binding_position, target->pos_abs() );
    who.remove_value( legacy_position );
    return true;
}

vehicle *get_remote_vehicle( Character &who, map &here )
{
    vehicle *target = resolve_remote_vehicle( who, here );
    if( target ) {
        const diag_value *hint = who.maybe_get_value( binding_position );
        if( !who.maybe_get_value( binding_uid ) || !hint || hint->tripoint() != target->pos_abs() ) {
            set_remote_vehicle( who, here, target );
        }
    } else if( who.maybe_get_value( binding_uid ) || who.maybe_get_value( legacy_position ) ) {
        set_remote_vehicle( who, here, nullptr );
    }
    return target;
}
