#pragma once
#ifndef CATA_SRC_MP_INVENTORY_ACTIVITY_H
#define CATA_SRC_MP_INVENTORY_ACTIVITY_H

#include <cstdint>
#include <memory>
#include <optional>
#include <string>
#include <vector>

#include "character_id.h"
#include "coordinates.h"
#include "type_id.h"

struct insert_selection;
struct construction_selection;
class Character;
struct bionic;
struct bionic_activation_choices;
struct martial_style_choice;
class craft_command;
class item;
class item_location;
class JsonObject;
class JsonOut;
class map;
class player_activity;

namespace cata_mp
{
struct pickup_host_state;
struct unload_intent;
struct craft_notice {
    std::string message;
    bool alarm = false;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};
struct inventory_activity_host_state {
    int64_t last_request = 0;
    bool needs_placement = false;
    bool tracks_needs = false;
    bool tracks_body = false;
    bool tracks_crafting = false;
    bool tracks_item_use = false;
    // Per-request delivery scope, including native effects whose callbacks abort the actor.
    bool refresh_observers = false;
    character_id healing_patient;
    std::optional<tripoint_abs_ms> automatic_mining_target;
    ter_str_id automatic_mining_terrain;
    furn_str_id automatic_mining_furniture;
    std::vector<craft_notice> notices;
};
struct inventory_activity_client_state {
    int64_t next_request = 0;
    int64_t pending_request = 0;
    std::string activity;
    bool active = false;
    bool finished = false;
    bool cancel_requested = false;
    bool needs_placement = false;
    bool can_wield = false;
    std::shared_ptr<item> preview;
    std::string item_use_progress;
    int64_t water_source_uid = 0;
    std::string craft_decision;
    recipe_id craft_recipe;
    int craft_batch = 0;
    std::optional<tripoint_abs_ms> craft_location;
    std::string construction_decision;
    std::string construction_prompt;
    bool construction_text = false;
    std::vector<craft_notice> notices;
};

void notify_craft_owner( character_id owner, const std::string &message, bool alarm = false );
std::string take_craft_notifications( inventory_activity_host_state &state );
void apply_craft_notifications( const JsonObject &state );

bool owns_inventory_activity( const Character &who );
bool inventory_activity_view( const player_activity &activity );
std::string execute_inventory_activity_request( Character &who, map &here,
        const JsonObject &request,
        inventory_activity_host_state &state, pickup_host_state &inventory, bool authorized = true );
bool apply_inventory_activity_result( const JsonObject &response );
void client_start_reload( const item_location &selected, const item_location &target,
                          const item_location &ammo, int quantity, int pocket,
                          bool allow_theft, bool allow_hammer );
void client_start_unload( const unload_intent &intent );
void client_start_insert( const insert_selection &selection );
void client_start_consume( const item_location &source, bool allow_consequences, bool allow_theft,
                           bool reprompt = false );
// Returns true when the client request was handled. Unsupported native methods
// remain on their existing path until their additional choices are migrated.
bool client_activate_item( const item_location &source, std::string &method,
                           std::optional<tripoint_abs_ms> target = std::nullopt );
bool client_auto_mine( const tripoint_abs_ms &target );
// nullopt means a local/server call; a handled client request never runs effects locally.
std::optional<bool> client_activate_bionic( const bionic &bio,
        const bionic_activation_choices *choices = nullptr );
std::optional<bool> client_deactivate_bionic( const bionic &bio );
bool client_select_martial_style( const martial_style_choice &choice );
bool client_examine_pry( const item_location &tool, const tripoint_abs_ms &target );
void client_start_firstaid( const item_location &source, Character &patient,
                            const bodypart_str_id &part, bool allow_theft, bool reprompt = false );
void client_start_craft( const craft_command &command );
void client_start_construction( const construction_selection &selected );
bool client_start_blueprint_construction( const construction_str_id &id,
        const tripoint_abs_ms &position );
bool client_change_construction( const tripoint_abs_ms &position, int64_t uid, bool remove );
void client_resume_craft( const item_location &source );
void client_step_inventory_activity();
void client_cancel_inventory_activity();
void client_update_inventory_activity_view();
} // namespace cata_mp
#endif // CATA_SRC_MP_INVENTORY_ACTIVITY_H
