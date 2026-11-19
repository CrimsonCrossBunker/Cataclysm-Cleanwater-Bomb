local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_CROP_OVERSEER_JOB",
    line = ccb.content.text("My job is to manage our outpost's agricultural production.  I'm constantly searching for trade partners and investors to increase our capacity.  If you are interested, I typically have tasks that I need assistance with."),
    replies = {
        {
            text = ccb.content.text("I'll keep that in mind."),
            next_topic = "TALK_RANCH_CROP_OVERSEER",
        },
    },
}
