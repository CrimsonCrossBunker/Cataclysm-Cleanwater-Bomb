local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGRS_MIGO_2_STORY1",
    line = ccb.content.text("Things have been getting weird for the last couple of years.  Then we started hearing rumors of strange lights in the sky at night."),
    replies = {
        { text = ccb.content.text("Where are you from?"), next_topic = "BGRS_MIGO_2_STORY2" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGRS_MIGO_2_STORY2",
    line = ccb.content.text("One night I heard my neighbor calling for me to come help him.  I went outside wondering what he could possibly need my help with in the middle of the night."),
    replies = {
        { text = ccb.content.text("What happened next?"), next_topic = "BGRS_MIGO_2_STORY3" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGRS_MIGO_2_STORY3",
    line = ccb.content.text("Some kind of hideous alien was standing over my neighbors disemboweled corpse.  It looked at me and said 'You're a great neighbor' then everything faded to black.  I feel like everything in my body fits differently now."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
