local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_TECHNO_KID_INTRO",
    line = ccb.content.text("Yes, yes… *electrical crackling* Isn't it beautiful?"),
    replies = {
        {
            text = ccb.content.text("Why don't you go somewhere else?"),
            next_topic = "TALK_TECHNO_KID_LEAVE",
        },
        {
            text = ccb.content.text("Let's trade then."),
            native_actions = { "start_trade" },
            next_topic = "TALK_TECHNO_KID",
        },
        { text = ccb.content.text("I'm sorry, I gotta go."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TECHNO_KID_LEAVE",
    line = ccb.content.text("I must find more power before I can leave."),
    replies = {
        { text = ccb.content.text("Wanna get outta here?"), next_topic = "TALK_SUGGEST_FOLLOW" },
        {
            text = ccb.content.text("What can you sell me?"),
            next_topic = "TALK_TECHNO_KID",
            native_actions = { "start_trade" },
        },
        { text = ccb.content.text("I'm sorry, I gotta go."), next_topic = "TALK_DONE" },
    },
}
