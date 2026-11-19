local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_SELFTEST_STORY1",
    line = ccb.content.text("I was a biohacker by trade before the Cataclysm.  I made a living out of bootlegging medicines, drugs and other copywritten biological products."),
    replies = {
        { text = ccb.content.text("Where are you from?"), next_topic = "BGSS_SELFTEST_STORY2" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_SELFTEST_STORY2",
    line = ccb.content.text("Imagine my surprise when I found myself infected with some kind of alien stem cells."),
    replies = {
        { text = ccb.content.text("Tell me more?"), next_topic = "BGSS_SELFTEST_STORY3" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_SELFTEST_STORY3",
    line = ccb.content.text("It's certainly helped me survive so far.  Was there even a choice not to take advantage of that?"),
    replies = {
        { text = ccb.content.text("How did it end?"), next_topic = "BGSS_SELFTEST_STORY3" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
