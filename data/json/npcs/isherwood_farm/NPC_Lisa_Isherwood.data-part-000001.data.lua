local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_LISA_TALK1",
    line = ccb.content.text("My family owns all the land around here, my parents are out in the barn and my other family is down the road."),
    replies = {
        { text = ccb.content.text("Ok, I'll go find them."), next_topic = "TALK_DONE" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_LISA_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LISA_JESSE",
    line = ccb.content.text("Mom is in her office, in the barn.  Be careful that you don't let our horses out."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_LISA_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LISA_CHRIS",
    line = ccb.content.text("Chris is out hunting or something right now."),
    replies = {
        { text = ccb.content.text("Oh, ok."), next_topic = "TALK_DONE" },
        { text = ccb.content.text("Or something?"), next_topic = "TALK_LISA_CHRIS2" },
        { text = ccb.content.text("Nice talking to you, bye."), next_topic = "TALK_DONE" },
    },
}
