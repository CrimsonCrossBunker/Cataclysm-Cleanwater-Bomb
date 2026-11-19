local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_GANGER_1_STORY1",
    line = ccb.content.text("I was born at the bottom of the habitat.  No silver spoon in my mouth."),
    replies = {
        {
            text = ccb.content.text("That must have been rough."),
            next_topic = "BGSS_GANGER_1_STORY2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_GANGER_1_STORY2",
    line = ccb.content.text("I saw my best friend die in front of me by the time I was eight."),
    replies = {
        { text = ccb.content.text("Where is that?"), next_topic = "BGSS_GANGER_1_STORY3" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_GANGEER_1_STORY3",
    line = ccb.content.text("I guess it prepared me for everyone dying yesterday."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
