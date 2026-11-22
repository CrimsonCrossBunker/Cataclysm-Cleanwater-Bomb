local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_BUY_LOCAL_MAP",
    line = ccb.content.text("To assist your operations, we are willing to sell you a map of the local area, as surveyed by our cam-spy drones.  Its standing price is 1 HGC."),
    replies = {
        {
            text = ccb.content.text("[1 HGC] Deal!"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.has_inventory("speaker", "RobofacCoin", 1),
            actions = { actions.handler("dlg_a_dda_77e2cf4040b1"), actions.set_actor_value("interlocutor", "dialogue_intercom_sold_local_map", "yes"), actions.set_string({ scope = "global", key = "hub01_intercom_sold_local_map" }, { "yes" }) },
        },
        {
            text = ccb.content.text("I'll have to give it some thought."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_ROBOFAC_INTERCOM_SELL_PORTAL_STORM_DATA", "TALK_ROBOFAC_INTERCOM_SELL_PORTAL_STORM_DATA_Small", "TALK_ROBOFAC_INTERCOM_SELL_PORTAL_STORM_DATA_Medium", "TALK_ROBOFAC_INTERCOM_SELL_PORTAL_STORM_DATA_Large" },
    line = ccb.content.text("Excellent; please deposit the printouts in the intercom's tray.  We'll issue a reward based on the quality of your recordings."),
    replies = {
        {
            text = ccb.content.text("[Deposit a NRE anomaly printout.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_PORTAL_STORM_DATA_Large",
            when = predicates.has_inventory("speaker", "nre_anomaly_printout_data", 1),
            actions = { actions.handler("dlg_a_dda_0b73973a513f") },
        },
        {
            text = ccb.content.text("[Deposit a long NRE printout.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_PORTAL_STORM_DATA_Large",
            when = predicates.has_inventory("speaker", "large_printout_portal_storm_data", 1),
            actions = { actions.handler("dlg_a_dda_c424948a0318") },
        },
        {
            text = ccb.content.text("[Deposit an NRE printout.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_PORTAL_STORM_DATA_Medium",
            when = predicates.handler("dlg_p_dda_516caf4fa5ec"),
            actions = { actions.handler("dlg_a_dda_6c27eeafdb86") },
        },
        {
            text = ccb.content.text("[Deposit a short NRE printout.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_PORTAL_STORM_DATA_Small",
            when = predicates.handler("dlg_p_dda_2ac1991513ff"),
            actions = { actions.handler("dlg_a_dda_9ce16051e93c") },
        },
        {
            text = ccb.content.text("That would be all."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_PORTAL_STORM_DATA_Small",
    line = {
        when = predicates.handler("dlg_p_dda_9ce50d3ad911"),
        yes = ccb.content.text("Extrapolating trends from these recordings has become difficult.  Research has requested we only accept higher quality data from now on."),
        no = {
            when = predicates.any_equal({ "yes", { scope = "global", key = "hub01_intercom_accepted_nre_recording" } }),
            yes = ccb.content.text("&\"Thank you.\"  The recording changes hands."),
            no = {
                when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_intercom_accepted_nre_recording" } }),
                yes = ccb.content.text("&\"Thank you.\"  The recording changes hands."),
                no = ccb.content.text("Excellent; this should be enough to work with.  Here's your agreed-upon reward.\"  The tray slides shut, and quickly reopens with your payment.  \"Given your performance and our constant need for new data, you are free to keep the recorder for further use.  We are willing to pay for any future data that you're able to record."),
            },
        },
    },
    on_enter = {
        { once = "nre_trade", actions = { actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_nre_recording", "yes"), actions.set_string({ scope = "global", key = "hub01_intercom_accepted_nre_recording" }, { "yes" }), actions.finish_mission("MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1", { success = true }) } },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_PORTAL_STORM_DATA_Medium",
    line = {
        when = predicates.handler("dlg_p_dda_1bc8ba6fed47"),
        yes = ccb.content.text("Extrapolating trends from these recordings has become difficult.  Research has requested we only accept higher quality data from now on."),
        no = {
            when = predicates.any_equal({ "yes", { scope = "global", key = "hub01_intercom_accepted_nre_recording" } }),
            yes = ccb.content.text("&\"Excellent.\"  The recording changes hands."),
            no = {
                when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_intercom_accepted_nre_recording" } }),
                yes = ccb.content.text("&\"Excellent.\"  The recording changes hands."),
                no = ccb.content.text("Great!  This looks like a very high-quality recording.  Because this data is much better, we are willing to pay five times what we paid for the base data collected.\"  The tray slides shut, and quickly reopens with your payment.  \"Given your performance and our constant need for new data, you are free to keep the recorder for further use.  We are willing to pay for any future data that you're able to record."),
            },
        },
    },
    on_enter = {
        { once = "nre_trade", actions = { actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_nre_recording", "yes"), actions.set_string({ scope = "global", key = "hub01_intercom_accepted_nre_recording" }, { "yes" }), actions.finish_mission("MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1", { success = true }) } },
    },
}
