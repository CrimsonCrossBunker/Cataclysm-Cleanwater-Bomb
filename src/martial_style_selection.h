#pragma once
#ifndef CATA_SRC_MARTIAL_STYLE_SELECTION_H
#define CATA_SRC_MARTIAL_STYLE_SELECTION_H

#include <optional>
#include <vector>

#include "type_id.h"

class Character;
class JsonObject;
class JsonOut;

enum class martial_style_action {
    select,
    toggle_hands_free,
    toggle_auto,
    cancel
};

struct martial_style_choice {
    martial_style_action action = martial_style_action::select;
    matype_id style{};
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

// A pending implant contributes choices without powering the frontend replica.
std::vector<matype_id> available_martial_styles( const Character &who,
        std::optional<unsigned int> activating_bionic = std::nullopt );
bool valid_martial_style_choice( const Character &who, const martial_style_choice &choice,
                                 std::optional<unsigned int> activating_bionic = std::nullopt );
std::optional<martial_style_choice> query_martial_style_choice( const Character &who,
        std::optional<unsigned int> activating_bionic = std::nullopt );
// Native effects only; no UI, supplied effects, or client-computed costs.
bool execute_martial_style_choice( Character &who, const martial_style_choice &choice );

#endif // CATA_SRC_MARTIAL_STYLE_SELECTION_H
