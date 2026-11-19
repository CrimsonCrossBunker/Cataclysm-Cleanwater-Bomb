local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_UPLIFTED_ANIMAL_2_STORY1",
    line = ccb.content.text("A resort created a whole line of Uplifts just like me."),
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
    id = "BGSS_UPLIFTED_ANIMAL_2_STORY2",
    line = ccb.content.text("We should have created a whole village of just us away from all the humans once the Cataclysm came."),
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
    id = "BGSS_UPLIFTED_ANIMAL_2_STORY3",
    line = ccb.content.text("Maybe we did, haha."),
    replies = {
        { text = ccb.content.text("Why didn't you?"), next_topic = "BGSS_UPLIFTED_ANIMAL_1_STORY3" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
