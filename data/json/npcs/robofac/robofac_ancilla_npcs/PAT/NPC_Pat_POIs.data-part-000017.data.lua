local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_morgantown_2b_far_1",
    line = ccb.content.text("Yeah, some old place in the woods, all fenced off.  That place is fahkin' hauwnted - my uncle told me all about it.  They say it's full of ghosts and shit like that.  Wicked scary.  I don't believe in ghosts, don't get me wrong, but I didn't believe in zombies either before <the_cataclysm>, so, ya' know, put that in ya' pipe and smoke it."),
    replies = { { text = ccb.content.text("I'll be careful.  Over and out."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_morgantown_2b_close",
    line = ccb.content.text("&You hear a chirp in your comm and Pat's hushed voice comes over the line: \"Listen', don' respond.  I've just got a picture come through and I see them THINGS over theah.  Those freaky little SHITS look just like the parabolic dishes I used'ta'use to pickup sat signals.  If this ain't some tabletop RPG dumbass nerd shit I don't know what is, but I'd bet they use them to hear.  Be quiet or get the fahk outta' there.  Bettah' yeah, go around back and fiah off a few shots, yeah?  Maybe they'll scramble over there n' you can poke around in safety.\""),
    replies = { { text = ccb.content.text("[Chirp Pat once and stay silent]"), next_topic = "TALK_DONE" } },
}
