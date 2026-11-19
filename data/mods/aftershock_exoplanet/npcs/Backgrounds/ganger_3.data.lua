local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_GANGER_3_STORY1",
    line = ccb.content.text("There's so much sky out here.  It's horrible."),
    replies = {
        {
            text = ccb.content.text("You seem like you are out of your element."),
            next_topic = "BGSS_GANGER_3_STORY2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_GANGER_3_STORY2",
    line = ccb.content.text("It might be worse than the dead rising."),
    replies = {
        { text = ccb.content.text("What will you do?"), next_topic = "BGSS_GANGER_3_STORY3" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_GANGER_3_STORY3",
    line = ccb.content.text("I'm going to kill my way back into the city so I can get out from under this sky."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
