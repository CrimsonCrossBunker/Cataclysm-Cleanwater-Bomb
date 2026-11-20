local ccb = require("ccb")

-- This mission is completed when you first sell any piece of portal storm data.
ccb.content.define_mission {
    id = "MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1",
    name = ccb.content.text("Hazard Meteorology"),
    goal = "MGOAL_NULL",
    description = ccb.content.text("Use the NRE recorder to collect information during a portal storm event.  You'll need to <color_yellow>stay outside and carry the recorder for around 6 minutes until you hear a sharp beep</color> to collect sufficient data.  Generate a printout by activating the NRE recorder and offer it to Hub 01 to finish the mission."),
    difficulty = 5,
    value = 0,
    finish = {
        map_updates = {
            {
                terrain = "robofachq_surface_entrance",
                layout = { nested = { { x = 1, y = 9, id = "robofac_hq_surface_merc_2" } } },
            },
        },
        handler = {
            "mark_dialogue_intercom_completed_robofac_intercom_portal_sm_1",
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
