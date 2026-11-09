#include "zone_edit.h"

#include <stddef.h>
#include <unordered_map>
#include <algorithm>
#include <set>
#include <sstream>
#include <tuple>
#include <utility>

#include "character.h"
#include "construction.h"
#include "debug.h"
#include "item_group.h"
#include "itype.h"
#include "json_loader.h"
#include "mp_client_conn.h"
#include "map_scale_constants.h"
#include "json.h"
#include "map.h"
#include "vehicle.h"
#include "vpart_position.h"
#include "vpart_range.h"
#include "character_id.h"
#include "clzones.h"
#include "coordinates.h"
#include "flexbuffer_json.h"
#include "item.h"
#include "item_uid.h"
#include "memory_fast.h"
#include "player_activity.h"
#include "safe_reference.h"
#include "value_ptr.h"
#include "vehicle_uid.h"

static const zone_type_id zone_type_CONSTRUCTION_BLUEPRINT( "CONSTRUCTION_BLUEPRINT" );
static const zone_type_id zone_type_FARM_PLOT( "FARM_PLOT" );
static const zone_type_id zone_type_LOOT_ITEM_GROUP( "LOOT_ITEM_GROUP" );

zone_edit_definition zone_edit_definition::capture( const zone_data &zone )
{
    zone_edit_definition result;
    result.name = zone.get_name();
    result.type = zone.get_type();
    result.enabled = zone.get_enabled();
    result.displayed = zone.get_is_displayed();
    result.personal = zone.get_is_personal();
    result.invert = zone.get_invert();
    result.vehicle_bound = zone.get_is_vehicle();
    result.start = result.personal ? zone.get_personal_start_point().raw() :
                   zone.get_start_point().raw();
    result.end = result.personal ? zone.get_personal_end_point().raw() : zone.get_end_point().raw();
    std::ostringstream stream;
    JsonOut out( stream );
    out.start_object();
    zone.get_options().serialize( out );
    out.end_object();
    result.options = stream.str();
    if( zone.get_is_vehicle() ) {
        if( const ::vehicle *owner = zone.get_vehicle_owner().get() ) {
            for( const auto &entry : owner->loot_zones ) {
                if( &entry.second == &zone ) {
                    const int cargo = owner->part_with_feature( entry.first, "CARGO", false );
                    if( cargo >= 0 ) {
                        result.vehicle = owner->uid().get_value();
                        result.part = owner->part( cargo ).get_base().uid().get_value();
                    }
                    break;
                }
            }
        }
    }
    return result;
}

bool zone_edit_definition::operator==( const zone_edit_definition &other ) const
{
    return std::tie( name, type, enabled, displayed, personal, invert, vehicle_bound, start, end,
                     options, vehicle, part ) ==
           std::tie( other.name, other.type, other.enabled, other.displayed, other.personal, other.invert,
                     other.vehicle_bound, other.start, other.end, other.options, other.vehicle, other.part );
}

bool zone_edit_definition::operator!=( const zone_edit_definition &other ) const
{
    return !( *this == other );
}

void zone_edit_definition::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "name", name );
    out.member( "type", type );
    out.member( "enabled", enabled );
    out.member( "displayed", displayed );
    out.member( "personal", personal );
    out.member( "invert", invert );
    out.member( "vehicle_bound", vehicle_bound );
    out.member( "start", start );
    out.member( "end", end );
    out.member( "options", options );
    out.member( "vehicle", vehicle );
    out.member( "part", part );
    out.end_object();
}

void zone_edit_definition::deserialize( const JsonObject &data )
{
    data.read( "name", name, true );
    data.read( "type", type, true );
    data.read( "enabled", enabled, true );
    data.read( "displayed", displayed, true );
    data.read( "personal", personal, true );
    data.read( "invert", invert, true );
    data.read( "vehicle_bound", vehicle_bound, true );
    data.read( "start", start, true );
    data.read( "end", end, true );
    data.read( "options", options, true );
    data.read( "vehicle", vehicle, true );
    data.read( "part", part, true );
    if( name.size() > 256 || options.size() > 65536 ) {
        data.throw_error( "Zone edit value exceeds its size limit" );
    }
}

void zone_edit_change::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "identity", identity );
    out.member( "before", before );
    out.member( "after", after );
    out.end_object();
}

void zone_edit_change::deserialize( const JsonObject &data )
{
    data.read( "identity", identity, true );
    data.read( "before", before, true );
    data.read( "after", after, true );
}

bool zone_edit_batch::empty() const
{
    return changes.empty() && expected_order == order;
}

void zone_edit_batch::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "faction", faction );
    out.member( "changes", changes );
    out.member( "expected_order", expected_order );
    out.member( "order", order );
    out.end_object();
}

void zone_edit_batch::deserialize( const JsonObject &data )
{
    if( data.get_array( "changes" ).size() > 4096 ||
        data.get_array( "expected_order" ).size() > 4096 || data.get_array( "order" ).size() > 4096 ) {
        data.throw_error( "Too many zone edits" );
    }
    data.read( "faction", faction, true );
    data.read( "changes", changes, true );
    data.read( "expected_order", expected_order, true );
    data.read( "order", order, true );
}

zone_edit_session::zone_edit_session( const Character &who, const faction_id &selected_faction ) :
    faction( selected_faction ), query( zone_query_context::for_character( who, who.pos_abs() ) )
{
}

zone_edit_session::zone_edit_session( const Character &who, zone_manager &manager,
                                      const std::optional<faction_id> &selected_faction ) :
    zone_edit_session( who, selected_faction.value_or( who.get_faction_id() ) )
{
    std::vector<zone_data *> visible;
    visible.reserve( manager.zones.size() );
    for( zone_data &zone : manager.zones ) {
        visible.push_back( &zone );
    }
    for( zone_data *zone : get_map().get_vehicle_zones( who.pos_abs().z() ) ) {
        visible.push_back( zone );
    }
    for( const zone_data *entry : visible ) {
        const zone_data &zone = *entry;
        if( zone.get_faction() != faction || !zone.matches_query( query ) ) {
            continue;
        }
        originals.push_back( { zone.get_identity(), zone_edit_definition::capture( zone ), std::nullopt } );
        const zone_edit_definition &before = *originals.back().before;
        bindings.emplace( zone.get_identity(), std::make_pair( before.vehicle, before.part ) );
        if( !zone.get_is_vehicle() ) {
            original_order.push_back( zone.get_identity() );
        }
        drafts.push_back( zone.make_edit_draft() );
        drafts.back().update_cached_shift( query.origin );
    }
}

std::vector<zone_manager::ref_zone_data> zone_edit_session::get_zones()
{
    std::vector<zone_manager::ref_zone_data> result;
    result.reserve( drafts.size() );
    for( zone_data &zone : drafts ) {
        result.emplace_back( zone );
    }
    return result;
}

zone_data &zone_edit_session::add( const zone_data &zone, int64_t vehicle, int64_t part )
{
    // Layout duplication creates a new logical zone, even if the source was a draft.
    zone_data draft = zone.make_edit_draft();
    draft.identity = zone_data::new_identity();
    draft.faction = faction;
    draft.personal_owner = draft.is_personal ? query.owner : character_id();
    draft.update_cached_shift( query.origin );
    draft.is_vehicle = vehicle != 0;
    bindings.emplace( draft.identity, std::make_pair( vehicle, part ) );
    const auto position = draft.is_vehicle ? drafts.end() :
    std::find_if( drafts.begin(), drafts.end(), []( const zone_data & entry ) {
        return entry.get_is_vehicle();
    } );
    return *drafts.insert( position, std::move( draft ) );
}

bool zone_edit_session::remove( const zone_data &zone )
{
    const auto found = std::find_if( drafts.begin(), drafts.end(), [&]( const zone_data & entry ) {
        return &entry == &zone;
    } );
    if( found == drafts.end() ) {
        return false;
    }
    bindings.erase( found->get_identity() );
    drafts.erase( found );
    return true;
}

bool zone_edit_session::swap( zone_data &a, zone_data &b )
{
    if( a.get_is_vehicle() || b.get_is_vehicle() ) {
        return false;
    }
    const auto owns = [&]( const zone_data & zone ) {
        return std::any_of( drafts.begin(), drafts.end(), [&]( const zone_data & entry ) {
            return &entry == &zone;
        } );
    };
    if( !owns( a ) || !owns( b ) ) {
        return false;
    }
    std::swap( a, b );
    return true;
}

bool zone_edit_session::has_near( const zone_type_id &type, const tripoint_abs_ms &where,
                                  int range ) const
{
    if( range < 0 ) {
        return false;
    }
    for( const zone_data &zone : drafts ) {
        if( !zone.get_enabled() || zone.get_type() != type || !zone.matches_query( query ) ) {
            continue;
        }
        const auto bounds = zone.query_bounds( query );
        if( where.z() >= bounds.first.z() && where.z() <= bounds.second.z() &&
            static_cast<int64_t>( where.x() ) + range >= bounds.first.x() &&
            static_cast<int64_t>( where.x() ) - range <= bounds.second.x() &&
            static_cast<int64_t>( where.y() ) + range >= bounds.first.y() &&
            static_cast<int64_t>( where.y() ) - range <= bounds.second.y() ) {
            return true;
        }
    }
    return false;
}

zone_edit_batch zone_edit_session::finish() const
{
    zone_edit_batch result;
    result.faction = faction;
    result.expected_order = original_order;
    // Original identities retain their position in the delta independently of UI ordering.
    for( const zone_edit_change &original : originals ) {
        const auto draft = std::find_if( drafts.begin(), drafts.end(), [&]( const zone_data & zone ) {
            return zone.get_identity() == original.identity;
        } );
        if( draft == drafts.end() ) {
            result.changes.push_back( original );
        }
    }
    for( const zone_data &draft : drafts ) {
        const auto original = std::find_if( originals.begin(),
        originals.end(), [&]( const zone_edit_change & entry ) {
            return entry.identity == draft.get_identity();
        } );
        zone_edit_change change;
        change.identity = draft.get_identity();
        if( original != originals.end() ) {
            change.before = original->before;
        }
        change.after = zone_edit_definition::capture( draft );
        const auto binding = bindings.find( change.identity );
        if( binding != bindings.end() ) {
            change.after->vehicle = binding->second.first;
            change.after->part = binding->second.second;
        }
        if( !change.before || *change.before != *change.after ) {
            result.changes.push_back( std::move( change ) );
        }
        if( !draft.get_is_vehicle() ) {
            result.order.push_back( draft.get_identity() );
        }
    }
    return result;
}

namespace
{
// These bounds apply to new choices, not to unchanged legacy zone geometry.
constexpr size_t maximum_zone_edits = 4096;
constexpr size_t maximum_zone_options = 65536;

shared_ptr_fast<zone_options> read_edit_options( const zone_edit_definition &definition )
{
    if( definition.options.size() > maximum_zone_options ) {
        return nullptr;
    }
    try {
        const JsonObject object = json_loader::from_string( definition.options ).get_object();
        auto options = zone_options::create( definition.type );
        std::set<std::string> strings;
        std::set<std::string> booleans;
        std::set<std::string> extra;
        if( dynamic_cast<plot_options *>( options.get() ) ) {
            strings = { "mark", "seed", "fertilizer" };
            for( const std::string &key : strings ) {
                const itype_id id( object.get_string( key ) );
                if( !id.is_null() && !id.is_valid() ) {
                    return nullptr;
                }
            }
            const itype_id seed( object.get_string( "seed" ) );
            if( !seed.is_null() && !seed->seed ) {
                return nullptr;
            }
        } else if( dynamic_cast<blueprint_options *>( options.get() ) ) {
            strings = { "mark", "group", "index" };
            const construction_str_id construction( object.get_string( "index" ) );
            const construction_group_str_id group( object.get_string( "group" ) );
            if( !construction.is_valid() || !group.is_valid() || construction->group != group ||
                construction->post_terrain != object.get_string( "mark" ) ) {
                return nullptr;
            }
        } else if( dynamic_cast<loot_options *>( options.get() ) ) {
            strings = { "mark" };
            if( definition.type == zone_type_LOOT_ITEM_GROUP &&
                !item_group::group_is_defined( item_group_id( object.get_string( "mark" ) ) ) ) {
                return nullptr;
            }
        } else if( dynamic_cast<unload_options *>( options.get() ) ) {
            strings = { "mark" };
            booleans = { "mods", "molle", "sparse_only", "always_unload" };
            extra = { "sparse_threshold" };
            const int threshold = object.get_int( "sparse_threshold" );
            if( threshold < 0 || threshold > 1000000 ) {
                return nullptr;
            }
        } else if( dynamic_cast<study_zone_options *>( options.get() ) ) {
            extra = { "npc_skill_preferences", "character_skill_preferences" };
            size_t names = 0;
            for( const std::string &field : extra ) {
                if( !object.has_member( field ) ) {
                    continue; // Legacy saves have only name preferences.
                }
                const JsonObject preferences = object.get_object( field );
                for( const JsonMember &member : preferences ) {
                    if( ++names > 256 || member.name().size() > 256 ) {
                        return nullptr;
                    }
                    const JsonArray skills = preferences.get_array( member.name() );
                    if( skills.size() > 256 ) {
                        return nullptr;
                    }
                    for( const JsonValue &value : skills ) {
                        if( !skill_id( value.get_string() ).is_valid() ) {
                            return nullptr;
                        }
                    }
                }
            }
        } else if( dynamic_cast<ignorable_options *>( options.get() ) ) {
            booleans = { "ignore_contents" };
        }
        for( const std::string &key : strings ) {
            if( object.get_string( key ).size() > 4096 ) {
                return nullptr;
            }
        }
        for( const std::string &key : booleans ) {
            object.get_bool( key );
        }
        for( const JsonMember &member : object ) {
            const std::string key = member.name();
            if( strings.count( key ) == 0 && booleans.count( key ) == 0 && extra.count( key ) == 0 ) {
                return nullptr;
            }
        }
        options->deserialize( object );
        return options;
    } catch( const JsonError & ) {
        return nullptr;
    }
}

bool bounded_edit_geometry( const Character &who, const zone_edit_definition &definition )
{
    const tripoint origin = definition.personal ? tripoint::zero : who.pos_abs().raw();
    const auto in_bounds = [&]( const tripoint & point ) {
        const int64_t z = definition.personal ? static_cast<int64_t>( point.z ) + who.pos_abs().z() :
                          point.z;
        return static_cast<int64_t>( point.x ) >= static_cast<int64_t>( origin.x ) - MAX_VIEW_DISTANCE &&
               static_cast<int64_t>( point.x ) <= static_cast<int64_t>( origin.x ) + MAX_VIEW_DISTANCE &&
               static_cast<int64_t>( point.y ) >= static_cast<int64_t>( origin.y ) - MAX_VIEW_DISTANCE &&
               static_cast<int64_t>( point.y ) <= static_cast<int64_t>( origin.y ) + MAX_VIEW_DISTANCE &&
               z >= -OVERMAP_DEPTH && z <= OVERMAP_HEIGHT;
    };
    // Native zone overlays and menus describe a single floor.
    return definition.start.x <= definition.end.x && definition.start.y <= definition.end.y &&
           definition.start.z == definition.end.z && in_bounds( definition.start ) &&
           in_bounds( definition.end );
}

vehicle *resolve_zone_vehicle( const zone_edit_definition &definition, const faction_id &faction,
                               point_rel_ms *mount = nullptr )
{
    if( !definition.vehicle_bound || definition.personal || definition.vehicle <= 0 ||
        definition.part <= 0 ||
        definition.start != definition.end ) {
        return nullptr;
    }
    map &here = get_map();
    const tripoint_abs_ms position( definition.start );
    if( !here.inbounds( position ) ) {
        return nullptr;
    }
    vehicle *owner = vehicle::find_vehicle_by_uid( here, definition.vehicle );
    if( !owner || owner->get_owner() != faction ) {
        return nullptr;
    }
    for( const vpart_reference &part : owner->get_all_parts() ) {
        if( part.has_feature( "CARGO" ) && part.part().get_base().uid().get_value() == definition.part &&
            owner->abs_part_pos( part.part() ) == position ) {
            if( mount ) {
                *mount = part.mount_pos();
            }
            return owner;
        }
    }
    return nullptr;
}
} // namespace

bool zone_edit_session::apply( Character &who, zone_manager &manager, const zone_edit_batch &batch )
{
    if( cata_mp::is_client_mode() || who.is_dead_state() || who.activity ||
        batch.changes.size() > maximum_zone_edits || batch.order.size() > maximum_zone_edits ||
        batch.expected_order.size() > maximum_zone_edits ) {
        return false;
    }
    const bool local_debug = who.is_avatar() && debug_mode;
    const faction_id faction = batch.faction;
    if( faction != who.get_faction_id() && !local_debug ) {
        return false;
    }
    const zone_query_context query = zone_query_context::for_character( who, who.pos_abs() );
    const auto editable = [&]( const zone_data & zone ) {
        return zone.get_faction() == faction && zone.matches_query( query );
    };
    // Inspect identities across native containers, including zones not owned by this player.
    std::map<std::string, zone_data *> live;
    std::vector<zone_data *> all;
    all.reserve( manager.zones.size() );
    for( zone_data &zone : manager.zones ) {
        all.push_back( &zone );
    }
    map &here = get_map();
    for( int z = -OVERMAP_DEPTH; z <= OVERMAP_HEIGHT; ++z ) {
        for( zone_data *zone : here.get_vehicle_zones( z ) ) {
            all.push_back( zone );
        }
    }
    for( zone_data *zone : all ) {
        if( !zone_data::valid_identity( zone->identity ) ) {
            return false;
        }
        const auto inserted = live.emplace( zone->identity, zone );
        if( !inserted.second && inserted.first->second != zone ) {
            return false;
        }
    }
    std::vector<std::string> current_order;
    for( const zone_data &zone : manager.zones ) {
        if( editable( zone ) ) {
            current_order.push_back( zone.identity );
        }
    }
    if( current_order != batch.expected_order ) {
        return false;
    }
    if( batch.empty() ) {
        return true;
    }

    std::set<std::string> changed;
    std::set<std::string> changed_identities;
    int64_t geometry_budget = 1024 * 1024;
    std::map<std::string, zone_data> prepared;
    std::map<std::string, std::pair<vehicle *, point_rel_ms>> vehicle_targets;
    std::set<std::string> resulting_ids( current_order.begin(), current_order.end() );
    for( const zone_edit_change &change : batch.changes ) {
        if( !zone_data::valid_identity( change.identity ) || !changed.insert( change.identity ).second ||
            ( !change.before && !change.after ) ) {
            return false;
        }
        const auto found = live.find( change.identity );
        if( change.before ) {
            if( found == live.end() || !editable( *found->second ) ||
                zone_edit_definition::capture( *found->second ) != *change.before ) {
                return false;
            }
            if( change.before->vehicle_bound && !resolve_zone_vehicle( *change.before, faction ) ) {
                return false;
            }
            if( !local_debug && change.before->type.is_valid() && change.before->type->hidden ) {
                return false;
            }
        } else if( found != live.end() ) {
            return false;
        }
        if( !change.after ) {
            resulting_ids.erase( change.identity );
            continue;
        }
        const zone_edit_definition &definition = *change.after;
        if( definition.name.empty() || definition.name.size() > 256 || !definition.type.is_valid() ||
            ( !local_debug && definition.type->hidden ) ||
            ( definition.personal && !definition.type->can_be_personal ) ||
            ( !definition.vehicle_bound && ( definition.vehicle != 0 || definition.part != 0 ) ) ||
            ( change.before && ( definition.personal != change.before->personal ||
                                 definition.vehicle_bound != change.before->vehicle_bound ||
                                 definition.invert != change.before->invert ) ) ||
            ( !change.before && definition.invert ) ) {
            return false;
        }
        const bool geometry_changed = !change.before || definition.start != change.before->start ||
                                      definition.end != change.before->end;
        const bool display_changed = !change.before || definition.displayed != change.before->displayed ||
                                     ( definition.displayed && definition.type != change.before->type );
        if( ( geometry_changed || display_changed ) && !bounded_edit_geometry( who, definition ) ) {
            return false;
        }
        if( geometry_changed || display_changed ) {
            geometry_budget -= ( static_cast<int64_t>( definition.end.x ) - definition.start.x + 1 ) *
                               ( static_cast<int64_t>( definition.end.y ) - definition.start.y + 1 );
            if( geometry_budget < 0 ) {
                return false;
            }
        }
        if( definition.vehicle_bound ) {
            if( ( definition.displayed && ( !change.before || !change.before->displayed ) ) ||
                ( ( !change.before || definition.type != change.before->type ) &&
                  ( definition.type == zone_type_FARM_PLOT ||
                    definition.type == zone_type_CONSTRUCTION_BLUEPRINT ) ) ) {
                return false;
            }
            point_rel_ms mount;
            vehicle *owner = resolve_zone_vehicle( definition, faction, &mount );
            if( !owner || ( change.before && ( definition.vehicle != change.before->vehicle ||
                                               definition.part != change.before->part || geometry_changed ) ) ) {
                return false;
            }
            vehicle_targets.emplace( change.identity, std::make_pair( owner, mount ) );
        } else if( !change.before ) {
            resulting_ids.insert( change.identity );
        }
        const auto options = change.before && definition.type == change.before->type &&
                             definition.options == change.before->options ? found->second->options :
                             read_edit_options( definition );
        if( !options ) {
            return false;
        }
        zone_data result = definition.personal ?
                           zone_data( definition.name, definition.type, faction, definition.invert, definition.enabled,
                                      tripoint_rel_ms( definition.start ), tripoint_rel_ms( definition.end ), options,
                                      definition.displayed ) :
                           zone_data( definition.name, definition.type, faction, definition.invert, definition.enabled,
                                      tripoint_abs_ms( definition.start ), tripoint_abs_ms( definition.end ), options,
                                      definition.displayed );
        // New identities are assigned by the authority. The draft identity is only
        // a transaction-local reference used to order newly created zones.
        result.identity = change.before ? change.identity : zone_data::new_identity();
        changed_identities.insert( result.identity );
        result.personal_owner = definition.personal ? who.getID() : character_id();
        result.cached_shift = who.pos_abs();
        result.is_vehicle = definition.vehicle_bound;
        if( change.before ) {
            // In-place edits retain native handles. Removal/recreation never does.
            result.lifetime_identity = found->second->lifetime_identity;
            result.temporarily_disabled = found->second->temporarily_disabled;
        }
        prepared.emplace( change.identity, std::move( result ) );
    }
    const std::set<std::string> requested_order( batch.order.begin(), batch.order.end() );
    if( requested_order.size() != batch.order.size() || requested_order != resulting_ids ) {
        return false;
    }

    // Prepare the replacement static vector before changing either native container.
    std::vector<zone_data> replacement;
    std::map<std::string, zone_data> ordered;
    std::vector<zone_data> erase_display;
    for( const zone_data &zone : manager.zones ) {
        if( !editable( zone ) ) {
            continue;
        }
        const auto update = prepared.find( zone.identity );
        if( changed.count( zone.identity ) == 0 ) {
            ordered.emplace( zone.identity, zone );
        } else if( update != prepared.end() ) {
            ordered.emplace( zone.identity, update->second );
        }
        if( changed.count( zone.identity ) != 0 && zone.is_displayed ) {
            erase_display.push_back( zone );
        }
    }
    for( const auto &entry : prepared ) {
        if( !entry.second.is_vehicle && live.count( entry.first ) == 0 ) {
            ordered.emplace( entry.first, entry.second );
        }
    }
    auto next = batch.order.begin();
    for( const zone_data &zone : manager.zones ) {
        if( !editable( zone ) ) {
            replacement.push_back( zone );
        } else if( next != batch.order.end() ) {
            replacement.push_back( ordered.at( *next++ ) );
        }
    }
    while( next != batch.order.end() ) {
        replacement.push_back( ordered.at( *next++ ) );
    }

    // No prompts or gameplay callbacks occur during native container installation.
    for( const zone_edit_change &change : batch.changes ) {
        if( change.before && change.before->vehicle_bound ) {
            zone_data *zone = live.at( change.identity );
            if( !change.after ) {
                here.deregister_vehicle_zone( *zone );
            } else {
                *zone = prepared.at( change.identity );
                zone->set_vehicle_owner( *vehicle_targets.at( change.identity ).first );
            }
            vehicle *owner = vehicle::find_vehicle_by_uid( here, change.before->vehicle );
            owner->zones_dirty = true;
        } else if( !change.before && change.after && change.after->vehicle_bound ) {
            const auto &target = vehicle_targets.at( change.identity );
            vehicle *owner = target.first;
            zone_data zone = prepared.at( change.identity );
            zone.set_vehicle_owner( *owner );
            owner->loot_zones.emplace( target.second, std::move( zone ) );
            owner->zones_dirty = true;
            here.register_vehicle_zone( owner, who.pos_abs().z() );
        }
    }
    manager.zones = std::move( replacement );
    manager.num_personal_zones = std::count_if( manager.zones.begin(), manager.zones.end(),
    []( const zone_data & zone ) {
        return zone.is_personal;
    } );
    manager.cache_data();
    manager.cache_vzones();

    // Keep presentation effects after the atomic state installation. Copy records before
    // loading overlay submaps, which can invalidate map/zone references through mapgen.
    std::vector<zone_data> redraw;
    for( const zone_data &zone : manager.zones ) {
        if( !zone.is_displayed ) {
            continue;
        }
        const bool overlap = std::any_of( erase_display.begin(), erase_display.end(),
        [&]( const zone_data & old ) {
            return zone.type == old.type && zone.get_start_point().z() == old.get_start_point().z() &&
                   zone.get_start_point().x() <= old.get_end_point().x() &&
                   old.get_start_point().x() <= zone.get_end_point().x() &&
                   zone.get_start_point().y() <= old.get_end_point().y() &&
                   old.get_start_point().y() <= zone.get_end_point().y();
        } );
        if( changed_identities.count( zone.identity ) != 0 || overlap ) {
            redraw.push_back( zone );
        }
    }
    for( zone_data &old : erase_display ) {
        old.is_displayed = false;
        old.refresh_display();
    }
    for( const zone_data &zone : redraw ) {
        zone.refresh_display();
    }
    return true;
}

void zone_edit_session::write_view( JsonOut &out ) const
{
    out.start_object();
    out.member( "faction", faction );
    out.member( "entries", originals );
    out.end_object();
}

std::shared_ptr<zone_edit_session> zone_edit_session::read_view( const Character &who,
        const JsonObject &data )
{
    faction_id faction;
    data.read( "faction", faction, true );
    if( faction != who.get_faction_id() ) {
        return nullptr;
    }
    auto result = std::shared_ptr<zone_edit_session>( new zone_edit_session( who, faction ) );
    if( data.get_array( "entries" ).size() > maximum_zone_edits ) {
        return nullptr;
    }
    std::vector<zone_edit_change> entries;
    data.read( "entries", entries, true );
    if( entries.size() > maximum_zone_edits ) {
        return nullptr;
    }
    std::set<std::string> identities;
    for( const zone_edit_change &entry : entries ) {
        if( !zone_data::valid_identity( entry.identity ) || !identities.insert( entry.identity ).second ||
            !entry.before || entry.after || !entry.before->type.is_valid() ||
            entry.before->options.size() > maximum_zone_options ) {
            return nullptr;
        }
        const zone_edit_definition &definition = *entry.before;
        // This is a server view, not a client command. Preserve readable legacy options
        // without running callbacks, creating world zones or expanding area caches.
        auto options = zone_options::create( definition.type );
        options->deserialize( json_loader::from_string( definition.options ).get_object() );
        zone_data zone = definition.personal ?
                         zone_data( definition.name, definition.type, faction, definition.invert, definition.enabled,
                                    tripoint_rel_ms( definition.start ), tripoint_rel_ms( definition.end ), options,
                                    definition.displayed ) :
                         zone_data( definition.name, definition.type, faction, definition.invert, definition.enabled,
                                    tripoint_abs_ms( definition.start ), tripoint_abs_ms( definition.end ), options,
                                    definition.displayed );
        zone.identity = entry.identity;
        zone.editing_draft = true;
        zone.is_vehicle = definition.vehicle_bound;
        zone.personal_owner = definition.personal ? who.getID() : character_id();
        zone.cached_shift = who.pos_abs();
        result->drafts.push_back( std::move( zone ) );
        result->originals.push_back( entry );
        result->bindings.emplace( entry.identity, std::make_pair( definition.vehicle, definition.part ) );
        if( !definition.vehicle_bound ) {
            result->original_order.push_back( entry.identity );
        }
    }
    return result;
}
