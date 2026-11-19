local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_corpse_surface_1",
    line = ccb.content.text("Ah, right.  Yeah, that ain't no fahkin' cave.  I looked ovah my old maps, and couldn't find anythin' theah before <the_cataclysm>.  Whatever it is is supahnatahral, ya' undahstand?"),
    replies = { { text = ccb.content.text("Thanks, Pat.  Over and out."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_corpse_surface_2",
    line = ccb.content.text("You see that fahkin'… thing, nearby?  In the distance?  Looks like a cave, but it isn't no fahkin' cave.  I looked ovah my old maps, and couldn't find anythin' theah before <the_cataclysm>.  Whatever it is is supahnatahral, ya' undahstand?"),
    replies = { { text = ccb.content.text("Thanks, Pat.  Over and out."), next_topic = "TALK_DONE" } },
}
