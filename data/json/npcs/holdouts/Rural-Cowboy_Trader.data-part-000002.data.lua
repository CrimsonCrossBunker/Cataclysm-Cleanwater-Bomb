local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYT_BACKGROUND",
    line = ccb.content.text("Worked as a salesman - high end farming equipment.  Now I know, it may not sound that fancy, but you'd be shocked at how pricy those machines can get.  I was lucky enough to be on a fairly remote farm when everything went to shit.  In a way, being a salesman saved me and the experience from the job might allow me to make a living in the apocalypse, bartering for gear and trinkets, so I got that going for me, I suppose."),
    replies = {
        {
            text = ccb.content.text("Speaking of which, I'd like to see your wares."),
            next_topic = "TALK_NONE",
            native_actions = { "start_trade" },
        },
        { text = ccb.content.text("Not a bad way to live."), next_topic = "TALK_NONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYT_JOKE",
    line = ccb.content.text("Hah, real cute.  Seem the End times didn't take your sense of humor, eh, stranger?"),
    replies = {
        {
            text = ccb.content.text("I have my moments.  So what are you doing here?"),
            next_topic = "TALK_COWBOYT_INTRODUCTION",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYT_INTRODUCTION",
    line = ccb.content.text("Ah, not much really.  Passing through, trying to make a living by trading with folk.  If you're interested, I got a lot of good things on sale, stranger."),
    replies = {
        {
            text = ccb.content.text("You do?  Let me take a look."),
            next_topic = "TALK_DONE",
            native_actions = { "start_trade" },
        },
        { text = ccb.content.text("I see."), next_topic = "TALK_COWBOYT_MAIN" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYT_FOLLOW",
    line = ccb.content.text("You seem like a decent sort, but I'm not really looking for company right now.  Think I'm better off on my own."),
    replies = {
        { text = ccb.content.text("If you think so."), next_topic = "TALK_NONE" },
        { text = ccb.content.text("Fair enough.  <end_talking_bye>"), next_topic = "TALK_DONE" },
    },
}
