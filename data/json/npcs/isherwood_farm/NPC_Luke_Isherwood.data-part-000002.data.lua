local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_LUKE_TALK1",
    line = ccb.content.text("Yeah, I work on it when I have the time.  I can't leave the farm too long, so I can't find some things I need."),
    replies = {
        {
            text = ccb.content.text("Maybe I can help out.  What do you need?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("Must be tough having the world fall apart when you had you future to look forward to."),
            next_topic = "TALK_ISHERWOOD_LUKE3",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_LUKE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
