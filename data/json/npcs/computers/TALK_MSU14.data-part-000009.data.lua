local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "MSU14_UNIT_ACCESS",
    line = ccb.content.text("&Module Name - Notice of Deactivation\nThis unit has been disconnected and its predictive capabilities disabled.  Please press any key to export the results of the last logged experiment.\n\nNo further input will be processed.\nHave a nice day."),
    on_enter = {
        { actions = { actions.set_actor_value("speaker", "computer_hacking_msu14_hack", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("Press any key and shut down."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_e3b47843f525") },
        },
    },
}
