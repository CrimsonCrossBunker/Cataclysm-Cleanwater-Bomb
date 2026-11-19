local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_EVAC_GUARD3_deep_scan" },
    line = ccb.content.text("&It's only a moment, but that's enough.  You are looking from behind a tree onto a road where a crude roadblock has been set up.  There's a refugee bus, one of the same ones parked outside the refugee center, stopped at the roadblock, and as the driver gets out to look at the roadblock, there's a loud crack and two spots of red appear on his chest and leg.  As he begins to fall and the people in the bus start screaming, the raiders emerge from the trees, already running with guns raised."),
    replies = {
        {
            text = ccb.content.text("*Withdraw from <npc_name>'s mind*."),
            actions = {
                actions.set_actor_value("speaker", "dialogue_refugee_center_traitor_deep_scanned_evac_guard_3", "yes"),
            },
            next_topic = "TALK_EVAC_GUARD3_post_scan",
        },
    },
}
