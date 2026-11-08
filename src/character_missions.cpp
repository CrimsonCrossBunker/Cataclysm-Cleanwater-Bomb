#include "character.h"

#include <algorithm>
#include <vector>

#include "debug.h"
#include "mission.h"
#include "messages.h"
#include "translations.h"

std::vector<mission *> Character::get_active_missions() const
{
    return active_missions;
}

std::vector<mission *> Character::get_completed_missions() const
{
    return completed_missions;
}

std::vector<mission *> Character::get_failed_missions() const
{
    return failed_missions;
}

mission *Character::get_active_mission() const
{
    return active_mission;
}

void Character::reset_all_missions()
{
    active_mission = nullptr;
    active_missions.clear();
    completed_missions.clear();
    failed_missions.clear();
}

void Character::update_active_mission()
{
    if( active_missions.empty() ) {
        active_mission = nullptr;
    } else {
        active_mission = active_missions.front();
    }
}

void Character::on_mission_assignment( mission &new_mission )
{
    if( ( new_mission.is_assigned() && new_mission.get_assigned_player_id() != getID() ) ||
        std::find( active_missions.begin(), active_missions.end(),
                   &new_mission ) != active_missions.end() ) {
        return;
    }
    active_missions.push_back( &new_mission );
    set_active_mission( new_mission );
}

void Character::on_mission_finished( mission &cur_mission )
{
    if( cur_mission.get_assigned_player_id() != getID() ) {
        return;
    }
    const auto iter = std::find( active_missions.begin(), active_missions.end(), &cur_mission );
    if( iter == active_missions.end() ) {
        return; // A repeated notification must not duplicate the completion ledger.
    }
    active_missions.erase( iter );
    if( cur_mission.has_failed() ) {
        if( !cur_mission.get_type().invisible_on_complete ) {
            failed_missions.push_back( &cur_mission );
        }
        add_msg_if_player( m_bad, _( "Mission \"%s\" is failed." ), cur_mission.name() );
    } else {
        if( !cur_mission.get_type().invisible_on_complete ) {
            completed_missions.push_back( &cur_mission );
        }
        add_msg_if_player( m_good, _( "Mission \"%s\" is successfully completed." ),
                           cur_mission.name() );
    }
    if( &cur_mission == active_mission ) {
        update_active_mission();
    }
}

bool Character::has_mission_id( const mission_type_id &miss_id )
{
    for( mission *miss : active_missions ) {
        if( miss->mission_id() == miss_id ) {
            return true;
        }
    }
    return false;
}

void Character::remove_active_mission( mission &cur_mission )
{
    const auto iter = std::find( active_missions.begin(), active_missions.end(), &cur_mission );
    if( iter == active_missions.end() ) {
        debugmsg( "removed mission %s was not in the active_missions list",
                  cur_mission.mission_id().c_str() );
        return;
    } else {
        active_missions.erase( iter );
    }

    if( &cur_mission == active_mission ) {
        update_active_mission();
    }
    cur_mission.remove_active_world_mission( cur_mission );
}

void Character::set_active_mission( mission &cur_mission )
{
    if( std::find( active_missions.begin(), active_missions.end(),
                   &cur_mission ) == active_missions.end() ) {
        debugmsg( "new objective %s is not in the active_missions list",
                  cur_mission.mission_id().c_str() );
        return;
    }
    active_mission = &cur_mission;
}

void Character::transfer_missions_to( Character &successor )
{
    if( &successor == this || !getID().is_valid() || !successor.getID().is_valid() ) {
        return;
    }
    mission *selected = active_mission;
    const auto transfer = [&]( const std::vector<mission *> &from, std::vector<mission *> &to,
    bool active ) {
        for( mission *entry : from ) {
            if( active && entry->is_assigned() && entry->get_assigned_player_id() != getID() ) {
                continue;
            }
            // Old local-takeover saves can retain historical owner IDs in
            // completed entries. Preserve that history without reassigning it.
            // Death releases active assignments. Only adopt released entries
            // from this character's own ledger, not every unassigned world quest.
            if( entry->get_assigned_player_id() == getID() || ( active && !entry->is_assigned() ) ) {
                entry->set_assigned_player_id( successor.getID() );
            }
            if( std::find( to.begin(), to.end(), entry ) == to.end() ) {
                to.push_back( entry );
            }
        }
    };
    transfer( active_missions, successor.active_missions, true );
    transfer( completed_missions, successor.completed_missions, false );
    transfer( failed_missions, successor.failed_missions, false );
    reset_all_missions();
    if( selected && std::find( successor.active_missions.begin(), successor.active_missions.end(),
                               selected ) != successor.active_missions.end() ) {
        successor.set_active_mission( *selected );
    }
}
