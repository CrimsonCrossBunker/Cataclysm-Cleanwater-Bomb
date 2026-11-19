local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "field_graboid",
    layout = {
        predecessor_mapgen = "field",
        monster_placements = { { id = "mon_graboid", name = ccb.content.text("Little Guy"), x = 12, y = 12 } },
    },
}
