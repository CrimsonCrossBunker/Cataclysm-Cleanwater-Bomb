local ccb = require("ccb")

-- Dialogue is handled externally.
ccb.content.define_mission {
    id = "MISSION_ISHERWOOD_BARRY_RETURN_TO_FARM",
    name = ccb.content.text("Return Barry to Isherwood's farm."),
    goal = "MGOAL_GO_TO",
    difficulty = 3,
    value = 20000,
    destination = "dairy_farm_isherwood_W",
    start = {
        target = { terrain = "dairy_farm_isherwood_W", special = "Isherwood Farm Mutable", reveal_radius = 3 },
    },
    finish = {
        handler = { "set_world_isherwood_barry_rescued_to_1", "mark_u_saved_barry_isherwood" },
        native_actions = { "stop_following" },
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("."),
        offer = ccb.content.text("."),
        accepted = ccb.content.text("."),
        rejected = "",
        advice = ccb.content.text("."),
        inquire = ccb.content.text("."),
        success = ccb.content.text("."),
        success_lie = ccb.content.text("."),
        failure = ccb.content.text("."),
    },
}
