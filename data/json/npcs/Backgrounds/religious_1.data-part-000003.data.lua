local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "BGSS_RELIGIOUS_1_FAITH2",
    line = ccb.content.text("I will keep the faith, and keep praying, and strike down the agents of Hell where I see them.  That's all we few can do, isn't it?  I suppose perhaps we're the meek that shall inherit the Earth.  Although I don't love our odds."),
    replies = {
        {
            text = ccb.content.text("What if you're wrong?"),
            next_topic = "BGSS_RELIGIOUS_1_FAITH1",
            when = predicates.negate(predicates.has_effect("interlocutor", "player_rude_BGSS_RELIGIOUS_1_FAITH1")),
            actions = {
                actions.add_effect("interlocutor", "player_rude_BGSS_RELIGIOUS_1_FAITH1", { permanent = true }),
            },
            opinion = { value = -1 },
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
