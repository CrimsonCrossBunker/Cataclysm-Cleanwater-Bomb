local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Julian_Leave",
    line = ccb.content.gendered_line("You sure?  I mean, you've been traveling for a long time, haven't you?  Alright, it's your decision.  Let me know when you changed your mind.", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("<end_talking_leave>  Nice meeting you."),
            next_topic = "TALK_DONE",
        },
    },
}
