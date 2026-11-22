local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_SHELTER_DENY_ADVICE",
    line = { when = predicates.handler("dlg_p_dda_8baf563d07a6"), yes = ccb.content.text("Focus on the road, mate!"), no = { when = predicates.handler("dlg_p_dda_11f4fe0cf4dc"), yes = ccb.content.text("I'm driving here!"), no = {
                when = predicates.handler("dlg_p_dda_7d19faa96245"),
                yes = ccb.content.text("I'm too thirsty, give me something to drink."),
                no = {
                    when = predicates.handler("dlg_p_dda_43c2f4328d3c"),
                    yes = ccb.content.text("I'm too hungry, give me something to eat."),
                    no = {
                        when = predicates.handler("dlg_p_dda_ea60ec832f23"),
                        yes = ccb.content.gendered_line("I'm too tired, let me rest first.", { "interlocutor" }),
                        no = {
                            when = predicates.has_effect("interlocutor", "asked_to_hint"),
                            yes = ccb.content.text("Nothing comes to my mind now.  Ask me later perhaps?"),
                            no = ccb.content.text("I have some reason for not telling you."),
                        },
                    },
                },
            } } },
    replies = {
        {
            text = ccb.content.text("Ah, okay."),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SUGGEST_FOLLOW",
    line = {
        when = predicates.has_effect("interlocutor", "infection"),
        yes = ccb.content.text("Not until I get some antibiotics…"),
        no = {
            when = predicates.has_effect("interlocutor", "asked_to_follow"),
            yes = ccb.content.gendered_line("You asked me recently; ask again later.", { "speaker" }),
            no = ccb.content.text("Why should I travel with you?"),
        },
    },
    replies = {
        {
            text = ccb.content.text("Understood.  I'll get those antibiotics."),
            next_topic = "TALK_NONE",
            when = predicates.has_effect("interlocutor", "infection"),
            switch = true,
        },
        {
            text = ccb.content.text("Right, right, I'll ask later."),
            next_topic = "TALK_NONE",
            when = predicates.has_effect("interlocutor", "asked_to_follow"),
            switch = true,
        },
        {
            text = ccb.content.text("I can keep you safe."),
            switch = true,
            default = true,
            trial = { kind = "persuade", difficulty = 20, modifiers = { { score = "FEAR", scale = 8 }, { score = "VALUE", scale = 2 }, { score = "TRUST", scale = 2 }, { score = "BRAVERY", scale = -2 }, { score = "LOWFUNC_PSYCHOPATH", scale = -10 }, { score = "HIGHFUNC_PSYCHOPATH", scale = 2 } } },
            success = { next_topic = "TALK_AGREE_FOLLOW", actions = { "follow", actions.handler("dlg_a_dda_22a5bb9a10f5") }, opinion = { trust = 1, value = 1 } },
            failure = { next_topic = "TALK_DENY_FOLLOW", actions = { "deny_follow" }, opinion = { value = -1, anger = 1 } },
        },
        {
            text = ccb.content.text("You can keep me safe."),
            switch = true,
            default = true,
            trial = { kind = "persuade", difficulty = 0, modifiers = { { score = "ALTRUISM", scale = 6 }, { score = "POS_FEAR", scale = -6 }, { score = "BRAVERY", scale = 2 }, { score = "ANGER", scale = -6 }, { score = "VALUE", scale = 2 }, { score = "LOWFUNC_PSYCHOPATH", scale = -10 }, { score = "HIGHFUNC_PSYCHOPATH", scale = 2 } } },
            success = { next_topic = "TALK_AGREE_FOLLOW", actions = { "follow", actions.handler("dlg_a_dda_22a5bb9a10f5") }, opinion = { value = -1 } },
            failure = { next_topic = "TALK_DENY_FOLLOW", actions = { "deny_follow" }, opinion = { value = -1, anger = 1 } },
        },
        {
            text = ccb.content.text("We're friends, aren't we?"),
            switch = true,
            default = true,
            trial = { kind = "persuade", difficulty = 0, modifiers = { { score = "TRUST", scale = 3 }, { score = "VALUE", scale = 3 }, { score = "ANGER", scale = -3 }, { score = "LOWFUNC_PSYCHOPATH", scale = -10 }, { score = "HIGHFUNC_PSYCHOPATH", scale = 2 } } },
            success = { next_topic = "TALK_AGREE_FOLLOW", actions = { "follow", actions.handler("dlg_a_dda_22a5bb9a10f5") }, opinion = { trust = 2, anger = -1 } },
            failure = { next_topic = "TALK_DENY_FOLLOW", actions = { "deny_follow" }, opinion = { value = -1, anger = 1 } },
        },
        {
            text = ccb.content.text("I'll kill you if you don't."),
            switch = true,
            default = true,
            trial = { kind = "intimidate", difficulty = 20, modifiers = { { score = "FEAR", scale = 8 }, { score = "VALUE", scale = 2 }, { score = "TRUST", scale = 2 }, { score = "BRAVERY", scale = -2 }, { score = "LOWFUNC_PSYCHOPATH", scale = 5 }, { score = "HIGHFUNC_PSYCHOPATH", scale = 2 } } },
            success = { next_topic = "TALK_AGREE_FOLLOW", actions = { "follow", actions.handler("dlg_a_dda_22a5bb9a10f5") }, opinion = { trust = -4, fear = 3, value = -1, anger = 4 } },
            failure = { next_topic = "TALK_DENY_FOLLOW", actions = { "deny_follow" }, opinion = { trust = -4, value = -5, anger = 20 } },
        },
        {
            text = ccb.content.text("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
            switch = true,
            default = true,
        },
    },
}
