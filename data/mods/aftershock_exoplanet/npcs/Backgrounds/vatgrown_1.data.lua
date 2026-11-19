local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_VATGROWN_1_STORY1",
    line = ccb.content.text("I'm a vatgrown, an almost man, a MacDuff.  I was a product in the Old World."),
    replies = {
        { text = ccb.content.text("Where are you from?"), next_topic = "BGSS_VATGROWN_1_STORY2" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_VATGROWN_1_STORY2",
    line = ccb.content.text("Now there are too few people left to differentiate.  Other than those morons afraid of mutants."),
    replies = {
        { text = ccb.content.text("Tell me more?"), next_topic = "BGSS_VATGROWN_1_STORY3" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_VATGROWN_1_STORY3",
    line = ccb.content.text("Now I choose the cause I'll die for."),
    replies = {
        { text = ccb.content.text("How did it end?"), next_topic = "BGSS_VATGROWN_1_STORY3" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
