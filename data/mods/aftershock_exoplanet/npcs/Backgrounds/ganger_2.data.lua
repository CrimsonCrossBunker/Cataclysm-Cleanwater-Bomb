local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_GANGER_2_STORY1",
    line = ccb.content.text("I've spent my life in the hive.  When things started turning strange I snuck out of the city."),
    replies = {
        {
            text = ccb.content.text("You seem like you are out of your element."),
            next_topic = "BGSS_GANGER_2_STORY2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_GANGER_2_STORY2",
    line = ccb.content.text("I've never seen so many trees outside of a video.  And there is so much wildlife."),
    replies = {
        { text = ccb.content.text("What will you do?"), next_topic = "BGSS_GANGER_2_STORY3" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_GANGEER_2_STORY3",
    line = ccb.content.text("I'm going to live my best life in a dead world."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
