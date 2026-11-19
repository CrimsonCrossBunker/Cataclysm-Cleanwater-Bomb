local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_PRISONER_LEADER_INQUIRY",
    line = ccb.content.text("Well, that's a boastful statement.  Not that I don't believe it, it's just….  Ah, nevermind.  Let's get to the point.  What do you want?"),
    replies = {
        {
            text = ccb.content.text("I want to get out of this <freaking> prison.  I hoped you could help me with that."),
            next_topic = "TALK_PRISONER_LEADER_GIVES_WORK",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PRISONER_LEADER_FROWN",
    line = ccb.content.text("Hold the horses, pal.  Nobody allowed you to stay here - yet."),
    replies = {
        {
            text = ccb.content.text("Please!  I don't want to go back there!  I'm tired and hungry!  I just need time to rest!"),
            next_topic = "TALK_PRISONER_LEADER_ANNOYED",
        },
        {
            text = ccb.content.text("Shit!  Looks like I'm on my own now.  Thanks for nothing.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
