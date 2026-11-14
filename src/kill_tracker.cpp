#include "kill_tracker.h"

#include <limits>
#include <memory>
#include <set>
#include <string>
#include <utility>

#include "cata_variant.h"
#include "avatar.h"
#include "character.h"
#include "character_action_guard.h"
#include "character_id.h"
#include "event.h"
#include "game.h"
#include "mtype.h"
#include "mp_actor_binding.h"
#include "mp_client_conn.h"
#include "npc.h"
#include "weakpoint.h"

void kill_statistics::reset( const std::map<mtype_id, int> &kills_,
                             const std::vector<std::string> &npc_kills_ )
{
    if( kills != kills_ || npc_kills != npc_kills_ ) {
        kills = kills_;
        npc_kills = npc_kills_;
        changed();
    }
}

int kill_statistics::kill_count( const mtype_id &mon ) const
{
    auto it = kills.find( mon );
    if( it != kills.end() ) {
        return it->second;
    }
    return 0;
}

int kill_statistics::kill_count( const species_id &spec ) const
{
    int result = 0;
    for( const auto &pair : kills ) {
        if( pair.first->in_species( spec ) ) {
            result += pair.second;
        }
    }
    return result;
}

int kill_statistics::guilt_kill_count( const mtype_id &mon ) const
{
    int count = 0;
    mon_flag_id flag;
    if( mon->has_flag( mon_flag_GUILT_ANIMAL ) ) {
        flag = mon_flag_GUILT_ANIMAL;
    } else if( mon->has_flag( mon_flag_GUILT_CHILD ) ) {
        flag = mon_flag_GUILT_CHILD;
    } else if( mon->has_flag( mon_flag_GUILT_HUMAN ) ) {
        flag = mon_flag_GUILT_HUMAN;
    } else if( mon->has_flag( mon_flag_GUILT_OTHERS ) ) {
        flag = mon_flag_GUILT_OTHERS;
    } else { // worst case scenario when no guilt flags are found
        auto noflag = kills.find( mon );
        if( noflag != kills.end() ) {
            return noflag->second;
        }
    }
    for( const auto &it : kills ) {
        if( it.first->has_flag( flag ) ) {
            count += it.second;
        }
    }
    return count;
}

int kill_statistics::monster_kill_count() const
{
    int result = 0;
    for( const auto &pair : kills ) {
        result += pair.second;
    }
    return result;
}

int kill_statistics::npc_kill_count() const
{
    return npc_kills.size();
}

int kill_statistics::total_kill_count() const
{
    return monster_kill_count() + npc_kill_count();
}

void kill_statistics::clear()
{
    if( !kills.empty() || !npc_kills.empty() ) {
        kills.clear();
        npc_kills.clear();
        changed();
    }
}

void kill_statistics::changed()
{
    if( ++revision_ == 0 ) {
        ++revision_;
    }
}

void kill_statistics::record_monster( const mtype_id &type )
{
    int &count = kills[type];
    if( count != std::numeric_limits<int>::max() ) {
        ++count;
        changed();
    }
}

void kill_statistics::record_character( const std::string &name )
{
    npc_kills.push_back( name );
    changed();
}

void kill_statistics::take_over( kill_statistics &previous )
{
    if( &previous != this ) {
        kills = std::move( previous.kills );
        npc_kills = std::move( previous.npc_kills );
        previous.kills.clear();
        previous.npc_kills.clear();
        previous.changed();
        changed();
    }
}

// Legacy value, maintained until kill_xp rework/removal from dependent mods.
static constexpr int npc_kill_xp = 10;

void kill_tracker::notify( const cata::event &event )
{
    if( cata_mp::is_client_mode() ||
        ( event.type() != event_type::character_kills_monster &&
          event.type() != event_type::character_kills_character ) ) {
        return;
    }
    const character_id id = event.get<character_id>( "killer" );
    Character *killer = id.is_valid() ? g->critter_by_id<Character>( id ) : nullptr;
    if( !killer ) {
        return;
    }
    const character_action_guard lifetime( *killer, true );
    if( !lifetime ) {
        return;
    }
    avatar &local = get_avatar();
    // Remote player bodies also appear in the legacy follower list. Their
    // persistent server-assigned proxy marker prevents credit leaking to host,
    // including between admission and connection-state publication.
    const npc *npc_killer = killer->as_npc();
    const bool player_proxy = npc_killer && cata_mp::is_player_proxy( *npc_killer );
    const bool local_follower = !killer->is_avatar() && !player_proxy &&
                                g->get_follower_list().count( id ) != 0;
    const bool receives_practice = killer->is_avatar() || player_proxy || local_follower;
    kill_statistics &own = killer->get_kill_statistics();
    if( event.type() == event_type::character_kills_monster ) {
        const mtype_id victim = event.get<mtype_id>( "victim_type" );
        own.record_monster( victim );
        if( local_follower ) {
            local.get_kill_statistics().record_monster( victim );
        }
        if( receives_practice ) {
            killer->kill_xp += event.get<int>( "exp" );
            // Practice can call scripts; all bookkeeping is committed before it.
            victim.obj().families.practice_kill( *killer );
        }
    } else {
        const std::string name = event.get<cata_variant_type::string>( "victim_name" );
        own.record_character( name );
        if( local_follower ) {
            local.get_kill_statistics().record_character( name );
        }
        if( receives_practice ) {
            killer->kill_xp += npc_kill_xp;
        }
    }
}
