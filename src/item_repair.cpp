#include "item_repair.h"

#include <set>

#include "character.h"
#include "item.h"
#include "itype.h"
#include "iuse_actor.h"
#include "map.h"
#include "player_activity.h"
#include "type_id.h"

namespace item_repair
{
std::vector<tool_option> tools_for( Character &you, const item_location &target )
{
    std::vector<tool_option> result;
    if( !target || target->damage() <= target->degradation() ) {
        return result;
    }
    const std::set<itype_id> &supported = target->repaired_with();
    const std::vector<item_location> tools = you.nearby( [&supported, &target]( const item * it,
    const item * ) {
        return it != target.get_item() && supported.count( it->typeId() ) > 0;
    } );
    for( const item_location &tool : tools ) {
        // Furniture pseudo tools visited by nearby() do not persist as items.
        if( !tool ) {
            continue;
        }
        for( const auto &[method, use] : tool->type->use_methods ) {
            const repair_item_actor *actor = dynamic_cast<const repair_item_actor *>( use.get_actor_ptr() );
            if( actor && actor->can_repair_target( you, *target, false, false ) ) {
                const bool available = actor->can_use_tool( you, *tool, false ) &&
                                       actor->can_repair_target( you, *target, false, true );
                result.push_back( { tool, method, actor, available } );
            }
        }
    }
    return result;
}

bool start( Character &you, const item_location &target, const tool_option &option )
{
    if( !target || !option.tool || target.get_item() == option.tool.get_item() ) {
        return false;
    }
    const use_function *use = option.tool->get_use( option.method );
    const repair_item_actor *actor = use ? dynamic_cast<const repair_item_actor *>(
                                         use->get_actor_ptr() ) : nullptr;
    if( !actor || target->damage() <= target->degradation() ||
        !actor->can_repair_target( you, *target, true, true ) ) {
        return false;
    }
    map &here = get_map();
    item_location tool = option.tool;
    if( !actor->use( &you, *tool, &here, tool.pos_bub( here ) ).has_value() ) {
        return false;
    }
    // Keep the selected locations and the normal repeat menu, timing and charge use.
    you.activity.targets[0] = option.tool;
    you.activity.targets.push_back( target );
    return true;
}
} // namespace item_repair
