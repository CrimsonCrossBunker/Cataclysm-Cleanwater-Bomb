local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "BGSS_EVACUEE_2_STORY1",
    line = ccb.content.gendered_line("Same as most people who didn't get killed straight up during the riots.  I went to one of those stupid <freaking> evacuation death traps.  I actually lived there for a while with three others.  One guy who I guess had watched a lot of movies kinda ran the show, because he seemed to really know what was going on.  Spoiler alert: he fucking didn't.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("What happened to your original crew?"),
            when = predicates.negate(predicates.has_effect("interlocutor", "player_BGSS_SAIDNO")),
            trial = {
                kind = "persuade",
                difficulty = 30,
                modifiers = { { score = "BRAVERY", scale = 1 }, { score = "TRUST", scale = 1 } },
            },
            success = { next_topic = "BGSS_EVACUEE_2_STORY2" },
            failure = { next_topic = "BGSS_EVACUEE_2_NOTYET" },
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
