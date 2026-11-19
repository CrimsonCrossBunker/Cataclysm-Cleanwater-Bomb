local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Dana_Tacoma2",
    line = ccb.content.text("All right.  I've taken some time to think about it, and I'm willing to go.  I'm sure they'll have use for a baker over there, after all, and if I don't get out of this place there's a very real chance I'm going to snap.  You can go let Pablo know first hand, if you want; he's been pretty excited about the idea."),
    replies = { { text = ccb.content.text("Sure, I'll go tell him.  Cool!"), next_topic = "TALK_DONE" } },
}
