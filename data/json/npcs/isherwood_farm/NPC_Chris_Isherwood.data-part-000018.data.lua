local ccb = require("ccb")

-- Dialogue for this mission is handled externally.
ccb.content.define_mission {
    id = "MISSION_ISHERWOOD_CHRIS_1_GET_WALL_BAGS",
    name = ccb.content.text("Retrieve Canvas Bags for Chris"),
    goal = "MGOAL_NULL",
    difficulty = 1,
    value = 0,
    finish = { actions = { { handler = "start_isherwood_wall" } } },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("."),
        offer = ccb.content.text("."),
        accepted = ccb.content.text("."),
        rejected = ccb.content.text("."),
        advice = ccb.content.text("."),
        inquire = ccb.content.text("."),
        success = ccb.content.text("."),
        success_lie = ccb.content.text("."),
        failure = ccb.content.text("."),
    },
}
