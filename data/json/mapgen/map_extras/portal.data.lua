local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_portal",
    layout = {
        nested = { { id = "portal_location", x = { 2, 20 }, y = { 2, 20 } } },
        monster_group_glyphs = { [" "] = { group = "GROUP_NETHER_PORTAL", chance = 1, density = 0.0001 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "portal_location",
    layout = {
        size = { width = 3, height = 3 },
        terrain = { [" "] = "t_region_groundcover" },
        furniture = { [" "] = "f_rubble_rock" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        trap_placements = { { id = "tr_portal", x = 1, y = 1 } },
    },
}
