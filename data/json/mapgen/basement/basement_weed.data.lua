local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "cannabis_extraction_equipment_nested_1x1",
    layout = {
        size = { width = 1, height = 1 },
        rotation = { 0, 3 },
        item_group_placements = {
            {
                group = {
                    entries = { { group = "cannabis_extraction_equipment", probability = 100 } },
                    kind = "distribution",
                },
                x = 0,
                y = 0,
                chance = 10,
            },
        },
    },
}
