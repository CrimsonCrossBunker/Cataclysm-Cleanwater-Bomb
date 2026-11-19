local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Greenwood_Firstmeet",
    line = ccb.content.text("What can I do for you?"),
    replies = {
        { text = ccb.content.text("Where am I?"), next_topic = "TALK_GODCO_Greenwood_Where" },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
