local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Sonia_Angry",
    line = ccb.content.text("&Sonia doesn't say anything back, ignoring you."),
    replies = { { text = ccb.content.text("[Walk away.]"), next_topic = "TALK_DONE" } },
}
