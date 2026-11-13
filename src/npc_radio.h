#pragma once
#ifndef CATA_SRC_NPC_RADIO_H
#define CATA_SRC_NPC_RADIO_H

class Character;
class map;
class npc;

namespace npc_radio
{
enum class radio_contact_result : int {
    ALPHA_NO_RADIO,
    BETA_NO_RADIO,
    BOTH_NO_RADIO,
    TOO_FAR,
    YES,
    last
};

bool has_radio( const Character &who );
bool can_contact( const map &here, const Character &alpha, const Character &beta );
radio_contact_result can_radio_contact( const Character &alpha, const Character &beta );
bool knows_representative( const Character &who, const npc &representative );
} // namespace npc_radio

#endif // CATA_SRC_NPC_RADIO_H
