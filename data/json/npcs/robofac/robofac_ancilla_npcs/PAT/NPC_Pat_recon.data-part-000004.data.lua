local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_PAT_RECON_10",
    line = ccb.content.text("This one might be nothin', but the mercs have been talking about this lonah lives out in a cabin - this cabin, heah.  They say he's SEEN things, but everyone's got a different idea about what he's seen.  Maybe you go see for yourself?"),
    replies = { { text = ccb.content.text("Maybe I'll check it out.  Thanks."), next_topic = "TALK_DONE" } },
}
