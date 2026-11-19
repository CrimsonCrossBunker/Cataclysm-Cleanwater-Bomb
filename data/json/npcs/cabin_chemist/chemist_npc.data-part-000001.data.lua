local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_CABIN_CHEMIST_INTRO",
    line = ccb.content.text("So, what can I do for you?"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_CABIN_CHEMIST_ASK_INTERVAL",
    line = ccb.content.text("Unfortunately, I'm still gathering resources and cooking new stuff.  Maybe ask again after <restock_time_point>."),
    replies = {
        {
            text = ccb.content.text("Alright.  thanks nonetheless."),
            next_topic = "TALK_NPC_CABIN_CHEMIST_INTRO",
        },
    },
}
