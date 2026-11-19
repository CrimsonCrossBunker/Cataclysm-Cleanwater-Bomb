local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GUNSMITH_TURRETS",
    line = ccb.content.text("*stares off into the distance.  \"The owners didn't need them anymore.  Not anymore…\""),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_GUNSMITH_SERVICES" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GUNSMITH_CODY",
    line = ccb.content.text("Stuff is fucked all over, bud.  How about we stick to talking business?"),
    replies = { { text = ccb.content.text("Alright."), next_topic = "TALK_GUNSMITH_SERVICES" } },
}
