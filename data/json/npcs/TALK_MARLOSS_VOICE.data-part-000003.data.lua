local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_MARLOSS_VOICE_WITH_US",
    line = ccb.content.text("Oh, but you already have."),
    replies = { { text = ccb.content.text("Yes… yes I have."), next_topic = "TALK_DONE" } },
}
