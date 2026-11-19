local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_BACKGROUND_NO",
    line = ccb.content.text("I'm sorry, that's a bit personal.  Like, you seem alright, but that's kind of heavy stuff, y'know?  Maybe I can tell you another time."),
    replies = { { text = ccb.content.text("Alright."), next_topic = "TALK_ROBOFAC_MERC_1_MAIN" } },
}
