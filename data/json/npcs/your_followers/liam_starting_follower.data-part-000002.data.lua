local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Meeting2",
    line = ccb.content.text("*gestures at the body.  \"Chris.  You know Chris, you've known Chris for years.  We all agreed to meet up here if shit got bad, remember?  We got here around the same time, set up a little camp.  Something seemed really off since we arrived though, Chris kept going on and on about how the food wasn't good enough.\"  He shifts his gaze back to you, eyes red.  \"We got plenty of food!  I tried to calm him down but just now the fucker came running in with an axe, tried to take my head off!  I… I…\" Liam gestures again to the corpse.  \"Then you came in.  Do you got anything to do with this?\""),
    replies = {
        {
            text = ccb.content.text("I heard gunshots, so I came in to see what's up.  I was just on my way here to see if you'd made it."),
            next_topic = "TALK_Liam_Meeting3",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Meeting3",
    line = ccb.content.text("Well, shit.  I'm guessing my story sounds like a lot of bullshit then.\"  Liam sags into the sofa behind him, wiping his eyes with his sleeve.  \"What the hell are we gonna do?  Holy shit."),
    replies = {
        {
            text = ccb.content.text("I believe you.  People have been acting crazy for weeks, it must have got Chris too.  Come on.  We're in this together."),
            next_topic = "TALK_Liam_Meeting4a",
        },
        {
            text = ccb.content.text("Pull yourself together.  You did what you had to.  The shit has hit the fan, no time for moping around."),
            next_topic = "TALK_Liam_Meeting4b",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Meeting4a",
    line = ccb.content.text("Thanks.  It's good to hear that.  Look, I'm sure I should be questioning you and making sure you're not gonna attack me with an axe or something, but I just can't anymore.  Come on, let's get Chris out of here and then figure out what to do next."),
    replies = {
        {
            text = ccb.content.text("Sure thing.  <lets_go>"),
            native_actions = { "follow" },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Meeting4b",
    line = ccb.content.text("All right, yeah.  Fair call.  I'm just a bit shell shocked, but it's good to see you.  Let's get Chris out of here and figure out what to do next"),
    replies = {
        {
            text = ccb.content.text("Sure thing.  <lets_go>"),
            native_actions = { "follow" },
            next_topic = "TALK_DONE",
        },
    },
}
