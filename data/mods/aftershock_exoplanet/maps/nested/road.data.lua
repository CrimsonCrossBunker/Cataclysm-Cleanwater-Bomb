local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_wraitheon_droneswarm",
    layout = {
        monster_placements = {
            { id = "mon_wraitheon_isohypsa", x = 12, y = 12, patrol = { { x = 12, y = 12 } } },
            {
                id = "mon_wraitheon_irradiant",
                x = 8,
                y = 8,
                patrol = { { x = 8, y = 8 }, { x = 8, y = 16 }, { x = 16, y = 16 }, { x = 16, y = 8 } },
            },
            { id = "mon_wraitheon_kaburaya", x = 4, y = 4, repetitions = { 6, 10 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_reaver_bandits",
    layout = {
        monster_placements = {
            { id = "afs_mon_reaver_rifle", x = 12, y = 12, patrol = { { x = 12, y = 12 } } },
            {
                id = "afs_mon_reaver_rifle",
                x = 8,
                y = 8,
                patrol = { { x = 8, y = 8 }, { x = 8, y = 16 }, { x = 16, y = 16 }, { x = 16, y = 8 } },
            },
            { id = "afs_mon_reaver", x = 4, y = 4, repetitions = { 1, 6 } },
        },
    },
}
