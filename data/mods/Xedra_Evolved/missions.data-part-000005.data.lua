local ccb = require("ccb")

-- TODO: If we ever get narrower search ranges than 'circular' make this further away
ccb.content.define_mission {
    id = "MISSION_REVENANT_VENGEANCE",
    name = ccb.content.text("Vengeance Shall Be Mine"),
    description = ccb.content.text("Your murderer is out there, and you will find them."),
    goal = "MGOAL_ASSASSINATE",
    difficulty = 4,
    start = {
        target = {
            terrain = "bandit_camp",
            match = "CONTAINS",
            reveal_radius = 1,
            min_distance = 540,
            search_range = 1500,
            random = true,
        },
        map_updates = {
            {
                layout = {
                    npc_placements = {
                        { id = "bandit_revenant", x = { 7, 22 }, y = { 6, 19 }, target = true },
                    },
                },
            },
        },
    },
    origins = { "ORIGIN_GAME_START" },
    value = 0,
    finish = { handler = "complete_revenant_vengeance" },
}
