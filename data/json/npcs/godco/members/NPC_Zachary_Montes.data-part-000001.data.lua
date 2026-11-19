local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Zachary_Intro",
    line = ccb.content.text("I got here first, therefore this place belongs to me.  Them's the rules in the <the_cataclysm>."),
    replies = {
        {
            text = ccb.content.text("Now that's an archaic belief.  I'll see you around."),
            next_topic = "TALK_DONE",
        },
    },
}
