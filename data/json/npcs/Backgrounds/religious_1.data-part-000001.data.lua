local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "BGSS_RELIGIOUS_1_STORY2",
    line = ccb.content.text("Of course.  It's clear enough, isn't it?  That… that end, was the Rapture.  I'm still here, and I still don't understand why, but I will keep Jesus in my heart through the Tribulations to come.  When they're past, I'm sure He will welcome me into the Kingdom of Heaven.  Or… or something along those lines.  It's not going exactly like I thought it would, but that's prophecy for you."),
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
            text = ccb.content.text("What will you do, then?"),
            next_topic = "BGSS_RELIGIOUS_1_FAITH2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
