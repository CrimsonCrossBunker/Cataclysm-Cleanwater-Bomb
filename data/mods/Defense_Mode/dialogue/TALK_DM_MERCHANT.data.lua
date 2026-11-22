local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_DM_MERCHANT",
    line = ccb.content.text("Nice to see you again.  Would you like to buy something, hire someone, or somethin' else?"),
    replies = {
        {
            text = ccb.content.text("I'll buy something."),
            next_topic = "TALK_DM_MERCHANT_2",
            when = predicates.handler("w16b_p_defense_mode_7701335cfe5a"),
            actions = { actions.handler("w16b_a_defense_mode_93e67421ae14"), "start_trade" },
        },
        {
            text = ccb.content.text("What'll it cost me to get some help around here?"),
            next_topic = "TALK_DM_MERCHANT_HIRE_COST",
        },
        {
            text = ccb.content.text("I'd like to hire some help."),
            next_topic = "TALK_DM_MERCHANT_2",
            actions = { actions.handler("w16b_a_defense_mode_e7361c1a4278") },
        },
        {
            text = ccb.content.text("Nevermind, I don't want anything."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_DM_MERCHANT_HIRE_COST",
    line = ccb.content.text("It's usually $500.  You can pay me up front in either goods or money, then we'll talk."),
    replies = {
        {
            text = ccb.content.text("I'll buy something."),
            next_topic = "TALK_DM_MERCHANT_2",
            when = predicates.handler("w16b_p_defense_mode_7701335cfe5a"),
            actions = { actions.handler("w16b_a_defense_mode_93e67421ae14"), "start_trade" },
        },
        {
            text = ccb.content.text("I'd like to hire some help."),
            next_topic = "TALK_DM_MERCHANT_2",
            actions = { actions.handler("w16b_a_defense_mode_d4141f5f8a77") },
        },
        {
            text = ccb.content.text("Nevermind, I don't want anything."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_DM_MERCHANT_2",
    line = ccb.content.text("Anything else I can do for you?"),
    replies = {
        {
            text = ccb.content.text("I'll buy something."),
            next_topic = "TALK_DM_MERCHANT_2",
            when = predicates.handler("w16b_p_defense_mode_7701335cfe5a"),
            actions = { actions.handler("w16b_a_defense_mode_93e67421ae14"), "start_trade" },
        },
        {
            text = ccb.content.text("What'll it cost me to get some help around here?"),
            next_topic = "TALK_DM_MERCHANT_HIRE_COST",
        },
        {
            text = ccb.content.text("I'd like to hire some help."),
            next_topic = "TALK_DM_MERCHANT_2",
            actions = { actions.handler("w16b_a_defense_mode_6c98740d08ea") },
        },
        {
            text = ccb.content.text("Nevermind, I don't want anything."),
            next_topic = "TALK_DONE",
        },
    },
}
