local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_4_accepted",
    line = ccb.content.text("Aye, alright.  Good.  I'll give ye a chitchat - a talk-rad talk-vid.  Take it t'them, make the introductions, and mayhaps lend a mite o' translating, now ye've hopefully started kennin' ol' Rubik's yark."),
    replies = {
        {
            text = ccb.content.text("[Take the device] Will do, Rubik."),
            next_topic = "TALK_EXODII_MERCHANT_mission_4_accepted_0-2",
            when = predicates.handler("dlg_p_dda_44a013be011b"),
            actions = { actions.handler("dlg_a_dda_c5a3adb40afa") },
        },
        {
            text = ccb.content.text("[Take the device] Will do, Rubik."),
            next_topic = "TALK_EXODII_MERCHANT_mission_4_accepted_3-4",
            when = predicates.handler("dlg_p_dda_2279cdadb63f"),
            actions = { actions.handler("dlg_a_dda_c5a3adb40afa") },
        },
        {
            text = ccb.content.text("[Take the device] Will do, Rubik."),
            next_topic = "TALK_EXODII_MERCHANT_mission_4_accepted_5-6",
            when = predicates.handler("dlg_p_dda_aef2ed885b5d"),
            actions = { actions.handler("dlg_a_dda_c5a3adb40afa") },
        },
        {
            text = ccb.content.text("[Take the device] Will do, Rubik."),
            next_topic = "TALK_EXODII_MERCHANT_mission_4_accepted_7-8",
            when = predicates.handler("dlg_p_dda_2e007446fed9"),
            actions = { actions.handler("dlg_a_dda_c5a3adb40afa") },
        },
        {
            text = ccb.content.text("[Take the device] Will do, Rubik."),
            next_topic = "TALK_EXODII_MERCHANT_mission_4_accepted_9-10",
            when = predicates.handler("dlg_p_dda_4863760f1f04"),
            actions = { actions.handler("dlg_a_dda_c5a3adb40afa") },
        },
    },
}
