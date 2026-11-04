#include "npc.h"

#include <algorithm>
#include <cmath>
#include <limits>
#include <vector>

#include "avatar.h"
#include "activity_type.h"
#include "bodypart.h"
#include "character_attire.h"
#include "craft_reservation.h"
#include "game.h"
#include "flag.h"
#include "field_type.h"
#include "stomach.h"
#include "itype.h"
#include "map.h"
#include "mapdata.h"
#include "map_selector.h"
#include "monster.h"
#include "pocket_type.h"
#include "mtype.h"
#include "ret_val.h"
#include "translations.h"
#include "units.h"
#include "visitable.h"

namespace
{
static const json_character_flag json_flag_CANNOT_MOVE( "CANNOT_MOVE" );

int units_of( const item &it )
{
    return it.count_by_charges() ? std::max( 0, it.charges ) : 1;
}

bool same_slot( const npc &who, const item &a, const item &b )
{
    if( a.get_layer() != b.get_layer() ) {
        return false;
    }
    for( const bodypart_id &bp : who.get_all_body_parts() ) {
        if( a.covers( bp ) && b.covers( bp ) ) {
            return true;
        }
    }
    return false;
}
}

double npc::autonomous_decision_score( const std::string &action, double urgency,
                                      int move_cost, double risk ) const
{
    const auto failed = autonomy.failed_actions.find( action );
    if( failed != autonomy.failed_actions.end() && calendar::turn < failed->second ) {
        return -1.0;
    }
    const auto serviced = autonomy.serviced_actions.find( action );
    const int waiting = serviced == autonomy.serviced_actions.end() ? 30 :
                        to_seconds<int>( calendar::turn - serviced->second );
    return npc_autonomy::action_score( urgency, move_cost, risk,
                                      autonomy.decision == action && calendar::turn < autonomy.decision_until,
                                      waiting );
}

void npc::autonomous_decision_result( const std::string &action, bool succeeded )
{
    if( succeeded ) {
        autonomy.failed_actions.erase( action );
        autonomy.serviced_actions[action] = calendar::turn;
        autonomy.decision = action;
        autonomy.decision_until = calendar::turn + 3_seconds;
    } else {
        autonomy.failed_actions[action] = calendar::turn + 3_seconds;
        if( autonomy.decision == action ) {
            autonomy.decision.clear();
        }
    }
}

int npc::autonomous_reserved_damage( const Creature &target ) const
{
    if( !is_player_ally() ) {
        return 0;
    }
    int damage = 0;
    for( const auto &weak : ai_cache.friends ) {
        const auto person = weak.lock();
        const npc *other = person ? dynamic_cast<const npc *>( person.get() ) : nullptr;
        if( !other || other == this || !other->is_player_ally() || other->is_dead_state() ||
            other->in_sleep_state() || other->autonomy.attack_until <= calendar::turn ||
            other->autonomy.recovering_until > calendar::turn ||
            other->autonomy.withdrawing_until > calendar::turn ) {
            continue;
        }
        const auto reserved = other->autonomy.attack_target.lock();
        if( reserved.get() == &target && sees( get_map(), *other ) ) {
            damage += std::clamp( other->autonomy.committed_damage, 0, std::max( 1, target.get_hp() ) );
            if( damage >= target.get_hp() ) {
                break;
            }
        }
    }
    return damage;
}

void npc::autonomous_reserve_attack( const Creature &target, int damage )
{
    autonomy.attack_target = g->shared_from<Creature>( target );
    autonomy.committed_damage = std::max( 0, damage );
    autonomy.attack_until = calendar::turn + 1_seconds;
}

bool npc::autonomous_position_reserved( const tripoint_abs_ms &position, bool seat ) const
{
    if( !is_player_ally() ) {
        return false;
    }
    for( const npc &other : g->all_npcs() ) {
        if( &other == this || !other.is_player_ally() || other.is_dead_state() ||
            other.in_sleep_state() || other.attitude != NPCATT_FOLLOW ) {
            continue;
        }
        const auto &goal = seat ? other.autonomy.seat_goal : other.autonomy.tactical_goal;
        const time_point until = seat ? other.autonomy.seat_until : other.autonomy.position_until;
        if( goal && *goal == position && until > calendar::turn && sees( get_map(), other ) ) {
            return true;
        }
    }
    return false;
}

void npc::refresh_autonomous_inventory( bool force )
{
    if( !force && autonomy.inventory_checked != calendar::before_time_starts &&
        calendar::turn >= autonomy.inventory_checked &&
        calendar::turn - autonomy.inventory_checked <
        npc_autonomy::cadence( 30_seconds, getID().get_value() ) ) {
        return;
    }
    autonomy.inventory_checked = calendar::turn;
    autonomy.quantities.clear();
    autonomy.tool_qualities.clear();
    autonomy.ammunition.clear();
    autonomy.ammo_targets.clear();
    autonomy.food_kcal = 0;
    autonomy.water_quench = 0;
    autonomy.healing_units = 0;
    const bool expedition = is_travelling() || ( assigned_camp &&
                            rl_dist( pos_abs_omt(), *assigned_camp ) > 6 );
    autonomy.food_target = npc_autonomy::expedition_stock( std::clamp( get_bmr(), 1200, 6000 ),
                           expedition );
    autonomy.water_target = npc_autonomy::expedition_stock( 240, expedition );
    autonomy.healing_target = hp_percentage() < 60 ? 8 : expedition ? 8 : 6;
    autonomy.magazine_target = expedition ? 3 : 2;
    autonomy.air_hazard = false;
    const map &here = get_map();
    for( const tripoint_bub_ms &p : here.points_in_radius( pos_bub(), 4 ) ) {
        if( here.inbounds( p ) && sees( here, p ) &&
            ( here.get_field_intensity( p, fd_smoke.id() ) > 0 ||
              here.get_field_intensity( p, fd_toxic_gas.id() ) > 0 ||
              here.get_field_intensity( p, fd_tear_gas.id() ) > 0 ) ) {
            autonomy.air_hazard = true;
            break;
        }
    }
    visit_items( [this]( item *node, item * ) {
        const int count = units_of( *node );
        autonomy.quantities[node->typeId()] += count;
        for( const auto &quality : node->type->qualities ) {
            autonomy.tool_qualities[quality.first] = std::max( autonomy.tool_qualities[quality.first],
                    node->get_quality_nonrecursive( quality.first ) );
        }
        for( const auto &quality : node->type->charged_qualities ) {
            autonomy.tool_qualities[quality.first] = std::max( autonomy.tool_qualities[quality.first],
                    node->get_quality_nonrecursive( quality.first ) );
        }
        if( node->get_use( "heal" ) ) {
            autonomy.healing_units += std::min( count, 100 );
        } else if( node->is_food() && will_eat( *node ).success() ) {
            autonomy.food_kcal += std::min( count, 10000 ) *
                                  std::max( 0, compute_effective_nutrients( *node ).kcal() );
            autonomy.water_quench += std::min( count, 10000 ) *
                                     std::max( 0, node->get_comestible()->quench );
        }
        if( node->is_ammo() ) {
            autonomy.ammunition[node->ammo_type()] += count;
        }
        // visit_items only descends into CONTAINER pockets, not loaded ammunition or wells.
        const auto count_loaded = [this]( const item &holder ) {
            for( const item *rounds : holder.all_items_top( pocket_type::MAGAZINE ) ) {
                if( rounds->is_ammo() ) {
                    autonomy.ammunition[rounds->ammo_type()] += units_of( *rounds );
                }
            }
        };
        count_loaded( *node );
        for( const item *mag : node->all_items_top( pocket_type::MAGAZINE_WELL ) ) {
            if( mag->is_magazine() ) {
                ++autonomy.quantities[mag->typeId()];
                count_loaded( *mag );
            }
        }
        if( node->is_gun() ) {
            for( const ammotype &ammo : node->ammo_types() ) {
                const int capacity = node->ammo_capacity( ammo );
                autonomy.ammo_targets[ammo] = std::max( autonomy.ammo_targets[ammo],
                                             std::clamp( capacity * ( autonomy.magazine_target + 1 ), 30,
                                                     autonomy.magazine_target == 3 ? 360 : 180 ) );
            }
        }
        return VisitResponse::NEXT;
    } );
    ai_cache.searched_tiles.clear();
}

int npc::autonomous_pickup_quantity( const item &it )
{
    refresh_autonomous_inventory();
    if( it.is_dangerous() || it.is_corpse() || it.is_filthy() || it.is_medication() ||
        craft_reservation::contains_reserved( it ) || craft_reservation::contains_live_craft( it ) ) {
        // Healing consumables below are explicitly recognized, not arbitrary drugs.
        if( !it.get_use( "heal" ) || it.is_dangerous() || it.is_filthy() ||
            craft_reservation::contains_reserved( it ) || craft_reservation::contains_live_craft( it ) ) {
            return 0;
        }
    }
    if( it.get_use( "heal" ) ) {
        return std::min( units_of( it ), npc_autonomy::missing_units( autonomy.healing_units, autonomy.healing_target ) );
    }
    if( it.is_food() ) {
        if( !will_eat( it ).success() ) {
            return 0;
        }
        const int food = npc_autonomy::missing_units( autonomy.food_kcal, autonomy.food_target,
                         compute_effective_nutrients( it ).kcal() );
        const int water = npc_autonomy::missing_units( autonomy.water_quench, autonomy.water_target,
                          it.get_comestible()->quench );
        return std::min( units_of( it ), std::max( food, water ) );
    }
    if( it.is_ammo() ) {
        const auto target = autonomy.ammo_targets.find( it.ammo_type() );
        if( target == autonomy.ammo_targets.end() ) {
            return 0;
        }
        return std::min( units_of( it ), npc_autonomy::missing_units(
                             autonomy.ammunition[it.ammo_type()], target->second ) );
    }
    if( it.is_magazine() ) {
        bool needed = false;
        visit_items( [this, &it, &needed]( item *node, item * ) {
            if( !node->is_gun() || !node->can_reload_with( it, false ) ) {
                return VisitResponse::NEXT;
            }
            int compatible = 0;
            for( const itype_id &type : node->magazine_compatible() ) {
                compatible += autonomy.quantities[type];
            }
            needed = compatible < autonomy.magazine_target;
            return needed ? VisitResponse::ABORT : VisitResponse::NEXT;
        } );
        return needed ? 1 : 0;
    }
    // A second bottle can be useful even if an empty bottle of its type is already carried.
    if( !it.is_armor() ) {
        for( const item *content : it.all_items_top() ) {
            if( ( content->is_food() || content->is_ammo() || content->get_use( "heal" ) ) &&
                autonomous_pickup_quantity( *content ) > 0 ) {
                return 1;
            }
        }
    }
    if( it.is_armor() && !it.is_pet_armor() && !it.is_power_armor() ) {
        const double score = autonomous_armor_score( it );
        double existing = 0;
        int worn_copies = 0;
        for( const item_location &old_loc : worn.top_items_loc( *this ) ) {
            const item &old = *old_loc;
            worn_copies += old.typeId() == it.typeId() ? 1 : 0;
            if( same_slot( *this, old, it ) ) {
                existing += std::max( 0.0, autonomous_armor_score( old ) );
            }
        }
        return autonomy.quantities[it.typeId()] <= worn_copies &&
               npc_autonomy::worthwhile_upgrade( existing, score ) &&
               can_wear( it, true ).success() ? 1 : 0;
    }
    if( it.is_melee() || it.is_gun() ) {
        const item_location weapon = get_wielded_item();
        const double current = weapon ? evaluate_weapon( *weapon ) :
                               evaluate_weapon( null_item_reference() );
        return npc_autonomy::worthwhile_upgrade( current, evaluate_weapon( it ) ) &&
               can_wield( it ).success() ? 1 : 0;
    }
    if( autonomy.quantities[it.typeId()] > 0 ) {
        return 0;
    }
    if( it.is_tool() && !it.type->qualities.empty() ) {
        for( const auto &quality : it.type->qualities ) {
            if( autonomy.tool_qualities[quality.first] < it.get_quality_nonrecursive( quality.first ) ) {
                return 1;
            }
        }
    }
    return 0;
}

double npc::autonomous_item_score( const item &it )
{
    if( autonomous_pickup_quantity( it ) <= 0 ) {
        return 0;
    }
    double priority = 40;
    if( it.get_use( "heal" ) ) {
        priority = autonomy.healing_units == 0 ? 100 : 60;
    } else if( it.is_food() ) {
        priority = it.get_comestible()->quench > 0 && autonomy.water_quench == 0 ? 110 : 70;
    } else if( it.is_ammo() || it.is_magazine() ) {
        priority = 80;
    } else if( it.is_armor() ) {
        priority = 50 + std::min( 30.0, autonomous_armor_score( it ) );
    }
    return priority;
}

double npc::autonomous_armor_score( const item &it ) const
{
    if( !it.is_armor() || it.is_pet_armor() || it.is_power_armor() || it.is_dangerous() ) {
        return -1000;
    }
    static const damage_type_id bash( "bash" );
    static const damage_type_id cut( "cut" );
    static const damage_type_id bullet( "bullet" );
    bool ranged_threat = false;
    if( const Creature *enemy = current_target() ) {
        if( const Character *person = enemy->as_character() ) {
            const item_location enemy_weapon = person->get_wielded_item();
            ranged_threat = enemy_weapon && enemy_weapon->is_gun();
        } else if( const monster *mon = dynamic_cast<const monster *>( enemy ) ) {
            ranged_threat = mon->has_flag( mon_flag_RANGED_ATTACKER );
        }
    }
    double protection = 0;
    double warmth = 0;
    double coverage_value = 0;
    for( const bodypart_id &bp : get_all_body_parts( get_body_part_flags::only_main ) ) {
        if( !it.covers( bp ) ) {
            continue;
        }
        const double coverage = it.get_coverage( bp ) / 100.0;
        coverage_value += coverage * 2;
        protection += coverage * ( it.resist( bash, false, bp ) +
                                   it.resist( cut, false, bp ) +
                                   it.resist( bullet, false, bp ) * ( ranged_threat ? 2.0 : 1.0 ) );
        const auto temperature = get_part_temp_conv( bp );
        if( temperature < BODYTEMP_COLD ) {
            warmth += coverage * it.get_warmth( bp ) * 0.4;
        } else if( temperature > BODYTEMP_HOT ) {
            warmth -= coverage * it.get_warmth( bp ) * 0.5;
        }
    }
    const double storage = std::min( 12.0, units::to_milliliter( it.get_volume_capacity() ) / 1000.0 );
    const double environmental = autonomy.air_hazard ? it.get_env_resist() * 3.0 : 0.0;
    const double mobility = get_stamina() < get_stamina_max() / 3 ? 1.2 : 0.8;
    return coverage_value + protection * 0.6 + warmth + storage + environmental -
           it.get_avg_encumber( *this ) * mobility -
           units::to_gram( it.weight() ) / 1500.0 - it.damage_level() * 2.0;
}

bool npc::autonomous_action_window( int move_cost, int approach_tiles ) const
{
    const auto safe_from = [this, move_cost, approach_tiles]( const Creature &enemy ) {
        if( const monster *mon = dynamic_cast<const monster *>( &enemy ) ) {
            if( mon->has_flag( mon_flag_RANGED_ATTACKER ) &&
                get_map().sees( enemy.pos_bub(), pos_bub(), -1 ) ) {
                return false;
            }
        }
        if( const Character *person = enemy.as_character() ) {
            const item_location weapon = person->get_wielded_item();
            if( weapon && weapon->is_gun() && weapon->has_ammo() &&
                get_map().sees( enemy.pos_bub(), pos_bub(), weapon->gun_range( person ) ) ) {
                return false;
            }
        }
        return npc_autonomy::action_window( rl_dist( pos_bub(), enemy.pos_bub() ) - approach_tiles,
                                           get_speed(), enemy.get_speed(), move_cost );
    };
    if( current_target() && !safe_from( *current_target() ) ) {
        return false;
    }
    for( const auto &enemy_ref : ai_cache.hostile_guys ) {
        if( const auto enemy = enemy_ref.lock() ) {
            if( !safe_from( *enemy ) ) {
                return false;
            }
        }
    }
    return true;
}

bool npc::autonomous_patient_reserved( const Character &patient ) const
{
    static const activity_id firstaid( "ACT_FIRSTAID" );
    for( const npc &other : g->all_npcs() ) {
        if( &other != this && !other.is_dead_state() && other.is_player_ally() &&
            other.autonomy.rescue_patient &&
            *other.autonomy.rescue_patient == patient.getID() && sees( get_map(), other ) &&
            ( calendar::turn < other.autonomy.rescue_until ||
              other.Character::has_activity( firstaid ) ) ) {
            return true;
        }
    }
    return false;
}

bool npc::autonomous_patient_route( const Character &patient )
{
    map &here = get_map();
    if( patient.is_dead_state() || patient.in_vehicle || patient.posz() != posz() ||
        !sees( here, patient ) || sees_dangerous_field( patient.pos_bub() ) ||
        is_no_go_position( patient.pos_abs() ) ) {
        return false;
    }
    if( rl_dist( pos_bub(), patient.pos_bub() ) <= 1 ) {
        path.clear();
        return true;
    }
    if( has_flag( json_flag_CANNOT_MOVE ) || rules.has_flag( ally_rule::hold_the_line ) ||
        rules.engagement == combat_engagement::NO_MOVE ||
        rules.engagement == combat_engagement::FREE_FIRE ) {
        return false;
    }
    const auto safe_route = [&]() {
        return !path.empty() && rl_dist( path.back(), patient.pos_bub() ) == 1 &&
               std::all_of( path.begin(), path.end(), [this, &here]( const auto &p ) {
            return here.inbounds( p ) && !sees_dangerous_field( p ) &&
                   !is_no_go_position( here.get_abs( p ) );
        } );
    };
    if( safe_route() && g->is_empty( path.front() ) ) {
        return true;
    }
    const auto previous_path = path;
    std::vector<tripoint_bub_ms> candidates;
    for( const tripoint_bub_ms &p : here.points_in_radius( patient.pos_bub(), 1 ) ) {
        if( p != patient.pos_bub() && g->is_empty( p ) && could_move_onto( p ) &&
            !sees_dangerous_field( p ) && !is_no_go_position( here.get_abs( p ) ) ) {
            candidates.push_back( p );
        }
    }
    std::stable_sort( candidates.begin(), candidates.end(), [this]( const auto &a, const auto &b ) {
        return rl_dist( pos_bub(), a ) < rl_dist( pos_bub(), b );
    } );
    for( const tripoint_bub_ms &destination : candidates ) {
        if( update_path( destination, true ) && safe_route() ) {
            return true;
        }
    }
    path = previous_path;
    return false;
}

bool npc::autonomous_target_reserved( const item &it ) const
{
    for( const npc &other : g->all_npcs() ) {
        if( &other != this && !other.is_dead() && other.is_player_ally() &&
            ( ( other.fetching_item && other.wanted_item && &*other.wanted_item == &it ) ||
              ( calendar::turn < other.autonomy.weapon_goal_until &&
                other.autonomy.weapon_goal && &*other.autonomy.weapon_goal == &it ) ) &&
            sees( get_map(), other ) ) {
            return true;
        }
    }
    return false;
}

bool npc::autonomous_equipment_step()
{
    if( !is_player_ally() || !is_safe() || in_vehicle || activity || in_sleep_state() ) {
        return false;
    }
    int inventory_size = 0;
    visit_items( [&inventory_size]( const item *, const item * ) {
        return ++inventory_size > 512 ? VisitResponse::ABORT : VisitResponse::NEXT;
    } );
    if( inventory_size > 512 ) {
        return false;
    }
    std::map<const item *, item_location> locations;
    for( item_location loc : all_items_loc() ) {
        locations.emplace( &*loc, loc );
    }
    item_location best;
    item_location replace;
    double best_gain = 3;
    int evaluated = 0;
    int skipped = 0;
    visit_items( [this, &best, &replace, &best_gain, &evaluated, &skipped, &locations]( item *node, item * ) {
        if( is_worn( *node ) || node->is_favorite || node->is_filthy() || !node->is_armor() ||
            craft_reservation::contains_reserved( *node ) || !node->is_owned_by( *this, true ) ) {
            return VisitResponse::NEXT;
        }
        if( skipped++ < autonomy.equipment_cursor ) {
            return VisitResponse::NEXT;
        }
        if( ++evaluated > 24 ) {
            return VisitResponse::ABORT;
        }
        if( !can_wear( *node, true ).success() ) {
            return VisitResponse::NEXT;
        }
        double old_score = 0;
        item_location old_location;
        int conflicts = 0;
        for( const item_location &old_loc : worn.top_items_loc( *this ) ) {
            const item &old = *old_loc;
            if( same_slot( *this, old, *node ) ) {
                ++conflicts;
                old_score += std::max( 0.0, autonomous_armor_score( old ) );
                old_location = item_location( *this, const_cast<item *>( &old ) );
            }
        }
        const double score = autonomous_armor_score( *node ) -
                             autonomous_outfit_penalty( *node, old_location ? &*old_location : nullptr );
        if( !npc_autonomy::worthwhile_upgrade( old_score, score ) || score - old_score <= best_gain ) {
            return VisitResponse::NEXT;
        }
        // The equipment plan dry-runs content migration before detaching anything.
        if( conflicts > 1 || ( old_location && ( old_location->is_favorite ||
                old_location->has_flag( flag_id( "SPLINT" ) ) ||
                craft_reservation::contains_reserved( *old_location ) ||
                !can_takeoff( *old_location ).success() ) ) ) {
            return VisitResponse::NEXT;
        }
        if( old_location ) {
            for( const bodypart_id &bp : get_all_body_parts( get_body_part_flags::only_main ) ) {
                if( old_location->get_coverage( bp ) > node->get_coverage( bp ) + 10 ) {
                    return VisitResponse::NEXT;
                }
            }
            if( old_location->get_env_resist() >= 10 &&
                node->get_env_resist() < old_location->get_env_resist() ) {
                return VisitResponse::NEXT;
            }
        }
        const auto location = locations.find( node );
        if( location == locations.end() ) {
            return VisitResponse::NEXT;
        }
        best = location->second;
        replace = old_location;
        best_gain = score - old_score;
        return VisitResponse::NEXT;
    } );
    autonomy.equipment_cursor = evaluated > 24 ? autonomy.equipment_cursor + 24 : 0;
    if( !best ) {
        return false;
    }
    autonomy.equipment_cursor = 0;
    return autonomous_plan_equipment( best, replace );
}

bool npc::autonomous_weapon_step()
{
    Character &leader = get_player_character();
    if( !is_player_ally() || attitude != NPCATT_FOLLOW || in_vehicle || leader.in_vehicle ||
        activity || in_sleep_state() || !rules.has_flag( ally_rule::allow_pick_up ) ||
        !sees( get_map(), leader ) || rl_dist( pos_bub(), leader.pos_bub() ) > 4 ) {
        return false;
    }
    map &here = get_map();
    if( sees_dangerous_field( pos_bub() ) ) {
        return false;
    }
    if( rules.has_flag( ally_rule::forbid_engage ) ||
        rules.engagement == combat_engagement::NONE ) {
        return false;
    }
    const bool may_move = !has_flag( json_flag_CANNOT_MOVE ) &&
                          !rules.has_flag( ally_rule::hold_the_line ) &&
                          rules.engagement != combat_engagement::NO_MOVE &&
                          rules.engagement != combat_engagement::FREE_FIRE;
    const int radius = may_move ? 3 : 1;
    const item_location held = get_wielded_item();
    if( held && ( held->is_favorite || !can_unwield( *held ).success() ||
                  craft_reservation::contains_reserved( *held ) ||
                  craft_reservation::contains_live_craft( *held ) ) ) {
        autonomy.weapon_goal = {};
        return false;
    }
    // Rule changes must not reuse an evaluation made with different weapon permissions.
    cached_info.erase( "weapon_value" );
    const double current = evaluate_weapon( held ? *held : null_item_reference() );
    const Creature *target = current_target();
    if( !target ) {
        for( const auto &weak : ai_cache.hostile_guys ) {
            if( const auto enemy = weak.lock() ) {
                if( enemy->posz() == posz() && !enemy->is_dead_state() && sees( here, *enemy ) &&
                    ( !target || rl_dist( pos_bub(), enemy->pos_bub() ) <
                      rl_dist( pos_bub(), target->pos_bub() ) ) ) {
                    target = enemy.get();
                }
            }
        }
    }
    const auto usable_range = [this]( const item &weapon ) {
        if( weapon.is_gun() && weapon.ammo_sufficient( this ) &&
            rules.has_flag( ally_rule::use_guns ) &&
            ( !rules.has_flag( ally_rule::use_silent ) || weapon.is_silent() ) ) {
            return std::max( 1, std::min( weapon.gun_range( this ),
                                        confident_shoot_range( weapon,
                                                most_accurate_aiming_method_limit( weapon ) ) ) );
        }
        return std::max( 1, weapon.reach_range( *this ).first );
    };
    const int target_distance = target ? rl_dist( pos_bub(), target->pos_bub() ) : 0;
    const double current_combat = npc_autonomy::combat_weapon_value( current, target_distance,
                                  held ? usable_range( *held ) : 1, 0 );
    item_location best;
    double best_score = 0;
    int examined = 0;
    static const zone_type_id no_pickup( "NO_NPC_PICKUP" );
    for( const tripoint_bub_ms &p : closest_points_first( pos_bub(), radius ) ) {
        if( rl_dist( p, leader.pos_bub() ) > 4 || !here.accessible_items( p ) ||
            !here.sees_some_items( p, *this ) || !sees( here, p ) ||
            sees_dangerous_field( p ) || is_no_go_position( here.get_abs( p ) ) ||
            g->check_zone( no_pickup, p ) ||
            ( p != pos_bub() && !here.clear_path( pos_bub(), p, radius, 1, 100 ) ) ) {
            continue;
        }
        for( item &candidate : here.i_at( p ) ) {
            if( ++examined > 64 ) {
                break;
            }
            if( ( !candidate.is_gun() && !candidate.is_melee() ) || candidate.active ||
                candidate.is_dangerous() || candidate.is_favorite ||
                craft_reservation::contains_reserved( candidate ) ||
                craft_reservation::contains_live_craft( candidate ) ||
                autonomous_target_reserved( candidate ) || !would_take_that( candidate, p ) ||
                !can_wield( candidate ).success() ) {
                continue;
            }
            item_location location( map_cursor( p ), &candidate );
            if( calendar::turn < autonomy.failed_weapon_until && location == autonomy.failed_weapon ) {
                continue;
            }
            item prepared;
            int reload_cost = 0;
            const bool ready_gun = candidate.is_gun() &&
                                   autonomous_gun_readiness( location, prepared, reload_cost, target != nullptr );
            const item &evaluated = ready_gun ? prepared : candidate;
            const double value = evaluate_weapon( evaluated );
            const int approach = std::max( 0, rl_dist( pos_bub(), p ) - 1 );
            const int cost = location.obtain_cost( *this ) + approach * 200 + reload_cost +
                             ( held ? item_handling_cost( *held ) : 0 );
            if( target && !autonomous_action_window( cost, approach ) ) {
                continue;
            }
            double score = value - current - rl_dist( pos_bub(), p ) * 2.0;
            if( target ) {
                const int range = usable_range( evaluated );
                // Do not value shooting through a wall as an immediate ranged opportunity.
                if( range > 1 && candidate.is_gun() &&
                    !here.sees( p, target->pos_bub(), -1 ) ) {
                    continue;
                }
                const double opportunity = npc_autonomy::combat_weapon_value( value,
                                           rl_dist( p, target->pos_bub() ), range, cost );
                if( opportunity <= current_combat * 1.15 || opportunity <= 0.0 ) {
                    continue;
                }
                score = opportunity - current_combat;
            } else if( !npc_autonomy::worthwhile_upgrade( current, value ) ) {
                continue;
            }
            if( calendar::turn < autonomy.weapon_goal_until && location == autonomy.weapon_goal ) {
                score *= 1.05;
            }
            if( score > best_score ) {
                best = location;
                best_score = score;
            }
        }
        if( examined > 64 ) {
            break;
        }
    }
    if( !best ) {
        autonomy.weapon_goal = {};
        return false;
    }
    const auto failed = [&]() {
        autonomy.failed_weapon = best;
        autonomy.failed_weapon_until = calendar::turn + 3_seconds;
        autonomy.weapon_goal = {};
        return false;
    };
    const tripoint_bub_ms destination = best.pos_bub( here );
    if( rl_dist( pos_bub(), destination ) > 1 ) {
        const auto previous_path = path;
        if( !may_move || !update_path( destination, true ) || path.empty() || path.size() > 6 ||
            std::any_of( path.begin(), path.end(), [this]( const tripoint_bub_ms &p ) {
                return sees_dangerous_field( p ) || is_no_go_position( get_map().get_abs( p ) );
            } ) ) {
            path = previous_path;
            return failed();
        }
        item prepared;
        int reload_cost = 0;
        autonomous_gun_readiness( best, prepared, reload_cost, target != nullptr );
        if( target && !autonomous_action_window( best.obtain_cost( *this ) + reload_cost +
                static_cast<int>( path.size() ) * 200 +
                ( held ? item_handling_cost( *held ) : 0 ), static_cast<int>( path.size() ) ) ) {
            path = previous_path;
            return failed();
        }
        autonomy.weapon_goal = best;
        autonomy.weapon_goal_until = calendar::turn + 3_seconds;
        autonomy.reason = _( "正在靠近能应对当前敌人的武器。" );
        autonomous_announce( "weapon", _( "我去拿那把武器，掩护我一下。" ) );
        move_to_next();
        return true;
    }
    // Use the native ground-to-hand transfer: no backpack slot or copied loot stack is needed.
    autonomous_announce( "weapon", _( "我去拿那把武器，掩护我一下。" ) );
    if( !wield( best ) ) {
        return failed();
    }
    autonomy.weapon_goal = {};
    autonomy.reason = _( "正在装备附近更适合当前战斗的武器。" );
    has_new_items = true;
    fetching_item = false;
    wanted_item = {};
    refresh_autonomous_inventory( true );
    return true;
}

int npc::autonomous_care_priority( const Character &patient )
{
    const healing_options need = patient_assessment( patient );
    if( !need.any_true() ) {
        return 0;
    }
    int lowest_hp = 100;
    for( const bodypart_id &part : patient.get_all_body_parts( get_body_part_flags::only_main ) ) {
        const int maximum = patient.get_part_hp_max( part );
        if( maximum > 0 ) {
            lowest_hp = std::min( lowest_hp, patient.get_part_hp_cur( part ) * 100 / maximum );
        }
    }
    return npc_autonomy::care_priority( lowest_hp, need.bleed, need.infect, need.bite );
}

Character *npc::autonomous_triage_patient()
{
    if( !is_player_ally() || attitude != NPCATT_FOLLOW || in_vehicle || activity ||
        in_sleep_state() || !is_safe() ) {
        return nullptr;
    }
    Character *best = nullptr;
    int best_score = 0;
    healing_options best_options;
    best_options.clear_all();
    const auto consider = [&]( Character &patient ) {
        if( patient.is_dead_state() || ( &patient != this &&
            ( patient.in_vehicle || patient.posz() != posz() ||
              rl_dist( pos_bub(), patient.pos_bub() ) > 4 || !sees( get_map(), patient ) ||
              autonomous_patient_reserved( patient ) ) ) ) {
            return;
        }
        if( &patient != this && rl_dist( pos_bub(), patient.pos_bub() ) > 1 &&
            ( !get_map().clear_path( pos_bub(), patient.pos_bub(), 4, 1, 100 ) ||
              is_no_go_position( patient.pos_abs() ) || sees_dangerous_field( patient.pos_bub() ) ) ) {
            return;
        }
        const healing_options options = has_healing_options( patient_assessment( patient ) );
        if( !options.any_true() ) {
            return;
        }
        item &medical = get_healing_item( options );
        if( medical.is_null() || medical.is_filthy() ||
            !craft_reservation::usable_by_automation( medical ) || !medical.ammo_sufficient( this ) ) {
            return;
        }
        const int score = autonomous_care_priority( patient ) * 10 -
                          rl_dist( pos_bub(), patient.pos_bub() );
        if( score > best_score ) {
            best = &patient;
            best_score = score;
            best_options = options;
        }
    };
    consider( *this );
    consider( get_player_character() );
    for( npc &other : g->all_npcs() ) {
        if( &other != this && other.is_player_ally() ) {
            consider( other );
        }
    }
    if( best ) {
        ai_cache.can_heal = best_options;
    }
    return best;
}

bool npc::autonomous_announce( const std::string &action, const std::string &line, bool urgent )
{
    const Character &leader = get_player_character();
    // Use native speech only when the leader is nearby; never break an explicit silence order.
    if( !is_player_ally() || is_dead_state() || is_hallucination() || in_sleep_state() ||
        is_mute() || ( !urgent && leader.in_sleep_state() ) ||
        rules.has_flag( ally_rule::use_silent ) ||
        ( !urgent && !rules.has_flag( ally_rule::allow_complain ) ) ||
        posz() != leader.posz() || rl_dist( pos_bub(), leader.pos_bub() ) > 12 ) {
        return false;
    }
    const time_duration spacing = urgent ? 2_seconds : 10_seconds;
    const auto previous = autonomy.announced_actions.find( action );
    if( ( autonomy.announcement_checked != calendar::before_time_starts &&
          calendar::turn - autonomy.announcement_checked < spacing ) ||
        ( previous != autonomy.announced_actions.end() &&
          calendar::turn - previous->second < 1_minutes ) ) {
        return false;
    }
    autonomy.announcement_checked = calendar::turn;
    autonomy.announced_actions[action] = calendar::turn;
    say( line );
    return true;
}

bool npc::autonomous_maintenance_allowed() const
{
    return is_player_ally() && ( attitude == NPCATT_FOLLOW || is_guarding() ||
                                ( assigned_camp && mission == NPC_MISSION_CAMP_RESIDENT &&
                                  pos_abs_omt() == *assigned_camp ) );
}

bool npc::autonomous_follow_maintenance()
{
    Character &leader = get_player_character();
    if( !autonomous_maintenance_allowed() || in_vehicle ||
        activity || in_sleep_state() || !is_safe() || sees_dangerous_field( pos_bub() ) ) {
        return false;
    }
    const bool together = attitude == NPCATT_FOLLOW && !leader.in_vehicle && sees( get_map(), leader ) &&
                          rl_dist( pos_bub(), leader.pos_bub() ) <= 4;
    if( autonomy.plan.task != npc_autonomy_task::none && autonomous_continue_plan() ) {
        return true;
    }
    if( fetching_item ) {
        if( together && wanted_item && rl_dist( wanted_item_pos, leader.pos_bub() ) <= 4 ) {
            autonomous_announce( "pickup", _( "I'll collect the supplies we need." ) );
            pick_up_item();
            return true;
        }
        fetching_item = false;
        wanted_item = {};
    }
    if( calendar::turn - autonomy.maintenance_checked < 2_seconds ) {
        return false;
    }
    autonomy.maintenance_checked = calendar::turn;
    refresh_autonomous_inventory();
    const item_location weapon = get_wielded_item();
    // Restore the ability to fight before optional housekeeping, even when separated.
    if( weapon && weapon->is_gun() && !weapon->ammo_sufficient( this ) &&
        autonomous_reload_step() ) {
        return true;
    }
    if( together && autonomous_weapon_step() ) {
        return true;
    }
    struct candidate {
        const char *action;
        int task;
        double score;
    };
    const bool supplies_missing = autonomy.food_kcal < autonomy.food_target / 2 ||
                                  autonomy.water_quench < autonomy.water_target / 2 ||
                                  autonomy.healing_units == 0;
    const bool loaded = weapon && weapon->is_gun() && weapon->ammo_sufficient( this );
    const double priorities[] = { has_new_items ? 0.55 : 0.25, loaded ? 0.35 : 0.65,
                                 0.30, 0.15, supplies_missing ? 0.60 : 0.20 };
    const char *actions[] = { "equipment", "reload", "supplies", "organize", "pickup" };
    std::vector<candidate> choices;
    for( int offset = 0; offset < 5; ++offset ) {
        const int task = ( autonomy.maintenance_cursor + offset ) % 5;
        if( ( task == 2 || task == 4 ) && !together ) {
            continue;
        }
        autonomy.serviced_actions.try_emplace( actions[task], calendar::turn - 30_seconds );
        choices.push_back( { actions[task], task,
                             autonomous_decision_score( actions[task], priorities[task],
                                     task == 0 ? 300 : 100 ) } );
    }
    std::stable_sort( choices.begin(), choices.end(), []( const candidate &a, const candidate &b ) {
        return a.score > b.score;
    } );
    for( const candidate &choice : choices ) {
        if( choice.score < 0 ) {
            continue;
        }
        bool acted = false;
        switch( choice.task ) {
            case 0:
                if( has_new_items || calendar::turn - autonomy.equipment_checked >=
                    npc_autonomy::cadence( 30_seconds, getID().get_value() ) ) {
                    autonomy.equipment_checked = calendar::turn;
                    has_new_items = false;
                    acted = autonomous_equipment_step() || wield_better_weapon();
                    has_new_items = acted;
                }
                break;
            case 1:
                acted = autonomous_reload_step();
                break;
            case 2:
                acted = autonomous_supply_step();
                break;
            case 3:
                acted = autonomous_organize_step();
                break;
            case 4:
                if( rules.has_flag( ally_rule::allow_pick_up ) &&
                    calendar::turn - autonomy.loot_checked >=
                    npc_autonomy::cadence( 2_seconds, getID().get_value() ) ) {
                    autonomy.loot_checked = calendar::turn;
                    find_item();
                    if( fetching_item ) {
                        autonomy.reason = _( "Collecting useful supplies nearby." );
                        autonomous_announce( "pickup", _( "I'll collect the supplies we need." ) );
                        pick_up_item();
                        acted = true;
                    }
                }
                break;
        }
        autonomous_decision_result( choice.action, acted );
        if( acted ) {
            autonomy.maintenance_cursor = ( choice.task + 1 ) % 5;
            return true;
        }
    }
    autonomy.reason = together ? _( "Following the team and watching for threats." ) :
                      _( "Rejoining the team with my equipment ready." );
    return false;
}

tripoint_bub_ms npc::autonomous_follow_position()
{
    const tripoint_bub_ms leader = get_player_character().pos_bub();
    const int distance = std::clamp( follow_distance(), 1, 3 );
    std::vector<std::pair<int, tripoint_bub_ms>> candidates;
    const auto leader_route = get_player_character().get_auto_move_route();
    std::vector<tripoint_bub_ms> reserved_positions;
    for( const npc &other : g->all_npcs() ) {
        if( &other != this && other.is_player_ally() && !other.path.empty() && sees( get_map(), other ) ) {
            reserved_positions.push_back( other.path.back() );
        }
    }
    const auto available = [&]( const tripoint_bub_ms &p ) {
        return p != leader && rl_dist( p, leader ) <= distance && could_move_onto( p ) &&
               !is_no_go_position( get_map().get_abs( p ) ) && !sees_dangerous_field( p ) &&
               ( p == pos_bub() || g->is_empty( p ) ) &&
               std::find( leader_route.begin(), leader_route.end(), p ) == leader_route.end() &&
               std::find( reserved_positions.begin(), reserved_positions.end(), p ) ==
               reserved_positions.end();
    };
    if( autonomy.follow_goal && calendar::turn - autonomy.follow_checked < 2_seconds ) {
        const tripoint_bub_ms cached = get_map().get_bub( *autonomy.follow_goal );
        if( available( cached ) ) {
            if( cached == pos_bub() ) {
                path.clear();
                return cached;
            }
            const bool reusable = !path.empty() && path.back() == cached &&
                                  rl_dist( pos_bub(), path.front() ) == 1 &&
                                  g->is_empty( path.front() ) &&
                                  std::all_of( path.begin(), path.end(), [this]( const auto &p ) {
                return could_move_onto( p ) && !sees_dangerous_field( p ) &&
                       !is_no_go_position( get_map().get_abs( p ) );
            } );
            if( reusable || update_path( cached, true ) ) {
                return cached;
            }
        }
    }
    autonomy.follow_checked = calendar::turn;
    for( const tripoint_bub_ms &p : get_map().points_in_radius( leader, distance ) ) {
        if( !available( p ) ) {
            continue;
        }
        const int score = rl_dist( pos_bub(), p ) * 10 +
                          ( get_map().has_flag( ter_furn_flag::TFLAG_DOOR, p ) ? 30 : 0 );
        candidates.emplace_back( score, p );
    }
    std::stable_sort( candidates.begin(), candidates.end(), []( const auto &a, const auto &b ) {
        return a.first < b.first;
    } );
    for( const auto &candidate : candidates ) {
        if( update_path( candidate.second, true ) ) {
            autonomy.follow_goal = get_map().get_abs( candidate.second );
            return candidate.second;
        }
    }
    path.clear();
    autonomy.follow_goal.reset();
    return pos_bub();
}
