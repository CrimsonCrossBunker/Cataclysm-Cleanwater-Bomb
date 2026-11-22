local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "THI_CONTROL_PLOT_KNOWN" },
    line = ccb.content.text("**Listing known local waypoints: **"),
    replies = {
        {
            text = ccb.content.text("High orbit over Salus IV"),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_aftershock_exoplanet_92b580caf574"),
            actions = { actions.handler("w16b_a_aftershock_exoplanet_069b11697a25") },
            show_always = true,
            show_reason = "You are already in orbit.",
        },
        {
            text = ccb.content.text("Salus IV Spaceport"),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_aftershock_exoplanet_d926b2f28ac0"),
            actions = { actions.handler("w16b_a_aftershock_exoplanet_f1438d0f1249") },
            show_always = true,
            show_reason = "You are already at this location.",
        },
        {
            text = ccb.content.text("Cancel."),
            next_topic = "THI_CONTROL_START",
        },
    },
}
