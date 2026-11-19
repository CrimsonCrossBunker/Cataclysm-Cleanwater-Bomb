local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_bandits_block_horizontal",
    layout = {
        size = { width = 24, height = 24 },
        nested = {
            {
                choices = {
                    "24x24_bandits_block_horizontal_felled_trees",
                    "24x24_bandits_block_horizontal_traps",
                },
                x = 0,
                y = { 3, 14 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_bandits_block_vertical",
    layout = {
        size = { width = 24, height = 24 },
        nested = {
            {
                choices = {
                    "24x24_bandits_block_vertical_felled_trees",
                    "24x24_bandits_block_vertical_traps",
                },
                x = { 3, 14 },
                y = 0,
            },
        },
    },
}
