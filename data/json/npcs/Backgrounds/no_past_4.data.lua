local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "BGSS_NO_PAST_4_STORY1",
    line = ccb.content.gendered_line("Who I was is gone.  All that stuff burned away in <the_cataclysm>.  Got it?  Who I am now started two days into it.  I was on the run from a big-ass hell zombie, running like I'd always been doing, when I found a steel baseball bat just laying on the ground.  I took it as a sign and beat that gooey bastard to a pulp… and that's when I became me.  I still run, because who doesn't, but I stand my ground now.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("What happened to you after that?"),
            next_topic = "BGSS_NO_PAST_4_STORY2",
        },
        {
            text = ccb.content.text("It can't be healthy to abandon your past like that…"),
            next_topic = "BGSS_NO_PAST_4_DROPIT",
            opinion = { anger = 3 },
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_NO_PAST_4_STORY2",
    line = ccb.content.gendered_line("I went on, running when I had to and fighting when I could, like the rest of us.  Started learning who I am now.  Lost the bat in a fight against some crazy electric lightning shooting zombie.  It was arcing electricity through my bat so I dropped it and used a nearby plank, but I wound up having to run and leave the ol' slugger behind.  I nearly died that day.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("It can't be healthy to abandon your past like that…"),
            next_topic = "BGSS_NO_PAST_4_DROPIT",
            opinion = { anger = 3 },
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_NO_PAST_4_DROPIT",
    line = ccb.content.gendered_line("Listen.  I said it clearly, and if you keep picking at it I'm gonna get mad.  Who I was is gone.  Dead.  I don't give a shit about your 'healthy', don't fucking ask again.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "CWH_NO_PAST_4_IDEAS1",
    line = ccb.content.text("You're asking me what I think caused all this?  It was all over the news.  Some kind of Chinese bio-weapon.  It's no different from the pandemic a few years back, but this time they got the formula right.  Maybe too right.  Doesn't matter anyway, I hear it got out on them and wiped them out too.  Serves em right."),
    replies = {
        {
            text = ccb.content.text("Can you tell me more about what actually went down, though?"),
            next_topic = "CWH_NO_PAST_4_IDEAS2",
        },
        {
            when = predicates.any({ predicates.minimum_attribute("speaker", "perception", 7), predicates.minimum_attribute("speaker", "intelligence", 8) }),
            text = ccb.content.text("How does that explain all the other crazy stuff?"),
            next_topic = "CWH_NO_PAST_4_SKEPTIC",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "CWH_NO_PAST_4_IDEAS2",
    line = ccb.content.text("Well, you know.  First there were the riots from the mind-control drugs in the water.  Except I think we can all see now it was actually a virus again.  The military and the cops did their damndest to put it down but it got out of hand.  Then the virus mutated and started bringing the dead back to life like in some kinda B-movie, and shit got really real.  They let the big things loose, or they set them on us, I dunno.  Huge unspeakable monsters… still makes me shudder to think of them.  They obviously weren't built for combat though, and the military took 'em down fast."),
    replies = {
        {
            when = predicates.any({ predicates.minimum_attribute("speaker", "perception", 7), predicates.minimum_attribute("speaker", "intelligence", 8) }),
            text = ccb.content.text("How does that explain all the other crazy stuff?"),
            next_topic = "CWH_NO_PAST_4_SKEPTIC",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "CWH_NO_PAST_4_SKEPTIC",
    line = ccb.content.text("What?  Of course it does.  They started with a bioweapon and then it went full nuclear.  Only the weapons we had now were a lot worse than H-bombs.  Uncle Sam managed to beat back the really nasty stuff, but I guess it was with his dying breath."),
    replies = {
        {
            text = ccb.content.text("Can you tell me more about what actually went down, though?"),
            next_topic = "CWH_NO_PAST_4_IDEAS2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
