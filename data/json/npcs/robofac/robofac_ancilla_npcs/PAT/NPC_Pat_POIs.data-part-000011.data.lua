local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_exodii_base_x0y0z0_recon",
    line = ccb.content.text("Gotta fahkin' be.  Listen, I got an update.  While ya' was gone, I met some merc hangin' around with a strange gun - it's relevant, I sweah.  Anyway.  Asked'em where he got it, and he told me to mind my own fahkin' business, so I told him to fahk off, and anyway, long story short, he says he got it off some killah robot he found out in the wildahness, near some kind of fahkin' scrap-metal pod with a sign.  I dunno.  Seems relevant.  If it's killah-fahkin' robots, set the HEW up, get a scan, and bounce.  Ovah'n'out."),
    replies = { { text = ccb.content.text("Thanks, Pat.  Over and out."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_exodii_base_x0y0z0_1",
    line = ccb.content.text("Ah, right.  Now that ya mention it, I saw some merc hangin' around with a strange gun - it's relevant, I sweah.  Anyway.  Asked'em where he got it, and he told me to mind my own fahkin' business, so I told him to fahk off, and anyway, long story short, he says he got it off some killah robot he found out in the wildahness, near some kind of fahkin' scrap-metal pod with a sign.  I dunno.  Seems relevant.  Ovah'n'out."),
    replies = { { text = ccb.content.text("Thanks, Pat.  Over and out."), next_topic = "TALK_DONE" } },
}
