local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_SUGGEST_FOLLOW_GLOOSCAP",
    line = ccb.content.text("Maybe some day.  If you can survive for long enough I may decide to come and stay with you."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GLOOSCAP",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GLOOSCAP_DRUGS",
    line = ccb.content.text("Not enough given what's happening."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GLOOSCAP",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
