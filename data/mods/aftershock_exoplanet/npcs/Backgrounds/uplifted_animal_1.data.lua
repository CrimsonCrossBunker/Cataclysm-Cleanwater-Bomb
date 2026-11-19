local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_UPLIFTED_ANIMAL_1_STORY1",
    line = ccb.content.text("I was created to be a billionaire's companion."),
    replies = {
        {
            text = ccb.content.text("Where are you from?"),
            next_topic = "BGSS_UPLIFTED_ANIMAL_1_STORY2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_UPLIFTED_ANIMAL_1_STORY2",
    line = ccb.content.text("Their wealth and connections didn't save them."),
    replies = {
        {
            text = ccb.content.text("So, what happened?"),
            next_topic = "BGSS_UPLIFTED_ANIMAL_1_STORY3",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_UPLIFTED_ANIMAL_1_STORY3",
    line = ccb.content.text("But they built me with the ability to survive a world beyond imagining."),
    replies = {
        {
            text = ccb.content.text("But here you are?"),
            next_topic = "BGSS_UPLIFTED_ANIMAL_1_STORY3",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
