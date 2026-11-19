local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_RC_SURVIVOR_Tips2",
    line = ccb.content.text("Sure, here, I'll draw you up a little map."),
    replies = {
        {
            text = ccb.content.text("Thanks!  What's your story?"),
            next_topic = "TALK_RC_SURVIVOR_Story",
        },
        { text = ccb.content.text("Thanks!  <end_talking_leave>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RC_SURVIVOR_Join",
    line = ccb.content.text("Sorry, I have people of my own to look out for.  I can't leave them in the lurch."),
    replies = {
        {
            text = ccb.content.text("They could come along too."),
            next_topic = "TALK_RC_SURVIVOR_Join1",
        },
        {
            text = ccb.content.text("Why don't I come back to your hideout?"),
            next_topic = "TALK_RC_SURVIVOR_Join2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RC_SURVIVOR_Join1",
    line = ccb.content.text("It doesn't really work that way.  They're back in safety, and I've got to go check in with them with some supplies.  You know how it is, not everyone is suited to risk travel these days."),
    replies = {
        {
            text = ccb.content.text("Why don't I come back to your hideout?"),
            next_topic = "TALK_RC_SURVIVOR_Join2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RC_SURVIVOR_Join2",
    line = ccb.content.text("Look, I don't know a better way to put this.  I don't know you, I can't bring some random back with me.  For all I know you're a cannibal psycho or something.  We all saw too much of that during <the_cataclysm>.  Me and mine, we're not looking to expand our tribe just now, OK?"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
