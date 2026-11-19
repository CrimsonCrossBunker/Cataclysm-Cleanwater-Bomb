local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_PAT_RECON_1",
    line = ccb.content.text("I bought these photos off a merc.  Just looks like some house outta town, but look, there are some odd ahrtifacts - little floatin' distortions - all over'em.  I've seen ghost shows.  The merc was a believah, so they didn't try and loot it.  Gotta be somethin' there, though.  Worth a scan."),
    replies = { { text = ccb.content.text("Maybe I'll check it out.  Thanks."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_PAT_RECON_2",
    line = ccb.content.text("Shared a smoke with a merc that took these photos of a Depahtment of Energy facility.  Nothin' more ominous than the DOE, yeah?  Worth a scan."),
    replies = { { text = ccb.content.text("Maybe I'll check it out.  Thanks."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_PAT_RECON_3",
    line = ccb.content.text("Fahka' sold me this - for a full coin I might add - said it's a fahkin' treasure map.  I was hard up for fresh data, so I bought it.  Says there's a grate out in the contry, and treasure underneath.  Figured it's worth checkin' out, anyway."),
    replies = { { text = ccb.content.text("Maybe I'll check it out.  Thanks."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_PAT_RECON_4",
    line = ccb.content.text("Check out these photos - looks like some kind of minin' operation.  But the strange thing is that, apparently, the ground was a rumblin', and the tradah that passed by swore they heard screams.  Not the zombie kind neithah.  Worth a scan - from the pahking lot, maybe."),
    replies = { { text = ccb.content.text("Maybe I'll check it out.  Thanks."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_PAT_RECON_5",
    line = ccb.content.text("This is a doozy.  This guy, all out of his mind, came by and swore he saw this scrap-metal castle just fahkin' BLIP into existence.  So crazy a story I doubt he made it up.  Lock'n'load and check it out, yeah?"),
    replies = { { text = ccb.content.text("Maybe I'll check it out.  Thanks."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_PAT_RECON_6",
    line = ccb.content.text("I picked these up off a tradah in exchange for some cigs - didn't tell me where they got'em.  Most of it's redacted, which probably means strange shit, no?  But I'm seein' here all these order forms for materials to build ventilation shafts, and a few geological reports say somethin' about forests.  It isn't much to go on, but keep an eye out for strange shit in the woods, yeah?"),
    replies = { { text = ccb.content.text("I'll keep an eye out.  Thanks."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_PAT_RECON_7",
    line = ccb.content.text("Came fresh off another merc claims they got it on a job from our employah, but wouldn't say too much more.  I coaxed a location out'of'em.  Given how secretive they were, I think it's worth a look and a scan, yeah?"),
    replies = { { text = ccb.content.text("Maybe I'll check it out.  Thanks."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_PAT_RECON_8",
    line = ccb.content.text("All I've got is that photo and a location.  It's some kind of building, glowing all purple.  I'd take a hazmat suit, if you got one.  Maybe it's freakin' nukes or some shit, yeah?"),
    replies = { { text = ccb.content.text("Maybe I'll check it out.  Thanks."), next_topic = "TALK_DONE" } },
}
