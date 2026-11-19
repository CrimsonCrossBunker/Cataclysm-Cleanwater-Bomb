local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_Whately_STORY1",
    line = ccb.content.text("Staying at the family compounds scattered across New England, we've managed to maintain some organization post Cataclysm."),
    replies = {
        { text = ccb.content.text("Where are you from?"), next_topic = "BGSS_Whately_STORY2" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_Whately_STORY2",
    line = ccb.content.text("The Whately family has been outcast in these parts for centuries.  But it made us stronger as a family."),
    replies = {
        { text = ccb.content.text("Tell me more?"), next_topic = "BGSS_Whately_STORY3" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_Whately_STORY3",
    line = ccb.content.text("We've been talking to those from other places from the beginning."),
    replies = {
        { text = ccb.content.text("How did it end?"), next_topic = "BGSS_Whately_STORY4" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_Whately_STORY4",
    line = ccb.content.text("All the earth was flame in a holocaust of ecstasy and freedom."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
