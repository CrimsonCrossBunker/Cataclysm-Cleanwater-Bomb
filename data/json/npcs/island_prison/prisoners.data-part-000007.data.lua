local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_PRISONER_LEADER_NO",
    line = ccb.content.text("The answer is still no.  In fact it might be better for us to kill you right away - you know, the less mouths to feed, the better.  But I'm in a good mood today, so I've decided to help you get out of this island."),
    replies = {
        {
            text = ccb.content.text("Ok, I'm listening."),
            next_topic = "TALK_PRISONER_LEADER_GIVES_WORK",
        },
        {
            text = ccb.content.text("You know, I think I'll manage without your help.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
