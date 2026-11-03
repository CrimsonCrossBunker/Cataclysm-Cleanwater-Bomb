#include "item_source.h"

#include <algorithm>

#include "character.h"
#include "game.h"
#include "item.h"
#include "item_location.h"
#include "item_uid.h"
#include "json.h"
#include "map.h"
#include "map_selector.h"
#include "vehicle_selector.h"
#include "visitable.h"

void item_source::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "kind", kind );
    out.member( "position", position );
    out.member( "path", path );
    out.end_object();
}

void item_source::deserialize( const JsonObject &object )
{
    object.read( "kind", kind, true );
    object.read( "position", position, true );
    object.read( "path", path, true );
}

item_location resolve_item_source( Character &who, map &here, const item_source &intent )
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
        for( map_cursor &cursor : map_selector( who.pos_bub(), 1 ) ) {
            if( cursor.pos_abs() == intent.position ) {
                const auto items = cursor.items_with( root_matches );
                if( items.size() == 1 && !cursor.find_parent( *items.front() ) ) {
                    root = item_location( cursor, items.front() );
                }
            }
        }
    } else if( intent.kind == "vehicle" ) {
        for( vehicle_cursor &cursor : vehicle_selector( here, who.pos_bub(), 1 ) ) {
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
    }
    return intent;
}
