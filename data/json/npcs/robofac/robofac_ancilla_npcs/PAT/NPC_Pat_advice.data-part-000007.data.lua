local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_BROKER_1",
    line = ccb.content.text("More jahrs.  You got me stumped on this one.  I'll leave this one up to you.  Fahkin' jahrs."),
    replies = {
        {
            text = ccb.content.text("Yeah, fair enough."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
        },
    },
}
