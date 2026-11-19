local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_INTRO_4",
    line = ccb.content.text("There is something else that has come up on our side which requires some field agents.  Would you like to hear about it?"),
    replies = {
        {
            text = ccb.content.text("Sounds like you have work for me?  Count me in."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_1_OFFER",
        },
        { text = ccb.content.text("Maybe not right now."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_1_JOBS",
    line = ccb.content.text("Right.  Your handling of this situation was exemplary, and it's clear to us that we greatly underestimated our potential for mutual benefit.  If you are interested, we are willing to offer you more work going forward, and all of it will have proper compensation from now on."),
    replies = {
        {
            text = ccb.content.text("And the trading we agreed on?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_1_JOBS_2",
        },
    },
}
