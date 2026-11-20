local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_PROOF",
    line = ccb.content.text("&He crosses his arms.  \"Fine.  Go talk to the guards, that crash was all the talk among them for a while.  Look, I'm not trying to do you over, I wouldn't risk my reputation and my job for a handful of cash, feel free to tell everyone in the center that I'm a liar sending people to their death for a quick buck if you find out that I lied.\""),
    replies = { { text = ccb.content.text("I see…"), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_SKETCHY",
    line = ccb.content.text("&He sighs.  \"Well, let's just say that the location of the helicopter doesn't make the retrieval of the cargo…trivial.  Apparently the higher-ups at the Old Guard agreed that it was too hard and too far to be worth.  It wasn't transporting Jesus, just valuable cargo.\""),
    replies = { { text = ccb.content.text("I see…"), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_DANGER",
    line = ccb.content.text("Yes actually.  The scout told me that he saw something weird down at the lake.  Translucent shapes swimming close to the surface from time to time.  I'm sure it has something to do with the weird storm that brought the helicopter down."),
    replies = { { text = ccb.content.text("I see…"), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_2",
    line = ccb.content.text("Alright, give me your map I'll show you the location."),
    replies = {
        {
            text = ccb.content.text("I had other questions."),
            next_topic = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_HUB",
        },
        { text = ccb.content.text("Thanks."), next_topic = "TALK_OLD_GUARD_REP" },
    },
}
