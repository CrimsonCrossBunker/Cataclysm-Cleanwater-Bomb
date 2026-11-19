local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_JACK_RESTOCK",
    line = ccb.content.text("Around <restock_time_point>."),
    replies = { { text = ccb.content.text("Alright then, bye."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_JACK_TALK1",
    line = ccb.content.text("I live here with my wife, this is our family's land.  My daughter's family and son live down the road."),
    replies = {
        {
            text = ccb.content.text("Your whole family survived?"),
            next_topic = "TALK_ISHERWOOD_JACK2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_JACK_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_JACK2",
    line = ccb.content.text("We've had our losses… now we stay close to home, preparing for trouble.  We've always taken disaster preparedness seriously, but we didn't expect anything like this though."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_JACK_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_JACK_FARM",
    line = ccb.content.text("Even out here we've had some attacks and seen… other things.  We have been working on our defenses, but it takes time.  We've been able to keep up with the crops and animals though so we won't have to risk our necks for supplies."),
    replies = {
        {
            text = ccb.content.text("What sort of defenses do you want?"),
            next_topic = "TALK_FARM_DEFENSE",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_JACK_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
