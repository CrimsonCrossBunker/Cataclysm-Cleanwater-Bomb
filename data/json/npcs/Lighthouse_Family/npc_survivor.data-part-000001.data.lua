local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_LIGHTHOUSE_SURVIVOR",
    line = ccb.content.text("Hello!  Glad to meet another survivor."),
    replies = {
        {
            text = ccb.content.text("Me too.  How did you manage to get here?"),
            next_topic = "TALK_LIGHTHOUSE_SURVIVOR1",
        },
    },
}
