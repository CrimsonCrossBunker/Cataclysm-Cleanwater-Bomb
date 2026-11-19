local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYN_INTRODUCTION1",
    line = ccb.content.text("I dunno.  Waiting.  Seeing if something happens I guess."),
    replies = {
        {
            text = ccb.content.text("You do realize there is an apocalypse going on, right?"),
            next_topic = "TALK_COWBOYN_INTRODUCTION2",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYN_INTRODUCTION2",
    line = ccb.content.text("Yeah.  I do."),
    replies = {
        {
            text = ccb.content.text("So shouldn't you be more concerned?  Trying to survive?"),
            next_topic = "TALK_COWBOYN_NIHILIST",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYN_NIHILIST",
    line = ccb.content.text("For how long?  You've seen what's out there.  If we survive today, we'll die the day after.  Or the day after that.  And if we live beyond that, we'll just see everyone we care about die.  All of them.  Might as well get it over with."),
    replies = {
        { text = ccb.content.text("What happened to you?"), next_topic = "TALK_COWBOYN_BACKGROUND" },
        {
            text = ccb.content.text("So you're just going to give up?"),
            next_topic = "TALK_COWBOYN_NIHILIST2",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYN_NIHILIST2",
    line = ccb.content.text("Yeah.  I think I will."),
    replies = {
        { text = ccb.content.text("What happened to you?"), next_topic = "TALK_COWBOYN_BACKGROUND" },
        { text = ccb.content.text("Fair enough."), next_topic = "TALK_DONE" },
    },
}
