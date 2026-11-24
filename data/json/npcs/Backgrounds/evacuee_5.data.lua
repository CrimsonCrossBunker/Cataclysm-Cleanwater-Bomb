local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- TK: In a future iteration, this evacuee might give you directions to a hive.
ccb.content.define_dialogue_topic {
    id = "BGSS_EVACUEE_5_STORY1",
    line = ccb.content.gendered_line("My evac shelter got swarmed by some of those bees, the ones the size of dogs.  I took out a few with a plank, but pretty quick I realized it was either head for the hills or get stuck like a pig.  The rest is history.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Giant bees?  Tell me more."),
            next_topic = "BGSS_EVACUEE_5_BEES",
        },
        {
            text = ccb.content.text("But bees aren't usually aggressive…"),
            next_topic = "BGSS_EVACUEE_5_WASPS",
            when = predicates.minimum_attribute("speaker", "perception", 8),
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_EVACUEE_5_BEES",
    line = ccb.content.gendered_line("Yeah, I'm sure you've seen them, they're everywhere.  Like something out of an old sci-fi movie.  Some of the others in the evac shelter got stung, it was no joke.  I didn't stick around to see what the lasting effect was though.  I'm not ashamed to admit I ran like a <freaking> chicken.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("But bees aren't usually aggressive… do you mean wasps?"),
            next_topic = "BGSS_EVACUEE_5_WASPS",
            when = predicates.minimum_attribute("speaker", "perception", 8),
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_EVACUEE_5_WASPS",
    line = ccb.content.gendered_line("Well, excuse me if I didn't stop to fucking ask what kind of killer bugs they were.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Sorry.  Could you tell me more about them?"),
            next_topic = "BGSS_EVACUEE_5_BEES",
        },
        { text = ccb.content.text("Right.  Sorry."), next_topic = "TALK_FRIEND_CONVERSATION" },
    },
}

ccb.content.define_dialogue_topic {
    id = "CWH_EVACUEE_5_IDEAS1",
    line = ccb.content.text("Okay listen.  Don't believe that government stuff.  There's a common thread to all of it: the riots, the military failing to contain it, even the giant monsters they said were appearing in the last few days and had to be wiped out with nukes."),
    replies = {
        { text = ccb.content.text("You've got my attention."), next_topic = "CWH_EVACUEE_5_IDEAS2" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "CWH_EVACUEE_5_IDEAS2",
    line = ccb.content.gendered_line("You ever see the Matrix?  This is it.  In real life.  To keep us locked in here, the creators of the simulation have to make sure we're just the right level of miserable.  I think their algorithms got messed up though, and went into overdrive, because all this is a little implausible.  Still, I guess we're still jacked in, so maybe it's working.", { "speaker" }),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
