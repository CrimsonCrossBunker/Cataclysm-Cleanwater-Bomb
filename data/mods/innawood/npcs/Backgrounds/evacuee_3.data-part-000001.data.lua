local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "BGSS_EVACUEE_3_STORY2",
    line = ccb.content.text("Sheer luck I guess.  I got lost in the woods and lived off of whatever nuts and berries I found.  Not as many things are poisonous as I thought."),
    replies = {
        {
            text = ccb.content.text("What got you out of the woods?"),
            when = predicates.negate(predicates.has_effect("interlocutor", "BGSS_EVACUEE_3_earlymeeting")),
            next_topic = "BGSS_EVACUEE_3_STORY3_LATE",
        },
        {
            text = ccb.content.text("What got you out of the woods?"),
            when = predicates.has_effect("interlocutor", "BGSS_EVACUEE_3_earlymeeting"),
            next_topic = "BGSS_EVACUEE_3_STORY3_EARLY",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
