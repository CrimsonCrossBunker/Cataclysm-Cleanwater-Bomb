local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_STRANGER_AGGRESSIVE",
    line = { when = predicates.actor_state("speaker", "has_weapon"), yes = ccb.content.text("<drop_it>"), no = ccb.content.text("This is my territory, <name_b>.") },
    replies = {
        {
            text = ccb.content.text("[Drop weapon.]"),
            next_topic = "TALK_DEMAND_LEAVE",
            when = predicates.handler("dlg_p_dda_3985a08230de"),
            actions = { "player_weapon_drop" },
        },
        {
            text = ccb.content.text("Calm down.  I'm not going to hurt you."),
            trial = { kind = "persuade", difficulty = 30, modifiers = { { score = "BRAVERY", scale = 1 }, { score = "AGGRESSION", scale = -3 }, { score = "ALTRUISM", scale = 2 }, { score = "FEAR", scale = -2 }, { score = "TRUST", scale = 3 } } },
            success = { next_topic = "TALK_STRANGER_WARY", actions = { "stranger_neutral" }, opinion = { trust = 1, fear = -1 } },
            failure = { next_topic = "TALK_DONE", actions = { "hostile" } },
        },
        {
            text = ccb.content.text("Screw you, no."),
            trial = { kind = "intimidate", difficulty = 25, modifiers = { { score = "BRAVERY", scale = 1 }, { score = "AGGRESSION", scale = -3 }, { score = "ALTRUISM", scale = 2 }, { score = "FEAR", scale = -2 }, { score = "TRUST", scale = 3 } } },
            success = { next_topic = "TALK_STRANGER_SCARED", actions = { "stranger_neutral" }, opinion = { trust = -2, fear = 1, anger = 1 } },
            failure = { next_topic = "TALK_DONE", actions = { "hostile" } },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MUG",
    line = { when = predicates.actor_state("speaker", "has_weapon"), yes = ccb.content.text("<drop_it>"), no = ccb.content.text("<hands_up>") },
    replies = {
        {
            text = ccb.content.text("Calm down.  I'm not going to hurt you."),
            trial = { kind = "persuade", difficulty = 35, modifiers = { { score = "BRAVERY", scale = 1 }, { score = "AGGRESSION", scale = -3 }, { score = "ALTRUISM", scale = 2 }, { score = "FEAR", scale = -2 }, { score = "TRUST", scale = 3 } } },
            success = { next_topic = "TALK_STRANGER_WARY", actions = { "stranger_neutral" }, opinion = { trust = 1, fear = -1 } },
            failure = { next_topic = "TALK_DONE", actions = { "hostile" } },
        },
        {
            text = ccb.content.text("Screw you, no."),
            trial = { kind = "intimidate", difficulty = 30, modifiers = { { score = "BRAVERY", scale = 1 }, { score = "AGGRESSION", scale = -3 }, { score = "ALTRUISM", scale = 2 }, { score = "FEAR", scale = -2 }, { score = "TRUST", scale = 3 } } },
            success = { next_topic = "TALK_STRANGER_SCARED", actions = { "stranger_neutral" }, opinion = { trust = -2, fear = 1, anger = 1 } },
            failure = { next_topic = "TALK_DONE", actions = { "hostile" } },
        },
        {
            text = ccb.content.text("[Drop weapon.]"),
            next_topic = "TALK_MUG",
            when = predicates.handler("dlg_p_dda_3985a08230de"),
            actions = { "player_weapon_drop" },
        },
        {
            text = ccb.content.text("[Put hands up.]"),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.actor_state("speaker", "has_weapon")),
            actions = { "start_mugging" },
        },
    },
}
