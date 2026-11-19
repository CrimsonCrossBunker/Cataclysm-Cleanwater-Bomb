local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_mansion_+1_prefarm",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "dddd    dddd",
            "d          d",
            "d          d",
            "d          d",
            "            ",
            "            ",
            "            ",
            "            ",
            "d          d",
            "d          d",
            "d          d",
            "dddd    dddd",
        },
        terrain = { d = "t_dirt" },
        furniture = { d = "f_clear" },
        flags = { "ALLOW_TERRAIN_UNDER_FURNITURE" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_mansion_+1_farm",
    layout = {
        nested = {
            { id = "fbmc_mansion_+1_prefarm", x = 6, y = 6 },
            { id = "fbmc_mansion_farm_field", x = 6, y = 5 },
            { id = "fbmc_mansion_farm_field", x = 13, y = 5 },
            { id = "fbmc_mansion_farm_field", x = 1, y = 17 },
            { id = "fbmc_mansion_farm_field", x = 6, y = 17 },
            { id = "fbmc_mansion_farm_field", x = 1, y = 20 },
            { id = "fbmc_mansion_farm_field", x = 6, y = 20 },
            { id = "fbmc_mansion_farm_field", x = 13, y = 17 },
            { id = "fbmc_mansion_farm_field", x = 18, y = 17 },
            { id = "fbmc_mansion_farm_field", x = 13, y = 20 },
            { id = "fbmc_mansion_farm_field", x = 18, y = 20 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_mansion_+1",
    layout = {
        tile_edits = { { shape = "point", operation = "furniture", id = "f_bulletin", x = 9, y = 9 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_mansion_+1_radio",
    layout = {
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_radio_tower", x = 8, y = 9 },
            { shape = "point", operation = "terrain", id = "t_radio_controls", x = 8, y = 10 },
        },
    },
}
