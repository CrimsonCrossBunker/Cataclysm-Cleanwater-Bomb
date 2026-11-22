local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_MEET_REWARD_NEGOTIATE_WEAK_1",
    line = ccb.content.text("W-Wait no, n- no, I- I'll give you all I have.  All I request to keep is some food, a gun, and a bullet for if things get bad."),
    on_enter = {
        { once = "first_negotiations_solar_balthazar", actions = { actions.handler("dlg_a_dda_ad980b24ebca") } },
    },
    replies = {
        {
            text = ccb.content.text("You're locked in there, right?  How would I get them?"),
            next_topic = "TALK_BALTHAZAR_MEET_REWARD_EXCUSE_WEAK",
        },
        {
            text = ccb.content.text("How about a little more, huh?"),
            next_topic = "TALK_BALTHAZAR_MEET_REWARD_NEGOTIATE_WEAK_2",
        },
        {
            text = ccb.content.text("That's better."),
            next_topic = "TALK_BALTHAZAR_MEET_DESCRIPTION_WEAK",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_MEET_REWARD_NEGOTIATE_WEAK_2",
    line = ccb.content.text("I-I-What?  It's all I have, I can't give you more."),
    on_enter = {
        { once = "second_negotiations_solar_balthazar", actions = { actions.handler("dlg_a_dda_48f3c26bafa2") } },
    },
    replies = {
        {
            text = ccb.content.text("Surely you have something more exotic in there."),
            next_topic = "TALK_BALTHAZAR_MEET_REWARD_NEGOTIATE_WEAK_3",
        },
        {
            text = ccb.content.text("So you also don't have anything else in the \"control center\"?"),
            next_topic = "TALK_BALTHAZAR_MEET_REWARD_NEGOTIATE_WEAK_CAUGHT",
            when = predicates.handler("dlg_p_dda_afc82d95f444"),
        },
        {
            text = ccb.content.text("Fine."),
            next_topic = "TALK_BALTHAZAR_MEET_DESCRIPTION_WEAK",
        },
        {
            text = ccb.content.text("No deal."),
            next_topic = "TALK_DONE",
        },
    },
}
