#include "item_insert.h"

#include "activity_actor_definitions.h"
#include "character.h"
#include "flag.h"
#include "item.h"
#include "item_pocket.h"
#include "json.h"
#include "mp_client_conn.h"
#include "mp_inventory_activity.h"
#include "ret_val.h"

void insert_selection::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "destination", destination );
    out.member( "items", items );
    out.member( "allow_nested", allow_nested );
    out.end_object();
}

void insert_selection::deserialize( const JsonObject &object )
{
    object.read( "destination", destination, true );
    object.read( "items", items, true );
    allow_nested = object.get_bool( "allow_nested", true );
}

insert_selection capture_insert_selection( const Character &who, const item_location &destination,
        const drop_locations &items, bool allow_nested )
{
    insert_selection result;
    result.destination = capture_item_source( who, destination );
    result.allow_nested = allow_nested;
    for( const drop_location &source : items ) {
        result.items.emplace_back( capture_item_source( who, source.first ), source.second );
    }
    return result;
}

namespace
{
bool needs_spill_selection( const Character &who, item_location container )
{
    while( container ) {
        if( container.where() != item_location::type::map && !who.is_wielding( *container ) ) {
            for( const item_pocket *pocket : container->get_container_pockets() ) {
                if( pocket->will_spill_if_unsealed() && !pocket->empty() ) {
                    return true;
                }
            }
        }
        container = container.has_parent() ? container.parent_item() : item_location::nowhere;
    }
    return false;
}
} // namespace

bool valid_insert_item( Character &who, item_location destination, item_location source )
{
    if( !destination || !source || destination == source ||
        destination.eventually_contains( source ) || source.eventually_contains( destination ) ||
        destination->has_flag( flag_NO_RELOAD ) || source->is_bucket_nonempty() ||
        ( !source.has_parent() && source->made_of( phase_id::LIQUID ) && !source->is_frozen_liquid() ) ||
        ( who.is_worn( *source ) && !who.can_takeoff( *source ).success() ) ) {
        return false;
    }
    // Native insertion has no explicit spill choice. Do not let a proxy NPC
    // silently discard liquid where the owner's avatar would ask for a target.
    if( ( destination->will_spill_if_unsealed() &&
          destination.where() != item_location::type::map && !who.is_wielding( *destination ) ) ||
        needs_spill_selection( who, destination ) ||
        ( source.has_parent() && needs_spill_selection( who, source.parent_item() ) ) ) {
        return false;
    }
    return true;
}

void start_item_insert( Character &who, const item_location &destination,
                        const drop_locations &items, bool reopen_menu, bool allow_nested, bool server_owned )
{
    if( who.is_avatar() && cata_mp::is_client_mode() && !server_owned ) {
        cata_mp::client_start_insert( capture_insert_selection( who, destination, items, allow_nested ) );
        return;
    }
    who.assign_activity( insert_item_activity_actor( destination, items, reopen_menu, allow_nested,
                         server_owned ) );
}
