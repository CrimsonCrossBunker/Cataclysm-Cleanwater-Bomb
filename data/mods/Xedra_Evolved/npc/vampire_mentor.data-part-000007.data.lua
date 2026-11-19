local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_POWER" },
    line = ccb.content.text("It's not something I do, it's something you'll do.  I know it'll be asking a lot from you, but I hope you'll understand why we are doing it."),
    replies = {
        { text = ccb.content.text("What is it?"), next_topic = "TALK_VAMPIRE_MENTOR_SACRIFICE" },
        { text = ccb.content.text("Don't tell me.  I'm going."), next_topic = "TALK_DONE" },
    },
}
