#pragma once
#ifndef CATA_SRC_MISSION_DIALOGUE_H
#define CATA_SRC_MISSION_DIALOGUE_H

#include <cstddef>
#include <vector>

#include "character_id.h"
#include "type_id.h"

class Character;
struct const_dialogue;
struct dialogue;
class mission;
class npc;

namespace mission_dialogue
{

struct mission_selection_identity {
    int uid = -1;
    std::size_t generation = 0;

    bool is_set() const {
        return uid >= 0 && generation != 0;
    }

    void reset() {
        uid = -1;
        generation = 0;
    }

    bool operator==( const mission_selection_identity &other ) const {
        return uid == other.uid && generation == other.generation;
    }

    bool operator!=( const mission_selection_identity &other ) const {
        return !( *this == other );
    }
};

mission_selection_identity identify_mission( const mission *miss );

mission *resolve_live_mission( const mission_selection_identity &identity );
bool is_live_mission( const mission *miss );

bool is_available_chatbin_mission( const npc &p, const mission *miss );
bool is_assigned_chatbin_mission_for( const npc &p, const character_id &owner_id,
                                      const mission *miss );
bool is_authorized_dialogue_mission( const npc &p, const character_id &owner_id,
                                     const mission *miss );

mission *resolve_selected_mission( const npc &p, const character_id &owner_id,
                                   mission_selection_identity &selection );

std::vector<mission *> filter_available_missions( const npc &p );
std::vector<mission *> filter_assigned_missions_for( const npc &p,
        const character_id &owner_id );

bool participants_live( const const_dialogue &d );
Character *resolve_dialogue_character( const const_dialogue &d, bool is_beta = false );
npc *resolve_dialogue_npc( const dialogue &d, bool is_beta = true );

void assign_selected_mission( dialogue &d );
void succeed_selected_mission( dialogue &d );
void fail_selected_mission( dialogue &d );
void clear_selected_mission( dialogue &d );
void reward_selected_mission( dialogue &d );
void start_selected_training( dialogue &conversation );
void start_selected_training_npc( dialogue &conversation );
void start_selected_training_seminar( dialogue &conversation );

void add_mission_for_dialogue( dialogue &d, const mission_type_id &mission_id );
void assign_mission_by_type_for_dialogue( dialogue &d, const mission_type_id &mission_id );
void finish_mission_by_type_for_dialogue( dialogue &d, const mission_type_id &mission_id,
        bool success, int step );
void remove_active_mission_by_type_for_dialogue( dialogue &d, const mission_type_id &mission_id );

} // namespace mission_dialogue

#endif // CATA_SRC_MISSION_DIALOGUE_H
