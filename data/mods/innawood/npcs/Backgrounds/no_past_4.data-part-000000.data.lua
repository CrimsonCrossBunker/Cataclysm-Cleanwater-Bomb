local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_NO_PAST_4_STORY1",
    line = ccb.content.text("Who I was is gone.  All that stuff burned away in <the_cataclysm>.  Got it?  Who I am now started two days into it.  I was on the run from a big-ass hell zombie, running like I'd always been doing, when I found a stick laying on the ground.  I took it as a sign and beat that gooey bastard to a pulp… and that's when I became me.  I still run, because who doesn't, but I stand my ground now."),
    replies = {
        {
            text = ccb.content.text("What happened to you after that?"),
            next_topic = "BGSS_NO_PAST_4_STORY2",
        },
        {
            text = ccb.content.text("It can't be healthy to abandon your past like that…"),
            next_topic = "BGSS_NO_PAST_4_DROPIT",
            opinion = { anger = 3 },
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_NO_PAST_4_STORY2",
    line = ccb.content.text("I went on, running when I had to and fighting when I could, like the rest of us.  Started learning who I am now.  Lost the stick in a fight against some crazy electric lightning shooting zombie.  I wound up having to run.  I nearly died that day."),
    replies = {
        {
            text = ccb.content.text("It can't be healthy to abandon your past like that…"),
            next_topic = "BGSS_NO_PAST_4_DROPIT",
            opinion = { anger = 3 },
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_NO_PAST_4_DROPIT",
    line = ccb.content.gendered_line("Listen.  I said it clearly, and if you keep picking at it I'm gonna get mad.  Who I was is gone.  Dead.  I don't give a shit about your 'healthy', don't <freaking> ask again.", { "interlocutor" }),
    replies = {
        { text = ccb.content.text("What were you saying before?"), next_topic = "TALK_NONE" },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
