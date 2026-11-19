local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_UPLIFTED_ANIMAL_3_STORY1",
    line = ccb.content.text("I grew up on an island with a doctor."),
    replies = {
        {
            text = ccb.content.text("Where are you from?"),
            next_topic = "BGSS_UPLIFTED_ANIMAL_3_STORY2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_UPLIFTED_ANIMAL_3_STORY2",
    line = ccb.content.text("I had so many brothers and sisters."),
    replies = {
        { text = ccb.content.text("Tell me more?"), next_topic = "BGSS_UPLIFTED_ANIMAL_3_STORY3" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_UPLIFTED_ANIMAL_3_STORY3",
    line = ccb.content.text("We ate him."),
    replies = {
        { text = ccb.content.text("How did it end?"), next_topic = "BGSS_UPLIFTED_ANIMAL_3_STORY3" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
