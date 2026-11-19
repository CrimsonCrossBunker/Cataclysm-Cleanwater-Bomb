local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_BUSY",
    line = {
        choices = {
            ccb.content.text("I'm already working on something for you.  I only got two hands and 24 hours in a day."),
        },
    },
    replies = { { text = ccb.content.text("Alright."), next_topic = "TALK_BLACKSMITH_SERVICES" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_PROTOTYPE_ONGOING",
    line = { choices = { ccb.content.text("I'm still working on it, can't rush perfection.") } },
    replies = { { text = ccb.content.text("Alright."), next_topic = "TALK_BLACKSMITH_SERVICES" } },
}
