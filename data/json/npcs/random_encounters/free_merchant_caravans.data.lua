local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_GUARD_B",
    line = ccb.content.text("*tips their hat down from their eyes and looks at you blearily.  \"Huh?  Hey, I'm tryin'a sleep here.  I was on night watch.\""),
    replies = { { text = ccb.content.text("Oh, uh, sorry."), next_topic = "TALK_DONE" } },
}
