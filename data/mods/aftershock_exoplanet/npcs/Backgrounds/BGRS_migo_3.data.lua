local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGRS_MIGO_3_STORY1",
    line = ccb.content.text("I worked in a top secret lab.  Things kept getting crazier and crazier outside and the scientists inside started making desperate experiments.  They worked on something called interdimensional portals."),
    replies = {
        { text = ccb.content.text("Where are you from?"), next_topic = "BGRS_MIGO_3_STORY2" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGRS_MIGO_3_STORY2",
    line = ccb.content.text("The eggheads kept saying we needed to find a way out of here before everything went sideways.  So we needed to open more portals even if we hadn't had time to take all the precautions."),
    replies = {
        { text = ccb.content.text("What happened next?"), next_topic = "BGRS_MIGO_3_STORY3" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGRS_MIGO_2_STORY3",
    line = ccb.content.text("One day they opened a portal trying to find an earthlike planet and suddenly portals were opening all over the lab and these fast and dangerous aliens overwhelmed the lab.  They killed most of the staff and took the rest prisoner."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
