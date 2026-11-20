local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_ROBOFAC_PAT_CIRCUIT_SAFARI_RECON",
    name = ccb.content.text("Circuit Safari: Pat's Recon"),
    description = ccb.content.text("Pat talked to a guy who heard about a guy who saw an Exodii that looked like his friend.  If you're lucky, it'll be a worker you can kill and bring back to Hub 01."),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 5,
    value = 0,
    start = {
        target = { terrain = "road_ew", match = "EXACT", reveal_radius = 2, random = true, search_range = 80 },
        map_updates = { { layout = { nested = { { x = 0, y = 0, id = "mx_exodii_crash_big_1_pat" } } } } },
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
