local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_REFUGEE_C_LOVE",
    line = ccb.content.text("I love you."),
    replies = {
        { text = ccb.content.text("Oh, uh, thanks.  I guess."), next_topic = "TALK_DONE" },
        { text = ccb.content.text("No thank you."), next_topic = "TALK_DONE" },
    },
}
