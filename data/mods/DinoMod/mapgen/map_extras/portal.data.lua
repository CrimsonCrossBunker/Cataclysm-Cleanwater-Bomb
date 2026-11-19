local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_portal_dino_south_america",
    layout = {
        nested = { { id = "portal_location", x = { 2, 20 }, y = { 2, 20 } } },
        monster_group_glyphs = { [" "] = { group = "GROUP_DINOSAUR_SOUTH_AMERICA", chance = 1, density = 0.0001 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_portal_dino_asia",
    layout = {
        nested = { { id = "portal_location", x = { 2, 20 }, y = { 2, 20 } } },
        monster_group_glyphs = { [" "] = { group = "GROUP_DINOSAUR_ASIA", chance = 1, density = 0.0001 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_portal_dino_europe",
    layout = {
        nested = { { id = "portal_location", x = { 2, 20 }, y = { 2, 20 } } },
        monster_group_glyphs = { [" "] = { group = "GROUP_DINOSAUR_EUROPE", chance = 1, density = 0.0001 } },
    },
}
