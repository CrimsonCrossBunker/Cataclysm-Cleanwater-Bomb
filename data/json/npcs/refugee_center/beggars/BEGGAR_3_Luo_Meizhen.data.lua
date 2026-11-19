local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_MYCUS4_NOTREADY",
    line = ccb.content.text("Well.  Well, well, well.  This is really interesting.  Look, you can see reticulations here, it looks sort of like an enlarged piece of a stipe from a basidiocarp… but look at this, these fibers are clearly unlike anything I've seen before.  I wonder if they're motile?\n\nSorry.  I could stare at this all day.  I owe you one, a big one.  Thanks for this.  Let me know if you ever need a favor from a chubby beggar woman."),
    replies = {
        {
            text = ccb.content.text("Glad you like it.  If I think of something you can do in return, I'll let you know."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_RECRUITED2",
    line = ccb.content.text("Well good.  Let's get going, I want to see some more of these crazy mushrooms."),
    replies = {
        {
            text = ccb.content.text("I'll see what I can do."),
            next_topic = "TALK_DONE",
            native_actions = { "follow" },
        },
    },
}
