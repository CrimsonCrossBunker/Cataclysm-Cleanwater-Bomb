local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = { "BEM_HIREABLE_1" },
    line = ccb.content.text("I'm just looking for my next job.  So if you can't help with that, I rather we be on our own separate ways."),
    replies = {
        {
            text = ccb.content.text("Well then, what does it cost to hire you."),
            next_topic = "BEM_HIREABLE_2",
        },
        {
            text = ccb.content.text("Ha I prefer the cheerful sort anyways."),
            next_topic = "TALK_DONE",
        },
        { text = ccb.content.text("Well whatever."), next_topic = "TALK_DONE" },
    },
}
