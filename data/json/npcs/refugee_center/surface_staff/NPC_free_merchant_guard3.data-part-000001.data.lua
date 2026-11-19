local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD3",
    line = ccb.content.text("Keep to yourself and you won't find any problems."),
    replies = {
        {
            text = ccb.content.text("What do you do around here?"),
            next_topic = "TALK_EVAC_GUARD3_NEW",
        },
        {
            text = ccb.content.text("Got tips for avoiding trouble?"),
            next_topic = "TALK_EVAC_GUARD3_RULES",
        },
        {
            text = ccb.content.text("Have you seen anyone who might be hiding something?"),
            next_topic = "TALK_EVAC_GUARD3_HIDE1",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD3_NEW",
    line = ccb.content.gendered_line("I haven't been here for long but I do my best to watch who comes and goes.  You can't always predict who will bring trouble.", { "interlocutor" }),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_EVAC_GUARD3" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD3_RULES",
    line = ccb.content.text("Keep your head down and stay out of my way."),
    replies = { { text = ccb.content.text("OK…"), next_topic = "TALK_EVAC_GUARD3" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD3_HIDE1",
    line = ccb.content.text("Like what?"),
    replies = {
        { text = ccb.content.text("I'm not sure…"), next_topic = "TALK_EVAC_GUARD3_WASTE" },
        {
            text = ccb.content.text("Like they could be working for someone else?"),
            next_topic = "TALK_EVAC_GUARD3_HIDE2",
        },
    },
}
