local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_THAWED_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_thawed_thawed_has_talked" } }),
        yes = ccb.content.text("Anymore bad news?"),
        no = ccb.content.text("What year is it?  How long have I been asleep?"),
    },
    on_enter = {
        {
            actions = { actions.set_actor_value("interlocutor", "dialogue_thawed_thawed_has_talked", "yes") },
        },
    },
    replies = {
        {
            switch = true,
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_thawed_thawed_has_talked" } }),
            text = ccb.content.text("Hey.  Let's chat for a second."),
            next_topic = "TALK_STRANGER_NEUTRAL",
        },
        {
            switch = true,
            default = true,
            text = ccb.content.text("I thawed you out of that pod.  Listen, I could use your help…"),
            trial = { kind = "persuade", difficulty = 0 },
            success = { next_topic = "TALK_THAWED_FRIENDLY", opinion = { trust = 1, value = 1 } },
            failure = { next_topic = "TALK_THAWED_WARY", opinion = { anger = 1, fear = 1 } },
        },
        {
            switch = true,
            default = true,
            text = ccb.content.text("If you won't help me, I am going to hurt you."),
            trial = {
                kind = "intimidate",
                difficulty = 20,
                modifiers = { { score = "AGGRESSION", scale = -2 }, { score = "BRAVERY", scale = -2 } },
            },
            success = {
                next_topic = "TALK_THAWED_FEARFUL",
                opinion = { trust = -4, fear = 3, value = -1, anger = 4 },
            },
            failure = {
                next_topic = "TALK_THAWED_BREAKDOWN",
                opinion = { trust = -4, value = -5, anger = 10 },
            },
        },
        {
            switch = true,
            default = true,
            text = ccb.content.text("Sorry, no need to get angry.  I'll get out of your way."),
            next_topic = "TALK_DONE",
        },
    },
}
