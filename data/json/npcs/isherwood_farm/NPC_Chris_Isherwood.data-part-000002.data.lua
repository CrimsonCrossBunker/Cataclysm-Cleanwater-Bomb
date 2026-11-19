local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_WANTS",
    line = ccb.content.text("My family is convinced that if we stay here, we'll be able to weather this catastrophe.  Since technology has failed, they've doubled down on older traditions.  I think we need to get out there and find some answers before settling on a path."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CHRIS_THEORIES",
    line = ccb.content.text("In one of my longer trips looking for Barry, I saw something out in a field.  I didn't get close but I swear unbelievable monsters were coming out of it.  It kinda shimmered, almost like it wasn't quite there.  I've been tracking those monsters for a while…"),
    replies = {
        {
            text = ccb.content.text("What did you find?"),
            next_topic = "TALK_ISHERWOOD_CHRIS_MIGO_BASE",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CHRIS_THEORIES2",
    line = ccb.content.text("I doubt that, other monsters and zombies attacked them way too often"),
    replies = {
        {
            text = ccb.content.text("Let's talk about something else."),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        { text = ccb.content.text("I'd better get going."), next_topic = "TALK_DONE" },
    },
}
