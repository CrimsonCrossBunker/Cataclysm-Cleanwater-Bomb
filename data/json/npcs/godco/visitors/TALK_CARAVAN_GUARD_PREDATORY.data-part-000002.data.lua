local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_TIME",
    line = ccb.content.text("Just two more days is all I need with them, then the boss can do whatever.  Is that good?"),
    replies = {
        {
            text = ccb.content.text("Alright, I'll be back then."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_5dbea276c605"), actions.set_actor_value("interlocutor", "general_trade_u_talked_about_records", "yes") },
        },
        {
            text = ccb.content.text("No, I need them now."),
            next_topic = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_NOW",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_INTIMSUCCESS",
    line = ccb.content.text("I don't know what the hell you want them for, but I sure don't care.  Take 'em, <name_b>."),
    on_enter = {
        { actions = { actions.set_first_topic("TALK_DONE") } },
    },
    replies = {
        {
            text = ccb.content.text("Thanks, <name_b>."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_120c74150ad9"), actions.set_actor_value("interlocutor", "general_trade_u_talked_about_records", "yes") },
        },
    },
}
