local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_portal",
    layout = {
        nested = { { id = "portal_location", x = { 2, 20 }, y = { 2, 20 } } },
        monster_group_glyphs = { [" "] = { group = "GROUP_NETHER_PORTAL", chance = 1, density = 0.0001 } },
    },
}
