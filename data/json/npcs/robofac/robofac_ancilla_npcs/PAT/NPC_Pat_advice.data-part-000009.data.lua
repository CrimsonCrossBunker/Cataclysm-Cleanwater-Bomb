local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_BEGGAR_2",
    line = ccb.content.text("Takes all kinds, I guess.  Never been much for lizards.  Let's treat this as a 'you' job, yeah?"),
    replies = {
        {
            text = ccb.content.text("Yeah… Right.  I guess I'll handle it.  Thanks."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_SCIENCE_REP",
    line = ccb.content.text("Workin' for the doctor is workin' for the feds.  Alright with me, but be careful."),
    replies = { { text = ccb.content.text("Thanks."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_RANCH_BARTENDER",
    line = ccb.content.text("I think it's a GREAT idea.  Maybe we help'em out, they hook us up with a steady supply, yeah?  I heard some other mercs talkin' about a still they used to keep in the woods, before it all.  Maybe that's a good place to look?"),
    replies = { { text = ccb.content.text("Thanks."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}
