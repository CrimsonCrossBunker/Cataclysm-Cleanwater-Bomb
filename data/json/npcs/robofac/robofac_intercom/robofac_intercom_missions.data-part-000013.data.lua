local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_ROBOFAC_INTERCOM_3",
    name = ccb.content.text("Light retrieval"),
    description = ccb.content.text("Reach the collapsed tower basement, and search the ruins for a photonic circuitry template.  The intercom warned you about heavy enemy presence, and of the existence of a hazardous environment.  They aren't sure if the safety gear they gave you is enough."),
    goal = "MGOAL_NULL",
    difficulty = 5,
    value = 0,
    start = {
        target = {
            terrain = "office_tower_collapse_b_a0",
            special = "office_tower_collapsed",
            reveal_radius = 1,
            random = true,
            search_range = 180,
            z = -1,
        },
        map_updates = { { layout = { nested = { { x = 10, y = 22, id = "robofac_mi3_photonics_chunk" } } } } },
    },
    finish = {
        item_rewards = { { item = "RobofacCoin", count = 8 } },
        handler = {
            "mark_dialogue_intercom_completed_robofac_intercom_3",
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
