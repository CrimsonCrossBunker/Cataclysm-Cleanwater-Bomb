#include "hauling.h"

#include <algorithm>
#include <set>
#include <utility>

#include "activity_handlers.h"
#include "character.h"
#include "flag.h"
#include "item.h"
#include "item_location.h"
#include "item_uid.h"
#include "json.h"
#include "map.h"
#include "mapdata.h"
#include "vpart_position.h"

void haul_item_selection::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "source", source );
    out.member( "quantity", quantity );
    out.end_object();
}

void haul_item_selection::deserialize( const JsonObject &data )
{
    data.read( "source", source, true );
    data.read( "quantity", quantity, true );
}

void hauling_selection::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "action", action );
    out.member( "position", position );
    out.member( "items", items );
    out.member( "enable_autohaul", enable_autohaul );
    out.member( "filter", filter );
    out.end_object();
}

void hauling_selection::deserialize( const JsonObject &data )
{
    data.read( "action", action, true );
    data.read( "position", position, true );
    data.read( "items", items );
    data.read( "enable_autohaul", enable_autohaul );
    data.read( "filter", filter );
}

bool execute_hauling( Character &who, map &here, const hauling_selection &choice )
{
    if( who.activity || who.pos_abs() != choice.position ) {
        return false;
    }
    if( choice.action == "stop" ) {
        who.stop_hauling();
        return true;
    }
    if( choice.action == "filter" ) {
        if( choice.filter.size() > 4096 ) {
            return false;
        }
        who.hauling_filter = choice.filter;
        return true;
    }
    if( choice.action == "autohaul" && !choice.enable_autohaul ) {
        who.stop_autohaul();
        return true;
    }
    if( who.get_moves() <= 0 || who.is_mounted() ||
        who.has_active_mutation( trait_id( "SHELL2" ) ) ||
        who.has_active_mutation( trait_id( "SHELL3" ) ) ||
        who.has_flag( json_character_flag( "TEMPORARY_SHAPESHIFT_NO_HANDS" ) ) ||
        here.veh_at( who.pos_bub() ) ||
        here.has_flag( ter_furn_flag::TFLAG_DEEP_WATER, who.pos_bub() ) ||
        !here.can_put_items( who.pos_bub() ) || here.impassable_field_at( who.pos_bub() ) ) {
        return false;
    }
    if( choice.action == "autohaul" ) {
        who.start_autohaul();
        return true;
    }
    if( choice.action != "all" && choice.action != "select" ) {
        return false;
    }
    std::vector<item_location> available = here.get_haulable_items( who.pos_bub() );
    available.erase( std::remove_if( available.begin(),
    available.end(), [&]( const item_location & loc ) {
        return activity_handlers::activity_item_reserved_for_other( *loc, who );
    } ), available.end() );
    std::vector<item_location> selected;
    if( choice.action == "all" ) {
        if( available.empty() ) {
            return false;
        }
        selected = available;
    } else {
        if( choice.items.size() > available.size() ) {
            return false;
        }
        std::set<int64_t> unique;
        // Validate the entire selection before splitting any stack. In particular,
        // duplicate IDs cannot split the same source twice or exceed its quantity.
        for( const haul_item_selection &entry : choice.items ) {
            if( entry.source.kind != "map" || entry.source.path.size() != 1 ||
                entry.source.position != choice.position || entry.quantity <= 0 ||
                !unique.insert( entry.source.path.front() ).second ) {
                return false;
            }
            const item_location source = resolve_item_source( who, here, entry.source, 0 );
            if( !source || std::find( available.begin(), available.end(), source ) == available.end() ||
                entry.quantity > ( source->count_by_charges() ? source->charges : 1 ) ) {
                return false;
            }
            selected.push_back( source );
        }
        std::vector<std::pair<item_location, item_location>> split_stacks;
        for( size_t i = 0; i < selected.size(); ++i ) {
            const int count = choice.items[i].quantity;
            if( selected[i]->count_by_charges() && count < selected[i]->charges ) {
                item_location split = selected[i].split_stack( count );
                if( !split ) {
                    // Restore prior splits if the map cannot accept another stack.
                    // Never silently haul more than the selected quantity.
                    for( auto &previous : split_stacks ) {
                        previous.first->charges += previous.second->charges;
                        previous.second.remove_item();
                    }
                    return false;
                }
                split_stacks.emplace_back( selected[i], split );
                selected[i] = split;
            }
        }
        if( selected != who.haul_list ) {
            who.suppress_autohaul = true;
        }
    }
    who.start_hauling( selected );
    if( choice.enable_autohaul ) {
        who.start_autohaul();
    }
    return true;
}
