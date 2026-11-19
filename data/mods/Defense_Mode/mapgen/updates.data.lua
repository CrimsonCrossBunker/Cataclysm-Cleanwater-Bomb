local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "shaun_of_the_dead_spawns",
    layout = {
        npc_placements = {
            { id = "follower_liz", x = 0, y = 0 },
            { id = "follower_david", x = 1, y = 0 },
            { id = "follower_dianne", x = 2, y = 0 },
            { id = "follower_ed", x = 1, y = 0 },
            { id = "follower_barbara", x = 1, y = 0 },
        },
    },
}
