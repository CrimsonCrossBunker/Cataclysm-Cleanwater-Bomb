local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_RURAL_1_FARMSUCCESS",
    line = ccb.content.text("I guess you look sturdy enough to take them on.  I marked the spot for you."),
    replies = {
        {
            text = ccb.content.text("Thanks for the directions.  I'll check it out."),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_RURAL_1_FARMFAILURE",
    line = ccb.content.text("I don't know if I trust you quite like that, just giving away so many personal details all at once.  Maybe later…"),
    replies = { { text = ccb.content.text("Sorry, didn't mean to intrude."), next_topic = "TALK_NONE" } },
}
