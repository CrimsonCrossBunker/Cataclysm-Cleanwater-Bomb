local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "BGSS_LOST_PARTNER_1_STORY1",
    line = {
        choices = {
            {
                when = predicates.actor_state("interlocutor", "female"),
                yes = ccb.content.text("My husband made it out with me, but got eaten by one of those <freaking> plant monsters a few days before I met you.  This hasn't been a great year for me."),
                no = ccb.content.text("My wife made it out with me, but got eaten by one of those <freaking> plant monsters a few days before I met you.  This hasn't been a great year for me."),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("I'm sorry to hear it."),
            next_topic = "BGSS_LOST_PARTNER_1_STORY2",
        },
        {
            text = ccb.content.text("Tell me about those plant monsters."),
            next_topic = "BGSS_LOST_PARTNER_1_TRIFFIDS",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
