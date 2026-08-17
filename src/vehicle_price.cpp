#include "vehicle_price.h"

#include <set>

#include "calendar.h"
#include "item.h"
#include "itype.h"
#include "type_id.h"
#include "veh_type.h"
#include "vehicle.h"
#include "vpart_position.h"
#include "vpart_range.h"

int vehicle_part_base_price( const vehicle &veh, const bool post_cataclysm )
{
    int result = 0;
    for( const vpart_reference &reference : veh.get_all_parts() ) {
        const vehicle_part &part = reference.part();
        if( !part.removed ) {
            result += part.get_base().price_no_contents( post_cataclysm );
        }
    }
    return result;
}

namespace
{

std::set<itype_id> liquid_engine_fuels()
{
    std::set<itype_id> result;
    for( const vpart_info &part : vehicles::parts::get_all() ) {
        if( !part.engine_info ) {
            continue;
        }
        for( const itype_id &fuel_id : part.engine_info->fuel_opts ) {
            if( fuel_id.is_null() || !fuel_id.is_valid() ) {
                continue;
            }
            const item fuel( fuel_id, calendar::turn_zero, 1 );
            if( fuel.made_of( phase_id::LIQUID ) ) {
                result.insert( fuel_id );
            }
        }
    }
    return result;
}

} // namespace

int vehicle_tank_fuel_price_postapoc( const vehicle &veh )
{
    const std::set<itype_id> engine_fuels = liquid_engine_fuels();
    int result = 0;
    for( const vpart_reference &reference :
         veh.get_any_parts( vpart_bitflags::VPFLAG_FLUIDTANK ) ) {
        const vehicle_part &part = reference.part();
        if( part.has_flag( vp_flag::carried_flag ) || part.ammo_remaining() <= 0 ) {
            continue;
        }
        const itype_id fuel_id = part.ammo_current();
        if( engine_fuels.count( fuel_id ) == 0 ) {
            continue;
        }
        result += item( fuel_id, calendar::turn_zero,
                        part.ammo_remaining() ).price_no_contents( true );
    }
    return result;
}
