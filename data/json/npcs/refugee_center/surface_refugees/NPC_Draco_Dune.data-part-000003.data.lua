local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_1_firstmeet",
    line = ccb.content.text("Nice to meet you too.  What brings you to these parts?  Got any stories to share?  Happy ones, hopefully… we've had our fill of sadness around here."),
    replies = {
        {
            text = ccb.content.text("What about you, how're you doing?"),
            next_topic = "TALK_REFUGEE_Draco_2",
        },
        {
            text = ccb.content.text("Yeah, it's tough everywhere.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
