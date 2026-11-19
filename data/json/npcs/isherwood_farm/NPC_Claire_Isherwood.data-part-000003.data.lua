local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_CLAIRE_FARM",
    line = ccb.content.text("We've always tried to live a quiet life out here, I suppose we are doing better than most."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CLAIRE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CLAIRE_HUSBAND",
    line = ccb.content.text("Jack and I have been together for 40 years.  He's been my anchor through all of this chaos."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CLAIRE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CLAIRE_DAUGHTER",
    line = ccb.content.text("Jesse and her family live up at the horse farm.  They may have some jobs for you."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CLAIRE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CLAIRE_BROTHER",
    line = ccb.content.text("Eddie's dairy is at the end of the road.  He's may have some jobs for you if you are interested."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CLAIRE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LEAVE_NOW_MARSHAL_CLAIRE",
    line = ccb.content.text("You should get off our land, you have no business here."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CLAIRE_TOPICS",
    line = ccb.content.text("Ask away."),
    replies = {
        {
            text = ccb.content.text("Tell me about your husband, is he around?"),
            next_topic = "TALK_CLAIRE_HUSBAND",
        },
        {
            text = ccb.content.text("Your daughter lives down the road?"),
            next_topic = "TALK_CLAIRE_DAUGHTER",
        },
        {
            text = ccb.content.text("Where is your brother's place?"),
            next_topic = "TALK_CLAIRE_BROTHER",
        },
        {
            text = ccb.content.text("A farm must be a pretty safe place these days."),
            next_topic = "TALK_CLAIRE_FARM",
        },
        {
            text = ccb.content.text("You are lucky to have your family still together."),
            next_topic = "TALK_ISHERWOOD_CLAIRE2",
        },
        {
            text = ccb.content.text("Let's trade."),
            native_actions = { "start_trade" },
            next_topic = "TALK_ISHERWOOD_CLAIRE",
        },
        { text = ccb.content.text("Can I do anything for you?"), next_topic = "TALK_MISSION_LIST" },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
