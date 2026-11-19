local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_CONVERSATION",
    line = ccb.content.text("What did you want to talk about?"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_nevermind>"),
            when = predicates.actor_state("interlocutor", "following"),
            next_topic = "TALK_FRIEND",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_nevermind>"),
            when = predicates.negate(predicates.actor_state("interlocutor", "following")),
            next_topic = "TALK_DONE",
        },
    },
}
