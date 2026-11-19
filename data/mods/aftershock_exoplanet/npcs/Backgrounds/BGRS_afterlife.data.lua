local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGRS_AFTERLIFE_1_STORY1",
    line = ccb.content.text("What level of hell is this?  I spent weeks in a sulfurous hell being tortured."),
    replies = {
        { text = ccb.content.text("What was that like?"), next_topic = "BGRS_AFTERLIFE_1_STORY2" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGRS_AFTERLIFE_1_STORY2",
    line = ccb.content.text("Then they started cutting me open and taking out my organs but adding new ones."),
    replies = {
        { text = ccb.content.text("How did it end?"), next_topic = "BGRS_AFTERLIFE_1_STORY3" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGRS_AFTERLIFE_1_STORY3",
    line = ccb.content.text("Now that I finally am able to move and have some freedom, I plan on finding some of these demons and punching through them until I find the devil himself."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
