#pragma once
#ifndef CATA_SRC_ITEM_HEALING_H
#define CATA_SRC_ITEM_HEALING_H

#include "character_id.h"
#include "type_id.h"

class Character;
class heal_actor;
class item_location;

const heal_actor *healing_action( const item_location &source );
Character *find_healing_patient( Character &healer, character_id patient );
bool healing_allowed( Character &healer, Character &patient, const item_location &source,
                      const bodypart_id &part, bool allow_theft = false );
bool start_owned_healing( Character &healer, Character &patient, const item_location &source,
                          const bodypart_id &part, bool allow_theft );
void select_client_healing( Character &healer, const item_location &source,
                            Character *patient = nullptr, bool reprompt = false );

#endif // CATA_SRC_ITEM_HEALING_H
