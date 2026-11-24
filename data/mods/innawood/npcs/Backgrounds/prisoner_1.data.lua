local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- This is a stand-in for 'npc_has_trait_flag': 'EXP_Bookkeeping' when that becomes available
-- This is a stand-in for 'npc_has_trait_flag': 'EXP_Medicine' when that becomes available
ccb.content.define_dialogue_topic {
    id = "BGSS_PRISONER_1_STORY1",
    line = ccb.content.text("I was locked up during <the_cataclysm>, but I escaped.  Hell of a story."),
    replies = {
        {
            text = ccb.content.text("So tell me this 'hell of a story'"),
            next_topic = "BGSS_PRISONER_1_STORY2",
        },
        {
            text = ccb.content.text("What were you in for?"),
            when = predicates.all({ predicates.any({ predicates.has_trait("interlocutor", "Exp_Agriculture1"), predicates.has_trait("interlocutor", "Exp_Agriculture2") }), predicates.negate(predicates.has_trait("interlocutor", "Exp_Biochemistry1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Biochemistry2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Bookkeeping1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Bookkeeping2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Medicine1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Medicine2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Physics1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Physics2")), predicates.negate(predicates.has_trait("interlocutor", "ADDICTIVE")), predicates.negate(predicates.has_trait("interlocutor", "PSYCHOTIC")) }),
            next_topic = "BGSS_PRISONER_1_IN_FOR_GROWOP",
        },
        {
            text = ccb.content.text("What were you in for?"),
            when = predicates.all({ predicates.any({ predicates.has_trait("interlocutor", "Exp_Biochemistry1"), predicates.has_trait("interlocutor", "Exp_Biochemistry2") }), predicates.negate(predicates.has_trait("interlocutor", "Exp_Agriculture1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Agriculture2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Biochemistry1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Biochemistry2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Bookkeeping1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Bookkeeping2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Medicine1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Medicine2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Physics1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Physics2")), predicates.negate(predicates.has_trait("interlocutor", "ADDICTIVE")), predicates.negate(predicates.has_trait("interlocutor", "PSYCHOTIC")) }),
            next_topic = "BGSS_PRISONER_1_IN_FOR_BIOWEAPON",
        },
        {
            text = ccb.content.text("What were you in for?"),
            when = predicates.all({ predicates.any({ predicates.has_trait("interlocutor", "Exp_Bookkeeping1"), predicates.has_trait("interlocutor", "Exp_Bookkeeping2") }), predicates.negate(predicates.has_trait("interlocutor", "Exp_Agriculture1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Agriculture2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Biochemistry1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Biochemistry2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Medicine1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Medicine2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Physics1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Physics2")), predicates.negate(predicates.has_trait("interlocutor", "ADDICTIVE")), predicates.negate(predicates.has_trait("interlocutor", "PSYCHOTIC")) }),
            next_topic = "BGSS_PRISONER_1_IN_FOR_TAXEVASION",
        },
        {
            text = ccb.content.text("What were you in for?"),
            when = predicates.all({ predicates.any({ predicates.has_trait("interlocutor", "Exp_Medicine1"), predicates.has_trait("interlocutor", "Exp_Medicine2") }), predicates.negate(predicates.has_trait("interlocutor", "Exp_Agriculture1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Agriculture2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Biochemistry1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Biochemistry2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Bookkeeping1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Bookkeeping2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Medicine1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Medicine2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Physics1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Physics2")), predicates.negate(predicates.has_trait("interlocutor", "ADDICTIVE")), predicates.negate(predicates.has_trait("interlocutor", "PSYCHOTIC")) }),
            next_topic = "BGSS_PRISONER_1_IN_FOR_ORGANS",
        },
        {
            text = ccb.content.text("What were you in for?"),
            when = predicates.all({ predicates.any({ predicates.has_trait("interlocutor", "Exp_Physics1"), predicates.has_trait("interlocutor", "Exp_Physics2") }), predicates.negate(predicates.has_trait("interlocutor", "Exp_Agriculture1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Agriculture2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Biochemistry1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Biochemistry2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Bookkeeping1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Bookkeeping2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Medicine1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Medicine2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Physics1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Physics2")), predicates.negate(predicates.has_trait("interlocutor", "ADDICTIVE")), predicates.negate(predicates.has_trait("interlocutor", "PSYCHOTIC")) }),
            next_topic = "BGSS_PRISONER_1_IN_FOR_NUCLEAR",
        },
        {
            text = ccb.content.text("What were you in for?"),
            when = predicates.all({ predicates.has_trait("interlocutor", "ADDICTIVE"), predicates.negate(predicates.has_trait("interlocutor", "Exp_Agriculture1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Agriculture2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Biochemistry1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Biochemistry2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Bookkeeping1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Bookkeeping2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Medicine1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Medicine2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Physics1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Physics2")), predicates.negate(predicates.has_trait("interlocutor", "PSYCHOTIC")) }),
            next_topic = "BGSS_PRISONER_1_IN_FOR_METH",
        },
        {
            text = ccb.content.text("What were you in for?"),
            when = predicates.all({ predicates.has_trait("interlocutor", "PSYCHOTIC"), predicates.negate(predicates.has_trait("interlocutor", "Exp_Agriculture1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Agriculture2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Biochemistry1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Biochemistry2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Bookkeeping1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Bookkeeping2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Medicine1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Medicine2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Physics1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Physics2")), predicates.negate(predicates.has_trait("interlocutor", "ADDICTIVE")) }),
            next_topic = "BGSS_PRISONER_1_IN_FOR_ASSAULT",
        },
        {
            text = ccb.content.text("What were you in for?"),
            when = predicates.all({ predicates.negate(predicates.has_trait("interlocutor", "Exp_Agriculture1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Agriculture2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Biochemistry1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Biochemistry2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Bookkeeping1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Bookkeeping2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Medicine1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Medicine2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Physics1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Physics2")), predicates.negate(predicates.has_trait("interlocutor", "ADDICTIVE")), predicates.negate(predicates.has_trait("interlocutor", "PSYCHOTIC")) }),
            next_topic = "BGSS_PRISONER_1_IN_FOR_OTHER",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PRISONER_1_IN_FOR_GROWOP",
    line = ccb.content.text("That's a story in itself, my friend.  I had one of the largest growing operations in this fine land.  Hah, the stories I could tell you… but I won't.  That's all way behind me."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PRISONER_1_IN_FOR_BIOWEAPON",
    line = ccb.content.text("It's a bit of a… it's a thing.  It started out as a dare.  I wound up making a special experimental weapon.  It didn't get used or anything, but, well, it got out of hand."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PRISONER_1_IN_FOR_TAXEVASION",
    line = ccb.content.text("Debt.  I borrowed a lot from a lot of people and eventually it all came crashing down on me and it turned out I broke some rules doing it…"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PRISONER_1_IN_FOR_NUCLEAR",
    line = ccb.content.text("This sounds a lot cooler than it is: I made a giant bomb."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PRISONER_1_IN_FOR_ORGANS",
    line = ccb.content.text("I got a little bit into black market organ trading.  It sounds worse than it was… but it was pretty bad."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PRISONER_1_IN_FOR_METH",
    line = ccb.content.text("I had a lot of weed.  Like a lot."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PRISONER_1_IN_FOR_ASSAULT",
    line = ccb.content.text("Assault charges.  I really don't want to get into it, let's just say that you don't want to look at me cross eyed when I'm in a bad mood okay?"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PRISONER_1_IN_FOR_OTHER",
    line = ccb.content.text("You know, I don't really want to say anymore.  It's all behind me, and I'd like to keep it that way."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PRISONER_1_STORY2",
    line = ccb.content.text("Okay, well, I was in the wrong place at the wrong time.  There was a big fight, I didn't stay clear of it, and me and a bunch of others got tied up to a tree while a few more got patched up.  Some looked pretty bad, now I kinda wonder if any of them were our first <zombies>."),
    replies = {
        { text = ccb.content.text("How did you get away?"), next_topic = "BGSS_PRISONER_1_STORY3" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PRISONER_1_STORY3",
    line = ccb.content.text("I heard gunshots, even from a ways away.  Didn't hear much screaming or anything.  That was my first clue something was up.  Food stopped showing up, next.  I was tied up there for maybe hours, maybe days, when finally someone woke me up.  It was a guard.  He let me go, filled me in on what was going on.  I wanted to think he was crazy, but something in his eyes… I believed him."),
    replies = {
        {
            text = ccb.content.text("What did you do from there?"),
            next_topic = "BGSS_PRISONER_1_STORY4",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PRISONER_1_STORY4",
    line = ccb.content.text("We let the others go too.  We were stuck in, a swarm of giant wasps had set down surrounding us, and the rest of the people except this one guard had turned.  We spent a few days pulping <zombies> and trying to figure a safe way past the wasps.  Food was running short.  Finally we picked the worst, only plan we could think of: we waited until nightfall and ran like hell."),
    replies = {
        {
            text = ccb.content.text("Did that actually work?"),
            next_topic = "BGSS_PRISONER_1_STORY5",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PRISONER_1_STORY5",
    line = ccb.content.text("It worked better than I'd imagined, honestly.  We thought the wasps would catch us but I guess they got sleepy.  There were six of us and four of them, and four of us made it out."),
    replies = {
        {
            text = ccb.content.text("What happened to the others that made it?"),
            next_topic = "BGSS_PRISONER_1_STORY6",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PRISONER_1_STORY6",
    line = ccb.content.text("The guard took off on his own.  Didn't trust us, and I don't blame him.  The other two wanted to set up a bandit gig.  Didn't sit right with me, so I split on pretty good terms.  I ran into the guard a couple more times.  Thought of seeing if he'd travel with me, but I dunno.  I don't think he'd take the offer, I'll always be a criminal to him.  If you want to try, I can tell you where I saw him last.  Wasn't long before I met you, and he had a good thing going, might still be there."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
