local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CLAIRE_RESTOCK",
    line = ccb.content.text("Around <restock_time_point>."),
    replies = { { text = ccb.content.text("Alright then, bye."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CLAIRE_TALK1",
    line = ccb.content.text("I live here with my husband, Jack.  He is working out in his shop."),
    replies = {
        {
            text = ccb.content.text("You are lucky to have your family still together."),
            next_topic = "TALK_ISHERWOOD_CLAIRE2",
        },
        {
            text = ccb.content.text("Must be nice, to have the quiet place amid so much madness."),
            next_topic = "TALK_CLAIRE_FARM",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CLAIRE2",
    line = ccb.content.text("You don't need as much luck if you are prepared and work together.  We've had our losses, my brother in law, Barry, was our best hunter but things are so different now…"),
    replies = {
        { text = ccb.content.text("What happened to Barry?"), next_topic = "TALK_BARRY" },
        {
            text = ccb.content.text("A farm must be a pretty safe place these days."),
            next_topic = "TALK_CLAIRE_FARM",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CLAIRE_TALK3",
    line = ccb.content.text("Well, nice to meet you.  I imagine Jack was boasting about my herbal remedies, he's proud of what we've put together here."),
    replies = {
        {
            text = ccb.content.text("He did mention you make remedies, are they effective?"),
            next_topic = "TALK_CLAIRE_MEDICINE",
        },
        {
            text = ccb.content.text("Must be nice, to have the quiet place amid so much madness."),
            next_topic = "TALK_CLAIRE_FARM",
        },
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
    id = "TALK_CLAIRE_MEDICINE",
    line = ccb.content.text("I have always studied and made some natural remedies, but now they are more essential than ever.  Who knows the next time we'll see a trained doctor.  These remedies aren't always as effective, but they can do the job in a pinch."),
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
