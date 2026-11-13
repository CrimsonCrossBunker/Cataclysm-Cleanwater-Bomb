#include "item_source.h"

#include <algorithm>

#include "character.h"
#include "flag.h"
#include "game.h"
#include "item.h"
#include "item_location.h"
#include "item_pocket.h"
#include "item_uid.h"
#include "json.h"
#include "map.h"
#include "map_selector.h"
#include "vehicle_selector.h"
#include "vehicle.h"
#include "vpart_position.h"
#include "visitable.h"

void item_source::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "kind", kind );
    out.member( "position", position );
    out.member( "path", path );
    if( vehicle != 0 || cargo != 0 ) {
        out.member( "vehicle", vehicle );
        out.member( "cargo", cargo );
    }
    out.end_object();
}

void item_source::deserialize( const JsonObject &object )
{
    object.read( "kind", kind, true );
    object.read( "position", position, true );
    object.read( "path", path, true );
    vehicle = object.has_member( "vehicle" ) ? object.get_int64( "vehicle" ) : 0;
    cargo = object.has_member( "cargo" ) ? object.get_int64( "cargo" ) : 0;
}

item_location resolve_item_source( Character &who, map &here, const item_source &intent, int range )
{
    if( intent.path.empty() || intent.path.size() > 64 ) {
        return item_location();
    }
    const auto root_matches = [&]( const item & candidate ) {
        return candidate.uid().get_value() == intent.path.front();
    };
    item_location root;
    if( intent.kind == "carried" ) {
        const auto items = who.items_with( root_matches );
        if( items.size() == 1 && !who.find_parent( *items.front() ) ) {
            root = item_location( who, items.front() );
        }
    } else if( intent.kind == "map" ) {
        for( map_cursor &cursor : map_selector( who.pos_bub(), range ) ) {
            if( cursor.pos_abs() == intent.position ) {
                const auto items = cursor.items_with( root_matches );
                if( items.size() == 1 && !cursor.find_parent( *items.front() ) ) {
                    root = item_location( cursor, items.front() );
                }
            }
        }
    } else if( intent.kind == "vehicle" && ( intent.vehicle != 0 || intent.cargo != 0 ) ) {
        const tripoint_abs_ms origin = who.pos_abs();
        const int64_t dx = static_cast<int64_t>( intent.position.x() ) - origin.x();
        const int64_t dy = static_cast<int64_t>( intent.position.y() ) - origin.y();
        if( intent.vehicle <= 0 || intent.cargo <= 0 || intent.position.z() != origin.z() ||
            dx < -range || dx > range || dy < -range || dy > range || !here.inbounds( intent.position ) ) {
            return item_location();
        }
        const tripoint_bub_ms pos = here.get_bub( intent.position );
        const auto cargo = here.veh_at( pos ).cargo();
        if( !cargo || cargo->vehicle().uid().get_value() != intent.vehicle ||
            cargo->part().get_base().uid().get_value() != intent.cargo ||
            !cargo->part().is_available() || cargo->part().is_cleaner_on() ||
            ( pos != who.pos_bub( here ) && !here.clear_path( who.pos_bub( here ), pos, range, 1, 100 ) ) ) {
            return item_location();
        }
        for( item &entry : cargo->items() ) {
            if( root_matches( entry ) ) {
                if( root ) {
                    return item_location();
                }
                root = item_location( vehicle_cursor( cargo->vehicle(), cargo->part_index() ), &entry );
            }
        }
    } else if( intent.kind == "vehicle" ) {
        for( vehicle_cursor &cursor : vehicle_selector( here, who.pos_bub(), range ) ) {
            const auto items = cursor.items_with( root_matches );
            if( items.size() == 1 && !cursor.find_parent( *items.front() ) ) {
                item_location candidate( cursor, items.front() );
                if( here.get_abs( candidate.pos_bub( here ) ) == intent.position ) {
                    root = candidate;
                }
            }
        }
    }
    for( size_t index = 1; root && index < intent.path.size(); ++index ) {
        item *child = nullptr;
        for( item *candidate : root->all_items_top() ) {
            if( candidate->uid().get_value() == intent.path[index] ) {
                if( child ) {
                    return item_location();
                }
                child = candidate;
            }
        }
        root = child ? item_location( root, child ) : item_location();
    }
    return root;
}

item_location resolve_furniture_item( map &here, const tripoint_abs_ms &position, int64_t uid )
{
    const tripoint_bub_ms tile = here.get_bub( position );
    if( uid <= 0 || !here.has_loaded_submap( tile ) || !here.has_furn( tile ) ) {
        return {};
    }
    for( item &entry : here.i_at( tile ) ) {
        if( entry.uid().get_value() == uid ) {
            return item_location( map_cursor( position ), &entry );
        }
    }
    return {};
}

item_location locate_item_with_parents( item_location location )
{
    if( !location || location.has_parent() ) {
        return location;
    }
    item *target = location.get_item();
    const auto in = [&]( auto &&owner ) -> item_location {
        if( !owner.has_item( *target ) )
        {
            return {};
        }
        const std::vector<item *> parents = owner.parents( *target );
        if( parents.empty() )
        {
            return location;
        }
        item_location result( owner, parents.back() );
        for( auto it = parents.rbegin() + 1; it != parents.rend(); ++it )
        {
            result = item_location( result, *it );
        }
        return item_location( result, target );
    };
    if( Character *carrier = location.carrier() ) {
        return in( *carrier );
    }
    if( const vehicle_cursor *cursor = location.veh_cursor() ) {
        return in( *cursor );
    }
    if( location.where() == item_location::type::map ) {
        return in( map_cursor( location.pos_abs() ) );
    }
    return location;
}

item_source capture_item_source( const Character &who, item_location source )
{
    item_source intent;
    while( source ) {
        intent.path.push_back( source->uid().get_value() );
        if( !source.has_parent() ) {
            break;
        }
        source = source.parent_item();
    }
    std::reverse( intent.path.begin(), intent.path.end() );
    if( source ) {
        intent.kind = source.held_by( who ) ? "carried" :
                      source.where() == item_location::type::map ? "map" :
                      source.where() == item_location::type::vehicle ? "vehicle" : "invalid";
        intent.position = get_map().get_abs( source.pos_bub( get_map() ) );
        if( intent.kind == "vehicle" ) {
            if( const vehicle_cursor *cursor = source.veh_cursor() ) {
                const auto cargo = get_map().veh_at( source.pos_bub( get_map() ) ).cargo();
                if( cargo && &cargo->vehicle() == &cursor->veh && cursor->part >= 0 &&
                    cargo->part_index() == static_cast<size_t>( cursor->part ) ) {
                    intent.vehicle = cargo->vehicle().uid().get_value();
                    intent.cargo = cargo->part().get_base().uid().get_value();
                }
            }
        }
    }
    return intent;
}

bool can_remove_from_item_pockets( const Character &who, item_location source )
{
    while( source.has_parent() ) {
        const item_pocket *pocket = source.parent_pocket();
        source = source.parent_item();
        if( !source || !pocket || source->has_flag( flag_NO_UNLOAD ) ||
            ( pocket->will_spill_if_unsealed() && source.where_recursive() != item_location::type::map &&
              !who.is_wielding( *source ) ) ) {
            return false;
        }
    }
    return true;
}
