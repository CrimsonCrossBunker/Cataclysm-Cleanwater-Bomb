local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_beds_SE",
    layout = {
        nested = { { id = "fbmc_shelter_bed_east_wall", x = 16, y = 20 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_beds_E",
    layout = {
        nested = { { id = "fbmc_shelter_bed_east_wall", x = 16, y = 16 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_beds_SW",
    layout = {
        nested = { { id = "fbmc_shelter_bed_west_wall", x = 5, y = 17 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_beds_W",
    layout = {
        nested = { { id = "fbmc_shelter_bed_west_wall", x = 5, y = 13 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_beds_NW",
    layout = {
        nested = { { id = "fbmc_shelter_bed_west_wall", x = 5, y = 9 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_shelter_dining_room",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            " hth",
            " hth",
            " hth",
            " hth",
        },
        palettes = { "fbmc_shelter_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_dining",
    layout = {
        nested = { { id = "fbmc_shelter_dining_room", x = 10, y = 10 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_shelter_living_room",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "tsss",
            "    ",
            "    ",
            " CtC",
        },
        palettes = { "fbmc_shelter_palette" },
    },
}
