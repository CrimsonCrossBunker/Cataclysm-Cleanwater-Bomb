local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_BUNKER_MERCHANT",
    line = ccb.content.text("Heya, scav."),
    replies = {
        {
            text = ccb.content.text("Did you build this place?"),
            next_topic = "TALK_BUNKER_MERCHANT_HERE",
        },
        { text = ccb.content.text("Who are you?"), next_topic = "TALK_BUNKER_MERCHANT_WHO" },
        {
            text = ccb.content.text("Why do you still use cash?"),
            next_topic = "TALK_BUNKER_MERCHANT_WHY",
        },
        { text = ccb.content.text("You're a trader?"), next_topic = "TALK_BUNKER_MERCHANT_TRADE" },
        {
            text = ccb.content.text("I need some supplies."),
            native_actions = { "start_trade" },
            next_topic = "TALK_BUNKER_MERCHANT",
        },
        {
            text = ccb.content.text("Need help with anything?"),
            next_topic = "TALK_BUNKER_MERCHANT_MISSION",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BUNKER_MERCHANT_HERE",
    line = ccb.content.gendered_line("No, no… well, maybe a little.  It was just as wrecked down here as it is up top when I found it, wasn't too hard to fix up.  You're welcome to stay in the spare room awhile, just don't hog it.  You're not the only scav out there.", { "interlocutor" }),
    replies = { { text = ccb.content.text("Interesting…"), next_topic = "TALK_BUNKER_MERCHANT" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BUNKER_MERCHANT_WHO",
    line = ccb.content.gendered_line("Just a scav who got lucky.  Now I'm content to sit around here on my pile of treasure.  I'm more than willing to trade if you've got the cash.", { "interlocutor" }),
    replies = { { text = ccb.content.text("I see…"), next_topic = "TALK_BUNKER_MERCHANT" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BUNKER_MERCHANT_WHY",
    line = ccb.content.text("Why not?  Everyone else does, so I suppose that's all that matters.  My ATM over there still works, connected to the bank servers and everything."),
    replies = { { text = ccb.content.text("Hmm…"), next_topic = "TALK_BUNKER_MERCHANT" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BUNKER_MERCHANT_TRADE",
    line = ccb.content.text("I suppose I am.  Scavs like you need supplies, right?  And I could always use more money."),
    replies = { { text = ccb.content.text("Alright…"), next_topic = "TALK_BUNKER_MERCHANT" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BUNKER_MERCHANT_MISSION",
    line = ccb.content.text("Not at the moment, check back later perhaps."),
    replies = { { text = ccb.content.text("Sure…"), next_topic = "TALK_BUNKER_MERCHANT" } },
}
