local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_CYBORG_Abomination_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_cyborg_abomination_cyborg_abomination_has_talked" } }),
        yes = ccb.content.text("Hey again.  *kzzz*"),
        no = ccb.content.text("I… can move again.  I have a real body!  Is this a body?"),
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_cyborg_abomination_cyborg_abomination_has_talked", "yes"),
            },
        },
    },
    replies = {
        {
            switch = true,
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_cyborg_abomination_cyborg_abomination_has_talked" } }),
            text = ccb.content.text("So you must have seen some weird stuff?"),
            next_topic = "TALK_STRANGER_NEUTRAL",
        },
        {
            switch = true,
            default = true,
            text = ccb.content.text("I built this body and rescued you…"),
            trial = { kind = "persuade", difficulty = 0 },
            success = { next_topic = "TALK_CYBORG_ABOMINATION_FRIENDLY", opinion = { trust = 1, value = 1 } },
            failure = { next_topic = "TALK_CYBORG_ABOMINATION_WARY", opinion = { anger = 1, fear = 1 } },
        },
        {
            switch = true,
            default = true,
            text = ccb.content.text("I can put you back in the pieces I found you in."),
            trial = {
                kind = "intimidate",
                difficulty = 20,
                modifiers = { { score = "AGGRESSION", scale = -2 }, { score = "BRAVERY", scale = -2 } },
            },
            success = {
                next_topic = "TALK_CYBORG_ABOMINATION_FEARFUL",
                opinion = { trust = -4, fear = 3, value = -1, anger = 4 },
            },
            failure = {
                next_topic = "TALK_CYBORG_ABOMINATION_BREAKDOWN",
                opinion = { trust = -4, value = -5, anger = 10 },
            },
        },
        {
            switch = true,
            default = true,
            text = ccb.content.text("No one deserves the hell you've been through.  I hope you find peace."),
            next_topic = "TALK_DONE",
        },
    },
}
