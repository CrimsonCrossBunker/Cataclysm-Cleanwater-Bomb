local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_BARKEEP_JOB",
    line = ccb.content.text("If it isn't obvious, I oversee the bar here.  The scavengers bring in old world alcohol that we sell for special occasions.  For most that come through here though, the drinks we brew ourselves are the only thing they can afford."),
    replies = { { text = ccb.content.text("I see."), next_topic = "TALK_RANCH_BARKEEP" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_BARKEEP_INFORMATION",
    line = ccb.content.text("We have a policy of keeping information to ourselves.  Ask the patrons if you want to hear rumors or news."),
    replies = { { text = ccb.content.text("Thanks for nothing."), next_topic = "TALK_RANCH_BARKEEP" } },
}
