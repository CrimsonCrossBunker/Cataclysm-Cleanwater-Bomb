local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_RC_SURVIVOR_2",
    line = ccb.content.text("What's up?"),
    replies = {
        { text = ccb.content.text("What's your story?"), next_topic = "TALK_RC_SURVIVOR_Story" },
        {
            text = ccb.content.text("You seen anything interesting out there?"),
            next_topic = "TALK_RC_SURVIVOR_Tips",
        },
        {
            text = ccb.content.text("Not much, just passing through.  Have a good day."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RC_SURVIVOR_Story",
    line = ccb.content.gendered_line("I found a map to this place in an evac center and thought I'd see if it was just full of <zombies> or if there was something up.  Didn't expect to find so many survivors still alive though.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("You looking for a traveling companion?  I could use someone to watch my back."),
            next_topic = "TALK_RC_SURVIVOR_Join",
        },
        {
            text = ccb.content.text("You seen anything interesting out there?"),
            next_topic = "TALK_RC_SURVIVOR_Tips",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
