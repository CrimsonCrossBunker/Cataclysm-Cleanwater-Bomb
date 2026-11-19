local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_CHURL_FRIENDLY",
    line = ccb.content.text("Excuse me?  Um… you mean you want to trade?"),
    replies = {
        {
            text = ccb.content.text("Ye!"),
            next_topic = "TALK_DONE",
            native_actions = { "start_trade" },
        },
    },
}
