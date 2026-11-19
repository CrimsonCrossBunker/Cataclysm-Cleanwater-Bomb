local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_EVACUEE_4_STORY1",
    line = ccb.content.text("I was traveling with a bunch of other evacuees, when we got jumped by the biggest zombie you ever saw.  It was busy with the others, so I did what anyone would do and fucked right out of there."),
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
    line = ccb.content.text("I ran until I felt like my lungs were going to jump right out of my mouth.  I holed up in the forest for the night, under a fir tree.  In the morning I heard someone talking, so I went to see.  I was playing it pretty careful though, there were still a lot of psychos and rioters around.  I snuck up on some kind of thing, some monster worse than any zombie.  Some huge bug thing, saying random phrases like some kind of broken tape recorder.  It was dragging a few human bodies behind it, I couldn't tell if they were dead or unconscious.  Honestly I didn't wait to find out, I ducked into the bushes and tried not to breath until I couldn't hear it anymore."),
    replies = {
        {
            text = ccb.content.text("Where did you go from there?"),
            next_topic = "BGSS_EVACUEE_4_STORY3",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_EVACUEE_4_STORY3",
    line = ccb.content.text("Once I was okay leaving the bushes, I made my way to a cave I could see a ways off.  It wasn't luxury but it kept the rain and wind off and gave me a place out of sight.  I stayed there until I got hungry.  Then I took on the wanderin' life until we met."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "CWH_EVACUEE_4_IDEAS1",
    line = ccb.content.text("How could you not know what happened?  The world damn well ended, that's what.  And it didn't start with an earthquake, birds, snakes, or music.  It started with riots, and they had to dispatch violent goons to take care of the <freaking> criminals.  The leadership tried to pad it claiming it was some kind of mind control, but I didn't see too much different from the usual bullshit: entitled babies looking for an excuse to break the law.  It just got way worse, this time, until it was time to get away.  I heard rumors they were even burning some places to try to control it - which, I have to admit, is maybe a bit too hard-core."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
