local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_EVACUEE_6_STORY1",
    line = ccb.content.gendered_line("Well, I was at home when the cell phone alert went off and told me to get to an evac shelter.  So I went to an evac shelter.  And then the shelter got too crowded, and people were waiting to get taken to the refugee center, but the buses never came.  You must already know about all that.  It turned into panic, and then fighting.  I didn't stick around to see what happened next; I headed into the woods with what tools I could snatch from the lockers.  I went back a few days later, but the place was totally abandoned.  No idea what happened to all those people.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "CWH_EVACUEE_6_IDEAS1",
    line = ccb.content.gendered_line("I gotta be honest with you, I heard a lot of stories back at the shelter, and only one of them really stuck.  This is some kind of science experiment gone wrong.  I don't know what caused the riots and the undead in the first place, but there's no way it's this out of control everywhere.  Yeah, I got the same 'the government has fallen' text as everyone, but it doesn't make *sense* that it could be so widespread so fast.  I think we're in some sort of exclusion zone, where they're letting whatever is going on run its course to see how it works so they can fight it better next time.  Somewhere out there, outside the zone, it's more or less business as usual.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
