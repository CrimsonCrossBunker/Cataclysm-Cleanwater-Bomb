local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_NO_PAST_2_STORY1",
    line = ccb.content.text("To be honest… I don't really remember.  I remember vague details of my life before the world was like this, but <the_cataclysm> itself?  It's all a blur.  I don't know how I got where I am now, or how any of this happened.  I think something pretty bad must have happened to me.  Or maybe I was just hit in the head really hard.  Or both.  Both seems likely.  First thing I remember is seeing a beautiful young woman with her face covered with blood, laughing and saying everything had fallen and it was all over."),
    replies = { { text = ccb.content.text("Huh."), next_topic = "TALK_FRIEND" } },
}
