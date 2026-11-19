local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_LEFT_FOR_DEAD_2_STORY1",
    line = ccb.content.text("I was sick when the world went to shit, and when I recovered enough to make a run for food… well, I've been running ever since."),
    replies = {
        {
            text = ccb.content.text("Come on, don't leave me hanging."),
            next_topic = "BGSS_LEFT_FOR_DEAD_2_STORY2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_LEFT_FOR_DEAD_2_STORY2",
    line = ccb.content.text("Okay, well, I was kinda out of it those first few days.  I knew there were storms, but I was having crazy fever dreams and stuff.  Honestly I probably should have gone to get help, except then I guess I'd be dead now.  I don't know what was a dream and what was the world ending.  I remember getting a drink and hearing some screaming far away, I think that was a bit before my fever broke.  I was still pretty groggy when I ran out of food, so it took me a while to really process how dead everything was when I headed out."),
    replies = {
        {
            text = ccb.content.text("What happened when you went out?"),
            next_topic = "BGSS_LEFT_FOR_DEAD_2_STORY3",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_LEFT_FOR_DEAD_2_STORY3",
    line = ccb.content.text("You probably remember what it was like.  I think it was about day four.  Once I stepped outside I realized what was going on, or realized I didn't know what was going on at least.  I saw a bunch of rioters smashing a tree, and then I noticed one of them was bashing a woman's head in.  I canceled my food trip, ran away before they saw me, and hid for as long as I could.  Things got comparatively quiet as the dead started to outnumber the living, so I started looting what I could from my neighbors, re-killing them when I had to.  Eventually the <zombies> overran my area and I had to climb out and head for the hills."),
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
    id = "CWH_LEFT_FOR_DEAD_2_IDEAS1",
    line = ccb.content.text("You mean what caused the riots and all that?  Well, they told us it was a foreign weapon but I have troubles believing anyone could engineer a weapon that could do all this.  The only answer I can come up with, silly though it sounds, is aliens."),
    replies = {
        {
            text = ccb.content.text("You think this is an invasion?"),
            next_topic = "CWH_LEFT_FOR_DEAD_2_IDEAS2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "CWH_LEFT_FOR_DEAD_2_IDEAS2",
    line = ccb.content.text("Well, maybe, but I'd guess it's too disorganized to be a proper invasion.  If I had to guess, I'd say there was something locked in the polar ice.  Like, remember a few years back there was that big thing online about an alien body found in the ice?  I don't know if you remember but it was all anyone was talking about for a while until it turned out to be a hoax.  Only, since then, I've seen some aliens walking around that look a *lot* like that ice body.  Maybe it wasn't a hoax, maybe that was a cover-up.  So, maybe those aliens had some kind of disease.  It went around the world and infected everything silently until, somehow, it activated and caused the violence and monsters and mutations."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
