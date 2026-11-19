local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_PLAYER_LEADS",
    line = ccb.content.text("Alright.  You can lead now."),
    replies = {
        { text = ccb.content.text("Good.  Something else…"), next_topic = "TALK_FRIEND" },
        { text = ccb.content.text_without_extraction("<lets_go>"), next_topic = "TALK_NONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LEADER_STAYS",
    replies = { { text = ccb.content.text("Okay, okay."), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_DESCRIBE_MISSION",
    replies = {
        { text = ccb.content.text("I see."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
