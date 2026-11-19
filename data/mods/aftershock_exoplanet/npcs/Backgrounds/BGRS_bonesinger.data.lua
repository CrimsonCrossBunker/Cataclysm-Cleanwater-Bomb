local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGRS_Bonesinger_STORY1",
    line = ccb.content.text("I heard the song before the aliens captured me.  I did what I could to help the other Bonesingers."),
    replies = {
        { text = ccb.content.text("Where are you from?"), next_topic = "BGRS_Bonesinger_STORY2" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGRS_Bonesinger_STORY2",
    line = ccb.content.text("One day I was being chased by some aliens and suddenly I was ambushed by another one that shot me with some kind of pain ray."),
    replies = {
        { text = ccb.content.text("Tell me more?"), next_topic = "BGRS_Bonesinger_STORY3" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGRS_Bonesinger_STORY3",
    line = ccb.content.text("Eventually they took the bones from my body.  It's strange though, I still hear the song calling to me, even in this new body."),
    replies = {
        {
            text = ccb.content.text("How did it end?"),
            next_topic = "BGSS_CRIMINAL_EXPERIMENT_STORY3",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
