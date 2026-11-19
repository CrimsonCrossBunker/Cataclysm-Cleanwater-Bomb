local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_shia",
    layout = {
        monster_placements = { { id = "mon_shia", x = { 0, 23 }, y = { 0, 23 }, chance = 100 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_jackson",
    layout = {
        monster_placements = { { id = "mon_zombie_jackson", x = { 0, 23 }, y = { 0, 23 }, chance = 100 } },
    },
}
