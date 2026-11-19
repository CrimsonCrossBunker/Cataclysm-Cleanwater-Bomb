local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_MONSTER_CORPSE_1_RECON",
    line = ccb.content.text("Well… guess I don't have to tell you about the giant hunk of meat outside.  We've finished our subsurface scans, and if I didn't know any better, I'd say this thing is a giant piece of calamari.  Nasty shit.  I'd be shocked if it weren't for all the other strange shit going on out there these days."),
    replies = { { text = ccb.content.text("Thanks."), next_topic = "TALK_DONE" } },
}
