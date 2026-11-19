local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_STORY2",
    line = ccb.content.gendered_line("Our conference was at a retreat by a lake.  We all got the emergency broadcast on our cells, but I was the only one to read between the lines and see it for what it was: large scale bio-terrorism.  I wasn't about to stay and find out who of my coworkers was a sleeper agent.  Although I'd bet fifty bucks it was Lee.  Anyway, I stole the coordinator's pickup and headed straight for my shelter.", { "interlocutor" }),
    replies = {
        { text = ccb.content.text("Did you get there?"), next_topic = "BGSS_PREPPER_1_STORY3" },
        { text = ccb.content.text("What about your shelter?"), next_topic = "BGSS_PREPPER_1_LMOE" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_STORY3",
    line = ccb.content.gendered_line("No, I barely got two miles.  I crashed into some kind of hell-spawn bio-weapon, a crazy screeching nightmarish thing made of arms and legs and heads from all sorts of creatures, humans too.  I think I killed it, but I know for sure I killed the truck.  Grabbed my duffel bag and ran, after putting a couple bullets into it for good measure.  I hope I never see something like that again.", { "interlocutor" }),
    replies = {
        { text = ccb.content.text("What about your shelter?"), next_topic = "BGSS_PREPPER_1_LMOE" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
