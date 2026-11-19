local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "seedling_corn",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "#",
        },
        sealed_item_glyphs = { ["#"] = { item = { id = "seed_corn" }, furniture = "f_plant_seedling", chance = 70 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "seedling_wheat",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "#",
        },
        sealed_item_glyphs = { ["#"] = { item = { id = "seed_wheat" }, furniture = "f_plant_seedling", chance = 70 } },
    },
}
