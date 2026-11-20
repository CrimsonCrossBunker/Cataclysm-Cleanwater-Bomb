local ccb = require("ccb")

-- Dialogue for this mission is handled externally.
ccb.content.define_mission {
    id = "MISSION_LUKE_RETRIEVE_TRUCK_EXPLOSIVES",
    name = ccb.content.text("Retrieve Some Dynamite for Luke"),
    description = ccb.content.text("Get 50 pounds of dynamite for Luke Isherwood to make a bomb.  There's a known shipment at a mine in the region."),
    goal = "MGOAL_NULL",
    difficulty = 5,
    value = 0,
    start = {
        target = { terrain = "mine_entrance_loading_zone", special = "Generic mine", reveal_radius = 1 },
        map_updates = {
            {
                layout = {
                    vehicle_placements = {
                        { id = "truck_trailer_explosives", chance = 100, rotation = 270, x = { 7 }, y = { 7 } },
                    },
                },
            },
        },
    },
    finish = { handler = "advance_world_isherwood_luke_truck_coming_by_1" },
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
