local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BOSS_No_Others_02_Story1",
    line = ccb.content.text("I'm sorry.  I've seen hints there are other wanderers out there but I don't know how to find any of them."),
    replies = {
        {
            text = ccb.content.text("Oh well.  Let's see what happens I guess."),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
