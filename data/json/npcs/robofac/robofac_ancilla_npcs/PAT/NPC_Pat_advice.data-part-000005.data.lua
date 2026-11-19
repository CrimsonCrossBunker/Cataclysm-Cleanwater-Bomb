local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_FREE_MERCHANTS_EVAC_3",
    line = ccb.content.text("Honestly, good to know people are buildin' things up.  Maybe we can get some use out'a'em, too, yeah?  Don't have much to say til we hear'em out."),
    replies = { { text = ccb.content.text("Thanks a lot."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_FREE_MERCHANTS_EVAC_4",
    line = ccb.content.text("This is the northeast, pal.  Go further northeast and every off-the-grid nerd you bump into'll have some on their house.  Check roofs."),
    replies = { { text = ccb.content.text("Thanks a lot."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}
