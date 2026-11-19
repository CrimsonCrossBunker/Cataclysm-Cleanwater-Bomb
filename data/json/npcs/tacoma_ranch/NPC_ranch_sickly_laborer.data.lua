local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_ILL_1_JOB",
    line = ccb.content.gendered_line("I was just a laborer till they could find me something a bit more permanent, but being constantly sick has prevented me from doing much of anything.", { "interlocutor" }),
    replies = { { text = ccb.content.text("That's sad."), next_topic = "TALK_RANCH_ILL_1" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_ILL_1_HIRE",
    line = ccb.content.gendered_line("I don't know what you could do.  I've tried everything.  Just give me time…", { "interlocutor" }),
    replies = { { text = ccb.content.text("OK."), next_topic = "TALK_RANCH_ILL_1" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_ILL_1_SICK",
    line = ccb.content.gendered_line("I keep getting sick!  At first I thought it was something I ate, but now it seems like I can't keep anything down…", { "interlocutor" }),
    replies = { { text = ccb.content.text("Uhm."), next_topic = "TALK_RANCH_ILL_1" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_SICKLY_LABORER_ANESTHETIC_FOR_DOCTOR",
    line = ccb.content.text("What could I possibly have that could help?"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_nevermind>"),
            next_topic = "TALK_RANCH_ILL_1",
        },
    },
}
