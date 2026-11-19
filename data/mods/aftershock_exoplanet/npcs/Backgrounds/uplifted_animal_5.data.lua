local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_UPLIFTED_ANIMAL_5_STORY1",
    line = ccb.content.text("I was part of a black ops paramilitary unit.  I still don't know if I worked for the government or a corporation."),
    replies = {
        {
            text = ccb.content.text("Where are you from?"),
            next_topic = "BGSS_UPLIFTED_ANIMAL_5_STORY2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_UPLIFTED_ANIMAL_5_STORY2",
    line = ccb.content.text("My team was sent in to a lab on a purge in fire mission.  The things I saw in there haunt me."),
    replies = {
        { text = ccb.content.text("Tell me more?"), next_topic = "BGSS_UPLIFTED_ANIMAL_5_STORY3" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_UPLIFTED_ANIMAL_5_STORY3",
    line = ccb.content.text("Others may have survived but I doubt it.  I certainly hope they haven't come back."),
    replies = {
        { text = ccb.content.text("How did it end?"), next_topic = "BGSS_UPLIFTED_ANIMAL_5_STORY3" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
