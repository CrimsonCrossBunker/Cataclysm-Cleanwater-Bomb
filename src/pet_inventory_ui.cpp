#include "pet_inventory_ui.h"

#include <algorithm>
#include <cstddef>
#include <functional>
#include <list>
#include <set>
#include <string>
#include <utility>
#include <vector>

#include "avatar.h"
#include "character.h"
#include "color.h"
#include "cursesdef.h"
#include "enums.h"
#include "flag.h"
#include "input_context.h"
#include "inventory.h"
#include "item.h"
#include "item_pocket.h"
#include "item_location.h"
#include "messages.h"
#include "monster.h"
#include "mtype.h"
#include "output.h"
#include "pet_slot.h"
#include "pocket_type.h"
#include "point.h"
#include "popup.h"
#include "string_formatter.h"
#include "translations.h"
#include "ui_manager.h"
#include "uilist.h"
#include "units.h"
#include "units_utility.h"

namespace pet_inventory_ui
{
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
    item *storage = pet.get_pet_storage();
    if( storage == nullptr ) {
        return;
    }

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
        if( storage->put_in( *iter, pocket_type::CONTAINER, false, nullptr, true ).success() ) {
            iter = pet.inv.erase( iter );
        } else {
            ++iter;
        }
    }
}

std::vector<pet_cargo_entry> transferable_pet_items( monster &pet )
{
    std::vector<pet_cargo_entry> result;
    item *storage = pet.get_pet_storage();
    if( storage != nullptr ) {
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

units::mass pet_cargo_weight( const std::vector<pet_cargo_entry> &cargo )
{
    units::mass result = 0_gram;
    for( const pet_cargo_entry &entry : cargo ) {
        if( entry.value != nullptr ) {
            result += entry.value->weight();
        }
    }
    return result;
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
        body_height = std::max( 4, height - 8 );

        root = catacurses::newwin( height, width, point::zero );
        left = catacurses::newwin( body_height, left_width, point( 1, 2 ) );
        right = catacurses::newwin( body_height, right_width,
                                    point( 1 + left_width, 2 ) );
        details = catacurses::newwin( 4, content_width,
                                      point( 1, 2 + body_height ) );
        controls = catacurses::newwin( 1, content_width,
                                       point( 1, height - 2 ) );
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
    context.register_action( "MOVE_ALL_ITEMS" );
    context.register_action( "PAGE_UP" );
    context.register_action( "PAGE_DOWN" );
    context.register_action( "QUIT" );
    context.register_action( "HELP_KEYBINDINGS" );
    return context;
}

bool can_pet_carry( const monster &pet, const item &candidate, std::string &reason )
{
    const item *storage = pet.get_pet_storage();
    if( storage == nullptr ) {
        reason = _( "Equip a storage item first." );
        return false;
    }
    if( candidate.weight() > pet.weight_capacity() - pet.get_carried_weight() ) {
        reason = _( "The animal cannot carry that much additional weight." );
        return false;
    }
    if( !storage->can_contain_directly( candidate ).success() ) {
        reason = _( "The equipped storage has no pocket that can contain this item." );
        return false;
    }
    return true;
}

bool move_character_item_to_pet( Character &who, monster &pet, item_location source,
                                 bool show_failure )
{
    if( !source ) {
        return false;
    }
    std::string reason;
    if( !can_pet_carry( pet, *source, reason ) ) {
        if( show_failure ) {
            popup( reason );
        }
        return false;
    }
    item *storage = pet.get_pet_storage();
    if( storage == nullptr ) {
        return false;
    }
    const item payload( *source );
    if( !storage->put_in( payload, pocket_type::CONTAINER, false, &who, true ).success() ) {
        if( show_failure ) {
            popup( _( "The item could not be inserted into the animal's storage pocket." ) );
        }
        return false;
    }
    source.remove_item();
    who.flag_encumbrance();
    who.mod_moves( -100 );
    return true;
}

bool move_pet_item_to_character( Character &who, monster &pet, const pet_cargo_entry &entry )
{
    if( entry.value == nullptr || entry.value->typeId().is_empty() ||
        entry.value->typeId().is_null() ) {
        return false;
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

void show_equipment( monster &pet )
{
    avatar &player = get_avatar();
    std::set<pet_slot_id> eligible_slots;
    for( const pet_slot &slot : get_all_pet_slots() ) {
        if( !slot.mount_only || pet.has_flag( mon_flag_PET_MOUNTABLE ) ) {
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

        const pet_slot &slot = slot_id.obj();
        if( slot.min_storage > 0_ml && !selected->is_container_empty() ) {
            popup( _( "Empty that storage item before equipping it on the animal." ) );
            return false;
        }
        if( selected->weight() > pet.weight_capacity() - pet.get_carried_weight() ) {
            popup( _( "That equipment is too heavy for the animal." ) );
            return false;
        }
        if( !pet.equip_pet_equipment( slot_id, *selected ) ) {
            popup( _( "The equipment could not be installed in that slot." ) );
            return false;
        }

        selected.remove_item();
        player.flag_encumbrance();
        player.mod_moves( -200 );
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
            item_text = string_format( _( "Fits: %s" ), candidate_slot_names( candidate ) );
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
                slot_text = string_format( _( "Installed: %s" ), equipped->display_name() );
            } else {
                slot_text = slot.description.translated();
            }
        }
        draw_detail_box( layout.details, item_title, item_text, slot_title, slot_text );

        werase( layout.controls );
        center_print( layout.controls, 0, c_light_gray,
                      string_format( _( "[%1$s] switch side  [%2$s] install/remove  [%3$s] exit" ),
                                     context.get_desc( "NEXT_TAB" ),
                                     context.get_desc( "CONFIRM" ),
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
        } else if( action == "CONFIRM" ) {
            bool changed = false;
            if( active == pane_side::left && !candidates.empty() ) {
                const equipment_candidate candidate = candidates[item_cursor.selected];
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
                    const equipment_candidate candidate = candidates[item_cursor.selected];
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

    const auto rebuild = [&]() {
        migrate_legacy_pet_cargo( pet );
        player_items = character_transfer_items( player );
        pet_items = transferable_pet_items( pet );
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
            player_rows.push_back( {
                entry->display_name(),
                string_format( _( "%1$d g  %2$s %3$s" ), units::to_gram( entry->weight() ),
                               format_volume( entry->volume() ), volume_units_abbr() ),
                c_white
            } );
        }

        std::vector<pane_row> pet_rows;
        pet_rows.reserve( pet_items.size() );
        for( const pet_cargo_entry &cargo : pet_items ) {
            if( cargo.value == nullptr ) {
                continue;
            }
            const item &entry = *cargo.value;
            const std::string location = cargo.legacy_inventory ? _( "Legacy cargo" ) :
                                         pet_pocket_name( *cargo.pocket, cargo.pocket_index );
            pet_rows.push_back( {
                string_format( _( "%1$s: %2$s" ), location, entry.display_name() ),
                string_format( _( "%1$s / %2$d g" ), format_volume( entry.volume() ),
                               units::to_gram( entry.weight() ) ),
                c_white
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

        const item *storage = pet.get_pet_storage();
        werase( layout.controls );
        center_print( layout.controls, 0, c_light_gray,
                      string_format(
                          _( "Cargo %1$s/%2$s %3$s, %4$d/%5$d g   [%6$s] switch  [%7$s] move  [%8$s] move all  [%9$s] exit" ),
                          format_volume( pet_cargo_volume( pet_items ) ),
                          format_volume( storage->get_volume_capacity() ), volume_units_abbr(),
                          units::to_gram( pet_cargo_weight( pet_items ) ),
                          units::to_gram( pet.weight_capacity() ),
                          context.get_desc( "NEXT_TAB" ), context.get_desc( "CONFIRM" ),
                          context.get_desc( "MOVE_ALL_ITEMS" ), context.get_desc( "QUIT" ) ) );
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
        } else if( action == "CONFIRM" ) {
            if( active == pane_side::left && !player_items.empty() ) {
                move_character_item_to_pet( player, pet, player_items[player_cursor.selected], true );
            } else if( active == pane_side::right && !pet_items.empty() ) {
                move_pet_item_to_character( player, pet, pet_items[pet_cursor.selected] );
            }
            rebuild();
        } else if( action == "MOVE_ALL_ITEMS" && count > 0 &&
                   query_yn( active == pane_side::left ?
                             _( "Move every item that fits to the animal?" ) :
                             _( "Take every item from the animal?" ) ) ) {
            if( active == pane_side::left ) {
                bool moved_item = true;
                while( moved_item ) {
                    moved_item = false;
                    rebuild();
                    for( const item_location &entry : player_items ) {
                        if( move_character_item_to_pet( player, pet, entry, false ) ) {
                            moved_item = true;
                            break;
                        }
                    }
                }
            } else {
                while( true ) {
                    rebuild();
                    if( pet_items.empty() ) {
                        break;
                    }
                    move_pet_item_to_character( player, pet, pet_items.front() );
                }
            }
            rebuild();
        }
        ui.invalidate_ui();
    }
}
} // namespace pet_inventory_ui
