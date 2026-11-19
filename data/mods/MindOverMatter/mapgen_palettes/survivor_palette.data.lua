local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "house_survivor_palette",
    layout = {
        item_groups = {
            ["6"] = {
                { group = "matrix_shard_group", chance = 5, repetitions = { 1, 2 } },
                { group = "collection_matrix_dust", chance = 2, repetitions = { 1, 2 } },
                { group = "dist_matrix_crystals_rare", chance = 5 },
            },
            F = { { group = "concentrated_matrix_elixirs", chance = 4, repetitions = { 1, 2 } } },
            f = { { group = "survivor_matrix_crystal_recipes", chance = 5 } },
            m = { { group = "concentrated_matrix_elixirs", chance = 3 } },
        },
    },
    extend = true,
}
