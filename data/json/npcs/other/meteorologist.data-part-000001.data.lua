local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_meteorologist_wait",
    line = ccb.content.text("I need more time.  Come back later."),
    replies = { { text = ccb.content.text("No problem."), next_topic = "TALK_DONE" } },
}
