#pragma once
#ifndef CATA_SRC_ZONE_EDIT_H
#define CATA_SRC_ZONE_EDIT_H

#include <cstdint>
#include <map>
#include <memory>
#include <optional>
#include <string>
#include <utility>
#include <vector>

#include "clzones.h"

class Character;
class JsonObject;
class JsonOut;

// Only editable values cross the command boundary. Ownership, temporary disables,
// personal-zone cache positions and native handles are never client choices.
struct zone_edit_definition {
    std::string name;
    zone_type_id type;
    bool enabled = true;
    bool displayed = false;
    bool personal = false;
    bool invert = false;
    bool vehicle_bound = false;
    tripoint start = tripoint::zero;
    tripoint end = tripoint::zero;
    std::string options;
    int64_t vehicle = 0;
    int64_t part = 0;

    static zone_edit_definition capture( const zone_data &zone );
    bool operator==( const zone_edit_definition &other ) const;
    bool operator!=( const zone_edit_definition &other ) const;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

struct zone_edit_change {
    // Existing stable ID, or a draft-local creation token replaced by the authority.
    std::string identity;
    std::optional<zone_edit_definition> before;
    std::optional<zone_edit_definition> after;

    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

struct zone_edit_batch {
    faction_id faction;
    std::vector<zone_edit_change> changes;
    // Order is separate from definitions so a renamed zone can also be reordered.
    // Vehicle priorities are managed by the vehicle and excluded from these lists.
    std::vector<std::string> expected_order;
    std::vector<std::string> order;

    bool empty() const;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

// A menu owns this draft. Closing it without submitting has no world effects.
class zone_edit_session
{
    private:
        zone_edit_session( const Character &who, const faction_id &selected_faction );
        faction_id faction;
        zone_query_context query;
        std::vector<zone_data> drafts;
        std::vector<zone_edit_change> originals;
        std::vector<std::string> original_order;
        // Bindings remain choices for the authority to resolve by exact identity.
        std::map<std::string, std::pair<int64_t, int64_t>> bindings;

    public:
        zone_edit_session( const Character &who, zone_manager &manager,
                           const std::optional<faction_id> &selected_faction = std::nullopt );
        // Validate the whole transaction before changing native state. No prompts.
        static bool apply( Character &who, zone_manager &manager, const zone_edit_batch &batch );
        std::vector<zone_manager::ref_zone_data> get_zones();
        zone_data &add( const zone_data &zone, int64_t vehicle = 0, int64_t part = 0 );
        bool remove( const zone_data &zone );
        bool swap( zone_data &a, zone_data &b );
        bool has_near( const zone_type_id &type, const tripoint_abs_ms &where, int range ) const;
        zone_edit_batch finish() const;
        void write_view( JsonOut &out ) const;
        static std::shared_ptr<zone_edit_session> read_view( const Character &who, const JsonObject &data );
};

#endif // CATA_SRC_ZONE_EDIT_H
