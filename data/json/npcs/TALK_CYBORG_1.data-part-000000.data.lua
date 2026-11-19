local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_CYBORG_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_cyborg_cyborg_has_talked" } }),
        yes = ccb.content.text("Hey again.  *kzzz*"),
        no = ccb.content.gendered_line("I… I'm free.  *Zzzt* I'm actually free!  *bzzz* Look, you're the first person I've seen in a long time.", { "interlocutor" }),
    },
    on_enter = {
        {
            actions = { actions.set_actor_value("interlocutor", "dialogue_cyborg_cyborg_has_talked", "yes") },
        },
    },
    replies = {
        {
            switch = true,
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_cyborg_cyborg_has_talked" } }),
            text = ccb.content.text("Hey.  Let's chat for a second."),
            next_topic = "TALK_STRANGER_NEUTRAL",
        },
        {
            switch = true,
            default = true,
            text = ccb.content.text("That's because I saved you.  Listen, I could use your help…"),
            trial = { kind = "persuade", difficulty = 0 },
            success = { next_topic = "TALK_CYBORG_FRIENDLY", opinion = { trust = 1, value = 1 } },
            failure = { next_topic = "TALK_CYBORG_WARY", opinion = { anger = 1, fear = 1 } },
        },
        {
            switch = true,
            default = true,
            text = ccb.content.text("Big fucking deal.  Do what I say or I'll shove that chip back where it belongs."),
            trial = {
                kind = "intimidate",
                difficulty = 20,
                modifiers = { { score = "AGGRESSION", scale = -2 }, { score = "BRAVERY", scale = -2 } },
            },
            success = {
                next_topic = "TALK_CYBORG_FEARFUL",
                opinion = { trust = -4, fear = 3, value = -1, anger = 4 },
            },
            failure = {
                next_topic = "TALK_CYBORG_BREAKDOWN",
                opinion = { trust = -4, value = -5, anger = 10 },
            },
        },
        {
            switch = true,
            default = true,
            text = ccb.content.text("Sorry, I'm nobody.  Enjoy your freedom, I guess."),
            next_topic = "TALK_DONE",
        },
    },
}
