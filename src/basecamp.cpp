#include "basecamp.h"

#include <cata_variant.h>
#include <coordinates.h>
#include <craft_command.h>
#include <enums.h>
#include <game_constants.h>
#include <item_components.h>
#include <item_uid.h>
#include <mapgendata.h>
#include <mission_companion.h>
#include <pimpl.h>
#include <plf/list.h>
#include <point.h>
#include <ret_val.h>
#include <safe_reference.h>
#include <stomach.h>
#include <translation.h>
#include <algorithm>
#include <array>
#include <atomic>
#include <cstdint>
#include <exception>
#include <iterator>
#include <limits>
#include <map>
#include <sstream>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <utility>
#include <vector>

#include "avatar.h"
#include "build_reqs.h"
#include "calendar.h"
#include "cata_assert.h"
#include "cata_utility.h"
#include "character.h"
#include "character_id.h"
#include "clzones.h"
#include "color.h"
#include "crafting.h"
#include "debug.h"
#include "event.h"
#include "event_bus.h"
#include "faction.h"
#include "faction_camp.h"
#include "flexbuffer_json.h"
#include "game.h"
#include "input_popup.h"
#include "inventory.h"
#include "item.h"
#include "itype.h"
#include "json.h"
#include "json_loader.h"
#include "map.h"
#include "map_iterator.h"
#include "map_scale_constants.h"
#include "mapdata.h"
#include "mapgen_functions.h"
#include "messages.h"
#include "npc.h"
#include "output.h"
#include "overmap.h"
#include "overmapbuffer.h"
#include "recipe.h"
#include "recipe_dictionary.h"
#include "recipe_groups.h"
#include "requirements.h"
#include "string_formatter.h"
#include "translations.h"
#include "type_id.h"

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
    #include "lua_platform_handle.h"
#endif

static const flag_id json_flag_PSEUDO( "PSEUDO" );

static const zone_type_id zone_type_CAMP_STORAGE( "CAMP_STORAGE" );

namespace
{

std::atomic<std::uint64_t> next_platform_camp_id { 1 };
std::atomic<std::uint64_t> next_platform_task_id { 1 };
std::atomic<std::uint64_t> next_platform_expansion_id { 1 };

std::uint64_t allocate_platform_camp_id()
{
    const std::uint64_t result = next_platform_camp_id.fetch_add(
                                     1, std::memory_order_relaxed );
    if( result == 0 || result == std::numeric_limits<std::uint64_t>::max() ) {
        std::terminate();
    }
    return result;
}

void reserve_platform_camp_id( const std::uint64_t id )
{
    if( id == 0 ) {
        return;
    }
    std::uint64_t next = next_platform_camp_id.load( std::memory_order_relaxed );
    while( next <= id && next != std::numeric_limits<std::uint64_t>::max() ) {
        if( next_platform_camp_id.compare_exchange_weak(
                next, id + 1, std::memory_order_relaxed ) ) {
            return;
        }
    }
}

std::uint64_t allocate_platform_expansion_id()
{
    const std::uint64_t result = next_platform_expansion_id.fetch_add(
                                     1, std::memory_order_relaxed );
    if( result == 0 || result == std::numeric_limits<std::uint64_t>::max() ) {
        std::terminate();
    }
    return result;
}

void reserve_platform_expansion_id_impl( const std::uint64_t id )
{
    if( id == 0 ) {
        return;
    }
    if( id == std::numeric_limits<std::uint64_t>::max() ) {
        std::terminate();
    }
    std::uint64_t next = next_platform_expansion_id.load( std::memory_order_relaxed );
    while( next <= id && !next_platform_expansion_id.compare_exchange_weak(
               next, id + 1, std::memory_order_relaxed ) ) {
    }
}

std::uint64_t allocate_platform_task_id()
{
    const std::uint64_t result = next_platform_task_id.fetch_add(
                                     1, std::memory_order_relaxed );
    if( result == 0 || result == std::numeric_limits<std::uint64_t>::max() ) {
        std::terminate();
    }
    return result;
}

void reserve_platform_task_id_impl( const std::uint64_t id )
{
    if( id == 0 ) {
        return;
    }
    if( id == std::numeric_limits<std::uint64_t>::max() ) {
        std::terminate();
    }
    std::uint64_t next = next_platform_task_id.load( std::memory_order_relaxed );
    while( next <= id && !next_platform_task_id.compare_exchange_weak(
               next, id + 1, std::memory_order_relaxed ) ) {
    }
}

} // namespace

namespace
{

constexpr std::int64_t maximum_platform_resource_work_amount = 1000000000;
constexpr std::int64_t maximum_platform_resource_work_duration = 1000000;
constexpr int maximum_platform_recipe_batch = 1000;
constexpr std::int64_t maximum_platform_recipe_duration = 1000000;
constexpr std::int64_t maximum_platform_upgrade_duration = 1000000;

bool platform_expansion_name_is_valid( const std::string &name )
{
    if( name.empty() || name.size() > 64 ) {
        return false;
    }
    return std::all_of( name.begin(), name.end(), []( const unsigned char value ) {
        return value >= 0x20U && value != 0x7fU;
    } );
}

bool platform_expansion_position_is_in_domain( const tripoint_abs_omt &camp,
        const tripoint_abs_omt &position )
{
    const int dx = position.x() - camp.x();
    const int dy = position.y() - camp.y();
    return position.z() == camp.z() && ( dx != 0 || dy != 0 ) &&
           dx >= -1 && dx <= 1 && dy >= -1 && dy <= 1;
}
constexpr std::size_t maximum_platform_recipe_holders = 16;
constexpr std::size_t maximum_platform_recipe_escrow_items = 256;

bool dispatch_worker_reservation_task(
    basecamp_platform_task_operation operation,
    basecamp_platform_task_execution_context &context, std::string &error );
bool dispatch_resource_work_task(
    basecamp_platform_task_operation operation,
    basecamp_platform_task_execution_context &context, std::string &error );
bool dispatch_recipe_work_task(
    basecamp_platform_task_operation operation,
    basecamp_platform_task_execution_context &context, std::string &error );
bool dispatch_upgrade_work_task(
    basecamp_platform_task_operation operation,
    basecamp_platform_task_execution_context &context, std::string &error );
bool platform_task_is_active( const basecamp_platform_task &task )
{
    return task.state == basecamp_platform_task_state::pending ||
           task.state == basecamp_platform_task_state::running;
}

void retire_platform_task_record( basecamp_platform_task &task, const time_point now )
{
    if( !platform_task_is_active( task ) ) {
        return;
    }
    if( task.identity_generation < std::numeric_limits<std::uint64_t>::max() ) {
        ++task.identity_generation;
    }
    task.state = basecamp_platform_task_state::cancelled;
    task.finished_at = now;
}

bool validate_positive_resource_changes(
    const std::vector<basecamp_platform_resource_change> &changes,
    const std::string_view label, std::string &error )
{
    for( std::size_t index = 0; index < changes.size(); ++index ) {
        const basecamp_platform_resource_change &change = changes[index];
        if( change.resource_id.is_null() || !change.resource_id.is_valid() ) {
            error = std::string( label ) + " contains an invalid resource id";
            return false;
        }
        if( change.delta <= 0 ||
            change.delta > maximum_platform_resource_work_amount ) {
            error = std::string( label ) + " amounts must be positive and bounded";
            return false;
        }
        for( std::size_t prior = 0; prior < index; ++prior ) {
            if( changes[prior].resource_id == change.resource_id ) {
                error = std::string( label ) + " contains a duplicate resource key";
                return false;
            }
        }
    }
    return true;
}

bool resource_change_sets_equal(
    const std::vector<basecamp_platform_resource_change> &lhs,
    const std::vector<basecamp_platform_resource_change> &rhs )
{
    if( lhs.size() != rhs.size() ) {
        return false;
    }
    std::vector<bool> matched( rhs.size(), false );
    for( const basecamp_platform_resource_change &left : lhs ) {
        const auto right = std::find_if( rhs.begin(), rhs.end(),
        [&left, &rhs, &matched]( const basecamp_platform_resource_change & candidate ) {
            const std::size_t index = static_cast<std::size_t>( &candidate - rhs.data() );
            return !matched[index] && candidate.resource_id == left.resource_id &&
                   candidate.delta == left.delta;
        } );
        if( right == rhs.end() ) {
            return false;
        }
        matched[static_cast<std::size_t>( right - rhs.begin() )] = true;
    }
    return true;
}

bool resource_work_has_effect( const basecamp_platform_resource_work &work )
{
    return !work.resource_inputs.empty() || !work.resource_outputs.empty() ||
           work.food_input_kcal.has_value() || work.food_output_kcal.has_value();
}

bool validate_resource_work_against_resources(
    const std::vector<basecamp_resource> &resources,
    const basecamp_platform_resource_work &work, std::string &error )
{
    for( const basecamp_platform_resource_change &change : work.resource_inputs ) {
        const auto found = std::find_if( resources.begin(), resources.end(),
        [&change]( const basecamp_resource & resource ) {
            return resource.fake_id == change.resource_id;
        } );
        if( found == resources.end() ) {
            error = "resource_work refers to an unknown camp resource";
            return false;
        }
    }
    for( const basecamp_platform_resource_change &change : work.resource_outputs ) {
        const auto found = std::find_if( resources.begin(), resources.end(),
        [&change]( const basecamp_resource & resource ) {
            return resource.fake_id == change.resource_id;
        } );
        if( found == resources.end() ) {
            error = "resource_work output refers to an unknown camp resource";
            return false;
        }
    }
    return true;
}

bool validate_resource_work_against_camp(
    const basecamp &camp, const basecamp_platform_resource_work &work,
    std::string &error )
{
    std::vector<basecamp_resource> resources;
    if( !camp.platform_resource_snapshot( resources, error ) ) {
        return false;
    }
    return validate_resource_work_against_resources( resources, work, error );
}

bool apply_platform_resource_availability(
    std::vector<basecamp_resource> &resources,
    const std::vector<basecamp_platform_resource_change> &changes,
    const bool add, std::string &error,
    const std::vector<basecamp_platform_resource_change> *outstanding_liability = nullptr )
{
    std::vector<basecamp_resource> normalized;
    if( !basecamp::platform_normalize_resources( resources, normalized, error ) ) {
        return false;
    }
    for( const basecamp_platform_resource_change &change : changes ) {
        const auto found = std::find_if( normalized.begin(), normalized.end(),
        [&change]( const basecamp_resource & resource ) {
            return resource.fake_id == change.resource_id;
        } );
        if( found == normalized.end() ) {
            error = "resource_work refers to an unknown camp resource";
            return false;
        }
        const std::uint64_t amount = static_cast<std::uint64_t>( change.delta );
        if( add ) {
            std::uint64_t reserved = 0;
            if( outstanding_liability != nullptr ) {
                const auto liability = std::find_if(
                                           outstanding_liability->begin(),
                                           outstanding_liability->end(), [&change](
                const basecamp_platform_resource_change & candidate ) {
                    return candidate.resource_id == change.resource_id;
                } );
                if( liability != outstanding_liability->end() ) {
                    reserved = static_cast<std::uint64_t>( liability->delta );
                }
            }
            if( reserved > static_cast<std::uint64_t>( std::numeric_limits<int>::max() ) -
                static_cast<std::uint64_t>( found->available ) ||
                amount > static_cast<std::uint64_t>( std::numeric_limits<int>::max() ) -
                static_cast<std::uint64_t>( found->available ) - reserved ) {
                error = "resource_work output or refund exceeds resource capacity";
                return false;
            }
            found->available += static_cast<int>( amount );
        } else if( amount > static_cast<std::uint64_t>( found->available ) ) {
            error = "resource_work input exceeds available resource quantity";
            return false;
        } else {
            found->available -= static_cast<int>( amount );
        }
    }

    for( const basecamp_platform_resource_change &change : changes ) {
        std::uint64_t remaining = static_cast<std::uint64_t>( change.delta );
        for( basecamp_resource &resource : resources ) {
            if( resource.fake_id != change.resource_id || remaining == 0 ) {
                continue;
            }
            if( add ) {
                const std::uint64_t room = static_cast<std::uint64_t>(
                                               std::numeric_limits<int>::max() - resource.available );
                const std::uint64_t applied = std::min( remaining, room );
                resource.available += static_cast<int>( applied );
                remaining -= applied;
            } else {
                const std::uint64_t applied = std::min( remaining,
                                                        static_cast<std::uint64_t>( resource.available ) );
                resource.available -= static_cast<int>( applied );
                remaining -= applied;
            }
        }
        if( remaining != 0 ) {
            error = add ? "resource_work could not apply the complete resource amount" :
                    "resource_work input exceeds available resource quantity";
            return false;
        }
    }
    return true;
}

bool apply_platform_resource_consumption(
    std::vector<basecamp_resource> &resources,
    const std::vector<basecamp_platform_resource_change> &changes,
    std::string &error )
{
    std::vector<basecamp_resource> normalized;
    if( !basecamp::platform_normalize_resources( resources, normalized, error ) ) {
        return false;
    }
    for( const basecamp_platform_resource_change &change : changes ) {
        const auto found = std::find_if( normalized.begin(), normalized.end(),
        [&change]( const basecamp_resource & resource ) {
            return resource.fake_id == change.resource_id;
        } );
        if( found == normalized.end() ) {
            error = "resource_work reservation refers to an unknown resource";
            return false;
        }
        if( static_cast<std::uint64_t>( change.delta ) >
            static_cast<std::uint64_t>( std::numeric_limits<int>::max() ) -
            static_cast<std::uint64_t>( found->consumed ) ) {
            error = "resource_work consumption bookkeeping would overflow";
            return false;
        }
    }
    for( const basecamp_platform_resource_change &change : changes ) {
        std::uint64_t remaining = static_cast<std::uint64_t>( change.delta );
        for( basecamp_resource &resource : resources ) {
            if( resource.fake_id != change.resource_id || remaining == 0 ) {
                continue;
            }
            const std::uint64_t room = static_cast<std::uint64_t>(
                                           std::numeric_limits<int>::max() - resource.consumed );
            const std::uint64_t applied = std::min( remaining, room );
            resource.consumed += static_cast<int>( applied );
            remaining -= applied;
        }
        if( remaining != 0 ) {
            error = "resource_work consumption bookkeeping would overflow";
            return false;
        }
    }
    return true;
}

faction *platform_task_owner( basecamp &camp, std::string &error )
{
    if( g == nullptr || camp.get_owner().is_null() ) {
        error = "resource_work owner faction is not available";
        return nullptr;
    }
    faction *owner = g->faction_manager_ptr->get( camp.get_owner(), false );
    if( owner == nullptr ) {
        error = "resource_work owner faction is not available";
        return nullptr;
    }
    return owner;
}

bool validate_platform_food_delta( const faction &owner, const std::int64_t delta,
                                   std::string &error,
                                   const std::int64_t outstanding_liability_kcal = 0 )
{
    if( delta == 0 ) {
        return true;
    }
    if( !owner.consumes_food ) {
        error = "resource_work food deltas require a consuming owner faction";
        return false;
    }
    const std::int64_t maximum_micro = maximum_platform_resource_work_amount * 1000;
    const std::int64_t current_micro = owner.food_supply().calories;
    if( current_micro < 0 || ( delta < 0 &&
                               -delta > current_micro / 1000 ) ) {
        error = "resource_work food input exceeds the owner supply";
        return false;
    }
    if( outstanding_liability_kcal < 0 ||
        outstanding_liability_kcal > maximum_platform_resource_work_amount ) {
        error = "resource_work outstanding food reservation exceeds owner capacity";
        return false;
    }
    const std::int64_t liability_micro = outstanding_liability_kcal * 1000;
    if( liability_micro > maximum_micro ||
        current_micro > maximum_micro - liability_micro ) {
        error = "resource_work outstanding food reservation exceeds owner capacity";
        return false;
    }
    if( delta > 0 && ( current_micro > maximum_micro - liability_micro ||
                       delta > ( maximum_micro - liability_micro - current_micro ) / 1000 ) ) {
        error = "resource_work food output or refund exceeds owner capacity";
        return false;
    }
    return true;
}

bool apply_platform_food_delta( faction &owner, const std::int64_t delta,
                                std::string &error,
                                const std::int64_t outstanding_liability_kcal = 0 )
{
    if( !validate_platform_food_delta( owner, delta, error,
                                       outstanding_liability_kcal ) ) {
        return false;
    }
    if( delta == 0 ) {
        return true;
    }
    const auto before = owner.debug_food_supply();
    if( delta < 0 ) {
        nutrients requested;
        requested.calories = ( -delta ) * 1000;
        const nutrients left = owner.consume_food_supply( requested );
        if( left.calories != 0 || !left.vitamins().empty() ) {
            owner.debug_food_supply() = before;
            error = "resource_work food reservation could not be applied atomically";
            return false;
        }
    } else {
        nutrients added;
        added.calories = delta * 1000;
        const nutrients applied = owner.add_to_food_supply(
        { { calendar::turn_zero, added } } );
        if( applied.calories != added.calories ) {
            owner.debug_food_supply() = before;
            error = "resource_work food output or refund was not applied atomically";
            return false;
        }
    }
    return true;
}

bool validate_empty_platform_task_parameters( const std::string_view parameters,
        std::string &error )
{
    if( !parameters.empty() ) {
        error = "Platform camp task kind '" +
                std::string( basecamp_platform_worker_reservation_kind ) +
                "' requires an empty parameter string";
        return false;
    }
    return true;
}

bool validate_resource_work_parameters( const std::string_view parameters,
                                        std::string &error )
{
    if( parameters != basecamp_platform_resource_work_parameter_schema ) {
        error = "resource_work requires parameter schema '" +
                std::string( basecamp_platform_resource_work_parameter_schema ) + "'";
        return false;
    }
    return true;
}

bool validate_recipe_work_parameters( const std::string_view parameters,
                                      std::string &error )
{
    if( parameters != basecamp_platform_recipe_work_parameter_schema ) {
        error = "recipe_work requires parameter schema '" +
                std::string( basecamp_platform_recipe_work_parameter_schema ) + "'";
        return false;
    }
    return true;
}

bool validate_upgrade_work_parameters( const std::string_view parameters,
                                       std::string &error )
{
    if( parameters != basecamp_platform_upgrade_work_parameter_schema ) {
        error = "upgrade_work requires parameter schema '" +
                std::string( basecamp_platform_upgrade_work_parameter_schema ) + "'";
        return false;
    }
    return true;
}

bool recipe_holders_equal( const basecamp_platform_recipe_holder &lhs,
                           const basecamp_platform_recipe_holder &rhs )
{
    return lhs.kind == rhs.kind && lhs.character == rhs.character &&
           lhs.identity_generation == rhs.identity_generation && lhs.slot == rhs.slot;
}

bool validate_recipe_holder( const basecamp_platform_recipe_holder &holder,
                             const char *label, std::string &error )
{
    if( holder.kind != basecamp_platform_recipe_holder_kind::character ||
        !holder.character.is_valid() || holder.identity_generation == 0 ||
        ( holder.slot != "inventory" && holder.slot != "worn" &&
          holder.slot != "wielded" ) ) {
        error = std::string( label ) +
                " must be a live generation-bound Character inventory holder";
        return false;
    }
    return true;
}

bool deserialize_platform_recipe_item( const std::string &serialized, item &result,
                                       std::string &error )
{
    if( serialized.empty() ) {
        error = "recipe_work escrow item serialization is empty";
        return false;
    }
    try {
        const JsonValue parsed = json_loader::from_string( serialized );
        if( !parsed.test_object() ) {
            error = "recipe_work escrow item is not a native item value";
            return false;
        }
        result.deserialize( parsed.get_object() );
    } catch( const std::exception &exception ) {
        error = std::string( "recipe_work escrow item cannot be restored: " ) +
                exception.what();
        return false;
    }
    if( result.is_null() || !result.uid().is_valid() ) {
        error = "recipe_work escrow item has no stable UID";
        return false;
    }
    return true;
}

bool serialize_platform_recipe_item( const item &value, std::string &serialized,
                                     std::string &error )
{
    if( value.is_null() || !value.uid().is_valid() ) {
        error = "recipe_work result has no stable Item UID";
        return false;
    }
    std::ostringstream buffer;
    JsonOut json( buffer );
    value.serialize( json );
    serialized = buffer.str();
    if( serialized.empty() ) {
        error = "recipe_work result serialization is empty";
        return false;
    }
    return true;
}

struct detached_recipe_item {
    basecamp_platform_recipe_escrow_item metadata;
    item value;
};

inventory make_detached_recipe_inventory(
    const std::vector<detached_recipe_item> &values )
{
    inventory result;
    for( const detached_recipe_item &entry : values ) {
        if( !entry.value.is_null() ) {
            result.add_item( entry.value, false, false, false );
        }
    }
    return result;
}

bool consume_detached_recipe_items(
    std::vector<detached_recipe_item> &values,
    const itype_id &type, const int quantity,
    const std::function<bool( const item & )> &filter,
    const bool in_tools, item_components *consumed,
    std::string &error )
{
    int remaining = quantity;
    for( auto entry = values.begin(); entry != values.end() && remaining > 0; ) {
        if( entry->metadata.tool != in_tools || entry->value.is_null() ) {
            ++entry;
            continue;
        }
        const bool root_matches = entry->value.typeId() == type && filter( entry->value );
        if( root_matches && !entry->value.is_container_empty() ) {
            error = "recipe_work cannot consume a non-empty escrow container";
            return false;
        }
        const int before = remaining;
        std::list<item> consumed_values;
        bool remove_root = false;
        if( item::count_by_charges( type ) ) {
            remove_root = entry->value.use_charges(
                              type, remaining, consumed_values,
                              tripoint_bub_ms::zero, filter, nullptr, in_tools );
        } else {
            remove_root = entry->value.use_amount(
                              type, remaining, consumed_values, filter );
        }
        if( consumed != nullptr && !in_tools ) {
            for( item &value : consumed_values ) {
                consumed->add( value );
            }
        }
        if( remove_root && root_matches ) {
            entry = values.erase( entry );
        } else {
            ++entry;
        }
        if( before == remaining && !remove_root ) {
            continue;
        }
    }
    if( remaining != 0 ) {
        error = "recipe_work detached escrow could not satisfy the selected requirement";
        return false;
    }
    return true;
}

bool consume_detached_requirement_data(
    const requirement_data &requirements,
    const std::function<bool( const item & )> &component_filter,
    const int batch, const std::string_view label,
    std::vector<detached_recipe_item> &values,
    item_components &consumed, std::string &error )
{
    const inventory all_items = make_detached_recipe_inventory( values );
    if( !requirements.can_make_with_inventory( all_items, component_filter, batch ) ) {
        error = std::string( label ) + " does not satisfy authoritative requirements";
        return false;
    }
    for( const std::vector<item_comp> &alternatives : requirements.get_components() ) {
        const inventory component_items = make_detached_recipe_inventory( values );
        const item_comp *choice = nullptr;
        for( const item_comp &candidate : alternatives ) {
            if( candidate.requirement ) {
                continue;
            }
            if( candidate.has( component_items, component_filter, batch ) ) {
                choice = &candidate;
                break;
            }
        }
        if( choice == nullptr ) {
            error = std::string( label ) +
                    " selected component alternative is not available in escrow";
            return false;
        }
        const std::int64_t requested = choice->count < 0 ?
                                       -static_cast<std::int64_t>( choice->count ) :
                                       static_cast<std::int64_t>( choice->count );
        if( requested <= 0 || requested > std::numeric_limits<int>::max() / batch ) {
            error = std::string( label ) + " component quantity is outside its safe bound";
            return false;
        }
        const std::int64_t total = requested * batch;
        if( !consume_detached_recipe_items(
                values, choice->type, static_cast<int>( total ),
                component_filter, false, &consumed, error ) ) {
            return false;
        }
    }

    for( const std::vector<tool_comp> &alternatives : requirements.get_tools() ) {
        const inventory tool_items = make_detached_recipe_inventory( values );
        const tool_comp *choice = nullptr;
        for( const tool_comp &candidate : alternatives ) {
            if( candidate.has( tool_items, return_true<item>, batch ) ) {
                choice = &candidate;
                break;
            }
        }
        if( choice == nullptr ) {
            error = std::string( label ) +
                    " selected tool alternative is not available in escrow";
            return false;
        }
        if( !choice->by_charges() ) {
            continue;
        }
        const itype *tool_type = item::find_type( choice->type );
        if( tool_type == nullptr ) {
            error = std::string( label ) + " selected an unknown tool type";
            return false;
        }
        const std::int64_t factor = tool_type->charge_factor();
        const std::int64_t total = static_cast<std::int64_t>( choice->count ) *
                                   batch * factor;
        if( factor <= 0 || total <= 0 || total > std::numeric_limits<int>::max() ) {
            error = std::string( label ) +
                    " tool charge requirement is outside its safe bound";
            return false;
        }
        if( !consume_detached_recipe_items(
                values, choice->type, static_cast<int>( total ),
                return_true<item>, true, nullptr, error ) ) {
            return false;
        }
    }
    return true;
}

bool select_and_consume_detached_recipe_requirements(
    const recipe &making, const basecamp_platform_recipe_work &work,
    Character &worker, std::vector<detached_recipe_item> &values,
    item_components &consumed, std::string &error )
{
    const std::function<bool( const item & )> component_filter =
        making.get_component_filter();
    const inventory all_items = make_detached_recipe_inventory( values );
    const requirement_data *selected = making.deduped_requirements().select_alternative(
                                           worker, all_items, component_filter, work.batch );
    if( selected == nullptr ) {
        error = "recipe_work authoritative requirement selection was cancelled or unavailable";
        return false;
    }
    return consume_detached_requirement_data( *selected, component_filter, work.batch,
            "recipe_work escrow", values, consumed, error );
}

bool recipe_escrow_shape_matches_work(
    const basecamp_platform_recipe_work &work,
    const std::vector<basecamp_platform_recipe_escrow_item> &escrow,
    std::string &error )
{
    if( escrow.empty() || escrow.size() > maximum_platform_recipe_escrow_items ) {
        error = "recipe_work requires a bounded non-empty exact Item escrow";
        return false;
    }
    std::set<std::int64_t> seen_uids;
    for( const basecamp_platform_recipe_escrow_item &entry : escrow ) {
        if( entry.stable_uid <= 0 || entry.identity_generation == 0 ||
            entry.charges <= 0 || !seen_uids.insert( entry.stable_uid ).second ) {
            error = "recipe_work escrow contains a duplicate or invalid Item identity";
            return false;
        }
        const auto holder = std::find_if( work.source_holders.begin(),
        work.source_holders.end(), [&entry]( const basecamp_platform_recipe_holder & candidate ) {
            return recipe_holders_equal( entry.source_holder, candidate );
        } );
        const bool is_output_holder = !entry.tool && recipe_holders_equal(
                                          entry.source_holder, work.destination_holder );
        if( holder == work.source_holders.end() && !is_output_holder ) {
            error = "recipe_work escrow source holder is not in its descriptor";
            return false;
        }
        item value;
        std::string item_error;
        if( !deserialize_platform_recipe_item( entry.serialized_item, value, item_error ) ) {
            error = item_error;
            return false;
        }
        if( value.uid().get_value() != entry.stable_uid ||
            ( value.count_by_charges() ? value.charges : 1 ) != entry.charges ) {
            error = "recipe_work escrow Item identity or charges do not match its value";
            return false;
        }
        if( entry.tool && entry.charges != ( value.count_by_charges() ? value.charges : 1 ) ) {
            error = "recipe_work tool escrow must retain the complete owning Item";
            return false;
        }
    }
    return true;
}

bool recipe_escrow_matches_work( const basecamp_platform_recipe_work &work,
                                 const std::vector<basecamp_platform_recipe_escrow_item> &escrow,
                                 const Character *worker, std::string &error )
{
    if( worker == nullptr || !recipe_escrow_shape_matches_work( work, escrow, error ) ) {
        return false;
    }
    const ::recipe_id recipe_ident( work.recipe_id );
    if( !recipe_ident.is_valid() ) {
        error = "recipe_work refers to an unknown recipe";
        return false;
    }
    const recipe &making = recipe_ident.obj();
    if( making.result().is_null() || making.is_blueprint() || making.is_nested() ||
        making.is_practice() || making.obsolete || making.is_blacklisted() ) {
        error = "recipe_work recipe is not a craftable concrete recipe";
        return false;
    }
    if( !worker->knows_recipe( &making ) ||
        !worker->meets_skill_requirements( making.required_skills ) ) {
        error = "recipe_work worker does not know or meet the recipe skills";
        return false;
    }
    for( const proficiency_id &proficiency : making.required_proficiencies() ) {
        if( !worker->has_proficiency( proficiency ) ) {
            error = "recipe_work worker lacks a required recipe proficiency";
            return false;
        }
    }
    const time_duration expected_duration = making.batch_duration(
            *worker,
            crafting_cost_context::for_recipe( *worker, making ),
            work.batch );
    if( to_turns<std::int64_t>( expected_duration ) != work.duration_turns ) {
        error = "recipe_work duration does not match the authoritative recipe duration";
        return false;
    }

    inventory escrow_inventory;
    for( const basecamp_platform_recipe_escrow_item &entry : escrow ) {
        item value;
        std::string item_error;
        if( !deserialize_platform_recipe_item( entry.serialized_item, value, item_error ) ) {
            error = item_error;
            return false;
        }
        escrow_inventory.add_item( std::move( value ), false, false, false );
    }
    if( !making.deduped_requirements().can_make_with_inventory(
            escrow_inventory, making.get_component_filter(), work.batch ) ) {
        error = "recipe_work escrow does not satisfy authoritative recipe requirements";
        return false;
    }
    return true;
}

bool upgrade_escrow_shape_matches_work(
    const basecamp_platform_upgrade_work &work,
    const std::vector<basecamp_platform_recipe_escrow_item> &escrow,
    std::string &error )
{
    if( escrow.empty() || escrow.size() > maximum_platform_recipe_escrow_items ) {
        error = "upgrade_work requires a bounded non-empty exact Item escrow";
        return false;
    }
    std::set<std::int64_t> seen_uids;
    for( const basecamp_platform_recipe_escrow_item &entry : escrow ) {
        if( entry.stable_uid <= 0 || entry.identity_generation == 0 ||
            entry.charges <= 0 || !seen_uids.insert( entry.stable_uid ).second ) {
            error = "upgrade_work escrow contains a duplicate or invalid Item identity";
            return false;
        }
        const bool known_holder = std::any_of( work.source_holders.begin(),
        work.source_holders.end(), [&entry]( const basecamp_platform_recipe_holder & holder ) {
            return recipe_holders_equal( entry.source_holder, holder );
        } );
        if( !known_holder ) {
            error = "upgrade_work escrow source holder is not in its descriptor";
            return false;
        }
        item value;
        std::string item_error;
        if( !deserialize_platform_recipe_item( entry.serialized_item, value, item_error ) ) {
            error = item_error;
            return false;
        }
        if( value.uid().get_value() != entry.stable_uid ||
            ( value.count_by_charges() ? value.charges : 1 ) != entry.charges ) {
            error = "upgrade_work escrow Item identity or charges do not match its value";
            return false;
        }
        if( entry.tool && entry.charges != ( value.count_by_charges() ? value.charges : 1 ) ) {
            error = "upgrade_work tool escrow must retain the complete owning Item";
            return false;
        }
    }
    return true;
}

bool upgrade_escrow_matches_work( const basecamp_platform_upgrade_work &work,
                                  const std::vector<basecamp_platform_recipe_escrow_item> &escrow,
                                  const Character *worker, std::string &error )
{
    if( worker == nullptr || !upgrade_escrow_shape_matches_work( work, escrow, error ) ) {
        return false;
    }
    const ::recipe_id upgrade_ident( work.upgrade_id );
    if( !upgrade_ident.is_valid() ) {
        error = "upgrade_work refers to an unknown blueprint recipe";
        return false;
    }
    const recipe &upgrade = upgrade_ident.obj();
    const auto requirements = upgrade.blueprint_build_reqs().reqs_by_parameters.find(
                                  work.mapgen_args );
    if( requirements == upgrade.blueprint_build_reqs().reqs_by_parameters.end() ) {
        error = "upgrade_work has no authoritative requirements for its mapgen arguments";
        return false;
    }
    if( !worker->meets_skill_requirements( requirements->second.skills ) ) {
        error = "upgrade_work worker does not meet the blueprint skills";
        return false;
    }
    inventory escrow_inventory;
    for( const basecamp_platform_recipe_escrow_item &entry : escrow ) {
        item value;
        std::string item_error;
        if( !deserialize_platform_recipe_item( entry.serialized_item, value, item_error ) ) {
            error = item_error;
            return false;
        }
        escrow_inventory.add_item( std::move( value ), false, false, false );
    }
    if( !requirements->second.consolidated_reqs.can_make_with_inventory(
            escrow_inventory, upgrade.get_component_filter(), 1 ) ) {
        error = "upgrade_work escrow does not satisfy authoritative blueprint requirements";
        return false;
    }
    return true;
}

const std::array<basecamp_platform_task_kind_executor, 4> &platform_task_executors()
{
    static const std::array<basecamp_platform_task_kind_executor, 4> executors = {{
            {
                basecamp_platform_worker_reservation_kind,
                "empty",
                true,
                true,
                true,
                true,
                true,
                validate_empty_platform_task_parameters,
                dispatch_worker_reservation_task
            },
            {
                basecamp_platform_resource_work_kind,
                "resource_work_v1",
                true,
                true,
                true,
                true,
                true,
                validate_resource_work_parameters,
                dispatch_resource_work_task
            },
            {
                basecamp_platform_recipe_work_kind,
                "recipe_work_v1",
                true,
                true,
                true,
                true,
                true,
                validate_recipe_work_parameters,
                dispatch_recipe_work_task
            },
            {
                basecamp_platform_upgrade_work_kind,
                "upgrade_work_v1",
                true,
                true,
                true,
                true,
                true,
                validate_upgrade_work_parameters,
                dispatch_upgrade_work_task
            }
        }
    };
    return executors;
}

std::string_view platform_task_operation_name( const basecamp_platform_task_operation operation )
{
    switch( operation ) {
        case basecamp_platform_task_operation::preflight:
            return "preflight";
        case basecamp_platform_task_operation::resolve:
            return "resolve";
        case basecamp_platform_task_operation::start:
            return "start";
        case basecamp_platform_task_operation::cancel:
            return "cancel";
        case basecamp_platform_task_operation::complete:
            return "complete";
    }
    return "unknown";
}

bool platform_task_operation_supported( const basecamp_platform_task_kind_executor &executor,
                                        const basecamp_platform_task_operation operation )
{
    switch( operation ) {
        case basecamp_platform_task_operation::preflight:
            return executor.supports_preflight;
        case basecamp_platform_task_operation::resolve:
            return executor.supports_resolve;
        case basecamp_platform_task_operation::start:
            return executor.supports_start;
        case basecamp_platform_task_operation::cancel:
            return executor.supports_cancel;
        case basecamp_platform_task_operation::complete:
            return executor.supports_complete;
    }
    return false;
}

bool dispatch_worker_reservation_task(
    const basecamp_platform_task_operation operation,
    basecamp_platform_task_execution_context &context, std::string &error )
{
    if( context.task == nullptr ) {
        error = "worker reservation executor requires a task context";
        return false;
    }
    if( !validate_empty_platform_task_parameters( context.task->parameters, error ) ) {
        return false;
    }

    switch( operation ) {
        case basecamp_platform_task_operation::preflight:
            if( context.task->state != basecamp_platform_task_state::pending ||
                context.task->started_at != calendar::before_time_starts ||
                context.task->due_at != calendar::before_time_starts ||
                context.task->finished_at ) {
                error = "worker reservation task has invalid initial state";
                return false;
            }
            return true;
        case basecamp_platform_task_operation::resolve:
            return true;
        case basecamp_platform_task_operation::start:
            if( context.camp == nullptr || !context.worker ||
                context.staged_assigned == nullptr || context.staged_tasks == nullptr ) {
                error = "worker reservation start requires camp, worker, and staging context";
                return false;
            }
            if( !context.worker->getID().is_valid() || context.worker->is_dead() ) {
                error = "worker is not live";
                return false;
            }
            if( context.duration < 0_turns ||
                context.duration > time_duration::from_turns( 1000000 ) ||
                context.now == calendar::before_time_starts ) {
                error = "task duration or start time is outside its bound";
                return false;
            }
            if( context.task->state != basecamp_platform_task_state::pending ) {
                error = "task is not pending";
                return false;
            }
            if( context.task->worker != context.worker->getID() ||
                context.task->worker_identity_generation !=
                context.worker->platform_identity_generation() ) {
                error = "worker identity does not match the task";
                return false;
            }
            if( context.worker->get_faction() == nullptr ||
                context.worker->get_faction()->id != context.camp->get_owner() ) {
                error = "worker does not belong to the camp owner";
                return false;
            }
            if( context.worker->assigned_camp ||
                context.camp->has_exact_worker( *context.worker ) ) {
                error = "worker is already assigned";
                return false;
            }
            if( std::any_of( context.staged_tasks->begin(), context.staged_tasks->end(),
            [&context]( const basecamp_platform_task & candidate ) {
            const bool active = candidate.task_id != context.task->task_id &&
                                ( candidate.state == basecamp_platform_task_state::pending ||
                                  candidate.state == basecamp_platform_task_state::running );
                return active && candidate.worker == context.worker->getID() &&
                       candidate.worker_identity_generation ==
                       context.worker->platform_identity_generation();
            } ) ) {
                error = "worker already has another active Platform camp task";
                return false;
            }
            context.staged_assigned->push_back( context.worker );
            context.task->state = basecamp_platform_task_state::running;
            context.task->started_at = context.now;
            context.task->due_at = context.now + context.duration;
            context.task->finished_at.reset();
            context.task->awaiting_reconciliation = false;
            context.worker->assigned_camp = context.camp->camp_omt_pos();
            return true;
        case basecamp_platform_task_operation::cancel:
        case basecamp_platform_task_operation::complete: {
            if( context.camp == nullptr || !context.worker ||
                context.staged_assigned == nullptr ) {
                error = "worker reservation finish requires camp, worker, and staging context";
                return false;
            }
            if( !context.worker->getID().is_valid() || context.worker->is_dead() ) {
                error = "worker is not live";
                return false;
            }
            if( context.task->worker != context.worker->getID() ||
                context.task->worker_identity_generation !=
                context.worker->platform_identity_generation() ) {
                error = "worker identity does not match the task";
                return false;
            }
            const bool task_active = context.task->state ==
                                     basecamp_platform_task_state::pending ||
                                     context.task->state ==
                                     basecamp_platform_task_state::running;
            if( context.complete ) {
                if( context.task->state != basecamp_platform_task_state::running ) {
                    error = "only a running task can complete";
                    return false;
                }
                if( context.now == calendar::before_time_starts ||
                    context.now < context.task->due_at ) {
                    error = "task is not due";
                    return false;
                }
            } else if( !task_active ) {
                error = "task is not active";
                return false;
            }

            if( context.task->state == basecamp_platform_task_state::running ) {
                if( !context.worker->assigned_camp ||
                    *context.worker->assigned_camp != context.camp->camp_omt_pos() ) {
                    error = "task reservation is missing";
                    return false;
                }
                const auto worker_it = std::find_if(
                                           context.staged_assigned->begin(), context.staged_assigned->end(),
                [&context]( const npc_ptr & candidate ) {
                    return candidate && candidate.get() == context.worker.get();
                } );
                if( worker_it == context.staged_assigned->end() ) {
                    error = "task worker reservation is not owned by this camp";
                    return false;
                }
                context.staged_assigned->erase( worker_it );
                context.worker->assigned_camp.reset();
            } else if( context.worker->assigned_camp ||
                       context.camp->has_exact_worker( *context.worker ) ) {
                error = "pending task worker reservation was changed externally";
                return false;
            }
            if( context.task->identity_generation ==
                std::numeric_limits<std::uint64_t>::max() ) {
                error = "task generation cannot be retired";
                return false;
            }
            ++context.task->identity_generation;
            context.task->state = context.complete ?
                                  basecamp_platform_task_state::completed :
                                  basecamp_platform_task_state::cancelled;
            context.task->finished_at = context.now;
            context.task->awaiting_reconciliation = false;
            return true;
        }
    }
    error = "unknown worker reservation operation";
    return false;
}

bool dispatch_resource_work_task(
    const basecamp_platform_task_operation operation,
    basecamp_platform_task_execution_context &context, std::string &error )
{
    if( context.task == nullptr ) {
        error = "resource_work executor requires a task context";
        return false;
    }
    if( !validate_resource_work_parameters(
            context.task->parameters, error ) ) {
        return false;
    }
    if( !context.task->resource_work ) {
        error = "resource_work task is missing its typed descriptor";
        return false;
    }
    const basecamp_platform_resource_work &work = *context.task->resource_work;
    if( !validate_basecamp_platform_resource_work( work, error ) ) {
        return false;
    }
    if( context.camp == nullptr ||
        ( context.staged_resources != nullptr &&
          !validate_resource_work_against_resources(
              *context.staged_resources, work, error ) ) ||
        ( context.staged_resources == nullptr &&
          !validate_resource_work_against_camp( *context.camp, work, error ) ) ) {
        return false;
    }

    const std::int64_t food_input = work.food_input_kcal.value_or( 0 );
    const std::int64_t food_output = work.food_output_kcal.value_or( 0 );
    const auto ledger_matches_work = [&]() {
        return resource_change_sets_equal( context.task->reserved_resources,
                                           work.resource_inputs ) &&
               context.task->reserved_food_kcal == food_input;
    };

    switch( operation ) {
        case basecamp_platform_task_operation::preflight:
            if( context.task->state != basecamp_platform_task_state::pending ||
                context.task->started_at != calendar::before_time_starts ||
                context.task->due_at != calendar::before_time_starts ||
                context.task->finished_at ||
                !context.task->reserved_resources.empty() ||
                context.task->reserved_food_kcal != 0 ) {
                error = "resource_work task has invalid initial state";
                return false;
            }
            return true;
        case basecamp_platform_task_operation::resolve:
            if( context.task->state == basecamp_platform_task_state::running &&
                !ledger_matches_work() ) {
                error = "resource_work reservation ledger does not match its descriptor";
                return false;
            }
            if( context.task->state != basecamp_platform_task_state::running &&
                ( !context.task->reserved_resources.empty() ||
                  context.task->reserved_food_kcal != 0 ) ) {
                error = "terminal or pending resource_work task retains a reservation";
                return false;
            }
            return true;
        case basecamp_platform_task_operation::start: {
            if( !context.worker || context.staged_assigned == nullptr ||
                context.staged_tasks == nullptr || context.staged_resources == nullptr ) {
                error = "resource_work start requires camp, worker, and staging context";
                return false;
            }
            if( context.task->state != basecamp_platform_task_state::pending ||
                context.now == calendar::before_time_starts ||
                context.duration != time_duration::from_turns( work.duration_turns ) ) {
                error = "resource_work start time or duration does not match its descriptor";
                return false;
            }
            if( !context.worker->getID().is_valid() || context.worker->is_dead() ||
                context.worker->get_faction() == nullptr ||
                context.worker->get_faction()->id != context.camp->get_owner() ) {
                error = "resource_work worker is not a live member of the camp owner";
                return false;
            }
            if( context.task->worker != context.worker->getID() ||
                context.task->worker_identity_generation !=
                context.worker->platform_identity_generation() ) {
                error = "resource_work worker identity does not match the task";
                return false;
            }
            if( context.worker->assigned_camp ||
                context.camp->has_exact_worker( *context.worker ) ) {
                error = "resource_work worker is already assigned";
                return false;
            }
            if( std::any_of( context.staged_tasks->begin(), context.staged_tasks->end(),
            [&context]( const basecamp_platform_task & candidate ) {
            const bool active = candidate.task_id != context.task->task_id &&
                                ( candidate.state == basecamp_platform_task_state::pending ||
                                  candidate.state == basecamp_platform_task_state::running );
                return active && candidate.worker == context.worker->getID() &&
                       candidate.worker_identity_generation ==
                       context.worker->platform_identity_generation();
            } ) ) {
                error = "resource_work worker already has another active task";
                return false;
            }
            if( !apply_platform_resource_availability(
                    *context.staged_resources, work.resource_inputs, false, error ) ) {
                return false;
            }
            if( food_input != 0 ) {
                faction *owner = platform_task_owner( *context.camp, error );
                if( owner == nullptr ||
                    !validate_platform_food_delta( *owner, -food_input, error ) ) {
                    return false;
                }
            }
            context.task->reserved_resources = work.resource_inputs;
            context.task->reserved_food_kcal = food_input;
            context.task->state = basecamp_platform_task_state::running;
            context.task->started_at = context.now;
            context.task->due_at = context.now + context.duration;
            context.task->finished_at.reset();
            context.task->reservation_discarded = false;
            context.task->awaiting_reconciliation = false;
            context.staged_assigned->push_back( context.worker );
            context.staged_food_delta_kcal = -food_input;
            context.commit_worker_assignment = true;
            return true;
        }
        case basecamp_platform_task_operation::cancel:
        case basecamp_platform_task_operation::complete: {
            if( !context.worker || context.staged_assigned == nullptr ||
                context.staged_resources == nullptr ) {
                error = "resource_work finish requires camp, worker, and staging context";
                return false;
            }
            if( !context.worker->getID().is_valid() || context.worker->is_dead() ||
                context.worker->get_faction() == nullptr ||
                context.worker->get_faction()->id != context.camp->get_owner() ) {
                error = "resource_work worker is not live for this operation";
                return false;
            }
            const bool running = context.task->state == basecamp_platform_task_state::running;
            if( context.complete ) {
                if( !running || context.now == calendar::before_time_starts ||
                    context.now < context.task->due_at ) {
                    error = "resource_work task is not due for completion";
                    return false;
                }
                if( !ledger_matches_work() ) {
                    error = "resource_work reservation ledger is inconsistent";
                    return false;
                }
            } else if( !platform_task_is_active( *context.task ) ) {
                error = "resource_work task is not active";
                return false;
            }

            if( running ) {
                if( !context.worker->assigned_camp ||
                    *context.worker->assigned_camp != context.camp->camp_omt_pos() ) {
                    error = "resource_work worker reservation is missing";
                    return false;
                }
                const auto assigned = std::find_if(
                                          context.staged_assigned->begin(),
                context.staged_assigned->end(), [&context]( const npc_ptr & candidate ) {
                    return candidate && candidate.get() == context.worker.get();
                } );
                if( assigned == context.staged_assigned->end() ) {
                    error = "resource_work reservation is not owned by this camp";
                    return false;
                }
            } else if( context.complete ) {
                error = "resource_work completion requires a running task";
                return false;
            }
            if( running && !ledger_matches_work() ) {
                error = "resource_work reservation ledger is inconsistent";
                return false;
            }

            std::vector<basecamp_platform_resource_change> outstanding_resources;
            std::int64_t outstanding_food_kcal = 0;
            if( !context.camp->platform_reservation_liability(
                    outstanding_resources, outstanding_food_kcal,
                    error, context.task->task_id ) ) {
                return false;
            }
            context.staged_food_liability_kcal = outstanding_food_kcal;

            if( context.complete ) {
                if( !apply_platform_resource_consumption(
                        *context.staged_resources, context.task->reserved_resources, error ) ||
                    !apply_platform_resource_availability(
                        *context.staged_resources, work.resource_outputs, true, error,
                        &outstanding_resources ) ) {
                    return false;
                }
                if( food_output != 0 ) {
                    faction *owner = platform_task_owner( *context.camp, error );
                    if( owner == nullptr ||
                        !validate_platform_food_delta( *owner, food_output, error,
                                                       outstanding_food_kcal ) ) {
                        return false;
                    }
                }
                context.staged_food_delta_kcal = food_output;
            } else if( running ) {
                if( !apply_platform_resource_availability(
                        *context.staged_resources, context.task->reserved_resources,
                        true, error, &outstanding_resources ) ) {
                    return false;
                }
                if( context.task->reserved_food_kcal != 0 ) {
                    faction *owner = platform_task_owner( *context.camp, error );
                    if( owner == nullptr ||
                        !validate_platform_food_delta(
                            *owner, context.task->reserved_food_kcal, error,
                            outstanding_food_kcal ) ) {
                        return false;
                    }
                }
                context.staged_food_delta_kcal = context.task->reserved_food_kcal;
            }

            if( running ) {
                const auto assigned = std::find_if(
                                          context.staged_assigned->begin(),
                context.staged_assigned->end(), [&context]( const npc_ptr & candidate ) {
                    return candidate && candidate.get() == context.worker.get();
                } );
                if( assigned != context.staged_assigned->end() ) {
                    context.staged_assigned->erase( assigned );
                }
                context.commit_worker_release = true;
            }
            context.task->reserved_resources.clear();
            context.task->reserved_food_kcal = 0;
            if( context.task->identity_generation ==
                std::numeric_limits<std::uint64_t>::max() ) {
                error = "resource_work task generation cannot be retired";
                return false;
            }
            ++context.task->identity_generation;
            context.task->state = context.complete ?
                                  basecamp_platform_task_state::completed :
                                  basecamp_platform_task_state::cancelled;
            context.task->finished_at = context.now;
            context.task->reservation_discarded = false;
            context.task->awaiting_reconciliation = false;
            return true;
        }
    }
    error = "unknown resource_work operation";
    return false;
}

bool recipe_escrow_equal(
    const std::vector<basecamp_platform_recipe_escrow_item> &lhs,
    const std::vector<basecamp_platform_recipe_escrow_item> &rhs )
{
    if( lhs.size() != rhs.size() ) {
        return false;
    }
    for( std::size_t index = 0; index < lhs.size(); ++index ) {
        const basecamp_platform_recipe_escrow_item &left = lhs[index];
        const basecamp_platform_recipe_escrow_item &right = rhs[index];
        if( left.stable_uid != right.stable_uid ||
            left.identity_generation != right.identity_generation ||
            left.charges != right.charges || left.tool != right.tool ||
            left.serialized_item != right.serialized_item ||
            !recipe_holders_equal( left.source_holder, right.source_holder ) ) {
            return false;
        }
    }
    return true;
}

bool dispatch_upgrade_work_task(
    const basecamp_platform_task_operation operation,
    basecamp_platform_task_execution_context &context, std::string &error )
{
    if( context.task == nullptr ) {
        error = "upgrade_work executor requires a task context";
        return false;
    }
    const bool isolated_recovery =
        operation == basecamp_platform_task_operation::resolve &&
        context.task->recipe_recovery_required &&
        context.task->state == basecamp_platform_task_state::refund_pending &&
        !context.task->recipe_escrow.empty();
    if( !validate_upgrade_work_parameters( context.task->parameters, error ) ) {
        return false;
    }
    if( !isolated_recovery && !context.task->upgrade_work ) {
        error = "upgrade_work executor requires a typed task descriptor";
        return false;
    }
    if( !isolated_recovery &&
        !validate_basecamp_platform_upgrade_work( *context.task->upgrade_work, error ) ) {
        return false;
    }
    if( isolated_recovery ) {
        return operation == basecamp_platform_task_operation::resolve;
    }

    basecamp_platform_upgrade_work &work = *context.task->upgrade_work;
    switch( operation ) {
        case basecamp_platform_task_operation::preflight:
            if( context.upgrade_completion && context.upgrade_prepare_only ) {
                if( context.camp == nullptr || context.worker == nullptr ||
                    context.recipe_original_escrow == nullptr ||
                    context.recipe_escrow == nullptr ||
                    context.task->state != basecamp_platform_task_state::running ||
                    context.task->upgrade_commit_marker != 0 ||
                    context.task->upgrade_applying_marker != 0 ||
                    context.now == calendar::before_time_starts ||
                    context.now < context.task->due_at ||
                    !recipe_escrow_equal( context.task->recipe_escrow,
                                          *context.recipe_original_escrow ) ||
                    context.worker->is_dead() ||
                    context.worker->getID() != context.task->worker ||
                    context.worker->platform_identity_generation() !=
                    context.task->worker_identity_generation ) {
                    error = "upgrade_work completion preflight has a stale task, worker, or escrow";
                    return false;
                }
                if( !context.camp->platform_validate_upgrade_target( work, error ) ||
                    !upgrade_escrow_matches_work( work, context.task->recipe_escrow,
                                                  context.worker.get(), error ) ) {
                    return false;
                }
                if( !context.recipe_escrow->empty() &&
                    !upgrade_escrow_shape_matches_work( work, *context.recipe_escrow,
                                                        error ) ) {
                    return false;
                }
                if( context.task->identity_generation ==
                    std::numeric_limits<std::uint64_t>::max() ) {
                    error = "upgrade_work task generation cannot be retired";
                    return false;
                }
                // This copy is part of the pre-mapgen staged transaction.  No
                // item vector or allocation is needed after mapgen succeeds.
                context.task->recipe_escrow = *context.recipe_escrow;
                context.task->upgrade_applying_marker = context.task->identity_generation;
                return true;
            }
            if( context.task->state != basecamp_platform_task_state::pending ||
                context.task->started_at != calendar::before_time_starts ||
                context.task->due_at != calendar::before_time_starts ||
                context.task->finished_at || !context.task->recipe_escrow.empty() ||
                context.task->upgrade_commit_marker != 0 ||
                context.task->upgrade_applying_marker != 0 ) {
                error = "upgrade_work task has invalid initial state";
                return false;
            }
            return true;
        case basecamp_platform_task_operation::resolve:
            if( context.task->upgrade_applying_marker != 0 ) {
                error = "upgrade_work task requires authoritative applying-marker recovery";
                return false;
            }
            if( ( context.task->state == basecamp_platform_task_state::running &&
                  context.task->upgrade_commit_marker != 0 ) ||
                ( context.task->state == basecamp_platform_task_state::refund_pending &&
                  context.task->upgrade_commit_marker != 0 ) ||
                ( context.task->state == basecamp_platform_task_state::completed_unclaimed &&
                  context.task->upgrade_commit_marker == 0 ) ) {
                error = "upgrade_work task has an invalid settlement commit marker";
                return false;
            }
            if( context.task->state == basecamp_platform_task_state::running ||
                context.task->state == basecamp_platform_task_state::refund_pending ||
                context.task->state == basecamp_platform_task_state::completed_unclaimed ) {
                if( context.task->recipe_escrow.empty() ||
                    !upgrade_escrow_shape_matches_work( work,
                                                        context.task->recipe_escrow, error ) ) {
                    return false;
                }
            } else if( !context.task->recipe_escrow.empty() ) {
                error = "non-running upgrade_work task retains an escrow";
                return false;
            }
            return true;
        case basecamp_platform_task_operation::start: {
            if( context.camp == nullptr || context.worker == nullptr ||
                context.staged_tasks == nullptr || context.staged_assigned == nullptr ||
                context.recipe_escrow == nullptr ) {
                error = "upgrade_work start requires camp, worker, and escrow staging context";
                return false;
            }
            if( context.task->state != basecamp_platform_task_state::pending ||
                context.now == calendar::before_time_starts ||
                context.duration != time_duration::from_turns( work.duration_turns ) ) {
                error = "upgrade_work start time or duration does not match its descriptor";
                return false;
            }
            if( !context.worker->getID().is_valid() || context.worker->is_dead() ||
                context.worker->get_faction() == nullptr ||
                context.worker->get_faction()->id != context.camp->get_owner() ||
                context.task->worker != context.worker->getID() ||
                context.task->worker_identity_generation !=
                context.worker->platform_identity_generation() ) {
                error = "upgrade_work worker identity or owner is not live";
                return false;
            }
            if( context.worker->assigned_camp || context.camp->has_exact_worker( *context.worker ) ) {
                error = "upgrade_work worker is already assigned";
                return false;
            }
            if( std::any_of( context.staged_tasks->begin(), context.staged_tasks->end(),
            [&context]( const basecamp_platform_task & candidate ) {
            return candidate.task_id != context.task->task_id &&
                   platform_task_is_active( candidate ) &&
                       candidate.worker == context.worker->getID() &&
                       candidate.worker_identity_generation ==
                       context.worker->platform_identity_generation();
            } ) ) {
                error = "upgrade_work worker already has another active task";
                return false;
            }
            if( !context.camp->platform_validate_upgrade_target( work, error ) ||
                !upgrade_escrow_matches_work( work, *context.recipe_escrow,
                                              context.worker.get(), error ) ) {
                return false;
            }
            context.task->recipe_escrow = *context.recipe_escrow;
            context.task->state = basecamp_platform_task_state::running;
            context.task->started_at = context.now;
            context.task->due_at = context.now + context.duration;
            context.task->finished_at.reset();
            context.task->upgrade_commit_marker = 0;
            context.task->upgrade_applying_marker = 0;
            context.task->awaiting_reconciliation = false;
            context.staged_assigned->push_back( context.worker );
            context.commit_worker_assignment = true;
            return true;
        }
        case basecamp_platform_task_operation::cancel: {
            if( context.recipe_claim ) {
                if( ( context.task->state != basecamp_platform_task_state::refund_pending &&
                      context.task->state != basecamp_platform_task_state::completed_unclaimed ) ||
                    context.recipe_escrow == nullptr ||
                    !recipe_escrow_equal( context.task->recipe_escrow,
                                          *context.recipe_escrow ) ||
                    ( context.task->state == basecamp_platform_task_state::refund_pending &&
                      context.task->upgrade_commit_marker != 0 ) ||
                    ( context.task->state == basecamp_platform_task_state::completed_unclaimed &&
                      context.task->upgrade_commit_marker == 0 ) ) {
                    error = "upgrade_work escrow claim does not match the persisted task";
                    return false;
                }
                if( context.task->identity_generation ==
                    std::numeric_limits<std::uint64_t>::max() ) {
                    error = "upgrade_work task generation cannot be retired";
                    return false;
                }
                ++context.task->identity_generation;
                context.task->recipe_escrow.clear();
                context.task->upgrade_commit_marker = 0;
                context.task->upgrade_applying_marker = 0;
                context.task->state = context.complete ?
                                      basecamp_platform_task_state::completed :
                                      basecamp_platform_task_state::cancelled;
                context.task->finished_at = context.now;
                context.task->awaiting_reconciliation = false;
                return true;
            }
            if( context.camp == nullptr || context.worker == nullptr ||
                context.staged_assigned == nullptr || context.task->state !=
                basecamp_platform_task_state::running ||
                context.task->recipe_escrow.empty() || context.worker->is_dead() ||
                context.worker->getID() != context.task->worker ||
                context.worker->platform_identity_generation() !=
                context.task->worker_identity_generation ) {
                error = "upgrade_work cancel requires the exact live worker and running escrow";
                return false;
            }
            const auto assigned = std::find_if( context.staged_assigned->begin(),
            context.staged_assigned->end(), [&context]( const npc_ptr & candidate ) {
                return candidate && candidate.get() == context.worker.get();
            } );
            if( assigned == context.staged_assigned->end() ) {
                error = "upgrade_work worker reservation is not owned by this camp";
                return false;
            }
            if( context.task->identity_generation ==
                std::numeric_limits<std::uint64_t>::max() ) {
                error = "upgrade_work task generation cannot be retired";
                return false;
            }
            context.staged_assigned->erase( assigned );
            context.commit_worker_release = true;
            ++context.task->identity_generation;
            context.task->upgrade_commit_marker = 0;
            context.task->upgrade_applying_marker = 0;
            context.task->state = basecamp_platform_task_state::refund_pending;
            context.task->finished_at.reset();
            context.task->awaiting_reconciliation = false;
            return true;
        }
        case basecamp_platform_task_operation::complete:
            if( context.recipe_claim ) {
                // Claiming a completed escrow is a terminal no-fail operation;
                // the item transfer was preflighted by the Lua holder layer.
                if( context.task->identity_generation ==
                    std::numeric_limits<std::uint64_t>::max() ) {
                    error = "upgrade_work task generation cannot be retired";
                    return false;
                }
                ++context.task->identity_generation;
                context.task->recipe_escrow.clear();
                context.task->upgrade_commit_marker = 0;
                context.task->upgrade_applying_marker = 0;
                context.task->state = context.complete ?
                                      basecamp_platform_task_state::completed :
                                      basecamp_platform_task_state::cancelled;
                context.task->finished_at = context.now;
                context.task->awaiting_reconciliation = false;
                return true;
            }
            if( !context.upgrade_completion || context.upgrade_prepare_only ) {
                error = "upgrade_work completion requires the transactional upgrade path";
                return false;
            }
            if( context.upgrade_commit_ready ) {
                // All fallible work, including the vector copy, was completed
                // before mapgen.  This branch only publishes already-staged
                // scalar state and removes the known worker reservation.
                context.task->upgrade_commit_marker = context.task->identity_generation;
                context.task->upgrade_applying_marker = 0;
                context.task->state = context.task->recipe_escrow.empty() ?
                                      basecamp_platform_task_state::completed :
                                      basecamp_platform_task_state::completed_unclaimed;
                context.task->finished_at = context.now;
                if( context.staged_assigned != nullptr && context.worker != nullptr ) {
                    const auto assigned = std::find_if(
                                              context.staged_assigned->begin(), context.staged_assigned->end(),
                    [&context]( const npc_ptr & candidate ) {
                        return candidate && candidate.get() == context.worker.get();
                    } );
                    if( assigned != context.staged_assigned->end() ) {
                        context.staged_assigned->erase( assigned );
                    }
                    context.commit_worker_release = true;
                }
                ++context.task->identity_generation;
                context.task->awaiting_reconciliation = false;
                return true;
            }
            error = "upgrade_work completion commit was not armed by its transaction";
            return false;
    }
    error = "unknown upgrade_work operation";
    return false;
}

bool dispatch_recipe_work_task(
    const basecamp_platform_task_operation operation,
    basecamp_platform_task_execution_context &context, std::string &error )
{
    if( context.task == nullptr || !context.task->recipe_work ) {
        error = "recipe_work executor requires a typed task descriptor";
        return false;
    }
    const bool isolated_recovery =
        operation == basecamp_platform_task_operation::resolve &&
        context.task->recipe_recovery_required &&
        context.task->state == basecamp_platform_task_state::refund_pending &&
        !context.task->recipe_escrow.empty();
    if( !validate_recipe_work_parameters( context.task->parameters, error ) ||
        ( !isolated_recovery &&
          !validate_basecamp_platform_recipe_work( *context.task->recipe_work, error ) ) ) {
        return false;
    }
    basecamp_platform_recipe_work &work = *context.task->recipe_work;
    switch( operation ) {
        case basecamp_platform_task_operation::preflight:
            if( context.task->state != basecamp_platform_task_state::pending ||
                context.task->started_at != calendar::before_time_starts ||
                context.task->due_at != calendar::before_time_starts ||
                context.task->finished_at || !context.task->recipe_escrow.empty() ||
                context.task->recipe_commit_marker != 0 ) {
                error = "recipe_work task has invalid initial state";
                return false;
            }
            return true;
        case basecamp_platform_task_operation::resolve:
            if( isolated_recovery ) {
                return true;
            }
            if( ( context.task->state == basecamp_platform_task_state::running &&
                  context.task->recipe_commit_marker != 0 ) ||
                ( context.task->state == basecamp_platform_task_state::refund_pending &&
                  context.task->recipe_commit_marker != 0 ) ||
                ( context.task->state == basecamp_platform_task_state::completed_unclaimed &&
                  context.task->recipe_commit_marker == 0 ) ) {
                error = "recipe_work task has an invalid settlement commit marker";
                return false;
            }
            if( context.task->state == basecamp_platform_task_state::running ||
                context.task->state == basecamp_platform_task_state::refund_pending ||
                context.task->state == basecamp_platform_task_state::completed_unclaimed ) {
                if( context.task->recipe_escrow.empty() ||
                    !recipe_escrow_shape_matches_work( work,
                                                       context.task->recipe_escrow, error ) ) {
                    return false;
                }
            } else if( !context.task->recipe_escrow.empty() ) {
                error = "non-running recipe_work task retains an escrow";
                return false;
            }
            return true;
        case basecamp_platform_task_operation::start: {
            if( context.camp == nullptr || !context.worker ||
                context.staged_tasks == nullptr || context.staged_assigned == nullptr ||
                context.recipe_escrow == nullptr ) {
                error = "recipe_work start requires camp, worker, and escrow staging context";
                return false;
            }
            if( context.task->state != basecamp_platform_task_state::pending ||
                context.now == calendar::before_time_starts ||
                context.duration != time_duration::from_turns( work.duration_turns ) ) {
                error = "recipe_work start time or duration does not match its descriptor";
                return false;
            }
            if( context.task->worker != context.worker->getID() ||
                context.task->worker_identity_generation !=
                context.worker->platform_identity_generation() ||
                !context.worker->getID().is_valid() || context.worker->is_dead() ||
                context.worker->get_faction() == nullptr ||
                context.worker->get_faction()->id != context.camp->get_owner() ) {
                error = "recipe_work worker identity or owner is not live";
                return false;
            }
            if( context.worker->assigned_camp || context.camp->has_exact_worker( *context.worker ) ) {
                error = "recipe_work worker is already assigned";
                return false;
            }
            if( std::any_of( context.staged_tasks->begin(), context.staged_tasks->end(),
            [&context]( const basecamp_platform_task & candidate ) {
            const bool active = candidate.task_id != context.task->task_id &&
                                platform_task_is_active( candidate );
                return active && candidate.worker == context.worker->getID() &&
                       candidate.worker_identity_generation ==
                       context.worker->platform_identity_generation();
            } ) ) {
                error = "recipe_work worker already has another active task";
                return false;
            }
            if( !recipe_escrow_matches_work( work, *context.recipe_escrow,
                                             context.worker.get(), error ) ) {
                return false;
            }
            context.task->recipe_escrow = *context.recipe_escrow;
            context.task->state = basecamp_platform_task_state::running;
            context.task->started_at = context.now;
            context.task->due_at = context.now + context.duration;
            context.task->finished_at.reset();
            context.task->awaiting_reconciliation = false;
            context.staged_assigned->push_back( context.worker );
            context.commit_worker_assignment = true;
            return true;
        }
        case basecamp_platform_task_operation::cancel:
        case basecamp_platform_task_operation::complete: {
            if( context.camp == nullptr || context.staged_tasks == nullptr ||
                context.recipe_escrow == nullptr ) {
                error = "recipe_work finish requires camp, task, and escrow context";
                return false;
            }
            if( context.recipe_claim ) {
                if( ( context.task->state != basecamp_platform_task_state::refund_pending &&
                      context.task->state != basecamp_platform_task_state::completed_unclaimed ) ||
                    !recipe_escrow_equal( context.task->recipe_escrow,
                                          *context.recipe_escrow ) ) {
                    error = "recipe_work escrow claim does not match the persisted task";
                    return false;
                }
                if( ( context.task->state == basecamp_platform_task_state::refund_pending &&
                      context.task->recipe_commit_marker != 0 ) ||
                    ( context.task->state == basecamp_platform_task_state::completed_unclaimed &&
                      context.task->recipe_commit_marker == 0 ) ) {
                    error = "recipe_work escrow claim has an invalid commit marker";
                    return false;
                }
                if( context.task->identity_generation ==
                    std::numeric_limits<std::uint64_t>::max() ) {
                    error = "recipe_work task generation cannot be retired";
                    return false;
                }
                ++context.task->identity_generation;
                context.task->recipe_escrow.clear();
                context.task->state = context.complete ?
                                      basecamp_platform_task_state::completed :
                                      basecamp_platform_task_state::cancelled;
                if( !context.complete ) {
                    context.task->recipe_commit_marker = 0;
                }
                context.task->finished_at = context.now;
                context.task->awaiting_reconciliation = false;
                return true;
            }
            if( context.worker == nullptr || context.staged_assigned == nullptr ) {
                error = "recipe_work finish requires an exact live worker";
                return false;
            }
            if( context.task->state != basecamp_platform_task_state::running ) {
                error = "recipe_work task is not running";
                return false;
            }
            if( context.worker->getID() != context.task->worker ||
                context.worker->platform_identity_generation() !=
                context.task->worker_identity_generation || context.worker->is_dead() ) {
                error = "recipe_work worker is stale for finish";
                return false;
            }
            const auto assigned = std::find_if(
                                      context.staged_assigned->begin(),
            context.staged_assigned->end(), [&context]( const npc_ptr & candidate ) {
                return candidate && candidate.get() == context.worker.get();
            } );
            if( assigned == context.staged_assigned->end() ) {
                error = "recipe_work worker reservation is not owned by this camp";
                return false;
            }
            if( context.complete ) {
                if( !context.recipe_completion || context.recipe_original_escrow == nullptr ||
                    context.now < context.task->due_at ||
                    context.task->recipe_commit_marker != 0 ||
                    !recipe_escrow_equal( context.task->recipe_escrow,
                                          *context.recipe_original_escrow ) ||
                    context.recipe_escrow->empty() ||
                    !recipe_escrow_shape_matches_work( *context.task->recipe_work,
                                                       *context.recipe_escrow, error ) ) {
                    if( error.empty() ) {
                        error = "recipe_work completion escrow is not fully preflighted";
                    }
                    return false;
                }
                context.task->recipe_escrow = *context.recipe_escrow;
                context.task->recipe_commit_marker = context.task->identity_generation;
                context.task->state = basecamp_platform_task_state::completed_unclaimed;
            } else {
                if( !recipe_escrow_equal( context.task->recipe_escrow,
                                          *context.recipe_escrow ) ) {
                    error = "recipe_work refund escrow changed before finish";
                    return false;
                }
                context.task->recipe_escrow.clear();
                context.task->recipe_commit_marker = 0;
                context.task->state = basecamp_platform_task_state::cancelled;
            }
            context.staged_assigned->erase( assigned );
            context.commit_worker_release = true;
            if( context.task->identity_generation ==
                std::numeric_limits<std::uint64_t>::max() ) {
                error = "recipe_work task generation cannot be retired";
                return false;
            }
            ++context.task->identity_generation;
            context.task->finished_at = context.now;
            context.task->awaiting_reconciliation = false;
            return true;
        }
    }
    error = "unknown recipe_work operation";
    return false;
}

bool stage_platform_task_refund(
    const basecamp &, const basecamp_platform_task &task,
    std::vector<basecamp_resource> &staged_resources,
    std::int64_t &food_refund_kcal, std::string &error )
{
    if( task.kind != basecamp_platform_resource_work_kind ||
        task.state != basecamp_platform_task_state::running ) {
        return true;
    }
    if( !task.resource_work ||
        !validate_basecamp_platform_resource_work( *task.resource_work, error ) ||
        !resource_change_sets_equal( task.reserved_resources,
                                     task.resource_work->resource_inputs ) ||
        task.reserved_food_kcal != task.resource_work->food_input_kcal.value_or( 0 ) ) {
        error = "resource_work reservation cannot be refunded safely";
        return false;
    }
    if( !apply_platform_resource_availability(
            staged_resources, task.reserved_resources, true, error ) ) {
        return false;
    }
    if( task.reserved_food_kcal >
        std::numeric_limits<std::int64_t>::max() - food_refund_kcal ) {
        error = "resource_work refund total overflows";
        return false;
    }
    food_refund_kcal += task.reserved_food_kcal;
    return true;
}

} // namespace

bool basecamp_upgrade_orientation_flags( const recipe_id &recipe,
        const point_rel_omt &direction,
        bool &mirror_horizontal, bool &mirror_vertical, int &rotation,
        const std::string_view base_error_message, const std::string &actor )
{
    mirror_horizontal = recipe->has_flag( "MAP_MIRROR_HORIZONTAL" );
    mirror_vertical = recipe->has_flag( "MAP_MIRROR_VERTICAL" );
    rotation = 0;
    std::string direction_string;

    const auto check_rotation = [&]( const std::string & flag, const int rotation_value ) {
        if( !recipe->has_flag( flag ) ) {
            return true;
        }
        if( rotation != 0 ) {
            debugmsg( "%s, the blueprint specifies multiple concurrent rotations, which is not supported",
                      string_format( base_error_message, actor, recipe->get_blueprint().str() ) );
            return false;
        }
        rotation = rotation_value;
        return true;
    };

    if( !check_rotation( "MAP_ROTATE_90", 1 ) ||
        !check_rotation( "MAP_ROTATE_180", 2 ) ||
        !check_rotation( "MAP_ROTATE_270", 3 ) ) {
        return false;
    }

    if( direction == point_rel_omt::north_west ) {
        direction_string = "NW";
    } else if( direction == point_rel_omt::north ) {
        direction_string = "N";
    } else if( direction == point_rel_omt::north_east ) {
        direction_string = "NE";
    } else if( direction == point_rel_omt::west ) {
        direction_string = "W";
    } else if( direction == point_rel_omt::zero ) {
        direction_string.clear();
    } else if( direction == point_rel_omt::east ) {
        direction_string = "E";
    } else if( direction == point_rel_omt::south_west ) {
        direction_string = "SW";
    } else if( direction == point_rel_omt::south ) {
        direction_string = "S";
    } else if( direction == point_rel_omt::south_east ) {
        direction_string = "SE";
    } else {
        debugmsg( "%s, the blueprint direction is not a supported camp direction",
                  string_format( base_error_message, actor, recipe->get_blueprint().str() ) );
        return false;
    }

    const auto check_mirror = [&]( const std::string & flag, bool & target,
    const char *axis ) {
        if( !recipe->has_flag( flag ) ) {
            return true;
        }
        if( target ) {
            debugmsg( "%s, the blueprint specifies multiple concurrent %s mirroring, which is not supported",
                      string_format( base_error_message, actor, recipe->get_blueprint().str() ), axis );
            return false;
        }
        target = true;
        return true;
    };
    if( !check_mirror( "MAP_MIRROR_HORIZONTAL_IF_" + direction_string,
                       mirror_horizontal, "horizontal" ) ||
        !check_mirror( "MAP_MIRROR_VERTICAL_IF_" + direction_string,
                       mirror_vertical, "vertical" ) ) {
        return false;
    }
    return check_rotation( "MAP_ROTATE_90_IF_" + direction_string, 1 ) &&
           check_rotation( "MAP_ROTATE_180_IF_" + direction_string, 2 ) &&
           check_rotation( "MAP_ROTATE_270_IF_" + direction_string, 3 );
}

bool validate_basecamp_platform_resource_work(
    const basecamp_platform_resource_work &work, std::string &error )
{
    if( !validate_positive_resource_changes(
            work.resource_inputs, "resource_work resource_inputs", error ) ||
        !validate_positive_resource_changes(
            work.resource_outputs, "resource_work resource_outputs", error ) ) {
        return false;
    }
    const auto validate_food = [&error]( const std::optional<std::int64_t> &value,
    const char *label ) {
        if( value && ( *value <= 0 || *value > maximum_platform_resource_work_amount ) ) {
            error = std::string( "resource_work " ) + label +
                    " must be positive and bounded";
            return false;
        }
        return true;
    };
    if( !validate_food( work.food_input_kcal, "food_input_kcal" ) ||
        !validate_food( work.food_output_kcal, "food_output_kcal" ) ) {
        return false;
    }
    if( work.duration_turns <= 0 ||
        work.duration_turns > maximum_platform_resource_work_duration ) {
        error = "resource_work duration must be positive and bounded";
        return false;
    }
    if( !resource_work_has_effect( work ) ) {
        error = "resource_work must have a non-zero resource or food effect";
        return false;
    }
    error.clear();
    return true;
}

bool validate_basecamp_platform_recipe_work(
    const basecamp_platform_recipe_work &work, std::string &error )
{
    if( work.recipe_id.empty() || !::recipe_id( work.recipe_id ).is_valid() ) {
        error = "recipe_work requires a valid concrete recipe id";
        return false;
    }
    if( work.batch <= 0 || work.batch > maximum_platform_recipe_batch ) {
        error = "recipe_work batch is outside its bound";
        return false;
    }
    if( work.duration_turns <= 0 ||
        work.duration_turns > maximum_platform_recipe_duration ) {
        error = "recipe_work duration must be positive and bounded";
        return false;
    }
    if( work.source_holders.empty() ||
        work.source_holders.size() > maximum_platform_recipe_holders ) {
        error = "recipe_work requires 1..16 explicit source holders";
        return false;
    }
    for( std::size_t index = 0; index < work.source_holders.size(); ++index ) {
        const basecamp_platform_recipe_holder &holder = work.source_holders[index];
        if( !validate_recipe_holder( holder, "recipe_work source holder", error ) ) {
            return false;
        }
        for( std::size_t prior = 0; prior < index; ++prior ) {
            if( recipe_holders_equal( holder, work.source_holders[prior] ) ) {
                error = "recipe_work source holders cannot repeat";
                return false;
            }
        }
    }
    if( !validate_recipe_holder( work.destination_holder,
                                 "recipe_work destination holder", error ) ||
        work.destination_holder.slot != "inventory" ) {
        error = "recipe_work destination must be an explicit Character inventory holder";
        return false;
    }
    const ::recipe_id recipe_ident( work.recipe_id );
    const recipe &making = recipe_ident.obj();
    if( making.result().is_null() || making.is_blueprint() || making.is_nested() ||
        making.is_practice() || making.obsolete || making.is_blacklisted() ) {
        error = "recipe_work only accepts a concrete non-obsolete recipe";
        return false;
    }
    if( making.has_steps() ) {
        error = "recipe_work step recipes are not yet safely expressible as one escrow transaction";
        return false;
    }
    error.clear();
    return true;
}

bool validate_basecamp_platform_upgrade_work(
    const basecamp_platform_upgrade_work &work, std::string &error )
{
    if( work.upgrade_id.empty() || !::recipe_id( work.upgrade_id ).is_valid() ) {
        error = "upgrade_work requires a valid blueprint recipe id";
        return false;
    }
    const ::recipe_id upgrade_ident( work.upgrade_id );
    const recipe &upgrade = upgrade_ident.obj();
    if( upgrade.result().str() != work.upgrade_id || !upgrade.is_blueprint() ||
        upgrade.is_nested() || upgrade.is_practice() || upgrade.obsolete ||
        upgrade.is_blacklisted() ) {
        error = "upgrade_work requires a concrete non-obsolete blueprint recipe";
        return false;
    }
    if( work.blueprint_id.empty() ||
        work.blueprint_id != upgrade.get_blueprint().str() ||
        !update_mapgen_id( work.blueprint_id ).is_valid() ) {
        error = "upgrade_work blueprint id does not match the authoritative recipe";
        return false;
    }
    if( work.target_position.is_invalid() || work.target_terrain.empty() ||
        !oter_id( work.target_terrain ).is_valid() ) {
        error = "upgrade_work requires an exact target position and terrain";
        return false;
    }
    switch( work.target_kind ) {
        case basecamp_platform_upgrade_target_kind::camp_core:
            if( work.target_core_generation == 0 || work.target_expansion_id != 0 ||
                work.target_expansion_generation != 0 ) {
                error = "upgrade_work camp-core target requires its exact core generation";
                return false;
            }
            break;
        case basecamp_platform_upgrade_target_kind::expansion:
            if( work.target_core_generation != 0 || work.target_expansion_id == 0 ||
                work.target_expansion_generation == 0 ) {
                error = "upgrade_work expansion target requires an exact token identity";
                return false;
            }
            break;
        default:
            error = "upgrade_work target kind is invalid";
            return false;
    }
    if( work.duration_turns <= 0 ||
        work.duration_turns > maximum_platform_upgrade_duration ) {
        error = "upgrade_work duration must be positive and bounded";
        return false;
    }
    const auto requirement_it = upgrade.blueprint_build_reqs().reqs_by_parameters.find(
                                    work.mapgen_args );
    if( requirement_it == upgrade.blueprint_build_reqs().reqs_by_parameters.end() ) {
        error = "upgrade_work mapgen arguments do not select an authoritative blueprint requirement";
        return false;
    }
    if( requirement_it->second.time <= 0 ||
        to_turns<std::int64_t>( time_duration::from_moves( requirement_it->second.time ) ) !=
        work.duration_turns ) {
        error = "upgrade_work duration does not match the authoritative blueprint requirement";
        return false;
    }
    if( work.source_holders.empty() ||
        work.source_holders.size() > maximum_platform_recipe_holders ) {
        error = "upgrade_work requires 1..16 explicit source holders";
        return false;
    }
    for( std::size_t index = 0; index < work.source_holders.size(); ++index ) {
        if( !validate_recipe_holder( work.source_holders[index],
                                     "upgrade_work source holder", error ) ) {
            return false;
        }
        for( std::size_t prior = 0; prior < index; ++prior ) {
            if( recipe_holders_equal( work.source_holders[index],
                                      work.source_holders[prior] ) ) {
                error = "upgrade_work source holders cannot repeat";
                return false;
            }
        }
    }
    if( !validate_recipe_holder( work.destination_holder,
                                 "upgrade_work destination holder", error ) ||
        work.destination_holder.slot != "inventory" ) {
        error = "upgrade_work destination must be an explicit Character inventory holder";
        return false;
    }
    if( work.mapgen_args.map.size() > 64 ) {
        error = "upgrade_work mapgen arguments exceed their bound";
        return false;
    }
    for( const auto &[key, value] : work.mapgen_args.map ) {
        if( key.empty() || key.size() > 64 || key.find( '\0' ) != std::string::npos ||
            !value.is_valid() ) {
            error = "upgrade_work mapgen arguments contain an invalid key or value";
            return false;
        }
    }
    error.clear();
    return true;
}

const basecamp_platform_task_kind_executor *find_basecamp_platform_task_executor(
    const std::string_view kind ) noexcept
{
    for( const basecamp_platform_task_kind_executor &executor : platform_task_executors() ) {
        if( executor.kind == kind ) {
            return &executor;
        }
    }
    return nullptr;
}

bool validate_basecamp_platform_task_kind(
    const std::string_view kind, const std::string_view parameters,
    const basecamp_platform_task_operation operation, std::string &error )
{
    const basecamp_platform_task_kind_executor *executor =
        find_basecamp_platform_task_executor( kind );
    if( executor == nullptr ) {
        error = "unsupported Platform camp task kind '" + std::string( kind ) + "'";
        return false;
    }
    if( executor->validate_parameters == nullptr ||
        !executor->validate_parameters( parameters, error ) ) {
        return false;
    }
    if( !platform_task_operation_supported( *executor, operation ) ) {
        error = "Platform camp task kind '" + std::string( kind ) +
                "' does not support " +
                std::string( platform_task_operation_name( operation ) ) + "";
        return false;
    }
    if( executor->dispatch == nullptr ) {
        error = "Platform camp task kind '" + std::string( kind ) +
                "' has no executor dispatch";
        return false;
    }
    error.clear();
    return true;
}

bool dispatch_basecamp_platform_task(
    const std::string_view kind, const basecamp_platform_task_operation operation,
    basecamp_platform_task_execution_context &context, std::string &error )
{
    const basecamp_platform_task_kind_executor *executor =
        find_basecamp_platform_task_executor( kind );
    if( executor == nullptr ) {
        error = "unsupported Platform camp task kind '" + std::string( kind ) + "'";
        return false;
    }
    if( !platform_task_operation_supported( *executor, operation ) ) {
        error = "Platform camp task kind '" + std::string( kind ) +
                "' does not support " +
                std::string( platform_task_operation_name( operation ) );
        return false;
    }
    if( executor->dispatch == nullptr ) {
        error = "Platform camp task kind '" + std::string( kind ) +
                "' has no executor dispatch";
        return false;
    }
    return executor->dispatch( operation, context, error );
}

void reserve_platform_task_id( const std::uint64_t id )
{
    reserve_platform_task_id_impl( id );
}

void reserve_platform_expansion_id( const std::uint64_t id )
{
    reserve_platform_expansion_id_impl( id );
}

std::string basecamp_platform_task_state_name( const basecamp_platform_task_state state )
{
    switch( state ) {
        case basecamp_platform_task_state::pending:
            return "pending";
        case basecamp_platform_task_state::running:
            return "running";
        case basecamp_platform_task_state::refund_pending:
            return "refund_pending";
        case basecamp_platform_task_state::completed_unclaimed:
            return "completed_unclaimed";
        case basecamp_platform_task_state::completed:
            return "completed";
        case basecamp_platform_task_state::cancelled:
            return "cancelled";
    }
    return "invalid";
}

std::optional<basecamp_platform_task_state>
basecamp_platform_task_state_from_name( const std::string_view name )
{
    if( name == "pending" ) {
        return basecamp_platform_task_state::pending;
    }
    if( name == "running" ) {
        return basecamp_platform_task_state::running;
    }
    if( name == "refund_pending" ) {
        return basecamp_platform_task_state::refund_pending;
    }
    if( name == "completed_unclaimed" ) {
        return basecamp_platform_task_state::completed_unclaimed;
    }
    if( name == "completed" ) {
        return basecamp_platform_task_state::completed;
    }
    if( name == "cancelled" ) {
        return basecamp_platform_task_state::cancelled;
    }
    return std::nullopt;
}

const std::map<point_rel_omt, base_camps::direction_data> base_camps::all_directions = {
    // direction, direction id, tab order, direction abbreviation with bracket, direction tab title
    { base_camps::base_dir, { "[B]", base_camps::TAB_MAIN, to_translation( "base camp: base", "[B]" ), to_translation( "base camp: base", " MAIN " ) } },
    { point_rel_omt::north, { "[N]", base_camps::TAB_N, to_translation( "base camp: north", "[N]" ), to_translation( "base camp: north", "  [N] " ) } },
    { point_rel_omt::north_east, { "[NE]", base_camps::TAB_NE, to_translation( "base camp: northeast", "[NE]" ), to_translation( "base camp: northeast", " [NE] " ) } },
    { point_rel_omt::east, { "[E]", base_camps::TAB_E, to_translation( "base camp: east", "[E]" ), to_translation( "base camp: east", "  [E] " ) } },
    { point_rel_omt::south_east, { "[SE]", base_camps::TAB_SE, to_translation( "base camp: southeast", "[SE]" ), to_translation( "base camp: southeast", " [SE] " ) } },
    { point_rel_omt::south, { "[S]", base_camps::TAB_S, to_translation( "base camp: south", "[S]" ), to_translation( "base camp: south", "  [S] " ) } },
    { point_rel_omt::south_west, { "[SW]", base_camps::TAB_SW, to_translation( "base camp: southwest", "[SW]" ), to_translation( "base camp: southwest", " [SW] " ) } },
    { point_rel_omt::west, { "[W]", base_camps::TAB_W, to_translation( "base camp: west", "[W]" ), to_translation( "base camp: west", "  [W] " ) } },
    { point_rel_omt::north_west, { "[NW]", base_camps::TAB_NW, to_translation( "base camp: northwest", "[NW]" ), to_translation( "base camp: northwest", " [NW] " ) } },
};

point_rel_omt base_camps::direction_from_id( const std::string &id )
{
    for( const auto &dir : all_directions ) {
        if( dir.second.id == id ) {
            return dir.first;
        }
    }
    return base_dir;
}

std::string base_camps::faction_encode_short( const std::string &type )
{
    return prefix + type + "_";
}

std::string base_camps::faction_encode_abs( const expansion_data &e, int number )
{
    return faction_encode_short( e.type ) + std::to_string( number );
}

std::string base_camps::faction_decode( std::string_view full_type )
{
    if( full_type.size() < ( prefix_len + 2 ) ) {
        return "camp";
    }
    int last_bar = full_type.find_last_of( '_' );

    return std::string{ full_type.substr( prefix_len, size_t( last_bar - prefix_len ) ) };
}

static const time_duration work_day_hours_time = work_day_hours * 1_hours;

time_duration base_camps::to_workdays( const time_duration &work_time )
{
    // logic here is duplicated in reverse in basecamp::time_to_food
    if( work_time < ( work_day_hours + 1 ) * 1_hours ) {
        return work_time;
    }
    int work_days = work_time / work_day_hours_time;
    time_duration excess_time = work_time - work_days * work_day_hours_time;
    return excess_time + 24_hours * work_days;
}

static std::map<std::string, int> max_upgrade_cache;

int base_camps::max_upgrade_by_type( const std::string &type )
{
    if( max_upgrade_cache.find( type ) == max_upgrade_cache.end() ) {
        int max = -1;
        const std::string faction_base = faction_encode_short( type );
        while( recipe_id( faction_base + std::to_string( max + 1 ) ).is_valid() ) {
            max += 1;
        }
        max_upgrade_cache[type] = max;
    }
    return max_upgrade_cache[type];
}

basecamp::basecamp() : platform_id_( allocate_platform_camp_id() ) {}

basecamp_map::basecamp_map( const basecamp_map & ) {}

// rhs is intentionally ignored; assignment resets the cached map.
// NOLINTNEXTLINE(bugprone-unhandled-self-assignment,cert-oop54-cpp)
basecamp_map &basecamp_map::operator=( const basecamp_map & )
{
    map_.reset();
    return *this;
}

basecamp::basecamp( const std::string &name_, const tripoint_abs_omt &omt_pos_ ):
    name( name_ ), omt_pos( omt_pos_ ), platform_id_( allocate_platform_camp_id() )
{
    parse_tags( name, get_player_character(), get_player_character() );
}

basecamp::basecamp( const std::string &name_, const tripoint_abs_ms &bb_pos_,
                    const std::vector<point_rel_omt> &directions_,
                    const std::map<point_rel_omt, expansion_data> &expansions_ )
    : directions( directions_ ), name( name_ ), platform_id_( allocate_platform_camp_id() ),
      bb_pos( bb_pos_ ), expansions( expansions_ )
{
    parse_tags( name, get_player_character(), get_player_character() );
    for( const auto &[direction, expansion] : expansions ) {
        platform_register_expansion_identity( direction, expansion, expansion.type );
    }
}

std::string basecamp::board_name() const
{
    //~ Name of a basecamp
    return string_format( _( "%s Board" ), name );
}

void basecamp::set_by_radio( bool access_by_radio )
{
    by_radio = access_by_radio;
}

std::uint64_t basecamp::platform_id() const noexcept
{
    return platform_id_;
}

std::uint64_t basecamp::platform_core_upgrade_generation() const noexcept
{
    return platform_core_upgrade_generation_;
}

void basecamp::set_platform_id( const std::uint64_t id )
{
    const std::uint64_t requested = id == 0 ? allocate_platform_camp_id() : id;
    // A freshly constructed deserialization target has its generated id but
    // has not read name/omt_pos yet.  It is not a live camp and must not be
    // rejected by the removal gate while its durable identity is restored.
    if( is_valid() && platform_id_ != 0 && platform_id_ != requested ) {
        std::string removal_error;
        if( !platform_can_remove( removal_error ) ) {
            return;
        }
        if( !platform_retire_tasks_for_camp() ) {
            return;
        }
    }
#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
    if( platform_id_ != 0 && platform_id_ != requested ) {
        cata::lua_platform::retire_camp_handle_identity( *this );
    }
#endif
    platform_id_ = requested;
    reserve_platform_camp_id( platform_id_ );
    for( auto &[expansion_id, expansion] : platform_expansions_ ) {
        static_cast<void>( expansion_id );
        expansion.camp_id = platform_id_;
    }
}

safe_reference<basecamp> basecamp::get_safe_reference()
{
    return platform_anchor.reference_to( this );
}

void basecamp::platform_register_expansion_identity(
    const point_rel_omt &direction, const expansion_data &expansion, std::string expansion_name )
{
    for( auto it = platform_expansions_.begin(); it != platform_expansions_.end(); ++it ) {
        if( it->second.direction == direction ) {
            platform_retire_expansion_identity( it->first );
            break;
        }
    }
    basecamp_platform_expansion record;
    record.expansion_id = allocate_platform_expansion_id();
    record.identity_generation = 1;
    record.camp_id = platform_id_;
    record.direction = direction;
    record.position = expansion.pos;
    record.type = expansion.type;
    if( record.type.rfind( base_camps::prefix, 0 ) != 0 ) {
        const std::string encoded = base_camps::faction_encode_abs( expansion, 0 );
        if( encoded != "null" ) {
            record.type = encoded;
        }
    }
    record.name = expansion_name.empty() ? record.type : std::move( expansion_name );
    record.work_in_progress = !expansion.in_progress.empty();
    platform_expansions_.emplace( record.expansion_id, std::move( record ) );
}

void basecamp::platform_retire_expansion_identity( const std::uint64_t expansion_id )
{
    const auto found = platform_expansions_.find( expansion_id );
    if( found == platform_expansions_.end() ) {
        return;
    }
    std::uint64_t retired_generation = found->second.identity_generation;
    if( retired_generation < std::numeric_limits<std::uint64_t>::max() ) {
        ++retired_generation;
    }
    platform_retired_expansion_generations_[expansion_id] = retired_generation;
    platform_expansions_.erase( found );
}

void basecamp::platform_retire_expansion_identities()
{
    for( auto &[id, expansion] : platform_expansions_ ) {
        static_cast<void>( id );
        if( expansion.identity_generation < std::numeric_limits<std::uint64_t>::max() ) {
            ++expansion.identity_generation;
        }
    }
}

// read an expansion's terrain ID of the form faction_base_$TYPE_$CURLEVEL
// find the last underbar, strip off the prefix of faction_base_ (which is 13 chars),
// and the pull out the $TYPE and $CURLEVEL
// This is legacy support for existing camps; future camps don't use cur_level at all
expansion_data basecamp::parse_expansion( std::string_view terrain,
        const tripoint_abs_omt &new_pos )
{
    expansion_data e;
    size_t last_bar = terrain.find_last_of( '_' );
    e.type = terrain.substr( base_camps::prefix_len, last_bar - base_camps::prefix_len );
    e.cur_level = std::stoi( str_cat( "0", terrain.substr( last_bar + 1 ) ) );
    e.pos = new_pos;
    return e;
}

void basecamp::add_expansion( const std::string &terrain, const tripoint_abs_omt &new_pos )
{
    if( terrain.find( base_camps::prefix ) == std::string::npos ) {
        return;
    }

    const point_rel_omt dir = talk_function::om_simple_dir( omt_pos, new_pos );
    expansions[ dir ] = parse_expansion( terrain, new_pos );
    update_provides( terrain, expansions[ dir ] );
    platform_register_expansion_identity( dir, expansions[ dir ], terrain );
    directions.push_back( dir );
}

void basecamp::add_expansion( const std::string &bldg, const tripoint_abs_omt &new_pos,
                              const point_rel_omt &dir )
{
    expansion_data e;
    e.type = base_camps::faction_decode( bldg );
    e.cur_level = -1;
    e.pos = new_pos;
    expansions[ dir ] = e;
    directions.push_back( dir );
    update_provides( bldg, expansions[ dir ] );
    update_resources( bldg );
    platform_register_expansion_identity( dir, expansions[ dir ], bldg );
}

void basecamp::define_camp( const tripoint_abs_omt &p, std::string_view camp_type,
                            bool player_founded )
{
    if( player_founded ) {
        query_new_name( true );
    }
    if( omt_pos != tripoint_abs_omt() && omt_pos != p ) {
        if( !platform_retire_tasks_for_camp() ) {
            return;
        }
#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
        cata::lua_platform::retire_camp_handle_identity( *this );
#endif
    }
    omt_pos = p;
    const oter_id &omt_ref = overmap_buffer.ter( omt_pos );
    // purging the regions guarantees all entries will start with faction_base_
    for( const std::pair<std::string, tripoint_abs_omt> &expansion :
         talk_function::om_building_region( omt_pos, 1, true ) ) {
        add_expansion( expansion.first, expansion.second );
    }
    const std::string om_cur = omt_ref.id().c_str();
    if( om_cur.find( base_camps::prefix ) == std::string::npos ) {
        expansion_data e;
        e.type = base_camps::faction_decode( camp_type );
        e.cur_level = -1;
        e.pos = omt_pos;
        expansions[base_camps::base_dir] = e;
        const std::string direction = oter_get_rotation_string( omt_ref );
        if( player_founded ) {
            const oter_id bcid( direction.empty() ? "faction_base_camp_0" : "faction_base_camp_new_0" +
                                direction );
            overmap_buffer.ter_set( omt_pos, bcid );
        }
        update_provides( base_camps::faction_encode_abs( e, 0 ),
                         expansions[base_camps::base_dir] );
    } else {
        expansions[base_camps::base_dir] = parse_expansion( om_cur, omt_pos );
    }
    platform_register_expansion_identity( base_camps::base_dir,
                                          expansions[base_camps::base_dir],
                                          expansions[base_camps::base_dir].type );
}

/// Returns the description for the recipe of the next building @ref bldg
std::string basecamp::om_upgrade_description( const std::string &bldg, const mapgen_arguments &args,
        bool trunc ) const
{
    const recipe &making = recipe_id( bldg ).obj();

    const requirement_data *reqs;
    time_duration base_time;
    const std::map<skill_id, int> *skills;

    if( making.is_blueprint() ) {
        auto req_it = making.blueprint_build_reqs().reqs_by_parameters.find( args );
        cata_assert( req_it != making.blueprint_build_reqs().reqs_by_parameters.end() );
        const build_reqs &bld_reqs = req_it->second;
        reqs = &bld_reqs.consolidated_reqs;
        base_time = time_duration::from_moves( bld_reqs.time );
        skills = &bld_reqs.skills;
    } else {
        reqs = &making.simple_requirements();
        base_time = making.batch_duration( get_player_character(),
                                           crafting_cost_context::for_recipe( get_player_character(), making ) );
        skills = &making.required_skills;
    }

    std::vector<std::string> component_print_buffer;
    const int pane = FULL_SCREEN_WIDTH;
    const auto tools = reqs->get_folded_tools_list( nullptr, pane, c_white, _inv, 1 );
    const auto comps = reqs->get_folded_components_list( nullptr, pane, c_white, _inv,
                       making.get_component_filter(), 1 );
    component_print_buffer.insert( component_print_buffer.end(), tools.begin(), tools.end() );
    component_print_buffer.insert( component_print_buffer.end(), comps.begin(), comps.end() );

    std::string comp;
    for( auto &elem : component_print_buffer ) {
        str_append( comp, elem, "\n" );
    }
    comp = string_format( _( "Notes:\n%s\n\nSkills used: %s\n%s\n" ),
                          making.description, making.required_all_skills_string( *skills ),
                          comp );
    if( !trunc ) {
        comp += string_format( _( "Risk: None\nTime: %s\n" ),
                               to_string( base_camps::to_workdays( base_time ) ) );
    }
    return comp;
}

// upgrade levels
// legacy next upgrade
std::string basecamp::next_upgrade( const point_rel_omt &dir, const int offset ) const
{
    const auto &e = expansions.find( dir );
    if( e == expansions.end() ) {
        return "null";
    }
    const expansion_data &e_data = e->second;

    int cur_level = -1;
    for( int i = 0; i < base_camps::max_upgrade_by_type( e_data.type ); i++ ) {
        const std::string candidate = base_camps::faction_encode_abs( e_data, i );
        if( e_data.provides.find( candidate ) == e_data.provides.end() ) {
            break;
        } else {
            cur_level = i;
        }
    }
    if( cur_level >= 0 ) {
        return base_camps::faction_encode_abs( e_data, cur_level + offset );
    }
    return "null";
}

bool basecamp::has_provides( const std::string &req, const expansion_data &e_data, int level ) const
{
    for( const auto &provide : e_data.provides ) {
        if( provide.first == req && provide.second > level ) {
            return true;
        }
    }
    return false;
}

bool basecamp::has_provides( const std::string &req, const std::optional<point_rel_omt> &dir,
                             int level ) const
{
    if( !dir ) {
        for( const auto &e : expansions ) {
            if( has_provides( req, e.second, level ) ) {
                return true;
            }
        }
    } else {
        const auto &e = expansions.find( *dir );
        if( e != expansions.end() ) {
            return has_provides( req, e->second, level );
        }
    }
    return false;
}

bool basecamp::has_water() const
{
    // special case required for fbmh_well_north constructed between b9162 (Jun 16, 2019) and b9644 (Sep 20, 2019)
    return has_provides( "water_well" ) || has_provides( "fbmh_well_north" );
}

bool basecamp::allowed_access_by( Character &guy, bool water_request ) const
{
    // The owner can always access their own camp.
    if( fac() == guy.get_faction() ) {
        return true;
    }
    // Sharing stuff also means sharing access.
    if( fac()->has_relationship( guy.get_faction()->id, npc_factions::relationship::share_my_stuff ) ) {
        return true;
    }
    // Some factions will share access to infinite water sources, but not food
    if( water_request &&
        fac()->has_relationship( guy.get_faction()->id, npc_factions::relationship::share_public_goods ) ) {
        return true;
    }
    return false;
}

std::vector<basecamp_upgrade> basecamp::available_upgrades( const point_rel_omt &dir )
{
    std::vector<basecamp_upgrade> ret_data;
    auto e = expansions.find( dir );
    if( e != expansions.end() ) {
        expansion_data &e_data = e->second;
        for( const recipe *recp_p : recipe_dict.all_blueprints() ) {
            const recipe &recp = *recp_p;
            const std::string &bldg = recp.result().str();
            // skip buildings that are completed
            if( e_data.provides.find( bldg ) != e_data.provides.end() ) {
                continue;
            }
            // skip building that have unmet requirements
            size_t needed_requires = recp.blueprint_requires().size();
            size_t met_requires = 0;
            for( const auto &bp_require : recp.blueprint_requires() ) {
                if( e_data.provides.find( bp_require.first ) == e_data.provides.end() ) {
                    break;
                }
                if( e_data.provides[bp_require.first] < bp_require.second ) {
                    break;
                }
                met_requires += 1;
            }
            if( met_requires < needed_requires ) {
                continue;
            }
            bool should_display = true;
            bool in_progress = false;
            for( const auto &bp_exclude : recp.blueprint_excludes() ) {
                // skip buildings that are excluded by previous builds
                if( e_data.provides.find( bp_exclude.first ) != e_data.provides.end() ) {
                    if( e_data.provides[bp_exclude.first] >= bp_exclude.second ) {
                        should_display = false;
                        break;
                    }
                }
                // track buildings that are currently being built
                if( e_data.in_progress.find( bp_exclude.first ) != e_data.in_progress.end() ) {
                    if( e_data.in_progress[bp_exclude.first] >= bp_exclude.second ) {
                        in_progress = true;
                        break;
                    }
                }
            }
            if( !should_display ) {
                continue;
            }
            if( recp.blueprint_build_reqs().reqs_by_parameters.empty() ) {
                debugmsg( "blueprint recipe %s lacked any blueprint_build_reqs", recp.result().str() );
            }
            for( const std::pair<const mapgen_arguments, build_reqs> &args_and_reqs :
                 recp.blueprint_build_reqs().reqs_by_parameters ) {
                const mapgen_arguments &args = args_and_reqs.first;
                const requirement_data &reqs = args_and_reqs.second.consolidated_reqs;
                bool can_make =
                    reqs.can_make_with_inventory( nullptr, _inv, recp.get_component_filter(), 1, craft_flags::none,
                                                  false );
                ret_data.push_back( { bldg, args, recp.blueprint_name(), can_make, in_progress } );
            }
        }
    }
    return ret_data;
}

std::unordered_set<recipe_id> basecamp::recipe_deck_all() const
{
    std::unordered_set<recipe_id> known_recipes;
    for( const npc_ptr &guy : assigned_npcs ) {
        if( guy.get() ) {
            for( const recipe *rec : guy->get_learned_recipes() ) {
                known_recipes.insert( rec->ident() );
            }
        }
    }

    for( const auto &exp_data_pair : expansions ) {
        for( const auto &provides : exp_data_pair.second.provides ) {
            const auto &test_s = recipe_group::get_recipes_by_id( provides.first );
            for( const std::pair<const recipe_id, translation> &rec_list : test_s ) {
                known_recipes.insert( rec_list.first );
            }
        }
    }

    return known_recipes;
}

// recipes and craft support functions
std::map<recipe_id, translation> basecamp::recipe_deck( const point_rel_omt &dir ) const
{
    std::map<recipe_id, translation> recipes;

    const auto &e = expansions.find( dir );
    if( e == expansions.end() ) {
        return recipes;
    }
    for( const auto &provides : e->second.provides ) {
        const auto &test_s = recipe_group::get_recipes_by_id( provides.first );
        recipes.insert( test_s.cbegin(), test_s.cend() );
    }
    return recipes;
}

std::map<recipe_id, translation> basecamp::recipe_deck( const std::string &bldg ) const
{
    return recipe_group::get_recipes_by_bldg( bldg );
}

void basecamp::add_resource( const itype_id &camp_resource )
{
    basecamp_resource bcp_r;
    bcp_r.fake_id = camp_resource;
    item camp_item( bcp_r.fake_id, calendar::turn_zero );
    bcp_r.ammo_id = camp_item.ammo_default();
    resources.emplace_back( bcp_r );
    fuel_types.insert( bcp_r.ammo_id );
}

void basecamp::update_resources( const std::string &bldg )
{
    if( !recipe_id( bldg ).is_valid() ) {
        return;
    }

    const recipe &making = recipe_id( bldg ).obj();
    for( const itype_id &bp_resource : making.blueprint_resources() ) {
        add_resource( bp_resource );
    }
}

void basecamp::update_provides( const std::string &bldg, expansion_data &e_data )
{
    if( !recipe_id( bldg ).is_valid() ) {
        debugmsg( "Invalid basecamp recipe %s", bldg );
        return;
    }

    const recipe &making = recipe_id( bldg ).obj();
    for( const auto &bp_provides : making.blueprint_provides() ) {
        if( e_data.provides.find( bp_provides.first ) == e_data.provides.end() ) {
            e_data.provides[bp_provides.first] = 0;
        }
        e_data.provides[bp_provides.first] += bp_provides.second;
    }
}

void basecamp::update_in_progress( const std::string &bldg, const point_rel_omt &dir )
{
    if( !recipe_id( bldg ).is_valid() ) {
        return;
    }
    auto e = expansions.find( dir );
    if( e == expansions.end() ) {
        return;
    }
    expansion_data &e_data = e->second;

    const recipe &making = recipe_id( bldg ).obj();
    for( const auto &bp_provides : making.blueprint_provides() ) {
        if( e_data.in_progress.find( bp_provides.first ) == e_data.in_progress.end() ) {
            e_data.in_progress[bp_provides.first] = 0;
        }
        e_data.in_progress[bp_provides.first] += bp_provides.second;
    }
}

void basecamp::reset_camp_resources( map &here )
{
    reset_camp_workers();
    for( auto &e : expansions ) {
        expansion_data &e_data = e.second;
        for( int level = 0; level <= e_data.cur_level; level++ ) {
            const std::string &bldg = base_camps::faction_encode_abs( e_data, level );
            if( bldg == "null" ) {
                break;
            }
            update_provides( bldg, e_data );
        }
        for( const auto &bp_provides : e_data.provides ) {
            update_resources( bp_provides.first );
        }
        for( itype_id &it : e.second.available_pseudo_items ) {
            add_resource( it );
        }
    }
    form_crafting_inventory( here );
}

// available companion list manipulation
// get all the companions currently performing missions at this camp
void basecamp::reset_camp_workers()
{
    camp_workers.clear();
    for( const auto &elem : overmap_buffer.get_companion_mission_npcs() ) {
        npc_companion_mission c_mission = elem->get_companion_mission();
        if( c_mission.position == omt_pos && c_mission.role_id == "FACTION_CAMP" ) {
            camp_workers.push_back( elem );
        }
    }
}

void basecamp::add_assignee( character_id id )
{
    npc_ptr npc_to_add = overmap_buffer.find_npc( id );
    if( !npc_to_add ) {
        debugmsg( "cant find npc to assign to basecamp, on the overmap_buffer" );
        return;
    }
    npc_to_add->assigned_camp = omt_pos;
    assigned_npcs.push_back( npc_to_add );
}

bool basecamp::assign_exact_worker( const npc_ptr &worker )
{
    constexpr std::size_t maximum_platform_workers = 256;
    if( !worker || !worker->getID().is_valid() || worker->is_dead() ||
        !is_valid() || assigned_npcs.size() >= maximum_platform_workers ) {
        return false;
    }
    if( worker->assigned_camp || has_exact_worker( *worker ) ) {
        return false;
    }
    std::vector<npc_ptr> staged = assigned_npcs;
    staged.push_back( worker );
    worker->assigned_camp = omt_pos;
    assigned_npcs.swap( staged );
    return true;
}

bool basecamp::recall_exact_worker( const npc_ptr &worker )
{
    if( !worker || !worker->getID().is_valid() || worker->is_dead() ||
        !worker->assigned_camp || *worker->assigned_camp != omt_pos ) {
        return false;
    }
    const auto found = std::find_if(
                           assigned_npcs.begin(), assigned_npcs.end(),
    [&worker]( const npc_ptr & assigned ) {
        return assigned && assigned.get() == worker.get();
    } );
    if( found == assigned_npcs.end() ) {
        return false;
    }
    std::vector<npc_ptr> staged = assigned_npcs;
    staged.erase( staged.begin() + std::distance( assigned_npcs.begin(), found ) );
    worker->assigned_camp = std::nullopt;
    assigned_npcs.swap( staged );
    return true;
}

bool basecamp::has_exact_worker( const npc &worker ) const noexcept
{
    return std::any_of(
               assigned_npcs.begin(), assigned_npcs.end(),
    [&worker]( const npc_ptr & assigned ) {
        return assigned && assigned.get() == &worker;
    } );
}

std::size_t basecamp::exact_worker_count() const noexcept
{
    return assigned_npcs.size();
}

void basecamp::remove_assignee( character_id id )
{
    npc_ptr npc_to_remove = overmap_buffer.find_npc( id );
    if( !npc_to_remove ) {
        debugmsg( "cant find npc to remove from basecamp, on the overmap_buffer" );
        return;
    }
    npc_to_remove->assigned_camp = std::nullopt;
    assigned_npcs.erase( std::remove( assigned_npcs.begin(), assigned_npcs.end(), npc_to_remove ),
                         assigned_npcs.end() );
}

void basecamp::validate_assignees()
{
    std::vector<npc_ptr>::iterator iter = assigned_npcs.begin();
    while( iter != assigned_npcs.end() ) {
        if( !( *iter ) || !( *iter )->assigned_camp || *( *iter )->assigned_camp != omt_pos ) {
            iter = assigned_npcs.erase( iter );
        } else {
            ++iter;
        }
    }
    for( character_id elem : g->get_follower_list() ) {
        npc_ptr npc_to_add = overmap_buffer.find_npc( elem );
        if( !npc_to_add ) {
            continue;
        }
        if( std::find( assigned_npcs.begin(), assigned_npcs.end(), npc_to_add ) != assigned_npcs.end() ) {
            continue;
        } else {
            if( npc_to_add->assigned_camp && *npc_to_add->assigned_camp == omt_pos ) {
                assigned_npcs.push_back( npc_to_add );
            }
        }
    }
    // remove duplicates - for legacy handling.
    std::sort( assigned_npcs.begin(), assigned_npcs.end() );
    auto last = std::unique( assigned_npcs.begin(), assigned_npcs.end() );
    assigned_npcs.erase( last, assigned_npcs.end() );
}

std::vector<npc_ptr> basecamp::get_npcs_assigned()
{
    validate_assignees();
    return assigned_npcs;
}

void basecamp::hide_mission( ui_mission_id id )
{
    const base_camps::direction_data &base_data = base_camps::all_directions.at( id.id.dir.value() );
    for( ui_mission_id &miss_id : hidden_missions[size_t( base_data.tab_order )] ) {
        if( is_equal( miss_id, id ) ) {
            return;
        }  //  The UI shouldn't allow us to hide something already hidden, but check anyway.
    }
    hidden_missions[size_t( base_data.tab_order )].push_back( id );
}

void basecamp::reveal_mission( ui_mission_id id )
{
    const base_camps::direction_data &base_data = base_camps::all_directions.at( id.id.dir.value() );
    for( auto it = hidden_missions[size_t( base_data.tab_order )].begin();
         it != hidden_missions[size_t( base_data.tab_order )].end(); it++ ) {
        if( is_equal( id.id, it->id ) ) {
            hidden_missions[size_t( base_data.tab_order )].erase( it );
            return;
        }
    }
    debugmsg( "Trying to reveal revealed mission.  Has no effect." );
}

bool basecamp::is_hidden( ui_mission_id id )
{
    if( hidden_missions.empty() ) {
        return false;
    }

    if( !id.id.dir ) {
        return false;
    }

    const base_camps::direction_data &base_data = base_camps::all_directions.at( id.id.dir.value() );
    for( ui_mission_id &miss_id : hidden_missions[size_t( base_data.tab_order )] ) {
        if( is_equal( miss_id, id ) ) {
            return true;
        }
    }
    return false;
}

// get the subset of companions working on a specific task
comp_list basecamp::get_mission_workers( const mission_id &miss_id, bool contains )
{
    comp_list available;
    for( const auto &elem : camp_workers ) {
        npc_companion_mission c_mission = elem->get_companion_mission();
        if( is_equal( c_mission.miss_id, miss_id ) ||
            ( contains && c_mission.miss_id.id == miss_id.id &&
              c_mission.miss_id.dir == miss_id.dir ) ) {
            available.push_back( elem );
        }
    }
    return available;
}

void basecamp::query_new_name( bool force )
{
    string_input_popup_imgui input_popup( 40 );
    bool done = false;
    bool need_input = true;
    std::string text;
    do {
        input_popup.set_description( _( "Name this camp" ) );
        input_popup.set_max_input_length( 25 );
        text = input_popup.query();
        if( input_popup.cancelled() || text.empty() ) {
            if( name.empty() || force ) {
                popup( _( "You need to input the base camp name." ) );
            } else {
                need_input = false;
            }
        } else {
            done = true;
        }
    } while( !done && need_input );
    if( done ) {
        name = text;
    }
}

void basecamp::set_name( const std::string &new_name )
{
    name = new_name;
    parse_tags( name, get_player_character(), get_player_character() );
}

/*
 * we could put this logic in map::use_charges() the way the vehicle code does, but I think
 * that's sloppy
 */
std::list<item> basecamp::use_charges( const itype_id &fake_id, int &quantity )
{
    std::list<item> ret;
    if( quantity <= 0 ) {
        return ret;
    }
    for( basecamp_resource &bcp_r : resources ) {
        if( bcp_r.fake_id == fake_id ) {
            item camp_item( bcp_r.fake_id, calendar::turn_zero );
            camp_item.charges = std::min( bcp_r.available, quantity );
            quantity -= camp_item.charges;
            bcp_r.available -= camp_item.charges;
            bcp_r.consumed += camp_item.charges;
            ret.push_back( camp_item );
            if( quantity <= 0 ) {
                break;
            }
        }
    }
    return ret;
}

bool basecamp::platform_resource_snapshot(
    std::vector<basecamp_resource> &result, std::string &error ) const
{
    return platform_normalize_resources( resources, result, error );
}

bool basecamp::platform_normalize_resources(
    const std::vector<basecamp_resource> &input,
    std::vector<basecamp_resource> &result, std::string &error )
{
    result.clear();
    for( const basecamp_resource &resource : input ) {
        if( resource.fake_id.is_null() || !resource.fake_id.is_valid() ) {
            error = "resource has an invalid fake id";
            result.clear();
            return false;
        }
        if( resource.available < 0 || resource.consumed < 0 ) {
            error = "resource has a negative native quantity";
            result.clear();
            return false;
        }
        const auto existing = std::find_if( result.begin(), result.end(),
        [&resource]( const basecamp_resource & candidate ) {
            return candidate.fake_id == resource.fake_id;
        } );
        if( existing == result.end() ) {
            result.push_back( resource );
            continue;
        }
        // A fake id is a safe public key only when all static resource
        // semantics agree.  Native use_charges() consumes equal fake ids as
        // one additive pool, so equal ammo semantics may be aggregated.
        if( existing->ammo_id != resource.ammo_id ) {
            error = "duplicate fake id has conflicting ammo semantics";
            result.clear();
            return false;
        }
        if( existing->available > std::numeric_limits<int>::max() - resource.available ||
            existing->consumed > std::numeric_limits<int>::max() - resource.consumed ) {
            error = "equivalent duplicate resource quantities overflow the public value";
            result.clear();
            return false;
        }
        existing->available += resource.available;
        existing->consumed += resource.consumed;
    }
    error.clear();
    return true;
}

bool basecamp::platform_adjust_resources(
    const std::vector<basecamp_platform_resource_change> &changes,
    std::string &error )
{
    if( changes.empty() ) {
        error = "at least one resource change is required";
        return false;
    }

    std::vector<basecamp_resource> normalized;
    if( !platform_resource_snapshot( normalized, error ) ) {
        return false;
    }
    std::vector<basecamp_platform_resource_change> outstanding_resources;
    std::int64_t outstanding_food_kcal = 0;
    if( !platform_reservation_liability(
            outstanding_resources, outstanding_food_kcal, error ) ) {
        return false;
    }
    static_cast<void>( outstanding_food_kcal );

    for( std::size_t index = 0; index < changes.size(); ++index ) {
        const basecamp_platform_resource_change &change = changes[index];
        if( change.delta == 0 ) {
            error = "resource delta must not be zero";
            return false;
        }
        for( std::size_t prior = 0; prior < index; ++prior ) {
            if( changes[prior].resource_id == change.resource_id ) {
                error = "resource ids must be unique within one adjustment";
                return false;
            }
        }

        const auto resource = std::find_if( normalized.begin(), normalized.end(),
        [&change]( const basecamp_resource & candidate ) {
            return candidate.fake_id == change.resource_id;
        } );
        if( resource == normalized.end() ) {
            error = "resource id is not provided by this camp";
            return false;
        }

        const std::uint64_t amount = change.delta < 0 ?
                                     static_cast<std::uint64_t>( -( change.delta + 1 ) ) + 1U :
                                     static_cast<std::uint64_t>( change.delta );
        const std::uint64_t available = static_cast<std::uint64_t>( resource->available );
        // The normalized public value remains an int even when equivalent
        // native entries are aggregated.  Do not create a state that the
        // next snapshot could no longer represent.
        if( change.delta < 0 && amount > available ) {
            error = "resource quantity is insufficient";
            return false;
        }
        const auto liability = std::find_if( outstanding_resources.begin(),
                                             outstanding_resources.end(), [&change](
        const basecamp_platform_resource_change & candidate ) {
            return candidate.resource_id == change.resource_id;
        } );
        const std::uint64_t reserved = liability == outstanding_resources.end() ? 0 :
                                       static_cast<std::uint64_t>( liability->delta );
        if( reserved > static_cast<std::uint64_t>( std::numeric_limits<int>::max() ) -
            available ||
            ( change.delta > 0 && amount > static_cast<std::uint64_t>(
                  std::numeric_limits<int>::max() ) - available - reserved ) ) {
            error = "resource quantity exceeds the native capacity";
            return false;
        }
        if( change.delta < 0 && amount > static_cast<std::uint64_t>(
                std::numeric_limits<int>::max() - resource->consumed ) ) {
            error = "resource consumption bookkeeping would overflow";
            return false;
        }
        if( change.delta < 0 ) {
            std::uint64_t remaining = amount;
            for( const basecamp_resource &candidate : resources ) {
                if( candidate.fake_id != change.resource_id ) {
                    continue;
                }
                const std::uint64_t applied = std::min( remaining,
                                                        static_cast<std::uint64_t>( candidate.available ) );
                if( applied > static_cast<std::uint64_t>(
                        std::numeric_limits<int>::max() - candidate.consumed ) ) {
                    error = "resource consumption bookkeeping would overflow";
                    return false;
                }
                remaining -= applied;
            }
        }
    }

    // Every change has passed the complete preflight above.  Only now mutate
    // the native entries, so a rejected batch cannot partially consume stock.
    for( const basecamp_platform_resource_change &change : changes ) {
        std::uint64_t remaining = change.delta < 0 ?
                                  static_cast<std::uint64_t>( -( change.delta + 1 ) ) + 1U :
                                  static_cast<std::uint64_t>( change.delta );
        for( basecamp_resource &resource : resources ) {
            if( resource.fake_id != change.resource_id || remaining == 0 ) {
                continue;
            }
            if( change.delta > 0 ) {
                const std::uint64_t room = static_cast<std::uint64_t>(
                                               std::numeric_limits<int>::max() - resource.available );
                const std::uint64_t applied = std::min( remaining, room );
                resource.available += static_cast<int>( applied );
                remaining -= applied;
            } else {
                const std::uint64_t applied = std::min( remaining,
                                                        static_cast<std::uint64_t>( resource.available ) );
                resource.available -= static_cast<int>( applied );
                resource.consumed += static_cast<int>( applied );
                remaining -= applied;
            }
        }
    }
    return true;
}

bool basecamp::platform_reservation_liability(
    std::vector<basecamp_platform_resource_change> &result,
    std::int64_t &food_kcal, std::string &error,
    const std::uint64_t excluded_task_id ) const
{
    result.clear();
    food_kcal = 0;
    std::vector<basecamp_resource> normalized;
    if( !platform_resource_snapshot( normalized, error ) ) {
        return false;
    }

    for( const basecamp_platform_task &task : platform_tasks ) {
        if( task.task_id == excluded_task_id || !platform_task_is_active( task ) ) {
            continue;
        }
        if( task.kind != basecamp_platform_resource_work_kind ) {
            if( !task.reserved_resources.empty() || task.reserved_food_kcal != 0 ) {
                error = "non-resource Platform task retains a reservation";
                return false;
            }
            continue;
        }
        if( task.parameters != basecamp_platform_resource_work_parameter_schema ) {
            error = "resource_work task has an invalid parameter schema";
            return false;
        }
        if( !task.resource_work ) {
            error = "resource_work task is missing its descriptor";
            return false;
        }
        if( !validate_basecamp_platform_resource_work( *task.resource_work, error ) ) {
            return false;
        }
        if( task.state == basecamp_platform_task_state::pending ) {
            if( !task.reserved_resources.empty() || task.reserved_food_kcal != 0 ) {
                error = "pending resource_work task retains a reservation";
                return false;
            }
            continue;
        }
        if( task.reservation_discarded ||
            !resource_change_sets_equal( task.reserved_resources,
                                         task.resource_work->resource_inputs ) ||
            task.reserved_food_kcal != task.resource_work->food_input_kcal.value_or( 0 ) ) {
            error = "resource_work reservation ledger is inconsistent";
            return false;
        }
        for( const basecamp_platform_resource_change &change : task.reserved_resources ) {
            const auto native = std::find_if( normalized.begin(), normalized.end(),
            [&change]( const basecamp_resource & resource ) {
                return resource.fake_id == change.resource_id;
            } );
            if( native == normalized.end() ) {
                error = "resource_work reservation refers to an unknown camp resource";
                return false;
            }
            const auto existing = std::find_if( result.begin(), result.end(),
            [&change]( const basecamp_platform_resource_change & candidate ) {
                return candidate.resource_id == change.resource_id;
            } );
            if( existing == result.end() ) {
                result.push_back( change );
            } else if( existing->delta > std::numeric_limits<std::int64_t>::max() -
                       change.delta ) {
                error = "resource_work reservation liability overflows";
                result.clear();
                return false;
            } else {
                existing->delta += change.delta;
            }
        }
        if( task.reserved_food_kcal >
            maximum_platform_resource_work_amount - food_kcal ) {
            error = "resource_work food reservation liability exceeds capacity";
            result.clear();
            return false;
        }
        food_kcal += task.reserved_food_kcal;
    }

    for( const basecamp_platform_resource_change &change : result ) {
        if( change.delta > std::numeric_limits<int>::max() ) {
            error = "resource_work reservation liability exceeds resource capacity";
            result.clear();
            return false;
        }
    }
    error.clear();
    return true;
}

std::vector<basecamp_platform_task> basecamp::platform_task_snapshot() const
{
    std::vector<basecamp_platform_task> result = platform_tasks;
    std::sort( result.begin(), result.end(), []( const basecamp_platform_task & lhs,
    const basecamp_platform_task & rhs ) {
        return lhs.task_id < rhs.task_id;
    } );
    return result;
}

std::vector<basecamp_platform_expansion> basecamp::platform_expansion_snapshot() const
{
    std::vector<basecamp_platform_expansion> result;
    result.reserve( platform_expansions_.size() );
    for( const auto &[expansion_id, stored] : platform_expansions_ ) {
        basecamp_platform_expansion snapshot = stored;
        const auto legacy = expansions.find( stored.direction );
        snapshot.work_in_progress = legacy != expansions.end() &&
                                    !legacy->second.in_progress.empty();
        snapshot.camp_id = platform_id_;
        result.push_back( std::move( snapshot ) );
        static_cast<void>( expansion_id );
    }
    return result;
}

bool basecamp::platform_validate_expansion_placement(
    const std::string &type, const tripoint_abs_omt &position, std::string &error ) const
{
    if( !is_valid() ) {
        error = "camp is not live";
        return false;
    }
    if( type.rfind( base_camps::prefix, 0 ) != 0 ) {
        error = "expansion type is not a Platform expansion recipe";
        return false;
    }
    if( !platform_expansion_position_is_in_domain( omt_pos, position ) ) {
        error = "expansion position is outside the camp expansion domain";
        return false;
    }

    const point_rel_omt direction = talk_function::om_simple_dir( omt_pos, position );
    if( expansions.find( direction ) != expansions.end() ||
        std::find( directions.begin(), directions.end(), direction ) != directions.end() ) {
        error = "an expansion already occupies the requested camp direction";
        return false;
    }
    if( std::any_of( platform_expansions_.begin(), platform_expansions_.end(),
    [&position]( const auto & entry ) {
    return entry.second.position == position;
} ) ) {
        error = "an expansion already occupies the requested position";
        return false;
    }

    // A Platform preflight must observe an existing OMT.  Calling the
    // overmapbuffer accessor that generates an OMT here would mutate the world
    // even when a later eligibility check rejects the request.
    const overmap_with_local_coords target =
        overmap_buffer.get_existing_om_global( position );
    if( !target.om ) {
        error = "the target OMT is not loaded for expansion placement";
        return false;
    }
    const oter_id &actual_terrain = target.om->ter( target.local );
    if( actual_terrain == oter_id() ) {
        error = "the target OMT has no valid terrain for expansion placement";
        return false;
    }

    // The recipe group owns the terrain and mapgen-parameter eligibility
    // rules.  The Platform path must select the requested recipe from that
    // exact result rather than approximating the accepted terrain set.
    const recipe_id requested_recipe( type );
    const std::optional<mapgen_arguments> *maybe_args =
        target.om->mapgen_args( target.local );
    const std::map<recipe_id, translation> eligible_expansions =
        recipe_group::get_recipes_by_id( "all_faction_base_expansions", actual_terrain,
                                         maybe_args );
    if( !requested_recipe.is_valid() ||
        eligible_expansions.find( requested_recipe ) == eligible_expansions.end() ) {
        error = "expansion type is not eligible for the target OMT terrain";
        return false;
    }

    // A stale faction-base terrain or an exact camp at the target is occupied
    // even if the legacy camp map has not been rebuilt yet.  Do not use the
    // broad overmapbuffer camp search: this check is for the supplied OMT.
    if( is_ot_match( "faction_base", actual_terrain, ot_match_type::contains ) ) {
        error = "the target OMT is already occupied by a faction camp terrain";
        return false;
    }
    if( target.om->find_camp( position.xy() ) ) {
        error = "the target OMT already contains a camp";
        return false;
    }

    error.clear();
    return true;
}

bool basecamp::platform_validate_upgrade_target(
    const basecamp_platform_upgrade_work &work, std::string &error ) const
{
    if( !is_valid() ) {
        error = "camp is not live";
        return false;
    }
    if( !validate_basecamp_platform_upgrade_work( work, error ) ) {
        return false;
    }

    point_rel_omt direction = base_camps::base_dir;
    tripoint_abs_omt expected_position = omt_pos;
    if( work.target_kind == basecamp_platform_upgrade_target_kind::expansion ) {
        const auto expansion_it = platform_expansions_.find( work.target_expansion_id );
        if( expansion_it == platform_expansions_.end() ||
            expansion_it->second.identity_generation != work.target_expansion_generation ) {
            error = "upgrade_work target expansion token is stale";
            return false;
        }
        direction = expansion_it->second.direction;
        expected_position = expansion_it->second.position;
    } else if( platform_core_upgrade_generation_ != work.target_core_generation ) {
        error = "upgrade_work target core generation is stale";
        return false;
    }
    if( work.target_position != expected_position ) {
        error = "upgrade_work target position no longer matches its stable target identity";
        return false;
    }
    const auto legacy_it = expansions.find( direction );
    if( legacy_it == expansions.end() || legacy_it->second.pos != expected_position ) {
        error = "upgrade_work target expansion is no longer present in the camp domain";
        return false;
    }
    const expansion_data &target = legacy_it->second;
    const oter_id &actual_terrain = overmap_buffer.ter_existing( expected_position );
    if( !actual_terrain.is_valid() || actual_terrain.id().str() != work.target_terrain ) {
        error = "upgrade_work target terrain changed since the task was created";
        return false;
    }

    const ::recipe_id upgrade_ident( work.upgrade_id );
    const recipe &upgrade = upgrade_ident.obj();
    bool mirror_horizontal = false;
    bool mirror_vertical = false;
    int rotation = 0;
    if( !basecamp_upgrade_orientation_flags( upgrade.ident(), direction,
            mirror_horizontal, mirror_vertical, rotation,
            "upgrade_work has invalid orientation", "" ) ) {
        error = "upgrade_work blueprint orientation is ambiguous for the exact target direction";
        return false;
    }
    static_cast<void>( mirror_horizontal );
    static_cast<void>( mirror_vertical );
    static_cast<void>( rotation );
    const auto required = upgrade.blueprint_requires();
    for( const auto &parent : required ) {
        const auto provided = target.provides.find( parent.first );
        if( provided == target.provides.end() || provided->second < parent.second ) {
            error = "upgrade_work parent or ordering requirement is not satisfied";
            return false;
        }
    }
    if( target.provides.find( work.upgrade_id ) != target.provides.end() ) {
        error = "upgrade_work target upgrade has already been applied";
        return false;
    }
    for( const auto &provided : upgrade.blueprint_provides() ) {
        const auto in_progress = target.in_progress.find( provided.first );
        if( in_progress != target.in_progress.end() && in_progress->second >= provided.second ) {
            error = "upgrade_work target has the same upgrade already in progress";
            return false;
        }
    }
    for( const auto &excluded : upgrade.blueprint_excludes() ) {
        const auto provided = target.provides.find( excluded.first );
        if( provided != target.provides.end() && provided->second >= excluded.second ) {
            error = "upgrade_work target is excluded by an already applied upgrade";
            return false;
        }
        const auto in_progress = target.in_progress.find( excluded.first );
        if( in_progress != target.in_progress.end() && in_progress->second >= excluded.second ) {
            error = "upgrade_work target conflicts with an upgrade already in progress";
            return false;
        }
    }
    if( oter_str_id( work.upgrade_id ).is_valid() &&
        oter_id( work.upgrade_id ) == actual_terrain ) {
        error = "upgrade_work target upgrade has already changed the terrain";
        return false;
    }
    error.clear();
    return true;
}

basecamp_platform_upgrade_commit_state basecamp::platform_upgrade_commit_state(
    const basecamp_platform_upgrade_work &work,
    const std::uint64_t task_identity_generation,
    const std::uint64_t applying_marker,
    const std::uint64_t commit_marker,
    std::string &error ) const
{
    error.clear();
    // This helper is only valid for a save observed between the applying and
    // terminal markers.  A marker mismatch is not evidence of either outcome:
    // it is an ambiguous/corrupt recovery boundary and must be retained.
    if( task_identity_generation == 0 || applying_marker == 0 ||
        applying_marker != task_identity_generation || commit_marker != 0 ) {
        error = "upgrade_work applying markers are not internally consistent";
        return basecamp_platform_upgrade_commit_state::unknown;
    }
    if( !is_valid() || !validate_basecamp_platform_upgrade_work( work, error ) ) {
        return basecamp_platform_upgrade_commit_state::unknown;
    }

    point_rel_omt direction = base_camps::base_dir;
    bool generation_pristine = true;
    bool generation_committed = false;
    if( work.target_kind == basecamp_platform_upgrade_target_kind::camp_core ) {
        if( platform_core_upgrade_generation_ == work.target_core_generation ) {
            generation_pristine = true;
        } else if( work.target_core_generation !=
                   std::numeric_limits<std::uint64_t>::max() &&
                   platform_core_upgrade_generation_ == work.target_core_generation + 1 ) {
            generation_pristine = false;
            generation_committed = true;
        } else {
            error = "upgrade_work applying marker observes an unknown core generation";
            return basecamp_platform_upgrade_commit_state::unknown;
        }
    } else if( work.target_kind == basecamp_platform_upgrade_target_kind::expansion ) {
        const auto expansion_it = platform_expansions_.find( work.target_expansion_id );
        if( expansion_it == platform_expansions_.end() ) {
            error = "upgrade_work applying marker refers to an unknown expansion";
            return basecamp_platform_upgrade_commit_state::unknown;
        }
        if( expansion_it->second.identity_generation == work.target_expansion_generation ) {
            generation_pristine = true;
        } else if( work.target_expansion_generation !=
                   std::numeric_limits<std::uint64_t>::max() &&
                   expansion_it->second.identity_generation ==
                   work.target_expansion_generation + 1 ) {
            generation_pristine = false;
            generation_committed = true;
        } else {
            error = "upgrade_work applying marker observes an unknown expansion generation";
            return basecamp_platform_upgrade_commit_state::unknown;
        }
        direction = expansion_it->second.direction;
    } else if( work.target_expansion_id != 0 || work.target_expansion_generation != 0 ) {
        error = "upgrade_work camp-core recovery carries an expansion generation";
        return basecamp_platform_upgrade_commit_state::unknown;
    }

    const auto legacy_it = expansions.find( direction );
    if( legacy_it == expansions.end() || legacy_it->second.pos != work.target_position ) {
        error = "upgrade_work applying marker has no authoritative target metadata";
        return basecamp_platform_upgrade_commit_state::unknown;
    }
    const overmap_with_local_coords target =
        overmap_buffer.get_existing_om_global( work.target_position );
    if( !target.om ) {
        error = "upgrade_work applying marker target terrain is not loaded";
        return basecamp_platform_upgrade_commit_state::unknown;
    }
    const oter_id actual_terrain = target.om->ter( target.local );
    const oter_id expected_old_terrain( work.target_terrain );
    if( !actual_terrain.is_valid() || !expected_old_terrain.is_valid() ) {
        error = "upgrade_work applying marker target terrain is not authoritative";
        return basecamp_platform_upgrade_commit_state::unknown;
    }

    const recipe &upgrade = ::recipe_id( work.upgrade_id ).obj();
    const auto &provides = legacy_it->second.provides;
    const auto &in_progress = legacy_it->second.in_progress;
    bool metadata_untouched = true;
    bool metadata_committed = !upgrade.blueprint_provides().empty();
    for( const auto &[provide_id, amount] : upgrade.blueprint_provides() ) {
        const auto provided = provides.find( provide_id );
        const auto pending = in_progress.find( provide_id );
        if( provided != provides.end() || pending != in_progress.end() ) {
            metadata_untouched = false;
        }
        if( amount <= 0 || provided == provides.end() || provided->second != amount ||
            pending != in_progress.end() ) {
            metadata_committed = false;
        }
    }

    std::optional<oter_id> expected_new_terrain;
    if( oter_str_id( work.upgrade_id ).is_valid() ) {
        expected_new_terrain = oter_id( work.upgrade_id );
        if( *expected_new_terrain == expected_old_terrain ) {
            error = "upgrade_work applying marker has no distinct committed terrain";
            return basecamp_platform_upgrade_commit_state::unknown;
        }
    }
    const bool terrain_pristine = actual_terrain == expected_old_terrain;
    const bool terrain_committed = expected_new_terrain ?
                                   actual_terrain == *expected_new_terrain : terrain_pristine;

    // Retryable means every observable value is still exactly at its pre-apply
    // value.  A partial provides/in_progress edit, a generation advance, or a
    // terrain change is never safe to replay.
    if( terrain_pristine && generation_pristine && metadata_untouched ) {
        return basecamp_platform_upgrade_commit_state::not_committed;
    }

    // Committed means all evidence agrees: exact post-upgrade terrain (or the
    // unchanged terrain for a terrain-neutral blueprint), complete provides,
    // no residual in-progress entry, and the one expected expansion generation
    // retirement.  The task marker was checked above before these domain facts.
    if( terrain_committed && metadata_committed &&
        ( ( expected_new_terrain && !terrain_pristine && generation_committed ) ||
          ( !expected_new_terrain && generation_committed ) ) ) {
        return basecamp_platform_upgrade_commit_state::committed;
    }

    error = "upgrade_work applying marker observes a partial or ambiguous state";
    return basecamp_platform_upgrade_commit_state::unknown;
}

bool basecamp::platform_get_expansion(
    const std::uint64_t expansion_id, const std::uint64_t identity_generation,
    basecamp_platform_expansion &result, std::string &error ) const
{
    const auto found = platform_expansions_.find( expansion_id );
    if( found == platform_expansions_.end() ) {
        error = platform_retired_expansion_generations_.count( expansion_id ) != 0 ?
                "expansion token refers to a retired generation" :
                "expansion was not found";
        return false;
    }
    if( found->second.identity_generation != identity_generation ) {
        error = "expansion token refers to a retired generation";
        return false;
    }
    result = found->second;
    const auto legacy = expansions.find( found->second.direction );
    result.work_in_progress = legacy != expansions.end() &&
                              !legacy->second.in_progress.empty();
    result.camp_id = platform_id_;
    error.clear();
    return true;
}

bool basecamp::platform_create_expansion(
    const std::string &type, const std::string &expansion_name,
    const tripoint_abs_omt &position, basecamp_platform_expansion &result,
    std::string &error )
{
    if( !is_valid() ) {
        error = "camp is not live";
        return false;
    }
    if( !platform_expansion_name_is_valid( expansion_name ) ) {
        error = "expansion name is empty, too long, or contains a control character";
        return false;
    }
    if( !platform_validate_expansion_placement( type, position, error ) ) {
        return false;
    }
    const point_rel_omt direction = talk_function::om_simple_dir( omt_pos, position );

    expansion_data legacy;
    legacy.type = type;
    legacy.pos = position;
    legacy.cur_level = -1;
    basecamp_platform_expansion created;
    created.expansion_id = allocate_platform_expansion_id();
    created.identity_generation = 1;
    created.camp_id = platform_id_;
    created.direction = direction;
    created.position = position;
    created.type = type;
    created.name = expansion_name;
    created.work_in_progress = false;

    // Prepare every allocating operation on detached containers before the
    // three native maps/vectors are published.  A failed allocation or an
    // unexpected duplicate therefore cannot leave a half-created expansion.
    std::map<point_rel_omt, expansion_data> staged_expansions = expansions;
    std::vector<point_rel_omt> staged_directions = directions;
    std::map<std::uint64_t, basecamp_platform_expansion> staged_platform_expansions =
        platform_expansions_;
    staged_expansions.emplace( direction, legacy );
    if( std::find( staged_directions.begin(), staged_directions.end(), direction ) ==
        staged_directions.end() ) {
        staged_directions.push_back( direction );
    }
    if( !staged_platform_expansions.emplace( created.expansion_id, created ).second ) {
        error = "the allocated expansion identity is already in use";
        return false;
    }
    expansions.swap( staged_expansions );
    directions.swap( staged_directions );
    platform_expansions_.swap( staged_platform_expansions );
    result = created;
    error.clear();
    return true;
}

bool basecamp::platform_remove_expansion(
    const std::uint64_t expansion_id, const std::uint64_t identity_generation,
    std::string &error )
{
    const auto found = platform_expansions_.find( expansion_id );
    if( found == platform_expansions_.end() ) {
        error = "expansion was not found";
        return false;
    }
    if( found->second.identity_generation != identity_generation ) {
        error = "expansion token refers to a retired generation";
        return false;
    }
    if( found->second.direction == base_camps::base_dir ) {
        error = "the base expansion cannot be removed independently";
        return false;
    }
    const auto legacy = expansions.find( found->second.direction );
    if( legacy != expansions.end() && !legacy->second.in_progress.empty() ) {
        error = "expansion work is still in progress";
        return false;
    }
    for( const basecamp_platform_task &task : platform_tasks ) {
        if( !task.upgrade_work ||
            task.upgrade_work->target_kind != basecamp_platform_upgrade_target_kind::expansion ||
            task.upgrade_work->target_expansion_id != expansion_id ||
            task.upgrade_work->target_expansion_generation != identity_generation ) {
            continue;
        }
        const bool recoverable =
            task.state == basecamp_platform_task_state::pending ||
            task.state == basecamp_platform_task_state::running ||
            task.state == basecamp_platform_task_state::refund_pending ||
            task.state == basecamp_platform_task_state::completed_unclaimed ||
            !task.recipe_escrow.empty() || task.upgrade_applying_marker != 0;
        if( recoverable ) {
            error = "upgrade_work still targets this expansion";
            return false;
        }
    }
    const point_rel_omt direction = found->second.direction;
    platform_retire_expansion_identity( expansion_id );
    expansions.erase( direction );
    directions.erase( std::remove( directions.begin(), directions.end(), direction ),
                      directions.end() );
    error.clear();
    return true;
}

bool basecamp::platform_can_remove( std::string &error ) const
{
    if( !is_valid() ) {
        error = "camp is not live";
        return false;
    }
    if( !assigned_npcs.empty() ) {
        error = "camp still has assigned workers";
        return false;
    }
    for( const auto &[direction, expansion] : expansions ) {
        static_cast<void>( direction );
        if( !expansion.in_progress.empty() ) {
            error = "camp still has unresolved expansion work";
            return false;
        }
    }
    for( const basecamp_platform_task &task : platform_tasks ) {
        const bool active = task.state == basecamp_platform_task_state::pending ||
                            task.state == basecamp_platform_task_state::running ||
                            task.state == basecamp_platform_task_state::refund_pending ||
                            task.state == basecamp_platform_task_state::completed_unclaimed;
        if( active || !task.recipe_escrow.empty() || task.upgrade_commit_marker != 0 ||
            task.upgrade_applying_marker != 0 || !task.reserved_resources.empty() ||
            task.reserved_food_kcal != 0 ) {
            error = "camp still has active or recoverable Platform task state";
            return false;
        }
    }
    for( const auto &[expansion_id, expansion] : platform_expansions_ ) {
        if( expansion.direction != base_camps::base_dir ) {
            error = "camp still has child expansions";
            return false;
        }
        static_cast<void>( expansion_id );
        if( expansion.work_in_progress ) {
            error = "camp still has unresolved Platform expansion work";
            return false;
        }
    }
    error.clear();
    return true;
}

bool basecamp::platform_create_task( basecamp_platform_task &task, std::string &error )
{
    constexpr std::size_t maximum_platform_tasks = 256;
    if( !is_valid() ) {
        error = "camp is not live";
        return false;
    }
    if( task.camp_id == 0 ) {
        task.camp_id = platform_id_;
    }
    if( task.camp_id != platform_id_ ) {
        error = "task belongs to a different camp";
        return false;
    }
    if( task.task_id == 0 ) {
        task.task_id = allocate_platform_task_id();
    }
    if( task.identity_generation != 1 ) {
        error = "new task must start at identity generation 1";
        return false;
    }
    if( task.owner_faction.is_null() || !task.manager.is_valid() ||
        !task.worker.is_valid() || task.worker_identity_generation == 0 ) {
        error = "task requires valid owner, manager, and worker identities";
        return false;
    }
    if( task.owner_faction != owner ) {
        error = "task owner does not match the camp owner";
        return false;
    }
    if( task.kind == basecamp_platform_resource_work_kind ) {
        if( !task.resource_work ) {
            error = "resource_work task requires a typed descriptor";
            return false;
        }
        if( task.parameters.empty() ) {
            task.parameters = std::string( basecamp_platform_resource_work_parameter_schema );
        }
        if( !task.reserved_resources.empty() || task.reserved_food_kcal != 0 ) {
            error = "new resource_work task cannot retain a reservation";
            return false;
        }
    } else if( task.kind == basecamp_platform_recipe_work_kind ) {
        if( !task.recipe_work ) {
            error = "recipe_work task requires a typed descriptor";
            return false;
        }
        if( task.parameters.empty() ) {
            task.parameters = std::string( basecamp_platform_recipe_work_parameter_schema );
        }
        if( !task.recipe_escrow.empty() ) {
            error = "new recipe_work task cannot retain an escrow or refund state";
            return false;
        }
    } else if( task.kind == basecamp_platform_upgrade_work_kind ) {
        if( !task.upgrade_work ) {
            error = "upgrade_work task requires a typed descriptor";
            return false;
        }
        if( task.parameters.empty() ) {
            task.parameters = std::string( basecamp_platform_upgrade_work_parameter_schema );
        }
        if( !task.recipe_escrow.empty() ) {
            error = "new upgrade_work task cannot retain an escrow or refund state";
            return false;
        }
    } else if( task.resource_work || task.recipe_work ||
               task.upgrade_work ||
               !task.reserved_resources.empty() || task.reserved_food_kcal != 0 ||
               !task.recipe_escrow.empty() ) {
        error = "the task kind does not permit a resource or recipe descriptor";
        return false;
    }
    if( platform_tasks.size() >= maximum_platform_tasks ) {
        error = "camp task capacity is exhausted";
        return false;
    }
    if( std::any_of( platform_tasks.begin(), platform_tasks.end(),
    [&task]( const basecamp_platform_task & existing ) {
    return existing.task_id == task.task_id;
} ) ) {
        error = "task id is already in use";
        return false;
    }
    if( std::any_of( platform_tasks.begin(), platform_tasks.end(),
    [&task]( const basecamp_platform_task & existing ) {
    const bool active = existing.state == basecamp_platform_task_state::pending ||
                        existing.state == basecamp_platform_task_state::running;
    return active && existing.worker == task.worker &&
           existing.worker_identity_generation == task.worker_identity_generation;
} ) ) {
        error = "worker already has an active Platform camp task";
        return false;
    }
    if( task.kind == basecamp_platform_upgrade_work_kind ) {
        if( !task.upgrade_work ||
            !platform_validate_upgrade_target( *task.upgrade_work, error ) ) {
            return false;
        }
        if( std::any_of( platform_tasks.begin(), platform_tasks.end(),
        [&task]( const basecamp_platform_task & existing ) {
        if( existing.kind != basecamp_platform_upgrade_work_kind ||
                !existing.upgrade_work || !task.upgrade_work ||
                !platform_task_is_active( existing ) ) {
                return false;
            }
            return existing.upgrade_work->upgrade_id == task.upgrade_work->upgrade_id &&
                   existing.upgrade_work->target_kind == task.upgrade_work->target_kind &&
                   existing.upgrade_work->target_position == task.upgrade_work->target_position;
        } ) ) {
            error = "the exact upgrade target already has an active upgrade_work task";
            return false;
        }
    }

    basecamp_platform_task_execution_context context;
    context.camp = this;
    context.task = &task;
    if( !dispatch_basecamp_platform_task(
            task.kind, basecamp_platform_task_operation::preflight, context, error ) ) {
        return false;
    }

    task.awaiting_reconciliation = false;
    reserve_platform_task_id( task.task_id );
    std::vector<basecamp_platform_task> staged = platform_tasks;
    staged.push_back( task );
    std::sort( staged.begin(), staged.end(), []( const basecamp_platform_task & lhs,
    const basecamp_platform_task & rhs ) {
        return lhs.task_id < rhs.task_id;
    } );
    platform_tasks.swap( staged );
    error.clear();
    return true;
}

bool basecamp::platform_start_task( const std::uint64_t task_id,
                                    const std::uint64_t task_generation,
                                    const npc_ptr &worker, const time_point now,
                                    const time_duration duration, std::string &error )
{
    auto task_it = std::find_if( platform_tasks.begin(), platform_tasks.end(),
    [task_id]( const basecamp_platform_task & candidate ) {
        return candidate.task_id == task_id;
    } );
    if( task_it == platform_tasks.end() ) {
        error = "task was not found";
        return false;
    }
    if( task_it->identity_generation != task_generation ) {
        error = "task token refers to a retired generation";
        return false;
    }
    std::vector<npc_ptr> staged_assigned = assigned_npcs;
    std::vector<basecamp_platform_task> staged_tasks = platform_tasks;
    std::vector<basecamp_resource> staged_resources = resources;
    auto staged_it = std::find_if( staged_tasks.begin(), staged_tasks.end(),
    [task_id]( const basecamp_platform_task & candidate ) {
        return candidate.task_id == task_id;
    } );
    if( staged_it == staged_tasks.end() ) {
        error = "task disappeared during preflight";
        return false;
    }
    basecamp_platform_task_execution_context context;
    context.camp = this;
    context.task = &*staged_it;
    context.worker = worker;
    context.staged_tasks = &staged_tasks;
    context.staged_assigned = &staged_assigned;
    context.staged_resources = &staged_resources;
    context.now = now;
    context.duration = duration;
    if( !dispatch_basecamp_platform_task(
            staged_it->kind, basecamp_platform_task_operation::start, context, error ) ) {
        return false;
    }
    if( context.staged_food_delta_kcal != 0 ) {
        faction *owner_faction = platform_task_owner( *this, error );
        if( owner_faction == nullptr ||
            !apply_platform_food_delta( *owner_faction,
                                        context.staged_food_delta_kcal, error ) ) {
            return false;
        }
    }
    if( context.commit_worker_assignment && context.worker ) {
        context.worker->assigned_camp = omt_pos;
    }
    resources.swap( staged_resources );
    assigned_npcs.swap( staged_assigned );
    platform_tasks.swap( staged_tasks );
    error.clear();
    return true;
}

bool basecamp::platform_start_task(
    const std::uint64_t task_id, const std::uint64_t task_generation,
    const npc_ptr &worker, const time_point now, const time_duration duration,
    const std::vector<basecamp_platform_recipe_escrow_item> &escrow,
    std::string &error )
{
    auto task_it = std::find_if( platform_tasks.begin(), platform_tasks.end(),
    [task_id]( const basecamp_platform_task & candidate ) {
        return candidate.task_id == task_id;
    } );
    if( task_it == platform_tasks.end() ) {
        error = "task was not found";
        return false;
    }
    if( task_it->identity_generation != task_generation ) {
        error = "task token refers to a retired generation";
        return false;
    }
    if( task_it->kind != basecamp_platform_recipe_work_kind &&
        task_it->kind != basecamp_platform_upgrade_work_kind ) {
        error = "Item escrow start requires a recipe_work or upgrade_work task";
        return false;
    }
    std::vector<npc_ptr> staged_assigned = assigned_npcs;
    std::vector<basecamp_platform_task> staged_tasks = platform_tasks;
    std::vector<basecamp_resource> staged_resources = resources;
    auto staged_it = std::find_if( staged_tasks.begin(), staged_tasks.end(),
    [task_id]( const basecamp_platform_task & candidate ) {
        return candidate.task_id == task_id;
    } );
    if( staged_it == staged_tasks.end() ) {
        error = "task disappeared during recipe start preflight";
        return false;
    }
    basecamp_platform_task_execution_context context;
    context.camp = this;
    context.task = &*staged_it;
    context.worker = worker;
    context.staged_tasks = &staged_tasks;
    context.staged_assigned = &staged_assigned;
    context.staged_resources = &staged_resources;
    context.recipe_escrow = &escrow;
    context.now = now;
    context.duration = duration;
    if( !dispatch_basecamp_platform_task(
            staged_it->kind, basecamp_platform_task_operation::start,
            context, error ) ) {
        return false;
    }
    if( context.commit_worker_assignment && context.worker ) {
        context.worker->assigned_camp = omt_pos;
    }
    assigned_npcs.swap( staged_assigned );
    platform_tasks.swap( staged_tasks );
    error.clear();
    return true;
}

bool basecamp::platform_finish_task( const std::uint64_t task_id,
                                     const std::uint64_t task_generation,
                                     const npc_ptr &worker, const time_point now,
                                     const bool complete, std::string &error )
{
    auto task_it = std::find_if( platform_tasks.begin(), platform_tasks.end(),
    [task_id]( const basecamp_platform_task & candidate ) {
        return candidate.task_id == task_id;
    } );
    if( task_it == platform_tasks.end() ) {
        error = "task was not found";
        return false;
    }
    if( task_it->identity_generation != task_generation ) {
        error = "task token refers to a retired generation";
        return false;
    }
    std::vector<npc_ptr> staged_assigned = assigned_npcs;
    std::vector<basecamp_platform_task> staged_tasks = platform_tasks;
    std::vector<basecamp_resource> staged_resources = resources;
    auto staged_it = std::find_if( staged_tasks.begin(), staged_tasks.end(),
    [task_id]( const basecamp_platform_task & candidate ) {
        return candidate.task_id == task_id;
    } );
    if( staged_it == staged_tasks.end() ) {
        error = "task disappeared during preflight";
        return false;
    }
    basecamp_platform_task_execution_context context;
    context.camp = this;
    context.task = &*staged_it;
    context.worker = worker;
    context.staged_tasks = &staged_tasks;
    context.staged_assigned = &staged_assigned;
    context.staged_resources = &staged_resources;
    context.now = now;
    context.complete = complete;
    const basecamp_platform_task_operation operation = complete ?
            basecamp_platform_task_operation::complete :
            basecamp_platform_task_operation::cancel;
    if( !dispatch_basecamp_platform_task( staged_it->kind, operation, context, error ) ) {
        return false;
    }
    if( context.staged_food_delta_kcal != 0 ) {
        faction *owner_faction = platform_task_owner( *this, error );
        if( owner_faction == nullptr ||
            !apply_platform_food_delta( *owner_faction,
                                        context.staged_food_delta_kcal, error ) ) {
            return false;
        }
    }
    if( context.commit_worker_release && context.worker ) {
        context.worker->assigned_camp.reset();
    }
    resources.swap( staged_resources );
    assigned_npcs.swap( staged_assigned );
    platform_tasks.swap( staged_tasks );
    error.clear();
    return true;
}

bool basecamp::platform_finish_task(
    const std::uint64_t task_id, const std::uint64_t task_generation,
    const npc_ptr &worker, const time_point now, const bool complete,
    const std::vector<basecamp_platform_recipe_escrow_item> &escrow,
    std::string &error )
{
    auto task_it = std::find_if( platform_tasks.begin(), platform_tasks.end(),
    [task_id]( const basecamp_platform_task & candidate ) {
        return candidate.task_id == task_id;
    } );
    if( task_it == platform_tasks.end() ) {
        error = "task was not found";
        return false;
    }
    if( task_it->identity_generation != task_generation ) {
        error = "task token refers to a retired generation";
        return false;
    }
    if( task_it->kind != basecamp_platform_recipe_work_kind &&
        task_it->kind != basecamp_platform_upgrade_work_kind ) {
        error = "Item escrow finish requires a recipe_work or upgrade_work task";
        return false;
    }
    if( complete ) {
        const std::vector<basecamp_platform_recipe_escrow_item> original_escrow =
            task_it->recipe_escrow;
        if( task_it->kind == basecamp_platform_upgrade_work_kind ) {
            return platform_complete_upgrade_task(
                       task_id, task_generation, worker, now, original_escrow, escrow,
                       error );
        }
        return platform_complete_recipe_task(
                   task_id, task_generation, worker, now, original_escrow, escrow,
                   error );
    }
    if( task_it->state != basecamp_platform_task_state::running ||
        task_it->recipe_escrow.empty() || !worker || worker->is_dead() ||
        worker->getID() != task_it->worker ||
        worker->platform_identity_generation() != task_it->worker_identity_generation ) {
        error = "Item escrow refund requires the exact live worker and running escrow";
        return false;
    }
    if( !recipe_escrow_equal( task_it->recipe_escrow, escrow ) ) {
        error = "Item escrow refund changed before cancellation";
        return false;
    }
    return platform_mark_recipe_refund_pending( task_id, task_generation, error );
}

bool basecamp::platform_complete_recipe_task(
    const std::uint64_t task_id, const std::uint64_t task_generation,
    const npc_ptr &worker, const time_point now,
    const std::vector<basecamp_platform_recipe_escrow_item> &original_escrow,
    const std::vector<basecamp_platform_recipe_escrow_item> &remaining_escrow,
    std::string &error )
{
    auto task_it = std::find_if( platform_tasks.begin(), platform_tasks.end(),
    [task_id]( const basecamp_platform_task & candidate ) {
        return candidate.task_id == task_id;
    } );
    if( task_it == platform_tasks.end() ) {
        error = "task was not found";
        return false;
    }
    if( task_it->identity_generation != task_generation ||
        task_it->kind != basecamp_platform_recipe_work_kind ) {
        error = "recipe_work task token is stale";
        return false;
    }
    if( task_it->recipe_commit_marker != 0 ) {
        error = "recipe_work task has already committed its settlement";
        return false;
    }
    std::vector<npc_ptr> staged_assigned = assigned_npcs;
    std::vector<basecamp_platform_task> staged_tasks = platform_tasks;
    auto staged_it = std::find_if( staged_tasks.begin(), staged_tasks.end(),
    [task_id]( const basecamp_platform_task & candidate ) {
        return candidate.task_id == task_id;
    } );
    if( staged_it == staged_tasks.end() ) {
        error = "task disappeared during recipe completion preflight";
        return false;
    }
    basecamp_platform_task_execution_context context;
    context.camp = this;
    context.task = &*staged_it;
    context.worker = worker;
    context.staged_tasks = &staged_tasks;
    context.staged_assigned = &staged_assigned;
    context.recipe_original_escrow = &original_escrow;
    context.recipe_escrow = &remaining_escrow;
    context.recipe_completion = true;
    context.now = now;
    context.complete = true;
    if( !dispatch_basecamp_platform_task(
            staged_it->kind, basecamp_platform_task_operation::complete,
            context, error ) ) {
        return false;
    }
    if( context.commit_worker_release && context.worker ) {
        context.worker->assigned_camp.reset();
    }
    assigned_npcs.swap( staged_assigned );
    platform_tasks.swap( staged_tasks );
    error.clear();
    return true;
}

bool basecamp::platform_claim_recipe_escrow(
    const std::uint64_t task_id, const std::uint64_t task_generation,
    const time_point now, const bool completed,
    const std::vector<basecamp_platform_recipe_escrow_item> &escrow,
    std::string &error )
{
    auto task_it = std::find_if( platform_tasks.begin(), platform_tasks.end(),
    [task_id]( const basecamp_platform_task & candidate ) {
        return candidate.task_id == task_id;
    } );
    if( task_it == platform_tasks.end() ) {
        error = "task was not found";
        return false;
    }
    if( task_it->identity_generation != task_generation ||
        ( task_it->kind != basecamp_platform_recipe_work_kind &&
          task_it->kind != basecamp_platform_upgrade_work_kind ) ) {
        error = "Item escrow token is stale";
        return false;
    }
    if( ( task_it->state == basecamp_platform_task_state::refund_pending ) == completed ||
        ( task_it->state == basecamp_platform_task_state::completed_unclaimed ) != completed ) {
        error = "recipe_work escrow claim does not match its terminal state";
        return false;
    }
    if( task_it->recipe_recovery_required ) {
        // A structurally invalid save record may still own valid serialized
        // Items.  Recovery is intentionally refund-only: it never executes a
        // recipe and therefore cannot create outputs from an untrusted
        // descriptor.
        if( completed || task_it->state != basecamp_platform_task_state::refund_pending ||
            task_it->recipe_escrow.empty() ||
            !recipe_escrow_equal( task_it->recipe_escrow, escrow ) ) {
            error = "Item escrow recovery requires the exact refund escrow";
            return false;
        }
        if( task_it->identity_generation == std::numeric_limits<std::uint64_t>::max() ) {
            error = "Item escrow task generation cannot be retired";
            return false;
        }
        std::vector<basecamp_platform_task> staged_tasks = platform_tasks;
        auto staged_it = std::find_if( staged_tasks.begin(), staged_tasks.end(),
        [task_id]( const basecamp_platform_task & candidate ) {
            return candidate.task_id == task_id;
        } );
        if( staged_it == staged_tasks.end() ) {
            error = "task disappeared during Item escrow recovery claim";
            return false;
        }
        staged_it->recipe_escrow.clear();
        staged_it->recipe_recovery_required = false;
        staged_it->recipe_commit_marker = 0;
        staged_it->upgrade_commit_marker = 0;
        staged_it->upgrade_applying_marker = 0;
        staged_it->state = basecamp_platform_task_state::cancelled;
        staged_it->finished_at = now;
        staged_it->awaiting_reconciliation = false;
        ++staged_it->identity_generation;
        platform_tasks.swap( staged_tasks );
        error.clear();
        return true;
    }
    std::vector<basecamp_platform_task> staged_tasks = platform_tasks;
    auto staged_it = std::find_if( staged_tasks.begin(), staged_tasks.end(),
    [task_id]( const basecamp_platform_task & candidate ) {
        return candidate.task_id == task_id;
    } );
    if( staged_it == staged_tasks.end() ) {
        error = "task disappeared during Item escrow claim";
        return false;
    }
    basecamp_platform_task_execution_context context;
    context.camp = this;
    context.task = &*staged_it;
    context.staged_tasks = &staged_tasks;
    context.recipe_escrow = &escrow;
    context.recipe_claim = true;
    context.complete = completed;
    context.now = now;
    if( !dispatch_basecamp_platform_task(
            staged_it->kind, basecamp_platform_task_operation::complete,
            context, error ) ) {
        return false;
    }
    platform_tasks.swap( staged_tasks );
    error.clear();
    return true;
}

bool basecamp::platform_prepare_recipe_refund(
    const std::uint64_t task_id, const std::uint64_t task_generation,
    const npc_ptr &worker,
    std::vector<basecamp_platform_recipe_escrow_item> &escrow,
    std::string &error ) const
{
    const auto task_it = std::find_if( platform_tasks.begin(), platform_tasks.end(),
    [task_id]( const basecamp_platform_task & candidate ) {
        return candidate.task_id == task_id;
    } );
    if( task_it == platform_tasks.end() ) {
        error = "task was not found";
        return false;
    }
    if( task_it->identity_generation != task_generation ||
        ( task_it->kind != basecamp_platform_recipe_work_kind &&
          task_it->kind != basecamp_platform_upgrade_work_kind ) ||
        ( task_it->kind == basecamp_platform_recipe_work_kind &&
          !task_it->recipe_work && !task_it->recipe_recovery_required ) ||
        ( task_it->kind == basecamp_platform_upgrade_work_kind &&
          !task_it->upgrade_work && !task_it->recipe_recovery_required ) ) {
        error = "Item escrow refund token is stale";
        return false;
    }
    if( task_it->state == basecamp_platform_task_state::running ) {
        if( !worker || worker->is_dead() || worker->getID() != task_it->worker ||
            worker->platform_identity_generation() != task_it->worker_identity_generation ) {
            error = "Item escrow refund requires the exact live worker";
            return false;
        }
    } else if( task_it->state != basecamp_platform_task_state::refund_pending &&
               task_it->state != basecamp_platform_task_state::completed_unclaimed ) {
        error = "Item escrow task has no recoverable escrow";
        return false;
    }
    if( !task_it->recipe_recovery_required ) {
        if( task_it->kind == basecamp_platform_recipe_work_kind &&
            !recipe_escrow_shape_matches_work( *task_it->recipe_work,
                                               task_it->recipe_escrow, error ) ) {
            return false;
        }
        if( task_it->kind == basecamp_platform_upgrade_work_kind &&
            !upgrade_escrow_shape_matches_work( *task_it->upgrade_work,
                                                task_it->recipe_escrow, error ) ) {
            return false;
        }
    }
    escrow = task_it->recipe_escrow;
    error.clear();
    return true;
}

bool basecamp::platform_prepare_recipe_completion(
    const std::uint64_t task_id, const std::uint64_t task_generation,
    const npc_ptr &worker, const time_point now,
    std::vector<basecamp_platform_recipe_escrow_item> &remaining_escrow,
    std::string &error ) const
{
    remaining_escrow.clear();
    const auto task_it = std::find_if( platform_tasks.begin(), platform_tasks.end(),
    [task_id]( const basecamp_platform_task & candidate ) {
        return candidate.task_id == task_id;
    } );
    if( task_it == platform_tasks.end() ) {
        error = "task was not found";
        return false;
    }
    if( task_it->identity_generation != task_generation ||
        task_it->kind != basecamp_platform_recipe_work_kind ||
        task_it->state != basecamp_platform_task_state::running ||
        !task_it->recipe_work || !worker || worker->is_dead() ||
        worker->getID() != task_it->worker ||
        worker->platform_identity_generation() != task_it->worker_identity_generation ) {
        error = "recipe_work completion requires the exact live worker and task generation";
        return false;
    }
    if( now == calendar::before_time_starts || now < task_it->due_at ) {
        error = "recipe_work task is not due for completion";
        return false;
    }
    if( !recipe_escrow_matches_work( *task_it->recipe_work,
                                     task_it->recipe_escrow, worker.get(), error ) ) {
        return false;
    }

    const recipe &making = ::recipe_id( task_it->recipe_work->recipe_id ).obj();
    std::vector<detached_recipe_item> detached;
    detached.reserve( task_it->recipe_escrow.size() );
    for( const basecamp_platform_recipe_escrow_item &entry : task_it->recipe_escrow ) {
        detached_recipe_item value;
        value.metadata = entry;
        std::string item_error;
        if( !deserialize_platform_recipe_item( entry.serialized_item,
                                               value.value, item_error ) ) {
            error = item_error;
            return false;
        }
        if( value.value.uid().get_value() != entry.stable_uid ||
            ( value.value.count_by_charges() ? value.value.charges : 1 ) != entry.charges ) {
            error = "recipe_work completion escrow has inconsistent Item identity or charges";
            return false;
        }
        detached.push_back( std::move( value ) );
    }

    item_components consumed_components;
    if( !select_and_consume_detached_recipe_requirements(
            making, *task_it->recipe_work, *worker, detached,
            consumed_components, error ) ) {
        return false;
    }

    // The recipe result helper receives the exact detached component values,
    // preserving the engine's food/uncraft component inheritance semantics.
    const std::vector<item> result_items = making.create_results(
            task_it->recipe_work->batch,
            &consumed_components );
    if( result_items.empty() || result_items.size() > maximum_platform_recipe_escrow_items ) {
        error = "recipe_work authoritative recipe result is empty or unbounded";
        return false;
    }

    if( detached.size() > maximum_platform_recipe_escrow_items - result_items.size() ) {
        error = "recipe_work completion escrow exceeds its bounded item count";
        return false;
    }
    remaining_escrow.reserve( detached.size() + result_items.size() );
    std::set<std::int64_t> result_uids;
    for( const detached_recipe_item &entry : detached ) {
        if( entry.value.is_null() ) {
            continue;
        }
        basecamp_platform_recipe_escrow_item remaining = entry.metadata;
        remaining.charges = entry.value.count_by_charges() ? entry.value.charges : 1;
        if( !result_uids.insert( remaining.stable_uid ).second ) {
            error = "recipe_work completion retained a duplicate Item UID";
            remaining_escrow.clear();
            return false;
        }
        if( !serialize_platform_recipe_item( entry.value,
                                             remaining.serialized_item, error ) ) {
            remaining_escrow.clear();
            return false;
        }
        remaining_escrow.push_back( std::move( remaining ) );
    }

    for( const item &value : result_items ) {
        basecamp_platform_recipe_escrow_item output;
        output.stable_uid = value.uid().get_value();
        output.identity_generation = 1;
        output.charges = value.count_by_charges() ? value.charges : 1;
        output.tool = false;
        output.source_holder = task_it->recipe_work->destination_holder;
        if( output.stable_uid <= 0 || !result_uids.insert( output.stable_uid ).second ||
            !serialize_platform_recipe_item( value, output.serialized_item, error ) ) {
            remaining_escrow.clear();
            return false;
        }
        remaining_escrow.push_back( std::move( output ) );
    }
    error.clear();
    return true;
}

bool basecamp::platform_prepare_upgrade_completion(
    const std::uint64_t task_id, const std::uint64_t task_generation,
    const npc_ptr &worker, const time_point now,
    std::vector<basecamp_platform_recipe_escrow_item> &remaining_escrow,
    std::string &error ) const
{
    remaining_escrow.clear();
    const auto task_it = std::find_if( platform_tasks.begin(), platform_tasks.end(),
    [task_id]( const basecamp_platform_task & candidate ) {
        return candidate.task_id == task_id;
    } );
    if( task_it == platform_tasks.end() ) {
        error = "task was not found";
        return false;
    }
    if( task_it->identity_generation != task_generation ||
        task_it->kind != basecamp_platform_upgrade_work_kind ||
        task_it->state != basecamp_platform_task_state::running ||
        !task_it->upgrade_work || !worker || worker->is_dead() ||
        worker->getID() != task_it->worker ||
        worker->platform_identity_generation() != task_it->worker_identity_generation ) {
        error = "upgrade_work completion requires the exact live worker and task generation";
        return false;
    }
    if( now == calendar::before_time_starts || now < task_it->due_at ) {
        error = "upgrade_work task is not due for completion";
        return false;
    }
    if( !platform_validate_upgrade_target( *task_it->upgrade_work, error ) ||
        !upgrade_escrow_matches_work( *task_it->upgrade_work,
                                      task_it->recipe_escrow, worker.get(), error ) ) {
        return false;
    }

    const basecamp_platform_upgrade_work &work = *task_it->upgrade_work;
    const recipe &upgrade = ::recipe_id( work.upgrade_id ).obj();
    const auto requirement_it = upgrade.blueprint_build_reqs().reqs_by_parameters.find(
                                    work.mapgen_args );
    if( requirement_it == upgrade.blueprint_build_reqs().reqs_by_parameters.end() ) {
        error = "upgrade_work has no authoritative blueprint requirements";
        return false;
    }

    std::vector<detached_recipe_item> detached;
    try {
        detached.reserve( task_it->recipe_escrow.size() );
    } catch( const std::exception &exception ) {
        error = std::string( "upgrade_work could not prepare detached escrow: " ) +
                exception.what();
        return false;
    }
    for( const basecamp_platform_recipe_escrow_item &entry : task_it->recipe_escrow ) {
        detached_recipe_item value;
        value.metadata = entry;
        std::string item_error;
        if( !deserialize_platform_recipe_item( entry.serialized_item,
                                               value.value, item_error ) ) {
            error = item_error;
            return false;
        }
        if( value.value.uid().get_value() != entry.stable_uid ||
            ( value.value.count_by_charges() ? value.value.charges : 1 ) != entry.charges ) {
            error = "upgrade_work completion escrow has inconsistent Item identity or charges";
            return false;
        }
        detached.push_back( std::move( value ) );
    }

    item_components consumed_components;
    if( !consume_detached_requirement_data(
            requirement_it->second.consolidated_reqs, upgrade.get_component_filter(), 1,
            "upgrade_work escrow", detached, consumed_components, error ) ) {
        return false;
    }

    try {
        remaining_escrow.reserve( detached.size() );
    } catch( const std::exception &exception ) {
        error = std::string( "upgrade_work could not reserve completion escrow: " ) +
                exception.what();
        remaining_escrow.clear();
        return false;
    }
    std::set<std::int64_t> remaining_uids;
    for( const detached_recipe_item &entry : detached ) {
        if( entry.value.is_null() ) {
            continue;
        }
        basecamp_platform_recipe_escrow_item retained = entry.metadata;
        retained.charges = entry.value.count_by_charges() ? entry.value.charges : 1;
        if( retained.stable_uid <= 0 || !remaining_uids.insert( retained.stable_uid ).second ||
            !serialize_platform_recipe_item( entry.value, retained.serialized_item, error ) ) {
            remaining_escrow.clear();
            if( error.empty() ) {
                error = "upgrade_work completion retained an invalid Item identity";
            }
            return false;
        }
        remaining_escrow.push_back( std::move( retained ) );
    }
    error.clear();
    return true;
}

bool basecamp::platform_complete_upgrade_task(
    const std::uint64_t task_id, const std::uint64_t task_generation,
    const npc_ptr &worker, const time_point now,
    const std::vector<basecamp_platform_recipe_escrow_item> &original_escrow,
    const std::vector<basecamp_platform_recipe_escrow_item> &remaining_escrow,
    std::string &error )
{
    auto task_it = std::find_if( platform_tasks.begin(), platform_tasks.end(),
    [task_id]( const basecamp_platform_task & candidate ) {
        return candidate.task_id == task_id;
    } );
    if( task_it == platform_tasks.end() ) {
        error = "task was not found";
        return false;
    }
    if( task_it->identity_generation != task_generation ||
        task_it->kind != basecamp_platform_upgrade_work_kind ||
        task_it->state != basecamp_platform_task_state::running ||
        !task_it->upgrade_work || task_it->upgrade_commit_marker != 0 ||
        task_it->upgrade_applying_marker != 0 || !worker || worker->is_dead() ||
        worker->getID() != task_it->worker ||
        worker->platform_identity_generation() != task_it->worker_identity_generation ) {
        error = "upgrade_work task token or worker is stale";
        return false;
    }
    if( !recipe_escrow_equal( task_it->recipe_escrow, original_escrow ) ) {
        error = "upgrade_work escrow changed before completion";
        return false;
    }
    if( now == calendar::before_time_starts || now < task_it->due_at ) {
        error = "upgrade_work task is not due for completion";
        return false;
    }
    if( !platform_validate_upgrade_target( *task_it->upgrade_work, error ) ||
        !upgrade_escrow_matches_work( *task_it->upgrade_work,
                                      task_it->recipe_escrow, worker.get(), error ) ) {
        return false;
    }
    if( remaining_escrow.size() > maximum_platform_recipe_escrow_items ||
        ( !remaining_escrow.empty() &&
          !upgrade_escrow_shape_matches_work( *task_it->upgrade_work,
                  remaining_escrow, error ) ) ) {
        if( error.empty() ) {
            error = "upgrade_work completion escrow is outside its bound";
        }
        return false;
    }

    const basecamp_platform_upgrade_work &work = *task_it->upgrade_work;
    const recipe &upgrade = ::recipe_id( work.upgrade_id ).obj();
    point_rel_omt direction = base_camps::base_dir;
    if( work.target_kind == basecamp_platform_upgrade_target_kind::expansion ) {
        const auto expansion_it = platform_expansions_.find( work.target_expansion_id );
        if( expansion_it == platform_expansions_.end() ||
            expansion_it->second.identity_generation != work.target_expansion_generation ) {
            error = "upgrade_work target expansion token is stale";
            return false;
        }
        direction = expansion_it->second.direction;
    }
    auto legacy_it = expansions.find( direction );
    if( legacy_it == expansions.end() || legacy_it->second.pos != work.target_position ) {
        error = "upgrade_work target metadata is no longer present";
        return false;
    }
    bool mirror_horizontal = false;
    bool mirror_vertical = false;
    int rotation = 0;
    if( !basecamp_upgrade_orientation_flags( upgrade.ident(), direction,
            mirror_horizontal, mirror_vertical, rotation,
            "upgrade_work has invalid orientation", "" ) ) {
        error = "upgrade_work blueprint orientation is ambiguous";
        return false;
    }
    if( task_it->identity_generation == std::numeric_limits<std::uint64_t>::max() ) {
        error = "upgrade_work task generation cannot be retired";
        return false;
    }
    if( work.target_kind == basecamp_platform_upgrade_target_kind::camp_core &&
        platform_core_upgrade_generation_ == std::numeric_limits<std::uint64_t>::max() ) {
        error = "upgrade_work core generation cannot be retired";
        return false;
    }
    if( work.target_kind == basecamp_platform_upgrade_target_kind::expansion ) {
        const auto expansion_it = platform_expansions_.find( work.target_expansion_id );
        if( expansion_it == platform_expansions_.end() ||
            expansion_it->second.identity_generation == std::numeric_limits<std::uint64_t>::max() ) {
            error = "upgrade_work expansion generation cannot be retired";
            return false;
        }
    }
    const auto &blueprint_provides = upgrade.blueprint_provides();
    for( const auto &[provide_id, amount] : blueprint_provides ) {
        const auto provided = legacy_it->second.provides.find( provide_id );
        const int current = provided == legacy_it->second.provides.end() ? 0 : provided->second;
        if( amount < 0 || current > std::numeric_limits<int>::max() - amount ) {
            error = "upgrade_work provides metadata would overflow";
            return false;
        }
    }

    // All allocating and fallible preparation is completed on detached copies
    // before the mapgen transaction begins.  The post-mapgen path consists
    // only of swaps and scalar assignments.
    std::vector<npc_ptr> staged_assigned;
    std::vector<basecamp_platform_task> staged_tasks;
    std::map<point_rel_omt, expansion_data> staged_expansions;
    std::map<std::uint64_t, basecamp_platform_expansion> staged_platform_expansions;
    std::vector<basecamp_resource> staged_resources;
    std::set<itype_id> staged_fuel_types;
    std::uint64_t staged_core_upgrade_generation = platform_core_upgrade_generation_;
    if( work.target_kind == basecamp_platform_upgrade_target_kind::camp_core ) {
        ++staged_core_upgrade_generation;
    }
    try {
        staged_assigned = assigned_npcs;
        staged_tasks = platform_tasks;
        staged_expansions = expansions;
        staged_platform_expansions = platform_expansions_;
        staged_resources = resources;
        staged_fuel_types = fuel_types;
        staged_resources.reserve( resources.size() + upgrade.blueprint_resources().size() );
        for( const itype_id &resource_id : upgrade.blueprint_resources() ) {
            basecamp_resource resource;
            resource.fake_id = resource_id;
            const item resource_item( resource.fake_id, calendar::turn_zero );
            resource.ammo_id = resource_item.ammo_default();
            staged_resources.push_back( resource );
            staged_fuel_types.insert( resource.ammo_id );
        }
    } catch( const std::exception &exception ) {
        error = std::string( "upgrade_work could not stage completion metadata: " ) +
                exception.what();
        return false;
    }

    auto staged_task_it = std::find_if( staged_tasks.begin(), staged_tasks.end(),
    [task_id]( const basecamp_platform_task & candidate ) {
        return candidate.task_id == task_id;
    } );
    if( staged_task_it == staged_tasks.end() ) {
        error = "upgrade_work task disappeared during completion staging";
        return false;
    }
    auto staged_legacy_it = staged_expansions.find( direction );
    if( staged_legacy_it == staged_expansions.end() ) {
        error = "upgrade_work target disappeared during completion staging";
        return false;
    }
    expansion_data staged_target = staged_legacy_it->second;
    for( const auto &[provide_id, amount] : blueprint_provides ) {
        staged_target.provides[provide_id] += amount;
        const auto in_progress = staged_target.in_progress.find( provide_id );
        if( in_progress != staged_target.in_progress.end() ) {
            if( in_progress->second <= amount ) {
                staged_target.in_progress.erase( in_progress );
            } else {
                in_progress->second -= amount;
            }
        }
    }
    staged_legacy_it->second = staged_target;
    if( work.target_kind == basecamp_platform_upgrade_target_kind::expansion ) {
        auto staged_expansion_it = staged_platform_expansions.find( work.target_expansion_id );
        if( staged_expansion_it == staged_platform_expansions.end() ) {
            error = "upgrade_work target expansion disappeared during completion staging";
            return false;
        }
        ++staged_expansion_it->second.identity_generation;
        staged_expansion_it->second.work_in_progress = false;
    }

    auto staged_task_context = basecamp_platform_task_execution_context{};
    staged_task_context.camp = this;
    staged_task_context.task = &*staged_task_it;
    staged_task_context.worker = worker;
    staged_task_context.staged_tasks = &staged_tasks;
    staged_task_context.staged_assigned = &staged_assigned;
    staged_task_context.recipe_original_escrow = &original_escrow;
    staged_task_context.recipe_escrow = &remaining_escrow;
    staged_task_context.upgrade_completion = true;
    staged_task_context.upgrade_prepare_only = true;
    staged_task_context.now = now;
    staged_task_context.complete = true;
    if( !dispatch_basecamp_platform_task(
            staged_task_it->kind, basecamp_platform_task_operation::preflight,
            staged_task_context, error ) ) {
        return false;
    }

    // The registry-owned terminal transition is applied to the detached task
    // before mapgen.  Its marker/state/worker edits are therefore discarded
    // together with the staged copies if the transactional map update fails;
    // nothing fallible remains in the task commit after mapgen succeeds.
    staged_task_context.upgrade_prepare_only = false;
    staged_task_context.upgrade_commit_ready = true;
    if( !dispatch_basecamp_platform_task(
            staged_task_it->kind, basecamp_platform_task_operation::complete,
            staged_task_context, error ) ) {
        return false;
    }

    const std::optional<oter_id> expected_terrain = oter_id( work.target_terrain );
    const std::optional<oter_id> terrain_publication =
        oter_str_id( work.upgrade_id ).is_valid() ?
        std::optional<oter_id>( oter_id( work.upgrade_id ) ) : std::nullopt;
    const ret_val<void> mapgen_result = run_mapgen_update_func_transactional(
                                            upgrade.get_blueprint(), work.target_position,
                                            work.mapgen_args, nullptr, true,
                                            mirror_horizontal, mirror_vertical, rotation,
                                            expected_terrain, terrain_publication );
    if( !mapgen_result.success() ) {
        error = "upgrade_work mapgen update failed: " + mapgen_result.str();
        return false;
    }

    resources.swap( staged_resources );
    fuel_types.swap( staged_fuel_types );
    platform_core_upgrade_generation_ = staged_core_upgrade_generation;
    expansions.swap( staged_expansions );
    platform_expansions_.swap( staged_platform_expansions );
    assigned_npcs.swap( staged_assigned );
    platform_tasks.swap( staged_tasks );
    error.clear();
    return true;
}

bool basecamp::platform_mark_recipe_refund_pending(
    const std::uint64_t task_id, const std::uint64_t task_generation,
    std::string &error )
{
    auto task_it = std::find_if( platform_tasks.begin(), platform_tasks.end(),
    [task_id]( const basecamp_platform_task & candidate ) {
        return candidate.task_id == task_id;
    } );
    if( task_it == platform_tasks.end() ) {
        error = "task was not found";
        return false;
    }
    if( task_it->identity_generation != task_generation ||
        ( task_it->kind != basecamp_platform_recipe_work_kind &&
          task_it->kind != basecamp_platform_upgrade_work_kind ) ||
        task_it->state != basecamp_platform_task_state::running ||
        task_it->recipe_escrow.empty() ) {
        error = "Item escrow refund state cannot be retained for this task";
        return false;
    }
    if( task_it->identity_generation == std::numeric_limits<std::uint64_t>::max() ) {
        error = "Item escrow task generation cannot be retired";
        return false;
    }
    std::vector<npc_ptr> staged_assigned = assigned_npcs;
    for( auto assigned = staged_assigned.begin(); assigned != staged_assigned.end(); ) {
        if( *assigned && ( *assigned )->getID() == task_it->worker &&
            ( *assigned )->platform_identity_generation() ==
            task_it->worker_identity_generation ) {
            if( ( *assigned )->assigned_camp &&
                *( *assigned )->assigned_camp == omt_pos ) {
                ( *assigned )->assigned_camp.reset();
            }
            assigned = staged_assigned.erase( assigned );
        } else {
            ++assigned;
        }
    }
    assigned_npcs.swap( staged_assigned );
    ++task_it->identity_generation;
    task_it->recipe_commit_marker = 0;
    task_it->upgrade_commit_marker = 0;
    task_it->upgrade_applying_marker = 0;
    task_it->state = basecamp_platform_task_state::refund_pending;
    task_it->finished_at.reset();
    error.clear();
    return true;
}

void basecamp::platform_release_worker_reservation( npc &worker )
{
    const character_id worker_id = worker.getID();
    const std::uint64_t worker_generation = worker.platform_identity_generation();
    bool has_running_task = false;
    for( basecamp_platform_task &task : platform_tasks ) {
        if( !platform_task_is_active( task ) || task.worker != worker_id ||
            task.worker_identity_generation != worker_generation ) {
            continue;
        }
        task.awaiting_reconciliation = true;
        has_running_task = has_running_task ||
                           task.state == basecamp_platform_task_state::running;
    }
    if( !has_running_task ) {
        return;
    }

    std::vector<npc_ptr> staged;
    staged.reserve( assigned_npcs.size() );
    for( const npc_ptr &candidate : assigned_npcs ) {
        if( candidate && candidate.get() == &worker &&
            candidate->getID() == worker_id &&
            candidate->platform_identity_generation() == worker_generation ) {
            continue;
        }
        staged.push_back( candidate );
    }
    if( worker.assigned_camp && *worker.assigned_camp == omt_pos ) {
        worker.assigned_camp.reset();
    }
    assigned_npcs.swap( staged );
}

void basecamp::platform_retire_tasks_for_worker( npc &worker )
{
    const character_id worker_id = worker.getID();
    const std::uint64_t worker_generation = worker.platform_identity_generation();
    bool released_reservation = false;
    bool retired_task = false;
    const time_point now = calendar::turn;

    std::vector<basecamp_resource> staged_resources = resources;
    std::int64_t food_refund_kcal = 0;
    bool can_refund = true;
    std::string refund_error;
    for( basecamp_platform_task &task : platform_tasks ) {
        if( !platform_task_is_active( task ) || task.worker != worker_id ||
            task.worker_identity_generation != worker_generation ) {
            continue;
        }
        released_reservation = released_reservation ||
                               task.state == basecamp_platform_task_state::running;
        retired_task = true;
        if( ( task.kind == basecamp_platform_recipe_work_kind ||
              task.kind == basecamp_platform_upgrade_work_kind ) &&
            !task.recipe_escrow.empty() ) {
            // Death/replacement has no safe destination holder.  Release only
            // the live worker reservation and retain every owned item for an
            // explicit later refund; do not turn the escrow into a discarded
            // terminal record.
            if( task.identity_generation < std::numeric_limits<std::uint64_t>::max() ) {
                ++task.identity_generation;
            }
            task.recipe_commit_marker = 0;
            task.upgrade_commit_marker = 0;
            task.upgrade_applying_marker = 0;
            task.state = basecamp_platform_task_state::refund_pending;
            task.finished_at.reset();
            task.awaiting_reconciliation = false;
            continue;
        }
        if( can_refund && !stage_platform_task_refund(
                *this, task, staged_resources, food_refund_kcal, refund_error ) ) {
            can_refund = false;
        }
    }
    if( can_refund && food_refund_kcal != 0 ) {
        faction *owner_faction = platform_task_owner( *this, refund_error );
        if( owner_faction == nullptr ||
            !validate_platform_food_delta( *owner_faction, food_refund_kcal,
                                           refund_error ) ) {
            can_refund = false;
        }
    }
    if( can_refund && food_refund_kcal != 0 ) {
        faction *owner_faction = platform_task_owner( *this, refund_error );
        if( owner_faction == nullptr ||
            !apply_platform_food_delta( *owner_faction, food_refund_kcal, refund_error ) ) {
            can_refund = false;
        }
    }
    if( can_refund ) {
        resources.swap( staged_resources );
    }

    for( basecamp_platform_task &task : platform_tasks ) {
        if( !platform_task_is_active( task ) || task.worker != worker_id ||
            task.worker_identity_generation != worker_generation ) {
            continue;
        }
        if( task.kind == basecamp_platform_resource_work_kind &&
            task.state == basecamp_platform_task_state::running ) {
            task.reservation_discarded = !can_refund;
        }
        task.reserved_resources.clear();
        task.reserved_food_kcal = 0;
        retire_platform_task_record( task, now );
        task.awaiting_reconciliation = false;
    }
    if( !retired_task || !released_reservation ) {
        return;
    }

    if( worker.assigned_camp && *worker.assigned_camp == omt_pos ) {
        worker.assigned_camp.reset();
    }
    std::vector<npc_ptr> staged;
    staged.reserve( assigned_npcs.size() );
    for( const npc_ptr &candidate : assigned_npcs ) {
        if( candidate && candidate->getID() == worker_id &&
            candidate->platform_identity_generation() == worker_generation ) {
            if( candidate->assigned_camp && *candidate->assigned_camp == omt_pos ) {
                candidate->assigned_camp.reset();
            }
            continue;
        }
        staged.push_back( candidate );
    }
    assigned_npcs.swap( staged );
}

bool basecamp::platform_retire_tasks_for_camp( const bool owner_change )
{
    const auto has_item_escrow = []( const basecamp_platform_task & task ) {
        return ( task.kind == basecamp_platform_recipe_work_kind ||
                 task.kind == basecamp_platform_upgrade_work_kind ) &&
               !task.recipe_escrow.empty();
    };
    const auto is_item_escrow_state = []( const basecamp_platform_task & task ) {
        return task.state == basecamp_platform_task_state::pending ||
               task.state == basecamp_platform_task_state::running ||
               task.state == basecamp_platform_task_state::completed_unclaimed;
    };

    // A camp-removal boundary has no explicit holder context with which to
    // prove a safe refund.  Owner takeover is different: it preserves the
    // item escrow as refund_pending and publishes the new owner only after
    // all live reservations have been released.
    for( const basecamp_platform_task &task : platform_tasks ) {
        if( !owner_change && has_item_escrow( task ) ) {
            return false;
        }
        if( owner_change && has_item_escrow( task ) && is_item_escrow_state( task ) &&
            task.identity_generation == std::numeric_limits<std::uint64_t>::max() ) {
            return false;
        }
    }
    const time_point now = calendar::turn;
    std::vector<std::pair<character_id, std::uint64_t>> released_workers;
    std::vector<basecamp_resource> staged_resources = resources;
    std::int64_t food_refund_kcal = 0;
    bool can_refund = true;
    std::string refund_error;
    for( basecamp_platform_task &task : platform_tasks ) {
        if( owner_change && has_item_escrow( task ) && is_item_escrow_state( task ) ) {
            if( task.state == basecamp_platform_task_state::running ) {
                released_workers.emplace_back( task.worker, task.worker_identity_generation );
            }
            ++task.identity_generation;
            task.recipe_commit_marker = 0;
            task.upgrade_commit_marker = 0;
            task.upgrade_applying_marker = 0;
            task.state = basecamp_platform_task_state::refund_pending;
            task.finished_at.reset();
            task.awaiting_reconciliation = false;
            continue;
        }
        if( !platform_task_is_active( task ) ) {
            continue;
        }
        if( task.state == basecamp_platform_task_state::running ) {
            released_workers.emplace_back( task.worker, task.worker_identity_generation );
        }
        if( can_refund && !stage_platform_task_refund(
                *this, task, staged_resources, food_refund_kcal, refund_error ) ) {
            can_refund = false;
        }
    }
    if( can_refund && food_refund_kcal != 0 ) {
        faction *owner_faction = platform_task_owner( *this, refund_error );
        if( owner_faction == nullptr ||
            !validate_platform_food_delta( *owner_faction, food_refund_kcal,
                                           refund_error ) ) {
            can_refund = false;
        }
    }
    if( can_refund && food_refund_kcal != 0 ) {
        faction *owner_faction = platform_task_owner( *this, refund_error );
        if( owner_faction == nullptr ||
            !apply_platform_food_delta( *owner_faction, food_refund_kcal, refund_error ) ) {
            can_refund = false;
        }
    }
    if( can_refund ) {
        resources.swap( staged_resources );
    }

    for( basecamp_platform_task &task : platform_tasks ) {
        if( !platform_task_is_active( task ) ) {
            continue;
        }
        if( task.kind == basecamp_platform_resource_work_kind &&
            task.state == basecamp_platform_task_state::running ) {
            task.reservation_discarded = !can_refund;
        }
        task.reserved_resources.clear();
        task.reserved_food_kcal = 0;
        task.upgrade_commit_marker = 0;
        task.upgrade_applying_marker = 0;
        retire_platform_task_record( task, now );
        task.awaiting_reconciliation = false;
    }
    if( released_workers.empty() ) {
        return true;
    }

    std::vector<npc_ptr> staged;
    staged.reserve( assigned_npcs.size() );
    for( const npc_ptr &candidate : assigned_npcs ) {
        const bool is_platform_reservation = candidate &&
                                             std::any_of( released_workers.begin(),
                                                     released_workers.end(),
        [&candidate]( const std::pair<character_id, std::uint64_t> &identity ) {
            return candidate->getID() == identity.first &&
                   candidate->platform_identity_generation() == identity.second;
        } );
        if( is_platform_reservation ) {
            if( candidate->assigned_camp && *candidate->assigned_camp == omt_pos ) {
                candidate->assigned_camp.reset();
            }
            continue;
        }
        staged.push_back( candidate );
    }
    assigned_npcs.swap( staged );
    return true;
}

bool basecamp::platform_reconcile_task_reservations(
    const basecamp_platform_actor_lookup &lookup, std::string &error )
{
    bool all_valid = true;
    const time_point now = calendar::turn;
    std::vector<character_id> active_worker_ids;
    std::vector<std::pair<character_id, std::uint64_t>> released_workers;
    std::vector<npc_ptr> workers_to_bind;
    std::vector<basecamp_platform_task> staged_tasks = platform_tasks;
    std::vector<npc_ptr> staged_assigned = assigned_npcs;
    std::vector<basecamp_resource> staged_resources = resources;
    std::int64_t food_refund_kcal = 0;
    bool can_refund_invalid = true;
    std::unordered_set<std::uint64_t> retired_resource_tasks;

    const auto lookup_actor = [&lookup]( const character_id id ) {
        if( lookup ) {
            return lookup( id );
        }
        return basecamp_platform_actor_lookup_result{};
    };

    auto retire_invalid = [&]( basecamp_platform_task & task, const std::string & reason ) {
        all_valid = false;
        error = "CampTask " + std::to_string( task.task_id ) + " archived: " + reason;
        if( task.state == basecamp_platform_task_state::running ) {
            released_workers.emplace_back( task.worker, task.worker_identity_generation );
        }
        if( task.kind == basecamp_platform_resource_work_kind &&
            ( task.state == basecamp_platform_task_state::running ||
              !task.reserved_resources.empty() || task.reserved_food_kcal != 0 ) ) {
            retired_resource_tasks.insert( task.task_id );
            if( task.state == basecamp_platform_task_state::running ) {
                if( can_refund_invalid && !stage_platform_task_refund(
                        *this, task, staged_resources, food_refund_kcal, error ) ) {
                    can_refund_invalid = false;
                }
            }
        }
        retire_platform_task_record( task, now );
        task.awaiting_reconciliation = false;
    };

    std::sort( staged_tasks.begin(), staged_tasks.end(),
    []( const basecamp_platform_task & lhs, const basecamp_platform_task & rhs ) {
        return lhs.task_id < rhs.task_id;
    } );

    for( basecamp_platform_task &task : staged_tasks ) {
        if( !platform_task_is_active( task ) ) {
            continue;
        }
        const bool rebind_actor_generations = task.awaiting_reconciliation;
        basecamp_platform_task_execution_context executor_context;
        executor_context.camp = this;
        executor_context.task = &task;
        if( !dispatch_basecamp_platform_task(
                task.kind, basecamp_platform_task_operation::resolve,
                executor_context, error ) ) {
            retire_invalid( task, error );
            continue;
        }
        if( task.camp_id != platform_id_ || task.owner_faction != owner ) {
            retire_invalid( task, "camp or owner identity no longer matches" );
            continue;
        }
        Character *manager = nullptr;
        npc_ptr manager_npc;
        if( g != nullptr && get_avatar().getID() == task.manager ) {
            manager = &get_avatar();
        } else {
            const basecamp_platform_actor_lookup_result manager_lookup =
                lookup_actor( task.manager );
            if( manager_lookup.status ==
                basecamp_platform_actor_lookup_status::ambiguous ) {
                retire_invalid( task, "manager stable id has conflicting live instances" );
                continue;
            }
            if( manager_lookup.status ==
                basecamp_platform_actor_lookup_status::authoritative_not_found ) {
                retire_invalid( task, "manager stable id is absent after authoritative world load" );
                continue;
            }
            if( manager_lookup.status == basecamp_platform_actor_lookup_status::unknown ) {
                task.awaiting_reconciliation = true;
                continue;
            }
            manager_npc = manager_lookup.actor;
            if( !manager_npc ) {
                retire_invalid( task, "manager lookup returned no live actor" );
                continue;
            }
            manager = manager_npc.get();
        }
        if( manager == nullptr ) {
            task.awaiting_reconciliation = true;
            continue;
        }
        if( !manager->is_avatar() && manager->as_npc() == nullptr ) {
            retire_invalid( task, "manager has an unsupported Character subtype" );
            continue;
        }
        if( owner.is_null() || g == nullptr ||
            g->faction_manager_ptr->get( owner, false ) == nullptr ) {
            task.awaiting_reconciliation = true;
            continue;
        }
        if( manager->get_faction() == nullptr || !allowed_access_by( *manager ) ) {
            retire_invalid( task, "manager identity or authorization is not live" );
            continue;
        }
        const npc *manager_as_npc = manager->as_npc();
        const std::uint64_t manager_generation = manager_as_npc == nullptr ? 0 :
                manager_as_npc->platform_identity_generation();
        if( manager_generation != task.manager_identity_generation ) {
            if( rebind_actor_generations ) {
                task.manager_identity_generation = manager_generation;
            } else {
                retire_invalid( task, "manager identity generation is stale" );
                continue;
            }
        }

        const basecamp_platform_actor_lookup_result worker_lookup = lookup_actor( task.worker );
        if( worker_lookup.status == basecamp_platform_actor_lookup_status::ambiguous ) {
            retire_invalid( task, "worker stable id has conflicting live instances" );
            continue;
        }
        if( worker_lookup.status ==
            basecamp_platform_actor_lookup_status::authoritative_not_found ) {
            retire_invalid( task, "worker stable id is absent after authoritative world load" );
            continue;
        }
        if( worker_lookup.status == basecamp_platform_actor_lookup_status::unknown ) {
            task.awaiting_reconciliation = true;
            continue;
        }
        npc_ptr worker = worker_lookup.actor;
        if( !worker ) {
            retire_invalid( task, "worker lookup returned no live actor" );
            continue;
        }
        if( !worker || worker->is_dead() || worker->get_faction() == nullptr ||
            worker->get_faction()->id != owner ) {
            retire_invalid( task, "worker identity, life, or owner is not live" );
            continue;
        }
        if( worker->platform_identity_generation() != task.worker_identity_generation ) {
            if( rebind_actor_generations ) {
                task.worker_identity_generation = worker->platform_identity_generation();
            } else {
                retire_invalid( task, "worker identity generation is stale" );
                continue;
            }
        }
        if( std::find( active_worker_ids.begin(), active_worker_ids.end(), task.worker ) !=
            active_worker_ids.end() ) {
            retire_invalid( task, "worker has duplicate active Platform task records" );
            continue;
        }
        active_worker_ids.push_back( task.worker );
        const std::pair<character_id, std::uint64_t> worker_identity =
        { task.worker, task.worker_identity_generation };

        auto assigned_by_identity = std::find_if( staged_assigned.begin(), staged_assigned.end(),
        [&worker_identity]( const npc_ptr & candidate ) {
            return candidate && candidate->getID() == worker_identity.first &&
                   candidate->platform_identity_generation() == worker_identity.second;
        } );
        if( task.state == basecamp_platform_task_state::pending ) {
            if( worker->assigned_camp || assigned_by_identity != staged_assigned.end() ) {
                retire_invalid( task, "pending task has an unexpected worker reservation" );
            }
            task.awaiting_reconciliation = false;
            continue;
        }
        if( worker->assigned_camp && *worker->assigned_camp != omt_pos ) {
            retire_invalid( task, "worker is reserved by a different camp" );
            continue;
        }
        if( assigned_by_identity != staged_assigned.end() &&
            assigned_by_identity->get() != worker.get() ) {
            retire_invalid( task, "worker reservation points at a replaced NPC instance" );
            continue;
        }
        workers_to_bind.push_back( worker );
        if( assigned_by_identity == staged_assigned.end() ) {
            staged_assigned.push_back( worker );
        }
        task.awaiting_reconciliation = false;
    }

    for( const std::pair<character_id, std::uint64_t> &identity : released_workers ) {
        const bool rebound = std::any_of( workers_to_bind.begin(), workers_to_bind.end(),
        [&identity]( const npc_ptr & candidate ) {
            return candidate && candidate->getID() == identity.first &&
                   candidate->platform_identity_generation() == identity.second;
        } );
        if( rebound ) {
            continue;
        }
        for( auto it = staged_assigned.begin(); it != staged_assigned.end(); ) {
            if( *it && ( *it )->getID() == identity.first &&
                ( *it )->platform_identity_generation() == identity.second ) {
                if( ( *it )->assigned_camp && *( *it )->assigned_camp == omt_pos ) {
                    ( *it )->assigned_camp.reset();
                }
                it = staged_assigned.erase( it );
            } else {
                ++it;
            }
        }
    }

    for( const npc_ptr &worker : workers_to_bind ) {
        if( worker && !worker->assigned_camp ) {
            worker->assigned_camp = omt_pos;
        }
    }
    if( can_refund_invalid && food_refund_kcal != 0 ) {
        faction *owner_faction = platform_task_owner( *this, error );
        if( owner_faction == nullptr ||
            !apply_platform_food_delta( *owner_faction, food_refund_kcal, error ) ) {
            can_refund_invalid = false;
        }
    }
    if( can_refund_invalid ) {
        resources.swap( staged_resources );
    }
    for( basecamp_platform_task &task : staged_tasks ) {
        if( retired_resource_tasks.count( task.task_id ) == 0 ) {
            continue;
        }
        task.reserved_resources.clear();
        task.reserved_food_kcal = 0;
        task.reservation_discarded = !can_refund_invalid;
    }
    assigned_npcs.swap( staged_assigned );
    platform_tasks.swap( staged_tasks );
    if( all_valid ) {
        error.clear();
    }
    return all_valid;
}

void basecamp::form_storage_zones( map &here, const tripoint_abs_ms &abspos )
{
    zone_manager &mgr = zone_manager::get_manager();
    if( here.check_vehicle_zones( here.get_abs_sub().z() ) ) {
        mgr.cache_vzones();
    }
    // NPC camps may never have had bb_pos registered
    validate_bb_pos( project_to<coords::ms>( omt_pos ) );
    tripoint_bub_ms src_loc = here.get_bub( bb_pos ) + point::north;
    std::vector<tripoint_abs_ms> possible_liquid_dumps;
    if( mgr.has_near( zone_type_CAMP_STORAGE, abspos, MAX_VIEW_DISTANCE ) ) {
        const std::vector<const zone_data *> zones = mgr.get_near_zones( zone_type_CAMP_STORAGE, abspos,
                MAX_VIEW_DISTANCE, get_owner() );
        // Find the nearest unsorted zone to dump objects at
        if( !zones.empty() ) {
            std::unordered_set<tripoint_abs_ms> src_set;
            for( const zone_data *zone : zones ) {
                for( const tripoint_abs_ms &p : tripoint_range<tripoint_abs_ms>(
                         zone->get_start_point(), zone->get_end_point() ) ) {
                    src_set.emplace( p );
                }
            }
            set_storage_tiles( src_set );
            src_loc = here.get_bub( zones.front()->get_center_point() );
        }
        map &here = get_map();
        for( const zone_data *zone : zones ) {
            if( zone->get_type() == zone_type_CAMP_STORAGE ) {
                for( const tripoint_abs_ms &p : tripoint_range<tripoint_abs_ms>(
                         zone->get_start_point(), zone->get_end_point() ) ) {
                    if( here.has_flag_ter_or_furn( ter_furn_flag::TFLAG_LIQUIDCONT, here.get_bub( p ) ) ) {
                        possible_liquid_dumps.emplace_back( p );
                    }
                }
            }
        }
    }
    set_dumping_spot( here.get_abs( src_loc ) );
    set_liquid_dumping_spot( possible_liquid_dumps );

}
void basecamp::form_crafting_inventory( map &target_map )
{
    _inv.clear();
    zone_manager &mgr = zone_manager::get_manager();
    map &here = get_map();
    if( here.check_vehicle_zones( here.get_abs_sub().z() ) ) {
        mgr.cache_vzones();
    }
    if( !src_set.empty() ) {
        _inv.form_from_zone( target_map, src_set, nullptr, false );
    }
    /*
     * something of a hack: add the resources we know the camp has
     * the hacky part is that we're adding resources based on the camp's flags, which were
     * generated based on upgrade missions, instead of having resources added when the
     * map changes
     */
    // make sure the array is empty
    fuels.clear();
    for( const itype_id &fuel_id : fuel_types ) {
        basecamp_fuel bcp_f;
        bcp_f.ammo_id = fuel_id;
        fuels.emplace_back( bcp_f );
    }

    // find available fuel

    for( const tripoint_abs_ms &abs_ms_pt : src_set ) {
        const tripoint_bub_ms &pt = target_map.get_bub( abs_ms_pt );
        if( target_map.accessible_items( pt ) ) {
            for( const item &i : target_map.i_at( pt ) ) {
                for( basecamp_fuel &bcp_f : fuels ) {
                    if( bcp_f.ammo_id == i.typeId() ) {
                        bcp_f.available += i.charges;
                        break;
                    }
                }
            }
        }

    }
    for( basecamp_resource &bcp_r : resources ) {
        bcp_r.consumed = 0;
        item camp_item( bcp_r.fake_id, calendar::turn_zero );
        camp_item.set_flag( json_flag_PSEUDO );
        if( !bcp_r.ammo_id.is_null() ) {
            for( basecamp_fuel &bcp_f : fuels ) {
                if( bcp_f.ammo_id == bcp_r.ammo_id ) {
                    if( bcp_f.available > 0 ) {
                        bcp_r.available = bcp_f.available;
                        camp_item = camp_item.ammo_set( bcp_f.ammo_id, bcp_f.available );
                    }
                    break;
                }
            }
        }
        _inv.add_item( camp_item );
    }

    //  We're potentially adding the same item multiple times if present in multiple expansions,
    //  but we're already that with the resources above. The resources are stored in expansions
    //  rather than in a common pool to allow them to apply only to their respective expansion
    //  in the future.
    for( auto &expansion : expansions ) {
        for( itype_id &it : expansion.second.available_pseudo_items ) {
            item camp_item = item( it );
            if( camp_item.is_magazine() ) {
                for( basecamp_fuel &bcp_f : fuels ) {
                    if( camp_item.can_reload_with( item( bcp_f.ammo_id ), false ) ) {
                        if( bcp_f.available > 0 ) {
                            camp_item = camp_item.ammo_set( bcp_f.ammo_id, bcp_f.available );
                        }
                        break;
                    }
                }
            }

            _inv.add_item( camp_item );
        }
    }
}

map &basecamp::get_camp_map()
{
    if( by_radio ) {
        if( !camp_map.map_ ) {
            camp_map.map_ = std::make_unique<map>();
            camp_map.map_->load( project_to<coords::sm>( omt_pos ) - point( 5, 5 ), false );
        }
        return *camp_map.map_;
    }
    return get_map();
}

void basecamp::unload_camp_map()
{
    if( camp_map.map_ ) {
        camp_map.map_.reset();
    }
}

bool basecamp::platform_transition_owner(
    faction_id new_owner, const std::function<void()> &before_publish )
{
    if( owner == new_owner ) {
        return true;
    }
    // Task/reservation/escrow preflight and transition are deliberately kept
    // separate from expansion identity retirement.  This is the one owner
    // boundary used by both ordinary assignment and takeover flows.
    if( !platform_retire_tasks_for_camp( true ) ) {
        return false;
    }
    platform_retire_expansion_identities();
    if( before_publish ) {
        before_publish();
    }
    owner = new_owner;
    for( basecamp_platform_task &task : platform_tasks ) {
        task.owner_faction = owner;
    }
    return true;
}

void basecamp::set_owner( faction_id new_owner )
{
    static_cast<void>( platform_transition_owner( new_owner, {} ) );
}

faction_id basecamp::get_owner()
{
    return owner;
}

void basecamp::handle_takeover_by( faction_id new_owner, bool violent_takeover )
{
    if( owner == new_owner ) {
        return;
    }
    nutrients captured_with_camp;
    bool captured_food = false;
    const bool transitioned = platform_transition_owner( new_owner, [&]() {
        get_event_bus().send<event_type::camp_taken_over>( get_owner(), new_owner, name,
                violent_takeover );
        assigned_npcs.clear();
        camp_workers.clear();
        add_msg_debug( debugmode::DF_CAMPS,
                       "Camp %s owned by %s is being taken over by %s!", name,
                       fac()->id.c_str(), new_owner->id.c_str() );
        if( !violent_takeover ) {
            return;
        }

        // Since it was violent, the old owner is going to be upset.
        if( new_owner == get_player_character().get_faction()->id ) {
            fac()->likes_u -= 100;
            fac()->trusts_u -= 100;
        }

        int num_of_owned_camps = 0;
        // Go over all camps in existence and count the ones belonging to current owner
        // TODO: Remove this when camps stop being stored on the player
        for( tripoint_abs_omt camp_loc : get_player_character().camps ) {
            std::optional<basecamp *> bcp = overmap_buffer.find_camp( camp_loc.xy() );
            if( !bcp ) {
                continue;
            }
            basecamp *checked_camp = *bcp;
            // Note: Will count current basecamp object as well
            if( checked_camp->get_owner() == get_owner() ) {
                add_msg_debug( debugmode::DF_CAMPS,
                               "Camp %s at %s is owned by %s, adding it to plunder calculations.",
                               checked_camp->camp_name(),
                               checked_camp->camp_omt_pos().to_string_writable(),
                               get_owner()->id.c_str() );
                num_of_owned_camps++;
            }
        }

        if( num_of_owned_camps < 1 ) {
            debugmsg( "Tried to take over a camp owned by %s, but they somehow own no camps!  Is the owner's faction id no longer valid?",
                      get_owner().c_str() );
            return;
        }

        // Keep all old-owner-dependent food operations before the orchestrator
        // publishes the new owner.
        captured_with_camp = fac()->food_supply() / num_of_owned_camps;
        nutrients taken_from_camp = -captured_with_camp;
        camp_food_supply( taken_from_camp );
        add_msg_debug( debugmode::DF_CAMPS,
                       "Food supplies of %s plundered by %d kilocalories!  Total food supply reduced to %d kilocalories after losing %.1f%% of their camps.",
                       fac()->id.c_str(), captured_with_camp.kcal(),
                       fac()->food_supply().kcal(),
                       1.0 / static_cast<double>( num_of_owned_camps ) * 100.0 );
        captured_food = true;
    } );
    if( !transitioned ) {
        return;
    }
    if( !violent_takeover || !captured_food ) {
        return;
    }
    const int previous_days_of_food = camp_food_supply_days( MODERATE_EXERCISE );
    // Kcal captured from the old owner is added to the new owner after the
    // single publish point above.
    std::map<time_point, nutrients> added;
    added[calendar::turn_zero] = captured_with_camp;
    fac()->add_to_food_supply( added );
    add_msg_debug( debugmode::DF_CAMPS,
                   "Food supply of new owner %s has increased to %d kilocalories due to takeover of camp %s!",
                   fac()->id.c_str(), new_owner->food_supply().kcal(), name );
    if( new_owner == get_player_character().get_faction()->id ) {
        popup( _( "Through your looting of %s you found %d days worth of food and other resources." ),
               name, camp_food_supply_days( MODERATE_EXERCISE ) - previous_days_of_food );
    }
}

void basecamp::form_crafting_inventory()
{
    map &here = get_camp_map();
    form_crafting_inventory( here );
    here.save();
}

// display names
std::string basecamp::expansion_tab( const point_rel_omt &dir ) const
{
    if( dir == base_camps::base_dir ) {
        return _( "Base Missions" );
    }
    const auto &expansion_types = recipe_group::get_recipes_by_id( "all_faction_base_expansions" );

    const auto &e = expansions.find( dir );
    if( e != expansions.end() ) {
        recipe_id id( base_camps::faction_encode_abs( e->second, 0 ) );
        const auto e_type = expansion_types.find( id );
        if( e_type != expansion_types.end() ) {
            //~ A particular faction camp / basecamp expansion
            return string_format( _( "%s Expansion" ), e_type->second );
        }
    }
    return _( "Empty Expansion" );
}

bool basecamp::point_within_camp( const tripoint_abs_omt &p ) const
{
    return std::any_of( expansions.begin(), expansions.end(), [ p ]( auto & e ) {
        return p == e.second.pos;
    } );
}

// legacy load and save
void basecamp::load_data( const std::string &data )
{
    std::stringstream stream( data );
    stream >> name >> bb_pos.x() >> bb_pos.y();
    // add space to name
    replace( name.begin(), name.end(), '_', ' ' );
}

basecamp_action_components::basecamp_action_components(
    const recipe &making, const mapgen_arguments &args, int batch_size, basecamp &base ) :
    making_( making ),
    args_( args ),
    batch_size_( batch_size ),
    base_( base )
{
}

bool basecamp_action_components::choose_components()
{
    // Basecamp crafting selects and consumes tools whole-recipe; the per-step
    // tool model is not wired through this path, so step recipes are excluded
    // here rather than risk mis-metering their tools.
    if( making_.has_steps() ) {
        debugmsg( "step recipe %s cannot be crafted at a basecamp yet", making_.ident().str() );
        return false;
    }
    const auto filter = is_crafting_component;
    avatar &player_character = get_avatar();
    const requirement_data *req;
    if( making_.is_blueprint() ) {
        const std::unordered_map<mapgen_arguments, build_reqs> &reqs_map =
            making_.blueprint_build_reqs().reqs_by_parameters;
        auto req_it = reqs_map.find( args_ );
        if( req_it == reqs_map.end() ) {
            debugmsg( "invalid argument selection for recipe" );
            return false;
        }
        req = &req_it->second.consolidated_reqs;
    } else {
        req = making_.deduped_requirements().select_alternative(
                  player_character, base_._inv, filter, batch_size_ );
    }
    if( !req ) {
        return false;
    }
    if( !item_selections_.empty() || !tool_selections_.empty() ) {
        debugmsg( "Reused basecamp_action_components" );
        return false;
    }
    for( const auto &it : req->get_components() ) {
        comp_selection<item_comp> is =
            player_character.select_item_component( it, batch_size_, base_._inv, true, filter,
                    !base_.by_radio );
        if( is.use_from == usage_from::cancel ) {
            return false;
        }
        item_selections_.push_back( is );
    }
    // this may consume pseudo-resources from fake items
    for( const auto &it : req->get_tools() ) {
        comp_selection<tool_comp> ts =
            player_character.select_tool_component( it, batch_size_, base_._inv, true,
                    !base_.by_radio );
        if( ts.use_from == usage_from::cancel ) {
            return false;
        }
        tool_selections_.push_back( ts );
    }
    return true;
}

void basecamp_action_components::consume_components()
{
    map &target_map = base_.get_camp_map();
    avatar &player_character = get_avatar();
    std::vector<tripoint_bub_ms> src;
    src.reserve( base_.src_set.size() );
    for( const tripoint_abs_ms &p : base_.src_set ) {
        src.emplace_back( target_map.get_bub( p ) );
    }
    for( const comp_selection<item_comp> &sel : item_selections_ ) {
        std::list<item> consumed = player_character.consume_items( target_map, sel, batch_size_,
                                   is_crafting_component, src );
        for( item &comp : consumed ) {
            consumed_components_.add( comp );
        }
    }
    // this may consume pseudo-resources from fake items
    for( const comp_selection<tool_comp> &sel : tool_selections_ ) {
        player_character.consume_tools( target_map, sel, batch_size_, src, &base_ );
    }
    // go back and consume the actual resources
    for( basecamp_resource &bcp_r : base_.resources ) {
        if( bcp_r.consumed > 0 ) {
            target_map.use_charges( src, bcp_r.ammo_id, bcp_r.consumed );
        }
    }
    target_map.save();
}
