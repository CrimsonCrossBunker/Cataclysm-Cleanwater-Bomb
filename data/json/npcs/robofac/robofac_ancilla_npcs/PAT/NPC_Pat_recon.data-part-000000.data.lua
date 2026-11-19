local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_RECON_DIRECTIONS_NO",
    line = ccb.content.text("Nothing new.  Check back later."),
    replies = {
        {
            text = ccb.content.text("Yeah, alright.  I'll check back later."),
            next_topic = "TALK_ROBOFAC_MERC_PAT",
        },
    },
}
