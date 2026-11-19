local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Julian_Leader",
    line = ccb.content.text("Advantages?  All I do is work!"),
    replies = {
        {
            text = ccb.content.text("Anything I can do to help you out?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Yeah, it must be exhausting.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Julian_Mood",
    line = ccb.content.text("It's been a struggle, trying to keep this bunch together.  Oh things could be better here, of course.  It could always be, but sometimes we don't even realize how good we have it here."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Julian_Church",
    line = ccb.content.text("When I was younger, I used to go to church with my family.  When I started growing up, I saw all this evil around me, people hating and persecuting others, despite the teachings of Jesus; I just stopped going one day, decided to make my own way.  I joined the NECC a few years back to rekindle my relationship with God, get back to who I was."),
    replies = { { text = ccb.content.text("Let's change the subject."), next_topic = "TALK_GODCO_Julian_2" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Julian_NoChat",
    line = ccb.content.text("I'd rather not talk about it."),
    replies = {
        {
            text = ccb.content.text("Yeah, I can understand.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Julian_Angry",
    line = ccb.content.text("&\"You've messed me over a good bit, and I've had enough.  Goodbye.\"  Julian goes back to his business and ignores you."),
    replies = { { text = ccb.content.text("See ya later <name_b>."), next_topic = "TALK_DONE" } },
}
