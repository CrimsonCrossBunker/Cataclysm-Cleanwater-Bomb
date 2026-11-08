#include "liquid_transfer.h"

#include <cstddef>

#include "character.h"
#include "finite_water.h"
#include "handle_liquid.h"
#include "iexamine.h"
#include "item.h"
#include "map.h"
#include "vehicle.h"
#include "vpart_position.h"
#include "vpart_range.h"

namespace liquid_handler
{
bool transfer_liquid( Character &who, item &liquid, liquid_dest_opt target,
                      std::optional<int> tank_part, bool silent, bool charge_moves )
{
    if( !liquid.made_of( phase_id::LIQUID ) || liquid.charges <= 0 ) {
        return false;
    }
    switch( target.dest_opt ) {
        case LD_ITEM:
            if( !target.item_loc || target.item_loc.get_item() == &liquid ||
                target.item_loc->has_item( liquid ) ||
                !who.pour_into( target.item_loc, liquid, true, silent ) ) {
                return false;
            }
            target.item_loc.make_active();
            if( charge_moves ) {
                who.mod_moves( -100 );
            }
            return true;
        case LD_VEH:
            if( !target.veh || !tank_part || *tank_part < 0 ) {
                return false;
            }
            // Resolve the selected index again. Do not dereference an unavailable,
            // incompatible or out-of-range tank, or choose another one.
            for( const vpart_reference &part : target.veh->get_all_parts() ) {
                if( part.part_index() == static_cast<size_t>( *tank_part ) && part.part().is_available() &&
                    part.part().is_tank() && part.part().can_reload( liquid ) ) {
                    if( !who.pour_into( part, liquid ) ) {
                        return false;
                    }
                    if( charge_moves ) {
                        who.mod_moves( -1000 );
                    }
                    return true;
                }
            }
            return false;
        case LD_KEG:
        case LD_GROUND: {
            map &here = get_map();
            if( !here.inbounds( target.pos ) ||
                ( target.dest_opt == LD_KEG && !iexamine::has_keg( target.pos ) ) ||
                ( target.dest_opt == LD_GROUND && !here.can_put_items_ter_furn( target.pos ) ) ) {
                return false;
            }
            if( target.dest_opt == LD_KEG ) {
                iexamine::pour_into_keg( target.pos, liquid, silent );
            } else if( finite_water::can_pour_into( here.get_abs( target.pos ) ) ) {
                finite_water::pour_into_finite_water( here.get_abs( target.pos ), liquid );
            } else {
                here.add_item_or_charges( target.pos, liquid );
                liquid.charges = 0;
            }
            if( charge_moves ) {
                who.mod_moves( -100 );
            }
            return true;
        }
        case LD_NULL:
        case LD_CONSUME:
        default:
            return false;
    }
}
} // namespace liquid_handler
