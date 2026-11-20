local ccb = require("ccb")

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
