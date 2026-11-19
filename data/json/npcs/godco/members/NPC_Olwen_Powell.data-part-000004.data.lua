local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Olwen_Mood",
    line = ccb.content.text("They're alright, I suppose.  Helena's an asshole as usual, we're low on supplies, and all scared to go twenty feet outside the gate."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Olwen_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Olwen_Story",
    line = ccb.content.text("Not much too it, really.  I came here on that bus with everyone else when <the_cataclysm> happened to stroll by.  I've been servicing everyone's electronics since then."),
    replies = {
        {
            text = ccb.content.text("Could you tell me about your past?"),
            next_topic = "TALK_GODCO_Olwen_Background",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Olwen_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Olwen_Background",
    line = ccb.content.text("Why not?  Oversharing is kind of my thing anyway.  Got any more interview questions?"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Olwen_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Olwen_Family",
    line = ccb.content.text("My dad's having a hard time letting go of the past.  Got any more interview questions?"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Olwen_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Olwen_Love0",
    line = ccb.content.text("Well…  Things were going pretty well between Julian and I before <the_cataclysm>, but after everything that happened…  Ugh, I'm getting depressed just thinking about it.  Let's just talk about something else."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Olwen_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Olwen_Love1",
    line = ccb.content.text("Pretty well actually!  Julian just asked me to marry him!  With wedding rings and everything!  I must be the happiest woman still alive!"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Olwen_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Olwen_Love2",
    line = ccb.content.text("I'm on cloud nine!  I just came back from trying on my wedding dress!  Julian is so charming thinking of everything, I don't know how to repay him, I'm really over the moon with the wedding."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Olwen_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
