local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- TK: In a future iteration, this evacuee might give you directions to a hive.
ccb.content.define_dialogue_topic {
    id = "BGSS_EVACUEE_5_STORY1",
    line = ccb.content.text("My cave got swarmed by some of those bees, the ones the size of dogs.  I took out a few with a stick, but pretty quick I realized it was either head for the hills or get stuck like a pig.  The rest is history."),
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
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_EVACUEE_5_BEES",
    line = ccb.content.text("Yeah, I'm sure you've seen them, they're everywhere.  Like something out of a scary story.  Some of the others in the cave got stung, it was no joke.  I didn't stick around to see what the lasting effect was though.  I'm not ashamed to admit I ran like a <freaking> chicken."),
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
