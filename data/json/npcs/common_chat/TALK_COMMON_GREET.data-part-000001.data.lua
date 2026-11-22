local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = { "TALK_STRANGER_SCARED", "TALK_STRANGER_WARY" },
    replies = {
        {
            text = ccb.content.text("[Put away weapon.]"),
            next_topic = "TALK_STRANGER_NEUTRAL",
            when = predicates.handler("dlg_p_dda_41e985c27ed5"),
            actions = { "player_weapon_away" },
            opinion = { trust = 2, fear = -2 },
        },
        {
            text = ccb.content.text("[Drop weapon.]"),
            next_topic = "TALK_STRANGER_NEUTRAL",
            when = predicates.handler("dlg_p_dda_3985a08230de"),
            actions = { "player_weapon_drop" },
            opinion = { trust = 4, fear = -3 },
        },
        {
            text = ccb.content.text("Don't worry, I'm not going to hurt you."),
            trial = { kind = "persuade", difficulty = 50, modifiers = { { score = "BRAVERY", scale = 2 }, { score = "FEAR", scale = -2 }, { score = "TRUST", scale = 2 } } },
            success = { next_topic = "TALK_STRANGER_NEUTRAL", actions = { "stranger_neutral" }, opinion = { trust = 1, fear = -1 } },
            failure = { next_topic = "TALK_DONE", actions = { "flee" } },
        },
    },
}
