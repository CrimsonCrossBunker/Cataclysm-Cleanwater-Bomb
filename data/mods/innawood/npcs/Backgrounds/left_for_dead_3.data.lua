local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_LEFT_FOR_DEAD_3_STORY1",
    line = ccb.content.text("Let's not dance around it: I joined the riots, at first.  I don't really remember what I was thinking.  I'd protested stuff like politics before, but this was different.  I didn't go down there expecting to chant and march, I grabbed a rock and went out planning to fuck shit up.  I've never felt so angry before.  The riots had already been going on a while at that point, and to me, it just looked like the man trying to squash the people again."),
    replies = {
        {
            text = ccb.content.text("Those rioters had a reputation for being absolutely psycho."),
            next_topic = "BGSS_LEFT_FOR_DEAD_3_STORY2",
        },
        {
            text = ccb.content.text("Not many people made it out of the riots alive."),
            next_topic = "BGSS_LEFT_FOR_DEAD_3_STORY3",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_LEFT_FOR_DEAD_3_STORY2",
    line = ccb.content.text("Yeah, you're telling me.  The rioters… they weren't even like humans, let alone protesters.  Nothing like any protest I'd ever been in before.  That didn't stop me.  I joined them, and I was as bad as a bunch of them.  Smashed stuff, beat up bystanders, set stuff on fire.  I remember ripping all the gear off this big bruiser and… nevermind.  I don't want to remember that."),
    replies = {
        {
            text = ccb.content.text("How did you survive?"),
            next_topic = "BGSS_LEFT_FOR_DEAD_3_STORY3",
        },
        {
            text = ccb.content.text("What made you come back?"),
            next_topic = "BGSS_LEFT_FOR_DEAD_3_STORY4",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_LEFT_FOR_DEAD_3_STORY3",
    line = ccb.content.text("At some point, I felt like I was waking up.  It was around the time they were busting out those big groups of guys spears.  Says something about my frame of mind that I don't even remember if I'd seen them before that point.  Anyway I heard the shouting and just kinda realized I was on the edges of a mob charging a line of spear tips pointed at us.  That's when I started seeing the mob for what it was, seeing the wild-eyed animals, even the zombies.  I turned and ran."),
    replies = {
        {
            text = ccb.content.text("What made you come back?"),
            next_topic = "BGSS_LEFT_FOR_DEAD_3_STORY4",
        },
        {
            text = ccb.content.text("Where did you go from there?"),
            next_topic = "BGSS_LEFT_FOR_DEAD_3_STORY5",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_LEFT_FOR_DEAD_3_STORY5",
    line = ccb.content.text("I knew the area pretty well.  I went for a quiet place I knew about, got there without being seen, and holed up in there for a few days.  I had a fair bit of stolen food and I just kept to myself.  When things started to quiet down, I headed out, and here I am."),
    replies = {
        {
            text = ccb.content.text("Thanks for telling me all that.  <done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        {
            text = ccb.content.text("Thanks for telling me all that.  <end_talking>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "CWH_LEFT_FOR_DEAD_3_IDEAS1",
    line = ccb.content.text("So, I remember the time leading up to the riots, same as anyone.  Things were bad, there were some really awful crimes happening, and there was a lot of racial tension as usual from the way the enforcers were handling it.  Then people started rioting, which isn't unusual, but it was weird the kind of places that the riots were starting in.  Like, nice, quiet places.  Anyway, I joined the riots and I don't remember a lot of clear stuff after that."),
    replies = {
        {
            text = ccb.content.text("You joined the riots?"),
            next_topic = "BGSS_LEFT_FOR_DEAD_3_STORY1",
        },
        {
            text = ccb.content.text("You must have some insights into what caused all this, then."),
            next_topic = "CWH_LEFT_FOR_DEAD_3_IDEAS2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "CWH_LEFT_FOR_DEAD_3_IDEAS2",
    line = ccb.content.text("Kinda, I guess.  I heard people blaming the riots on some kind of drug, and frankly I'm not sure that's far off base.  That's kinda what it felt like, although the whole time I really felt like myself.  It wasn't until I snapped out of it that I realized how weird it was.  That doesn't explain anything else though: the zombies, the monsters, all this stuff is way off base.  Anything I've tried to guess just sounds like scary stories, like demonic curses or alien weapons kinda stuff."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
