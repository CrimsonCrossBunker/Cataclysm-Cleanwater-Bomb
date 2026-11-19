local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_lab_concourse_area_spawn",
    layout = {
        loot_placements = { { group = "lanyard_YS_badge", x = 4, y = { 5, 18 }, chance = 100 } },
    },
}
