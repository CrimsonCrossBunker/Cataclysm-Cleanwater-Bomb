local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_HELICOPTER_PILOT",
    name = ccb.content.text("Go to the refueling stop"),
    description = ccb.content.text("Your bird is now on the ground, never again able to fly, you could search for a new one in the closest refueling stop requisitioned by the military."),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 3,
    start = {
        target = {
            terrain = "s_air_helicopter_pad",
            special = "o_airport",
            reveal_radius = 6,
            min_distance = 15,
            z = 0,
        },
        map_updates = {
            {
                layout = {
                    monster_placements = {
                        { id = "mon_zombie_military_pilot", x = 1, y = 1 },
                        { id = "mon_feral_soldier", x = 3, y = 3 },
                        { id = "mon_zombie_soldier", x = 7, y = 3 },
                        { id = "mon_zombie_soldier", x = 8, y = 2 },
                        { id = "mon_zombie_soldier", x = 7, y = 6 },
                    },
                },
            },
        },
    },
    origins = { "ORIGIN_GAME_START" },
    value = 0,
    finish = { handler = "morale_mission_helicopter_pilot" },
}
