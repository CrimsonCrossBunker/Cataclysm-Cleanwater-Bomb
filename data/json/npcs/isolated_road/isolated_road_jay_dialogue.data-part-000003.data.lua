local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GUNSMITH_ABOUT",
    line = ccb.content.text("I did a boring IT job and prepped for this shit.  Look at me now."),
    replies = {
        { text = ccb.content.text("Look at you now."), next_topic = "TALK_GUNSMITH_SERVICES" },
        { text = ccb.content.text("…"), next_topic = "TALK_GUNSMITH_SERVICES" },
    },
}
