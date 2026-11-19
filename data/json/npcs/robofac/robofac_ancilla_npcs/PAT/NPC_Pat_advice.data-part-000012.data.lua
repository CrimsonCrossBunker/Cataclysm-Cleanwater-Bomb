local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_REFUGEES_misc",
    line = ccb.content.text("I think ya' shouldn't be so involved.  Doesn't seem like there's much pay in it.  This is a 'you' job, yeah?"),
    replies = {
        {
            text = ccb.content.text("Sure, that's fair."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_TACOMA_Nunez",
    line = ccb.content.text("I think you shouldn't be involved heah.  No pay in it.  Not your business.  But hey, ya' are.  Might as well see it through."),
    replies = {
        {
            text = ccb.content.text("Sure, that's fair."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
        },
    },
}
