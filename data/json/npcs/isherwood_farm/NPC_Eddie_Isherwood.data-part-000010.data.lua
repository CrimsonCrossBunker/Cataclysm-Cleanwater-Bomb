local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_EDDIE_JESSE",
    line = ccb.content.text("Jesse manages the horses and other livestock, she is amazing with animals."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_EDDIE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
