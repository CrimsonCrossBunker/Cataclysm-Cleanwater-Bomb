local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_OLD_GUARD_REP_2",
    line = ccb.content.text("I don't have any recon in that place.  All up to you."),
    replies = { { text = ccb.content.text("Thanks."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_OLD_GUARD_REP_3-NotMet",
    line = ccb.content.text("Robots.  The fahk is the world comin' to.  Tread carefully."),
    replies = { { text = ccb.content.text("Thanks, will do."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_OLD_GUARD_REP_3-HasMet",
    line = ccb.content.text("Isn't this just that robot you met in that fahkin' castle?"),
    replies = {
        {
            text = ccb.content.text("Oh, right, I remember that.  Thanks."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_OLD_GUARD_REP_4",
    line = ccb.content.text("Monster's the least surprising thing to be fahkin' with a road, isn't it?  I don't have any intel on the area, so you're going in blind.  Lock'n'load."),
    replies = { { text = ccb.content.text("Thanks, will do."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_OLD_GUARD_REP_MARSHALL",
    line = ccb.content.text("Way I see it, you're the Fed, not me.  This is your side gig.  Handle this how you see fit.  And word of advice: don't tell our mutual employah about this."),
    replies = { { text = ccb.content.text("Thanks."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_directions_exodii_signpost",
    line = ccb.content.text("Let me check my maps… yeah… there's nothin' there.  Or, at least, there wasn't nothin' there.  If somethin's there, it happened after it all.  Lock'n'load."),
    replies = {
        {
            text = ccb.content.text("Great, more end-of-the-world stuff."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
        },
    },
}
