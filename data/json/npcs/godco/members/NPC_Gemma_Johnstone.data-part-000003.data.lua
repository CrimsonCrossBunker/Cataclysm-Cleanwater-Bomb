local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Gemma_Story",
    line = ccb.content.text("My story?  It's been told a thousand times."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Gemma_Leader",
    line = ccb.content.text("I always have things on the go: tidying, organizing, cleaning, but I don't complain.  I never complain."),
    replies = {
        {
            text = ccb.content.text("Is there anything I can do to help you out?"),
            next_topic = "TALK_GODCO_Gemma_Help",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("There sure is.  <end_talking_bye>"), next_topic = "TALK_DONE" },
    },
}
