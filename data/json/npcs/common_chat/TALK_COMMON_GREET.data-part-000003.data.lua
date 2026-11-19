local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_STRANGER_FRIENDLY",
    line = ccb.content.text("Hey there, <name_g>."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_STRANGER_NEUTRAL",
    line = ccb.content.text("Hello there."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_STRANGER_WARY",
    line = ccb.content.text("Okay, no sudden movements…"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_STRANGER_SCARED",
    line = ccb.content.text("Keep your distance!"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
