local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = { "TALK_EVAC_GUARD3_post_scan" },
    line = ccb.content.text("&Only a few moments have passed.  <npc_name> hasn't noticed anything amiss."),
    replies = {
        { text = ccb.content.text("…"), next_topic = "TALK_EVAC_GUARD3" },
        {
            text = ccb.content.text("It's you."),
            next_topic = "TALK_EVAC_GUARD3_direct_accusation",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_refugee_center_traitor_deep_scanned_evac_guard_3" } }),
        },
    },
}
