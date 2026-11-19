local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_NEW",
    line = ccb.content.text("I'm the region's federal liaison.  Most people here call us the 'Old Guard' and I rather like the sound of it.  Despite how things currently appear, the federal government was not entirely destroyed.  After the outbreak I was chosen to coordinate civilian and militia efforts in support of military operations."),
    replies = {
        {
            text = ccb.content.text("So what are you actually doing here?"),
            next_topic = "TALK_OLD_GUARD_REP_NEW_DOING",
        },
        { text = ccb.content.text("Never mind…"), next_topic = "TALK_OLD_GUARD_REP" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_NEW_DOING",
    line = ccb.content.text("I ensure that the citizens here have what they need to survive and protect themselves from raiders.  Keeping some form of law is going to be the most important element in rebuilding the world.  We do what we can to keep the 'Free Merchants' here prospering and in return they have provided us with spare men and supplies when they can."),
    replies = {
        {
            text = ccb.content.text("Is there a catch?"),
            next_topic = "TALK_OLD_GUARD_REP_NEW_DOWNSIDE",
        },
        {
            text = ccb.content.text("Anything more to it?"),
            next_topic = "TALK_OLD_GUARD_REP_NEW_DOWNSIDE",
        },
        { text = ccb.content.text("Never mind…"), next_topic = "TALK_OLD_GUARD_REP" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_NEW_DOWNSIDE",
    line = ccb.content.gendered_line("Well… I was like any other civilian till they conscripted me so I'll tell it to you straight.  They're the best hope we got right now.  They are stretched impossibly thin but are willing to do what is needed to maintain order.  They don't care much about looters since they understand most everyone is dead, but if you have something they need… you WILL give it to them.  Since most survivors here have nothing they want, they are welcomed as champions.", { "interlocutor" }),
    replies = { { text = ccb.content.text("Hmmm…"), next_topic = "TALK_OLD_GUARD_REP" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_WORLD",
    line = ccb.content.text("There isn't much pushed out by public relations that I'd actually believe.  From what I gather, communication between the regional force commands is almost non-existent.  What I do know is that the 'Old Guard' is currently based out of the 2nd Fleet and patrols the Atlantic coast trying to provide support to the remaining footholds."),
    replies = {
        {
            text = ccb.content.text("The 2nd Fleet?"),
            next_topic = "TALK_OLD_GUARD_REP_WORLD_2NDFLEET",
        },
        {
            text = ccb.content.text("Tell me about the footholds."),
            next_topic = "TALK_OLD_GUARD_REP_WORLD_FOOTHOLDS",
        },
        { text = ccb.content.text("Never mind…"), next_topic = "TALK_OLD_GUARD_REP" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_WORLD_2NDFLEET",
    line = ccb.content.text("I don't know much about how it formed but it is the armada of military and commercial ships that's floating off the coast.  They have everything from supertankers and carriers to fishing trawlers… even a few NATO ships.  Most civilians are offered a cabin on one of the liners to retire to if they serve as a federal employee for a few years."),
    replies = { { text = ccb.content.text("Hmmm…"), next_topic = "TALK_OLD_GUARD_REP" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_WORLD_FOOTHOLDS",
    line = ccb.content.text("They may just be propaganda but apparently one or two cities were successful in 'walling themselves off.'  Around here I was told that there were a few places like this one but I couldn't tell you where."),
    replies = { { text = ccb.content.text("Hmmm…"), next_topic = "TALK_OLD_GUARD_REP" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_ASK_JOIN",
    line = ccb.content.text("You can't actually join unless you go through a recruiter.  We can usually use help though, ask me from time to time if there is any work available.  Completing missions as a contractor is a great way to make a name for yourself among the most powerful men left in the world."),
    replies = { { text = ccb.content.text("Hmmm…"), next_topic = "TALK_OLD_GUARD_REP" } },
}
