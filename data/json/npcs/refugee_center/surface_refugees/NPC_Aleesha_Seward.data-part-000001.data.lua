local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Aleesha_1a",
    line = {
        joined = {
            ccb.content.text("*doesn't quite meet your gaze as you approach.  \""),
            {
                choices = {
                    ccb.content.text("Hey there."),
                    ccb.content.text("Oh, hey, it's you again."),
                    ccb.content.text("What's up?"),
                    ccb.content.gendered_line("You're back, and still alive!  Whoa.", { "speaker" }),
                    ccb.content.text("Aw hey, look who's back."),
                },
            },
            ccb.content.text("\""),
        },
    },
    replies = {
        {
            text = ccb.content.text("Hi, Aleesha.  What's up?"),
            next_topic = "TALK_REFUGEE_Aleesha_2",
        },
        { text = ccb.content.text("Hi Aleesha.  <end_talking_leave>"), next_topic = "TALK_DONE" },
    },
}
