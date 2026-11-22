local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_SHARE_EQUIPMENT",
    line = {
        when = predicates.has_effect("interlocutor", "asked_for_item"),
        yes = ccb.content.gendered_line("You just asked me for stuff; ask later.", { "speaker" }),
        no = ccb.content.text("Why should I share my equipment with you?"),
    },
    replies = {
        {
            text = ccb.content.text("Okay, fine."),
            next_topic = "TALK_NONE",
            when = predicates.has_effect("interlocutor", "asked_for_item"),
            switch = true,
        },
        {
            text = ccb.content.text("Because I'm holding a thermal detonator!"),
            next_topic = "TALK_GIVE_EQUIPMENT",
            when = predicates.has_item("speaker", "mininuke"),
            actions = { actions.give_equipment({ { score = "TRUST", scale = 1 }, { score = "VALUE", scale = 3 }, { score = "ALTRUISM", scale = 2 }, { score = "TOTAL", scale = 300 } }) },
            opinion = { trust = -6, fear = 5, value = -1, anger = 5 },
            switch = true,
            default = true,
        },
        {
            text = ccb.content.text("Because I'm your friend!"),
            switch = true,
            default = true,
            trial = { kind = "persuade", difficulty = 10, modifiers = { { score = "TRUST", scale = 1 }, { score = "VALUE", scale = 3 }, { score = "ALTRUISM", scale = 2 }, { score = "LOWFUNC_PSYCHOPATH", scale = -2 }, { score = "HIGHFUNC_PSYCHOPATH", scale = 1 } } },
            success = { next_topic = "TALK_GIVE_EQUIPMENT", actions = { actions.give_equipment({ { score = "TRUST", scale = 1 }, { score = "VALUE", scale = 3 }, { score = "ALTRUISM", scale = 2 }, { score = "TOTAL", scale = 300 } }) }, opinion = { value = -1 } },
            failure = { next_topic = "TALK_DENY_EQUIPMENT", opinion = { value = -1, anger = 2 } },
        },
        {
            text = ccb.content.text("Well, I am helping you out…"),
            when = predicates.any({ predicates.assigned_missions(1, 1), predicates.assigned_missions(2) }),
            switch = true,
            default = true,
            trial = { kind = "persuade", difficulty = 12, modifiers = { { score = "TRUST", scale = 1 }, { score = "VALUE", scale = 2 }, { score = "ALTRUISM", scale = 1 }, { score = "MISSIONS", scale = 1 }, { score = "LOWFUNC_PSYCHOPATH", scale = -2 }, { score = "HIGHFUNC_PSYCHOPATH", scale = 1 } } },
            success = { next_topic = "TALK_GIVE_EQUIPMENT", actions = { "give_equipment" } },
            failure = { next_topic = "TALK_DENY_EQUIPMENT", opinion = { value = -1, anger = 2 } },
        },
        {
            text = ccb.content.text("I'll give it back!"),
            switch = true,
            default = true,
            trial = { kind = "lie", difficulty = 0, modifiers = { { score = "TRUST", scale = 2 }, { score = "VALUE", scale = 5 }, { score = "ALTRUISM", scale = 3 }, { score = "LOWFUNC_PSYCHOPATH", scale = -2 }, { score = "HIGHFUNC_PSYCHOPATH", scale = 1 } } },
            success = { next_topic = "TALK_GIVE_EQUIPMENT", actions = { actions.give_equipment({ { score = "TRUST", scale = 1 }, { score = "VALUE", scale = 3 }, { score = "ALTRUISM", scale = 2 }, { score = "TOTAL", scale = 300 } }) }, opinion = { value = -1 } },
            failure = { next_topic = "TALK_DENY_EQUIPMENT", opinion = { trust = -1, value = -1, anger = 2 } },
        },
        {
            text = ccb.content.text("Give it to me, or else!"),
            switch = true,
            default = true,
            trial = { kind = "intimidate", difficulty = 40 },
            success = { next_topic = "TALK_GIVE_EQUIPMENT", actions = { actions.give_equipment({ { score = "U_INTIMIDATE", scale = 1 }, { score = "NPC_INTIMIDATE", scale = -1 }, { score = "FEAR", scale = 1 }, { score = "BRAVERY", scale = -1 }, { score = "TOTAL", scale = 500 } }) }, opinion = { trust = -3, fear = 2, value = -2, anger = 3 } },
            failure = { next_topic = "TALK_DENY_EQUIPMENT", opinion = { trust = -3, fear = 1, value = -3, anger = 5 } },
        },
        {
            text = ccb.content.text("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
            when = predicates.has_effect("interlocutor", "asked_for_item"),
            switch = true,
            default = true,
        },
        {
            text = ccb.content.text("Never mind, I'll do without.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
