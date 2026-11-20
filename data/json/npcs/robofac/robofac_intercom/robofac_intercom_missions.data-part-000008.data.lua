local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_ROBOFAC_INTERCOM_2",
    name = ccb.content.text("Return to sender"),
    description = ccb.content.text("Find the corpse of a Hub 01's AI researcher and retrieve the hard case they brought with them during the evacuation."),
    goal = "MGOAL_NULL",
    difficulty = 5,
    value = 0,
    start = {
        target = { terrain = "road_ew", match = "EXACT", reveal_radius = 2, random = true, search_range = 80 },
        map_updates = {
            { layout = { nested = { { x = 0, y = 0, id = "robofac_mi2_convoy_ambush_chunk" } } } },
        },
        handler = "mark_global_portal_storms_u_heard_of_portal_storms",
    },
    finish = {
        map_updates = {
            {
                terrain = "robofachq_surface_entrance",
                layout = { nested = { { x = 6, y = 7, id = "robofac_hq_surface_merc_1" } } },
            },
        },
        item_rewards = { { item = "RobofacCoin", count = 4 } },
        handler = {
            "mark_dialogue_intercom_completed_robofac_intercom_2",
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
