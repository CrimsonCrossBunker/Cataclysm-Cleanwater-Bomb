local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_RADIATION_2_STORY1",
    line = ccb.content.text("I was working in a reactor when something big started smashing everything."),
    replies = {
        { text = ccb.content.text("Where are you from?"), next_topic = "BGSS_RADIATION_2_STORY2" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_RADIATION_2_STORY2",
    line = ccb.content.text("My coworkers and I spiked the reactor to prevent the deaths of hundreds of thousands."),
    replies = {
        { text = ccb.content.text("Tell me more?"), next_topic = "BGSS_RADIATION_2_STORY3" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_RADIATION_1_STORY3",
    line = ccb.content.text("I guess the other workers are probably all dead anyway now."),
    replies = {
        { text = ccb.content.text("How did it end?"), next_topic = "BGSS_RADIATION_2_STORY3" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
