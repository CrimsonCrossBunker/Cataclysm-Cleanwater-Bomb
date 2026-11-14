#pragma once
#ifndef CATA_SRC_REPAIR_ACTIVITY_H
#define CATA_SRC_REPAIR_ACTIVITY_H

#include <coordinates.h>
#include <point.h>
#include <requirements.h>
#include <type_id.h>
#include <cstdint>
#include <memory>
#include <optional>
#include <string>

#include "activity_actor.h"
#include "craft_command.h"
#include "item_source.h"

class Character;
class JsonObject;
class JsonOut;
class JsonValue;
class item;
class item_location;
class map;
class repair_item_actor;
class vehicle;
struct vehicle_control_selection;

// Values also occur in actorless legacy repair saves.
enum class repair_repeat : int {
    INIT = 0,
    ONCE = 1,
    FULL = 3,
    EVENT = 4,
    REFIT_ONCE = 5,
    REFIT_FULL = 6,
    CANCEL = 7,
};

repair_repeat query_repair_repeat( Character &who, const item &tool, const item &fix,
                                   const repair_item_actor &actor, repair_repeat previous );

// A portable source or a particular tool supplied by particular vehicle hardware.
struct repair_tool_source {
    item_source portable;
    int64_t vehicle_id = 0;
    int64_t part = 0;
    int64_t installed_tool = 0;
    tripoint_abs_ms position;
    std::string tool;
    std::string method;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

struct repair_activity_choice {
    item_source target;
    int repeat = 0;
    comp_selection<item_comp> material;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

class repair_activity_actor : public activity_actor
{
    public:
        repair_tool_source source;
        std::optional<repair_activity_choice> choice;
        bool waiting = true;

        const activity_id &get_type() const override;
        void start( player_activity &act, Character &who ) override;
        void do_turn( player_activity &act, Character &who ) override;
        void finish( player_activity &act, Character &who ) override;
        std::unique_ptr<activity_actor> clone() const override;
        void serialize( JsonOut &out ) const override;
        void read( const JsonObject &data );
        static std::unique_ptr<activity_actor> deserialize( JsonValue &data );

        bool apply_choice( Character &who, const repair_activity_choice &selected );
        std::optional<repair_activity_choice> query_choice( Character &who ) const;
        void run_local( Character &who );
};

bool start_owned_repair( Character &who, item_location tool, const std::string &method );
bool has_vehicle_repair_tool( const vehicle &target, const tripoint_abs_ms &position );
bool valid_vehicle_repair( Character &who, map &here, vehicle &target,
                           const tripoint_abs_ms &position, const repair_tool_source &source );
bool execute_vehicle_repair( Character &who, const repair_tool_source &source );
bool query_mounted_repair( Character &who, const item &tool, const tripoint_bub_ms &position,
                           const std::string &method );
std::optional<vehicle_control_selection> query_vehicle_repair( Character &who, map &here,
        vehicle &target, const tripoint_abs_ms &position );

#endif // CATA_SRC_REPAIR_ACTIVITY_H
