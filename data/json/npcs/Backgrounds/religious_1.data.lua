local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "BGSS_RELIGIOUS_1_STORY1",
    line = ccb.content.text("My story.  Huh.  It's nothing special.  I had people, but they've risen to be with the Lord.  I don't understand why He didn't take me too, but I suppose it'll all be clear in time."),
    replies = {
        {
            text = ccb.content.text("Do you mean in a religious sense, or…?"),
            next_topic = "BGSS_RELIGIOUS_1_STORY2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_RELIGIOUS_1_STORY2",
    line = ccb.content.text("Of course.  It's clear enough, isn't it?  That… that end, was the Rapture.  I'm still here, and I still don't understand why, but I will keep Jesus in my heart through the Tribulations to come.  When they're past, I'm sure He will welcome me into the Kingdom of Heaven.  Or… or something along those lines.  It's not going exactly like I thought it would, but that's prophecy for you."),
    replies = {
        {
            text = ccb.content.text("What if you're wrong?"),
            next_topic = "BGSS_RELIGIOUS_1_FAITH1",
            when = predicates.negate(predicates.has_effect("interlocutor", "player_rude_BGSS_RELIGIOUS_1_FAITH1")),
            actions = {
                actions.add_effect("interlocutor", "player_rude_BGSS_RELIGIOUS_1_FAITH1", { permanent = true }),
            },
            opinion = { value = -1 },
        },
        {
            text = ccb.content.text("What will you do, then?"),
            next_topic = "BGSS_RELIGIOUS_1_FAITH2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_RELIGIOUS_1_FAITH1",
    line = ccb.content.text("What?  How could you say something like that?  I can't believe you'd look at all this and think it could be anything but the end-times.  The dead are walking, the gates of Hell itself have opened, the Beasts of the Devil walk the Earth, and the Righteous have all be drawn up into the Lord's Kingdom.  What more proof could you possibly ask for?"),
    replies = {
        {
            text = ccb.content.text("What will you do, then?"),
            next_topic = "BGSS_RELIGIOUS_1_FAITH2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_RELIGIOUS_1_FAITH2",
    line = ccb.content.text("I will keep the faith, and keep praying, and strike down the agents of Hell where I see them.  That's all we few can do, isn't it?  I suppose perhaps we're the meek that shall inherit the Earth.  Although I don't love our odds."),
    replies = {
        {
            text = ccb.content.text("What if you're wrong?"),
            next_topic = "BGSS_RELIGIOUS_1_FAITH1",
            when = predicates.negate(predicates.has_effect("interlocutor", "player_rude_BGSS_RELIGIOUS_1_FAITH1")),
            actions = {
                actions.add_effect("interlocutor", "player_rude_BGSS_RELIGIOUS_1_FAITH1", { permanent = true }),
            },
            opinion = { value = -1 },
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "CWH_RELIGIOUS_1_IDEAS1",
    line = ccb.content.text("It's clear enough, isn't it?  That… that end, was the Rapture.  I'm still here, and I still don't understand why, but I will keep Jesus in my heart through the Tribulations to come.  When they're past, I'm sure He will welcome me into the Kingdom of Heaven.  Or… or something along those lines."),
    replies = {
        {
            text = ccb.content.text("I meant more the actual events.  What happened?"),
            next_topic = "CWH_RELIGIOUS_1_IDEAS2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "CWH_RELIGIOUS_1_IDEAS2",
    line = ccb.content.text("Oh.  Well, I think it follows the good word in Revelations, if I remember right.  I haven't talked to a preacher in a bit, you know.  There were the plagues… the first one was the one a couple years ago, that big pandemic, that was when people started talking about the end being near.  Then there was a plague of blood, or was it violence?  That was the riots.  Then the seas turned red with blood, that was from all the people being shot.  Then a plague of fire, I remember that one for sure, that was when there were bombs and things going off everywhere to try to contain the riots.  And then demons and monsters walked the Earth, and the dead rose from their graves, and finally the meek inherited.  Clear as day."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
