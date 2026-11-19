local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_MAGUS_INTRO",
    line = ccb.content.text("I'm busy, what is it?"),
    replies = {
        {
            text = ccb.content.text("Why don't you go somewhere else?"),
            next_topic = "TALK_OLD_MAGUS_LEAVE",
        },
        {
            text = ccb.content.text("Let's trade then."),
            native_actions = { "start_trade" },
            next_topic = "TALK_OLD_MAGUS",
        },
        { text = ccb.content.text("I'm sorry, I gotta go."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_MAGUS_LEAVE",
    line = ccb.content.text("And leave my tower and all my research?  I think not."),
    replies = {
        { text = ccb.content.text("Wanna get outta here?"), next_topic = "TALK_SUGGEST_FOLLOW" },
        {
            text = ccb.content.text("What can you sell me?"),
            next_topic = "TALK_OLD_MAGUS",
            native_actions = { "start_trade" },
        },
        { text = ccb.content.text("I'm sorry, I gotta go."), next_topic = "TALK_DONE" },
    },
}
