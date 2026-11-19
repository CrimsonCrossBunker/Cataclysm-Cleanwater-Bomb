local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_LEAVE",
    line = ccb.content.text("You're really leaving?"),
    replies = {
        {
            text = ccb.content.text("Yeah, I'm sure.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
            native_actions = { "leave" },
            opinion = { trust = -2, anger = 1 },
        },
        { text = ccb.content.text("Nah, I'm just kidding."), next_topic = "TALK_NONE" },
    },
}
