local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_CYBERNINJA_STORY1",
    line = ccb.content.text("As a corporate wetworks specialist I'm used to crazy situations.  But this is like nothing I've ever experienced."),
    replies = {
        {
            text = ccb.content.text("What are you going to do now?"),
            next_topic = "BGSS_CYBERNINJA_STORY2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_CYBERNINJA_STORY2",
    line = ccb.content.text("I'm gonna find somewhere that people are making a stand.  And if I can agree with their plans I'll make my stand with them."),
    replies = {
        { text = ccb.content.text("Where is that?"), next_topic = "BGSS_CYBERNINJA_STORY3" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_CYBERNINJA_STORY3",
    line = ccb.content.text("Right now you are looking like the best leader I've met so far in this Cataclysm."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
