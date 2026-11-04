#include "npc.h"

#include <algorithm>
#include <vector>

#include "avatar.h"
#include "flag.h"
#include "game.h"
#include "line.h"
#include "map.h"
#include "translations.h"

namespace
{
static const json_character_flag json_flag_CANNOT_MOVE( "CANNOT_MOVE" );
bool on_shot_line( const tripoint_bub_ms &from, const tripoint_bub_ms &target,
                   const tripoint_bub_ms &position )
{
    if( from.z() != position.z() || from == target || rl_dist( from, target ) > 40 ||
        rl_dist( from, position ) >= rl_dist( from, target ) ) {
        return false;
    }
    const auto ray = line_to( from, target );
    return std::any_of( ray.begin(), ray.end(), [&position]( const tripoint_bub_ms &p ) {
        return rl_dist( p, position ) <= 1;
    } );
}
}

bool npc::autonomous_tactical_step()
{
    const Creature *target = current_target();
    if( !is_player_ally() || attitude != NPCATT_FOLLOW || !target || in_vehicle ||
        activity || in_sleep_state() ||
        is_hallucination() || has_flag( json_flag_CANNOT_MOVE ) ||
        rules.engagement == combat_engagement::NO_MOVE ||
        rules.engagement == combat_engagement::FREE_FIRE ||
        rules.has_flag( ally_rule::hold_the_line ) ||
        calendar::turn == autonomy.tactics_checked || target->posz() != posz() ||
        rl_dist( pos_bub(), target->pos_bub() ) > 30 ) {
        return false;
    }
    autonomy.tactics_checked = calendar::turn;
    map &here = get_map();
    const item_location weapon = get_wielded_item();
    const bool shooter = weapon && weapon->is_gun() && rules.has_flag( ally_rule::use_guns );
    const bool vulnerable = hp_percentage() < 40 || ( shooter && weapon->ammo_remaining() == 0 );
    if( hp_percentage() < 35 ) {
        autonomy.withdrawing_until = calendar::turn + 3_seconds;
    }
    const int effective_range = shooter ? std::max( 1, confident_shoot_range( *weapon,
                                most_accurate_aiming_method_limit( *weapon ) ) ) : 1;
    const int preferred_range = shooter ? std::clamp( rl_dist( pos_bub(), target->pos_bub() ),
                                std::min( 4, effective_range ), effective_range ) : 1;
    std::vector<const Creature *> threats;
    for( const auto &weak : ai_cache.hostile_guys ) {
        if( const auto enemy = weak.lock() ) {
            threats.push_back( enemy.get() );
        }
    }
    if( std::find( threats.begin(), threats.end(), target ) == threats.end() ) {
        threats.push_back( target );
    }
    // Local positioning evaluates only the eight nearest known threats, never new unseen enemies.
    const auto nearer = [this]( const Creature *a, const Creature *b ) {
        return rl_dist( pos_bub(), a->pos_bub() ) < rl_dist( pos_bub(), b->pos_bub() );
    };
    if( threats.size() > 8 ) {
        std::partial_sort( threats.begin(), threats.begin() + 8, threats.end(), nearer );
        threats.resize( 8 );
    }
    std::vector<const Character *> friends;
    for( const auto &weak : ai_cache.friends ) {
        if( const auto ally = weak.lock() ) {
            if( const Character *person = ally->as_character() ) {
                if( person != this && friends.size() < 12 ) {
                    friends.push_back( person );
                }
            }
        }
    }
    const npc *protected_ally = nullptr;
    for( const Character *ally : friends ) {
        const npc *companion = dynamic_cast<const npc *>( ally );
        if( companion && rl_dist( pos_bub(), companion->pos_bub() ) <= 4 &&
            ( companion->autonomy.recovering_until > calendar::turn ||
              companion->autonomy.withdrawing_until > calendar::turn ) ) {
            if( !protected_ally || companion->hp_percentage() < protected_ally->hp_percentage() ) {
                protected_ally = companion;
            }
        }
    }
    const tripoint_bub_ms leader = get_player_character().pos_bub();
    struct firing_lane {
        std::vector<tripoint_bub_ms> points;
        tripoint_bub_ms origin;
        int length;
    };
    std::vector<firing_lane> firing_lanes;
    for( const Character *ally : friends ) {
        const item_location ally_weapon = ally->get_wielded_item();
        if( !ally_weapon || !ally_weapon->is_gun() || ally_weapon->ammo_remaining() <= 0 ) {
            continue;
        }
        const npc *companion = dynamic_cast<const npc *>( ally );
        const auto planned = companion ? companion->autonomy.attack_target.lock() :
                             shared_ptr_fast<Creature>();
        const tripoint_bub_ms aim = planned && sees( here, *planned ) ?
                                   planned->pos_bub() : target->pos_bub();
        const int distance = rl_dist( ally->pos_bub(), aim );
        if( distance > 0 && distance <= 40 && ally->posz() == posz() && aim.z() == posz() ) {
            firing_lanes.push_back( { line_to( ally->pos_bub(), aim ), ally->pos_bub(), distance } );
        }
    }
    const auto score = [&]( const tripoint_bub_ms &p ) {
        int result = 0;
        const int range = rl_dist( p, target->pos_bub() );
        if( shooter && !vulnerable ) {
            result -= std::abs( range - preferred_range ) * 5;
            if( !here.sees( p, target->pos_bub(), weapon->gun_range( this ) ) ) {
                result -= 35;
            }
        }
        for( const Creature *enemy : threats ) {
            const int distance = rl_dist( p, enemy->pos_bub() );
            result -= std::max( 0, ( vulnerable ? 6 : shooter ? 4 : 1 ) - distance ) * 18;
            if( vulnerable && here.sees( enemy->pos_bub(), p, -1 ) ) {
                result -= 20;
            }
        }
        for( const Character *ally : friends ) {
            if( shooter && on_shot_line( p, target->pos_bub(), ally->pos_bub() ) ) {
                result -= 50;
            }
            // Leave room around the wounded and the teammate already treating them.
            if( ally->hp_percentage() < 35 && rl_dist( p, ally->pos_bub() ) == 1 ) {
                result -= 5;
            }
        }
        for( const firing_lane &lane : firing_lanes ) {
            if( rl_dist( lane.origin, p ) < lane.length &&
                std::any_of( lane.points.begin(), lane.points.end(), [&p]( const auto &point ) {
                return rl_dist( point, p ) <= 1;
            } ) ) {
                result -= 35;
            }
        }
        if( protected_ally && !vulnerable ) {
            result -= std::max( 0, rl_dist( p, protected_ally->pos_bub() ) - 2 ) * 10;
            if( protected_ally->autonomy.withdrawing_until > calendar::turn ) {
                const int screen_range = std::max( 1,
                                                  rl_dist( protected_ally->pos_bub(), target->pos_bub() ) - 2 );
                result -= std::abs( range - screen_range ) * 8;
            }
        }
        result -= std::max( 0, rl_dist( p, leader ) - follow_distance() - 2 ) * 8;
        if( autonomy.tactical_goal && here.get_bub( *autonomy.tactical_goal ) == p &&
            autonomy.tactical_enemy && *autonomy.tactical_enemy == target->pos_abs() ) {
            result += 2;
        }
        return result;
    };
    const int current_score = score( pos_bub() );
    std::vector<std::pair<int, tripoint_bub_ms>> positions;
    for( const tripoint_bub_ms &p : here.points_in_radius( pos_bub(), 3 ) ) {
        if( p == pos_bub() || p == leader || !here.inbounds( p ) || !g->is_empty( p ) ||
            autonomous_position_reserved( here.get_abs( p ), false ) || !could_move_onto( p ) ||
            sees_dangerous_field( p ) || is_no_go_position( here.get_abs( p ) ) ||
            ( ( rules.has_flag( ally_rule::forbid_engage ) || rules.engagement == combat_engagement::NONE ) &&
              rl_dist( p, target->pos_bub() ) < rl_dist( pos_bub(), target->pos_bub() ) ) ) {
            continue;
        }
        const int candidate = score( p ) - std::max( 0, rl_dist( pos_bub(), p ) - 1 ) * 3;
        if( candidate > current_score + 8 ) {
            positions.emplace_back( candidate, p );
        }
    }
    std::stable_sort( positions.begin(), positions.end(), []( const auto &a, const auto &b ) {
        return a.first > b.first;
    } );
    const auto previous_path = path;
    std::optional<tripoint_bub_ms> best;
    for( size_t i = 0; i < std::min<size_t>( positions.size(), 6 ); ++i ) {
        if( update_path( positions[i].second, true ) && !path.empty() ) {
            const bool unsafe_route = std::any_of( path.begin(), path.end(), [this]( const auto &p ) {
                return sees_dangerous_field( p ) || is_no_go_position( get_map().get_abs( p ) );
            } );
            if( !unsafe_route ) {
                best = positions[i].second;
                break;
            }
        }
    }
    if( !best ) {
        path = previous_path;
        autonomy.tactical_goal.reset();
        return false;
    }
    autonomy.tactical_goal = here.get_abs( *best );
    autonomy.position_until = calendar::turn + 2_seconds;
    autonomy.tactical_enemy = target->pos_abs();
    autonomy.reason = vulnerable ? _( "Seeking a safer position before recovering." ) :
                      protected_ally ? _( "Covering a recovering or withdrawing teammate." ) :
                      _( "Keeping weapon distance and clearing friendly firing lanes." );
    if( vulnerable ) {
        autonomous_announce( "retreat", _( "I need to fall back!" ), true );
    } else if( protected_ally ) {
        autonomous_announce( "cover", _( "I'll cover our teammate." ) );
    }
    move_to_next();
    return true;
}
