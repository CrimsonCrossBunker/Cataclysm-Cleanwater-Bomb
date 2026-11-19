local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = { "TALK_MENTOR_NO_CHAT" },
    line = ccb.content.text("I do not care for such frivolous things."),
    replies = {
        {
            text = ccb.content.text("Alright.  What were we talking about before?"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("See you."), next_topic = "TALK_DONE" },
    },
}
