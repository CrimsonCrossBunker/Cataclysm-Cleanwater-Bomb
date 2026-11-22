local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_SCIENCE_REP",
    line = {
        when = predicates.has_any_trait("speaker", { "PROF_FED" }),
        yes = ccb.content.text("Marshal…"),
        no = ccb.content.text("Citizen…"),
    },
    replies = {
        {
            text = ccb.content.text("Who are you?"),
            next_topic = "TALK_SCIENCE_REP_NEW",
        },
        {
            text = ccb.content.text("Heard anything about the outside world?"),
            next_topic = "TALK_SCIENCE_REP_WORLD",
        },
        {
            text = ccb.content.text("Can I trade for supplies?"),
            next_topic = "TALK_SCIENCE_REP_ASK_TRADE",
        },
        {
            text = ccb.content.text("Can I do anything for you?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("Can you help me with my bionic implants?"),
            next_topic = "TALK_SCIENCE_REP_CBM",
            when = predicates.handler("dlg_p_dda_9aa5249d2b43"),
        },
        {
            text = ccb.content.text("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SCIENCE_REP_NEW",
    line = ccb.content.gendered_line("I'm a doctor, one of the several at the outpost.  We were the lucky ones.  Came here right went things started to go wrong, never left.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("So what are you doing right now?"),
            next_topic = "TALK_SCIENCE_REP_NEW_DOING",
        },
        { text = ccb.content.text("Never mind…"), next_topic = "TALK_SCIENCE_REP" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SCIENCE_REP_NEW_DOING",
    line = ccb.content.text("The Old Guard--that's what's left of the feds--set me up here to screen any new arrivals for infection risks.  Can't be too paranoid these days.  Sad to have to turn people away, but I like the assignment for the chance to get news about the outside world."),
    replies = {
        { text = ccb.content.text("What kind of news?"), next_topic = "TALK_SCIENCE_REP_NEW_NEWS" },
        { text = ccb.content.text("Never mind…"), next_topic = "TALK_SCIENCE_REP" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SCIENCE_REP_NEW_NEWS",
    line = ccb.content.text("Sightings of unusual living dead or new mutations.  The more we know about what's happening, the closer we can get to a treatment or maybe even a cure.  It's a long shot, but you have hope to survive."),
    replies = { { text = ccb.content.text("Good luck with that."), next_topic = "TALK_SCIENCE_REP" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SCIENCE_REP_WORLD",
    line = ccb.content.text("This is no classic zombie outbreak.  The dead seem to be getting stronger as the days go on.  Some survivors too, come in here with… adaptations.  Maybe they're related."),
    replies = { { text = ccb.content.text("Never mind…"), next_topic = "TALK_SCIENCE_REP" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SCIENCE_REP_ASK_TRADE",
    line = ccb.content.text("We can't.  There's nothing we can spare to sell and I've got no budget to buy from you.  I don't suppose you want to donate?"),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_SCIENCE_REP" } },
}
