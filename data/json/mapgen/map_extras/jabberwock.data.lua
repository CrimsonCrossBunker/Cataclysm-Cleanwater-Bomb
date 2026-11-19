local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_jabberwock",
    layout = {
        monster_placements = { { id = "mon_jabberwock", x = { 0, 23 }, y = { 0, 23 }, chance = 100 } },
    },
}
