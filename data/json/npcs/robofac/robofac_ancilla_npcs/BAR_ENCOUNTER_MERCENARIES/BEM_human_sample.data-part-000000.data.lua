local ccb = require("ccb")

-- This mission is assigned and completed using dialogue and EOCs. As such, we don't have any goal, which would make it auto-complete under certain circumstances.
-- All dialogue about this mission is handled through talk_topics, so we don't use any of these strings.
ccb.content.define_mission {
    id = "BEM_human_sample_mission",
    name = ccb.content.text("Fleshmonger"),
    goal = "MGOAL_NULL",
    description = ccb.content.text("Deposit a human sample in a pit within the dead drop location.  Pick up your reward at the Terminal once that's done."),
    difficulty = 1,
    value = 0,
    start = {
        target = { terrain = "forest", reveal_radius = 2, random = true, search_range = 40, z = 0 },
        map_updates = {
            {
                layout = {
                    flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
                    terrain_placements = { { id = "t_pit_BEM_human_sample", x = 9, y = 3 } },
                },
            },
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
