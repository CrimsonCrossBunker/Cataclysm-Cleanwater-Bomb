local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_GUARD_A2",
    line = ccb.content.text("Hi again.  You want something?"),
    replies = {
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_CARAVAN_GUARD_A_Job",
        },
        {
            text = ccb.content.text("You looking for work?  I might be hiring."),
            next_topic = "TALK_CARAVAN_GUARD_A_Hire",
        },
        { text = ccb.content.text("Nope, just saying hi."), next_topic = "TALK_DONE" },
    },
}
