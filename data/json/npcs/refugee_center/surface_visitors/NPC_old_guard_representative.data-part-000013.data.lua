local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_1",
    line = ccb.content.text("A helicopter crashed in the region not long ago, at first I thought it was just a rumor, caravan guards talking about some crash nearby, but then I got a visit from a couple of Old Guard people looking for a lost helicopter, one of them got quite drunk one night and shared some interesting details, turns out it was an Old Guard heli coming back from way out west with quite the cargo, and I know where you can find it.  That's all you're getting for free though, I'd like to see some return on investment on that bottle you understand."),
    replies = {
        {
            text = ccb.content.text("I'm not buying anything without some proof."),
            next_topic = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_PROOF",
        },
        {
            text = ccb.content.text("Why sell the info instead of retrieving the cargo yourself?  What happened to the old guard investigation?  How can you be sure that it wasn't looted already?  This sounds sketchy as hell."),
            next_topic = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_SKETCHY",
        },
        {
            text = ccb.content.text("[50 merch] Fine."),
            next_topic = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_2",
            when = predicates.has_inventory("speaker", "FMCNote", 50),
            actions = { actions.transfer_items("FMCNote", 50), actions.assign_mission("MISSION_FIND_SUNKEN_HELICOPTER") },
            failure_topic = "TALK_DONE",
            failure_explanation = ccb.content.text("You don't have enough."),
        },
        {
            text = ccb.content.text("Never mind…"),
            next_topic = "TALK_OLD_GUARD_REP",
        },
    },
}

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
