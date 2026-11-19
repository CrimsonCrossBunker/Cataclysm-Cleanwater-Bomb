local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_LIXA_surface_1a_2",
    line = ccb.content.text("Right, right.  Without the intahnet I couldn't find shit about this, but I did ask around when I heard about it.  Some of the othah mercs have been avoidin' the job.  Nothin' concrete, but they just don't like the sound of it.  Doesn't bode well for us, I think.  Ovah'n'out."),
    replies = { { text = ccb.content.text("Over and out."), next_topic = "TALK_DONE" } },
}
