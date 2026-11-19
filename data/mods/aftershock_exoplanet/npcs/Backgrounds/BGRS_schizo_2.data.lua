local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGRS_SCHIZO_2_STORY1",
    line = ccb.content.text("If you think this Universe is bad, you should see some of the others."),
    replies = {
        { text = ccb.content.text("Where are you from then?"), next_topic = "BGRS_SCHIZO_2_STORY2" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGRS_SCHIZO_2_STORY2",
    line = ccb.content.text("Believing something existed and then finding out it didn't was like reaching the top of the stairs and thinking there was one more step."),
    replies = {
        {
            text = ccb.content.text("What does that have to do with anything?"),
            next_topic = "BGRS_SCHIZO_2_STORY3",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGRS_SCHIZO_2_STORY3",
    line = ccb.content.text("I think a lot of psychopaths are just geniuses who drove so fast that they lost control."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
