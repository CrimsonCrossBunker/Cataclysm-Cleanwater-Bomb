local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_1_ACCEPTED",
    line = ccb.content.text("Very close by.\"  The voice lists off some relative coordinates.  \"Good luck."),
    replies = { { text = ccb.content.text("I'll be back soon."), next_topic = "TALK_DONE" } },
}
