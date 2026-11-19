local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_xedra_rural_church_recon",
    line = ccb.content.text("Yeah, check this out.  Aftah we talked I tracked down the merc that sold me the photo.  Turns out she went back.  She opened the door, crawled through a fahkin' blocked-up hallway, and got inside.  She tells me she opens the next door an' BAM - somethin' grabs her.  She said it didn' fahkin' hurt, but it was STRONG.  Wicked strong.  Said she couldn' even describe it, just, like, some kinda' fahkin' THING.  So whatevah it is, if ya' get close, make sure ya' got an escape, yeah?  Don't just fahkin' bumble in there like an idiot.  Pat ovah'n'out."),
    replies = { { text = ccb.content.text("Thanks, Pat.  Over and out."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_xedra_rural_church_1",
    line = ccb.content.text("&The comm is silent a moment before Pat chirps back.  \"Dunno if it's helpful, but my old map cache says there's a church theah.  Go slow, quiet, and careful, yeah?"),
    replies = { { text = ccb.content.text("Thanks, Pat.  Over and out."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_xedra_rural_church_2",
    line = ccb.content.text("Look closah, theah, in the distance.  Caught it on one'a the pics that came through.  Look's like it's glowin' purple.  Checked my maps, and it's definitely that church theah in the distance.  Somethin' goin' on.  Go slow, quiet, careful, yeah?"),
    replies = { { text = ccb.content.text("Thanks, Pat.  Over and out."), next_topic = "TALK_DONE" } },
}
