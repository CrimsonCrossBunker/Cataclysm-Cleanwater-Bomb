local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_LAND",
    line = ccb.content.text("Well, wildlife is more hostile and I've seen gigantic insects around, never mind all these monsters.  I've also found mysterious dead spots and mutated vegetation.  I don't think staying on a farm is sustainable forever, there are big planet wide changes occurring."),
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
    id = "TALK_LEAVE_NOW_MARSHAL_CHRIS",
    line = ccb.content.text("You should leave before my family sees you."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}
