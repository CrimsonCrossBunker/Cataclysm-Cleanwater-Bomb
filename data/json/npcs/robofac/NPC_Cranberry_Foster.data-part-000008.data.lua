local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_HWP_NO",
    line = ccb.content.text("You'll have to work it out with the intercom.  I don't want to vouch for someone I don't really know."),
    replies = {
        {
            text = ccb.content.text("Anything I can do to change your mind?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.handler("dlg_p_dda_5518106cf401"),
        },
        {
            text = ccb.content.text("Anything I can do to change your mind?"),
            next_topic = "TALK_ROBOFAC_MERC_1_HWP_IF_I_OWE_YOU",
            when = predicates.handler("dlg_p_dda_6bb028d8c1c4"),
        },
        {
            text = ccb.content.text("Alright."),
            next_topic = "TALK_ROBOFAC_MERC_1_MAIN",
        },
    },
}
