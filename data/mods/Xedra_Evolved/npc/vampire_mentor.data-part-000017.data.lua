local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_KILLING_HELP" },
    line = ccb.content.text("No thanks.  I've decided long ago to never gamble my life for someone else's cause.  I prefer waiting on the side, helping those who want my help."),
    replies = {
        {
            text = ccb.content.text("I want your help, mentor."),
            next_topic = "TALK_VAMPIRE_MENTOR_MENTORING",
        },
        {
            text = ccb.content.text("Then you must die."),
            next_topic = "TALK_DONE",
            actions = { "hostile", actions.handler("dlg_a_xedra_evolved_0e28e28b2a89") },
        },
        {
            text = ccb.content.text("Got it.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}
