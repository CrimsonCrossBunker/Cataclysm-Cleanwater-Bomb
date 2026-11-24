local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc_class {
    id = "CRYO_HACKER",
    name = ccb.content.text("Thawed Hacker"),
    job_description = ccb.content.text("I'm looking for some choice systems to hack."),
    traits = {
        { group = "BG_survival_story_TEENAGER" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "AFS_CRYOADAPTATION" },
    },
    strength = { rng = { -4, 0 } },
    dexterity = { rng = { -2, 0 } },
    intelligence = { rng = { 1, 5 } },
    perception = { rng = { -2, 0 } },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { -1, -2 } } } } } },
        },
        { skill = "electronics", bonus = { rng = { 1, 4 } } },
        { skill = "computer", bonus = { rng = { 3, 6 } } },
    },
}

ccb.content.define_npc_class {
    id = "CRYO_DOCTOR",
    name = ccb.content.text("Thawed Doctor"),
    job_description = ccb.content.text("I'm looking for wounded to help."),
    traits = {
        { group = "BG_survival_story_MEDICAL" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "AFS_CRYOADAPTATION" },
        { trait = "PROF_MED" },
    },
    strength = { rng = { -2, 0 } },
    intelligence = { rng = { 0, 2 } },
    perception = { one_in = 4 },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 3, 2 } }, { rng = { -1, -3 } } } } } },
        },
        { skill = "firstaid", bonus = { rng = { 2, 6 } } },
    },
}

ccb.content.define_npc_class {
    id = "CRYO_SCIENTIST",
    name = ccb.content.text("Thawed Scientist"),
    job_description = ccb.content.text("I'm looking for clues concerning these monsters' origins…"),
    traits = {
        { group = "BG_survival_story_LAB" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "AFS_CRYOADAPTATION" },
    },
    strength = { rng = { -1, -3 } },
    dexterity = { rng = { -1, 0 } },
    intelligence = { rng = { 2, 5 } },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -4 } } } } },
        },
        { skill = "computer", bonus = { rng = { 1, 5 } } },
        { skill = "electronics", bonus = { rng = { 1, 5 } } },
        { skill = "firstaid", bonus = { rng = { 1, 4 } } },
    },
}

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

ccb.content.define_dialogue_topic {
    id = "TALK_THAWED_FRIENDLY",
    line = ccb.content.text("So what happens now?"),
    replies = {
        {
            text = ccb.content.text("Come with me.  We can help each other out."),
            trial = { kind = "persuade", difficulty = 0, modifiers = { { score = "value", scale = 2 } } },
            success = {
                next_topic = "TALK_AGREE_FOLLOW",
                native_actions = { "follow" },
                opinion = { trust = 1, value = 1 },
            },
            failure = {
                next_topic = "TALK_DENY_FOLLOW",
                native_actions = { "deny_follow" },
                opinion = { trust = -1, fear = 1 },
            },
        },
        {
            text = ccb.content.text("We both go our separate ways.  Enjoy your freedom."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_THAWED_WARY",
    line = ccb.content.text("Why didn't you leave me frozen until things were better?"),
    replies = {
        {
            text = ccb.content.text("If I didn't thaw you out now, you'd have died in that pod."),
            trial = {
                kind = "persuade",
                difficulty = 5,
                modifiers = { { score = "TRUST", scale = 2 }, { score = "VALUE", scale = 2 } },
            },
            success = { next_topic = "TALK_THAWED_FRIENDLY", opinion = { trust = 1, value = 1 } },
            failure = { next_topic = "TALK_THAWED_LEAVES" },
        },
        {
            text = ccb.content.text("I'm being nice for now.  You'd better hope that it lasts."),
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
        { text = ccb.content.text("Forget it.  Enjoy your freedom."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_THAWED_FEARFUL",
    line = ccb.content.text("I'm sorry, what can I do to help you?"),
    replies = {
        {
            text = ccb.content.text("Follow me and do my bidding, then."),
            trial = {
                kind = "intimidate",
                difficulty = 20,
                modifiers = {
                    { score = "FEAR", scale = 8 },
                    { score = "VALUE", scale = 2 },
                    { score = "TRUST", scale = 2 },
                    { score = "BRAVERY", scale = -2 },
                },
            },
            success = {
                next_topic = "TALK_AGREE_FOLLOW",
                native_actions = { "follow" },
                opinion = { trust = -4, fear = 3, value = -1, anger = 4 },
            },
            failure = {
                next_topic = "TALK_THAWED_BREAKDOWN",
                opinion = { trust = 4, value = -5, anger = 10 },
            },
        },
        {
            text = ccb.content.text("Get out of my sight."),
            next_topic = "TALK_DONE",
            native_actions = { "flee" },
            opinion = { trust = -1, fear = -2, anger = -2 },
        },
        {
            text = ccb.content.text("No, *I'm* sorry, I didn't mean that.  Go do what you want."),
            trial = { kind = "persuade", difficulty = 10 },
            success = { next_topic = "TALK_DONE", opinion = { trust = 1, value = 1, anger = -1 } },
            failure = {
                next_topic = "TALK_THAWED_BREAKDOWN",
                opinion = { trust = 4, value = -5, anger = 10 },
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_THAWED_BREAKDOWN",
    line = ccb.content.text("How dare you threaten me!"),
    replies = {
        {
            text = ccb.content.text("Run while you still can!"),
            trial = {
                kind = "intimidate",
                difficulty = 20,
                modifiers = {
                    { score = "FEAR", scale = 8 },
                    { score = "VALUE", scale = 2 },
                    { score = "TRUST", scale = 2 },
                    { score = "BRAVERY", scale = -2 },
                },
            },
            success = { next_topic = "TALK_DONE", native_actions = { "flee" } },
            failure = { next_topic = "TALK_DONE", native_actions = { "hostile" } },
        },
        {
            text = ccb.content.text("Not if I kill you first!"),
            next_topic = "TALK_DONE",
            native_actions = { "hostile" },
        },
        {
            text = ccb.content.text("I'm sorry!  I shouldn't have said that!"),
            trial = { kind = "persuade", difficulty = 30 },
            success = { next_topic = "TALK_DONE", opinion = { trust = 1, value = 1, anger = -1 } },
            failure = { next_topic = "TALK_DONE", native_actions = { "hostile" } },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_THAWED_LEAVES",
    line = ccb.content.text("Go freeze yourself.  Bye."),
    replies = { { text = ccb.content.text("Suit yourself."), next_topic = "TALK_DONE" } },
}
