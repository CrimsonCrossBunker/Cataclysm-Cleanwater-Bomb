local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "BGSS_EVACUEE_3_STORY2",
    line = ccb.content.gendered_line("Sheer luck I guess.  I went the absolute wrong way, into town, and wound up stuck in the subway system.  I spent a few days living off vending machine food.  Not the best eating, but I pulled through.  At least there weren't so many zombies down there.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("What got you out of the subway?"),
            when = predicates.negate(predicates.has_effect("interlocutor", "BGSS_EVACUEE_3_earlymeeting")),
            next_topic = "BGSS_EVACUEE_3_STORY3_LATE",
        },
        {
            text = ccb.content.text("What got you out of the subway?"),
            when = predicates.has_effect("interlocutor", "BGSS_EVACUEE_3_earlymeeting"),
            next_topic = "BGSS_EVACUEE_3_STORY3_EARLY",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
