local ccb = require("ccb")

-- If you haven't completed the opening quest yet Cody will blow you off
ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_NOT_INTERESTED_FABRICATE",
    line = {
        choices = {
            ccb.content.text("Sorry, I don't really have the time to work on something like that.  I've got lots of pieces for sale on the shelves."),
        },
    },
    replies = { { text = ccb.content.text("Alright."), next_topic = "TALK_BLACKSMITH_SERVICES" } },
}
