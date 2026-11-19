local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_RADIATION_1_STORY1",
    line = ccb.content.text("When the government gave up on saving the depths of the city someone decided to use tactical nukes and buy time for the retreat."),
    replies = {
        { text = ccb.content.text("Where are you from?"), next_topic = "BGSS_RADIATION_1_STORY2" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_RADIATION_1_STORY2",
    line = ccb.content.text("It blew an opening in the horde roaming the city and allowed me to escape."),
    replies = {
        { text = ccb.content.text("Tell me more?"), next_topic = "BGSS_RADIATION_1_STORY3" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_RADIATION_1_STORY3",
    line = ccb.content.text("Every choice has consequences though.  But every consequence is probably worth it, if it's the only way to survive."),
    replies = {
        { text = ccb.content.text("How did it end?"), next_topic = "BGSS_RADIATION_1_STORY3" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
