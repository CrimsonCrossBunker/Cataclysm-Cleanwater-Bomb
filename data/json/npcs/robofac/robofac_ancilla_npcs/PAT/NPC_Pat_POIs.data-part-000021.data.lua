local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_cabin_3_reverberation_hint_1",
    line = ccb.content.text("Gotta be.  I asked around aftah we talked, and nobody has talked to that lonah in days, turns out.  They haven't been around.  They're either theah in the cabin, or gone.  Fahkin' lock'n'load and be ready.  Ovah'n'out."),
    replies = { { text = ccb.content.text("Thanks, Pat.  Over and out."), next_topic = "TALK_DONE" } },
}
