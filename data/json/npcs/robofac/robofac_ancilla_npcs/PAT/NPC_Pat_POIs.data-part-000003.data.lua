local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_LIXA_surface_recon",
    line = ccb.content.text("That's what I thought.  Turns out theah's some chattah about this place around the Hub with the mercs.  If you're there for a scan, set up the HEW, scan from outside, and get the fahk outta theah."),
    replies = { { text = ccb.content.text("Got it.  Over and out."), next_topic = "TALK_DONE" } },
}
