local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "BGSS_FEMA_EVACUEE_1_STORY1",
    line = ccb.content.text("That's a tall order.  I guess the short version is that I got evacuated to a FEMA camp for my so-called safety, but luckily I made it out."),
    replies = {
        {
            text = ccb.content.text("Tell me more about that FEMA camp."),
            next_topic = "BGSS_FEMA_EVACUEE_1_STORY2",
        },
        {
            text = ccb.content.text("How did you get out?"),
            when = predicates.negate(predicates.has_effect("interlocutor", "player_BGSS_SAIDNO")),
            trial = {
                kind = "persuade",
                difficulty = 20,
                modifiers = { { score = "BRAVERY", scale = 2 }, { score = "TRUST", scale = 1 } },
            },
            success = { next_topic = "BGSS_FEMA_EVACUEE_1_ESCAPE1" },
            failure = { next_topic = "BGSS_FEMA_EVACUEE_1_NOTYET" },
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_FEMA_EVACUEE_1_STORY2",
    line = ccb.content.text("It was terrifying.  We were shipped there on a repurposed school bus, about thirty of us.  You can probably see the issues right away.  A few of the folks on board the bus had injuries, and some schmuck who had seen too many B-movies tried to insist that anyone who 'had been bitten' was going to 'turn'.  Fucking idiot, right?  I've been bitten a dozen times now and the worst I got was a gross infection."),
    replies = {
        {
            text = ccb.content.text("What happened after that?"),
            next_topic = "BGSS_FEMA_EVACUEE_1_STORY3",
        },
        {
            text = ccb.content.text("How did you get out?"),
            when = predicates.negate(predicates.has_effect("interlocutor", "player_BGSS_SAIDNO")),
            trial = {
                kind = "persuade",
                difficulty = 20,
                modifiers = { { score = "BRAVERY", scale = 2 }, { score = "TRUST", scale = 1 } },
            },
            success = { next_topic = "BGSS_FEMA_EVACUEE_1_ESCAPE1" },
            failure = { next_topic = "BGSS_FEMA_EVACUEE_1_NOTYET" },
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_FEMA_EVACUEE_1_STORY3",
    line = ccb.content.text("That guy started a frenzy.  People were already panicked.  There was an armed guy overseeing the transport, acting like a cop but really he was just some dumb-ass kid they'd handed a rifle to.  He tried to calm things down, and I guess it actually worked for a bit, although the 'kill the infected' bunch were freaked out and were clearly ready to jump the moment the granny with the cut on her arm started frothing at the mouth.  They started acting up again when we got to the camp.  That didn't go well for them.  A few heavily armed soldiers dragged them away, and I never saw them again."),
    replies = {
        {
            text = ccb.content.text("How did you get out?"),
            when = predicates.negate(predicates.has_effect("interlocutor", "player_BGSS_SAIDNO")),
            trial = { kind = "persuade", difficulty = 30 },
            success = { next_topic = "BGSS_FEMA_EVACUEE_1_ESCAPE1" },
            failure = { next_topic = "BGSS_FEMA_EVACUEE_1_NOTYET" },
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
