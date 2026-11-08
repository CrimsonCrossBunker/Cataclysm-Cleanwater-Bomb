#include "craft_command.h"

#include <coordinates.h>
#include <algorithm>
#include <climits>
#include <cstdint>
#include <cstdlib>
#include <functional>
#include <limits>
#include <list>
#include <optional>
#include <string>
#include <utility>
#include <vector>

#include "activity_actor_definitions.h"
#include "cached_options.h"
#include "calendar.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "crafting.h"
#include "crafting_enums.h"
#include "debug.h"
#include "enum_conversions.h"
#include "enum_traits.h"
#include "flag.h"
#include "flexbuffer_json.h"
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
#include "mp_client_conn.h"
#include "mp_inventory_activity.h"
#include "output.h"
#include "pocket_type.h"
#include "recipe.h"
#include "requirements.h"
#include "ret_val.h"
#include "rng.h"
#include "temp_crafting_inventory.h"
#include "translations.h"
#include "type_id.h"
#include "uistate.h"
#include "units.h"
#include "vehicle.h"
#include "visitable.h"
#include "vpart_position.h"
#include "weather.h"

static const itype_id itype_candle( "candle" );

static const trait_id trait_DEBUG_HS( "DEBUG_HS" );

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

bool craft_command::select_components( bool only_cache_comps )
{
    if( empty() ) {
        return false;
    }

    bool need_selections = true;
    temp_crafting_inventory map_inv;
    map_inv.form_from_map( crafter->pos_bub(), pickup_range, crafter );

    if( has_cached_selections() ) {
        std::vector<comp_selection<item_comp>> missing_items = check_item_components_missing( map_inv );
        std::vector<comp_selection<tool_comp>> missing_tools = check_tool_components_missing( map_inv );

        if( missing_items.empty() && missing_tools.empty() ) {
            // All items we used previously are still there, so we don't need to do selection.
            need_selections = false;
        } else if( !only_cache_comps && !query_continue( missing_items, missing_tools ) ) {
            return false;
        }
    }

    if( need_selections ) {
        if( !crafter->can_make( rec, batch_size ) ) {
            if( crafter->can_start_craft( rec, recipe_filter_flags::none, batch_size ) ) {
                if( !query_yn( _( "You don't have enough charges to complete the %s.\n"
                                  "Start crafting anyway?" ), rec->result_name() ) ) {
                    return false;
                }
            } else if( !rec->character_has_required_proficiencies( *crafter ) ) {
                popup( _( "You don't have the required proficiencies to craft this!" ) );
                return false;
            } else {
                debugmsg( "Tried to start craft without sufficient charges" );
                return false;
            }
        }

        flags = recipe_filter_flags::no_rotten;

        if( !crafter->can_start_craft( rec, flags, batch_size ) ) {
            if( !query_yn( _( "This craft will use rotten components.\n"
                              "Start crafting anyway?" ) ) ) {
                return false;
            }
            flags = recipe_filter_flags::none;
        }

        flags |= recipe_filter_flags::no_favorite;
        if( !crafter->can_start_craft( rec, flags, batch_size ) ) {
            if( !query_yn( _( "This craft will use favorited components.\n"
                              "Start crafting anyway?" ) ) ) {
                return false;
            }
            flags = flags & recipe_filter_flags::no_rotten ? recipe_filter_flags::no_rotten :
                    recipe_filter_flags::none;
        }

        item_selections.clear();
        const auto filter = rec->get_component_filter( flags );
        const requirement_data *needs = rec->deduped_requirements().select_alternative(
                                            *crafter, filter, batch_size, craft_flags::start_only );
        if( !needs ) {
            return false;
        }

        for( const auto &it : needs->get_components() ) {
            comp_selection<item_comp> is =
                crafter->select_item_component( it, batch_size, map_inv, true, filter, true, true, rec );
            if( is.use_from == usage_from::cancel ) {
                return false;
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
                    return false;
                }
                tool_selections.push_back( ts );
            }
        }
    }

    if( only_cache_comps ) {
        return true;
    }

    // Only (re)select per-step tools when fresh selection is needed; a cached
    // repeat craft whose tools are all still present reuses the stored
    // allocations rather than reselecting and reprompting.
    if( rec->has_steps() && ( need_selections || step_tool_allocs.size() != rec->steps().size() ) ) {
        bool cancelled = false;
        step_tool_choices.clear();
        step_tool_allocs = select_step_tool_allocs( *crafter, *rec, batch_size, map_inv, cancelled,
                           -1, &step_tool_choices );
        if( cancelled ) {
            step_tool_allocs.clear();
            return false;
        }
    }

    plans.clear();
    if( rec->has_attention_steps() && crafter->is_avatar() ) {
        std::optional<std::vector<attention_plan>> chosen =
                show_craft_planning_modal( *rec, *crafter, batch_size, /*from_step=*/0, {} );
        if( !chosen ) {
            return false;
        }
        plans = std::move( *chosen );
    }
    return true;
}

bool craft_command::prepare()
{
    return select_components( false );
}

item craft_command::preview_start() const
{
    if( empty() ) {
        return item();
    }
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    const auto components = crafter->preview_crafting_components( item_selections, batch_size,
                            rec->get_component_filter( flags ) );
    return components ? item( rec, batch_size, *components, std::vector<item_comp> {}, false ) : item();
}

const char *craft_command::spoilage_warning( const item &preview ) const
{
    if( !preview.goes_bad() || rec->get_rot_inherit() == rot_inherit_mode::FRESH ) {
        return nullptr;
    }
    const time_duration duration = time_duration::from_moves(
                                       crafter->expected_time_to_craft( *rec, batch_size ) );
    const double rot = preview.get_relative_rot_after(
                           get_weather().get_temperature( crafter->pos_bub() ), 1.0f, duration );
    if( rot >= 1.0 ) {
        return _( "The selected ingredients may be rotten before this craft "
                  "finishes.\nStart crafting anyway?" );
    }
    if( preview.get_shelf_life() - preview.get_shelf_life() * rot <= 3_hours ) {
        return _( "The finished item may only have one to three hour or less of shelf life "
                  "left.\nStart crafting anyway?" );
    }
    return nullptr;
}

bool craft_command::prepare_owned_start()
{
    placement.reset();
    disposition.reset();
    start_weapon = {};
    allow_nonempty = allow_spoilage = false;
    item preview = preview_start();
    if( preview.is_null() ) {
        return false;
    }
    const auto filter = rec->get_component_filter( flags );
    if( !continue_prompt_liquids( filter, true ) ) {
        if( !continue_prompt_liquids( filter ) ) {
            return false;
        }
        allow_nonempty = true;
    }
    if( const char *warning = spoilage_warning( preview ) ) {
        if( !crafter->query_yn( warning ) ) {
            return false;
        }
        allow_spoilage = true;
    }
    placement = query_craft_placement( *crafter, preview, loc, always_start_on_ground() );
    if( !placement ) {
        return false;
    }
    if( *placement == craft_placement::wield && crafter->has_wield_conflicts( preview ) ) {
        start_weapon = capture_item_source( *crafter, crafter->get_wielded_item() );
        disposition = query_item_disposition( *crafter, crafter->get_wielded_item() );
        if( !disposition ) {
            return false;
        }
    }
    return validate_owned_start();
}

bool craft_command::validate_owned_start() const
{
    if( !placement || empty() || crafter->is_dead_state() ) {
        return false;
    }
    const item preview = preview_start();
    if( preview.is_null() ||
        !can_place_selected_craft( *crafter, preview, loc, always_start_on_ground(), *placement ) ||
        ( !allow_nonempty && !continue_prompt_liquids( rec->get_component_filter( flags ), true ) ) ||
        ( !allow_spoilage && spoilage_warning( preview ) ) ) {
        return false;
    }
    if( *placement == craft_placement::wield && crafter->has_wield_conflicts( preview ) ) {
        const item_location weapon = resolve_item_source( *crafter, get_map(), start_weapon );
        return disposition && weapon && weapon == crafter->get_wielded_item() &&
               crafter->can_unwield( *weapon ).success();
    }
    return !disposition;
}

void craft_command::execute( bool only_cache_comps )
{
    if( crafter && crafter->is_avatar() && cata_mp::is_client_mode() ) {
        const restore_on_out_of_scope restore_rng( rng_get_engine() );
        if( select_components( only_cache_comps ) && !only_cache_comps && prepare_owned_start() ) {
            cata_mp::client_start_craft( *this );
            record_selection();
        }
        return;
    }
    if( !select_components( only_cache_comps ) || only_cache_comps ) {
        return;
    }
    execute_prepared();
}

void craft_command::execute_prepared()
{
    if( placement ) {
        if( !validate_owned_start() ) {
            return;
        }
    }
    crafter->start_craft( *this, loc, std::move( plans ) );
    record_selection();
}

void craft_command::record_selection()
{
    crafter->last_batch = batch_size;
    crafter->lastrecipe = rec->ident();

    if( !crafter->is_avatar() ) {
        return;
    }

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
        bool no_prompt ) const
{
    std::vector<comp_selection<item_comp>> containers;
    for( const comp_selection<item_comp> &selection : item_selections ) {
        if( item::count_by_charges( selection.comp.type ) && selection.comp.count > 0 ) {
            continue;
        }
        const std::vector<pocket_data> &pockets = selection.comp.type->pockets;
        if( std::any_of( pockets.begin(), pockets.end(), []( const pocket_data & p ) {
        return p.type == pocket_type::CONTAINER && p.watertight;
    } ) ) {
            containers.push_back( selection );
        }
    }
    const std::optional<item_components> preview = crafter->preview_crafting_components(
                containers, batch_size, filter );
    if( !preview ) {
        return false;
    }
    for( const item_components::type_vector_pair &group : *preview ) {
        for( const item &container : group.second ) {
            if( !container.empty_container() &&
                ( no_prompt || !query_yn( _( "%1$s is not empty.  Continue anyway?" ),
                                          container.tname( 1U, true ) ) ) ) {
                return false;
            }
        }
    }
    return true;
}

static std::list<item> sane_consume_items( const comp_selection<item_comp> &it, Character *crafter,
        int batch, const std::function<bool( const item & )> &filter )
{
    map &m = get_map();
    const std::vector<pocket_data> it_pkt = it.comp.type->pockets;
    if( ( item::count_by_charges( it.comp.type ) && it.comp.count > 0 ) ||
    !std::any_of( it_pkt.begin(), it_pkt.end(), []( const pocket_data & p ) {
    return p.type == pocket_type::CONTAINER && p.watertight;
} ) ) {
        std::list<item> consumed = crafter->consume_items( it, batch, filter );
        return consumed;
    }

    // Everything below only occurs for item components that are liquid containers
    std::function<bool( const item & )> empty_filter = [&filter]( const item & it ) {
        return it.empty_container() && filter( it );
    };
    std::function<bool( const item & )> map_filter = [crafter, &filter]( const item & candidate ) {
        return candidate.is_owned_by( *crafter, true ) && filter( candidate );
    };
    std::function<bool( const item & )> map_empty_filter =
    [crafter, &empty_filter]( const item & candidate ) {
        return candidate.is_owned_by( *crafter, true ) && empty_filter( candidate );
    };

    int real_count = ( it.comp.count > 0 ) ? it.comp.count * batch : std::abs( it.comp.count );
    std::list<item> ret;
    for( int i = 0; i < 2 && real_count > 0; i++ ) {
        if( it.use_from & usage_from::map ) {
            const tripoint_bub_ms &loc = crafter->pos_bub();
            for( int radius = 0; radius <= pickup_range && real_count > 0; radius++ ) {
                for( const tripoint_bub_ms &p : m.points_in_radius( loc, radius ) ) {
                    if( rl_dist( loc, p ) >= radius ) {
                        std::list<item> tmp = m.use_amount_square( p, it.comp.type, real_count,
                                              i == 0 ? map_empty_filter : map_filter );
                        ret.insert( ret.end(), tmp.begin(), tmp.end() );
                    }
                }
            }
        }
        if( it.use_from & usage_from::player && real_count > 0 ) {
            std::list<item> tmp = crafter->use_amount( it.comp.type, real_count,
                                  i == 0 ? empty_filter : filter );
            real_count -= tmp.size();
            ret.insert( ret.end(), tmp.begin(), tmp.end() );
        }
    }
    return ret;
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
static std::vector<std::vector<step_tool_alloc>> allocate_step_tools(
            Character &crafter, const recipe &rec, int batch,
            const std::function<comp_selection<tool_comp>( const std::vector<tool_comp> & )> &select_group,
            bool &cancelled, int reselect_step )
{
    cancelled = false;
    const std::vector<recipe_step> &steps = rec.steps();
    std::vector<std::vector<step_tool_alloc>> allocs( steps.size() );

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

std::vector<std::vector<step_tool_alloc>> select_step_tool_allocs(
        Character &crafter, const recipe &rec, int batch, temp_crafting_inventory &map_inv,
        bool &cancelled, int reselect_step,
        std::vector<comp_selection<tool_comp>> *choices )
{
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

    const auto remember = [&]( const std::vector<tool_comp> &group ) {
        comp_selection<tool_comp> selected = select_group( group );
        if( choices ) {
            choices->push_back( selected );
        }
        return selected;
    };
    return allocate_step_tools( crafter, rec, batch, remember, cancelled, reselect_step );
}

namespace
{
template<typename Comp>
bool canonical_selection( comp_selection<Comp> &selected, const std::vector<Comp> &options,
                          int batch, bool tool )
{
    const auto found = std::find_if( options.begin(), options.end(), [&]( const Comp & candidate ) {
        return candidate.type == selected.comp.type && candidate.count == selected.comp.count;
    } );
    if( found == options.end() || !found->type.is_valid() ) {
        return false;
    }
    const int64_t count = found->count > 0 ? static_cast<int64_t>( found->count ) * batch :
                          -static_cast<int64_t>( found->count );
    const int64_t factor = tool && found->count > 0 ? found->type->charge_factor() : 1;
    if( count > INT_MAX || factor < 1 || count > INT_MAX / factor ) {
        return false;
    }
    if( tool && found->count <= 0 ) {
        if( selected.use_from != usage_from::none ) {
            return false;
        }
    } else if( selected.use_from != usage_from::map && selected.use_from != usage_from::player &&
               selected.use_from != usage_from::both ) {
        return false;
    }
    // Recoverability and all other component properties come from the recipe.
    selected.comp = *found;
    return true;
}

template<typename Comp>
bool canonical_selections( std::vector<comp_selection<Comp>> &selected,
                           const std::vector<std::vector<Comp>> &groups, int batch, bool tool )
{
    if( selected.size() != groups.size() ) {
        return false;
    }
    for( size_t i = 0; i < groups.size(); ++i ) {
        if( !canonical_selection( selected[i], groups[i], batch, tool ) ) {
            return false;
        }
    }
    return true;
}
bool selected_tools_available( Character &who,
                               const std::vector<comp_selection<tool_comp>> &tools, int batch,
                               bool with_remainder )
{
    if( tools.empty() ) {
        return true;
    }
    temp_crafting_inventory map_inv;
    map_inv.form_from_map( who.pos_bub(), pickup_range, &who );
    return std::all_of( tools.begin(), tools.end(), [&]( const comp_selection<tool_comp> &selected ) {
        const itype_id type = selected.comp.type;
        if( selected.comp.count <= 0 ) {
            return who.has_amount( type, 1 ) || map_inv.has_tools( type, 1 );
        }
        const int full = type->charge_factor() * selected.comp.count * batch;
        const int debit = std::max( full / 20 + ( with_remainder ? full % 20 : 0 ), 1 );
        if( selected.use_from == usage_from::map ) {
            return map_inv.has_charges( type, debit );
        }
        if( selected.use_from == usage_from::player ) {
            return who.crafting_inventory( who.pos_bub(), -1 ).has_charges( type, debit );
        }
        return who.crafting_inventory().has_charges( type, debit );
    } );
}
} // namespace

void write_craft_plans( JsonOut &out, const std::vector<attention_plan> &plans )
{
    out.start_array();
    for( const attention_plan &plan : plans ) {
        out.start_object();
        out.member( "choice", static_cast<int>( plan.choice ) );
        out.member( "alarm", plan.alarm_offset );
        out.end_object();
    }
    out.end_array();
}

std::optional<std::vector<attention_plan>> read_craft_plans( const Character &who,
                                        const recipe &rec, int batch, const JsonArray &data, const item *current )
{
    std::vector<attention_plan> plans;
    std::optional<crafting_cost_context> context;
    for( const JsonObject entry : data ) {
        const size_t index = plans.size();
        const int choice = entry.get_int( "choice" );
        if( index >= rec.steps().size() || choice < 0 || choice > 2 ) {
            return std::nullopt;
        }
        attention_plan plan;
        plan.choice = static_cast<step_choice>( choice );
        entry.read( "alarm", plan.alarm_offset, true );
        if( current && static_cast<int>( index ) < current->get_current_step() ) {
            const auto &old = current->get_step_plans();
            const attention_plan previous = index < old.size() ? old[index] : attention_plan{};
            if( plan.choice != previous.choice || plan.alarm_offset != previous.alarm_offset ) {
                return std::nullopt;
            }
        } else if( plan.choice == step_choice::set_timer ) {
            if( rec.steps()[index].attention != step_attention::unattended ||
                !( who.has_watch() || who.has_alarm_clock() ) || !plan.alarm_offset ) {
                return std::nullopt;
            }
            const bool inflight = current && static_cast<int>( index ) == current->get_current_step() &&
                                  current->get_passive_started_at() != calendar::before_time_starts;
            if( inflight ) {
                const bool paused = current->get_saved_ready_at() != calendar::before_time_starts;
                const auto allowed = compute_inflight_alarm_choices( current->get_passive_started_at(),
                                     paused ? current->get_saved_ready_at() : current->get_ready_at(),
                                     paused ? current->get_pause_started_at() : calendar::turn );
                if( plan.alarm_offset != allowed.finish_offset &&
                    plan.alarm_offset != allowed.five_before_offset ) {
                    return std::nullopt;
                }
            } else {
                if( !context ) {
                    context = crafting_cost_context::for_recipe( who, rec );
                }
                const auto duration = time_duration::from_moves( rec.step_budget_moves(
                                          who, index, batch, *context, recipe_time_flag::ignore_proficiencies ) );
                if( *plan.alarm_offset < 0_seconds ||
                    ( *plan.alarm_offset != duration && *plan.alarm_offset != duration - 5_minutes ) ) {
                    return std::nullopt;
                }
            }
        } else if( plan.alarm_offset || ( plan.choice == step_choice::do_something &&
                                          rec.steps()[index].attention != step_attention::unattended ) ) {
            return std::nullopt;
        }
        plans.push_back( plan );
    }
    if( !plans.empty() && plans.size() != rec.steps().size() ) {
        return std::nullopt;
    }
    return plans;
}

void craft_command::serialize_selection( JsonOut &out ) const
{
    out.start_object();
    out.member( "recipe", rec->ident() );
    out.member( "batch", batch_size );
    out.member( "long", longcraft );
    out.member( "flags", static_cast<int>( flags ) );
    if( loc ) {
        out.member( "location", get_map().get_abs( *loc ) );
    }
    out.member( "components", item_selections );
    out.member( "tools", tool_selections );
    out.member( "step_tools", step_tool_choices );
    out.member( "plans" );
    write_craft_plans( out, plans );
    if( placement ) {
        out.member( "start" );
        out.start_object();
        out.member( "placement", static_cast<int>( *placement ) );
        out.member( "allow_nonempty", allow_nonempty );
        out.member( "allow_spoilage", allow_spoilage );
        out.member( "weapon", start_weapon );
        if( disposition ) {
            out.member( "disposition" );
            out.start_object();
            out.member( "action", disposition->action );
            out.member( "container", disposition->container );
            out.member( "pocket", disposition->pocket );
            out.end_object();
        }
        out.end_object();
    }
    out.end_object();
}

std::optional<craft_command> craft_command::from_selection( Character &who, const JsonObject &data )
{
    const recipe_id id( data.get_string( "recipe" ) );
    const int batch = data.get_int( "batch" );
    const int filter_flags = data.get_int( "flags" );
    if( !id.is_valid() || batch <= 0 || batch > crafting_batch_input_max ||
        filter_flags < 0 || filter_flags > 3 || !who.has_recipe( &*id ) ||
        !crafting_allowed( who, *id ) ) {
        return std::nullopt;
    }
    std::optional<tripoint_bub_ms> target;
    if( data.has_member( "location" ) ) {
        tripoint_abs_ms absolute;
        data.read( "location", absolute, true );
        if( absolute.z() != who.pos_abs().z() || square_dist( absolute, who.pos_abs() ) > 1 ||
            !get_map().inbounds( absolute ) ) {
            return std::nullopt;
        }
        target = get_map().get_bub( absolute );
    }
    craft_command command( &*id, batch, data.get_bool( "long" ), &who, target );
    command.flags = static_cast<recipe_filter_flags>( filter_flags );
    data.read( "components", command.item_selections, true );
    data.read( "tools", command.tool_selections, true );
    data.read( "step_tools", command.step_tool_choices, true );
    bool matched = false;
    for( const requirement_data &alternative : id->deduped_requirements().alternatives() ) {
        auto items = command.item_selections;
        auto tools = command.tool_selections;
        if( canonical_selections( items, alternative.get_components(), batch, false ) &&
            ( id->has_steps() ? tools.empty() :
              canonical_selections( tools, alternative.get_tools(), batch, true ) ) ) {
            command.item_selections = std::move( items );
            command.tool_selections = std::move( tools );
            matched = true;
            break;
        }
    }
    if( !matched || !who.can_start_craft( &*id, command.flags, batch ) ) {
        return std::nullopt;
    }
    if( id->has_steps() ) {
        size_t index = 0;
        bool cancelled = false;
        const auto select = [&]( const std::vector<tool_comp> &group ) {
            comp_selection<tool_comp> choice;
            choice.use_from = usage_from::cancel;
            if( index < command.step_tool_choices.size() ) {
                choice = command.step_tool_choices[index++];
                if( !canonical_selection( choice, group, batch, true ) ) {
                    choice.use_from = usage_from::cancel;
                }
            }
            return choice;
        };
        command.step_tool_allocs = allocate_step_tools( who, *id, batch, select, cancelled, -1 );
        if( cancelled || index != command.step_tool_choices.size() ) {
            return std::nullopt;
        }
    } else if( !command.step_tool_choices.empty() ) {
        return std::nullopt;
    }
    if( !selected_tools_available( who, command.tool_selections, batch, true ) ||
        !selected_tools_available( who, command.step_tool_choices, batch, true ) ) {
        return std::nullopt;
    }
    auto plans = read_craft_plans( who, *id, batch, data.get_array( "plans" ) );
    if( !plans ) {
        return std::nullopt;
    }
    command.plans = std::move( *plans );
    const auto filter = id->get_component_filter( command.flags );
    if( !who.preview_crafting_components( command.item_selections, batch, filter ) ) {
        return std::nullopt;
    }
    if( data.has_object( "start" ) ) {
        const JsonObject start = data.get_object( "start" );
        const int selected = start.get_int( "placement" );
        if( selected < static_cast<int>( craft_placement::automatic ) ||
            selected > static_cast<int>( craft_placement::drop ) ) {
            return std::nullopt;
        }
        command.placement = static_cast<craft_placement>( selected );
        command.allow_nonempty = start.get_bool( "allow_nonempty", false );
        command.allow_spoilage = start.get_bool( "allow_spoilage", false );
        start.read( "weapon", command.start_weapon );
        if( start.has_object( "disposition" ) ) {
            const JsonObject selected = start.get_object( "disposition" );
            command.disposition = item_disposition{ selected.get_string( "action" ),
                                                    selected.get_int64( "container" ), selected.get_int64( "pocket" ) };
        }
        if( !command.validate_owned_start() ) {
            return std::nullopt;
        }
    }
    return command;
}

craft_resume_selection::craft_resume_selection( const item &craft ) :
    recipe( craft.get_making().ident() ), batch( craft.get_making_batch_size() ),
    progress( craft.item_counter ), step( craft.get_current_step() ),
    replaces_tools( !craft.has_tools_to_continue() )
{
}

bool craft_resume_selection::matches( const item &craft ) const
{
    return craft.is_craft() && recipe == craft.get_making().ident() &&
           batch == craft.get_making_batch_size() && progress == craft.item_counter &&
           step == craft.get_current_step() && replaces_tools == !craft.has_tools_to_continue();
}

std::optional<craft_resume_selection> craft_resume_selection::prepare( Character &who, item &craft )
{
    if( !craft.is_craft() ) {
        return std::nullopt;
    }
    craft_resume_selection selected( craft );
    if( !who.can_continue_craft( craft, craft.get_continue_reqs(), &selected ) ) {
        return std::nullopt;
    }
    return selected;
}

std::vector<std::vector<step_tool_alloc>> craft_resume_selection::retain_paid_tools(
        const item &craft, std::vector<std::vector<step_tool_alloc>> fresh )
{
    const auto &prior = craft.get_step_tool_allocs();
    const auto &steps = craft.get_making().steps();
    if( craft.get_making().has_steps() && prior.size() == steps.size() ) {
        const int current = std::clamp( craft.get_current_step(), 0,
                                        static_cast<int>( steps.size() ) - 1 );
        for( size_t s = 0; s < fresh.size(); ++s ) {
            if( static_cast<int>( s ) == current ) {
                continue;
            }
            std::vector<step_tool_alloc> merged;
            for( const step_tool_alloc &allocation : prior[s] ) {
                if( !allocation.root_derived ) {
                    merged.push_back( allocation );
                }
            }
            merged.insert( merged.end(), fresh[s].begin(), fresh[s].end() );
            fresh[s] = std::move( merged );
        }
    }
    // Selection is in recipe order. Never charge a previously paid bucket again,
    // even when the chosen tool changed at that position.
    for( size_t s = 0; s < fresh.size() && s < prior.size(); ++s ) {
        for( size_t a = 0; a < fresh[s].size() && a < prior[s].size(); ++a ) {
            fresh[s][a].consumed_buckets = std::max( fresh[s][a].consumed_buckets,
                                           prior[s][a].consumed_buckets );
        }
    }
    return fresh;
}

void craft_resume_selection::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "recipe", recipe );
    out.member( "batch", batch );
    out.member( "progress", progress );
    out.member( "step", step );
    out.member( "replace_tools", replaces_tools );
    out.member( "flags", static_cast<int>( flags ) );
    out.member( "components", components );
    out.member( "tools", tools );
    out.end_object();
}

std::optional<craft_resume_selection> craft_resume_selection::from_selection(
    Character &who, item &craft, const JsonObject &data )
{
    if( !craft.is_craft() ) {
        return std::nullopt;
    }
    craft_resume_selection selected( craft );
    data.read( "recipe", selected.recipe, true );
    data.read( "batch", selected.batch, true );
    data.read( "progress", selected.progress, true );
    data.read( "step", selected.step, true );
    data.read( "replace_tools", selected.replaces_tools, true );
    const int filter_flags = data.get_int( "flags" );
    if( !selected.matches( craft ) || selected.batch <= 0 || filter_flags < 0 || filter_flags > 3 ) {
        return std::nullopt;
    }
    selected.flags = static_cast<recipe_filter_flags>( filter_flags );
    data.read( "components", selected.components, true );
    data.read( "tools", selected.tools, true );
    const requirement_data requirements = craft.get_continue_reqs();
    if( !canonical_selections( selected.components, requirements.get_components(), 1, false ) ) {
        return std::nullopt;
    }
    const ::recipe &rec = craft.get_making();
    if( !rec.character_has_required_proficiencies( who ) ) {
        return std::nullopt;
    }
    if( selected.replaces_tools ) {
        if( rec.has_steps() ) {
            size_t index = 0;
            bool cancelled = false;
            const auto choose = [&]( const std::vector<tool_comp> &group ) {
                comp_selection<tool_comp> choice;
                choice.use_from = usage_from::cancel;
                if( index < selected.tools.size() ) {
                    choice = selected.tools[index++];
                    if( !canonical_selection( choice, group, selected.batch, true ) ) {
                        choice.use_from = usage_from::cancel;
                    }
                }
                return choice;
            };
            const bool prior_full = craft.get_step_tool_allocs().size() == rec.steps().size();
            const int current = std::clamp( selected.step, 0,
                                            static_cast<int>( rec.steps().size() ) - 1 );
            auto fresh = allocate_step_tools( who, rec, selected.batch, choose, cancelled,
                                              prior_full ? current : -1 );
            if( cancelled || index != selected.tools.size() ) {
                return std::nullopt;
            }
            selected.allocations = retain_paid_tools( craft, std::move( fresh ) );
        } else {
            if( !canonical_selections( selected.tools, rec.simple_requirements().get_tools(),
                                       selected.batch, true ) ) {
                return std::nullopt;
            }
            std::vector<step_tool_alloc> step0;
            for( const auto &choice : selected.tools ) {
                step_tool_alloc allocation;
                allocation.sel = choice;
                allocation.step_count_units = std::max( 0, choice.comp.count ) * selected.batch;
                step0.push_back( allocation );
            }
            selected.allocations = retain_paid_tools( craft, { step0 } );
        }
        if( !selected_tools_available( who, selected.tools, selected.batch, rec.has_steps() ) ) {
            return std::nullopt;
        }
    } else if( !selected.tools.empty() ) {
        return std::nullopt;
    }
    const auto base_filter = rec.get_component_filter( selected.flags );
    const auto filter = [&]( const item & component ) {
        return base_filter( component ) &&
               ( component.is_container_empty() || !component.is_watertight_container() );
    };
    if( !selected.components.empty() &&
        !who.preview_crafting_components( selected.components, 1, filter ) ) {
        return std::nullopt;
    }
    return selected;
}

bool craft_resume_selection::apply( Character &who, item &craft ) const
{
    if( !matches( craft ) ) {
        return false;
    }
    const auto base_filter = craft.get_making().get_component_filter( flags );
    const auto filter = [&]( const item & component ) {
        return base_filter( component ) &&
               ( component.is_container_empty() || !component.is_watertight_container() );
    };
    auto validated = components;
    if( !components.empty() &&
        ( !canonical_selections( validated, craft.get_continue_reqs().get_components(), 1, false ) ||
          !who.preview_crafting_components( components, 1, filter ) ) ) {
        return false;
    }
    if( replaces_tools && !selected_tools_available( who, tools, batch,
            craft.get_making().has_steps() ) ) {
        return false;
    }
    for( const auto &selection : components ) {
        for( item &component : who.consume_items( selection, 1, filter ) ) {
            craft.components.add( component );
        }
    }
    if( replaces_tools ) {
        craft.set_step_tool_allocs( allocations );
        craft.set_tools_to_continue( true );
    }
    return true;
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

    temp_crafting_inventory map_inv;
    map_inv.form_from_map( crafter->pos_bub(), pickup_range, crafter );

    if( !check_item_components_missing( map_inv ).empty() ) {
        debugmsg( "Aborting crafting: couldn't find cached components" );
        return item();
    }

    const auto filter = rec->get_component_filter( flags );

    if( !placement && crafter->is_avatar() &&
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

    std::optional<item_components> preview_used = crafter->preview_crafting_components(
                item_selections, batch_size, filter );
    if( !preview_used ) {
        debugmsg( "Aborting crafting: couldn't preview selected components" );
        return item();
    }

    // The preview uses copies of the selected components and follows the same
    // inheritance path as the craft that will be created below.
    item preview( rec, batch_size, *preview_used, std::vector<item_comp> {}, false );
    if( placement ? !can_place_selected_craft( *crafter, preview, loc, always_start_on_ground(),
            *placement ) :
        !can_place_craft( *crafter, preview, loc, always_start_on_ground() ) ) {
        crafter->add_msg_if_player( _( "There is not enough room to place the in-progress craft.  "
                                       "Try a smaller batch or clear space nearby.  "
                                       "No components or tool charges have been consumed." ) );
        return item();
    }
    if( const char *warning = spoilage_warning( preview ) ) {
        if( placement ? !allow_spoilage : crafter->is_avatar() && !crafter->query_yn( warning ) ) {
            return item();
        }
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

    for( const auto &it : item_selections ) {
        std::list<item> tmp = sane_consume_items( it, crafter, batch_size, filter );
        for( item &tmp_it : tmp ) {
            if( !placement && safe_to_unload_comp( tmp_it ) ) {
                item_location tmp_loc( *crafter, &tmp_it );
                unload_activity_actor::unload( *crafter, tmp_loc );
            }
        }
        for( item &it : tmp ) {
            used.add( it );
        }
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

    if( placement ) {
        new_craft.get_craft_results().owner_selects_destination = true;
        new_craft.get_craft_results().components_pending = true;
    }

    // Carry the probe's debited start buckets onto the real craft.
    new_craft.set_step_tool_allocs( start_allocs );
    new_craft.set_tools_to_continue( true );
    new_craft.set_next_failure_point( *crafter );
    new_craft.set_owner( *crafter );

    // The wielded item (or its container) may itself be a selected component.
    // Native crafting consumes components before freeing the hand for the
    // workpiece. Moving it earlier invalidates the selected material source.
    if( placement == craft_placement::wield && disposition ) {
        const item_location weapon = resolve_item_source( *crafter, get_map(), start_weapon );
        if( weapon && weapon == crafter->get_wielded_item() &&
            !execute_item_disposition( *crafter, weapon, *disposition ) ) {
            // A selected storage pocket can also have been consumed. Keep both
            // the weapon and workpiece; native placement falls back to ground.
            crafter->add_msg_if_player( _( "Your selected storage is no longer available.  "
                                           "You put the in-progress craft down to work on it." ) );
        }
    }

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
