local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_NEC_COMMO_GOAL",
    line = ccb.content.text("We are securing the external communications array for this facility.  I'm rather restricted in what I can release… go find my commander if you have any questions."),
    replies = {
        {
            text = ccb.content.text("I'll try and find your commander then…"),
            next_topic = "TALK_NONE",
        },
    },
}
