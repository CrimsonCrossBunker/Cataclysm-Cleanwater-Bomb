local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_CURE" },
    line = ccb.content.text("No.  I've long passed the point of no return.  Either your cure won't do anything, or it'll kill me."),
    replies = {
        {
            text = ccb.content.text("Then you must die."),
            next_topic = "TALK_DONE",
            actions = { "hostile", actions.handler("dlg_a_xedra_evolved_5c384dab2f0a") },
        },
        {
            text = ccb.content.text("I understand.  Can we talk?"),
            next_topic = "TALK_VAMPIRE_MENTOR_TALK",
        },
        {
            text = ccb.content.text("I just wanted to look around.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}
