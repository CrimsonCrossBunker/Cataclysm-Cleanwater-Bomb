local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "BGSS_EVACUEE_1_STORY2",
    line = ccb.content.gendered_line("I spent a lot of time rummaging for rhubarb and bits of vegetables in the forest before I found the courage to start picking off some of those dead monsters.  I guess I was getting desperate.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("And that's it?  You spent months just living off the land?"),
            next_topic = "BGSS_EVACUEE_1_STORY3",
            when = predicates.negate(predicates.has_effect("interlocutor", "BGSS_EVACUEE_1_earlymeeting")),
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
