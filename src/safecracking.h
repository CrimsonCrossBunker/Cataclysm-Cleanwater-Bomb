#pragma once
#ifndef CATA_SRC_SAFECRACKING_H
#define CATA_SRC_SAFECRACKING_H

#include "coordinates.h"
#include "type_id.h"

class Character;
class JsonObject;
class JsonOut;
class map;
enum class activity_execution;

enum class safe_action { guess, crack, open };

struct safe_interaction {
    safe_action action = safe_action::guess;
    tripoint_abs_ms origin;
    tripoint_abs_ms position;
    furn_str_id furniture;

    bool matches( const Character &who, const map &here ) const;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

bool has_safecracking_tool( const Character &who );
bool can_hear_safe_lock( const Character &who );
bool execute_safe_interaction( Character &who, map &here, const safe_interaction &choice,
                               activity_execution execution );

#endif // CATA_SRC_SAFECRACKING_H
