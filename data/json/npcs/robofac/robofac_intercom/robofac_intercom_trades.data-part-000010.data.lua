local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_STORM",
    line = {
        when = predicates.handler("dlg_p_dda_f5179cb22d81"),
        yes = ccb.content.text("Research has requested we no longer pay for portal storm recordings.  You have done enough."),
        no = {
            when = predicates.any_equal({ "yes", { scope = "global", key = "hub01_intercom_accepted_HEW_recording" } }),
            yes = ccb.content.text("&\"Thank you.\"  The recording changes hands."),
            no = {
                when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_intercom_accepted_HEW_recording" } }),
                yes = ccb.content.text("&\"Thank you.\"  The recording changes hands."),
                no = ccb.content.text("Excellent.  Here's your agreed-upon reward.\"  The tray slides shut, and quickly reopens with your payment."),
            },
        },
    },
    on_enter = {
        { actions = { actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_HEW_recording", "yes"), actions.set_string({ scope = "global", key = "hub01_intercom_accepted_HEW_recording" }, { "yes" }), actions.finish_mission("MISSION_ROBOFAC_INTERCOM_MWS_4", { success = true }) } },
    },
}
