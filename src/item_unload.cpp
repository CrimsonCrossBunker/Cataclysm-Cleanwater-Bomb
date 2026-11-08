#include "item_unload.h"

#include <algorithm>
#include <optional>
#include <utility>

#include "character.h"
#include "flag.h"
#include "item.h"
#include "item_pocket.h"
#include "pocket_type.h"
#include "safe_reference.h"

bool unload_ammo_pocket( Character &who, item &target, item_pocket &pocket,
                         const std::function<bool( item &, const item & )> &receive )
{
    const auto pockets = target.get_pockets( []( const item_pocket & p ) {
        return p.is_type( pocket_type::MAGAZINE );
    } );
    if( !receive || std::find( pockets.begin(), pockets.end(), &pocket ) == pockets.end() ) {
        return false;
    }

    const auto actor_lifetime = who.get_safe_reference();
    const auto target_lifetime = target.get_safe_reference();
    int moved = 0;
    std::optional<item> representative;
    bool complete = true;
    for( item *source : pocket.all_items_top() ) {
        if( source->has_flag( flag_CASING ) || !source->is_ammo() ) {
            continue;
        }
        const auto source_lifetime = source->get_safe_reference();
        const int quantity = source->count_by_charges() ? source->charges : 1;
        if( quantity <= 0 ) {
            continue;
        }
        item dropped = *source;
        if( target.is_filthy() ) {
            dropped.set_flag( flag_FILTHY );
        }
        const bool accepted = receive( dropped, *source );
        if( !actor_lifetime || !target_lifetime || !source_lifetime ) {
            return false;
        }
        const int transferred = accepted ? quantity : source->count_by_charges() ?
                                std::clamp( quantity - dropped.charges, 0, quantity ) : 0;
        if( transferred > 0 ) {
            moved += transferred;
            if( !representative ) {
                representative.emplace( std::move( dropped ) );
            }
            // Settle each transfer immediately: a later cancellation must not
            // leave a second copy of ammo already placed by the receiver.
            if( transferred == quantity ) {
                pocket.remove_item( *source );
            } else {
                source->charges -= transferred;
            }
        }
        if( !accepted ) {
            complete = false;
            break;
        }
    }
    if( moved > 0 ) {
        // item_reload_cost clamps to the supplied stack's charges. The stack
        // passed to the receiver may now be empty or only a partial remainder.
        representative->charges = moved;
        who.mod_moves( -who.item_reload_cost( target, *representative, moved ) / 2 );
        pocket.on_contents_changed();
        target.on_contents_changed();
        who.invalidate_weight_carried_cache();
    }
    return complete;
}
