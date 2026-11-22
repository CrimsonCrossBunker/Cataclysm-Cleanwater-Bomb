local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_COMPLETE",
    line = {
        when = predicates.handler("dlg_p_dda_ac36be63f1e3"),
        yes = ccb.content.text("&The intercom's tray slides open, filled with your payment.  \"Excellent.  In addition to your contracting fee you may keep the HOUND.  We would appreciate periodic reports on its field performance.\"\n\nYou hear a THUNK as something covers the microphone, and through scratches and muffled words, you heard \"Permission--tell-----okay.\"\n\nYou then hear the intercom click off, there is a moment of silence, and it clicks on again.  \"Ahem, so, as discussed earlier, we think this unit will lead to some important developments that will need field testing.  If things go as planned we will happily offer you a place in our field testing program.  Please occasionally check with us about project status.\""),
        no = ccb.content.text("&The intercom's tray slides open, filled with your payment.  \"Excellent.  In addition to your contracting fee you may keep the HOUND.  We would appreciate periodic reports on its field performance.\""),
    },
    replies = {
        {
            text = ccb.content.text("Thank you."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_COMPLETE_ALT",
    line = {
        when = predicates.handler("dlg_p_dda_ac36be63f1e3"),
        yes = ccb.content.text("&The intercom is silent a long moment, and then you hear a keyboard clacking and the tray slides open, filled with your payment.  \"Yes, this will do.  In addition to your contracting fee you may of course keep the HOUND.  We would appreciate periodic reports on its field performance.\"\n\nYou hear a THUNK as something covers the microphone, and through scratches and muffled words, you heard \"Permission--tell-----okay.\"\n\nYou then hear the intercom click off, there is a moment of silence, and it clicks on again.  \"Ahem, so, as discussed earlier, we think this unit will lead to some important developments that will need field testing.  If things go as planned we will happily offer you a place in our field testing program.  Please occasionally check with us about project status.\""),
        no = ccb.content.text("&The intercom is silent a long moment, and then you hear a keyboard clacking and the tray slides open, filled with your payment.  \"Yes, this will do.  In addition to your contracting fee you may of course keep the HOUND.  We would appreciate periodic reports on its field performance.\""),
    },
    replies = {
        {
            text = ccb.content.text("Thank you."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1",
    name = ccb.content.text("Data Retrieval"),
    description = ccb.content.text("Reach the LIXA facility, and search the area for anything of interest.  The intercom warned you about a number of undead aboveground, and the high probability of more underground."),
    goal = "MGOAL_NULL",
    difficulty = 5,
    value = 0,
    start = {
        target = { terrain = "LIXA_road_guard", special = "physics_lab_LIXA", reveal_radius = 1, z = 0 },
    },
    finish = {
        item_rewards = { { item = "RobofacCoin", count = 5 } },
        handler = {
            "mark_dialogue_intercom_completed_robofac_intercom_lixa_sm_1",
            "advance_hub01_completed_missions_by_1",
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("…"),
        accepted = ccb.content.text("…"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("…"),
        inquire = ccb.content.text("…"),
        success = ccb.content.text("…"),
        success_lie = ccb.content.text("…"),
        failure = ccb.content.text("…"),
    },
}
