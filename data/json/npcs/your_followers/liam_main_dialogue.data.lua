local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Callsigns",
    line = ccb.content.text("Roger that red burrito, that's a ten-forward on the callsigns.  Glad you like 'em."),
    replies = {
        {
            text = ccb.content.text("You're weird, my friend.  Red burrito, out."),
            next_topic = "TALK_DONE",
        },
    },
}
