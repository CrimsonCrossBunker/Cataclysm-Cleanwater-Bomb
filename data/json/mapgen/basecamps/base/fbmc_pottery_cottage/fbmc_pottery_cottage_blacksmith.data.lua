local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_pottery_cottage_blacksmith_construction",
    layout = {
        nested = { { id = "fbmc_pottery_cottage_blacksmith_construction_nested", x = 8, y = 16 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_pottery_cottage_blacksmith_1",
    layout = {
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_forge_rock", x = 9, y = 20, z = 0 },
            { shape = "point", operation = "furniture", id = "f_chimney", x = 9, y = 20, z = 1 },
            { shape = "point", operation = "furniture", id = "f_workbench", x = 9, y = 18, z = 0 },
            { shape = "point", operation = "furniture", id = "f_workbench", x = 9, y = 19, z = 0 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_pottery_cottage_blacksmith_2",
    layout = {
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_drophammer", x = 12, y = 17 },
            { shape = "point", operation = "furniture", id = "f_workbench", x = 12, y = 18 },
            { shape = "point", operation = "furniture", id = "f_workbench", x = 12, y = 19 },
        },
    },
}
