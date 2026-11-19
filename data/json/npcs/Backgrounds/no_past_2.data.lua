local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "CWH_NO_PAST_2_IDEAS1",
    line = ccb.content.text("To be honest… I don't really remember.  I remember vague details of my life before the world was like this, but <the_cataclysm> itself?  It's all a blur.  I think something pretty bad must have happened to me.  I remember a few things: snatches of violence, something about a woman killing her baby.  I feel like I'd rather not remember."),
    replies = { { text = ccb.content.text("Huh."), next_topic = "TALK_FRIEND_CONVERSATION" } },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_NO_PAST_2_STORY1",
    line = ccb.content.text("To be honest… I don't really remember.  I remember vague details of my life before the world was like this, but <the_cataclysm> itself?  It's all a blur.  I don't know how I got where I am now, or how any of this happened.  I think something pretty bad must have happened to me.  Or maybe I was just hit in the head really hard.  Or both.  Both seems likely.  First thing I remember is seeing an already-read text on my phone from the emergency government broadcast system, saying the United States had fallen."),
    replies = { { text = ccb.content.text("Huh."), next_topic = "TALK_FRIEND_CONVERSATION" } },
}
