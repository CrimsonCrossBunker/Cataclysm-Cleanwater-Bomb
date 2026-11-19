local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Theresa_Firstmeet",
    line = ccb.content.text("It is nice to meet you as well.  I reckon you got some questions about our group."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
