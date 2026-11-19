local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GLOOSCAP_HAPPENING",
    line = ccb.content.text("Another world is going and a new world is coming.  I hope this new one is better than the last, a new golden age.  So far not great."),
    replies = {
        {
            text = ccb.content.text("Sure sure.  So are you on drugs?"),
            next_topic = "TALK_GLOOSCAP_DRUGS",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GLOOSCAP",
        },
        {
            text = ccb.content.text("Whatever, I don't have time for creepy stuff."),
            next_topic = "TALK_DONE",
        },
    },
}
