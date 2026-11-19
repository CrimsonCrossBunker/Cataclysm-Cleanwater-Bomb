local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_STORY1",
    line = ccb.content.text("Ooooh, boy.  I was ready for this.  The winds were blowing this way for years.  I had a fully stocked shelter set up.  So, of course, just my luck: I was miles from home when attack hit and the world ended."),
    replies = {
        { text = ccb.content.text("What happened to you?"), next_topic = "BGSS_PREPPER_1_STORY2" },
        { text = ccb.content.text("What about your shelter?"), next_topic = "BGSS_PREPPER_1_LMOE" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_STORY2",
    line = ccb.content.text("I was in this beautiful valley by a lake with a lot of other people.  We got word that something bad was happening, but I was the only one to read between the lines and see it for what it was: large scale war.  I wasn't about to stay and find out who among us was a sleeper agent.  Although I'd bet it was Lee.  Anyway, I stole away and headed straight for my shelter."),
    replies = {
        { text = ccb.content.text("Did you get there?"), next_topic = "BGSS_PREPPER_1_STORY3" },
        { text = ccb.content.text("What about your shelter?"), next_topic = "BGSS_PREPPER_1_LMOE" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_STORY3",
    line = ccb.content.text("No, I barely got two miles.  I ran into some kind of hell-spawn bio-weapon, a crazy screeching nightmarish thing made of arms and legs and heads from all sorts of creatures, humans too.  I think I killed it.  Grabbed my stuff and ran, after putting a couple bullets into it.  I hope I never see something like that again."),
    replies = {
        { text = ccb.content.text("What about your shelter?"), next_topic = "BGSS_PREPPER_1_LMOE" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
