local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_DOCTOR_AID_DONE",
    line = ccb.content.gendered_line("Take it easy now.  Wouldn't want you coming back here too soon.", { "speaker" }),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}
