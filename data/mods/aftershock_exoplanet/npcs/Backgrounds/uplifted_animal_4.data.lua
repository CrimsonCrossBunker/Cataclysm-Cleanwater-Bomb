local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_UPLIFTED_ANIMAL_4_STORY1",
    line = ccb.content.text("The zoo designed me to be a link between my original species and humans studying us."),
    replies = {
        {
            text = ccb.content.text("Where are you from?"),
            next_topic = "BGSS_UPLIFTED_ANIMAL_4_STORY2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_UPLIFTED_ANIMAL_4_STORY2",
    line = ccb.content.text("I was there when the Cataclysm happened.  Many animals were infected."),
    replies = {
        { text = ccb.content.text("Tell me more?"), next_topic = "BGSS_UPLIFTED_ANIMAL_4_STORY3" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_UPLIFTED_ANIMAL_4_STORY3",
    line = ccb.content.text("Zombears are terrifying creatures of destruction."),
    replies = {
        { text = ccb.content.text("How did it end?"), next_topic = "BGSS_UPLIFTED_ANIMAL_4_STORY3" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
