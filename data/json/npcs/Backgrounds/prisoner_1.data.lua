local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_PRISONER_1_IN_FOR_GROWOP",
    line = ccb.content.text("That's a story in itself, my friend.  I had one of the largest grow-ops on the Eastern seaboard.  Hah, the stories I could tell you… but I won't.  That's all way behind me."),
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
    line = ccb.content.gendered_line("It's a bit of a… it's a thing.  It started out as a dare.  I wound up making a bioweapon.  It didn't get used or anything, but, well, it got out of hand.", { "interlocutor" }),
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
    line = ccb.content.gendered_line("Tax evasion.  I was an accountant, and I helped my boss move a hell of a lot of money in some very clever ways.  Not clever enough, it turns out…", { "interlocutor" }),
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
    line = ccb.content.text("This sounds a lot cooler than it is: possession of an unlicensed nuclear accelerator."),
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
    line = ccb.content.gendered_line("Multiple counts of possession.  I used to be really hung up on meth.", { "interlocutor" }),
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
    line = ccb.content.text("Assault charges.  I really don't want to get into it, let's just say that you don't want to talk during a movie around me okay?"),
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
    line = ccb.content.gendered_line("Okay, well, I was in the wrong place at the wrong time.  There was a big fight, I didn't stay clear of it, and me and a bunch of others got tossed in solitary while a few more landed in the infirmary.  Some looked pretty bad, now I kinda wonder if any of them were our first <zombies>.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("How did you get out of lockup?"),
            next_topic = "BGSS_PRISONER_1_STORY3",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PRISONER_1_STORY3",
    line = ccb.content.gendered_line("I heard gunshots, even from down in lockup.  Didn't hear much screaming or anything.  That was my first clue something was up.  Food stopped showing up, next.  Then, the lights went out.  I was down there for maybe hours, maybe days, when finally a flashlight in the bars blinded me.  It was a guard.  He let me out, filled me in on what was going on.  I wanted to think he was crazy, but something in his eyes… I believed him.", { "interlocutor" }),
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
    line = ccb.content.text("We let out the others in solitary.  We were stuck in, the guard bots had gone haywire and wouldn't let anyone out, and the rest of the people except this one guard had turned.  We spent a few days pulping <zombies> and trying to figure a safe way past the bots.  Food was running short.  Finally we picked the worst, only plan we could think of: we dragged some storage lockers to the entry hall, used them as shields, and pushed them until we were close enough to take out the bots' sensors with our weapons."),
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
    line = ccb.content.text("It worked better than I'd imagined, honestly.  We thought the bots would shoot the lockers but I guess they mistook us for family.  There were six of us and four of them, and four of us made it out."),
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

-- TK: Add two mission options, to go find the guard survivor and the bandits
ccb.content.define_dialogue_topic {
    id = "BGSS_PRISONER_1_STORY6",
    line = ccb.content.gendered_line("The guard took off on his own.  Didn't trust us, and I don't blame him.  The other two wanted to set up a bandit gig.  Didn't sit right with me, so I split on pretty good terms.  I ran into the guard a couple more times.  Thought of seeing if he'd travel with me, but I dunno.  I don't think he'd take the offer, I'll always be a con to him.  If you want to try, I can tell you where I saw him last.  Wasn't long before I met you, and he had a good thing going, might still be there.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
