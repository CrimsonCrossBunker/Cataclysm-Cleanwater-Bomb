local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "survivor_corpse",
    layout = {
        size = { width = 1, height = 1 },
        item_group_placements = { { group = "corpses_unisex_survival", x = { 0 }, y = { 0 }, chance = 100 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "corpses_bones_only",
    layout = {
        size = { width = 1, height = 1 },
        item_group_placements = { { group = "corpses_bones_only", x = { 0 }, y = { 0 }, chance = 100 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "survivor_creature",
    layout = {
        size = { width = 1, height = 1 },
        monster_placements = { { group = "GROUP_SURVIVOR_FOREST", x = { 0 }, y = { 0 }, chance = 100 } },
    },
}
