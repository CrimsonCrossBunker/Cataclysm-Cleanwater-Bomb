local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_STOLE_ITEM",
    line = ccb.content.text("You picked up something that does not belong to you…"),
    replies = {
        {
            text = ccb.content.text("Okay, okay, this is all a misunderstanding.  Sorry, I'll drop it now."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_9dc70a1dd705"),
            actions = { "drop_stolen_item" },
            opinion = { anger = 5 },
        },
        {
            text = ccb.content.text("No, I'm keeping it.  Try and take it off me, I dare you."),
            when = predicates.handler("dlg_p_dda_9dc70a1dd705"),
            trial = { kind = "intimidate", difficulty = 30, modifiers = { { score = "FEAR", scale = 8 }, { score = "VALUE", scale = 2 }, { score = "TRUST", scale = 2 }, { score = "BRAVERY", scale = -2 }, { score = "LOWFUNC_PSYCHOPATH", scale = 5 }, { score = "HIGHFUNC_PSYCHOPATH", scale = 1 } } },
            success = { next_topic = "TALK_KEEPING_ITEM", actions = { actions.handler("dlg_a_dda_bf9db73e0c3c") } },
            failure = { next_topic = "TALK_DONE", actions = { "hostile", actions.handler("dlg_a_dda_f10f6ee920dd") } },
        },
        {
            text = ccb.content.text("Look, I really need this.  Please let me have it."),
            when = predicates.handler("dlg_p_dda_9dc70a1dd705"),
            trial = { kind = "persuade", difficulty = 20, modifiers = { { score = "TRUST", scale = 3 }, { score = "VALUE", scale = 3 }, { score = "ANGER", scale = -3 }, { score = "LOWFUNC_PSYCHOPATH", scale = -5 }, { score = "HIGHFUNC_PSYCHOPATH", scale = 1 } } },
            success = { next_topic = "TALK_ALLOW_KEEP_ITEM", actions = { actions.handler("dlg_a_dda_e9283e68fc6a") } },
            failure = { next_topic = "TALK_DISALLOW_KEEP_ITEM", actions = { actions.handler("dlg_a_dda_2a428b0a450a") }, opinion = { trust = -3, anger = 2 } },
        },
        {
            text = ccb.content.text("What, this?  It's not the same one, you are mistaken."),
            when = predicates.handler("dlg_p_dda_9dc70a1dd705"),
            trial = { kind = "lie", difficulty = 25, modifiers = { { score = "TRUST", scale = 3 }, { score = "LOWFUNC_PSYCHOPATH", scale = -5 }, { score = "HIGHFUNC_PSYCHOPATH", scale = 1 } } },
            success = { next_topic = "TALK_DONE", actions = { "remove_stolen_status" } },
            failure = { next_topic = "TALK_DISALLOW_KEEP_ITEM", opinion = { trust = -3, value = -1, anger = 2 } },
        },
        {
            text = ccb.content.text("I'm sorry.  Look, I already dropped it, okay?"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_d89fcfbd2941"),
            actions = { "remove_stolen_status", actions.handler("dlg_a_dda_f3817b1673db") },
        },
    },
}
