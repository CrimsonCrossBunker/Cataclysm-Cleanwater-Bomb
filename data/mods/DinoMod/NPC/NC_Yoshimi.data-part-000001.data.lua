local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_yoshimi_firstmeet",
    line = ccb.content.text("You have seen through my ruse.  In retrospect I should have prepared a costume of some kind.  Unimportant!  You haven't attacked me or tried to seduce me so you aren't like the others.  Had any bad headaches recently, strange mood swings, strong urges, desire for human flesh?"),
    replies = {
        {
            text = ccb.content.text("Only the usual.  What are you really?"),
            next_topic = "TALK_yoshimi_what",
        },
        {
            text = ccb.content.text("You are aware of the Cataclysm then?"),
            next_topic = "TALK_yoshimi_cataclysm",
        },
        {
            text = ccb.content.text("I'd rather not say at this point."),
            next_topic = "TALK_Yoshimi_1",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_yoshimi_what",
    line = ccb.content.text("I am a hard working professional in a challenging field adjusting to a recent change in circumstances.  That is all you need to know."),
    replies = { { text = ccb.content.text("Fair enough."), next_topic = "TALK_Yoshimi_1" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_yoshimi_ask_past",
    line = ccb.content.text("My manager Dr. Tingle made some important mistakes and I have had to make some quick decisions I would rather not go into detail on.  In retrospect our faculties may have been influenced by external factors.  Suffice to say Dr. Tingle is no longer with us but died happy.  And I escaped alive."),
    replies = {
        {
            text = ccb.content.text("Let's talk about something else."),
            next_topic = "TALK_Yoshimi_1",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_yoshimi_cataclysm",
    line = ccb.content.text("Look at me.  Yes, I am aware.  The question is what happens next."),
    replies = {
        {
            text = ccb.content.text("Yes.  Let's talk about something else."),
            next_topic = "TALK_Yoshimi_1",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_yoshimi_ask_mood",
    line = ccb.content.text("I just got here, actually; I've recently found it wise to move a lot.  There may be some interesting specimens nearby.  I mean dinosaurs."),
    replies = { { text = ccb.content.text("Interesting."), next_topic = "TALK_Yoshimi_1" } },
}
