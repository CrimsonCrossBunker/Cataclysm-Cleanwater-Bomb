local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GREAT_LIBRARY_LIBRARIAN_AboutGreeting",
    line = ccb.content.text("*frowning.  \"Listen, we are doing our best here.  Most of our original staff is gone and people keep stealing and breaking things for no reason.  We're just trying to protect some information for the future.\""),
    replies = {
        {
            text = ccb.content.text("Okay, I'm sorry."),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_AboutGreeting_End",
        },
        {
            text = ccb.content.text("But why bother then?"),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_AboutGreeting_Why",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GREAT_LIBRARY_LIBRARIAN_AboutGreeting_End",
    line = ccb.content.text("*deep breath, tired smile.  \"How else can I help you?\""),
}

ccb.content.define_dialogue_topic {
    id = "TALK_GREAT_LIBRARY_LIBRARIAN_AboutGreeting_Why",
    line = ccb.content.text("*frowning, grimacing.  \"I don't know.  It's.  I can't talk about this right now.\""),
    replies = {
        {
            text = ccb.content.text("Of course, I'm sorry."),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_AboutGreeting_End",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_GREAT_LIBRARY_LIBRARIAN_AboutMe", "TALK_GREAT_LIBRARY_LIBRARIAN_AboutMe_Basic" },
    line = ccb.content.text("Oh.  Um.  I guess I like stories.  And quiet."),
    replies = {
        {
            text = ccb.content.text("How did you end up here?"),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_AboutMe_Basic",
        },
        {
            text = ccb.content.text("That's fine for now."),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_Talk",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GREAT_LIBRARY_LIBRARIAN_AboutMe_Basic",
    line = ccb.content.text("Oh, well I took a job here about a year before <the_cataclysm>, and I was living alone when things got bad and I thought I might be safer here with work friends.  My friends Beatrice and Ross and I got some supplies ready and then more people started to join us.  And then it got bad.  But I think that has settled down some now."),
}
