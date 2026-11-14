#pragma once
#ifndef CATA_SRC_SPELL_CASTING_CHOICE_H
#define CATA_SRC_SPELL_CASTING_CHOICE_H

#include <optional>
#include <vector>

#include "coordinates.h"
#include "craft_command.h"
#include "magic.h"
#include "type_id.h"

class Character;
class JsonObject;
class JsonOut;
class spell;

// Player input contains only a target and native material alternatives. Spell
// level, success, cost and effects always come from the owning activity.
struct spell_casting_choice {
    std::optional<tripoint_abs_ms> target;
    std::vector<comp_selection<item_comp>> components;
    std::vector<comp_selection<tool_comp>> tools;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

struct spell_casting_prompt {
    spell preview;
    bool target = false;
    bool components = false;
    std::optional<spell_casting_choice> query( Character &who ) const;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

bool spell_needs_target_choice( const spell &selected, const Character &who );
bool valid_spell_casting_choice( Character &who, const spell &selected,
                                 spell_casting_choice &choice, bool target, bool components );
void consume_spell_casting_components( Character &who, const spell_casting_choice &choice );

#endif // CATA_SRC_SPELL_CASTING_CHOICE_H
