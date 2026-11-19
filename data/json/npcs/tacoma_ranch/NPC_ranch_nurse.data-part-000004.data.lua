local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_NURSE_AID_DONE",
    line = ccb.content.text("That's the best I can do on short notice."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}
