local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GLOOSCAP_POWERS",
    line = ccb.content.text("I don't think so.  I'm pretty good at hunting though."),
    replies = {
        { text = ccb.content.text("I guess that's something."), next_topic = "TALK_GLOOSCAP" },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
