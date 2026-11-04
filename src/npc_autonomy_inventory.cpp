#include "npc.h"

#include <algorithm>
#include <list>
#include <unordered_set>
#include <vector>

#include "avatar.h"
#include "bodypart.h"
#include "character_attire.h"
#include "clzones.h"
#include "craft_reservation.h"
#include "game.h"
#include "game_constants.h"
#include "flag.h"
#include "item_contents.h"
#include "item_pocket.h"
#include "itype.h"
#include "map.h"
#include "pocket_type.h"
#include "ret_val.h"
#include "translations.h"
#include "visitable.h"

namespace
{
// Plan on copies only. Never detach belongings until all capacity checks pass.
item *corresponding_item( const item &original, item &copy, const item *wanted, int depth = 0 )
{
    if( &original == wanted ) {
        return &copy;
    }
    if( depth >= 32 ) {
        return nullptr;
    }
    const auto originals = original.all_items_top();
    const auto copies = copy.all_items_top();
    auto c = copies.begin();
    for( const item *o : originals ) {
        if( c == copies.end() ) {
            break;
        }
        if( item *found = corresponding_item( *o, **c, wanted, depth + 1 ) ) {
            return found;
        }
        ++c;
    }
    return nullptr;
}

bool store_directly( item &container, const item &payload )
{
    auto pockets = container.get_container_pockets();
    std::stable_sort( pockets.begin(), pockets.end(), []( const item_pocket *a, const item_pocket *b ) {
        return a->settings.priority() > b->settings.priority();
    } );
    for( item_pocket *p : pockets ) {
        if( !p->sealed() && !p->settings.is_disabled() && p->settings.accepts_item( payload ) &&
            p->can_contain( payload ).success() && p->insert_item( payload ).success() ) {
            container.on_contents_changed();
            return true;
        }
    }
    return false;
}

std::map<const item *, item_location> bounded_locations( npc &who )
{
    int count = 0;
    who.visit_items( [&count]( const item *, const item * ) {
        return ++count > 512 ? VisitResponse::ABORT : VisitResponse::NEXT;
    } );
    std::map<const item *, item_location> result;
    if( count <= 512 ) {
        for( item_location loc : who.all_items_loc() ) {
            result.emplace( &*loc, loc );
        }
    }
    return result;
}

bool accessible_source( npc &who, item_location loc )
{
    if( !loc || !loc.held_by( who ) || loc->is_favorite || loc->is_dangerous() || loc->active ||
        loc->has_link_data() || !loc->is_owned_by( who, true ) ||
        craft_reservation::contains_reserved( *loc ) || craft_reservation::contains_live_craft( *loc ) ) {
        return false;
    }
    for( int depth = 0; loc.has_parent(); ++depth ) {
        const item_pocket *pocket = loc.parent_pocket();
        if( depth >= 32 || !pocket || !pocket->is_type( pocket_type::CONTAINER ) ||
            pocket->sealed() || !pocket->settings.is_unloadable() ) {
            return false;
        }
        loc = loc.parent_item();
        if( !loc || !loc->is_owned_by( who, true ) || loc->has_link_data() ||
            craft_reservation::contains_reserved( *loc ) || craft_reservation::contains_live_craft( *loc ) ) {
            return false;
        }
    }
    return true;
}

bool pack_retired( npc &who, item &prepared, item &retired, const item *avoid,
                   bool &retired_inside, int &cost )
{
    const auto cargo = retired.all_items_top( pocket_type::CONTAINER );
    if( cargo.size() > 128 ) {
        return false;
    }
    for( const item_pocket *pocket : retired.get_container_pockets() ) {
        if( !pocket->empty() && ( pocket->sealed() || !pocket->settings.is_unloadable() ||
                                pocket->settings.was_edited() ) ) {
            return false;
        }
    }
    for( const item *it : cargo ) {
        const int insertion_cost = prepared.insert_cost( *it );
        if( it->is_dangerous() || it->has_link_data() || !store_directly( prepared, *it ) ) {
            return false;
        }
        cost += who.item_handling_cost( *it, true, retired.obtain_cost( *it ) ) +
                who.item_handling_cost( *it, true, insertion_cost );
    }
    retired.get_contents().clear_pockets_if( []( const item_pocket &p ) {
        return p.is_type( pocket_type::CONTAINER );
    } );
    retired.on_contents_changed();
    const int storage_cost = prepared.insert_cost( retired );
    retired_inside = store_directly( prepared, retired );
    cost += who.item_handling_cost( retired, true, retired_inside ? storage_cost : 100 );
    return retired_inside || who.best_pocket( retired, avoid ).second;
}

bool bounded_contents( const item &root )
{
    int count = 0;
    root.visit_items( [&count]( const item *, const item * ) {
        return ++count > 256 ? VisitResponse::ABORT : VisitResponse::NEXT;
    } );
    return count <= 256;
}

bool prepare_outfit( npc &who, const item_location &candidate, const item_location &previous,
                     item &prepared, item &retired, bool &retired_inside, int &cost )
{
    if( !accessible_source( who, candidate ) || who.is_worn( *candidate ) ||
        !candidate->is_owned_by( who, true ) || candidate->is_filthy() || candidate->is_dangerous() ||
        ( candidate->count_by_charges() && candidate->charges != 1 ) ||
        craft_reservation::contains_reserved( *candidate ) ||
        craft_reservation::contains_live_craft( *candidate ) ||
        !who.can_wear( *candidate, true ).success() ) {
        return false;
    }
    if( !bounded_contents( *candidate ) || ( previous && !bounded_contents( *previous ) ) ) {
        return false;
    }
    prepared = *candidate;
    cost = candidate.obtain_cost( who ) + who.item_wear_cost( prepared );
    retired_inside = false;
    if( !previous ) {
        return true;
    }
    if( !previous.held_by( who ) || !previous->is_owned_by( who, true ) ||
        !who.is_worn( *previous ) || previous->is_favorite ||
        previous->any_pockets_sealed() || previous->has_link_data() || previous->active ||
        previous->has_flag( flag_id( "SPLINT" ) ) || !who.can_takeoff( *previous ).success() ||
        craft_reservation::contains_reserved( *previous ) ||
        craft_reservation::contains_live_craft( *previous ) ) {
        return false;
    }
    retired = *previous;
    if( item *excluded = corresponding_item( *previous, retired, &*candidate ) ) {
        retired.remove_items_with( [excluded]( const item &it ) { return &it == excluded; } );
    }
    cost += who.item_wear_cost( *previous );
    if( !pack_retired( who, prepared, retired, &*previous, retired_inside, cost ) ) {
        return false;
    }
    return npc_autonomy::worthwhile_upgrade( who.autonomous_armor_score( *previous ),
            who.autonomous_armor_score( prepared ) - who.autonomous_outfit_penalty( prepared, &*previous ) );
}

int spare_quantity( npc &who, const item &it, bool sharing = false )
{
    who.refresh_autonomous_inventory();
    if( it.is_favorite || it.is_dangerous() || it.is_filthy() || it.active ||
        !it.is_owned_by( who, true ) || craft_reservation::contains_reserved( it ) ||
        craft_reservation::contains_live_craft( it ) ) {
        return 0;
    }
    int spare = 0;
    if( it.get_use( "heal" ) ) {
        spare = who.autonomy.healing_units - ( sharing ?
                std::max( 2, who.autonomy.healing_target / 2 ) : who.autonomy.healing_target );
    } else if( it.is_ammo() ) {
        const int target = who.autonomy.ammo_targets[it.ammo_type()];
        spare = who.autonomy.ammunition[it.ammo_type()] - ( sharing ? ( target + 1 ) / 2 : target );
    } else if( it.is_food() && who.will_eat( it ).success() ) {
        const int kcal = who.compute_effective_nutrients( it ).kcal();
        const int water = it.get_comestible()->quench;
        spare = it.count_by_charges() ? it.charges : 1;
        if( kcal > 0 ) {
            spare = std::min( spare,
                              std::max( 0, who.autonomy.food_kcal - ( sharing ? who.autonomy.food_target / 2 : who.autonomy.food_target ) ) / kcal );
        }
        if( water > 0 ) {
            spare = std::min( spare,
                              std::max( 0, who.autonomy.water_quench - ( sharing ? who.autonomy.water_target / 2 : who.autonomy.water_target ) ) / water );
        }
        if( kcal <= 0 && water <= 0 ) {
            spare = 0;
        }
    }
    return std::clamp( spare, 0, it.count_by_charges() ? it.charges : 1 );
}

int team_transfer_quantity( npc &donor, npc &recipient, const item &it )
{
    int quantity = std::min( spare_quantity( donor, it, true ), recipient.autonomous_pickup_quantity( it ) );
    if( it.get_use( "heal" ) ) {
        quantity = std::min( quantity, npc_autonomy::balanced_units( donor.autonomy.healing_units,
                             recipient.autonomy.healing_units ) );
    } else if( it.is_ammo() ) {
        quantity = std::min( quantity, npc_autonomy::balanced_units( donor.autonomy.ammunition[it.ammo_type()],
                             recipient.autonomy.ammunition[it.ammo_type()] ) );
    } else if( it.is_food() ) {
        const int kcal = donor.compute_effective_nutrients( it ).kcal();
        const int water = it.get_comestible()->quench;
        if( kcal > 0 ) {
            quantity = std::min( quantity, npc_autonomy::balanced_units( donor.autonomy.food_kcal,
                                 recipient.autonomy.food_kcal, kcal ) );
        }
        if( water > 0 ) {
            quantity = std::min( quantity, npc_autonomy::balanced_units( donor.autonomy.water_quench,
                                 recipient.autonomy.water_quench, water ) );
        }
    }
    return quantity;
}

void remove_quantity( item_location source, int quantity )
{
    if( source->count_by_charges() && source->charges > quantity ) {
        source->charges -= quantity;
        source.on_contents_changed();
    } else {
        source.remove_item();
    }
}
}

double npc::autonomous_outfit_penalty( const item &candidate, const item *previous )
{
    std::list<item> projected;
    for( const item_location &loc : worn.top_items_loc( *this ) ) {
        if( &*loc != previous ) {
            projected.push_back( *loc );
        }
    }
    outfit next( projected );
    std::map<bodypart_id, encumbrance_data> before;
    std::map<bodypart_id, encumbrance_data> after;
    worn.item_encumb( before, null_item_reference(), *this );
    next.item_encumb( after, candidate, *this );
    double penalty = 0;
    for( const auto &bp : after ) {
        // Per-item encumbrance is already in the armor score; account for additional layering here.
        penalty += std::max( 0, bp.second.layer_penalty - before[bp.first].layer_penalty ) * 0.8;
        if( bp.second.encumbrance >= 60 && bp.second.encumbrance > before[bp.first].encumbrance ) {
            penalty += ( bp.second.encumbrance - before[bp.first].encumbrance ) * 2.0;
        }
    }
    return penalty;
}

bool npc::autonomous_plan_equipment( item_location candidate, item_location previous )
{
    item prepared;
    item retired;
    bool inside = false;
    int cost = 0;
    if( !prepare_outfit( *this, candidate, previous, prepared, retired, inside, cost ) ) {
        return false;
    }
    autonomy.plan = {};
    autonomy.plan.task = npc_autonomy_task::equipment;
    autonomy.plan.source = candidate;
    autonomy.plan.target = previous;
    autonomy.plan.target_required = static_cast<bool>( previous );
    autonomy.plan.work_required = std::max( 1, cost );
    autonomy.plan.expires = calendar::turn + 5_minutes;
    autonomy.reason = _( "Preparing a safe equipment and pocket change." );
    return autonomous_continue_plan();
}

bool npc::autonomous_continue_plan()
{
    npc_autonomy_plan &plan = autonomy.plan;
    if( plan.task == npc_autonomy_task::none ) {
        return false;
    }
    if( calendar::turn > plan.expires || !accessible_source( *this, plan.source ) ||
        ( plan.target_required && ( !plan.target || !plan.target.held_by( *this ) ) ) ||
        is_dead_state() || !autonomous_maintenance_allowed() ) {
        plan = {};
        return false;
    }
    const Character &leader = get_player_character();
    if( !is_safe() || activity || in_vehicle || in_sleep_state() ||
        sees_dangerous_field( pos_bub() ) ) {
        return false;
    }
    const bool external = plan.task == npc_autonomy_task::share ||
                          plan.task == npc_autonomy_task::deposit;
    if( external && attitude != NPCATT_FOLLOW ) {
        plan = {};
        return false;
    }
    if( external && ( leader.in_vehicle || !sees( get_map(), leader ) ||
                     rl_dist( pos_bub(), leader.pos_bub() ) > 4 ) ) {
        return false;
    }
    if( plan.task == npc_autonomy_task::share && !rules.has_flag( ally_rule::share_supplies ) ) {
        plan = {};
        return false;
    }
    if( plan.task == npc_autonomy_task::share && plan.recipient ) {
        npc *recipient = nullptr;
        for( npc &other : g->all_npcs() ) {
            if( other.getID() == *plan.recipient && other.is_player_ally() && !other.is_dead_state() &&
                !other.in_vehicle && other.is_safe() && sees( get_map(), other ) &&
                other.rules.has_flag( ally_rule::share_supplies ) &&
                rl_dist( pos_bub(), other.pos_bub() ) <= 3 ) {
                recipient = &other;
                break;
            }
        }
        if( !recipient ) {
            plan = {};
            autonomous_decision_result( "supplies", false );
            return false;
        }
        if( rl_dist( pos_bub(), recipient->pos_bub() ) > 1 ) {
            for( const tripoint_bub_ms &p : get_map().points_in_radius( recipient->pos_bub(), 1 ) ) {
                if( p == recipient->pos_bub() || p.z() != leader.posz() ||
                    rl_dist( p, leader.pos_bub() ) > 4 ||
                    !get_map().inbounds( p ) || !g->is_empty( p ) ||
                    !could_move_onto( p ) || sees_dangerous_field( p ) ||
                    is_no_go_position( get_map().get_abs( p ) ) ||
                    !update_path( p, true ) || path.empty() ) {
                    continue;
                }
                if( std::any_of( path.begin(), path.end(), [this]( const auto &step ) {
                    return sees_dangerous_field( step ) || is_no_go_position( get_map().get_abs( step ) );
                } ) ) {
                    continue;
                }
                autonomous_announce( "share", _( "I'll bring you some spare supplies." ) );
                move_to_next();
                return true;
            }
            plan = {};
            autonomous_decision_result( "supplies", false );
            return false;
        }
    }
    const int spent = npc_autonomy::work_slice( moves, plan.work_required, plan.work_done );
    if( spent > 0 && plan.work_done == 0 ) {
        switch( plan.task ) {
            case npc_autonomy_task::equipment:
                autonomous_announce( "equipment", _( "I'll change into more suitable equipment." ) );
                break;
            case npc_autonomy_task::organize:
                autonomous_announce( "organize", _( "I'll put my supplies where I can reach them." ) );
                break;
            case npc_autonomy_task::share:
                autonomous_announce( "share", _( "I'll pass some spare supplies to our teammate." ) );
                break;
            case npc_autonomy_task::deposit:
                autonomous_announce( "deposit", _( "I'll leave the surplus in our storage area." ) );
                break;
            case npc_autonomy_task::none:
                break;
        }
    }
    mod_moves( -spent );
    plan.work_done += spent;
    if( plan.work_done < plan.work_required ) {
        return spent > 0;
    }
    if( plan.task == npc_autonomy_task::equipment ) {
        item prepared;
        item retired;
        bool inside = false;
        int cost = 0;
        if( !prepare_outfit( *this, plan.source, plan.target, prepared, retired, inside, cost ) ) {
            plan = {};
            return spent > 0;
        }
        if( cost > plan.work_done ) {
            plan.work_required = cost;
            return true;
        }
        // Only this commit detaches items; interrupted preparation leaves the outfit intact.
        item candidate( *plan.source );
        plan.source.remove_item();
        std::list<item> removed;
        if( plan.target && ( !takeoff( plan.target, &removed ) || removed.empty() ) ) {
            i_add( candidate );
            plan = {};
            return true;
        }
        // Native takeoff hooks may modify the old garment. Rebuild from their actual result.
        prepared = candidate;
        int updated_cost = 0;
        bool ready = true;
        if( !removed.empty() ) {
            retired = removed.front();
            ready = pack_retired( *this, prepared, retired, nullptr, inside, updated_cost );
        }
        const auto equipped = ready ? wear_item( prepared, false ) : std::nullopt;
        bool committed = equipped.has_value();
        if( committed && !removed.empty() && !inside && !try_add( retired, nullptr, nullptr, false ) ) {
            std::list<item> undo;
            takeoff( item_location( *this, &**equipped ), &undo );
            committed = false;
        }
        if( committed ) {
            autonomy.reason = _( "Equipment improved; belongings retained." );
        } else {
            if( !removed.empty() ) {
                if( !wear_item( removed.front(), false ) ) {
                    i_add( removed.front() );
                }
            }
            i_add( candidate );
            autonomy.reason = _( "Equipment change canceled; belongings restored." );
        }
        has_new_items = true;
    } else if( plan.task == npc_autonomy_task::organize ) {
        if( plan.target && plan.target.held_by( *this ) && is_worn( *plan.target ) &&
            plan.source != plan.target &&
            plan.source.has_parent() && !plan.source.parent_pocket()->settings.was_edited() &&
            !plan.source.eventually_contains( plan.target ) &&
            !craft_reservation::contains_reserved( *plan.source ) &&
            !craft_reservation::contains_live_craft( *plan.source ) ) {
            item_location target = plan.target;
            auto pocket = target->best_pocket( *plan.source, target, &*plan.source, false, false,
                                              false, false, false );
            if( pocket.second && pocket.second != plan.source.parent_pocket() &&
                pocket.second->insert_item( *plan.source ).success() ) {
                target.on_contents_changed();
                plan.source.remove_item();
                autonomy.reason = _( "Moving essential supplies to an accessible pocket." );
            }
        }
    } else {
        refresh_autonomous_inventory( true );
        const int quantity = std::min( plan.quantity, spare_quantity( *this, *plan.source,
                                      plan.task == npc_autonomy_task::share ) );
        if( quantity > 0 ) {
            item part( *plan.source );
            if( part.count_by_charges() ) {
                part.charges = quantity;
            }
            if( plan.task == npc_autonomy_task::share && plan.recipient ) {
                for( npc &other : g->all_npcs() ) {
                    if( other.getID() != *plan.recipient || !other.is_player_ally() || other.is_dead() ||
                        other.in_vehicle || !other.is_safe() ||
                        !other.rules.has_flag( ally_rule::share_supplies ) ||
                        rl_dist( pos_bub(), other.pos_bub() ) > 1 || !sees( get_map(), other ) ) {
                        continue;
                    }
                    other.refresh_autonomous_inventory( true );
                    if( team_transfer_quantity( *this, other, part ) >= quantity &&
                        other.try_add( part, nullptr, nullptr, false ) ) {
                        remove_quantity( plan.source, quantity );
                        other.refresh_autonomous_inventory( true );
                        autonomy.reason = _( "Sharing surplus supplies with a nearby teammate." );
                    }
                    break;
                }
            } else if( plan.task == npc_autonomy_task::deposit ) {
                map &here = get_map();
                const tripoint_bub_ms p = here.get_bub( plan.destination );
                zone_manager &zones = zone_manager::get_manager();
                const zone_type_id type = zones.get_near_zone_type_for_item( part, pos_abs(), 1, fac_id );
                const auto destinations = type.is_null() ? std::unordered_set<tripoint_abs_ms>() :
                                          zones.get_near( type, pos_abs(), 1, &part, fac_id );
                if( destinations.count( plan.destination ) != 0 &&
                    !here.veh_at( p ) && rl_dist( pos_bub(), p ) <= 1 && here.can_put_items( p ) &&
                    !sees_dangerous_field( p ) && sees( here, p ) &&
                    !here.add_item_or_charges( p, part ).is_null() ) {
                    remove_quantity( plan.source, quantity );
                    autonomy.reason = _( "Leaving surplus supplies in an authorized storage zone." );
                }
            }
        }
    }
    plan = {};
    refresh_autonomous_inventory( true );
    return true;
}

item::reload_option npc::autonomous_reload_option( const item_location &base, bool combat )
{
    if( !base ) {
        return {};
    }
    std::vector<item::reload_option> options;
    list_ammo( base, options, false );
    item::reload_option best;
    for( item::reload_option &opt : options ) {
        // Planning and execution use the same carried, accessible ammunition.
        if( !opt || !accessible_source( *this, opt.ammo ) || opt.target->is_favorite ||
            !opt.target->is_owned_by( *this, true ) ||
            ( opt.ammo->is_magazine() &&
              opt.ammo->ammo_remaining() <= opt.target->ammo_remaining() ) ) {
            continue;
        }
        if( combat && opt.ammo->is_ammo() && opt.target->ammo_remaining() == 0 ) {
            opt.qty( std::min( opt.qty(), std::max( 1, base->ammo_required() ) ) );
        }
        const bool ready = opt.ammo->is_magazine() && opt.ammo->ammo_remaining() > 0;
        const bool best_ready = best && best.ammo->is_magazine() && best.ammo->ammo_remaining() > 0;
        if( !best || ( ready != best_ready ? ready : opt.moves() < best.moves() ) ) {
            best = opt;
        }
    }
    return best;
}

bool npc::autonomous_gun_readiness( const item_location &gun, item &prepared,
                                  int &move_cost, bool combat )
{
    move_cost = 0;
    if( !gun || !gun->is_gun() || !rules.has_flag( ally_rule::use_guns ) ||
        ( rules.has_flag( ally_rule::use_silent ) && !gun->is_silent() ) ) {
        return false;
    }
    prepared = *gun;
    if( prepared.ammo_sufficient( this ) ) {
        return true;
    }
    const item::reload_option opt = autonomous_reload_option( gun, combat );
    if( !opt || ( opt.target != gun && &*opt.target != gun->magazine_current() ) ||
        opt.ammo->ammo_current().is_null() ) {
        return false;
    }
    const int rounds = opt.ammo->is_magazine() ? opt.ammo->ammo_remaining() : opt.qty();
    // This copy only estimates readiness; native reload consumes the actual ammunition later.
    prepared.ammo_set( opt.ammo->ammo_current(), rounds );
    move_cost = std::max( 1, opt.moves() );
    return prepared.ammo_sufficient( this );
}

bool npc::autonomous_carried_weapon_step()
{
    if( !is_player_ally() || attitude != NPCATT_FOLLOW || activity || in_vehicle ||
        in_sleep_state() || sees_dangerous_field( pos_bub() ) ||
        rules.has_flag( ally_rule::forbid_engage ) ||
        rules.engagement == combat_engagement::NONE ) {
        return false;
    }
    const Creature *target = current_target();
    for( const auto &weak : ai_cache.hostile_guys ) {
        if( const auto enemy = weak.lock() ) {
            if( !enemy->is_dead_state() && enemy->posz() == posz() && sees( get_map(), *enemy ) &&
                ( !target || rl_dist( pos_bub(), enemy->pos_bub() ) <
                  rl_dist( pos_bub(), target->pos_bub() ) ) ) {
                target = enemy.get();
            }
        }
    }
    if( !target ) {
        return false;
    }
    const item_location held = get_wielded_item();
    if( held && ( held->is_favorite || !can_unwield( *held ).success() ||
                  craft_reservation::contains_reserved( *held ) ||
                  craft_reservation::contains_live_craft( *held ) ) ) {
        return false;
    }
    const int distance = rl_dist( pos_bub(), target->pos_bub() );
    const auto range = [this]( const item &weapon ) {
        return weapon.is_gun() && weapon.ammo_sufficient( this ) ?
               std::max( 1, confident_shoot_range( weapon,
                         most_accurate_aiming_method_limit( weapon ) ) ) :
               std::max( 1, weapon.reach_range( *this ).first );
    };
    cached_info.erase( "weapon_value" );
    const double current = npc_autonomy::combat_weapon_value(
                               evaluate_weapon( held ? *held : null_item_reference() ), distance,
                               held ? range( *held ) : 1, 0 );
    const auto locations = bounded_locations( *this );
    item_location best;
    double best_score = current * 1.15;
    for( const auto &entry : locations ) {
        const item_location &loc = entry.second;
        if( loc == held || ( calendar::turn < autonomy.failed_weapon_until &&
                             loc == autonomy.failed_weapon ) ||
            !loc->is_gun() || !loc->ammo_sufficient( this ) ||
            !accessible_source( *this, loc ) || !can_wield( *loc ).success() ||
            !rules.has_flag( ally_rule::use_guns ) ||
            ( rules.has_flag( ally_rule::use_silent ) && !loc->is_silent() ) ) {
            continue;
        }
        const int cost = loc.obtain_cost( *this ) + ( held ? item_handling_cost( *held ) : 0 );
        if( !autonomous_action_window( cost ) ) {
            continue;
        }
        const double score = npc_autonomy::combat_weapon_value( evaluate_weapon( *loc ),
                             distance, range( *loc ), cost );
        if( score > best_score ) {
            best = loc;
            best_score = score;
        }
    }
    if( !best ) {
        return false;
    }
    if( !wield( best ) ) {
        autonomy.failed_weapon = best;
        autonomy.failed_weapon_until = calendar::turn + 3_seconds;
        return false;
    }
    autonomy.weapon_goal = {};
    autonomy.reason = _( "正在换用随身携带、适合当前距离的枪械。" );
    autonomous_announce( "weapon", _( "我换上枪来掩护你。" ) );
    return true;
}

bool npc::autonomous_reload_step()
{
    if( !autonomous_maintenance_allowed() || !rules.has_flag( ally_rule::use_guns ) ||
        activity || in_sleep_state() || in_vehicle ||
        sees_dangerous_field( pos_bub() ) ) {
        return false;
    }
    const bool combat = !is_safe() || !ai_cache.hostile_guys.empty();
    if( combat && ( attitude != NPCATT_FOLLOW ||
                    rules.has_flag( ally_rule::forbid_engage ) ||
                    rules.engagement == combat_engagement::NONE ) ) {
        return false;
    }
    const auto locations = bounded_locations( *this );
    std::vector<item_location> guns;
    const item_location held = get_wielded_item();
    if( held && held->is_gun() && accessible_source( *this, held ) &&
        ( !rules.has_flag( ally_rule::use_silent ) || held->is_silent() ) ) {
        guns.push_back( held );
    }
    for( const auto &entry : locations ) {
        const item_location &loc = entry.second;
        if( loc != held && loc->is_gun() && accessible_source( *this, loc ) &&
            ( !rules.has_flag( ally_rule::use_silent ) || loc->is_silent() ) ) {
            guns.push_back( loc );
        }
    }
    std::vector<item_location> targets = guns;
    for( const auto &entry : locations ) {
        const item_location &loc = entry.second;
        if( loc->is_magazine() && accessible_source( *this, loc ) &&
            std::any_of( guns.begin(), guns.end(), [&loc]( const item_location &gun ) {
        return gun->can_reload_with( *loc, false );
        } ) ) {
            targets.push_back( loc );
        }
    }
    for( const item_location &base : targets ) {
        int required_rounds = std::max( 1, base->ammo_required() );
        if( combat && base->is_magazine() ) {
            required_rounds = 0;
            for( const item_location &gun : guns ) {
                if( gun->can_reload_with( *base, false ) ) {
                    const int required = std::max( 1, gun->ammo_required() );
                    required_rounds = required_rounds == 0 ? required : std::min( required_rounds, required );
                }
            }
            if( required_rounds == 0 ) {
                continue;
            }
        }
        if( combat && ( ( base->is_gun() && base->ammo_sufficient( this ) ) ||
                        ( base->is_magazine() && base->ammo_remaining() >= required_rounds ) ||
                        ( held && held->is_gun() && held->ammo_sufficient( this ) ) ) ) {
            continue;
        }
        item::reload_option opt = autonomous_reload_option( base, combat );
        if( !opt ) {
            continue;
        }
        if( combat && opt.ammo->is_ammo() ) {
            const int needed = std::max( 1, required_rounds - opt.target->ammo_remaining() );
            opt.qty( needed );
            if( opt.qty() + opt.target->ammo_remaining() < required_rounds ) {
                continue;
            }
        }
        const int cost = std::max( 1, opt.moves() );
        int followup_cost = 100 + ( held ? item_handling_cost( *held ) : 0 );
        if( base->is_gun() && base != held ) {
            followup_cost += base.obtain_cost( *this );
        }
        if( combat && base->is_magazine() ) {
            // A filled spare is not useful until it is inserted into a compatible gun.
            int insertion = -1;
            for( const item_location &gun : guns ) {
                if( gun->can_reload_with( *base, false ) ) {
                    const int moves = item_reload_cost( *gun, *base, 1 ) +
                                      ( gun == held ? 0 : gun.obtain_cost( *this ) );
                    insertion = insertion < 0 ? moves : std::min( insertion, moves );
                }
            }
            if( insertion < 0 ) {
                continue;
            }
            followup_cost += insertion;
        }
        if( combat && !autonomous_action_window( cost + followup_cost ) ) {
            continue;
        }
        autonomous_announce( "reload", _( "我先准备弹药，再掩护你。" ) );
        if( opt.target->reload( *this, opt.ammo, opt.qty(), opt.pocket_index ) ) {
            mod_moves( -cost );
            recoil = MAX_RECOIL;
            invalidate_range_cache();
            has_new_items = true;
            cached_info.erase( "weapon_value" );
            cached_info.erase( "reloadables" );
            refresh_autonomous_inventory( true );
            autonomy.reason = _( "正在利用敌人接近前的空隙准备弹药。" );
            return true;
        }
    }
    return false;
}

bool npc::autonomous_organize_step()
{
    if( calendar::turn - autonomy.pockets_checked <
        npc_autonomy::cadence( 1_minutes, getID().get_value() ) ) {
        return false;
    }
    autonomy.pockets_checked = calendar::turn;
    const auto locations = bounded_locations( *this );
    int examined = 0;
    visit_items( [this, &examined, &locations]( item *node, item * ) {
        if( ++examined > 128 ) {
            return VisitResponse::ABORT;
        }
        if( ( !node->is_ammo() && !node->get_use( "heal" ) ) || node->is_favorite || node->active ||
            node->is_dangerous() || craft_reservation::contains_reserved( *node ) ||
            craft_reservation::contains_live_craft( *node ) || !node->is_owned_by( *this, true ) ) {
            return VisitResponse::NEXT;
        }
        const auto location = locations.find( node );
        if( location == locations.end() ) {
            return VisitResponse::NEXT;
        }
        item_location source = location->second;
        if( !accessible_source( *this, source ) || !source.has_parent() ||
            !source.parent_pocket() || source.parent_pocket()->sealed() ||
            source.parent_pocket()->settings.was_edited() ) {
            return VisitResponse::NEXT;
        }
        const auto target = best_pocket( *node, node );
        if( !target.second || !is_worn( *target.first ) || target.second == source.parent_pocket() ||
            source.eventually_contains( target.first ) ) {
            return VisitResponse::NEXT;
        }
        const int old_cost = source.obtain_cost( *this );
        const int new_cost = item_handling_cost( *node, true, target.second->moves() );
        if( old_cost < new_cost + 50 ) {
            return VisitResponse::NEXT;
        }
        autonomy.plan = {};
        autonomy.plan.task = npc_autonomy_task::organize;
        autonomy.plan.source = source;
        autonomy.plan.target = target.first;
        autonomy.plan.target_required = true;
        autonomy.plan.work_required = std::max( 1, old_cost + target.first->insert_cost( *node ) );
        autonomy.plan.expires = calendar::turn + 5_minutes;
        return VisitResponse::ABORT;
    } );
    return autonomous_continue_plan();
}

bool npc::autonomous_supply_step()
{
    if( !is_player_ally() || attitude != NPCATT_FOLLOW || !is_safe() || in_vehicle ||
        activity || in_sleep_state() || sees_dangerous_field( pos_bub() ) ||
        calendar::turn - autonomy.supplies_checked <
        npc_autonomy::cadence( 10_seconds, getID().get_value() ) ) {
        return false;
    }
    autonomy.supplies_checked = calendar::turn;
    std::vector<npc *> recipients;
    for( npc &other : g->all_npcs() ) {
        if( rules.has_flag( ally_rule::share_supplies ) &&
            &other != this && other.is_player_ally() && !other.is_dead() && !other.in_vehicle &&
            other.is_safe() && other.rules.has_flag( ally_rule::share_supplies ) &&
            rl_dist( pos_bub(), other.pos_bub() ) <= 3 && sees( get_map(), other ) ) {
            other.refresh_autonomous_inventory();
            recipients.push_back( &other );
        }
    }
    const auto locations = bounded_locations( *this );
    int examined = 0;
    visit_items( [this, &recipients, &examined, &locations]( item *node, item * ) {
        if( ++examined > 128 ) {
            return VisitResponse::ABORT;
        }
        if( is_worn( *node ) || ( get_wielded_item() && &*get_wielded_item() == node ) ||
            !node->made_of_from_type( phase_id::SOLID ) || !node->empty_container() ) {
            return VisitResponse::NEXT;
        }
        const int spare = spare_quantity( *this, *node, true );
        if( spare <= 0 ) {
            return VisitResponse::NEXT;
        }
        item part( *node );
        if( part.count_by_charges() ) {
            part.charges = spare;
        }
        const auto location = locations.find( node );
        if( location == locations.end() ) {
            return VisitResponse::NEXT;
        }
        item_location source = location->second;
        if( !accessible_source( *this, source ) ) {
            return VisitResponse::NEXT;
        }
        const auto urgency = [&part]( npc &other ) {
            if( part.get_use( "heal" ) ) {
                return other.autonomous_care_priority( other ) +
                       ( other.autonomy.healing_units == 0 ? 100 : 0 );
            }
            if( part.is_food() ) {
                const int thirst = part.get_comestible()->quench > 0 ? other.get_thirst() : 0;
                const int hunger = other.compute_effective_nutrients( part ).kcal() > 0 ?
                                   other.get_hunger() : 0;
                return std::max( thirst, hunger );
            }
            return part.is_ammo() && other.autonomy.ammunition[part.ammo_type()] == 0 ? 100 : 0;
        };
        std::stable_sort( recipients.begin(), recipients.end(), [&urgency]( npc *a, npc *b ) {
            return urgency( *a ) > urgency( *b );
        } );
        for( npc *other : recipients ) {
            const int need = team_transfer_quantity( *this, *other, part );
            if( need <= 0 ) {
                continue;
            }
            item transfer( part );
            if( transfer.count_by_charges() ) {
                transfer.charges = need;
            }
            if( !other->can_add( transfer, nullptr, false ) ) {
                continue;
            }
            autonomy.plan = {};
            autonomy.plan.task = npc_autonomy_task::share;
            autonomy.plan.source = source;
            autonomy.plan.recipient = other->getID();
            autonomy.plan.quantity = need;
            autonomy.plan.work_required = std::max( 1, source.obtain_cost( *this, need ) +
                                                  other->item_handling_cost( transfer ) );
            autonomy.plan.expires = calendar::turn + 1_minutes;
            return VisitResponse::ABORT;
        }
        const int deposit_quantity = spare_quantity( *this, *node );
        if( deposit_quantity <= 0 ) {
            return VisitResponse::NEXT;
        }
        if( part.count_by_charges() ) {
            part.charges = deposit_quantity;
        }
        zone_manager &zones = zone_manager::get_manager();
        const zone_type_id type = zones.get_near_zone_type_for_item( part, pos_abs(), 1, fac_id );
        if( type.is_null() ) {
            return VisitResponse::NEXT;
        }
        const auto destinations = zones.get_near( type, pos_abs(), 1, &part, fac_id );
        for( const tripoint_bub_ms &p : get_map().points_in_radius( pos_bub(), 1 ) ) {
            if( destinations.count( get_map().get_abs( p ) ) == 0 || get_map().veh_at( p ) ||
                !get_map().can_put_items( p ) || sees_dangerous_field( p ) || !sees( get_map(), p ) ) {
                continue;
            }
            autonomy.plan = {};
            autonomy.plan.task = npc_autonomy_task::deposit;
            autonomy.plan.source = source;
            autonomy.plan.destination = get_map().get_abs( p );
            autonomy.plan.quantity = deposit_quantity;
            autonomy.plan.work_required = std::max( 1, source.obtain_cost( *this, deposit_quantity ) +
                                                  item_handling_cost( part ) );
            autonomy.plan.expires = calendar::turn + 1_minutes;
            return VisitResponse::ABORT;
        }
        return VisitResponse::NEXT;
    } );
    return autonomous_continue_plan();
}
