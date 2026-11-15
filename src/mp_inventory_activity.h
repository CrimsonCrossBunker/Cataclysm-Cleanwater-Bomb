#pragma once
#ifndef CATA_SRC_MP_INVENTORY_ACTIVITY_H
#define CATA_SRC_MP_INVENTORY_ACTIVITY_H

#include <cstdint>
#include <memory>
#include <optional>
#include <string>
#include <utility>
#include <vector>

#include "character_id.h"
#include "mp_peek.h"
#include "coordinates.h"
#include "item_source.h"
#include "type_id.h"
#include "walking.h"

struct appliance_connection_selection;
struct deployed_furniture_selection;
struct terrain_examine_selection;
struct safe_interaction;
struct fireplace_selection;
struct appliance_conversion_selection;
struct grab_selection;
struct hauling_selection;
struct insert_selection;
struct item_move_selection;
struct ground_food_target;
struct construction_selection;
class Character;
struct walk_move_choices;
struct vertical_move_selection;
struct sleep_selection;
struct wait_selection;
struct vertical_move_prompt;
struct bionic;
struct bionic_activation_choices;
struct butchery_selection;
struct disassembly_selection;
struct item_activation_choices;
struct martial_style_choice;
struct vehicle_control_selection;
class craft_command;
class item;
class item_location;
class JsonObject;
class JsonOut;
class map;
class player_activity;
class repair_activity_actor;
struct spell_casting_prompt;
class dialogue_window;
class talker;

enum class zone_scope;
class zone_edit_session;
struct zone_edit_batch;
struct farming_command;
namespace charcoal_kiln
{
struct command;
}

namespace smoking_rack
{
struct command;
}

namespace fermentation_vessel
{
struct command;
}
namespace keg
{
struct command;
}
namespace furniture_reload
{
struct command;
}
namespace arc_furnace
{
struct completion;
}
namespace stook
{
struct command;
}
namespace autoclave
{
struct command;
}
namespace mill
{
struct command;
}

namespace item_repair
{
struct mending_selection;
struct repair_target;
} // namespace item_repair

namespace cata_mp
{
struct pickup_host_state;
struct equipment_intent;
struct unload_intent;
struct owned_dialogue_session;
struct npc_trade_prompt;
struct dialogue_view_option {
    std::string text;
    std::string color;
    bool selectable = true;
    bool confirm_hostile = false;
    bool confirm_helpless = false;
    bool quit_candidate = false;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};
struct npc_seminar_prompt {
    int64_t id = 0;
    std::string status;
    std::vector<std::pair<character_id, std::string>> candidates;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};
struct npc_item_offer_prompt {
    int64_t id = 0;
    std::string replacement_question;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};
struct dialogue_view_prompt {
    uint64_t session_id = 0;
    uint64_t response_revision = 0;
    std::string speaker_name;
    std::string speaker_color;
    std::string challenge;
    std::string player_response;
    std::string remote_name;
    bool is_computer = false;
    bool is_not_conversation = false;
    bool is_remote = false;
    bool append_challenge = true;
    std::vector<dialogue_view_option> options;
    std::shared_ptr<const npc_trade_prompt> trade;
    std::optional<npc_seminar_prompt> seminar;
    std::optional<npc_item_offer_prompt> item_offer;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};
struct craft_notice {
    std::string message;
    bool alarm = false;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};
struct inventory_activity_host_state {
    int64_t last_request = 0;
    std::optional<peek_authorization> peek;
    bool needs_placement = false;
    bool tracks_needs = false;
    bool tracks_body = false;
    bool tracks_crafting = false;
    bool tracks_item_use = false;
    bool tracks_walking = false;
    bool tracks_dialogue = false;
    uint64_t next_dialogue_session = 0;
    std::shared_ptr<owned_dialogue_session> dialogue_session;
    // Per-request delivery scope, including native effects whose callbacks abort the actor.
    bool refresh_observers = false;
    std::vector<tripoint_abs_ms> changed_tiles;
    std::vector<int64_t> refresh_vehicle_snapshots;
    bool spellbook_ready = false;
    bool spellbook_recast = false;
    character_id healing_patient;
    std::optional<tripoint_abs_ms> automatic_mining_target;
    ter_str_id automatic_mining_terrain;
    furn_str_id automatic_mining_furniture;
    std::vector<craft_notice> notices;
};
struct inventory_activity_client_state {
    std::optional<automove_step> pending_automove;
    bool automatic_mining = false;
    bool automatic_mining_succeeded = false;
    std::optional<peek_authorization> peek;
    std::shared_ptr<zone_edit_session> zone_editor;
    std::shared_ptr<vertical_move_prompt> vertical_prompt;
    bool zone_action_menu = false;
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
    int64_t liquid_source_uid = 0;
    bool remote_security_prompt = false;
    bool tree_direction_prompt = false;
    std::string smash_prompt;
    std::shared_ptr<repair_activity_actor> repair_prompt;
    std::shared_ptr<disassembly_selection> disassembly_prompt;
    std::shared_ptr<spell_casting_prompt> spell_prompt;
    std::shared_ptr<dialogue_view_prompt> dialogue_prompt;
    std::shared_ptr<dialogue_window> dialogue_ui;
    bool spellbook_ready = false;
    bool spellbook_recast = false;
    int64_t remote_vehicle_target = 0;
    item_source remote_controller;
    std::shared_ptr<item> remote_controller_preview;
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
bool client_walk( const tripoint_rel_ms &direction, const walk_move_choices &choices );
void client_start_sleep( const sleep_selection &choice );
void client_start_wait( const wait_selection &choice );
void client_sync_rest_activity( const JsonObject &state );
bool client_vertical_move( const vertical_move_selection &choice );
bool client_query_ledge_move( const tripoint_abs_ms &ledge );
bool client_peek_over_ledge( const tripoint_abs_ms &origin, const tripoint_abs_ms &ledge );
bool client_peek( const tripoint_abs_ms &origin, const tripoint_abs_ms &target, int direction = 0 );
bool client_query_peek( int direction );
std::optional<peek_authorization> client_peek_authorization();
bool client_query_vertical_move( int direction,
                                 const std::optional<tripoint_abs_ms> &ledge = std::nullopt );
bool client_take_down_furniture( const deployed_furniture_selection &choice );
bool client_terrain_examine( const terrain_examine_selection &choice );
bool client_safe_interaction( const safe_interaction &choice );
bool client_fireplace_selection( const fireplace_selection &choice );
bool client_appliance_conversion( const appliance_conversion_selection &choice );
bool client_finish_arc_furnace( const arc_furnace::completion &choice );
bool client_stook_command( const stook::command &choice );
bool client_autoclave_command( const autoclave::command &choice );
bool client_mill_command( const mill::command &choice );
bool client_grab( const grab_selection &choice );
bool client_hauling( const hauling_selection &choice );
void client_start_mending( const item_location &target, item_repair::mending_selection selection );
bool client_start_selected_repair( const item_location &tool, const std::string &method,
                                   const item_repair::repair_target &target );
void client_start_item_move( const item_move_selection &selection );
void client_start_smash( const tripoint_bub_ms &target );
void client_start_owned_wear( const std::vector<equipment_intent> &selection );
bool client_start_read( const item_location &book, const item_location &ereader,
                        bool continuous = false, int learner_id = -1 );
void client_start_reload( const item_location &selected, const item_location &target,
                          const item_location &ammo, int quantity, int pocket,
                          bool allow_theft, bool allow_hammer );
void client_start_unload( const unload_intent &intent );
void client_start_insert( const insert_selection &selection );
void client_start_consume( const item_location &source, bool allow_consequences, bool allow_theft,
                           bool reprompt = false );
void client_start_consume_ground( const ground_food_target &target, bool allow_consequences );
// Returns true when the client request was handled. Unsupported native methods
// remain on their existing path until their additional choices are migrated.
bool client_activate_item( const item_location &source, std::string &method,
                           std::optional<tripoint_abs_ms> target = std::nullopt,
                           const item_activation_choices *choices = nullptr );
bool client_auto_mine( const tripoint_abs_ms &target );
// nullopt means a local/server call; a handled client request never runs effects locally.
std::optional<bool> client_activate_bionic( const bionic &bio,
        const bionic_activation_choices *choices = nullptr );
std::optional<bool> client_deactivate_bionic( const bionic &bio );
std::optional<bool> client_cast_spell( const spell_id &id,
                                       const std::optional<tripoint_abs_ms> &target = std::nullopt );
bool client_query_spellbook( bool recast );
bool client_select_martial_style( const martial_style_choice &choice );
// Client choices only; execution and cranking remain owned by the server.
void client_plug_appliance( const appliance_connection_selection &selection );
bool client_vehicle_control( const vehicle_control_selection &choice );
bool client_drive_radio_car( const point_rel_ms &direction );
bool client_zone_sort( zone_scope scope );
bool client_query_zones( bool actions = false );
bool client_start_zone_work( const std::string &action );
bool client_farming_command( const farming_command &command );
bool client_kiln_command( const charcoal_kiln::command &command );
bool client_smoking_rack_command( const smoking_rack::command &command );
bool client_fermentation_command( const fermentation_vessel::command &command );
bool client_keg_command( const keg::command &command );
bool client_furniture_reload( const furniture_reload::command &command );
bool client_start_butchery( const std::vector<butchery_selection> &selected );
bool client_start_disassembly( const std::vector<disassembly_selection> &selected, bool recursive );
bool client_submit_zone_edits( const zone_edit_batch &batch );
void client_query_vehicle_control();
bool client_examine_pry( const item_location &tool, const tripoint_abs_ms &target );
void client_start_firstaid( const item_location &source, Character &patient,
                            const bodypart_str_id &part, bool allow_theft, bool reprompt = false );
void client_start_craft( const craft_command &command );
void client_start_construction( const construction_selection &selected );
bool client_start_blueprint_construction( const construction_str_id &id,
        const tripoint_abs_ms &position );
bool client_change_construction( const tripoint_abs_ms &position, int64_t uid, bool remove );
void client_resume_craft( const item_location &source );
std::optional<bool> client_start_dialogue( const talker &target, bool radio_contact = false,
        bool is_computer = false, bool is_not_conversation = false,
        const std::string &remote_name = {} );
bool client_start_radio_dialogue( character_id target );
bool client_choose_dialogue_response( uint64_t session_id, uint64_t response_revision,
                                      std::size_t response_index );
bool client_dialogue_special_action( uint64_t session_id, uint64_t response_revision,
                                     const std::string &action );
void client_step_inventory_activity();
void client_cancel_inventory_activity();
void client_update_inventory_activity_view();
} // namespace cata_mp
#endif // CATA_SRC_MP_INVENTORY_ACTIVITY_H
