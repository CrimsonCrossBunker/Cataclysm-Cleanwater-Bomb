local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_0",
    line = ccb.content.text("Wait.  Before you go, I got an offer for you if you're interested."),
    replies = {
        {
            text = ccb.content.text("What is it?"),
            next_topic = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_1",
        },
        { text = ccb.content.text("Maybe later."), next_topic = "TALK_DONE" },
    },
}
