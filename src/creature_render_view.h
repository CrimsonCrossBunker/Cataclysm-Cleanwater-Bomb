#pragma once
#ifndef CATA_SRC_CREATURE_RENDER_VIEW_H
#define CATA_SRC_CREATURE_RENDER_VIEW_H

#include <optional>
#include <string>
#include <utility>
#include <vector>

#include "coords_fwd.h"

class Character;
class Creature;
class map;
class monster;
enum class FacingDirection;

// Owned appearance values. No actor, worn item, mutation, tileset or SDL pointer
// survives capture; tile/category/overlay resolution belongs to the renderer.
struct entity_render_view {
    std::string body;
    std::string category;
    int rotation = -2;
    bool male = true;
    bool stack_overlays = false;
    std::vector<std::pair<std::string, std::string>> overlays;
};

entity_render_view capture_character_render_view( const Character &ch,
        FacingDirection facing_override );
entity_render_view capture_monster_overlay_view( const monster &mon );

// The owner resolves visibility, underwater fallback, mount/summoner/avatar
// appearance and disposition. The renderer only consumes these values, in the
// same rider/body/effect/icon order as the legacy draw path.
struct creature_render_view {
    std::string body;
    std::string species;
    std::string ridden_body;
    std::optional<entity_render_view> rider;
    std::optional<entity_render_view> character;
    std::optional<entity_render_view> monster_overlays;
    std::string disposition;
    int rotation = -2;
    bool special = false;
    bool overridden = false;
    bool character_result = false;
};

// Owner-only disposition query; returns an owned icon id, empty for the avatar.
std::string capture_creature_disposition( const map &here, Character &observer,
        const Creature &actor );

// Owner-only capture entry. The returned view can outlive every input actor.
std::optional<creature_render_view> capture_creature_render_view( const map &here,
        Character &observer, const Creature *critter, const tripoint_bub_ms &pos, bool invisible );

#endif // CATA_SRC_CREATURE_RENDER_VIEW_H
