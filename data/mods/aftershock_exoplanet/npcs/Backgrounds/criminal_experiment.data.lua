local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_CRIMINAL_EXPERIMENT_STORY1",
    line = ccb.content.text("I underwent experimental treatments paid for by the cartels to become a more fearsome enforcer."),
    replies = {
        {
            text = ccb.content.text("Where are you from?"),
            next_topic = "BGSS_CRIMINAL_EXPERIMENT_STORY2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_CRIMINAL_EXPERIMENT_STORY2",
    line = ccb.content.text("Half of the guys I underwent gene therapy with died, but hey if I had to guess 90 percent of everyone is dead now?"),
    replies = {
        { text = ccb.content.text("Tell me more?"), next_topic = "BGSS_CRIMINAL_EXPERIMENT_STORY3" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_CRIMINAL_EXPERIMENT_STORY3",
    line = ccb.content.text("Only the insane will prosper."),
    replies = {
        {
            text = ccb.content.text("How did it end?"),
            next_topic = "BGSS_CRIMINAL_EXPERIMENT_STORY3",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
