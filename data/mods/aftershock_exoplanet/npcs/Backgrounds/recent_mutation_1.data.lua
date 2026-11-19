local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_RECENT_MUTATION_1_STORY1",
    line = ccb.content.text("Things were good.  I had a good job working for a zaibatsu.  I was respected, and had people working for me.  I mostly ignored the changes that were happening in the city, they were beneath me."),
    replies = {
        {
            text = ccb.content.text("So, what happened?"),
            next_topic = "BGSS_RECENT_MUTATION_1_STORY2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_RECENT_MUTATION_1_STORY2",
    line = ccb.content.text("Slowly fewer and fewer of the cubicle drones came into the office.  Security notices piled up about routes through the city to avoid.  Finally, one day I came in and you could hear the riots coming closer and some kind of animalistic roars, gigantic animals."),
    replies = {
        {
            text = ccb.content.text("So, what happened?"),
            next_topic = "BGSS_RECENT_MUTATION_1_STORY3",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_RECENT_MUTATION_1_STORY3",
    line = ccb.content.text("That last day security and scientists came up from the underground lab and rounded up all the remaining staff.  One of them said that this was the only chance any of us had of surviving.  They started injecting people at gunpoint."),
    replies = {
        {
            text = ccb.content.text("So, did you evacuate?"),
            next_topic = "BGSS_RECENT_MUTATION_1_STORY3",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
