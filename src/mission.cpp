#include "mission.h"

#include <calendar.h>
#include <character_id.h>
#include <coordinates.h>
#include <dialogue_helpers.h>
#include <translation.h>
#include <type_id.h>
#include <algorithm>
#include <cstddef>
#include <istream>
#include <iterator>
#include <list>
#include <memory>
#include <numeric>
#include <set>
#include <unordered_map>
#include <unordered_set>
#include <utility>

#include "avatar.h"
#include "character.h"
#include "character_action_guard.h"
#include "creature.h"
#include "debug.h"
#include "dialogue.h"
#include "dialogue_chatbin.h"
#include "enum_conversions.h"
#include "game.h"
#include "item.h"
#include "item_group.h"
#include "kill_tracker.h"
#include "lua_platform_hooks.h"
#include "map.h"
#include "monster.h"
#include "npc.h"
#include "npc_lifetime.h"
#include "mp_client_conn.h"
#include "omdata.h"
#include "overmapbuffer.h"
#include "player_activity.h"
#include "point.h"
#include "requirements.h"
#include "talker.h"
#include "temp_crafting_inventory.h"
#include "visitable.h"

#define dbg(x) DebugLog((x),D_GAME) << __FILE__ << ":" << __LINE__ << ": "

static const efftype_id effect_pet( "pet" );
static const efftype_id effect_run( "run" );

static const mission_type_id mission_NULL( "NULL" );

mission mission_type::create( const character_id &npc_id ) const
{
    mission ret;
    ret.uid = g->assign_mission_id();
    ret.type = this;
    ret.dimension = g->get_dimension_prefix();
    ret.npc_id = npc_id;
    ret.item_id = item_id;
    ret.item_count = item_count;
    ret.value = value;
    ret.follow_up = follow_up;
    ret.monster_species = monster_species;
    ret.monster_type = monster_type;
    ret.monster_kill_goal = monster_kill_goal;

    struct dialogue d( get_talker_for( get_player_character() ),
                       get_talker_for( g->find_npc( npc_id ) ) );
    time_duration deadline_as_var = deadline.evaluate( d );
    if( deadline_as_var != 0_turns ) {
        ret.deadline = calendar::turn + deadline_as_var;
    } else {
        ret.deadline = calendar::turn_zero;
    }

    return ret;
}

std::string mission_type::tname() const
{
    return name.translated();
}

static std::unordered_map<int, mission> world_missions;
// Reverse index of the same registry, used to validate legacy borrowed pointers
// without dereferencing freed storage or scanning every mission on each query.
static std::unordered_map<const mission *, int> mission_addresses;
static std::size_t next_mission_identity_generation = 1;

// Phase callbacks may erase or replace entries in world_missions. Keep only
// identities across callbacks, including when a death affects several quests.
static std::vector<std::pair<int, std::size_t>> snapshot_missions()
{
    std::vector<std::pair<int, std::size_t>> result;
    result.reserve( world_missions.size() );
    for( const auto &entry : world_missions ) {
        result.emplace_back( entry.first, entry.second.identity_generation() );
    }
    return result;
}

static std::size_t issue_mission_identity_generation()
{
    const std::size_t result = next_mission_identity_generation;
    ++next_mission_identity_generation;
    if( next_mission_identity_generation == 0 ) {
        next_mission_identity_generation = 1;
    }
    return result;
}

mission *mission::reserve_new( const mission_type_id &type, const character_id &npc_id )
{
    const mission tmp = mission_type::get( type )->create( npc_id );
    // TODO: Warn about overwrite?
    mission &miss = world_missions[tmp.uid] = tmp;
    miss.identity_generation_ = issue_mission_identity_generation();
    mission_addresses[&miss] = miss.uid;
    return &miss;
}

mission *mission::find( int id, bool ok_missing )
{
    const auto iter = world_missions.find( id );
    if( iter != world_missions.end() ) {
        return &iter->second;
    }
    if( !ok_missing ) {
        dbg( D_ERROR ) << "requested mission with uid " << id << " does not exist";
        debugmsg( "requested mission with uid %d does not exist", id );
    }
    return nullptr;
}

mission *mission::find_by_address( const mission *candidate )
{
    const auto address = mission_addresses.find( candidate );
    if( address == mission_addresses.end() ) {
        return nullptr;
    }
    mission *live = find( address->second, true );
    return live == candidate ? live : nullptr;
}

bool mission::remove_unassigned( const int id )
{
    const auto iter = world_missions.find( id );
    if( iter == world_missions.end() ||
        iter->second.is_assigned() ) {
        return false;
    }
    mission_addresses.erase( &iter->second );
    world_missions.erase( iter );
    return true;
}

std::vector<mission *> mission::get_all_active()
{
    std::vector<mission *> ret;
    ret.reserve( world_missions.size() );
    for( auto &pr : world_missions ) {
        ret.push_back( &pr.second );
    }

    return ret;
}

void mission::remove_active_world_mission( mission &cur_mission )
{
    for( auto iter = world_missions.begin(); iter != world_missions.end(); iter++ ) {
        if( iter->second.get_id() == cur_mission.get_id() && iter->second.in_progress() ) {
            mission_addresses.erase( &iter->second );
            world_missions.erase( iter );
            break;
        }
    }
}

void mission::add_existing( const mission &m )
{
    mission &stored = world_missions[m.uid] = m;
    stored.identity_generation_ = issue_mission_identity_generation();
    mission_addresses[&stored] = stored.uid;
}

void mission::sync_replica( const mission &m )
{
    auto iter = world_missions.find( m.uid );
    if( iter == world_missions.end() ) {
        add_existing( m );
        return;
    }
    const std::size_t preserved_generation = iter->second.identity_generation_;
    iter->second = m;
    iter->second.identity_generation_ = preserved_generation;
    mission_addresses[&iter->second] = iter->second.uid;
}

namespace
{

std::unordered_set<itype_id> find_item_mission_targets( const character_id owner )
{
    std::unordered_set<itype_id> result;
    for( const auto &e : world_missions ) {
        const mission &miss = e.second;
        if( miss.in_progress() && miss.get_assigned_player_id() == owner &&
            !miss.get_npc_id().is_valid() && miss.get_type().goal == MGOAL_FIND_ITEM ) {
            result.insert( miss.get_item_id() );
        }
    }
    return result;
}

std::unordered_set<itype_id> present_mission_items( const std::unordered_set<itype_id> &targets )
{
    std::unordered_set<itype_id> result;
    std::unordered_set<itype_id> software_targets;
    for( const itype_id &target : targets ) {
        if( item( target ).is_software() ) {
            software_targets.insert( target );
        }
    }

    avatar &player_character = get_avatar();
    player_character.visit_items( [&]( item * it, item * ) {
        if( targets.count( it->typeId() ) != 0 ) {
            result.insert( it->typeId() );
        }
        return VisitResponse::NEXT;
    } );
    for( const itype_id &target : software_targets ) {
        if( player_character.count_softwares( target ) > 0 ) {
            result.insert( target );
        }
    }

    if( result.size() == targets.size() ) {
        return result;
    }

    get_map().for_each_visible_item( player_character.pos_bub(), 5, &player_character,
    [&]( const item & it ) {
        it.visit_items( [&]( item * child, item * ) {
            if( targets.count( child->typeId() ) != 0 ) {
                result.insert( child->typeId() );
            }
            return VisitResponse::NEXT;
        } );
        for( const item *soft : it.softwares() ) {
            if( software_targets.count( soft->typeId() ) != 0 ) {
                result.insert( soft->typeId() );
            }
        }
    } );
    return result;
}

} // namespace

void mission::process_all()
{
    if( cata_mp::is_client_mode() ) {
        return;
    }
    avatar &player_character = get_avatar();
    const std::unordered_set<itype_id> targets = find_item_mission_targets( player_character.getID() );

    // Activity blocks MGOAL_FIND_ITEM before it searches any items.
    const bool use_item_filter = !targets.empty() && !player_character.activity;
    const std::unordered_set<itype_id> present = use_item_filter ? present_mission_items( targets ) :
            std::unordered_set<itype_id>();
    bool item_filter_valid = use_item_filter;

    // Preserve the current iteration order, but callbacks may insert, replace,
    // or erase missions. Never keep an unordered-map iterator across them.
    for( const auto &entry : snapshot_missions() ) {
        mission *miss = find( entry.first, true );
        if( !miss || miss->identity_generation() != entry.second ) {
            continue;
        }
        const bool was_in_progress = miss->in_progress();
        const bool had_pending_effects = miss->failure_effects_pending;
        const bool can_skip_item_check = item_filter_valid && was_in_progress &&
                                         miss->get_assigned_player_id() == player_character.getID() &&
                                         !miss->get_npc_id().is_valid() &&
                                         miss->get_type().goal == MGOAL_FIND_ITEM &&
                                         ( !miss->has_deadline() || calendar::turn <= miss->get_deadline() ) &&
                                         present.count( miss->get_item_id() ) == 0;
        if( !can_skip_item_check ) {
            miss->process();
        }
        const mission *after = find( entry.first, true );
        // Completion/failure effects may change inventory relevant to later checks.
        if( !after || after->identity_generation() != entry.second ||
            ( was_in_progress && !after->in_progress() ) ||
            ( had_pending_effects && !after->failure_effects_pending ) ) {
            item_filter_valid = false;
        }
    }
}

std::vector<mission *> mission::to_ptr_vector( const std::vector<int> &vec, bool ok_missing )
{
    std::vector<mission *> result;
    for( const int &id : vec ) {
        mission *miss = find( id, ok_missing );
        if( miss != nullptr ) {
            result.push_back( miss );
        }
    }
    return result;
}

std::vector<int> mission::to_uid_vector( const std::vector<mission *> &vec )
{
    std::vector<int> result;
    result.reserve( vec.size() );
    for( const mission *miss : vec ) {
        if( const mission *live = find_by_address( miss ) ) {
            result.push_back( live->uid );
        }
    }
    return result;
}

void mission::clear_all()
{
    mission_addresses.clear();
    world_missions.clear();
}

void mission::on_creature_death( Creature &poor_dead_dude )
{
    if( cata_mp::is_client_mode() || poor_dead_dude.is_hallucination() ) {
        return;
    }
    monster *mon = dynamic_cast<monster *>( &poor_dead_dude );
    if( mon != nullptr ) {

        std::set<int> quest_ids = mon->mission_ids;
        if( mon->is_nemesis() && quest_ids.empty() ) {
            // Old unbound nemeses predate quest identities on hordes. Only
            // those retain the original local-avatar association.
            for( const auto &entry : world_missions ) {
                const mission &task = entry.second;
                if( task.in_progress() && task.type->goal == MGOAL_KILL_NEMESIS &&
                    task.player_id == get_avatar().getID() ) {
                    quest_ids.insert( entry.first );
                    break;
                }
            }
        }
        std::vector<std::pair<int, std::size_t>> affected;
        for( const int mission_id : quest_ids ) {
            const mission *entry = find( mission_id );
            if( entry ) {
                affected.emplace_back( mission_id, entry->identity_generation() );
            }
        }
        // Failure effects may remove this creature or replace another mission.
        // Do not access the creature or its mission set again after calling out.
        for( const auto &identity : affected ) {
            mission *entry = find( identity.first, true );
            if( !entry || entry->identity_generation() != identity.second || !entry->in_progress() ) {
                continue;
            }
            switch( entry->type->goal ) {
                case MGOAL_KILL_NEMESIS:
                    if( entry->type->monster_kill_goal == 1 ) {
                        entry->step_complete( 1 );
                    } else {
                        entry->nemesis_respawn_pending = true;
                        entry->process();
                    }
                    break;
                case MGOAL_FIND_MONSTER:
                    entry->fail();
                    break;
                case MGOAL_KILL_MONSTER:
                    entry->step_complete( 1 );
                    break;
                case MGOAL_KILL_MONSTERS:
                    if( entry->monster_kill_goal-- == 0 ) {
                        entry->step_complete( 1 );
                    }
                    break;
                default:
                    break;
            }
        }
        return;
    }
    const Character *dead_character = poor_dead_dude.as_character();
    if( !dead_character || !dead_character->getID().is_valid() ) {
        return;
    }
    const character_id dead_id = dead_character->getID();
    const bool was_npc = dead_character->as_npc() != nullptr;
    const auto affected = snapshot_missions();
    // NPC-backed remote players own quests too. Release the actual dead
    // character's active tasks, never the local avatar's or another player's.
    // Keep the dead character's ledger for native local takeover/history.
    for( const auto &identity : affected ) {
        mission *entry = find( identity.first, true );
        if( entry && entry->in_progress() && entry->player_id == dead_id ) {
            entry->player_id = character_id();
        }
    }
    if( !was_npc ) {
        return;
    }
    for( const auto &identity : affected ) {
        mission *entry = find( identity.first, true );
        if( !entry || entry->identity_generation() != identity.second || !entry->in_progress() ) {
            continue;
        }
        // A failure phase can erase this entry and any later entry. Capture the
        // decision first and perform at most one terminal transition.
        const bool fail_for_death = entry->npc_id == dead_id ||
                                    ( entry->type->goal == MGOAL_RECRUIT_NPC && entry->target_npc_id == dead_id );
        if( entry->type->goal == MGOAL_ASSASSINATE && entry->target_npc_id == dead_id ) {
            entry->step_complete( 1 );
        }
        if( fail_for_death ) {
            entry->fail();
        }
    }
}

bool mission::on_creature_fusion( Creature &fuser, Creature &fused )
{
    if( fuser.is_hallucination() || fused.is_hallucination() ) {
        return false;
    }
    monster *mon_fuser = dynamic_cast<monster *>( &fuser );
    if( mon_fuser == nullptr ) {
        debugmsg( "Unimplemented: fuser is not a monster" );
        return false;
    }
    monster *mon_fused = dynamic_cast<monster *>( &fused );
    if( mon_fused == nullptr ) {
        debugmsg( "Unimplemented: fused is not a monster" );
        return false;
    }
    bool mission_transfered = false;
    std::vector<int> mission_ids_to_remove;
    for( const int mission_id : mon_fused->mission_ids ) {
        const mission *const found_mission = mission::find( mission_id );
        if( !found_mission ) {
            debugmsg( "invalid mission id %d", mission_id );
            continue;
        }
        const mission_type *const type = found_mission->type;
        if( type->goal == MGOAL_KILL_MONSTER || type->goal == MGOAL_KILL_MONSTERS ) {
            // the fuser has to be killed now!
            mon_fuser->mission_ids.emplace( mission_id );
            mission_ids_to_remove.push_back( mission_id );
            mission_transfered = true;
        }
    }
    for( const int mission_id : mission_ids_to_remove ) {
        mon_fused->mission_ids.erase( mission_id );
    }
    return mission_transfered;
}

void mission::on_talk_with_npc( const character_id &npc_id )
{
    switch( type->goal ) {
        case MGOAL_TALK_TO_NPC:
            // If our goal is to talk to this npc, and we haven't yet completed a step for this
            // mission, then complete a step.
            if( npc_id == target_npc_id && step == 0 ) {
                step_complete( 1 );
            }
            break;
        default:
            break;
    }
}

mission *mission::reserve_random( const mission_origin origin, const tripoint_abs_omt &p,
                                  const character_id &npc_id )
{
    const mission_type_id type = mission_type::get_random_id( origin, p );
    if( type.is_null() ) {
        return nullptr;
    }
    return mission::reserve_new( type, npc_id );
}

Character *mission::assigned_character() const
{
    if( !player_id.is_valid() ) {
        return nullptr;
    }
    avatar &local = get_avatar();
    if( local.getID() == player_id ) {
        return local.is_dead_state() ? nullptr : &local;
    }
    npc *owner = g->find_npc( player_id );
    if( !owner || owner->is_dead() || !g->shared_from( *owner ) ) {
        return nullptr;
    }
    // Registry entries are weak: an active NPC need not already have a held
    // reference. Confirm native loading before tracking, and never reactivate
    // an explicitly retired incarnation.
    const npc_lifetime active = g->npc_lifetimes().track_active( *owner );
    return active.resolve( g->npc_lifetimes() ) == owner ? owner : nullptr;
}

void mission::assign( Character &u )
{
    if( !u.getID().is_valid() || player_id == u.getID() ) {
        return;
    }
    if( player_id.is_valid() ) {
        debugmsg( "tried to assign mission %d to player, but mission is already assigned to %d",
                  uid, player_id.get_value() );
        return;
    }
    const character_action_guard owner( u );
    if( !owner ) {
        return;
    }
    player_id = u.getID();
    u.on_mission_assignment( *this );
    if( status != mission_status::yet_to_start ) {
        return;
    }
    const int mission_id = uid;
    const std::size_t generation = identity_generation_;
    const auto live = [&]() {
        const mission *current = find( mission_id, true );
        return owner && current == this && current->identity_generation() == generation;
    };
    const kill_statistics &kills = u.get_kill_statistics();
    if( type->goal == MGOAL_KILL_MONSTER_TYPE && monster_type != mtype_id::NULL_ID() ) {
        kill_count_to_reach = kills.kill_count( monster_type ) + monster_kill_goal;
    } else if( type->goal == MGOAL_KILL_MONSTER_SPEC ) {
        kill_count_to_reach = kills.kill_count( monster_species ) + monster_kill_goal;
    }
    dialogue d( get_talker_for( u ), get_talker_for( g->find_npc( npc_id ) ) );
    const time_duration deadline_as_var = type->deadline.evaluate( d );
    if( !live() ) {
        return;
    }
    deadline = deadline_as_var != 0_turns ? calendar::turn + deadline_as_var : calendar::turn_zero;
    // Publish the transition before arbitrary phase callbacks: reentrant
    // completion must not be overwritten by a late in_progress assignment.
    status = mission_status::in_progress;
    const auto start_phase = type->start;
    if( start_phase ) {
        start_phase( this, u );
    }
    if( !live() ) {
        return;
    }
    cata::lua_platform::dispatch_native_hook(
    "on_mission_start", {
        { "mission", cata::lua_platform::native_callback_mission { mission_id, generation } }
    } );
}

void mission::fail()
{
    if( has_failed() || has_succeeded() ) {
        return;
    }
    if( Character *owner = assigned_character() ) {
        fail( *owner );
    } else {
        status = mission_status::failure;
        nemesis_respawn_pending = false;
        deadline = calendar::turn;
        // The owner may be disconnected/unloaded. Persist the phase instead of
        // applying that character's penalties or scripts to the local avatar.
        failure_effects_pending = true;
    }
}

void mission::fail( Character &player_character )
{
    if( player_character.getID() != player_id || has_failed() || has_succeeded() ) {
        return;
    }
    status = mission_status::failure;
    nemesis_respawn_pending = false;
    deadline = calendar::turn;
    failure_effects_pending = true;
    finish_failure( player_character );
}

void mission::finish_failure( Character &who )
{
    const character_action_guard owner( who );
    if( !failure_effects_pending || who.getID() != player_id || !owner ) {
        return;
    }
    const int mission_id = uid;
    const std::size_t generation = identity_generation_;
    const auto fail_phase = type->fail;
    // Consume before calling out: a repeated process() or saved result cannot
    // replay a partially executed phase.
    failure_effects_pending = false;
    who.on_mission_finished( *this );
    if( fail_phase ) {
        fail_phase( this, who );
    }
    const mission *current = find( mission_id, true );
    if( !owner || current != this || current->identity_generation() != generation ) {
        return;
    }
    cata::lua_platform::dispatch_native_hook(
    "on_mission_end", {
        { "mission", cata::lua_platform::native_callback_mission { mission_id, generation } },
        { "success", false }
    } );
}

void mission::set_target_to_mission_giver()
{
    const npc *giver = g->find_npc( npc_id );
    if( giver != nullptr ) {
        target = giver->pos_abs_omt();
    } else {
        target = tripoint_abs_omt::invalid;
    }
}

void mission::step_complete( const int _step )
{
    step = _step;
    switch( type->goal ) {
        case MGOAL_FIND_ITEM:
        case MGOAL_FIND_ITEM_GROUP:
        case MGOAL_FIND_MONSTER:
        case MGOAL_ASSASSINATE:
        case MGOAL_KILL_MONSTER:
        case MGOAL_KILL_MONSTERS:
        case MGOAL_COMPUTER_TOGGLE:
        case MGOAL_TALK_TO_NPC:
            // Go back and report.
            set_target_to_mission_giver();
            break;
        default:
            //Suppress warnings
            break;
    }
}

void mission::wrap_up()
{
    if( Character *owner = assigned_character() ) {
        wrap_up( *owner );
    }
}

void mission::wrap_up( Character &player_character )
{
    if( player_character.getID() != player_id || has_failed() || has_succeeded() ) {
        return;
    }
    const character_action_guard owner( player_character );
    if( !owner ) {
        return;
    }
    const int mission_id = uid;
    const std::size_t generation = identity_generation_;
    const auto live = [&]() {
        const mission *current = find( mission_id, true );
        return owner && current == this && current->identity_generation() == generation;
    };

    status = mission_status::success;
    nemesis_respawn_pending = false;
    player_character.on_mission_finished( *this );
    std::vector<item_comp> comps;
    switch( type->goal ) {
        case MGOAL_FIND_ITEM_GROUP: {
            temp_crafting_inventory tmp_inv = player_character.crafting_inventory();
            std::vector<item *> items = std::vector<item *>();
            tmp_inv.dump( items );
            item_group_id grp_type = type->group_id;
            itype_id container = type->container_id;
            bool specific_container_required = !container.is_null();
            bool remove_container = type->remove_container;
            itype_id empty_container = type->empty_container;

            std::map<itype_id, int> matches = std::map<itype_id, int>();
            get_all_item_group_matches(
                items, grp_type, matches,
                container, itype_id::NULL_ID(), specific_container_required );

            comps.reserve( matches.size() );
            for( std::pair<const itype_id, int> &cnt : matches ) {
                comps.emplace_back( cnt.first, cnt.second );

            }

            player_character.consume_items( comps );
            if( !live() ) {
                return;
            }

            if( remove_container ) {
                std::vector<item_comp> container_comp = std::vector<item_comp>();
                if( !empty_container.is_null() ) {
                    container_comp.emplace_back( empty_container, type->item_count );
                    player_character.consume_items( container_comp );
                    if( !live() ) {
                        return;
                    }
                } else {
                    container_comp.emplace_back( container, type->item_count );
                    player_character.consume_items( container_comp );
                    if( !live() ) {
                        return;
                    }
                }
            }
        }
        break;

        case MGOAL_FIND_ITEM: {
            const item item_sought( type->item_id );
            if( item_sought.is_software() ) {
                int consumed = 0;
                while( consumed < item_count ) {
                    const bool consumed_item = player_character.consume_software_container( type->item_id );
                    if( !live() ) {
                        return;
                    }
                    if( consumed_item ) {
                        consumed++;
                    } else {
                        debugmsg( "Tried to consume more software %s than available", type->item_id.c_str() );
                        break;
                    }
                }
            } else {
                comps.emplace_back( type->item_id, item_count );
                player_character.consume_items( comps );
                if( !live() ) {
                    return;
                }
            }
        }
        break;
        case MGOAL_FIND_ANY_ITEM:
            player_character.remove_mission_items( uid );
            break;
        case MGOAL_FIND_MONSTER: {
            Creature *found_creature = g->get_creature_if( [&]( const Creature & critter ) {
                const monster *const mon_ptr = dynamic_cast<const monster *>( &critter );
                return mon_ptr && mon_ptr->mission_ids.count( uid );
            } );
            if( found_creature != nullptr ) {
                monster *found_monster = found_creature->as_monster();
                if( found_monster != nullptr ) {
                    found_monster->mission_ids.erase( uid );
                    found_monster->remove_effect( effect_pet );
                    found_monster->remove_effect( effect_run );
                    found_monster->friendly = 0;
                    found_monster->morale = 100;
                }
            }
        }
        break;
        default:
            //Suppress warnings
            break;
    }

    if( !live() ) {
        return;
    }
    // Tracks completion/failure
    deadline = calendar::turn;
    const auto end_phase = type->end;
    if( end_phase ) {
        end_phase( this, player_character );
    }
    if( !live() ) {
        return;
    }
    cata::lua_platform::dispatch_native_hook(
    "on_mission_end", {
        {
            "mission",
            cata::lua_platform::native_callback_mission {
                uid, identity_generation_
            }
        },
        { "success", true }
    } );
}

bool mission::is_complete( const character_id &_npc_id ) const
{
    if( Character *owner = assigned_character() ) {
        return is_complete( _npc_id, *owner );
    }
    return !is_assigned() && is_complete( _npc_id, get_avatar() );
}

bool mission::is_complete( const character_id &_npc_id,
                           Character &player_character ) const
{
    if( ( is_assigned() && player_id != player_character.getID() ) || has_failed() ) {
        return false;
    }
    if( status == mission_status::success ) {
        return true;
    }

    switch( type->goal ) {
        case MGOAL_GO_TO: {
            const tripoint_abs_omt cur_pos = player_character.pos_abs_omt();
            return rl_dist( cur_pos, target ) <= 1;
        }

        case MGOAL_GO_TO_TYPE: {
            const oter_id cur_ter = overmap_buffer.ter( player_character.pos_abs_omt() );
            return ( cur_ter->get_type_id() == oter_type_str_id( type->target_id.str() ) );
        }

        case MGOAL_FIND_ITEM_GROUP: {
            temp_crafting_inventory tmp_inv = player_character.crafting_inventory();
            std::vector<item *> items = std::vector<item *>();
            tmp_inv.dump( items );
            item_group_id grp_type = type->group_id;
            itype_id container = type->container_id;
            bool specific_container_required = !container.is_null();

            std::map<itype_id, int> matches = std::map<itype_id, int>();
            get_all_item_group_matches(
                items, grp_type, matches,
                container, itype_id::NULL_ID(), specific_container_required );

            int total_match = std::accumulate( matches.begin(), matches.end(), 0,
            []( const std::size_t previous, const std::pair<const itype_id, std::size_t> &p ) {
                return static_cast<int>( previous + p.second );
            } );

            if( total_match >= ( type->item_count ) ) {
                return true;

            }
        }
        return false;

        case MGOAL_FIND_ITEM: {
            if( npc_id.is_valid() && npc_id != _npc_id ) {
                return false;
            }
            if( player_character.activity ) {
                return false;
            }
            item item_sought( type->item_id );
            map &here = get_map();
            int found_quantity = 0;
            bool charges = item_sought.count_by_charges();
            bool software = item_sought.is_software();
            auto count_items = [this, &found_quantity, charges, software]( const item & i ) {
                if( software ) {
                    for( const item *soft : i.softwares() ) {
                        if( soft->typeId() == type->item_id ) {
                            found_quantity ++;
                        }
                    }
                }
                if( charges ) {
                    found_quantity += i.charges_of( type->item_id, item_count - found_quantity );
                } else {
                    found_quantity += i.amount_of( type->item_id, false, item_count - found_quantity );
                }
            };
            here.for_each_visible_item( player_character.pos_bub(), 5, &player_character,
            [&]( const item & it ) {
                if( found_quantity < item_count ) {
                    count_items( it );
                }
            } );
            if( software ) {
                found_quantity += player_character.count_softwares( type->item_id );
            }
            if( charges ) {
                return player_character.charges_of( type->item_id ) + found_quantity >= item_count;
            } else {
                return player_character.amount_of( type->item_id ) + found_quantity >= item_count;
            }
        }
        return true;

        case MGOAL_FIND_ANY_ITEM:
            return player_character.has_mission_item( uid ) && ( !npc_id.is_valid() || npc_id == _npc_id );

        case MGOAL_FIND_MONSTER:
            if( npc_id.is_valid() && npc_id != _npc_id ) {
                return false;
            }
            return g->get_creature_if( [&]( const Creature & critter ) {
                const monster *const mon_ptr = dynamic_cast<const monster *>( &critter );
                return mon_ptr && mon_ptr->mission_ids.count( uid );
            } );

        case MGOAL_RECRUIT_NPC: {
            npc *p = g->find_npc( target_npc_id );
            return p != nullptr && p->get_attitude() == NPCATT_FOLLOW;
        }

        case MGOAL_RECRUIT_NPC_CLASS: {
            const auto npcs = overmap_buffer.get_npcs_near( player_character.pos_abs_sm(), 100 );
            for( const auto &npc : npcs ) {
                if( npc->myclass == recruit_class && npc->get_attitude() == NPCATT_FOLLOW ) {
                    return true;
                }
            }
            return false;
        }

        case MGOAL_FIND_NPC:
            return npc_id == _npc_id;

        case MGOAL_TALK_TO_NPC:
        case MGOAL_ASSASSINATE:
        case MGOAL_KILL_MONSTER:
        case MGOAL_KILL_MONSTERS:
        case MGOAL_KILL_NEMESIS:
        case MGOAL_COMPUTER_TOGGLE:
            return step >= 1;

        case MGOAL_KILL_MONSTER_TYPE:
            return player_character.get_kill_statistics().kill_count( monster_type ) >= kill_count_to_reach;

        case MGOAL_KILL_MONSTER_SPEC:
            return player_character.get_kill_statistics().kill_count( monster_species ) >= kill_count_to_reach;

        case MGOAL_CONDITION: {
            std::unique_ptr<talker> beta;
            std::vector<mission *> miss;
            // Skip the NPC check if the mission was obtained via a scenario/profession/hobby
            if( npc_id.is_valid() || type->origins.empty() || type->origins.size() != 1 ||
                type->origins.front() != mission_origin::ORIGIN_GAME_START ) {
                // Only allow completing when talking to the mission originator.
                if( npc_id != _npc_id ) {
                    return false;
                }
                npc *n = g->find_npc( _npc_id );
                if( n == nullptr ) {
                    return false;
                }
                beta = get_talker_for( *n );
                for( mission*&mission : n->chatbin.missions_assigned ) {
                    if( mission->get_assigned_player_id() == player_character.getID() ) {
                        miss.emplace_back( mission );
                    }
                }
            } else {
                for( mission*&mission : player_character.get_active_missions() ) {
                    if( mission->type->id == type->id ) {
                        miss.emplace_back( mission );
                    }
                }
            }
            dialogue cc( get_talker_for( player_character ), std::move( beta ) );
            cc.missions_assigned = std::move( miss );

            return type->test_goal_condition( cc );
        }

        default:
            return false;
    }
}

void mission::get_all_item_group_matches( std::vector<item *> &items,
        item_group_id &grp_type, std::map<itype_id, int> &matches,
        const itype_id &required_container, const itype_id &actual_container,
        bool &specific_container_required )
{
    for( item *itm : items ) {
        bool correct_container = ( required_container == actual_container ) ||
                                 !specific_container_required;

        bool item_in_group = item_group::group_contains_item( grp_type, itm->typeId() );

        //check whether item itself is target
        if( item_in_group && correct_container ) {
            std::map<itype_id, int>::iterator it = matches.find( itm->typeId() );
            if( it != matches.end() ) {
                it->second = ( it->second ) + 1;
            } else {
                matches.insert( std::make_pair( itm->typeId(), 1 ) );
            }
        }

        //recursively check item contents for target
        if( itm->is_container() && !itm->is_container_empty() ) {
            std::list<item *> content_list = itm->all_items_top();
            std::vector<item *> content = std::vector<item *>();

            //list of item into list item*
            std::transform(
                content_list.begin(), content_list.end(),
                std::back_inserter( content ),
            []( item * p ) {
                return p;
            } );

            get_all_item_group_matches(
                content, grp_type, matches,
                required_container, itm->typeId(), specific_container_required );
        }
    }
}

bool mission::has_deadline() const
{
    return deadline != calendar::turn_zero;
}

time_point mission::get_deadline() const
{
    return deadline;
}

std::string mission::get_description() const
{
    return type->description.translated();
}

dimension_id mission::get_dimension() const
{
    return dimension;
}

bool mission::has_target() const
{
    return !target.is_invalid();
}

const tripoint_abs_omt &mission::get_target() const
{
    return target;
}

const mission_type &mission::get_type() const
{
    if( type == nullptr ) {
        debugmsg( "Null mission type" );
        return mission_type::get_all().front();
    }

    return *type;
}

bool mission::has_follow_up() const
{
    return !follow_up.is_null();
}

mission_type_id mission::get_follow_up() const
{
    return follow_up;
}

int mission::get_value() const
{
    return value;
}

int mission::get_id() const
{
    return uid;
}

const itype_id &mission::get_item_id() const
{
    return item_id;
}

bool mission::has_failed() const
{
    return status == mission_status::failure;
}

bool mission::has_succeeded() const
{
    return status == mission_status::success;
}

bool mission::in_progress() const
{
    return status == mission_status::in_progress;
}

std::size_t mission::identity_generation() const noexcept
{
    return identity_generation_;
}

void mission::process()
{
    if( failure_effects_pending ) {
        if( Character *owner = assigned_character() ) {
            finish_failure( *owner );
        }
        return;
    }
    if( !in_progress() ) {
        return;
    }

    if( has_deadline() && calendar::turn > deadline ) {
        fail();
    } else if( nemesis_respawn_pending ) {
        if( Character *owner = assigned_character() ) {
            nemesis_respawn_pending = false;
            mission_start::kill_nemesis( this, *owner );
        }
    } else if( !npc_id.is_valid() && is_complete( npc_id ) ) { // No quest giver.
        wrap_up();
    }
}

character_id mission::get_npc_id() const
{
    return npc_id;
}

const talk_effect_fun_t::likely_rewards_t &mission::get_likely_rewards() const
{
    return type->likely_rewards;
}

bool mission::has_generic_rewards() const
{
    return type->has_generic_rewards;
}

bool mission::generic_reward_claimed() const noexcept
{
    return generic_reward_claimed_;
}

void mission::commit_generic_reward_claim() noexcept
{
    generic_reward_claimed_ = true;
}

void mission::set_deadline( time_point new_deadline )
{
    deadline = new_deadline;
}

void mission::set_dimension( dimension_id dimension_prefix )
{
    dimension = dimension_prefix;
}

void mission::set_target( const tripoint_abs_omt &p )
{
    target = p;
}

void mission::set_target_npc_id( const character_id &npc_id )
{
    target_npc_id = npc_id;
}

void mission::set_assigned_player_id( const character_id &char_id )
{
    player_id = char_id;
}


bool mission::is_assigned() const
{
    return player_id.is_valid();
}

character_id mission::get_assigned_player_id() const
{
    return player_id;
}

std::string mission::name() const
{
    if( type == nullptr ) {
        return "NULL";
    }
    return type->tname();
}

mission_type_id mission::mission_id() const
{
    if( type == nullptr ) {
        return mission_NULL;
    }
    return type->id;
}

std::string mission::dialogue_for_topic( const std::string &in_topic ) const
{
    // The internal keys are pretty ugly, it's better to translate them here than globally
    static const std::map<std::string, std::string> topic_translation = {{
            { "TALK_MISSION_DESCRIBE", "describe" },
            { "TALK_MISSION_DESCRIBE_URGENT", "describe" },
            { "TALK_MISSION_OFFER", "offer" },
            { "TALK_MISSION_ACCEPTED", "accepted" },
            { "TALK_MISSION_REJECTED", "rejected" },
            { "TALK_MISSION_ADVICE", "advice" },
            { "TALK_MISSION_INQUIRE", "inquire" },
            { "TALK_MISSION_SUCCESS", "success" },
            { "TALK_MISSION_SUCCESS_LIE", "success_lie" },
            { "TALK_MISSION_FAILURE", "failure" }
        }
    };

    const auto &replacement = topic_translation.find( in_topic );
    const std::string &topic = replacement != topic_translation.end() ? replacement->second : in_topic;

    const auto &response = type->dialogue.find( topic );
    if( response != type->dialogue.end() ) {
        return response->second.translated();
    }

    debugmsg( "Someone forgot to code this message id is %s, topic is %s!",
              type->id.c_str(), topic.c_str() );
    return "";
}

mission::mission()
    : deadline( 0 )
{
    type = nullptr;
    status = mission_status::yet_to_start;
    value = 0;
    uid = -1;
    target = tripoint_abs_omt::invalid;
    item_id = itype_id::NULL_ID();
    item_count = 1;
    target_id = string_id<oter_type_t>::NULL_ID();
    recruit_class = npc_class_id::NULL_ID();
    target_npc_id = character_id();
    monster_type = mtype_id::NULL_ID();
    monster_kill_goal = -1;
    npc_id = character_id();
    good_fac_id = -1;
    generic_reward_claimed_ = false;
    bad_fac_id = -1;
    step = 0;
    player_id = character_id();
}

namespace io
{
template<>
std::string enum_to_string<mission::mission_status>( mission::mission_status data )
{
    switch( data ) {
        // *INDENT-OFF*
        case mission::mission_status::yet_to_start: return "yet_to_start";
        case mission::mission_status::in_progress: return "in_progress";
        case mission::mission_status::success: return "success";
        case mission::mission_status::failure: return "failure";
        // *INDENT-ON*
        case mission::mission_status::num_mission_status:
            break;

    }
    cata_fatal( "Invalid mission_status" );
}

} // namespace io

mission::mission_status mission::status_from_string( const std::string &s )
{
    return io::string_to_enum<mission::mission_status>( s );
}

std::string mission::status_to_string( mission::mission_status st )
{
    return io::enum_to_string<mission::mission_status>( st );
}
