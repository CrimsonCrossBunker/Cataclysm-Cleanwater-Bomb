local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_BOOKS_DELIVER",
    line = ccb.content.text("Excellent.  What new stories have you brought me?"),
    replies = {
        {
            text = ccb.content.text("Well, let's see."),
            native_actions = { "start_trade" },
            next_topic = "TALK_FORGE_LORD",
        },
    },
}
