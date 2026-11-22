local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_MEET_ROBOT_WEAK",
    line = ccb.content.text("This bunker has a control center for the local bots so I made them only attack when attacked first."),
    on_enter = {
        { once = "knows_control_center", actions = { actions.handler("dlg_a_dda_219009214fa4") } },
    },
    replies = {
        {
            text = ccb.content.text("Sounds useful."),
            next_topic = "TALK_BALTHAZAR_MEET_DESCRIPTION_WEAK",
        },
        {
            text = ccb.content.text("So you do have some tech you can give me."),
            next_topic = "TALK_BALTHAZAR_MEET_REWARD_NEGOTIATE_WEAK_CAUGHT",
            when = predicates.handler("dlg_p_dda_a29af93c992a"),
        },
        {
            text = ccb.content.text("Walk away."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_MEET_REWARD_NEGOTIATE_WEAK_CAUGHT",
    line = ccb.content.text("Wh- Alright, you got me, I can offer you a bot from the control center as well, but that is truly all I have."),
    on_enter = {
        { once = "third_negotiations_solar_balthazar", actions = { actions.handler("dlg_a_dda_cfe8d38967d1") } },
    },
    replies = {
        {
            text = ccb.content.text("I knew you had more."),
            next_topic = "TALK_BALTHAZAR_MEET_DESCRIPTION_WEAK",
        },
        {
            text = ccb.content.text("Surely you have some more in there."),
            next_topic = "TALK_BALTHAZAR_MEET_REWARD_NEGOTIATE_WEAK_3",
        },
        {
            text = ccb.content.text("Walk away."),
            next_topic = "TALK_DONE",
        },
    },
}
