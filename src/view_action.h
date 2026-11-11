#pragma once
#ifndef CATA_SRC_VIEW_ACTION_H
#define CATA_SRC_VIEW_ACTION_H

#include <optional>
#include <string>

#include "coordinates.h"
#include "map_viewpoint.h"
#include "safe_reference.h"

class Character;
class Creature;
class map;

// A local UI selection, never a client-supplied simulation snapshot. Execute
// after leaving a presentation view, from the actor's unchanged real position.
struct view_action {
    enum class kind { travel, fire, rename, blind_throw, blind_throw_wielded };
    kind action = kind::travel;
    tripoint_abs_ms origin;
    tripoint_abs_ms target;
    safe_reference<map> context;
    safe_reference<Creature> subject;
    std::optional<map_viewpoint> observation;
    int distance = 0;
    std::string name;

    bool visible_to( Character &who, map &here ) const;
};

view_action select_view_action( view_action::kind action, Character &who, map &here,
                                const tripoint_bub_ms &target, Creature *subject = nullptr );

#endif // CATA_SRC_VIEW_ACTION_H
