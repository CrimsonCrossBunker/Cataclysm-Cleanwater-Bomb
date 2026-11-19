local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_unvitrified_orchard_recon",
    line = ccb.content.text("Ah, yeah, actually, I did.  Listen.  I'm not sure it's a good idea.  Talked to a buddy of that same fahkin' merc.  Turns out the merc was goin' to explore that house, but nevah came back.  On top'a that, now that you're close, the fahkin' feed keeps goin dead.  Don't bode well.  If ya' go, be prepared for somethin' real bad to happen.  Go get a snack, some smokes, and some watah.  Ovah."),
    replies = {
        {
            text = ccb.content.text("Got it.  Thanks, Pat.  Over and out."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_unvitrified_orchard_1",
    line = ccb.content.text("Mostly the fahkin' feed keeps goin' dead.  I've been checkin the maps, and it seems worse the closer you get to that house ovah there.  Go check it out, yeah?  Ovah'n'out."),
    replies = { { text = ccb.content.text("Over and out."), next_topic = "TALK_DONE" } },
}
