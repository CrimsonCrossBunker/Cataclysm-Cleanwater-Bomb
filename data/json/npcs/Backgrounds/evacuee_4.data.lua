local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_EVACUEE_4_STORY1",
    line = ccb.content.gendered_line("They were shipping me with a bunch of evacuees over to a refugee center, when the bus got smashed in by the biggest zombie you ever saw.  It was busy with the other passengers, so I did what anyone would do and fucked right out of there.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Don't leave me hanging, what happened next?"),
            next_topic = "BGSS_EVACUEE_4_STORY2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_EVACUEE_4_STORY2",
    line = ccb.content.gendered_line("I ran until I felt like my lungs were going to jump right out of my mouth.  I holed up in the forest for the night, under a fir tree.  In the morning I heard someone talking, so I went to see.  I was playing it pretty careful though, there were still a lot of psychos and rioters around.  I snuck up on some kind of thing, some monster worse than any zombie.  Some huge bug thing, saying random phrases like some kind of broken tape recorder.  It was dragging a few human bodies behind it, I couldn't tell if they were dead or unconscious.  Honestly I didn't wait to find out, I ducked into the bushes and tried not to breath until I couldn't hear it anymore.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Where did you go from there?"),
            next_topic = "BGSS_EVACUEE_4_STORY3",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_EVACUEE_4_STORY3",
    line = ccb.content.gendered_line("Once I was okay leaving the bushes, I made my way to an old shed I could see a ways off.  It was falling in but it kept the rain and wind off and gave me a place out of sight.  I stayed there until I ran out of those ass-tasting ration bars I'd filled my backpack with.  Then I took on the wanderin' life until we met.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "CWH_EVACUEE_4_IDEAS1",
    line = ccb.content.text("What's this, some kinda Back to the Future thing?  How could you not know what happened?  The world damn well ended, that's what.  And it didn't start with an earthquake, birds, snakes, or airplanes.  It started with riots, and they had to dispatch cops and then the military to take care of the <freaking> criminals.  The government tried to pad it claiming it was some kind of mind control, but I didn't see too much different from the usual bullshit: entitled babies looking for an excuse to break the law.  It just got way worse, this time, until it was time to get out of dodge.  I heard rumors they were even bombing some of the urban centers to try to control it - which, I have to admit, is maybe a bit too hard-core."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
