local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_temple_stairs_recon",
    line = ccb.content.text("Might be.  Remembah, it's some sort of grate in the ground.  Might be tough'ta spot.  Keep an eye out."),
    replies = { { text = ccb.content.text("Right.  Over and out."), next_topic = "TALK_DONE" } },
}
