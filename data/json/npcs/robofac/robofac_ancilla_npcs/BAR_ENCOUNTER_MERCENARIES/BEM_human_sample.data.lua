local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "EOC_BEM_HUMAN_SAMPLE_BUY_MAP",
    layout = {
        loot_placements = { { group = "BEM_human_sample_drop", x = 13, y = 4, repetitions = { 1, 3 } } },
    },
}
