#pragma once
#ifndef CATA_SRC_INPUT_CONTEXT_ACTIONS_H
#define CATA_SRC_INPUT_CONTEXT_ACTIONS_H

#include <cstdint>
#include <string>
#include <vector>

namespace cata::input_context_actions
{

struct action_descriptor {
    std::string id;
    std::string label;
    std::string group;
    bool repeatable = false;
    bool dangerous = false;

    bool operator==( const action_descriptor &rhs ) const;
};

struct context_snapshot {
    std::string category;
    // HUD identity is intentionally independent from the keybinding category.
    // Generic input categories (notably UILIST) may opt into stable, distinct
    // HUD scenes without changing their bindings.
    std::string hud_scene_id;
    std::string hud_scene_title;
    int revision = 0;
    std::vector<action_descriptor> actions;
};

// Publish the named actions accepted by the input_context that is about to
// wait for input.  Internal transport actions are removed.  The revision only
// changes when the effective context or action catalogue changes.
bool needs_publish( const std::string &category,
                    const std::string &hud_scene_id,
                    const std::string &hud_scene_title,
                    const std::vector<std::string> &registered_action_ids,
                    std::uint64_t catalog_token,
                    int label_revision );
void publish( const std::string &category,
              const std::string &hud_scene_id,
              const std::string &hud_scene_title,
              const std::vector<action_descriptor> &registered_actions,
              std::uint64_t catalog_token = 0, int label_revision = 0 );

context_snapshot snapshot();

// Validate a batch of action ids against one rendered revision.  The returned
// vector matches the input order.  This lets UI bindings filter a whole
// action_slot with one lock and without copying the complete context snapshot.
std::vector<bool> validate_candidates( int context_revision,
                                       const std::vector<std::string> &actions );

// Queue one named action for the currently published context.  Risky actions
// require an explicitly-authorized long press in the Android HUD.  Other
// callers keep the default false and cannot enqueue them.
bool enqueue( const std::string &action, int context_revision,
              bool dangerous_authorized = false );
bool has_pending();

// Consume a queued action only when it is still registered by this exact
// input_context.  Stale commands are discarded instead of being replayed by a
// later screen.
bool consume( const std::vector<std::string> &registered_actions, std::string &action );

void clear();

} // namespace cata::input_context_actions

#endif // CATA_SRC_INPUT_CONTEXT_ACTIONS_H
