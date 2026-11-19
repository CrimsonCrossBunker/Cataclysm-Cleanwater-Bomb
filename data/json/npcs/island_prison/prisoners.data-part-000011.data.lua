local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_PRISONER_LEADER_TRIAL_SUCCESS",
    line = ccb.content.text("Okay.  It was convincing.  I'll still get what I want, one way or another.  You better watch your back from now on."),
    replies = { { text = ccb.content.text("Noted.  <end_talking_bye>"), next_topic = "TALK_DONE" } },
}
