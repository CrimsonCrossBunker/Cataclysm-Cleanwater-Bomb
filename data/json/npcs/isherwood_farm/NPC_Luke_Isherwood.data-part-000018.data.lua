local ccb = require("ccb")

-- Dialogue for this mission is handled externally.
ccb.content.define_mission {
    id = "MISSION_LUKE_RETRIEVE_TRUCK",
    name = ccb.content.text("Retrieve the Truck for Luke Isherwood"),
    description = ccb.content.text("Kill the two bandits for Luke Isherwood to get their truck."),
    goal = "MGOAL_ASSASSINATE",
    difficulty = 5,
    value = 0,
    start = {
        target = { terrain = "trailhead_shack_z0", special = "trailhead_shack", reveal_radius = 1 },
        map_updates = {
            {
                layout = {
                    npc_placements = {
                        { id = "bandit", x = 5, y = 8, target = true },
                        { id = "bandit", x = 5, y = 9, target = true },
                    },
                    vehicle_placements = {
                        {
                            id = "pickup",
                            chance = 100,
                            fuel = 100,
                            rotation = 0,
                            faction = "hells_raiders",
                            x = { 5 },
                            y = { 8 },
                        },
                    },
                },
            },
        },
    },
    finish = { actions = { { handler = "start_isherwood_truck" } } },
    origins = { "ORIGIN_SECONDARY" },
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
