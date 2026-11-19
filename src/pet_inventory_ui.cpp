#include "pet_inventory_ui.h"

#include <character_id.h>
#include <clone_ptr.h>
#include <coordinates.h>
#include <item_uid.h>
#include <memory_fast.h>
#include <monster_uid.h>
#include <type_id.h>
#include <algorithm>
#include <cstddef>
#include <functional>
#include <iterator>
#include <list>
#include <map>
#include <memory>
#include <optional>
#include <set>
#include <string>
#include <utility>
#include <vector>

#include "avatar.h"
#include "cata_utility.h"
#include "character.h"
#include "color.h"
#include "creature_tracker.h"
#include "cursesdef.h"
#include "enums.h"
#include "flag.h"
#include "flexbuffer_json.h"
#include "input_context.h"
#include "inventory.h"
#include "item.h"
#include "item_location.h"
#include "item_pocket.h"
#include "itype.h"
#include "json.h"
#include "map.h"
#include "monster.h"
#include "mtype.h"
#include "output.h"
#include "pet_slot.h"
#include "pimpl.h"
#include "player_activity.h"
#include "pocket_type.h"
#include "point.h"
#include "requirements.h"
#include "ret_val.h"
#include "string_formatter.h"
#include "string_input_popup.h"
#include "translation.h"
#include "translations.h"
#include "ui_manager.h"
#include "uilist.h"
#include "units.h"
#include "units_utility.h"
#include "value_ptr.h"

class activity_actor;

static const activity_id ACT_PET_TRANSFER( "ACT_PET_TRANSFER" );

static const damage_type_id damage_bash( "bash" );
static const damage_type_id damage_cut( "cut" );
static const damage_type_id damage_stab( "stab" );

namespace pet_inventory_ui
{
std::string load_summary( const monster &pet, const Character &who )
{
    const units::mass carried = pet.get_carried_weight();
    if( !pet.has_flag( mon_flag_PET_MOUNTABLE ) ) {
        return string_format( _( "Equipment/cargo: %.1f / %.1f %s  Remaining: %.1f %s" ),
                              convert_weight( carried ), convert_weight( pet.weight_capacity() ), weight_units(),
                              convert_weight( pet.weight_capacity() - carried ), weight_units() );
    }
    const Character &rider = pet.mounted_player != nullptr ? *pet.mounted_player : who;
    const units::mass total = pet.get_load_weight( &rider );
    return string_format(
               _( "Equipment/cargo: %.1f %s  Rider: %.1f %s\n%s: %.1f / %.1f %s  Remaining: %.1f %s" ),
               convert_weight( carried ), weight_units(), convert_weight( rider.get_weight() ),
               weight_units(), pet.mounted_player != nullptr ? _( "Riding load" ) : _( "After mounting" ),
               convert_weight( total ), convert_weight( pet.weight_capacity() ),
               weight_units(), convert_weight( pet.weight_capacity() - total ), weight_units() );
}

std::optional<std::pair<quality_id, int>> missing_install_quality( const Character &who,
                                       const item &equipment )
{
    if( equipment.type->pet_equipment ) {
        for( const auto &[quality, level] : equipment.type->pet_equipment->install_qualities ) {
            if( !who.has_quality( quality, level ) ) {
                return std::make_pair( quality, level );
            }
        }
    }
    return std::nullopt;
}

ret_val<void> install_equipment( Character &who, monster &pet, const pet_slot_id &slot,
                                 item_location source )
{
    if( !source ) {
        return ret_val<void>::make_failure( _( "The equipment is no longer available." ) );
    }
    const units::mass added = pet.mounted_player == &who && who.has_item( *source ) ?
                              0_gram : source->weight();
    if( added > 0_gram && pet.get_load_weight() + added > pet.weight_capacity() ) {
        return ret_val<void>::make_failure( _( "That equipment is too heavy for the animal." ) );
    }
    if( const auto missing = missing_install_quality( who, *source ) ) {
        return ret_val<void>::make_failure( _( "Installing this equipment requires %s quality level %d." ),
                                            missing->first.obj().name, missing->second );
    }
    if( !pet.equip_pet_equipment( slot, *source ) ) {
        return ret_val<void>::make_failure( _( "The equipment could not be installed in that slot." ) );
    }
    source.remove_item();
    who.flag_encumbrance();
    who.mod_moves( -200 );
    return ret_val<void>::make_success();
}

namespace
{

enum class pane_side : int {
    left,
    right
};

struct pane_cursor {
    int selected = 0;
    int offset = 0;

    void normalize( int item_count, int visible_lines ) {
        if( item_count <= 0 ) {
            selected = 0;
            offset = 0;
            return;
        }
        selected = std::clamp( selected, 0, item_count - 1 );
        if( selected < offset ) {
            offset = selected;
        } else if( selected >= offset + visible_lines ) {
            offset = selected - visible_lines + 1;
        }
        offset = std::clamp( offset, 0, std::max( 0, item_count - visible_lines ) );
    }

    void move( int delta, int item_count ) {
        if( item_count <= 0 ) {
            selected = 0;
            return;
        }
        selected = ( selected + delta + item_count ) % item_count;
    }

    void page( int delta, int item_count, int visible_lines ) {
        move( delta * std::max( 1, visible_lines ), item_count );
    }
};

void append_character_item_location( Character &who, item_location location,
                                     std::vector<item_location> &result,
                                     std::set<const item *> &seen )
{
    if( !location ) {
        return;
    }

    for( item *contained : location->all_items_top( pocket_type::CONTAINER ) ) {
        append_character_item_location( who, item_location( location, contained ), result, seen );
    }

    item *candidate = location.get_item();
    if( candidate == nullptr || candidate->typeId().is_empty() ||
        candidate->typeId().is_null() || !seen.insert( candidate ).second ||
        candidate->has_flag( flag_INTEGRATED ) || candidate->made_of( phase_id::LIQUID ) ||
        !who.can_drop( *candidate ).success() ) {
        return;
    }
    result.push_back( location );
}

std::vector<item_location> character_transfer_items( Character &who )
{
    std::vector<item_location> result;
    std::set<const item *> seen;

    // Character::all_items_loc covers wielded and worn equipment together with
    // their nested contents, but deliberately does not enumerate legacy
    // inventory stacks.  Preserve those parent-aware locations first.
    for( item_location location : who.all_items_loc() ) {
        if( location ) {
            item *candidate = location.get_item();
            if( candidate != nullptr && !candidate->typeId().is_empty() &&
                !candidate->typeId().is_null() && seen.insert( candidate ).second &&
                !candidate->has_flag( flag_INTEGRATED ) &&
                !candidate->made_of( phase_id::LIQUID ) &&
                who.can_drop( *candidate ).success() ) {
                result.push_back( location );
            }
        }
    }

    // Explicitly enumerate the inventory stacks.  This is the source used by
    // the ordinary inventory selectors and is required for loose items such
    // as horse tack, stirrups, saddlebags, and pet armor.
    for( std::list<item> *stack : who.inv->slice() ) {
        if( stack == nullptr ) {
            continue;
        }
        for( item &entry : *stack ) {
            append_character_item_location( who, item_location( who, &entry ), result, seen );
        }
    }
    return result;
}

struct equipment_candidate {
    item_location location;
    std::vector<pet_slot_id> compatible_slots;
};

std::vector<equipment_candidate> equipment_candidates( Character &who, const monster &pet,
        const std::vector<pet_slot_id> &slots )
{
    std::vector<equipment_candidate> result;
    for( item_location &candidate : character_transfer_items( who ) ) {
        if( !candidate || candidate->typeId().is_empty() || candidate->typeId().is_null() ) {
            continue;
        }
        equipment_candidate entry;
        entry.location = candidate;
        for( const pet_slot_id &slot_id : slots ) {
            if( pet.pet_slot_available( slot_id ) && !pet.has_pet_equipment( slot_id ) &&
                slot_id.obj().accepts( *candidate, pet ) ) {
                entry.compatible_slots.push_back( slot_id );
            }
        }
        if( !entry.compatible_slots.empty() ) {
            result.push_back( std::move( entry ) );
        }
    }
    return result;
}

bool candidate_supports_slot( const equipment_candidate &candidate, const pet_slot_id &slot )
{
    return std::find( candidate.compatible_slots.begin(), candidate.compatible_slots.end(), slot ) !=
           candidate.compatible_slots.end();
}

std::string candidate_slot_names( const equipment_candidate &candidate )
{
    std::string result;
    for( const pet_slot_id &slot : candidate.compatible_slots ) {
        if( !result.empty() ) {
            result += ", ";
        }
        result += slot.obj().name.translated();
    }
    return result;
}

struct pet_cargo_entry {
    item *value = nullptr;
    item_pocket *pocket = nullptr;
    std::size_t pocket_index = 0;
    bool legacy_inventory = false;
};

std::string pet_pocket_name( const item_pocket &pocket, const std::size_t index )
{
    std::string name = pocket.get_name().translated();
    if( name.empty() ) {
        name = string_format( _( "Pocket %d" ), index + 1 );
    }
    return name;
}

bool is_transferable_cargo( const item &candidate )
{
    return !candidate.typeId().is_empty() && !candidate.typeId().is_null() &&
           !candidate.has_var( "DESTROY_ITEM_ON_MON_DEATH" );
}

void migrate_legacy_pet_cargo( monster &pet )
{
    auto iter = pet.inv.begin();
    while( iter != pet.inv.end() ) {
        if( iter->typeId().is_empty() || iter->typeId().is_null() ) {
            iter = pet.inv.erase( iter );
            continue;
        }
        if( iter->has_var( "DESTROY_ITEM_ON_MON_DEATH" ) ) {
            ++iter;
            continue;
        }
        item *storage = pet.find_pet_storage( *iter );
        if( storage != nullptr &&
            storage->put_in( *iter, pocket_type::CONTAINER, false, nullptr, true ).success() ) {
            iter = pet.inv.erase( iter );
        } else {
            ++iter;
        }
    }
}

std::vector<pet_cargo_entry> transferable_pet_items( monster &pet )
{
    std::vector<pet_cargo_entry> result;
    for( item *storage : pet.get_pet_storages() ) {
        const std::vector<item_pocket *> pockets = storage->get_container_pockets();
        for( std::size_t pocket_index = 0; pocket_index < pockets.size(); ++pocket_index ) {
            item_pocket *pocket = pockets[pocket_index];
            if( pocket == nullptr ) {
                continue;
            }
            for( item *stored : pocket->all_items_top() ) {
                if( stored != nullptr && is_transferable_cargo( *stored ) ) {
                    result.push_back( { stored, pocket, pocket_index, false } );
                }
            }
        }
    }
    for( item &legacy : pet.inv ) {
        if( is_transferable_cargo( legacy ) ) {
            result.push_back( { &legacy, nullptr, 0, true } );
        }
    }
    return result;
}

units::volume pet_cargo_volume( const std::vector<pet_cargo_entry> &cargo )
{
    units::volume result = 0_ml;
    for( const pet_cargo_entry &entry : cargo ) {
        if( entry.value != nullptr ) {
            result += entry.value->volume();
        }
    }
    return result;
}

std::string equipment_summary( const item &equipment )
{
    if( equipment.is_pet_armor() ) {
        return string_format( _( "%.1f %s; bash %.1f cut %.1f stab %.1f" ),
                              convert_weight( equipment.weight() ), weight_units(),
                              equipment.resist( damage_bash ),
                              equipment.resist( damage_cut ),
                              equipment.resist( damage_stab ) );
    }
    return string_format( _( "Weight: %.1f %s" ), convert_weight( equipment.weight() ),
                          weight_units() );
}

struct pane_row {
    std::string name;
    std::string status;
    nc_color color = c_white;
};

struct menu_layout {
    catacurses::window root;
    catacurses::window left;
    catacurses::window right;
    catacurses::window details;
    catacurses::window controls;
    int body_height = 0;

    void resize( ui_adaptor &adaptor ) {
        const int width = TERMX;
        const int height = TERMY;
        const int content_width = std::max( 2, width - 2 );
        const int left_width = content_width / 2;
        const int right_width = content_width - left_width;
        body_height = std::max( 4, height - 11 );

        root = catacurses::newwin( height, width, point::zero );
        left = catacurses::newwin( body_height, left_width, point( 1, 2 ) );
        right = catacurses::newwin( body_height, right_width,
                                    point( 1 + left_width, 2 ) );
        details = catacurses::newwin( 4, content_width,
                                      point( 1, 2 + body_height ) );
        controls = catacurses::newwin( 4, content_width,
                                       point( 1, height - 5 ) );
        adaptor.position_from_window( root );
    }
};

int pane_visible_lines( const catacurses::window &window )
{
    return std::max( 1, getmaxy( window ) - 3 );
}

void draw_table_pane( const catacurses::window &window, const std::string &title,
                      const std::string &name_heading, const std::string &status_heading,
                      const std::vector<pane_row> &rows, pane_cursor &cursor, bool active,
                      const std::string &empty_message )
{
    werase( window );
    draw_border( window, active ? c_light_green : c_dark_gray );
    center_print( window, 0, active ? c_yellow : c_light_gray, title );

    const int width = getmaxx( window );
    const int status_width = std::clamp( width / 3, 10, std::max( 10, width - 8 ) );
    const int name_width = std::max( 1, width - status_width - 5 );
    trim_and_print( window, point( 3, 1 ), name_width, c_dark_gray, name_heading );
    right_print( window, 1, 2, c_dark_gray, status_heading );

    const int visible_lines = pane_visible_lines( window );
    cursor.normalize( static_cast<int>( rows.size() ), visible_lines );
    if( rows.empty() ) {
        trim_and_print( window, point( 2, 2 ), width - 4, c_dark_gray, empty_message );
    } else {
        const int last = std::min( static_cast<int>( rows.size() ), cursor.offset + visible_lines );
        for( int index = cursor.offset; index < last; ++index ) {
            const bool selected = index == cursor.selected;
            const int line = index - cursor.offset + 2;
            const nc_color row_color = selected ?
                                       ( active ? c_yellow : c_light_gray ) : rows[index].color;
            if( selected ) {
                mvwprintz( window, point( 1, line ), row_color, ">" );
            }
            trim_and_print( window, point( 3, line ), name_width, row_color, rows[index].name );
            right_print( window, line, 2, row_color, rows[index].status );
        }
    }
    wnoutrefresh( window );
}

void draw_detail_box( const catacurses::window &window, const std::string &left_title,
                      const std::string &left_text, const std::string &right_title,
                      const std::string &right_text )
{
    werase( window );
    draw_border( window, c_dark_gray );
    const int width = getmaxx( window );
    const int split = width / 2;
    trim_and_print( window, point( 2, 1 ), split - 4, c_light_blue, left_title );
    trim_and_print( window, point( 2, 2 ), split - 4, c_light_gray, left_text );
    trim_and_print( window, point( split + 1, 1 ), width - split - 3,
                    c_light_blue, right_title );
    trim_and_print( window, point( split + 1, 2 ), width - split - 3,
                    c_light_gray, right_text );
    wnoutrefresh( window );
}

input_context pet_inventory_context( const std::string &id )
{
    input_context context( id );
    context.register_action( "UP" );
    context.register_action( "DOWN" );
    context.register_action( "LEFT" );
    context.register_action( "RIGHT" );
    context.register_action( "PREV_TAB" );
    context.register_action( "NEXT_TAB" );
    context.register_action( "CONFIRM" );
    context.register_action( "EXAMINE" );
    context.register_action( "MOVE_ALL_ITEMS" );
    context.register_action( "PAGE_UP" );
    context.register_action( "PAGE_DOWN" );
    context.register_action( "QUIT" );
    context.register_action( "HELP_KEYBINDINGS" );
    return context;
}

bool can_pet_carry( const monster &pet, const item &candidate, std::string &reason,
                    const item *source = nullptr )
{
    const item *storage = pet.get_pet_storage();
    if( storage == nullptr ) {
        reason = _( "Equip a storage item first." );
        return false;
    }
    if( ( pet.mounted_player == nullptr ||
          !pet.mounted_player->has_item( source != nullptr ? *source : candidate ) ) &&
        candidate.weight() > pet.weight_capacity() - pet.get_load_weight() ) {
        reason = _( "The animal cannot carry that much additional weight." );
        return false;
    }
    if( pet.find_pet_storage( candidate ) == nullptr ) {
        reason = _( "The equipped storage has no pocket that can contain this item." );
        return false;
    }
    return true;
}

bool move_character_item_to_pet( Character &who, monster &pet, item_location source,
                                 bool show_failure, int quantity )
{
    if( !source ) {
        return false;
    }
    if( quantity <= 0 || quantity > source->count() ) {
        return false;
    }
    item payload( *source );
    if( payload.count_by_charges() ) {
        payload.charges = quantity;
    }
    std::string reason;
    if( !can_pet_carry( pet, payload, reason, source.get_item() ) ) {
        if( show_failure ) {
            popup( reason );
        }
        return false;
    }
    item *storage = pet.find_pet_storage( payload );
    if( storage == nullptr ) {
        return false;
    }
    if( !storage->put_in( payload, pocket_type::CONTAINER, false, &who, true ).success() ) {
        if( show_failure ) {
            popup( _( "The item could not be inserted into the animal's storage pocket." ) );
        }
        return false;
    }
    if( source->count_by_charges() && quantity < source->charges ) {
        source->charges -= quantity;
        source.on_contents_changed();
    } else {
        source.remove_item();
    }
    who.flag_encumbrance();
    who.mod_moves( -100 );
    return true;
}

bool move_pet_item_to_character( Character &who, monster &pet, const pet_cargo_entry &entry,
                                 int quantity )
{
    if( entry.value == nullptr || entry.value->typeId().is_empty() ||
        entry.value->typeId().is_null() ) {
        return false;
    }

    if( quantity <= 0 || quantity > entry.value->count() ) {
        return false;
    }
    if( entry.value->count_by_charges() && quantity < entry.value->charges ) {
        item payload( *entry.value );
        payload.charges = quantity;
        entry.value->charges -= quantity;
        if( entry.pocket != nullptr ) {
            entry.pocket->on_contents_changed();
        }
        who.i_add( payload );
        who.flag_encumbrance();
        who.mod_moves( -100 );
        return true;
    }
    std::optional<item> extracted;
    if( entry.legacy_inventory ) {
        const auto found = std::find_if( pet.inv.begin(), pet.inv.end(),
        [&entry]( const item & candidate ) {
            return &candidate == entry.value;
        } );
        if( found == pet.inv.end() ) {
            return false;
        }
        extracted = *found;
        pet.inv.erase( found );
    } else {
        if( entry.pocket == nullptr ) {
            return false;
        }
        extracted = entry.pocket->remove_item( *entry.value );
        if( !extracted ) {
            return false;
        }
    }

    if( !extracted || extracted->typeId().is_empty() || extracted->typeId().is_null() ) {
        return false;
    }
    item moved = std::move( *extracted );
    who.i_add( moved );
    who.flag_encumbrance();
    who.mod_moves( -100 );
    return true;
}

} // namespace

void transfer_request::serialize( JsonOut &json ) const
{
    json.start_object();
    json.member( "to_pet", to_pet );
    json.member( "source", source );
    json.member( "cargo_uid", cargo_uid );
    json.member( "quantity", quantity );
    json.end_object();
}

void transfer_request::deserialize( const JsonObject &json )
{
    json.read( "to_pet", to_pet );
    json.read( "source", source );
    json.read( "cargo_uid", cargo_uid );
    json.read( "quantity", quantity );
}

ret_val<void> transfer_item( Character &who, monster &pet, const transfer_request &request )
{
    if( request.to_pet ) {
        if( !request.source || !who.has_item( *request.source ) ||
            !who.can_drop( *request.source ).success() ) {
            return ret_val<void>::make_failure( _( "The selected item is no longer available." ) );
        }
        if( move_character_item_to_pet( who, pet, request.source, false, request.quantity ) ) {
            return ret_val<void>::make_success();
        }
        return ret_val<void>::make_failure(
                   _( "The item no longer fits the animal's weight or pocket limits." ) );
    }
    for( const pet_cargo_entry &entry : transferable_pet_items( pet ) ) {
        if( entry.value->uid().get_value() == request.cargo_uid ) {
            return move_pet_item_to_character( who, pet, entry, request.quantity ) ?
                   ret_val<void>::make_success() :
                   ret_val<void>::make_failure( _( "The selected quantity is no longer available." ) );
        }
    }
    return ret_val<void>::make_failure( _( "The animal is no longer carrying that item." ) );
}

const activity_id &transfer_activity_actor::get_type() const
{
    return ACT_PET_TRANSFER;
}

void transfer_activity_actor::start( player_activity &act, Character & )
{
    act.moves_total = 1;
    act.moves_left = 1;
}

void transfer_activity_actor::do_turn( player_activity &act, Character &who )
{
    const shared_ptr_fast<monster> pet = get_creature_tracker().find_by_uid( pet_uid );
    map &here = get_map();
    const auto reachable = [&]() {
        return pet && !pet->is_dead() && pet->friendly == -1 &&
               here.inbounds( who.pos_abs() ) && here.inbounds( pet->pos_abs() ) &&
               who.posz() == pet->posz() && rl_dist( who.pos_abs(), pet->pos_abs() ) <= 1 &&
               here.passable( pet->pos_bub( here ) ) &&
               here.clear_path( who.pos_bub( here ), pet->pos_bub( here ), 1, 1, 100 );
    };
    if( who.getID() != operator_id || !reachable() || next_request < 0 ||
        next_request > static_cast<int>( requests.size() ) ) {
        who.add_msg_if_player( m_info, _( "The animal is no longer available for transferring items." ) );
        act.set_to_null();
        return;
    }
    while( who.get_moves() > 0 && next_request < static_cast<int>( requests.size() ) ) {
        if( !reachable() ) {
            who.add_msg_if_player( m_info, _( "The animal is no longer available for transferring items." ) );
            act.set_to_null();
            return;
        }
        const ret_val<void> result = transfer_item( who, *pet, requests[next_request] );
        if( act.actor.get() != this ) {
            return;
        }
        if( !result.success() ) {
            who.add_msg_if_player( m_info, "%s", result.str() );
        }
        ++next_request;
    }
    if( next_request == static_cast<int>( requests.size() ) ) {
        act.set_to_null();
    }
}

void transfer_activity_actor::finish( player_activity &act, Character & )
{
    act.set_to_null();
}

void transfer_activity_actor::serialize( JsonOut &json ) const
{
    json.start_object();
    json.member( "pet_uid", pet_uid );
    json.member( "operator_id", operator_id );
    json.member( "requests", std::vector<transfer_request>( requests.begin() + next_request,
                 requests.end() ) );
    json.end_object();
}

std::unique_ptr<activity_actor> transfer_activity_actor::deserialize( JsonValue &json )
{
    auto actor = std::make_unique<transfer_activity_actor>();
    const JsonObject data = json.get_object();
    data.read( "pet_uid", actor->pet_uid );
    data.read( "operator_id", actor->operator_id );
    data.read( "requests", actor->requests );
    data.read( "next_request", actor->next_request );
    return actor;
}

void show_equipment( monster &pet )
{
    avatar &player = get_avatar();
    std::set<pet_slot_id> eligible_slots;
    for( const pet_slot &slot : get_all_pet_slots() ) {
        if( ( !slot.mount_only || pet.has_flag( mon_flag_PET_MOUNTABLE ) ) &&
            ( slot.bodytypes.empty() || slot.bodytypes.count( pet.type->bodytype ) != 0 ) ) {
            eligible_slots.insert( slot.id );
        }
    }

    // Build a stable grouped order: each root slot is followed by its child slots.
    std::vector<pet_slot_id> slots;
    std::set<pet_slot_id> added_slots;
    std::function<void( const pet_slot_id & )> append_slot_group;
    append_slot_group = [&]( const pet_slot_id & slot_id ) {
        if( eligible_slots.count( slot_id ) == 0 || !added_slots.insert( slot_id ).second ) {
            return;
        }
        slots.push_back( slot_id );
        for( const pet_slot_id &child : slot_id.obj().sub_slots ) {
            append_slot_group( child );
        }
    };
    for( const pet_slot &slot : get_all_pet_slots() ) {
        const std::optional<pet_slot_id> parent = get_pet_slot_parent( slot.id );
        if( eligible_slots.count( slot.id ) > 0 &&
            ( !parent || eligible_slots.count( *parent ) == 0 ) ) {
            append_slot_group( slot.id );
        }
    }
    for( const pet_slot_id &slot_id : eligible_slots ) {
        append_slot_group( slot_id );
    }

    pane_side active = pane_side::left;
    pane_cursor item_cursor;
    pane_cursor slot_cursor;
    std::vector<equipment_candidate> candidates;

    const auto rebuild = [&]() {
        candidates = equipment_candidates( player, pet, slots );
        item_cursor.normalize( static_cast<int>( candidates.size() ), 1 );
        slot_cursor.normalize( static_cast<int>( slots.size() ), 1 );
    };
    rebuild();

    const auto selected_slot = [&]() -> std::optional<pet_slot_id> {
        if( slots.empty() )
        {
            return std::nullopt;
        }
        slot_cursor.selected = std::clamp( slot_cursor.selected, 0,
                                           static_cast<int>( slots.size() ) - 1 );
        return slots[slot_cursor.selected];
    };

    const auto select_first_candidate_for_slot = [&]( const pet_slot_id & slot_id ) {
        const auto found = std::find_if( candidates.begin(), candidates.end(),
        [&slot_id]( const equipment_candidate & candidate ) {
            return candidate_supports_slot( candidate, slot_id );
        } );
        if( found == candidates.end() ) {
            return false;
        }
        item_cursor.selected = std::distance( candidates.begin(), found );
        active = pane_side::left;
        return true;
    };

    const auto choose_slot_for_candidate = [&]( const equipment_candidate & candidate ) ->
    std::optional<pet_slot_id> {
        const std::optional<pet_slot_id> current = selected_slot();
        if( current && candidate_supports_slot( candidate, *current ) )
        {
            return current;
        }
        if( candidate.compatible_slots.size() == 1 )
        {
            return candidate.compatible_slots.front();
        }

        uilist menu;
        menu.text = string_format( _( "Install %s in which slot?" ),
                                   candidate.location->display_name() );
        for( std::size_t index = 0; index < candidate.compatible_slots.size(); ++index )
        {
            const pet_slot_id &slot_id = candidate.compatible_slots[index];
            menu.addentry( static_cast<int>( index ), true, -1,
                           slot_id.obj().name.translated() );
        }
        menu.query();
        if( menu.ret < 0 || menu.ret >= static_cast<int>( candidate.compatible_slots.size() ) )
        {
            return std::nullopt;
        }
        return candidate.compatible_slots[menu.ret];
    };

    const auto install_candidate = [&]( const equipment_candidate & candidate,
    const pet_slot_id & slot_id ) {
        item_location selected = candidate.location;
        if( !selected || !slot_id.is_valid() || !candidate_supports_slot( candidate, slot_id ) ) {
            return false;
        }

        const ret_val<void> installed = install_equipment( player, pet, slot_id, selected );
        if( !installed.success() ) {
            popup( installed.str() );
            return false;
        }

        const auto slot_iter = std::find( slots.begin(), slots.end(), slot_id );
        if( slot_iter != slots.end() ) {
            slot_cursor.selected = std::distance( slots.begin(), slot_iter );
        }
        active = pane_side::right;
        return true;
    };

    const auto remove_from_slot = [&]( const pet_slot_id & slot_id ) {
        const pet_slot &slot = slot_id.obj();
        if( slot.min_storage > 0_ml && pet.pet_storage_count() == 1 && !pet.inv.empty() ) {
            popup( _( "Move the stored items out of the animal before removing its last storage item." ) );
            return false;
        }
        cata::value_ptr<item> removed = pet.remove_pet_equipment( slot_id );
        if( !removed ) {
            popup( _( "Remove equipment from dependent slots first." ) );
            return false;
        }
        player.i_add( *removed );
        player.flag_encumbrance();
        player.mod_moves( -200 );
        return true;
    };

    menu_layout layout;
    ui_adaptor ui;
    ui.on_screen_resize( [&]( ui_adaptor & adaptor ) {
        layout.resize( adaptor );
    } );
    ui.mark_resize();

    input_context context = pet_inventory_context( "PET_EQUIPMENT" );
    ui.on_redraw( [&]( ui_adaptor & ) {
        werase( layout.root );
        draw_border( layout.root );
        center_print( layout.root, 0, c_white,
                      string_format( _( "%s equipment" ), pet.get_name() ) );
        // Refresh the background before its child windows so it cannot erase their contents.
        wnoutrefresh( layout.root );

        const std::optional<pet_slot_id> current_slot = selected_slot();
        std::vector<pane_row> item_rows;
        item_rows.reserve( candidates.size() );
        for( const equipment_candidate &candidate : candidates ) {
            pane_row row;
            row.name = candidate.location->display_name();
            row.status = candidate_slot_names( candidate );
            row.color = current_slot && candidate_supports_slot( candidate, *current_slot ) ?
                        c_light_green : c_white;
            item_rows.push_back( std::move( row ) );
        }

        std::vector<pane_row> slot_rows;
        slot_rows.reserve( slots.size() );
        for( const pet_slot_id &slot_id : slots ) {
            const pet_slot &slot = slot_id.obj();
            const item *equipped = pet.get_pet_equipment( slot_id );
            const bool available = pet.pet_slot_available( slot_id );
            pane_row row;
            row.name = get_pet_slot_parent( slot_id ) ?
                       "  " + slot.name.translated() :
                       string_format( "[ %s ]", slot.name.translated() );
            if( !available ) {
                row.status = _( "[locked]" );
                row.color = c_dark_gray;
            } else if( equipped != nullptr ) {
                row.status = equipped->display_name();
                row.color = c_light_green;
            } else {
                row.status = _( "[empty]" );
                row.color = c_white;
            }
            if( !candidates.empty() &&
                candidate_supports_slot( candidates[item_cursor.selected], slot_id ) ) {
                row.color = c_light_cyan;
            }
            slot_rows.push_back( std::move( row ) );
        }

        draw_table_pane( layout.left, _( "Available equipment" ), _( "Item" ),
                         _( "Compatible slots" ), item_rows, item_cursor,
                         active == pane_side::left,
                         _( "No compatible equipment is available." ) );
        draw_table_pane( layout.right, _( "Animal equipment by slot group" ), _( "Slot group" ),
                         _( "Installed item" ), slot_rows, slot_cursor,
                         active == pane_side::right,
                         _( "This animal has no equipment slots." ) );

        std::string item_title = _( "Selected item" );
        std::string item_text = _( "No item selected." );
        if( !candidates.empty() ) {
            const equipment_candidate &candidate = candidates[item_cursor.selected];
            item_title = candidate.location->display_name();
            item_text = candidate.location->is_pet_armor() ? equipment_summary( *candidate.location ) :
                        string_format( _( "Fits: %s" ), candidate_slot_names( candidate ) );
        }

        std::string slot_title = _( "Selected slot" );
        std::string slot_text = _( "No slot selected." );
        if( current_slot ) {
            const pet_slot &slot = current_slot->obj();
            slot_title = slot.name.translated();
            if( !pet.pet_slot_available( *current_slot ) ) {
                const std::optional<pet_slot_id> parent = get_pet_slot_parent( *current_slot );
                slot_text = parent ? string_format( _( "Requires %s" ),
                                                    parent->obj().name.translated() ) :
                            _( "Locked" );
            } else if( const item *equipped = pet.get_pet_equipment( *current_slot ) ) {
                slot_text = equipment_summary( *equipped );
            } else {
                slot_text = slot.description.translated();
            }
        }
        draw_detail_box( layout.details, item_title, item_text, slot_title, slot_text );

        werase( layout.controls );
        fold_and_print( layout.controls, point::zero, getmaxx( layout.controls ),
                        pet.get_load_weight( pet.has_flag( mon_flag_PET_MOUNTABLE ) ? &player : nullptr ) >
                        pet.weight_capacity() ? c_light_red : c_light_gray,
                        load_summary( pet, player ) );
        center_print( layout.controls, 2, c_light_gray,
                      string_format( _( "[%1$s] switch  [%2$s] install/remove  [%3$s] details  [%4$s] exit" ),
                                     context.get_desc( "NEXT_TAB" ),
                                     context.get_desc( "CONFIRM" ),
                                     context.get_desc( "EXAMINE" ),
                                     context.get_desc( "QUIT" ) ) );
        wnoutrefresh( layout.controls );
    } );

    while( true ) {
        ui_manager::redraw();
        const std::string action = context.handle_input();
        pane_cursor &cursor = active == pane_side::left ? item_cursor : slot_cursor;
        const int count = active == pane_side::left ? static_cast<int>( candidates.size() ) :
                          static_cast<int>( slots.size() );
        const int visible = active == pane_side::left ? pane_visible_lines( layout.left ) :
                            pane_visible_lines( layout.right );

        if( action == "QUIT" ) {
            return;
        } else if( action == "UP" ) {
            cursor.move( -1, count );
        } else if( action == "DOWN" ) {
            cursor.move( 1, count );
        } else if( action == "PAGE_UP" ) {
            cursor.page( -1, count, visible );
        } else if( action == "PAGE_DOWN" ) {
            cursor.page( 1, count, visible );
        } else if( action == "LEFT" || action == "PREV_TAB" || action == "RIGHT" ||
                   action == "NEXT_TAB" ) {
            active = active == pane_side::left ? pane_side::right : pane_side::left;
        } else if( action == "EXAMINE" ) {
            const item *equipment = nullptr;
            if( active == pane_side::left && !candidates.empty() ) {
                equipment = candidates[item_cursor.selected].location.get_item();
            } else if( active == pane_side::right && !slots.empty() ) {
                equipment = pet.get_pet_equipment( slots[slot_cursor.selected] );
            }
            if( equipment != nullptr ) {
                full_screen_popup( "%s\n%s", equipment_summary( *equipment ), equipment->info( true ) );
            }
        } else if( action == "CONFIRM" ) {
            bool changed = false;
            if( active == pane_side::left && !candidates.empty() ) {
                const equipment_candidate &candidate = candidates[item_cursor.selected];
                const std::optional<pet_slot_id> target = choose_slot_for_candidate( candidate );
                changed = target && install_candidate( candidate, *target );
            } else if( active == pane_side::right && !slots.empty() ) {
                const pet_slot_id slot_id = slots[slot_cursor.selected];
                if( !pet.pet_slot_available( slot_id ) ) {
                    popup( _( "Equip the parent slot first." ) );
                } else if( pet.has_pet_equipment( slot_id ) ) {
                    changed = remove_from_slot( slot_id );
                } else if( !candidates.empty() &&
                           candidate_supports_slot( candidates[item_cursor.selected], slot_id ) ) {
                    const equipment_candidate &candidate = candidates[item_cursor.selected];
                    changed = install_candidate( candidate, slot_id );
                } else if( !select_first_candidate_for_slot( slot_id ) ) {
                    popup( _( "You have no compatible equipment for this slot." ) );
                }
            }
            if( changed ) {
                rebuild();
            }
        }
        ui.invalidate_ui();
    }
}

void show_transfer( monster &pet )
{
    avatar &player = get_avatar();
    if( pet.get_pet_storage() == nullptr ) {
        popup( _( "Equip the animal with a storage item before transferring cargo." ) );
        return;
    }

    pane_side active = pane_side::left;
    pane_cursor player_cursor;
    pane_cursor pet_cursor;
    std::vector<item_location> player_items;
    std::vector<pet_cargo_entry> pet_items;
    migrate_legacy_pet_cargo( pet );
    const std::vector<item_location> all_player_items = character_transfer_items( player );
    const std::vector<pet_cargo_entry> all_pet_items = transferable_pet_items( pet );
    std::map<const item *, int> selected;
    std::string filter;

    const auto select_item = [&selected]( const item & entry, int quantity ) {
        if( quantity <= 0 ) {
            selected.erase( &entry );
            return;
        }
        for( auto pending = selected.begin(); pending != selected.end(); ) {
            if( pending->first != &entry &&
                ( pending->first->has_item( entry ) || entry.has_item( *pending->first ) ) ) {
                pending = selected.erase( pending );
            } else {
                ++pending;
            }
        }
        selected[&entry] = quantity;
    };

    const auto rebuild = [&]() {
        player_items.clear();
        pet_items.clear();
        for( const item_location &entry : all_player_items ) {
            if( lcmatch( entry->display_name(), filter ) ) {
                player_items.push_back( entry );
            }
        }
        for( const pet_cargo_entry &entry : all_pet_items ) {
            if( lcmatch( entry.value->display_name(), filter ) ) {
                pet_items.push_back( entry );
            }
        }
        player_cursor.normalize( static_cast<int>( player_items.size() ), 1 );
        pet_cursor.normalize( static_cast<int>( pet_items.size() ), 1 );
    };
    rebuild();

    menu_layout layout;
    ui_adaptor ui;
    ui.on_screen_resize( [&]( ui_adaptor & adaptor ) {
        layout.resize( adaptor );
    } );
    ui.mark_resize();

    input_context context = pet_inventory_context( "PET_ITEM_TRANSFER" );
    context.register_action( "SELECT_ITEM" );
    context.register_action( "SELECT_QUANTITY" );
    context.register_action( "FILTER" );
    ui.on_redraw( [&]( ui_adaptor & ) {
        werase( layout.root );
        draw_border( layout.root );
        center_print( layout.root, 0, c_white,
                      string_format( _( "Transfer items with %s" ), pet.get_name() ) );
        // Refresh the background first; both inventory panes must remain visible afterward.
        wnoutrefresh( layout.root );

        std::vector<pane_row> player_rows;
        player_rows.reserve( player_items.size() );
        for( const item_location &entry : player_items ) {
            const auto pending = selected.find( entry.get_item() );
            const std::string marked = pending == selected.end() ? " " : std::to_string( pending->second );
            player_rows.push_back( {
                string_format( "[%s] %s%s", marked, entry->is_favorite ? "* " : "", entry->display_name() ),
                string_format( _( "%1$d g  %2$s %3$s" ), units::to_gram( entry->weight() ),
                               format_volume( entry->volume() ), volume_units_abbr() ),
                pending == selected.end() ? c_white : c_light_green
            } );
        }

        std::vector<pane_row> pet_rows;
        pet_rows.reserve( pet_items.size() );
        for( const pet_cargo_entry &cargo : pet_items ) {
            if( cargo.value == nullptr ) {
                continue;
            }
            const item &entry = *cargo.value;
            const auto pending = selected.find( &entry );
            const std::string marked = pending == selected.end() ? " " : std::to_string( pending->second );
            const std::string location = cargo.legacy_inventory ? _( "Legacy cargo" ) :
                                         pet_pocket_name( *cargo.pocket, cargo.pocket_index );
            pet_rows.push_back( {
                string_format( "[%s] %s: %s", marked, location, entry.display_name() ),
                string_format( _( "%1$s / %2$d g" ), format_volume( entry.volume() ),
                               units::to_gram( entry.weight() ) ),
                pending == selected.end() ? c_white : c_light_green
            } );
        }

        draw_table_pane( layout.left, _( "Your inventory" ), _( "Item" ),
                         _( "Weight / volume" ), player_rows, player_cursor,
                         active == pane_side::left, _( "Your inventory is empty." ) );
        draw_table_pane( layout.right, string_format( _( "%s storage pockets" ), pet.get_name() ),
                         _( "Pocket / item" ), _( "Volume / weight" ), pet_rows, pet_cursor,
                         active == pane_side::right, _( "The animal is carrying no cargo." ) );

        std::string left_title = _( "Selected inventory item" );
        std::string left_text = _( "No inventory item selected." );
        if( !player_items.empty() ) {
            const item_location &entry = player_items[player_cursor.selected];
            left_title = entry->display_name();
            std::string reason;
            left_text = can_pet_carry( pet, *entry, reason ) ?
                        _( "Can be moved to the animal." ) : reason;
        }

        std::string right_title = _( "Selected animal cargo" );
        std::string right_text = _( "No cargo selected." );
        if( !pet_items.empty() ) {
            const pet_cargo_entry &cargo = pet_items[pet_cursor.selected];
            if( cargo.value != nullptr ) {
                right_title = cargo.value->display_name();
                if( cargo.legacy_inventory ) {
                    right_text = _( "Legacy cargo awaiting migration to a real pocket." );
                } else {
                    right_text = string_format(
                                     _( "%1$s: %2$s / %3$s %4$s" ),
                                     pet_pocket_name( *cargo.pocket, cargo.pocket_index ),
                                     format_volume( cargo.pocket->contents_volume() ),
                                     format_volume( cargo.pocket->volume_capacity() ),
                                     volume_units_abbr() );
                }
            }
        }
        draw_detail_box( layout.details, left_title, left_text, right_title, right_text );

        units::volume total_capacity = 0_ml;
        for( const item *storage : pet.get_pet_storages() ) {
            total_capacity += storage->get_volume_capacity();
        }
        units::mass weight_delta = 0_gram;
        units::volume volume_delta = 0_ml;
        for( const item_location &entry : all_player_items ) {
            const auto pending = selected.find( entry.get_item() );
            if( pending != selected.end() ) {
                item payload( *entry );
                if( payload.count_by_charges() ) {
                    payload.charges = pending->second;
                }
                weight_delta += payload.weight();
                volume_delta += payload.volume();
            }
        }
        for( const pet_cargo_entry &entry : all_pet_items ) {
            const auto pending = selected.find( entry.value );
            if( pending != selected.end() ) {
                item payload( *entry.value );
                if( payload.count_by_charges() ) {
                    payload.charges = pending->second;
                }
                weight_delta -= payload.weight();
                volume_delta -= payload.volume();
            }
        }
        const units::mass projected = pet.get_load_weight() +
                                      ( pet.mounted_player == &player ? 0_gram : weight_delta );
        werase( layout.controls );
        trim_and_print( layout.controls, point::zero, getmaxx( layout.controls ),
                        projected > pet.weight_capacity() ? c_light_red : c_light_gray,
                        string_format( _( "After transfer: load %.1f / %.1f %s; free %.1f %s" ),
                                       convert_weight( projected ), convert_weight( pet.weight_capacity() ), weight_units(),
                                       convert_weight( pet.weight_capacity() - projected ), weight_units() ) );
        trim_and_print( layout.controls, point::south, getmaxx( layout.controls ), c_light_gray,
                        string_format( _( "Cargo: %s / %s %s; selected: %d; filter: %s" ),
                                       format_volume( pet_cargo_volume( all_pet_items ) + volume_delta ),
                                       format_volume( total_capacity ), volume_units_abbr(), selected.size(), filter ) );
        center_print( layout.controls, 2, c_light_gray,
                      string_format( _( "[%s] select  [%s] quantity  [%s] confirm  [%s] filter" ),
                                     context.get_desc( "SELECT_ITEM" ), context.get_desc( "SELECT_QUANTITY" ),
                                     context.get_desc( "CONFIRM" ), context.get_desc( "FILTER" ) ) );
        center_print( layout.controls, 3, c_light_gray,
                      string_format( _( "[%s] switch  [%s] select all  [%s] details  [%s] cancel" ),
                                     context.get_desc( "NEXT_TAB" ), context.get_desc( "MOVE_ALL_ITEMS" ),
                                     context.get_desc( "EXAMINE" ), context.get_desc( "QUIT" ) ) );
        wnoutrefresh( layout.controls );
    } );

    while( true ) {
        ui_manager::redraw();
        const std::string action = context.handle_input();
        pane_cursor &cursor = active == pane_side::left ? player_cursor : pet_cursor;
        const int count = active == pane_side::left ? static_cast<int>( player_items.size() ) :
                          static_cast<int>( pet_items.size() );
        const int visible = active == pane_side::left ? pane_visible_lines( layout.left ) :
                            pane_visible_lines( layout.right );

        if( action == "QUIT" ) {
            return;
        } else if( action == "UP" ) {
            cursor.move( -1, count );
        } else if( action == "DOWN" ) {
            cursor.move( 1, count );
        } else if( action == "PAGE_UP" ) {
            cursor.page( -1, count, visible );
        } else if( action == "PAGE_DOWN" ) {
            cursor.page( 1, count, visible );
        } else if( action == "LEFT" || action == "PREV_TAB" || action == "RIGHT" ||
                   action == "NEXT_TAB" ) {
            active = active == pane_side::left ? pane_side::right : pane_side::left;
        } else if( action == "FILTER" ) {
            filter = string_input_popup().title( _( "Filter items" ) ).text( filter ).query_string();
            rebuild();
        } else if( action == "EXAMINE" && count > 0 ) {
            const item &entry = active == pane_side::left ?
                                *player_items[player_cursor.selected] : *pet_items[pet_cursor.selected].value;
            full_screen_popup( "%s", entry.info( true ) );
        } else if( ( action == "SELECT_ITEM" || action == "SELECT_QUANTITY" ) && count > 0 ) {
            const item &entry = active == pane_side::left ?
                                *player_items[player_cursor.selected] : *pet_items[pet_cursor.selected].value;
            const auto pending = selected.find( &entry );
            int quantity = pending == selected.end() ? entry.count() : 0;
            if( action == "SELECT_QUANTITY" && entry.count_by_charges() ) {
                quantity = pending == selected.end() ? entry.count() : pending->second;
                if( !query_int( quantity, false, _( "Select quantity (0-%d):" ), entry.count() ) ||
                    quantity < 0 || quantity > entry.count() ) {
                    continue;
                }
            }
            select_item( entry, quantity );
        } else if( action == "MOVE_ALL_ITEMS" ) {
            if( active == pane_side::left ) {
                for( const item_location &entry : player_items ) {
                    const bool contained = std::any_of( player_items.begin(), player_items.end(),
                    [&entry]( const item_location & other ) {
                        return other != entry && other->has_item( *entry );
                    } );
                    if( !contained ) {
                        select_item( *entry, entry->count() );
                    }
                }
            } else {
                for( const pet_cargo_entry &entry : pet_items ) {
                    select_item( *entry.value, entry.value->count() );
                }
            }
        } else if( action == "CONFIRM" ) {
            std::vector<transfer_request> requests;
            for( const pet_cargo_entry &entry : all_pet_items ) {
                const auto pending = selected.find( entry.value );
                if( pending != selected.end() ) {
                    requests.push_back( { false, item_location(), entry.value->uid().get_value(), pending->second } );
                }
            }
            for( const item_location &entry : all_player_items ) {
                const auto pending = selected.find( entry.get_item() );
                if( pending != selected.end() ) {
                    requests.push_back( { true, entry, 0, pending->second } );
                }
            }
            if( !requests.empty() ) {
                pet.ensure_uid();
                player.assign_activity( transfer_activity_actor( pet.uid().get_value(), player.getID(),
                                        std::move( requests ) ) );
                return;
            }
        }
        ui.invalidate_ui();
    }
}
} // namespace pet_inventory_ui
