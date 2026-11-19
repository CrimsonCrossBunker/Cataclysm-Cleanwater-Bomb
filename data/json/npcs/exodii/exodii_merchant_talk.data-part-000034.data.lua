local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Exodus",
    line = ccb.content.text("Oh yeah, right and so.  Each and every.  We wander, we make do.  It's a livin'."),
    replies = {
        {
            text = ccb.content.text("What drove you out?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodus2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
