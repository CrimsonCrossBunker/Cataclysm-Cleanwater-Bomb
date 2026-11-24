local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

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

-- TK: In a future version this character will give you directions to the FEMA camp.
ccb.content.define_dialogue_topic {
    id = "BGSS_FEMA_EVACUEE_1_ESCAPE1",
    line = ccb.content.gendered_line("That place was chaos.  I only stayed a few hours.  They had a big backhoe running, digging a huge pit in a cordoned section they wouldn't let us near.  Well, I managed to sneak over that way, and saw them dumping load after load of the dead in the pit, pouring dirt back over them even as they revived and tried to climb out.  Even with all the shit I've seen since, it haunts me.  I knew then I had to get out.  Luckily for me, we were attacked the next morning by some giant horror, a kind I haven't really seen since then.  While the guards were busy with that, I grabbed some supplies I'd stocked up over the night and I fucked right out of there.  A few others tried to get the fuck out with me, but as far as I know I was the only lucky one.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Tell me more about that FEMA camp."),
            next_topic = "BGSS_FEMA_EVACUEE_1_STORY2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_FEMA_EVACUEE_1_NOTYET",
    line = ccb.content.text("Maybe another time.  I don't really like thinking about it."),
    replies = {
        {
            text = ccb.content.text("Sorry.  Tell me more about that FEMA camp."),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDNO", { turns = 600 }) },
            next_topic = "BGSS_FEMA_EVACUEE_1_STORY2",
        },
        {
            text = ccb.content.text("Sorry for asking.  <done_conversation_section>"),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDNO", { turns = 600 }) },
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        {
            text = ccb.content.text("Sorry for asking.  <end_talking>"),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDNO", { turns = 600 }) },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "CWH_FEMA_EVACUEE_1_IDEAS1",
    line = ccb.content.gendered_line("Woof, you ready for a real hot take?  The <freaking> government did this to us.  Intentionally, or at least sort-of intentionally.", { "speaker" }),
    replies = {
        { text = ccb.content.text("Oh?"), next_topic = "CWH_FEMA_EVACUEE_1_IDEAS2" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "CWH_FEMA_EVACUEE_1_IDEAS2",
    line = ccb.content.text("Damn right.  They lied to us for god knows how long about what was going on because they didn't want us to figure it out.  It probably started as a way to keep the people in line, but it backfired somehow.  My guess is they tried to de-educate us, tried to mislead us, and when that wasn't working they tried actual drugs in the water to make us stupid or something.  Instead of just stupid, some people got violent.  Then they tried to leverage that to put in martial law, but that didn't work and they wound up fighting hordes of people.  Only they didn't realize their <freaking> brain drugs were some kind of mutagen that turn people into zombies."),
    replies = {
        {
            text = ccb.content.text("What about all the other stuff?"),
            next_topic = "CWH_FEMA_EVACUEE_1_IDEAS3",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "CWH_FEMA_EVACUEE_1_IDEAS3",
    line = ccb.content.text("I think it's mostly mutation.  I don't know what they used, but it's some real mad science shit, I didn't think most of this was even possible.  I also wonder if whatever they put in the water has made us a bit crazy.  Maybe some of this is just a hallucination?  That one blows my mind a bit, I'm not sure I believe it but I got nothin' else."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
