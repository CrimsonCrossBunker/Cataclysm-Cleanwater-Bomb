local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_LUKE_EDDIE_NoBarry",
    line = ccb.content.text("&His shoulders slump a little at the question.  \"Things have been tough for my dad since Barry was captured.  He works till he falls asleep most nights…\""),
    replies = {
        { text = ccb.content.text("What happened to Barry?"), next_topic = "TALK_LUKE_BARRY" },
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
    id = "TALK_LUKE_EDDIE_YesBarry",
    line = ccb.content.text("*looks around, then leans in just a little closer.  \"He's doing OK now that Barry's home, but, well, things still aren't the same.  I imagine that'll take time.\""),
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
