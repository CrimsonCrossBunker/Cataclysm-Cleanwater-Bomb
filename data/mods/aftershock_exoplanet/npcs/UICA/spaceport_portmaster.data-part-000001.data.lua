local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_SPACEPORT_PORTMASTER",
    line = ccb.content.text("Do you want to book passage back to the station?"),
    replies = {
        {
            text = ccb.content.text("That's why I'm here."),
            next_topic = "TALK_SPACEPORT_PORTMASTER_UP",
        },
        { text = ccb.content.text("Not right now."), next_topic = "TALK_DONE" },
    },
}
