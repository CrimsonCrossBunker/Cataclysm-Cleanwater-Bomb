local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_TEAMSTER_CHAT",
    line = ccb.content.text("Sure, got nothin' to load up just now."),
    replies = {
        {
            text = ccb.content.text("I've gotta run, nice talking to you."),
            next_topic = "TALK_DONE",
        },
    },
}
