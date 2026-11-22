local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_ROBOTS_WEAK",
    line = ccb.content.text("This bunker has a control center for the local bots so I made them only attack when attacked first."),
    on_enter = {
        { once = "knows_control_center", actions = { actions.handler("dlg_a_dda_219009214fa4") } },
    },
    replies = {
        {
            text = ccb.content.text("Sounds useful."),
            next_topic = "TALK_BALTHAZAR_INTERCOM_MAIN",
        },
    },
}
