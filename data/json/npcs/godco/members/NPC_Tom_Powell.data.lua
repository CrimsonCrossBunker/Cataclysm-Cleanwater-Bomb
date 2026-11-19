local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Tom_Olwen_Love0",
    line = ccb.content.text("I see that she is feeling down since <the_cataclysm> ruined their plans of living together, but Julian was asking me the other day about my wedding with Felicity so…  I can expect that to not last long."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Tom_Olwen_Love1",
    line = ccb.content.text("I saw her big smile when receiving her ring from Julian, some days the smiles of my family are what keeps me going after everything that happened…"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Tom_Olwen_Love2",
    line = ccb.content.text("She is constantly jumping from happiness after trying her wedding dress with her mother…  I keep getting distracted from my investigation into <the_cataclysm>, but seeing those two makes me smile so I can't stop seeing their antics."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Tom_Community",
    line = ccb.content.text("New England Church Community is what they're called.  My wife was the first in the family to come in contact with 'em.  She joined because of their charity work and as for myself, well… you know why I was there.  Let me tell you, being surrounded by like-minded folks was like a breath of fresh air.  Even if the only belief we shared was paranoia, but you get what I'm saying.  I tried everything to prep my family for the inevitable, I really did, but in the end it wasn't me who saved us all."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Tom_Goal",
    line = ccb.content.text("I want to find out the truth and preserve the past for the following generation, so that they'll know some of what happened."),
    replies = {
        { text = ccb.content.text("Any progress?"), next_topic = "TALK_GODCO_Tom_Goal1" },
        {
            text = ccb.content.text("Sounds like an ambitious project.  Is there anything I can do to help you out?"),
            next_topic = "TALK_GODCO_Tom_Help",
        },
        {
            text = ccb.content.text("Good luck with that.  See you around, Tom."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Tom_Goal1",
    line = ccb.content.text("So far?  Not so great.  Now that the Internet is down, I don't know.  Such abundant hidden information - all gone!"),
    replies = {
        {
            text = ccb.content.text("Is there anything I can do to help you out?"),
            next_topic = "TALK_GODCO_Tom_Help",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Try not to glorify the past.  See you around, Tom."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Tom_Help",
    line = ccb.content.text("Of course!  Just put all your literary findings on that chair over there.  Remember, you're not only doing a favor for me, but for all of humanity as well.  World heritage is what we're talking about!  I managed to get my hands on a book called 'Zombie Survival Guide' while, uh… dumpster diving.  Imagine how much this book alone reveals about our pre-Cataclysm culture!  Oh boy, how wrong we were about everything."),
    replies = {
        {
            text = ccb.content.text("I mean, can I help with the research?"),
            next_topic = "TALK_GODCO_Tom_Research",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Tom_Research",
    line = ccb.content.text("No no no no no!  Thinking is one of the only thing I have left and you can't take that away from me.  But, If you *really* want to make yourself useful, relevant newspapers would help me piece out the puzzle."),
    repeat_replies = {
        {
            items = { "newest_newspaper", "weeks_old_newspaper", "months_old_newspaper" },
            reply = { text = ccb.content.text("Delivering <topic_item>."), next_topic = "TALK_DELIVER_ASK" },
        },
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Tom_Angry",
    line = ccb.content.text("No, I'm all out of them.  Now, I've got better things to do, goodbye."),
    replies = { { text = ccb.content.text("Okay Tom, go ahead and be that way."), next_topic = "TALK_DONE" } },
}
