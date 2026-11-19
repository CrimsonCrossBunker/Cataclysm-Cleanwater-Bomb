local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_LUKE_BARRY2",
    line = ccb.content.text("*frowns.  \"I don't know how much I can tell you.  Your best bet is to talk to Uncle Carlos.\""),
    replies = {
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

ccb.content.define_dialogue_topic {
    id = "TALK_LUKE_BARRYhelp",
    line = ccb.content.text("I really… okay.  Maybe ask my grandma, Claire.  She'll know if it's okay to talk about."),
    replies = {
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
