local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_HEALER_GREY_INTRO",
    line = ccb.content.text("Blessed be.  May you purge that which opposes the calm."),
    replies = {
        {
            text = ccb.content.text("Why don't you go somewhere else?"),
            next_topic = "TALK_HEALER_GREY_LEAVE",
        },
        {
            text = ccb.content.text("Let's trade then."),
            native_actions = { "start_trade" },
            next_topic = "TALK_HEALER_GREY",
        },
        { text = ccb.content.text("I'm sorry, I gotta go."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_HEALER_GREY_LEAVE",
    line = ccb.content.text("I must purge this place before I can move on."),
    replies = {
        { text = ccb.content.text("Wanna get outta here?"), next_topic = "TALK_SUGGEST_FOLLOW" },
        {
            text = ccb.content.text("What can you sell me?"),
            next_topic = "TALK_HEALER_GREY",
            native_actions = { "start_trade" },
        },
        { text = ccb.content.text("I'm sorry, I gotta go."), next_topic = "TALK_DONE" },
    },
}
