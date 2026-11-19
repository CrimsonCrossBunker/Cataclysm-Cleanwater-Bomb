local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_MILITIA_GUARD1_Introduction",
    line = ccb.content.text("I'm on watch duty.  Talk to the Boss.  He's upstairs."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MILITIA_GUARD1_BYE",
    line = ccb.content.text("Stay safe out there.  Hate to have to kill you after you've already died."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}
