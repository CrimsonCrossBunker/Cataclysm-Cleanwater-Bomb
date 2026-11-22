local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_STRANGER_SCARED",
    replies = {
        {
            text = ccb.content.text("[Mood Stablization Check] I'm not going to hurt you."),
            when = predicates.handler("dlg_p_mindovermatter_36a04c7d320b"),
            trial = { kind = "condition", when = predicates.handler("dlg_p_mindovermatter_695b06c33141") },
            success = { next_topic = "TALK_STRANGER_NEUTRAL", actions = { "stranger_neutral" }, opinion = { trust = 3, fear = -1 } },
            failure = { next_topic = "TALK_DONE", actions = { "flee", actions.handler("dlg_a_mindovermatter_67f27142b7a4") } },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_STRANGER_WARY",
    replies = {
        {
            text = ccb.content.text("[Mood Stablization Check] I'm not going to hurt you."),
            when = predicates.handler("dlg_p_mindovermatter_36a04c7d320b"),
            trial = { kind = "condition", when = predicates.handler("dlg_p_mindovermatter_695b06c33141") },
            success = { next_topic = "TALK_STRANGER_NEUTRAL", actions = { "stranger_neutral" }, opinion = { trust = 3, fear = -1 } },
            failure = { next_topic = "TALK_DONE", actions = { "flee", actions.handler("dlg_a_mindovermatter_67f27142b7a4") } },
        },
    },
}
