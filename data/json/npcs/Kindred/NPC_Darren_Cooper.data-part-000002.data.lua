local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_COOPER_INTRODUCTION_QUERY",
    line = ccb.content.text("I see.  Would you like to hear my side, or is your mind made up already?"),
    replies = {
        { text = ccb.content.text("I'm curious.  Go on."), next_topic = "TALK_COOPERS_SIDE" },
        {
            text = ccb.content.text("She told me to stop you, and that's what I'll do."),
            next_topic = "TALK_COOPER_FIGHT",
        },
        {
            text = ccb.content.text("I don't care about any of this.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_KNOWS_COOPER_CARVE",
    line = ccb.content.text("What?  I'd never do anything like that!  Dammit… if she thinks I did that, that would explain why she's not willing to work with me.  Maybe there's still some hope she'll understand what's necessary."),
    replies = {
        { text = ccb.content.text("So what happened then?"), next_topic = "TALK_COOPERS_SIDE" },
        {
            text = ccb.content.text("You're still a killer, and I can't let you keep going."),
            next_topic = "TALK_COOPER_FIGHT",
        },
        { text = ccb.content.text("I don't really care.  I'm leaving."), next_topic = "TALK_DONE" },
    },
}
