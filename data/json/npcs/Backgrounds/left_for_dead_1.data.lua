local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_LEFT_FOR_DEAD_1_STORY1",
    line = ccb.content.gendered_line("I was late to evacuate when the shit hit the fan.  Got stuck in town for a few days, survived by hiding in basements eating girl scout cookies and drinking warm root beer.  Eventually I managed to weasel my way out without getting caught by the <zombies>.  I spent a few days holed up in an abandoned mall, but I needed food so I headed out to fend for myself in the woods.  I wasn't doing a great job of it, so I'm kinda glad you showed up.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "CWH_LEFT_FOR_DEAD_1_IDEAS1",
    line = ccb.content.text("Okay, so, hear me out.  This might sound crazy, but we're dealing with the <freaking> walking dead, so I think I get a pass on that.  You know your Greek mythology at all?"),
    replies = {
        {
            text = ccb.content.text("Not really.  How is that relevant?"),
            next_topic = "CWH_LEFT_FOR_DEAD_1_EXPLAIN",
        },
        { text = ccb.content.text("Sure, why?"), next_topic = "CWH_LEFT_FOR_DEAD_1_IDEAS2" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "CWH_LEFT_FOR_DEAD_1_IDEAS2",
    line = ccb.content.text("Okay, well, I know this sounds like an Indiana Jones B-plot, but I think someone found Pandora's Box, the actual thing or close to it.  I think they tried to somehow harness it, to use the power in it for something.  Maybe even something good, who knows, the power of the gods seems like it would be a green energy source to me.  Whatever it was, they screwed it up, and released it for real.  Not just a metaphorical thing like in the stories, but actually set the forces of Hades loose on Earth.  Yeah, I know it's far-fetched, but like I said: I think I get a pass on that."),
    replies = {
        {
            text = ccb.content.text("What?  Pandora's box?"),
            next_topic = "CWH_LEFT_FOR_DEAD_1_EXPLAIN",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "CWH_LEFT_FOR_DEAD_1_EXPLAIN",
    line = ccb.content.text("According to legend, Pandora was in the house of the gods and found an unopened box.  She decided to investigate, and when she opened it and unthinkable horrors and diseases spilled out.  Sound familiar?"),
    replies = {
        {
            text = ccb.content.text("Sure, what's that go to do with anything?"),
            next_topic = "CWH_LEFT_FOR_DEAD_1_IDEAS2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
