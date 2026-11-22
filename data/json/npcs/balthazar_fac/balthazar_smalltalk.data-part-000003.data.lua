local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_ROBOTS_STRONG",
    line = ccb.content.text("I got a control center.  Anything else or will you hear me out now?"),
    on_enter = {
        { once = "knows_control_center", actions = { actions.handler("dlg_a_dda_219009214fa4") } },
    },
    replies = {
        {
            text = ccb.content.text("Fine, what do you need help with?"),
            next_topic = "TALK_BALTHAZAR_MEET_STRONG",
        },
        {
            text = ccb.content.text("There was something else…"),
            next_topic = "TALK_BALTHAZAR_INTERCOM_MAIN",
        },
    },
}
