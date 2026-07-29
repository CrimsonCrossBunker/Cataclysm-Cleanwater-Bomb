#include "craft_command.h"

#include <algorithm>
#include <climits>
#include <cstdint>
#include <cstdlib>
#include <functional>
#include <limits>
#include <list>
#include <string>
#include <utility>
#include <vector>

#include "activity_actor_definitions.h"
#include "character.h"
#include "crafting.h"
#include "crafting_enums.h"
#include "debug.h"
#include "enum_conversions.h"
#include "enum_traits.h"
#include "flag.h"
#include "flexbuffer_json.h"
#include "game_constants.h"
#include "inventory.h"
#include "item.h"
#include "item_components.h"
#include "item_contents.h"
#include "item_location.h"
#include "item_pocket.h"
#include "itype.h"
#include "json.h"
#include "line.h"
#include "map.h"
#include "map_iterator.h"
#include "output.h"
#include "pocket_type.h"
#include "recipe.h"
#include "requirements.h"
#include "translations.h"
#include "type_id.h"
#include "uistate.h"
#include "vehicle.h"
#include "visitable.h"
#include "vpart_position.h"
#include "weather.h"

static const itype_id itype_candle( "candle" );

static const trait_id trait_DEBUG_HS( "DEBUG_HS" );

namespace {

struct craft_material_source {
    item_location location;
    item snapshot;
    item_uid source_uid;
    int quantity = 0;
    bool by_charges = false;
};

struct craft_material_plan {
    std::vector<craft_material_source> sources;
    item_components preview_components;
};

std::vector<item_location> craft_source_locations( Character &crafter,
        const comp_selection<item_comp> &selection,
        const std::function<bool( const item & )> &filter, bool preferred )
{
    const itype_id type = selection.comp.type;
    const std::function<bool( const item & )> source_filter =
        [&filter, &type, preferred]( const item &candidate ) {
            return candidate.typeId() == type && filter( candidate ) &&
                   ( !preferred || is_preferred_component( candidate ) );
        };
    std::vector<item_location> locations;
    map &here = get_map();

    if( selection.use_from & usage_from::map ) {
        const std::vector<tripoint_bub_ms> reachable = here.reachable_item_points(
                    crafter.pos_bub(), PICKUP_RANGE, 1, 100 );
        for( const tripoint_bub_ms &point : reachable ) {
            std::list<item_location> at_point = here.items_with( point, source_filter );
            locations.insert( locations.end(), at_point.begin(), at_point.end() );
        }
    }
    if( selection.use_from & usage_from::player ) {
        for( item *candidate : crafter.items_with( source_filter ) ) {
            locations.emplace_back( crafter, candidate );
        }
    }
    return locations;
}

bool build_craft_material_plan( Character &crafter,
                                const std::vector<comp_selection<item_comp>> &selections,
                                int batch, const std::function<bool( const item & )> &filter,
                                craft_material_plan &plan )
{
    for( const comp_selection<item_comp> &selection : selections ) {
        const bool by_charges = item::count_by_charges( selection.comp.type ) &&
                                selection.comp.count > 0;
        int remaining = selection.comp.count > 0 ? selection.comp.count * batch :
                        std::abs( selection.comp.count );
        std::vector<item_location> candidates;
        for( int pass = 0; pass < 2 && remaining > 0; ++pass ) {
            const bool preferred = pass == 0;
            for( usage_from source : { usage_from::map, usage_from::player } ) {
                comp_selection<item_comp> source_selection = selection;
                source_selection.use_from = source;
                const std::vector<item_location> pass_candidates = craft_source_locations(
                            crafter, source_selection, filter, preferred );
                for( const item_location &candidate : pass_candidates ) {
                    if( std::find( candidates.begin(), candidates.end(), candidate ) == candidates.end() ) {
                        candidates.push_back( candidate );
                    }
                }
            }
        }

        for( item_location &location : candidates ) {
            if( remaining <= 0 ) {
                break;
            }
            if( !location ) {
                continue;
            }
            int already_planned = 0;
            for( const craft_material_source &planned : plan.sources ) {
                if( planned.location == location ) {
                    already_planned += planned.quantity;
                }
            }
            const int available = by_charges ? location->charges - already_planned :
                              ( already_planned == 0 ? 1 : 0 );
            const int quantity = by_charges ? std::min( remaining, available ) : 1;
            if( quantity <= 0 ) {
                continue;
            }
            item snapshot = *location;
            if( by_charges && quantity < snapshot.charges ) {
                snapshot.mod_charges( quantity - snapshot.charges );
            }
            plan.sources.push_back( { location, snapshot, location->uid(), quantity, by_charges } );
            remaining -= quantity;
        }
        if( remaining > 0 ) {
            return false;
        }
    }

    for( const comp_selection<item_comp> &selection : selections ) {
        item_comp used = selection.comp;
        used.count *= batch;
        auto found = std::find_if( plan.preview_components.begin(), plan.preview_components.end(),
        [&used]( const item_comp &existing ) {
            return existing.type == used.type;
        } );
        if( found == plan.preview_components.end() ) {
            plan.preview_components.push_back( used );
        } else {
            found->count += used.count;
        }
    }
    return true;
}

bool validate_craft_material_plan( const craft_material_plan &plan )
{
    for( const craft_material_source &source : plan.sources ) {
        if( !source.location || source.location->uid() != source.source_uid ||
            source.location->typeId() != source.snapshot.typeId() ) {
            return false;
        }
        if( source.by_charges && source.location->charges < source.quantity ) {
            return false;
        }
    }
    return true;
}

bool consume_craft_material_plan( Character &crafter, craft_material_plan &plan,
                                  item_components &used )
{
    if( !validate_craft_material_plan( plan ) ) {
        return false;
    }

    map &here = get_map();
    for( craft_material_source &source : plan.sources ) {
        item consumed = *source.location;
        if( source.by_charges ) {
            consumed.mod_charges( source.quantity - consumed.charges );
            source.location->mod_charges( -source.quantity );
            source.location.on_contents_changed();
        } else {
            source.location.remove_item();
            remove_ammo( consumed, crafter );
        }
        if( !consumed.contains_no_solids() ) {
            consumed.spill_contents( crafter );
        }
        consumed.overflow( here, crafter.pos_bub( here ) );
        if( !source.by_charges && craft_command::safe_to_unload_comp( consumed ) ) {
            item_location consumed_location( crafter, &consumed );
            unload_activity_actor::unload( crafter, consumed_location );
        }
        used.add( consumed );
    }
    return true;
}

} // namespace

template<typename CompType>
std::string comp_selection<CompType>::nname() const
{
    switch( use_from ) {
        case usage_from::map:
            return item::nname( comp.type, comp.count ) + _( " (nearby)" );
        case usage_from::both:
            return item::nname( comp.type, comp.count ) + _( " (person & nearby)" );
        case usage_from::player:
        // Is the same as the default return;
        case usage_from::none:
        case usage_from::cancel:
        case usage_from::num_usages_from:
            break;
    }

    return item::nname( comp.type, comp.count );
}

namespace io
{

template<>
std::string enum_to_string<usage_from>( usage_from data )
{
    switch( data ) {
        // *INDENT-OFF*
        case usage_from::map: return "map";
        case usage_from::player: return "player";
        case usage_from::both: return "both";
        case usage_from::none: return "none";
        case usage_from::cancel: return "cancel";
        // *INDENT-ON*
        case usage_from::num_usages_from:
            break;
    }
    cata_fatal( "Invalid usage" );
}

} // namespace io

template<typename CompType>
void comp_selection<CompType>::serialize( JsonOut &jsout ) const
{
    jsout.start_object();

    jsout.member( "use_from", io::enum_to_string( use_from ) );
    jsout.member( "type", comp.type );
    jsout.member( "count", comp.count );

    jsout.end_object();
}

template<typename CompType>
void comp_selection<CompType>::deserialize( const JsonObject &data )
{
    std::string use_from_str;
    data.read( "use_from", use_from_str );
    use_from = io::string_to_enum<usage_from>( use_from_str );
    data.read( "type", comp.type );
    data.read( "count", comp.count );
}

template void comp_selection<tool_comp>::serialize( JsonOut &jsout ) const;
template void comp_selection<item_comp>::serialize( JsonOut &jsout ) const;
template void comp_selection<tool_comp>::deserialize( const JsonObject &data );
template void comp_selection<item_comp>::deserialize( const JsonObject &data );

void step_tool_alloc::serialize( JsonOut &jsout ) const
{
    jsout.start_object();
    jsout.member( "sel", sel );
    jsout.member( "step_count_units", step_count_units );
    jsout.member( "consumed_buckets", consumed_buckets );
    jsout.member( "root_derived", root_derived );
    jsout.end_object();
}

void step_tool_alloc::deserialize( const JsonObject &data )
{
    data.read( "sel", sel );
    data.read( "step_count_units", step_count_units );
    data.read( "consumed_buckets", consumed_buckets );
    data.read( "root_derived", root_derived );
}

void craft_command::execute( const std::optional<tripoint_bub_ms> &new_loc )
{
    loc = new_loc;
    execute();
}

void craft_command::execute( bool only_cache_comps )
{
    if( empty() ) {
        return;
    }

    bool need_selections = true;
    inventory map_inv;
    map_inv.form_from_map( crafter->pos_bub(), PICKUP_RANGE, crafter );

    if( has_cached_selections() ) {
        std::vector<comp_selection<item_comp>> missing_items = check_item_components_missing( map_inv );
        std::vector<comp_selection<tool_comp>> missing_tools = check_tool_components_missing( map_inv );

        if( missing_items.empty() && missing_tools.empty() ) {
            // All items we used previously are still there, so we don't need to do selection.
            need_selections = false;
        } else if( !only_cache_comps && !query_continue( missing_items, missing_tools ) ) {
            return;
        }
    }

    if( need_selections ) {
        if( !crafter->can_make( rec, batch_size ) ) {
            if( crafter->can_start_craft( rec, recipe_filter_flags::none, batch_size ) ) {
                if( !query_yn( _( "You don't have enough charges to complete the %s.\n"
                                  "Start crafting anyway?" ), rec->result_name() ) ) {
                    return;
                }
            } else if( !rec->character_has_required_proficiencies( *crafter ) ) {
                popup( _( "You don't have the required proficiencies to craft this!" ) );
                return;
            } else {
                debugmsg( "Tried to start craft without sufficient charges" );
                return;
            }
        }

        flags = recipe_filter_flags::no_rotten;

        if( !crafter->can_start_craft( rec, flags, batch_size ) ) {
            if( !query_yn( _( "This craft will use rotten components.\n"
                              "Start crafting anyway?" ) ) ) {
                return;
            }
            flags = recipe_filter_flags::none;
        }

        flags |= recipe_filter_flags::no_favorite;
        if( !crafter->can_start_craft( rec, flags, batch_size ) ) {
            if( !query_yn( _( "This craft will use favorited components.\n"
                              "Start crafting anyway?" ) ) ) {
                return;
            }
            flags = flags & recipe_filter_flags::no_rotten ? recipe_filter_flags::no_rotten :
                    recipe_filter_flags::none;
        }

        item_selections.clear();
        const auto filter = rec->get_component_filter( flags );
        const requirement_data *needs = rec->deduped_requirements().select_alternative(
                                            *crafter, filter, batch_size, craft_flags::start_only );
        if( !needs ) {
            return;
        }

        for( const auto &it : needs->get_components() ) {
            comp_selection<item_comp> is =
                crafter->select_item_component( it, batch_size, map_inv, true, filter, true, true, rec );
            if( is.use_from == usage_from::cancel ) {
                return;
            }
            item_selections.push_back( is );
        }

        // Step recipes select their tools per step, so only stepless recipes
        // select from the flattened whole-recipe tool list here; doing both would
        // prompt for the same tools twice.
        tool_selections.clear();
        if( !rec->has_steps() ) {
            for( const auto &it : needs->get_tools() ) {
                comp_selection<tool_comp> ts = crafter->select_tool_component(
                it, batch_size, map_inv, true, true, true, []( int charges ) {
                    return charges / 20 + charges % 20;
                } );
                if( ts.use_from == usage_from::cancel ) {
                    return;
                }
                tool_selections.push_back( ts );
            }
        }
    }

    if( only_cache_comps ) {
        return;
    }

    // Only (re)select per-step tools when fresh selection is needed; a cached
    // repeat craft whose tools are all still present reuses the stored
    // allocations rather than reselecting and reprompting.
    if( need_selections && rec->has_steps() ) {
        bool cancelled = false;
        step_tool_allocs = select_step_tool_allocs( *crafter, *rec, batch_size, map_inv, cancelled );
        if( cancelled ) {
            return;
        }
    }

    std::vector<attention_plan> plans;
    if( rec->has_attention_steps() && crafter->is_avatar() ) {
        std::optional<std::vector<attention_plan>> chosen =
                show_craft_planning_modal( *rec, *crafter, batch_size, /*from_step=*/0, {} );
        if( !chosen ) {
            return;
        }
        plans = std::move( *chosen );
    }
    crafter->start_craft( *this, loc, std::move( plans ) );
    crafter->last_batch = batch_size;
    crafter->lastrecipe = rec->ident();

    const auto iter = std::find( uistate.recent_recipes.begin(), uistate.recent_recipes.end(),
                                 rec->ident() );
    if( iter != uistate.recent_recipes.end() ) {
        uistate.recent_recipes.erase( iter );
    }

    uistate.recent_recipes.push_back( rec->ident() );

    if( uistate.recent_recipes.size() > 20 ) {
        uistate.recent_recipes.erase( uistate.recent_recipes.begin() );
    }
}

/** Does a string join with ', ' of the components in the passed vector and inserts into 'str' */
template<typename T>
static std::string component_list_string( const std::vector<comp_selection<T>> &components )
{
    return enumerate_as_string( components.begin(), components.end(),
    []( const comp_selection<T> &comp ) {
        return comp.nname();
    } );
}

bool craft_command::query_continue( const std::vector<comp_selection<item_comp>> &missing_items,
                                    const std::vector<comp_selection<tool_comp>> &missing_tools )
{
    std::string ss = _( "Some components used previously are missing.  Continue?" );

    if( !missing_items.empty() ) {
        ss += "\n";
        ss += _( "Item(s): " );
        ss += component_list_string( missing_items );
    }

    if( !missing_tools.empty() ) {
        ss += "\n";
        ss += _( "Tool(s): " );
        ss += component_list_string( missing_tools );
    }

    return query_yn( ss );
}

bool craft_command::continue_prompt_liquids( const std::function<bool( const item & )> &filter,
        bool no_prompt )
{
    for( const auto &it : item_selections ) {
        const std::vector<pocket_data> it_pkt = it.comp.type->pockets;
        if( ( item::count_by_charges( it.comp.type ) && it.comp.count > 0 ) ||
        !std::any_of( it_pkt.begin(), it_pkt.end(), []( const pocket_data & p ) {
        return p.type == pocket_type::CONTAINER && p.watertight;
    } ) ) {
            continue;
        }

        int real_count = ( it.comp.count > 0 ) ? it.comp.count * batch_size : std::abs( it.comp.count );
        std::vector<item_location> candidates;
        for( bool preferred : { true, false } ) {
            for( usage_from source : { usage_from::map, usage_from::player } ) {
                comp_selection<item_comp> source_selection = it;
                source_selection.use_from = source;
                const std::vector<item_location> pass_candidates = craft_source_locations(
                            *crafter, source_selection, filter, preferred );
                for( const item_location &candidate : pass_candidates ) {
                    if( std::find( candidates.begin(), candidates.end(), candidate ) == candidates.end() ) {
                        candidates.push_back( candidate );
                    }
                }
            }
        }
        for( const item_location &candidate : candidates ) {
            if( real_count <= 0 ) {
                break;
            }
            --real_count;
            if( !candidate->empty_container() ) {
                if( no_prompt || !query_yn( _( "%s is not empty.  Continue anyway?" ),
                                             candidate->tname( 1U, true ) ) ) {
                    return false;
                }
            }
        }
    }
    return true;
}

bool craft_command::safe_to_unload_comp( const item &it )
{
    // Candle wax from candles should be consumed with the candle
    if( it.is_container_empty() || it.typeId() == itype_candle ) {
        return false;
    }

    // Return true if item contains anything "real"
    const std::function<bool( const item &i )> filter = []( const item & i ) {
        return !i.has_flag( flag_ZERO_WEIGHT ) && !i.has_flag( flag_NO_DROP );
    };
    const bool valid = it.get_contents().has_any_with( filter, pocket_type::CONTAINER ) ||
                       it.get_contents().has_any_with( filter, pocket_type::MAGAZINE ) ||
                       it.get_contents().has_any_with( filter, pocket_type::MAGAZINE_WELL );
    if( valid ) {
        return true;
    }

    // Don't try to unload items that shouldn't be outside their container
    itype_id ammo = it.loaded_ammo().typeId();
    if( ammo.is_null() ) {
        return !it.empty_container();
    } else if( ammo->has_flag( flag_ZERO_WEIGHT ) ||
               ammo->has_flag( flag_NO_DROP ) ) {
        return false;
    }

    return true;
}

static bool should_add_crafting_faults( Character *who, const recipe *rec )
{
    // Intentionally does not consider books helping.
    // Because ~~lazy implementation~~ book learning is no substitute for experience.
    if( rec->proficiency_skill_maluses( *who ) > 0.0f ) {
        return true;
    }
    return false;
}

std::vector<std::vector<step_tool_alloc>> select_step_tool_allocs(
        Character &crafter, const recipe &rec, int batch, read_only_visitable &map_inv,
        bool &cancelled, int reselect_step )
{
    cancelled = false;
    const std::vector<recipe_step> &steps = rec.steps();
    std::vector<std::vector<step_tool_alloc>> allocs( steps.size() );

    const auto start_charges = []( int charges ) {
        return charges / 20 + charges % 20;
    };

    // Replay a tool group's selection across groups with the same options and
    // counts, so a group shared between steps prompts the crafter only once.
    std::vector<std::pair<std::string, comp_selection<tool_comp>>> replay;
    const auto group_key = []( const std::vector<tool_comp> &group ) -> std::string {
        std::vector<std::string> parts;
        parts.reserve( group.size() );
        for( const tool_comp &tc : group )
        {
            parts.push_back( tc.type.str() + ":" + std::to_string( tc.count ) );
        }
        std::sort( parts.begin(), parts.end() );
        std::string key;
        for( const std::string &p : parts )
        {
            key += p;
            key += ',';
        }
        return key;
    };
    const auto select_group = [&]( const std::vector<tool_comp> &group ) -> comp_selection<tool_comp> {
        const std::string key = group_key( group );
        for( const std::pair<std::string, comp_selection<tool_comp>> &r : replay )
        {
            if( r.first == key ) {
                return r.second;
            }
        }
        comp_selection<tool_comp> ts = crafter.select_tool_component(
                                           group, batch, map_inv, true, true, true, start_charges );
        if( ts.use_from != usage_from::cancel )
        {
            replay.emplace_back( key, ts );
        }
        return ts;
    };

    for( size_t i = 0; i < steps.size(); ++i ) {
        // On resume only the current step's own tools are reselected; other
        // steps keep their prior selections (filled in by the caller).
        if( reselect_step >= 0 && static_cast<int>( i ) != reselect_step ) {
            continue;
        }
        for( const std::vector<tool_comp> &group : steps[i].requirements.get_tools() ) {
            comp_selection<tool_comp> ts = select_group( group );
            if( ts.use_from == usage_from::cancel ) {
                cancelled = true;
                return allocs;
            }
            step_tool_alloc alloc;
            alloc.sel = ts;
            alloc.step_count_units = std::max( 0, ts.comp.count ) * std::max( batch, 1 );
            allocs[i].push_back( alloc );
        }
    }

    // Recipe-root tools belong to the whole craft.  Distribute their charges
    // across all timed steps pro-rata by each step's move budget (so per-step
    // time, proficiency, and tool-speed modifiers are reflected); the last
    // weighted step takes the rounding remainder so the shares sum exactly.
    const std::vector<std::vector<tool_comp>> &root_groups = rec.root_requirements().get_tools();
    if( root_groups.empty() ) {
        return allocs;
    }
    const crafting_cost_context ctx = crafting_cost_context::for_recipe( crafter, rec );
    std::vector<int64_t> step_budget( steps.size(), 0 );
    int64_t total_budget = 0;
    int last_weighted = -1;
    for( size_t i = 0; i < steps.size(); ++i ) {
        step_budget[i] = std::max<int64_t>(
                             static_cast<int64_t>( rec.step_budget_moves( crafter, i, batch, ctx ) ), 0 );
        total_budget += step_budget[i];
        if( step_budget[i] > 0 ) {
            last_weighted = static_cast<int>( i );
        }
    }
    if( total_budget <= 0 ) {
        return allocs;
    }
    for( const std::vector<tool_comp> &group : root_groups ) {
        comp_selection<tool_comp> ts = select_group( group );
        if( ts.use_from == usage_from::cancel ) {
            cancelled = true;
            return allocs;
        }
        const int total_units = std::max( 0, ts.comp.count ) * std::max( batch, 1 );
        int assigned = 0;
        for( size_t i = 0; i < steps.size(); ++i ) {
            if( step_budget[i] <= 0 ) {
                continue;
            }
            const int share = static_cast<int>( i ) == last_weighted
                              ? total_units - assigned
                              : static_cast<int>( total_units * step_budget[i] / total_budget );
            assigned += share;
            step_tool_alloc alloc;
            alloc.sel = ts;
            alloc.step_count_units = share;
            alloc.root_derived = true;
            allocs[i].push_back( alloc );
        }
    }
    return allocs;
}

item craft_command::create_in_progress_craft()
{
    // Use up the components and tools
    item_components used;
    std::vector<item_comp> comps_used;
    if( crafter->has_trait( trait_DEBUG_HS ) ) {
        return item( rec, batch_size, used, comps_used, false );
    }

    if( empty() ) {
        debugmsg( "Warning: attempted to consume items from an empty craft_command" );
        return item();
    }

    inventory map_inv;
    map_inv.form_from_map( crafter->pos_bub(), PICKUP_RANGE, crafter );

    if( !check_item_components_missing( map_inv ).empty() ) {
        debugmsg( "Aborting crafting: couldn't find cached components" );
        return item();
    }

    const auto filter = rec->get_component_filter( flags );

    if( crafter->is_avatar() &&
        !continue_prompt_liquids( filter ) ) {
        // player cancelled when prompted to unload liquid
        return item();
    }

    // Build the per-step allocations the craft will carry.  A stepless recipe
    // collapses its whole-recipe tool selections into one implicit step.
    std::vector<std::vector<step_tool_alloc>> start_allocs;
    if( rec->has_steps() ) {
        start_allocs = step_tool_allocs;
    } else {
        std::vector<step_tool_alloc> step0;
        step0.reserve( tool_selections.size() );
        for( const comp_selection<tool_comp> &sel : tool_selections ) {
            step_tool_alloc alloc;
            alloc.sel = sel;
            alloc.step_count_units = std::max( 0, sel.comp.count ) * std::max( batch_size, 1 );
            step0.push_back( alloc );
        }
        start_allocs = { step0 };
    }

    craft_material_plan material_plan;
    if( !build_craft_material_plan( *crafter, item_selections, batch_size, filter,
                                     material_plan ) ) {
        debugmsg( "Aborting crafting: couldn't build a non-destructive material plan" );
        return item();
    }

    // Build the same temporary craft used by the real craft path from the planned
    // snapshots.  This warning must happen before either materials or tools are
    // consumed, so cancelling leaves every source unchanged.
    item_components preview_used;
    for( const craft_material_source &source : material_plan.sources ) {
        preview_used.add( source.snapshot );
    }
    item preview( rec, batch_size, preview_used, material_plan.preview_components, false );
    const time_duration expected_duration = time_duration::from_moves(
                crafter->expected_time_to_craft( *rec, batch_size ) );
    const double predicted_rot = preview.get_relative_rot_after(
                                     get_weather().get_temperature( crafter->pos_bub() ), 1.0f,
                                     expected_duration );
    if( preview.goes_bad() && crafter->is_avatar() ) {
        const time_duration predicted_remaining = preview.get_shelf_life() -
                preview.get_shelf_life() * predicted_rot;
        if( predicted_rot >= 1.0 || predicted_remaining <= 3_hours ) {
            const char *warning = predicted_rot >= 1.0
                                  ? _( "The selected ingredients may be rotten before this craft finishes.\n"
                                       "Start crafting anyway?" )
                                  : _( "The finished item may have one hour or less of shelf life left.\n"
                                       "Start crafting anyway?" );
            if( !crafter->query_yn( warning ) ) {
                return item();
            }
        }
    }

    if( !validate_craft_material_plan( material_plan ) ) {
        debugmsg( "Aborting crafting: planned material sources changed before tool validation" );
        return item();
    }

    // Run the start (bucket-0) tool debit on a probe before consuming components
    // so a charge shortfall aborts without losing them; the debited allocations
    // carry over to the real craft.
    {
        item probe( rec, batch_size, item_components{}, std::vector<item_comp> {} );
        probe.set_step_tool_allocs( start_allocs );
        if( !crafter->craft_consume_step_tools( probe ) ) {
            debugmsg( "start tool debit failed for craft %s", rec->ident().str() );
            return item();
        }
        start_allocs = probe.get_step_tool_allocs();
    }

    if( !consume_craft_material_plan( *crafter, material_plan, used ) ) {
        debugmsg( "Aborting crafting: planned material sources changed before consumption" );
        return item();
    }

    for( const comp_selection<item_comp> &selection : item_selections ) {
        item_comp comp_used = selection.comp;
        comp_used.count *= batch_size;

        //Handle duplicate component requirement
        auto found_it = std::find_if( comps_used.begin(),
        comps_used.end(), [&comp_used]( const item_comp & c ) {
            return c.type == comp_used.type;
        } );
        if( found_it != comps_used.end() ) {
            item_comp &found_comp = *found_it;
            found_comp.count += comp_used.count;
        } else {
            comps_used.emplace_back( comp_used );
        }
    }

    item new_craft( rec, batch_size, used, comps_used, should_add_crafting_faults( crafter, rec ) );

    // Carry the probe's debited start buckets onto the real craft.
    new_craft.set_step_tool_allocs( start_allocs );
    new_craft.set_tools_to_continue( true );
    new_craft.set_next_failure_point( *crafter );
    new_craft.set_owner( *crafter );

    return new_craft;
}

skill_id craft_command::get_skill_id()
{
    return rec->skill_used;
}

std::vector<comp_selection<item_comp>> craft_command::check_item_components_missing(
                                        const read_only_visitable &map_inv ) const
{
    std::vector<comp_selection<item_comp>> missing;

    const auto filter = rec->get_component_filter( flags );

    for( const auto &item_sel : item_selections ) {
        itype_id type = item_sel.comp.type;
        const item_comp component = item_sel.comp;
        const int count = component.count > 0 ? component.count * batch_size : std::abs( component.count );

        if( item::count_by_charges( type ) && count > 0 ) {
            switch( item_sel.use_from ) {
                case usage_from::player:
                    if( !crafter->has_charges( type, count, filter ) ) {
                        missing.push_back( item_sel );
                    }
                    break;
                case usage_from::map:
                    if( !map_inv.has_charges( type, count, filter ) ) {
                        missing.push_back( item_sel );
                    }
                    break;
                case usage_from::both:
                    if( !( crafter->charges_of( type, INT_MAX, filter ) +
                           map_inv.charges_of( type, INT_MAX, filter ) >= count ) ) {
                        missing.push_back( item_sel );
                    }
                    break;
                case usage_from::none:
                case usage_from::cancel:
                case usage_from::num_usages_from:
                    break;
            }
        } else {
            // Counting by units, not charges.
            switch( item_sel.use_from ) {
                case usage_from::player:
                    if( !crafter->has_amount( type, count, false, filter ) ) {
                        missing.push_back( item_sel );
                    }
                    break;
                case usage_from::map:
                    if( !map_inv.has_components( type, count, filter ) ) {
                        missing.push_back( item_sel );
                    }
                    break;
                case usage_from::both:
                    if( !( crafter->amount_of( type, false, std::numeric_limits<int>::max(), filter ) +
                           map_inv.amount_of( type, false, std::numeric_limits<int>::max(), filter ) >= count ) ) {
                        missing.push_back( item_sel );
                    }
                    break;
                case usage_from::none:
                case usage_from::cancel:
                case usage_from::num_usages_from:
                    break;
            }
        }
    }

    return missing;
}

std::vector<comp_selection<tool_comp>> craft_command::check_tool_components_missing(
                                        const read_only_visitable &map_inv ) const
{
    std::vector<comp_selection<tool_comp>> missing;

    // Step recipes store their tools per step; a root tool repeats across steps
    // with the same selection, so check each distinct selection once.  Stepless
    // recipes carry the flat whole-recipe selection list.
    std::vector<comp_selection<tool_comp>> to_check;
    if( rec->has_steps() ) {
        for( const std::vector<step_tool_alloc> &step_allocs : step_tool_allocs ) {
            for( const step_tool_alloc &a : step_allocs ) {
                const bool seen = std::any_of( to_check.begin(), to_check.end(),
                [&a]( const comp_selection<tool_comp> &s ) {
                    return s.comp.type == a.sel.comp.type && s.comp.count == a.sel.comp.count &&
                           s.use_from == a.sel.use_from;
                } );
                if( !seen ) {
                    to_check.push_back( a.sel );
                }
            }
        }
    } else {
        to_check = tool_selections;
    }

    for( const auto &tool_sel : to_check ) {
        itype_id type = tool_sel.comp.type;
        if( tool_sel.comp.count > 0 ) {
            const int count = tool_sel.comp.count * batch_size;
            switch( tool_sel.use_from ) {
                case usage_from::player:
                    if( !crafter->has_charges( type, count ) ) {
                        missing.push_back( tool_sel );
                    }
                    break;
                case usage_from::map:
                    if( !map_inv.has_charges( type, count ) ) {
                        missing.push_back( tool_sel );
                    }
                    break;
                case usage_from::both:
                    if( !crafter->crafting_inventory().has_charges( type, count ) ) {
                        missing.push_back( tool_sel );
                    }
                    break;
                case usage_from::none:
                case usage_from::cancel:
                case usage_from::num_usages_from:
                    break;
            }
        } else if( !crafter->has_amount( type, 1 ) && !map_inv.has_tools( type, 1 ) ) {
            missing.push_back( tool_sel );
        }
    }

    return missing;
}
