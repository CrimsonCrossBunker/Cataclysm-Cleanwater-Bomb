local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_bugout",
    layout = {
        nested = {
            {
                choices = { { id = "nested_bugout_bag", weight = 100 } },
                x = { 0, 23 },
                y = { 0, 23 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "nested_bugout_bag",
    layout = {
        size = { width = 1, height = 1 },
        item_group_placements = {
            {
                group = { entries = { { group = "bugout_bag", probability = 100 } }, kind = "distribution" },
                x = 0,
                y = 0,
                chance = 100,
            },
        },
        monster_group_placements = { { group = "GROUP_ZOMBIE", x = 0, y = 0, chance = 100 } },
    },
}
