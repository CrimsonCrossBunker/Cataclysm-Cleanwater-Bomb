local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_EXODII_MISSION_WAREHOUSE_NO_FOUND",
    line = ccb.content.text("Nothin' yet.  Check back later.  Ya' tell our employah' about it yet?  You should."),
    replies = {
        {
            text = ccb.content.text("Thanks.  I'll check in later."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
        },
    },
}
