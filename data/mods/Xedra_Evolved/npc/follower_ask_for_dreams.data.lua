local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_CANNOT_PRODUCE_DREAMDROSS_MANA",
    line = ccb.content.text("I can't do that right now.  I need time to recover my mana."),
    replies = {
        {
            text = ccb.content.text("Got it.  Can we talk about something else?"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("Got it.  See you later."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CANNOT_PRODUCE_DREAMDROSS_TIME",
    line = ccb.content.text("I can't do that right now.  I need time to gather more dreamdross."),
    replies = {
        {
            text = ccb.content.text("Got it.  Can we talk about something else?"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("Got it.  See you later."), next_topic = "TALK_DONE" },
    },
}
