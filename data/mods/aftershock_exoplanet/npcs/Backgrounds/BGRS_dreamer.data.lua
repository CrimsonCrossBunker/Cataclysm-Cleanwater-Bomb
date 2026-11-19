local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGRS_Dreamer_STORY1",
    line = ccb.content.text("I just spent what felt like weeks in a dream that I was acting as a targeting computer for some kind of alien turret."),
    replies = {
        { text = ccb.content.text("Where are you from then?"), next_topic = "BGRS_Dreamer_STORY2" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGRS_Dreamer_STORY2",
    line = ccb.content.text("Now I'm in some kind of Mary Shelley nightmare?  I mean at least I have mobility."),
    replies = {
        {
            text = ccb.content.text("What does that have to do with anything?"),
            next_topic = "BGRS_Dreamer_STORY3",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGRS_Dreamer_STORY3",
    line = ccb.content.text("I'm going to keep going with this dream, hopefully soon I'll get to one where I can fly."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
