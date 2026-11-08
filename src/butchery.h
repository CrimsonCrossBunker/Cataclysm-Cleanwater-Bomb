#pragma once

#include <optional>
#include <string>
#include <vector>

#include "calendar.h"
#include "item_location.h"
#include "item_source.h"
#include "map.h"
#include "type_id.h"

class Character;
class item;
class player_activity;

enum class butcher_type : int {
    BLEED,          // bleeding a corpse
    QUICK,          // quick butchery
    FULL,           // full workshop butchery
    FIELD_DRESS,    // field dressing a corpse
    SKIN,           // skinning a corpse
    QUARTER,        // quarter a corpse
    DISMEMBER,      // destroy a corpse
    DISSECT,        // dissect a corpse for CBMs
    NUM_TYPES       // always keep at the end, number of butchery types
};

struct butchery_selection {
    item_source corpse;
    mtype_id type;
    butcher_type action = butcher_type::QUICK;
    bool allow_theft = false;
    bool allow_desecration = false;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

// Choices only; requirements, duration and yields are calculated by the operator.
bool query_butchery_selection( Character &who, const std::vector<item_location> &corpses,
                               butcher_type action, std::vector<butchery_selection> &selected );
bool start_owned_butchery( Character &who, const std::vector<butchery_selection> &selected );
bool accessible_butchery_corpse( Character &who, const item_location &corpse );

struct butchery_data {
    item_location corpse;
    requirement_id req;
    butcher_type b_type;
    float req_speed_bonus = 0.0f;
    time_duration time_to_butcher;
    // when `progress` reaches `time_to_butcher`, the corpse is butchered
    time_duration progress;
    // Old/native activities ask locally; owned requests carry explicit consent.
    std::optional<bool> allow_desecration;
    bool allow_theft = false;
    std::optional<mtype_id> corpse_type;

    butchery_data() = default;
    butchery_data( item_location &corpse, const butcher_type &b_type ) : corpse( corpse ),
        b_type( b_type ) {}
};

int butcher_time_to_cut( Character &you, const item &corpse_item, butcher_type action );

// Checks corpse contents, prior processing and incompatible work in progress.
// Tools, light and other activity requirements are checked separately.
bool butcher_action_applicable( Character &you, const item &corpse_item, butcher_type action );

// Whether this corpse should trigger species-empathy reactions during butchery.
// CCB keeps the pre-CDDA#78796 rule: zombified corpses are exempt.
bool character_has_butchery_empathy( const Character &character, const mtype_id &corpse );

std::string butcher_progress_var( butcher_type action );

std::string butcher_progress_time_var();

double butcher_get_progress( const item &corpse_item, butcher_type action );

butcher_type get_butcher_type( player_activity *act );

bool set_up_butchery( Character &you, const butchery_data &bd );

int roll_butchery_dissect( int skill_level, int dex, int tool_quality );

// Returns real blood stacks awaiting the operator's destination choice.
std::vector<item_location> destroy_the_carcass( const butchery_data &bd, Character &you );

std::optional<butcher_type> butcher_submenu( const std::vector<map_stack::iterator> &corpses,
        int index = -1 );
