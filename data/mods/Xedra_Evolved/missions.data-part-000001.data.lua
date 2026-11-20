local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_SEVENOCLOCK",
    name = ccb.content.text("Find the source of the bloody footsteps."),
    goal = "MGOAL_GO_TO_TYPE",
    destination = "cabin_sevenoclock",
    difficulty = 1,
    value = 0,
    start = { target = { terrain = "cabin_sevenoclock", special = "old cabin" } },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = "",
        offer = "",
        accepted = "",
        rejected = "",
        advice = "",
        inquire = "",
        success = "",
        success_lie = "",
        failure = "",
    },
}

ccb.content.define_mission {
    id = "MISSION_DEATHWORM",
    name = ccb.content.text("Find the source of the acid-burned hole."),
    goal = "MGOAL_GO_TO_TYPE",
    destination = "field_deathworm",
    difficulty = 1,
    value = 0,
    start = { target = { terrain = "field_deathworm", special = "acid-scarred field" } },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = "",
        offer = "",
        accepted = "",
        rejected = "",
        advice = "",
        inquire = "",
        success = "",
        success_lie = "",
        failure = "",
    },
}
