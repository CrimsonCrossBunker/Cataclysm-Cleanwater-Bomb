local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_PAT_RECON_13",
    line = ccb.content.text("This fahkin' merc stumbled in, sweatin' like a pig, and snortin', too.  Well, not snortin', really, but coughing.  They were hawkin' some smokes.  I says: \"that doesn't seem like a good idea, right?\"  Given' the coughin', right?  \"The fahk is in'em,\" I said?  Well, they say: \"ah, the coughin' is from some dust storm.\"  They described it as some sort of fuckin' fog - nasty shit you can't breath in.  Smells like the old Y, apparently.  Doesn't sound safe or natural, but maybe you go see for yourself?  Interestin' weather phenomenon if nothin' else."),
    replies = {
        { text = ccb.content.text("The old Y?"), next_topic = "MISSION_ROBOFAC_PAT_RECON_13_old_y" },
        { text = ccb.content.text("Maybe I'll check it out.  Thanks."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_PAT_RECON_13_old_y",
    line = ccb.content.text("Yeah, the YMCA, ya' know?  The one with the pool.  He said is smells like a fahkin' pool.  You know, right after they dump all that chlorine in.  Bad sign for that cloud being safe, ah'll tell ya' that."),
    replies = {
        {
            text = ccb.content.text("Maybe I'll check it out.  Thanks for the warning, Pat."),
            next_topic = "TALK_DONE",
        },
    },
}
