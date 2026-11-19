local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_LISA_TOPICS",
    line = ccb.content.text("Go on…"),
    replies = {
        { text = ccb.content.text("Hi, I'm looking for Jesse."), next_topic = "TALK_LISA_JESSE" },
        { text = ccb.content.text("Hi, I'm looking for Chris."), next_topic = "TALK_LISA_CHRIS" },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_TALKED_TO_LISA",
    line = ccb.content.text("Yeah, Chris talked to me a minute ago.\"  She touches the shoulder strap on her rifle.  \"I can't believe he's not trying to talk me out of it, really, but I'd do anything to save Uncle Barry.  I'll be ready at the tower, when you need me."),
    replies = { { text = ccb.content.text("Great.  I'll see you there."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_NOT_TALKED_TO_LISA",
    line = ccb.content.text("He did?\"  She touches the shoulder strap on her rifle.  \"Like, action?  Yeah, I'm a pretty good shot, and I'd do anything to save Uncle Barry.  I'm surprised Chris didn't try to go all protective older brother on me.  What's the plan?"),
    replies = {
        {
            text = ccb.content.text("[Explain the plan.]"),
            next_topic = "TALK_ISHERWOOD_LISA_JOIN_RESCUE",
        },
    },
}
