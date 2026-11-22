local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_GUARD_PREDATORY",
    line = ccb.content.text("*looks up at you in uninterested fashion.  \"What do you want?  I'm working.\""),
    replies = {
        {
            text = ccb.content.text("Oh, uh, sorry."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("I'm here to pick up a delivery."),
            next_topic = "TALK_CARAVAN_GUARD_PREDATORY_PICKUP",
            when = predicates.all({ predicates.has_mission("MISSION_INVESTIGATE_TRADER"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_trade_u_talked_about_records" } })) }),
        },
        {
            text = ccb.content.text("I'm back for the records, and I have the money."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_trade_u_owe_20" } }),
            actions = { actions.handler("w16b_a_dda_905330b7b16a") },
        },
        {
            text = ccb.content.text("I'm back for the records, and I have the money."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_trade_u_owe_50" } }),
            actions = { actions.handler("w16b_a_dda_fef3fda7ed0f") },
        },
        {
            text = ccb.content.text("I'm back for the records, and I have the money."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_trade_u_owe_150" } }),
            actions = { actions.handler("w16b_a_dda_dc7499dbfcd6") },
        },
        {
            text = ccb.content.text("I'm back for your records."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_1992fc90a741"),
            actions = { actions.handler("w16b_a_dda_6dc89c37aece"), actions.clear_actor_value("interlocutor", "timer_trade_fixing_records") },
        },
    },
}
